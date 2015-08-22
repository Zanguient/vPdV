unit uvVisaoClienteFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvVisaoFrame, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Menus, cxControls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxStyles, cxEdit, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, DB, cxDBData, dxSkinsdxNavBar2Painter,
  ActnList, ADODB, dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxInplaceContainer, cxVGrid, cxNavigator,
  cxDBNavigator, StdCtrls, cxButtons, ExtCtrls;

type
  TvVisaoClienteFrame = class(TvVisaoFrame)
    nmcliente: TcxEditorRow;
    adqPadraoid: TAutoIncField;
    adqPadraoidempresa: TIntegerField;
    adqPadraonrinscjurd: TWideStringField;
    adqPadraonmcliente: TWideStringField;
    adqPadraoidentificador: TWideStringField;
    adqPadraotelcel: TWideStringField;
    adqPadraotelfixo: TWideStringField;
    cxGrid1DBTableView1id: TcxGridDBColumn;
    cxGrid1DBTableView1idempresa: TcxGridDBColumn;
    cxGrid1DBTableView1nrinscjurd: TcxGridDBColumn;
    cxGrid1DBTableView1nmcliente: TcxGridDBColumn;
    cxGrid1DBTableView1identificador: TcxGridDBColumn;
    cxGrid1DBTableView1telfixo: TcxGridDBColumn;
    cxGrid1DBTableView1telcel: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vVisaoClienteFrame: TvVisaoClienteFrame;

implementation

{$R *.dfm}

end.
