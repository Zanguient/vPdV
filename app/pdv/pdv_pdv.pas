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
  cxGridDBTableView, cxClasses, cxGrid, DBClient,
  cxContainer, cxTextEdit, cxLabel, Provider, ADODB, cxButtonEdit, cxImage,
  cxImageComboBox, ImgList, cxCalc, cxCurrencyEdit, cxGridCustomView;

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
    scbTotalizador: TScrollBox;
    lblFrom: TcxLabel;
    panTotal: TPanel;
    lblTotal: TcxLabel;
    panDados: TPanel;
    lblTelefone: TcxLabel;
    edtTelefone: TcxTextEdit;
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
    cdsAddPedidoITEMPEDIDO_ID: TIntegerField;
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
    cdsItemPedidoMAXID: TAggregateField;
    cdsAddPedidoMAXID: TAggregateField;
    cdsAddPedidoSUMVRTOTAL: TAggregateField;
    cdsItemPedidoSUMVRTOTAL: TAggregateField;
    adqInsPedido: TADOQuery;
    adqInsItemPedido: TADOQuery;
    adqInsAdicionalPedido: TADOQuery;
    cilItensPDV: TcxImageList;
    adqItemPedido: TADOQuery;
    dspItemPedido: TDataSetProvider;
    adqUpdItemPedido: TADOQuery;
    cdsItemCategoriaPRODUTO_ID: TIntegerField;
    cdsItemPedidoPRODUTO_ID: TIntegerField;
    adqConsID: TADOQuery;
    adqDelItemPedido: TADOQuery;
    cdsItemPedidoIMG: TLargeintField;
    edtTotal: TcxCurrencyEdit;
    adqAdicional: TADOQuery;
    dspAdicional: TDataSetProvider;
    cdsAddPedidoIMG: TLargeintField;
    cdsAddPedidoVRTOTAITEM: TFloatField;
    adqDelAddPedido: TADOQuery;
    adqUpdAdicionalPedido: TADOQuery;
    adqConsItemPedidoID: TADOQuery;
    styGridPDV: TcxStyleRepository;
    styGridBackgroud: TcxStyle;
    styGridContent: TcxStyle;
    styGridHeader: TcxStyle;
    styGridSelection: TcxStyle;
    cdsAgrupAdicionalimgindex: TIntegerField;
    adqAuxUpdMesa: TADOQuery;
    adqUpdPedido: TADOQuery;
    cdsPedidoImpressao: TClientDataSet;
    cdsPedidoImpressaoEMPRESA: TStringField;
    cdsPedidoImpressaoUNIDADE: TStringField;
    cdsPedidoImpressaoENDERECO: TStringField;
    cdsPedidoImpressaoREFERENCIA: TStringField;
    cdsPedidoImpressaoTIPOPEDIDO: TStringField;
    cdsPedidoImpressaoCONTATO: TStringField;
    cdsPedidoImpressaoVRPEDIDO: TCurrencyField;
    adqItemPedidoF: TADOQuery;
    dspItemPedidoF: TDataSetProvider;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    constructor PCreate(Form: TComponent; Parametros: TParametros); Overload;
    procedure btnGavetaClick(Sender: TObject);
    procedure btnFinalizarPedidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cdsItemPedidoAfterScroll(DataSet: TDataSet);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsItemPedidoAfterPost(DataSet: TDataSet);
    procedure gdbPedidoCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure gdbPedidoCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FParametros: TParametros;
  public
    { Public declarations }
    procedure OnClickCategoriaPDV(Sender: TObject);
    procedure OnClickProdutosPDV(Sender: TObject);
    procedure AtualizaValorPedido;
    procedure AtualizacdsPedido;
  end;

var
  frmPDV_PDV: TfrmPDV_PDV;
  stStatusPedido: String;
  boOk, boJaPostou: Boolean;

implementation

{$R *.dfm}

uses
  lib_mensagem, lib_interface, pdv_adicional, uDmConexao, lib_vmsis, lib_acesso,
  main_base, pdv_confirma_qtde_peso, math, pdv_main, lib_modelo_impressao, StrUtils;

procedure TfrmPDV_PDV.FormShow(Sender: TObject);
var
  Interface_: TInterface; 
  iComp, iGrava: Integer;
