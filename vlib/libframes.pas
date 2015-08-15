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
        function CriarAba(onwner : TcxPageControl) : TcxTabSheet;
     public
        property NomeLabelPadrao : String read FNomeLabelPadrao write FNomeLabelPadrao;
        procedure Criar();
        constructor Create(PageControl : TcxPageControl; Frame : TParamFrame);
     end;

     TAbasNavegacao = class
     public
         class procedure CriarAba(PageControl : TcxPageControl; Frame : TParamFrame; const
            NomeLabelCaption : String = 'lblNomeFrame');
     end;

implementation

{ TAbas }

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
begin
   tab := CriarAba(FPageControl);
   frame := FClassFrame.create(tab);
   frame.Parent := tab;
   frame.Align := alClient;
   labelCaption := frame.FindComponent(FNomeLabelPadrao);
   if(labelCaption <> nil) then begin
      if labelCaption.ClassName = 'TLabel' then
         tab.Caption := (labelCaption as Tlabel).Caption;
   end else
      tab.Caption := FNomeLabelPadrao;
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
    Result := tab;
  end;
end;

{ TAbasNavegacao }

class procedure TAbasNavegacao.CriarAba(PageControl: TcxPageControl; Frame: TParamFrame; const NomeLabelCaption: String);
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
