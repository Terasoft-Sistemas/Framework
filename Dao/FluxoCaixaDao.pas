unit FluxoCaixaDao;

interface

uses
  FluxoCaixaModel,
  ContaCorrenteModel,
  Interfaces.Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.FuncoesTexto;

type
  TFluxoCaixaDao = class

  private

    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FFluxoCaixasLista: TObjectList<TFluxoCaixaModel>;
    FWhereView: String;
    FPorcentagemInadimplenciaView: Real;
    FBancoView: String;
    FPortadorView: String;
    FDataFinalView: Variant;
    FDataInicialView: Variant;
    FSomarBancosView: Boolean;
    FResumo_A_Pagar: Real;
    FResumo_A_Receber: Real;
    FResumo_A_Receber_Registros: Integer;
    FResumo_A_Pagar_Registros: Integer;
    FResultado_APagar: Real;
    FResultado_SaldoAtualBancos: Real;
    FResultado_Inadimplencia: Real;
    FResultado_Total: Real;
    FResultado_AReceber: Real;
    FOrderView: String;
    procedure SetFluxoCaixasLista(const Value: TObjectList<TFluxoCaixaModel>);
    procedure SetWhereView(const Value: String);

    procedure SetBancoView(const Value: String);
    procedure SetDataFinalView(const Value: Variant);
    procedure SetDataInicialView(const Value: Variant);
    procedure SetPorcentagemInadimplenciaView(const Value: Real);
    procedure SetPortadorView(const Value: String);
    procedure SetSomarBancosView(const Value: Boolean);
    procedure SetResumo_A_Pagar(const Value: Real);
    procedure SetResumo_A_Receber(const Value: Real);
    procedure SetResumo_A_Pagar_Registros(const Value: Integer);
    procedure SetResumo_A_Receber_Registros(const Value: Integer);
    procedure SetResultado_APagar(const Value: Real);
    procedure SetResultado_AReceber(const Value: Real);
    procedure SetResultado_Inadimplencia(const Value: Real);
    procedure SetResultado_SaldoAtualBancos(const Value: Real);
    procedure SetResultado_Total(const Value: Real);
    procedure SetOrderView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property FluxoCaixasLista: TObjectList<TFluxoCaixaModel> read FFluxoCaixasLista write SetFluxoCaixasLista;
    property WhereView: String read FWhereView write SetWhereView;
    property OrderView: String read FOrderView write SetOrderView;
    property DataInicialView: Variant read FDataInicialView write SetDataInicialView;
    property DataFinalView: Variant read FDataFinalView write SetDataFinalView;
    property BancoView: String read FBancoView write SetBancoView;
    property PortadorView: String read FPortadorView write SetPortadorView;
    property PorcentagemInadimplenciaView: Real read FPorcentagemInadimplenciaView write SetPorcentagemInadimplenciaView;
    property SomarBancosView: Boolean read FSomarBancosView write SetSomarBancosView;

    property Resumo_A_Receber: Real read FResumo_A_Receber write SetResumo_A_Receber;
    property Resumo_A_Receber_Registros: Integer read FResumo_A_Receber_Registros write SetResumo_A_Receber_Registros;
    property Resumo_A_Pagar: Real read FResumo_A_Pagar write SetResumo_A_Pagar;
    property Resumo_A_Pagar_Registros: Integer read FResumo_A_Pagar_Registros write SetResumo_A_Pagar_Registros;

    property Resultado_SaldoAtualBancos: Real read FResultado_SaldoAtualBancos write SetResultado_SaldoAtualBancos;
    property Resultado_AReceber: Real read FResultado_AReceber write SetResultado_AReceber;
    property Resultado_Inadimplencia: Real read FResultado_Inadimplencia write SetResultado_Inadimplencia;
    property Resultado_APagar: Real read FResultado_APagar write SetResultado_APagar;
    property Resultado_Total: Real read FResultado_Total write SetResultado_Total;

    function obterFluxoCaixaSintetico : TFDMemTable;
    function obterFluxoCaixaAnalitico : TFDMemTable;
    function obterResumo: TFDMemTable;
    procedure obterResultadoFluxoCaixa;

