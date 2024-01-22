unit TEFDao;

interface

uses
  TEFModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Utils;

type
  TTEFDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FTEFsLista: TObjectList<TTEFModel>;
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
    procedure SetTEFsLista(const Value: TObjectList<TTEFModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

    function where: String;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property TEFsLista: TObjectList<TTEFModel> read FTEFsLista write SetTEFsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(ATEFModel: TTEFModel): String;
    function alterar(ATEFModel: TTEFModel): String;
    function excluir(ATEFModel: TTEFModel): String;
	
    procedure obterLista;

    function carregaClasse(pId: String): TTEFModel;
    procedure setParams(var pQry: TFDQuery; pTEFModel: TTEFModel);

end;

implementation

uses
  System.Rtti;

{ TTEF }

function TTEFDao.carregaClasse(pId: String): TTEFModel;
var
  lQry: TFDQuery;
  lModel: TTEFModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTEFModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from tef where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                         := lQry.FieldByName('ID').AsString;
    lModel.NOME_REDE                  := lQry.FieldByName('NOME_REDE').AsString;
    lModel.VALORTOTAL                 := lQry.FieldByName('VALORTOTAL').AsString;
    lModel.TIPO_TRANSACAO             := lQry.FieldByName('TIPO_TRANSACAO').AsString;
    lModel.MSU                        := lQry.FieldByName('MSU').AsString;
    lModel.AUTORIZACAO                := lQry.FieldByName('AUTORIZACAO').AsString;
    lModel.NUMERO_LOTE                := lQry.FieldByName('NUMERO_LOTE').AsString;
    lModel.TIMESTAMP_HOST             := lQry.FieldByName('TIMESTAMP_HOST').AsString;
    lModel.TIMESTAMP_LOCAL            := lQry.FieldByName('TIMESTAMP_LOCAL').AsString;
    lModel.DATA                       := lQry.FieldByName('DATA').AsString;
    lModel.STATUS                     := lQry.FieldByName('STATUS').AsString;
    lModel.TIMESTAMP_CANCELAMENTO     := lQry.FieldByName('TIMESTAMP_CANCELAMENTO').AsString;
    lModel.DOCUMENTO_FISCAL_VINCULADO := lQry.FieldByName('DOCUMENTO_FISCAL_VINCULADO').AsString;
    lModel.MOEDA                      := lQry.FieldByName('MOEDA').AsString;
    lModel.TIPO_PESSOA                := lQry.FieldByName('TIPO_PESSOA').AsString;
    lModel.DOCUMENTO_PESSOA           := lQry.FieldByName('DOCUMENTO_PESSOA').AsString;
    lModel.STATUS_TRANSACAOO          := lQry.FieldByName('STATUS_TRANSACAOO').AsString;
    lModel.NOME_ADMINISTRADORA        := lQry.FieldByName('NOME_ADMINISTRADORA').AsString;
    lModel.CODIGO_AUTORIZACAO         := lQry.FieldByName('CODIGO_AUTORIZACAO').AsString;
    lModel.TIPO_PARCELAMENTO          := lQry.FieldByName('TIPO_PARCELAMENTO').AsString;
    lModel.QUANTIDADE_PARCELAS        := lQry.FieldByName('QUANTIDADE_PARCELAS').AsString;
    lModel.PARCELA                    := lQry.FieldByName('PARCELA').AsString;
    lModel.DATA_VENCIMENTO_PARCELA    := lQry.FieldByName('DATA_VENCIMENTO_PARCELA').AsString;
    lModel.VALOR_PARCELA              := lQry.FieldByName('VALOR_PARCELA').AsString;
    lModel.NSU_PARCELA                := lQry.FieldByName('NSU_PARCELA').AsString;
    lModel.DATA_TRANSACAO_COMPROVANTE := lQry.FieldByName('DATA_TRANSACAO_COMPROVANTE').AsString;
    lModel.HORA_TRANSACAO_COMPROVANTE := lQry.FieldByName('HORA_TRANSACAO_COMPROVANTE').AsString;
    lModel.NSU_CANCELAMENTO           := lQry.FieldByName('NSU_CANCELAMENTO').AsString;
    lModel.CLIENTE_ID                 := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.CONTASRECEBER_FATURA       := lQry.FieldByName('CONTASRECEBER_FATURA').AsString;
    lModel.CONTASRECEBER_PARCELA      := lQry.FieldByName('CONTASRECEBER_PARCELA').AsString;
    lModel.PEDIDO_ID                  := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.CAIXA_ID                   := lQry.FieldByName('CAIXA_ID').AsString;
    lModel.CONTACORRENTE_ID           := lQry.FieldByName('CONTACORRENTE_ID').AsString;
    lModel.IMPRESSAO                  := lQry.FieldByName('IMPRESSAO').AsString;
    lModel.RETORNO_COMPLETO           := lQry.FieldByName('RETORNO_COMPLETO').AsString;
    lModel.SYSTIME                    := lQry.FieldByName('SYSTIME').AsString;
    lModel.CHAMADA                    := lQry.FieldByName('CHAMADA').AsString;
    lModel.CNPJ_CREDENCIADORA         := lQry.FieldByName('CNPJ_CREDENCIADORA').AsString;
    lModel.CODIGO_CREDENCIADORA       := lQry.FieldByName('CODIGO_CREDENCIADORA').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TTEFDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TTEFDao.Destroy;
begin

  inherited;
end;

function TTEFDao.incluir(ATEFModel: TTEFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('TEF', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    ATEFModel.id := vIConexao.Generetor('GEN_TEF');
    setParams(lQry, ATEFModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTEFDao.alterar(ATEFModel: TTEFModel): String;
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

    Result := ATEFModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTEFDao.excluir(ATEFModel: TTEFModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from tef where ID = :ID',[ATEFModel.ID]);
   lQry.ExecSQL;
   Result := ATEFModel.ID;

  finally
    lQry.Free;
  end;
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FTEFsLista := TObjectList<TTEFModel>.Create;

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

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FTEFsLista.Add(TTEFModel.Create(vIConexao));

      i := FTEFsLista.Count -1;

      FTEFsLista[i].ID                          := lQry.FieldByName('ID').AsString;
      FTEFsLista[i].NOME_REDE                   := lQry.FieldByName('NOME_REDE').AsString;
      FTEFsLista[i].VALORTOTAL                  := lQry.FieldByName('VALORTOTAL').AsString;
      FTEFsLista[i].TIPO_TRANSACAO              := lQry.FieldByName('TIPO_TRANSACAO').AsString;
      FTEFsLista[i].MSU                         := lQry.FieldByName('MSU').AsString;
      FTEFsLista[i].AUTORIZACAO                 := lQry.FieldByName('AUTORIZACAO').AsString;
      FTEFsLista[i].NUMERO_LOTE                 := lQry.FieldByName('NUMERO_LOTE').AsString;
      FTEFsLista[i].TIMESTAMP_HOST              := lQry.FieldByName('TIMESTAMP_HOST').AsString;
      FTEFsLista[i].TIMESTAMP_LOCAL             := lQry.FieldByName('TIMESTAMP_LOCAL').AsString;
      FTEFsLista[i].DATA                        := lQry.FieldByName('DATA').AsString;
      FTEFsLista[i].STATUS                      := lQry.FieldByName('STATUS').AsString;
      FTEFsLista[i].TIMESTAMP_CANCELAMENTO      := lQry.FieldByName('TIMESTAMP_CANCELAMENTO').AsString;
      FTEFsLista[i].DOCUMENTO_FISCAL_VINCULADO  := lQry.FieldByName('DOCUMENTO_FISCAL_VINCULADO').AsString;
      FTEFsLista[i].MOEDA                       := lQry.FieldByName('MOEDA').AsString;
      FTEFsLista[i].TIPO_PESSOA                 := lQry.FieldByName('TIPO_PESSOA').AsString;
      FTEFsLista[i].DOCUMENTO_PESSOA            := lQry.FieldByName('DOCUMENTO_PESSOA').AsString;
      FTEFsLista[i].STATUS_TRANSACAOO           := lQry.FieldByName('STATUS_TRANSACAOO').AsString;
      FTEFsLista[i].NOME_ADMINISTRADORA         := lQry.FieldByName('NOME_ADMINISTRADORA').AsString;
      FTEFsLista[i].CODIGO_AUTORIZACAO          := lQry.FieldByName('CODIGO_AUTORIZACAO').AsString;
      FTEFsLista[i].TIPO_PARCELAMENTO           := lQry.FieldByName('TIPO_PARCELAMENTO').AsString;
      FTEFsLista[i].QUANTIDADE_PARCELAS         := lQry.FieldByName('QUANTIDADE_PARCELAS').AsString;
      FTEFsLista[i].PARCELA                     := lQry.FieldByName('PARCELA').AsString;
      FTEFsLista[i].DATA_VENCIMENTO_PARCELA     := lQry.FieldByName('DATA_VENCIMENTO_PARCELA').AsString;
      FTEFsLista[i].VALOR_PARCELA               := lQry.FieldByName('VALOR_PARCELA').AsString;
      FTEFsLista[i].NSU_PARCELA                 := lQry.FieldByName('NSU_PARCELA').AsString;
      FTEFsLista[i].DATA_TRANSACAO_COMPROVANTE  := lQry.FieldByName('DATA_TRANSACAO_COMPROVANTE').AsString;
      FTEFsLista[i].HORA_TRANSACAO_COMPROVANTE  := lQry.FieldByName('HORA_TRANSACAO_COMPROVANTE').AsString;
      FTEFsLista[i].NSU_CANCELAMENTO            := lQry.FieldByName('NSU_CANCELAMENTO').AsString;
      FTEFsLista[i].CLIENTE_ID                  := lQry.FieldByName('CLIENTE_ID').AsString;
      FTEFsLista[i].CONTASRECEBER_FATURA        := lQry.FieldByName('CONTASRECEBER_FATURA').AsString;
      FTEFsLista[i].CONTASRECEBER_PARCELA       := lQry.FieldByName('CONTASRECEBER_PARCELA').AsString;
      FTEFsLista[i].PEDIDO_ID                   := lQry.FieldByName('PEDIDO_ID').AsString;
      FTEFsLista[i].CAIXA_ID                    := lQry.FieldByName('CAIXA_ID').AsString;
      FTEFsLista[i].CONTACORRENTE_ID            := lQry.FieldByName('CONTACORRENTE_ID').AsString;
      FTEFsLista[i].IMPRESSAO                   := lQry.FieldByName('IMPRESSAO').AsString;
      FTEFsLista[i].RETORNO_COMPLETO            := lQry.FieldByName('RETORNO_COMPLETO').AsString;
      FTEFsLista[i].SYSTIME                     := lQry.FieldByName('SYSTIME').AsString;
      FTEFsLista[i].CHAMADA                     := lQry.FieldByName('CHAMADA').AsString;
      FTEFsLista[i].CNPJ_CREDENCIADORA          := lQry.FieldByName('CNPJ_CREDENCIADORA').AsString;
      FTEFsLista[i].CODIGO_CREDENCIADORA        := lQry.FieldByName('CODIGO_CREDENCIADORA').AsString;

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

procedure TTEFDao.SetTEFsLista(const Value: TObjectList<TTEFModel>);
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

procedure TTEFDao.setParams(var pQry: TFDQuery; pTEFModel: TTEFModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('TEF');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TTEFModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pTEFModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pTEFModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
