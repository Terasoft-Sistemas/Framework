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
    CONTROLE_LOGISTICA_RESULTADO_SAIDA      = 'RESULTADO.SAIDA';
    CONTROLE_LOGISTICA_RESULTADO_ENTRADA    = 'RESULTADO.ENTRADA';
    CONTROLE_LOGISTICA_RESULTADO_PRODUTO    = 'RESULTADO.PRODUTO';

    CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO = 'A';
    CONTROLE_LOGISTICA_STATUS_ENVIADO       = 'E';
    CONTROLE_LOGISTICA_STATUS_DIVERGENTE    = 'D';
    CONTROLE_LOGISTICA_STATUS_FINALIZADO    = 'Z';

    CONTROLE_LOGISTICA_STATUS_PRODUTO  = 'PRODUTO.STATUS';
    CONTROLE_LOGISTICA_STATUS_ENTRADA  = 'ENTRADA.STATUS';
    CONTROLE_LOGISTICA_STATUS_SAIDA    = 'SAIDA.STATUS';

    {
      Interface conhecidas
    }
    CONTROLE_LOGISTICA_NENHUM    = 'N';
    CONTROLE_LOGISTICA_FEDEX     = 'F';

    LOGISTICA_TIPOSAIDA_PEDIDO      = 'P';
    LOGISTICA_TIPOSAIDA_SAIDATRANSF = 'T';
    LOGISTICA_TIPOSAIDA_OUTRASSAIDAS= 'O';

    LOGISTICA_TIPOENTRADANORMAL     = 'E'; // envolve tabela ENTRADA
    LOGISTICA_TIPODEVOLUCAOSAIDA    = 'D'; // envolve tabela DEVOLUCAO


    LOGISTTICA_FEDEX             = 'FEDEX';


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

      function precisaEnviarEntrada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): boolean;
      function enviaEntrada(pTipo: TipoWideStringFramework; pNumeroDoc: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function getStatusEntrada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): TipoWideStringFramework;
      procedure setStatusEntrada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
      function getResultadoEntrada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): TipoWideStringFramework;
      function entradaFinalizada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): boolean;

      function precisaEnviarSaida(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): boolean;
      function enviaSaida(pTipo: TipoWideStringFramework; pNumeroDoc: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function getStatusSaida(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): TipoWideStringFramework;
      procedure setStatusSaida(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
      function getResultadoSaida(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): TipoWideStringFramework;
      function saidaFinalizada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): boolean;

      function processaRetorno(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function processaServico(pResultado: IResultadoOperacao = nil): IResultadoOperacao;

      function getVersao: TipoWideStringFramework;
      function getCompilacao: Int64;

      function getName: TipoWideStringFramework;

      property api: IUnknown read getAPI write setAPI;

      property versao: TipoWideStringFramework read getVersao;
      property compilacao: Int64 read getCompilacao;

      property name: TipoWideStringFramework read getName;

      property conttroleAlteracoes: IControleAlteracoes read getControleAlteracoes write setControleAlteracoes;

    end;

  function logistica_utiizada: String;

  procedure registraLogistica(const pLogistica: TipoWideStringFramework; pCriador: TCriadorLogistica);
  function criaLogistica(pLogistica: TipoWideStringFramework = ''; const pCNPJ: TipoWideStringFramework = ''; const pRazaoSocial: TipoWideStringFramework = ''): ILogistica;

  function getLogisticaGlobal: ILogistica;

  {$if defined(__TESTAR_LOGISTICA__)}
    function testaLogistica_Entrada(pTipo: TipoWideStringFramework=''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function testaLogisticaSaida(pTipo: TipoWideStringFramework=''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function testaLogistica_Retorno(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  {$endif}

  function logistica_ProcessaServico(pResultado: IResultadoOperacao): IResultadoOperacao;

  procedure logistica_marcaProdutoParaEnvio(pCodigoPro: TipoWideStringFramework);
  function logistica_EnviaProduto(pCodigoPro: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

  function logistica_EntradaFinalizada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): boolean;
  function logistica_SaidaFinalizada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework; pResultado: IResultadoOperacao = nil ): boolean;

  procedure logistica_marcaEntradaParaEnvio(const pTipo: TipoWideStringFramework; pNumeroDoc: TipoWideStringFramework);
  function logistica_EnviaEntrada(pTipo: TipoWideStringFramework; pID: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

  function logistica_liberaDocumento(pTipo, pNumeroDoc: TipoWideStringFramework; pResultado: IResultadoOperacao=nil):IResultadoOperacao;
  function logistica_travaDocumento(pTipo, pNumeroDoc: TipoWideStringFramework; pResultado: IResultadoOperacao=nil):IResultadoOperacao;

  procedure logistica_marcaSaidaParaEnvio(pTipo, pNumeroDoc: TipoWideStringFramework);
  function logistica_EnviaSaida(pTipo: TipoWideStringFramework; pNumeroPed: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

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
    SysUtils,
    Terasoft.Framework.FuncoesDiversas,
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
  getLogisticaGlobal.setStatusEntrada(pTipo,pNumeroDoc,CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO);
end;

function logistica_EnviaEntrada;
begin
  Result := getLogisticaGlobal.enviaEntrada(pTipo,pID,checkResultadoOperacao(pResultado));
end;

procedure logistica_marcaSaidaParaEnvio;
begin
  getLogisticaGlobal.setStatusSaida(pTipo,pNumeroDoc,CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO);
end;

function logistica_EnviaSaida;
begin
  Result := getLogisticaGlobal.enviaSaida(pTipo, pNumeroPed,checkResultadoOperacao(pResultado));
end;

{$if defined(__TESTAR_LOGISTICA__)}
function testaLogistica_Entrada;
begin
  Result := checkResultadoOperacao(pResultado);
  Result := getLogisticaGlobal.enviaEntrada('','',Result);
  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;

function testaLogistica_Retorno;
begin
  Result := getLogisticaGlobal.processaRetorno(checkResultadoOperacao(pResultado));
  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;

function testaLogisticaSaida;
begin
  Result := checkResultadoOperacao(pResultado);
  Result := getLogisticaGlobal.enviaSaida(pTipo,Result.propriedade['id'].asString,Result);
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
  {$if defined(__FORCAR_LOGISTICA_FEDEX__)}
    Result := CONTROLE_LOGISTICA_FEDEX;
  {$else}
    Result := ValorTagConfig(tagConfig_LOGISTICA,tagConfigcfg_Padrao_LOGISTICA,tvString);
  {$endif};
end;

function logistica_travaDocumento;
begin
  Result := checkResultadoOperacao(pResultado);
  if(logistica_utiizada<>CONTROLE_LOGISTICA_NENHUM) then
  try
    gdbPadrao.updateDB('movimento_serial', ['TIPO_DOCUMENTO','ID_DOCUMENTO'], [pTipo,pNumeroDoc],['TIPO_MOVIMENTO'],['*'],true,true);
  except
    on e: Exception do
      Result.formataErro('logistica_liberaDocumento: %s: %s', [ e.ClassName, e.Message]);
  end;
end;

function logistica_liberaDocumento;
  var
    lValor: String;
begin
  Result := checkResultadoOperacao(pResultado);
  if(logistica_utiizada<>CONTROLE_LOGISTICA_NENHUM) then
  try
    lValor := '';
    if stringNoArray(pTipo,[LOGISTICA_TIPOSAIDA_PEDIDO,LOGISTICA_TIPOSAIDA_SAIDATRANSF]) then
      lValor := 'S';

    if(lValor<>'') then
      gdbPadrao.updateDB('movimento_serial', ['TIPO_DOCUMENTO','ID_DOCUMENTO'], [pTipo,pNumeroDoc],['TIPO_MOVIMENTO'],[lValor],true,true);

  except
    on e: Exception do
      Result.formataErro('logistica_travaDocumento: %s: %s', [ e.ClassName, e.Message]);
  end;
end;

function logistica_EntradaFinalizada;
begin
  checkResultadoOperacao(pResultado);

  Result := true;

  if(logistica_utiizada<>CONTROLE_LOGISTICA_NENHUM) then
    Result := getLogisticaGlobal.entradaFinalizada(pTipo,pNumeroDoc);
end;

function logistica_SaidaFinalizada;
begin
  checkResultadoOperacao(pResultado);

  Result := true;

  if(logistica_utiizada<>CONTROLE_LOGISTICA_NENHUM) then
    Result := getLogisticaGlobal.saidaFinalizada(pTipo,pNumeroDoc);
end;

{$if defined(__AUTOMATIZA_LOGISTICA__)}
function _automacao_logistica(const pNome: TipoWideStringFramework; const pParametro: TipoWideStringFramework; const pDadosAdicionais: TipoWideStringFramework; pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  Result := checkResultadoOperacao(pResultado);
  if(logistica_utiizada<>CONTROLE_LOGISTICA_NENHUM) then
    Result := logistica_ProcessaServico(pResultado);
end;

procedure inicia;
begin
  Terasoft.Framework.ProcessoAutomacao.registraProcessoAutomacao(AUTOMACAO_LOGISTICA,_automacao_logistica);
end;

initialization
  inicia;

{$endif}

end.
