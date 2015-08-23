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
      OnClick = btnConfirmaClick
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
      OnClick = btnSemAddClick
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
    Active = True
    Aggregates = <>
    Params = <>
    Left = 592
    Top = 64
    Data = {
      710000009619E0BD010000001800000004000000000003000000710002494404
      000100000000000B4E4D41444943494F4E414C01004900000001000557494454
      4802000200FA000949444D41524341444F010049000000010005574944544802
      0002000100054944494D4704000100000000000000}
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
  object dspAdicional: TDataSetProvider
    Left = 528
    Top = 64
  end
  object adqPadrao: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      
        'SELECT id id_mesa, nmmesa, dsobsmesa, idmesaativ status, 0.00 va' +
        'lor'
      '  FROM MESA'
      '')
    Left = 560
    Top = 64
  end
end
