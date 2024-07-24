unit LocalizacaoEstoqueDao;

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
  LocalizacaoEstoqueModel;

type
  TLocalizacaoEstoqueDao = class

  private
    vIConexao : IConexao;

    vConstrutor : TConstrutorDao;

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
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel): String;
    function alterar(pLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel): String;
    function excluir(pLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel): String;
    function carregaClasse(pID : String): TLocalizacaoEstoqueModel;

    procedure setParams(var pQry: TFDQuery; pLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel);
    function ObterLista: IFDDataset; overload;

end;

implementation

uses
  Data.DB, System.Rtti;

{ TPCG }

function TLocalizacaoEstoqueDao.carregaClasse(pID: String): TLocalizacaoEstoqueModel;
var
  lQry: TFDQuery;
  lModel: TLocalizacaoEstoqueModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TLocalizacaoEstoqueModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from LOCALIZACAO_ESTOQUE where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID      := lQry.FieldByName('ID').AsString;
    lModel.NOME    := lQry.FieldByName('NOME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TLocalizacaoEstoqueDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TLocalizacaoEstoqueDao.Destroy;
begin
  inherited;
end;


function TLocalizacaoEstoqueDao.incluir(pLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('LOCALIZACAO_ESTOQUE', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
//    pAnexoModel.ID := vIConexao.Generetor('LOCALIZACAO_ESTOQUE');
    setParams(lQry, pLocalizacaoEstoqueModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TLocalizacaoEstoqueDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := 'select '+lPaginacao+' * from LOCALIZACAO_ESTOQUE where 1=1 ';

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

function TLocalizacaoEstoqueDao.alterar(pLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('LOCALIZACAO_ESTOQUE','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pLocalizacaoEstoqueModel);
    lQry.ExecSQL;

    Result := pLocalizacaoEstoqueModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TLocalizacaoEstoqueDao.excluir(pLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from LOCALIZACAO_ESTOQUE where ID = :ID' ,[pLocalizacaoEstoqueModel.ID]);
   lQry.ExecSQL;
   Result := pLocalizacaoEstoqueModel.ID;

  finally
    lQry.Free;
  end;
end;

function TLocalizacaoEstoqueDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and ID = ' +QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TLocalizacaoEstoqueDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From LOCALIZACAO_ESTOQUE where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;


procedure TLocalizacaoEstoqueDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TLocalizacaoEstoqueDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TLocalizacaoEstoqueDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TLocalizacaoEstoqueDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TLocalizacaoEstoqueDao.setParams(var pQry: TFDQuery; pLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('LOCALIZACAO_ESTOQUE');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TLocalizacaoEstoqueModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pLocalizacaoEstoqueModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pLocalizacaoEstoqueModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TLocalizacaoEstoqueDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TLocalizacaoEstoqueDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TLocalizacaoEstoqueDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;


end.
