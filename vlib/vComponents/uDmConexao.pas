unit uDmConexao;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdmConexao = class(TDataModule)
    adoConexaoBd: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{$R *.dfm}

end.
