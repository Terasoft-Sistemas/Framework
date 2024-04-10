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
  Terasoft.Utils,
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

    function ObterListaMemTable : TFDMemTable;
    function obterPrecoVenda : TFDMemTable;
    procedure obterLista;
    procedure obterListaCatalogo;

    function obterSaldo(pIdProduto: String): Double;
    procedure subtrairSaldo(pIdProduto: String; pSaldo: Double);
    procedure adicionarSaldo(pIdProduto: String; pSaldo: Double);
    function valorVenda(pIdProduto: String): Variant;
    function obterCodigobarras(pIdProduto: String): String;
    function carregaClasse(pId: String): TProdutosModel;
end;
implementation

uses
  System.Rtti;
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
    lQry.Open('select * from PRODUTO where CODIGO_PRO = '+ QuotedStr(pId));
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

    if pProdutosModel.CODIGO_PRO = '' then
      pProdutosModel.CODIGO_PRO := vIConexao.Generetor('GEN_PRODUTO');

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

      lSql := lSql +'        produto.nome_pro,                                                           '+SLineBreak+
                    '        produto.barras_pro,                                                         '+SLineBreak+
                    '        produto.codigo_pro,                                                         '+SLineBreak+
                    '        coalesce(produto.venda_pro, 0) venda_pro,                                   '+SLineBreak+
                    '        coalesce(produto.saldo_pro, 0) saldo_pro,                                   '+SLineBreak+
                    '        produto.customedio_pro,                                                     '+SLineBreak+
                    '        produto.nfce_cfop,                                                          '+SLineBreak+
                    '        produto.ean_14,                                                             '+SLineBreak+
                    '        produto.referencia_new,                                                     '+SLineBreak+
                    '        produto.unidade_pro,                                                        '+SLineBreak+
                    '        produto.garantia_12,                                                        '+SLineBreak+
                    '        produto.garantia_24,                                                        '+SLineBreak+
                    '        produto.divizor,                                                            '+SLineBreak+
                    '        produto.multiplicador,                                                      '+SLineBreak+
                    '        fornecedor.fantasia_for nome_for,                                           '+SLineBreak+
                    '        grupoproduto.nome_gru,                                                      '+SLineBreak+
                    '        subgrupoproduto.nome_sub,                                                   '+SLineBreak+
                    '        marcaproduto.nome_mar,                                                      '+SLineBreak+
                    '        produto_tipo.nome tipo_nome,                                                '+SLineBreak+
                    '        produto.margem_pro margem_pro,                                              '+SLineBreak+
                    '        produto.aliq_credito_pis,                                                   '+SLineBreak+
                    '        produto.aliq_credito_cofins,                                                '+SLineBreak+
                    '        produto.cst_credito_cofins,                                                 '+SLineBreak+
                    '        produto.cst_credito_pis,                                                    '+SLineBreak+
                    '        produto.custoultimo_pro,                                                    '+SLineBreak+
                    '        produto.ipi_pro                                                             '+SLineBreak+
                    '   from produto                                                                     '+SLineBreak+
                    '  inner join fornecedor on fornecedor.codigo_for = produto.codigo_for               '+SLineBreak+
                    '  inner join grupoproduto on grupoproduto.codigo_gru = produto.codigo_gru           '+SLineBreak+
                    '  inner join subgrupoproduto on subgrupoproduto.codigo_sub = produto.codigo_sub     '+SLineBreak+
                    '  inner join marcaproduto on marcaproduto.codigo_mar = produto.codigo_mar           '+SLineBreak+
                    '   left join produto_tipo on produto_tipo.id = produto.tipo_id                      '+SLineBreak+
                    '  where 1=1                                                                         '+SLineBreak;

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

      FProdutossLista[i].CODIGO_PRO          := lQry.FieldByName('CODIGO_PRO').AsString;
      FProdutossLista[i].NOME_PRO            := lQry.FieldByName('NOME_PRO').AsString;
      FProdutossLista[i].BARRAS_PRO          := lQry.FieldByName('BARRAS_PRO').AsString;
      FProdutossLista[i].VENDA_PRO           := lQry.FieldByName('VENDA_PRO').AsString;
      FProdutossLista[i].CUSTOMEDIO_PRO      := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
      FProdutossLista[i].NFCE_CFOP           := lQry.FieldByName('NFCE_CFOP').AsString;
      FProdutossLista[i].EAN_14              := lQry.FieldByName('EAN_14').AsString;
      FProdutossLista[i].REFERENCIA_NEW      := lQry.FieldByName('REFERENCIA_NEW').AsString;
      FProdutossLista[i].UNIDADE_PRO         := lQry.FieldByName('UNIDADE_PRO').AsString;
      FProdutossLista[i].GARANTIA_12         := lQry.FieldByName('GARANTIA_12').AsString;
      FProdutossLista[i].GARANTIA_24         := lQry.FieldByName('GARANTIA_24').AsString;
      FProdutossLista[i].DIVIZOR             := lQry.FieldByName('DIVIZOR').AsString;
      FProdutossLista[i].MULTIPLICADOR       := lQry.FieldByName('MULTIPLICADOR').AsString;
      FProdutossLista[i].SALDO_PRO           := lQry.FieldByName('SALDO_PRO').AsString;
      FProdutossLista[i].NOME_FOR            := lQry.FieldByName('NOME_FOR').AsString;
      FProdutossLista[i].NOME_GRU            := lQry.FieldByName('NOME_GRU').AsString;
      FProdutossLista[i].NOME_SUB            := lQry.FieldByName('NOME_SUB').AsString;
      FProdutossLista[i].NOME_MAR            := lQry.FieldByName('NOME_MAR').AsString;
      FProdutossLista[i].TIPO_NOME           := lQry.FieldByName('TIPO_NOME').AsString;
      FProdutossLista[i].MARGEM_PRO          := lQry.FieldByName('MARGEM_PRO').AsString;
      FProdutossLista[i].ALIQ_CREDITO_PIS    := lQry.FieldByName('ALIQ_CREDITO_PIS').AsString;
      FProdutossLista[i].ALIQ_CREDITO_COFINS := lQry.FieldByName('ALIQ_CREDITO_COFINS').AsString;
      FProdutossLista[i].CST_CREDITO_COFINS  := lQry.FieldByName('CST_CREDITO_COFINS').AsString;
      FProdutossLista[i].CST_CREDITO_PIS     := lQry.FieldByName('CST_CREDITO_PIS').AsString;
      FProdutossLista[i].CUSTOULTIMO_PRO     := lQry.FieldByName('CUSTOULTIMO_PRO').AsString;
      FProdutossLista[i].IPI_PRO             := lQry.FieldByName('IPI_PRO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TProdutosDao.obterListaCatalogo;
var
  lQry,
  lQryCD         : TFDQuery;
  i              : Integer;
  lPaginacao,
  lSql           : String;
begin

  FProdutossLista := TObjectList<TProdutosModel>.Create;
  lQry            := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := 'first ' + LengthPageView + ' SKIP ' + StartRecordView;

    lSQL := '  select  '+lPaginacao+'                                                           '+
            '          NOME_PRO,                                                                '+
            '          BARRAS_PRO,                                                              '+
            '          CODIGO_PRO,                                                              '+
            '          REFERENCIA_NEW,                                                          '+
            '          VENDA_PRO,                                                               '+
            '          CUSTOMEDIO_PRO,                                                          '+
            '          NFCE_CFOP,                                                               '+
            '          GARANTIA_12,                                                             '+
            '          GARANTIA_24,                                                             '+
            '          SALDO_DISPONIVEL                                                         '+
            '    from                                                                           '+
            '                                                                                   '+
            '      (                                                                            '+
            '        select produto.nome_pro,                                                   '+
            '               produto.barras_pro,                                                 '+
            '               produto.codigo_pro,                                                 '+
            '               produto.referencia_new,                                             '+
            '               produto.venda_pro,                                                  '+
            '               produto.customedio_pro,                                             '+
            '               produto.nfce_cfop,                                                  '+
            '               produto.garantia_12,                                                '+
            '               produto.garantia_24,                                                '+
            '               saldo.saldo - saldo.reservado saldo_disponivel                      '+
            '          from produto                                                             '+
            '          left join view_saldo_produto saldo on saldo.codigo = produto.codigo_pro  '+
            '       )  produto                                                                  '+
            '                                                                                   '+
            '   where 1=1                                                                       ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    vIConexao.ConfigConexaoExterna('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA);

    lQryCD := vIConexao.criarQueryExterna;
    lQryCD.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FProdutossLista.Add(TProdutosModel.Create(vIConexao));
      i := FProdutossLista.Count -1;

      FProdutossLista[i].CODIGO_PRO        := lQry.FieldByName('CODIGO_PRO').AsString;
      FProdutossLista[i].NOME_PRO          := lQry.FieldByName('NOME_PRO').AsString;
      FProdutossLista[i].BARRAS_PRO        := lQry.FieldByName('BARRAS_PRO').AsString;
      FProdutossLista[i].VENDA_PRO         := lQry.FieldByName('VENDA_PRO').AsString;
      FProdutossLista[i].CUSTOMEDIO_PRO    := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
      FProdutossLista[i].NFCE_CFOP         := lQry.FieldByName('NFCE_CFOP').AsString;
      FProdutossLista[i].GARANTIA_12       := lQry.FieldByName('GARANTIA_12').AsString;
      FProdutossLista[i].GARANTIA_24       := lQry.FieldByName('GARANTIA_24').AsString;
      FProdutossLista[i].SALDO_DISPONIVEL  := lQry.FieldByName('SALDO_DISPONIVEL').AsString;

      lQryCD.First;
      if lQryCD.Locate('CODIGO_PRO', lQry.FieldByName('CODIGO_PRO').AsString, []) then
        FProdutossLista[i].SALDO_CD := lQryCD.FieldByName('SALDO_DISPONIVEL').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
    lQryCD.Free;
  end;
