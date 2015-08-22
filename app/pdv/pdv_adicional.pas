unit pdv_adicional;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons;

type
  TfrmAdicional = class(TForm)
    scbAdicional: TScrollBox;
    scbOpcoes: TScrollBox;
    btnConfirma: TcxButton;
    btnSemAdd: TcxButton;
    btnCancelar: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdicional: TfrmAdicional;

implementation

{$R *.dfm}

procedure TfrmAdicional.FormCreate(Sender: TObject);
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
   
  for iComp := 0 to pred(scbOpcoes.ControlCount) do
  begin
    scbOpcoes.Controls[iComp].Width := Trunc(scbOpcoes.Width/scbOpcoes.ControlCount);
    scbOpcoes.Controls[iComp].Left  := Trunc(scbOpcoes.Width/scbOpcoes.ControlCount)*(iComp+1);
  end;
end;

procedure TfrmAdicional.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
