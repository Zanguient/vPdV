unit lib_vmsis;

interface

uses
   Classes, WinInet, Dialogs, Windows, Forms,
   IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient;

  type
    TAcesso_Perifericos = Class(TPersistent)
    public
      function AbreGaveta: Boolean;
      function LeBalanca: Double;
    end;

   TAcesso_Online = Class(TPersistent)
   public
      function Verif_Net: Integer;
      function Verif_Site(stUrl: String): Boolean;
//   published
   end;
   TUtilidades = class
   public
     class function GetDateToMySql(date : TDateTime) : string;
   end;
implementation

uses
  lib_mensagem, SysUtils;
                                                                                                   
  function Elgin_LeBalanca(Porta, Baud, Valor: PChar): Integer; Stdcall; External 'Elgin.dll';
  function rStatusGaveta_DUAL_DarumaFramework(var iStatusGaveta: Integer): Integer; StdCall; External 'C:\Windows\System32\DarumaFramework.dll';
  function iAcionarGaveta_DUAL_DarumaFramework(): Integer; StdCall; External 'C:\Windows\System32\DarumaFramework.dll';

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

{ TAcesso_Perifericos }   

function TAcesso_Perifericos.AbreGaveta: Boolean;
  procedure AcionaGaveta;
  var
    iRetorno: Integer;
  begin
    iRetorno := iAcionarGaveta_DUAL_DarumaFramework();
    if (iRetorno = 1) then
      Aviso(GAVETA_ACIONADA)
    else
      Erro(GAVETA_ERRO);
  end;
var
  iRetorno: Integer;
  iStatusGaveta: Integer;
begin
  iRetorno := rStatusGaveta_DUAL_DarumaFramework(iStatusGaveta);
  if (iRetorno = 1) then
  begin
    case iStatusGaveta of
      0: AcionaGaveta;
      1: Aviso(GAVETA_ABERTA);
    else
      Aviso(GAVETA_ERRO);
    end;
  end else
    Aviso(GAVETA_ERRO);
  result := Boolean(iStatusGaveta);
end;

function TAcesso_Perifericos.LeBalanca: Double;
var
  stPorta, stBaud, stValor: String;
  iRetorno: Integer;
  flReturn: Double;
begin                 
  flReturn := 0.0;
  stBaud := '9600';
  stValor := StringOfChar(' ', 5);
  stPorta := 'COM11';

  iRetorno := Elgin_LeBalanca(PAnsiChar(stPorta), PAnsiChar(stBaud), PAnsiChar(stValor));
  if iRetorno = 1 then
    flReturn := StrToFloat(stValor)
  else
    Aviso(ERRO_COMUNICACAO_BALANCA);
  Result := flReturn;
end;

{ TUtilidades }

class function TUtilidades.GetDateToMySql(date : TDateTime): string;
begin
   Result := FormatDateTime('yyyy-MM-dd', date);
end;

end.
