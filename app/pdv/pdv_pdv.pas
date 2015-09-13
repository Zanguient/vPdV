unit pdv_pdv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, ExtCtrls, cxControls, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxProgressBar,
  cxGridChartView, cxGridLevel, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DBClient,
  cxContainer, cxTextEdit, cxLabel, Provider, ADODB, cxButtonEdit, cxImage,
  cxImageComboBox, ImgList;
    
type
  TParametros = Record
  Caption: String;
  Tag, Totalizador_Height: Integer;
  btnGravar_Visible, panDados_Visible: Boolean;
end;

type
  TfrmPDV_PDV = class(TForm)
    scbMenu: TScrollBox;
    btnGaveta: TcxButton;
    btnFinalizarPedido: TcxButton;
    btnGravar: TcxButton;
    btnCancelar: TcxButton;
    scbGrupo: TScrollBox;
    scbCategoria: TScrollBox;
    scbProduto: TScrollBox;
    panGrids: TPanel;
    dbgAdicional: TcxGrid;
    gdbAddPedido: TcxGridDBTableView;
    gdbAddPedidoColumn1: TcxGridDBColumn;
    gdbAddPedidoColumn2: TcxGridDBColumn;
    dbgAdicionalDBBandedTableView1: TcxGridDBBandedTableView;
    dbgAdicionalDBBandedTableView1Column1: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column2: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column3: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column4: TcxGridDBBandedColumn;
    dbgAdicionalLevel1: TcxGridLevel;
    dbgProduto: TcxGrid;
    gdbPedido: TcxGridDBTableView;
    gdbNmProduto: TcxGridDBColumn;
    gdbQuantidade: TcxGridDBColumn;
    gdbVrUnitario: TcxGridDBColumn;
    gdbVrTotaItem: TcxGridDBColumn;
    dbgProdutoChartView1: TcxGridChartView;
    dbgProdutoLevel1: TcxGridLevel;
    cdsItemCategoria: TClientDataSet;
    dtsItemCategoria: TDataSource;
    cdsCategoria: TClientDataSet;
    dtsCategoria: TDataSource;
    cdsItemPedido: TClientDataSet;
    dtsItemPedido: TDataSource;
    cdsAddPedido: TClientDataSet;
    dtsAddPedido: TDataSource;
    cdsCategoriaid: TIntegerField;
    cdsCategorianmcategoria: TStringField;
    cdsCategoriaimgindex: TIntegerField;
    cdsItemPedidoID: TIntegerField;
    cdsItemPedidoPEDIDO_ID: TIntegerField;
    cdsItemPedidoCARDAPIO_ID: TIntegerField;
    cdsItemPedidoLOTE_ID: TIntegerField;
    cdsItemPedidoQTITEM: TFloatField;
    cdsItemPedidoVRVENDA: TFloatField;
    cdsItemPedidoVRTOTAL: TFloatField;
    cdsItemPedidoIDADICIONAL: TIntegerField;
    cdsItemPedidoNMPRODUTO: TStringField;
    cdsAddPedidoid: TIntegerField;
    cdsAddPedidoVRUNITARIO: TFloatField;
    cdsAddPedidoQTITEM: TFloatField;
    cdsAddPedidoNMPRODUTO: TStringField;
    gdbAddPedidoColumn3: TcxGridDBColumn;
    gdbAddPedidoColumn4: TcxGridDBColumn;
    cdsAddPedidoVRTOTAITEM: TFloatField;
    scbTotalizador: TScrollBox;
    lblFrom: TcxLabel;
    panTotal: TPanel;
    lblTotal: TcxLabel;
    edtTotal: TcxTextEdit;
    panDados: TPanel;
    lblCPF: TcxLabel;
    edtCPF: TcxTextEdit;
    edtNome: TcxTextEdit;
    lblNome: TcxLabel;
    btnPesqCliente: TcxButton;
    dspAgrupAdicional: TDataSetProvider;
    dspCategoria: TDataSetProvider;
    dspItemCategoria: TDataSetProvider;
    dspItAgrupAdicional: TDataSetProvider;
    adqCategoria: TADOQuery;
    adqItemCategoria: TADOQuery;
    adqItAgrupAdicional: TADOQuery;
    adqAgrupAdicional: TADOQuery;
    cdsItemPedidoPRODUTO_ID: TIntegerField;
    cdsAddPedidoPRODUTO_ID: TIntegerField;
    cdsItemCategoriaID: TAutoIncField;
    cdsItemCategoriaNMPRODUTO: TStringField;
    cdsItemCategoriaPOSARVORE: TStringField;
    cdsItemCategoriaUNIMEDIDA_ID: TIntegerField;
    cdsItemCategoriaCDBARRA: TStringField;
    cdsItemCategoriaIDPRODVENDA: TSmallintField;
    cdsItemCategoriaIDADICIONAL: TSmallintField;
    cdsItemCategoriaIMGINDEX: TIntegerField;
    cdsItemCategoriaCATEGORIA_ID: TIntegerField;
    cdsItemCategoriaVRVENDA: TFloatField;
    cdsItemCategoriaQTVENDA: TFloatField;
    cdsItemCategoriaQTADICGRATIS: TIntegerField;
    cdsItemCategoriaIDTIPOMED: TStringField;
    adqVerifAdicional: TADOQuery;
    cdsAgrupAdicional: TClientDataSet;
    dtsAgrupAdicional: TDataSource;
    cdsAgrupAdicionalID: TAutoIncField;
    cdsAgrupAdicionalNMAGRUPADIC: TStringField;
    cdsAgrupAdicionalVRAGRUPADIC: TFloatField;
    adqVerifAdicionalID: TAutoIncField;
    gdbExcluir: TcxGridDBColumn;
    cilPDV_16: TcxImageList;
    cdsItemPedidoIMG: TIntegerField;
    cdsAddPedidoIMG: TIntegerField;
    cdsItemPedidoMAXID: TAggregateField;
    cdsAddPedidoMAXID: TAggregateField;
    cdsAddPedidoSUMVRTOTAL: TAggregateField;
    cdsItemPedidoSUMVRTOTAL: TAggregateField;
    adqInsPedido: TADOQuery;
    adqInsItemPedido: TADOQuery;
    adqInsAdicionalPedido: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    constructor PCreate(Form: TComponent; Parametros: TParametros); Overload;
    procedure btnGavetaClick(Sender: TObject);
    procedure btnFinalizarPedidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cdsItemPedidoAfterScroll(DataSet: TDataSet);
    procedure gdbExcluirPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsItemPedidoAfterPost(DataSet: TDataSet);
    procedure gdbPedidoCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure gdbPedidoCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    FParametros: TParametros;
  public
    { Public declarations }
    procedure OnClickCategoriaPDV(Sender: TObject);
    procedure OnClickProdutosPDV(Sender: TObject);
    procedure AtualizaValorPedido;
  end;

