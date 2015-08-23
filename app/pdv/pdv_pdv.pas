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
  cxContainer, cxTextEdit, cxLabel, Provider, ADODB;
    
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
    dbgAdicionalDBTableView1: TcxGridDBTableView;
    dbgAdicionalDBTableView1Column1: TcxGridDBColumn;
    dbgAdicionalDBTableView1Column2: TcxGridDBColumn;
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
    cdsProdutos: TClientDataSet;
    dtsProdutos: TDataSource;
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
    dbgAdicionalDBTableView1Column3: TcxGridDBColumn;
    dbgAdicionalDBTableView1Column4: TcxGridDBColumn;
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
    DataSetProvider1: TDataSetProvider;
    dspCategoria: TDataSetProvider;
    dspProdutos: TDataSetProvider;
    DataSetProvider4: TDataSetProvider;
    adqCategoria: TADOQuery;
    adqProdutos: TADOQuery;
    cdsProdutosID: TAutoIncField;
    cdsProdutosNMPRODUTO: TStringField;
    cdsProdutosPOSARVORE: TStringField;
    cdsProdutosUNIMEDIDA_ID: TIntegerField;
    cdsProdutosCDBARRA: TStringField;
    cdsProdutosIDPRODVENDA: TSmallintField;
    cdsProdutosIDADICIONAL: TSmallintField;
    cdsProdutosIMGINDEX: TIntegerField;
    cdsProdutosCATEGORIA_ID: TIntegerField;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    cdsItemPedidoPRODUTO_ID: TIntegerField;
    cdsAddPedidoPRODUTO_ID: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    constructor PCreate(Form: TComponent; Parametros: TParametros); Overload;
    procedure btnGavetaClick(Sender: TObject);
    procedure btnFinalizarPedidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FParametros: TParametros;
  public
    { Public declarations }
    procedure OnClickCategoriaPDV(Sender: TObject);
    procedure OnClickProdutosPDV(Sender: TObject);
  end;

var
  frmPDV_PDV: TfrmPDV_PDV;

implementation

{$R *.dfm}

uses
  lib_mensagem, lib_interface, pdv_adicional, uDmConexao, lib_vmsis, lib_acesso,
  main_base;

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

  adqProdutos.Close;
  adqProdutos.Open;

  cdsCategoria.Data := dspCategoria.Data;
  cdsProdutos.Data  := dspProdutos.Data;

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
  cdsProdutos.Filtered := False;
  retirados := 0;
  
  for contador := 0 to scbProduto.ControlCount - 1 do
  begin
    if scbProduto.Controls[contador - retirados].ClassName = 'TcxButton' then
    begin
       scbProduto.Controls[contador - retirados].Destroy;
       Inc(retirados);
    end;
  end;
  
  cdsProdutos.Filter   := ' CATEGORIA_ID = ' + IntToStr((Sender as TcxButton).Tag);
  cdsProdutos.Filtered := True;

  if scbProduto.ControlCount = 0 then
  begin
    cdsProdutos.First;
    while not cdsProdutos.Eof do
    begin
      Interface_.CriaButtonScrollBox(scbProduto, cdsProdutos.FieldByName('NMPRODUTO').AsString,
        OnClickProdutosPDV, 150, 150, cdsProdutos.FieldByName('ID').AsInteger);

      cdsProdutos.Next;
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
  begin
    if cdsItemPedido.Locate('PRODUTO_ID', cdsProdutosID.AsInteger, [loCaseInsensitive]) then
    begin
      cdsItemPedido.Edit;
      cdsItemPedidoQTITEM.AsFloat := cdsItemPedidoQTITEM.AsFloat+1.0; 
      cdsItemPedido.Post;
    end else
    begin
      cdsItemPedido.Insert;
  {    cdsItemPedidoPEDIDO_ID: TIntegerField
      cdsItemPedidoCARDAPIO_ID: TIntegerField
      cdsItemPedidoLOTE_ID: TIntegerField
      cdsItemPedidoVRVENDA: TFloatField
      cdsItemPedidoVRTOTAL: TFloatField
      cdsItemPedidoIDADICIONAL: TIntegerField}
      cdsItemPedidoQTITEM.AsFloat := 1.0;
      cdsItemPedidoPRODUTO_ID.AsInteger := cdsProdutosID.AsInteger;
      cdsItemPedidoNMPRODUTO.AsString := cdsProdutosNMPRODUTO.AsString;
      cdsItemPedido.Post;
    end;
  end;
  procedure ConfirmaAdicional;
  begin
    if cdsAddPedido.Locate('PRODUTO_ID', cdsProdutosID.AsInteger, [loCaseInsensitive]) then
    begin
      cdsAddPedido.Edit;
      cdsAddPedidoQTITEM.AsFloat := cdsAddPedidoQTITEM.AsFloat+1.0; 
      cdsAddPedido.Post;
    end else
    begin
      cdsAddPedido.Insert;
      {cdsAddPedidoid: TIntegerField
      cdsAddPedidoNMPRODUTO: TStringField
      cdsAddPedidoVRUNITARIO: TFloatField
      cdsAddPedidoVRTOTAITEM: TFloatField}
      cdsAddPedidoQTITEM.AsFloat := 1.0;
      cdsAddPedidoPRODUTO_ID.AsInteger := cdsProdutosID.AsInteger;
      cdsAddPedidoNMPRODUTO.AsString := cdsProdutosNMPRODUTO.AsString;
      cdsAddPedido.Post;
    end;
  end;
begin
  cdsProdutos.Locate('ID', (Sender as TcxButton).Tag, [loCaseInsensitive]);

  if Boolean(cdsProdutosIDADICIONAL.AsInteger) then
  begin
    frmAdicional := TfrmAdicional.Create(Self);

    try
      frmAdicional.Tag := (Sender as TcxButton).Tag;
      frmAdicional.ShowModal;

      if frmAdicional.GetBlz then begin
        ConfirmaProduto;
        //ConfirmaAdicional;
      end;
    finally
      FreeAndNil(frmAdicional);
    end;
  end else
    ConfirmaProduto;
end;

procedure TfrmPDV_PDV.btnGavetaClick(Sender: TObject);
var
  Acesso_Perifericos: TAcesso_Perifericos;
  AcessoGaveta : TAcessoUsuario;
begin
  inherited;
  AcessoGaveta := TAcessoUsuario.create(frmMainBase.Fusuario);
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
    Acesso_Perifericos.AbreGaveta;
  finally
    FreeAndNil(Acesso_Perifericos);
  end;
end;

procedure TfrmPDV_PDV.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
