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
          Version = 1
          object cxvGrid1nmcliente: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nmcliente'
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxvGrid1telfixo: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'telfixo'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxvGrid1telcel: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'telcel'
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxvGrid1identificador: TcxDBEditorRow
            Properties.Caption = 'identificador'
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
            Index = 3
            Version = 1
          end
          object cxvGrid1nrinscjurd: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nrinscjurd'
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
        end
        inherited panGrid: TPanel
          Width = 556
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
            inherited cxGridDBTableView1: TcxGridDBTableView
              object cxGridDBTableView1nmrua: TcxGridDBColumn
                DataBinding.FieldName = 'nmrua'
                Width = 150
              end
              object cxGridDBTableView1cdnumero: TcxGridDBColumn
                DataBinding.FieldName = 'cdnumero'
                Width = 50
              end
              object cxGridDBTableView1complemento: TcxGridDBColumn
                DataBinding.FieldName = 'complemento'
                Width = 100
              end
              object cxGridDBTableView1cdcep: TcxGridDBColumn
                DataBinding.FieldName = 'cdcep'
              end
              object cxGridDBTableView1cdbairro_id: TcxGridDBColumn
                DataBinding.FieldName = 'cdbairro_id'
              end
              object cxGridDBTableView1dtcadastro: TcxGridDBColumn
                DataBinding.FieldName = 'dtcadastro'
                Width = 80
              end
            end
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
    object adqPadraoidentificador: TWideStringField
      DisplayLabel = 'Tipo pessoa'
      FieldName = 'identificador'
      Visible = False
      OnChange = adqPadraoidentificadorChange
      Size = 1
    end
    object adqPadraotelfixo: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telfixo'
      Size = 15
    end
    object adqPadraotelcel: TWideStringField
      DisplayLabel = 'Celular'
      FieldName = 'telcel'
      Size = 15
    end
  end
  inherited adqDetail: TADOQuery
    Parameters = <
      item
        Name = 'cliente_id'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 2
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      '  from endereco'
      'where cliente_id = :cliente_id')
    object adqDetailid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object adqDetailnmrua: TWideStringField
      DisplayLabel = 'Logradouro'
      DisplayWidth = 80
      FieldName = 'nmrua'
      Size = 200
    end
    object adqDetailcdnumero: TWideStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'cdnumero'
      Size = 30
    end
    object adqDetailcomplemento: TStringField
      DisplayWidth = 80
      FieldName = 'complemento'
      Size = 255
    end
    object adqDetailcdcep: TWideStringField
      DisplayLabel = 'Cep'
      FieldName = 'cdcep'
      Size = 10
    end
    object adqDetailcdbairro_id: TIntegerField
      DisplayLabel = 'Bairro'
      FieldName = 'cdbairro_id'
    end
    object adqDetaildtcadastro: TDateField
      DisplayLabel = 'Data cadastro'
      FieldName = 'dtcadastro'
      ReadOnly = True
    end
    object adqDetailcliente_id: TIntegerField
      FieldName = 'cliente_id'
      Visible = False
    end
  end
end
