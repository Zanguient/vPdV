unit lib_sincronizacao;

interface

uses IdHTTP, SysUtils, Windows, Classes, Variants, Dialogs, XMLDoc, XMLIntf, DateUtils, lib_db,
     DB, DBClient, IdURI, IdCookie;
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
    FDataUltimaSinc: TDateTime;
    function VariantValueToStr(const value: Variant): String;    
  protected
    procedure PreencheDataUltimaSinc;
    function GetUrlParametersLogin : String;
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
    FResponse: string;
    procedure ConfigurarCdsConfUpload;
    procedure AddRegistroMapa(Model, Module, CampoWeb, CampoLocal, TabelaLocal, ModelPai,
      NomeCampoPai, ChaveModelWeb, ValorFixo: String);
    procedure AddMapaTabelaPrincipal;
    procedure FilterCds(cds: TClientDataSet; const Filtro: String);
    function GetJsonParcial(const Model, ModelPai, Module: string; const ValorCampoPai: Variant): string;
    function GetURLUpload: String;
    function GetResponseError: String;
    procedure SetIdWeb;
  protected
    procedure ExecuteQuery(qry: TObjetoDB);virtual; 
  public
    procedure AddModelFilho(const Model, Module, ChavesTabela, TabelaLocal, ModelPai: string;
      const CamposWebLocal: TListaMapaValor; const NomeCampoTabelaPai: string = 'id');
    procedure SendData;
    constructor create(const model, module: string; const CamposWebLocal: TListaMapaValor;
      const ChavesTabela: string; const TabelaLocal: string = ''); override;
    destructor destroy; override;
  end;

  TTipoSincronizacao = (tsUpload, tsDownload);

  TMapeamento = class(TObject)
  private
    FTipoSincronizacao: TTipoSincronizacao;
    FEmpresa: Integer;
    FUnidade: Integer;
    FAlmoxarifado: Integer;
  public
    procedure AddEmpresaUpload(mapa: TListaMapaValor);
    procedure AddUnidadeUpload(mapa: TListaMapaValor);
    procedure AddAlmoxarifadoUpload(mapa: TListaMapaValor);

    function MapaPais: TListaMapaValor;
    function MapaEstado: TListaMapaValor;
    function MapaCidade: TListaMapaValor;
    function MapaBairro: TListaMapaValor;
    function MapaCliente: TListaMapaValor;
    function MapaFornecedor: TListaMapaValor;
    function MapaUnidadeMedida: TListaMapaValor;
    function MapaProduto: TListaMapaValor;
    function MapaFinalidade: TListaMapaValor;
    function MapaEntrada: TListaMapaValor;
    function MapaSaida: TListaMapaValor;
    function MapaItemProduto: TListaMapaValor;
    function MapaLote: TListaMapaValor;
    function MapaPosEstoque: TListaMapaValor;
    function MapaAgrupAdicional: TListaMapaValor;
    function MapaCategoria: TListaMapaValor;
    function MapaComposicaoProd: TListaMapaValor;
    function MapaItemCategoria: TListaMapaValor;
    function MapaItAgrupAdicional: TListaMapaValor;
    function MapaMesa: TListaMapaValor;
    function MapaAdicionais: TListaMapaValor;
    function MapaPedido: TListaMapaValor;
    function MapaItempedido: TListaMapaValor;
    function MapaItAdicional: TListaMapaValor;
    function MapaAberfechcaixa: TListaMapaValor;
    function MapaMovCaixa: TListaMapaValor;
    function MapaFuncionario: TListaMapaValor;
    constructor create(const TipoSincroniacao: TTipoSincronizacao;
      const Empresa, Unidade, Almoxarifado: Integer);
  end;

  TSincronizarTabelas = class
  public

    class function Sincronizado : Boolean;
    class procedure GravarDataSincronizacao(const Data: TDateTime; const Status: TStatusAtualizacao;
      const Log : string);
    class function Download(const Empresa, Unidade, Almoxarifado: Integer): String;
    class function Upload(const Empresa, Unidade, Almoxarifado: Integer): string;
    class function Sincronizar(const SincronizacaoForcada: Boolean): String;
  end;
implementation

uses StrUtils, lib_tratamentos_sincronizacao, uDmConexao;


const
   SENHA_VMSIS = 'masterVMSIS123v';
   USUARIO_VMSIS = 'vmsismaster';
   URL_PARCIAL_GET_XML = '/getmodelasxml/';
   URL_PARCIAL_SEND_XML = '/savejsonasmodel/';
   NOME_CHAVE_PADRAO_FK = '[[*****{{FIELD_CONSIDER_FOREIGN_KEY}}****]]';


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
    url_param := FUrlToGetXML + Format('?model=%s&module=%s&DataInicial=%s%s', [Fmodel, FModulo,
      VariantValueToStr(FDataUltimaSinc) ,GetUrlParametersLogin]);

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
  i, k, j: Integer;
  doc: IXMLDocument;
  row, field: IXMLNode;
  campos, campo_atual, campo_fk, valor_adicional: string;
  lista_camposChave: TStringList;
  add_to_ignore, validar_chave : Boolean;
