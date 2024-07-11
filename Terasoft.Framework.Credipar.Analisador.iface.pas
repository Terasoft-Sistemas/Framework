
{$i Credipar.inc}

unit Terasoft.Framework.Credipar.Analisador.iface;

interface
  uses
    Classes,
    Terasoft.Framework.Texto,
    SysUtils,
    Terasoft.Framework.DB,
    Terasoft.Framework.ControleAlteracoes,
    Terasoft.Framework.Types;

  type

    //ICredipar_PessoaJuridica = interface
    //['{B2D41380-46B9-4937-B8BE-926813959765}']
    //  function loadFromPathReaderWriter(const pPathRW: IPathReaderWriter; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    //end;

    ICredipar_PessoaFisica = interface
    ['{B2D41380-46B9-4937-B8BE-926813959765}']
      function critica(pResultado: IResultadoOperacao): boolean;
      function getAddr: Pointer;
      function loadFromPathReaderWriter(const pPathRW: IUnknown; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    end;

    ICredipar_Proposta = interface
    ['{7BFA61DA-E339-44BB-9AE1-BCDD55FBDF47}']

      function critica(pResultado: IResultadoOperacao): boolean;
      function getAddr: Pointer;
      function loadFromPathReaderWriter(const pPathRW: IUnknown; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

    //property id getter/setter
      function getId: Int64;
      procedure setId(const pValue: Int64);

      property id: Int64 read getId write setId;
    end;

    ICredipar = interface
    ['{5E234CAB-1B84-42F7-A94E-5F76F58B7901}']
    //property proposta getter/setter
      function getAddr: Pointer;

      function getProposta: ICredipar_Proposta;
      procedure setProposta(const pValue: ICredipar_Proposta);

      function getNovaProposta: ICredipar_Proposta;

      function critica(pResultado: IResultadoOperacao): boolean;

    //property pessoaFisica getter/setter
      function getPessoaFisica: ICredipar_PessoaFisica;
      procedure setPessoaFisica(const pValue: ICredipar_PessoaFisica);

      function enviaProposta(pResultado: IResultadoOperacao=nil): IResultadoOperacao;
      function cancelarProposta(pProposta: Int64; pMotivo: TipoWideStringFramework ; pResultado: IResultadoOperacao=nil): IResultadoOperacao;
      function statusProposta(pProposta: Int64; pResultado: IResultadoOperacao=nil): IResultadoOperacao;
      function anexarDocumentoAnalise(pProposta: Int64; pTipoDocumento: TipoWideStringFramework; pFormatoArquivo: TipoWideStringFramework; pDados: TBytes; pResultado: IResultadoOperacao=nil): IResultadoOperacao;

      function getDiretorioArquivos: tipoWideStringFramework;
      procedure setDiretorioArquivos(const pValue: tipoWideStringFramework);

    //property modoProducao getter/setter
      function getModoProducao: boolean;
      procedure setModoProducao(const pValue: boolean);

    //property urlWS getter/setter
      function getUrlWS: TipoWideStringFramework;
      procedure setUrlWS(const pValue: TipoWideStringFramework);

    //property token getter/setter
      function getToken: TipoWideStringFramework;
      procedure setToken(const pValue: TipoWideStringFramework);

    //property codLojaCred getter/setter
      function getCodigoLojaCredipar: Integer;
      procedure setCodigoLojaCredipar(const pValue: Integer);

    //property codigoProdutoCredipar getter/setter
      function getCodigoProdutoCredipar: Integer;
      procedure setCodigoProdutoCredipar(const pValue: Integer);

      //function editarDados(pDadosCliente, pDadosProposta: IUnknown; pResultado: IResultadoOperacao=nil): IResultadoOperacao;

    //property controleAlteracoes getter/setter
      function getControleAlteracoes: IControleAlteracoes;
      procedure setControleAlteracoes(const pValue: IControleAlteracoes);

      property controleAlteracoes: IControleAlteracoes read getControleAlteracoes write setControleAlteracoes;
      property codigoProdutoCredipar: Integer read getCodigoProdutoCredipar write setCodigoProdutoCredipar;
      property codigoLojaCredipar: Integer read getCodigoLojaCredipar write setCodigoLojaCredipar;
      property token: TipoWideStringFramework read getToken write setToken;
      property urlWS: TipoWideStringFramework read getUrlWS write setUrlWS;
      property modoProducao: boolean read getModoProducao write setModoProducao;
      property diretorioArquivos: tipoWideStringFramework read getDiretorioArquivos write setDiretorioArquivos;
      property pessoaFisica: ICredipar_PessoaFisica read getPessoaFisica write setPessoaFisica;
      property proposta: ICredipar_Proposta read getProposta write setProposta;
    end;

  {$if not defined(__DLL__)}
    function createCredipar: ICredipar ; stdcall;
    function getCredipar: ICredipar;
    function carregaPedidoCredipar(const pID: Int64; pCredipar: ICredipar; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function enviaPropostaCredipar(pCredipar: ICredipar; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  {$ifend}



  function _strToTempoResidencia(const pValue: String): String;

implementation
  uses
    strUtils,
    Terasoft.Framework.Conversoes,
    FuncoesConfig, Terasoft.Framework.Credipar.Analisador.iface.Conts;

{$if not defined(__DLL__)}
    function createCredipar: ICredipar; stdcall; external 'Credipar_DLL' name 'createCredipar' delayed;

function getCredipar: ICredipar;
begin
  Result := createCredipar;
  if(gdbPadrao<>nil) then
  begin
    Result.urlWS := ValorTagConfig(tagConfig_CREDIPAR_ENDERECO_WS,'',tvString);
    Result.modoProducao := true;
    Result.diretorioArquivos := ValorTagConfig(tagConfig_CREDIPAR_DIRETORIO_ARQUIVOS,'',tvString);
    Result.token := ValorTagConfig(tagConfig_CREDIPAR_TOKEN,'',tvString);
    Result.codigoLojaCredipar := ValorTagConfig(tagConfig_CREDIPAR_CODIGO_LOJA,0,tvInteiro);
    Result.controleAlteracoes := criaControleAlteracoes(CONTROLEALTERACOES_CREDIPAR,gdbPadrao,true)
  end;
end;

function carregaPedidoCredipar(const pID: Int64; pCredipar: ICredipar; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  var
    lDSCliente,lDSProposta: IDataset;
    indice: Integer;
    maiorValor,valor: Extended;
begin
  Result := checkResultadoOperacao(pResultado);
  if(pCredipar=nil) then
    pCredipar := createCredipar;

  pResultado.propriedade['credipar'].asInterface := pCredipar;

  lDSProposta := gdbPadrao.criaDataset;
  lDSProposta.query(
    'select'+#13+
       '    w.id proposta,'+#13+
       '    i.valor_unitario * i.quantidade vlitem,'+#13+
       '    w.cliente_id,'+#13+
       '    -- ''0'' loja, este está em TAG'+#13+
       '    w.CODIGO_PRODUTO_FINANCIAMENTO codProdutoCredipar, --Criado'+#13+
       '    w.valor_total,'+#13+
       '    w.valor_entrada,'+#13+
       '    w.parcelas,'+#13+
       '    w.data,'+#13+
       '    w.primeiro_vencimento,'+#13+
       '    p.nome_pro'+#13+
       'from'+#13+
       '    web_pedido w'+#13+
       'inner join'+#13+
       '  web_pedidoitens i'+#13+
       '    on'+#13+
       '      i.web_pedido_id = w.id'+#13+
       'inner join'+#13+
       '  produto p'+#13+
       '    on'+#13+
       '      p.codigo_pro = i.produto_id'+#13+
       'inner join'+#13+
       '  clientes c'+#13+
       '    on c.codigo_cli = w.cliente_id'+#13+
       'where'+#13+
       '  w.id=:id'+#13+
       'order by'+#13+
       '  1,2',

    'id',[pID]);
  if(lDSProposta.dataset.RecordCount = 0 ) then
  begin
    pResultado.formataErro('carregaPedidoCredipar: Pedido[%d] não existe.',[pID]);
    exit;
  end;

  lDSCliente := gdbPadrao.criaDataset;
  lDSCliente.query('select'+#13+
     '    c.codigo_cli ID,'+#13+
     '    c.cnpj_cpf_cli,'+#13+
     '    c.fantasia_cli,'+#13+
     '    c.nascimento_cli,'+#13+
     '    c.sexo_cli,'+#13+
     '    c.tipodoc_cli tipodoc, --Criado'+#13+
     '    /*'+#13+
     '      1-RG'+#13+
     '      2-CNH'+#13+
     '      3-CTPS'+#13+
     '      4-Carteira Cons. Classe'+#13+
     '      5- RNE (Registro Nacional de estrangeiro)'+#13+
     '      6-Passaporte'+#13+
     '      7-Certificado Reservista'+#13+
     '    */'+#13+
     '    c.inscricao_rg_cli,'+#13+
     '    c.inscricao_municipal EMISSOR_RG,'+#13+
     '    c.expedicao_rg,'+#13+
     '    case c.estadocivil_cli'+#13+
     '    /*'+#13+
     '      0-Casado'+#13+
     '      1-Solteiro'+#13+
     '      2-Viuvo'+#13+
     '    */'+#13+
     '      when ''C'' then ''0'''+#13+
     '      when ''S'' then ''1'''+#13+
     '      when ''V'' then ''2'''+#13+
     '      else ''9'''+#13+
     '    end as estadocivil_cli,'+#13+
     '    c.mae_cli,'+#13+
     '    c.pai_cli,'+#13+
     '    c.naturalidade_cli,'+#13+
     '    c.uf_naturalidade_cli, --Criado'+#13+
     '    c.ESCOLARIDADE_CLI, --Criado'+#13+
     '    /*'+#13+
     '      1- ANALFABETO'+#13+
     '      2- FUNDAMENTAL/MEDIO'+#13+
     '      3- SUPERIOR'+#13+
     '    */'+#13+
     '    c.telefone_cli,'+#13+
     '    c.cep_cli,'+#13+
     '    c.endereco_cli,'+#13+
     '    c.numero_end,'+#13+
     '    c.complemento,'+#13+
     '    c.bairro_cli,'+#13+
     '    c.cidade_cli,'+#13+
     '    c.uf_cli,'+#13+
     '    c.tempo_residencia,'+#13+
     '/*'+#13+
     '      1- Até 1 ano'+#13+
     '      2- de 1 a 3 anos'+#13+
     '      3- de 3 a 5 anos'+#13+
     '      4- Mais de 5 anos'+#13+
     '      feito função para converter'+#13+
     'function strToTempoResidencia(const pValue: String): Integer;'+#13+
     '  var'+#13+
     '    l: IListaTextoEX;'+#13+
     'begin'+#13+
     '  l := novaListaTextoEx(false,pValue);'+#13+
     '  l.strings.Add(''INV'');              //0'+#13+
     '  l.strings.Add(''MENOS DE UM ANO'');  //1'+#13+
     '  l.strings.Add(''1 ANO'');            //2'+#13+
     '  l.strings.Add(''2 ANOS'');           //3'+#13+
     '  l.strings.Add(''3 ANOS'');           //4'+#13+
     '  l.strings.Add(''4 ANOS'');           //5'+#13+
     '  l.strings.Add(''5 ANOS'');           //6'+#13+
     '  l.strings.Add(''MAIS DE 5 ANOS'');   //7'+#13+
     '  l.strings.Add(''MAIS DE 10 ANOS'');  //8'+#13+
     '  l.strings.Add(''MAIS DE 15 ANOS'');  //9'+#13+
     '  l.strings.Add(''MAIS DE 20 ANOS'');  //10'+#13+
     '  Result := l.strings.IndexOf(uppercase(retiraAcentos(trim(pValue))));'+#13+
     '  if(Result>1) and (Result<5) then'+#13+
     '    Result:=2'+#13+
     '  else if(Result>4) and (Result<7) then'+#13+
     '    Result := 3'+#13+
     '  else if(Result>6) then'+#13+
     '    Result := 4;'+#13+
     'end;'+#13+
     '*/'+#13+
     '    c.tipo_residencia,'+#13+
     '    /*'+#13+
     '      Temos o campo TIPO_RESIDENCIA na tabela, porém ele permite os valores'+#13+
     '          ''PR''#211''PRIA'''+#13+
     '          ''CEDIDA'''+#13+
     '          ''ALUGADA'''+#13+
     '      0- Alugada'+#13+
     '      1- Própria'+#13+
     '      2- Financiada'+#13+
     '      3- Parentes/Pais'+#13+
     '    */'+#13+
     '    c.CODIGO_OCUPACAO_CLI codigo_ocupacao, --criado'+#13+
     '    /*'+#13+
     '        0-APOSENTADO'+#13+
     '        1-PENSIONISTA'+#13+
     '        2-ASSALARIADO'+#13+
     '        3-AUTÔNOMO'+#13+
     '        4-LIBERAL'+#13+
     '        5-PROPRIETÁRIO'+#13+
     '        6-DO LAR'+#13+
     '        8-FUNCIONÁRIO PÚBLICO'+#13+
     '        7-OUTROS'+#13+
     '        9-AUXÍLIO-DOENÇA'+#13+
     '    */'+#13+
     '    c.localtrabalho_cli,'+#13+
     '    o.nome ocupacao,'+#13+
     '    c.trabalho_admissao,'+#13+
     '    c.renda_cli,'+#13+
     '    c.ENDTRABALHO_CLI EnderecoEmp,'+#13+
     '    ''000'' NumeroEmp,'+#13+
     '    '' '' ComplementoEmp,'+#13+
     '    c.BAIRTRABALHO_CLI BairroEmp,'+#13+
     '    c.CIDTRABALHO_CLI CidadeEmp,'+#13+
     '    c.UFTRABALHO_CLI UFEmp,'+#13+
     '    c.CEPTRABALHO_CLI CEPEmp,'+#13+
     '    c.fonetrabalho_cli,'+#13+
     '    c.TIPO_FUNCIONARIO_PUBLICO_CLI tipofuncionariopublico, --Criado'+#13+
     '    /*'+#13+
     '      1- Concursado'+#13+
     '      2-Contratato'+#13+
     '      3-Comissionado'+#13+
     '    */'+#13+
     '    c.NUMBENEFICIO_CLI, --Criado'+#13+
     '    c.FONTE_BENEFICIO_CLI, --Criado'+#13+
     '    /*'+#13+
     '        1-INSS'+#13+
     '        2-PREFEITURA'+#13+
     '        3-AERONÁUTICA'+#13+
     '        4-EXÉRCITO'+#13+
     '        5-SIAPE'+#13+
     '        6-MINISTÉRIO TRANSPORTES'+#13+
     '        7-DEPART ESTRADAS E RODAGENS'+#13+
     '        8-GOVERNO DO ESTADO'+#13+
     '        9-OUTROS'+#13+
     '    */'+#13+
     '    c.CNPJ_trabalho_cli, --Criado'+#13+
     '    ct.nome as CONTADOR_TRABALHO_CLI,'+#13+
     '    ct.telefone as telefone_CONTADOR_TRABALHO_CLI,'+#13+
     '    ''000'' as ramal_CONTADOR_TRABALHO_CLI,'+#13+
     '    c.CPF_CONJUGE_CLI,  --Criado'+#13+
     '    c.DOCIDENTIFICACAOCONJ_CLI, --Criado'+#13+
     '    c.TIPODOCIDENTIFICACAOCONJ_CLI, --Criado'+#13+
     '    c.SALARIOCON_CLI,'+#13+
     '    '' '' TempoConjAno,'+#13+
     '    '' '' TempoConjMes,'+#13+
     '    c.referencia2_cli,'+#13+
     '    c.foneref2_cli,'+#13+
     '    c.referencia3_cli,'+#13+
     '    c.foneref3_cli'+#13+
     'from'+#13+
     '    clientes c'+#13+
     '    left join clientes_ocupacao o on o.id = c.ocupacao_id'+#13+
     '    left join contador ct  on ct.id = c.contador_id'+#13+
     '  where c.codigo_cli = :codigo',
    'codigo',[lDSProposta.dataset.FieldByName('cliente_id').AsString]);

  if(lDSCliente.dataset.RecordCount = 0 ) then
  begin
    pResultado.formataErro('carregaPedidoCredipar: Cliente [%s] do pedido [%d] não existe.',[lDSProposta.dataset.FieldByName('cliente_id').AsString, pID]);
    exit;
  end;
  valor := 0;

  indice:=-1;

  while not lDSProposta.dataset.Eof do
  begin
    valor := lDSProposta.dataset.FieldByName('vlitem').AsExtended;
    if(valor>maiorValor) then
    begin
      maiorValor := valor;
      indice := lDSProposta.dataset.RecNo;
    end;

    lDSProposta.dataset.Next;
  end;
  lDSProposta.dataset.RecNo := indice;

  pCredipar.pessoaFisica.loadFromPathReaderWriter(lDSCliente,pResultado);
  pCredipar.proposta.loadFromPathReaderWriter(lDSProposta,pResultado);

end;

function enviaPropostaCredipar(pCredipar: ICredipar; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  var
    save: Integer;
begin
  Result := checkResultadoOperacao(pResultado);
  save := pResultado.erros;
  if(pCredipar=nil) then
  begin
    pResultado.adicionaErro('enviaPedidoCredipar: Interface CREDIPAR não fornecida.');
    exit;
  end;

  pResultado := pCredipar.enviaProposta(pResultado);

  if(pResultado.erros<>save) then exit;
end;

{$ifend}

function _strToTempoResidencia(const pValue: String): String;
  var
    l: IListaTextoEX;
    i: Integer;
begin
  l := novaListaTextoEx(false,'');
  l.strings.Add('INV');              //0
  l.strings.Add('MENOS DE UM ANO');  //1
  l.strings.Add('1 ANO');            //2
  l.strings.Add('2 ANOS');           //3
  l.strings.Add('3 ANOS');           //4
  l.strings.Add('4 ANOS');           //5
  l.strings.Add('5 ANOS');           //6
  l.strings.Add('MAIS DE 5 ANOS');   //7
  l.strings.Add('MAIS DE 10 ANOS');  //8
  l.strings.Add('MAIS DE 15 ANOS');  //9
  l.strings.Add('MAIS DE 20 ANOS');  //10
  i := l.strings.IndexOf(uppercase(retiraAcentos(trim(pValue))));
  if(i>1) and (i<5) then
    i:=2
  else if(i>4) and (i<7) then
    i := 3
  else if(i>6) then
    i := 4;
  Result := IntToStr(i);
end;

end.
