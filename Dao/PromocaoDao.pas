unit PromocaoDao;

interface

uses
  PromocaoModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TPromocaoDao = class

  private
    vIConexao : IConexao;
    FPromocaosLista: TObjectList<TPromocaoModel>;
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
    procedure SetPromocaosLista(const Value: TObjectList<TPromocaoModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property PromocaosLista: TObjectList<TPromocaoModel> read FPromocaosLista write SetPromocaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(APromocaoModel: TPromocaoModel): String;
    function alterar(APromocaoModel: TPromocaoModel): String;
    function excluir(APromocaoModel: TPromocaoModel): String;

    procedure obterLista;

end;

implementation

{ TPromocao }

constructor TPromocaoDao.Create(vIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPromocaoDao.Destroy;
begin

  inherited;
end;

function TPromocaoDao.incluir(APromocaoModel: TPromocaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

end;

function TPromocaoDao.alterar(APromocaoModel: TPromocaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

end;

function TPromocaoDao.excluir(APromocaoModel: TPromocaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from promocao where ID = :ID',[APromocaoModel.ID]);
   lQry.ExecSQL;
   Result := APromocaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPromocaoDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and promocao.id = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TPromocaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From promocao where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPromocaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPromocaosLista := TObjectList<TPromocaoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
    '       promocao.*           '+
	  '  from promocao             '+
    ' where 1=1                  ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPromocaosLista.Add(TPromocaoModel.Create);

      i := FPromocaosLista.Count -1;

      FPromocaosLista[i].ID              := lQry.FieldByName('ID').AsString;
      FPromocaosLista[i].DESCRICAO       := lQry.FieldByName('DESCRICAO').AsString;
      FPromocaosLista[i].DATA            := lQry.FieldByName('DATA').AsString;
      FPromocaosLista[i].DATAINICIO      := lQry.FieldByName('DATAINICIO').AsString;
      FPromocaosLista[i].DATAFIM         := lQry.FieldByName('DATAFIM').AsString;
      FPromocaosLista[i].CLIENTE_ID      := lQry.FieldByName('CLIENTE_ID').AsString;
      FPromocaosLista[i].PRECO_VENDA_ID  := lQry.FieldByName('PRECO_VENDA_ID').AsString;
      FPromocaosLista[i].HORAINICIO      := lQry.FieldByName('HORAINICIO').AsString;
      FPromocaosLista[i].HORAFIM         := lQry.FieldByName('HORAFIM').AsString;
      FPromocaosLista[i].DOMINGO         := lQry.FieldByName('DOMINGO').AsString;
      FPromocaosLista[i].SEGUNDA         := lQry.FieldByName('SEGUNDA').AsString;
      FPromocaosLista[i].TERCA           := lQry.FieldByName('TERCA').AsString;
      FPromocaosLista[i].QUARTA          := lQry.FieldByName('QUARTA').AsString;
      FPromocaosLista[i].QUINTA          := lQry.FieldByName('QUINTA').AsString;
      FPromocaosLista[i].SEXTA           := lQry.FieldByName('SEXTA').AsString;
      FPromocaosLista[i].SABADO          := lQry.FieldByName('SABADO').AsString;
      FPromocaosLista[i].PORTADOR_ID     := lQry.FieldByName('PORTADOR_ID').AsString;
      FPromocaosLista[i].LOJA            := lQry.FieldByName('LOJA').AsString;
      FPromocaosLista[i].TIPO_ABATIMENTO := lQry.FieldByName('TIPO_ABATIMENTO').AsString;
      FPromocaosLista[i].SYSTIME         := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPromocaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPromocaoDao.SetPromocaosLista(const Value: TObjectList<TPromocaoModel>);
begin
  FPromocaosLista := Value;
end;

procedure TPromocaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPromocaoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPromocaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPromocaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPromocaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPromocaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPromocaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
