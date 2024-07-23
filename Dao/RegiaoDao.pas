unit RegiaoDao;

interface

uses
  RegiaoModel,
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
  TRegiaoDao = class

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

    function incluir(pRegiaoModel: TRegiaoModel): String;
    function alterar(pRegiaoModel: TRegiaoModel): String;
    function excluir(pRegiaoModel: TRegiaoModel): String;

    procedure setParams(var pQry : TFDQuery; pRegiaoModel: TRegiaoModel);

    function ObterLista: IFDDataset;
end;

implementation

{ TRegiao }

constructor TRegiaoDao.Create(pIConexao : IConexao);
begin
  vIConexao      := pIConexao;
  vConstrutorDao := TConstrutorDao.Create(pIConexao);
end;

destructor TRegiaoDao.Destroy;
begin
  vConstrutorDao.Free;
  inherited;
end;

function TRegiaoDao.incluir(pRegiaoModel: TRegiaoModel): String;
var
  lQry          : TFDQuery;
  lSQL          : String;
begin
  lQry          := vIConexao.CriarQuery;
  try
    lSQL := vConstrutorDao.gerarInsert('REGIAO', 'ID', true);

    lQry.SQL.Add(lSQL);
    pRegiaoModel.ID := vIConexao.Generetor('GEN_REGIAO');
    setParams(lQry, pRegiaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lQry.Free;
  end;
end;

function TRegiaoDao.alterar(pRegiaoModel: TRegiaoModel): String;
var
  lQry      : TFDQuery;
  lSQL      : String;
begin
  lQry      := vIConexao.CriarQuery;

  lSQL := vConstrutorDao.gerarUpdate('REGIAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pRegiaoModel);
    lQry.ExecSQL;

    Result := pRegiaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TRegiaoDao.excluir(pRegiaoModel: TRegiaoModel): String;
var
  lQry     : TFDQuery;
begin
  lQry     := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from REGIAO where ID = :ID',[pRegiaoModel.ID]);
   lQry.ExecSQL;

   Result := pRegiaoModel.ID;
  finally
    lQry.Free;
  end;
end;

function TRegiaoDao.where: String;
var
  lSQL: String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and REGIAO.ID = '+IntToStr(FIDRecordView);

  Result := lSql;
end;

procedure TRegiaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From REGIAO where 1=1 ';

    lSQL := lSQL + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TRegiaoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := 'select '+lPaginacao+' * From REGIAO where 1=1 ';
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

procedure TRegiaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TRegiaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TRegiaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TRegiaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TRegiaoDao.setParams(var pQry: TFDQuery; pRegiaoModel: TRegiaoModel);
var
  lCtx  : TRttiContext;
  lProp : TRttiProperty;
  i     : Integer;
begin
  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TRegiaoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pRegiaoModel).AsString = '', Unassigned, lProp.GetValue(pRegiaoModel).AsString);
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TRegiaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TRegiaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TRegiaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
