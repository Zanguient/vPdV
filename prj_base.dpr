program prj_base;

uses
  Forms,
  SysUtils,
  main_base in 'main_base.pas' {frmMainBase},
  login_base in 'login\login_base.pas' {frmLoginBase},
  lib_interface in 'vlib\lib_interface.pas',
  lib_mensagem in 'vlib\lib_mensagem.pas',
  lib_vmsis in 'vlib\lib_vmsis.pas',
  libframes in 'vlib\libframes.pas',
  uvPadraoFrame in 'vlib\vComponents\uvPadraoFrame.pas' {vPadraoFrame: TFrame},
  uDmConexao in 'vlib\vComponents\uDmConexao.pas' {dmConexao: TDataModule},
  pdv_main in 'app\pdv\pdv_main.pas' {frmPDVMain: TFrame},
  lib_modelo_impressao in 'vlib\lib_modelo_impressao.pas',
  uvCadastroClienteFrame in 'app\cadastro\cliente\uvCadastroClienteFrame.pas' {vCadastroClienteFrame: TFrame},
  pdv_pdv in 'app\pdv\pdv_pdv.pas' {frmPDV_PDV},
  pdv_adicional in 'app\pdv\pdv_adicional.pas' {frmAdicional},
  lib_acesso in 'vlib\lib_acesso.pas',
  lib_db in 'vlib\lib_db.pas',
  lib_imagens in 'vlib\lib_imagens.pas' {lb_imagens},
  autenticacao in 'login\autenticacao.pas' {frmAutenticacao},
  lib_cadastros_iniciais in 'vlib\lib_cadastros_iniciais.pas',
  pdv_aberturacaixa in 'app\pdv\pdv_aberturacaixa.pas' {frmAberturaCaixa},
  pdv_abertura_fechamento_caixa in 'app\pdv\pdv_abertura_fechamento_caixa.pas' {frmAberturaFechamentoCaixa},
  uvPadraoCadastroFrame in 'vlib\vComponents\uvPadraoCadastroFrame.pas' {vPadraoCadastro: TFrame},
  lib_sincronizacao in 'vlib\lib_sincronizacao.pas',
  pdv_confirma_qtde_peso in 'app\pdv\pdv_confirma_qtde_peso.pas' {frmConfirmaQtdePeso},
  uvCadastroFornecedorFrame in 'app\cadastro\fornecedor\uvCadastroFornecedorFrame.pas' {vCadastroFornecedorFrame: TFrame},
  lib_tratamentos_sincronizacao in 'vlib\lib_tratamentos_sincronizacao.pas',
  pdv_cancelar_pedido in 'app\pdv\pdv_cancelar_pedido.pas' {vCancelaPedido: TFrame},
  uParametrosSincronizacao in 'app\cadastro\sincronizacao\uParametrosSincronizacao.pas' {ParametrosSincronizacao: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Client PDV VMSis';
  Application.CreateForm(TdmConexao, dmConexao);
  frmLoginBase := TfrmLoginBase.Create(Application);
  frmLoginBase.ShowModal;
  try
     if frmLoginBase.GetLogado then
     begin

       CriarMainForm(frmLoginBase.IdUsuario, frmLoginBase.IdEmpresa, frmLoginBase.IdUnidade,
         frmLoginBase.NomeUsuario, frmLoginBase.NomeEmpresa, frmLoginBase.NomeUnidade);
       FreeAndNil(frmLoginBase);
       Application.Run;
     end;
  finally
    FreeAndNil(frmLoginBase);
    Application.Terminate;
  end
end.





