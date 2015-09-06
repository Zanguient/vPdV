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
  KeyPreview = True
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
      OnClick = btnGravarClick
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
      object gdbAddPedido: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dtsAddPedido
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        object gdbAddPedidoColumn1: TcxGridDBColumn
          Caption = 'Adicional'
          DataBinding.FieldName = 'NMPRODUTO'
          Width = 264
        end
        object gdbAddPedidoColumn2: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTITEM'
          Width = 89
        end
        object gdbAddPedidoColumn3: TcxGridDBColumn
          Caption = 'Valor Unit'#225'rio'
          DataBinding.FieldName = 'VRUNITARIO'
          Width = 101
        end
        object gdbAddPedidoColumn4: TcxGridDBColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'VRTOTAITEM'
          Width = 100
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
        GridView = gdbAddPedido
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
        OnCellClick = gdbPedidoCellClick
        OnCellDblClick = gdbPedidoCellDblClick
        DataController.DataSource = dtsItemPedido
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellAutoHeight = True
        OptionsView.GroupByBox = False
        object gdbNmProduto: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'NMPRODUTO'
          Width = 240
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
          Width = 100
        end
        object gdbExcluir: TcxGridDBColumn
          DataBinding.FieldName = 'IMG'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.ButtonGlyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000006464
            677F1F21457F2627447F6F6F707F00000000000000007777777F000000000000
            0000000000006A6A707F2123437F2426467F6B6B6D7F000000006969717F363A
            88E9191E82FF191F83FF464991E97272767F0000000000000000000000000000
            00006D6D747F3A3D8AE9191E82FF191E82FF40458FE96F6F757F20234D7F191E
            86FF191F86FF191F86FF191E86FF474C96E97272767F00000000000000006D6D
            747F383C8BE9191E86FF191F86FF191F86FF181E86FF2B2D527F2527527F181E
            8DFF191F8DFF191F8DFF191F8DFF191F8DFF464A99E97575787F6E6F757F3A3E
            91E9181E8DFF191F8DFF191F8DFF191F8DFF191F8DFF2F31567F6D6D747F3B40
            97E91A1F92FF1A2093FF1A1F93FF1A1F93FF1A1F92FF4C50AAFF4146A4FF1A1F
            92FF1A2093FF1A1F93FF1A1F93FF1A1F93FF484D9CE97172767F000000006D6E
            757F3C419BE9192099FF1A2099FF1A2099FF1A2099FF1A2099FF1A2099FF1A20
            99FF1A2099FF1A2099FF1A2099FF484DA0E97373777F00000000000000000000
            00006D6E757F3B40A0E919209FFF1A209FFF1A209FFF1A209FFF1A209FFF1A20
            9FFF1A209FFF1A209FFF494EA5E97373777F0000000000000000000000000000
            0000000000007071777F464BB5FF1A21A5FF1A21A5FF1A21A5FF1A21A5FF1A21
            A5FF1A21A5FF5359BAFF7575787F000000000000000000000000000000000000
            0000000000006F6F767F444AB9FF1B21ABFF1B21ABFF1B21ABFF1B21ABFF1B21
            ABFF1B21ABFF5257BEFF7474787F000000000000000000000000000000000000
            00006D6D767F3A3FADE91A21B1FF1B22B1FF1B22B1FF1A21B1FF1A21B1FF1B22
            B1FF1B22B1FF1B22B1FF484DB1E97272787F0000000000000000000000006D6D
            777F3B40B1E91A21B8FF1B22B8FF1B22B8FF1A20B7FF1F27BBFF1F27BBFF1A20
            B7FF1B22B8FF1B22B8FF1B22B8FF474DB5E97273787F000000006C6D777F3A3F
            B6E91B22BEFF1B23BEFF1B23BEFF1A21BDFF1F28C1FF5861D1FF4C56CEFF1F28
            C1FF1A21BDFF1B23BEFF1B23BEFF1B22BEFF4248B9E97373787F2527677F1B22
            C4FF1C23C4FF1C23C4FF1B21C3FF2028C7FF565EC5E97676797F6E6E777F454E
            C0E92028C7FF1B21C3FF1C23C4FF1C23C4FF1920C3FF34376A7F282D6C7F1D25
            CBFF1B22C9FF1B21C9FF1F27CCFF555CC8E97373797F00000000000000006C6C
            777F454DC4E92028CCFF1B21C9FF1B21C9FF2028CCFF30346D7F6A6B777F424C
            C8E91F28D2FF212BD2FF535CCBE97373797F0000000000000000000000000000
            00006C6C777F454EC8E9212BD2FF212BD2FF4D55C9E96F70787F000000006A6B
            787F2D31717F3438727F7373797F000000000000000000000000000000000000
            0000000000006C6C787F2F33717F3135717F6F70787F00000000}
          Properties.DefaultImageIndex = 0
          Properties.Images = cilPDV_16
          Properties.Items = <
            item
              ImageIndex = 8
            end>
          Width = 23
          IsCaptionAssigned = True
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
  object cdsItemCategoria: TClientDataSet
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
      end
      item
        Name = 'VRVENDA'
        DataType = ftFloat
      end
      item
        Name = 'QTVENDA'
        DataType = ftFloat
      end
      item
        Name = 'QTADICGRATIS'
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
    Left = 847
    Top = 128
    Data = {
      5E0100009619E0BD01000000180000000D0000000000030000005E0102494404
      0001000200010007535542545950450200490008004175746F696E6300094E4D
      50524F4455544F010049000000010005574944544802000200C80009504F5341
      52564F524501004900000001000557494454480200020028000C554E494D4544
      4944415F49440400010000000000074344424152524101004900000001000557
      494454480200020064000B494450524F4456454E444102000100000000000B49
      4441444943494F4E414C020001000000000008494D47494E4445580400010000
      0000000C43415445474F5249415F4944040001000000000007565256454E4441
      080004000000000007515456454E444108000400000000000C51544144494347
      524154495304000100000000000949445449504F4D4544010049000000010005
      574944544802000200010001000C4155544F494E4356414C5545040001000100
      0000}
    object cdsItemCategoriaID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object cdsItemCategoriaNMPRODUTO: TStringField
      FieldName = 'NMPRODUTO'
      Size = 200
    end
    object cdsItemCategoriaPOSARVORE: TStringField
      FieldName = 'POSARVORE'
      Size = 40
    end
    object cdsItemCategoriaUNIMEDIDA_ID: TIntegerField
      FieldName = 'UNIMEDIDA_ID'
    end
    object cdsItemCategoriaCDBARRA: TStringField
      FieldName = 'CDBARRA'
      Size = 100
    end
    object cdsItemCategoriaIDPRODVENDA: TSmallintField
      FieldName = 'IDPRODVENDA'
    end
    object cdsItemCategoriaIDADICIONAL: TSmallintField
      FieldName = 'IDADICIONAL'
    end
    object cdsItemCategoriaIMGINDEX: TIntegerField
      FieldName = 'IMGINDEX'
    end
    object cdsItemCategoriaCATEGORIA_ID: TIntegerField
      FieldName = 'CATEGORIA_ID'
    end
    object cdsItemCategoriaVRVENDA: TFloatField
      FieldName = 'VRVENDA'
    end
    object cdsItemCategoriaQTVENDA: TFloatField
      FieldName = 'QTVENDA'
    end
    object cdsItemCategoriaQTADICGRATIS: TIntegerField
      FieldName = 'QTADICGRATIS'
    end
    object cdsItemCategoriaIDTIPOMED: TStringField
      FieldName = 'IDTIPOMED'
      Size = 1
    end
  end
  object dtsItemCategoria: TDataSource
    DataSet = cdsItemCategoria
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
    AggregatesActive = True
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
      end
      item
        Name = 'PRODUTO_ID'
        DataType = ftInteger
      end
      item
        Name = 'IMG'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterPost = cdsItemPedidoAfterPost
    AfterScroll = cdsItemPedidoAfterScroll
    Left = 847
    Top = 190
    Data = {
      DB0000009619E0BD01000000180000000B000000000003000000DB0002494404
      000100000000000950454449444F5F494404000100000000000B434152444150
      494F5F49440400010000000000074C4F54455F49440400010000000000065154
      4954454D080004000000000007565256454E4441080004000000000007565254
      4F54414C08000400000000000B494441444943494F4E414C0400010000000000
      094E4D50524F4455544F010049000000010005574944544802000200FA000A50
      524F4455544F5F4944040001000000000003494D4704000100000000000000}
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
    object cdsItemPedidoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
    end
    object cdsItemPedidoIMG: TIntegerField
      FieldName = 'IMG'
    end
    object cdsItemPedidoSUMVRTOTAL: TAggregateField
      FieldName = 'SUMVRTOTAL'
      Active = True
      Expression = 'SUM(VRTOTAL)'
    end
    object cdsItemPedidoMAXID: TAggregateField
      FieldName = 'MAXID'
      Active = True
      Expression = 'MAX(ID)'
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
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'NMPRODUTO'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'QTITEM'
        DataType = ftFloat
      end
      item
        Name = 'VRUNITARIO'
        DataType = ftFloat
      end
      item
        Name = 'VRTOTAITEM'
        DataType = ftFloat
      end
      item
        Name = 'PRODUTO_ID'
        DataType = ftInteger
      end
      item
        Name = 'IMG'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 847
    Top = 222
    Data = {
      970000009619E0BD010000001800000007000000000003000000970002696404
      00010000000000094E4D50524F4455544F010049000000010005574944544802
      000200FA000651544954454D08000400000000000A5652554E49544152494F08
      000400000000000A5652544F54414954454D08000400000000000A50524F4455
      544F5F4944040001000000000003494D4704000100000000000000}
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
    object cdsAddPedidoPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
    end
    object cdsAddPedidoIMG: TIntegerField
      FieldName = 'IMG'
    end
    object cdsAddPedidoSUMVRTOTAL: TAggregateField
      FieldName = 'SUMVRTOTAL'
      Active = True
      Expression = 'SUM(VRTOTAITEM)'
    end
    object cdsAddPedidoMAXID: TAggregateField
      FieldName = 'MAXID'
      Active = True
      Expression = 'MAX(ID)'
    end
  end
  object dtsAddPedido: TDataSource
    DataSet = cdsAddPedido
    Left = 875
    Top = 222
  end
  object dspAgrupAdicional: TDataSetProvider
    DataSet = adqAgrupAdicional
    Left = 759
    Top = 256
  end
  object dspCategoria: TDataSetProvider
    DataSet = adqCategoria
    Left = 759
    Top = 128
  end
  object dspItemCategoria: TDataSetProvider
    DataSet = adqItemCategoria
    Left = 759
    Top = 160
  end
  object dspItAgrupAdicional: TDataSetProvider
    DataSet = adqItAgrupAdicional
    Left = 839
    Top = 270
  end
  object adqCategoria: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      'SELECT id, nmcategoria, imgindex'
      '  FROM CATEGORIA'
      ' WHERE IDCATEGORIATIV = '#39'S'#39)
    Left = 728
    Top = 128
  end
  object adqItemCategoria: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.ID, P.NMPRODUTO, P.POSARVORE, P.UNIMEDIDA_ID, P.CDBARRA' +
        ','
      
        '       P.IDPRODVENDA, P.IDADICIONAL, P.IMGINDEX, IC.CATEGORIA_ID' +
        ','
      '       IC.VRVENDA, IC.QTVENDA, IC.QTADICGRATIS, U.IDTIPOMED'
      
        '  FROM PRODUTO P INNER JOIN ITEMCATEGORIA IC ON IC.PRODUTO_ID = ' +
        'P.ID'
      '                 INNER JOIN UNIMEDIDA U ON U.ID = P.UNIMEDIDA_ID'
      ' WHERE P.IDADICIONAL = 0')
    Left = 728
    Top = 160
  end
  object adqItAgrupAdicional: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.ID, P.NMPRODUTO, P.POSARVORE, P.UNIMEDIDA_ID, P.CDBARRA' +
        ','
      '       P.IDPRODVENDA, P.IDADICIONAL, P.IMGINDEX, IC.CATEGORIA_ID'
      
        '  FROM PRODUTO P INNER JOIN ITEMCATEGORIA IC ON IC.PRODUTO_ID = ' +
        'P.ID')
    Left = 808
    Top = 270
  end
  object adqAgrupAdicional: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      'SELECT AA.ID, AA.NMAGRUPADIC, AA.VRAGRUPADIC'
      
        '  FROM ITEMCATEGORIA IC INNER JOIN ITAGRUPADICIONAL IA ON IC.ID ' +
        '= IA.CARDAPIO_ID'
      
        '                        INNER JOIN AGRUPADICIONAL   AA ON AA.ID ' +
        '= IA.AGRUPADICIONAL_ID'
      ' WHERE AA.IDAGRUPATIV = '#39'S'#39)
    Left = 728
    Top = 256
  end
  object adqVerifAdicional: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <
      item
        Name = 'P_PRODUTO'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT AA.ID'
      
        '  FROM ITEMCATEGORIA IC INNER JOIN ITAGRUPADICIONAL IA ON IC.ID ' +
        '= IA.CARDAPIO_ID'
      
        '                        INNER JOIN AGRUPADICIONAL   AA ON AA.ID ' +
        '= IA.AGRUPADICIONAL_ID'
      ' WHERE AA.IDAGRUPATIV = '#39'S'#39
      '   AND IA.CARDAPIO_ID = :P_PRODUTO'
      '')
    Left = 648
    Top = 224
    object adqVerifAdicionalID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
  end
  object cdsAgrupAdicional: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'NMAGRUPADIC'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'VRAGRUPADIC'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 728
    Top = 286
    Data = {
      840000009619E0BD010000001800000003000000000003000000840002494404
      0001000200010007535542545950450200490008004175746F696E63000B4E4D
      414752555041444943010049000000010005574944544802000200FA000B5652
      414752555041444943080004000000000001000C4155544F494E4356414C5545
      0400010001000000}
    object cdsAgrupAdicionalID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object cdsAgrupAdicionalNMAGRUPADIC: TStringField
      FieldName = 'NMAGRUPADIC'
      Size = 250
    end
    object cdsAgrupAdicionalVRAGRUPADIC: TFloatField
      FieldName = 'VRAGRUPADIC'
    end
  end
  object dtsAgrupAdicional: TDataSource
    DataSet = cdsAgrupAdicional
    Left = 759
    Top = 286
  end
  object cilPDV_16: TcxImageList
    DrawingStyle = dsTransparent
    FormatVersion = 1
    DesignInfo = 11010696
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000006464
          677F1F21457F2627447F6F6F707F00000000000000007777777F000000000000
          0000000000006A6A707F2123437F2426467F6B6B6D7F000000006969717F363A
          88E9191E82FF191F83FF464991E97272767F0000000000000000000000000000
          00006D6D747F3A3D8AE9191E82FF191E82FF40458FE96F6F757F20234D7F191E
          86FF191F86FF191F86FF191E86FF474C96E97272767F00000000000000006D6D
          747F383C8BE9191E86FF191F86FF191F86FF181E86FF2B2D527F2527527F181E
          8DFF191F8DFF191F8DFF191F8DFF191F8DFF464A99E97575787F6E6F757F3A3E
          91E9181E8DFF191F8DFF191F8DFF191F8DFF191F8DFF2F31567F6D6D747F3B40
          97E91A1F92FF1A2093FF1A1F93FF1A1F93FF1A1F92FF4C50AAFF4146A4FF1A1F
          92FF1A2093FF1A1F93FF1A1F93FF1A1F93FF484D9CE97172767F000000006D6E
          757F3C419BE9192099FF1A2099FF1A2099FF1A2099FF1A2099FF1A2099FF1A20
          99FF1A2099FF1A2099FF1A2099FF484DA0E97373777F00000000000000000000
          00006D6E757F3B40A0E919209FFF1A209FFF1A209FFF1A209FFF1A209FFF1A20
          9FFF1A209FFF1A209FFF494EA5E97373777F0000000000000000000000000000
          0000000000007071777F464BB5FF1A21A5FF1A21A5FF1A21A5FF1A21A5FF1A21
          A5FF1A21A5FF5359BAFF7575787F000000000000000000000000000000000000
          0000000000006F6F767F444AB9FF1B21ABFF1B21ABFF1B21ABFF1B21ABFF1B21
          ABFF1B21ABFF5257BEFF7474787F000000000000000000000000000000000000
          00006D6D767F3A3FADE91A21B1FF1B22B1FF1B22B1FF1A21B1FF1A21B1FF1B22
          B1FF1B22B1FF1B22B1FF484DB1E97272787F0000000000000000000000006D6D
          777F3B40B1E91A21B8FF1B22B8FF1B22B8FF1A20B7FF1F27BBFF1F27BBFF1A20
          B7FF1B22B8FF1B22B8FF1B22B8FF474DB5E97273787F000000006C6D777F3A3F
          B6E91B22BEFF1B23BEFF1B23BEFF1A21BDFF1F28C1FF5861D1FF4C56CEFF1F28
          C1FF1A21BDFF1B23BEFF1B23BEFF1B22BEFF4248B9E97373787F2527677F1B22
          C4FF1C23C4FF1C23C4FF1B21C3FF2028C7FF565EC5E97676797F6E6E777F454E
          C0E92028C7FF1B21C3FF1C23C4FF1C23C4FF1920C3FF34376A7F282D6C7F1D25
          CBFF1B22C9FF1B21C9FF1F27CCFF555CC8E97373797F00000000000000006C6C
          777F454DC4E92028CCFF1B21C9FF1B21C9FF2028CCFF30346D7F6A6B777F424C
          C8E91F28D2FF212BD2FF535CCBE97373797F0000000000000000000000000000
          00006C6C777F454EC8E9212BD2FF212BD2FF4D55C9E96F70787F000000006A6B
          787F2D31717F3438727F7373797F000000000000000000000000000000000000
          0000000000006C6C787F2F33717F3135717F6F70787F00000000}
      end>
  end
  object adqInsPedido: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <
      item
        Name = 'P_IDTIPOPEDIDO'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'P_CLIENTE_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'P_NMCLIENTE'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'P_MESA_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'P_VRPEDIDO'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'P_IDSTATUSPED'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO PEDIDO'
      '  (IDTIPOPEDIDO, CLIENTE_ID, NMCLIENTE,'
      '   MESA_ID, VRPEDIDO, IDSTATUSPED)'
      ' VALUES'
      '  (:P_IDTIPOPEDIDO, :P_CLIENTE_ID, :P_NMCLIENTE,'
      '   :P_MESA_ID, :P_VRPEDIDO, :P_IDSTATUSPED)')
    Left = 808
    Top = 344
  end
  object adqInsItemPedido: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <
      item
        Name = 'P_EMPRESA_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'P_PEDIDO_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'P_CARDAPIO_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'P_LOTE_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'P_QTITEM'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'P_VRVENDA'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'P_VRTOTAL'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'P_IDADICIONAL'
        DataType = ftBoolean
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO ITEMPEDIDO'
      '  (EMPRESA_ID, DTCADASTRO, PEDIDO_ID, CARDAPIO_ID,'
      '   LOTE_ID, QTITEM, VRVENDA, VRTOTAL, IDADICIONAL)'
      'VALUES'
      '  (:P_EMPRESA_ID, NOW(), :P_PEDIDO_ID, :P_CARDAPIO_ID,'
      
        '   :P_LOTE_ID, :P_QTITEM, :P_VRVENDA, :P_VRTOTAL, :P_IDADICIONAL' +
        ')')
    Left = 840
    Top = 344
  end
  object adqInsAdicionalPedido: TADOQuery
    Connection = dmConexao.adoConexaoBd
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.ID, P.NMPRODUTO, P.POSARVORE, P.UNIMEDIDA_ID, P.CDBARRA' +
        ','
      
        '       P.IDPRODVENDA, P.IDADICIONAL, P.IMGINDEX, IC.CATEGORIA_ID' +
        ','
      '       IC.VRVENDA, IC.QTVENDA, IC.QTADICGRATIS, U.IDTIPOMED'
      
        '  FROM PRODUTO P INNER JOIN ITEMCATEGORIA IC ON IC.PRODUTO_ID = ' +
        'P.ID'
      '                 INNER JOIN UNIMEDIDA U ON U.ID = P.UNIMEDIDA_ID'
      ' WHERE P.IDADICIONAL = 0')
    Left = 872
    Top = 344
  end
end
