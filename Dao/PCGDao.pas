unit PCGDao;

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
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  LojasModel;

type
  TPCGDao = class;
  ITPCGDao=IObject<TPCGDao>;

  TPCGDao = class
  private
    [weak] mySelf: ITPCGDao;
    vIConexao : IConexao;

    vNomeCampo, vNomeCampoOS, vNomeCampoDev, vNomeCampoEntrada : String;
    vTabelaPedido, vTabelaOS, vTabelaDevolucao, vTabelaEntrada : String;
    vFiltro : String;

    procedure DefineDadosSelectVendas(Acao: TTipoAnalisePCG; pPCG_Parametros: TPCG_Parametros);
    procedure DefineDadosSelectEstoque(Acao: TTipoAnaliseEstoquePCG; pPCG_Parametros: TPCG_Parametros);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPCGDao;

    function ObterVendasResultado1(pPCG_Parametros: TPCG_Parametros): IFDDataset;
    function ObterVendasResultado2(pPCG_Parametros: TPCG_Parametros): IFDDataset;
    function ObterEstoqueResultado1(pPCG_Parametros: TPCG_Parametros): IFDDataset;

end;

implementation

uses
  Interfaces.QueryLojaAsync,
  Data.DB,
  PCGModel,
  Clipbrd;

{ TPCG }

constructor TPCGDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPCGDao.Destroy;
begin
  inherited;
end;

class function TPCGDao.getNewIface(pIConexao: IConexao): ITPCGDao;
begin
  Result := TImplObjetoOwner<TPCGDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPCGDao.ObterVendasResultado1(pPCG_Parametros: TPCG_Parametros): IFDDataset;
