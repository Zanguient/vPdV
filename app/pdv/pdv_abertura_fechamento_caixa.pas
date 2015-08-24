unit pdv_abertura_fechamento_caixa;

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
 TTipoLancamentoCaixa = (tlPreAbertura, tlAbertura, tlFechamento);
  TfrmAberturaFechamentoCaixa = class(TForm)
    panPreAbertura: TPanel;
    panBotoes: TPanel;
    btnConfirmar: TcxButton;
    btnCancelar: TcxButton;
    lblVrCaixa: TcxLabel;
    edtValorPreAbertura: TcxCurrencyEdit;
    panAbertura: TPanel;
    cxLabel1: TcxLabel;
    edtValorAbertura: TcxCurrencyEdit;
    panFechamento: TPanel;
    cxLabel2: TcxLabel;
    edtVendasCalc: TcxCurrencyEdit;
    cxLabel3: TcxLabel;
    edtRetiradasCalc: TcxCurrencyEdit;
    cxLabel4: TcxLabel;
    edtSangriaCalc: TcxCurrencyEdit;
    cxLabel5: TcxLabel;
    edtEntradaCalc: TcxCurrencyEdit;
    cxLabel6: TcxLabel;
    edtDebitoCalc: TcxCurrencyEdit;
    cxLabel7: TcxLabel;
    edtCreditoCalc: TcxCurrencyEdit;
    edtVendasConf: TcxCurrencyEdit;
    edtSangriaConf: TcxCurrencyEdit;
    edtRetiradasConf: TcxCurrencyEdit;
    edtEntradaConf: TcxCurrencyEdit;
    edtDebitoConf: TcxCurrencyEdit;
    edtCreditoConf: TcxCurrencyEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    FConfirmado : Boolean;
    procedure RedimencionarTela;
    procedure ValidarCampo(edit : TcxCurrencyEdit; const MaiorQueZero : Boolean = False);
    procedure GravarValorPreAbertura;
    procedure GravarValorAbertura;
  protected
    FTipoLancamento : TTipoLancamentoCaixa;
  public
    property Confirmado : Boolean read FConfirmado;
    { Public declarations }
  end;

var
  frmAberturaFechamentoCaixa: TfrmAberturaFechamentoCaixa;

function CaixaPreAberto : Boolean;
function CaixaAberto : Boolean;
function CaixaFechado : Boolean;

implementation

uses lib_db, lib_mensagem, main_base, lib_vmsis;

{$R *.dfm}

function CaixaPreAberto;
begin
  Result := False;
  frmAberturaFechamentoCaixa := TfrmAberturaFechamentoCaixa.Create(Application);
  try
    frmAberturaFechamentoCaixa.FTipoLancamento := tlPreAbertura;
    frmAberturaFechamentoCaixa.ShowModal;
    Result := frmAberturaFechamentoCaixa.Confirmado;
  finally
    FreeAndNil(frmAberturaFechamentoCaixa);
  end;

end;

function CaixaAberto : Boolean;
var
  tbAberFechCaixa : TObjetoDB;

begin
  tbAberFechCaixa := TObjetoDB.create('aberfechcaixa');
  try
    tbAberFechCaixa.AddParametro('status', 'A');
    tbAberFechCaixa.Select(['id']);
    if not tbAberFechCaixa.Cds.IsEmpty then
    begin
      Result := True;
      Exit;
    end;
  finally
    FreeAndNil(tbAberFechCaixa);
  end;

  Result := False;
  frmAberturaFechamentoCaixa := TfrmAberturaFechamentoCaixa.Create(Application);
  try
    frmAberturaFechamentoCaixa.FTipoLancamento := tlAbertura;
    frmAberturaFechamentoCaixa.ShowModal;
    Result := frmAberturaFechamentoCaixa.Confirmado;
  finally
    FreeAndNil(frmAberturaFechamentoCaixa);
  end;
end;

function CaixaFechado : Boolean;
begin
  Result := False;
  frmAberturaFechamentoCaixa := TfrmAberturaFechamentoCaixa.Create(Application);
  try
    frmAberturaFechamentoCaixa.FTipoLancamento := tlFechamento;
    frmAberturaFechamentoCaixa.ShowModal;
    Result := frmAberturaFechamentoCaixa.Confirmado;
  finally
    FreeAndNil(frmAberturaFechamentoCaixa);
  end;
end;
procedure TfrmAberturaFechamentoCaixa.FormShow(Sender: TObject);
begin
  RedimencionarTela;
  edtValorPreAbertura.Value := 0;
  edtValorAbertura.Value := 0;
//  edtValorAbertura.Text
end;

procedure TfrmAberturaFechamentoCaixa.btnCancelarClick(Sender: TObject);
begin
   FConfirmado := False;
   Close;
end;

procedure TfrmAberturaFechamentoCaixa.RedimencionarTela;
const
 VALOR_ADICIONAL = 31;
