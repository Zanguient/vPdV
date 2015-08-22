unit pdv_adicional;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, DB, DBClient;

type
  TfrmAdicional = class(TForm)
    scbAdicional: TScrollBox;
    scbOpcoes: TScrollBox;
    btnConfirma: TcxButton;
    btnSemAdd: TcxButton;
    btnCancelar: TcxButton;
    cdsAdicional: TClientDataSet;
    dtsAdicional: TDataSource;
    cdsAdicionalNMADICIONAL: TStringField;
    cdsAdicionalID: TIntegerField;
    cdsAdicionalIDMARCADO: TStringField;
    cdsAdicionalIDIMG: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OnClickAdicionalPDV(Sender: TObject);
  end;

var
  frmAdicional: TfrmAdicional;

implementation

{$R *.dfm}

uses
  lib_interface;

procedure TfrmAdicional.FormCreate(Sender: TObject);
var
   region: hrgn;
begin
  Height := Screen.WorkAreaHeight-20;
  Width  := Screen.WorkAreaWidth-20;
  Position := poScreenCenter;

  DoubleBuffered := True;
  region := CreateRoundRectRgn(0, 0, width, height, 15, 15);
  SetWindowRgn(handle, region, true);
end;

procedure TfrmAdicional.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAdicional.FormShow(Sender: TObject);  
var
  Interface_: TInterface; 
  iComp: Integer;
begin
  Interface_ := TInterface.Create();
  
  for iComp := 0 to pred(scbOpcoes.ControlCount) do
  begin
    scbOpcoes.Controls[iComp].Width := Trunc(scbOpcoes.Width/scbOpcoes.ControlCount);
    scbOpcoes.Controls[iComp].Left  := Trunc(scbOpcoes.Width/scbOpcoes.ControlCount)*(iComp+1);
  end;

  if scbAdicional.ControlCount = 0 then
  begin
    cdsAdicional.First;
    while not cdsAdicional.Eof do
    begin
      Interface_.CriaButtonScrollBox(scbAdicional, cdsAdicional.FieldByName('NMADICIONAL').AsString,
        OnClickAdicionalPDV, 150, 150);

      cdsAdicional.Next;
    end;
  end;

  if scbAdicional.ControlCount > 0 then
  begin
    Interface_ := TInterface.Create();
    Interface_.OrganizaScrollBox(scbAdicional,1);
  end;
end;

procedure TfrmAdicional.OnClickAdicionalPDV(Sender: TObject);
begin
  (Sender as TcxButton).CanBeFocused := not (Sender as TcxButton).CanBeFocused;
end;

end.
