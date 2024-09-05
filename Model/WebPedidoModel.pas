unit WebPedidoModel;

interface

uses
  math,
  Terasoft.Types,
  Terasoft.Utils,
  Spring.Collections,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  FireDAC.Comp.Client,
  PedidoVendaModel,
  WebPedidoItensModel,
  PedidoItensModel,
  ReservaModel,
  System.SysUtils,
  FuncionarioModel,
  System.StrUtils,
  ProdutosModel,
  EmpresaModel,
  WebPedidoItensDao,
  Terasoft.Framework.ObjectIface,
  MovimentoSerialModel;

type
  TWebPedidoModel = class;
  ITWebPedidoModel=IObject<TWebPedidoModel>;

  TVenderItemParametros = record
    WEB_PEDIDO,
    PRODUTO,
    QUANTIDADE,
    VALOR_UNITARIO,
    DESCONTO,
    TIPO,
    ENTREGA,
    MONTAGEM,
    TIPO_ENTREGA,
    TIPO_GARANTIA,
    VLR_GARANTIA,
    TIPO_GARANTIA_FR,
    VLR_GARANTIA_FR    : String;
  end;

  TWebPedidoModel = class
  private
    [weak] mySelf: ITWebPedidoModel;
    vIConexao : IConexao;
    FWebPedidosLista: IList<ITWebPedidoModel>;
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
    FTOTAL_GARANTIA: Variant;
    FSEGURO_PRESTAMISTA_CUSTO: Variant;
    FSEGURO_PRESTAMISTA_VALOR: Variant;
    FVALOR_FINANCIADO: Variant;
    FAVALISTA_ID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetWebPedidosLista(const Value: IList<ITWebPedidoModel>);
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
    procedure SetTOTAL_GARANTIA(const Value: Variant);
    procedure SetSEGURO_PRESTAMISTA_CUSTO(const Value: Variant);
    procedure SetSEGURO_PRESTAMISTA_VALOR(const Value: Variant);
    procedure SetVALOR_FINANCIADO(const Value: Variant);
    procedure SetAVALISTA_ID(const Value: Variant);

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
    property TOTAL_GARANTIA: Variant read FTOTAL_GARANTIA write SetTOTAL_GARANTIA;
    property CLIENTE_NOME: Variant read FCLIENTE_NOME write SetCLIENTE_NOME;
    property TIPO_COMISSAO: Variant read FTIPO_COMISSAO write SetTIPO_COMISSAO;
    property GERENTE_ID: Variant read FGERENTE_ID write SetGERENTE_ID;
    property SEGURO_PRESTAMISTA_VALOR : Variant read FSEGURO_PRESTAMISTA_VALOR write SetSEGURO_PRESTAMISTA_VALOR;
    property SEGURO_PRESTAMISTA_CUSTO : Variant read FSEGURO_PRESTAMISTA_CUSTO write SetSEGURO_PRESTAMISTA_CUSTO;
    property VALOR_FINANCIADO: Variant read FVALOR_FINANCIADO write SetVALOR_FINANCIADO;
    property AVALISTA_ID: Variant read FAVALISTA_ID write SetAVALISTA_ID;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITWebPedidoModel;

    function Salvar: String;
    function obterLista : IFDDataset;
    function carregaClasse(pId: String): ITWebPedidoModel;

    function aprovarVendaAssistida(pIdVendaAssistida: Integer): String;
    function VenderItem(pVenderItemParametros: TVenderItemParametros): String;
    function ConcederDesconto(pIDPedido, pIDItem, pTipoDesconto : String; pPorcentagem : Real): Boolean;
    procedure calcularTotais;
    procedure obterTotais;

    function Incluir : String;
    function Alterar(pID: String): ITWebPedidoModel;
    function Excluir(pID: String) : String;

    function Autorizar(pID : String) : Boolean;
    function AutorizarDesconto(pID : String) : Boolean;
    function Negar(pID: String): Boolean;
    function NegarDesconto(pID: String): Boolean;

    property WebPedidosLista: IList<ITWebPedidoModel> read FWebPedidosLista write SetWebPedidosLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDUsuario: String read FIDUsuario write SetIDUsuario;

    procedure IncluiReservaCD(pWebPedidoItensModel: ITWebPedidoItensModel);
    procedure ExcluirReservaCD(pWebPedidoItensID, pFilial : String);
    procedure AtualizaReservaCD(pWebPedidoModel: ITWebPedidoModel);

  end;

implementation

uses
  WebPedidoDao,
  ClienteModel,
  FinanceiroPedidoModel,
  PortadorModel,
  SolicitacaoDescontoModel, PermissaoRemotaModel, Terasoft.Configuracoes;

{ TWebPedidoModel }

procedure TWebPedidoModel.AfterConstruction;
begin
  inherited;

end;

function TWebPedidoModel.Alterar(pID : String): ITWebPedidoModel;
var
  lWebPedidoModel : ITWebPedidoModel;
begin
  if pID = '' then
    CriaException('ID � obrigat�rio.');

  lWebPedidoModel := TWebPedidoModel.getNewIface(vIConexao);
  try
    lWebPedidoModel := lWebPedidoModel.objeto.carregaClasse(pID);
    lWebPedidoModel.objeto.Acao := tacAlterar;
    Result := lWebPedidoModel;
  finally
  end;
end;

function TWebPedidoModel.aprovarVendaAssistida(pIdVendaAssistida: Integer): String;
var
  lPedidoVendaModel        : ITPedidoVendaModel;
  lPedidoItensModel        : ITPedidoItensModel;
  lWebPedidoItensModel     : ITWebPedidoItensModel;
  lWebPedidoModel          : ITWebPedidoModel;
  lClientesModel           : ITClienteModel;
  lFinanceiroPedidoModel   : ITFinanceiroPedidoModel;
  lConfiguracoes           : ITerasoftConfiguracoes;
  lPedido                  : String;
  lItem, lIndex            : Integer;
  lTableCliente,
  lTableFinanceiro         : IFDDataset;
