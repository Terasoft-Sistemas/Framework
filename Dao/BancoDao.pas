unit BancoDao;

interface

uses
  BancoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TBancoDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

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
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    const
      NomeTabela = 'Banco';

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pBancoModel: TBancoModel): String;
    function alterar(pBancoModel: TBancoModel): String;
    function excluir(pBancoModel: TBancoModel): String;

    function carregaClasse(pID : String): TBancoModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pBancoModel: TBancoModel);

end;

implementation

uses
  System.Rtti;

{ TBanco }

function TBancoDao.carregaClasse(pID : String): TBancoModel;
var
  lQry: TFDQuery;
  lModel: TBancoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TBancoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from Banco where NUMERO_BAN = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_BAN                       := lQry.FieldByName('NUMERO_BAN').AsString;
    lModel.NOME_BAN                         := lQry.FieldByName('NOME_BAN').AsString;
    lModel.AGENCIA_BAN                      := lQry.FieldByName('AGENCIA_BAN').AsString;
    lModel.CONTA_BAN                        := lQry.FieldByName('CONTA_BAN').AsString;
    lModel.CONTATO_BAN                      := lQry.FieldByName('CONTATO_BAN').AsString;
    lModel.TELEFONE_BAN                     := lQry.FieldByName('TELEFONE_BAN').AsString;
    lModel.USUARIO_BAN                      := lQry.FieldByName('USUARIO_BAN').AsString;
    lModel.DIGAGENCIA_BAN                   := lQry.FieldByName('DIGAGENCIA_BAN').AsString;
    lModel.DIGCONTA_BAN                     := lQry.FieldByName('DIGCONTA_BAN').AsString;
    lModel.NUM_BAN                          := lQry.FieldByName('NUM_BAN').AsString;
    lModel.CODIGO_CEDENTE                   := lQry.FieldByName('CODIGO_CEDENTE').AsString;
    lModel.LICENCA                          := lQry.FieldByName('LICENCA').AsString;
    lModel.LAYOUT_RETORNO                   := lQry.FieldByName('LAYOUT_RETORNO').AsString;
    lModel.LAYOUT_REMESSA                   := lQry.FieldByName('LAYOUT_REMESSA').AsString;
    lModel.CAMINHO_RETORNO                  := lQry.FieldByName('CAMINHO_RETORNO').AsString;
    lModel.CAMINHO_REMESSA                  := lQry.FieldByName('CAMINHO_REMESSA').AsString;
    lModel.LIMITE_BAN                       := lQry.FieldByName('LIMITE_BAN').AsString;
    lModel.ID                               := lQry.FieldByName('ID').AsString;
    lModel.VALOR_BOLETO                     := lQry.FieldByName('VALOR_BOLETO').AsString;
    lModel.DESPESA_BOLETO_CONTA_ID          := lQry.FieldByName('DESPESA_BOLETO_CONTA_ID').AsString;
    lModel.CODIGO_CEDENTE2                  := lQry.FieldByName('CODIGO_CEDENTE2').AsString;
    lModel.OUTRAS_CONFIGURACOES             := lQry.FieldByName('OUTRAS_CONFIGURACOES').AsString;
    lModel.LOJA                             := lQry.FieldByName('LOJA').AsString;
    lModel.TIPO_IMPRESSAO                   := lQry.FieldByName('TIPO_IMPRESSAO').AsString;
    lModel.LIMITE_TROCA                     := lQry.FieldByName('LIMITE_TROCA').AsString;
    lModel.STATUS                           := lQry.FieldByName('STATUS').AsString;
    lModel.OUTRAS_CONFIGURACOES2            := lQry.FieldByName('OUTRAS_CONFIGURACOES2').AsString;
    lModel.DIAS_PROTESTO_DEVOLUCAO          := lQry.FieldByName('DIAS_PROTESTO_DEVOLUCAO').AsString;
    lModel.CODIGO_PROTESTO_DEVOLUCAO        := lQry.FieldByName('CODIGO_PROTESTO_DEVOLUCAO').AsString;
    lModel.CONTA_APLICACAO                  := lQry.FieldByName('CONTA_APLICACAO').AsString;
    lModel.LOCAL_PAGAMENTO                  := lQry.FieldByName('LOCAL_PAGAMENTO').AsString;
    lModel.BANCO_REFERENTE                  := lQry.FieldByName('BANCO_REFERENTE').AsString;
    lModel.DETALHAMENTO_REMESSA             := lQry.FieldByName('DETALHAMENTO_REMESSA').AsString;
    lModel.URL_ATUALIZACAO_BOLETO           := lQry.FieldByName('URL_ATUALIZACAO_BOLETO').AsString;
    lModel.ATUALIZAR_BOLETO                 := lQry.FieldByName('ATUALIZAR_BOLETO').AsString;
    lModel.DRG                              := lQry.FieldByName('DRG').AsString;
    lModel.PERSONALIZACAO_BOLETO            := lQry.FieldByName('PERSONALIZACAO_BOLETO').AsString;
    lModel.SEQUENCIA_REMESSA_PAGAMENTO      := lQry.FieldByName('SEQUENCIA_REMESSA_PAGAMENTO').AsString;
    lModel.CODIGO_CONVENIO_PAGAMENTO        := lQry.FieldByName('CODIGO_CONVENIO_PAGAMENTO').AsString;
    lModel.CAMINHO_RETORNO_PAGAMENTO        := lQry.FieldByName('CAMINHO_RETORNO_PAGAMENTO').AsString;
    lModel.CAMINHO_REMESSA_PAGAMENTO        := lQry.FieldByName('CAMINHO_REMESSA_PAGAMENTO').AsString;
    lModel.CONTA_JUROS_ANTECIPACAO          := lQry.FieldByName('CONTA_JUROS_ANTECIPACAO').AsString;
    lModel.CONTA_IOF_ANTECIPACAO            := lQry.FieldByName('CONTA_IOF_ANTECIPACAO').AsString;
    lModel.CONTA_ESTORNO_ANTECIPACAO        := lQry.FieldByName('CONTA_ESTORNO_ANTECIPACAO').AsString;
    lModel.SYSTIME                          := lQry.FieldByName('SYSTIME').AsString;
    lModel.TIPO_COBRANCA                    := lQry.FieldByName('TIPO_COBRANCA').AsString;
    lModel.DEVELOPER_APPLICATION_KEY        := lQry.FieldByName('DEVELOPER_APPLICATION_KEY').AsString;
    lModel.CLIENT_ID                        := lQry.FieldByName('CLIENT_ID').AsString;
    lModel.CLIENT_SECRET                    := lQry.FieldByName('CLIENT_SECRET').AsString;
    lModel.LOG                              := lQry.FieldByName('LOG').AsString;
    lModel.FANTASIA                         := lQry.FieldByName('FANTASIA').AsString;
    lModel.RAZAO                            := lQry.FieldByName('RAZAO').AsString;
    lModel.CNPJ                             := lQry.FieldByName('CNPJ').AsString;
    lModel.ENDERECO                         := lQry.FieldByName('ENDERECO').AsString;
    lModel.BAIRRO                           := lQry.FieldByName('BAIRRO').AsString;
    lModel.CIDADE                           := lQry.FieldByName('CIDADE').AsString;
    lModel.UF                               := lQry.FieldByName('UF').AsString;
    lModel.CEP                              := lQry.FieldByName('CEP').AsString;
    lModel.TELEFONE                         := lQry.FieldByName('TELEFONE').AsString;
    lModel.TIPO_EMITENTE                    := lQry.FieldByName('TIPO_EMITENTE').AsString;
    lModel.INDICADORPIX                     := lQry.FieldByName('INDICADORPIX').AsString;
    lModel.CONVENIO                         := lQry.FieldByName('CONVENIO').AsString;
    lModel.MODALIDADE                       := lQry.FieldByName('MODALIDADE').AsString;
    lModel.CODIGOTRANSMISSAO                := lQry.FieldByName('CODIGOTRANSMISSAO').AsString;
    lModel.SCOPE                            := lQry.FieldByName('SCOPE').AsString;
    lModel.CARACTERISTICA_TITULO            := lQry.FieldByName('CARACTERISTICA_TITULO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TBancoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TBancoDao.Destroy;
begin
  inherited;
end;

function TBancoDao.incluir(pBancoModel: TBancoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('BANCO', 'NUMERO_BAN', true);

  try
    lQry.SQL.Add(lSQL);
    pBancoModel.NUMERO_BAN := vIConexao.Generetor('GEN_BANCO_ID');
    setParams(lQry, pBancoModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_BAN').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TBancoDao.alterar(pBancoModel: TBancoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('BANCO','NUMERO_BAN');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pBancoModel);
    lQry.ExecSQL;

    Result := pBancoModel.NUMERO_BAN;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TBancoDao.excluir(pBancoModel: TBancoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from BANCO where NUMERO_BAN = :NUMERO_BAN' ,[pBancoModel.ID]);
   lQry.ExecSQL;
   Result := pBancoModel.ID;

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
    lSQL := lSQL + ' and NUMERO_BAN = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TBancoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From BANCO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TBancoDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+' * from BANCO where 1=1 '+SLineBreak;


    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TBancoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
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
begin
  vConstrutor.setParams(NomeTabela,pQry,pBancoModel);
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
