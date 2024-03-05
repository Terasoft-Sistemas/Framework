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

    FWhereView: String;
    FPorcentagemInadimplenciaView: Real;
    FBancoView: String;
    FPortadorView: String;
    FDataFinalView: Variant;
    FDataInicialView: Variant;
    FSomarBancosView: Boolean;
    FOrderView: String;
    FTipoView: String;
    FLojaView: Variant;

    procedure SetWhereView(const Value: String);
    procedure SetBancoView(const Value: String);
    procedure SetDataFinalView(const Value: Variant);
    procedure SetDataInicialView(const Value: Variant);
    procedure SetPorcentagemInadimplenciaView(const Value: Real);
    procedure SetPortadorView(const Value: String);
    procedure SetSomarBancosView(const Value: Boolean);
    procedure SetOrderView(const Value: String);

    function where: String;
    procedure SetTipoView(const Value: String);
    procedure SetLojaView(const Value: Variant);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property WhereView: String read FWhereView write SetWhereView;
    property OrderView: String read FOrderView write SetOrderView;
    property DataInicialView: Variant read FDataInicialView write SetDataInicialView;
    property DataFinalView: Variant read FDataFinalView write SetDataFinalView;
    property BancoView: String read FBancoView write SetBancoView;
    property PortadorView: String read FPortadorView write SetPortadorView;
    property PorcentagemInadimplenciaView: Real read FPorcentagemInadimplenciaView write SetPorcentagemInadimplenciaView;
    property SomarBancosView: Boolean read FSomarBancosView write SetSomarBancosView;
    property TipoView: String read FTipoView write SetTipoView;
    property LojaView : Variant read FLojaView write SetLojaView;

    function obterFluxoCaixaSintetico : TFDMemTable;
    function obterFluxoCaixaAnalitico : TFDMemTable;
    function obterResumo              : TFDMemTable;
    function obterResultadoFluxoCaixa : TFDMemTable;
end;

implementation

uses
  System.Math, System.SysUtils, Data.DB, LojasModel;

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
  lQry        : TFDQuery;
  lSql        : String;
  lMemTable   : TFDMemTable;
  lLojas_Dados,
  lLojasModel : TLojasModel;
begin
  lQry        := vIConexao.CriarQuery;
  lLojasModel := TLojasModel.Create(vIConexao);
  lMemTable   := TFDMemTable.Create(nil);

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

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by ' + FOrderView;

    lMemTable.FieldDefs.Add('LOJA',       ftString, 3);
    lMemTable.FieldDefs.Add('LOJA_NOME',  ftString, 10);
    lMemTable.FieldDefs.Add('VENCIMENTO', ftDate);
    lMemTable.FieldDefs.Add('PAGAR',      ftFloat);
    lMemTable.FieldDefs.Add('RECEBER',    ftFloat);
    lMemTable.FieldDefs.Add('COMPRA',     ftFloat);
    lMemTable.CreateDataSet;

    lLojasModel.LojaView := self.FLojaView;
    lLojasModel.obterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
      lQry := vIConexao.CriarQueryExterna;
      lQry.Open(lSQL);

      lQry.First;
      while not lQry.Eof do
      begin
        lMemTable.InsertRecord([
                                lLojas_Dados.LOJA,
                                lLojas_Dados.DESCRICAO,
                                lQry.FieldByName('VENCIMENTO').AsString,
                                lQry.FieldByName('PAGAR').AsFloat,
                                lQry.FieldByName('RECEBER').AsFloat,
                                lQry.FieldByName('COMPRA').AsFloat
                               ]);
        lQry.Next;
      end;
    end;

    lMemTable.Open;
    Result := lMemTable;

  finally
    lQry.Free;
  end;
end;

function TFluxoCaixaDao.obterFluxoCaixaAnalitico : TFDMemTable;
var
  lQry        : TFDQuery;
  lSql        : String;
  lMemTable   : TFDMemTable;
  lLojas_Dados,
  lLojasModel : TLojasModel;
