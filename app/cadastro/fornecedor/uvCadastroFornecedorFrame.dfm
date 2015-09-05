inherited vCadastroFornecedorFrame: TvCadastroFornecedorFrame
  inherited pgcPadrao: TcxPageControl
    inherited tabVisao: TcxTabSheet
      inherited panClient: TPanel
        inherited cxgridFiltro: TcxVerticalGrid
          Version = 1
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
          Version = 1
          object cxvGrid1nmfornecedor: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nmfornecedor'
            ID = 2
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxvGrid1identificador: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'identificador'
            ID = 3
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxvGrid1nrinscjurd: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'nrinscjurd'
            ID = 1
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxvGrid1telfixo: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'telfixo'
            ID = 6
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxvGrid1telcel: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'telcel'
            ID = 5
            ParentID = -1
            Index = 4
            Version = 1
          end
        end
        inherited panGrid: TPanel
          inherited pnlNavigator: TPanel
            inherited lblGridCaption: TcxLabel
              Caption = 'Endere'#231'o'
              Style.IsFontAssigned = True
            end
          end
          inherited cxGrid2: TcxGrid
            inherited cxGridDBTableView1: TcxGridDBTableView
              object cxGridDBTableView1nmrua: TcxGridDBColumn
                DataBinding.FieldName = 'nmrua'
              end
              object cxGridDBTableView1cdnumero: TcxGridDBColumn
                DataBinding.FieldName = 'cdnumero'
              end
              object cxGridDBTableView1cdcep: TcxGridDBColumn
                DataBinding.FieldName = 'cdcep'
              end
              object cxGridDBTableView1dtcadastro: TcxGridDBColumn
                DataBinding.FieldName = 'dtcadastro'
              end
              object cxGridDBTableView1cdbairro_id: TcxGridDBColumn
                DataBinding.FieldName = 'cdbairro_id'
              end
              object cxGridDBTableView1complemento: TcxGridDBColumn
                DataBinding.FieldName = 'complemento'
              end
            end
          end
        end
      end
    end
  end
  inherited adqPadrao: TADOQuery
    SQL.Strings = (
      'select * from fornecedor'
      'where 1=1')
    object adqPadraoid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object adqPadraonrinscjurd: TWideStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'nrinscjurd'
    end
    object adqPadraonmfornecedor: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nmfornecedor'
      Size = 250
    end
    object adqPadraoidentificador: TWideStringField
      DisplayLabel = 'Tipo'
      FieldName = 'identificador'
      Size = 1
    end
    object adqPadraoidempresa: TIntegerField
      FieldName = 'idempresa'
      Visible = False
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
  end
  inherited adqDetail: TADOQuery
    Parameters = <
      item
        Name = 'fornecedor_id'
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
      'where fornecedor_id = :fornecedor_id')
    object adqDetailid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object adqDetailnmrua: TWideStringField
      FieldName = 'nmrua'
      Size = 200
    end
    object adqDetailcdnumero: TWideStringField
      FieldName = 'cdnumero'
      Size = 30
    end
    object adqDetailcdcep: TWideStringField
      FieldName = 'cdcep'
      Size = 10
    end
    object adqDetailempresa_id: TIntegerField
      FieldName = 'empresa_id'
    end
    object adqDetaildtcadastro: TDateField
      FieldName = 'dtcadastro'
    end
    object adqDetailcdbairro_id: TIntegerField
      FieldName = 'cdbairro_id'
    end
    object adqDetailcliente_id: TIntegerField
      FieldName = 'cliente_id'
    end
    object adqDetailfornecedor_id: TIntegerField
      FieldName = 'fornecedor_id'
    end
    object adqDetailcomplemento: TWideStringField
      FieldName = 'complemento'
      Size = 255
    end
  end
end
