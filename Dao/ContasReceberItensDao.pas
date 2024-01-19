unit ContasReceberItensDao;

interface

uses
  ContasReceberItensModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Types,
  LojasModel,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TContasReceberItensDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FContasReceberItenssLista: TObjectList<TContasReceberItensModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDContasReceberView: String;
    FRecebimentoContasReceberLista: TObjectList<TRecebimentoContasReceber>;
    FParcelaView: String;
    procedure SetCountView(const Value: String);
    procedure SetContasReceberItenssLista(const Value: TObjectList<TContasReceberItensModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDContasReceberView(const Value: String);
    procedure SetRecebimentoContasReceberLista(const Value: TObjectList<TRecebimentoContasReceber>);
    procedure SetParcelaView(const Value: String);

  public
    constructor Create(pIConexao: IConexao);
    destructor Destroy; override;
    property ContasReceberItenssLista: TObjectList<TContasReceberItensModel> read FContasReceberItenssLista write SetContasReceberItenssLista;
    property RecebimentoContasReceberLista: TObjectList<TRecebimentoContasReceber> read FRecebimentoContasReceberLista write SetRecebimentoContasReceberLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDContasReceberView: String read FIDContasReceberView write SetIDContasReceberView;
    property ParcelaView: String read FParcelaView write SetParcelaView;
    function incluir(AContasReceberItensModel: TContasReceberItensModel): String;
    function alterar(AContasReceberItensModel: TContasReceberItensModel): String;
    function excluir(AContasReceberItensModel: TContasReceberItensModel): String;

    procedure obterTotalRegistros;
    procedure obterLista;
    procedure obterRecebimentoContasReceber;
    function obterContaCliente(pContaClienteParametros: TContaClienteParametros): TListaContaClienteRetorno;
    function carregaClasse(pId: String): TContasReceberItensModel;
    function where: String;

    function gerarChamadaTEF(pFatura, pTefModalidade, pTefParcelamento, pTefAdquirente: String): String;
    procedure setParams(var pQry: TFDQuery; pContasReceberItensModel: TContasReceberItensModel);
    procedure setParamsArray(var pQry: TFDQuery; pContasReceberItensModel: TContasReceberItensModel);
end;

implementation

uses
  System.Rtti;

{ TContasReceberItens }

function TContasReceberItensDao.carregaClasse(pId: String): TContasReceberItensModel;
var
  lQry: TFDQuery;
  lModel: TContasReceberItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContasReceberItensModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from contasreceberitens where id = '+pId);
    if lQry.IsEmpty then
      Exit;
    lModel.ID                     := lQry.FieldByName('ID').AsString;
    lModel.FATURA_REC             := lQry.FieldByName('FATURA_REC').AsString;
    lModel.CODIGO_CLI             := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.POSICAO_ID             := lQry.FieldByName('POSICAO_ID').AsString;
    lModel.VENCIMENTO_REC         := lQry.FieldByName('VENCIMENTO_REC').AsString;
    lModel.PACELA_REC             := lQry.FieldByName('PACELA_REC').AsString;
    lModel.VLRPARCELA_REC         := lQry.FieldByName('VLRPARCELA_REC').AsString;
    lModel.VALORREC_REC           := lQry.FieldByName('VALORREC_REC').AsString;
    lModel.DATABAIXA_REC          := lQry.FieldByName('DATABAIXA_REC').AsString;
    lModel.SITUACAO_REC           := lQry.FieldByName('SITUACAO_REC').AsString;
    lModel.TOTALPARCELAS_REC      := lQry.FieldByName('TOTALPARCELAS_REC').AsString;
    lModel.CODIGO_POR             := lQry.FieldByName('CODIGO_POR').AsString;
    lModel.CODIGO_CON             := lQry.FieldByName('CODIGO_CON').AsString;
    lModel.DESTITULO_REC          := lQry.FieldByName('DESTITULO_REC').AsString;
    lModel.NOSSO_NUMERO           := lQry.FieldByName('NOSSO_NUMERO').AsString;
    lModel.CARTAO                 := lQry.FieldByName('CARTAO').AsString;
    lModel.OBSERVACAO             := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.VENCIMENTO_BOLETO      := lQry.FieldByName('VENCIMENTO_BOLETO').AsString;
    lModel.COMISSAO               := lQry.FieldByName('COMISSAO').AsString;
    lModel.COMISSAO_BASE          := lQry.FieldByName('COMISSAO_BASE').AsString;
    lModel.LOJA                   := lQry.FieldByName('LOJA').AsString;
    lModel.SYSTIME                := lQry.FieldByName('SYSTIME').AsString;
    lModel.DATA_ACEITE            := lQry.FieldByName('DATA_ACEITE').AsString;
    lModel.USUARIO_ACEITE         := lQry.FieldByName('USUARIO_ACEITE').AsString;
    lModel.VALOR_PAGO             := lQry.FieldByName('VALOR_PAGO').AsString;
    lModel.NF_FATURA              := lQry.FieldByName('NF_FATURA').AsString;
    lModel.OBS                    := lQry.FieldByName('OBS').AsString;
    lModel.VAUCHER_CLIENTE_ID     := lQry.FieldByName('VAUCHER_CLIENTE_ID').AsString;
    lModel.VALOR_DESCONTO_CARTAO  := lQry.FieldByName('VALOR_DESCONTO_CARTAO').AsString;
    lModel.VALOR_RECEBIDO_CARTAO  := lQry.FieldByName('VALOR_RECEBIDO_CARTAO').AsString;
    lModel.FATURA_RECEBIDA_CARTAO := lQry.FieldByName('FATURA_RECEBIDA_CARTAO').AsString;
    lModel.VALOR_JUROS_CARTAO     := lQry.FieldByName('VALOR_JUROS_CARTAO').AsString;
    lModel.TEF_CHAMADA            := lQry.FieldByName('TEF_CHAMADA').AsString;
    lModel.TEF_MODALIDADE         := lQry.FieldByName('TEF_MODALIDADE').AsString;
    lModel.TEF_PARCELAMENTO       := lQry.FieldByName('TEF_PARCELAMENTO').AsString;
    lModel.TEF_ADQUIRENTE         := lQry.FieldByName('TEF_ADQUIRENTE').AsString;
    lModel.PIX_IDENTIFICADOR      := lQry.FieldByName('PIX_IDENTIFICADOR').AsString;
    lModel.PIX_EMV                := lQry.FieldByName('PIX_EMV').AsString;
    lModel.PIX_EXPIRACAO          := lQry.FieldByName('PIX_EXPIRACAO').AsString;
    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TContasReceberItensDao.Create(pIConexao: IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TContasReceberItensDao.Destroy;
begin
  inherited;
end;

function TContasReceberItensDao.incluir(AContasReceberItensModel: TContasReceberItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTASRECEBERITENS','FATURA_REC');

  try
    lQry.SQL.Add(lSQL);
    lQry.Params.ArraySize := AContasReceberItensModel.ContasReceberItenssLista.Count;
    setParamsArray(lQry, AContasReceberItensModel);
    lQry.Execute(AContasReceberItensModel.ContasReceberItenssLista.Count, 0);
    Result := '';
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasReceberItensDao.alterar(AContasReceberItensModel: TContasReceberItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CONTASRECEBERITENS','FATURA_REC');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasReceberItensModel);
    lQry.ExecSQL;
    Result := AContasReceberItensModel.ID;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasReceberItensDao.excluir(AContasReceberItensModel: TContasReceberItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from contasreceberitens where ID = :ID',[AContasReceberItensModel.ID]);
   lQry.ExecSQL;
   Result := AContasReceberItensModel.ID;
  finally
    lQry.Free;
  end;
end;

function TContasReceberItensDao.gerarChamadaTEF(pFatura, pTefModalidade, pTefParcelamento, pTefAdquirente: String): String;
var
  lQry: TFDQuery;
  lSQL:String;
  lChamada: String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := '   update contasreceberitens                           '+SLineBreak+
          '      set tef_modalidade = :tef_modalidade,            '+SLineBreak+
          '          tef_parcelamento = :tef_parcelamento,        '+SLineBreak+
          '          tef_adquirente = :tef_adquirente,            '+SLineBreak+
          '          tef_chamada = :tef_chamada                   '+SLineBreak+
          '    where fatura_rec = :fatura_rec                     '+SLineBreak;

  try
    lChamada := vIConexao.Generetor('GEN_TEF_CHAMADA');

    lQry.SQL.Add(lSQL);
    lQry.ParamByName('tef_chamada').Value      := lChamada;
    lQry.ParamByName('tef_modalidade').Value   := pTefModalidade;
    lQry.ParamByName('tef_parcelamento').Value := pTefParcelamento;
    lQry.ParamByName('tef_adquirente').Value   := pTefAdquirente;
    lQry.ParamByName('fatura_rec').Value       := pFatura;
    lQry.ExecSQL;

    Result := lChamada;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasReceberItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';
  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;
  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and contasreceberitens.id = '+IntToStr(FIDRecordView);
  if FIDContasReceberView <> '' then
    lSQL := lSQL + ' and contasreceberitens.fatura_rec = '+ QuotedStr(FIDContasReceberView);
  Result := lSQL;
end;

procedure TContasReceberItensDao.obterTotalRegistros;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From contasreceberitens where 1=1 ';
    lSql := lSql + where;

    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;

function TContasReceberItensDao.obterContaCliente(pContaClienteParametros: TContaClienteParametros): TListaContaClienteRetorno;
var
  lSql          : String;
  lLojasModel,
  lLojas        : TLojasModel;
  lQry          : TFDQuery;
  lResultado    : TContaClienteRetorno;
begin
  lLojasModel := TLojasModel.Create(vIConexao);
  Result      := TListaSimplesCreator.CreateList<TContaClienteRetorno>;

  try
    lSql :=
      'select                                                                                                                                                                                                  '+SLineBreak+
      '       e.loja,                                                                                                                                                                                            '+SLineBreak+
      '       i.id,                                                                                                                                                                                              '+SLineBreak+
      '       i.vencimento_rec,                                                                                                                                                                                  '+SLineBreak+
      '       i.fatura_rec,                                                                                                                                                                                      '+SLineBreak+
      '       i.pacela_rec,                                                                                                                                                                                      '+SLineBreak+
      '       i.valorrec_rec,                                                                                                                                                                                    '+SLineBreak+
      '       i.totalparcelas_rec,                                                                                                                                                                               '+SLineBreak+
      '       i.vlrparcela_rec ,                                                                                                                                                                                 '+SLineBreak+
      '       p.RECEBIMENTO_CONTA_ID,                                                                                                                                                                            '+SLineBreak+
      '       r.CODIGO_CTA,                                                                                                                                                                                      '+SLineBreak;

    if pContaClienteParametros.Juros then
    begin
      lSql := lSql +
        '    case                                                                                                                                                                                              '+SLineBreak+
        '      when dateadd ( coalesce(e.limite_atrazo,0) day to case when i.databaixa_rec > i.vencimento_rec then coalesce(i.databaixa_rec,i.vencimento_rec) else i.vencimento_rec end  ) < current_date then '+SLineBreak+
        '        coalesce(c.juros_bol,e.juros_bol) / 100 * (i.vlrparcela_rec - i.valorrec_rec) * (DATEDIFF( day, case when i.databaixa_rec > i.vencimento_rec then coalesce(i.databaixa_rec,i.vencimento_rec)  '+SLineBreak+
        '      else i.vencimento_rec end, current_date )) + coalesce(c.multa,e.multa_bol) / 100 * (i.vlrparcela_rec - i.valorrec_rec)                                                                          '+SLineBreak+
        '    else 0                                                                                                                                                                                            '+SLineBreak+
        '    end juros,                                                                                                                                                                                        '+SLineBreak+
        '   (i.vlrparcela_rec - i.valorrec_rec) +                                                                                                                                                              '+SLineBreak+
        '    case                                                                                                                                                                                              '+SLineBreak+
        '      when dateadd (coalesce(e.limite_atrazo,0) day to case when i.databaixa_rec > i.vencimento_rec then coalesce(i.databaixa_rec,i.vencimento_rec) else i.vencimento_rec end) < current_date then    '+SLineBreak+
        '        coalesce(c.juros_bol,e.juros_bol) / 100 * (i.vlrparcela_rec - i.valorrec_rec) * (DATEDIFF( day, case when i.databaixa_rec > i.vencimento_rec then coalesce(i.databaixa_rec,i.vencimento_rec)  '+SLineBreak+
        '        else i.vencimento_rec end, current_date )) + coalesce(c.multa,e.multa_bol) / 100 * (i.vlrparcela_rec - i.valorrec_rec)                                                                        '+SLineBreak+
        '    else 0                                                                                                                                                                                            '+SLineBreak+
        '    end as aberto,                                                                                                                                                                                    '+SLineBreak;
    end
    else
    begin
      lSql := lSql +
        '    cast(0 as float) juros,                                                                                                                                                                           '+SLineBreak+
        '    (i.vlrparcela_rec - i.valorrec_rec)  as aberto,                                                                                                                                                   '+SLineBreak;
    end;

    lSql := lSql +
    '       i.pacela_rec||''/''||i.totalparcelas_rec as TOTAL_PARCELA,                                                                                                                                         '+SLineBreak+
    '       p.nome_port,                                                                                                                                                                                       '+SLineBreak+
    '       coalesce(r.os_rec,r.pedido_rec) pedido_rec,                                                                                                                                                        '+SLineBreak+
    '       ''0''  ctrBaixa,                                                                                                                                                                                   '+SLineBreak+
    '       cast(0 as float) desconto                                                                                                                                                                          '+SLineBreak+
    '  from contasreceberitens i                                                                                                                                                                               '+SLineBreak+
    ' inner join contasreceber r on i.fatura_rec = r.fatura_rec                                                                                                                                                '+SLineBreak+
    ' inner join portador p on i.codigo_por = p.codigo_port                                                                                                                                                    '+SLineBreak+
    ' inner join clientes c on c.codigo_cli = i.codigo_cli                                                                                                                                                     '+SLineBreak+
    '  left join boleto b on i.fatura_rec = b.fatura_rec and i.pacela_rec = b.parcela_rec                                                                                                                      '+SLineBreak+
    '  left join empresa e on 1=1                                                                                                                                                                              '+SLineBreak+
    ' where i.situacao_rec = ''A''                                                                                                                                                                             '+SLineBreak+
    '   and coalesce(p.situacao_cliente,''S'') = ''S''                                                                                                                                                         '+SLineBreak+
    '   and (i.vlrparcela_rec > i.valorrec_rec) and i.situacao_rec <> ''R'' and i.situacao_rec <> ''X''                                                                                                        '+SLineBreak;

    if not pContaClienteParametros.NSU.IsEmpty then
    begin
      if Length(pContaClienteParametros.NSU) = 44 then
        lSql := lSql + ' and b.codigobarras = ' + QuotedStr(pContaClienteParametros.NSU)
      else
        lSql := lSql + ' and b.linhadigitavel = ' + QuotedStr(pContaClienteParametros.NSU);
    end
    else if not pContaClienteParametros.Fatura.IsEmpty then
    begin
      lSql := lSql + ' and i.fatura_rec = ' + QuotedStr(pContaClienteParametros.Fatura);

      if pContaClienteParametros.Parcela.IsEmpty then
        lSql := lSql + ' and i.pacela_rec = ' + pContaClienteParametros.Parcela;

    end
    else
    begin
      if (pContaClienteParametros.DataInicio <> '') and (pContaClienteParametros.DataFim <> '') then
        lSql := lSql + ' and i.vencimento_rec between ' + QuotedStr(transformaDataFireBirdWhere(pContaClienteParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pContaClienteParametros.DataFim))
      else if pContaClienteParametros.DataInicio <> '' then
        lSql := lSql + ' and i.vencimento_rec >= ' + QuotedStr(transformaDataFireBirdWhere(pContaClienteParametros.DataInicio))
      else if pContaClienteParametros.DataFim <> '' then
        lSql := lSql + ' and i.vencimento_rec <= ' + QuotedStr(transformaDataFireBirdWhere(pContaClienteParametros.DataFim));
    end;

    if not pContaClienteParametros.Cliente.IsEmpty then
      lSql := lSql + ' and i.codigo_cli = ' + QuotedStr(pContaClienteParametros.Cliente);

    lSql := lSql + ' order by i.vencimento_rec ';

    if not pContaClienteParametros.Loja.IsEmpty then
      lLojasModel.LojaView := pContaClienteParametros.Loja;

    lLojasModel.obterLista;

    for lLojas in lLojasModel.LojassLista do
    begin
      vIConexao.ConfigConexao(llojas.LOJA);
      lQry := vIConexao.CriarQuery;

      lQry.Open(lSQL);

      lQry.First;
      while not lQry.Eof do
      begin
        lResultado.ID                     := lQry.FieldByName('ID').AsString;
        lResultado.LOJA                   := lQry.FieldByName('LOJA').AsString;
        lResultado.VENCIMENTO_REC         := lQry.FieldByName('VENCIMENTO_REC').AsString;
        lResultado.FATURA_REC             := lQry.FieldByName('FATURA_REC').AsString;
        lResultado.PACELA_REC             := lQry.FieldByName('PACELA_REC').AsString;
        lResultado.VALORREC_REC           := lQry.FieldByName('VALORREC_REC').AsString;
        lResultado.TOTALPARCELAS_REC      := lQry.FieldByName('TOTALPARCELAS_REC').AsString;
        lResultado.VLRPARCELA_REC         := lQry.FieldByName('VLRPARCELA_REC').AsString;
        lResultado.RECEBIMENTO_CONTA_ID   := lQry.FieldByName('RECEBIMENTO_CONTA_ID').AsString;
        lResultado.CODIGO_CTA             := lQry.FieldByName('CODIGO_CTA').AsString;
        lResultado.JUROS                  := lQry.FieldByName('JUROS').AsString;
        lResultado.ABERTO                 := lQry.FieldByName('ABERTO').AsString;
        lResultado.TOTAL_PARCELA          := lQry.FieldByName('TOTAL_PARCELA').AsString;
        lResultado.NOME_PORT              := lQry.FieldByName('NOME_PORT').AsString;
        lResultado.PEDIDO_REC             := lQry.FieldByName('PEDIDO_REC').AsString;
        lResultado.CTRBAIXA               := lQry.FieldByName('CTRBAIXA').AsString;
        lResultado.DESCONTO               := lQry.FieldByName('DESCONTO').AsString;

        Result.add(lResultado);

        lQry.Next;
      end;

    end;

  finally
    lLojasModel.Free;
  end;

end;

procedure TContasReceberItensDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin

  lQry := vIConexao.CriarQuery;

  FContasReceberItenssLista := TObjectList<TContasReceberItensModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       contasreceberitens.*,                                                          '+SLineBreak+
      '       portador.nome_port,                                                            '+SLineBreak+
      '       contasreceber.pedido_rec,                                                      '+SLineBreak+
      '       clientes.fantasia_cli                                                          '+SLineBreak+
	    '  from contasreceberitens                                                             '+SLineBreak+
      ' inner join portador on contasreceberitens.codigo_por = portador.codigo_port          '+SLineBreak+
      ' inner join contasreceber on contasreceberitens.fatura_rec = contasreceber.fatura_rec '+SLineBreak+
      ' inner join clientes on contasreceber.codigo_cli = clientes.codigo_cli                '+SLineBreak+
      ' where 1=1                                                                            '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FContasReceberItenssLista.Add(TContasReceberItensModel.Create(vIConexao));

      i := FContasReceberItenssLista.Count -1;

      FContasReceberItenssLista[i].ID                      := lQry.FieldByName('ID').AsString;
      FContasReceberItenssLista[i].FATURA_REC              := lQry.FieldByName('FATURA_REC').AsString;
      FContasReceberItenssLista[i].CODIGO_CLI              := lQry.FieldByName('CODIGO_CLI').AsString;
      FContasReceberItenssLista[i].POSICAO_ID              := lQry.FieldByName('POSICAO_ID').AsString;
      FContasReceberItenssLista[i].VENCIMENTO_REC          := lQry.FieldByName('VENCIMENTO_REC').AsString;
      FContasReceberItenssLista[i].PACELA_REC              := lQry.FieldByName('PACELA_REC').AsString;
      FContasReceberItenssLista[i].VLRPARCELA_REC          := lQry.FieldByName('VLRPARCELA_REC').AsString;
      FContasReceberItenssLista[i].VALORREC_REC            := lQry.FieldByName('VALORREC_REC').AsString;
      FContasReceberItenssLista[i].DATABAIXA_REC           := lQry.FieldByName('DATABAIXA_REC').AsString;
      FContasReceberItenssLista[i].SITUACAO_REC            := lQry.FieldByName('SITUACAO_REC').AsString;
      FContasReceberItenssLista[i].TOTALPARCELAS_REC       := lQry.FieldByName('TOTALPARCELAS_REC').AsString;
      FContasReceberItenssLista[i].CODIGO_POR              := lQry.FieldByName('CODIGO_POR').AsString;
      FContasReceberItenssLista[i].CODIGO_CON              := lQry.FieldByName('CODIGO_CON').AsString;
      FContasReceberItenssLista[i].DESTITULO_REC           := lQry.FieldByName('DESTITULO_REC').AsString;
      FContasReceberItenssLista[i].NOSSO_NUMERO            := lQry.FieldByName('NOSSO_NUMERO').AsString;
      FContasReceberItenssLista[i].CARTAO                  := lQry.FieldByName('CARTAO').AsString;
      FContasReceberItenssLista[i].OBSERVACAO              := lQry.FieldByName('OBSERVACAO').AsString;
      FContasReceberItenssLista[i].VENCIMENTO_BOLETO       := lQry.FieldByName('VENCIMENTO_BOLETO').AsString;
      FContasReceberItenssLista[i].COMISSAO                := lQry.FieldByName('COMISSAO').AsString;
      FContasReceberItenssLista[i].COMISSAO_BASE           := lQry.FieldByName('COMISSAO_BASE').AsString;
      FContasReceberItenssLista[i].LOJA                    := lQry.FieldByName('LOJA').AsString;
      FContasReceberItenssLista[i].SYSTIME                 := lQry.FieldByName('SYSTIME').AsString;
      FContasReceberItenssLista[i].DATA_ACEITE             := lQry.FieldByName('DATA_ACEITE').AsString;
      FContasReceberItenssLista[i].USUARIO_ACEITE          := lQry.FieldByName('USUARIO_ACEITE').AsString;
      FContasReceberItenssLista[i].VALOR_PAGO              := lQry.FieldByName('VALOR_PAGO').AsString;
      FContasReceberItenssLista[i].NF_FATURA               := lQry.FieldByName('NF_FATURA').AsString;
      FContasReceberItenssLista[i].OBS                     := lQry.FieldByName('OBS').AsString;
      FContasReceberItenssLista[i].VAUCHER_CLIENTE_ID      := lQry.FieldByName('VAUCHER_CLIENTE_ID').AsString;
      FContasReceberItenssLista[i].VALOR_DESCONTO_CARTAO   := lQry.FieldByName('VALOR_DESCONTO_CARTAO').AsString;
      FContasReceberItenssLista[i].VALOR_RECEBIDO_CARTAO   := lQry.FieldByName('VALOR_RECEBIDO_CARTAO').AsString;
      FContasReceberItenssLista[i].FATURA_RECEBIDA_CARTAO  := lQry.FieldByName('FATURA_RECEBIDA_CARTAO').AsString;
      FContasReceberItenssLista[i].VALOR_JUROS_CARTAO      := lQry.FieldByName('VALOR_JUROS_CARTAO').AsString;
      FContasReceberItenssLista[i].TEF_CHAMADA             := lQry.FieldByName('TEF_CHAMADA').AsString;
      FContasReceberItenssLista[i].TEF_MODALIDADE          := lQry.FieldByName('TEF_MODALIDADE').AsString;
      FContasReceberItenssLista[i].TEF_PARCELAMENTO        := lQry.FieldByName('TEF_PARCELAMENTO').AsString;
      FContasReceberItenssLista[i].TEF_ADQUIRENTE          := lQry.FieldByName('TEF_ADQUIRENTE').AsString;
      FContasReceberItenssLista[i].PIX_IDENTIFICADOR       := lQry.FieldByName('PIX_IDENTIFICADOR').AsString;
      FContasReceberItenssLista[i].PIX_EMV                 := lQry.FieldByName('PIX_EMV').AsString;
      FContasReceberItenssLista[i].PIX_EXPIRACAO           := lQry.FieldByName('PIX_EXPIRACAO').AsString;
      FContasReceberItenssLista[i].PORTADOR_NOME           := lQry.FieldByName('NOME_PORT').AsString;
      FContasReceberItenssLista[i].PEDIDO_REC              := lQry.FieldByName('PEDIDO_REC').AsString;
      FContasReceberItenssLista[i].CLIENTE_NOME            := lQry.FieldByName('FANTASIA_CLI').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TContasReceberItensDao.obterRecebimentoContasReceber;
var
  lQry : TFDQuery;
  lSQL : String;
  i    : INteger;
begin
  lQry := vIConexao.CriarQuery;

  FRecebimentoContasReceberLista := TObjectList<TRecebimentoContasReceber>.Create;
  try
    lSQL := '  select c.numero_cai id, coalesce(p.nome_port,''DINHEIRO'') tipo, coalesce(c.valor_cai,0) valor, ''CAIXA'' ORIGEM                '+SLineBreak+
            '    from caixa c                                                                                                                  '+SLineBreak+
            '    left join portador p on p.codigo_port = c.portador_cai                                                                        '+SLineBreak+
            '   where c.fatura_cai = '+ QuotedStr(FIDContasReceberView)                                                                         +SLineBreak+
            '     and c.parcela_cai = '+ FParcelaView                                                                                           +SLineBreak+
            '     and c.tipo_cai = ''C''                                                                                                       '+SLineBreak+
            '     and c.status <> ''X''                                                                                                        '+SLineBreak+
            '   union all                                                                                                                      '+SLineBreak+
            '  select r.id, case when r.tef_id <> '''' then ''TEF: '' else '''' end || a.nome_adm tipo,                                        '+SLineBreak+
            '         coalesce(r.valor,0) valor, ''RECEBIMENTO_CARTAO'' ORIGEM                                                                 '+SLineBreak+
            '    from recebimento_cartao r                                                                                                     '+SLineBreak+
            '   inner join admcartao a on a.id = r.bandeira_id                                                                                 '+SLineBreak+
            '   where r.fatura = '+ QuotedStr(FIDContasReceberView)                                                                             +SLineBreak+
            '     and r.parcela = '+ FParcelaView                                                                                               +SLineBreak+
            '   union all                                                                                                                      '+SLineBreak+
            '  select c.numero_cor, coalesce(p.nome_port, ''RECEBIMENTO EM CONTA CORRENTE'') tipo, c.valor_cor valor, ''CONTACORRENTE'' ORIGEM '+SLineBreak+
            '    from contacorrente c                                                                                                          '+SLineBreak+
            '    left join portador p on p.codigo_port = c.portador_cor                                                                        '+SLineBreak+
            '   where c.fatura_cor = ' + QuotedStr(FIDContasReceberView)                                                                        +SLineBreak+
            '     and c.parcela_cor = '+ FParcelaView                                                                                           +SLineBreak+
            '     and c.status <> ''X''                                                                                                        '+SLineBreak+
            '     and c.tipo_cta = ''C''                                                                                                       '+SLineBreak;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      if lQry.FieldByName('VALOR').AsFloat > 0 then begin
        FRecebimentoContasReceberLista.Add(TRecebimentoContasReceber.Create);
        i := FRecebimentoContasReceberLista.Count -1;
        FRecebimentoContasReceberLista[i].ID      := lQry.FieldByName('ID').AsString;
        FRecebimentoContasReceberLista[i].TIPO    := lQry.FieldByName('TIPO').AsString;
        FRecebimentoContasReceberLista[i].VALOR   := lQry.FieldByName('VALOR').AsString;
        FRecebimentoContasReceberLista[i].ORIGEM  := lQry.FieldByName('ORIGEM').AsString;
      end;
      lQry.Next;
    end;

  finally
    lQry.Free;
  end;
end;

procedure TContasReceberItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasReceberItensDao.SetContasReceberItenssLista(const Value: TObjectList<TContasReceberItensModel>);
begin
  FContasReceberItenssLista := Value;
end;

procedure TContasReceberItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasReceberItensDao.SetIDContasReceberView(const Value: String);
begin
  FIDContasReceberView := Value;
end;

procedure TContasReceberItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasReceberItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasReceberItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasReceberItensDao.setParams(var pQry: TFDQuery; pContasReceberItensModel: TContasReceberItensModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONTASRECEBERITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TContasReceberItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pContasReceberItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pContasReceberItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TContasReceberItensDao.setParamsArray(var pQry: TFDQuery; pContasReceberItensModel: TContasReceberItensModel);
var
  lCount: Integer;
begin
  for lCount := 0 to Pred(pContasReceberItensModel.ContasReceberItenssLista.Count) do
  begin
    pQry.ParamByName('fatura_rec').Values[lCount]                := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].FATURA_REC                = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].FATURA_REC);
    pQry.ParamByName('codigo_cli').Values[lCount]                := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].CODIGO_CLI                = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].CODIGO_CLI);
    pQry.ParamByName('posicao_id').Values[lCount]                := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].POSICAO_ID                = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].POSICAO_ID);
    pQry.ParamByName('vencimento_rec').Values[lCount]            := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VENCIMENTO_REC            = '', Unassigned, transformaDataFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].VENCIMENTO_REC));
    pQry.ParamByName('pacela_rec').Values[lCount]                := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].PACELA_REC                = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].PACELA_REC);
    pQry.ParamByName('vlrparcela_rec').Values[lCount]            := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VLRPARCELA_REC            = '', Unassigned, FormataFloatFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].VLRPARCELA_REC));
    pQry.ParamByName('valorrec_rec').Values[lCount]              := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALORREC_REC              = '', Unassigned, FormataFloatFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALORREC_REC));
    pQry.ParamByName('databaixa_rec').Values[lCount]             := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].DATABAIXA_REC             = '', Unassigned, transformaDataFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].DATABAIXA_REC));
    pQry.ParamByName('situacao_rec').Values[lCount]              := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].SITUACAO_REC              = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].SITUACAO_REC);
    pQry.ParamByName('totalparcelas_rec').Values[lCount]         := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].TOTALPARCELAS_REC         = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].TOTALPARCELAS_REC);
    pQry.ParamByName('codigo_por').Values[lCount]                := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].CODIGO_POR                = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].CODIGO_POR);
    pQry.ParamByName('codigo_con').Values[lCount]                := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].CODIGO_CON                = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].CODIGO_CON);
    pQry.ParamByName('destitulo_rec').Values[lCount]             := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].DESTITULO_REC             = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].DESTITULO_REC);
    pQry.ParamByName('nosso_numero').Values[lCount]              := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].NOSSO_NUMERO              = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].NOSSO_NUMERO);
    pQry.ParamByName('cartao').Values[lCount]                    := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].CARTAO                    = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].CARTAO);
    pQry.ParamByName('observacao').Values[lCount]                := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].OBSERVACAO                = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].OBSERVACAO);
    pQry.ParamByName('vencimento_boleto').Values[lCount]         := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VENCIMENTO_BOLETO         = '', Unassigned, transformaDataFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].VENCIMENTO_BOLETO));
    pQry.ParamByName('comissao').Values[lCount]                  := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].COMISSAO                  = '', Unassigned, FormataFloatFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].COMISSAO));
    pQry.ParamByName('comissao_base').Values[lCount]             := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].COMISSAO_BASE             = '', Unassigned, FormataFloatFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].COMISSAO_BASE));
    pQry.ParamByName('loja').Values[lCount]                      := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].LOJA                      = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].LOJA);
    pQry.ParamByName('data_aceite').Values[lCount]               := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].DATA_ACEITE               = '', Unassigned, transformaDataFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].DATA_ACEITE));
    pQry.ParamByName('usuario_aceite').Values[lCount]            := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].USUARIO_ACEITE            = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].USUARIO_ACEITE);
    pQry.ParamByName('valor_pago').Values[lCount]                := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALOR_PAGO                = '', Unassigned, FormataFloatFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALOR_PAGO));
    pQry.ParamByName('nf_fatura').Values[lCount]                 := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].NF_FATURA                 = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].NF_FATURA);
    pQry.ParamByName('obs').Values[lCount]                       := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].OBS                       = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].OBS);
    pQry.ParamByName('vaucher_cliente_id').Values[lCount]        := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VAUCHER_CLIENTE_ID        = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].VAUCHER_CLIENTE_ID);
    pQry.ParamByName('valor_desconto_cartao').Values[lCount]     := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALOR_DESCONTO_CARTAO     = '', Unassigned, FormataFloatFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALOR_DESCONTO_CARTAO));
    pQry.ParamByName('valor_recebido_cartao').Values[lCount]     := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALOR_RECEBIDO_CARTAO     = '', Unassigned, FormataFloatFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALOR_RECEBIDO_CARTAO));
    pQry.ParamByName('fatura_recebida_cartao').Values[lCount]    := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].FATURA_RECEBIDA_CARTAO    = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].FATURA_RECEBIDA_CARTAO);
    pQry.ParamByName('valor_juros_cartao').Values[lCount]        := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALOR_JUROS_CARTAO        = '', Unassigned, FormataFloatFireBird(pContasReceberItensModel.ContasReceberItenssLista[lCount].VALOR_JUROS_CARTAO));
    pQry.ParamByName('tef_chamada').Values[lCount]               := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].TEF_CHAMADA               = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].TEF_CHAMADA);
    pQry.ParamByName('tef_modalidade').Values[lCount]            := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].TEF_MODALIDADE            = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].TEF_MODALIDADE);
    pQry.ParamByName('tef_parcelamento').Values[lCount]          := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].TEF_PARCELAMENTO          = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].TEF_PARCELAMENTO);
    pQry.ParamByName('tef_adquirente').Values[lCount]            := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].TEF_ADQUIRENTE            = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].TEF_ADQUIRENTE);
    pQry.ParamByName('pix_identificador').Values[lCount]         := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].PIX_IDENTIFICADOR         = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].PIX_IDENTIFICADOR);
    pQry.ParamByName('pix_emv').Values[lCount]                   := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].PIX_EMV                   = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].PIX_EMV);
    pQry.ParamByName('pix_expiracao').Values[lCount]             := IIF(pContasReceberItensModel.ContasReceberItenssLista[lCount].PIX_EXPIRACAO             = '', Unassigned, pContasReceberItensModel.ContasReceberItenssLista[lCount].PIX_EXPIRACAO);
  end;
end;

procedure TContasReceberItensDao.SetParcelaView(const Value: String);
begin
  FParcelaView := Value;
end;

procedure TContasReceberItensDao.SetRecebimentoContasReceberLista(const Value: TObjectList<TRecebimentoContasReceber>);
begin
  FRecebimentoContasReceberLista := Value;
end;

procedure TContasReceberItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasReceberItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasReceberItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
