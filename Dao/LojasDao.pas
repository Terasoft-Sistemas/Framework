unit LojasDao;

interface

uses
  LojasModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TLojasDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FLojassLista: TObjectList<TLojasModel>;
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
    procedure SetLojassLista(const Value: TObjectList<TLojasModel>);
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
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property LojassLista: TObjectList<TLojasModel> read FLojassLista write SetLojassLista;
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
    function obterFiliais: TFDMemTable;

end;

implementation

{ TLojas }

constructor TLojasDao.Create(pIConexao: IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TLojasDao.Destroy;
begin

  inherited;
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

function TLojasDao.obterFiliais: TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FLojassLista := TObjectList<TLojasModel>.Create;

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

    lSQL := lSQL + ' order by 1';

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

procedure TLojasDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FLojassLista := TObjectList<TLojasModel>.Create;

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

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FLojassLista.Add(TLojasModel.Create(vIConexao));

      i := FLojassLista.Count -1;

      FLojassLista[i].CD           := lQry.FieldByName('CD').AsString;
      FLojassLista[i].LOJA         := lQry.FieldByName('LOJA').AsString;
      FLojassLista[i].DESCRICAO    := lQry.FieldByName('DESCRICAO').AsString;
      FLojassLista[i].SERVER       := lQry.FieldByName('SERVER').AsString;
      FLojassLista[i].PORT         := lQry.FieldByName('PORT').AsString;
      FLojassLista[i].DATABASE     := lQry.FieldByName('DATABASE').AsString;
      FLojassLista[i].CLIENTE_ID   := lQry.FieldByName('CLIENTE_ID').AsString;

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

procedure TLojasDao.SetLojassLista(const Value: TObjectList<TLojasModel>);
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
