unit DocumentoDao;

interface

uses
  DocumentoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TDocumentoDao = class

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

    function incluir(pDocumentoModel: TDocumentoModel): String;
    function alterar(pDocumentoModel: TDocumentoModel): String;
    function excluir(pDocumentoModel: TDocumentoModel): String;

    function carregaClasse(pID : String): TDocumentoModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pDocumentoModel: TDocumentoModel);

end;

implementation

uses
  System.Rtti;

{ TDocumento }

function TDocumentoDao.carregaClasse(pID : String): TDocumentoModel;
var
  lQry: TFDQuery;
  lModel: TDocumentoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TDocumentoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from DOCUMENTO where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID       := lQry.FieldByName('ID').AsString;
    lModel.NOME     := lQry.FieldByName('NOME').AsString;
    lModel.SYSTIME  := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TDocumentoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TDocumentoDao.Destroy;
begin
  inherited;
end;

function TDocumentoDao.incluir(pDocumentoModel: TDocumentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('DOCUMENTO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pDocumentoModel.ID := vIConexao.Generetor('GEN_DOCUMENTO');
    setParams(lQry, pDocumentoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDocumentoDao.alterar(pDocumentoModel: TDocumentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('DOCUMENTO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pDocumentoModel);
    lQry.ExecSQL;

    Result := pDocumentoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDocumentoDao.excluir(pDocumentoModel: TDocumentoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from DOCUMENTO where ID = :ID' ,[pDocumentoModel.ID]);
   lQry.ExecSQL;
   Result := pDocumentoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TDocumentoDao.where: String;
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

procedure TDocumentoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From DOCUMENTO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TDocumentoDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+' * from DOCUMENTO where 1=1             '+SLineBreak;


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

procedure TDocumentoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDocumentoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDocumentoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TDocumentoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDocumentoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TDocumentoDao.setParams(var pQry: TFDQuery; pDocumentoModel: TDocumentoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('DOCUMENTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TDocumentoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pDocumentoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pDocumentoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TDocumentoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TDocumentoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TDocumentoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
