unit pdv_confirma_qtde_peso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Menus, cxControls, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxTextEdit, cxCurrencyEdit, cxLabel, StdCtrls,
  cxButtons;

type
  TfrmConfirmaQtdePeso = class(TForm)
    panBotoes: TPanel;
    btnConfirmar: TcxButton;
    btnCancelar: TcxButton;
    panFechamento: TPanel;
    lblQtde: TcxLabel;
    edtQuantidade: TcxCurrencyEdit;
    lblValor: TcxLabel;
    edtValor: TcxCurrencyEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FQtde: Double;
  protected
    { Protected declarations }
  public
    property Qtde: Double read FQtde;
    { Public declarations }
  end;

var
  frmConfirmaQtdePeso: TfrmConfirmaQtdePeso;

function ConfirmaQtdePeso(flValorUnit: Double; boBalanca: Boolean = False) : Double;

implementation

uses lib_db, lib_mensagem, main_base, lib_vmsis;

{$R *.dfm}

function ConfirmaQtdePeso(flValorUnit: Double; boBalanca: Boolean = False): Double;
var
  Acesso_Perifericos: TAcesso_Perifericos;
Begin
  Result := 0.0;
  frmConfirmaQtdePeso := TfrmConfirmaQtdePeso.Create(Application);
  Acesso_Perifericos := TAcesso_Perifericos.Create;
  try
    frmConfirmaQtdePeso.edtQuantidade.Enabled := not boBalanca;
    if flValorUnit > 0.0 then
      frmConfirmaQtdePeso.edtValor.Text := formatfloat('###,###,##0.00', flValorUnit)
    else
      frmConfirmaQtdePeso.edtValor.Text := '0,00';
    if boBalanca then
      frmConfirmaQtdePeso.edtQuantidade.Text := formatfloat('###,###,##0.000', Acesso_Perifericos.LeBalanca)
    else
      frmConfirmaQtdePeso.edtQuantidade.Text := formatfloat('###,###,##0.000', 0.0);
    if StrToFloat(frmConfirmaQtdePeso.edtQuantidade.Text) < 0.001 then
      frmConfirmaQtdePeso.edtQuantidade.Enabled := True; 
    frmConfirmaQtdePeso.ShowModal;
    Result := frmConfirmaQtdePeso.Qtde;
  finally
    FreeAndNil(Acesso_Perifericos);
    FreeAndNil(frmConfirmaQtdePeso);
  end;
end;

procedure TfrmConfirmaQtdePeso.btnCancelarClick(Sender: TObject);
begin
  FQtde := 0.0;
  Close;
end;

procedure TfrmConfirmaQtdePeso.btnConfirmarClick(Sender: TObject);
begin                        
  if (edtQuantidade.Text = '') then
  begin
    Aviso(INFORMAR_QTDE);
    edtQuantidade.SetFocus;
  end else
  begin
    FQtde := StrToFloat(edtQuantidade.Text);
    Close;
  end;
end;

procedure TfrmConfirmaQtdePeso.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key in [#13]) then
  begin
    if (edtQuantidade.Text = '') then
    begin
      Aviso(INFORMAR_QTDE);
      edtQuantidade.SetFocus;
    end
    else
      btnConfirmarClick(btnConfirmar);
  end;
end;

end.

