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
  cxInplaceContainer, ExtCtrls, cxPC, cxCurrencyEdit, cxMaskEdit,
  cxCalendar, cxDBLookupComboBox, cxImageComboBox;

type
  TvCadastroFornecedorFrame = class(TvPadraoCadastro)
    adqPadraoid: TIntegerField;
    adqPadraonrinscjurd: TWideStringField;
    adqPadraonmfornecedor: TWideStringField;
    adqPadraoidentificador: TWideStringField;
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
    adqPadraonmrua: TWideStringField;
    adqPadraocdnumero: TWideStringField;
    adqPadraocomplemento: TStringField;
    adqPadraocdcep: TWideStringField;
    adqPadraocdbairro_id: TIntegerField;
    adqPadraodtcadastro: TDateTimeField;
    adqPadraoid_web: TIntegerField;
    catEndereco: TcxCategoryRow;
    cxvGrid1nmrua: TcxDBEditorRow;
    cxvGrid1cdnumero: TcxDBEditorRow;
    cxvGrid1complemento: TcxDBEditorRow;
    cxvGrid1cdbairro_id: TcxDBEditorRow;
    cxvGrid1cdcep: TcxDBEditorRow;
    cxvGrid1DBEditorRow6: TcxDBEditorRow;
    adqBairro: TADOQuery;
    adqBairroid: TAutoIncField;
    adqBairrodtcadastro: TDateField;
    adqBairrocdbairro: TWideStringField;
    adqBairronmbairro: TWideStringField;
    adqBairrocidade_id: TIntegerField;
    adqBairroid_web: TIntegerField;
    dtsBairro: TDataSource;
    procedure adqPadraoidentificadorChange(Sender: TField);
    procedure adqPadraoNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
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

constructor TvCadastroFornecedorFrame.Create(AOwner: TComponent);
begin
  inherited;
  adqBairro.Close;
  adqBairro.Open;
end;

procedure TvCadastroFornecedorFrame.adqPadraoNewRecord(DataSet: TDataSet);
begin
  inherited;
  adqPadraoidentificador.AsString := 'F';
  adqPadraodtcadastro.AsDateTime := Date;
end;

end.
