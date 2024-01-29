unit FinanceiroPedidoModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
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
        
  public

    property  ID                   : Variant read FID write SetID;
    property  SYSTIME              : Variant read FSYSTIME write SetSYSTIME;
    property  DATA_CADASTRO        : Variant read FDATA_CADASTRO write SetDATA_CADASTRO;
    property  WEB_PEDIDO_ID        : Variant read FWEB_PEDIDO_ID write SetWEB_PEDIDO_ID;
    property  PEDIDO_VENDA_ID      : Variant read FPEDIDO_VENDA_ID write SetPEDIDO_VENDA_ID;
    property  PORTADOR_ID          : Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property  VALOR_TOTAL          : Variant read FVALOR_TOTAL write SetVALOR_TOTAL;
    property  QUANTIDADE_PARCELAS  : Variant read FQUANTIDADE_PARCELAS write SetQUANTIDADE_PARCELAS;
    property  PARCELA              : Variant read FPARCELA write SetPARCELA;
    property  VALOR_PARCELA        : Variant read FVALOR_PARCELA write SetVALOR_PARCELA;
    property  VENCIMENTO           : Variant read FVENCIMENTO write SetVENCIMENTO;
    property  CONDICAO_PAGAMENTO   : Variant read FCONDICAO_PAGAMENTO write SetCONDICAO_PAGAMENTO;
    property  OBSERVACAO           : Variant read FOBSERVACAO write SetOBSERVACAO;

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

  end;

implementation

uses
  FinanceiroPedidoDao;

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

  if self.FVENCIMENTO = '' then
    CriaException('Vencimento não informado.');

  if self.FCONDICAO_PAGAMENTO = '' then
    CriaException('Condição de Pagamento não informado.');

  self.Acao := tacIncluir;
  self.Salvar;
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

  self.FID  := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar;
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

procedure TFinanceiroPedidoModel.SetVALOR_PARCELA(const Value: Variant);
begin
  FVALOR_PARCELA := Value;
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