begin
  Interface_ := TInterface.Create();

  stStatusPedido := 'A';
  boJaPostou := False;
  boOk := True;
  lblFrom.Caption := FParametros.Caption;
  frmPDV_PDV.Tag  := FParametros.Tag;                  
  panDados.Visible  := FParametros.panDados_Visible;
  scbTotalizador.Align := alCustom;
  scbTotalizador.Height := FParametros.Totalizador_Height;
  scbTotalizador.Align := alTop;
  btnGravar.Visible := FParametros.btnGravar_Visible;
  iGrava := Integer(not FParametros.btnGravar_Visible);

  edtNome.Width := (panDados.Width - edtNome.Left) - btnPesqCliente.Width;

  scbProduto.Height := Trunc(scbGrupo.Height/2)-scbTotalizador.Height;

  adqCategoria.Close;
  adqCategoria.Open;

  adqItemCategoria.Close;
  adqItemCategoria.Open;

  cdsCategoria.Data := dspCategoria.Data;
  cdsItemCategoria.Data  := dspItemCategoria.Data;

  adqItemPedido.Close;
  adqItemPedido.Parameters.ParamByName('P_MESA_ID').Value := FParametros.Tag;
  adqItemPedido.Open;
  cdsItemPedido.Data := dspItemPedido.Data;

  adqAdicional.Close;
  adqAdicional.Parameters.ParamByName('P_PEDIDO_ID').Value := cdsItemPedidoPEDIDO_ID.AsInteger;
  adqAdicional.Open;
  cdsAddPedido.Data := dspAdicional.Data;

  if scbCategoria.ControlCount = 0 then
  begin
    cdsCategoria.First;
    while not cdsCategoria.Eof do
    begin
      Interface_.CriaButtonScrollBox(scbCategoria, cdsCategoria.FieldByName('nmcategoria').AsString,
        OnClickCategoriaPDV, 100, 100, cdsCategoriaid.AsInteger, cilItensPDV, cdsCategoriaimgindex.AsInteger);

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
  AtualizaValorPedido;
end;

procedure TfrmPDV_PDV.FormCreate(Sender: TObject);
var
   region: hrgn;
