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
      OnClick = btnGavetaClick
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
      OnClick = btnFinalizarPedidoClick
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
      Top = 88
      Width = 361
      Height = 32
      Align = alClient
      BevelOuter = bvNone
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
    object scbTotalizador: TScrollBox
      Left = 0
      Top = 0
      Width = 361
      Height = 88
      Align = alTop
      AutoSize = True
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 2
      object lblFrom: TcxLabel
        Left = 4
        Top = 5
        Caption = 'Mesa'
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
      object panTotal: TPanel
        Left = 121
        Top = 0
        Width = 236
        Height = 42
        Align = alRight
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object lblTotal: TcxLabel
          Left = 11
          Top = 7
          Caption = 'Total'
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
        object edtTotal: TcxTextEdit
          Left = 60
          Top = 7
          Hint = 'Total'
          ParentFont = False
          Properties.Alignment.Horz = taLeftJustify
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clBackground
          Style.Font.Height = -16
          Style.Font.Name = 'MS Sans Serif'
          Style.Font.Style = [fsBold]
          Style.Shadow = False
          Style.IsFontAssigned = True
          StyleDisabled.BorderColor = clActiveCaption
          StyleDisabled.Color = clSilver
          StyleDisabled.TextColor = clBtnHighlight
          StyleFocused.BorderColor = clRed
          StyleFocused.Color = clBtnHighlight
          StyleFocused.TextColor = clBackground
          StyleHot.BorderColor = clBackground
          StyleHot.Color = clSkyBlue
          StyleHot.TextColor = clHighlightText
          StyleHot.TextStyle = [fsBold]
          TabOrder = 1
          Width = 168
        end
      end
      object panDados: TPanel
        Left = 0
        Top = 42
        Width = 357
        Height = 42
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        Visible = False
        object lblCPF: TcxLabel
          Left = 6
          Top = 7
          Caption = 'CPF'
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
        object edtCPF: TcxTextEdit
          Left = 51
          Top = 7
          Hint = 'Total'
          ParentFont = False
          Properties.Alignment.Horz = taLeftJustify
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clBackground
          Style.Font.Height = -16
          Style.Font.Name = 'MS Sans Serif'
          Style.Font.Style = [fsBold]
          Style.Shadow = False
          Style.IsFontAssigned = True
          StyleDisabled.BorderColor = clActiveCaption
          StyleDisabled.Color = clSilver
          StyleDisabled.TextColor = clBtnHighlight
          StyleFocused.BorderColor = clRed
          StyleFocused.Color = clBtnHighlight
          StyleFocused.TextColor = clBackground
          StyleHot.BorderColor = clBackground
          StyleHot.Color = clSkyBlue
          StyleHot.TextColor = clHighlightText
          StyleHot.TextStyle = [fsBold]
          TabOrder = 1
          Width = 137
        end
        object edtNome: TcxTextEdit
          Left = 250
          Top = 7
          Hint = 'Total'
          ParentFont = False
          Properties.Alignment.Horz = taLeftJustify
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clBackground
          Style.Font.Height = -16
          Style.Font.Name = 'MS Sans Serif'
          Style.Font.Style = [fsBold]
          Style.Shadow = False
          Style.IsFontAssigned = True
          StyleDisabled.BorderColor = clActiveCaption
          StyleDisabled.Color = clSilver
          StyleDisabled.TextColor = clBtnHighlight
          StyleFocused.BorderColor = clRed
          StyleFocused.Color = clBtnHighlight
          StyleFocused.TextColor = clBackground
          StyleHot.BorderColor = clBackground
          StyleHot.Color = clSkyBlue
          StyleHot.TextColor = clHighlightText
          StyleHot.TextStyle = [fsBold]
          TabOrder = 2
          Width = 296
        end
        object lblNome: TcxLabel
          Left = 196
          Top = 4
          Caption = 'Nome'
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
        object btnPesqCliente: TcxButton
          Left = 327
          Top = 0
          Width = 30
          Height = 42
          Caption = '...'
          TabOrder = 4
          Align = alRight
          SpeedButtonOptions.CanBeFocused = False
          SpeedButtonOptions.Flat = True
          SpeedButtonOptions.Transparent = True
        end
      end
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
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'NMPRODUTO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'POSARVORE'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'UNIMEDIDA_ID'
        DataType = ftInteger
      end
      item
        Name = 'CDBARRA'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'IDPRODVENDA'
        DataType = ftSmallint
      end
      item
        Name = 'IDADICIONAL'
        DataType = ftSmallint
      end
      item
        Name = 'IMGINDEX'
        DataType = ftInteger
      end
      item
        Name = 'CATEGORIA_ID'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 847
    Top = 128
    Data = {
      0B0100009619E0BD0100000018000000090000000000030000000B0102494404
      0001000200010007535542545950450200490008004175746F696E6300094E4D
      50524F4455544F010049000000010005574944544802000200C80009504F5341
      52564F524501004900000001000557494454480200020028000C554E494D4544
      4944415F49440400010000000000074344424152524101004900000001000557
      494454480200020064000B494450524F4456454E444102000100000000000B49
      4441444943494F4E414C020001000000000008494D47494E4445580400010000
      0000000C43415445474F5249415F4944040001000000000001000C4155544F49
      4E4356414C55450400010001000000}
    object cdsProdutosID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object cdsProdutosNMPRODUTO: TStringField
      FieldName = 'NMPRODUTO'
      Size = 200
    end
    object cdsProdutosPOSARVORE: TStringField
      FieldName = 'POSARVORE'
      Size = 40
    end
    object cdsProdutosUNIMEDIDA_ID: TIntegerField
      FieldName = 'UNIMEDIDA_ID'
    end
    object cdsProdutosCDBARRA: TStringField
      FieldName = 'CDBARRA'
      Size = 100
    end
    object cdsProdutosIDPRODVENDA: TSmallintField
      FieldName = 'IDPRODVENDA'
    end
    object cdsProdutosIDADICIONAL: TSmallintField
      FieldName = 'IDADICIONAL'
    end
    object cdsProdutosIMGINDEX: TIntegerField
      FieldName = 'IMGINDEX'
    end
    object cdsProdutosCATEGORIA_ID: TIntegerField
      FieldName = 'CATEGORIA_ID'
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
  object DataSetProvider1: TDataSetProvider
    Left = 759
    Top = 128
  end
  object dspCategoria: TDataSetProvider
    DataSet = adqCategoria
    Left = 759
    Top = 160
  end
  object dspProdutos: TDataSetProvider
    DataSet = adqProdutos
    Left = 759
    Top = 192
  end
  object DataSetProvider4: TDataSetProvider
    Left = 759
    Top = 224
  end
  object adqCategoria: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      'SELECT id, nmcategoria, imgindex'
      '  FROM CATEGORIA')
    Left = 728
    Top = 160
  end
  object adqProdutos: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.ID, P.NMPRODUTO, P.POSARVORE, P.UNIMEDIDA_ID, P.CDBARRA' +
        ','
      '       P.IDPRODVENDA, P.IDADICIONAL, P.IMGINDEX, IC.CATEGORIA_ID'
      
        '  FROM PRODUTO P INNER JOIN ITEMCATEGORIA IC ON IC.PRODUTO_ID = ' +
        'P.ID')
    Left = 728
    Top = 192
  end
  object ADOQuery1: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.ID, P.NMPRODUTO, P.POSARVORE, P.UNIMEDIDA_ID, P.CDBARRA' +
        ','
      '       P.IDPRODVENDA, P.IDADICIONAL, P.IMGINDEX, IC.CATEGORIA_ID'
      
        '  FROM PRODUTO P INNER JOIN ITEMCATEGORIA IC ON IC.PRODUTO_ID = ' +
        'P.ID')
    Left = 728
    Top = 224
  end
  object ADOQuery2: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.ID, P.NMPRODUTO, P.POSARVORE, P.UNIMEDIDA_ID, P.CDBARRA' +
        ','
      '       P.IDPRODVENDA, P.IDADICIONAL, P.IMGINDEX, IC.CATEGORIA_ID'
      
        '  FROM PRODUTO P INNER JOIN ITEMCATEGORIA IC ON IC.PRODUTO_ID = ' +
        'P.ID')
    Left = 728
    Top = 128
  end
end
