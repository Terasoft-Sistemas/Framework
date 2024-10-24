unit NFModel;

interface

uses
  SysUtils,
  Terasoft.Types,
  FireDAC.Comp.Client,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TNFModel = class;
  ITNFModel=IObject<TNFModel>;

  TNFModel = class
  private
    [unsafe] mySelf: ITNFModel;
    vIConexao : IConexao;
    FAcao: TAcao;
    FVFCPUFDEST: Variant;
    FDATA_NF: Variant;
    FENTREGA_BAIRRO: Variant;
    FCAIXA_SAT: Variant;
    FGNRE_IMPRESSO: Variant;
    FNUMERO_PROCESSO: Variant;
    FVICMSUFREMET: Variant;
    FBASE_ST_NF: Variant;
    FVALOR_EXTENSO: Variant;
    FLOJA_ORIGEM: Variant;
    FREF_AAMM: Variant;
    FVTOTTRIB_FEDERAL: Variant;
    FDR: Variant;
    FDATA_CANCELAMENTO: Variant;
    FTRANSPORTADORA_REDESPACHO_ID: Variant;
    FXPED: Variant;
    FVTOTTRIB_MUNICIPAL: Variant;
    FSTATUS_TRANSMISSAO: Variant;
    FNUMERO_ECF: Variant;
    FOBS_NF: Variant;
    FDESCONTO_NF: Variant;
    FVICMS_NF: Variant;
    FENTREGA_UF: Variant;
    FNUMERO_SERIE_ECF: Variant;
    FTRANSPORTADORA: Variant;
    FVFCP: Variant;
    FREF_CNPJ: Variant;
    FVALOR_NF: Variant;
    FINDPRES: Variant;
    FORCAMENTO_ID: Variant;
    FENTRADA_ID: Variant;
    FDESPESA_IMPORTACAO: Variant;
    FTRANSPORTADORA_ID: Variant;
    FID_NF3: Variant;
    FPESO_LIQUIDO: Variant;
    FPESO_LIQUIDO_NEW: Variant;
    FPEDIDO_ID: Variant;
    FCONV: Variant;
    FRECIBO_NFE: Variant;
    FICMS_NF: Variant;
    FINTERMEDIADOR_NOME: Variant;
    FAGRUPAMENTO_FATURA: Variant;
    FTRA_MARCA: Variant;
    FVALOR_SUFRAMA: Variant;
    FTIPO_FRETE: Variant;
    FNOME_XML: Variant;
    FCODIGO_VEN: Variant;
    FENTREGA_CEP: Variant;
    FTRA_PLACA: Variant;
    FCNPJ_CPF_CONSUMIDOR: Variant;
    FVALOR_PAGO: Variant;
    FXML_NFE: Variant;
    FPCTE: Variant;
    FENTREGA_NUMERO: Variant;
    FVSEG: Variant;
    FAIH: Variant;
    FDATA_SAIDA: Variant;
    FVPIS: Variant;
    FQTPARCELAS: Variant;
    FMODELO: Variant;
    FCODIGO_CLI: Variant;
    FWEB_PEDIDO_ID: Variant;
    FID: Variant;
    FVCOFINS: Variant;
    FESPECIE_VOLUME: Variant;
    FTOTAL_NF: Variant;
    FSERIE_NF: Variant;
    FCODIGO_PORT: Variant;
    FTRANSFERENCIA_ID: Variant;
    FTRA_RNTC: Variant;
    FREF_SERIE: Variant;
    FVTOTTRIB_ESTADUAL: Variant;
    FICMS_ST: Variant;
    FBICMS_NF: Variant;
    FACRES_NF: Variant;
    FVDOLAR: Variant;
    FSTATUS: Variant;
    FAUTORIZADA: Variant;
    FLOJA: Variant;
    FCFOP_NF: Variant;
    FNUMERO_NF: Variant;
    FENTREGA_COMPLEMENTO: Variant;
    FINTERMEDIADOR_CNPJ: Variant;
    FCFOP_ID: Variant;
    FOBS_FISCAL: Variant;
    FFISCO_NF: Variant;
    FGNRE: Variant;
    FOUTROS_NF: Variant;
    FISENTA_NF: Variant;
    FCONDICOES_PAGTO: Variant;
    FPESO_BRUTO: Variant;
    FSTATUS_NF: Variant;
    FSYSTIME: Variant;
    FPESO_BRUTO_NEW: Variant;
    FREF_NNF: Variant;
    FREF_CUF: Variant;
    FHORA_SAIDA: Variant;
    FHEM: Variant;
    FEMAIL_NFE: Variant;
    FCNF: Variant;
    FCONSIGNADO_ID: Variant;
    FSAIDAS_ID: Variant;
    FDEVOLUCAO_ID: Variant;
    FCTR_IMPRESSAO_NF: Variant;
    FLOCAL_EMBARQUE: Variant;
    FVTOTTRIB: Variant;
    FN_SERIE_SAT: Variant;
    FVIPIDEVOL: Variant;
    FCODIGO_TIP: Variant;
    FVCREDICMSSN: Variant;
    FCCF_CUPOM: Variant;
    FNUMERO_PED: Variant;
    FENTREGA_CIDADE: Variant;
    FSTATUS_PENDENTE: Variant;
    FCONSIGNADO_STATUS: Variant;
    FVEND: Variant;
    FENTREGA_ENDERECO: Variant;
    FVICMSSTRET: Variant;
    FPROTOCOLO_NFE: Variant;
    FTRA_UF: Variant;
    FREF_MOD: Variant;
    FINFO_COMPLEMENTAR: Variant;
    FFRETE: Variant;
    FENTREGA_COD_MUNICIPIO: Variant;
    FVICMSUFDEST: Variant;
    FVFCPST: Variant;
    FNFE: Variant;
    FQTDE_VOLUME: Variant;
    FVICMSDESON: Variant;
    FDATA_HORA_AUTORIZACAO: Variant;
    FUSUARIO_NF: Variant;
    FDESC_NF: Variant;
    FTRA_NUMERACAO: Variant;
    FVFCPSTRET: Variant;
    FID_INFO_COMPLEMENTAR: Variant;
    FTIPO_NF: Variant;
    FOS_ID: Variant;
    FVII: Variant;
    FUF_EMBARQUE: Variant;
    FVLRENTRADA_NF: Variant;
    FIPI_NF: Variant;
    FCLIENTE_NF: Variant;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDPedidoView: Integer;
    FNFLista: IList<ITNFModel>;
    FHORA_NF: Variant;
    FCidade_transp: Variant;
    Fcnpj_cpf_cliente: Variant;
    FEndereco_transp: Variant;
    FEstado_transp: Variant;
    Fbairro_cliente: Variant;
    Frazao_social_cliente: Variant;
    FNome_usuario: Variant;
    FBairro_transp: Variant;
    Fcep_cliente: Variant;
    Fnumero_cliente: Variant;
    FCep_transp: Variant;
    Fcomplemento_cliente: Variant;
    Fcontato_cliente: Variant;
    Fcliente_nome_cliente: Variant;
    Ftransportadora_nome_transp: Variant;
    Fcidade_cliente: Variant;
    FComplemento_transp: Variant;
    Fendereco_cliente: Variant;
    FContato_transp: Variant;
    Ftelefone_cliente: Variant;
    Festado_cliente: Variant;
    FVendedor_Nome: Variant;
    Fcelular_cliente: Variant;
    FTOTAL_BASE_COFINS: Variant;
    FQUANTIDADE_PRODUTOS: Variant;
    FTOTAL_DESCONTO: Variant;
    FTOTAL_BASE_IPI: Variant;
    FTOTAL_ICMS: Variant;
    FTOTAL_FCP: Variant;
    FTOTAL_ICMS_ST: Variant;
    FQUANTIDADE_ITENS: Variant;
    FTOTAL_OUTROS: Variant;
    FTOTAL_PIS: Variant;
    FTOTAL_BASE_ICMS: Variant;
    FTOTAL_COFINS: Variant;
    FTOTAL_FCP_ST: Variant;
    FTOTAL_ICMS_DESON: Variant;
    FTOTAL_DESCONTO_PERCENTUAL: Variant;
    FTOTAL_PRODUTOS: Variant;
    FTOTAL_FRETE: Variant;
    FTOTAL_BASE_ICMS_ST: Variant;
    FTOTAL_IPI: Variant;
    FTOTAL_BASE_PIS: Variant;
    FTOTAL_TOTALNF: Variant;
    FNumeroNFView: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetACRES_NF(const Value: Variant);
    procedure SetAGRUPAMENTO_FATURA(const Value: Variant);
    procedure SetAIH(const Value: Variant);
    procedure SetAUTORIZADA(const Value: Variant);
    procedure SetBASE_ST_NF(const Value: Variant);
    procedure SetBICMS_NF(const Value: Variant);
    procedure SetCAIXA_SAT(const Value: Variant);
    procedure SetCCF_CUPOM(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCFOP_NF(const Value: Variant);
    procedure SetCNF(const Value: Variant);
    procedure SetCNPJ_CPF_CONSUMIDOR(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCODIGO_PORT(const Value: Variant);
    procedure SetCODIGO_TIP(const Value: Variant);
    procedure SetCODIGO_VEN(const Value: Variant);
    procedure SetCONDICOES_PAGTO(const Value: Variant);
    procedure SetCONSIGNADO_ID(const Value: Variant);
    procedure SetCONSIGNADO_STATUS(const Value: Variant);
    procedure SetCONV(const Value: Variant);
    procedure SetCTR_IMPRESSAO_NF(const Value: Variant);
    procedure SetDATA_CANCELAMENTO(const Value: Variant);
    procedure SetDATA_HORA_AUTORIZACAO(const Value: Variant);
    procedure SetDATA_NF(const Value: Variant);
    procedure SetDATA_SAIDA(const Value: Variant);
    procedure SetDESC_NF(const Value: Variant);
    procedure SetDESCONTO_NF(const Value: Variant);
    procedure SetDESPESA_IMPORTACAO(const Value: Variant);
    procedure SetDEVOLUCAO_ID(const Value: Variant);
    procedure SetDR(const Value: Variant);
    procedure SetEMAIL_NFE(const Value: Variant);
    procedure SetENTRADA_ID(const Value: Variant);
    procedure SetENTREGA_BAIRRO(const Value: Variant);
    procedure SetENTREGA_CEP(const Value: Variant);
    procedure SetENTREGA_CIDADE(const Value: Variant);
    procedure SetENTREGA_COD_MUNICIPIO(const Value: Variant);
    procedure SetENTREGA_COMPLEMENTO(const Value: Variant);
    procedure SetENTREGA_ENDERECO(const Value: Variant);
    procedure SetENTREGA_NUMERO(const Value: Variant);
    procedure SetENTREGA_UF(const Value: Variant);
    procedure SetESPECIE_VOLUME(const Value: Variant);
    procedure SetFISCO_NF(const Value: Variant);
    procedure SetFRETE(const Value: Variant);
    procedure SetGNRE(const Value: Variant);
    procedure SetGNRE_IMPRESSO(const Value: Variant);
    procedure SetHEM(const Value: Variant);
    procedure SetHORA_SAIDA(const Value: Variant);
    procedure SetICMS_NF(const Value: Variant);
    procedure SetICMS_ST(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetID_INFO_COMPLEMENTAR(const Value: Variant);
    procedure SetID_NF3(const Value: Variant);
    procedure SetINDPRES(const Value: Variant);
    procedure SetINFO_COMPLEMENTAR(const Value: Variant);
    procedure SetINTERMEDIADOR_CNPJ(const Value: Variant);
    procedure SetINTERMEDIADOR_NOME(const Value: Variant);
    procedure SetIPI_NF(const Value: Variant);
    procedure SetISENTA_NF(const Value: Variant);
    procedure SetLOCAL_EMBARQUE(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLOJA_ORIGEM(const Value: Variant);
    procedure SetMODELO(const Value: Variant);
    procedure SetN_SERIE_SAT(const Value: Variant);
    procedure SetNFE(const Value: Variant);
    procedure SetNOME_XML(const Value: Variant);
    procedure SetNUMERO_ECF(const Value: Variant);
    procedure SetNUMERO_NF(const Value: Variant);
    procedure SetNUMERO_PED(const Value: Variant);
    procedure SetNUMERO_PROCESSO(const Value: Variant);
    procedure SetNUMERO_SERIE_ECF(const Value: Variant);
    procedure SetOBS_FISCAL(const Value: Variant);
    procedure SetOBS_NF(const Value: Variant);
    procedure SetORCAMENTO_ID(const Value: Variant);
    procedure SetOS_ID(const Value: Variant);
    procedure SetOUTROS_NF(const Value: Variant);
    procedure SetPCTE(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetPESO_BRUTO(const Value: Variant);
    procedure SetPESO_BRUTO_NEW(const Value: Variant);
    procedure SetPESO_LIQUIDO(const Value: Variant);
    procedure SetPESO_LIQUIDO_NEW(const Value: Variant);
    procedure SetPROTOCOLO_NFE(const Value: Variant);
    procedure SetQTDE_VOLUME(const Value: Variant);
    procedure SetQTPARCELAS(const Value: Variant);
    procedure SetRECIBO_NFE(const Value: Variant);
    procedure SetREF_AAMM(const Value: Variant);
    procedure SetREF_CNPJ(const Value: Variant);
    procedure SetREF_CUF(const Value: Variant);
    procedure SetREF_MOD(const Value: Variant);
    procedure SetREF_NNF(const Value: Variant);
    procedure SetREF_SERIE(const Value: Variant);
    procedure SetSAIDAS_ID(const Value: Variant);
    procedure SetSERIE_NF(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSTATUS_NF(const Value: Variant);
    procedure SetSTATUS_PENDENTE(const Value: Variant);
    procedure SetSTATUS_TRANSMISSAO(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO_FRETE(const Value: Variant);
    procedure SetTIPO_NF(const Value: Variant);
    procedure SetTOTAL_NF(const Value: Variant);
    procedure SetTRA_MARCA(const Value: Variant);
    procedure SetTRA_NUMERACAO(const Value: Variant);
    procedure SetTRA_PLACA(const Value: Variant);
    procedure SetTRA_RNTC(const Value: Variant);
    procedure SetTRA_UF(const Value: Variant);
    procedure SetTRANSFERENCIA_ID(const Value: Variant);
    procedure SetTRANSPORTADORA(const Value: Variant);
    procedure SetTRANSPORTADORA_ID(const Value: Variant);
    procedure SetTRANSPORTADORA_REDESPACHO_ID(const Value: Variant);
    procedure SetUF_EMBARQUE(const Value: Variant);
    procedure SetUSUARIO_NF(const Value: Variant);
    procedure SetVALOR_EXTENSO(const Value: Variant);
    procedure SetVALOR_NF(const Value: Variant);
    procedure SetVALOR_PAGO(const Value: Variant);
    procedure SetVALOR_SUFRAMA(const Value: Variant);
    procedure SetVCOFINS(const Value: Variant);
    procedure SetVCREDICMSSN(const Value: Variant);
    procedure SetVDOLAR(const Value: Variant);
    procedure SetVEND(const Value: Variant);
    procedure SetVFCP(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetVFCPSTRET(const Value: Variant);
    procedure SetVFCPUFDEST(const Value: Variant);
    procedure SetVICMS_NF(const Value: Variant);
    procedure SetVICMSDESON(const Value: Variant);
    procedure SetVICMSSTRET(const Value: Variant);
    procedure SetVICMSUFDEST(const Value: Variant);
    procedure SetVICMSUFREMET(const Value: Variant);
    procedure SetVII(const Value: Variant);
    procedure SetVIPIDEVOL(const Value: Variant);
    procedure SetVLRENTRADA_NF(const Value: Variant);
    procedure SetVPIS(const Value: Variant);
    procedure SetVSEG(const Value: Variant);
    procedure SetVTOTTRIB(const Value: Variant);
    procedure SetVTOTTRIB_ESTADUAL(const Value: Variant);
    procedure SetVTOTTRIB_FEDERAL(const Value: Variant);
    procedure SetVTOTTRIB_MUNICIPAL(const Value: Variant);
    procedure SetWEB_PEDIDO_ID(const Value: Variant);
    procedure SetXML_NFE(const Value: Variant);
    procedure SetXPED(const Value: Variant);
    procedure SetCLIENTE_NF(const Value: Variant);
    procedure SetCountView(const Value: String);
    procedure SetIDPedidoView(const Value: Integer);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetNFLista(const Value: IList<ITNFModel>);
    procedure SetHORA_NF(const Value: Variant);
    procedure Setbairro_cliente(const Value: Variant);
    procedure SetBairro_transp(const Value: Variant);
    procedure Setcelular_cliente(const Value: Variant);
    procedure Setcep_cliente(const Value: Variant);
    procedure SetCep_transp(const Value: Variant);
    procedure Setcidade_cliente(const Value: Variant);
    procedure SetCidade_transp(const Value: Variant);
    procedure Setcliente_nome_cliente(const Value: Variant);
    procedure Setcnpj_cpf_cliente(const Value: Variant);
    procedure Setcomplemento_cliente(const Value: Variant);
    procedure SetComplemento_transp(const Value: Variant);
    procedure Setcontato_cliente(const Value: Variant);
    procedure SetContato_transp(const Value: Variant);
    procedure Setendereco_cliente(const Value: Variant);
    procedure SetEndereco_transp(const Value: Variant);
    procedure Setestado_cliente(const Value: Variant);
    procedure SetEstado_transp(const Value: Variant);
    procedure SetNome_usuario(const Value: Variant);
    procedure Setnumero_cliente(const Value: Variant);
    procedure Setrazao_social_cliente(const Value: Variant);
    procedure Settelefone_cliente(const Value: Variant);
    procedure Settransportadora_nome_transp(const Value: Variant);
    procedure SetVendedor_Nome(const Value: Variant);
    procedure SetQUANTIDADE_ITENS(const Value: Variant);
    procedure SetQUANTIDADE_PRODUTOS(const Value: Variant);
    procedure SetTOTAL_BASE_COFINS(const Value: Variant);
    procedure SetTOTAL_BASE_ICMS(const Value: Variant);
    procedure SetTOTAL_BASE_ICMS_ST(const Value: Variant);
    procedure SetTOTAL_BASE_IPI(const Value: Variant);
    procedure SetTOTAL_BASE_PIS(const Value: Variant);
    procedure SetTOTAL_COFINS(const Value: Variant);
    procedure SetTOTAL_DESCONTO(const Value: Variant);
    procedure SetTOTAL_DESCONTO_PERCENTUAL(const Value: Variant);
    procedure SetTOTAL_FCP(const Value: Variant);
    procedure SetTOTAL_FCP_ST(const Value: Variant);
    procedure SetTOTAL_FRETE(const Value: Variant);
    procedure SetTOTAL_ICMS(const Value: Variant);
    procedure SetTOTAL_ICMS_DESON(const Value: Variant);
    procedure SetTOTAL_ICMS_ST(const Value: Variant);
    procedure SetTOTAL_IPI(const Value: Variant);
    procedure SetTOTAL_OUTROS(const Value: Variant);
    procedure SetTOTAL_PIS(const Value: Variant);
    procedure SetTOTAL_PRODUTOS(const Value: Variant);
    procedure SetTOTAL_TOTALNF(const Value: Variant);
    procedure SetNumeroNFView(const Value: String);

  public
    property  Acao                         :TAcao   read FAcao write SetAcao;
    property  NUMERO_NF                    :Variant read FNUMERO_NF write SetNUMERO_NF;
    property  SERIE_NF                     :Variant read FSERIE_NF write SetSERIE_NF;
    property  CODIGO_CLI                   :Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property  CODIGO_VEN                   :Variant read FCODIGO_VEN write SetCODIGO_VEN;
    property  CODIGO_PORT                  :Variant read FCODIGO_PORT write SetCODIGO_PORT;
    property  CODIGO_TIP                   :Variant read FCODIGO_TIP write SetCODIGO_TIP;
    property  DATA_NF                      :Variant read FDATA_NF write SetDATA_NF;
    property  VALOR_NF                     :Variant read FVALOR_NF write SetVALOR_NF;
    property  DESC_NF                      :Variant read FDESC_NF write SetDESC_NF;
    property  ACRES_NF                     :Variant read FACRES_NF write SetACRES_NF;
    property  TOTAL_NF                     :Variant read FTOTAL_NF write SetTOTAL_NF;
    property  BICMS_NF                     :Variant read FBICMS_NF write SetBICMS_NF;
    property  VICMS_NF                     :Variant read FVICMS_NF write SetVICMS_NF;
    property  ICMS_NF                      :Variant read FICMS_NF write SetICMS_NF;
    property  USUARIO_NF                   :Variant read FUSUARIO_NF write SetUSUARIO_NF;
    property  NUMERO_PED                   :Variant read FNUMERO_PED write SetNUMERO_PED;
    property  TIPO_NF                      :Variant read FTIPO_NF write SetTIPO_NF;
    property  STATUS_NF                    :Variant read FSTATUS_NF write SetSTATUS_NF;
    property  DESCONTO_NF                  :Variant read FDESCONTO_NF write SetDESCONTO_NF;
    property  CFOP_NF                      :Variant read FCFOP_NF write SetCFOP_NF;
    property  FISCO_NF                     :Variant read FFISCO_NF write SetFISCO_NF;
    property  OBS_NF                       :Variant read FOBS_NF write SetOBS_NF;
    property  NUMERO_ECF                   :Variant read FNUMERO_ECF write SetNUMERO_ECF;
    property  DATA_CANCELAMENTO            :Variant read FDATA_CANCELAMENTO write SetDATA_CANCELAMENTO;
    property  PESO_LIQUIDO                 :Variant read FPESO_LIQUIDO write SetPESO_LIQUIDO;
    property  PESO_BRUTO                   :Variant read FPESO_BRUTO write SetPESO_BRUTO;
    property  VALOR_EXTENSO                :Variant read FVALOR_EXTENSO write SetVALOR_EXTENSO;
    property  QTDE_VOLUME                  :Variant read FQTDE_VOLUME write SetQTDE_VOLUME;
    property  ESPECIE_VOLUME               :Variant read FESPECIE_VOLUME write SetESPECIE_VOLUME;
    property  TRANSPORTADORA               :Variant read FTRANSPORTADORA write SetTRANSPORTADORA;
    property  DATA_SAIDA                   :Variant read FDATA_SAIDA write SetDATA_SAIDA;
    property  FRETE                        :Variant read FFRETE write SetFRETE;
    property  CONDICOES_PAGTO              :Variant read FCONDICOES_PAGTO write SetCONDICOES_PAGTO;
    property  LOJA                         :Variant read FLOJA write SetLOJA;
    property  ISENTA_NF                    :Variant read FISENTA_NF write SetISENTA_NF;
    property  OUTROS_NF                    :Variant read FOUTROS_NF write SetOUTROS_NF;
    property  BASE_ST_NF                   :Variant read FBASE_ST_NF write SetBASE_ST_NF;
    property  ICMS_ST                      :Variant read FICMS_ST write SetICMS_ST;
    property  IPI_NF                       :Variant read FIPI_NF write SetIPI_NF;
    property  ID_NF3                       :Variant read FID_NF3 write SetID_NF3;
    property  RECIBO_NFE                   :Variant read FRECIBO_NFE write SetRECIBO_NFE;
    property  PROTOCOLO_NFE                :Variant read FPROTOCOLO_NFE write SetPROTOCOLO_NFE;
    property  NFE                          :Variant read FNFE write SetNFE;
    property  AUTORIZADA                   :Variant read FAUTORIZADA write SetAUTORIZADA;
    property  MODELO                       :Variant read FMODELO write SetMODELO;
    property  VLRENTRADA_NF                :Variant read FVLRENTRADA_NF write SetVLRENTRADA_NF;
    property  QTPARCELAS                   :Variant read FQTPARCELAS write SetQTPARCELAS;
    property  NUMERO_SERIE_ECF             :Variant read FNUMERO_SERIE_ECF write SetNUMERO_SERIE_ECF;
    property  CCF_CUPOM                    :Variant read FCCF_CUPOM write SetCCF_CUPOM;
    property  EMAIL_NFE                    :Variant read FEMAIL_NFE write SetEMAIL_NFE;
    property  NOME_XML                     :Variant read FNOME_XML write SetNOME_XML;
    property  STATUS                       :Variant read FSTATUS write SetSTATUS;
    property  PCTE                         :Variant read FPCTE write SetPCTE;
    property  HEM                          :Variant read FHEM write SetHEM;
    property  DR                           :Variant read FDR write SetDR;
    property  AIH                          :Variant read FAIH write SetAIH;
    property  VEND                         :Variant read FVEND write SetVEND;
    property  CONV                         :Variant read FCONV write SetCONV;
    property  ID_INFO_COMPLEMENTAR         :Variant read FID_INFO_COMPLEMENTAR write SetID_INFO_COMPLEMENTAR;
    property  TIPO_FRETE                   :Variant read FTIPO_FRETE write SetTIPO_FRETE;
    property  TRANSPORTADORA_ID            :Variant read FTRANSPORTADORA_ID write SetTRANSPORTADORA_ID;
    property  VCREDICMSSN                  :Variant read FVCREDICMSSN write SetVCREDICMSSN;
    property  VPIS                         :Variant read FVPIS write SetVPIS;
    property  VCOFINS                      :Variant read FVCOFINS write SetVCOFINS;
    property  ID                           :Variant read FID write SetID;
    property  VTOTTRIB                     :Variant read FVTOTTRIB write SetVTOTTRIB;
    property  OBS_FISCAL                   :Variant read FOBS_FISCAL write SetOBS_FISCAL;
    property  INFO_COMPLEMENTAR            :Variant read FINFO_COMPLEMENTAR write SetINFO_COMPLEMENTAR;
    property  CFOP_ID                      :Variant read FCFOP_ID write SetCFOP_ID;
    property  UF_EMBARQUE                  :Variant read FUF_EMBARQUE write SetUF_EMBARQUE;
    property  LOCAL_EMBARQUE               :Variant read FLOCAL_EMBARQUE write SetLOCAL_EMBARQUE;
    property  VSEG                         :Variant read FVSEG write SetVSEG;
    property  VII                          :Variant read FVII write SetVII;
    property  VALOR_SUFRAMA                :Variant read FVALOR_SUFRAMA write SetVALOR_SUFRAMA;
    property  XML_NFE                      :Variant read FXML_NFE write SetXML_NFE;
    property  STATUS_TRANSMISSAO           :Variant read FSTATUS_TRANSMISSAO write SetSTATUS_TRANSMISSAO;
    property  HORA_SAIDA                   :Variant read FHORA_SAIDA write SetHORA_SAIDA;
    property  VTOTTRIB_FEDERAL             :Variant read FVTOTTRIB_FEDERAL write SetVTOTTRIB_FEDERAL;
    property  VTOTTRIB_ESTADUAL            :Variant read FVTOTTRIB_ESTADUAL write SetVTOTTRIB_ESTADUAL;
    property  VTOTTRIB_MUNICIPAL           :Variant read FVTOTTRIB_MUNICIPAL write SetVTOTTRIB_MUNICIPAL;
    property  CTR_IMPRESSAO_NF             :Variant read FCTR_IMPRESSAO_NF write SetCTR_IMPRESSAO_NF;
    property  VALOR_PAGO                   :Variant read FVALOR_PAGO write SetVALOR_PAGO;
    property  XPED                         :Variant read FXPED write SetXPED;
    property  CNPJ_CPF_CONSUMIDOR          :Variant read FCNPJ_CPF_CONSUMIDOR write SetCNPJ_CPF_CONSUMIDOR;
    property  DEVOLUCAO_ID                 :Variant read FDEVOLUCAO_ID write SetDEVOLUCAO_ID;
    property  PEDIDO_ID                    :Variant read FPEDIDO_ID write SetPEDIDO_ID;
    property  OS_ID                        :Variant read FOS_ID write SetOS_ID;
    property  ORCAMENTO_ID                 :Variant read FORCAMENTO_ID write SetORCAMENTO_ID;
    property  SAIDAS_ID                    :Variant read FSAIDAS_ID write SetSAIDAS_ID;
    property  REF_CUF                      :Variant read FREF_CUF write SetREF_CUF;
    property  REF_AAMM                     :Variant read FREF_AAMM write SetREF_AAMM;
    property  REF_CNPJ                     :Variant read FREF_CNPJ write SetREF_CNPJ;
    property  REF_MOD                      :Variant read FREF_MOD write SetREF_MOD;
    property  REF_SERIE                    :Variant read FREF_SERIE write SetREF_SERIE;
    property  REF_NNF                      :Variant read FREF_NNF write SetREF_NNF;
    property  VFCP                         :Variant read FVFCP write SetVFCP;
    property  VFCPST                       :Variant read FVFCPST write SetVFCPST;
    property  VFCPSTRET                    :Variant read FVFCPSTRET write SetVFCPSTRET;
    property  VFCPUFDEST                   :Variant read FVFCPUFDEST write SetVFCPUFDEST;
    property  VICMSUFDEST                  :Variant read FVICMSUFDEST write SetVICMSUFDEST;
    property  VICMSUFREMET                 :Variant read FVICMSUFREMET write SetVICMSUFREMET;
    property  INDPRES                      :Variant read FINDPRES write SetINDPRES;
    property  GNRE                         :Variant read FGNRE write SetGNRE;
    property  VDOLAR                       :Variant read FVDOLAR write SetVDOLAR;
    property  NUMERO_PROCESSO              :Variant read FNUMERO_PROCESSO write SetNUMERO_PROCESSO;
    property  GNRE_IMPRESSO                :Variant read FGNRE_IMPRESSO write SetGNRE_IMPRESSO;
    property  TRA_PLACA                    :Variant read FTRA_PLACA write SetTRA_PLACA;
    property  TRA_RNTC                     :Variant read FTRA_RNTC write SetTRA_RNTC;
    property  TRA_UF                       :Variant read FTRA_UF write SetTRA_UF;
    property  TRA_MARCA                    :Variant read FTRA_MARCA write SetTRA_MARCA;
    property  TRA_NUMERACAO                :Variant read FTRA_NUMERACAO write SetTRA_NUMERACAO;
    property  TRANSPORTADORA_REDESPACHO_ID :Variant read FTRANSPORTADORA_REDESPACHO_ID write SetTRANSPORTADORA_REDESPACHO_ID;
    property  DESPESA_IMPORTACAO           :Variant read FDESPESA_IMPORTACAO write SetDESPESA_IMPORTACAO;
    property  DATA_HORA_AUTORIZACAO        :Variant read FDATA_HORA_AUTORIZACAO write SetDATA_HORA_AUTORIZACAO;
    property  VIPIDEVOL                    :Variant read FVIPIDEVOL write SetVIPIDEVOL;
    property  N_SERIE_SAT                  :Variant read FN_SERIE_SAT write SetN_SERIE_SAT;
    property  CAIXA_SAT                    :Variant read FCAIXA_SAT write SetCAIXA_SAT;
    property  AGRUPAMENTO_FATURA           :Variant read FAGRUPAMENTO_FATURA write SetAGRUPAMENTO_FATURA;
    property  CONSIGNADO_ID                :Variant read FCONSIGNADO_ID write SetCONSIGNADO_ID;
    property  CONSIGNADO_STATUS            :Variant read FCONSIGNADO_STATUS write SetCONSIGNADO_STATUS;
    property  PESO_LIQUIDO_NEW             :Variant read FPESO_LIQUIDO_NEW write SetPESO_LIQUIDO_NEW;
    property  PESO_BRUTO_NEW               :Variant read FPESO_BRUTO_NEW write SetPESO_BRUTO_NEW;
    property  STATUS_PENDENTE              :Variant read FSTATUS_PENDENTE write SetSTATUS_PENDENTE;
    property  CNF                          :Variant read FCNF write SetCNF;
    property  VICMSDESON                   :Variant read FVICMSDESON write SetVICMSDESON;
    property  VICMSSTRET                   :Variant read FVICMSSTRET write SetVICMSSTRET;
    property  SYSTIME                      :Variant read FSYSTIME write SetSYSTIME;
    property  ENTRADA_ID                   :Variant read FENTRADA_ID write SetENTRADA_ID;
    property  INTERMEDIADOR_CNPJ           :Variant read FINTERMEDIADOR_CNPJ write SetINTERMEDIADOR_CNPJ;
    property  INTERMEDIADOR_NOME           :Variant read FINTERMEDIADOR_NOME write SetINTERMEDIADOR_NOME;
    property  LOJA_ORIGEM                  :Variant read FLOJA_ORIGEM write SetLOJA_ORIGEM;
    property  ENTREGA_ENDERECO             :Variant read FENTREGA_ENDERECO write SetENTREGA_ENDERECO;
    property  ENTREGA_COMPLEMENTO          :Variant read FENTREGA_COMPLEMENTO write SetENTREGA_COMPLEMENTO;
    property  ENTREGA_NUMERO               :Variant read FENTREGA_NUMERO write SetENTREGA_NUMERO;
    property  ENTREGA_BAIRRO               :Variant read FENTREGA_BAIRRO write SetENTREGA_BAIRRO;
    property  ENTREGA_CIDADE               :Variant read FENTREGA_CIDADE write SetENTREGA_CIDADE;
    property  ENTREGA_CEP                  :Variant read FENTREGA_CEP write SetENTREGA_CEP;
    property  ENTREGA_UF                   :Variant read FENTREGA_UF write SetENTREGA_UF;
    property  ENTREGA_COD_MUNICIPIO        :Variant read FENTREGA_COD_MUNICIPIO write SetENTREGA_COD_MUNICIPIO;
    property  WEB_PEDIDO_ID                :Variant read FWEB_PEDIDO_ID write SetWEB_PEDIDO_ID;
    property  TRANSFERENCIA_ID             :Variant read FTRANSFERENCIA_ID write SetTRANSFERENCIA_ID;
    property  CLIENTE_NF                   :Variant read FCLIENTE_NF write SetCLIENTE_NF;
    property  HORA_NF                      :Variant read FHORA_NF write SetHORA_NF;

    property razao_social_cliente          : Variant read Frazao_social_cliente write Setrazao_social_cliente;
    property cliente_nome_cliente          : Variant read Fcliente_nome_cliente write Setcliente_nome_cliente;
    property cnpj_cpf_cliente              : Variant read Fcnpj_cpf_cliente write Setcnpj_cpf_cliente;
    property cep_cliente                   : Variant read Fcep_cliente write Setcep_cliente;
    property endereco_cliente              : Variant read Fendereco_cliente write Setendereco_cliente;
    property numero_cliente                : Variant read Fnumero_cliente write Setnumero_cliente;
    property complemento_cliente           : Variant read Fcomplemento_cliente write Setcomplemento_cliente;
    property bairro_cliente                : Variant read Fbairro_cliente write Setbairro_cliente;
    property cidade_cliente                : Variant read Fcidade_cliente write Setcidade_cliente;
    property estado_cliente                : Variant read Festado_cliente write Setestado_cliente;
    property telefone_cliente              : Variant read Ftelefone_cliente write Settelefone_cliente;
    property celular_cliente               : Variant read Fcelular_cliente write Setcelular_cliente;
    property contato_cliente               : Variant read Fcontato_cliente write Setcontato_cliente;

    property Vendedor_Nome                 : Variant read FVendedor_Nome write SetVendedor_Nome;
    property transportadora_nome_transp    : Variant read Ftransportadora_nome_transp write Settransportadora_nome_transp;
    property Cep_transp                    : Variant read FCep_transp write SetCep_transp;
    property Endereco_transp               : Variant read FEndereco_transp write SetEndereco_transp;
    property Complemento_transp            : Variant read FComplemento_transp write SetComplemento_transp;
    property Bairro_transp                 : Variant read FBairro_transp write SetBairro_transp;
    property Cidade_transp                 : Variant read FCidade_transp write SetCidade_transp;
    property Estado_transp                 : Variant read FEstado_transp write SetEstado_transp;
    property Contato_transp                : Variant read FContato_transp write SetContato_transp;
    property Nome_usuario                  : Variant read FNome_usuario write SetNome_usuario;

    property QUANTIDADE_PRODUTOS       :Variant read FQUANTIDADE_PRODUTOS write SetQUANTIDADE_PRODUTOS;
    property QUANTIDADE_ITENS          :Variant read FQUANTIDADE_ITENS write SetQUANTIDADE_ITENS;
    property TOTAL_PRODUTOS            :Variant read FTOTAL_PRODUTOS write SetTOTAL_PRODUTOS;
    property TOTAL_BASE_ICMS           :Variant read FTOTAL_BASE_ICMS write SetTOTAL_BASE_ICMS;
    property TOTAL_ICMS                :Variant read FTOTAL_ICMS write SetTOTAL_ICMS;
    property TOTAL_BASE_ICMS_ST        :Variant read FTOTAL_BASE_ICMS_ST write SetTOTAL_BASE_ICMS_ST;
    property TOTAL_ICMS_ST             :Variant read FTOTAL_ICMS_ST write SetTOTAL_ICMS_ST;
    property TOTAL_ICMS_DESON          :Variant read FTOTAL_ICMS_DESON write SetTOTAL_ICMS_DESON;
    property TOTAL_BASE_IPI            :Variant read FTOTAL_BASE_IPI write SetTOTAL_BASE_IPI;
    property TOTAL_IPI                 :Variant read FTOTAL_IPI write SetTOTAL_IPI;
    property TOTAL_BASE_PIS            :Variant read FTOTAL_BASE_PIS write SetTOTAL_BASE_PIS;
    property TOTAL_PIS                 :Variant read FTOTAL_PIS write SetTOTAL_PIS;
    property TOTAL_BASE_COFINS         :Variant read FTOTAL_BASE_COFINS write SetTOTAL_BASE_COFINS;
    property TOTAL_COFINS              :Variant read FTOTAL_COFINS write SetTOTAL_COFINS;
    property TOTAL_FCP                 :Variant read FTOTAL_FCP write SetTOTAL_FCP;
    property TOTAL_FCP_ST              :Variant read FTOTAL_FCP_ST write SetTOTAL_FCP_ST;
    property TOTAL_FRETE               :Variant read FTOTAL_FRETE write SetTOTAL_FRETE;
    property TOTAL_OUTROS              :Variant read FTOTAL_OUTROS write SetTOTAL_OUTROS;
    property TOTAL_DESCONTO            :Variant read FTOTAL_DESCONTO write SetTOTAL_DESCONTO;
    property TOTAL_TOTALNF             :Variant read FTOTAL_TOTALNF write SetTOTAL_TOTALNF;
    property TOTAL_DESCONTO_PERCENTUAL :Variant read FTOTAL_DESCONTO_PERCENTUAL write SetTOTAL_DESCONTO_PERCENTUAL;


    property NFLista: IList<ITNFModel> read FNFLista write SetNFLista;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDPedidoView: Integer read FIDPedidoView write SetIDPedidoView;
    property NumeroNFView: String read FNumeroNFView write SetNumeroNFView;

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITNFModel;

    function Salvar: String;
    function Incluir: String;
    function carregaClasse(ID: String): ITNFModel;

    procedure obterLista;
    procedure obterListaNFe;
    procedure AtualizarDataEmissao(pNotaFiscal : String);
    function obterTotalizador: ITNFModel;

    function verificarNotas: IFDDataset;

 end;

implementation

uses
  Terasoft.Configuracoes, NFDao;

{ TNFModel }

function TNFModel.obterTotalizador: ITNFModel;
var
  lNFDao: ITNFDao;
begin
  lNFDao := TNFDao.getNewIface(vIConexao);

  lNFDao.objeto.NumeroNFView := FNumeroNFView;

  Result := lNFDao.objeto.obterTotalizador;

end;

procedure TNFModel.AtualizarDataEmissao(pNotaFiscal: String);
var
  lNFModel : ITNFModel;
begin
  lNFModel := TNFModel.getNewIface(vIConexao);

  try
    lNFModel := lNFModel.objeto.carregaClasse(pNotaFiscal);

    lNFModel.objeto.Acao := tacAlterar;
    lNFModel.objeto.DATA_NF    := DateToStr(vIConexao.DataServer);
    lNFModel.objeto.HORA_NF    := TimeToStr(vIConexao.HoraServer);
    lNFModel.objeto.DATA_SAIDA := lNFModel.objeto.DATA_NF;
    lNFModel.objeto.HORA_SAIDA := lNFModel.objeto.HORA_NF;
    lNFModel.objeto.Salvar;
  finally
    lNFModel := nil;
  end;
end;

function TNFModel.carregaClasse(ID: String): ITNFModel;
var
  lNFDao: ITNFDao;
begin
  lNFDao := TNFDao.getNewIface(vIConexao);
  try
    Result := lNFDao.objeto.carregaClasse(ID);
  finally
    lNFDao:=nil;
  end;
end;

constructor TNFModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TNFModel.Destroy;
begin
  FNFLista := nil;
  vIConexao := nil;
  inherited;
end;

class function TNFModel.getNewIface(pIConexao: IConexao): ITNFModel;
begin
  Result := TImplObjetoOwner<TNFModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TNFModel.Incluir: String;
var
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lConfiguracoes := TerasoftConfiguracoes.getNewIface(vIConexao);

  try
    Self.FDATA_NF            := vIConexao.DataServer;
    Self.FHORA_NF            := vIConexao.HoraServer;
    Self.FNUMERO_PED         := '000000';
    Self.FUSUARIO_NF         := vIConexao.getUSer.ID;
    Self.FLOJA               := vIConexao.getEmpresa.LOJA;
    Self.FTIPO_NF            := 'N';
    Self.FTIPO_FRETE         := '1';
    Self.FESPECIE_VOLUME     := 'VOLUME(S)';
    Self.FEMAIL_NFE          := '1';
    Self.FSTATUS_NF          := '0';
    Self.FDATA_SAIDA         := vIConexao.DataServer;
    Self.FHORA_SAIDA         := vIConexao.HoraServer;
    Self.FMODELO             := '55';
    Self.FINDPRES            := '1';
    Self.FSERIE_NF           := lConfiguracoes.objeto.valorTag('SERIE_NFE', '001', tvString);
    Self.FBICMS_NF           := FloatToStr(0);
    Self.FVICMS_NF           := FloatToStr(0);
    Self.FICMS_NF            := FloatToStr(0);
    Self.FBASE_ST_NF         := FloatToStr(0);
    Self.FIPI_NF             := FloatToStr(0);
    Self.FICMS_ST            := FloatToStr(0);
    Self.FVSEG               := FloatToStr(0);
    Self.FVALOR_SUFRAMA      := FloatToStr(0);
    Self.FVFCPST             := FloatToStr(0);
    Self.FVFCP               := FloatToStr(0);
    Self.FVICMSDESON         := FloatToStr(0);
    Self.FVICMSUFDEST        := FloatToStr(0);
    Self.FVICMSUFREMET       := FloatToStr(0);
    Self.FVICMSSTRET         := FloatToStr(0);
    Self.FVTOTTRIB_FEDERAL   := FloatToStr(0);
    Self.FVTOTTRIB_ESTADUAL  := FloatToStr(0);
    Self.FVTOTTRIB_MUNICIPAL := FloatToStr(0);
    Self.FVCREDICMSSN        := FloatToStr(0);
    Self.FVPIS               := FloatToStr(0);
    Self.FVCOFINS            := FloatToStr(0);
    Self.FVTOTTRIB           := FloatToStr(0);
    Self.FVII                := FloatToStr(0);
    Self.FVALOR_SUFRAMA      := FloatToStr(0);
    Self.FVFCPSTRET          := FloatToStr(0);
    Self.FVFCPUFDEST         := FloatToStr(0);
    Self.FVALOR_NF           := FloatToStr(0);
    Self.FACRES_NF           := FloatToStr(0);
    Self.FTOTAL_NF           := FloatToStr(0);
    Self.FDESC_NF            := FloatToStr(0);
    Self.FDESCONTO_NF        := FloatToStr(0);
    Self.FVALOR_PAGO         := FloatToStr(0);
    Self.FFRETE              := FloatToStr(0);
    Self.FOUTROS_NF          := FloatToStr(0);

//    Self.FAcao := tacIncluir;
//    Result := Self.Salvar;
  finally
    lConfiguracoes := nil;
  end;
end;

function TNFModel.Salvar: String;
var
  lNFDao: ITNFDao;
begin
  Result := '';
  lNFDao := TNFDao.getNewIface(vIConexao);

   try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lNFDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lNFDao.objeto.alterar(mySelf);
    end;

   finally
     lNFDao:=nil;
   end;

end;

procedure TNFModel.obterLista;
var
  lNFLista: ITNFDao;
begin
  lNFLista := TNFDao.getNewIface(vIConexao);

  try
    lNFLista.objeto.TotalRecords    := FTotalRecords;
    lNFLista.objeto.WhereView       := FWhereView;
    lNFLista.objeto.CountView       := FCountView;
    lNFLista.objeto.OrderView       := FOrderView;
    lNFLista.objeto.StartRecordView := FStartRecordView;
    lNFLista.objeto.LengthPageView  := FLengthPageView;
    lNFLista.objeto.IDRecordView    := FIDRecordView;
    lNFLista.objeto.IDPedidoView    := FIDPedidoView;

    lNFLista.objeto.obterLista;

    FTotalRecords  := lNFLista.objeto.TotalRecords;
    FNFLista       := lNFLista.objeto.NFLista;

  finally
    lNFLista:=nil;
  end;
end;

procedure TNFModel.obterListaNFe;
var
  lNFLista: ITNFDao;
begin
  lNFLista := TNFDao.getNewIface(vIConexao);

  try
    lNFLista.objeto.TotalRecords    := FTotalRecords;
    lNFLista.objeto.WhereView       := FWhereView;
    lNFLista.objeto.CountView       := FCountView;
    lNFLista.objeto.OrderView       := FOrderView;
    lNFLista.objeto.StartRecordView := FStartRecordView;
    lNFLista.objeto.LengthPageView  := FLengthPageView;
    lNFLista.objeto.IDRecordView    := FIDRecordView;
    lNFLista.objeto.IDPedidoView    := FIDPedidoView;

    lNFLista.objeto.obterListaNFe;

    FTotalRecords  := lNFLista.objeto.TotalRecords;
    FNFLista       := lNFLista.objeto.NFLista;

  finally
    lNFLista:=nil;
  end;
end;

function TNFModel.verificarNotas: IFDDataset;
var
  lNFDao: ITNFDao;
begin
  lNFDao := TNFDao.getNewIface(vIConexao);
  try
    Result := lNFDao.objeto.verificarNotas;
  finally
    lNFDao := nil;
  end;
end;

procedure TNFModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TNFModel.SetACRES_NF(const Value: Variant);
begin
  FACRES_NF := Value;
end;

procedure TNFModel.SetAGRUPAMENTO_FATURA(const Value: Variant);
begin
  FAGRUPAMENTO_FATURA := Value;
end;

procedure TNFModel.SetAIH(const Value: Variant);
begin
  FAIH := Value;
end;

procedure TNFModel.SetAUTORIZADA(const Value: Variant);
begin
  FAUTORIZADA := Value;
end;

procedure TNFModel.Setbairro_cliente(const Value: Variant);
begin
  Fbairro_cliente := Value;
end;

procedure TNFModel.SetBairro_transp(const Value: Variant);
begin
  FBairro_transp := Value;
end;

procedure TNFModel.SetBASE_ST_NF(const Value: Variant);
begin
  FBASE_ST_NF := Value;
end;

procedure TNFModel.SetBICMS_NF(const Value: Variant);
begin
  FBICMS_NF := Value;
end;

procedure TNFModel.SetCAIXA_SAT(const Value: Variant);
begin
  FCAIXA_SAT := Value;
end;

procedure TNFModel.SetCCF_CUPOM(const Value: Variant);
begin
  FCCF_CUPOM := Value;
end;

procedure TNFModel.Setcelular_cliente(const Value: Variant);
begin
  Fcelular_cliente := Value;
end;

procedure TNFModel.Setcep_cliente(const Value: Variant);
begin
  Fcep_cliente := Value;
end;

procedure TNFModel.SetCep_transp(const Value: Variant);
begin
  FCep_transp := Value;
end;

procedure TNFModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;

procedure TNFModel.SetCFOP_NF(const Value: Variant);
begin
  FCFOP_NF := Value;
end;

procedure TNFModel.Setcidade_cliente(const Value: Variant);
begin
  Fcidade_cliente := Value;
end;

procedure TNFModel.SetCidade_transp(const Value: Variant);
begin
  FCidade_transp := Value;
end;

procedure TNFModel.SetCLIENTE_NF(const Value: Variant);
begin
  FCLIENTE_NF := Value;
end;

procedure TNFModel.Setcliente_nome_cliente(const Value: Variant);
begin
  Fcliente_nome_cliente := Value;
end;

procedure TNFModel.SetCNF(const Value: Variant);
begin
  FCNF := Value;
end;

procedure TNFModel.Setcnpj_cpf_cliente(const Value: Variant);
begin
  Fcnpj_cpf_cliente := Value;
end;

procedure TNFModel.SetCNPJ_CPF_CONSUMIDOR(const Value: Variant);
begin
  FCNPJ_CPF_CONSUMIDOR := Value;
end;

procedure TNFModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TNFModel.SetCODIGO_PORT(const Value: Variant);
begin
  FCODIGO_PORT := Value;
end;

procedure TNFModel.SetCODIGO_TIP(const Value: Variant);
begin
  FCODIGO_TIP := Value;
end;

procedure TNFModel.SetCODIGO_VEN(const Value: Variant);
begin
  FCODIGO_VEN := Value;
end;

procedure TNFModel.Setcomplemento_cliente(const Value: Variant);
begin
  Fcomplemento_cliente := Value;
end;

procedure TNFModel.SetComplemento_transp(const Value: Variant);
begin
  FComplemento_transp := Value;
end;

procedure TNFModel.SetCONDICOES_PAGTO(const Value: Variant);
begin
  FCONDICOES_PAGTO := Value;
end;

procedure TNFModel.SetCONSIGNADO_ID(const Value: Variant);
begin
  FCONSIGNADO_ID := Value;
end;

procedure TNFModel.SetCONSIGNADO_STATUS(const Value: Variant);
begin
  FCONSIGNADO_STATUS := Value;
end;

procedure TNFModel.Setcontato_cliente(const Value: Variant);
begin
  Fcontato_cliente := Value;
end;

procedure TNFModel.SetContato_transp(const Value: Variant);
begin
  FContato_transp := Value;
end;

procedure TNFModel.SetCONV(const Value: Variant);
begin
  FCONV := Value;
end;

procedure TNFModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TNFModel.SetCTR_IMPRESSAO_NF(const Value: Variant);
begin
  FCTR_IMPRESSAO_NF := Value;
end;

procedure TNFModel.SetDATA_CANCELAMENTO(const Value: Variant);
begin
  FDATA_CANCELAMENTO := Value;
end;

procedure TNFModel.SetDATA_HORA_AUTORIZACAO(const Value: Variant);
begin
  FDATA_HORA_AUTORIZACAO := Value;
end;

procedure TNFModel.SetDATA_NF(const Value: Variant);
begin
  FDATA_NF := Value;
end;

procedure TNFModel.SetDATA_SAIDA(const Value: Variant);
begin
  FDATA_SAIDA := Value;
end;

procedure TNFModel.SetDESCONTO_NF(const Value: Variant);
begin
  FDESCONTO_NF := Value;
end;

procedure TNFModel.SetDESC_NF(const Value: Variant);
begin
  FDESC_NF := Value;
end;

procedure TNFModel.SetDESPESA_IMPORTACAO(const Value: Variant);
begin
  FDESPESA_IMPORTACAO := Value;
end;

procedure TNFModel.SetDEVOLUCAO_ID(const Value: Variant);
begin
  FDEVOLUCAO_ID := Value;
end;

procedure TNFModel.SetDR(const Value: Variant);
begin
  FDR := Value;
end;

procedure TNFModel.SetEMAIL_NFE(const Value: Variant);
begin
  FEMAIL_NFE := Value;
end;

procedure TNFModel.Setendereco_cliente(const Value: Variant);
begin
  Fendereco_cliente := Value;
end;

procedure TNFModel.SetEndereco_transp(const Value: Variant);
begin
  FEndereco_transp := Value;
end;

procedure TNFModel.SetENTRADA_ID(const Value: Variant);
begin
  FENTRADA_ID := Value;
end;

procedure TNFModel.SetENTREGA_BAIRRO(const Value: Variant);
begin
  FENTREGA_BAIRRO := Value;
end;

procedure TNFModel.SetENTREGA_CEP(const Value: Variant);
begin
  FENTREGA_CEP := Value;
end;

procedure TNFModel.SetENTREGA_CIDADE(const Value: Variant);
begin
  FENTREGA_CIDADE := Value;
end;

procedure TNFModel.SetENTREGA_COD_MUNICIPIO(const Value: Variant);
begin
  FENTREGA_COD_MUNICIPIO := Value;
end;

procedure TNFModel.SetENTREGA_COMPLEMENTO(const Value: Variant);
begin
  FENTREGA_COMPLEMENTO := Value;
end;

procedure TNFModel.SetENTREGA_ENDERECO(const Value: Variant);
begin
  FENTREGA_ENDERECO := Value;
end;

procedure TNFModel.SetENTREGA_NUMERO(const Value: Variant);
begin
  FENTREGA_NUMERO := Value;
end;

procedure TNFModel.SetENTREGA_UF(const Value: Variant);
begin
  FENTREGA_UF := Value;
end;

procedure TNFModel.SetESPECIE_VOLUME(const Value: Variant);
begin
  FESPECIE_VOLUME := Value;
end;

procedure TNFModel.Setestado_cliente(const Value: Variant);
begin
  Festado_cliente := Value;
end;

procedure TNFModel.SetEstado_transp(const Value: Variant);
begin
  FEstado_transp := Value;
end;

procedure TNFModel.SetFISCO_NF(const Value: Variant);
begin
  FFISCO_NF := Value;
end;

procedure TNFModel.SetFRETE(const Value: Variant);
begin
  FFRETE := Value;
end;

procedure TNFModel.SetGNRE(const Value: Variant);
begin
  FGNRE := Value;
end;

procedure TNFModel.SetGNRE_IMPRESSO(const Value: Variant);
begin
  FGNRE_IMPRESSO := Value;
end;

procedure TNFModel.SetHEM(const Value: Variant);
begin
  FHEM := Value;
end;

procedure TNFModel.SetHORA_NF(const Value: Variant);
begin
  FHORA_NF := Value;
end;

procedure TNFModel.SetHORA_SAIDA(const Value: Variant);
begin
  FHORA_SAIDA := Value;
end;

procedure TNFModel.SetICMS_NF(const Value: Variant);
begin
  FICMS_NF := Value;
end;

procedure TNFModel.SetICMS_ST(const Value: Variant);
begin
  FICMS_ST := Value;
end;

procedure TNFModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TNFModel.SetIDPedidoView(const Value: Integer);
begin
  FIDPedidoView := Value;
end;

procedure TNFModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TNFModel.SetID_INFO_COMPLEMENTAR(const Value: Variant);
begin
  FID_INFO_COMPLEMENTAR := Value;
end;

procedure TNFModel.SetID_NF3(const Value: Variant);
begin
  FID_NF3 := Value;
end;

procedure TNFModel.SetINDPRES(const Value: Variant);
begin
  FINDPRES := Value;
end;

procedure TNFModel.SetINFO_COMPLEMENTAR(const Value: Variant);
begin
  FINFO_COMPLEMENTAR := Value;
end;

procedure TNFModel.SetINTERMEDIADOR_CNPJ(const Value: Variant);
begin
  FINTERMEDIADOR_CNPJ := Value;
end;

procedure TNFModel.SetINTERMEDIADOR_NOME(const Value: Variant);
begin
  FINTERMEDIADOR_NOME := Value;
end;

procedure TNFModel.SetIPI_NF(const Value: Variant);
begin
  FIPI_NF := Value;
end;

procedure TNFModel.SetISENTA_NF(const Value: Variant);
begin
  FISENTA_NF := Value;
end;

procedure TNFModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TNFModel.SetLOCAL_EMBARQUE(const Value: Variant);
begin
  FLOCAL_EMBARQUE := Value;
end;

procedure TNFModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TNFModel.SetLOJA_ORIGEM(const Value: Variant);
begin
  FLOJA_ORIGEM := Value;
end;

procedure TNFModel.SetMODELO(const Value: Variant);
begin
  FMODELO := Value;
end;

procedure TNFModel.SetNFE(const Value: Variant);
begin
  FNFE := Value;
end;

procedure TNFModel.SetNFLista;
begin
  FNFLista := Value;
end;

procedure TNFModel.SetNome_usuario(const Value: Variant);
begin
  FNome_usuario := Value;
end;

procedure TNFModel.SetNOME_XML(const Value: Variant);
begin
  FNOME_XML := Value;
end;

procedure TNFModel.SetNumeroNFView(const Value: String);
begin
  FNumeroNFView := Value;
end;

procedure TNFModel.Setnumero_cliente(const Value: Variant);
begin
  Fnumero_cliente := Value;
end;

procedure TNFModel.SetNUMERO_ECF(const Value: Variant);
begin
  FNUMERO_ECF := Value;
end;

procedure TNFModel.SetNUMERO_NF(const Value: Variant);
begin
  FNUMERO_NF := Value;
end;

procedure TNFModel.SetNUMERO_PED(const Value: Variant);
begin
  FNUMERO_PED := Value;
end;

procedure TNFModel.SetNUMERO_PROCESSO(const Value: Variant);
begin
  FNUMERO_PROCESSO := Value;
end;

procedure TNFModel.SetNUMERO_SERIE_ECF(const Value: Variant);
begin
  FNUMERO_SERIE_ECF := Value;
end;

procedure TNFModel.SetN_SERIE_SAT(const Value: Variant);
begin
  FN_SERIE_SAT := Value;
end;

procedure TNFModel.SetOBS_FISCAL(const Value: Variant);
begin
  FOBS_FISCAL := Value;
end;

procedure TNFModel.SetOBS_NF(const Value: Variant);
begin
  FOBS_NF := Value;
end;

procedure TNFModel.SetORCAMENTO_ID(const Value: Variant);
begin
  FORCAMENTO_ID := Value;
end;

procedure TNFModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TNFModel.SetOS_ID(const Value: Variant);
begin
  FOS_ID := Value;
end;

procedure TNFModel.SetOUTROS_NF(const Value: Variant);
begin
  FOUTROS_NF := Value;
end;

procedure TNFModel.SetPCTE(const Value: Variant);
begin
  FPCTE := Value;
end;

procedure TNFModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TNFModel.SetPESO_BRUTO(const Value: Variant);
begin
  FPESO_BRUTO := Value;
end;

procedure TNFModel.SetPESO_BRUTO_NEW(const Value: Variant);
begin
  FPESO_BRUTO_NEW := Value;
end;

procedure TNFModel.SetPESO_LIQUIDO(const Value: Variant);
begin
  FPESO_LIQUIDO := Value;
end;

procedure TNFModel.SetPESO_LIQUIDO_NEW(const Value: Variant);
begin
  FPESO_LIQUIDO_NEW := Value;
end;

procedure TNFModel.SetPROTOCOLO_NFE(const Value: Variant);
begin
  FPROTOCOLO_NFE := Value;
end;

procedure TNFModel.SetQTDE_VOLUME(const Value: Variant);
begin
  FQTDE_VOLUME := Value;
end;

procedure TNFModel.SetQTPARCELAS(const Value: Variant);
begin
  FQTPARCELAS := Value;
end;

procedure TNFModel.SetQUANTIDADE_ITENS(const Value: Variant);
begin
  FQUANTIDADE_ITENS := Value;
end;

procedure TNFModel.SetQUANTIDADE_PRODUTOS(const Value: Variant);
begin
  FQUANTIDADE_PRODUTOS := Value;
end;

procedure TNFModel.Setrazao_social_cliente(const Value: Variant);
begin
  Frazao_social_cliente := Value;
end;

procedure TNFModel.SetRECIBO_NFE(const Value: Variant);
begin
  FRECIBO_NFE := Value;
end;

procedure TNFModel.SetREF_AAMM(const Value: Variant);
begin
  FREF_AAMM := Value;
end;

procedure TNFModel.SetREF_CNPJ(const Value: Variant);
begin
  FREF_CNPJ := Value;
end;

procedure TNFModel.SetREF_CUF(const Value: Variant);
begin
  FREF_CUF := Value;
end;

procedure TNFModel.SetREF_MOD(const Value: Variant);
begin
  FREF_MOD := Value;
end;

procedure TNFModel.SetREF_NNF(const Value: Variant);
begin
  FREF_NNF := Value;
end;

procedure TNFModel.SetREF_SERIE(const Value: Variant);
begin
  FREF_SERIE := Value;
end;

procedure TNFModel.SetSAIDAS_ID(const Value: Variant);
begin
  FSAIDAS_ID := Value;
end;

procedure TNFModel.SetSERIE_NF(const Value: Variant);
begin
  FSERIE_NF := Value;
end;

procedure TNFModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TNFModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TNFModel.SetSTATUS_NF(const Value: Variant);
begin
  FSTATUS_NF := Value;
end;

procedure TNFModel.SetSTATUS_PENDENTE(const Value: Variant);
begin
  FSTATUS_PENDENTE := Value;
end;

procedure TNFModel.SetSTATUS_TRANSMISSAO(const Value: Variant);
begin
  FSTATUS_TRANSMISSAO := Value;
end;

procedure TNFModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TNFModel.Settelefone_cliente(const Value: Variant);
begin
  Ftelefone_cliente := Value;
end;

procedure TNFModel.SetTIPO_FRETE(const Value: Variant);
begin
  FTIPO_FRETE := Value;
end;

procedure TNFModel.SetTIPO_NF(const Value: Variant);
begin
  FTIPO_NF := Value;
end;

procedure TNFModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TNFModel.SetTOTAL_BASE_COFINS(const Value: Variant);
begin
  FTOTAL_BASE_COFINS := Value;
end;

procedure TNFModel.SetTOTAL_BASE_ICMS(const Value: Variant);
begin
  FTOTAL_BASE_ICMS := Value;
end;

procedure TNFModel.SetTOTAL_BASE_ICMS_ST(const Value: Variant);
begin
  FTOTAL_BASE_ICMS_ST := Value;
end;

procedure TNFModel.SetTOTAL_BASE_IPI(const Value: Variant);
begin
  FTOTAL_BASE_IPI := Value;
end;

procedure TNFModel.SetTOTAL_BASE_PIS(const Value: Variant);
begin
  FTOTAL_BASE_PIS := Value;
end;

procedure TNFModel.SetTOTAL_COFINS(const Value: Variant);
begin
  FTOTAL_COFINS := Value;
end;

procedure TNFModel.SetTOTAL_DESCONTO(const Value: Variant);
begin
  FTOTAL_DESCONTO := Value;
end;

procedure TNFModel.SetTOTAL_DESCONTO_PERCENTUAL(const Value: Variant);
begin
  FTOTAL_DESCONTO_PERCENTUAL := Value;
end;

procedure TNFModel.SetTOTAL_FCP(const Value: Variant);
begin
  FTOTAL_FCP := Value;
end;

procedure TNFModel.SetTOTAL_FCP_ST(const Value: Variant);
begin
  FTOTAL_FCP_ST := Value;
end;

procedure TNFModel.SetTOTAL_FRETE(const Value: Variant);
begin
  FTOTAL_FRETE := Value;
end;

procedure TNFModel.SetTOTAL_ICMS(const Value: Variant);
begin
  FTOTAL_ICMS := Value;
end;

procedure TNFModel.SetTOTAL_ICMS_DESON(const Value: Variant);
begin
  FTOTAL_ICMS_DESON := Value;
end;

procedure TNFModel.SetTOTAL_ICMS_ST(const Value: Variant);
begin
  FTOTAL_ICMS_ST := Value;
end;

procedure TNFModel.SetTOTAL_IPI(const Value: Variant);
begin
  FTOTAL_IPI := Value;
end;

procedure TNFModel.SetTOTAL_NF(const Value: Variant);
begin
  FTOTAL_NF := Value;
end;

procedure TNFModel.SetTOTAL_OUTROS(const Value: Variant);
begin
  FTOTAL_OUTROS := Value;
end;

procedure TNFModel.SetTOTAL_PIS(const Value: Variant);
begin
  FTOTAL_PIS := Value;
end;

procedure TNFModel.SetTOTAL_PRODUTOS(const Value: Variant);
begin
  FTOTAL_PRODUTOS := Value;
end;

procedure TNFModel.SetTOTAL_TOTALNF(const Value: Variant);
begin
  FTOTAL_TOTALNF := Value;
end;

procedure TNFModel.SetTRANSFERENCIA_ID(const Value: Variant);
begin
  FTRANSFERENCIA_ID := Value;
end;

procedure TNFModel.SetTRANSPORTADORA(const Value: Variant);
begin
  FTRANSPORTADORA := Value;
end;

procedure TNFModel.SetTRANSPORTADORA_ID(const Value: Variant);
begin
  FTRANSPORTADORA_ID := Value;
end;

procedure TNFModel.Settransportadora_nome_transp(const Value: Variant);
begin
  Ftransportadora_nome_transp := Value;
end;

procedure TNFModel.SetTRANSPORTADORA_REDESPACHO_ID(const Value: Variant);
begin
  FTRANSPORTADORA_REDESPACHO_ID := Value;
end;

procedure TNFModel.SetTRA_MARCA(const Value: Variant);
begin
  FTRA_MARCA := Value;
end;

procedure TNFModel.SetTRA_NUMERACAO(const Value: Variant);
begin
  FTRA_NUMERACAO := Value;
end;

procedure TNFModel.SetTRA_PLACA(const Value: Variant);
begin
  FTRA_PLACA := Value;
end;

procedure TNFModel.SetTRA_RNTC(const Value: Variant);
begin
  FTRA_RNTC := Value;
end;

procedure TNFModel.SetTRA_UF(const Value: Variant);
begin
  FTRA_UF := Value;
end;

procedure TNFModel.SetUF_EMBARQUE(const Value: Variant);
begin
  FUF_EMBARQUE := Value;
end;

procedure TNFModel.SetUSUARIO_NF(const Value: Variant);
begin
  FUSUARIO_NF := Value;
end;

procedure TNFModel.SetVALOR_EXTENSO(const Value: Variant);
begin
  FVALOR_EXTENSO := Value;
end;

procedure TNFModel.SetVALOR_NF(const Value: Variant);
begin
  FVALOR_NF := Value;
end;

procedure TNFModel.SetVALOR_PAGO(const Value: Variant);
begin
  FVALOR_PAGO := Value;
end;

procedure TNFModel.SetVALOR_SUFRAMA(const Value: Variant);
begin
  FVALOR_SUFRAMA := Value;
end;

procedure TNFModel.SetVCOFINS(const Value: Variant);
begin
  FVCOFINS := Value;
end;

procedure TNFModel.SetVCREDICMSSN(const Value: Variant);
begin
  FVCREDICMSSN := Value;
end;

procedure TNFModel.SetVDOLAR(const Value: Variant);
begin
  FVDOLAR := Value;
end;

procedure TNFModel.SetVEND(const Value: Variant);
begin
  FVEND := Value;
end;

procedure TNFModel.SetVendedor_Nome(const Value: Variant);
begin
  FVendedor_Nome := Value;
end;

procedure TNFModel.SetVFCP(const Value: Variant);
begin
  FVFCP := Value;
end;

procedure TNFModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TNFModel.SetVFCPSTRET(const Value: Variant);
begin
  FVFCPSTRET := Value;
end;

procedure TNFModel.SetVFCPUFDEST(const Value: Variant);
begin
  FVFCPUFDEST := Value;
end;

procedure TNFModel.SetVICMSDESON(const Value: Variant);
begin
  FVICMSDESON := Value;
end;

procedure TNFModel.SetVICMSSTRET(const Value: Variant);
begin
  FVICMSSTRET := Value;
end;

procedure TNFModel.SetVICMSUFDEST(const Value: Variant);
begin
  FVICMSUFDEST := Value;
end;

procedure TNFModel.SetVICMSUFREMET(const Value: Variant);
begin
  FVICMSUFREMET := Value;
end;

procedure TNFModel.SetVICMS_NF(const Value: Variant);
begin
  FVICMS_NF := Value;
end;

procedure TNFModel.SetVII(const Value: Variant);
begin
  FVII := Value;
end;

procedure TNFModel.SetVIPIDEVOL(const Value: Variant);
begin
  FVIPIDEVOL := Value;
end;

procedure TNFModel.SetVLRENTRADA_NF(const Value: Variant);
begin
  FVLRENTRADA_NF := Value;
end;

procedure TNFModel.SetVPIS(const Value: Variant);
begin
  FVPIS := Value;
end;

procedure TNFModel.SetVSEG(const Value: Variant);
begin
  FVSEG := Value;
end;

procedure TNFModel.SetVTOTTRIB(const Value: Variant);
begin
  FVTOTTRIB := Value;
end;

procedure TNFModel.SetVTOTTRIB_ESTADUAL(const Value: Variant);
begin
  FVTOTTRIB_ESTADUAL := Value;
end;

procedure TNFModel.SetVTOTTRIB_FEDERAL(const Value: Variant);
begin
  FVTOTTRIB_FEDERAL := Value;
end;

procedure TNFModel.SetVTOTTRIB_MUNICIPAL(const Value: Variant);
begin
  FVTOTTRIB_MUNICIPAL := Value;
end;

procedure TNFModel.SetWEB_PEDIDO_ID(const Value: Variant);
begin
  FWEB_PEDIDO_ID := Value;
end;

procedure TNFModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TNFModel.SetXML_NFE(const Value: Variant);
begin
  FXML_NFE := Value;
end;

procedure TNFModel.SetXPED(const Value: Variant);
begin
  FXPED := Value;
end;

end.
