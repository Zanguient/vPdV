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

   { Validações }
   INFORMAR_USUARIO = 'Usuário deve ser informado.';
   INFORMAR_SENHA   = 'Senha deve ser informada.';
   INFORMAR_VALOR   = 'Valor deve ser informado.';
   INFORMAR_QTDE    = 'Quantidade deve ser informada.';
   OPCAO_N_IDENTIFICADA = 'Opção não identificada.';
   EXISTENCIA_CAIXA_ABERTO = 'O caixa não foi fechado. Feche antes de prosseguir.';
   FALHA_ABRIR_CAIXA = 'Ocorreu uma falha ao abrir o caixa.';

   { Gaveta / Impressora não fiscal }
   GAVETA_ACIONADA = 'A gaveta foi aberta.';
   GAVETA_ERRO = 'Verifique conexão com a gaveta.';
   GAVETA_ABERTA = 'A gaveta já está aberta.';
   GAVETA_SEM_PERMISSAO = 'Você não tem permissão para abrir a gaveta sem chave.';


   IMPRESSORA_DESLIGADA = 'Impressora desligada.';
   IMPRESSORA_OFFLINE   = 'Impressora OFFLINE.';
   IMPRESSORA_SEMPAPEL  = 'Impressora sem papel.';
   IMPRESSORA_INICIALIZANDO  = 'Impressora inicializando.';
   ERRO_AO_IMPRIMIR = 'Erro durante a impressão, verifique a impressora.';

   ERRO_GENERICO = 'Erro generico.';
   ERRO_RETORNO_NAO_ESPERADO = 'Retorno não esperado.';

   ERRO_COMUNICACAO_BALANCA = 'Verifique a conexão com a balança.';

   { Rotina de Login }
   INICIA_PROCESSO_FC = 'Iniciando frente de caixa...';

   { PDV }
   EXCLUIR_ITEM = 'Deseja excluir o item?';
   CONFIRMA_PERDA_DADOS = 'O pedido foi alterado, deseja desfazer a alteração?';
   MOTIVO_DEVE_INFORMAR = 'O motivo deve ser informado.';
   CONFIRMA_CANCELAMENTO_PEDIDO = 'Cancelar o pedido?';
   MOTIVO_TEMP_CANCELAMENTO = 'Os motivos foram armazenados temporariamente. Sem confirmação do cancelamento. ';
   MOTIVO_INFORM_PERDIDO = 'Os motivos não confirmados serão perdidos, deseja prosseguir?';
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
   CONFIRMA = 'Confirmação';
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
