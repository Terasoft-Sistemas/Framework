unit SolicitacaoDescontoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TSolicitacaoDescontoModel = class

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
    FVALOR_PEDIDO: Variant;
    FTIPOVENDA_ID: Variant;
    FPEDIDO_ID: Variant;
    FUSUARIO_CEDENTE: Variant;
    FCLIENTE_ID: Variant;
    FID: Variant;
    FUSUARIO_SOLICITANTE: Variant;
    FSTATUS: Variant;
    FSYSTIME: Variant;
    FTABELA_ORIGEM: Variant;
    FVALOR_DESCONTO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCLIENTE_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTABELA_ORIGEM(const Value: Variant);
    procedure SetTIPOVENDA_ID(const Value: Variant);
    procedure SetUSUARIO_CEDENTE(const Value: Variant);
    procedure SetUSUARIO_SOLICITANTE(const Value: Variant);
    procedure SetVALOR_DESCONTO(const Value: Variant);
    procedure SetVALOR_PEDIDO(const Value: Variant);

  public
    property ID: Variant read FID write SetID;
    property PEDIDO_ID: Variant read FPEDIDO_ID write SetPEDIDO_ID;
    property CLIENTE_ID: Variant read FCLIENTE_ID write SetCLIENTE_ID;
    property USUARIO_SOLICITANTE: Variant read FUSUARIO_SOLICITANTE write SetUSUARIO_SOLICITANTE;
    property USUARIO_CEDENTE: Variant read FUSUARIO_CEDENTE write SetUSUARIO_CEDENTE;
    property VALOR_PEDIDO: Variant read FVALOR_PEDIDO write SetVALOR_PEDIDO;
    property VALOR_DESCONTO: Variant read FVALOR_DESCONTO write SetVALOR_DESCONTO;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property TIPOVENDA_ID: Variant read FTIPOVENDA_ID write SetTIPOVENDA_ID;
    property TABELA_ORIGEM: Variant read FTABELA_ORIGEM write SetTABELA_ORIGEM;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TSolicitacaoDescontoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TSolicitacaoDescontoModel;
    function obterLista: TFDMemTable;

    function Autorizar(pID : String): Boolean;
    function Negar(pID : String): Boolean;

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
  SolicitacaoDescontoDao,
  System.Classes,
  Terasoft.Utils,
  System.SysUtils, DescontoModel, WebPedidoModel;

{ TSolicitacaoDescontoModel }

function TSolicitacaoDescontoModel.Alterar(pID: String): TSolicitacaoDescontoModel;
var
  lSolicitacaoDescontoModel : TSolicitacaoDescontoModel;
begin
  lSolicitacaoDescontoModel := TSolicitacaoDescontoModel.Create(vIConexao);
  try
    lSolicitacaoDescontoModel       := lSolicitacaoDescontoModel.carregaClasse(pID);
    lSolicitacaoDescontoModel.Acao  := tacAlterar;
    Result            := lSolicitacaoDescontoModel;
  finally
  end;
end;

function TSolicitacaoDescontoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TSolicitacaoDescontoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TSolicitacaoDescontoModel.Autorizar(pID: String): Boolean;
var
  lSolicitacaoDesconto : TSolicitacaoDescontoModel;
  lWebPedidoModel      : TWebPedidoModel;
  lDescontoModel       : TDescontoModel;
  lTableDesconto       : TFDMemTable;
  lPercentual          : Double;
begin
  if pID = '' then
    CriaException('ID não informado.');

  lSolicitacaoDesconto := TSolicitacaoDescontoModel.Create(vIConexao);
  lDescontoModel       := TDescontoModel.Create(vIConexao);
  lWebPedidoModel      := TWebPedidoModel.Create(vIConexao);

  try
    lSolicitacaoDesconto := lSolicitacaoDesconto.carregaClasse(pID);

    lDescontoModel.IDUsuarioView   := vIConexao.getUSer.ID;
    lDescontoModel.IDTipoVendaView := lSolicitacaoDesconto.TIPOVENDA_ID;

    lTableDesconto := lDescontoModel.ObterLista;

    lPercentual := lSolicitacaoDesconto.VALOR_DESCONTO / lSolicitacaoDesconto.VALOR_PEDIDO * 100;

    if (lPercentual > lTableDesconto.FieldByName('VALOR_DES').AsFloat) then
      CriaException('Desconto não autorizado');

    lSolicitacaoDesconto.USUARIO_CEDENTE := vIConexao.getUSer.ID;
    lSolicitacaoDesconto.STATUS          := 'A';

    lSolicitacaoDesconto.Acao := tacAlterar;
    lSolicitacaoDesconto.Salvar;

    if lSolicitacaoDesconto.TABELA_ORIGEM = 'WEB_PEDIDO' then
      lWebPedidoModel.AutorizarDesconto(lSolicitacaoDesconto.PEDIDO_ID);

    Result := True;

  finally
    lSolicitacaoDesconto.Free;
    lWebPedidoModel.Free;
    lDescontoModel.Free;
  end;
