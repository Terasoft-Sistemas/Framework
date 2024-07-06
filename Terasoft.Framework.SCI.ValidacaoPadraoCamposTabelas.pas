
{$i definicoes.inc}

unit Terasoft.Framework.SCI.ValidacaoPadraoCamposTabelas;

interface

  procedure registraValidacaoPadraoCamposTabelas;

implementation
  uses
    Terasoft.Framework.OpcoesCamposTabelas;

procedure registraValidacaoPadraoCamposTabelas;
begin
  registraOpcoesCampos('null', 'null', '');
  registraOpcoesCampos('notnull', 'notnull', '');

  registraValidacaoCampoTabela('clientes','CNPJ_CPF_CLI','notnull','CNPJ/CPF cliente',true);

  registraOpcoesCampos('statusgenerico', 'A', 'Ativo');
  registraOpcoesCampos('statusgenerico', 'I', 'Inativo');
  registraValidacaoCampoTabela('clientes','status','statusgenerico','Status do cliente');

  registraOpcoesCampos('tipopessoa', 'F', 'F�sica');
  registraOpcoesCampos('tipopessoa', 'J', 'Jur�dica');
  registraValidacaoCampoTabela('clientes','TIPO_CLI','tipopessoa','Tipo do cliente');

  registraOpcoesCampos('estadocivilpessoa', 'C', 'Casado');
  registraOpcoesCampos('estadocivilpessoa', 'S', 'Solteiro');
  registraOpcoesCampos('estadocivilpessoa', 'V', 'Vi�vo');
  registraOpcoesCampos('estadocivilpessoa', 'O', 'Outros');
  registraValidacaoCampoTabela('clientes','ESTADOCIVIL_CLI','estadocivilpessoa','Estado civil do Cliente');



{  //OLD
  registraOpcoesCampoTabelaOld('clientes','STATUS','A','Ativo');
  registraOpcoesCampoTabelaOld('clientes','STATUS','I','Inativo');

  registraOpcoesCampoTabelaOld('clientes','TIPO_CLI','F','F�sica');
  registraOpcoesCampoTabelaOld('clientes','TIPO_CLI','J','Jur�dica');

  registraOpcoesCampoTabelaOld('clientes','ESTADOCIVIL_CLI','C','Casado');
  registraOpcoesCampoTabelaOld('clientes','ESTADOCIVIL_CLI','S','Solteiro');
  registraOpcoesCampoTabelaOld('clientes','ESTADOCIVIL_CLI','V','Vi�vo');
  registraOpcoesCampoTabelaOld('clientes','ESTADOCIVIL_CLI','O','Outros');
}

  gOpcoesDefaultRegistradas := true;
end;

end.
