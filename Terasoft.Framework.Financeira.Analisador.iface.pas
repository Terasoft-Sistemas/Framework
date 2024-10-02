
{$i Credipar.inc}

unit Terasoft.Framework.Financeira.Analisador.iface;

interface
  uses
    Classes,
    Terasoft.Framework.Texto,
    SysUtils,
    Spring.Collections,
    Terasoft.Framework.DB,
    Terasoft.Framework.ControleAlteracoes,
    Terasoft.Framework.Types;

  type
    IFinanceira = interface;

    IFinanceiraConfig = interface
    ['{56619AF9-FB62-426C-B39A-94027E3D8592}']
    //property token getter/setter
      function getToken: TipoWideStringFramework;
      procedure setToken(const pValue: TipoWideStringFramework);

    //property modoProducao getter/setter
      function getModoProducao: boolean;
      procedure setModoProducao(const pValue: boolean);

    //property urlWS getter/setter
      function getUrlWS: TipoWideStringFramework;
      procedure setUrlWS(const pValue: TipoWideStringFramework);

    //property codLojaCred getter/setter
      function getCodigoLojaFinanceira: Integer;
      procedure setCodigoLojaFinanceira(const pValue: Integer);

    //property codigoProdutoCredipar getter/setter
      function getCodigoProdutoFinanceira: Integer;
      procedure setCodigoProdutoFinanceira(const pValue: Integer);

      function getDiretorioArquivos: tipoWideStringFramework;
      procedure setDiretorioArquivos(const pValue: tipoWideStringFramework);

    //property controleAlteracoes getter/setter
      function getControleAlteracoes: IControleAlteracoes;
      procedure setControleAlteracoes(const pValue: IControleAlteracoes);

    //property filial getter/setter
      function getFilial: TipoWideStringFramework;
      procedure setFilial(const pValue: TipoWideStringFramework);

    //property propriedades getter/setter
      function getPropriedades: IPropriedade;
      procedure setPropriedades(const pValue: IPropriedade);

    //property codigoLojista getter/setter
      function getCodigoLojista: TipoWideStringFramework;
      procedure setCodigoLojista(const pValue: TipoWideStringFramework);

    //property usuario getter/setter
      function getUsuario: TipoWideStringFramework;
      procedure setUsuario(const pValue: TipoWideStringFramework);

    //property responsavel getter/setter
      function getResponsavel: TipoWideStringFramework;
      procedure setResponsavel(const pValue: TipoWideStringFramework);

      property responsavel: TipoWideStringFramework read getResponsavel write setResponsavel;
      property usuario: TipoWideStringFramework read getUsuario write setUsuario;
      property codigoLojista: TipoWideStringFramework read getCodigoLojista write setCodigoLojista;
      property propriedades: IPropriedade read getPropriedades write setPropriedades;
      property filial: TipoWideStringFramework read getFilial write setFilial;
      property controleAlteracoes: IControleAlteracoes read getControleAlteracoes write setControleAlteracoes;
      property diretorioArquivos: tipoWideStringFramework read getDiretorioArquivos write setDiretorioArquivos;
      property codigoProdutoFinanceira: Integer read getCodigoProdutoFinanceira write setCodigoProdutoFinanceira;
      property codigoLojaFinanceira: Integer read getCodigoLojaFinanceira write setCodigoLojaFinanceira;
      property urlWS: TipoWideStringFramework read getUrlWS write setUrlWS;
      property token: TipoWideStringFramework read getToken write setToken;
      property modoProducao: boolean read getModoProducao write setModoProducao;


    end;


    IFinanceiraSimulacao = interface
    ['{73A996FC-A303-4D8A-B9B4-29E76E687D45}']
    //property data getter/setter
      function getData: TDate;
      procedure setData(const pValue: TDate);

    //property resultado getter/setter
      function getResultado: IREsultadoOperacao;
      procedure setResultado(const pValue: IREsultadoOperacao);

    //property valorCompra getter/setter
      function getValorCompra: Extended;
      procedure setValorCompra(const pValue: Extended);

    //property valorEntrada getter/setter
      function getValorEntrada: Extended;
      procedure setValorEntrada(const pValue: Extended);

    //property parcelas getter/setter
      function getParcelas: Integer;
      procedure setParcelas(const pValue: Integer);

    //property vencimento getter/setter
      function getVencimento: TDate;
      procedure setVencimento(const pValue: TDate);

    //property valorParcela getter/setter
      function getValorParcela: Extended;
      procedure setValorParcela(const pValue: Extended);

    //property coeficiente getter/setter
      function getCoeficiente: Extended;
      procedure setCoeficiente(const pValue: Extended);

    //property valorIOF getter/setter
      function getValorIOF: Extended;
      procedure setValorIOF(const pValue: Extended);

    //property valorCET getter/setter
      function getValorCET: Extended;
      procedure setValorCET(const pValue: Extended);

      property valorCET: Extended read getValorCET write setValorCET;
      property valorIOF: Extended read getValorIOF write setValorIOF;
      property coeficiente: Extended read getCoeficiente write setCoeficiente;
      property valorParcela: Extended read getValorParcela write setValorParcela;
      property vencimento: TDate read getVencimento write setVencimento;
      property parcelas: Integer read getParcelas write setParcelas;
      property valorEntrada: Extended read getValorEntrada write setValorEntrada;
      property valorCompra: Extended read getValorCompra write setValorCompra;
      property resultado: IREsultadoOperacao read getResultado write setResultado;
      property data: TDate read getData write setData;
    end;

    IFinanaceira_ConciliacaoItem = interface
    ['{31A850DB-1286-4BE0-B47D-BE4DF4295FA7}']
    //property data getter/setter
      function getData: TDate;
      procedure setData(const pValue: TDate);

    //property dados getter/setter
      function getDados: TipoWideStringFramework;
      procedure setDados(const pValue: TipoWideStringFramework);

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property contrato getter/setter
      function getContrato: TipoWideStringFramework;
      procedure setContrato(const pValue: TipoWideStringFramework);

    //property valor_credito getter/setter
      function getValor_credito: Extended;
      procedure setValor_credito(const pValue: Extended);

    //property cliente_nome getter/setter
      function getCliente_nome: TipoWideStringFramework;
      procedure setCliente_nome(const pValue: TipoWideStringFramework);

      property cliente_nome: TipoWideStringFramework read getCliente_nome write setCliente_nome;
    //property cpf getter/setter
      function getCpf: TipoWideStringFramework;
      procedure setCpf(const pValue: TipoWideStringFramework);

    //property banco getter/setter
      function getBanco: TipoWideStringFramework;
      procedure setBanco(const pValue: TipoWideStringFramework);

    //property agencia getter/setter
      function getAgencia: TipoWideStringFramework;
      procedure setAgencia(const pValue: TipoWideStringFramework);

    //property cc getter/setter
      function getCc: TipoWideStringFramework;
      procedure setCc(const pValue: TipoWideStringFramework);

    //property previsao getter/setter
      function getPrevisao: TDate;
      procedure setPrevisao(const pValue: TDate);

    //property codigoLoja getter/setter
      function getCodigoLoja: Integer;
      procedure setCodigoLoja(const pValue: Integer);

    //property proposta getter/setter
      function getProposta: TipoWideStringFramework;
      procedure setProposta(const pValue: TipoWideStringFramework);

    //property valorTotal getter/setter
      function getValorTotal: Extended;
      procedure setValorTotal(const pValue: Extended);

    //property valorRetencao getter/setter
      function getValorRetencao: Extended;
      procedure setValorRetencao(const pValue: Extended);

      property valorRetencao: Extended read getValorRetencao write setValorRetencao;
      property valorTotal: Extended read getValorTotal write setValorTotal;
      property proposta: TipoWideStringFramework read getProposta write setProposta;
      property codigoLoja: Integer read getCodigoLoja write setCodigoLoja;
      property previsao: TDate read getPrevisao write setPrevisao;
      property cc: TipoWideStringFramework read getCc write setCc;
      property agencia: TipoWideStringFramework read getAgencia write setAgencia;
      property banco: TipoWideStringFramework read getBanco write setBanco;
      property cpf: TipoWideStringFramework read getCpf write setCpf;
      property valor_credito: Extended read getValor_credito write setValor_credito;
      property contrato: TipoWideStringFramework read getContrato write setContrato;
      property resultado: IResultadoOperacao read getResultado write setResultado;
      property dados: TipoWideStringFramework read getDados write setDados;
      property data: TDate read getData write setData;
    end;

    TListaItemsConciliacao = IList<IFinanaceira_ConciliacaoItem>;

    IFinanaceira_Conciliacao = interface
    ['{0FA526FE-6E60-4EA2-8B93-E48A84561560}']
    //property data getter/setter
      function getData: TDate;
      procedure setData(const pValue: TDate);

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property dados getter/setter
      function getDados: TipoWideStringFramework;
      procedure setDados(const pValue: TipoWideStringFramework);

    //property items getter/setter
      function getItems: TListaItemsConciliacao;
      procedure setItems(const pValue: TListaItemsConciliacao);

      property items: TListaItemsConciliacao read getItems write setItems;
      property dados: TipoWideStringFramework read getDados write setDados;
      property resultado: IResultadoOperacao read getResultado write setResultado;
      property data: TDate read getData write setData;
    end;

    IFinanceira_PessoaFisica = interface
    ['{B2D41380-46B9-4937-B8BE-926813959765}']
      function critica(pResultado: IResultadoOperacao): boolean;
      function getAddr: Pointer;
      function loadFromPathReaderWriter(const pPathRW: IUnknown; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    end;

    IFinanceira_Proposta = interface
    ['{7BFA61DA-E339-44BB-9AE1-BCDD55FBDF47}']

      function critica(pResultado: IResultadoOperacao): boolean;
      function getAddr: Pointer;
      function loadFromPathReaderWriter(const pPathRW: IUnknown; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

    //property id getter/setter
      function getId: Int64;
      procedure setId(const pValue: Int64);

    //property filial getter/setter
      function getFilial: TipoWideStringFramework;
      procedure setFilial(const pValue: TipoWideStringFramework);

      property filial: TipoWideStringFramework read getFilial write setFilial;
      property id: Int64 read getId write setId;
    end;

    IFinanceira = interface
    ['{0CFD13E2-C178-4365-8B39-44C573D1FB4A}']

      function getAddr: Pointer;

    //property nome getter/setter
      function getNome: TipoWideStringFramework;

    //property config getter/setter
      function getConfig: IFinanceiraConfig;

      function critica(pResultado: IResultadoOperacao=nil): boolean;

      function simulacao(vlrCompra: Extended; VlrEntrada: Extended; qtdParcela: Integer; dtPriVcto: TDate; pResultado: IResultadoOperacao=nil): IFinanceiraSimulacao;
      function corrigeproposta(pResultado: IResultadoOperacao=nil): IResultadoOperacao;

    //property proposta getter/setter
      function getProposta: IFinanceira_Proposta;
      procedure setProposta(const pValue: IFinanceira_Proposta);

      function getNovaProposta: IFinanceira_Proposta;

    //property pessoaFisica getter/setter
      function getPessoaFisica: IFinanceira_PessoaFisica;
      procedure setPessoaFisica(const pValue: IFinanceira_PessoaFisica);

      function getStatusProposta(const pID: Int64): TipoWideStringFramework;
      procedure setStatusProposta(const pID: Int64; const pStatus: TipoWideStringFramework );

      function enviaProposta(pResultado: IResultadoOperacao=nil): IResultadoOperacao;

      property pessoaFisica: IFinanceira_PessoaFisica read getPessoaFisica write setPessoaFisica;
      property proposta: IFinanceira_Proposta read getProposta write setProposta;

      property config: IFinanceiraConfig read getConfig;
      property nome: TipoWideStringFramework read getNome;
    end;

    ICredipar = interface(IFinanceira)
    ['{5E234CAB-1B84-42F7-A94E-5F76F58B7901}']
      function getAddr: Pointer;

      function cancelarProposta(pID: Int64; pMotivo: TipoWideStringFramework ; pResultado: IResultadoOperacao=nil): IResultadoOperacao;
      function statusProposta(pID: Int64; pResultado: IResultadoOperacao=nil): IResultadoOperacao;
      function anexarDocumentoAnalise(pProposta: Int64; pTipoDocumento: TipoWideStringFramework; pFormatoArquivo: TipoWideStringFramework; pDados: TBytes; pResultado: IResultadoOperacao=nil): IResultadoOperacao;
      function anexarDocumentoProcessamento(pProposta: Int64; pTipoDocumento: TipoWideStringFramework; pFormatoArquivo: TipoWideStringFramework; pDados: TBytes; pResultado: IResultadoOperacao=nil): IResultadoOperacao;
      function statusProcessamento(pProposta: Int64; pResultado: IResultadoOperacao=nil): IResultadoOperacao;
      function conciliacao(pData: TDate; pResultado: IResultadoOperacao=nil): IFinanaceira_Conciliacao;
      function boleto(pProposta: Int64; pResultado: IResultadoOperacao=nil): IResultadoOperacao;

    end;

  ITopOne = interface(IFinanceira)
  ['{4039606F-8D52-4849-888C-0A0E6E37FBD5}']

      //function test(pResultado: IResultadoOperacao=nil): IResultadoOperacao;

  end;

  {$if not defined(__DLL__)}
    function getTopOne(pFilial: TipoWideStringFramework; pGDB: IGDB): ITopOne;


    function getCredipar(pFilial: TipoWideStringFramework; pGDB: IGDB): ICredipar;
    function carregaPedidoFinanceira(const pID: Int64; pFinanceira: IFinanceira; pGDB: IGDB; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function enviaPropostaFinanceira(pFinanceira: IFinanceira; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function getCrediparFilial(const pFilial: TipoWideStringFramework; pGDB: IGDB): ICredipar;
    function preValidarPropostaCredipar(const pID: Int64; pGDB: IGDB=nil; pResultado: IResultadoOperacao=nil):IResultadoOperacao;
  {$ifend}

  function getSimulacaoFinanceiraIface:IFinanceiraSimulacao;


implementation
  uses
    strUtils,
    Terasoft.Framework.Conversoes,
    Terasoft.Framework.Validacoes,
    FuncoesConfig, Terasoft.Framework.Financeira.Analisador.iface.Consts;

  type
    TFinanceiraSimulacaoImpl = class(TInterfacedObject, IFinanceiraSimulacao)
    protected
      fData: TDate;
      fResultado: IREsultadoOperacao;
      fValorCompra: Extended;
      fValorEntrada: Extended;
      fParcelas: Integer;
      fVencimento: TDate;
      fValorParcela: Extended;
      fCoeficiente: Extended;
      fValorIOF: Extended;
      fValorCET: Extended;

    //property valorCET getter/setter
      function getValorCET: Extended;
      procedure setValorCET(const pValue: Extended);

    //property valorIOF getter/setter
      function getValorIOF: Extended;
      procedure setValorIOF(const pValue: Extended);

    //property coeficiente getter/setter
      function getCoeficiente: Extended;
      procedure setCoeficiente(const pValue: Extended);

    //property valorParcela getter/setter
      function getValorParcela: Extended;
      procedure setValorParcela(const pValue: Extended);

    //property vencimento getter/setter
      function getVencimento: TDate;
      procedure setVencimento(const pValue: TDate);

    //property parcelas getter/setter
      function getParcelas: Integer;
      procedure setParcelas(const pValue: Integer);

    //property valorEntrada getter/setter
      function getValorEntrada: Extended;
      procedure setValorEntrada(const pValue: Extended);

    //property valorCompra getter/setter
      function getValorCompra: Extended;
      procedure setValorCompra(const pValue: Extended);

    //property resultado getter/setter
      function getResultado: IREsultadoOperacao;
      procedure setResultado(const pValue: IREsultadoOperacao);

    //property data getter/setter
      function getData: TDate;
      procedure setData(const pValue: TDate);
    end;


function getSimulacaoFinanceiraIface:IFinanceiraSimulacao;
begin
  Result := TFinanceiraSimulacaoImpl.Create;
end;

{ TFinanceiraSimulacaoImpl }

procedure TFinanceiraSimulacaoImpl.setValorCET(const pValue: Extended);
begin
  fValorCET := pValue;
end;

function TFinanceiraSimulacaoImpl.getValorCET: Extended;
begin
  Result := fValorCET;
end;

procedure TFinanceiraSimulacaoImpl.setValorIOF(const pValue: Extended);
begin
  fValorIOF := pValue;
end;

function TFinanceiraSimulacaoImpl.getValorIOF: Extended;
begin
  Result := fValorIOF;
end;

procedure TFinanceiraSimulacaoImpl.setCoeficiente(const pValue: Extended);
begin
  fCoeficiente := pValue;
end;

function TFinanceiraSimulacaoImpl.getCoeficiente: Extended;
begin
  Result := fCoeficiente;
end;

procedure TFinanceiraSimulacaoImpl.setValorParcela(const pValue: Extended);
begin
  fValorParcela := pValue;
end;

function TFinanceiraSimulacaoImpl.getValorParcela: Extended;
begin
  Result := fValorParcela;
end;

procedure TFinanceiraSimulacaoImpl.setVencimento(const pValue: TDate);
begin
  fVencimento := pValue;
end;

function TFinanceiraSimulacaoImpl.getVencimento: TDate;
begin
  Result := fVencimento;
end;

procedure TFinanceiraSimulacaoImpl.setParcelas(const pValue: Integer);
begin
  fParcelas := pValue;
end;

function TFinanceiraSimulacaoImpl.getParcelas: Integer;
begin
  Result := fParcelas;
end;

procedure TFinanceiraSimulacaoImpl.setValorEntrada(const pValue: Extended);
begin
  fValorEntrada := pValue;
end;

function TFinanceiraSimulacaoImpl.getValorEntrada: Extended;
begin
  Result := fValorEntrada;
end;

procedure TFinanceiraSimulacaoImpl.setValorCompra(const pValue: Extended);
begin
  fValorCompra := pValue;
end;

function TFinanceiraSimulacaoImpl.getValorCompra: Extended;
begin
  Result := fValorCompra;
end;

procedure TFinanceiraSimulacaoImpl.setResultado(const pValue: IREsultadoOperacao);
begin
  fResultado := pValue;
end;

function TFinanceiraSimulacaoImpl.getResultado: IREsultadoOperacao;
begin
  Result := fResultado;
end;

procedure TFinanceiraSimulacaoImpl.setData(const pValue: TDate);
begin
  fData := pValue;
end;

function TFinanceiraSimulacaoImpl.getData: TDate;
begin
  Result := fData;
end;

{$if not defined(__DLL__)}

    function createCredipar: ICredipar; stdcall; external 'Credipar_DLL' name 'createCredipar' delayed;
    function createTopOne: ITopOne; stdcall; external 'TopOne_DLL' name 'createTopOne' delayed;

function getTopOne;
  var
    cfg: ITagConfig;
begin
  Result := createTopOne;
  if(pGDB=nil) then
    pGDB := gdbPadrao;
  if(pGDB<>nil) then
  begin
    cfg := novoTagConfig(pGDB);
    Result.config.propriedades.propriedade['GDB'].asInterface := pGDB;
    Result.config.urlWS := cfg.ValorTagConfig(tagConfig_TOPONE_ENDERECO_ENDPOINT,'',tvString);
    Result.config.modoProducao := false;
    Result.config.diretorioArquivos := cfg.ValorTagConfig(tagConfig_TOPONE_DIRETORIO_ARQUIVOS,'',tvString);
    Result.config.usuario := cfg.ValorTagConfig(tagConfig_TOPONE_USUARIO_ENDPOINT,'',tvString);
    Result.config.token := cfg.ValorTagConfig(tagConfig_TOPONE_SENHA_ENDPOINT,'',tvString);
    //Result.config.codigoProdutoFinanceira := cfg.ValorTagConfig(tagConfig_CREDIPAR_PRODUTO,0,tvInteiro);
    Result.config.controleAlteracoes := criaControleAlteracoes(FINANCEIRA_TOPONE_NOME,pGDB,true);
    //Result.config.codigoLojista := cfg.ValorTagConfig(tagConfig_CREDIPAR_CODIGO_LOJISTA,0,tvString);
    Result.config.filial := pFilial;
  end;
end;

function getCredipar;//: ICredipar;
  var
    cfg: ITagConfig;
begin
  Result := createCredipar;
  if(pGDB=nil) then
    pGDB := gdbPadrao;
  if(pGDB<>nil) then
  begin
    cfg := novoTagConfig(pGDB);
    Result.config.propriedades.propriedade['GDB'].asInterface := pGDB;
    Result.config.urlWS := cfg.ValorTagConfig(tagConfig_CREDIPAR_ENDERECO_WS,'',tvString);
    Result.config.modoProducao := true;
    Result.config.diretorioArquivos := cfg.ValorTagConfig(tagConfig_CREDIPAR_DIRETORIO_ARQUIVOS,'',tvString);
    Result.config.token := cfg.ValorTagConfig(tagConfig_CREDIPAR_TOKEN,'',tvString);
    Result.config.codigoLojaFinanceira := cfg.ValorTagConfig(tagConfig_CREDIPAR_CODIGO_LOJA,0,tvInteiro);
    Result.config.codigoProdutoFinanceira := cfg.ValorTagConfig(tagConfig_CREDIPAR_PRODUTO,0,tvInteiro);
    Result.config.controleAlteracoes := criaControleAlteracoes(FINANCEIRA_CREDIPAR_NOME,pGDB,true);
    Result.config.codigoLojista := cfg.ValorTagConfig(tagConfig_CREDIPAR_CODIGO_LOJISTA,0,tvString);
    Result.config.filial := pFilial;
  end;
end;

function carregaPedidoFinanceira(const pID: Int64; pFinanceira: IFinanceira; pGDB: IGDB; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  var
    lDSCliente,lDSProposta: IDataset;
    indice: Integer;
    maiorValor,valor: Extended;
begin
  Result := checkResultadoOperacao(pResultado);

  if(pGDB=nil) then
  begin
    pGDB := gdbPadrao;
    if(pGDB=nil) then
    begin
      pResultado.adicionaErro('carregaPedidoCredipar: Banco de dados não fornecido.');
      exit;
    end;
  end;

  if(pFinanceira=nil) then
    pFinanceira :=  getCredipar('', pGDB);

  pResultado.propriedade['financeira'].asInterface := pFinanceira;

  lDSProposta := pGDB.criaDataset;
  lDSProposta.query(
    'select'+#13+
       '    w.id proposta,'+#13+
       '    i.valor_unitario * i.quantidade vlitem,'+#13+
       '    w.cliente_id,'+#13+
       '    -- ''0'' loja, este está em TAG'+#13+
       '    w.CODIGO_PRODUTO_FINANCIAMENTO codProdutoCredipar, --Criado'+#13+
       '    w.VALOR_FINANCIADO valor_total,'+#13+
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

  lDSCliente := pGDB.criaDataset;
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
       '    c.celular_cli,'+#13+
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
       '    c.funcaotrabalho_cli ocupacao,'+#13+
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
       '    c.nome_contador_cli as CONTADOR_TRABALHO_CLI,'+#13+
       '    c.telefone_contador_cli as telefone_CONTADOR_TRABALHO_CLI,'+#13+
       '    ''000'' as ramal_CONTADOR_TRABALHO_CLI,'+#13+
       '    c.CPF_CONJUGE_CLI,  --Criado'+#13+
       '    c.DOCIDENTIFICACAOCONJ_CLI, --Criado'+#13+
       '    c.TIPODOCIDENTIFICACAOCONJ_CLI, --Criado'+#13+
       '    /*'+#13+
       '      1-RG'+#13+
       '      2-CNH'+#13+
       '      3-CTPS'+#13+
       '      4-CARTEIRA CONSELHO CLASSE'+#13+
       '      5-RNE (REGISTRO NACIONAL DE ESTRANGEIRO'+#13+
       '      6-PASSAPORTE'+#13+
       '      7-CERTIFICADO RESERVISTA'+#13+
       '    */'+#13+
       '    c.SALARIOCON_CLI'+#13+
       ' from'+#13+
       '    clientes c'+#13+
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

  pFinanceira.pessoaFisica.loadFromPathReaderWriter(lDSCliente,pResultado);
  pFinanceira.proposta.loadFromPathReaderWriter(lDSProposta,pResultado);

  pFinanceira.corrigeproposta(pResultado);

end;

function enviaPropostaFinanceira(pFinanceira: IFinanceira; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  var
    save: Integer;
begin
  Result := checkResultadoOperacao(pResultado);

  save := pResultado.erros;
  if(pFinanceira=nil) then
  begin
    pResultado.adicionaErro('enviaPropostaFinanceira: Interface FINANCEIRA não fornecida.');
    exit;
  end;

  pResultado := pFinanceira.enviaProposta(pResultado);

  //if(pResultado.erros<>save) then exit;

end;

  var
    gListaFilialCredipar: IDictionary<TipoWideStringFramework, ICredipar>;

function getCrediparFilial;//(const pFilial: TipoWideStringFramework): ICredipar;
begin
  Result := nil;
  if(pFilial='') then
    exit;
  if(gListaFilialCredipar=nil) then
    gListaFilialCredipar := TCollections.CreateDictionary<TipoWideStringFramework, ICredipar>;

  if not gListaFilialCredipar.TryGetValue(pFilial,Result) then
  begin
    Result := getCredipar(pFilial,pGDB);
    gListaFilialCredipar.AddOrSetValue(pFilial,Result);
  end;
end;

function preValidarPropostaCredipar;
  var
    save: Integer;
    dsWeb,dsCliente: IDataset;
begin
  Result := checkResultadoOperacao(pResultado);
  save := pResultado.erros;
  validaRegraTabela(FINANCEIRA_CREDIPAR_NOME,'web_pedido','id',[pID],pGDB,pResultado);
  if supports(pResultado.propriedade['dataset'].asInterface,IDataset,dsWeb) then
  begin
    validaRegraTabela(FINANCEIRA_CREDIPAR_NOME,'clientes','CODIGO_CLI',[dsWeb.dataset.FieldByName('cliente_id').AsString],pGDB,pResultado);
    validaRegraTabela(FINANCEIRA_CREDIPAR_NOME,'WEB_PEDIDOITENS','WEB_PEDIDO_ID',[pID],pGDB,pResultado);
  end;
end;


{$ifend}

end.
