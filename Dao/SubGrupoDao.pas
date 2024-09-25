unit SubGrupoDao;

interface

uses
  SubGrupoModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao;

type
  TSubGrupoDao = class;
  ITSubGrupoDao=IObject<TSubGrupoDao>;

  TSubGrupoDao = class
  private
    [unsafe] mySelf: ITSubGrupoDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

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
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;
    procedure SetIDRecordView(const Value: String);

    var
      vConstrutorDao : IConstrutorDao;

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITSubGrupoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String  read FIDRecordView write SetIDRecordView;

    function incluir(pSubGrupoModel: ITSubGrupoModel): String;
    function alterar(pSubGrupoModel: ITSubGrupoModel): String;
    function excluir(pSubGrupoModel: ITSubGrupoModel): String;
    function carregaClasse(pID : String): ITSubGrupoModel;

    procedure setParams(var pQry: TFDQuery; pSubGrupoModel: ITSubGrupoModel);
    function ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): IFDDataset; overload;
    function ObterLista: IFDDataset; overload;

end;

implementation

uses
  Data.DB, System.Rtti;

{ TPCG }

constructor TSubGrupoDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TSubGrupoDao.Destroy;
begin
  inherited;
end;

function TSubGrupoDao.carregaClasse(pID: String): ITSubGrupoModel;
var
  lQry: TFDQuery;
  lModel: ITSubGrupoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TSubGrupoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from SUBGRUPOPRODUTO where CODIGO_SUB = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.CODIGO_SUB       := lQry.FieldByName('CODIGO_SUB').AsString;
    lModel.objeto.NOME_SUB         := lQry.FieldByName('NOME_SUB').AsString;
    lModel.objeto.CODIGO_GRU       := lQry.FieldByName('CODIGO_GRU').AsString;
    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TSubGrupoDao.ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: IFDDataset;
begin
  try
    lMemTable := TImplObjetoOwner<TDataset>.CreateOwner(TFDMemTable.Create(nil));


    lSQL := 'Select CODIGO_SUB,          ' + #13 +
            '       NOME_SUB             ' + #13 +
            'From SUBGRUPOPRODUTO        ' + #13 +
            'Order by NOME_SUB           ' + #13;

    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoRazao';
      Fields := 'RAZAO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    TFDMemTable(lMemTable.objeto).IndexName := 'OrdenacaoRazao';

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('CODIGO', ftString, 6);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('RAZAO', ftString, 40);
    TFDMemTable(lMemTable.objeto).CreateDataSet;

    lQry := vIConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.objeto.InsertRecord([
                              lQry.FieldByName('CODIGO_SUB').AsString,
                              lQry.FieldByName('NOME_SUB').AsString
                             ]);

      lQry.Next;
    end;

    lMemTable.objeto.Open;

    Result := lMemTable;

  finally
    lQry.Free;
  end;
end;

function TSubGrupoDao.incluir(pSubGrupoModel: ITSubGrupoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('SUBGRUPOPRODUTO', 'CODIGO_SUB');

  try
    lQry.SQL.Add(lSQL);
    pSubGrupoModel.objeto.CODIGO_SUB := vIConexao.Generetor('GEN_SUBGRUPOPRODUTO');
    setParams(lQry, pSubGrupoModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_SUB').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSubGrupoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := 'select '+lPaginacao+' * from SUBGRUPOPRODUTO where 1=1 ';

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

function TSubGrupoDao.alterar(pSubGrupoModel: ITSubGrupoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('SUBGRUPOPRODUTO','CODIGO_SUB');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pSubGrupoModel);
    lQry.ExecSQL;

    Result := pSubGrupoModel.objeto.CODIGO_SUB;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSubGrupoDao.excluir(pSubGrupoModel: ITSubGrupoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from SUBGRUPOPRODUTO where CODIGO_SUB = :CODIGO_SUB' ,[pSubGrupoModel.objeto.CODIGO_SUB]);
   lQry.ExecSQL;
   Result := pSubGrupoModel.objeto.CODIGO_SUB;

  finally
    lQry.Free;
  end;
end;

class function TSubGrupoDao.getNewIface(pIConexao: IConexao): ITSubGrupoDao;
begin
  Result := TImplObjetoOwner<TSubGrupoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TSubGrupoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and CODIGO_SUB = '+QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TSubGrupoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From SUBGRUPOPRODUTO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TSubGrupoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSubGrupoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSubGrupoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TSubGrupoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSubGrupoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TSubGrupoDao.setParams(var pQry: TFDQuery; pSubGrupoModel: ITSubGrupoModel);
begin
  vConstrutor.setParams('SubGrupoPRODUTO',pQry,pSubGrupoModel.objeto);
end;

procedure TSubGrupoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TSubGrupoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TSubGrupoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
