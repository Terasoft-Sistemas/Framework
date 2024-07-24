unit SituacaoFinanceiraDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  SituacaoFinanceiraModel;

type
  TSituacaoFinanceiraDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FValorAVencer: Double;
    FValorDeJuros: Double;
    FValorEmAberto: Double;
    FValorEmAbertoComJuros: Double;
    FValorEmAtraso: Double;
    FValorComprasRealizadasAPrazo: Double;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

    function where: String;
    procedure SetValorAVencer(const Value: Double);
    procedure SetValorComprasRealizadasAPrazo(const Value: Double);
    procedure SetValorDeJuros(const Value: Double);
    procedure SetValorEmAberto(const Value: Double);
    procedure SetValorEmAbertoComJuros(const Value: Double);
    procedure SetValorEmAtraso(const Value: Double);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;
    property ValorEmAberto : Double read FValorEmAberto write SetValorEmAberto;
    property ValorDeJuros : Double read FValorDeJuros write SetValorDeJuros;
    property ValorEmAbertoComJuros : Double read FValorEmAbertoComJuros write SetValorEmAbertoComJuros;
    property ValorEmAtraso : Double read FValorEmAtraso write SetValorEmAtraso;
    property ValorAVencer : Double read FValorAVencer write SetValorAVencer;
    property ValorComprasRealizadasAPrazo : Double read FValorComprasRealizadasAPrazo write SetValorComprasRealizadasAPrazo;

    function obterLista(pCliente : String): IFDDataset;
    function ObterResumoFinanceiro(pCliente : String): TFDMemTable;
    function ObterDetalhesBaixa(pFatura, pParcela : String): IFDDataset;
    function ObterCredito(pCliente: String): Double;
end;

implementation

uses
  System.Rtti, Data.DB;

{ TSituacaoFinanceira }

constructor TSituacaoFinanceiraDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TSituacaoFinanceiraDao.Destroy;
begin
  inherited;
end;

function TSituacaoFinanceiraDao.ObterLista(pCliente : String): IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSQL :=
      ' select '+lPaginacao+'                                                    '+SLineBreak+
      '          C.CODIGO_CLI,                                                   '+SLineBreak+
      '          C.FANTASIA_CLI,                                                 '+SLineBreak+
      '          CR.FATURA_REC,                                                  '+SLineBreak+
      '          R.DATAEMI_REC,                                                  '+SLineBreak+
      '          CR.VENCIMENTO_REC,                                              '+SLineBreak+
      '          CR.TOTALPARCELAS_REC,                                           '+SLineBreak+
      '          CR.PACELA_REC,                                                  '+SLineBreak+
      '          CR.VLRPARCELA_REC,                                              '+SLineBreak+
      '          CR.VALORREC_REC,                                                '+SLineBreak+
      '          CR.DATABAIXA_REC,                                               '+SLineBreak+
      '          R.PEDIDO_REC,                                                   '+SLineBreak+
      '          R.OS_REC ,                                                      '+SLineBreak+
      '          CR.DESTITULO_REC,                                               '+SLineBreak+
      '          CR.CODIGO_POR,                                                  '+SLineBreak+
      '          R.CODIGO_CTA,                                                   '+SLineBreak+
      '          P.NOME_PORT,                                                    '+SLineBreak+
      '          P.SITUACAO_CLIENTE,                                             '+SLineBreak+
      '          CR.SITUACAO_REC ,                                               '+SLineBreak+
      '          CR.NOSSO_NUMERO,                                                '+SLineBreak+
      '          CR.OBSERVACAO,                                                  '+SLineBreak+
      '          CR.POSICAO_ID,                                                  '+SLineBreak+
      '          R.AVALISTA,                                                     '+SLineBreak+
      '          CR.ID,                                                          '+SLineBreak+
      '          R.VENDEDOR_REC,                                                 '+SLineBreak+
      '          CR.COMISSAO,                                                    '+SLineBreak+
      '          V.NUMERO_NF,                                                    '+SLineBreak+
      '          CR.TOTALPARCELAS_REC                                            '+SLineBreak+
      '    FROM  CLIENTES C                                                      '+SLineBreak+
      '    INNER JOIN CONTASRECEBER R ON                                         '+SLineBreak+
      '          C.CODIGO_CLI = R.CODIGO_CLI                                     '+SLineBreak+
      '    INNER JOIN CONTASRECEBERITENS CR ON                                   '+SLineBreak+
      '          R.FATURA_REC = CR.FATURA_REC                                    '+SLineBreak+
      '    LEFT JOIN PORTADOR P ON                                               '+SLineBreak+
      '          CR.CODIGO_POR = P.CODIGO_PORT                                   '+SLineBreak+
      '    LEFT JOIN PEDIDOVENDA V ON                                            '+SLineBreak+
      '          R.PEDIDO_REC = V.NUMERO_PED                                     '+SLineBreak+
      '    WHERE                                                                 '+SLineBreak+
      '          C.CODIGO_CLI =' +QuotedStr(pCliente)                             +SLineBreak;

    lSql := lSql + where;

    lSQL := lSQL + ' ORDER BY CR.VENCIMENTO_REC';

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

