unit FinanceiroPedidoModel;

interface

uses
  System.Math,
  Terasoft.Types,
  Terasoft.Utils,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TFinanceiroParams = record
    WEB_PEDIDO_ID,
    PORTADOR_ID           : String;
    PRIMEIRO_VENCIMENTO   : TDate;
    QUANTIDADE_PARCELAS   : Integer;
    INDCE_APLICADO        : Double;
    VALOR_ACRESCIMO       : Double;
    VALOR_LIQUIDO         : Double;
    VALOR_TOTAL           : Double;
    VALOR_SEG_PRESTAMISTA : Double;
    PER_SEG_PRESTAMSTA    : Double;
    VALOR_ACRESCIMO_SEG_PRESTAMISTA : Double;

  end;

  TFinanceiroPedidoModel = class

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
    FQUANTIDADE_PARCELAS: Variant;
    FPEDIDO_VENDA_ID: Variant;
    FOBSERVACAO: Variant;
    FVALOR_TOTAL: Variant;
    FPORTADOR_ID: Variant;
    FDATA_CADASTRO: Variant;
    FVENCIMENTO: Variant;
    FWEB_PEDIDO_ID: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FVALOR_PARCELA: Variant;
    FCONDICAO_PAGAMENTO: Variant;
    FPARCELA: Variant;
    FINDCE_APLICADO: Variant;
    FVALOR_ACRESCIMO: Variant;
    FID_FINANCEIRO: Variant;
    FVALOR_LIQUIDO: Variant;
    FVALOR_SEG_PRESTAMISTA: Variant;
    FPER_SEG_PRESTAMSTA: Variant;
    FVALOR_ACRESCIMO_SEG_PRESTAMISTA: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCONDICAO_PAGAMENTO(const Value: Variant);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetPARCELA(const Value: Variant);
    procedure SetPEDIDO_VENDA_ID(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetQUANTIDADE_PARCELAS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR_PARCELA(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);
    procedure SetVENCIMENTO(const Value: Variant);
    procedure SetWEB_PEDIDO_ID(const Value: Variant);
    procedure SetINDCE_APLICADO(const Value: Variant);
    procedure SetVALOR_ACRESCIMO(const Value: Variant);
    procedure SetID_FINANCEIRO(const Value: Variant);
    procedure SetVALOR_LIQUIDO(const Value: Variant);
    procedure SetPER_SEG_PRESTAMSTA(const Value: Variant);
    procedure SetVALOR_SEG_PRESTAMISTA(const Value: Variant);
    procedure SetVALOR_ACRESCIMO_SEG_PRESTAMISTA(const Value: Variant);
        
  public

    property  ID                    : Variant read FID write SetID;
    property  SYSTIME               : Variant read FSYSTIME write SetSYSTIME;
    property  DATA_CADASTRO         : Variant read FDATA_CADASTRO write SetDATA_CADASTRO;
    property  WEB_PEDIDO_ID         : Variant read FWEB_PEDIDO_ID write SetWEB_PEDIDO_ID;
    property  PEDIDO_VENDA_ID       : Variant read FPEDIDO_VENDA_ID write SetPEDIDO_VENDA_ID;
    property  PORTADOR_ID           : Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property  VALOR_TOTAL           : Variant read FVALOR_TOTAL write SetVALOR_TOTAL;
    property  QUANTIDADE_PARCELAS   : Variant read FQUANTIDADE_PARCELAS write SetQUANTIDADE_PARCELAS;
    property  PARCELA               : Variant read FPARCELA write SetPARCELA;
    property  VALOR_PARCELA         : Variant read FVALOR_PARCELA write SetVALOR_PARCELA;
    property  VENCIMENTO            : Variant read FVENCIMENTO write SetVENCIMENTO;
    property  CONDICAO_PAGAMENTO    : Variant read FCONDICAO_PAGAMENTO write SetCONDICAO_PAGAMENTO;
    property  OBSERVACAO            : Variant read FOBSERVACAO write SetOBSERVACAO;
    property  INDCE_APLICADO        : Variant read FINDCE_APLICADO write SetINDCE_APLICADO;
    property  VALOR_ACRESCIMO       : Variant read FVALOR_ACRESCIMO write SetVALOR_ACRESCIMO;
    property  ID_FINANCEIRO         : Variant read FID_FINANCEIRO write SetID_FINANCEIRO;
    property  VALOR_LIQUIDO         : Variant read FVALOR_LIQUIDO write SetVALOR_LIQUIDO;
    property  VALOR_SEG_PRESTAMISTA : Variant read FVALOR_SEG_PRESTAMISTA write SetVALOR_SEG_PRESTAMISTA;
    property  PER_SEG_PRESTAMSTA    : Variant read FPER_SEG_PRESTAMSTA write SetPER_SEG_PRESTAMSTA;
    property  VALOR_ACRESCIMO_SEG_PRESTAMISTA : Variant read FVALOR_ACRESCIMO_SEG_PRESTAMISTA write SetVALOR_ACRESCIMO_SEG_PRESTAMISTA;

    property Acao               : TAcao       read FAcao               write SetAcao;
    property TotalRecords       : Integer     read FTotalRecords       write SetTotalRecords;
    property WhereView          : String      read FWhereView          write SetWhereView;
    property CountView          : String      read FCountView          write SetCountView;
    property OrderView          : String      read FOrderView          write SetOrderView;
    property StartRecordView    : String      read FStartRecordView    write SetStartRecordView;
    property LengthPageView     : String      read FLengthPageView     write SetLengthPageView;
    property IDRecordView       : Integer     read FIDRecordView       write SetIDRecordView;


  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar  : String;

    function Incluir : String;
    function Alterar(pID: String): TFinanceiroPedidoModel;
    function Excluir(pID: String) : String;

    function carregaClasse(pId: String): TFinanceiroPedidoModel;
    function obterLista: TFDMemTable;
    function obterResumo(pIDPedido : String) : TFDMemTable;
    function qtdePagamentoPrazo(pWebPedido : String): Integer;
    function obterResumoFinanceiro : TFDMemTable;

    procedure gerarFinanceiro(pFinanceiroParams: TFinanceiroParams);

  end;

implementation

uses
  FinanceiroPedidoDao, System.Classes, System.SysUtils;

{ TFinanceiroPedidoModel }

function TFinanceiroPedidoModel.Incluir: String;
begin
  if self.FWEB_PEDIDO_ID = '' then
    CriaException('WebPedido não informado.');

  if self.FPORTADOR_ID = '' then
    CriaException('Portador não informado.');

  if self.FVALOR_TOTAL = '' then
    CriaException('Valor Total não informado.');

  if self.FQUANTIDADE_PARCELAS = '' then
    CriaException('Quantidade de Parcelas não informada.');

  if self.FPARCELA = '' then
    CriaException('Parcela não informada.');

  if self.FVALOR_PARCELA = '' then
    CriaException('Valor da Parcela não informado.');

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TFinanceiroPedidoModel.Alterar(pID: String): TFinanceiroPedidoModel;
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);
  try
    lFinanceiroPedidoModel := lFinanceiroPedidoModel.carregaClasse(pID);
    lFinanceiroPedidoModel.Acao := tacAlterar;
    Result := lFinanceiroPedidoModel;
  finally
  end;
