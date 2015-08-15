inherited vCadastroFrame: TvCadastroFrame
  Width = 649
  Height = 469
  inherited panTop: TPanel
    Width = 649
    inherited btnFechar: TcxButton
      Left = 624
    end
  end
  inherited panClient: TPanel
    Width = 649
    Height = 442
    object cxvGrid1: TcxDBVerticalGrid
      Left = 0
      Top = 0
      Width = 649
      Height = 121
      Align = alTop
      TabOrder = 0
      DataController.DataSource = DataSource1
      Version = 1
    end
    object dxNavBar1: TdxNavBar
      Left = 499
      Top = 121
      Width = 150
      Height = 321
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
        Caption = 'Inserir'
      end
      object nbiExcluir: TdxNavBarItem
        Caption = 'Excluir'
      end
    end
    object panGrid: TPanel
      Left = 0
      Top = 121
      Width = 499
      Height = 321
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
        object cxDBNavigator1: TcxDBNavigator
          Left = 169
          Top = 0
          Width = 330
          Height = 24
          Buttons.Edit.Visible = False
          Buttons.Refresh.Visible = False
          Buttons.SaveBookmark.Visible = False
          Buttons.GotoBookmark.Visible = False
          Buttons.Filter.Visible = False
          DataSource = DataSource2
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
        Height = 297
        Align = alClient
        TabOrder = 1
        object cxGrid1DBTableView1: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = DataSource2
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
  object DataSource2: TDataSource [2]
    DataSet = ClientDataSet2
    Left = 424
    Top = 262
  end
  object ClientDataSet2: TClientDataSet [3]
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 262
  end
end
