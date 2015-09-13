unit lib_sincronizacao;

interface

uses IdHTTP, SysUtils, Windows, Classes, Variants, Dialogs, lib_db, XMLDoc, XMLIntf;

type
  TSincronizacao = class(TObject)
  private
    FUrlToGetXML: string;
    FUrlToSendXML: string;
    FModulo: string;
    Fmodel: string;
    FTabelaLocal : string;
    FCamposWebLocal : TListaMapaValor;
    FChavesTabela : string;
    function GetXMLText(FieldsSeparetedByPipe : String = ''): string;
  protected

  public
    procedure GetWebData; virtual;
    constructor create(const model, module: string; const CamposWebLocal: TListaMapaValor; const ChavesTabela: string;
      const TabelaLocal: string = '');
  end;

  TSincronizarTabelas = class
  public
    class procedure ExecutarSincObjeto(obj: TSincronizacao);
    class procedure Sincronizar;
  end;
implementation

uses StrUtils;


const
   SENHA_VMSIS = 'masterVMSIS123v';
   USUARIO_VMSIS = 'vmsismaster';
   URL_BASE = 'http://177.153.20.166';
   URL_PARCIAL_GET_XML = '/getmodelasjson/';
   URL_PARCIAL_SEND_XML = '/setmodelasjson/';

{var
 html : string;
 params : TStringList;
 Parameters,response: TStringStream;
begin
  params := TStringList.Create;
  response := TStringStream.Create('');
  params.Add('username=vmsismaster');
  params.Add('password=masterVMSIS123v');
  IdHTTP1.Request.Clear;
  IdHTTP1.Post('http://177.153.20.166/login/', params, response);
  html := IdHTTP1.Get('http://177.153.20.166/filtro/?model=cliente&module=cadastro.cliente.models');
  RichEdit1.Text := html;}


{ TSincronizacao }


constructor TSincronizacao.create(const model, module: string; const CamposWebLocal : TListaMapaValor; const ChavesTabela : string;
  const TabelaLocal : string = '');
begin
   FUrlToGetXML:= URL_BASE + URL_PARCIAL_GET_XML;
   FUrlToSendXML:= URL_BASE + URL_PARCIAL_SEND_XML;
   Fmodel:= model;
   FModulo:= module;
   FCamposWebLocal:= CamposWebLocal;

   if TabelaLocal = EmptyStr then
      FTabelaLocal:= Fmodel
   else
     FTabelaLocal:= TabelaLocal;

  FChavesTabela:= ChavesTabela + ',';
end;

function TSincronizacao.GetXMLText(FieldsSeparetedByPipe : string): string;
var
  XML : string;
  url_param : string;
  http : TIdHTTP;
begin
  http := TIdHTTP.Create(nil);
  try
    url_param := FUrlToGetXML + Format('?model=%s&module=%s&usuario=%s&senha=%s', [Fmodel, FModulo, USUARIO_VMSIS, SENHA_VMSIS]);

    if FieldsSeparetedByPipe <> EmptyStr then
       url_param := url_param + '&fields=' + FieldsSeparetedByPipe;

    XML := http.Get(url_param);
    if Copy(XML, 1, 5) <> '<?xml' then
       Result := EmptyStr
    else
       Result := XML;

  finally
    if Assigned(http) then
      FreeAndnil(http)
  end;


end;

procedure TSincronizacao.GetWebData;
var
  bd, bd_fk: TObjetoDB;
  i, k: Integer;
  doc: IXMLDocument;
  row, field: IXMLNode;
  campos, campo_atual, campo_fk, valor_adicional: string;

begin
  bd:= TObjetoDB.create(FTabelaLocal);
  doc:= TXMLDocument.Create(nil);
  try
    campos := '';

    for i:= 0 to FCamposWebLocal.Count - 1 do
    begin
      campos := campos + FCamposWebLocal.GetKey(i) + '|';
    end;

    if campos <> EmptyStr then
    begin
      campos := Copy(campos, 1, Length(campos) - 1);
    end;

    doc.XML.Text:= GetXMLText(campos);
    doc.Active:= True;

    for i:= 0 to doc.ChildNodes.Nodes['django-objects'].ChildNodes.Count - 1 do
    begin
      row:= doc.ChildNodes.Nodes['django-objects'].ChildNodes[i];
      bd.ClearIgnoreParam;
      for k:= 0 to row.ChildNodes.Count -1 do
      begin
        field:= row.ChildNodes[k];
        campo_atual:= FCamposWebLocal.GetValue(VarToStr(field.Attributes['name']));
        valor_adicional := FCamposWebLocal.GetAdicional(VarToStr(field.Attributes['name']));
        if valor_adicional <> EmptyStr then
        begin
          bd.AddParametro(campo_atual, valor_adicional);
        end
        else
        begin
          if field.HasAttribute('to') then
          begin
            campo_fk:= varToStr(field.Attributes['to']);
            campo_fk:= ReverseString(campo_fk);
            campo_fk:= copy(campo_fk, 1, pos('.', campo_fk)-1);
            campo_fk := ReverseString(campo_fk);
            bd_fk := TObjetoDB.create(campo_fk);
            try
              bd_fk.AddParametro('id_web', field.NodeValue);
              bd_fk.Select(['id']);
              bd.AddParametro(campo_atual, bd_fk.GetVal('id'));
            finally
              FreeAndNil(bd_fk);
            end;
          end
          else
          begin
            bd.AddParametro(campo_atual, field.NodeValue);
          end;
        end;

        if Pos(campo_atual + ',', FChavesTabela) = 0 then
          bd.AddIgnoreParam(campo_atual);

      end;
      bd.AddParametro('id_web', row.Attributes['pk']);
      bd.AddIgnoreParam('id_web');

      bd.Select(['id']);

      if not bd.IsEmpty then
      begin
        bd.SetParamsToNewValueUp(False);
        bd.Update;
      end
      else
      begin
        bd.ClearIgnoreParam;
        bd.Insert;
      end;
    end;
  finally
    FreeAndNil(bd);
  end;

