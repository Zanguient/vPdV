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
  Provider, cxImageComboBox, ImgList, cxCurrencyEdit, cxTextEdit;

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
    btnSangria: TcxButton;
    btnFecharCaixa: TcxButton;
    procedure btnGavetaClick(Sender: TObject);
    procedure btnDeliveryClick(Sender: TObject);
    procedure btnBalcaoClick(Sender: TObject);
    procedure btnFecharCaixaClick(Sender: TObject);
    procedure pmiLiberarClick(Sender: TObject);
    procedure pmiOcupadaClick(Sender: TObject);
    procedure sbxOpcoesPDVResize(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure btnSangriaClick(Sender: TObject);
    procedure cdsMesastatusGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
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
  lib_acesso, main_base, pdv_abertura_fechamento_caixa, StrUtils,
  pdv_sangria;

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

procedure TfrmPDVMain.OnClickOpcoesPDV(Sender: TObject);
var
  P_Create: TParametros;
begin
  P_Create.Caption := 'Mesa ' + (Sender as TcxButton).Caption;
  P_Create.Tag     := (Sender as TcxButton).Tag;
  P_Create.Totalizador_Height := 45;
  P_Create.btnGravar_Visible  := True;
  P_Create.panDados_Visible   := False;
  
  cdsMesa.Locate('ID_MESA', (Sender as TcxButton).Tag, [loCaseInsensitive]);

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

procedure TfrmPDVMain.btnFecharCaixaClick(Sender: TObject);
begin
  inherited;
  if CaixaFechado then
    CaixaPreAberto;
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
  
  Abort;
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

procedure TfrmPDVMain.sbxOpcoesPDVResize(Sender: TObject);
var
  iComp: Integer;
begin
  inherited;
  for iComp := 0 to pred(scbOpcoes.ControlCount) do
  begin
    scbOpcoes.Controls[iComp].Width := Trunc(panLeft.Width/scbOpcoes.ControlCount);
    scbOpcoes.Controls[iComp].Left  := Trunc(panLeft.Width/scbOpcoes.ControlCount)*(iComp+1);
  end;
end;

procedure TfrmPDVMain.FrameResize(Sender: TObject);
begin
  inherited;
  RefreshMesa;
end;

procedure TfrmPDVMain.btnSangriaClick(Sender: TObject);
begin
  inherited;
  frmsangria := Tfrmsangria.Create(Self);
  try
    frmsangria.ShowModal;
  finally
    FreeAndNil(frmsangria);
  end;                     
end;

procedure TfrmPDVMain.cdsMesastatusGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  case AnsiIndexStr(UpperCase(cdsMesaStatus.AsString), ['L','O']) of
    0: Text := 'Livre';
    1: Text := 'Ocupada';
  else
    Text := 'Desconhecido';
  end;
end;

end.

