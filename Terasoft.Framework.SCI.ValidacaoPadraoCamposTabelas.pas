
{$i definicoes.inc}

unit Terasoft.Framework.SCI.ValidacaoPadraoCamposTabelas;

interface

  procedure registraValidacaoPadraoCamposTabelas;

implementation
  uses
    Terasoft.Framework.Validacoes,
    Terasoft.Framework.OpcoesCamposTabelas;

procedure registraValidacaoPadraoCamposTabelas;
begin
  //Opções null e not null
  try
//    if(usaValidacoesNovas=false) then
//      exit;

    registraOpcoesCampos('null', 'null', '');
    registraOpcoesCampos('notnull', 'notnull', '');
    registraOpcoesCampos('emailvalidoounull', 'null', '');
    registraOpcoesCampos('emailvalidoounull', '<@>', '');
    registraOpcoesCampos('emailvalido', '<@>', '');
    registraOpcoesCampos('cnpjvalido', '<cnpj>', '');
    registraOpcoesCampos('cpfvalido', '<cnpj>', '');
    registraOpcoesCampos('cnpjcpfvalido', '<cnpjcpf>', '');
    registraOpcoesCampos('somentenumeros', '<somentenumeros>', '');
    registraOpcoesCampos('chavenfe', '<chavenfe>', '');
    registraOpcoesCampos('uf', '<uf>', '');
    registraOpcoesCampos('imei', '<imei>', '');


    registraValidacaoCampoTabela('clientes','CNPJ_CPF_CLI','notnull','CNPJ/CPF cliente',true);
    registraValidacaoCampoTabela('clientes','FANTASIA_CLI','notnull','Nome do cliente',true);

    registraValidacaoCampoTabela('clientes','EMAIL_CLI','emailvalidoounull','Email do cliente',true);

    registraOpcoesCampos('sexo', 'M', 'Masculino');
    registraOpcoesCampos('sexo', 'F', 'Feminino');
    registraValidacaoCampoTabela('clientes','SEXO_CLI','sexo','Sexo do cliente');

    registraOpcoesCampos('tipopessoa', 'F', 'Física');
    registraOpcoesCampos('tipopessoa', 'J', 'Jurídica');
    registraValidacaoCampoTabela('clientes','TIPO_CLI','tipopessoa','Tipo do cliente',true);

    registraOpcoesCampos('statusgenerico', 'A', 'Ativo');
    registraOpcoesCampos('statusgenerico', 'I', 'Inativo');
    registraValidacaoCampoTabela('clientes','status','statusgenerico','Status do cliente',true);

    registraOpcoesCampos('SEPROCADO', 'S', 'Seprocado');
    registraOpcoesCampos('SEPROCADO', 'F', 'Falecimento');
    registraOpcoesCampos('SEPROCADO', 'C', 'Cartório');
    registraOpcoesCampos('SEPROCADO', 'I', 'Inadimplente');
    registraOpcoesCampos('SEPROCADO', 'N', 'Liberado');
    registraValidacaoCampoTabela('clientes','SEPROCADO_CLI','SEPROCADO','Situação do cliente',true);

    exit;

    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE','sexo','Sexo do dependente');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE2','sexo','Sexo do dependente 2');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE3','sexo','Sexo do dependente 3');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE4','sexo','Sexo do dependente 4');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE5','sexo','Sexo do dependente 5');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE6','sexo','Sexo do dependente 6');

    registraOpcoesCampos('classificacao', 'A', 'A');
    registraOpcoesCampos('classificacao', 'B', 'B');
    registraOpcoesCampos('classificacao', 'C', 'C');
    registraOpcoesCampos('classificacao', 'D', 'D');
    registraOpcoesCampos('classificacao', 'E', 'E');
    registraValidacaoCampoTabela('clientes','CLASSIF_CLI','classificacao','Classificação do cliente');

    registraOpcoesCampos('SIMNAO', 'S', 'Sim');
    registraOpcoesCampos('SIMNAO', 'N', 'Não');
    registraValidacaoCampoTabela('clientes','ENVIA_SMS','SIMNAO','Envia SMS');
    registraValidacaoCampoTabela('clientes','tela','SIMNAO','Contrato do cliente');

    registraOpcoesCampos('estadocivilpessoa', 'C', 'Casado');
    registraOpcoesCampos('estadocivilpessoa', 'S', 'Solteiro');
    registraOpcoesCampos('estadocivilpessoa', 'V', 'Viúvo');
    registraOpcoesCampos('estadocivilpessoa', 'O', 'Outros');
    registraValidacaoCampoTabela('clientes','ESTADOCIVIL_CLI','estadocivilpessoa','Estado civil do Cliente');

    registraOpcoesCampos('regimetributario', '1', 'Lucro Real');
    registraOpcoesCampos('regimetributario', '2', 'Lucro Presumido');
    registraOpcoesCampos('regimetributario', '3', 'Cumulativo');
    registraOpcoesCampos('regimetributario', '4', 'Não cumulativo');
    registraOpcoesCampos('regimetributario', '5', 'Estimativa');
    registraOpcoesCampos('regimetributario', '6', 'Simples');
    registraOpcoesCampos('regimetributario', '9', 'Produtor Rural');
    registraOpcoesCampos('regimetributario', 'O', 'Orgão público estadual');
    registraOpcoesCampos('regimetributario', 'F', 'Órgão público federal');
    registraOpcoesCampos('regimetributario', 'M', 'Micro empreendedor Individual');
    registraValidacaoCampoTabela('clientes','TIPO_APURACAO','regimetributario','Regime tributário do cliente');


    registraOpcoesCampos('tipodocid', '1', 'RG');
    registraOpcoesCampos('tipodocid', '2', 'CNH');
    registraOpcoesCampos('tipodocid', '3', 'CTPS');
    registraOpcoesCampos('tipodocid', '4', 'Carteira Cons. Classe');
    registraOpcoesCampos('tipodocid', '5', 'RNE');
    registraOpcoesCampos('tipodocid', '6', 'Passaporte');
    registraOpcoesCampos('tipodocid', '7', 'Certificado de Reservista');
    registraValidacaoCampoTabela('clientes','TIPODOC_CLI','tipodocid','Tipo de documento de identificação do cliente');


    registraOpcoesCampos('tiposuframa', 'ICMS', '2');
    registraOpcoesCampos('tiposuframa', 'PIS/Cofins', '3');
    registraOpcoesCampos('tiposuframa', 'PIS/Cofins/ICMS', '4');
    registraOpcoesCampos('tiposuframa', 'Sem suframa', '9');
    registraValidacaoCampoTabela('clientes','TIPO_SUFRAMA','tiposuframa','Tipo SUFRAMA do cliente');

    registraOpcoesCampos('sexoa', 'M', 'Macho');
    registraOpcoesCampos('sexoa', 'F', 'Fêmea');
    registraValidacaoCampoTabela('CLIENTES_ANIMAIS','sexo','sexoa','Sexo do animal');

    registraOpcoesCampos('tipoendereco', 'C', 'Cobrança');
    registraOpcoesCampos('tipoendereco', 'E', 'Entrega');
    registraOpcoesCampos('tipoendereco', 'O', 'Outros');
    registraValidacaoCampoTabela('CLIENTES_ENDERECO','TIPO','tipoendereco','Tipo de endereço do cliente');

  finally
    gOpcoesDefaultRegistradas := true;
  end;
end;

end.
