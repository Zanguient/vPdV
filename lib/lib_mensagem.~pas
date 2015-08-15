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
   OPCAO_N_IDENTIFICADA = 'Opção não identificada.';

   { Rotina de Login }
   INICIA_PROCESSO_FC = 'Iniciando frente de caixa...';

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