var
  frmPDV_PDV: TfrmPDV_PDV;

implementation

{$R *.dfm}

uses
  lib_mensagem, lib_interface, pdv_adicional, uDmConexao, lib_vmsis, lib_acesso,
  main_base, pdv_confirma_qtde_peso, math;

procedure TfrmPDV_PDV.FormShow(Sender: TObject);
var
  Interface_: TInterface; 
  iComp, iGrava: Integer;
begin
  Interface_ := TInterface.Create();

  lblFrom.Caption := FParametros.Caption;
  frmPDV_PDV.Tag  := FParametros.Tag;
  scbTotalizador.Height := FParametros.Totalizador_Height;
  btnGravar.Visible := FParametros.btnGravar_Visible;
  iGrava := Integer(not FParametros.btnGravar_Visible);
  panDados.Visible  := FParametros.panDados_Visible;

  edtNome.Width := (panDados.Width - edtNome.Left) - btnPesqCliente.Width;

  scbProduto.Height := Trunc(scbGrupo.Height/2)-scbTotalizador.Height; 

  adqCategoria.Close;
  adqCategoria.Open;

  adqItemCategoria.Close;
  adqItemCategoria.Open;

  cdsCategoria.Data := dspCategoria.Data;
  cdsItemCategoria.Data  := dspItemCategoria.Data;

  if scbCategoria.ControlCount = 0 then
  begin
    cdsCategoria.First;
    while not cdsCategoria.Eof do
    begin
      Interface_.CriaButtonScrollBox(scbCategoria, cdsCategoria.FieldByName('nmcategoria').AsString,
        OnClickCategoriaPDV, 150, 150, cdsCategoriaid.AsInteger);

      cdsCategoria.Next;
    end;
  end;                

  if scbCategoria.ControlCount > 0 then
  begin
    Interface_ := TInterface.Create();
    Interface_.OrganizaScrollBox(scbCategoria,1);
  end; 

  for iComp := 0 to pred(scbMenu.ControlCount) do
  begin
    scbMenu.Controls[iComp].Width := Trunc(scbMenu.Width/(scbMenu.ControlCount-iGrava));
  end;
