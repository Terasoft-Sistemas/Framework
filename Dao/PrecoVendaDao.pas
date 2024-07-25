unit PrecoVendaDao;
interface
uses
  PrecoVendaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TPrecoVendaDao = class
  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPrecoVendasLista: IList<TPrecoVendaModel>;
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
    procedure SetPrecoVendasLista(const Value: IList<TPrecoVendaModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPrecoVendaModel: TPrecoVendaModel);
    function where: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property PrecoVendasLista: IList<TPrecoVendaModel> read FPrecoVendasLista write SetPrecoVendasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pPrecoVendaModel: TPrecoVendaModel): String;
    function alterar(pPrecoVendaModel: TPrecoVendaModel): String;
    function excluir(pPrecoVendaModel: TPrecoVendaModel): String;
	  function carregaClasse(pID : String) : TPrecoVendaModel;
    procedure obterLista;
end;
implementation

uses
  System.Rtti;
{ TPrecoVenda }
function TPrecoVendaDao.carregaClasse(pID: String): TPrecoVendaModel;
var
  lQry: TFDQuery;
  lModel: TPrecoVendaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPrecoVendaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PRECO_VENDA where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                   := lQry.FieldByName('ID').AsString;
    lModel.NOME                 := lQry.FieldByName('NOME').AsString;
    lModel.ACRESCIMO_DESCONTO   := lQry.FieldByName('ACRESCIMO_DESCONTO').AsString;
    lModel.PERCENTUAL           := lQry.FieldByName('PERCENTUAL').AsString;
    lModel.STATUS               := lQry.FieldByName('STATUS').AsString;
    lModel.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
    lModel.TIPO_CUSTO           := lQry.FieldByName('TIPO_CUSTO').AsString;
    lModel.CONDICOES            := lQry.FieldByName('CONDICOES').AsString;
    lModel.PRODUTOS_IGNORAR     := lQry.FieldByName('PRODUTOS_IGNORAR').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TPrecoVendaDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPrecoVendaDao.Destroy;
begin
  FPrecoVendasLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TPrecoVendaDao.incluir(pPrecoVendaModel: TPrecoVendaModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PRECO_VENDA', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pPrecoVendaModel.ID := vIConexao.Generetor('GEN_PRECOVENDA');
    setParams(lQry, pPrecoVendaModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPrecoVendaDao.alterar(pPrecoVendaModel: TPrecoVendaModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PRECO_VENDA', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPrecoVendaModel);
    lQry.ExecSQL;

    Result := pPrecoVendaModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPrecoVendaDao.excluir(pPrecoVendaModel: TPrecoVendaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from preco_venda where ID = :ID',[pPrecoVendaModel.ID]);
   lQry.ExecSQL;
   Result := pPrecoVendaModel.ID;
  finally
    lQry.Free;
  end;
end;
function TPrecoVendaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';
  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;
  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and preco_venda.id = '+IntToStr(FIDRecordView);
  Result := lSQL;
end;
procedure TPrecoVendaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := 'select count(*) records From preco_venda where 1=1 ';
    lSql := lSql + where;
    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;
procedure TPrecoVendaDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: TPrecoVendaModel;
begin
  lQry := vIConexao.CriarQuery;
  FPrecoVendasLista := TCollections.CreateList<TPrecoVendaModel>(true);
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';
    lSQL := lSQL +
    '        preco_venda.*            '+
	  '   from preco_venda              '+
    '  where 1=1                      ';
    lSql := lSql + where;
    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;
    lQry.Open(lSQL);
    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPrecoVendaModel.Create(vIConexao);
      FPrecoVendasLista.Add(modelo);
      modelo.ID                 := lQry.FieldByName('ID').AsString;
      modelo.NOME               := lQry.FieldByName('NOME').AsString;
      modelo.ACRESCIMO_DESCONTO := lQry.FieldByName('ACRESCIMO_DESCONTO').AsString;
      modelo.PERCENTUAL         := lQry.FieldByName('PERCENTUAL').AsString;
      modelo.STATUS             := lQry.FieldByName('STATUS').AsString;
      modelo.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;
      modelo.TIPO_CUSTO         := lQry.FieldByName('TIPO_CUSTO').AsString;
      modelo.CONDICOES          := lQry.FieldByName('CONDICOES').AsString;
      modelo.PRODUTOS_IGNORAR   := lQry.FieldByName('PRODUTOS_IGNORAR').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;
procedure TPrecoVendaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TPrecoVendaDao.SetPrecoVendasLista;
begin
  FPrecoVendasLista := Value;
end;
procedure TPrecoVendaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;
procedure TPrecoVendaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;
procedure TPrecoVendaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;
procedure TPrecoVendaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoVendaDao.setParams(var pQry: TFDQuery; pPrecoVendaModel: TPrecoVendaModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PRECO_VENDA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPrecoVendaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPrecoVendaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPrecoVendaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPrecoVendaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TPrecoVendaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TPrecoVendaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
end.