function TSituacaoFinanceiraDao.ObterResumoFinanceiro(pCliente: String): TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
begin
  lQry := vIConexao.CriarQuery;

  FValorEmAberto                := 0;
  FValorDeJuros                 := 0;
  FValorEmAbertoComJuros        := 0;
  FValorEmAtraso                := 0;
  FValorAVencer                 := 0;
  FValorComprasRealizadasAPrazo := 0;

  try
    lSQL :=
      '    SELECT                                                                               '+SLineBreak+
      '          CR.VENCIMENTO_REC,                                                             '+SLineBreak+
      '          CR.VLRPARCELA_REC,                                                             '+SLineBreak+
      '          CR.VALORREC_REC,                                                               '+SLineBreak+
      '          CR.DATABAIXA_REC,                                                              '+SLineBreak+
      '          CR.VENCIMENTO_REC - COALESCE(CR.DATABAIXA_REC,CURRENT_DATE) RECEBER_DIASATRASO '+SLineBreak+
      '    FROM  CLIENTES C                                                                     '+SLineBreak+
      '    INNER JOIN CONTASRECEBER R ON                                                        '+SLineBreak+
      '          C.CODIGO_CLI = R.CODIGO_CLI                                                    '+SLineBreak+
      '    INNER JOIN CONTASRECEBERITENS CR ON                                                  '+SLineBreak+
      '          R.FATURA_REC = CR.FATURA_REC                                                   '+SLineBreak+
      '    WHERE                                                                                '+SLineBreak+
      '          C.CODIGO_CLI =' +QuotedStr(pCliente)                                            +SLineBreak;

    lQry.Open(lSQL);

    if lQry.IsEmpty then
      Exit;

    lQry.First;
    while not lQry.Eof do
    begin
      FValorEmAberto := FValorEmAberto + (lQry.FieldByName('VLRPARCELA_REC').AsFloat-lQry.FieldByName('VALORREC_REC').AsFloat);
//      FValorDeJuros  := FValorDeJuros + Self.CalculaJurosAtraso(lQry.FieldByName('EMPRESA_PERCENTUALJUROS').AsFloat,
//                                                                lQry.FieldByName('RECEBER_VALORPARCELA').AsFloat-lQry.FieldByName('RECEBER_VALORRECEBIDO').AsFloat,
//                                                                lQry.FieldByName('EMPRESA_LIMITEATRASO').AsInteger,
//                                                                lQry.FieldByName('RECEBER_VENCIMENTO').AsDateTime
//                                                                );
      FValorEmAbertoComJuros := FValorEmAberto+FValorDeJuros;

      if lQry.FieldByName('VENCIMENTO_REC').AsDateTime < Now then
        FValorEmAtraso := FValorEmAtraso + (lQry.FieldByName('VLRPARCELA_REC').AsFloat-lQry.FieldByName('VALORREC_REC').AsFloat);

      if lQry.FieldByName('VENCIMENTO_REC').AsDateTime >= Now then
        FValorAVencer := FValorAVencer + (lQry.FieldByName('VLRPARCELA_REC').AsFloat-lQry.FieldByName('VALORREC_REC').AsFloat);

      FValorComprasRealizadasAPrazo := FValorComprasRealizadasAPrazo + lQry.FieldByName('VLRPARCELA_REC').AsFloat;

      lQry.Next;
    end;

  finally
    lQry.Free;
  end;
