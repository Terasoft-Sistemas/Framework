unit SolicitacaoDescontoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TDescontoRemotoResultado = record
    fdLojasRecords,
    fdRegistros      : IFDDataset;
  end;

  TSolicitacaoDescontoModel = class;
  ITSolicitacaoDescontoModel = IObject<TSolicitacaoDescontoModel>;

  TSolicitacaoDescontoModel = class
  private
    [unsafe] mySelf: ITSolicitacaoDescontoModel;
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

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITSolicitacaoDescontoModel;

    function Incluir: String;
    function Alterar(pID : String): ITSolicitacaoDescontoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITSolicitacaoDescontoModel;
    function obterLista: IFDDataset;
    function obterDescontoVendaAssistidaRemoto: TDescontoRemotoResultado;

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
  Data.DB,
  SolicitacaoDescontoDao,
  System.Classes,
  Terasoft.Utils,
  System.SysUtils, DescontoModel, WebPedidoModel;

{ TSolicitacaoDescontoModel }

function TSolicitacaoDescontoModel.Alterar(pID: String): ITSolicitacaoDescontoModel;
var
  lSolicitacaoDescontoModel : ITSolicitacaoDescontoModel;
begin
  lSolicitacaoDescontoModel := TSolicitacaoDescontoModel.getNewIface(vIConexao);
  try
    lSolicitacaoDescontoModel       := lSolicitacaoDescontoModel.objeto.carregaClasse(pID);
    lSolicitacaoDescontoModel.objeto.Acao  := tacAlterar;
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

class function TSolicitacaoDescontoModel.getNewIface(pIConexao: IConexao): ITSolicitacaoDescontoModel;
begin
  Result := TImplObjetoOwner<TSolicitacaoDescontoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TSolicitacaoDescontoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TSolicitacaoDescontoModel.Autorizar(pID: String): Boolean;
var
  lSolicitacaoDesconto : ITSolicitacaoDescontoModel;
  lWebPedidoModel      : ITWebPedidoModel;
  lDescontoModel       : ITDescontoModel;
  lTableDesconto       : IFDDataset;
  lPercentual          : Double;
begin
  if pID = '' then
    CriaException('ID não informado.');

  lSolicitacaoDesconto := TSolicitacaoDescontoModel.getNewIface(vIConexao);
  lDescontoModel       := TDescontoModel.getNewIface(vIConexao);
  lWebPedidoModel      := TWebPedidoModel.getNewIface(vIConexao);

  try
    lSolicitacaoDesconto := lSolicitacaoDesconto.objeto.carregaClasse(pID);

    lDescontoModel.objeto.IDUsuarioView   := vIConexao.getUSer.ID;
    lDescontoModel.objeto.IDTipoVendaView := lSolicitacaoDesconto.objeto.TIPOVENDA_ID;

    lTableDesconto := lDescontoModel.objeto.ObterLista;

    lPercentual := lSolicitacaoDesconto.objeto.VALOR_DESCONTO / lSolicitacaoDesconto.objeto.VALOR_PEDIDO * 100;

    if (lPercentual > lTableDesconto.objeto.FieldByName('VALOR_DES').AsFloat) then
      CriaException('Desconto não autorizado');

    lSolicitacaoDesconto.objeto.USUARIO_CEDENTE := vIConexao.getUSer.ID;
    lSolicitacaoDesconto.objeto.STATUS          := 'A';

    lSolicitacaoDesconto.objeto.Acao := tacAlterar;
    lSolicitacaoDesconto.objeto.Salvar;

    if lSolicitacaoDesconto.objeto.TABELA_ORIGEM = 'WEB_PEDIDO' then
      lWebPedidoModel.objeto.AutorizarDesconto(lSolicitacaoDesconto.objeto.PEDIDO_ID);

    Result := True;

  finally
    lSolicitacaoDesconto:=nil;
    lWebPedidoModel:=nil;
    lDescontoModel:=nil;
  end;
