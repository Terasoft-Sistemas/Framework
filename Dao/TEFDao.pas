unit TEFDao;

interface

uses
  TEFModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto;

type
  TTEFDao = class

  private
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

    function montaCondicaoQuery: String;
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create;
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

{ TTEF }

uses VariaveisGlobais;

function TTEFDao.carregaClasse(pId: String): TTEFModel;
var
  lQry: TFDQuery;
  lModel: TTEFModel;
begin
  lQry     := xConexao.CriarQuery;
  lModel   := TTEFModel.Create;
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

constructor TTEFDao.Create;
begin

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
  lQry := xConexao.CriarQuery;

  lSQL :=   '   insert into tef (id,                               '+SLineBreak+
            '                    nome_rede,                        '+SLineBreak+
            '                    valortotal,                       '+SLineBreak+
            '                    tipo_transacao,                   '+SLineBreak+
            '                    msu,                              '+SLineBreak+
            '                    autorizacao,                      '+SLineBreak+
            '                    numero_lote,                      '+SLineBreak+
            '                    timestamp_host,                   '+SLineBreak+
            '                    timestamp_local,                  '+SLineBreak+
            '                    data,                             '+SLineBreak+
            '                    status,                           '+SLineBreak+
            '                    timestamp_cancelamento,           '+SLineBreak+
            '                    documento_fiscal_vinculado,       '+SLineBreak+
            '                    moeda,                            '+SLineBreak+
            '                    tipo_pessoa,                      '+SLineBreak+
            '                    documento_pessoa,                 '+SLineBreak+
            '                    status_transacaoo,                '+SLineBreak+
            '                    nome_administradora,              '+SLineBreak+
            '                    codigo_autorizacao,               '+SLineBreak+
            '                    tipo_parcelamento,                '+SLineBreak+
            '                    quantidade_parcelas,              '+SLineBreak+
            '                    parcela,                          '+SLineBreak+
            '                    data_vencimento_parcela,          '+SLineBreak+
            '                    valor_parcela,                    '+SLineBreak+
            '                    nsu_parcela,                      '+SLineBreak+
            '                    data_transacao_comprovante,       '+SLineBreak+
            '                    hora_transacao_comprovante,       '+SLineBreak+
            '                    nsu_cancelamento,                 '+SLineBreak+
            '                    cliente_id,                       '+SLineBreak+
            '                    contasreceber_fatura,             '+SLineBreak+
            '                    contasreceber_parcela,            '+SLineBreak+
            '                    pedido_id,                        '+SLineBreak+
            '                    caixa_id,                         '+SLineBreak+
            '                    contacorrente_id,                 '+SLineBreak+
            '                    impressao,                        '+SLineBreak+
            '                    retorno_completo,                 '+SLineBreak+
            '                    chamada,                          '+SLineBreak+
            '                    cnpj_credenciadora,               '+SLineBreak+
            '                    codigo_credenciadora)             '+SLineBreak+
            '   values (:id,                                       '+SLineBreak+
            '           :nome_rede,                                '+SLineBreak+
            '           :valortotal,                               '+SLineBreak+
            '           :tipo_transacao,                           '+SLineBreak+
            '           :msu,                                      '+SLineBreak+
            '           :autorizacao,                              '+SLineBreak+
            '           :numero_lote,                              '+SLineBreak+
            '           :timestamp_host,                           '+SLineBreak+
            '           :timestamp_local,                          '+SLineBreak+
            '           :data,                                     '+SLineBreak+
            '           :status,                                   '+SLineBreak+
            '           :timestamp_cancelamento,                   '+SLineBreak+
            '           :documento_fiscal_vinculado,               '+SLineBreak+
            '           :moeda,                                    '+SLineBreak+
            '           :tipo_pessoa,                              '+SLineBreak+
            '           :documento_pessoa,                         '+SLineBreak+
            '           :status_transacaoo,                        '+SLineBreak+
            '           :nome_administradora,                      '+SLineBreak+
            '           :codigo_autorizacao,                       '+SLineBreak+
            '           :tipo_parcelamento,                        '+SLineBreak+
            '           :quantidade_parcelas,                      '+SLineBreak+
            '           :parcela,                                  '+SLineBreak+
            '           :data_vencimento_parcela,                  '+SLineBreak+
            '           :valor_parcela,                            '+SLineBreak+
            '           :nsu_parcela,                              '+SLineBreak+
            '           :data_transacao_comprovante,               '+SLineBreak+
            '           :hora_transacao_comprovante,               '+SLineBreak+
            '           :nsu_cancelamento,                         '+SLineBreak+
            '           :cliente_id,                               '+SLineBreak+
            '           :contasreceber_fatura,                     '+SLineBreak+
            '           :contasreceber_parcela,                    '+SLineBreak+
            '           :pedido_id,                                '+SLineBreak+
            '           :caixa_id,                                 '+SLineBreak+
            '           :contacorrente_id,                         '+SLineBreak+
            '           :impressao,                                '+SLineBreak+
            '           :retorno_completo,                         '+SLineBreak+
            '           :chamada,                                  '+SLineBreak+
            '           :cnpj_credenciadora,                       '+SLineBreak+
            '           :codigo_credenciadora)                     '+SLineBreak+
            ' returning ID                                         '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := xConexao.Generetor('GEN_TEF');
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
  lQry := xConexao.CriarQuery;

  lSQL :=  '    update tef                                                              '+SLineBreak+
           '       set nome_rede = :nome_rede,                                          '+SLineBreak+
           '           valortotal = :valortotal,                                        '+SLineBreak+
           '           tipo_transacao = :tipo_transacao,                                '+SLineBreak+
           '           msu = :msu,                                                      '+SLineBreak+
           '           autorizacao = :autorizacao,                                      '+SLineBreak+
           '           numero_lote = :numero_lote,                                      '+SLineBreak+
           '           timestamp_host = :timestamp_host,                                '+SLineBreak+
           '           timestamp_local = :timestamp_local,                              '+SLineBreak+
           '           data = :data,                                                    '+SLineBreak+
           '           status = :status,                                                '+SLineBreak+
           '           timestamp_cancelamento = :timestamp_cancelamento,                '+SLineBreak+
           '           documento_fiscal_vinculado = :documento_fiscal_vinculado,        '+SLineBreak+
           '           moeda = :moeda,                                                  '+SLineBreak+
           '           tipo_pessoa = :tipo_pessoa,                                      '+SLineBreak+
           '           documento_pessoa = :documento_pessoa,                            '+SLineBreak+
           '           status_transacaoo = :status_transacaoo,                          '+SLineBreak+
           '           nome_administradora = :nome_administradora,                      '+SLineBreak+
           '           codigo_autorizacao = :codigo_autorizacao,                        '+SLineBreak+
           '           tipo_parcelamento = :tipo_parcelamento,                          '+SLineBreak+
           '           quantidade_parcelas = :quantidade_parcelas,                      '+SLineBreak+
           '           parcela = :parcela,                                              '+SLineBreak+
           '           data_vencimento_parcela = :data_vencimento_parcela,              '+SLineBreak+
           '           valor_parcela = :valor_parcela,                                  '+SLineBreak+
           '           nsu_parcela = :nsu_parcela,                                      '+SLineBreak+
           '           data_transacao_comprovante = :data_transacao_comprovante,        '+SLineBreak+
           '           hora_transacao_comprovante = :hora_transacao_comprovante,        '+SLineBreak+
           '           nsu_cancelamento = :nsu_cancelamento,                            '+SLineBreak+
           '           cliente_id = :cliente_id,                                        '+SLineBreak+
           '           contasreceber_fatura = :contasreceber_fatura,                    '+SLineBreak+
           '           contasreceber_parcela = :contasreceber_parcela,                  '+SLineBreak+
           '           pedido_id = :pedido_id,                                          '+SLineBreak+
           '           caixa_id = :caixa_id,                                            '+SLineBreak+
           '           contacorrente_id = :contacorrente_id,                            '+SLineBreak+
           '           impressao = :impressao,                                          '+SLineBreak+
           '           retorno_completo = :retorno_completo,                            '+SLineBreak+
           '           chamada = :chamada,                                              '+SLineBreak+
           '           cnpj_credenciadora = :cnpj_credenciadora,                        '+SLineBreak+
           '           codigo_credenciadora = :codigo_credenciadora                     '+SLineBreak+
           '     where (id = :id)                                                       '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := IIF(ATEFModel.ID = '', Unassigned, ATEFModel.ID);
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
  lQry := xConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from tef where ID = :ID',[ATEFModel.ID]);
   lQry.ExecSQL;
   Result := ATEFModel.ID;

  finally
    lQry.Free;
  end;
