unit ConfiguracoesDao;

interface

uses
  ConfiguracoesModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TConfiguracoesDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FConfiguracoessLista: TObjectList<TConfiguracoesModel>;
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
    procedure SetConfiguracoessLista(const Value: TObjectList<TConfiguracoesModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao : Iconexao);
    destructor Destroy; override;

    property ConfiguracoessLista: TObjectList<TConfiguracoesModel> read FConfiguracoessLista write SetConfiguracoessLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AConfiguracoesModel: TConfiguracoesModel): String;
    function alterar(AConfiguracoesModel: TConfiguracoesModel): String;
    function excluir(AConfiguracoesModel: TConfiguracoesModel): String;

    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pConfiguracoesModel: TConfiguracoesModel);

end;

implementation

uses
  System.Rtti;

{ TConfiguracoes }

constructor TConfiguracoesDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TConfiguracoesDao.Destroy;
begin
  freeAndNil(FConfiguracoessLista);
  freeAndNil(vConstrutor);
  vIConexao   := nil;
  inherited;
end;

function TConfiguracoesDao.incluir(AConfiguracoesModel: TConfiguracoesModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONFIGURACOES','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AConfiguracoesModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TConfiguracoesDao.alterar(AConfiguracoesModel: TConfiguracoesModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CONFIGURACOES','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AConfiguracoesModel);
    lQry.ExecSQL;

    Result := AConfiguracoesModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TConfiguracoesDao.excluir(AConfiguracoesModel: TConfiguracoesModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from configuracoes where ID = :ID',[AConfiguracoesModel.ID]);
   lQry.ExecSQL;
   Result := AConfiguracoesModel.ID;

  finally
    lQry.Free;
  end;
end;

function TConfiguracoesDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and configuracoes.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TConfiguracoesDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From configuracoes where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TConfiguracoesDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i : Integer;
begin
  lQry := vIConexao.CriarQuery;

  FConfiguracoessLista := TObjectList<TConfiguracoesModel>.Create;

  try
    lSQL := ' select  *                '+
	          '   from configuracoes     '+
            '  where 1=1               ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FConfiguracoessLista.Add(TConfiguracoesModel.Create(vIConexao));
      i := FConfiguracoessLista.Count -1;
      FConfiguracoessLista[i].ID             := lQry.FieldByName('ID').AsString;
      FConfiguracoessLista[i].TAG            := lQry.FieldByName('TAG').AsString;
      FConfiguracoessLista[i].F_ID           := lQry.FieldByName('FID').AsString;
      FConfiguracoessLista[i].PERFIL_ID      := lQry.FieldByName('PERFIL_ID').AsString;
      FConfiguracoessLista[i].VALORINTEIRO   := lQry.FieldByName('VALORINTEIRO').AsString;
      FConfiguracoessLista[i].VALORSTRING    := lQry.FieldByName('VALORSTRING').AsString;
      FConfiguracoessLista[i].VALORMEMO      := lQry.FieldByName('VALORMEMO').AsString;
      FConfiguracoessLista[i].VALORNUMERICO  := lQry.FieldByName('VALORNUMERICO').AsString;
      FConfiguracoessLista[i].VALORCHAR      := lQry.FieldByName('VALORCHAR').AsString;
      FConfiguracoessLista[i].VALORDATA      := lQry.FieldByName('VALORDATA').AsString;
      FConfiguracoessLista[i].VALORHORA      := lQry.FieldByName('VALORHORA').AsString;
      FConfiguracoessLista[i].VALORDATAHORA  := lQry.FieldByName('VALORDATAHORA').AsString;
      FConfiguracoessLista[i].SYSTIME        := lQry.FieldByName('SYSTIME').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TConfiguracoesDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TConfiguracoesDao.SetConfiguracoessLista(const Value: TObjectList<TConfiguracoesModel>);
begin
  FConfiguracoessLista := Value;
end;

procedure TConfiguracoesDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TConfiguracoesDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TConfiguracoesDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TConfiguracoesDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TConfiguracoesDao.setParams(var pQry: TFDQuery; pConfiguracoesModel: TConfiguracoesModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONFIGURACOES');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TConfiguracoesModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pConfiguracoesModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pConfiguracoesModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TConfiguracoesDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TConfiguracoesDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TConfiguracoesDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
