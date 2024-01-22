unit CaixaControleDao;

interface

uses
  CaixaControleModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TCaixaControleDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;
    FCaixaControlesLista: TObjectList<TCaixaControleModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetCaixaControlesLista(const Value: TObjectList<TCaixaControleModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property CaixaControlesLista: TObjectList<TCaixaControleModel> read FCaixaControlesLista write SetCaixaControlesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(ACaixaControleModel: TCaixaControleModel): String;
    function alterar(ACaixaControleModel: TCaixaControleModel): String;
    function excluir(ACaixaControleModel: TCaixaControleModel): String;

    procedure obterLista;
    procedure ultimosCaixa(pUsuario: String);

    procedure setParams(var pQry: TFDQuery; pCaixaControleModel: TCaixaControleModel);
    function ultimoCaixa(pUsuario: String): String;
    function dataFechamento(pIdCaixa, pUsuario: String) : String;
end;

implementation

uses
  System.Rtti;

{ TCaixaControle }

constructor TCaixaControleDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

function TCaixaControleDao.dataFechamento(pIdCaixa, pUsuario: String): String;
var
  lSql : String;
begin
  lSql := ' select first 1 cast(c.data+c.hora as timestamp) dataAbertura '+
          '   from caixa_ctr c where c.id > ' + pIdCaixa                  +
          '    and c.status  = ''F''                                     '+
          '    and c.usuario = ' + QuotedStr(pUsuario)                    +
          '  order by 1 ';

  Result := vIConexao.getConnection.ExecSQLScalar(lSql);
end;

destructor TCaixaControleDao.Destroy;
begin

  inherited;
end;

function TCaixaControleDao.incluir(ACaixaControleModel: TCaixaControleModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CAIXA_CTR','ID', True);

  try
    lQry.SQL.Add(lSQL);
    ACaixaControleModel.ID := StrToInt(vIConexao.Generetor('GEN_CAIXA_CTR')).ToString;
    setParams(lQry, ACaixaControleModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaControleDao.alterar(ACaixaControleModel: TCaixaControleModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry     := vIConexao.CriarQuery;

  lSQL     := vConstrutor.gerarUpdate('CAIXA_CTR','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACaixaControleModel);
    lQry.ExecSQL;

    Result := ACaixaControleModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaControleDao.excluir(ACaixaControleModel: TCaixaControleModel): String;
var
  lQry: TFDQuery;

begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from caixa_ctr where ID = :ID',[ACaixaControleModel.ID]);
   lQry.ExecSQL;
   Result := ACaixaControleModel.ID;

  finally
    lQry.Free;
  end;
end;

function TCaixaControleDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if not FIDRecordView.IsEmpty then
    lSQL := lSQL + ' and id = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TCaixaControleDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From caixa_ctr where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCaixaControleDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;

begin

  lQry := vIConexao.CriarQuery;

  FCaixaControlesLista := TObjectList<TCaixaControleModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       caixa_ctr.*              '+
	    '  from caixa_ctr                '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCaixaControlesLista.Add(TCaixaControleModel.Create(vIConexao));

      i := FCaixaControlesLista.Count -1;

      FCaixaControlesLista[i].ID                := lQry.FieldByName('ID').AsString;
      FCaixaControlesLista[i].DATA              := lQry.FieldByName('DATA').AsString;
      FCaixaControlesLista[i].STATUS            := lQry.FieldByName('STATUS').AsString;
      FCaixaControlesLista[i].USUARIO           := lQry.FieldByName('USUARIO').AsString;
      FCaixaControlesLista[i].HORA              := lQry.FieldByName('HORA').AsString;
      FCaixaControlesLista[i].DATA_FECHA        := lQry.FieldByName('DATA_FECHA').AsString;
      FCaixaControlesLista[i].CONTAGEM_DINHEIRO := lQry.FieldByName('CONTAGEM_DINHEIRO').AsString;
      FCaixaControlesLista[i].CONTAGEM_CREDITO  := lQry.FieldByName('CONTAGEM_CREDITO').AsString;
      FCaixaControlesLista[i].CONTAGEM_DEBITO   := lQry.FieldByName('CONTAGEM_DEBITO').AsString;
      FCaixaControlesLista[i].JUSTIFICATIVA     := lQry.FieldByName('JUSTIFICATIVA').AsString;
      FCaixaControlesLista[i].SYSTIME           := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCaixaControleDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCaixaControleDao.SetCaixaControlesLista(const Value: TObjectList<TCaixaControleModel>);
begin
  FCaixaControlesLista := Value;
end;

procedure TCaixaControleDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCaixaControleDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TCaixaControleDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCaixaControleDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCaixaControleDao.setParams(var pQry: TFDQuery; pCaixaControleModel: TCaixaControleModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CAIXA_CTR');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TCaixaControleModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pCaixaControleModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pCaixaControleModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TCaixaControleDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCaixaControleDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCaixaControleDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TCaixaControleDao.ultimoCaixa(pUsuario: String): String;
var
  lConexao : TFDConnection;
  lSql     : String;
begin
  lConexao := vIConexao.getConnection;

  lSql := ' select caixa_ctr.id                                                        '+
          '   from caixa_ctr                                                           '+
          '  where caixa_ctr.usuario = ' + QuotedStr(pUsuario)                          +
          '    and caixa_ctr.status = ''I''                                            '+
          '    and cast(caixa_ctr.data+caixa_ctr.hora as timestamp) =                  '+
          '      (select first 1 cast(c.data+c.hora as timestamp) dataAbertura         '+
          '         from caixa_ctr c                                                   '+
          '        where c.status = ''I''                                              '+
          '          and c.usuario = ' + QuotedStr(pUsuario)                            +
          '        order by 1 desc ) ';

  Result := lConexao.ExecSQLScalar(lSql);
end;

procedure TCaixaControleDao.ultimosCaixa(pUsuario: String);
var
  lQry      : TFDQuery;
  lSQL      : String;
  i         : INteger;

begin

  lQry := vIConexao.CriarQuery;

  FCaixaControlesLista := TObjectList<TCaixaControleModel>.Create;

  try
    lSQL := ' select c.id,                                                                    '+
            '        c.data,                                                                  '+
            '        c.hora,                                                                  '+
            '        coalesce(c.data_fecha, ''ABERTO'') data_fecha,                           '+
            '        (select first 1 cf.hora                                                  '+
            '           from caixa_ctr cf                                                     '+
            '          where cf.usuario = '+QuotedStr(pUsuario)                                +
            '            and cf.status = ''F''                                                '+
            '            and cast(cf.id as integer) > cast(c.id as integer)) hora_fecha       '+
            '   from caixa_ctr c                                                              '+
            '  where c.usuario = '+QuotedStr(pUsuario)                                         +
            '    and c.status = ''I''                                                         '+
            '    and c.data = (select first 1 data                                            '+
            '                    from caixa_ctr                                               '+
            '                   where usuario = '+QuotedStr(pUsuario)                          +
            '                     and status = ''I''                                          '+
            '                   order by data desc)                                           '+
            '  order by c.data desc, c.hora desc                                              ';

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCaixaControlesLista.Add(TCaixaControleModel.Create(vIConexao));

      i := FCaixaControlesLista.Count -1;

      FCaixaControlesLista[i].ID                := lQry.FieldByName('ID').AsString;
      FCaixaControlesLista[i].DATA              := lQry.FieldByName('DATA').AsString;
      FCaixaControlesLista[i].HORA              := lQry.FieldByName('HORA').AsString;
      FCaixaControlesLista[i].DATA_FECHA        := lQry.FieldByName('DATA_FECHA').AsString;
      FCaixaControlesLista[i].HORA_FECHA        := lQry.FieldByName('HORA_FECHA').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

end.
