unit pdv_adicional;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, DB, DBClient, Provider, ADODB, ExtCtrls, cxControls,
  cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxButtonEdit,
  cxImageComboBox, cxCurrencyEdit;

type
  TfrmAdicional = class(TForm)
    scbOpcoes: TScrollBox;
    btnConfirma: TcxButton;
    btnSemAdd: TcxButton;
    btnCancelar: TcxButton;
    cdsAdicional: TClientDataSet;
    dtsAdicional: TDataSource;
    dspAdicional: TDataSetProvider;
    adqAdicional: TADOQuery;
    cdsAdicionalID: TAutoIncField;
    cdsAdicionalVALOR: TFloatField;
    cdsAdicionalQUANTIDADE: TFloatField;
    cdsAdicionalNMPRODUTO: TStringField;
    cdsAdicionalIMGINDEX: TIntegerField;
    cdsAdicionalIDTIPOMED: TStringField;
    panDireita: TPanel;
    scbAgrupAdicional: TScrollBox;
    scbAdicional: TScrollBox;
    dbgAdicional: TcxGrid;
    dbgAdicionalPedido: TcxGridDBTableView;
    dbgAdicionalPedidoColumn1: TcxGridDBColumn;
    dbgAdicionalPedidoColumn2: TcxGridDBColumn;
    dbgAdicionalPedidoColumn3: TcxGridDBColumn;
    dbgAdicionalPedidoColumn4: TcxGridDBColumn;
    dbgAdicionalDBBandedTableView1: TcxGridDBBandedTableView;
    dbgAdicionalDBBandedTableView1Column1: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column2: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column3: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column4: TcxGridDBBandedColumn;
    dbgAdicionalLevel1: TcxGridLevel;
    cdbgExcluir: TcxGridDBColumn;
    dtsAddPedido: TDataSource;
    cdsAddPedido: TClientDataSet;
    cdsAddPedidoid: TIntegerField;
    cdsAddPedidoNMPRODUTO: TStringField;
    cdsAddPedidoQTITEM: TFloatField;
    cdsAddPedidoVRUNITARIO: TFloatField;
    cdsAddPedidoITEMPEDIDO_ID: TIntegerField;
    cdsAddPedidoIMG: TLargeintField;
    cdsAddPedidoVRTOTAITEM: TFloatField;
    cdsAddPedidoSUMVRTOTAL: TAggregateField;
    cdsAddPedidoMAXID: TAggregateField;
    adqAuxAdicional: TADOQuery;
    cdsAuxAddPedido: TClientDataSet;
    cdsAuxAddPedidoid: TIntegerField;
    cdsAuxAddPedidoNMPRODUTO: TStringField;
    cdsAuxAddPedidoQTITEM: TFloatField;
    cdsAuxAddPedidoVRUNITARIO: TFloatField;
    cdsAuxAddPedidoITEMPEDIDO_ID: TIntegerField;
    cdsAuxAddPedidoIMG: TLargeintField;
    cdsAuxAddPedidoVRTOTAITEM: TFloatField;
    cdsAuxAddPedidoSUMVRTOTAL: TAggregateField;
    cdsAuxAddPedidoSUMVRTOTAITEM: TAggregateField;
    cdsAuxAddPedidoSUMQTITEM: TAggregateField;
    cdsAuxAddPedidoQTGRATUI: TIntegerField;
    cdsAuxAddPedidoSUMQTGRATUI: TAggregateField;
    cdsAuxAdicional: TClientDataSet;
    cdsAuxAdicionalPRODUTO_ID: TIntegerField;
    cdsAuxAdicionalVRVENDA: TFloatField;
    cdsAuxAdicionalQTADICGRATIS: TIntegerField;
    cdsAuxAdicionalID: TAutoIncField;
    cdsAuxAdicionalVRAGRUPADIC: TFloatField;
    dspAuxAdicional: TDataSetProvider;
    cdsAuxAddPedidoVRADICIONAL: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSemAddClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgAdicionalPedidoCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsAddPedidoQTITEMChange(Sender: TField);
  private
    { Private declarations }
    FOk: Boolean;
  public
    { Public declarations }
    procedure OnClickAdicionalPDV(Sender: TObject);
    procedure OnClickAgrupAdicionalPDV(Sender: TObject);
    function GetBlz: Boolean;
    function ConfereGratuidade: Boolean;
  end;

var
  frmAdicional: TfrmAdicional;
//  boGratuitoOk: Boolean;
  inCARDAPIO_ID: Integer;

implementation

{$R *.dfm}

