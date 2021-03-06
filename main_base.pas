unit main_base;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxNavBar2Painter, dxNavBarCollns, cxClasses,
  dxNavBarBase, dxNavBar, dxSkinscxPCPainter, cxPC, ImgList, dxSkinsForm,
  dxNavBarStyles, ExtCtrls, lib_acesso;

type
  TfrmMainBase = class(TForm)
    nbMain_Base: TdxNavBar;
    pgcPrincipal: TcxPageControl;
    nbgCadastro: TdxNavBarGroup;
    nbiCliente: TdxNavBarItem;
    nbgSair: TdxNavBarGroup;
    nbgPDV: TdxNavBarGroup;
    nbgEstoque: TdxNavBarGroup;
    nbiEntrada: TdxNavBarItem;
    nbiSaida: TdxNavBarItem;
    cilMenu: TcxImageList;
    nbiFornecedor: TdxNavBarItem;
    sty_menu_lat: TdxNavBarStyleItem;
    sty_menu_lat_header: TdxNavBarStyleItem;
    sty_menu_lat_active: TdxNavBarStyleItem;
    sty_menu_lat_hottra: TdxNavBarStyleItem;
    nbMain_BaseStyleItem1: TdxNavBarStyleItem;
    nbMain_BaseStyleItem2: TdxNavBarStyleItem;
    nbMain_BaseStyleItem3: TdxNavBarStyleItem;
    nbMain_BaseStyleItem4: TdxNavBarStyleItem;
    nbiCancelarPedido: TdxNavBarItem;
    nbgConfiguracoes: TdxNavBarGroup;
    nbiSincronizacao: TdxNavBarItem;
    tmSincronizacao: TTimer;
    nbiContrroleAcesso: TdxNavBarItem;
    procedure nbgSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nbgPDVClick(Sender: TObject);
    procedure nbiClienteClick(Sender: TObject);
    procedure nbiFornecedorClick(Sender: TObject);
    procedure nbiCancelarPedidoClick(Sender: TObject);
    procedure nbiSincronizacaoClick(Sender: TObject);
    procedure tmSincronizacaoTimer(Sender: TObject);
    procedure nbiEntradaClick(Sender: TObject);
    procedure nbiContrroleAcessoClick(Sender: TObject);
  private
    { Private declarations }
//    procedure InvocadordeBpl(stClasse: String);
    FAcessoUsuario: TAcessoUsuario; 
    FidEmpresa : Integer;
    FidPais : Integer;
    FidEstado : Integer;
    FIdCidade : Integer;
    FidBairro : Integer;
    FidAlmoxarifado : Integer;
    FidUnidade : Integer;
    FIdFuncionario : Integer;
    Fusuario : String;
    FNomeEmpresa : String;
    FNomeUnidade : String;
    FidUsuario : Integer;

  public
    { Public declarations }

    property IdUsuario : Integer read FIdUsuario;
    property NomeUsuario : String read FUsuario;
    property IdEmpresa : Integer read FIdEmpresa;
    property NomeEmpresa : String read FNomeEmpresa;
    property IdUnidade : Integer read FidUnidade;
    property NomeUnidade : String read FNomeUnidade;
  end;

var
  frmMainBase: TfrmMainBase;

procedure CriarMainForm(const IdUsuario, IdEmpresa, IdUnidade : Integer;
  const NomeUsuario, NomeEmpresa, NomeUnidade : string);

implementation

{$R *.dfm}

uses
   libframes, pdv_main, pdv_aberturacaixa, pdv_abertura_fechamento_caixa, uvCadastroClienteFrame,
   uvCadastroFornecedorFrame, lib_db, pdv_cancelar_pedido, uParametrosSincronizacao, lib_sincronizacao,
   uvEstoqueEntradaFrame, lib_mensagem, uControleAcesso;


procedure CriarMainForm(const IdUsuario, IdEmpresa, IdUnidade : Integer;
  const NomeUsuario, NomeEmpresa, NomeUnidade : string);
