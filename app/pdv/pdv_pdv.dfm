object frmPDV_PDV: TfrmPDV_PDV
  Left = 149
  Top = 107
  AlphaBlendValue = 250
  BorderIcons = []
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
  object scbMenu: TScrollBox
    Left = 0
    Top = 362
    Width = 920
    Height = 91
    Align = alBottom
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ParentBackground = True
    TabOrder = 0
    object btnGaveta: TcxButton
      Left = 0
      Top = 0
      Width = 200
      Height = 91
      Caption = 'Gaveta'
      TabOrder = 0
      Align = alLeft
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
    object btnFinalizarPedido: TcxButton
      Left = 200
      Top = 0
      Width = 200
      Height = 91
      Caption = 'Finalizar '
      TabOrder = 1
      Align = alLeft
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
    object btnGravar: TcxButton
      Left = 400
      Top = 0
      Width = 200
      Height = 91
      Caption = 'Gravar'
      TabOrder = 2
      Align = alLeft
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
    object btnCancelar: TcxButton
      Left = 600
      Top = 0
      Width = 200
      Height = 91
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
      Align = alLeft
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
    end
  end
  object scbGrupo: TScrollBox
    Left = 559
    Top = 0
    Width = 361
    Height = 362
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 1
    object scbCategoria: TScrollBox
      Left = 0
      Top = 0
      Width = 361
      Height = 120
      Align = alClient
      TabOrder = 0
    end
    object scbProduto: TScrollBox
      Left = 0
      Top = 120
      Width = 361
      Height = 242
      Align = alBottom
      TabOrder = 1
    end
  end
  object panGrids: TPanel
    Left = 0
    Top = 0
    Width = 559
    Height = 362
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = True
    ParentColor = True
    TabOrder = 2
    object dbgAdicional: TcxGrid
      Left = 0
      Top = 203
      Width = 559
      Height = 159
      Align = alBottom
      TabOrder = 0
      object dbgAdicionalDBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dtsAddPedido
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object dbgAdicionalDBTableView1Column1: TcxGridDBColumn
          Caption = 'Adicional'
          DataBinding.FieldName = 'NMPRODUTO'
          Width = 264
        end
        object dbgAdicionalDBTableView1Column2: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTITEM'
          Width = 89
        end
        object dbgAdicionalDBTableView1Column3: TcxGridDBColumn
          Caption = 'Valor Unit'#225'rio'
          DataBinding.FieldName = 'VRUNITARIO'
          Width = 101
        end
        object dbgAdicionalDBTableView1Column4: TcxGridDBColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'VRTOTAITEM'
          Width = 99
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
        GridView = dbgAdicionalDBTableView1
      end
    end
    object dbgProduto: TcxGrid
      Left = 0
      Top = 0
      Width = 559
      Height = 203
      Align = alClient
      TabOrder = 1
      object gdbPedido: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dtsItemPedido
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object gdbNmProduto: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'NMPRODUTO'
          Width = 260
        end
        object gdbQuantidade: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTITEM'
          Width = 90
        end
        object gdbVrUnitario: TcxGridDBColumn
          Caption = 'Valor Unit'#225'rio'
          DataBinding.FieldName = 'VRVENDA'
          Width = 101
        end
        object gdbVrTotaItem: TcxGridDBColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'VRTOTAL'
          PropertiesClassName = 'TcxProgressBarProperties'
          Width = 102
        end
      end
      object dbgProdutoChartView1: TcxGridChartView
        DiagramColumn.Active = True
      end
      object dbgProdutoLevel1: TcxGridLevel
        GridView = gdbPedido
      end
    end
  end
  object cdsProdutos: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 847
    Top = 128
    Data = {
      E00000009619E0BD010000001800000009000000000003000000E000096E6D70
      726F6475746F010049000000010005574944544802000200C800026964040001
      000000000009706F736172766F72650100490000000100055749445448020002
      0028000C756E696D65646964615F696404000100000000000763646261727261
      01004900000001000557494454480200020064000B696470726F6476656E6461
      04000100000000000B696461646963696F6E616C040001000000000008696D67
      696E64657804000100000000000C69645F63617465676F726961040001000000
      00000000}
    object cdsProdutosnmproduto: TStringField
      FieldName = 'nmproduto'
      Size = 200
    end
    object cdsProdutosid: TIntegerField
      FieldName = 'id'
    end
    object cdsProdutosposarvore: TStringField
      FieldName = 'posarvore'
      Size = 40
    end
    object cdsProdutosunimedida_id: TIntegerField
      FieldName = 'unimedida_id'
    end
    object cdsProdutoscdbarra: TStringField
      FieldName = 'cdbarra'
      Size = 100
    end
    object cdsProdutosidprodvenda: TIntegerField
      FieldName = 'idprodvenda'
    end
    object cdsProdutosidadicional: TIntegerField
      FieldName = 'idadicional'
    end
    object cdsProdutosimgindex: TIntegerField
      FieldName = 'imgindex'
    end
    object cdsProdutosid_categoria: TIntegerField
      FieldName = 'id_categoria'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 875
    Top = 128
  end
  object cdsCategoria: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 847
    Top = 159
    Data = {
      560000009619E0BD010000001800000003000000000003000000560002696404
      000100000000000B6E6D63617465676F72696101004900000001000557494454
      4802000200FA0008696D67696E64657804000100000000000000}
    object cdsCategoriaid: TIntegerField
      FieldName = 'id'
    end
    object cdsCategorianmcategoria: TStringField
      FieldName = 'nmcategoria'
      Size = 250
    end
    object cdsCategoriaimgindex: TIntegerField
      FieldName = 'imgindex'
    end
  end
  object dtsCategoria: TDataSource
    DataSet = cdsCategoria
    Left = 875
    Top = 159
  end
  object cdsItemPedido: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'PEDIDO_ID'
        DataType = ftInteger
      end
      item
        Name = 'CARDAPIO_ID'
        DataType = ftInteger
      end
      item
        Name = 'LOTE_ID'
        DataType = ftInteger
      end
      item
        Name = 'QTITEM'
        DataType = ftFloat
      end
      item
        Name = 'VRVENDA'
        DataType = ftFloat
      end
      item
        Name = 'VRTOTAL'
        DataType = ftFloat
      end
      item
        Name = 'IDADICIONAL'
        DataType = ftInteger
      end
      item
        Name = 'NMPRODUTO'
        DataType = ftString
        Size = 250
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 847
    Top = 190
    Data = {
      BC0000009619E0BD010000001800000009000000000003000000BC0002494404
      000100000000000950454449444F5F494404000100000000000B434152444150
      494F5F49440400010000000000074C4F54455F49440400010000000000065154
      4954454D080004000000000007565256454E4441080004000000000007565254
      4F54414C08000400000000000B494441444943494F4E414C0400010000000000
      094E4D50524F4455544F010049000000010005574944544802000200FA000000}
    object cdsItemPedidoID: TIntegerField
      FieldName = 'ID'
    end
    object cdsItemPedidoPEDIDO_ID: TIntegerField
      FieldName = 'PEDIDO_ID'
    end
    object cdsItemPedidoCARDAPIO_ID: TIntegerField
      FieldName = 'CARDAPIO_ID'
    end
    object cdsItemPedidoLOTE_ID: TIntegerField
      FieldName = 'LOTE_ID'
    end
    object cdsItemPedidoQTITEM: TFloatField
      FieldName = 'QTITEM'
    end
    object cdsItemPedidoVRVENDA: TFloatField
      FieldName = 'VRVENDA'
    end
    object cdsItemPedidoVRTOTAL: TFloatField
      FieldName = 'VRTOTAL'
    end
    object cdsItemPedidoIDADICIONAL: TIntegerField
      FieldName = 'IDADICIONAL'
    end
    object cdsItemPedidoNMPRODUTO: TStringField
      FieldName = 'NMPRODUTO'
      Size = 250
    end
  end
  object dtsItemPedido: TDataSource
    DataSet = cdsItemPedido
    Left = 875
    Top = 190
  end
  object cdsAddPedido: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 847
    Top = 222
    Data = {
      780000009619E0BD010000001800000005000000000003000000780002696404
      00010000000000094E4D50524F4455544F010049000000010005574944544802
      000200FA000651544954454D08000400000000000A5652554E49544152494F08
      000400000000000A5652544F54414954454D08000400000000000000}
    object cdsAddPedidoid: TIntegerField
      FieldName = 'id'
    end
    object cdsAddPedidoNMPRODUTO: TStringField
      FieldName = 'NMPRODUTO'
      Size = 250
    end
    object cdsAddPedidoQTITEM: TFloatField
      FieldName = 'QTITEM'
    end
    object cdsAddPedidoVRUNITARIO: TFloatField
      FieldName = 'VRUNITARIO'
    end
    object cdsAddPedidoVRTOTAITEM: TFloatField
      FieldName = 'VRTOTAITEM'
    end
  end
  object dtsAddPedido: TDataSource
    DataSet = cdsAddPedido
    Left = 875
    Top = 222
  end
end
