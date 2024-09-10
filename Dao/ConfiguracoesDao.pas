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
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  Interfaces.Conexao;

type
  TConfiguracoesDao = class;
  ITConfiguracoesDao=IObject<TConfiguracoesDao>;

  TConfiguracoesDao = class
  private
    [weak] mySelf: ITConfiguracoesDao;
    vIConexao : IConexao;
    vConstrutor : IConstrutorDao;

    FConfiguracoessLista: IList<ITConfiguracoesModel>;
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
    procedure SetConfiguracoessLista(const Value: IList<ITConfiguracoesModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor _Create(pIConexao : Iconexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITConfiguracoesDao;

    property ConfiguracoessLista: IList<ITConfiguracoesModel> read FConfiguracoessLista write SetConfiguracoessLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AConfiguracoesModel: ITConfiguracoesModel): String;
    function alterar(AConfiguracoesModel: ITConfiguracoesModel): String;
    function excluir(AConfiguracoesModel: ITConfiguracoesModel): String;

    function carregaClasse(pID : String): ITConfiguracoesModel;

    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pConfiguracoesModel: ITConfiguracoesModel);

end;

implementation

uses
  Terasoft.Framework.LOG,
  System.Rtti;

{ TConfiguracoes }

constructor TConfiguracoesDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

function TConfiguracoesDao.carregaClasse(pID: String): ITConfiguracoesModel;
var
  lQry: TFDQuery;
  lModel: ITConfiguracoesModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TConfiguracoesModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CONFIGURACOES where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

      lModel.objeto.ID             := lQry.FieldByName('ID').AsString;
      lModel.objeto.TAG            := lQry.FieldByName('TAG').AsString;
      lModel.objeto.F_ID           := lQry.FieldByName('FID').AsString;
      lModel.objeto.PERFIL_ID      := lQry.FieldByName('PERFIL_ID').AsString;
      lModel.objeto.VALORINTEIRO   := lQry.FieldByName('VALORINTEIRO').AsString;
      lModel.objeto.VALORSTRING    := lQry.FieldByName('VALORSTRING').AsString;
      lModel.objeto.VALORMEMO      := lQry.FieldByName('VALORMEMO').AsString;
      lModel.objeto.VALORNUMERICO  := lQry.FieldByName('VALORNUMERICO').AsString;
      lModel.objeto.VALORCHAR      := lQry.FieldByName('VALORCHAR').AsString;
      lModel.objeto.VALORDATA      := lQry.FieldByName('VALORDATA').AsString;
      lModel.objeto.VALORHORA      := lQry.FieldByName('VALORHORA').AsString;
      lModel.objeto.VALORDATAHORA  := lQry.FieldByName('VALORDATAHORA').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

destructor TConfiguracoesDao.Destroy;
begin
  FConfiguracoessLista := nil;
  vConstrutor:=nil;
  vIConexao   := nil;
  inherited;
end;

function TConfiguracoesDao.incluir(AConfiguracoesModel: ITConfiguracoesModel): String;
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

function TConfiguracoesDao.alterar(AConfiguracoesModel: ITConfiguracoesModel): String;
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

    Result := AConfiguracoesModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TConfiguracoesDao.excluir(AConfiguracoesModel: ITConfiguracoesModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from configuracoes where ID = :ID',[AConfiguracoesModel.objeto.ID]);
   lQry.ExecSQL;
   Result := AConfiguracoesModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TConfiguracoesDao.getNewIface(pIConexao: IConexao): ITConfiguracoesDao;
begin
  Result := TImplObjetoOwner<TConfiguracoesDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
    logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TConfiguracoesDao.obterTotalRegistros',LOG_LEVEL_DEBUG);
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
  modelo: ITConfiguracoesModel;
  i: Integer;
begin
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TConfiguracoesDao.obterLista',LOG_LEVEL_DEBUG);
  lQry := vIConexao.CriarQuery;

  FConfiguracoessLista := TCollections.CreateList<ITConfiguracoesModel>;

  try
    lSQL := ' select  *                '+
	          '   from configuracoes     '+
            '  where 1=1               ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    logaByTagSeNivel(TAGLOG_CONDICIONAL, format('TConfiguracoesDao.obterLista: Criando [%d] TConfiguracoesModel',[lQry.RecordCount]),LOG_LEVEL_DEBUG);
    i := 0;
    while not lQry.Eof do
    begin
      inc(i);
      logaByTagSeNivel(TAGLOG_CONDICIONAL, format('TConfiguracoesDao.obterLista: ítem [%d] de [%d]',[i,lQry.RecordCount]),LOG_LEVEL_DEBUG);
      modelo := TConfiguracoesModel.getNewIface(vIConexao);
      FConfiguracoessLista.Add(modelo);
      modelo.objeto.ID             := lQry.FieldByName('ID').AsString;
      modelo.objeto.TAG            := lQry.FieldByName('TAG').AsString;
      modelo.objeto.F_ID           := lQry.FieldByName('FID').AsString;
      modelo.objeto.PERFIL_ID      := lQry.FieldByName('PERFIL_ID').AsString;
      modelo.objeto.VALORINTEIRO   := lQry.FieldByName('VALORINTEIRO').AsString;
      modelo.objeto.VALORSTRING    := lQry.FieldByName('VALORSTRING').AsString;
      modelo.objeto.VALORMEMO      := lQry.FieldByName('VALORMEMO').AsString;
      modelo.objeto.VALORNUMERICO  := lQry.FieldByName('VALORNUMERICO').AsString;
      modelo.objeto.VALORCHAR      := lQry.FieldByName('VALORCHAR').AsString;
      modelo.objeto.VALORDATA      := lQry.FieldByName('VALORDATA').AsString;
      modelo.objeto.VALORHORA      := lQry.FieldByName('VALORHORA').AsString;
      modelo.objeto.VALORDATAHORA  := lQry.FieldByName('VALORDATAHORA').AsString;
      modelo.objeto.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;
      logaByTagSeNivel(TAGLOG_CONDICIONAL, format('TConfiguracoesDao.obterLista: ítem [%d] de [%d]: - Próximo registro',[i,lQry.RecordCount]),LOG_LEVEL_DEBUG);
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TConfiguracoesDao.obterLista: Saindo da procedure',LOG_LEVEL_DEBUG);
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

procedure TConfiguracoesDao.setParams(var pQry: TFDQuery; pConfiguracoesModel: ITConfiguracoesModel);
begin
  vConstrutor.setParams('CONFIGURACOES',pQry,pConfiguracoesModel.objeto);
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
