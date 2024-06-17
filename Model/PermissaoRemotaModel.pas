unit PermissaoRemotaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TPermissaoRemotaModel = class

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

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TPermissaoRemotaModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TPermissaoRemotaModel;
    function obterLista: TFDMemTable;

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
  PermissaoRemotaDao,  
  System.Classes, 
  System.SysUtils;

{ TPermissaoRemotaModel }

function TPermissaoRemotaModel.Alterar(pID: String): TPermissaoRemotaModel;
var
  lPermissaoRemotaModel : TPermissaoRemotaModel;
begin
  lPermissaoRemotaModel := TPermissaoRemotaModel.Create(vIConexao);
  try
    lPermissaoRemotaModel       := lPermissaoRemotaModel.carregaClasse(pID);
    lPermissaoRemotaModel.Acao  := tacAlterar;
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

function TPermissaoRemotaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TPermissaoRemotaModel.carregaClasse(pId : String): TPermissaoRemotaModel;
var
  lPermissaoRemotaDao: TPermissaoRemotaDao;
begin
  lPermissaoRemotaDao := TPermissaoRemotaDao.Create(vIConexao);

  try
    Result := lPermissaoRemotaDao.carregaClasse(pId);
  finally
    lPermissaoRemotaDao.Free;
  end;
end;

constructor TPermissaoRemotaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPermissaoRemotaModel.Destroy;
begin
  inherited;
end;

function TPermissaoRemotaModel.obterLista: TFDMemTable;
var
  lPermissaoRemotaLista: TPermissaoRemotaDao;
begin
  lPermissaoRemotaLista := TPermissaoRemotaDao.Create(vIConexao);

  try
    lPermissaoRemotaLista.TotalRecords    := FTotalRecords;
    lPermissaoRemotaLista.WhereView       := FWhereView;
    lPermissaoRemotaLista.CountView       := FCountView;
    lPermissaoRemotaLista.OrderView       := FOrderView;
    lPermissaoRemotaLista.StartRecordView := FStartRecordView;
    lPermissaoRemotaLista.LengthPageView  := FLengthPageView;
    lPermissaoRemotaLista.IDRecordView    := FIDRecordView;

    Result := lPermissaoRemotaLista.obterLista;

    FTotalRecords := lPermissaoRemotaLista.TotalRecords;

  finally
    lPermissaoRemotaLista.Free;
  end;
end;

function TPermissaoRemotaModel.Salvar: String;
var
  lPermissaoRemotaDao: TPermissaoRemotaDao;
begin
  lPermissaoRemotaDao := TPermissaoRemotaDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPermissaoRemotaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lPermissaoRemotaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lPermissaoRemotaDao.excluir(Self);
    end;
  finally
    lPermissaoRemotaDao.Free;
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
