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
    function CheckNodeValue(const field : IXMLNode): OleVariant;
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

uses StrUtils, lib_tratamentos_sincronizacao;


const
   SENHA_VMSIS = 'masterVMSIS123v';
   USUARIO_VMSIS = 'vmsismaster';
   URL_BASE = 'http://127.0.0.1:8000/';//'http://177.153.20.166';
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
      if FCamposWebLocal.GetKey(i) <> EmptyStr then
        campos := campos + FCamposWebLocal.GetKey(i) + '|'
      else
      begin
        bd.AddParametro(FCamposWebLocal.GetValue(i), FCamposWebLocal.GetAdicional(i));
      end;

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
            campo_fk:= ReverseString(campo_fk);
            bd_fk := TObjetoDB.create(campo_fk);
            try
              bd_fk.AddParametro('id_web', CheckNodeValue(field));
              bd_fk.Select(['id']);
              bd.AddParametro(campo_atual, bd_fk.GetVal('id'));
            finally
              FreeAndNil(bd_fk);
            end;
          end
          else
          begin
            bd.AddParametro(campo_atual, CheckNodeValue(field));
          end;
        end;

        if Pos(campo_atual + ',', FChavesTabela) = 0 then
          bd.AddIgnoreParam(campo_atual);
                     
      end;
      bd.AddParametro('id_web', row.Attributes['pk']);

      if Pos('pk,', FChavesTabela) = 0 then
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

function TSincronizacao.CheckNodeValue(const field: IXMLNode): OleVariant;
var
  field_type : string;
  value : Variant;
const
  C_BOLLEAN_FIELD = 'BooleanField';
  
