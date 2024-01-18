unit PrecoVendaProdutoDao;

interface

uses
  PrecoVendaProdutoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao;

type
  TPrecoVendaProdutoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPrecoVendaProdutosLista: TObjectList<TPrecoVendaProdutoModel>;
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
    procedure SetPrecoVendaProdutosLista(const Value: TObjectList<TPrecoVendaProdutoModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPrecoVendaProdutoModel: TPrecoVendaProdutoModel);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property PrecoVendaProdutosLista: TObjectList<TPrecoVendaProdutoModel> read FPrecoVendaProdutosLista write SetPrecoVendaProdutosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pPrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
    function alterar(pPrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
    function excluir(pPrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
	
    procedure obterLista;

end;

implementation

{ TPrecoVendaProduto }

constructor TPrecoVendaProdutoDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPrecoVendaProdutoDao.Destroy;
begin

  inherited;
end;

function TPrecoVendaProdutoDao.incluir(pPrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PRECO_VENDA_PRODUTO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('ID').Value := vIConexao.Generetor('GEN_PRECOVENDAPRODUTO');
    setParams(lQry, pPrecoVendaProdutoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPrecoVendaProdutoDao.alterar(pPrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PRECO_VENDA_PRODUTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('ID').Value := ifThen(pPrecoVendaProdutoModel.ID = '', Unassigned, pPrecoVendaProdutoModel.ID);
    setParams(lQry, pPrecoVendaProdutoModel);
    lQry.ExecSQL;

    Result := pPrecoVendaProdutoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPrecoVendaProdutoDao.excluir(pPrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from preco_venda_produto where ID = :ID',[pPrecoVendaProdutoModel.ID]);
   lQry.ExecSQL;
   Result := pPrecoVendaProdutoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPrecoVendaProdutoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and preco_venda_produto.id = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TPrecoVendaProdutoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From preco_venda_produto where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPrecoVendaProdutoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPrecoVendaProdutosLista := TObjectList<TPrecoVendaProdutoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
    '       preco_venda_produto.*        '+
	  '  from preco_venda_produto          '+
    ' where 1=1                          ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPrecoVendaProdutosLista.Add(TPrecoVendaProdutoModel.Create(vIConexao));

      i := FPrecoVendaProdutosLista.Count -1;

      FPrecoVendaProdutosLista[i].ID             := lQry.FieldByName('ID').AsString;
      FPrecoVendaProdutosLista[i].PRECO_VENDA_ID := lQry.FieldByName('PRECO_VENDA_ID').AsString;
      FPrecoVendaProdutosLista[i].PRODUTO_ID     := lQry.FieldByName('PRODUTO_ID').AsString;
      FPrecoVendaProdutosLista[i].VALOR_VENDA    := lQry.FieldByName('VALOR_VENDA').AsString;
      FPrecoVendaProdutosLista[i].SYSTIME        := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPrecoVendaProdutoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPrecoVendaProdutoDao.SetPrecoVendaProdutosLista(const Value: TObjectList<TPrecoVendaProdutoModel>);
begin
  FPrecoVendaProdutosLista := Value;
end;

procedure TPrecoVendaProdutoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPrecoVendaProdutoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPrecoVendaProdutoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPrecoVendaProdutoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoVendaProdutoDao.setParams(var pQry: TFDQuery; pPrecoVendaProdutoModel: TPrecoVendaProdutoModel);
begin
  pQry.ParamByName('PRECO_VENDA_ID').Value  := ifThen(pPrecoVendaProdutoModel.PRECO_VENDA_ID  = '', Unassigned, pPrecoVendaProdutoModel.PRECO_VENDA_ID);
  pQry.ParamByName('PRODUTO_ID').Value      := ifThen(pPrecoVendaProdutoModel.PRODUTO_ID      = '', Unassigned, pPrecoVendaProdutoModel.PRODUTO_ID);
  pQry.ParamByName('VALOR_VENDA').Value     := ifThen(pPrecoVendaProdutoModel.VALOR_VENDA     = '', Unassigned, pPrecoVendaProdutoModel.VALOR_VENDA);
end;

procedure TPrecoVendaProdutoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPrecoVendaProdutoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPrecoVendaProdutoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