end;

procedure TfrmPDV_PDV.FormCreate(Sender: TObject);
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

procedure TfrmPDV_PDV.OnClickCategoriaPDV(Sender: TObject);
var
  Interface_: TInterface;
  contador, retirados: Integer;
begin
  cdsItemCategoria.Filtered := False;
  retirados := 0;
  
  for contador := 0 to scbProduto.ControlCount - 1 do
  begin
    if scbProduto.Controls[contador - retirados].ClassName = 'TcxButton' then
    begin
       scbProduto.Controls[contador - retirados].Destroy;
       Inc(retirados);
    end;
  end;
  
  cdsItemCategoria.Filter   := ' CATEGORIA_ID = ' + IntToStr((Sender as TcxButton).Tag);
  cdsItemCategoria.Filtered := True;

  if scbProduto.ControlCount = 0 then
  begin
    cdsItemCategoria.First;
    while not cdsItemCategoria.Eof do
    begin
      Interface_.CriaButtonScrollBox(scbProduto, cdsItemCategoria.FieldByName('NMPRODUTO').AsString,
        OnClickProdutosPDV, 150, 150, cdsItemCategoria.FieldByName('ID').AsInteger);

      cdsItemCategoria.Next;
    end;
  end;

  if scbProduto.ControlCount > 0 then
  begin
    Interface_ := TInterface.Create();
    Interface_.OrganizaScrollBox(scbProduto,1);
  end;
end;

constructor TfrmPDV_PDV.PCreate(Form: TComponent; Parametros: TParametros);
begin
  inherited Create(frmPDV_PDV);
  FParametros := Parametros;
end;

procedure TfrmPDV_PDV.OnClickProdutosPDV(Sender: TObject);
  procedure ConfirmaProduto;
  var
    flRetConfirmaQtdePeso: Double;
  begin
    if cdsItemPedido.Locate('PRODUTO_ID', cdsItemCategoriaID.AsInteger, [loCaseInsensitive]) and
      (cdsItemCategoriaIDTIPOMED.AsString <> 'M') then
    begin
      cdsItemPedido.Edit;
      flRetConfirmaQtdePeso := ConfirmaQtdePeso(cdsItemCategoriaVRVENDA.AsFloat);
      if flRetConfirmaQtdePeso = 0 then begin
        cdsItemPedido.Cancel;
        Exit;
      end;
      cdsItemPedidoQTITEM.AsFloat  := RoundTo(cdsItemPedidoQTITEM.AsFloat+flRetConfirmaQtdePeso, -3);
      cdsItemPedidoVRTOTAL.AsFloat := RoundTo(cdsItemPedidoQTITEM.AsFloat*cdsItemPedidoVRVENDA.AsFloat, -2);
    end else
    begin
      cdsItemPedido.Insert;
      if VarIsNull(cdsItemPedidoMAXID.Value) then
        cdsItemPedidoID.AsInteger := 1
      else
        cdsItemPedidoID.AsInteger := Integer(cdsItemPedidoMAXID.Value)+1;
      cdsItemPedidoVRVENDA.AsFloat := RoundTo(cdsItemCategoriaVRVENDA.AsFloat, -2);
      cdsItemPedidoPRODUTO_ID.AsInteger := cdsItemCategoriaID.AsInteger;
      cdsItemPedidoNMPRODUTO.AsString := cdsItemCategoriaNMPRODUTO.AsString;
      if (cdsItemCategoriaIDTIPOMED.AsString = 'M') then
        flRetConfirmaQtdePeso := ConfirmaQtdePeso(cdsItemCategoriaVRVENDA.AsFloat,True)
      else
        flRetConfirmaQtdePeso := ConfirmaQtdePeso(cdsItemCategoriaVRVENDA.AsFloat);
      if flRetConfirmaQtdePeso = 0 then begin
        cdsItemPedido.Cancel;
        Abort;
      end;
      cdsItemPedidoCARDAPIO_ID.AsInteger := (Sender as TcxButton).Tag;
      cdsItemPedidoQTITEM.AsFloat := RoundTo(flRetConfirmaQtdePeso, -3);
      cdsItemPedidoVRTOTAL.AsFloat := RoundTo(cdsItemCategoriaVRVENDA.AsFloat*flRetConfirmaQtdePeso, -2);
      cdsItemPedidoIMG.AsInteger := 0;

