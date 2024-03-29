{$i Logistica.inc}

unit Terasoft.Framework.Logistica;

interface
  uses
    Classes, Terasoft.Framework.Texto,
    Terasoft.Framework.ListaSimples,
    Data.FmtBcd,
    Terasoft.Framework.ControleAlteracoes,
    Terasoft.Framework.DB,
    Terasoft.Framework.Types;

  const
    CONTROLE_LOGISTICA_RESULTADO_VENDA  = 'RESULTADO.VENDA';
    CONTROLE_LOGISTICA_RESULTADO_ENTRADA  = 'RESULTADO.ENTRADA';
    CONTROLE_LOGISTICA_RESULTADO_PRODUTO  = 'RESULTADO.PRODUTO';

    CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO = 'A';
    CONTROLE_LOGISTICA_STATUS_ENVIADO       = 'E';
    CONTROLE_LOGISTICA_STATUS_DIVERGENTE    = 'D';
    CONTROLE_LOGISTICA_STATUS_FINALIZADO    = 'Z';

    CONTROLE_LOGISTICA_STATUS_PRODUTO  = 'PRODUTO.STATUS';
    CONTROLE_LOGISTICA_STATUS_ENTRADA  = 'ENTRADA.STATUS';
    CONTROLE_LOGISTICA_STATUS_VENDA    = 'VENDA.STATUS';

    {
      Interface conhecidas
    }
    CONTROLE_LOGISTICA_NENHUM    = 'N';
    CONTROLE_LOGISTICA_FEDEX     = 'F';


  type
    ILogistica = interface;

    TLogisticaProcessadorArquivoRetorno = reference to function (pUnkAPI: IUnknown; pResultado: IResultadoOperacao): IResultadoOperacao;

    TCriadorLogistica = reference to function (const pCNPJ: TipoWideStringFramework; const pRazaoSocial: TipoWideStringFramework): ILogistica;

    ILogistica = interface
     ['{6F92AC71-F0F6-4AC1-9188-B0C9B9EBD114}']

      procedure setAPI(const pValue: IUnknown);
      function getAPI: IUnknown;

      function getControleAlteracoes: IControleAlteracoes;
      procedure setControleAlteracoes(const pValue: IControleAlteracoes);

      function precisaEnviarProduto(const pCodigoPro: TipoWideStringFramework): boolean;
      function enviaProduto(pID: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function getStatusProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;
      procedure setStatusProduto(const pCodigoPro: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
      function getResultadoProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;

      function precisaEnviarEntrada(const pID: TipoWideStringFramework): boolean;
      function enviaEntrada(pID: String = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function getStatusEntrada(const pID: TipoWideStringFramework): TipoWideStringFramework;
      procedure setStatusEntrada(const pID: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
      function getResultadoEntrada(const pID: TipoWideStringFramework): TipoWideStringFramework;
      function entradaFinalizada(const pID: TipoWideStringFramework): boolean;

      function precisaEnviarVenda(const pNumeroPed: TipoWideStringFramework): boolean;
      function enviaVenda(pNumeroPed: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function getStatusVenda(const pNumeroPed: TipoWideStringFramework): TipoWideStringFramework;
      procedure setStatusVenda(const pNumeroPed: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
      function getResultadoVenda(const pNumeroPed: TipoWideStringFramework): TipoWideStringFramework;
      function vendaFinalizada(const pNumeroPed: TipoWideStringFramework): boolean;

      function processaRetorno(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function processaServico(pResultado: IResultadoOperacao = nil): IResultadoOperacao;

      function getVersao: TipoWideStringFramework;
      function getCompilacao: Int64;

      property api: IUnknown read getAPI write setAPI;

      property versao: TipoWideStringFramework read getVersao;
      property compilacao: Int64 read getCompilacao;

      property conttroleAlteracoes: IControleAlteracoes read getControleAlteracoes write setControleAlteracoes;

    end;

  function logistica_utiizada: String;

  procedure registraLogistica(const pLogistica: TipoWideStringFramework; pCriador: TCriadorLogistica);
  function criaLogistica(pLogistica: TipoWideStringFramework = ''; const pCNPJ: TipoWideStringFramework = ''; const pRazaoSocial: TipoWideStringFramework = ''): ILogistica;

  function getLogisticaGlobal: ILogistica;

  {$if defined(__TESTAR_LOGISTICA__)}
    function testaLogistica_Entrada(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function testaLogisticaVenda(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function testaLogistica_Retorno(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  {$endif}

  function logistica_ProcessaServico(pResultado: IResultadoOperacao): IResultadoOperacao;

  procedure logistica_marcaProdutoParaEnvio(pCodigoPro: TipoWideStringFramework);
  function logistica_EnviaProduto(pCodigoPro: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

  procedure logistica_marcaEntradaParaEnvio(pID: TipoWideStringFramework);
  function logistica_EnviaEntrada(pID: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

  procedure logistica_marcaVendaParaEnvio(pNumeroPed: TipoWideStringFramework);
  function logistica_EnviaVenda(pNumeroPed: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

implementation
  uses
    {$if defined(__AUTOMATIZA_LOGISTICA__)}
      Fedex.SCI.Impl,
      Terasoft.Framework.ProcessoAutomacao,
      Terasoft.Framework.ProcessoAutomacao.consts,
    {$endif}

    {$if defined(__TESTAR_LOGISTICA__)}
      FuncoesMensagem,
    {$endif}
    Spring.Collections,
    Terasoft.Framework.Exceptions,
    FuncoesConfig;

  var
    fListaCriador: IDictionary<TipoWideStringFramework, TCriadorLogistica>;
    fLogisticaGlobal: ILogistica;


function logistica_ProcessaServico;
begin
  Result := getLogisticaGlobal.processaServico(checkResultadoOperacao(pResultado));
end;

procedure logistica_marcaProdutoParaEnvio;
begin
  getLogisticaGlobal.setStatusProduto(pCodigoPro,CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO);
end;

function logistica_EnviaProduto;
begin
  Result := getLogisticaGlobal.enviaProduto(pCodigoPro,checkResultadoOperacao(pResultado));
end;

procedure logistica_marcaEntradaParaEnvio;
begin
  getLogisticaGlobal.setStatusEntrada(pID,CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO);
end;

function logistica_EnviaEntrada;
begin
  Result := getLogisticaGlobal.enviaEntrada(pID,checkResultadoOperacao(pResultado));
end;

procedure logistica_marcaVendaParaEnvio;
begin
  getLogisticaGlobal.setStatusVenda(pNumeroPed,CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO);
end;

function logistica_EnviaVenda;
begin
  Result := getLogisticaGlobal.enviaVenda(pNumeroPed,checkResultadoOperacao(pResultado));
end;

{$if defined(__TESTAR_LOGISTICA__)}
function testaLogistica_Entrada;
begin
  Result := checkResultadoOperacao(pResultado);
  Result := getLogisticaGlobal.enviaEntrada('',Result);
  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;

function testaLogistica_Retorno;
begin
  Result := getLogisticaGlobal.processaRetorno(checkResultadoOperacao(pResultado));
  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;

function testaLogisticaVenda;
begin
  Result := checkResultadoOperacao(pResultado);
  Result := getLogisticaGlobal.enviaVenda('',Result);
  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;
{$endif}

function getLogisticaGlobal: ILogistica;
begin
  if(fLogisticaGlobal=nil) then begin
    fLogisticaGlobal := criaLogistica;
    if(fLogisticaGlobal=nil) then
      raise ENaoImplementado.Create('getLogisticaGlobal: N�o implementado uma interface de log�stica');
  end;
  Result := fLogisticaGlobal;
end;

procedure registraLogistica;
begin
  if(fListaCriador=nil) then
    fListaCriador := TCollections.CreateDictionary<TipoWideStringFramework,TCriadorLogistica>(getComparadorOrdinalTipoWideStringFramework);
  fListaCriador.AddOrSetValue(pLogistica,pCriador);
end;

function criaLogistica;
  var
    p: TCriadorLogistica;
begin
  Result := nil;
  if(pLogistica='') then
    pLogistica := logistica_utiizada;
  if(pLogistica=CONTROLE_LOGISTICA_NENHUM) then
    exit;
  if assigned(fListaCriador) and fListaCriador.TryGetValue(pLogistica,p) then
    Result := p(pCNPJ,pRazaoSocial);
  if(Result=nil) then
    raise ENaoImplementado.CreateFmt('criaLogistica: Log�stica [%s] n�o implementada.', [ pLogistica ]);
end;

function logistica_utiizada: String;
begin
  Result := ValorTagConfig(tagConfig_LOGISTICA,tagConfigcfg_Padrao_LOGISTICA,tvString);
end;

{$if defined(__AUTOMATIZA_LOGISTICA__)}
function _automacao_logistica(const pNome: TipoWideStringFramework; const pParametro: TipoWideStringFramework; const pDadosAdicionais: TipoWideStringFramework; pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  Result := checkResultadoOperacao(pResultado);
  if(logistica_utiizada=CONTROLE_LOGISTICA_NENHUM) then exit;
  Result := logistica_ProcessaServico(pResultado);
end;

initialization
  Terasoft.Framework.ProcessoAutomacao.registraProcessoAutomacao(AUTOMACAO_LOGISTICA,_automacao_logistica);

{$endif}

end.
