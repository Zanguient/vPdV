unit lib_interface;

interface

uses
   Classes, WinInet, Dialogs, Windows, Forms,
   IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient,
   
  cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxNavBar2Painter, dxNavBarCollns, cxClasses,
  dxNavBarBase, dxNavBar, dxSkinscxPCPainter, cxPC, ImgList, dxSkinsForm;


{  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;
}
type
  TInterface = Class(TPersistent)
{    Button1: TButton;
    Button2: TButton;
    ScrollBox: TScrollBox;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);}
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CriaButtonPanel(ScrollBox: TScrollBox; stCaption, stOnClick: String);
    procedure OrganizaPanel(ScrollBox: TScrollBox);
  end;

var
  cPan :Integer;

const
  { Panel de button }
  QTDECOLUNS_PANEL = 3; {QTDECOLUNS_PANEL for 0, pega o limite de botões possiveis}
  BUTTON_WIDTH  = 75;
  BUTTON_HEIGHT = 50;
  BUTTON_TOP    = 10;

implementation

{$R *.dfm}

{procedure TInterface.Button1Click(Sender: TObject);
begin
   CriaButtonPanel(ScrollBox, 'Teste', '');
end; }

procedure TInterface.CriaButtonPanel(ScrollBox: TScrollBox; stCaption, stOnClick: String);
var
   btn: TcxButton;
begin
   btn := TButton.Create(nil);
   btn.Visible := False;
   btn.Parent  := ScrollBox;
   btn.Name    := 'btn'+ScrollBox.Name+IntToStr(ScrollBox.ControlCount);
   btn.Caption := stCaption;
   btn.Height  := BUTTON_HEIGHT;
   btn.Width   := BUTTON_WIDTH;
//   btn.OnClick := stOnClick;
   btn.Visible := True;
end;

procedure TInterface.OrganizaPanel(ScrollBox: TScrollBox); 
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

{procedure TInterface.Button2Click(Sender: TObject);
begin
   OrganizaPanel(ScrollBox);
end;   }

end.
