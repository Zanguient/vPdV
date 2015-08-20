inherited vCadastroFrame: TvCadastroFrame
  Width = 649
  Height = 469
  inherited panTop: TPanel
    Width = 649
    Height = 29
    inherited lblNomeFrame: TLabel
      Left = 101
      Height = 27
    end
    inherited btnFechar: TcxButton
      Left = 624
      Height = 27
    end
    object cxNavPadrao: TcxDBNavigator
      Left = 1
      Top = 1
      Width = 100
      Height = 27
      Buttons.First.Visible = False
      Buttons.PriorPage.Visible = False
      Buttons.Prior.Visible = False
      Buttons.Next.Visible = False
      Buttons.NextPage.Visible = False
      Buttons.Last.Visible = False
      Buttons.Insert.Visible = False
      Buttons.Delete.Visible = False
      Buttons.Edit.Visible = False
      Buttons.Refresh.Visible = False
      Buttons.SaveBookmark.Visible = False
      Buttons.GotoBookmark.Visible = False
      Buttons.Filter.Visible = False
      DataSource = dtsPadrao
      InfoPanel.Font.Charset = DEFAULT_CHARSET
      InfoPanel.Font.Color = clDefault
      InfoPanel.Font.Height = -11
      InfoPanel.Font.Name = 'MS Sans Serif'
      InfoPanel.Font.Style = []
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'McSkin'
      Align = alLeft
      TabOrder = 1
    end
  end
  inherited panClient: TPanel
    Top = 29
    Width = 649
    Height = 440
    object cxvGrid1: TcxDBVerticalGrid
      Left = 0
      Top = 0
      Width = 649
      Height = 121
      Align = alTop
      TabOrder = 0
      Version = 1
    end
    object dxNavBar1: TdxNavBar
      Left = 499
      Top = 121
      Width = 150
      Height = 319
      Align = alRight
      ActiveGroupIndex = 0
      TabOrder = 1
      View = 17
      ViewStyle.ColorSchemeName = 'Silver'
      OptionsView.NavigationPane.OverflowPanelUseSmallImages = False
      OptionsView.NavigationPane.ShowHeader = False
      OptionsView.NavigationPane.ShowOverflowPanel = False
      object nbProcesso: TdxNavBarGroup
        Caption = 'Processo'
        SelectedLinkIndex = -1
        TopVisibleLinkIndex = 0
        Links = <
          item
            Item = nbiInserir
          end
          item
            Item = nbiExcluir
          end>
      end
      object nbiInserir: TdxNavBarItem
        Action = actInserir
      end
      object nbiExcluir: TdxNavBarItem
        Action = actExcluir
      end
    end
    object panGrid: TPanel
      Left = 0
      Top = 121
      Width = 499
      Height = 319
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object pnlNavigator: TPanel
        Left = 0
        Top = 0
        Width = 499
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object cxNavDetail: TcxDBNavigator
          Left = 179
          Top = 0
          Width = 320
          Height = 24
          Buttons.PriorPage.Visible = False
          Buttons.NextPage.Visible = False
          Buttons.Edit.Visible = False
          Buttons.Refresh.Visible = False
          Buttons.SaveBookmark.Visible = False
          Buttons.GotoBookmark.Visible = False
          Buttons.Filter.Visible = False
          DataSource = dtsDetail
          InfoPanel.Font.Charset = DEFAULT_CHARSET
          InfoPanel.Font.Color = clDefault
          InfoPanel.Font.Height = -11
          InfoPanel.Font.Name = 'MS Sans Serif'
          InfoPanel.Font.Style = []
          LookAndFeel.Kind = lfStandard
          LookAndFeel.NativeStyle = False
          LookAndFeel.SkinName = 'McSkin'
          Align = alRight
          TabOrder = 0
        end
        object lblGridCaption: TcxLabel
          Left = 0
          Top = 0
          Align = alLeft
          Caption = '[Digite caption Grid]'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -15
          Style.Font.Name = 'MS Sans Serif'
          Style.Font.Style = []
          Style.TextStyle = [fsBold]
          Style.IsFontAssigned = True
          StyleHot.TextStyle = [fsBold]
        end
      end
      object cxGrid1: TcxGrid
        Left = 0
        Top = 24
        Width = 499
        Height = 295
        Align = alClient
        TabOrder = 1
        object cxGrid1DBTableView1: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dtsDetail
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
  end
  inherited dtsPadrao: TDataSource
    OnStateChange = dtsPadraoStateChange
  end
  inherited adqPadrao: TADOQuery
    SQL.Strings = (
      'select *'
      '  from clientes')
  end
  object dtsDetail: TDataSource
    DataSet = adqDetail
    Left = 424
    Top = 262
  end
  object adqDetail: TADOQuery
    Connection = dmConexao.adoConexaoBd
    BeforeEdit = adqDetailBeforeEdit
    Parameters = <>
    SQL.Strings = (
      'select *'
      '  from clientes')
    Left = 384
    Top = 264
  end
  object ActionList1: TActionList
    Left = 312
    Top = 224
    object actInserir: TAction
      Caption = 'Inserir'
      ShortCut = 45
      OnExecute = actInserirExecute
    end
    object actExcluir: TAction
      Caption = 'Excluir'
      ShortCut = 46
      OnExecute = actExcluirExecute
    end
  end
end
