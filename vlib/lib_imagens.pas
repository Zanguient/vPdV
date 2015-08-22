unit lib_imagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, cxGraphics, ExtCtrls;

type
  Tlb_imagens = class(TForm)
    img16x16: TcxImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  lb_imagens: Tlb_imagens;

implementation

{$R *.dfm}

end.
