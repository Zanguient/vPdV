unit lib_mensagem;

interface

uses
   Windows, Forms;

procedure Aviso(Msg: String);
function Confirma(Msg: String): Boolean;
procedure Erro(Msg: String);

CONST
   { Barra de titulo }
   VMSIS = 'VMSis - ';

   { Valida��es }
   INFORMAR_USUARIO = 'Usu�rio deve ser informado.';
   INFORMAR_SENHA   = 'Senha deve ser informada.';
   INFORMAR_VALOR   = 'Valor deve ser informado.';
   INFORMAR_QTDE    = 'Quantidade deve ser informada.';
   OPCAO_N_IDENTIFICADA = 'Op��o n�o identificada.';
   EXISTENCIA_CAIXA_ABERTO = 'O caixa n�o foi fechado. Feche antes de prosseguir.';
   FALHA_ABRIR_CAIXA = 'Ocorreu uma falha ao abrir o caixa.';

   { Gaveta / Impressora n�o fiscal }
   GAVETA_ACIONADA = 'A gaveta foi aberta.';
   GAVETA_ERRO = 'Verifique conex�o com a gaveta.';
   GAVETA_ABERTA = 'A gaveta j� est� aberta.';
   GAVETA_SEM_PERMISSAO = 'Voc� n�o tem permiss�o para abrir a gaveta sem chave.';


   IMPRESSORA_DESLIGADA = 'Impressora desligada.';
   IMPRESSORA_OFFLINE   = 'Impressora OFFLINE.';
   IMPRESSORA_SEMPAPEL  = 'Impressora sem papel.';
   IMPRESSORA_INICIALIZANDO  = 'Impressora inicializando.';
   ERRO_AO_IMPRIMIR = 'Erro durante a impress�o, verifique a impressora.';

   ERRO_GENERICO = 'Erro generico.';
   ERRO_RETORNO_NAO_ESPERADO = 'Retorno n�o esperado.';

   ERRO_COMUNICACAO_BALANCA = 'Verifique a conex�o com a balan�a.';

   { Rotina de Login }
   INICIA_PROCESSO_FC = 'Iniciando frente de caixa...';

   { PDV }
   EXCLUIR_ITEM = 'Deseja excluir o item?';
   CONFIRMA_PERDA_DADOS = 'O pedido foi alterado, deseja desfazer a altera��o?';
   MOTIVO_DEVE_INFORMAR = 'O motivo deve ser informado.';
   CONFIRMA_CANCELAMENTO_PEDIDO = 'Cancelar o pedido?';
   MOTIVO_TEMP_CANCELAMENTO = 'Os motivos foram armazenados temporariamente. Sem confirma��o do cancelamento. ';
   MOTIVO_INFORM_PERDIDO = 'Os motivos n�o confirmados ser�o perdidos, deseja prosseguir?';
   EXISTE_PEDIDO_MESA = 'Existe pedido em aberto para a mesa.';

implementation

procedure Aviso(Msg: String);
const
   AVISO = 'Aviso';
begin
   MESSAGEBOX(Application.Handle, PChar(Msg), VMSIS+AVISO, MB_ICONWARNING + MB_OK);
end;

function Confirma(Msg: String): Boolean;
const
   CONFIRMA = 'Confirma��o';
begin
   Result := False;
   if MESSAGEBOX(Application.Handle, PChar(Msg), VMSIS+CONFIRMA, MB_ICONQUESTION + MB_YESNO) = IDYES then
      Result := True;
end;

procedure Erro(Msg: String);
const
   ERRO = 'Erro';
begin
   MESSAGEBOX(Application.Handle, PChar(Msg), VMSIS+ERRO, MB_ICONHAND + MB_OK);
end;

end.
