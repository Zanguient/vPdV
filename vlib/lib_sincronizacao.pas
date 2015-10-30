unit lib_sincronizacao;

interface

uses IdHTTP, SysUtils, Windows, Classes, Variants, Dialogs, XMLDoc, XMLIntf, DateUtils, lib_db,
     DB, DBClient;
type
  TStatusAtualizacao = (saSucesso, saError);

  TSincronizacaoBase = class(TObject)
  protected
    FUrlToGetXML: string;
    FUrlToSendXML: string;
    FUrlBase: string;
    FModulo: string;
    Fmodel: string;
    FTabelaLocal : string;
    FCamposWebLocal : TListaMapaValor;
    FChavesTabela : string;
  public
    constructor create(const model, module: string; const CamposWebLocal: TListaMapaValor; const ChavesTabela: string;
      const TabelaLocal: string = ''); virtual;

  end;

  TSincronizacao = class(TSincronizacaoBase)
  private

    FCondicoesParaBaixar: String;
    function GetXMLText(FieldsSeparetedByPipe : String = ''): string;
    function CheckNodeValue(const field : IXMLNode): OleVariant;
  public
    property FiltroDownload: string read FCondicoesParaBaixar write FCondicoesParaBaixar;
    procedure GetWebData; virtual;

    constructor create(const model, module: string; const CamposWebLocal: TListaMapaValor; const ChavesTabela: string;
      const TabelaLocal: string = ''); override;
  end;

  TUpload = class(TSincronizacaoBase)
  private
     FCdsConfUpload: TClientDataSet;
     FCdsModels: TClientDataSet;
     FJson: string;
     procedure ConfigurarCdsConfUpload;
     procedure AddRegistroMapa(Model, Module, CampoWeb, CampoLocal, TabelaLocal, ModelPai, NomeCampoPai: String);
     procedure AddMapaTabelaPrinciapal;
     procedure FilterCds(cds: TClientDataSet; const Filtro: String);
     function GetJsonParcial(const Model, ModelPai, Module: string; const ValorCampoPai: Variant): string;
  public

    procedure AddModelFilho(const Model, Module, ChavesTabela, TabelaLocal, ModelPai: string;
      const CamposWebLocal: TListaMapaValor; const NomeTabelaCampoPai: string = 'id');

    function GetURLUpload: String;

    constructor create(const model, module: string; const CamposWebLocal: TListaMapaValor;
      const ChavesTabela: string; const TabelaLocal: string = ''); override;
    destructor destroy; override;
  end;

  TSincronizarTabelas = class
  public

    class function MapaPais: TListaMapaValor;
    class function MapaEstado(const MarcarCampoPai: Boolean = False): TListaMapaValor;

    class function Sincronizado : Boolean;
    class procedure GravarDataSincronizacao(const Data: TDateTime; const Status: TStatusAtualizacao;
      const Log : string);
    class function Download(const Empresa, Unidade, Almoxarifado: Integer): String;
    class function Upload: string;
    class function Sincronizar(const SincronizacaoForcada: Boolean): String;
  end;
implementation

uses StrUtils, lib_tratamentos_sincronizacao, uDmConexao;


const
   SENHA_VMSIS = 'masterVMSIS123v';
   USUARIO_VMSIS = 'vmsismaster';
   URL_PARCIAL_GET_XML = '/getmodelasxml/';
   URL_PARCIAL_SEND_XML = '/savejsonasmodel/';

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


(* modelo de url para enviar
http://localhost:8000/savejsonasmodel?data={"model":"pais", "module":"cadastro.localidade.pais.models", "rws":[{"empresa_id":"1", "dtcadastro":"2015-10-12",
   "cdpais":"0055", "nmpais":"BRASIL2", "cdsiscomex":"55555", "sgpais2":"BR", "sgpais3":"BRA",
   "model_child":[{"model":"estado", "module":"cadastro.localidade.estado.models", "parent_field":"pais_id",
   "rws":[{"empresa_id":"1", "dtcadastro":"2015-10-12", "cdestado":"32", "nmestado":"ESTADO MINAS", "sgestado":"EM", "dsregiao":"SULDESTE"}]} ] }] }

