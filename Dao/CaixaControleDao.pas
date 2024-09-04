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
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  Interfaces.Conexao;

type
  TCaixaControleDao = class;
  ITCaixaControleDao=IObject<TCaixaControleDao>;

  TCaixaControleDao = class
  private
    [weak] mySelf: ITCaixaControleDao;
    vIConexao : IConexao;
    vConstrutor : IConstrutorDao;
    FCaixaControlesLista: IList<ITCaixaControleModel>;
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
    procedure SetCaixaControlesLista(const Value: IList<ITCaixaControleModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCaixaControleDao;

    property CaixaControlesLista: IList<ITCaixaControleModel> read FCaixaControlesLista write SetCaixaControlesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(ACaixaControleModel: ITCaixaControleModel): String;
    function alterar(ACaixaControleModel: ITCaixaControleModel): String;
    function excluir(ACaixaControleModel: ITCaixaControleModel): String;

    procedure obterLista;
    procedure ultimosCaixa(pUsuario: String);

    procedure setParams(var pQry: TFDQuery; pCaixaControleModel: ITCaixaControleModel);
    function ultimoCaixa(pUsuario: String): String;
    function dataFechamento(pIdCaixa, pUsuario: String) : String;

    function vendaCaixaFechado(pDataHora: String): boolean;
end;

implementation

uses
  System.Rtti;

{ TCaixaControle }

constructor TCaixaControleDao._Create(pIConexao : IConexao);
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

function TCaixaControleDao.vendaCaixaFechado(pDataHora: String): boolean;
var
  lSql : String;
begin
  lSql := ' select first 1 c.id , cast(c.data+c.hora as timestamp) dataAbertura                    '+
          '   from caixa_ctr c                                                                     '+
          ' where c.status = ''F'' and cast(c.data+c.hora as timestamp)  > ' + QuotedStr(pDataHora) +
          '   and c.usuario = ' + QuotedStr(self.vIConexao.getUSer.ID) + ' order by 2 desc         ';

  Result := vIConexao.getConnection.ExecSQLScalar(lSql);
end;

destructor TCaixaControleDao.Destroy;
begin
  FCaixaControlesLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TCaixaControleDao.incluir(ACaixaControleModel: ITCaixaControleModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CAIXA_CTR','ID', True);

  try
    lQry.SQL.Add(lSQL);
    ACaixaControleModel.objeto.ID := StrToInt(vIConexao.Generetor('GEN_CAIXA_CTR')).ToString;
    setParams(lQry, ACaixaControleModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaControleDao.alterar(ACaixaControleModel: ITCaixaControleModel): String;
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

    Result := ACaixaControleModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaControleDao.excluir(ACaixaControleModel: ITCaixaControleModel): String;
var
  lQry: TFDQuery;

begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from caixa_ctr where ID = :ID',[ACaixaControleModel.objeto.ID]);
   lQry.ExecSQL;
   Result := ACaixaControleModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TCaixaControleDao.getNewIface(pIConexao: IConexao): ITCaixaControleDao;
begin
  Result := TImplObjetoOwner<TCaixaControleDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
  modelo: ITCaixaControleModel;
begin

  lQry := vIConexao.CriarQuery;

  FCaixaControlesLista := TCollections.CreateList<ITCaixaControleModel>;

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

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TCaixaControleModel.getNewIface(vIConexao);
      FCaixaControlesLista.Add(modelo);

      modelo.objeto.ID                := lQry.FieldByName('ID').AsString;
      modelo.objeto.DATA              := lQry.FieldByName('DATA').AsString;
      modelo.objeto.STATUS            := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.USUARIO           := lQry.FieldByName('USUARIO').AsString;
      modelo.objeto.HORA              := lQry.FieldByName('HORA').AsString;
      modelo.objeto.DATA_FECHA        := lQry.FieldByName('DATA_FECHA').AsString;
      modelo.objeto.CONTAGEM_DINHEIRO := lQry.FieldByName('CONTAGEM_DINHEIRO').AsString;
      modelo.objeto.CONTAGEM_CREDITO  := lQry.FieldByName('CONTAGEM_CREDITO').AsString;
      modelo.objeto.CONTAGEM_DEBITO   := lQry.FieldByName('CONTAGEM_DEBITO').AsString;
      modelo.objeto.JUSTIFICATIVA     := lQry.FieldByName('JUSTIFICATIVA').AsString;
      modelo.objeto.SYSTIME           := lQry.FieldByName('SYSTIME').AsString;

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

procedure TCaixaControleDao.SetCaixaControlesLista;
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

procedure TCaixaControleDao.setParams(var pQry: TFDQuery; pCaixaControleModel: ITCaixaControleModel);
begin
  vConstrutor.setParams('CAIXA_CTR',pQry,pCaixaControleModel.objeto);
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
  modelo    : ITCaixaControleModel;

begin

  lQry := vIConexao.CriarQuery;

  FCaixaControlesLista := TCollections.CreateList<ITCaixaControleModel>;

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

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TCaixaControleModel.getNewIface(vIConexao);
      FCaixaControlesLista.Add(modelo);

      modelo.objeto.ID                := lQry.FieldByName('ID').AsString;
      modelo.objeto.DATA              := lQry.FieldByName('DATA').AsString;
      modelo.objeto.HORA              := lQry.FieldByName('HORA').AsString;
      modelo.objeto.DATA_FECHA        := lQry.FieldByName('DATA_FECHA').AsString;
      modelo.objeto.HORA_FECHA        := lQry.FieldByName('HORA_FECHA').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

end.
