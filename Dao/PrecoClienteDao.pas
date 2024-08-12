unit PrecoClienteDao;
interface
uses
  PrecoClienteModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TPrecoClienteDao = class;
  ITPrecoClienteDao=IObject<TPrecoClienteDao>;

  TPrecoClienteDao = class
  private
    [weak] mySelf:ITPrecoClienteDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FPrecoClientesLista: IList<ITPrecoClienteModel>;
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
    procedure SetPrecoClientesLista(const Value: IList<ITPrecoClienteModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPrecoClienteModel: ITPrecoClienteModel);
    function where: String;

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPrecoClienteDao;

    property PrecoClientesLista: IList<ITPrecoClienteModel> read FPrecoClientesLista write SetPrecoClientesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pPrecoClienteModel: ITPrecoClienteModel): String;
    function alterar(pPrecoClienteModel: ITPrecoClienteModel): String;
    function excluir(pPrecoClienteModel: ITPrecoClienteModel): String;
	
    procedure obterLista;
end;
implementation

uses
  System.Rtti;

  { TPrecoCliente }

constructor TPrecoClienteDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPrecoClienteDao.Destroy;
begin
  FPrecoClientesLista:=nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TPrecoClienteDao.incluir(pPrecoClienteModel: ITPrecoClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PRECO_CLIENTE', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPrecoClienteModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPrecoClienteDao.alterar(pPrecoClienteModel: ITPrecoClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarUpdate('PRECO_CLIENTE', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPrecoClienteModel);
    lQry.ExecSQL;
    Result := pPrecoClienteModel.objeto.ID;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPrecoClienteDao.excluir(pPrecoClienteModel: ITPrecoClienteModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from preco_cliente where ID = :ID',[pPrecoClienteModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pPrecoClienteModel.objeto.ID;
  finally
    lQry.Free;
  end;
end;
class function TPrecoClienteDao.getNewIface(pIConexao: IConexao): ITPrecoClienteDao;
begin
  Result := TImplObjetoOwner<TPrecoClienteDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPrecoClienteDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';
  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;
  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and preco_cliente.id = '+IntToStr(FIDRecordView);
  Result := lSQL;
end;
procedure TPrecoClienteDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := 'select count(*) records From preco_cliente where 1=1 ';
    lSql := lSql + where;
    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;
procedure TPrecoClienteDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITPrecoClienteModel;
begin
  lQry := vIConexao.CriarQuery;
  FPrecoClientesLista := TCollections.CreateList<ITPrecoClienteModel>;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';
    lSQL := lSQL +
    '       preco_cliente.*          '+
	  '  from preco_cliente            '+
    ' where 1=1                      ';
    lSql := lSql + where;
    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;
    lQry.Open(lSQL);
    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPrecoClienteModel.getNewIface(vIConexao);
      FPrecoClientesLista.Add(modelo);
      modelo.objeto.PRODUTO := lQry.FieldByName('PRODUTO').AsString;
      modelo.objeto.CLIENTE := lQry.FieldByName('CLIENTE').AsString;
      modelo.objeto.VALOR   := lQry.FieldByName('VALOR').AsString;
      modelo.objeto.ID      := lQry.FieldByName('ID').AsString;
      modelo.objeto.SYSTIME := lQry.FieldByName('SYSTIME').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;
procedure TPrecoClienteDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TPrecoClienteDao.SetPrecoClientesLista;
begin
  FPrecoClientesLista := Value;
end;
procedure TPrecoClienteDao.SetID(const Value: Variant);
begin
  FID := Value;
end;
procedure TPrecoClienteDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;
procedure TPrecoClienteDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;
procedure TPrecoClienteDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoClienteDao.setParams(var pQry: TFDQuery; pPrecoClienteModel: ITPrecoClienteModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PRECO_CLIENTE');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPrecoClienteModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPrecoClienteModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPrecoClienteModel.objeto).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPrecoClienteDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TPrecoClienteDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TPrecoClienteDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
end.
