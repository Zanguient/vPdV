unit pdv_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvPadraoFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, ADODB, DB, DBClient, StdCtrls, cxButtons,
  ExtCtrls, cxControls, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid;

type
  TfrmPDVMain = class(TvPadraoFrame)
    scbPedidos: TScrollBox;
    dbgPedidos: TcxGrid;
    dtvPedidos: TcxGridDBTableView;
    gcpMesa: TcxGridDBColumn;
    gcpStatus: TcxGridDBColumn;
    gcpValor: TcxGridDBColumn;
    dbgPedidosLevel1: TcxGridLevel;
    panLeft: TPanel;
    scbOpcoes: TScrollBox;
    btnGaveta: TcxButton;
    btnDelivery: TcxButton;
    btnBalcao: TcxButton;
    cxButton1: TcxButton;
    sbxOpcoesPDV: TScrollBox;
    cdsMesa: TClientDataSet;
    cdsMesaid_mesa: TIntegerField;
    cdsMesanmmesa: TStringField;
    cdsMesadsobsmesa: TStringField;
    cdsMesastatus: TStringField;
    cdsMesavalor: TFloatField;
    dtsMesa: TDataSource;
    procedure FrameResize(Sender: TObject);
    procedure btnGavetaClick(Sender: TObject);
    procedure dtvPedidosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OnClickOpcoesPDV(Sender: TObject);
  end;

var
  frmPDVMain: TfrmPDVMain;

implementation

{$R *.dfm}

uses
  lib_interface, lib_mensagem;

  function rStatusGaveta_DUAL_DarumaFramework(var iStatusGaveta: Integer): Integer; StdCall; External 'DarumaFrameWork.dll';
  function iAcionarGaveta_DUAL_DarumaFramework(): Integer; StdCall; External 'DarumaFrameWork.dll';

procedure TfrmPDVMain.FrameResize(Sender: TObject);
var
  iComp: Integer;
  Interface_: TInterface;
begin
  Interface_ := TInterface.Create();

  if sbxOpcoesPDV.ControlCount = 0 then
  begin
    cdsMesa.First;
    while not cdsMesa.Eof do
    begin
      Interface_.CriaButtonScrollBox(sbxOpcoesPDV, cdsMesa.FieldByName('nmmesa').AsString, OnClickOpcoesPDV, 150, 150);

      cdsMesa.Next;
    end;
  end;

  if sbxOpcoesPDV.ControlCount > 0 then
  begin
    Interface_ := TInterface.Create();
    Interface_.OrganizaScrollBox(sbxOpcoesPDV,1);
  end;

  for iComp := 0 to pred(scbOpcoes.ControlCount) do
  begin
    scbOpcoes.Controls[iComp].Width := Trunc(panLeft.Width/scbOpcoes.ControlCount);
    scbOpcoes.Controls[iComp].Left  := Trunc(panLeft.Width/scbOpcoes.ControlCount)*(iComp+1);
  end;
end;

procedure TfrmPDVMain.btnGavetaClick(Sender: TObject);
  procedure AcionaGaveta;
  var
    iRetorno: Integer;
  begin
    iRetorno := iAcionarGaveta_DUAL_DarumaFramework();
    if (iRetorno = 1) then
      Aviso(GAVETA_ACIONADA)
    else
      Erro(GAVETA_ERRO);
  end;
var
  iRetorno: Integer;
  iStatusGaveta: Integer;
begin
  inherited;
  //Permissao
  //if PodeMexer(GAVETA_SEM_PERMISSAO) then begin
    iRetorno := rStatusGaveta_DUAL_DarumaFramework(iStatusGaveta);
    if (iRetorno = 1) then
    begin
      case iStatusGaveta of
        0: AcionaGaveta;
        1: Aviso(GAVETA_ABERTA);
      else
        Aviso(GAVETA_ERRO);
      end;
    end else
      Aviso(GAVETA_ERRO);
  //end;
end;

procedure TfrmPDVMain.dtvPedidosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $9400D3
  else
    ACanvas.Brush.Color := $FFFFFF;

  ACanvas.Font.Color := clBlack;
end;

procedure TfrmPDVMain.OnClickOpcoesPDV(Sender: TObject);
begin
  //
end;

end.
