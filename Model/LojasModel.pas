unit LojasModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao, FireDAC.Comp.Client;

type
  TLojasModel = class

  private
    vIConexao : IConexao;
    FLojassLista: TObjectList<TLojasModel>;
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
    procedure SetLojassLista(const Value: TObjectList<TLojasModel>);
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

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;
    procedure obterHosts;
    function obterFiliais: TFDMemTable;

    property LojassLista: TObjectList<TLojasModel> read FLojassLista write SetLojassLista;
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

constructor TLojasModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TLojasModel.Destroy;
begin

  inherited;
end;

function TLojasModel.obterFiliais: TFDMemTable;
var
  lLojasDao : TLojasDao;
begin
  lLojasDao := TLojasDao.Create(vIConexao);
  try
    lLojasDao.LojaView  := FLojaView;
    lLojasDao.WhereView := FWhereView;
    Result := lLojasDao.obterFiliais;
  finally
    lLojasDao.Free;
  end;
end;

procedure TLojasModel.obterHosts;
var
  lLojasLista: TLojasDao;
begin
  lLojasLista := TLojasDao.Create(vIConexao);

  try
    lLojasLista.TotalRecords    := FTotalRecords;
    lLojasLista.WhereView       := FWhereView;
    lLojasLista.CountView       := FCountView;
    lLojasLista.OrderView       := FOrderView;
    lLojasLista.StartRecordView := FStartRecordView;
    lLojasLista.LengthPageView  := FLengthPageView;
    lLojasLista.IDRecordView    := FIDRecordView;
    lLojasLista.LojaView        := FLojaView;

    lLojasLista.obterHosts;

    FTotalRecords  := lLojasLista.TotalRecords;
    FLojassLista := lLojasLista.LojassLista;

  finally
    lLojasLista.Free;
  end;
end;

procedure TLojasModel.obterLista;
var
  lLojasLista: TLojasDao;
begin
  lLojasLista := TLojasDao.Create(vIConexao);

  try
    lLojasLista.TotalRecords    := FTotalRecords;
    lLojasLista.WhereView       := FWhereView;
    lLojasLista.CountView       := FCountView;
    lLojasLista.OrderView       := FOrderView;
    lLojasLista.StartRecordView := FStartRecordView;
    lLojasLista.LengthPageView  := FLengthPageView;
    lLojasLista.IDRecordView    := FIDRecordView;
    lLojasLista.LojaView        := FLojaView;

    lLojasLista.obterLista;

    FTotalRecords  := lLojasLista.TotalRecords;
    FLojassLista := lLojasLista.LojassLista;

  finally
    lLojasLista.Free;
  end;
end;

function TLojasModel.Salvar: String;
var
  lLojasDao: TLojasDao;
begin
  lLojasDao := TLojasDao.Create(vIConexao);

  Result := '';

  try
  finally
    lLojasDao.Free;
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

procedure TLojasModel.SetLojassLista(const Value: TObjectList<TLojasModel>);
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
