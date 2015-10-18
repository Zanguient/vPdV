unit pdv_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvPadraoFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, ADODB, DB, DBClient, StdCtrls, cxButtons,
  ExtCtrls, cxControls, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Provider, cxImageComboBox, ImgList;

type
  TfrmPDVMain = class(TvPadraoFrame)
    scbPedidos: TScrollBox;
    dbgPedidos: TcxGrid;
    dtvPedidos: TcxGridDBTableView;
    gcpMesa: TcxGridDBColumn;
    gcpStatus: TcxGridDBColumn;
    gcpValor: TcxGridDBColumn;
    dbgPedidosLevel1: TcxGridLevel;
    panLeft: TPanel;
    scbOpcoes: TScrollBox;
    btnGaveta: TcxButton;
    btnDelivery: TcxButton;
    btnBalcao: TcxButton;
    cxButton1: TcxButton;
    sbxOpcoesPDV: TScrollBox;
    cdsMesa: TClientDataSet;
    dtsMesa: TDataSource;
    dspPadrao: TDataSetProvider;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    styGridPDV: TcxStyleRepository;
    styGridBackgroud: TcxStyle;
    styGridContent: TcxStyle;
    styGridHeader: TcxStyle;
    styGridSelection: TcxStyle;
    cilDetalhePDV: TcxImageList;
    adqAuxUpdMesa: TADOQuery;
    pumMesaL: TPopupMenu;
    pmiLiberar: TMenuItem;
    pumMesaO: TPopupMenu;
    pmiOcupada: TMenuItem;
    cdsMesaid_mesa: TAutoIncField;
    cdsMesanmmesa: TStringField;
    cdsMesadsobsmesa: TStringField;
    cdsMesastatus: TStringField;
    cdsMesavalor: TFloatField;
    procedure FrameResize(Sender: TObject);
    procedure btnGavetaClick(Sender: TObject);
    procedure dtvPedidosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnDeliveryClick(Sender: TObject);
    procedure btnBalcaoClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure gcpStatusGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure pmiLiberarClick(Sender: TObject);
    procedure pmiOcupadaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OnClickOpcoesPDV(Sender: TObject);
    procedure RefreshMesa;
  end;

var
  frmPDVMain: TfrmPDVMain;

implementation

{$R *.dfm}

uses
  lib_interface, lib_mensagem, pdv_pdv, pdv_adicional, uDmConexao, lib_vmsis,
  lib_acesso, main_base, pdv_abertura_fechamento_caixa, StrUtils;

procedure TfrmPDVMain.FrameResize(Sender: TObject);
var
  iComp: Integer;
begin
  RefreshMesa;

  for iComp := 0 to pred(scbOpcoes.ControlCount) do
  begin
    scbOpcoes.Controls[iComp].Width := Trunc(panLeft.Width/scbOpcoes.ControlCount);
    scbOpcoes.Controls[iComp].Left  := Trunc(panLeft.Width/scbOpcoes.ControlCount)*(iComp+1);
  end;
end;

procedure TfrmPDVMain.btnGavetaClick(Sender: TObject);
var
  Acesso_Perifericos: TAcesso_Perifericos;
  AcessoGaveta: TAcessoUsuario;
begin
  inherited;
  AcessoGaveta := TAcessoUsuario.create(frmMainBase.NomeUsuario);
  Acesso_Perifericos := TAcesso_Perifericos.Create;
  try
    if AcessoGaveta.Autenticado('gaveta', TpmProcessar) then
    begin
      Acesso_Perifericos.AbreGaveta;
    end;
  finally
    FreeAndNil(AcessoGaveta);
    FreeAndNil(Acesso_Perifericos);
  end;
end;

procedure TfrmPDVMain.dtvPedidosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $9400D3
  else
    ACanvas.Brush.Color := $FFFFFF;

  ACanvas.Font.Color := clBlack;
end;

procedure TfrmPDVMain.OnClickOpcoesPDV(Sender: TObject);
var
  P_Create: TParametros;
begin
  P_Create.Caption := 'Mesa ' + (Sender as TcxButton).Caption;
  P_Create.Tag     := (Sender as TcxButton).Tag;
  P_Create.Totalizador_Height := 45;
  P_Create.btnGravar_Visible  := True;
  P_Create.panDados_Visible   := False;

  FrmPDV_PDV := TfrmPDV_PDV.PCreate(Self,P_Create);
  try
    frmPDV_PDV.ShowModal;
  finally
    FreeAndNil(frmPDV_PDV);
    RefreshMesa;
  end;
