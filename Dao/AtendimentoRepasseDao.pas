unit AtendimentoRepasseDao;

interface

uses
  AtendimentoRepasseModel,
  Terasoft.Utils,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Rtti,
  Interfaces.Conexao;

type
  TAtendimentoRepasseDao = class

  private
    vIConexao : IConexao;

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
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property TotalRecords      : Integer      read FTotalRecords        write SetTotalRecords;
    property IDRecordView      : Integer      read FIDRecordView        write SetIDRecordView;
    property WhereView         : String       read FWhereView           write SetWhereView;
    property CountView         : String       read FCountView           write SetCountView;
    property OrderView         : String       read FOrderView           write SetOrderView;
    property StartRecordView   : String       read FStartRecordView     write SetStartRecordView;
    property LengthPageView    : String       read FLengthPageView      write SetLengthPageView;

    function incluir(pAtendimentoRepasseModel: TAtendimentoRepasseModel): String;
    function alterar(pAtendimentoRepasseModel: TAtendimentoRepasseModel): String;
    function excluir(pAtendimentoRepasseModel: TAtendimentoRepasseModel): String;

    procedure setParams(var pQry : TFDQuery; pAtendimentoRepasseModel: TAtendimentoRepasseModel);

    function ObterLista: TFDMemTable;
end;

implementation

{ TAtendimentoRepasse }

constructor TAtendimentoRepasseDao.Create(pIConexao : IConexao);
begin
  vIConexao      := pIConexao;
  vConstrutorDao := TConstrutorDao.Create(vIConexao);
end;

destructor TAtendimentoRepasseDao.Destroy;
begin
  vConstrutorDao.Free;
  inherited;
end;

function TAtendimentoRepasseDao.incluir(pAtendimentoRepasseModel: TAtendimentoRepasseModel): String;
var
  lQry   : TFDQuery;
  lSQL   : String;
begin
  lQry   := vIConexao.CriarQuery;

  try
    lSQL := vConstrutorDao.gerarInsert('ATENDIMENTO_REPASSE', 'ID', true);

    lQry.SQL.Add(lSQL);

    pAtendimentoRepasseModel.ID := vIConexao.Generetor('GEN_ATENDIMENTO_REPASSE');
    setParams(lQry, pAtendimentoRepasseModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lQry.Free;
  end;
end;

function TAtendimentoRepasseDao.alterar(pAtendimentoRepasseModel: TAtendimentoRepasseModel): String;
var
  lQry   : TFDQuery;
  lSQL   : String;
begin
  lQry   := vIConexao.CriarQuery;

  lSQL := vConstrutorDao.gerarUpdate('ATENDIMENTO_REPASSE', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pAtendimentoRepasseModel);
    lQry.ParamByName('id').Value := IIF(pAtendimentoRepasseModel.ID = '', Unassigned, pAtendimentoRepasseModel.ID);
    lQry.ExecSQL;

    Result := pAtendimentoRepasseModel.ID;

  finally
    lQry.Free;
  end;
end;

function TAtendimentoRepasseDao.excluir(pAtendimentoRepasseModel: TAtendimentoRepasseModel): String;
var
  lQry  : TFDQuery;
begin
  lQry  := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ATENDIMENTO_REPASSE where ID = :ID',[pAtendimentoRepasseModel.ID]);
   lQry.ExecSQL;

   Result := pAtendimentoRepasseModel.ID;
  finally
    lQry.Free;
  end;
end;

function TAtendimentoRepasseDao.where: String;
var
  lSQL: String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ATENDIMENTO_REPASSE.id = '+IntToStr(FIDRecordView);

  Result := lSql;
end;

procedure TAtendimentoRepasseDao.obterTotalRegistros;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From ATENDIMENTO_REPASSE inner join usuario on usuario.id = atendimento_repasse.usuario_repasse_id  where 1=1 ';

    lSQL := lSQL + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TAtendimentoRepasseDao.ObterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL :=   '  select '+lPaginacao + '                                                         '+SLineBreak+
              '         atendimento_repasse.*,                                                   '+SLineBreak+
              '         usuario.fantasia usuario_nome                                            '+SLineBreak+
              '    from atendimento_repasse                                                      '+SLineBreak+
              '   inner join usuario on usuario.id = atendimento_repasse.usuario_repasse_id      '+SLineBreak+
              '   where 1=1 ';

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutorDao.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TAtendimentoRepasseDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAtendimentoRepasseDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAtendimentoRepasseDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAtendimentoRepasseDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAtendimentoRepasseDao.setParams(var pQry: TFDQuery; pAtendimentoRepasseModel: TAtendimentoRepasseModel);
var
  lCtx  : TRttiContext;
  lProp : TRttiProperty;
  i     : Integer;
begin
  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TAtendimentoRepasseModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pAtendimentoRepasseModel).AsString = '', Unassigned, lProp.GetValue(pAtendimentoRepasseModel).AsString);
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TAtendimentoRepasseDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAtendimentoRepasseDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAtendimentoRepasseDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