end;

function TProdutosDao.ObterListaMemTable: TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: TFDMemTable;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSQL := ' Select CODIGO_PRO,      ' + SLineBreak +
            '        NOME_PRO,        ' + SLineBreak +
            '        UNIDADE_PRO      ' + SLineBreak +
            '   From PRODUTO          ' + SLineBreak +
            '  Order by NOME_PRO      ' + SLineBreak;


    lQry.Open(lSQL);
    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by '+FOrderView;

    Result := vConstrutor.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

function TProdutosDao.obterPrecoVenda: TFDMemTable;
var
  lQry : TFDQuery;
  lSql : String;
  lMemTable : TFDMemTable;
begin
  try
    lQry := vIConexao.CriarQuery;

     lSql :=' select                                                                                                                                  '+SlineBreak+
            '      tabela,                                                                                                                            '+SlineBreak+
            '      valor                                                                                                                              '+SlineBreak+
            '         from                                                                                                                            '+SlineBreak+
            '           (select                                                                                                                       '+SlineBreak+
            '                   t.nome tabela,                                                                                                        '+SlineBreak+
            '                   ti.valor_venda valor                                                                                                  '+SlineBreak+
            '              from preco_venda t                                                                                                         '+SlineBreak+
            '             inner join preco_venda_produto ti on t.id = ti.preco_venda_id                                                               '+SlineBreak+
            '             where coalesce(t.status,''A'') = ''A''                                                                                      '+SlineBreak+
            '               and coalesce(t.PRODUTOS_IGNORAR, ''A'') <> ''I''                                                                          '+SlineBreak+
            '               and ti.produto_id = '+QuotedStr(IDRecordView)+'                                                                           '+SlineBreak+
            ' union all                                                                                                                               '+SlineBreak+
            ' select                                                                                                                                  '+SlineBreak+
            '      t.nome tabela,                                                                                                                     '+SlineBreak+
            '               (select                                                                                                                   '+SlineBreak+
            '                     case                                                                                                                '+SlineBreak+
            '                         when t.acrescimo_desconto = ''D'' then pro.venda_pro - t.percentual / 100 * pro.venda_pro                       '+SlineBreak+
            '                         when t.acrescimo_desconto = ''A'' then pro.venda_pro + t.percentual / 100 * pro.venda_pro                       '+SlineBreak+
            '                     else                                                                                                                '+SlineBreak+
            '                     case                                                                                                                '+SlineBreak+
            '                         when t.tipo_custo = ''CUSTOULTIMO_PRO'' then pro.CUSTOULTIMO_PRO  + t.percentual / 100 * pro.CUSTOULTIMO_PRO    '+SlineBreak+
            '                         when t.tipo_custo = ''CUSTOMEDIO_PRO'' then pro.CUSTOMEDIO_PRO  + t.percentual / 100 * pro.CUSTOMEDIO_PRO       '+SlineBreak+
            '                         when t.tipo_custo = ''CUSTOULTIMO_PRO'' then pro.CUSTOLIQUIDO_PRO  + t.percentual / 100 * pro.CUSTOLIQUIDO_PRO  '+SlineBreak+
            '                         when t.tipo_custo = ''CUSTOULTIMO_PRO'' then pro.CUSTODOLAR_PRO  + t.percentual / 100 * pro.CUSTODOLAR_PRO      '+SlineBreak+
            '                         when t.tipo_custo = ''CUSTOULTIMO_PRO'' then pro.CUSTO_MANUAL  + t.percentual / 100 * pro.CUSTO_MANUAL          '+SlineBreak+
            '                     end                                                                                                                 '+SlineBreak+
            '                     end                                                                                                                 '+SlineBreak+
            '                from produto pro                                                                                                         '+SlineBreak+
            '               where pro.codigo_pro = '+QuotedStr(IDRecordView)+') valor                                                                 '+SlineBreak+
            '                from preco_venda t                                                                                                       '+SlineBreak+
            '               where coalesce(t.status,''A'') = ''A''                                                                                    '+SlineBreak+
            '                 and t.PRODUTOS_IGNORAR = ''I''                                                                                          '+SlineBreak+
            '                 and t.percentual > 0                                                                                                    '+SlineBreak+
            '  )                                                                                                                                      '+SlineBreak;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
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
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PRODUTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TProdutosModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pProdutoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pProdutoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
