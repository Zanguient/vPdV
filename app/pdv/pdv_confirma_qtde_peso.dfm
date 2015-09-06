object frmConfirmaQtdePeso: TfrmConfirmaQtdePeso
  Left = 441
  Top = 136
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 131
  ClientWidth = 354
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = edtQuantidadeKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object panBotoes: TPanel
    Left = 0
    Top = 89
    Width = 354
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object btnConfirmar: TcxButton
      Left = 0
      Top = 0
      Width = 177
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
      Left = 177
      Top = 0
      Width = 177
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
  object panFechamento: TPanel
    Left = 0
    Top = 0
    Width = 354
    Height = 89
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object lblQtde: TcxLabel
      Left = 4
      Top = 13
      Caption = 'Quantidade'
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
    object edtQuantidade: TcxCurrencyEdit
      Left = 107
      Top = 8
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DecimalPlaces = 3
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -19
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      OnKeyPress = edtQuantidadeKeyPress
      Width = 239
    end
    object lblValor: TcxLabel
      Left = 4
      Top = 50
      Caption = 'Valor'
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
    object edtValor: TcxCurrencyEdit
      Left = 107
      Top = 45
      Enabled = False
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -19
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 239
    end
  end
end
