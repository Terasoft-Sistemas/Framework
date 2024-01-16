unit PromocaoItensDao;

interface

uses
  PromocaoItensModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants;

type
  TPromocaoItensDao = class

  private
    FPromocaoItenssLista: TObjectList<TPromocaoItensModel>;
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
    procedure SetPromocaoItenssLista(const Value: TObjectList<TPromocaoItensModel>);
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

    property PromocaoItenssLista: TObjectList<TPromocaoItensModel> read FPromocaoItenssLista write SetPromocaoItenssLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(APromocaoItensModel: TPromocaoItensModel): String;
    function alterar(APromocaoItensModel: TPromocaoItensModel): String;
    function excluir(APromocaoItensModel: TPromocaoItensModel): String;
	
    procedure obterLista;

end;

implementation

{ TPromocaoItens }

uses VariaveisGlobais;

constructor TPromocaoItensDao.Create;
begin

end;

destructor TPromocaoItensDao.Destroy;
begin

  inherited;
end;

function TPromocaoItensDao.incluir(APromocaoItensModel: TPromocaoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

end;

function TPromocaoItensDao.alterar(APromocaoItensModel: TPromocaoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

end;

function TPromocaoItensDao.excluir(APromocaoItensModel: TPromocaoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := xConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from promocaoitens where ID = :ID',[APromocaoItensModel.ID]);
   lQry.ExecSQL;
   Result := APromocaoItensModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPromocaoItensDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and promocaoitens.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TPromocaoItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := xConexao.CriarQuery;

    lSql := '  select count(*) records                                         '+
            '    From promocaoitens                                            '+
            '   inner join promocao on promocaoitens.promocao_id = promocao.id '+
            '   where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPromocaoItensDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := xConexao.CriarQuery;

  FPromocaoItenssLista := TObjectList<TPromocaoItensModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       promocaoitens.valor_promocao                             '+
      '       from promocaoitens                                       '+
      ' inner join promocao on promocaoitens.promocao_id = promocao.id '+
      ' where 1=1                                                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPromocaoItenssLista.Add(TPromocaoItensModel.Create);

      i := FPromocaoItenssLista.Count -1;

      FPromocaoItenssLista[i].VALOR_PROMOCAO := lQry.FieldByName('VALOR_PROMOCAO').AsString;
      
      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPromocaoItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPromocaoItensDao.SetPromocaoItenssLista(const Value: TObjectList<TPromocaoItensModel>);
begin
  FPromocaoItenssLista := Value;
end;

procedure TPromocaoItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPromocaoItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPromocaoItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPromocaoItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPromocaoItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPromocaoItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPromocaoItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
