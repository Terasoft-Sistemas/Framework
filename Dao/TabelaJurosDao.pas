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
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.Utils;

type
  TTabelaJurosDao = class;
  ITTabelaJurosDao=IObject<TTabelaJurosDao>;

  TTabelaJurosDao = class
  private
    [unsafe] mySelf:ITTabelaJurosDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FTabelaJurossLista: IList<ITTabelaJurosModel>;
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
    procedure SetTabelaJurossLista(const Value: IList<ITTabelaJurosModel>);
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

    class function getNewIface(pIConexao: IConexao): ITTabelaJurosDao;

    property TabelaJurossLista: IList<ITTabelaJurosModel> read FTabelaJurossLista write SetTabelaJurossLista;
    property ID: Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    procedure setParams(var pQry: TFDQuery; pTabelaJurosModel: ITTabelaJurosModel);

    function incluir(ATabelaJurosModel: ITTabelaJurosModel): String;
    function alterar(ATabelaJurosModel: ITTabelaJurosModel): String;
    function excluir(ATabelaJurosModel: ITTabelaJurosModel): String;

    procedure obterLista;
    function carregaClasse(pId: Integer): ITTabelaJurosModel;

end;

implementation

uses
  System.Rtti;

{ TTabelaJuros }

function TTabelaJurosDao.carregaClasse(pId: Integer): ITTabelaJurosModel;
var
  lQry: TFDQuery;
  lModel: ITTabelaJurosModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTabelaJurosModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from tabelajuros where id = '+ IntToStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.CODIGO      := lQry.FieldByName('CODIGO').AsString;
    lModel.objeto.INDCE       := lQry.FieldByName('INDCE').AsString;
    lModel.objeto.INDCEENT    := lQry.FieldByName('INDCEENT').AsString;
    lModel.objeto.ID          := lQry.FieldByName('ID').AsString;
    lModel.objeto.PERCENTUAL  := lQry.FieldByName('PERCENTUAL').AsString;
    lModel.objeto.PORTADOR_ID := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TTabelaJurosDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TTabelaJurosDao.Destroy;
begin
  FTabelaJurossLista:=nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TTabelaJurosDao.incluir(ATabelaJurosModel: ITTabelaJurosModel): String;
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

function TTabelaJurosDao.alterar(ATabelaJurosModel: ITTabelaJurosModel): String;
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

    Result := ATabelaJurosModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosDao.excluir(ATabelaJurosModel: ITTabelaJurosModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from tabelajuros where ID = :ID',[ATabelaJurosModel.objeto.ID]);
   lQry.ExecSQL;
   Result := ATabelaJurosModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TTabelaJurosDao.getNewIface(pIConexao: IConexao): ITTabelaJurosDao;
begin
  Result := TImplObjetoOwner<TTabelaJurosDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
  modelo: ITTabelaJurosModel;
begin
  lQry := vIConexao.CriarQuery;

  FTabelaJurossLista := TCollections.CreateList<ITTabelaJurosModel>;

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
      modelo := TTabelaJurosModel.getNewIface(vIConexao);
      FTabelaJurossLista.Add(modelo);

      modelo.objeto.CODIGO      := lQry.FieldByName('CODIGO').AsString;
      modelo.objeto.INDCE       := lQry.FieldByName('INDCE').AsString;
      modelo.objeto.INDCEENT    := lQry.FieldByName('INDCEENT').AsString;
      modelo.objeto.ID          := lQry.FieldByName('ID').AsString;
      modelo.objeto.PERCENTUAL  := FormatFloat('#,##0.00', lQry.FieldByName('PERCENTUAL').AsFloat);
      modelo.objeto.PORTADOR_ID := lQry.FieldByName('PORTADOR_ID').AsString;
      modelo.objeto.SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

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

procedure TTabelaJurosDao.setParams(var pQry: TFDQuery; pTabelaJurosModel: ITTabelaJurosModel);
begin
  vConstrutor.setParams('TABELAJUROS',pQry,pTabelaJurosModel.objeto);
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
