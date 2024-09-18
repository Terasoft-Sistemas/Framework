unit VendasVendedorDao;

interface

uses
  VendasVendedorModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TVendasVendedorDao = class;
  ITVendasVendedorDao=IObject<TVendasVendedorDao>;

  TVendasVendedorDao = class
  private
    [weak] mySelf : ITVendasVendedorDao;
    vIConexao 	  : IConexao;
    vConstrutor   : IConstrutorDao;

    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITVendasVendedorDao;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;

    function obterComissao(pVendasVendedorParametros : TVendasVendedorParametros): IFDDataset;

end;

implementation

uses
  System.Rtti, Data.DB, Interfaces.QueryLojaAsync, System.AnsiStrings, Terasoft.FuncoesTexto;

{ TVendasVendedor }

constructor TVendasVendedorDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TVendasVendedorDao.Destroy;
begin
  inherited;
end;

class function TVendasVendedorDao.getNewIface(pIConexao: IConexao): ITVendasVendedorDao;
begin
  Result := TImplObjetoOwner<TVendasVendedorDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TVendasVendedorDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  Result := lSQL;
end;

function TVendasVendedorDao.obterComissao(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
var
  lSQL        : String;
  lMemTable   : TFDMemTable;
  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin
  lAsyncList := getQueryLojaAsyncList(vIConexao, pVendasVendedorParametros.Lojas);
  lMemTable  := TFDMemTable.Create(nil);
  Result     := criaIFDDataset(lMemTable);

  lSQL := ' select                                                                                                                                                                            '+SLineBreak+
          '     f.nome_fun,                                                                                                                                                                   '+SLineBreak+
          '     f.codigo_fun,                                                                                                                                                                 '+SLineBreak+
          '     ''RECEBIMENTO'' tipo,                                                                                                                                                         '+SLineBreak+
          '     ''PEDIDO'' documento,                                                                                                                                                         '+SLineBreak+
          '     p.loja,                                                                                                                                                                       '+SLineBreak+
          '     p.numero_ped numero_ped,                                                                                                                                                      '+SLineBreak+
          '     p.numero_nf,                                                                                                                                                                  '+SLineBreak+
          '     cli.codigo_cli,                                                                                                                                                               '+SLineBreak+
          '     coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                                          '+SLineBreak+
          '     cli.fantasia_cli,                                                                                                                                                             '+SLineBreak+
          '     pt.nome_port,                                                                                                                                                                 '+SLineBreak+
          '     ci.pacela_rec||''/''||ci.totalparcelas_rec parcela,                                                                                                                           '+SLineBreak+
          '     coalesce(cor.data_cor, cai.data_cai) data_baixa,                                                                                                                              '+SLineBreak+
          '     (ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) /100 valor,                                                                             '+SLineBreak+
          '     cast(coalesce(((cast((ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) / 100 as float)) *                                                 '+SLineBreak+
          '                       (select sum(cast((coalesce(pdi.qtde_calculada, 0) * coalesce(pdi.valorunitario_ped, 0))* coalesce(pdi.comissao_percentual, 0) / 100 as decimal (15, 5)))    '+SLineBreak+
          '                          from pedidoitens pdi                                                                                                                                     '+SLineBreak+
          '                         where pdi.numero_ped = c.pedido_rec)) /                                                                                                                   '+SLineBreak+
          '                       (select sum((pdi.valorunitario_ped * pdi.qtde_calculada))                                                                                                   '+SLineBreak+
          '                          from pedidoitens pdi                                                                                                                                     '+SLineBreak+
          '                         where pdi.numero_ped = c.pedido_rec), 0) as float) comissao,                                                                                              '+SLineBreak+
          '     cast(coalesce((coalesce((ci.comissao_base *                                                                                                                                   '+SLineBreak+
          '                                 (select sum(cast((coalesce(pdi.qtde_calculada, 0) * coalesce(pdi.valorunitario_ped, 0))* coalesce(pdi.comissao_percentual, 0) / 100 as float))    '+SLineBreak+
          '                                    from pedidoitens pdi                                                                                                                           '+SLineBreak+
          '                                   where pdi.numero_ped = c.pedido_rec))/                                                                                                          '+SLineBreak+
          '                                 (select sum((pdi.valorunitario_ped * pdi.qtde_calculada))                                                                                         '+SLineBreak+
          '                                    from pedidoitens pdi                                                                                                                           '+SLineBreak+
          '                                   where pdi.numero_ped = c.pedido_rec), 0) * 100)/ci.comissao_base, 0) as float) percentual                                                       '+SLineBreak+
          '   from contasreceberitens ci                                                                                                                                                      '+SLineBreak+
          '  inner join contasreceber c on ci.fatura_rec = c.fatura_rec                                                                                                                       '+SLineBreak+
          '   left join pedidovenda p on c.pedido_rec = p.numero_ped                                                                                                                          '+SLineBreak+
          '  inner join funcionario f on p.codigo_ven = f.codigo_fun                                                                                                                          '+SLineBreak+
          '   left join clientes cli on ci.codigo_cli = cli.codigo_cli                                                                                                                        '+SLineBreak+
          '   left join portador pt on pt.codigo_port = ci.codigo_por                                                                                                                         '+SLineBreak+
          '   left join caixa cai on cai.fatura_cai = ci.fatura_rec                                                                                                                           '+SLineBreak+
          '    and cai.parcela_cai = ci.pacela_rec                                                                                                                                            '+SLineBreak+
          '    and cai.status <> ''X''                                                                                                                                                        '+SLineBreak+
          '   left join contacorrente cor on cor.fatura_cor = ci.fatura_rec                                                                                                                   '+SLineBreak+
          '    and cor.parcela_cor = ci.pacela_rec                                                                                                                                            '+SLineBreak+
          '    and cor.status <> ''X''                                                                                                                                                        '+SLineBreak+
          '  where coalesce(cor.valor_cor, cai.valor_cai) > 0                                                                                                                                 '+SLineBreak+
          '    and p.codigo_ven <> coalesce(p.gerente_id, '''')                                                                                                                               '+SLineBreak+
          '    and coalesce(p.tipo_comissao, ''F'') = ''R''                                                                                                                                   '+SLineBreak+
          '    and ci.destitulo_rec is null                                                                                                                                                   '+SLineBreak+
          '    and coalesce(cor.data_cor,cai.data_cai) between ' +
            QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL +  'and p.codigo_ven = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL +
    ' union all                                                                                                                                                                          '+SLineBreak+
    'select f.nome_fun,                                                                                                                                                                  '+SLineBreak+
    '       f.codigo_fun,                                                                                                                                                                '+SLineBreak+
    '       ''RECEBIMENTO'' tipo,                                                                                                                                                        '+SLineBreak+
    '       ''PEDIDO'' documento,                                                                                                                                                        '+SLineBreak+
    '       p.loja,                                                                                                                                                                      '+SLineBreak+
    '       p.numero_ped numero_ped,                                                                                                                                                     '+SLineBreak+
    '       p.numero_nf,                                                                                                                                                                 '+SLineBreak+
    '       cli.codigo_cli,                                                                                                                                                              '+SLineBreak+
    '       coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                                         '+SLineBreak+
    '       cli.fantasia_cli,                                                                                                                                                            '+SLineBreak+
    '       pt.nome_port,                                                                                                                                                                '+SLineBreak+
    '       ci.pacela_rec||''/''||ci.totalparcelas_rec parcela,                                                                                                                          '+SLineBreak+
    '       ci.databaixa_rec data_baixa,                                                                                                                                                 '+SLineBreak+
    '       (ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) /100 valor,                                                                            '+SLineBreak+
    '       cast(coalesce(((cast((ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) / 100 as float)) *                                                '+SLineBreak+
    '                          (select sum(cast((coalesce(pdi.qtde_calculada, 0) * coalesce(pdi.valorunitario_ped, 0))* coalesce(pdi.comissao_percentual, 0) / 100 as decimal (15, 5)))  '+SLineBreak+
    '                             from pedidoitens pdi                                                                                                                                   '+SLineBreak+
    '                            where pdi.numero_ped = c.pedido_rec))/                                                                                                                  '+SLineBreak+
    '                          (select sum((pdi.valorunitario_ped * pdi.qtde_calculada))                                                                                                 '+SLineBreak+
    '                             from pedidoitens pdi                                                                                                                                   '+SLineBreak+
    '                            where pdi.numero_ped = c.pedido_rec), 0) as float) comissao,                                                                                            '+SLineBreak+
    '       cast(coalesce((coalesce((ci.comissao_base *                                                                                                                                  '+SLineBreak+
    '                                    (select sum(cast((coalesce(pdi.qtde_calculada, 0) * coalesce(pdi.valorunitario_ped, 0))* coalesce(pdi.comissao_percentual, 0) / 100 as float))  '+SLineBreak+
    '                                       from pedidoitens pdi                                                                                                                         '+SLineBreak+
    '                                      where pdi.numero_ped = c.pedido_rec))/                                                                                                        '+SLineBreak+
    '                                    (select sum((pdi.valorunitario_ped * pdi.qtde_calculada))                                                                                       '+SLineBreak+
    '                                       from pedidoitens pdi                                                                                                                         '+SLineBreak+
    '                                      where pdi.numero_ped = c.pedido_rec), 0) * 100)/ci.comissao_base, 0) as float) percentual                                                     '+SLineBreak+
    '  from contasreceberitens ci                                                                                                                                                        '+SLineBreak+
    ' inner join contasreceber c on ci.fatura_rec = c.fatura_rec                                                                                                                         '+SLineBreak+
    '  left join pedidovenda p on c.pedido_rec = p.numero_ped                                                                                                                            '+SLineBreak+
    ' inner join funcionario f on p.codigo_ven = f.codigo_fun                                                                                                                            '+SLineBreak+
    '  left join clientes cli on ci.codigo_cli = cli.codigo_cli                                                                                                                          '+SLineBreak+
    '  left join portador pt on pt.codigo_port = ci.codigo_por                                                                                                                           '+SLineBreak+
    '  left join caixa cai on cai.fatura_cai = ci.fatura_rec                                                                                                                             '+SLineBreak+
    '   and cai.parcela_cai = ci.pacela_rec                                                                                                                                              '+SLineBreak+
    '   and cai.status <> ''X''                                                                                                                                                          '+SLineBreak+
    '  left join contacorrente cor on cor.fatura_cor = ci.fatura_rec                                                                                                                     '+SLineBreak+
    '   and cor.parcela_cor = ci.pacela_rec                                                                                                                                              '+SLineBreak+
    '   and cor.status <> ''X''                                                                                                                                                          '+SLineBreak+
    ' where coalesce(cor.valor_cor, cai.valor_cai) > 0                                                                                                                                   '+SLineBreak+
    '   and p.codigo_ven <> coalesce(p.gerente_id, '''')                                                                                                                                 '+SLineBreak+
    '   and coalesce(p.tipo_comissao, ''F'') = ''R''                                                                                                                                     '+SLineBreak+
    '   and ci.destitulo_rec = ''N''                                                                                                                                                     '+SLineBreak+
    '   and ci.databaixa_rec between ' +
       QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL +  'and p.codigo_ven = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL +
    ' union all                                                                                                                                                                                                 '+SLineBreak+
    ' select f.nome_fun,                                                                                                                                                                                        '+SLineBreak+
    '        f.codigo_fun,                                                                                                                                                                                      '+SLineBreak+
    '        ''FATURAMENTO'' tipo,                                                                                                                                                                              '+SLineBreak+
    '        ''PEDIDO'' documento,                                                                                                                                                                              '+SLineBreak+
    '        p.loja,                                                                                                                                                                                            '+SLineBreak+
    '        p.numero_ped numero_ped,                                                                                                                                                                           '+SLineBreak+
    '        p.numero_nf,                                                                                                                                                                                       '+SLineBreak+
    '        cli.codigo_cli,                                                                                                                                                                                    '+SLineBreak+
    '        coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                                                               '+SLineBreak+
    '        cli.fantasia_cli,                                                                                                                                                                                  '+SLineBreak+
    '        pt.nome_port,                                                                                                                                                                                      '+SLineBreak+
    '        '''' parcela,                                                                                                                                                                                      '+SLineBreak+
    '        p.data_faturado data_baixa,                                                                                                                                                                        '+SLineBreak+
    '        sum((it.valorunitario_ped * it.qtde_calculada) -                                                                                                                                                   '+SLineBreak+
    '            (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) -                                                                                               '+SLineBreak+
    '            (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) as valor,                                                                                                     '+SLineBreak+
    '        sum(((it.valorunitario_ped * it.qtde_calculada) -                                                                                                                                                  '+SLineBreak+
    '             (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) -                                                                                              '+SLineBreak+
    '             (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) * it.comissao_percentual /100) as comissao,                                                                  '+SLineBreak+
    '        sum(((it.valorunitario_ped * it.qtde_calculada) -                                                                                                                                                  '+SLineBreak+
    '             (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) -                                                                                              '+SLineBreak+
    '             (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) * it.comissao_percentual /100) * 100 / sum((it.valorunitario_ped * it.qtde_calculada) -                      '+SLineBreak+
    '             (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) - (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) percentual  '+SLineBreak+
    '   from pedidovenda p                                                                                                                                                                                      '+SLineBreak+
    '   left join pedidoitens it on it.numero_ped = p.numero_ped                                                                                                                                                '+SLineBreak+
    '  inner join funcionario f on p.codigo_ven = f.codigo_fun                                                                                                                                                  '+SLineBreak+
    '   left join clientes cli on p.codigo_cli = cli.codigo_cli                                                                                                                                                 '+SLineBreak+
    '   left join portador pt on pt.codigo_port = p.codigo_port                                                                                                                                                 '+SLineBreak+
    '   left join pedidovenda_analise a on p.numero_ped = a.pedido_id                                                                                                                                           '+SLineBreak+
    '  where p.codigo_ven <> coalesce(p.gerente_id, '''')                                                                                                                                                       '+SLineBreak+
    '    and coalesce(p.tipo_comissao, ''F'') = ''F''                                                                                                                                                           '+SLineBreak+
    '    and ((it.valorunitario_ped * it.qtde_calculada) -                                                                                                                                                      '+SLineBreak+
    '         (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) -                                                                                                  '+SLineBreak+
    '         (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) > 0                                                                                                              '+SLineBreak;

  if pVendasVendedorParametros.TipoData = 'E' then
  begin
    lSQL := lSQL + ' and coalesce(p.status,''P'') in (''P'',''F'')  ';
    lSQL := lSQL + ' and p.data_ped between ' +
      QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));
  end
  else if pVendasVendedorParametros.TipoData = 'F' then
  begin
    lSQL := lSQL + ' and coalesce(p.status,''P'') = ''F''  ';
    lSQL := lSQL + ' and p.data_faturado between ' +
      QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));
  end;

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and p.codigo_ven = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL + ' group by 1,2,3,4,5,6,7,8 ,9,10,11,12,13 ';

  lSQL := lSQL +
    '  union  all                                                                                                                                                                                   '+SLineBreak+
    ' select coalesce(f.nome_fun, ''SEM  GERENTE  INFORMADO'') nome_fun,                                                                                                                            '+SLineBreak+
    '        f.codigo_fun,                                                                                                                                                                          '+SLineBreak+
    '        ''RECEBIMENTO'' tipo,                                                                                                                                                                  '+SLineBreak+
    '        ''PEDIDO'' documento,                                                                                                                                                                  '+SLineBreak+
    '        p.loja,                                                                                                                                                                                '+SLineBreak+
    '        p.numero_ped numero_ped,                                                                                                                                                               '+SLineBreak+
    '        p.numero_nf,                                                                                                                                                                           '+SLineBreak+
    '        cli.codigo_cli,                                                                                                                                                                        '+SLineBreak+
    '        coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                                                   '+SLineBreak+
    '        cli.fantasia_cli,                                                                                                                                                                      '+SLineBreak+
    '        pt.nome_port,                                                                                                                                                                          '+SLineBreak+
    '        ci.pacela_rec||''/''||ci.totalparcelas_rec parcela,                                                                                                                                    '+SLineBreak+
    '        coalesce(cor.data_cor, cai.data_cai) data_baixa,                                                                                                                                       '+SLineBreak+
    '        (ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) /100 valor,                                                                                      '+SLineBreak+
    '        cast(coalesce(((cast((ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) / 100 as float)) *                                                          '+SLineBreak+
    '                             (select sum(cast((coalesce(pdi.qtde_calculada, 0) * coalesce(pdi.valorunitario_ped, 0))* coalesce(pdi.gerente_comissao_percentual, 0) / 100 as decimal (15, 5)))  '+SLineBreak+
    '                                from pedidoitens pdi                                                                                                                                           '+SLineBreak+
    '                               where pdi.numero_ped = c.pedido_rec))/                                                                                                                          '+SLineBreak+
    '                             (select sum((pdi.valorunitario_ped * pdi.qtde_calculada))                                                                                                         '+SLineBreak+
    '                                from pedidoitens pdi                                                                                                                                           '+SLineBreak+
    '                               where pdi.numero_ped = c.pedido_rec), 0) as float) comissao,                                                                                                    '+SLineBreak+
    '        cast(coalesce((coalesce((ci.comissao_base *                                                                                                                                            '+SLineBreak+
    '                                 (select sum(cast((coalesce(pdi.qtde_calculada, 0) * coalesce(pdi.valorunitario_ped, 0))* coalesce(pdi.gerente_comissao_percentual, 0) / 100 as float))        '+SLineBreak+
    '                                    from pedidoitens pdi                                                                                                                                       '+SLineBreak+
    '                                   where pdi.numero_ped = c.pedido_rec))/                                                                                                                      '+SLineBreak+
    '                                 (select sum((pdi.valorunitario_ped * pdi.qtde_calculada))                                                                                                     '+SLineBreak+
    '                                    from pedidoitens pdi                                                                                                                                       '+SLineBreak+
    '                                   where pdi.numero_ped = c.pedido_rec), 0) * 100)/ci.comissao_base, 0) as float) percentual                                                                   '+SLineBreak+
    '   from contasreceberitens ci                                                                                                                                                                  '+SLineBreak+
    '  inner join contasreceber c on ci.fatura_rec = c.fatura_rec                                                                                                                                   '+SLineBreak+
    '   left join pedidovenda p on c.pedido_rec = p.numero_ped                                                                                                                                      '+SLineBreak+
    '  inner join funcionario f on p.gerente_id = f.codigo_fun                                                                                                                                      '+SLineBreak+
    '   left join clientes cli on ci.codigo_cli = cli.codigo_cli                                                                                                                                    '+SLineBreak+
    '   left join portador pt on pt.codigo_port = ci.codigo_por                                                                                                                                     '+SLineBreak+
    '   left join caixa cai on cai.fatura_cai = ci.fatura_rec                                                                                                                                       '+SLineBreak+
    '    and cai.parcela_cai = ci.pacela_rec                                                                                                                                                        '+SLineBreak+
    '    and cai.status <> ''X''                                                                                                                                                                    '+SLineBreak+
    '   left join contacorrente cor on cor.fatura_cor = ci.fatura_rec                                                                                                                               '+SLineBreak+
    '    and cor.parcela_cor = ci.pacela_rec                                                                                                                                                        '+SLineBreak+
    '    and cor.status <> ''X''                                                                                                                                                                    '+SLineBreak+
    '  where coalesce(cor.valor_cor, cai.valor_cai) > 0                                                                                                                                             '+SLineBreak+
    '    and coalesce(p.gerente_tipo_comissao, ''F'') = ''R''                                                                                                                                       '+SLineBreak+
    '    and ci.destitulo_rec is null                                                                                                                                                               '+SLineBreak+
    '    and coalesce(cor.data_cor,cai.data_cai) between ' +
        QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and p.gerente_id = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL +
    ' union all                                                                                                                                                                                     '+SLineBreak+
    ' select coalesce(f.nome_fun, ''SEM  GERENTE  INFORMADO'') nome_fun,                                                                                                                            '+SLineBreak+
    '        f.codigo_fun,                                                                                                                                                                          '+SLineBreak+
    '        ''RECEBIMENTO'' tipo,                                                                                                                                                                  '+SLineBreak+
    '        ''PEDIDO'' documento,                                                                                                                                                                  '+SLineBreak+
    '         p.loja,                                                                                                                                                                               '+SLineBreak+
    '         p.numero_ped numero_ped,                                                                                                                                                              '+SLineBreak+
    '         p.numero_nf,                                                                                                                                                                          '+SLineBreak+
    '         cli.codigo_cli,                                                                                                                                                                       '+SLineBreak+
    '         coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                                                  '+SLineBreak+
    '         cli.fantasia_cli,                                                                                                                                                                     '+SLineBreak+
    '         pt.nome_port,                                                                                                                                                                         '+SLineBreak+
    '         ci.pacela_rec||''/''||ci.totalparcelas_rec parcela,                                                                                                                                   '+SLineBreak+
    '         ci.databaixa_rec data_baixa,                                                                                                                                                          '+SLineBreak+
    '         (ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) /100 valor,                                                                                     '+SLineBreak+
    '         cast(coalesce(((cast((ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) / 100 as float)) *                                                         '+SLineBreak+
    '                              (select sum(cast((coalesce(pdi.qtde_calculada, 0) * coalesce(pdi.valorunitario_ped, 0))* coalesce(pdi.gerente_comissao_percentual, 0) / 100 as decimal (15, 5))) '+SLineBreak+
    '                                 from pedidoitens pdi                                                                                                                                          '+SLineBreak+
    '                                where pdi.numero_ped = c.pedido_rec))/                                                                                                                         '+SLineBreak+
    '                              (select sum((pdi.valorunitario_ped * pdi.qtde_calculada))                                                                                                        '+SLineBreak+
    '                                 from pedidoitens pdi                                                                                                                                          '+SLineBreak+
    '                                where pdi.numero_ped = c.pedido_rec), 0) as float) comissao,                                                                                                   '+SLineBreak+
    '         cast(coalesce((coalesce((ci.comissao_base *                                                                                                                                           '+SLineBreak+
    '                                 (select sum(cast((coalesce(pdi.qtde_calculada, 0) * coalesce(pdi.valorunitario_ped, 0))* coalesce(pdi.gerente_comissao_percentual, 0) / 100 as float))        '+SLineBreak+
    '                                    from pedidoitens pdi                                                                                                                                       '+SLineBreak+
    '                                   where pdi.numero_ped = c.pedido_rec))/                                                                                                                      '+SLineBreak+
    '                                 (select sum((pdi.valorunitario_ped * pdi.qtde_calculada))                                                                                                     '+SLineBreak+
    '                                    from pedidoitens pdi                                                                                                                                       '+SLineBreak+
    '                                   where pdi.numero_ped = c.pedido_rec), 0) * 100)/ci.comissao_base, 0) as float) percentual                                                                   '+SLineBreak+
    '   from contasreceberitens ci                                                                                                                                                                  '+SLineBreak+
    '  inner join contasreceber c on ci.fatura_rec = c.fatura_rec                                                                                                                                   '+SLineBreak+
    '   left join pedidovenda p on c.pedido_rec = p.numero_ped                                                                                                                                      '+SLineBreak+
    '  inner join funcionario f on p.gerente_id = f.codigo_fun                                                                                                                                      '+SLineBreak+
    '   left join clientes cli on ci.codigo_cli = cli.codigo_cli                                                                                                                                    '+SLineBreak+
    '   left join portador pt on pt.codigo_port = ci.codigo_por                                                                                                                                     '+SLineBreak+
    '   left join caixa cai on cai.fatura_cai = ci.fatura_rec                                                                                                                                       '+SLineBreak+
    '    and cai.parcela_cai = ci.pacela_rec                                                                                                                                                        '+SLineBreak+
    '    and cai.status <> ''X''                                                                                                                                                                    '+SLineBreak+
    '   left join contacorrente cor on cor.fatura_cor = ci.fatura_rec                                                                                                                               '+SLineBreak+
    '    and cor.parcela_cor = ci.pacela_rec                                                                                                                                                        '+SLineBreak+
    '    and cor.status <> ''X''                                                                                                                                                                    '+SLineBreak+
    '  where coalesce(cor.valor_cor, cai.valor_cai) > 0                                                                                                                                             '+SLineBreak+
    '    and coalesce(p.gerente_tipo_comissao, ''F'') = ''R''                                                                                                                                       '+SLineBreak+
    '    and ci.destitulo_rec = ''N''                                                                                                                                                               '+SLineBreak+
    '    and ci.databaixa_rec between ' +
         QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and p.gerente_id = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL +
    '  union all                                                                                                                                                                                                '+SLineBreak+
    '  select coalesce(f.nome_fun, ''SEM  GERENTE  INFORMADO'') nome_fun,                                                                                                                                       '+SLineBreak+
    '         f.codigo_fun,                                                                                                                                                                                     '+SLineBreak+
    '         ''FATURAMENTO'' tipo,                                                                                                                                                                             '+SLineBreak+
    '         ''PEDIDO'' documento,                                                                                                                                                                             '+SLineBreak+
    '         p.loja,                                                                                                                                                                                           '+SLineBreak+
    '         p.numero_ped numero_ped,                                                                                                                                                                          '+SLineBreak+
    '         p.numero_nf,                                                                                                                                                                                      '+SLineBreak+
    '         cli.codigo_cli,                                                                                                                                                                                   '+SLineBreak+
    '         coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                                                              '+SLineBreak+
    '         cli.fantasia_cli,                                                                                                                                                                                 '+SLineBreak+
    '         pt.nome_port,                                                                                                                                                                                     '+SLineBreak+
    '         '''' parcela,                                                                                                                                                                                     '+SLineBreak+
    '         p.data_faturado data_baixa,                                                                                                                                                                       '+SLineBreak+
    '         sum((it.valorunitario_ped * it.qtde_calculada) -                                                                                                                                                  '+SLineBreak+
    '             (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) -                                                                                              '+SLineBreak+
    '             (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) as valor,                                                                                                    '+SLineBreak+
    '         sum(((it.valorunitario_ped * it.qtde_calculada) -                                                                                                                                                 '+SLineBreak+
    '              (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) -                                                                                             '+SLineBreak+
    '              (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) * it.gerente_comissao_percentual /100) as comissao,                                                         '+SLineBreak+
    '         sum(((it.valorunitario_ped * it.qtde_calculada) -                                                                                                                                                 '+SLineBreak+
    '              (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) -                                                                                             '+SLineBreak+
    '              (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) * it.gerente_comissao_percentual /100) * 100 / sum((it.valorunitario_ped * it.qtde_calculada) -             '+SLineBreak+
    '              (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) - (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) percentual '+SLineBreak+
    '    from pedidovenda p                                                                                                                                                                                     '+SLineBreak+
    '    left join pedidoitens it on it.numero_ped = p.numero_ped                                                                                                                                               '+SLineBreak+
    '   inner join funcionario f on p.gerente_id = f.codigo_fun                                                                                                                                                 '+SLineBreak+
    '    left join clientes cli on p.codigo_cli = cli.codigo_cli                                                                                                                                                '+SLineBreak+
    '    left join portador pt on pt.codigo_port = p.codigo_port                                                                                                                                                '+SLineBreak+
    '    left join pedidovenda_analise a on p.numero_ped = a.pedido_id                                                                                                                                          '+SLineBreak+
    '   where coalesce(p.gerente_tipo_comissao, ''F'') = ''F''                                                                                                                                                  '+SLineBreak+
    '     and ((it.valorunitario_ped * it.qtde_calculada) -                                                                                                                                                     '+SLineBreak+
    '          (cast(it.qtde_calculada * it.valorunitario_ped as float) * coalesce(it.desconto_ped, 0) / 100) -                                                                                                 '+SLineBreak+
    '          (it.qtde_calculada * it.valorunitario_ped / p.valor_ped * coalesce(p.dolar, 0))) > 0                                                                                                             '+SLineBreak;

  if pVendasVendedorParametros.TipoData = 'E' then
  begin
    lSQL := lSQL + ' and coalesce(p.status,''P'') in (''P'',''F'')  ';
    lSQL := lSQL + ' and p.data_ped between ' +
      QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));
  end
  else if pVendasVendedorParametros.TipoData = 'F' then
  begin
    lSQL := lSQL + ' and coalesce(p.status,''P'') = ''F''  ';
    lSQL := lSQL + ' and p.data_faturado between ' +
      QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));
  end;

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and p.gerente_id = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL + ' group by 1,2,3,4,5,6,7,8 ,9,10,11,12,13 ';

  lSQL := lSQL +
    '   union all                                                                                                                                                                      '+SLineBreak+
    '  select f.nome_fun,                                                                                                                                                              '+SLineBreak+
    '         f.codigo_fun,                                                                                                                                                            '+SLineBreak+
    '         ''RECEBIMENTO'' tipo,                                                                                                                                                    '+SLineBreak+
    '         ''O.S.'' documento,                                                                                                                                                      '+SLineBreak+
    '         p.loja,                                                                                                                                                                  '+SLineBreak+
    '         p.numero_os numero_ped,                                                                                                                                                  '+SLineBreak+
    '         p.numero_nf,                                                                                                                                                             '+SLineBreak+
    '         cli.codigo_cli,                                                                                                                                                          '+SLineBreak+
    '         coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                                     '+SLineBreak+
    '         coalesce(cli.razao_cli, cli.fantasia_cli) fantasia_cli,                                                                                                                  '+SLineBreak+
    '         pt.nome_port,                                                                                                                                                            '+SLineBreak+
    '         ci.pacela_rec||''/''||ci.totalparcelas_rec parcela,                                                                                                                      '+SLineBreak+
    '         coalesce(cor.data_cor, cai.data_cai) data_baixa,                                                                                                                         '+SLineBreak+
    '         (ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) /100 valor,                                                                        '+SLineBreak+
    '         cast(coalesce(((cast((ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) / 100 as float)) *                                            '+SLineBreak+
    '                              (select sum(cast((coalesce(pdi.quantidade_pro, 0) * coalesce(pdi.valorunitario_os, 0))* coalesce(pdi.comissao_vend, 0) / 100 as decimal (15, 5)))   '+SLineBreak+
    '                                 from ositens pdi                                                                                                                                 '+SLineBreak+
    '                                where pdi.numero_os = p.numero_os                                                                                                                 '+SLineBreak+
    '                                  and f.codigo_fun = pdi.vendedor_id))/                                                                                                           '+SLineBreak+
    '                              (select sum((pdi.valorunitario_os * pdi.quantidade_pro))                                                                                            '+SLineBreak+
    '                                 from ositens pdi                                                                                                                                 '+SLineBreak+
    '                                where pdi.numero_os = p.numero_os                                                                                                                 '+SLineBreak+
    '                                  and f.codigo_fun = pdi.vendedor_id), 0) as float) comissao,                                                                                     '+SLineBreak+
    '         cast(coalesce((coalesce((ci.comissao_base *                                                                                                                              '+SLineBreak+
    '                                 (select sum(cast((coalesce(pdi.quantidade_pro, 0) * coalesce(pdi.valorunitario_os, 0))* coalesce(pdi.comissao_vend, 0) / 100 as float))          '+SLineBreak+
    '                                    from ositens pdi                                                                                                                              '+SLineBreak+
    '                                   where pdi.numero_os = p.numero_os                                                                                                              '+SLineBreak+
    '                                     and f.codigo_fun = pdi.vendedor_id))/                                                                                                        '+SLineBreak+
    '                                 (select sum((pdi.valorunitario_os * pdi.quantidade_pro))                                                                                         '+SLineBreak+
    '                                    from ositens pdi                                                                                                                              '+SLineBreak+
    '                                   where pdi.numero_os = p.numero_os                                                                                                              '+SLineBreak+
    '                                     and f.codigo_fun = pdi.vendedor_id), 0) * 100)/ci.comissao_base, 0) as float) percentual                                                     '+SLineBreak+
    '    from contasreceberitens ci                                                                                                                                                    '+SLineBreak+
    '   inner join contasreceber c on ci.fatura_rec = c.fatura_rec                                                                                                                     '+SLineBreak+
    '    left join os p on c.os_rec = p.numero_os                                                                                                                                      '+SLineBreak+
    '   inner join funcionario f on                                                                                                                                                    '+SLineBreak+
    '     (select sum(coalesce(pi.quantidade_pro, 0) * coalesce(pi.valorunitario_os, 0))                                                                                               '+SLineBreak+
    '        from ositens pi                                                                                                                                                           '+SLineBreak+
    '       where pi.numero_os = p.numero_os                                                                                                                                           '+SLineBreak+
    '         and f.codigo_fun = pi.vendedor_id                                                                                                                                        '+SLineBreak+
    '         and coalesce(pi.tipo_comissao_vend, ''F'') = ''R'') > 0                                                                                                                  '+SLineBreak+
    '    left join clientes cli on ci.codigo_cli = cli.codigo_cli                                                                                                                      '+SLineBreak+
    '    left join portador pt on pt.codigo_port = ci.codigo_por                                                                                                                       '+SLineBreak+
    '    left join caixa cai on cai.fatura_cai = ci.fatura_rec                                                                                                                         '+SLineBreak+
    '     and cai.parcela_cai = ci.pacela_rec                                                                                                                                          '+SLineBreak+
    '     and cai.status <> ''X''                                                                                                                                                      '+SLineBreak+
    '    left join contacorrente cor on cor.fatura_cor = ci.fatura_rec                                                                                                                 '+SLineBreak+
    '     and cor.parcela_cor = ci.pacela_rec                                                                                                                                          '+SLineBreak+
    '     and cor.status <> ''X''                                                                                                                                                      '+SLineBreak+
    '   where 1=1                                                                                                                                                                      '+SLineBreak+
    '     and coalesce(cor.data_cor,cai.data_cai) between ' +
        QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and f.codigo_fun = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL +
    '  union all                                                                                                                                               '+SLineBreak+
    ' select f.nome_fun,                                                                                                                                       '+SLineBreak+
    '        f.codigo_fun,                                                                                                                                     '+SLineBreak+
    '        ''FATURAMENTO'' tipo,                                                                                                                             '+SLineBreak+
    '        ''O.S.'' documento,                                                                                                                               '+SLineBreak+
    '        p.loja,                                                                                                                                           '+SLineBreak+
    '        p.numero_os numero_ped,                                                                                                                           '+SLineBreak+
    '        p.numero_nf,                                                                                                                                      '+SLineBreak+
    '        cli.codigo_cli,                                                                                                                                   '+SLineBreak+
    '        coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                              '+SLineBreak+
    '        coalesce(cli.razao_cli, cli.fantasia_cli) fantasia_cli,                                                                                           '+SLineBreak+
    '        pt.nome_port,                                                                                                                                     '+SLineBreak+
    '        '''' parcela,                                                                                                                                     '+SLineBreak+
    '        p.fechamento_os data_baixa,                                                                                                                       '+SLineBreak+
    '        sum(cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float)) as valor,                              '+SLineBreak+
    '        sum(cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float) * it.comissao_vend /100) as comissao,   '+SLineBreak+
    '        sum((cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float) * it.comissao_vend /100)) * 100 /      '+SLineBreak+
    '            sum(case                                                                                                                                      '+SLineBreak+
    '                when cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float) = 0 then 1                     '+SLineBreak+
    '                else cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float)                                '+SLineBreak+
    '                end) percentual                                                                                                                           '+SLineBreak+
    '   from os p                                                                                                                                              '+SLineBreak+
    '   left join ositens it on it.numero_os = p.numero_os                                                                                                     '+SLineBreak+
    '  inner join funcionario f on it.vendedor_id = f.codigo_fun                                                                                               '+SLineBreak+
    '   left join clientes cli on p.codigo_cli = cli.codigo_cli                                                                                                '+SLineBreak+
    '   left join portador pt on pt.codigo_port = p.codigo_prt                                                                                                 '+SLineBreak+
    '  where it.vendedor_id is not null                                                                                                                        '+SLineBreak+
    '    and coalesce(it.tipo_comissao_vend, ''F'') = ''F''                                                                                                    '+SLineBreak+
    '    and p.fechamento_os between ' +
    QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and f.codigo_fun = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL + ' group by 1,2,3,4,5,6,7,8,9,10,11,12,13 ';

  lSQl := lSQL +
    '   union all                                                                                                                                               '+SLineBreak+
    '  select                                                                                                                                                   '+SLineBreak+
    '     f.nome_fun,                                                                                                                                           '+SLineBreak+
    '     f.codigo_fun,                                                                                                                                         '+SLineBreak+
    '     ''RECEBIMENTO'' tipo,                                                                                                                                 '+SLineBreak+
    '     ''O.S.'' documento,                                                                                                                                   '+SLineBreak+
    '     p.loja,                                                                                                                                               '+SLineBreak+
    '     p.numero_os numero_ped ,                                                                                                                              '+SLineBreak+
    '     p.numero_nf,                                                                                                                                          '+SLineBreak+
    '     cli.codigo_cli,                                                                                                                                       '+SLineBreak+
    '     coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                  '+SLineBreak+
    '     coalesce(cli.razao_cli, cli.fantasia_cli) fantasia_cli, pt.nome_port,                                                                                 '+SLineBreak+
    '     ci.pacela_rec||''/''||ci.totalparcelas_rec parcela,                                                                                                   '+SLineBreak+
    '     coalesce(cor.data_cor,cai.data_cai) data_baixa,                                                                                                       '+SLineBreak+
    '     (ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) /100  valor,                                                    '+SLineBreak+
    '     cast(coalesce((( cast((ci.comissao_base * 100 / ci.vlrparcela_rec) * coalesce(cor.valor_cor, cai.valor_cai) / 100 as float) ) *                       '+SLineBreak+
    '          (select  sum(cast((coalesce(pdi.quantidade_pro,0) * coalesce(pdi.valorunitario_os,0))* coalesce(pdi.comissao_tec,0) / 100 as decimal (15,5)))    '+SLineBreak+
    '            from ositens pdi                                                                                                                               '+SLineBreak+
    '           where pdi.numero_os = p.numero_os                                                                                                               '+SLineBreak+
    '             and f.codigo_fun = pdi.tecnico_id)) /                                                                                                         '+SLineBreak+
    '          (select sum((pdi.valorunitario_os * pdi.quantidade_pro))                                                                                         '+SLineBreak+
    '            from ositens pdi                                                                                                                               '+SLineBreak+
    '           where pdi.numero_os = p.numero_os                                                                                                               '+SLineBreak+
    '             and f.codigo_fun = pdi.tecnico_id), 0) AS float) comissao,                                                                                    '+SLineBreak+
    '     cast(coalesce((coalesce((ci.COMISSAO_BASE *                                                                                                           '+SLineBreak+
    '          (select sum(cast((coalesce(pdi.quantidade_pro,0) * coalesce(pdi.valorunitario_os,0))* coalesce(pdi.comissao_tec,0) / 100 as float))              '+SLineBreak+
    '             from ositens pdi                                                                                                                              '+SLineBreak+
    '            where pdi.numero_os = p.numero_os                                                                                                              '+SLineBreak+
    '              and f.codigo_fun = pdi.tecnico_id))/                                                                                                         '+SLineBreak+
    '          (select sum((pdi.valorunitario_os * pdi.quantidade_pro))                                                                                         '+SLineBreak+
    '             from ositens pdi                                                                                                                              '+SLineBreak+
    '            where pdi.numero_os = p.numero_os and f.codigo_fun = pdi.tecnico_id), 0) * 100)/ci.COMISSAO_BASE, 0) AS float) percentual                      '+SLineBreak+
    '     from contasreceberitens ci                                                                                                                            '+SLineBreak+
    '    inner join contasreceber c on ci.fatura_rec = c.fatura_rec                                                                                             '+SLineBreak+
    '     left join os p on c.os_rec = p.numero_os                                                                                                              '+SLineBreak+
    '    inner join funcionario f on                                                                                                                            '+SLineBreak+
    '          (select sum(coalesce(pi.quantidade_pro,0) * coalesce(pi.valorunitario_os,0))                                                                     '+SLineBreak+
    '             from ositens pi                                                                                                                               '+SLineBreak+
    '            where pi.numero_os = p.numero_os                                                                                                               '+SLineBreak+
    '              and f.codigo_fun = pi.tecnico_id                                                                                                             '+SLineBreak+
    '              and coalesce(pi.tipo_comissao_tec,''F'') = ''R'' ) > 0                                                                                       '+SLineBreak+
    '     left join clientes cli on ci.codigo_cli = cli.codigo_cli                                                                                              '+SLineBreak+
    '     left join portador pt on pt.CODIGO_PORT = ci.CODIGO_POR                                                                                               '+SLineBreak+
    '     left join caixa cai on cai.fatura_cai = ci.fatura_rec                                                                                                 '+SLineBreak+
    '      and cai.parcela_cai = ci.pacela_rec                                                                                                                  '+SLineBreak+
    '      and cai.status <> ''X''                                                                                                                              '+SLineBreak+
    '     left join contacorrente cor on cor.fatura_cor = ci.fatura_rec                                                                                         '+SLineBreak+
    '      and cor.parcela_cor = ci.pacela_rec                                                                                                                  '+SLineBreak+
    '      and cor.status <> ''X''                                                                                                                              '+SLineBreak+
    '    where coalesce(cor.data_cor,cai.data_cai) between                                                                                                      '+SLineBreak+
      QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and f.codigo_fun = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL +
    '   union all                                                                                                                                               '+SLineBreak+
    '  select                                                                                                                                                   '+SLineBreak+
    '     f.nome_fun,                                                                                                                                           '+SLineBreak+
    '     f.codigo_fun,                                                                                                                                         '+SLineBreak+
    '     ''FATURAMENTO'' tipo,                                                                                                                                 '+SLineBreak+
    '     ''O.S.'' documento,                                                                                                                                   '+SLineBreak+
    '     p.loja,                                                                                                                                               '+SLineBreak+
    '     p.numero_os numero_ped ,                                                                                                                              '+SLineBreak+
    '     p.numero_nf,                                                                                                                                          '+SLineBreak+
    '     cli.codigo_cli,                                                                                                                                       '+SLineBreak+
    '     coalesce(cli.razao_cli, cli.fantasia_cli) razao_cli,                                                                                                  '+SLineBreak+
    '     coalesce(cli.razao_cli, cli.fantasia_cli) fantasia_cli, pt.nome_port,                                                                                 '+SLineBreak+
    '     '''' parcela,                                                                                                                                         '+SLineBreak+
    '     p.fechamento_os data_baixa,                                                                                                                           '+SLineBreak+
    '     sum(cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float)) as valor,                                  '+SLineBreak+
    '     sum(cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float) * it.comissao_tec /100) as comissao,        '+SLineBreak+
    '     sum((cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float) * it.comissao_tec /100)) * 100 /           '+SLineBreak+
    '         sum(case when cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float) = 0 then                      '+SLineBreak+
    '               1                                                                                                                                           '+SLineBreak+
    '             else cast((it.valorunitario_os-((it.descontopro_os/100)*it.valorunitario_os))* it.quantidade_pro as float) end ) percentual                   '+SLineBreak+
    '    from os p                                                                                                                                              '+SLineBreak+
    '    left join ositens it on it.numero_os = p.numero_os                                                                                                     '+SLineBreak+
    '   inner join funcionario f on it.tecnico_id = f.codigo_fun                                                                                                '+SLineBreak+
    '    left join clientes cli on p.codigo_cli = cli.codigo_cli                                                                                                '+SLineBreak+
    '    left join portador pt on pt.CODIGO_PORT = p.CODIGO_PRT                                                                                                 '+SLineBreak+
    '   where it.tecnico_id is not null                                                                                                                         '+SLineBreak+
    '     and coalesce(it.tipo_comissao_tec,''F'') = ''F''                                                                                                      '+SLineBreak+
    '     and p.fechamento_os between ' +
       QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and f.codigo_fun = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL + ' group by 1,2,3,4,5,6,7,8,9,10,11,12,13 ';
  lSQL := lSQL + ' order by 3, 11, 6 ';

  gravaSQL(lSQL, 'VendasVendedorObterComissao_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  lMemTable.FieldDefs.Add('NOME_FUN', ftString, 50);
  lMemTable.FieldDefs.Add('CODIGO_FUN', ftString, 6);
  lMemTable.FieldDefs.Add('TIPO', ftString, 11);
  lMemTable.FieldDefs.Add('NUMERO_PED', ftString, 6);
  lMemTable.FieldDefs.Add('NUMERO_NF', ftString, 6);
  lMemTable.FieldDefs.Add('RAZAO_CLI', ftString, 100);
  lMemTable.FieldDefs.Add('FANTASIA_CLI', ftString, 100);
  lMemTable.FieldDefs.Add('NOME_PORT', ftString, 20);
  lMemTable.FieldDefs.Add('PARCELA', ftString, 23);
  lMemTable.FieldDefs.Add('DATA_BAIXA', ftDate);
  lMemTable.FieldDefs.Add('VALOR', ftFloat);
  lMemTable.FieldDefs.Add('COMISSAO', ftFloat);
  lMemTable.FieldDefs.Add('PERCENTUAL', ftFloat);
  lMemTable.FieldDefs.Add('DOCUMENTO', ftString, 6);
  lMemTable.FieldDefs.Add('LOJA', ftString, 3);
  lMemTable.FieldDefs.Add('CODIGO_CLI', ftString, 6);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterComissao';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterComissao: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterComissao: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA, lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lMemTable.InsertRecord([lQA.dataset.dataset.FieldByName('NOME_FUN').AsString,
                              lQA.dataset.dataset.FieldByName('CODIGO_FUN').AsString,
                              lQA.dataset.dataset.FieldByName('TIPO').AsString,
                              lQA.dataset.dataset.FieldByName('NUMERO_PED').AsString,
                              lQA.dataset.dataset.FieldByName('NUMERO_NF').AsString,
                              lQA.dataset.dataset.FieldByName('RAZAO_CLI').AsString,
                              lQA.dataset.dataset.FieldByName('FANTASIA_CLI').AsString,
                              lQA.dataset.dataset.FieldByName('NOME_PORT').AsString,
                              lQA.dataset.dataset.FieldByName('PARCELA').AsString,
                              lQA.dataset.dataset.FieldByName('DATA_BAIXA').AsDateTime,
                              lQA.dataset.dataset.FieldByName('VALOR').AsFloat,
                              lQA.dataset.dataset.FieldByName('COMISSAO').AsFloat,
                              lQA.dataset.dataset.FieldByName('PERCENTUAL').AsFloat,
                              lQA.dataset.dataset.FieldByName('DOCUMENTO').AsString,
                              lQA.dataset.dataset.FieldByName('LOJA').AsString,
                              lQA.dataset.dataset.FieldByName('CODIGO_CLI').AsString]);

      lQA.dataset.dataset.Next;
    end;
  end;

end;

procedure TVendasVendedorDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from GRUPO_FILIAIS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TVendasVendedorDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVendasVendedorDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVendasVendedorDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TVendasVendedorDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TVendasVendedorDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TVendasVendedorDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
