unit PrecoVendaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TPrecoVendaModel = class

  private
    vIConexao : IConexao;
    FPrecoVendasLista: TObjectList<TPrecoVendaModel>;
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
    procedure SetPrecoVendasLista(const Value: TObjectList<TPrecoVendaModel>);
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

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;

    property PrecoVendasLista: TObjectList<TPrecoVendaModel> read FPrecoVendasLista write SetPrecoVendasLista;
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

constructor TPrecoVendaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPrecoVendaModel.Destroy;
begin

  inherited;
end;

procedure TPrecoVendaModel.obterLista;
var
  lPrecoVendaLista: TPrecoVendaDao;
begin
  lPrecoVendaLista := TPrecoVendaDao.Create(vIConexao);

  try
    lPrecoVendaLista.TotalRecords    := FTotalRecords;
    lPrecoVendaLista.WhereView       := FWhereView;
    lPrecoVendaLista.CountView       := FCountView;
    lPrecoVendaLista.OrderView       := FOrderView;
    lPrecoVendaLista.StartRecordView := FStartRecordView;
    lPrecoVendaLista.LengthPageView  := FLengthPageView;
    lPrecoVendaLista.IDRecordView    := FIDRecordView;

    lPrecoVendaLista.obterLista;

    FTotalRecords  := lPrecoVendaLista.TotalRecords;
    FPrecoVendasLista := lPrecoVendaLista.PrecoVendasLista;

  finally
    lPrecoVendaLista.Free;
  end;
end;

function TPrecoVendaModel.Salvar: String;
var
  lPrecoVendaDao: TPrecoVendaDao;
begin
  lPrecoVendaDao := TPrecoVendaDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPrecoVendaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lPrecoVendaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lPrecoVendaDao.excluir(Self);
    end;

  finally
    lPrecoVendaDao.Free;
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

procedure TPrecoVendaModel.SetPrecoVendasLista(const Value: TObjectList<TPrecoVendaModel>);
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