begin
  bd:= TObjetoDB.create(FTabelaLocal);
  doc:= TXMLDocument.Create(nil);
  lista_camposChave:= TStringList.Create;

  try
    validar_chave:= True;  
    lista_camposChave.Delimiter:= '|';
    lista_camposChave.DelimitedText:= FChavesTabela;

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
        if validar_chave then
        begin
          for j:= 0 to lista_camposChave.Count - 1 do
          begin
            if Pos(campo_atual + ',', lista_camposChave[0] + ',') = 0 then
            begin
              add_to_ignore:= True
            end
            else
            begin
              if campo_atual = lista_camposChave[0] then
              begin
                bd.Select(['*']);
                validar_chave:= bd.IsEmpty;
                if not validar_chave then
                  break;
              end
              else
              begin
                add_to_ignore:= False;
              end;
            end
          end;
        end;

        if add_to_ignore then
          bd.AddIgnoreParam(campo_atual)

      end;
      bd.AddParametro('id_web', row.Attributes['pk']);

      if Pos('pk,', FChavesTabela) = 0 then
        bd.AddIgnoreParam('id_web');
      if validar_chave then
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


procedure TUpload.AddMapaTabelaPrincipal;
var
  i: Integer;
  ValorAdicional: string;
begin
  for i:= 0 to FCamposWebLocal.Count - 1 do
  begin
    ValorAdicional:= FCamposWebLocal.GetAdicional(i);

    if ValorAdicional = NOME_CHAVE_PADRAO_FK then
      ValorAdicionaL:= EmptyStr;

    AddRegistroMapa(Fmodel, FModulo, FCamposWebLocal.GetKey(i), FCamposWebLocal.GetValue(i),
      FTabelaLocal, EmptyStr, EmptyStr, FChavesTabela, ValorAdicional);
  end;
end;

procedure TUpload.AddModelFilho(const Model, Module, ChavesTabela,
  TabelaLocal, ModelPai: string; const CamposWebLocal: TListaMapaValor;
  const NomeCampoTabelaPai: string = 'id');
var
  i: Integer;
  ValorAdicional: string;
begin
  for i:= 0 to CamposWebLocal.Count - 1 do
  begin
    ValorAdicional:= CamposWebLocal.GetAdicional(i);
    if ValorAdicional = NOME_CHAVE_PADRAO_FK then
    begin
      AddRegistroMapa(Model, Module, CamposWebLocal.GetKey(i), CamposWebLocal.GetValue(i),
        TabelaLocal, ModelPai, NomeCampoTabelaPai, ChavesTabela, EmptyStr);
    end
    else
    begin
      AddRegistroMapa(Model, Module, CamposWebLocal.GetKey(i), CamposWebLocal.GetValue(i),
        TabelaLocal, ModelPai, EmptyStr, ChavesTabela, ValorAdicional);
    end;
  end;

end;

procedure TUpload.AddRegistroMapa(Model, Module, CampoWeb, CampoLocal, TabelaLocal, ModelPai,
  NomeCampoPai, ChaveModelWeb, ValorFixo: String);

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
  FCdsConfUpload.FieldByName('ValorFixo').AsString:= ValorFixo;
  FCdsConfUpload.Post;

  if not FCdsModels.Locate('Model', VarArrayOf([Model]), [loCaseInsensitive]) then
  begin
    FCdsModels.Insert;
    FCdsModels.FieldByName('Model').AsString:= AsteriscoSeVazio(Model);
    FCdsModels.FieldByName('Module').AsString:= AsteriscoSeVazio(Module);
    FCdsModels.FieldByName('TabelaLocal').AsString:= AsteriscoSeVazio(TabelaLocal);
    FCdsModels.FieldByName('ModelPai').AsString:= AsteriscoSeVazio(ModelPai);
    FCdsModels.FieldByName('ChavesTabelaWeb').AsString:= ChaveModelWeb;
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
    FCdsConfUpload.FieldDefs.Add('ValorFixo', ftString, 300);
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
    FCdsModels.FieldDefs.Add('ChavesTabelaWeb', ftString, 255);
    FCdsModels.CreateDataSet;
  end;
  FCdsModels.IndexFieldNames:= 'Sequencial';
end;

{ TSincronizarTabelas }

class function TSincronizarTabelas.Download(const Empresa, Unidade, Almoxarifado: Integer): String;
var
  sinc : TSincronizacao;
  map : TListaMapaValor;
  mapaCampos: TMapeamento;
