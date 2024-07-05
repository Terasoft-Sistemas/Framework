
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

  registraOpcoesCampoTabela('clientes','TIPO_CLI','F','F�sica');
  registraOpcoesCampoTabela('clientes','TIPO_CLI','J','Jur�dica');

  registraOpcoesCampoTabela('clientes','ESTADOCIVIL_CLI','C','Casado');
  registraOpcoesCampoTabela('clientes','ESTADOCIVIL_CLI','S','Solteiro');
  registraOpcoesCampoTabela('clientes','ESTADOCIVIL_CLI','V','Vi�vo');
  registraOpcoesCampoTabela('clientes','ESTADOCIVIL_CLI','O','Outros');

end;

end.
