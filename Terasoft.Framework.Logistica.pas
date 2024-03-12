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
    CONTROLE_LOGISTICA_RESULTADO_SO  = 'RESULTADO.SO';
    CONTROLE_LOGISTICA_RESULTADO_PO  = 'RESULTADO.PO';
    CONTROLE_LOGISTICA_RESULTADO_SKU  = 'RESULTADO.SKU';

    CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO = 'A';
    CONTROLE_LOGISTICA_STATUS_ENVIADO       = 'E';
    CONTROLE_LOGISTICA_STATUS_DIVERGENTE    = 'D';
    CONTROLE_LOGISTICA_STATUS_FINALIZADO    = 'Z';

    CONTROLE_LOGISTICA_NENHUM    = 'N';
    CONTROLE_LOGISTICA_FEDEX     = 'F';

  type
    ILogistica = interface;

    TLogisticaProcessadorArquivoRetorno = reference to function (pUnkAPI: IUnknown; pResultado: IResultadoOperacao): IResultadoOperacao;

    TCriadorLogistica = reference to function (const pCNPJ: TipoWideStringFramework; const pRazaoSocial: TipoWideStringFramework): ILogistica;

    ILogistica = interface
     ['{6F92AC71-F0F6-4AC1-9188-B0C9B9EBD114}']

      function enviaVenda(pNumeroPed: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function enviaEntrada(pID: String = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function processaRetorno(pResultado: IResultadoOperacao = nil): IResultadoOperacao;

      procedure setAPI(const pValue: IUnknown);
      function getAPI: IUnknown;

      function precisaEnviarProduto(const pCodigoPro: TipoWideStringFramework): boolean;
      function getStatusProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;
      procedure setStatusProduto(const pCodigoPro: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
      function getResultadoProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;

      function precisaEnviarEntrada(const pID: TipoWideStringFramework): boolean;
      function getStatusEntrada(const pID: TipoWideStringFramework): TipoWideStringFramework;
      procedure setStatusEntrada(const pID: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
      function getResultadoEntrada(const pID: TipoWideStringFramework): TipoWideStringFramework;
      function entradaFinalizada(const pID: TipoWideStringFramework): boolean;

      function precisaEnviarVenda(const pNumeroPed: TipoWideStringFramework): boolean;
      function getStatusVenda(const pNumeroPed: TipoWideStringFramework): TipoWideStringFramework;
      procedure setStatusVenda(const pNumeroPed: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
      function getResultadoVenda(const pNumeroPed: TipoWideStringFramework): TipoWideStringFramework;
      function vendaFinalizada(const pNumeroPed: TipoWideStringFramework): boolean;

      //procedure setProcessador(pInterface: TipoWideStringFramework; pProcessador: TLogisticaProcessadorArquivoRetorno);
      //function getProcessador(pInterface: TipoWideStringFramework): TLogisticaProcessadorArquivoRetorno;

      //function processaRetorno(pProcessador: TLogisticaProcessadorArquivoRetorno; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

      function getVersao: TipoWideStringFramework;
      function getCompilacao: Int64;

      function getControleAlteracoes: IControleAlteracoes;
      procedure setControleAlteracoes(const pValue: IControleAlteracoes);

      property api: IUnknown read getAPI write setAPI;

      property versao: TipoWideStringFramework read getVersao;
      property compilacao: Int64 read getCompilacao;

      property conttroleAlteracoes: IControleAlteracoes read getControleAlteracoes write setControleAlteracoes;

    end;

  function sci_logistica_utiizada: String;
  function sci_logistica_usa_fedex: boolean;

  procedure registraLogistica(const pLogistica: TipoWideStringFramework; pCriador: TCriadorLogistica);
  function criaLogistica(pLogistica: TipoWideStringFramework = ''; const pCNPJ: TipoWideStringFramework = ''; const pRazaoSocial: TipoWideStringFramework = ''): ILogistica;

  function getLogisticaGlobal: ILogistica;

implementation
  uses
    Spring.Collections,
    Terasoft.Framework.Exceptions,
    FuncoesConfig;

  var
    fListaCriador: IDictionary<TipoWideStringFramework, TCriadorLogistica>;
    fLogisticaGlobal: ILogistica;

function getLogisticaGlobal: ILogistica;
begin
  if(fLogisticaGlobal=nil) then
    fLogisticaGlobal := criaLogistica;
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
    pLogistica := sci_logistica_utiizada;
  if(pLogistica=CONTROLE_LOGISTICA_NENHUM) then
    exit;
  if assigned(fListaCriador) and fListaCriador.TryGetValue(pLogistica,p) then
    Result := p(pCNPJ,pRazaoSocial)
  else
    raise ENaoImplementado.CreateFmt('criaLogistica: Logística [%s] não implementada.', [ pLogistica ]);
end;

function sci_logistica_utiizada: String;
begin
  Result := ValorTagConfig(tagConfig_LOGISTICA,tagConfigcfg_Padrao_LOGISTICA,tvString);
end;

function sci_logistica_usa_fedex: boolean;
begin
  Result := sci_logistica_utiizada = CONTROLE_LOGISTICA_FEDEX;
end;

end.