var
  lSQL:String;
  lMemTable: TFDMemTable;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin

  lAsyncList := getQueryLojaAsyncList(vIConexao,pPCG_Parametros.Lojas);

  lMemTable   := TFDMemTable.Create(nil);
  Result := criaIFDDataset(lMemTable);

  Self.DefineDadosSelectVendas(pPCG_Parametros.TipoAnalise, pPCG_Parametros);

  lSQL := 'select                                                                                                                                                 ' + #13 +
          '    CODIGO,                                                                                                                                            ' + #13 +
          '    DESCRICAO,                                                                                                                                         ' + #13 +
          '    VALOR_LIQUIDO,                                                                                                                                     ' + #13 +
          '    ACRESCIMO,                                                                                                                                         ' + #13 +
          '    FRETE,                                                                                                                                             ' + #13 +
          '    IPI,                                                                                                                                               ' + #13 +
          '    ST                                                                                                                                                 ' + #13 +
          '																																					                                                                              ' + #13 +
          'from                                                                                                                                                   ' + #13 +
          '(                                                                                                                                                      ' + #13 +
          '																																					                                                                              ' + #13 +
          '    select                                                                                                                                             ' + #13 +
          '        CODIGO,                                                                                                                                        ' + #13 +
          '        DESCRICAO,                                                                                                                                     ' + #13 +
          '        sum(valor_produto-desconto) VALOR_LIQUIDO,                                                                                                     ' + #13 +
          '        sum(acrescimo) ACRESCIMO,                                                                                                                      ' + #13 +
          '        sum(frete) FRETE,                                                                                                                              ' + #13 +
          '        sum(ipi) IPI,                                                                                                                                  ' + #13 +
          '        sum(st) ST                                                                                                                                     ' + #13 +
          '																																					                                                                              ' + #13 +
          '    from                                                                                                                                               ' + #13 +
          '    (                                                                                                                                                  ' + #13 +
          '       select                                                                                                                                          ' + #13 +
          '            v.data_ped DATA_EMISSAO,                                                                                                                   ' + #13 +
          '            v.data_faturado DATA_FATURADO,                                                                                                             ' + #13 +
          '            ' + vNomeCampo + ',                                                                                                                        ' + #13 +
          '            (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                                    ' + #13 +
          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                                     ' + #13 +
          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,                                   ' + #13 +
          '            ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                                       ' + #13 +
          '            i.valor_ipi IPI,                                                                                                                           ' + #13 +
          '            i.valor_st ST                                                                                                                              ' + #13 +
          '																																					                                                                              ' + #13 +
          '        from                                                                                                                                           ' + #13 +
          '            ' + vTabelaPedido + '                                                                                                                      ' + #13 +
          '																																					                                                                              ' + #13 +
          '        where                                                                                                                                          ' + #13 +
          '            coalesce(v.valor_ped,0) > 0                                                                                                                ' + #13 +
          '            and coalesce(v.status,''P'') in (''P'',''F'')                                                                                              ' + #13 +
          '            ' + vFiltro + '                                                                                                                            ' + #13 +
          '																																					                                                                              ' + #13 +
          '        union all                                                                                                                                      ' + #13 +
          '																																					                                                                              ' + #13 +
          '        select                                                                                                                                         ' + #13 +
          '            v.fechamento_os DATA_EMISSAO,                                                                                                              ' + #13 +
          '            v.fechamento_os DATA_FATURADO,                                                                                                             ' + #13 +
          '            ' + IIF(vNomeCampoOS <> '', vNomeCampoOS, vNomeCampo) + ',                                                                                 ' + #13 +
          '            (i.valorunitario_os*i.quantidade_pro) VALOR_PRODUTO,                                                                                       ' + #13 +
          '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.desc_os as float) DESCONTO,                           ' + #13 +
          '            ((i.valorunitario_os*i.quantidade_pro)/(v.total_os+v.desc_os-v.acrescimo_os))*cast(v.acrescimo_os as float) ACRESCIMO,                     ' + #13 +
          '            0 FRETE,                                                                                                                                   ' + #13 +
          '            0 IPI,                                                                                                                                     ' + #13 +
          '            0 ST                                                                                                                                       ' + #13 +
          '																																					                                                                              ' + #13 +
          '        from                                                                                                                                           ' + #13 +
          '            ' + vTabelaOS + '                                                                                                                          ' + #13 +
          '																																					                                                                              ' + #13 +
          '        where                                                                                                                                          ' + #13 +
          '            coalesce(v.status_os,''F'') = ''F''                                                                                                        ' + #13 +
          '            and coalesce(v.total_os, 0) > 0                                                                                                            ' + #13 +
          '            ' + vFiltro + '                                                                                                                            ' + #13 +
          '																																					                                                                              ' + #13 +
          '        union all                                                                                                                                      ' + #13 +
          '																																					                                                                              ' + #13 +
          '        select                                                                                                                                         ' + #13 +
          '            v.data DATA_EMISSAO,                                                                                                                       ' + #13 +
          '            v.data DATA_FATURADO,                                                                                                                      ' + #13 +
          '            ' + IIF(vNomeCampoDev <> '', vNomeCampoDev, vNomeCampo) + ',                                                                               ' + #13 +
          '            (i.quantidade*i.valor_unitario) *-1 VALOR_PRODUTO,                                                                                         ' + #13 +
          '            ((i.quantidade*i.valor_unitario)/(v.valor_total+v.desconto-v.valor_acrescimo))*coalesce(cast(v.desconto as float),0) *-1 DESCONTO,         ' + #13 +
          '            ((i.quantidade*i.valor_unitario)/(v.valor_total+v.desconto-v.valor_acrescimo))*coalesce(cast(v.valor_acrescimo as float),0) *-1 ACRESCIMO, ' + #13 +
          '            0 FRETE,                                                                                                                                   ' + #13 +
          '            0 IPI,                                                                                                                                     ' + #13 +
          '            0 ST                                                                                                                                       ' + #13 +
          '																																					                                                                              ' + #13 +
          '        from                                                                                                                                           ' + #13 +
          '            ' + vTabelaDevolucao + '                                                                                                                   ' + #13 +
          '																																					                                                                              ' + #13 +
          '        where                                                                                                                                          ' + #13 +
          '            coalesce(v.valor_total,0) > 0                                                                                                              ' + #13 +
          '            ' + vFiltro + '                                                                                                                            ' + #13 +
          '																																					                                                                              ' + #13 +
          '        union all                                                                                                                                      ' + #13 +
          '																																					                                                                              ' + #13 +
          '        select                                                                                                                                         ' + #13 +
          '            e.datamovi_ent DATA_EMISSAO,                                                                                                               ' + #13 +
          '            e.datamovi_ent DATA_FATURADO,                                                                                                              ' + #13 +
          '            ' + IIF(vNomeCampoEntrada <> '', vNomeCampoEntrada, vNomeCampo) + ',                                                                       ' + #13 +
          '            coalesce(e.TOTAL_ENT,0)*-1 VALOR_PRODUTO,                                                                                                  ' + #13 +
          '            0 DESCONTO,                                                                                                                                ' + #13 +
          '            0 ACRESCIMO,                                                                                                                               ' + #13 +
          '            0 FRETE,                                                                                                                                   ' + #13 +
          '            0 IPI,                                                                                                                                     ' + #13 +
          '            0 ST                                                                                                                                       ' + #13 +
          '																																					                                                                              ' + #13 +
          '        from                                                                                                                                           ' + #13 +
          '            ' + vTabelaEntrada + '                                                                                                                     ' + #13 +
          '																																					                                                                              ' + #13 +
          '        where                                                                                                                                          ' + #13 +
          '            coalesce(e.TOTAL_ENT,0) > 0                                                                                                                ' + #13 +
          '            ' + vFiltro + '                                                                                                                            ' + #13 +
          '																																		 			                                                                              ' + #13 +
          '    ) resultado                                                                                                                                        ' + #13 +
          '																																					                                                                              ' + #13 +
          '    where                                                                                                                                              ' + #13 +
          '        resultado.' + ifThen(pPCG_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pPCG_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pPCG_Parametros.DataFim)) + #13 +
          '																																					                                                                              ' + #13 +
          '    group by 1, 2                                                                                                                                      ' + #13 +
          '    order by 2                                                                                                                                         ' + #13 +
          '																																					                                                                              ' + #13 +
          ')																																					                                                                            ' + #13;

  gravaSQL(lSQL, 'PCGDao_ObterVendasResultado1_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  with lMemTable.IndexDefs.AddIndexDef do
  begin
    Name := 'OrdenacaoDescricao';
    Fields := 'DESCRICAO'; //pPCG_Parametros.ColunaOrdenacao;
    Options := [TIndexOption.ixCaseInsensitive];
//      if pPCG_Parametros.ColunaOrdenacaoOrdem = 'Asc' then Options := [TIndexOption.ixCaseInsensitive]
//      else Options := [TIndexOption.ixDescending, TIndexOption.ixCaseInsensitive];
  end;

  lMemTable.IndexName := 'OrdenacaoDescricao';

  lMemTable.FieldDefs.Add('LOJA', ftString, 3);
  lMemTable.FieldDefs.Add('CODIGO', ftString, 100);
  lMemTable.FieldDefs.Add('DESCRICAO', ftString, 100);
  lMemTable.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
  lMemTable.FieldDefs.Add('ACRESCIMO', ftFloat);
  lMemTable.FieldDefs.Add('FRETE', ftFloat);
  lMemTable.FieldDefs.Add('IPI', ftFloat);
  lMemTable.FieldDefs.Add('ST', ftFloat);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.tag := 'ObterVendasResultado1';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TDashbordDao.ObterVendasResultado1: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.espera;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TDashbordDao.ObterVendasResultado1: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lMemTable.InsertRecord([
                              lQA.loja.objeto.LOJA,
                              lQA.dataset.dataset.FieldByName('CODIGO').AsString,
                              lQA.dataset.dataset.FieldByName('DESCRICAO').AsString,
                              lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat,
                              lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat,
                              lQA.dataset.dataset.FieldByName('FRETE').AsFloat,
                              lQA.dataset.dataset.FieldByName('IPI').AsFloat,
                              lQA.dataset.dataset.FieldByName('ST').AsFloat
                             ]);

      lQA.dataset.dataset.Next;
    end;

  end;

  lMemTable.Open;

end;

function TPCGDao.ObterVendasResultado2(pPCG_Parametros: TPCG_Parametros): IFDDataset;
var
  lSQL              : String;
  lMemTable         : TFDMemTable;
  lValorPossivel    : Real;
  lPercentual       : Real;

  lCodigo           : String;
  lDescricao        : String;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;

begin

  lAsyncList := getQueryLojaAsyncList(vIConexao,pPCG_Parametros.Lojas);

  lMemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(lMemTable);

  Self.DefineDadosSelectVendas(pPCG_Parametros.TipoAnalise, pPCG_Parametros);

  lSQL := 'select                                                                                                                                 ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, '    CODIGO,    ', '') + '                                                                 ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, '    DESCRICAO, ', '') + '                                                                 ' + #13 +
          '    VALOR_LIQUIDO,                                                                                                                     ' + #13 +
          '    ACRESCIMO,                                                                                                                         ' + #13 +
          '    FRETE,                                                                                                                             ' + #13 +
          '    IPI,                                                                                                                               ' + #13 +
          '    ST,                                                                                                                                ' + #13 +
          '    VALOR_TOTAL,                                                                                                                       ' + #13 +
          '    QUANTIDADE_VENDA,                                                                                                                  ' + #13 +
          '    TICKET_MEDIO,                                                                                                                      ' + #13 +
          '    TOTAL_ITENS,                                                                                                                       ' + #13 +
          '    QUANTIDADE_MEDIA_ITENS,                                                                                                            ' + #13 +
          '    VALOR_MEDIA_ITENS,                                                                                                                 ' + #13 +
          '    VALOR_POSSIVEL,                                                                                                                    ' + #13 +
          '    DIFERENCA                                                                                                                          ' + #13 +
          '    --,PERCENTUAL                                                                                                                      ' + #13 +
          'from                                                                                                                                   ' + #13 +
          '(                                                                                                                                      ' + #13 +
          '    select                                                                                                                             ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, '    CODIGO,    ', '') + '                                                                 ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, '    DESCRICAO, ', '') + '                                                                 ' + #13 +
          '        VALOR_LIQUIDO,                                                                                                                 ' + #13 +
          '        VALOR_PRODUTO,                                                                                                                 ' + #13 +
          '        VALOR_POSSIVEL,                                                                                                                ' + #13 +
          '        DESCONTO,                                                                                                                      ' + #13 +
          '        ACRESCIMO,                                                                                                                     ' + #13 +
          '        FRETE,                                                                                                                         ' + #13 +
          '        IPI,                                                                                                                           ' + #13 +
          '        ST,                                                                                                                            ' + #13 +
          '        CUSTO,                                                                                                                         ' + #13 +
          '        TOTAL_ITENS,                                                                                                                   ' + #13 +
          '        (valor_liquido+acrescimo) VALOR_TOTAL,                                                                                         ' + #13 +
          '        (valor_liquido/quantidade_venda) TICKET_MEDIO,                                                                                 ' + #13 +
          '        (total_itens/quantidade_venda) QUANTIDADE_MEDIA_ITENS,                                                                         ' + #13 +
          '        case when total_itens = 0 then (valor_liquido/ 1) else (valor_liquido/ total_itens) end VALOR_MEDIA_ITENS,                     ' + #13 +
