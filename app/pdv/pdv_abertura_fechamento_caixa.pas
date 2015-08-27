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
    procedure PrepararTelas;
    procedure ValidarCampo(edit : TcxCurrencyEdit; const MaiorQueZero : Boolean = False);
    procedure GravarValorPreAbertura;
    procedure GravarValorAbertura;
    procedure GravarValorFechamento;
    procedure BuscarValorFechamento;
  protected
    FTipoLancamento : TTipoLancamentoCaixa;
    FidCaixa : Integer;
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
    if not tbAberFechCaixa.IsEmpty then
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
  PrepararTelas;
  edtValorPreAbertura.Value := 0;
  edtValorAbertura.Value := 0;
//  edtValorAbertura.Text
end;

procedure TfrmAberturaFechamentoCaixa.btnCancelarClick(Sender: TObject);
begin
   FConfirmado := False;
   Close;
end;

procedure TfrmAberturaFechamentoCaixa.PrepararTelas;
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
      BuscarValorFechamento;
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
    tbAberFechCaixa.AddSqlAdicional(' where status in (''P'', ''A'') ');
    tbAberFechCaixa.Select(['ID']);

    if not tbAberFechCaixa.IsEmpty then
    begin
      Aviso(EXISTENCIA_CAIXA_ABERTO);
      Abort;
    end;

    tbAberFechCaixa.Reset;

    tbCaixa := TObjetoDB.create('caixa');
    try
      tbCaixa.Select(['id']);
      tbCaixa.First;
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
  finally
    FreeAndNil(tbAberFechCaixa);
  end;
end;

procedure TfrmAberturaFechamentoCaixa.btnConfirmarClick(Sender: TObject);
begin
   case FTipoLancamento of
     tlPreAbertura: GravarValorPreAbertura;
     tlAbertura: GravarValorAbertura;
     tlFechamento: GravarValorFechamento;
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
    if not tbAberFechCaixa.IsEmpty then
    begin
      FConfirmado := True;
      Exit;
    end;

    tbAberFechCaixa.Reset;
    tbAberFechCaixa.AddParametro('status', 'P');
    tbAberFechCaixa.Select(['vrcorrigido', 'dtmovi', 'funciconfabertura', 'status']);

    if tbAberFechCaixa.IsEmpty then
    begin
      GravarValorPreAbertura;
      tbAberFechCaixa.Select(['vrcorrigido', 'dtmovi', 'funciconfabertura', 'status']);

      if tbAberFechCaixa.IsEmpty then
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

procedure TfrmAberturaFechamentoCaixa.GravarValorFechamento;
var

  tbAberFechCaixa : TObjetoDB;
begin


  tbAberFechCaixa := TobjetoDB.create('aberfechcaixa');
  try
    tbAberFechCaixa.AddParametro('status', 'A');
    tbAberFechCaixa.AddParametro('id_caixa', FidCaixa);
    tbAberFechCaixa.Select(['*']);

    tbAberFechCaixa.ChangeValue('vrvenda', edtVendasConf.Value);
    tbAberFechCaixa.ChangeValue('vrretirada', edtRetiradasConf.Value);
    tbAberFechCaixa.ChangeValue('vrsangria', edtSangriaConf.Value);
    tbAberFechCaixa.ChangeValue('vrentrada', edtEntradaConf.Value);
    tbAberFechCaixa.ChangeValue('vrdebio', edtDebitoConf.Value);
    tbAberFechCaixa.ChangeValue('vrcredito', edtCreditoConf.Value);
    tbAberFechCaixa.ChangeValue('status', 'F');
    tbAberFechCaixa.ChangeValue('funcifechamento', frmMainBase.FidUsuario);
    tbAberFechCaixa.SaveChanges;
    FConfirmado := True;
  finally
    FreeAndNil(tbAberFechCaixa);
  end;
end;

procedure TfrmAberturaFechamentoCaixa.BuscarValorFechamento;
var
  tbAberFechCaixa : TObjetoDB;
  tbMovCaixa : TObjetoDB;
  tbCaixa : TObjetoDB;
  IdCaixa : Integer;
  DataMovimento : TDate;
const
  ENTRADA = 'E';
  VENDA = 'V';
  SANGRIA = 'S';
  RETIRADA = 'R';
  CREDITO = 'CR';
  DEBITO = 'DE';
begin

  tbCaixa := TObjetoDB.create('caixa');
  try
    tbCaixa.Select(['id']);
    IdCaixa := tbCaixa.GetVal('id');
  finally
    FreeAndNil(tbCaixa);
  end;

  tbAberFechCaixa := TobjetoDB.create('aberfechcaixa');
  try
    tbAberFechCaixa.AddParametro('status', 'A');
    tbAberFechCaixa.AddParametro('id_caixa', IdCaixa);
    tbAberFechCaixa.Select(['dtmovi']);
    DataMovimento := VarToDateTime(tbAberFechCaixa.GetVal('dtmovi'));
  finally
    FreeAndNil(tbAberFechCaixa);
  end;

  tbMovCaixa := TObjetoDB.create('movcaixa');
  try
    //valores por tipo
    tbMovCaixa.AddParametro('dtmovi', DataMovimento, ' >= ');
    tbMovCaixa.AddSqlAdicional(' group by tpmovi');
    tbMovCaixa.Select(['sum(vrmovi) as vrmovi', 'tpmovi']);

    if tbMovCaixa.Find('tpmovi', VENDA) then
      edtVendasCalc.Value := tbMovCaixa.GetVal('vrmovi')
    else
      edtVendasCalc.Value := 0;

    if tbMovCaixa.Find('tpmovi', RETIRADA) then
      edtRetiradasCalc.Value := tbMovCaixa.GetVal('vrmovi')
    else
      edtRetiradasCalc.Value := 0;

    if tbMovCaixa.Find('tpmovi', SANGRIA) then
      edtSangriaCalc.Value := tbMovCaixa.GetVal('vrmovi')
    else
      edtSangriaCalc.Value := 0;

    if tbMovCaixa.Find('tpmovi', ENTRADA) then
      edtEntradaCalc.Value := tbMovCaixa.GetVal('vrmovi')
    else
      edtEntradaCalc.Value := 0;

    //valores por forma de pagamento
    tbMovCaixa.ClearSqlAdicional;
    tbMovCaixa.AddSqlAdicional(' group by formpgto');
    tbMovCaixa.Select(['sum(vrmovi) as vrmovi', 'formpgto']);

    if tbMovCaixa.Find('formpgto', DEBITO) then
      edtDebitoCalc.Value := tbMovCaixa.GetVal('vrmovi')
    else
      edtDebitoCalc.Value := 0;

    if tbMovCaixa.Find('formpgto', CREDITO) then
      edtCreditoCalc.Value := tbMovCaixa.GetVal('vrmovi')
    else
      edtCreditoCalc.Value := 0;

    edtVendasConf.Value := edtVendasCalc.Value;
    edtSangriaConf.Value := edtSangriaCalc.Value;
    edtRetiradasConf.Value := edtRetiradasCalc.Value;
    edtEntradaConf.Value := edtEntradaCalc.Value;
    edtDebitoConf.Value := edtDebitoCalc.Value;
    edtCreditoConf.Value := edtCreditoCalc.Value;
    FidCaixa := IdCaixa;
  finally
    FreeAndNil(tbMovCaixa);
  end;
end;

end.

