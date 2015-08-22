inherited vVisaoClienteFrame: TvVisaoClienteFrame
  inherited panTop: TPanel
    inherited lblNomeFrame: TLabel
      Width = 32
      Caption = 'Cliente'
    end
  end
  inherited panClient: TPanel
    inherited cxgridFiltro: TcxVerticalGrid
      Version = 1
      object nmcliente: TcxEditorRow
        Properties.Caption = 'Cliente'
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
        object cxGrid1DBTableView1id: TcxGridDBColumn
          DataBinding.FieldName = 'id'
        end
        object cxGrid1DBTableView1idempresa: TcxGridDBColumn
          DataBinding.FieldName = 'idempresa'
        end
        object cxGrid1DBTableView1nrinscjurd: TcxGridDBColumn
          DataBinding.FieldName = 'nrinscjurd'
        end
        object cxGrid1DBTableView1nmcliente: TcxGridDBColumn
          DataBinding.FieldName = 'nmcliente'
          Width = 150
        end
        object cxGrid1DBTableView1identificador: TcxGridDBColumn
          DataBinding.FieldName = 'identificador'
          Visible = False
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
  inherited adqPadrao: TADOQuery
    SQL.Strings = (
      'select * from cliente'
      'where 1=1')
    object adqPadraoid: TAutoIncField
      DisplayLabel = 'Id'
      FieldName = 'id'
      ReadOnly = True
    end
    object adqPadraoidempresa: TIntegerField
      DisplayLabel = 'Empresa'
      FieldName = 'idempresa'
    end
    object adqPadraonrinscjurd: TWideStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'nrinscjurd'
    end
    object adqPadraonmcliente: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nmcliente'
      Size = 250
    end
    object adqPadraoidentificador: TWideStringField
      FieldName = 'identificador'
      Visible = False
      Size = 1
    end
    object adqPadraotelfixo: TWideStringField
      DisplayLabel = 'Fixo'
      FieldName = 'telfixo'
      Size = 15
    end
    object adqPadraotelcel: TWideStringField
      DisplayLabel = 'Celular'
      FieldName = 'telcel'
      Size = 15
    end
  end
end
