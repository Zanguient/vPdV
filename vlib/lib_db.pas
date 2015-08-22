unit lib_db;

interface
uses Windows, Messages, SysUtils, Variants, Classes, ADODB, uDmConexao, DBClient, Provider;

  type
    TMapaValor = class
    protected
       FChave : String;
       FValor : Variant;
    public
       constructor create(const chave : string; valor : variant);
       destructor destroy;override;
    end;

    TListaMapaValor = class
    private
      FlistaValor : TList;
    public
      procedure Add(const chave : string; valor : Variant);
      procedure Remove(const index : Integer); overload;
      procedure Remove(const chave : string); overload;
      function GetValue(const index : Integer): Variant; overload;
      function GetValue(const chave : string): Variant; overload;
      function GetKey(const index : integer): string;
      function Count : Integer;
      procedure Clear;
      constructor create;
      destructor destroy; override;
    end;

    TObjetoDB = class(TObject)
    private
      Fquery : TADOQuery;
      FTabela : String;
      FParametros : TListaMapaValor;
      Fdsp : TDataSetProvider;
      function GetSQLWhere : String;
      function GetSQlInsert : String;
      procedure SetParams;
    public
      Cds : TClientDataSet;
      procedure AddParametro(const field : string; valor : variant);
      procedure RemoverParametro(const index : Integer); overload;
      procedure RemoverParametro(const chave : String); overload;
      procedure RemoverTodosParametros;
      procedure Select(fields : array of string);
      procedure Insert();
      function GetVal(const field : String): variant;
      constructor create(const NomeTabela : String);
      destructor destroy; override;
    end;



implementation


{ TObjetoDB }

procedure TObjetoDB.AddParametro(const field: string; valor: variant);
begin
  FParametros.Add(field, valor);
end;

constructor TObjetoDB.create(const NomeTabela : String);
begin
  FTabela := NomeTabela;
  Fquery := TADOQuery.Create(nil);
  Fdsp := TDataSetProvider.Create(nil);
  Cds := TClientDataSet.Create(nil);
  FParametros := TListaMapaValor.create;
  Fquery.Connection := dmConexao.adoConexaoBd;

  Fdsp.DataSet := Fquery;
  Cds.ProviderName := Fdsp.Name;
end;

destructor TObjetoDB.destroy;
begin
  FreeAndNil(Fquery);
  FreeAndNil(FParametros);
  FreeAndNil(fdsp);
  FreeAndNil(Cds);
  inherited destroy;
end;

procedure TObjetoDB.RemoverParametro(const index: Integer);
begin
  FParametros.Remove(index);
end;

function TObjetoDB.GetSQLWhere: String;
var
 contador : Integer;
 sql : string;
 key : string;
begin
  Result := EmptyStr;
  try
    if FParametros.Count > 0 then
      sql := ' WHERE ';

    for contador := 0 to FParametros.Count - 1 do
    begin
      key := FParametros.GetKey(contador);
      sql := sql + Format(' %s = :%s AND ', [key, key]);
    end;
    Result := sql;
    Result := Copy(Result, 1, Length(Result) - 4);
  finally
  end;
end;

procedure TObjetoDB.RemoverParametro(const chave : String);
begin
  FParametros.Remove(chave);
end;

procedure TObjetoDB.Select(fields: array of string);
var
 contador : Integer;
 sql_fields : string;
begin
  Fquery.Close;
  Fquery.SQL.Clear;
  for contador := 0 to Length(fields) - 1 do
  begin
    sql_fields := sql_fields + fields[contador] + ', ';
  end;

  sql_fields := Copy(sql_fields, 1, length(sql_fields) - 2);

  Fquery.SQL.Add(Format('SELECT %s', [sql_fields]));
  Fquery.SQL.Add(Format(' FROM %S', [FTabela]));
  Fquery.SQL.Add(GetSQLWhere);
  SetParams;
  Fquery.Open;
  Cds.Data := Fdsp.Data;
end;

procedure TObjetoDB.SetParams;
var
 contador : Integer;
begin
  for contador := 0 to FParametros.Count - 1 do
  begin
    Fquery.Parameters.ParamByName(FParametros.GetKey(contador)).Value := FParametros.GetValue(contador);
  end;
end;

function TObjetoDB.GetSQlInsert: String;
var
  contador : Integer;
  sql_fields, sql_param, field : string;
begin
  sql_fields := Format('INSERT INTO %s( ', [FTabela]);
  sql_param := 'values( ';
  for contador := 0 to FParametros.Count - 1 do
  begin
    field := FParametros.GetKey(contador);
    sql_fields := sql_fields + field + ', ';
    sql_param := sql_param + ':' + field + ', ';
  end;
  sql_fields := Copy(sql_fields, 1, Length(sql_fields) - 2) + ')';
  sql_param := Copy(sql_param, 1, Length(sql_param) - 2) + ')';
  Result := sql_fields + sql_param;

end;

procedure TObjetoDB.Insert;
begin
  if FParametros.Count = 0 then
     raise Exception.Create('Não será possível inserir, pois nenhum parametro foi fornecido');

  Fquery.close;
  Fquery.SQL.Clear;
  Fquery.SQL.Text := GetSQlInsert;
  SetParams;
  Fquery.ExecSQL;
end;

procedure TObjetoDB.RemoverTodosParametros;

begin
   FParametros.Clear;
end;

function TObjetoDB.GetVal(const field: String): variant;
begin
  Result := Cds.FieldByName(field).Value;
end;

{ TMapaValor }

constructor TMapaValor.create(const chave: string; valor: variant);
begin
  FChave := chave;
  FValor := valor;
end;

destructor TMapaValor.destroy;
begin
  inherited  destroy;
end;

{ TListaMapaValor }

procedure TListaMapaValor.Add(const chave: string; valor: Variant);
var
  Mapa : TMapaValor;
begin
  Mapa := TMapaValor.create(chave, valor);
  FlistaValor.Add(Mapa);
end;

function TListaMapaValor.Count : Integer;
begin
  Result := FlistaValor.Count;
end;

constructor TListaMapaValor.create;
begin
   FlistaValor := TList.Create;
end;

destructor TListaMapaValor.destroy;
begin
  FreeAndNil(FlistaValor);
  inherited destroy;
end;

procedure TListaMapaValor.Remove(const index : Integer);
begin
   FlistaValor.Delete(index);
end;

function TListaMapaValor.GetValue(const index: Integer): Variant;
var
 mapa : TMapaValor;
begin
  mapa := FlistaValor.Items[index];
  Result := mapa.FValor; 
end;

procedure TListaMapaValor.Remove(const chave: string);
var
  contador : Integer;
  mapa : TMapaValor;
begin
  for contador := 0 to FlistaValor.Count do
  begin
    mapa := FlistaValor.Items[contador];
    if UpperCase(mapa.FChave) = UpperCase(chave) then
    begin
      FlistaValor.Delete(contador);
    end;
  end;
end;

function TListaMapaValor.GetValue(const chave: string): Variant;
var
  contador : Integer;
  mapa : TMapaValor;
begin
  for contador := 0 to FlistaValor.Count do
  begin
    mapa := FlistaValor.Items[contador];
    if UpperCase(mapa.FChave) = UpperCase(chave) then
    begin
      Result := mapa.FValor;
    end;
  end;
end;

function TListaMapaValor.GetKey(const index: integer): string;
var
 mapa : TMapaValor;
begin
  mapa := FlistaValor.Items[index];
  Result := mapa.FChave;
end;

procedure TListaMapaValor.Clear;
begin
   FlistaValor.Clear;
end;

end.