//      cdsItemPedidoIDADICIONAL.AsInteger :=
//      cdsItemPedidoLOTE_ID: TIntegerField
    end;
  end;
begin
  cdsItemCategoria.Locate('ID', (Sender as TcxButton).Tag, [loCaseInsensitive]);

  adqVerifAdicional.Close;
  adqVerifAdicional.Parameters.ParamByName('P_PRODUTO').Value := cdsItemCategoriaID.AsInteger;
  adqVerifAdicional.Open;

  ConfirmaProduto;
  if not adqVerifAdicional.IsEmpty then
  begin
    if cdsAgrupAdicional.IsEmpty then
    begin
      adqAgrupAdicional.Close;
      adqAgrupAdicional.Open;
      cdsAgrupAdicional.Data := dspAgrupAdicional.Data;
      adqAgrupAdicional.Close;
    end;

    frmAdicional := TfrmAdicional.Create(Self);

    try
      frmAdicional.Tag := (Sender as TcxButton).Tag;
      frmAdicional.ShowModal;
      if frmAdicional.GetBlz then
        cdsItemPedido.Post
      else
        cdsItemPedido.Cancel;
    finally
      FreeAndNil(frmAdicional);
    end;
  end else
    cdsItemPedido.Post;
end;

procedure TfrmPDV_PDV.btnGavetaClick(Sender: TObject);
var
  Acesso_Perifericos: TAcesso_Perifericos;
  AcessoGaveta : TAcessoUsuario;
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

procedure TfrmPDV_PDV.btnFinalizarPedidoClick(Sender: TObject);
var
  Acesso_Perifericos: TAcesso_Perifericos;
begin
  inherited;
  Acesso_Perifericos := TAcesso_Perifericos.Create;
  try
    btnGravarClick(btnGravar);
    Acesso_Perifericos.AbreGaveta;
  finally
    FreeAndNil(Acesso_Perifericos);
  end;
end;

procedure TfrmPDV_PDV.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPDV_PDV.cdsItemPedidoAfterScroll(DataSet: TDataSet);
begin
  cdsAddPedido.Filtered := False;
  cdsAddPedido.Filter := ' PRODUTO_ID = ' + IntToStr(cdsItemPedidoID.AsInteger);
  cdsAddPedido.Filtered := True;
end;

procedure TfrmPDV_PDV.gdbExcluirPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
{  while not cdsAddPedido.Eof do
     cdsAddPedido.Delete;
  cdsItemPedido.Delete;}
end;

