
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

  registraOpcoesCampos('tipopessoa', 'F', 'Física');
  registraOpcoesCampos('tipopessoa', 'J', 'Jurídica');
  registraValidacaoCampoTabela('clientes','TIPO_CLI','tipopessoa','Tipo do cliente');

  registraOpcoesCampos('estadocivilpessoa', 'C', 'Casado');
  registraOpcoesCampos('estadocivilpessoa', 'S', 'Solteiro');
  registraOpcoesCampos('estadocivilpessoa', 'V', 'Viúvo');
  registraOpcoesCampos('estadocivilpessoa', 'O', 'Outros');
  registraValidacaoCampoTabela('clientes','ESTADOCIVIL_CLI','estadocivilpessoa','Estado civil do Cliente');



{  //OLD
  registraOpcoesCampoTabelaOld('clientes','STATUS','A','Ativo');
  registraOpcoesCampoTabelaOld('clientes','STATUS','I','Inativo');

  registraOpcoesCampoTabelaOld('clientes','TIPO_CLI','F','Física');
  registraOpcoesCampoTabelaOld('clientes','TIPO_CLI','J','Jurídica');

  registraOpcoesCampoTabelaOld('clientes','ESTADOCIVIL_CLI','C','Casado');
  registraOpcoesCampoTabelaOld('clientes','ESTADOCIVIL_CLI','S','Solteiro');
  registraOpcoesCampoTabelaOld('clientes','ESTADOCIVIL_CLI','V','Viúvo');
  registraOpcoesCampoTabelaOld('clientes','ESTADOCIVIL_CLI','O','Outros');
}

  gOpcoesDefaultRegistradas := true;
end;

end.
