unit FuncionarioDao;

interface

uses
  FuncionarioModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TFuncionarioDao = class

  private
    vIConexao : IConexao;
    FFuncionariosLista: TObjectList<TFuncionarioModel>;
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
    procedure SetFuncionariosLista(const Value: TObjectList<TFuncionarioModel>);
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

    property FuncionariosLista: TObjectList<TFuncionarioModel> read FFuncionariosLista write SetFuncionariosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    procedure obterLista;

    function comissaoVendedor(pIdVendedor, pIdTipoComissao: String): Double;
end;

implementation

{ TFuncionario }

function TFuncionarioDao.comissaoVendedor(pIdVendedor, pIdTipoComissao: String): Double;
var
  lQry: TFDQuery;
  lSQL: String;
begin
  try
    lQry     := vIConexao.CriarQuery;

    lSql := '  select distinct coalesce(comissao, 0) comissao  '+
            '    from comissao_vendedor                        '+
            '   where 1=1                                      ';

    lSql := lSql + ' and vendedor   = '+ QuotedStr(pIdVendedor);
    lSql := lSql + ' and tipo_venda = '+ QuotedStr(pIdTipoComissao);

    lQry.Open(lSQL);

    Result := lQry.FieldByName('comissao').AsFloat;

  finally
    lQry.Free;
  end;

end;

constructor TFuncionarioDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFuncionarioDao.Destroy;
begin

  inherited;
end;

function TFuncionarioDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and funcionario.codigo_fun = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TFuncionarioDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From funcionario where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TFuncionarioDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FFuncionariosLista := TObjectList<TFuncionarioModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       funcionario.codigo_fun,     '+
      '       funcionario.nome_fun,       '+
      '       funcionario.gerente_id,     '+
      '       funcionario.tipo_comissao   '+
	    '  from funcionario                 '+
      ' where 1=1                         ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FFuncionariosLista.Add(TFuncionarioModel.Create(vIConexao));

      i := FFuncionariosLista.Count -1;

      FFuncionariosLista[i].CODIGO_FUN       := lQry.FieldByName('CODIGO_FUN').AsString;
      FFuncionariosLista[i].NOME_FUN         := lQry.FieldByName('NOME_FUN').AsString;
      FFuncionariosLista[i].GERENTE_ID       := lQry.FieldByName('GERENTE_ID').AsString;
      FFuncionariosLista[i].TIPO_COMISSAO    := lQry.FieldByName('TIPO_COMISSAO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TFuncionarioDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFuncionarioDao.SetFuncionariosLista(const Value: TObjectList<TFuncionarioModel>);
begin
  FFuncionariosLista := Value;
end;

procedure TFuncionarioDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TFuncionarioDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TFuncionarioDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFuncionarioDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFuncionarioDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFuncionarioDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFuncionarioDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