begin                  
  //Altera o tamanho do formulário para o tamanho da tela
  Height := Screen.Height;
  Width  := Screen.Width;

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
        OnClickProdutosPDV, 150, 150, cdsItemCategoria.FieldByName('ID').AsInteger, cilItensPDV, cdsItemCategoriaIMGINDEX.AsInteger);

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
var
  flQuantidade: Double;
  inGambi: Integer;
  procedure ConfirmaProduto(flQuantidade: Double = 0);
  var
    flRetConfirmaQtdePeso: Double;
  begin
    if cdsItemPedido.Locate('PRODUTO_ID', cdsItemCategoriaPRODUTO_ID.AsInteger, [loCaseInsensitive]) and
      (cdsItemCategoriaIDTIPOMED.AsString <> 'M') and (cdsAddPedido.RecordCount = 0) and (flQuantidade = 0) then
    begin
      cdsItemPedido.Edit;
      flRetConfirmaQtdePeso := ConfirmaQtdePeso(cdsItemCategoriaVRVENDA.AsFloat);
      if flRetConfirmaQtdePeso = 0 then begin
        cdsItemPedido.Cancel;
        Exit;
      end;
      cdsItemPedidoQTITEM.AsFloat  := RoundTo(cdsItemPedidoQTITEM.AsFloat+flRetConfirmaQtdePeso, -3);
      cdsItemPedidoVRTOTAL.AsFloat := RoundTo(cdsItemPedidoQTITEM.AsFloat*cdsItemPedidoVRVENDA.AsFloat, -2);
      boOk := False;
    end else
    begin
      cdsItemPedido.Insert;
      if VarIsNull(cdsItemPedidoMAXID.Value) then
        cdsItemPedidoID.AsInteger := 1
      else
        cdsItemPedidoID.AsInteger := Integer(cdsItemPedidoMAXID.Value)+1;
      cdsItemPedidoVRVENDA.AsFloat := RoundTo(cdsItemCategoriaVRVENDA.AsFloat, -2);
      cdsItemPedidoPRODUTO_ID.AsInteger := cdsItemCategoriaPRODUTO_ID.AsInteger;
      cdsItemPedidoNMPRODUTO.AsString := cdsItemCategoriaNMPRODUTO.AsString;
      if flQuantidade = 0 then
      begin
        if (cdsItemCategoriaIDTIPOMED.AsString = 'M') then
          flRetConfirmaQtdePeso := ConfirmaQtdePeso(cdsItemCategoriaVRVENDA.AsFloat,True)
        else
          flRetConfirmaQtdePeso := ConfirmaQtdePeso(cdsItemCategoriaVRVENDA.AsFloat);
      end else
        flRetConfirmaQtdePeso := flQuantidade;
      if flRetConfirmaQtdePeso = 0 then begin
        cdsItemPedido.Cancel;
        Abort;
      end;
      cdsItemPedidoCARDAPIO_ID.AsInteger := (Sender as TcxButton).Tag;
      cdsItemPedidoQTITEM.AsFloat := RoundTo(flRetConfirmaQtdePeso, -3);
      cdsItemPedidoVRTOTAL.AsFloat := RoundTo(cdsItemCategoriaVRVENDA.AsFloat*flRetConfirmaQtdePeso, -2);
      cdsItemPedidoLOTE_ID.Clear;
      cdsItemPedidoIMG.Value := 0;
                                                                                                            
      boOk := False;
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
      AtualizaValorPedido;
      if frmAdicional.GetBlz then
      begin
        if ((cdsAddPedido.RecordCount > 0) and (cdsItemPedido.State in [dsEdit])) then
        begin
          flQuantidade := cdsItemPedidoQTITEM.AsFloat;
          inGambi := cdsAddPedidoITEMPEDIDO_ID.AsInteger;
          cdsItemPedido.Cancel;
          ConfirmaProduto(flQuantidade-cdsItemPedidoQTITEM.AsFloat);
          cdsAddPedido.Filtered := False;
          cdsAddPedido.Filter := ' QTITEM > 0 AND ITEMPEDIDO_ID = '+IntToStr(inGambi);
          cdsAddPedido.Filtered := True;
          cdsAddPedido.First;
          while not cdsAddPedido.Eof do
          begin
            cdsAddPedido.Edit;
            cdsAddPedidoITEMPEDIDO_ID.AsInteger := cdsItemPedidoID.AsInteger;
            cdsAddPedido.Post;
          end;
          cdsItemPedido.Locate('ID', cdsItemPedidoID.AsInteger, [loCaseInsensitive]);
        end else
        begin
          cdsItemPedido.Post;
        end;
        if cdsAddPedido.State in [dsEdit, dsInsert] then
          cdsAddPedido.Post;
      end else
        cdsItemPedido.Cancel;
    finally
      FreeAndNil(frmAdicional);
    end;
  end else
    if cdsItemPedido.State in [dsEdit, dsInsert] then
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
  Impressao_Nao_Fiscal: TImpressao_Nao_Fiscal;
begin
  inherited;
  Acesso_Perifericos := TAcesso_Perifericos.Create;
  Impressao_Nao_Fiscal := TImpressao_Nao_Fiscal.Create;
  stStatusPedido := 'F';
  try
    btnGravarClick(btnGravar);
    
    AtualizacdsPedido;
    cdsAddPedido.Filtered := False;
    if not Impressao_Nao_Fiscal.Verif_Impressora then
    begin
      if not Confirma(DESEJA_CONTINUAR_PEDIDO) then
        Exit;
    end else
      Impressao_Nao_Fiscal.Layout_Finaliza_Pedido(cdsPedidoImpressao, cdsItemPedido, cdsAddPedido);
    
    Acesso_Perifericos.AbreGaveta;

    adqUpdPedido.Close;
    adqUpdPedido.Parameters.ParamByName('P_ID').Value := adqItemPedido.FieldByName('PEDIDO_ID').Value;
    adqUpdPedido.Parameters.ParamByName('P_IDSTATUSPED').Value := 'F';
    adqUpdPedido.ExecSQL;

    btnCancelarClick(btnCancelar);
  finally
    FreeAndNil(Acesso_Perifericos);
    FreeAndNil(Impressao_Nao_Fiscal);
  end;
end;

procedure TfrmPDV_PDV.btnCancelarClick(Sender: TObject);
begin
  if not boOk then
    if not Confirma(CONFIRMA_PERDA_DADOS) then
      Exit;

  Close;
end;

procedure TfrmPDV_PDV.cdsItemPedidoAfterScroll(DataSet: TDataSet);
begin
  cdsAddPedido.Filtered := False;
  cdsAddPedido.Filter := ' QTITEM > 0 AND ITEMPEDIDO_ID = ' + IntToStr(cdsItemPedidoID.AsInteger);
  cdsAddPedido.Filtered := True;
