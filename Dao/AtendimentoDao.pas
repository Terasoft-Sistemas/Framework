unit AtendimentoDao;

interface

uses
  AtendimentoModel,
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
  TAtendimentoDao = class

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

    function incluir(pAtendimentoModel: TAtendimentoModel): String;
    function alterar(pAtendimentoModel: TAtendimentoModel): String;
    function excluir(pAtendimentoModel: TAtendimentoModel): String;

    procedure setParams(var pQry : TFDQuery; pAtendimentoModel: TAtendimentoModel);

    function ObterLista: IFDDataset;
end;

implementation

{ TAtendimento }

constructor TAtendimentoDao.Create(pIConexao : IConexao);
begin
  vIConexao      := pIConexao;
  vConstrutorDao := TConstrutorDao.Create(vIConexao);
end;

destructor TAtendimentoDao.Destroy;
begin
  vConstrutorDao.Free;
  inherited;
end;

function TAtendimentoDao.incluir(pAtendimentoModel: TAtendimentoModel): String;
var
  lQry    : TFDQuery;
  lSQL    : String;
begin
  lQry    := vIConexao.CriarQuery;

  try
    lSQL := vConstrutorDao.gerarInsert('ATENDIMENTO', 'ID');

    lQry.SQL.Add(lSQL);
    setParams(lQry, pAtendimentoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lQry.Free;
  end;
end;

function TAtendimentoDao.alterar(pAtendimentoModel: TAtendimentoModel): String;
var
  lQry      : TFDQuery;
  lSQL      : String;
begin
  lQry      := vIConexao.CriarQuery;

  lSQL := vConstrutorDao.gerarUpdate('ATENDIMENTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pAtendimentoModel);
    lQry.ExecSQL;

    Result := pAtendimentoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TAtendimentoDao.excluir(pAtendimentoModel: TAtendimentoModel): String;
var
  lQry     : TFDQuery;
begin
  lQry     := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from atendimento where ID = :ID',[pAtendimentoModel.ID]);
   lQry.ExecSQL;

   Result := pAtendimentoModel.ID;
  finally
    lQry.Free;
  end;
end;

function TAtendimentoDao.where: String;
var
  lSQL: String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and atendimento.id = '+IntToStr(FIDRecordView);

  Result := lSql;
end;

procedure TAtendimentoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := '   select count(*) records                                                           '+SLineBreak+
            '     from atendimento                                                                '+SLineBreak+
            '    inner join clientes on clientes.codigo_cli = atendimento.cliente                 '+SLineBreak+
            '    inner join usuario atendente on atendente.id = atendimento.usuario               '+SLineBreak+
            '    inner join usuario responsavel on responsavel.id = atendimento.responsavel       '+SLineBreak+
            ' where 1=1 ';

    lSQL := lSQL + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TAtendimentoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := 'first ' + LengthPageView + ' SKIP ' + StartRecordView;

    lSQL := '   select '+lPaginacao+' Atendimento.*,                                                               '+SLineBreak+
            '          clientes.fantasia_cli clientes_fantasia,                                                    '+SLineBreak+
            '          atendente.nome atendente_nome,                                                              '+SLineBreak+
            '          responsavel.nome responsavel_nome,                                                          '+SLineBreak+
            '          case                                                                                        '+SLineBreak+
            '            when atendimento.status = ''A'' then ''Aberto''                                           '+SLineBreak+
            '            when atendimento.status = ''C'' then ''Acompanhamento''                                   '+SLineBreak+
            '            when atendimento.status = ''E'' then ''Andamento''                                        '+SLineBreak+
            '            when atendimento.status = ''T'' then ''Teste''                                            '+SLineBreak+
            '          end status_extenso                                                                          '+SLineBreak+
            '     from Atendimento                                                                                 '+SLineBreak+
            '    inner join clientes on clientes.codigo_cli = atendimento.cliente                                  '+SLineBreak+
            '    inner join usuario atendente on atendente.id = atendimento.usuario                                '+SLineBreak+
            '    inner join usuario responsavel on responsavel.id = atendimento.responsavel                        '+SLineBreak+
            '    where 1=1';

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

procedure TAtendimentoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAtendimentoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAtendimentoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAtendimentoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAtendimentoDao.setParams(var pQry: TFDQuery; pAtendimentoModel: TAtendimentoModel);
var
  lCtx  : TRttiContext;
  lProp : TRttiProperty;
  i     : Integer;
begin
  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TAtendimentoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pAtendimentoModel).AsString = '', Unassigned, lProp.GetValue(pAtendimentoModel).AsString);
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TAtendimentoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAtendimentoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAtendimentoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
