unit PedidoVendaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.FuncoesTexto,
  Terasoft.Utils,
  PedidoItensModel,
  Interfaces.Conexao;

type
  TVenderItem = record
    BarrasProduto: String;
    Quantidade: Double;
    PrecoUf,
    Promocao,
    PrecoCliente,
    TabelaPreco : Boolean
  end;

  TPedidoVendaModel = class
  private

    vIConexao : IConexao;

    FPedidoVendasLista: TObjectList<TPedidoVendaModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FENTRADA_PORTADOR_ID: Variant;
    FVFCPUFDEST: Variant;
    FENTREGA_OBSERVACAO: Variant;
    FCTR_EXPORTACAO: Variant;
    FENTREGA_REGIAO_ID: Variant;
    FTIPO_COMISSAO: Variant;
    FVICMSUFREMET: Variant;
    FENTREGA_BAIRRO: Variant;
    FCARGA_ID: Variant;
    FGERENTE_TIPO_COMISSAO: Variant;
    FPATRIMONIO_OBSERVACAO: Variant;
    FENTREGA_HORA: Variant;
    FUF_TRANSPORTADORA: Variant;
    FFRETE_PED: Variant;
    FUSUARIO_PED: Variant;
    FDESC_PED: Variant;
    FREGIAO_ID: Variant;
    FPRECO_VENDA_ID: Variant;
    FTIPO_PED: Variant;
    FMONTAGEM_DATA: Variant;
    FENTREGA_UF: Variant;
    FTABJUROS_PED: Variant;
    FDATA_PED: Variant;
    FIMP_TICKET: Variant;
    FPEDIDO_COMPRA: Variant;
    FDESCONTO_DRG: Variant;
    FPARCELA_PED: Variant;
    FNUMERO_ORC: Variant;
    FVALOR_RESTITUICAO: Variant;
    FLOCAL_PED: Variant;
    FENTREGA: Variant;
    FPESO_LIQUIDO: Variant;
    FTELEVENDA_PED: Variant;
    FLOTE_CARGA_ID: Variant;
    FARQUITETO_ID: Variant;
    FCONDICOES2_PAG: Variant;
    FENTREGUE: Variant;
    FLISTA_NOIVA_ID: Variant;
    FVALOR_SUFRAMA: Variant;
    FTIPO_FRETE: Variant;
    FPESO_PED: Variant;
    FDESCONTO_PED: Variant;
    FCODIGO_VEN: Variant;
    FFORM: Variant;
    FPOS_VENDA: Variant;
    FARQUIVO_XML_NF: Variant;
    FENTREGA_CEP: Variant;
    FVALOR_DESPESA_VENDA: Variant;
    FCNPJ_CPF_CONSUMIDOR: Variant;
    FVALOR_PAGO: Variant;
    FNAO_FISCAL_ABERTO: Variant;
    FTOTAL2_PED: Variant;
    FENTREGA_NUMERO: Variant;
    FARQUITETO_COMISSAO: Variant;
    FVALOR_PED: Variant;
    FMONTAGEM_HORA: Variant;
    FVLR_GARANTIA: Variant;
    FCHAVE_XML_NF: Variant;
    FHORA_PED: Variant;
    FCODIGO_CLI: Variant;
    FWEB_PEDIDO_ID: Variant;
    FESPECIE_VOLUME: Variant;
    FID: Variant;
    FTOTAL1_PED: Variant;
    FGERENTE_ID: Variant;
    FCTR_IMPRESSAO_ITENS: Variant;
    FINDCE_PED: Variant;
    FCODIGO_PORT: Variant;
    FCTR_ENVIO_NFE: Variant;
    FDATAHORA_IMPRESSO: Variant;
    FNUMERO_NF: Variant;
    FSTATUS: Variant;
    FLOJA: Variant;
    FENTREGA_COMPLEMENTO: Variant;
    FCONDICOES_PAG: Variant;
    FCFOP_ID: Variant;
    FDATAHORA_RETIRADA: Variant;
    FFATURA_ID: Variant;
    FENTREGADOR_ID: Variant;
    FENTREGA_CONTATO: Variant;
    FPESO_BRUTO: Variant;
    FDATA_FATURADO: Variant;
    FCTR_ENVIO_BOLETO: Variant;
    FVALOR_TAXA_SERVICO: Variant;
    FSTATUS_ID: Variant;
    FSYSTIME: Variant;
    FINFORMACOES_PED: Variant;
    FTOTAL_PED: Variant;
    FLACA_OU_GLASS: Variant;
    FCOMANDA: Variant;
    FSMS: Variant;
    FRNTRC: Variant;
    FVALOR_IPI: Variant;
    FPARCELAS2_PED: Variant;
    FPRIMEIROVENC2_PED: Variant;
    FOBS_GERAL: Variant;
    FNUMERO_CF: Variant;
    FDOLAR: Variant;
    FACRES_PED: Variant;
    FCODIGO_TIP: Variant;
    FRESERVADO: Variant;
    FNUMERO_SENHA: Variant;
    FPRODUCAO_ID: Variant;
    FNUMERO_PED: Variant;
    FENTREGA_CIDADE: Variant;
    FQTDEITENS: Variant;
    FENTREGA_ENDERECO: Variant;
    FPLACA: Variant;
    FSTATUS_PED: Variant;
    FDATA_COTACAO: Variant;
    FPEDIDO_VIDRACARIA: Variant;
    FENTREGA_TELEFONE: Variant;
    FVFCPST: Variant;
    FVICMSUFDEST: Variant;
    FENTREGA_CELULAR: Variant;
    FENTREGA_COD_MUNICIPIO: Variant;
    FORDEM: Variant;
    FQTDE_VOLUME: Variant;
    FCTR_IMPRESSAO_PED: Variant;
    FVALORENTADA_PED: Variant;
    FCTR_ENVIO_PEDIDO: Variant;
    FVICMSDESON: Variant;
    FDATA_FINALIZADO: Variant;
    FDATAHORA_COLETA: Variant;
    FZERAR_ST: Variant;
    FENTREGA_AGENDA_ID: Variant;
    FCF_ABERTO: Variant;
    FINDICACAO_ID: Variant;
    FCONTATO_PED: Variant;
    FPARCELAS_PED: Variant;
    FPRIMEIROVENC_PED: Variant;
    FIDRecordView: String;
    FFANTASIA_CLI: Variant;
    FBAIRRO_CLI: Variant;
    FUF_CLI: Variant;
    FENDERECO: Variant;
    FCIDADE_CLI: Variant;
    FCNPJ_CPF_CLI: Variant;
    FIDUsuario: String;
    FCODIGO_PRO: Variant;
    FVALORUNITARIO_PED: Variant;
    FQUANTIDADE_PED: Variant;
    FPEDIDOITENS_ID: Variant;
    FCFOP_NF: Variant;
    FNOME_VENDEDOR: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPedidoVendasLista(const Value: TObjectList<TPedidoVendaModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetACRES_PED(const Value: Variant);
    procedure SetARQUITETO_COMISSAO(const Value: Variant);
    procedure SetARQUITETO_ID(const Value: Variant);
    procedure SetARQUIVO_XML_NF(const Value: Variant);
    procedure SetCARGA_ID(const Value: Variant);
    procedure SetCF_ABERTO(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCHAVE_XML_NF(const Value: Variant);
    procedure SetCNPJ_CPF_CONSUMIDOR(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCODIGO_PORT(const Value: Variant);
    procedure SetCODIGO_TIP(const Value: Variant);
    procedure SetCODIGO_VEN(const Value: Variant);
    procedure SetCOMANDA(const Value: Variant);
    procedure SetCONDICOES_PAG(const Value: Variant);
    procedure SetCONDICOES2_PAG(const Value: Variant);
    procedure SetCONTATO_PED(const Value: Variant);
    procedure SetCTR_ENVIO_BOLETO(const Value: Variant);
    procedure SetCTR_ENVIO_NFE(const Value: Variant);
    procedure SetCTR_ENVIO_PEDIDO(const Value: Variant);
    procedure SetCTR_EXPORTACAO(const Value: Variant);
    procedure SetCTR_IMPRESSAO_ITENS(const Value: Variant);
    procedure SetCTR_IMPRESSAO_PED(const Value: Variant);
    procedure SetDATA_COTACAO(const Value: Variant);
    procedure SetDATA_FATURADO(const Value: Variant);
    procedure SetDATA_FINALIZADO(const Value: Variant);
    procedure SetDATA_PED(const Value: Variant);
    procedure SetDATAHORA_COLETA(const Value: Variant);
    procedure SetDATAHORA_IMPRESSO(const Value: Variant);
    procedure SetDATAHORA_RETIRADA(const Value: Variant);
    procedure SetDESC_PED(const Value: Variant);
    procedure SetDESCONTO_DRG(const Value: Variant);
    procedure SetDESCONTO_PED(const Value: Variant);
    procedure SetDOLAR(const Value: Variant);
    procedure SetENTRADA_PORTADOR_ID(const Value: Variant);
    procedure SetENTREGA(const Value: Variant);
    procedure SetENTREGA_AGENDA_ID(const Value: Variant);
    procedure SetENTREGA_BAIRRO(const Value: Variant);
    procedure SetENTREGA_CELULAR(const Value: Variant);
    procedure SetENTREGA_CEP(const Value: Variant);
    procedure SetENTREGA_CIDADE(const Value: Variant);
    procedure SetENTREGA_COD_MUNICIPIO(const Value: Variant);
    procedure SetENTREGA_COMPLEMENTO(const Value: Variant);
    procedure SetENTREGA_CONTATO(const Value: Variant);
    procedure SetENTREGA_ENDERECO(const Value: Variant);
    procedure SetENTREGA_HORA(const Value: Variant);
    procedure SetENTREGA_NUMERO(const Value: Variant);
    procedure SetENTREGA_OBSERVACAO(const Value: Variant);
    procedure SetENTREGA_REGIAO_ID(const Value: Variant);
    procedure SetENTREGA_TELEFONE(const Value: Variant);
    procedure SetENTREGA_UF(const Value: Variant);
    procedure SetENTREGADOR_ID(const Value: Variant);
    procedure SetENTREGUE(const Value: Variant);
    procedure SetESPECIE_VOLUME(const Value: Variant);
    procedure SetFATURA_ID(const Value: Variant);
    procedure SetFORM(const Value: Variant);
    procedure SetFRETE_PED(const Value: Variant);
    procedure SetGERENTE_ID(const Value: Variant);
    procedure SetGERENTE_TIPO_COMISSAO(const Value: Variant);
    procedure SetHORA_PED(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIMP_TICKET(const Value: Variant);
    procedure SetINDCE_PED(const Value: Variant);
    procedure SetINDICACAO_ID(const Value: Variant);
    procedure SetINFORMACOES_PED(const Value: Variant);
    procedure SetLACA_OU_GLASS(const Value: Variant);
    procedure SetLISTA_NOIVA_ID(const Value: Variant);
    procedure SetLOCAL_PED(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLOTE_CARGA_ID(const Value: Variant);
    procedure SetMONTAGEM_DATA(const Value: Variant);
    procedure SetMONTAGEM_HORA(const Value: Variant);
    procedure SetNAO_FISCAL_ABERTO(const Value: Variant);
    procedure SetNUMERO_CF(const Value: Variant);
    procedure SetNUMERO_NF(const Value: Variant);
    procedure SetNUMERO_ORC(const Value: Variant);
    procedure SetNUMERO_PED(const Value: Variant);
    procedure SetNUMERO_SENHA(const Value: Variant);
    procedure SetOBS_GERAL(const Value: Variant);
    procedure SetORDEM(const Value: Variant);
    procedure SetPARCELA_PED(const Value: Variant);
    procedure SetPARCELAS_PED(const Value: Variant);
    procedure SetPARCELAS2_PED(const Value: Variant);
    procedure SetPATRIMONIO_OBSERVACAO(const Value: Variant);
    procedure SetPEDIDO_COMPRA(const Value: Variant);
    procedure SetPEDIDO_VIDRACARIA(const Value: Variant);
    procedure SetPESO_BRUTO(const Value: Variant);
    procedure SetPESO_LIQUIDO(const Value: Variant);
    procedure SetPESO_PED(const Value: Variant);
    procedure SetPLACA(const Value: Variant);
    procedure SetPOS_VENDA(const Value: Variant);
    procedure SetPRECO_VENDA_ID(const Value: Variant);
    procedure SetPRIMEIROVENC_PED(const Value: Variant);
    procedure SetPRIMEIROVENC2_PED(const Value: Variant);
    procedure SetPRODUCAO_ID(const Value: Variant);
    procedure SetQTDE_VOLUME(const Value: Variant);
    procedure SetQTDEITENS(const Value: Variant);
    procedure SetREGIAO_ID(const Value: Variant);
    procedure SetRESERVADO(const Value: Variant);
    procedure SetRNTRC(const Value: Variant);
    procedure SetSMS(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSTATUS_ID(const Value: Variant);
    procedure SetSTATUS_PED(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTABJUROS_PED(const Value: Variant);
    procedure SetTELEVENDA_PED(const Value: Variant);
    procedure SetTIPO_COMISSAO(const Value: Variant);
    procedure SetTIPO_FRETE(const Value: Variant);
    procedure SetTIPO_PED(const Value: Variant);
    procedure SetTOTAL_PED(const Value: Variant);
    procedure SetTOTAL1_PED(const Value: Variant);
    procedure SetTOTAL2_PED(const Value: Variant);
    procedure SetUF_TRANSPORTADORA(const Value: Variant);
    procedure SetUSUARIO_PED(const Value: Variant);
    procedure SetVALOR_DESPESA_VENDA(const Value: Variant);
    procedure SetVALOR_IPI(const Value: Variant);
    procedure SetVALOR_PAGO(const Value: Variant);
    procedure SetVALOR_PED(const Value: Variant);
    procedure SetVALOR_RESTITUICAO(const Value: Variant);
    procedure SetVALOR_SUFRAMA(const Value: Variant);
    procedure SetVALOR_TAXA_SERVICO(const Value: Variant);
    procedure SetVALORENTADA_PED(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetVFCPUFDEST(const Value: Variant);
    procedure SetVICMSDESON(const Value: Variant);
    procedure SetVICMSUFDEST(const Value: Variant);
    procedure SetVICMSUFREMET(const Value: Variant);
    procedure SetVLR_GARANTIA(const Value: Variant);
    procedure SetWEB_PEDIDO_ID(const Value: Variant);
    procedure SetZERAR_ST(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetBAIRRO_CLI(const Value: Variant);
    procedure SetCIDADE_CLI(const Value: Variant);
    procedure SetENDERECO(const Value: Variant);
    procedure SetFANTASIA_CLI(const Value: Variant);
    procedure SetUF_CLI(const Value: Variant);
    procedure SetCNPJ_CPF_CLI(const Value: Variant);
    procedure SetIDUsuario(const Value: String);
    procedure SetCODIGO_PRO(const Value: Variant);
    procedure SetQUANTIDADE_PED(const Value: Variant);
    procedure SetVALORUNITARIO_PED(const Value: Variant);
    procedure SetPEDIDOITENS_ID(const Value: Variant);
    procedure SetCFOP_NF(const Value: Variant);
    procedure SetNOME_VENDEDOR(const Value: Variant);

    procedure getDataVendedor;

  public
    property NUMERO_PED: Variant read FNUMERO_PED write SetNUMERO_PED;
    property CODIGO_CLI: Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property CODIGO_VEN: Variant read FCODIGO_VEN write SetCODIGO_VEN;
    property CODIGO_PORT: Variant read FCODIGO_PORT write SetCODIGO_PORT;
    property CODIGO_TIP: Variant read FCODIGO_TIP write SetCODIGO_TIP;
    property DATA_PED: Variant read FDATA_PED write SetDATA_PED;
    property VALOR_PED: Variant read FVALOR_PED write SetVALOR_PED;
    property DESC_PED: Variant read FDESC_PED write SetDESC_PED;
    property ACRES_PED: Variant read FACRES_PED write SetACRES_PED;
    property TOTAL_PED: Variant read FTOTAL_PED write SetTOTAL_PED;
    property USUARIO_PED: Variant read FUSUARIO_PED write SetUSUARIO_PED;
    property NUMERO_ORC: Variant read FNUMERO_ORC write SetNUMERO_ORC;
    property INFORMACOES_PED: Variant read FINFORMACOES_PED write SetINFORMACOES_PED;
    property TIPO_PED: Variant read FTIPO_PED write SetTIPO_PED;
    property INDCE_PED: Variant read FINDCE_PED write SetINDCE_PED;
    property CFOP_ID: Variant read FCFOP_ID write SetCFOP_ID;
    property PRIMEIROVENC_PED: Variant read FPRIMEIROVENC_PED write SetPRIMEIROVENC_PED;
    property VALORENTADA_PED: Variant read FVALORENTADA_PED write SetVALORENTADA_PED;
    property PARCELAS_PED: Variant read FPARCELAS_PED write SetPARCELAS_PED;
    property PARCELA_PED: Variant read FPARCELA_PED write SetPARCELA_PED;
    property STATUS_PED: Variant read FSTATUS_PED write SetSTATUS_PED;
    property TABJUROS_PED: Variant read FTABJUROS_PED write SetTABJUROS_PED;
    property CONTATO_PED: Variant read FCONTATO_PED write SetCONTATO_PED;
    property DESCONTO_PED: Variant read FDESCONTO_PED write SetDESCONTO_PED;
    property CTR_IMPRESSAO_PED: Variant read FCTR_IMPRESSAO_PED write SetCTR_IMPRESSAO_PED;
    property FRETE_PED: Variant read FFRETE_PED write SetFRETE_PED;
    property CONDICOES_PAG: Variant read FCONDICOES_PAG write SetCONDICOES_PAG;
    property TOTAL1_PED: Variant read FTOTAL1_PED write SetTOTAL1_PED;
    property TOTAL2_PED: Variant read FTOTAL2_PED write SetTOTAL2_PED;
    property LOCAL_PED: Variant read FLOCAL_PED write SetLOCAL_PED;
    property TELEVENDA_PED: Variant read FTELEVENDA_PED write SetTELEVENDA_PED;
    property PESO_PED: Variant read FPESO_PED write SetPESO_PED;
    property PRIMEIROVENC2_PED: Variant read FPRIMEIROVENC2_PED write SetPRIMEIROVENC2_PED;
    property PARCELAS2_PED: Variant read FPARCELAS2_PED write SetPARCELAS2_PED;
    property VALOR_IPI: Variant read FVALOR_IPI write SetVALOR_IPI;
    property CONDICOES2_PAG: Variant read FCONDICOES2_PAG write SetCONDICOES2_PAG;
    property LOJA: Variant read FLOJA write SetLOJA;
    property DOLAR: Variant read FDOLAR write SetDOLAR;
    property CTR_EXPORTACAO: Variant read FCTR_EXPORTACAO write SetCTR_EXPORTACAO;
    property ID: Variant read FID write SetID;
    property NUMERO_CF: Variant read FNUMERO_CF write SetNUMERO_CF;
    property CF_ABERTO: Variant read FCF_ABERTO write SetCF_ABERTO;
    property NAO_FISCAL_ABERTO: Variant read FNAO_FISCAL_ABERTO write SetNAO_FISCAL_ABERTO;
    property HORA_PED: Variant read FHORA_PED write SetHORA_PED;
    property TIPO_FRETE: Variant read FTIPO_FRETE write SetTIPO_FRETE;
    property VALOR_PAGO: Variant read FVALOR_PAGO write SetVALOR_PAGO;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property DATA_FATURADO: Variant read FDATA_FATURADO write SetDATA_FATURADO;
    property NUMERO_NF: Variant read FNUMERO_NF write SetNUMERO_NF;
    property VALOR_SUFRAMA: Variant read FVALOR_SUFRAMA write SetVALOR_SUFRAMA;
    property CARGA_ID: Variant read FCARGA_ID write SetCARGA_ID;
    property LISTA_NOIVA_ID: Variant read FLISTA_NOIVA_ID write SetLISTA_NOIVA_ID;
    property VALOR_RESTITUICAO: Variant read FVALOR_RESTITUICAO write SetVALOR_RESTITUICAO;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property DESCONTO_DRG: Variant read FDESCONTO_DRG write SetDESCONTO_DRG;
    property STATUS_ID: Variant read FSTATUS_ID write SetSTATUS_ID;
    property PRECO_VENDA_ID: Variant read FPRECO_VENDA_ID write SetPRECO_VENDA_ID;
    property RNTRC: Variant read FRNTRC write SetRNTRC;
    property PLACA: Variant read FPLACA write SetPLACA;
    property PESO_LIQUIDO: Variant read FPESO_LIQUIDO write SetPESO_LIQUIDO;
    property PESO_BRUTO: Variant read FPESO_BRUTO write SetPESO_BRUTO;
    property QTDE_VOLUME: Variant read FQTDE_VOLUME write SetQTDE_VOLUME;
    property ESPECIE_VOLUME: Variant read FESPECIE_VOLUME write SetESPECIE_VOLUME;
    property UF_TRANSPORTADORA: Variant read FUF_TRANSPORTADORA write SetUF_TRANSPORTADORA;
    property PRODUCAO_ID: Variant read FPRODUCAO_ID write SetPRODUCAO_ID;
    property REGIAO_ID: Variant read FREGIAO_ID write SetREGIAO_ID;
    property ORDEM: Variant read FORDEM write SetORDEM;
    property CNPJ_CPF_CONSUMIDOR: Variant read FCNPJ_CPF_CONSUMIDOR write SetCNPJ_CPF_CONSUMIDOR;
    property PEDIDO_COMPRA: Variant read FPEDIDO_COMPRA write SetPEDIDO_COMPRA;
    property DATA_FINALIZADO: Variant read FDATA_FINALIZADO write SetDATA_FINALIZADO;
    property NUMERO_SENHA: Variant read FNUMERO_SENHA write SetNUMERO_SENHA;
    property ARQUITETO_ID: Variant read FARQUITETO_ID write SetARQUITETO_ID;
    property ARQUITETO_COMISSAO: Variant read FARQUITETO_COMISSAO write SetARQUITETO_COMISSAO;
    property LOTE_CARGA_ID: Variant read FLOTE_CARGA_ID write SetLOTE_CARGA_ID;
    property ENTREGA: Variant read FENTREGA write SetENTREGA;
    property VALOR_DESPESA_VENDA: Variant read FVALOR_DESPESA_VENDA write SetVALOR_DESPESA_VENDA;
    property ENTREGA_ENDERECO: Variant read FENTREGA_ENDERECO write SetENTREGA_ENDERECO;
    property ENTREGA_COMPLEMENTO: Variant read FENTREGA_COMPLEMENTO write SetENTREGA_COMPLEMENTO;
    property ENTREGA_NUMERO: Variant read FENTREGA_NUMERO write SetENTREGA_NUMERO;
    property ENTREGA_BAIRRO: Variant read FENTREGA_BAIRRO write SetENTREGA_BAIRRO;
    property ENTREGA_CIDADE: Variant read FENTREGA_CIDADE write SetENTREGA_CIDADE;
    property ENTREGA_CEP: Variant read FENTREGA_CEP write SetENTREGA_CEP;
    property ENTREGA_UF: Variant read FENTREGA_UF write SetENTREGA_UF;
    property ENTREGA_COD_MUNICIPIO: Variant read FENTREGA_COD_MUNICIPIO write SetENTREGA_COD_MUNICIPIO;
    property ENTREGA_TELEFONE: Variant read FENTREGA_TELEFONE write SetENTREGA_TELEFONE;
    property ENTREGA_CELULAR: Variant read FENTREGA_CELULAR write SetENTREGA_CELULAR;
    property ENTREGA_OBSERVACAO: Variant read FENTREGA_OBSERVACAO write SetENTREGA_OBSERVACAO;
    property ENTREGA_HORA: Variant read FENTREGA_HORA write SetENTREGA_HORA;
    property ENTREGA_CONTATO: Variant read FENTREGA_CONTATO write SetENTREGA_CONTATO;
    property ENTREGA_AGENDA_ID: Variant read FENTREGA_AGENDA_ID write SetENTREGA_AGENDA_ID;
    property ENTREGA_REGIAO_ID: Variant read FENTREGA_REGIAO_ID write SetENTREGA_REGIAO_ID;
    property ENTREGADOR_ID: Variant read FENTREGADOR_ID write SetENTREGADOR_ID;
    property FATURA_ID: Variant read FFATURA_ID write SetFATURA_ID;
    property DATAHORA_IMPRESSO: Variant read FDATAHORA_IMPRESSO write SetDATAHORA_IMPRESSO;
    property CTR_IMPRESSAO_ITENS: Variant read FCTR_IMPRESSAO_ITENS write SetCTR_IMPRESSAO_ITENS;
    property RESERVADO: Variant read FRESERVADO write SetRESERVADO;
    property PATRIMONIO_OBSERVACAO: Variant read FPATRIMONIO_OBSERVACAO write SetPATRIMONIO_OBSERVACAO;
    property OBS_GERAL: Variant read FOBS_GERAL write SetOBS_GERAL;
    property SMS: Variant read FSMS write SetSMS;
    property IMP_TICKET: Variant read FIMP_TICKET write SetIMP_TICKET;
    property COMANDA: Variant read FCOMANDA write SetCOMANDA;
    property VALOR_TAXA_SERVICO: Variant read FVALOR_TAXA_SERVICO write SetVALOR_TAXA_SERVICO;
    property VFCPUFDEST: Variant read FVFCPUFDEST write SetVFCPUFDEST;
    property VICMSUFDEST: Variant read FVICMSUFDEST write SetVICMSUFDEST;
    property VICMSUFREMET: Variant read FVICMSUFREMET write SetVICMSUFREMET;
    property ENTREGUE: Variant read FENTREGUE write SetENTREGUE;
    property INDICACAO_ID: Variant read FINDICACAO_ID write SetINDICACAO_ID;
    property ZERAR_ST: Variant read FZERAR_ST write SetZERAR_ST;
    property PEDIDO_VIDRACARIA: Variant read FPEDIDO_VIDRACARIA write SetPEDIDO_VIDRACARIA;
    property CHAVE_XML_NF: Variant read FCHAVE_XML_NF write SetCHAVE_XML_NF;
    property ARQUIVO_XML_NF: Variant read FARQUIVO_XML_NF write SetARQUIVO_XML_NF;
    property GERENTE_ID: Variant read FGERENTE_ID write SetGERENTE_ID;
    property ENTRADA_PORTADOR_ID: Variant read FENTRADA_PORTADOR_ID write SetENTRADA_PORTADOR_ID;
    property DATA_COTACAO: Variant read FDATA_COTACAO write SetDATA_COTACAO;
    property TIPO_COMISSAO: Variant read FTIPO_COMISSAO write SetTIPO_COMISSAO;
    property GERENTE_TIPO_COMISSAO: Variant read FGERENTE_TIPO_COMISSAO write SetGERENTE_TIPO_COMISSAO;
    property POS_VENDA: Variant read FPOS_VENDA write SetPOS_VENDA;
    property VLR_GARANTIA: Variant read FVLR_GARANTIA write SetVLR_GARANTIA;
    property WEB_PEDIDO_ID: Variant read FWEB_PEDIDO_ID write SetWEB_PEDIDO_ID;
    property LACA_OU_GLASS: Variant read FLACA_OU_GLASS write SetLACA_OU_GLASS;
    property VFCPST: Variant read FVFCPST write SetVFCPST;
    property MONTAGEM_DATA: Variant read FMONTAGEM_DATA write SetMONTAGEM_DATA;
    property MONTAGEM_HORA: Variant read FMONTAGEM_HORA write SetMONTAGEM_HORA;
    property FORM: Variant read FFORM write SetFORM;
    property VICMSDESON: Variant read FVICMSDESON write SetVICMSDESON;
    property QTDEITENS: Variant read FQTDEITENS write SetQTDEITENS;
    property CTR_ENVIO_PEDIDO: Variant read FCTR_ENVIO_PEDIDO write SetCTR_ENVIO_PEDIDO;
    property CTR_ENVIO_BOLETO: Variant read FCTR_ENVIO_BOLETO write SetCTR_ENVIO_BOLETO;
    property CTR_ENVIO_NFE: Variant read FCTR_ENVIO_NFE write SetCTR_ENVIO_NFE;
    property DATAHORA_COLETA: Variant read FDATAHORA_COLETA write SetDATAHORA_COLETA;
    property DATAHORA_RETIRADA: Variant read FDATAHORA_RETIRADA write SetDATAHORA_RETIRADA;
    property CFOP_NF: Variant read FCFOP_NF write SetCFOP_NF;
    property FANTASIA_CLI :Variant read FFANTASIA_CLI write SetFANTASIA_CLI;
    property ENDERECO     :Variant read FENDERECO write SetENDERECO;
    property BAIRRO_CLI   :Variant read FBAIRRO_CLI write SetBAIRRO_CLI;
    property CIDADE_CLI   :Variant read FCIDADE_CLI write SetCIDADE_CLI;
    property UF_CLI       :Variant read FUF_CLI write SetUF_CLI;
    property CNPJ_CPF_CLI :Variant read FCNPJ_CPF_CLI write SetCNPJ_CPF_CLI;
    property NOME_VENDEDOR: Variant read FNOME_VENDEDOR write SetNOME_VENDEDOR;
    property PEDIDOITENS_ID    :Variant read FPEDIDOITENS_ID write SetPEDIDOITENS_ID;
    property CODIGO_PRO        :Variant read FCODIGO_PRO write SetCODIGO_PRO;
    property QUANTIDADE_PED    :Variant read FQUANTIDADE_PED write SetQUANTIDADE_PED;
    property VALORUNITARIO_PED :Variant read FVALORUNITARIO_PED write SetVALORUNITARIO_PED;

    property PedidoVendasLista: TObjectList<TPedidoVendaModel> read FPedidoVendasLista write SetPedidoVendasLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property IDUsuario: String read FIDUsuario write SetIDUsuario;

  	constructor Create(pConexao: IConexao);
    destructor Destroy; override;

    function Incluir : String;
    function Alterar(pID : String) : TPedidoVendaModel;
    function Excluir(pID : String) : String;
    function Salvar : String;

    procedure obterLista;
    function obterPedido(pNumeroPedido: String): TPedidoVendaModel;

    function carregaClasse(pId: String): TPedidoVendaModel;
    procedure RecalcularImpostos(pNumeroPedido: String);
    function GerarNF(pModelo, pSerie: String): String;
    function gerarContasReceberPedido: String; overload;
    function gerarContasReceberPedido(pValor, pPortador, pParcelas, pPrimeiroVencimento : String; pAcrescimo: String = ''): String; overload;
    function statusPedido(pId: String): String;

    procedure calcularTotais;
    procedure faturado(pIdNf: String);
    procedure concluirPedido;
    procedure reabrirPedido;
    procedure excluirContasReceber;
    procedure excluirPedido;
    procedure verificarTagObservacao;
    procedure venderItem(pVenderItem: TVenderItem);

  end;

implementation

uses
  PedidoVendaDao,
  ContasReceberModel,
  PortadorModel,
  System.SysUtils,
  ContasReceberItensModel,
  System.StrUtils,
  CalcularImpostosModel,
  NFModel,
  NFItensModel,
  ProdutosModel,
  CFOPModel,
  EmpresaModel,
  FireDAC.Comp.Client, ClienteModel, FuncionarioModel, Terasoft.Configuracoes,
  PixModel;

{ TPedidoVendaModel }

function TPedidoVendaModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := Salvar;
end;

function TPedidoVendaModel.Incluir: String;
begin
  verificarTagObservacao;

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TPedidoVendaModel.Alterar(pID: String): TPedidoVendaModel;
var
  lPedidoVendaModel : TPedidoVendaModel;
begin
  lPedidoVendaModel := TPedidoVendaModel.Create(vIConexao);
  try
    lPedidoVendaModel      := lPedidoVendaModel.carregaClasse(pID);
    lPedidoVendaModel.Acao := tacAlterar;
    Result                 := lPedidoVendaModel;
  finally

  end;
end;

procedure TPedidoVendaModel.calcularTotais;
var
  lPedidoItensModel  : TPedidoItensModel;
  lAcrescimo, lFrete : Double;
begin
  lPedidoItensModel := TPedidoItensModel.Create(vIConexao);
  try
    lPedidoItensModel.obterTotaisItens(self.FNUMERO_PED);

    lAcrescimo := self.ACRES_PED;
    lFrete     := self.FRETE_PED;

    self.Acao          := tacAlterar;
    self.NUMERO_PED    := self.FNUMERO_PED;
    self.VALOR_PED     := FloatToStr(lPedidoItensModel.VALOR_TOTAL_ITENS);
    self.VLR_GARANTIA  := FloatToStr(lPedidoItensModel.VALOR_TOTAL_GARANTIA);
    self.DESC_PED      := FloatToStr(lPedidoItensModel.VALOR_TOTAL_DESCONTO);

    if lPedidoItensModel.VALOR_TOTAL_ITENS > 0 then
      self.DESCONTO_PED  := FloatToStr(lPedidoItensModel.VALOR_TOTAL_DESCONTO * 100 / lPedidoItensModel.VALOR_TOTAL_ITENS)
    else
      self.DESCONTO_PED := '0';
    self.TOTAL_PED     := FloatToStr(lPedidoItensModel.VALOR_TOTAL + lAcrescimo + lFrete);

    self.Salvar;
  finally
    lPedidoItensModel.Free;
  end;
end;

function TPedidoVendaModel.carregaClasse(pId: String): TPedidoVendaModel;
var
  lPedidoVendaDao: TPedidoVendaDao;
begin
  lPedidoVendaDao := TPedidoVendaDao.Create(vIConexao);
  try
    Result := lPedidoVendaDao.carregaClasse(pId);
  finally
    lPedidoVendaDao.Free;
  end;
end;

procedure TPedidoVendaModel.concluirPedido;
var
  lPedidoVendaModel        : TPedidoVendaModel;
  lPedidoItensModel,
  lModel                   : TPedidoItensModel;
  lContasReceberModel      : TContasReceberModel;
  lContasReceberItensModel : TContasReceberItensModel;
  lClienteModel            : TClienteModel;
  lPixModel                : TPixModel;
  lComissaoCliente         : Double;
begin
  lPedidoVendaModel        := TPedidoVendaModel.Create(vIConexao);
  lPedidoItensModel        := TPedidoItensModel.Create(vIConexao);
  lClienteModel            := TClienteModel.Create(vIConexao);
  lContasReceberModel      := TContasReceberModel.Create(vIConexao);
  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);
  lPixModel                := TPixModel.Create(vIConexao);

  try
    lPedidoVendaModel := lPedidoVendaModel.carregaClasse(self.FNUMERO_PED);

    lContasReceberModel.IDPedidoView := lPedidoVendaModel.NUMERO_PED;
    lContasReceberModel.WhereView    := ' and portador.tpag_nfe = ''17''';
    lContasReceberModel.obterContasReceberPedido;

    for lContasReceberModel in lContasReceberModel.ContasRecebersLista do
    begin
      lContasReceberItensModel.IDContasReceberView := lContasReceberModel.FATURA_REC;
      lContasReceberItensModel.obterLista;

      for lContasReceberItensModel in lContasReceberItensModel.ContasReceberItenssLista do
      begin
        lPixModel.WhereView := ' and pix.contasreceberitens_id = '+ lContasReceberItensModel.ID +
                               ' and pix.valor_recebido > 0         '+
                               ' and pix.data_pagamento is not null ';

        lPixModel.obterLista;

        if lPixModel.TotalRecords = 0 then
          CriaException('Pix não recebido. Realizar o recebimento');
      end;
    end;

    lPedidoVendaModel.Acao := tacAlterar;
    lPedidoVendaModel.STATUS_PED := 'B';
    lPedidoVendaModel.STATUS     := 'P';
    lPedidoVendaModel.Salvar;

    lPedidoItensModel.IDPedidoVendaView := lPedidoVendaModel.NUMERO_PED;
    lPedidoItensModel.obterLista;

    lComissaoCliente := lClienteModel.comissaoCliente(self.FCODIGO_CLI);

    for lModel in lPedidoItensModel.PedidoItenssLista do
    begin
      lModel.gerarEstoque;
      lModel.calcularComissao(lPedidoVendaModel.CODIGO_VEN, lPedidoVendaModel.CODIGO_TIP, lComissaoCliente, lPedidoVendaModel.GERENTE_ID);
    end;

  finally
    lContasReceberItensModel.Free;
    lContasReceberModel.Free;
    lPedidoVendaModel.Free;
    lPedidoItensModel.Free;
    lClienteModel.Free;
    lPixModel.Free;
  end;
end;

constructor TPedidoVendaModel.Create(pConexao : IConexao);
begin
  vIConexao := pConexao;
end;

destructor TPedidoVendaModel.Destroy;
begin
  inherited;
end;

procedure TPedidoVendaModel.excluirContasReceber;
var
  lContasReceberModel, lModel: TContasReceberModel;
begin
  lContasReceberModel := TContasReceberModel.Create(vIConexao);
  try
    lContasReceberModel.IDPedidoView := self.NUMERO_PED;
    lContasReceberModel.obterLista;

    for lModel in lContasReceberModel.ContasRecebersLista do
    begin
      lModel.Acao := tacExcluir;
      lModel.Salvar;
    end;
  finally
    lContasReceberModel.Free;
  end;
end;

procedure TPedidoVendaModel.excluirPedido;
begin
  if self.NUMERO_PED = '' then
    CriaException('Pedido não informado.');

  self.excluirContasReceber;

  self.Acao := tacExcluir;
  self.Salvar;
end;

procedure TPedidoVendaModel.faturado(pIdNf: String);
begin
  self.FAcao := tacAlterar;
  self.FSTATUS        := 'F';
  self.FDATA_FATURADO := DateToStr(vIConexao.DataServer);
  self.FNUMERO_NF     := pIdNf;
  self.Salvar;
end;

function TPedidoVendaModel.gerarContasReceberPedido(pValor, pPortador, pParcelas, pPrimeiroVencimento: String; pAcrescimo: String = ''): String;
var
  lContasReceberModel      : TContasReceberModel;
  lContasReceberItensModel : TContasReceberItensModel;
  lEmpresaModel            : TEmpresaModel;
  lFaturaReceber           : String;
  lParcela, lTotalParcelas : Integer;
  lValorParcela,
  lValorTotal,
  lSomaParcelas            : Double;
  lVencimento              : TDate;
begin

  if (self.FCODIGO_CLI = '000000') and (pPortador = '000001') then
    CriaException('Para o cliente consumidor o portador não pode ser carteira.');

  lContasReceberModel      := TContasReceberModel.Create(vIConexao);
  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);
  lEmpresaModel            := TEmpresaModel.Create(vIConexao);

  try
    lEmpresaModel.Carregar;

    lContasReceberModel.Acao          := tacIncluir;
    lContasReceberModel.LOJA          := self.FLOJA;
    lContasReceberModel.PEDIDO_REC    := self.FNUMERO_PED;
    lContasReceberModel.CODIGO_CLI    := self.FCODIGO_CLI;
    lContasReceberModel.DATAEMI_REC   := self.FDATA_PED;
    lContasReceberModel.VALOR_REC     := pValor;
    lContasReceberModel.ACRESCIMO     := pAcrescimo;
    lContasReceberModel.SITUACAO_REC  := 'A';
    lContasReceberModel.VENDEDOR_REC  := self.FCODIGO_VEN;
    lContasReceberModel.USUARIO_REC   := self.vIConexao.getUSer.ID;
    lContasReceberModel.OBS_REC       := 'Venda: '+self.FNUMERO_PED;
    lContasReceberModel.TIPO_REC      := 'N';
    lContasReceberModel.CODIGO_POR    := pPortador;
    lContasReceberModel.JUROS_FIXO    := lEmpresaModel.JUROS_BOL;
    lContasReceberModel.CODIGO_CTA    := '555555';
    lFaturaReceber := lContasReceberModel.Salvar;

    lParcela       := 0;
    lValorTotal    := lContasReceberModel.VALOR_REC;
    lTotalParcelas := StrToInt(pParcelas);
    lValorParcela  := lValorTotal / lTotalParcelas;
    lVencimento    := StrToDate(pPrimeiroVencimento);
    lSomaParcelas  := 0;

    lContasReceberItensModel.ContasReceberItenssLista := TObjectList<TContasReceberItensModel>.Create;

    for lParcela := 0 to Pred(lTotalParcelas) do begin
      lContasReceberItensModel.ContasReceberItenssLista.Add(TContasReceberItensModel.Create(vIConexao));
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].FATURA_REC         := lFaturaReceber;
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].CODIGO_POR         := pPortador;
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].CODIGO_CLI         := lContasReceberModel.CODIGO_CLI;
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].SITUACAO_REC       := 'A';
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].VALORREC_REC       := '0';
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].VALOR_PAGO         := '0';
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].LOJA               := lContasReceberModel.LOJA;
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].VLRPARCELA_REC     := lValorParcela.ToString;
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].PACELA_REC         := (lParcela + 1).ToString;
      lContasReceberItensModel.ContasReceberItenssLista[lParcela].TOTALPARCELAS_REC  := lTotalParcelas.ToString;

      if lParcela > 0 then
        lVencimento := IncMonth(lVencimento,1);

      lContasReceberItensModel.ContasReceberItenssLista[lParcela].VENCIMENTO_REC := DateToStr(lVencimento);

      lSomaParcelas := lSomaParcelas + StrToFloat(FormatFloat('0.00', lValorParcela));
    end;

    if lSomaParcelas > lValorTotal then
      lContasReceberItensModel.ContasReceberItenssLista[0].VLRPARCELA_REC := (lValorParcela - (lSomaParcelas - lValorTotal)).ToString
    else if lSomaParcelas < lValorTotal then
      lContasReceberItensModel.ContasReceberItenssLista[0].VLRPARCELA_REC := (lValorParcela + (lValorTotal - lSomaParcelas)).ToString;

    lContasReceberItensModel.Acao := tacIncluir;
    lContasReceberItensModel.Salvar;

    Result := lFaturaReceber;
  finally
    lContasReceberItensModel.Free;
    lContasReceberModel.Free;
  end;
