unit PrecoVendaProdutoDao;
interface
uses
  PrecoVendaProdutoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TPrecoVendaProdutoDao = class;
  ITPrecoVendaProdutoDao=IObject<TPrecoVendaProdutoDao>;

  TPrecoVendaProdutoDao = class
  private
    [weak] mySelf: ITPrecoVendaProdutoDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;
    FPrecoVendaProdutosLista: IList<ITPrecoVendaProdutoModel>;
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
    procedure SetPrecoVendaProdutosLista(const Value: IList<ITPrecoVendaProdutoModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;
    procedure SetIDRecordView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPrecoVendaProdutoModel: ITPrecoVendaProdutoModel);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPrecoVendaProdutoDao;

    property PrecoVendaProdutosLista: IList<ITPrecoVendaProdutoModel> read FPrecoVendaProdutosLista write SetPrecoVendaProdutosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pPrecoVendaProdutoModel: ITPrecoVendaProdutoModel): String;
    function alterar(pPrecoVendaProdutoModel: ITPrecoVendaProdutoModel): String;
    function excluir(pPrecoVendaProdutoModel: ITPrecoVendaProdutoModel): String;
    function carregaClasse(pID : String) : ITPrecoVendaProdutoModel;
	
    procedure obterLista;
end;
implementation

uses
  System.Rtti;
{ TPrecoVendaProduto }
function TPrecoVendaProdutoDao.carregaClasse(pID: String): ITPrecoVendaProdutoModel;
var
  lQry: TFDQuery;
  lModel: ITPrecoVendaProdutoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPrecoVendaProdutoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PRECO_VENDA_PRODUTO where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;
    lModel.objeto.PRECO_VENDA_ID   := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.objeto.PRODUTO_ID       := lQry.FieldByName('PRODUTO_ID').AsString;
    lModel.objeto.VALOR_VENDA      := lQry.FieldByName('VALOR_VENDA').AsString;
    lModel.objeto.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TPrecoVendaProdutoDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPrecoVendaProdutoDao.Destroy;
begin
  FPrecoVendaProdutosLista:=nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TPrecoVendaProdutoDao.incluir(pPrecoVendaProdutoModel: ITPrecoVendaProdutoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PRECO_VENDA_PRODUTO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pPrecoVendaProdutoModel.objeto.ID := vIConexao.Generetor('GEN_PRECOVENDAPRODUTO');
    setParams(lQry, pPrecoVendaProdutoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPrecoVendaProdutoDao.alterar(pPrecoVendaProdutoModel: ITPrecoVendaProdutoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PRECO_VENDA_PRODUTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPrecoVendaProdutoModel);
    lQry.ExecSQL;

    Result := pPrecoVendaProdutoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPrecoVendaProdutoDao.excluir(pPrecoVendaProdutoModel: ITPrecoVendaProdutoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from preco_venda_produto where ID = :ID',[pPrecoVendaProdutoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pPrecoVendaProdutoModel.objeto.ID;
  finally
    lQry.Free;
  end;
end;
class function TPrecoVendaProdutoDao.getNewIface(pIConexao: IConexao): ITPrecoVendaProdutoDao;
begin
  Result := TImplObjetoOwner<TPrecoVendaProdutoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
  modelo: ITPrecoVendaProdutoModel;
begin
  lQry := vIConexao.CriarQuery;
  FPrecoVendaProdutosLista := TCollections.CreateList<ITPrecoVendaProdutoModel>;
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
    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPrecoVendaProdutoModel.getNewIface(vIConexao);
      FPrecoVendaProdutosLista.Add(modelo);
      modelo.objeto.ID             := lQry.FieldByName('ID').AsString;
      modelo.objeto.PRECO_VENDA_ID := lQry.FieldByName('PRECO_VENDA_ID').AsString;
      modelo.objeto.PRODUTO_ID     := lQry.FieldByName('PRODUTO_ID').AsString;
      modelo.objeto.VALOR_VENDA    := lQry.FieldByName('VALOR_VENDA').AsString;
      modelo.objeto.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;
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
procedure TPrecoVendaProdutoDao.SetPrecoVendaProdutosLista;
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

procedure TPrecoVendaProdutoDao.setParams(var pQry: TFDQuery; pPrecoVendaProdutoModel: ITPrecoVendaProdutoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PRECO_VENDA_PRODUTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPrecoVendaProdutoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPrecoVendaProdutoModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPrecoVendaProdutoModel.objeto).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
