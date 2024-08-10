unit LojasModel;

interface

uses
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  Interfaces.Conexao, FireDAC.Comp.Client;

type
  TLojasModel = class;
  ITLojasModel=IObject<TLojasModel>;

  TLojasModel = class
  private
    [weak] mySelf: ITLojasModel;
    vIConexao : IConexao;
    FLojassLista: IList<ITLojasModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FDESCRICAO: Variant;
    FPORT: Variant;
    FLOJA: Variant;
    FDATABASE: Variant;
    FSERVER: Variant;
    FLojaView: String;
    FCD: Variant;
    FCLIENTE_ID: Variant;
    FSTRING_CONEXAO: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLojassLista(const Value: IList<ITLojasModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetDATABASE(const Value: Variant);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetPORT(const Value: Variant);
    procedure SetSERVER(const Value: Variant);
    procedure SetLojaView(const Value: String);
    procedure SetCD(const Value: Variant);
    procedure SetCLIENTE_ID(const Value: Variant);
    procedure SetSTRING_CONEXAO(const Value: Variant);
  public
    property CD: Variant read FCD write SetCD;
    property LOJA: Variant read FLOJA write SetLOJA;
    property DESCRICAO: Variant read FDESCRICAO write SetDESCRICAO;
    property SERVER: Variant read FSERVER write SetSERVER;
    property PORT: Variant read FPORT write SetPORT;
    property DATABASE: Variant read FDATABASE write SetDATABASE;
    property CLIENTE_ID: Variant read FCLIENTE_ID write SetCLIENTE_ID;
    property STRING_CONEXAO: Variant read FSTRING_CONEXAO write SetSTRING_CONEXAO;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITLojasModel;

    function Salvar: String;
    procedure obterLista;
    procedure obterHosts;
    function obterFiliais: IFDDataset;

    property LojassLista: IList<ITLojasModel> read FLojassLista write SetLojassLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property LojaView: String read FLojaView write SetLojaView;
  end;

implementation

uses
  LojasDao;

{ TLojasModel }

constructor TLojasModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TLojasModel.Destroy;
begin
  FLojassLista := nil;
  vIConexao := nil;
  inherited;
end;

class function TLojasModel.getNewIface(pIConexao: IConexao): ITLojasModel;
begin
  Result := TImplObjetoOwner<TLojasModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TLojasModel.obterFiliais: IFDDataset;
var
  lLojasDao : ITLojasDao;
begin
  lLojasDao := TLojasDao.getNewIface(vIConexao);
  try
    lLojasDao.objeto.LojaView  := FLojaView;
    lLojasDao.objeto.WhereView := FWhereView;
    Result := lLojasDao.objeto.obterFiliais;
  finally
    lLojasDao:=nil;
  end;
end;

procedure TLojasModel.obterHosts;
var
  lLojasLista: ITLojasDao;
begin
  lLojasLista := TLojasDao.getNewIface(vIConexao);

  try
    lLojasLista.objeto.TotalRecords    := FTotalRecords;
    lLojasLista.objeto.WhereView       := FWhereView;
    lLojasLista.objeto.CountView       := FCountView;
    lLojasLista.objeto.OrderView       := FOrderView;
    lLojasLista.objeto.StartRecordView := FStartRecordView;
    lLojasLista.objeto.LengthPageView  := FLengthPageView;
    lLojasLista.objeto.IDRecordView    := FIDRecordView;
    lLojasLista.objeto.LojaView        := FLojaView;

    lLojasLista.objeto.obterHosts;

    FTotalRecords  := lLojasLista.objeto.TotalRecords;
    FLojassLista := lLojasLista.objeto.LojassLista;

  finally
    lLojasLista:=nil;
  end;
end;

procedure TLojasModel.obterLista;
var
  lLojasLista: ITLojasDao;
begin
  lLojasLista := TLojasDao.getNewIface(vIConexao);

  try
    lLojasLista.objeto.TotalRecords    := FTotalRecords;
    lLojasLista.objeto.WhereView       := FWhereView;
    lLojasLista.objeto.CountView       := FCountView;
    lLojasLista.objeto.OrderView       := FOrderView;
    lLojasLista.objeto.StartRecordView := FStartRecordView;
    lLojasLista.objeto.LengthPageView  := FLengthPageView;
    lLojasLista.objeto.IDRecordView    := FIDRecordView;
    lLojasLista.objeto.LojaView        := FLojaView;

    lLojasLista.objeto.obterLista;

    FTotalRecords  := lLojasLista.objeto.TotalRecords;
    FLojassLista := lLojasLista.objeto.LojassLista;

  finally
    lLojasLista:=nil;
  end;
end;

function TLojasModel.Salvar: String;
var
  lLojasDao: ITLojasDao;
begin
  lLojasDao := TLojasDao.getNewIface(vIConexao);

  Result := '';

  try
  finally
    lLojasDao:=nil;
  end;
end;

procedure TLojasModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TLojasModel.SetCD(const Value: Variant);
begin
  FCD := Value;
end;

procedure TLojasModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TLojasModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TLojasModel.SetDATABASE(const Value: Variant);
begin
  FDATABASE := Value;
end;

procedure TLojasModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TLojasModel.SetLojaView(const Value: String);
begin
  FLojaView := Value;
end;

procedure TLojasModel.SetLojassLista;
begin
  FLojassLista := Value;
end;

procedure TLojasModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TLojasModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TLojasModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TLojasModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TLojasModel.SetPORT(const Value: Variant);
begin
  FPORT := Value;
end;

procedure TLojasModel.SetSERVER(const Value: Variant);
begin
  FSERVER := Value;
end;

procedure TLojasModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TLojasModel.SetSTRING_CONEXAO(const Value: Variant);
begin
  FSTRING_CONEXAO := Value;
end;

procedure TLojasModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TLojasModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
