object frmAdicional: TfrmAdicional
  Left = 192
  Top = 103
  BorderStyle = bsNone
  ClientHeight = 453
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object scbAdicional: TScrollBox
    Left = 0
    Top = 0
    Width = 920
    Height = 362
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ParentBackground = True
    TabOrder = 0
  end
  object scbOpcoes: TScrollBox
    Left = 0
    Top = 362
    Width = 920
    Height = 91
    Align = alBottom
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ParentBackground = True
    TabOrder = 1
    object btnConfirma: TcxButton
      Left = 0
      Top = 0
      Width = 200
      Height = 91
      Caption = 'Confirmar'
      TabOrder = 0
      Align = alLeft
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
    object btnSemAdd: TcxButton
      Left = 200
      Top = 0
      Width = 200
      Height = 91
      Caption = 'Sem adicional'
      TabOrder = 1
      Align = alLeft
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
    object btnCancelar: TcxButton
      Left = 400
      Top = 0
      Width = 200
      Height = 91
      Caption = 'Cancelar'
      TabOrder = 2
      Align = alLeft
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
  end
end
