unit EntradaItensModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TEntradaItensModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCUSTO_COMPRA_NEW: Variant;
    FCST_O09: Variant;
    FVBCSTRET: Variant;
    FQTD_CHECAGEM: Variant;
    FQBCPROD_S09: Variant;
    FICMS_ST_ORIGINAL: Variant;
    FCLISTSERV_U06: Variant;
    FVII_P04: Variant;
    FBASE_ST_ENT: Variant;
    FVENDA2_PRO: Variant;
    FALIQ_CREDITO_PIS: Variant;
    FCSITTRIB_U07: Variant;
    FPCOFINS_S08: Variant;
    FALIQ_CREDITO_COFINS: Variant;
    FVFRETE_I15: Variant;
    FPPIS_Q08: Variant;
    FDATA_VECTO: Variant;
    FPFCP: Variant;
    FVBC_R02: Variant;
    FCODIGO_FOR: Variant;
    FCUSTO_DEVOLUCAO: Variant;
    FCUSTOMEDIO_ANTERIOR: Variant;
    FVALIQPROD_S10: Variant;
    FVFCP: Variant;
    FDESC_I17: Variant;
    FVPIS_Q09: Variant;
    FVBC_P02: Variant;
    FPPIS_R03: Variant;
    FPREDBC_N14: Variant;
    FTRIBUTA_PIS: Variant;
    FVALIQ_U03: Variant;
    FVALIQPROD_R05: Variant;
    FVALIQPROD_Q11: Variant;
    FTRIBUTA_COFINS: Variant;
    FICMS_ENT: Variant;
    FVALORUNI_ENT: Variant;
    FCUSTOULTIMO_ANTERIOR: Variant;
    FVBCFCPST: Variant;
    FVBC_T02: Variant;
    FVBC_S07: Variant;
    FQBCPROD_R04: Variant;
    FQBCPROD_Q10: Variant;
    FMOBIBC_N13: Variant;
    FVENDA_PRO: Variant;
    FDATA_ATUALIZACAO_PRECO_VENDA: Variant;
    FVBC_U02: Variant;
    FVBCFCPSTRET: Variant;
    FVPIS_R06: Variant;
    FVBC_Q07: Variant;
    FCONTA_CONTABIL: Variant;
    FVICMS_ST_ENT: Variant;
    FDATA_FAB: Variant;
    FMARGEM_PRO: Variant;
    FVFRETE_I15_2: Variant;
    FCMUNFG_U05: Variant;
    FVALIQPROD_T05: Variant;
    FPCOFINS_T03: Variant;
    FVCOFINS_S11: Variant;
    FSERIE_ENT: Variant;
    FID: Variant;
    FATUALIZADO_VALOR_VENDA: Variant;
    FVIOF_P05: Variant;
    FVICMS_N17: Variant;
    FCFOP: Variant;
    FBASE_ST_ORIGINAL: Variant;
    FQBCPROD_T04: Variant;
    FVISSQN_U04: Variant;
    FLOJA: Variant;
    FSTATUS: Variant;
    FNUMERO_ENT: Variant;
    FVALOR_ATUALIZACAO_PRECO_VENDA: Variant;
    FCFOP_ID: Variant;
    FPIS: Variant;
    FICMS_ST_ENT: Variant;
    FCODIGO_PRO: Variant;
    FVICMS_ORIGINAL: Variant;
    FVCOFINS_T06: Variant;
    FORIG_N11: Variant;
    FVUNID_O12: Variant;
    FCOFINS: Variant;
    FPRECO_DOLAR: Variant;
    FSYSTIME: Variant;
    FCST_CREDITO_PIS: Variant;
    FVBC_O10: Variant;
    FITEM_ENT: Variant;
    FBASE_ICMS_ENT: Variant;
    FVBCFPC: Variant;
    FCST_CREDITO_COFINS: Variant;
    FQUNID_O11: Variant;
    FPREDBCST_N20: Variant;
    FVICMSSUBISTITUTORET: Variant;
    FCST_ENTRADA: Variant;
    FPICMSSTRET: Variant;
    FESTOQUE_2: Variant;
    FVSEG_I16: Variant;
    FNUMERO_LOTE: Variant;
    FQUANTIDADE_ENT: Variant;
    FMDBCST_N18: Variant;
    FVICMSSTRET: Variant;
    FPFCPST: Variant;
    FVDESPADU_P03: Variant;
    FVALOR_VENDA: Variant;
    FPFCPSTRET: Variant;
    FVFCPST: Variant;
    FVIPI_014: Variant;
    FPMVAST_N19: Variant;
    FVICMS_ST_ORIGINAL: Variant;
    FCST_S06: Variant;
    FCIENQ_O02: Variant;
    FVFCPSTRET: Variant;
    FNCM_I05: Variant;
    FCREDITA_ICMS: Variant;
    FCST_Q06: Variant;
    FCENQ_O06: Variant;
    FCST_ENT: Variant;
    FCUSTO_COMPRA: Variant;
    FIPI_ENT: Variant;
    FIDEntrada: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetALIQ_CREDITO_COFINS(const Value: Variant);
    procedure SetALIQ_CREDITO_PIS(const Value: Variant);
    procedure SetATUALIZADO_VALOR_VENDA(const Value: Variant);
    procedure SetBASE_ICMS_ENT(const Value: Variant);
    procedure SetBASE_ST_ENT(const Value: Variant);
    procedure SetBASE_ST_ORIGINAL(const Value: Variant);
    procedure SetCENQ_O06(const Value: Variant);
    procedure SetCFOP(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCIENQ_O02(const Value: Variant);
    procedure SetCLISTSERV_U06(const Value: Variant);
    procedure SetCMUNFG_U05(const Value: Variant);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCODIGO_PRO(const Value: Variant);
    procedure SetCOFINS(const Value: Variant);
    procedure SetCONTA_CONTABIL(const Value: Variant);
    procedure SetCREDITA_ICMS(const Value: Variant);
    procedure SetCSITTRIB_U07(const Value: Variant);
    procedure SetCST_CREDITO_COFINS(const Value: Variant);
    procedure SetCST_CREDITO_PIS(const Value: Variant);
    procedure SetCST_ENT(const Value: Variant);
    procedure SetCST_ENTRADA(const Value: Variant);
    procedure SetCST_O09(const Value: Variant);
    procedure SetCST_Q06(const Value: Variant);
    procedure SetCST_S06(const Value: Variant);
    procedure SetCUSTO_COMPRA(const Value: Variant);
    procedure SetCUSTO_COMPRA_NEW(const Value: Variant);
    procedure SetCUSTO_DEVOLUCAO(const Value: Variant);
    procedure SetCUSTOMEDIO_ANTERIOR(const Value: Variant);
    procedure SetCUSTOULTIMO_ANTERIOR(const Value: Variant);
    procedure SetDATA_ATUALIZACAO_PRECO_VENDA(const Value: Variant);
    procedure SetDATA_FAB(const Value: Variant);
    procedure SetDATA_VECTO(const Value: Variant);
    procedure SetDESC_I17(const Value: Variant);
    procedure SetESTOQUE_2(const Value: Variant);
    procedure SetICMS_ENT(const Value: Variant);
    procedure SetICMS_ST_ENT(const Value: Variant);
    procedure SetICMS_ST_ORIGINAL(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIPI_ENT(const Value: Variant);
    procedure SetITEM_ENT(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetMARGEM_PRO(const Value: Variant);
    procedure SetMDBCST_N18(const Value: Variant);
    procedure SetMOBIBC_N13(const Value: Variant);
    procedure SetNCM_I05(const Value: Variant);
    procedure SetNUMERO_ENT(const Value: Variant);
    procedure SetNUMERO_LOTE(const Value: Variant);
    procedure SetORIG_N11(const Value: Variant);
    procedure SetPCOFINS_S08(const Value: Variant);
    procedure SetPCOFINS_T03(const Value: Variant);
    procedure SetPFCP(const Value: Variant);
    procedure SetPFCPST(const Value: Variant);
    procedure SetPFCPSTRET(const Value: Variant);
    procedure SetPICMSSTRET(const Value: Variant);
    procedure SetPIS(const Value: Variant);
    procedure SetPMVAST_N19(const Value: Variant);
    procedure SetPPIS_Q08(const Value: Variant);
    procedure SetPPIS_R03(const Value: Variant);
    procedure SetPRECO_DOLAR(const Value: Variant);
    procedure SetPREDBC_N14(const Value: Variant);
    procedure SetPREDBCST_N20(const Value: Variant);
    procedure SetQBCPROD_Q10(const Value: Variant);
    procedure SetQBCPROD_R04(const Value: Variant);
    procedure SetQBCPROD_S09(const Value: Variant);
    procedure SetQBCPROD_T04(const Value: Variant);
    procedure SetQTD_CHECAGEM(const Value: Variant);
    procedure SetQUANTIDADE_ENT(const Value: Variant);
    procedure SetQUNID_O11(const Value: Variant);
    procedure SetSERIE_ENT(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTRIBUTA_COFINS(const Value: Variant);
    procedure SetTRIBUTA_PIS(const Value: Variant);
    procedure SetVALIQ_U03(const Value: Variant);
    procedure SetVALIQPROD_Q11(const Value: Variant);
    procedure SetVALIQPROD_R05(const Value: Variant);
    procedure SetVALIQPROD_S10(const Value: Variant);
    procedure SetVALIQPROD_T05(const Value: Variant);
    procedure SetVALOR_ATUALIZACAO_PRECO_VENDA(const Value: Variant);
    procedure SetVALOR_VENDA(const Value: Variant);
    procedure SetVALORUNI_ENT(const Value: Variant);
    procedure SetVBC_O10(const Value: Variant);
    procedure SetVBC_P02(const Value: Variant);
    procedure SetVBC_Q07(const Value: Variant);
    procedure SetVBC_R02(const Value: Variant);
    procedure SetVBC_S07(const Value: Variant);
    procedure SetVBC_T02(const Value: Variant);
    procedure SetVBC_U02(const Value: Variant);
    procedure SetVBCFCPST(const Value: Variant);
    procedure SetVBCFCPSTRET(const Value: Variant);
    procedure SetVBCFPC(const Value: Variant);
    procedure SetVBCSTRET(const Value: Variant);
    procedure SetVCOFINS_S11(const Value: Variant);
    procedure SetVCOFINS_T06(const Value: Variant);
    procedure SetVDESPADU_P03(const Value: Variant);
    procedure SetVENDA_PRO(const Value: Variant);
    procedure SetVENDA2_PRO(const Value: Variant);
    procedure SetVFCP(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetVFCPSTRET(const Value: Variant);
    procedure SetVFRETE_I15(const Value: Variant);
    procedure SetVFRETE_I15_2(const Value: Variant);
    procedure SetVICMS_N17(const Value: Variant);
    procedure SetVICMS_ORIGINAL(const Value: Variant);
    procedure SetVICMS_ST_ENT(const Value: Variant);
    procedure SetVICMS_ST_ORIGINAL(const Value: Variant);
    procedure SetVICMSSTRET(const Value: Variant);
    procedure SetVICMSSUBISTITUTORET(const Value: Variant);
    procedure SetVII_P04(const Value: Variant);
    procedure SetVIOF_P05(const Value: Variant);
    procedure SetVIPI_014(const Value: Variant);
    procedure SetVISSQN_U04(const Value: Variant);
    procedure SetVPIS_Q09(const Value: Variant);
    procedure SetVPIS_R06(const Value: Variant);
    procedure SetVSEG_I16(const Value: Variant);
    procedure SetVUNID_O12(const Value: Variant);
    procedure SetIDEntrada(const Value: String);

  public

    property NUMERO_ENT                     : Variant  read FNUMERO_ENT write SetNUMERO_ENT;
    property CODIGO_FOR                     : Variant  read FCODIGO_FOR write SetCODIGO_FOR;
    property CODIGO_PRO                     : Variant  read FCODIGO_PRO write SetCODIGO_PRO;
    property QUANTIDADE_ENT                 : Variant  read FQUANTIDADE_ENT write SetQUANTIDADE_ENT;
    property VALORUNI_ENT                   : Variant  read FVALORUNI_ENT write SetVALORUNI_ENT;
    property IPI_ENT                        : Variant  read FIPI_ENT write SetIPI_ENT;
    property STATUS                         : Variant  read FSTATUS write SetSTATUS;
    property NUMERO_LOTE                    : Variant  read FNUMERO_LOTE write SetNUMERO_LOTE;
    property LOJA                           : Variant  read FLOJA write SetLOJA;
    property CUSTO_COMPRA                   : Variant  read FCUSTO_COMPRA write SetCUSTO_COMPRA;
    property ID                             : Variant  read FID write SetID;
    property VENDA_PRO                      : Variant  read FVENDA_PRO write SetVENDA_PRO;
    property VENDA2_PRO                     : Variant  read FVENDA2_PRO write SetVENDA2_PRO;
    property DATA_FAB                       : Variant  read FDATA_FAB write SetDATA_FAB;
    property DATA_VECTO                     : Variant  read FDATA_VECTO write SetDATA_VECTO;
    property ICMS_ENT                       : Variant  read FICMS_ENT write SetICMS_ENT;
    property BASE_ICMS_ENT                  : Variant  read FBASE_ICMS_ENT write SetBASE_ICMS_ENT;
    property SERIE_ENT                      : Variant  read FSERIE_ENT write SetSERIE_ENT;
    property BASE_ST_ENT                    : Variant  read FBASE_ST_ENT write SetBASE_ST_ENT;
    property ICMS_ST_ENT                    : Variant  read FICMS_ST_ENT write SetICMS_ST_ENT;
    property CST_ENT                        : Variant  read FCST_ENT write SetCST_ENT;
    property PIS                            : Variant  read FPIS write SetPIS;
    property COFINS                         : Variant  read FCOFINS write SetCOFINS;
    property VICMS_ST_ENT                   : Variant  read FVICMS_ST_ENT write SetVICMS_ST_ENT;
    property ITEM_ENT                       : Variant  read FITEM_ENT write SetITEM_ENT;
    property CFOP                           : Variant  read FCFOP write SetCFOP;
    property VICMS_N17                      : Variant  read FVICMS_N17 write SetVICMS_N17;
    property MDBCST_N18                     : Variant  read FMDBCST_N18 write SetMDBCST_N18;
    property PMVAST_N19                     : Variant  read FPMVAST_N19 write SetPMVAST_N19;
    property PREDBCST_N20                   : Variant  read FPREDBCST_N20 write SetPREDBCST_N20;
    property PREDBC_N14                     : Variant  read FPREDBC_N14 write SetPREDBC_N14;
    property CST_O09                        : Variant  read FCST_O09 write SetCST_O09;
    property CIENQ_O02                      : Variant  read FCIENQ_O02 write SetCIENQ_O02;
    property CENQ_O06                       : Variant  read FCENQ_O06 write SetCENQ_O06;
    property VBC_O10                        : Variant  read FVBC_O10 write SetVBC_O10;
    property QUNID_O11                      : Variant  read FQUNID_O11 write SetQUNID_O11;
    property VUNID_O12                      : Variant  read FVUNID_O12 write SetVUNID_O12;
    property VIPI_014                       : Variant  read FVIPI_014 write SetVIPI_014;
    property VBC_P02                        : Variant  read FVBC_P02 write SetVBC_P02;
    property VDESPADU_P03                   : Variant  read FVDESPADU_P03 write SetVDESPADU_P03;
    property VII_P04                        : Variant  read FVII_P04 write SetVII_P04;
    property VIOF_P05                       : Variant  read FVIOF_P05 write SetVIOF_P05;
    property ORIG_N11                       : Variant  read FORIG_N11 write SetORIG_N11;
    property MOBIBC_N13                     : Variant  read FMOBIBC_N13 write SetMOBIBC_N13;
    property CST_Q06                        : Variant  read FCST_Q06 write SetCST_Q06;
    property VBC_Q07                        : Variant  read FVBC_Q07 write SetVBC_Q07;
    property PPIS_Q08                       : Variant  read FPPIS_Q08 write SetPPIS_Q08;
    property VPIS_Q09                       : Variant  read FVPIS_Q09 write SetVPIS_Q09;
    property QBCPROD_Q10                    : Variant  read FQBCPROD_Q10 write SetQBCPROD_Q10;
    property VALIQPROD_Q11                  : Variant  read FVALIQPROD_Q11 write SetVALIQPROD_Q11;
    property VBC_R02                        : Variant  read FVBC_R02 write SetVBC_R02;
    property PPIS_R03                       : Variant  read FPPIS_R03 write SetPPIS_R03;
    property QBCPROD_R04                    : Variant  read FQBCPROD_R04 write SetQBCPROD_R04;
    property VALIQPROD_R05                  : Variant  read FVALIQPROD_R05 write SetVALIQPROD_R05;
    property VPIS_R06                       : Variant  read FVPIS_R06 write SetVPIS_R06;
    property CST_S06                        : Variant  read FCST_S06 write SetCST_S06;
    property VBC_S07                        : Variant  read FVBC_S07 write SetVBC_S07;
    property PCOFINS_S08                    : Variant  read FPCOFINS_S08 write SetPCOFINS_S08;
    property VCOFINS_S11                    : Variant  read FVCOFINS_S11 write SetVCOFINS_S11;
    property QBCPROD_S09                    : Variant  read FQBCPROD_S09 write SetQBCPROD_S09;
    property VALIQPROD_S10                  : Variant  read FVALIQPROD_S10 write SetVALIQPROD_S10;
    property VBC_T02                        : Variant  read FVBC_T02 write SetVBC_T02;
    property PCOFINS_T03                    : Variant  read FPCOFINS_T03 write SetPCOFINS_T03;
    property QBCPROD_T04                    : Variant  read FQBCPROD_T04 write SetQBCPROD_T04;
    property VALIQPROD_T05                  : Variant  read FVALIQPROD_T05 write SetVALIQPROD_T05;
    property VCOFINS_T06                    : Variant  read FVCOFINS_T06 write SetVCOFINS_T06;
    property VBC_U02                        : Variant  read FVBC_U02 write SetVBC_U02;
    property VALIQ_U03                      : Variant  read FVALIQ_U03 write SetVALIQ_U03;
    property VISSQN_U04                     : Variant  read FVISSQN_U04 write SetVISSQN_U04;
    property CMUNFG_U05                     : Variant  read FCMUNFG_U05 write SetCMUNFG_U05;
    property CLISTSERV_U06                  : Variant  read FCLISTSERV_U06 write SetCLISTSERV_U06;
    property CSITTRIB_U07                   : Variant  read FCSITTRIB_U07 write SetCSITTRIB_U07;
    property DESC_I17                       : Variant  read FDESC_I17 write SetDESC_I17;
    property NCM_I05                        : Variant  read FNCM_I05 write SetNCM_I05;
    property VFRETE_I15                     : Variant  read FVFRETE_I15 write SetVFRETE_I15;
    property VSEG_I16                       : Variant  read FVSEG_I16 write SetVSEG_I16;
    property CFOP_ID                        : Variant  read FCFOP_ID write SetCFOP_ID;
    property ALIQ_CREDITO_PIS               : Variant  read FALIQ_CREDITO_PIS write SetALIQ_CREDITO_PIS;
    property ALIQ_CREDITO_COFINS            : Variant  read FALIQ_CREDITO_COFINS write SetALIQ_CREDITO_COFINS;
    property CST_CREDITO_COFINS             : Variant  read FCST_CREDITO_COFINS write SetCST_CREDITO_COFINS;
    property CST_CREDITO_PIS                : Variant  read FCST_CREDITO_PIS write SetCST_CREDITO_PIS;
    property TRIBUTA_COFINS                 : Variant  read FTRIBUTA_COFINS write SetTRIBUTA_COFINS;
    property TRIBUTA_PIS                    : Variant  read FTRIBUTA_PIS write SetTRIBUTA_PIS;
    property CREDITA_ICMS                   : Variant  read FCREDITA_ICMS write SetCREDITA_ICMS;
    property CONTA_CONTABIL                 : Variant  read FCONTA_CONTABIL write SetCONTA_CONTABIL;
    property CST_ENTRADA                    : Variant  read FCST_ENTRADA write SetCST_ENTRADA;
    property SYSTIME                        : Variant  read FSYSTIME write SetSYSTIME;
    property ESTOQUE_2                      : Variant  read FESTOQUE_2 write SetESTOQUE_2;
    property PRECO_DOLAR                    : Variant  read FPRECO_DOLAR write SetPRECO_DOLAR;
    property CUSTO_COMPRA_NEW               : Variant  read FCUSTO_COMPRA_NEW write SetCUSTO_COMPRA_NEW;
    property VBCFCPST                       : Variant  read FVBCFCPST write SetVBCFCPST;
    property PFCPST                         : Variant  read FPFCPST write SetPFCPST;
    property VFCPST                         : Variant  read FVFCPST write SetVFCPST;
    property VBCFCPSTRET                    : Variant  read FVBCFCPSTRET write SetVBCFCPSTRET;
    property PFCPSTRET                      : Variant  read FPFCPSTRET write SetPFCPSTRET;
    property VFCPSTRET                      : Variant  read FVFCPSTRET write SetVFCPSTRET;
    property VBCFPC                         : Variant  read FVBCFPC write SetVBCFPC;
    property PFCP                           : Variant  read FPFCP write SetPFCP;
    property VFCP                           : Variant  read FVFCP write SetVFCP;
    property VFRETE_I15_2                   : Variant  read FVFRETE_I15_2 write SetVFRETE_I15_2;
    property CUSTOMEDIO_ANTERIOR            : Variant  read FCUSTOMEDIO_ANTERIOR write SetCUSTOMEDIO_ANTERIOR;
    property CUSTOULTIMO_ANTERIOR           : Variant  read FCUSTOULTIMO_ANTERIOR write SetCUSTOULTIMO_ANTERIOR;
    property ATUALIZADO_VALOR_VENDA         : Variant  read FATUALIZADO_VALOR_VENDA write SetATUALIZADO_VALOR_VENDA;
    property VALOR_VENDA                    : Variant  read FVALOR_VENDA write SetVALOR_VENDA;
    property QTD_CHECAGEM                   : Variant  read FQTD_CHECAGEM write SetQTD_CHECAGEM;
    property MARGEM_PRO                     : Variant  read FMARGEM_PRO write SetMARGEM_PRO;
    property VBCSTRET                       : Variant  read FVBCSTRET write SetVBCSTRET;
    property VICMSSTRET                     : Variant  read FVICMSSTRET write SetVICMSSTRET;
    property DATA_ATUALIZACAO_PRECO_VENDA   : Variant  read FDATA_ATUALIZACAO_PRECO_VENDA write SetDATA_ATUALIZACAO_PRECO_VENDA;
    property VALOR_ATUALIZACAO_PRECO_VENDA  : Variant  read FVALOR_ATUALIZACAO_PRECO_VENDA write SetVALOR_ATUALIZACAO_PRECO_VENDA;
    property CUSTO_DEVOLUCAO                : Variant  read FCUSTO_DEVOLUCAO write SetCUSTO_DEVOLUCAO;
    property VICMS_ST_ORIGINAL              : Variant  read FVICMS_ST_ORIGINAL write SetVICMS_ST_ORIGINAL;
    property BASE_ST_ORIGINAL               : Variant  read FBASE_ST_ORIGINAL write SetBASE_ST_ORIGINAL;
    property ICMS_ST_ORIGINAL               : Variant  read FICMS_ST_ORIGINAL write SetICMS_ST_ORIGINAL;
    property VICMS_ORIGINAL                 : Variant  read FVICMS_ORIGINAL write SetVICMS_ORIGINAL;
    property VICMSSUBISTITUTORET            : Variant  read FVICMSSUBISTITUTORET write SetVICMSSUBISTITUTORET;
    property PICMSSTRET                     : Variant  read FPICMSSTRET write SetPICMSSTRET;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TEntradaItensModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId: String): TEntradaItensModel;
    function obterLista : TFDMemTable;

   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDEntrada: String read FIDEntrada write SetIDEntrada;

  end;

implementation

uses
  EntradaItensDao;

{ TEntradaItensModel }

function TEntradaItensModel.Alterar(pID : String): TEntradaItensModel;
var
  lEntradaItensModel : TEntradaItensModel;
begin
  lEntradaItensModel := TEntradaItensModel.Create(vIConexao);
  try
    lEntradaItensModel       := lEntradaItensModel.carregaClasse(pID);
    lEntradaItensModel.Acao  := tacAlterar;
    Result                   := lEntradaItensModel;
  finally
  end;
end;

function TEntradaItensModel.Excluir(pID: String): String;
begin
  self.FID   := pID;
  self.FAcao := tacExcluir;
  Result     := self.Salvar;
end;

function TEntradaItensModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  self.Salvar;
end;

function TEntradaItensModel.carregaClasse(pId: String): TEntradaItensModel;
var
  lEntradaItensDao: TEntradaItensDao;
begin
  lEntradaItensDao := TEntradaItensDao.Create(vIConexao);

  try
    Result := lEntradaItensDao.carregaClasse(pId);
  finally
    lEntradaItensDao.Free;
  end;
end;

constructor TEntradaItensModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TEntradaItensModel.Destroy;
begin

  inherited;
end;

function TEntradaItensModel.obterLista: TFDMemTable;
var
  lEntradaItensLista: TEntradaItensDao;
begin
  lEntradaItensLista := TEntradaItensDao.Create(vIConexao);
  try
    lEntradaItensLista.TotalRecords    := FTotalRecords;
    lEntradaItensLista.WhereView       := FWhereView;
    lEntradaItensLista.CountView       := FCountView;
    lEntradaItensLista.OrderView       := FOrderView;
    lEntradaItensLista.StartRecordView := FStartRecordView;
    lEntradaItensLista.LengthPageView  := FLengthPageView;
    lEntradaItensLista.IDRecordView    := FIDRecordView;
    lEntradaItensLista.IDEntrada       := FIDEntrada;

    Result := lEntradaItensLista.obterLista;

    FTotalRecords  := lEntradaItensLista.TotalRecords;

  finally
    lEntradaItensLista.Free;
  end;
end;

function TEntradaItensModel.Salvar: String;
var
  lEntradaItensDao: TEntradaItensDao;
begin
  lEntradaItensDao := TEntradaItensDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lEntradaItensDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lEntradaItensDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lEntradaItensDao.excluir(Self);
    end;

  finally
    lEntradaItensDao.Free;
  end;
end;

procedure TEntradaItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TEntradaItensModel.SetALIQ_CREDITO_COFINS(const Value: Variant);
begin
  FALIQ_CREDITO_COFINS := Value;
end;

procedure TEntradaItensModel.SetALIQ_CREDITO_PIS(const Value: Variant);
begin
  FALIQ_CREDITO_PIS := Value;
end;

procedure TEntradaItensModel.SetATUALIZADO_VALOR_VENDA(const Value: Variant);
begin
  FATUALIZADO_VALOR_VENDA := Value;
end;

procedure TEntradaItensModel.SetBASE_ICMS_ENT(const Value: Variant);
begin
  FBASE_ICMS_ENT := Value;
end;

procedure TEntradaItensModel.SetBASE_ST_ENT(const Value: Variant);
begin
  FBASE_ST_ENT := Value;
end;

procedure TEntradaItensModel.SetBASE_ST_ORIGINAL(const Value: Variant);
begin
  FBASE_ST_ORIGINAL := Value;
end;

procedure TEntradaItensModel.SetCENQ_O06(const Value: Variant);
begin
  FCENQ_O06 := Value;
end;

procedure TEntradaItensModel.SetCFOP(const Value: Variant);
begin
  FCFOP := Value;
end;

procedure TEntradaItensModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;

procedure TEntradaItensModel.SetCIENQ_O02(const Value: Variant);
begin
  FCIENQ_O02 := Value;
end;

procedure TEntradaItensModel.SetCLISTSERV_U06(const Value: Variant);
begin
  FCLISTSERV_U06 := Value;
end;

procedure TEntradaItensModel.SetCMUNFG_U05(const Value: Variant);
begin
  FCMUNFG_U05 := Value;
end;

procedure TEntradaItensModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;

procedure TEntradaItensModel.SetCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
end;

procedure TEntradaItensModel.SetCOFINS(const Value: Variant);
begin
  FCOFINS := Value;
end;

procedure TEntradaItensModel.SetCONTA_CONTABIL(const Value: Variant);
begin
  FCONTA_CONTABIL := Value;
end;

procedure TEntradaItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TEntradaItensModel.SetCREDITA_ICMS(const Value: Variant);
begin
  FCREDITA_ICMS := Value;
end;

procedure TEntradaItensModel.SetCSITTRIB_U07(const Value: Variant);
begin
  FCSITTRIB_U07 := Value;
end;

procedure TEntradaItensModel.SetCST_CREDITO_COFINS(const Value: Variant);
begin
  FCST_CREDITO_COFINS := Value;
end;

procedure TEntradaItensModel.SetCST_CREDITO_PIS(const Value: Variant);
begin
  FCST_CREDITO_PIS := Value;
end;

procedure TEntradaItensModel.SetCST_ENT(const Value: Variant);
begin
  FCST_ENT := Value;
end;

procedure TEntradaItensModel.SetCST_ENTRADA(const Value: Variant);
begin
  FCST_ENTRADA := Value;
end;

procedure TEntradaItensModel.SetCST_O09(const Value: Variant);
begin
  FCST_O09 := Value;
end;

procedure TEntradaItensModel.SetCST_Q06(const Value: Variant);
begin
  FCST_Q06 := Value;
end;

procedure TEntradaItensModel.SetCST_S06(const Value: Variant);
begin
  FCST_S06 := Value;
end;

procedure TEntradaItensModel.SetCUSTOMEDIO_ANTERIOR(const Value: Variant);
begin
  FCUSTOMEDIO_ANTERIOR := Value;
end;

procedure TEntradaItensModel.SetCUSTOULTIMO_ANTERIOR(const Value: Variant);
begin
  FCUSTOULTIMO_ANTERIOR := Value;
end;

procedure TEntradaItensModel.SetCUSTO_COMPRA(const Value: Variant);
begin
  FCUSTO_COMPRA := Value;
end;

procedure TEntradaItensModel.SetCUSTO_COMPRA_NEW(const Value: Variant);
begin
  FCUSTO_COMPRA_NEW := Value;
end;

procedure TEntradaItensModel.SetCUSTO_DEVOLUCAO(const Value: Variant);
begin
  FCUSTO_DEVOLUCAO := Value;
end;

procedure TEntradaItensModel.SetDATA_ATUALIZACAO_PRECO_VENDA(
  const Value: Variant);
begin
  FDATA_ATUALIZACAO_PRECO_VENDA := Value;
end;

procedure TEntradaItensModel.SetDATA_FAB(const Value: Variant);
begin
  FDATA_FAB := Value;
end;

procedure TEntradaItensModel.SetDATA_VECTO(const Value: Variant);
begin
  FDATA_VECTO := Value;
end;

procedure TEntradaItensModel.SetDESC_I17(const Value: Variant);
begin
  FDESC_I17 := Value;
end;

procedure TEntradaItensModel.SetESTOQUE_2(const Value: Variant);
begin
  FESTOQUE_2 := Value;
end;

procedure TEntradaItensModel.SetICMS_ENT(const Value: Variant);
begin
  FICMS_ENT := Value;
end;

procedure TEntradaItensModel.SetICMS_ST_ENT(const Value: Variant);
begin
  FICMS_ST_ENT := Value;
end;

procedure TEntradaItensModel.SetICMS_ST_ORIGINAL(const Value: Variant);
begin
  FICMS_ST_ORIGINAL := Value;
end;

procedure TEntradaItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEntradaItensModel.SetIDEntrada(const Value: String);
begin
  FIDEntrada := Value;
end;

procedure TEntradaItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TEntradaItensModel.SetIPI_ENT(const Value: Variant);
begin
  FIPI_ENT := Value;
end;

procedure TEntradaItensModel.SetITEM_ENT(const Value: Variant);
begin
  FITEM_ENT := Value;
end;

procedure TEntradaItensModel.SetLengthPageView(const Value: String);
begin

end;

procedure TEntradaItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TEntradaItensModel.SetMARGEM_PRO(const Value: Variant);
begin
  FMARGEM_PRO := Value;
end;

procedure TEntradaItensModel.SetMDBCST_N18(const Value: Variant);
begin
  FMDBCST_N18 := Value;
end;

procedure TEntradaItensModel.SetMOBIBC_N13(const Value: Variant);
begin
  FMOBIBC_N13 := Value;
end;

procedure TEntradaItensModel.SetNCM_I05(const Value: Variant);
begin
  FNCM_I05 := Value;
end;

procedure TEntradaItensModel.SetNUMERO_ENT(const Value: Variant);
begin
  FNUMERO_ENT := Value;
end;

procedure TEntradaItensModel.SetNUMERO_LOTE(const Value: Variant);
begin
  FNUMERO_LOTE := Value;
end;

procedure TEntradaItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TEntradaItensModel.SetORIG_N11(const Value: Variant);
begin
  FORIG_N11 := Value;
end;

procedure TEntradaItensModel.SetPCOFINS_S08(const Value: Variant);
begin
  FPCOFINS_S08 := Value;
end;

procedure TEntradaItensModel.SetPCOFINS_T03(const Value: Variant);
begin
  FPCOFINS_T03 := Value;
end;

procedure TEntradaItensModel.SetPFCP(const Value: Variant);
begin
  FPFCP := Value;
end;

procedure TEntradaItensModel.SetPFCPST(const Value: Variant);
begin
  FPFCPST := Value;
end;

procedure TEntradaItensModel.SetPFCPSTRET(const Value: Variant);
begin
  FPFCPSTRET := Value;
end;

procedure TEntradaItensModel.SetPICMSSTRET(const Value: Variant);
begin
  FPICMSSTRET := Value;
end;

procedure TEntradaItensModel.SetPIS(const Value: Variant);
begin
  FPIS := Value;
end;

procedure TEntradaItensModel.SetPMVAST_N19(const Value: Variant);
begin
  FPMVAST_N19 := Value;
end;

procedure TEntradaItensModel.SetPPIS_Q08(const Value: Variant);
begin
  FPPIS_Q08 := Value;
end;

procedure TEntradaItensModel.SetPPIS_R03(const Value: Variant);
begin
  FPPIS_R03 := Value;
end;

procedure TEntradaItensModel.SetPRECO_DOLAR(const Value: Variant);
begin
  FPRECO_DOLAR := Value;
end;

procedure TEntradaItensModel.SetPREDBCST_N20(const Value: Variant);
begin
  FPREDBCST_N20 := Value;
end;

procedure TEntradaItensModel.SetPREDBC_N14(const Value: Variant);
begin
  FPREDBC_N14 := Value;
end;

procedure TEntradaItensModel.SetQBCPROD_Q10(const Value: Variant);
begin
  FQBCPROD_Q10 := Value;
end;

procedure TEntradaItensModel.SetQBCPROD_R04(const Value: Variant);
begin
  FQBCPROD_R04 := Value;
end;

procedure TEntradaItensModel.SetQBCPROD_S09(const Value: Variant);
begin
  FQBCPROD_S09 := Value;
end;

procedure TEntradaItensModel.SetQBCPROD_T04(const Value: Variant);
begin
  FQBCPROD_T04 := Value;
end;

procedure TEntradaItensModel.SetQTD_CHECAGEM(const Value: Variant);
begin
  FQTD_CHECAGEM := Value;
end;

procedure TEntradaItensModel.SetQUANTIDADE_ENT(const Value: Variant);
begin
  FQUANTIDADE_ENT := Value;
end;

procedure TEntradaItensModel.SetQUNID_O11(const Value: Variant);
begin
  FQUNID_O11 := Value;
end;

procedure TEntradaItensModel.SetSERIE_ENT(const Value: Variant);
begin
  FSERIE_ENT := Value;
end;

procedure TEntradaItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TEntradaItensModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TEntradaItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TEntradaItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TEntradaItensModel.SetTRIBUTA_COFINS(const Value: Variant);
begin
  FTRIBUTA_COFINS := Value;
end;

procedure TEntradaItensModel.SetTRIBUTA_PIS(const Value: Variant);
begin
  FTRIBUTA_PIS := Value;
end;

procedure TEntradaItensModel.SetVALIQPROD_Q11(const Value: Variant);
begin
  FVALIQPROD_Q11 := Value;
end;

procedure TEntradaItensModel.SetVALIQPROD_R05(const Value: Variant);
begin
  FVALIQPROD_R05 := Value;
end;

procedure TEntradaItensModel.SetVALIQPROD_S10(const Value: Variant);
begin
  FVALIQPROD_S10 := Value;
end;

procedure TEntradaItensModel.SetVALIQPROD_T05(const Value: Variant);
begin
  FVALIQPROD_T05 := Value;
end;

procedure TEntradaItensModel.SetVALIQ_U03(const Value: Variant);
begin
  FVALIQ_U03 := Value;
end;

procedure TEntradaItensModel.SetVALORUNI_ENT(const Value: Variant);
begin
  FVALORUNI_ENT := Value;
end;

procedure TEntradaItensModel.SetVALOR_ATUALIZACAO_PRECO_VENDA(
  const Value: Variant);
begin
  FVALOR_ATUALIZACAO_PRECO_VENDA := Value;
end;

procedure TEntradaItensModel.SetVALOR_VENDA(const Value: Variant);
begin
  FVALOR_VENDA := Value;
end;

procedure TEntradaItensModel.SetVBCFCPST(const Value: Variant);
begin
  FVBCFCPST := Value;
end;

procedure TEntradaItensModel.SetVBCFCPSTRET(const Value: Variant);
begin
  FVBCFCPSTRET := Value;
end;

procedure TEntradaItensModel.SetVBCFPC(const Value: Variant);
begin
  FVBCFPC := Value;
end;

procedure TEntradaItensModel.SetVBCSTRET(const Value: Variant);
begin
  FVBCSTRET := Value;
end;

procedure TEntradaItensModel.SetVBC_O10(const Value: Variant);
begin
  FVBC_O10 := Value;
end;

procedure TEntradaItensModel.SetVBC_P02(const Value: Variant);
begin
  FVBC_P02 := Value;
end;

procedure TEntradaItensModel.SetVBC_Q07(const Value: Variant);
begin
  FVBC_Q07 := Value;
end;

procedure TEntradaItensModel.SetVBC_R02(const Value: Variant);
begin
  FVBC_R02 := Value;
end;

procedure TEntradaItensModel.SetVBC_S07(const Value: Variant);
begin
  FVBC_S07 := Value;
end;

procedure TEntradaItensModel.SetVBC_T02(const Value: Variant);
begin
  FVBC_T02 := Value;
end;

procedure TEntradaItensModel.SetVBC_U02(const Value: Variant);
begin
  FVBC_U02 := Value;
end;

procedure TEntradaItensModel.SetVCOFINS_S11(const Value: Variant);
begin
  FVCOFINS_S11 := Value;
end;

procedure TEntradaItensModel.SetVCOFINS_T06(const Value: Variant);
begin
  FVCOFINS_T06 := Value;
end;

procedure TEntradaItensModel.SetVDESPADU_P03(const Value: Variant);
begin
  FVDESPADU_P03 := Value;
end;

procedure TEntradaItensModel.SetVENDA2_PRO(const Value: Variant);
begin
  FVENDA2_PRO := Value;
end;

procedure TEntradaItensModel.SetVENDA_PRO(const Value: Variant);
begin
  FVENDA_PRO := Value;
end;

procedure TEntradaItensModel.SetVFCP(const Value: Variant);
begin
  FVFCP := Value;
end;

procedure TEntradaItensModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TEntradaItensModel.SetVFCPSTRET(const Value: Variant);
begin
  FVFCPSTRET := Value;
end;

procedure TEntradaItensModel.SetVFRETE_I15(const Value: Variant);
begin
  FVFRETE_I15 := Value;
end;

procedure TEntradaItensModel.SetVFRETE_I15_2(const Value: Variant);
begin
  FVFRETE_I15_2 := Value;
end;

procedure TEntradaItensModel.SetVICMSSTRET(const Value: Variant);
begin
  FVICMSSTRET := Value;
end;

procedure TEntradaItensModel.SetVICMSSUBISTITUTORET(const Value: Variant);
begin
  FVICMSSUBISTITUTORET := Value;
end;

procedure TEntradaItensModel.SetVICMS_N17(const Value: Variant);
begin
  FVICMS_N17 := Value;
end;

procedure TEntradaItensModel.SetVICMS_ORIGINAL(const Value: Variant);
begin
  FVICMS_ORIGINAL := Value;
end;

procedure TEntradaItensModel.SetVICMS_ST_ENT(const Value: Variant);
begin
  FVICMS_ST_ENT := Value;
end;

procedure TEntradaItensModel.SetVICMS_ST_ORIGINAL(const Value: Variant);
begin
  FVICMS_ST_ORIGINAL := Value;
end;

procedure TEntradaItensModel.SetVII_P04(const Value: Variant);
begin
  FVII_P04 := Value;
end;

procedure TEntradaItensModel.SetVIOF_P05(const Value: Variant);
begin
  FVIOF_P05 := Value;
end;

procedure TEntradaItensModel.SetVIPI_014(const Value: Variant);
begin
  FVIPI_014 := Value;
end;

procedure TEntradaItensModel.SetVISSQN_U04(const Value: Variant);
begin
  FVISSQN_U04 := Value;
end;

procedure TEntradaItensModel.SetVPIS_Q09(const Value: Variant);
begin
  FVPIS_Q09 := Value;
end;

procedure TEntradaItensModel.SetVPIS_R06(const Value: Variant);
begin
  FVPIS_R06 := Value;
end;

procedure TEntradaItensModel.SetVSEG_I16(const Value: Variant);
begin
  FVSEG_I16 := Value;
end;

procedure TEntradaItensModel.SetVUNID_O12(const Value: Variant);
begin
  FVUNID_O12 := Value;
end;

procedure TEntradaItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
