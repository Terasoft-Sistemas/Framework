unit ImpressoraDao;

interface

uses
  ImpressoraModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TImpressoraDao = class;
  ITImpressoraDao=IObject<TImpressoraDao>;

  TImpressoraDao = class
  private
    [unsafe] mySelf: ITImpressoraDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FImpressorasLista: IList<ITImpressoraModel>;
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
    procedure SetImpressorasLista(const Value: IList<ITImpressoraModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure setParams(var pQry: TFDQuery; pImpressoraModel: ITImpressoraModel);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITImpressoraDao;

    property ImpressorasLista: IList<ITImpressoraModel> read FImpressorasLista write SetImpressorasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AImpressoraModel: ITImpressoraModel): String;
    function alterar(AImpressoraModel: ITImpressoraModel): String;
    function excluir(AImpressoraModel: ITImpressoraModel): String;
	  function carregaClasse(pId: Integer): ITImpressoraModel;

    procedure obterLista;

end;

implementation

uses
  System.Rtti;

{ TImpressora }

function TImpressoraDao.carregaClasse(pId: Integer): ITImpressoraModel;
var
  lQry: TFDQuery;
  lModel: ITImpressoraModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TImpressoraModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from IMPRESSORA where ID = '+pId.ToString);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID              := lQry.FieldByName('ID').AsString;
    lModel.objeto.NOME            := lQry.FieldByName('NOME').AsString;
    lModel.objeto.CAMINHO         := lQry.FieldByName('CAMINHO').AsString;
    lModel.objeto.VIAS            := lQry.FieldByName('VIAS').AsString;
    lModel.objeto.DIRETA          := lQry.FieldByName('DIRETA').AsString;
    lModel.objeto.LISTA_IMPRESSAO := lQry.FieldByName('LISTA_IMPRESSAO').AsString;
    lModel.objeto.CORTE           := lQry.FieldByName('CORTE').AsString;
    lModel.objeto.SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.CABECALHO       := lQry.FieldByName('CABECALHO').AsString;
    lModel.objeto.CORPO           := lQry.FieldByName('CORPO').AsString;
    lModel.objeto.RODAPE          := lQry.FieldByName('RODAPE').AsString;
    lModel.objeto.PORTA           := lQry.FieldByName('PORTA').AsString;
    lModel.objeto.MODELO          := lQry.FieldByName('MODELO').AsString;
    lModel.objeto.RECIBO          := lQry.FieldByName('RECIBO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TImpressoraDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(pIConexao);
end;

destructor TImpressoraDao.Destroy;
begin
  FImpressorasLista:=nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TImpressoraDao.incluir(AImpressoraModel: ITImpressoraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('IMPRESSORA','ID');

  try
    lQry.SQL.Add(lSQL);
    AImpressoraModel.objeto.ID := vIConexao.Generetor('GEN_IMPRESSORA');
    setParams(lQry, AImpressoraModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TImpressoraDao.alterar(AImpressoraModel: ITImpressoraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('IMPRESSORA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AImpressoraModel);
    lQry.ExecSQL;

    Result := AImpressoraModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TImpressoraDao.excluir(AImpressoraModel: ITImpressoraModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from IMPRESSORA where ID = :ID',[AImpressoraModel.objeto.ID]);
   lQry.ExecSQL;
   Result := AImpressoraModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TImpressoraDao.getNewIface(pIConexao: IConexao): ITImpressoraDao;
begin
  Result := TImplObjetoOwner<TImpressoraDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TImpressoraDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and IMPRESSORA.ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TImpressoraDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From IMPRESSORA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TImpressoraDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITImpressoraModel;
begin
  lQry := vIConexao.CriarQuery;

  FImpressorasLista := TCollections.CreateList<ITImpressoraModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '        impressora.*            '+
	    '   from impressora              '+
      '  where 1=1                     ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TImpressoraModel.getNewIface(vIConexao);
      FImpressorasLista.Add(modelo);

      modelo.objeto.ID              := lQry.FieldByName('ID').AsString;
      modelo.objeto.NOME            := lQry.FieldByName('NOME').AsString;
      modelo.objeto.CAMINHO         := lQry.FieldByName('CAMINHO').AsString;
      modelo.objeto.VIAS            := lQry.FieldByName('VIAS').AsString;
      modelo.objeto.DIRETA          := lQry.FieldByName('DIRETA').AsString;
      modelo.objeto.LISTA_IMPRESSAO := lQry.FieldByName('LISTA_IMPRESSAO').AsString;
      modelo.objeto.CORTE           := lQry.FieldByName('CORTE').AsString;
      modelo.objeto.SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.CABECALHO       := lQry.FieldByName('CABECALHO').AsString;
      modelo.objeto.CORPO           := lQry.FieldByName('CORPO').AsString;
      modelo.objeto.RODAPE          := lQry.FieldByName('RODAPE').AsString;
      modelo.objeto.PORTA           := lQry.FieldByName('PORTA').AsString;
      modelo.objeto.MODELO          := lQry.FieldByName('MODELO').AsString;
      modelo.objeto.RECIBO          := lQry.FieldByName('RECIBO').AsString;
      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TImpressoraDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TImpressoraDao.SetImpressorasLista;
begin
  FImpressorasLista := Value;
end;

procedure TImpressoraDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TImpressoraDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TImpressoraDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TImpressoraDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TImpressoraDao.setParams(var pQry: TFDQuery; pImpressoraModel: ITImpressoraModel);
begin
  vConstrutor.setParams('IMPRESSORA',pQry,pImpressoraModel.objeto);
end;

procedure TImpressoraDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TImpressoraDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TImpressoraDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
