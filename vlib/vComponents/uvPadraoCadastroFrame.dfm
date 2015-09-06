object vPadraoCadastro: TvPadraoCadastro
  Left = 0
  Top = 0
  Width = 505
  Height = 467
  TabOrder = 0
  object pgcPadrao: TcxPageControl
    Left = 0
    Top = 0
    Width = 505
    Height = 467
    ActivePage = tabCadastro
    Align = alClient
    TabOrder = 0
    OnChange = pgcPadraoChange
    ClientRectBottom = 463
    ClientRectLeft = 4
    ClientRectRight = 501
    ClientRectTop = 24
    object tabVisao: TcxTabSheet
      Caption = 'tabVisao'
      ImageIndex = 0
      object panClient: TPanel
        Left = 0
        Top = 29
        Width = 497
        Height = 410
        Align = alClient
        AutoSize = True
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object cxgridFiltro: TcxVerticalGrid
          Left = 0
          Top = 0
          Width = 497
          Height = 81
          Align = alTop
          TabOrder = 0
          Version = 1
        end
        object cxGrid1: TcxGrid
          Left = 0
          Top = 113
          Width = 396
          Height = 297
          Align = alClient
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object cxGrid1DBTableView1: TcxGridDBTableView
            OnDblClick = cxGrid1DBTableView1DblClick
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
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
        object panFiltro: TPanel
          Left = 0
          Top = 81
          Width = 497
          Height = 32
          Align = alTop
          TabOrder = 2
          object cxDBNavigator1: TcxDBNavigator
            Left = 274
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
            DataSource = dtsPadrao
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
          Left = 396
          Top = 113
          Width = 101
          Height = 297
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
      object panTop: TPanel
        Left = 0
        Top = 0
        Width = 497
        Height = 29
        Align = alTop
        AutoSize = True
        TabOrder = 1
        object lblNomeFrame: TLabel
          Left = 119
          Top = 1
          Width = 81
          Height = 27
          Align = alLeft
          Caption = '[Nome do Frame]'
          Visible = False
        end
        object btnFechar: TcxButton
          Left = 472
          Top = 1
          Width = 24
          Height = 27
          Caption = 'X'
          TabOrder = 0
          OnClick = btnFecharClick
          Align = alRight
          Colors.Default = clBtnHighlight
          Colors.NormalText = clActiveCaption
          Colors.Hot = clGradientActiveCaption
          Colors.HotText = clBtnHighlight
          Colors.Pressed = clRed
          Colors.PressedText = clBtnHighlight
          PaintStyle = bpsCaption
          SpeedButtonOptions.CanBeFocused = False
          SpeedButtonOptions.Flat = True
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
    end
    object tabCadastro: TcxTabSheet
      Caption = 'tbCadastro'
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 29
        Width = 497
        Height = 410
        Align = alClient
        AutoSize = True
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object cxvGrid1: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 497
          Height = 121
          Align = alTop
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.GoToNextCellOnTab = True
          TabOrder = 0
          DataController.DataSource = dtsPadrao
          Version = 1
        end
        object panGrid: TPanel
          Left = 0
          Top = 121
          Width = 497
          Height = 289
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object pnlNavigator: TPanel
            Left = 0
            Top = 0
            Width = 497
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object cxNavDetail: TcxDBNavigator
              Left = 177
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
          object cxGrid2: TcxGrid
            Left = 0
            Top = 24
            Width = 497
            Height = 265
            Align = alClient
            TabOrder = 1
            object cxGridDBTableView1: TcxGridDBTableView
              NavigatorButtons.ConfirmDelete = False
              DataController.DataSource = dtsDetail
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.GroupByBox = False
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridDBTableView1
            end
          end
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 497
        Height = 29
        Align = alTop
        AutoSize = True
        TabOrder = 1
        object Label1: TLabel
          Left = 97
          Top = 1
          Width = 81
          Height = 27
          Align = alLeft
          Caption = '[Nome do Frame]'
          Visible = False
        end
        object cxButton1: TcxButton
          Left = 472
          Top = 1
          Width = 24
          Height = 27
          Caption = 'X'
          TabOrder = 0
          OnClick = cxButton1Click
          Align = alRight
          Colors.Default = clBtnHighlight
          Colors.NormalText = clActiveCaption
          Colors.Hot = clGradientActiveCaption
          Colors.HotText = clBtnHighlight
          Colors.Pressed = clRed
          Colors.PressedText = clBtnHighlight
          PaintStyle = bpsCaption
          SpeedButtonOptions.CanBeFocused = False
          SpeedButtonOptions.Flat = True
          SpeedButtonOptions.Transparent = True
        end
        object cxNavCadastro: TcxDBNavigator
          Left = 1
          Top = 1
          Width = 96
          Height = 27
          Buttons.OnButtonClick = cxDBNavigator2ButtonsButtonClick
          Buttons.First.Visible = False
          Buttons.PriorPage.Visible = False
          Buttons.Prior.Visible = False
          Buttons.Next.Visible = False
          Buttons.NextPage.Visible = False
          Buttons.Last.Visible = False
          Buttons.Insert.Visible = True
          Buttons.Delete.Visible = True
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
    end
  end
  object adqPadrao: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 368
    Top = 40
  end
  object dtsPadrao: TDataSource
    AutoEdit = False
    DataSet = adqPadrao
    OnStateChange = dtsPadraoStateChange
    Left = 400
    Top = 40
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
  object adqDetail: TADOQuery
    Connection = dmConexao.adoConexaoBd
    BeforeOpen = adqDetailBeforeOpen
    OnNewRecord = adqDetailNewRecord
    Parameters = <>
    Left = 384
    Top = 264
  end
  object dtsDetail: TDataSource
    DataSet = adqDetail
    Left = 416
    Top = 264
  end
end
