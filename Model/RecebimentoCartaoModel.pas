unit RecebimentoCartaoModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TRecebimentoCartaoModel = class;
  ITRecebimentoCartaoModel=IObject<TRecebimentoCartaoModel>;

  TRecebimentoCartaoModel = class
  private
    [unsafe] mySelf: ITRecebimentoCartaoModel;
    vIConexao : IConexao;
    FRecebimentoCartaosLista: IList<ITRecebimentoCartaoModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVALOR: Variant;
    FVENCIMENTO: Variant;
    FCLIENTE_ID: Variant;
    FID: Variant;
    FFATURA: Variant;
    FSYSTIME: Variant;
    FBANDEIRA_ID: Variant;
    FDATA_HORA: Variant;
    FTEF_ID: Variant;
    FUSUARIO_ID: Variant;
    FPARCELA: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetRecebimentoCartaosLista(const Value: IList<ITRecebimentoCartaoModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetBANDEIRA_ID(const Value: Variant);
    procedure SetCLIENTE_ID(const Value: Variant);
    procedure SetDATA_HORA(const Value: Variant);
    procedure SetFATURA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetPARCELA(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTEF_ID(const Value: Variant);
    procedure SetUSUARIO_ID(const Value: Variant);
    procedure SetVALOR(const Value: Variant);
    procedure SetVENCIMENTO(const Value: Variant);
  public
    property ID: Variant read FID write SetID;
    property USUARIO_ID: Variant read FUSUARIO_ID write SetUSUARIO_ID;
    property DATA_HORA: Variant read FDATA_HORA write SetDATA_HORA;
    property CLIENTE_ID: Variant read FCLIENTE_ID write SetCLIENTE_ID;
    property FATURA: Variant read FFATURA write SetFATURA;
    property PARCELA: Variant read FPARCELA write SetPARCELA;
    property VALOR: Variant read FVALOR write SetVALOR;
    property BANDEIRA_ID: Variant read FBANDEIRA_ID write SetBANDEIRA_ID;
    property VENCIMENTO: Variant read FVENCIMENTO write SetVENCIMENTO;
    property TEF_ID: Variant read FTEF_ID write SetTEF_ID;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITRecebimentoCartaoModel;

    function carregaClasse(pID: String): ITRecebimentoCartaoModel;
    function Salvar: String;
    procedure obterLista;

    property RecebimentoCartaosLista: IList<ITRecebimentoCartaoModel> read FRecebimentoCartaosLista write SetRecebimentoCartaosLista;
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
  RecebimentoCartaoDao;

{ TRecebimentoCartaoModel }

function TRecebimentoCartaoModel.carregaClasse(pID: String): ITRecebimentoCartaoModel;
var
  lRecebimentoCartaoDao : ITRecebimentoCartaoDao;
begin
  lRecebimentoCartaoDao := TRecebimentoCartaoDao.getNewIface(vIConexao);
  try
    Result := lRecebimentoCartaoDao.objeto.carregaClasse(pID);
  finally
    lRecebimentoCartaoDao:=nil;
  end;
end;

constructor TRecebimentoCartaoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TRecebimentoCartaoModel.Destroy;
begin
  FRecebimentoCartaosLista := nil;
  vIConexao := nil;
  inherited;
end;

class function TRecebimentoCartaoModel.getNewIface(
  pIConexao: IConexao): ITRecebimentoCartaoModel;
begin
  Result := TImplObjetoOwner<TRecebimentoCartaoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TRecebimentoCartaoModel.obterLista;
var
  lRecebimentoCartaoLista: ITRecebimentoCartaoDao;
begin
  lRecebimentoCartaoLista := TRecebimentoCartaoDao.getNewIface(vIConexao);

  try
    lRecebimentoCartaoLista.objeto.TotalRecords    := FTotalRecords;
    lRecebimentoCartaoLista.objeto.WhereView       := FWhereView;
    lRecebimentoCartaoLista.objeto.CountView       := FCountView;
    lRecebimentoCartaoLista.objeto.OrderView       := FOrderView;
    lRecebimentoCartaoLista.objeto.StartRecordView := FStartRecordView;
    lRecebimentoCartaoLista.objeto.LengthPageView  := FLengthPageView;
    lRecebimentoCartaoLista.objeto.IDRecordView    := FIDRecordView;

    lRecebimentoCartaoLista.objeto.obterLista;

    FTotalRecords  := lRecebimentoCartaoLista.objeto.TotalRecords;
    FRecebimentoCartaosLista := lRecebimentoCartaoLista.objeto.RecebimentoCartaosLista;

  finally
    lRecebimentoCartaoLista:=nil;
  end;
end;

function TRecebimentoCartaoModel.Salvar: String;
var
  lRecebimentoCartaoDao: ITRecebimentoCartaoDao;
begin
  lRecebimentoCartaoDao := TRecebimentoCartaoDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lRecebimentoCartaoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lRecebimentoCartaoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lRecebimentoCartaoDao.objeto.excluir(mySelf);
    end;

  finally
    lRecebimentoCartaoDao:=nil;
  end;
end;

procedure TRecebimentoCartaoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TRecebimentoCartaoModel.SetBANDEIRA_ID(const Value: Variant);
begin
  FBANDEIRA_ID := Value;
end;

procedure TRecebimentoCartaoModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TRecebimentoCartaoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TRecebimentoCartaoModel.SetDATA_HORA(const Value: Variant);
begin
  FDATA_HORA := Value;
end;

procedure TRecebimentoCartaoModel.SetFATURA(const Value: Variant);
begin
  FFATURA := Value;
end;

procedure TRecebimentoCartaoModel.SetRecebimentoCartaosLista;
begin
  FRecebimentoCartaosLista := Value;
end;

procedure TRecebimentoCartaoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TRecebimentoCartaoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TRecebimentoCartaoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TRecebimentoCartaoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TRecebimentoCartaoModel.SetPARCELA(const Value: Variant);
begin
  FPARCELA := Value;
end;

procedure TRecebimentoCartaoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TRecebimentoCartaoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TRecebimentoCartaoModel.SetTEF_ID(const Value: Variant);
begin
  FTEF_ID := Value;
end;

procedure TRecebimentoCartaoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TRecebimentoCartaoModel.SetUSUARIO_ID(const Value: Variant);
begin
  FUSUARIO_ID := Value;
end;

procedure TRecebimentoCartaoModel.SetVALOR(const Value: Variant);
begin
  FVALOR := Value;
end;

procedure TRecebimentoCartaoModel.SetVENCIMENTO(const Value: Variant);
begin
  FVENCIMENTO := Value;
end;

procedure TRecebimentoCartaoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
