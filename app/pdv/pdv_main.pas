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
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPDVMain: TfrmPDVMain;

implementation

{$R *.dfm}

uses
  lib_interface;

procedure TfrmPDVMain.FrameResize(Sender: TObject);
var
  iComp: Integer;
  Interface_: TInterface;
begin                               
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

end.
