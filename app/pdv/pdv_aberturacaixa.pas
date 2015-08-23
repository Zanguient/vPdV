unit pdv_aberturacaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, cxControls, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxLabel, cxTextEdit, DB, Provider,
  ADODB;

type
  TfrmAberturaCaixa = class(TForm)
    scbMenu: TScrollBox;
    btnCancelar: TcxButton;
    btnConfirmar: TcxButton;
    scbValor: TScrollBox;
    lblVrCaixa: TcxLabel;
    edtValor: TcxTextEdit;
    adqPadrao: TADOQuery;
    dspPadrao: TDataSetProvider;
    dtsPadrao: TDataSource;
    adqPadraoID: TAutoIncField;
    adqPadraoID_CAIXA: TIntegerField;
    adqPadraoVRINICIAL: TFloatField;
    adqPadraoVRCORRIGIDO: TFloatField;
    adqPadraoDTMOVI: TDateField;
    adqPadraoFUNCICONFABERTURA: TIntegerField;
    adqPadraoSTATUS: TStringField;
    adqInicia: TADOQuery;
    AutoIncField1: TAutoIncField;
    IntegerField1: TIntegerField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    DateField1: TDateField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FAberto: Boolean;
  public
    { Public declarations }
    function GetCaixaAberto: Boolean;
  end;

var
  frmAberturaCaixa: TfrmAberturaCaixa;

implementation

{$R *.dfm}

uses
  lib_mensagem;

procedure TfrmAberturaCaixa.btnCancelarClick(Sender: TObject);
begin  
  FAberto := False;
  Close;
end;

procedure TfrmAberturaCaixa.FormShow(Sender: TObject);
begin
  adqPadrao.Close;
  adqPadrao.Open;

  if adqPadrao.IsEmpty then
    FAberto := False
  else begin
    FAberto := True;
    Close;
  end;

  edtValor.Text := '0,00';
end;

function TfrmAberturaCaixa.GetCaixaAberto: Boolean;
begin
  Result := FAberto;
end;

procedure TfrmAberturaCaixa.btnConfirmarClick(Sender: TObject);
begin     
  FAberto := False;

  adqInicia.Close;
  adqInicia.Parameters.ParamByName('ID_CAIXA').Value := 1;
  adqInicia.Parameters.ParamByName('VRCORRIGIDO').Value := StrToFloat(edtValor.Text);
  adqInicia.Parameters.ParamByName('FUNCICONFABERTURA').Value := 1;
  adqInicia.Parameters.ParamByName('STATUS').Value := 'A';
  adqInicia.ExecSQL;

  FAberto := True;  
  Close;
end;

procedure TfrmAberturaCaixa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in [#13]) then
  begin
    if (edtValor.Text = '') then
    begin
      Aviso(INFORMAR_SENHA);
      edtValor.SetFocus;
    end
    else
      btnConfirmarClick(btnConfirmar);
  end;
end;

procedure TfrmAberturaCaixa.edtValorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9',',',#8]) then
    key := #0;
end;

end.
