unit GrupoComissaoDao;

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
  Spring.Collections,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  GrupoComissaoModel;

type
  TGrupoComissaoDao = class;
  ITGrupoComissaoDao=IObject<TGrupoComissaoDao>;

  TGrupoComissaoDao = class
  private
    [weak] mySelf: ITGrupoComissaoDao;
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

    class function getNewIface(pIConexao: IConexao): ITGrupoComissaoDao;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pGrupoComissaoModel: ITGrupoComissaoModel): String;
    function alterar(pGrupoComissaoModel: ITGrupoComissaoModel): String;
    function excluir(pGrupoComissaoModel: ITGrupoComissaoModel): String;
    function carregaClasse(pID : String): ITGrupoComissaoModel;

    procedure setParams(var pQry: TFDQuery; pGrupoComissaoModel: ITGrupoComissaoModel);
    function ObterLista: IFDDataset; overload;
    function ObterGrupoComissaoProduto(pProduto: String) : Double;

end;

implementation

uses
  Data.DB, System.Rtti;

{ TPCG }

function TGrupoComissaoDao.carregaClasse(pID: String): ITGrupoComissaoModel;
var
  lQry: TFDQuery;
  lModel: ITGrupoComissaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TGrupoComissaoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from GRUPO_COMISSAO where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID       		:= lQry.FieldByName('ID').AsString;
    lModel.objeto.NOME    			:= lQry.FieldByName('NOME').AsString;
    lModel.objeto.PERCENTUAL   := lQry.FieldByName('PERCENTUAL').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TGrupoComissaoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TGrupoComissaoDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TGrupoComissaoDao.incluir(pGrupoComissaoModel: ITGrupoComissaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('GRUPO_COMISSAO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pGrupoComissaoModel.objeto.ID := vIConexao.Generetor('GEN_GRUPO_COMISSAO');
    setParams(lQry, pGrupoComissaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoComissaoDao.ObterGrupoComissaoProduto(pProduto: String): Double;
var
  lQry       : TFDQuery;
  lSQL       : String;
begin
  lQry       := vIConexao.CriarQuery;
  try
    lSQL := 'select coalesce(g.percentual, 0) as percentual             '+sLineBreak+
            '  from produto p                                           '+sLineBreak+
            '  left join grupo_comissao g on g.id = p.grupo_comissao_id '+sLineBreak+
            ' where p.codigo_pro = ' +QuotedStr(pProduto);

    lQry.Open(lSQL);

    Result := StrToFloat( lQry.FieldByName('PERCENTUAL').AsString);
  finally
    lQry.Free;
  end;
end;

function TGrupoComissaoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := 'select '+lPaginacao+' * from GRUPO_COMISSAO where 1=1 ';
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

function TGrupoComissaoDao.alterar(pGrupoComissaoModel: ITGrupoComissaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('GRUPO_COMISSAO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoComissaoModel);
    lQry.ExecSQL;

    Result := pGrupoComissaoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoComissaoDao.excluir(pGrupoComissaoModel: ITGrupoComissaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from GRUPO_COMISSAO where ID = :ID' ,[pGrupoComissaoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pGrupoComissaoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TGrupoComissaoDao.getNewIface(pIConexao: IConexao): ITGrupoComissaoDao;
begin
  Result := TImplObjetoOwner<TGrupoComissaoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TGrupoComissaoDao.where: String;
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

procedure TGrupoComissaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From GRUPO_COMISSAO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;


procedure TGrupoComissaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoComissaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoComissaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoComissaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TGrupoComissaoDao.setParams(var pQry: TFDQuery; pGrupoComissaoModel: ITGrupoComissaoModel);
begin
  vConstrutor.setParams('GRUPO_COMISSAO',pQry,pGrupoComissaoModel.objeto);
end;

procedure TGrupoComissaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TGrupoComissaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TGrupoComissaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;


end.
