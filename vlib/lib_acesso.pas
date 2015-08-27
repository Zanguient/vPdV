unit lib_acesso;

interface

uses IdHashMessageDigest, Windows, Messages, sysutils, lib_db, TypInfo;

  type
    TPermissoes = (TpmExcluir, TpmInserir, TpmEditar, TpmVisualizar, TpmProcessar);
    Tcriptografia = class
    public
       class function MD5(const texto : string) : string;
    end;

    TAcesso = class
      class procedure AddRotina(const modulo, descricao : String; const visivel : Boolean);
      class procedure AddRotinas;
    end;

    TAcessoUsuario = class
    private
      FUsuario : TObjetoDB;
      FDbPermissao : TObjetoDB;
      FdbRotina : TObjetoDB;
      FUsuarioLogin : String;
      FIdUsuario : Integer;
    public
      property Usuario : String read FUsuarioLogin;
      property IdUsuario : Integer read FIdUsuario;
      
      procedure AddPermissao(const modulo : String; permissao : TPermissoes);
      function PossuiPermissao(const modulo : String; permissao : TPermissoes) : Boolean;
      function Autenticado(const modulo : String; permissao : TPermissoes) : Boolean;
      function Logado(const senha : string) : boolean;
      constructor create(usuario : String);
      destructor destroy; override;
    end;

implementation

uses IdHash, autenticacao, lib_mensagem;

{ Tcriptografia }

class function Tcriptografia.MD5(const texto: string): string;
var
  imd5 : TIdHashMessageDigest5;
begin
  imd5 := TIdHashMessageDigest5.Create;
  try
    Result := imd5.AsHex(imd5.HashValue(texto));
  finally
    FreeAndNil(imd5);
  end;
end;

{ TAcesso }

class procedure TAcesso.AddRotina(const modulo, descricao: String;
  const visivel: Boolean);
var
  tbRotina : TObjetoDB;  
begin
  tbRotina := TObjetoDB.create('rotina');
  try
    tbRotina.AddParametro('modulo', modulo);
    tbRotina.Select(['id']);
    if tbRotina.IsEmpty then
    begin
      tbRotina.AddParametro('descricao', descricao);

      if visivel then
        tbRotina.AddParametro('visivel', 'S')
      else
        tbRotina.AddParametro('visivel', 'N');

      tbRotina.Insert;
    end;
  finally
    FreeAndNil(tbRotina);
  end;
end;

class procedure TAcesso.AddRotinas;
begin
  AddRotina('gaveta', 'Abrir balança', False);
end;

{ TAcessoUsuario }

procedure TAcessoUsuario.AddPermissao(const modulo: String;
  permissao: TPermissoes);
begin
  FdbRotina.RemoverTodosParametros;
  FdbRotina.AddParametro('modulo', modulo);
  FdbRotina.Select(['id']);

  if FdbRotina.IsEmpty then
    raise Exception.Create('O módulo especificado não existe.' + ' Modulo : ' + modulo);

  FDbPermissao.RemoverTodosParametros;
  FDbPermissao.AddParametro('descricao', GetEnumName(TypeInfo(TPermissoes), Integer(permissao)));

  FDbPermissao.Select(['id']);

  if not FDbPermissao.IsEmpty then
    Exit;

  FDbPermissao.AddParametro('funcionario_id', FUsuario.GetVal('id'));
  FDbPermissao.AddParametro('id_rotina', FdbRotina.GetVal('id'));
  FDbPermissao.Insert;
  
end;

function TAcessoUsuario.Autenticado(const modulo: String;
  permissao: TPermissoes): Boolean;
begin
  Result := UsuarioAutenticado(modulo, permissao);
end;

constructor TAcessoUsuario.create(usuario: String);

begin
    FUsuario := TObjetoDB.create('funcionario');
    FUsuario.AddParametro('usuario', usuario);
    FUsuario.Select(['usuario', 'nome', 'id', 'senha']);

    if(FUsuario.IsEmpty) then
    begin
      Aviso('Usuário informado não existe.');
      Abort;
    end;

    FUsuarioLogin := FUsuario.GetVal('usuario');
    FIdUsuario := FUsuario.GetVal('id');

    FDbPermissao := TObjetoDb.create('permusr');
    FdbRotina := TObjetoDb.create('rotina');
end;

destructor TAcessoUsuario.destroy;
begin
  FreeAndNil(FdbRotina);
  FreeAndNil(FdbPermissao);
  FreeAndNil(FUsuario);
  inherited destroy;
end;

function TAcessoUsuario.Logado(const senha: string): boolean;
begin
  Result := (senha = FUsuario.GetVal('senha'));
end;

function TAcessoUsuario.PossuiPermissao(const modulo: String;
  permissao: TPermissoes): Boolean;
begin
  FdbRotina.RemoverTodosParametros;
  FdbRotina.AddParametro('modulo', modulo);
  FdbRotina.Select(['id']);
  Result := not FdbRotina.IsEmpty;

  if not Result then
    Exit;

  FDbPermissao.RemoverTodosParametros;
  FDbPermissao.AddParametro('id_rotina', FdbRotina.GetVal('id'));
  FDbPermissao.AddParametro('funcionario_id', FUsuario.GetVal('id'));
  FDbPermissao.AddParametro('descricao', GetEnumName(TypeInfo(TPermissoes), Integer(permissao)));

  FDbPermissao.Select(['id']);
  Result := not FDbPermissao.IsEmpty;
end;

end.
