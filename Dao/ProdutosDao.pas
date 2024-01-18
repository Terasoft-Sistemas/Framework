unit ProdutosDao;

interface

uses
  ProdutosModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao;

type
  TProdutosDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FProdutossLista: TObjectList<TProdutosModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetProdutossLista(const Value: TObjectList<TProdutosModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

    procedure setParams(var pQry: TFDQuery; pProdutoModel: TProdutosModel);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ProdutossLista: TObjectList<TProdutosModel> read FProdutossLista write SetProdutossLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pProdutosModel: TProdutosModel): String;
    function alterar(pProdutosModel: TProdutosModel): String;
    function excluir(pProdutosModel: TProdutosModel): String;

    procedure obterLista;
    function obterSaldo(pIdProduto: String): Double;
    procedure subtrairSaldo(pIdProduto: String; pSaldo: Double);
    procedure adicionarSaldo(pIdProduto: String; pSaldo: Double);

    function valorVenda(pIdProduto: String): Variant;

    function obterCodigobarras(pIdProduto: String): String;
    function carregaClasse(pId: String): TProdutosModel;
end;

implementation

{ TProdutos }

function TProdutosDao.carregaClasse(pId: String): TProdutosModel;
var
  lQry: TFDQuery;
  lModel: TProdutosModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TProdutosModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from produto where codigo_pro = '+ QuotedStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.UUID                             := lQry.FieldByName('UUID').AsString;
    lModel.CODIGO_PRO                       := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.CODIGO_GRU                       := lQry.FieldByName('CODIGO_GRU').AsString;
    lModel.CODIGO_FOR                       := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.NOME_PRO                         := lQry.FieldByName('NOME_PRO').AsString;
    lModel.UNIDADE_PRO                      := lQry.FieldByName('UNIDADE_PRO').AsString;
    lModel.SALDO_PRO                        := lQry.FieldByName('SALDO_PRO').AsString;
    lModel.SALDOMIN_PRO                     := lQry.FieldByName('SALDOMIN_PRO').AsString;
    lModel.CUSTOMEDIO_PRO                   := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
    lModel.CUSTOULTIMO_PRO                  := lQry.FieldByName('CUSTOULTIMO_PRO').AsString;
    lModel.CUSTOLIQUIDO_PRO                 := lQry.FieldByName('CUSTOLIQUIDO_PRO').AsString;
    lModel.CUSTODOLAR_PRO                   := lQry.FieldByName('CUSTODOLAR_PRO').AsString;
    lModel.MARGEM_PRO                       := lQry.FieldByName('MARGEM_PRO').AsString;
    lModel.VENDA_PRO                        := lQry.FieldByName('VENDA_PRO').AsString;
    lModel.VENDAPRAZO_PRO                   := lQry.FieldByName('VENDAPRAZO_PRO').AsString;
    lModel.VENDAPROMOCAO_PRO                := lQry.FieldByName('VENDAPROMOCAO_PRO').AsString;
    lModel.PESO_PRO                         := lQry.FieldByName('PESO_PRO').AsString;
    lModel.VENDAMINIMA_PRO                  := lQry.FieldByName('VENDAMINIMA_PRO').AsString;
    lModel.VENDAWEB_PRO                     := lQry.FieldByName('VENDAWEB_PRO').AsString;
    lModel.MARCA_PRO                        := lQry.FieldByName('MARCA_PRO').AsString;
    lModel.APLICACAO_PRO                    := lQry.FieldByName('APLICACAO_PRO').AsString;
    lModel.IMAGEM_PRO                       := lQry.FieldByName('IMAGEM_PRO').AsString;
    lModel.CODIGO_MAR                       := lQry.FieldByName('CODIGO_MAR').AsString;
    lModel.COMISSAO_PRO                     := lQry.FieldByName('COMISSAO_PRO').AsString;
    lModel.CODIGO_SUB                       := lQry.FieldByName('CODIGO_SUB').AsString;
    lModel.DATADOLAR_PRO                    := lQry.FieldByName('DATADOLAR_PRO').AsString;
    lModel.VALORDOLAR_PRO                   := lQry.FieldByName('VALORDOLAR_PRO').AsString;
    lModel.GARANTIA_PRO                     := lQry.FieldByName('GARANTIA_PRO').AsString;
    lModel.NOVIDADE_PRO                     := lQry.FieldByName('NOVIDADE_PRO').AsString;
    lModel.BARRAS_PRO                       := lQry.FieldByName('BARRAS_PRO').AsString;
    lModel.USUARIO_PRO                      := lQry.FieldByName('USUARIO_PRO').AsString;
    lModel.IPI_PRO                          := lQry.FieldByName('IPI_PRO').AsString;
    lModel.FRETE_PRO                        := lQry.FieldByName('FRETE_PRO').AsString;
    lModel.ULTIMAVENDA_PRO                  := lQry.FieldByName('ULTIMAVENDA_PRO').AsString;
    lModel.QTDEDIAS_PRO                     := lQry.FieldByName('QTDEDIAS_PRO').AsString;
    lModel.CODLISTA_COD                     := lQry.FieldByName('CODLISTA_COD').AsString;
    lModel.ICMS_PRO                         := lQry.FieldByName('ICMS_PRO').AsString;
    lModel.DESCRICAO                        := lQry.FieldByName('DESCRICAO').AsString;
    lModel.PRODUTO_FINAL                    := lQry.FieldByName('PRODUTO_FINAL').AsString;
    lModel.QTDE_PRODUZIR                    := lQry.FieldByName('QTDE_PRODUZIR').AsString;
    lModel.PRINCIPIO_ATIVO                  := lQry.FieldByName('PRINCIPIO_ATIVO').AsString;
    lModel.CODIGO_FORNECEDOR                := lQry.FieldByName('CODIGO_FORNECEDOR').AsString;
    lModel.STATUS_PRO                       := lQry.FieldByName('STATUS_PRO').AsString;
    lModel.LOJA                             := lQry.FieldByName('LOJA').AsString;
    lModel.ECF_PRO                          := lQry.FieldByName('ECF_PRO').AsString;
    lModel.LISTA                            := lQry.FieldByName('LISTA').AsString;
    lModel.COMIS_PRO                        := lQry.FieldByName('COMIS_PRO').AsString;
    lModel.DESCONTO_PRO                     := lQry.FieldByName('DESCONTO_PRO').AsString;
    lModel.PMC_PRO                          := lQry.FieldByName('PMC_PRO').AsString;
    lModel.PRECO_FABRICANTE                 := lQry.FieldByName('PRECO_FABRICANTE').AsString;
    lModel.SALDO                            := lQry.FieldByName('SALDO').AsString;
    lModel.CLAS_FISCAL_PRO                  := lQry.FieldByName('CLAS_FISCAL_PRO').AsString;
    lModel.TABELA_VENDA                     := lQry.FieldByName('TABELA_VENDA').AsString;
    lModel.PRODUTO_REFERENTE                := lQry.FieldByName('PRODUTO_REFERENTE').AsString;
    lModel.TABICMS_PRO                      := lQry.FieldByName('TABICMS_PRO').AsString;
    lModel.VALIDADE_PRO                     := lQry.FieldByName('VALIDADE_PRO').AsString;
    lModel.PESQUISA                         := lQry.FieldByName('PESQUISA').AsString;
    lModel.METROSBARRAS_PRO                 := lQry.FieldByName('METROSBARRAS_PRO').AsString;
    lModel.ALIQUOTA_PIS                     := lQry.FieldByName('ALIQUOTA_PIS').AsString;
    lModel.ALIQUOTA_COFINS                  := lQry.FieldByName('ALIQUOTA_COFINS').AsString;
    lModel.CST_COFINS                       := lQry.FieldByName('CST_COFINS').AsString;
    lModel.CST_PIS                          := lQry.FieldByName('CST_PIS').AsString;
    lModel.CSOSN                            := lQry.FieldByName('CSOSN').AsString;
    lModel.QUTDE_MAXIMA                     := lQry.FieldByName('QUTDE_MAXIMA').AsString;
    lModel.ULTIMA_ALTERACAO_PRO             := lQry.FieldByName('ULTIMA_ALTERACAO_PRO').AsString;
    lModel.LOCALIZACAO                      := lQry.FieldByName('LOCALIZACAO').AsString;
    lModel.PRODUTO_NFE                      := lQry.FieldByName('PRODUTO_NFE').AsString;
    lModel.CNPJ_PRODUTO_NFE                 := lQry.FieldByName('CNPJ_PRODUTO_NFE').AsString;
    lModel.ID                               := lQry.FieldByName('ID').AsString;
    lModel.MATERIAL                         := lQry.FieldByName('MATERIAL').AsString;
    lModel.PEDIDO_MENSAL                    := lQry.FieldByName('PEDIDO_MENSAL').AsString;
    lModel.QUANT_PECA_BARRA                 := lQry.FieldByName('QUANT_PECA_BARRA').AsString;
    lModel.QUANT_BARRA_USADAS               := lQry.FieldByName('QUANT_BARRA_USADAS').AsString;
    lModel.VALOR_MP                         := lQry.FieldByName('VALOR_MP').AsString;
    lModel.QUANT_PECA_HORA                  := lQry.FieldByName('QUANT_PECA_HORA').AsString;
    lModel.SERRA                            := lQry.FieldByName('SERRA').AsString;
    lModel.FURADEIRA                        := lQry.FieldByName('FURADEIRA').AsString;
    lModel.ROSQUEADEIRA                     := lQry.FieldByName('ROSQUEADEIRA').AsString;
    lModel.TORNO                            := lQry.FieldByName('TORNO').AsString;
    lModel.GALVANIZACAO                     := lQry.FieldByName('GALVANIZACAO').AsString;
    lModel.TEMPERA                          := lQry.FieldByName('TEMPERA').AsString;
    lModel.FREZADORA                        := lQry.FieldByName('FREZADORA').AsString;
    lModel.FRETE                            := lQry.FieldByName('FRETE').AsString;
    lModel.MARGEM_LUCRO                     := lQry.FieldByName('MARGEM_LUCRO').AsString;
    lModel.PORCENTAGEM_NFE                  := lQry.FieldByName('PORCENTAGEM_NFE').AsString;
    lModel.HORA_MAQUINA                     := lQry.FieldByName('HORA_MAQUINA').AsString;
    lModel.CODIGO_FORNECEDOR2               := lQry.FieldByName('CODIGO_FORNECEDOR2').AsString;
    lModel.CODIGO_FORNECEDOR3               := lQry.FieldByName('CODIGO_FORNECEDOR3').AsString;
    lModel.REFERENCIA_NEW                   := lQry.FieldByName('REFERENCIA_NEW').AsString;
    lModel.MULTIPLOS                        := lQry.FieldByName('MULTIPLOS').AsString;
    lModel.CST_CREDITO_PIS                  := lQry.FieldByName('CST_CREDITO_PIS').AsString;
    lModel.CST_CREDITO_COFINS               := lQry.FieldByName('CST_CREDITO_COFINS').AsString;
    lModel.ALIQ_CREDITO_COFINS              := lQry.FieldByName('ALIQ_CREDITO_COFINS').AsString;
    lModel.ALIQ_CREDITO_PIS                 := lQry.FieldByName('ALIQ_CREDITO_PIS').AsString;
    lModel.CFOP_ESTADUAL_ID                 := lQry.FieldByName('CFOP_ESTADUAL_ID').AsString;
    lModel.CFOP_INTERESTADUAL_ID            := lQry.FieldByName('CFOP_INTERESTADUAL_ID').AsString;
    lModel.CST_IPI                          := lQry.FieldByName('CST_IPI').AsString;
    lModel.IPI_SAI                          := lQry.FieldByName('IPI_SAI').AsString;
    lModel.VALIDAR_CAIXA                    := lQry.FieldByName('VALIDAR_CAIXA').AsString;
    lModel.USAR_INSC_ST                     := lQry.FieldByName('USAR_INSC_ST').AsString;
    lModel.FORNECEDOR_CODIGO                := lQry.FieldByName('FORNECEDOR_CODIGO').AsString;
    lModel.CONTROLE_SERIAL                  := lQry.FieldByName('CONTROLE_SERIAL').AsString;
    lModel.DESMEMBRAR_KIT                   := lQry.FieldByName('DESMEMBRAR_KIT').AsString;
    lModel.CALCULO_MARGEM                   := lQry.FieldByName('CALCULO_MARGEM').AsString;
    lModel.PESO_LIQUIDO                     := lQry.FieldByName('PESO_LIQUIDO').AsString;
    lModel.CONTA_CONTABIL                   := lQry.FieldByName('CONTA_CONTABIL').AsString;
    lModel.LINK                             := lQry.FieldByName('LINK').AsString;
    lModel.EAN_14                           := lQry.FieldByName('EAN_14').AsString;
    lModel.VALIDADE                         := lQry.FieldByName('VALIDADE').AsString;
    lModel.USAR_BALANCA                     := lQry.FieldByName('USAR_BALANCA').AsString;
    lModel.VENDA_WEB                        := lQry.FieldByName('VENDA_WEB').AsString;
    lModel.SYSTIME                          := lQry.FieldByName('SYSTIME').AsString;
    lModel.OBS_GERAL                        := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.MULTIPLICADOR                    := lQry.FieldByName('MULTIPLICADOR').AsString;
    lModel.DIVIZOR                          := lQry.FieldByName('DIVIZOR').AsString;
    lModel.ARREDONDAMENTO                   := lQry.FieldByName('ARREDONDAMENTO').AsString;
    lModel.OBS_NF                           := lQry.FieldByName('OBS_NF').AsString;
    lModel.DESTAQUE                         := lQry.FieldByName('DESTAQUE').AsString;
    lModel.MARGEM_PROMOCAO                  := lQry.FieldByName('MARGEM_PROMOCAO').AsString;
    lModel.TIPO_ID                          := lQry.FieldByName('TIPO_ID').AsString;
    lModel.PART_NUMBER                      := lQry.FieldByName('PART_NUMBER').AsString;
    lModel.NFCE_CST                         := lQry.FieldByName('NFCE_CST').AsString;
    lModel.NFCE_CSOSN                       := lQry.FieldByName('NFCE_CSOSN').AsString;
    lModel.NFCE_ICMS                        := lQry.FieldByName('NFCE_ICMS').AsString;
    lModel.NFCE_CFOP                        := lQry.FieldByName('NFCE_CFOP').AsString;
    lModel.ETIQUETA_NOME                    := lQry.FieldByName('ETIQUETA_NOME').AsString;
    lModel.ETIQUETA_NOME_CIENTIFICO         := lQry.FieldByName('ETIQUETA_NOME_CIENTIFICO').AsString;
    lModel.ETIQUETA_PESO_LIQUIDO            := lQry.FieldByName('ETIQUETA_PESO_LIQUIDO').AsString;
    lModel.ETIQUETA_PESO_BRUTO              := lQry.FieldByName('ETIQUETA_PESO_BRUTO').AsString;
    lModel.ETIQUETA_SIGLA                   := lQry.FieldByName('ETIQUETA_SIGLA').AsString;
    lModel.ETIQUETA_PORCAO                  := lQry.FieldByName('ETIQUETA_PORCAO').AsString;
    lModel.IMPRESSAO_COZINHA                := lQry.FieldByName('IMPRESSAO_COZINHA').AsString;
    lModel.IMPRESSAO_BALCAO                 := lQry.FieldByName('IMPRESSAO_BALCAO').AsString;
    lModel.WEB_NOME_PRO                     := lQry.FieldByName('WEB_NOME_PRO').AsString;
    lModel.WEB_GERENCIA_ESTOQUE             := lQry.FieldByName('WEB_GERENCIA_ESTOQUE').AsString;
    lModel.WEB_PRECO_VENDA                  := lQry.FieldByName('WEB_PRECO_VENDA').AsString;
    lModel.WEB_PRECO_PROMOCAO               := lQry.FieldByName('WEB_PRECO_PROMOCAO').AsString;
    lModel.WEB_PESO                         := lQry.FieldByName('WEB_PESO').AsString;
    lModel.WEB_ALTURA                       := lQry.FieldByName('WEB_ALTURA').AsString;
    lModel.WEB_LARGURA                      := lQry.FieldByName('WEB_LARGURA').AsString;
    lModel.WEB_PROFUNDIDADE                 := lQry.FieldByName('WEB_PROFUNDIDADE').AsString;
    lModel.CONSERVADORA                     := lQry.FieldByName('CONSERVADORA').AsString;
    lModel.CLIENTE_CONSERVADORA             := lQry.FieldByName('CLIENTE_CONSERVADORA').AsString;
    lModel.VOLTAGEM                         := lQry.FieldByName('VOLTAGEM').AsString;
    lModel.ANO_FABRICACAO                   := lQry.FieldByName('ANO_FABRICACAO').AsString;
    lModel.PROPRIEDADE                      := lQry.FieldByName('PROPRIEDADE').AsString;
    lModel.MODELO                           := lQry.FieldByName('MODELO').AsString;
    lModel.TIPO_CONSERVADORA                := lQry.FieldByName('TIPO_CONSERVADORA').AsString;
    lModel.FICHA_TECNICA                    := lQry.FieldByName('FICHA_TECNICA').AsString;
    lModel.DESCRICAO_TECNICA                := lQry.FieldByName('DESCRICAO_TECNICA').AsString;
    lModel.IMAGEM_TECNICA                   := lQry.FieldByName('IMAGEM_TECNICA').AsString;
    lModel.CUSTO_MEDIDA                     := lQry.FieldByName('CUSTO_MEDIDA').AsString;
    lModel.IMAGEM                           := lQry.FieldByName('IMAGEM').AsString;
    lModel.POS_VENDA_DIAS                   := lQry.FieldByName('POS_VENDA_DIAS').AsString;
    lModel.WEB_DESCONTO                     := lQry.FieldByName('WEB_DESCONTO').AsString;
    lModel.WEB_CARACTERISTICA               := lQry.FieldByName('WEB_CARACTERISTICA').AsString;
    lModel.BONUS                            := lQry.FieldByName('BONUS').AsString;
    lModel.LW                               := lQry.FieldByName('LW').AsString;
    lModel.OH                               := lQry.FieldByName('OH').AsString;
    lModel.TW                               := lQry.FieldByName('TW').AsString;
    lModel.TH                               := lQry.FieldByName('TH').AsString;
    lModel.TIPO_VENDA_COMISSAO_ID           := lQry.FieldByName('TIPO_VENDA_COMISSAO_ID').AsString;
    lModel.DIFERENCA_CORTE                  := lQry.FieldByName('DIFERENCA_CORTE').AsString;
    lModel.USAR_CONTROLE_KG                 := lQry.FieldByName('USAR_CONTROLE_KG').AsString;
    lModel.CEST                             := lQry.FieldByName('CEST').AsString;
    lModel.SUGESTAO_COMPRA                  := lQry.FieldByName('SUGESTAO_COMPRA').AsString;
    lModel.STATUS_LINHA                     := lQry.FieldByName('STATUS_LINHA').AsString;
    lModel.CONTROLEALTERACAO                := lQry.FieldByName('CONTROLEALTERACAO').AsString;
    lModel.PRECO_DOLAR                      := lQry.FieldByName('PRECO_DOLAR').AsString;
    lModel.EMBALAGEM_ID                     := lQry.FieldByName('EMBALAGEM_ID').AsString;
    lModel.CUSTO_MANUAL                     := lQry.FieldByName('CUSTO_MANUAL').AsString;
    lModel.ETIQUETA_LINHA_1                 := lQry.FieldByName('ETIQUETA_LINHA_1').AsString;
    lModel.ETIQUETA_LINHA_2                 := lQry.FieldByName('ETIQUETA_LINHA_2').AsString;
    lModel.SALDO_ONLINE                     := lQry.FieldByName('SALDO_ONLINE').AsString;
    lModel.EQUIPAMENTO_ID                   := lQry.FieldByName('EQUIPAMENTO_ID').AsString;
    lModel.MEDIA_SUGESTAO                   := lQry.FieldByName('MEDIA_SUGESTAO').AsString;
    lModel.DATA_MEDIA_SUGESTAO              := lQry.FieldByName('DATA_MEDIA_SUGESTAO').AsString;
    lModel.USAR_PARTES                      := lQry.FieldByName('USAR_PARTES').AsString;
    lModel.CODIGO_ANP                       := lQry.FieldByName('CODIGO_ANP').AsString;
    lModel.ALTURA_M                         := lQry.FieldByName('ALTURA_M').AsString;
    lModel.LARGURA_M                        := lQry.FieldByName('LARGURA_M').AsString;
    lModel.PROFUNDIDADE_M                   := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.BASE_ST_RECOLHIDO                := lQry.FieldByName('BASE_ST_RECOLHIDO').AsString;
    lModel.PERCENTUAL_ST_RECOLHIDO          := lQry.FieldByName('PERCENTUAL_ST_RECOLHIDO').AsString;
    lModel.FCI                              := lQry.FieldByName('FCI').AsString;
    lModel.WEB_PALAVRA_CHAVE                := lQry.FieldByName('WEB_PALAVRA_CHAVE').AsString;
    lModel.WEB_URL                          := lQry.FieldByName('WEB_URL').AsString;
    lModel.WEB_COR                          := lQry.FieldByName('WEB_COR').AsString;
    lModel.WEB_TAMANHO                      := lQry.FieldByName('WEB_TAMANHO').AsString;
    lModel.IPI_CENQ                         := lQry.FieldByName('IPI_CENQ').AsString;
    lModel.VOLUME_QTDE                      := lQry.FieldByName('VOLUME_QTDE').AsString;
    lModel.M3                               := lQry.FieldByName('M3').AsString;
    lModel.TIPO_ITEM                        := lQry.FieldByName('TIPO_ITEM').AsString;
    lModel.MARGEM_PRAZO                     := lQry.FieldByName('MARGEM_PRAZO').AsString;
    lModel.VALIDAR_LOTE                     := lQry.FieldByName('VALIDAR_LOTE').AsString;
    lModel.CUSTOBASE_PRO                    := lQry.FieldByName('CUSTOBASE_PRO').AsString;
    lModel.VALOR_VENDA_MAXIMO               := lQry.FieldByName('VALOR_VENDA_MAXIMO').AsString;
    lModel.VALOR_VENDA_MINIMO               := lQry.FieldByName('VALOR_VENDA_MINIMO').AsString;
    lModel.ORDEM                            := lQry.FieldByName('ORDEM').AsString;
    lModel.NOME_RESUMIDO                    := lQry.FieldByName('NOME_RESUMIDO').AsString;
    lModel.COMBO                            := lQry.FieldByName('COMBO').AsString;
    lModel.UTRIB                            := lQry.FieldByName('UTRIB').AsString;
    lModel.QTRIB                            := lQry.FieldByName('QTRIB').AsString;
    lModel.CLIENTE_TSB                      := lQry.FieldByName('CLIENTE_TSB').AsString;
    lModel.UUIDALTERACAO                    := lQry.FieldByName('UUIDALTERACAO').AsString;
    lModel.RECEITA                          := lQry.FieldByName('RECEITA').AsString;
    lModel.CONTROLE_INVENTARIO              := lQry.FieldByName('CONTROLE_INVENTARIO').AsString;
    lModel.COTACAO_TIPO                     := lQry.FieldByName('COTACAO_TIPO').AsString;
    lModel.VENDA_COM_DESCONTO               := lQry.FieldByName('VENDA_COM_DESCONTO').AsString;
    lModel.WEB_URL_IMAGENS                  := lQry.FieldByName('WEB_URL_IMAGENS').AsString;
    lModel.WEB_ID                           := lQry.FieldByName('WEB_ID').AsString;
    lModel.WEB_INTEGRA                      := lQry.FieldByName('WEB_INTEGRA').AsString;
    lModel.WEB_GERENCIA_PRECO_VENDA         := lQry.FieldByName('WEB_GERENCIA_PRECO_VENDA').AsString;
    lModel.WEB_GERENCIA_IMAGENS             := lQry.FieldByName('WEB_GERENCIA_IMAGENS').AsString;
    lModel.WEB_RESUMO                       := lQry.FieldByName('WEB_RESUMO').AsString;
    lModel.DESCRICAO_ANP                    := lQry.FieldByName('DESCRICAO_ANP').AsString;
    lModel.CBENEF                           := lQry.FieldByName('CBENEF').AsString;
    lModel.INDESCALA                        := lQry.FieldByName('INDESCALA').AsString;
    lModel.CNPJFAB                          := lQry.FieldByName('CNPJFAB').AsString;
    lModel.PRODUTO_PAI                      := lQry.FieldByName('PRODUTO_PAI').AsString;
    lModel.CONVERSAO_FRACIONADA             := lQry.FieldByName('CONVERSAO_FRACIONADA').AsString;
    lModel.CUSTO_FINANCEIRO                 := lQry.FieldByName('CUSTO_FINANCEIRO').AsString;
    lModel.PRAZO_MEDIO                      := lQry.FieldByName('PRAZO_MEDIO').AsString;
    lModel.ARTIGO_ID                        := lQry.FieldByName('ARTIGO_ID').AsString;
    lModel.WEB_CATEGORIAS                   := lQry.FieldByName('WEB_CATEGORIAS').AsString;
    lModel.WEB_TIPO_PRODUTO                 := lQry.FieldByName('WEB_TIPO_PRODUTO').AsString;
    lModel.SUBLIMACAO                       := lQry.FieldByName('SUBLIMACAO').AsString;
    lModel.LISTAR_PRODUCAO                  := lQry.FieldByName('LISTAR_PRODUCAO').AsString;
    lModel.LISTAR_ROMANEIO                  := lQry.FieldByName('LISTAR_ROMANEIO').AsString;
    lModel.VALOR_TERCERIZADOS               := lQry.FieldByName('VALOR_TERCERIZADOS').AsString;
    lModel.GARANTIA_12                      := lQry.FieldByName('GARANTIA_12').AsString;
    lModel.GARANTIA_24                      := lQry.FieldByName('GARANTIA_24').AsString;
    lModel.MONTAGEM                         := lQry.FieldByName('MONTAGEM').AsString;
    lModel.ENTREGA                          := lQry.FieldByName('ENTREGA').AsString;
    lModel.CENQ                             := lQry.FieldByName('CENQ').AsString;
    lModel.CODIGO_ANTERIOR                  := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.VALOR_BONUS_SERVICO              := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
    lModel.NFE_INTEIRO                      := lQry.FieldByName('NFE_INTEIRO').AsString;
    lModel.GRUPO_COMISSAO_ID                := lQry.FieldByName('GRUPO_COMISSAO_ID').AsString;
    lModel.VALOR_ICMS_SUBSTITUTO            := lQry.FieldByName('VALOR_ICMS_SUBSTITUTO').AsString;
    lModel.FAMILIA                          := lQry.FieldByName('FAMILIA').AsString;
    lModel.TIPO_PRO                         := lQry.FieldByName('TIPO_PRO').AsString;
    lModel.CUSTOULTIMO_IMPORTACAO           := lQry.FieldByName('CUSTOULTIMO_IMPORTACAO').AsString;
    lModel.PRODUTO_ORIGEM                   := lQry.FieldByName('PRODUTO_ORIGEM').AsString;
    lModel.VALOR_MONTADOR                   := lQry.FieldByName('VALOR_MONTADOR').AsString;
    lModel.DATA_ALTERACAO_VENDA_PRO         := lQry.FieldByName('DATA_ALTERACAO_VENDA_PRO').AsString;
    lModel.DATA_ALTERACAO_CUSTOULTIMO_PRO   := lQry.FieldByName('DATA_ALTERACAO_CUSTOULTIMO_PRO').AsString;
    lModel.WEB_CODIGO_INTEGRACAO_MASTER     := lQry.FieldByName('WEB_CODIGO_INTEGRACAO_MASTER').AsString;
    lModel.WEB_CODIGO_INTEGRACAO            := lQry.FieldByName('WEB_CODIGO_INTEGRACAO').AsString;
    lModel.WEB_VARIACAO                     := lQry.FieldByName('WEB_VARIACAO').AsString;
    lModel.PRODUTO_MODELO                   := lQry.FieldByName('PRODUTO_MODELO').AsString;
    lModel.DATA_CONSUMO_OMINIONE            := lQry.FieldByName('DATA_CONSUMO_OMINIONE').AsString;
    lModel.CATEGORIA_ID                     := lQry.FieldByName('CATEGORIA_ID').AsString;
    lModel.UNIDADE_ENTRADA                  := lQry.FieldByName('UNIDADE_ENTRADA').AsString;
    lModel.CPRODANVISA                      := lQry.FieldByName('CPRODANVISA').AsString;
    lModel.XMOTIVOISENCAO                   := lQry.FieldByName('XMOTIVOISENCAO').AsString;
    lModel.VPMC                             := lQry.FieldByName('VPMC').AsString;
    lModel.PRODUTO_FILHO                    := lQry.FieldByName('PRODUTO_FILHO').AsString;
    lModel.CONVERSAO_FRACIONADA_FILHO       := lQry.FieldByName('CONVERSAO_FRACIONADA_FILHO').AsString;
    lModel.PERCENTUAL_PERDA_MATERIA_PRIMA   := lQry.FieldByName('PERCENTUAL_PERDA_MATERIA_PRIMA').AsString;
    lModel.EXTIPI                           := lQry.FieldByName('EXTIPI').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;