begin
  lQry        := vIConexao.CriarQuery;
  lLojasModel := TLojasModel.Create(vIConexao);
  lMemTable   := TFDMemTable.Create(nil);

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

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by ' + FOrderView;

    lMemTable.FieldDefs.Add('LOJA',         ftString, 3);
    lMemTable.FieldDefs.Add('LOJA_NOME',    ftString, 10);
    lMemTable.FieldDefs.Add('TIPO',         ftString, 30);
    lMemTable.FieldDefs.Add('TITULO',       ftString, 30);
    lMemTable.FieldDefs.Add('CODIGO_NOME',  ftString, 6);
    lMemTable.FieldDefs.Add('NOME',         ftString, 50);
    lMemTable.FieldDefs.Add('VENCIMENTO',   ftDate);
    lMemTable.FieldDefs.Add('EMISSAO',      ftDate);
    lMemTable.FieldDefs.Add('PARCELA',      ftString, 10);
    lMemTable.FieldDefs.Add('VALOR',        ftFloat);
    lMemTable.FieldDefs.Add('ABERTO',       ftFloat);
    lMemTable.FieldDefs.Add('PORTADOR',     ftString, 30);
    lMemTable.FieldDefs.Add('PORTADOR_COD', ftString, 50);

    lMemTable.CreateDataSet;

    lLojasModel.LojaView := self.FLojaView;
    lLojasModel.obterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
      lQry := vIConexao.CriarQueryExterna;
      lQry.Open(lSQL);

      lQry.First;
      while not lQry.Eof do
      begin
        lMemTable.InsertRecord([
                                lLojas_Dados.LOJA,
                                lLojas_Dados.DESCRICAO,
                                lQry.FieldByName('TIPO').AsString,
                                lQry.FieldByName('TITULO').AsString,
                                lQry.FieldByName('CODIGO_NOME').AsString,
                                lQry.FieldByName('NOME').AsString,
                                lQry.FieldByName('VENCIMENTO').AsDateTime,
                                lQry.FieldByName('EMISSAO').AsDateTime,
                                lQry.FieldByName('PARCELA').AsString,
                                lQry.FieldByName('VALOR').AsFloat,
                                lQry.FieldByName('ABERTO').AsFloat,
                                lQry.FieldByName('PORTADOR').AsString,
                                lQry.FieldByName('PORTADOR_COD').AsString
                               ]);
        lQry.Next;
      end;
    end;

    lMemTable.Open;
    Result := lMemTable;

  finally
    lQry.Free;
  end;
end;

function TFluxoCaixaDao.obterResumo: TFDMemTable;
var
  lQry        : TFDQuery;
  lSql        : String;
  lMemTable   : TFDMemTable;
  lLojas_Dados,
  lLojasModel : TLojasModel;
begin
  lQry        := vIConexao.CriarQuery;
  lLojasModel := TLojasModel.Create(vIConexao);
  lMemTable   := TFDMemTable.Create(nil);

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
            '                            i.vlrparcela_rec - coalesce(i.valorrec_rec,0) Total,                                             '+sLineBreak+
            '                            i.vencimento_rec vencimento,                                                                     '+sLineBreak+
            '                            i.codigo_por portador_cod                                                                        '+sLineBreak+
            '                       from contasreceberitens i                                                                             '+sLineBreak+
            '                      where (i.vlrparcela_rec - coalesce(i.valorrec_rec,0)) <> 0                                             '+sLineBreak+
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
            '          )                                                                                                                  '+sLineBreak+
            '                      where 1=1                                                                                              '+sLineBreak;

    lSql := lSql + where;

    lSql := lSql + '  )          '+sLineBreak+
                   '  group by 1 '+sLineBreak;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by ' + FOrderView;

    lMemTable.FieldDefs.Add('LOJA',            ftString, 3);
    lMemTable.FieldDefs.Add('LOJA_NOME',       ftString, 10);
    lMemTable.FieldDefs.Add('TIPO',            ftString, 20);
    lMemTable.FieldDefs.Add('TOTALREGISTROS',  ftFloat);
    lMemTable.FieldDefs.Add('TOTAL',           ftFloat);
    lMemTable.CreateDataSet;

    lLojasModel.LojaView := self.FLojaView;
    lLojasModel.obterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
      lQry := vIConexao.CriarQueryExterna;
      lQry.Open(lSQL);

      lQry.First;
      while not lQry.Eof do
      begin
        lMemTable.InsertRecord([
                                lLojas_Dados.LOJA,
                                lLojas_Dados.DESCRICAO,
                                lQry.FieldByName('TIPO').AsString,
                                lQry.FieldByName('TOTALREGISTROS').AsFloat,
                                lQry.FieldByName('TOTAL').AsFloat
                               ]);
        lQry.Next;
      end;
    end;

    lMemTable.Open;
    Result := lMemTable;

  finally
    lQry.Free;
  end;