end;

function TFinanceiroPedidoModel.Excluir(pID: String): String;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

  self.FID_FINANCEIRO  := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar;
end;

procedure TFinanceiroPedidoModel.gerarFinanceiro(pFinanceiroParams: TFinanceiroParams);
var
  i             : Integer;
  lSoma         : Double;
  lVencimento   : TDate;
  lIDFinanceiro : String;
  lRetorno      : String;
begin

  lVencimento   := pFinanceiroParams.PRIMEIRO_VENCIMENTO;
  lIDFinanceiro := '';
  lSoma         := 0;

  for i := 1 to pFinanceiroParams.QUANTIDADE_PARCELAS do
  begin
    self.WEB_PEDIDO_ID        := pFinanceiroParams.WEB_PEDIDO_ID;
    self.PORTADOR_ID          := pFinanceiroParams.PORTADOR_ID;
    self.VALOR_LIQUIDO        := FloatToStr(pFinanceiroParams.VALOR_LIQUIDO);
    self.VALOR_TOTAL          := FloatToStr(pFinanceiroParams.VALOR_TOTAL);
    self.QUANTIDADE_PARCELAS  := IntToStr(pFinanceiroParams.QUANTIDADE_PARCELAS);
    self.PARCELA              := IntToStr(i);
    self.VALOR_PARCELA        := FloatToStr(pFinanceiroParams.VALOR_TOTAL / pFinanceiroParams.QUANTIDADE_PARCELAS);
    self.INDCE_APLICADO       := FloatToStr(pFinanceiroParams.INDCE_APLICADO);
    self.VALOR_ACRESCIMO      := FloatToStr(pFinanceiroParams.VALOR_ACRESCIMO);
    self.ID_FINANCEIRO        := lIDFinanceiro;

    self.VALOR_SEG_PRESTAMISTA           := pFinanceiroParams.VALOR_SEG_PRESTAMISTA;
    self.PER_SEG_PRESTAMSTA              := pFinanceiroParams.PER_SEG_PRESTAMSTA;
    self.VALOR_ACRESCIMO_SEG_PRESTAMISTA := pFinanceiroParams.VALOR_ACRESCIMO_SEG_PRESTAMISTA;


    if i = 1 then
      self.VENCIMENTO         := DateToStr(lVencimento)
    else
    begin
      lVencimento     := IncMonth(lVencimento, 1);
      self.VENCIMENTO := DateToStr(lVencimento);
    end;

    lSoma := lSoma + self.VALOR_PARCELA;

    if i = pFinanceiroParams.QUANTIDADE_PARCELAS then
      self.VALOR_PARCELA := FloatToStr(self.VALOR_PARCELA + (pFinanceiroParams.VALOR_TOTAL - lSoma));

    lRetorno := self.Incluir;

    if i = 1 then
      lIDFinanceiro := lRetorno;

  end;

