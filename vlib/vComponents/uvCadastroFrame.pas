unit uvCadastroFrame;

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
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxContainer,
  cxEdit, cxStyles, cxImageComboBox, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, DB, cxDBData, dxSkinsdxNavBar2Painter,
  dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient, cxVGrid, cxDBVGrid,
  cxInplaceContainer, cxLabel, cxNavigator, cxDBNavigator, Provider, ADODB;

type
  TvCadastroFrame = class(TvPadraoFrame)
    cxvGrid1: TcxDBVerticalGrid;
    DataSource2: TDataSource;
    ClientDataSet2: TClientDataSet;
    dxNavBar1: TdxNavBar;
    nbProcesso: TdxNavBarGroup;
    nbiInserir: TdxNavBarItem;
    nbiExcluir: TdxNavBarItem;
    panGrid: TPanel;
    pnlNavigator: TPanel;
    cxDBNavigator1: TcxDBNavigator;
    lblGridCaption: TcxLabel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vCadastroFrame: TvCadastroFrame;

implementation

{$R *.dfm}

end.
