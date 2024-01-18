unit PrecoClienteDao;

interface

uses
  PrecoClienteModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TPrecoClienteDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPrecoClientesLista: TObjectList<TPrecoClienteModel>;
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
    procedure SetPrecoClientesLista(const Value: TObjectList<TPrecoClienteModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPrecoClienteModel: TPrecoClienteModel);
    function where: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property PrecoClientesLista: TObjectList<TPrecoClienteModel> read FPrecoClientesLista write SetPrecoClientesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pPrecoClienteModel: TPrecoClienteModel): String;
    function alterar(pPrecoClienteModel: TPrecoClienteModel): String;
    function excluir(pPrecoClienteModel: TPrecoClienteModel): String;
	
    procedure obterLista;

end;

implementation

{ TPrecoCliente }

constructor TPrecoClienteDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPrecoClienteDao.Destroy;
begin

  inherited;
end;

function TPrecoClienteDao.incluir(pPrecoClienteModel: TPrecoClienteModel): String;
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

function TPrecoClienteDao.alterar(pPrecoClienteModel: TPrecoClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('PRECO_CLIENTE', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPrecoClienteModel);
    lQry.ParamByName('id').Value := ifThen(pPrecoClienteModel.ID = '', Unassigned, pPrecoClienteModel.ID);
    lQry.ExecSQL;

    Result := pPrecoClienteModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPrecoClienteDao.excluir(pPrecoClienteModel: TPrecoClienteModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from preco_cliente where ID = :ID',[pPrecoClienteModel.ID]);
   lQry.ExecSQL;
   Result := pPrecoClienteModel.ID;

  finally
    lQry.Free;
  end;
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPrecoClientesLista := TObjectList<TPrecoClienteModel>.Create;

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

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPrecoClientesLista.Add(TPrecoClienteModel.Create(vIConexao));

      i := FPrecoClientesLista.Count -1;

      FPrecoClientesLista[i].PRODUTO := lQry.FieldByName('PRODUTO').AsString;
      FPrecoClientesLista[i].CLIENTE := lQry.FieldByName('CLIENTE').AsString;
      FPrecoClientesLista[i].VALOR   := lQry.FieldByName('VALOR').AsString;
      FPrecoClientesLista[i].ID      := lQry.FieldByName('ID').AsString;
      FPrecoClientesLista[i].SYSTIME := lQry.FieldByName('SYSTIME').AsString;

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

procedure TPrecoClienteDao.SetPrecoClientesLista(const Value: TObjectList<TPrecoClienteModel>);
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

procedure TPrecoClienteDao.setParams(var pQry: TFDQuery; pPrecoClienteModel: TPrecoClienteModel);
begin
  pQry.ParamByName('produto').Value := ifThen(pPrecoClienteModel.PRODUTO = '', Unassigned, pPrecoClienteModel.PRODUTO);
  pQry.ParamByName('cliente').Value := ifThen(pPrecoClienteModel.CLIENTE = '', Unassigned, pPrecoClienteModel.CLIENTE);
  pQry.ParamByName('valor').Value   := ifThen(pPrecoClienteModel.VALOR   = '', Unassigned, pPrecoClienteModel.VALOR);
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