end;

function TPedidoVendaModel.GerarNF(pModelo, pSerie: String): String;
var
  lPedidoItensModel,
  lItens            : TPedidoItensModel;
  lNFModel          : TNFModel;
  lNFItensModel     : TNFItensModel;
  lEmpresaModel     : TEmpresaModel;
  lNumeroNFe        : String;
begin
  if self.FNUMERO_PED = '' then
    CriaException('Pedido não informado');

  if pModelo = '' then
    CriaException('Modelo não informado');

  lPedidoItensModel := TPedidoItensModel.Create(vIConexao);
  lNFItensModel     := TNFItensModel.Create(vIConexao);
  lNFModel          := TNFModel.Create(vIConexao);
  lEmpresaModel     := TEmpresaModel.Create(vIConexao);

  try
    self.RecalcularImpostos(self.NUMERO_PED);
    lEmpresaModel.Carregar;

    lNFModel.Acao := tacIncluir;
    lNFModel.TIPO_NF               := 'N';
    lNFModel.EMAIL_NFE             := '1';
    lNFModel.STATUS_NF             := '0';
    lNFModel.INDPRES               := '1';
    lNFModel.STATUS_TRANSMISSAO    := '8';
    lNFModel.NOME_XML              := 'Em processamento';
    lNFModel.MODELO                := pModelo;
    lNFModel.SERIE_NF              := pSerie;
    lNFModel.ESPECIE_VOLUME        := self.ESPECIE_VOLUME;
    lNFModel.BICMS_NF              := FloatToStr(0);
    lNFModel.VICMS_NF              := FloatToStr(0);
    lNFModel.ICMS_NF               := FloatToStr(0);
    lNFModel.OUTROS_NF             := FloatToStr(0);
    lNFModel.BASE_ST_NF            := FloatToStr(0);
    lNFModel.IPI_NF                := FloatToStr(0);
    lNFModel.ICMS_ST               := FloatToStr(0);
    lNFModel.VSEG                  := FloatToStr(0);
    lNFModel.VALOR_SUFRAMA         := FloatToStr(0);
    lNFModel.VFCPST                := FloatToStr(0);
    lNFModel.VFCP                  := FloatToStr(0);
    lNFModel.VICMSDESON            := FloatToStr(0);
    lNFModel.VICMSUFDEST           := FloatToStr(0);
    lNFModel.VICMSUFREMET          := FloatToStr(0);
    lNFModel.VICMSSTRET            := FloatToStr(0);
    lNFModel.VTOTTRIB_FEDERAL      := FloatToStr(0);
    lNFModel.VTOTTRIB_ESTADUAL     := FloatToStr(0);
    lNFModel.VTOTTRIB_MUNICIPAL    := FloatToStr(0);
    lNFModel.VCREDICMSSN           := FloatToStr(0);
    lNFModel.VPIS                  := FloatToStr(0);
    lNFModel.VCOFINS               := FloatToStr(0);
    lNFModel.VTOTTRIB              := FloatToStr(0);
    lNFModel.VII                   := FloatToStr(0);
    lNFModel.VALOR_SUFRAMA         := FloatToStr(0);
    lNFModel.VFCPSTRET             := FloatToStr(0);
    lNFModel.VFCPUFDEST            := FloatToStr(0);
    lNFModel.USUARIO_NF            := self.vIConexao.getUSer.ID;
    lNFModel.LOJA                  := self.LOJA;
    lNFModel.TIPO_FRETE            := self.FTIPO_FRETE;
    lNFModel.DATA_NF               := DateToStr(vIConexao.DataServer);
    lNFModel.DATA_SAIDA            := DateToStr(vIConexao.DataServer);
    lNFModel.HORA_SAIDA            := TimeToStr(vIConexao.HoraServer);
    lNFModel.UF_EMBARQUE           := lEmpresaModel.UF;
    lNFModel.LOCAL_EMBARQUE        := lEmpresaModel.CIDADE;
    lNFModel.CODIGO_CLI            := self.FCODIGO_CLI;
    lNFModel.CODIGO_VEN            := self.FCODIGO_VEN;
    lNFModel.CODIGO_PORT           := self.FCODIGO_PORT;
    lNFModel.CODIGO_TIP            := self.FCODIGO_TIP;
    lNFModel.CFOP_ID               := self.FCFOP_ID;
    lNFModel.CFOP_NF               := self.FCFOP_NF;
    lNFModel.VALOR_NF              := self.FVALOR_PED;
    lNFModel.ACRES_NF              := self.FACRES_PED;
    lNFModel.TOTAL_NF              := self.FTOTAL_PED;
    lNFModel.NUMERO_PED            := self.FNUMERO_PED;
    lNFModel.PEDIDO_ID             := self.FNUMERO_PED;
    lNFModel.DESC_NF               := self.FDESC_PED;
    lNFModel.DESCONTO_NF           := self.FDESCONTO_PED;
    lNFModel.VALOR_PAGO            := self.FVALOR_PAGO;
    lNFModel.TIPO_FRETE            := self.TIPO_FRETE;
    lNFModel.CNPJ_CPF_CONSUMIDOR   := self.FCNPJ_CPF_CONSUMIDOR;
    lNFModel.VALOR_SUFRAMA         := self.FVALOR_SUFRAMA;
    lNFModel.FRETE                 := self.FFRETE_PED;
    lNFModel.OUTROS_NF             := self.FACRES_PED;
    lNFModel.TRANSPORTADORA        := self.FTELEVENDA_PED;
    lNFModel.OBS_NF                := self.FINFORMACOES_PED;
    lNFModel.ESPECIE_VOLUME        := self.FESPECIE_VOLUME;
    lNFModel.TRA_UF                := self.FUF_TRANSPORTADORA;
    lNFModel.TRA_PLACA             := self.FPLACA;
    lNFModel.TRA_RNTC              := self.FRNTRC;
    lNFModel.TIPO_FRETE            := IfThen(pModelo = '55', self.FTIPO_FRETE, '9');
    lNumeroNFe := lNFModel.Salvar;

    lNFModel := lNFModel.carregaClasse(lNumeroNFe);

    self.Acao       := tacAlterar;
    self.FNUMERO_NF := lNFModel.NUMERO_ECF;
    self.Salvar;

    lPedidoItensModel.IDPedidoVendaView := self.NUMERO_PED;
    lPedidoItensModel.obterLista;

    for lItens in lPedidoItensModel.PedidoItenssLista do begin
      lNFItensModel.Acao := tacIncluir;
      lNFItensModel.NUMERO_NF             := lNumeroNFe;
      lNFItensModel.SERIE_NF              := pSerie;
      lNFItensModel.LOJA                  := self.LOJA;
      lNFItensModel.ITEM_NF               := Format('%3.3d', [StrToInt(lItens.ITEM)]);
      lNFItensModel.MODBCST_N18           := '4';
      lNFItensModel.INDESCALA             := 'S';
      //Não encontrado no fonte
      lNFItensModel.PREDBCEFET            := FloatToStr(0);
      lNFItensModel.VBCEFET               := FloatToStr(0);
      lNFItensModel.PICMSEFET             := FloatToStr(0);
      lNFItensModel.VICMSEFET             := FloatToStr(0);
      lNFItensModel.BASE_IPI2             := FloatToStr(0);
      //
      //Não tem na tabela de pedidoitens
      lNFItensModel.VBC_IPI               := FloatToStr(0);
      lNFItensModel.VSEG                  := FloatToStr(0);
      lNFItensModel.VICMSSUBISTITUTORET   := FloatToStr(0);
      lNFItensModel.VBCSTRET              := FloatToStr(0);
      lNFItensModel.VICMSSTRET            := FloatToStr(0);
      lNFItensModel.PICMSSTRET            := FloatToStr(0);
      lNFItensModel.VICMSUFDEST           := FloatToStr(0);
      lNFItensModel.VFCP                  := FloatToStr(0);
      lNFItensModel.PFCP                  := FloatToStr(0);
      lNFItensModel.VBCCFP                := FloatToStr(0);
      lNFItensModel.PPRCOMP               := FloatToStr(0);
      lNFItensModel.VPRCOMP               := FloatToStr(0);
      lNFItensModel.CSOSN                 := '';
      lNFItensModel.CFOP                  := '';
      lNFItensModel.PCREDSN               := FloatToStr(0);
      lNFItensModel.VCREDICMSSN           := FloatToStr(0);
      lNFItensModel.VALIQPROD_S10         := FloatToStr(0);
      lNFItensModel.VTOTTRIB              := FloatToStr(0);
      lNFItensModel.VTOTTRIB_FEDERAL      := FloatToStr(0);
      lNFItensModel.VTOTTRIB_ESTADUAL     := FloatToStr(0);
      lNFItensModel.VTOTTRIB_MUNICIPAL    := FloatToStr(0);
      lNFItensModel.PFCPSTRET             := FloatToStr(0);
      lNFItensModel.VFCPSTRET             := FloatToStr(0);
      //
      lNFItensModel.CODIGO_PRO            := lItens.CODIGO_PRO;
      lNFItensModel.VALORUNITARIO_NF      := lItens.VALORUNITARIO_PED;
      lNFItensModel.QUANTIDADE_NF         := lItens.QTDE_CALCULADA;
      lNFItensModel.VLRVENDA_NF           := lItens.VLRVENDA_PRO;
      lNFItensModel.VLRCUSTO_NF           := lItens.VLRCUSTO_PRO;
      lNFItensModel.CFOP_ID               := lItens.CFOP_ID;
      lNFItensModel.CFOP                  := lItens.CFOP;
      lNFItensModel.VFCPST                := lItens.VFCPST;
      lNFItensModel.VICMSDESON            := lItens.VICMSDESON;
      lNFItensModel.MOTDESICMS            := lItens.MOTDESICMS;
      lNFItensModel.PCRED_PRESUMIDO       := lItens.PCRED_PRESUMIDO;
      lNFItensModel.CST_Q06               := lItens.PIS_CST;
      lNFItensModel.CST_IPI               := lItens.PIS_CST;
      lNFItensModel.PPIS_Q08              := lItens.ALIQ_PIS;
      lNFItensModel.CST_S06               := lItens.COFINS_CST;
      lNFItensModel.PCOFINS_S08           := lItens.ALIQ_COFINS;
      lNFItensModel.QBCPROD_S09           := lItens.QTDE_CALCULADA;
      lNFItensModel.MOTDESICMS            := lItens.MOTDESICMS;
      lNFItensModel.VICMSDESON            := lItens.VICMSDESON;
      lNFItensModel.VDESC                 := lItens.VDESC;
      lNFItensModel.VALOR_SUFRAMA_ITEM    := lItens.VALOR_SUFRAMA_ITEM;
      lNFItensModel.VBCFCPST              := lItens.VBCFCPST;
      lNFItensModel.PFCPST                := lItens.PFCPST;
      lNFItensModel.VICMSUFDEST           := lItens.VICMSUFDEST;
      lNFItensModel.VICMSUFREMET          := lItens.VICMSUFREMET;
      lNFItensModel.REDUCAO_NF            := lItens.REDUCAO_ICMS;
      lNFItensModel.VOUTROS               := lItens.VOUTROS;
      lNFItensModel.FRETE                 := lItens.VFRETE;
      lNFItensModel.VALOR_IPI             := lItens.VALOR_IPI;
      lNFItensModel.CSOSN                 := lItens.CSOSN;
      lNFItensModel.IPI_NF                := lItens.ALIQ_IPI;
      lNFItensModel.CST_N12               := lItens.CST;
      lNFItensModel.PREDBC_N14            := lItens.REDUCAO_ICMS;
      lNFItensModel.VBC_N15               := lItens.BASE_ICMS;
      lNFItensModel.ICMS_NF               := lItens.ALIQ_ICMS;
      lNFItensModel.VICMS_N17             := lItens.VALOR_ICMS;
      lNFItensModel.PMVAST_N19            := lItens.MVA;
      lNFItensModel.PREDBCST_N20          := lItens.REDUCAO_ST;
      lNFItensModel.VBCST_N21             := lItens.BASE_ST;
      lNFItensModel.PICMSST_N22           := lItens.ALIQ_ICMS_ST;
      lNFItensModel.VICMSST_N23           := lItens.VALOR_ST;
      lNFItensModel.VPIS_Q09              := lItens.VALOR_PIS;
      lNFItensModel.VCOFINS_S11           := lItens.VALOR_COFINS;
      lNFItensModel.VBC_Q07               := lItens.BASE_PIS;
      lNFItensModel.VBC_S07               := lItens.BASE_COFINS;
      lNFItensModel.PIS_SUFRAMA           := lItens.PIS_SUFRAMA;
      lNFItensModel.COFINS_SUFRAMA        := lItens.COFINS_SUFRAMA;
      lNFItensModel.ICMS_SUFRAMA          := lItens.ICMS_SUFRAMA;
      lNFItensModel.IPI_SUFRAMA           := lItens.IPI_SUFRAMA;
      lNFItensModel.XPED                  := lItens.XPED;
      lNFItensModel.NITEMPED2             := lItens.NITEMPED2;
      lNFItensModel.LOTE                  := lItens.OBSERVACAO;
      lNFItensModel.Salvar;
    end;
    Result := lNumeroNFe;
  finally
    lPedidoItensModel.Free;
    lNFItensModel.Free;
    lNFModel.Free;
    lEmpresaModel.Free;
  end;
