unit ProdutosModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  Interfaces.Conexao,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TProdutosModel=class;
  ITProdutosModel=IObject<TProdutosModel>;


  TProdutoPreco = record
    Produto,
    Cliente,
    Portador,
    PrecoVenda,
    Loja                : String;
    Qtde                : Double;
    PrecoUf,
    Promocao,
    PrecoCliente,
    TabelaPreco         : Boolean;
  end;

  TProdutoGarantia = record
    GARANTIA_EXTENDIDA_VENDA_12,
    GARANTIA_EXTENDIDA_CUSTO_12,
    GARANTIA_EXTENDIDA_VENDA_24,
    GARANTIA_EXTENDIDA_CUSTO_24,
    GARANTIA_EXTENDIDA_VENDA_36,
    GARANTIA_EXTENDIDA_CUSTO_36,
    ROUBO_FURTO_12,
    ROUBO_FURTO_24,
    ROUBO_FURTO_CUSTO_12,
    ROUBO_FURTO_CUSTO_24,
    ROUBO_FURTO_DA_12,
    ROUBO_FURTO_DA_24,
    ROUBO_FURTO_CUSTO_DA_12,
    ROUBO_FURTO_CUSTO_DA_24 : Double;
  end;

  TProdutosModel = class
  private
    [weak] mySelf: ITProdutosModel;
    vIConexao : IConexao;
    FProdutossLista: IList<ITProdutosModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVENDA_COM_DESCONTO: Variant;
    FNFCE_ICMS: Variant;
    FDESTAQUE: Variant;
    FUSAR_BALANCA: Variant;
    FSALDO_PRO: Variant;
    FCODIGO_GRU: Variant;
    FLW: Variant;
    FCALCULO_MARGEM: Variant;
    FMARGEM_LUCRO: Variant;
    FROSQUEADEIRA: Variant;
    FMARCA_PRO: Variant;
    FVPMC: Variant;
    FPRODUTO_MODELO: Variant;
    FDATA_ALTERACAO_VENDA_PRO: Variant;
    FWEB_INTEGRA: Variant;
    FVALIDAR_LOTE: Variant;
    FANO_FABRICACAO: Variant;
    FCLIENTE_CONSERVADORA: Variant;
    FETIQUETA_PESO_BRUTO: Variant;
    FMULTIPLICADOR: Variant;
    FMULTIPLOS: Variant;
    FQUANT_BARRA_USADAS: Variant;
    FTABELA_VENDA: Variant;
    FWEB_VARIACAO: Variant;
    FCUSTO_FINANCEIRO: Variant;
    FCONTROLE_INVENTARIO: Variant;
    FNOME_RESUMIDO: Variant;
    FTIPO_ITEM: Variant;
    FWEB_PALAVRA_CHAVE: Variant;
    FCONSERVADORA: Variant;
    FIMPRESSAO_COZINHA: Variant;
    FETIQUETA_SIGLA: Variant;
    FALIQ_CREDITO_PIS: Variant;
    FMATERIAL: Variant;
    FFRETE_PRO: Variant;
    FUSUARIO_PRO: Variant;
    FNOME_PRO: Variant;
    FTIPO_PRO: Variant;
    FDESCRICAO_ANP: Variant;
    FRECEITA: Variant;
    FIPI_CENQ: Variant;
    FWEB_TAMANHO: Variant;
    FDIFERENCA_CORTE: Variant;
    FBONUS: Variant;
    FIMPRESSAO_BALCAO: Variant;
    FALIQ_CREDITO_COFINS: Variant;
    FPORCENTAGEM_NFE: Variant;
    FCST_PIS: Variant;
    FVALORDOLAR_PRO: Variant;
    FVALOR_ICMS_SUBSTITUTO: Variant;
    FALTURA_M: Variant;
    FCODIGO_ANP: Variant;
    FUSAR_CONTROLE_KG: Variant;
    FOH: Variant;
    FOBS_NF: Variant;
    FCST_COFINS: Variant;
    FPRODUTO_REFERENTE: Variant;
    FIPI_PRO: Variant;
    FCODIGO_FOR: Variant;
    FLISTAR_PRODUCAO: Variant;
    FDATA_MEDIA_SUGESTAO: Variant;
    FEQUIPAMENTO_ID: Variant;
    FPROPRIEDADE: Variant;
    FWEB_PROFUNDIDADE: Variant;
    FWEB_PRECO_VENDA: Variant;
    FEAN_14: Variant;
    FVALIDADE_PRO: Variant;
    FLISTA: Variant;
    FCODIGO_MAR: Variant;
    FGRUPO_COMISSAO_ID: Variant;
    FCONVERSAO_FRACIONADA: Variant;
    FVALOR_VENDA_MINIMO: Variant;
    FCNPJ_PRODUTO_NFE: Variant;
    FCLAS_FISCAL_PRO: Variant;
    FGARANTIA_12: Variant;
    FPRAZO_MEDIO: Variant;
    FMARGEM_PRAZO: Variant;
    FWEB_COR: Variant;
    FPERCENTUAL_ST_RECOLHIDO: Variant;
    FUSAR_PARTES: Variant;
    FWEB_DESCONTO: Variant;
    FDESCRICAO_TECNICA: Variant;
    FWEB_PESO: Variant;
    FWEB_NOME_PRO: Variant;
    FNFCE_CFOP: Variant;
    FVENDA_WEB: Variant;
    FFURADEIRA: Variant;
    FVENDAMINIMA_PRO: Variant;
    FENTREGA: Variant;
    FETIQUETA_NOME: Variant;
    FARREDONDAMENTO: Variant;
    FPESO_LIQUIDO: Variant;
    FQUANT_PECA_HORA: Variant;
    FECF_PRO: Variant;
    FBARRAS_PRO: Variant;
    FDATA_ALTERACAO_CUSTOULTIMO_PRO: Variant;
    FSUBLIMACAO: Variant;
    FWEB_RESUMO: Variant;
    FLINK: Variant;
    FDESCRICAO: Variant;
    FPRODUTO_FILHO: Variant;
    FCODIGO_ANTERIOR: Variant;
    FGARANTIA_24: Variant;
    FLARGURA_M: Variant;
    FSALDO_ONLINE: Variant;
    FCONTROLEALTERACAO: Variant;
    FCEST: Variant;
    FVOLTAGEM: Variant;
    FCODIGO_FORNECEDOR2: Variant;
    FDESCONTO_PRO: Variant;
    FQTDEDIAS_PRO: Variant;
    FGARANTIA_PRO: Variant;
    FPESO_PRO: Variant;
    FVENDA_PRO: Variant;
    FSALDOMIN_PRO: Variant;
    FUUID: Variant;
    FVALOR_TERCERIZADOS: Variant;
    FCODIGO_FORNECEDOR3: Variant;
    FQUANT_PECA_BARRA: Variant;
    FCODLISTA_COD: Variant;
    FWEB_CATEGORIAS: Variant;
    FWEB_CARACTERISTICA: Variant;
    FCUSTO_MEDIDA: Variant;
    FMETROSBARRAS_PRO: Variant;
    FQTDE_PRODUZIR: Variant;
    FFAMILIA: Variant;
    FETIQUETA_LINHA_2: Variant;
    FMODELO: Variant;
    FCONTA_CONTABIL: Variant;
    FCST_IPI: Variant;
    FCFOP_ESTADUAL_ID: Variant;
    FCUSTOMEDIO_PRO: Variant;
    FUNIDADE_ENTRADA: Variant;
    FMARGEM_PROMOCAO: Variant;
    FID: Variant;
    FPMC_PRO: Variant;
    FMARGEM_PRO: Variant;
    FWEB_GERENCIA_PRECO_VENDA: Variant;
    FIMAGEM_TECNICA: Variant;
    FWEB_ALTURA: Variant;
    FETIQUETA_NOME_CIENTIFICO: Variant;
    FPRODUTO_NFE: Variant;
    FICMS_PRO: Variant;
    FPRODUTO_ORIGEM: Variant;
    FETIQUETA_LINHA_1: Variant;
    FPOS_VENDA_DIAS: Variant;
    FHORA_MAQUINA: Variant;
    FLOCALIZACAO: Variant;
    FPERCENTUAL_PERDA_MATERIA_PRIMA: Variant;
    FCONVERSAO_FRACIONADA_FILHO: Variant;
    FIMAGEM: Variant;
    FLOJA: Variant;
    FCATEGORIA_ID: Variant;
    FCENQ: Variant;
    FLISTAR_ROMANEIO: Variant;
    FARTIGO_ID: Variant;
    FCUSTO_MANUAL: Variant;
    FSUGESTAO_COMPRA: Variant;
    FTIPO_CONSERVADORA: Variant;
    FPRECO_FABRICANTE: Variant;
    FPRODUTO_FINAL: Variant;
    FCUSTOULTIMO_PRO: Variant;
    FCODIGO_PRO: Variant;
    FMONTAGEM: Variant;
    FWEB_ID: Variant;
    FMEDIA_SUGESTAO: Variant;
    FFORNECEDOR_CODIGO: Variant;
    FGALVANIZACAO: Variant;
    FCOMIS_PRO: Variant;
    FCODIGO_FORNECEDOR: Variant;
    FCPRODANVISA: Variant;
    FWEB_CODIGO_INTEGRACAO_MASTER: Variant;
    FVALOR_MONTADOR: Variant;
    FWEB_TIPO_PRODUTO: Variant;
    FFCI: Variant;
    FPRECO_DOLAR: Variant;
    FNFCE_CST: Variant;
    FSYSTIME: Variant;
    FIPI_SAI: Variant;
    FCFOP_INTERESTADUAL_ID: Variant;
    FCST_CREDITO_PIS: Variant;
    FWEB_GERENCIA_IMAGENS: Variant;
    FWEB_LARGURA: Variant;
    FDIVIZOR: Variant;
    FCST_CREDITO_COFINS: Variant;
    FWEB_CODIGO_INTEGRACAO: Variant;
    FVALOR_BONUS_SERVICO: Variant;
    FQTRIB: Variant;
    FEMBALAGEM_ID: Variant;
    FWEB_PRECO_PROMOCAO: Variant;
    FETIQUETA_PESO_LIQUIDO: Variant;
    FNFCE_CSOSN: Variant;
    FOBS_GERAL: Variant;
    FQUTDE_MAXIMA: Variant;
    FCUSTOULTIMO_IMPORTACAO: Variant;
    FETIQUETA_PORCAO: Variant;
    FVALOR_MP: Variant;
    FSALDO: Variant;
    FVENDAPRAZO_PRO: Variant;
    FEXTIPI: Variant;
    FPRODUTO_PAI: Variant;
    FINDESCALA: Variant;
    FCBENEF: Variant;
    FCOTACAO_TIPO: Variant;
    FTW: Variant;
    FUSAR_INSC_ST: Variant;
    FTEMPERA: Variant;
    FPEDIDO_MENSAL: Variant;
    FCUSTOLIQUIDO_PRO: Variant;
    FXMOTIVOISENCAO: Variant;
    FWEB_URL_IMAGENS: Variant;
    FSTATUS_PRO: Variant;
    FPRINCIPIO_ATIVO: Variant;
    FCOMISSAO_PRO: Variant;
    FIMAGEM_PRO: Variant;
    FAPLICACAO_PRO: Variant;
    FDATA_CONSUMO_OMINIONE: Variant;
    FCLIENTE_TSB: Variant;
    FUTRIB: Variant;
    FPROFUNDIDADE_M: Variant;
    FSTATUS_LINHA: Variant;
    FREFERENCIA_NEW: Variant;
    FFRETE: Variant;
    FFREZADORA: Variant;
    FALIQUOTA_PIS: Variant;
    FPESQUISA: Variant;
    FUUIDALTERACAO: Variant;
    FORDEM: Variant;
    FVOLUME_QTDE: Variant;
    FTIPO_VENDA_COMISSAO_ID: Variant;
    FWEB_GERENCIA_ESTOQUE: Variant;
    FCONTROLE_SERIAL: Variant;
    FALIQUOTA_COFINS: Variant;
    FCODIGO_SUB: Variant;
    FVENDAWEB_PRO: Variant;
    FNFE_INTEIRO: Variant;
    FCOMBO: Variant;
    FVALOR_VENDA_MAXIMO: Variant;
    FVALIDAR_CAIXA: Variant;
    FULTIMAVENDA_PRO: Variant;
    FDATADOLAR_PRO: Variant;
    FUNIDADE_PRO: Variant;
    FCUSTOBASE_PRO: Variant;
    FM3: Variant;
    FBASE_ST_RECOLHIDO: Variant;
    FTH: Variant;
    FFICHA_TECNICA: Variant;
    FPART_NUMBER: Variant;
    FVALIDADE: Variant;
    FSERRA: Variant;
    FTABICMS_PRO: Variant;
    FNOVIDADE_PRO: Variant;
    FCUSTODOLAR_PRO: Variant;
    FCNPJFAB: Variant;
    FWEB_URL: Variant;
    FTIPO_ID: Variant;
    FDESMEMBRAR_KIT: Variant;
    FTORNO: Variant;
    FULTIMA_ALTERACAO_PRO: Variant;
    FCSOSN: Variant;
    FVENDAPROMOCAO_PRO: Variant;
    FIDRecordView: String;
    FSALDO_CD: Variant;
    FSALDO_DISPONIVEL: Variant;
    FGRADE_ID: Variant;
    FMARGEM_CALCULADA: Variant;
    FTIPO_NOME: Variant;
    FNOME_SUB: Variant;
    FNOME_GRU: Variant;
    FNOME_MAR: Variant;
    FCodProdutoView: String;
    FNOME_FOR: Variant;
    FCOR_ID: Variant;
    FVOLTAGEM_ID: Variant;
    FTIPO__PRO: Variant;
    FPERMITE_VENDA_SEGURO_FR: Variant;
    FGRUPO_GARANTIA_ID: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetProdutossLista(const Value: IList<ITProdutosModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetALIQ_CREDITO_COFINS(const Value: Variant);
    procedure SetALIQ_CREDITO_PIS(const Value: Variant);
    procedure SetALIQUOTA_COFINS(const Value: Variant);
    procedure SetALIQUOTA_PIS(const Value: Variant);
    procedure SetALTURA_M(const Value: Variant);
    procedure SetANO_FABRICACAO(const Value: Variant);
    procedure SetAPLICACAO_PRO(const Value: Variant);
    procedure SetARREDONDAMENTO(const Value: Variant);
    procedure SetARTIGO_ID(const Value: Variant);
    procedure SetBARRAS_PRO(const Value: Variant);
    procedure SetBASE_ST_RECOLHIDO(const Value: Variant);
    procedure SetBONUS(const Value: Variant);
    procedure SetCALCULO_MARGEM(const Value: Variant);
    procedure SetCATEGORIA_ID(const Value: Variant);
    procedure SetCBENEF(const Value: Variant);
    procedure SetCENQ(const Value: Variant);
    procedure SetCEST(const Value: Variant);
    procedure SetCFOP_ESTADUAL_ID(const Value: Variant);
    procedure SetCFOP_INTERESTADUAL_ID(const Value: Variant);
    procedure SetCLAS_FISCAL_PRO(const Value: Variant);
    procedure SetCLIENTE_CONSERVADORA(const Value: Variant);
    procedure SetCLIENTE_TSB(const Value: Variant);
    procedure SetCNPJ_PRODUTO_NFE(const Value: Variant);
    procedure SetCNPJFAB(const Value: Variant);
    procedure SetCODIGO_ANP(const Value: Variant);
    procedure SetCODIGO_ANTERIOR(const Value: Variant);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCODIGO_FORNECEDOR(const Value: Variant);
    procedure SetCODIGO_FORNECEDOR2(const Value: Variant);
    procedure SetCODIGO_FORNECEDOR3(const Value: Variant);
    procedure SetCODIGO_GRU(const Value: Variant);
    procedure SetCODIGO_MAR(const Value: Variant);
    procedure SetCODIGO_PRO(const Value: Variant);
    procedure SetCODIGO_SUB(const Value: Variant);
    procedure SetCODLISTA_COD(const Value: Variant);
    procedure SetCOMBO(const Value: Variant);
    procedure SetCOMIS_PRO(const Value: Variant);
    procedure SetCOMISSAO_PRO(const Value: Variant);
    procedure SetCONSERVADORA(const Value: Variant);
    procedure SetCONTA_CONTABIL(const Value: Variant);
    procedure SetCONTROLE_INVENTARIO(const Value: Variant);
    procedure SetCONTROLE_SERIAL(const Value: Variant);
    procedure SetCONTROLEALTERACAO(const Value: Variant);
    procedure SetCONVERSAO_FRACIONADA(const Value: Variant);
    procedure SetCONVERSAO_FRACIONADA_FILHO(const Value: Variant);
    procedure SetCOTACAO_TIPO(const Value: Variant);
    procedure SetCPRODANVISA(const Value: Variant);
    procedure SetCSOSN(const Value: Variant);
    procedure SetCST_COFINS(const Value: Variant);
    procedure SetCST_CREDITO_COFINS(const Value: Variant);
    procedure SetCST_CREDITO_PIS(const Value: Variant);
    procedure SetCST_IPI(const Value: Variant);
    procedure SetCST_PIS(const Value: Variant);
    procedure SetCUSTO_FINANCEIRO(const Value: Variant);
    procedure SetCUSTO_MANUAL(const Value: Variant);
    procedure SetCUSTO_MEDIDA(const Value: Variant);
    procedure SetCUSTOBASE_PRO(const Value: Variant);
    procedure SetCUSTODOLAR_PRO(const Value: Variant);
    procedure SetCUSTOLIQUIDO_PRO(const Value: Variant);
    procedure SetCUSTOMEDIO_PRO(const Value: Variant);
    procedure SetCUSTOULTIMO_IMPORTACAO(const Value: Variant);
    procedure SetCUSTOULTIMO_PRO(const Value: Variant);
    procedure SetDATA_ALTERACAO_CUSTOULTIMO_PRO(const Value: Variant);
    procedure SetDATA_ALTERACAO_VENDA_PRO(const Value: Variant);
    procedure SetDATA_CONSUMO_OMINIONE(const Value: Variant);
    procedure SetDATA_MEDIA_SUGESTAO(const Value: Variant);
    procedure SetDATADOLAR_PRO(const Value: Variant);
    procedure SetDESCONTO_PRO(const Value: Variant);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetDESCRICAO_ANP(const Value: Variant);
    procedure SetDESCRICAO_TECNICA(const Value: Variant);
    procedure SetDESMEMBRAR_KIT(const Value: Variant);
    procedure SetDESTAQUE(const Value: Variant);
    procedure SetDIFERENCA_CORTE(const Value: Variant);
    procedure SetDIVIZOR(const Value: Variant);
    procedure SetEAN_14(const Value: Variant);
    procedure SetECF_PRO(const Value: Variant);
    procedure SetEMBALAGEM_ID(const Value: Variant);
    procedure SetENTREGA(const Value: Variant);
    procedure SetEQUIPAMENTO_ID(const Value: Variant);
    procedure SetETIQUETA_LINHA_1(const Value: Variant);
    procedure SetETIQUETA_LINHA_2(const Value: Variant);
    procedure SetETIQUETA_NOME(const Value: Variant);
    procedure SetETIQUETA_NOME_CIENTIFICO(const Value: Variant);
    procedure SetETIQUETA_PESO_BRUTO(const Value: Variant);
    procedure SetETIQUETA_PESO_LIQUIDO(const Value: Variant);
    procedure SetETIQUETA_PORCAO(const Value: Variant);
    procedure SetETIQUETA_SIGLA(const Value: Variant);
    procedure SetEXTIPI(const Value: Variant);
    procedure SetFAMILIA(const Value: Variant);
    procedure SetFCI(const Value: Variant);
    procedure SetFICHA_TECNICA(const Value: Variant);
    procedure SetFORNECEDOR_CODIGO(const Value: Variant);
    procedure SetFRETE(const Value: Variant);
    procedure SetFRETE_PRO(const Value: Variant);
    procedure SetFREZADORA(const Value: Variant);
    procedure SetFURADEIRA(const Value: Variant);
    procedure SetGALVANIZACAO(const Value: Variant);
    procedure SetGARANTIA_12(const Value: Variant);
    procedure SetGARANTIA_24(const Value: Variant);
    procedure SetGARANTIA_PRO(const Value: Variant);
    procedure SetGRUPO_COMISSAO_ID(const Value: Variant);
    procedure SetHORA_MAQUINA(const Value: Variant);
    procedure SetICMS_PRO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIMAGEM(const Value: Variant);
    procedure SetIMAGEM_PRO(const Value: Variant);
    procedure SetIMAGEM_TECNICA(const Value: Variant);
    procedure SetIMPRESSAO_BALCAO(const Value: Variant);
    procedure SetIMPRESSAO_COZINHA(const Value: Variant);
    procedure SetINDESCALA(const Value: Variant);
    procedure SetIPI_CENQ(const Value: Variant);
    procedure SetIPI_PRO(const Value: Variant);
    procedure SetIPI_SAI(const Value: Variant);
    procedure SetLARGURA_M(const Value: Variant);
    procedure SetLINK(const Value: Variant);
    procedure SetLISTA(const Value: Variant);
    procedure SetLISTAR_PRODUCAO(const Value: Variant);
    procedure SetLISTAR_ROMANEIO(const Value: Variant);
    procedure SetLOCALIZACAO(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLW(const Value: Variant);
    procedure SetM3(const Value: Variant);
    procedure SetMARCA_PRO(const Value: Variant);
    procedure SetMARGEM_LUCRO(const Value: Variant);
    procedure SetMARGEM_PRAZO(const Value: Variant);
    procedure SetMARGEM_PRO(const Value: Variant);
    procedure SetMARGEM_PROMOCAO(const Value: Variant);
    procedure SetMATERIAL(const Value: Variant);
    procedure SetMEDIA_SUGESTAO(const Value: Variant);
    procedure SetMETROSBARRAS_PRO(const Value: Variant);
    procedure SetMODELO(const Value: Variant);
    procedure SetMONTAGEM(const Value: Variant);
    procedure SetMULTIPLICADOR(const Value: Variant);
    procedure SetMULTIPLOS(const Value: Variant);
    procedure SetNFCE_CFOP(const Value: Variant);
    procedure SetNFCE_CSOSN(const Value: Variant);
    procedure SetNFCE_CST(const Value: Variant);
    procedure SetNFCE_ICMS(const Value: Variant);
    procedure SetNFE_INTEIRO(const Value: Variant);
    procedure SetNOME_PRO(const Value: Variant);
    procedure SetNOME_RESUMIDO(const Value: Variant);
    procedure SetNOVIDADE_PRO(const Value: Variant);
    procedure SetOBS_GERAL(const Value: Variant);
    procedure SetOBS_NF(const Value: Variant);
    procedure SetOH(const Value: Variant);
    procedure SetORDEM(const Value: Variant);
    procedure SetPART_NUMBER(const Value: Variant);
    procedure SetPEDIDO_MENSAL(const Value: Variant);
    procedure SetPERCENTUAL_PERDA_MATERIA_PRIMA(const Value: Variant);
    procedure SetPERCENTUAL_ST_RECOLHIDO(const Value: Variant);
    procedure SetPESO_LIQUIDO(const Value: Variant);
    procedure SetPESO_PRO(const Value: Variant);
    procedure SetPESQUISA(const Value: Variant);
    procedure SetPMC_PRO(const Value: Variant);
    procedure SetPORCENTAGEM_NFE(const Value: Variant);
    procedure SetPOS_VENDA_DIAS(const Value: Variant);
    procedure SetPRAZO_MEDIO(const Value: Variant);
    procedure SetPRECO_DOLAR(const Value: Variant);
    procedure SetPRECO_FABRICANTE(const Value: Variant);
    procedure SetPRINCIPIO_ATIVO(const Value: Variant);
    procedure SetPRODUTO_FILHO(const Value: Variant);
    procedure SetPRODUTO_FINAL(const Value: Variant);
    procedure SetPRODUTO_MODELO(const Value: Variant);
    procedure SetPRODUTO_NFE(const Value: Variant);
    procedure SetPRODUTO_ORIGEM(const Value: Variant);
    procedure SetPRODUTO_PAI(const Value: Variant);
    procedure SetPRODUTO_REFERENTE(const Value: Variant);
    procedure SetPROFUNDIDADE_M(const Value: Variant);
    procedure SetPROPRIEDADE(const Value: Variant);
    procedure SetQTDE_PRODUZIR(const Value: Variant);
    procedure SetQTDEDIAS_PRO(const Value: Variant);
    procedure SetQTRIB(const Value: Variant);
    procedure SetQUANT_BARRA_USADAS(const Value: Variant);
    procedure SetQUANT_PECA_BARRA(const Value: Variant);
    procedure SetQUANT_PECA_HORA(const Value: Variant);
    procedure SetQUTDE_MAXIMA(const Value: Variant);
    procedure SetRECEITA(const Value: Variant);
    procedure SetREFERENCIA_NEW(const Value: Variant);
    procedure SetROSQUEADEIRA(const Value: Variant);
    procedure SetSALDO(const Value: Variant);
    procedure SetSALDO_ONLINE(const Value: Variant);
    procedure SetSALDO_PRO(const Value: Variant);
    procedure SetSALDOMIN_PRO(const Value: Variant);
    procedure SetSERRA(const Value: Variant);
    procedure SetSTATUS_LINHA(const Value: Variant);
    procedure SetSTATUS_PRO(const Value: Variant);
    procedure SetSUBLIMACAO(const Value: Variant);
    procedure SetSUGESTAO_COMPRA(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTABELA_VENDA(const Value: Variant);
    procedure SetTABICMS_PRO(const Value: Variant);
    procedure SetTEMPERA(const Value: Variant);
    procedure SetTH(const Value: Variant);
    procedure SetTIPO_CONSERVADORA(const Value: Variant);
    procedure SetTIPO_ID(const Value: Variant);
    procedure SetTIPO_ITEM(const Value: Variant);
    procedure SetTIPO_PRO(const Value: Variant);
    procedure SetTIPO_VENDA_COMISSAO_ID(const Value: Variant);
    procedure SetTORNO(const Value: Variant);
    procedure SetTW(const Value: Variant);
    procedure SetULTIMA_ALTERACAO_PRO(const Value: Variant);
    procedure SetULTIMAVENDA_PRO(const Value: Variant);
    procedure SetUNIDADE_ENTRADA(const Value: Variant);
    procedure SetUNIDADE_PRO(const Value: Variant);
    procedure SetUSAR_BALANCA(const Value: Variant);
    procedure SetUSAR_CONTROLE_KG(const Value: Variant);
    procedure SetUSAR_INSC_ST(const Value: Variant);
    procedure SetUSAR_PARTES(const Value: Variant);
    procedure SetUSUARIO_PRO(const Value: Variant);
    procedure SetUTRIB(const Value: Variant);
    procedure SetUUID(const Value: Variant);
    procedure SetUUIDALTERACAO(const Value: Variant);
    procedure SetVALIDADE(const Value: Variant);
    procedure SetVALIDADE_PRO(const Value: Variant);
    procedure SetVALIDAR_CAIXA(const Value: Variant);
    procedure SetVALIDAR_LOTE(const Value: Variant);
    procedure SetVALOR_BONUS_SERVICO(const Value: Variant);
    procedure SetVALOR_ICMS_SUBSTITUTO(const Value: Variant);
    procedure SetVALOR_MONTADOR(const Value: Variant);
    procedure SetVALOR_MP(const Value: Variant);
    procedure SetVALOR_TERCERIZADOS(const Value: Variant);
    procedure SetVALOR_VENDA_MAXIMO(const Value: Variant);
    procedure SetVALOR_VENDA_MINIMO(const Value: Variant);
    procedure SetVALORDOLAR_PRO(const Value: Variant);
    procedure SetVENDA_COM_DESCONTO(const Value: Variant);
    procedure SetVENDA_PRO(const Value: Variant);
    procedure SetVENDA_WEB(const Value: Variant);
    procedure SetVENDAMINIMA_PRO(const Value: Variant);
    procedure SetVENDAPRAZO_PRO(const Value: Variant);
    procedure SetVENDAPROMOCAO_PRO(const Value: Variant);
    procedure SetVENDAWEB_PRO(const Value: Variant);
    procedure SetVOLTAGEM(const Value: Variant);
    procedure SetVOLUME_QTDE(const Value: Variant);
    procedure SetVPMC(const Value: Variant);
    procedure SetWEB_ALTURA(const Value: Variant);
    procedure SetWEB_CARACTERISTICA(const Value: Variant);
    procedure SetWEB_CATEGORIAS(const Value: Variant);
    procedure SetWEB_CODIGO_INTEGRACAO(const Value: Variant);
    procedure SetWEB_CODIGO_INTEGRACAO_MASTER(const Value: Variant);
    procedure SetWEB_COR(const Value: Variant);
    procedure SetWEB_DESCONTO(const Value: Variant);
    procedure SetWEB_GERENCIA_ESTOQUE(const Value: Variant);
    procedure SetWEB_GERENCIA_IMAGENS(const Value: Variant);
    procedure SetWEB_GERENCIA_PRECO_VENDA(const Value: Variant);
    procedure SetWEB_ID(const Value: Variant);
    procedure SetWEB_INTEGRA(const Value: Variant);
    procedure SetWEB_LARGURA(const Value: Variant);
    procedure SetWEB_NOME_PRO(const Value: Variant);
    procedure SetWEB_PALAVRA_CHAVE(const Value: Variant);
    procedure SetWEB_PESO(const Value: Variant);
    procedure SetWEB_PRECO_PROMOCAO(const Value: Variant);
    procedure SetWEB_PRECO_VENDA(const Value: Variant);
    procedure SetWEB_PROFUNDIDADE(const Value: Variant);
    procedure SetWEB_RESUMO(const Value: Variant);
    procedure SetWEB_TAMANHO(const Value: Variant);
    procedure SetWEB_TIPO_PRODUTO(const Value: Variant);
    procedure SetWEB_URL(const Value: Variant);
    procedure SetWEB_URL_IMAGENS(const Value: Variant);
    procedure SetWEB_VARIACAO(const Value: Variant);
    procedure SetXMOTIVOISENCAO(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetSALDO_CD(const Value: Variant);
    procedure SetSALDO_DISPONIVEL(const Value: Variant);
    procedure SetGRADE_ID(const Value: Variant);
    procedure SetMARGEM_CALCULADA(const Value: Variant);
    procedure SetNOME_GRU(const Value: Variant);
    procedure SetNOME_MAR(const Value: Variant);
    procedure SetNOME_SUB(const Value: Variant);
    procedure SetTIPO_NOME(const Value: Variant);
    procedure SetCodProdutoView(const Value: String);
    procedure SetNOME_FOR(const Value: Variant);
    procedure SetCOR_ID(const Value: Variant);
    procedure SetVOLTAGEM_ID(const Value: Variant);
    procedure SetTIPO__PRO(const Value: Variant);
    procedure SetPERMITE_VENDA_SEGURO_FR(const Value: Variant);
    procedure SetGRUPO_GARANTIA_ID(const Value: Variant);

  public
    property UUID: Variant read FUUID write SetUUID;
    property CODIGO_PRO: Variant read FCODIGO_PRO write SetCODIGO_PRO;
    property CODIGO_GRU: Variant read FCODIGO_GRU write SetCODIGO_GRU;
    property CODIGO_FOR: Variant read FCODIGO_FOR write SetCODIGO_FOR;
    property NOME_PRO: Variant read FNOME_PRO write SetNOME_PRO;
    property UNIDADE_PRO: Variant read FUNIDADE_PRO write SetUNIDADE_PRO;
    property SALDO_PRO: Variant read FSALDO_PRO write SetSALDO_PRO;
    property SALDOMIN_PRO: Variant read FSALDOMIN_PRO write SetSALDOMIN_PRO;
    property CUSTOMEDIO_PRO: Variant read FCUSTOMEDIO_PRO write SetCUSTOMEDIO_PRO;
    property CUSTOULTIMO_PRO: Variant read FCUSTOULTIMO_PRO write SetCUSTOULTIMO_PRO;
    property CUSTOLIQUIDO_PRO: Variant read FCUSTOLIQUIDO_PRO write SetCUSTOLIQUIDO_PRO;
    property CUSTODOLAR_PRO: Variant read FCUSTODOLAR_PRO write SetCUSTODOLAR_PRO;
    property MARGEM_PRO: Variant read FMARGEM_PRO write SetMARGEM_PRO;
    property VENDA_PRO: Variant read FVENDA_PRO write SetVENDA_PRO;
    property VENDAPRAZO_PRO: Variant read FVENDAPRAZO_PRO write SetVENDAPRAZO_PRO;
    property VENDAPROMOCAO_PRO: Variant read FVENDAPROMOCAO_PRO write SetVENDAPROMOCAO_PRO;
    property PESO_PRO: Variant read FPESO_PRO write SetPESO_PRO;
    property VENDAMINIMA_PRO: Variant read FVENDAMINIMA_PRO write SetVENDAMINIMA_PRO;
    property VENDAWEB_PRO: Variant read FVENDAWEB_PRO write SetVENDAWEB_PRO;
    property MARCA_PRO: Variant read FMARCA_PRO write SetMARCA_PRO;
    property APLICACAO_PRO: Variant read FAPLICACAO_PRO write SetAPLICACAO_PRO;
    property IMAGEM_PRO: Variant read FIMAGEM_PRO write SetIMAGEM_PRO;
    property CODIGO_MAR: Variant read FCODIGO_MAR write SetCODIGO_MAR;
    property COMISSAO_PRO: Variant read FCOMISSAO_PRO write SetCOMISSAO_PRO;
    property CODIGO_SUB: Variant read FCODIGO_SUB write SetCODIGO_SUB;
    property DATADOLAR_PRO: Variant read FDATADOLAR_PRO write SetDATADOLAR_PRO;
    property VALORDOLAR_PRO: Variant read FVALORDOLAR_PRO write SetVALORDOLAR_PRO;
    property GARANTIA_PRO: Variant read FGARANTIA_PRO write SetGARANTIA_PRO;
    property NOVIDADE_PRO: Variant read FNOVIDADE_PRO write SetNOVIDADE_PRO;
    property BARRAS_PRO: Variant read FBARRAS_PRO write SetBARRAS_PRO;
    property USUARIO_PRO: Variant read FUSUARIO_PRO write SetUSUARIO_PRO;
    property IPI_PRO: Variant read FIPI_PRO write SetIPI_PRO;
    property FRETE_PRO: Variant read FFRETE_PRO write SetFRETE_PRO;
    property ULTIMAVENDA_PRO: Variant read FULTIMAVENDA_PRO write SetULTIMAVENDA_PRO;
    property QTDEDIAS_PRO: Variant read FQTDEDIAS_PRO write SetQTDEDIAS_PRO;
    property CODLISTA_COD: Variant read FCODLISTA_COD write SetCODLISTA_COD;
    property ICMS_PRO: Variant read FICMS_PRO write SetICMS_PRO;
    property DESCRICAO: Variant read FDESCRICAO write SetDESCRICAO;
    property PRODUTO_FINAL: Variant read FPRODUTO_FINAL write SetPRODUTO_FINAL;
    property QTDE_PRODUZIR: Variant read FQTDE_PRODUZIR write SetQTDE_PRODUZIR;
    property PRINCIPIO_ATIVO: Variant read FPRINCIPIO_ATIVO write SetPRINCIPIO_ATIVO;
    property CODIGO_FORNECEDOR: Variant read FCODIGO_FORNECEDOR write SetCODIGO_FORNECEDOR;
    property STATUS_PRO: Variant read FSTATUS_PRO write SetSTATUS_PRO;
    property LOJA: Variant read FLOJA write SetLOJA;
    property ECF_PRO: Variant read FECF_PRO write SetECF_PRO;
    property LISTA: Variant read FLISTA write SetLISTA;
    property COMIS_PRO: Variant read FCOMIS_PRO write SetCOMIS_PRO;
    property DESCONTO_PRO: Variant read FDESCONTO_PRO write SetDESCONTO_PRO;
    property PMC_PRO: Variant read FPMC_PRO write SetPMC_PRO;
    property PRECO_FABRICANTE: Variant read FPRECO_FABRICANTE write SetPRECO_FABRICANTE;
    property SALDO: Variant read FSALDO write SetSALDO;
    property CLAS_FISCAL_PRO: Variant read FCLAS_FISCAL_PRO write SetCLAS_FISCAL_PRO;
    property TABELA_VENDA: Variant read FTABELA_VENDA write SetTABELA_VENDA;
    property PRODUTO_REFERENTE: Variant read FPRODUTO_REFERENTE write SetPRODUTO_REFERENTE;
    property TABICMS_PRO: Variant read FTABICMS_PRO write SetTABICMS_PRO;
    property VALIDADE_PRO: Variant read FVALIDADE_PRO write SetVALIDADE_PRO;
    property PESQUISA: Variant read FPESQUISA write SetPESQUISA;
    property METROSBARRAS_PRO: Variant read FMETROSBARRAS_PRO write SetMETROSBARRAS_PRO;
    property ALIQUOTA_PIS: Variant read FALIQUOTA_PIS write SetALIQUOTA_PIS;
    property ALIQUOTA_COFINS: Variant read FALIQUOTA_COFINS write SetALIQUOTA_COFINS;
    property CST_COFINS: Variant read FCST_COFINS write SetCST_COFINS;
    property CST_PIS: Variant read FCST_PIS write SetCST_PIS;
    property CSOSN: Variant read FCSOSN write SetCSOSN;
    property QUTDE_MAXIMA: Variant read FQUTDE_MAXIMA write SetQUTDE_MAXIMA;
    property ULTIMA_ALTERACAO_PRO: Variant read FULTIMA_ALTERACAO_PRO write SetULTIMA_ALTERACAO_PRO;
    property LOCALIZACAO: Variant read FLOCALIZACAO write SetLOCALIZACAO;
    property PRODUTO_NFE: Variant read FPRODUTO_NFE write SetPRODUTO_NFE;
    property CNPJ_PRODUTO_NFE: Variant read FCNPJ_PRODUTO_NFE write SetCNPJ_PRODUTO_NFE;
    property ID: Variant read FID write SetID;
    property MATERIAL: Variant read FMATERIAL write SetMATERIAL;
    property PEDIDO_MENSAL: Variant read FPEDIDO_MENSAL write SetPEDIDO_MENSAL;
    property QUANT_PECA_BARRA: Variant read FQUANT_PECA_BARRA write SetQUANT_PECA_BARRA;
    property QUANT_BARRA_USADAS: Variant read FQUANT_BARRA_USADAS write SetQUANT_BARRA_USADAS;
    property VALOR_MP: Variant read FVALOR_MP write SetVALOR_MP;
    property QUANT_PECA_HORA: Variant read FQUANT_PECA_HORA write SetQUANT_PECA_HORA;
    property SERRA: Variant read FSERRA write SetSERRA;
    property FURADEIRA: Variant read FFURADEIRA write SetFURADEIRA;
    property ROSQUEADEIRA: Variant read FROSQUEADEIRA write SetROSQUEADEIRA;
    property TORNO: Variant read FTORNO write SetTORNO;
    property GALVANIZACAO: Variant read FGALVANIZACAO write SetGALVANIZACAO;
    property TEMPERA: Variant read FTEMPERA write SetTEMPERA;
    property FREZADORA: Variant read FFREZADORA write SetFREZADORA;
    property FRETE: Variant read FFRETE write SetFRETE;
    property MARGEM_LUCRO: Variant read FMARGEM_LUCRO write SetMARGEM_LUCRO;
    property PORCENTAGEM_NFE: Variant read FPORCENTAGEM_NFE write SetPORCENTAGEM_NFE;
    property HORA_MAQUINA: Variant read FHORA_MAQUINA write SetHORA_MAQUINA;
    property CODIGO_FORNECEDOR2: Variant read FCODIGO_FORNECEDOR2 write SetCODIGO_FORNECEDOR2;
    property CODIGO_FORNECEDOR3: Variant read FCODIGO_FORNECEDOR3 write SetCODIGO_FORNECEDOR3;
    property REFERENCIA_NEW: Variant read FREFERENCIA_NEW write SetREFERENCIA_NEW;
    property MULTIPLOS: Variant read FMULTIPLOS write SetMULTIPLOS;
    property CST_CREDITO_PIS: Variant read FCST_CREDITO_PIS write SetCST_CREDITO_PIS;
    property CST_CREDITO_COFINS: Variant read FCST_CREDITO_COFINS write SetCST_CREDITO_COFINS;
    property ALIQ_CREDITO_COFINS: Variant read FALIQ_CREDITO_COFINS write SetALIQ_CREDITO_COFINS;
    property ALIQ_CREDITO_PIS: Variant read FALIQ_CREDITO_PIS write SetALIQ_CREDITO_PIS;
    property CFOP_ESTADUAL_ID: Variant read FCFOP_ESTADUAL_ID write SetCFOP_ESTADUAL_ID;
    property CFOP_INTERESTADUAL_ID: Variant read FCFOP_INTERESTADUAL_ID write SetCFOP_INTERESTADUAL_ID;
    property CST_IPI: Variant read FCST_IPI write SetCST_IPI;
    property IPI_SAI: Variant read FIPI_SAI write SetIPI_SAI;
    property VALIDAR_CAIXA: Variant read FVALIDAR_CAIXA write SetVALIDAR_CAIXA;
    property USAR_INSC_ST: Variant read FUSAR_INSC_ST write SetUSAR_INSC_ST;
    property FORNECEDOR_CODIGO: Variant read FFORNECEDOR_CODIGO write SetFORNECEDOR_CODIGO;
    property CONTROLE_SERIAL: Variant read FCONTROLE_SERIAL write SetCONTROLE_SERIAL;
    property DESMEMBRAR_KIT: Variant read FDESMEMBRAR_KIT write SetDESMEMBRAR_KIT;
    property CALCULO_MARGEM: Variant read FCALCULO_MARGEM write SetCALCULO_MARGEM;
    property PESO_LIQUIDO: Variant read FPESO_LIQUIDO write SetPESO_LIQUIDO;
    property CONTA_CONTABIL: Variant read FCONTA_CONTABIL write SetCONTA_CONTABIL;
    property LINK: Variant read FLINK write SetLINK;
    property EAN_14: Variant read FEAN_14 write SetEAN_14;
    property VALIDADE: Variant read FVALIDADE write SetVALIDADE;
    property USAR_BALANCA: Variant read FUSAR_BALANCA write SetUSAR_BALANCA;
    property VENDA_WEB: Variant read FVENDA_WEB write SetVENDA_WEB;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property OBS_GERAL: Variant read FOBS_GERAL write SetOBS_GERAL;
    property MULTIPLICADOR: Variant read FMULTIPLICADOR write SetMULTIPLICADOR;
    property DIVIZOR: Variant read FDIVIZOR write SetDIVIZOR;
    property ARREDONDAMENTO: Variant read FARREDONDAMENTO write SetARREDONDAMENTO;
    property OBS_NF: Variant read FOBS_NF write SetOBS_NF;
    property DESTAQUE: Variant read FDESTAQUE write SetDESTAQUE;
    property MARGEM_PROMOCAO: Variant read FMARGEM_PROMOCAO write SetMARGEM_PROMOCAO;
    property TIPO_ID: Variant read FTIPO_ID write SetTIPO_ID;
    property PART_NUMBER: Variant read FPART_NUMBER write SetPART_NUMBER;
    property NFCE_CST: Variant read FNFCE_CST write SetNFCE_CST;
    property NFCE_CSOSN: Variant read FNFCE_CSOSN write SetNFCE_CSOSN;
    property NFCE_ICMS: Variant read FNFCE_ICMS write SetNFCE_ICMS;
    property NFCE_CFOP: Variant read FNFCE_CFOP write SetNFCE_CFOP;
    property ETIQUETA_NOME: Variant read FETIQUETA_NOME write SetETIQUETA_NOME;
    property ETIQUETA_NOME_CIENTIFICO: Variant read FETIQUETA_NOME_CIENTIFICO write SetETIQUETA_NOME_CIENTIFICO;
    property ETIQUETA_PESO_LIQUIDO: Variant read FETIQUETA_PESO_LIQUIDO write SetETIQUETA_PESO_LIQUIDO;
    property ETIQUETA_PESO_BRUTO: Variant read FETIQUETA_PESO_BRUTO write SetETIQUETA_PESO_BRUTO;
    property ETIQUETA_SIGLA: Variant read FETIQUETA_SIGLA write SetETIQUETA_SIGLA;
    property ETIQUETA_PORCAO: Variant read FETIQUETA_PORCAO write SetETIQUETA_PORCAO;
    property IMPRESSAO_COZINHA: Variant read FIMPRESSAO_COZINHA write SetIMPRESSAO_COZINHA;
    property IMPRESSAO_BALCAO: Variant read FIMPRESSAO_BALCAO write SetIMPRESSAO_BALCAO;
    property WEB_NOME_PRO: Variant read FWEB_NOME_PRO write SetWEB_NOME_PRO;
    property WEB_GERENCIA_ESTOQUE: Variant read FWEB_GERENCIA_ESTOQUE write SetWEB_GERENCIA_ESTOQUE;
    property WEB_PRECO_VENDA: Variant read FWEB_PRECO_VENDA write SetWEB_PRECO_VENDA;
    property WEB_PRECO_PROMOCAO: Variant read FWEB_PRECO_PROMOCAO write SetWEB_PRECO_PROMOCAO;
    property WEB_PESO: Variant read FWEB_PESO write SetWEB_PESO;
    property WEB_ALTURA: Variant read FWEB_ALTURA write SetWEB_ALTURA;
    property WEB_LARGURA: Variant read FWEB_LARGURA write SetWEB_LARGURA;
    property WEB_PROFUNDIDADE: Variant read FWEB_PROFUNDIDADE write SetWEB_PROFUNDIDADE;
    property CONSERVADORA: Variant read FCONSERVADORA write SetCONSERVADORA;
    property CLIENTE_CONSERVADORA: Variant read FCLIENTE_CONSERVADORA write SetCLIENTE_CONSERVADORA;
    property VOLTAGEM: Variant read FVOLTAGEM write SetVOLTAGEM;
    property ANO_FABRICACAO: Variant read FANO_FABRICACAO write SetANO_FABRICACAO;
    property PROPRIEDADE: Variant read FPROPRIEDADE write SetPROPRIEDADE;
    property MODELO: Variant read FMODELO write SetMODELO;
    property TIPO_CONSERVADORA: Variant read FTIPO_CONSERVADORA write SetTIPO_CONSERVADORA;
    property FICHA_TECNICA: Variant read FFICHA_TECNICA write SetFICHA_TECNICA;
    property DESCRICAO_TECNICA: Variant read FDESCRICAO_TECNICA write SetDESCRICAO_TECNICA;
    property IMAGEM_TECNICA: Variant read FIMAGEM_TECNICA write SetIMAGEM_TECNICA;
    property CUSTO_MEDIDA: Variant read FCUSTO_MEDIDA write SetCUSTO_MEDIDA;
    property IMAGEM: Variant read FIMAGEM write SetIMAGEM;
    property POS_VENDA_DIAS: Variant read FPOS_VENDA_DIAS write SetPOS_VENDA_DIAS;
    property WEB_DESCONTO: Variant read FWEB_DESCONTO write SetWEB_DESCONTO;
    property WEB_CARACTERISTICA: Variant read FWEB_CARACTERISTICA write SetWEB_CARACTERISTICA;
    property BONUS: Variant read FBONUS write SetBONUS;
    property LW: Variant read FLW write SetLW;
    property OH: Variant read FOH write SetOH;
    property TW: Variant read FTW write SetTW;
    property TH: Variant read FTH write SetTH;
    property TIPO_VENDA_COMISSAO_ID: Variant read FTIPO_VENDA_COMISSAO_ID write SetTIPO_VENDA_COMISSAO_ID;
    property DIFERENCA_CORTE: Variant read FDIFERENCA_CORTE write SetDIFERENCA_CORTE;
    property USAR_CONTROLE_KG: Variant read FUSAR_CONTROLE_KG write SetUSAR_CONTROLE_KG;
    property CEST: Variant read FCEST write SetCEST;
    property SUGESTAO_COMPRA: Variant read FSUGESTAO_COMPRA write SetSUGESTAO_COMPRA;
    property STATUS_LINHA: Variant read FSTATUS_LINHA write SetSTATUS_LINHA;
    property CONTROLEALTERACAO: Variant read FCONTROLEALTERACAO write SetCONTROLEALTERACAO;
    property PRECO_DOLAR: Variant read FPRECO_DOLAR write SetPRECO_DOLAR;
    property EMBALAGEM_ID: Variant read FEMBALAGEM_ID write SetEMBALAGEM_ID;
    property CUSTO_MANUAL: Variant read FCUSTO_MANUAL write SetCUSTO_MANUAL;
    property ETIQUETA_LINHA_1: Variant read FETIQUETA_LINHA_1 write SetETIQUETA_LINHA_1;
    property ETIQUETA_LINHA_2: Variant read FETIQUETA_LINHA_2 write SetETIQUETA_LINHA_2;
    property SALDO_ONLINE: Variant read FSALDO_ONLINE write SetSALDO_ONLINE;
    property EQUIPAMENTO_ID: Variant read FEQUIPAMENTO_ID write SetEQUIPAMENTO_ID;
    property MEDIA_SUGESTAO: Variant read FMEDIA_SUGESTAO write SetMEDIA_SUGESTAO;
    property DATA_MEDIA_SUGESTAO: Variant read FDATA_MEDIA_SUGESTAO write SetDATA_MEDIA_SUGESTAO;
    property USAR_PARTES: Variant read FUSAR_PARTES write SetUSAR_PARTES;
    property CODIGO_ANP: Variant read FCODIGO_ANP write SetCODIGO_ANP;
    property ALTURA_M: Variant read FALTURA_M write SetALTURA_M;
    property LARGURA_M: Variant read FLARGURA_M write SetLARGURA_M;
    property PROFUNDIDADE_M: Variant read FPROFUNDIDADE_M write SetPROFUNDIDADE_M;
    property BASE_ST_RECOLHIDO: Variant read FBASE_ST_RECOLHIDO write SetBASE_ST_RECOLHIDO;
    property PERCENTUAL_ST_RECOLHIDO: Variant read FPERCENTUAL_ST_RECOLHIDO write SetPERCENTUAL_ST_RECOLHIDO;
    property FCI: Variant read FFCI write SetFCI;
    property WEB_PALAVRA_CHAVE: Variant read FWEB_PALAVRA_CHAVE write SetWEB_PALAVRA_CHAVE;
    property WEB_URL: Variant read FWEB_URL write SetWEB_URL;
    property WEB_COR: Variant read FWEB_COR write SetWEB_COR;
    property WEB_TAMANHO: Variant read FWEB_TAMANHO write SetWEB_TAMANHO;
    property IPI_CENQ: Variant read FIPI_CENQ write SetIPI_CENQ;
    property VOLUME_QTDE: Variant read FVOLUME_QTDE write SetVOLUME_QTDE;
    property M3: Variant read FM3 write SetM3;
    property TIPO_ITEM: Variant read FTIPO_ITEM write SetTIPO_ITEM;
    property MARGEM_PRAZO: Variant read FMARGEM_PRAZO write SetMARGEM_PRAZO;
    property VALIDAR_LOTE: Variant read FVALIDAR_LOTE write SetVALIDAR_LOTE;
    property CUSTOBASE_PRO: Variant read FCUSTOBASE_PRO write SetCUSTOBASE_PRO;
    property VALOR_VENDA_MAXIMO: Variant read FVALOR_VENDA_MAXIMO write SetVALOR_VENDA_MAXIMO;
    property VALOR_VENDA_MINIMO: Variant read FVALOR_VENDA_MINIMO write SetVALOR_VENDA_MINIMO;
    property ORDEM: Variant read FORDEM write SetORDEM;
    property NOME_RESUMIDO: Variant read FNOME_RESUMIDO write SetNOME_RESUMIDO;
    property COMBO: Variant read FCOMBO write SetCOMBO;
    property UTRIB: Variant read FUTRIB write SetUTRIB;
    property QTRIB: Variant read FQTRIB write SetQTRIB;
    property CLIENTE_TSB: Variant read FCLIENTE_TSB write SetCLIENTE_TSB;
    property UUIDALTERACAO: Variant read FUUIDALTERACAO write SetUUIDALTERACAO;
    property RECEITA: Variant read FRECEITA write SetRECEITA;
    property CONTROLE_INVENTARIO: Variant read FCONTROLE_INVENTARIO write SetCONTROLE_INVENTARIO;
    property COTACAO_TIPO: Variant read FCOTACAO_TIPO write SetCOTACAO_TIPO;
    property VENDA_COM_DESCONTO: Variant read FVENDA_COM_DESCONTO write SetVENDA_COM_DESCONTO;
    property WEB_URL_IMAGENS: Variant read FWEB_URL_IMAGENS write SetWEB_URL_IMAGENS;
    property WEB_ID: Variant read FWEB_ID write SetWEB_ID;
    property WEB_INTEGRA: Variant read FWEB_INTEGRA write SetWEB_INTEGRA;
    property WEB_GERENCIA_PRECO_VENDA: Variant read FWEB_GERENCIA_PRECO_VENDA write SetWEB_GERENCIA_PRECO_VENDA;
    property WEB_GERENCIA_IMAGENS: Variant read FWEB_GERENCIA_IMAGENS write SetWEB_GERENCIA_IMAGENS;
    property WEB_RESUMO: Variant read FWEB_RESUMO write SetWEB_RESUMO;
    property DESCRICAO_ANP: Variant read FDESCRICAO_ANP write SetDESCRICAO_ANP;
    property CBENEF: Variant read FCBENEF write SetCBENEF;
    property INDESCALA: Variant read FINDESCALA write SetINDESCALA;
    property CNPJFAB: Variant read FCNPJFAB write SetCNPJFAB;
    property PRODUTO_PAI: Variant read FPRODUTO_PAI write SetPRODUTO_PAI;
    property CONVERSAO_FRACIONADA: Variant read FCONVERSAO_FRACIONADA write SetCONVERSAO_FRACIONADA;
    property CUSTO_FINANCEIRO: Variant read FCUSTO_FINANCEIRO write SetCUSTO_FINANCEIRO;
    property PRAZO_MEDIO: Variant read FPRAZO_MEDIO write SetPRAZO_MEDIO;
    property ARTIGO_ID: Variant read FARTIGO_ID write SetARTIGO_ID;
    property WEB_CATEGORIAS: Variant read FWEB_CATEGORIAS write SetWEB_CATEGORIAS;
    property WEB_TIPO_PRODUTO: Variant read FWEB_TIPO_PRODUTO write SetWEB_TIPO_PRODUTO;
    property SUBLIMACAO: Variant read FSUBLIMACAO write SetSUBLIMACAO;
    property LISTAR_PRODUCAO: Variant read FLISTAR_PRODUCAO write SetLISTAR_PRODUCAO;
    property LISTAR_ROMANEIO: Variant read FLISTAR_ROMANEIO write SetLISTAR_ROMANEIO;
    property VALOR_TERCERIZADOS: Variant read FVALOR_TERCERIZADOS write SetVALOR_TERCERIZADOS;
    property GARANTIA_12: Variant read FGARANTIA_12 write SetGARANTIA_12;
    property GARANTIA_24: Variant read FGARANTIA_24 write SetGARANTIA_24;
    property MONTAGEM: Variant read FMONTAGEM write SetMONTAGEM;
    property ENTREGA: Variant read FENTREGA write SetENTREGA;
    property CENQ: Variant read FCENQ write SetCENQ;
    property CODIGO_ANTERIOR: Variant read FCODIGO_ANTERIOR write SetCODIGO_ANTERIOR;
    property VALOR_BONUS_SERVICO: Variant read FVALOR_BONUS_SERVICO write SetVALOR_BONUS_SERVICO;
    property NFE_INTEIRO: Variant read FNFE_INTEIRO write SetNFE_INTEIRO;
    property GRUPO_COMISSAO_ID: Variant read FGRUPO_COMISSAO_ID write SetGRUPO_COMISSAO_ID;
    property VALOR_ICMS_SUBSTITUTO: Variant read FVALOR_ICMS_SUBSTITUTO write SetVALOR_ICMS_SUBSTITUTO;
    property FAMILIA: Variant read FFAMILIA write SetFAMILIA;
    property TIPO_PRO: Variant read FTIPO_PRO write SetTIPO_PRO;
    property CUSTOULTIMO_IMPORTACAO: Variant read FCUSTOULTIMO_IMPORTACAO write SetCUSTOULTIMO_IMPORTACAO;
    property PRODUTO_ORIGEM: Variant read FPRODUTO_ORIGEM write SetPRODUTO_ORIGEM;
    property VALOR_MONTADOR: Variant read FVALOR_MONTADOR write SetVALOR_MONTADOR;
    property DATA_ALTERACAO_VENDA_PRO: Variant read FDATA_ALTERACAO_VENDA_PRO write SetDATA_ALTERACAO_VENDA_PRO;
    property DATA_ALTERACAO_CUSTOULTIMO_PRO: Variant read FDATA_ALTERACAO_CUSTOULTIMO_PRO write SetDATA_ALTERACAO_CUSTOULTIMO_PRO;
    property WEB_CODIGO_INTEGRACAO_MASTER: Variant read FWEB_CODIGO_INTEGRACAO_MASTER write SetWEB_CODIGO_INTEGRACAO_MASTER;
    property WEB_CODIGO_INTEGRACAO: Variant read FWEB_CODIGO_INTEGRACAO write SetWEB_CODIGO_INTEGRACAO;
    property WEB_VARIACAO: Variant read FWEB_VARIACAO write SetWEB_VARIACAO;
    property PRODUTO_MODELO: Variant read FPRODUTO_MODELO write SetPRODUTO_MODELO;
    property DATA_CONSUMO_OMINIONE: Variant read FDATA_CONSUMO_OMINIONE write SetDATA_CONSUMO_OMINIONE;
    property CATEGORIA_ID: Variant read FCATEGORIA_ID write SetCATEGORIA_ID;
    property UNIDADE_ENTRADA: Variant read FUNIDADE_ENTRADA write SetUNIDADE_ENTRADA;
    property CPRODANVISA: Variant read FCPRODANVISA write SetCPRODANVISA;
    property XMOTIVOISENCAO: Variant read FXMOTIVOISENCAO write SetXMOTIVOISENCAO;
    property VPMC: Variant read FVPMC write SetVPMC;
    property PRODUTO_FILHO: Variant read FPRODUTO_FILHO write SetPRODUTO_FILHO;
    property CONVERSAO_FRACIONADA_FILHO: Variant read FCONVERSAO_FRACIONADA_FILHO write SetCONVERSAO_FRACIONADA_FILHO;
    property PERCENTUAL_PERDA_MATERIA_PRIMA: Variant read FPERCENTUAL_PERDA_MATERIA_PRIMA write SetPERCENTUAL_PERDA_MATERIA_PRIMA;
    property EXTIPI: Variant read FEXTIPI write SetEXTIPI;
    property SALDO_DISPONIVEL: Variant read FSALDO_DISPONIVEL write SetSALDO_DISPONIVEL;
    property SALDO_CD: Variant read FSALDO_CD write SetSALDO_CD;
    property MARGEM_CALCULADA: Variant read FMARGEM_CALCULADA write SetMARGEM_CALCULADA;
    property GRADE_ID: Variant read FGRADE_ID write SetGRADE_ID;
    property NOME_GRU : Variant read FNOME_GRU write SetNOME_GRU;
    property NOME_FOR : Variant read FNOME_FOR write SetNOME_FOR;
    property NOME_SUB : Variant read FNOME_SUB write SetNOME_SUB;
    property NOME_MAR : Variant read FNOME_MAR write SetNOME_MAR;
    property TIPO_NOME : Variant read FTIPO_NOME write SetTIPO_NOME;
    property VOLTAGEM_ID : Variant read FVOLTAGEM_ID write SetVOLTAGEM_ID;
    property COR_ID : Variant read FCOR_ID write SetCOR_ID;
    property TIPO__PRO : Variant read FTIPO__PRO write SetTIPO__PRO;
    property PERMITE_VENDA_SEGURO_FR : Variant read FPERMITE_VENDA_SEGURO_FR write SetPERMITE_VENDA_SEGURO_FR;
    property GRUPO_GARANTIA_ID : Variant read FGRUPO_GARANTIA_ID write SetGRUPO_GARANTIA_ID;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITProdutosModel;

    procedure obterLista;
    procedure obterVenderItem;
    procedure obterListaCatalogo;
    function obterPromocao(pCodProduto: String): IFDDataset;
    function obterComissao(pCodProduto: String): IFDDataset;

    function Incluir : String;
    function Alterar(pID : String) : ITProdutosModel;
    function Excluir(pCodigoPro : String) : String;
    function Salvar : String;
    function obterListaConsulta: IFDDataset;
    function obterListaMemTable: IFDDataset;
    function obterCodigoBarras(pIdProduto: String): String;
    function obterSaldo(pIdProduto: String): Double;
    function obterSaldoDisponivel(pIdProduto: String): Double;

    function carregaClasse(pId: String): ITProdutosModel;
    function valorVenda(pIdProduto: String): Variant;
    function ObterTabelaPreco : IFDDataset;
    function ValorUnitario(pProdutoPreco: TProdutoPreco) : Double;
    function ValorGarantia(pProduto: String; pValorFaixa: Double): TProdutoGarantia;
    function ConsultaProdutosVendidos(pProduto : String): IFDDataset;

    procedure subtrairSaldo(pIdProduto: String; pSaldo: Double);
    procedure adicionarSaldo(pIdProduto: String; pSaldo: Double);

    procedure verificarCustoMedio;

    property ProdutossLista: IList<ITProdutosModel> read FProdutossLista write SetProdutossLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property CodProdutoView : String read FCodProdutoView write SetCodProdutoView;

  end;

implementation
uses
  ProdutosDao,
  ClienteModel,
  PrecoUFModel,
  PromocaoItensModel,
  PrecoVendaModel,
  PrecoVendaProdutoModel,
  PrecoClienteModel,
  System.SysUtils,
  Data.DB,
  PromocaoModel,
  Variants,
  GrupoModel,
  SubGrupoModel,
  MarcaModel,
  FornecedorModel;

  { TProdutosModel }

procedure TProdutosModel.adicionarSaldo(pIdProduto: String; pSaldo: Double);
var
  lProdutoDao: ITProdutosDao;
begin
  lProdutoDao := TProdutosDao.getNewIface(vIConexao);
  try
    lProdutoDao.objeto.adicionarSaldo(pIdProduto, pSaldo);
  finally
    lProdutoDao:=nil;
  end;
end;

function TProdutosModel.Alterar(pID: String): ITProdutosModel;
var
  lProdutosModel : ITProdutosModel;
begin
  lProdutosModel := TProdutosModel.getNewIface(vIConexao);
  try
    lProdutosModel      := lProdutosModel.objeto.carregaClasse(pID);
    lProdutosModel.objeto.Acao := tacAlterar;
    Result              := lProdutosModel;
  finally

  end;
end;

function TProdutosModel.Excluir(pCodigoPro: String): String;
begin
  self.FCODIGO_PRO := pCodigoPro;
  self.Acao        := tacExcluir;
  Result           := self.Salvar;
end;

class function TProdutosModel.getNewIface(pIConexao: IConexao): ITProdutosModel;
begin
  Result := TImplObjetoOwner<TProdutosModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TProdutosModel.Incluir: String;
var
  lGrupoModel      : TGrupoModel;
  lSubGrupoModel   : TSubGrupoModel;
  lMarcaModel      : TMarcaModel;
  lFornecedorModel : TFornecedorModel;
begin

  lGrupoModel      := TGrupoModel.Create(vIConexao);
  lSubGrupoModel   := TSubGrupoModel.Create(vIConexao);
  lMarcaModel      := TMarcaModel.Create(vIConexao);
  lFornecedorModel := TFornecedorModel.Create(vIConexao);
  try

    if self.CODIGO_GRU = '' then
    begin
      lGrupoModel.StartRecordView := '0';
      lGrupoModel.LengthPageView  := '1';
      lGrupoModel.OrderView       := 'CODIGO_GRU';
      self.CODIGO_GRU := lGrupoModel.ObterLista.objeto.FieldByName('CODIGO_GRU').AsString;
    end;

    if self.CODIGO_FOR = '' then
    begin
      lFornecedorModel.StartRecordView := '0';
      lFornecedorModel.LengthPageView  := '1';
      lFornecedorModel.OrderView       := 'CODIGO_FOR';
      self.CODIGO_FOR := lFornecedorModel.ObterLista.objeto.FieldByName('CODIGO_FOR').AsString;
    end;

    if self.CODIGO_MAR = '' then
    begin
      lMarcaModel.StartRecordView := '0';
      lMarcaModel.LengthPageView  := '1';
      lMarcaModel.OrderView       := 'CODIGO_MAR';
      self.CODIGO_MAR := lMarcaModel.ObterLista.objeto.FieldByName('CODIGO_MAR').AsString;
    end;

    if self.CODIGO_SUB = '' then
    begin
      lSubGrupoModel.StartRecordView := '0';
      lSubGrupoModel.LengthPageView  := '1';
      lSubGrupoModel.OrderView       := 'CODIGO_SUB';
      self.CODIGO_SUB := lSubGrupoModel.ObterLista.objeto.FieldByName('CODIGO_SUB').AsString;
    end;

    self.ECF_PRO              := 'FF';
    self.TIPO_ITEM            := '00';
    self.CENQ                 := '999';
    self.LISTA                := 'N';
    self.WEB_GERENCIA_ESTOQUE := 'N';
    self.PRINCIPIO_ATIVO      := 'N';
    self.IMPRESSAO_COZINHA    := 'N';
    self.STATUS_PRO           := 'S';
    self.TABELA_VENDA         := 'S';
    self.NOVIDADE_PRO         := 'S';
    self.PRODUTO_FINAL        := 'S';
    self.INDESCALA            := 'S';
    self.VALIDAR_CAIXA        := 'S';

    verificarCustoMedio;

    self.DATADOLAR_PRO   := DateToStr(vIConexao.DataServer);
    self.USUARIO_PRO     := self.vIConexao.getUSer.NOME;
    self.LOJA            := self.vIConexao.getEmpresa.LOJA;

    self.Acao := tacIncluir;
    Result    := self.Salvar;
  finally
    lGrupoModel.Free;
  end;
end;

function TProdutosModel.carregaClasse(pId: String): ITProdutosModel;
var
  lProdutosDao: ITProdutosDao;
begin
  lProdutosDao := TProdutosDao.getNewIface(vIConexao);
  try
    Result := lProdutosDao.objeto.carregaClasse(pId);
  finally
    lProdutosDao:=nil;
  end;
end;

function TProdutosModel.ConsultaProdutosVendidos(pProduto: String): IFDDataset;
var
  lProdutosDao: ITProdutosDao;
begin
  lProdutosDao := TProdutosDao.getNewIface(vIConexao);
  try
    Result := lProdutosDao.objeto.ConsultaProdutosVendidos(pProduto);
  finally
    lProdutosDao:=nil;
  end;
end;

constructor TProdutosModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TProdutosModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TProdutosModel.obterCodigoBarras(pIdProduto: String): String;
var
  lProdutosDao: ITProdutosDao;
begin
  lProdutosDao := TProdutosDao.getNewIface(vIConexao);
  try
    Result := lProdutosDao.objeto.obterCodigoBarras(pIdProduto);
  finally
    lProdutosDao:=nil;
  end;
end;

function TProdutosModel.obterComissao(pCodProduto: String): IFDDataset;
var
  lProdutosDao : ITProdutosDao;
begin
  lProdutosDao := TProdutosDao.getNewIface(vIConexao);
  try
    Result := lProdutosDao.objeto.obterComissao(pCodProduto);
  finally
    lProdutosDao:=nil;
  end;
end;

procedure TProdutosModel.obterLista;
var
  lProdutosLista: ITProdutosDao;
begin
  lProdutosLista := TProdutosDao.getNewIface(vIConexao);
  try
    lProdutosLista.objeto.TotalRecords        := FTotalRecords;
    lProdutosLista.objeto.WhereView           := FWhereView;
    lProdutosLista.objeto.CountView           := FCountView;
    lProdutosLista.objeto.OrderView           := FOrderView;
    lProdutosLista.objeto.StartRecordView     := FStartRecordView;
    lProdutosLista.objeto.LengthPageView      := FLengthPageView;
    lProdutosLista.objeto.IDRecordView        := FIDRecordView;

    lProdutosLista.objeto.obterLista;

    FTotalRecords   := lProdutosLista.objeto.TotalRecords;
    FProdutossLista := lProdutosLista.objeto.ProdutossLista;
  finally
    lProdutosLista:=nil;
  end;
end;

procedure TProdutosModel.obterListaCatalogo;
var
  lProdutosLista: ITProdutosDao;
begin
  lProdutosLista := TProdutosDao.getNewIface(vIConexao);
  try
    lProdutosLista.objeto.TotalRecords    := FTotalRecords;
    lProdutosLista.objeto.WhereView       := FWhereView;
    lProdutosLista.objeto.CountView       := FCountView;
    lProdutosLista.objeto.OrderView       := FOrderView;
    lProdutosLista.objeto.StartRecordView := FStartRecordView;
    lProdutosLista.objeto.LengthPageView  := FLengthPageView;
    lProdutosLista.objeto.IDRecordView    := FIDRecordView;

    lProdutosLista.objeto.obterListaCatalogo;

    FTotalRecords   := lProdutosLista.objeto.TotalRecords;
    FProdutossLista := lProdutosLista.objeto.ProdutossLista;
  finally
    lProdutosLista:=nil
  end;
end;

function TProdutosModel.obterListaConsulta: IFDDataset;
var
  lProdutos : ITProdutosDao;
begin
  lProdutos := TProdutosDao.getNewIface(vIConexao);
  try
    lProdutos.objeto.TotalRecords    := FTotalRecords;
    lProdutos.objeto.WhereView       := FWhereView;
    lProdutos.objeto.CountView       := FCountView;
    lProdutos.objeto.OrderView       := FOrderView;
    lProdutos.objeto.StartRecordView := FStartRecordView;
    lProdutos.objeto.LengthPageView  := FLengthPageView;
    lProdutos.objeto.IDRecordView    := FIDRecordView;

    Result        := lProdutos.objeto.obterListaConsulta;
    FTotalRecords := lProdutos.objeto.TotalRecords;
  finally
    lProdutos:=nil;
  end;
end;

function TProdutosModel.obterListaMemTable: IFDDataset;
var
  lProdutosLista : ITProdutosDao;
begin
  lProdutosLista := TProdutosDao.getNewIface(vIConexao);
  try
    lProdutosLista.objeto.TotalRecords    := FTotalRecords;
    lProdutosLista.objeto.WhereView       := FWhereView;
    lProdutosLista.objeto.CountView       := FCountView;
    lProdutosLista.objeto.OrderView       := FOrderView;
    lProdutosLista.objeto.StartRecordView := FStartRecordView;
    lProdutosLista.objeto.LengthPageView  := FLengthPageView;
    lProdutosLista.objeto.IDRecordView    := FIDRecordView;

    Result         := lProdutosLista.objeto.obterListaMemTable;
    FTotalRecords  := lProdutosLista.objeto.TotalRecords;
  finally
    lProdutosLista:=nil;
  end;
end;

function TProdutosModel.ObterTabelaPreco: IFDDataset;
var
  lProdutoDao: ITProdutosDao;
begin
  lProdutoDao := TProdutosDao.getNewIface(vIConexao);
  try
    lProdutoDao.objeto.IDRecordView := FIDRecordView;
    Result := lProdutoDao.objeto.ObterTabelaPreco;
  finally
    lProdutoDao:=nil;
  end;
end;

procedure TProdutosModel.obterVenderItem;
var
  lProdutosDao: ITProdutosDao;
begin
  lProdutosDao := TProdutosDao.getNewIface(vIConexao);
  try
    lProdutosDao.objeto.TotalRecords        := FTotalRecords;
    lProdutosDao.objeto.WhereView           := FWhereView;
    lProdutosDao.objeto.CountView           := FCountView;
    lProdutosDao.objeto.OrderView           := FOrderView;
    lProdutosDao.objeto.StartRecordView     := FStartRecordView;
    lProdutosDao.objeto.LengthPageView      := FLengthPageView;
    lProdutosDao.objeto.IDRecordView        := FIDRecordView;

    lProdutosDao.objeto.obterVenderItem;

    FTotalRecords   := lProdutosDao.objeto.TotalRecords;
    FProdutossLista := lProdutosDao.objeto.ProdutossLista;
  finally
    lProdutosDao:=nil;
  end;
end;

function TProdutosModel.obterPromocao(pCodProduto: String): IFDDataset;
var
  lMemTable           : IFDDataset;
  lPromocaoModel      : ITPromocaoModel;
  lPromocaoItensModel : ITPromocaoItensModel;
begin
  if pCodProduto = '' then
    CriaException('Produto não informado');

  lMemTable           := criaIFDDataset(TFDMemTable.Create(nil));
  lPromocaoModel      := TPromocaoModel.getNewIface(vIConexao);
  lPromocaoItensModel := TPromocaoItensModel.getNewIface(vIConexao);

  try
    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name    := 'OrdenacaoPromocao';
      Fields  := 'PROMOCAO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    with TFDMemTable(lMemTable.objeto) do
    begin
      IndexName := 'OrdenacaoPromocao';
      FieldDefs.Add('ID_PROMOCAO', ftInteger);
      FieldDefs.Add('DATAINICIO', ftDate);
      FieldDefs.Add('DATAFIM', ftDate);
      FieldDefs.Add('PROMOCAO', ftString, 50);
      FieldDefs.Add('VALOR_PROMOCAO', ftFloat);
      FieldDefs.Add('SALDO', ftFloat);
      CreateDataSet;
    end;

    lPromocaoItensModel.objeto.ProdutoView := pCodProduto;
    lPromocaoItensModel.objeto.WhereView   := ' and current_date between promocao.datainicio and promocao.datafim ';
    lPromocaoItensModel.objeto.obterLista;

    for lPromocaoItensModel in lPromocaoItensModel.objeto.PromocaoItenssLista do
    begin
      lPromocaoModel.objeto.IDRecordView := lPromocaoItensModel.objeto.promocao_id;
      lPromocaoModel.objeto.obterLista;

      lMemTable.objeto.InsertRecord([
                              lPromocaoItensModel.objeto.promocao_id,
                              lPromocaoModel.objeto.PromocaosLista.First.objeto.DATAINICIO,
                              lPromocaoModel.objeto.PromocaosLista.First.objeto.DATAFIM,
                              lPromocaoModel.objeto.PromocaosLista.First.objeto.DESCRICAO,
                              lPromocaoItensModel.objeto.valor_promocao,
                              lPromocaoItensModel.objeto.saldo
                             ]);
    end;

    lMemTable.objeto.Open;
    Result := lMemTable;
  finally
    lPromocaoModel:=nil;
    lPromocaoItensModel:=nil;
  end;
end;

function TProdutosModel.obterSaldo(pIdProduto: String): Double;
var
  lProdutoDao: ITProdutosDao;
begin
  lProdutoDao := TProdutosDao.getNewIface(vIConexao);
  try
    Result := lProdutoDao.objeto.obterSaldo(pIdProduto);
  finally
    lProdutoDao:=nil;
  end;
end;

function TProdutosModel.obterSaldoDisponivel(pIdProduto: String): Double;
var
  lProdutoDao: ITProdutosDao;
begin
  lProdutoDao := TProdutosDao.getNewIface(vIConexao);
  try
    Result := lProdutoDao.objeto.obterSaldoDisponivel(pIdProduto);
  finally
    lProdutoDao:=nil;
  end;
end;

function TProdutosModel.Salvar: String;
var
  lProdutosDao: ITProdutosDao;
begin
  lProdutosDao := TProdutosDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lProdutosDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lProdutosDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lProdutosDao.objeto.excluir(mySelf);
    end;
  finally
    lProdutosDao:=nil;
  end;
end;
procedure TProdutosModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;
procedure TProdutosModel.SetALIQUOTA_COFINS(const Value: Variant);
begin
  FALIQUOTA_COFINS := Value;
end;
procedure TProdutosModel.SetALIQUOTA_PIS(const Value: Variant);
begin
  FALIQUOTA_PIS := Value;
end;
procedure TProdutosModel.SetALIQ_CREDITO_COFINS(const Value: Variant);
begin
  FALIQ_CREDITO_COFINS := Value;
end;
procedure TProdutosModel.SetALIQ_CREDITO_PIS(const Value: Variant);
begin
  FALIQ_CREDITO_PIS := Value;
end;
procedure TProdutosModel.SetALTURA_M(const Value: Variant);
begin
  FALTURA_M := Value;
end;
procedure TProdutosModel.SetANO_FABRICACAO(const Value: Variant);
begin
  FANO_FABRICACAO := Value;
end;
procedure TProdutosModel.SetAPLICACAO_PRO(const Value: Variant);
begin
  FAPLICACAO_PRO := Value;
end;
procedure TProdutosModel.SetARREDONDAMENTO(const Value: Variant);
begin
  FARREDONDAMENTO := Value;
end;
procedure TProdutosModel.SetARTIGO_ID(const Value: Variant);
begin
  FARTIGO_ID := Value;
end;
procedure TProdutosModel.SetBARRAS_PRO(const Value: Variant);
begin
  FBARRAS_PRO := Value;
end;
procedure TProdutosModel.SetBASE_ST_RECOLHIDO(const Value: Variant);
begin
  FBASE_ST_RECOLHIDO := Value;
end;
procedure TProdutosModel.SetBONUS(const Value: Variant);
begin
  FBONUS := Value;
end;
procedure TProdutosModel.SetCALCULO_MARGEM(const Value: Variant);
begin
  FCALCULO_MARGEM := Value;
end;
procedure TProdutosModel.SetCATEGORIA_ID(const Value: Variant);
begin
  FCATEGORIA_ID := Value;
end;
procedure TProdutosModel.SetCBENEF(const Value: Variant);
begin
  FCBENEF := Value;
end;
procedure TProdutosModel.SetCENQ(const Value: Variant);
begin
  FCENQ := Value;
end;
procedure TProdutosModel.SetCEST(const Value: Variant);
begin
  FCEST := Value;
end;
procedure TProdutosModel.SetCFOP_ESTADUAL_ID(const Value: Variant);
begin
  FCFOP_ESTADUAL_ID := Value;
end;
procedure TProdutosModel.SetCFOP_INTERESTADUAL_ID(const Value: Variant);
begin
  FCFOP_INTERESTADUAL_ID := Value;
end;
procedure TProdutosModel.SetCLAS_FISCAL_PRO(const Value: Variant);
begin
  FCLAS_FISCAL_PRO := Value;
end;
procedure TProdutosModel.SetCLIENTE_CONSERVADORA(const Value: Variant);
begin
  FCLIENTE_CONSERVADORA := Value;
end;
procedure TProdutosModel.SetCLIENTE_TSB(const Value: Variant);
begin
  FCLIENTE_TSB := Value;
end;
procedure TProdutosModel.SetCNPJFAB(const Value: Variant);
begin
  FCNPJFAB := Value;
end;
procedure TProdutosModel.SetCNPJ_PRODUTO_NFE(const Value: Variant);
begin
  FCNPJ_PRODUTO_NFE := Value;
end;
procedure TProdutosModel.SetCODIGO_ANP(const Value: Variant);
begin
  FCODIGO_ANP := Value;
end;
procedure TProdutosModel.SetCODIGO_ANTERIOR(const Value: Variant);
begin
  FCODIGO_ANTERIOR := Value;
end;
procedure TProdutosModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;
procedure TProdutosModel.SetCODIGO_FORNECEDOR(const Value: Variant);
begin
  FCODIGO_FORNECEDOR := Value;
end;
procedure TProdutosModel.SetCODIGO_FORNECEDOR2(const Value: Variant);
begin
  FCODIGO_FORNECEDOR2 := Value;
end;
procedure TProdutosModel.SetCODIGO_FORNECEDOR3(const Value: Variant);
begin
  FCODIGO_FORNECEDOR3 := Value;
end;
procedure TProdutosModel.SetCODIGO_GRU(const Value: Variant);
begin
  FCODIGO_GRU := Value;
end;
procedure TProdutosModel.SetCODIGO_MAR(const Value: Variant);
begin
  FCODIGO_MAR := Value;
end;
procedure TProdutosModel.SetCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
end;
procedure TProdutosModel.SetCODIGO_SUB(const Value: Variant);
begin
  FCODIGO_SUB := Value;
end;
procedure TProdutosModel.SetCODLISTA_COD(const Value: Variant);
begin
  FCODLISTA_COD := Value;
end;
procedure TProdutosModel.SetCodProdutoView(const Value: String);
begin
  FCodProdutoView := Value;
end;

procedure TProdutosModel.SetCOMBO(const Value: Variant);
begin
  FCOMBO := Value;
end;
procedure TProdutosModel.SetCOMISSAO_PRO(const Value: Variant);
begin
  FCOMISSAO_PRO := Value;
end;
procedure TProdutosModel.SetCOMIS_PRO(const Value: Variant);
begin
  FCOMIS_PRO := Value;
end;
procedure TProdutosModel.SetCONSERVADORA(const Value: Variant);
begin
  FCONSERVADORA := Value;
end;
procedure TProdutosModel.SetCONTA_CONTABIL(const Value: Variant);
begin
  FCONTA_CONTABIL := Value;
end;
procedure TProdutosModel.SetCONTROLEALTERACAO(const Value: Variant);
begin
  FCONTROLEALTERACAO := Value;
end;
procedure TProdutosModel.SetCONTROLE_INVENTARIO(const Value: Variant);
begin
  FCONTROLE_INVENTARIO := Value;
end;
procedure TProdutosModel.SetCONTROLE_SERIAL(const Value: Variant);
begin
  FCONTROLE_SERIAL := Value;
end;
procedure TProdutosModel.SetCONVERSAO_FRACIONADA(const Value: Variant);
begin
  FCONVERSAO_FRACIONADA := Value;
end;
procedure TProdutosModel.SetCONVERSAO_FRACIONADA_FILHO(const Value: Variant);
begin
  FCONVERSAO_FRACIONADA_FILHO := Value;
end;
procedure TProdutosModel.SetCOR_ID(const Value: Variant);
begin
  FCOR_ID := Value;
end;
procedure TProdutosModel.SetCOTACAO_TIPO(const Value: Variant);
begin
  FCOTACAO_TIPO := Value;
end;
procedure TProdutosModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TProdutosModel.SetCPRODANVISA(const Value: Variant);
begin
  FCPRODANVISA := Value;
end;
procedure TProdutosModel.SetCSOSN(const Value: Variant);
begin
  FCSOSN := Value;
end;
procedure TProdutosModel.SetCST_COFINS(const Value: Variant);
begin
  FCST_COFINS := Value;
end;
procedure TProdutosModel.SetCST_CREDITO_COFINS(const Value: Variant);
begin
  FCST_CREDITO_COFINS := Value;
end;
procedure TProdutosModel.SetCST_CREDITO_PIS(const Value: Variant);
begin
  FCST_CREDITO_PIS := Value;
end;
procedure TProdutosModel.SetCST_IPI(const Value: Variant);
begin
  FCST_IPI := Value;
end;
procedure TProdutosModel.SetCST_PIS(const Value: Variant);
begin
  FCST_PIS := Value;
end;
procedure TProdutosModel.SetCUSTOBASE_PRO(const Value: Variant);
begin
  FCUSTOBASE_PRO := Value;
end;
procedure TProdutosModel.SetCUSTODOLAR_PRO(const Value: Variant);
begin
  FCUSTODOLAR_PRO := Value;
end;
procedure TProdutosModel.SetCUSTOLIQUIDO_PRO(const Value: Variant);
begin
  FCUSTOLIQUIDO_PRO := Value;
end;
procedure TProdutosModel.SetCUSTOMEDIO_PRO(const Value: Variant);
begin
  FCUSTOMEDIO_PRO := Value;
end;
procedure TProdutosModel.SetCUSTOULTIMO_IMPORTACAO(const Value: Variant);
begin
  FCUSTOULTIMO_IMPORTACAO := Value;
end;
procedure TProdutosModel.SetCUSTOULTIMO_PRO(const Value: Variant);
begin
  FCUSTOULTIMO_PRO := Value;
end;
procedure TProdutosModel.SetCUSTO_FINANCEIRO(const Value: Variant);
begin
  FCUSTO_FINANCEIRO := Value;
end;
procedure TProdutosModel.SetCUSTO_MANUAL(const Value: Variant);
begin
  FCUSTO_MANUAL := Value;
end;
procedure TProdutosModel.SetCUSTO_MEDIDA(const Value: Variant);
begin
  FCUSTO_MEDIDA := Value;
end;
procedure TProdutosModel.SetDATADOLAR_PRO(const Value: Variant);
begin
  FDATADOLAR_PRO := Value;
end;
procedure TProdutosModel.SetDATA_ALTERACAO_CUSTOULTIMO_PRO(
  const Value: Variant);
begin
  FDATA_ALTERACAO_CUSTOULTIMO_PRO := Value;
end;
procedure TProdutosModel.SetDATA_ALTERACAO_VENDA_PRO(const Value: Variant);
begin
  FDATA_ALTERACAO_VENDA_PRO := Value;
end;
procedure TProdutosModel.SetDATA_CONSUMO_OMINIONE(const Value: Variant);
begin
  FDATA_CONSUMO_OMINIONE := Value;
end;
procedure TProdutosModel.SetDATA_MEDIA_SUGESTAO(const Value: Variant);
begin
  FDATA_MEDIA_SUGESTAO := Value;
end;
procedure TProdutosModel.SetDESCONTO_PRO(const Value: Variant);
begin
  FDESCONTO_PRO := Value;
end;
procedure TProdutosModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;
procedure TProdutosModel.SetDESCRICAO_ANP(const Value: Variant);
begin
  FDESCRICAO_ANP := Value;
end;
procedure TProdutosModel.SetDESCRICAO_TECNICA(const Value: Variant);
begin
  FDESCRICAO_TECNICA := Value;
end;
procedure TProdutosModel.SetDESMEMBRAR_KIT(const Value: Variant);
begin
  FDESMEMBRAR_KIT := Value;
end;
procedure TProdutosModel.SetDESTAQUE(const Value: Variant);
begin
  FDESTAQUE := Value;
end;
procedure TProdutosModel.SetDIFERENCA_CORTE(const Value: Variant);
begin
  FDIFERENCA_CORTE := Value;
end;
procedure TProdutosModel.SetDIVIZOR(const Value: Variant);
begin
  FDIVIZOR := Value;
end;
procedure TProdutosModel.SetEAN_14(const Value: Variant);
begin
  FEAN_14 := Value;
end;
procedure TProdutosModel.SetECF_PRO(const Value: Variant);
begin
  FECF_PRO := Value;
end;
procedure TProdutosModel.SetEMBALAGEM_ID(const Value: Variant);
begin
  FEMBALAGEM_ID := Value;
end;
procedure TProdutosModel.SetENTREGA(const Value: Variant);
begin
  FENTREGA := Value;
end;
procedure TProdutosModel.SetEQUIPAMENTO_ID(const Value: Variant);
begin
  FEQUIPAMENTO_ID := Value;
end;
procedure TProdutosModel.SetETIQUETA_LINHA_1(const Value: Variant);
begin
  FETIQUETA_LINHA_1 := Value;
end;
procedure TProdutosModel.SetETIQUETA_LINHA_2(const Value: Variant);
begin
  FETIQUETA_LINHA_2 := Value;
end;
procedure TProdutosModel.SetETIQUETA_NOME(const Value: Variant);
begin
  FETIQUETA_NOME := Value;
end;
procedure TProdutosModel.SetETIQUETA_NOME_CIENTIFICO(const Value: Variant);
begin
  FETIQUETA_NOME_CIENTIFICO := Value;
end;
procedure TProdutosModel.SetETIQUETA_PESO_BRUTO(const Value: Variant);
begin
  FETIQUETA_PESO_BRUTO := Value;
end;
procedure TProdutosModel.SetETIQUETA_PESO_LIQUIDO(const Value: Variant);
begin
  FETIQUETA_PESO_LIQUIDO := Value;
end;
procedure TProdutosModel.SetETIQUETA_PORCAO(const Value: Variant);
begin
  FETIQUETA_PORCAO := Value;
end;
procedure TProdutosModel.SetETIQUETA_SIGLA(const Value: Variant);
begin
  FETIQUETA_SIGLA := Value;
end;
procedure TProdutosModel.SetEXTIPI(const Value: Variant);
begin
  FEXTIPI := Value;
end;
procedure TProdutosModel.SetFAMILIA(const Value: Variant);
begin
  FFAMILIA := Value;
end;
procedure TProdutosModel.SetFCI(const Value: Variant);
begin
  FFCI := Value;
end;
procedure TProdutosModel.SetFICHA_TECNICA(const Value: Variant);
begin
  FFICHA_TECNICA := Value;
end;
procedure TProdutosModel.SetFORNECEDOR_CODIGO(const Value: Variant);
begin
  FFORNECEDOR_CODIGO := Value;
end;
procedure TProdutosModel.SetFRETE(const Value: Variant);
begin
  FFRETE := Value;
end;
procedure TProdutosModel.SetFRETE_PRO(const Value: Variant);
begin
  FFRETE_PRO := Value;
end;
procedure TProdutosModel.SetFREZADORA(const Value: Variant);
begin
  FFREZADORA := Value;
end;
procedure TProdutosModel.SetFURADEIRA(const Value: Variant);
begin
  FFURADEIRA := Value;
end;
procedure TProdutosModel.SetGALVANIZACAO(const Value: Variant);
begin
  FGALVANIZACAO := Value;
end;
procedure TProdutosModel.SetGARANTIA_12(const Value: Variant);
begin
  FGARANTIA_12 := Value;
end;
procedure TProdutosModel.SetGARANTIA_24(const Value: Variant);
begin
  FGARANTIA_24 := Value;
end;
procedure TProdutosModel.SetGARANTIA_PRO(const Value: Variant);
begin
  FGARANTIA_PRO := Value;
end;
procedure TProdutosModel.SetGRADE_ID(const Value: Variant);
begin
  FGRADE_ID := Value;
end;

procedure TProdutosModel.SetGRUPO_COMISSAO_ID(const Value: Variant);
begin
  FGRUPO_COMISSAO_ID := Value;
end;
procedure TProdutosModel.SetGRUPO_GARANTIA_ID(const Value: Variant);
begin
  FGRUPO_GARANTIA_ID := Value;
end;

procedure TProdutosModel.SetHORA_MAQUINA(const Value: Variant);
begin
  FHORA_MAQUINA := Value;
end;
procedure TProdutosModel.SetPART_NUMBER(const Value: Variant);
begin
  FPART_NUMBER := Value;
end;
procedure TProdutosModel.SetPEDIDO_MENSAL(const Value: Variant);
begin
  FPEDIDO_MENSAL := Value;
end;
procedure TProdutosModel.SetPERCENTUAL_PERDA_MATERIA_PRIMA(
  const Value: Variant);
begin
  FPERCENTUAL_PERDA_MATERIA_PRIMA := Value;
end;
procedure TProdutosModel.SetPERCENTUAL_ST_RECOLHIDO(const Value: Variant);
begin
  FPERCENTUAL_ST_RECOLHIDO := Value;
end;
procedure TProdutosModel.SetPERMITE_VENDA_SEGURO_FR(const Value: Variant);
begin
  FPERMITE_VENDA_SEGURO_FR := Value;
end;

procedure TProdutosModel.SetPESO_LIQUIDO(const Value: Variant);
begin
  FPESO_LIQUIDO := Value;
end;
procedure TProdutosModel.SetPESO_PRO(const Value: Variant);
begin
  FPESO_PRO := Value;
end;
procedure TProdutosModel.SetPESQUISA(const Value: Variant);
begin
  FPESQUISA := Value;
end;
procedure TProdutosModel.SetPMC_PRO(const Value: Variant);
begin
  FPMC_PRO := Value;
end;
procedure TProdutosModel.SetPORCENTAGEM_NFE(const Value: Variant);
begin
  FPORCENTAGEM_NFE := Value;
end;
procedure TProdutosModel.SetPOS_VENDA_DIAS(const Value: Variant);
begin
  FPOS_VENDA_DIAS := Value;
end;
procedure TProdutosModel.SetPRAZO_MEDIO(const Value: Variant);
begin
  FPRAZO_MEDIO := Value;
end;
procedure TProdutosModel.SetPRECO_DOLAR(const Value: Variant);
begin
  FPRECO_DOLAR := Value;
end;
procedure TProdutosModel.SetPRECO_FABRICANTE(const Value: Variant);
begin
  FPRECO_FABRICANTE := Value;
end;
procedure TProdutosModel.SetPRINCIPIO_ATIVO(const Value: Variant);
begin
  FPRINCIPIO_ATIVO := Value;
end;
procedure TProdutosModel.SetProdutossLista;
begin
  FProdutossLista := Value;
end;
procedure TProdutosModel.SetICMS_PRO(const Value: Variant);
begin
  FICMS_PRO := Value;
end;
procedure TProdutosModel.SetID(const Value: Variant);
begin
  FID := Value;
end;
procedure TProdutosModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;
procedure TProdutosModel.SetPRODUTO_FILHO(const Value: Variant);
begin
  FPRODUTO_FILHO := Value;
end;
procedure TProdutosModel.SetPRODUTO_FINAL(const Value: Variant);
begin
  FPRODUTO_FINAL := Value;
end;
procedure TProdutosModel.SetPRODUTO_MODELO(const Value: Variant);
begin
  FPRODUTO_MODELO := Value;
end;
procedure TProdutosModel.SetPRODUTO_NFE(const Value: Variant);
begin
  FPRODUTO_NFE := Value;
end;
procedure TProdutosModel.SetPRODUTO_ORIGEM(const Value: Variant);
begin
  FPRODUTO_ORIGEM := Value;
end;
procedure TProdutosModel.SetPRODUTO_PAI(const Value: Variant);
begin
  FPRODUTO_PAI := Value;
end;
procedure TProdutosModel.SetPRODUTO_REFERENTE(const Value: Variant);
begin
  FPRODUTO_REFERENTE := Value;
end;
procedure TProdutosModel.SetPROFUNDIDADE_M(const Value: Variant);
begin
  FPROFUNDIDADE_M := Value;
end;
procedure TProdutosModel.SetPROPRIEDADE(const Value: Variant);
begin
  FPROPRIEDADE := Value;
end;
procedure TProdutosModel.SetQTDEDIAS_PRO(const Value: Variant);
begin
  FQTDEDIAS_PRO := Value;
end;
procedure TProdutosModel.SetQTDE_PRODUZIR(const Value: Variant);
begin
  FQTDE_PRODUZIR := Value;
end;
procedure TProdutosModel.SetQTRIB(const Value: Variant);
begin
  FQTRIB := Value;
end;
procedure TProdutosModel.SetQUANT_BARRA_USADAS(const Value: Variant);
begin
  FQUANT_BARRA_USADAS := Value;
end;
procedure TProdutosModel.SetQUANT_PECA_BARRA(const Value: Variant);
begin
  FQUANT_PECA_BARRA := Value;
end;
procedure TProdutosModel.SetQUANT_PECA_HORA(const Value: Variant);
begin
  FQUANT_PECA_HORA := Value;
end;
procedure TProdutosModel.SetQUTDE_MAXIMA(const Value: Variant);
begin
  FQUTDE_MAXIMA := Value;
end;
procedure TProdutosModel.SetRECEITA(const Value: Variant);
begin
  FRECEITA := Value;
end;
procedure TProdutosModel.SetREFERENCIA_NEW(const Value: Variant);
begin
  FREFERENCIA_NEW := Value;
end;
procedure TProdutosModel.SetROSQUEADEIRA(const Value: Variant);
begin
  FROSQUEADEIRA := Value;
end;
procedure TProdutosModel.SetIMAGEM(const Value: Variant);
begin
  FIMAGEM := Value;
end;
procedure TProdutosModel.SetIMAGEM_PRO(const Value: Variant);
begin
  FIMAGEM_PRO := Value;
end;
procedure TProdutosModel.SetIMAGEM_TECNICA(const Value: Variant);
begin
  FIMAGEM_TECNICA := Value;
end;
procedure TProdutosModel.SetIMPRESSAO_BALCAO(const Value: Variant);
begin
  FIMPRESSAO_BALCAO := Value;
end;
procedure TProdutosModel.SetIMPRESSAO_COZINHA(const Value: Variant);
begin
  FIMPRESSAO_COZINHA := Value;
end;
procedure TProdutosModel.SetINDESCALA(const Value: Variant);
begin
  FINDESCALA := Value;
end;
procedure TProdutosModel.SetIPI_CENQ(const Value: Variant);
begin
  FIPI_CENQ := Value;
end;
procedure TProdutosModel.SetIPI_PRO(const Value: Variant);
begin
  FIPI_PRO := Value;
end;
procedure TProdutosModel.SetIPI_SAI(const Value: Variant);
begin
  FIPI_SAI := Value;
end;
procedure TProdutosModel.SetLARGURA_M(const Value: Variant);
begin
  FLARGURA_M := Value;
end;
procedure TProdutosModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;
procedure TProdutosModel.SetLINK(const Value: Variant);
begin
  FLINK := Value;
end;
procedure TProdutosModel.SetLISTA(const Value: Variant);
begin
  FLISTA := Value;
end;
procedure TProdutosModel.SetLISTAR_PRODUCAO(const Value: Variant);
begin
  FLISTAR_PRODUCAO := Value;
end;
procedure TProdutosModel.SetLISTAR_ROMANEIO(const Value: Variant);
begin
  FLISTAR_ROMANEIO := Value;
end;
procedure TProdutosModel.SetLOCALIZACAO(const Value: Variant);
begin
  FLOCALIZACAO := Value;
end;
procedure TProdutosModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;
procedure TProdutosModel.SetLW(const Value: Variant);
begin
  FLW := Value;
end;
procedure TProdutosModel.SetM3(const Value: Variant);
begin
  FM3 := Value;
end;
procedure TProdutosModel.SetMARCA_PRO(const Value: Variant);
begin
  FMARCA_PRO := Value;
end;
procedure TProdutosModel.SetMARGEM_CALCULADA(const Value: Variant);
begin
  FMARGEM_CALCULADA := Value;
end;

procedure TProdutosModel.SetMARGEM_LUCRO(const Value: Variant);
begin
  FMARGEM_LUCRO := Value;
end;
procedure TProdutosModel.SetMARGEM_PRAZO(const Value: Variant);
begin
  FMARGEM_PRAZO := Value;
end;
procedure TProdutosModel.SetMARGEM_PRO(const Value: Variant);
begin
  FMARGEM_PRO := Value;
end;
procedure TProdutosModel.SetMARGEM_PROMOCAO(const Value: Variant);
begin
  FMARGEM_PROMOCAO := Value;
end;
procedure TProdutosModel.SetMATERIAL(const Value: Variant);
begin
  FMATERIAL := Value;
end;
procedure TProdutosModel.SetMEDIA_SUGESTAO(const Value: Variant);
begin
  FMEDIA_SUGESTAO := Value;
end;
procedure TProdutosModel.SetMETROSBARRAS_PRO(const Value: Variant);
begin
  FMETROSBARRAS_PRO := Value;
end;
procedure TProdutosModel.SetMODELO(const Value: Variant);
begin
  FMODELO := Value;
end;
procedure TProdutosModel.SetMONTAGEM(const Value: Variant);
begin
  FMONTAGEM := Value;
end;
procedure TProdutosModel.SetMULTIPLICADOR(const Value: Variant);
begin
  FMULTIPLICADOR := Value;
end;
procedure TProdutosModel.SetMULTIPLOS(const Value: Variant);
begin
  FMULTIPLOS := Value;
end;
procedure TProdutosModel.SetNFCE_CFOP(const Value: Variant);
begin
  FNFCE_CFOP := Value;
end;
procedure TProdutosModel.SetNFCE_CSOSN(const Value: Variant);
begin
  FNFCE_CSOSN := Value;
end;
procedure TProdutosModel.SetNFCE_CST(const Value: Variant);
begin
  FNFCE_CST := Value;
end;
procedure TProdutosModel.SetNFCE_ICMS(const Value: Variant);
begin
  FNFCE_ICMS := Value;
end;
procedure TProdutosModel.SetNFE_INTEIRO(const Value: Variant);
begin
  FNFE_INTEIRO := Value;
end;
procedure TProdutosModel.SetNOME_FOR(const Value: Variant);
begin
  FNOME_FOR := Value;
end;

procedure TProdutosModel.SetNOME_GRU(const Value: Variant);
begin
  FNOME_GRU := Value;
end;

procedure TProdutosModel.SetNOME_MAR(const Value: Variant);
begin
  FNOME_MAR := Value;
end;

procedure TProdutosModel.SetNOME_PRO(const Value: Variant);
begin
  FNOME_PRO := Value;
end;
procedure TProdutosModel.SetNOME_RESUMIDO(const Value: Variant);
begin
  FNOME_RESUMIDO := Value;
end;
procedure TProdutosModel.SetNOME_SUB(const Value: Variant);
begin
  FNOME_SUB := Value;
end;

procedure TProdutosModel.SetNOVIDADE_PRO(const Value: Variant);
begin
  FNOVIDADE_PRO := Value;
end;
procedure TProdutosModel.SetOBS_GERAL(const Value: Variant);
begin
  FOBS_GERAL := Value;
end;
procedure TProdutosModel.SetOBS_NF(const Value: Variant);
begin
  FOBS_NF := Value;
end;
procedure TProdutosModel.SetOH(const Value: Variant);
begin
  FOH := Value;
end;
procedure TProdutosModel.SetORDEM(const Value: Variant);
begin
  FORDEM := Value;
end;
procedure TProdutosModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;
procedure TProdutosModel.SetSALDO(const Value: Variant);
begin
  FSALDO := Value;
end;
procedure TProdutosModel.SetSALDOMIN_PRO(const Value: Variant);
begin
  FSALDOMIN_PRO := Value;
end;
procedure TProdutosModel.SetSALDO_CD(const Value: Variant);
begin
  FSALDO_CD := Value;
end;

procedure TProdutosModel.SetSALDO_DISPONIVEL(const Value: Variant);
begin
  FSALDO_DISPONIVEL := Value;
end;

procedure TProdutosModel.SetSALDO_ONLINE(const Value: Variant);
begin
  FSALDO_ONLINE := Value;
end;
procedure TProdutosModel.SetSALDO_PRO(const Value: Variant);
begin
  FSALDO_PRO := Value;
end;
procedure TProdutosModel.SetSERRA(const Value: Variant);
begin
  FSERRA := Value;
end;
procedure TProdutosModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TProdutosModel.SetSTATUS_LINHA(const Value: Variant);
begin
  FSTATUS_LINHA := Value;
end;
procedure TProdutosModel.SetSTATUS_PRO(const Value: Variant);
begin
  FSTATUS_PRO := Value;
end;
procedure TProdutosModel.SetSUBLIMACAO(const Value: Variant);
begin
  FSUBLIMACAO := Value;
end;
procedure TProdutosModel.SetSUGESTAO_COMPRA(const Value: Variant);
begin
  FSUGESTAO_COMPRA := Value;
end;
procedure TProdutosModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;
procedure TProdutosModel.SetTABELA_VENDA(const Value: Variant);
begin
  FTABELA_VENDA := Value;
end;
procedure TProdutosModel.SetTABICMS_PRO(const Value: Variant);
begin
  FTABICMS_PRO := Value;
end;
procedure TProdutosModel.SetTEMPERA(const Value: Variant);
begin
  FTEMPERA := Value;
end;
procedure TProdutosModel.SetTH(const Value: Variant);
begin
  FTH := Value;
end;
procedure TProdutosModel.SetTIPO_CONSERVADORA(const Value: Variant);
begin
  FTIPO_CONSERVADORA := Value;
end;
procedure TProdutosModel.SetTIPO_ID(const Value: Variant);
begin
  FTIPO_ID := Value;
end;
procedure TProdutosModel.SetTIPO_ITEM(const Value: Variant);
begin
  FTIPO_ITEM := Value;
end;
procedure TProdutosModel.SetTIPO_NOME(const Value: Variant);
begin
  FTIPO_NOME := Value;
end;

procedure TProdutosModel.SetTIPO_PRO(const Value: Variant);
begin
  FTIPO_PRO := Value;
end;
procedure TProdutosModel.SetTIPO_VENDA_COMISSAO_ID(const Value: Variant);
begin
  FTIPO_VENDA_COMISSAO_ID := Value;
end;
procedure TProdutosModel.SetTIPO__PRO(const Value: Variant);
begin
  FTIPO__PRO := Value;
end;
procedure TProdutosModel.SetTORNO(const Value: Variant);
begin
  FTORNO := Value;
end;
procedure TProdutosModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TProdutosModel.SetTW(const Value: Variant);
begin
  FTW := Value;
end;
procedure TProdutosModel.SetULTIMAVENDA_PRO(const Value: Variant);
begin
  FULTIMAVENDA_PRO := Value;
end;
procedure TProdutosModel.SetULTIMA_ALTERACAO_PRO(const Value: Variant);
begin
  FULTIMA_ALTERACAO_PRO := Value;
end;
procedure TProdutosModel.SetUNIDADE_ENTRADA(const Value: Variant);
begin
  FUNIDADE_ENTRADA := Value;
end;
procedure TProdutosModel.SetUNIDADE_PRO(const Value: Variant);
begin
  FUNIDADE_PRO := Value;
end;
procedure TProdutosModel.SetUSAR_BALANCA(const Value: Variant);
begin
  FUSAR_BALANCA := Value;
end;
procedure TProdutosModel.SetUSAR_CONTROLE_KG(const Value: Variant);
begin
  FUSAR_CONTROLE_KG := Value;
end;
procedure TProdutosModel.SetUSAR_INSC_ST(const Value: Variant);
begin
  FUSAR_INSC_ST := Value;
end;
procedure TProdutosModel.SetUSAR_PARTES(const Value: Variant);
begin
  FUSAR_PARTES := Value;
end;
procedure TProdutosModel.SetUSUARIO_PRO(const Value: Variant);
begin
  FUSUARIO_PRO := Value;
end;
procedure TProdutosModel.SetUTRIB(const Value: Variant);
begin
  FUTRIB := Value;
end;
procedure TProdutosModel.SetUUID(const Value: Variant);
begin
  FUUID := Value;
end;
procedure TProdutosModel.SetUUIDALTERACAO(const Value: Variant);
begin
  FUUIDALTERACAO := Value;
end;
procedure TProdutosModel.SetVALIDADE(const Value: Variant);
begin
  FVALIDADE := Value;
end;
procedure TProdutosModel.SetVALIDADE_PRO(const Value: Variant);
begin
  FVALIDADE_PRO := Value;
end;
procedure TProdutosModel.SetVALIDAR_CAIXA(const Value: Variant);
begin
  FVALIDAR_CAIXA := Value;
end;
procedure TProdutosModel.SetVALIDAR_LOTE(const Value: Variant);
begin
  FVALIDAR_LOTE := Value;
end;
procedure TProdutosModel.SetVALORDOLAR_PRO(const Value: Variant);
begin
  FVALORDOLAR_PRO := Value;
end;
procedure TProdutosModel.SetVALOR_BONUS_SERVICO(const Value: Variant);
begin
  FVALOR_BONUS_SERVICO := Value;
end;
procedure TProdutosModel.SetVALOR_ICMS_SUBSTITUTO(const Value: Variant);
begin
  FVALOR_ICMS_SUBSTITUTO := Value;
end;
procedure TProdutosModel.SetVALOR_MONTADOR(const Value: Variant);
begin
  FVALOR_MONTADOR := Value;
end;
procedure TProdutosModel.SetVALOR_MP(const Value: Variant);
begin
  FVALOR_MP := Value;
end;
procedure TProdutosModel.SetVALOR_TERCERIZADOS(const Value: Variant);
begin
  FVALOR_TERCERIZADOS := Value;
end;
procedure TProdutosModel.SetVALOR_VENDA_MAXIMO(const Value: Variant);
begin
  FVALOR_VENDA_MAXIMO := Value;
end;
procedure TProdutosModel.SetVALOR_VENDA_MINIMO(const Value: Variant);
begin
  FVALOR_VENDA_MINIMO := Value;
end;
procedure TProdutosModel.SetVENDAMINIMA_PRO(const Value: Variant);
begin
  FVENDAMINIMA_PRO := Value;
end;
procedure TProdutosModel.SetVENDAPRAZO_PRO(const Value: Variant);
begin
  FVENDAPRAZO_PRO := Value;
end;
procedure TProdutosModel.SetVENDAPROMOCAO_PRO(const Value: Variant);
begin
  FVENDAPROMOCAO_PRO := Value;
end;
procedure TProdutosModel.SetVENDAWEB_PRO(const Value: Variant);
begin
  FVENDAWEB_PRO := Value;
end;
procedure TProdutosModel.SetVENDA_COM_DESCONTO(const Value: Variant);
begin
  FVENDA_COM_DESCONTO := Value;
end;
procedure TProdutosModel.SetVENDA_PRO(const Value: Variant);
begin
  FVENDA_PRO := Value;
end;
procedure TProdutosModel.SetVENDA_WEB(const Value: Variant);
begin
  FVENDA_WEB := Value;
end;
procedure TProdutosModel.SetVOLTAGEM(const Value: Variant);
begin
  FVOLTAGEM := Value;
end;
procedure TProdutosModel.SetVOLTAGEM_ID(const Value: Variant);
begin
  FVOLTAGEM_ID := Value;
end;

procedure TProdutosModel.SetVOLUME_QTDE(const Value: Variant);
begin
  FVOLUME_QTDE := Value;
end;
procedure TProdutosModel.SetVPMC(const Value: Variant);
begin
  FVPMC := Value;
end;
procedure TProdutosModel.SetWEB_ALTURA(const Value: Variant);
begin
  FWEB_ALTURA := Value;
end;
procedure TProdutosModel.SetWEB_CARACTERISTICA(const Value: Variant);
begin
  FWEB_CARACTERISTICA := Value;
end;
procedure TProdutosModel.SetWEB_CATEGORIAS(const Value: Variant);
begin
  FWEB_CATEGORIAS := Value;
end;
procedure TProdutosModel.SetWEB_CODIGO_INTEGRACAO(const Value: Variant);
begin
  FWEB_CODIGO_INTEGRACAO := Value;
end;
procedure TProdutosModel.SetWEB_CODIGO_INTEGRACAO_MASTER(const Value: Variant);
begin
  FWEB_CODIGO_INTEGRACAO_MASTER := Value;
end;
procedure TProdutosModel.SetWEB_COR(const Value: Variant);
begin
  FWEB_COR := Value;
end;
procedure TProdutosModel.SetWEB_DESCONTO(const Value: Variant);
begin
  FWEB_DESCONTO := Value;
end;
procedure TProdutosModel.SetWEB_GERENCIA_ESTOQUE(const Value: Variant);
begin
  FWEB_GERENCIA_ESTOQUE := Value;
end;
procedure TProdutosModel.SetWEB_GERENCIA_IMAGENS(const Value: Variant);
begin
  FWEB_GERENCIA_IMAGENS := Value;
end;
procedure TProdutosModel.SetWEB_GERENCIA_PRECO_VENDA(const Value: Variant);
begin
  FWEB_GERENCIA_PRECO_VENDA := Value;
end;
procedure TProdutosModel.SetWEB_ID(const Value: Variant);
begin
  FWEB_ID := Value;
end;
procedure TProdutosModel.SetWEB_INTEGRA(const Value: Variant);
begin
  FWEB_INTEGRA := Value;
end;
procedure TProdutosModel.SetWEB_LARGURA(const Value: Variant);
begin
  FWEB_LARGURA := Value;
end;
procedure TProdutosModel.SetWEB_NOME_PRO(const Value: Variant);
begin
  FWEB_NOME_PRO := Value;
end;
procedure TProdutosModel.SetWEB_PALAVRA_CHAVE(const Value: Variant);
begin
  FWEB_PALAVRA_CHAVE := Value;
end;
procedure TProdutosModel.SetWEB_PESO(const Value: Variant);
begin
  FWEB_PESO := Value;
end;
procedure TProdutosModel.SetWEB_PRECO_PROMOCAO(const Value: Variant);
begin
  FWEB_PRECO_PROMOCAO := Value;
end;
procedure TProdutosModel.SetWEB_PRECO_VENDA(const Value: Variant);
begin
  FWEB_PRECO_VENDA := Value;
end;
procedure TProdutosModel.SetWEB_PROFUNDIDADE(const Value: Variant);
begin
  FWEB_PROFUNDIDADE := Value;
end;
procedure TProdutosModel.SetWEB_RESUMO(const Value: Variant);
begin
  FWEB_RESUMO := Value;
end;
procedure TProdutosModel.SetWEB_TAMANHO(const Value: Variant);
begin
  FWEB_TAMANHO := Value;
end;
procedure TProdutosModel.SetWEB_TIPO_PRODUTO(const Value: Variant);
begin
  FWEB_TIPO_PRODUTO := Value;
end;
procedure TProdutosModel.SetWEB_URL(const Value: Variant);
begin
  FWEB_URL := Value;
end;
procedure TProdutosModel.SetWEB_URL_IMAGENS(const Value: Variant);
begin
  FWEB_URL_IMAGENS := Value;
end;
procedure TProdutosModel.SetWEB_VARIACAO(const Value: Variant);
begin
  FWEB_VARIACAO := Value;
end;
procedure TProdutosModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
procedure TProdutosModel.SetXMOTIVOISENCAO(const Value: Variant);
begin
  FXMOTIVOISENCAO := Value;
end;
procedure TProdutosModel.subtrairSaldo(pIdProduto: String; pSaldo: Double);
var
  lProdutoDao: ITProdutosDao;
begin
  lProdutoDao := TProdutosDao.getNewIface(vIConexao);
  try
    lProdutoDao.objeto.subtrairSaldo(pIdProduto, pSaldo);
  finally
    lProdutoDao:=nil;
  end;
end;

function TProdutosModel.ValorGarantia(pProduto: String; pValorFaixa: Double): TProdutoGarantia;
var
  lProdutoDao: ITProdutosDao;
begin
  lProdutoDao := TProdutosDao.getNewIface(vIConexao);
  try
     Result :=  lProdutoDao.objeto.ValorGarantia(pProduto, pValorFaixa);
  finally
    lProdutoDao:=nil;
  end;
end;


function TProdutosModel.ValorUnitario(pProdutoPreco: TProdutoPreco): Double;
var
  lClienteModel           : TClienteModel;
  lPrecoUFModel           : ITPrecoUFModel;
  lPromocaoItensModel     : ITPromocaoItensModel;
  lProdutosModel          : ITProdutosModel;
  lCondicaoPromocao,
  lDia                    : String;
  lPrecoVendaModel        : ITPrecoVendaModel;
  lPrecoVendaProdutoModel : ITPrecoVendaProdutoModel;
  lPrecoClienteModel      : ITPrecoClienteModel;
begin
  lClienteModel           := TClienteModel.Create(vIConexao);
  lPrecoUFModel           := TPrecoUFModel.getNewIface(vIConexao);
  lPromocaoItensModel     := TPromocaoItensModel.getNewIface(vIConexao);
  lPrecoVendaModel        := TPrecoVendaModel.getNewIface(vIConexao);
  lPrecoVendaProdutoModel := TPrecoVendaProdutoModel.getNewIface(vIConexao);
  lProdutosModel          := TProdutosModel.getNewIface(vIConexao);
  lPrecoClienteModel      := TPrecoClienteModel.getNewIface(vIConexao);
  try

    if pProdutoPreco.PrecoUf then
    begin
      lPrecoUFModel.objeto.WhereView := ' and preco_uf.uf = ' + QuotedStr(lClienteModel.ufCliente(pProdutoPreco.Cliente)) + ' and preco_uf.produto_id = '+ QuotedStr(pProdutoPreco.Produto);
      lPrecoUFModel.objeto.obterLista;
      if lPrecoUFModel.objeto.TotalRecords > 0 then
      begin
        if lPrecoUFModel.objeto.PrecoUFsLista.First.objeto.TOTAL > 0 then
        begin
          Result := lPrecoUFModel.objeto.PrecoUFsLista.First.objeto.TOTAL;
          exit;
        end;
      end;
    end;

    if pProdutoPreco.Promocao then
    begin
      lDia := DiadaSemana(vIConexao.DataServer);

      lCondicaoPromocao := '  and promocaoitens.produto_id = '+QuotedStr(pProdutoPreco.Produto) +
                           '  and current_date between promocao.datainicio and promocao.datafim '+
                           '  and current_time between promocao.horainicio and promocao.horafim'+
                           '  and promocao.'+lDia+' = ''S'' ';

      if pProdutoPreco.Portador <> '' then
        lCondicaoPromocao := lCondicaoPromocao + ' and ((promocao.portador_id is null) or (promocao.portador_id = '+QuotedStr(pProdutoPreco.Portador)+'))';
      if pProdutoPreco.PrecoVenda <> '' then
        lCondicaoPromocao := lCondicaoPromocao + ' and ((promocao.preco_venda_id is null) or (promocao.preco_venda_id = '+QuotedStr(pProdutoPreco.PrecoVenda)+'))';
      if pProdutoPreco.Cliente <> '' then
        lCondicaoPromocao := lCondicaoPromocao + ' and ((promocao.cliente_id is null) or (promocao.cliente_id = '+QuotedStr(pProdutoPreco.Cliente)+'))';
      if pProdutoPreco.Loja <> '' then
        lCondicaoPromocao := lCondicaoPromocao + ' and ((promocao.loja = '+QuotedStr(pProdutoPreco.Loja)+') or (promocao.loja is null)) ';

      lPromocaoItensModel.objeto.WhereView := lCondicaoPromocao;
      lPromocaoItensModel.objeto.obterLista;

      if lPromocaoItensModel.objeto.TotalRecords > 0 then
      begin
        Result := lPromocaoItensModel.objeto.PromocaoItenssLista.First.objeto.valor_promocao;
        exit;
      end;
    end;

    if pProdutoPreco.PrecoCliente then
    begin
      lPrecoClienteModel.objeto.WhereView := ' and preco_cliente.cliente = '+ QuotedStr(pProdutoPreco.Cliente) + ' and preco_cliente.produto = '+ QuotedStr(pProdutoPreco.Produto);
      lPrecoClienteModel.objeto.obterLista;

      if lPrecoClienteModel.objeto.TotalRecords > 0 then
      begin
        if lPrecoClienteModel.objeto.PrecoClientesLista.First.objeto.VALOR > 0 then
        begin
          Result := lPrecoClienteModel.objeto.PrecoClientesLista.First.objeto.VALOR;
          exit;
        end;
      end;
    end;

    if pProdutoPreco.TabelaPreco then
    begin
      lClienteModel := lClienteModel.carregaClasse(pProdutoPreco.Cliente);
      if lClienteModel.preco_id <> '' then
      begin
        lPrecoVendaModel.objeto.WhereView := ' and id = '+ QuotedStr(lClienteModel.preco_id);
        lPrecoVendaModel.objeto.obterLista;
      end;
      if pProdutoPreco.PrecoVenda <> '' then
      begin
        lPrecoVendaModel.objeto.WhereView := ' and id = '+ QuotedStr(pProdutoPreco.PrecoVenda);
        lPrecoVendaModel.objeto.obterLista;
      end;
      if lPrecoVendaModel.objeto.TotalRecords > 0  then
      begin
        if lPrecoVendaModel.objeto.PrecoVendasLista[0].objeto.PRODUTOS_IGNORAR <> 'I' then
        begin
          lPrecoVendaProdutoModel.objeto.WhereView := ' and preco_venda_id = ' + QuotedStr(lPrecoVendaModel.objeto.PrecoVendasLista[0].objeto.ID) + ' and produto_id = ' + QuotedStr(pProdutoPreco.Produto);
          lPrecoVendaProdutoModel.objeto.obterLista;
          if lPrecoVendaProdutoModel.objeto.TotalRecords = 0 then
          begin
            if lPrecoVendaModel.objeto.PrecoVendasLista[0].objeto.PERCENTUAL > 0 then
            begin
              if lPrecoVendaModel.objeto.PrecoVendasLista[0].objeto.ACRESCIMO_DESCONTO = 'C' then
              begin
                Result := lProdutosModel.objeto.ProdutossLista.First.objeto.CUSTOMEDIO_PRO + (lProdutosModel.objeto.ProdutossLista.First.objeto.CUSTOMEDIO_PRO * (lPrecoVendaModel.objeto.PrecoVendasLista[0].objeto.PERCENTUAL / 100));
                exit;
              end
              else if lPrecoVendaModel.objeto.PrecoVendasLista[0].objeto.ACRESCIMO_DESCONTO = 'A' then
              begin
                Result := lProdutosModel.objeto.ProdutossLista.First.objeto.VENDA_PRO + (lProdutosModel.objeto.ProdutossLista.First.objeto.VENDA_PRO * (lPrecoVendaModel.objeto.PrecoVendasLista[0].objeto.PERCENTUAL / 100));
                exit;
              end
              else
              begin
                Result := lProdutosModel.objeto.ProdutossLista.First.objeto.VENDA_PRO - (lProdutosModel.objeto.ProdutossLista.First.objeto.VENDA_PRO * (lPrecoVendaModel.objeto.PrecoVendasLista[0].objeto.PERCENTUAL / 100));
                exit;
              end;
            end;
          end;
        end;
      end;
    end;

    Result := lProdutosModel.objeto.valorVenda(pProdutoPreco.Produto);

  finally
    lPrecoVendaProdutoModel:=nil;
    lPromocaoItensModel:=nil;
    lPrecoClienteModel:=nil;
    lPrecoVendaModel:=nil;
    lProdutosModel:=nil;
    lClienteModel.Free;
    lPrecoUFModel:=nil;
  end;
end;

function TProdutosModel.valorVenda(pIdProduto: String): Variant;
var
  lProdutoDao: ITProdutosDao;
begin
  lProdutoDao := TProdutosDao.getNewIface(vIConexao);
  try
    Result := lProdutoDao.objeto.valorVenda(pIdProduto);
    if Result = Null then
      Result := 0;

  finally
    lProdutoDao:=nil;
  end;
end;

procedure TProdutosModel.verificarCustoMedio;
begin
  if self.CUSTOMEDIO_PRO = '' then
    self.CUSTOMEDIO_PRO := self.CUSTOULTIMO_PRO;
end;

end.
