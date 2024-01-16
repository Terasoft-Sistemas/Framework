unit PrecoVendaProdutoDao;

interface

uses
  PrecoVendaProdutoModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants;

type
  TPrecoVendaProdutoDao = class

  private
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

    function montaCondicaoQuery: String;
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create;
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

    function incluir(APrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
    function alterar(APrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
    function excluir(APrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
	
    procedure obterLista;

end;

implementation

{ TPrecoVendaProduto }

uses VariaveisGlobais;

constructor TPrecoVendaProdutoDao.Create;
begin

end;

destructor TPrecoVendaProdutoDao.Destroy;
begin

  inherited;
end;

function TPrecoVendaProdutoDao.incluir(APrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

end;

function TPrecoVendaProdutoDao.alterar(APrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

end;

function TPrecoVendaProdutoDao.excluir(APrecoVendaProdutoModel: TPrecoVendaProdutoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := xConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from preco_venda_produto where ID = :ID',[APrecoVendaProdutoModel.ID]);
   lQry.ExecSQL;
   Result := APrecoVendaProdutoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPrecoVendaProdutoDao.montaCondicaoQuery: String;
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
    lQry := xConexao.CriarQuery;

    lSql := 'select count(*) records From preco_venda_produto where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

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
  lQry := xConexao.CriarQuery;

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

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPrecoVendaProdutosLista.Add(TPrecoVendaProdutoModel.Create);

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
