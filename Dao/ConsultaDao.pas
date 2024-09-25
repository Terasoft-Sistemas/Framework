unit ConsultaDao;

interface

uses
  ConsultaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TConsultaDao = class;
  ITConsultaDao=IObject<TConsultaDao>;

  TConsultaDao = class
  private
    [unsafe] mySelf: ITConsultaDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FConsultasLista: IList<ITConsultaModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FTabelaView: String;
    FDescricaoView: String;
    FCodigoView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetConsultasLista(const Value: IList<ITConsultaModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetTabelaView(const Value: String);
    procedure SetCodigoView(const Value: String);
    procedure SetDescricaoView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITConsultaDao;

    property ConsultasLista: IList<ITConsultaModel> read FConsultasLista write SetConsultasLista;
    property ID :Variant read FID write SetID;
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

    procedure obterLista;

end;

implementation

{ TConsulta }

constructor TConsultaDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TConsultaDao.Destroy;
begin
  FConsultasLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

class function TConsultaDao.getNewIface(pIConexao: IConexao): ITConsultaDao;
begin
  Result := TImplObjetoOwner<TConsultaDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TConsultaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  Result := lSQL;
end;

procedure TConsultaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From '+FTabelaView+' where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TConsultaDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITConsultaModel;
begin
  lQry := vIConexao.CriarQuery;

  FConsultasLista := TCollections.CreateList<ITConsultaModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      FCodigoView           +' CODIGO,      '+
      FDescricaoView        +' DESCRICAO    '+
	    '  from '+FTabelaView +
      ' where 1=1 ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TConsultaModel.getNewIface(vIConexao);
      FConsultasLista.Add(modelo);

      modelo.objeto.CODIGO      := lQry.FieldByName('CODIGO').AsString;
      modelo.objeto.DESCRICAO   := lQry.FieldByName('DESCRICAO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TConsultaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TConsultaDao.SetCodigoView(const Value: String);
begin
  FCodigoView := Value;
end;

procedure TConsultaDao.SetDescricaoView(const Value: String);
begin
  FDescricaoView := Value;
end;

procedure TConsultaDao.SetConsultasLista;
begin
  FConsultasLista := Value;
end;

procedure TConsultaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TConsultaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TConsultaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TConsultaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TConsultaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TConsultaDao.SetTabelaView(const Value: String);
begin
  FTabelaView := Value;
end;

procedure TConsultaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TConsultaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
