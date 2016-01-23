unit lib_cadastros_iniciais;

interface

uses Windows, Messages, SysUtils;

  type
     TCadastrosIniciais = class(TObject)
     private
       FDataPadrao: TDateTime;
       procedure AddEmpresa;
       procedure AddPaises;
       procedure AddEstados;
       procedure AddCidade;
       procedure AddAbairro;
       procedure AddFuncionario;
       procedure AddCaixa;
       procedure AddAlmoxarifado;
       procedure AddUnidade;
       procedure AddParametrosSincronizacao;
     public
       FidEmpresa : Integer;
       FidPais : Integer;
       FidEstado : Integer;
       FIdCidade : Integer;
       FidBairro : Integer;
       FidAlmoxarifado : Integer;
       FidUnidade : Integer;
       FIdFuncionario : Integer;
       Fusuario : String;
       FNomeEmpresa : String;
       FNomeUnidade : String;
       procedure Executar;
     end;
implementation

uses lib_acesso, lib_db, Classes;

{ TCadastrosIniciais }


procedure TCadastrosIniciais.AddAbairro;
var
  tbBairro : TObjetoDB;
begin
  tbBairro := TObjetoDB.create('bairro');
  try
//    tbBairro.AddParametro('empresa_id', FidEmpresa);
    tbBairro.AddParametro('cdbairro', '1');

    tbBairro.Select(['id']);

    if not tbBairro.IsEmpty then
    begin
      FidBairro := tbBairro.GetVal('id');
      Exit;
    end;

    tbBairro.AddParametro('nmbairro', 'JARDIM VIT”RIA');
    tbBairro.AddParametro('dtcadastro', FDataPadrao);
 //   tbBairro.AddParametro('pais_id', FidPais);
//    tbBairro.AddParametro('estado_id', FidEstado);
    tbBairro.AddParametro('cidade_id', FIdCidade);
    tbBairro.Insert;

    tbBairro.Select(['id']);
    FidBairro := tbBairro.GetVal('id');
  finally
    FreeAndNil(tbBairro);
  end

end;

procedure TCadastrosIniciais.AddAlmoxarifado;
  var
    tbAlmoxarifado : TObjetoDB;
begin
  tbAlmoxarifado := TObjetoDB.create('Almoxarifado');
  try
    tbAlmoxarifado.AddParametro('nmalmoxa', 'Almoxarifado padr„o');
    tbAlmoxarifado.Select(['id']);

    if tbAlmoxarifado.IsEmpty then
    begin
      tbAlmoxarifado.AddParametro('dtcadastro', FDataPadrao);
      tbAlmoxarifado.Insert;
      tbAlmoxarifado.Select(['id']);
      FidAlmoxarifado := tbAlmoxarifado.GetVal('id');
      Exit;
    end;

    FidAlmoxarifado := tbAlmoxarifado.GetVal('id');

  finally
    FreeAndNil(tbAlmoxarifado);
  end;
end;

procedure TCadastrosIniciais.AddCaixa;
var
  tbCaixa : TObjetoDB;
begin
  tbCaixa := TObjetoDB.create('caixa');
  try
    tbCaixa.Select(['id']);
    if tbCaixa.IsEmpty then
    begin
      tbCaixa.AddParametro('nmcaixa', 'CAIXA');
      tbCaixa.Insert;
    end;
  finally
    FreeAndNil(tbCaixa);
  end;

end;

procedure TCadastrosIniciais.AddCidade;
var
  tbCidade : TObjetoDB;
begin
  tbCidade := TObjetoDB.create('cidade');
  try
//    tbCidade.AddParametro('empresa_id', FidEmpresa);
    tbCidade.AddParametro('cdcidade', '1');

    tbCidade.Select(['id']);

    if not tbCidade.IsEmpty then
    begin
      FIdCidade := tbCidade.GetVal('id');
      Exit;
    end;

    tbCidade.AddParametro('nmcidade', 'BELO HORIZONTE');
    tbCidade.AddParametro('dtcadastro', FDataPadrao);
    tbCidade.AddParametro('pais_id', FidPais);
    tbCidade.AddParametro('estado_id', FidEstado);
    tbCidade.Insert;

    tbCidade.Select(['id']);
    FIdCidade := tbCidade.GetVal('id');
  finally
    FreeAndNil(tbCidade);
  end

end;

procedure TCadastrosIniciais.AddEmpresa;
var
  tbEmpresa : TObjetoDB;
begin
  tbEmpresa := TObjetoDB.create('empresa');
  try
    tbEmpresa.AddParametro('codigo', '01');

    tbEmpresa.Select(['id', 'nmempresa']);

    if not tbEmpresa.IsEmpty then
    begin
      FidEmpresa := tbEmpresa.GetVal('id');
      FNomeEmpresa := tbEmpresa.GetVal('nmempresa');
      Exit;
    end;

    tbEmpresa.AddParametro('nmempresa', 'Empresa Padraoç');
    tbEmpresa.AddParametro('dtcadastro', FDataPadrao);
    tbEmpresa.Insert;

    tbEmpresa.Select(['id']);
    FidEmpresa := tbEmpresa.GetVal('id');
    FNomeEmpresa := 'Empresa Padr„o';
  finally
    FreeAndNil(tbEmpresa);
  end
end;

procedure TCadastrosIniciais.AddEstados;
var
  tbEstado : TObjetoDB;
begin
  tbEstado := TObjetoDB.create('estado');
  try
