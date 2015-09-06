unit lib_sincronizacao;

interface

uses IdHTTP, SysUtils, Windows, Classes, Variants, Dialogs, lib_db, XMLDoc, XMLIntf;

type
  TChaveEValor = class of TMapaValor;
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
    procedure Save; virtual;
    constructor create(const model, module: string; const CamposWebLocal: TListaMapaValor; const ChavesTabela: string;
      const TabelaLocal: string = '');
  end;

  TSincronizarTabelas = class
  public
    class procedure ExecutarSincObjeto(obj: TSincronizacao);
    class procedure Sincronizar;
  end;
implementation


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

procedure TSincronizacao.Save;
var
  bd: TObjetoDB;
  i, k: Integer;
  doc: IXMLDocument;
  row, field: IXMLNode;
  campos, campo_atual: string;
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

        bd.AddParametro(campo_atual, field.NodeValue);

        if Pos(campo_atual + ',', FChavesTabela) = 0 then
          bd.AddIgnoreParam(campo_atual);
        
      end;

      bd.Select(['codigo']);

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
  map:= TListaMapaValor.create;
  map.Add('nmempresa', 'nmempresa', '');
  map.Add('codigo', 'codigo', '');
  map.Add('dtcadastro', 'dtcadastro', '');
  sinc := TSincronizacao.create('empresa', 'cadastro.empresa.models', map, 'codigo', 'empresa');
  try
    sinc.Save;
  finally
    FreeAndNil(sinc);
  end;

end;

end.