end;

procedure TPedidoVendaModel.getDataVendedor;
var
  lFuncionarioModel : TFuncionarioModel;
begin
  if self.FCODIGO_VEN = '' then
    exit;

  lFuncionarioModel := TFuncionarioModel.Create(vIConexao);
  try
    lFuncionarioModel.IDRecordView := self.FCODIGO_VEN;
    lFuncionarioModel.obterLista;

    if lFuncionarioModel.FuncionariosLista[0].TIPO_COMISSAO <> '' then
      self.FTIPO_COMISSAO := lFuncionarioModel.FuncionariosLista[0].TIPO_COMISSAO
    else
      self.FTIPO_COMISSAO := 'F';

    if lFuncionarioModel.FuncionariosLista[0].GERENTE_ID <> '' then
      self.FGERENTE_ID := lFuncionarioModel.FuncionariosLista[0].GERENTE_ID;

  finally
    lFuncionarioModel.Free;
  end;
end;


procedure TPedidoVendaModel.venderItem(pVenderItem: TVenderItem);
var
  lConfiguracoes : TerasoftConfiguracoes;
  lEmpresaModel  : TEmpresaModel;
  lProdutosModel : TProdutosModel;
  lPedidoItensModel, lModel : TPedidoItensModel;
  lProdutoPreco: TProdutoPreco;