begin
  Application.CreateForm(TfrmMainBase, frmMainBase);
  frmMainBase.FIdEmpresa := IdEmpresa;
  frmMainBase.FidUsuario := IdUsuario;
  frmMainBase.FidUnidade := IdUnidade;
  frmMainBase.FNomeEmpresa := NomeEmpresa;
  frmMainBase.FNomeUnidade := NomeUnidade;
  frmMainBase.Fusuario := NomeUsuario;
  frmMainBase.FAcessoUsuario:= TAcessoUsuario.create(NomeUsuario);
end;

procedure TfrmMainBase.nbgSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMainBase.FormCreate(Sender: TObject);
var
  region: hrgn;
  db : TObjetoDB;
  dbSincronizacao: TObjetoDB;
begin
  //Altera o tamanho do formulário para o tamanho da tela
  Height := Screen.Height;
  Width  := Screen.Width;

  DoubleBuffered := True;
  region := CreateRoundRectRgn(0, 0, width, height, 15, 15);
  SetWindowRgn(handle, region, true);

  db := TObjetoDB.create('empresa');
  try
    //dados da empresa
    db.AddSqlAdicional(' LIMIT 1 ');
    db.Select(['ID', 'NMEMPRESA']);
    FIdEmpresa := db.GetVal('ID');
    FNomeEmpresa := db.GetVal('NMEMPRESA')
  finally
    FreeAndNil(db);
  end;

  dbSincronizacao:= TObjetoDB.create('ParametrosSincronizacao');
  try
    dbSincronizacao.Select(['IntervaloHora', 'IntervaloMinuto']);
    try
      tmSincronizacao.Interval:= ((dbSincronizacao.GetVal('IntervaloHora') * 3600) +
        (dbSincronizacao.GetVal('IntervaloMinuto') * 60)) * 1000;
      tmSincronizacao.Enabled:= True;
    except
      tmSincronizacao.Enabled:= False;
    end
  finally
    FreeAndNil(dbSincronizacao);
  end;


end;

procedure TfrmMainBase.nbgPDVClick(Sender: TObject);
begin
  FAcessoUsuario.BloquearUsuarioSemPermissao(MODULO_VENDA, TpmVisualizar);
  if CaixaAberto then
    TAbasNavegacao.CriarAba(pgcPrincipal, TfrmPDVMain);
end;

procedure TfrmMainBase.nbiClienteClick(Sender: TObject);
begin
  FAcessoUsuario.BloquearUsuarioSemPermissao(MODULO_CLIENTE, TpmVisualizar);
  TAbasNavegacao.CriarAba(pgcPrincipal, TvCadastroCliente);
end;

procedure TfrmMainBase.nbiFornecedorClick(Sender: TObject);
begin
  FAcessoUsuario.BloquearUsuarioSemPermissao(MODULO_FORNECEDOR, TpmVisualizar);
  TAbasNavegacao.CriarAba(pgcPrincipal, TvCadastroFornecedorFrame);
end;

procedure TfrmMainBase.nbiCancelarPedidoClick(Sender: TObject);
begin
  FAcessoUsuario.BloquearUsuarioSemPermissao(MODULO_VENDA, TpmExcluir);
  TAbasNavegacao.CriarAba(pgcPrincipal, TvCancelaPedido);
end;

procedure TfrmMainBase.nbiSincronizacaoClick(Sender: TObject);
begin
   FAcessoUsuario.BloquearUsuarioSemPermissao(MODULO_SINCRONIZAR, TpmVisualizar);
   TAbasNavegacao.CriarAba(pgcPrincipal, TParametrosSincronizacao)
end;

procedure TfrmMainBase.tmSincronizacaoTimer(Sender: TObject);
begin
  TSincronizarTabelas.Sincronizar(True);
end;

procedure TfrmMainBase.nbiEntradaClick(Sender: TObject);
begin
  FAcessoUsuario.BloquearUsuarioSemPermissao(MODULO_ESTOQUE_ENTRADA, TpmVisualizar);
  TAbasNavegacao.CriarAba(pgcPrincipal, TvEstoqueEntradaFrame);
end;

procedure TfrmMainBase.nbiContrroleAcessoClick(Sender: TObject);
begin
  FAcessoUsuario.BloquearUsuarioSemPermissao(MODULO_CONTROLE_ACESSO, TpmVisualizar);
  TAbasNavegacao.CriarAba(pgcPrincipal, TframeControleAcesso);
end;

end.
