unit ConsultaModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Interfaces.Conexao;

type
  TConsultaModel = class

  private
    vIConexao : IConexao;
    FConsultasLista: IList<TConsultaModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FDESCRICAO: Variant;
    FCODIGO: Variant;
    FTabelaView: String;
    FDescricaoView: String;
    FCodigoView: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetConsultasLista(const Value: IList<TConsultaModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO(const Value: Variant);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetTabelaView(const Value: String);
    procedure SetCodigoView(const Value: String);
    procedure SetDescricaoView(const Value: String);
  public
    property CODIGO: Variant read FCODIGO write SetCODIGO;
    property DESCRICAO: Variant read FDESCRICAO write SetDESCRICAO;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    procedure obterLista;

    property ConsultasLista: IList<TConsultaModel> read FConsultasLista write SetConsultasLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property TabelaView: String read FTabelaView write SetTabelaView;
    property CodigoView: String read FCodigoView write SetCodigoView;
    property DescricaoView: String read FDescricaoView write SetDescricaoView;

  end;

implementation

uses
  ConsultaDao;

{ TConsultaModel }

constructor TConsultaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TConsultaModel.Destroy;
begin
  FConsultasLista := nil;
  vIConexao := nil;
  inherited;
end;

procedure TConsultaModel.obterLista;
var
  lConsultaLista: TConsultaDao;
begin
  lConsultaLista := TConsultaDao.Create(vIConexao);

  try
    lConsultaLista.TotalRecords     := FTotalRecords;
    lConsultaLista.WhereView        := FWhereView;
    lConsultaLista.CountView        := FCountView;
    lConsultaLista.OrderView        := FOrderView;
    lConsultaLista.StartRecordView  := FStartRecordView;
    lConsultaLista.LengthPageView   := FLengthPageView;
    lConsultaLista.IDRecordView     := FIDRecordView;
    lConsultaLista.TabelaView       := FTabelaView;
    lConsultaLista.CodigoView       := FCodigoView;
    lConsultaLista.DescricaoView    := FDescricaoView;

    lConsultaLista.obterLista;

    FTotalRecords  := lConsultaLista.TotalRecords;
    FConsultasLista := lConsultaLista.ConsultasLista;

  finally
    lConsultaLista.Free;
  end;
end;

procedure TConsultaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TConsultaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TConsultaModel.SetCODIGO(const Value: Variant);
begin
  FCODIGO := Value;
end;

procedure TConsultaModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TConsultaModel.SetCodigoView(const Value: String);
begin
  FCodigoView := Value;
end;

procedure TConsultaModel.SetDescricaoView(const Value: String);
begin
  FDescricaoView := Value;
end;

procedure TConsultaModel.SetConsultasLista;
begin
  FConsultasLista := Value;
end;

procedure TConsultaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TConsultaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TConsultaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TConsultaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TConsultaModel.SetTabelaView(const Value: String);
begin
  FTabelaView := Value;
end;

procedure TConsultaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TConsultaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
