unit lib_modelo_impressao;

interface

uses
   Classes, WinInet, Dialogs, Windows, Forms,
   IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient,
   lib_mensagem, SysUtils, Variants, Graphics, Controls,
   ComCtrls, StdCtrls, ExtCtrls, DBClient;

type
   TImpressao_Nao_Fiscal = Class(TPersistent)
//   private
//   protected
   public
     function Verif_Impressora: Boolean;
     procedure Layout_Finaliza_Pedido(cdsInfo: TClientDataSet);
     procedure Layout_Pedido(cdsPedido, cdsProduto, cdsAdicionais: TClientDataSet);
//   published
end;

implementation

  function rStatusImpressora_DUAL_DarumaFramework(): Integer; StdCall; External 'DarumaFrameWork.dll';
  function iImprimirTexto_DUAL_DarumaFramework(stTexto: String; iTam: Integer ): Integer; StdCall; External 'DarumaFramework.dll';

{ TImpressao_Nao_Fiscal }

{
  Formatação:
  Texto centralizado: <ce>Centralizado</ce>
  Texto justificado: <ju>Justificado</ju>
  Texto em Negrito: <b>Negrito</b>
  Texto em Italico: <i>Italico</i>
  Texto em Sublinhado: <s>Sublinhado</s>
  Texto em Expandido: <e>Expandido</e>
  Texto em Condensado: <c>Condensado</c>
  Texto Normal: <n>Normal</n>
  Saltar uma Linha: <l></l>Salto de uma Linha
  Saltar varias Linhas: <sl>NN</sl>Saltar varias Linhas
  Riscar Linha com Caracter Especifico: <tc>C</tc>
  Imprimir Data Atual sistema: <dt></dt>
  Imprimir Hora Atual sistema: <hr></hr>
  Imprimir Data Atual impressora: <dti></dti>
  Imprimir Hora Atual impressora: <hri></hri>
  Inserir Espaços em Branco: <sp>NN</sp>
  Usando as Tabulacoes <tb></tb>
  Configurar Tabulacoes <ft>n1,n2,n3,...</ft>
  Alinhando a Direita <ad></ad>
  Configura Margem <mg>e,d</mg>
  Duplica a Altura do caracter <da></da>
  Habilita o Modo Fonte Elite <fe>texto</fe>
  Texto Extra Grande <xl>texto</xl>
  Salto milimetrico <slm>xx</slm>
  Conf. Espaço entre Linhas <cespl>xx</cespl>

  Comandos:
  Imprimir logotipo carregado <bmp></bmp>
  Imprimir bmp s/carregar <ibmp>path/arq.bmp</ibmp>
  Acionar guilhotina <gui></gui>
  Abrir Gaveta de Dinheiro: <g></g>
  Sinal Sonoro, Apitar: <sn></sn>
  Aguardar o Termino da Impressão: <a></a>
  Configura Corte (P)Parcial  (T)Total <confgui>T</confgui>

  Imprimir Código de Barras:
  <ean13>123456789012</ean13>
  <ean8>1234567</ean8>
  <upc-a>12345678901</upc-a>
  <code39>CODE 39</code39>
  <code93>CODE 93</code93>
  <codabar>CODABAR</codabar>
  <msi>123456789</msi>
  <code11>12345678901</code11>
  <pdf>1234</pdf>
  <code128>123456789123-A-B-*_%-&</code128>
  <i2of5>1234</i2of5>
  <s2of5>12345678</s2of5>
  <qrcode>www.daruma.com.br</qrcode>

  Sub-tags para Codigos de Barras::
  Para código na vertical <cbv></cbv>
  Imprimir Texto na lateral do Cod. Vertical <txtl></txtl>
  Imprimir código abaixo das barras <txt></txt>
  Altuda do Cod. Barras <hx></hx> (onde  x = altura)
  Largura do Cod. Barras <wx></wx> (onde  x = largura)
  Colunas - para pdf <cx></cx> (onde x =coluna)
  Salva QrCode em bmp:<sbmp>c:\Imagem.bmp</sbmp>
  Nivel Correção QrCode: <correcao>x</correcao> (onde x = M, Q ou  H)
}

procedure TImpressao_Nao_Fiscal.Layout_Finaliza_Pedido(cdsInfo: TClientDataSet);
var
  Texto_Impressao: TMemo;
begin
  Texto_Impressao := TMemo.Create(nil);
  {
    #                                       #
    #                Empresa                #
    #                Undiade                #
    #                                       #
    #  Destino                              #
    #                                       #
    #  Produto 1     qdte  valor total item #
    #  Produto 1     qdte  valor total item #
    #  Produto 1     qdte  valor total item #
    #  Produto 1     qdte  valor total item #
    #                                       #
    #                         Valor Total   #
    #                                       #
    #       Documento sem valor fiscal      #
    #                  VMSis                #
    #                                       #
  }

  Texto_Impressao.Lines.Add('<e><ce><b>'+cdsInfo.FieldByName('EMPRESA').AsString+'</b></ce></e>');
  Texto_Impressao.Lines.Add('<ce>'+cdsInfo.FieldByName('UNIDADE').AsString+'<ce>');
  Texto_Impressao.Lines.Add('<l></l>');

  try
    if iImprimirTexto_DUAL_DarumaFramework(Texto_Impressao.Text, 0) <> 1 then
      Erro(ERRO_AO_IMPRIMIR);
  except
    raise;
  end;

  FreeAndNil(cdsInfo);
