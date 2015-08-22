unit pdv_pdv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, ExtCtrls, cxControls, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxProgressBar,
  cxGridChartView, cxGridLevel, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DBClient;

type
  TfrmPDV_PDV = class(TForm)
    scbMenu: TScrollBox;
    btnGaveta: TcxButton;
    btnFinalizarPedido: TcxButton;
    btnGravar: TcxButton;
    btnCancelar: TcxButton;
    scbGrupo: TScrollBox;
    scbCategoria: TScrollBox;
    scbProduto: TScrollBox;
    panGrids: TPanel;
    dbgAdicional: TcxGrid;
    dbgAdicionalDBTableView1: TcxGridDBTableView;
    dbgAdicionalDBTableView1Column1: TcxGridDBColumn;
    dbgAdicionalDBTableView1Column2: TcxGridDBColumn;
    dbgAdicionalDBBandedTableView1: TcxGridDBBandedTableView;
    dbgAdicionalDBBandedTableView1Column1: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column2: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column3: TcxGridDBBandedColumn;
    dbgAdicionalDBBandedTableView1Column4: TcxGridDBBandedColumn;
    dbgAdicionalLevel1: TcxGridLevel;
    dbgAdicionalLevel2: TcxGridLevel;
    dbgAdicionalLevel3: TcxGridLevel;
    dbgProduto: TcxGrid;
    una: TcxGridDBTableView;
    unaColumn1: TcxGridDBColumn;
    unaColumn2: TcxGridDBColumn;
    unateste: TcxGridDBColumn;
    unateste2: TcxGridDBColumn;
    dbgProdutoChartView1: TcxGridChartView;
    dbgProdutoLevel1: TcxGridLevel;
    cdsProdutos: TClientDataSet;
    dtsProdutos: TDataSource;
    cdsCategoria: TClientDataSet;
    dtsCategoria: TDataSource;
    cdsPedido: TClientDataSet;
    dtsPedido: TDataSource;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPDV_PDV: TfrmPDV_PDV;

implementation

{$R *.dfm}   

uses
  lib_mensagem;

procedure TfrmPDV_PDV.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPDV_PDV.FormShow(Sender: TObject);
begin
  Caption := IntToStr(frmPDV_PDV.tag);
end;

procedure TfrmPDV_PDV.FormCreate(Sender: TObject);
var
   region: hrgn;
   iComp: Integer;
begin
  Height := Screen.WorkAreaHeight-20;
  Width  := Screen.WorkAreaWidth-20;
  Position := poScreenCenter;

  DoubleBuffered := True;
  region := CreateRoundRectRgn(0, 0, width, height, 15, 15);
  SetWindowRgn(handle, region, true);

  for iComp := 0 to pred(scbMenu.ControlCount) do
  begin
    scbMenu.Controls[iComp].Width := Trunc(scbMenu.Width/scbMenu.ControlCount);
    scbMenu.Controls[iComp].Left  := Trunc(scbMenu.Width/scbMenu.ControlCount)*(iComp+1);
  end;

  scbProduto.Width := Trunc(scbGrupo.Width/2);
end;

end.
