inherited vCadastroFornecedorFrame: TvCadastroFornecedorFrame
  inherited pgcPadrao: TcxPageControl
    inherited tabVisao: TcxTabSheet
      inherited panClient: TPanel
        inherited cxgridFiltro: TcxVerticalGrid
          Version = 1
          object nmcliente: TcxEditorRow
            Properties.Caption = 'Nome'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object telfixo: TcxEditorRow
            Properties.Caption = 'Telefone'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object telcelular: TcxEditorRow
            Properties.Caption = 'Celular'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object nrinscjurd: TcxEditorRow
            Properties.Caption = 'CPF/CNPJ'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
        end
        inherited cxGrid1: TcxGrid
          LookAndFeel.SkinName = ''
          inherited cxGrid1DBTableView1: TcxGridDBTableView
            object cxGrid1DBTableView1nrinscjurd: TcxGridDBColumn
              DataBinding.FieldName = 'nrinscjurd'
            end
            object cxGrid1DBTableView1nmfornecedor: TcxGridDBColumn
              DataBinding.FieldName = 'nmfornecedor'
              Width = 200
            end
            object cxGrid1DBTableView1telfixo: TcxGridDBColumn
              DataBinding.FieldName = 'telfixo'
            end
            object cxGrid1DBTableView1telcel: TcxGridDBColumn
              DataBinding.FieldName = 'telcel'
            end
          end
        end
        inherited dxNavBar: TdxNavBar
          inherited nbPesquisa: TdxNavBarGroup
            Links = <
              item
                Item = nbiFiltrar
              end
              item
                Item = nbLimpar
              end>
          end
        end
      end
      inherited panTop: TPanel
        inherited lblNomeFrame: TLabel
          Width = 54
          Caption = 'Fornecedor'
        end
      end
    end
    inherited tabCadastro: TcxTabSheet
      inherited Panel1: TPanel
        inherited cxvGrid1: TcxDBVerticalGrid
          Height = 289
          Version = 1
          object cxvGrid1nmfornecedor: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nmfornecedor'
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxvGrid1identificador: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.EditProperties.Items = <
              item
                Description = 'F'#237'sica'
                ImageIndex = 0
                Value = 'F'
              end
              item
                Description = 'Jur'#237'dica'
                Value = 'J'
              end>
            Properties.DataBinding.FieldName = 'identificador'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxvGrid1nrinscjurd: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nrinscjurd'
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxvGrid1telfixo: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'telfixo'
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxvGrid1telcel: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'telcel'
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object catEndereco: TcxCategoryRow
            Options.Focusing = False
            Properties.Caption = 'Endere'#231'o'
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object cxvGrid1nmrua: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nmrua'
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object cxvGrid1cdnumero: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.AssignedValues.DisplayFormat = True
            Properties.EditProperties.DecimalPlaces = 0
            Properties.EditProperties.MaxLength = 9
            Properties.DataBinding.FieldName = 'cdnumero'
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object cxvGrid1complemento: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'complemento'
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object cxvGrid1cdbairro_id: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.EditProperties.KeyFieldNames = 'id'
            Properties.EditProperties.ListColumns = <
              item
                FieldName = 'nmbairro'
              end>
            Properties.EditProperties.ListSource = dtsBairro
            Properties.DataBinding.FieldName = 'cdbairro_id'
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
          object cxvGrid1cdcep: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxMaskEditProperties'
            Properties.DataBinding.FieldName = 'cdcep'
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
          object cxvGrid1DBEditorRow6: TcxDBEditorRow
            Properties.Caption = 'Data Cadastro'
            Properties.EditPropertiesClassName = 'TcxDateEditProperties'
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.SaveTime = False
            Properties.EditProperties.ShowTime = False
            Properties.DataBinding.FieldName = 'dtcadastro'
            ID = 11
            ParentID = -1
            Index = 11
            Version = 1
          end
        end
        inherited panGrid: TPanel
          Top = 289
          Height = 121
          inherited pnlNavigator: TPanel
            inherited lblGridCaption: TcxLabel
              Caption = 'Endere'#231'o'
              Style.IsFontAssigned = True
            end
          end
          inherited cxGrid2: TcxGrid
            Height = 97
          end
        end
      end
    end
  end
  inherited adqPadrao: TADOQuery
    OnNewRecord = adqPadraoNewRecord
    SQL.Strings = (
      'select * from fornecedor'
      'where 1=1')
    object adqPadraoid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object adqPadraonmfornecedor: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nmfornecedor'
      Size = 250
    end
    object adqPadraonrinscjurd: TWideStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'nrinscjurd'
    end
    object adqPadraoidentificador: TWideStringField
      DisplayLabel = 'Tipo'
      FieldName = 'identificador'
      OnChange = adqPadraoidentificadorChange
      Size = 1
    end
    object adqPadraotelcel: TStringField
      DisplayLabel = 'Celular'
      FieldName = 'telcel'
      Size = 15
    end
    object adqPadraotelfixo: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telfixo'
      Size = 15
    end
    object adqPadraonmrua: TWideStringField
      DisplayLabel = 'Logradouro'
      DisplayWidth = 80
      FieldName = 'nmrua'
      Size = 200
    end
    object adqPadraocdnumero: TWideStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'cdnumero'
      Size = 30
    end
    object adqPadraocomplemento: TStringField
      DisplayLabel = 'Complemento'
      DisplayWidth = 80
      FieldName = 'complemento'
      Size = 255
    end
    object adqPadraocdcep: TWideStringField
      DisplayLabel = 'Cep'
      FieldName = 'cdcep'
      Size = 10
    end
    object adqPadraocdbairro_id: TIntegerField
      DisplayLabel = 'Bairro'
      FieldName = 'cdbairro_id'
    end
    object adqPadraodtcadastro: TDateTimeField
      DisplayLabel = 'Cadastro'
      FieldName = 'dtcadastro'
    end
    object adqPadraoid_web: TIntegerField
      FieldName = 'id_web'
      Visible = False
    end
  end
  inherited adqDetail: TADOQuery
    SQL.Strings = (
      '')
    Left = 168
    Top = 384
  end
  inherited dtsDetail: TDataSource
    Left = 200
    Top = 384
  end
  object adqBairro: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      'select * from bairro')
    Left = 352
    Top = 176
    object adqBairroid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object adqBairrodtcadastro: TDateField
      FieldName = 'dtcadastro'
    end
    object adqBairrocdbairro: TWideStringField
      FieldName = 'cdbairro'
      Size = 10
    end
    object adqBairronmbairro: TWideStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 80
      FieldName = 'nmbairro'
      Size = 250
    end
    object adqBairrocidade_id: TIntegerField
      FieldName = 'cidade_id'
    end
    object adqBairroid_web: TIntegerField
      FieldName = 'id_web'
    end
  end
  object dtsBairro: TDataSource
    AutoEdit = False
    DataSet = adqBairro
    OnStateChange = dtsPadraoStateChange
    Left = 384
    Top = 176
  end
end