*)

{ TSincronizacao }


constructor Tsincronizacao.create(const model, module: string; const CamposWebLocal: TListaMapaValor; const ChavesTabela: string;
      const TabelaLocal: string = '');
begin
  inherited;
  FCondicoesParaBaixar:= EmptyStr; 
end;

function TSincronizacao.GetXMLText(FieldsSeparetedByPipe : string): string;
var
  XML : string;
  url_param : string;
  http : TIdHTTP;
begin
  http := TIdHTTP.Create(nil);
  try
    url_param := FUrlToGetXML + Format('?model=%s&module=%s&usuario=%s&senha=%s', [Fmodel, FModulo,
       USUARIO_VMSIS, SENHA_VMSIS]);

    if FieldsSeparetedByPipe <> EmptyStr then
       url_param := url_param + '&fields=' + FieldsSeparetedByPipe;

    if FCondicoesParaBaixar <> EmptyStr then
       url_param := url_param + '&filter=' + FCondicoesParaBaixar;
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
  C_BOOLEAN_FIELD = 'BooleanField';
  
begin
  field_type := VarToStr(field.Attributes['type']);

  try
    value := field.NodeValue
  except
    Result := Null;
    Exit;
  end;

  if field_type = C_BOOLEAN_FIELD then
  begin
     if value = 'True' then
       Result := 1
     else
       Result := 0
  end
  else
    Result := value;

end;


procedure TUpload.AddMapaTabelaPrinciapal;
var
  i: Integer;
begin
  for i:= 0 to FCamposWebLocal.Count - 1 do
  begin
    AddRegistroMapa(Fmodel, FModulo, FCamposWebLocal.GetKey(i), FCamposWebLocal.GetValue(i),
      FTabelaLocal, EmptyStr, EmptyStr);
  end;
end;

procedure TUpload.AddModelFilho(const Model, Module, ChavesTabela,
  TabelaLocal, ModelPai: string; const CamposWebLocal: TListaMapaValor;
  const NomeTabelaCampoPai: string = 'id');
var
  i: Integer;
begin
  for i:= 0 to FCamposWebLocal.Count - 1 do
  begin
    if CamposWebLocal.GetAdicional(i) = 'fk' then
    begin
      AddRegistroMapa(Model, Module, CamposWebLocal.GetKey(i), CamposWebLocal.GetValue(i),
        TabelaLocal, ModelPai, NomeTabelaCampoPai);
    end
    else
    begin
      AddRegistroMapa(Model, Module, CamposWebLocal.GetKey(i), CamposWebLocal.GetValue(i),
        TabelaLocal, ModelPai, EmptyStr);
    end;
  end;

end;

procedure TUpload.AddRegistroMapa(Model, Module, CampoWeb, CampoLocal, TabelaLocal, ModelPai,
  NomeCampoPai: String);
  function AsteriscoSeVazio(Valor: String): string;
  begin
    Result:= IfThen(Valor = EmptyStr, '*', Valor);
  end;
