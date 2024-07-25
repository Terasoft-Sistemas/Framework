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
  Interfaces.Conexao;

type
  TImpressoraDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FImpressorasLista: IList<TImpressoraModel>;
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
    procedure SetImpressorasLista(const Value: IList<TImpressoraModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure setParams(var pQry: TFDQuery; pImpressoraModel: TImpressoraModel);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ImpressorasLista: IList<TImpressoraModel> read FImpressorasLista write SetImpressorasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AImpressoraModel: TImpressoraModel): String;
    function alterar(AImpressoraModel: TImpressoraModel): String;
    function excluir(AImpressoraModel: TImpressoraModel): String;
	  function carregaClasse(pId: Integer): TImpressoraModel;

    procedure obterLista;

end;

implementation

uses
  System.Rtti;

{ TImpressora }

function TImpressoraDao.carregaClasse(pId: Integer): TImpressoraModel;
var
  lQry: TFDQuery;
  lModel: TImpressoraModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TImpressoraModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from IMPRESSORA where ID = '+pId.ToString);

    if lQry.IsEmpty then
      Exit;

    lModel.ID              := lQry.FieldByName('ID').AsString;
    lModel.NOME            := lQry.FieldByName('NOME').AsString;
    lModel.CAMINHO         := lQry.FieldByName('CAMINHO').AsString;
    lModel.VIAS            := lQry.FieldByName('VIAS').AsString;
    lModel.DIRETA          := lQry.FieldByName('DIRETA').AsString;
    lModel.LISTA_IMPRESSAO := lQry.FieldByName('LISTA_IMPRESSAO').AsString;
    lModel.CORTE           := lQry.FieldByName('CORTE').AsString;
    lModel.SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
    lModel.CABECALHO       := lQry.FieldByName('CABECALHO').AsString;
    lModel.CORPO           := lQry.FieldByName('CORPO').AsString;
    lModel.RODAPE          := lQry.FieldByName('RODAPE').AsString;
    lModel.PORTA           := lQry.FieldByName('PORTA').AsString;
    lModel.MODELO          := lQry.FieldByName('MODELO').AsString;
    lModel.RECIBO          := lQry.FieldByName('RECIBO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TImpressoraDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(pIConexao);
end;

destructor TImpressoraDao.Destroy;
begin
  FImpressorasLista:=nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TImpressoraDao.incluir(AImpressoraModel: TImpressoraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('IMPRESSORA','ID');

  try
    lQry.SQL.Add(lSQL);
    AImpressoraModel.ID := vIConexao.Generetor('GEN_IMPRESSORA');
    setParams(lQry, AImpressoraModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TImpressoraDao.alterar(AImpressoraModel: TImpressoraModel): String;
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

    Result := AImpressoraModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TImpressoraDao.excluir(AImpressoraModel: TImpressoraModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from IMPRESSORA where ID = :ID',[AImpressoraModel.ID]);
   lQry.ExecSQL;
   Result := AImpressoraModel.ID;

  finally
    lQry.Free;
  end;
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FImpressorasLista := TCollections.CreateList<TImpressoraModel>(true);

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

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FImpressorasLista.Add(TImpressoraModel.Create(vIConexao));

      i := FImpressorasLista.Count -1;

      FImpressorasLista[i].ID              := lQry.FieldByName('ID').AsString;
      FImpressorasLista[i].NOME            := lQry.FieldByName('NOME').AsString;
      FImpressorasLista[i].CAMINHO         := lQry.FieldByName('CAMINHO').AsString;
      FImpressorasLista[i].VIAS            := lQry.FieldByName('VIAS').AsString;
      FImpressorasLista[i].DIRETA          := lQry.FieldByName('DIRETA').AsString;
      FImpressorasLista[i].LISTA_IMPRESSAO := lQry.FieldByName('LISTA_IMPRESSAO').AsString;
      FImpressorasLista[i].CORTE           := lQry.FieldByName('CORTE').AsString;
      FImpressorasLista[i].SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
      FImpressorasLista[i].CABECALHO       := lQry.FieldByName('CABECALHO').AsString;
      FImpressorasLista[i].CORPO           := lQry.FieldByName('CORPO').AsString;
      FImpressorasLista[i].RODAPE          := lQry.FieldByName('RODAPE').AsString;
      FImpressorasLista[i].PORTA           := lQry.FieldByName('PORTA').AsString;
      FImpressorasLista[i].MODELO          := lQry.FieldByName('MODELO').AsString;
      FImpressorasLista[i].RECIBO          := lQry.FieldByName('RECIBO').AsString;
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

procedure TImpressoraDao.setParams(var pQry: TFDQuery; pImpressoraModel: TImpressoraModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('IMPRESSORA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TImpressoraModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pImpressoraModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pImpressoraModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
