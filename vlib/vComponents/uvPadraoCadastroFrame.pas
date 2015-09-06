unit uvPadraoCadastroFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxPC, cxStyles, cxEdit, cxCustomData, cxFilter, cxData, cxDataStorage,
  DB, cxDBData, dxSkinsdxNavBar2Painter, Menus, cxContainer, cxLabel,
  cxVGrid, cxDBVGrid, ActnList, ADODB, StdCtrls, cxButtons, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, cxNavigator, cxDBNavigator,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxInplaceContainer, ExtCtrls;

type
  TvPadraoCadastro = class(TFrame)
    pgcPadrao: TcxPageControl;
    tabVisao: TcxTabSheet;
    panClient: TPanel;
    cxgridFiltro: TcxVerticalGrid;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    panFiltro: TPanel;
    cxDBNavigator1: TcxDBNavigator;
    dxNavBar: TdxNavBar;
    nbPesquisa: TdxNavBarGroup;
    nbiFiltrar: TdxNavBarItem;
    nbLimpar: TdxNavBarItem;
    panTop: TPanel;
    lblNomeFrame: TLabel;
    btnFechar: TcxButton;
    cxNavPadrao: TcxDBNavigator;
    adqPadrao: TADOQuery;
    dtsPadrao: TDataSource;
    ActionList1: TActionList;
    actFilttar: TAction;
    actLimpar: TAction;
    tabCadastro: TcxTabSheet;
    Panel1: TPanel;
    cxvGrid1: TcxDBVerticalGrid;
    panGrid: TPanel;
    pnlNavigator: TPanel;
    cxNavDetail: TcxDBNavigator;
    lblGridCaption: TcxLabel;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    Panel2: TPanel;
    Label1: TLabel;
    cxButton1: TcxButton;
    cxNavCadastro: TcxDBNavigator;
    adqDetail: TADOQuery;
    dtsDetail: TDataSource;
    procedure cxNavPadraoButtonsButtonClick(Sender: TObject;
      AButtonIndex: Integer; var ADone: Boolean);
    procedure actFilttarExecute(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure actLimparExecute(Sender: TObject);
    procedure cxGrid1DBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxDBNavigator2ButtonsButtonClick(Sender: TObject;
      AButtonIndex: Integer; var ADone: Boolean);
    procedure adqDetailNewRecord(DataSet: TDataSet);
    procedure adqDetailBeforeOpen(DataSet: TDataSet);
    procedure dtsPadraoStateChange(Sender: TObject);
    procedure pgcPadraoChange(Sender: TObject);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
    stSql:String;
  protected
    stpk, stfk, stDescricao: String;
    procedure addFilter(filter: String); virtual;
    procedure DoFilterExecute(); virtual;
    procedure setCadastroCaption; virtual;
    procedure openDetail; virtual;
    procedure setCadastroAba();
    procedure setVisaoAba();    
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

procedure TvPadraoCadastro.cxNavPadraoButtonsButtonClick(Sender: TObject;
  AButtonIndex: Integer; var ADone: Boolean);
begin
  if AButtonIndex = NBDI_INSERT then
    setCadastroAba
  else
    inherited;
end;

procedure TvPadraoCadastro.actFilttarExecute(Sender: TObject);
begin
  adqPadrao.Close;
  adqPadrao.SQL.Text := stSql;
  DoFilterExecute;
  adqPadrao.Open;
end;

procedure TvPadraoCadastro.btnFecharClick(Sender: TObject);
begin
  Owner.Free;
end;

procedure TvPadraoCadastro.actLimparExecute(Sender: TObject);
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

procedure TvPadraoCadastro.addFilter(filter: String);
begin
  adqPadrao.SQL.Add('and ('+filter+')');
end;

constructor TvPadraoCadastro.Create(AOwner: TComponent);
begin
  inherited;
  stSql := adqPadrao.SQL.Text;
  stpk := adqPadrao.Fields[0].FieldName;
  stfk := adqDetail.Parameters.Items[0].Name;
  stDescricao := adqPadrao.Fields[1].FieldName;
  pgcPadrao.ActivePageIndex := 0;
  tabCadastro.TabVisible := False;
  tabVisao.Caption := lblNomeFrame.Caption;
  addFilter('1=2');
  adqPadrao.Active := True;
end;

procedure TvPadraoCadastro.DoFilterExecute;
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

procedure TvPadraoCadastro.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $E6D8AD
  else
    ACanvas.Brush.Color := $9AFA00;

  ACanvas.Font.Color := clBlack;
end;

procedure TvPadraoCadastro.cxDBNavigator2ButtonsButtonClick(
  Sender: TObject; AButtonIndex: Integer; var ADone: Boolean);
begin
  if (AButtonIndex = NBDI_CANCEL) and (adqPadrao.State = dsInsert) then
    setVisaoAba
  else
    inherited;
end;

procedure TvPadraoCadastro.adqDetailNewRecord(DataSet: TDataSet);
begin
   adqDetail.Fields.FieldByName(stfk).Value := adqPadrao.FieldValues[stpk];
end;

procedure TvPadraoCadastro.adqDetailBeforeOpen(DataSet: TDataSet);
begin
   adqDetail.Parameters.Items[0].Value := adqPadrao.FieldValues[stpk];
end;

procedure TvPadraoCadastro.dtsPadraoStateChange(Sender: TObject);
begin
  setCadastroCaption;
  if adqPadrao.State in [dsInsert, dsEdit] then
  begin
    cxNavCadastro.Buttons.Insert.Enabled := False;
    cxNavCadastro.Buttons.Delete.Enabled := False;
  end;
end;

procedure TvPadraoCadastro.setCadastroCaption;
begin
  if pgcPadrao.ActivePageIndex = 1 then
  begin
    if (adqPadrao.State = dsInsert) or (adqPadrao.RecordCount < 1) then
      tabCadastro.Caption := lblNomeFrame.Caption
    else
      tabCadastro.Caption := lblNomeFrame.Caption + adqPadrao.FieldValues[stDescricao];
  end;
end;

procedure TvPadraoCadastro.pgcPadraoChange(Sender: TObject);
begin
  setCadastroCaption;
  openDetail;
end;

procedure TvPadraoCadastro.openDetail;
begin
  if pgcPadrao.ActivePageIndex = 1 then
  begin
    adqDetail.Close;
    adqDetail.Open;
  end;
end;

procedure TvPadraoCadastro.setCadastroAba;
begin
  tabVisao.TabVisible := False;
  tabCadastro.TabVisible := True;
  pgcPadrao.ActivePage := tabCadastro;
end;

procedure TvPadraoCadastro.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
  if not adqPadrao.IsEmpty then
    setCadastroAba;
end;

procedure TvPadraoCadastro.setVisaoAba;
begin
  tabVisao.TabVisible := True;
  tabCadastro.TabVisible := False;
  pgcPadrao.ActivePage := tabVisao;
end;

procedure TvPadraoCadastro.cxButton1Click(Sender: TObject);
begin
  setVisaoAba;
end;

end.
