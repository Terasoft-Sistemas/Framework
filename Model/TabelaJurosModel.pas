unit TabelaJurosModel;

interface

uses
  Terasoft.Enumerado,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TTabelaJurosModel = class

  private
    vIConexao : IConexao;
    FTabelaJurossLista: TObjectList<TTabelaJurosModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPERCENTUAL: Variant;
    FPORTADOR_ID: Variant;
    FINDCE: Variant;
    FCODIGO: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FINDCEENT: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetTabelaJurossLista(const Value: TObjectList<TTabelaJurosModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetINDCE(const Value: Variant);
    procedure SetINDCEENT(const Value: Variant);
    procedure SetPERCENTUAL(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
  public
    property CODIGO: Variant read FCODIGO write SetCODIGO;
    property INDCE: Variant read FINDCE write SetINDCE;
    property INDCEENT: Variant read FINDCEENT write SetINDCEENT;
    property ID: Variant read FID write SetID;
    property PERCENTUAL: Variant read FPERCENTUAL write SetPERCENTUAL;
    property PORTADOR_ID: Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;
    function carregaClasse(pId: Integer): TTabelaJurosModel;

    property TabelaJurossLista: TObjectList<TTabelaJurosModel> read FTabelaJurossLista write SetTabelaJurossLista;
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
  TabelaJurosDao;

{ TTabelaJurosModel }

function TTabelaJurosModel.carregaClasse(pId: Integer): TTabelaJurosModel;
var
  lTabelaJurosDao: TTabelaJurosDao;
begin
  lTabelaJurosDao := TTabelaJurosDao.Create;

  try
    Result := lTabelaJurosDao.carregaClasse(pId);
  finally
    lTabelaJurosDao.Free;
  end;
end;

constructor TTabelaJurosModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTabelaJurosModel.Destroy;
begin

  inherited;
end;

procedure TTabelaJurosModel.obterLista;
var
  lTabelaJurosLista: TTabelaJurosDao;
begin
  lTabelaJurosLista := TTabelaJurosDao.Create;

  try
    lTabelaJurosLista.TotalRecords    := FTotalRecords;
    lTabelaJurosLista.WhereView       := FWhereView;
    lTabelaJurosLista.CountView       := FCountView;
    lTabelaJurosLista.OrderView       := FOrderView;
    lTabelaJurosLista.StartRecordView := FStartRecordView;
    lTabelaJurosLista.LengthPageView  := FLengthPageView;
    lTabelaJurosLista.IDRecordView    := FIDRecordView;

    lTabelaJurosLista.obterLista;

    FTotalRecords  := lTabelaJurosLista.TotalRecords;
    FTabelaJurossLista := lTabelaJurosLista.TabelaJurossLista;

  finally
    lTabelaJurosLista.Free;
  end;
end;

function TTabelaJurosModel.Salvar: String;
var
  lTabelaJurosDao: TTabelaJurosDao;
begin
  lTabelaJurosDao := TTabelaJurosDao.Create;

  Result := '';

  try
    case FAcao of
      Terasoft.Enumerado.tacIncluir: Result := lTabelaJurosDao.incluir(Self);
      Terasoft.Enumerado.tacAlterar: Result := lTabelaJurosDao.alterar(Self);
      Terasoft.Enumerado.tacExcluir: Result := lTabelaJurosDao.excluir(Self);
    end;

  finally
    lTabelaJurosDao.Free;
  end;
end;

procedure TTabelaJurosModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TTabelaJurosModel.SetCODIGO(const Value: Variant);
begin
  FCODIGO := Value;
end;

procedure TTabelaJurosModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosModel.SetTabelaJurossLista(const Value: TObjectList<TTabelaJurosModel>);
begin
  FTabelaJurossLista := Value;
end;

procedure TTabelaJurosModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosModel.SetINDCE(const Value: Variant);
begin
  FINDCE := Value;
end;

procedure TTabelaJurosModel.SetINDCEENT(const Value: Variant);
begin
  FINDCEENT := Value;
end;

procedure TTabelaJurosModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTabelaJurosModel.SetPERCENTUAL(const Value: Variant);
begin
  FPERCENTUAL := Value;
end;

procedure TTabelaJurosModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TTabelaJurosModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTabelaJurosModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TTabelaJurosModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTabelaJurosModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
