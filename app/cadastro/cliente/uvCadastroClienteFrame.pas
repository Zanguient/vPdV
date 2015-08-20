unit uvCadastroClienteFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvCadastroFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxStyles, cxEdit, dxSkinsdxNavBar2Painter,
  cxContainer, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, Provider, ADODB, DBClient, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxLabel, cxNavigator, cxDBNavigator,
  dxNavBarCollns, dxNavBarBase, dxNavBar, cxInplaceContainer, cxVGrid,
  cxDBVGrid, StdCtrls, cxButtons, ExtCtrls, ActnList;

type
  TvCadastroClienteFrame = class(TvCadastroFrame)
    adqPadraoid: TAutoIncField;
    adqPadraoidempresa: TIntegerField;
    adqPadraonrinscjurd: TWideStringField;
    adqPadraonmcliente: TWideStringField;
    adqPadraoidentificador: TWideStringField;
    adqPadraotelcel: TWideStringField;
    adqPadraotelfixo: TWideStringField;
    cxvGrid1id: TcxDBEditorRow;
    cxvGrid1idempresa: TcxDBEditorRow;
    cxvGrid1nrinscjurd: TcxDBEditorRow;
    cxvGrid1nmcliente: TcxDBEditorRow;
    cxvGrid1identificador: TcxDBEditorRow;
    cxvGrid1telcel: TcxDBEditorRow;
    cxvGrid1telfixo: TcxDBEditorRow;
    nbiSalvar: TdxNavBarItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vCadastroClienteFrame: TvCadastroClienteFrame;

implementation

uses uvPadraoFrame;

{$R *.dfm}

end.
