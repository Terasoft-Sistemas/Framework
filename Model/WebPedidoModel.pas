unit WebPedidoModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  System.Generics.Collections,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TVenderItemParametros = record
    PRODUTO,
    QUANTIDADE,
    DESCONTO         : String;
  end;

  TWebPedidoModel = class

  private
    vIConexao : IConexao;
    FWebPedidosLista: TObjectList<TWebPedidoModel>;
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
    procedure SetWebPedidosLista(const Value: TObjectList<TWebPedidoModel>);
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
    function carregaClasse(pId: String): TWebPedidoModel;

    function aprovarVendaAssistida(pIdVendaAssistida: Integer): String;
    function VenderItem(pVenderItemParametros: TVenderItemParametros): String;
    procedure calcularTotais;
    procedure obterTotais;

    function Incluir : String;
    function Alterar(pID: String): TWebPedidoModel;
    function Excluir(pID: String) : String;

    property WebPedidosLista: TObjectList<TWebPedidoModel> read FWebPedidosLista write SetWebPedidosLista;
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
  WebPedidoDao,
  PedidoVendaModel,
  WebPedidoItensModel,
  PedidoItensModel,
  System.SysUtils,
  FuncionarioModel,
  System.StrUtils, ProdutosModel, EmpresaModel, WebPedidoItensDao;

{ TWebPedidoModel }

procedure TWebPedidoModel.AfterConstruction;
begin
  inherited;

end;

function TWebPedidoModel.Alterar(pID : String): TWebPedidoModel;
var
  lWebPedidoModel : TWebPedidoModel;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    lWebPedidoModel := lWebPedidoModel.carregaClasse(pID);
    lWebPedidoModel.Acao := tacAlterar;
    Result := lWebPedidoModel;
  finally
  end;
end;

function TWebPedidoModel.aprovarVendaAssistida(pIdVendaAssistida: Integer): String;
var
  lPedidoVendaModel        : TPedidoVendaModel;
  lPedidoItensModel        : TPedidoItensModel;
  lWebPedidoItensModel     : TWebPedidoItensModel;
  lWebPedidoModel          : TWebPedidoModel;
  lPedido                  : String;
  lItem, lIndex            : Integer;
