unit lib_interface;

interface

uses
   Classes, WinInet, Dialogs, Windows, Forms,
   IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient,
   cxButtons, SysUtils;

type
  TInterface = Class(TPersistent)
//   private
//   protected
  public
    procedure OrganizaScrollBox(ScrollBox: TScrollBox; inTop: Integer);
    procedure CriaButtonScrollBox(ScrollBox: TScrollBox; stCaption: String; stOnClick: TNotifyEvent;
      inHeight, inWidth: Integer);
//   published
end;    

const
  { Panel de button }
  QTDECOLUNS_PANEL = 0; {QTDECOLUNS_PANEL for 0, pega o limite de botões possiveis}
//  BUTTON_WIDTH  = 200;
//  BUTTON_HEIGHT = 80;
//  BUTTON_TOP    = 1;

implementation

uses Controls;

{ Interface }

{ TInterface }

procedure TInterface.CriaButtonScrollBox(ScrollBox: TScrollBox; stCaption: String;
  stOnClick: TNotifyEvent; inHeight, inWidth: Integer);
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