end;

function TFluxoCaixaDao.obterResultadoFluxoCaixa : TFDMemTable;
var
  lQry : TFDQuery;
  lSql : String;
  lPagar,
  lReceber,
  lInadimplente,
  lSaldoBanco,
  lTotal              : Double;
  lMemTable           : TFDMemTable;
  lContaCorrenteModel : TContaCorrenteModel;
  lLojas_Dados,
  lLojasModel         : TLojasModel;

begin
  lMemTable   := TFDMemTable.Create(nil);
  lLojasModel := TLojasModel.Create(vIConexao);

  try
    lSql := '        select TIPO,                                                                                  '+sLineBreak+
            '               COUNT(*) TOTALREGISTROS,                                                               '+sLineBreak+
            '               SUM(TOTAL) TOTAL                                                                       '+sLineBreak+
            '          from                                                                                        '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '          (                                                                                           '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '               select tipo,                                                                           '+sLineBreak+
            '                      vencimento,                                                                     '+sLineBreak+
            '                      portador_cod,                                                                   '+sLineBreak+
            '                      total                                                                           '+sLineBreak+
            '               from                                                                                   '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '                    (                                                                                 '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '                         select ''PAGAR'' tipo,                                                       '+sLineBreak+
            '                                i.venc_pag vencimento,                                                '+sLineBreak+
            '                                i.portador_id portador_cod,                                           '+sLineBreak+
            '                                i.valorparcela_pag - coalesce(i.valorpago_pag, 0) Total               '+sLineBreak+
            '                           from contaspagaritens i                                                    '+sLineBreak+
            '                          where (i.valorparcela_pag - coalesce(i.valorpago_pag, 0)) <> 0              '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '                         union all                                                                    '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '                         select ''RECEBER'' tipo,                                                     '+sLineBreak+
            '                                ci.vencimento_rec vencimento,                                         '+sLineBreak+
            '                                ci.codigo_por portador_cod,                                           '+sLineBreak+
            '                                ci.vlrparcela_rec - coalesce(ci.valorrec_rec,0) Total                 '+sLineBreak+
            '                           from  contasreceberitens ci                                                '+sLineBreak+
            '                          inner join contasreceber c on c.fatura_rec = ci.fatura_rec                  '+sLineBreak+
            '                          where (ci.vlrparcela_rec - coalesce(ci.valorrec_rec, 0)) <> 0               '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '                         union all                                                                    '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '                         select ''COMPRA'' tipo,                                                      '+sLineBreak+
            '                                   pe.vencimento,                                                     '+sLineBreak+
            '                                   null portador_cod,                                                 '+sLineBreak+
            '                                   pe.valor_parcela Total                                             '+sLineBreak+
            '                              from pedidocompra p                                                     '+sLineBreak+
            '                              inner join previsao_pedidocompra pe on p.numero_ped = pe.numero_ped     '+sLineBreak+
            '                              where (select count(*) from pedidocompraitens pi                        '+sLineBreak+
            '                                   where pi.numero_ped = p.numero_ped                                 '+sLineBreak+
            '                                        and coalesce(pi.quantidade_ate,0)< pi.quantidade_ped) > 0     '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '               )                                                                                      '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '          where 1=1                                                                                   '+sLineBreak;

    lSql := lSql + Where;

    lSql := lSql +
            '                                                                                                      '+sLineBreak+
            '          )                                                                                           '+sLineBreak+
            '                                                                                                      '+sLineBreak+
            '     group by 1                                                                                       '+sLineBreak;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by ' + FOrderView;

    lMemTable.FieldDefs.Add('LOJA',                   ftString, 3);
    lMemTable.FieldDefs.Add('NOME_LOJA',              ftString, 10);
    lMemTable.FieldDefs.Add('RESULTADO_RECEBER',      ftFloat);
    lMemTable.FieldDefs.Add('RESULTADO_PAGAR',        ftFloat);
    lMemTable.FieldDefs.Add('RESULTADO_INADIMPLENTE', ftFloat);
    lMemTable.FieldDefs.Add('RESULTADO_SALDO_BANCO',  ftFloat);
    lMemTable.FieldDefs.Add('TOTAL',                  ftFloat);
    lMemTable.CreateDataSet;

    lLojasModel.LojaView := self.FLojaView;
    lLojasModel.obterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
      lQry := vIConexao.CriarQueryExterna;
      lQry.Open(lSQL);

      lReceber      := 0;
      lInadimplente := 0;
      lPagar        := 0;

      lQry.First;
      while not lQry.Eof do
      begin
        if lQry.FieldByName('Tipo').AsString = 'RECEBER' then
        begin
          if FPorcentagemInadimplenciaView > 0 then
          begin
            lReceber      := lReceber + (lQry.FieldByName('Total').AsFloat - (lQry.FieldByName('Total').AsFloat * (FPorcentagemInadimplenciaView / 100)));
            lInadimplente := lInadimplente + (lQry.FieldByName('Total').AsFloat * (FPorcentagemInadimplenciaView / 100));
          end
          else
            lReceber := lReceber + lQry.FieldByName('Total').AsFloat;
        end;

        if (lQry.FieldByName('Tipo').AsString = 'PAGAR') or
           (lQry.FieldByName('Tipo').AsString = 'COMPRA') then
        begin
          lPagar := lPagar + lQry.FieldByName('Total').AsFloat;
        end;

        lQry.Next;
      end;

      lContaCorrenteModel := TContaCorrenteModel.Create(vIConexao);
      lContaCorrenteModel.IDBancoView := FBancoView;
      lContaCorrenteModel.obterSaldo(lLojas_Dados.LOJA);

      lSaldoBanco := lContaCorrenteModel.Saldo;

      lTotal := lReceber + ifThen(FSomarBancosView, lSaldoBanco, 0) - lPagar;

      lMemTable.InsertRecord([
                              lLojas_Dados.LOJA,
                              lLojas_Dados.DESCRICAO,
                              FormatFloat('####0.00', lReceber),
                              FormatFloat('####0.00', lPagar),
                              FormatFloat('####0.00', lInadimplente),
                              FormatFloat('####0.00', lSaldoBanco),
                              FormatFloat('####0.00', lTotal)
                             ]);

      Result := lMemTable;

    end;

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

procedure TFluxoCaixaDao.SetLojaView(const Value: Variant);
begin
  FLojaView := Value;
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

procedure TFluxoCaixaDao.SetSomarBancosView(const Value: Boolean);
begin
  FSomarBancosView := Value;
end;

procedure TFluxoCaixaDao.SetTipoView(const Value: String);
begin
  FTipoView := Value;
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
    lSql := lSql + ' and portador_cod = ' + QuotedStr(FPortadorView);

  if FTipoView <> '' then
    lSql := lSql + ' and tipo = ' + QuotedStr(FTipoView);

  if FWhereView <> '' then
    lSql := lSql + FWhereView;

  Result := lSql;
end;

end.