begin
  case FTipoLancamento of
    tlPreAbertura :
    begin
      panPreAbertura.Visible := True;
      frmAberturaFechamentoCaixa.Height := panPreAbertura.Height + panBotoes.Height + VALOR_ADICIONAL;
      frmAberturaFechamentoCaixa.Caption := 'Definir valor inicial para próxima abertura';
    end;
    tlAbertura:
    begin
      panAbertura.Visible := True;
      frmAberturaFechamentoCaixa.Height := panAbertura.Height + panBotoes.Height + VALOR_ADICIONAL;;
      frmAberturaFechamentoCaixa.Caption := 'Abertura do caixa';
    end;
    tlFechamento:
    begin
      panFechamento.Visible := True;
      frmAberturaFechamentoCaixa.Height := panFechamento.Height + panBotoes.Height + VALOR_ADICIONAL;;
      frmAberturaFechamentoCaixa.Caption := 'Fechamento do caixa';
    end;
  end;
  panBotoes.Visible := True;

end;

procedure TfrmAberturaFechamentoCaixa.ValidarCampo(edit: TcxCurrencyEdit;
  const MaiorQueZero: Boolean = False);
begin
   if (edit.Value = Null) or (MaiorQueZero and (edit.Value <= 0) ) then
   begin
     Aviso(INFORMAR_VALOR);
     if edit.CanFocus then
       edit.SetFocus;
     Abort;
   end;

end;

procedure TfrmAberturaFechamentoCaixa.GravarValorPreAbertura;
var
  tbAberFechCaixa : TObjetoDB;
  tbCaixa : TObjetoDB;
begin
  FConfirmado := False;
  ValidarCampo(edtValorPreAbertura);

  tbAberFechCaixa := TobjetoDB.create('aberfechcaixa');
  try
    try
      tbAberFechCaixa.AddSqlAdicional(' where status in (''P'', ''A'') ');
      tbAberFechCaixa.Select(['ID']);

      if not tbAberFechCaixa.cds.IsEmpty then
      begin
        Aviso(EXISTENCIA_CAIXA_ABERTO);
        Abort;
      end;

      tbAberFechCaixa.Reset;

      tbCaixa := TObjetoDB.create('caixa');
      try
        tbCaixa.Select(['id']);
        tbCaixa.Cds.First;
        tbAberFechCaixa.AddParametro('id_caixa', tbCaixa.GetVal('id'));
      finally
        FreeAndNil(tbCaixa);
      end;
      tbAberFechCaixa.AddParametro('vrinicial',(StringReplace(edtValorPreAbertura.Text, ',', '.', [rfReplaceAll])));
      tbAberFechCaixa.AddParametro('funcipreabertura', frmMainBase.FidUsuario);
      tbAberFechCaixa.AddParametro('dtmovi', TUtilidades.GetDateToMySql(Date));
      tbAberFechCaixa.AddParametro('status', 'P');
      tbAberFechCaixa.Insert;
      FConfirmado := True;
    except
      on E:Exception do
      begin
        if E.ClassType <> EAbstractError then
        begin
          Aviso('Ocorreu um erro ao abrir o caixa.' + #13 + E.Message);
          Exit;
        end
        else
          Abort;
      end
    end;
  finally
    FreeAndNil(tbAberFechCaixa);
  end;
end;

procedure TfrmAberturaFechamentoCaixa.btnConfirmarClick(Sender: TObject);
begin
   case FTipoLancamento of
     tlPreAbertura: GravarValorPreAbertura;
     tlAbertura: GravarValorAbertura;
   end;
   close;
end;

procedure TfrmAberturaFechamentoCaixa.GravarValorAbertura;
var
  tbAberFechCaixa : TObjetoDB;
begin
  FConfirmado := False;
  tbAberFechCaixa := TObjetoDB.create('aberfechcaixa');
  try
    tbAberFechCaixa.AddParametro('status', 'A');
    tbAberFechCaixa.Select(['ID']);
    if not tbAberFechCaixa.Cds.IsEmpty then
    begin
      FConfirmado := True;
      Exit;
    end;

    tbAberFechCaixa.Reset;
    tbAberFechCaixa.AddParametro('status', 'P');
    tbAberFechCaixa.Select(['vrcorrigido', 'dtmovi', 'funciconfabertura', 'status']);

    if tbAberFechCaixa.Cds.IsEmpty then
    begin
      GravarValorPreAbertura;
      tbAberFechCaixa.Select(['vrcorrigido', 'dtmovi', 'funciconfabertura', 'status']);

      if tbAberFechCaixa.Cds.IsEmpty then
      begin
        Aviso(FALHA_ABRIR_CAIXA);
        Abort;
      end;
    end;

    tbAberFechCaixa.ChangeValue('vrcorrigido', edtValorAbertura.Value);
    tbAberFechCaixa.ChangeValue('dtmovi', Date);
    tbAberFechCaixa.ChangeValue('funciconfabertura', frmMainBase.FidUsuario);
    tbAberFechCaixa.ChangeValue('status', 'A');
    tbAberFechCaixa.SaveChanges;
    FConfirmado := True;

  finally
    FreeAndNil(tbAberFechCaixa);
  end;
end;

end.