begin
  lConfiguracoes    := vIConexao.getTerasoftConfiguracoes as TerasoftConfiguracoes;
  lEmpresaModel     := TEmpresaModel.Create(vIConexao);
  lProdutosModel    := TProdutosModel.Create(vIConexao);
  lPedidoItensModel := TPedidoItensModel.Create(vIConexao);

  try
    if pVenderItem.Quantidade = 0 then
      CriaException('Quantidade inválida.');

    lProdutosModel.WhereView := ' and produto.barras_pro = '+ QuotedStr(pVenderItem.BarrasProduto);
    lProdutosModel.obterLista;

    if lProdutosModel.TotalRecords = 0  then
      CriaException('Produto não localizado.');

    lEmpresaModel.Carregar;

    if lEmpresaModel.AVISARNEGATIVO_EMP = 'S' then
    begin
      if (lConfiguracoes.valorTag('USAR_RESERVA','',tvBool) = 'S') and (lProdutosModel.obterSaldoDisponivel(lProdutosModel.ProdutossLista[0].CODIGO_PRO) <= 0) then
        CriaException('Produto sem saldo disponível em estoque.')
      else
      if lProdutosModel.ProdutossLista[0].SALDO_PRO <= 0 then
        CriaException('Produto sem saldo em estoque.')
    end;

    lPedidoItensModel.WhereView := 'and pedidoitens.numero_ped = '+ self.FNUMERO_PED +' and pedidoitens.codigo_pro = '+ lProdutosModel.ProdutossLista[0].CODIGO_PRO;
    lPedidoItensModel.obterLista;

    if (lPedidoItensModel.TotalRecords > 0) and (lConfiguracoes.valorTag('FRENTE_CAIXA_SOMAR_QTDE_ITENS', 'S', tvBool) = 'S') then
    begin
      lModel := lPedidoItensModel.carregaClasse(lPedidoItensModel.PedidoItenssLista[0].ID);
      lModel.Acao := tacAlterar;
      lModel.QUANTIDADE_PED := lPedidoItensModel.PedidoItenssLista[0].QUANTIDADE_PED + pVenderItem.Quantidade;
      lModel.QUANTIDADE_NEW := lPedidoItensModel.PedidoItenssLista[0].QUANTIDADE_NEW + pVenderItem.Quantidade;
      lModel.Salvar;
    end
    else
    begin
      lPedidoItensModel.Acao := tacIncluir;
      lPedidoItensModel.NUMERO_PED           := self.FNUMERO_PED;
      lPedidoItensModel.CODIGO_PRO           := lProdutosModel.ProdutossLista[0].CODIGO_PRO;
      lPedidoItensModel.CODIGO_CLI           := self.FCODIGO_CLI;
      lPedidoItensModel.COMISSAO_PED         := FloatToStr(0);
      lPedidoItensModel.DESCONTO_PED         := FloatToStr(0);
      lPedidoItensModel.LOJA                 := lEmpresaModel.LOJA;
      lPedidoItensModel.QUANTIDADE_PED       := FloatToStr(pVenderItem.Quantidade);
      lPedidoItensModel.QUANTIDADE_NEW       := FloatToStr(pVenderItem.Quantidade);

      lProdutoPreco.Produto                  := lProdutosModel.ProdutossLista[0].CODIGO_PRO;
      lProdutoPreco.Cliente                  := self.FCODIGO_CLI;
      lProdutoPreco.Portador                 := self.FCODIGO_PORT;
      lProdutoPreco.Qtde                     := pVenderItem.Quantidade;
      lProdutoPreco.PrecoUf                  := pVenderItem.PrecoUf;
      lProdutoPreco.PrecoCliente             := pVenderItem.PrecoCliente;
      lProdutoPreco.Promocao                 := pVenderItem.Promocao;
      lProdutoPreco.TabelaPreco              := pVenderItem.TabelaPreco;

      lPedidoItensModel.VALORUNITARIO_PED    := lProdutosModel.ValorUnitario(lProdutoPreco).ToString;
      lPedidoItensModel.VLRVENDA_PRO         := lProdutosModel.ProdutossLista[0].VENDA_PRO;
      lPedidoItensModel.VLRCUSTO_PRO         := lProdutosModel.ProdutossLista[0].CUSTOMEDIO_PRO;
      lPedidoItensModel.Salvar;
    end;

  finally
    lEmpresaModel.Free;
    lProdutosModel.Free;
    lPedidoItensModel.Free;
  end;
