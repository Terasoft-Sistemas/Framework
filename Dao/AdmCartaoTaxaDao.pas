unit AdmCartaoTaxaDao;

interface

uses
  AdmCartaoTaxaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TAdmCartaoTaxaDao = class;

  ITAdmCartaoTaxaDao = IObject<TAdmCartaoTaxaDao>;

  TAdmCartaoTaxaDao = class
  private
    [unsafe] mySelf: ITAdmCartaoTaxaDao;
    vIConexao : IConexao;
    vConstrutor : IConstrutorDao;

    FAdmCartaoTaxasLista: IList<ITAdmCartaoTaxaModel>;
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
    procedure SetAdmCartaoTaxasLista(const Value: IList<ITAdmCartaoTaxaModel>);
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

    class function getNewIface(pIConexao: IConexao): ITAdmCartaoTaxaDao;

    property AdmCartaoTaxasLista: IList<ITAdmCartaoTaxaModel> read FAdmCartaoTaxasLista write SetAdmCartaoTaxasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AAdmCartaoTaxaModel: ITAdmCartaoTaxaModel): String;
    function alterar(AAdmCartaoTaxaModel: ITAdmCartaoTaxaModel): String;
    function excluir(AAdmCartaoTaxaModel: ITAdmCartaoTaxaModel): String;

    function carregaClasse(pID : String): ITAdmCartaoTaxaModel;

    procedure obterLista;

    procedure setParams(var pQry: TFDQuery; pCartaoTaxaModel: ITAdmCartaoTaxaModel);

end;

implementation

uses
  System.Rtti;

{ TAdmCartaoTaxa }

function TAdmCartaoTaxaDao.carregaClasse(pID: String): ITAdmCartaoTaxaModel;
var
  lQry: TFDQuery;
  lModel: ITAdmCartaoTaxaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TAdmCartaoTaxaModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ADMCARTAO_TAXA where ID = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                 := lQry.FieldByName('ID').AsString;
    lModel.objeto.ADM_ID             := lQry.FieldByName('ADM_ID').AsString;
    lModel.objeto.PARCELA            := lQry.FieldByName('PARCELA').AsString;
    lModel.objeto.TAXA               := lQry.FieldByName('TAXA').AsString;
    lModel.objeto.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.DIAS_VENCIMENTO    := lQry.FieldByName('DIAS_VENCIMENTO').AsString;
    lModel.objeto.CONCILIADORA_ID    := lQry.FieldByName('CONCILIADORA_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TAdmCartaoTaxaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TAdmCartaoTaxaDao.Destroy;
begin
  FAdmCartaoTaxasLista := nil;
  vConstrutor := nil;
  vIConexao := nil;
  inherited;
end;

function TAdmCartaoTaxaDao.incluir(AAdmCartaoTaxaModel: ITAdmCartaoTaxaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ADMCARTAO_TAXA', 'ID', True);

  try
    lQry.SQL.Add(lSQL);
    AAdmCartaoTaxaModel.objeto.ID := vIConexao.Generetor('GEN_ADMCARTAO_TAXA');
    setParams(lQry, AAdmCartaoTaxaModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAdmCartaoTaxaDao.alterar(AAdmCartaoTaxaModel: ITAdmCartaoTaxaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('ADMCARTAO_TAXA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AAdmCartaoTaxaModel);
    lQry.ExecSQL;

    Result := AAdmCartaoTaxaModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAdmCartaoTaxaDao.excluir(AAdmCartaoTaxaModel: ITAdmCartaoTaxaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ADMCARTAO_TAXA where ID = :ID',[AAdmCartaoTaxaModel.objeto.ID]);
   lQry.ExecSQL;
   Result := AAdmCartaoTaxaModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TAdmCartaoTaxaDao.getNewIface(pIConexao: IConexao): ITAdmCartaoTaxaDao;
begin
  Result := TImplObjetoOwner<TAdmCartaoTaxaDao>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TAdmCartaoTaxaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TAdmCartaoTaxaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From ADMCARTAO_TAXA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TAdmCartaoTaxaDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITAdmCartaoTaxaModel;
begin
  lQry := vIConexao.CriarQuery;

  FAdmCartaoTaxasLista := TCollections.CreateList<ITAdmCartaoTaxaModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       admcartao_taxa.*         '+
	    '  from admcartao_taxa           '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TAdmCartaoTaxaModel.getNewIface(vIConexao);
      FAdmCartaoTaxasLista.Add(modelo);

      modelo.objeto.ID              := lQry.FieldByName('ID').AsString;
      modelo.objeto.ADM_ID          := lQry.FieldByName('ADM_ID').AsString;
      modelo.objeto.PARCELA         := lQry.FieldByName('PARCELA').AsString;
      modelo.objeto.TAXA            := lQry.FieldByName('TAXA').AsString;
      modelo.objeto.SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.DIAS_VENCIMENTO := lQry.FieldByName('DIAS_VENCIMENTO').AsString;
      modelo.objeto.CONCILIADORA_ID := lQry.FieldByName('CONCILIADORA_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TAdmCartaoTaxaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAdmCartaoTaxaDao.SetAdmCartaoTaxasLista;
begin
  FAdmCartaoTaxasLista := Value;
end;

procedure TAdmCartaoTaxaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAdmCartaoTaxaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAdmCartaoTaxaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAdmCartaoTaxaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAdmCartaoTaxaDao.setParams(var pQry: TFDQuery; pCartaoTaxaModel: ITAdmCartaoTaxaModel);
begin
  vConstrutor.setParams('ADMCARTAO_TAXA',pQry,pCartaoTaxaModel.objeto);
end;

procedure TAdmCartaoTaxaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAdmCartaoTaxaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAdmCartaoTaxaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