end;

implementation

uses
  System.Math, System.SysUtils;

{ TFluxoCaixa }

constructor TFluxoCaixaDao.Create(pIConexao : Iconexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TFluxoCaixaDao.Destroy;
begin

  inherited;
end;

function TFluxoCaixaDao.obterFluxoCaixaSintetico : TFDMemTable;
var
  lQry               : TFDQuery;
  lSql               : String;
  lMemTable          : TFDMemTable;
  lPaginacao         : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSql := '  select                                                                                                                                     '+sLineBreak+
            '        VENCIMENTO,                                                                                                                          '+sLineBreak+
            '        SUM(PAGAR) as PAGAR,                                                                                                                 '+sLineBreak+
            '        SUM(RECEBER) as RECEBER,                                                                                                             '+sLineBreak+
            '        SUM(COMPRA) as COMPRA                                                                                                                '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '    from                                                                                                                                     '+sLineBreak+
            '        ( select                                                                                                                             '+sLineBreak+
            '                VENCIMENTO,                                                                                                                  '+sLineBreak+
            '                (case when tipo in (''PAGAR'',''PREVISAO'') then Aberto end) PAGAR,                                                          '+sLineBreak+
            '                (case when tipo = ''RECEBER'' then Aberto end) RECEBER,                                                                      '+sLineBreak+
            '                (case when tipo = ''COMPRA'' then Aberto end) COMPRA,                                                                        '+sLineBreak+
            '                portador_cod                                                                                                                 '+sLineBreak+
            '            from                                                                                                                             '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '             (select                                                                                                                         '+sLineBreak+
            '                    case when p.previsao = ''S'' then ''PREVISAO'' else ''PAGAR'' end as tipo,                                               '+sLineBreak+
            '                    i.dupliacata_pag as titulo,                                                                                              '+sLineBreak+
            '                    i.codigo_for as codigo_nome,                                                                                             '+sLineBreak+
            '                    f.fantasia_for as nome,                                                                                                  '+sLineBreak+
            '                    i.venc_pag as vencimento,                                                                                                '+sLineBreak+
            '                    p.dataemi_pag as emissao,                                                                                                '+sLineBreak+
            '                    i.pacela_pag||''/''||i.totalparcelas as parcela,                                                                         '+sLineBreak+
            '                    i.valorparcela_pag as valor,                                                                                             '+sLineBreak+
            '                    (i.valorparcela_pag - coalesce(i.valorpago_pag,0) - coalesce(i.desconto,0) ) as aberto,                                  '+sLineBreak+
            '                    pt.nome_port as portador,                                                                                                '+sLineBreak+
            '                    pt.codigo_port portador_cod                                                                                              '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                from                                                                                                                         '+sLineBreak+
            '                    contaspagaritens i                                                                                                       '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                      inner join contaspagar p on p.duplicata_pag = i.dupliacata_pag and p.codigo_for = i.codigo_for                         '+sLineBreak+
            '                      inner join fornecedor f on f.codigo_for = i.codigo_for                                                                 '+sLineBreak+
            '                      left join portador pt on i.portador_id = pt.codigo_port                                                                '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                where                                                                                                                        '+sLineBreak+
            '                    (i.situacao_pag = ''A'') and ((p.previsao is null) or (p.previsao = ''N''))                                              '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                union  all                                                                                                                   '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                       select                                                                                                                '+sLineBreak+
            '                             ''RECEBER'' as tipo,                                                                                            '+sLineBreak+
            '                             i.fatura_rec as titulo,                                                                                         '+sLineBreak+
            '                             i.codigo_cli as codigo_nome,                                                                                    '+sLineBreak+
            '                             f.fantasia_cli as nome,                                                                                         '+sLineBreak+
            '                             i.vencimento_rec as vencimento,                                                                                 '+sLineBreak+
            '                             p.dataemi_rec as emissao,                                                                                       '+sLineBreak+
            '                             i.pacela_rec||''/''||i.totalparcelas_rec as parcela,                                                            '+sLineBreak+
            '                             i.vlrparcela_rec as valor,                                                                                      '+sLineBreak+
            '                             (i.vlrparcela_rec - coalesce(i.valorrec_rec,0)) as aberto,                                                      '+sLineBreak+
            '                             pt.nome_port as portador,                                                                                       '+sLineBreak+
            '                             pt.codigo_port portador_cod                                                                                     '+sLineBreak+
            '                       from                                                                                                                  '+sLineBreak+
            '                           contasreceberitens i                                                                                              '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                             inner join contasreceber p on p.fatura_rec = i.fatura_rec                                                       '+sLineBreak+
            '                             inner join clientes f on f.codigo_cli = i.codigo_cli                                                            '+sLineBreak+
            '                             left join portador pt on i.codigo_por = pt.codigo_port                                                          '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                       where                                                                                                                 '+sLineBreak+
            '                          ((i.situacao_rec = ''A'') or (i.destitulo_rec = ''S''))                                                            '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                       union  all                                                                                                            '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                                   select                                                                                                    '+sLineBreak+
            '                                      ''COMPRA'' as tipo,                                                                                    '+sLineBreak+
            '                                       c.numero_ped as titulo,                                                                               '+sLineBreak+
            '                                       c.codigo_for as codigo_nome,                                                                          '+sLineBreak+
            '                                       f.fantasia_for as nome,                                                                               '+sLineBreak+
            '                                       v.vencimento as vencimento,                                                                           '+sLineBreak+
            '                                       c.data_ped as emissao,                                                                                '+sLineBreak+
            '                                       v.parcela||''/''||c.parcelas_ped as parcela,                                                          '+sLineBreak+
            '                                       sum(v.valor_parcela) valor,                                                                           '+sLineBreak+
            '                                       sum(v.valor_parcela) aberto,                                                                          '+sLineBreak+
            '                                       null as portador ,                                                                                    '+sLineBreak+
            '                                       null portador_cod                                                                                     '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                                   from                                                                                                      '+sLineBreak+
            '                                       pedidocompra c                                                                                        '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                                   inner join fornecedor f on c.codigo_for = f.codigo_for                                                    '+sLineBreak+
            '                                   inner join previsao_pedidocompra v on c.numero_ped = v.numero_ped and c.codigo_for = v.codigo_for         '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                                   where                                                                                                     '+sLineBreak+
            '                                      (select count(*) from pedidocompraitens i where i.numero_ped = c.numero_ped                            '+sLineBreak+
            '                                          and i.codigo_for = c.codigo_for and i.quantidade_ate < i.quantidade_ped)  > 0                      '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                                       group by 1,2,3,4,5,6,7                                                                                '+sLineBreak+
            '                                       )                                                                                                     '+sLineBreak+
            '                                   where 1=1                                                                                                 '+sLineBreak;

    lSql := lSql + where;

    lSql := lSql + '        )                                                                                                                             '+sLineBreak+
                   '        group by 1                                                                                                                    '+sLineBreak;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

function TFluxoCaixaDao.obterFluxoCaixaAnalitico : TFDMemTable;
var
  lQry: TFDQuery;
  lSql: String;
  i: Integer;
begin

  lQry := vIConexao.CriarQuery;

  try
    lSql := '  select                                                                                                                                     '+sLineBreak+
            '        TIPO,                                                                                                                                '+sLineBreak+
            '        TITULO,                                                                                                                              '+sLineBreak+
            '        CODIGO_NOME,                                                                                                                         '+sLineBreak+
            '        NOME,                                                                                                                                '+sLineBreak+
            '        VENCIMENTO,                                                                                                                          '+sLineBreak+
            '        EMISSAO,                                                                                                                             '+sLineBreak+
            '        PARCELA,                                                                                                                             '+sLineBreak+
            '        VALOR,                                                                                                                               '+sLineBreak+
            '        ABERTO,                                                                                                                              '+sLineBreak+
            '        PORTADOR,                                                                                                                            '+sLineBreak+
            '        PORTADOR_COD                                                                                                                         '+sLineBreak+
            '      from                                                                                                                                   '+sLineBreak+
            '           (select                                                                                                                           '+sLineBreak+
            '               case when p.previsao = ''S'' then ''PREVISAO'' else ''PAGAR'' end as tipo,                                                    '+sLineBreak+
            '               i.dupliacata_pag as titulo,                                                                                                   '+sLineBreak+
            '               i.codigo_for as codigo_nome,                                                                                                  '+sLineBreak+
            '               f.fantasia_for as nome,                                                                                                       '+sLineBreak+
            '               i.venc_pag as vencimento,                                                                                                     '+sLineBreak+
            '               p.dataemi_pag as emissao,                                                                                                     '+sLineBreak+
            '               i.pacela_pag||''/''||i.totalparcelas as parcela,                                                                              '+sLineBreak+
            '               i.valorparcela_pag as valor,                                                                                                  '+sLineBreak+
            '               (i.valorparcela_pag - coalesce(i.valorpago_pag,0) - coalesce(i.desconto,0) ) as aberto,                                       '+sLineBreak+
            '               pt.nome_port as portador,                                                                                                     '+sLineBreak+
            '               pt.codigo_port portador_cod                                                                                                   '+sLineBreak+
            '           from                                                                                                                              '+sLineBreak+
            '               contaspagaritens i                                                                                                            '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                 inner join contaspagar p on p.duplicata_pag = i.dupliacata_pag and p.codigo_for = i.codigo_for                              '+sLineBreak+
            '                 inner join fornecedor f on f.codigo_for = i.codigo_for                                                                      '+sLineBreak+
            '                 left join portador pt on i.portador_id = pt.codigo_port                                                                     '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '           where                                                                                                                             '+sLineBreak+
            '                (i.situacao_pag = ''A'')                                                                                                     '+sLineBreak+
            '                and ((p.previsao is null) or (p.previsao = ''N''))                                                                           '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '       union  all                                                                                                                            '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '          select                                                                                                                             '+sLineBreak+
            '               ''RECEBER'' as tipo,                                                                                                          '+sLineBreak+
            '               i.fatura_rec as titulo,                                                                                                       '+sLineBreak+
            '               i.codigo_cli as codigo_nome,                                                                                                  '+sLineBreak+
            '               f.fantasia_cli as nome,                                                                                                       '+sLineBreak+
            '               i.vencimento_rec as vencimento,                                                                                               '+sLineBreak+
            '               p.dataemi_rec as emissao,                                                                                                     '+sLineBreak+
            '               i.pacela_rec||''/''||i.totalparcelas_rec as parcela,                                                                          '+sLineBreak+
            '               i.vlrparcela_rec as valor,                                                                                                    '+sLineBreak+
            '               (i.vlrparcela_rec - coalesce(i.valorrec_rec,0)) as aberto,                                                                    '+sLineBreak+
            '               pt.nome_port as portador,                                                                                                     '+sLineBreak+
            '               pt.codigo_port portador_cod                                                                                                   '+sLineBreak+
            '           from                                                                                                                              '+sLineBreak+
            '              contasreceberitens i                                                                                                           '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                   inner join contasreceber p on p.fatura_rec = i.fatura_rec                                                                 '+sLineBreak+
            '                   inner join clientes f on f.codigo_cli = i.codigo_cli                                                                      '+sLineBreak+
            '                   left join portador pt on i.codigo_por = pt.codigo_port                                                                    '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '           where                                                                                                                             '+sLineBreak+
            '             ((i.situacao_rec = ''A'') or (i.destitulo_rec = ''S''))                                                                         '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '           union  all                                                                                                                        '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '               select                                                                                                                        '+sLineBreak+
            '                     ''COMPRA'' as tipo,                                                                                                     '+sLineBreak+
            '                     c.numero_ped as titulo,                                                                                                 '+sLineBreak+
            '                     c.codigo_for as codigo_nome,                                                                                            '+sLineBreak+
            '                     f.fantasia_for as nome,                                                                                                 '+sLineBreak+
            '                     v.vencimento as vencimento,                                                                                             '+sLineBreak+
            '                     c.data_ped as emissao,                                                                                                  '+sLineBreak+
            '                     v.parcela||''/''||c.parcelas_ped as parcela,                                                                            '+sLineBreak+
            '                     sum(v.valor_parcela) valor,                                                                                             '+sLineBreak+
            '                     sum(v.valor_parcela) aberto,                                                                                            '+sLineBreak+
            '                     null as portador,                                                                                                       '+sLineBreak+
            '                     null portador_cod                                                                                                       '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '               from                                                                                                                          '+sLineBreak+
            '                   pedidocompra c                                                                                                            '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '                   inner join fornecedor f on c.codigo_for = f.codigo_for                                                                    '+sLineBreak+
            '                   inner join previsao_pedidocompra v on c.numero_ped = v.numero_ped and c.codigo_for = v.codigo_for                         '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '               where                                                                                                                         '+sLineBreak+
            '                  ( select count(*) from pedidocompraitens i                                                                                 '+sLineBreak+
            '                    where i.numero_ped = c.numero_ped  and i.codigo_for = c.codigo_for and i.quantidade_ate < i.quantidade_ped)  > 0         '+sLineBreak+
            '                    group by 1,2,3,4,5,6,7                                                                                                   '+sLineBreak+
            '                  )                                                                                                                          '+sLineBreak+
            '                                                                                                                                             '+sLineBreak+
            '               where 1=1                                                                                                                     '+sLineBreak;

    lSql := lSql + where;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

function TFluxoCaixaDao.obterResumo: TFDMemTable;
var
  lQry: TFDQuery;
  lSql: String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSql := '   select                                                                                                                    '+sLineBreak+
            '       TIPO,                                                                                                                 '+sLineBreak+
            '       COUNT(*) TOTALREGISTROS,                                                                                              '+sLineBreak+
            '       SUM(TOTAL) TOTAL                                                                                                      '+sLineBreak+
            '                                                                                                                             '+sLineBreak+
            '     from                                                                                                                    '+sLineBreak+
            '         (select                                                                                                             '+sLineBreak+
            '                tipo,                                                                                                        '+sLineBreak+
            '                total,                                                                                                       '+sLineBreak+
            '                vencimento                                                                                                   '+sLineBreak+
            '                from                                                                                                         '+sLineBreak+
            '                    (select ''PAGAR'' TIPO,                                                                                  '+sLineBreak+
            '                            i.valorparcela_pag - coalesce(i.valorpago_pag, 0) Total,                                         '+sLineBreak+
            '                            i.venc_pag vencimento,                                                                           '+sLineBreak+
            '                            i.portador_id portador_cod                                                                       '+sLineBreak+
            '                       from contaspagaritens i                                                                               '+sLineBreak+
            '                      where (i.valorparcela_pag - coalesce(i.valorpago_pag, 0)) <> 0                                         '+sLineBreak+
            '                                                                                                                             '+sLineBreak+
            '                      union all                                                                                              '+sLineBreak+
            '                     select ''RECEBER'' TIPO,                                                                                '+sLineBreak+
            '                            i.valorrec_rec - coalesce(i.valor_pago,0) Total,                                                 '+sLineBreak+
            '                            i.vencimento_rec vencimento,                                                                     '+sLineBreak+
            '                            i.codigo_por portador_cod                                                                        '+sLineBreak+
            '                       from contasreceberitens i                                                                             '+sLineBreak+
            '                      where (i.valorrec_rec - coalesce(i.valor_pago,0)) <> 0                                                 '+sLineBreak+
            '                                                                                                                             '+sLineBreak+
            '                      union all                                                                                              '+sLineBreak+
            '                     select ''COMPRA'' TIPO,                                                                                 '+sLineBreak+
            '                            v.valor_parcela Total,                                                                           '+sLineBreak+
            '                            v.vencimento vencimento,                                                                         '+sLineBreak+
            '                            null portador_cod                                                                                '+sLineBreak+
            '                       from pedidocompra p                                                                                   '+sLineBreak+
            '                      inner join fornecedor f on p.codigo_for = f.codigo_for                                                 '+sLineBreak+
            '                      inner join previsao_pedidocompra v on p.numero_ped = v.numero_ped and p.codigo_for = v.codigo_for      '+sLineBreak+
            '                      where (select count(*) from pedidocompraitens i                                                        '+sLineBreak+
            '                      where i.numero_ped = p.numero_ped                                                                      '+sLineBreak+
            '                        and coalesce(i.quantidade_ate,0) < i.quantidade_ped) > 0                                             '+sLineBreak+
            '          )                                                                                                                  '+sLineBreak;

    lSql := lSql + where;

    lSql := lSql + '  )                                                                                                                   '+sLineBreak+
                   '  group by 1';

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

procedure TFluxoCaixaDao.obterResultadoFluxoCaixa;
var
  lQry: TFDQuery;
  lSql: String;
  lContaCorrenteModel: TContaCorrenteModel;
  I: Integer;
begin

  lQry := vIConexao.CriarQuery;

  try
    lSql := '      select ''PAGAR'' TIPO, ' +
            '             Count(*) TotalRegistros, ' +
            '             Sum(i.valor_parcela - coalesce(i.valor_pago, 0)) Total ' +
            '      from contaspagaritens i ' +
            '      where (i.valor_parcela - coalesce(i.valor_pago, 0)) <> 0 ' +
            '            and i.vencimento between ''' + transformaDataFireBirdWhere(FDataInicialView) + ''' and ''' + transformaDataFireBirdWhere(FDataFinalView) + ''' ';

    lSql := lSql + ' union  all ' +
                   ' select ''RECEBER'' tipo, ' +
                   '        Count(*) TotalRegistros, ' +
                   '        Sum(i.valor_parcela - coalesce(i.valor_recebido,0)) Total ' +
                   ' from contasreceberitens i ' +
                   '      inner join contasreceber p on p.id = i.contasreceber_id ' +
                   ' where (i.valor_parcela - coalesce(i.valor_recebido,0)) <> 0 ' +
                   '       and i.vencimento between ''' + transformaDataFireBirdWhere(FDataInicialView) + ''' and ''' + transformaDataFireBirdWhere(FDataFinalView) + ''' ' +
                   ifThen(FPortadorView <> '', ' and p.portador_id = ' + FPortadorView, '');

    lSql := lSql + ' union  all ' +
                   ' select ''COMPRA'' tipo, ' +
                   '        Count(*) TotalRegistros, ' +
                   '        Sum(v.valor_parcela) Total ' +
                   ' from pedidocompra p ' +
                   '      inner join pedidocompra_previsaopagar v on v.pedidocompra_id = p.id ' +
                   ' where (select count(*) from pedidocompraitens i where i.pedidocompra_id = p.id and coalesce(i.quantidade_atendida,0) < i.quantidade) > 0 ' +
                   '       and v.vencimento between ''' + transformaDataFireBirdWhere(FDataInicialView) + ''' and ''' + transformaDataFireBirdWhere(FDataFinalView) + ''' ';

    lSql := lSql + 'order by 1 ';

    lQry.Open(lSql);

    FResultado_AReceber      := 0;
    FResultado_Inadimplencia := 0;
    FResultado_APagar        := 0;

    lQry.First;
    while not lQry.Eof do
    begin
      if lQry.FieldByName('Tipo').AsString = 'RECEBER' then
      begin
        if FPorcentagemInadimplenciaView > 0 then
        begin
          FResultado_AReceber      := FResultado_AReceber + (lQry.FieldByName('Total').AsFloat - (lQry.FieldByName('Total').AsFloat * (FPorcentagemInadimplenciaView / 100)));
          FResultado_Inadimplencia := FResultado_Inadimplencia + (lQry.FieldByName('Total').AsFloat * (FPorcentagemInadimplenciaView / 100));
        end
        else
          FResultado_AReceber := FResultado_AReceber + lQry.FieldByName('Total').AsFloat;
      end;

      if (lQry.FieldByName('Tipo').AsString = 'PAGAR') or
         (lQry.FieldByName('Tipo').AsString = 'COMPRA') then
      begin
        FResultado_APagar := FResultado_APagar + lQry.FieldByName('Total').AsFloat;
      end;

      lQry.Next;
    end;


    lContaCorrenteModel := TContaCorrenteModel.Create(vIConexao);

//    lContaCorrenteModel.IDBancoView := FBancoView;
//    lContaCorrenteModel.obterSaldo;

//    FResultado_SaldoAtualBancos := lContaCorrenteModel.Saldo;


    FResultado_Total := FResultado_AReceber + ifThen(FSomarBancosView, FResultado_SaldoAtualBancos, 0) - FResultado_APagar;

  finally
    lQry.Free;
    lContaCorrenteModel.Free;
  end;
end;

procedure TFluxoCaixaDao.SetBancoView(const Value: String);
begin
  FBancoView := Value;
end;

procedure TFluxoCaixaDao.SetDataFinalView(const Value: Variant);
begin
  FDataFinalView := Value;
end;

procedure TFluxoCaixaDao.SetDataInicialView(const Value: Variant);
begin
  FDataInicialView := Value;
end;

procedure TFluxoCaixaDao.SetFluxoCaixasLista(const Value: TObjectList<TFluxoCaixaModel>);
begin
  FFluxoCaixasLista := Value;
end;

procedure TFluxoCaixaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFluxoCaixaDao.SetPorcentagemInadimplenciaView(const Value: Real);
begin
  FPorcentagemInadimplenciaView := Value;
end;

procedure TFluxoCaixaDao.SetPortadorView(const Value: String);
begin
  FPortadorView := Value;
end;

procedure TFluxoCaixaDao.SetResultado_APagar(const Value: Real);
begin
  FResultado_APagar := Value;
end;

procedure TFluxoCaixaDao.SetResultado_AReceber(const Value: Real);
begin
  FResultado_AReceber := Value;
end;

procedure TFluxoCaixaDao.SetResultado_Inadimplencia(const Value: Real);
begin
  FResultado_Inadimplencia := Value;
end;

procedure TFluxoCaixaDao.SetResultado_SaldoAtualBancos(const Value: Real);
begin
  FResultado_SaldoAtualBancos := Value;
end;

procedure TFluxoCaixaDao.SetResultado_Total(const Value: Real);
begin
  FResultado_Total := Value;
end;

procedure TFluxoCaixaDao.SetResumo_A_Pagar(const Value: Real);
begin
  FResumo_A_Pagar := Value;
end;

procedure TFluxoCaixaDao.SetResumo_A_Pagar_Registros(const Value: Integer);
begin
  FResumo_A_Pagar_Registros := Value;
end;

procedure TFluxoCaixaDao.SetResumo_A_Receber(const Value: Real);
begin
  FResumo_A_Receber := Value;
end;

procedure TFluxoCaixaDao.SetResumo_A_Receber_Registros(const Value: Integer);
begin
  FResumo_A_Receber_Registros := Value;
end;

procedure TFluxoCaixaDao.SetSomarBancosView(const Value: Boolean);
begin
  FSomarBancosView := Value;
end;

procedure TFluxoCaixaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TFluxoCaixaDao.where: String;
var
  lSql: String;
begin
  lSql := ' and vencimento between ''' + transformaDataFireBirdWhere(FDataInicialView) + ''' and ''' + transformaDataFireBirdWhere(FDataFinalView) + ''' ';

  if FPortadorView <> '' then
    lSql := lSql + ' and portador_cod = ' + FPortadorView;

  Result := lSql;
end;

end.