begin
  FCdsConfUpload.Insert;
  FCdsConfUpload.FieldByName('Model').AsString:= AsteriscoSeVazio(Model);
  FCdsConfUpload.FieldByName('Module').AsString:= AsteriscoSeVazio(Module);
  FCdsConfUpload.FieldByName('CampoWeb').AsString:= AsteriscoSeVazio(CampoWeb);
  FCdsConfUpload.FieldByName('CampoLocal').AsString:= AsteriscoSeVazio(CampoLocal);
  FCdsConfUpload.FieldByName('ModelPai').AsString:= AsteriscoSeVazio(ModelPai);
  FCdsConfUpload.FieldByName('NomeCampoPai').AsString:= AsteriscoSeVazio(NomeCampoPai);
  FCdsConfUpload.FieldByName('TabelaLocal').AsString:= AsteriscoSeVazio(TabelaLocal);
  FCdsConfUpload.Post;

  if not FCdsModels.Locate('Model', VarArrayOf([Model]), [loCaseInsensitive]) then
  begin
    FCdsModels.Insert;
    FCdsModels.FieldByName('Model').AsString:= AsteriscoSeVazio(Model);
    FCdsModels.FieldByName('Module').AsString:= AsteriscoSeVazio(Module);
    FCdsModels.FieldByName('TabelaLocal').AsString:= AsteriscoSeVazio(TabelaLocal);
    FCdsModels.FieldByName('ModelPai').AsString:= AsteriscoSeVazio(ModelPai);
    FCdsModels.Post;
  end;
end;

procedure TUpload.ConfigurarCdsConfUpload;
begin
  if not Assigned(FCdsConfUpload) then
  begin
    FCdsConfUpload:= TClientDataSet.Create(nil);
    FCdsConfUpload.FieldDefs.Add('Sequencial', ftAutoInc);
    FCdsConfUpload.FieldDefs.Add('Model', ftString, 100);
    FCdsConfUpload.FieldDefs.Add('Module', ftString, 300);
    FCdsConfUpload.FieldDefs.Add('CampoWeb', ftString, 100);
    FCdsConfUpload.FieldDefs.Add('CampoLocal', ftString, 100);
    FCdsConfUpload.FieldDefs.Add('ModelPai', ftString, 100);
    FCdsConfUpload.FieldDefs.Add('NomeCampoPai', ftString, 100);
    FCdsConfUpload.FieldDefs.Add('TabelaLocal', ftString, 100);
    FCdsConfUpload.CreateDataSet;
  end;
  FCdsConfUpload.IndexFieldNames:= 'Sequencial';

  if not Assigned(FCdsModels) then
  begin
    FCdsModels:= TClientDataSet.Create(nil);
    FCdsModels.FieldDefs.Add('Sequencial', ftAutoInc);
    FCdsModels.FieldDefs.Add('Model', ftString, 100);
    FCdsModels.FieldDefs.Add('Module', ftString, 300);
    FCdsModels.FieldDefs.Add('TabelaLocal', ftString, 100);
    FCdsModels.FieldDefs.Add('ModelPai', ftString, 100);
    FCdsModels.CreateDataSet;
  end;
  FCdsModels.IndexFieldNames:= 'Sequencial';
end;

{ TSincronizarTabelas }

class function TSincronizarTabelas.Download(const Empresa, Unidade, Almoxarifado: Integer): String;
var
  sinc : TSincronizacao;
  map : TListaMapaValor;
begin
  dmConexao.adoConexaoBd.BeginTrans;
  try try

    map:= MapaPais;
    sinc := TSincronizacao.create('pais', 'cadastro.localidades.pais.models', map, 'cdpais', 'pais');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //estado
    map:= MapaEstado;
    sinc := TSincronizacao.create('estado', 'cadastro.localidades.estado.models', map, 'cdestado,sgestado', 'estado');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
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
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
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
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
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
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
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
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
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
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
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
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);


    //finalidade
    map := TListaMapaValor.create;
    map.Add('dtcadastro', 'dtcadastro');
    map.Add('descricao', 'descricao');

    sinc := TSincronizacao.create('finalidade', 'estoque.cadastro_estoque.finalidade.models', map, 'descricao', 'finalidade');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //entrada - estoque()
    map := TListaMapaValor.create;
    map.Add('dtentrada', 'dtentrada');
    map.Add('fornecedor', 'fornecedor_id');
    sinc := TSincronizacao.create('Entrada', 'estoque.entrada.models', map, 'pk', 'Entrada');
    sinc.FiltroDownload:= format('{"unidade_id":"%d"}', [Unidade]);
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
    sinc.FiltroDownload:= format('{"unidade_id":"%d"}', [Unidade]);
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
    sinc.FiltroDownload:= format('{"almoxarifado_id":"%d"}', [Almoxarifado]);
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
    sinc.FiltroDownload:= format('{"unidade_id":"%d"}', [Unidade]);
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
    sinc.FiltroDownload:= format('{"almoxarifado_id":"%d"}', [Almoxarifado]);
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
    sinc.FiltroDownload:= format('{"unidade_id":"%d"}', [Unidade]);
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

    dmConexao.adoConexaoBd.CommitTrans;

  except
    on E:Exception do
    begin
      dmConexao.adoConexaoBd.RollbackTrans;
      Result:= E.Message;
    end;
  end;
  finally
    if Assigned(sinc) then
       FreeAndNil(sinc);
    if Assigned(map) then
       FreeAndNil(map);

  end;
