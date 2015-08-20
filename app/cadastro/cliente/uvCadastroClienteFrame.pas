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
  cxDBVGrid, StdCtrls, cxButtons, ExtCtrls;

type
  TvCadastroClienteFrame = class(TvCadastroFrame)
    adqPadraoid: TAutoIncField;
    adqPadraoidempresa: TIntegerField;
    adqPadraonrinscjurd: TWideStringField;
    adqPadraonmcliente: TWideStringField;
    adqPadraoidentificador: TWideStringField;
    adqPadraotelcel: TWideStringField;
    adqPadraotelfixo: TWideStringField;
    cdsPadraoid: TAutoIncField;
    cdsPadraoidempresa: TIntegerField;
    cdsPadraonrinscjurd: TWideStringField;
    cdsPadraonmcliente: TWideStringField;
    cdsPadraoidentificador: TWideStringField;
    cdsPadraotelcel: TWideStringField;
    cdsPadraotelfixo: TWideStringField;
    cxvGrid1id: TcxDBEditorRow;
    cxvGrid1idempresa: TcxDBEditorRow;
    cxvGrid1nrinscjurd: TcxDBEditorRow;
    cxvGrid1nmcliente: TcxDBEditorRow;
    cxvGrid1identificador: TcxDBEditorRow;
    cxvGrid1telcel: TcxDBEditorRow;
    cxvGrid1telfixo: TcxDBEditorRow;
    nbiSalvar: TdxNavBarItem;
    procedure nbiSalvarClick(Sender: TObject);
    procedure nbiInserirClick(Sender: TObject);
    procedure nbiExcluirClick(Sender: TObject);
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

procedure TvCadastroClienteFrame.nbiSalvarClick(Sender: TObject);
begin
  inherited;
 // cdsPadrao.Post;
//  cdsPadrao.ApplyUpdates(0);

end;

procedure TvCadastroClienteFrame.nbiInserirClick(Sender: TObject);
begin
  inherited;
//   cdsPadrao.Append;
end;

procedure TvCadastroClienteFrame.nbiExcluirClick(Sender: TObject);
begin
  inherited;
  // cdsPadrao.Delete;
end;

end.
