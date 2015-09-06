unit uvCadastroFornecedorFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uvPadraoCadastroFrame, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxStyles, cxEdit, cxCustomData,
  cxFilter, cxData, cxDataStorage, DB, cxDBData, dxSkinsdxNavBar2Painter,
  Menus, cxContainer, ActnList, ADODB, cxLabel, cxVGrid, cxDBVGrid,
  StdCtrls, cxButtons, dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar,
  cxNavigator, cxDBNavigator, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxInplaceContainer, ExtCtrls, cxPC;

type
  TvCadastroFornecedorFrame = class(TvPadraoCadastro)
    adqPadraoid: TIntegerField;
    adqPadraonrinscjurd: TWideStringField;
    adqPadraonmfornecedor: TWideStringField;
    adqPadraoidentificador: TWideStringField;
    adqPadraoidempresa: TIntegerField;
    adqPadraotelcel: TStringField;
    adqPadraotelfixo: TStringField;
    cxGrid1DBTableView1nrinscjurd: TcxGridDBColumn;
    cxGrid1DBTableView1nmfornecedor: TcxGridDBColumn;
    cxGrid1DBTableView1telcel: TcxGridDBColumn;
    cxGrid1DBTableView1telfixo: TcxGridDBColumn;
    cxvGrid1nrinscjurd: TcxDBEditorRow;
    cxvGrid1nmfornecedor: TcxDBEditorRow;
    cxvGrid1identificador: TcxDBEditorRow;
    cxvGrid1telcel: TcxDBEditorRow;
    cxvGrid1telfixo: TcxDBEditorRow;
    adqDetailid: TAutoIncField;
    adqDetailnmrua: TWideStringField;
    adqDetailcdnumero: TWideStringField;
    adqDetailcdcep: TWideStringField;
    adqDetailempresa_id: TIntegerField;
    adqDetaildtcadastro: TDateField;
    adqDetailcdbairro_id: TIntegerField;
    adqDetailcliente_id: TIntegerField;
    adqDetailfornecedor_id: TIntegerField;
    adqDetailcomplemento: TWideStringField;
    cxGridDBTableView1nmrua: TcxGridDBColumn;
    cxGridDBTableView1cdnumero: TcxGridDBColumn;
    cxGridDBTableView1cdcep: TcxGridDBColumn;
    cxGridDBTableView1dtcadastro: TcxGridDBColumn;
    cxGridDBTableView1cdbairro_id: TcxGridDBColumn;
    cxGridDBTableView1complemento: TcxGridDBColumn;
    procedure adqPadraoidentificadorChange(Sender: TField);
    procedure adqDetailNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vCadastroFornecedorFrame: TvCadastroFornecedorFrame;

implementation

{$R *.dfm}

procedure TvCadastroFornecedorFrame.adqPadraoidentificadorChange(Sender: TField);
begin
  inherited;
  if Sender.AsString = 'F' then
    adqPadraonrinscjurd.EditMask := '000.000.000-00;0; '
  else
    adqPadraonrinscjurd.EditMask := '00.000.000/0000-00;0; ';
end;

procedure TvCadastroFornecedorFrame.adqDetailNewRecord(DataSet: TDataSet);
begin
  inherited;
  adqDetailempresa_id.AsInteger := 1;
end;

end.