end;


class procedure TSincronizarTabelas.GravarDataSincronizacao(
  const Data: TDateTime; const Status: TStatusAtualizacao; const Log : string);
var
  bd: TObjetoDB;
begin
  bd:= TObjetoDB.create('CotroleSincronizacao');
  try
    bd.AddParametro('dtsincronizacao', Data);

    case Status of
      saSucesso: bd.AddParametro('Status', 'S');
      saError: bd.AddParametro('Status', 'E');
    end;

    bd.AddParametro('Log', Log);
    bd.Insert;
  finally
    FreeAndNil(bd);
  end;
end;

class function TSincronizarTabelas.MapaEstado(const MarcarCampoPai: Boolean = False): TListaMapaValor;
var
  map : TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro', '');
  map.Add('cdestado', 'cdestado', '');
  map.Add('nmestado', 'nmestado', '');
  map.Add('sgestado', 'sgestado', '');

  if MarcarCampoPai then
    map.Add('pais_id', 'pais_id', 'fk')
  else
    map.Add('pais', 'pais_id', '');

  map.Add('dsregiao', 'dsregiao', '');
  Result:= map;
end;

class function TSincronizarTabelas.MapaPais: TListaMapaValor;
var
  map : TListaMapaValor;
begin
  //pais
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro', '');
  map.Add('cdpais', 'cdpais', '');
  map.Add('nmpais', 'nmpais', '');
  map.Add('cdsiscomex', 'cdsiscomex', '');
  map.Add('sgpais2', 'sgpais2', '');
  map.Add('sgpais3', 'sgpais3', '');
  Result:= map;
end;

class function TSincronizarTabelas.Sincronizado: Boolean;
var
  bdDtSinc: TObjetoDB;
  bdParamSinc: TObjetoDB;
  diferencaMinutos : Integer;
  minutosParaIntervalo: Integer;
begin
  Result:= True;
  bdDtSinc:= TObjetoDB.create('CotroleSincronizacao');
  bdParamSinc:= TObjetoDB.create('ParametrosSincronizacao');
  try
    bdDtSinc.AddParametro('Status', 'S');
    bdDtSinc.Select(['IFNULL(MAX(dtsincronizacao), DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -1000 YEAR)) AS Data']);
    bdParamSinc.Select(['IntervaloHora', 'IntervaloMinuto']);

    if bdParamSinc.IsEmpty then
    begin
      Result:= False;
      Exit;
    end;

    diferencaMinutos:= MinutesBetween(bdDtSinc.GetVal('Data'), now);
    minutosParaIntervalo:= (bdParamSinc.GetVal('IntervaloHora') * 60) + bdParamSinc.GetVal('IntervaloMinuto');

    if diferencaMinutos >= minutosParaIntervalo then
      Result:= False;

  finally
    FreeAndNil(bdDtSinc);
    FreeAndNil(bdParamSinc);
  end;
end;

