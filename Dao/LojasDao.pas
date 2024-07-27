unit LojasDao;

interface

uses
  LojasModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TLojasDao = class;
  ITLojasDao=IObject<TLojasDao>;

  TLojasDao = class
  private
    [weak] mySelf:ITLojasDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FLojassLista: IList<ITLojasModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FLojaView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetLojassLista(const Value: IList<ITLojasModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetLojaView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITLojasDao;

    property LojassLista: IList<ITLojasModel> read FLojassLista write SetLojassLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property LojaView: String read FLojaView write SetLojaView;

    procedure obterLista;
    procedure obterHosts;
    function obterFiliais: IFDDataset;

end;

implementation

{ TLojas }

constructor TLojasDao._Create(pIConexao: IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TLojasDao.Destroy;
begin
  FLojassLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

class function TLojasDao.getNewIface(pIConexao: IConexao): ITLojasDao;
begin
  Result := TImplObjetoOwner<TLojasDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TLojasDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if not FLojaView.IsEmpty then
    lSQL := lSQL + 'and loja2.loja = '+ QuotedStr(FLojaView);

  Result := lSQL;
end;

procedure TLojasDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From loja2 where loja2.server is not null ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TLojasDao.obterFiliais: IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITLojasModel;
begin
  lQry := vIConexao.CriarQuery;

  FLojassLista := TCollections.CreateList<ITLojasModel>;

  try
    lSQL := ' select                               ' + sLineBreak +
            '        loja2.cd,                     ' + sLineBreak +
            '        loja2.loja,                   ' + sLineBreak +
            '        loja2.descricao,              ' + sLineBreak +
            '        loja2.server,                 ' + sLineBreak +
            '        loja2.port,                   ' + sLineBreak +
            '        loja2.database,               ' + sLineBreak +
            '        loja2.cliente_id              ' + sLineBreak +
            '   from loja2                         ' + sLineBreak +
            '  where loja2.cliente_id is not null  ' + sLineBreak;

    lSql := lSql + where;

    lSQL := lSQL + ' order by 3';

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

procedure TLojasDao.obterHosts;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITLojasModel;
begin
  lQry := vIConexao.CriarQuery;

  FLojassLista := TCollections.CreateList<ITLojasModel>;

  try
    lSQL := ' select hosts.loja,                          ' + #13+
            '        hosts.string_conexao                 ' + #13+
            '   from loja2                                ' + #13+
            '  inner join hosts on hosts.loja = loja2.loja' + #13;

    lSQL := lSQL + ' order by 1';

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TLojasModel.getNewIface(vIConexao);
      FLojassLista.Add(modelo);

      modelo.objeto.LOJA           := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.STRING_CONEXAO := lQry.FieldByName('STRING_CONEXAO').AsString;

      lQry.Next;
    end;
  finally
    lQry.Free;
  end;
end;

procedure TLojasDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITLojasModel;
begin
  lQry := vIConexao.CriarQuery;

  FLojassLista := TCollections.CreateList<ITLojasModel>;

  try
    lSQL := ' select                           ' + #13 +
            '        loja2.cd,                 ' + #13 +
            '        loja2.loja,               ' + #13 +
            '        loja2.descricao,          ' + #13 +
            '        loja2.server,             ' + #13 +
            '        loja2.port,               ' + #13 +
            '        loja2.database,           ' + #13 +
            '        loja2.cliente_id          ' + #13 +
            '   from loja2                     ' + #13 +
            '  where loja2.server is not null  ' + #13;

    lSql := lSql + where;

    lSQL := lSQL + ' order by 1';

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TLojasModel.getNewIface(vIConexao);
      FLojassLista.Add(modelo);

      modelo.objeto.CD           := lQry.FieldByName('CD').AsString;
      modelo.objeto.LOJA         := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.DESCRICAO    := lQry.FieldByName('DESCRICAO').AsString;
      modelo.objeto.SERVER       := lQry.FieldByName('SERVER').AsString;
      modelo.objeto.PORT         := lQry.FieldByName('PORT').AsString;
      modelo.objeto.DATABASE     := lQry.FieldByName('DATABASE').AsString;
      modelo.objeto.CLIENTE_ID   := lQry.FieldByName('CLIENTE_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TLojasDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TLojasDao.SetLojaView(const Value: String);
begin
  FLojaView := Value;
end;

procedure TLojasDao.SetLojassLista;
begin
  FLojassLista := Value;
end;

procedure TLojasDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TLojasDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TLojasDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TLojasDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TLojasDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TLojasDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TLojasDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
