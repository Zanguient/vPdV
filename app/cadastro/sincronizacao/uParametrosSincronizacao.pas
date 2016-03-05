unit uParametrosSincronizacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, main_base;

type
  TParametrosSincronizacao = class(TFrame)
    btnConfirmar: TcxButton;
    btnCancelar: TcxButton;
    edtIp: TEdit;
    Label1: TLabel;
    gpbTempoSinc: TGroupBox;
    Label2: TLabel;
    edtHoras: TEdit;
    Minutos: TLabel;
    edtMinutos: TEdit;
    btnSincronizar: TcxButton;
    lblNomeFrame: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ObterDados;
    procedure SalvarDados;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses lib_db, lib_sincronizacao, lib_mensagem;

{$R *.dfm}

{ TParametrosSincronizacao }

constructor TParametrosSincronizacao.Create(AOwner: TComponent);
begin
  inherited;
  ObterDados;
end;

procedure TParametrosSincronizacao.ObterDados;
var
  getDados: TObjetoDB;
begin
  getDados:= TObjetoDB.create('ParametrosSincronizacao');
  try
    getDados.Select(['IntervaloHora', 'IntervaloMinuto', 'IpSincronizacao']);
    edtIp.Text:= getDados.GetVal('IpSincronizacao');
    edtHoras.Text:= getDados.GetVal('IntervaloHora');
    edtMinutos.Text:= getDados.GetVal('IntervaloMinuto');
  finally
    FreeAndNil(getDados);
  end;
end;

procedure TParametrosSincronizacao.SalvarDados;
var
  setDados: TObjetoDB;
  vazio: Boolean;
begin
  setDados:= TObjetoDB.create('ParametrosSincronizacao');
  try
    setDados.Select(['id']);
    vazio:= setDados.IsEmpty;
    if vazio then
    begin
      setDados.AddParametro('IntervaloHora', edtHoras.Text);
      setDados.AddParametro('IntervaloMinuto', edtMinutos.Text);
      setDados.AddParametro('IpSincronizacao', edtIp.Text);
      setDados.Insert;
    end
    else
    begin
      setDados.AddParametroNewValueUp('IntervaloHora', edtHoras.Text);
      setDados.AddParametroNewValueUp('IntervaloMinuto', edtMinutos.Text);
      setDados.AddParametroNewValueUp('IpSincronizacao', edtIp.Text);
      setDados.Update;
    end;
    frmMainBase.tmSincronizacao.Interval:= (( StrToInt(edtHoras.Text) * 3600) +
      (StrToInt(edtMinutos.Text) * 60)) * 1000;
    Aviso('Dados salvos com sucesso!');
  finally
    FreeAndNil(setDados);
  end;
end;

procedure TParametrosSincronizacao.btnCancelarClick(Sender: TObject);
begin
   ObterDados;
end;

procedure TParametrosSincronizacao.btnConfirmarClick(Sender: TObject);
begin
  SalvarDados;
end;

procedure TParametrosSincronizacao.btnSincronizarClick(Sender: TObject);
var
  msg: string;
begin
  
  msg:= TSincronizarTabelas.Sincronizar(True);
  if msg <> EmptyStr then
     Aviso('Ocorreu um erro ao sincronizar.' + #13 + msg)
  else
    Aviso('Sincronização realizada com suscesso');
end;


end.
