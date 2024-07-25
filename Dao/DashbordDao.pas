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
  LojasModel;

type
  TDashbordDao = class

  private
    vIConexao : IConexao;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;

    function ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;

end;

implementation

uses
  Data.DB,
  Clipbrd;

{ TDashbord }

constructor TDashbordDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDashbordDao.Destroy;
begin
  inherited;
end;

function TDashbordDao.ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lLojasModel,
  lLojas_Dados: TLojasModel;
  MemTable: TFDMemTable;
  lTotalValores: Real;
begin
  lLojasModel := TLojasModel.Create(vIConexao);
  MemTable := TFDMemTable.Create(nil);

  try
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
            '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                 ' + #13 +
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
            '            0 CUSTO,                                                                                                               ' + #13 +
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
            '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
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


    lLojasModel.LojaView := pDashbord_Parametros.Lojas;
    lLojasModel.ObterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      try
        vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
        lQry := vIConexao.CriarQueryExterna;

        lQry.Open(lSQL);

        lTotalValores := lQry.FieldByName('VALOR_LIQUIDO').AsFloat;

        if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ST').AsFloat;
        if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ACRESCIMO').AsFloat;
        if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('IPI').AsFloat;
        if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('FRETE').AsFloat;

        if MemTable.IsEmpty then
        begin
          MemTable.InsertRecord([
                                  lLojas_Dados.LOJA,
                                  lTotalValores,
                                  lQry.FieldByName('CUSTO').AsFloat,
                                  lQry.FieldByName('TOTAL_ITENS').AsInteger,
                                  lQry.FieldByName('QUANTIDADE_VENDA').AsInteger,
                                  lQry.FieldByName('CLIENTE').AsInteger
                                  ]);
        end else
        begin
          MemTable.Edit;
          MemTable.FieldByName('VALOR_LIQUIDO').Value      := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
          MemTable.FieldByName('CUSTO').Value              := MemTable.FieldByName('CUSTO').Value + lQry.FieldByName('CUSTO').AsFloat;
          MemTable.FieldByName('TOTAL_ITENS').Value        := MemTable.FieldByName('TOTAL_ITENS').Value + lQry.FieldByName('TOTAL_ITENS').AsInteger;
          MemTable.FieldByName('QUANTIDADE_VENDA').Value   := MemTable.FieldByName('QUANTIDADE_VENDA').Value + lQry.FieldByName('QUANTIDADE_VENDA').AsInteger;
          MemTable.FieldByName('QUANTIDADE_CLIENTE').Value := MemTable.FieldByName('QUANTIDADE_CLIENTE').Value + lQry.FieldByName('CLIENTE').AsInteger;
          MemTable.Post;
        end;

      finally
       lQry.Free;
      end;
    end;

    MemTable.Edit;
    MemTable.FieldByName('TICKET_MEDIO').Value     := MemTable.FieldByName('VALOR_LIQUIDO').AsFloat/MemTable.FieldByName('QUANTIDADE_VENDA').AsInteger;
    MemTable.FieldByName('QUANTIDADE_MEDIA').Value := MemTable.FieldByName('TOTAL_ITENS').AsInteger / MemTable.FieldByName('QUANTIDADE_VENDA').AsInteger;
    MemTable.FieldByName('VALOR_ITEM_MEDIO').Value := MemTable.FieldByName('VALOR_LIQUIDO').AsFloat / MemTable.FieldByName('TOTAL_ITENS').AsInteger;
    MemTable.FieldByName('MARKUP_1').Value         := (MemTable.FieldByName('VALOR_LIQUIDO').AsFloat/MemTable.FieldByName('CUSTO').AsFloat*100)-100;
    MemTable.FieldByName('MARKUP_2').Value         := -1*((MemTable.FieldByName('CUSTO').AsFloat*100/MemTable.FieldByName('VALOR_LIQUIDO').AsFloat)-100);
    MemTable.Post;

    Result :=  MemTable;
  finally
  end;
end;

function TDashbordDao.ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lLojasModel,
  lLojas_Dados: TLojasModel;
  MemTable: TFDMemTable;
  lTotalValores: Real;
