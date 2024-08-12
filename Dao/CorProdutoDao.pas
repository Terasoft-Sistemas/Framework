unit CorProdutoDao;

interface

uses
  CorProdutoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TCorProdutoDao = class;
  ITCorProdutoDao=IObject<TCorProdutoDao>;

  TCorProdutoDao = class
  private
    [weak] mySelf: ITCorProdutoDao;
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

    class function getNewIface(pIConexao: IConexao): ITCorProdutoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pCorProdutoModel: ITCorProdutoModel): String;
    function alterar(pCorProdutoModel: ITCorProdutoModel): String;
    function excluir(pCorProdutoModel: ITCorProdutoModel): String;

    function carregaClasse(pID : String): ITCorProdutoModel;
    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pCorProdutoModel: ITCorProdutoModel);

end;

implementation

uses
  System.Rtti;

{ TCorProduto }

function TCorProdutoDao.carregaClasse(pID : String): ITCorProdutoModel;
var
  lQry: TFDQuery;
  lModel: ITCorProdutoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCorProdutoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from cor_produto where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;
    lModel.objeto.DESCRICAO        := lQry.FieldByName('DESCRICAO').AsString;
    lModel.objeto.DATA_CADASTRO    := lQry.FieldByName('DATA_CADASTRO').AsString;
    lModel.objeto.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TCorProdutoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TCorProdutoDao.Destroy;
begin
  inherited;
end;

function TCorProdutoDao.incluir(pCorProdutoModel: ITCorProdutoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('COR_PRODUTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pCorProdutoModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCorProdutoDao.alterar(pCorProdutoModel: ITCorProdutoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('cor_produto','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pCorProdutoModel);
    lQry.ExecSQL;

    Result := pCorProdutoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCorProdutoDao.excluir(pCorProdutoModel: ITCorProdutoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from cor_produto where ID = :ID' ,[pCorProdutoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pCorProdutoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TCorProdutoDao.getNewIface(pIConexao: IConexao): ITCorProdutoDao;
begin
  Result := TImplObjetoOwner<TCorProdutoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCorProdutoDao.where: String;
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

procedure TCorProdutoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From cor_produto where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TCorProdutoDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+'         '+SLineBreak+
              '         id,                    '+SLineBreak+
              '         descricao,             '+SLineBreak+
              '         data_cadastro,         '+SLineBreak+
              '         systime                '+SLineBreak+
              '    from cor_produto            '+SLineBreak+
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

procedure TCorProdutoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCorProdutoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCorProdutoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCorProdutoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCorProdutoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCorProdutoDao.setParams(var pQry: TFDQuery; pCorProdutoModel: ITCorProdutoModel);
begin
  vConstrutor.setParams('Cor_Produto',pQry,pCorProdutoModel.objeto);
end;

procedure TCorProdutoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCorProdutoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCorProdutoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
