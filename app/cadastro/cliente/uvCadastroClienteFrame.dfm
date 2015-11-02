inherited vCadastroCliente: TvCadastroCliente
  Width = 564
  inherited pgcPadrao: TcxPageControl
    Width = 564
    ClientRectRight = 560
    inherited tabVisao: TcxTabSheet
      inherited panClient: TPanel
        Width = 556
        inherited cxgridFiltro: TcxVerticalGrid
          Width = 556
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
          Width = 455
          LookAndFeel.SkinName = ''
          inherited cxGrid1DBTableView1: TcxGridDBTableView
            object cxGrid1DBTableView1id: TcxGridDBColumn
              DataBinding.FieldName = 'id'
            end
            object cxGrid1DBTableView1nrinscjurd: TcxGridDBColumn
              DataBinding.FieldName = 'nrinscjurd'
            end
            object cxGrid1DBTableView1nmcliente: TcxGridDBColumn
              DataBinding.FieldName = 'nmcliente'
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
        inherited panFiltro: TPanel
          Width = 556
          inherited cxDBNavigator1: TcxDBNavigator
            Left = 333
          end
        end
        inherited dxNavBar: TdxNavBar
          Left = 455
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
        Width = 556
        inherited lblNomeFrame: TLabel
          Width = 32
          Caption = 'Cliente'
        end
        inherited btnFechar: TcxButton
          Left = 531
        end
      end
    end
    inherited tabCadastro: TcxTabSheet
      inherited Panel1: TPanel
        Width = 556
        inherited cxvGrid1: TcxDBVerticalGrid
          Width = 556
          Height = 305
          Version = 1
          object cxvGrid1nmcliente: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nmcliente'
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxvGrid1identificador: TcxDBEditorRow
            Properties.Caption = 'Tipo'
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
            ID = 3
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxvGrid1nrinscjurd: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nrinscjurd'
            ID = 4
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxvGrid1telfixo: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'telfixo'
            ID = 1
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxvGrid1telcel: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'telcel'
            ID = 2
            ParentID = -1
            Index = 4
            Version = 1
          end
          object catEndereco: TcxCategoryRow
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
            Properties.EditProperties.EditMask = '00000-000;0; '
            Properties.DataBinding.FieldName = 'cdcep'
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
          object cxvGrid1dtcadastro: TcxDBEditorRow
            Properties.Caption = 'Data cadastro'
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
          Top = 305
          Width = 556
          Height = 105
          inherited pnlNavigator: TPanel
            Width = 556
            inherited cxNavDetail: TcxDBNavigator
              Left = 236
            end
            inherited lblGridCaption: TcxLabel
              Caption = 'Endere'#231'o'
              Style.IsFontAssigned = True
            end
          end
          inherited cxGrid2: TcxGrid
            Width = 556
            Height = 81
          end
        end
      end
      inherited Panel2: TPanel
        Width = 556
        inherited cxButton1: TcxButton
          Left = 531
        end
        inherited cxNavCadastro: TcxDBNavigator
          Buttons.OnButtonClick = nil
        end
      end
    end
  end
  inherited adqPadrao: TADOQuery
    OnNewRecord = adqPadraoNewRecord
    SQL.Strings = (
      'select * from cliente'
      'where 1=1')
    object adqPadraoid: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
      ReadOnly = True
    end
    object adqPadraonmcliente: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nmcliente'
      Size = 250
    end
    object adqPadraonrinscjurd: TWideStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'nrinscjurd'
      EditMask = '000.000.000-00;0; '
    end
    object adqPadraotelfixo: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telfixo'
      Size = 15
    end
    object adqPadraoidentificador: TWideStringField
      DisplayLabel = 'Tipo pessoa'
      FieldName = 'identificador'
      Visible = False
      OnChange = adqPadraoidentificadorChange
      Size = 1
    end
    object adqPadraotelcel: TWideStringField
      DisplayLabel = 'Celular'
      FieldName = 'telcel'
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
    Left = 248
    Top = 416
  end
  inherited dtsDetail: TDataSource
    Left = 280
    Top = 416
  end
  object adqBairro: TADOQuery
    Connection = dmConexao.adoConexaoBd
    OnNewRecord = adqPadraoNewRecord
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
