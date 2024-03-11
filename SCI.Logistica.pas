unit SCI.Logistica;

interface

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
