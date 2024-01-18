unit PrecoVendaDao;

interface

uses
  PrecoVendaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao;

type
  TPrecoVendaDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPrecoVendasLista: TObjectList<TPrecoVendaModel>;
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
    procedure SetPrecoVendasLista(const Value: TObjectList<TPrecoVendaModel>);
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

    property PrecoVendasLista: TObjectList<TPrecoVendaModel> read FPrecoVendasLista write SetPrecoVendasLista;
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
	
    procedure obterLista;

end;

implementation

{ TPrecoVenda }

constructor TPrecoVendaDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPrecoVendaDao.Destroy;
begin

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
    lQry.ParamByName('ID').Value := vIConexao.Generetor('GEN_PRECOVENDA');
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
    lQry.ParamByName('ID').Value := ifThen(pPrecoVendaModel.ID = '', Unassigned, pPrecoVendaModel.ID);
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPrecoVendasLista := TObjectList<TPrecoVendaModel>.Create;

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

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPrecoVendasLista.Add(TPrecoVendaModel.Create(vIConexao));

      i := FPrecoVendasLista.Count -1;

      FPrecoVendasLista[i].ID                 := lQry.FieldByName('ID').AsString;
      FPrecoVendasLista[i].NOME               := lQry.FieldByName('NOME').AsString;
      FPrecoVendasLista[i].ACRESCIMO_DESCONTO := lQry.FieldByName('ACRESCIMO_DESCONTO').AsString;
      FPrecoVendasLista[i].PERCENTUAL         := lQry.FieldByName('PERCENTUAL').AsString;
      FPrecoVendasLista[i].STATUS             := lQry.FieldByName('STATUS').AsString;
      FPrecoVendasLista[i].SYSTIME            := lQry.FieldByName('SYSTIME').AsString;
      FPrecoVendasLista[i].TIPO_CUSTO         := lQry.FieldByName('TIPO_CUSTO').AsString;
      FPrecoVendasLista[i].CONDICOES          := lQry.FieldByName('CONDICOES').AsString;
      FPrecoVendasLista[i].PRODUTOS_IGNORAR   := lQry.FieldByName('PRODUTOS_IGNORAR').AsString;

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

procedure TPrecoVendaDao.SetPrecoVendasLista(const Value: TObjectList<TPrecoVendaModel>);
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
begin
  pQry.ParamByName('NOME').Value                 := ifThen(pPrecoVendaModel.NOME                = '', Unassigned, pPrecoVendaModel.NOME);
  pQry.ParamByName('ACRESCIMO_DESCONTO').Value   := ifThen(pPrecoVendaModel.ACRESCIMO_DESCONTO  = '', Unassigned, pPrecoVendaModel.ACRESCIMO_DESCONTO);
  pQry.ParamByName('PERCENTUAL').Value           := ifThen(pPrecoVendaModel.PERCENTUAL          = '', Unassigned, pPrecoVendaModel.PERCENTUAL);
  pQry.ParamByName('STATUS').Value               := ifThen(pPrecoVendaModel.STATUS              = '', Unassigned, pPrecoVendaModel.STATUS);
  pQry.ParamByName('TIPO_CUSTO').Value           := ifThen(pPrecoVendaModel.TIPO_CUSTO          = '', Unassigned, pPrecoVendaModel.TIPO_CUSTO);
  pQry.ParamByName('CONDICOES').Value            := ifThen(pPrecoVendaModel.CONDICOES           = '', Unassigned, pPrecoVendaModel.CONDICOES);
  pQry.ParamByName('PRODUTOS_IGNORAR').Value     := ifThen(pPrecoVendaModel.PRODUTOS_IGNORAR    = '', Unassigned, pPrecoVendaModel.PRODUTOS_IGNORAR);
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
