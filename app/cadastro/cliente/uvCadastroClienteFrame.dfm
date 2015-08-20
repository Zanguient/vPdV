inherited vCadastroClienteFrame: TvCadastroClienteFrame
  Height = 443
  inherited panClient: TPanel
    Height = 416
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
      Height = 295
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
      inherited nbiInserir: TdxNavBarItem
        OnClick = nbiInserirClick
      end
      inherited nbiExcluir: TdxNavBarItem
        OnClick = nbiExcluirClick
      end
      object nbiSalvar: TdxNavBarItem
        Caption = 'Salvar'
        OnClick = nbiSalvarClick
      end
    end
    inherited panGrid: TPanel
      Height = 295
      inherited pnlNavigator: TPanel
        inherited cxDBNavigator1: TcxDBNavigator
          DataSource = dtsPadrao
        end
        inherited lblGridCaption: TcxLabel
          Style.IsFontAssigned = True
        end
      end
      inherited cxGrid1: TcxGrid
        Height = 271
      end
    end
  end
  inherited cdsPadrao: TClientDataSet
    object cdsPadraoid: TAutoIncField
      FieldName = 'id'
    end
    object cdsPadraoidempresa: TIntegerField
      FieldName = 'idempresa'
    end
    object cdsPadraonrinscjurd: TWideStringField
      FieldName = 'nrinscjurd'
    end
    object cdsPadraonmcliente: TWideStringField
      FieldName = 'nmcliente'
      Size = 250
    end
    object cdsPadraoidentificador: TWideStringField
      FieldName = 'identificador'
      Size = 1
    end
    object cdsPadraotelcel: TWideStringField
      FieldName = 'telcel'
      Size = 15
    end
    object cdsPadraotelfixo: TWideStringField
      FieldName = 'telfixo'
      Size = 15
    end
  end
  inherited dtsPadrao: TDataSource
    DataSet = adqPadrao
  end
  inherited adqPadrao: TADOQuery
    CursorType = ctStatic
    DataSource = nil
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