begin

  if not (pIdVendaAssistida <> 0) then
    exit;

  lWebPedidoModel        := TWebPedidoModel.Create(vIConexao);
  lPedidoVendaModel      := TPedidoVendaModel.Create(vIConexao);
  lWebPedidoItensModel   := TWebPedidoItensModel.Create(vIConexao);
  lPedidoItensModel      := TPedidoItensModel.Create(vIConexao);

  try

    lPedidoVendaModel.WhereView := ' and pedidovenda.web_pedido_id = '+ IntToStr(pIdVendaAssistida);
    lPedidoVendaModel.obterLista;

    if lPedidoVendaModel.TotalRecords > 0 then begin
      Result := lPedidoVendaModel.PedidoVendasLista[0].NUMERO_PED;
      exit;
    end;

    lWebPedidoModel := lWebPedidoModel.carregaClasse(pIdVendaAssistida.ToString);

    lPedidoVendaModel.Acao                 := tacIncluir;
    lPedidoVendaModel.LOJA                 := lWebPedidoModel.LOJA;
    lPedidoVendaModel.DATA_PED             := DateToStr(vIConexao.DataServer);
    lPedidoVendaModel.HORA_PED             := TimeToStr(vIConexao.HoraServer);
    lPedidoVendaModel.PRIMEIROVENC_PED     := lWebPedidoModel.PRIMEIRO_VENCIMENTO;
    lPedidoVendaModel.ACRES_PED            := lWebPedidoModel.ACRESCIMO;
    lPedidoVendaModel.DESC_PED             := lWebPedidoModel.VALOR_CUPOM_DESCONTO;
    lPedidoVendaModel.DESCONTO_PED         := lWebPedidoModel.PERCENTUAL_DESCONTO;
    lPedidoVendaModel.VALOR_PED            := FloatToStr((StrToFloat(lWebPedidoModel.VALOR_TOTAL)+StrToFloat(lWebPedidoModel.VALOR_CUPOM_DESCONTO))-StrToFloat(lWebPedidoModel.ACRESCIMO));
    lPedidoVendaModel.TOTAL_PED            := lWebPedidoModel.VALOR_TOTAL;
    lPedidoVendaModel.VALORENTADA_PED      := lWebPedidoModel.VALOR_ENTRADA;
    lPedidoVendaModel.PARCELAS_PED         := lWebPedidoModel.PARCELAS;
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
    lPedidoVendaModel.WEB_PEDIDO_ID        := lWebPedidoModel.ID;
    lPedidoVendaModel.CODIGO_CLI           := lWebPedidoModel.CLIENTE_ID;
    lPedidoVendaModel.CODIGO_PORT          := lWebPedidoModel.PORTADOR_ID;
    lPedidoVendaModel.CODIGO_VEN           := lWebPedidoModel.VENDEDOR_ID;
    lPedidoVendaModel.CODIGO_TIP           := lWebPedidoModel.TIPOVENDA_ID;
    lPedidoVendaModel.FRETE_PED            := lWebPedidoModel.VALOR_FRETE;
    lPedidoVendaModel.INFORMACOES_PED      := lWebPedidoModel.OBSERVACAO;
    lPedidoVendaModel.ENTREGA_ENDERECO     := lWebPedidoModel.ENTREGA_ENDERECO;
    lPedidoVendaModel.ENTREGA_NUMERO       := lWebPedidoModel.ENTREGA_NUMERO;
    lPedidoVendaModel.ENTREGA_BAIRRO       := lWebPedidoModel.ENTREGA_BAIRRO;
    lPedidoVendaModel.ENTREGA_CIDADE       := lWebPedidoModel.ENTREGA_CIDADE;
    lPedidoVendaModel.ENTREGA_UF           := lWebPedidoModel.ENTREGA_UF;
    lPedidoVendaModel.ENTREGA_CEP          := lWebPedidoModel.ENTREGA_CEP;
    lPedidoVendaModel.ENTREGA_COMPLEMENTO  := lWebPedidoModel.ENTREGA_COMPLEMENTO;
    lPedidoVendaModel.MONTAGEM_DATA        := lWebPedidoModel.MONTAGEM_DATA;
    lPedidoVendaModel.USUARIO_PED          := self.vIConexao.getUSer.ID;
    lPedidoVendaModel.IDUsuario            := self.vIConexao.getUSer.ID;
    lPedidoVendaModel.TIPO_COMISSAO        := self.TIPO_COMISSAO;
    lPedidoVendaModel.GERENTE_ID           := self.GERENTE_ID;

    lPedido := lPedidoVendaModel.Salvar;

    lPedidoVendaModel.NUMERO_PED := lPedido;

    lWebPedidoItensModel.IDWebPedidoView := pIdVendaAssistida;
    lWebPedidoItensModel.obterLista;

    lPedidoItensModel.PedidoItenssLista := TObjectList<TPedidoItensModel>.Create;

    lItem  := 0;
    lIndex := 0;

    for lWebPedidoItensModel in lWebPedidoItensModel.WebPedidoItenssLista do begin
      inc(lItem);

      lPedidoItensModel.PedidoItenssLista.Add(TPedidoItensModel.Create(vIConexao));

      lPedidoItensModel.PedidoItenssLista[lIndex].NUMERO_PED             := lPedido;
      lPedidoItensModel.PedidoItenssLista[lIndex].CODIGO_CLI             := lWebPedidoModel.CLIENTE_ID;
      lPedidoItensModel.PedidoItenssLista[lIndex].LOJA                   := lWebPedidoModel.LOJA;
      lPedidoItensModel.PedidoItenssLista[lIndex].QUANTIDADE_PED         := lWebPedidoItensModel.QUANTIDADE;
      lPedidoItensModel.PedidoItenssLista[lIndex].QUANTIDADE_NEW         := lWebPedidoItensModel.QUANTIDADE;
      lPedidoItensModel.PedidoItenssLista[lIndex].WEB_PEDIDOITENS_ID     := lWebPedidoItensModel.ID;
      lPedidoItensModel.PedidoItenssLista[lIndex].TIPO_VENDA             := lWebPedidoItensModel.TIPO_ENTREGA;
      lPedidoItensModel.PedidoItenssLista[lIndex].OBSERVACAO             := copy(lWebPedidoItensModel.OBSERVACAO,1,50);
      lPedidoItensModel.PedidoItenssLista[lIndex].OBS_ITEM               := lWebPedidoItensModel.OBSERVACAO;
      lPedidoItensModel.PedidoItenssLista[lIndex].CODIGO_PRO             := lWebPedidoItensModel.PRODUTO_ID;
      lPedidoItensModel.PedidoItenssLista[lIndex].QUANTIDADE_TIPO        := lWebPedidoItensModel.VLR_GARANTIA;
      lPedidoItensModel.PedidoItenssLista[lIndex].ENTREGA                := lWebPedidoItensModel.ENTREGA;
      lPedidoItensModel.PedidoItenssLista[lIndex].MONTAGEM               := lWebPedidoItensModel.MONTAGEM;
      lPedidoItensModel.PedidoItenssLista[lIndex].DESCONTO_PED           := lWebPedidoItensModel.PERCENTUAL_DESCONTO;
      lPedidoItensModel.PedidoItenssLista[lIndex].VALORUNITARIO_PED      := lWebPedidoItensModel.VALOR_UNITARIO;
      lPedidoItensModel.PedidoItenssLista[lIndex].ITEM                   := lItem.ToString;
      lPedidoItensModel.PedidoItenssLista[lIndex].VALOR_BONUS_SERVICO    := lWebPedidoItensModel.VALOR_BONUS_SERVICO;
      lPedidoItensModel.PedidoItenssLista[lIndex].BALANCA                := lWebPedidoItensModel.USAR_BALANCA;
      lPedidoItensModel.PedidoItenssLista[lIndex].VLRVENDA_PRO           := lWebPedidoItensModel.VENDA_PRO;
      lPedidoItensModel.PedidoItenssLista[lIndex].VALOR_VENDA_CADASTRO   := lWebPedidoItensModel.VENDA_PRO;
      lPedidoItensModel.PedidoItenssLista[lIndex].VLRCUSTO_PRO           := lWebPedidoItensModel.CUSTOMEDIO_PRO;
      lPedidoItensModel.PedidoItenssLista[lIndex].VALOR_MONTADOR         := lWebPedidoItensModel.VALOR_MONTADOR;
      lPedidoItensModel.PedidoItenssLista[lIndex].COMISSAO_PERCENTUAL    := lWebPedidoItensModel.PERCENTUAL_COMISSAO;
      lPedidoItensModel.PedidoItenssLista[lIndex].COMISSAO_PED           := '0';

      inc(lIndex);
    end;

    lPedidoItensModel.Acao := tacIncluirLote;
    lPedidoItensModel.Salvar;

    lPedidoVendaModel.gerarContasReceberPedido;

    lWebPedidoModel.FAcao      := tacAlterar;
    lWebPedidoModel.FSTATUS    := 'F';
    lWebPedidoModel.FPEDIDO_ID := lPedido;
    lWebPedidoModel.Salvar;

    Result := lPedido;

  finally
    lWebPedidoModel.Free;
    lPedidoVendaModel.Free;
    lWebPedidoItensModel.Free;
    lPedidoItensModel.Free;
  end;

