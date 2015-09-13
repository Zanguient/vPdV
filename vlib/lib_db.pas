unit lib_db;

interface
uses Windows, Messages, SysUtils, Variants, Classes, ADODB, uDmConexao, DBClient, Provider, DB;

  type
    TMapaValor = class
    protected
       FChave : String;
       FValor : Variant;
       FAdicional : String;
    public
       constructor create(const chave : string; valor : variant; Adicional : String = '');
       destructor destroy;override;
    end;

    TListaMapaValor = class
    private
      FlistaValor : TList;
    public
      procedure Add(const chave : string; valor : Variant; Adicional : String = '');
      procedure Remove(const index : Integer); overload;
      procedure Remove(const chave : string); overload;
      function GetValue(const index : Integer): Variant; overload;
      function GetValue(const chave : string): Variant; overload;
      function GetKey(const index : integer): string;
      function GetAdicional(const index : integer) : string; overload;
      function GetAdicional(const chave : string) : string; overload;
      function Count : Integer;
      procedure Clear;
      constructor create; virtual;
      destructor destroy; override;
    end;

    TObjetoDB = class(Tobject)
    private
      Fquery : TADOQuery;
      FTabela : String;
      FParametros : TListaMapaValor;
      FParametrosNewValue : TListaMapaValor;
      Fdsp : TDataSetProvider;
      FSqlAdicional : TStringList;
      FIgnoreParams : TStringList;
      function GetSQLWhere : string;
      function GetSQlInsert : string;
      function GetSQLUpdate : string;
      procedure SetParams;
      procedure SetNewValueParamUp;
    public
      procedure AddIgnoreParam(Param : String);
      procedure ClearIgnoreParam;
      procedure AddParametro(const field : string; valor : variant; comparador : String = '=');
      procedure AddParametroNewValueUp(const field : string; valor : variant);
      procedure RemoverParametro(const index : Integer); overload;
      procedure RemoverParametro(const chave : String); overload;
      procedure RemoverTodosParametros;
      procedure AddSqlAdicional(sql : String);
      procedure ClearSqlAdicional;
      procedure Reset;
      procedure Select(fields : array of string);
      procedure Insert;
      procedure Update;
      procedure ChangeValue(const field : String; newvalue : Variant);
      procedure SaveChanges;
      procedure Next;
      procedure Prior;
      procedure Last;
      procedure First;

      procedure SetParamsToNewValueUp(const onlyIgnored : Boolean);
      function IsEmpty : Boolean;
      function Find(Field : String; Value : Variant) : Boolean;
      function GetVal(const field : String): variant;
      constructor create(const NomeTabela : String);
      destructor destroy; override;
    end;


implementation


{ TObjetoDB }

procedure TObjetoDB.AddParametro(const field: string; valor: variant; comparador : String = '=');
begin
  FParametros.Add(field, valor, comparador);
end;

constructor TObjetoDB.create(const NomeTabela : String);
begin

  FTabela := NomeTabela;

  Fquery := TADOQuery.Create(nil);
  Fquery.Connection := dmConexao.adoConexaoBd;

  Fdsp := TDataSetProvider.Create(nil);
  Fdsp.DataSet := Fquery;

  FSqlAdicional := TStringList.Create;
  FParametros := TListaMapaValor.create;
  FParametrosNewValue := TListaMapaValor.create;
  FIgnoreParams := TStringList.Create;

end;

destructor TObjetoDB.destroy;
begin
  FreeAndNil(Fquery);
  FreeAndNil(FParametros);
  FreeAndNil(fdsp);
  FSqlAdicional.Clear;
  FreeAndNil(FSqlAdicional);
  FreeAndNil(FIgnoreParams);
  FreeAndNil(FParametrosNewValue);
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
 comparador : string;
begin
  Result := EmptyStr;

  for contador := 0 to FParametros.Count - 1 do
  begin
    key := FParametros.GetKey(contador);
    if FIgnoreParams.IndexOf(key) = -1 then
    begin
      comparador := FParametros.GetAdicional(contador);
      sql := sql + Format(' %s %s :%s AND ', [key, comparador, key]);
    end
  end;

  if sql <> EmptyStr then
    sql := ' WHERE ' + sql;

  Result := sql;
  Result := Copy(Result, 1, Length(Result) - 4);

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

  if FSqlAdicional.Count > 0 then
    Fquery.SQL.AddStrings(FSqlAdicional);

  SetParams;
  Fquery.Open;

end;

procedure TObjetoDB.SetParams;
var
 contador : Integer;
 key : string;
begin
  for contador := 0 to FParametros.Count - 1 do
  begin
    key := FParametros.GetKey(contador);
    if FIgnoreParams.IndexOf(key) = -1 then
    begin
      Fquery.Parameters.ParamByName(key).Value := FParametros.GetValue(contador);
    end
  end;
end;

function TObjetoDB.GetSQlInsert: String;
var
  contador : Integer;
  sql_fields, sql_param, field : string;
begin
  if (FSqlAdicional.Count > 0)  then
  begin
    Result := FSqlAdicional.GetText;
    Exit;
  end;

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
  if (FParametros.Count = 0) and (FSqlAdicional.Count = 0) then
     raise Exception.Create('Não será possível inserir, pois nenhum parametro foi fornecido');

  Fquery.close;
  Fquery.SQL.Clear;
  Fquery.SQL.Text := GetSQlInsert;
  SetParams;
  Fquery.ExecSQL;
  FParametros.Clear;
