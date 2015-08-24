unit uvVisaoFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvPadraoFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, StdCtrls, cxButtons, ExtCtrls, cxControls,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxStyles,
  cxEdit, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, dxSkinsdxNavBar2Painter, cxNavigator,
  cxDBNavigator, dxNavBar, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxInplaceContainer, cxVGrid, dxNavBarCollns, dxNavBarBase, DBClient,
  Provider, ADODB, ActnList, lib_imagens;

type
  TvVisaoFrame = class(TvPadraoFrame)
    cxgridFiltro: TcxVerticalGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    panFiltro: TPanel;
    dxNavBar: TdxNavBar;
    cxDBNavigator1: TcxDBNavigator;
    nbiFiltrar: TdxNavBarItem;
    nbLimpar: TdxNavBarItem;
    nbPesquisa: TdxNavBarGroup;
    ActionList1: TActionList;
    actFilttar: TAction;
    actLimpar: TAction;
    cxNavPadrao: TcxDBNavigator;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure cxGrid1DBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxNavPadraoButtonsButtonClick(Sender: TObject;
      AButtonIndex: Integer; var ADone: Boolean);
    procedure actFilttarExecute(Sender: TObject);
    procedure actLimparExecute(Sender: TObject);
  private
    { Private declarations }
    stSql:String;
    frvCadastroFrame:TFrame;
    procedure setvCadastroFrame(frame: TFrame);
  protected
    procedure addFilter(filter: String);
    procedure DoFilterExecute(); virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property vCadastroFrame: TFrame write setvCadastroFrame;
  end;

var
  vVisaoFrame: TvVisaoFrame;

implementation

{$R *.dfm}

procedure TvVisaoFrame.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $E6D8AD
  else
    ACanvas.Brush.Color := $9AFA00;

  ACanvas.Font.Color := clBlack;
end;

procedure TvVisaoFrame.cxNavPadraoButtonsButtonClick(Sender: TObject; AButtonIndex: Integer; var ADone: Boolean);
begin
  if AButtonIndex = 6 then
  begin
    vVisaoFrame.Visible := False;
    frvCadastroFrame.Create(vVisaoFrame.Owner);
  end
  else
    inherited;
end;

procedure TvVisaoFrame.actFilttarExecute(Sender: TObject);
begin
  inherited;
  adqPadrao.Close;
  adqPadrao.SQL.Text := stSql;  
  DoFilterExecute;
  adqPadrao.Open;
end;

procedure TvVisaoFrame.DoFilterExecute;
var
  i: Integer;
  stfield: String;
begin
  for i := 0 to cxgridFiltro.Rows.Count - 1 do
  begin
    if not VarIsNull(TcxEditorRow(cxgridFiltro.Rows.Items[i]).Properties.Value) then
    begin
      if adqPadrao.FieldByName(cxgridFiltro.Rows.Items[i].Name).Origin = '' then
        stfield := adqPadrao.FieldByName(cxgridFiltro.Rows.Items[i].Name).FieldName
      else
        stfield := adqPadrao.FieldByName(cxgridFiltro.Rows.Items[i].Name).Origin;
      if (adqPadrao.FieldByName(cxgridFiltro.Rows.Items[i].Name).DataType = ftInteger) or
         (adqPadrao.FieldByName(cxgridFiltro.Rows.Items[i].Name).DataType = ftFloat) then
        addFilter(stfield +' = '+ TcxEditorRow(cxgridFiltro.Rows.Items[i]).Properties.Value)
//      else if (adqPadrao.FieldByName(cxgridFiltro.Rows.Items[i].Name).DataType = ftDate) or
//         (adqPadrao.FieldByName(cxgridFiltro.Rows.Items[i].Name).DataType = ftDateTime) then
//        addFilter(stfield +' = '+ StrToDateTime(TcxEditorRow(cxgridFiltro.Rows.Items[i]).Properties.Value))
      else
        addFilter(stfield +' like '''+ (TcxEditorRow(cxgridFiltro.Rows.Items[i]).Properties.Value)+'''');
    end;
  end;
end;

procedure TvVisaoFrame.addFilter(filter: String);
begin
  adqPadrao.SQL.Add('and ('+filter+')');
end;

procedure TvVisaoFrame.actLimparExecute(Sender: TObject);
var
  i: Integer;
begin
  adqPadrao.Close;
  adqPadrao.SQL.Text := stSql;
  for i := 0 to cxgridFiltro.Rows.Count - 1 do
  begin
    TcxEditorRow(cxgridFiltro.Rows.Items[i]).Properties.Value := Null;
  end;
end;

constructor TvVisaoFrame.Create(AOwner: TComponent);
begin
  inherited;
  stSql := adqPadrao.SQL.Text;
end;

procedure TvVisaoFrame.setvCadastroFrame(frame: TFrame);
begin
   frvCadastroFrame := frame;
end;

end.
