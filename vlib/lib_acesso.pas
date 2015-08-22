unit lib_acesso;

interface

uses IdHashMessageDigest, Windows, Messages, sysutils;

  type
    Tcriptografia = class
    public
       class function MD5(const texto : string) : string;
    end;

    TAcesso = class
    
    end;

implementation

uses IdHash;

{ Tcriptografia }

class function Tcriptografia.MD5(const texto: string): string;
var
  imd5 : TIdHashMessageDigest5;
begin
  imd5 := TIdHashMessageDigest5.Create;
  try
    Result := imd5.AsHex(imd5.HashValue(texto));
  finally
    FreeAndNil(imd5);
  end;
end;

end.
