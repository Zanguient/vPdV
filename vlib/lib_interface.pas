unit lib_interface;

interface

uses
   Classes, WinInet, Dialogs, Windows, Forms,
   IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient,
   cxButtons, SysUtils, cxGraphics, Buttons, 
   Controls, ExtCtrls, StdCtrls, Messages, Menus;

type
  TInterface = Class(TPersistent)
//   private
//   protected
  public
    procedure ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);
    procedure OrganizaScrollBox(ScrollBox: TScrollBox; inTop: Integer);
    procedure CriaButtonScrollBox(ScrollBox: TScrollBox; stCaption: String; stOnClick: TNotifyEvent;
      inHeight, inWidth: Integer; intag: Integer = 0; TmpImageList: TcxImageList = Nil;
      inImagePos: Integer = 0; pum: TPopUpMenu = Nil);
//   published
end;

const
  { Panel de button }
  QTDECOLUNS_PANEL = 0; {QTDECOLUNS_PANEL for 0, pega o limite de botões possiveis}
//  BUTTON_WIDTH  = 200;
//  BUTTON_HEIGHT = 80;
//  BUTTON_TOP    = 1;

implementation

{ Interface }

{ TInterface }

procedure TInterface.ArredondarComponente(Componente: TWinControl;
  const Radius: SmallInt);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Componente do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Radius, Radius);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

procedure TInterface.CriaButtonScrollBox(ScrollBox: TScrollBox; stCaption: String;
  stOnClick: TNotifyEvent; inHeight, inWidth: Integer; intag: Integer = 0; TmpImageList: TcxImageList = Nil;
  inImagePos: Integer = 0; pum: TPopUpMenu = Nil);
var
   btn: TcxButton;
begin
   btn := TcxButton.Create(nil);
   btn.Visible := False;
   btn.Parent  := ScrollBox;
   btn.Name    := 'btn'+ScrollBox.Name+IntToStr(ScrollBox.ControlCount);
   btn.Caption := stCaption;
   btn.Height  := inHeight;
   btn.Width   := inWidth;
   btn.OnClick := stOnClick;
   btn.Visible := True;
   btn.Tag     := intag;
   btn.SpeedButtonOptions.CanBeFocused := False;
   btn.SpeedButtonOptions.Flat := True;
   btn.SpeedButtonOptions.Transparent := True;
   btn.PopupMenu := pum;

   try
     if TmpImageList <> Nil then
       TmpImageList.GetImage(inImagePos, btn.Glyph);
     btn.Layout := blGlyphTop;
   except
     //Cala a boca
   end;
   ArredondarComponente(btn,10);
end;

procedure TInterface.OrganizaScrollBox(ScrollBox: TScrollBox; inTop: Integer);
var
  iComp, iCompLinha, iCompDaLn, iPrButton: Integer;
  iRestDimen: Double;
  boMudaLinha: Boolean;
begin
   iCompDaLn := 0;
   iPrButton := 0;
   iCompLinha := (ScrollBox.Width div ScrollBox.Controls[iPrButton].Width);
   if (QTDECOLUNS_PANEL > 0) and (iCompLinha > QTDECOLUNS_PANEL) then
      iCompLinha := QTDECOLUNS_PANEL;

   iRestDimen := (ScrollBox.Width-(ScrollBox.Controls[iPrButton].Width * iCompLinha))/(iCompLinha+1);

   for iComp := 0 to pred(ScrollBox.ControlCount) do begin
      if iCompDaLn < iCompLinha then
         boMudaLinha := False
      else
         boMudaLinha := True;

      if boMudaLinha then begin
         ScrollBox.Controls[iComp].Left := Trunc(iRestDimen);
         ScrollBox.Controls[iComp].Top  := ScrollBox.Controls[iComp-1].Top+inTop+
           ScrollBox.Controls[iComp].Height;
         iCompDaLn := 0;
      end else begin
         if iComp = 0 then begin
            ScrollBox.Controls[iComp].Left := Trunc(iRestDimen);
            ScrollBox.Controls[iComp].Top  := inTop;
         end else begin
            ScrollBox.Controls[iComp].Left := ScrollBox.Controls[iComp-1].Left+ScrollBox.Controls[iComp].width+Trunc(iRestDimen);
            ScrollBox.Controls[iComp].Top  := ScrollBox.Controls[iComp-1].Top;
         end;
      end;
      inc(iCompDaLn);
   end;
end;

end.