//          '        (valor_liquido/total_itens) VALOR_MEDIA_ITENS,                                                                                 ' + #13 +
          '        (valor_liquido-valor_possivel) DIFERENCA,                                                                                      ' + #13 +
          '        QUANTIDADE_VENDA,                                                                                                              ' + #13 +
          '        CLIENTE                                                                                                                        ' + #13 +
          '    from                                                                                                                               ' + #13 +
          '    (                                                                                                                                  ' + #13 +
          '        select                                                                                                                         ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, '    CODIGO,    ', '') + '                                                                 ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, '    DESCRICAO, ', '') + '                                                                 ' + #13 +
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
          '            count(distinct(quantidade_venda)) QUANTIDADE_VENDA,                                                                        ' + #13 +
          '            count(distinct(cliente)) CLIENTE                                                                                           ' + #13 +
          '        from                                                                                                                           ' + #13 +
          '        (                                                                                                                              ' + #13 +
          '           select                                                                                                                      ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, vNomeCampo + ', ', '') + '                                                                 ' + #13 +
          '                v.data_ped DATA_EMISSAO,                                                                                               ' + #13 +
          '                v.data_faturado DATA_FATURADO,                                                                                         ' + #13 +
          '                (i.valorunitario_ped * i.qtde_calculada) VALOR_PRODUTO,                                                                ' + #13 +
          '                (i.vlrvenda_pro * i.qtde_calculada) VALOR_POSSIVEL,                                                                    ' + #13 +
          '                ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.desc_ped as float),0) DESCONTO,                 ' + #13 +
          '                ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.acres_ped as float),0) ACRESCIMO,               ' + #13 +
          '                ((i.valorunitario_ped * i.qtde_calculada)/v.valor_ped)*coalesce(cast(v.frete_ped as float),0) FRETE,                   ' + #13 +
          '                i.valor_ipi IPI,                                                                                                       ' + #13 +
          '                i.valor_st ST,                                                                                                         ' + #13 +
          '                coalesce(i.vlrcusto_pro,0) * coalesce(i.qtde_calculada,0) CUSTO,                                                       ' + #13 +
          '                coalesce(i.qtde_calculada, 0) TOTAL_ITENS,                                                                             ' + #13 +
          '                v.numero_ped || ''P'' QUANTIDADE_VENDA,                                                                                ' + #13 +
          '                v.codigo_cli CLIENTE,                                                                                                  ' + #13 +
          '                '' '' ITEM                                                                                                             ' + #13 +
          '            from                                                                                                                       ' + #13 +
          '                ' + vTabelaPedido + '                                                                                                  ' + #13 +
          '            where                                                                                                                      ' + #13 +
          '                coalesce(v.valor_ped,0) > 0                                                                                            ' + #13 +
          '                and coalesce(v.status, ''P'') in (''P'', ''F'')                                                                        ' + #13 +
          '            ' + vFiltro + '                                                                                                            ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            union all                                                                                                                  ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            select                                                                                                                     ' + #13 +
          '                distinct                                                                                                               ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, IIF(vNomeCampoDev <> '', vNomeCampoDev, vNomeCampo) + ', ', '') + '                        ' + #13 +
          '                v.data DATA_EMISSAO,                                                                                                   ' + #13 +
          '                v.data DATA_FATURADO,                                                                                                  ' + #13 +
          '                (i.valor_unitario*i.quantidade) *-1 VALOR_PRODUTO,                                                                     ' + #13 +
          '                (pi.vlrvenda_pro*i.quantidade) *-1 VALOR_CADASTRO,                                                                     ' + #13 +
          '                ((i.quantidade*i.valor_unitario)/(v.valor_total+v.desconto-v.valor_acrescimo))*coalesce(cast(v.desconto as float),0) *-1 DESCONTO,         ' + #13 +
          '                ((i.quantidade*i.valor_unitario)/(v.valor_total+v.desconto-v.valor_acrescimo))*coalesce(cast(v.valor_acrescimo as float),0) *-1 ACRESCIMO, ' + #13 +
          '                0 FRETE,                                                                                                               ' + #13 +
          '                0 IPI,                                                                                                                 ' + #13 +
          '                0 ST,                                                                                                                  ' + #13 +
          '                0 CUSTO,                                                                                                               ' + #13 +
          '                i.quantidade * -1 TOTAL_ITENS,                                                                                         ' + #13 +
          '                0 QUANTIDADE_VENDA,                                                                                                    ' + #13 +
          '                0 CLIENTE,                                                                                                             ' + #13 +
          '                i.item ITEM                                                                                                            ' + #13 +
          '            from                                                                                                                       ' + #13 +
          '                ' + vTabelaDevolucao + '                                                                                               ' + #13 +
          '            where                                                                                                                      ' + #13 +
          '                coalesce(v.valor_total,0) > 0                                                                                          ' + #13 +
          '                ' + vFiltro + '                                                                                                        ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            union all                                                                                                                  ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            select                                                                                                                     ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, IIF(vNomeCampoEntrada <> '', vNomeCampoEntrada, vNomeCampo) + ', ', '') + '                ' + #13 +
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
          '                0 QUANTIDADE_VENDA,                                                                                                 ' + #13 +
          '                0 CLIENTE,                                                                                                          ' + #13 +
          '                '' '' ITEM                                                                                                             ' + #13 +
          '            from                                                                                                                       ' + #13 +
          '                ' + vTabelaEntrada + '                                                                                                 ' + #13 +
          '            where                                                                                                                      ' + #13 +
          '                coalesce(e.TOTAL_ENT,0) > 0                                                                                            ' + #13 +
          '                ' + vFiltro + '                                                                                                        ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            union all                                                                                                                  ' + #13 +
          '                                                                                                                                       ' + #13 +
          '            select                                                                                                                     ' + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, IIF(vNomeCampoOS <> '', vNomeCampoOS, vNomeCampo) + ', ', '') + '                          ' + #13 +
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
          '                ' + vTabelaOS + '                                                                                                      ' + #13 +
          '            where                                                                                                                      ' + #13 +
          '                coalesce(v.status_os, ''F'') = ''F'' and                                                                               ' + #13 +
          '                coalesce(v.total_os, 0) > 0                                                                                            ' + #13 +
          '                ' + vFiltro + '                                                                                                        ' + #13 +
          '        ) resultado                                                                                                                    ' + #13 +
          '                                                                                                                                       ' + #13 +
          '        where                                                                                                                          ' + #13 +
          '            resultado.' + ifThen(pPCG_Parametros.TipoData = 'EMISSÃO', 'data_emissao', 'data_faturado') + ' between ' + QuotedStr(transformaDataFireBirdWhere(pPCG_Parametros.DataInicio)) + ' and ' + QuotedStr(transformaDataFireBirdWhere(pPCG_Parametros.DataFim)) + #13 +
          IIF(pPCG_Parametros.TipoAnalise <> tpFilial, '        group by 1, 2 ', '') + '                                                          ' + #13 +
          '    )                                                                                                                                  ' + #13 +
          ')                                                                                                                                      ';

  gravaSQL(lSQL, 'PCGDao_ObterVendasResultado2_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  with lMemTable.IndexDefs.AddIndexDef do
  begin
    Name := 'OrdenacaoDescricao';
    Fields := 'DESCRICAO'; //pPCG_Parametros.ColunaOrdenacao;
    Options := [TIndexOption.ixCaseInsensitive];
//      if pPCG_Parametros.ColunaOrdenacaoOrdem = 'Asc' then Options := [TIndexOption.ixCaseInsensitive]
//      else Options := [TIndexOption.ixDescending, TIndexOption.ixCaseInsensitive];
  end;

  lMemTable.IndexName := 'OrdenacaoDescricao';

  lMemTable.FieldDefs.Add('LOJA', ftString, 6);
  lMemTable.FieldDefs.Add('CODIGO', ftString, 100);
  lMemTable.FieldDefs.Add('DESCRICAO', ftString, 100);

  lMemTable.FieldDefs.Add('VALOR_VENDA', ftFloat);
  lMemTable.FieldDefs.Add('VALOR_DF', ftFloat);
  lMemTable.FieldDefs.Add('VALOR_TOTAL', ftFloat);

  lMemTable.FieldDefs.Add('VENDA_QUANTIDADE', ftFloat);
  lMemTable.FieldDefs.Add('VENDA_MEDIA', ftFloat);

  lMemTable.FieldDefs.Add('ITENS_QTDE', ftFloat);
  lMemTable.FieldDefs.Add('ITENS_MEDIA', ftFloat);
  lMemTable.FieldDefs.Add('ITENS_VALOR_MEDIO', ftFloat);

  lMemTable.FieldDefs.Add('DC_POSSIVEL', ftFloat);
  lMemTable.FieldDefs.Add('DC_DIFERENCA', ftFloat);
  lMemTable.FieldDefs.Add('DC_PERCENTUAL', ftFloat);

  lMemTable.FieldDefs.Add('FRETE', ftFloat);
  lMemTable.FieldDefs.Add('IPI', ftFloat);
  lMemTable.FieldDefs.Add('ST', ftFloat);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.tag := 'TPCGDao.PCGDao_ObterVendasResultado2';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TPCGDao.PCGDao_ObterVendasResultado2_: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.espera;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TPCGDao.PCGDao_ObterVendasResultado2_: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lValorPossivel := 0;
      lPercentual    := 0;

      if lQA.dataset.dataset.FieldByName('VALOR_POSSIVEL').AsFloat <> 0 then
      begin
        lValorPossivel := lQA.dataset.dataset.FieldByName('VALOR_POSSIVEL').AsFloat;
        lPercentual    := ((lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat / lValorPossivel)*100)-100
      end;

      if pPCG_Parametros.TipoAnalise = tpFilial then
      begin
        lCodigo    := lQA.loja.objeto.LOJA;
        lDescricao := lQA.loja.objeto.DESCRICAO;
      end
      else
      begin
        lCodigo    := lQA.dataset.dataset.FieldByName('CODIGO').AsString;
        lDescricao := Trim(lQA.dataset.dataset.FieldByName('DESCRICAO').AsString);
      end;

      lMemTable.InsertRecord([
                              lQA.loja.objeto.LOJA,
                              lCodigo,
                              lDescricao,

                              lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat,
                              lQA.dataset.dataset.FieldByName('ACRESCIMO').AsFloat,
                              lQA.dataset.dataset.FieldByName('VALOR_TOTAL').AsFloat,

                              lQA.dataset.dataset.FieldByName('QUANTIDADE_VENDA').AsFloat,
                              lQA.dataset.dataset.FieldByName('TICKET_MEDIO').AsFloat,

                              lQA.dataset.dataset.FieldByName('TOTAL_ITENS').AsFloat,
                              lQA.dataset.dataset.FieldByName('QUANTIDADE_MEDIA_ITENS').AsFloat,
                              lQA.dataset.dataset.FieldByName('VALOR_MEDIA_ITENS').AsFloat,

                              lValorPossivel,
                              lQA.dataset.dataset.FieldByName('DIFERENCA').AsFloat,
                              lPercentual,

                              lQA.dataset.dataset.FieldByName('FRETE').AsFloat,
                              lQA.dataset.dataset.FieldByName('IPI').AsFloat,
                              lQA.dataset.dataset.FieldByName('ST').AsFloat
                             ]);

      lQA.dataset.dataset.Next;
    end;

  end;

  lMemTable.Open;

end;

procedure TPCGDao.DefineDadosSelectVendas(Acao: TTipoAnalisePCG; pPCG_Parametros: TPCG_Parametros);
begin
  vTabelaPedido    := 'pedidovenda v                                                                         ' + #13 +
                      '                inner join pedidoitens i    on i.numero_ped   = v.numero_ped          ' + #13 +
                      '                left  join produto p        on p.codigo_pro   = i.codigo_pro          ' + #13 +
                      '                left  join fornecedor f     on f.codigo_for   = p.codigo_for          ' + #13 +
                      '                left  join funcionario fu   on fu.codigo_fun  = v.codigo_ven          ' + #13 +
                      '                left  join grupoproduto gp  on gp.codigo_gru  = p.codigo_gru          ' + #13 +
                      '                left  join clientes cl      on cl.codigo_cli  = v.codigo_cli          ' + #13 +
                      '                left  join grupo_comissao g on g.id           = p.grupo_comissao_id   ' + #13 +
                      '                left  join portador po      on po.codigo_port = v.codigo_port         ' + #13 +
                      '                left  join marcaproduto m   on m.codigo_mar   = p.codigo_mar          ' + #13;

  vTabelaOS        := 'os v                                                                                  ' + #13 +
                      '                inner join ositens i        on i.numero_os    = v.numero_os           ' + #13 +
                      '                left  join produto p        on p.codigo_pro   = i.codigo_pro          ' + #13 +
                      '                left  join fornecedor f     on f.codigo_for   = p.codigo_for          ' + #13 +
                      '                left  join funcionario fu   on fu.codigo_fun  = i.vendedor_id         ' + #13 +
                      '                left  join grupoproduto gp  on gp.codigo_gru  = p.codigo_gru          ' + #13 +
                      '                left  join clientes cl      on cl.codigo_cli  = v.codigo_cli          ' + #13 +
                      '                left  join grupo_comissao g on g.id           = p.grupo_comissao_id   ' + #13 +
                      '                left  join portador po      on po.codigo_port = v.entrada_portador_id ' + #13 +
                      '                left  join marcaproduto m   on m.codigo_mar   = p.codigo_mar          ' + #13;

  vTabelaDevolucao := 'devolucao v                                                                           ' + #13 +
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

  vTabelaEntrada   := 'entrada e                                                                             ' + #13 +
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

  vNomeCampo        := '';
  vNomeCampoOS      := '';
  vNomeCampoDev     := '';
  vNomeCampoEntrada := '';

  case Acao of

    tpVendedores:
      begin
        vNomeCampo       := 'fu.codigo_fun CODIGO, fu.nome_fun DESCRICAO';
      end;

    tpClientes:
      begin
        vNomeCampo :=       'cl.codigo_cli CODIGO, cl.fantasia_cli DESCRICAO';
      end;

    tpProdutos:
      begin
        vNomeCampo :=       'p.codigo_pro CODIGO, p.nome_pro DESCRICAO';
      end;

    tpGrupo:
      begin
        vNomeCampo :=       'gp.codigo_gru CODIGO, gp.nome_gru DESCRICAO';
      end;

    tpGrupoComissao:
      begin
        vNomeCampo :=       'g.id CODIGO, g.nome DESCRICAO';
      end;

    tpPortador:
      begin
        vNomeCampo :=       'po.codigo_port CODIGO, po.nome_port DESCRICAO';
      end;

    tpFornecedor:
      begin
        vNomeCampo :=       'f.codigo_for CODIGO, f.fantasia_for DESCRICAO';
      end;

    tpDia:
      begin
        vNomeCampo        := 'v.data_ped CODIGO, v.data_ped DESCRICAO ';
        vNomeCampoOS      := 'v.fechamento_os CODIGO, v.fechamento_os DESCRICAO ';
        vNomeCampoDev     := 'v.data CODIGO, v.data DESCRICAO ';
        vNomeCampoEntrada := 'e.datamovi_ent CODIGO, e.datamovi_ent DESCRICAO ';
      end;

    tpMes:
      begin
        if pPCG_Parametros.TipoData = 'EMISSÃO' then
          vNomeCampo        := 'RIGHT(''0'' || extract(month from v.data_ped), 2) CODIGO, RIGHT(''0'' || extract(month from v.data_ped), 2) DESCRICAO '
        else
          vNomeCampo        := 'RIGHT(''0'' || extract(month from v.DATA_FATURADO), 2) CODIGO, RIGHT(''0'' || extract(month from v.DATA_FATURADO), 2) DESCRICAO ';

        vNomeCampoOS      := 'RIGHT(''0'' || extract(month from v.fechamento_os), 2) CODIGO, RIGHT(''0'' || extract(month from v.fechamento_os), 2) DESCRICAO ';
        vNomeCampoDev     := 'RIGHT(''0'' || extract(month from v.data), 2) CODIGO, RIGHT(''0'' || extract(month from v.data), 2) DESCRICAO ';
        vNomeCampoEntrada := 'RIGHT(''0'' || extract(month from e.datamovi_ent), 2) CODIGO, RIGHT(''0'' || extract(month from e.datamovi_ent), 2) DESCRICAO ';
      end;

    tpCidade:
      begin
        vNomeCampo :=       'cl.cidade_cli CODIGO, cl.cidade_cli DESCRICAO';
      end;

    tpMarca:
      begin
        vNomeCampo :=       'm.codigo_mar CODIGO, m.nome_mar DESCRICAO';
      end;

    tpUF:
      begin
        vNomeCampo :=       'cl.uf_cli CODIGO, cl.uf_cli DESCRICAO';
      end;
  end;

  // Filtros Selecionados
  vFiltro := '';


  if pPCG_Parametros.Vendedor <> '' then
    vFiltro := vFiltro + ' and fu.codigo_fun in (' + pPCG_Parametros.Vendedor + ')';

  if pPCG_Parametros.Fornecedor <> '' then
    vFiltro := vFiltro + ' and f.codigo_for in (' + pPCG_Parametros.Fornecedor + ')';

  if pPCG_Parametros.Grupo <> '' then
    vFiltro := vFiltro + ' and gp.codigo_gru in (' + pPCG_Parametros.Grupo + ')';

  if pPCG_Parametros.SubGrupo <> '' then
    vFiltro := vFiltro + ' and p.codigo_sub in (' + pPCG_Parametros.SubGrupo + ')';

  if pPCG_Parametros.Marca <> '' then
    vFiltro := vFiltro + ' and m.codigo_mar in (' + pPCG_Parametros.Marca + ')';

  if pPCG_Parametros.Tipo <> '' then
    vFiltro := vFiltro + ' and v.codigo_tip in (' + pPCG_Parametros.Tipo + ')';
  // Fim Filtros Selecionados
end;


function TPCGDao.ObterEstoqueResultado1(pPCG_Parametros: TPCG_Parametros): IFDDataset;
var
  lSQL:String;
  lMemTable: TFDMemTable;

  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;

begin

  lAsyncList := getQueryLojaAsyncList(vIConexao,pPCG_Parametros.Lojas);

  lMemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(lMemTable);

  Self.DefineDadosSelectEstoque(pPCG_Parametros.TipoAnaliseEstoque, pPCG_Parametros);

  lSQL := 'select                                                          ' + #13 +
          '    DESCRICAO,                                                  ' + #13 +
          '    CUSTO,                                                      ' + #13 +
          '    VENDA,                                                      ' + #13 +
          '    SALDO                                                       ' + #13 +
          '                                                                ' + #13 +
          'from                                                            ' + #13 +
          '(                                                               ' + #13 +
          '    select                                                      ' + #13 +
          '        ' + vNomeCampo + ',                                     ' + #13 +
          '        sum(p.customedio_pro*p.saldo_pro) CUSTO,                ' + #13 +
          '        sum(p.venda_pro*p.saldo_pro) VENDA,                     ' + #13 +
          '        sum(p.saldo_pro) SALDO                                  ' + #13 +
          '                                                                ' + #13 +
          '    from                                                        ' + #13 +
          '        produto p                                               ' + #13 +
          '                                                                ' + #13 +
          '    left join grupoproduto g     on g.codigo_gru = p.codigo_gru ' + #13 +
          '    left join subgrupoproduto s  on s.codigo_sub = p.codigo_sub ' + #13 +
          '    left join produto_tipo t     on p.tipo_id = t.id            ' + #13 +
          '    left join fornecedor f       on f.codigo_for = p.codigo_for ' + #13 +
          '    left join marcaproduto m     on m.codigo_mar = p.codigo_mar ' + #13 +
          '                                                                ' + #13 +
          '    where                                                       ' + #13 +
          '        p.saldo_pro <> 0                                        ' + #13 +
          '        ' + vFiltro + '                                         ' + #13 +
          '                                                                ' + #13 +
          '    group by 1                                                  ' + #13 +
          '                                                                ' + #13 +
          ') resultado                                                     ' + #13;

  gravaSQL(lSQL, 'PCGDao_ObterEstoqueResultado1_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  with lMemTable.IndexDefs.AddIndexDef do
  begin
    Name := 'OrdenacaoCusto';
    Fields := 'CUSTO';
    Options := [TIndexOption.ixDescending, TIndexOption.ixCaseInsensitive];
  end;

  lMemTable.IndexName := 'OrdenacaoCusto';

  lMemTable.FieldDefs.Add('LOJA', ftString, 3);
  lMemTable.FieldDefs.Add('LOJA_NOME', ftString, 100);
  lMemTable.FieldDefs.Add('DESCRICAO', ftString, 100);
  lMemTable.FieldDefs.Add('CUSTO', ftFloat);
  lMemTable.FieldDefs.Add('VENDA', ftFloat);
  lMemTable.FieldDefs.Add('SALDO', ftFloat);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.tag := 'TPCGDao.ObterEstoqueResultado1';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TPCGDao.ObterEstoqueResultado1: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.espera;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TPCGDao.ObterEstoqueResultado1: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA,lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lMemTable.InsertRecord([
                              lQA.loja.objeto.LOJA,
                              lQA.loja.objeto.DESCRICAO,
                              lQA.dataset.dataset.FieldByName('DESCRICAO').AsString,
                              lQA.dataset.dataset.FieldByName('CUSTO').AsFloat,
                              lQA.dataset.dataset.FieldByName('VENDA').AsFloat,
                              lQA.dataset.dataset.FieldByName('SALDO').AsFloat
                             ]);

      lQA.dataset.dataset.Next;
    end;

  end;

  lMemTable.Open;

end;

procedure TPCGDao.DefineDadosSelectEstoque(Acao: TTipoAnaliseEstoquePCG; pPCG_Parametros: TPCG_Parametros);
begin
  vNomeCampo := '';

  case Acao of

    tpEstGrupo:
      begin
        vNomeCampo := 'g.nome_gru DESCRICAO';
      end;

    tpEstSubGrupo:
      begin
        vNomeCampo := 's.nome_sub DESCRICAO';
      end;

    tpEstFornecedor:
      begin
        vNomeCampo := 'f.fantasia_for DESCRICAO';
      end;

    tpEstMarca:
      begin
        vNomeCampo := 'm.nome_mar DESCRICAO';
      end;

    tpEstTipo:
      begin
        vNomeCampo := 't.nome DESCRICAO';
      end;
  end;


  // Filtros Selecionados
  vFiltro := '';

  if pPCG_Parametros.Fornecedor <> '' then
    vFiltro := vFiltro + ' and f.codigo_for in (' + pPCG_Parametros.Fornecedor + ')';

  if pPCG_Parametros.Grupo <> '' then
    vFiltro := vFiltro + ' and g.codigo_gru in (' + pPCG_Parametros.Grupo + ')';

  if pPCG_Parametros.SubGrupo <> '' then
    vFiltro := vFiltro + ' and s.codigo_sub in (' + pPCG_Parametros.SubGrupo + ')';

  if pPCG_Parametros.Marca <> '' then
    vFiltro := vFiltro + ' and m.codigo_mar in (' + pPCG_Parametros.Marca + ')';

  if pPCG_Parametros.Tipo <> '' then
    vFiltro := vFiltro + ' and t.id in (' + pPCG_Parametros.Tipo + ')';
  // Fim Filtros Selecionados
end;

end.
