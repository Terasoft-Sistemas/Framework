unit TabelaJurosDao;

interface

uses
  TabelaJurosModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao,
  Terasoft.Utils;

type
  TTabelaJurosDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FTabelaJurossLista: IList<TTabelaJurosModel>;
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
    procedure SetTabelaJurossLista(const Value: IList<TTabelaJurosModel>);
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

    property TabelaJurossLista: IList<TTabelaJurosModel> read FTabelaJurossLista write SetTabelaJurossLista;
    property ID: Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    procedure setParams(var pQry: TFDQuery; pTabelaJurosModel: TTabelaJurosModel);

    function incluir(ATabelaJurosModel: TTabelaJurosModel): String;
    function alterar(ATabelaJurosModel: TTabelaJurosModel): String;
    function excluir(ATabelaJurosModel: TTabelaJurosModel): String;

    procedure obterLista;
    function carregaClasse(pId: Integer): TTabelaJurosModel;

end;

implementation

uses
  System.Rtti;

{ TTabelaJuros }

function TTabelaJurosDao.carregaClasse(pId: Integer): TTabelaJurosModel;
var
  lQry: TFDQuery;
  lModel: TTabelaJurosModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTabelaJurosModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from tabelajuros where id = '+ IntToStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.CODIGO      := lQry.FieldByName('CODIGO').AsString;
    lModel.INDCE       := lQry.FieldByName('INDCE').AsString;
    lModel.INDCEENT    := lQry.FieldByName('INDCEENT').AsString;
    lModel.ID          := lQry.FieldByName('ID').AsString;
    lModel.PERCENTUAL  := lQry.FieldByName('PERCENTUAL').AsString;
    lModel.PORTADOR_ID := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TTabelaJurosDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TTabelaJurosDao.Destroy;
begin
  FTabelaJurossLista:=nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TTabelaJurosDao.incluir(ATabelaJurosModel: TTabelaJurosModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := vConstrutor.gerarInsert('TABELAJUROS', 'ID');
    lQry.SQL.Add(lSQL);
    setParams(lQry, ATabelaJurosModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosDao.alterar(ATabelaJurosModel: TTabelaJurosModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('TABELAJUROS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ATabelaJurosModel);
    lQry.ExecSQL;

    Result := ATabelaJurosModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosDao.excluir(ATabelaJurosModel: TTabelaJurosModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from tabelajuros where ID = :ID',[ATabelaJurosModel.ID]);
   lQry.ExecSQL;
   Result := ATabelaJurosModel.ID;

  finally
    lQry.Free;
  end;
end;

function TTabelaJurosDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and tabelajuros.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TTabelaJurosDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From tabelajuros where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TTabelaJurosDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: TTabelaJurosModel;
begin
  lQry := vIConexao.CriarQuery;

  FTabelaJurossLista := TCollections.CreateList<TTabelaJurosModel>(true);

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
    '       tabelajuros.*          '+
	  '  from tabelajuros            '+
    ' where 1=1                    ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TTabelaJurosModel.Create(vIConexao);
      FTabelaJurossLista.Add(modelo);

      modelo.CODIGO      := lQry.FieldByName('CODIGO').AsString;
      modelo.INDCE       := lQry.FieldByName('INDCE').AsString;
      modelo.INDCEENT    := lQry.FieldByName('INDCEENT').AsString;
      modelo.ID          := lQry.FieldByName('ID').AsString;
      modelo.PERCENTUAL  := FormatFloat('#,##0.00', lQry.FieldByName('PERCENTUAL').AsFloat);
      modelo.PORTADOR_ID := lQry.FieldByName('PORTADOR_ID').AsString;
      modelo.SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TTabelaJurosDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosDao.SetTabelaJurossLista;
begin
  FTabelaJurossLista := Value;
end;

procedure TTabelaJurosDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTabelaJurosDao.setParams(var pQry: TFDQuery; pTabelaJurosModel: TTabelaJurosModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('TABELAJUROS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TTabelaJurosModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pTabelaJurosModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pTabelaJurosModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TTabelaJurosDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTabelaJurosDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTabelaJurosDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
