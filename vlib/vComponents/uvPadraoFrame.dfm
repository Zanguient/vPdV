object vPadraoFrame: TvPadraoFrame
  Left = 0
  Top = 0
  Width = 477
  Height = 495
  TabOrder = 0
  object panTop: TPanel
    Left = 0
    Top = 0
    Width = 477
    Height = 27
    Align = alTop
    AutoSize = True
    ParentColor = True
    TabOrder = 0
    object lblNomeFrame: TLabel
      Left = 1
      Top = 1
      Width = 81
      Height = 25
      Align = alLeft
      Caption = '[Nome do Frame]'
      Visible = False
    end
    object btnFechar: TcxButton
      Left = 452
      Top = 1
      Width = 24
      Height = 25
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
      SpeedButtonOptions.Transparent = True
    end
  end
  object panClient: TPanel
    Left = 0
    Top = 27
    Width = 477
    Height = 468
    Align = alClient
    AutoSize = True
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
  end
  object cdsPadrao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPadrao'
    Left = 368
    Top = 40
  end
  object dtsPadrao: TDataSource
    DataSet = cdsPadrao
    Left = 400
    Top = 40
  end
  object adqPadrao: TADOQuery
    Connection = dmConexao.adoConexaoBd
    DataSource = dtsPadrao
    Parameters = <>
    Left = 368
    Top = 80
  end
  object dspPadrao: TDataSetProvider
    DataSet = adqPadrao
    Options = [poAllowMultiRecordUpdates]
    Left = 416
    Top = 80
  end
end
