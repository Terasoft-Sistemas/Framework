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

    TLogisticaProcessadorArquivoRetorno = function (pUnkAPI: IUnknown; pResultado: IResultadoOperacao): IResultadoOperacao;

    ILogisticaAPI = interface
     ['{6F92AC71-F0F6-4AC1-9188-B0C9B9EBD114}']
      procedure setProcessador(pInterface: TipoWideStringFramework; pProcessador: TLogisticaProcessadorArquivoRetorno);
      function getProcessador(pInterface: TipoWideStringFramework): TLogisticaProcessadorArquivoRetorno;

      function processaRetorno(pProcessador: TLogisticaProcessadorArquivoRetorno; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

      function getVersao: TipoWideStringFramework;
      function getCompilacao: Int64;

      property versao: TipoWideStringFramework read getVersao;
      property compilacao: Int64 read getCompilacao;

    end;


  function sci_logistica_utiizada: String;
  function sci_logistica_usa_fedex: boolean;

implementation
  uses
    FuncoesConfig;

function sci_logistica_utiizada: String;
begin
  Result := ValorTagConfig(tagConfig_LOGISTICA,tagConfigcfg_Padrao_LOGISTICA,tvString);
end;

function sci_logistica_usa_fedex: boolean;
begin
  Result := sci_logistica_utiizada = CONTROLE_LOGISTICA_FEDEX;
end;


end.