end;

function TSolicitacaoDescontoModel.Negar(pID: String): Boolean;
var
  lSolicitacaoDesconto : TSolicitacaoDescontoModel;
  lWebPedidoModel      : TWebPedidoModel;
begin
  lSolicitacaoDesconto := TSolicitacaoDescontoModel.Create(vIConexao);
  lWebPedidoModel      := TWebPedidoModel.Create(vIConexao);

  try
    lSolicitacaoDesconto := lSolicitacaoDesconto.carregaClasse(pID);

    lSolicitacaoDesconto.USUARIO_CEDENTE := vIConexao.getUSer.ID;
    lSolicitacaoDesconto.STATUS          := 'N';

    lSolicitacaoDesconto.Acao := tacAlterar;
    lSolicitacaoDesconto.Salvar;

    if lSolicitacaoDesconto.TABELA_ORIGEM = 'WEB_PEDIDO' then
      lWebPedidoModel.NegarDesconto(lSolicitacaoDesconto.PEDIDO_ID);

    Result := True;

  finally
    lSolicitacaoDesconto.Free;
    lWebPedidoModel.Free;
  end;
end;

function TSolicitacaoDescontoModel.carregaClasse(pId : String): TSolicitacaoDescontoModel;
var
  lSolicitacaoDescontoDao: TSolicitacaoDescontoDao;
begin
  lSolicitacaoDescontoDao := TSolicitacaoDescontoDao.Create(vIConexao);

  try
    Result := lSolicitacaoDescontoDao.carregaClasse(pId);
  finally
    lSolicitacaoDescontoDao.Free;
  end;
end;

constructor TSolicitacaoDescontoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TSolicitacaoDescontoModel.Destroy;
begin
  inherited;
end;

function TSolicitacaoDescontoModel.obterLista: TFDMemTable;
var
  lSolicitacaoDescontoLista: TSolicitacaoDescontoDao;
begin
  lSolicitacaoDescontoLista := TSolicitacaoDescontoDao.Create(vIConexao);

  try
    lSolicitacaoDescontoLista.TotalRecords    := FTotalRecords;
    lSolicitacaoDescontoLista.WhereView       := FWhereView;
    lSolicitacaoDescontoLista.CountView       := FCountView;
    lSolicitacaoDescontoLista.OrderView       := FOrderView;
    lSolicitacaoDescontoLista.StartRecordView := FStartRecordView;
    lSolicitacaoDescontoLista.LengthPageView  := FLengthPageView;
    lSolicitacaoDescontoLista.IDRecordView    := FIDRecordView;

    Result := lSolicitacaoDescontoLista.obterLista;

    FTotalRecords := lSolicitacaoDescontoLista.TotalRecords;

  finally
    lSolicitacaoDescontoLista.Free;
  end;
end;

function TSolicitacaoDescontoModel.Salvar: String;
var
  lSolicitacaoDescontoDao: TSolicitacaoDescontoDao;
begin
  lSolicitacaoDescontoDao := TSolicitacaoDescontoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lSolicitacaoDescontoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lSolicitacaoDescontoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lSolicitacaoDescontoDao.excluir(Self);
    end;
  finally
    lSolicitacaoDescontoDao.Free;
  end;
end;

procedure TSolicitacaoDescontoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TSolicitacaoDescontoModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TSolicitacaoDescontoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSolicitacaoDescontoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSolicitacaoDescontoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TSolicitacaoDescontoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSolicitacaoDescontoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TSolicitacaoDescontoModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TSolicitacaoDescontoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TSolicitacaoDescontoModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TSolicitacaoDescontoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TSolicitacaoDescontoModel.SetTABELA_ORIGEM(const Value: Variant);
begin
  FTABELA_ORIGEM := Value;
end;

procedure TSolicitacaoDescontoModel.SetTIPOVENDA_ID(const Value: Variant);
begin
  FTIPOVENDA_ID := Value;
end;

procedure TSolicitacaoDescontoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TSolicitacaoDescontoModel.SetUSUARIO_CEDENTE(const Value: Variant);
begin
  FUSUARIO_CEDENTE := Value;
end;

procedure TSolicitacaoDescontoModel.SetUSUARIO_SOLICITANTE(
  const Value: Variant);
begin
  FUSUARIO_SOLICITANTE := Value;
end;

procedure TSolicitacaoDescontoModel.SetVALOR_DESCONTO(const Value: Variant);
begin
  FVALOR_DESCONTO := Value;
end;

procedure TSolicitacaoDescontoModel.SetVALOR_PEDIDO(const Value: Variant);
begin
  FVALOR_PEDIDO := Value;
end;

procedure TSolicitacaoDescontoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
