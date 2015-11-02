unit uvEstoqueEntradaFrame;

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
  cxInplaceContainer, ExtCtrls, cxPC, cxCalendar,
  cxDBLookupComboBox, cxCurrencyEdit;

type
  TvEstoqueEntradaFrame = class(TvPadraoCadastro)
    adqPadraoid: TAutoIncField;
    adqPadraodtentrada: TDateField;
    adqPadraofornecedor_id: TIntegerField;
    adqPadraoid_web: TIntegerField;
    adqPadraodtcadastro: TDateTimeField;
    cxgridFiltroDtEntrada: TcxEditorRow;
    cxGrid1DBTableView1dtentrada: TcxGridDBColumn;
    cxGrid1DBTableView1fornecedor_id: TcxGridDBColumn;
    adqFornecedor: TADOQuery;
    dtsFornecedor: TDataSource;
    adqFornecedorid: TAutoIncField;
    adqFornecedornrinscjurd: TWideStringField;
    adqFornecedornmfornecedor: TWideStringField;
    adqFornecedoridentificador: TWideStringField;
    adqFornecedornmrua: TWideStringField;
    adqFornecedorcdnumero: TWideStringField;
    adqFornecedorcdcep: TWideStringField;
    adqFornecedorcdbairro_id: TIntegerField;
    adqFornecedortelcel: TWideStringField;
    adqFornecedortelfixo: TWideStringField;
    adqFornecedorid_web: TIntegerField;
    adqFornecedordtcadastro: TDateTimeField;
    cxvGrid1id: TcxDBEditorRow;
    cxvGrid1dtentrada: TcxDBEditorRow;
    cxvGrid1fornecedor_id: TcxDBEditorRow;
    adqDetailid: TAutoIncField;
    adqDetaildtcadastro: TDateField;
    adqDetailproduto_id: TIntegerField;
    adqDetaillote_id: TIntegerField;
    adqDetailqtdeprod: TFloatField;
    adqDetailid_web: TIntegerField;
    adqDetailentrada_id: TIntegerField;
    adqDetailsaida_id: TIntegerField;
    adqDetailvlprod: TFloatField;
    cxGridDBTableView1produto_id: TcxGridDBColumn;
    cxGridDBTableView1qtdeprod: TcxGridDBColumn;
    cxGridDBTableView1vlprod: TcxGridDBColumn;
    adqProduto: TADOQuery;
    DataSource1: TDataSource;
    adqProdutoid: TAutoIncField;
    adqProdutodtcadastro: TDateField;
    adqProdutoposarvore: TWideStringField;
    adqProdutonmproduto: TWideStringField;
    adqProdutounimedida_id: TIntegerField;
    adqProdutocdbarra: TWideStringField;
    adqProdutoidprodvenda: TSmallintField;
    adqProdutoidadicional: TSmallintField;
    adqProdutoimgindex: TIntegerField;
    adqProdutoid_web: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;    
  end;

var
  vEstoqueEntradaFrame: TvEstoqueEntradaFrame;

implementation

{$R *.dfm}

{ TvEstoqueEntradaFrame }

constructor TvEstoqueEntradaFrame.Create(AOwner: TComponent);
begin
  inherited;
  adqProduto.Close;
  adqProduto.Open;

  adqFornecedor.Close;
  adqFornecedor.Open;
end;

end.
