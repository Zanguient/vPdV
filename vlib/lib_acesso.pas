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
    public
      procedure AddPermissao(const modulo : String; permissao : TPermissoes);
      constructor create(usuario : String);
      destructor destroy; override;
    end;

implementation

uses IdHash;

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
    if tbRotina.Cds.IsEmpty then
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
  AddRotina('balanca', 'Abrir balança', False);
end;

{ TAcessoUsuario }

procedure TAcessoUsuario.AddPermissao(const modulo: String;
  permissao: TPermissoes);
begin
  FdbRotina.RemoverTodosParametros;
  FdbRotina.AddParametro('modulo', modulo);
  FdbRotina.Select(['id']);

  if FdbRotina.Cds.IsEmpty then
    raise Exception.Create('O módulo especificado não existe.' + ' Modulo : ' + modulo);

  FDbPermissao.RemoverTodosParametros;
  FDbPermissao.AddParametro('modulo', modulo);
  FDbPermissao.AddParametro('descricao', GetEnumName(TypeInfo(TPermissoes), Integer(permissao)));

  FDbPermissao.Select(['id']);

  if not FDbPermissao.Cds.IsEmpty then
    Exit;

  FDbPermissao.AddParametro('funcionario_id', FUsuario.GetVal('id'));
  FDbPermissao.AddParametro('id_rotina', FdbRotina.GetVal('id'));
  FDbPermissao.Insert;
  
end;

constructor TAcessoUsuario.create(usuario: String);

begin
    FUsuario := TObjetoDB.create('funcionario');
    FUsuario.AddParametro('usuario', usuario);
    FUsuario.Select(['usuario', 'nome', 'id', 'senha']);

    if(FUsuario.Cds.IsEmpty) then
      raise Exception.Create('Usuário informado não existe.');

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

end.