end;

constructor TProdutosDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TProdutosDao.Destroy;
begin

  inherited;
end;

function TProdutosDao.incluir(pProdutosModel: TProdutosModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PRODUTO', 'CODIGO_PRO');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('CODIGO_PRO').Value := vIConexao.Generetor('GEN_PRODUTO');
    setParams(lQry, pProdutosModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_PRO').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

procedure TProdutosDao.adicionarSaldo(pIdProduto: String; pSaldo: Double);
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := ' update produto                                     '+SLineBreak+
          '    set saldo_pro = coalesce(saldo_pro, 0) + :saldo '+SLineBreak+
          '  where codigo_pro = :codigo                        '+SLineBreak;
  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('saldo').Value   := FormataFloatFireBird(pSaldo.ToString);
    lQry.ParamByName('codigo').Value  := pIdProduto;
    lQry.ExecSQL;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TProdutosDao.alterar(pProdutosModel: TProdutosModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PRODUTO', 'CODIGO_PRO');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('CODIGO_PRO').Value := ifThen(pProdutosModel.CODIGO_PRO = '', Unassigned, pProdutosModel.CODIGO_PRO);
    setParams(lQry, pProdutosModel);
    lQry.ExecSQL;

    Result := pProdutosModel.CODIGO_PRO;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TProdutosDao.excluir(pProdutosModel: TProdutosModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from produto where codigo_pro = :CODIGO_PRO',[pProdutosModel.CODIGO_PRO]);
   lQry.ExecSQL;
   Result := pProdutosModel.CODIGO_PRO;

  finally
    lQry.Free;
  end;
end;

function TProdutosDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and produto.codigo_pro = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TProdutosDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From produto where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TProdutosDao.obterCodigobarras(pIdProduto: String): String;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select barras_pro from produto where codigo_pro = '+ QuotedStr(pIdProduto));
end;

procedure TProdutosDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FProdutossLista := TObjectList<TProdutosModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       produto.nome_pro,             '+
      '       produto.barras_pro,           '+
      '       produto.codigo_pro,           '+
      '       produto.venda_pro,            '+
      '       produto.customedio_pro,       '+
      '       produto.nfce_cfop             '+
	    '  from produto                       '+
      ' where 1=1                           ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FProdutossLista.Add(TProdutosModel.Create(vIConexao));

      i := FProdutossLista.Count -1;

      FProdutossLista[i].CODIGO_PRO      := lQry.FieldByName('CODIGO_PRO').AsString;
      FProdutossLista[i].NOME_PRO        := lQry.FieldByName('NOME_PRO').AsString;
      FProdutossLista[i].BARRAS_PRO      := lQry.FieldByName('BARRAS_PRO').AsString;
      FProdutossLista[i].VENDA_PRO       := lQry.FieldByName('VENDA_PRO').AsString;
      FProdutossLista[i].CUSTOMEDIO_PRO  := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
      FProdutossLista[i].NFCE_CFOP       := lQry.FieldByName('NFCE_CFOP').AsString;
      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

function TProdutosDao.obterSaldo(pIdProduto: String): Double;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select saldo_pro from produto where codigo_pro = '+ QuotedStr(pIdProduto));
end;

procedure TProdutosDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TProdutosDao.SetProdutossLista(const Value: TObjectList<TProdutosModel>);
begin
  FProdutossLista := Value;
end;

procedure TProdutosDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TProdutosDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TProdutosDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TProdutosDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TProdutosDao.setParams(var pQry: TFDQuery; pProdutoModel: TProdutosModel);
begin
  pQry.ParamByName('CODIGO_PRO').Value                           := ifThen(pProdutoModel.CODIGO_PRO                        = '', Unassigned, pProdutoModel.CODIGO_PRO);
  pQry.ParamByName('CODIGO_GRU').Value                           := ifThen(pProdutoModel.CODIGO_GRU                        = '', Unassigned, pProdutoModel.CODIGO_GRU);
  pQry.ParamByName('CODIGO_FOR').Value                           := ifThen(pProdutoModel.CODIGO_FOR                        = '', Unassigned, pProdutoModel.CODIGO_FOR);
  pQry.ParamByName('NOME_PRO').Value                             := ifThen(pProdutoModel.NOME_PRO                          = '', Unassigned, pProdutoModel.NOME_PRO);
  pQry.ParamByName('UNIDADE_PRO').Value                          := ifThen(pProdutoModel.UNIDADE_PRO                       = '', Unassigned, pProdutoModel.UNIDADE_PRO);
  pQry.ParamByName('SALDO_PRO').Value                            := ifThen(pProdutoModel.SALDO_PRO                         = '', Unassigned, pProdutoModel.SALDO_PRO);
  pQry.ParamByName('SALDOMIN_PRO').Value                         := ifThen(pProdutoModel.SALDOMIN_PRO                      = '', Unassigned, pProdutoModel.SALDOMIN_PRO);
  pQry.ParamByName('CUSTOMEDIO_PRO').Value                       := ifThen(pProdutoModel.CUSTOMEDIO_PRO                    = '', Unassigned, pProdutoModel.CUSTOMEDIO_PRO);
  pQry.ParamByName('CUSTOULTIMO_PRO').Value                      := ifThen(pProdutoModel.CUSTOULTIMO_PRO                   = '', Unassigned, pProdutoModel.CUSTOULTIMO_PRO);
  pQry.ParamByName('CUSTOLIQUIDO_PRO').Value                     := ifThen(pProdutoModel.CUSTOLIQUIDO_PRO                  = '', Unassigned, pProdutoModel.CUSTOLIQUIDO_PRO);
  pQry.ParamByName('CUSTODOLAR_PRO').Value                       := ifThen(pProdutoModel.CUSTODOLAR_PRO                    = '', Unassigned, pProdutoModel.CUSTODOLAR_PRO);
  pQry.ParamByName('MARGEM_PRO').Value                           := ifThen(pProdutoModel.MARGEM_PRO                        = '', Unassigned, pProdutoModel.MARGEM_PRO);
  pQry.ParamByName('VENDA_PRO').Value                            := ifThen(pProdutoModel.VENDA_PRO                         = '', Unassigned, pProdutoModel.VENDA_PRO);
  pQry.ParamByName('VENDAPRAZO_PRO').Value                       := ifThen(pProdutoModel.VENDAPRAZO_PRO                    = '', Unassigned, pProdutoModel.VENDAPRAZO_PRO);
  pQry.ParamByName('VENDAPROMOCAO_PRO').Value                    := ifThen(pProdutoModel.VENDAPROMOCAO_PRO                 = '', Unassigned, pProdutoModel.VENDAPROMOCAO_PRO);
  pQry.ParamByName('PESO_PRO').Value                             := ifThen(pProdutoModel.PESO_PRO                          = '', Unassigned, pProdutoModel.PESO_PRO);
  pQry.ParamByName('VENDAMINIMA_PRO').Value                      := ifThen(pProdutoModel.VENDAMINIMA_PRO                   = '', Unassigned, pProdutoModel.VENDAMINIMA_PRO);
  pQry.ParamByName('VENDAWEB_PRO').Value                         := ifThen(pProdutoModel.VENDAWEB_PRO                      = '', Unassigned, pProdutoModel.VENDAWEB_PRO);
  pQry.ParamByName('MARCA_PRO').Value                            := ifThen(pProdutoModel.MARCA_PRO                         = '', Unassigned, pProdutoModel.MARCA_PRO);
  pQry.ParamByName('APLICACAO_PRO').Value                        := ifThen(pProdutoModel.APLICACAO_PRO                     = '', Unassigned, pProdutoModel.APLICACAO_PRO);
  pQry.ParamByName('IMAGEM_PRO').Value                           := ifThen(pProdutoModel.IMAGEM_PRO                        = '', Unassigned, pProdutoModel.IMAGEM_PRO);
  pQry.ParamByName('CODIGO_MAR').Value                           := ifThen(pProdutoModel.CODIGO_MAR                        = '', Unassigned, pProdutoModel.CODIGO_MAR);
  pQry.ParamByName('COMISSAO_PRO').Value                         := ifThen(pProdutoModel.COMISSAO_PRO                      = '', Unassigned, pProdutoModel.COMISSAO_PRO);
  pQry.ParamByName('CODIGO_SUB').Value                           := ifThen(pProdutoModel.CODIGO_SUB                        = '', Unassigned, pProdutoModel.CODIGO_SUB);
  pQry.ParamByName('DATADOLAR_PRO').Value                        := ifThen(pProdutoModel.DATADOLAR_PRO                     = '', Unassigned, pProdutoModel.DATADOLAR_PRO);
  pQry.ParamByName('VALORDOLAR_PRO').Value                       := ifThen(pProdutoModel.VALORDOLAR_PRO                    = '', Unassigned, pProdutoModel.VALORDOLAR_PRO);
  pQry.ParamByName('GARANTIA_PRO').Value                         := ifThen(pProdutoModel.GARANTIA_PRO                      = '', Unassigned, pProdutoModel.GARANTIA_PRO);
  pQry.ParamByName('NOVIDADE_PRO').Value                         := ifThen(pProdutoModel.NOVIDADE_PRO                      = '', Unassigned, pProdutoModel.NOVIDADE_PRO);
  pQry.ParamByName('BARRAS_PRO').Value                           := ifThen(pProdutoModel.BARRAS_PRO                        = '', Unassigned, pProdutoModel.BARRAS_PRO);
  pQry.ParamByName('USUARIO_PRO').Value                          := ifThen(pProdutoModel.USUARIO_PRO                       = '', Unassigned, pProdutoModel.USUARIO_PRO);
  pQry.ParamByName('IPI_PRO').Value                              := ifThen(pProdutoModel.IPI_PRO                           = '', Unassigned, pProdutoModel.IPI_PRO);
  pQry.ParamByName('FRETE_PRO').Value                            := ifThen(pProdutoModel.FRETE_PRO                         = '', Unassigned, pProdutoModel.FRETE_PRO);
  pQry.ParamByName('ULTIMAVENDA_PRO').Value                      := ifThen(pProdutoModel.ULTIMAVENDA_PRO                   = '', Unassigned, pProdutoModel.ULTIMAVENDA_PRO);
  pQry.ParamByName('QTDEDIAS_PRO').Value                         := ifThen(pProdutoModel.QTDEDIAS_PRO                      = '', Unassigned, pProdutoModel.QTDEDIAS_PRO);
  pQry.ParamByName('CODLISTA_COD').Value                         := ifThen(pProdutoModel.CODLISTA_COD                      = '', Unassigned, pProdutoModel.CODLISTA_COD);
  pQry.ParamByName('ICMS_PRO').Value                             := ifThen(pProdutoModel.ICMS_PRO                          = '', Unassigned, pProdutoModel.ICMS_PRO);
  pQry.ParamByName('DESCRICAO').Value                            := ifThen(pProdutoModel.DESCRICAO                         = '', Unassigned, pProdutoModel.DESCRICAO);
  pQry.ParamByName('PRODUTO_FINAL').Value                        := ifThen(pProdutoModel.PRODUTO_FINAL                     = '', Unassigned, pProdutoModel.PRODUTO_FINAL);
  pQry.ParamByName('QTDE_PRODUZIR').Value                        := ifThen(pProdutoModel.QTDE_PRODUZIR                     = '', Unassigned, pProdutoModel.QTDE_PRODUZIR);
  pQry.ParamByName('PRINCIPIO_ATIVO').Value                      := ifThen(pProdutoModel.PRINCIPIO_ATIVO                   = '', Unassigned, pProdutoModel.PRINCIPIO_ATIVO);
  pQry.ParamByName('CODIGO_FORNECEDOR').Value                    := ifThen(pProdutoModel.CODIGO_FORNECEDOR                 = '', Unassigned, pProdutoModel.CODIGO_FORNECEDOR);
  pQry.ParamByName('STATUS_PRO').Value                           := ifThen(pProdutoModel.STATUS_PRO                        = '', Unassigned, pProdutoModel.STATUS_PRO);
  pQry.ParamByName('LOJA').Value                                 := ifThen(pProdutoModel.LOJA                              = '', Unassigned, pProdutoModel.LOJA);
  pQry.ParamByName('ECF_PRO').Value                              := ifThen(pProdutoModel.ECF_PRO                           = '', Unassigned, pProdutoModel.ECF_PRO);
  pQry.ParamByName('LISTA').Value                                := ifThen(pProdutoModel.LISTA                             = '', Unassigned, pProdutoModel.LISTA);
  pQry.ParamByName('COMIS_PRO').Value                            := ifThen(pProdutoModel.COMIS_PRO                         = '', Unassigned, pProdutoModel.COMIS_PRO);
  pQry.ParamByName('DESCONTO_PRO').Value                         := ifThen(pProdutoModel.DESCONTO_PRO                      = '', Unassigned, pProdutoModel.DESCONTO_PRO);
  pQry.ParamByName('PMC_PRO').Value                              := ifThen(pProdutoModel.PMC_PRO                           = '', Unassigned, pProdutoModel.PMC_PRO);
  pQry.ParamByName('PRECO_FABRICANTE').Value                     := ifThen(pProdutoModel.PRECO_FABRICANTE                  = '', Unassigned, pProdutoModel.PRECO_FABRICANTE);
  pQry.ParamByName('SALDO').Value                                := ifThen(pProdutoModel.SALDO                             = '', Unassigned, pProdutoModel.SALDO);
  pQry.ParamByName('CLAS_FISCAL_PRO').Value                      := ifThen(pProdutoModel.CLAS_FISCAL_PRO                   = '', Unassigned, pProdutoModel.CLAS_FISCAL_PRO);
  pQry.ParamByName('TABELA_VENDA').Value                         := ifThen(pProdutoModel.TABELA_VENDA                      = '', Unassigned, pProdutoModel.TABELA_VENDA);
  pQry.ParamByName('PRODUTO_REFERENTE').Value                    := ifThen(pProdutoModel.PRODUTO_REFERENTE                 = '', Unassigned, pProdutoModel.PRODUTO_REFERENTE);
  pQry.ParamByName('TABICMS_PRO').Value                          := ifThen(pProdutoModel.TABICMS_PRO                       = '', Unassigned, pProdutoModel.TABICMS_PRO);
  pQry.ParamByName('VALIDADE_PRO').Value                         := ifThen(pProdutoModel.VALIDADE_PRO                      = '', Unassigned, pProdutoModel.VALIDADE_PRO);
  pQry.ParamByName('PESQUISA').Value                             := ifThen(pProdutoModel.PESQUISA                          = '', Unassigned, pProdutoModel.PESQUISA);
  pQry.ParamByName('METROSBARRAS_PRO').Value                     := ifThen(pProdutoModel.METROSBARRAS_PRO                  = '', Unassigned, pProdutoModel.METROSBARRAS_PRO);
  pQry.ParamByName('ALIQUOTA_PIS').Value                         := ifThen(pProdutoModel.ALIQUOTA_PIS                      = '', Unassigned, pProdutoModel.ALIQUOTA_PIS);
  pQry.ParamByName('ALIQUOTA_COFINS').Value                      := ifThen(pProdutoModel.ALIQUOTA_COFINS                   = '', Unassigned, pProdutoModel.ALIQUOTA_COFINS);
  pQry.ParamByName('CST_COFINS').Value                           := ifThen(pProdutoModel.CST_COFINS                        = '', Unassigned, pProdutoModel.CST_COFINS);
  pQry.ParamByName('CST_PIS').Value                              := ifThen(pProdutoModel.CST_PIS                           = '', Unassigned, pProdutoModel.CST_PIS);
  pQry.ParamByName('CSOSN').Value                                := ifThen(pProdutoModel.CSOSN                             = '', Unassigned, pProdutoModel.CSOSN);
  pQry.ParamByName('QUTDE_MAXIMA').Value                         := ifThen(pProdutoModel.QUTDE_MAXIMA                      = '', Unassigned, pProdutoModel.QUTDE_MAXIMA);
  pQry.ParamByName('ULTIMA_ALTERACAO_PRO').Value                 := ifThen(pProdutoModel.ULTIMA_ALTERACAO_PRO              = '', Unassigned, pProdutoModel.ULTIMA_ALTERACAO_PRO);
  pQry.ParamByName('LOCALIZACAO').Value                          := ifThen(pProdutoModel.LOCALIZACAO                       = '', Unassigned, pProdutoModel.LOCALIZACAO);
  pQry.ParamByName('PRODUTO_NFE').Value                          := ifThen(pProdutoModel.PRODUTO_NFE                       = '', Unassigned, pProdutoModel.PRODUTO_NFE);
  pQry.ParamByName('CNPJ_PRODUTO_NFE').Value                     := ifThen(pProdutoModel.CNPJ_PRODUTO_NFE                  = '', Unassigned, pProdutoModel.CNPJ_PRODUTO_NFE);
  pQry.ParamByName('MATERIAL').Value                             := ifThen(pProdutoModel.MATERIAL                          = '', Unassigned, pProdutoModel.MATERIAL);
  pQry.ParamByName('PEDIDO_MENSAL').Value                        := ifThen(pProdutoModel.PEDIDO_MENSAL                     = '', Unassigned, pProdutoModel.PEDIDO_MENSAL);
  pQry.ParamByName('QUANT_PECA_BARRA').Value                     := ifThen(pProdutoModel.QUANT_PECA_BARRA                  = '', Unassigned, pProdutoModel.QUANT_PECA_BARRA);
  pQry.ParamByName('QUANT_BARRA_USADAS').Value                   := ifThen(pProdutoModel.QUANT_BARRA_USADAS                = '', Unassigned, pProdutoModel.QUANT_BARRA_USADAS);
  pQry.ParamByName('VALOR_MP').Value                             := ifThen(pProdutoModel.VALOR_MP                          = '', Unassigned, pProdutoModel.VALOR_MP);
  pQry.ParamByName('QUANT_PECA_HORA').Value                      := ifThen(pProdutoModel.QUANT_PECA_HORA                   = '', Unassigned, pProdutoModel.QUANT_PECA_HORA);
  pQry.ParamByName('SERRA').Value                                := ifThen(pProdutoModel.SERRA                             = '', Unassigned, pProdutoModel.SERRA);
  pQry.ParamByName('FURADEIRA').Value                            := ifThen(pProdutoModel.FURADEIRA                         = '', Unassigned, pProdutoModel.FURADEIRA);
  pQry.ParamByName('ROSQUEADEIRA').Value                         := ifThen(pProdutoModel.ROSQUEADEIRA                      = '', Unassigned, pProdutoModel.ROSQUEADEIRA);
  pQry.ParamByName('TORNO').Value                                := ifThen(pProdutoModel.TORNO                             = '', Unassigned, pProdutoModel.TORNO);
  pQry.ParamByName('GALVANIZACAO').Value                         := ifThen(pProdutoModel.GALVANIZACAO                      = '', Unassigned, pProdutoModel.GALVANIZACAO);
  pQry.ParamByName('TEMPERA').Value                              := ifThen(pProdutoModel.TEMPERA                           = '', Unassigned, pProdutoModel.TEMPERA);
  pQry.ParamByName('FREZADORA').Value                            := ifThen(pProdutoModel.FREZADORA                         = '', Unassigned, pProdutoModel.FREZADORA);
  pQry.ParamByName('FRETE').Value                                := ifThen(pProdutoModel.FRETE                             = '', Unassigned, pProdutoModel.FRETE);
  pQry.ParamByName('MARGEM_LUCRO').Value                         := ifThen(pProdutoModel.MARGEM_LUCRO                      = '', Unassigned, pProdutoModel.MARGEM_LUCRO);
  pQry.ParamByName('PORCENTAGEM_NFE').Value                      := ifThen(pProdutoModel.PORCENTAGEM_NFE                   = '', Unassigned, pProdutoModel.PORCENTAGEM_NFE);
  pQry.ParamByName('HORA_MAQUINA').Value                         := ifThen(pProdutoModel.HORA_MAQUINA                      = '', Unassigned, pProdutoModel.HORA_MAQUINA);
  pQry.ParamByName('CODIGO_FORNECEDOR2').Value                   := ifThen(pProdutoModel.CODIGO_FORNECEDOR2                = '', Unassigned, pProdutoModel.CODIGO_FORNECEDOR2);
  pQry.ParamByName('CODIGO_FORNECEDOR3').Value                   := ifThen(pProdutoModel.CODIGO_FORNECEDOR3                = '', Unassigned, pProdutoModel.CODIGO_FORNECEDOR3);
  pQry.ParamByName('REFERENCIA_NEW').Value                       := ifThen(pProdutoModel.REFERENCIA_NEW                    = '', Unassigned, pProdutoModel.REFERENCIA_NEW);
  pQry.ParamByName('MULTIPLOS').Value                            := ifThen(pProdutoModel.MULTIPLOS                         = '', Unassigned, pProdutoModel.MULTIPLOS);
  pQry.ParamByName('CST_CREDITO_PIS').Value                      := ifThen(pProdutoModel.CST_CREDITO_PIS                   = '', Unassigned, pProdutoModel.CST_CREDITO_PIS);
  pQry.ParamByName('CST_CREDITO_COFINS').Value                   := ifThen(pProdutoModel.CST_CREDITO_COFINS                = '', Unassigned, pProdutoModel.CST_CREDITO_COFINS);
  pQry.ParamByName('ALIQ_CREDITO_COFINS').Value                  := ifThen(pProdutoModel.ALIQ_CREDITO_COFINS               = '', Unassigned, pProdutoModel.ALIQ_CREDITO_COFINS);
  pQry.ParamByName('ALIQ_CREDITO_PIS').Value                     := ifThen(pProdutoModel.ALIQ_CREDITO_PIS                  = '', Unassigned, pProdutoModel.ALIQ_CREDITO_PIS);
  pQry.ParamByName('CFOP_ESTADUAL_ID').Value                     := ifThen(pProdutoModel.CFOP_ESTADUAL_ID                  = '', Unassigned, pProdutoModel.CFOP_ESTADUAL_ID);
  pQry.ParamByName('CFOP_INTERESTADUAL_ID').Value                := ifThen(pProdutoModel.CFOP_INTERESTADUAL_ID             = '', Unassigned, pProdutoModel.CFOP_INTERESTADUAL_ID);
  pQry.ParamByName('CST_IPI').Value                              := ifThen(pProdutoModel.CST_IPI                           = '', Unassigned, pProdutoModel.CST_IPI);
  pQry.ParamByName('IPI_SAI').Value                              := ifThen(pProdutoModel.IPI_SAI                           = '', Unassigned, pProdutoModel.IPI_SAI);
  pQry.ParamByName('VALIDAR_CAIXA').Value                        := ifThen(pProdutoModel.VALIDAR_CAIXA                     = '', Unassigned, pProdutoModel.VALIDAR_CAIXA);
  pQry.ParamByName('USAR_INSC_ST').Value                         := ifThen(pProdutoModel.USAR_INSC_ST                      = '', Unassigned, pProdutoModel.USAR_INSC_ST);
  pQry.ParamByName('FORNECEDOR_CODIGO').Value                    := ifThen(pProdutoModel.FORNECEDOR_CODIGO                 = '', Unassigned, pProdutoModel.FORNECEDOR_CODIGO);
  pQry.ParamByName('CONTROLE_SERIAL').Value                      := ifThen(pProdutoModel.CONTROLE_SERIAL                   = '', Unassigned, pProdutoModel.CONTROLE_SERIAL);
  pQry.ParamByName('DESMEMBRAR_KIT').Value                       := ifThen(pProdutoModel.DESMEMBRAR_KIT                    = '', Unassigned, pProdutoModel.DESMEMBRAR_KIT);
  pQry.ParamByName('CALCULO_MARGEM').Value                       := ifThen(pProdutoModel.CALCULO_MARGEM                    = '', Unassigned, pProdutoModel.CALCULO_MARGEM);
  pQry.ParamByName('PESO_LIQUIDO').Value                         := ifThen(pProdutoModel.PESO_LIQUIDO                      = '', Unassigned, pProdutoModel.PESO_LIQUIDO);
  pQry.ParamByName('CONTA_CONTABIL').Value                       := ifThen(pProdutoModel.CONTA_CONTABIL                    = '', Unassigned, pProdutoModel.CONTA_CONTABIL);
  pQry.ParamByName('LINK').Value                                 := ifThen(pProdutoModel.LINK                              = '', Unassigned, pProdutoModel.LINK);
  pQry.ParamByName('EAN_14').Value                               := ifThen(pProdutoModel.EAN_14                            = '', Unassigned, pProdutoModel.EAN_14);
  pQry.ParamByName('VALIDADE').Value                             := ifThen(pProdutoModel.VALIDADE                          = '', Unassigned, pProdutoModel.VALIDADE);
  pQry.ParamByName('USAR_BALANCA').Value                         := ifThen(pProdutoModel.USAR_BALANCA                      = '', Unassigned, pProdutoModel.USAR_BALANCA);
  pQry.ParamByName('VENDA_WEB').Value                            := ifThen(pProdutoModel.VENDA_WEB                         = '', Unassigned, pProdutoModel.VENDA_WEB);
  pQry.ParamByName('OBS_GERAL').Value                            := ifThen(pProdutoModel.OBS_GERAL                         = '', Unassigned, pProdutoModel.OBS_GERAL);
  pQry.ParamByName('MULTIPLICADOR').Value                        := ifThen(pProdutoModel.MULTIPLICADOR                     = '', Unassigned, pProdutoModel.MULTIPLICADOR);
  pQry.ParamByName('DIVIZOR').Value                              := ifThen(pProdutoModel.DIVIZOR                           = '', Unassigned, pProdutoModel.DIVIZOR);
  pQry.ParamByName('ARREDONDAMENTO').Value                       := ifThen(pProdutoModel.ARREDONDAMENTO                    = '', Unassigned, pProdutoModel.ARREDONDAMENTO);
  pQry.ParamByName('OBS_NF').Value                               := ifThen(pProdutoModel.OBS_NF                            = '', Unassigned, pProdutoModel.OBS_NF);
  pQry.ParamByName('DESTAQUE').Value                             := ifThen(pProdutoModel.DESTAQUE                          = '', Unassigned, pProdutoModel.DESTAQUE);
  pQry.ParamByName('MARGEM_PROMOCAO').Value                      := ifThen(pProdutoModel.MARGEM_PROMOCAO                   = '', Unassigned, pProdutoModel.MARGEM_PROMOCAO);
  pQry.ParamByName('TIPO_ID').Value                              := ifThen(pProdutoModel.TIPO_ID                           = '', Unassigned, pProdutoModel.TIPO_ID);
  pQry.ParamByName('PART_NUMBER').Value                          := ifThen(pProdutoModel.PART_NUMBER                       = '', Unassigned, pProdutoModel.PART_NUMBER);
  pQry.ParamByName('NFCE_CST').Value                             := ifThen(pProdutoModel.NFCE_CST                          = '', Unassigned, pProdutoModel.NFCE_CST);
  pQry.ParamByName('NFCE_CSOSN').Value                           := ifThen(pProdutoModel.NFCE_CSOSN                        = '', Unassigned, pProdutoModel.NFCE_CSOSN);
  pQry.ParamByName('NFCE_ICMS').Value                            := ifThen(pProdutoModel.NFCE_ICMS                         = '', Unassigned, pProdutoModel.NFCE_ICMS);
  pQry.ParamByName('NFCE_CFOP').Value                            := ifThen(pProdutoModel.NFCE_CFOP                         = '', Unassigned, pProdutoModel.NFCE_CFOP);
  pQry.ParamByName('ETIQUETA_NOME').Value                        := ifThen(pProdutoModel.ETIQUETA_NOME                     = '', Unassigned, pProdutoModel.ETIQUETA_NOME);
  pQry.ParamByName('ETIQUETA_NOME_CIENTIFICO').Value             := ifThen(pProdutoModel.ETIQUETA_NOME_CIENTIFICO          = '', Unassigned, pProdutoModel.ETIQUETA_NOME_CIENTIFICO);
  pQry.ParamByName('ETIQUETA_PESO_LIQUIDO').Value                := ifThen(pProdutoModel.ETIQUETA_PESO_LIQUIDO             = '', Unassigned, pProdutoModel.ETIQUETA_PESO_LIQUIDO);
  pQry.ParamByName('ETIQUETA_PESO_BRUTO').Value                  := ifThen(pProdutoModel.ETIQUETA_PESO_BRUTO               = '', Unassigned, pProdutoModel.ETIQUETA_PESO_BRUTO);
  pQry.ParamByName('ETIQUETA_SIGLA').Value                       := ifThen(pProdutoModel.ETIQUETA_SIGLA                    = '', Unassigned, pProdutoModel.ETIQUETA_SIGLA);
  pQry.ParamByName('ETIQUETA_PORCAO').Value                      := ifThen(pProdutoModel.ETIQUETA_PORCAO                   = '', Unassigned, pProdutoModel.ETIQUETA_PORCAO);
  pQry.ParamByName('IMPRESSAO_COZINHA').Value                    := ifThen(pProdutoModel.IMPRESSAO_COZINHA                 = '', Unassigned, pProdutoModel.IMPRESSAO_COZINHA);
  pQry.ParamByName('IMPRESSAO_BALCAO').Value                     := ifThen(pProdutoModel.IMPRESSAO_BALCAO                  = '', Unassigned, pProdutoModel.IMPRESSAO_BALCAO);
  pQry.ParamByName('WEB_NOME_PRO').Value                         := ifThen(pProdutoModel.WEB_NOME_PRO                      = '', Unassigned, pProdutoModel.WEB_NOME_PRO);
  pQry.ParamByName('WEB_GERENCIA_ESTOQUE').Value                 := ifThen(pProdutoModel.WEB_GERENCIA_ESTOQUE              = '', Unassigned, pProdutoModel.WEB_GERENCIA_ESTOQUE);
  pQry.ParamByName('WEB_PRECO_VENDA').Value                      := ifThen(pProdutoModel.WEB_PRECO_VENDA                   = '', Unassigned, pProdutoModel.WEB_PRECO_VENDA);
  pQry.ParamByName('WEB_PRECO_PROMOCAO').Value                   := ifThen(pProdutoModel.WEB_PRECO_PROMOCAO                = '', Unassigned, pProdutoModel.WEB_PRECO_PROMOCAO);
  pQry.ParamByName('WEB_PESO').Value                             := ifThen(pProdutoModel.WEB_PESO                          = '', Unassigned, pProdutoModel.WEB_PESO);
  pQry.ParamByName('WEB_ALTURA').Value                           := ifThen(pProdutoModel.WEB_ALTURA                        = '', Unassigned, pProdutoModel.WEB_ALTURA);
  pQry.ParamByName('WEB_LARGURA').Value                          := ifThen(pProdutoModel.WEB_LARGURA                       = '', Unassigned, pProdutoModel.WEB_LARGURA);
  pQry.ParamByName('WEB_PROFUNDIDADE').Value                     := ifThen(pProdutoModel.WEB_PROFUNDIDADE                  = '', Unassigned, pProdutoModel.WEB_PROFUNDIDADE);
  pQry.ParamByName('CONSERVADORA').Value                         := ifThen(pProdutoModel.CONSERVADORA                      = '', Unassigned, pProdutoModel.CONSERVADORA);
  pQry.ParamByName('CLIENTE_CONSERVADORA').Value                 := ifThen(pProdutoModel.CLIENTE_CONSERVADORA              = '', Unassigned, pProdutoModel.CLIENTE_CONSERVADORA);
  pQry.ParamByName('VOLTAGEM').Value                             := ifThen(pProdutoModel.VOLTAGEM                          = '', Unassigned, pProdutoModel.VOLTAGEM);
  pQry.ParamByName('ANO_FABRICACAO').Value                       := ifThen(pProdutoModel.ANO_FABRICACAO                    = '', Unassigned, pProdutoModel.ANO_FABRICACAO);
  pQry.ParamByName('PROPRIEDADE').Value                          := ifThen(pProdutoModel.PROPRIEDADE                       = '', Unassigned, pProdutoModel.PROPRIEDADE);
  pQry.ParamByName('MODELO').Value                               := ifThen(pProdutoModel.MODELO                            = '', Unassigned, pProdutoModel.MODELO);
  pQry.ParamByName('TIPO_CONSERVADORA').Value                    := ifThen(pProdutoModel.TIPO_CONSERVADORA                 = '', Unassigned, pProdutoModel.TIPO_CONSERVADORA);
  pQry.ParamByName('FICHA_TECNICA').Value                        := ifThen(pProdutoModel.FICHA_TECNICA                     = '', Unassigned, pProdutoModel.FICHA_TECNICA);
  pQry.ParamByName('DESCRICAO_TECNICA').Value                    := ifThen(pProdutoModel.DESCRICAO_TECNICA                 = '', Unassigned, pProdutoModel.DESCRICAO_TECNICA);
  pQry.ParamByName('IMAGEM_TECNICA').Value                       := ifThen(pProdutoModel.IMAGEM_TECNICA                    = '', Unassigned, pProdutoModel.IMAGEM_TECNICA);
  pQry.ParamByName('CUSTO_MEDIDA').Value                         := ifThen(pProdutoModel.CUSTO_MEDIDA                      = '', Unassigned, pProdutoModel.CUSTO_MEDIDA);
  pQry.ParamByName('IMAGEM').Value                               := ifThen(pProdutoModel.IMAGEM                            = '', Unassigned, pProdutoModel.IMAGEM);
  pQry.ParamByName('POS_VENDA_DIAS').Value                       := ifThen(pProdutoModel.POS_VENDA_DIAS                    = '', Unassigned, pProdutoModel.POS_VENDA_DIAS);
  pQry.ParamByName('WEB_DESCONTO').Value                         := ifThen(pProdutoModel.WEB_DESCONTO                      = '', Unassigned, pProdutoModel.WEB_DESCONTO);
  pQry.ParamByName('WEB_CARACTERISTICA').Value                   := ifThen(pProdutoModel.WEB_CARACTERISTICA                = '', Unassigned, pProdutoModel.WEB_CARACTERISTICA);
  pQry.ParamByName('BONUS').Value                                := ifThen(pProdutoModel.BONUS                             = '', Unassigned, pProdutoModel.BONUS);
  pQry.ParamByName('LW').Value                                   := ifThen(pProdutoModel.LW                                = '', Unassigned, pProdutoModel.LW);
  pQry.ParamByName('OH').Value                                   := ifThen(pProdutoModel.OH                                = '', Unassigned, pProdutoModel.OH);
  pQry.ParamByName('TW').Value                                   := ifThen(pProdutoModel.TW                                = '', Unassigned, pProdutoModel.TW);
  pQry.ParamByName('TH').Value                                   := ifThen(pProdutoModel.TH                                = '', Unassigned, pProdutoModel.TH);
  pQry.ParamByName('TIPO_VENDA_COMISSAO_ID').Value               := ifThen(pProdutoModel.TIPO_VENDA_COMISSAO_ID            = '', Unassigned, pProdutoModel.TIPO_VENDA_COMISSAO_ID);
  pQry.ParamByName('DIFERENCA_CORTE').Value                      := ifThen(pProdutoModel.DIFERENCA_CORTE                   = '', Unassigned, pProdutoModel.DIFERENCA_CORTE);
  pQry.ParamByName('USAR_CONTROLE_KG').Value                     := ifThen(pProdutoModel.USAR_CONTROLE_KG                  = '', Unassigned, pProdutoModel.USAR_CONTROLE_KG);
  pQry.ParamByName('CEST').Value                                 := ifThen(pProdutoModel.CEST                              = '', Unassigned, pProdutoModel.CEST);
  pQry.ParamByName('SUGESTAO_COMPRA').Value                      := ifThen(pProdutoModel.SUGESTAO_COMPRA                   = '', Unassigned, pProdutoModel.SUGESTAO_COMPRA);
  pQry.ParamByName('STATUS_LINHA').Value                         := ifThen(pProdutoModel.STATUS_LINHA                      = '', Unassigned, pProdutoModel.STATUS_LINHA);
  pQry.ParamByName('CONTROLEALTERACAO').Value                    := ifThen(pProdutoModel.CONTROLEALTERACAO                 = '', Unassigned, pProdutoModel.CONTROLEALTERACAO);
  pQry.ParamByName('PRECO_DOLAR').Value                          := ifThen(pProdutoModel.PRECO_DOLAR                       = '', Unassigned, pProdutoModel.PRECO_DOLAR);
  pQry.ParamByName('EMBALAGEM_ID').Value                         := ifThen(pProdutoModel.EMBALAGEM_ID                      = '', Unassigned, pProdutoModel.EMBALAGEM_ID);
  pQry.ParamByName('CUSTO_MANUAL').Value                         := ifThen(pProdutoModel.CUSTO_MANUAL                      = '', Unassigned, pProdutoModel.CUSTO_MANUAL);
  pQry.ParamByName('ETIQUETA_LINHA_1').Value                     := ifThen(pProdutoModel.ETIQUETA_LINHA_1                  = '', Unassigned, pProdutoModel.ETIQUETA_LINHA_1);
  pQry.ParamByName('ETIQUETA_LINHA_2').Value                     := ifThen(pProdutoModel.ETIQUETA_LINHA_2                  = '', Unassigned, pProdutoModel.ETIQUETA_LINHA_2);
  pQry.ParamByName('SALDO_ONLINE').Value                         := ifThen(pProdutoModel.SALDO_ONLINE                      = '', Unassigned, pProdutoModel.SALDO_ONLINE);
  pQry.ParamByName('EQUIPAMENTO_ID').Value                       := ifThen(pProdutoModel.EQUIPAMENTO_ID                    = '', Unassigned, pProdutoModel.EQUIPAMENTO_ID);
  pQry.ParamByName('MEDIA_SUGESTAO').Value                       := ifThen(pProdutoModel.MEDIA_SUGESTAO                    = '', Unassigned, pProdutoModel.MEDIA_SUGESTAO);
  pQry.ParamByName('DATA_MEDIA_SUGESTAO').Value                  := ifThen(pProdutoModel.DATA_MEDIA_SUGESTAO               = '', Unassigned, pProdutoModel.DATA_MEDIA_SUGESTAO);
  pQry.ParamByName('USAR_PARTES').Value                          := ifThen(pProdutoModel.USAR_PARTES                       = '', Unassigned, pProdutoModel.USAR_PARTES);
  pQry.ParamByName('CODIGO_ANP').Value                           := ifThen(pProdutoModel.CODIGO_ANP                        = '', Unassigned, pProdutoModel.CODIGO_ANP);
  pQry.ParamByName('ALTURA_M').Value                             := ifThen(pProdutoModel.ALTURA_M                          = '', Unassigned, pProdutoModel.ALTURA_M);
  pQry.ParamByName('LARGURA_M').Value                            := ifThen(pProdutoModel.LARGURA_M                         = '', Unassigned, pProdutoModel.LARGURA_M);
  pQry.ParamByName('PROFUNDIDADE_M').Value                       := ifThen(pProdutoModel.PROFUNDIDADE_M                    = '', Unassigned, pProdutoModel.PROFUNDIDADE_M);
  pQry.ParamByName('BASE_ST_RECOLHIDO').Value                    := ifThen(pProdutoModel.BASE_ST_RECOLHIDO                 = '', Unassigned, pProdutoModel.BASE_ST_RECOLHIDO);
  pQry.ParamByName('PERCENTUAL_ST_RECOLHIDO').Value              := ifThen(pProdutoModel.PERCENTUAL_ST_RECOLHIDO           = '', Unassigned, pProdutoModel.PERCENTUAL_ST_RECOLHIDO);
  pQry.ParamByName('FCI').Value                                  := ifThen(pProdutoModel.FCI                               = '', Unassigned, pProdutoModel.FCI);
  pQry.ParamByName('WEB_PALAVRA_CHAVE').Value                    := ifThen(pProdutoModel.WEB_PALAVRA_CHAVE                 = '', Unassigned, pProdutoModel.WEB_PALAVRA_CHAVE);
  pQry.ParamByName('WEB_URL').Value                              := ifThen(pProdutoModel.WEB_URL                           = '', Unassigned, pProdutoModel.WEB_URL);
  pQry.ParamByName('WEB_COR').Value                              := ifThen(pProdutoModel.WEB_COR                           = '', Unassigned, pProdutoModel.WEB_COR);
  pQry.ParamByName('WEB_TAMANHO').Value                          := ifThen(pProdutoModel.WEB_TAMANHO                       = '', Unassigned, pProdutoModel.WEB_TAMANHO);
  pQry.ParamByName('IPI_CENQ').Value                             := ifThen(pProdutoModel.IPI_CENQ                          = '', Unassigned, pProdutoModel.IPI_CENQ);
  pQry.ParamByName('VOLUME_QTDE').Value                          := ifThen(pProdutoModel.VOLUME_QTDE                       = '', Unassigned, pProdutoModel.VOLUME_QTDE);
  pQry.ParamByName('M3').Value                                   := ifThen(pProdutoModel.M3                                = '', Unassigned, pProdutoModel.M3);
  pQry.ParamByName('TIPO_ITEM').Value                            := ifThen(pProdutoModel.TIPO_ITEM                         = '', Unassigned, pProdutoModel.TIPO_ITEM);
  pQry.ParamByName('MARGEM_PRAZO').Value                         := ifThen(pProdutoModel.MARGEM_PRAZO                      = '', Unassigned, pProdutoModel.MARGEM_PRAZO);
  pQry.ParamByName('VALIDAR_LOTE').Value                         := ifThen(pProdutoModel.VALIDAR_LOTE                      = '', Unassigned, pProdutoModel.VALIDAR_LOTE);
  pQry.ParamByName('CUSTOBASE_PRO').Value                        := ifThen(pProdutoModel.CUSTOBASE_PRO                     = '', Unassigned, pProdutoModel.CUSTOBASE_PRO);
  pQry.ParamByName('VALOR_VENDA_MAXIMO').Value                   := ifThen(pProdutoModel.VALOR_VENDA_MAXIMO                = '', Unassigned, pProdutoModel.VALOR_VENDA_MAXIMO);
  pQry.ParamByName('VALOR_VENDA_MINIMO').Value                   := ifThen(pProdutoModel.VALOR_VENDA_MINIMO                = '', Unassigned, pProdutoModel.VALOR_VENDA_MINIMO);
  pQry.ParamByName('ORDEM').Value                                := ifThen(pProdutoModel.ORDEM                             = '', Unassigned, pProdutoModel.ORDEM);
  pQry.ParamByName('NOME_RESUMIDO').Value                        := ifThen(pProdutoModel.NOME_RESUMIDO                     = '', Unassigned, pProdutoModel.NOME_RESUMIDO);
  pQry.ParamByName('COMBO').Value                                := ifThen(pProdutoModel.COMBO                             = '', Unassigned, pProdutoModel.COMBO);
  pQry.ParamByName('UTRIB').Value                                := ifThen(pProdutoModel.UTRIB                             = '', Unassigned, pProdutoModel.UTRIB);
  pQry.ParamByName('QTRIB').Value                                := ifThen(pProdutoModel.QTRIB                             = '', Unassigned, pProdutoModel.QTRIB);
  pQry.ParamByName('CLIENTE_TSB').Value                          := ifThen(pProdutoModel.CLIENTE_TSB                       = '', Unassigned, pProdutoModel.CLIENTE_TSB);
  pQry.ParamByName('UUIDALTERACAO').Value                        := ifThen(pProdutoModel.UUIDALTERACAO                     = '', Unassigned, pProdutoModel.UUIDALTERACAO);
  pQry.ParamByName('RECEITA').Value                              := ifThen(pProdutoModel.RECEITA                           = '', Unassigned, pProdutoModel.RECEITA);
  pQry.ParamByName('CONTROLE_INVENTARIO').Value                  := ifThen(pProdutoModel.CONTROLE_INVENTARIO               = '', Unassigned, pProdutoModel.CONTROLE_INVENTARIO);
  pQry.ParamByName('COTACAO_TIPO').Value                         := ifThen(pProdutoModel.COTACAO_TIPO                      = '', Unassigned, pProdutoModel.COTACAO_TIPO);
  pQry.ParamByName('VENDA_COM_DESCONTO').Value                   := ifThen(pProdutoModel.VENDA_COM_DESCONTO                = '', Unassigned, pProdutoModel.VENDA_COM_DESCONTO);
  pQry.ParamByName('WEB_URL_IMAGENS').Value                      := ifThen(pProdutoModel.WEB_URL_IMAGENS                   = '', Unassigned, pProdutoModel.WEB_URL_IMAGENS);
  pQry.ParamByName('WEB_ID').Value                               := ifThen(pProdutoModel.WEB_ID                            = '', Unassigned, pProdutoModel.WEB_ID);
  pQry.ParamByName('WEB_INTEGRA').Value                          := ifThen(pProdutoModel.WEB_INTEGRA                       = '', Unassigned, pProdutoModel.WEB_INTEGRA);
  pQry.ParamByName('WEB_GERENCIA_PRECO_VENDA').Value             := ifThen(pProdutoModel.WEB_GERENCIA_PRECO_VENDA          = '', Unassigned, pProdutoModel.WEB_GERENCIA_PRECO_VENDA);
  pQry.ParamByName('WEB_GERENCIA_IMAGENS').Value                 := ifThen(pProdutoModel.WEB_GERENCIA_IMAGENS              = '', Unassigned, pProdutoModel.WEB_GERENCIA_IMAGENS);
  pQry.ParamByName('WEB_RESUMO').Value                           := ifThen(pProdutoModel.WEB_RESUMO                        = '', Unassigned, pProdutoModel.WEB_RESUMO);
  pQry.ParamByName('DESCRICAO_ANP').Value                        := ifThen(pProdutoModel.DESCRICAO_ANP                     = '', Unassigned, pProdutoModel.DESCRICAO_ANP);
  pQry.ParamByName('CBENEF').Value                               := ifThen(pProdutoModel.CBENEF                            = '', Unassigned, pProdutoModel.CBENEF);
  pQry.ParamByName('INDESCALA').Value                            := ifThen(pProdutoModel.INDESCALA                         = '', Unassigned, pProdutoModel.INDESCALA);
  pQry.ParamByName('CNPJFAB').Value                              := ifThen(pProdutoModel.CNPJFAB                           = '', Unassigned, pProdutoModel.CNPJFAB);
  pQry.ParamByName('PRODUTO_PAI').Value                          := ifThen(pProdutoModel.PRODUTO_PAI                       = '', Unassigned, pProdutoModel.PRODUTO_PAI);
  pQry.ParamByName('CONVERSAO_FRACIONADA').Value                 := ifThen(pProdutoModel.CONVERSAO_FRACIONADA              = '', Unassigned, pProdutoModel.CONVERSAO_FRACIONADA);
  pQry.ParamByName('CUSTO_FINANCEIRO').Value                     := ifThen(pProdutoModel.CUSTO_FINANCEIRO                  = '', Unassigned, pProdutoModel.CUSTO_FINANCEIRO);
  pQry.ParamByName('PRAZO_MEDIO').Value                          := ifThen(pProdutoModel.PRAZO_MEDIO                       = '', Unassigned, pProdutoModel.PRAZO_MEDIO);
  pQry.ParamByName('ARTIGO_ID').Value                            := ifThen(pProdutoModel.ARTIGO_ID                         = '', Unassigned, pProdutoModel.ARTIGO_ID);
  pQry.ParamByName('WEB_CATEGORIAS').Value                       := ifThen(pProdutoModel.WEB_CATEGORIAS                    = '', Unassigned, pProdutoModel.WEB_CATEGORIAS);
  pQry.ParamByName('WEB_TIPO_PRODUTO').Value                     := ifThen(pProdutoModel.WEB_TIPO_PRODUTO                  = '', Unassigned, pProdutoModel.WEB_TIPO_PRODUTO);
  pQry.ParamByName('SUBLIMACAO').Value                           := ifThen(pProdutoModel.SUBLIMACAO                        = '', Unassigned, pProdutoModel.SUBLIMACAO);
  pQry.ParamByName('LISTAR_PRODUCAO').Value                      := ifThen(pProdutoModel.LISTAR_PRODUCAO                   = '', Unassigned, pProdutoModel.LISTAR_PRODUCAO);
  pQry.ParamByName('LISTAR_ROMANEIO').Value                      := ifThen(pProdutoModel.LISTAR_ROMANEIO                   = '', Unassigned, pProdutoModel.LISTAR_ROMANEIO);
  pQry.ParamByName('VALOR_TERCERIZADOS').Value                   := ifThen(pProdutoModel.VALOR_TERCERIZADOS                = '', Unassigned, pProdutoModel.VALOR_TERCERIZADOS);
  pQry.ParamByName('GARANTIA_12').Value                          := ifThen(pProdutoModel.GARANTIA_12                       = '', Unassigned, pProdutoModel.GARANTIA_12);
  pQry.ParamByName('GARANTIA_24').Value                          := ifThen(pProdutoModel.GARANTIA_24                       = '', Unassigned, pProdutoModel.GARANTIA_24);
  pQry.ParamByName('MONTAGEM').Value                             := ifThen(pProdutoModel.MONTAGEM                          = '', Unassigned, pProdutoModel.MONTAGEM);
  pQry.ParamByName('ENTREGA').Value                              := ifThen(pProdutoModel.ENTREGA                           = '', Unassigned, pProdutoModel.ENTREGA);
  pQry.ParamByName('CENQ').Value                                 := ifThen(pProdutoModel.CENQ                              = '', Unassigned, pProdutoModel.CENQ);
  pQry.ParamByName('CODIGO_ANTERIOR').Value                      := ifThen(pProdutoModel.CODIGO_ANTERIOR                   = '', Unassigned, pProdutoModel.CODIGO_ANTERIOR);
  pQry.ParamByName('VALOR_BONUS_SERVICO').Value                  := ifThen(pProdutoModel.VALOR_BONUS_SERVICO               = '', Unassigned, pProdutoModel.VALOR_BONUS_SERVICO);
  pQry.ParamByName('NFE_INTEIRO').Value                          := ifThen(pProdutoModel.NFE_INTEIRO                       = '', Unassigned, pProdutoModel.NFE_INTEIRO);
  pQry.ParamByName('GRUPO_COMISSAO_ID').Value                    := ifThen(pProdutoModel.GRUPO_COMISSAO_ID                 = '', Unassigned, pProdutoModel.GRUPO_COMISSAO_ID);
  pQry.ParamByName('VALOR_ICMS_SUBSTITUTO').Value                := ifThen(pProdutoModel.VALOR_ICMS_SUBSTITUTO             = '', Unassigned, pProdutoModel.VALOR_ICMS_SUBSTITUTO);
  pQry.ParamByName('FAMILIA').Value                              := ifThen(pProdutoModel.FAMILIA                           = '', Unassigned, pProdutoModel.FAMILIA);
  pQry.ParamByName('TIPO_PRO').Value                             := ifThen(pProdutoModel.TIPO_PRO                          = '', Unassigned, pProdutoModel.TIPO_PRO);
  pQry.ParamByName('CUSTOULTIMO_IMPORTACAO').Value               := ifThen(pProdutoModel.CUSTOULTIMO_IMPORTACAO            = '', Unassigned, pProdutoModel.CUSTOULTIMO_IMPORTACAO);
  pQry.ParamByName('PRODUTO_ORIGEM').Value                       := ifThen(pProdutoModel.PRODUTO_ORIGEM                    = '', Unassigned, pProdutoModel.PRODUTO_ORIGEM);
  pQry.ParamByName('VALOR_MONTADOR').Value                       := ifThen(pProdutoModel.VALOR_MONTADOR                    = '', Unassigned, pProdutoModel.VALOR_MONTADOR);
  pQry.ParamByName('DATA_ALTERACAO_VENDA_PRO').Value             := ifThen(pProdutoModel.DATA_ALTERACAO_VENDA_PRO          = '', Unassigned, pProdutoModel.DATA_ALTERACAO_VENDA_PRO);
  pQry.ParamByName('DATA_ALTERACAO_CUSTOULTIMO_PRO').Value       := ifThen(pProdutoModel.DATA_ALTERACAO_CUSTOULTIMO_PRO    = '', Unassigned, pProdutoModel.DATA_ALTERACAO_CUSTOULTIMO_PRO);
  pQry.ParamByName('WEB_CODIGO_INTEGRACAO_MASTER').Value         := ifThen(pProdutoModel.WEB_CODIGO_INTEGRACAO_MASTER      = '', Unassigned, pProdutoModel.WEB_CODIGO_INTEGRACAO_MASTER);
  pQry.ParamByName('WEB_CODIGO_INTEGRACAO').Value                := ifThen(pProdutoModel.WEB_CODIGO_INTEGRACAO             = '', Unassigned, pProdutoModel.WEB_CODIGO_INTEGRACAO);
  pQry.ParamByName('WEB_VARIACAO').Value                         := ifThen(pProdutoModel.WEB_VARIACAO                      = '', Unassigned, pProdutoModel.WEB_VARIACAO);
  pQry.ParamByName('PRODUTO_MODELO').Value                       := ifThen(pProdutoModel.PRODUTO_MODELO                    = '', Unassigned, pProdutoModel.PRODUTO_MODELO);
  pQry.ParamByName('DATA_CONSUMO_OMINIONE').Value                := ifThen(pProdutoModel.DATA_CONSUMO_OMINIONE             = '', Unassigned, pProdutoModel.DATA_CONSUMO_OMINIONE);
  pQry.ParamByName('CATEGORIA_ID').Value                         := ifThen(pProdutoModel.CATEGORIA_ID                      = '', Unassigned, pProdutoModel.CATEGORIA_ID);
  pQry.ParamByName('UNIDADE_ENTRADA').Value                      := ifThen(pProdutoModel.UNIDADE_ENTRADA                   = '', Unassigned, pProdutoModel.UNIDADE_ENTRADA);
  pQry.ParamByName('CPRODANVISA').Value                          := ifThen(pProdutoModel.CPRODANVISA                       = '', Unassigned, pProdutoModel.CPRODANVISA);
  pQry.ParamByName('XMOTIVOISENCAO').Value                       := ifThen(pProdutoModel.XMOTIVOISENCAO                    = '', Unassigned, pProdutoModel.XMOTIVOISENCAO);
  pQry.ParamByName('VPMC').Value                                 := ifThen(pProdutoModel.VPMC                              = '', Unassigned, pProdutoModel.VPMC);
  pQry.ParamByName('PRODUTO_FILHO').Value                        := ifThen(pProdutoModel.PRODUTO_FILHO                     = '', Unassigned, pProdutoModel.PRODUTO_FILHO);
  pQry.ParamByName('CONVERSAO_FRACIONADA_FILHO').Value           := ifThen(pProdutoModel.CONVERSAO_FRACIONADA_FILHO        = '', Unassigned, pProdutoModel.CONVERSAO_FRACIONADA_FILHO);
  pQry.ParamByName('PERCENTUAL_PERDA_MATERIA_PRIMA').Value       := ifThen(pProdutoModel.PERCENTUAL_PERDA_MATERIA_PRIMA    = '', Unassigned, pProdutoModel.PERCENTUAL_PERDA_MATERIA_PRIMA);
  pQry.ParamByName('EXTIPI').Value                               := ifThen(pProdutoModel.EXTIPI                            = '', Unassigned, pProdutoModel.EXTIPI);
end;

procedure TProdutosDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TProdutosDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TProdutosDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TProdutosDao.subtrairSaldo(pIdProduto: String; pSaldo: Double);
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := ' update produto                                     '+SLineBreak+
          '    set saldo_pro = coalesce(saldo_pro, 0) - :saldo '+SLineBreak+
          '  where codigo_pro = :codigo                        '+SLineBreak;
  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('saldo').Value   := FormataFloatFireBird(pSaldo.ToString);
    lQry.ParamByName('codigo').Value  := pIdProduto;
    lQry.ExecSQL;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TProdutosDao.valorVenda(pIdProduto: String): Variant;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select venda_pro from produto where codigo_pro = '+ QuotedStr(pIdProduto));
end;

end.