end;

procedure TfrmPDVMain.btnDeliveryClick(Sender: TObject);
var
  P_Create: TParametros;
begin
  inherited;
  P_Create.Caption := 'Delivery';
  P_Create.Tag     := 99999;
  P_Create.Totalizador_Height := 88;
  P_Create.btnGravar_Visible  := False;
  P_Create.panDados_Visible   := True;

  FrmPDV_PDV := TfrmPDV_PDV.PCreate(Self,P_Create);
  try
    frmPDV_PDV.ShowModal;
  finally
    FreeAndNil(frmPDV_PDV);     
    RefreshMesa;
  end;
end;

procedure TfrmPDVMain.btnBalcaoClick(Sender: TObject);
var
  P_Create: TParametros;
begin
  inherited;                                       
  P_Create.Caption := 'Balcão';
  P_Create.Tag     := 88888;
  P_Create.Totalizador_Height := 88;
  P_Create.btnGravar_Visible  := False;
  P_Create.panDados_Visible   := True;

  FrmPDV_PDV := TfrmPDV_PDV.PCreate(Self,P_Create);
  try
    frmPDV_PDV.ShowModal;
  finally
    FreeAndNil(frmPDV_PDV);
    RefreshMesa;
  end;
end;

procedure TfrmPDVMain.cxButton1Click(Sender: TObject);
begin
  inherited;
  if CaixaFechado then
    CaixaPreAberto;
end;

procedure TfrmPDVMain.gcpStatusGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  inherited;
  case AnsiIndexStr(UpperCase(AText), ['L','O']) of
    0: Atext := 'Livre';
    1: Atext := 'Ocupada';
  else
    AText := 'Desconhecido';
  end;
end;

procedure TfrmPDVMain.RefreshMesa; 
var
  Interface_: TInterface;
  contador, retirados, inStatus: Integer;
  pum: TPopUpMenu;
begin
  adqPadrao.Close;
  adqPadrao.Open;

  cdsMesa.Data := dspPadrao.Data;
  retirados := 0;

  for contador := 0 to sbxOpcoesPDV.ControlCount - 1 do
  begin
    if sbxOpcoesPDV.Controls[contador - retirados].ClassName = 'TcxButton' then
    begin
       sbxOpcoesPDV.Controls[contador - retirados].Destroy;
       Inc(retirados);
    end;
  end;

  if sbxOpcoesPDV.ControlCount = 0 then
  begin
    cdsMesa.First;
    while not cdsMesa.Eof do
    begin
      if cdsMesastatus.AsString = 'L' then
      begin
        inStatus := 0;
        pum := pumMesaO;
      end else
      begin
        inStatus := 1;
        pum := pumMesaL;
      end;

      Interface_.CriaButtonScrollBox(sbxOpcoesPDV, cdsMesa.FieldByName('nmmesa').AsString, OnClickOpcoesPDV, 150, 150,
        cdsMesa.FieldByName('id_mesa').AsInteger, cilDetalhePDV, inStatus, pum);

      cdsMesa.Next;
    end;
  end;

  if sbxOpcoesPDV.ControlCount > 0 then
  begin
    Interface_ := TInterface.Create();
    Interface_.OrganizaScrollBox(sbxOpcoesPDV,1);
  end;
end;

procedure TfrmPDVMain.pmiLiberarClick(Sender: TObject);
begin
  inherited;
  if cdsMesavalor.AsFloat > 0 then
    Aviso(EXISTE_PEDIDO_MESA)
  else
  begin
    adqAuxUpdMesa.Close;
    adqAuxUpdMesa.Parameters.ParamByName('IDSTATUS').Value := 'L';
    adqAuxUpdMesa.Parameters.ParamByName('ID').Value := pumMesaL.PopupComponent.Tag;
    adqAuxUpdMesa.ExecSQL;
  end;

  RefreshMesa;
end;

procedure TfrmPDVMain.pmiOcupadaClick(Sender: TObject);
begin
  inherited;
  adqAuxUpdMesa.Close;
  adqAuxUpdMesa.Parameters.ParamByName('IDSTATUS').Value := 'O';
  adqAuxUpdMesa.Parameters.ParamByName('ID').Value := pumMesaO.PopupComponent.Tag;
  adqAuxUpdMesa.ExecSQL;
  
  RefreshMesa;
end;

end.

