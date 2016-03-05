unit uControleAcesso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvPadraoFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, DB, ADODB, StdCtrls, cxButtons, ExtCtrls,
  DBClient, DBCtrls, Grids, DBGrids;

type
  TframeControleAcesso = class(TvPadraoFrame)
    cdsFuncionario: TClientDataSet;
    cdsFuncionarioNome: TStringField;
    cdsFuncionarioid: TIntegerField;
    cdsRotina: TClientDataSet;
    cdsRotinaid: TIntegerField;
    cdsRotinamodulo: TStringField;
    cdsRotinadescricao: TStringField;
    cdsRotinavisivel: TStringField;
    GroupBox1: TGroupBox;
    dsFuncionario: TDataSource;
    dbgFuncionarios: TDBGrid;
    dsRotina: TDataSource;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    dbgRotina: TDBGrid;
    GroupBox3: TGroupBox;
    chkProcessar: TCheckBox;
    chkVisualizar: TCheckBox;
    chkExcluir: TCheckBox;
    chkEditar: TCheckBox;
    chkInserir: TCheckBox;
    cdsFuncionariousuario: TStringField;
    cbtnSalvar: TcxButton;
    procedure cdsRotinaAfterScroll(DataSet: TDataSet);
    procedure cdsFuncionarioAfterScroll(DataSet: TDataSet);
    procedure cbtnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarFuncionarios;
    procedure CarregarRotinas;
    procedure CarregarPermissoes(const usuario: string; const modulo: string);
    procedure AtualizarPermissoes(const usuario: string; const modulo: String);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

  end;

var
  frameControleAcesso: TframeControleAcesso;

implementation

uses lib_db, lib_acesso, lib_mensagem;

{$R *.dfm}

{ TframeControleAcesso }

procedure TframeControleAcesso.AtualizarPermissoes(const usuario: string; const modulo: String);
var
  acesso: TAcessoUsuario;
  procedure InserirExcluirPermissao(tipo: TPermissoes; Permitir: Boolean);
  var
    acesso: TAcessoUsuario;
  begin
    acesso:= TAcessoUsuario.create(usuario);
    try
      if Permitir then
        acesso.AddPermissao(modulo, tipo)
      else
        acesso.RemoverPermissao(modulo, tipo);
    finally
      FreeAndNil(acesso);
    end;
  end;
begin
   InserirExcluirPermissao(TpmProcessar, chkProcessar.Checked);
   InserirExcluirPermissao(TpmVisualizar, chkVisualizar.Checked);
   InserirExcluirPermissao(TpmExcluir, chkExcluir.Checked);
   InserirExcluirPermissao(TpmEditar, chkEditar.Checked);
   InserirExcluirPermissao(TpmInserir, chkInserir.Checked);
   Aviso('Dados salvos com sucesso!');
end;

procedure TframeControleAcesso.CarregarFuncionarios;
var
  tbFuncionario: TObjetoDB;
begin
  tbFuncionario:= TObjetoDB.create('Funcionario');
  try
    tbFuncionario.Select(['nome', 'id', 'usuario']);
    cdsFuncionario.Data:= tbFuncionario.GetData;
  finally
    FreeAndNil(tbFuncionario);
  end;
end;

procedure TframeControleAcesso.CarregarPermissoes(
  const usuario: string; const modulo: String);
var
  acesso: TAcessoUsuario;
begin
  acesso:= TAcessoUsuario.create(usuario);
  try
    chkProcessar.Checked:= acesso.PossuiPermissao(modulo, TpmProcessar);
    chkVisualizar.Checked:= acesso.PossuiPermissao(modulo, TpmVisualizar);
    chkExcluir.Checked:= acesso.PossuiPermissao(modulo, TpmExcluir);
    chkEditar.Checked:= acesso.PossuiPermissao(modulo, TpmEditar);
    chkInserir.Checked:= acesso.PossuiPermissao(modulo, TpmInserir);
  finally
    FreeAndNil(acesso);
  end;

end;

procedure TframeControleAcesso.CarregarRotinas;
var
  tbRotina: TObjetoDB;
begin
  tbRotina:= TObjetoDB.create('Rotina');
  try
    tbRotina.Select(['id', 'modulo', 'descricao', 'visivel']);
    cdsRotina.Data:= tbRotina.GetData;
  finally
    FreeAndNil(tbRotina);
  end;
end;

constructor TframeControleAcesso.Create(AOwner: TComponent);
begin
  inherited;
   CarregarFuncionarios;
   CarregarRotinas;
end;

procedure TframeControleAcesso.cdsRotinaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  CarregarPermissoes(cdsFuncionariousuario.AsString, cdsRotinamodulo.AsString);
end;

procedure TframeControleAcesso.cdsFuncionarioAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  CarregarPermissoes(cdsFuncionariousuario.AsString, cdsRotinamodulo.AsString);
end;

procedure TframeControleAcesso.cbtnSalvarClick(Sender: TObject);
begin
  inherited;
  AtualizarPermissoes(cdsFuncionariousuario.AsString, cdsRotinamodulo.AsString);
end;

end.