end;

procedure TfrmPDV_PDV.btnGravarClick(Sender: TObject);
var
  inPedido_ID, inItemPedido_ID: Integer;
begin
  try
    cdsItemPedido.DisableControls;
    cdsAddPedido.DisableControls;    

    adqAuxUpdMesa.Close;
    if stStatusPedido = 'F' then
      adqAuxUpdMesa.Parameters.ParamByName('IDSTATUS').Value := 'L'
    else
      adqAuxUpdMesa.Parameters.ParamByName('IDSTATUS').Value := 'O';
    adqAuxUpdMesa.Parameters.ParamByName('ID').Value := FParametros.Tag;
    adqAuxUpdMesa.ExecSQL;
    
    if adqItemPedido.IsEmpty then
    begin
      adqInsPedido.Close;
      adqInsPedido.Parameters.ParamByName('P_IDTIPOPEDIDO').Value := Copy(FParametros.Caption,1,1);
      case AnsiIndexStr(UpperCase(Copy(FParametros.Caption,1,1)), ['M','D','B']) of
        1,2: begin
              adqInsPedido.Parameters.ParamByName('P_CLIENTE_ID').Value := 1;
              adqInsPedido.Parameters.ParamByName('P_NMCLIENTE').Value  := edtNome.Text;
             end;
        0:   begin
               adqInsPedido.Parameters.ParamByName('P_MESA_ID').Value   := FParametros.Tag;
             end;
      end;
      adqInsPedido.Parameters.ParamByName('P_VRPEDIDO').Value     := StrToFloat(edtTotal.Text);
      adqInsPedido.Parameters.ParamByName('P_IDSTATUSPED').Value  := stStatusPedido;
      adqInsPedido.ExecSQL;

      adqConsID.Close;
      adqConsID.Open;
      inPedido_ID := adqConsID.FieldByName('ID').AsInteger;
    end else
      inPedido_ID := adqItemPedido.FieldByName('PEDIDO_ID').Value;

    //Exclusao adicionais zerados
    frmPDV_PDV.cdsAddPedido.Filtered := False;
    cdsAddPedido.First;
    while not cdsAddPedido.Eof do
    begin
      if cdsAddPedidoQTITEM.Value = 0.0 then
      begin
        adqDelAddPedido.Close;
        adqDelAddPedido.Parameters.ParamByName('P_ITEMPEDIDO_ID').Value := cdsAddPedidoITEMPEDIDO_ID.AsInteger;
        adqDelAddPedido.Parameters.ParamByName('P_ITEM_ID').Value := cdsAddPedidoID.AsInteger;
        adqDelAddPedido.ExecSQL;
      end;
      cdsAddPedido.Next;
    end;                                      
    frmPDV_PDV.cdsAddPedido.Filtered := True;

    //ItemPedido
    cdsItemPedido.Filtered := False;
    cdsItemPedido.First;
    while not cdsItemPedido.Eof do
    begin
      if cdsItemPedidoQTITEM.Value = 0.0 then
      begin
        adqDelItemPedido.Close;
        adqDelItemPedido.Parameters.ParamByName('ID').Value := cdsItemPedido.FieldByName('ID').AsInteger;
        adqDelItemPedido.Parameters.ParamByName('PEDIDO_ID').Value := inPedido_ID;
        adqDelItemPedido.ExecSQL;
      end else
      begin
        inItemPedido_ID := 0;
        if not adqItemPedido.Locate('ID', cdsItemPedidoID.Value, [loCaseInsensitive]) then begin
          adqInsItemPedido.Close;
          adqInsItemPedido.Parameters.ParamByName('P_PEDIDO_ID').Value   := inPedido_ID;
          adqInsItemPedido.Parameters.ParamByName('P_CARDAPIO_ID').Value := cdsItemPedidoCARDAPIO_ID.AsInteger;
    //      adqInsItemPedido.Parameters.ParamByName('P_LOTE_ID').Value     := cdsItemPedidoLOTE_ID.Value;
          adqInsItemPedido.Parameters.ParamByName('P_QTITEM').Value      := cdsItemPedidoQTITEM.AsFloat;
          adqInsItemPedido.Parameters.ParamByName('P_VRVENDA').Value     := cdsItemPedidoVRVENDA.AsFloat;
          adqInsItemPedido.Parameters.ParamByName('P_VRTOTAL').Value     := cdsItemPedidoVRTOTAL.AsFloat;
          adqInsItemPedido.Parameters.ParamByName('P_PRODUTO_ID').Value  := cdsItemPedidoPRODUTO_ID.AsInteger;
          adqInsItemPedido.Parameters.ParamByName('P_IDADICIONAL').Value := cdsItemPedidoIDADICIONAL.AsInteger;
          adqInsItemPedido.ExecSQL;

          adqConsItemPedidoID.Close;
          adqConsItemPedidoID.Open;                       
          inItemPedido_ID := adqConsItemPedidoID.FieldByName('ID').AsInteger;
        end else
        begin
          adqUpdItemPedido.Close;
          adqUpdItemPedido.Parameters.ParamByName('ID').Value  := cdsItemPedidoID.Value;
          adqUpdItemPedido.Parameters.ParamByName('P_CARDAPIO_ID').Value := cdsItemPedidoCARDAPIO_ID.AsInteger;
    //      adqUpdItemPedido.Parameters.ParamByName('P_LOTE_ID').Value     := cdsItemPedidoLOTE_ID.AsInteger;
          adqUpdItemPedido.Parameters.ParamByName('P_QTITEM').Value      := cdsItemPedidoQTITEM.AsFloat;
          adqUpdItemPedido.Parameters.ParamByName('P_VRVENDA').Value     := cdsItemPedidoVRVENDA.AsFloat;
          adqUpdItemPedido.Parameters.ParamByName('P_VRTOTAL').Value     := cdsItemPedidoVRTOTAL.AsFloat;
          adqUpdItemPedido.Parameters.ParamByName('P_IDADICIONAL').Value := cdsItemPedidoIDADICIONAL.AsInteger;
          adqUpdItemPedido.ExecSQL;
        end;
        
        //Adicional
        cdsAddPedido.First;
        while not cdsAddPedido.Eof do
        begin
          if not adqAdicional.Locate('ID;ITEMPEDIDO_ID', VarArrayOf([cdsAddPedidoID.Value,cdsAddPedidoITEMPEDIDO_ID.Value]), [loCaseInsensitive]) then
          begin
            adqInsAdicionalPedido.Close;
            if inItemPedido_ID = 0 then
              adqInsAdicionalPedido.Parameters.ParamByName('P_ITEMPEDIDO_ID').Value := cdsAddPedidoITEMPEDIDO_ID.AsInteger
            else                                                                                      
              adqInsAdicionalPedido.Parameters.ParamByName('P_ITEMPEDIDO_ID').Value := inItemPedido_ID;
            adqInsAdicionalPedido.Parameters.ParamByName('P_ITEM_ID').Value       := cdsAddPedidoID.AsInteger;
            adqInsAdicionalPedido.Parameters.ParamByName('P_QTITEM').Value        := cdsAddPedidoQTITEM.AsFloat;
            adqInsAdicionalPedido.Parameters.ParamByName('P_VALOR').Value         := cdsAddPedidoVRUNITARIO.AsFloat;
            adqInsAdicionalPedido.Parameters.ParamByName('P_VRVENDA').Value       := cdsAddPedidoVRTOTAITEM.AsFloat;
            adqInsAdicionalPedido.ExecSQL;
          end else
          begin
            adqUpdAdicionalPedido.Close;
            adqUpdAdicionalPedido.Parameters.ParamByName('P_ITEMPEDIDO_ID').Value := cdsAddPedidoITEMPEDIDO_ID.AsInteger;
            adqUpdAdicionalPedido.Parameters.ParamByName('P_ITEM_ID').Value       := cdsAddPedidoID.AsInteger;
            adqUpdAdicionalPedido.Parameters.ParamByName('P_QTITEM').Value        := cdsAddPedidoQTITEM.AsFloat;
            adqUpdAdicionalPedido.Parameters.ParamByName('P_VALOR').Value         := cdsAddPedidoVRUNITARIO.AsFloat;
            adqUpdAdicionalPedido.Parameters.ParamByName('P_VRVENDA').Value       := cdsAddPedidoVRTOTAITEM.AsFloat;
            adqUpdAdicionalPedido.ExecSQL;
          end;

          cdsAddPedido.Next;
        end;
      end;

      cdsItemPedido.Next;
    end;
    cdsItemPedido.Filtered := True;

    if stStatusPedido = 'F' then
    begin
      adqItemPedidoF.Close;
      adqItemPedidoF.Parameters.ParamByName('P_PEDIDO_ID').Value := inPedido_ID;
      adqItemPedidoF.Open;
      cdsItemPedido.Data := dspItemPedidoF.Data;
    end else
    begin
      adqItemPedido.Close;
      adqItemPedido.Parameters.ParamByName('P_MESA_ID').Value := FParametros.Tag;
      adqItemPedido.Open;
      cdsItemPedido.Data := dspItemPedido.Data;
    end;

    adqAdicional.Close;
    adqAdicional.Parameters.ParamByName('P_PEDIDO_ID').Value := cdsItemPedidoPedido_ID.AsInteger;
    adqAdicional.Open;
    cdsAddPedido.Data := dspAdicional.Data;

    cdsItemPedido.First;

    cdsItemPedido.EnableControls;
    cdsAddPedido.EnableControls;

    boOk := True;
  except
    cdsItemPedido.EnableControls;
    cdsAddPedido.EnableControls;
    Raise;
  end;
