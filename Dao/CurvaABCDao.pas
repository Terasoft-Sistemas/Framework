unit CurvaABCDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  LojasModel;

type
  TCurvaABCDao = class;
  ITCurvaABCDao=IObject<TCurvaABCDao>;

  TCurvaABCDao = class
  private
    [weak] mySelf: ITCurvaABCDao;
    vIConexao : IConexao;

    lNomeCampo, lNomeCampoOS, lNomeCampoDev, lNomeCampoEntrada : String;
    lTabelaPedido, lTabelaOS, lTabelaDevolucao, lTabelaEntrada : String;
    lFiltro : String;

    procedure DefineDadosSelect(Acao: TTipoAnaliseCurvaABC; pCurvaABC_Parametros: TCurvaABC_Parametros);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCurvaABCDao;

    function ObterCurvaABC(pCurvaABC_Parametros: TCurvaABC_Parametros): IFDDataset;

end;

implementation

uses
  Interfaces.QueryLojaAsync,
  CurvaABCModel,
  Terasoft.Framework.LOG,
  Data.DB;

{ TCurvaABC }

constructor TCurvaABCDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCurvaABCDao.Destroy;
begin
  inherited;
end;

class function TCurvaABCDao.getNewIface(pIConexao: IConexao): ITCurvaABCDao;
begin
  Result := TImplObjetoOwner<TCurvaABCDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCurvaABCDao.ObterCurvaABC(pCurvaABC_Parametros: TCurvaABC_Parametros): IFDDataset;
var
  lSQL              : String;
  lMemTable         : TFDMemTable;
  Options           : TLocateOptions;

  lTotalVendas      : Real;
  lTotalQtde        : Real;
  lTotalQtdeCli     : Real;
  lTotalCusto       : Real;
  lTotalLucro       : Real;
  lTotalItens       : Real;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;

