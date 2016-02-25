unit pdv_sangria;

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
  ADODB, cxCurrencyEdit;

type
  Tfrmsangria = class(TForm)
    scbMenu: TScrollBox;
    btnCancelar: TcxButton;
    btnConfirmar: TcxButton;
    scbValor: TScrollBox;
    lblVrRetirada: TcxLabel;
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
    edtValor: TcxCurrencyEdit;
    adqInsMovCaixa: TADOQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsangria: Tfrmsangria;

implementation

{$R *.dfm}

uses
  lib_mensagem, lib_interface, lib_vmsis, lib_acesso, main_base;

procedure Tfrmsangria.btnCancelarClick(Sender: TObject);
begin  
  Close;
end;

procedure Tfrmsangria.FormShow(Sender: TObject);
begin
  edtValor.Text := '0,00';
end;

procedure Tfrmsangria.btnConfirmarClick(Sender: TObject);
var
  Acesso_Perifericos: TAcesso_Perifericos;
  AcessoGaveta: TAcessoUsuario;
begin
  AcessoGaveta := TAcessoUsuario.create(frmMainBase.NomeUsuario);
  Acesso_Perifericos := TAcesso_Perifericos.Create;
  try
    if AcessoGaveta.Autenticado('gaveta', TpmProcessar) then
    begin
      adqInsMovCaixa.Close;
      adqInsMovCaixa.Parameters.ParamByName('ID_CAIXA').Value := 1;
      adqInsMovCaixa.Parameters.ParamByName('DTMOVI').Value := Now;
      adqInsMovCaixa.Parameters.ParamByName('VRMOVI').Value := StrToFloat(edtValor.Text);
      adqInsMovCaixa.Parameters.ParamByName('TPMOVI').Value    := 'S';
      adqInsMovCaixa.Parameters.ParamByName('FORMPGTO').Value  := 'DI';
      adqInsMovCaixa.ExecSQL;
      
      Acesso_Perifericos.AbreGaveta;
    end;
  finally
    FreeAndNil(AcessoGaveta);
    FreeAndNil(Acesso_Perifericos);
  end;
    
  Close;
end;

procedure Tfrmsangria.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in [#13]) then
  begin
    if (edtValor.Text = '') then
    begin
      Aviso(INFORMAR_VALOR);
      edtValor.SetFocus;
    end
    else
      btnConfirmarClick(btnConfirmar);
  end;
end;

procedure Tfrmsangria.edtValorKeyPress(Sender: TObject;
  var Key: Char);
begin         
  if (key in ['-']) then
    key := #0
  else if (key in [#13]) then
    btnConfirmarClick(btnConfirmar);
end;

end.