begin

  if not (pIdVendaAssistida <> 0) then
    exit;

  lWebPedidoModel        := TWebPedidoModel.getNewIface(vIConexao);
  lWebPedidoItensModel   := TWebPedidoItensModel.getNewIface(vIConexao);

  lPedidoVendaModel      := TPedidoVendaModel.getNewIface(vIConexao);
  lPedidoItensModel      := TPedidoItensModel.getNewIface(vIConexao);

  lClientesModel         := TClienteModel.getNewIface(vIConexao);
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);

  Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

  try
    lPedidoVendaModel.objeto.WhereView := ' and pedidovenda.web_pedido_id = '+ IntToStr(pIdVendaAssistida);
    lPedidoVendaModel.objeto.obterLista;

    if lPedidoVendaModel.objeto.TotalRecords > 0 then
      CriaException('Já existe um pedido gerado para esse registro');

    lFinanceiroPedidoModel.objeto.WhereView := ' and financeiro_pedido.web_pedido_id = ' + pIdVendaAssistida.ToString;
    lTableFinanceiro := lFinanceiroPedidoModel.objeto.obterLista;

    lWebPedidoModel := lWebPedidoModel.objeto.carregaClasse(pIdVendaAssistida.ToString);

    lClientesModel.objeto.IDRecordView := lWebPedidoModel.objeto.CLIENTE_ID;
    lTableCliente := lClientesModel.objeto.ObterListaMemTable;

    lPedidoVendaModel.objeto.Acao                 := tacIncluir;
    lPedidoVendaModel.objeto.LOJA                 := lWebPedidoModel.objeto.LOJA;
    lPedidoVendaModel.objeto.DATA_PED             := DateToStr(vIConexao.DataServer);
    lPedidoVendaModel.objeto.HORA_PED             := TimeToStr(vIConexao.HoraServer);
    lPedidoVendaModel.objeto.PRIMEIROVENC_PED     := lWebPedidoModel.objeto.PRIMEIRO_VENCIMENTO;
    lPedidoVendaModel.objeto.ACRES_PED            := lWebPedidoModel.objeto.ACRESCIMO;
    lPedidoVendaModel.objeto.DESC_PED             := lWebPedidoModel.objeto.VALOR_CUPOM_DESCONTO;
    lPedidoVendaModel.objeto.DESCONTO_PED         := lWebPedidoModel.objeto.PERCENTUAL_DESCONTO;
    lPedidoVendaModel.objeto.VALOR_PED            := FloatToStr((StrToFloat(lWebPedidoModel.objeto.VALOR_TOTAL) + StrToFloat(lWebPedidoModel.objeto.VALOR_CUPOM_DESCONTO)));
    lPedidoVendaModel.objeto.TOTAL_PED            := lWebPedidoModel.objeto.VALOR_TOTAL;
    lPedidoVendaModel.objeto.VALORENTADA_PED      := lWebPedidoModel.objeto.VALOR_ENTRADA;
    lPedidoVendaModel.objeto.PARCELAS_PED         := lWebPedidoModel.objeto.PARCELAS;
    lPedidoVendaModel.objeto.PARCELA_PED          := '0'; //Valor da parcela
    lPedidoVendaModel.objeto.CTR_IMPRESSAO_PED    := '0';
    lPedidoVendaModel.objeto.RESERVADO            := 'N';
    lPedidoVendaModel.objeto.TIPO_FRETE           := '9';
    lPedidoVendaModel.objeto.SMS                  := 'N';
    lPedidoVendaModel.objeto.ENTREGA              := 'N';
    lPedidoVendaModel.objeto.STATUS_PED           := 'P';
    lPedidoVendaModel.objeto.STATUS               := 'O';
    lPedidoVendaModel.objeto.TIPO_PED             := 'P';
    lPedidoVendaModel.objeto.TABJUROS_PED         := 'N';
    lPedidoVendaModel.objeto.WEB_PEDIDO_ID        := lWebPedidoModel.objeto.ID;
    lPedidoVendaModel.objeto.CODIGO_CLI           := lWebPedidoModel.objeto.CLIENTE_ID;
    lPedidoVendaModel.objeto.CNPJ_CPF_CONSUMIDOR  := lTableCliente.objeto.fieldByName('CNPJ_CPF_CLI').AsString;

    if lFinanceiroPedidoModel.objeto.TotalRecords > 0 then
      lPedidoVendaModel.objeto.CODIGO_PORT        := lTableFinanceiro.objeto.FieldByName('PORTADOR_ID').AsString
    else
      lPedidoVendaModel.objeto.CODIGO_PORT        := lWebPedidoModel.objeto.PORTADOR_ID;

    lPedidoVendaModel.objeto.CODIGO_VEN               := lWebPedidoModel.objeto.VENDEDOR_ID;
    lPedidoVendaModel.objeto.CODIGO_TIP               := lWebPedidoModel.objeto.TIPOVENDA_ID;
    lPedidoVendaModel.objeto.FRETE_PED                := lWebPedidoModel.objeto.VALOR_FRETE;
    lPedidoVendaModel.objeto.INFORMACOES_PED          := lWebPedidoModel.objeto.OBSERVACAO;
    lPedidoVendaModel.objeto.ENTREGA_ENDERECO         := lWebPedidoModel.objeto.ENTREGA_ENDERECO;
    lPedidoVendaModel.objeto.ENTREGA_NUMERO           := lWebPedidoModel.objeto.ENTREGA_NUMERO;
    lPedidoVendaModel.objeto.ENTREGA_BAIRRO           := lWebPedidoModel.objeto.ENTREGA_BAIRRO;
    lPedidoVendaModel.objeto.ENTREGA_CIDADE           := lWebPedidoModel.objeto.ENTREGA_CIDADE;
    lPedidoVendaModel.objeto.ENTREGA_UF               := lWebPedidoModel.objeto.ENTREGA_UF;
    lPedidoVendaModel.objeto.ENTREGA_CEP              := lWebPedidoModel.objeto.ENTREGA_CEP;
    lPedidoVendaModel.objeto.ENTREGA_COMPLEMENTO      := lWebPedidoModel.objeto.ENTREGA_COMPLEMENTO;
    lPedidoVendaModel.objeto.MONTAGEM_DATA            := lWebPedidoModel.objeto.MONTAGEM_DATA;
    lPedidoVendaModel.objeto.USUARIO_PED              := self.vIConexao.getUSer.ID;
    lPedidoVendaModel.objeto.IDUsuario                := self.vIConexao.getUSer.ID;
    lPedidoVendaModel.objeto.TIPO_COMISSAO            := self.TIPO_COMISSAO;
    lPedidoVendaModel.objeto.GERENTE_ID               := self.GERENTE_ID;
    lPedidoVendaModel.objeto.CONDICOES2_PAG           := lWebPedidoModel.objeto.AVALISTA_ID;
    lPedidoVendaModel.objeto.FORM                     := 'PDV';

    lPedidoVendaModel.objeto.SEGURO_PRESTAMISTA_CUSTO := lWebPedidoModel.objeto.SEGURO_PRESTAMISTA_CUSTO;
    lPedidoVendaModel.objeto.SEGURO_PRESTAMISTA_VALOR := lWebPedidoModel.objeto.SEGURO_PRESTAMISTA_VALOR;

    lPedido := lPedidoVendaModel.objeto.Salvar;

    lPedidoVendaModel.objeto.NUMERO_PED := lPedido;

    lWebPedidoItensModel.objeto.IDWebPedidoView := pIdVendaAssistida;
    lWebPedidoItensModel.objeto.obterLista;

    lPedidoItensModel.objeto.PedidoItenssLista := TCollections.CreateList<ITPedidoItensModel>;

    lItem  := 0;
    lIndex := 0;

    for lWebPedidoItensModel in lWebPedidoItensModel.objeto.WebPedidoItenssLista do begin
      inc(lItem);

      lPedidoItensModel.objeto.PedidoItenssLista.Add(TPedidoItensModel.getNewIface(vIConexao));

      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.NUMERO_PED             := lPedido;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.CODIGO_CLI             := lWebPedidoModel.objeto.CLIENTE_ID;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.LOJA                   := lWebPedidoModel.objeto.LOJA;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.QUANTIDADE_PED         := FloatToStr(lWebPedidoItensModel.objeto.QUANTIDADE);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.QUANTIDADE_NEW         := FloatToStr(lWebPedidoItensModel.objeto.QUANTIDADE);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.WEB_PEDIDOITENS_ID     := lWebPedidoItensModel.objeto.ID;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.TIPO_VENDA             := lWebPedidoItensModel.objeto.TIPO_ENTREGA;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.OBSERVACAO             := copy(lWebPedidoItensModel.objeto.OBSERVACAO,1,50);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.OBS_ITEM               := lWebPedidoItensModel.objeto.OBSERVACAO;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.CODIGO_PRO             := lWebPedidoItensModel.objeto.PRODUTO_ID;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.QUANTIDADE_TIPO        := FloatToStr(lWebPedidoItensModel.objeto.VLR_GARANTIA);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.ENTREGA                := lWebPedidoItensModel.objeto.ENTREGA;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.MONTAGEM               := lWebPedidoItensModel.objeto.MONTAGEM;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.DESCONTO_PED           := FloatToStr(lWebPedidoItensModel.objeto.PERCENTUAL_DESCONTO);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VDESC                  := FloatToStr(lWebPedidoItensModel.objeto.PERCENTUAL_DESCONTO / 100 * (lWebPedidoItensModel.objeto.QUANTIDADE * lWebPedidoItensModel.objeto.VALOR_UNITARIO));
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VALORUNITARIO_PED      := FloatToStr(lWebPedidoItensModel.objeto.VALOR_UNITARIO);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.ITEM                   := lItem.ToString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VALOR_BONUS_SERVICO    := FloatToStr(lWebPedidoItensModel.objeto.VALOR_BONUS_SERVICO);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.BALANCA                := lWebPedidoItensModel.objeto.USAR_BALANCA;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VLRVENDA_PRO           := FloatToStr(lWebPedidoItensModel.objeto.VLRVENDA_PRO);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VALOR_VENDA_CADASTRO   := FloatToStr(lWebPedidoItensModel.objeto.VALOR_VENDA_ATUAL);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VLRCUSTO_PRO           := FloatToStr(lWebPedidoItensModel.objeto.VALOR_CUSTO_ATUAL);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VALOR_MONTADOR         := FloatToStr(lWebPedidoItensModel.objeto.VALOR_MONTADOR);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.COMISSAO_PERCENTUAL    := FloatToStr(lWebPedidoItensModel.objeto.PERCENTUAL_COMISSAO);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.COMISSAO_PED           := '0';
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.TIPO_GARANTIA_FR       := lWebPedidoItensModel.objeto.TIPO_GARANTIA_FR;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VLR_GARANTIA_FR        := lWebPedidoItensModel.objeto.VLR_GARANTIA_FR;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.CUSTO_GARANTIA_FR      := lWebPedidoItensModel.objeto.CUSTO_GARANTIA_FR;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.CUSTO_GARANTIA         := lWebPedidoItensModel.objeto.CUSTO_GARANTIA;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.PER_GARANTIA_FR        := lWebPedidoItensModel.objeto.PER_GARANTIA_FR;

      inc(lIndex);
    end;

    lPedidoItensModel.objeto.Acao := tacIncluirLote;
    lPedidoItensModel.objeto.Salvar;

    lPedidoVendaModel.objeto.calcularTotais;

    if lFinanceiroPedidoModel.objeto.TotalRecords > 0 then
      lPedidoVendaModel.objeto.gerarContasReceberFinanceiroPedido(pIdVendaAssistida.ToString)
    else
      lPedidoVendaModel.objeto.gerarContasReceberPedido;

    lWebPedidoModel.objeto.FAcao      := tacAlterar;
    lWebPedidoModel.objeto.FSTATUS    := 'F';
    lWebPedidoModel.objeto.FPEDIDO_ID := lPedido;
    lWebPedidoModel.objeto.Salvar;

    Result := lPedido;

  finally
    lFinanceiroPedidoModel:=nil;
    lWebPedidoModel:=nil;
    lPedidoVendaModel:=nil;
    lWebPedidoItensModel:=nil;
    lPedidoItensModel:=nil;
    lClientesModel:=nil;
  end;

