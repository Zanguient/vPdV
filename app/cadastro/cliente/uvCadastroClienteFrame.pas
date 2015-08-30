unit uvCadastroClienteFrame;

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
  cxInplaceContainer, ExtCtrls, cxPC, cxImageComboBox;

type
  TvCadastroCliente = class(TvPadraoCadastro)
    adqPadraoid: TAutoIncField;
    adqPadraoidempresa: TIntegerField;
    adqPadraonrinscjurd: TWideStringField;
    adqPadraonmcliente: TWideStringField;
    adqPadraoidentificador: TWideStringField;
    adqPadraotelcel: TWideStringField;
    adqPadraotelfixo: TWideStringField;
    cxGrid1DBTableView1id: TcxGridDBColumn;
    cxGrid1DBTableView1nrinscjurd: TcxGridDBColumn;
    cxGrid1DBTableView1nmcliente: TcxGridDBColumn;
    cxGrid1DBTableView1telfixo: TcxGridDBColumn;
    cxGrid1DBTableView1telcel: TcxGridDBColumn;
    nmcliente: TcxEditorRow;
    telfixo: TcxEditorRow;
    telcelular: TcxEditorRow;
    nrinscjurd: TcxEditorRow;
    cxvGrid1idempresa: TcxDBEditorRow;
    cxvGrid1nrinscjurd: TcxDBEditorRow;
    cxvGrid1nmcliente: TcxDBEditorRow;
    cxvGrid1identificador: TcxDBEditorRow;
    cxvGrid1telfixo: TcxDBEditorRow;
    cxvGrid1telcel: TcxDBEditorRow;
    adqDetailid: TAutoIncField;
    adqDetailnmrua: TWideStringField;
    adqDetailcdnumero: TWideStringField;
    adqDetailcdcep: TWideStringField;
    adqDetailempresa_id: TIntegerField;
    adqDetaildtcadastro: TDateField;
    adqDetailcdbairro_id: TIntegerField;
    adqDetailcliente_id: TIntegerField;
    adqDetailcomplemento: TStringField;
    cxGridDBTableView1nmrua: TcxGridDBColumn;
    cxGridDBTableView1cdnumero: TcxGridDBColumn;
    cxGridDBTableView1complemento: TcxGridDBColumn;
    cxGridDBTableView1cdcep: TcxGridDBColumn;
    cxGridDBTableView1cdbairro_id: TcxGridDBColumn;
    cxGridDBTableView1dtcadastro: TcxGridDBColumn;
    procedure adqPadraoidentificadorChange(Sender: TField);
    procedure adqPadraoNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vCadastroCliente: TvCadastroCliente;

implementation

{$R *.dfm}

procedure TvCadastroCliente.adqPadraoidentificadorChange(Sender: TField);
begin
  inherited;
  if Sender.AsString = 'F' then
    adqPadraonrinscjurd.EditMask := '000.000.000-00;0; '
  else
    adqPadraonrinscjurd.EditMask := '00.000.000/0000-00;0; ';
end;

procedure TvCadastroCliente.adqPadraoNewRecord(DataSet: TDataSet);
begin
  inherited;
  adqPadraoidempresa.AsInteger := 1;
  adqPadraoidentificador.AsString := 'F';
end;

end.
