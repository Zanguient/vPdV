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
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSemAddClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgAdicionalPedidoCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    FOk: Boolean;
  public
    { Public declarations }
    procedure OnClickAdicionalPDV(Sender: TObject);
    procedure OnClickAgrupAdicionalPDV(Sender: TObject);
    function GetBlz: Boolean;
  end;

var
  frmAdicional: TfrmAdicional;

implementation

{$R *.dfm}

uses
  lib_mensagem, lib_interface, uDmConexao, pdv_pdv;

procedure TfrmAdicional.FormCreate(Sender: TObject);
var
   region: hrgn;
begin
  Height := Screen.WorkAreaHeight-20;
  Width  := Screen.WorkAreaWidth-20;
  Position := poScreenCenter;

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
        OnClickAgrupAdicionalPDV, 150, 150, frmPDV_PDV.cdsAgrupAdicionalID.AsInteger);

      frmPDV_PDV.cdsAgrupAdicional.Next;
    end;
  end;

  if scbAgrupAdicional.ControlCount > 0 then
  begin
    Interface_ := TInterface.Create();
    Interface_.OrganizaScrollBox(scbAgrupAdicional,1);
  end;

  frmPDV_PDV.cdsAddPedido.Filtered := False;
  frmPDV_PDV.cdsAddPedido.Filter := '  QTITEM > 0 AND ITEMPEDIDO_ID = ' + IntToStr(frmPDV_PDV.cdsItemPedidoID.AsInteger);
  frmPDV_PDV.cdsAddPedido.Filtered := True;
end;

procedure TfrmAdicional.OnClickAdicionalPDV(Sender: TObject);
begin                                                                           
  cdsAdicional.Locate('ID', (Sender as TcxButton).Tag, [loCaseInsensitive]);
  if frmPDV_PDV.cdsAddPedido.Locate('ID', cdsAdicionalID.AsInteger, [loCaseInsensitive]) then
  begin
    frmPDV_PDV.cdsAddPedido.Edit;
    frmPDV_PDV.cdsAddPedidoQTITEM.AsFloat     := frmPDV_PDV.cdsAddPedidoQTITEM.AsFloat+1.0;
    frmPDV_PDV.cdsAddPedidoVRUNITARIO.AsFloat   := cdsAdicionalVALOR.AsFloat;
//    frmPDV_PDV.cdsAddPedidoV.AsFloat := frmPDV_PDV.cdsAddPedidoVRUNITARIO.AsFloat*frmPDV_PDV.cdsAddPedidoQTITEM.AsFloat;
    frmPDV_PDV.cdsAddPedido.Post;
  end else
  begin
    frmPDV_PDV.cdsAddPedido.Insert;
    frmPDV_PDV.cdsAddPedidoIMG.AsInteger        := 0;
    frmPDV_PDV.cdsAddPedidoid.AsInteger         := cdsAdicionalID.AsInteger;
    frmPDV_PDV.cdsAddPedidoVRUNITARIO.AsFloat   := cdsAdicionalVALOR.AsFloat;
    frmPDV_PDV.cdsAddPedidoVRTOTAITEM.AsFloat   := cdsAdicionalVALOR.AsFloat;
    frmPDV_PDV.cdsAddPedidoQTITEM.AsFloat       := 1.0;
    frmPDV_PDV.cdsAddPedidoITEMPEDIDO_ID.AsInteger := frmPDV_PDV.cdsITEMPEDIDOID.AsInteger;
    frmPDV_PDV.cdsAddPedidoNMPRODUTO.AsString   := cdsAdicionalNMPRODUTO.AsString;
    frmPDV_PDV.cdsAddPedidoIMG.AsInteger        := 0;
    frmPDV_PDV.cdsAddPedido.Post;
  end;
end;

function TfrmAdicional.GetBlz: Boolean;
begin
  Result := FOk;
end;

procedure TfrmAdicional.btnSemAddClick(Sender: TObject);
begin
  FOk := True;
  frmPDV_PDV.cdsAddPedido.First;
  while not frmPDV_PDV.cdsAddPedido.Eof do
  begin
    frmPDV_PDV.cdsAddPedido.Edit;
    frmPDV_PDV.cdsAddPedidoQTITEM.AsFloat := 0.0;
    frmPDV_PDV.cdsAddPedido.Post;

    frmPDV_PDV.cdsAddPedido.Next;
  end;
  Close;
end;

procedure TfrmAdicional.btnConfirmaClick(Sender: TObject);
begin
  FOk := True;
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
        OnClickAdicionalPDV, 150, 150, cdsAdicionalID.AsInteger);

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
    begin
//      frmPDV_PDV.cdsAddPedido.DisableControls;
//      frmPDV_PDV.cdsAddPedido.Filtered := False;

      frmPDV_PDV.cdsAddPedido.Edit;
      frmPDV_PDV.cdsAddPedidoQTITEM.AsFloat := 0.0;
      frmPDV_PDV.cdsAddPedido.Post;

//      frmPDV_PDV.cdsAddPedido.Filtered := True;
//      frmPDV_PDV.cdsAddPedido.EnableControls;

//      if frmPDV_PDV.cdsAddPedido.RecordCount > 0 then
        frmPDV_PDV.cdsAddPedido.First;
    end;
end;

end.
