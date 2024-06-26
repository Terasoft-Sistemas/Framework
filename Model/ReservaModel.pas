unit ReservaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TReservaModel = class

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
    FHORAS_BAIXA: Variant;
    FVALOR_UNITARIO: Variant;
    FENTREGA_HORA: Variant;
    FOBSERVACAO: Variant;
    FFILIAL: Variant;
    FDESCONTO: Variant;
    FPRODUTO_ID: Variant;
    FMONTAGEM_DATA: Variant;
    FHORA: Variant;
    FENTREGA: Variant;
    FPEDIDO_ID: Variant;
    FRETIRA_LOJA: Variant;
    FMONTAGEM_HORA: Variant;
    FCLIENTE_ID: Variant;
    FID: Variant;
    FSTATUS: Variant;
    FVENDEDOR_ID: Variant;
    FSYSTIME: Variant;
    FINFORMACOES_PED: Variant;
    FQUANTIDADE: Variant;
    FWEB_PEDIDOITENS_ID: Variant;
    FPRODUCAO_ID: Variant;
    FDATAHORA_EFETIVADA: Variant;
    FPRODUCAO_LOJA: Variant;
    FENTREGA_DATA: Variant;
    FTIPO: Variant;
    FDATA: Variant;
    FWEB_PEDIDO_ID: Variant;
    FENTREGA_BAIRRO: Variant;
    FENTREGA_UF: Variant;
    FENTREGA_CEP: Variant;
    FENTREGA_NUMERO: Variant;
    FENTREGA_COMPLEMENTO: Variant;
    FENTREGA_CIDADE: Variant;
    FENTREGA_ENDERECO: Variant;
    FENTREGA_COD_MUNICIPIO: Variant;
    FVALOR_ACRESCIMO: Variant;
    FVALOR_TOTAL: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCLIENTE_ID(const Value: Variant);
    procedure SetDATA(const Value: Variant);
    procedure SetDATAHORA_EFETIVADA(const Value: Variant);
    procedure SetDESCONTO(const Value: Variant);
    procedure SetENTREGA(const Value: Variant);
    procedure SetENTREGA_DATA(const Value: Variant);
    procedure SetENTREGA_HORA(const Value: Variant);
    procedure SetFILIAL(const Value: Variant);
    procedure SetHORA(const Value: Variant);
    procedure SetHORAS_BAIXA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetINFORMACOES_PED(const Value: Variant);
    procedure SetMONTAGEM_DATA(const Value: Variant);
    procedure SetMONTAGEM_HORA(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetPRODUCAO_ID(const Value: Variant);
    procedure SetPRODUCAO_LOJA(const Value: Variant);
    procedure SetPRODUTO_ID(const Value: Variant);
    procedure SetQUANTIDADE(const Value: Variant);
    procedure SetRETIRA_LOJA(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetVALOR_UNITARIO(const Value: Variant);
    procedure SetVENDEDOR_ID(const Value: Variant);
    procedure SetWEB_PEDIDOITENS_ID(const Value: Variant);
    procedure SetWEB_PEDIDO_ID(const Value: Variant);
    procedure SetENTREGA_BAIRRO(const Value: Variant);
    procedure SetENTREGA_CEP(const Value: Variant);
    procedure SetENTREGA_CIDADE(const Value: Variant);
    procedure SetENTREGA_COD_MUNICIPIO(const Value: Variant);
    procedure SetENTREGA_COMPLEMENTO(const Value: Variant);
    procedure SetENTREGA_ENDERECO(const Value: Variant);
    procedure SetENTREGA_NUMERO(const Value: Variant);
    procedure SetENTREGA_UF(const Value: Variant);
    procedure SetVALOR_ACRESCIMO(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);

  public

    property ID                   : Variant  read FID write SetID;
    property PRODUTO_ID           : Variant  read FPRODUTO_ID write SetPRODUTO_ID;
    property CLIENTE_ID           : Variant  read FCLIENTE_ID write SetCLIENTE_ID;
    property VENDEDOR_ID          : Variant  read FVENDEDOR_ID write SetVENDEDOR_ID;
    property QUANTIDADE           : Variant  read FQUANTIDADE write SetQUANTIDADE;
    property VALOR_UNITARIO       : Variant  read FVALOR_UNITARIO write SetVALOR_UNITARIO;
    property DESCONTO             : Variant  read FDESCONTO write SetDESCONTO;
    property DATA                 : Variant  read FDATA write SetDATA;
    property HORAS_BAIXA          : Variant  read FHORAS_BAIXA write SetHORAS_BAIXA;
    property STATUS               : Variant  read FSTATUS write SetSTATUS;
    property HORA                 : Variant  read FHORA write SetHORA;
    property FILIAL               : Variant  read FFILIAL write SetFILIAL;
    property PEDIDO_ID            : Variant  read FPEDIDO_ID write SetPEDIDO_ID;
    property INFORMACOES_PED      : Variant  read FINFORMACOES_PED write SetINFORMACOES_PED;
    property OBSERVACAO           : Variant  read FOBSERVACAO write SetOBSERVACAO;
    property WEB_PEDIDOITENS_ID   : Variant  read FWEB_PEDIDOITENS_ID write SetWEB_PEDIDOITENS_ID;
    property TIPO                 : Variant  read FTIPO write SetTIPO;
    property DATAHORA_EFETIVADA   : Variant  read FDATAHORA_EFETIVADA write SetDATAHORA_EFETIVADA;
    property RETIRA_LOJA          : Variant  read FRETIRA_LOJA write SetRETIRA_LOJA;
    property ENTREGA              : Variant  read FENTREGA write SetENTREGA;
    property ENTREGA_DATA         : Variant  read FENTREGA_DATA write SetENTREGA_DATA;
    property ENTREGA_HORA         : Variant  read FENTREGA_HORA write SetENTREGA_HORA;
    property MONTAGEM_DATA        : Variant  read FMONTAGEM_DATA write SetMONTAGEM_DATA;
    property MONTAGEM_HORA        : Variant  read FMONTAGEM_HORA write SetMONTAGEM_HORA;
    property SYSTIME              : Variant  read FSYSTIME write SetSYSTIME;
    property PRODUCAO_ID          : Variant  read FPRODUCAO_ID write SetPRODUCAO_ID;
    property PRODUCAO_LOJA        : Variant  read FPRODUCAO_LOJA write SetPRODUCAO_LOJA;
    property WEB_PEDIDO_ID        : Variant read FWEB_PEDIDO_ID write SetWEB_PEDIDO_ID;
    property ENTREGA_ENDERECO     : Variant read FENTREGA_ENDERECO write SetENTREGA_ENDERECO;
    property ENTREGA_COMPLEMENTO  : Variant read FENTREGA_COMPLEMENTO write SetENTREGA_COMPLEMENTO;
    property ENTREGA_NUMERO       : Variant read FENTREGA_NUMERO write SetENTREGA_NUMERO;
    property ENTREGA_BAIRRO       : Variant read FENTREGA_BAIRRO write SetENTREGA_BAIRRO;
    property ENTREGA_CIDADE       : Variant read FENTREGA_CIDADE write SetENTREGA_CIDADE;
    property ENTREGA_UF           : Variant read FENTREGA_UF write SetENTREGA_UF;
    property ENTREGA_CEP          : Variant read FENTREGA_CEP write SetENTREGA_CEP;
    property ENTREGA_COD_MUNICIPIO: Variant read FENTREGA_COD_MUNICIPIO write SetENTREGA_COD_MUNICIPIO;

    property VALOR_ACRESCIMO      : Variant read FVALOR_ACRESCIMO write SetVALOR_ACRESCIMO;
    property VALOR_TOTAL          : Variant read FVALOR_TOTAL write SetVALOR_TOTAL;


  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TReservaModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TReservaModel;
    function obterLista: TFDMemTable;

    function AtualizaReservaVendaAssistida(pAtualizaReserva_Parametros: TAtualizaReserva_Parametros): String;
    function concluirReserva(pStatus, pPedido, pWebPedidoItensId, pFilial: String): Boolean;
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
  ReservaDao,
  System.Classes, 
  System.SysUtils;

{ TReservaModel }

function TReservaModel.Alterar(pID: String): TReservaModel;
var
  lReservaModel : TReservaModel;
begin
  lReservaModel := TReservaModel.Create(vIConexao);
  try
    lReservaModel       := lReservaModel.carregaClasse(pID);
    lReservaModel.Acao  := tacAlterar;
    Result              := lReservaModel;
  finally
  end;
end;

function TReservaModel.AtualizaReservaVendaAssistida(pAtualizaReserva_Parametros: TAtualizaReserva_Parametros): String;
var
  lReservaDao : TReservaDao;
begin
  lReservaDao := TReservaDao.Create(vIConexao);
  try
    Result := lReservaDao.AtualizaReservaVendaAssistida(pAtualizaReserva_Parametros);
  finally
    lReservaDao.Free;
  end;
end;

function TReservaModel.Excluir(pID: String): String;
begin
  self.ID       := pID;
  self.FAcao    := tacExcluir;
  Result        := self.Salvar;
end;

function TReservaModel.Incluir: String;
begin
  self.DATA        := DateToStr(vIConexao.DataServer);
  self.HORA        := TimeToStr(vIConexao.HoraServer);
  self.HORAS_BAIXA := '24';

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TReservaModel.carregaClasse(pId : String): TReservaModel;
var
  lReservaDao: TReservaDao;
begin
  lReservaDao := TReservaDao.Create(vIConexao);

  try
    Result := lReservaDao.carregaClasse(pId);
  finally
    lReservaDao.Free;
  end;
end;

function TReservaModel.concluirReserva(pStatus, pPedido, pWebPedidoItensId, pFilial: String): Boolean;
var
  lTableReserva: TFDMemTable;
begin
  self.WhereView := ' and reserva.web_pedidoitens_id = ' + pWebPedidoItensId + ' and reserva.filial = ' + QuotedStr(pFilial);
  lTableReserva := self.obterLista;

  self := self.Alterar(lTableReserva.FieldByName('ID').AsString);

  self.STATUS             := pStatus;
  self.PEDIDO_ID          := pPedido;
  self.DATAHORA_EFETIVADA := DateTimeToStr(vIConexao.DataHoraServer);
  self.Salvar;
end;

constructor TReservaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TReservaModel.Destroy;
begin
  inherited;
end;

function TReservaModel.obterLista: TFDMemTable;
var
  lReservaLista: TReservaDao;
begin
  lReservaLista := TReservaDao.Create(vIConexao);

  try
    lReservaLista.TotalRecords    := FTotalRecords;
    lReservaLista.WhereView       := FWhereView;
    lReservaLista.CountView       := FCountView;
    lReservaLista.OrderView       := FOrderView;
    lReservaLista.StartRecordView := FStartRecordView;
    lReservaLista.LengthPageView  := FLengthPageView;
    lReservaLista.IDRecordView    := FIDRecordView;

    Result := lReservaLista.obterLista;

    FTotalRecords := lReservaLista.TotalRecords;

  finally
    lReservaLista.Free;
  end;
end;

function TReservaModel.Salvar: String;
var
  lReservaDao: TReservaDao;
begin
  lReservaDao := TReservaDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lReservaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lReservaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lReservaDao.excluir(Self);
    end;

  finally
    lReservaDao.Free;
  end;
end;

procedure TReservaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TReservaModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TReservaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TReservaModel.SetDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TReservaModel.SetDATAHORA_EFETIVADA(const Value: Variant);
begin
  FDATAHORA_EFETIVADA := Value;
end;

procedure TReservaModel.SetDESCONTO(const Value: Variant);
begin
  FDESCONTO := Value;
end;

procedure TReservaModel.SetENTREGA(const Value: Variant);
begin
  FENTREGA := Value;
end;

procedure TReservaModel.SetENTREGA_BAIRRO(const Value: Variant);
begin
  FENTREGA_BAIRRO := Value;
end;

procedure TReservaModel.SetENTREGA_CEP(const Value: Variant);
begin
  FENTREGA_CEP := Value;
end;

procedure TReservaModel.SetENTREGA_CIDADE(const Value: Variant);
begin
  FENTREGA_CIDADE := Value;
end;

procedure TReservaModel.SetENTREGA_COD_MUNICIPIO(const Value: Variant);
begin
  FENTREGA_COD_MUNICIPIO := Value;
end;

procedure TReservaModel.SetENTREGA_COMPLEMENTO(const Value: Variant);
begin
  FENTREGA_COMPLEMENTO := Value;
end;

procedure TReservaModel.SetENTREGA_DATA(const Value: Variant);
begin
  FENTREGA_DATA := Value;
end;

procedure TReservaModel.SetENTREGA_ENDERECO(const Value: Variant);
begin
  FENTREGA_ENDERECO := Value;
end;

procedure TReservaModel.SetENTREGA_HORA(const Value: Variant);
begin
  FENTREGA_HORA := Value;
end;

procedure TReservaModel.SetENTREGA_NUMERO(const Value: Variant);
begin
  FENTREGA_NUMERO := Value;
end;

procedure TReservaModel.SetENTREGA_UF(const Value: Variant);
begin
  FENTREGA_UF := Value;
end;

procedure TReservaModel.SetFILIAL(const Value: Variant);
begin
  FFILIAL := Value;
end;

procedure TReservaModel.SetHORA(const Value: Variant);
begin
  FHORA := Value;
end;

procedure TReservaModel.SetHORAS_BAIXA(const Value: Variant);
begin
  FHORAS_BAIXA := Value;
end;

procedure TReservaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TReservaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TReservaModel.SetINFORMACOES_PED(const Value: Variant);
begin
  FINFORMACOES_PED := Value;
end;

procedure TReservaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TReservaModel.SetMONTAGEM_DATA(const Value: Variant);
begin
  FMONTAGEM_DATA := Value;
end;

procedure TReservaModel.SetMONTAGEM_HORA(const Value: Variant);
begin
  FMONTAGEM_HORA := Value;
end;

procedure TReservaModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TReservaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TReservaModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TReservaModel.SetPRODUCAO_ID(const Value: Variant);
begin
  FPRODUCAO_ID := Value;
end;

procedure TReservaModel.SetPRODUCAO_LOJA(const Value: Variant);
begin
  FPRODUCAO_LOJA := Value;
end;

procedure TReservaModel.SetPRODUTO_ID(const Value: Variant);
begin
  FPRODUTO_ID := Value;
end;

procedure TReservaModel.SetQUANTIDADE(const Value: Variant);
begin
  FQUANTIDADE := Value;
end;

procedure TReservaModel.SetRETIRA_LOJA(const Value: Variant);
begin
  FRETIRA_LOJA := Value;
end;

procedure TReservaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;


procedure TReservaModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TReservaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TReservaModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TReservaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TReservaModel.SetVALOR_ACRESCIMO(const Value: Variant);
begin
  FVALOR_ACRESCIMO := Value;
end;

procedure TReservaModel.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;

procedure TReservaModel.SetVALOR_UNITARIO(const Value: Variant);
begin
  FVALOR_UNITARIO := Value;
end;

procedure TReservaModel.SetVENDEDOR_ID(const Value: Variant);
begin
  FVENDEDOR_ID := Value;
end;

procedure TReservaModel.SetWEB_PEDIDOITENS_ID(const Value: Variant);
begin
  FWEB_PEDIDOITENS_ID := Value;
end;

procedure TReservaModel.SetWEB_PEDIDO_ID(const Value: Variant);
begin
  FWEB_PEDIDO_ID := Value;
end;

procedure TReservaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