end;

procedure TPedidoVendaModel.verificarTagObservacao;
var
  lConfiguracoes : TerasoftConfiguracoes;
begin
  lConfiguracoes := vIConexao.getTerasoftConfiguracoes as TerasoftConfiguracoes;
  self.INFORMACOES_PED := lConfiguracoes.valorTag('OBSERVACAO', '', tvMemo);
end;

function TPedidoVendaModel.gerarContasReceberPedido: String;
var
  lValorContasReceber : Double;
  lParcelas           : String;
begin
  lValorContasReceber := self.FTOTAL_PED - self.VALORENTADA_PED;
  lParcelas           := ifThen(StrToIntDef(self.FPARCELAS_PED, 0) > 0, self.FPARCELAS_PED, '1');

  if StrToFloatDef(self.VALORENTADA_PED,0 ) > 0 then
    self.gerarContasReceberPedido(self.VALORENTADA_PED, '777777', '1', self.DATA_PED);

  self.gerarContasReceberPedido(lValorContasReceber.ToString, self.FCODIGO_PORT, lParcelas, self.FPRIMEIROVENC_PED);
end;

function TPedidoVendaModel.obterPedido(pNumeroPedido: String): TPedidoVendaModel;
var
  lPedidoVendaDao: TPedidoVendaDao;
