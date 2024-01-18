unit TabelaJurosDao;

interface

uses
  TabelaJurosModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TTabelaJurosDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FTabelaJurossLista: TObjectList<TTabelaJurosModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetTabelaJurossLista(const Value: TObjectList<TTabelaJurosModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property TabelaJurossLista: TObjectList<TTabelaJurosModel> read FTabelaJurossLista write SetTabelaJurossLista;
    property ID: Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    procedure setParams(var pQry: TFDQuery; pTabelaJurosModel: TTabelaJurosModel);

    function incluir(ATabelaJurosModel: TTabelaJurosModel): String;
    function alterar(ATabelaJurosModel: TTabelaJurosModel): String;
    function excluir(ATabelaJurosModel: TTabelaJurosModel): String;
	
    procedure obterLista;
    function carregaClasse(pId: Integer): TTabelaJurosModel;

end;

implementation

{ TTabelaJuros }

function TTabelaJurosDao.carregaClasse(pId: Integer): TTabelaJurosModel;
var
  lQry: TFDQuery;
  lModel: TTabelaJurosModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTabelaJurosModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from tabelajuros where id = '+ IntToStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.CODIGO      := lQry.FieldByName('CODIGO').AsString;
    lModel.INDCE       := lQry.FieldByName('INDCE').AsString;
    lModel.INDCEENT    := lQry.FieldByName('INDCEENT').AsString;
    lModel.ID          := lQry.FieldByName('ID').AsString;
    lModel.PERCENTUAL  := lQry.FieldByName('PERCENTUAL').AsString;
    lModel.PORTADOR_ID := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TTabelaJurosDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TTabelaJurosDao.Destroy;
begin

  inherited;
end;

function TTabelaJurosDao.incluir(ATabelaJurosModel: TTabelaJurosModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := vConstrutor.gerarInsert('TABELAJUROS', 'ID');
    lQry.SQL.Add(lSQL);
    setParams(lQry, ATabelaJurosModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosDao.alterar(ATabelaJurosModel: TTabelaJurosModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('TABELAJUROS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := ifThen(ATabelaJurosModel.ID = '', Unassigned, ATabelaJurosModel.ID);
    setParams(lQry, ATabelaJurosModel);
    lQry.ExecSQL;

    Result := ATabelaJurosModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosDao.excluir(ATabelaJurosModel: TTabelaJurosModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from tabelajuros where ID = :ID',[ATabelaJurosModel.ID]);
   lQry.ExecSQL;
   Result := ATabelaJurosModel.ID;

  finally
    lQry.Free;
  end;
end;

function TTabelaJurosDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and tabelajuros.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TTabelaJurosDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From tabelajuros where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TTabelaJurosDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FTabelaJurossLista := TObjectList<TTabelaJurosModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
    '       tabelajuros.*          '+
	  '  from tabelajuros            '+
    ' where 1=1                    ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FTabelaJurossLista.Add(TTabelaJurosModel.Create(vIConexao));

      i := FTabelaJurossLista.Count -1;

      FTabelaJurossLista[i].CODIGO      := lQry.FieldByName('CODIGO').AsString;
      FTabelaJurossLista[i].INDCE       := lQry.FieldByName('INDCE').AsString;
      FTabelaJurossLista[i].INDCEENT    := lQry.FieldByName('INDCEENT').AsString;
      FTabelaJurossLista[i].ID          := lQry.FieldByName('ID').AsString;
      FTabelaJurossLista[i].PERCENTUAL  := lQry.FieldByName('PERCENTUAL').AsString;
      FTabelaJurossLista[i].PORTADOR_ID := lQry.FieldByName('PORTADOR_ID').AsString;
      FTabelaJurossLista[i].SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TTabelaJurosDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosDao.SetTabelaJurossLista(const Value: TObjectList<TTabelaJurosModel>);
begin
  FTabelaJurossLista := Value;
end;

procedure TTabelaJurosDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTabelaJurosDao.setParams(var pQry: TFDQuery; pTabelaJurosModel: TTabelaJurosModel);
begin
  pQry.ParamByName('codigo').Value      := ifThen(pTabelaJurosModel.CODIGO      = '', Unassigned, pTabelaJurosModel.CODIGO);
  pQry.ParamByName('indce').Value       := ifThen(pTabelaJurosModel.INDCE       = '', Unassigned, pTabelaJurosModel.INDCE);
  pQry.ParamByName('indceent').Value    := ifThen(pTabelaJurosModel.INDCEENT    = '', Unassigned, pTabelaJurosModel.INDCEENT);
  pQry.ParamByName('percentual').Value  := ifThen(pTabelaJurosModel.PERCENTUAL  = '', Unassigned, pTabelaJurosModel.PERCENTUAL);
  pQry.ParamByName('portador_id').Value := ifThen(pTabelaJurosModel.PORTADOR_ID = '', Unassigned, pTabelaJurosModel.PORTADOR_ID);
end;

procedure TTabelaJurosDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTabelaJurosDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTabelaJurosDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