end;

procedure TObjetoDB.RemoverTodosParametros;

begin
   FParametros.Clear;
end;

function TObjetoDB.GetVal(const field: String): variant;
begin
  Result := Fquery.FieldByName(field).Value;
end;

procedure TObjetoDB.AddSqlAdicional(sql: String);
begin
   FSqlAdicional.Add(sql);
end;

procedure TObjetoDB.ClearSqlAdicional;
begin
   FSqlAdicional.Clear;
end;

procedure TObjetoDB.Reset;
begin
   ClearSqlAdicional;
   RemoverTodosParametros;
   Fquery.Close;
end;

procedure TObjetoDB.ChangeValue(const field: String; newvalue: Variant);
begin
  if Fquery.State in [dsBrowse, dsInactive] then
  begin
    Fquery.Edit;
  end;
  Fquery.FieldByName(field).Value := newvalue;
end;

procedure TObjetoDB.SaveChanges;
begin
  if Fquery.State in [dsInsert, dsEdit] then
  begin
    Fquery.Post;
  end
end;

procedure TObjetoDB.Next;
begin
   Fquery.Next;
end;

procedure TObjetoDB.Prior;
begin
  Fquery.Prior;
end;

procedure TObjetoDB.Last;
begin
  Fquery.Last;
end;

procedure TObjetoDB.First;
begin
  Fquery.First;
end;

function TObjetoDB.IsEmpty : Boolean;
begin
  Result := Fquery.IsEmpty;
end;

function TObjetoDB.Find(Field: String; Value: Variant): Boolean;
begin
  Result := Fquery.Locate(Field, Value, [loCaseInsensitive]);
end;

procedure TObjetoDB.AddIgnoreParam(Param : String);
begin
  FIgnoreParams.Add(Param);
end;

procedure TObjetoDB.ClearIgnoreParam;
begin
   FIgnoreParams.Clear;
end;


procedure TObjetoDB.AddParametroNewValueUp(const field: string;
  valor: variant);
begin
  FParametrosNewValue.Add(field, valor, '');
end;

procedure TObjetoDB.Update;
begin
  if ((FParametros.Count = 0) and (FSqlAdicional.Count = 0)) or (FParametrosNewValue.Count = 0) then
     raise Exception.Create('Não será possível inserir, pois nenhum parametro foi fornecido');

  Fquery.close;
  Fquery.Parameters.Clear;
  Fquery.SQL.Clear;
  Fquery.SQL.Text := GetSQLUpdate;
  SetParams;
  SetNewValueParamUp;
  Fquery.ExecSQL;
  FParametros.Clear;
  FParametrosNewValue.Clear;

end;

function TObjetoDB.GetSQLUpdate: string;
var
  contador : Integer;
  sql_param, field : string;
begin

  sql_param := Format('update %s set ', [FTabela]);

  for contador := 0 to FParametrosNewValue.Count - 1 do
  begin
    field := FParametrosNewValue.GetKey(contador);
    sql_param := sql_param + Format(' %s = :new_%s, ', [field, field ])
  end;
  sql_param := Copy(sql_param, 1, Length(sql_param) - 2);
  sql_param := sql_param + GetSQLWhere;

  Result := sql_param;

end;

procedure TObjetoDB.SetNewValueParamUp;
var
 contador : Integer;
 key : string;
begin
  for contador := 0 to FParametrosNewValue.Count - 1 do
  begin
    key := FParametrosNewValue.GetKey(contador);
    Fquery.Parameters.ParamByName('new_' + key).Value := FParametrosNewValue.GetValue(contador);
  end;

end;

procedure TObjetoDB.SetParamsToNewValueUp(const onlyIgnored: Boolean);
var
 contador : Integer;
 key : string;
begin
  FParametrosNewValue.Clear;
  for contador := 0 to FParametros.Count - 1 do
  begin
    key := FParametros.GetKey(contador);
    FParametrosNewValue.Add(key, FParametros.GetValue(contador), '');
  end;

end;

{ TMapaValor }

constructor TMapaValor.create(const chave: string; valor: variant; Adicional : string = '');
begin
  FChave := chave;
  FValor := valor;
  FAdicional := Adicional;
end;

destructor TMapaValor.destroy;
begin
  inherited  destroy;
end;

{ TListaMapaValor }

procedure TListaMapaValor.Add(const chave: string; valor: Variant;  Adicional : String = '');
var
  Mapa : TMapaValor;
begin
  Mapa := TMapaValor.create(chave, valor, Adicional);
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
  for contador := 0 to FlistaValor.Count - 1 do
  begin
    mapa := FlistaValor.Items[contador];
    if UpperCase(mapa.FChave) = UpperCase(chave) then
    begin
      Result := mapa.FValor;
      Break;
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

function TListaMapaValor.GetAdicional(const index : integer): string;
var
  mapa : TMapaValor;
begin
  mapa := FlistaValor.Items[index];
  Result := mapa.FAdicional;
end;

function TListaMapaValor.GetAdicional(const chave: string): string;
var
  contador : Integer;
  mapa : TMapaValor;
begin
  for contador := 0 to FlistaValor.Count - 1 do
  begin
    mapa := FlistaValor.Items[contador];
    if UpperCase(mapa.FChave) = UpperCase(chave) then
    begin
      Result := mapa.FAdicional;
      Break;
    end;
  end;

end;

end.
