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
  MedidaModel;

type
  TMedidaDao = class

  private
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

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pMedidaModel: TMedidaModel): String;
    function alterar(pMedidaModel: TMedidaModel): String;
    function excluir(pMedidaModel: TMedidaModel): String;
    function carregaClasse(pID : String): TMedidaModel;

    procedure setParams(var pQry: TFDQuery; pMedidaModel: TMedidaModel);
    function ObterLista: TFDMemTable; overload;

end;

implementation

uses
  Data.DB, System.Rtti;

{ TPCG }

function TMedidaDao.carregaClasse(pID: String): TMedidaModel;
var
  lQry: TFDQuery;
  lModel: TMedidaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TMedidaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from MEDIDA where CODIGO_MED = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.CODIGO_MED       := lQry.FieldByName('CODIGO_MED').AsString;
    lModel.DESCRICAO_MED    := lQry.FieldByName('DESCRICAO_MED').AsString;
    lModel.ID               := lQry.FieldByName('ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TMedidaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TMedidaDao.Destroy;
begin
  inherited;
end;


function TMedidaDao.incluir(pMedidaModel: TMedidaModel): String;
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

function TMedidaDao.ObterLista: TFDMemTable;
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

function TMedidaDao.alterar(pMedidaModel: TMedidaModel): String;
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

    Result := pMedidaModel.CODIGO_MED;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMedidaDao.excluir(pMedidaModel: TMedidaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from MEDIDA where CODIGO_MED = :CODIGO_MED' ,[pMedidaModel.CODIGO_MED]);
   lQry.ExecSQL;
   Result := pMedidaModel.CODIGO_MED;

  finally
    lQry.Free;
  end;
end;

function TMedidaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and CODIGO_MED = '+IntToStr(FIDRecordView);

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

procedure TMedidaDao.SetIDRecordView(const Value: Integer);
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

procedure TMedidaDao.setParams(var pQry: TFDQuery; pMedidaModel: TMedidaModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('MEDIDA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TMedidaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pMedidaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pMedidaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
