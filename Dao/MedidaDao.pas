unit MedidaDao;

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
  MedidaModel;

type
  TMedidaDao = class;
  ITMedidaDao=IObject<TMedidaDao>;

  TMedidaDao = class
  private
    [unsafe] mySelf: ITMedidaDao;
    vIConexao : IConexao;

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

    class function getNewIface(pIConexao: IConexao): ITMedidaDao;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pMedidaModel: ITMedidaModel): String;
    function alterar(pMedidaModel: ITMedidaModel): String;
    function excluir(pMedidaModel: ITMedidaModel): String;
    function carregaClasse(pID : String): ITMedidaModel;

    procedure setParams(var pQry: TFDQuery; pMedidaModel: ITMedidaModel);
    function ObterLista: IFDDataset; overload;

end;

implementation

uses
  Data.DB, System.Rtti;

{ TPCG }

function TMedidaDao.carregaClasse(pID: String): ITMedidaModel;
var
  lQry: TFDQuery;
  lModel: ITMedidaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TMedidaModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from MEDIDA where CODIGO_MED = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.CODIGO_MED       := lQry.FieldByName('CODIGO_MED').AsString;
    lModel.objeto.DESCRICAO_MED    := lQry.FieldByName('DESCRICAO_MED').AsString;
    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TMedidaDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TMedidaDao.Destroy;
begin
  inherited;
end;


function TMedidaDao.incluir(pMedidaModel: ITMedidaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('MEDIDA', 'CODIGO_MED', true);

  try
    lQry.SQL.Add(lSQL);
//    pAnexoModel.ID := vIConexao.Generetor('MEDIDA');
    setParams(lQry, pMedidaModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_MED').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMedidaDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := 'select '+lPaginacao+' * from MEDIDA where 1=1 ';

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

function TMedidaDao.alterar(pMedidaModel: ITMedidaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('MEDIDA','CODIGO_MED');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMedidaModel);
    lQry.ExecSQL;

    Result := pMedidaModel.objeto.CODIGO_MED;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMedidaDao.excluir(pMedidaModel: ITMedidaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from MEDIDA where CODIGO_MED = :CODIGO_MED' ,[pMedidaModel.objeto.CODIGO_MED]);
   lQry.ExecSQL;
   Result := pMedidaModel.objeto.CODIGO_MED;

  finally
    lQry.Free;
  end;
end;

class function TMedidaDao.getNewIface(pIConexao: IConexao): ITMedidaDao;
begin
  Result := TImplObjetoOwner<TMedidaDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TMedidaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and CODIGO_MED = '+QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TMedidaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From MEDIDA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;


procedure TMedidaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMedidaDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TMedidaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMedidaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TMedidaDao.setParams(var pQry: TFDQuery; pMedidaModel: ITMedidaModel);
begin
  vConstrutor.setParams('MEDIDA',pQry,pMedidaModel.objeto);
end;

procedure TMedidaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TMedidaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TMedidaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;


end.