class function TSincronizarTabelas.Sincronizar(const SincronizacaoForcada: Boolean): String;
var
  Empresa, Unidade, Almoxarifado: Integer;
  DataInicio : TDateTime;
  dbBuscaParametros : TObjetoDB;

begin
  Result:= EmptyStr;
  if (Sincronizado) and (not SincronizacaoForcada) then
    Exit;

  dbBuscaParametros:= TObjetoDB.create('empresa');
  try
    dbBuscaParametros.Select(['id']);
    Empresa:= dbBuscaParametros.GetVal('id')
  finally
    FreeAndNil(dbBuscaParametros);
  end;

  dbBuscaParametros:= TObjetoDB.create('unidade');
  try
    dbBuscaParametros.Select(['id']);
    Unidade:= dbBuscaParametros.GetVal('id')
  finally
    FreeAndNil(dbBuscaParametros);
  end;

  dbBuscaParametros:= TObjetoDB.create('Almoxarifado');
  try
    dbBuscaParametros.Select(['id']);
    Almoxarifado:= dbBuscaParametros.GetVal('id');
  finally
    FreeAndNil(dbBuscaParametros);
  end;

  DataInicio:= Now;
  
  Result := Download(Empresa, Unidade, Almoxarifado);

  if Result <> EmptyStr then
  begin
     GravarDataSincronizacao(DataInicio, saError, Result);
     Exit;
  end;

  Result:= Upload;

  if Result <> EmptyStr then
  begin
     GravarDataSincronizacao(DataInicio, saError, Result);
     Exit;
  end;

  //GravarDataSincronizacao(DataInicio, saSucesso, EmptyStr);


end;


class function TSincronizarTabelas.Upload: string;
var
  upload: TUpload;
  mapPais, mapEstado: TListaMapaValor;
begin
  Result:= EmptyStr;
  try try
    mapPais:= MapaPais;
    mapEstado:= MapaEstado(True);

    upload:= TUpload.create('Pais', 'cadastro.pais.models', mapPais, 'id');
    upload.AddModelFilho('Estado', 'cadastro.estado.models', 'id', 'Estado', 'Pais',
      mapEstado);

    Result:= upload.GetURLUpload;
  except
    on E:Exception do
    begin
      Result:= E.Message;
    end;
  end;
  finally
    FreeAndNil(mapPais);
    FreeAndNil(mapEstado);
    FreeAndNil(upload);
  end;
end;

{ TSincronizacaoBase }

constructor TSincronizacaoBase.create(const model, module: string; const CamposWebLocal: TListaMapaValor; const ChavesTabela: string;
      const TabelaLocal: string = '');
var
  bdSinc: TObjetoDB;
begin
  bdSinc:= TObjetoDB.create('ParametrosSincronizacao');
  FUrlBase:= '';
  try
    bdSinc.Select(['IpSincronizacao']);
    FUrlBase:= bdSinc.GetVal('IpSincronizacao');
  finally
    FreeAndNil(bdSinc);
  end;

  FUrlToGetXML:= FUrlBase + URL_PARCIAL_GET_XML;
  FUrlToSendXML:= FUrlBase + URL_PARCIAL_SEND_XML;
  Fmodel:= model;
  FModulo:= module;

  if TabelaLocal = EmptyStr then
     FTabelaLocal:= Fmodel
  else
    FTabelaLocal:= TabelaLocal;

  FChavesTabela:= ChavesTabela + ',';
  FCamposWebLocal:= CamposWebLocal;
end;

constructor TUpload.create(const model, module: string; const CamposWebLocal: TListaMapaValor;
  const ChavesTabela: string; const TabelaLocal: string = '');
begin
  inherited;
  ConfigurarCdsConfUpload;
  AddMapaTabelaPrinciapal;
end;

destructor TUpload.destroy;
begin
  FreeAndNil(FCdsConfUpload);
  inherited;   
end;

