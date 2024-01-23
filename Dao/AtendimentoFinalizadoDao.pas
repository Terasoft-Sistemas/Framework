unit AtendimentoFinalizadoDao;

interface

uses
  AtendimentoFinalizadoModel,
  Conexao,
  SistemaControl,
  Terasoft.Utils,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  ServerController,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Rtti;

type
  TAtendimentoFinalizadoDao = class

  private
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;

    var
      vConstrutorDao : TConstrutorDao;

  public
    constructor Create;
    destructor Destroy; override;

    property TotalRecords      : Integer      read FTotalRecords        write SetTotalRecords;
    property IDRecordView      : Integer      read FIDRecordView        write SetIDRecordView;
    property WhereView         : String       read FWhereView           write SetWhereView;
    property CountView         : String       read FCountView           write SetCountView;
    property OrderView         : String       read FOrderView           write SetOrderView;
    property StartRecordView   : String       read FStartRecordView     write SetStartRecordView;
    property LengthPageView    : String       read FLengthPageView      write SetLengthPageView;

    function incluir(pAtendimentoFinalizadoModel: TAtendimentoFinalizadoModel): String;
    function alterar(pAtendimentoFinalizadoModel: TAtendimentoFinalizadoModel): String;
    function excluir(pAtendimentoFinalizadoModel: TAtendimentoFinalizadoModel): String;

    procedure setParams(var pQry : TFDQuery; pAtendimentoFinalizadoModel: TAtendimentoFinalizadoModel);

    function ObterLista: TFDMemTable;
end;

implementation

{ TAtendimentoFinalizado }

constructor TAtendimentoFinalizadoDao.Create;
begin
  vConstrutorDao := TConstrutorDao.Create(Controller.xConexao);
end;

destructor TAtendimentoFinalizadoDao.Destroy;
begin
  vConstrutorDao.Free;
  inherited;
end;

function TAtendimentoFinalizadoDao.incluir(pAtendimentoFinalizadoModel: TAtendimentoFinalizadoModel): String;
var
  lQry          : TFDQuery;
  lSQL          : String;
  lConexao      : TConexao;
begin
  lConexao      := TConexao.Create;
  lQry          := lConexao.CriarQuery;
  try
    lSQL := vConstrutorDao.gerarInsert('ATENDIMENTO_FINALIZADO', 'ID');

    lQry.SQL.Add(lSQL);
    setParams(lQry, pAtendimentoFinalizadoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

function TAtendimentoFinalizadoDao.alterar(pAtendimentoFinalizadoModel: TAtendimentoFinalizadoModel): String;
var
  lQry      : TFDQuery;
  lSQL      : String;
  lConexao  : TConexao;
begin
  lConexao  := TConexao.Create;
  lQry      := lConexao.CriarQuery;

  lSQL := vConstrutorDao.gerarUpdate('ATENDIMENTO_FINALIZADO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pAtendimentoFinalizadoModel);
    lQry.ExecSQL;

    Result := pAtendimentoFinalizadoModel.ID;

  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

function TAtendimentoFinalizadoDao.excluir(pAtendimentoFinalizadoModel: TAtendimentoFinalizadoModel): String;
var
  lQry     : TFDQuery;
  lConexao : TConexao;
begin
  lConexao := TConexao.Create;
  lQry     := lConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ATENDIMENTO_FINALIZADO where ID = :ID',[pAtendimentoFinalizadoModel.ID]);
   lQry.ExecSQL;

   Result := pAtendimentoFinalizadoModel.ID;
  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

function TAtendimentoFinalizadoDao.where: String;
var
  lSQL: String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ATENDIMENTO_FINALIZADO.id = '+IntToStr(FIDRecordView);

  Result := lSql;
end;

procedure TAtendimentoFinalizadoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
  lConexao: TConexao;
begin
  try
    lConexao := TConexao.Create;
    lQry := lConexao.CriarQuery;

    lSql := 'select count(*) records From ATENDIMENTO_FINALIZADO where 1=1 ';

    lSQL := lSQL + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

function TAtendimentoFinalizadoDao.ObterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lConexao   : TConexao;
begin
  lConexao   := TConexao.Create;
  lQry       := lConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSQL := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView + ' * From ATENDIMENTO_FINALIZADO where 1=1 '
    else
      lSQL := 'select * From ATENDIMENTO_FINALIZADO where 1=1 ';

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutorDao.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

procedure TAtendimentoFinalizadoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAtendimentoFinalizadoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAtendimentoFinalizadoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAtendimentoFinalizadoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAtendimentoFinalizadoDao.setParams(var pQry: TFDQuery; pAtendimentoFinalizadoModel: TAtendimentoFinalizadoModel);
var
  lCtx  : TRttiContext;
  lProp : TRttiProperty;
  i     : Integer;
begin
  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TAtendimentoFinalizadoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pAtendimentoFinalizadoModel).AsString = '', Unassigned, lProp.GetValue(pAtendimentoFinalizadoModel).AsString);
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TAtendimentoFinalizadoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAtendimentoFinalizadoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAtendimentoFinalizadoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
