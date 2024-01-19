unit BancoDao;

interface

uses
  BancoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TBancoDao = class

  private
    vIConexao : Iconexao;
    vConstrutor : TConstrutorDao;

    FBancosLista: TObjectList<TBancoModel>;
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
    procedure SetBancosLista(const Value: TObjectList<TBancoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao : Iconexao);
    destructor Destroy; override;

    property BancosLista: TObjectList<TBancoModel> read FBancosLista write SetBancosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ABancoModel: TBancoModel): String;
    function alterar(ABancoModel: TBancoModel): String;
    function excluir(ABancoModel: TBancoModel): String;
	
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pBancoModel: TBancoModel);

end;

implementation

uses
  System.Rtti;

{ TBanco }

constructor TBancoDao.Create(pIConexao : Iconexao);
begin
  vIconexao := pIconexao;
  vConstrutor := TConstrutorDao.Create(vIconexao);
end;

destructor TBancoDao.Destroy;
begin

  inherited;
end;

function TBancoDao.incluir(ABancoModel: TBancoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('BANCO', 'ID', True);

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('NUMERO_BAN').Value := vIconexao.Generetor('GEN_BANCO');
    setParams(lQry, ABancoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TBancoDao.alterar(ABancoModel: TBancoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('BANCO','ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('NUMERO_BAN').Value := ABancoModel.numero_ban;
    setParams(lQry, ABancoModel);
    lQry.ExecSQL;

    Result := ABancoModel.ID;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

function TBancoDao.excluir(ABancoModel: TBancoModel): String;
var
  lQry: TFDQuery;

begin

  lQry := vIconexao.CriarQuery;

  try
   lQry.ExecSQL('delete from BANCO where ID = :ID',[ABancoModel.ID]);
   lQry.ExecSQL;
   Result := ABancoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TBancoDao.where: String;
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

procedure TBancoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;

begin
  try

    lQry := vIconexao.CriarQuery;

    lSql := 'select count(*) records from BANCO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TBancoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;

begin

  lQry := vIconexao.CriarQuery;

  FBancosLista := TObjectList<TBancoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       banco.*           '+
	    '  from banco             '+
      ' where 1=1               ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FBancosLista.Add(TBancoModel.Create(vIConexao));

      i := FBancosLista.Count -1;

      FBancosLista[i].NUMERO_BAN                    := lQry.FieldByName('NUMERO_BAN').AsString;
      FBancosLista[i].NOME_BAN                      := lQry.FieldByName('NOME_BAN').AsString;
      FBancosLista[i].AGENCIA_BAN                   := lQry.FieldByName('AGENCIA_BAN').AsString;
      FBancosLista[i].CONTA_BAN                     := lQry.FieldByName('CONTA_BAN').AsString;
      FBancosLista[i].CONTATO_BAN                   := lQry.FieldByName('CONTATO_BAN').AsString;
      FBancosLista[i].TELEFONE_BAN                  := lQry.FieldByName('TELEFONE_BAN').AsString;
      FBancosLista[i].USUARIO_BAN                   := lQry.FieldByName('USUARIO_BAN').AsString;
      FBancosLista[i].DIGAGENCIA_BAN                := lQry.FieldByName('DIGAGENCIA_BAN').AsString;
      FBancosLista[i].DIGCONTA_BAN                  := lQry.FieldByName('DIGCONTA_BAN').AsString;
      FBancosLista[i].NUM_BAN                       := lQry.FieldByName('NUM_BAN').AsString;
      FBancosLista[i].CODIGO_CEDENTE                := lQry.FieldByName('CODIGO_CEDENTE').AsString;
      FBancosLista[i].LICENCA                       := lQry.FieldByName('LICENCA').AsString;
      FBancosLista[i].LAYOUT_RETORNO                := lQry.FieldByName('LAYOUT_RETORNO').AsString;
      FBancosLista[i].LAYOUT_REMESSA                := lQry.FieldByName('LAYOUT_REMESSA').AsString;
      FBancosLista[i].CAMINHO_RETORNO               := lQry.FieldByName('CAMINHO_RETORNO').AsString;
      FBancosLista[i].CAMINHO_REMESSA               := lQry.FieldByName('CAMINHO_REMESSA').AsString;
      FBancosLista[i].LIMITE_BAN                    := lQry.FieldByName('LIMITE_BAN').AsString;
      FBancosLista[i].ID                            := lQry.FieldByName('ID').AsString;
      FBancosLista[i].VALOR_BOLETO                  := lQry.FieldByName('VALOR_BOLETO').AsString;
      FBancosLista[i].DESPESA_BOLETO_CONTA_ID       := lQry.FieldByName('DESPESA_BOLETO_CONTA_ID').AsString;
      FBancosLista[i].CODIGO_CEDENTE2               := lQry.FieldByName('CODIGO_CEDENTE2').AsString;
      FBancosLista[i].OUTRAS_CONFIGURACOES          := lQry.FieldByName('OUTRAS_CONFIGURACOES').AsString;
      FBancosLista[i].LOJA                          := lQry.FieldByName('LOJA').AsString;
      FBancosLista[i].TIPO_IMPRESSAO                := lQry.FieldByName('TIPO_IMPRESSAO').AsString;
      FBancosLista[i].LIMITE_TROCA                  := lQry.FieldByName('LIMITE_TROCA').AsString;
      FBancosLista[i].STATUS                        := lQry.FieldByName('STATUS').AsString;
      FBancosLista[i].OUTRAS_CONFIGURACOES2         := lQry.FieldByName('OUTRAS_CONFIGURACOES2').AsString;
      FBancosLista[i].DIAS_PROTESTO_DEVOLUCAO       := lQry.FieldByName('DIAS_PROTESTO_DEVOLUCAO').AsString;
      FBancosLista[i].CODIGO_PROTESTO_DEVOLUCAO     := lQry.FieldByName('CODIGO_PROTESTO_DEVOLUCAO').AsString;
      FBancosLista[i].CONTA_APLICACAO               := lQry.FieldByName('CONTA_APLICACAO').AsString;
      FBancosLista[i].LOCAL_PAGAMENTO               := lQry.FieldByName('LOCAL_PAGAMENTO').AsString;
      FBancosLista[i].BANCO_REFERENTE               := lQry.FieldByName('BANCO_REFERENTE').AsString;
      FBancosLista[i].DETALHAMENTO_REMESSA          := lQry.FieldByName('DETALHAMENTO_REMESSA').AsString;
      FBancosLista[i].URL_ATUALIZACAO_BOLETO        := lQry.FieldByName('URL_ATUALIZACAO_BOLETO').AsString;
      FBancosLista[i].ATUALIZAR_BOLETO              := lQry.FieldByName('ATUALIZAR_BOLETO').AsString;
      FBancosLista[i].DRG                           := lQry.FieldByName('DRG').AsString;
      FBancosLista[i].PERSONALIZACAO_BOLETO         := lQry.FieldByName('PERSONALIZACAO_BOLETO').AsString;
      FBancosLista[i].SEQUENCIA_REMESSA_PAGAMENTO   := lQry.FieldByName('SEQUENCIA_REMESSA_PAGAMENTO').AsString;
      FBancosLista[i].CODIGO_CONVENIO_PAGAMENTO     := lQry.FieldByName('CODIGO_CONVENIO_PAGAMENTO').AsString;
      FBancosLista[i].CAMINHO_RETORNO_PAGAMENTO     := lQry.FieldByName('CAMINHO_RETORNO_PAGAMENTO').AsString;
      FBancosLista[i].CAMINHO_REMESSA_PAGAMENTO     := lQry.FieldByName('CAMINHO_REMESSA_PAGAMENTO').AsString;
      FBancosLista[i].CONTA_JUROS_ANTECIPACAO       := lQry.FieldByName('CONTA_JUROS_ANTECIPACAO').AsString;
      FBancosLista[i].CONTA_IOF_ANTECIPACAO         := lQry.FieldByName('CONTA_IOF_ANTECIPACAO').AsString;
      FBancosLista[i].CONTA_ESTORNO_ANTECIPACAO     := lQry.FieldByName('CONTA_ESTORNO_ANTECIPACAO').AsString;
      FBancosLista[i].SYSTIME                       := lQry.FieldByName('SYSTIME').AsString;
      FBancosLista[i].TIPO_COBRANCA                 := lQry.FieldByName('TIPO_COBRANCA').AsString;
      FBancosLista[i].DEVELOPER_APPLICATION_KEY     := lQry.FieldByName('DEVELOPER_APPLICATION_KEY').AsString;
      FBancosLista[i].CLIENT_ID                     := lQry.FieldByName('CLIENT_ID').AsString;
      FBancosLista[i].CLIENT_SECRET                 := lQry.FieldByName('CLIENT_SECRET').AsString;
      FBancosLista[i].FANTASIA                      := lQry.FieldByName('FANTASIA').AsString;
      FBancosLista[i].RAZAO                         := lQry.FieldByName('RAZAO').AsString;
      FBancosLista[i].CNPJ                          := lQry.FieldByName('CNPJ').AsString;
      FBancosLista[i].ENDERECO                      := lQry.FieldByName('ENDERECO').AsString;
      FBancosLista[i].BAIRRO                        := lQry.FieldByName('BAIRRO').AsString;
      FBancosLista[i].CIDADE                        := lQry.FieldByName('CIDADE').AsString;
      FBancosLista[i].UF                            := lQry.FieldByName('UF').AsString;
      FBancosLista[i].CEP                           := lQry.FieldByName('CEP').AsString;
      FBancosLista[i].TELEFONE                      := lQry.FieldByName('TELEFONE').AsString;
      FBancosLista[i].TIPO_EMITENTE                 := lQry.FieldByName('TIPO_EMITENTE').AsString;
      FBancosLista[i].INDICADORPIX                  := lQry.FieldByName('INDICADORPIX').AsString;
      FBancosLista[i].CONVENIO                      := lQry.FieldByName('CONVENIO').AsString;
      FBancosLista[i].MODALIDADE                    := lQry.FieldByName('MODALIDADE').AsString;
      FBancosLista[i].CODIGOTRANSMISSAO             := lQry.FieldByName('CODIGOTRANSMISSAO').AsString;
      FBancosLista[i].SCOPE                         := lQry.FieldByName('SCOPE').AsString;
      FBancosLista[i].CARACTERISTICA_TITULO         := lQry.FieldByName('CARACTERISTICA_TITULO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TBancoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TBancoDao.SetBancosLista(const Value: TObjectList<TBancoModel>);
begin
  FBancosLista := Value;
end;

procedure TBancoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TBancoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TBancoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TBancoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TBancoDao.setParams(var pQry: TFDQuery; pBancoModel: TBancoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('BANCO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TBancoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pBancoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pBancoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TBancoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TBancoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TBancoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
