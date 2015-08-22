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
  cxContainer, cxTextEdit, cxLabel;
    
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
    cdsProdutosnmproduto: TStringField;
    cdsProdutosid: TIntegerField;
    cdsProdutosposarvore: TStringField;
    cdsProdutosunimedida_id: TIntegerField;
    cdsProdutoscdbarra: TStringField;
    cdsProdutosidprodvenda: TIntegerField;
    cdsProdutosidadicional: TIntegerField;
    cdsProdutosimgindex: TIntegerField;
    cdsProdutosid_categoria: TIntegerField;
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
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    constructor PCreate(Form: TComponent; Parametros: TParametros); Overload;
  private
    { Private declarations }
    FParametros: TParametros;
  public
    { Public declarations }
    procedure OnClickCategoriaPDV(Sender: TObject);
  end;

var
  frmPDV_PDV: TfrmPDV_PDV;

implementation

{$R *.dfm}   

uses
  lib_mensagem, lib_interface, pdv_adicional;

procedure TfrmPDV_PDV.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

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

  if scbCategoria.ControlCount = 0 then
  begin
    cdsCategoria.First;
    while not cdsCategoria.Eof do
    begin
      Interface_.CriaButtonScrollBox(scbCategoria, cdsCategoria.FieldByName('nmcategoria').AsString,
        OnClickCategoriaPDV, 150, 150);

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
begin
  frmAdicional := TfrmAdicional.Create(Self);

  try
    frmAdicional.Tag := (Sender as TcxButton).Tag;
    frmAdicional.ShowModal;
  finally
    frmAdicional.Release;
    frmAdicional := nil;
  end;
end;

constructor TfrmPDV_PDV.PCreate(Form: TComponent; Parametros: TParametros);
begin
  inherited Create(frmPDV_PDV);
  FParametros := Parametros;
end;

end.
