unit BancoDao;

interface

uses
  BancoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TBancoDao = class;
  ITBancoDao = IObject<TBancoDao>;

  TBancoDao = class
  private
    [unsafe] mySelf: ITBancoDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

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

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITBancoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pBancoModel: ITBancoModel): String;
    function alterar(pBancoModel: ITBancoModel): String;
    function excluir(pBancoModel: ITBancoModel): String;

    function carregaClasse(pID : String): ITBancoModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pBancoModel: ITBancoModel);

end;

implementation

uses
  System.Rtti;

{ TBanco }

function TBancoDao.carregaClasse(pID : String): ITBancoModel;
var
  lQry: TFDQuery;
  lModel: ITBancoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TBancoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from Banco where NUMERO_BAN = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_BAN                       := lQry.FieldByName('NUMERO_BAN').AsString;
    lModel.objeto.NOME_BAN                         := lQry.FieldByName('NOME_BAN').AsString;
    lModel.objeto.AGENCIA_BAN                      := lQry.FieldByName('AGENCIA_BAN').AsString;
    lModel.objeto.CONTA_BAN                        := lQry.FieldByName('CONTA_BAN').AsString;
    lModel.objeto.CONTATO_BAN                      := lQry.FieldByName('CONTATO_BAN').AsString;
    lModel.objeto.TELEFONE_BAN                     := lQry.FieldByName('TELEFONE_BAN').AsString;
    lModel.objeto.USUARIO_BAN                      := lQry.FieldByName('USUARIO_BAN').AsString;
    lModel.objeto.DIGAGENCIA_BAN                   := lQry.FieldByName('DIGAGENCIA_BAN').AsString;
    lModel.objeto.DIGCONTA_BAN                     := lQry.FieldByName('DIGCONTA_BAN').AsString;
    lModel.objeto.NUM_BAN                          := lQry.FieldByName('NUM_BAN').AsString;
    lModel.objeto.CODIGO_CEDENTE                   := lQry.FieldByName('CODIGO_CEDENTE').AsString;
    lModel.objeto.LICENCA                          := lQry.FieldByName('LICENCA').AsString;
    lModel.objeto.LAYOUT_RETORNO                   := lQry.FieldByName('LAYOUT_RETORNO').AsString;
    lModel.objeto.LAYOUT_REMESSA                   := lQry.FieldByName('LAYOUT_REMESSA').AsString;
    lModel.objeto.CAMINHO_RETORNO                  := lQry.FieldByName('CAMINHO_RETORNO').AsString;
    lModel.objeto.CAMINHO_REMESSA                  := lQry.FieldByName('CAMINHO_REMESSA').AsString;
    lModel.objeto.LIMITE_BAN                       := lQry.FieldByName('LIMITE_BAN').AsString;
    lModel.objeto.ID                               := lQry.FieldByName('ID').AsString;
    lModel.objeto.VALOR_BOLETO                     := lQry.FieldByName('VALOR_BOLETO').AsString;
    lModel.objeto.DESPESA_BOLETO_CONTA_ID          := lQry.FieldByName('DESPESA_BOLETO_CONTA_ID').AsString;
    lModel.objeto.CODIGO_CEDENTE2                  := lQry.FieldByName('CODIGO_CEDENTE2').AsString;
    lModel.objeto.OUTRAS_CONFIGURACOES             := lQry.FieldByName('OUTRAS_CONFIGURACOES').AsString;
    lModel.objeto.LOJA                             := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.TIPO_IMPRESSAO                   := lQry.FieldByName('TIPO_IMPRESSAO').AsString;
    lModel.objeto.LIMITE_TROCA                     := lQry.FieldByName('LIMITE_TROCA').AsString;
    lModel.objeto.STATUS                           := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.OUTRAS_CONFIGURACOES2            := lQry.FieldByName('OUTRAS_CONFIGURACOES2').AsString;
    lModel.objeto.DIAS_PROTESTO_DEVOLUCAO          := lQry.FieldByName('DIAS_PROTESTO_DEVOLUCAO').AsString;
    lModel.objeto.CODIGO_PROTESTO_DEVOLUCAO        := lQry.FieldByName('CODIGO_PROTESTO_DEVOLUCAO').AsString;
    lModel.objeto.CONTA_APLICACAO                  := lQry.FieldByName('CONTA_APLICACAO').AsString;
    lModel.objeto.LOCAL_PAGAMENTO                  := lQry.FieldByName('LOCAL_PAGAMENTO').AsString;
    lModel.objeto.BANCO_REFERENTE                  := lQry.FieldByName('BANCO_REFERENTE').AsString;
    lModel.objeto.DETALHAMENTO_REMESSA             := lQry.FieldByName('DETALHAMENTO_REMESSA').AsString;
    lModel.objeto.URL_ATUALIZACAO_BOLETO           := lQry.FieldByName('URL_ATUALIZACAO_BOLETO').AsString;
    lModel.objeto.ATUALIZAR_BOLETO                 := lQry.FieldByName('ATUALIZAR_BOLETO').AsString;
    lModel.objeto.DRG                              := lQry.FieldByName('DRG').AsString;
    lModel.objeto.PERSONALIZACAO_BOLETO            := lQry.FieldByName('PERSONALIZACAO_BOLETO').AsString;
    lModel.objeto.SEQUENCIA_REMESSA_PAGAMENTO      := lQry.FieldByName('SEQUENCIA_REMESSA_PAGAMENTO').AsString;
    lModel.objeto.CODIGO_CONVENIO_PAGAMENTO        := lQry.FieldByName('CODIGO_CONVENIO_PAGAMENTO').AsString;
    lModel.objeto.CAMINHO_RETORNO_PAGAMENTO        := lQry.FieldByName('CAMINHO_RETORNO_PAGAMENTO').AsString;
    lModel.objeto.CAMINHO_REMESSA_PAGAMENTO        := lQry.FieldByName('CAMINHO_REMESSA_PAGAMENTO').AsString;
    lModel.objeto.CONTA_JUROS_ANTECIPACAO          := lQry.FieldByName('CONTA_JUROS_ANTECIPACAO').AsString;
    lModel.objeto.CONTA_IOF_ANTECIPACAO            := lQry.FieldByName('CONTA_IOF_ANTECIPACAO').AsString;
    lModel.objeto.CONTA_ESTORNO_ANTECIPACAO        := lQry.FieldByName('CONTA_ESTORNO_ANTECIPACAO').AsString;
    lModel.objeto.SYSTIME                          := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.TIPO_COBRANCA                    := lQry.FieldByName('TIPO_COBRANCA').AsString;
    lModel.objeto.DEVELOPER_APPLICATION_KEY        := lQry.FieldByName('DEVELOPER_APPLICATION_KEY').AsString;
    lModel.objeto.CLIENT_ID                        := lQry.FieldByName('CLIENT_ID').AsString;
    lModel.objeto.CLIENT_SECRET                    := lQry.FieldByName('CLIENT_SECRET').AsString;
    lModel.objeto.LOG                              := lQry.FieldByName('LOG').AsString;
    lModel.objeto.FANTASIA                         := lQry.FieldByName('FANTASIA').AsString;
    lModel.objeto.RAZAO                            := lQry.FieldByName('RAZAO').AsString;
    lModel.objeto.CNPJ                             := lQry.FieldByName('CNPJ').AsString;
    lModel.objeto.ENDERECO                         := lQry.FieldByName('ENDERECO').AsString;
    lModel.objeto.BAIRRO                           := lQry.FieldByName('BAIRRO').AsString;
    lModel.objeto.CIDADE                           := lQry.FieldByName('CIDADE').AsString;
    lModel.objeto.UF                               := lQry.FieldByName('UF').AsString;
    lModel.objeto.CEP                              := lQry.FieldByName('CEP').AsString;
    lModel.objeto.TELEFONE                         := lQry.FieldByName('TELEFONE').AsString;
    lModel.objeto.TIPO_EMITENTE                    := lQry.FieldByName('TIPO_EMITENTE').AsString;
    lModel.objeto.INDICADORPIX                     := lQry.FieldByName('INDICADORPIX').AsString;
    lModel.objeto.CONVENIO                         := lQry.FieldByName('CONVENIO').AsString;
    lModel.objeto.MODALIDADE                       := lQry.FieldByName('MODALIDADE').AsString;
    lModel.objeto.CODIGOTRANSMISSAO                := lQry.FieldByName('CODIGOTRANSMISSAO').AsString;
    lModel.objeto.SCOPE                            := lQry.FieldByName('SCOPE').AsString;
    lModel.objeto.CARACTERISTICA_TITULO            := lQry.FieldByName('CARACTERISTICA_TITULO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TBancoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TBancoDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TBancoDao.incluir(pBancoModel: ITBancoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('BANCO', 'NUMERO_BAN', true);

  try
    lQry.SQL.Add(lSQL);
    pBancoModel.objeto.NUMERO_BAN := vIConexao.Generetor('GEN_BANCO_ID');
    setParams(lQry, pBancoModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_BAN').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TBancoDao.alterar(pBancoModel: ITBancoModel): String;
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

    Result := pBancoModel.objeto.NUMERO_BAN;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TBancoDao.excluir(pBancoModel: ITBancoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from BANCO where NUMERO_BAN = :NUMERO_BAN' ,[pBancoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pBancoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TBancoDao.getNewIface(pIConexao: IConexao): ITBancoDao;
begin
  Result := TImplObjetoOwner<TBancoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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

function TBancoDao.obterLista: IFDDataset;
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

procedure TBancoDao.setParams(var pQry: TFDQuery; pBancoModel: ITBancoModel);
begin
  vConstrutor.setParams(NomeTabela,pQry,pBancoModel.objeto);
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
