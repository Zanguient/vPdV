unit uvCadastroFrame;

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
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxContainer,
  cxEdit, cxStyles, cxImageComboBox, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, DB, cxDBData, dxSkinsdxNavBar2Painter,
  dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient, cxVGrid, cxDBVGrid,
  cxInplaceContainer, cxLabel, cxNavigator, cxDBNavigator, Provider, ADODB,
  ActnList;

type
  TvCadastroFrame = class(TvPadraoFrame)
    cxvGrid1: TcxDBVerticalGrid;
    dtsDetail: TDataSource;
    dxNavBar1: TdxNavBar;
    nbProcesso: TdxNavBarGroup;
    nbiInserir: TdxNavBarItem;
    nbiExcluir: TdxNavBarItem;
    panGrid: TPanel;
    pnlNavigator: TPanel;
    cxNavDetail: TcxDBNavigator;
    lblGridCaption: TcxLabel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    adqDetail: TADOQuery;
    cxNavPadrao: TcxDBNavigator;
    ActionList1: TActionList;
    actInserir: TAction;
    actExcluir: TAction;
    procedure adqDetailBeforeEdit(DataSet: TDataSet);
    procedure actInserirExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure dtsPadraoStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vCadastroFrame: TvCadastroFrame;

implementation

{$R *.dfm}

procedure TvCadastroFrame.adqDetailBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if dtsPadrao.DataSet.State in [dsInsert, dsEdit] then
    dtsPadrao.DataSet.Edit;
end;

procedure TvCadastroFrame.actInserirExecute(Sender: TObject);
begin
  inherited;
  dtsPadrao.DataSet.Append;
end;

procedure TvCadastroFrame.actExcluirExecute(Sender: TObject);
begin
  inherited;
  dtsPadrao.DataSet.Delete;
end;

procedure TvCadastroFrame.dtsPadraoStateChange(Sender: TObject);
begin
  inherited;
  actInserir.Visible := dtsPadrao.DataSet.State = dsBrowse;
  actExcluir.Visible := dtsPadrao.DataSet.State = dsBrowse;
end;

end.