end;

function TSituacaoFinanceiraDao.ObterDetalhesBaixa(pFatura, pParcela: String): IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSQL :=
      'SELECT                                                                                             '+SLineBreak+
      '    LANCAMENTODATA,                                                                                '+SLineBreak+
      '    LANCAMENTOHISTORICO,                                                                           '+SLineBreak+
      '    LANCAMENTOVALOR,                                                                               '+SLineBreak+
      '    LANCAMENTOPARCELA,                                                                             '+SLineBreak+
      '    LANCAMENTONUMERO,                                                                              '+SLineBreak+
      '    LANCAMENTOLOCAL,                                                                               '+SLineBreak+
      '    LANCAMENTOCLIENTE,                                                                             '+SLineBreak+
      '    SYSTIME                                                                                        '+SLineBreak+
      'FROM (                                                                                             '+SLineBreak+
      '    SELECT                                                                                         '+SLineBreak+
      '        C.DATA_COR AS LANCAMENTODATA,                                                              '+SLineBreak+
      '        C.OBSERVACAO_COR AS LANCAMENTOHISTORICO,                                                   '+SLineBreak+
      '        C.VALOR_COR AS LANCAMENTOVALOR,                                                            '+SLineBreak+
      '        C.PARCELA_COR AS LANCAMENTOPARCELA,                                                        '+SLineBreak+
      '        C.NUMERO_COR AS LANCAMENTONUMERO,                                                          '+SLineBreak+
      '        B.NOME_BAN AS LANCAMENTOLOCAL,                                                             '+SLineBreak+
      '        C.CLIENTE_COR AS LANCAMENTOCLIENTE,                                                        '+SLineBreak+
      '        C.SYSTIME AS SYSTIME                                                                       '+SLineBreak+
      '    FROM                                                                                           '+SLineBreak+
      '        CONTACORRENTE C                                                                            '+SLineBreak+
      '        LEFT JOIN BANCO B ON B.NUMERO_BAN = C.CODIGO_BAN                                           '+SLineBreak+
      '    WHERE                                                                                          '+SLineBreak+
      '        C.FATURA_COR = '+QuotedStr(pFatura)+' AND C.PARCELA_COR = '+QuotedStr(pParcela)+'          '+SLineBreak+
      '        AND C.STATUS <> ''X''                                                                      '+SLineBreak+
      '                                                                                                   '+SLineBreak+
      '    UNION ALL                                                                                      '+SLineBreak+
      '                                                                                                   '+SLineBreak+
      '    SELECT                                                                                         '+SLineBreak+
      '        CAIXA.DATA_CAI AS LANCAMENTODATA,                                                          '+SLineBreak+
      '        CAIXA.HISTORICO_CAI AS LANCAMENTOHISTORICO,                                                '+SLineBreak+
      '        CAIXA.VALOR_CAI AS LANCAMENTOVALOR,                                                        '+SLineBreak+
      '        CAIXA.PARCELA_CAI AS LANCAMENTOPARCELA,                                                    '+SLineBreak+
      '        CAIXA.NUMERO_CAI AS LANCAMENTONUMERO,                                                      '+SLineBreak+
      '      ''CAIXA'' AS LANCAMENTOLOCAL,                                                                '+SLineBreak+
      '        CAIXA.CLIENTE_CAI AS LANCAMENTOCLIENTE,                                                    '+SLineBreak+
      '        CAIXA.SYSTIME AS SYSTIME                                                                   '+SLineBreak+
      '    FROM                                                                                           '+SLineBreak+
      '        CAIXA                                                                                      '+SLineBreak+
      '    WHERE                                                                                          '+SLineBreak+
      '        CAIXA.FATURA_CAI = '+QuotedStr(pFatura)+' AND CAIXA.PARCELA_CAI = '+QuotedStr(pParcela)+'  '+SLineBreak+
      '        AND CAIXA.STATUS <> ''X''                                                                  '+SLineBreak+
      '                                                                                                   '+SLineBreak+
      '    UNION ALL                                                                                      '+SLineBreak+
      '                                                                                                   '+SLineBreak+
      '    SELECT                                                                                         '+SLineBreak+
      '        U.DATA AS LANCAMENTODATA,                                                                  '+SLineBreak+
      '      ''BAIXA PELO CRÉDITO CLIENTE'' AS LANCAMENTOHISTORICO,                                       '+SLineBreak+
      '        U.VALOR AS LANCAMENTOVALOR,                                                                '+SLineBreak+
      '        U.PARCELA AS LANCAMENTOPARCELA,                                                            '+SLineBreak+
      '        U.ID AS LANCAMENTONUMERO,                                                                  '+SLineBreak+
      '      ''CRÉDITO CLIENTE'' AS LANCAMENTOLOCAL,                                                      '+SLineBreak+
      '        C.CLIENTE_ID AS LANCAMENTOCLIENTE,                                                         '+SLineBreak+
      '        U.SYSTIME AS SYSTIME                                                                       '+SLineBreak+
      '    FROM                                                                                           '+SLineBreak+
      '        CREDITO_CLIENTE C                                                                          '+SLineBreak+
      '        LEFT JOIN CREDITO_CLIENTE_USO U ON U.CREDITO_CLIENTE_ID = C.ID                             '+SLineBreak+
      '    WHERE                                                                                          '+SLineBreak+
      '        U.RECEBER_ID = '+QuotedStr(pFatura)+' AND U.PARCELA = '+QuotedStr(pParcela)+'              '+SLineBreak+
      ') AS LANCAMENTOS                                                                                   '+SLineBreak+
      'ORDER BY                                                                                           '+SLineBreak+
      '    SYSTIME                                                                                        '+SLineBreak;

    lQry.Open(lSQL);
    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

