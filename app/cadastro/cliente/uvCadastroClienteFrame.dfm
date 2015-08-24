inherited vCadastroClienteFrame: TvCadastroClienteFrame
  Height = 443
  inherited panClient: TPanel
    Height = 414
    inherited cxvGrid1: TcxDBVerticalGrid
      DataController.DataSource = dtsPadrao
      Version = 1
      object cxvGrid1id: TcxDBEditorRow
        Properties.DataBinding.FieldName = 'id'
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxvGrid1idempresa: TcxDBEditorRow
        Properties.DataBinding.FieldName = 'idempresa'
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
      object cxvGrid1nmcliente: TcxDBEditorRow
        Properties.DataBinding.FieldName = 'nmcliente'
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxvGrid1identificador: TcxDBEditorRow
        Properties.DataBinding.FieldName = 'identificador'
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxvGrid1telcel: TcxDBEditorRow
        Properties.DataBinding.FieldName = 'telcel'
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxvGrid1telfixo: TcxDBEditorRow
        Properties.DataBinding.FieldName = 'telfixo'
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
    end
    inherited dxNavBar1: TdxNavBar
      Height = 293
      inherited nbProcesso: TdxNavBarGroup
        Links = <
          item
            Item = nbiInserir
          end
          item
            Item = nbiExcluir
          end
          item
            Item = nbiSalvar
          end>
      end
      object nbiSalvar: TdxNavBarItem
        Caption = 'Salvar'
      end
    end
    inherited panGrid: TPanel
      Height = 293
      inherited pnlNavigator: TPanel
        inherited lblGridCaption: TcxLabel
          Style.IsFontAssigned = True
        end
      end
      inherited cxGrid1: TcxGrid
        Height = 269
      end
    end
  end
  inherited adqPadrao: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'select * from cliente')
    object adqPadraoid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object adqPadraoidempresa: TIntegerField
      FieldName = 'idempresa'
    end
    object adqPadraonrinscjurd: TWideStringField
      FieldName = 'nrinscjurd'
    end
    object adqPadraonmcliente: TWideStringField
      FieldName = 'nmcliente'
      Size = 250
    end
    object adqPadraoidentificador: TWideStringField
      FieldName = 'identificador'
      Size = 1
    end
    object adqPadraotelcel: TWideStringField
      FieldName = 'telcel'
      Size = 15
    end
    object adqPadraotelfixo: TWideStringField
      FieldName = 'telfixo'
      Size = 15
    end
  end
end
