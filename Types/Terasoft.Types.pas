unit Terasoft.Types;

interface

uses
  Variants,
  SysUtils,
  Terasoft.Framework.Types,
  Terasoft.Framework.ListaSimples;

type
  TVariantArray = array of Variant;

  TParametrosEventoUso = IListaString;

  TAcao = (tacIndefinido, tacIncluir, tacIncluirLote, tacAlterar, tacExcluir);
  TTipoApuracao = (tapVencimento, tapEmissao);
  TEscolhaSimples = (tesSim, tesNao);
  TTipoColunas = (tcoString, tcoFloat, tcoCNPJCPF, tcoFone, tcoCEP, tcoData, tcoDataHora, tcoHora);
  TTipoAviso = (tavError, tavSuccess, tavWarning);
  TTipoMensagem = (tmInfo, tmSuccess, tmNotice, tmError, tmSimple);
  TPosicaoHorizontal = (tphLeft, tphCenter, tphRight);
  TPosicaoVertical = (tpvTop, tpvBottom);
  TConclusaoContasReceber = (tcPedirBandeira, tcReceberEntrada, tcReceberCartao, tcConcluido, tcReceberTef, tcReceberPix, tcCheque, tcNull);
  TPortador = (tpDinheiro, tpCredito, tpDebito, tpPix, tpPixAvulso, tpPixEntrada, tpTef, tpCarteira, tpBoleto, tpCreditoCliente, tpAvista, tpReceber, tpCheque, tpNull, tpEmpty);
  TTabela = (ttPedidoVenda, ttRecibo, ttFechamentoCaixa, ttCreditoCliente, ttExtratoCaixa, ttNull);
  TBubina = (tb40, tb30, tbNull);
  TLado = (lEsquerdo, lDireito);
  TImpressaoPedido = (tipPedido, tipRecibo, tipCarne, tipNFCe, tipNFe, tipPixRecebimento, tipNenhum);
  TProcedure = procedure of object;

  TTipoValorConfiguracao = ( tvInteiro, tvNumero, tvString, tvMemo, tvChar, tvBool, tvData, tvHora, tvDataHora, tvEmpresa );

  THost = record
    Server,
    Port,
    Database : String;
  end;

  TContaClienteParametros = record
    Juros: Boolean;
    DataInicio,
    DataFim,
    NSU,
    Fatura,
    Parcela,
    Loja,
    Cliente: String;
  end;

  TContaClienteRetorno = record
    LOJA,
    ID,
    VENCIMENTO_REC,
    FATURA_REC,
    PACELA_REC,
    VALORREC_REC,
    TOTALPARCELAS_REC,
    VLRPARCELA_REC,
    RECEBIMENTO_CONTA_ID,
    CODIGO_CTA,
    JUROS,
    ABERTO,
    TOTAL_PARCELA,
    NOME_PORT,
    PEDIDO_REC,
    CTRBAIXA,
    DESCONTO: String;
  end;

  TListaContaClienteRetorno = IListaSimples<TContaClienteRetorno>;

  TTipoAnaliseDRG = (tpFaturamento, tpCompetencia, tpRecebimento, tpPrevisao, tpOrcamento);
  TNivelVisualizacaoDRG = (tpNivel1, tpNivel2, tpNivel3);

  TTipoAnalisePCG = (tpVendedores, tpClientes, tpProdutos, tpGrupo, tpGrupoComissao, tpPortador, tpFornecedor, tpMes, tpCidade, tpDia, tpMarca, tpUF, tpFilial);
  TTipoAnaliseEstoquePCG = (tpEstGrupo, tpEstSubGrupo, tpEstFornecedor, tpEstMarca, tpEstTipo, tpEstProduto);
  TFiliasPorPCG = (tpDescricao, tpNumero);

  TTipoAnaliseCurvaABC = (tpABCVendedores, tpABCClientes, tpABCProdutos, tpABCGrupo, tpABCGrupoComissao, tpABCPortador, tpABCFornecedor, tpABCMes, tpABCCidade, tpABCDia, tpABCMarca, tpABCUF);
  TClassificarPorCurvaABC = (tpABCQuantidade, tpABCQtdeCliente, tpABCVenda, tpABCCusto, tpABCLucro);

  //
  // Curva ABC
  //
  TCurvaABC_Parametros = record
    TipoData,
    DataInicio,
    DataFim        : String;
    TipoAnalise    : TTipoAnaliseCurvaABC;
    ClassificarPor : TClassificarPorCurvaABC;
    SomarST,
    SomarACrescimo,
    SomarIPI,
    SomarFrete     : Boolean;
    Produto,
    Fornecedor,
    Grupo,
    SubGrupo,
    Marca,
    Grade,
    Lojas,
    Atividade,
    TipoSaida,
    Cliente,
    Vendedor,
    Gerente,
    Cidade,
    UF,
    TipoMargem     : String;
  end;

  TAtualizaReserva_Parametros = record
    Web_pedido_id,
    Cliente_id,
    status,
    Vendedor_id,
    Filial,
    Informacoes_ped,
    Entrega_data,
    Montagem_data,
    Entrega_hora,
    Montagem_hora,
    Entrega_endereco,
    Entrega_complemento,
    Entrega_numero,
    Entrega_bairro,
    Entrega_cidade,
    Entrega_uf,
    Entrega_cep,
    Entrega_cod_municipio: String;
    Valor_Acrescimo,
    Valor_Total: Real
  end;

  TCurvaABC_Dados = record
    Loja, Descricao                : String;
    Qtde_Venda, Quantidade_Cliente : Integer;
    Valor_Liquido, Custo           : Real;
  end;

  TOperacoesDashboardAsync = (od_totalizador, od_pordia, od_porano,od_porhora,od_vendedores,od_filiais{,od_anos});
  TOperacoesDashboardAsyncSet  = set of TOperacoesDashboardAsync;


  TListaCurvaABC = IListaSimples<TCurvaABC_Dados>;
  // FIM Curva ABC

  //
  // DASHBOARD
  //
  TDashbord_Parametros = record
    ////////////////////////////////////////////////////////////////
    ///                                                          ///
    /// Ao Ao incluir novo campo, colcoar ele na função HASH,    ///
    /// para que seja detectada a mudança no conteudo do record  ///
    ///                                                          ///
    ////////////////////////////////////////////////////////////////
    TipoData,
    DataInicio,
    DataFim,
    Lojas,
    SomarST,
    SomarAcrescimo,
    SomarIPI,
    SomarFrete,
    Vendedores,
    TipoAnalise : String;
    expandeAsync: TOperacoesDashboardAsyncSet;
    identificador: TBytes;
    function hash: TBytes;
    function compare(pOther: TDashbord_Parametros): boolean;
  end;

  TDashbord_Dados = record
    MES,
    DATA,
    LOJA: String;
    VALOR_LIQUIDO,
    CUSTO: Real;
    TOTAL_ITENS,
    QUANTIDADE_VENDA,
    QUANTIDADE_CLIENTE : Integer;
  end;

  TListaDashbord = IListaSimples<TDashbord_Dados>;
  // FIM DASHBOARD

  //
  // DRG
  //
  TDRG_Parametros = record
    SomaFrete,
    ApresentarContasZeradas: Boolean;
    ListarCMV,
    ListarDevolucao,
    ConsiderarDesconto,
    VisializarGrupoProduto,
    SomarST,
    SomarACrescimo,
    SomarIPI,
    SomarFrete: Boolean;
    NivelVisualizacao: TNivelVisualizacaoDRG;
    TipoAnalise: TTipoAnaliseDRG;
    DataInicio,
    DataFim,
    MesAno,
    Ano,
    Nivel,
    FiltroGrupo,
    FiltroSubGrupo,
    Lojas,
    Filtro: String;
    ValorPrincipal: Real;
    DataPadrao: String;
  end;

  TDRG_Detalhes_Parametros = record
    DataInicio,
    DataFim,
    MesAno,
    Ano,
    Conta,
    Lojas: String;
  end;
  // FIM DRG

  //
  // FORNECEDOR
  //
  TFornecedor_Parametros = record
    Fornecedores: String;
  end;
  // FIM FORNECEDOR

  //
  // PCG
  //
  TPCG_Parametros = record
    TipoData,
    DataInicio,
    DataFim,
    Vendedor,
    Fornecedor,
    Grupo,
    SubGrupo,
    Marca,
    Tipo,
    Lojas,
    ColunaOrdenacao,
    ColunaOrdenacaoOrdem: String;
    FiliaisPor: TFiliasPorPCG;
    TipoAnalise: TTipoAnalisePCG;
    TipoAnaliseEstoque: TTipoAnaliseEstoquePCG;
    SomarST,
    SomarACrescimo,
    SomarIPI,
    SomarFrete: Boolean;
  end;

  TPCG_Dados = record
    Loja,
    Descricao : String;
    Valor_Liquido,
    Acrescimo,
    Frete,
    IPI,
    ST : Real;
  end;
  TListaPCG = IListaSimples<TPCG_Dados>;
  // FIM PCG

  //
  // GESTAO PIX
  //
  TPix_Parametros = record
    TipoData,
    Situacao,
    DataInicio,
    DataFim,
    Cliente,
    Lojas : String;
  end;
  // FIM GESTAO PIX

  //
  // GRUPO PRODUTO
  //
  TGrupo_Parametros = record
    Grupos: String;
  end;
  // FIM GRUPO PRODUTO


  //
  // SUBGRUPO PRODUTO
  //
  TSubGrupo_Parametros = record
    SubGrupos: String;
  end;
  // FIM SUBGRUPO PRODUTO


  //
  // VENDEDOR
  //
  TVendedor_Parametros = record
    Vendedores: String;
  end;
  // FIM VENDEDOR


  //
  // MARCA PRODUTO
  //
  TMarca_Parametros = record
    Marcas: String;
  end;
  // FIM MARCA PRODUTO


  //
  // TIPO VENDA
  //
  TTipoVenda_Parametros = record
    TipoVendas: String;
  end;
  // FIM TIPO VENDA


  //
  // TIPO ESTOQUE
  //
  TTipoEstoque_Parametros = record
    TipoEstoques: String;
  end;
  // FIM TIPO ESTOQUE

implementation
  uses
    Terasoft.Framework.Bytes;

{ TDashbord_Parametros }

function TDashbord_Parametros.compare(pOther: TDashbord_Parametros): boolean;
begin
  Result := compareBytes(self.hash,pOther.hash)=0;
end;

function TDashbord_Parametros.hash: TBytes;
begin
  Result := sha256Bytes(concatBytes([
      self.identificador,
      BytesOf(self.TipoData),
      BytesOf(self.DataInicio),
      BytesOf(self.DataFim),
      BytesOf(self.Lojas),
      BytesOf(self.SomarST),
      BytesOf(self.SomarAcrescimo),
      BytesOf(self.SomarIPI),
      BytesOf(self.SomarFrete),
      BytesOf(self.Vendedores),
      BytesOf(self.TipoAnalise),
      BytesOf(self.SomarAcrescimo)
      ]));
end;

end.