end;

procedure TImpressao_Nao_Fiscal.Layout_Pedido(cdsPedido, cdsProduto, cdsAdicionais: TClientDataSet);
var
  Texto_Impressao: TMemo;
begin
  Texto_Impressao := TMemo.Create(nil);
  {
    #                                       #
    #                Empresa                #
    #                Unidade                #
    #                                       #
    #  Destino                              #
    #                                       #
    #  Produto 1     qdte  valor total item #
    #     Adicional  qtde                   #
    #     Adicional  qtde                   #
    #  Produto 1     qdte  valor total item #
    #     Adicional  qtde                   #
    #     Adicional  qtde                   #
    #     Adicional  qtde                   #
    #     Adicional  qtde                   #
    #  Produto 1     qdte  valor total item #
    #  Produto 1     qdte  valor total item #
    #                                       #
    #                  VMSis                #
    #          dd/mm/yyyy - hh:mi           #
  }

  Texto_Impressao.Lines.Add('<sl>3</sl>');
  Texto_Impressao.Lines.Add('<e><ce><b>'+cdsPedido.FieldByName('EMPRESA').AsString+'</b></ce></e>');
  Texto_Impressao.Lines.Add('<ce>'+cdsPedido.FieldByName('UNIDADE').AsString+'<ce>');
  Texto_Impressao.Lines.Add('<l></l>');
  Texto_Impressao.Lines.Add('<n>Delivery</n>');
  Texto_Impressao.Lines.Add('<n>'+cdsPedido.FieldByName('ENDERECO').AsString+'</n>');
  Texto_Impressao.Lines.Add('<n>'+cdsPedido.FieldByName('REFERENCIA').AsString+'</n>');
  Texto_Impressao.Lines.Add('<l></l>');
  Texto_Impressao.Lines.Add('<b>Produto<tb><tb><tb>Qtde<tb>Valor</b>');
  cdsProduto.First;
  while not cdsProduto.Eof do begin
    Texto_Impressao.Lines.Add(cdsProduto.FieldByName('NMPRODUTO').AsString+'<tb><tb><tb>'+cdsProduto.FieldByName('QUANTIDADE').AsString+'<tb>'+cdsProduto.FieldByName('VRTOTAL').AsString);
    cdsAdicionais.Filtered := False;
    cdsAdicionais.Filter := ' ID_PRODUTO = '+cdsProduto.FieldByName('ID').AsString;
    cdsAdicionais.Filtered := False;
    cdsAdicionais.First;
    while not cdsAdicionais.Eof do begin
      Texto_Impressao.Lines.Add('<tb>'+cdsProduto.FieldByName('NMADICIONAL').AsString+'<tb><tb>'+cdsProduto.FieldByName('QUANTIDADE').AsString+'<tb>'+cdsProduto.FieldByName('VRTOTAL').AsString);
      cdsAdicionais.Next;
    end;
    cdsProduto.Next;
  end;
  Texto_Impressao.Lines.Add('<tb><tb><tb><tb><tb>'+cdsPedido.FieldByName('VRPEDIDO').AsString);
  Texto_Impressao.Lines.Add('<l></l>');
  Texto_Impressao.Lines.Add('<ce>Documento sem valor fiscal</ce>');
  Texto_Impressao.Lines.Add('<ce>VMSis</ce>');
  Texto_Impressao.Lines.Add('<ce><dt> - <hr></hr></dt></ce>');
  Texto_Impressao.Lines.Add('<sl>4</sl>');
  Texto_Impressao.Lines.Add('<l></l>');                                            

  try
    if iImprimirTexto_DUAL_DarumaFramework(Texto_Impressao.Text, 0) <> 1 then
      Erro(ERRO_AO_IMPRIMIR);
  except
    raise;
  end;

  FreeAndNil(cdsPedido);  
  FreeAndNil(cdsProduto);
  FreeAndNil(cdsAdicionais);
end;

function TImpressao_Nao_Fiscal.Verif_Impressora: Boolean;
var
  boOK: Boolean;
begin
  boOK := False;
  case rStatusImpressora_DUAL_DarumaFramework() of
    0: Aviso(IMPRESSORA_DESLIGADA);
    1: boOk := True;
    -27: Erro(ERRO_GENERICO);
    -50: Erro(IMPRESSORA_OFFLINE);
    -51: Aviso(IMPRESSORA_SEMPAPEL);
    -52: Aviso(IMPRESSORA_INICIALIZANDO);
  else
    Erro(ERRO_RETORNO_NAO_ESPERADO);
  end;
  Result := boOK;
end;

end.
