unit libframes;

interface
 uses SysUtils, Variants, Classes, ComCtrls, forms, controls, StdCtrls,
  cxGraphics, cxControls, cxLookAndFeels, ExtCtrls, cxButtons,
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

 type
    TParamFrame = class of TFrame;
    TAbas = class(TPersistent)
     protected
     private
        FNomeLabelPadrao : String;
        FClassFrame : TParamFrame;
        FPageControl : TcxPageControl;
        function AbaJaCriada(var TabIndex: Integer): Boolean;
        function GetTituloAba(Frame: TFrame): String;
        function CriarAba(onwner : TcxPageControl) : TcxTabSheet;
     public
        property NomeLabelPadrao : String read FNomeLabelPadrao;
        procedure Criar();
        constructor Create(PageControl : TcxPageControl; Frame : TParamFrame);
     end;

     TAbasNavegacao = class
     public
         class procedure CriarAba(PageControl : TcxPageControl; Frame : TParamFrame; 
            NomeLabelCaption : String = 'lblNomeFrame');
     end;

implementation

{ TAbas }

function TAbas.AbaJaCriada(var TabIndex: Integer): Boolean;
var
   titulo: string;
   frame: TFrame;
   lbl: TComponent;
   i: Integer;
begin
  Result:= False;
  TabIndex:= -1;
  frame := FClassFrame.create(nil);
  try
    titulo:= GetTituloAba(frame);
    for i:= 0 to FPageControl.ComponentCount - 1 do
    begin
      if FPageControl.Components[i].ClassType = TcxTabSheet then
      begin
        if (FPageControl.Components[i] as TcxTabSheet).Caption = titulo then
        begin
          Result:= True;
          TabIndex:= (FPageControl.Components[i] as TcxTabSheet).TabIndex;
          Break;
        end;
      end;
    end;
  finally
    FreeAndNil(frame);
  end;
end;

constructor TAbas.Create(PageControl : TcxPageControl; Frame: TParamFrame);
begin
   inherited create;
   FNomeLabelPadrao := 'lblNomeFrame';
   FClassFrame := Frame;
   FPageControl := PageControl;
end;

procedure TAbas.Criar;
var
   tab : TcxTabSheet;
   frame : TFrame;
   labelCaption : TComponent;
   titulo: String;
   tabIndex: Integer;
begin
  if not AbaJaCriada(tabIndex) then
  begin
    tab := CriarAba(FPageControl);
    frame := FClassFrame.create(tab);
    frame.Parent := tab;
    frame.Align := alClient;
    titulo := GetTituloAba(Frame);
    tab.Caption:= titulo;
  end
  else
    FPageControl.ActivePageIndex:= tabIndex;

end;

function TAbas.CriarAba(onwner: TcxPageControl): TcxTabSheet;
var
  tab : TcxTabSheet;
begin
  if(onwner = nil) then
  begin
    raise Exception.Create('Passe a PageControl para o método CriarAba.');
    Abort;
  end
  else
  begin
    tab := TcxTabSheet.Create(onwner);
    tab.PageControl := onwner;
    onwner.ActivePage := tab;
    Result := tab;
  end;
end;

function TAbas.GetTituloAba(Frame: TFrame): String;
var
   labelCaption: TComponent;
begin
  Result:= FNomeLabelPadrao;
  labelCaption := frame.FindComponent(FNomeLabelPadrao);
  if(labelCaption <> nil) then
  begin
    if labelCaption.ClassName = 'TLabel' then
      Result := (labelCaption as Tlabel).Caption;
  end;
end;

{ TAbasNavegacao }

class procedure TAbasNavegacao.CriarAba(PageControl: TcxPageControl; Frame: TParamFrame; NomeLabelCaption: String);
var
  aba : TAbas;
begin
  try
    aba := TAbas.Create(PageControl, Frame);
    aba.FNomeLabelPadrao := NomeLabelCaption;
    aba.Criar;
  finally
    FreeAndNil(aba);
  end;
end;

end.
