unit DRGDao;

interface

uses
  DRGModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.Texto,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.FuncoesTexto,
  LojasModel;

type
  TDRGDao = class;
  ITDRGDao=IObject<TDRGDao>;

  TDRGDao = class
  private
    [weak] mySelf:ITDRGDao;
    vIConexao : IConexao;
  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDRGDao;

    function ObterLista(pDRG_Parametros: TDRG_Parametros): IFDDataset;
    function ObterDRG_Detalhes(pDRG_Detalhes_Parametros: TDRG_Detalhes_Parametros): IFDDataset;

end;

implementation

uses
  Terasoft.Framework.LOG,
  Interfaces.QueryLojaAsync,
  Data.DB;

{ TDRG }

constructor TDRGDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDRGDao.Destroy;
begin

  inherited;
end;

class function TDRGDao.getNewIface(pIConexao: IConexao): ITDRGDao;
begin
  Result := TImplObjetoOwner<TDRGDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDRGDao.ObterDRG_Detalhes(pDRG_Detalhes_Parametros: TDRG_Detalhes_Parametros): IFDDataset;
var
  lSQL:String;
  lMemTable: IFDDataset;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin

  lAsyncList := getQueryLojaAsyncList(vIConexao,pDRG_Detalhes_Parametros.Lojas);

  lMemTable := criaIFDDataset(TFDMemTable.Create(nil));

  lSQL := ' select *                                                               '+#13+
          '                                                                        '+#13+
          ' from                                                                   '+#13+
          '                                                                        '+#13+
          ' (select                                                                '+#13+
          '     v.numero_cor LANCAMENTO,                                           '+#13+
          '     v.data_cor DATA,                                                   '+#13+
          '     v.observacao_cor HISTORICO,                                        '+#13+
          '     s.descricao_cen SUBGRUPO,                                          '+#13+
          '     trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta) CONTA, '+#13+
          '                                                                        '+#13+
          '     cast(v.valor_cor as float) VALOR,                                  '+#13+
          '     cast(b.nome_ban as varchar80) OBSERVACAO                           '+#13+
          '                                                                        '+#13+
          ' from                                                                   '+#13+
          '     contacorrente v                                                    '+#13+
          '                                                                        '+#13+
          ' left join contas c on c.codigo_cta = v.codigo_cta                      '+#13+
          ' left join centrocusto_cta s on s.id_cen = v.centro_custo               '+#13+
          ' left join banco b on b.numero_ban = v.codigo_ban                       '+#13+
          '                                                                        '+#13+
          ' where                                                                  '+#13+
          '     c.tiposemdr_cta = ''S'' and coalesce(v.status,'''') <> ''X''       '+#13+
          '     and coalesce(b.drg,''S'') = ''S''                                  '+#13+
          '                                                                        '+#13+
          ' union all                                                              '+#13+
          '                                                                        '+#13+
          ' select                                                                 '+#13+
          '     v.numero_cai LANCAMENTO,                                           '+#13+
          '     v.data_cai DATA,                                                   '+#13+
          '     v.historico_cai HISTORICO,                                         '+#13+
          '     s.descricao_cen SUBGRUPO,                                          '+#13+
          '     trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta) CONTA, '+#13+
          '     cast(v.valor_cai as float)  VALOR,                                 '+#13+
          '     cast(''CAIXA'' as varchar100) OBSERVACAO                           '+#13+
          '                                                                        '+#13+
          ' from                                                                   '+#13+
          '     caixa v                                                            '+#13+
          '                                                                        '+#13+
          ' left join contas c on c.codigo_cta = v.codigo_cta                      '+#13+
          ' left join centrocusto_cta s on s.id_cen = v.centro_custo               '+#13+
          '                                                                        '+#13+
          ' where                                                                  '+#13+
          '     c.tiposemdr_cta = ''S'' and coalesce(v.status,'''') <> ''X''       '+#13+
          ' ) d                                                                    '+#13+
          '                                                                        '+#13+
          ' where                                                                  '+#13+
          '   d.data between ' + QuotedStr(transformaDataFireBirdWhere(pDRG_Detalhes_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pDRG_Detalhes_Parametros.DataFim)) + ' and ' +
          '   d.conta = ' + QuotedStr(pDRG_Detalhes_Parametros.Conta) + #13;

  gravaSQL(lSQL, 'DRGDao_ObterDRG_Detalhes_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
  begin
    Name := 'OrdenacaoLojaData';
    Fields := 'LOJA;DATA';
    Options := [TIndexOption.ixCaseInsensitive];
  end;

  TFDMemTable(lMemTable.objeto).IndexName := 'OrdenacaoLojaData';
  // Filial, Lançamento, Data, Histórico, Conta Corrente, Valor

  TFDMemTable(lMemTable.objeto).FieldDefs.Add('LOJA',          ftString, 3);
  TFDMemTable(lMemTable.objeto).FieldDefs.Add('LANCAMENTO',    ftString, 100);
  TFDMemTable(lMemTable.objeto).FieldDefs.Add('DATA',          ftDate);
  TFDMemTable(lMemTable.objeto).FieldDefs.Add('HISTORICO',     ftString, 200);
  TFDMemTable(lMemTable.objeto).FieldDefs.Add('CONTACORRENTE', ftString, 100);
  TFDMemTable(lMemTable.objeto).FieldDefs.Add('SUBGRUPO',      ftString, 100);
  TFDMemTable(lMemTable.objeto).FieldDefs.Add('OBSERVACAO',    ftString, 100);
  TFDMemTable(lMemTable.objeto).FieldDefs.Add('VALOR',         ftFloat);

  TFDMemTable(lMemTable.objeto).CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterVendasResultado1';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDashbordDao.ObterVendasResultado1: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDashbordDao.ObterVendasResultado1: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin

      lMemTable.objeto.InsertRecord([
                              lQA.loja.objeto.LOJA,
                              lQA.dataset.dataset.FieldByName('LANCAMENTO').AsString,
                              lQA.dataset.dataset.FieldByName('DATA').AsDateTime,
                              lQA.dataset.dataset.FieldByName('HISTORICO').AsString,
                              lQA.dataset.dataset.FieldByName('CONTA').AsString,
                              lQA.dataset.dataset.FieldByName('SUBGRUPO').AsString,
                              lQA.dataset.dataset.FieldByName('OBSERVACAO').AsString,
                              lQA.dataset.dataset.FieldByName('VALOR').AsFloat
                            ]);

      lQA.dataset.dataset.Next;
    end;
  end;

  lMemTable.objeto.Open;

  Result := lMemTable;

end;

function TDRGDao.ObterLista(pDRG_Parametros: TDRG_Parametros): IFDDataset;
var
  lSQL:String;

  lMemTable: TFDMemTable;

  lGrupoAnt, lGrupo, lSubGrupo, lConta : String;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin

  lAsyncList := getQueryLojaAsyncList(vIConexao,pDRG_Parametros.Lojas);

  if pDRG_Parametros.DataPadrao = '' then
    CriaException('Data padrão não definida');

  lMemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(lMemTable);

  lSQL := 'select '+#13;

  case pDRG_Parametros.NivelVisualizacao of
    tpNivel1 :
      lSQL := lSQL + '    GRUPO, '+#13;
    tpNivel2 :
      lSQL := lSQL + '    GRUPO, SUBGRUPO, '+#13;
    tpNivel3 :
      lSQL := lSQL + '    GRUPO, SUBGRUPO, CONTA, '+#13;
  end;


  lSQL := lSQL +  '    sum(cast(valor as float)) as VALOR                                                                                                                                        '+#13+
                  'from (                                                                                                                                                                        '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        else ''001. RECEITA''                                                                                                                                                 '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.'+pDRG_Parametros.DataPadrao+' data ,                                                                                                                               '+#13+
                  '        coalesce((trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen)) , (''SEM SUB GRUPO'')  ) SUBGRUPO,                                                        '+#13+
                  '        coalesce((trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta)) , (''VENDA ''||p.nome_port) )  CONTA,                                                          '+#13+
                  '        coalesce(SUM((( i.valorunitario_ped * i.qtde_calculada )-((( CAST(coalesce(i.desconto_ped,0) AS FLOAT) / 100 )*                                                       '+#13+
                  '         i.valorunitario_ped )) * i.qtde_calculada )   - (((( i.valorunitario_ped * i.qtde_calculada ) ) / ( (v.valor_ped) )) * (coalesce(v.DOLAR,0)) )   ),0) VALOR          '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        pedidovenda v                                                                                                                                                         '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    inner join pedidoitens i on i.numero_ped = v.numero_ped                                                                                                                   '+#13+
                  '    left join portador p on v.codigo_port = p.codigo_port                                                                                                                     '+#13+
                  '    left join contas c on c.codigo_cta = p.receita_conta_id                                                                                                                   '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '        ((COALESCE(v.status,''P'') = ''P'') or (v.status = ''F''))                                                                                                            '+#13+
                  '        and v.valor_ped > 0                                                                                                                                                   '+#13+
                  '        and i.VALORUNITARIO_PED > 0 and i.QTDE_CALCULADA > 0                                                                                                                  '+#13+
                  '        and v.codigo_port <> ''999999''                                                                                                                                       '+#13+
                  '                                                                                                                                                                              '+#13+
                  '        group by  1,2,3,4,5,6                                                                                                                                                 '+#13+
                  '                                                                                                                                                                              '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union all                                                                                                                                                                 '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        else ''001. RECEITA''                                                                                                                                                 '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.'+pDRG_Parametros.DataPadrao+' data ,                                                                                                                               '+#13+
                  '        coalesce( (trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen)) , (''SEM SUB GRUPO'')  ) SUBGRUPO,                                                       '+#13+
                  '        coalesce( (trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta)) , (''VENDA ''||p.nome_port) )  CONTA,                                                         '+#13+
                  '        coalesce(SUM( i.VLRPARCELA_REC),0) VALOR                                                                                                                              '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        pedidovenda v                                                                                                                                                         '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    inner join CONTASRECEBER r on r.PEDIDO_REC = v.numero_ped                                                                                                                 '+#13+
                  '    inner join CONTASRECEBERITENS i on r.FATURA_REC = i.FATURA_REC                                                                                                            '+#13+
                  '    left join portador p on i.CODIGO_POR = p.codigo_port                                                                                                                      '+#13+
                  '    left join contas c on c.codigo_cta = p.receita_conta_id                                                                                                                   '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '       ((COALESCE(v.status,''P'') = ''P'') or (v.status = ''F''))                                                                                                             '+#13+
                  '       and  v.codigo_port = ''999999''                                                                                                                                        '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    group by 1,2,3,4,5,6                                                                                                                                                      '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union                                                                                                                                                                     '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        else ''001. RECEITA''                                                                                                                                                 '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.data_sai data ,                                                                                                                                                     '+#13+
                  '        coalesce( (trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen)) , (''SEM SUB GRUPO'')  ) SUBGRUPO,                                                       '+#13+
                  '        coalesce( (trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta)) , (''OUTRAS SAIDAS'') )  CONTA,                                                               '+#13+
                  '        coalesce( (sum(coalesce(v.VALOR_ICMS_SAI,0)) ),0) VALOR                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        saidas v                                                                                                                                                              '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    inner join contas c on c.codigo_cta = v.CODIGO_CTA                                                                                                                        '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '        ((coalesce(c.tiposemdr_cta,''N'') = ''S'') or  (coalesce(c.tiposemdr_cta_recebimento,''N'') = ''S''))                                                                 '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    group by 1,2,3,4,5,6                                                                                                                                                      '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union                                                                                                                                                                     '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        else ''001. RECEITA''                                                                                                                                                 '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.data ,                                                                                                                                                              '+#13+
                  '        coalesce((trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen)) , (''SEM SUB GRUPO'')  ) SUBGRUPO,                                                        '+#13+
                  '        coalesce((trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta)) , (''DEVOLUCAO'') )  CONTA,                                                                    '+#13+
                  '        cast(SUM(((cast( di.valor_unitario as float) * cast( di.quantidade as float) )-((( coalesce(cast(di.desconto_ped as float),0) / 100 )*                                '+#13+
                  '        cast( di.valor_unitario as float) )) * cast( di.quantidade as float))) as float) *-1 as  VALOR                                                                        '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        devolucao v                                                                                                                                                           '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    inner join devolucaoitens di on v.id = di.id                                                                                                                              '+#13+
                  '    left join contas c on c.codigo_cta = ''''                                                                                                                                 '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '        1=1 and v.VALOR_TOTAL > 0                                                                                                                                             '+#13+
                  '                                                                                                                                                                              '+#13+
                  '        group by 1,2,3,4,5,6                                                                                                                                                  '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union                                                                                                                                                                     '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        else ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                                                 '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.'+pDRG_Parametros.DataPadrao+' data ,                                                                                                                               '+#13+
                  '        coalesce( (trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen)) , (''SEM SUB GRUPO'')  ) SUBGRUPO,                                                       '+#13+
                  '        coalesce( (trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta)) , (''CMV - Custo Mercadoria Vendida'') )  CONTA,                                              '+#13+
                  '        coalesce(sum(coalesce(i.QTDE_CALCULADA * i.vlrcusto_pro,0)),0) VALOR                                                                                                  '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        pedidovenda v                                                                                                                                                         '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    inner join pedidoitens i on i.numero_ped = v.numero_ped                                                                                                                   '+#13+
                  '    left join portador p on v.codigo_port = p.codigo_port                                                                                                                     '+#13+
                  '    left join contas c on c.codigo_cta = p.custo_conta_id                                                                                                                     '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '        ((COALESCE(v.status,''P'' ) = ''P'' ) or ( v.status = ''F'')  )                                                                                                       '+#13+
                  '        and i.vlrcusto_pro > 0 and i.QTDE_CALCULADA > 0                                                                                                                       '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    group by 1,2,3,4,5,6                                                                                                                                                      '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union                                                                                                                                                                     '+#13+
                  '                                                                                                                                                                              '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        else ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                                                 '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.data ,                                                                                                                                                              '+#13+
                  '        coalesce( (trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen)) , (''SEM SUB GRUPO'')  ) SUBGRUPO,                                                       '+#13+
                  '        coalesce( (trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta)) , (''CMD - Custo Mercadoria Devolvida'') )  CONTA,                                            '+#13+
                  '        coalesce( (sum(coalesce(di.quantidade * di.custo + coalesce(di.valor_st,0) + coalesce(di.frete,0),0)) *-1 ),0) VALOR                                                  '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        devolucao v                                                                                                                                                           '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    inner join devolucaoitens di on di.id = v.id                                                                                                                              '+#13+
                  '    left join contas c on c.codigo_cta = ''''                                                                                                                                 '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '        1=1 and v.VALOR_TOTAL > 0                                                                                                                                             '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    group by 1,2,3,4,5,6                                                                                                                                                      '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union                                                                                                                                                                     '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        ''007. RECEITAS EXTRA-OPERACIONAIS''  as GRUPO,                                                                                                                       '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.'+pDRG_Parametros.DataPadrao+' data ,                                                                                                                               '+#13+
                  '        coalesce( (trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen)) , (''SEM SUB GRUPO'')  ) SUBGRUPO,                                                       '+#13+
                  '        coalesce( (trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta)) , (''Acréscimo financeiro ''||p.nome_port) )  CONTA,                                          '+#13+
                  '        sum(coalesce(v.acres_ped,0)) VALOR                                                                                                                                    '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        pedidovenda v                                                                                                                                                         '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    left join portador p on v.codigo_port = p.codigo_port                                                                                                                     '+#13+
                  '    left join contas c on c.codigo_cta = p.df_conta_id and c.tiposemdr_cta = ''S''                                                                                            '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where 1=1  and v.valor_ped > 0                                                                                                                                            '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    group by 1,2,3,4,5,6                                                                                                                                                      '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union                                                                                                                                                                     '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        r.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        else ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                                             '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        r.loja ,                                                                                                                                                              '+#13+
                  '        i.databaixa_rec  data ,                                                                                                                                               '+#13+
                  '        coalesce( (trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen)) , (''SEM SUB GRUPO'')  ) SUBGRUPO,                                                       '+#13+
                  '        coalesce( (trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta)) , (''DESCONTO CONCEDIDO CARTAO'') )  CONTA,                                                   '+#13+
                  '        sum(coalesce(i.VALOR_DESCONTO_CARTAO,0)) VALOR                                                                                                                        '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        contasreceber r                                                                                                                                                       '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    inner join contasreceberitens i on r.fatura_rec = i.fatura_rec                                                                                                            '+#13+
                  '    left join contas c on c.codigo_cta = ''''                                                                                                                                 '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '      i.VALOR_DESCONTO_CARTAO > 0                                                                                                                                             '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    group by 1,2,3,4,5,6                                                                                                                                                      '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union                                                                                                                                                                     '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.data_cai data ,                                                                                                                                                     '+#13+
                  '        trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen) SUBGRUPO,                                                                                            '+#13+
                  '        trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta) CONTA,                                                                                                    '+#13+
                  '        coalesce(sum(coalesce(v.valor_cai,0)),0) VALOR                                                                                                                        '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '        contas c                                                                                                                                                              '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    left join caixa v on c.codigo_cta = V.codigo_cta and coalesce(v.status,'''') <> ''X''                                                                                     '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '        c.tiposemdr_cta = ''S''                                                                                                                                               '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    group by 1,2,3,4,5,6                                                                                                                                                      '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    union                                                                                                                                                                     '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    select                                                                                                                                                                    '+#13+
                  '        v.id,                                                                                                                                                                 '+#13+
                  '        case                                                                                                                                                                  '+#13+
                  '        when c.dr_cta = ''A''  then ''001. RECEITA''                                                                                                                          '+#13+
                  '        when c.dr_cta = ''V''  then ''002. CUSTOS VARIÁVEIS TOTAIS''                                                                                                          '+#13+
                  '        when c.dr_cta = ''F''  then ''004. CUSTOS FIXOS TOTAIS''                                                                                                              '+#13+
                  '        when c.dr_cta = ''I''  then ''006. INVESTIMENTOS''                                                                                                                    '+#13+
                  '        when c.dr_cta = ''R''  then ''007. RECEITAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''O''  then ''008. DESPESAS EXTRA-OPERACIONAIS''                                                                                                      '+#13+
                  '        when c.dr_cta = ''L''  then ''010. IMPOSTOS SOBRE O LUCRO''                                                                                                           '+#13+
                  '        when c.dr_cta = ''D''  then ''011. DISTRIBUIÇÃO DE LUCROS''                                                                                                           '+#13+
                  '        end as GRUPO,                                                                                                                                                         '+#13+
                  '        v.loja ,                                                                                                                                                              '+#13+
                  '        v.data_cor data ,                                                                                                                                                     '+#13+
                  '        trim(coalesce(s.classificacao,'''') || '' '' || s.descricao_cen) SUBGRUPO,                                                                                            '+#13+
                  '        trim(coalesce(c.classificacao,'''') || '' '' || c.nome_cta) conta,                                                                                                    '+#13+
                  '        coalesce(sum(coalesce(v.valor_cor,0)),0) VALOR                                                                                                                        '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    from                                                                                                                                                                      '+#13+
                  '      contas c                                                                                                                                                                '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    left join contacorrente v  on c.codigo_cta = v.codigo_cta and coalesce(v.status,'''') <> ''X''                                                                            '+#13+
                  '    left join centrocusto_cta s on s.id_cen = c.centrocusto_cta                                                                                                               '+#13+
                  '    left join banco b on b.NUMERO_BAN = v.CODIGO_BAN                                                                                                                          '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    where                                                                                                                                                                     '+#13+
                  '        c.tiposemdr_cta = ''S''                                                                                                                                               '+#13+
                  '        and coalesce(b.drg,''S'') <> ''N''                                                                                                                                    '+#13+
                  '                                                                                                                                                                              '+#13+
                  '    group by 1,2,3,4,5,6                                                                                                                                                      '+#13+
                  '                                                                                                                                                                              '+#13+
                  ')                                                                                                                                                                             '+#13+
                  'where                                                                                                                                                                         '+#13+
                  '    data between '+QuotedStr(transformaDataFireBirdWhere(pDRG_Parametros.DataInicio))+' and '+QuotedStr(transformaDataFireBirdWhere(pDRG_Parametros.DataFim)) +'              '+#13+
                  '    and valor <> 0                                                                                                                                                            '+#13;

  if pDRG_Parametros.FiltroGrupo <> '' then
    lSQL := lSQL + '    and Grupo = '+QuotedStr(pDRG_Parametros.FiltroGrupo)+#13;

  if pDRG_Parametros.FiltroSubGrupo <> '' then
    lSQL := lSQL + '    and SubGrupo = '+QuotedStr(pDRG_Parametros.FiltroSubGrupo)+#13;

  case pDRG_Parametros.NivelVisualizacao of
    tpNivel1 :
      lSQL := lSQL + 'group by 1 '+#13+
                     'order by 1 nulls last';
    tpNivel2 :
      lSQL := lSQL + 'group by 1, 2 '+#13+
                     'order by 1 nulls last, 2 ';
    tpNivel3 :
      lSQL := lSQL + 'group by 1, 2, 3 '+#13+
                     'order by 1 nulls last, 2, 3 ';
  end;

  gravaSQL(lSQL, 'DRGDao_ObterLista_' + FormatDateTime('yyyymmddhhnnsszzz', now));


  with lMemTable.IndexDefs.AddIndexDef do
  begin
    Name := 'OrdenacaoGrupoSubGrupoConta';
    Fields := 'GRUPO;SUBGRUPO;CONTA';
    Options := [TIndexOption.ixCaseInsensitive];
  end;

  lMemTable.IndexName := 'OrdenacaoGrupoSubGrupoConta';

  lMemTable.FieldDefs.Add('GRUPO',       ftString, 100);
  lMemTable.FieldDefs.Add('SUBGRUPO',    ftString, 100);
  lMemTable.FieldDefs.Add('CONTA',       ftString, 100);
  lMemTable.FieldDefs.Add('VALOR',       ftFloat);
  lMemTable.FieldDefs.Add('PORCENTAGEM', ftFloat);

  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterVendasResultado1';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDRGDao.ObterLista: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDRGDao.ObterLista: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.first;

    while not lQA.dataset.dataset.Eof do
    begin

      case pDRG_Parametros.NivelVisualizacao of
        tpNivel1 :
          begin
            lGrupo    := lQA.dataset.dataset.FieldByName('GRUPO').AsString;
            lSubGrupo := '';
            lConta    := '';
          end;

        tpNivel2 :
          begin
            lGrupo    := lQA.dataset.dataset.FieldByName('GRUPO').AsString;
            lSubGrupo := lQA.dataset.dataset.FieldByName('SUBGRUPO').AsString;
            lConta    := '';
          end;

        tpNivel3 :
          begin
            lGrupo    := lQA.dataset.dataset.FieldByName('GRUPO').AsString;
            lSubGrupo := lQA.dataset.dataset.FieldByName('SUBGRUPO').AsString;
            lConta    := lQA.dataset.dataset.FieldByName('CONTA').AsString;
          end;

      end;
      if(lGrupo='') then
      begin
        logaByTagSeNivel(TAGLOG_CONDICIONAL,format('TDRGDao.ObterLista: Query [%s] para a loja [%s] retornou um grupo inválido', [ lSql ,lQA.loja.objeto.LOJA ]), LOG_LEVEL_ATENCAO);
      end;

      if not lMemTable.Locate('GRUPO;SUBGRUPO;CONTA', VarArrayOf([lGrupo, lSubGrupo, lConta])) then
      begin
        lMemTable.InsertRecord([
                                lGrupo,
                                lSubGrupo,
                                lConta,
                                lQA.dataset.dataset.FieldByName('VALOR').AsFloat,
                                0//  lQA.dataset.dataset.FieldByName('VALOR').AsFloat / pDRG_Parametros.ValorPrincipal * 100
                              ]);
      end else
      begin
        lMemTable.Edit;
        lMemTable.FieldByName('VALOR').AsFloat       := lMemTable.FieldByName('VALOR').AsFloat + lQA.dataset.dataset.FieldByName('VALOR').AsFloat;
        //lMemTable.FieldByName('PORCENTAGEM').AsFloat := lMemTable.FieldByName('VALOR').AsFloat / pDRG_Parametros.ValorPrincipal * 100;
        lMemTable.CheckBrowseMode;
      end;

      lQA.dataset.dataset.Next;
    end;
  end;

  lMemTable.first;
  if pDRG_Parametros.ValorPrincipal = 0 then
  begin
    while not lMemTable.Eof do
    begin
      if(lMemTable.FieldByName('GRUPO').AsString<>'') then
        break;
      lMemTable.Next;
    end;
  end;
  pDRG_Parametros.ValorPrincipal := lMemTable.FieldByName('Valor').AsFloat;

  lMemTable.first;

  while not lMemTable.Eof do
  begin
    lMemTable.edit;
    lMemTable.FieldByName('PORCENTAGEM').AsFloat := lMemTable.FieldByName('VALOR').AsFloat / pDRG_Parametros.ValorPrincipal * 100.0;
    lMemTable.CheckBrowseMode;
    lMemTable.Next;
  end;

  lMemTable.Open;

end;

end.
