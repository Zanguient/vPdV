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
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        object dbgAdicionalDBTableView1Column1: TcxGridDBColumn
          Caption = 'Coluna 1'
        end
        object dbgAdicionalDBTableView1Column2: TcxGridDBColumn
          Caption = 'Coluna 2'
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
      object dbgAdicionalLevel2: TcxGridLevel
        GridView = dbgAdicionalDBBandedTableView1
      end
      object dbgAdicionalLevel3: TcxGridLevel
      end
    end
    object dbgProduto: TcxGrid
      Left = 0
      Top = 0
      Width = 559
      Height = 203
      Align = alClient
      TabOrder = 1
      object una: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        object unaColumn1: TcxGridDBColumn
        end
        object unaColumn2: TcxGridDBColumn
        end
        object unateste: TcxGridDBColumn
          DataBinding.FieldName = 'teste'
        end
        object unateste2: TcxGridDBColumn
          DataBinding.FieldName = 'teste2'
          PropertiesClassName = 'TcxProgressBarProperties'
        end
      end
      object dbgProdutoChartView1: TcxGridChartView
        DiagramColumn.Active = True
      end
      object dbgProdutoLevel1: TcxGridLevel
        GridView = una
      end
    end
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 847
    Top = 128
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 875
    Top = 128
  end
  object cdsCategoria: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 847
    Top = 159
  end
  object dtsCategoria: TDataSource
    DataSet = cdsCategoria
    Left = 875
    Top = 159
  end
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 847
    Top = 190
  end
  object dtsPedido: TDataSource
    DataSet = cdsPedido
    Left = 875
    Top = 190
  end
end