end;

{ TSincronizarTabelas }

class procedure TSincronizarTabelas.ExecutarSincObjeto(
  obj: TSincronizacao);
begin
  //if Assigned(obj) then
 // begin
   // obj.
 // end;
end;

class procedure TSincronizarTabelas.Sincronizar;
var
  sinc : TSincronizacao;
  map : TListaMapaValor;

begin
   try

     //pais
     map := TListaMapaValor.create;
//     map.Add('empresa', 'empresa_id', '');
     map.Add('dtcadastro', 'dtcadastro', '');
     map.Add('cdpais', 'cdpais', '');
     map.Add('nmpais', 'nmpais', '');
     map.Add('cdsiscomex', 'cdsiscomex', '');
     map.Add('sgpais2', 'sgpais2', '');
     map.Add('sgpais3', 'sgpais3', '');
     sinc := TSincronizacao.create('pais', 'cadastro.localidades.pais.models', map, 'cdpais', 'pais');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);


     //estado
     map := TListaMapaValor.create;
  //   map.Add('empresa', 'empresa_id', '');
     map.Add('dtcadastro', 'dtcadastro', '');
     map.Add('cdestado', 'cdestado', '');
     map.Add('nmestado', 'nmestado', '');
     map.Add('sgestado', 'sgestado', '');
     map.Add('pais', 'pais_id', '');
     map.Add('dsregiao', 'dsregiao', '');
     sinc := TSincronizacao.create('estado', 'cadastro.localidades.estado.models', map, 'cdestado,sgestado', 'estado');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //cidade
     map := TListaMapaValor.create;
  //   map.Add('empresa', 'empresa_id', '');
     map.Add('dtcadastro', 'dtcadastro', '');
     map.Add('cdcidade', 'cdcidade', '');
     map.Add('nmcidade', 'nmcidade', '');
     map.Add('pais', 'pais_id', '');
     map.Add('estado', 'estado_id', '');
     sinc := TSincronizacao.create('cidade', 'cadastro.localidades.cidade.models', map, 'cdcidade', 'cidade');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);


     //bairro
     map := TListaMapaValor.create;
  //   map.Add('empresa', 'empresa_id', '');
     map.Add('dtcadastro', 'dtcadastro', '');
     map.Add('cdbairro', 'cdbairro', '');
     map.Add('nmbairro', 'nmbairro', '');
     map.Add('cidade', 'cidade_id', '');
     sinc := TSincronizacao.create('bairro', 'cadastro.localidades.bairro.models', map, 'cdbairro', 'bairro');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //cliente
     map := TListaMapaValor.create;
  //   map.Add('master_endereco', 'idempresa', '');
     map.Add('dtcadastro', 'dtcadastro', '');
     map.Add('nrinscjurd', 'nrinscjurd', '');
     map.Add('nmcliente', 'nmcliente', '');
     map.Add('identificador', 'identificador', '');
     map.Add('telcel', 'telcel', '');
     map.Add('telfixo', 'telfixo', '');
     map.Add('nmrua', 'nmrua', '');
     map.Add('cdnumero', 'cdnumero', '');
     map.Add('cdcep', 'cdcep', '');
     map.Add('cdbairro', 'cdbairro_id', '');
     sinc := TSincronizacao.create('cliente', 'cadastro.cliente.models', map, 'nmcliente', 'cliente');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //fornecedor
     map := TListaMapaValor.create;
//     map.Add('empresa', 'idempresa', '');
     map.Add('dtcadastro', 'dtcadastro', '');
     map.Add('nrinscjurd', 'nrinscjurd', '');
     map.Add('nmfornecedor', 'nmfornecedor', '');
     map.Add('identificador', 'identificador', '');
     map.Add('telcel', 'telcel', '');
     map.Add('telfixo', 'telfixo', '');
     map.Add('nmrua', 'nmrua', '');
     map.Add('cdnumero', 'cdnumero', '');
     map.Add('cdcep', 'cdcep', '');
     map.Add('cdbairro', 'cdbairro_id', '');
     sinc := TSincronizacao.create('fornecedor', 'cadastro.fornecedor.models', map, 'nmfornecedor', 'fornecedor');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

   finally
     if Assigned(sinc) then
        FreeAndNil(sinc);
     if Assigned(map) then
        FreeAndNil(map);

   end;

end;

end.
