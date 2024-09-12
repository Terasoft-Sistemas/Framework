unit DashbordDao;

interface

uses
  DashbordModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Utils,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  Interfaces.QueryLojaAsync,
  LojasModel;

type
  TDashbordDao = class;
  ITDashbordDao=IObject<TDashbordDao>;

  TDashbordDao = class
  private
    [weak] mySelf: ITDashbordDao;
    vIConexao : IConexao;
  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDashbordDao;

    function ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;

  end;

implementation

uses
  Terasoft.Framework.LOG,
  Data.DB,
  Clipbrd;

{ TDashbord }

constructor TDashbordDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDashbordDao.Destroy;
begin
  inherited;
end;

class function TDashbordDao.getNewIface(pIConexao: IConexao): ITDashbordDao;
begin
  Result := TImplObjetoOwner<TDashbordDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDashbordDao.ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lSQL:String;
  MemTable: TFDMemTable;
  lTotalValores: Real;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;

begin

  lAsyncList := getQueryLojaAsyncList(vIConexao,pDashbord_Parametros.Lojas);

  MemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(MemTable);

  lSQL := 'select                                                                                                                             ' + #13 +
          '    VALOR_LIQUIDO,                                                                                                                 ' + #13 +
          '    DESCONTO,                                                                                                                      ' + #13 +
          '    ACRESCIMO,                                                                                                                     ' + #13 +
          '    FRETE,                                                                                                                         ' + #13 +
          '    IPI,                                                                                                                           ' + #13 +
          '    ST,                                                                                                                            ' + #13 +
          '    CUSTO,                                                                                                                         ' + #13 +
          '    TOTAL_ITENS,                                                                                                                   ' + #13 +
          '    QUANTIDADE_VENDA,                                                                                                              ' + #13 +
          '    CLIENTE                                                                                                                        ' + #13 +
          '                                                                                                                                   ' + #13 +
          'from                                                                                                                               ' + #13 +
          '(                                                                                                                                  ' + #13 +
          '                                                                                                                                   ' + #13 +
          '    select                                                                                                                         ' + #13 +
          '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                 ' + #13 +
          '        sum(desconto) DESCONTO,                                                                                                    ' + #13 +
          '        sum(acrescimo) ACRESCIMO,                                                                                                  ' + #13 +
          '        sum(frete) FRETE,                                                                                                          ' + #13 +
          '        sum(ipi) IPI,                                                                                                              ' + #13 +
          '        sum(st) ST,                                                                                                                ' + #13 +
          '        sum(custo) CUSTO,                                                                                                          ' + #13 +
          '        sum(total_itens) TOTAL_ITENS,                                                                                              ' + #13 +
          '        count(distinct(quantidade_venda)) QUANTIDADE_VENDA,                                                                        ' + #13 +
          '        count(distinct(cliente)) CLIENTE,                                                                                          ' + #13 +
          '        '' '' ITEM                                                                                                                 ' + #13 +
          '    from                                                                                                                           ' + #13 +
          '    (                                                                                                                              ' + #13 +
          '       select                                                                                                                      ' + #13 +
          '            v.data_ped DATA_EMISSAO,                                                                                               ' + #13 +
          '            v.data_faturado DATA_FATURADO,                                                                                         ' + #13 +
          '            (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
          '            (i.valorunitario_ped*(cast(i.desconto_ped as float)/100))*i.qtde_calculada DESCONTO,                 ' + #13 +
          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
          '            i.valor_ipi IPI,                                                                                                       ' + #13 +
          '            i.valor_st ST,                                                                                                         ' + #13 +
          '            coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
          '            coalesce(i.qtde_calculada, 0) TOTAL_ITENS,                                                                             ' + #13 +
          '            v.numero_ped || ''P'' QUANTIDADE_VENDA,                                                                                ' + #13 +
          '            v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
          '            '' '' ITEM                                                                                                             ' + #13 +
          '        from                                                                                                                       ' + #13 +
          '            pedidovenda v                                                                                                          ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        inner join pedidoitens i on v.numero_ped = i.numero_ped                                                                    ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        where                                                                                                                      ' + #13 +
          '            coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
          '            and coalesce(v.status,''P'') in (''P'',''F'')                                                                          ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '                                                                                                                                   ' + #13 +
          '        union all                                                                                                                  ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        select                                                                                                                     ' + #13 +
          '            distinct                                                                                                               ' + #13 +
          '            d.data DATA_EMISSAO,                                                                                                   ' + #13 +
          '            d.data DATA_FATURADO,                                                                                                  ' + #13 +
          '            (di.valor_unitario * di.quantidade) * -1 VALOR_PRODUTO,                                                                ' + #13 +
          '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.desconto as float),0) *-1 DESCONTO,           ' + #13 +
          '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.valor_acrescimo as float),0) *-1 ACRESCIMO,   ' + #13 +
          '            0 FRETE,                                                                                                               ' + #13 +
          '            0 IPI,                                                                                                                 ' + #13 +
          '            0 ST,                                                                                                                  ' + #13 +
          '            (di.quantidade*di.custo)*-1 CUSTO ,                                                                                                               ' + #13 +
          '            0 TOTAL_ITENS,                                                                                                         ' + #13 +
          '            null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
          '            null CLIENTE,                                                                                                          ' + #13 +
          '            di.item ITEM                                                                                                           ' + #13 +
          '        from                                                                                                                       ' + #13 +
          '             devolucao d                                                                                                           ' + #13 +
          '               left join funcionario f     on f.codigo_fun  = d.vendedor                                                           ' + #13 +
          '               left join devolucaoitens di on di.id         = d.id                                                                 ' + #13 +
          '               left join pedidovenda v     on v.numero_ped  = d.pedido                                                             ' + #13 +
          '               left join pedidoitens vi    on vi.numero_ped = v.numero_ped and                                                     ' + #13 +
          '                                              vi.codigo_pro = di.produto                                                           ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        where                                                                                                                      ' + #13 +
          '            coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '                                                                                                                                   ' + #13 +
          '        union all                                                                                                                  ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        select                                                                                                                     ' + #13 +
          '            e.datamovi_ent DATA_EMISSAO,                                                                                           ' + #13 +
          '            e.datamovi_ent DATA_FATURADO,                                                                                          ' + #13 +
          '            coalesce(e.TOTAL_ENT,0) * -1 VALOR_PRODUTO,                                                                            ' + #13 +
          '            0 DESCONTO,                                                                                                            ' + #13 +
          '            0 ACRESCIMO,                                                                                                           ' + #13 +
          '            0 FRETE,                                                                                                               ' + #13 +
          '            0 IPI,                                                                                                                 ' + #13 +
          '            0 ST,                                                                                                                  ' + #13 +
          '            0 CUSTO,                                                                                                               ' + #13 +
          '            0 TOTAL_ITENS,                                                                                                         ' + #13 +
          '            null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
          '            null CLIENTE,                                                                                                          ' + #13 +
          '            '' '' ITEM                                                                                                             ' + #13 +
          '        from                                                                                                                       ' + #13 +
          '             entrada e                                                                                                             ' + #13 +
          '               inner join pedidovenda v on e.devolucao_pedido_id = v.numero_ped                                                    ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        where                                                                                                                      ' + #13 +
          '            coalesce(e.TOTAL_ENT,0) > 0                                                                                            ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '                                                                                                                                   ' + #13 +
          '        union all                                                                                                                  ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        select                                                                                                                     ' + #13 +
          '            v.fechamento_os DATA_EMISSAO,                                                                                          ' + #13 +
          '            v.fechamento_os DATA_FATURADO,                                                                                         ' + #13 +
          '            (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                   ' + #13 +
          '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,       ' + #13 +
          '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO, ' + #13 +
          '            0 FRETE,                                                                                                               ' + #13 +
          '            0 IPI,                                                                                                                 ' + #13 +
          '            0 ST,                                                                                                                  ' + #13 +
          '            coalesce(i.quantidade_pro,0) * coalesce(i.custo_pro,0) CUSTO,                                                          ' + #13 +
          '            coalesce(i.quantidade_pro,0) TOTAL_ITENS,                                                                              ' + #13 +
          '            v.numero_os || ''O'' QUANTIDADE_VENDA,                                                                                 ' + #13 +
          '            v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
          '            '' '' ITEM                                                                                                             ' + #13 +
          '        from                                                                                                                       ' + #13 +
          '             os v                                                                                                                  ' + #13 +
          '               inner join ositens i  on v.numero_os  = i.numero_os                                                                 ' + #13 +
          '               left  join produto pr on i.codigo_pro = pr.codigo_pro                                                               ' + #13 +
          '        where                                                                                                                      ' + #13 +
          '            coalesce(v.status_os,''F'') = ''F''                                                                                    ' + #13 +
          '            and coalesce(v.total_os, 0) > 0                                                                                        ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and i.vendedor_id in (' + pDashbord_Parametros.Vendedores + ') ','') + #13 +
          '                                                                                                                                   ' + #13 +
          '    ) resultado                                                                                                                    ' + #13 +
          '                                                                                                                                   ' + #13 +
          '    where                                                                                                                          ' + #13 +
          '        resultado.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between               ' + #13 +
                                 QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio))+' and                                ' + #13 +
                                 QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + '                                     ' + #13 +
          ')                                                                                                                                  ' + #13;

  gravaSQL(lSQL, 'DashbordDao_ObterQuery1_Totalizador_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  MemTable.FieldDefs.Add('LOJA', ftString,3);
  MemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
  MemTable.FieldDefs.Add('CUSTO', ftFloat);
  MemTable.FieldDefs.Add('TOTAL_ITENS', ftInteger);
  MemTable.FieldDefs.Add('QUANTIDADE_VENDA', ftInteger);
  MemTable.FieldDefs.Add('QUANTIDADE_CLIENTE', ftInteger);

  MemTable.FieldDefs.Add('TICKET_MEDIO', ftFloat);
  MemTable.FieldDefs.Add('QUANTIDADE_MEDIA', ftFloat);
  MemTable.FieldDefs.Add('VALOR_ITEM_MEDIO', ftFloat);
  MemTable.FieldDefs.Add('MARKUP_1', ftFloat);
  MemTable.FieldDefs.Add('MARKUP_2', ftFloat);

  MemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterQuery1_Totalizador';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery1_Totalizador: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery1_Totalizador: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lTotalValores := lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;

    if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ST').AsFloat;
    if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
    if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
    if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;

    if MemTable.IsEmpty then
    begin
      MemTable.InsertRecord([
                              lQA.loja.objeto.LOJA,
                              lTotalValores,
                              lQA.dataset.dataset.FieldByName('CUSTO').AsFloat,
                              lQA.dataset.dataset.FieldByName('TOTAL_ITENS').AsInteger,
                              lQA.dataset.dataset.FieldByName('QUANTIDADE_VENDA').AsInteger,
                              lQA.dataset.dataset.FieldByName('CLIENTE').AsInteger
                              ]);
    end else
    begin
      MemTable.Edit;
      MemTable.FieldByName('VALOR_LIQUIDO').Value      := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
      MemTable.FieldByName('CUSTO').Value              := MemTable.FieldByName('CUSTO').Value + lQA.dataset.dataset.FieldByName('CUSTO').AsFloat;
      MemTable.FieldByName('TOTAL_ITENS').Value        := MemTable.FieldByName('TOTAL_ITENS').Value + lQA.dataset.dataset.FieldByName('TOTAL_ITENS').AsInteger;
      MemTable.FieldByName('QUANTIDADE_VENDA').Value   := MemTable.FieldByName('QUANTIDADE_VENDA').Value + lQA.dataset.dataset.FieldByName('QUANTIDADE_VENDA').AsInteger;
      MemTable.FieldByName('QUANTIDADE_CLIENTE').Value := MemTable.FieldByName('QUANTIDADE_CLIENTE').Value + lQA.dataset.dataset.FieldByName('CLIENTE').AsInteger;
      MemTable.Post;
    end;

  end;

  MemTable.Edit;
  if(MemTable.FieldByName('QUANTIDADE_VENDA').AsInteger<>0) then
  begin
    MemTable.FieldByName('TICKET_MEDIO').Value     := MemTable.FieldByName('VALOR_LIQUIDO').AsFloat/MemTable.FieldByName('QUANTIDADE_VENDA').AsInteger;
    MemTable.FieldByName('QUANTIDADE_MEDIA').Value := MemTable.FieldByName('TOTAL_ITENS').AsInteger / MemTable.FieldByName('QUANTIDADE_VENDA').AsInteger;
  end else
  begin
    MemTable.FieldByName('TICKET_MEDIO').Value     := 0;
    MemTable.FieldByName('QUANTIDADE_MEDIA').Value := 0;
  end;

  if(MemTable.FieldByName('TOTAL_ITENS').AsInteger<>0) then
    MemTable.FieldByName('VALOR_ITEM_MEDIO').Value := MemTable.FieldByName('VALOR_LIQUIDO').AsFloat / MemTable.FieldByName('TOTAL_ITENS').AsInteger
  else
   MemTable.FieldByName('VALOR_ITEM_MEDIO').Value := 0;

  if(MemTable.FieldByName('CUSTO').AsFloat<>0.0) then
    MemTable.FieldByName('MARKUP_1').Value         := (MemTable.FieldByName('VALOR_LIQUIDO').AsFloat/MemTable.FieldByName('CUSTO').AsFloat*100)-100
  else
    MemTable.FieldByName('MARKUP_1').Value         := 0;

  if(MemTable.FieldByName('VALOR_LIQUIDO').AsFloat<>0.0) then
    MemTable.FieldByName('MARKUP_2').Value         := -1*((MemTable.FieldByName('CUSTO').AsFloat*100/MemTable.FieldByName('VALOR_LIQUIDO').AsFloat)-100)
  else
    MemTable.FieldByName('MARKUP_2').Value         := 0;

  MemTable.Post;

end;

function TDashbordDao.ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lSQL:String;
  MemTable: TFDMemTable;
  lTotalValores: Real;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;

begin
  lAsyncList := getQueryLojaAsyncList(vIConexao,pDashbord_Parametros.Lojas);

  MemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(MemTable);

    lSQL := 'select                                                                                                                             ' + #13 +
            '    DATA_EMISSAO,                                                                                                                  ' + #13 +
            '    DATA_FATURADO,                                                                                                                 ' + #13 +
            '    VALOR_LIQUIDO,                                                                                                                 ' + #13 +
            '    VALOR_PRODUTO,                                                                                                                 ' + #13 +
            '    DESCONTO,                                                                                                                      ' + #13 +
            '    ACRESCIMO,                                                                                                                     ' + #13 +
            '    FRETE,                                                                                                                         ' + #13 +
            '    IPI,                                                                                                                           ' + #13 +
            '    ST,                                                                                                                            ' + #13 +
            '    CUSTO                                                                                                                          ' + #13 +
            'from                                                                                                                               ' + #13 +
            '(                                                                                                                                  ' + #13 +
            '    select                                                                                                                         ' + #13 +
            '        DATA_EMISSAO,                                                                                                              ' + #13 +
            '        DATA_FATURADO,                                                                                                             ' + #13 +
            '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                 ' + #13 +
            '        sum(valor_produto) VALOR_PRODUTO,                                                                                          ' + #13 +
            '        sum(desconto) DESCONTO,                                                                                                    ' + #13 +
            '        sum(acrescimo) ACRESCIMO,                                                                                                  ' + #13 +
            '        sum(frete) FRETE,                                                                                                          ' + #13 +
            '        sum(ipi) IPI,                                                                                                              ' + #13 +
            '        sum(st) ST,                                                                                                                ' + #13 +
            '        sum(custo) CUSTO                                                                                                           ' + #13 +
            '    from                                                                                                                           ' + #13 +
            '    (                                                                                                                              ' + #13 +
            '        select                                                                                                                     ' + #13 +
            '            v.data_ped DATA_EMISSAO,                                                                                               ' + #13 +
            '            v.data_faturado DATA_FATURADO,                                                                                         ' + #13 +
            '            (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
            '            (i.valorunitario_ped*(cast(i.desconto_ped as float)/100))*i.qtde_calculada DESCONTO,                 ' + #13 +
            '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
            '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
            '            i.valor_ipi IPI,                                                                                                       ' + #13 +
            '            i.valor_st ST,                                                                                                         ' + #13 +
            '            coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
            '			       '' '' ITEM   			                                                                                                    ' + #13 +
            '        from                                                                                                                       ' + #13 +
            '             pedidovenda v                                                                                                         ' + #13 +
            '               inner join pedidoitens i on v.numero_ped = i.numero_ped                                                             ' + #13 +
            '        where                                                                                                                      ' + #13 +
            '            coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
            '            and coalesce(v.status,''P'') in (''P'',''F'')                                                                          ' + #13 +
            '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
            '                                                                                                                                   ' + #13 +
            '        union all                                                                                                                  ' + #13 +
            '                                                                                                                                   ' + #13 +
            '        select                                                                                                                     ' + #13 +
            '            distinct                                                                                                               ' + #13 +
            '            d.data DATA_EMISSAO,                                                                                                   ' + #13 +
            '            d.data DATA_FATURADO,                                                                                                  ' + #13 +
            '            (di.valor_unitario*di.quantidade) *-1 VALOR_PRODUTO,                                                                   ' + #13 +
            '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.desconto as float),0) *-1 DESCONTO,           ' + #13 +
            '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.valor_acrescimo as float),0) *-1 ACRESCIMO,   ' + #13 +
            '            0 FRETE,                                                                                                               ' + #13 +
            '            0 IPI,                                                                                                                 ' + #13 +
            '            0 ST,                                                                                                                  ' + #13 +
            '            (di.quantidade*di.custo)*-1 CUSTO,                                                                                                               ' + #13 +
            '			       di.item ITEM                                                                                                           ' + #13 +
            '        from                                                                                                                       ' + #13 +
            '             devolucao d                                                                                                           ' + #13 +
            '               left join funcionario f     on f.codigo_fun  = d.vendedor                                                           ' + #13 +
            '               left join devolucaoitens di on di.id         = d.id                                                                 ' + #13 +
            '               left join pedidovenda v     on v.numero_ped  = d.pedido                                                             ' + #13 +
            '               left join pedidoitens vi    on vi.numero_ped = v.numero_ped and                                                     ' + #13 +
            '                                              vi.codigo_pro = di.produto                                                           ' + #13 +
            '        where                                                                                                                      ' + #13 +
            '            coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
            '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
            '                                                                                                                                   ' + #13 +
            '        union all                                                                                                                  ' + #13 +
            '                                                                                                                                   ' + #13 +
            '        select                                                                                                                     ' + #13 +
            '            e.datamovi_ent DATA_EMISSAO,                                                                                           ' + #13 +
            '            e.datamovi_ent DATA_FATURADO,                                                                                          ' + #13 +
            '            coalesce(e.TOTAL_ENT,0)*-1 VALOR_LIQUIDO,                                                                              ' + #13 +
            '            0 DESCONTO,                                                                                                            ' + #13 +
            '            0 ACRESCIMO,                                                                                                           ' + #13 +
            '            0 FRETE,                                                                                                               ' + #13 +
            '            0 IPI,                                                                                                                 ' + #13 +
            '            0 ST,                                                                                                                  ' + #13 +
            '            0 CUSTO,                                                                                                               ' + #13 +
            '			       '' '' ITEM   			                                                                                                    ' + #13 +
            '        from                                                                                                                       ' + #13 +
            '             entrada e                                                                                                             ' + #13 +
            '               inner join pedidovenda v on e.devolucao_pedido_id = v.numero_ped                                                    ' + #13 +
            '        where                                                                                                                      ' + #13 +
            '            coalesce(e.TOTAL_ENT,0) > 0                                                                                            ' + #13 +
            '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
            '                                                                                                                                   ' + #13 +
            '        union all                                                                                                                  ' + #13 +
            '                                                                                                                                   ' + #13 +
            '        select                                                                                                                     ' + #13 +
            '            v.fechamento_os DATA_EMISSAO,                                                                                          ' + #13 +
            '            v.fechamento_os DATA_FATURADO,                                                                                         ' + #13 +
            '            (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                   ' + #13 +
            '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,       ' + #13 +
            '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO, ' + #13 +
            '            0 FRETE,                                                                                                               ' + #13 +
            '            0 IPI,                                                                                                                 ' + #13 +
            '            0 ST,                                                                                                                  ' + #13 +
            '            coalesce(i.quantidade_pro,0) * coalesce(i.custo_pro,0) CUSTO,                                                          ' + #13 +
            '			       '' '' ITEM   			                                                                                                    ' + #13 +
            '        from                                                                                                                       ' + #13 +
            '             os v                                                                                                                  ' + #13 +
            '               inner join ositens i  on v.numero_os  = i.numero_os                                                                 ' + #13 +
            '               left  join produto pr on i.codigo_pro = pr.codigo_pro                                                               ' + #13 +
            '        where                                                                                                                      ' + #13 +
            '            coalesce(v.status_os,''F'') = ''F''                                                                                    ' + #13 +
            '            and coalesce(v.total_os, 0) > 0                                                                                        ' + #13 +
            '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and i.vendedor_id in (' + pDashbord_Parametros.Vendedores + ') ','') + #13 +
            '    ) resultado                                                                                                                    ' + #13 +
            '                                                                                                                                   ' + #13 +
            'where                                                                                                                              ' + #13 +
            '     resultado.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + #13 +
            '                                                                                                                                   ' + #13 +
            'group by 1, 2                                                                                                                         ' + #13 +
            'order by 1                                                                                                                         ' + #13 +
            ')                                                                                                                                  ';

    gravaSQL(lSQL, 'DashbordDao_ObterQuery2_VendaPorDia_' + FormatDateTime('yyyymmddhhnnsszzz', now));

    MemTable.FieldDefs.Add('DATA_EMISSAO', ftString, 10);
    MemTable.FieldDefs.Add('DIA', ftString, 2);
    MemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
    MemTable.CreateDataSet;

    for lQA in lAsyncList do
    begin
      lQA.rotulo := 'ObterQuery2_VendaPorDia';
      conexao := lQA.loja.objeto.conexaoLoja;
      if(conexao=nil) then
        raise Exception.CreateFmt('TDashbordDao.ObterQuery2_VendaPorDia: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

      lQA.execQuery(lSQL,'',[]);
    end;

    for lQA in lAsyncList do
    begin
      lQA.esperar;
      if(lQA.resultado.erros>0) then
        raise Exception.CreateFmt('TDashbordDao.ObterQuery2_VendaPorDia: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

      lQA.dataset.dataset.First;
      while not lQA.dataset.dataset.Eof do
      begin
        lTotalValores := lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;

        if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ST').AsFloat;
        if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
        if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
        if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;

        if pDashbord_Parametros.TipoData = 'EMISSÃO' then
        begin
          if not MemTable.Locate('DATA_EMISSAO', lQA.dataset.dataset.FieldByName('DATA_EMISSAO').AsString) then
          begin
            MemTable.InsertRecord([
                                    lQA.dataset.dataset.FieldByName('DATA_EMISSAO').AsString,
                                    Copy(lQA.dataset.dataset.FieldByName('DATA_EMISSAO').AsString, 1, 2),
                                    lTotalValores
                                    ]);
          end else
          begin
            MemTable.Edit;
            MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
            MemTable.Post;
          end;
        end else
        begin
          if not MemTable.Locate('DATA_EMISSAO', lQA.dataset.dataset.FieldByName('DATA_FATURADO').AsString) then
          begin
            MemTable.InsertRecord([
                                    lQA.dataset.dataset.FieldByName('DATA_FATURADO').AsString,
                                    Copy(lQA.dataset.dataset.FieldByName('DATA_FATURADO').AsString, 1, 2),
                                    lTotalValores
                                    ]);
          end else
          begin
            MemTable.Edit;
            MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
            MemTable.Post;
          end;
        end;
        lQA.dataset.dataset.Next;
      end;

  end;

  MemTable.IndexFieldNames := 'DATA_EMISSAO';
  MemTable.Open;

end;

function TDashbordDao.ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lSQL:String;
  MemTable: TFDMemTable;
  Options: TLocateOptions;
  lTotalValores: Real;
  I, lojas: Integer;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;

begin
  lAsyncList := getQueryLojaAsyncList(vIConexao,pDashbord_Parametros.Lojas);
  MemTable    := TFDMemTable.Create(nil);
  Result := criaIFDDataset(MemTable);
  lSQL :=
          '    select                                                                                                                     ' + #13 +
          '        extract(month from ' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ') MES,    ' + #13 +
          '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                             ' + #13 +
          '        sum(valor_produto) VALOR_PRODUTO,                                                                                      ' + #13 +
          '        sum(desconto) DESCONTO,                                                                                                ' + #13 +
          '        sum(acrescimo) ACRESCIMO,                                                                                              ' + #13 +
          '        sum(frete) FRETE,                                                                                                      ' + #13 +
          '        sum(ipi) IPI,                                                                                                          ' + #13 +
          '        sum(st) ST,                                                                                                            ' + #13 +
          '        sum(custo) CUSTO                                                                                                       ' + #13 +
          '                                                                                                                               ' + #13 +
          '    from                                                                                                                       ' + #13 +
          '    (                                                                                                                          ' + #13 +
          '    select                                                                                                                     ' + #13 +
          '        v.data_ped DATA_EMISSAO,                                                                                               ' + #13 +
          '        v.data_faturado DATA_FATURADO,                                                                                         ' + #13 +
          '        (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
          '        (i.valorunitario_ped*(cast(i.desconto_ped as float)/100))*i.qtde_calculada DESCONTO,                 ' + #13 +
          '        ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
          '        ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
          '        i.valor_ipi IPI,                                                                                                       ' + #13 +
          '        i.valor_st ST,                                                                                                         ' + #13 +
          '        coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
          '        '' '' ITEM                                                                                                         ' + #13 +
          '                                                                                                                               ' + #13 +
          '    from                                                                                                                       ' + #13 +
          '         pedidovenda v                                                                                                         ' + #13 +
          '           inner join pedidoitens i on v.numero_ped = i.numero_ped                                                             ' + #13 +
          '    where                                                                                                                      ' + #13 +
          '        coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
          '        and coalesce(v.status,''P'') in (''P'',''F'')                                                              ' + #13 +
          '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '                                                                                                                               ' + #13 +
          '    union all                                                                                                                  ' + #13 +
          '                                                                                                                               ' + #13 +
          '    select                                                                                                                     ' + #13 +
          '        distinct                                                                                                               ' + #13 +
          '        d.data DATA_EMISSAO,                                                                                                   ' + #13 +
          '        d.data DATA_FATURADO,                                                                                                  ' + #13 +
          '        (di.valor_unitario*di.quantidade) *-1 VALOR_PRODUTO,                                                                   ' + #13 +
          '        ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.desconto as float),0) *-1 DESCONTO,           ' + #13 +
          '        ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.valor_acrescimo as float),0) *-1 ACRESCIMO,   ' + #13 +
          '        0 FRETE,                                                                                                               ' + #13 +
          '        0 IPI,                                                                                                                 ' + #13 +
          '        0 ST,                                                                                                                  ' + #13 +
          '        (di.quantidade*di.custo)*-1 CUSTO,                                                                                                               ' + #13 +
          '        di.item ITEM                                                                                                           ' + #13 +
          '    from                                                                                                                       ' + #13 +
          '         devolucao d                                                                                                           ' + #13 +
          '           left join funcionario f     on f.codigo_fun  = d.vendedor                                                           ' + #13 +
          '           left join devolucaoitens di on di.id         = d.id                                                                 ' + #13 +
          '           left join pedidovenda v     on v.numero_ped  = d.pedido                                                             ' + #13 +
          '           left join pedidoitens vi    on vi.numero_ped = v.numero_ped and vi.codigo_pro = di.produto                          ' + #13 +
          '    where                                                                                                                      ' + #13 +
          '        coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
          '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '                                                                                                                               ' + #13 +
          '    union all                                                                                                                  ' + #13 +
          '                                                                                                                               ' + #13 +
          '    select                                                                                                                     ' + #13 +
          '        e.datamovi_ent DATA_EMISSAO,                                                                                           ' + #13 +
          '        e.datamovi_ent DATA_FATURADO,                                                                                          ' + #13 +
          '        coalesce(e.TOTAL_ENT,0)*-1 VALOR_LIQUIDO,                                                                              ' + #13 +
          '        0 DESCONTO,                                                                                                            ' + #13 +
          '        0 ACRESCIMO,                                                                                                           ' + #13 +
          '        0 FRETE,                                                                                                               ' + #13 +
          '        0 IPI,                                                                                                                 ' + #13 +
          '        0 ST,                                                                                                                  ' + #13 +
          '        0 CUSTO,                                                                                                               ' + #13 +
          '        '' '' ITEM                                                                                                         ' + #13 +
          '    from                                                                                                                       ' + #13 +
          '         entrada e                                                                                                             ' + #13 +
          '           inner join pedidovenda v on e.devolucao_pedido_id = v.numero_ped                                                    ' + #13 +
          '    where                                                                                                                      ' + #13 +
          '        coalesce(e.TOTAL_ENT,0) > 0                                                                                            ' + #13 +
          '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '    																														                                                              	' + #13 +
          '    union all                                                                                                                  ' + #13 +
          '                                                                                                                               ' + #13 +
          '    select                                                                                                                     ' + #13 +
          '        v.fechamento_os DATA_EMISSAO,                                                                                          ' + #13 +
          '        v.fechamento_os DATA_FATURADO,                                                                                         ' + #13 +
          '        (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                   ' + #13 +
          '        ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,       ' + #13 +
          '        ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO, ' + #13 +
          '        0 FRETE,                                                                                                               ' + #13 +
          '        0 IPI,                                                                                                                 ' + #13 +
          '        0 ST,                                                                                                                  ' + #13 +
          '        coalesce(i.quantidade_pro,0) * coalesce(i.custo_pro,0) CUSTO,                                                          ' + #13 +
          '        '' '' ITEM                                                                                                         ' + #13 +
          '    from                                                                                                                       ' + #13 +
          '         os v                                                                                                                  ' + #13 +
          '           inner join ositens i  on v.numero_os  = i.numero_os                                                                 ' + #13 +
          '           left  join produto pr on i.codigo_pro = pr.codigo_pro                                                               ' + #13 +
          '    where                                                                                                                      ' + #13 +
          '        coalesce(v.status_os,''F'') = ''F''                                                                            ' + #13 +
          '        and coalesce(v.total_os, 0) > 0                                                                                        ' + #13 +
          '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and i.vendedor_id in (' + pDashbord_Parametros.Vendedores + ') ','') + #13 +
          '                                                                                                                               ' + #13 +
          ') resultado                                                                                                                    ' + #13 +
          '                                                                                                                               ' + #13 +
          'where                                                                                                                          ' + #13 +
          '      resultado.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio)) + ' and '+ QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + #13 +
          '                                                                                                                               ' + #13 +
          'group by 1                                                                                                                     ' + #13 +
          'order by 1                                                                                                                     ' + #13;

  gravaSQL(lSQL, 'DashbordDao_ObterQuery3_VendaPorAno_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  MemTable.FieldDefs.Add('MES', ftInteger);
  MemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
  MemTable.CreateDataSet;
  Options := [loCaseInsensitive];

  for I := 1 to 12 do
  begin
    MemTable.InsertRecord([ I, 0 ]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterQuery3_VendaPorAno';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery3_VendaPorAno: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery3_VendaPorAno: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.First;
    while not lQA.dataset.dataset.Eof do
    begin
      lTotalValores := lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;

      if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ST').AsFloat;
      if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
      if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
      if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;

      if not MemTable.Locate('MES', lQA.dataset.dataset.FieldByName('MES').AsInteger, Options) then
      begin
        MemTable.InsertRecord([
                                lQA.dataset.dataset.FieldByName('MES').AsInteger,
                                lTotalValores
                                ]);
      end else
      begin
        MemTable.Edit;
        MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
        MemTable.Post;
      end;
      lQA.dataset.dataset.Next;
    end;
  end;

  MemTable.IndexFieldNames := 'MES';
  MemTable.Open;

end;

function TDashbordDao.ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  MemTable: TFDMemTable;
  Options: TLocateOptions;
  lTotalValores: Real;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;

begin
  lAsyncList := getQueryLojaAsyncList(vIConexao,pDashbord_Parametros.Lojas);

  MemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(MemTable);
  lSQL := 'select                                                                                                                                                     ' + #13 +
          '    DESCRICAO,                                                                                                                                             ' + #13 +
          '    VALOR_LIQUIDO,                                                                                                                                         ' + #13 +
          '    DESCONTO,                                                                                                                                              ' + #13 +
          '    ACRESCIMO,                                                                                                                                             ' + #13 +
          '    FRETE,                                                                                                                                                 ' + #13 +
          '    IPI,                                                                                                                                                   ' + #13 +
          '    ST,                                                                                                                                                    ' + #13 +
          '    CUSTO                                                                                                                                                  ' + #13 +
          'from                                                                                                                                                       ' + #13 +
          '(                                                                                                                                                          ' + #13 +
          '    select                                                                                                                                                 ' + #13 +
          '        DESCRICAO,                                                                                                                                         ' + #13 +
          '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                                         ' + #13 +
          '        sum(desconto) DESCONTO,                                                                                                                            ' + #13 +
          '        sum(acrescimo) ACRESCIMO,                                                                                                                          ' + #13 +
          '        sum(frete) FRETE,                                                                                                                                  ' + #13 +
          '        sum(ipi) IPI,                                                                                                                                      ' + #13 +
          '        sum(st) ST,                                                                                                                                        ' + #13 +
          '        sum(custo) CUSTO                                                                                                                                   ' + #13 +
          '    from                                                                                                                                                   ' + #13 +
          '    (                                                                                                                                                      ' + #13 +
          '        select                                                                                                                                             ' + #13 +
          '            lpad(extract(hour from v.hora_ped),2,''0'' )||'':00''||'' - ''||lpad(extract(hour from v.hora_ped )+1,2,''0'' )||'':00'' DESCRICAO,            ' + #13 +
          '            v.data_ped DATA_EMISSAO,                                                                                                                       ' + #13 +
          '            v.data_faturado DATA_FATURADO,                                                                                                                 ' + #13 +
          '    		     (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                                        ' + #13 +
          '    	       (i.valorunitario_ped*(cast(i.desconto_ped as float)/100))*i.qtde_calculada DESCONTO,                                         ' + #13 +
          '    		     ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,                                       ' + #13 +
          '    		     ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                                           ' + #13 +
          '    		     i.valor_ipi IPI,                                                                                                                               ' + #13 +
          '    		     i.valor_st ST,                                                                                                                                 ' + #13 +
          '    		     coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO                                                                                ' + #13 +
          '        from                                                                                                                                               ' + #13 +
          '             pedidovenda v                                                                                                                                 ' + #13 +
          '               inner join pedidoitens i on v.numero_ped = i.numero_ped                                                                                     ' + #13 +
          '        where                                                                                                                                              ' + #13 +
          '            coalesce(v.valor_ped,0) > 0                                                                                                                    ' + #13 +
          '            and coalesce(v.status,''P'') in (''P'',''F'')                                                                                                  ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '')                         + #13 +
          '                                                                                                                                                           ' + #13 +
          '        union all                                                                                                                                          ' + #13 +
          '                                                                                                                                                           ' + #13 +
          '        select                                                                                                                                             ' + #13 +
          '            lpad(extract(hour from v.datahora_fim),2,''0'' )||'':00''||'' - ''||lpad(extract(hour from v.datahora_fim )+1,2,''0'' )||'':00'' as descricao, ' + #13 +
          '            v.fechamento_os DATA_EMISSAO,                                                                                                                  ' + #13 +
          '            v.fechamento_os DATA_FATURADO,                                                                                                                 ' + #13 +
          '    		     (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                                           ' + #13 +
          '    		     ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,                               ' + #13 +
          '    		     ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO,                         ' + #13 +
          '    		     0 FRETE,                                                                                                                                       ' + #13 +
          '    		     0 IPI,                                                                                                                                         ' + #13 +
          '    		     0 ST,                                                                                                                                          ' + #13 +
          '    		     coalesce(i.quantidade_pro,0) * coalesce(i.custo_pro,0) CUSTO                                                                                   ' + #13 +
          '        from                                                                                                                                               ' + #13 +
          '             os v                                                                                                                                          ' + #13 +
          '               inner join ositens i on v.numero_os = i.numero_os                                                                                           ' + #13 +
          '        where                                                                                                                                              ' + #13 +
          '            coalesce(v.status_os,''F'') = ''F''                                                                                                            ' + #13 +
          '            and coalesce(v.total_os, 0) > 0                                                                                                                ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and i.vendedor_id in (' + pDashbord_Parametros.Vendedores + ') ', '')                        + #13 +
          '    ) horas                                                                                                                                                ' + #13 +
          '                                                                                                                                                           ' + #13 +
          '    where                                                                                                                                                  ' + #13 +
          '        horas.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + #13 +
          '                                                                                                                                                           ' + #13 +
          '    group by 1                                                                                                                                             ' + #13 +
          '    order by 1                                                                                                                                             ' + #13 +
          ')                                                                                                                                                          ';

  gravaSQL(lSQL, 'DashbordDao_ObterQuery4_VendaPorHora_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  MemTable.FieldDefs.Add('DESCRICAO',ftString,100);
  MemTable.FieldDefs.Add('VALOR_LIQUIDO',ftFloat);
  MemTable.FieldDefs.Add('DESCONTO',ftFloat);
  MemTable.FieldDefs.Add('ACRESCIMO',ftFloat);
  MemTable.FieldDefs.Add('FRETE',ftFloat);
  MemTable.FieldDefs.Add('IPI',ftFloat);
  MemTable.FieldDefs.Add('ST',ftFloat);
  MemTable.FieldDefs.Add('CUSTO',ftFloat);

  MemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterQuery4_VendaPorHora';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery4_VendaPorHora: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery4_VendaPorHora: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.First;
    while not lQA.dataset.dataset.Eof do
    begin
      lTotalValores := lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;

      if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ST').AsFloat;
      if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
      if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
      if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;

      if not MemTable.Locate('DESCRICAO', lQA.dataset.dataset.FieldByName('DESCRICAO').AsString) then
      begin
        MemTable.InsertRecord([
                                lQA.dataset.dataset.FieldByName('DESCRICAO').AsString,
                                lTotalValores,
                                lQA.dataset.dataset.FieldByName('DESCONTO').AsFloat,
                                lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat,
                                lQA.dataset.dataset.FieldByName('FRETE').AsFloat,
                                lQA.dataset.dataset.FieldByName('IPI').AsFloat,
                                lQA.dataset.dataset.FieldByName('ST').AsFloat,
                                lQA.dataset.dataset.FieldByName('CUSTO').AsFloat
                                ]);
      end else
      begin
        MemTable.Edit;
        MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
        MemTable.FieldByName('DESCONTO').Value      := MemTable.FieldByName('DESCONTO').Value + lQA.dataset.dataset.FieldByName('DESCONTO').AsFloat;
        MemTable.FieldByName('ACRESCIMO').Value     := MemTable.FieldByName('ACRESCIMO').Value + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
        MemTable.FieldByName('FRETE').Value         := MemTable.FieldByName('FRETE').Value + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;
        MemTable.FieldByName('IPI').Value           := MemTable.FieldByName('IPI').Value + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
        MemTable.FieldByName('ST').Value            := MemTable.FieldByName('ST').Value + lQA.dataset.dataset.FieldByName('ST').AsFloat;
        MemTable.FieldByName('CUSTO').Value         := MemTable.FieldByName('CUSTO').Value + lQA.dataset.dataset.FieldByName('CUSTO').AsFloat;
        MemTable.Post;
      end;
      lQA.dataset.dataset.Next;
    end;

  end;

  MemTable.IndexFieldNames := 'DESCRICAO';
  MemTable.Open;

end;

//function TDashbordDao.ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
//var
//  lSQL:String;
//  MemTable: TFDMemTable;
//  Options: TLocateOptions;
//  lTotalValores: Real;
//
//  lAsyncList  : IListaQueryAsync;
//  lQA         : IQueryLojaAsync;
//  conexao     : IConexao;
//
//begin
//  lAsyncList := getQueryLojaAsyncList(vIConexao,pDashbord_Parametros.Lojas);
//
//  MemTable := TFDMemTable.Create(nil);
//  Result := criaIFDDataset(MemTable);
//  lSQL := 'select                                                                                                                             ' + #13 +
//          '    CODIGO_VEN,                                                                                                                    ' + #13 +
//          '    VENDEDOR,                                                                                                                      ' + #13 +
//          '    VALOR_LIQUIDO,                                                                                                                 ' + #13 +
//          '    VALOR_PRODUTO,                                                                                                                 ' + #13 +
//          '    DESCONTO,                                                                                                                      ' + #13 +
//          '    ACRESCIMO,                                                                                                                     ' + #13 +
//          '    FRETE,                                                                                                                         ' + #13 +
//          '    IPI,                                                                                                                           ' + #13 +
//          '    ST,                                                                                                                            ' + #13 +
//          '    CUSTO,                                                                                                                         ' + #13 +
//          '    TOTAL_ITENS,                                                                                                                   ' + #13 +
//          '    QUANTIDADE_VENDA,                                                                                                              ' + #13 +
//          '    CLIENTE                                                                                                                        ' + #13 +
//          'from                                                                                                                               ' + #13 +
//          '(                                                                                                                                  ' + #13 +
//          '    select                                                                                                                         ' + #13 +
//          '        CODIGO_VEN,                                                                                                                ' + #13 +
//          '        VENDEDOR,                                                                                                                  ' + #13 +
//          '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                 ' + #13 +
//          '        sum(valor_produto) VALOR_PRODUTO,                                                                                          ' + #13 +
//          '        sum(desconto) DESCONTO,                                                                                                    ' + #13 +
//          '        sum(acrescimo) ACRESCIMO,                                                                                                  ' + #13 +
//          '        sum(frete) FRETE,                                                                                                          ' + #13 +
//          '        sum(ipi) IPI,                                                                                                              ' + #13 +
//          '        sum(st) ST,                                                                                                                ' + #13 +
//          '        sum(custo) CUSTO,                                                                                                          ' + #13 +
//          '        sum(total_itens) TOTAL_ITENS,                                                                                              ' + #13 +
//          '        count(distinct(quantidade_venda)) QUANTIDADE_VENDA,                                                                        ' + #13 +
//          '        count(distinct(cliente))-1 CLIENTE                                                                                         ' + #13 +
//          '    from                                                                                                                           ' + #13 +
//          '    (                                                                                                                              ' + #13 +
//          '       select                                                                                                                      ' + #13 +
//          '            v.data_ped DATA_EMISSAO,                                                                                               ' + #13 +
//          '            v.data_faturado DATA_FATURADO,                                                                                         ' + #13 +
//          '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
//          '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
//          '            (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
//          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                 ' + #13 +
//          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
//          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
//          '            i.valor_ipi IPI,                                                                                                       ' + #13 +
//          '            i.valor_st ST,                                                                                                         ' + #13 +
//          '            coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
//          '            coalesce(i.qtde_calculada, 0) TOTAL_ITENS,                                                                             ' + #13 +
//          '            v.numero_ped || ''P'' QUANTIDADE_VENDA,                                                                                ' + #13 +
//          '            v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
//          '            '' '' ITEM                                                                                                             ' + #13 +
//          '        from                                                                                                                       ' + #13 +
//          '             pedidovenda v                                                                                                         ' + #13 +
//          '			          inner join pedidoitens i on v.numero_ped = i.numero_ped                                                             ' + #13 +
//          '               left  join funcionario f on f.codigo_fun = v.codigo_ven                                                             ' + #13 +
//          '        where                                                                                                                      ' + #13 +
//          '            coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
//          '            and coalesce(v.status, ''P'') in (''P'', ''F'')                                                                        ' + #13 +
//          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
//          '                                                                                                                                   ' + #13 +
//          '        union all                                                                                                                  ' + #13 +
//          '                                                                                                                                   ' + #13 +
//          '        select                                                                                                                     ' + #13 +
//          '            distinct                                                                                                               ' + #13 +
//          '            d.data DATA_EMISSAO,                                                                                                   ' + #13 +
//          '            d.data DATA_FATURADO,                                                                                                  ' + #13 +
//          '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
//          '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
//          '            (di.valor_unitario*di.quantidade) *-1 VALOR_PRODUTO,                                                                   ' + #13 +
//          '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.desconto as float),0) *-1 DESCONTO,           ' + #13 +
//          '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.valor_acrescimo as float),0) *-1 ACRESCIMO,   ' + #13 +
//          '            0 FRETE,                                                                                                               ' + #13 +
//          '            0 IPI,                                                                                                                 ' + #13 +
//          '            0 ST,                                                                                                                  ' + #13 +
//          '            0 CUSTO,                                                                                                               ' + #13 +
//          '            di.quantidade * -1 TOTAL_ITENS,                                                                                        ' + #13 +
//          '            null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
//          '            null CLIENTE,                                                                                                          ' + #13 +
//          '            di.item ITEM                                                                                                           ' + #13 +
//          '        from                                                                                                                       ' + #13 +
//          '             devolucao d                                                                                                           ' + #13 +
//          '               left join funcionario f     on f.codigo_fun  = d.vendedor                                                           ' + #13 +
//          '               left join devolucaoitens di on di.id         = d.id                                                                 ' + #13 +
//          '               left join pedidovenda v     on v.numero_ped  = d.pedido                                                             ' + #13 +
//          '               left join pedidoitens vi    on vi.numero_ped = v.numero_ped and                                                     ' + #13 +
//          '			                                         vi.codigo_pro = di.produto                                                           ' + #13 +
//          '        where                                                                                                                      ' + #13 +
//          '            coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
//          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
//          '                                                                                                                                   ' + #13 +
//          '        union all                                                                                                                  ' + #13 +
//          '                                                                                                                                   ' + #13 +
//          '        select                                                                                                                     ' + #13 +
//          '            e.datamovi_ent DATA_EMISSAO,                                                                                           ' + #13 +
//          '            e.datamovi_ent DATA_FATURADO,                                                                                          ' + #13 +
//          '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
//          '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
//          '            coalesce(e.TOTAL_ENT,0)*-1 VALOR_PRODUTO,                                                                              ' + #13 +
//          '            0 DESCONTO,                                                                                                            ' + #13 +
//          '            0 ACRESCIMO,                                                                                                           ' + #13 +
//          '            0 FRETE,                                                                                                               ' + #13 +
//          '            0 IPI,                                                                                                                 ' + #13 +
//          '            0 ST,                                                                                                                  ' + #13 +
//          '            0 CUSTO,                                                                                                               ' + #13 +
//          '            0 TOTAL_ITENS,                                                                                                         ' + #13 +
//          '            null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
//          '            null CLIENTE,                                                                                                          ' + #13 +
//          '            '' '' ITEM                                                                                                             ' + #13 +
//          '        from                                                                                                                       ' + #13 +
//          '             entrada e                                                                                                             ' + #13 +
//          '               inner join pedidovenda v on e.devolucao_pedido_id = v.numero_ped                                                    ' + #13 +
//          '               left  join funcionario f on f.codigo_fun          = v.codigo_ven                                                    ' + #13 +
//          '        where                                                                                                                      ' + #13 +
//          '            coalesce(e.TOTAL_ENT,0) > 0                                                                                            ' + #13 +
//          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
//          '                                                                                                                                   ' + #13 +
//          '        union all                                                                                                                  ' + #13 +
//          '                                                                                                                                   ' + #13 +
//          '        select                                                                                                                     ' + #13 +
//          '            v.fechamento_os DATA_EMISSAO,                                                                                          ' + #13 +
//          '            v.fechamento_os DATA_FATURADO,                                                                                         ' + #13 +
//          '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
//          '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
//          '            (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                   ' + #13 +
//          '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,       ' + #13 +
//          '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO, ' + #13 +
//          '            0 FRETE,                                                                                                               ' + #13 +
//          '            0 IPI,                                                                                                                 ' + #13 +
//          '            0 ST,                                                                                                                  ' + #13 +
//          '            coalesce(i.quantidade_pro,0) * coalesce(i.custo_pro,0) CUSTO,                                                          ' + #13 +
//          '            coalesce(i.quantidade_pro,0) TOTAL_ITENS,                                                                              ' + #13 +
//          '            v.numero_os || ''O'' QUANTIDADE_VENDA,                                                                                 ' + #13 +
//          '            v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
//          '            '' '' ITEM                                                                                                             ' + #13 +
//          '        from                                                                                                                       ' + #13 +
//          '             os v                                                                                                                  ' + #13 +
//          '               inner join ositens i     on v.numero_os  = i.numero_os                                                              ' + #13 +
//          '               inner join funcionario f on f.codigo_fun = i.vendedor_id                                                            ' + #13 +
//          '        where                                                                                                                      ' + #13 +
//          '            coalesce(v.status_os, ''F'') = ''F''                                                                                   ' + #13 +
//          '            and coalesce(v.total_os, 0) > 0                                                                                        ' + #13 +
//          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
//          '    ) resultado                                                                                                                    ' + #13 +
//          '                                                                                                                                   ' + #13 +
//          '    where                                                                                                                          ' + #13 +
//          '        resultado.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + #13 +
//          '                                                                                                                                   ' + #13 +
//          '    group by 1, 2                                                                                                                     ' + #13 +
//          '    order by 2 desc                                                                                                                ' + #13 +
//          ')                                                                                                                                  ';
//
//  gravaSQL(lSQL, 'DashbordDao_ObterQuery6_RankingVendedores_' + FormatDateTime('yyyymmddhhnnsszzz', now));
//
//  MemTable.FieldDefs.Add('CODIGO_VEN',    ftString,  10);
//  MemTable.FieldDefs.Add('VENDEDOR',      ftString, 100);
//  MemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
//  MemTable.FieldDefs.Add('CUSTO',         ftFloat);
//  MemTable.FieldDefs.Add('CLIENTE',       ftInteger);
//  MemTable.FieldDefs.Add('DOCUMENTO',     ftInteger);
//  MemTable.FieldDefs.Add('ITENS',         ftInteger);
//  MemTable.FieldDefs.Add('DESCONTO',      ftFloat);
//  MemTable.FieldDefs.Add('ACRESCIMO',     ftFloat);
//  MemTable.FieldDefs.Add('FRETE',         ftFloat);
//  MemTable.FieldDefs.Add('IPI',           ftFloat);
//  MemTable.FieldDefs.Add('ST',            ftFloat);
//  MemTable.CreateDataSet;
//
//  for lQA in lAsyncList do
//  begin
//    lQA.tag := 'ObterQuery6_RankingVendedores';
//    conexao := lQA.loja.objeto.conexaoLoja;
//    if(conexao=nil) then
//      raise Exception.CreateFmt('TDashbordDao.ObterQuery6_RankingVendedores: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);
//
//    lQA.execQuery(lSQL,'',[]);
//  end;
//
//  for lQA in lAsyncList do
//  begin
//    lQA.espera;
//    if(lQA.resultado.erros>0) then
//      raise Exception.CreateFmt('TDashbordDao.ObterQuery6_RankingVendedores: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);
//
//    lQA.dataset.dataset.First;
//    while not lQA.dataset.dataset.Eof do
//    begin
//      lTotalValores := lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;
//
//      if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ST').AsFloat;
//      if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
//      if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
//      if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;
//
//      if not MemTable.Locate('VENDEDOR', trim(lQA.dataset.dataset.FieldByName('VENDEDOR').AsString)) then
//      begin
//        MemTable.InsertRecord([
//                                lQA.dataset.dataset.FieldByName('CODIGO_VEN').AsString,
//                                trim(lQA.dataset.dataset.FieldByName('VENDEDOR').AsString),
//                                lTotalValores,
//                                lQA.dataset.dataset.FieldByName('CUSTO').AsFloat,
//                                lQA.dataset.dataset.FieldByName('CLIENTE').AsInteger,
//                                lQA.dataset.dataset.FieldByName('DESCONTO').AsFloat,
//                                lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat,
//                                lQA.dataset.dataset.FieldByName('FRETE').AsFloat,
//                                lQA.dataset.dataset.FieldByName('IPI').AsFloat,
//                                lQA.dataset.dataset.FieldByName('ST').AsFloat
//                                ]);
//      end else
//      begin
//        MemTable.Edit;
//        MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
//        MemTable.FieldByName('CUSTO').Value         := MemTable.FieldByName('CUSTO').Value + lQA.dataset.dataset.FieldByName('CUSTO').AsFloat;
//        MemTable.FieldByName('CLIENTE').Value       := MemTable.FieldByName('CLIENTE').Value + lQA.dataset.dataset.FieldByName('CLIENTE').AsInteger;
//        MemTable.FieldByName('DESCONTO').Value      := MemTable.FieldByName('DESCONTO').Value + lQA.dataset.dataset.FieldByName('DESCONTO').AsFloat;
//        MemTable.FieldByName('ACRESCIMO').Value     := MemTable.FieldByName('ACRESCIMO').Value + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
//        MemTable.FieldByName('FRETE').Value         := MemTable.FieldByName('FRETE').Value + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;
//        MemTable.FieldByName('IPI').Value           := MemTable.FieldByName('IPI').Value + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
//        MemTable.FieldByName('ST').Value            := MemTable.FieldByName('ST').Value + lQA.dataset.dataset.FieldByName('ST').AsFloat;
//        MemTable.Post;
//      end;
//      lQA.dataset.dataset.Next;
//    end;
//  end;
//
//  MemTable.IndexFieldNames := 'VENDEDOR';
//  MemTable.Open;
//
//end;
//




function TDashbordDao.ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lSQL, lTipoAnalise, lTipoAnaliseEntrada:String;
  MemTable: TFDMemTable;
  Options: TLocateOptions;
  lTotalValores: Real;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;

begin
  lAsyncList := getQueryLojaAsyncList(vIConexao,pDashbord_Parametros.Lojas);

  MemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(MemTable);

//    lTipoAnalise        := ' gc.id CODIGO_VEN, gc.nome VENDEDOR, ';
//    lTipoAnaliseEntrada :=  QuotedStr('000000')+' CODIGO_VEN, '+QuotedStr('DEV ENTRADA')+' VENDEDOR, ';

  if pDashbord_Parametros.TipoAnalise = 'VENDEDOR' then
  begin
    lTipoAnalise        := ' f.codigo_fun CODIGO_VEN,  f.nome_fun VENDEDOR, ';
    lTipoAnaliseEntrada := ' f.codigo_fun CODIGO_VEN,  f.nome_fun VENDEDOR, ';
  end else
  if pDashbord_Parametros.TipoAnalise = 'FORNECEDOR' then
  begin
    lTipoAnalise        := '  fo.codigo_for CODIGO_VEN, fo.fantasia_for VENDEDOR, ';
    lTipoAnaliseEntrada :=  QuotedStr('000000')+' CODIGO_VEN, '+QuotedStr('DEV ENTRADA')+' VENDEDOR, ';
  end else
  if pDashbord_Parametros.TipoAnalise = 'GRUPOPRODUTO' then
  begin
    lTipoAnalise        := '  g.codigo_gru CODIGO_VEN, g.nome_gru VENDEDOR, ';
    lTipoAnaliseEntrada :=  QuotedStr('000000')+' CODIGO_VEN, '+QuotedStr('DEV ENTRADA')+' VENDEDOR, ';
  end else
  if pDashbord_Parametros.TipoAnalise = 'SUBGRUPOPRODUTO' then
  begin
    lTipoAnalise        := '  s.codigo_sub CODIGO_VEN, s.nome_sub VENDEDOR, ';
    lTipoAnaliseEntrada :=  QuotedStr('000000')+' CODIGO_VEN, '+QuotedStr('DEV ENTRADA')+' VENDEDOR, ';
  end else
  if pDashbord_Parametros.TipoAnalise = 'MARCAPRODUTO' then
  begin
    lTipoAnalise        := '  m.codigo_mar CODIGO_VEN, m.nome_mar VENDEDOR, ';
    lTipoAnaliseEntrada :=  QuotedStr('000000')+' CODIGO_VEN, '+QuotedStr('DEV ENTRADA')+' VENDEDOR, ';
  end else
  if pDashbord_Parametros.TipoAnalise = 'PRODUTO_TIPO' then
  begin
    lTipoAnalise        := ' coalesce(pt.id, 999999) CODIGO_VEN, coalesce(pt.nome, ''NAO INFORMADO'') VENDEDOR, ';
    lTipoAnaliseEntrada :=  QuotedStr('000000')+' CODIGO_VEN, '+QuotedStr('DEV ENTRADA')+' VENDEDOR, ';
  end else
  if pDashbord_Parametros.TipoAnalise = 'GRUPO_COMISSAO' then
  begin
    lTipoAnalise        := ' gc.id CODIGO_VEN, gc.nome VENDEDOR, ';
    lTipoAnaliseEntrada :=  QuotedStr('000000')+' CODIGO_VEN, '+QuotedStr('DEV ENTRADA')+' VENDEDOR, ';
  end;

  lSQL := 'select                                                                                                                             ' + #13 +
          '    CODIGO_VEN,                                                                                                                    ' + #13 +
          '    VENDEDOR,                                                                                                                      ' + #13 +
          '    VALOR_LIQUIDO,                                                                                                                 ' + #13 +
          '    VALOR_PRODUTO,                                                                                                                 ' + #13 +
          '    DESCONTO,                                                                                                                      ' + #13 +
          '    ACRESCIMO,                                                                                                                     ' + #13 +
          '    FRETE,                                                                                                                         ' + #13 +
          '    IPI,                                                                                                                           ' + #13 +
          '    ST,                                                                                                                            ' + #13 +
          '    CUSTO,                                                                                                                         ' + #13 +
          '    TOTAL_ITENS,                                                                                                                   ' + #13 +
          '    QUANTIDADE_VENDA,                                                                                                              ' + #13 +
          '    CLIENTE                                                                                                                        ' + #13 +
          'from                                                                                                                               ' + #13 +
          '(                                                                                                                                  ' + #13 +
          '    select                                                                                                                         ' + #13 +
          '        CODIGO_VEN,                                                                                                                ' + #13 +
          '        VENDEDOR,                                                                                                                  ' + #13 +
          '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                 ' + #13 +
          '        sum(valor_produto) VALOR_PRODUTO,                                                                                          ' + #13 +
          '        sum(desconto) DESCONTO,                                                                                                    ' + #13 +
          '        sum(acrescimo) ACRESCIMO,                                                                                                  ' + #13 +
          '        sum(frete) FRETE,                                                                                                          ' + #13 +
          '        sum(ipi) IPI,                                                                                                              ' + #13 +
          '        sum(st) ST,                                                                                                                ' + #13 +
          '        sum(custo) CUSTO,                                                                                                          ' + #13 +
          '        sum(total_itens) TOTAL_ITENS,                                                                                              ' + #13 +
          '        count(distinct(quantidade_venda)) QUANTIDADE_VENDA,                                                                        ' + #13 +
          '        count(distinct(cliente))-1 CLIENTE                                                                                         ' + #13 +
          '    from                                                                                                                           ' + #13 +
          '    (                                                                                                                              ' + #13 +
          '       select                                                                                                                      ' + #13 +
          '            v.data_ped DATA_EMISSAO,                                                                                               ' + #13 +
          '            v.data_faturado DATA_FATURADO,                                                                                         ' + #13 +
//          '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
//          '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
          lTipoAnalise +



          '            (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
          '            (i.valorunitario_ped*(cast(i.desconto_ped as float)/100))*i.qtde_calculada DESCONTO,                 ' + #13 +
          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
          '            i.valor_ipi IPI,                                                                                                       ' + #13 +
          '            i.valor_st ST,                                                                                                         ' + #13 +
          '            coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
          '            coalesce(i.qtde_calculada, 0) TOTAL_ITENS,                                                                             ' + #13 +
          '            v.numero_ped || ''P'' QUANTIDADE_VENDA,                                                                                ' + #13 +
          '            v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
          '            '' '' ITEM                                                                                                             ' + #13 +
          '        from                                                                                                                       ' + #13 +
          '             pedidovenda v                                                                                                         ' + #13 +
          '            inner join pedidoitens i     on v.numero_ped = i.numero_ped                                                            ' + #13 +
          '            left  join funcionario f     on f.codigo_fun = v.codigo_ven                                                            ' + #13 +
          '            left  join produto p         on p.codigo_pro = i.codigo_pro                                                            ' + #13 +
          '            left  join grupoproduto g    on g.codigo_gru = p.codigo_gru                                                            ' + #13 +
          '            left  join subgrupoproduto s on s.codigo_sub = p.codigo_sub                                                            ' + #13 +
          '            left  join marcaproduto m    on m.codigo_mar = p.codigo_mar                                                            ' + #13 +
          '            left  join produto_tipo pt   on pt.id = p.tipo_id                                                                      ' + #13 +
          '            left  join grupo_comissao gc on gc.id = p.grupo_comissao_id                                                            ' + #13 +
          '            left  join fornecedor fo     on fo.codigo_for = p.codigo_for                                                           ' + #13 +

          '        where                                                                                                                      ' + #13 +
          '            coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
          '            and coalesce(v.status, ''P'') in (''P'', ''F'')                                                                        ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '                                                                                                                                   ' + #13 +
          '        union all                                                                                                                  ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        select                                                                                                                     ' + #13 +
          '            distinct                                                                                                               ' + #13 +
          '            d.data DATA_EMISSAO,                                                                                                   ' + #13 +
          '            d.data DATA_FATURADO,                                                                                                  ' + #13 +
//          '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
//          '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
          lTipoAnalise +
          '            (di.valor_unitario*di.quantidade) *-1 VALOR_PRODUTO,                                                                   ' + #13 +
          '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.desconto as float),0) *-1 DESCONTO,           ' + #13 +
          '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.valor_acrescimo as float),0) *-1 ACRESCIMO,   ' + #13 +
          '            0 FRETE,                                                                                                               ' + #13 +
          '            0 IPI,                                                                                                                 ' + #13 +
          '            0 ST,                                                                                                                  ' + #13 +
          '            (di.quantidade*di.custo)*-1 CUSTO,                                                                                                               ' + #13 +
          '            di.quantidade * -1 TOTAL_ITENS,                                                                                        ' + #13 +
          '            null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
          '            null CLIENTE,                                                                                                          ' + #13 +
          '            di.item ITEM                                                                                                           ' + #13 +
          '        from                                                                                                                       ' + #13 +
          '             devolucao d                                                                                                           ' + #13 +
          '               left join funcionario f      on f.codigo_fun  = d.vendedor                                                          ' + #13 +
          '               left join devolucaoitens di  on di.id         = d.id                                                                ' + #13 +
          '               left join pedidovenda v      on v.numero_ped  = d.pedido                                                            ' + #13 +
          '               left join pedidoitens vi     on vi.numero_ped = v.numero_ped and vi.codigo_pro = di.produto                         ' + #13 +
          '               left  join produto p         on p.codigo_pro = di.produto                                                           ' + #13 +
          '               left  join grupoproduto g    on g.codigo_gru = p.codigo_gru                                                         ' + #13 +
          '               left  join subgrupoproduto s on s.codigo_sub = p.codigo_sub                                                         ' + #13 +
          '               left  join marcaproduto m    on m.codigo_mar = p.codigo_mar                                                         ' + #13 +
          '               left  join produto_tipo pt   on pt.id = p.tipo_id                                                                   ' + #13 +
          '               left  join grupo_comissao gc on gc.id = p.grupo_comissao_id                                                         ' + #13 +
          '               left  join fornecedor fo     on fo.codigo_for = p.codigo_for                                                        ' + #13 +


 		      '                                                                                                                                   ' + #13 +
          '        where                                                                                                                      ' + #13 +
          '            coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '                                                                                                                                   ' + #13 +
          '        union all                                                                                                                  ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        select                                                                                                                     ' + #13 +
          '            e.datamovi_ent DATA_EMISSAO,                                                                                           ' + #13 +
          '            e.datamovi_ent DATA_FATURADO,                                                                                          ' + #13 +
//          '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
//          '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
          lTipoAnaliseEntrada +
          '            coalesce(e.TOTAL_ENT,0)*-1 VALOR_PRODUTO,                                                                              ' + #13 +
          '            0 DESCONTO,                                                                                                            ' + #13 +
          '            0 ACRESCIMO,                                                                                                           ' + #13 +
          '            0 FRETE,                                                                                                               ' + #13 +
          '            0 IPI,                                                                                                                 ' + #13 +
          '            0 ST,                                                                                                                  ' + #13 +
          '            0 CUSTO,                                                                                                               ' + #13 +
          '            0 TOTAL_ITENS,                                                                                                         ' + #13 +
          '            null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
          '            null CLIENTE,                                                                                                          ' + #13 +
          '            '' '' ITEM                                                                                                             ' + #13 +
          '        from                                                                                                                       ' + #13 +
          '             entrada e                                                                                                             ' + #13 +
          '               inner join pedidovenda v on e.devolucao_pedido_id = v.numero_ped                                                    ' + #13 +
          '               left  join funcionario f on f.codigo_fun          = v.codigo_ven                                                    ' + #13 +
          '        where                                                                                                                      ' + #13 +
          '            coalesce(e.TOTAL_ENT,0) > 0                                                                                            ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '                                                                                                                                   ' + #13 +
          '        union all                                                                                                                  ' + #13 +
          '                                                                                                                                   ' + #13 +
          '        select                                                                                                                     ' + #13 +
          '            v.fechamento_os DATA_EMISSAO,                                                                                          ' + #13 +
          '            v.fechamento_os DATA_FATURADO,                                                                                         ' + #13 +
//          '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
//          '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
          lTipoAnalise +
          '            (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                   ' + #13 +
          '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,       ' + #13 +
          '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO, ' + #13 +
          '            0 FRETE,                                                                                                               ' + #13 +
          '            0 IPI,                                                                                                                 ' + #13 +
          '            0 ST,                                                                                                                  ' + #13 +
          '            coalesce(i.quantidade_pro,0) * coalesce(i.custo_pro,0) CUSTO,                                                          ' + #13 +
          '            coalesce(i.quantidade_pro,0) TOTAL_ITENS,                                                                              ' + #13 +
          '            v.numero_os || ''O'' QUANTIDADE_VENDA,                                                                                 ' + #13 +
          '            v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
          '            '' '' ITEM                                                                                                             ' + #13 +
          '        from                                                                                                                       ' + #13 +
          '             os v                                                                                                                  ' + #13 +
          '               inner join ositens i     on v.numero_os  = i.numero_os                                                              ' + #13 +
          '               inner join funcionario f on f.codigo_fun = i.vendedor_id                                                            ' + #13 +
          '               left  join produto p on p.codigo_pro = i.codigo_pro                                                                 ' + #13 +
          '               left  join grupoproduto g    on g.codigo_gru = p.codigo_gru                                                         ' + #13 +
          '               left  join subgrupoproduto s on s.codigo_sub = p.codigo_sub                                                         ' + #13 +
          '               left  join marcaproduto m    on m.codigo_mar = p.codigo_mar                                                         ' + #13 +
          '               left  join produto_tipo pt   on pt.id = p.tipo_id                                                                   ' + #13 +
          '               left  join grupo_comissao gc on gc.id = p.grupo_comissao_id                                                         ' + #13 +
          '               left  join fornecedor fo     on fo.codigo_for = p.codigo_for                                                        ' + #13 +


          '        where                                                                                                                      ' + #13 +
          '            coalesce(v.status_os, ''F'') = ''F''                                                                                   ' + #13 +
          '            and coalesce(v.total_os, 0) > 0                                                                                        ' + #13 +
          '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
          '    ) resultado                                                                                                                    ' + #13 +
          '                                                                                                                                   ' + #13 +
          '    where                                                                                                                          ' + #13 +
          '        resultado.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + #13 +
          '                                                                                                                                   ' + #13 +
          '    group by 1, 2                                                                                                                     ' + #13 +
          '    order by 2 desc                                                                                                                ' + #13 +
          ')                                                                                                                                  ';

  gravaSQL(lSQL, 'DashbordDao_ObterQuery6_RankingVendedores_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  MemTable.FieldDefs.Add('CODIGO_VEN',    ftString,  10);
  MemTable.FieldDefs.Add('VENDEDOR',      ftString, 100);
  MemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
  MemTable.FieldDefs.Add('CUSTO',         ftFloat);
  MemTable.FieldDefs.Add('CLIENTE',       ftInteger);
  MemTable.FieldDefs.Add('DOCUMENTO',     ftInteger);
  MemTable.FieldDefs.Add('ITENS',         ftInteger);
  MemTable.FieldDefs.Add('DESCONTO',      ftFloat);
  MemTable.FieldDefs.Add('ACRESCIMO',     ftFloat);
  MemTable.FieldDefs.Add('FRETE',         ftFloat);
  MemTable.FieldDefs.Add('IPI',           ftFloat);
  MemTable.FieldDefs.Add('ST',            ftFloat);
  MemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterQuery6_RankingVendedores';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery6_RankingVendedores: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery6_RankingVendedores: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.First;
    while not lQA.dataset.dataset.Eof do
    begin
      lTotalValores := lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;

      if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ST').AsFloat;
      if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
      if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
      if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;

      if not MemTable.Locate('VENDEDOR', trim(lQA.dataset.dataset.FieldByName('VENDEDOR').AsString)) then
      begin
        MemTable.InsertRecord([
                                lQA.dataset.dataset.FieldByName('CODIGO_VEN').AsString,
                                trim(lQA.dataset.dataset.FieldByName('VENDEDOR').AsString),
                                lTotalValores,
                                lQA.dataset.dataset.FieldByName('CUSTO').AsFloat,
                                lQA.dataset.dataset.FieldByName('CLIENTE').AsInteger,
                                lQA.dataset.dataset.FieldByName('DESCONTO').AsFloat,
                                lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat,
                                lQA.dataset.dataset.FieldByName('FRETE').AsFloat,
                                lQA.dataset.dataset.FieldByName('IPI').AsFloat,
                                lQA.dataset.dataset.FieldByName('ST').AsFloat
                                ]);
      end else
      begin
        MemTable.Edit;
        MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
        MemTable.FieldByName('CUSTO').Value         := MemTable.FieldByName('CUSTO').Value + lQA.dataset.dataset.FieldByName('CUSTO').AsFloat;
        MemTable.FieldByName('CLIENTE').Value       := MemTable.FieldByName('CLIENTE').Value + lQA.dataset.dataset.FieldByName('CLIENTE').AsInteger;
        MemTable.FieldByName('DESCONTO').Value      := MemTable.FieldByName('DESCONTO').Value + lQA.dataset.dataset.FieldByName('DESCONTO').AsFloat;
        MemTable.FieldByName('ACRESCIMO').Value     := MemTable.FieldByName('ACRESCIMO').Value + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
        MemTable.FieldByName('FRETE').Value         := MemTable.FieldByName('FRETE').Value + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;
        MemTable.FieldByName('IPI').Value           := MemTable.FieldByName('IPI').Value + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
        MemTable.FieldByName('ST').Value            := MemTable.FieldByName('ST').Value + lQA.dataset.dataset.FieldByName('ST').AsFloat;
        MemTable.Post;
      end;
      lQA.dataset.dataset.Next;
    end;
  end;

  MemTable.IndexFieldNames := 'VENDEDOR';
  MemTable.Open;

end;




function TDashbordDao.ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lSQL:String;
  MemTable: TFDMemTable;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
  lTotalValores: Real;
begin
  lAsyncList := getQueryLojaAsyncList(vIConexao,pDashbord_Parametros.Lojas);
  MemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(MemTable);

  lSQL :=
      ' select                                                                                                                                            ' + #13 +
      '     VALOR_LIQUIDO,                                                                                                                                ' + #13 +
      '     CUSTO,                                                                                                                                        ' + #13 +
      '     TOTAL_ITENS,                                                                                                                                  ' + #13 +
      '         DESCONTO,                                                                                                                                 ' + #13 +
      '         ACRESCIMO,                                                                                                                                ' + #13 +
      '         FRETE,                                                                                                                                    ' + #13 +
      '         IPI,                                                                                                                                      ' + #13 +
      '         ST,                                                                                                                                       ' + #13 +

      '     QUANTIDADE_VENDA,                                                                                                                             ' + #13 +
      '     QUANTIDADE_CLIENTE                                                                                                                            ' + #13 +
      '                                                                                                                                                   ' + #13 +
      ' from                                                                                                                                              ' + #13 +
      ' (                                                                                                                                                 ' + #13 +
      '     select                                                                                                                                        ' + #13 +
      '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                                 ' + #13 +
      '        sum(custo) CUSTO,                                                                                                                          ' + #13 +
      '        sum(total_itens) TOTAL_ITENS,                                                                                                              ' + #13 +
      '        sum(desconto) DESCONTO,                                                                                                                    ' + #13 +
      '        sum(acrescimo) ACRESCIMO,                                                                                                                  ' + #13 +
      '        sum(frete) FRETE,                                                                                                                          ' + #13 +
      '        sum(ipi) IPI,                                                                                                                              ' + #13 +
      '        sum(st) ST,                                                                                                                                ' + #13 +
      '         count(distinct(quantidade_venda)) QUANTIDADE_VENDA,                                                                                       ' + #13 +
      '         count(distinct(QUANTIDADE_CLIENTE))-1 QUANTIDADE_CLIENTE                                                                                  ' + #13 +
      '     from                                                                                                                                          ' + #13 +
      '     (                                                                                                                                             ' + #13 +
      '        select                                                                                                                                     ' + #13 +
      '             v.data_ped DATA_EMISSAO,                                                                                                              ' + #13 +
      '             v.data_faturado DATA_FATURADO,                                                                                                        ' + #13 +
      '             (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                               ' + #13 +
      '             ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(v.desc_ped,0) DESCONTO,                                               ' + #13 +
      '             ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(v.acres_ped,0) ACRESCIMO,                                             ' + #13 +
      '             ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(v.frete_ped,0) FRETE,                                                 ' + #13 +
      '             i.valor_ipi IPI,                                                                                                                      ' + #13 +
      '             i.valor_st ST,                                                                                                                        ' + #13 +
      '             coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                                      ' + #13 +
      '             coalesce(i.qtde_calculada, 0) TOTAL_ITENS,                                                                                            ' + #13 +
      '             v.numero_ped || ''P'' QUANTIDADE_VENDA,                                                                                               ' + #13 +
      '             v.codigo_cli QUANTIDADE_CLIENTE,                                                                                                      ' + #13 +
      '             '' '' ITEM                                                                                                                            ' + #13 +
      '         from                                                                                                                                      ' + #13 +
      '             pedidovenda v                                                                                                                         ' + #13 +
      '                                                                                                                                                   ' + #13 +
      '         inner join pedidoitens i on v.numero_ped = i.numero_ped                                                                                   ' + #13 +
      '                                                                                                                                                   ' + #13 +
      '         where                                                                                                                                     ' + #13 +
      '             coalesce(v.valor_ped,0) > 0                                                                                                           ' + #13 +
      '             and coalesce(v.status,''P'') in (''P'',''F'')                                                                                         ' + #13 +
      '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '')                 + #13 +
      '                                                                                                                                                   ' + #13 +
      '         union all                                                                                                                                 ' + #13 +
      '                                                                                                                                                   ' + #13 +
      '        select                                                                                                                     ' + #13 +
      '            distinct                                                                                                               ' + #13 +
      '            d.data DATA_EMISSAO,                                                                                                   ' + #13 +
      '            d.data DATA_FATURADO,                                                                                                  ' + #13 +
      '            (di.valor_unitario * di.quantidade) * -1 VALOR_PRODUTO,                                                                ' + #13 +
      '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.desconto as float),0) *-1 DESCONTO,           ' + #13 +
      '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.valor_acrescimo as float),0) *-1 ACRESCIMO,   ' + #13 +
      '            0 FRETE,                                                                                                               ' + #13 +
      '            0 IPI,                                                                                                                 ' + #13 +
      '            0 ST,                                                                                                                  ' + #13 +
      '            (di.quantidade*di.custo)*-1 CUSTO,                                                                                                               ' + #13 +
      '            0 TOTAL_ITENS,                                                                                                         ' + #13 +
      '            null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
      '            null CLIENTE,                                                                                                          ' + #13 +
      '            di.item ITEM                                                                                                           ' + #13 +
      '        from                                                                                                                       ' + #13 +
      '             devolucao d                                                                                                           ' + #13 +
      '               left join funcionario f     on f.codigo_fun  = d.vendedor                                                           ' + #13 +
      '               left join devolucaoitens di on di.id         = d.id                                                                 ' + #13 +
      '               left join pedidovenda v     on v.numero_ped  = d.pedido                                                             ' + #13 +
      '               left join pedidoitens vi    on vi.numero_ped = v.numero_ped and                                                     ' + #13 +
      '                                              vi.codigo_pro = di.produto                                                           ' + #13 +
      '                                                                                                                                   ' + #13 +
      '        where                                                                                                                      ' + #13 +
      '            coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
      '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '')                 + #13 +
      '                                                                                                                                                   ' + #13 +
      '         union all                                                                                                                                 ' + #13 +
      '                                                                                                                                                   ' + #13 +
      '         select                                                                                                                                    ' + #13 +
      '             e.datamovi_ent DATA_EMISSAO,                                                                                                          ' + #13 +
      '             e.datamovi_ent DATA_FATURADO,                                                                                                         ' + #13 +
      '             coalesce(e.TOTAL_ENT,0)*-1 VALOR_LIQUIDO,                                                                                             ' + #13 +
      '             0 DESCONTO,                                                                                                                           ' + #13 +
      '             0 ACRESCIMO,                                                                                                                          ' + #13 +
      '             0 FRETE,                                                                                                                              ' + #13 +
      '             0 IPI,                                                                                                                                ' + #13 +
      '             0 ST,                                                                                                                                 ' + #13 +
      '             0 CUSTO,                                                                                                                              ' + #13 +
      '             0 TOTAL_ITENS,                                                                                                                        ' + #13 +
      '             '' '' QUANTIDADE_VENDA,                                                                                                               ' + #13 +
      '             '' '' QUANTIDADE_CLIENTE,                                                                                                             ' + #13 +
      '             '' '' ITEM                                                                                                                            ' + #13 +

      '         from                                                                                                                                      ' + #13 +
      '             entrada e                                                                                                                             ' + #13 +
      '               inner join pedidovenda v on e.devolucao_pedido_id = v.numero_ped                                                                    ' + #13 +
      '         where                                                                                                                                     ' + #13 +
      '             coalesce(e.TOTAL_ENT,0) > 0                                                                                                           ' + #13 +
      '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '')                 + #13 +
      '     ) vendas                                                                                                                                      ' + #13 +
      '                                                                                                                                                   ' + #13 +
      '     where                                                                                                                                         ' + #13 +
      '           vendas.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + #13 +
      ' )                                                                                                                                                 ' + #13;

  gravaSQL(lSQL, 'DashbordDao_ObterQuery7_RankingFiliais_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  MemTable.FieldDefs.Add('LOJA', ftString,3);
  MemTable.FieldDefs.Add('NOME_LOJA', ftString,100);
  MemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
  MemTable.FieldDefs.Add('CUSTO', ftFloat);
  MemTable.FieldDefs.Add('DESCONTO',      ftFloat);
  MemTable.FieldDefs.Add('ACRESCIMO',     ftFloat);
  MemTable.FieldDefs.Add('FRETE',         ftFloat);
  MemTable.FieldDefs.Add('IPI',           ftFloat);
  MemTable.FieldDefs.Add('ST',            ftFloat);

  MemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterQuery7_RankingFiliais';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery7_RankingFiliais: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery7_RankingFiliais: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

      lTotalValores := lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;

      if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ST').AsFloat;
      if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat;
      if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('IPI').AsFloat;
      if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQA.dataset.dataset.FieldByName('FRETE').AsFloat;


    lQA.dataset.dataset.First;
    MemTable.InsertRecord([
                            lQA.loja.objeto.LOJA,
                            lQA.loja.objeto.DESCRICAO,
                            lTotalValores, //lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat,
                            lQA.dataset.dataset.FieldByName('CUSTO').AsFloat,
                            lQA.dataset.dataset.FieldByName('DESCONTO').AsFloat,
                            lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat,
                            lQA.dataset.dataset.FieldByName('FRETE').AsFloat,
                            lQA.dataset.dataset.FieldByName('IPI').AsFloat,
                            lQA.dataset.dataset.FieldByName('ST').AsFloat
                            ]);


  end;
end;

function TDashbordDao.ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lSQL:String;
  lMemTable: TFDMemTable;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin
  lAsyncList := getQueryLojaAsyncList(vIConexao,pDashbord_Parametros.Lojas);

  lMemTable :=  TFDMemTable.Create(nil);
  Result := criaIFDDataset(lMemTable);

  lSQL := '       select                                              ' + #13 +
          '          distinct extract(year from v.data_ped) ANO       ' + #13 +
          '        from                                               ' + #13 +
          '            pedidovenda v                                  ' + #13 +
          '        where                                              ' + #13 +
          '            coalesce(v.valor_ped,0) > 0                    ' + #13 +
          '            and coalesce(v.status,''P'') in (''P'',''F'')  ';

  gravaSQL(lSQL, 'DashbordDao_ObterQuery_Anos_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  lMemTable.FieldDefs.Add('ANO', ftInteger);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterQuery_Anos';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery_Anos: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDashbordDao.ObterQuery_Anos: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      if not lMemTable.Locate('ANO', lQA.dataset.dataset.FieldByName('ANO').AsInteger) then
      begin
        lMemTable.InsertRecord([lQA.dataset.dataset.FieldByName('ANO').AsInteger]);
      end;

      lQA.dataset.dataset.Next;
    end;
  end;


end;

end.
