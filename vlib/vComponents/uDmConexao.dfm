object dmConexao: TdmConexao
  OldCreateOrder = False
  Left = 420
  Top = 238
  Height = 150
  Width = 215
  object adoConexaoBd: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=VMSIS' +
      ';Initial Catalog=vmsis_db'
    LoginPrompt = False
    Left = 48
    Top = 40
  end
end