uses
  lib_mensagem, lib_interface, uDmConexao, pdv_pdv, math;

procedure TfrmAdicional.FormCreate(Sender: TObject);
var
   region: hrgn;
begin
  //Altera o tamanho do formulário para o tamanho da tela
  Height := Screen.Height;
  Width  := Screen.Width;
//  boGratuitoOk := False;
  cdsAuxAddPedido.EmptyDataSet;

  cdsAddPedido.Data := frmPDV_PDV.cdsAddPedido.Data;

  cdsAddPedido.Filtered := False;
  cdsAddPedido.Filter := ' QTITEM > 0 AND ITEMPEDIDO_ID = '+frmPDV_PDV.cdsItemPedidoID.AsString;
  cdsAddPedido.Filtered := True;
  cdsAddPedido.First;

  inCARDAPIO_ID := frmPDV_PDV.cdsItemPedidoCARDAPIO_ID.AsInteger;
  adqAuxAdicional.Close;
  adqAuxAdicional.Parameters.ParamByName('P_CARDAPIO_ID').Value := inCARDAPIO_ID;
  adqAuxAdicional.Open;
  cdsAuxAdicional.Data := dspAuxAdicional.Data;                          
  adqAuxAdicional.Close;
  
//  inQuantGratis := adqAuxAdicional.FieldByName('QTADICGRATIS').AsInteger;
  while not cdsAddPedido.Eof do
  begin
    cdsAuxAdicional.First;
    cdsAuxAdicional.Locate('PRODUTO_ID', cdsAddPedidoid.AsInteger, [loCaseInsensitive]);
    cdsAuxAddPedido.Insert;
    cdsAuxAddPedidoid.AsInteger            := cdsAddPedidoid.AsInteger;
    cdsAuxAddPedidoNMPRODUTO.AsString      := cdsAddPedidoNMPRODUTO.AsString;
    cdsAuxAddPedidoQTITEM.AsFloat          := cdsAddPedidoQTITEM.AsFloat;
    cdsAuxAddPedidoVRUNITARIO.AsFloat      := cdsAddPedidoVRUNITARIO.AsFloat;
    cdsAuxAddPedidoITEMPEDIDO_ID.AsInteger := cdsAddPedidoITEMPEDIDO_ID.AsInteger;
    cdsAuxAddPedidoIMG.AsInteger           := cdsAddPedidoIMG.AsInteger;
    cdsAuxAddPedidoVRTOTAITEM.AsFloat      := cdsAddPedidoVRTOTAITEM.AsFloat;
    cdsAuxAddPedidoQTGRATUI.AsInteger      := 0;
    cdsAuxAddPedidoVRADICIONAL.AsFloat     := cdsAuxAdicionalVRAGRUPADIC.AsFloat;
    cdsAuxAddPedido.Post;

    cdsAddPedido.Next;
  end;                                           
//  boGratuitoOk := ConfereGratuidade;

  DoubleBuffered := True;
  region := CreateRoundRectRgn(0, 0, width, height, 15, 15);
  SetWindowRgn(handle, region, true);
end;

procedure TfrmAdicional.btnCancelarClick(Sender: TObject);
begin
  FOk := False;
  Close;
end;

procedure TfrmAdicional.FormShow(Sender: TObject);  
var
  Interface_: TInterface; 
  iComp: Integer;
begin
  Interface_ := TInterface.Create();

  for iComp := 0 to pred(scbOpcoes.ControlCount) do
  begin
    scbOpcoes.Controls[iComp].Width := Trunc(scbOpcoes.Width/scbOpcoes.ControlCount);
    scbOpcoes.Controls[iComp].Left  := Trunc(scbOpcoes.Width/scbOpcoes.ControlCount)*(iComp+1);
  end;

  panDireita.Width := Trunc(frmAdicional.Width/2)+Trunc(frmAdicional.Width/6);

  if scbAgrupAdicional.ControlCount = 0 then
  begin
    frmPDV_PDV.cdsAgrupAdicional.First;
    while not frmPDV_PDV.cdsAgrupAdicional.Eof do
    begin
      Interface_.CriaButtonScrollBox(scbAgrupAdicional, frmPDV_PDV.cdsAgrupAdicional.FieldByName('NMAGRUPADIC').AsString,
        OnClickAgrupAdicionalPDV, 150, 150, frmPDV_PDV.cdsAgrupAdicionalID.AsInteger, frmPDV_PDV.cilItensPDV, frmPDV_PDV.cdsAgrupAdicionalimgindex.AsInteger);

      frmPDV_PDV.cdsAgrupAdicional.Next;
    end;
  end;

  if scbAgrupAdicional.ControlCount > 0 then
  begin
    Interface_ := TInterface.Create();
    Interface_.OrganizaScrollBox(scbAgrupAdicional,1);
  end;

  cdsAddPedido.Filtered := False;
  cdsAddPedido.Filter := '  QTITEM > 0 AND ITEMPEDIDO_ID = ' + IntToStr(frmPDV_PDV.cdsItemPedidoID.AsInteger);
  cdsAddPedido.Filtered := True;
