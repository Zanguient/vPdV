inherited vEstoqueEntradaFrame: TvEstoqueEntradaFrame
  inherited pgcPadrao: TcxPageControl
    ActivePage = tabCadastro
    inherited tabVisao: TcxTabSheet
      inherited panClient: TPanel
        inherited cxgridFiltro: TcxVerticalGrid
          Version = 1
          object cxgridFiltroDtEntrada: TcxEditorRow
            Properties.Caption = 'Dt. Entrada'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
        end
        inherited cxGrid1: TcxGrid
          LookAndFeel.SkinName = ''
          inherited cxGrid1DBTableView1: TcxGridDBTableView
            object cxGrid1DBTableView1dtentrada: TcxGridDBColumn
              DataBinding.FieldName = 'dtentrada'
              PropertiesClassName = 'TcxDateEditProperties'
              Properties.ReadOnly = True
            end
            object cxGrid1DBTableView1fornecedor_id: TcxGridDBColumn
              DataBinding.FieldName = 'fornecedor_id'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.KeyFieldNames = 'id'
              Properties.ListColumns = <
                item
                  FieldName = 'nmfornecedor'
                end>
              Properties.ListSource = dtsFornecedor
              MinWidth = 0
              Width = 300
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
          Width = 79
          Caption = 'Entrada Estoque'
        end
      end
    end
    inherited tabCadastro: TcxTabSheet
      inherited Panel1: TPanel
        inherited cxvGrid1: TcxDBVerticalGrid
          Version = 1
          object cxvGrid1id: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'id'
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxvGrid1dtentrada: TcxDBEditorRow
            Properties.DataBinding.FieldName = 'dtentrada'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxvGrid1fornecedor_id: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.EditProperties.ListColumns = <>
            Properties.DataBinding.FieldName = 'fornecedor_id'
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
        end
        inherited panGrid: TPanel
          Visible = True
          inherited pnlNavigator: TPanel
            inherited lblGridCaption: TcxLabel
              Caption = 'Produtos'
              Style.IsFontAssigned = True
            end
          end
          inherited cxGrid2: TcxGrid
            inherited cxGridDBTableView1: TcxGridDBTableView
              object cxGridDBTableView1produto_id: TcxGridDBColumn
                DataBinding.FieldName = 'produto_id'
                PropertiesClassName = 'TcxLookupComboBoxProperties'
                Properties.ListColumns = <>
                Width = 180
              end
              object cxGridDBTableView1qtdeprod: TcxGridDBColumn
                DataBinding.FieldName = 'qtdeprod'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.EditFormat = ',0.00;-,0.00'
                Properties.MaxLength = 13
                Properties.Nullable = False
                Properties.Nullstring = '0'
              end
              object cxGridDBTableView1vlprod: TcxGridDBColumn
                DataBinding.FieldName = 'vlprod'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.EditFormat = ',0.00;-,0.00'
                Properties.MaxLength = 13
                Properties.Nullable = False
                Properties.Nullstring = '0'
                Width = 65
              end
            end
          end
        end
      end
      inherited Panel2: TPanel
        inherited Label1: TLabel
          Width = 79
          Caption = 'Entrada Estoque'
        end
      end
    end
  end
  inherited adqPadrao: TADOQuery
    SQL.Strings = (
      'select * from entrada'
      'where 1=1')
    object adqPadraoid: TAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id'
      ReadOnly = True
    end
    object adqPadraodtentrada: TDateField
      DisplayLabel = 'Dt. Entrada'
      FieldName = 'dtentrada'
    end
    object adqPadraofornecedor_id: TIntegerField
      DisplayLabel = 'Fornecedor'
      FieldName = 'fornecedor_id'
    end
    object adqPadraoid_web: TIntegerField
      FieldName = 'id_web'
      Visible = False
    end
    object adqPadraodtcadastro: TDateTimeField
      FieldName = 'dtcadastro'
      Visible = False
    end
  end
  inherited ActionList1: TActionList
    Left = 464
    Top = 96
  end
  inherited adqDetail: TADOQuery
    Parameters = <
      item
        Name = 'entrada_id'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 2
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'select * from itemproduto'
      'where entrada_id=:entrada_id')
    object adqDetailid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object adqDetaildtcadastro: TDateField
      FieldName = 'dtcadastro'
    end
    object adqDetailproduto_id: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'produto_id'
    end
    object adqDetaillote_id: TIntegerField
      FieldName = 'lote_id'
    end
    object adqDetailqtdeprod: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'qtdeprod'
    end
    object adqDetailvlprod: TFloatField
      DisplayLabel = 'Vl. Unit'#225'rio'
      FieldName = 'vlprod'
    end
    object adqDetailid_web: TIntegerField
      FieldName = 'id_web'
    end
    object adqDetailentrada_id: TIntegerField
      FieldName = 'entrada_id'
    end
    object adqDetailsaida_id: TIntegerField
      FieldName = 'saida_id'
    end
  end
  object adqFornecedor: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      'select * from fornecedor'
      'where 1=1')
    Left = 280
    Top = 104
    object adqFornecedorid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object adqFornecedornrinscjurd: TWideStringField
      FieldName = 'nrinscjurd'
      Visible = False
    end
    object adqFornecedornmfornecedor: TWideStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'nmfornecedor'
      Size = 250
    end
    object adqFornecedoridentificador: TWideStringField
      FieldName = 'identificador'
      Visible = False
      Size = 1
    end
    object adqFornecedornmrua: TWideStringField
      FieldName = 'nmrua'
      Visible = False
      Size = 200
    end
    object adqFornecedorcdnumero: TWideStringField
      FieldName = 'cdnumero'
      Visible = False
      Size = 30
    end
    object adqFornecedorcdcep: TWideStringField
      FieldName = 'cdcep'
      Visible = False
      Size = 10
    end
    object adqFornecedorcdbairro_id: TIntegerField
      FieldName = 'cdbairro_id'
      Visible = False
    end
    object adqFornecedortelcel: TWideStringField
      FieldName = 'telcel'
      Visible = False
      Size = 15
    end
    object adqFornecedortelfixo: TWideStringField
      FieldName = 'telfixo'
      Visible = False
      Size = 15
    end
    object adqFornecedorid_web: TIntegerField
      FieldName = 'id_web'
      Visible = False
    end
    object adqFornecedordtcadastro: TDateTimeField
      FieldName = 'dtcadastro'
      Visible = False
    end
  end
  object dtsFornecedor: TDataSource
    AutoEdit = False
    DataSet = adqFornecedor
    OnStateChange = dtsPadraoStateChange
    Left = 312
    Top = 104
  end
  object adqProduto: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      'select * from produto'
      'where 1=1')
    Left = 144
    Top = 252
    object adqProdutoid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object adqProdutodtcadastro: TDateField
      FieldName = 'dtcadastro'
    end
    object adqProdutoposarvore: TWideStringField
      FieldName = 'posarvore'
      Size = 40
    end
    object adqProdutonmproduto: TWideStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 80
      FieldName = 'nmproduto'
      Size = 200
    end
    object adqProdutounimedida_id: TIntegerField
      FieldName = 'unimedida_id'
    end
    object adqProdutocdbarra: TWideStringField
      FieldName = 'cdbarra'
      Size = 100
    end
    object adqProdutoidprodvenda: TSmallintField
      FieldName = 'idprodvenda'
    end
    object adqProdutoidadicional: TSmallintField
      FieldName = 'idadicional'
    end
    object adqProdutoimgindex: TIntegerField
      FieldName = 'imgindex'
    end
    object adqProdutoid_web: TIntegerField
      FieldName = 'id_web'
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = adqProduto
    OnStateChange = dtsPadraoStateChange
    Left = 176
    Top = 252
  end
end