end;

function TWebPedidoModel.carregaClasse(pId: String): TWebPedidoModel;
var
  lWebPedidoDao: TWebPedidoDao;
begin
  lWebPedidoDao := TWebPedidoDao.Create(vIConexao);
  try
    Result := lWebPedidoDao.carregaClasse(pId);
  finally
    lWebPedidoDao.Free;
  end;
end;

constructor TWebPedidoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TWebPedidoModel.Destroy;
begin

  inherited;
end;

function TWebPedidoModel.Excluir(pID: String): String;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

  self.FID  := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar;
end;

function TWebPedidoModel.Incluir: String;
begin
    self.FDATAHORA              := DateTimeToStr(vIConexao.DataHoraServer);
    self.FUSUARIO               := vIConexao.getUSer.ID;
    self.FSTATUS                := 'I';
    self.FTIPO                  := 'NORMAL';
    self.FPARCELAS              := '001';
    self.FPRIMEIRO_VENCIMENTO   := DateToStr(vIConexao.DataServer + 30);

    self.Acao := tacIncluir;
    self.Salvar;
end;

procedure TWebPedidoModel.obterListaVendaAssistida;
var
  lWebPedidoLista: TWebPedidoDao;
begin
  lWebPedidoLista := TWebPedidoDao.Create(vIConexao);

  try
    lWebPedidoLista.TotalRecords    := FTotalRecords;
    lWebPedidoLista.WhereView       := FWhereView;
    lWebPedidoLista.CountView       := FCountView;
    lWebPedidoLista.OrderView       := FOrderView;
    lWebPedidoLista.StartRecordView := FStartRecordView;
    lWebPedidoLista.LengthPageView  := FLengthPageView;
    lWebPedidoLista.IDRecordView    := FIDRecordView;

    lWebPedidoLista.obterListaVendaAssistida;

    FTotalRecords    := lWebPedidoLista.TotalRecords;
    FWebPedidosLista := lWebPedidoLista.WebPedidosLista;

  finally
    lWebPedidoLista.Free;
  end;
end;

procedure TWebPedidoModel.obterTotais;
var
  lWebPedidoItensModel : TWebPedidoItensModel;
  lTotais : TTotais;