end;

procedure TfrmAdicional.OnClickAdicionalPDV(Sender: TObject);
  procedure CalculaTotalItem;
  var
    inAuxSUMQTGRATUI: Double;
  begin
    inAuxSUMQTGRATUI := 0.0;
    cdsAuxAdicional.First;
    if not cdsAuxAdicional.Locate('PRODUTO_ID', cdsAddPedidoid.AsInteger, [loCaseInsensitive]) then
    begin
      adqAuxAdicional.Close;
      adqAuxAdicional.Parameters.ParamByName('P_CARDAPIO_ID').Value := inCARDAPIO_ID;
      adqAuxAdicional.Open;
      cdsAuxAdicional.Data := dspAuxAdicional.Data;
      adqAuxAdicional.Close;
      cdsAuxAdicional.Locate('PRODUTO_ID', cdsAddPedidoid.AsInteger, [loCaseInsensitive]);
    end;
    if not VarIsNull(cdsAuxAddPedidoSUMQTGRATUI.Value) then
      inAuxSUMQTGRATUI := StrToInt(cdsAuxAddPedidoSUMQTGRATUI.Value)
    else
      inAuxSUMQTGRATUI := 0;

    if not cdsAuxAddPedido.Locate('ID', cdsAdicionalID.AsInteger, [loCaseInsensitive]) then
    begin
      cdsAuxAddPedido.Insert;
      cdsAuxAddPedidoIMG.AsInteger        := 0;
      cdsAuxAddPedidoid.AsInteger         := cdsAdicionalID.AsInteger;
      cdsAuxAddPedidoVRUNITARIO.AsFloat   := cdsAdicionalVALOR.AsFloat;
      cdsAuxAddPedidoITEMPEDIDO_ID.AsInteger := frmPDV_PDV.cdsITEMPEDIDOID.AsInteger;
      cdsAuxAddPedidoQTGRATUI.AsInteger   := 0;  
      cdsAuxAddPedidoIMG.AsInteger        := 0;
      cdsAuxAddPedidoQTITEM.AsFloat       := 1.0;
      cdsAuxAddPedido.Post;
      cdsAuxAddPedido.Locate('ID', cdsAddPedidoID.AsInteger, [loCaseInsensitive]);
    end;
    if not VarIsNull(cdsAuxAddPedidoSUMQTGRATUI.Value) then
    begin
      if StrToInt(cdsAuxAddPedidoSUMQTGRATUI.Value) < cdsAuxAdicionalQTADICGRATIS.AsInteger then
      begin
        cdsAuxAddPedido.Edit;
        cdsAuxAddPedidoQTGRATUI.AsInteger := cdsAuxAddPedidoQTGRATUI.AsInteger+1;
        cdsAuxAddPedido.Post;
      end;
    end else
    begin
      cdsAuxAddPedido.Edit;
      cdsAuxAddPedidoQTGRATUI.AsInteger := cdsAuxAddPedidoQTGRATUI.AsInteger+1;
      cdsAuxAddPedido.Post;
    end;
  end;
var
  flValorCalculado: Double;
begin
//  boGratuitoOk := False;
  cdsAdicional.Locate('ID', (Sender as TcxButton).Tag, [loCaseInsensitive]);
  if cdsAddPedido.Locate('ID', cdsAdicionalID.AsInteger, [loCaseInsensitive]) then
  begin
    cdsAddPedido.Edit;
    cdsAddPedidoVRUNITARIO.AsFloat := cdsAdicionalVALOR.AsFloat;
    CalculaTotalItem;
    cdsAddPedidoQTITEM.AsFloat     := cdsAddPedidoQTITEM.AsFloat+1.0;
    cdsAddPedido.Post;
  end else
  begin
    cdsAddPedido.Insert;
    cdsAddPedidoIMG.AsInteger        := 0;
    cdsAddPedidoid.AsInteger         := cdsAdicionalID.AsInteger;
    cdsAddPedidoVRUNITARIO.AsFloat   := cdsAdicionalVALOR.AsFloat;
    cdsAddPedidoITEMPEDIDO_ID.AsInteger := frmPDV_PDV.cdsITEMPEDIDOID.AsInteger;
    CalculaTotalItem;
    cdsAddPedidoQTITEM.AsFloat       := 1.0;
    cdsAddPedidoNMPRODUTO.AsString   := cdsAdicionalNMPRODUTO.AsString;
    cdsAddPedidoIMG.AsInteger        := 0;
    cdsAddPedido.Post;
  end;
