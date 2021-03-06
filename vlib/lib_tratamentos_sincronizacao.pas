unit lib_tratamentos_sincronizacao;

interface
  type
    TTratamentos = Class
    public
      class procedure PreencherIdEntradaSaidaItemProduto;
    end;
implementation

uses lib_db, ADODB, uDmConexao, SysUtils;
{ TTratamentos }

class procedure TTratamentos.PreencherIdEntradaSaidaItemProduto;
var
   qry: TADOQuery;           
begin
  qry := TADOQuery.Create(nil);
  try
    qry.Connection:= dmConexao.adoConexaoBd;
    qry.SQL.Text:=
      'UPDATE Itemproduto, Entrada '+
      '   SET Itemproduto.entrada_id = Entrada.id '+
      '  WHERE Itemproduto.id_web = entrada.id_web ';

    qry.ExecSQL;

    qry.SQL.Text:=
      'UPDATE Itemproduto, Saida '+
      '   SET Itemproduto.saida_id = Saida.id '+
      '  WHERE Itemproduto.id_web = Saida.id_web ';
    qry.ExecSQL;

  finally
    FreeAndNil(qry);
  end;
end;

end.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
 