end;

function TWebPedidoModel.carregaClasse(pId: String): ITWebPedidoModel;
var
  lWebPedidoDao: ITWebPedidoDao;
begin
  lWebPedidoDao := TWebPedidoDao.getNewIface(vIConexao);
  try
    Result := lWebPedidoDao.objeto.carregaClasse(pId);
  finally
    lWebPedidoDao:=nil;
  end;
end;

constructor TWebPedidoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TWebPedidoModel.Destroy;
begin
  FWebPedidosLista := nil;
  vIConexao := nil;
  inherited;
end;

function TWebPedidoModel.Excluir(pID: String): String;
begin
  if pID = '' then
    CriaException('ID � obrigat�rio.');

  self.FID  := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar;
end;

procedure TWebPedidoModel.ExcluirReservaCD(pWebPedidoItensID, pFilial: String);
var
  lReservaModel : ITReservaModel;
  lTableReserva : IFDDataset;
begin
  lReservaModel := TReservaModel.getNewIface(vIConexao.NovaConexao('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA));

  try
    lReservaModel.objeto.WhereView := ' and reserva.web_pedidoitens_id = ' + pWebPedidoItensID + ' and reserva.filial = ' + QuotedStr(pFilial);
    lTableReserva := lReservaModel.objeto.obterLista;

    if lTableReserva.objeto.FieldByName('ID').AsString = '' then
      CriaException('Reserva n�o localizada');

    lReservaModel.objeto.Excluir(lTableReserva.objeto.FieldByName('ID').AsString);
  finally
    lReservaModel:=nil;
  end;
end;

class function TWebPedidoModel.getNewIface(pIConexao: IConexao): ITWebPedidoModel;
begin
  Result := TImplObjetoOwner<TWebPedidoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TWebPedidoModel.Incluir: String;
begin
  self.FDATAHORA              := DateTimeToStr(vIConexao.DataHoraServer);
  self.FUSUARIO               := vIConexao.getUSer.ID;
  self.FSTATUS                := 'I';

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TWebPedidoModel.obterLista: IFDDataset;
var
  lWebPedidoLista: ITWebPedidoDao;
begin
  lWebPedidoLista := TWebPedidoDao.getNewIface(vIConexao);

  try
    lWebPedidoLista.objeto.TotalRecords    := FTotalRecords;
    lWebPedidoLista.objeto.WhereView       := FWhereView;
    lWebPedidoLista.objeto.CountView       := FCountView;
    lWebPedidoLista.objeto.OrderView       := FOrderView;
    lWebPedidoLista.objeto.StartRecordView := FStartRecordView;
    lWebPedidoLista.objeto.LengthPageView  := FLengthPageView;
    lWebPedidoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lWebPedidoLista.objeto.obterLista;
    FTotalRecords := lWebPedidoLista.objeto.TotalRecords;
  finally
    lWebPedidoLista:=nil;
  end;
end;

procedure TWebPedidoModel.obterTotais;
var
  lWebPedidoItensModel : ITWebPedidoItensModel;
  lTotais : TTotais;
begin
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(vIConexao);
  try
    lTotais := lWebPedidoItensModel.objeto.obterTotais(self.FID);

    self.VALOR_ITENS               := lTotais.VALOR_ITENS;
    self.VALOR_CUPOM_DESCONTO      := lTotais.VALOR_DESCONTO;
    self.TOTAL_GARANTIA            := lTotais.TOTAL_GARANTIA;
    self.SEGURO_PRESTAMISTA_VALOR  := lTotais.SEGURO_PRESTAMISTA_VALOR;
    self.ACRESCIMO                 := lTotais.VALOR_ACRESCIMO;
    self.VALOR_FRETE               := lTotais.VALOR_FRETE;
    self.VALOR_TOTAL               := lTotais.VALOR_TOTAL;

  finally
    lWebPedidoItensModel:=nil;
  end;
end;

procedure TWebPedidoModel.calcularTotais;
var
  lWebPedidoItensDao : ITWebPedidoItensDao;
  lTotais            : TTotais;
begin
  lWebPedidoItensDao := TWebPedidoItensDao.getNewIface(vIConexao);
  try
    lTotais := lWebPedidoItensDao.objeto.obterTotais(self.FID);

    self.Acao := tacAlterar;

    self.ACRESCIMO             := lTotais.VALOR_ACRESCIMO;
    self.TOTAL_GARANTIA        := lTotais.TOTAL_GARANTIA;
    self.VALOR_FRETE           := lTotais.VALOR_FRETE;
    self.VALOR_CUPOM_DESCONTO  := lTotais.VALOR_DESCONTO;
    self.VALOR_ITENS           := lTotais.VALOR_ITENS;
    self.VALOR_TOTAL           := lTotais.VALOR_TOTAL;

    if lTotais.VALOR_DESCONTO > 0 then
      self.PERCENTUAL_DESCONTO := lTotais.VALOR_DESCONTO * 100 / (lTotais.VALOR_TOTAL + lTotais.VALOR_DESCONTO)
    else
      self.PERCENTUAL_DESCONTO := 0;

    self.Salvar;
  finally
    lWebPedidoItensDao:=nil;
  end;
end;

function TWebPedidoModel.Salvar: String;
var
  lWebPedidoDao : ITWebPedidoDao;
begin
  lWebPedidoDao := TWebPedidoDao.getNewIface(vIConexao);
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lWebPedidoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lWebPedidoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lWebPedidoDao.objeto.excluir(mySelf);
    end;
  finally
    lWebPedidoDao:=nil;
  end;
end;

procedure TWebPedidoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TWebPedidoModel.SetACRESCIMO(const Value: Variant);
begin
  FACRESCIMO := Value;
end;

procedure TWebPedidoModel.SetAVALISTA_ID(const Value: Variant);
begin
  FAVALISTA_ID := Value;
end;

procedure TWebPedidoModel.SetCAMINHO_BOLETO(const Value: Variant);
begin
  FCAMINHO_BOLETO := Value;
end;

procedure TWebPedidoModel.SetCAMINHO_NFE(const Value: Variant);
begin
  FCAMINHO_NFE := Value;
end;

procedure TWebPedidoModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TWebPedidoModel.SetCLIENTE_NOME(const Value: Variant);
begin
  FCLIENTE_NOME := Value;
end;

procedure TWebPedidoModel.SetCODIGO_AUTORIZACAO_CARTAO(const Value: Variant);
begin
  FCODIGO_AUTORIZACAO_CARTAO := Value;
end;

procedure TWebPedidoModel.SetCODIGO_CUPOM_DESCONTO(const Value: Variant);
begin
  FCODIGO_CUPOM_DESCONTO := Value;
end;

procedure TWebPedidoModel.SetCONDICOES2_PAG(const Value: Variant);
begin
  FCONDICOES2_PAG := Value;
end;

procedure TWebPedidoModel.SetCONDICOES_PAGAMENTO(const Value: Variant);
begin
  FCONDICOES_PAGAMENTO := Value;
end;

procedure TWebPedidoModel.SetCONTROLEALTERACAO(const Value: Variant);
begin
  FCONTROLEALTERACAO := Value;
end;

procedure TWebPedidoModel.SetCORREIO_DATA(const Value: Variant);
begin
  FCORREIO_DATA := Value;
end;

procedure TWebPedidoModel.SetCORREIO_HORA(const Value: Variant);
begin
  FCORREIO_HORA := Value;
end;

procedure TWebPedidoModel.SetCORREIO_VOLUME(const Value: Variant);
begin
  FCORREIO_VOLUME := Value;
end;

procedure TWebPedidoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TWebPedidoModel.SetCUPOM_DESCONTO(const Value: Variant);
begin
  FCUPOM_DESCONTO := Value;
end;

procedure TWebPedidoModel.SetCUPOM_TIPO(const Value: Variant);
begin
  FCUPOM_TIPO := Value;
end;

procedure TWebPedidoModel.SetCUPOM_VALOR(const Value: Variant);
begin
  FCUPOM_VALOR := Value;
end;

procedure TWebPedidoModel.SetDADOS_ADICIONAIS(const Value: Variant);
begin
  FDADOS_ADICIONAIS := Value;
end;

procedure TWebPedidoModel.SetDADOS_AUTORIZACAO(const Value: Variant);
begin
  FDADOS_AUTORIZACAO := Value;
end;

procedure TWebPedidoModel.SetDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TWebPedidoModel.SetDATAHORA(const Value: Variant);
begin
  FDATAHORA := Value;
end;

procedure TWebPedidoModel.SetDATA_CONSUMO_OMINIONE(const Value: Variant);
begin
  FDATA_CONSUMO_OMINIONE := Value;
end;

procedure TWebPedidoModel.SetDATA_EXPORTACAO(const Value: Variant);
begin
  FDATA_EXPORTACAO := Value;
end;

procedure TWebPedidoModel.SetDATA_HORA_ANALISE(const Value: Variant);
begin
  FDATA_HORA_ANALISE := Value;
end;

procedure TWebPedidoModel.SetDATA_HORA_APROVACAO(const Value: Variant);
begin
  FDATA_HORA_APROVACAO := Value;
end;

procedure TWebPedidoModel.SetDATA_HORA_REPROVADO(const Value: Variant);
begin
  FDATA_HORA_REPROVADO := Value;
end;

procedure TWebPedidoModel.SetENTREGA_BAIRRO(const Value: Variant);
begin
  FENTREGA_BAIRRO := Value;
end;

procedure TWebPedidoModel.SetENTREGA_CEP(const Value: Variant);
begin
  FENTREGA_CEP := Value;
end;

procedure TWebPedidoModel.SetENTREGA_CIDADE(const Value: Variant);
begin
  FENTREGA_CIDADE := Value;
end;

procedure TWebPedidoModel.SetENTREGA_COD_MUNICIPIO(const Value: Variant);
begin
  FENTREGA_COD_MUNICIPIO := Value;
end;

procedure TWebPedidoModel.SetENTREGA_COMPLEMENTO(const Value: Variant);
begin
  FENTREGA_COMPLEMENTO := Value;
end;

procedure TWebPedidoModel.SetENTREGA_DATA(const Value: Variant);
begin
  FENTREGA_DATA := Value;
end;

procedure TWebPedidoModel.SetENTREGA_ENDERECO(const Value: Variant);
begin
  FENTREGA_ENDERECO := Value;
end;

procedure TWebPedidoModel.SetENTREGA_HORA(const Value: Variant);
begin
  FENTREGA_HORA := Value;
end;

procedure TWebPedidoModel.SetENTREGA_NUMERO(const Value: Variant);
begin
  FENTREGA_NUMERO := Value;
end;

procedure TWebPedidoModel.SetENTREGA_UF(const Value: Variant);
begin
  FENTREGA_UF := Value;
end;

procedure TWebPedidoModel.SetENVIAR_EMAIL(const Value: Variant);
begin
  FENVIAR_EMAIL := Value;
end;

procedure TWebPedidoModel.SetEVENTO(const Value: Variant);
begin
  FEVENTO := Value;
end;

procedure TWebPedidoModel.SetFATURAR(const Value: Variant);
begin
  FFATURAR := Value;
end;

procedure TWebPedidoModel.SetFRETE_ALTURA(const Value: Variant);
begin
  FFRETE_ALTURA := Value;
end;

procedure TWebPedidoModel.SetFRETE_LARGURA(const Value: Variant);
begin
  FFRETE_LARGURA := Value;
end;

procedure TWebPedidoModel.SetFRETE_PESO(const Value: Variant);
begin
  FFRETE_PESO := Value;
end;

procedure TWebPedidoModel.SetFRETE_PROFUNDIDADE(const Value: Variant);
begin
  FFRETE_PROFUNDIDADE := Value;
end;

procedure TWebPedidoModel.SetFRETE_VALOR(const Value: Variant);
begin
  FFRETE_VALOR := Value;
end;

procedure TWebPedidoModel.SetGERENTE_ID(const Value: Variant);
begin
  FGERENTE_ID := Value;
end;

procedure TWebPedidoModel.SetPARCELAS(const Value: Variant);
begin
  FPARCELAS := Value;
end;

procedure TWebPedidoModel.SetWebPedidosLista;
begin
  FWebPedidosLista := Value;
end;

procedure TWebPedidoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TWebPedidoModel.SetIDPEDIDOSOVIS(const Value: Variant);
begin
  FIDPEDIDOSOVIS := Value;
end;

procedure TWebPedidoModel.SetIDPEDIDOSOVISUSUARIO(const Value: Variant);
begin
  FIDPEDIDOSOVISUSUARIO := Value;
end;

procedure TWebPedidoModel.SetPEDIDO_COMPRA(const Value: Variant);
begin
  FPEDIDO_COMPRA := Value;
end;

procedure TWebPedidoModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TWebPedidoModel.SetPED_PLATAFORMA(const Value: Variant);
begin
  FPED_PLATAFORMA := Value;
end;

procedure TWebPedidoModel.SetPERCENTUAL_DESCONTO(const Value: Variant);
begin
  FPERCENTUAL_DESCONTO := Value;
end;

procedure TWebPedidoModel.SetPERIOD(const Value: Variant);
begin
  FPERIOD := Value;
end;

procedure TWebPedidoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TWebPedidoModel.SetPRECO_VENDA_ID(const Value: Variant);
begin
  FPRECO_VENDA_ID := Value;
end;

procedure TWebPedidoModel.SetPRE_ANALISE_DATAHORA(const Value: Variant);
begin
  FPRE_ANALISE_DATAHORA := Value;
end;

procedure TWebPedidoModel.SetPRE_ANALISE_STATUS(const Value: Variant);
begin
  FPRE_ANALISE_STATUS := Value;
end;

procedure TWebPedidoModel.SetPRE_ANALISE_USUARIO_ID(const Value: Variant);
begin
  FPRE_ANALISE_USUARIO_ID := Value;
end;

procedure TWebPedidoModel.SetPRIMEIRO_VENCIMENTO(const Value: Variant);
begin
  FPRIMEIRO_VENCIMENTO := Value;
end;

procedure TWebPedidoModel.SetPROPOSTA(const Value: Variant);
begin
  FPROPOSTA := Value;
end;

procedure TWebPedidoModel.SetREGIAO_ID(const Value: Variant);
begin
  FREGIAO_ID := Value;
end;

procedure TWebPedidoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TWebPedidoModel.SetIDUsuario(const Value: String);
begin
  FIDUsuario := Value;
end;

procedure TWebPedidoModel.SetIMPRESSAO(const Value: Variant);
begin
  FIMPRESSAO := Value;
end;

procedure TWebPedidoModel.SetINTERMEDIADOR_ID(const Value: Variant);
begin
  FINTERMEDIADOR_ID := Value;
end;

procedure TWebPedidoModel.SetISGIFT(const Value: Variant);
begin
  FISGIFT := Value;
end;

procedure TWebPedidoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TWebPedidoModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TWebPedidoModel.SetLOTE_EXPORTACAO(const Value: Variant);
begin
  FLOTE_EXPORTACAO := Value;
end;

procedure TWebPedidoModel.SetMARKETPLACE(const Value: Variant);
begin
  FMARKETPLACE := Value;
end;

procedure TWebPedidoModel.SetMENSAGEM_ANALISE(const Value: Variant);
begin
  FMENSAGEM_ANALISE := Value;
end;

procedure TWebPedidoModel.SetMONTAGEM_DATA(const Value: Variant);
begin
  FMONTAGEM_DATA := Value;
end;

procedure TWebPedidoModel.SetMONTAGEM_HORA(const Value: Variant);
begin
  FMONTAGEM_HORA := Value;
end;

procedure TWebPedidoModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TWebPedidoModel.SetOBSERVACOES(const Value: Variant);
begin
  FOBSERVACOES := Value;
end;

procedure TWebPedidoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TWebPedidoModel.SetORIGEM_PEDIDO(const Value: Variant);
begin
  FORIGEM_PEDIDO := Value;
end;

procedure TWebPedidoModel.SetSAIDA_ID(const Value: Variant);
begin
  FSAIDA_ID := Value;
end;

procedure TWebPedidoModel.SetSEGURO_PRESTAMISTA_CUSTO(const Value: Variant);
begin
  FSEGURO_PRESTAMISTA_CUSTO := Value;
end;

procedure TWebPedidoModel.SetSEGURO_PRESTAMISTA_VALOR(const Value: Variant);
begin
  FSEGURO_PRESTAMISTA_VALOR := Value;
end;

procedure TWebPedidoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TWebPedidoModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TWebPedidoModel.SetSTATUS_ANALISE(const Value: Variant);
begin
  FSTATUS_ANALISE := Value;
end;

procedure TWebPedidoModel.SetSTATUS_SOVIS(const Value: Variant);
begin
  FSTATUS_SOVIS := Value;
end;

procedure TWebPedidoModel.SetSUBSTATUS(const Value: Variant);
begin
  FSUBSTATUS := Value;
end;

procedure TWebPedidoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TWebPedidoModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TWebPedidoModel.SetTIPOVENDA_ID(const Value: Variant);
begin
  FTIPOVENDA_ID := Value;
end;

procedure TWebPedidoModel.SetTIPO_COMISSAO(const Value: Variant);
begin
  FTIPO_COMISSAO := Value;
end;

procedure TWebPedidoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TWebPedidoModel.SetTOTAL_GARANTIA(const Value: Variant);
begin
  FTOTAL_GARANTIA := Value;
end;

procedure TWebPedidoModel.SetTRANSPORTADORA_DADOS_ADICIONAIS(
  const Value: Variant);
begin
  FTRANSPORTADORA_DADOS_ADICIONAIS := Value;
end;

procedure TWebPedidoModel.SetTRANSPORTADORA_ID(const Value: Variant);
begin
  FTRANSPORTADORA_ID := Value;
end;

procedure TWebPedidoModel.SetUSAR_TABELA_PRECO(const Value: Variant);
begin
  FUSAR_TABELA_PRECO := Value;
end;

procedure TWebPedidoModel.SetUSUARIO(const Value: Variant);
begin
  FUSUARIO := Value;
end;

procedure TWebPedidoModel.SetUSUARIO_ANALISANDO(const Value: Variant);
begin
  FUSUARIO_ANALISANDO := Value;
end;

procedure TWebPedidoModel.SetUSUARIO_ANALISE(const Value: Variant);
begin
  FUSUARIO_ANALISE := Value;
end;

procedure TWebPedidoModel.SetUSUARIO_APROVACAO(const Value: Variant);
begin
  FUSUARIO_APROVACAO := Value;
end;

procedure TWebPedidoModel.SetUSUARIO_REPROVADO(const Value: Variant);
begin
  FUSUARIO_REPROVADO := Value;
end;

procedure TWebPedidoModel.SetUUID_SOVIS(const Value: Variant);
begin
  FUUID_SOVIS := Value;
end;

procedure TWebPedidoModel.SetVALOR_CUPOM_DESCONTO(const Value: Variant);
begin
  FVALOR_CUPOM_DESCONTO := Value;
end;

procedure TWebPedidoModel.SetVALOR_ENTRADA(const Value: Variant);
begin
  FVALOR_ENTRADA := Value;
end;

procedure TWebPedidoModel.SetVALOR_FINANCIADO(const Value: Variant);
begin
  FVALOR_FINANCIADO := Value;
end;

procedure TWebPedidoModel.SetVALOR_FRETE(const Value: Variant);
begin
  FVALOR_FRETE := Value;
end;

procedure TWebPedidoModel.SetVALOR_GARANTIA(const Value: Variant);
begin
  FVALOR_GARANTIA := Value;
end;

procedure TWebPedidoModel.SetVALOR_ITENS(const Value: Variant);
begin
  FVALOR_ITENS := Value;
end;

procedure TWebPedidoModel.SetVALOR_ST(const Value: Variant);
begin
  FVALOR_ST := Value;
end;

procedure TWebPedidoModel.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;

procedure TWebPedidoModel.SetVENDEDOR_ID(const Value: Variant);
begin
  FVENDEDOR_ID := Value;
end;

procedure TWebPedidoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TWebPedidoModel.VenderItem(pVenderItemParametros: TVenderItemParametros): String;
var
  lWebPedidoItensModel : ITWebPedidoItensModel;
  lProdutoModel        : ITProdutosModel;
  lMovimentoSerialModel: ITMovimentoSerialModel;
  lPrecoParamentros    : TProdutoPreco;
  lProdutoPreco        : TProdutoPreco;
  lValorUnitario,
  lValorVendido        : Double;
  p: ITWebPedidoModel;
  i : Integer;
  lVendaComSerial: Boolean;
  lSerialItem: String;
begin
  lVendaComSerial := False;

  lWebPedidoItensModel  := TWebPedidoItensModel.getNewIface(vIConexao);
  lProdutoModel         := TProdutosModel.getNewIface(vIConexao);
  lMovimentoSerialModel := TMovimentoSerialModel.getNewIface(vIConexao);

  if pVenderItemParametros.PRODUTO = '' then
    CriaException('Produto não informado');

  if StrToFloatDef(pVenderItemParametros.QUANTIDADE, 0) = 0 then
    CriaException('Quantidade não informada');

  if (PVenderItemParametros.TIPO_ENTREGA <> 'CD') and (lMovimentoSerialModel.objeto.ValidaVendaSerial(pVenderItemParametros.PRODUTO)) then
  begin
    if lMovimentoSerialModel.objeto.SaldoProdutoSerial(pVenderItemParametros.PRODUTO) <  StrToFloat(pVenderItemParametros.QUANTIDADE) then
      CriaException('Produto com venda obrigatória de serial e com saldo de serial inferior a quantidade solicitada para venda.')
    else
      lVendaComSerial := True;
  end;

  try
    p := self.carregaClasse(pVenderItemParametros.WEB_PEDIDO);

    lProdutoModel.objeto.IDRecordView := pVenderItemParametros.PRODUTO;
    lProdutoModel.objeto.obterLista;

    lProdutoModel := lProdutoModel.objeto.ProdutossLista.First;

    lWebPedidoItensModel.objeto.WEB_PEDIDO_ID       := p.objeto.ID;
    lWebPedidoItensModel.objeto.PRODUTO_ID          := pVenderItemParametros.PRODUTO;
    lWebPedidoItensModel.objeto.QUANTIDADE          := pVenderItemParametros.QUANTIDADE;

    lProdutoPreco.Produto     := pVenderItemParametros.PRODUTO;
    lProdutoPreco.TabelaPreco := true;
    lProdutoPreco.Promocao    := true;


    lValorUnitario            := lProdutoModel.objeto.ValorUnitario(lProdutoPreco);
    lValorVendido             := StrToFloat(retiraPonto(pVenderItemParametros.VALOR_UNITARIO));

    lWebPedidoItensModel.objeto.VALOR_VENDIDO       := lValorVendido.ToString;
    lWebPedidoItensModel.objeto.VLRVENDA_PRO        := lValorUnitario;

    if lValorVendido < lValorUnitario then
     lWebPedidoItensModel.objeto.VALOR_UNITARIO  := lValorUnitario.ToString
    else
     lWebPedidoItensModel.objeto.VALOR_UNITARIO  := lValorVendido.ToString;

    if lValorVendido < lValorUnitario then
      lWebPedidoItensModel.objeto.PERCENTUAL_DESCONTO := RoundTo((1 - lValorVendido / lValorUnitario) * 100, -5).ToString
    else
      lWebPedidoItensModel.objeto.PERCENTUAL_DESCONTO := '0';

    lWebPedidoItensModel.objeto.VALOR_VENDA_ATUAL   := lProdutoModel.objeto.VENDA_PRO;
		lWebPedidoItensModel.objeto.VALOR_CUSTO_ATUAL   := lProdutoModel.objeto.CUSTOMEDIO_PRO;

		lWebPedidoItensModel.objeto.RESERVADO           := pVenderItemParametros.QUANTIDADE;
    lWebPedidoItensModel.objeto.TIPO                := PVenderItemParametros.TIPO;
    lWebPedidoItensModel.objeto.ENTREGA             := PVenderItemParametros.ENTREGA;
    lWebPedidoItensModel.objeto.MONTAGEM            := PVenderItemParametros.MONTAGEM;
    lWebPedidoItensModel.objeto.TIPO_ENTREGA        := PVenderItemParametros.TIPO_ENTREGA;
    lWebPedidoItensModel.objeto.TIPO_GARANTIA       := PVenderItemParametros.TIPO_GARANTIA;
    lWebPedidoItensModel.objeto.VLR_GARANTIA        := PVenderItemParametros.VLR_GARANTIA;
    lWebPedidoItensModel.objeto.TIPO_GARANTIA_FR    := PVenderItemParametros.TIPO_GARANTIA_FR;
    lWebPedidoItensModel.objeto.VLR_GARANTIA_FR     := PVenderItemParametros.VLR_GARANTIA_FR;

    if (lWebPedidoItensModel.objeto.TIPO_ENTREGA = 'LJ') and (lWebPedidoItensModel.objeto.TIPO <> 'FUTURA') and (pVenderItemParametros.QUANTIDADE > lProdutoModel.objeto.SALDO_DISPONIVEL) then
      lWebPedidoItensModel.objeto.TIPO := 'SALDO_NEGA';

    Result := lWebPedidoItensModel.objeto.Incluir;

    if (PVenderItemParametros.TIPO_ENTREGA = 'CD') or ((PVenderItemParametros.TIPO_ENTREGA = 'LJ') and (PVenderItemParametros.ENTREGA = 'S')) then
    begin
      lWebPedidoItensModel.objeto.ID := Result;
      p.objeto.IncluiReservaCD(lWebPedidoItensModel);
    end;

    if lVendaComSerial then
    begin
      lSerialItem := '';

      for I := 1 to StrToInt(pVenderItemParametros.QUANTIDADE) do
      begin


        lMovimentoSerialModel.objeto.LOGISTICA         := 'FEDEX';
        lMovimentoSerialModel.objeto.TIPO_SERIAL       := 'I';
        lMovimentoSerialModel.objeto.NUMERO            := lMovimentoSerialModel.objeto.RetornaSerialVenda(pVenderItemParametros.PRODUTO);
        lMovimentoSerialModel.objeto.PRODUTO           := pVenderItemParametros.PRODUTO;
        lMovimentoSerialModel.objeto.TIPO_DOCUMENTO    := 'V';
        lMovimentoSerialModel.objeto.ID_DOCUMENTO      := pVenderItemParametros.WEB_PEDIDO;
        lMovimentoSerialModel.objeto.SUB_ID            := Result;
        lMovimentoSerialModel.objeto.TIPO_MOVIMENTO    := 'S';

        lSerialItem := lSerialItem + lMovimentoSerialModel.objeto.NUMERO + ' ';

        lMovimentoSerialModel.objeto.Incluir;
      end;

      lWebPedidoItensModel := lWebPedidoItensModel.objeto.Alterar(Result);
      lWebPedidoItensModel.objeto.OBSERVACAO := 'Serial: ' + lSerialItem;
      lWebPedidoItensModel.objeto.Salvar;
    end;

    p.objeto.calcularTotais;
  finally
    lWebPedidoItensModel:=nil;
    lProdutoModel:=nil;
    lMovimentoSerialModel:=nil;
  end;
end;

function TWebPedidoModel.ConcederDesconto(pIDPedido, pIDItem, pTipoDesconto : String; pPorcentagem : Real): Boolean;
var
  lWebPedidoItensModel        : ITWebPedidoItensModel;
  lWebPedidoItensModelAlterar : ITWebPedidoItensModel;
  i                           : Integer;
begin
  try
    try
      lWebPedidoItensModel        := TWebPedidoItensModel.getNewIface(vIConexao);
      lWebPedidoItensModelAlterar := TWebPedidoItensModel.getNewIface(vIConexao);

      lWebPedidoItensModel.objeto.IDWebPedidoView := StrToInt(pIDPedido);

      if pIDItem <> '' then
        lWebPedidoItensModel.objeto.IDRecordView := StrToInt(pIDItem);

      lWebPedidoItensModel.objeto.obterLista;

      for i := 0 to lWebPedidoItensModel.objeto.WebPedidoItenssLista.Count -1 do
      begin
        lWebPedidoItensModelAlterar := lWebPedidoItensModelAlterar.objeto.Alterar(lWebPedidoItensModel.objeto.WebPedidoItenssLista[i].objeto.ID);
        lWebPedidoItensModelAlterar.objeto.PERCENTUAL_DESCONTO := pPorcentagem;
        lWebPedidoItensModelAlterar.objeto.Salvar;
      end;

      result := True;
    except
     on E:Exception do
     begin
       CriaException('Erro: '+ E.Message);
       result := False;
     end;
    end;

  finally
    lWebPedidoItensModel:=nil;
    lWebPedidoItensModelAlterar:=nil;

  end;
end;

procedure TWebPedidoModel.IncluiReservaCD(pWebPedidoItensModel: ITWebPedidoItensModel);
var
  lReservaModel        : ITReservaModel;
  lWebPedidoItensModel : ITWebPedidoItensModel;
begin
  lReservaModel        := TReservaModel.getNewIface(vIConexao.NovaConexao('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA));
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(vIConexao);

  try
    try
      lWebPedidoItensModel := pWebPedidoItensModel;

      with lWebPedidoItensModel.objeto do
      begin
        lReservaModel.objeto.PRODUTO_ID          := PRODUTO_ID;
        lReservaModel.objeto.QUANTIDADE          := QUANTIDADE;
        lReservaModel.objeto.VALOR_UNITARIO      := VALOR_VENDIDO;
        lReservaModel.objeto.OBSERVACAO          := 'Reserva realizada pela venda assistida N '+WEB_PEDIDO_ID;
        lReservaModel.objeto.WEB_PEDIDOITENS_ID  := ID;
        lReservaModel.objeto.WEB_PEDIDO_ID       := WEB_PEDIDO_ID;
        lReservaModel.objeto.TIPO                := TIPO;
        lReservaModel.objeto.ENTREGA             := ENTREGA;
        lReservaModel.objeto.RETIRA_LOJA         := IIF(TIPO_ENTREGA = 'LJ','S','N');;
        lReservaModel.objeto.STATUS              := IIF(TIPO_ENTREGA = 'LJ','L','1');
        lReservaModel.objeto.CLIENTE_ID          := '000000';
        lReservaModel.objeto.VENDEDOR_ID         := '000000';
        lReservaModel.objeto.FILIAL              := vIConexao.getEmpresa.LOJA;
      end;

      lReservaModel.objeto.Incluir;

    except
     on E:Exception do
       CriaException('Erro: '+ E.Message);
    end;
  finally
    lReservaModel:=nil;
    lWebPedidoItensModel:=nil;
  end;
end;

function TWebPedidoModel.Negar(pID: String): Boolean;
var
  lWebPedidoModel : ITWebPedidoModel;
  lSolicitacaoDescontoModel : ITSolicitacaoDescontoModel;
  lMemTableSolicitacao : IFDDataset;
begin
  if pID = '' then
    CriaException('ID não informado');

  lSolicitacaoDescontoModel := TSolicitacaoDescontoModel.getNewIface(vIConexao);
  lWebPedidoModel           := TWebPedidoModel.getNewIface(vIConexao);
  try
    lWebPedidoModel := lWebPedidoModel.objeto.carregaClasse(pID);

    if (lWebPedidoModel.objeto.STATUS <> 'E') and (lWebPedidoModel.objeto.STATUS <> 'P') then
      CriaException('Permissão já negada ou autorizada.');

    if lWebPedidoModel.objeto.STATUS = 'E' then
    begin
      lSolicitacaoDescontoModel.objeto.WhereView := ' and solicitacao_desconto.tabela_origem = ''WEB_PEDIDO'' '+
                                             ' and solicitacao_desconto.pedido_id = '+lWebPedidoModel.objeto.ID +
                                             ' and solicitacao_desconto.status is null ';

      lMemTableSolicitacao := lSolicitacaoDescontoModel.objeto.obterLista;

      lSolicitacaoDescontoModel := lSolicitacaoDescontoModel.objeto.carregaClasse(lMemTableSolicitacao.objeto.FieldByName('ID').AsString);

      lSolicitacaoDescontoModel.objeto.USUARIO_CEDENTE := vIConexao.getUser.ID;
      lSolicitacaoDescontoModel.objeto.STATUS          := 'N';

      lSolicitacaoDescontoModel.objeto.Acao := tacAlterar;
      lSolicitacaoDescontoModel.objeto.Salvar;
    end;

    lWebPedidoModel.objeto.STATUS := 'D';
    lWebPedidoModel.objeto.Acao := tacAlterar;
    lWebPedidoModel.objeto.Salvar;

    Result := true;

  finally
    lSolicitacaoDescontoModel:=nil;
    lWebPedidoModel:=nil;
  end;
end;

function TWebPedidoModel.NegarDesconto(pID: String): Boolean;
var
  lWebPedidoModel  : ITWebPedidoModel;
  lPermissaoRemota : ITPermissaoRemotaModel;
  lTablePermissa   : IFDDataset;
begin
  if pID = '' then
    CriaException('ID não informado.');

  lWebPedidoModel  := TWebPedidoModel.getNewIface(vIConexao);
  lPermissaoRemota := TPermissaoRemotaModel.getNewIface(vIConexao);

  try
    lWebPedidoModel := lWebPedidoModel.objeto.carregaClasse(pID);

    if lWebPedidoModel.objeto.STATUS <> 'E' then
      CriaException('Desconto já negado ou autorizado.');

    lPermissaoRemota.objeto.WhereView := ' and permissao_remota.tabela = ''WEB_PEDIDOITENS'' '+
		                              ' and permissao_remota.pedido_id = '+pID +
		                              ' and coalesce(permissao_remota.status,'''') = '''' ';

    lTablePermissa := lPermissaoRemota.objeto.obterLista;

    lTablePermissa.objeto.First;
    while not lTablePermissa.objeto.Eof do
    begin
      lPermissaoRemota.objeto.Excluir(lTablePermissa.objeto.FieldByName('ID').AsString);
      lTablePermissa.objeto.Next;
    end;

    lWebPedidoModel.objeto.STATUS              := 'D';
		lWebPedidoModel.objeto.DATA_HORA_APROVACAO := '';
		lWebPedidoModel.objeto.USUARIO_APROVACAO   := '';

    lWebPedidoModel.objeto.Acao := tacAlterar;
    lWebPedidoModel.objeto.Salvar;

    Result := True;
  finally
    lPermissaoRemota:=nil;
    lWebPedidoModel:=nil;
  end;
end;

procedure TWebPedidoModel.AtualizaReservaCD(pWebPedidoModel: ITWebPedidoModel);
var
  lReservaModel : ITReservaModel;
  lWebPedidoModel : ITWebPedidoModel;
begin
  lReservaModel        := TReservaModel.getNewIface(vIConexao.NovaConexao('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA));
//  lReservaModel := TReservaModel.Create(vIConexao);
  lWebPedidoModel := TWebPedidoModel.getNewIface(vIConexao);

  try
    try
      lWebPedidoModel := pWebPedidoModel;

      lReservaModel := lReservaModel.objeto.Alterar(lWebPedidoModel.objeto.ID); //Precisa alterar "todas" reservas do peiddo

      with lWebPedidoModel do
      begin
        lReservaModel.objeto.ENTREGA_DATA       := ENTREGA_DATA;
        lReservaModel.objeto.ENTREGA_HORA       := ENTREGA_HORA;
        lReservaModel.objeto.MONTAGEM_DATA      := MONTAGEM_DATA;
        lReservaModel.objeto.MONTAGEM_HORA      := MONTAGEM_HORA;
        lReservaModel.objeto.CLIENTE_ID         := CLIENTE_ID;
        lReservaModel.objeto.VENDEDOR_ID        := VENDEDOR_ID;
        lReservaModel.objeto.FILIAL             := LOJA;
        lReservaModel.objeto.INFORMACOES_PED    := OBSERVACAO;
      end;

      lReservaModel.objeto.Salvar;

    except
     on E:Exception do
       CriaException('Erro: '+ E.Message);
    end;
  finally
    lReservaModel:=nil;
    lWebPedidoModel:=nil;
  end;
end;


function TWebPedidoModel.Autorizar(pID : String): Boolean;
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  lWebPedidoModel        : ITWebPedidoModel;
begin
  if pID = '' then
    CriaException('ID não informado');

  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);
  lWebPedidoModel        := TWebPedidoModel.getNewIface(vIConexao);

  try
    lWebPedidoModel := lWebPedidoModel.objeto.carregaClasse(pID);

    if (lWebPedidoModel.objeto.STATUS <> 'E') and (lWebPedidoModel.objeto.STATUS <> 'P') then
      CriaException('Permissão já negada ou autorizada.');

    if (lFinanceiroPedidoModel.objeto.qtdePagamentoPrazo(pID) = 0) then
    begin
      if lWebPedidoModel.objeto.STATUS <> 'E' then
        lWebPedidoModel.objeto.STATUS            := 'C';

      lWebPedidoModel.objeto.DATA_HORA_APROVACAO := DateTimeToStr(vIConexao.DataHoraServer);
      lWebPedidoModel.objeto.USUARIO_APROVACAO   := vIConexao.getUSer.ID;
    end
    else
    begin
      if lWebPedidoModel.objeto.STATUS <> 'E' then
        lWebPedidoModel.objeto.STATUS := 'A';
    end;

    lWebPedidoModel.objeto.Acao := tacAlterar;
    lWebPedidoModel.objeto.Salvar;

    Result := true;
  finally
    lFinanceiroPedidoModel:=nil;
    lWebPedidoModel:=nil;
  end;
end;

function TWebPedidoModel.AutorizarDesconto(pID: String): Boolean;
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  lWebPedidoModel        : ITWebPedidoModel;
  lPermissaoRemota       : ITPermissaoRemotaModel;
  lTablePermissao        : IFDDataset;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);
  lWebPedidoModel        := TWebPedidoModel.getNewIface(vIConexao);
  lPermissaoRemota       := TPermissaoRemotaModel.getNewIface(vIConexao);

  try
    lWebPedidoModel := lWebPedidoModel.objeto.carregaClasse(pID);

    if lWebPedidoModel.objeto.STATUS <> 'E' then
      CriaException('Desconto já negado ou autorizado.');

    lPermissaoRemota.objeto.WhereView := ' and permissao_remota.pedido_id = ' + pID +
                                  ' and permissao_remota.tabela = ''WEB_PEDIDOITENS'' '+
                                  ' and coalesce(permissao_remota.status,'''') = '''' ';

    lTablePermissao := lPermissaoRemota.objeto.obterLista;

    if lTablePermissao.objeto.RecordCount > 0 then
      lWebPedidoModel.objeto.STATUS := 'P'

    else if (lFinanceiroPedidoModel.objeto.qtdePagamentoPrazo(pID) = 0) then
      lWebPedidoModel.objeto.STATUS := 'C'

    else
      lWebPedidoModel.objeto.STATUS := 'A';

    lWebPedidoModel.objeto.Acao := tacAlterar;
    lWebPedidoModel.objeto.Salvar;

    Result := True;

  finally
    lFinanceiroPedidoModel:=nil;
    lPermissaoRemota:=nil;
    lWebPedidoModel:=nil;
  end;
end;

end.
