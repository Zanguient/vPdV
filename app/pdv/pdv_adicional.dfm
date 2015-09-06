object frmAdicional: TfrmAdicional
  Left = 192
  Top = 103
  BorderStyle = bsNone
  ClientHeight = 517
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
  object scbOpcoes: TScrollBox
    Left = 0
    Top = 426
    Width = 920
    Height = 91
    Align = alBottom
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ParentBackground = True
    TabOrder = 0
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
  object panDireita: TPanel
    Left = 471
    Top = 0
    Width = 449
    Height = 426
    Align = alRight
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object scbAdicional: TScrollBox
      Left = 0
      Top = 0
      Width = 449
      Height = 267
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ParentBackground = True
      TabOrder = 0
    end
    object dbgAdicional: TcxGrid
      Left = 0
      Top = 267
      Width = 449
      Height = 159
      Align = alBottom
      TabOrder = 1
      object dbgAdicionalPedido: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        OnCellClick = dbgAdicionalPedidoCellClick
        DataController.DataSource = frmPDV_PDV.dtsAddPedido
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object dbgAdicionalPedidoColumn1: TcxGridDBColumn
          Caption = 'Adicional'
          DataBinding.FieldName = 'NMPRODUTO'
          Width = 264
        end
        object dbgAdicionalPedidoColumn2: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTITEM'
          Width = 89
        end
        object dbgAdicionalPedidoColumn3: TcxGridDBColumn
          Caption = 'Valor Unit'#225'rio'
          DataBinding.FieldName = 'VRUNITARIO'
          Width = 101
        end
        object dbgAdicionalPedidoColumn4: TcxGridDBColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'VRTOTAITEM'
          Width = 99
        end
        object cdbgExcluir: TcxGridDBColumn
          DataBinding.FieldName = 'IMG'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 0
          Properties.Images = frmPDV_PDV.cilPDV_16
          Properties.Items = <>
          Width = 25
          IsCaptionAssigned = True
        end
      end
      object dbgAdicionalDBBandedTableView1: TcxGridDBBandedTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Bands = <
          item
            Caption = 'Grupo 1'
          end
          item
            Caption = 'Grupo 2'
          end>
        object dbgAdicionalDBBandedTableView1Column1: TcxGridDBBandedColumn
          Caption = 'Coluna 1'
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object dbgAdicionalDBBandedTableView1Column2: TcxGridDBBandedColumn
          Caption = 'Coluna 2'
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object dbgAdicionalDBBandedTableView1Column3: TcxGridDBBandedColumn
          Caption = 'Coluna 3'
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object dbgAdicionalDBBandedTableView1Column4: TcxGridDBBandedColumn
          Caption = 'Coluna 4'
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
      end
      object dbgAdicionalLevel1: TcxGridLevel
        GridView = dbgAdicionalPedido
      end
    end
  end
  object scbAgrupAdicional: TScrollBox
    Left = 0
    Top = 0
    Width = 471
    Height = 426
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ParentBackground = True
    TabOrder = 2
  end
  object cdsAdicional: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'VALOR'
        DataType = ftFloat
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
      end
      item
        Name = 'NMPRODUTO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'IMGINDEX'
        DataType = ftInteger
      end
      item
        Name = 'IDTIPOMED'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 592
    Top = 64
    Data = {
      BE0000009619E0BD010000001800000006000000000003000000BE0002494404
      0001000200010007535542545950450200490008004175746F696E6300055641
      4C4F5208000400000000000A5155414E5449444144450800040000000000094E
      4D50524F4455544F010049000000010005574944544802000200C80008494D47
      494E44455804000100000000000949445449504F4D4544010049000000010005
      574944544802000200010001000C4155544F494E4356414C5545040001000100
      0000}
    object cdsAdicionalID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object cdsAdicionalVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object cdsAdicionalQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsAdicionalNMPRODUTO: TStringField
      FieldName = 'NMPRODUTO'
      Size = 200
    end
    object cdsAdicionalIMGINDEX: TIntegerField
      FieldName = 'IMGINDEX'
    end
    object cdsAdicionalIDTIPOMED: TStringField
      FieldName = 'IDTIPOMED'
      Size = 1
    end
  end
  object dtsAdicional: TDataSource
    DataSet = cdsAdicional
    Left = 624
    Top = 64
  end
  object dspAdicional: TDataSetProvider
    DataSet = adqAdicional
    Left = 528
    Top = 64
  end
  object adqAdicional: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <
      item
        Name = 'P_AGRUPADICIONAL'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 248
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT A.ID, A.VALOR, A.QUANTIDADE, P.NMPRODUTO, P.IMGINDEX, U.I' +
        'DTIPOMED'
      '  FROM ADICIONAIS A INNER JOIN PRODUTO P ON P.ID = A.ITEM_ID'
      
        '                    INNER JOIN UNIMEDIDA U ON P.UNIMEDIDA_ID = U' +
        '.ID'
      ' WHERE A.AGRUPADICIONAL_ID = :P_AGRUPADICIONAL'
      '   AND P.IDADICIONAL = 1')
    Left = 560
    Top = 64
  end
end