function TSituacaoFinanceiraDao.ObterCredito(pCliente: String): Double;
var
  lQry       : TFDQuery;
  lSQL       : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSQL :=
      'SELECT                                                            '+SLineBreak+
      '    SUM(c.valor - (SELECT COALESCE(SUM(u.valor), 0)               '+SLineBreak+
      '                    FROM credito_cliente_uso u                    '+SLineBreak+
      '                    WHERE u.credito_cliente_id = c.id)) AS Valor  '+SLineBreak+
      'FROM                                                              '+SLineBreak+
      '    credito_cliente c                                             '+SLineBreak+
      'WHERE                                                             '+SLineBreak+
      '    c.tipo = ''C''                                                '+SLineBreak+
      '    AND c.cliente_id = '+QuotedStr(pCliente)+'                    '+SLineBreak+
      '    AND (c.valor - (SELECT COALESCE(SUM(u.valor), 0)              '+SLineBreak+
      '                    FROM credito_cliente_uso u                    '+SLineBreak+
      '                    WHERE u.credito_cliente_id = c.id)) > 0       '+SLineBreak;

    lQry.Open(lSQL);
    Result := lQry.FieldByName('Valor').AsFloat;
  finally
    lQry.Free;
  end;
end;

procedure TSituacaoFinanceiraDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSituacaoFinanceiraDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSituacaoFinanceiraDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TSituacaoFinanceiraDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSituacaoFinanceiraDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TSituacaoFinanceiraDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TSituacaoFinanceiraDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TSituacaoFinanceiraDao.SetValorAVencer(const Value: Double);
begin
  FValorAVencer := Value;
end;

procedure TSituacaoFinanceiraDao.SetValorComprasRealizadasAPrazo(
  const Value: Double);
begin
  FValorComprasRealizadasAPrazo := Value;
end;

procedure TSituacaoFinanceiraDao.SetValorDeJuros(const Value: Double);
begin
  FValorDeJuros := Value;
end;

procedure TSituacaoFinanceiraDao.SetValorEmAberto(const Value: Double);
begin
  FValorEmAberto := Value;
end;

procedure TSituacaoFinanceiraDao.SetValorEmAbertoComJuros(const Value: Double);
begin
  FValorEmAbertoComJuros := Value;
end;

procedure TSituacaoFinanceiraDao.SetValorEmAtraso(const Value: Double);
begin
  FValorEmAtraso := Value;
end;

procedure TSituacaoFinanceiraDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TSituacaoFinanceiraDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and ID = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

end.
