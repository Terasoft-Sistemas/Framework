unit NFItensModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TNFItensModel = class

  private
    vIConexao : IConexao;
    FNFItenssLista: TObjectList<TNFItensModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVFCPUFDEST: Variant;
    FDDESEMB_I23: Variant;
    FVBCSTRET: Variant;
    FNITEMPED2: Variant;
    FQBCPROD_S09: Variant;
    FVALOR_ICMS: Variant;
    FMOTDESICMS: Variant;
    FVICMSUFREMET: Variant;
    FVII_P04: Variant;
    FDDI_I20: Variant;
    FVBCUFDEST: Variant;
    FIPI_SUFRAMA: Variant;
    FOBSERVACAO: Variant;
    FPCOFINS_S08: Variant;
    FIPI_CENQ: Variant;
    FTPINTERMEDIO: Variant;
    FVTOTTRIB_FEDERAL: Variant;
    FPPIS_Q08: Variant;
    FVDESCDI_I29: Variant;
    FCHNFE: Variant;
    FPICMSEFET: Variant;
    FPFCP: Variant;
    FXPED: Variant;
    FVTOTTRIB_MUNICIPAL: Variant;
    FCST_N12: Variant;
    FPCREDPIS: Variant;
    FVALIQPROD_S10: Variant;
    FNUMERO_SERIE_ECF: Variant;
    FVICMSEFET: Variant;
    FVFCP: Variant;
    FV_PROD2: Variant;
    FPCREDCOFINS: Variant;
    FVPIS_Q09: Variant;
    FVBC_P02: Variant;
    FVBCST_N21: Variant;
    FNRE: Variant;
    FPICMSINTER: Variant;
    FPREDBC_N14: Variant;
    FREDUCAO_NF: Variant;
    FVALIQPROD_Q11: Variant;
    FQEXPORT: Variant;
    FNITEMPED: Variant;
    FPEDIDO_ID: Variant;
    FOBS_ITEM: Variant;
    FICMS_NF: Variant;
    FVBCFCPST: Variant;
    FCEST: Variant;
    FVBC_S07: Variant;
    FQBCPROD_Q10: Variant;
    FALIQUOTA_II: Variant;
    FVAFRMM_OPC: Variant;
    FNDRAW: Variant;
    FVBCFCPSTRET: Variant;
    FVOUTROS: Variant;
    FVSEG: Variant;
    FVBC_Q07: Variant;
    FNSEQADIC_I27: Variant;
    FVBCEFET: Variant;
    FICMS_SUFRAMA: Variant;
    FCST_IPI: Variant;
    FCONTA_CONTABIL: Variant;
    FPCREDSN: Variant;
    FVALORUNITARIO_NF: Variant;
    FVALOR_VIP: Variant;
    FVBCFCPUFDEST: Variant;
    FTPVIATRANSP: Variant;
    FID: Variant;
    FVCOFINS_S11: Variant;
    FSERIE_NF: Variant;
    FV_PROD: Variant;
    FVIOF_P05: Variant;
    FCFOP: Variant;
    FVICMS_N17: Variant;
    FVTOTTRIB_ESTADUAL: Variant;
    FVALOR_SUFRAMA_ITEM: Variant;
    FVALOR_DIFERIMENTO: Variant;
    FSTATUS: Variant;
    FLOJA: Variant;
    FNUMERO_NF: Variant;
    FCENQ: Variant;
    FCFOP_ID: Variant;
    FBASE_ICMS: Variant;
    FCODIGO_PRO: Variant;
    FPPRCOMP: Variant;
    FPCRED_PRESUMIDO: Variant;
    FCEXPORTADOR_I24: Variant;
    FNDI_I19: Variant;
    FLOTE: Variant;
    FSYSTIME: Variant;
    FITEM_NF: Variant;
    FVPRCOMP: Variant;
    FVBCCFP: Variant;
    FVDESC: Variant;
    FVTOTTRIB: Variant;
    FID_OBS_LANCAMENTO: Variant;
    FPREDBCST_N20: Variant;
    FVALOR_IPI: Variant;
    FVICMSSUBISTITUTORET: Variant;
    FQTRIB: Variant;
    FXLOCDESEMB_I21: Variant;
    FUNIDADE_NF: Variant;
    FPICMSSTRET: Variant;
    FESTOQUE_2: Variant;
    FVCREDICMSSN: Variant;
    FVLRCUSTO_NF: Variant;
    FQUANTIDADE_NF: Variant;
    FEXTIPI: Variant;
    FINDESCALA: Variant;
    FCBENEF: Variant;
    FVUNTRIB: Variant;
    FDESTINO: Variant;
    FPIS_SUFRAMA: Variant;
    FVBC_N15: Variant;
    FVICMSSTRET: Variant;
    FPFCPST: Variant;
    FPICMSUFDEST: Variant;
    FCOFINS_SUFRAMA: Variant;
    FVDESPADU_P03: Variant;
    FNADICAO_I26: Variant;
    FUTRIB: Variant;
    FPCREDICMS: Variant;
    FVBC_IPI: Variant;
    FFRETE: Variant;
    FCFABRICANTE_I28: Variant;
    FUFDESEMB_I22: Variant;
    FPICMSST_N22: Variant;
    FPFCPSTRET: Variant;
    FVFCPST: Variant;
    FVICMSUFDEST: Variant;
    FPMVAST_N19: Variant;
    FBASE_ICMS_ST: Variant;
    FVLRVENDA_NF: Variant;
    FVICMSDESON: Variant;
    FCST_S06: Variant;
    FMODBCST_N18: Variant;
    FPREDBCEFET: Variant;
    FVFCPSTRET: Variant;
    FSAIDA_ID: Variant;
    FPFCPUFDEST: Variant;
    FDESCRICAO_PRODUTO: Variant;
    FVICMSST_N23: Variant;
    FCNPJFAB: Variant;
    FOS_ID: Variant;
    FBASE_IPI2: Variant;
    FPICMSINTERPART: Variant;
    FCST_Q06: Variant;
    FCSOSN: Variant;
    FIPI_NF: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetNFItenssLista(const Value: TObjectList<TNFItensModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetALIQUOTA_II(const Value: Variant);
    procedure SetBASE_ICMS(const Value: Variant);
    procedure SetBASE_ICMS_ST(const Value: Variant);
    procedure SetBASE_IPI2(const Value: Variant);
    procedure SetCBENEF(const Value: Variant);
    procedure SetCENQ(const Value: Variant);
    procedure SetCEST(const Value: Variant);
    procedure SetCEXPORTADOR_I24(const Value: Variant);
    procedure SetCFABRICANTE_I28(const Value: Variant);
    procedure SetCFOP(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCHNFE(const Value: Variant);
    procedure SetCNPJFAB(const Value: Variant);
    procedure SetCODIGO_PRO(const Value: Variant);
    procedure SetCOFINS_SUFRAMA(const Value: Variant);
    procedure SetCONTA_CONTABIL(const Value: Variant);
    procedure SetCSOSN(const Value: Variant);
    procedure SetCST_IPI(const Value: Variant);
    procedure SetCST_N12(const Value: Variant);
    procedure SetCST_Q06(const Value: Variant);
    procedure SetCST_S06(const Value: Variant);
    procedure SetDDESEMB_I23(const Value: Variant);
    procedure SetDDI_I20(const Value: Variant);
    procedure SetDESCRICAO_PRODUTO(const Value: Variant);
    procedure SetDESTINO(const Value: Variant);
    procedure SetESTOQUE_2(const Value: Variant);
    procedure SetEXTIPI(const Value: Variant);
    procedure SetFRETE(const Value: Variant);
    procedure SetICMS_NF(const Value: Variant);
    procedure SetICMS_SUFRAMA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetID_OBS_LANCAMENTO(const Value: Variant);
    procedure SetINDESCALA(const Value: Variant);
    procedure SetIPI_CENQ(const Value: Variant);
    procedure SetIPI_NF(const Value: Variant);
    procedure SetIPI_SUFRAMA(const Value: Variant);
    procedure SetITEM_NF(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLOTE(const Value: Variant);
    procedure SetMODBCST_N18(const Value: Variant);
    procedure SetMOTDESICMS(const Value: Variant);
    procedure SetNADICAO_I26(const Value: Variant);
    procedure SetNDI_I19(const Value: Variant);
    procedure SetNDRAW(const Value: Variant);
    procedure SetNITEMPED(const Value: Variant);
    procedure SetNITEMPED2(const Value: Variant);
    procedure SetNRE(const Value: Variant);
    procedure SetNSEQADIC_I27(const Value: Variant);
    procedure SetNUMERO_NF(const Value: Variant);
    procedure SetNUMERO_SERIE_ECF(const Value: Variant);
    procedure SetOBS_ITEM(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetOS_ID(const Value: Variant);
    procedure SetPCOFINS_S08(const Value: Variant);
    procedure SetPCRED_PRESUMIDO(const Value: Variant);
    procedure SetPCREDCOFINS(const Value: Variant);
    procedure SetPCREDICMS(const Value: Variant);
    procedure SetPCREDPIS(const Value: Variant);
    procedure SetPCREDSN(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetPFCP(const Value: Variant);
    procedure SetPFCPST(const Value: Variant);
    procedure SetPFCPSTRET(const Value: Variant);
    procedure SetPFCPUFDEST(const Value: Variant);
    procedure SetPICMSEFET(const Value: Variant);
    procedure SetPICMSINTER(const Value: Variant);
    procedure SetPICMSINTERPART(const Value: Variant);
    procedure SetPICMSST_N22(const Value: Variant);
    procedure SetPICMSSTRET(const Value: Variant);
    procedure SetPICMSUFDEST(const Value: Variant);
    procedure SetPIS_SUFRAMA(const Value: Variant);
    procedure SetPMVAST_N19(const Value: Variant);
    procedure SetPPIS_Q08(const Value: Variant);
    procedure SetPPRCOMP(const Value: Variant);
    procedure SetPREDBC_N14(const Value: Variant);
    procedure SetPREDBCEFET(const Value: Variant);
    procedure SetPREDBCST_N20(const Value: Variant);
    procedure SetQBCPROD_Q10(const Value: Variant);
    procedure SetQBCPROD_S09(const Value: Variant);
    procedure SetQEXPORT(const Value: Variant);
    procedure SetQTRIB(const Value: Variant);
    procedure SetQUANTIDADE_NF(const Value: Variant);
    procedure SetREDUCAO_NF(const Value: Variant);
    procedure SetSAIDA_ID(const Value: Variant);
    procedure SetSERIE_NF(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTPINTERMEDIO(const Value: Variant);
    procedure SetTPVIATRANSP(const Value: Variant);
    procedure SetUFDESEMB_I22(const Value: Variant);
    procedure SetUNIDADE_NF(const Value: Variant);
    procedure SetUTRIB(const Value: Variant);
    procedure SetV_PROD(const Value: Variant);
    procedure SetV_PROD2(const Value: Variant);
    procedure SetVAFRMM_OPC(const Value: Variant);
    procedure SetVALIQPROD_Q11(const Value: Variant);
    procedure SetVALIQPROD_S10(const Value: Variant);
    procedure SetVALOR_DIFERIMENTO(const Value: Variant);
    procedure SetVALOR_ICMS(const Value: Variant);
    procedure SetVALOR_IPI(const Value: Variant);
    procedure SetVALOR_SUFRAMA_ITEM(const Value: Variant);
    procedure SetVALOR_VIP(const Value: Variant);
    procedure SetVALORUNITARIO_NF(const Value: Variant);
    procedure SetVBC_IPI(const Value: Variant);
    procedure SetVBC_N15(const Value: Variant);
    procedure SetVBC_P02(const Value: Variant);
    procedure SetVBC_Q07(const Value: Variant);
    procedure SetVBC_S07(const Value: Variant);
    procedure SetVBCCFP(const Value: Variant);
    procedure SetVBCEFET(const Value: Variant);
    procedure SetVBCFCPST(const Value: Variant);
    procedure SetVBCFCPSTRET(const Value: Variant);
    procedure SetVBCFCPUFDEST(const Value: Variant);
    procedure SetVBCST_N21(const Value: Variant);
    procedure SetVBCSTRET(const Value: Variant);
    procedure SetVBCUFDEST(const Value: Variant);
    procedure SetVCOFINS_S11(const Value: Variant);
    procedure SetVCREDICMSSN(const Value: Variant);
    procedure SetVDESC(const Value: Variant);
    procedure SetVDESCDI_I29(const Value: Variant);
    procedure SetVDESPADU_P03(const Value: Variant);
    procedure SetVFCP(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetVFCPSTRET(const Value: Variant);
    procedure SetVFCPUFDEST(const Value: Variant);
    procedure SetVICMS_N17(const Value: Variant);
    procedure SetVICMSDESON(const Value: Variant);
    procedure SetVICMSEFET(const Value: Variant);
    procedure SetVICMSST_N23(const Value: Variant);
    procedure SetVICMSSTRET(const Value: Variant);
    procedure SetVICMSSUBISTITUTORET(const Value: Variant);
    procedure SetVICMSUFDEST(const Value: Variant);
    procedure SetVICMSUFREMET(const Value: Variant);
    procedure SetVII_P04(const Value: Variant);
    procedure SetVIOF_P05(const Value: Variant);
    procedure SetVLRCUSTO_NF(const Value: Variant);
    procedure SetVLRVENDA_NF(const Value: Variant);
    procedure SetVOUTROS(const Value: Variant);
    procedure SetVPIS_Q09(const Value: Variant);
    procedure SetVPRCOMP(const Value: Variant);
    procedure SetVSEG(const Value: Variant);
    procedure SetVTOTTRIB(const Value: Variant);
    procedure SetVTOTTRIB_ESTADUAL(const Value: Variant);
    procedure SetVTOTTRIB_FEDERAL(const Value: Variant);
    procedure SetVTOTTRIB_MUNICIPAL(const Value: Variant);
    procedure SetVUNTRIB(const Value: Variant);
    procedure SetXLOCDESEMB_I21(const Value: Variant);
    procedure SetXPED(const Value: Variant);

  public
    property NUMERO_NF: Variant read FNUMERO_NF write SetNUMERO_NF;
    property SERIE_NF: Variant read FSERIE_NF write SetSERIE_NF;
    property CODIGO_PRO: Variant read FCODIGO_PRO write SetCODIGO_PRO;
    property VALORUNITARIO_NF: Variant read FVALORUNITARIO_NF write SetVALORUNITARIO_NF;
    property QUANTIDADE_NF: Variant read FQUANTIDADE_NF write SetQUANTIDADE_NF;
    property VLRVENDA_NF: Variant read FVLRVENDA_NF write SetVLRVENDA_NF;
    property VLRCUSTO_NF: Variant read FVLRCUSTO_NF write SetVLRCUSTO_NF;
    property REDUCAO_NF: Variant read FREDUCAO_NF write SetREDUCAO_NF;
    property ICMS_NF: Variant read FICMS_NF write SetICMS_NF;
    property IPI_NF: Variant read FIPI_NF write SetIPI_NF;
    property ITEM_NF: Variant read FITEM_NF write SetITEM_NF;
    property UNIDADE_NF: Variant read FUNIDADE_NF write SetUNIDADE_NF;
    property LOJA: Variant read FLOJA write SetLOJA;
    property VALOR_ICMS: Variant read FVALOR_ICMS write SetVALOR_ICMS;
    property BASE_ICMS_ST: Variant read FBASE_ICMS_ST write SetBASE_ICMS_ST;
    property VALOR_IPI: Variant read FVALOR_IPI write SetVALOR_IPI;
    property BASE_ICMS: Variant read FBASE_ICMS write SetBASE_ICMS;
    property LOTE: Variant read FLOTE write SetLOTE;
    property PMVAST_N19: Variant read FPMVAST_N19 write SetPMVAST_N19;
    property PREDBCST_N20: Variant read FPREDBCST_N20 write SetPREDBCST_N20;
    property VBCST_N21: Variant read FVBCST_N21 write SetVBCST_N21;
    property PICMSST_N22: Variant read FPICMSST_N22 write SetPICMSST_N22;
    property VICMSST_N23: Variant read FVICMSST_N23 write SetVICMSST_N23;
    property MODBCST_N18: Variant read FMODBCST_N18 write SetMODBCST_N18;
    property CST_N12: Variant read FCST_N12 write SetCST_N12;
    property VBC_N15: Variant read FVBC_N15 write SetVBC_N15;
    property VICMS_N17: Variant read FVICMS_N17 write SetVICMS_N17;
    property NUMERO_SERIE_ECF: Variant read FNUMERO_SERIE_ECF write SetNUMERO_SERIE_ECF;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property PREDBC_N14: Variant read FPREDBC_N14 write SetPREDBC_N14;
    property CFOP: Variant read FCFOP write SetCFOP;
    property ID_OBS_LANCAMENTO: Variant read FID_OBS_LANCAMENTO write SetID_OBS_LANCAMENTO;
    property CSOSN: Variant read FCSOSN write SetCSOSN;
    property PCREDSN: Variant read FPCREDSN write SetPCREDSN;
    property VCREDICMSSN: Variant read FVCREDICMSSN write SetVCREDICMSSN;
    property NDI_I19: Variant read FNDI_I19 write SetNDI_I19;
    property DDI_I20: Variant read FDDI_I20 write SetDDI_I20;
    property XLOCDESEMB_I21: Variant read FXLOCDESEMB_I21 write SetXLOCDESEMB_I21;
    property UFDESEMB_I22: Variant read FUFDESEMB_I22 write SetUFDESEMB_I22;
    property DDESEMB_I23: Variant read FDDESEMB_I23 write SetDDESEMB_I23;
    property CEXPORTADOR_I24: Variant read FCEXPORTADOR_I24 write SetCEXPORTADOR_I24;
    property NADICAO_I26: Variant read FNADICAO_I26 write SetNADICAO_I26;
    property NSEQADIC_I27: Variant read FNSEQADIC_I27 write SetNSEQADIC_I27;
    property CFABRICANTE_I28: Variant read FCFABRICANTE_I28 write SetCFABRICANTE_I28;
    property VDESCDI_I29: Variant read FVDESCDI_I29 write SetVDESCDI_I29;
    property VBC_P02: Variant read FVBC_P02 write SetVBC_P02;
    property VDESPADU_P03: Variant read FVDESPADU_P03 write SetVDESPADU_P03;
    property VII_P04: Variant read FVII_P04 write SetVII_P04;
    property VIOF_P05: Variant read FVIOF_P05 write SetVIOF_P05;
    property CST_Q06: Variant read FCST_Q06 write SetCST_Q06;
    property VBC_Q07: Variant read FVBC_Q07 write SetVBC_Q07;
    property PPIS_Q08: Variant read FPPIS_Q08 write SetPPIS_Q08;
    property VPIS_Q09: Variant read FVPIS_Q09 write SetVPIS_Q09;
    property QBCPROD_Q10: Variant read FQBCPROD_Q10 write SetQBCPROD_Q10;
    property VALIQPROD_Q11: Variant read FVALIQPROD_Q11 write SetVALIQPROD_Q11;
    property CST_S06: Variant read FCST_S06 write SetCST_S06;
    property VBC_S07: Variant read FVBC_S07 write SetVBC_S07;
    property PCOFINS_S08: Variant read FPCOFINS_S08 write SetPCOFINS_S08;
    property VCOFINS_S11: Variant read FVCOFINS_S11 write SetVCOFINS_S11;
    property QBCPROD_S09: Variant read FQBCPROD_S09 write SetQBCPROD_S09;
    property VALIQPROD_S10: Variant read FVALIQPROD_S10 write SetVALIQPROD_S10;
    property ID: Variant read FID write SetID;
    property VTOTTRIB: Variant read FVTOTTRIB write SetVTOTTRIB;
    property OBSERVACAO: Variant read FOBSERVACAO write SetOBSERVACAO;
    property CFOP_ID: Variant read FCFOP_ID write SetCFOP_ID;
    property CONTA_CONTABIL: Variant read FCONTA_CONTABIL write SetCONTA_CONTABIL;
    property VDESC: Variant read FVDESC write SetVDESC;
    property VSEG: Variant read FVSEG write SetVSEG;
    property FRETE: Variant read FFRETE write SetFRETE;
    property VOUTROS: Variant read FVOUTROS write SetVOUTROS;
    property CST_IPI: Variant read FCST_IPI write SetCST_IPI;
    property VALOR_DIFERIMENTO: Variant read FVALOR_DIFERIMENTO write SetVALOR_DIFERIMENTO;
    property OBS_ITEM: Variant read FOBS_ITEM write SetOBS_ITEM;
    property ICMS_SUFRAMA: Variant read FICMS_SUFRAMA write SetICMS_SUFRAMA;
    property PIS_SUFRAMA: Variant read FPIS_SUFRAMA write SetPIS_SUFRAMA;
    property COFINS_SUFRAMA: Variant read FCOFINS_SUFRAMA write SetCOFINS_SUFRAMA;
    property IPI_SUFRAMA: Variant read FIPI_SUFRAMA write SetIPI_SUFRAMA;
    property VALOR_SUFRAMA_ITEM: Variant read FVALOR_SUFRAMA_ITEM write SetVALOR_SUFRAMA_ITEM;
    property DESCRICAO_PRODUTO: Variant read FDESCRICAO_PRODUTO write SetDESCRICAO_PRODUTO;
    property ESTOQUE_2: Variant read FESTOQUE_2 write SetESTOQUE_2;
    property VTOTTRIB_FEDERAL: Variant read FVTOTTRIB_FEDERAL write SetVTOTTRIB_FEDERAL;
    property VTOTTRIB_ESTADUAL: Variant read FVTOTTRIB_ESTADUAL write SetVTOTTRIB_ESTADUAL;
    property VTOTTRIB_MUNICIPAL: Variant read FVTOTTRIB_MUNICIPAL write SetVTOTTRIB_MUNICIPAL;
    property PEDIDO_ID: Variant read FPEDIDO_ID write SetPEDIDO_ID;
    property NITEMPED: Variant read FNITEMPED write SetNITEMPED;
    property XPED: Variant read FXPED write SetXPED;
    property TPVIATRANSP: Variant read FTPVIATRANSP write SetTPVIATRANSP;
    property TPINTERMEDIO: Variant read FTPINTERMEDIO write SetTPINTERMEDIO;
    property VAFRMM_OPC: Variant read FVAFRMM_OPC write SetVAFRMM_OPC;
    property VBC_IPI: Variant read FVBC_IPI write SetVBC_IPI;
    property ALIQUOTA_II: Variant read FALIQUOTA_II write SetALIQUOTA_II;
    property VBCUFDEST: Variant read FVBCUFDEST write SetVBCUFDEST;
    property PFCPUFDEST: Variant read FPFCPUFDEST write SetPFCPUFDEST;
    property PICMSUFDEST: Variant read FPICMSUFDEST write SetPICMSUFDEST;
    property PICMSINTER: Variant read FPICMSINTER write SetPICMSINTER;
    property PICMSINTERPART: Variant read FPICMSINTERPART write SetPICMSINTERPART;
    property VFCPUFDEST: Variant read FVFCPUFDEST write SetVFCPUFDEST;
    property VICMSUFDEST: Variant read FVICMSUFDEST write SetVICMSUFDEST;
    property VICMSUFREMET: Variant read FVICMSUFREMET write SetVICMSUFREMET;
    property CEST: Variant read FCEST write SetCEST;
    property SAIDA_ID: Variant read FSAIDA_ID write SetSAIDA_ID;
    property V_PROD: Variant read FV_PROD write SetV_PROD;
    property PCREDICMS: Variant read FPCREDICMS write SetPCREDICMS;
    property PCREDPIS: Variant read FPCREDPIS write SetPCREDPIS;
    property PCREDCOFINS: Variant read FPCREDCOFINS write SetPCREDCOFINS;
    property DESTINO: Variant read FDESTINO write SetDESTINO;
    property BASE_IPI2: Variant read FBASE_IPI2 write SetBASE_IPI2;
    property IPI_CENQ: Variant read FIPI_CENQ write SetIPI_CENQ;
    property NITEMPED2: Variant read FNITEMPED2 write SetNITEMPED2;
    property V_PROD2: Variant read FV_PROD2 write SetV_PROD2;
    property UTRIB: Variant read FUTRIB write SetUTRIB;
    property QTRIB: Variant read FQTRIB write SetQTRIB;
    property VUNTRIB: Variant read FVUNTRIB write SetVUNTRIB;
    property VBCFCPUFDEST: Variant read FVBCFCPUFDEST write SetVBCFCPUFDEST;
    property VBCFCPST: Variant read FVBCFCPST write SetVBCFCPST;
    property PFCPST: Variant read FPFCPST write SetPFCPST;
    property VFCPST: Variant read FVFCPST write SetVFCPST;
    property VBCCFP: Variant read FVBCCFP write SetVBCCFP;
    property PFCP: Variant read FPFCP write SetPFCP;
    property VFCP: Variant read FVFCP write SetVFCP;
    property VBCFCPSTRET: Variant read FVBCFCPSTRET write SetVBCFCPSTRET;
    property PFCPSTRET: Variant read FPFCPSTRET write SetPFCPSTRET;
    property VFCPSTRET: Variant read FVFCPSTRET write SetVFCPSTRET;
    property OS_ID: Variant read FOS_ID write SetOS_ID;
    property CBENEF: Variant read FCBENEF write SetCBENEF;
    property INDESCALA: Variant read FINDESCALA write SetINDESCALA;
    property CNPJFAB: Variant read FCNPJFAB write SetCNPJFAB;
    property PREDBCEFET: Variant read FPREDBCEFET write SetPREDBCEFET;
    property VBCEFET: Variant read FVBCEFET write SetVBCEFET;
    property PICMSEFET: Variant read FPICMSEFET write SetPICMSEFET;
    property VICMSEFET: Variant read FVICMSEFET write SetVICMSEFET;
    property CENQ: Variant read FCENQ write SetCENQ;
    property VBCSTRET: Variant read FVBCSTRET write SetVBCSTRET;
    property VICMSSTRET: Variant read FVICMSSTRET write SetVICMSSTRET;
    property PICMSSTRET: Variant read FPICMSSTRET write SetPICMSSTRET;
    property VICMSSUBISTITUTORET: Variant read FVICMSSUBISTITUTORET write SetVICMSSUBISTITUTORET;
    property VICMSDESON: Variant read FVICMSDESON write SetVICMSDESON;
    property MOTDESICMS: Variant read FMOTDESICMS write SetMOTDESICMS;
    property VALOR_VIP: Variant read FVALOR_VIP write SetVALOR_VIP;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property PCRED_PRESUMIDO: Variant read FPCRED_PRESUMIDO write SetPCRED_PRESUMIDO;
    property NDRAW: Variant read FNDRAW write SetNDRAW;
    property PPRCOMP: Variant read FPPRCOMP write SetPPRCOMP;
    property VPRCOMP: Variant read FVPRCOMP write SetVPRCOMP;
    property NRE: Variant read FNRE write SetNRE;
    property CHNFE: Variant read FCHNFE write SetCHNFE;
    property QEXPORT: Variant read FQEXPORT write SetQEXPORT;
    property EXTIPI: Variant read FEXTIPI write SetEXTIPI;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;
    function obterTotais(pNF : String): TFDMemTable;

    function carregaClasse(pId: String): TNFItensModel;

    property NFItenssLista: TObjectList<TNFItensModel> read FNFItenssLista write SetNFItenssLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  NFItensDao;

{ TNFItensModel }

function TNFItensModel.carregaClasse(pId: String): TNFItensModel;
var
  lNFItensDao: TNFItensDao;
begin
  lNFItensDao := TNFItensDao.Create(vIConexao);
  try
    Result := lNFItensDao.carregaClasse(pId);
  finally
    lNFItensDao.Free;
  end;
end;

constructor TNFItensModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TNFItensModel.Destroy;
begin

  inherited;
end;

procedure TNFItensModel.obterLista;
var
  lNFItensLista: TNFItensDao;
begin
  lNFItensLista := TNFItensDao.Create(vIConexao);

  try
    lNFItensLista.TotalRecords    := FTotalRecords;
    lNFItensLista.WhereView       := FWhereView;
    lNFItensLista.CountView       := FCountView;
    lNFItensLista.OrderView       := FOrderView;
    lNFItensLista.StartRecordView := FStartRecordView;
    lNFItensLista.LengthPageView  := FLengthPageView;
    lNFItensLista.IDRecordView    := FIDRecordView;

    lNFItensLista.obterLista;

    FTotalRecords  := lNFItensLista.TotalRecords;
    FNFItenssLista := lNFItensLista.NFItenssLista;

  finally
    lNFItensLista.Free;
  end;
end;

function TNFItensModel.obterTotais(pNF: String): TFDMemTable;
var
  lNFItensDao : TNFItensDao;
begin
  lNFItensDao := TNFItensDao.Create(vIConexao);
  try
    Result := lNFItensDao.obterTotais(pNF);
  finally
    lNFItensDao.Free;
  end;
end;

function TNFItensModel.Salvar: String;
var
  lNFItensDao: TNFItensDao;
begin
  lNFItensDao := TNFItensDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lNFItensDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lNFItensDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lNFItensDao.excluir(Self);
    end;

  finally
    lNFItensDao.Free;
  end;
end;

procedure TNFItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TNFItensModel.SetALIQUOTA_II(const Value: Variant);
begin
  FALIQUOTA_II := Value;
end;

procedure TNFItensModel.SetBASE_ICMS(const Value: Variant);
begin
  FBASE_ICMS := Value;
end;

procedure TNFItensModel.SetBASE_ICMS_ST(const Value: Variant);
begin
  FBASE_ICMS_ST := Value;
end;

procedure TNFItensModel.SetBASE_IPI2(const Value: Variant);
begin
  FBASE_IPI2 := Value;
end;

procedure TNFItensModel.SetCBENEF(const Value: Variant);
begin
  FCBENEF := Value;
end;

procedure TNFItensModel.SetCENQ(const Value: Variant);
begin
  FCENQ := Value;
end;

procedure TNFItensModel.SetCEST(const Value: Variant);
begin
  FCEST := Value;
end;

procedure TNFItensModel.SetCEXPORTADOR_I24(const Value: Variant);
begin
  FCEXPORTADOR_I24 := Value;
end;

procedure TNFItensModel.SetCFABRICANTE_I28(const Value: Variant);
begin
  FCFABRICANTE_I28 := Value;
end;

procedure TNFItensModel.SetCFOP(const Value: Variant);
begin
  FCFOP := Value;
end;

procedure TNFItensModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;

procedure TNFItensModel.SetCHNFE(const Value: Variant);
begin
  FCHNFE := Value;
end;

procedure TNFItensModel.SetCNPJFAB(const Value: Variant);
begin
  FCNPJFAB := Value;
end;

procedure TNFItensModel.SetCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
end;

procedure TNFItensModel.SetCOFINS_SUFRAMA(const Value: Variant);
begin
  FCOFINS_SUFRAMA := Value;
end;

procedure TNFItensModel.SetCONTA_CONTABIL(const Value: Variant);
begin
  FCONTA_CONTABIL := Value;
end;

procedure TNFItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TNFItensModel.SetCSOSN(const Value: Variant);
begin
  FCSOSN := Value;
end;

procedure TNFItensModel.SetCST_IPI(const Value: Variant);
begin
  FCST_IPI := Value;
end;

procedure TNFItensModel.SetCST_N12(const Value: Variant);
begin
  FCST_N12 := Value;
end;

procedure TNFItensModel.SetCST_Q06(const Value: Variant);
begin
  FCST_Q06 := Value;
end;

procedure TNFItensModel.SetCST_S06(const Value: Variant);
begin
  FCST_S06 := Value;
end;

procedure TNFItensModel.SetDDESEMB_I23(const Value: Variant);
begin
  FDDESEMB_I23 := Value;
end;

procedure TNFItensModel.SetDDI_I20(const Value: Variant);
begin
  FDDI_I20 := Value;
end;

procedure TNFItensModel.SetDESCRICAO_PRODUTO(const Value: Variant);
begin
  FDESCRICAO_PRODUTO := Value;
end;

procedure TNFItensModel.SetDESTINO(const Value: Variant);
begin
  FDESTINO := Value;
end;

procedure TNFItensModel.SetESTOQUE_2(const Value: Variant);
begin
  FESTOQUE_2 := Value;
end;

procedure TNFItensModel.SetEXTIPI(const Value: Variant);
begin
  FEXTIPI := Value;
end;

procedure TNFItensModel.SetFRETE(const Value: Variant);
begin
  FFRETE := Value;
end;

procedure TNFItensModel.SetNADICAO_I26(const Value: Variant);
begin
  FNADICAO_I26 := Value;
end;

procedure TNFItensModel.SetNDI_I19(const Value: Variant);
begin
  FNDI_I19 := Value;
end;

procedure TNFItensModel.SetNDRAW(const Value: Variant);
begin
  FNDRAW := Value;
end;

procedure TNFItensModel.SetNFItenssLista(const Value: TObjectList<TNFItensModel>);
begin
  FNFItenssLista := Value;
end;

procedure TNFItensModel.SetICMS_NF(const Value: Variant);
begin
  FICMS_NF := Value;
end;

procedure TNFItensModel.SetICMS_SUFRAMA(const Value: Variant);
begin
  FICMS_SUFRAMA := Value;
end;

procedure TNFItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TNFItensModel.SetNITEMPED(const Value: Variant);
begin
  FNITEMPED := Value;
end;

procedure TNFItensModel.SetNITEMPED2(const Value: Variant);
begin
  FNITEMPED2 := Value;
end;

procedure TNFItensModel.SetNRE(const Value: Variant);
begin
  FNRE := Value;
end;

procedure TNFItensModel.SetNSEQADIC_I27(const Value: Variant);
begin
  FNSEQADIC_I27 := Value;
end;

procedure TNFItensModel.SetNUMERO_NF(const Value: Variant);
begin
  FNUMERO_NF := Value;
end;

procedure TNFItensModel.SetNUMERO_SERIE_ECF(const Value: Variant);
begin
  FNUMERO_SERIE_ECF := Value;
end;

procedure TNFItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TNFItensModel.SetID_OBS_LANCAMENTO(const Value: Variant);
begin
  FID_OBS_LANCAMENTO := Value;
end;

procedure TNFItensModel.SetINDESCALA(const Value: Variant);
begin
  FINDESCALA := Value;
end;

procedure TNFItensModel.SetIPI_CENQ(const Value: Variant);
begin
  FIPI_CENQ := Value;
end;

procedure TNFItensModel.SetIPI_NF(const Value: Variant);
begin
  FIPI_NF := Value;
end;

procedure TNFItensModel.SetIPI_SUFRAMA(const Value: Variant);
begin
  FIPI_SUFRAMA := Value;
end;

procedure TNFItensModel.SetITEM_NF(const Value: Variant);
begin
  FITEM_NF := Value;
end;

procedure TNFItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TNFItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TNFItensModel.SetLOTE(const Value: Variant);
begin
  FLOTE := Value;
end;

procedure TNFItensModel.SetMODBCST_N18(const Value: Variant);
begin
  FMODBCST_N18 := Value;
end;

procedure TNFItensModel.SetMOTDESICMS(const Value: Variant);
begin
  FMOTDESICMS := Value;
end;

procedure TNFItensModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TNFItensModel.SetOBS_ITEM(const Value: Variant);
begin
  FOBS_ITEM := Value;
end;

procedure TNFItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TNFItensModel.SetOS_ID(const Value: Variant);
begin
  FOS_ID := Value;
end;

procedure TNFItensModel.SetPCOFINS_S08(const Value: Variant);
begin
  FPCOFINS_S08 := Value;
end;

procedure TNFItensModel.SetPCREDCOFINS(const Value: Variant);
begin
  FPCREDCOFINS := Value;
end;

procedure TNFItensModel.SetPCREDICMS(const Value: Variant);
begin
  FPCREDICMS := Value;
end;

procedure TNFItensModel.SetPCREDPIS(const Value: Variant);
begin
  FPCREDPIS := Value;
end;

procedure TNFItensModel.SetPCREDSN(const Value: Variant);
begin
  FPCREDSN := Value;
end;

procedure TNFItensModel.SetPCRED_PRESUMIDO(const Value: Variant);
begin
  FPCRED_PRESUMIDO := Value;
end;

procedure TNFItensModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TNFItensModel.SetPFCP(const Value: Variant);
begin
  FPFCP := Value;
end;

procedure TNFItensModel.SetPFCPST(const Value: Variant);
begin
  FPFCPST := Value;
end;

procedure TNFItensModel.SetPFCPSTRET(const Value: Variant);
begin
  FPFCPSTRET := Value;
end;

procedure TNFItensModel.SetPFCPUFDEST(const Value: Variant);
begin
  FPFCPUFDEST := Value;
end;

procedure TNFItensModel.SetPICMSEFET(const Value: Variant);
begin
  FPICMSEFET := Value;
end;

procedure TNFItensModel.SetPICMSINTER(const Value: Variant);
begin
  FPICMSINTER := Value;
end;

procedure TNFItensModel.SetPICMSINTERPART(const Value: Variant);
begin
  FPICMSINTERPART := Value;
end;

procedure TNFItensModel.SetPICMSSTRET(const Value: Variant);
begin
  FPICMSSTRET := Value;
end;

procedure TNFItensModel.SetPICMSST_N22(const Value: Variant);
begin
  FPICMSST_N22 := Value;
end;

procedure TNFItensModel.SetPICMSUFDEST(const Value: Variant);
begin
  FPICMSUFDEST := Value;
end;

procedure TNFItensModel.SetPIS_SUFRAMA(const Value: Variant);
begin
  FPIS_SUFRAMA := Value;
end;

procedure TNFItensModel.SetPMVAST_N19(const Value: Variant);
begin
  FPMVAST_N19 := Value;
end;

procedure TNFItensModel.SetPPIS_Q08(const Value: Variant);
begin
  FPPIS_Q08 := Value;
end;

procedure TNFItensModel.SetPPRCOMP(const Value: Variant);
begin
  FPPRCOMP := Value;
end;

procedure TNFItensModel.SetPREDBCEFET(const Value: Variant);
begin
  FPREDBCEFET := Value;
end;

procedure TNFItensModel.SetPREDBCST_N20(const Value: Variant);
begin
  FPREDBCST_N20 := Value;
end;

procedure TNFItensModel.SetPREDBC_N14(const Value: Variant);
begin
  FPREDBC_N14 := Value;
end;

procedure TNFItensModel.SetQBCPROD_Q10(const Value: Variant);
begin
  FQBCPROD_Q10 := Value;
end;

procedure TNFItensModel.SetQBCPROD_S09(const Value: Variant);
begin
  FQBCPROD_S09 := Value;
end;

procedure TNFItensModel.SetQEXPORT(const Value: Variant);
begin
  FQEXPORT := Value;
end;

procedure TNFItensModel.SetQTRIB(const Value: Variant);
begin
  FQTRIB := Value;
end;

procedure TNFItensModel.SetQUANTIDADE_NF(const Value: Variant);
begin
  FQUANTIDADE_NF := Value;
end;

procedure TNFItensModel.SetREDUCAO_NF(const Value: Variant);
begin
  FREDUCAO_NF := Value;
end;

procedure TNFItensModel.SetSAIDA_ID(const Value: Variant);
begin
  FSAIDA_ID := Value;
end;

procedure TNFItensModel.SetSERIE_NF(const Value: Variant);
begin
  FSERIE_NF := Value;
end;

procedure TNFItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TNFItensModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TNFItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TNFItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TNFItensModel.SetTPINTERMEDIO(const Value: Variant);
begin
  FTPINTERMEDIO := Value;
end;

procedure TNFItensModel.SetTPVIATRANSP(const Value: Variant);
begin
  FTPVIATRANSP := Value;
end;

procedure TNFItensModel.SetUFDESEMB_I22(const Value: Variant);
begin
  FUFDESEMB_I22 := Value;
end;

procedure TNFItensModel.SetUNIDADE_NF(const Value: Variant);
begin
  FUNIDADE_NF := Value;
end;

procedure TNFItensModel.SetUTRIB(const Value: Variant);
begin
  FUTRIB := Value;
end;

procedure TNFItensModel.SetVAFRMM_OPC(const Value: Variant);
begin
  FVAFRMM_OPC := Value;
end;

procedure TNFItensModel.SetVALIQPROD_Q11(const Value: Variant);
begin
  FVALIQPROD_Q11 := Value;
end;

procedure TNFItensModel.SetVALIQPROD_S10(const Value: Variant);
begin
  FVALIQPROD_S10 := Value;
end;

procedure TNFItensModel.SetVALORUNITARIO_NF(const Value: Variant);
begin
  FVALORUNITARIO_NF := Value;
end;

procedure TNFItensModel.SetVALOR_DIFERIMENTO(const Value: Variant);
begin
  FVALOR_DIFERIMENTO := Value;
end;

procedure TNFItensModel.SetVALOR_ICMS(const Value: Variant);
begin
  FVALOR_ICMS := Value;
end;

procedure TNFItensModel.SetVALOR_IPI(const Value: Variant);
begin
  FVALOR_IPI := Value;
end;

procedure TNFItensModel.SetVALOR_SUFRAMA_ITEM(const Value: Variant);
begin
  FVALOR_SUFRAMA_ITEM := Value;
end;

procedure TNFItensModel.SetVALOR_VIP(const Value: Variant);
begin
  FVALOR_VIP := Value;
end;

procedure TNFItensModel.SetVBCCFP(const Value: Variant);
begin
  FVBCCFP := Value;
end;

procedure TNFItensModel.SetVBCEFET(const Value: Variant);
begin
  FVBCEFET := Value;
end;

procedure TNFItensModel.SetVBCFCPST(const Value: Variant);
begin
  FVBCFCPST := Value;
end;

procedure TNFItensModel.SetVBCFCPSTRET(const Value: Variant);
begin
  FVBCFCPSTRET := Value;
end;

procedure TNFItensModel.SetVBCFCPUFDEST(const Value: Variant);
begin
  FVBCFCPUFDEST := Value;
end;

procedure TNFItensModel.SetVBCSTRET(const Value: Variant);
begin
  FVBCSTRET := Value;
end;

procedure TNFItensModel.SetVBCST_N21(const Value: Variant);
begin
  FVBCST_N21 := Value;
end;

procedure TNFItensModel.SetVBCUFDEST(const Value: Variant);
begin
  FVBCUFDEST := Value;
end;

procedure TNFItensModel.SetVBC_IPI(const Value: Variant);
begin
  FVBC_IPI := Value;
end;

procedure TNFItensModel.SetVBC_N15(const Value: Variant);
begin
  FVBC_N15 := Value;
end;

procedure TNFItensModel.SetVBC_P02(const Value: Variant);
begin
  FVBC_P02 := Value;
end;

procedure TNFItensModel.SetVBC_Q07(const Value: Variant);
begin
  FVBC_Q07 := Value;
end;

procedure TNFItensModel.SetVBC_S07(const Value: Variant);
begin
  FVBC_S07 := Value;
end;

procedure TNFItensModel.SetVCOFINS_S11(const Value: Variant);
begin
  FVCOFINS_S11 := Value;
end;

procedure TNFItensModel.SetVCREDICMSSN(const Value: Variant);
begin
  FVCREDICMSSN := Value;
end;

procedure TNFItensModel.SetVDESC(const Value: Variant);
begin
  FVDESC := Value;
end;

procedure TNFItensModel.SetVDESCDI_I29(const Value: Variant);
begin
  FVDESCDI_I29 := Value;
end;

procedure TNFItensModel.SetVDESPADU_P03(const Value: Variant);
begin
  FVDESPADU_P03 := Value;
end;

procedure TNFItensModel.SetVFCP(const Value: Variant);
begin
  FVFCP := Value;
end;

procedure TNFItensModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TNFItensModel.SetVFCPSTRET(const Value: Variant);
begin
  FVFCPSTRET := Value;
end;

procedure TNFItensModel.SetVFCPUFDEST(const Value: Variant);
begin
  FVFCPUFDEST := Value;
end;

procedure TNFItensModel.SetVICMSDESON(const Value: Variant);
begin
  FVICMSDESON := Value;
end;

procedure TNFItensModel.SetVICMSEFET(const Value: Variant);
begin
  FVICMSEFET := Value;
end;

procedure TNFItensModel.SetVICMSSTRET(const Value: Variant);
begin
  FVICMSSTRET := Value;
end;

procedure TNFItensModel.SetVICMSST_N23(const Value: Variant);
begin
  FVICMSST_N23 := Value;
end;

procedure TNFItensModel.SetVICMSSUBISTITUTORET(const Value: Variant);
begin
  FVICMSSUBISTITUTORET := Value;
end;

procedure TNFItensModel.SetVICMSUFDEST(const Value: Variant);
begin
  FVICMSUFDEST := Value;
end;

procedure TNFItensModel.SetVICMSUFREMET(const Value: Variant);
begin
  FVICMSUFREMET := Value;
end;

procedure TNFItensModel.SetVICMS_N17(const Value: Variant);
begin
  FVICMS_N17 := Value;
end;

procedure TNFItensModel.SetVII_P04(const Value: Variant);
begin
  FVII_P04 := Value;
end;

procedure TNFItensModel.SetVIOF_P05(const Value: Variant);
begin
  FVIOF_P05 := Value;
end;

procedure TNFItensModel.SetVLRCUSTO_NF(const Value: Variant);
begin
  FVLRCUSTO_NF := Value;
end;

procedure TNFItensModel.SetVLRVENDA_NF(const Value: Variant);
begin
  FVLRVENDA_NF := Value;
end;

procedure TNFItensModel.SetVOUTROS(const Value: Variant);
begin
  FVOUTROS := Value;
end;

procedure TNFItensModel.SetVPIS_Q09(const Value: Variant);
begin
  FVPIS_Q09 := Value;
end;

procedure TNFItensModel.SetVPRCOMP(const Value: Variant);
begin
  FVPRCOMP := Value;
end;

procedure TNFItensModel.SetVSEG(const Value: Variant);
begin
  FVSEG := Value;
end;

procedure TNFItensModel.SetVTOTTRIB(const Value: Variant);
begin
  FVTOTTRIB := Value;
end;

procedure TNFItensModel.SetVTOTTRIB_ESTADUAL(const Value: Variant);
begin
  FVTOTTRIB_ESTADUAL := Value;
end;

procedure TNFItensModel.SetVTOTTRIB_FEDERAL(const Value: Variant);
begin
  FVTOTTRIB_FEDERAL := Value;
end;

procedure TNFItensModel.SetVTOTTRIB_MUNICIPAL(const Value: Variant);
begin
  FVTOTTRIB_MUNICIPAL := Value;
end;

procedure TNFItensModel.SetVUNTRIB(const Value: Variant);
begin
  FVUNTRIB := Value;
end;

procedure TNFItensModel.SetV_PROD(const Value: Variant);
begin
  FV_PROD := Value;
end;

procedure TNFItensModel.SetV_PROD2(const Value: Variant);
begin
  FV_PROD2 := Value;
end;

procedure TNFItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TNFItensModel.SetXLOCDESEMB_I21(const Value: Variant);
begin
  FXLOCDESEMB_I21 := Value;
end;

procedure TNFItensModel.SetXPED(const Value: Variant);
begin
  FXPED := Value;
end;

end.