begin
  field_type := VarToStr(field.Attributes['type']);

  try
    value := field.NodeValue
  except
    Result := Null;
    Exit;
  end;

  if field_type = C_BOLLEAN_FIELD then
  begin
     if value = 'True' then
       Result := 1
     else
       Result := 0
  end
  else
    Result := value;

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
     sinc := TSincronizacao.create('cliente', 'cadastro.cliente.models', map, 'telcel', 'cliente');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //fornecedor
     map := TListaMapaValor.create;
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
     sinc := TSincronizacao.create('fornecedor', 'cadastro.fornecedor.models', map, 'telcel', 'fornecedor');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);


     //unimedida
     map := TListaMapaValor.create;
     map.Add('dtcadastro', 'dtcadastro', '');
     map.Add('nmmedida', 'nmmedida', '');
     map.Add('sgmedida', 'sgmedida', '');
     map.Add('qtfatorconv', 'qtfatorconv', '');
     map.Add('idtipomed', 'idtipomed', '');

     sinc := TSincronizacao.create('unimedida', 'cadastro.unimedida.models', map, 'nmmedida', 'unimedida');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //produto
     map := TListaMapaValor.create;
     map.Add('dtcadastro', 'dtcadastro');
     map.Add('posarvore', 'posarvore');
     map.Add('nmproduto', 'nmproduto');
     map.Add('unimedida', 'unimedida_id');
     map.Add('cdbarra', 'cdbarra');
     map.Add('idprodvenda', 'idprodvenda');
     map.Add('idadicional', 'idadicional');
     map.Add('imgindex', 'imgindex');

     sinc := TSincronizacao.create('produto', 'cadastro.produto.models', map, 'nmproduto', 'produto');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);


     //finalidade
     map := TListaMapaValor.create;
     map.Add('dtcadastro', 'dtcadastro');
     map.Add('descricao', 'descricao');

     sinc := TSincronizacao.create('finalidade', 'estoque.cadastro_estoque.finalidade.models', map, 'descricao', 'finalidade');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //entrada - estoque()
     map := TListaMapaValor.create;
     map.Add('dtentrada', 'dtentrada');
     map.Add('fornecedor', 'fornecedor_id');
     sinc := TSincronizacao.create('Entrada', 'estoque.entrada.models', map, 'pk', 'Entrada');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //saida
     map := TListaMapaValor.create;
     map.Add('dtsaida', 'dtsaida');
     map.Add('cliente', 'cliente_id');
     map.Add('finalidade', 'finalidade_id');
     map.Add('idtipo', 'idtipo');
     sinc := TSincronizacao.create('Saida', 'estoque.saida.models', map, 'pk', 'Saida');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //itemproduto
     map := TListaMapaValor.create;
     map.Add('dtcadastro', 'dtcadastro');
     map.Add('produto', 'produto_id');
     map.Add('lote', 'lote_id');
     map.Add('qtdeprod', 'qtdeprod');
     sinc := TSincronizacao.create('Itemproduto', 'estoque.itemproduto.models', map, 'pk', 'Itemproduto');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     TTratamentos.PreencherIdEntradaSaidaItemProduto;
     //lote
     map := TListaMapaValor.create;
     map.Add('dtcadastro', 'dtcadastro');
     map.Add('dslote', 'dslote');
     map.Add('dtvalidade', 'dtvalidade');
     map.Add('dtfabricacao', 'dtfabricacao');
     sinc := TSincronizacao.create('Lote', 'estoque.lote.models', map, 'pk', 'Lote');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //posestoque
     map := TListaMapaValor.create;
     map.Add('dtcadastro', 'dtcadastro');
     map.Add('produto', 'produto_id');
     map.Add('lote', 'lote_id');
     map.Add('qtdeproduto', 'qtdeproduto');
     sinc := TSincronizacao.create('posestoque', 'estoque.posestoque.models', map, 'pk', 'posestoque');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //AgrupAdicional
     map := TListaMapaValor.create;
     map.Add('nmagrupadic', 'nmagrupadic');
     map.Add('vragrupadic', 'vragrupadic');
     map.Add('idagrupativ', 'idagrupativ');
     sinc := TSincronizacao.create('AgrupAdicional', 'pedido.cadastro_pedido.agrupadicional.models',
       map, 'pk', 'AgrupAdicional');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //Categoria
     map := TListaMapaValor.create;
     map.Add('nmcategoria', 'nmcategoria');
     map.Add('idcategoriativ', 'idcategoriativ');
     map.Add('imgindex', 'imgindex');
     sinc := TSincronizacao.create('categoria', 'pedido.cadastro_pedido.categoria.models',
       map, 'pk', 'categoria');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //ComposicaoProd
     map := TListaMapaValor.create;
     map.Add('produto', 'produto_id');
     map.Add('prodcomp', 'prodcomp_id');
     map.Add('qtcomp', 'qtcomp');
     map.Add('unimedida', 'unimedida_id');
     sinc := TSincronizacao.create('ComposicaoProd', 'pedido.cadastro_pedido.composicaoproduto.models',
       map, 'pk', 'ComposicaoProd');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //ItemCategoria
     map := TListaMapaValor.create;
     map.Add('categoria', 'categoria_id');
     map.Add('produto', 'produto_id');
     map.Add('vrvenda', 'vrvenda');
     map.Add('qtvenda', 'qtvenda');
     map.Add('qtadicgratis', 'qtadicgratis');
     map.Add('unimedida', 'unimedida_id');
     sinc := TSincronizacao.create('ItemCategoria', 'pedido.cadastro_pedido.itemcategoria.models',
       map, 'pk', 'ItemCategoria');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //itagrupadicional
     map := TListaMapaValor.create;
     map.Add('cardapio', 'cardapio_id');
     map.Add('agrupadicional', 'agrupadicional_id');
     sinc := TSincronizacao.create('itagrupadicional', 'pedido.cadastro_pedido.itemcategoria.models',
       map, 'pk', 'itagrupadicional');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //mesa
     map := TListaMapaValor.create;
     map.Add('nmmesa', 'nmmesa');
     map.Add('dsobsmesa', 'dsobsmesa');
     map.Add('idmesaativ', 'idmesaativ');
     sinc := TSincronizacao.create('Mesa', 'pedido.cadastro_pedido.mesa.models', map, 'nmmesa', 'Mesa');
     sinc.GetWebData;
     FreeAndNil(sinc);
     FreeAndNil(map);

     //adicionais
     map := TListaMapaValor.create;
     map.Add('agrupadicional', 'agrupadicional_id');
     map.Add('item', 'item_id');
     map.Add('valor', 'valor');
     map.Add('quantidade', 'quantidade');
     sinc := TSincronizacao.create('Adicionais', 'pedido.cadastro_pedido.agrupadicional.models',
       map, 'pk', 'Adicionais');
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

