object frmAberturaFechamentoCaixa: TfrmAberturaFechamentoCaixa
  Left = 441
  Top = 136
  AutoScroll = False
  BorderIcons = []
  BorderStyle = bsSizeToolWin
  ClientHeight = 298
  ClientWidth = 482
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panPreAbertura: TPanel
    Left = 0
    Top = 0
    Width = 482
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    Visible = False
    object lblVrCaixa: TcxLabel
      Left = 14
      Top = 14
      Caption = 'Valor remanescente no caixa'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBackground
      Style.Font.Height = -17
      Style.Font.Name = 'Latha'
      Style.Font.Style = [fsBold]
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object edtValorPreAbertura: TcxCurrencyEdit
      Left = 247
      Top = 18
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#,##0.00;-#,##0.00'
      Properties.MaxLength = 13
      TabOrder = 1
      Width = 200
    end
  end
  object panBotoes: TPanel
    Left = 0
    Top = 252
    Width = 482
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    Visible = False
    object btnConfirmar: TcxButton
      Left = 0
      Top = 0
      Width = 282
      Height = 42
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
      Align = alClient
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
    object btnCancelar: TcxButton
      Left = 282
      Top = 0
      Width = 200
      Height = 42
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
      Align = alRight
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
  end
  object panAbertura: TPanel
    Left = 0
    Top = 48
    Width = 482
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 2
    Visible = False
    object cxLabel1: TcxLabel
      Left = 34
      Top = 7
      Caption = 'Valor inicial do caixa'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBackground
      Style.Font.Height = -17
      Style.Font.Name = 'Latha'
      Style.Font.Style = [fsBold]
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object edtValorAbertura: TcxCurrencyEdit
      Left = 208
      Top = 11
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 1
      Width = 200
    end
  end
  object panFechamento: TPanel
    Left = 0
    Top = 91
    Width = 482
    Height = 161
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 3
    Visible = False
    object cxLabel2: TcxLabel
      Left = 4
      Top = 7
      Caption = 'Valor das vendas'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBackground
      Style.Font.Height = -17
      Style.Font.Name = 'Latha'
      Style.Font.Style = [fsBold]
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object edtVendasCalc: TcxCurrencyEdit
      Left = 166
      Top = 10
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 1
      Width = 154
    end
    object cxLabel3: TcxLabel
      Left = 4
      Top = 30
      Caption = 'Valor das retiradas'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBackground
      Style.Font.Height = -17
      Style.Font.Name = 'Latha'
      Style.Font.Style = [fsBold]
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object edtRetiradasCalc: TcxCurrencyEdit
      Left = 166
      Top = 33
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 3
      Width = 154
    end
    object cxLabel4: TcxLabel
      Left = 4
      Top = 53
      Caption = 'Valor das sangrias'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBackground
      Style.Font.Height = -17
      Style.Font.Name = 'Latha'
      Style.Font.Style = [fsBold]
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object edtSangriaCalc: TcxCurrencyEdit
      Left = 166
      Top = 56
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 5
      Width = 154
    end
    object cxLabel5: TcxLabel
      Left = 4
      Top = 76
      Caption = 'Valor das entradas'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBackground
      Style.Font.Height = -17
      Style.Font.Name = 'Latha'
      Style.Font.Style = [fsBold]
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object edtEntradaCalc: TcxCurrencyEdit
      Left = 166
      Top = 79
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 7
      Width = 154
    end
    object cxLabel6: TcxLabel
      Left = 4
      Top = 99
      Caption = 'Valor dos d'#233'bitos'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBackground
      Style.Font.Height = -17
      Style.Font.Name = 'Latha'
      Style.Font.Style = [fsBold]
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object edtDebitoCalc: TcxCurrencyEdit
      Left = 166
      Top = 102
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 9
      Width = 154
    end
    object cxLabel7: TcxLabel
      Left = 4
      Top = 122
      Caption = 'Valor dos cr'#233'ditos'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBackground
      Style.Font.Height = -17
      Style.Font.Name = 'Latha'
      Style.Font.Style = [fsBold]
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object edtCreditoCalc: TcxCurrencyEdit
      Left = 166
      Top = 125
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 11
      Width = 154
    end
    object edtVendasConf: TcxCurrencyEdit
      Left = 323
      Top = 10
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 12
      Width = 154
    end
    object edtSangriaConf: TcxCurrencyEdit
      Left = 323
      Top = 56
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 13
      Width = 154
    end
    object edtRetiradasConf: TcxCurrencyEdit
      Left = 323
      Top = 33
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 14
      Width = 154
    end
    object edtEntradaConf: TcxCurrencyEdit
      Left = 323
      Top = 79
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 15
      Width = 154
    end
    object edtDebitoConf: TcxCurrencyEdit
      Left = 323
      Top = 102
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 16
      Width = 154
    end
    object edtCreditoConf: TcxCurrencyEdit
      Left = 323
      Top = 125
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 17
      Width = 154
    end
  end
end
