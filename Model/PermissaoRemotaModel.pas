unit PermissaoRemotaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TPermissaoRemotaModel = class;
  ITPermissaoRemotaModel=IObject<TPermissaoRemotaModel>;

  TPermissaoRemotaModel = class
  private
    [weak] mySelf:ITPermissaoRemotaModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FOPERACAO: Variant;
    FREGISTRO_ID: Variant;
    FMSG_SOLICITACAO: Variant;
    FPEDIDO_ID: Variant;
    FTABELA: Variant;
    FUSUARIO_CEDENTE: Variant;
    FID: Variant;
    FUSUARIO_SOLICITANTE: Variant;
    FSTATUS: Variant;
    FSYSTIME: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetMSG_SOLICITACAO(const Value: Variant);
    procedure SetOPERACAO(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetREGISTRO_ID(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTABELA(const Value: Variant);
    procedure SetUSUARIO_CEDENTE(const Value: Variant);
    procedure SetUSUARIO_SOLICITANTE(const Value: Variant);

  public
    property ID                    : Variant read FID write SetID;
    property USUARIO_SOLICITANTE   : Variant read FUSUARIO_SOLICITANTE write SetUSUARIO_SOLICITANTE;
    property USUARIO_CEDENTE       : Variant read FUSUARIO_CEDENTE write SetUSUARIO_CEDENTE;
    property OPERACAO              : Variant read FOPERACAO write SetOPERACAO;
    property MSG_SOLICITACAO       : Variant read FMSG_SOLICITACAO write SetMSG_SOLICITACAO;
    property STATUS                : Variant read FSTATUS write SetSTATUS;
    property SYSTIME               : Variant read FSYSTIME write SetSYSTIME;
    property TABELA                : Variant read FTABELA write SetTABELA;
    property REGISTRO_ID           : Variant read FREGISTRO_ID write SetREGISTRO_ID;
    property PEDIDO_ID             : Variant read FPEDIDO_ID write SetPEDIDO_ID;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPermissaoRemotaModel;

    function Incluir: String;
    function Alterar(pID : String): ITPermissaoRemotaModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITPermissaoRemotaModel;
    function obterLista: IFDDataset;

    function Autorizar(pID : String): Boolean;
    function Negar(pID: String): Boolean;

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
  System.Classes,
  System.SysUtils,
  Terasoft.Utils,
  PermissaoRemotaDao,
  WebPedidoModel,
  Terasoft.Configuracoes;

{ TPermissaoRemotaModel }

function TPermissaoRemotaModel.Alterar(pID: String): ITPermissaoRemotaModel;
var
  lPermissaoRemotaModel : ITPermissaoRemotaModel;
begin
  lPermissaoRemotaModel := TPermissaoRemotaModel.getNewIface(vIConexao);
  try
    lPermissaoRemotaModel       := lPermissaoRemotaModel.objeto.carregaClasse(pID);
    lPermissaoRemotaModel.objeto.Acao  := tacAlterar;
    Result            := lPermissaoRemotaModel;
  finally
  end;
end;

function TPermissaoRemotaModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TPermissaoRemotaModel.getNewIface(pIConexao: IConexao): ITPermissaoRemotaModel;
begin
  Result := TImplObjetoOwner<TPermissaoRemotaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPermissaoRemotaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TPermissaoRemotaModel.Autorizar(pID: String): Boolean;
var
  lPermissaoRemotaModel : ITPermissaoRemotaModel;
  lWebPedidoModel       : ITWebPedidoModel;
  lConfiguracoes        : ITerasoftConfiguracoes;
begin
  if pID = '' then
    CriaException('ID não informado');

  lPermissaoRemotaModel := TPermissaoRemotaModel.getNewIface(vIConexao);
  lWebPedidoModel       := TWebPedidoModel.getNewIface(vIConexao);

  try
    lPermissaoRemotaModel := lPermissaoRemotaModel.objeto.carregaClasse(pID);

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    if not lConfiguracoes.objeto.verificaPerfil(lPermissaoRemotaModel.objeto.OPERACAO) then
      CriaException('Usuário sem permissão para autorizar essa solicitação.');

    lPermissaoRemotaModel.objeto.Acao := tacAlterar;
    lPermissaoRemotaModel.objeto.USUARIO_CEDENTE := vIConexao.getUSer.ID;
    lPermissaoRemotaModel.objeto.STATUS          := 'A';
    lPermissaoRemotaModel.objeto.Salvar;

    if (lPermissaoRemotaModel.objeto.TABELA = 'WEB_PEDIDOITENS') and
       ((lPermissaoRemotaModel.objeto.OPERACAO = 'VENDA_FUTURA_AUTORIZAR') or (lPermissaoRemotaModel.objeto.OPERACAO = 'VENDA_NEGATIVA')) then
    begin
      lPermissaoRemotaModel.objeto.WhereView := ' and permissao_remota.tabela = ''WEB_PEDIDOITENS'' '+
                                         ' and permissao_remota.pedido_id = '+lPermissaoRemotaModel.objeto.PEDIDO_ID +
                                         ' and coalesce(permissao_remota.status, '''') = ''''';
      lPermissaoRemotaModel.objeto.obterLista;

      if lPermissaoRemotaModel.objeto.TotalRecords = 0 then
        lWebPedidoModel.objeto.Autorizar(lPermissaoRemotaModel.objeto.PEDIDO_ID);

    end;

    Result := true;

  finally
    lPermissaoRemotaModel:=nil;
    lWebPedidoModel:=nil;
  end;
end;

function TPermissaoRemotaModel.Negar(pID: String): Boolean;
var
  lPermissaoRemotaModel : ITPermissaoRemotaModel;
  lWebPedidoModel       : ITWebPedidoModel;
  lConfiguracoes        : ITerasoftConfiguracoes;
  lTablePermissao       : IFDDataset;
begin
  if pID = '' then
    CriaException('ID não informado');

  lPermissaoRemotaModel := TPermissaoRemotaModel.getNewIface(vIConexao);
  lWebPedidoModel       := TWebPedidoModel.getNewIface(vIConexao);

  try
    lPermissaoRemotaModel := lPermissaoRemotaModel.objeto.carregaClasse(pID);

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    if not lConfiguracoes.objeto.verificaPerfil(lPermissaoRemotaModel.objeto.OPERACAO) then
      CriaException('Usuário sem permissão para autorizar essa solicitação.');

    lPermissaoRemotaModel.objeto.Acao := tacExcluir;
    lPermissaoRemotaModel.objeto.Salvar;

    if (lPermissaoRemotaModel.objeto.TABELA = 'WEB_PEDIDOITENS') and
       ((lPermissaoRemotaModel.objeto.OPERACAO = 'VENDA_FUTURA_AUTORIZAR') or (lPermissaoRemotaModel.objeto.OPERACAO = 'VENDA_NEGATIVA')) then
    begin
      lPermissaoRemotaModel.objeto.WhereView := ' and permissao_remota.tabela = ''WEB_PEDIDOITENS'' '+
                                         ' and permissao_remota.pedido_id = '+lPermissaoRemotaModel.objeto.PEDIDO_ID;

      lTablePermissao := lPermissaoRemotaModel.objeto.obterLista;

      lTablePermissao.objeto.First;
      while not lTablePermissao.objeto.eof do
      begin
        lPermissaoRemotaModel.objeto.Excluir(lTablePermissao.objeto.FieldByName('ID').AsString);
        lTablePermissao.objeto.Next;
      end;

      lWebPedidoModel.objeto.Negar(lPermissaoRemotaModel.objeto.PEDIDO_ID);
    end;

    Result := true;

  finally
    lPermissaoRemotaModel:=nil;
    lWebPedidoModel:=nil;
  end;

end;

function TPermissaoRemotaModel.carregaClasse(pId : String): ITPermissaoRemotaModel;
var
  lPermissaoRemotaDao: ITPermissaoRemotaDao;
begin
  lPermissaoRemotaDao := TPermissaoRemotaDao.getNewIface(vIConexao);

  try
    Result := lPermissaoRemotaDao.objeto.carregaClasse(pId);
  finally
    lPermissaoRemotaDao:=nil;
  end;
end;

constructor TPermissaoRemotaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPermissaoRemotaModel.Destroy;
begin
  inherited;
end;

function TPermissaoRemotaModel.obterLista: IFDDataset;
var
  lPermissaoRemotaLista: ITPermissaoRemotaDao;
begin
  lPermissaoRemotaLista := TPermissaoRemotaDao.getNewIface(vIConexao);

  try
    lPermissaoRemotaLista.objeto.TotalRecords    := FTotalRecords;
    lPermissaoRemotaLista.objeto.WhereView       := FWhereView;
    lPermissaoRemotaLista.objeto.CountView       := FCountView;
    lPermissaoRemotaLista.objeto.OrderView       := FOrderView;
    lPermissaoRemotaLista.objeto.StartRecordView := FStartRecordView;
    lPermissaoRemotaLista.objeto.LengthPageView  := FLengthPageView;
    lPermissaoRemotaLista.objeto.IDRecordView    := FIDRecordView;

    Result := lPermissaoRemotaLista.objeto.obterLista;

    FTotalRecords := lPermissaoRemotaLista.objeto.TotalRecords;

  finally
    lPermissaoRemotaLista:=nil;
  end;
end;

function TPermissaoRemotaModel.Salvar: String;
var
  lPermissaoRemotaDao: ITPermissaoRemotaDao;
begin
  lPermissaoRemotaDao := TPermissaoRemotaDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPermissaoRemotaDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lPermissaoRemotaDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lPermissaoRemotaDao.objeto.excluir(mySelf);
    end;
  finally
    lPermissaoRemotaDao:=nil;
  end;
end;

procedure TPermissaoRemotaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPermissaoRemotaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPermissaoRemotaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPermissaoRemotaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPermissaoRemotaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPermissaoRemotaModel.SetMSG_SOLICITACAO(const Value: Variant);
begin
  FMSG_SOLICITACAO := Value;
end;

procedure TPermissaoRemotaModel.SetOPERACAO(const Value: Variant);
begin
  FOPERACAO := Value;
end;

procedure TPermissaoRemotaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TPermissaoRemotaModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TPermissaoRemotaModel.SetREGISTRO_ID(const Value: Variant);
begin
  FREGISTRO_ID := Value;
end;

procedure TPermissaoRemotaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TPermissaoRemotaModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TPermissaoRemotaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPermissaoRemotaModel.SetTABELA(const Value: Variant);
begin
  FTABELA := Value;
end;

procedure TPermissaoRemotaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TPermissaoRemotaModel.SetUSUARIO_CEDENTE(const Value: Variant);
begin
  FUSUARIO_CEDENTE := Value;
end;

procedure TPermissaoRemotaModel.SetUSUARIO_SOLICITANTE(const Value: Variant);
begin
  FUSUARIO_SOLICITANTE := Value;
end;

procedure TPermissaoRemotaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
