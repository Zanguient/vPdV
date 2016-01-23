unit pdv_forma_pagamento;

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
  TfrmFormaPagamento = class(TForm)
    scbMenu: TScrollBox;
    scbValor: TScrollBox;
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
    lblFormaPagamento: TcxLabel;
    btnCredito: TcxButton;
    btnDebito: TcxButton;
    btnDinheiro: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDinheiroClick(Sender: TObject);
    procedure btnDebitoClick(Sender: TObject);
    procedure btnCreditoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;                     
  function Escolhe_Forma_Pagamento: String;

var
  frmFormaPagamento: TfrmFormaPagamento;
  stForma: String;

implementation

{$R *.dfm}

uses
  lib_mensagem;

{ TfrmFormaPagamento }

function Escolhe_Forma_Pagamento: String;
begin
  frmFormaPagamento := TfrmFormaPagamento.Create(Nil);
  frmFormaPagamento.ShowModal;

  Result := stForma;
end;

procedure TfrmFormaPagamento.FormShow(Sender: TObject);
var
  iComp: Integer;
begin
  stForma := '';

  for iComp := 0 to pred(scbMenu.ControlCount) do
  begin
    scbMenu.Controls[iComp].Width := Trunc(scbMenu.Width/(scbMenu.ControlCount));
  end;
end;

procedure TfrmFormaPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;

procedure TfrmFormaPagamento.btnDinheiroClick(Sender: TObject);
begin
  stForma := 'DI';
  Close;
end;

procedure TfrmFormaPagamento.btnDebitoClick(Sender: TObject);
begin
  stForma := 'DE';
  Close;
end;

procedure TfrmFormaPagamento.btnCreditoClick(Sender: TObject);
begin
  stForma := 'CR';
  Close;
end;

end.
