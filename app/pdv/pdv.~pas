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
  cxGridDBTableView, cxGrid, ImgList;

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
    procedure CriaButtonPanel(ScrollBox: TScrollBox; stCaption, stOnClick: String);
    procedure OrganizaPanel(ScrollBox: TScrollBox);
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

procedure TfrmPDV.CriaButtonPanel(ScrollBox: TScrollBox; stCaption,
  stOnClick: String);
var
   btn: TcxButton;
begin
   btn := TcxButton.Create(nil);
   btn.Visible := False;
   btn.Parent  := ScrollBox;
   btn.Name    := 'btn'+ScrollBox.Name+IntToStr(ScrollBox.ControlCount);
   btn.Caption := stCaption;
   btn.Height  := BUTTON_HEIGHT;
   btn.Width   := BUTTON_WIDTH;
//   btn.OnClick := stOnClick;
   btn.Visible := True;
end;

procedure TfrmPDV.OrganizaPanel(ScrollBox: TScrollBox);
var
  iComp, iCompLinha, iCompDaLn: Integer;
  iRestDimen: Double;
  boMudaLinha: Boolean;
begin
   iCompDaLn := 0;
   iCompLinha := (ScrollBox.Width div BUTTON_WIDTH);
   if (QTDECOLUNS_PANEL > 0) and (iCompLinha > QTDECOLUNS_PANEL) then
      iCompLinha := QTDECOLUNS_PANEL;

   iRestDimen := (ScrollBox.Width-(BUTTON_WIDTH * iCompLinha))/(iCompLinha+1);

   for iComp := 0 to pred(ScrollBox.ControlCount) do begin
      if iCompDaLn < iCompLinha then
         boMudaLinha := False
      else
         boMudaLinha := True;

      if boMudaLinha then begin
         ScrollBox.Controls[iComp].Left := Trunc(iRestDimen);
         ScrollBox.Controls[iComp].Top  := ScrollBox.Controls[iComp-1].Top+BUTTON_TOP+BUTTON_HEIGHT;
         iCompDaLn := 0;
      end else begin
         if iComp = 0 then begin
            ScrollBox.Controls[iComp].Left := Trunc(iRestDimen);
            ScrollBox.Controls[iComp].Top  := BUTTON_TOP;
         end else begin
            ScrollBox.Controls[iComp].Left := ScrollBox.Controls[iComp-1].Left+BUTTON_WIDTH+Trunc(iRestDimen);
            ScrollBox.Controls[iComp].Top  := ScrollBox.Controls[iComp-1].Top;
         end;
      end;
      inc(iCompDaLn);
   end;
end;

constructor TfrmPDV.Create(AOwner: TComponent);
begin
  inherited; 
   OrganizaPanel(sbxOpcoesPDV);
end;

initialization
   RegisterClass(TfrmPDV);
        
end.

