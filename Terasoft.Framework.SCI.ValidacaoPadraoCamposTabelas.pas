
{$i definicoes.inc}

unit Terasoft.Framework.SCI.ValidacaoPadraoCamposTabelas;

interface
  uses
    Terasoft.Framework.Types;

  procedure registraValidacaoPadraoCamposTabelas;

implementation
  uses
    Terasoft.Framework.Credipar.Analisador.iface.Conts,
    Terasoft.Framework.Log,
    strUtils,SysUtils,Classes,
    Terasoft.Framework.Texto,
    Terasoft.Framework.DB,
    Terasoft.Framework.Validacoes,
    Terasoft.Framework.OpcoesCamposTabelas;

  const
    {$if defined(AMBIENTE_DESENVOLVIMENTO_NBANTONIO)}
      condicao = true;
    {$else}
      condicao = false;
    {$endif}

procedure registraValidacaoPadraoCamposTabelas;
  var
    ds: IDataset;
    lTabela: String;
    lCampos,lDelim: IListaTextoEX;
    s1,s2,lCampo,lDescricao: String;
    i: Integer;
begin
  if(gOpcoesDefaultRegistradas) then
    exit;
  try
    if(usaValidacoesNovas=false) then
      exit;

    logaByTagSeNivel(TAGLOG_VALIDACOES,'Iniciando registro de validações padrão.',LOG_LEVEL_DEBUG);

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
    registraValidacaoCampoTabela('clientes','SEXO_CLI','sexo','Sexo do cliente',true);

    registraOpcoesCampos('escolaridade', '1', 'Analfabeto');
    registraOpcoesCampos('escolaridade', '2', 'Fundamental/Médio');
    registraOpcoesCampos('escolaridade', '3', 'Superior');
    registraValidacaoCampoTabela('clientes','ESCOLARIDADE_CLI','escolaridade','Grau de instrução do cliente');


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

    registraOpcoesCampos('estadocivilpessoa', 'C', 'Casado');
    registraOpcoesCampos('estadocivilpessoa', 'S', 'Solteiro');
    registraOpcoesCampos('estadocivilpessoa', 'V', 'Viúvo');
    registraOpcoesCampos('estadocivilpessoa', 'O', 'Outros');
    registraValidacaoCampoTabela('clientes','ESTADOCIVIL_CLI','estadocivilpessoa','Estado civil do Cliente',true);

    registraOpcoesCampos('classificacao', 'A', 'A');
    registraOpcoesCampos('classificacao', 'B', 'B');
    registraOpcoesCampos('classificacao', 'C', 'C');
    registraOpcoesCampos('classificacao', 'D', 'D');
    registraOpcoesCampos('classificacao', 'E', 'E');
    registraValidacaoCampoTabela('clientes','CLASSIF_CLI','classificacao','Classificação do cliente',condicao);

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
    registraValidacaoCampoTabela('clientes','TIPO_APURACAO','regimetributario','Regime tributário do cliente',condicao);

    registraOpcoesCampos('tipodocid', '1', 'RG');
    registraOpcoesCampos('tipodocid', '2', 'CNH');
    registraOpcoesCampos('tipodocid', '3', 'CTPS');
    registraOpcoesCampos('tipodocid', '4', 'Carteira Cons. Classe');
    registraOpcoesCampos('tipodocid', '5', 'RNE');
    registraOpcoesCampos('tipodocid', '6', 'Passaporte');
    registraOpcoesCampos('tipodocid', '7', 'Certificado de Reservista');
    registraValidacaoCampoTabela('clientes','TIPODOC_CLI','tipodocid','Tipo de documento de identificação do cliente',condicao);

    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE','sexo','Sexo do dependente');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE2','sexo','Sexo do dependente 2');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE3','sexo','Sexo do dependente 3');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE4','sexo','Sexo do dependente 4');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE5','sexo','Sexo do dependente 5');
    registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE6','sexo','Sexo do dependente 6');

    registraOpcoesCampos('SIMNAO', 'S', 'Sim');
    registraOpcoesCampos('SIMNAO', 'N', 'Não');
    registraValidacaoCampoTabela('clientes','ENVIA_SMS','SIMNAO','Envia SMS');
    registraValidacaoCampoTabela('clientes','tela','SIMNAO','Contrato do cliente');

    registraOpcoesCampos('tiposuframa', '2', 'ICMS');
    registraOpcoesCampos('tiposuframa', '3', 'PIS/Cofins');
    registraOpcoesCampos('tiposuframa', '4', 'PIS/Cofins/ICMS');
    registraOpcoesCampos('tiposuframa', '9', 'Sem suframa');
    registraValidacaoCampoTabela('clientes','TIPO_SUFRAMA','tiposuframa','Tipo SUFRAMA do cliente',condicao);

    registraOpcoesCampos('sexoa', 'M', 'Macho');
    registraOpcoesCampos('sexoa', 'F', 'Fêmea');
    registraValidacaoCampoTabela('CLIENTES_ANIMAIS','sexo','sexoa','Sexo do animal');

    registraOpcoesCampos('parentesco', 'PAI');
    registraOpcoesCampos('parentesco', 'MÃE');
    registraOpcoesCampos('parentesco', 'FILHO');
    registraOpcoesCampos('parentesco', 'FILHA');
    registraOpcoesCampos('parentesco', 'MARIDO');
    registraOpcoesCampos('parentesco', 'ESPOSA');
    registraOpcoesCampos('parentesco', 'AVÔ');
    registraOpcoesCampos('parentesco', 'AVÓ');
    registraOpcoesCampos('parentesco', 'NETO');
    registraOpcoesCampos('parentesco', 'NETA');
    registraOpcoesCampos('parentesco', 'SOBRINHO');
    registraOpcoesCampos('parentesco', 'SOBRINHA');
    registraOpcoesCampos('parentesco', 'TIO');
    registraOpcoesCampos('parentesco', 'TIA');
    registraOpcoesCampos('parentesco', 'IRMÃO');
    registraOpcoesCampos('parentesco', 'IRMÃ');
    registraOpcoesCampos('parentesco', 'CUNHADO');
    registraOpcoesCampos('parentesco', 'CUNHADA');
    registraOpcoesCampos('parentesco', 'PRIMO');
    registraOpcoesCampos('parentesco', 'PRIMA');
    registraOpcoesCampos('parentesco', 'SOGRO');
    registraOpcoesCampos('parentesco', 'SOGRA');
    registraOpcoesCampos('parentesco', 'GENRO');
    registraOpcoesCampos('parentesco', 'NORA');
    registraValidacaoCampoTabela('CLIENTES','PARENTESCO_REF1','parentesco','Parentesco do cliente coma a referência 1');
    registraValidacaoCampoTabela('CLIENTES','PARENTESCO_REF2','parentesco','Parentesco do cliente coma a referência 2');

    registraOpcoesCampos('temporesidencia', 'MENOS DE UM ANO');
    registraOpcoesCampos('temporesidencia', '1 ANO');
    registraOpcoesCampos('temporesidencia', '2 ANOS');
    registraOpcoesCampos('temporesidencia', '3 ANOS');
    registraOpcoesCampos('temporesidencia', '2 ANOS');
    registraOpcoesCampos('temporesidencia', '3 ANOS');
    registraOpcoesCampos('temporesidencia', '4 ANOS');
    registraOpcoesCampos('temporesidencia', '5 ANOS');
    registraOpcoesCampos('temporesidencia', 'MAIS DE 5 ANOS');
    registraOpcoesCampos('temporesidencia', 'MAIS DE 10 ANOS');
    registraOpcoesCampos('temporesidencia', 'MAIS DE 15 ANOS');
    registraOpcoesCampos('temporesidencia', 'MAIS DE 20 ANOS');
    registraValidacaoCampoTabela('CLIENTES','TEMPO_RESIDENCIA','temporesidencia','Tempo de residência do cliente');

    registraOpcoesCampos('tiporesidencia', 'PRÓPRIA');
    registraOpcoesCampos('tiporesidencia', 'CEDIDA');
    registraOpcoesCampos('tiporesidencia', 'ALUGADA');
    registraValidacaoCampoTabela('CLIENTES','TIPO_RESIDENCIA','tiporesidencia','Tipo de residência do cliente');

    registraOpcoesCampos('regimetrabalho', 'CLT');
    registraOpcoesCampos('regimetrabalho', 'Autônomo');
    registraOpcoesCampos('regimetrabalho', 'Outros');
    registraValidacaoCampoTabela('CLIENTES','REGIME_TRABALHO','regimetrabalho','Regime de trabalho do cliente');

    registraOpcoesCampos('tipoendereco', 'C', 'Cobrança');
    registraOpcoesCampos('tipoendereco', 'E', 'Entrega');
    registraOpcoesCampos('tipoendereco', 'O', 'Outros');
    registraValidacaoCampoTabela('CLIENTES_ENDERECO','TIPO','tipoendereco','Tipo de endereço do cliente');

    ds := gdbPadrao.criaDataset;
    ds.query(
        'select'+#13+
           '    c.*'+#13+
           'from'+#13+
           '    configuracoes c'+#13+
           'where'+#13+
           '    c.tag'+#13+
           'like'+#13+
           '    ''CAMPOS_OBRIGATORIO_%''',
        '',[] );

    lCampos := novaListaTexto;
    lDelim := novaListaTexto;
    while not ds.dataset.Eof do
    begin
      lTabela:=trim(stringReplace(ds.dataset.FieldByName('tag').AsString,'CAMPOS_OBRIGATORIO_','',[rfReplaceAll,rfIgnoreCase]));
      lCampos.text := StringReplace(trim(ds.dataset.FieldByName('valormemo').AsString),';','=',[rfReplaceAll]);
      for s1 in lCampos do
      begin
        lDelim.text := s1;
        i := lDelim.strings.Count;
        while i > 0 do
        begin
          dec(i);
          lCampo := trim(lDelim.strings.Names[i]);
          if(lCampo = '') then
          begin
            lCampo := trim(lDelim.strings.Strings[i]);
            if(lCampo='') then continue;
          end;
          registraValidacaoCampoTabela(lTabela,lCampo, 'NOTNULL',trim(lDelim.strings.ValueFromIndex[i]),true);
        end;
      end;


      ds.dataset.Next;
    end;

    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_CCB, 'CCB');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_INFPESSOAL, 'Informação Pessoal');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_COMPRESIDENCIA, 'Comprovante de residência');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_COMPRENDA, 'Comprovante de renda');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_COMPRENDA, 'Comprovante de renda');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_EXPCREDITO, 'Experiência de Crédito');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_CARTABACEN, 'Carta BACEN');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_CONSREGIONAL, 'Conselho Regional');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_CONTRATOSOCIAL, 'Contrato Social');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_IR, 'Declaração de Imposto de Renda');
    registraOpcoesCampos('credipar_tipodoc_analise', CREDIPAR_TIPODOC_OUTROS, 'Outros');

  finally
    gOpcoesDefaultRegistradas := true;
    logaByTagSeNivel(TAGLOG_VALIDACOES,'Registro de validações padrão finalizado.',LOG_LEVEL_DEBUG);
  end;
end;

procedure doit(const pGDB: IGDB);
begin
  registraValidacaoPadraoCamposTabelas;
end;

initialization
  registraAfterConnectDatabase(doit);

end.