begin
  lAsyncList := getQueryLojaAsyncList(vIConexao,pCurvaABC_Parametros.Lojas);

  lMemTable := TFDMemTable.Create(nil);

  Self.DefineDadosSelect(pCurvaABC_Parametros.TipoAnalise, pCurvaABC_Parametros);

  lSQL := 'select                                                                                                                                 ' + #13 +
          '    DESCRICAO,                                                                                                                         ' + #13 +
          '    VALOR_LIQUIDO,                                                                                                                     ' + #13 +
          '    QUANTIDADE_VENDA,                                                                                                                  ' + #13 +
          '    CLIENTE,                                                                                                                           ' + #13 +
          '    CUSTO,                                                                                                                             ' + #13 +
          '    TOTAL_ITENS                                                                                                                        ' + #13 +
          'from                                                                                                                                   ' + #13 +
          '(                                                                                                                                      ' + #13 +
          '    select                                                                                                                             ' + #13 +
          '        DESCRICAO,                                                                                                                     ' + #13 +
          '        VALOR_LIQUIDO,                                                                                                                 ' + #13 +
          '        VALOR_PRODUTO,                                                                                                                 ' + #13 +
          '        DESCONTO,                                                                                                                      ' + #13 +
          '        ACRESCIMO,                                                                                                                     ' + #13 +
          '        FRETE,                                                                                                                         ' + #13 +
          '        IPI,                                                                                                                           ' + #13 +
          '        ST,                                                                                                                            ' + #13 +
          '        CUSTO,                                                                                                                         ' + #13 +
          '        TOTAL_ITENS,                                                                                                                   ' + #13 +
          '        (valor_liquido+acrescimo) VALOR_TOTAL,                                                                                         ' + #13 +
          '        QUANTIDADE_VENDA,                                                                                                              ' + #13 +
          '        CLIENTE                                                                                                                        ' + #13 +
          '                                                                                                                                       ' + #13 +
          '    from                                                                                                                               ' + #13 +
          '    (                                                                                                                                  ' + #13 +
          '                                                                                                                                       ' + #13 +
          '        select                                                                                                                         ' + #13 +
          '            DESCRICAO,                                                                                                                 ' + #13 +
          '            sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                 ' + #13 +
          '            sum(valor_produto) VALOR_PRODUTO,                                                                                          ' + #13 +
          '            sum(valor_possivel) VALOR_POSSIVEL,                                                                                        ' + #13 +
          '            sum(desconto) DESCONTO,                                                                                                    ' + #13 +
          '            sum(acrescimo) ACRESCIMO,                                                                                                  ' + #13 +
          '            sum(frete) FRETE,                                                                                                          ' + #13 +
          '            sum(ipi) IPI,                                                                                                              ' + #13 +
          '            sum(st) ST,                                                                                                                ' + #13 +
          '            sum(custo) CUSTO,                                                                                                          ' + #13 +
          '            sum(total_itens) TOTAL_ITENS,                                                                                              ' + #13 +
          '            count(distinct(quantidade_venda)) QUANTIDADE_VENDA,                                                                      ' + #13 +
          '            count(distinct(cliente)) CLIENTE                                                                                         ' + #13 +
          '                                                                                                                                       ' + #13 +
          '        from                                                                                                                           ' + #13 +
          '        (                                                                                                                              ' + #13 +
          '                                                                                                                                       ' + #13 +
          '           select                                                                                                                      ' + #13 +
          '                ' + lNomeCampo + ',                                                                                                    ' + #13 +
          '                v.data_ped DATA_EMISSAO,                                                                                               ' + #13 +
          '                v.data_faturado DATA_FATURADO,                                                                                         ' + #13 +
          '                (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
          '                (i.vlrvenda_pro * i.qtde_calculada) VALOR_POSSIVEL,                                                                    ' + #13 +
          '                (i.valorunitario_ped*(i.desconto_ped/100))*i.qtde_calculada DESCONTO,                 ' + #13 +
          '                ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
          '                ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
          '                i.valor_ipi IPI,                                                                                                       ' + #13 +
          '                i.valor_st ST,                                                                                                         ' + #13 +
          '                coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
          '                coalesce(i.qtde_calculada, 0) TOTAL_ITENS,                                                                             ' + #13 +
          '                v.numero_ped || ''P'' QUANTIDADE_VENDA,                                                                                ' + #13 +
          '                v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
          '                '' '' ITEM                                                                                                             ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            from                                                                                                                       ' + #13 +
          '            ' + lTabelaPedido + '                                                                                                      ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            where                                                                                                                      ' + #13 +
          '                coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
          '                and coalesce(v.status,''P'') in (''P'',''F'')                                                                          ' + #13 +
          '            ' + lFiltro + '                                                                                                            ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            union all                                                                                                                  ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            select                                                                                                                     ' + #13 +
          '                distinct                                                                                                               ' + #13 +
          '                ' + IIF(lNomeCampoDev <> '', lNomeCampoDev, lNomeCampo) + ',                                                           ' + #13 +
          '                v.data DATA_EMISSAO,                                                                                                   ' + #13 +
          '                v.data DATA_FATURADO,                                                                                                  ' + #13 +
          '                (i.valor_unitario * i.quantidade) *-1 VALOR_PRODUTO,                                                                   ' + #13 +
          '                (pi.vlrvenda_pro * i.quantidade) *-1 VALOR_CADASTRO,                                                                    ' + #13 +
          '                0 DESCONTO,                                                                                                            ' + #13 +
          '                0 ACRESCIMO,                                                                                                           ' + #13 +
          '                0 FRETE,                                                                                                               ' + #13 +
          '                0 IPI,                                                                                                                 ' + #13 +
          '                0 ST,                                                                                                                  ' + #13 +
          '                0 CUSTO,                                                                                                               ' + #13 +
          '                i.quantidade * -1 TOTAL_ITENS,                                                                                        ' + #13 +
          '                null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
          '                null CLIENTE,                                                                                                          ' + #13 +
          '                i.item ITEM                                                                                                           ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            from                                                                                                                       ' + #13 +
          '            ' + lTabelaDevolucao + '                                                                                                   ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            where                                                                                                                      ' + #13 +
          '                coalesce(v.valor_total,0) > 0                                                                                          ' + #13 +
          '            ' + lFiltro + '                                                                                                            ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            union all                                                                                                                  ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            select                                                                                                                     ' + #13 +
          '                ' + IIF(lNomeCampoEntrada <> '', lNomeCampoEntrada, lNomeCampo) + ',                                                   ' + #13 +
          '                e.datamovi_ent DATA_EMISSAO,                                                                                           ' + #13 +
          '                e.datamovi_ent DATA_FATURADO,                                                                                          ' + #13 +
          '                coalesce(e.TOTAL_ENT,0)*-1 VALOR_PRODUTO,                                                                              ' + #13 +
          '                0 VALOR_CADASTRO,                                                                                                      ' + #13 +
          '                0 DESCONTO,                                                                                                            ' + #13 +
          '                0 ACRESCIMO,                                                                                                           ' + #13 +
          '                0 FRETE,                                                                                                               ' + #13 +
          '                0 IPI,                                                                                                                 ' + #13 +
          '                0 ST,                                                                                                                  ' + #13 +
          '                0 CUSTO,                                                                                                               ' + #13 +
          '                0 TOTAL_ITENS,                                                                                                         ' + #13 +
          '                null QUANTIDADE_VENDA,                                                                                                 ' + #13 +
          '                null CLIENTE,                                                                                                          ' + #13 +
          '                '' '' ITEM                                                                                                             ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            from                                                                                                                       ' + #13 +
          '            ' + lTabelaEntrada + '                                                                                                     ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            where                                                                                                                      ' + #13 +
          '                coalesce(e.TOTAL_ENT,0) > 0                                                                                            ' + #13 +
          '            ' + lFiltro + '                                                                                                            ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            union all                                                                                                                  ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            select                                                                                                                     ' + #13 +
          '                ' + IIF(lNomeCampoOS <> '', lNomeCampoOS, lNomeCampo) + ',                                                             ' + #13 +
          '                v.fechamento_os DATA_EMISSAO,                                                                                          ' + #13 +
          '                v.fechamento_os DATA_FATURADO,                                                                                         ' + #13 +
          '                (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                   ' + #13 +
          '                (i.venda_pro * i.quantidade_pro) VALOR_CADASTRO,                                                                       ' + #13 +
          '                ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,       ' + #13 +
          '                ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO, ' + #13 +
          '                0 FRETE,                                                                                                               ' + #13 +
          '                0 IPI,                                                                                                                 ' + #13 +
          '                0 ST,                                                                                                                  ' + #13 +
          '                coalesce(i.quantidade_pro,0) * coalesce(i.custo_pro,0) CUSTO,                                                          ' + #13 +
          '                coalesce(i.quantidade_pro,0) TOTAL_ITENS,                                                                              ' + #13 +
          '                v.numero_os || ''O'' QUANTIDADE_VENDA,                                                                                 ' + #13 +
          '                v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
          '                '' '' ITEM                                                                                                             ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            from                                                                                                                       ' + #13 +
          '            ' + lTabelaOS + '                                                                                                          ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            where                                                                                                                      ' + #13 +
          '                coalesce(v.status_os,''F'') = ''F''                                                                                    ' + #13 +
          '                and coalesce(v.total_os, 0) > 0                                                                                        ' + #13 +
          '            ' + lFiltro + '                                                                                                            ' + #13 +
          '                                                                                                                                       ' + #13 +
          '        ) resultado                                                                                                                    ' + #13 +
          '                                                                                                                                       ' + #13 +
          '        where                                                                                                                          ' + #13 +
          '            resultado.' + ifThen(pCurvaABC_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pCurvaABC_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pCurvaABC_Parametros.DataFim)) + #13 +
          '                                                                                                                                       ' + #13 +
          '        group by 1                                                                                                                     ' + #13 +
          '    )                                                                                                                                  ' + #13 +
          ')                                                                                                                                      ' + #13;

  gravaSQL(lSQL, 'CurvaABCDao_ObterCurvaABC_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  with lMemTable.IndexDefs.AddIndexDef do
  begin
    Name := 'OrdenacaoRateio';
    Fields := 'RATEIO';
    Options := [TIndexOption.ixDescending, TIndexOption.ixCaseInsensitive];
  end;

  lMemTable.IndexName := '';

  lMemTable.FieldDefs.Add('DESCRICAO', ftString, 100);
  lMemTable.FieldDefs.Add('RATEIO', ftFloat);
  lMemTable.FieldDefs.Add('QUANTIDADE_VENDA', ftInteger);
  lMemTable.FieldDefs.Add('QUANTIDADE_CLIENTE', ftInteger);
  lMemTable.FieldDefs.Add('TOTAL_ITENS', ftFloat);
  lMemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
  lMemTable.FieldDefs.Add('CUSTO', ftFloat);
  lMemTable.FieldDefs.Add('LUCRO', ftFloat);
  lMemTable.FieldDefs.Add('MARGEM', ftFloat);
  lMemTable.CreateDataSet;

  lTotalVendas := 0;
  lTotalQtde   := 0;
  lTotalCusto  := 0;
  lTotalLucro  := 0;
  lTotalItens  := 0;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterQuery_Anos';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TCurvaABCDao.ObterCurvaABC: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TCurvaABCDao.ObterCurvaABC: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      if not lMemTable.Locate('DESCRICAO', Trim(lQA.dataset.dataset.FieldByName('DESCRICAO').AsString), Options) then
      begin
        lMemTable.InsertRecord([
                                Trim(lQA.dataset.dataset.FieldByName('DESCRICAO').AsString),
                                0,
                                lQA.dataset.dataset.FieldByName('QUANTIDADE_VENDA').AsFloat,
                                lQA.dataset.dataset.FieldByName('CLIENTE').AsFloat,
                                lQA.dataset.dataset.FieldByName('TOTAL_ITENS').AsFloat,
                                lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat,
                                lQA.dataset.dataset.FieldByName('CUSTO').AsFloat,
                                lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat - lQA.dataset.dataset.FieldByName('CUSTO').AsFloat,
                                0
                               ]);
      end
      else
      begin
        lMemTable.Edit;
        lMemTable.FieldByName('VALOR_LIQUIDO').AsFloat      := lMemTable.FieldByName('VALOR_LIQUIDO').AsFloat      + lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;
        lMemTable.FieldByName('CUSTO').AsFloat              := lMemTable.FieldByName('CUSTO').AsFloat              + lQA.dataset.dataset.FieldByName('CUSTO').AsFloat;
        lMemTable.FieldByName('LUCRO').AsFloat              := lMemTable.FieldByName('VALOR_LIQUIDO').AsFloat      - lMemTable.FieldByName('CUSTO').Value;
        lMemTable.FieldByName('QUANTIDADE_VENDA').AsFloat   := lMemTable.FieldByName('QUANTIDADE_VENDA').AsFloat   + lQA.dataset.dataset.FieldByName('QUANTIDADE_VENDA').AsInteger;
        lMemTable.FieldByName('QUANTIDADE_CLIENTE').AsFloat := lMemTable.FieldByName('QUANTIDADE_CLIENTE').AsFloat + lQA.dataset.dataset.FieldByName('CLIENTE').AsInteger;
        lMemTable.FieldByName('TOTAL_ITENS').AsFloat        := lMemTable.FieldByName('TOTAL_ITENS').AsFloat        + lQA.dataset.dataset.FieldByName('TOTAL_ITENS').AsInteger;
        lMemTable.Post;
      end;

      lTotalVendas  := lTotalVendas  + lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat;
      lTotalQtde    := lTotalQtde    + lQA.dataset.dataset.FieldByName('QUANTIDADE_VENDA').AsInteger;
      lTotalItens   := lTotalItens   + lQA.dataset.dataset.FieldByName('TOTAL_ITENS').AsInteger;
      lTotalQtdeCli := lTotalQtdeCli + lQA.dataset.dataset.FieldByName('CLIENTE').AsInteger;
      lTotalCusto   := lTotalCusto   + lQA.dataset.dataset.FieldByName('CUSTO').AsFloat;
      lTotalLucro   := lTotalLucro   + lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat - lQA.dataset.dataset.FieldByName('CUSTO').AsFloat;

      lQA.dataset.dataset.Next;
    end;

  end;

  // Calculando RATEIO e MARGEM
  lMemTable.First;
  while not lMemTable.Eof do
  begin
    lMemTable.Edit;

    if (pCurvaABC_Parametros.ClassificarPor = tpABCQuantidade) and (lTotalQtde <> 0) then
      lMemTable.FieldByName('RATEIO').AsFloat := (lMemTable.FieldByName('QUANTIDADE_VENDA').AsFloat / lTotalQtde) * 100
    else
    if (pCurvaABC_Parametros.ClassificarPor = tpABCQtdeCliente) and (lTotalQtdeCli <> 0) then
      lMemTable.FieldByName('RATEIO').AsFloat := (lMemTable.FieldByName('QUANTIDADE_CLIENTE').AsFloat / lTotalQtdeCli) * 100
    else
    if (pCurvaABC_Parametros.ClassificarPor = tpABCVenda) and (lTotalVendas <> 0) then
      lMemTable.FieldByName('RATEIO').AsFloat := (lMemTable.FieldByName('VALOR_LIQUIDO').AsFloat / lTotalVendas) * 100
    else
    if (pCurvaABC_Parametros.ClassificarPor = tpABCCusto) and (lTotalCusto <> 0) then
      lMemTable.FieldByName('RATEIO').AsFloat := (lMemTable.FieldByName('CUSTO').AsFloat / lTotalCusto) * 100
    else
    if (pCurvaABC_Parametros.ClassificarPor = tpABCLucro) and (lTotalLucro <> 0) then
      lMemTable.FieldByName('RATEIO').AsFloat := (lMemTable.FieldByName('LUCRO').AsFloat / lTotalLucro) * 100
    else
      lMemTable.FieldByName('RATEIO').AsFloat := 0;


    if (pCurvaABC_Parametros.TipoMargem = 'S') then
    begin
      if (lMemTable.FieldByName('CUSTO').AsFloat <> 0) then
        lMemTable.FieldByName('MARGEM').AsFloat := (lMemTable.FieldByName('VALOR_LIQUIDO').AsFloat / lMemTable.FieldByName('CUSTO').AsFloat*100)-100
      else
        lMemTable.FieldByName('MARGEM').AsFloat := 0;
    end else
    begin
      if (lMemTable.FieldByName('VALOR_LIQUIDO').AsFloat <> 0) then
        lMemTable.FieldByName('MARGEM').AsFloat := -1 * ((lMemTable.FieldByName('CUSTO').AsFloat * 100 / lMemTable.FieldByName('VALOR_LIQUIDO').AsFloat) - 100)
      else
        lMemTable.FieldByName('MARGEM').AsFloat := 0;
    end;

    lMemTable.Next;
  end;

  lMemTable.IndexName := 'OrdenacaoRateio';
  lMemTable.Open;
  Result := criaIFDDataset(lMemTable);

end;

procedure TCurvaABCDao.DefineDadosSelect(Acao: TTipoAnaliseCurvaABC; pCurvaABC_Parametros: TCurvaABC_Parametros);
begin
  lTabelaPedido    := 'pedidovenda v                                                                         ' + #13 +
                      '                inner join pedidoitens i    on i.numero_ped   = v.numero_ped          ' + #13 +
                      '                left  join produto p        on p.codigo_pro   = i.codigo_pro          ' + #13 +
                      '                left  join fornecedor f     on f.codigo_for   = p.codigo_for          ' + #13 +
                      '                left  join funcionario fu   on fu.codigo_fun  = v.codigo_ven          ' + #13 +
                      '                left  join grupoproduto gp  on gp.codigo_gru  = p.codigo_gru          ' + #13 +
                      '                left  join clientes cl      on cl.codigo_cli  = v.codigo_cli          ' + #13 +
                      '                left  join grupo_comissao g on g.id           = p.grupo_comissao_id   ' + #13 +
                      '                left  join portador po      on po.codigo_port = v.codigo_port         ' + #13 +
                      '                left  join marcaproduto m   on m.codigo_mar   = p.codigo_mar          ' + #13;

  lTabelaOS        := 'os v                                                                                  ' + #13 +
                      '                inner join ositens i        on i.numero_os    = v.numero_os           ' + #13 +
                      '                left  join produto p        on p.codigo_pro   = i.codigo_pro          ' + #13 +
                      '                left  join fornecedor f     on f.codigo_for   = p.codigo_for          ' + #13 +
                      '                left  join funcionario fu   on fu.codigo_fun  = i.vendedor_id         ' + #13 +
                      '                left  join grupoproduto gp  on gp.codigo_gru  = p.codigo_gru          ' + #13 +
                      '                left  join clientes cl      on cl.codigo_cli  = v.codigo_cli          ' + #13 +
                      '                left  join grupo_comissao g on g.id           = p.grupo_comissao_id   ' + #13 +
                      '                left  join portador po      on po.codigo_port = v.entrada_portador_id ' + #13 +
                      '                left  join marcaproduto m   on m.codigo_mar   = p.codigo_mar          ' + #13;

  lTabelaDevolucao := 'devolucao v                                                                           ' + #13 +
                      '                left  join devolucaoitens i on i.id           = v.id                  ' + #13 +
                      '                left  join produto p        on p.codigo_pro   = i.produto             ' + #13 +
                      '                left  join fornecedor f     on f.codigo_for   = p.codigo_for          ' + #13 +
                      '                left  join funcionario fu   on fu.codigo_fun  = v.vendedor            ' + #13 +
                      '                left  join grupoproduto gp  on gp.codigo_gru  = p.codigo_gru          ' + #13 +
                      '                left  join clientes cl      on cl.codigo_cli  = v.cliente             ' + #13 +
                      '                left  join grupo_comissao g on g.id           = p.grupo_comissao_id   ' + #13 +
                      '                left  join portador po      on po.codigo_port = v.portador_id         ' + #13 +
                      '                left  join marcaproduto m   on m.codigo_mar   = p.codigo_mar          ' + #13 +
                      '                left  join pedidovenda pv   on pv.numero_ped  = v.pedido              ' + #13 +
                      '                left  join pedidoitens pi   on pi.numero_ped  = pv.numero_ped and     ' + #13 +
                      '                                               pi.codigo_pro  = i.produto             ' + #13;

  lTabelaEntrada   := 'entrada e                                                                             ' + #13 +
                      '                inner join pedidovenda v    on v.numero_ped   = e.devolucao_pedido_id ' + #13 +
                      '                left  join entradaitens i   on i.numero_ent   = e.numero_ent and      ' + #13 +
                      '                                               i.codigo_for   = e.codigo_for          ' + #13 +
                      '                left  join produto p        on p.codigo_pro   = i.codigo_pro          ' + #13 +
                      '                left  join fornecedor f     on f.codigo_for   = p.codigo_for          ' + #13 +
                      '                left  join funcionario fu   on fu.codigo_fun  = v.codigo_ven          ' + #13 +
                      '                left  join grupoproduto gp  on gp.codigo_gru  = p.codigo_gru          ' + #13 +
                      '                left  join clientes cl      on cl.codigo_cli  = v.codigo_cli          ' + #13 +
                      '                left  join grupo_comissao g on g.id           = p.grupo_comissao_id   ' + #13 +
                      '                left  join portador po      on po.codigo_port = v.codigo_port         ' + #13 +
                      '                left  join marcaproduto m   on m.codigo_mar   = p.codigo_mar          ' + #13;

  lNomeCampo        := '';
  lNomeCampoOS      := '';
  lNomeCampoDev     := '';
  lNomeCampoEntrada := '';

  case Acao of

    tpABCVendedores:
      begin
        lNomeCampo       := 'fu.codigo_fun CODIGO, fu.nome_fun DESCRICAO';
      end;

    tpABCClientes:
      begin
        lNomeCampo :=       'cl.codigo_cli CODIGO, cl.fantasia_cli DESCRICAO';
      end;

    tpABCProdutos:
      begin
        lNomeCampo :=       'p.codigo_pro CODIGO, p.nome_pro DESCRICAO';
      end;

    tpABCGrupo:
      begin
        lNomeCampo :=       'gp.codigo_gru CODIGO, gp.nome_gru DESCRICAO';
      end;

    tpABCGrupoComissao:
      begin
        lNomeCampo :=       'g.id CODIGO, g.nome DESCRICAO';
      end;

    tpABCPortador:
      begin
        lNomeCampo :=       'po.codigo_port CODIGO, po.nome_port DESCRICAO';
      end;

    tpABCFornecedor:
      begin
        lNomeCampo :=       'f.codigo_for CODIGO, f.fantasia_for DESCRICAO';
      end;

    tpABCDia:
      begin
        lNomeCampo        := 'v.data_ped CODIGO, v.data_ped DESCRICAO ';
        lNomeCampoOS      := 'v.fechamento_os CODIGO, v.fechamento_os DESCRICAO ';
        lNomeCampoDev     := 'v.data CODIGO, v.data DESCRICAO ';
        lNomeCampoEntrada := 'e.datamovi_ent CODIGO, e.datamovi_ent DESCRICAO ';
      end;

    tpABCMes:
      begin
        lNomeCampo        := 'RIGHT(''0'' || extract(month from v.data_ped), 2) CODIGO, RIGHT(''0'' || extract(month from v.data_ped), 2) DESCRICAO ';
        lNomeCampoOS      := 'RIGHT(''0'' || extract(month from v.fechamento_os), 2) CODIGO, RIGHT(''0'' || extract(month from v.fechamento_os), 2) DESCRICAO ';
        lNomeCampoDev     := 'RIGHT(''0'' || extract(month from v.data), 2) CODIGO, RIGHT(''0'' || extract(month from v.data), 2) DESCRICAO ';
        lNomeCampoEntrada := 'RIGHT(''0'' || extract(month from e.datamovi_ent), 2) CODIGO, RIGHT(''0'' || extract(month from e.datamovi_ent), 2) DESCRICAO ';
      end;

    tpABCMarca:
      begin
        lNomeCampo :=       'm.codigo_mar CODIGO, m.nome_mar DESCRICAO';
      end;

    tpABCUF:
      begin
        lNomeCampo :=       'cl.uf_cli CODIGO, cl.uf_cli DESCRICAO';
      end;
  end;

  // Filtros Selecionados
  lFiltro := '';


  if pCurvaABC_Parametros.Vendedor <> '' then
    lFiltro := lFiltro + ' and fu.codigo_fun in (' + pCurvaABC_Parametros.Vendedor + ')';

  if pCurvaABC_Parametros.Fornecedor <> '' then
    lFiltro := lFiltro + ' and f.codigo_for in (' + pCurvaABC_Parametros.Fornecedor + ')';

  if pCurvaABC_Parametros.Grupo <> '' then
    lFiltro := lFiltro + ' and gp.codigo_gru in (' + pCurvaABC_Parametros.Grupo + ')';

  if pCurvaABC_Parametros.SubGrupo <> '' then
    lFiltro := lFiltro + ' and p.codigo_sub in (' + pCurvaABC_Parametros.SubGrupo + ')';

  if pCurvaABC_Parametros.Marca <> '' then
    lFiltro := lFiltro + ' and m.codigo_mar in (' + pCurvaABC_Parametros.Marca + ')';

  // Fim Filtros Selecionados
end;

end.