begin
  dmConexao.adoConexaoBd.BeginTrans;
  mapaCampos:= TMapeamento.create(tsDownload, Empresa, Unidade, Almoxarifado);
  try try
    //pais
    map:= mapaCampos.MapaPais;
    sinc := TSincronizacao.create('pais', 'cadastro.localidades.pais.models', map, 'cdpais', 'pais');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //estado
    map:= mapaCampos.MapaEstado;
    sinc := TSincronizacao.create('estado', 'cadastro.localidades.estado.models', map, 'cdestado|sgestado', 'estado');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //cidade
    map := mapaCampos.MapaCidade;
    sinc := TSincronizacao.create('cidade', 'cadastro.localidades.cidade.models', map, 'cdcidade', 'cidade');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);


    //bairro
    map := mapaCampos.MapaBairro;
    sinc := TSincronizacao.create('bairro', 'cadastro.localidades.bairro.models', map, 'cdbairro', 'bairro');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //funcionario
    map:= mapaCampos.MapaFuncionario;
    sinc:= TSincronizacao.create('Funcionario', 'cadastro.funcionario.models', map, 'usuario');
    sinc.FiltroDownload:= Format('{"unidade":"%d"}', [Unidade]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //cliente
    map := mapaCampos.MapaCliente;
    sinc := TSincronizacao.create('cliente', 'cadastro.cliente.models', map, 'telcel', 'cliente');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //fornecedor
    map := mapaCampos.MapaFornecedor;
    sinc := TSincronizacao.create('fornecedor', 'cadastro.fornecedor.models', map, 'telcel', 'fornecedor');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //unimedida
    map := mapaCampos.MapaUnidadeMedida;
    sinc := TSincronizacao.create('unimedida', 'cadastro.unimedida.models', map, 'nmmedida', 'unimedida');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //produto
    map := mapaCampos.MapaProduto;
    sinc := TSincronizacao.create('produto', 'cadastro.produto.models', map, 'nmproduto', 'produto');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);


    //finalidade
    map := mapaCampos.MapaFinalidade;
    sinc := TSincronizacao.create('finalidade', 'estoque.cadastro_estoque.finalidade.models', map, 'descricao', 'finalidade');
    sinc.FiltroDownload:= format('{"empresa":"%d"}', [Empresa]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //entrada - estoque()
    map := mapaCampos.MapaEntrada;
    sinc := TSincronizacao.create('Entrada', 'estoque.entrada.models', map, 'pk', 'Entrada');
    sinc.FiltroDownload:= format('{"unidade_id":"%d"}', [Unidade]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //saida
    map := mapaCampos.MapaSaida;
    sinc := TSincronizacao.create('Saida', 'estoque.saida.models', map, 'pk', 'Saida');
    sinc.FiltroDownload:= format('{"unidade_id":"%d"}', [Unidade]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //itemproduto
    map := mapaCampos.MapaItemProduto;
    sinc := TSincronizacao.create('Itemproduto', 'estoque.itemproduto.models', map, 'pk', 'Itemproduto');
    sinc.FiltroDownload:= format('{"almoxarifado_id":"%d"}', [Almoxarifado]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);
    
    TTratamentos.PreencherIdEntradaSaidaItemProduto;

    //lote
    map := mapaCampos.MapaLote;
    sinc := TSincronizacao.create('Lote', 'estoque.lote.models', map, 'pk', 'Lote');
    sinc.FiltroDownload:= format('{"unidade_id":"%d"}', [Unidade]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //posestoque
    map := mapaCampos.MapaPosEstoque;
    sinc := TSincronizacao.create('posestoque', 'estoque.posestoque.models', map, 'pk', 'posestoque');
    sinc.FiltroDownload:= format('{"almoxarifado_id":"%d"}', [Almoxarifado]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //AgrupAdicional
    map := mapaCampos.MapaAgrupAdicional;
    sinc := TSincronizacao.create('AgrupAdicional', 'pedido.cadastro_pedido.agrupadicional.models',
      map, 'pk', 'AgrupAdicional');
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //Categoria
    map := mapaCampos.MapaCategoria;
    sinc := TSincronizacao.create('categoria', 'pedido.cadastro_pedido.categoria.models',
      map, 'pk', 'categoria');
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //ComposicaoProd
    map := mapaCampos.MapaComposicaoProd;
    sinc := TSincronizacao.create('ComposicaoProd', 'pedido.cadastro_pedido.composicaoproduto.models',
      map, 'pk', 'ComposicaoProd');
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //ItemCategoria
    map := mapaCampos.MapaItemCategoria;
    sinc := TSincronizacao.create('ItemCategoria', 'pedido.cadastro_pedido.itemcategoria.models',
      map, 'pk', 'ItemCategoria');
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //itagrupadicional
    map := mapaCampos.MapaItAgrupAdicional;
    sinc := TSincronizacao.create('itagrupadicional', 'pedido.cadastro_pedido.itemcategoria.models',
      map, 'pk', 'itagrupadicional');
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //mesa
    map := mapaCampos.MapaMesa;
    sinc := TSincronizacao.create('Mesa', 'pedido.cadastro_pedido.mesa.models', map, 'nmmesa', 'Mesa');
    sinc.FiltroDownload:= format('{"unidade_id":"%d"}', [Unidade]);
    sinc.GetWebData;
    FreeAndNil(sinc);
    FreeAndNil(map);

    //adicionais
    map := mapaCampos.MapaAdicionais;
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

{  Result:= Upload(Empresa, Unidade, Almoxarifado);

  if Result <> EmptyStr then
  begin
    GravarDataSincronizacao(DataInicio, saError, Result);
    Exit;
  end;

  GravarDataSincronizacao(DataInicio, saSucesso, EmptyStr);}


end;


class function TSincronizarTabelas.Upload(const Empresa, Unidade, Almoxarifado: Integer): string;
var
  upload: TUpload;
  mapaCampos: TMapeamento;
  map, mapItemProduto, mapItemPedido, mapItAdicional: TListaMapaValor;

begin
  Result:= EmptyStr;
  mapaCampos:= TMapeamento.create(tsUpload, Empresa, Unidade, Almoxarifado);
  dmConexao.adoConexaoBd.BeginTrans;
  try try

    map:= mapaCampos.MapaPais;
    upload:= TUpload.create('Pais', 'cadastro.localidade.pais.models', map, 'cdpais');
    upload.SendData;

    map:= mapaCampos.MapaEstado;
    FreeAndNil(upload);         
    upload:= TUpload.create('Estado', 'cadastro.localidade.estado.models', map, 'sgestado|cdestado');
    upload.SendData;

    map:= mapaCampos.MapaCidade;
    FreeAndNil(upload);
    upload:= TUpload.create('Cidade', 'cadastro.localidade.cidade.models', map, 'cdcidade');
    upload.SendData;

    map:= mapaCampos.MapaBairro;
    FreeAndNil(upload);
    upload:= TUpload.create('Bairro', 'cadastro.localidade.bairro.models', map, 'cdbairro');
    upload.SendData;

    FreeAndNil(upload);
    map:= mapaCampos.MapaCliente;
    upload:= TUpload.create('Cliente', 'cadastro.cliente.models', map, 'telcel');
    upload.SendData;

    FreeAndNil(upload);
    map:= mapaCampos.MapaFornecedor;
    upload:= TUpload.create('Fornecedor', 'cadastro.fornecedor.models', map, 'nrinscjurd');
    upload.SendData;

    FreeAndNil(upload);
    map:= mapaCampos.MapaEntrada;
    upload:= TUpload.create('Entrada', 'estoque.entrada.models', map, 'id_desktop');
    mapItemProduto:= mapaCampos.MapaItemProduto;
    mapItemProduto.Add('master_moviest', 'entrada_id', NOME_CHAVE_PADRAO_FK);
    upload.AddModelFilho('Itemproduto', 'estoque.itemproduto.models', 'id_desktop', 'Itemproduto',
      'Entrada', mapItemProduto);
    upload.SendData;

    FreeAndNil(upload);
    map:= mapaCampos.MapaSaida;
    upload:= TUpload.create('Saida', 'estoque.saida.models', map, 'id_desktop');
    mapItemProduto:= mapaCampos.MapaItemProduto;
    mapItemProduto.Add('master_moviest', 'saida_id', NOME_CHAVE_PADRAO_FK);
    upload.AddModelFilho('Itemproduto', 'estoque.itemproduto.models', 'id_desktop', 'Itemproduto',
      'Entrada', mapItemProduto);
    upload.SendData;

    FreeAndNil(upload);
    map:= mapaCampos.MapaPosEstoque;
    upload:= TUpload.create('Posestoque', 'estoque.posestoque.models', map, 'id_desktop');
    upload.SendData;

    FreeAndNil(upload);
    map:= mapaCampos.MapaPedido;
    upload:= TUpload.create('Pedido', 'pedido.frentecaixa.models', map, 'id_desktop');

    mapItemPedido:= mapaCampos.MapaItempedido;
    upload.AddModelFilho('ItemPedido', 'pedido.frentecaixa.models', 'id',
      'ItemPedido', 'Pedido', mapItemPedido);

    mapItAdicional:= mapaCampos.MapaItAdicional;
    upload.AddModelFilho('ItAdicional', 'pedido.frentecaixa.models', 'id',
      'ItAdicional', 'ItemPedido', mapItAdicional);

    upload.SendData;

    FreeAndNil(upload);
    map:= mapaCampos.MapaAberfechcaixa;
    upload:= TUpload.create('AberFechCaixa', 'pedido.aberfechcaixa.models', map, 'id_desktop');
    upload.SendData;

    FreeAndNil(upload);
    map:= mapaCampos.MapaAberfechcaixa;
    upload:= TUpload.create('MovCaixa', 'pedido.movcaixa.models', map, 'id_desktop');
    upload.SendData;
    dmConexao.adoConexaoBd.CommitTrans;
  except
    on E:Exception do
    begin
      dmConexao.adoConexaoBd.RollbackTrans;
      Result:= E.Message;
    end;
  end;
  finally
    if Assigned(upload) then
      FreeAndNil(upload);
    if Assigned(mapItemProduto) then
      FreeAndNil(mapItemProduto);
    if Assigned(mapaCampos) then
      FreeAndNil(mapaCampos);
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
  PreencheDataUltimaSinc;
end;

constructor TUpload.create(const model, module: string; const CamposWebLocal: TListaMapaValor;
  const ChavesTabela: string; const TabelaLocal: string = '');
begin
  inherited;
  ConfigurarCdsConfUpload;
  AddMapaTabelaPrincipal;
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

    if Assigned(dbGetValores) then
      FreeAndNil(dbGetValores);

    dbGetValores:= TObjetoDB.create(tabelaLocal);

    json:= '"model":"' + Model + '","module":"' + Module + '", "chaves":"' +
      cdsPaiTemp.FieldByName('ChavesTabelaWeb').AsString + '",';

    if ModelPai <> EmptyStr then
    begin
      FilterCds(cdsFiltro, 'Model = ' + QuotedStr(Model) + ' and NomeCampoPai <> ' + QuotedStr('*'));
      json:= json + '"parent_field":"' + cdsFiltro.FieldByName('CampoWeb').AsString + '",';
      dbGetValores.AddParametro(cdsFiltro.FieldByName('NomeCampoPai').AsString, ValorCampoPai);
    end;

    json:= json + '"rws":[';

    if dbGetValores.ParamCount > 0 then
    begin
      dbGetValores.AddSqlAdicional(
      ' AND (dtCreated >= :Data '+ #13 +
      ' OR  ModifiedTime >= :Data1 '+ #13 +
      ' OR id_web is null) '
      );
    end
    else
    begin
      dbGetValores.AddSqlAdicional(
      ' WHERE (dtCreated >= :Data '+ #13 +
      ' OR  ModifiedTime >= :Data1 '+ #13 +
      ' OR id_web is null) '
      );
    end;
    dbGetValores.FNomesParamAdic:= varArrayOf(['Data', 'Data1']);
    dbGetValores.FValoresParamAdic:= varArrayOf([FDataUltimaSinc, FDataUltimaSinc]);
    ExecuteQuery(dbGetValores);

    dbGetValores.First;
    while not dbGetValores.Eof do
    begin
      json:= json + '{';
      FilterCds(cdsFiltro, 'Model = ' + QuotedStr(Model));
      cdsFiltro.First;
      while not cdsFiltro.Eof do
      begin
        json:= json + '"' + cdsFiltro.FieldByName('CampoWeb').AsString + '":';
        if cdsFiltro.FieldByName('ValorFixo').AsString = EmptyStr then
        begin
          json:= json + '"' + VariantValueToStr(dbGetValores.GetVal(cdsFiltro.FieldByName('CampoLocal').AsString)) + '"';
        end
        else
        begin
          json:= json + '"' + cdsFiltro.FieldByName('ValorFixo').AsString + '"';
        end;


        cdsFiltro.Next;

        if not cdsFiltro.Eof then
          json:= json + ',';
      end;

      //campo para mapear os ids do web com o do desktop
      json:= json + ',"desktop_id":' + '"' + VarToStr(dbGetValores.GetVal('id')) + '"';

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

procedure TUpload.SendData;
var
  url_param : string;
  http : TIdHTTP;
  error: string;
  param: TStringList;
begin
  http := TIdHTTP.Create(nil);
  param:= TStringList.Create;
  try

    param.Add('senha='+SENHA_VMSIS);
    param.Add('usuario=' + USUARIO_VMSIS);
    param.Add('data={'+GetJsonParcial(Fmodel, EmptyStr, FModulo, Null) + '}');

    http.AllowCookies := True;
    http.HandleRedirects := False;
    http.Request.Accept         := 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8';
    http.Request.AcceptCharSet  := 'iso-8859-1, utf-8, utf-16, *;q=0.1';
    http.Request.AcceptEncoding := 'gzip, deflate, sdch';
    http.Request.Connection     := 'Keep-Alive';
    http.Request.ContentType    := 'application/x-www-form-urlencoded';
    http.Request.UserAgent      := 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36';
    FResponse:= http.Post(FUrlToSendXML, param);

    error:= GetResponseError;
    if error = EmptyStr then
      SetIdWeb()
    else
      raise Exception.Create(error);

  finally
    FreeAndNil(http);
    FreeAndNil(param);
  end;
end;

function TSincronizacaoBase.GetUrlParametersLogin: String;
begin
   Result:= Format('&usuario=%s&senha=%s', [USUARIO_VMSIS, SENHA_VMSIS])
end;

function TSincronizacaoBase.VariantValueToStr(const value: Variant): String;
begin
  case VarType(value) of
    varDate: Result:= FormatDateTime('yyyy-mm-dd', value);
    varDouble, varCurrency: Result:= StringReplace(VarToStr(value), ',', '.', [rfReplaceAll]);
  else                       
    Result:= VarToStr(value);
  end
end;

procedure TSincronizacaoBase.PreencheDataUltimaSinc;
var
  bdDtSinc: TObjetoDB;
begin
  bdDtSinc:= TObjetoDB.create('cotrolesincronizacao');
  try
    bdDtSinc.AddParametro('Status', 'S');
    bdDtSinc.Select(['IFNULL(MAX(dtsincronizacao), DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -1 YEAR)) AS Data']);
    FDataUltimaSinc:= bdDtSinc.GetVal('Data');//VariantValueToStr(bdDtSinc.GetVal('Data'));
  finally
    FreeAndNil(bdDtSinc);
  end;

end;

{ TMapeamento }

function TMapeamento.MapaCliente: TListaMapaValor;
var
  map: TListaMapaValor;
begin
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
  AddEmpresaUpload(map);
  Result:= map;
end;

constructor TMapeamento.create(const TipoSincroniacao: TTipoSincronizacao;
      const Empresa, Unidade, Almoxarifado: Integer);
begin
  FTipoSincronizacao:= TipoSincroniacao;
  FUnidade:= Unidade;
  FEmpresa:= Empresa;
  FAlmoxarifado:= Almoxarifado;

end;

function TMapeamento.MapaBairro: TListaMapaValor;
var
  map: TListaMapaValor;
begin                               
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro', '');
  map.Add('cdbairro', 'cdbairro', '');
  map.Add('nmbairro', 'nmbairro', '');
  map.Add('cidade', 'cidade_id', '');
  AddEmpresaUpload(map);
  Result:= map;
end;

function TMapeamento.MapaCidade: TListaMapaValor;
var
  map : TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro', '');
  map.Add('cdcidade', 'cdcidade', '');
  map.Add('nmcidade', 'nmcidade', '');
  map.Add('pais', 'pais_id', '');
  map.Add('estado', 'estado_id', '');
  AddEmpresaUpload(map);
  Result:= map;
end;

function TMapeamento.MapaEstado: TListaMapaValor;
var
  map : TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro', '');
  map.Add('cdestado', 'cdestado', '');
  map.Add('nmestado', 'nmestado', '');
  map.Add('sgestado', 'sgestado', '');
  map.Add('dsregiao', 'dsregiao', '');
  map.Add('pais', 'pais_id', '');
  AddEmpresaUpload(map);


  Result:= map;

end;

function TMapeamento.MapaPais: TListaMapaValor;
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
  AddEmpresaUpload(map);

  Result:= map;

end;

function TUpload.GetResponseError: String;
begin
  Result:= EmptyStr;
  if UpperCase(Copy(FResponse, 1, 5)) = 'ERROR' then
  begin
    Result:= Copy(FResponse, 7, Length(FResponse));
    if Trim(Result) = EmptyStr then
      Result:= 'Erro desconheido ao realizar upload'; 
  end;
end;

procedure TUpload.SetIdWeb;
var
  splitModel, splitIds: TStringList;
  i: Integer;
  nomeModel, idWeb, idDesktop, tabelaLocal, linhaModel, linhaId: string;
  dbUpdateValue: TObjetoDB;
const
  C_IDX_MODEL = 0;
  C_IDX_ID = 1;
begin
  splitModel:= TStringList.Create;
  splitids:= TStringList.Create;
  try
    splitModel.Delimiter:= '|';
    splitModel.DelimitedText:= FResponse;

    for i:= 0 to splitModel.Count - 1 do
    begin

      if (splitModel[i] = EmptyStr) or (UpperCase(splitModel[i]) = 'SUCCESS') then
        Continue;

      splitIds.Delimiter:= Pchar('')[0];
      splitIds.Delimiter:= ';';
      splitIds.DelimitedText:= splitModel[i];


      linhaModel:= splitIds[C_IDX_MODEL];
      linhaId:= splitIds[C_IDX_ID];
      nomeModel:= Copy(linhaModel, Pos('=', linhaModel) + 1, Length(linhaModel));
      idWeb:= Copy(linhaId, Pos(':', linhaId) + 1, Length(linhaId));
      idDesktop:= Copy(linhaId, 1, Pos(':', linhaId)-1);

      if FCdsModels.Locate('Model', varArrayOf([nomeModel]), [loCaseInsensitive]) then
      begin
        tabelaLocal:= FCdsModels.FieldByName('TabelaLocal').AsString;
      end
      else
      begin
        raise Exception.Create(Format('Não foi possível completar o update dos campos no desktop. '+
          'Model %s não encontrado.', [nomeModel]) );
      end;

      if Assigned(dbUpdateValue) then
        FreeAndNil(dbUpdateValue);

      dbUpdateValue:= TObjetoDB.create(tabelaLocal);
      dbUpdateValue.AddParametro('id', idDesktop);
      dbUpdateValue.AddParametroNewValueUp('id_web', idWeb);
      dbUpdateValue.Update;
    end;


  finally
    FreeAndNil(splitModel);
    FreeAndNil(splitIds);
    if Assigned(dbUpdateValue) then
      FreeAndNil(dbUpdateValue);
  end;
end;

procedure TUpload.ExecuteQuery(qry: TObjetoDB);
begin
   qry.Select(['*']);
end;

function TMapeamento.MapaFornecedor: TListaMapaValor;
var
  map: TListaMapaValor;
begin
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
  AddEmpresaUpload(map);
  Result:= map;
end;

function TMapeamento.MapaUnidadeMedida: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro', '');
  map.Add('nmmedida', 'nmmedida', '');
  map.Add('sgmedida', 'sgmedida', '');
  map.Add('qtfatorconv', 'qtfatorconv', '');
  map.Add('idtipomed', 'idtipomed', '');
  AddEmpresaUpload(map);
  Result:= map;
end;

function TMapeamento.MapaProduto: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro');
  map.Add('posarvore', 'posarvore');
  map.Add('nmproduto', 'nmproduto');
  map.Add('unimedida', 'unimedida_id');
  map.Add('cdbarra', 'cdbarra');
  map.Add('idprodvenda', 'idprodvenda');
  map.Add('idadicional', 'idadicional');
  map.Add('imgindex', 'imgindex');
  AddEmpresaUpload(map);
  Result:= map;
end;

function TMapeamento.MapaFinalidade: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro');
  map.Add('descricao', 'descricao');
  AddEmpresaUpload(map);
  Result:= map;
end;

function TMapeamento.MapaEntrada: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtentrada', 'dtentrada');
  map.Add('fornecedor', 'fornecedor_id');
  AddUnidadeUpload(map);
  Result:= map;
end;

function TMapeamento.MapaSaida: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtsaida', 'dtsaida');
  map.Add('cliente', 'cliente_id');
  map.Add('finalidade', 'finalidade_id');
  map.Add('idtipo', 'idtipo');
  AddUnidadeUpload(map);
  Result:= map;
end;

function TMapeamento.MapaItemProduto: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro');
  map.Add('produto', 'produto_id');
  map.Add('lote', 'lote_id');
  map.Add('qtdeprod', 'qtdeprod');
  AddEmpresaUpload(map);
  AddUnidadeUpload(map);
  AddAlmoxarifadoUpload(map);
  Result:= map;
end;

function TMapeamento.MapaLote: TListaMapaValor;
var
 map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro');
  map.Add('dslote', 'dslote');
  map.Add('dtvalidade', 'dtvalidade');
  map.Add('dtfabricacao', 'dtfabricacao');
  AddUnidadeUpload(map);
  Result:= map;
end;

function TMapeamento.MapaPosEstoque: TListaMapaValor;
var
 map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro');
  map.Add('produto', 'produto_id');
  map.Add('lote', 'lote_id');
  map.Add('qtdeproduto', 'qtdeproduto');
  AddEmpresaUpload(map);
  AddAlmoxarifadoUpload(map);
  Result:= map;
end;

function TMapeamento.MapaAgrupAdicional: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('nmagrupadic', 'nmagrupadic');
  map.Add('vragrupadic', 'vragrupadic');
  map.Add('idagrupativ', 'idagrupativ');
  Result:= map;
end;

function TMapeamento.MapaCategoria: TListaMapaValor;
var
  map:TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('nmcategoria', 'nmcategoria');
  map.Add('idcategoriativ', 'idcategoriativ');
  map.Add('imgindex', 'imgindex');
  Result:= map;
end;

function TMapeamento.MapaComposicaoProd: TListaMapaValor;
var
 map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('produto', 'produto_id');
  map.Add('prodcomp', 'prodcomp_id');
  map.Add('qtcomp', 'qtcomp');
  map.Add('unimedida', 'unimedida_id');
  Result:= map;
end;

function TMapeamento.MapaItemCategoria: TListaMapaValor;
var
 map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('categoria', 'categoria_id');
  map.Add('produto', 'produto_id');
  map.Add('vrvenda', 'vrvenda');
  map.Add('qtvenda', 'qtvenda');
  map.Add('qtadicgratis', 'qtadicgratis');
  map.Add('unimedida', 'unimedida_id');
  Result:= map;
end;

function TMapeamento.MapaItAgrupAdicional: TListaMapaValor;
var
 map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('cardapio', 'cardapio_id');
  map.Add('agrupadicional', 'agrupadicional_id');
  Result:= map;
end;

function TMapeamento.MapaMesa: TListaMapaValor;
var
 map: TListaMapaValor;
begin
  map := TListaMapaValor.create;
  map.Add('nmmesa', 'nmmesa');
  map.Add('dsobsmesa', 'dsobsmesa');
  map.Add('idmesaativ', 'idmesaativ');
  AddUnidadeUpload(map);
  Result:= map;
end;

function TMapeamento.MapaAdicionais: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map:= TListaMapaValor.create;
  map.Add('agrupadicional', 'agrupadicional_id');
  map.Add('item', 'item_id');
  map.Add('valor', 'valor');
  map.Add('quantidade', 'quantidade');
  Result:= map;
end;

procedure TMapeamento.AddEmpresaUpload(mapa: TListaMapaValor);
begin
  if FTipoSincronizacao = tsUpload then
  begin
    mapa.Add('empresa', '', IntToStr(FEmpresa));
  end;
end;

procedure TMapeamento.AddUnidadeUpload(mapa: TListaMapaValor);
begin
  if FTipoSincronizacao = tsUpload then
  begin
    mapa.Add('unidade', '', IntToStr(FUnidade));
  end;
end;

procedure TMapeamento.AddAlmoxarifadoUpload(mapa: TListaMapaValor);
begin
  if FTipoSincronizacao = tsUpload then
  begin
    mapa.Add('almoxarifado', '', IntToStr(FAlmoxarifado));
  end;

end;

function TMapeamento.MapaPedido: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map:= TListaMapaValor.create;
  map.Add('idtipopedido', 'idtipopedido');
  map.Add('cliente', 'cliente_id');
  map.Add('nmcliente', 'nmcliente');
  map.Add('mesa', 'mesa_id');
  map.Add('vrpedido', 'vrpedido');
  map.Add('idstatusped', 'idstatusped');
  map.Add('dsmotivo', 'dsmotivo');
  Result:= map;
end;

function TMapeamento.MapaItempedido: TListaMapaValor;
var
 map: TListaMapaValor;
begin
  map:= TListaMapaValor.create;
  map.Add('dtcadastro', 'dtcadastro');
  map.Add('pedido', 'pedido_id', NOME_CHAVE_PADRAO_FK);
  map.Add('cardapio', 'cardapio_id');
  AddAlmoxarifadoUpload(map);
  map.Add('lote', 'lote_id');
  map.Add('qtitem', 'qtitem');
  map.Add('vrvenda', 'vrvenda');
  map.Add('vrtotal', 'vrtotal');
  map.Add('idadicional', 'idadicional');
  map.Add('produto', 'Produto_id');
  Result:= map;
end;

function TMapeamento.MapaItAdicional: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map:= TListaMapaValor.create;
  map.Add('itempedido', 'itempedido_id', NOME_CHAVE_PADRAO_FK); 
  map.Add('item', 'item_id');
  map.Add('qtitem', 'qtitem');
  map.Add('valor', 'valor');
  map.Add('VrVenda', 'VrVenda');
  Result:= map;
end;

function TMapeamento.MapaAberfechcaixa: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map:= TListaMapaValor.create;
  map.Add('caixa', 'id_caixa');
  map.Add('vrinicial', 'vrinicial');
  map.Add('vrcorrigido', 'vrcorrigido');
  map.Add('vrvenda', 'vrvenda');
  map.Add('vrretirada', 'vrretirada');
  map.Add('vrsangria', 'vrsangria');
  map.Add('vrentrada', 'vrentrada');
  map.Add('vrdebio', 'vrdebio');
  map.Add('vrcredito', 'vrcredito');
  map.Add('dtmovi', 'dtmovi');
  map.Add('funciconfabertura', 'funciconfabertura');
  map.Add('funcipreabertura', 'funcipreabertura');
  map.Add('funcifechamento', 'funcifechamento');
  map.Add('status', 'status');
  Result:= map;

end;

function TMapeamento.MapaMovCaixa: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map:= TListaMapaValor.create;
  map.Add('caixa', 'id_caixa');
  map.Add('dtmovi', 'dtmovi');
  map.Add('vrmovi', 'vrmovi');
  map.Add('tpmovi', 'tpmovi');
  map.Add('formpgto', 'formpgto');
  map.Add('pedido', 'id_pedido');
  Result:= map;
end;

function TMapeamento.MapaFuncionario: TListaMapaValor;
var
  map: TListaMapaValor;
begin
  map:= TListaMapaValor.create;
  map.Add('nome', 'nome');
  map.Add('usuario', 'usuario');
  map.Add('sexo', 'sexo');
  map.Add('email', 'email');
  map.Add('senha', 'senha');
  map.Add('confsenha', 'confsenha');
  Result:= map;

end;

end.