begin
  lPedidoVendaDao := TPedidoVendaDao.Create(vIConexao);
  try
    Result := lPedidoVendaDao.obterPedido(pNumeroPedido);
  finally
    lPedidoVendaDao.Free;
  end;
end;

procedure TPedidoVendaModel.reabrirPedido;
var
  lPedidoVendaModel : TPedidoVendaModel;
  lPedidoItensModel,
  lModel            : TPedidoItensModel;
begin
  lPedidoVendaModel := TPedidoVendaModel.Create(vIConexao);
  lPedidoItensModel := TPedidoItensModel.Create(vIConexao);

  try
    lPedidoVendaModel := lPedidoVendaModel.carregaClasse(self.FNUMERO_PED);
    lPedidoVendaModel.Acao := tacAlterar;
    lPedidoVendaModel.STATUS_PED := 'P';
    lPedidoVendaModel.Salvar;

    lPedidoItensModel.IDPedidoVendaView := lPedidoVendaModel.NUMERO_PED;
    lPedidoItensModel.obterLista;

    for lModel in lPedidoItensModel.PedidoItenssLista do
    begin
      lModel.cancelarEstoque;
    end;

  finally
    lPedidoVendaModel.Free;
    lPedidoItensModel.Free;
  end;
end;

procedure TPedidoVendaModel.obterLista;
var
  lPedidoVendaLista: TPedidoVendaDao;
begin
  lPedidoVendaLista := TPedidoVendaDao.Create(vIConexao);
  try
    lPedidoVendaLista.TotalRecords    := FTotalRecords;
    lPedidoVendaLista.WhereView       := FWhereView;
    lPedidoVendaLista.CountView       := FCountView;
    lPedidoVendaLista.OrderView       := FOrderView;
    lPedidoVendaLista.StartRecordView := FStartRecordView;
    lPedidoVendaLista.LengthPageView  := FLengthPageView;
    lPedidoVendaLista.IDRecordView    := FIDRecordView;
    lPedidoVendaLista.obterLista;

    FTotalRecords      := lPedidoVendaLista.TotalRecords;
    FPedidoVendasLista := lPedidoVendaLista.PedidoVendasLista;
  finally
    lPedidoVendaLista.Free;
  end;
end;

procedure TPedidoVendaModel.RecalcularImpostos(pNumeroPedido: String);
var
  lPedidoVendaLista      : TPedidoVendaDao;
  lCalcularImpostosModel : TCalcularImpostosModel;
  lPedidoItensModal      : TPedidoItensModel;
  lPedidoVendaModel      : TPedidoVendaModel;
  lEmpresaModel          : TEmpresaModel;
begin
  lPedidoVendaLista      := TPedidoVendaDao.Create(vIConexao);
  lCalcularImpostosModel := TCalcularImpostosModel.Create(vIConexao);
  lPedidoItensModal      := TPedidoItensModel.Create(vIConexao);
  lEmpresaModel          := TEmpresaModel.Create(vIConexao);

  try
    lPedidoVendaLista.obterUpdateImpostos(pNumeroPedido);
    lEmpresaModel.Carregar;

    for lPedidoVendaModel in lPedidoVendaLista.PedidoVendasLista do
    begin
      lCalcularImpostosModel.EMITENTE_UF          := lEmpresaModel.UF;
      lCalcularImpostosModel.REGIME_TRIBUTARIO    := lEmpresaModel.REGIME_TRIBUTARIO;
      lCalcularImpostosModel.MODELO_NF            := '65';
      lCalcularImpostosModel.VALOR_DESCONTO_TOTAL := lPedidoVendaModel.DESC_PED;
      lCalcularImpostosModel.VALOR_ACRESCIMO      := lPedidoVendaModel.ACRES_PED;
      lCalcularImpostosModel.TOTAL_PRODUTO        := lPedidoVendaModel.VALOR_PED;
      lCalcularImpostosModel.DESTINATARIO_UF      := IIF(lPedidoVendaModel.UF_CLI <> '', lPedidoVendaModel.UF_CLI, lEmpresaModel.UF);
      lCalcularImpostosModel.CODIGO_PRODUTO       := lPedidoVendaModel.CODIGO_PRO;
      lCalcularImpostosModel.QUANTIDADE           := lPedidoVendaModel.QUANTIDADE_PED;
      lCalcularImpostosModel.VALORUNITARIO        := lPedidoVendaModel.VALORUNITARIO_PED;


      lCalcularImpostosModel := lCalcularImpostosModel.Processar;

      lPedidoItensModal := lPedidoItensModal.carregaClasse(lPedidoVendaModel.PEDIDOITENS_ID);

      lPedidoItensModal.Acao              := tacAlterar;
      lPedidoItensModal.ID                := lPedidoVendaModel.PEDIDOITENS_ID;
      lPedidoItensModal.IPI_CST           := lCalcularImpostosModel.IPI_CST;
      lPedidoItensModal.ALIQ_IPI          := FloatToStr(lCalcularImpostosModel.IPI_ALIQUOTA);
      lPedidoItensModal.VALOR_IPI         := FloatToStr(lCalcularImpostosModel.IPI_VALOR);
      lPedidoItensModal.CST               := (lCalcularImpostosModel.ICMS_CST);
      lPedidoItensModal.REDUCAO_ICMS      := FloatToStr(lCalcularImpostosModel.ICMS_REDUCAO);
      lPedidoItensModal.BASE_ICMS         := FloatToStr(lCalcularImpostosModel.ICMS_BASE);
      lPedidoItensModal.ALIQ_ICMS         := FloatToStr(lCalcularImpostosModel.ICMS_ALIQUOTA);
      lPedidoItensModal.VALOR_ICMS        := FloatToStr(lCalcularImpostosModel.ICMS_VALOR);
      lPedidoItensModal.ALIQ_ICMS_ST      := FloatToStr(lCalcularImpostosModel.ICMSST_ALIQUOTA);
      lPedidoItensModal.MVA               := FloatToStr(lCalcularImpostosModel.ICMSST_MVA);
      lPedidoItensModal.REDUCAO_ST        := FloatToStr(lCalcularImpostosModel.ICMSST_REDUCAO);
      lPedidoItensModal.VALOR_ST          := FloatToStr(lCalcularImpostosModel.ICMSST_VALOR);
      lPedidoItensModal.BASE_ST           := FloatToStr(lCalcularImpostosModel.ICMSST_BASE);
      lPedidoItensModal.PIS_CST           := (lCalcularImpostosModel.PIS_CST);
      lPedidoItensModal.ALIQ_PIS          := FloatToStr(lCalcularImpostosModel.PIS_ALIQUOTA);
      lPedidoItensModal.BASE_PIS          := FloatToStr(lCalcularImpostosModel.PIS_BASE);
      lPedidoItensModal.VALOR_PIS         := FloatToStr(lCalcularImpostosModel.PIS_VALOR);
      lPedidoItensModal.COFINS_CST        := (lCalcularImpostosModel.COFINS_CST);
      lPedidoItensModal.ALIQ_COFINS       := FloatToStr(lCalcularImpostosModel.COFINS_ALIQUOTA);
      lPedidoItensModal.BASE_COFINS       := FloatToStr(lCalcularImpostosModel.COFINS_BASE);
      lPedidoItensModal.VALOR_COFINS      := FloatToStr(lCalcularImpostosModel.COFINS_VALOR);
      lPedidoItensModal.VBCUFDEST         := FloatToStr(lCalcularImpostosModel.VBCUFDEST);
      lPedidoItensModal.PFCPUFDEST        := FloatToStr(lCalcularImpostosModel.PICMSUFDEST);
      lPedidoItensModal.PICMSUFDEST       := FloatToStr(lCalcularImpostosModel.PICMSINTER);
      lPedidoItensModal.PICMSINTER        := FloatToStr(lCalcularImpostosModel.PICMSINTERPART);
      lPedidoItensModal.PICMSINTERPART    := FloatToStr(lCalcularImpostosModel.PICMSINTERPART);
      lPedidoItensModal.VICMSUFDEST       := FloatToStr(lCalcularImpostosModel.VICMSUFDEST);
      lPedidoItensModal.VICMSUFREMET      := FloatToStr(lCalcularImpostosModel.VBCFCPST);
      lPedidoItensModal.VBCFCPST          := FloatToStr(lCalcularImpostosModel.PFCPST);
      lPedidoItensModal.PFCPST            := FloatToStr(lCalcularImpostosModel.PFCPST);
      lPedidoItensModal.VFCPST            := FloatToStr(lCalcularImpostosModel.VFCPST);
      lPedidoItensModal.CFOP_ID           := lCalcularImpostosModel.CFOP_ID;
      lPedidoItensModal.CFOP              := lCalcularImpostosModel.CFOP;
      lPedidoItensModal.DESCONTO_PED      := FloatToStr(lCalcularImpostosModel.DESCONTO_ITEM);
      lPedidoItensModal.VOUTROS           := FloatToStr(lCalcularImpostosModel.ACRESCIMO_ITEM);
      lPedidoItensModal.CSOSN             := lCalcularImpostosModel.ICMS_CSOSN;
      lPedidoItensModal.Salvar;
    end;
    if self.CFOP_ID = '' then
    begin
      self.Acao    := tacAlterar;
      self.CFOP_ID := lCalcularImpostosModel.CFOP_ID;
      self.CFOP_NF := lCalcularImpostosModel.CFOP;
      self.Salvar;
    end;
  finally
    lPedidoVendaLista.Free;
    lCalcularImpostosModel.Free;
    lPedidoItensModal.Free;
  end;