end;

function TFinanceiroPedidoModel.carregaClasse(pId: String): TFinanceiroPedidoModel;
var
  lFinanceiroPedidoDao : TFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.Create(vIConexao);
  try
    Result := lFinanceiroPedidoDao.carregaClasse(pId);
  finally
    lFinanceiroPedidoDao.Free;
  end;
end;

constructor TFinanceiroPedidoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFinanceiroPedidoModel.Destroy;
begin

  inherited;
end;

function TFinanceiroPedidoModel.obterResumo(pIDPedido : String): TFDMemTable;
var
  lFinanceiroPedidoDao : TFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.Create(vIConexao);
  try
    Result := lFinanceiroPedidoDao.obterResumo(pIDPedido);
  finally
    lFinanceiroPedidoDao.Free;
  end;
end;

function TFinanceiroPedidoModel.obterResumoFinanceiro: TFDMemTable;
var
  lFinanceiroPedidoDao : TFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.Create(vIConexao);
  try
    lFinanceiroPedidoDao.WhereView := FWhereView;

    Result := lFinanceiroPedidoDao.obterResumoFinanceiro;
  finally
    lFinanceiroPedidoDao.Free;
  end;
end;

function TFinanceiroPedidoModel.qtdePagamentoPrazo(pWebPedido: String): Integer;
var
  lFinanceiroPedidoDao: TFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.Create(vIConexao);
  try
    Result := lFinanceiroPedidoDao.qtdePagamentoPrazo(pWebPedido);
  finally
    lFinanceiroPedidoDao.Free;
  end;
