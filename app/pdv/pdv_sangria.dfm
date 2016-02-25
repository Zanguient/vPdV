object frmsangria: Tfrmsangria
  Left = 383
  Top = 285
  BorderStyle = bsNone
  ClientHeight = 100
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object scbMenu: TScrollBox
    Left = 0
    Top = 52
    Width = 400
    Height = 48
    Align = alBottom
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ParentBackground = True
    TabOrder = 0
    object btnCancelar: TcxButton
      Left = 200
      Top = 0
      Width = 200
      Height = 48
      Caption = 'Cancelar'
      TabOrder = 0
      OnClick = btnCancelarClick
      Align = alRight
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
    object btnConfirmar: TcxButton
      Left = 0
      Top = 0
      Width = 200
      Height = 48
      Caption = 'Confirmar'
      TabOrder = 1
      OnClick = btnConfirmarClick
      Align = alClient
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
  end
  object scbValor: TScrollBox
    Left = 0
    Top = 0
    Width = 400
    Height = 52
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ParentBackground = True
    TabOrder = 1
    object lblVrRetirada: TcxLabel
      Left = 35
      Top = 14
      Caption = 'Valor da retirada'
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
      Left = 185
      Top = 18
      EditValue = 0.000000000000000000
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.MaxValue = True
      Properties.DisplayFormat = 'R$ ,0.00;-R$ ,0.00'
      Properties.MaxLength = 13
      TabOrder = 1
      OnKeyPress = edtValorKeyPress
      Width = 163
    end
  end
  object adqPadrao: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    Left = 328
    Top = 40
    object adqPadraoID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object adqPadraoID_CAIXA: TIntegerField
      FieldName = 'ID_CAIXA'
    end
    object adqPadraoVRINICIAL: TFloatField
      FieldName = 'VRINICIAL'
    end
    object adqPadraoVRCORRIGIDO: TFloatField
      FieldName = 'VRCORRIGIDO'
    end
    object adqPadraoDTMOVI: TDateField
      FieldName = 'DTMOVI'
    end
    object adqPadraoFUNCICONFABERTURA: TIntegerField
      FieldName = 'FUNCICONFABERTURA'
    end
    object adqPadraoSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
  end
  object dspPadrao: TDataSetProvider
    DataSet = adqPadrao
    Left = 296
    Top = 40
  end
  object dtsPadrao: TDataSource
    DataSet = adqPadrao
    Left = 360
    Top = 40
  end
  object adqInsMovCaixa: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <
      item
        Name = 'ID_CAIXA'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 64
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'DTMOVI'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 64
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'VRMOVI'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 64
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'TPMOVI'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 64
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'FORMPGTO'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 64
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT INTO MOVCAIXA (ID_CAIXA, DTMOVI, VRMOVI, TPMOVI, FORMPGTO' +
        ')'
      '  VALUES (:ID_CAIXA, :DTMOVI, :VRMOVI, :TPMOVI, :FORMPGTO)')
    Left = 352
    Top = 72
  end
end
