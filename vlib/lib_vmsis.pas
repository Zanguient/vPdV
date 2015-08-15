unit lib_vmsis;

interface

uses
   Classes, WinInet, Dialogs, Windows, Forms,
   IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient;

type
   TAcesso_Online = Class(TPersistent)
//   private
//   protected
   public
      function Verif_Net: Integer;
      function Verif_Site(stUrl: String): Boolean;
//   published
end;

implementation

{ Acesso_Online }

function TAcesso_Online.Verif_Net: Integer;
const
   SEM_CONEXAO_COM_A_INTERNET            = 1;
   CONEXAO_COM_INTERNET_ATRAVES_ROTEADOR = 2;
   CONEXAO_COM_INTERNET_ATRAVES_PROXY    = 3;
   SEM_CONEXAO = 0;
var
   Flags: Cardinal;
begin
   if not InternetGetConnectedState(@Flags, 0) then
      Result := SEM_CONEXAO_COM_A_INTERNET
   else
   if (Flags and INTERNET_CONNECTION_LAN) <> 0 then
      Result := CONEXAO_COM_INTERNET_ATRAVES_ROTEADOR
   else if (Flags and INTERNET_CONNECTION_PROXY) <> 0 then
      Result := CONEXAO_COM_INTERNET_ATRAVES_PROXY
   else
      Result := SEM_CONEXAO;
end;

function TAcesso_Online.Verif_Site(stUrl: String): Boolean;
var
  IdICMPClient: TIdICMPClient;
begin
   IdICMPClient := TIdICMPClient.Create(nil);
   try
      IdICMPClient.Host := stUrl;
      IdICMPClient.ReceiveTimeout := 500;
      IdICMPClient.Ping;

      Result := (IdICMPClient.ReplyStatus.BytesReceived > 0);
   finally
      IdICMPClient.Free;
   end
end;

end.
