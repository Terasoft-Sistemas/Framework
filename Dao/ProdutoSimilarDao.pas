unit ProdutoSimilarDao;

interface

uses
  ProdutoSimilarModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TProdutoSimilarDao = class;
  ITProdutoSimilarDao=IObject<TProdutoSimilarDao>;

  TProdutoSimilarDao = class
  private
    [unsafe] mySelf: ITProdutoSimilarDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

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
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITProdutoSimilarDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pProdutoSimilarModel: ITProdutoSimilarModel): String;
    function alterar(pProdutoSimilarModel: ITProdutoSimilarModel): String;
    function excluir(pProdutoSimilarModel: ITProdutoSimilarModel): String;

    function carregaClasse(pID : String): ITProdutoSimilarModel;
    function obterLista: IFDDataset;
    function ConsultaProdutosSimilar(pProduto: String): IFDDataset;
    function VerificarProduto(pProduto, pSimilar : String) : String;

    procedure setParams(var pQry: TFDQuery; pProdutoSimilarModel: ITProdutoSimilarModel);

end;

implementation

uses
  System.Rtti;

{ TProdutoSimilar }

function TProdutoSimilarDao.carregaClasse(pID : String): ITProdutoSimilarModel;
var
  lQry: TFDQuery;
  lModel: ITProdutoSimilarModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TProdutoSimilarModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PRODUTO_SIMILAR where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                 := lQry.FieldByName('ID').AsString;
    lModel.objeto.PRODUTO_ID         := lQry.FieldByName('PRODUTO_ID').AsString;
	  lModel.objeto.PRODUTO_SIMILAR_ID := lQry.FieldByName('PRODUTO_SIMILAR_ID').AsString;
    lModel.objeto.ACESSORIO          := lQry.FieldByName('ACESSORIO').AsString;
    lModel.objeto.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TProdutoSimilarDao.ConsultaProdutosSimilar(pProduto: String): IFDDataset;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := ' select distinct s.id,                                                                 '+sLineBreak+
            '        s.produto_similar_id as produto_id,                                            '+sLineBreak+
            '        s.produto_similar_id,                                                          '+sLineBreak+
            '        s.acessorio,                                                                   '+sLineBreak+
            '        prod.nome_pro,                                                                 '+sLineBreak+
            '        prod.saldo_pro,                                                                '+sLineBreak+
            '        prod.venda_pro,                                                                '+sLineBreak+
            '        m.nome_mar,                                                                    '+sLineBreak+
            '        prod.codlista_cod,                                                             '+sLineBreak+
            '        prod.localizacao,                                                              '+sLineBreak+
            '        case                                                                           '+sLineBreak+
            '          when s.produto_id = '+QuotedStr(pProduto)+' then ''S''                       '+sLineBreak+
            '          else ''N''                                                                   '+sLineBreak+
            '        end as principal                                                               '+sLineBreak+
            '   from produto_similar s                                                              '+sLineBreak+
            '  inner join produto prod on prod.codigo_pro = s.produto_similar_id                    '+sLineBreak+
            '  inner join marcaproduto m on prod.codigo_mar = m.codigo_mar                          '+sLineBreak+
            '  where s.acessorio is null                                                            '+sLineBreak+
            '    and (s.produto_id = '+QuotedStr(pProduto)+'                                        '+sLineBreak+
            '         or s.produto_similar_id = '+QuotedStr(pProduto)+'                             '+sLineBreak+
            '         or (s.produto_id in ( select s1.produto_id                                    '+sLineBreak+
            '                                 from produto_similar s1                               '+sLineBreak+
            '                                where s1.acessorio is null                             '+sLineBreak+
            '                                  and s1.produto_similar_id = '+QuotedStr(pProduto)+'  '+sLineBreak+
            '                             )                                                         '+sLineBreak+
            '    and s.produto_similar_id <> '+QuotedStr(pProduto)+'                                '+sLineBreak+
            '            )                                                                          '+sLineBreak+
            '        )                                                                              '+sLineBreak;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

constructor TProdutoSimilarDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TProdutoSimilarDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TProdutoSimilarDao.incluir(pProdutoSimilarModel: ITProdutoSimilarModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PRODUTO_SIMILAR', 'ID', true);
  try
    lQry.SQL.Add(lSQL);
    pProdutoSimilarModel.objeto.ID := vIConexao.Generetor('GEN_PRODUTO_SIMILAR');
    setParams(lQry, pProdutoSimilarModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TProdutoSimilarDao.alterar(pProdutoSimilarModel: ITProdutoSimilarModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PRODUTO_SIMILAR','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pProdutoSimilarModel);
    lQry.ExecSQL;

    Result := pProdutoSimilarModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TProdutoSimilarDao.excluir(pProdutoSimilarModel: ITProdutoSimilarModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from PRODUTO_SIMILAR where ID = :ID' ,[pProdutoSimilarModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pProdutoSimilarModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;


class function TProdutoSimilarDao.getNewIface(pIConexao: IConexao): ITProdutoSimilarDao;
begin
  Result := TImplObjetoOwner<TProdutoSimilarDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TProdutoSimilarDao.where: String;
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

procedure TProdutoSimilarDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from PRODUTO_SIMILAR where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TProdutoSimilarDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+' *       '+SLineBreak+
              '    from PRODUTO_SIMILAR        '+SLineBreak+
              '   where 1=1                    '+SLineBreak;


    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

function TProdutoSimilarDao.VerificarProduto(pProduto, pSimilar: String): String;
begin
  Result := vIConexao.getConnection.ExecSQLScalar('select * from produto_similar s where s.produto_id = '+QuotedStr(pProduto)+' and s.produto_similar_id = '+QuotedStr(pSimilar));
end;

procedure TProdutoSimilarDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TProdutoSimilarDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TProdutoSimilarDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TProdutoSimilarDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TProdutoSimilarDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TProdutoSimilarDao.setParams(var pQry: TFDQuery; pProdutoSimilarModel: ITProdutoSimilarModel);
begin
  vConstrutor.setParams('PRODUTO_SIMILAR', pQry,pProdutoSimilarModel.objeto);
end;

procedure TProdutoSimilarDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TProdutoSimilarDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TProdutoSimilarDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