procedure TUpload.FilterCds(cds: TClientDataSet; const Filtro: String);
begin
  cds.Filtered:= False;
  cds.Filter:= Filtro;
  cds.Filtered:= True;
end;

function TUpload.GetURLUpload: String;
begin
  Result:= FUrlToSendXML + '?data={' + GetJsonParcial(Fmodel, EmptyStr, FModulo, Null) + '}';
end;

function TUpload.GetJsonParcial(const Model, ModelPai, Module: string;
  const ValorCampoPai: Variant): string;
  var
   cdsPaiTemp, cdsFilhosTemp, cdsFiltro: TClientDataSet;
   dbGetValores: TObjetoDB;
   tabelaLocal, json: string;

begin
  cdsPaiTemp:= TClientDataSet.Create(nil);
  cdsFilhosTemp:= TClientDataSet.Create(nil);
  cdsFiltro:= TClientDataSet.Create(nil);
  try
    cdsPaiTemp.Data:= FCdsModels.Data;
    cdsFiltro.Data:= FCdsConfUpload.Data;

    FilterCds(cdsPaiTemp, 'Model = ' + QuotedStr(Model));
    tabelaLocal:= cdsPaiTemp.FieldByName('TabelaLocal').AsString;
    dbGetValores:= TObjetoDB.create(tabelaLocal);

    json:= '"model":"' + Model + '","module":"' + Module + '",';

    if ModelPai <> EmptyStr then
    begin
      FilterCds(cdsFiltro, 'Model = ' + QuotedStr(Model) + ' and NomeCampoPai <> ' + QuotedStr('*'));
      json:= json + '"parent_field":"' + cdsFiltro.FieldByName('CampoWeb').AsString + '",';
      dbGetValores.AddParametro(cdsFiltro.FieldByName('NomeCampoPai').AsString, ValorCampoPai);
    end;

    json:= json + '"rws":[';

    dbGetValores.Select(['*']);
    dbGetValores.First;
    while not dbGetValores.Eof do
    begin
      json:= json + '{';
      FilterCds(cdsFiltro, 'Model = ' + QuotedStr(Model));
      cdsFiltro.First;
      while not cdsFiltro.Eof do
      begin
        json:= json + '"' + cdsFiltro.FieldByName('CampoWeb').AsString + '":';
        json:= json + '"' + VarToStr(dbGetValores.GetVal(cdsFiltro.FieldByName('CampoLocal').AsString)) + '"';

        cdsFiltro.Next;

        if not cdsFiltro.Eof then
          json:= json + ',';
      end;

      FilterCds(cdsPaiTemp, 'ModelPai = ' + QuotedStr(Model));

      if not cdsPaiTemp.IsEmpty then
      begin
        json:= json + ',"model_child":[';
      end;

      cdsPaiTemp.First;
      while not cdsPaiTemp.Eof do
      begin
        FilterCds(cdsFiltro, 'Model=' + QuotedStr(cdsPaiTemp.FieldByName('Model').AsString)  +
          ' and NomeCampoPai <> ' + QuotedStr('*'));

        json:= json + '{';

        json:= json + GetJsonParcial(cdsPaiTemp.FieldByName('Model').AsString, Model,
          cdsPaiTemp.FieldByName('Module').AsString,
          dbGetValores.GetVal(cdsFiltro.FieldByName('NomeCampoPai').AsString));

        json:= json + '}';

        cdsPaiTemp.Next;

        if not cdsPaiTemp.Eof then
          json:= json + ',';
      end;

      if not cdsPaiTemp.IsEmpty then
      begin
        json:= json + ']';
      end;
      json:= json + '}';
      dbGetValores.Next;

      if not dbGetValores.Eof then
        json:= json + ',';
    end;
    json:= json + ']';
    Result:= json;
  finally
    if Assigned(dbGetValores) then
      FreeAndNil(dbGetValores);

    FreeAndNil(cdsPaiTemp);
    FreeAndNil(cdsFilhosTemp);
  end;

end;

end.


