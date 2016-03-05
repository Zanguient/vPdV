inherited frameControleAcesso: TframeControleAcesso
  Width = 756
  Height = 565
  inherited panTop: TPanel
    Width = 756
    inherited lblNomeFrame: TLabel
      Width = 96
      Caption = 'Controle de acessos'
    end
    inherited btnFechar: TcxButton
      Left = 731
    end
  end
  inherited panClient: TPanel
    Width = 756
    Height = 538
    object Splitter1: TSplitter
      Left = 321
      Top = 0
      Height = 538
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 321
      Height = 538
      Align = alLeft
      Caption = 'Funcion'#225'rios'
      Color = clWhite
      ParentColor = False
      TabOrder = 0
      object dbgFuncionarios: TDBGrid
        Left = 2
        Top = 15
        Width = 317
        Height = 521
        Align = alClient
        DataSource = dsFuncionario
        Options = [dgColumnResize, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 306
            Visible = True
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 324
      Top = 0
      Width = 317
      Height = 538
      Align = alLeft
      Caption = 'Rotinas'
      Color = clWhite
      ParentColor = False
      TabOrder = 1
      object dbgRotina: TDBGrid
        Left = 2
        Top = 15
        Width = 313
        Height = 521
        Align = alClient
        DataSource = dsRotina
        Options = [dgColumnResize, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 306
            Visible = True
          end>
      end
    end
    object GroupBox3: TGroupBox
      Left = 641
      Top = 0
      Width = 185
      Height = 538
      Align = alLeft
      Caption = 'Opera'#231#245'es'
      Color = clWhite
      ParentColor = False
      TabOrder = 2
      object chkProcessar: TCheckBox
        Left = 4
        Top = 20
        Width = 110
        Height = 17
        Caption = 'Processar'
        Color = clWhite
        ParentColor = False
        TabOrder = 0
      end
      object chkVisualizar: TCheckBox
        Left = 4
        Top = 37
        Width = 110
        Height = 17
        Caption = 'Visualizar'
        Color = clWhite
        ParentColor = False
        TabOrder = 1
      end
      object chkExcluir: TCheckBox
        Left = 4
        Top = 54
        Width = 110
        Height = 17
        Caption = 'Excluir'
        Color = clWhite
        ParentColor = False
        TabOrder = 2
      end
      object chkEditar: TCheckBox
        Left = 4
        Top = 71
        Width = 110
        Height = 17
        Caption = 'Editar'
        Color = clWhite
        ParentColor = False
        TabOrder = 3
      end
      object chkInserir: TCheckBox
        Left = 4
        Top = 88
        Width = 110
        Height = 17
        Caption = 'Inserir'
        Color = clWhite
        ParentColor = False
        TabOrder = 4
      end
    end
  end
  object cdsFuncionario: TClientDataSet
    Aggregates = <>
    Params = <>
    ReadOnly = True
    AfterScroll = cdsFuncionarioAfterScroll
    Left = 184
    Top = 24
    object cdsFuncionarioNome: TStringField
      FieldName = 'Nome'
    end
    object cdsFuncionarioid: TIntegerField
      FieldName = 'id'
    end
    object cdsFuncionariousuario: TStringField
      FieldName = 'usuario'
      Size = 0
    end
  end
  object cdsRotina: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsRotinaAfterScroll
    Left = 144
    Top = 24
    object cdsRotinaid: TIntegerField
      FieldName = 'id'
    end
    object cdsRotinamodulo: TStringField
      FieldName = 'modulo'
    end
    object cdsRotinadescricao: TStringField
      FieldName = 'descricao'
    end
    object cdsRotinavisivel: TStringField
      FieldName = 'visivel'
      Size = 1
    end
  end
  object dsFuncionario: TDataSource
    DataSet = cdsFuncionario
    Left = 224
    Top = 8
  end
  object dsRotina: TDataSource
    DataSet = cdsRotina
    Left = 104
    Top = 24
  end
end