procedure TfrmPDV_PDV.btnGravarClick(Sender: TObject);
begin
  {adqInsPedido.Close;
  adqInsPedido.Parameters.ParamByName('P_IDTIPOPEDIDO').Value := ;
  adqInsPedido.Parameters.ParamByName('P_CLIENTE_ID').Value   := ;
  adqInsPedido.Parameters.ParamByName('P_NMCLIENTE').Value    := ;
  adqInsPedido.Parameters.ParamByName('P_MESA_ID').Value      := ;
  adqInsPedido.Parameters.ParamByName('P_VRPEDIDO').Value     := ;
  adqInsPedido.Parameters.ParamByName('P_IDSTATUSPED').Value  := ;
  adqInsPedido.ExecSQL;

  adqInsItemPedido.Close;
  adqInsItemPedido.Parameters.ParamByName('P_EMPRESA_ID').Value  := ;
  adqInsItemPedido.Parameters.ParamByName('P_PEDIDO_ID').Value   := ;
  adqInsItemPedido.Parameters.ParamByName('P_CARDAPIO_ID').Value := ;
  adqInsItemPedido.Parameters.ParamByName('P_LOTE_ID').Value     := ;
  adqInsItemPedido.Parameters.ParamByName('P_QTITEM').Value      := ;
  adqInsItemPedido.Parameters.ParamByName('P_VRVENDA').Value     := ;
  adqInsItemPedido.Parameters.ParamByName('P_VRTOTAL').Value     := ;
  adqInsItemPedido.Parameters.ParamByName('P_IDADICIONAL').Value := ;
  adqInsItemPedido.ExecSQL;

  adqInsAdicionalPedido.Close;
  adqInsAdicionalPedido.Parameters.ParamByName('P_EMPRESA_ID').Value  := ;
  adqInsAdicionalPedido.Parameters.ParamByName('P_PEDIDO_ID').Value   := ;
  adqInsAdicionalPedido.Parameters.ParamByName('P_CARDAPIO_ID').Value := ;
  adqInsAdicionalPedido.Parameters.ParamByName('P_LOTE_ID').Value     := ;
  adqInsAdicionalPedido.Parameters.ParamByName('P_QTITEM').Value      := ;
  adqInsAdicionalPedido.Parameters.ParamByName('P_VRVENDA').Value     := ;
  adqInsAdicionalPedido.Parameters.ParamByName('P_VRTOTAL').Value     := ;
  adqInsAdicionalPedido.Parameters.ParamByName('P_IDADICIONAL').Value := ;
  adqInsAdicionalPedido.ExecSQL;}
end;

procedure TfrmPDV_PDV.cdsItemPedidoAfterPost(DataSet: TDataSet);
begin
  AtualizaValorPedido;
end;

procedure TfrmPDV_PDV.AtualizaValorPedido;
begin
  if VarIsNull(cdsItemPedidoSUMVRTOTAL.Value) then 
    edtTotal.Text := '0,00'
  else
    edtTotal.Text := cdsItemPedidoSUMVRTOTAL.Value;
end;

procedure TfrmPDV_PDV.gdbPedidoCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  if not (ACellViewInfo.Item.Name = 'gdbExcluir') then
  begin
    adqVerifAdicional.Close;
    adqVerifAdicional.Parameters.ParamByName('P_PRODUTO').Value := cdsItemPedidoCARDAPIO_ID.AsInteger;
    adqVerifAdicional.Open;

    if not adqVerifAdicional.IsEmpty then
    begin
      if cdsAgrupAdicional.IsEmpty then
      begin
        adqAgrupAdicional.Close;
        adqAgrupAdicional.Open;
        cdsAgrupAdicional.Data := dspAgrupAdicional.Data;
        adqAgrupAdicional.Close;
      end;

      frmAdicional := TfrmAdicional.Create(Self);

      try
        frmAdicional.ShowModal;
      finally
        FreeAndNil(frmAdicional);
      end;
    end;
  end;
end;

procedure TfrmPDV_PDV.gdbPedidoCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin 
  if ACellViewInfo.Item.Name = 'gdbExcluir' then
  begin
    if Confirma(EXCLUIR_ITEM) then
    begin
      while not cdsAddPedido.Eof do
        cdsAddPedido.Delete;
      cdsItemPedido.Delete;
    end;
  end;
end;

end.
