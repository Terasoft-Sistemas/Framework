unit TEFDao;

interface

uses
  TEFModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Utils;

type
  TTEFDao = class;
  ITTEFDao=IObject<TTEFDao>;

  TTEFDao = class
  private
    [unsafe] mySelf: ITTEFDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FTEFsLista: IList<ITTEFModel>;
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
    procedure SetTEFsLista(const Value: IList<ITTEFModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

    function where: String;
  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITTEFDao;

    property TEFsLista: IList<ITTEFModel> read FTEFsLista write SetTEFsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(ATEFModel: ITTEFModel): String;
    function alterar(ATEFModel: ITTEFModel): String;
    function excluir(ATEFModel: ITTEFModel): String;
	
    procedure obterLista;

    function carregaClasse(pId: String): ITTEFModel;
    procedure setParams(var pQry: TFDQuery; pTEFModel: ITTEFModel);

end;

implementation

uses
  System.Rtti;

{ TTEF }

function TTEFDao.carregaClasse(pId: String): ITTEFModel;
var
  lQry: TFDQuery;
  lModel: ITTEFModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTEFModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from tef where id = '+ QuotedStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                         := lQry.FieldByName('ID').AsString;
    lModel.objeto.NOME_REDE                  := lQry.FieldByName('NOME_REDE').AsString;
    lModel.objeto.VALORTOTAL                 := lQry.FieldByName('VALORTOTAL').AsString;
    lModel.objeto.TIPO_TRANSACAO             := lQry.FieldByName('TIPO_TRANSACAO').AsString;
    lModel.objeto.MSU                        := lQry.FieldByName('MSU').AsString;
    lModel.objeto.AUTORIZACAO                := lQry.FieldByName('AUTORIZACAO').AsString;
    lModel.objeto.NUMERO_LOTE                := lQry.FieldByName('NUMERO_LOTE').AsString;
    lModel.objeto.TIMESTAMP_HOST             := lQry.FieldByName('TIMESTAMP_HOST').AsString;
    lModel.objeto.TIMESTAMP_LOCAL            := lQry.FieldByName('TIMESTAMP_LOCAL').AsString;
    lModel.objeto.DATA                       := lQry.FieldByName('DATA').AsString;
    lModel.objeto.STATUS                     := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.TIMESTAMP_CANCELAMENTO     := lQry.FieldByName('TIMESTAMP_CANCELAMENTO').AsString;
    lModel.objeto.DOCUMENTO_FISCAL_VINCULADO := lQry.FieldByName('DOCUMENTO_FISCAL_VINCULADO').AsString;
    lModel.objeto.MOEDA                      := lQry.FieldByName('MOEDA').AsString;
    lModel.objeto.TIPO_PESSOA                := lQry.FieldByName('TIPO_PESSOA').AsString;
    lModel.objeto.DOCUMENTO_PESSOA           := lQry.FieldByName('DOCUMENTO_PESSOA').AsString;
    lModel.objeto.STATUS_TRANSACAOO          := lQry.FieldByName('STATUS_TRANSACAOO').AsString;
    lModel.objeto.NOME_ADMINISTRADORA        := lQry.FieldByName('NOME_ADMINISTRADORA').AsString;
    lModel.objeto.CODIGO_AUTORIZACAO         := lQry.FieldByName('CODIGO_AUTORIZACAO').AsString;
    lModel.objeto.TIPO_PARCELAMENTO          := lQry.FieldByName('TIPO_PARCELAMENTO').AsString;
    lModel.objeto.QUANTIDADE_PARCELAS        := lQry.FieldByName('QUANTIDADE_PARCELAS').AsString;
    lModel.objeto.PARCELA                    := lQry.FieldByName('PARCELA').AsString;
    lModel.objeto.DATA_VENCIMENTO_PARCELA    := lQry.FieldByName('DATA_VENCIMENTO_PARCELA').AsString;
    lModel.objeto.VALOR_PARCELA              := lQry.FieldByName('VALOR_PARCELA').AsString;
    lModel.objeto.NSU_PARCELA                := lQry.FieldByName('NSU_PARCELA').AsString;
    lModel.objeto.DATA_TRANSACAO_COMPROVANTE := lQry.FieldByName('DATA_TRANSACAO_COMPROVANTE').AsString;
    lModel.objeto.HORA_TRANSACAO_COMPROVANTE := lQry.FieldByName('HORA_TRANSACAO_COMPROVANTE').AsString;
    lModel.objeto.NSU_CANCELAMENTO           := lQry.FieldByName('NSU_CANCELAMENTO').AsString;
    lModel.objeto.CLIENTE_ID                 := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.objeto.CONTASRECEBER_FATURA       := lQry.FieldByName('CONTASRECEBER_FATURA').AsString;
    lModel.objeto.CONTASRECEBER_PARCELA      := lQry.FieldByName('CONTASRECEBER_PARCELA').AsString;
    lModel.objeto.PEDIDO_ID                  := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.objeto.CAIXA_ID                   := lQry.FieldByName('CAIXA_ID').AsString;
    lModel.objeto.CONTACORRENTE_ID           := lQry.FieldByName('CONTACORRENTE_ID').AsString;
    lModel.objeto.IMPRESSAO                  := lQry.FieldByName('IMPRESSAO').AsString;
    lModel.objeto.RETORNO_COMPLETO           := lQry.FieldByName('RETORNO_COMPLETO').AsString;
    lModel.objeto.SYSTIME                    := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.CHAMADA                    := lQry.FieldByName('CHAMADA').AsString;
    lModel.objeto.CNPJ_CREDENCIADORA         := lQry.FieldByName('CNPJ_CREDENCIADORA').AsString;
    lModel.objeto.CODIGO_CREDENCIADORA       := lQry.FieldByName('CODIGO_CREDENCIADORA').AsString;
    lModel.objeto.MOTIVO_CANCELAMENTO        := lQry.FieldByName('MOTIVO_CANCELAMENTO').AsString;
    lModel.objeto.PARCELAS_BAIXADAS          := lQry.FieldByName('PARCELAS_BAIXADAS').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TTEFDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TTEFDao.Destroy;
begin
  FTEFsLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TTEFDao.incluir(ATEFModel: ITTEFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('TEF', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    ATEFModel.objeto.id := vIConexao.Generetor('GEN_TEF');
    setParams(lQry, ATEFModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTEFDao.alterar(ATEFModel: ITTEFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('TEF', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ATEFModel);
    lQry.ExecSQL;

    Result := ATEFModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTEFDao.excluir(ATEFModel: ITTEFModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from tef where ID = :ID',[ATEFModel.objeto.ID]);
   lQry.ExecSQL;
   Result := ATEFModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TTEFDao.getNewIface(pIConexao: IConexao): ITTEFDao;
begin
  Result := TImplObjetoOwner<TTEFDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TTEFDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and tef.id = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TTEFDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From tef where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TTEFDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITTEFModel;
begin
  lQry := vIConexao.CriarQuery;

  FTEFsLista := TCollections.CreateList<ITTEFModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '        tef.*            '+
	    '   from tef              '+
      '  where 1=1              ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TTEFModel.getNewIface(vIConexao);
      FTEFsLista.Add(modelo);

      modelo.objeto.ID                          := lQry.FieldByName('ID').AsString;
      modelo.objeto.NOME_REDE                   := lQry.FieldByName('NOME_REDE').AsString;
      modelo.objeto.VALORTOTAL                  := lQry.FieldByName('VALORTOTAL').AsString;
      modelo.objeto.TIPO_TRANSACAO              := lQry.FieldByName('TIPO_TRANSACAO').AsString;
      modelo.objeto.MSU                         := lQry.FieldByName('MSU').AsString;
      modelo.objeto.AUTORIZACAO                 := lQry.FieldByName('AUTORIZACAO').AsString;
      modelo.objeto.NUMERO_LOTE                 := lQry.FieldByName('NUMERO_LOTE').AsString;
      modelo.objeto.TIMESTAMP_HOST              := lQry.FieldByName('TIMESTAMP_HOST').AsString;
      modelo.objeto.TIMESTAMP_LOCAL             := lQry.FieldByName('TIMESTAMP_LOCAL').AsString;
      modelo.objeto.DATA                        := lQry.FieldByName('DATA').AsString;
      modelo.objeto.STATUS                      := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.TIMESTAMP_CANCELAMENTO      := lQry.FieldByName('TIMESTAMP_CANCELAMENTO').AsString;
      modelo.objeto.DOCUMENTO_FISCAL_VINCULADO  := lQry.FieldByName('DOCUMENTO_FISCAL_VINCULADO').AsString;
      modelo.objeto.MOEDA                       := lQry.FieldByName('MOEDA').AsString;
      modelo.objeto.TIPO_PESSOA                 := lQry.FieldByName('TIPO_PESSOA').AsString;
      modelo.objeto.DOCUMENTO_PESSOA            := lQry.FieldByName('DOCUMENTO_PESSOA').AsString;
      modelo.objeto.STATUS_TRANSACAOO           := lQry.FieldByName('STATUS_TRANSACAOO').AsString;
      modelo.objeto.NOME_ADMINISTRADORA         := lQry.FieldByName('NOME_ADMINISTRADORA').AsString;
      modelo.objeto.CODIGO_AUTORIZACAO          := lQry.FieldByName('CODIGO_AUTORIZACAO').AsString;
      modelo.objeto.TIPO_PARCELAMENTO           := lQry.FieldByName('TIPO_PARCELAMENTO').AsString;
      modelo.objeto.QUANTIDADE_PARCELAS         := lQry.FieldByName('QUANTIDADE_PARCELAS').AsString;
      modelo.objeto.PARCELA                     := lQry.FieldByName('PARCELA').AsString;
      modelo.objeto.DATA_VENCIMENTO_PARCELA     := lQry.FieldByName('DATA_VENCIMENTO_PARCELA').AsString;
      modelo.objeto.VALOR_PARCELA               := lQry.FieldByName('VALOR_PARCELA').AsString;
      modelo.objeto.NSU_PARCELA                 := lQry.FieldByName('NSU_PARCELA').AsString;
      modelo.objeto.DATA_TRANSACAO_COMPROVANTE  := lQry.FieldByName('DATA_TRANSACAO_COMPROVANTE').AsString;
      modelo.objeto.HORA_TRANSACAO_COMPROVANTE  := lQry.FieldByName('HORA_TRANSACAO_COMPROVANTE').AsString;
      modelo.objeto.NSU_CANCELAMENTO            := lQry.FieldByName('NSU_CANCELAMENTO').AsString;
      modelo.objeto.CLIENTE_ID                  := lQry.FieldByName('CLIENTE_ID').AsString;
      modelo.objeto.CONTASRECEBER_FATURA        := lQry.FieldByName('CONTASRECEBER_FATURA').AsString;
      modelo.objeto.CONTASRECEBER_PARCELA       := lQry.FieldByName('CONTASRECEBER_PARCELA').AsString;
      modelo.objeto.PEDIDO_ID                   := lQry.FieldByName('PEDIDO_ID').AsString;
      modelo.objeto.CAIXA_ID                    := lQry.FieldByName('CAIXA_ID').AsString;
      modelo.objeto.CONTACORRENTE_ID            := lQry.FieldByName('CONTACORRENTE_ID').AsString;
      modelo.objeto.IMPRESSAO                   := lQry.FieldByName('IMPRESSAO').AsString;
      modelo.objeto.RETORNO_COMPLETO            := lQry.FieldByName('RETORNO_COMPLETO').AsString;
      modelo.objeto.SYSTIME                     := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.CHAMADA                     := lQry.FieldByName('CHAMADA').AsString;
      modelo.objeto.CNPJ_CREDENCIADORA          := lQry.FieldByName('CNPJ_CREDENCIADORA').AsString;
      modelo.objeto.CODIGO_CREDENCIADORA        := lQry.FieldByName('CODIGO_CREDENCIADORA').AsString;
      modelo.objeto.PARCELAS_BAIXADAS           := lQry.FieldByName('PARCELAS_BAIXADAS').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TTEFDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTEFDao.SetTEFsLista;
begin
  FTEFsLista := Value;
end;

procedure TTEFDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTEFDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TTEFDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTEFDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTEFDao.setParams(var pQry: TFDQuery; pTEFModel: ITTEFModel);
begin
  vConstrutor.setParams('TEF',pQry,pTEFModel.objeto);
end;

procedure TTEFDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTEFDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTEFDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
