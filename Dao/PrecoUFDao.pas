unit PrecoUFDao;

interface

uses
  PrecoUFModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TPrecoUFDao = class

  private
    vIConexao : IConexao;
    FPrecoUFsLista: TObjectList<TPrecoUFModel>;
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
    procedure SetPrecoUFsLista(const Value: TObjectList<TPrecoUFModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;

  public
    constructor Create(pIConexao : IConexao;);
    destructor Destroy; override;

    property PrecoUFsLista: TObjectList<TPrecoUFModel> read FPrecoUFsLista write SetPrecoUFsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(APrecoUFModel: TPrecoUFModel): String;
    function alterar(APrecoUFModel: TPrecoUFModel): String;
    function excluir(APrecoUFModel: TPrecoUFModel): String;
	
    procedure obterLista;

end;

implementation

{ TPrecoUF }

constructor TPrecoUFDao.Create(pIConexao : IConexao;);
begin
  vIConexao := pIConexao;
end;

destructor TPrecoUFDao.Destroy;
begin

  inherited;
end;

function TPrecoUFDao.incluir(APrecoUFModel: TPrecoUFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
 
end;

function TPrecoUFDao.alterar(APrecoUFModel: TPrecoUFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  
end;

function TPrecoUFDao.excluir(APrecoUFModel: TPrecoUFModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from preco_uf where ID = :ID',[APrecoUFModel.ID]);
   lQry.ExecSQL;
   Result := APrecoUFModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPrecoUFDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and preco_uf.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TPrecoUFDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From preco_uf where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPrecoUFDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPrecoUFsLista := TObjectList<TPrecoUFModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       preco_uf.*,                                              '+
      '       produto.customedio_pro,                                  '+
      '       produto.margem_pro                                       '+
	    '  from preco_uf                                                 '+
      ' inner join produto on preco_uf.produto_id = produto.codigo_pro '+
      ' where 1=1                                                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPrecoUFsLista.Add(TPrecoUFModel.Create);

      i := FPrecoUFsLista.Count -1;

      FPrecoUFsLista[i].ID         := lQry.FieldByName('ID').AsString;
      FPrecoUFsLista[i].PRODUTO_ID := lQry.FieldByName('PRODUTO_ID').AsString;
      FPrecoUFsLista[i].UF         := lQry.FieldByName('UF').AsString;
      FPrecoUFsLista[i].COMISSAO   := lQry.FieldByName('COMISSAO').AsString;
      FPrecoUFsLista[i].SIMPLES    := lQry.FieldByName('SIMPLES').AsString;
      FPrecoUFsLista[i].ICMS_ST    := lQry.FieldByName('ICMS_ST').AsString;
      FPrecoUFsLista[i].SYSTIME    := lQry.FieldByName('SYSTIME').AsString;

      FPrecoUFsLista[i].TOTAL      := (lQry.FieldByName('CUSTOMEDIO_PRO').AsFloat * lQry.FieldByName('MARGEM_PRO').AsFloat / 100 + lQry.FieldByName('CUSTOMEDIO_PRO').AsFloat) /
                                      ( (100 - (lQry.FieldByName('COMISSAO').AsFloat + lQry.FieldByName('SIMPLES').AsFloat + lQry.FieldByName('ICMS_ST').AsFloat) ) / 100);

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPrecoUFDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPrecoUFDao.SetPrecoUFsLista(const Value: TObjectList<TPrecoUFModel>);
begin
  FPrecoUFsLista := Value;
end;

procedure TPrecoUFDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPrecoUFDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPrecoUFDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPrecoUFDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoUFDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPrecoUFDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPrecoUFDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
