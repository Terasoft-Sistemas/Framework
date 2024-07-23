unit TabelaJurosDiaDao;

interface

uses
  TabelaJurosDiaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TTabelaJurosDiaDao = class

  private
    vIConexao 	: IConexao;
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
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pTabelaJurosDiaModel: TTabelaJurosDiaModel): String;
    function alterar(pTabelaJurosDiaModel: TTabelaJurosDiaModel): String;
    function excluir(pTabelaJurosDiaModel: TTabelaJurosDiaModel): String;

    function carregaClasse(pID : String): TTabelaJurosDiaModel;
    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pTabelaJurosDiaModel: TTabelaJurosDiaModel);

end;

implementation

uses
  System.Rtti;

{ TTabelaJurosDia }

function TTabelaJurosDiaDao.carregaClasse(pID : String): TTabelaJurosDiaModel;
var
  lQry: TFDQuery;
  lModel: TTabelaJurosDiaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTabelaJurosDiaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from Tabelajuros_dia where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID      := lQry.FieldByName('ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TTabelaJurosDiaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TTabelaJurosDiaDao.Destroy;
begin
  inherited;
end;

function TTabelaJurosDiaDao.incluir(pTabelaJurosDiaModel: TTabelaJurosDiaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('TABELAJUROS_DIA', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pTabelaJurosDiaModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosDiaDao.alterar(pTabelaJurosDiaModel: TTabelaJurosDiaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('TABELAJUROS_DIA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pTabelaJurosDiaModel);
    lQry.ExecSQL;

    Result := pTabelaJurosDiaModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosDiaDao.excluir(pTabelaJurosDiaModel: TTabelaJurosDiaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from Tabelajuros_dia where ID = :ID' ,[pTabelaJurosDiaModel.ID]);
   lQry.ExecSQL;
   Result := pTabelaJurosDiaModel.ID;

  finally
    lQry.Free;
  end;
end;

function TTabelaJurosDiaDao.where: String;
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

procedure TTabelaJurosDiaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From Tabelajuros_dia where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TTabelaJurosDiaDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+' * from TabelaJuros_dia where 1=1 '+SLineBreak;

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

procedure TTabelaJurosDiaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosDiaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosDiaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosDiaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosDiaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTabelaJurosDiaDao.setParams(var pQry: TFDQuery; pTabelaJurosDiaModel: TTabelaJurosDiaModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('Tabelajuros_dia');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TTabelaJurosDiaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pTabelaJurosDiaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pTabelaJurosDiaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TTabelaJurosDiaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTabelaJurosDiaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTabelaJurosDiaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