end;

procedure TfrmPDV_PDV.cdsItemPedidoAfterPost(DataSet: TDataSet);
begin
  if not boJaPostou then
    AtualizaValorPedido;
  boJaPostou := False;
end;

procedure TfrmPDV_PDV.AtualizaValorPedido;
begin
  if not VarIsNull(cdsAddPedidoSUMVRTOTAL.Value) then
  begin
    cdsItemPedido.Edit;
    cdsItemPedidoVRTOTAL.AsFloat := (cdsItemPedidoQTITEM.AsFloat * cdsItemPedidoVRVENDA.AsFloat) + StrToFloat(cdsAddPedidoSUMVRTOTAL.Value);
    boJaPostou := True;
    cdsItemPedido.Post;
  end;

  if VarIsNull(cdsItemPedidoSUMVRTOTAL.Value) then
    edtTotal.Text := '0,00'
  else
    edtTotal.Text := formatfloat('###,###,##0.00', cdsItemPedidoSUMVRTOTAL.Value);
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
        AtualizaValorPedido;
      finally
        FreeAndNil(frmAdicional);
      end;
    end;
    boOk := False;
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
      cdsAddPedido.First;
      while not cdsAddPedido.Eof do
      begin
        cdsAddPedido.Edit;
        cdsAddPedidoQTITEM.AsFloat := 0.0;
        cdsAddPedido.Post;
      end;
      cdsItemPedido.Edit;
      cdsItemPedido.FieldByName('QTITEM').Value := 0.0;
      cdsItemPedido.Post;

      cdsItemPedido.First;

      //Super ultra gambiarra para não dar o erro esporadico ao "excluir" um item com adicional
      Abort;

      boOk := False;
    end;
  end;
