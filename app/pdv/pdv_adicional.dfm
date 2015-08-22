object frmAdicional: TfrmAdicional
  Left = 192
  Top = 103
  BorderStyle = bsNone
  ClientHeight = 453
  ClientWidth = 920
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
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
      OnClick = btnCancelarClick
      Align = alLeft
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
  end
  object cdsAdicional: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 592
    Top = 64
    object cdsAdicionalID: TIntegerField
      FieldName = 'ID'
    end
    object cdsAdicionalNMADICIONAL: TStringField
      FieldName = 'NMADICIONAL'
      Size = 250
    end
    object cdsAdicionalIDMARCADO: TStringField
      FieldName = 'IDMARCADO'
      Size = 1
    end
    object cdsAdicionalIDIMG: TIntegerField
      FieldName = 'IDIMG'
    end
  end
  object dtsAdicional: TDataSource
    DataSet = cdsAdicional
    Left = 624
    Top = 64
  end
end
