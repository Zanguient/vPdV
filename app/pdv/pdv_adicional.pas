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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdicional: TfrmAdicional;

implementation

{$R *.dfm}

end.
