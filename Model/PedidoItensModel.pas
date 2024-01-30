unit PedidoItensModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  mcibr.motor,
  mcibr.interfaces,
  mcibr.enum.contribuinte.ipi,
  mcibr.enum.contribuinte.icms,
  mcibr.pis,
  mcibr.enum.piscofins,
  mcibr.pisst,
  mcibr.produto,
  mcibr.enum.ipi,
  mcibr.enum.tipo.venda,
  mcibr.utils,
  Interfaces.Conexao;

type
  TPedidoItensModel = class

  private
    vIConexao : IConexao;

    FPedidoItenssLista: TObjectList<TPedidoItensModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVFCPUFDEST: Variant;
    FBASE_ST: Variant;
    FCTR_EXPORTACAO: Variant;
    FDESCONTO_UF: Variant;
    FNITEMPED2: Variant;
    FQTD_CHECAGEM: Variant;
    FVALOR_ICMS: Variant;
    FMOTDESICMS: Variant;
    FVICMSUFREMET: Variant;
    FREDUCAO_ICMS: Variant;
    FVLRVENDA_PRO: Variant;
    FVBCUFDEST: Variant;
    FQTD_CHECAGEM_CORTE: Variant;
    FPOS_VENDA_OBS: Variant;
    FCUSTO_DRG: Variant;
    FIPI_SUFRAMA: Variant;
    FOBSERVACAO: Variant;
    FCOMBO_ITEM: Variant;
    FBONUS: Variant;
    FPOS_VENDA_RETORNO: Variant;
    FAVULSO: Variant;
    FPREVENDA_ID: Variant;
    FXPED: Variant;
    FVLRVENDA_MINIMO: Variant;
    FALTURA_M: Variant;
    FDUN14: Variant;
    FPROJETO_ID: Variant;
    FQUANTIDADE_TIPO: Variant;
    FCOMISSAO_PERCENTUAL: Variant;
    FFUNCIONARIO_ID: Variant;
    FDESC_RESTITUICAO_ST: Variant;
    FALIQ_ICMS: Variant;
    FGERENTE_COMISSAO_PERCENTUAL: Variant;
    FPICMSINTER: Variant;
    FENTREGA: Variant;
    FVALOR_VENDA_CADASTRO: Variant;
    FQTDE_CALCULADA: Variant;
    FRESERVA_ID: Variant;
    FOBS_ITEM: Variant;
    FVBCFCPST: Variant;
    FLARGURA_M: Variant;
    FALTURA: Variant;
    FMVA: Variant;
    FDESCONTO_PED: Variant;
    FAMBIENTE_OBS: Variant;
    FVALOR_PIS: Variant;
    FVOUTROS: Variant;
    FVALOR_COFINS: Variant;
    FICMS_SUFRAMA: Variant;
    FPRODUTO_REFERENCIA: Variant;
    FVALOR_ST: Variant;
    FCODIGO_CLI: Variant;
    FREDUCAO_ST: Variant;
    FID: Variant;
    FALIQ_ICMS_ST: Variant;
    FLARGURA: Variant;
    FVALOR_RESTITUICAO_ST: Variant;
    FPEDIDOITENS_ID: Variant;
    FVALOR_DIFERIMENTO: Variant;
    FBONUS_USO: Variant;
    FVALOR_SUFRAMA_ITEM: Variant;
    FPOS_VENDA_STATUS: Variant;
    FALIQ_PIS: Variant;
    FLOJA: Variant;
    FTIPO_VENDA: Variant;
    FVALOR_SUFRAMA_ITEM_NEW: Variant;
    FITEM: Variant;
    FALIQ_COFINS: Variant;
    FBASE_ICMS: Variant;
    FCFOP_ID: Variant;
    FCODIGO_PRO: Variant;
    FPCRED_PRESUMIDO: Variant;
    FMONTAGEM: Variant;
    FVALORUNITARIO_PED: Variant;
    FQUANTIDADE_TROCA: Variant;
    FVALOR_MONTADOR: Variant;
    FSYSTIME: Variant;
    FBALANCA: Variant;
    FVFRETE: Variant;
    FQUANTIDADE_KG: Variant;
    FSAIDAS_ID: Variant;
    FVALOR_IPI: Variant;
    FVALOR_BONUS_SERVICO: Variant;
    FWEB_PEDIDOITENS_ID: Variant;
    FQUANTIDADE_NEW: Variant;
    FORCAMENTO_TSB_ID: Variant;
    FRESERVADO: Variant;
    FPRODUCAO_ID: Variant;
    FAMBIENTE_ID: Variant;
    FNUMERO_PED: Variant;
    FCBENEF: Variant;
    FPIS_SUFRAMA: Variant;
    FPFCPST: Variant;
    FIMPRESSO: Variant;
    FPICMSUFDEST: Variant;
    FCOFINS_SUFRAMA: Variant;
    FCOMISSAO_PED: Variant;
    FORIGINAL_PEDIDO_ID: Variant;
    FVLRVENDA_MAXIMO: Variant;
    FPROFUNDIDADE_M: Variant;
    FVFCPST: Variant;
    FVICMSUFDEST: Variant;
    FALIQ_IPI: Variant;
    FVICMSDESON: Variant;
    FCST: Variant;
    FPEDIDOCOMPRAITENS_ID: Variant;
    FPFCPUFDEST: Variant;
    FDESCRICAO_PRODUTO: Variant;
    FBASE_PIS: Variant;
    FTIPO_NF: Variant;
    FVLRCUSTO_PRO: Variant;
    FQUANTIDADE_PED: Variant;
    FPICMSINTERPART: Variant;
    FBASE_COFINS: Variant;
    FIDPedidoVendaView: String;
    FIDRecordView: String;
    FNOME_PRO: Variant;
    FBARRAS_PRO: Variant;
    FTOTAL: Variant;
    FIDUsuario: String;
    FTOTAL_PRODUTO: Variant;
    FVALOR_TOTAL_ITENS: Variant;
    FVALOR_TOTAL_DESCONTO: Variant;
    FVALOR_TOTAL_GARANTIA: Variant;
    FVALOR_TOTAL: Variant;
    FPIS_CST: Variant;
    FCOFINS_CST: Variant;
    FIPI_CST: Variant;
    FVDESC: Variant;
    FCSOSN: Variant;
    FCFOP: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPedidoItenssLista(const Value: TObjectList<TPedidoItensModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetALIQ_COFINS(const Value: Variant);
    procedure SetALIQ_ICMS(const Value: Variant);
    procedure SetALIQ_ICMS_ST(const Value: Variant);
    procedure SetALIQ_IPI(const Value: Variant);
    procedure SetALIQ_PIS(const Value: Variant);
    procedure SetALTURA(const Value: Variant);
    procedure SetALTURA_M(const Value: Variant);
    procedure SetAMBIENTE_ID(const Value: Variant);
    procedure SetAMBIENTE_OBS(const Value: Variant);
    procedure SetAVULSO(const Value: Variant);
    procedure SetBALANCA(const Value: Variant);
    procedure SetBASE_COFINS(const Value: Variant);
    procedure SetBASE_ICMS(const Value: Variant);
    procedure SetBASE_PIS(const Value: Variant);
    procedure SetBASE_ST(const Value: Variant);
    procedure SetBONUS(const Value: Variant);
    procedure SetBONUS_USO(const Value: Variant);
    procedure SetCBENEF(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCODIGO_PRO(const Value: Variant);
    procedure SetCOFINS_SUFRAMA(const Value: Variant);
    procedure SetCOMBO_ITEM(const Value: Variant);
    procedure SetCOMISSAO_PED(const Value: Variant);
    procedure SetCOMISSAO_PERCENTUAL(const Value: Variant);
    procedure SetCST(const Value: Variant);
    procedure SetCTR_EXPORTACAO(const Value: Variant);
    procedure SetCUSTO_DRG(const Value: Variant);
    procedure SetDESC_RESTITUICAO_ST(const Value: Variant);
    procedure SetDESCONTO_PED(const Value: Variant);
    procedure SetDESCONTO_UF(const Value: Variant);
    procedure SetDESCRICAO_PRODUTO(const Value: Variant);
    procedure SetDUN14(const Value: Variant);
    procedure SetENTREGA(const Value: Variant);
    procedure SetFUNCIONARIO_ID(const Value: Variant);
    procedure SetGERENTE_COMISSAO_PERCENTUAL(const Value: Variant);
    procedure SetICMS_SUFRAMA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIMPRESSO(const Value: Variant);
    procedure SetIPI_SUFRAMA(const Value: Variant);
    procedure SetITEM(const Value: Variant);
    procedure SetLARGURA(const Value: Variant);
    procedure SetLARGURA_M(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetMONTAGEM(const Value: Variant);
    procedure SetMOTDESICMS(const Value: Variant);
    procedure SetMVA(const Value: Variant);
    procedure SetNITEMPED2(const Value: Variant);
    procedure SetNUMERO_PED(const Value: Variant);
    procedure SetOBS_ITEM(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetORCAMENTO_TSB_ID(const Value: Variant);
    procedure SetORIGINAL_PEDIDO_ID(const Value: Variant);
    procedure SetPCRED_PRESUMIDO(const Value: Variant);
    procedure SetPEDIDOCOMPRAITENS_ID(const Value: Variant);
    procedure SetPEDIDOITENS_ID(const Value: Variant);
    procedure SetPFCPST(const Value: Variant);
    procedure SetPFCPUFDEST(const Value: Variant);
    procedure SetPICMSINTER(const Value: Variant);
    procedure SetPICMSINTERPART(const Value: Variant);
    procedure SetPICMSUFDEST(const Value: Variant);
    procedure SetPIS_SUFRAMA(const Value: Variant);
    procedure SetPOS_VENDA_OBS(const Value: Variant);
    procedure SetPOS_VENDA_RETORNO(const Value: Variant);
    procedure SetPOS_VENDA_STATUS(const Value: Variant);
    procedure SetPREVENDA_ID(const Value: Variant);
    procedure SetPRODUCAO_ID(const Value: Variant);
    procedure SetPRODUTO_REFERENCIA(const Value: Variant);
    procedure SetPROFUNDIDADE_M(const Value: Variant);
    procedure SetPROJETO_ID(const Value: Variant);
    procedure SetQTD_CHECAGEM(const Value: Variant);
    procedure SetQTD_CHECAGEM_CORTE(const Value: Variant);
    procedure SetQTDE_CALCULADA(const Value: Variant);
    procedure SetQUANTIDADE_KG(const Value: Variant);
    procedure SetQUANTIDADE_NEW(const Value: Variant);
    procedure SetQUANTIDADE_PED(const Value: Variant);
    procedure SetQUANTIDADE_TIPO(const Value: Variant);
    procedure SetQUANTIDADE_TROCA(const Value: Variant);
    procedure SetREDUCAO_ICMS(const Value: Variant);
    procedure SetREDUCAO_ST(const Value: Variant);
    procedure SetRESERVA_ID(const Value: Variant);
    procedure SetRESERVADO(const Value: Variant);
    procedure SetSAIDAS_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO_NF(const Value: Variant);
    procedure SetTIPO_VENDA(const Value: Variant);
    procedure SetVALOR_BONUS_SERVICO(const Value: Variant);
    procedure SetVALOR_COFINS(const Value: Variant);
    procedure SetVALOR_DIFERIMENTO(const Value: Variant);
    procedure SetVALOR_ICMS(const Value: Variant);
    procedure SetVALOR_IPI(const Value: Variant);
    procedure SetVALOR_MONTADOR(const Value: Variant);
    procedure SetVALOR_PIS(const Value: Variant);
    procedure SetVALOR_RESTITUICAO_ST(const Value: Variant);
    procedure SetVALOR_ST(const Value: Variant);
    procedure SetVALOR_SUFRAMA_ITEM(const Value: Variant);
    procedure SetVALOR_SUFRAMA_ITEM_NEW(const Value: Variant);
    procedure SetVALOR_VENDA_CADASTRO(const Value: Variant);
    procedure SetVALORUNITARIO_PED(const Value: Variant);
    procedure SetVBCFCPST(const Value: Variant);
    procedure SetVBCUFDEST(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetVFCPUFDEST(const Value: Variant);
    procedure SetVFRETE(const Value: Variant);
    procedure SetVICMSDESON(const Value: Variant);
    procedure SetVICMSUFDEST(const Value: Variant);
    procedure SetVICMSUFREMET(const Value: Variant);
    procedure SetVLRCUSTO_PRO(const Value: Variant);
    procedure SetVLRVENDA_MAXIMO(const Value: Variant);
    procedure SetVLRVENDA_MINIMO(const Value: Variant);
    procedure SetVLRVENDA_PRO(const Value: Variant);
    procedure SetVOUTROS(const Value: Variant);
    procedure SetWEB_PEDIDOITENS_ID(const Value: Variant);
    procedure SetXPED(const Value: Variant);
    procedure SetIDPedidoVendaView(const Value: String);
    procedure SetIDRecordView(const Value: String);
    procedure SetBARRAS_PRO(const Value: Variant);
    procedure SetNOME_PRO(const Value: Variant);
    procedure SetTOTAL(const Value: Variant);
    procedure SetIDUsuario(const Value: String);
    procedure SetTOTAL_PRODUTO(const Value: Variant);
    procedure SetVALOR_TOTAL_DESCONTO(const Value: Variant);
    procedure SetVALOR_TOTAL_GARANTIA(const Value: Variant);
    procedure SetVALOR_TOTAL_ITENS(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);
    procedure SetCOFINS_CST(const Value: Variant);
    procedure SetIPI_CST(const Value: Variant);
    procedure SetPIS_CST(const Value: Variant);
    procedure SetVDESC(const Value: Variant);
    procedure SetCSOSN(const Value: Variant);
    procedure SetCFOP(const Value: Variant);

  public
    property ID: Variant read FID write SetID;
    property CODIGO_CLI: Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property NUMERO_PED: Variant read FNUMERO_PED write SetNUMERO_PED;
    property CODIGO_PRO: Variant read FCODIGO_PRO write SetCODIGO_PRO;
    property QUANTIDADE_PED: Variant read FQUANTIDADE_PED write SetQUANTIDADE_PED;
    property QUANTIDADE_TROCA: Variant read FQUANTIDADE_TROCA write SetQUANTIDADE_TROCA;
    property VALORUNITARIO_PED: Variant read FVALORUNITARIO_PED write SetVALORUNITARIO_PED;
    property DESCONTO_PED: Variant read FDESCONTO_PED write SetDESCONTO_PED;
    property DESCONTO_UF: Variant read FDESCONTO_UF write SetDESCONTO_UF;
    property VALOR_IPI: Variant read FVALOR_IPI write SetVALOR_IPI;
    property VALOR_ST: Variant read FVALOR_ST write SetVALOR_ST;
    property VLRVENDA_PRO: Variant read FVLRVENDA_PRO write SetVLRVENDA_PRO;
    property VLRCUSTO_PRO: Variant read FVLRCUSTO_PRO write SetVLRCUSTO_PRO;
    property COMISSAO_PED: Variant read FCOMISSAO_PED write SetCOMISSAO_PED;
    property TIPO_NF: Variant read FTIPO_NF write SetTIPO_NF;
    property QUANTIDADE_TIPO: Variant read FQUANTIDADE_TIPO write SetQUANTIDADE_TIPO;
    property OBSERVACAO: Variant read FOBSERVACAO write SetOBSERVACAO;
    property CTR_EXPORTACAO: Variant read FCTR_EXPORTACAO write SetCTR_EXPORTACAO;
    property PRODUTO_REFERENCIA: Variant read FPRODUTO_REFERENCIA write SetPRODUTO_REFERENCIA;
    property OBS_ITEM: Variant read FOBS_ITEM write SetOBS_ITEM;
    property RESERVA_ID: Variant read FRESERVA_ID write SetRESERVA_ID;
    property LOJA: Variant read FLOJA write SetLOJA;
    property ALIQ_IPI: Variant read FALIQ_IPI write SetALIQ_IPI;
    property VALOR_RESTITUICAO_ST: Variant read FVALOR_RESTITUICAO_ST write SetVALOR_RESTITUICAO_ST;
    property CFOP_ID: Variant read FCFOP_ID write SetCFOP_ID;
    property CST: Variant read FCST write SetCST;
    property ALIQ_ICMS: Variant read FALIQ_ICMS write SetALIQ_ICMS;
    property ALIQ_ICMS_ST: Variant read FALIQ_ICMS_ST write SetALIQ_ICMS_ST;
    property REDUCAO_ST: Variant read FREDUCAO_ST write SetREDUCAO_ST;
    property MVA: Variant read FMVA write SetMVA;
    property REDUCAO_ICMS: Variant read FREDUCAO_ICMS write SetREDUCAO_ICMS;
    property BASE_ICMS: Variant read FBASE_ICMS write SetBASE_ICMS;
    property VALOR_ICMS: Variant read FVALOR_ICMS write SetVALOR_ICMS;
    property BASE_ST: Variant read FBASE_ST write SetBASE_ST;
    property DESC_RESTITUICAO_ST: Variant read FDESC_RESTITUICAO_ST write SetDESC_RESTITUICAO_ST;
    property ICMS_SUFRAMA: Variant read FICMS_SUFRAMA write SetICMS_SUFRAMA;
    property PIS_SUFRAMA: Variant read FPIS_SUFRAMA write SetPIS_SUFRAMA;
    property COFINS_SUFRAMA: Variant read FCOFINS_SUFRAMA write SetCOFINS_SUFRAMA;
    property IPI_SUFRAMA: Variant read FIPI_SUFRAMA write SetIPI_SUFRAMA;
    property ALIQ_PIS: Variant read FALIQ_PIS write SetALIQ_PIS;
    property ALIQ_COFINS: Variant read FALIQ_COFINS write SetALIQ_COFINS;
    property BASE_PIS: Variant read FBASE_PIS write SetBASE_PIS;
    property BASE_COFINS: Variant read FBASE_COFINS write SetBASE_COFINS;
    property VALOR_PIS: Variant read FVALOR_PIS write SetVALOR_PIS;
    property VALOR_COFINS: Variant read FVALOR_COFINS write SetVALOR_COFINS;
    property PREVENDA_ID: Variant read FPREVENDA_ID write SetPREVENDA_ID;
    property AVULSO: Variant read FAVULSO write SetAVULSO;
    property QUANTIDADE_NEW: Variant read FQUANTIDADE_NEW write SetQUANTIDADE_NEW;
    property BALANCA: Variant read FBALANCA write SetBALANCA;
    property QTDE_CALCULADA: Variant read FQTDE_CALCULADA write SetQTDE_CALCULADA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property AMBIENTE_ID: Variant read FAMBIENTE_ID write SetAMBIENTE_ID;
    property AMBIENTE_OBS: Variant read FAMBIENTE_OBS write SetAMBIENTE_OBS;
    property PROJETO_ID: Variant read FPROJETO_ID write SetPROJETO_ID;
    property LARGURA: Variant read FLARGURA write SetLARGURA;
    property ALTURA: Variant read FALTURA write SetALTURA;
    property ITEM: Variant read FITEM write SetITEM;
    property DUN14: Variant read FDUN14 write SetDUN14;
    property SAIDAS_ID: Variant read FSAIDAS_ID write SetSAIDAS_ID;
    property CUSTO_DRG: Variant read FCUSTO_DRG write SetCUSTO_DRG;
    property POS_VENDA_STATUS: Variant read FPOS_VENDA_STATUS write SetPOS_VENDA_STATUS;
    property POS_VENDA_RETORNO: Variant read FPOS_VENDA_RETORNO write SetPOS_VENDA_RETORNO;
    property POS_VENDA_OBS: Variant read FPOS_VENDA_OBS write SetPOS_VENDA_OBS;
    property VALOR_SUFRAMA_ITEM_NEW: Variant read FVALOR_SUFRAMA_ITEM_NEW write SetVALOR_SUFRAMA_ITEM_NEW;
    property VALOR_SUFRAMA_ITEM: Variant read FVALOR_SUFRAMA_ITEM write SetVALOR_SUFRAMA_ITEM;
    property BONUS: Variant read FBONUS write SetBONUS;
    property BONUS_USO: Variant read FBONUS_USO write SetBONUS_USO;
    property FUNCIONARIO_ID: Variant read FFUNCIONARIO_ID write SetFUNCIONARIO_ID;
    property PRODUCAO_ID: Variant read FPRODUCAO_ID write SetPRODUCAO_ID;
    property QUANTIDADE_KG: Variant read FQUANTIDADE_KG write SetQUANTIDADE_KG;
    property RESERVADO: Variant read FRESERVADO write SetRESERVADO;
    property DESCRICAO_PRODUTO: Variant read FDESCRICAO_PRODUTO write SetDESCRICAO_PRODUTO;
    property COMISSAO_PERCENTUAL: Variant read FCOMISSAO_PERCENTUAL write SetCOMISSAO_PERCENTUAL;
    property QTD_CHECAGEM: Variant read FQTD_CHECAGEM write SetQTD_CHECAGEM;
    property QTD_CHECAGEM_CORTE: Variant read FQTD_CHECAGEM_CORTE write SetQTD_CHECAGEM_CORTE;
    property ALTURA_M: Variant read FALTURA_M write SetALTURA_M;
    property LARGURA_M: Variant read FLARGURA_M write SetLARGURA_M;
    property PROFUNDIDADE_M: Variant read FPROFUNDIDADE_M write SetPROFUNDIDADE_M;
    property VBCUFDEST: Variant read FVBCUFDEST write SetVBCUFDEST;
    property PFCPUFDEST: Variant read FPFCPUFDEST write SetPFCPUFDEST;
    property PICMSUFDEST: Variant read FPICMSUFDEST write SetPICMSUFDEST;
    property PICMSINTER: Variant read FPICMSINTER write SetPICMSINTER;
    property PICMSINTERPART: Variant read FPICMSINTERPART write SetPICMSINTERPART;
    property VFCPUFDEST: Variant read FVFCPUFDEST write SetVFCPUFDEST;
    property VICMSUFDEST: Variant read FVICMSUFDEST write SetVICMSUFDEST;
    property VICMSUFREMET: Variant read FVICMSUFREMET write SetVICMSUFREMET;
    property COMBO_ITEM: Variant read FCOMBO_ITEM write SetCOMBO_ITEM;
    property VLRVENDA_MINIMO: Variant read FVLRVENDA_MINIMO write SetVLRVENDA_MINIMO;
    property VLRVENDA_MAXIMO: Variant read FVLRVENDA_MAXIMO write SetVLRVENDA_MAXIMO;
    property IMPRESSO: Variant read FIMPRESSO write SetIMPRESSO;
    property ORCAMENTO_TSB_ID: Variant read FORCAMENTO_TSB_ID write SetORCAMENTO_TSB_ID;
    property GERENTE_COMISSAO_PERCENTUAL: Variant read FGERENTE_COMISSAO_PERCENTUAL write SetGERENTE_COMISSAO_PERCENTUAL;
    property XPED: Variant read FXPED write SetXPED;
    property NITEMPED2: Variant read FNITEMPED2 write SetNITEMPED2;
    property VOUTROS: Variant read FVOUTROS write SetVOUTROS;
    property VFRETE: Variant read FVFRETE write SetVFRETE;
    property ORIGINAL_PEDIDO_ID: Variant read FORIGINAL_PEDIDO_ID write SetORIGINAL_PEDIDO_ID;
    property VALOR_VENDA_CADASTRO: Variant read FVALOR_VENDA_CADASTRO write SetVALOR_VENDA_CADASTRO;
    property WEB_PEDIDOITENS_ID: Variant read FWEB_PEDIDOITENS_ID write SetWEB_PEDIDOITENS_ID;
    property TIPO_VENDA: Variant read FTIPO_VENDA write SetTIPO_VENDA;
    property ENTREGA: Variant read FENTREGA write SetENTREGA;
    property VBCFCPST: Variant read FVBCFCPST write SetVBCFCPST;
    property PFCPST: Variant read FPFCPST write SetPFCPST;
    property VFCPST: Variant read FVFCPST write SetVFCPST;
    property VALOR_BONUS_SERVICO: Variant read FVALOR_BONUS_SERVICO write SetVALOR_BONUS_SERVICO;
    property CBENEF: Variant read FCBENEF write SetCBENEF;
    property VICMSDESON: Variant read FVICMSDESON write SetVICMSDESON;
    property MOTDESICMS: Variant read FMOTDESICMS write SetMOTDESICMS;
    property VALOR_DIFERIMENTO: Variant read FVALOR_DIFERIMENTO write SetVALOR_DIFERIMENTO;
    property VALOR_MONTADOR: Variant read FVALOR_MONTADOR write SetVALOR_MONTADOR;
    property MONTAGEM: Variant read FMONTAGEM write SetMONTAGEM;
    property PCRED_PRESUMIDO: Variant read FPCRED_PRESUMIDO write SetPCRED_PRESUMIDO;
    property PEDIDOCOMPRAITENS_ID: Variant read FPEDIDOCOMPRAITENS_ID write SetPEDIDOCOMPRAITENS_ID;
    property PEDIDOITENS_ID: Variant read FPEDIDOITENS_ID write SetPEDIDOITENS_ID;
    property PIS_CST    : Variant read FPIS_CST write SetPIS_CST;
    property COFINS_CST : Variant read FCOFINS_CST write SetCOFINS_CST;
    property IPI_CST    : Variant read FIPI_CST write SetIPI_CST;
    property VDESC: Variant read FVDESC write SetVDESC;
    property CSOSN: Variant read FCSOSN write SetCSOSN;
    property CFOP: Variant read FCFOP write SetCFOP;
    property BARRAS_PRO: Variant read FBARRAS_PRO write SetBARRAS_PRO;
    property NOME_PRO: Variant read FNOME_PRO write SetNOME_PRO;
    property TOTAL: Variant read FTOTAL write SetTOTAL;
    property TOTAL_PRODUTO: Variant read FTOTAL_PRODUTO write SetTOTAL_PRODUTO;

  	constructor Create(pConexao: IConexao);
    destructor Destroy; override;
    function Salvar: String;
    function Incluir : String;
    function Alterar(pID : String) : TPedidoItensModel;
    function Excluir(pID : String) : String;

    procedure obterLista;
    procedure obterPedido(pNUmeroPedido: String);
    procedure obterTotaisItens(pNumeroPedido: String);
    function carregaClasse(pId: String): TPedidoItensModel;

    function gerarEstoque: String;
    function cancelarEstoque: String;

    property PedidoItenssLista: TObjectList<TPedidoItensModel> read FPedidoItenssLista write SetPedidoItenssLista;

   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property IDPedidoVendaView: String read FIDPedidoVendaView write SetIDPedidoVendaView;
    property IDUsuario: String read FIDUsuario write SetIDUsuario;
    property VALOR_TOTAL_ITENS: Variant read FVALOR_TOTAL_ITENS write SetVALOR_TOTAL_ITENS;
    property VALOR_TOTAL_GARANTIA: Variant read FVALOR_TOTAL_GARANTIA write SetVALOR_TOTAL_GARANTIA;
    property VALOR_TOTAL_DESCONTO: Variant read FVALOR_TOTAL_DESCONTO write SetVALOR_TOTAL_DESCONTO;
    property VALOR_TOTAL: Variant read FVALOR_TOTAL write SetVALOR_TOTAL;
  end;

implementation

uses
  PedidoItensDao,
  CalcularImpostosModel,
  System.SysUtils,
  MovimentoModel,
  PedidoVendaModel,
  ProdutosModel,
  UsuarioModel;

{ TPedidoItensModel }

function TPedidoItensModel.Alterar(pID: String): TPedidoItensModel;
var
  lPedidoItensModel : TPedidoItensModel;
begin
  lPedidoItensModel := lPedidoItensModel.Create(vIConexao);
  try
    lPedidoItensModel      := lPedidoItensModel.carregaClasse(pID);
    lPedidoItensModel.Acao := tacAlterar;
    Result                 := lPedidoItensModel;
  finally

  end;
end;

function TPedidoItensModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

function TPedidoItensModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  self.Salvar;
end;

function TPedidoItensModel.cancelarEstoque: String;
var
  lMovimentoModel, lModel: TMovimentoModel;
  lProdutosModel: TProdutosModel;
  lUsuarioModel : TUsuarioModel;
begin
  lMovimentoModel := TMovimentoModel.Create(vIConexao);
  lProdutosModel  := TProdutosModel.Create(vIConexao);
  lUsuarioModel   := TUsuarioModel.Create(vIConexao);

  try
    lMovimentoModel.WhereView := ' and movimento.status <> ''X''                 '+
                                 ' and movimento.tipo_doc = ''P''                '+
                                 ' and movimento.tabela_origem = ''PEDIDOITENS'' '+
                                 ' and movimento.id_origem = '+ QuotedStr(self.FID);

    lMovimentoModel.obterLista;

    for lModel in lMovimentoModel.MovimentosLista do
    begin
      lModel.Acao := tacAlterar;
      lModel.STATUS  := 'X';
      lModel.OBS_MOV := 'Alt.Ped.Usuário: '+ lUsuarioModel.nomeUsuario(self.vIConexao.getUSer.NOME) + DateToStr(vIConexao.DataServer) + ' ' + TimeToStr(vIConexao.HoraServer);
      lModel.Salvar;

      lProdutosModel.adicionarSaldo(lModel.CODIGO_PRO, lModel.QUANTIDADE_MOV);
    end;

  finally
    lMovimentoModel.Free;
    lProdutosModel.Free;
  end;
end;

function TPedidoItensModel.carregaClasse(pId: String): TPedidoItensModel;
var
  lPedidoItensDao: TPedidoItensDao;
begin
  lPedidoItensDao := TPedidoItensDao.Create(vIConexao);
  try
    Result := lPedidoItensDao.carregaClasse(pId);
  finally
    lPedidoItensDao.Free;
  end;
end;

constructor TPedidoItensModel.Create(pConexao: IConexao);
begin
  vIConexao := pConexao;
end;

destructor TPedidoItensModel.Destroy;
begin
  inherited;
end;

function TPedidoItensModel.gerarEstoque: String;
var
  lMovimentoModel   : TMovimentoModel;
  lProdutosModel    : TProdutosModel;
begin
  lMovimentoModel   := TMovimentoModel.Create(vIConexao);
  lProdutosModel    := TProdutosModel.Create(vIConexao);

  try
    lMovimentoModel.Acao := tacIncluir;

    lMovimentoModel.DOCUMENTO_MOV   := self.FNUMERO_PED;
    lMovimentoModel.CODIGO_PRO      := self.FCODIGO_PRO;
    lMovimentoModel.CODIGO_FOR      := self.FCODIGO_CLI;
    lMovimentoModel.OBS_MOV         := 'Venda N: ' + self.FNUMERO_PED;
    lMovimentoModel.TIPO_DOC        := 'P';
    lMovimentoModel.DATA_MOV        := DateToStr(vIConexao.DataServer);
    lMovimentoModel.DATA_DOC        := DateToStr(vIConexao.DataServer);
    lMovimentoModel.QUANTIDADE_MOV  := self.FQUANTIDADE_PED;
    lMovimentoModel.VALOR_MOV       := self.FVALORUNITARIO_PED;
    lMovimentoModel.CUSTO_ATUAL     := self.FVLRCUSTO_PRO;
    lMovimentoModel.VENDA_ATUAL     := self.FVLRVENDA_PRO;
    lMovimentoModel.STATUS          := '0';
    lMovimentoModel.LOJA            := self.FLOJA;
    lMovimentoModel.tabela_origem   := 'PEDIDOITENS';
    lMovimentoModel.id_origem       := self.FID;
    Result := lMovimentoModel.Salvar;

    lProdutosModel.subtrairSaldo(self.FCODIGO_PRO, self.FQUANTIDADE_PED);

  finally
    lProdutosModel.Free;
    lMovimentoModel.Free;
  end;
end;

procedure TPedidoItensModel.obterPedido(pNUmeroPedido: String);
var
  lPedidoItensLista: TPedidoItensDao;
begin
  lPedidoItensLista := TPedidoItensDao.Create(vIConexao);
  try
    lPedidoItensLista.obterItensPedido(pNUmeroPedido);
    FPedidoItenssLista := lPedidoItensLista.PedidoItenssLista;
  finally
    lPedidoItensLista.Free;
  end;
end;
procedure TPedidoItensModel.obterTotaisItens(pNumeroPedido: String);
var
  lPedidoItensLista: TPedidoItensDao;
begin
  lPedidoItensLista := TPedidoItensDao.Create(vIConexao);
  try
    lPedidoItensLista.obterTotaisItens(pNUmeroPedido);
    self.VALOR_TOTAL_ITENS     := lPedidoItensLista.VALOR_TOTAL_ITENS;
    self.VALOR_TOTAL_GARANTIA  := lPedidoItensLista.VALOR_TOTAL_GARANTIA;
    self.VALOR_TOTAL_DESCONTO  := lPedidoItensLista.VALOR_TOTAL_DESCONTO;
    self.VALOR_TOTAL           := lPedidoItensLista.VALOR_TOTAL;
  finally
    lPedidoItensLista.Free;
  end;
end;

procedure TPedidoItensModel.obterLista;
var
  lPedidoItensLista: TPedidoItensDao;
begin
  lPedidoItensLista := TPedidoItensDao.Create(vIConexao);
  try
    lPedidoItensLista.TotalRecords      := FTotalRecords;
    lPedidoItensLista.WhereView         := FWhereView;
    lPedidoItensLista.CountView         := FCountView;
    lPedidoItensLista.OrderView         := FOrderView;
    lPedidoItensLista.StartRecordView   := FStartRecordView;
    lPedidoItensLista.LengthPageView    := FLengthPageView;
    lPedidoItensLista.IDRecordView      := FIDRecordView;
    lPedidoItensLista.IDPedidoVendaView := FIDPedidoVendaView;

    lPedidoItensLista.obterLista;

    FTotalRecords      := lPedidoItensLista.TotalRecords;
    FPedidoItenssLista := lPedidoItensLista.PedidoItenssLista;
  finally
    lPedidoItensLista.Free;
  end;
end;

function TPedidoItensModel.Salvar: String;
var
  lPedidoItensDao: TPedidoItensDao;
begin
  lPedidoItensDao := TPedidoItensDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir     : Result := lPedidoItensDao.incluir(Self);
      Terasoft.Types.tacIncluirLote : Result := lPedidoItensDao.incluirLote(Self);
      Terasoft.Types.tacAlterar     : Result := lPedidoItensDao.alterar(Self);
      Terasoft.Types.tacExcluir     : Result := lPedidoItensDao.excluir(Self);
    end;

  finally
    lPedidoItensDao.Free;
  end;
end;

procedure TPedidoItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPedidoItensModel.SetALIQ_COFINS(const Value: Variant);
begin
  FALIQ_COFINS := Value;
end;

procedure TPedidoItensModel.SetALIQ_ICMS(const Value: Variant);
begin
  FALIQ_ICMS := Value;
end;

procedure TPedidoItensModel.SetALIQ_ICMS_ST(const Value: Variant);
begin
  FALIQ_ICMS_ST := Value;
end;

procedure TPedidoItensModel.SetALIQ_IPI(const Value: Variant);
begin
  FALIQ_IPI := Value;
end;

procedure TPedidoItensModel.SetALIQ_PIS(const Value: Variant);
begin
  FALIQ_PIS := Value;
end;

procedure TPedidoItensModel.SetALTURA(const Value: Variant);
begin
  FALTURA := Value;
end;

procedure TPedidoItensModel.SetALTURA_M(const Value: Variant);
begin
  FALTURA_M := Value;
end;

procedure TPedidoItensModel.SetAMBIENTE_ID(const Value: Variant);
begin
  FAMBIENTE_ID := Value;
end;

procedure TPedidoItensModel.SetAMBIENTE_OBS(const Value: Variant);
begin
  FAMBIENTE_OBS := Value;
end;

procedure TPedidoItensModel.SetAVULSO(const Value: Variant);
begin
  FAVULSO := Value;
end;

procedure TPedidoItensModel.SetBALANCA(const Value: Variant);
begin
  FBALANCA := Value;
end;

procedure TPedidoItensModel.SetBARRAS_PRO(const Value: Variant);
begin
  FBARRAS_PRO := Value;
end;

procedure TPedidoItensModel.SetBASE_COFINS(const Value: Variant);
begin
  FBASE_COFINS := Value;
end;

procedure TPedidoItensModel.SetBASE_ICMS(const Value: Variant);
begin
  FBASE_ICMS := Value;
end;

procedure TPedidoItensModel.SetBASE_PIS(const Value: Variant);
begin
  FBASE_PIS := Value;
end;

procedure TPedidoItensModel.SetBASE_ST(const Value: Variant);
begin
  FBASE_ST := Value;
end;

procedure TPedidoItensModel.SetBONUS(const Value: Variant);
begin
  FBONUS := Value;
end;

procedure TPedidoItensModel.SetBONUS_USO(const Value: Variant);
begin
  FBONUS_USO := Value;
end;

procedure TPedidoItensModel.SetCBENEF(const Value: Variant);
begin
  FCBENEF := Value;
end;

procedure TPedidoItensModel.SetCFOP(const Value: Variant);
begin
  FCFOP := Value;
end;

procedure TPedidoItensModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;

procedure TPedidoItensModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TPedidoItensModel.SetCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
end;

procedure TPedidoItensModel.SetCOFINS_CST(const Value: Variant);
begin
  FCOFINS_CST := Value;
end;

procedure TPedidoItensModel.SetCOFINS_SUFRAMA(const Value: Variant);
begin
  FCOFINS_SUFRAMA := Value;
end;

procedure TPedidoItensModel.SetCOMBO_ITEM(const Value: Variant);
begin
  FCOMBO_ITEM := Value;
end;

procedure TPedidoItensModel.SetCOMISSAO_PED(const Value: Variant);
begin
  FCOMISSAO_PED := Value;
end;

procedure TPedidoItensModel.SetCOMISSAO_PERCENTUAL(const Value: Variant);
begin
  FCOMISSAO_PERCENTUAL := Value;
end;

procedure TPedidoItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoItensModel.SetCSOSN(const Value: Variant);
begin
  FCSOSN := Value;
end;

procedure TPedidoItensModel.SetCST(const Value: Variant);
begin
  FCST := Value;
end;

procedure TPedidoItensModel.SetCTR_EXPORTACAO(const Value: Variant);
begin
  FCTR_EXPORTACAO := Value;
end;

procedure TPedidoItensModel.SetCUSTO_DRG(const Value: Variant);
begin
  FCUSTO_DRG := Value;
end;

procedure TPedidoItensModel.SetDESCONTO_PED(const Value: Variant);
begin
  FDESCONTO_PED := Value;
end;

procedure TPedidoItensModel.SetDESCONTO_UF(const Value: Variant);
begin
  FDESCONTO_UF := Value;
end;

procedure TPedidoItensModel.SetDESCRICAO_PRODUTO(const Value: Variant);
begin
  FDESCRICAO_PRODUTO := Value;
end;

procedure TPedidoItensModel.SetDESC_RESTITUICAO_ST(const Value: Variant);
begin
  FDESC_RESTITUICAO_ST := Value;
end;

procedure TPedidoItensModel.SetDUN14(const Value: Variant);
begin
  FDUN14 := Value;
end;

procedure TPedidoItensModel.SetENTREGA(const Value: Variant);
begin
  FENTREGA := Value;
end;

procedure TPedidoItensModel.SetFUNCIONARIO_ID(const Value: Variant);
begin
  FFUNCIONARIO_ID := Value;
end;

procedure TPedidoItensModel.SetGERENTE_COMISSAO_PERCENTUAL(
  const Value: Variant);
begin
  FGERENTE_COMISSAO_PERCENTUAL := Value;
end;

procedure TPedidoItensModel.SetPCRED_PRESUMIDO(const Value: Variant);
begin
  FPCRED_PRESUMIDO := Value;
end;

procedure TPedidoItensModel.SetPEDIDOCOMPRAITENS_ID(const Value: Variant);
begin
  FPEDIDOCOMPRAITENS_ID := Value;
end;

procedure TPedidoItensModel.SetPedidoItenssLista(const Value: TObjectList<TPedidoItensModel>);
begin
  FPedidoItenssLista := Value;
end;

procedure TPedidoItensModel.SetICMS_SUFRAMA(const Value: Variant);
begin
  FICMS_SUFRAMA := Value;
end;

procedure TPedidoItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPedidoItensModel.SetIDPedidoVendaView(const Value: String);
begin
  FIDPedidoVendaView := Value;
end;

procedure TPedidoItensModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPedidoItensModel.SetIDUsuario(const Value: String);
begin
  FIDUsuario := Value;
end;
procedure TPedidoItensModel.SetPEDIDOITENS_ID(const Value: Variant);
begin
  FPEDIDOITENS_ID := Value;
end;

procedure TPedidoItensModel.SetPFCPST(const Value: Variant);
begin
  FPFCPST := Value;
end;

procedure TPedidoItensModel.SetPFCPUFDEST(const Value: Variant);
begin
  FPFCPUFDEST := Value;
end;

procedure TPedidoItensModel.SetPICMSINTER(const Value: Variant);
begin
  FPICMSINTER := Value;
end;

procedure TPedidoItensModel.SetPICMSINTERPART(const Value: Variant);
begin
  FPICMSINTERPART := Value;
end;

procedure TPedidoItensModel.SetPICMSUFDEST(const Value: Variant);
begin
  FPICMSUFDEST := Value;
end;

procedure TPedidoItensModel.SetPIS_CST(const Value: Variant);
begin
  FPIS_CST := Value;
end;

procedure TPedidoItensModel.SetPIS_SUFRAMA(const Value: Variant);
begin
  FPIS_SUFRAMA := Value;
end;

procedure TPedidoItensModel.SetPOS_VENDA_OBS(const Value: Variant);
begin
  FPOS_VENDA_OBS := Value;
end;

procedure TPedidoItensModel.SetPOS_VENDA_RETORNO(const Value: Variant);
begin
  FPOS_VENDA_RETORNO := Value;
end;

procedure TPedidoItensModel.SetPOS_VENDA_STATUS(const Value: Variant);
begin
  FPOS_VENDA_STATUS := Value;
end;

procedure TPedidoItensModel.SetPREVENDA_ID(const Value: Variant);
begin
  FPREVENDA_ID := Value;
end;

procedure TPedidoItensModel.SetPRODUCAO_ID(const Value: Variant);
begin
  FPRODUCAO_ID := Value;
end;

procedure TPedidoItensModel.SetPRODUTO_REFERENCIA(const Value: Variant);
begin
  FPRODUTO_REFERENCIA := Value;
end;

procedure TPedidoItensModel.SetPROFUNDIDADE_M(const Value: Variant);
begin
  FPROFUNDIDADE_M := Value;
end;

procedure TPedidoItensModel.SetPROJETO_ID(const Value: Variant);
begin
  FPROJETO_ID := Value;
end;

procedure TPedidoItensModel.SetQTDE_CALCULADA(const Value: Variant);
begin
  FQTDE_CALCULADA := Value;
end;

procedure TPedidoItensModel.SetQTD_CHECAGEM(const Value: Variant);
begin
  FQTD_CHECAGEM := Value;
end;

procedure TPedidoItensModel.SetQTD_CHECAGEM_CORTE(const Value: Variant);
begin
  FQTD_CHECAGEM_CORTE := Value;
end;

procedure TPedidoItensModel.SetQUANTIDADE_KG(const Value: Variant);
begin
  FQUANTIDADE_KG := Value;
end;

procedure TPedidoItensModel.SetQUANTIDADE_NEW(const Value: Variant);
begin
  FQUANTIDADE_NEW := Value;
end;

procedure TPedidoItensModel.SetQUANTIDADE_PED(const Value: Variant);
begin
  FQUANTIDADE_PED := Value;
end;

procedure TPedidoItensModel.SetQUANTIDADE_TIPO(const Value: Variant);
begin
  FQUANTIDADE_TIPO := Value;
end;

procedure TPedidoItensModel.SetQUANTIDADE_TROCA(const Value: Variant);
begin
  FQUANTIDADE_TROCA := Value;
end;

procedure TPedidoItensModel.SetREDUCAO_ICMS(const Value: Variant);
begin
  FREDUCAO_ICMS := Value;
end;

procedure TPedidoItensModel.SetREDUCAO_ST(const Value: Variant);
begin
  FREDUCAO_ST := Value;
end;

procedure TPedidoItensModel.SetRESERVADO(const Value: Variant);
begin
  FRESERVADO := Value;
end;

procedure TPedidoItensModel.SetRESERVA_ID(const Value: Variant);
begin
  FRESERVA_ID := Value;
end;

procedure TPedidoItensModel.SetIMPRESSO(const Value: Variant);
begin
  FIMPRESSO := Value;
end;

procedure TPedidoItensModel.SetIPI_CST(const Value: Variant);
begin
  FIPI_CST := Value;
end;

procedure TPedidoItensModel.SetIPI_SUFRAMA(const Value: Variant);
begin
  FIPI_SUFRAMA := Value;
end;

procedure TPedidoItensModel.SetITEM(const Value: Variant);
begin
  FITEM := Value;
end;

procedure TPedidoItensModel.SetLARGURA(const Value: Variant);
begin
  FLARGURA := Value;
end;

procedure TPedidoItensModel.SetLARGURA_M(const Value: Variant);
begin
  FLARGURA_M := Value;
end;

procedure TPedidoItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TPedidoItensModel.SetMONTAGEM(const Value: Variant);
begin
  FMONTAGEM := Value;
end;

procedure TPedidoItensModel.SetMOTDESICMS(const Value: Variant);
begin
  FMOTDESICMS := Value;
end;

procedure TPedidoItensModel.SetMVA(const Value: Variant);
begin
  FMVA := Value;
end;

procedure TPedidoItensModel.SetNITEMPED2(const Value: Variant);
begin
  FNITEMPED2 := Value;
end;

procedure TPedidoItensModel.SetNOME_PRO(const Value: Variant);
begin
  FNOME_PRO := Value;
end;

procedure TPedidoItensModel.SetNUMERO_PED(const Value: Variant);
begin
  FNUMERO_PED := Value;
end;

procedure TPedidoItensModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TPedidoItensModel.SetOBS_ITEM(const Value: Variant);
begin
  FOBS_ITEM := Value;
end;

procedure TPedidoItensModel.SetORCAMENTO_TSB_ID(const Value: Variant);
begin
  FORCAMENTO_TSB_ID := Value;
end;

procedure TPedidoItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoItensModel.SetORIGINAL_PEDIDO_ID(const Value: Variant);
begin
  FORIGINAL_PEDIDO_ID := Value;
end;

procedure TPedidoItensModel.SetSAIDAS_ID(const Value: Variant);
begin
  FSAIDAS_ID := Value;
end;

procedure TPedidoItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPedidoItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPedidoItensModel.SetTIPO_NF(const Value: Variant);
begin
  FTIPO_NF := Value;
end;

procedure TPedidoItensModel.SetTIPO_VENDA(const Value: Variant);
begin
  FTIPO_VENDA := Value;
end;

procedure TPedidoItensModel.SetTOTAL(const Value: Variant);
begin
  FTOTAL := Value;
end;

procedure TPedidoItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPedidoItensModel.SetTOTAL_PRODUTO(const Value: Variant);
begin
  FTOTAL_PRODUTO := Value;
end;

procedure TPedidoItensModel.SetVALORUNITARIO_PED(const Value: Variant);
begin
  FVALORUNITARIO_PED := Value;
end;

procedure TPedidoItensModel.SetVALOR_BONUS_SERVICO(const Value: Variant);
begin
  FVALOR_BONUS_SERVICO := Value;
end;

procedure TPedidoItensModel.SetVALOR_COFINS(const Value: Variant);
begin
  FVALOR_COFINS := Value;
end;

procedure TPedidoItensModel.SetVALOR_DIFERIMENTO(const Value: Variant);
begin
  FVALOR_DIFERIMENTO := Value;
end;

procedure TPedidoItensModel.SetVALOR_ICMS(const Value: Variant);
begin
  FVALOR_ICMS := Value;
end;

procedure TPedidoItensModel.SetVALOR_IPI(const Value: Variant);
begin
  FVALOR_IPI := Value;
end;

procedure TPedidoItensModel.SetVALOR_MONTADOR(const Value: Variant);
begin
  FVALOR_MONTADOR := Value;
end;

procedure TPedidoItensModel.SetVALOR_PIS(const Value: Variant);
begin
  FVALOR_PIS := Value;
end;

procedure TPedidoItensModel.SetVALOR_RESTITUICAO_ST(const Value: Variant);
begin
  FVALOR_RESTITUICAO_ST := Value;
end;

procedure TPedidoItensModel.SetVALOR_ST(const Value: Variant);
begin
  FVALOR_ST := Value;
end;

procedure TPedidoItensModel.SetVALOR_SUFRAMA_ITEM(const Value: Variant);
begin
  FVALOR_SUFRAMA_ITEM := Value;
end;

procedure TPedidoItensModel.SetVALOR_SUFRAMA_ITEM_NEW(const Value: Variant);
begin
  FVALOR_SUFRAMA_ITEM_NEW := Value;
end;

procedure TPedidoItensModel.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;

procedure TPedidoItensModel.SetVALOR_TOTAL_DESCONTO(const Value: Variant);
begin
  FVALOR_TOTAL_DESCONTO := Value;
end;

procedure TPedidoItensModel.SetVALOR_TOTAL_GARANTIA(const Value: Variant);
begin
  FVALOR_TOTAL_GARANTIA := Value;
end;

procedure TPedidoItensModel.SetVALOR_TOTAL_ITENS(const Value: Variant);
begin
  FVALOR_TOTAL_ITENS := Value;
end;

procedure TPedidoItensModel.SetVALOR_VENDA_CADASTRO(const Value: Variant);
begin
  FVALOR_VENDA_CADASTRO := Value;
end;

procedure TPedidoItensModel.SetVBCFCPST(const Value: Variant);
begin
  FVBCFCPST := Value;
end;

procedure TPedidoItensModel.SetVBCUFDEST(const Value: Variant);
begin
  FVBCUFDEST := Value;
end;

procedure TPedidoItensModel.SetVDESC(const Value: Variant);
begin
  FVDESC := Value;
end;

procedure TPedidoItensModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TPedidoItensModel.SetVFCPUFDEST(const Value: Variant);
begin
  FVFCPUFDEST := Value;
end;

procedure TPedidoItensModel.SetVFRETE(const Value: Variant);
begin
  FVFRETE := Value;
end;

procedure TPedidoItensModel.SetVICMSDESON(const Value: Variant);
begin
  FVICMSDESON := Value;
end;

procedure TPedidoItensModel.SetVICMSUFDEST(const Value: Variant);
begin
  FVICMSUFDEST := Value;
end;

procedure TPedidoItensModel.SetVICMSUFREMET(const Value: Variant);
begin
  FVICMSUFREMET := Value;
end;

procedure TPedidoItensModel.SetVLRCUSTO_PRO(const Value: Variant);
begin
  FVLRCUSTO_PRO := Value;
end;

procedure TPedidoItensModel.SetVLRVENDA_MAXIMO(const Value: Variant);
begin
  FVLRVENDA_MAXIMO := Value;
end;

procedure TPedidoItensModel.SetVLRVENDA_MINIMO(const Value: Variant);
begin
  FVLRVENDA_MINIMO := Value;
end;

procedure TPedidoItensModel.SetVLRVENDA_PRO(const Value: Variant);
begin
  FVLRVENDA_PRO := Value;
end;

procedure TPedidoItensModel.SetVOUTROS(const Value: Variant);
begin
  FVOUTROS := Value;
end;

procedure TPedidoItensModel.SetWEB_PEDIDOITENS_ID(const Value: Variant);
begin
  FWEB_PEDIDOITENS_ID := Value;
end;

procedure TPedidoItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TPedidoItensModel.SetXPED(const Value: Variant);
begin
  FXPED := Value;
end;

end.
