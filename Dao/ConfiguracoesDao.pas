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
  Spring.Collections,
  Interfaces.Conexao;

type
  TConfiguracoesDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FConfiguracoessLista: IList<TConfiguracoesModel>;
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
    procedure SetConfiguracoessLista(const Value: IList<TConfiguracoesModel>);
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

    property ConfiguracoessLista: IList<TConfiguracoesModel> read FConfiguracoessLista write SetConfiguracoessLista;
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
  FConfiguracoessLista := nil;
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
  modelo: TConfiguracoesModel;
begin
  lQry := vIConexao.CriarQuery;

  FConfiguracoessLista := TCollections.CreateList<TConfiguracoesModel>(true);

  try
    lSQL := ' select  *                '+
	          '   from configuracoes     '+
            '  where 1=1               ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TConfiguracoesModel.Create(vIConexao);
      FConfiguracoessLista.Add(modelo);
      modelo.ID             := lQry.FieldByName('ID').AsString;
      modelo.TAG            := lQry.FieldByName('TAG').AsString;
      modelo.F_ID           := lQry.FieldByName('FID').AsString;
      modelo.PERFIL_ID      := lQry.FieldByName('PERFIL_ID').AsString;
      modelo.VALORINTEIRO   := lQry.FieldByName('VALORINTEIRO').AsString;
      modelo.VALORSTRING    := lQry.FieldByName('VALORSTRING').AsString;
      modelo.VALORMEMO      := lQry.FieldByName('VALORMEMO').AsString;
      modelo.VALORNUMERICO  := lQry.FieldByName('VALORNUMERICO').AsString;
      modelo.VALORCHAR      := lQry.FieldByName('VALORCHAR').AsString;
      modelo.VALORDATA      := lQry.FieldByName('VALORDATA').AsString;
      modelo.VALORHORA      := lQry.FieldByName('VALORHORA').AsString;
      modelo.VALORDATAHORA  := lQry.FieldByName('VALORDATAHORA').AsString;
      modelo.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;
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

procedure TConfiguracoesDao.SetConfiguracoessLista;
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