end;

procedure TfrmPDV_PDV.AtualizacdsPedido;
begin
  if cdsPedidoImpressao.IsEmpty then
    cdsPedidoImpressao.Insert
  else
    cdsPedidoImpressao.Edit;

  cdsPedidoImpressaoEMPRESA.AsString := frmMainBase.NomeEmpresa;
  cdsPedidoImpressaoUNIDADE.AsString := frmMainBase.NomeUnidade;

  case AnsiIndexStr(UpperCase(Copy(FParametros.Caption,1,1)), ['M','D','B']) of
    0: begin
        //Mesa
        cdsPedidoImpressaoTIPOPEDIDO.AsString := 'M';
        cdsPedidoImpressaoENDERECO.AsString   := Copy(FParametros.Caption, 5, Length(FParametros.Caption)-5);
       end;
    1: begin
        //Delivery                                   
        cdsPedidoImpressaoTIPOPEDIDO.AsString := 'D';
        //cdsPedidoImpressaoENDERECO.AsString   := 
        cdsPedidoImpressaoCONTATO.AsString    := edtTelefone.Text + ' - ' + edtNome.Text;
        //cdsPedidoImpressaoREFERENCIA.AsString :=
       end;
    2: begin
        //Balcão
        cdsPedidoImpressaoTIPOPEDIDO.AsString := 'B';
        cdsPedidoImpressaoCONTATO.AsString    := edtTelefone.Text + ' - ' + edtNome.Text;
       end;
  end;
  cdsPedidoImpressaoVRPEDIDO.AsFloat := StrToFloat(edtTotal.Text);

  cdsPedidoImpressao.Post;
end;

procedure TfrmPDV_PDV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

end.
