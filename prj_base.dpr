program prj_base;

uses
  Forms,
  main_base in 'main_base.pas' {frmMainBase},
  login_base in 'login\login_base.pas' {frmLoginBase},
  pdv in 'app\pdv\pdv.pas' {frmPDV: TFrame},
  lib_interface in 'vlib\lib_interface.pas',
  lib_mensagem in 'vlib\lib_mensagem.pas',
  lib_vmsis in 'vlib\lib_vmsis.pas',
  libframes in 'vlib\libframes.pas',
  uvPadraoFrame in 'vlib\vComponents\uvPadraoFrame.pas' {vPadraoFrame: TFrame},
  uvVisaoFrame in 'vlib\vComponents\uvVisaoFrame.pas' {vVisaoFrame: TFrame},
  uvCadastroFrame in 'vlib\vComponents\uvCadastroFrame.pas' {vCadastroFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMainBase, frmMainBase);
  frmLoginBase := TfrmLoginBase.Create(nil);
  frmLoginBase.ShowModal;
  if frmLoginBase.GetLogado then begin
     frmLoginBase.Release;
     Application.Run;
  end;
end.