end;

function TFinanceiroPedidoModel.obterLista: TFDMemTable;
var
  lFinanceiroPedidoLista: TFinanceiroPedidoDao;
begin
  lFinanceiroPedidoLista := TFinanceiroPedidoDao.Create(vIConexao);
  try
    lFinanceiroPedidoLista.TotalRecords    := FTotalRecords;
    lFinanceiroPedidoLista.WhereView       := FWhereView;
    lFinanceiroPedidoLista.CountView       := FCountView;
    lFinanceiroPedidoLista.OrderView       := FOrderView;
    lFinanceiroPedidoLista.StartRecordView := FStartRecordView;
    lFinanceiroPedidoLista.LengthPageView  := FLengthPageView;
    lFinanceiroPedidoLista.IDRecordView    := FIDRecordView;

    Result        := lFinanceiroPedidoLista.obterLista;
    FTotalRecords := lFinanceiroPedidoLista.TotalRecords;
  finally
    lFinanceiroPedidoLista.Free;
  end;
end;

function TFinanceiroPedidoModel.Salvar: String;
var
  lFinanceiroPedidoDao : TFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.Create(vIConexao);
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lFinanceiroPedidoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lFinanceiroPedidoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lFinanceiroPedidoDao.excluir(Self);
    end;
  finally
    lFinanceiroPedidoDao.Free;
  end;
end;

procedure TFinanceiroPedidoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TFinanceiroPedidoModel.SetCONDICAO_PAGAMENTO(const Value: Variant);
begin
  FCONDICAO_PAGAMENTO := Value;
end;

procedure TFinanceiroPedidoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFinanceiroPedidoModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;

procedure TFinanceiroPedidoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TFinanceiroPedidoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TFinanceiroPedidoModel.SetID_FINANCEIRO(const Value: Variant);
begin
  FID_FINANCEIRO := Value;
end;

procedure TFinanceiroPedidoModel.SetINDCE_APLICADO(const Value: Variant);
begin
  FINDCE_APLICADO := Value;
end;

procedure TFinanceiroPedidoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFinanceiroPedidoModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TFinanceiroPedidoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFinanceiroPedidoModel.SetPARCELA(const Value: Variant);
begin
  FPARCELA := Value;
end;

procedure TFinanceiroPedidoModel.SetPEDIDO_VENDA_ID(const Value: Variant);
begin
  FPEDIDO_VENDA_ID := Value;
end;

procedure TFinanceiroPedidoModel.SetPER_SEG_PRESTAMSTA(const Value: Variant);
begin
  FPER_SEG_PRESTAMSTA := Value;
end;

procedure TFinanceiroPedidoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TFinanceiroPedidoModel.SetQUANTIDADE_PARCELAS(const Value: Variant);
begin
  FQUANTIDADE_PARCELAS := Value;
end;

procedure TFinanceiroPedidoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFinanceiroPedidoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TFinanceiroPedidoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_ACRESCIMO(const Value: Variant);
begin
  FVALOR_ACRESCIMO := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_ACRESCIMO_SEG_PRESTAMISTA(
  const Value: Variant);
begin
  FVALOR_ACRESCIMO_SEG_PRESTAMISTA := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_LIQUIDO(const Value: Variant);
begin
  FVALOR_LIQUIDO := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_PARCELA(const Value: Variant);
begin
  FVALOR_PARCELA := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_SEG_PRESTAMISTA(const Value: Variant);
begin
  FVALOR_SEG_PRESTAMISTA := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;

procedure TFinanceiroPedidoModel.SetVENCIMENTO(const Value: Variant);
begin
  FVENCIMENTO := Value;
end;

procedure TFinanceiroPedidoModel.SetWEB_PEDIDO_ID(const Value: Variant);
begin
  FWEB_PEDIDO_ID := Value;
end;

procedure TFinanceiroPedidoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
