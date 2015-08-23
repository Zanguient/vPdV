unit autenticacao;

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
  dxSkinXmas2008Blue, Menus, StdCtrls, cxButtons, cxMaskEdit, cxTextEdit,
  cxLabel, lib_mensagem, lib_acesso;

type
  TfrmAutenticacao = class(TForm)
    lblUsuario: TcxLabel;
    lblSenha: TcxLabel;
    edtUsuario: TcxTextEdit;
    edtSenha: TcxMaskEdit;
    btnLogin: TcxButton;
    btnCancelar: TcxButton;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FPossuiAcesso : Boolean;
  public
    { Public declarations }
    FPermissao : TPermissoes;
    FModulo : String;
    property PossuiAcesso : Boolean read FPossuiAcesso;
  end;

var
  frmAutenticacao: TfrmAutenticacao;
  function UsuarioAutenticado(const modulo : string; const permissao : TPermissoes) : Boolean;

implementation
{$R *.dfm}

function UsuarioAutenticado(const modulo : string; const permissao : TPermissoes) : Boolean;
begin
  try
    frmAutenticacao := TfrmAutenticacao.Create(Application);
    frmAutenticacao.FModulo := modulo;
    frmAutenticacao.FPermissao := permissao;
    frmAutenticacao.ShowModal;
    Result := frmAutenticacao.FPossuiAcesso;
  finally
    frmAutenticacao.Release;
  end;
end;

procedure TfrmAutenticacao.btnLoginClick(Sender: TObject);
var
 AcessoUsr : TAcessoUsuario;
begin
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

  AcessoUsr := TAcessoUsuario.create(edtUsuario.Text);
  try
    try
      if not AcessoUsr.Logado(edtSenha.Text) then
      begin
        FPossuiAcesso := False;
      end
      else
        FPossuiAcesso := AcessoUsr.PossuiPermissao(FModulo, FPermissao);
    except
      FPossuiAcesso := False;
      raise;
    end;
  finally
    FreeAndNil(AcessoUsr);
  end;

  if not FPossuiAcesso then
  begin
    Aviso('Usuário não possui permissão para realizar esta operação.');
    Abort;
  end;

  close;
end;

procedure TfrmAutenticacao.btnCancelarClick(Sender: TObject);
begin
  FPossuiAcesso := False;
  Close;
end;

procedure TfrmAutenticacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnLogin.Click
  else if Key = VK_ESCAPE then
     btnCancelar.Click;

end;

end.
