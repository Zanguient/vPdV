program prj_base;

uses
  Forms,
  SysUtils,
  main_base in 'main_base.pas' {frmMainBase},
  login_base in 'login\login_base.pas' {frmLoginBase},
  pdv in 'app\pdv\pdv.pas' {frmPDV: TFrame},
  lib_interface in 'vlib\lib_interface.pas',
  lib_mensagem in 'vlib\lib_mensagem.pas',
  lib_vmsis in 'vlib\lib_vmsis.pas',
  libframes in 'vlib\libframes.pas',
  uvPadraoFrame in 'vlib\vComponents\uvPadraoFrame.pas' {vPadraoFrame: TFrame},
  uvVisaoFrame in 'vlib\vComponents\uvVisaoFrame.pas' {vVisaoFrame: TFrame},
  uvCadastroFrame in 'vlib\vComponents\uvCadastroFrame.pas' {vCadastroFrame: TFrame},
  uDmConexao in 'vlib\vComponents\uDmConexao.pas' {dmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmConexao, dmConexao);
  frmLoginBase := TfrmLoginBase.Create(Application);
  frmLoginBase.ShowModal;
  try
     if frmLoginBase.GetLogado then
     begin
       FreeAndNil(frmLoginBase);
       Application.CreateForm(TfrmMainBase, frmMainBase);
       Application.Run;
     end;
  finally
    FreeAndNil(frmLoginBase);
    Application.Terminate;
  end
end.




