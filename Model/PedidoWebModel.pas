unit PedidoWebModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TPedidoWebModel = class

  private
    vIConexao : IConexao;
    FPedidoWebsLista: TObjectList<TPedidoWebModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCUPOM_DESCONTO: Variant;
    FFRETE_LARGURA: Variant;
    FCORREIO_DATA: Variant;
    FDATA_EXPORTACAO: Variant;
    FCUPOM_VALOR: Variant;
    FENTREGA_BAIRRO: Variant;
    FIDPEDIDOSOVISUSUARIO: Variant;
    FDADOS_ADICIONAIS: Variant;
    FTIPOVENDA_ID: Variant;
    FUSUARIO_ANALISANDO: Variant;
    FENTREGA_HORA: Variant;
    FACRESCIMO: Variant;
    FOBSERVACAO: Variant;
    FPRECO_VENDA_ID: Variant;
    FREGIAO_ID: Variant;
    FIMPRESSAO: Variant;
    FDATAHORA: Variant;
    FDATA_HORA_APROVACAO: Variant;
    FPRIMEIRO_VENCIMENTO: Variant;
    FDADOS_AUTORIZACAO: Variant;
    FENTREGA_UF: Variant;
    FMONTAGEM_DATA: Variant;
    FVALOR_TOTAL: Variant;
    FPORTADOR_ID: Variant;
    FIDPEDIDOSOVIS: Variant;
    FPEDIDO_COMPRA: Variant;
    FPRE_ANALISE_USUARIO_ID: Variant;
    FFATURAR: Variant;
    FUSUARIO_APROVACAO: Variant;
    FENVIAR_EMAIL: Variant;
    FCORREIO_HORA: Variant;
    FTRANSPORTADORA_ID: Variant;
    FSTATUS_ANALISE: Variant;
    FCONDICOES2_PAG: Variant;
    FPEDIDO_ID: Variant;
    FCONTROLEALTERACAO: Variant;
    FENTREGA_CEP: Variant;
    FPED_PLATAFORMA: Variant;
    FENTREGA_NUMERO: Variant;
    FPRE_ANALISE_DATAHORA: Variant;
    FMONTAGEM_HORA: Variant;
    FVALOR_ST: Variant;
    FCLIENTE_ID: Variant;
    FSUBSTATUS: Variant;
    FID: Variant;
    FMARKETPLACE: Variant;
    FFRETE_PROFUNDIDADE: Variant;
    FPROPOSTA: Variant;
    FUUID_SOVIS: Variant;
    FDATA_HORA_ANALISE: Variant;
    FISGIFT: Variant;
    FPERIOD: Variant;
    FMENSAGEM_ANALISE: Variant;
    FFRETE_PESO: Variant;
    FCAMINHO_NFE: Variant;
    FSTATUS: Variant;
    FVENDEDOR_ID: Variant;
    FLOJA: Variant;
    FENTREGA_COMPLEMENTO: Variant;
    FUSUARIO_ANALISE: Variant;
    FFRETE_VALOR: Variant;
    FUSAR_TABELA_PRECO: Variant;
    FVALOR_FRETE: Variant;
    FSYSTIME: Variant;
    FCAMINHO_BOLETO: Variant;
    FCONDICOES_PAGAMENTO: Variant;
    FSTATUS_SOVIS: Variant;
    FPARCELAS: Variant;
    FCODIGO_AUTORIZACAO_CARTAO: Variant;
    FLOTE_EXPORTACAO: Variant;
    FCORREIO_VOLUME: Variant;
    FORIGEM_PEDIDO: Variant;
    FPERCENTUAL_DESCONTO: Variant;
    FCUPOM_TIPO: Variant;
    FENTREGA_CIDADE: Variant;
    FVALOR_CUPOM_DESCONTO: Variant;
    FFRETE_ALTURA: Variant;
    FENTREGA_ENDERECO: Variant;
    FDATA_CONSUMO_OMINIONE: Variant;
    FDATA_HORA_REPROVADO: Variant;
    FENTREGA_DATA: Variant;
    FEVENTO: Variant;
    FUSUARIO: Variant;
    FPRE_ANALISE_STATUS: Variant;
    FENTREGA_COD_MUNICIPIO: Variant;
    FTIPO: Variant;
    FTRANSPORTADORA_DADOS_ADICIONAIS: Variant;
    FSAIDA_ID: Variant;
    FUSUARIO_REPROVADO: Variant;
    FDATA: Variant;
    FINTERMEDIADOR_ID: Variant;
    FVALOR_ENTRADA: Variant;
    FCODIGO_CUPOM_DESCONTO: Variant;
    FOBSERVACOES: Variant;
    FCLIENTE_NOME: Variant;
    FVALOR_ITENS: Variant;
    FVALOR_GARANTIA: Variant;
    FIDUsuario: String;
    FTIPO_COMISSAO: Variant;
    FGERENTE_ID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPedidoWebsLista(const Value: TObjectList<TPedidoWebModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetACRESCIMO(const Value: Variant);
    procedure SetCAMINHO_BOLETO(const Value: Variant);
    procedure SetCAMINHO_NFE(const Value: Variant);
    procedure SetCLIENTE_ID(const Value: Variant);
    procedure SetCODIGO_AUTORIZACAO_CARTAO(const Value: Variant);
    procedure SetCODIGO_CUPOM_DESCONTO(const Value: Variant);
    procedure SetCONDICOES_PAGAMENTO(const Value: Variant);
    procedure SetCONDICOES2_PAG(const Value: Variant);
    procedure SetCONTROLEALTERACAO(const Value: Variant);
    procedure SetCORREIO_DATA(const Value: Variant);
    procedure SetCORREIO_HORA(const Value: Variant);
    procedure SetCORREIO_VOLUME(const Value: Variant);
    procedure SetCUPOM_DESCONTO(const Value: Variant);
    procedure SetCUPOM_TIPO(const Value: Variant);
    procedure SetCUPOM_VALOR(const Value: Variant);
    procedure SetDADOS_ADICIONAIS(const Value: Variant);
    procedure SetDADOS_AUTORIZACAO(const Value: Variant);
    procedure SetDATA(const Value: Variant);
    procedure SetDATA_CONSUMO_OMINIONE(const Value: Variant);
    procedure SetDATA_EXPORTACAO(const Value: Variant);
    procedure SetDATA_HORA_ANALISE(const Value: Variant);
    procedure SetDATA_HORA_APROVACAO(const Value: Variant);
    procedure SetDATA_HORA_REPROVADO(const Value: Variant);
    procedure SetDATAHORA(const Value: Variant);
    procedure SetENTREGA_BAIRRO(const Value: Variant);
    procedure SetENTREGA_CEP(const Value: Variant);
    procedure SetENTREGA_CIDADE(const Value: Variant);
    procedure SetENTREGA_COD_MUNICIPIO(const Value: Variant);
    procedure SetENTREGA_COMPLEMENTO(const Value: Variant);
    procedure SetENTREGA_DATA(const Value: Variant);
    procedure SetENTREGA_ENDERECO(const Value: Variant);
    procedure SetENTREGA_HORA(const Value: Variant);
    procedure SetENTREGA_NUMERO(const Value: Variant);
    procedure SetENTREGA_UF(const Value: Variant);
    procedure SetENVIAR_EMAIL(const Value: Variant);
    procedure SetEVENTO(const Value: Variant);
    procedure SetFATURAR(const Value: Variant);
    procedure SetFRETE_ALTURA(const Value: Variant);
    procedure SetFRETE_LARGURA(const Value: Variant);
    procedure SetFRETE_PESO(const Value: Variant);
    procedure SetFRETE_PROFUNDIDADE(const Value: Variant);
    procedure SetFRETE_VALOR(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIDPEDIDOSOVIS(const Value: Variant);
    procedure SetIDPEDIDOSOVISUSUARIO(const Value: Variant);
    procedure SetIMPRESSAO(const Value: Variant);
    procedure SetINTERMEDIADOR_ID(const Value: Variant);
    procedure SetISGIFT(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLOTE_EXPORTACAO(const Value: Variant);
    procedure SetMARKETPLACE(const Value: Variant);
    procedure SetMENSAGEM_ANALISE(const Value: Variant);
    procedure SetMONTAGEM_DATA(const Value: Variant);
    procedure SetMONTAGEM_HORA(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetOBSERVACOES(const Value: Variant);
    procedure SetORIGEM_PEDIDO(const Value: Variant);
    procedure SetPARCELAS(const Value: Variant);
    procedure SetPED_PLATAFORMA(const Value: Variant);
    procedure SetPEDIDO_COMPRA(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetPERCENTUAL_DESCONTO(const Value: Variant);
    procedure SetPERIOD(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetPRE_ANALISE_DATAHORA(const Value: Variant);
    procedure SetPRE_ANALISE_STATUS(const Value: Variant);
    procedure SetPRE_ANALISE_USUARIO_ID(const Value: Variant);
    procedure SetPRECO_VENDA_ID(const Value: Variant);
    procedure SetPRIMEIRO_VENCIMENTO(const Value: Variant);
    procedure SetPROPOSTA(const Value: Variant);
    procedure SetREGIAO_ID(const Value: Variant);
    procedure SetSAIDA_ID(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSTATUS_ANALISE(const Value: Variant);
    procedure SetSTATUS_SOVIS(const Value: Variant);
    procedure SetSUBSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetTIPOVENDA_ID(const Value: Variant);
    procedure SetTRANSPORTADORA_DADOS_ADICIONAIS(const Value: Variant);
    procedure SetTRANSPORTADORA_ID(const Value: Variant);
    procedure SetUSAR_TABELA_PRECO(const Value: Variant);
    procedure SetUSUARIO(const Value: Variant);
    procedure SetUSUARIO_ANALISANDO(const Value: Variant);
    procedure SetUSUARIO_ANALISE(const Value: Variant);
    procedure SetUSUARIO_APROVACAO(const Value: Variant);
    procedure SetUSUARIO_REPROVADO(const Value: Variant);
    procedure SetUUID_SOVIS(const Value: Variant);
    procedure SetVALOR_CUPOM_DESCONTO(const Value: Variant);
    procedure SetVALOR_ENTRADA(const Value: Variant);
    procedure SetVALOR_FRETE(const Value: Variant);
    procedure SetVALOR_ST(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);
    procedure SetVENDEDOR_ID(const Value: Variant);
    procedure SetCLIENTE_NOME(const Value: Variant);
    procedure SetVALOR_GARANTIA(const Value: Variant);
    procedure SetVALOR_ITENS(const Value: Variant);
    procedure SetIDUsuario(const Value: String);
    procedure SetGERENTE_ID(const Value: Variant);
    procedure SetTIPO_COMISSAO(const Value: Variant);
  public
      procedure AfterConstruction; override;
    property ID: Variant read FID write SetID;
    property LOJA: Variant read FLOJA write SetLOJA;
    property DATAHORA: Variant read FDATAHORA write SetDATAHORA;
    property CLIENTE_ID: Variant read FCLIENTE_ID write SetCLIENTE_ID;
    property VENDEDOR_ID: Variant read FVENDEDOR_ID write SetVENDEDOR_ID;
    property PORTADOR_ID: Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property TIPOVENDA_ID: Variant read FTIPOVENDA_ID write SetTIPOVENDA_ID;
    property CONDICOES_PAGAMENTO: Variant read FCONDICOES_PAGAMENTO write SetCONDICOES_PAGAMENTO;
    property PERCENTUAL_DESCONTO: Variant read FPERCENTUAL_DESCONTO write SetPERCENTUAL_DESCONTO;
    property VALOR_FRETE: Variant read FVALOR_FRETE write SetVALOR_FRETE;
    property VALOR_ST: Variant read FVALOR_ST write SetVALOR_ST;
    property OBSERVACAO: Variant read FOBSERVACAO write SetOBSERVACAO;
    property OBSERVACOES: Variant read FOBSERVACOES write SetOBSERVACOES;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property SUBSTATUS: Variant read FSUBSTATUS write SetSUBSTATUS;
    property PEDIDO_ID: Variant read FPEDIDO_ID write SetPEDIDO_ID;
    property ORIGEM_PEDIDO: Variant read FORIGEM_PEDIDO write SetORIGEM_PEDIDO;
    property PEDIDO_COMPRA: Variant read FPEDIDO_COMPRA write SetPEDIDO_COMPRA;
    property ACRESCIMO: Variant read FACRESCIMO write SetACRESCIMO;
    property ISGIFT: Variant read FISGIFT write SetISGIFT;
    property VALOR_TOTAL: Variant read FVALOR_TOTAL write SetVALOR_TOTAL;
    property CODIGO_CUPOM_DESCONTO: Variant read FCODIGO_CUPOM_DESCONTO write SetCODIGO_CUPOM_DESCONTO;
    property VALOR_CUPOM_DESCONTO: Variant read FVALOR_CUPOM_DESCONTO write SetVALOR_CUPOM_DESCONTO;
    property DADOS_ADICIONAIS: Variant read FDADOS_ADICIONAIS write SetDADOS_ADICIONAIS;
    property DATA: Variant read FDATA write SetDATA;
    property CONTROLEALTERACAO: Variant read FCONTROLEALTERACAO write SetCONTROLEALTERACAO;
    property USUARIO: Variant read FUSUARIO write SetUSUARIO;
    property TRANSPORTADORA_ID: Variant read FTRANSPORTADORA_ID write SetTRANSPORTADORA_ID;
    property EVENTO: Variant read FEVENTO write SetEVENTO;
    property IMPRESSAO: Variant read FIMPRESSAO write SetIMPRESSAO;
    property IDPEDIDOSOVIS: Variant read FIDPEDIDOSOVIS write SetIDPEDIDOSOVIS;
    property CORREIO_VOLUME: Variant read FCORREIO_VOLUME write SetCORREIO_VOLUME;
    property CORREIO_DATA: Variant read FCORREIO_DATA write SetCORREIO_DATA;
    property CORREIO_HORA: Variant read FCORREIO_HORA write SetCORREIO_HORA;
    property ENVIAR_EMAIL: Variant read FENVIAR_EMAIL write SetENVIAR_EMAIL;
    property TRANSPORTADORA_DADOS_ADICIONAIS: Variant read FTRANSPORTADORA_DADOS_ADICIONAIS write SetTRANSPORTADORA_DADOS_ADICIONAIS;
    property DADOS_AUTORIZACAO: Variant read FDADOS_AUTORIZACAO write SetDADOS_AUTORIZACAO;
    property PARCELAS: Variant read FPARCELAS write SetPARCELAS;
    property VALOR_ENTRADA: Variant read FVALOR_ENTRADA write SetVALOR_ENTRADA;
    property PRIMEIRO_VENCIMENTO: Variant read FPRIMEIRO_VENCIMENTO write SetPRIMEIRO_VENCIMENTO;
    property IDPEDIDOSOVISUSUARIO: Variant read FIDPEDIDOSOVISUSUARIO write SetIDPEDIDOSOVISUSUARIO;
    property USAR_TABELA_PRECO: Variant read FUSAR_TABELA_PRECO write SetUSAR_TABELA_PRECO;
    property TIPO: Variant read FTIPO write SetTIPO;
    property DATA_HORA_ANALISE: Variant read FDATA_HORA_ANALISE write SetDATA_HORA_ANALISE;
    property USUARIO_ANALISE: Variant read FUSUARIO_ANALISE write SetUSUARIO_ANALISE;
    property DATA_HORA_APROVACAO: Variant read FDATA_HORA_APROVACAO write SetDATA_HORA_APROVACAO;
    property USUARIO_APROVACAO: Variant read FUSUARIO_APROVACAO write SetUSUARIO_APROVACAO;
    property MENSAGEM_ANALISE: Variant read FMENSAGEM_ANALISE write SetMENSAGEM_ANALISE;
    property STATUS_SOVIS: Variant read FSTATUS_SOVIS write SetSTATUS_SOVIS;
    property FATURAR: Variant read FFATURAR write SetFATURAR;
    property CAMINHO_BOLETO: Variant read FCAMINHO_BOLETO write SetCAMINHO_BOLETO;
    property CAMINHO_NFE: Variant read FCAMINHO_NFE write SetCAMINHO_NFE;
    property UUID_SOVIS: Variant read FUUID_SOVIS write SetUUID_SOVIS;
    property ENTREGA_DATA: Variant read FENTREGA_DATA write SetENTREGA_DATA;
    property ENTREGA_HORA: Variant read FENTREGA_HORA write SetENTREGA_HORA;
    property MONTAGEM_DATA: Variant read FMONTAGEM_DATA write SetMONTAGEM_DATA;
    property MONTAGEM_HORA: Variant read FMONTAGEM_HORA write SetMONTAGEM_HORA;
    property USUARIO_ANALISANDO: Variant read FUSUARIO_ANALISANDO write SetUSUARIO_ANALISANDO;
    property ENTREGA_ENDERECO: Variant read FENTREGA_ENDERECO write SetENTREGA_ENDERECO;
    property ENTREGA_COMPLEMENTO: Variant read FENTREGA_COMPLEMENTO write SetENTREGA_COMPLEMENTO;
    property ENTREGA_NUMERO: Variant read FENTREGA_NUMERO write SetENTREGA_NUMERO;
    property ENTREGA_BAIRRO: Variant read FENTREGA_BAIRRO write SetENTREGA_BAIRRO;
    property ENTREGA_CIDADE: Variant read FENTREGA_CIDADE write SetENTREGA_CIDADE;
    property ENTREGA_UF: Variant read FENTREGA_UF write SetENTREGA_UF;
    property ENTREGA_CEP: Variant read FENTREGA_CEP write SetENTREGA_CEP;
    property ENTREGA_COD_MUNICIPIO: Variant read FENTREGA_COD_MUNICIPIO write SetENTREGA_COD_MUNICIPIO;
    property PRE_ANALISE_STATUS: Variant read FPRE_ANALISE_STATUS write SetPRE_ANALISE_STATUS;
    property PRE_ANALISE_USUARIO_ID: Variant read FPRE_ANALISE_USUARIO_ID write SetPRE_ANALISE_USUARIO_ID;
    property PRE_ANALISE_DATAHORA: Variant read FPRE_ANALISE_DATAHORA write SetPRE_ANALISE_DATAHORA;
    property PERIOD: Variant read FPERIOD write SetPERIOD;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property DATA_HORA_REPROVADO: Variant read FDATA_HORA_REPROVADO write SetDATA_HORA_REPROVADO;
    property USUARIO_REPROVADO: Variant read FUSUARIO_REPROVADO write SetUSUARIO_REPROVADO;
    property CONDICOES2_PAG: Variant read FCONDICOES2_PAG write SetCONDICOES2_PAG;
    property SAIDA_ID: Variant read FSAIDA_ID write SetSAIDA_ID;
    property PROPOSTA: Variant read FPROPOSTA write SetPROPOSTA;
    property FRETE_ALTURA: Variant read FFRETE_ALTURA write SetFRETE_ALTURA;
    property FRETE_PROFUNDIDADE: Variant read FFRETE_PROFUNDIDADE write SetFRETE_PROFUNDIDADE;
    property FRETE_LARGURA: Variant read FFRETE_LARGURA write SetFRETE_LARGURA;
    property FRETE_PESO: Variant read FFRETE_PESO write SetFRETE_PESO;
    property FRETE_VALOR: Variant read FFRETE_VALOR write SetFRETE_VALOR;
    property CUPOM_DESCONTO: Variant read FCUPOM_DESCONTO write SetCUPOM_DESCONTO;
    property CUPOM_TIPO: Variant read FCUPOM_TIPO write SetCUPOM_TIPO;
    property CUPOM_VALOR: Variant read FCUPOM_VALOR write SetCUPOM_VALOR;
    property MARKETPLACE: Variant read FMARKETPLACE write SetMARKETPLACE;
    property REGIAO_ID: Variant read FREGIAO_ID write SetREGIAO_ID;
    property PRECO_VENDA_ID: Variant read FPRECO_VENDA_ID write SetPRECO_VENDA_ID;
    property DATA_CONSUMO_OMINIONE: Variant read FDATA_CONSUMO_OMINIONE write SetDATA_CONSUMO_OMINIONE;
    property INTERMEDIADOR_ID: Variant read FINTERMEDIADOR_ID write SetINTERMEDIADOR_ID;
    property LOTE_EXPORTACAO: Variant read FLOTE_EXPORTACAO write SetLOTE_EXPORTACAO;
    property DATA_EXPORTACAO: Variant read FDATA_EXPORTACAO write SetDATA_EXPORTACAO;
    property STATUS_ANALISE: Variant read FSTATUS_ANALISE write SetSTATUS_ANALISE;
    property PED_PLATAFORMA: Variant read FPED_PLATAFORMA write SetPED_PLATAFORMA;
    property CODIGO_AUTORIZACAO_CARTAO: Variant read FCODIGO_AUTORIZACAO_CARTAO write SetCODIGO_AUTORIZACAO_CARTAO;
    property VALOR_ITENS: Variant read FVALOR_ITENS write SetVALOR_ITENS;
    property VALOR_GARANTIA: Variant read FVALOR_GARANTIA write SetVALOR_GARANTIA;
    property CLIENTE_NOME: Variant read FCLIENTE_NOME write SetCLIENTE_NOME;
    property TIPO_COMISSAO: Variant read FTIPO_COMISSAO write SetTIPO_COMISSAO;
    property GERENTE_ID: Variant read FGERENTE_ID write SetGERENTE_ID;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterListaVendaAssistida;
    function carregaClasse(pId: String): TPedidoWebModel;

    function aprovarVendaAssistida(pIdVendaAssistida: Integer): String;

    property PedidoWebsLista: TObjectList<TPedidoWebModel> read FPedidoWebsLista write SetPedidoWebsLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDUsuario: String read FIDUsuario write SetIDUsuario;

  end;

implementation

uses
  PedidoWebDao,
  PedidoVendaModel,
  PedidoWebItensModel,
  PedidoItensModel,
  System.SysUtils,
  FuncionarioModel,
  VariaveisGlobais, System.StrUtils;

{ TPedidoWebModel }

procedure TPedidoWebModel.AfterConstruction;
begin
  inherited;

end;

function TPedidoWebModel.aprovarVendaAssistida(pIdVendaAssistida: Integer): String;
var
  lPedidoVendaModel        : TPedidoVendaModel;
  lPedidoItensModel        : TPedidoItensModel;
  lPedidoWebItensModel     : TPedidoWebItensModel;
  lPedidoWebModel          : TPedidoWebModel;
  lPedido                  : String;
  lItem, lIndex            : Integer;
begin

  if not (pIdVendaAssistida <> 0) then
    exit;

  lPedidoWebModel        := TPedidoWebModel.Create(vIConexao);
  lPedidoVendaModel      := TPedidoVendaModel.Create(vIConexao);
  lPedidoWebItensModel   := TPedidoWebItensModel.Create(vIConexao);
  lPedidoItensModel      := TPedidoItensModel.Create(vIConexao);

  try

    lPedidoVendaModel.WhereView := ' and pedidovenda.web_pedido_id = '+ IntToStr(pIdVendaAssistida);
    lPedidoVendaModel.obterLista;

    if lPedidoVendaModel.TotalRecords > 0 then begin
      Result := lPedidoVendaModel.PedidoVendasLista[0].NUMERO_PED;
      exit;
    end;

    lPedidoWebModel := lPedidoWebModel.carregaClasse(pIdVendaAssistida.ToString);

    lPedidoVendaModel.Acao                 := tacIncluir;
    lPedidoVendaModel.LOJA                 := xEmpresaLoja;
    lPedidoVendaModel.DATA_PED             := DateToStr(xConexao.DataServer);
    lPedidoVendaModel.HORA_PED             := TimeToStr(xConexao.HoraServer);
    lPedidoVendaModel.PRIMEIROVENC_PED     := lPedidoWebModel.PRIMEIRO_VENCIMENTO;
    lPedidoVendaModel.ACRES_PED            := lPedidoWebModel.ACRESCIMO;
    lPedidoVendaModel.DESC_PED             := lPedidoWebModel.VALOR_CUPOM_DESCONTO;
    lPedidoVendaModel.DESCONTO_PED         := lPedidoWebModel.PERCENTUAL_DESCONTO;
    lPedidoVendaModel.VALOR_PED            := FloatToStr((StrToFloat(lPedidoWebModel.VALOR_TOTAL)+StrToFloat(lPedidoWebModel.VALOR_CUPOM_DESCONTO))-StrToFloat(lPedidoWebModel.ACRESCIMO));
    lPedidoVendaModel.TOTAL_PED            := lPedidoWebModel.VALOR_TOTAL;
    lPedidoVendaModel.VALORENTADA_PED      := lPedidoWebModel.VALOR_ENTRADA;
    lPedidoVendaModel.PARCELAS_PED         := lPedidoWebModel.PARCELAS;
    lPedidoVendaModel.PARCELA_PED          := '0'; //Valor da parcela
    lPedidoVendaModel.CTR_IMPRESSAO_PED    := '0';
    lPedidoVendaModel.RESERVADO            := 'N';
    lPedidoVendaModel.TIPO_FRETE           := '9';
    lPedidoVendaModel.SMS                  := 'N';
    lPedidoVendaModel.ENTREGA              := 'N';
    lPedidoVendaModel.STATUS_PED           := 'P';
    lPedidoVendaModel.STATUS               := 'P';
    lPedidoVendaModel.TIPO_PED             := 'P';
    lPedidoVendaModel.TABJUROS_PED         := 'N';
    lPedidoVendaModel.WEB_PEDIDO_ID        := lPedidoWebModel.ID;
    lPedidoVendaModel.CODIGO_CLI           := lPedidoWebModel.CLIENTE_ID;
    lPedidoVendaModel.CODIGO_PORT          := lPedidoWebModel.PORTADOR_ID;
    lPedidoVendaModel.CODIGO_VEN           := lPedidoWebModel.VENDEDOR_ID;
    lPedidoVendaModel.CODIGO_TIP           := lPedidoWebModel.TIPOVENDA_ID;
    lPedidoVendaModel.FRETE_PED            := lPedidoWebModel.VALOR_FRETE;
    lPedidoVendaModel.INFORMACOES_PED      := lPedidoWebModel.OBSERVACAO;
    lPedidoVendaModel.ENTREGA_ENDERECO     := lPedidoWebModel.ENTREGA_ENDERECO;
    lPedidoVendaModel.ENTREGA_NUMERO       := lPedidoWebModel.ENTREGA_NUMERO;
    lPedidoVendaModel.ENTREGA_BAIRRO       := lPedidoWebModel.ENTREGA_BAIRRO;
    lPedidoVendaModel.ENTREGA_CIDADE       := lPedidoWebModel.ENTREGA_CIDADE;
    lPedidoVendaModel.ENTREGA_UF           := lPedidoWebModel.ENTREGA_UF;
    lPedidoVendaModel.ENTREGA_CEP          := lPedidoWebModel.ENTREGA_CEP;
    lPedidoVendaModel.ENTREGA_COMPLEMENTO  := lPedidoWebModel.ENTREGA_COMPLEMENTO;
    lPedidoVendaModel.MONTAGEM_DATA        := lPedidoWebModel.MONTAGEM_DATA;
    lPedidoVendaModel.USUARIO_PED          := VariaveisGlobais.xUsuarioID;
    lPedidoVendaModel.IDUsuario            := VariaveisGlobais.xUsuarioID;
    lPedidoVendaModel.TIPO_COMISSAO        := self.TIPO_COMISSAO;
    lPedidoVendaModel.GERENTE_ID           := self.GERENTE_ID;

    lPedido := lPedidoVendaModel.Salvar;

    lPedidoVendaModel.NUMERO_PED := lPedido;

    lPedidoWebItensModel.IDPedidoWebView := pIdVendaAssistida;
    lPedidoWebItensModel.obterLista;

    lPedidoItensModel.PedidoItenssLista := TObjectList<TPedidoItensModel>.Create;

    lItem  := 0;
    lIndex := 0;

    for lPedidoWebItensModel in lPedidoWebItensModel.PedidoWebItenssLista do begin
      inc(lItem);

      lPedidoItensModel.PedidoItenssLista.Add(TPedidoItensModel.Create(xConexaoLocal));

      lPedidoItensModel.PedidoItenssLista[lIndex].NUMERO_PED             := lPedido;
      lPedidoItensModel.PedidoItenssLista[lIndex].CODIGO_CLI             := lPedidoWebModel.CLIENTE_ID;
      lPedidoItensModel.PedidoItenssLista[lIndex].LOJA                   := VariaveisGlobais.xEmpresaLoja;
      lPedidoItensModel.PedidoItenssLista[lIndex].QUANTIDADE_PED         := lPedidoWebItensModel.QUANTIDADE;
      lPedidoItensModel.PedidoItenssLista[lIndex].QUANTIDADE_NEW         := lPedidoWebItensModel.QUANTIDADE;
      lPedidoItensModel.PedidoItenssLista[lIndex].WEB_PEDIDOITENS_ID     := lPedidoWebItensModel.ID;
      lPedidoItensModel.PedidoItenssLista[lIndex].TIPO_VENDA             := lPedidoWebItensModel.TIPO_ENTREGA;
      lPedidoItensModel.PedidoItenssLista[lIndex].OBSERVACAO             := copy(lPedidoWebItensModel.OBSERVACAO,1,50);
      lPedidoItensModel.PedidoItenssLista[lIndex].OBS_ITEM               := lPedidoWebItensModel.OBSERVACAO;
      lPedidoItensModel.PedidoItenssLista[lIndex].CODIGO_PRO             := lPedidoWebItensModel.PRODUTO_ID;
      lPedidoItensModel.PedidoItenssLista[lIndex].QUANTIDADE_TIPO        := lPedidoWebItensModel.VLR_GARANTIA;
      lPedidoItensModel.PedidoItenssLista[lIndex].ENTREGA                := lPedidoWebItensModel.ENTREGA;
      lPedidoItensModel.PedidoItenssLista[lIndex].MONTAGEM               := lPedidoWebItensModel.MONTAGEM;
      lPedidoItensModel.PedidoItenssLista[lIndex].DESCONTO_PED           := lPedidoWebItensModel.PERCENTUAL_DESCONTO;
      lPedidoItensModel.PedidoItenssLista[lIndex].VALORUNITARIO_PED      := lPedidoWebItensModel.VALOR_UNITARIO;
      lPedidoItensModel.PedidoItenssLista[lIndex].ITEM                   := lItem.ToString;
      lPedidoItensModel.PedidoItenssLista[lIndex].VALOR_BONUS_SERVICO    := lPedidoWebItensModel.VALOR_BONUS_SERVICO;
      lPedidoItensModel.PedidoItenssLista[lIndex].BALANCA                := lPedidoWebItensModel.USAR_BALANCA;
      lPedidoItensModel.PedidoItenssLista[lIndex].VLRVENDA_PRO           := lPedidoWebItensModel.VENDA_PRO;
      lPedidoItensModel.PedidoItenssLista[lIndex].VALOR_VENDA_CADASTRO   := lPedidoWebItensModel.VENDA_PRO;
      lPedidoItensModel.PedidoItenssLista[lIndex].VLRCUSTO_PRO           := lPedidoWebItensModel.CUSTOMEDIO_PRO;
      lPedidoItensModel.PedidoItenssLista[lIndex].VALOR_MONTADOR         := lPedidoWebItensModel.VALOR_MONTADOR;
      lPedidoItensModel.PedidoItenssLista[lIndex].COMISSAO_PERCENTUAL    := lPedidoWebItensModel.PERCENTUAL_COMISSAO;
      lPedidoItensModel.PedidoItenssLista[lIndex].COMISSAO_PED           := '0';

      inc(lIndex);
    end;

    lPedidoItensModel.Acao := tacIncluirLote;
    lPedidoItensModel.Salvar;

    lPedidoVendaModel.gerarContasReceberPedido;

    lPedidoWebModel.FAcao      := tacAlterar;
    lPedidoWebModel.FSTATUS    := 'F';
    lPedidoWebModel.FPEDIDO_ID := lPedido;
    lPedidoWebModel.Salvar;

    Result := lPedido;

  finally
    lPedidoWebModel.Free;
    lPedidoVendaModel.Free;
    lPedidoWebItensModel.Free;
    lPedidoItensModel.Free;
  end;

end;

function TPedidoWebModel.carregaClasse(pId: String): TPedidoWebModel;
var
  lPedidoWebDao: TPedidoWebDao;
begin
  lPedidoWebDao := TPedidoWebDao.Create(vIConexao);
  try
    Result := lPedidoWebDao.carregaClasse(pId);
  finally
    lPedidoWebDao.Free;
  end;
end;

constructor TPedidoWebModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPedidoWebModel.Destroy;
begin

  inherited;
end;

procedure TPedidoWebModel.obterListaVendaAssistida;
var
  lPedidoWebLista: TPedidoWebDao;
begin
  lPedidoWebLista := TPedidoWebDao.Create(vIConexao);

  try
    lPedidoWebLista.TotalRecords    := FTotalRecords;
    lPedidoWebLista.WhereView       := FWhereView;
    lPedidoWebLista.CountView       := FCountView;
    lPedidoWebLista.OrderView       := FOrderView;
    lPedidoWebLista.StartRecordView := FStartRecordView;
    lPedidoWebLista.LengthPageView  := FLengthPageView;
    lPedidoWebLista.IDRecordView    := FIDRecordView;

    lPedidoWebLista.obterListaVendaAssistida;

    FTotalRecords    := lPedidoWebLista.TotalRecords;
    FPedidoWebsLista := lPedidoWebLista.PedidoWebsLista;

  finally
    lPedidoWebLista.Free;
  end;
end;

function TPedidoWebModel.Salvar: String;
var
  lPedidoWebDao: TPedidoWebDao;
begin
  lPedidoWebDao := TPedidoWebDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacAlterar: Result := lPedidoWebDao.alterar(Self);
    end;
  finally
    lPedidoWebDao.Free;
  end;
end;

procedure TPedidoWebModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPedidoWebModel.SetACRESCIMO(const Value: Variant);
begin
  FACRESCIMO := Value;
end;

procedure TPedidoWebModel.SetCAMINHO_BOLETO(const Value: Variant);
begin
  FCAMINHO_BOLETO := Value;
end;

procedure TPedidoWebModel.SetCAMINHO_NFE(const Value: Variant);
begin
  FCAMINHO_NFE := Value;
end;

procedure TPedidoWebModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TPedidoWebModel.SetCLIENTE_NOME(const Value: Variant);
begin
  FCLIENTE_NOME := Value;
end;

procedure TPedidoWebModel.SetCODIGO_AUTORIZACAO_CARTAO(const Value: Variant);
begin
  FCODIGO_AUTORIZACAO_CARTAO := Value;
end;

procedure TPedidoWebModel.SetCODIGO_CUPOM_DESCONTO(const Value: Variant);
begin
  FCODIGO_CUPOM_DESCONTO := Value;
end;

procedure TPedidoWebModel.SetCONDICOES2_PAG(const Value: Variant);
begin
  FCONDICOES2_PAG := Value;
end;

procedure TPedidoWebModel.SetCONDICOES_PAGAMENTO(const Value: Variant);
begin
  FCONDICOES_PAGAMENTO := Value;
end;

procedure TPedidoWebModel.SetCONTROLEALTERACAO(const Value: Variant);
begin
  FCONTROLEALTERACAO := Value;
end;

procedure TPedidoWebModel.SetCORREIO_DATA(const Value: Variant);
begin
  FCORREIO_DATA := Value;
end;

procedure TPedidoWebModel.SetCORREIO_HORA(const Value: Variant);
begin
  FCORREIO_HORA := Value;
end;

procedure TPedidoWebModel.SetCORREIO_VOLUME(const Value: Variant);
begin
  FCORREIO_VOLUME := Value;
end;

procedure TPedidoWebModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoWebModel.SetCUPOM_DESCONTO(const Value: Variant);
begin
  FCUPOM_DESCONTO := Value;
end;

procedure TPedidoWebModel.SetCUPOM_TIPO(const Value: Variant);
begin
  FCUPOM_TIPO := Value;
end;

procedure TPedidoWebModel.SetCUPOM_VALOR(const Value: Variant);
begin
  FCUPOM_VALOR := Value;
end;

procedure TPedidoWebModel.SetDADOS_ADICIONAIS(const Value: Variant);
begin
  FDADOS_ADICIONAIS := Value;
end;

procedure TPedidoWebModel.SetDADOS_AUTORIZACAO(const Value: Variant);
begin
  FDADOS_AUTORIZACAO := Value;
end;

procedure TPedidoWebModel.SetDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TPedidoWebModel.SetDATAHORA(const Value: Variant);
begin
  FDATAHORA := Value;
end;

procedure TPedidoWebModel.SetDATA_CONSUMO_OMINIONE(const Value: Variant);
begin
  FDATA_CONSUMO_OMINIONE := Value;
end;

procedure TPedidoWebModel.SetDATA_EXPORTACAO(const Value: Variant);
begin
  FDATA_EXPORTACAO := Value;
end;

procedure TPedidoWebModel.SetDATA_HORA_ANALISE(const Value: Variant);
begin
  FDATA_HORA_ANALISE := Value;
end;

procedure TPedidoWebModel.SetDATA_HORA_APROVACAO(const Value: Variant);
begin
  FDATA_HORA_APROVACAO := Value;
end;

procedure TPedidoWebModel.SetDATA_HORA_REPROVADO(const Value: Variant);
begin
  FDATA_HORA_REPROVADO := Value;
end;

procedure TPedidoWebModel.SetENTREGA_BAIRRO(const Value: Variant);
begin
  FENTREGA_BAIRRO := Value;
end;

procedure TPedidoWebModel.SetENTREGA_CEP(const Value: Variant);
begin
  FENTREGA_CEP := Value;
end;

procedure TPedidoWebModel.SetENTREGA_CIDADE(const Value: Variant);
begin
  FENTREGA_CIDADE := Value;
end;

procedure TPedidoWebModel.SetENTREGA_COD_MUNICIPIO(const Value: Variant);
begin
  FENTREGA_COD_MUNICIPIO := Value;
end;

procedure TPedidoWebModel.SetENTREGA_COMPLEMENTO(const Value: Variant);
begin
  FENTREGA_COMPLEMENTO := Value;
end;

procedure TPedidoWebModel.SetENTREGA_DATA(const Value: Variant);
begin
  FENTREGA_DATA := Value;
end;

procedure TPedidoWebModel.SetENTREGA_ENDERECO(const Value: Variant);
begin
  FENTREGA_ENDERECO := Value;
end;

procedure TPedidoWebModel.SetENTREGA_HORA(const Value: Variant);
begin
  FENTREGA_HORA := Value;
end;

procedure TPedidoWebModel.SetENTREGA_NUMERO(const Value: Variant);
begin
  FENTREGA_NUMERO := Value;
end;

procedure TPedidoWebModel.SetENTREGA_UF(const Value: Variant);
begin
  FENTREGA_UF := Value;
end;

procedure TPedidoWebModel.SetENVIAR_EMAIL(const Value: Variant);
begin
  FENVIAR_EMAIL := Value;
end;

procedure TPedidoWebModel.SetEVENTO(const Value: Variant);
begin
  FEVENTO := Value;
end;

procedure TPedidoWebModel.SetFATURAR(const Value: Variant);
begin
  FFATURAR := Value;
end;

procedure TPedidoWebModel.SetFRETE_ALTURA(const Value: Variant);
begin
  FFRETE_ALTURA := Value;
end;

procedure TPedidoWebModel.SetFRETE_LARGURA(const Value: Variant);
begin
  FFRETE_LARGURA := Value;
end;

procedure TPedidoWebModel.SetFRETE_PESO(const Value: Variant);
begin
  FFRETE_PESO := Value;
end;

procedure TPedidoWebModel.SetFRETE_PROFUNDIDADE(const Value: Variant);
begin
  FFRETE_PROFUNDIDADE := Value;
end;

procedure TPedidoWebModel.SetFRETE_VALOR(const Value: Variant);
begin
  FFRETE_VALOR := Value;
end;

procedure TPedidoWebModel.SetGERENTE_ID(const Value: Variant);
begin
  FGERENTE_ID := Value;
end;

procedure TPedidoWebModel.SetPARCELAS(const Value: Variant);
begin
  FPARCELAS := Value;
end;

procedure TPedidoWebModel.SetPedidoWebsLista(const Value: TObjectList<TPedidoWebModel>);
begin
  FPedidoWebsLista := Value;
end;

procedure TPedidoWebModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPedidoWebModel.SetIDPEDIDOSOVIS(const Value: Variant);
begin
  FIDPEDIDOSOVIS := Value;
end;

procedure TPedidoWebModel.SetIDPEDIDOSOVISUSUARIO(const Value: Variant);
begin
  FIDPEDIDOSOVISUSUARIO := Value;
end;

procedure TPedidoWebModel.SetPEDIDO_COMPRA(const Value: Variant);
begin
  FPEDIDO_COMPRA := Value;
end;

procedure TPedidoWebModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TPedidoWebModel.SetPED_PLATAFORMA(const Value: Variant);
begin
  FPED_PLATAFORMA := Value;
end;

procedure TPedidoWebModel.SetPERCENTUAL_DESCONTO(const Value: Variant);
begin
  FPERCENTUAL_DESCONTO := Value;
end;

procedure TPedidoWebModel.SetPERIOD(const Value: Variant);
begin
  FPERIOD := Value;
end;

procedure TPedidoWebModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TPedidoWebModel.SetPRECO_VENDA_ID(const Value: Variant);
begin
  FPRECO_VENDA_ID := Value;
end;

procedure TPedidoWebModel.SetPRE_ANALISE_DATAHORA(const Value: Variant);
begin
  FPRE_ANALISE_DATAHORA := Value;
end;

procedure TPedidoWebModel.SetPRE_ANALISE_STATUS(const Value: Variant);
begin
  FPRE_ANALISE_STATUS := Value;
end;

procedure TPedidoWebModel.SetPRE_ANALISE_USUARIO_ID(const Value: Variant);
begin
  FPRE_ANALISE_USUARIO_ID := Value;
end;

procedure TPedidoWebModel.SetPRIMEIRO_VENCIMENTO(const Value: Variant);
begin
  FPRIMEIRO_VENCIMENTO := Value;
end;

procedure TPedidoWebModel.SetPROPOSTA(const Value: Variant);
begin
  FPROPOSTA := Value;
end;

procedure TPedidoWebModel.SetREGIAO_ID(const Value: Variant);
begin
  FREGIAO_ID := Value;
end;

procedure TPedidoWebModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPedidoWebModel.SetIDUsuario(const Value: String);
begin
  FIDUsuario := Value;
end;

procedure TPedidoWebModel.SetIMPRESSAO(const Value: Variant);
begin
  FIMPRESSAO := Value;
end;

procedure TPedidoWebModel.SetINTERMEDIADOR_ID(const Value: Variant);
begin
  FINTERMEDIADOR_ID := Value;
end;

procedure TPedidoWebModel.SetISGIFT(const Value: Variant);
begin
  FISGIFT := Value;
end;

procedure TPedidoWebModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoWebModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TPedidoWebModel.SetLOTE_EXPORTACAO(const Value: Variant);
begin
  FLOTE_EXPORTACAO := Value;
end;

procedure TPedidoWebModel.SetMARKETPLACE(const Value: Variant);
begin
  FMARKETPLACE := Value;
end;

procedure TPedidoWebModel.SetMENSAGEM_ANALISE(const Value: Variant);
begin
  FMENSAGEM_ANALISE := Value;
end;

procedure TPedidoWebModel.SetMONTAGEM_DATA(const Value: Variant);
begin
  FMONTAGEM_DATA := Value;
end;

procedure TPedidoWebModel.SetMONTAGEM_HORA(const Value: Variant);
begin
  FMONTAGEM_HORA := Value;
end;

procedure TPedidoWebModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TPedidoWebModel.SetOBSERVACOES(const Value: Variant);
begin
  FOBSERVACOES := Value;
end;

procedure TPedidoWebModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoWebModel.SetORIGEM_PEDIDO(const Value: Variant);
begin
  FORIGEM_PEDIDO := Value;
end;

procedure TPedidoWebModel.SetSAIDA_ID(const Value: Variant);
begin
  FSAIDA_ID := Value;
end;

procedure TPedidoWebModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPedidoWebModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TPedidoWebModel.SetSTATUS_ANALISE(const Value: Variant);
begin
  FSTATUS_ANALISE := Value;
end;

procedure TPedidoWebModel.SetSTATUS_SOVIS(const Value: Variant);
begin
  FSTATUS_SOVIS := Value;
end;

procedure TPedidoWebModel.SetSUBSTATUS(const Value: Variant);
begin
  FSUBSTATUS := Value;
end;

procedure TPedidoWebModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPedidoWebModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TPedidoWebModel.SetTIPOVENDA_ID(const Value: Variant);
begin
  FTIPOVENDA_ID := Value;
end;

procedure TPedidoWebModel.SetTIPO_COMISSAO(const Value: Variant);
begin
  FTIPO_COMISSAO := Value;
end;

procedure TPedidoWebModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPedidoWebModel.SetTRANSPORTADORA_DADOS_ADICIONAIS(
  const Value: Variant);
begin
  FTRANSPORTADORA_DADOS_ADICIONAIS := Value;
end;

procedure TPedidoWebModel.SetTRANSPORTADORA_ID(const Value: Variant);
begin
  FTRANSPORTADORA_ID := Value;
end;

procedure TPedidoWebModel.SetUSAR_TABELA_PRECO(const Value: Variant);
begin
  FUSAR_TABELA_PRECO := Value;
end;

procedure TPedidoWebModel.SetUSUARIO(const Value: Variant);
begin
  FUSUARIO := Value;
end;

procedure TPedidoWebModel.SetUSUARIO_ANALISANDO(const Value: Variant);
begin
  FUSUARIO_ANALISANDO := Value;
end;

procedure TPedidoWebModel.SetUSUARIO_ANALISE(const Value: Variant);
begin
  FUSUARIO_ANALISE := Value;
end;

procedure TPedidoWebModel.SetUSUARIO_APROVACAO(const Value: Variant);
begin
  FUSUARIO_APROVACAO := Value;
end;

procedure TPedidoWebModel.SetUSUARIO_REPROVADO(const Value: Variant);
begin
  FUSUARIO_REPROVADO := Value;
end;

procedure TPedidoWebModel.SetUUID_SOVIS(const Value: Variant);
begin
  FUUID_SOVIS := Value;
end;

procedure TPedidoWebModel.SetVALOR_CUPOM_DESCONTO(const Value: Variant);
begin
  FVALOR_CUPOM_DESCONTO := Value;
end;

procedure TPedidoWebModel.SetVALOR_ENTRADA(const Value: Variant);
begin
  FVALOR_ENTRADA := Value;
end;

procedure TPedidoWebModel.SetVALOR_FRETE(const Value: Variant);
begin
  FVALOR_FRETE := Value;
end;

procedure TPedidoWebModel.SetVALOR_GARANTIA(const Value: Variant);
begin
  FVALOR_GARANTIA := Value;
end;

procedure TPedidoWebModel.SetVALOR_ITENS(const Value: Variant);
begin
  FVALOR_ITENS := Value;
end;

procedure TPedidoWebModel.SetVALOR_ST(const Value: Variant);
begin
  FVALOR_ST := Value;
end;

procedure TPedidoWebModel.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;

procedure TPedidoWebModel.SetVENDEDOR_ID(const Value: Variant);
begin
  FVENDEDOR_ID := Value;
end;

procedure TPedidoWebModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