//    tbEstado.AddParametro('empresa_id', FidEmpresa);
    tbEstado.AddParametro('cdestado', '31');

    tbEstado.Select(['id']);

    if not tbEstado.IsEmpty then
    begin
      FidEstado := tbEstado.GetVal('id');
      Exit;
    end;

    tbEstado.AddParametro('dtcadastro', FDataPadrao);
    tbEstado.AddParametro('nmestado', 'MINAS GERAIS');
    tbEstado.AddParametro('sgestado', 'MG');
    tbEstado.AddParametro('pais_id', FidPais);
    tbEstado.AddParametro('dsregiao', 'SUDESTE');        
    tbEstado.Insert;

    tbEstado.Select(['id']);
    FidEstado := tbEstado.GetVal('id');

  finally
    FreeAndNil(tbEstado);
  end;

end;

procedure TCadastrosIniciais.AddFuncionario;
var
  tbFunc : TobjetoDB;
begin
  tbFunc := TObjetoDB.create('funcionario');
  try

    tbFunc.AddParametro('usuario', 'vmsismaster');

    tbFunc.Select(['id', 'usuario']);
    if not tbFunc.IsEmpty then
    begin
      FIdFuncionario := tbFunc.GetVal('id');
      Fusuario := tbFunc.GetVal('usuario');
      Exit;
    end;

//    tbFunc.AddParametro('empresa_id', FidEmpresa);
    tbFunc.AddParametro('dtcadastro', FDataPadrao);
    tbFunc.AddParametro('nome', 'vmsismaster');
    tbFunc.AddParametro('sexo', 'M');
    tbFunc.AddParametro('dtnascimento', FDataPadrao);
    tbFunc.AddParametro('email', 'vmsis@vmsis.com.br');
    tbFunc.AddParametro('senha', 'masterVMSIS123v');
    tbFunc.AddParametro('confsenha', 'masterVMSIS123v');
//    tbFunc.AddParametro('endereco', 'RUA 1');
//    tbFunc.AddParametro('numero', '1');
//    tbFunc.AddParametro('complemento', 'SEM COMPLEMENTO');
//    tbFunc.AddParametro('cep', '31300000');
//    tbFunc.AddParametro('pais_id', FidPais);
//    tbFunc.AddParametro('estado_id', FidEstado);
//    tbFunc.AddParametro('cidade_id', FIdCidade);
//    tbFunc.AddParametro('bairro_id', FidBairro);
//    tbFunc.AddParametro('dtadmissao', FDataPadrao);
    tbFunc.AddParametro('pessoa', 'J');
    tbFunc.Insert;

    tbFunc.Select(['id', 'usuario']);
    FIdFuncionario := tbFunc.GetVal('id');
    Fusuario := tbFunc.GetVal('usuario');
  finally
    FreeAndNil(tbFunc);
  end;
end;

procedure TCadastrosIniciais.AddPaises;
var
  tbPais : TObjetoDB;
begin
  tbPais := TObjetoDB.create('pais');
  try
//    tbPais.AddParametro('empresa_id', FidEmpresa);
    tbPais.AddParametro('cdpais', '0055');

    tbPais.Select(['id']);

    if not tbPais.IsEmpty then
    begin
      FidPais := tbPais.GetVal('id');
      Exit;
    end;

    tbPais.AddParametro('dtcadastro', FDataPadrao);
    tbPais.AddParametro('nmpais', 'BRASIL');
    tbPais.Insert;

    tbPais.Select(['id']);
    FidPais := tbPais.GetVal('id');

  finally
    FreeAndNil(tbPais);
  end;

end;

procedure TCadastrosIniciais.AddParametrosSincronizacao;
var
  tbParametrosSincronizacao: TObjetoDB;
begin
  tbParametrosSincronizacao:= TObjetoDB.create('ParametrosSincronizacao');
  try
    tbParametrosSincronizacao.Select(['id']);
    if tbParametrosSincronizacao.IsEmpty then
    begin
      //http://177.153.20.166
      tbParametrosSincronizacao.AddParametro('IpSincronizacao', 'http://127.0.0.1:8000');
      tbParametrosSincronizacao.Insert;
    end;
  finally
    FreeAndNil(tbParametrosSincronizacao);
  end;
end;

procedure TCadastrosIniciais.AddUnidade;
var
  tbUnidade : TObjetoDB;
begin
  tbUnidade := TObjetoDB.create('Unidade');
  try
    tbUnidade.AddParametro('nmrazao', 'UNIDADE PADR√O');
    tbUnidade.Select(['id', 'nmrazao']);
    if tbUnidade.IsEmpty then
    begin
      tbUnidade.AddParametro('nmfantasia', 'UNIDADE PADR√O');
      tbUnidade.AddParametro('almoxpedido_id', FidAlmoxarifado);
      tbUnidade.Insert;
      tbUnidade.Select(['id', 'nmrazao']);
      FidUnidade := tbUnidade.GetVal('id');
      FNomeUnidade := tbUnidade.GetVal('nmrazao');
      Exit;
    end;
    FidUnidade := tbUnidade.GetVal('id');
    FNomeUnidade := tbUnidade.GetVal('nmrazao');   

  finally
    FreeAndNil(tbUnidade);
  end;
end;

procedure TCadastrosIniciais.Executar;
var
  UsrAce : TAcessoUsuario;
begin
   FDataPadrao:= Date;
   AddEmpresa;
//   AddPaises;
//   AddEstados;
//   AddCidade;
//   AddAbairro;
//   AddFuncionario;
   AddAlmoxarifado;
   AddUnidade;
   AddCaixa;
   AddParametrosSincronizacao;
   TAcesso.AddRotinas;

{   UsrAce := TAcessoUsuario.create(Fusuario);
   try
     UsrAce.AddPermissao('gaveta', TpmProcessar);
   finally
     FreeAndNil(UsrAce);
   end}

end;

end.
