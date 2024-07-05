
{$i definicoes.inc}

unit Terasoft.Framework.SCI.ValidacaoPadraoCamposTabelas;

interface

  procedure registraValidacaoPadraoCamposTabelas;

implementation
  uses
    Terasoft.Framework.OpcoesCamposTabelas;

procedure registraValidacaoPadraoCamposTabelas;
begin

  registraOpcoesCampoTabela('clientes','STATUS','A','Ativo');
  registraOpcoesCampoTabela('clientes','STATUS','I','Inativo');

  registraOpcoesCampoTabela('clientes','TIPO_CLI','F','Física');
  registraOpcoesCampoTabela('clientes','TIPO_CLI','J','Jurídica');

  registraOpcoesCampoTabela('clientes','ESTADOCIVIL_CLI','C','Casado');
  registraOpcoesCampoTabela('clientes','ESTADOCIVIL_CLI','S','Solteiro');
  registraOpcoesCampoTabela('clientes','ESTADOCIVIL_CLI','V','Viúvo');
  registraOpcoesCampoTabela('clientes','ESTADOCIVIL_CLI','O','Outros');

end;

end.
