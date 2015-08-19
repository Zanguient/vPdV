unit uvVisaoFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvPadraoFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, StdCtrls, cxButtons, ExtCtrls, cxControls,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxStyles,
  cxEdit, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, dxSkinsdxNavBar2Painter, cxNavigator,
  cxDBNavigator, dxNavBar, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxInplaceContainer, cxVGrid, dxNavBarCollns, dxNavBarBase, DBClient,
  Provider, ADODB;

type
  TvVisaoFrame = class(TvPadraoFrame)
    cxVerticalGrid1: TcxVerticalGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    panFiltro: TPanel;
    dxNavBar: TdxNavBar;
    cxDBNavigator1: TcxDBNavigator;
    nbiFiltrar: TdxNavBarItem;
    nbLimpar: TdxNavBarItem;
    nbiIncluir: TdxNavBarItem;
    nbiExcluir: TdxNavBarItem;
    nbPesquisa: TdxNavBarGroup;
    nbProcesso: TdxNavBarGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vVisaoFrame: TvVisaoFrame;

implementation

{$R *.dfm}

end.
