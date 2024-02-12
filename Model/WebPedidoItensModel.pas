unit WebPedidoItensModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  System.Generics.Collections,
  Interfaces.Conexao;

type

  TTotais = record
    VALOR_ACRESCIMO,
    VALOR_FRETE,
    VALOR_DESCONTO,
    VALOR_ITENS,
    VALOR_TOTAL    : Double;
  end;

  TWebPedidoItensModel = class

  private
    vIConexao : IConexao;
    FWebPedidoItenssLista: TObjectList<TWebPedidoItensModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FBASE_ST: Variant;
    FQUANTIDADE_OLD: Variant;
    FVALOR_CUSTO_ATUAL: Variant;
    FVALOR_UNITARIO: Variant;
    FVALOR_ICMS: Variant;
    FREDUCAO_ICMS: Variant;
    FIPI_SUFRAMA: Variant;
    FOBSERVACAO: Variant;
    FPRODUTO_ID: Variant;
    FAVULSO: Variant;
    FVALOR_VENDA_ATUAL: Variant;
    FVALOR_VENDIDO: Variant;
    FDESC_RESTITUICAO_ST: Variant;
    FALIQ_ICMS: Variant;
    FPERCENTUAL_COMISSAO: Variant;
    FENTREGA: Variant;
    FQUANTIDADE_SEPARACAO: Variant;
    FVBCFCPST: Variant;
    FMVA: Variant;
    FVALOR_PIS: Variant;
    FVALOR_COFINS: Variant;
    FICMS_SUFRAMA: Variant;
    FVLR_GARANTIA: Variant;
    FVALOR_ST: Variant;
    FREDUCAO_ST: Variant;
    FWEB_PEDIDO_ID: Variant;
    FALIQ_ICMS_ST: Variant;
    FVALOR_RESTITUICAO_ST: Variant;
    FALIQ_PIS: Variant;
    FALIQ_COFINS: Variant;
    FBASE_ICMS: Variant;
    FCFOP_ID: Variant;
    FTIPO_GARANTIA: Variant;
    FMONTAGEM: Variant;
    FQUANTIDADE_TROCA: Variant;
    FSYSTIME: Variant;
    FVALOR_IPI: Variant;
    FQUANTIDADE: Variant;
    FRESERVADO: Variant;
    FPERCENTUAL_DESCONTO: Variant;
    FPIS_SUFRAMA: Variant;
    FTIPO_ENTREGA: Variant;
    FPFCPST: Variant;
    FCOFINS_SUFRAMA: Variant;
    FVFCPST: Variant;
    FALIQ_IPI: Variant;
    FTIPO: Variant;
    FCST: Variant;
    FQUANTIDADE_PENDENTE: Variant;
    FBASE_PIS: Variant;
    FQUANTIDADE_TROCA_OLD: Variant;
    FBASE_COFINS: Variant;
    FPRODUTO_REFERENCIA: Variant;
    FPRODUTO_NOME: Variant;
    FPRODUTO_REFERENCIA_NEW: Variant;
    FPRODUTO_BARRAS: Variant;
    FPRODUTO_CODIGO: Variant;
    FTOTAL: Variant;
    FIDWebPedidoView: Integer;
    FUSAR_BALANCA: Variant;
    FVENDA_PRO: Variant;
    FCUSTOMEDIO_PRO: Variant;
    FVALOR_MONTADOR: Variant;
    FVALOR_BONUS_SERVICO: Variant;
    FID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetWebPedidoItenssLista(const Value: TObjectList<TWebPedidoItensModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetALIQ_COFINS(const Value: Variant);
    procedure SetALIQ_ICMS(const Value: Variant);
    procedure SetALIQ_ICMS_ST(const Value: Variant);
    procedure SetALIQ_IPI(const Value: Variant);
    procedure SetALIQ_PIS(const Value: Variant);
    procedure SetAVULSO(const Value: Variant);
    procedure SetBASE_COFINS(const Value: Variant);
    procedure SetBASE_ICMS(const Value: Variant);
    procedure SetBASE_PIS(const Value: Variant);
    procedure SetBASE_ST(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCOFINS_SUFRAMA(const Value: Variant);
    procedure SetCST(const Value: Variant);
    procedure SetDESC_RESTITUICAO_ST(const Value: Variant);
    procedure SetENTREGA(const Value: Variant);
    procedure SetICMS_SUFRAMA(const Value: Variant);
    procedure SetIPI_SUFRAMA(const Value: Variant);
    procedure SetMONTAGEM(const Value: Variant);
    procedure SetMVA(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetPERCENTUAL_COMISSAO(const Value: Variant);
    procedure SetPERCENTUAL_DESCONTO(const Value: Variant);
    procedure SetPFCPST(const Value: Variant);
    procedure SetPIS_SUFRAMA(const Value: Variant);
    procedure SetPRODUTO_ID(const Value: Variant);
    procedure SetQUANTIDADE(const Value: Variant);
    procedure SetQUANTIDADE_OLD(const Value: Variant);
    procedure SetQUANTIDADE_PENDENTE(const Value: Variant);
    procedure SetQUANTIDADE_SEPARACAO(const Value: Variant);
    procedure SetQUANTIDADE_TROCA(const Value: Variant);
    procedure SetQUANTIDADE_TROCA_OLD(const Value: Variant);
    procedure SetREDUCAO_ICMS(const Value: Variant);
    procedure SetREDUCAO_ST(const Value: Variant);
    procedure SetRESERVADO(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetTIPO_ENTREGA(const Value: Variant);
    procedure SetTIPO_GARANTIA(const Value: Variant);
    procedure SetVALOR_COFINS(const Value: Variant);
    procedure SetVALOR_CUSTO_ATUAL(const Value: Variant);
    procedure SetVALOR_ICMS(const Value: Variant);
    procedure SetVALOR_IPI(const Value: Variant);
    procedure SetVALOR_PIS(const Value: Variant);
    procedure SetVALOR_RESTITUICAO_ST(const Value: Variant);
    procedure SetVALOR_ST(const Value: Variant);
    procedure SetVALOR_UNITARIO(const Value: Variant);
    procedure SetVALOR_VENDA_ATUAL(const Value: Variant);
    procedure SetVALOR_VENDIDO(const Value: Variant);
    procedure SetVBCFCPST(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetVLR_GARANTIA(const Value: Variant);
    procedure SetWEB_PEDIDO_ID(const Value: Variant);
    procedure SetPRODUTO_BARRAS(const Value: Variant);
    procedure SetPRODUTO_CODIGO(const Value: Variant);
    procedure SetPRODUTO_NOME(const Value: Variant);
    procedure SetPRODUTO_REFERENCIA(const Value: Variant);
    procedure SetPRODUTO_REFERENCIA_NEW(const Value: Variant);
    procedure SetTOTAL(const Value: Variant);
    procedure SetIDWebPedidoView(const Value: Integer);
    procedure SetCUSTOMEDIO_PRO(const Value: Variant);
    procedure SetUSAR_BALANCA(const Value: Variant);
    procedure SetVALOR_BONUS_SERVICO(const Value: Variant);
    procedure SetVALOR_MONTADOR(const Value: Variant);
    procedure SetVENDA_PRO(const Value: Variant);
    procedure SetID(const Value: Variant);
  public
    property ID: Variant read FID write SetID;
    property WEB_PEDIDO_ID: Variant read FWEB_PEDIDO_ID write SetWEB_PEDIDO_ID;
    property PRODUTO_ID: Variant read FPRODUTO_ID write SetPRODUTO_ID;
    property QUANTIDADE: Variant read FQUANTIDADE write SetQUANTIDADE;
    property QUANTIDADE_TROCA: Variant read FQUANTIDADE_TROCA write SetQUANTIDADE_TROCA;
    property VALOR_UNITARIO: Variant read FVALOR_UNITARIO write SetVALOR_UNITARIO;
    property PERCENTUAL_DESCONTO: Variant read FPERCENTUAL_DESCONTO write SetPERCENTUAL_DESCONTO;
    property VALOR_VENDA_ATUAL: Variant read FVALOR_VENDA_ATUAL write SetVALOR_VENDA_ATUAL;
    property VALOR_CUSTO_ATUAL: Variant read FVALOR_CUSTO_ATUAL write SetVALOR_CUSTO_ATUAL;
    property PERCENTUAL_COMISSAO: Variant read FPERCENTUAL_COMISSAO write SetPERCENTUAL_COMISSAO;
    property OBSERVACAO: Variant read FOBSERVACAO write SetOBSERVACAO;
    property QUANTIDADE_OLD: Variant read FQUANTIDADE_OLD write SetQUANTIDADE_OLD;
    property QUANTIDADE_TROCA_OLD: Variant read FQUANTIDADE_TROCA_OLD write SetQUANTIDADE_TROCA_OLD;
    property AVULSO: Variant read FAVULSO write SetAVULSO;
    property VALOR_ST: Variant read FVALOR_ST write SetVALOR_ST;
    property RESERVADO: Variant read FRESERVADO write SetRESERVADO;
    property TIPO_GARANTIA: Variant read FTIPO_GARANTIA write SetTIPO_GARANTIA;
    property VLR_GARANTIA: Variant read FVLR_GARANTIA write SetVLR_GARANTIA;
    property TIPO_ENTREGA: Variant read FTIPO_ENTREGA write SetTIPO_ENTREGA;
    property MONTAGEM: Variant read FMONTAGEM write SetMONTAGEM;
    property ENTREGA: Variant read FENTREGA write SetENTREGA;
    property TIPO: Variant read FTIPO write SetTIPO;
    property QUANTIDADE_PENDENTE: Variant read FQUANTIDADE_PENDENTE write SetQUANTIDADE_PENDENTE;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property VALOR_VENDIDO: Variant read FVALOR_VENDIDO write SetVALOR_VENDIDO;
    property QUANTIDADE_SEPARACAO: Variant read FQUANTIDADE_SEPARACAO write SetQUANTIDADE_SEPARACAO;
    property ALIQ_IPI: Variant read FALIQ_IPI write SetALIQ_IPI;
    property VALOR_IPI: Variant read FVALOR_IPI write SetVALOR_IPI;
    property CFOP_ID: Variant read FCFOP_ID write SetCFOP_ID;
    property CST: Variant read FCST write SetCST;
    property VALOR_RESTITUICAO_ST: Variant read FVALOR_RESTITUICAO_ST write SetVALOR_RESTITUICAO_ST;
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
    property VBCFCPST: Variant read FVBCFCPST write SetVBCFCPST;
    property PFCPST: Variant read FPFCPST write SetPFCPST;
    property VFCPST: Variant read FVFCPST write SetVFCPST;
    property TOTAL: Variant read FTOTAL write SetTOTAL;

    property PRODUTO_CODIGO: Variant read FPRODUTO_CODIGO write SetPRODUTO_CODIGO;
    property PRODUTO_REFERENCIA_NEW: Variant read FPRODUTO_REFERENCIA_NEW write SetPRODUTO_REFERENCIA_NEW;
    property PRODUTO_REFERENCIA: Variant read FPRODUTO_REFERENCIA write SetPRODUTO_REFERENCIA;
    property PRODUTO_BARRAS: Variant read FPRODUTO_BARRAS write SetPRODUTO_BARRAS;
    property PRODUTO_NOME: Variant read FPRODUTO_NOME write SetPRODUTO_NOME;
    property VALOR_BONUS_SERVICO: Variant read FVALOR_BONUS_SERVICO write SetVALOR_BONUS_SERVICO;
    property USAR_BALANCA: Variant read FUSAR_BALANCA write SetUSAR_BALANCA;
    property VENDA_PRO: Variant read FVENDA_PRO write SetVENDA_PRO;
    property CUSTOMEDIO_PRO: Variant read FCUSTOMEDIO_PRO write SetCUSTOMEDIO_PRO;
    property VALOR_MONTADOR: Variant read FVALOR_MONTADOR write SetVALOR_MONTADOR;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TWebPedidoItensModel;
    Function Excluir (pID : String) : String;

    function Salvar   : String;

    procedure obterListaVendaAssistidaItens;
    procedure obterLista;

    function carregaClasse(pId: String): TWebPedidoItensModel;

    function obterTotais(pId: String): TTotais;

    property WebPedidoItenssLista: TObjectList<TWebPedidoItensModel> read FWebPedidoItenssLista write SetWebPedidoItenssLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDWebPedidoView: Integer read FIDWebPedidoView write SetIDWebPedidoView;

  end;

implementation

uses
  WebPedidoItensDao;

{ TWebPedidoItensModel }

function TWebPedidoItensModel.Incluir: String;
begin
  self.FQUANTIDADE_TROCA    := '0';
  self.FPERCENTUAL_DESCONTO := '0';

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TWebPedidoItensModel.Alterar(pID : String): TWebPedidoItensModel;
var
  lWebPedidoItensModel : TWebPedidoItensModel;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

    lWebPedidoItensModel := TWebPedidoItensModel.Create(vIConexao);
  try
    lWebPedidoItensModel := lWebPedidoItensModel.carregaClasse(pID);
    lWebPedidoItensModel.Acao := tacAlterar;
    Result := lWebPedidoItensModel;
  finally
  end;
end;

function TWebPedidoItensModel.Excluir(pID : String): String;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

  self.FID  := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar;
end;

function TWebPedidoItensModel.carregaClasse(pId: String): TWebPedidoItensModel;
var
  lWebPedidoItensDao: TWebPedidoItensDao;
begin
  lWebPedidoItensDao := TWebPedidoItensDao.Create(vIConexao);
  try
    Result := lWebPedidoItensDao.carregaClasse(pId);
  finally
    lWebPedidoItensDao.Free;
  end;
end;
constructor TWebPedidoItensModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TWebPedidoItensModel.Destroy;
begin

  inherited;
end;

procedure TWebPedidoItensModel.obterLista;
var
  lWebPedidoItensLista: TWebPedidoItensDao;
begin
  lWebPedidoItensLista := TWebPedidoItensDao.Create(vIConexao);

  try
    lWebPedidoItensLista.TotalRecords    := FTotalRecords;
    lWebPedidoItensLista.WhereView       := FWhereView;
    lWebPedidoItensLista.CountView       := FCountView;
    lWebPedidoItensLista.OrderView       := FOrderView;
    lWebPedidoItensLista.StartRecordView := FStartRecordView;
    lWebPedidoItensLista.LengthPageView  := FLengthPageView;
    lWebPedidoItensLista.IDRecordView    := FIDRecordView;
    lWebPedidoItensLista.IDWebPedidoView := FIDWebPedidoView;

    lWebPedidoItensLista.obterLista;

    FTotalRecords         := lWebPedidoItensLista.TotalRecords;
    FWebPedidoItenssLista := lWebPedidoItensLista.WebPedidoItenssLista;

  finally
    lWebPedidoItensLista.Free;
  end;
end;

procedure TWebPedidoItensModel.obterListaVendaAssistidaItens;
var
  lWebPedidoItensLista: TWebPedidoItensDao;
begin
  lWebPedidoItensLista := TWebPedidoItensDao.Create(vIConexao);

  try
    lWebPedidoItensLista.TotalRecords    := FTotalRecords;
    lWebPedidoItensLista.WhereView       := FWhereView;
    lWebPedidoItensLista.CountView       := FCountView;
    lWebPedidoItensLista.OrderView       := FOrderView;
    lWebPedidoItensLista.StartRecordView := FStartRecordView;
    lWebPedidoItensLista.LengthPageView  := FLengthPageView;
    lWebPedidoItensLista.IDRecordView    := FIDRecordView;
    lWebPedidoItensLista.IDWebPedidoView := FIDWebPedidoView;

    lWebPedidoItensLista.obterListaVendaAssistidaItens;

    FTotalRecords         := lWebPedidoItensLista.TotalRecords;
    FWebPedidoItenssLista := lWebPedidoItensLista.WebPedidoItenssLista;

  finally
    lWebPedidoItensLista.Free;
  end;
end;

function TWebPedidoItensModel.obterTotais(pId: String): TTotais;
var
  lWebPedidoItensDao : TWebPedidoItensDao;
begin
  lWebPedidoItensDao := TWebPedidoItensDao.Create(vIConexao);
  try
    Result := lWebPedidoItensDao.obterTotais(pId);
  finally
    lWebPedidoItensDao.Free;
  end;
end;

function TWebPedidoItensModel.Salvar: String;
var
  lWebPedidoItensDao: TWebPedidoItensDao;
begin
  lWebPedidoItensDao := TWebPedidoItensDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lWebPedidoItensDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lWebPedidoItensDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lWebPedidoItensDao.excluir(Self);
    end;
  finally
    lWebPedidoItensDao.Free;
  end;
end;

procedure TWebPedidoItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TWebPedidoItensModel.SetALIQ_COFINS(const Value: Variant);
begin
  FALIQ_COFINS := Value;
end;

procedure TWebPedidoItensModel.SetALIQ_ICMS(const Value: Variant);
begin
  FALIQ_ICMS := Value;
end;

procedure TWebPedidoItensModel.SetALIQ_ICMS_ST(const Value: Variant);
begin
  FALIQ_ICMS_ST := Value;
end;

procedure TWebPedidoItensModel.SetALIQ_IPI(const Value: Variant);
begin
  FALIQ_IPI := Value;
end;

procedure TWebPedidoItensModel.SetALIQ_PIS(const Value: Variant);
begin
  FALIQ_PIS := Value;
end;

procedure TWebPedidoItensModel.SetAVULSO(const Value: Variant);
begin
  FAVULSO := Value;
end;

procedure TWebPedidoItensModel.SetBASE_COFINS(const Value: Variant);
begin
  FBASE_COFINS := Value;
end;

procedure TWebPedidoItensModel.SetBASE_ICMS(const Value: Variant);
begin
  FBASE_ICMS := Value;
end;

procedure TWebPedidoItensModel.SetBASE_PIS(const Value: Variant);
begin
  FBASE_PIS := Value;
end;

procedure TWebPedidoItensModel.SetBASE_ST(const Value: Variant);
begin
  FBASE_ST := Value;
end;

procedure TWebPedidoItensModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;

procedure TWebPedidoItensModel.SetCOFINS_SUFRAMA(const Value: Variant);
begin
  FCOFINS_SUFRAMA := Value;
end;

procedure TWebPedidoItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TWebPedidoItensModel.SetCST(const Value: Variant);
begin
  FCST := Value;
end;

procedure TWebPedidoItensModel.SetCUSTOMEDIO_PRO(const Value: Variant);
begin
  FCUSTOMEDIO_PRO := Value;
end;

procedure TWebPedidoItensModel.SetDATA_CADASTRO(const Value: Variant);
begin

end;

procedure TWebPedidoItensModel.SetDESC_RESTITUICAO_ST(const Value: Variant);
begin
  FDESC_RESTITUICAO_ST := Value;
end;

procedure TWebPedidoItensModel.SetENTREGA(const Value: Variant);
begin
  FENTREGA := Value;
end;

procedure TWebPedidoItensModel.SetWebPedidoItenssLista(const Value: TObjectList<TWebPedidoItensModel>);
begin
  FWebPedidoItenssLista := Value;
end;

procedure TWebPedidoItensModel.SetICMS_SUFRAMA(const Value: Variant);
begin
  FICMS_SUFRAMA := Value;
end;

procedure TWebPedidoItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TWebPedidoItensModel.SetIDWebPedidoView(const Value: Integer);
begin
  FIDWebPedidoView := Value;
end;

procedure TWebPedidoItensModel.SetPERCENTUAL_COMISSAO(const Value: Variant);
begin
  FPERCENTUAL_COMISSAO := Value;
end;

procedure TWebPedidoItensModel.SetPERCENTUAL_DESCONTO(const Value: Variant);
begin
  FPERCENTUAL_DESCONTO := Value;
end;

procedure TWebPedidoItensModel.SetPFCPST(const Value: Variant);
begin
  FPFCPST := Value;
end;

procedure TWebPedidoItensModel.SetPIS_SUFRAMA(const Value: Variant);
begin
  FPIS_SUFRAMA := Value;
end;

procedure TWebPedidoItensModel.SetPRODUTO_BARRAS(const Value: Variant);
begin
  FPRODUTO_BARRAS := Value;
end;

procedure TWebPedidoItensModel.SetPRODUTO_CODIGO(const Value: Variant);
begin
  FPRODUTO_CODIGO := Value;
end;

procedure TWebPedidoItensModel.SetPRODUTO_ID(const Value: Variant);
begin
  FPRODUTO_ID := Value;
end;

procedure TWebPedidoItensModel.SetPRODUTO_NOME(const Value: Variant);
begin
  FPRODUTO_NOME := Value;
end;

procedure TWebPedidoItensModel.SetPRODUTO_REFERENCIA(const Value: Variant);
begin
  FPRODUTO_REFERENCIA := Value;
end;

procedure TWebPedidoItensModel.SetPRODUTO_REFERENCIA_NEW(const Value: Variant);
begin
  FPRODUTO_REFERENCIA_NEW := Value;
end;

procedure TWebPedidoItensModel.SetQUANTIDADE(const Value: Variant);
begin
  FQUANTIDADE := Value;
end;

procedure TWebPedidoItensModel.SetQUANTIDADE_OLD(const Value: Variant);
begin
  FQUANTIDADE_OLD := Value;
end;

procedure TWebPedidoItensModel.SetQUANTIDADE_PENDENTE(const Value: Variant);
begin
  FQUANTIDADE_PENDENTE := Value;
end;

procedure TWebPedidoItensModel.SetQUANTIDADE_SEPARACAO(const Value: Variant);
begin
  FQUANTIDADE_SEPARACAO := Value;
end;

procedure TWebPedidoItensModel.SetQUANTIDADE_TROCA(const Value: Variant);
begin
  FQUANTIDADE_TROCA := Value;
end;

procedure TWebPedidoItensModel.SetQUANTIDADE_TROCA_OLD(const Value: Variant);
begin
  FQUANTIDADE_TROCA_OLD := Value;
end;

procedure TWebPedidoItensModel.SetREDUCAO_ICMS(const Value: Variant);
begin
  FREDUCAO_ICMS := Value;
end;

procedure TWebPedidoItensModel.SetREDUCAO_ST(const Value: Variant);
begin
  FREDUCAO_ST := Value;
end;

procedure TWebPedidoItensModel.SetRESERVADO(const Value: Variant);
begin
  FRESERVADO := Value;
end;

procedure TWebPedidoItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TWebPedidoItensModel.SetIPI_SUFRAMA(const Value: Variant);
begin
  FIPI_SUFRAMA := Value;
end;

procedure TWebPedidoItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TWebPedidoItensModel.SetMONTAGEM(const Value: Variant);
begin
  FMONTAGEM := Value;
end;

procedure TWebPedidoItensModel.SetMVA(const Value: Variant);
begin
  FMVA := Value;
end;

procedure TWebPedidoItensModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TWebPedidoItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TWebPedidoItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TWebPedidoItensModel.SetSYSTIME(const Value: Variant);
begin

end;

procedure TWebPedidoItensModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TWebPedidoItensModel.SetTIPO_ENTREGA(const Value: Variant);
begin
  FTIPO_ENTREGA := Value;
end;

procedure TWebPedidoItensModel.SetTIPO_GARANTIA(const Value: Variant);
begin
  FTIPO_GARANTIA := Value;
end;

procedure TWebPedidoItensModel.SetTOTAL(const Value: Variant);
begin
  FTOTAL := Value;
end;

procedure TWebPedidoItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TWebPedidoItensModel.SetUSAR_BALANCA(const Value: Variant);
begin
  FUSAR_BALANCA := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_BONUS_SERVICO(const Value: Variant);
begin
  FVALOR_BONUS_SERVICO := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_COFINS(const Value: Variant);
begin
  FVALOR_COFINS := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_CUSTO_ATUAL(const Value: Variant);
begin
  FVALOR_CUSTO_ATUAL := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_ICMS(const Value: Variant);
begin
  FVALOR_ICMS := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_IPI(const Value: Variant);
begin
  FVALOR_IPI := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_MONTADOR(const Value: Variant);
begin
  FVALOR_MONTADOR := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_PIS(const Value: Variant);
begin
  FVALOR_PIS := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_RESTITUICAO_ST(const Value: Variant);
begin
  FVALOR_RESTITUICAO_ST := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_ST(const Value: Variant);
begin
  FVALOR_ST := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_UNITARIO(const Value: Variant);
begin
  FVALOR_UNITARIO := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_VENDA_ATUAL(const Value: Variant);
begin
  FVALOR_VENDA_ATUAL := Value;
end;

procedure TWebPedidoItensModel.SetVALOR_VENDIDO(const Value: Variant);
begin
  FVALOR_VENDIDO := Value;
end;

procedure TWebPedidoItensModel.SetVBCFCPST(const Value: Variant);
begin
  FVBCFCPST := Value;
end;

procedure TWebPedidoItensModel.SetVENDA_PRO(const Value: Variant);
begin
  FVENDA_PRO := Value;
end;

procedure TWebPedidoItensModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TWebPedidoItensModel.SetVLR_GARANTIA(const Value: Variant);
begin
  FVLR_GARANTIA := Value;
end;

procedure TWebPedidoItensModel.SetWEB_PEDIDO_ID(const Value: Variant);
begin
  FWEB_PEDIDO_ID := Value;
end;

procedure TWebPedidoItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