end;

function TfrmAdicional.GetBlz: Boolean;
begin
  Result := FOk;
end;

procedure TfrmAdicional.btnSemAddClick(Sender: TObject);
begin
  FOk := True;
  cdsAddPedido.First;
  while not cdsAddPedido.Eof do
    cdsAddPedido.Delete;
  frmPDV_PDV.cdsAddPedido.Data := cdsAddPedido.Data;
  Close;
end;

procedure TfrmAdicional.btnConfirmaClick(Sender: TObject);
begin
  FOk := True;
  frmPDV_PDV.cdsAddPedido.Data := cdsAddPedido.Data;
  Close;
end;

procedure TfrmAdicional.OnClickAgrupAdicionalPDV(Sender: TObject);
var
  Interface_: TInterface;
  contador, retirados: Integer;
begin
  retirados := 0;

  for contador := 0 to scbAdicional.ControlCount - 1 do
  begin
    if scbAdicional.Controls[contador - retirados].ClassName = 'TcxButton' then
    begin
       scbAdicional.Controls[contador - retirados].Destroy;
       Inc(retirados);
    end;
  end;

  adqAdicional.Close;
  adqAdicional.Parameters.ParamByName('P_AGRUPADICIONAL').Value := (Sender as TcxButton).Tag;
  adqAdicional.Open;

  cdsAdicional.Data := dspAdicional.Data;
  adqAdicional.Close;

  if scbAdicional.ControlCount = 0 then
  begin
    cdsAdicional.First;
    while not cdsAdicional.Eof do
    begin
      Interface_.CriaButtonScrollBox(scbAdicional, cdsAdicional.FieldByName('NMPRODUTO').AsString,
        OnClickAdicionalPDV, 150, 150, cdsAdicionalID.AsInteger, frmPDV_PDV.cilItensPDV, cdsAdicionalIMGINDEX.AsInteger);

      cdsAdicional.Next;
    end;
  end;

  if scbAdicional.ControlCount > 0 then
  begin
    Interface_ := TInterface.Create();
    Interface_.OrganizaScrollBox(scbAdicional,1);
  end;
end;

procedure TfrmAdicional.dbgAdicionalPedidoCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  if ACellViewInfo.Item.Name = 'cdbgExcluir' then
    if Confirma(EXCLUIR_ITEM) then
      cdsAddPedido.Delete;
  Abort;
end;

procedure TfrmAdicional.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
  FreeAndNil(cdsAddPedido);
  FreeAndNil(cdsAdicional);
  FreeAndNil(adqAdicional);
  FreeAndNil(cdsAuxAddPedido);
end;

procedure TfrmAdicional.cdsAddPedidoQTITEMChange(Sender: TField);
begin
  cdsAuxAddPedido.Locate('ID', cdsAddPedidoID.AsInteger, [loCaseInsensitive]);
  if cdsAddPedido.State in [dsEdit, dsInsert] then
    cdsAddPedidoVRTOTAITEM.AsFloat := cdsAddPedidoVRUNITARIO.AsFloat*(cdsAddPedidoQTITEM.AsInteger-cdsAuxAddPedidoQTGRATUI.AsInteger);
end;

function TfrmAdicional.ConfereGratuidade: Boolean;
var
  flAux: Double;
begin
{  flAux := 0.0;
  cdsAddPedido.DisableControls;
  cdsAddPedido.First;
  while not cdsAddPedido.Eof do
  begin
    if RoundTo((cdsAddPedidoQTITEM.AsFloat*cdsAddPedidoVRUNITARIO.AsFloat),-2) <> RoundTo(cdsAddPedidoVRTOTAITEM.AsFloat,-2) then
    begin
      flAux := flAux+cdsAddPedidoQTITEM.AsFloat-(cdsAddPedidoVRTOTAITEM.AsFloat/cdsAddPedidoVRUNITARIO.AsFloat);
    end;
    cdsAddPedido.Next;
  end;
  Result := (RoundTo(flAux,0) <= inQuantGratis);
  cdsAddPedido.EnableControls;}
end;

end.
