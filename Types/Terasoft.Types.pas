unit Terasoft.Types;

interface

uses
  Terasoft.Framework.ListaSimples;

type
  TAcao = (tacIndefinido, tacIncluir, tacIncluirLote, tacAlterar, tacExcluir);
  TTipoApuracao = (tapVencimento, tapEmissao);
  TEscolhaSimples = (tesSim, tesNao);
  TTipoColunas = (tcoString, tcoFloat, tcoCNPJCPF, tcoFone, tcoCEP, tcoData, tcoDataHora, tcoHora);
  TTipoAviso = (tavError, tavSuccess, tavWarning);
  TTipoMensagem = (tmInfo, tmSuccess, tmNotice, tmError, tmSimple);
  TPosicaoHorizontal = (tphLeft, tphCenter, tphRight);
  TPosicaoVertical = (tpvTop, tpvBottom);
  TConclusaoContasReceber = (tcPedirBandeira, tcReceberEntrada, tcReceberCartao, tcConcluido, tcReceberTef, tcReceberPix, tcNull);
  TPortador = (tpDinheiro, tpCredito, tpDebito, tpPix, tpTef, tpCarteira, tpCreditoCliente, tpNull);
  TTabela = (ttPedidoVenda, ttRecibo, ttFechamentoCaixa, ttCreditoCliente, ttNull);
  TBubina = (tb40, tb30, tbNull);
  TLado = (lEsquerdo, lDireito);
  TImpressaoPedido = (tipPedido, tipRecibo, tipCarne, tipNFCe);
  TProcedure = procedure of object;

  TTipoValorConfiguracao = ( tvInteiro, tvNumero, tvString, tvMemo, tvChar, tvBool, tvData, tvHora, tvDataHora, tvEmpresa );

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

implementation
end.
