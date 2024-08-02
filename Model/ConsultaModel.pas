unit ConsultaModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TConsultaModel = class;
  ITConsultaModel=IObject<TConsultaModel>;

  TConsultaModel = class
  private
    [weak] mySelf: ITConsultaModel;
    vIConexao : IConexao;
    FConsultasLista: IList<ITConsultaModel>;
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
    procedure SetConsultasLista(const Value: IList<ITConsultaModel>);
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

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITConsultaModel;

    procedure obterLista;

    property ConsultasLista: IList<ITConsultaModel> read FConsultasLista write SetConsultasLista;
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

constructor TConsultaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TConsultaModel.Destroy;
begin
  FConsultasLista := nil;
  vIConexao := nil;
  inherited;
end;

class function TConsultaModel.getNewIface(pIConexao: IConexao): ITConsultaModel;
begin
  Result := TImplObjetoOwner<TConsultaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TConsultaModel.obterLista;
var
  lConsultaLista: ITConsultaDao;
begin
  lConsultaLista := TConsultaDao.getNewIface(vIConexao);

  try
    lConsultaLista.objeto.TotalRecords     := FTotalRecords;
    lConsultaLista.objeto.WhereView        := FWhereView;
    lConsultaLista.objeto.CountView        := FCountView;
    lConsultaLista.objeto.OrderView        := FOrderView;
    lConsultaLista.objeto.StartRecordView  := FStartRecordView;
    lConsultaLista.objeto.LengthPageView   := FLengthPageView;
    lConsultaLista.objeto.IDRecordView     := FIDRecordView;
    lConsultaLista.objeto.TabelaView       := FTabelaView;
    lConsultaLista.objeto.CodigoView       := FCodigoView;
    lConsultaLista.objeto.DescricaoView    := FDescricaoView;

    lConsultaLista.objeto.obterLista;

    FTotalRecords  := lConsultaLista.objeto.TotalRecords;
    FConsultasLista := lConsultaLista.objeto.ConsultasLista;

  finally
    lConsultaLista:=nil;
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