begin
  lWebPedidoItensModel := TWebPedidoItensModel.Create(vIConexao);
  try
    lTotais := lWebPedidoItensModel.obterTotais(self.FID);

    self.ACRESCIMO            := lTotais.ACRESCIMO.ToString;
    self.VALOR_FRETE          := lTotais.FRETE.ToString;
    self.VALOR_CUPOM_DESCONTO := lTotais.DESCONTO.ToString;
    self.VALOR_ITENS          := lTotais.VALOR_ITENS.ToString;
    self.VALOR_TOTAL          := lTotais.VALOR_TOTAL.ToString;
  finally
    lWebPedidoItensModel.free;
  end;
end;

procedure TWebPedidoModel.calcularTotais;
var
  lWebPedidoItensDao : TWebPedidoItensDao;
  lTotais            : TTotais;
begin
  lWebPedidoItensDao := TWebPedidoItensDao.Create(vIConexao);
  try
    lTotais := lWebPedidoItensDao.obterTotais(self.FID);

    self.Acao := tacAlterar;
    self.VALOR_TOTAL := lTotais.VALOR_TOTAL;
    self.Salvar;
  finally
    lWebPedidoItensDao.Free;
  end;
end;

function TWebPedidoModel.Salvar: String;
var
  lWebPedidoDao : TWebPedidoDao;
begin
  lWebPedidoDao := TWebPedidoDao.Create(vIConexao);
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lWebPedidoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lWebPedidoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lWebPedidoDao.excluir(Self);
    end;
  finally
    lWebPedidoDao.Free;
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

procedure TWebPedidoModel.SetWebPedidosLista(const Value: TObjectList<TWebPedidoModel>);
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
  lWebPedidoItensModel : TWebPedidoItensModel;
  lProdutoModel        : TProdutosModel;
  lPrecoParamentros    : TProdutoPreco;

begin
  lWebPedidoItensModel := TWebPedidoItensModel.Create(vIConexao);
  lProdutoModel        := TProdutosModel.Create(vIConexao);

  if pVenderItemParametros.PRODUTO = '' then
    CriaException('Produto não informado');

  if StrToFloatDef(pVenderItemParametros.QUANTIDADE, 0) = 0 then
    CriaException('Quantidade não informada');

  try
    lProdutoModel.IDRecordView := pVenderItemParametros.PRODUTO;
    lProdutoModel.obterLista;

    lProdutoModel := lProdutoModel.ProdutossLista[0];

    lWebPedidoItensModel.Acao                := tacIncluir;
    lWebPedidoItensModel.WEB_PEDIDO_ID       := self.ID;
    lWebPedidoItensModel.PRODUTO_ID          := pVenderItemParametros.PRODUTO;
    lWebPedidoItensModel.QUANTIDADE          := pVenderItemParametros.QUANTIDADE;

    lPrecoParamentros.Produto       := pVenderItemParametros.PRODUTO;
    lPrecoParamentros.Cliente       := self.FCLIENTE_ID;
    lPrecoParamentros.Portador      := self.FPORTADOR_ID;
    lPrecoParamentros.PrecoVenda    := '';
    lPrecoParamentros.Loja          := self.FLOJA;
    lPrecoParamentros.Qtde          := StrToFloatDef(pVenderItemParametros.QUANTIDADE, 0);
    lPrecoParamentros.PrecoUf       := false;
    lPrecoParamentros.Promocao      := true;
    lPrecoParamentros.PrecoCliente  := false;
    lPrecoParamentros.TabelaPreco   := true;

    lWebPedidoItensModel.VALOR_UNITARIO      := lProdutoModel.ValorUnitario(lPrecoParamentros);
    lWebPedidoItensModel.VALOR_VENDIDO       := lWebPedidoItensModel.VALOR_UNITARIO;
    lWebPedidoItensModel.QUANTIDADE_TROCA    := '0';
		lWebPedidoItensModel.PERCENTUAL_DESCONTO := '0';
		lWebPedidoItensModel.VALOR_VENDA_ATUAL   := lProdutoModel.VENDA_PRO;
		lWebPedidoItensModel.VALOR_CUSTO_ATUAL   := lProdutoModel.CUSTOMEDIO_PRO;
    lWebPedidoItensModel.TIPO_ENTREGA        := 'LJ';
		lWebPedidoItensModel.RESERVADO           := pVenderItemParametros.QUANTIDADE;
    lWebPedidoItensModel.TIPO                := 'NORMAL';

    Result := lWebPedidoItensModel.Salvar;
    calcularTotais;
  finally
    lWebPedidoItensModel.Free;
    lProdutoModel.Free;
  end;
end;

end.
