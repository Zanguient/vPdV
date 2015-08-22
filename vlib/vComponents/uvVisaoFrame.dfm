inherited vVisaoFrame: TvVisaoFrame
  inherited panClient: TPanel
    object cxVerticalGrid1: TcxVerticalGrid
      Left = 0
      Top = 0
      Width = 477
      Height = 81
      Align = alTop
      TabOrder = 0
      Version = 1
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 113
      Width = 376
      Height = 355
      Align = alClient
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGrid1DBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object panFiltro: TPanel
      Left = 0
      Top = 81
      Width = 477
      Height = 32
      Align = alTop
      TabOrder = 2
      object cxDBNavigator1: TcxDBNavigator
        Left = 254
        Top = 1
        Width = 222
        Height = 30
        Buttons.ConfirmDelete = False
        Buttons.Insert.Enabled = False
        Buttons.Insert.Visible = False
        Buttons.Append.Enabled = False
        Buttons.Delete.Enabled = False
        Buttons.Delete.Visible = False
        Buttons.Edit.Enabled = False
        Buttons.Edit.Visible = False
        Buttons.Post.Enabled = False
        Buttons.Post.Visible = False
        Buttons.Cancel.Enabled = False
        Buttons.Cancel.Visible = False
        Buttons.Refresh.Enabled = False
        Buttons.Refresh.Visible = False
        Buttons.SaveBookmark.Enabled = False
        Buttons.SaveBookmark.Visible = False
        Buttons.GotoBookmark.Enabled = False
        Buttons.GotoBookmark.Visible = False
        Buttons.Filter.Enabled = False
        Buttons.Filter.Visible = False
        InfoPanel.Font.Charset = DEFAULT_CHARSET
        InfoPanel.Font.Color = clDefault
        InfoPanel.Font.Height = -11
        InfoPanel.Font.Name = 'MS Sans Serif'
        InfoPanel.Font.Style = []
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = 'McSkin'
        Align = alRight
        TabOrder = 0
      end
    end
    object dxNavBar: TdxNavBar
      Left = 376
      Top = 113
      Width = 101
      Height = 355
      Align = alRight
      ActiveGroupIndex = 0
      TabOrder = 3
      View = 17
      ViewStyle.ColorSchemeName = 'Silver'
      OptionsView.NavigationPane.OverflowPanelUseSmallImages = False
      OptionsView.NavigationPane.ShowHeader = False
      OptionsView.NavigationPane.ShowOverflowPanel = False
      object nbPesquisa: TdxNavBarGroup
        Caption = 'Pesquisa'
        SelectedLinkIndex = -1
        TopVisibleLinkIndex = 0
        Links = <
          item
            Item = nbiFiltrar
          end
          item
            Item = nbLimpar
          end>
      end
      object nbProcesso: TdxNavBarGroup
        Caption = 'Processo'
        SelectedLinkIndex = -1
        TopVisibleLinkIndex = 0
        Links = <
          item
            Item = nbiIncluir
          end
          item
            Item = nbiExcluir
          end>
      end
      object nbiFiltrar: TdxNavBarItem
        Action = actFilttar
      end
      object nbLimpar: TdxNavBarItem
        Action = acrLimpar
      end
      object nbiIncluir: TdxNavBarItem
        Caption = 'Incluir'
      end
      object nbiExcluir: TdxNavBarItem
        Caption = 'Excluir'
      end
    end
  end
  object ActionList1: TActionList
    Left = 424
    Top = 184
    object actFilttar: TAction
      Caption = 'Filttar'
    end
    object acrLimpar: TAction
      Caption = 'Limpar'
    end
  end
end
