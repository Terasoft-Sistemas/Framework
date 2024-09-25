unit PrecoVendaModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TPrecoVendaModel = class;
  ITPrecoVendaModel=IObject<TPrecoVendaModel>;

  TPrecoVendaModel = class
  private
    [unsafe] mySelf: ITPrecoVendaModel;
    vIConexao : IConexao;
    FPrecoVendasLista: IList<ITPrecoVendaModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPERCENTUAL: Variant;
    FTIPO_CUSTO: Variant;
    FID: Variant;
    FCONDICOES: Variant;
    FSTATUS: Variant;
    FSYSTIME: Variant;
    FPRODUTOS_IGNORAR: Variant;
    FACRESCIMO_DESCONTO: Variant;
    FNOME: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPrecoVendasLista(const Value: IList<ITPrecoVendaModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetACRESCIMO_DESCONTO(const Value: Variant);
    procedure SetCONDICOES(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetPERCENTUAL(const Value: Variant);
    procedure SetPRODUTOS_IGNORAR(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO_CUSTO(const Value: Variant);
  public
    property ID: Variant read FID write SetID;
    property NOME: Variant read FNOME write SetNOME;
    property ACRESCIMO_DESCONTO: Variant read FACRESCIMO_DESCONTO write SetACRESCIMO_DESCONTO;
    property PERCENTUAL: Variant read FPERCENTUAL write SetPERCENTUAL;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property TIPO_CUSTO: Variant read FTIPO_CUSTO write SetTIPO_CUSTO;
    property CONDICOES: Variant read FCONDICOES write SetCONDICOES;
    property PRODUTOS_IGNORAR: Variant read FPRODUTOS_IGNORAR write SetPRODUTOS_IGNORAR;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPrecoVendaModel;

    function Incluir: String;
    function Alterar(pID : String) : ITPrecoVendaModel;
    function Excluir(pID : String) : String;
    function carregaClasse(pID : String) : ITPrecoVendaModel;
    function Salvar: String;
    procedure obterLista;

    property PrecoVendasLista: IList<ITPrecoVendaModel> read FPrecoVendasLista write SetPrecoVendasLista;
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
  PrecoVendaDao;

{ TPrecoVendaModel }

function TPrecoVendaModel.Alterar(pID: String): ITPrecoVendaModel;
var
  lPrecoVendaModel : ITPrecoVendaModel;
begin
  lPrecoVendaModel := TPrecoVendaModel.getNewIface(vIConexao);
  try
    lPrecoVendaModel      := lPrecoVendaModel.objeto.carregaClasse(pID);
    lPrecoVendaModel.objeto.Acao := tacAlterar;
    Result                := lPrecoVendaModel;
  finally

  end;
end;

function TPrecoVendaModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TPrecoVendaModel.getNewIface(
  pIConexao: IConexao): ITPrecoVendaModel;
begin
  Result := TImplObjetoOwner<TPrecoVendaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPrecoVendaModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TPrecoVendaModel.carregaClasse(pID: String): ITPrecoVendaModel;
var
  lPrecoVendaModel: ITPrecoVendaDao;
begin
  lPrecoVendaModel := TPrecoVendaDao.getNewIface(vIConexao);
  try
    Result := lPrecoVendaModel.objeto.carregaClasse(ID);
  finally
    lPrecoVendaModel:=nil;
  end;
end;

constructor TPrecoVendaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPrecoVendaModel.Destroy;
begin
  FPrecoVendasLista:=nil;
  vIConexao:=nil;
  inherited;
end;

procedure TPrecoVendaModel.obterLista;
var
  lPrecoVendaLista: ITPrecoVendaDao;
begin
  lPrecoVendaLista := TPrecoVendaDao.getNewIface(vIConexao);

  try
    lPrecoVendaLista.objeto.TotalRecords    := FTotalRecords;
    lPrecoVendaLista.objeto.WhereView       := FWhereView;
    lPrecoVendaLista.objeto.CountView       := FCountView;
    lPrecoVendaLista.objeto.OrderView       := FOrderView;
    lPrecoVendaLista.objeto.StartRecordView := FStartRecordView;
    lPrecoVendaLista.objeto.LengthPageView  := FLengthPageView;
    lPrecoVendaLista.objeto.IDRecordView    := FIDRecordView;

    lPrecoVendaLista.objeto.obterLista;

    FTotalRecords  := lPrecoVendaLista.objeto.TotalRecords;
    FPrecoVendasLista := lPrecoVendaLista.objeto.PrecoVendasLista;

  finally
    lPrecoVendaLista:=nil;
  end;
end;

function TPrecoVendaModel.Salvar: String;
var
  lPrecoVendaDao: ITPrecoVendaDao;
begin
  lPrecoVendaDao := TPrecoVendaDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPrecoVendaDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lPrecoVendaDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lPrecoVendaDao.objeto.excluir(mySelf);
    end;

  finally
    lPrecoVendaDao:=nil;
  end;
end;

procedure TPrecoVendaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPrecoVendaModel.SetACRESCIMO_DESCONTO(const Value: Variant);
begin
  FACRESCIMO_DESCONTO := Value;
end;

procedure TPrecoVendaModel.SetCONDICOES(const Value: Variant);
begin
  FCONDICOES := Value;
end;

procedure TPrecoVendaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPrecoVendaModel.SetPERCENTUAL(const Value: Variant);
begin
  FPERCENTUAL := Value;
end;

procedure TPrecoVendaModel.SetPrecoVendasLista;
begin
  FPrecoVendasLista := Value;
end;

procedure TPrecoVendaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPrecoVendaModel.SetPRODUTOS_IGNORAR(const Value: Variant);
begin
  FPRODUTOS_IGNORAR := Value;
end;

procedure TPrecoVendaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPrecoVendaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPrecoVendaModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TPrecoVendaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoVendaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPrecoVendaModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TPrecoVendaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPrecoVendaModel.SetTIPO_CUSTO(const Value: Variant);
begin
  FTIPO_CUSTO := Value;
end;

procedure TPrecoVendaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPrecoVendaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
