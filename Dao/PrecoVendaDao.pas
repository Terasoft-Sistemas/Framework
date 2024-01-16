unit PrecoVendaDao;

interface

uses
  PrecoVendaModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants;

type
  TPrecoVendaDao = class

  private
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

    function montaCondicaoQuery: String;

  public
    constructor Create;
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

    function incluir(APrecoVendaModel: TPrecoVendaModel): String;
    function alterar(APrecoVendaModel: TPrecoVendaModel): String;
    function excluir(APrecoVendaModel: TPrecoVendaModel): String;
	
    procedure obterLista;

end;

implementation

{ TPrecoVenda }

uses VariaveisGlobais;

constructor TPrecoVendaDao.Create;
begin

end;

destructor TPrecoVendaDao.Destroy;
begin

  inherited;
end;

function TPrecoVendaDao.incluir(APrecoVendaModel: TPrecoVendaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

end;

function TPrecoVendaDao.alterar(APrecoVendaModel: TPrecoVendaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

end;

function TPrecoVendaDao.excluir(APrecoVendaModel: TPrecoVendaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := xConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from preco_venda where ID = :ID',[APrecoVendaModel.ID]);
   lQry.ExecSQL;
   Result := APrecoVendaModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPrecoVendaDao.montaCondicaoQuery: String;
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
    lQry := xConexao.CriarQuery;

    lSql := 'select count(*) records From preco_venda where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

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
  lQry := xConexao.CriarQuery;

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

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPrecoVendasLista.Add(TPrecoVendaModel.Create);

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