begin
  lLojasModel := TLojasModel.Create(vIConexao);
  MemTable := TFDMemTable.Create(nil);

  try
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
            '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                 ' + #13 +
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
            '            0 CUSTO,                                                                                                               ' + #13 +
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
            '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
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

    lLojasModel.LojaView := pDashbord_Parametros.Lojas;
    lLojasModel.ObterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      try
        vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
        lQry := vIConexao.CriarQueryExterna;

        lQry.Open(lSQL);

        lQry.First;
        while not lQry.Eof do
        begin
          lTotalValores := lQry.FieldByName('VALOR_LIQUIDO').AsFloat;

          if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ST').AsFloat;
          if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ACRESCIMO').AsFloat;
          if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('IPI').AsFloat;
          if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('FRETE').AsFloat;

          if pDashbord_Parametros.TipoData = 'EMISSÃO' then
          begin
            if not MemTable.Locate('DATA_EMISSAO', lQry.FieldByName('DATA_EMISSAO').AsString) then
            begin
              MemTable.InsertRecord([
                                      lQry.FieldByName('DATA_EMISSAO').AsString,
                                      Copy(lQry.FieldByName('DATA_EMISSAO').AsString, 1, 2),
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
            if not MemTable.Locate('DATA_EMISSAO', lQry.FieldByName('DATA_FATURADO').AsString) then
            begin
              MemTable.InsertRecord([
                                      lQry.FieldByName('DATA_FATURADO').AsString,
                                      Copy(lQry.FieldByName('DATA_FATURADO').AsString, 1, 2),
                                      lTotalValores
                                      ]);
            end else
            begin
              MemTable.Edit;
              MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
              MemTable.Post;
            end;
          end;
          lQry.Next;
        end;

      finally
       lQry.Free;
      end;
    end;

    MemTable.IndexFieldNames := 'DATA_EMISSAO';
    MemTable.Open;

    Result :=  MemTable;
  finally
  end;
end;

function TDashbordDao.ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lLojasModel,
  lLojas_Dados: TLojasModel;
  MemTable: TFDMemTable;
  Options: TLocateOptions;
  lTotalValores: Real;
  I, lojas: Integer;
begin
  MemTable    := TFDMemTable.Create(nil);
  lLojasModel := TLojasModel.Create(vIConexao);
  lQry        := vIConexao.CriarQuery;

  try
    lSQL := '  execute block                                                                                                                ' + #13 +
            '    returns (                                                                                                                  ' + #13 +
            '      MES                    varchar(2),                                                                                       ' + #13 +
            '      VALOR_LIQUIDO          numeric(15,2),                                                                                    ' + #13 +
            '      DESCONTO               numeric(15,2),                                                                                    ' + #13 +
            '      ACRESCIMO              numeric(15,2),                                                                                    ' + #13 +
            '      FRETE                  numeric(15,2),                                                                                    ' + #13 +
            '      IPI                    numeric(15,2),                                                                                    ' + #13 +
            '      ST                     numeric(15,2),                                                                                    ' + #13 +
            '      CUSTO                  numeric(15,2))                                                                                    ' + #13 +
            '    as                                                                                                                         ' + #13 +
            '  declare variable vsql varchar(20000);                                                                                        ' + #13 +
            '  declare variable vservidor varchar(150);                                                                                     ' + #13 +
            '  begin                                                                                                                        ' + #13 +
            '    vsql = ''select                                                                                                            ' + #13 +
            '	    MES,                                                                                                                      ' + #13 +
            '	    VALOR_LIQUIDO,                                                                                                            ' + #13 +
            '	    DESCONTO,                                                                                                                 ' + #13 +
            '	    ACRESCIMO,                                                                                                                ' + #13 +
            '	    FRETE,                                                                                                                    ' + #13 +
            '	    IPI,                                                                                                                      ' + #13 +
            '	    ST,                                                                                                                       ' + #13 +
            '	    CUSTO                                                                                                                     ' + #13 +
            'from                                                                                                                           ' + #13 +
            '(                                                                                                                              ' + #13 +
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
            '        ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                 ' + #13 +
            '        ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
            '        ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
            '        i.valor_ipi IPI,                                                                                                       ' + #13 +
            '        i.valor_st ST,                                                                                                         ' + #13 +
            '        coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
            '        '''' '''' ITEM                                                                                                         ' + #13 +
            '                                                                                                                               ' + #13 +
            '    from                                                                                                                       ' + #13 +
            '         pedidovenda v                                                                                                         ' + #13 +
            '           inner join pedidoitens i on v.numero_ped = i.numero_ped                                                             ' + #13 +
            '    where                                                                                                                      ' + #13 +
            '        coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
            '        and coalesce(v.status,''''P'''') in (''''P'''',''''F'''')                                                              ' + #13 +
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
            '        0 CUSTO,                                                                                                               ' + #13 +
            '        di.item ITEM                                                                                                           ' + #13 +
            '    from                                                                                                                       ' + #13 +
            '         devolucao d                                                                                                           ' + #13 +
            '           left join funcionario f     on f.codigo_fun  = d.vendedor                                                           ' + #13 +
            '           left join devolucaoitens di on di.id         = d.id                                                                 ' + #13 +
            '           left join pedidovenda v     on v.numero_ped  = d.pedido                                                             ' + #13 +
            '           left join pedidoitens vi    on vi.numero_ped = v.numero_ped and vi.codigo_pro = di.produto                          ' + #13 +
            '    where                                                                                                                      ' + #13 +
            '        coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
            '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
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
            '        '''' '''' ITEM                                                                                                         ' + #13 +
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
            '        '''' '''' ITEM                                                                                                         ' + #13 +
            '    from                                                                                                                       ' + #13 +
            '         os v                                                                                                                  ' + #13 +
            '           inner join ositens i  on v.numero_os  = i.numero_os                                                                 ' + #13 +
            '           left  join produto pr on i.codigo_pro = pr.codigo_pro                                                               ' + #13 +
            '    where                                                                                                                      ' + #13 +
            '        coalesce(v.status_os,''''F'''') = ''''F''''                                                                            ' + #13 +
            '        and coalesce(v.total_os, 0) > 0                                                                                        ' + #13 +
            '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and i.vendedor_id in (' + pDashbord_Parametros.Vendedores + ') ','') + #13 +
            '                                                                                                                               ' + #13 +
            ') resultado                                                                                                                    ' + #13 +
            '                                                                                                                               ' + #13 +
            'where                                                                                                                          ' + #13 +
            '      resultado.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ''' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio)) + ''' and ''' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + ''''+ #13 +
            '                                                                                                                               ' + #13 +
            'group by 1                                                                                                                     ' + #13 +
            'order by 1                                                                                                                     ' + #13 +
            ')'';                                                                                                                           ' + #13 +
            '    for                                                                                                                        ' + #13 ;

    lLojasModel.LojaView := pDashbord_Parametros.Lojas;
    lLojasModel.ObterLista;

    lojas := 0;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      inc(lojas);

      if lojas = 1 then
        lSQL := lSQL +
          '        select '''+lLojas_Dados.Server+'/'+lLojas_Dados.Port+':'+lLojas_Dados.DataBase+''' from rdb$database       ' + #13
      else
        lSQL := lSQL +
          '        union all                                                                                                  ' + #13+
          '        select '''+lLojas_Dados.Server+'/'+lLojas_Dados.Port+':'+lLojas_Dados.DataBase+''' from rdb$database       ' + #13;
    end;

    lSQL := lSQL +
            '        into vservidor                                                                                                         ' + #13 +
            '      do                                                                                                                       ' + #13 +
            '      begin                                                                                                                    ' + #13 +
            '        for execute statement vsql                                                                                             ' + #13 +
            '        on external vservidor                                                                                                  ' + #13 +
            '        as user ''SYSDBA'' password ''masterkey''                                                                              ' + #13 +
            '        into                                                                                                                   ' + #13 +
            '          MES,                                                                                                                 ' + #13 +
            '          VALOR_LIQUIDO,                                                                                                       ' + #13 +
            '          DESCONTO,                                                                                                            ' + #13 +
            '          ACRESCIMO,                                                                                                           ' + #13 +
            '          FRETE,                                                                                                               ' + #13 +
            '         IPI,                                                                                                                  ' + #13 +
            '          ST,                                                                                                                  ' + #13 +
            '          CUSTO                                                                                                                ' + #13 +
            '        do                                                                                                                     ' + #13 +
            '          suspend;                                                                                                             ' + #13 +
            '      end                                                                                                                      ' + #13 +
            '    end                                                                                                                        ' + #13;

    gravaSQL(lSQL, 'DashbordDao_ObterQuery3_VendaPorAno_' + FormatDateTime('yyyymmddhhnnsszzz', now));

    MemTable.FieldDefs.Add('MES', ftInteger);
    MemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
    MemTable.CreateDataSet;
    Options := [loCaseInsensitive];

    for I := 1 to 12 do
    begin
      MemTable.InsertRecord([ I, 0 ]);
    end;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lTotalValores := lQry.FieldByName('VALOR_LIQUIDO').AsFloat;

      if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ST').AsFloat;
      if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ACRESCIMO').AsFloat;
      if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('IPI').AsFloat;
      if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('FRETE').AsFloat;

      if not MemTable.Locate('MES', lQry.FieldByName('MES').AsInteger, Options) then
      begin
        MemTable.InsertRecord([
                                lQry.FieldByName('MES').AsInteger,
                                lTotalValores
                                ]);
      end else
      begin
        MemTable.Edit;
        MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
        MemTable.Post;
      end;
      lQry.Next;
    end;

    MemTable.IndexFieldNames := 'MES';
    MemTable.Open;

    Result :=  MemTable;
  finally
  end;
end;

//function TDashbordDao.ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
//var
//  lQry: TFDQuery;
//  lSQL:String;
//  lConexao: TConexao;
//  lListaLojas: TLista_Lojas_Dados;
//  lLojas_Dados: TLojas_Dados;
//  lLojas_Parametros: TLojas_Parametros;
//  lLojasModel: TLojasModel;
//  MemTable: TFDMemTable;
//  Options: TLocateOptions;
//  lTotalValores: Real;
//  I: Integer;
//begin
//  MemTable := TFDMemTable.Create(nil);
//  lConexao := TConexao.Create;
//  lLojasModel := TLojasModel.Create;
//
//  try
//    lSQL := 'select                                                                                                                         ' + #13 +
//            '	    MES,                                                                                                                      ' + #13 +
//            '	    VALOR_LIQUIDO,                                                                                                            ' + #13 +
//            '	    DESCONTO,                                                                                                                 ' + #13 +
//            '	    ACRESCIMO,                                                                                                                ' + #13 +
//            '	    FRETE,                                                                                                                    ' + #13 +
//            '	    IPI,                                                                                                                      ' + #13 +
//            '	    ST,                                                                                                                       ' + #13 +
//            '	    CUSTO                                                                                                                     ' + #13 +
//            'from                                                                                                                           ' + #13 +
//            '(                                                                                                                              ' + #13 +
//            '    select                                                                                                                     ' + #13 +
//            '        extract(month from ' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ') MES,    ' + #13 +
//            '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                             ' + #13 +
//            '        sum(valor_produto) VALOR_PRODUTO,                                                                                      ' + #13 +
//            '        sum(desconto) DESCONTO,                                                                                                ' + #13 +
//            '        sum(acrescimo) ACRESCIMO,                                                                                              ' + #13 +
//            '        sum(frete) FRETE,                                                                                                      ' + #13 +
//            '        sum(ipi) IPI,                                                                                                          ' + #13 +
//            '        sum(st) ST,                                                                                                            ' + #13 +
//            '        sum(custo) CUSTO                                                                                                       ' + #13 +
//            '                                                                                                                               ' + #13 +
//            '    from                                                                                                                       ' + #13 +
//            '    (                                                                                                                          ' + #13 +
//            '    select                                                                                                                     ' + #13 +
//            '        v.data_ped DATA_EMISSAO,                                                                                               ' + #13 +
//            '        v.data_faturado DATA_FATURADO,                                                                                         ' + #13 +
//            '        (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
//            '        ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                 ' + #13 +
//            '        ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
//            '        ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
//            '        i.valor_ipi IPI,                                                                                                       ' + #13 +
//            '        i.valor_st ST,                                                                                                         ' + #13 +
//            '        coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
//            '        '' '' ITEM                                                                                                             ' + #13 +
//            '                                                                                                                               ' + #13 +
//            '    from                                                                                                                       ' + #13 +
//            '         pedidovenda v                                                                                                         ' + #13 +
//            '           inner join pedidoitens i on v.numero_ped = i.numero_ped                                                             ' + #13 +
//            '    where                                                                                                                      ' + #13 +
//            '        coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
//            '        and coalesce(v.status,''P'') in (''P'',''F'')                                                                          ' + #13 +
//            '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
//            '                                                                                                                               ' + #13 +
//            '    union all                                                                                                                  ' + #13 +
//            '                                                                                                                               ' + #13 +
//            '    select                                                                                                                     ' + #13 +
//            '        distinct                                                                                                               ' + #13 +
//            '        d.data DATA_EMISSAO,                                                                                                   ' + #13 +
//            '        d.data DATA_FATURADO,                                                                                                  ' + #13 +
//            '        (di.valor_unitario*di.quantidade) *-1 VALOR_PRODUTO,                                                                   ' + #13 +
//            '        ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.desconto as float),0) *-1 DESCONTO,           ' + #13 +
//            '        ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.valor_acrescimo as float),0) *-1 ACRESCIMO,   ' + #13 +
//            '        0 FRETE,                                                                                                               ' + #13 +
//            '        0 IPI,                                                                                                                 ' + #13 +
//            '        0 ST,                                                                                                                  ' + #13 +
//            '        0 CUSTO,                                                                                                               ' + #13 +
//            '        di.item ITEM                                                                                                           ' + #13 +
//            '    from                                                                                                                       ' + #13 +
//            '         devolucao d                                                                                                           ' + #13 +
//            '           left join funcionario f     on f.codigo_fun  = d.vendedor                                                           ' + #13 +
//            '           left join devolucaoitens di on di.id         = d.id                                                                 ' + #13 +
//            '           left join pedidovenda v     on v.numero_ped  = d.pedido                                                             ' + #13 +
//            '           left join pedidoitens vi    on vi.numero_ped = v.numero_ped and vi.codigo_pro = di.produto                          ' + #13 +
//            '    where                                                                                                                      ' + #13 +
//            '        coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
//            '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
//            '                                                                                                                               ' + #13 +
//            '    union all                                                                                                                  ' + #13 +
//            '                                                                                                                               ' + #13 +
//            '    select                                                                                                                     ' + #13 +
//            '        e.datamovi_ent DATA_EMISSAO,                                                                                           ' + #13 +
//            '        e.datamovi_ent DATA_FATURADO,                                                                                          ' + #13 +
//            '        coalesce(e.TOTAL_ENT,0)*-1 VALOR_LIQUIDO,                                                                              ' + #13 +
//            '        0 DESCONTO,                                                                                                            ' + #13 +
//            '        0 ACRESCIMO,                                                                                                           ' + #13 +
//            '        0 FRETE,                                                                                                               ' + #13 +
//            '        0 IPI,                                                                                                                 ' + #13 +
//            '        0 ST,                                                                                                                  ' + #13 +
//            '        0 CUSTO,                                                                                                               ' + #13 +
//            '        '' '' ITEM                                                                                                             ' + #13 +
//            '    from                                                                                                                       ' + #13 +
//            '         entrada e                                                                                                             ' + #13 +
//            '           inner join pedidovenda v on e.devolucao_pedido_id = v.numero_ped                                                    ' + #13 +
//            '    where                                                                                                                      ' + #13 +
//            '        coalesce(e.TOTAL_ENT,0) > 0                                                                                            ' + #13 +
//            '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
//            '    																														                                                              	' + #13 +
//            '    union all                                                                                                                  ' + #13 +
//            '                                                                                                                               ' + #13 +
//            '    select                                                                                                                     ' + #13 +
//            '        v.fechamento_os DATA_EMISSAO,                                                                                          ' + #13 +
//            '        v.fechamento_os DATA_FATURADO,                                                                                         ' + #13 +
//            '        (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                   ' + #13 +
//            '        ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,       ' + #13 +
//            '        ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO, ' + #13 +
//            '        0 FRETE,                                                                                                               ' + #13 +
//            '        0 IPI,                                                                                                                 ' + #13 +
//            '        0 ST,                                                                                                                  ' + #13 +
//            '        coalesce(i.quantidade_pro,0) * coalesce(i.custo_pro,0) CUSTO,                                                          ' + #13 +
//            '        '' '' ITEM                                                                                                             ' + #13 +
//            '    from                                                                                                                       ' + #13 +
//            '         os v                                                                                                                  ' + #13 +
//            '           inner join ositens i  on v.numero_os  = i.numero_os                                                                 ' + #13 +
//            '           left  join produto pr on i.codigo_pro = pr.codigo_pro                                                               ' + #13 +
//            '    where                                                                                                                      ' + #13 +
//            '        coalesce(v.status_os,''F'') = ''F''                                                                                    ' + #13 +
//            '        and coalesce(v.total_os, 0) > 0                                                                                        ' + #13 +
//            '        ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and i.vendedor_id in (' + pDashbord_Parametros.Vendedores + ') ','') + #13 +
//            '                                                                                                                               ' + #13 +
//            ') resultado                                                                                                                    ' + #13 +
//            '                                                                                                                               ' + #13 +
//            'where                                                                                                                          ' + #13 +
//            '      resultado.' + ifThen(pDashbord_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pDashbord_Parametros.DataFim)) + #13 +
//            '                                                                                                                               ' + #13 +
//            'group by 1                                                                                                                     ' + #13 +
//            'order by 1                                                                                                                     ' + #13 +
//            ')                                                                                                                              ';
//
//    gravaSQL(lSQL, 'DashbordDao_ObterQuery3_VendaPorAno_' + FormatDateTime('yyyymmddhhnnsszzz', now));
//
//    MemTable.FieldDefs.Add('MES', ftInteger);
//    MemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
//    MemTable.CreateDataSet;
//    Options := [loCaseInsensitive];
//
//    for I := 1 to 12 do
//    begin
//      MemTable.InsertRecord([ I, 0 ]);
//    end;
//
//
//    lLojas_Parametros.Numero := pDashbord_Parametros.Lojas;
//    lListaLojas := lLojasModel.ObterLista(lLojas_Parametros);
//
//    for lLojas_Dados in lListaLojas do
//    begin
//      try
//        lConexao.ConfigConexaoExterna(lLojas_Dados.Server,lLojas_Dados.Port,lLojas_Dados.DataBase);
//        lQry := lConexao.CriarQueryExterna;
//
//        lQry.Open(lSQL);
//
//        lQry.First;
//        while not lQry.Eof do
//        begin
//          lTotalValores := lQry.FieldByName('VALOR_LIQUIDO').AsFloat;
//
//          if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ST').AsFloat;
//          if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ACRESCIMO').AsFloat;
//          if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('IPI').AsFloat;
//          if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('FRETE').AsFloat;
//
//          if not MemTable.Locate('MES', lQry.FieldByName('MES').AsInteger, Options) then
//          begin
//            MemTable.InsertRecord([
//                                    lQry.FieldByName('MES').AsInteger,
//                                    lTotalValores
//                                    ]);
//          end else
//          begin
//            MemTable.Edit;
//            MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
//            MemTable.Post;
//          end;
//          lQry.Next;
//        end;
//
//      finally
//        lQry.Free;
//      end;
//    end;
//
//    MemTable.IndexFieldNames := 'MES';
//    MemTable.Open;
//
//    Result :=  MemTable;
//  finally
//    lConexao.Free;
//  end;
//end;

function TDashbordDao.ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lLojasModel,
  lLojas_Dados: TLojasModel;
  MemTable: TFDMemTable;
  Options: TLocateOptions;
  lTotalValores: Real;
begin
  MemTable := TFDMemTable.Create(nil);
  lLojasModel := TLojasModel.Create(vIConexao);

  try
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
            '    	       ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                                         ' + #13 +
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

    lLojasModel.LojaView := pDashbord_Parametros.Lojas;
    lLojasModel.ObterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      try
        vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
        lQry := vIConexao.CriarQueryExterna;

        lQry.Open(lSQL);

        lQry.First;
        while not lQry.Eof do
        begin
          lTotalValores := lQry.FieldByName('VALOR_LIQUIDO').AsFloat;

          if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ST').AsFloat;
          if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ACRESCIMO').AsFloat;
          if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('IPI').AsFloat;
          if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('FRETE').AsFloat;

          if not MemTable.Locate('DESCRICAO', lQry.FieldByName('DESCRICAO').AsString) then
          begin
            MemTable.InsertRecord([
                                    lQry.FieldByName('DESCRICAO').AsString,
                                    lTotalValores,
                                    lQry.FieldByName('DESCONTO').AsFloat,
                                    lQry.FieldByName('ACRESCIMO').AsFloat,
                                    lQry.FieldByName('FRETE').AsFloat,
                                    lQry.FieldByName('IPI').AsFloat,
                                    lQry.FieldByName('ST').AsFloat,
                                    lQry.FieldByName('CUSTO').AsFloat
                                    ]);
          end else
          begin
            MemTable.Edit;
            MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
            MemTable.FieldByName('DESCONTO').Value      := MemTable.FieldByName('DESCONTO').Value + lQry.FieldByName('DESCONTO').AsFloat;
            MemTable.FieldByName('ACRESCIMO').Value     := MemTable.FieldByName('ACRESCIMO').Value + lQry.FieldByName('ACRESCIMO').AsFloat;
            MemTable.FieldByName('FRETE').Value         := MemTable.FieldByName('FRETE').Value + lQry.FieldByName('FRETE').AsFloat;
            MemTable.FieldByName('IPI').Value           := MemTable.FieldByName('IPI').Value + lQry.FieldByName('IPI').AsFloat;
            MemTable.FieldByName('ST').Value            := MemTable.FieldByName('ST').Value + lQry.FieldByName('ST').AsFloat;
            MemTable.FieldByName('CUSTO').Value         := MemTable.FieldByName('CUSTO').Value + lQry.FieldByName('CUSTO').AsFloat;
             MemTable.Post;
          end;
          lQry.Next;
        end;

      finally
        lQry.Free;
      end;
    end;

    MemTable.IndexFieldNames := 'DESCRICAO';
    MemTable.Open;

    Result :=  MemTable;
  finally
  end;
end;

function TDashbordDao.ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lLojasModel,
  lLojas_Dados: TLojasModel;
  MemTable: TFDMemTable;
  Options: TLocateOptions;
  lTotalValores: Real;
begin
  MemTable := TFDMemTable.Create(nil);
  lLojasModel := TLojasModel.Create(vIConexao);

  try
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
            '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
            '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
            '            (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
            '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                 ' + #13 +
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
            '			          inner join pedidoitens i on v.numero_ped = i.numero_ped                                                             ' + #13 +
            '               left  join funcionario f on f.codigo_fun = v.codigo_ven                                                             ' + #13 +
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
            '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
            '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
            '            (di.valor_unitario*di.quantidade) *-1 VALOR_PRODUTO,                                                                   ' + #13 +
            '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.desconto as float),0) *-1 DESCONTO,           ' + #13 +
            '            ((di.quantidade*di.valor_unitario)/(d.valor_total+d.desconto-d.valor_acrescimo))*coalesce(cast(d.valor_acrescimo as float),0) *-1 ACRESCIMO,   ' + #13 +
            '            0 FRETE,                                                                                                               ' + #13 +
            '            0 IPI,                                                                                                                 ' + #13 +
            '            0 ST,                                                                                                                  ' + #13 +
            '            0 CUSTO,                                                                                                               ' + #13 +
            '            di.quantidade * -1 TOTAL_ITENS,                                                                                        ' + #13 +
            '            null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
            '            null CLIENTE,                                                                                                          ' + #13 +
            '            di.item ITEM                                                                                                           ' + #13 +
            '        from                                                                                                                       ' + #13 +
            '             devolucao d                                                                                                           ' + #13 +
            '               left join funcionario f     on f.codigo_fun  = d.vendedor                                                           ' + #13 +
            '               left join devolucaoitens di on di.id         = d.id                                                                 ' + #13 +
            '               left join pedidovenda v     on v.numero_ped  = d.pedido                                                             ' + #13 +
            '               left join pedidoitens vi    on vi.numero_ped = v.numero_ped and                                                     ' + #13 +
            '			                                         vi.codigo_pro = di.produto                                                           ' + #13 +
            '        where                                                                                                                      ' + #13 +
            '            coalesce(d.valor_total,0) > 0                                                                                          ' + #13 +
            '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and f.codigo_fun in (' + pDashbord_Parametros.Vendedores + ') ', '') + #13 +
            '                                                                                                                                   ' + #13 +
            '        union all                                                                                                                  ' + #13 +
            '                                                                                                                                   ' + #13 +
            '        select                                                                                                                     ' + #13 +
            '            e.datamovi_ent DATA_EMISSAO,                                                                                           ' + #13 +
            '            e.datamovi_ent DATA_FATURADO,                                                                                          ' + #13 +
            '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
            '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
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
            '            f.codigo_fun CODIGO_VEN,                                                                                               ' + #13 +
            '            f.nome_fun VENDEDOR,                                                                                                   ' + #13 +
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

    lLojasModel.LojaView := pDashbord_Parametros.Lojas;
    lLojasModel.ObterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      try
        vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
        lQry := vIConexao.CriarQueryExterna;

        lQry.Open(lSQL);

        lQry.First;
        while not lQry.Eof do
        begin
          lTotalValores := lQry.FieldByName('VALOR_LIQUIDO').AsFloat;

          if pDashbord_Parametros.SomarST        = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ST').AsFloat;
          if pDashbord_Parametros.SomarAcrescimo = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('ACRESCIMO').AsFloat;
          if pDashbord_Parametros.SomarIPI       = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('IPI').AsFloat;
          if pDashbord_Parametros.SomarFRETE     = 'SIM' then lTotalValores := lTotalValores + lQry.FieldByName('FRETE').AsFloat;

          if not MemTable.Locate('VENDEDOR', trim(lQry.FieldByName('VENDEDOR').AsString)) then
          begin
            MemTable.InsertRecord([
                                    lQry.FieldByName('CODIGO_VEN').AsString,
                                    trim(lQry.FieldByName('VENDEDOR').AsString),
                                    lTotalValores,
                                    lQry.FieldByName('CUSTO').AsFloat,
                                    lQry.FieldByName('CLIENTE').AsInteger,
                                    lQry.FieldByName('DESCONTO').AsFloat,
                                    lQry.FieldByName('ACRESCIMO').AsFloat,
                                    lQry.FieldByName('FRETE').AsFloat,
                                    lQry.FieldByName('IPI').AsFloat,
                                    lQry.FieldByName('ST').AsFloat
                                    ]);
          end else
          begin
            MemTable.Edit;
            MemTable.FieldByName('VALOR_LIQUIDO').Value := MemTable.FieldByName('VALOR_LIQUIDO').Value + lTotalValores;
            MemTable.FieldByName('CUSTO').Value         := MemTable.FieldByName('CUSTO').Value + lQry.FieldByName('CUSTO').AsFloat;
            MemTable.FieldByName('CLIENTE').Value       := MemTable.FieldByName('CLIENTE').Value + lQry.FieldByName('CLIENTE').AsInteger;
            MemTable.FieldByName('DESCONTO').Value      := MemTable.FieldByName('DESCONTO').Value + lQry.FieldByName('DESCONTO').AsFloat;
            MemTable.FieldByName('ACRESCIMO').Value     := MemTable.FieldByName('ACRESCIMO').Value + lQry.FieldByName('ACRESCIMO').AsFloat;
            MemTable.FieldByName('FRETE').Value         := MemTable.FieldByName('FRETE').Value + lQry.FieldByName('FRETE').AsFloat;
            MemTable.FieldByName('IPI').Value           := MemTable.FieldByName('IPI').Value + lQry.FieldByName('IPI').AsFloat;
            MemTable.FieldByName('ST').Value            := MemTable.FieldByName('ST').Value + lQry.FieldByName('ST').AsFloat;
            MemTable.Post;
          end;
          lQry.Next;
        end;

      finally
        lQry.Free;
      end;
    end;

    MemTable.IndexFieldNames := 'VENDEDOR';
    MemTable.Open;

    Result :=  MemTable;
  finally
  end;
end;

function TDashbordDao.ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lLojasModel,
  lLojas_Dados: TLojasModel;
  MemTable: TFDMemTable;
begin
  lLojasModel := TLojasModel.Create(vIConexao);
  MemTable := TFDMemTable.Create(nil);

  try
    lSQL :=
        ' select                                                                                                                                            ' + #13 +
        '     VALOR_LIQUIDO,                                                                                                                                ' + #13 +
        '     CUSTO,                                                                                                                                        ' + #13 +
        '     TOTAL_ITENS,                                                                                                                                  ' + #13 +
        '     QUANTIDADE_VENDA,                                                                                                                             ' + #13 +
        '     QUANTIDADE_CLIENTE                                                                                                                            ' + #13 +
        '                                                                                                                                                   ' + #13 +
        ' from                                                                                                                                              ' + #13 +
        ' (                                                                                                                                                 ' + #13 +
        '     select                                                                                                                                        ' + #13 +
        '         sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                                ' + #13 +
        '         sum(custo) CUSTO,                                                                                                                         ' + #13 +
        '         sum(total_itens) TOTAL_ITENS,                                                                                                             ' + #13 +
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
        '            0 CUSTO,                                                                                                               ' + #13 +
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
        '            ' + ifThen(pDashbord_Parametros.Vendedores <> '', ' and v.CODIGO_VEN in (' + pDashbord_Parametros.Vendedores + ') ', '')                 + #13 +
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

    MemTable.CreateDataSet;

    lLojasModel.LojaView := pDashbord_Parametros.Lojas;
    lLojasModel.ObterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      try
        vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
        lQry := vIConexao.CriarQueryExterna;

        lQry.Open(lSQL);

        MemTable.InsertRecord([
                                lLojas_Dados.LOJA,
                                lLojas_Dados.DESCRICAO,
                                lQry.FieldByName('VALOR_LIQUIDO').AsFloat
                                ]);


      finally
       lQry.Free;
      end;
    end;

    Result :=  MemTable;
  finally
  end;
end;

function TDashbordDao.ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: TFDMemTable;
  lLojasModel,
  lLojas_Dados: TLojasModel;
begin
  lLojasModel := TLojasModel.Create(vIConexao);
  lMemTable := TFDMemTable.Create(nil);

  lSQL := '       select                                              ' + #13 +
          '          distinct extract(year from v.data_ped) ANO       ' + #13 +
          '        from                                               ' + #13 +
          '            pedidovenda v                                  ' + #13 +
          '        where                                              ' + #13 +
          '            coalesce(v.valor_ped,0) > 0                    ' + #13 +
          '            and coalesce(v.status,''P'') in (''P'',''F'')  ';

  gravaSQL(lSQL, 'DashbordDao_ObterQuery_Anos_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  try
    lMemTable.FieldDefs.Add('ANO', ftInteger);
    lMemTable.CreateDataSet;

    lLojasModel.LojaView := pDashbord_Parametros.Lojas;
    lLojasModel.ObterLista;

    for lLojas_Dados in lLojasModel.LojassLista do
    begin
      vIConexao.ConfigConexaoExterna(lLojas_Dados.LOJA);
      lQry := vIConexao.CriarQueryExterna;

      lQry.Open(lSQL);

      lQry.First;
      while not lQry.Eof do
      begin
        if not lMemTable.Locate('ANO', lQry.FieldByName('ANO').AsInteger) then
        begin
          lMemTable.InsertRecord([lQry.FieldByName('ANO').AsInteger]);
        end;

        lQry.Next;
      end;
    end;

  finally
    Result := lMemTable;
    lLojasModel.Free;

    if lQry <> nil then
      lQry.Free;

  end;

end;

end.
