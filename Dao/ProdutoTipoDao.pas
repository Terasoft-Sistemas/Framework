unit ProdutoTipoDao;

interface

uses

  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.FuncoesTexto,
  System.Generics.Collections,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  ProdutoTipoModel;

type
  TProdutoTipoDao = class;
  ITProdutoTipoDao = IObject<TProdutoTipoDao>;

  TProdutoTipoDao = class
  private
    [weak] mySelf: ITProdutoTipoDao;
    vIConexao : IConexao;

    vConstrutor : TConstrutorDao;

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

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITProdutoTipoDao;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pProdutoTipoModel: ITProdutoTipoModel): String;
    function alterar(pProdutoTipoModel: ITProdutoTipoModel): String;
    function excluir(pProdutoTipoModel: ITProdutoTipoModel): String;
    function carregaClasse(pID : String): ITProdutoTipoModel;

    procedure setParams(var pQry: TFDQuery; pProdutoTipoModel: ITProdutoTipoModel);
    function ObterLista: IFDDataset; overload;

end;

implementation

uses
  Data.DB, System.Rtti;

{ TPCG }

function TProdutoTipoDao.carregaClasse(pID: String): ITProdutoTipoModel;
var
  lQry: TFDQuery;
  lModel: ITProdutoTipoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TProdutoTipoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PRODUTO_TIPO where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID           := lQry.FieldByName('ID').AsString;
    lModel.objeto.NOME    	  	:= lQry.FieldByName('NOME').AsString;
    lModel.objeto.USA_PECA     := lQry.FieldByName('USA_PECA').AsString;
	  lModel.objeto.COTACAO      := lQry.FieldByName('COTACAO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TProdutoTipoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TProdutoTipoDao.Destroy;
begin
  inherited;
end;


function TProdutoTipoDao.incluir(pProdutoTipoModel: ITProdutoTipoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PRODUTO_TIPO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pProdutoTipoModel.objeto.ID := vIConexao.Generetor('GEN_PRODUTO_TIPO');
    setParams(lQry, pProdutoTipoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TProdutoTipoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := 'select '+lPaginacao+' * from PRODUTO_TIPO where 1=1 ';
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

function TProdutoTipoDao.alterar(pProdutoTipoModel: ITProdutoTipoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PRODUTO_TIPO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pProdutoTipoModel);
    lQry.ExecSQL;

    Result := pProdutoTipoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TProdutoTipoDao.excluir(pProdutoTipoModel: ITProdutoTipoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from PRODUTO_TIPO where ID = :ID' ,[pProdutoTipoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pProdutoTipoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TProdutoTipoDao.getNewIface(pIConexao: IConexao): ITProdutoTipoDao;
begin
  Result := TImplObjetoOwner<TProdutoTipoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TProdutoTipoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TProdutoTipoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From PRODUTO_TIPO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;


procedure TProdutoTipoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TProdutoTipoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TProdutoTipoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TProdutoTipoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TProdutoTipoDao.setParams(var pQry: TFDQuery; pProdutoTipoModel: ITProdutoTipoModel);
begin
  vConstrutor.setParams('PRODUTO_TIPO',pQry,pProdutoTipoModel.objeto);
end;

procedure TProdutoTipoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TProdutoTipoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TProdutoTipoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;


end.
