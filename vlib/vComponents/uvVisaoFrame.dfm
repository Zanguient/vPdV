inherited vVisaoFrame: TvVisaoFrame
  inherited panTop: TPanel
    Height = 29
    inherited lblNomeFrame: TLabel
      Left = 119
      Height = 27
    end
    inherited btnFechar: TcxButton
      Height = 27
      SpeedButtonOptions.Transparent = False
    end
    object cxNavPadrao: TcxDBNavigator
      Left = 1
      Top = 1
      Width = 118
      Height = 27
      Buttons.OnButtonClick = cxNavPadraoButtonsButtonClick
      Buttons.Images = lb_imagens.img16x16
      Buttons.First.Visible = False
      Buttons.PriorPage.Visible = False
      Buttons.Prior.Visible = False
      Buttons.Next.Visible = False
      Buttons.NextPage.Visible = False
      Buttons.Last.Visible = False
      Buttons.Insert.ImageIndex = 3
      Buttons.Insert.Visible = True
      Buttons.Delete.ImageIndex = 13
      Buttons.Delete.Visible = True
      Buttons.Edit.Visible = False
      Buttons.Post.Visible = False
      Buttons.Cancel.Visible = False
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
      LookAndFeel.NativeStyle = True
      Align = alLeft
      TabOrder = 1
    end
  end
  inherited panClient: TPanel
    Top = 29
    Height = 466
    object cxgridFiltro: TcxVerticalGrid
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
      Height = 353
      Align = alClient
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGrid1DBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxGrid1DBTableView1CustomDrawCell
        DataController.DataSource = dtsPadrao
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CellMultiSelect = True
        OptionsView.GroupByBox = False
        Styles.Header = cxStyle1
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
      Height = 353
      Align = alRight
      ActiveGroupIndex = 0
      TabOrder = 3
      View = 17
      ViewStyle.ColorSchemeName = 'Silver'
      OptionsImage.SmallImages = lb_imagens.img16x16
      OptionsView.Common.ShowGroupCaptions = False
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
      object nbiFiltrar: TdxNavBarItem
        Action = actFilttar
      end
      object nbLimpar: TdxNavBarItem
        Action = actLimpar
      end
    end
  end
  inherited dtsPadrao: TDataSource
    AutoEdit = False
  end
  object ActionList1: TActionList
    Images = lb_imagens.img16x16
    Left = 424
    Top = 184
    object actFilttar: TAction
      Caption = 'Filtrar'
      ImageIndex = 0
      OnExecute = actFilttarExecute
    end
    object actLimpar: TAction
      Caption = 'Limpar'
      ImageIndex = 1
      OnExecute = actLimparExecute
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 400
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clActiveBorder
    end
  end
end