end;
function TPedidoVendaModel.Salvar: String;
var
  lPedidoVendaDao: TPedidoVendaDao;
begin
  lPedidoVendaDao := TPedidoVendaDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPedidoVendaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lPedidoVendaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lPedidoVendaDao.excluir(Self);
    end;
  finally
    lPedidoVendaDao.Free;
  end;
end;
procedure TPedidoVendaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;
procedure TPedidoVendaModel.SetACRES_PED(const Value: Variant);
begin
  FACRES_PED := Value;
end;
procedure TPedidoVendaModel.SetARQUITETO_COMISSAO(const Value: Variant);
begin
  FARQUITETO_COMISSAO := Value;
end;
procedure TPedidoVendaModel.SetARQUITETO_ID(const Value: Variant);
begin
  FARQUITETO_ID := Value;
end;
procedure TPedidoVendaModel.SetARQUIVO_XML_NF(const Value: Variant);
begin
  FARQUIVO_XML_NF := Value;
end;
procedure TPedidoVendaModel.SetBAIRRO_CLI(const Value: Variant);
begin
  FBAIRRO_CLI := Value;
end;
procedure TPedidoVendaModel.SetCARGA_ID(const Value: Variant);
begin
  FCARGA_ID := Value;
end;
procedure TPedidoVendaModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;
procedure TPedidoVendaModel.SetCFOP_NF(const Value: Variant);
begin
  FCFOP_NF := Value;
end;
procedure TPedidoVendaModel.SetCF_ABERTO(const Value: Variant);
begin
  FCF_ABERTO := Value;
end;
procedure TPedidoVendaModel.SetCHAVE_XML_NF(const Value: Variant);
begin
  FCHAVE_XML_NF := Value;
end;
procedure TPedidoVendaModel.SetCIDADE_CLI(const Value: Variant);
begin
  FCIDADE_CLI := Value;
end;
procedure TPedidoVendaModel.SetCNPJ_CPF_CLI(const Value: Variant);
begin
  FCNPJ_CPF_CLI := Value;
end;
procedure TPedidoVendaModel.SetCNPJ_CPF_CONSUMIDOR(const Value: Variant);
begin
  FCNPJ_CPF_CONSUMIDOR := Value;
end;
procedure TPedidoVendaModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;
procedure TPedidoVendaModel.SetCODIGO_PORT(const Value: Variant);
begin
  FCODIGO_PORT := Value;
end;
procedure TPedidoVendaModel.SetCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
end;
procedure TPedidoVendaModel.SetCODIGO_TIP(const Value: Variant);
begin
  FCODIGO_TIP := Value;
end;

procedure TPedidoVendaModel.SetCODIGO_VEN(const Value: Variant);
begin
  FCODIGO_VEN := Value;
  getDataVendedor;
end;

procedure TPedidoVendaModel.SetCOMANDA(const Value: Variant);
begin
  FCOMANDA := Value;
end;
procedure TPedidoVendaModel.SetCONDICOES2_PAG(const Value: Variant);
begin
  FCONDICOES2_PAG := Value;
end;
procedure TPedidoVendaModel.SetCONDICOES_PAG(const Value: Variant);
begin
  FCONDICOES_PAG := Value;
end;
procedure TPedidoVendaModel.SetCONTATO_PED(const Value: Variant);
begin
  FCONTATO_PED := Value;
end;
procedure TPedidoVendaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TPedidoVendaModel.SetCTR_ENVIO_BOLETO(const Value: Variant);
begin
  FCTR_ENVIO_BOLETO := Value;
end;
procedure TPedidoVendaModel.SetCTR_ENVIO_NFE(const Value: Variant);
begin
  FCTR_ENVIO_NFE := Value;
end;
procedure TPedidoVendaModel.SetCTR_ENVIO_PEDIDO(const Value: Variant);
begin
  FCTR_ENVIO_PEDIDO := Value;
end;
procedure TPedidoVendaModel.SetCTR_EXPORTACAO(const Value: Variant);
begin
  FCTR_EXPORTACAO := Value;
end;
procedure TPedidoVendaModel.SetCTR_IMPRESSAO_ITENS(const Value: Variant);
begin
  FCTR_IMPRESSAO_ITENS := Value;
end;
procedure TPedidoVendaModel.SetCTR_IMPRESSAO_PED(const Value: Variant);
begin
  FCTR_IMPRESSAO_PED := Value;
end;
procedure TPedidoVendaModel.SetDATAHORA_COLETA(const Value: Variant);
begin
  FDATAHORA_COLETA := Value;
end;
procedure TPedidoVendaModel.SetDATAHORA_IMPRESSO(const Value: Variant);
begin
  FDATAHORA_IMPRESSO := Value;
end;
procedure TPedidoVendaModel.SetDATAHORA_RETIRADA(const Value: Variant);
begin
  FDATAHORA_RETIRADA := Value;
end;
procedure TPedidoVendaModel.SetDATA_COTACAO(const Value: Variant);
begin
  FDATA_COTACAO := Value;
end;
procedure TPedidoVendaModel.SetDATA_FATURADO(const Value: Variant);
begin
  FDATA_FATURADO := Value;
end;
procedure TPedidoVendaModel.SetDATA_FINALIZADO(const Value: Variant);
begin
  FDATA_FINALIZADO := Value;
end;
procedure TPedidoVendaModel.SetDATA_PED(const Value: Variant);
begin
  FDATA_PED := Value;
end;
procedure TPedidoVendaModel.SetDESCONTO_DRG(const Value: Variant);
begin
  FDESCONTO_DRG := Value;
end;
procedure TPedidoVendaModel.SetDESCONTO_PED(const Value: Variant);
begin
  FDESCONTO_PED := Value;
end;
procedure TPedidoVendaModel.SetDESC_PED(const Value: Variant);
begin
  FDESC_PED := Value;
end;
procedure TPedidoVendaModel.SetDOLAR(const Value: Variant);
begin
  FDOLAR := Value;
end;
procedure TPedidoVendaModel.SetENDERECO(const Value: Variant);
begin
  FENDERECO := Value;
end;
procedure TPedidoVendaModel.SetENTRADA_PORTADOR_ID(const Value: Variant);
begin
  FENTRADA_PORTADOR_ID := Value;
end;
procedure TPedidoVendaModel.SetENTREGA(const Value: Variant);
begin
  FENTREGA := Value;
end;
procedure TPedidoVendaModel.SetENTREGADOR_ID(const Value: Variant);
begin
  FENTREGADOR_ID := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_AGENDA_ID(const Value: Variant);
begin
  FENTREGA_AGENDA_ID := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_BAIRRO(const Value: Variant);
begin
  FENTREGA_BAIRRO := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_CELULAR(const Value: Variant);
begin
  FENTREGA_CELULAR := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_CEP(const Value: Variant);
begin
  FENTREGA_CEP := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_CIDADE(const Value: Variant);
begin
  FENTREGA_CIDADE := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_COD_MUNICIPIO(const Value: Variant);
begin
  FENTREGA_COD_MUNICIPIO := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_COMPLEMENTO(const Value: Variant);
begin
  FENTREGA_COMPLEMENTO := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_CONTATO(const Value: Variant);
begin
  FENTREGA_CONTATO := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_ENDERECO(const Value: Variant);
begin
  FENTREGA_ENDERECO := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_HORA(const Value: Variant);
begin
  FENTREGA_HORA := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_NUMERO(const Value: Variant);
begin
  FENTREGA_NUMERO := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_OBSERVACAO(const Value: Variant);
begin
  FENTREGA_OBSERVACAO := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_REGIAO_ID(const Value: Variant);
begin
  FENTREGA_REGIAO_ID := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_TELEFONE(const Value: Variant);
begin
  FENTREGA_TELEFONE := Value;
end;
procedure TPedidoVendaModel.SetENTREGA_UF(const Value: Variant);
begin
  FENTREGA_UF := Value;
end;
procedure TPedidoVendaModel.SetENTREGUE(const Value: Variant);
begin
  FENTREGUE := Value;
end;
procedure TPedidoVendaModel.SetESPECIE_VOLUME(const Value: Variant);
begin
  FESPECIE_VOLUME := Value;
end;
procedure TPedidoVendaModel.SetFANTASIA_CLI(const Value: Variant);
begin
  FFANTASIA_CLI := Value;
end;
procedure TPedidoVendaModel.SetFATURA_ID(const Value: Variant);
begin
  FFATURA_ID := Value;
end;
procedure TPedidoVendaModel.SetFORM(const Value: Variant);
begin
  FFORM := Value;
