unit pdv_cancelar_pedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvPadraoFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, DB, ADODB, StdCtrls, cxButtons, ExtCtrls,
  cxControls, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxCurrencyEdit, cxImageComboBox,
  cxGridLevel, cxGridChartView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxContainer,
  cxTextEdit, cxMemo, cxDBEdit, cxLabel, cxDBLabel, DBClient, Provider;

type
  TvCancelaPedido = class(TvPadraoFrame)
    dbgProduto: TcxGrid;
    gdbPedido: TcxGridDBTableView;
    gdbMesa: TcxGridDBColumn;
    gdbStatusPedido: TcxGridDBColumn;
    gdbValorPedido: TcxGridDBColumn;
    gdbTipoPedido: TcxGridDBColumn;
    dbgProdutoChartView1: TcxGridChartView;
    dbgProdutoLevel1: TcxGridLevel;
    styGridPDV: TcxStyleRepository;
    styGridBackgroud: TcxStyle;
    styGridContent: TcxStyle;
    styGridHeader: TcxStyle;
    styGridSelection: TcxStyle;
    panPedido: TPanel;
    memMotivo: TcxDBMemo;
    panCabe: TPanel;
    adqPadraoMESA_ID: TIntegerField;
    adqPadraoVRPEDIDO: TFloatField;
    adqPadraoIDSTATUSPED: TStringField;
    adqPadraoDSMOTIVO: TMemoField;
    adqPadraoIDTIPOPEDIDO: TStringField;
    adqPadraoID: TAutoIncField;
    adqPadraoNMMESA: TStringField;
    dbeMesa: TcxDBLabel;
    sbxOpcoesCancelamento: TScrollBox;
    btnAtualizar: TcxButton;
    cdsPedido: TClientDataSet;
    dtsPedido: TDataSource;
    cdsPedidoMESA_ID: TIntegerField;
    cdsPedidoVRPEDIDO: TFloatField;
    cdsPedidoIDSTATUSPED: TStringField;
    cdsPedidoDSMOTIVO: TMemoField;
    cdsPedidoIDTIPOPEDIDO: TStringField;
    cdsPedidoID: TAutoIncField;
    cdsPedidoNMMESA: TStringField;
    dspPadrao: TDataSetProvider;
    lblMotivo: TcxLabel;
    btnCancelar: TcxButton;
    procedure FrameResize(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dtsPedidoStateChange(Sender: TObject);
    procedure cdsPedidoAfterScroll(DataSet: TDataSet);
    procedure dbgProdutoEnter(Sender: TObject);
    procedure memMotivoEnter(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure gdbStatusPedidoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure gdbTipoPedidoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ControleBotoes;
  end;

var
  vCancelaPedido: TvCancelaPedido;
  boAlteracao: Boolean;

implementation

{$R *.dfm}

uses
  lib_interface, lib_mensagem, Math, StrUtils;

procedure TvCancelaPedido.FrameResize(Sender: TObject); 
var
  iComp : Integer;
  Interface_: TInterface;
begin
  Interface_ := TInterface.Create();
  boAlteracao := False;

  adqPadrao.Close;
  adqPadrao.Open;

  cdsPedido.Data := dspPadrao.Data;

  for iComp := 0 to pred(sbxOpcoesCancelamento.ControlCount) do
  begin
    sbxOpcoesCancelamento.Controls[iComp].Width := Trunc(sbxOpcoesCancelamento.Width/sbxOpcoesCancelamento.ControlCount);
    sbxOpcoesCancelamento.Controls[iComp].Left  := Trunc(sbxOpcoesCancelamento.Width/sbxOpcoesCancelamento.ControlCount)*(iComp+1);
  end;
  ControleBotoes;
end;

procedure TvCancelaPedido.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if memMotivo.GetTextLen = 0 then
  begin
    memMotivo.SetFocus;
    Aviso(MOTIVO_DEVE_INFORMAR);
  end else
  begin
    if Confirma(CONFIRMA_CANCELAMENTO_PEDIDO) then
      if adqPadrao.Locate('ID', cdsPedidoID.AsInteger, [loCaseInsensitive]) then
      begin
        adqPadrao.Edit;
        adqPadraoDSMOTIVO.AsString := cdsPedidoDSMOTIVO.AsString;
        adqPadraoIDSTATUSPED.AsString := 'C';
        adqPadrao.Post;
      end;
    cdsPedido.DisableControls;
    adqPadrao.Close;
    adqPadrao.Open;
    cdsPedido.Data := dspPadrao.Data;
    cdsPedido.EnableControls;
    cdsPedido.First;
  end;
end;

procedure TvCancelaPedido.dtsPedidoStateChange(Sender: TObject);
begin      
  if dtsPedido.State in [dsEdit] then
    boAlteracao := True
  else
    if boAlteracao then
      Aviso(MOTIVO_TEMP_CANCELAMENTO);
  ControleBotoes;
  inherited;
end;

procedure TvCancelaPedido.cdsPedidoAfterScroll(DataSet: TDataSet);
begin
  inherited;
  boAlteracao := False;
end;

procedure TvCancelaPedido.dbgProdutoEnter(Sender: TObject);
begin
  inherited;
  ControleBotoes;
end;

procedure TvCancelaPedido.memMotivoEnter(Sender: TObject);
begin
  inherited;
  ControleBotoes;
end;

procedure TvCancelaPedido.ControleBotoes;
begin
  btnCancelar.Enabled  := (memMotivo.Focused and (not dbgProduto.Focused)) and not cdsPedido.IsEmpty;
  btnAtualizar.Enabled := not memMotivo.Focused;
end;

procedure TvCancelaPedido.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  cdsPedido.DisableControls;
  cdsPedido.First;
  while not cdsPedido.Eof do
  begin
    if Length(cdsPedidoDSMOTIVO.AsString) > 0 then
    begin
      if Confirma(MOTIVO_INFORM_PERDIDO) then
      begin
        adqPadrao.Close;
        adqPadrao.Open;

        cdsPedido.Data := dspPadrao.Data;
      end;
      Break;
    end;

    cdsPedido.Next;
  end;
  cdsPedido.First;
  cdsPedido.EnableControls;
end;

procedure TvCancelaPedido.gdbStatusPedidoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  inherited;
  case AnsiIndexStr(UpperCase(AText), ['A','C','F']) of
    0: Atext := 'Aberto';
    1: Atext := 'Cancelado';
    2: Atext := 'Finalizado';
  else
    AText := 'Desconhecido'; 
  end;
end;

procedure TvCancelaPedido.gdbTipoPedidoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  inherited;
  case AnsiIndexStr(UpperCase(AText), ['D','B','M']) of
    0: Atext := 'Delivery';
    1: Atext := 'Balcão';
    2: Atext := 'Mesa';
  else
    AText := 'Desconhecido';
  end;
end;

end.
