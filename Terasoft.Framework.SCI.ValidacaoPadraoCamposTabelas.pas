
{$i definicoes.inc}

unit Terasoft.Framework.SCI.ValidacaoPadraoCamposTabelas;

interface
  uses
    Terasoft.Framework.DB,
    Terasoft.Framework.Types;

  procedure registraValidacaoPadraoCamposTabelas(pGDB: IGDB);

implementation
  uses
    Terasoft.Framework.Credipar.Analisador.iface.Consts,
    Terasoft.Framework.Log,
    strUtils,SysUtils,Classes,
    Terasoft.Framework.Texto,
    Terasoft.Framework.Validacoes,
    Terasoft.Framework.OpcoesCamposTabelas;

  const
    {$if defined(AMBIENTE_DESENVOLVIMENTO_NBANTONIO)}
      condicao = false;
    {$else}
      condicao = false;
    {$endif}

procedure registraValidacaoPadraoCamposTabelas(pGDB: IGDB);
  var
    ds: IDataset;
    lTabela: String;
    lCampos,lDelim: IListaTextoEX;
    s1,s2,lCampo,lDescricao: String;
    i: Integer;
    validador: IValidadorDatabase;
begin
  if(usaValidacoesNovas=false) then
    exit;

  if not Supports(pGDB.validador, IValidadorDatabase, validador) then exit;

  try

    logaByTagSeNivel(TAGLOG_VALIDACOES,'Iniciando registro de validações padrão.',LOG_LEVEL_DEBUG);

    with validador do
    begin

      if(opcoesDefaultRegistradas) then
        exit;

      registraOpcoesCampos('null', 'null', '');
      registraOpcoesCampos('notnull', 'notnull', '');
      registraOpcoesCampos('emailvalidoounull', 'null', '');
      registraOpcoesCampos('emailvalidoounull', '<@>', '');
      registraOpcoesCampos('emailvalido', '<@>', '');
      registraOpcoesCampos('cnpjvalido', '<cnpj>', '');
      registraOpcoesCampos('cpfvalido', '<cpf>', '');
      registraOpcoesCampos('cnpjcpfvalido', '<cnpjcpf>', '');
      registraOpcoesCampos('somentenumeros', '<somentenumeros>', '');
      registraOpcoesCampos('naozero', '<naozero>', '');
      registraOpcoesCampos('chavenfe', '<chavenfe>', '');
      registraOpcoesCampos('uf', '<uf>', '');
      registraOpcoesCampos('imei', '<imei>', '');


      //registraValidacaoCampoTabela('','clientes','CNPJ_CPF_CLI','notnull','CNPJ/CPF cliente',condicao);
      registraValidacaoCampoTabela('','clientes','FANTASIA_CLI','notnull','Nome do cliente',true);

      registraValidacaoCampoTabela('','clientes','EMAIL_CLI','emailvalidoounull','Email do cliente',condicao);

      registraOpcoesCampos('sexo', 'M', 'Masculino');
      registraOpcoesCampos('sexo', 'F', 'Feminino');
      registraValidacaoCampoTabela('','clientes','SEXO_CLI','sexo','Sexo do cliente',condicao);

      registraOpcoesCampos('escolaridade', '1', 'Analfabeto');
      registraOpcoesCampos('escolaridade', '2', 'Fundamental/Médio');
      registraOpcoesCampos('escolaridade', '3', 'Superior');
      registraValidacaoCampoTabela('','clientes','ESCOLARIDADE_CLI','escolaridade','Grau de instrução do cliente',condicao);


      registraOpcoesCampos('tipopessoa', 'F', 'Física');
      registraOpcoesCampos('tipopessoa', 'J', 'Jurídica');
      registraValidacaoCampoTabela('','clientes','TIPO_CLI','tipopessoa','Tipo do cliente',condicao);

      registraOpcoesCampos('statusgenerico', 'A', 'Ativo');
      registraOpcoesCampos('statusgenerico', 'I', 'Inativo');
      registraValidacaoCampoTabela('','clientes','status','statusgenerico','Status do cliente',condicao);

      registraOpcoesCampos('SEPROCADO', 'S', 'Seprocado');
      registraOpcoesCampos('SEPROCADO', 'F', 'Falecimento');
      registraOpcoesCampos('SEPROCADO', 'C', 'Cartório');
      registraOpcoesCampos('SEPROCADO', 'I', 'Inadimplente');
      registraOpcoesCampos('SEPROCADO', 'N', 'Liberado');
      registraValidacaoCampoTabela('','clientes','SEPROCADO_CLI','SEPROCADO','Situação do cliente',condicao);

      registraOpcoesCampos('estadocivilpessoa', 'C', 'Casado');
      registraOpcoesCampos('estadocivilpessoa', 'S', 'Solteiro');
      registraOpcoesCampos('estadocivilpessoa', 'V', 'Viúvo');
      registraOpcoesCampos('estadocivilpessoa', 'O', 'Outros');
      registraValidacaoCampoTabela('','clientes','ESTADOCIVIL_CLI','estadocivilpessoa','Estado civil do Cliente',condicao);

      registraOpcoesCampos('classificacao', 'A', 'A');
      registraOpcoesCampos('classificacao', 'B', 'B');
      registraOpcoesCampos('classificacao', 'C', 'C');
      registraOpcoesCampos('classificacao', 'D', 'D');
      registraOpcoesCampos('classificacao', 'E', 'E');
      registraValidacaoCampoTabela('','clientes','CLASSIF_CLI','classificacao','Classificação do cliente',condicao);

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
      registraValidacaoCampoTabela('','clientes','TIPO_APURACAO','regimetributario','Regime tributário do cliente',condicao);

      registraOpcoesCampos('tipodocid', '1', 'RG');
      registraOpcoesCampos('tipodocid', '2', 'CNH');
      registraOpcoesCampos('tipodocid', '3', 'CTPS');
      registraOpcoesCampos('tipodocid', '4', 'Carteira Cons. Classe');
      registraOpcoesCampos('tipodocid', '5', 'RNE');
      registraOpcoesCampos('tipodocid', '6', 'Passaporte');
      registraOpcoesCampos('tipodocid', '7', 'Certificado de Reservista');
      registraValidacaoCampoTabela('','clientes','TIPODOC_CLI','tipodocid','Tipo de documento de identificação do cliente',condicao);
      registraValidacaoCampoTabela('','clientes','TIPODOCIDENTIFICACAOCONJ_CLI','tipodocid','Tipo de documento de identificação do cônjuge do cliente',condicao);

      registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE','sexo','Sexo do dependente');
      registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE2','sexo','Sexo do dependente 2');
      registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE3','sexo','Sexo do dependente 3');
      registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE4','sexo','Sexo do dependente 4');
      registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE5','sexo','Sexo do dependente 5');
      registraValidacaoCampoTabela('clientes','SEXO_DEPENDENTE6','sexo','Sexo do dependente 6');

      registraOpcoesCampos('SIMNAO', 'S', 'Sim');
      registraOpcoesCampos('SIMNAO', 'N', 'Não');
      registraValidacaoCampoTabela('','clientes','ENVIA_SMS','SIMNAO','Envia SMS');
      registraValidacaoCampoTabela('','clientes','tela','SIMNAO','Contrato do cliente');

      registraOpcoesCampos('tiposuframa', '2', 'ICMS');
      registraOpcoesCampos('tiposuframa', '3', 'PIS/Cofins');
      registraOpcoesCampos('tiposuframa', '4', 'PIS/Cofins/ICMS');
      registraOpcoesCampos('tiposuframa', '9', 'Sem suframa');
      registraValidacaoCampoTabela('','clientes','TIPO_SUFRAMA','tiposuframa','Tipo SUFRAMA do cliente',condicao);

      registraOpcoesCampos('sexoa', 'M', 'Macho');
      registraOpcoesCampos('sexoa', 'F', 'Fêmea');
      registraValidacaoCampoTabela('','CLIENTES_ANIMAIS','sexo','sexoa','Sexo do animal');

      registraOpcoesCampos('ocupacao', '0','Aposentado');
      registraOpcoesCampos('ocupacao', '1','Pensionista');
      registraOpcoesCampos('ocupacao', '2','Assalariado');
      registraOpcoesCampos('ocupacao', '3','Autônomo');
      registraOpcoesCampos('ocupacao', '4','Liberal');
      registraOpcoesCampos('ocupacao', '5','Proprietário');
      registraOpcoesCampos('ocupacao', '6','Do lar');
      registraOpcoesCampos('ocupacao', '8','Funcionário Público');
      registraOpcoesCampos('ocupacao', '7','Outros');
      registraOpcoesCampos('ocupacao', '9','Auxílio Doença');
      registraValidacaoCampoTabela('','clientes','CODIGO_OCUPACAO_CLI','ocupacao','Ocupação do cliente');


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
      registraValidacaoCampoTabela('','CLIENTES','PARENTESCO_REF1','parentesco','Parentesco do cliente coma a referência 1',condicao);
      registraValidacaoCampoTabela('','CLIENTES','PARENTESCO_REF2','parentesco','Parentesco do cliente coma a referência 2',condicao);

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
      registraValidacaoCampoTabela('','CLIENTES','TEMPO_RESIDENCIA','temporesidencia','Tempo de residência do cliente',condicao);

      registraOpcoesCampos('tiporesidencia', 'PRÓPRIA');
      registraOpcoesCampos('tiporesidencia', 'CEDIDA');
      registraOpcoesCampos('tiporesidencia', 'ALUGADA');
      registraValidacaoCampoTabela('','CLIENTES','TIPO_RESIDENCIA','tiporesidencia','Tipo de residência do cliente',condicao);

      registraOpcoesCampos('regimetrabalho', 'C', 'CLT');
      registraOpcoesCampos('regimetrabúmealho', 'A', 'Autônomo');
      registraOpcoesCampos('regimetrabalho', 'N', 'Outros');
      registraValidacaoCampoTabela('','CLIENTES','REGIME_TRABALHO','regimetrabalho','Regime de trabalho do cliente',condicao);

      registraOpcoesCampos('tipo_funcionario_publico', '1', 'Concursado');
      registraOpcoesCampos('tipo_funcionario_publico', '2', 'Contratado');
      registraOpcoesCampos('tipo_funcionario_publico', '2', 'Comissionado');
      registraValidacaoCampoTabela('','CLIENTES','TIPO_FUNCIONARIO_PUBLICO_CLI','tipo_funcionario_publico','Tipo de Funcionário Público',condicao);

      registraOpcoesCampos('fonte_pagadora_beneficio', '1', 'I.N.S.S.');
      registraOpcoesCampos('fonte_pagadora_beneficio', '2', 'Prefeitura');
      registraOpcoesCampos('fonte_pagadora_beneficio', '3', 'Aeronáutica');
      registraOpcoesCampos('fonte_pagadora_beneficio', '4', 'Exército');
      registraOpcoesCampos('fonte_pagadora_beneficio', '5', 'SIAPE');
      registraOpcoesCampos('fonte_pagadora_beneficio', '6', 'Min. Transp.');
      registraOpcoesCampos('fonte_pagadora_beneficio', '7', 'D.E.R.');
      registraOpcoesCampos('fonte_pagadora_beneficio', '8', 'Governo do Estado');
      registraOpcoesCampos('fonte_pagadora_beneficio', '9', 'Outros');
      registraValidacaoCampoTabela('','CLIENTES','FONTE_BENEFICIO_CLI','fonte_pagadora_beneficio','Fonte Pagadora do benefício do cliente',condicao);

      registraOpcoesCampos('tipoendereco', 'C', 'Cobrança');
      registraOpcoesCampos('tipoendereco', 'E', 'Entrega');
      registraOpcoesCampos('tipoendereco', 'O', 'Outros');
      registraValidacaoCampoTabela('','CLIENTES_ENDERECO','TIPO','tipoendereco','Tipo de endereço do cliente');

      ds := pGDB.criaDataset;
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
            registraValidacaoCampoTabela('',lTabela,lCampo, 'NOTNULL',trim(lDelim.strings.ValueFromIndex[i]),true);
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
    end;

  finally
    validador.opcoesDefaultRegistradas := true;
    logaByTagSeNivel(TAGLOG_VALIDACOES,'Registro de validações padrão finalizado.',LOG_LEVEL_DEBUG);
  end;
end;

procedure doit(const pGDB: IGDB);
begin
  registraValidacaoPadraoCamposTabelas(pGDB);
end;

procedure inicia;
begin
  registraConfiguraValidador(doit);
end;

initialization
  inicia;

end.
