object dmConexao: TdmConexao
  OldCreateOrder = False
  Left = 418
  Top = 238
  Height = 150
  Width = 215
  object adoConexaoBd: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=silfer;Persist Security Info=True;Us' +
      'er ID=root;Data Source=vmsis;Initial Catalog=vmsis'
    Provider = 'MSDASQL.1'
    Left = 48
    Top = 40
  end
end
