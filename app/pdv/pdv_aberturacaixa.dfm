object frmAberturaCaixa: TfrmAberturaCaixa
  Left = 383
  Top = 285
  BorderStyle = bsNone
  ClientHeight = 100
  ClientWidth = 400
  Color = clBtnHighlight
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
    object lblVrCaixa: TcxLabel
      Left = 44
      Top = 14
      Caption = 'Valor no Caixa'
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
      Left = 173
      Top = 18
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
    SQL.Strings = (
      
        'SELECT ID, ID_CAIXA, VRINICIAL, VRCORRIGIDO, DTMOVI, FUNCICONFAB' +
        'ERTURA, STATUS'
      '  FROM ABERCAIXA'
      ' WHERE STATUS = '#39'A'#39
      '')
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
  object adqInicia: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <
      item
        Name = 'ID_CAIXA'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'VRCORRIGIDO'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'FUNCICONFABERTURA'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'STATUS'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO ABERCAIXA'
      
        '  (ID_CAIXA, VRINICIAL, VRCORRIGIDO, DTMOVI, FUNCICONFABERTURA, ' +
        'STATUS)'
      'VALUES'
      
        '  (:ID_CAIXA, 0, :VRCORRIGIDO, NOW(), :FUNCICONFABERTURA, :STATU' +
        'S)')
    Left = 328
    Top = 72
    object AutoIncField1: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object IntegerField1: TIntegerField
      FieldName = 'ID_CAIXA'
    end
    object FloatField1: TFloatField
      FieldName = 'VRINICIAL'
    end
    object FloatField2: TFloatField
      FieldName = 'VRCORRIGIDO'
    end
    object DateField1: TDateField
      FieldName = 'DTMOVI'
    end
    object IntegerField2: TIntegerField
      FieldName = 'FUNCICONFABERTURA'
    end
    object StringField1: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
  end
end