end;
procedure TPedidoVendaModel.SetFRETE_PED(const Value: Variant);
begin
  FFRETE_PED := Value;
end;
procedure TPedidoVendaModel.SetGERENTE_ID(const Value: Variant);
begin
  FGERENTE_ID := Value;
end;
procedure TPedidoVendaModel.SetGERENTE_TIPO_COMISSAO(const Value: Variant);
begin
  FGERENTE_TIPO_COMISSAO := Value;
end;
procedure TPedidoVendaModel.SetHORA_PED(const Value: Variant);
begin
  FHORA_PED := Value;
end;
procedure TPedidoVendaModel.SetPARCELAS2_PED(const Value: Variant);
begin
  FPARCELAS2_PED := Value;
end;
procedure TPedidoVendaModel.SetPARCELAS_PED(const Value: Variant);
begin
  FPARCELAS_PED := Value;
end;
procedure TPedidoVendaModel.SetPARCELA_PED(const Value: Variant);
begin
  FPARCELA_PED := Value;
end;
procedure TPedidoVendaModel.SetPATRIMONIO_OBSERVACAO(const Value: Variant);
begin
  FPATRIMONIO_OBSERVACAO := Value;
end;
procedure TPedidoVendaModel.SetPEDIDOITENS_ID(const Value: Variant);
begin
  FPEDIDOITENS_ID := Value;
end;

procedure TPedidoVendaModel.SetPedidoVendasLista(const Value: TObjectList<TPedidoVendaModel>);
begin
  FPedidoVendasLista := Value;
end;

procedure TPedidoVendaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPedidoVendaModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPedidoVendaModel.SetIDUsuario(const Value: String);
begin
  FIDUsuario := Value;
end;

procedure TPedidoVendaModel.SetPEDIDO_COMPRA(const Value: Variant);
begin
  FPEDIDO_COMPRA := Value;
end;

procedure TPedidoVendaModel.SetPEDIDO_VIDRACARIA(const Value: Variant);
begin
  FPEDIDO_VIDRACARIA := Value;
end;

procedure TPedidoVendaModel.SetPESO_BRUTO(const Value: Variant);
begin
  FPESO_BRUTO := Value;
end;

procedure TPedidoVendaModel.SetPESO_LIQUIDO(const Value: Variant);
begin
  FPESO_LIQUIDO := Value;
end;

procedure TPedidoVendaModel.SetPESO_PED(const Value: Variant);
begin
  FPESO_PED := Value;
end;

procedure TPedidoVendaModel.SetPLACA(const Value: Variant);
begin
  FPLACA := Value;
end;

procedure TPedidoVendaModel.SetPOS_VENDA(const Value: Variant);
begin
  FPOS_VENDA := Value;
end;

procedure TPedidoVendaModel.SetPRECO_VENDA_ID(const Value: Variant);
begin
  FPRECO_VENDA_ID := Value;
end;

procedure TPedidoVendaModel.SetPRIMEIROVENC2_PED(const Value: Variant);
begin
  FPRIMEIROVENC2_PED := Value;
end;

procedure TPedidoVendaModel.SetPRIMEIROVENC_PED(const Value: Variant);
begin
  FPRIMEIROVENC_PED := Value;
end;

procedure TPedidoVendaModel.SetPRODUCAO_ID(const Value: Variant);
begin
  FPRODUCAO_ID := Value;
end;

procedure TPedidoVendaModel.SetQTDEITENS(const Value: Variant);
begin
  FQTDEITENS := Value;
end;

procedure TPedidoVendaModel.SetQTDE_VOLUME(const Value: Variant);
begin
  FQTDE_VOLUME := Value;
end;

procedure TPedidoVendaModel.SetQUANTIDADE_PED(const Value: Variant);
begin
  FQUANTIDADE_PED := Value;
end;

procedure TPedidoVendaModel.SetREGIAO_ID(const Value: Variant);
begin
  FREGIAO_ID := Value;
end;

procedure TPedidoVendaModel.SetRESERVADO(const Value: Variant);
begin
  FRESERVADO := Value;
end;

procedure TPedidoVendaModel.SetRNTRC(const Value: Variant);
begin
  FRNTRC := Value;
end;

procedure TPedidoVendaModel.SetIMP_TICKET(const Value: Variant);
begin
  FIMP_TICKET := Value;
end;

procedure TPedidoVendaModel.SetINDCE_PED(const Value: Variant);
begin
  FINDCE_PED := Value;
end;

procedure TPedidoVendaModel.SetINDICACAO_ID(const Value: Variant);
begin
  FINDICACAO_ID := Value;
end;

procedure TPedidoVendaModel.SetINFORMACOES_PED(const Value: Variant);
begin
  FINFORMACOES_PED := Value;
end;

procedure TPedidoVendaModel.SetLACA_OU_GLASS(const Value: Variant);
begin
  FLACA_OU_GLASS := Value;
end;

procedure TPedidoVendaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoVendaModel.SetLISTA_NOIVA_ID(const Value: Variant);
begin
  FLISTA_NOIVA_ID := Value;
end;

procedure TPedidoVendaModel.SetLOCAL_PED(const Value: Variant);
begin
  FLOCAL_PED := Value;
end;

procedure TPedidoVendaModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TPedidoVendaModel.SetLOTE_CARGA_ID(const Value: Variant);
begin
  FLOTE_CARGA_ID := Value;
end;

procedure TPedidoVendaModel.SetMONTAGEM_DATA(const Value: Variant);
begin
  FMONTAGEM_DATA := Value;
end;

procedure TPedidoVendaModel.SetMONTAGEM_HORA(const Value: Variant);
begin
  FMONTAGEM_HORA := Value;
end;

procedure TPedidoVendaModel.SetNAO_FISCAL_ABERTO(const Value: Variant);
begin
  FNAO_FISCAL_ABERTO := Value;
end;

procedure TPedidoVendaModel.SetNOME_VENDEDOR(const Value: Variant);
begin
  FNOME_VENDEDOR := Value;
end;

procedure TPedidoVendaModel.SetNUMERO_CF(const Value: Variant);
begin
  FNUMERO_CF := Value;
end;

procedure TPedidoVendaModel.SetNUMERO_NF(const Value: Variant);
begin
  FNUMERO_NF := Value;
end;

procedure TPedidoVendaModel.SetNUMERO_ORC(const Value: Variant);
begin
  FNUMERO_ORC := Value;
end;

procedure TPedidoVendaModel.SetNUMERO_PED(const Value: Variant);
begin
  FNUMERO_PED := Value;
end;

procedure TPedidoVendaModel.SetNUMERO_SENHA(const Value: Variant);
begin
  FNUMERO_SENHA := Value;
end;

procedure TPedidoVendaModel.SetOBS_GERAL(const Value: Variant);
begin
  FOBS_GERAL := Value;
end;

procedure TPedidoVendaModel.SetORDEM(const Value: Variant);
begin
  FORDEM := Value;
end;

procedure TPedidoVendaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoVendaModel.SetSMS(const Value: Variant);
begin
  FSMS := Value;
end;

procedure TPedidoVendaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPedidoVendaModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TPedidoVendaModel.SetSTATUS_ID(const Value: Variant);
begin
  FSTATUS_ID := Value;
end;

procedure TPedidoVendaModel.SetSTATUS_PED(const Value: Variant);
begin
  FSTATUS_PED := Value;
end;

procedure TPedidoVendaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPedidoVendaModel.SetTABJUROS_PED(const Value: Variant);
begin
  FTABJUROS_PED := Value;
end;

procedure TPedidoVendaModel.SetTELEVENDA_PED(const Value: Variant);
begin
  FTELEVENDA_PED := Value;
end;

procedure TPedidoVendaModel.SetTIPO_COMISSAO(const Value: Variant);
begin
  FTIPO_COMISSAO := Value;
end;

procedure TPedidoVendaModel.SetTIPO_FRETE(const Value: Variant);
begin
  FTIPO_FRETE := Value;
end;

procedure TPedidoVendaModel.SetTIPO_PED(const Value: Variant);
begin
  FTIPO_PED := Value;
end;

procedure TPedidoVendaModel.SetTOTAL1_PED(const Value: Variant);
begin
  FTOTAL1_PED := Value;
end;

procedure TPedidoVendaModel.SetTOTAL2_PED(const Value: Variant);
begin
  FTOTAL2_PED := Value;
end;

procedure TPedidoVendaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPedidoVendaModel.SetTOTAL_PED(const Value: Variant);
begin
  FTOTAL_PED := Value;
end;

procedure TPedidoVendaModel.SetUF_CLI(const Value: Variant);
begin
  FUF_CLI := Value;
end;

procedure TPedidoVendaModel.SetUF_TRANSPORTADORA(const Value: Variant);
begin
  FUF_TRANSPORTADORA := Value;
end;

procedure TPedidoVendaModel.SetUSUARIO_PED(const Value: Variant);
begin
  FUSUARIO_PED := Value;
end;

procedure TPedidoVendaModel.SetVALORENTADA_PED(const Value: Variant);
begin
  FVALORENTADA_PED := Value;
end;

procedure TPedidoVendaModel.SetVALORUNITARIO_PED(const Value: Variant);
begin
  FVALORUNITARIO_PED := Value;
end;

procedure TPedidoVendaModel.SetVALOR_DESPESA_VENDA(const Value: Variant);
begin
  FVALOR_DESPESA_VENDA := Value;
end;

procedure TPedidoVendaModel.SetVALOR_IPI(const Value: Variant);
begin
  FVALOR_IPI := Value;
end;

procedure TPedidoVendaModel.SetVALOR_PAGO(const Value: Variant);
begin
  FVALOR_PAGO := Value;
end;

procedure TPedidoVendaModel.SetVALOR_PED(const Value: Variant);
begin
  FVALOR_PED := Value;
end;

procedure TPedidoVendaModel.SetVALOR_RESTITUICAO(const Value: Variant);
begin
  FVALOR_RESTITUICAO := Value;
end;

procedure TPedidoVendaModel.SetVALOR_SUFRAMA(const Value: Variant);
begin
  FVALOR_SUFRAMA := Value;
end;

procedure TPedidoVendaModel.SetVALOR_TAXA_SERVICO(const Value: Variant);
begin
  FVALOR_TAXA_SERVICO := Value;
end;

procedure TPedidoVendaModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TPedidoVendaModel.SetVFCPUFDEST(const Value: Variant);
begin
  FVFCPUFDEST := Value;
end;

procedure TPedidoVendaModel.SetVICMSDESON(const Value: Variant);
begin
  FVICMSDESON := Value;
end;

procedure TPedidoVendaModel.SetVICMSUFDEST(const Value: Variant);
begin
  FVICMSUFDEST := Value;
end;

procedure TPedidoVendaModel.SetVICMSUFREMET(const Value: Variant);
begin
  FVICMSUFREMET := Value;
end;

procedure TPedidoVendaModel.SetVLR_GARANTIA(const Value: Variant);
begin
  FVLR_GARANTIA := Value;
end;

procedure TPedidoVendaModel.SetWEB_PEDIDO_ID(const Value: Variant);
begin
  FWEB_PEDIDO_ID := Value;
end;

procedure TPedidoVendaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TPedidoVendaModel.SetZERAR_ST(const Value: Variant);
begin
  FZERAR_ST := Value;
end;

function TPedidoVendaModel.statusPedido(pId: String): String;
var
  lPedidoVendaDao: TPedidoVendaDao;
begin
  lPedidoVendaDao := TPedidoVendaDao.Create(vIConexao);
  try
    Result := lPedidoVendaDao.statusPedido(pId);
  finally
    lPedidoVendaDao.Free;
  end;
end;

end.
