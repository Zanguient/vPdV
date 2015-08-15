unit pdv;

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
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ImgList, lib_interface;

type
  TfrmPDV = class(TFrame)
    sbxOpcoesPDV: TScrollBox;
    ScrollBox2: TScrollBox;
    btnFechar: TcxButton;
    cxButton4: TcxButton;
    cxButton5: TcxButton;
    btnGaveta: TcxButton;
    scbBalcDeliv: TScrollBox;
    btnDelivery: TcxButton;
    btnBalcao: TcxButton;
    ScrollBox1: TScrollBox;
    dtvPedidos: TcxGridDBTableView;
    dbgPedidosLevel1: TcxGridLevel;
    dbgPedidos: TcxGrid;
    gcpMesa: TcxGridDBColumn;
    gcpStatus: TcxGridDBColumn;
    gcpValor: TcxGridDBColumn;
    cxButton9: TcxButton;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    cxButton6: TcxButton;
    cxButton12: TcxButton;
    cxButton13: TcxButton;
    cxButton14: TcxButton;
    cxButton15: TcxButton;
    cxButton16: TcxButton;
    cxButton17: TcxButton;
    cxButton18: TcxButton;
    cxButton7: TcxButton;
    cxButton8: TcxButton;
    cxButton10: TcxButton;
    cxButton11: TcxButton;
    cxButton19: TcxButton;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;  

var
  cPan :Integer;

const
  { Panel de button }
  QTDECOLUNS_PANEL = 0; {QTDECOLUNS_PANEL for 0, pega o limite de botões possiveis}
  BUTTON_WIDTH  = 200;
  BUTTON_HEIGHT = 80;
  BUTTON_TOP    = 1;

implementation

{$R *.dfm}

{uses
   lib_interface; }


{ TfrmPDV }

constructor TfrmPDV.Create(AOwner: TComponent);
begin
  inherited;

end;

initialization
   RegisterClass(TfrmPDV);
        
end.