end;

function TTEFDao.montaCondicaoQuery: String;
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
    lQry := xConexao.CriarQuery;

    lSql := 'select count(*) records From tef where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

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
  lQry := xConexao.CriarQuery;

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

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FTEFsLista.Add(TTEFModel.Create);

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
begin
  pQry.ParamByName('nome_rede').Value                  := IIF(pTEFModel.NOME_REDE                  = '', Unassigned, pTEFModel.NOME_REDE);
  pQry.ParamByName('valortotal').Value                 := IIF(pTEFModel.VALORTOTAL                 = '', Unassigned, FormataFloatFireBird(pTEFModel.VALORTOTAL));
  pQry.ParamByName('tipo_transacao').Value             := IIF(pTEFModel.TIPO_TRANSACAO             = '', Unassigned, pTEFModel.TIPO_TRANSACAO);
  pQry.ParamByName('msu').Value                        := IIF(pTEFModel.MSU                        = '', Unassigned, pTEFModel.MSU);
  pQry.ParamByName('autorizacao').Value                := IIF(pTEFModel.AUTORIZACAO                = '', Unassigned, pTEFModel.AUTORIZACAO);
  pQry.ParamByName('numero_lote').Value                := IIF(pTEFModel.NUMERO_LOTE                = '', Unassigned, pTEFModel.NUMERO_LOTE);
  pQry.ParamByName('timestamp_host').Value             := IIF(pTEFModel.TIMESTAMP_HOST             = '', Unassigned, pTEFModel.TIMESTAMP_HOST);
  pQry.ParamByName('timestamp_local').Value            := IIF(pTEFModel.TIMESTAMP_LOCAL            = '', Unassigned, transformaDataFireBird(pTEFModel.TIMESTAMP_LOCAL));
  pQry.ParamByName('data').Value                       := IIF(pTEFModel.DATA                       = '', Unassigned, transformaDataFireBird(pTEFModel.DATA));
  pQry.ParamByName('status').Value                     := IIF(pTEFModel.STATUS                     = '', Unassigned, pTEFModel.STATUS);
  pQry.ParamByName('timestamp_cancelamento').Value     := IIF(pTEFModel.TIMESTAMP_CANCELAMENTO     = '', Unassigned, pTEFModel.TIMESTAMP_CANCELAMENTO);
  pQry.ParamByName('documento_fiscal_vinculado').Value := IIF(pTEFModel.DOCUMENTO_FISCAL_VINCULADO = '', Unassigned, pTEFModel.DOCUMENTO_FISCAL_VINCULADO);
  pQry.ParamByName('moeda').Value                      := IIF(pTEFModel.MOEDA                      = '', Unassigned, pTEFModel.MOEDA);
  pQry.ParamByName('tipo_pessoa').Value                := IIF(pTEFModel.TIPO_PESSOA                = '', Unassigned, pTEFModel.TIPO_PESSOA);
  pQry.ParamByName('documento_pessoa').Value           := IIF(pTEFModel.DOCUMENTO_PESSOA           = '', Unassigned, pTEFModel.DOCUMENTO_PESSOA);
  pQry.ParamByName('status_transacaoo').Value          := IIF(pTEFModel.STATUS_TRANSACAOO          = '', Unassigned, pTEFModel.STATUS_TRANSACAOO);
  pQry.ParamByName('nome_administradora').Value        := IIF(pTEFModel.NOME_ADMINISTRADORA        = '', Unassigned, pTEFModel.NOME_ADMINISTRADORA);
  pQry.ParamByName('codigo_autorizacao').Value         := IIF(pTEFModel.CODIGO_AUTORIZACAO         = '', Unassigned, pTEFModel.CODIGO_AUTORIZACAO);
  pQry.ParamByName('tipo_parcelamento').Value          := IIF(pTEFModel.TIPO_PARCELAMENTO          = '', Unassigned, pTEFModel.TIPO_PARCELAMENTO);
  pQry.ParamByName('quantidade_parcelas').Value        := IIF(pTEFModel.QUANTIDADE_PARCELAS        = '', Unassigned, pTEFModel.QUANTIDADE_PARCELAS);
  pQry.ParamByName('parcela').Value                    := IIF(pTEFModel.PARCELA                    = '', Unassigned, pTEFModel.PARCELA);
  pQry.ParamByName('data_vencimento_parcela').Value    := IIF(pTEFModel.DATA_VENCIMENTO_PARCELA    = '', Unassigned, transformaDataFireBird(pTEFModel.DATA_VENCIMENTO_PARCELA));
  pQry.ParamByName('valor_parcela').Value              := IIF(pTEFModel.VALOR_PARCELA              = '', Unassigned, FormataFloatFireBird(pTEFModel.VALOR_PARCELA));
  pQry.ParamByName('nsu_parcela').Value                := IIF(pTEFModel.NSU_PARCELA                = '', Unassigned, pTEFModel.NSU_PARCELA);
  pQry.ParamByName('data_transacao_comprovante').Value := IIF(pTEFModel.DATA_TRANSACAO_COMPROVANTE = '', Unassigned, transformaDataFireBird(pTEFModel.DATA_TRANSACAO_COMPROVANTE));
  pQry.ParamByName('hora_transacao_comprovante').Value := IIF(pTEFModel.HORA_TRANSACAO_COMPROVANTE = '', Unassigned, pTEFModel.HORA_TRANSACAO_COMPROVANTE);
  pQry.ParamByName('nsu_cancelamento').Value           := IIF(pTEFModel.NSU_CANCELAMENTO           = '', Unassigned, pTEFModel.NSU_CANCELAMENTO);
  pQry.ParamByName('cliente_id').Value                 := IIF(pTEFModel.CLIENTE_ID                 = '', Unassigned, pTEFModel.CLIENTE_ID);
  pQry.ParamByName('contasreceber_fatura').Value       := IIF(pTEFModel.CONTASRECEBER_FATURA       = '', Unassigned, pTEFModel.CONTASRECEBER_FATURA);
  pQry.ParamByName('contasreceber_parcela').Value      := IIF(pTEFModel.CONTASRECEBER_PARCELA      = '', Unassigned, pTEFModel.CONTASRECEBER_PARCELA);
  pQry.ParamByName('pedido_id').Value                  := IIF(pTEFModel.PEDIDO_ID                  = '', Unassigned, pTEFModel.PEDIDO_ID);
  pQry.ParamByName('caixa_id').Value                   := IIF(pTEFModel.CAIXA_ID                   = '', Unassigned, pTEFModel.CAIXA_ID);
  pQry.ParamByName('contacorrente_id').Value           := IIF(pTEFModel.CONTACORRENTE_ID           = '', Unassigned, pTEFModel.CONTACORRENTE_ID);
  pQry.ParamByName('impressao').Value                  := IIF(pTEFModel.IMPRESSAO                  = '', Unassigned, pTEFModel.IMPRESSAO);
  pQry.ParamByName('retorno_completo').Value           := IIF(pTEFModel.RETORNO_COMPLETO           = '', Unassigned, pTEFModel.RETORNO_COMPLETO);
  pQry.ParamByName('chamada').Value                    := IIF(pTEFModel.CHAMADA                    = '', Unassigned, pTEFModel.CHAMADA);
  pQry.ParamByName('cnpj_credenciadora').Value         := IIF(pTEFModel.CNPJ_CREDENCIADORA         = '', Unassigned, pTEFModel.CNPJ_CREDENCIADORA);
  pQry.ParamByName('codigo_credenciadora').Value       := IIF(pTEFModel.CODIGO_CREDENCIADORA       = '', Unassigned, pTEFModel.CODIGO_CREDENCIADORA);
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