end;

function TSolicitacaoDescontoModel.Negar(pID: String): Boolean;
var
  lSolicitacaoDesconto : ITSolicitacaoDescontoModel;
  lWebPedidoModel      : ITWebPedidoModel;
begin
  lSolicitacaoDesconto := TSolicitacaoDescontoModel.getNewIface(vIConexao);
  lWebPedidoModel      := TWebPedidoModel.getNewIface(vIConexao);

  try
    lSolicitacaoDesconto := lSolicitacaoDesconto.objeto.carregaClasse(pID);

    lSolicitacaoDesconto.objeto.USUARIO_CEDENTE := vIConexao.getUSer.ID;
    lSolicitacaoDesconto.objeto.STATUS          := 'N';

    lSolicitacaoDesconto.objeto.Acao := tacAlterar;
    lSolicitacaoDesconto.objeto.Salvar;

    if lSolicitacaoDesconto.objeto.TABELA_ORIGEM = 'WEB_PEDIDO' then
      lWebPedidoModel.objeto.NegarDesconto(lSolicitacaoDesconto.objeto.PEDIDO_ID);

    Result := True;

  finally
    lSolicitacaoDesconto:=nil;
    lWebPedidoModel:=nil;
  end;
end;

function TSolicitacaoDescontoModel.carregaClasse(pId : String): ITSolicitacaoDescontoModel;
var
  lSolicitacaoDescontoDao: ITSolicitacaoDescontoDao;
begin
  lSolicitacaoDescontoDao := TSolicitacaoDescontoDao.getNewIface(vIConexao);

  try
    Result := lSolicitacaoDescontoDao.objeto.carregaClasse(pId);
  finally
    lSolicitacaoDescontoDao:=nil;
  end;
end;

constructor TSolicitacaoDescontoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TSolicitacaoDescontoModel.Destroy;
begin
  inherited;
end;

function TSolicitacaoDescontoModel.obterDescontoVendaAssistidaRemoto: TDescontoRemotoResultado;
var
  lSolicitacaoDescontoDao : ITSolicitacaoDescontoDao;
begin

  lSolicitacaoDescontoDao := TSolicitacaoDescontoDao.getNewIface(vIConexao);
  try
    Result := lSolicitacaoDescontoDao.objeto.obterDescontoVendaAssistidaRemoto;
  finally
    lSolicitacaoDescontoDao := nil;
  end;
end;

function TSolicitacaoDescontoModel.obterLista: IFDDataset;
var
  lSolicitacaoDescontoLista: ITSolicitacaoDescontoDao;
begin
  lSolicitacaoDescontoLista := TSolicitacaoDescontoDao.getNewIface(vIConexao);

  try
    lSolicitacaoDescontoLista.objeto.TotalRecords    := FTotalRecords;
    lSolicitacaoDescontoLista.objeto.WhereView       := FWhereView;
    lSolicitacaoDescontoLista.objeto.CountView       := FCountView;
    lSolicitacaoDescontoLista.objeto.OrderView       := FOrderView;
    lSolicitacaoDescontoLista.objeto.StartRecordView := FStartRecordView;
    lSolicitacaoDescontoLista.objeto.LengthPageView  := FLengthPageView;
    lSolicitacaoDescontoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lSolicitacaoDescontoLista.objeto.obterLista;

    FTotalRecords := lSolicitacaoDescontoLista.objeto.TotalRecords;

  finally
    lSolicitacaoDescontoLista:=nil;
  end;
end;

function TSolicitacaoDescontoModel.Salvar: String;
var
  lSolicitacaoDescontoDao: ITSolicitacaoDescontoDao;
begin
  lSolicitacaoDescontoDao := TSolicitacaoDescontoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lSolicitacaoDescontoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lSolicitacaoDescontoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lSolicitacaoDescontoDao.objeto.excluir(mySelf);
    end;
  finally
    lSolicitacaoDescontoDao:=nil;
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
