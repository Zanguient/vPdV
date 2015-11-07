unit login_base;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxImage, cxProgressBar, Menus, ExtCtrls, StdCtrls,
  cxButtons, Gauges, dxGDIPlusClasses, cxLabel, cxTextEdit, cxMaskEdit;

type
  TfrmLoginBase = class(TForm)
    btnLogin: TcxButton;
    imgLogin_Fundo: TImage;
    gauBarProgress: TGauge;
    panMaxMin: TPanel;
    btnMinimiza: TcxButton;
    btnFechar: TcxButton;
    lblUsuario: TcxLabel;
    lblSenha: TcxLabel;
    edtSenha: TcxMaskEdit;
    edtUsuario: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnMinimizaClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
    FidEmpresa : Integer;
{    FidPais : Integer;
    FidEstado : Integer;
    FIdCidade : Integer;
    FidBairro : Integer;}
    FidAlmoxarifado : Integer;
    FidUnidade : Integer;
    FIdFuncionario : Integer;
    Fusuario : String;
    FNomeEmpresa : String;
    FNomeUnidade : String;
    FLogado : Boolean;
    procedure WMov_tela(var Msg: TMessage);
    message WM_NChitTest;
  public
    { Public declarations }
    function GetLogado: Boolean;
    procedure ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);
    property IdUsuario : Integer read FIdFuncionario;
    property NomeUsuario : String read FUsuario;
    property IdEmpresa : Integer read FIdEmpresa;
    property NomeEmpresa : String read FNomeEmpresa;
    property IdUnidade : Integer read FidUnidade;
    property NomeUnidade : String read FNomeUnidade;
  end;

var
  frmLoginBase: TfrmLoginBase;

implementation

{$R *.dfm}

uses
   lib_mensagem, lib_db, lib_acesso, lib_cadastros_iniciais, lib_sincronizacao;

{ TfrmLoginBase }

function TfrmLoginBase.GetLogado: Boolean;
begin
  Result := FLogado;
end;

procedure TfrmLoginBase.FormCreate(Sender: TObject);
var
  region: hrgn;
begin
  DoubleBuffered := True;
  region := CreateRoundRectRgn(0, 0, width, height, 15, 15);
  SetWindowRgn(handle, region, true);
  ArredondarComponente(btnLogin,10);
end;

procedure TfrmLoginBase.WMov_tela(var Msg: TMessage);
begin
  if GetAsyncKeyState(VK_LBUTTON) < 0 then
    Msg.Result := HTCAPTION
  else
    Msg.Result := HTCLIENT;
end;

procedure TfrmLoginBase.btnMinimizaClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfrmLoginBase.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmLoginBase.ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Componente do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Radius, Radius);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

procedure TfrmLoginBase.edtUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in [#13]) then
  begin
    if (edtSenha.Text = '') then
    begin
      Aviso(INFORMAR_SENHA);
      edtSenha.SetFocus;
    end
    else
      btnLoginClick(btnLogin);
  end;
end;

procedure TfrmLoginBase.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in [#13]) then
  begin
    if (edtUsuario.Text = '') then
    begin
      Aviso(INFORMAR_USUARIO);
      edtUsuario.SetFocus;
    end
    else
      btnLoginClick(btnLogin);
  end;
end;

procedure TfrmLoginBase.btnLoginClick(Sender: TObject);
var
  usrAcesso :  TAcessoUsuario;
  CadastrosIniciais : TCadastrosIniciais;
  db : TObjetoDB;
begin
  FLogado := False;

  CadastrosIniciais := TCadastrosIniciais.Create;
  try
    try
      CadastrosIniciais.Executar;
      FidEmpresa := CadastrosIniciais.FidEmpresa;
      FidAlmoxarifado := CadastrosIniciais.FidAlmoxarifado;
      FidUnidade := CadastrosIniciais.FidUnidade;
      FNomeEmpresa := CadastrosIniciais.FNomeEmpresa;
      FNomeUnidade := CadastrosIniciais.FNomeUnidade;
    except
      //cala boca
    end
  finally
    FreeAndNil(CadastrosIniciais);
  end;

  if Trim(edtUsuario.Text) = EmptyStr then
  begin
    Aviso('Informe o campo Usuário.');
    edtUsuario.SetFocus;
    Abort;
  end;

  if Trim(edtSenha.Text) = EmptyStr then
  begin
    Aviso('Informe o campo Senha.');
    edtSenha.SetFocus;
    Abort;
  end;

  usrAcesso := TAcessoUsuario.create(edtUsuario.Text);
  try
    if(not usrAcesso.Logado(edtSenha.Text)) then
    begin
      Aviso('Senha ou usuário inválidos.');
      Abort;
    end;

    FUsuario := usrAcesso.Usuario;
    FIdFuncionario := usrAcesso.IdUsuario;

    TSincronizarTabelas.Sincronizar(False);
  finally
    FreeAndNil(usrAcesso);
  end;


  FLogado := True;
  Close;
end;

end.

