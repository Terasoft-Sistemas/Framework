unit ProdutosDao;

interface

uses
  ProdutosModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao, Terasoft.Types;

type
  TProdutosDao = class;
  ITProdutosDao=IObject<TProdutosDao>;

  TProdutosDao = class
  private
    [weak] mySelf: ITProdutosDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FProdutossLista: IList<ITProdutosModel>;
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
    procedure SetProdutossLista(const Value: IList<ITProdutosModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;
    procedure SetIDRecordView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pProdutoModel: ITProdutosModel);

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITProdutosDao;

    property ProdutossLista: IList<ITProdutosModel> read FProdutossLista write SetProdutossLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pProdutosModel: ITProdutosModel): String;
    function alterar(pProdutosModel: ITProdutosModel): String;
    function excluir(pProdutosModel: ITProdutosModel): String;

    function obterListaConsulta: IFDDataset;
    function obterListaMemTable: IFDDataset;
    function ObterTabelaPreco: IFDDataset;

    procedure obterLista;
    procedure obterVenderItem;
    procedure obterListaCatalogo;

    function obterComissao(pCodProduto: String): IFDDataset;
    function obterSaldo(pIdProduto: String): Double;
    function obterSaldoDisponivel(pIdProduto: String): Double;
    procedure subtrairSaldo(pIdProduto: String; pSaldo: Double);
    procedure adicionarSaldo(pIdProduto: String; pSaldo: Double);
    function valorVenda(pIdProduto: String): Variant;
    function obterCodigobarras(pIdProduto: String): String;
    function carregaClasse(pId: String): ITProdutosModel;
    function ConsultaProdutosVendidos(pProduto : String) : IFDDataset;

    function ValorGarantia(pProduto: String; pValorFaixa: Double): TProdutoGarantia;


end;

implementation

uses
  {$if defined(DEBUG)}
    ClipBrd,
  {$endif}
  System.Rtti;

{ TProdutos }
function TProdutosDao.carregaClasse(pID: String): ITProdutosModel;
var
  lQry: TFDQuery;
  lModel: ITProdutosModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TProdutosModel.getNewIface(vIConexao);
  Result   := lModel;
  try
    lQry.Open('select * from PRODUTO where CODIGO_PRO = '+ QuotedStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.UUID                             := lQry.FieldByName('UUID').AsString;
    lModel.objeto.CODIGO_PRO                       := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.objeto.CODIGO_GRU                       := lQry.FieldByName('CODIGO_GRU').AsString;
    lModel.objeto.CODIGO_FOR                       := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.objeto.NOME_PRO                         := lQry.FieldByName('NOME_PRO').AsString;
    lModel.objeto.UNIDADE_PRO                      := lQry.FieldByName('UNIDADE_PRO').AsString;
    lModel.objeto.SALDO_PRO                        := lQry.FieldByName('SALDO_PRO').AsString;
    lModel.objeto.SALDOMIN_PRO                     := lQry.FieldByName('SALDOMIN_PRO').AsString;
    lModel.objeto.CUSTOMEDIO_PRO                   := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
    lModel.objeto.CUSTOULTIMO_PRO                  := lQry.FieldByName('CUSTOULTIMO_PRO').AsString;
    lModel.objeto.CUSTOLIQUIDO_PRO                 := lQry.FieldByName('CUSTOLIQUIDO_PRO').AsString;
    lModel.objeto.CUSTODOLAR_PRO                   := lQry.FieldByName('CUSTODOLAR_PRO').AsString;
    lModel.objeto.MARGEM_PRO                       := lQry.FieldByName('MARGEM_PRO').AsString;
    lModel.objeto.VENDA_PRO                        := lQry.FieldByName('VENDA_PRO').AsString;
    lModel.objeto.VENDAPRAZO_PRO                   := lQry.FieldByName('VENDAPRAZO_PRO').AsString;
    lModel.objeto.VENDAPROMOCAO_PRO                := lQry.FieldByName('VENDAPROMOCAO_PRO').AsString;
    lModel.objeto.PESO_PRO                         := lQry.FieldByName('PESO_PRO').AsString;
    lModel.objeto.VENDAMINIMA_PRO                  := lQry.FieldByName('VENDAMINIMA_PRO').AsString;
    lModel.objeto.VENDAWEB_PRO                     := lQry.FieldByName('VENDAWEB_PRO').AsString;
    lModel.objeto.MARCA_PRO                        := lQry.FieldByName('MARCA_PRO').AsString;
    lModel.objeto.APLICACAO_PRO                    := lQry.FieldByName('APLICACAO_PRO').AsString;
    lModel.objeto.IMAGEM_PRO                       := lQry.FieldByName('IMAGEM_PRO').AsString;
    lModel.objeto.CODIGO_MAR                       := lQry.FieldByName('CODIGO_MAR').AsString;
    lModel.objeto.COMISSAO_PRO                     := lQry.FieldByName('COMISSAO_PRO').AsString;
    lModel.objeto.CODIGO_SUB                       := lQry.FieldByName('CODIGO_SUB').AsString;
    lModel.objeto.DATADOLAR_PRO                    := lQry.FieldByName('DATADOLAR_PRO').AsString;
    lModel.objeto.VALORDOLAR_PRO                   := lQry.FieldByName('VALORDOLAR_PRO').AsString;
    lModel.objeto.GARANTIA_PRO                     := lQry.FieldByName('GARANTIA_PRO').AsString;
    lModel.objeto.NOVIDADE_PRO                     := lQry.FieldByName('NOVIDADE_PRO').AsString;
    lModel.objeto.BARRAS_PRO                       := lQry.FieldByName('BARRAS_PRO').AsString;
    lModel.objeto.USUARIO_PRO                      := lQry.FieldByName('USUARIO_PRO').AsString;
    lModel.objeto.IPI_PRO                          := lQry.FieldByName('IPI_PRO').AsString;
    lModel.objeto.FRETE_PRO                        := lQry.FieldByName('FRETE_PRO').AsString;
    lModel.objeto.ULTIMAVENDA_PRO                  := lQry.FieldByName('ULTIMAVENDA_PRO').AsString;
    lModel.objeto.QTDEDIAS_PRO                     := lQry.FieldByName('QTDEDIAS_PRO').AsString;
    lModel.objeto.CODLISTA_COD                     := lQry.FieldByName('CODLISTA_COD').AsString;
    lModel.objeto.ICMS_PRO                         := lQry.FieldByName('ICMS_PRO').AsString;
    lModel.objeto.DESCRICAO                        := lQry.FieldByName('DESCRICAO').AsString;
    lModel.objeto.PRODUTO_FINAL                    := lQry.FieldByName('PRODUTO_FINAL').AsString;
    lModel.objeto.QTDE_PRODUZIR                    := lQry.FieldByName('QTDE_PRODUZIR').AsString;
    lModel.objeto.PRINCIPIO_ATIVO                  := lQry.FieldByName('PRINCIPIO_ATIVO').AsString;
    lModel.objeto.CODIGO_FORNECEDOR                := lQry.FieldByName('CODIGO_FORNECEDOR').AsString;
    lModel.objeto.STATUS_PRO                       := lQry.FieldByName('STATUS_PRO').AsString;
    lModel.objeto.LOJA                             := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.ECF_PRO                          := lQry.FieldByName('ECF_PRO').AsString;
    lModel.objeto.LISTA                            := lQry.FieldByName('LISTA').AsString;
    lModel.objeto.COMIS_PRO                        := lQry.FieldByName('COMIS_PRO').AsString;
    lModel.objeto.DESCONTO_PRO                     := lQry.FieldByName('DESCONTO_PRO').AsString;
    lModel.objeto.PMC_PRO                          := lQry.FieldByName('PMC_PRO').AsString;
    lModel.objeto.PRECO_FABRICANTE                 := lQry.FieldByName('PRECO_FABRICANTE').AsString;
    lModel.objeto.SALDO                            := lQry.FieldByName('SALDO').AsString;
    lModel.objeto.CLAS_FISCAL_PRO                  := lQry.FieldByName('CLAS_FISCAL_PRO').AsString;
    lModel.objeto.TABELA_VENDA                     := lQry.FieldByName('TABELA_VENDA').AsString;
    lModel.objeto.PRODUTO_REFERENTE                := lQry.FieldByName('PRODUTO_REFERENTE').AsString;
    lModel.objeto.TABICMS_PRO                      := lQry.FieldByName('TABICMS_PRO').AsString;
    lModel.objeto.VALIDADE_PRO                     := lQry.FieldByName('VALIDADE_PRO').AsString;
    lModel.objeto.PESQUISA                         := lQry.FieldByName('PESQUISA').AsString;
    lModel.objeto.METROSBARRAS_PRO                 := lQry.FieldByName('METROSBARRAS_PRO').AsString;
    lModel.objeto.ALIQUOTA_PIS                     := lQry.FieldByName('ALIQUOTA_PIS').AsString;
    lModel.objeto.ALIQUOTA_COFINS                  := lQry.FieldByName('ALIQUOTA_COFINS').AsString;
    lModel.objeto.CST_COFINS                       := lQry.FieldByName('CST_COFINS').AsString;
    lModel.objeto.CST_PIS                          := lQry.FieldByName('CST_PIS').AsString;
    lModel.objeto.CSOSN                            := lQry.FieldByName('CSOSN').AsString;
    lModel.objeto.QUTDE_MAXIMA                     := lQry.FieldByName('QUTDE_MAXIMA').AsString;
    lModel.objeto.ULTIMA_ALTERACAO_PRO             := lQry.FieldByName('ULTIMA_ALTERACAO_PRO').AsString;
    lModel.objeto.LOCALIZACAO                      := lQry.FieldByName('LOCALIZACAO').AsString;
    lModel.objeto.PRODUTO_NFE                      := lQry.FieldByName('PRODUTO_NFE').AsString;
    lModel.objeto.CNPJ_PRODUTO_NFE                 := lQry.FieldByName('CNPJ_PRODUTO_NFE').AsString;
    lModel.objeto.ID                               := lQry.FieldByName('ID').AsString;
    lModel.objeto.MATERIAL                         := lQry.FieldByName('MATERIAL').AsString;
    lModel.objeto.PEDIDO_MENSAL                    := lQry.FieldByName('PEDIDO_MENSAL').AsString;
    lModel.objeto.QUANT_PECA_BARRA                 := lQry.FieldByName('QUANT_PECA_BARRA').AsString;
    lModel.objeto.QUANT_BARRA_USADAS               := lQry.FieldByName('QUANT_BARRA_USADAS').AsString;
    lModel.objeto.VALOR_MP                         := lQry.FieldByName('VALOR_MP').AsString;
    lModel.objeto.QUANT_PECA_HORA                  := lQry.FieldByName('QUANT_PECA_HORA').AsString;
    lModel.objeto.SERRA                            := lQry.FieldByName('SERRA').AsString;
    lModel.objeto.FURADEIRA                        := lQry.FieldByName('FURADEIRA').AsString;
    lModel.objeto.ROSQUEADEIRA                     := lQry.FieldByName('ROSQUEADEIRA').AsString;
    lModel.objeto.TORNO                            := lQry.FieldByName('TORNO').AsString;
    lModel.objeto.GALVANIZACAO                     := lQry.FieldByName('GALVANIZACAO').AsString;
    lModel.objeto.TEMPERA                          := lQry.FieldByName('TEMPERA').AsString;
    lModel.objeto.FREZADORA                        := lQry.FieldByName('FREZADORA').AsString;
    lModel.objeto.FRETE                            := lQry.FieldByName('FRETE').AsString;
    lModel.objeto.MARGEM_LUCRO                     := lQry.FieldByName('MARGEM_LUCRO').AsString;
    lModel.objeto.PORCENTAGEM_NFE                  := lQry.FieldByName('PORCENTAGEM_NFE').AsString;
    lModel.objeto.HORA_MAQUINA                     := lQry.FieldByName('HORA_MAQUINA').AsString;
    lModel.objeto.CODIGO_FORNECEDOR2               := lQry.FieldByName('CODIGO_FORNECEDOR2').AsString;
    lModel.objeto.CODIGO_FORNECEDOR3               := lQry.FieldByName('CODIGO_FORNECEDOR3').AsString;
    lModel.objeto.REFERENCIA_NEW                   := lQry.FieldByName('REFERENCIA_NEW').AsString;
    lModel.objeto.MULTIPLOS                        := lQry.FieldByName('MULTIPLOS').AsString;
    lModel.objeto.CST_CREDITO_PIS                  := lQry.FieldByName('CST_CREDITO_PIS').AsString;
    lModel.objeto.CST_CREDITO_COFINS               := lQry.FieldByName('CST_CREDITO_COFINS').AsString;
    lModel.objeto.ALIQ_CREDITO_COFINS              := lQry.FieldByName('ALIQ_CREDITO_COFINS').AsString;
    lModel.objeto.ALIQ_CREDITO_PIS                 := lQry.FieldByName('ALIQ_CREDITO_PIS').AsString;
    lModel.objeto.CFOP_ESTADUAL_ID                 := lQry.FieldByName('CFOP_ESTADUAL_ID').AsString;
    lModel.objeto.CFOP_INTERESTADUAL_ID            := lQry.FieldByName('CFOP_INTERESTADUAL_ID').AsString;
    lModel.objeto.CST_IPI                          := lQry.FieldByName('CST_IPI').AsString;
    lModel.objeto.IPI_SAI                          := lQry.FieldByName('IPI_SAI').AsString;
    lModel.objeto.VALIDAR_CAIXA                    := lQry.FieldByName('VALIDAR_CAIXA').AsString;
    lModel.objeto.USAR_INSC_ST                     := lQry.FieldByName('USAR_INSC_ST').AsString;
    lModel.objeto.FORNECEDOR_CODIGO                := lQry.FieldByName('FORNECEDOR_CODIGO').AsString;
    lModel.objeto.CONTROLE_SERIAL                  := lQry.FieldByName('CONTROLE_SERIAL').AsString;
    lModel.objeto.DESMEMBRAR_KIT                   := lQry.FieldByName('DESMEMBRAR_KIT').AsString;
    lModel.objeto.CALCULO_MARGEM                   := lQry.FieldByName('CALCULO_MARGEM').AsString;
    lModel.objeto.PESO_LIQUIDO                     := lQry.FieldByName('PESO_LIQUIDO').AsString;
    lModel.objeto.CONTA_CONTABIL                   := lQry.FieldByName('CONTA_CONTABIL').AsString;
    lModel.objeto.LINK                             := lQry.FieldByName('LINK').AsString;
    lModel.objeto.EAN_14                           := lQry.FieldByName('EAN_14').AsString;
    lModel.objeto.VALIDADE                         := lQry.FieldByName('VALIDADE').AsString;
    lModel.objeto.USAR_BALANCA                     := lQry.FieldByName('USAR_BALANCA').AsString;
    lModel.objeto.VENDA_WEB                        := lQry.FieldByName('VENDA_WEB').AsString;
    lModel.objeto.SYSTIME                          := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.OBS_GERAL                        := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.objeto.MULTIPLICADOR                    := lQry.FieldByName('MULTIPLICADOR').AsString;
    lModel.objeto.DIVIZOR                          := lQry.FieldByName('DIVIZOR').AsString;
    lModel.objeto.ARREDONDAMENTO                   := lQry.FieldByName('ARREDONDAMENTO').AsString;
    lModel.objeto.OBS_NF                           := lQry.FieldByName('OBS_NF').AsString;
    lModel.objeto.DESTAQUE                         := lQry.FieldByName('DESTAQUE').AsString;
    lModel.objeto.MARGEM_PROMOCAO                  := lQry.FieldByName('MARGEM_PROMOCAO').AsString;
    lModel.objeto.TIPO_ID                          := lQry.FieldByName('TIPO_ID').AsString;
    lModel.objeto.PART_NUMBER                      := lQry.FieldByName('PART_NUMBER').AsString;
    lModel.objeto.NFCE_CST                         := lQry.FieldByName('NFCE_CST').AsString;
    lModel.objeto.NFCE_CSOSN                       := lQry.FieldByName('NFCE_CSOSN').AsString;
    lModel.objeto.NFCE_ICMS                        := lQry.FieldByName('NFCE_ICMS').AsString;
    lModel.objeto.NFCE_CFOP                        := lQry.FieldByName('NFCE_CFOP').AsString;
    lModel.objeto.ETIQUETA_NOME                    := lQry.FieldByName('ETIQUETA_NOME').AsString;
    lModel.objeto.ETIQUETA_NOME_CIENTIFICO         := lQry.FieldByName('ETIQUETA_NOME_CIENTIFICO').AsString;
    lModel.objeto.ETIQUETA_PESO_LIQUIDO            := lQry.FieldByName('ETIQUETA_PESO_LIQUIDO').AsString;
    lModel.objeto.ETIQUETA_PESO_BRUTO              := lQry.FieldByName('ETIQUETA_PESO_BRUTO').AsString;
    lModel.objeto.ETIQUETA_SIGLA                   := lQry.FieldByName('ETIQUETA_SIGLA').AsString;
    lModel.objeto.ETIQUETA_PORCAO                  := lQry.FieldByName('ETIQUETA_PORCAO').AsString;
    lModel.objeto.IMPRESSAO_COZINHA                := lQry.FieldByName('IMPRESSAO_COZINHA').AsString;
    lModel.objeto.IMPRESSAO_BALCAO                 := lQry.FieldByName('IMPRESSAO_BALCAO').AsString;
    lModel.objeto.WEB_NOME_PRO                     := lQry.FieldByName('WEB_NOME_PRO').AsString;
    lModel.objeto.WEB_GERENCIA_ESTOQUE             := lQry.FieldByName('WEB_GERENCIA_ESTOQUE').AsString;
    lModel.objeto.WEB_PRECO_VENDA                  := lQry.FieldByName('WEB_PRECO_VENDA').AsString;
    lModel.objeto.WEB_PRECO_PROMOCAO               := lQry.FieldByName('WEB_PRECO_PROMOCAO').AsString;
    lModel.objeto.WEB_PESO                         := lQry.FieldByName('WEB_PESO').AsString;
    lModel.objeto.WEB_ALTURA                       := lQry.FieldByName('WEB_ALTURA').AsString;
    lModel.objeto.WEB_LARGURA                      := lQry.FieldByName('WEB_LARGURA').AsString;
    lModel.objeto.WEB_PROFUNDIDADE                 := lQry.FieldByName('WEB_PROFUNDIDADE').AsString;
    lModel.objeto.CONSERVADORA                     := lQry.FieldByName('CONSERVADORA').AsString;
    lModel.objeto.CLIENTE_CONSERVADORA             := lQry.FieldByName('CLIENTE_CONSERVADORA').AsString;
    lModel.objeto.VOLTAGEM                         := lQry.FieldByName('VOLTAGEM').AsString;
    lModel.objeto.ANO_FABRICACAO                   := lQry.FieldByName('ANO_FABRICACAO').AsString;
    lModel.objeto.PROPRIEDADE                      := lQry.FieldByName('PROPRIEDADE').AsString;
    lModel.objeto.MODELO                           := lQry.FieldByName('MODELO').AsString;
    lModel.objeto.TIPO_CONSERVADORA                := lQry.FieldByName('TIPO_CONSERVADORA').AsString;
    lModel.objeto.FICHA_TECNICA                    := lQry.FieldByName('FICHA_TECNICA').AsString;
    lModel.objeto.DESCRICAO_TECNICA                := lQry.FieldByName('DESCRICAO_TECNICA').AsString;
    lModel.objeto.IMAGEM_TECNICA                   := lQry.FieldByName('IMAGEM_TECNICA').AsString;
    lModel.objeto.CUSTO_MEDIDA                     := lQry.FieldByName('CUSTO_MEDIDA').AsString;
    lModel.objeto.IMAGEM                           := lQry.FieldByName('IMAGEM').AsString;
    lModel.objeto.POS_VENDA_DIAS                   := lQry.FieldByName('POS_VENDA_DIAS').AsString;
    lModel.objeto.WEB_DESCONTO                     := lQry.FieldByName('WEB_DESCONTO').AsString;
    lModel.objeto.WEB_CARACTERISTICA               := lQry.FieldByName('WEB_CARACTERISTICA').AsString;
    lModel.objeto.BONUS                            := lQry.FieldByName('BONUS').AsString;
    lModel.objeto.LW                               := lQry.FieldByName('LW').AsString;
    lModel.objeto.OH                               := lQry.FieldByName('OH').AsString;
    lModel.objeto.TW                               := lQry.FieldByName('TW').AsString;
    lModel.objeto.TH                               := lQry.FieldByName('TH').AsString;
    lModel.objeto.TIPO_VENDA_COMISSAO_ID           := lQry.FieldByName('TIPO_VENDA_COMISSAO_ID').AsString;
    lModel.objeto.DIFERENCA_CORTE                  := lQry.FieldByName('DIFERENCA_CORTE').AsString;
    lModel.objeto.USAR_CONTROLE_KG                 := lQry.FieldByName('USAR_CONTROLE_KG').AsString;
    lModel.objeto.CEST                             := lQry.FieldByName('CEST').AsString;
    lModel.objeto.SUGESTAO_COMPRA                  := lQry.FieldByName('SUGESTAO_COMPRA').AsString;
    lModel.objeto.STATUS_LINHA                     := lQry.FieldByName('STATUS_LINHA').AsString;
    lModel.objeto.CONTROLEALTERACAO                := lQry.FieldByName('CONTROLEALTERACAO').AsString;
    lModel.objeto.PRECO_DOLAR                      := lQry.FieldByName('PRECO_DOLAR').AsString;
    lModel.objeto.EMBALAGEM_ID                     := lQry.FieldByName('EMBALAGEM_ID').AsString;
    lModel.objeto.CUSTO_MANUAL                     := lQry.FieldByName('CUSTO_MANUAL').AsString;
    lModel.objeto.ETIQUETA_LINHA_1                 := lQry.FieldByName('ETIQUETA_LINHA_1').AsString;
    lModel.objeto.ETIQUETA_LINHA_2                 := lQry.FieldByName('ETIQUETA_LINHA_2').AsString;
    lModel.objeto.SALDO_ONLINE                     := lQry.FieldByName('SALDO_ONLINE').AsString;
    lModel.objeto.EQUIPAMENTO_ID                   := lQry.FieldByName('EQUIPAMENTO_ID').AsString;
    lModel.objeto.MEDIA_SUGESTAO                   := lQry.FieldByName('MEDIA_SUGESTAO').AsString;
    lModel.objeto.DATA_MEDIA_SUGESTAO              := lQry.FieldByName('DATA_MEDIA_SUGESTAO').AsString;
    lModel.objeto.USAR_PARTES                      := lQry.FieldByName('USAR_PARTES').AsString;
    lModel.objeto.CODIGO_ANP                       := lQry.FieldByName('CODIGO_ANP').AsString;
    lModel.objeto.ALTURA_M                         := lQry.FieldByName('ALTURA_M').AsString;
    lModel.objeto.LARGURA_M                        := lQry.FieldByName('LARGURA_M').AsString;
    lModel.objeto.PROFUNDIDADE_M                   := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.objeto.BASE_ST_RECOLHIDO                := lQry.FieldByName('BASE_ST_RECOLHIDO').AsString;
    lModel.objeto.PERCENTUAL_ST_RECOLHIDO          := lQry.FieldByName('PERCENTUAL_ST_RECOLHIDO').AsString;
    lModel.objeto.FCI                              := lQry.FieldByName('FCI').AsString;
    lModel.objeto.WEB_PALAVRA_CHAVE                := lQry.FieldByName('WEB_PALAVRA_CHAVE').AsString;
    lModel.objeto.WEB_URL                          := lQry.FieldByName('WEB_URL').AsString;
    lModel.objeto.WEB_COR                          := lQry.FieldByName('WEB_COR').AsString;
    lModel.objeto.WEB_TAMANHO                      := lQry.FieldByName('WEB_TAMANHO').AsString;
    lModel.objeto.IPI_CENQ                         := lQry.FieldByName('IPI_CENQ').AsString;
    lModel.objeto.VOLUME_QTDE                      := lQry.FieldByName('VOLUME_QTDE').AsString;
    lModel.objeto.M3                               := lQry.FieldByName('M3').AsString;
    lModel.objeto.TIPO_ITEM                        := lQry.FieldByName('TIPO_ITEM').AsString;
    lModel.objeto.MARGEM_PRAZO                     := lQry.FieldByName('MARGEM_PRAZO').AsString;
    lModel.objeto.VALIDAR_LOTE                     := lQry.FieldByName('VALIDAR_LOTE').AsString;
    lModel.objeto.CUSTOBASE_PRO                    := lQry.FieldByName('CUSTOBASE_PRO').AsString;
    lModel.objeto.VALOR_VENDA_MAXIMO               := lQry.FieldByName('VALOR_VENDA_MAXIMO').AsString;
    lModel.objeto.VALOR_VENDA_MINIMO               := lQry.FieldByName('VALOR_VENDA_MINIMO').AsString;
    lModel.objeto.ORDEM                            := lQry.FieldByName('ORDEM').AsString;
    lModel.objeto.NOME_RESUMIDO                    := lQry.FieldByName('NOME_RESUMIDO').AsString;
    lModel.objeto.COMBO                            := lQry.FieldByName('COMBO').AsString;
    lModel.objeto.UTRIB                            := lQry.FieldByName('UTRIB').AsString;
    lModel.objeto.QTRIB                            := lQry.FieldByName('QTRIB').AsString;
    lModel.objeto.CLIENTE_TSB                      := lQry.FieldByName('CLIENTE_TSB').AsString;
    lModel.objeto.UUIDALTERACAO                    := lQry.FieldByName('UUIDALTERACAO').AsString;
    lModel.objeto.RECEITA                          := lQry.FieldByName('RECEITA').AsString;
    lModel.objeto.CONTROLE_INVENTARIO              := lQry.FieldByName('CONTROLE_INVENTARIO').AsString;
    lModel.objeto.COTACAO_TIPO                     := lQry.FieldByName('COTACAO_TIPO').AsString;
    lModel.objeto.VENDA_COM_DESCONTO               := lQry.FieldByName('VENDA_COM_DESCONTO').AsString;
    lModel.objeto.WEB_URL_IMAGENS                  := lQry.FieldByName('WEB_URL_IMAGENS').AsString;
    lModel.objeto.WEB_ID                           := lQry.FieldByName('WEB_ID').AsString;
    lModel.objeto.WEB_INTEGRA                      := lQry.FieldByName('WEB_INTEGRA').AsString;
    lModel.objeto.WEB_GERENCIA_PRECO_VENDA         := lQry.FieldByName('WEB_GERENCIA_PRECO_VENDA').AsString;
    lModel.objeto.WEB_GERENCIA_IMAGENS             := lQry.FieldByName('WEB_GERENCIA_IMAGENS').AsString;
    lModel.objeto.WEB_RESUMO                       := lQry.FieldByName('WEB_RESUMO').AsString;
    lModel.objeto.DESCRICAO_ANP                    := lQry.FieldByName('DESCRICAO_ANP').AsString;
    lModel.objeto.CBENEF                           := lQry.FieldByName('CBENEF').AsString;
    lModel.objeto.INDESCALA                        := lQry.FieldByName('INDESCALA').AsString;
    lModel.objeto.CNPJFAB                          := lQry.FieldByName('CNPJFAB').AsString;
    lModel.objeto.PRODUTO_PAI                      := lQry.FieldByName('PRODUTO_PAI').AsString;
    lModel.objeto.CONVERSAO_FRACIONADA             := lQry.FieldByName('CONVERSAO_FRACIONADA').AsString;
    lModel.objeto.CUSTO_FINANCEIRO                 := lQry.FieldByName('CUSTO_FINANCEIRO').AsString;
    lModel.objeto.PRAZO_MEDIO                      := lQry.FieldByName('PRAZO_MEDIO').AsString;
    lModel.objeto.ARTIGO_ID                        := lQry.FieldByName('ARTIGO_ID').AsString;
    lModel.objeto.WEB_CATEGORIAS                   := lQry.FieldByName('WEB_CATEGORIAS').AsString;
    lModel.objeto.WEB_TIPO_PRODUTO                 := lQry.FieldByName('WEB_TIPO_PRODUTO').AsString;
    lModel.objeto.SUBLIMACAO                       := lQry.FieldByName('SUBLIMACAO').AsString;
    lModel.objeto.LISTAR_PRODUCAO                  := lQry.FieldByName('LISTAR_PRODUCAO').AsString;
    lModel.objeto.LISTAR_ROMANEIO                  := lQry.FieldByName('LISTAR_ROMANEIO').AsString;
    lModel.objeto.VALOR_TERCERIZADOS               := lQry.FieldByName('VALOR_TERCERIZADOS').AsString;
    lModel.objeto.GARANTIA_12                      := lQry.FieldByName('GARANTIA_12').AsString;
    lModel.objeto.GARANTIA_24                      := lQry.FieldByName('GARANTIA_24').AsString;
    lModel.objeto.MONTAGEM                         := lQry.FieldByName('MONTAGEM').AsString;
    lModel.objeto.ENTREGA                          := lQry.FieldByName('ENTREGA').AsString;
    lModel.objeto.CENQ                             := lQry.FieldByName('CENQ').AsString;
    lModel.objeto.CODIGO_ANTERIOR                  := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.objeto.VALOR_BONUS_SERVICO              := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
    lModel.objeto.NFE_INTEIRO                      := lQry.FieldByName('NFE_INTEIRO').AsString;
    lModel.objeto.GRUPO_COMISSAO_ID                := lQry.FieldByName('GRUPO_COMISSAO_ID').AsString;
    lModel.objeto.VALOR_ICMS_SUBSTITUTO            := lQry.FieldByName('VALOR_ICMS_SUBSTITUTO').AsString;
    lModel.objeto.FAMILIA                          := lQry.FieldByName('FAMILIA').AsString;
    lModel.objeto.TIPO_PRO                         := lQry.FieldByName('TIPO_PRO').AsString;
    lModel.objeto.CUSTOULTIMO_IMPORTACAO           := lQry.FieldByName('CUSTOULTIMO_IMPORTACAO').AsString;
    lModel.objeto.PRODUTO_ORIGEM                   := lQry.FieldByName('PRODUTO_ORIGEM').AsString;
    lModel.objeto.VALOR_MONTADOR                   := lQry.FieldByName('VALOR_MONTADOR').AsString;
    lModel.objeto.DATA_ALTERACAO_VENDA_PRO         := lQry.FieldByName('DATA_ALTERACAO_VENDA_PRO').AsString;
    lModel.objeto.DATA_ALTERACAO_CUSTOULTIMO_PRO   := lQry.FieldByName('DATA_ALTERACAO_CUSTOULTIMO_PRO').AsString;
    lModel.objeto.WEB_CODIGO_INTEGRACAO_MASTER     := lQry.FieldByName('WEB_CODIGO_INTEGRACAO_MASTER').AsString;
    lModel.objeto.WEB_CODIGO_INTEGRACAO            := lQry.FieldByName('WEB_CODIGO_INTEGRACAO').AsString;
    lModel.objeto.WEB_VARIACAO                     := lQry.FieldByName('WEB_VARIACAO').AsString;
    lModel.objeto.PRODUTO_MODELO                   := lQry.FieldByName('PRODUTO_MODELO').AsString;
    lModel.objeto.DATA_CONSUMO_OMINIONE            := lQry.FieldByName('DATA_CONSUMO_OMINIONE').AsString;
    lModel.objeto.CATEGORIA_ID                     := lQry.FieldByName('CATEGORIA_ID').AsString;
    lModel.objeto.UNIDADE_ENTRADA                  := lQry.FieldByName('UNIDADE_ENTRADA').AsString;
    lModel.objeto.CPRODANVISA                      := lQry.FieldByName('CPRODANVISA').AsString;
    lModel.objeto.XMOTIVOISENCAO                   := lQry.FieldByName('XMOTIVOISENCAO').AsString;
    lModel.objeto.VPMC                             := lQry.FieldByName('VPMC').AsString;
    lModel.objeto.PRODUTO_FILHO                    := lQry.FieldByName('PRODUTO_FILHO').AsString;
    lModel.objeto.CONVERSAO_FRACIONADA_FILHO       := lQry.FieldByName('CONVERSAO_FRACIONADA_FILHO').AsString;
    lModel.objeto.PERCENTUAL_PERDA_MATERIA_PRIMA   := lQry.FieldByName('PERCENTUAL_PERDA_MATERIA_PRIMA').AsString;
    lModel.objeto.EXTIPI                           := lQry.FieldByName('EXTIPI').AsString;
    lModel.objeto.TIPO__PRO                        := lQry.FieldByName('TIPO$_PRO').AsString;
    lModel.objeto.VOLTAGEM_ID                      := lQry.FieldByName('VOLTAGEM_ID').AsString;
    lModel.objeto.COR_ID                           := lQry.FieldByName('COR_ID').AsString;
    lModel.objeto.PERMITE_VENDA_SEGURO_FR          := lQry.FieldByName('PERMITE_VENDA_SEGURO_FR').AsString;
    lModel.objeto.GRUPO_GARANTIA_ID                := lQry.FieldByName('GRUPO_GARANTIA_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TProdutosDao.ConsultaProdutosVendidos(pProduto: String): IFDDataset;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := '  select                                         '+sLineBreak+
            '         i.numero_ped as documento,              '+sLineBreak+
            '         p.codigo_pro as codigo,                 '+sLineBreak+
            '         p.nome_pro as produto,                  '+sLineBreak+
            '         i.qtde_calculada as quantidade,         '+sLineBreak+
            '         i.valorunitario_ped as valor            '+sLineBreak+
            '    from pedidoitens i, produto p                '+sLineBreak+
            '   where i.codigo_pro = p.codigo_pro             '+sLineBreak+
            '     and i.numero_ped = '+QuotedStr(pProduto)+'  '+sLineBreak;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

constructor TProdutosDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TProdutosDao.Destroy;
begin
  FProdutossLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TProdutosDao.incluir(pProdutosModel: ITProdutosModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PRODUTO', 'CODIGO_PRO');

  try
    lQry.SQL.Add(lSQL);

    if pProdutosModel.objeto.CODIGO_PRO = '' then
      pProdutosModel.objeto.CODIGO_PRO := vIConexao.Generetor('GEN_PRODUTO');

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

function TProdutosDao.alterar(pProdutosModel: ITProdutosModel): String;
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

    Result := pProdutosModel.objeto.CODIGO_PRO;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TProdutosDao.excluir(pProdutosModel: ITProdutosModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from produto where codigo_pro = :CODIGO_PRO',[pProdutosModel.objeto.CODIGO_PRO]);
   lQry.ExecSQL;
   Result := pProdutosModel.objeto.CODIGO_PRO;
  finally
    lQry.Free;
  end;
end;

class function TProdutosDao.getNewIface(pIConexao: IConexao): ITProdutosDao;
begin
  Result := TImplObjetoOwner<TProdutosDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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

procedure TProdutosDao.obterVenderItem;
var
  lQry  : TFDQuery;
  lSQL  : String;
  modelo: ITProdutosModel;
begin
  lQry := vIConexao.CriarQuery;
  FProdutossLista := TCollections.CreateList<ITProdutosModel>;

  try
    lSql := lSql +  ' select produto.codigo_pro,                                                                       '+SLineBreak+
                    '        produto.usar_balanca,                                                                     '+SLineBreak+
                    '        produto.venda_pro,                                                                        '+SLineBreak+
                    '        produto.customedio_pro,                                                                   '+SLineBreak+
                    '        coalesce(produto.saldo_pro, 0) -                                                          '+SLineBreak+
                    '        coalesce((select sum(view_reservados.reservado)                                           '+SLineBreak+
                    '                    from view_reservados                                                          '+SLineBreak+
                    '                   where view_reservados.produto_id = produto.codigo_pro), 0) as saldo_disponivel '+SLineBreak+
                    '   from produto                                                                                   '+SLineBreak+
                    '  where 1=1                                                                                       '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;

    while not lQry.Eof do
    begin
      modelo := TProdutosModel.getNewIface(vIConexao);

      FProdutossLista.Add(modelo);
      modelo.objeto.CODIGO_PRO           := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.objeto.VENDA_PRO            := lQry.FieldByName('VENDA_PRO').AsString;
      modelo.objeto.CUSTOMEDIO_PRO       := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
      modelo.objeto.USAR_BALANCA         := lQry.FieldByName('USAR_BALANCA').AsString;
      modelo.objeto.SALDO_DISPONIVEL     := lQry.FieldByName('SALDO_DISPONIVEL').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;
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

function TProdutosDao.obterComissao(pCodProduto: String): IFDDataset;
var
  lQry      : TFDQuery;
  lSql      : String;
  lMemTable : TFDMemTable;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := '  select tipo_venda_comissao_id,                  '+SlineBreak+
            '         comis_pro,                               '+SlineBreak+
            '         grupo_comissao_id                        '+SlineBreak+
            '    from produto                                  '+SlineBreak+
            '   where codigo_pro = '+ QuotedStr(pCodProduto);

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

procedure TProdutosDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITProdutosModel;
begin
  lQry := vIConexao.CriarQuery;
  FProdutossLista := TCollections.CreateList<ITProdutosModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

      lSql := lSql +'        produto.nome_pro,                                                                          '+SLineBreak+
                    '        produto.barras_pro,                                                                        '+SLineBreak+
                    '        produto.codigo_pro,                                                                        '+SLineBreak+
                    '        coalesce(produto.venda_pro, 0) venda_pro,                                                  '+SLineBreak+
                    '        coalesce(produto.saldo_pro, 0) saldo_pro,                                                  '+SLineBreak+
                    '        produto.customedio_pro,                                                                    '+SLineBreak+
                    '        produto.nfce_cfop,                                                                         '+SLineBreak+
                    '        produto.fornecedor_codigo,                                                                 '+SLineBreak+
                    '        produto.codigo_fornecedor,                                                                 '+SLineBreak+
                    '        produto.multiplos,                                                                         '+SLineBreak+
                    '        produto.largura_m,                                                                         '+SLineBreak+
                    '        produto.altura_m,                                                                          '+SLineBreak+
                    '        produto.profundidade_m,                                                                    '+SLineBreak+
                    '        produto.peso_liquido,                                                                      '+SLineBreak+
                    '        produto.peso_pro,                                                                          '+SLineBreak+
                    '        produto.localizacao,                                                                       '+SLineBreak+
                    '        produto.aplicacao_pro,                                                                     '+SLineBreak+
                    '        produto.ean_14,                                                                            '+SLineBreak+
                    '        produto.CODLISTA_COD,                                                                      '+SLineBreak+
                    '        produto.unidade_pro,                                                                       '+SLineBreak+
                    '        produto.garantia_12,                                                                       '+SLineBreak+
                    '        produto.garantia_24,                                                                       '+SLineBreak+
                    '        produto.divizor,                                                                           '+SLineBreak+
                    '        produto.multiplicador,                                                                     '+SLineBreak+
                    '        fornecedor.fantasia_for nome_for,                                                          '+SLineBreak+
                    '        grupoproduto.nome_gru,                                                                     '+SLineBreak+
                    '        subgrupoproduto.nome_sub,                                                                  '+SLineBreak+
                    '        marcaproduto.nome_mar,                                                                     '+SLineBreak+
                    '        produto_tipo.nome tipo_nome,                                                               '+SLineBreak+
                    '        produto.margem_pro margem_pro,                                                             '+SLineBreak+
                    '        produto.aliq_credito_pis,                                                                  '+SLineBreak+
                    '        produto.aliq_credito_cofins,                                                               '+SLineBreak+
                    '        produto.cst_credito_cofins,                                                                '+SLineBreak+
                    '        produto.cst_credito_pis,                                                                   '+SLineBreak+
                    '        produto.custoultimo_pro,                                                                   '+SLineBreak+
                    '        produto.ipi_pro,                                                                           '+SLineBreak+
                    '        produto.tipo_venda_comissao_id,                                                            '+SLineBreak+
                    '        produto.comis_pro,                                                                         '+SLineBreak+
                    '        produto.grupo_comissao_id,                                                                 '+SLineBreak+
                    '        produto.codigo_gru,                                                                        '+SLineBreak+
                    '        produto.codigo_for,                                                                        '+SLineBreak+
                    '        produto.codigo_mar,                                                                        '+SLineBreak+
                    '        produto.codigo_sub,                                                                        '+SLineBreak+
                    '        produto.voltagem_id,                                                                       '+SLineBreak+
                    '        produto.cor_id,                                                                            '+SLineBreak+
                    '        produto.tipo_id,                                                                           '+SLineBreak+
                    '        produto.localizacao,                                                                       '+SLineBreak+
                    '        produto.unidade_entrada,                                                                   '+SLineBreak+
                    '        produto.nome_resumido,                                                                     '+SLineBreak+
                    '        produto.usar_balanca,                                                                      '+SLineBreak+
                    '        produto.tipo$_pro,                                                                         '+SLineBreak+
                    '        produto.web_caracteristica,                                                                '+SLineBreak+
                    '        produto.garantia_pro,                                                                      '+SLineBreak+
                    '        coalesce(produto.saldo_pro,0) - coalesce((                                                 '+SLineBreak+
                    '          select sum(view_reservados.reservado)                                                    '+SLineBreak+
                    '            from view_reservados                                                                   '+SLineBreak+
                    '           where view_reservados.produto_id = produto.codigo_pro), 0) saldo_disponivel             '+SLineBreak+
                    '   from produto                                                                                    '+SLineBreak+
                    '  inner join fornecedor on fornecedor.codigo_for = produto.codigo_for                              '+SLineBreak+
                    '  inner join grupoproduto on grupoproduto.codigo_gru = produto.codigo_gru                          '+SLineBreak+
                    '  inner join subgrupoproduto on subgrupoproduto.codigo_sub = produto.codigo_sub                    '+SLineBreak+
                    '  inner join marcaproduto on marcaproduto.codigo_mar = produto.codigo_mar                          '+SLineBreak+
                    '   left join produto_tipo on produto_tipo.id = produto.tipo_id                                     '+SLineBreak+
                    '  where 1=1                                                                                        '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    {$if defined(DEBUG)}
      Clipboard.AsText := lSQL;
    {$endif}

    lQry.Open(lSQL);

    lQry.First;

    while not lQry.Eof do
    begin
      modelo := TProdutosModel.getNewIface(vIConexao);

      FProdutossLista.Add(modelo);

      modelo.objeto.CODIGO_PRO              := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.objeto.NOME_PRO                := lQry.FieldByName('NOME_PRO').AsString;
      modelo.objeto.BARRAS_PRO              := lQry.FieldByName('BARRAS_PRO').AsString;
      modelo.objeto.VENDA_PRO               := lQry.FieldByName('VENDA_PRO').AsString;
      modelo.objeto.CUSTOMEDIO_PRO          := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
      modelo.objeto.NFCE_CFOP               := lQry.FieldByName('NFCE_CFOP').AsString;
      modelo.objeto.FORNECEDOR_CODIGO       := lQry.FieldByName('FORNECEDOR_CODIGO').AsString;
      modelo.objeto.CODIGO_FORNECEDOR       := lQry.FieldByName('CODIGO_FORNECEDOR').AsString;
      modelo.objeto.MULTIPLOS               := lQry.FieldByName('MULTIPLOS').AsString;
      modelo.objeto.LARGURA_M               := lQry.FieldByName('LARGURA_M').AsString;
      modelo.objeto.ALTURA_M                := lQry.FieldByName('ALTURA_M').AsString;
      modelo.objeto.PROFUNDIDADE_M          := lQry.FieldByName('PROFUNDIDADE_M').AsString;
      modelo.objeto.PESO_LIQUIDO            := lQry.FieldByName('PESO_LIQUIDO').AsString;
      modelo.objeto.PESO_PRO                := lQry.FieldByName('PESO_PRO').AsString;
      modelo.objeto.APLICACAO_PRO           := lQry.FieldByName('APLICACAO_PRO').AsString;
      modelo.objeto.EAN_14                  := lQry.FieldByName('EAN_14').AsString;
      modelo.objeto.LOCALIZACAO             := lQry.FieldByName('LOCALIZACAO').AsString;
      modelo.objeto.CODLISTA_COD            := lQry.FieldByName('CODLISTA_COD').AsString;
      modelo.objeto.UNIDADE_PRO             := lQry.FieldByName('UNIDADE_PRO').AsString;
      modelo.objeto.GARANTIA_12             := lQry.FieldByName('GARANTIA_12').AsString;
      modelo.objeto.GARANTIA_24             := lQry.FieldByName('GARANTIA_24').AsString;
      modelo.objeto.DIVIZOR                 := lQry.FieldByName('DIVIZOR').AsString;
      modelo.objeto.MULTIPLICADOR           := lQry.FieldByName('MULTIPLICADOR').AsString;
      modelo.objeto.SALDO_PRO               := lQry.FieldByName('SALDO_PRO').AsString;
      modelo.objeto.NOME_FOR                := lQry.FieldByName('NOME_FOR').AsString;
      modelo.objeto.NOME_GRU                := lQry.FieldByName('NOME_GRU').AsString;
      modelo.objeto.NOME_SUB                := lQry.FieldByName('NOME_SUB').AsString;
      modelo.objeto.NOME_MAR                := lQry.FieldByName('NOME_MAR').AsString;
      modelo.objeto.TIPO_NOME               := lQry.FieldByName('TIPO_NOME').AsString;
      modelo.objeto.MARGEM_PRO              := lQry.FieldByName('MARGEM_PRO').AsString;
      modelo.objeto.ALIQ_CREDITO_PIS        := lQry.FieldByName('ALIQ_CREDITO_PIS').AsString;
      modelo.objeto.ALIQ_CREDITO_COFINS     := lQry.FieldByName('ALIQ_CREDITO_COFINS').AsString;
      modelo.objeto.CST_CREDITO_COFINS      := lQry.FieldByName('CST_CREDITO_COFINS').AsString;
      modelo.objeto.CST_CREDITO_PIS         := lQry.FieldByName('CST_CREDITO_PIS').AsString;
      modelo.objeto.CUSTOULTIMO_PRO         := lQry.FieldByName('CUSTOULTIMO_PRO').AsString;
      modelo.objeto.IPI_PRO                 := lQry.FieldByName('IPI_PRO').AsString;
      modelo.objeto.TIPO_VENDA_COMISSAO_ID  := lQry.FieldByName('TIPO_VENDA_COMISSAO_ID').AsString;
      modelo.objeto.COMIS_PRO               := lQry.FieldByName('COMIS_PRO').AsString;
      modelo.objeto.GRUPO_COMISSAO_ID       := lQry.FieldByName('GRUPO_COMISSAO_ID').AsString;
      modelo.objeto.CODIGO_GRU              := lQry.FieldByName('CODIGO_GRU').AsString;
      modelo.objeto.CODIGO_FOR              := lQry.FieldByName('CODIGO_FOR').AsString;
      modelo.objeto.CODIGO_SUB              := lQry.FieldByName('CODIGO_SUB').AsString;
      modelo.objeto.CODIGO_MAR              := lQry.FieldByName('CODIGO_MAR').AsString;
      modelo.objeto.VOLTAGEM_ID             := lQry.FieldByName('VOLTAGEM_ID').AsString;
      modelo.objeto.COR_ID                  := lQry.FieldByName('COR_ID').AsString;
      modelo.objeto.TIPO_ID                 := lQry.FieldByName('TIPO_ID').AsString;
      modelo.objeto.LOCALIZACAO             := lQry.FieldByName('LOCALIZACAO').AsString;
      modelo.objeto.UNIDADE_ENTRADA         := lQry.FieldByName('UNIDADE_ENTRADA').AsString;
      modelo.objeto.NOME_RESUMIDO           := lQry.FieldByName('NOME_RESUMIDO').AsString;
      modelo.objeto.USAR_BALANCA            := lQry.FieldByName('USAR_BALANCA').AsString;
      modelo.objeto.SALDO_DISPONIVEL        := lQry.FieldByName('SALDO_DISPONIVEL').AsString;
      modelo.objeto.WEB_CARACTERISTICA      := lQry.FieldByName('WEB_CARACTERISTICA').AsString;
      modelo.objeto.GARANTIA_PRO            := lQry.FieldByName('GARANTIA_PRO').AsString;

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
  modelo : ITProdutosModel;
  lPaginacao,
  lSql           : String;
begin

  FProdutossLista := TCollections.CreateList<ITProdutosModel>;
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
            '          SALDO_DISPONIVEL,                                                        '+
            '          codigo_for,                                                              '+
            '          codigo_gru,                                                              '+
            '          codigo_sub,                                                              '+
            '          codigo_mar,                                                              '+
            '          tipo_id,                                                                 '+
            '          cor_id,                                                                  '+
            '          voltagem_id,                                                             '+
            '          entrega,                                                                 '+
            '          montagem,                                                                '+
            '          saldo_pro,                                                               '+
            '          status_pro,                                                              '+
            '          status_linha                                                             '+
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
            '               coalesce(produto.saldo_pro,0) - coalesce( saldo.saldo_reservado,0) saldo_disponivel,  '+
            '               produto.codigo_for,                                                 '+
            '               produto.codigo_gru,                                                 '+
            '               produto.codigo_sub,                                                 '+
            '               produto.codigo_mar,                                                 '+
            '               produto.tipo_id,                                                    '+
            '               produto.cor_id,                                                     '+
            '               produto.voltagem_id,                                                '+
            '               produto.entrega,                                                    '+
            '               produto.montagem,                                                   '+
            '               coalesce(produto.saldo_pro, 0) saldo_pro,                           '+
            '               produto.status_pro,                                                 '+
            '               coalesce(produto.status_linha, ''N'') status_linha                  '+
            '          from produto                                                             '+
            '          left join view_saldo_reservado saldo on saldo.produto_id = produto.codigo_pro  '+
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

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TProdutosModel.getNewIface(vIConexao);
      FProdutossLista.Add(modelo);

      modelo.objeto.CODIGO_PRO        := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.objeto.NOME_PRO          := lQry.FieldByName('NOME_PRO').AsString;
      modelo.objeto.BARRAS_PRO        := lQry.FieldByName('BARRAS_PRO').AsString;
      modelo.objeto.VENDA_PRO         := lQry.FieldByName('VENDA_PRO').AsString;
      modelo.objeto.CUSTOMEDIO_PRO    := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
      modelo.objeto.NFCE_CFOP         := lQry.FieldByName('NFCE_CFOP').AsString;
      modelo.objeto.GARANTIA_12       := lQry.FieldByName('GARANTIA_12').AsString;
      modelo.objeto.GARANTIA_24       := lQry.FieldByName('GARANTIA_24').AsString;
      modelo.objeto.SALDO_DISPONIVEL  := lQry.FieldByName('SALDO_DISPONIVEL').AsString;
      modelo.objeto.codigo_for        := lQry.FieldByName('codigo_for').AsString;
      modelo.objeto.codigo_gru        := lQry.FieldByName('codigo_gru').AsString;
      modelo.objeto.codigo_sub        := lQry.FieldByName('codigo_sub').AsString;
      modelo.objeto.codigo_mar        := lQry.FieldByName('codigo_mar').AsString;
      modelo.objeto.tipo_id           := lQry.FieldByName('tipo_id').AsString;
      modelo.objeto.cor_id            := lQry.FieldByName('cor_id').AsString;
      modelo.objeto.voltagem_id       := lQry.FieldByName('voltagem_id').AsString;
      modelo.objeto.ENTREGA           := lQry.FieldByName('ENTREGA').AsString;
      modelo.objeto.MONTAGEM          := lQry.FieldByName('MONTAGEM').AsString;
      modelo.objeto.saldo_pro         := lQry.FieldByName('saldo_pro').AsString;
      modelo.objeto.status_pro        := lQry.FieldByName('status_pro').AsString;
      modelo.objeto.status_linha      := lQry.FieldByName('status_linha').AsString;

      lQryCD.First;
      if lQryCD.Locate('CODIGO_PRO', lQry.FieldByName('CODIGO_PRO').AsString, []) then
        modelo.objeto.SALDO_CD := lQryCD.FieldByName('SALDO_DISPONIVEL').AsString
      else
        modelo.objeto.SALDO_CD := '0';

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
    lQryCD.Free;
  end;
end;

function TProdutosDao.obterListaConsulta: IFDDataset;
var
  lSQL,
  lPaginacao : String;
  lQry      : TFDQuery;
  lMemTable : IFDDataset;
begin
  lQry := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := ' select '+lPaginacao+'                                                                                                              '+sLinebreak+
            '        produto.codigo_pro,                                                                                                         '+sLinebreak+
            '        produto.nome_pro,                                                                                                           '+sLinebreak+
            '        produto.barras_pro,                                                                                                         '+sLinebreak+
            '        coalesce(produto.venda_pro, 0) venda_pro,                                                                                   '+sLinebreak+
            '        coalesce(produto.saldo_pro, 0) saldo_pro,                                                                                   '+sLinebreak+
            '        coalesce(produto.saldo_pro,0) - coalesce((select sum(view_reservados.reservado)                                             '+sLinebreak+
            '                                                    from view_reservados                                                            '+sLinebreak+
            '                                                   where view_reservados.produto_id = produto.codigo_pro), 0) saldo_disponivel      '+sLinebreak+
            '   from produto                                                                                                                     '+sLinebreak+
            '  where 1=1                                                                                                                         '+sLinebreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

function TProdutosDao.obterListaMemTable : IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: IFDDataset;
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

function TProdutosDao.ObterTabelaPreco: IFDDataset;
var
  lQry : TFDQuery;
  lSql : String;
  lMemTable : IFDDataset;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := ' select                                                                                                                             '+SlineBreak+
            '       tabela,                                                                                                                      '+SlineBreak+
            '       valor                                                                                                                        '+SlineBreak+
            '   from                                                                                                                             '+SlineBreak+
            '       (select                                                                                                                      '+SlineBreak+
            '              t.nome tabela,                                                                                                        '+SlineBreak+
            '              ti.valor_venda valor                                                                                                  '+SlineBreak+
            '          from preco_venda t                                                                                                        '+SlineBreak+
            '         inner join preco_venda_produto ti on t.id = ti.preco_venda_id                                                              '+SlineBreak+
            '         where coalesce(t.status,''A'') = ''A''                                                                                     '+SlineBreak+
            '           and coalesce(t.produtos_ignorar, ''A'') <> ''I''                                                                         '+SlineBreak+
            '           and ti.produto_id = '+QuotedStr(IDRecordView)+'                                                                          '+SlineBreak+
            '         union all                                                                                                                  '+SlineBreak+
            '        select                                                                                                                      '+SlineBreak+
            '              t.nome tabela,                                                                                                        '+SlineBreak+
            '              (select                                                                                                               '+SlineBreak+
            '                case                                                                                                                '+SlineBreak+
            '                  when t.acrescimo_desconto = ''D'' then pro.venda_pro - t.percentual / 100 * pro.venda_pro                         '+SlineBreak+
            '                  when t.acrescimo_desconto = ''A'' then pro.venda_pro + t.percentual / 100 * pro.venda_pro                         '+SlineBreak+
            '                else                                                                                                                '+SlineBreak+
            '                  case                                                                                                              '+SlineBreak+
            '                    when t.tipo_custo = ''CUSTOULTIMO_PRO'' then pro.custoultimo_pro + t.percentual / 100 * pro.custoultimo_pro     '+SlineBreak+
            '                    when t.tipo_custo = ''CUSTOMEDIO_PRO'' then pro.customedio_pro + t.percentual / 100 * pro.customedio_pro        '+SlineBreak+
            '                    when t.tipo_custo = ''CUSTOULTIMO_PRO'' then pro.custoliquido_pro + t.percentual / 100 * pro.custoliquido_pro   '+SlineBreak+
            '                    when t.tipo_custo = ''CUSTOULTIMO_PRO'' then pro.custodolar_pro + t.percentual / 100 * pro.custodolar_pro       '+SlineBreak+
            '                    when t.tipo_custo = ''CUSTOULTIMO_PRO'' then pro.custo_manual + t.percentual / 100 * pro.custo_manual           '+SlineBreak+
            '                  end                                                                                                               '+SlineBreak+
            '                end                                                                                                                 '+SlineBreak+
            '                 from produto pro                                                                                                   '+SlineBreak+
            '                where pro.codigo_pro = '+QuotedStr(IDRecordView)+') valor                                                           '+SlineBreak+
            '          from preco_venda t                                                                                                        '+SlineBreak+
            '         where coalesce(t.status,''A'') = ''A''                                                                                     '+SlineBreak+
            '           and t.produtos_ignorar = ''I''                                                                                           '+SlineBreak+
            '           and t.percentual > 0                                                                                                     '+SlineBreak+
            '               )                                                                                                                    '+SlineBreak;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

function TProdutosDao.obterSaldo(pIdProduto: String): Double;
begin
  Result := vIConexao.getConnection.ExecSQLScalar('select saldo_pro from produto where codigo_pro = '+ QuotedStr(pIdProduto));
end;

function TProdutosDao.obterSaldoDisponivel(pIdProduto: String): Double;
begin
  Result := vIConexao.getConnection.ExecSQLScalar('select coalesce(produto.saldo_pro, 0) -                                                           ' +
                                                  '       coalesce((select sum(view_reservados.reservado)                                            ' +
                                                  '                   from view_reservados                                                           ' +
                                                  '                   where view_reservados.produto_id = produto.codigo_pro), 0) as saldo_disponivel ' +
                                                  '  from produto                                                                                    ' +
                                                  ' where codigo_pro = '+ QuotedStr(pIdProduto));
end;

procedure TProdutosDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TProdutosDao.SetProdutossLista;
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

procedure TProdutosDao.setParams(var pQry: TFDQuery; pProdutoModel: ITProdutosModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PRODUTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TProdutosModel).GetProperty(StringReplace(pQry.Params[i].Name, '$', '_', [rfReplaceAll]));

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pProdutoModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pProdutoModel.objeto).AsString))
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

function TProdutosDao.ValorGarantia(pProduto: String; pValorFaixa: Double): TProdutoGarantia;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=
          ' select                                                                                      '+#13+
          '     p.permite_venda_seguro_fr,                                                              '+#13+
          '     gf.garantia_extendida_venda_12,                                                         '+#13+
          '     gf.garantia_extendida_custo_12,                                                         '+#13+
          '     gf.garantia_extendida_venda_24,                                                         '+#13+
          '     gf.garantia_extendida_custo_24,                                                         '+#13+
          '     gf.garantia_extendida_venda_36,                                                         '+#13+
          '     gf.garantia_extendida_custo_36                                                          '+#13+
          '                                                                                             '+#13+
          ' from                                                                                        '+#13+
          '     produto p                                                                               '+#13+
          '                                                                                             '+#13+
          ' left join grupo_garantia g on g.id= p.grupo_garantia_id                                     '+#13+
          ' left join grupo_garantia_faixa gf on gf.grupo_garantia_id = g.id and '+FormataFloatFireBird(FloatToStr(pValorFaixa))+' between gf.valor_venda_inicial and  gf.valor_venda_final '+#13+
          '                                                                                             '+#13+
          ' where                                                                                       '+#13+
     //     '     '+FormataFloatFireBird(FloatToStr(pValorFaixa))+' between gf.valor_venda_inicial and  gf.valor_venda_final and   '+#13+
          '     p.codigo_pro = '+QuotedStr(pProduto)+'                         '+#13;

  try
    lQry.SQL.Add(lSQL);
    lQry.Open(lSQL);

    Result.GARANTIA_EXTENDIDA_VENDA_12 := lQry.FieldByName('GARANTIA_EXTENDIDA_VENDA_12').AsFloat;
    Result.GARANTIA_EXTENDIDA_CUSTO_12 := lQry.FieldByName('GARANTIA_EXTENDIDA_CUSTO_12').AsFloat;
    Result.GARANTIA_EXTENDIDA_VENDA_24 := lQry.FieldByName('GARANTIA_EXTENDIDA_VENDA_24').AsFloat;
    Result.GARANTIA_EXTENDIDA_CUSTO_24 := lQry.FieldByName('GARANTIA_EXTENDIDA_CUSTO_24').AsFloat;
    Result.GARANTIA_EXTENDIDA_VENDA_36 := lQry.FieldByName('GARANTIA_EXTENDIDA_VENDA_36').AsFloat;
    Result.GARANTIA_EXTENDIDA_CUSTO_36 := lQry.FieldByName('GARANTIA_EXTENDIDA_CUSTO_36').AsFloat;

    if lQry.FieldByName('PERMITE_VENDA_SEGURO_FR').AsString <> 'S' then
    begin
      Result.ROUBO_FURTO_12              := 0;
      Result.ROUBO_FURTO_24              := 0;
      Result.ROUBO_FURTO_CUSTO_12        := 0;
      Result.ROUBO_FURTO_CUSTO_24        := 0;
      Result.ROUBO_FURTO_DA_12           := 0;
      Result.ROUBO_FURTO_DA_24           := 0;
      Result.ROUBO_FURTO_CUSTO_DA_12     := 0;
      Result.ROUBO_FURTO_CUSTO_DA_24     := 0;
    end else
    begin
      lSQL :=
              'select                                                            '+#13+
              'distinct                                                          '+#13+
              '                                                                  '+#13+
              '(select                                                           '+#13+
              'case c.tag                                                        '+#13+
              'when ''SEGURO_FR_PER_VENDA_12'' then c.valornumerico              '+#13+
              'end ROUBO_FURTO_12                                                '+#13+
              'from configuracoes c where c.tag = ''SEGURO_FR_PER_VENDA_12'' ),  '+#13+
              '                                                                  '+#13+
              '(select                                                           '+#13+
              'case c.tag                                                        '+#13+
              'when ''SEGURO_FR_PER_CUSTO_12'' then c.valornumerico              '+#13+
              'end ROUBO_FURTO_CUSTO_12                                          '+#13+
              'from configuracoes c where c.tag = ''SEGURO_FR_PER_CUSTO_12'' ),  '+#13+
              '                                                                  '+#13+
              '(select                                                           '+#13+
              'case c.tag                                                        '+#13+
              'when ''SEGURO_FRDA_PER_VENDA_12'' then c.valornumerico            '+#13+
              'end ROUBO_FURTO_DA_12                                             '+#13+
              'from configuracoes c where c.tag = ''SEGURO_FRDA_PER_VENDA_12'' ),'+#13+
              '                                                                  '+#13+
              '(select                                                           '+#13+
              'case c.tag                                                        '+#13+
              'when ''SEGURO_FRDA_PER_CUSTO_12'' then c.valornumerico            '+#13+
              'end ROUBO_FURTO_CUSTO_DA_12                                       '+#13+
              'from configuracoes c where c.tag = ''SEGURO_FRDA_PER_CUSTO_12'' ),'+#13+
              '                                                                  '+#13+
              '(select                                                           '+#13+
              'case c.tag                                                        '+#13+
              'when ''SEGURO_FR_PER_VENDA_24'' then c.valornumerico              '+#13+
              'end ROUBO_FURTO_24                                                '+#13+
              'from configuracoes c where c.tag = ''SEGURO_FR_PER_VENDA_24'' ),  '+#13+
              '                                                                  '+#13+
              '(select                                                           '+#13+
              'case c.tag                                                        '+#13+
              'when ''SEGURO_FR_PER_CUSTO_24'' then c.valornumerico              '+#13+
              'end ROUBO_FURTO_CUSTO_24                                          '+#13+
              'from configuracoes c where c.tag = ''SEGURO_FR_PER_CUSTO_24'' ),  '+#13+
              '                                                                  '+#13+
              '(select                                                           '+#13+
              'case c.tag                                                        '+#13+
              'when ''SEGURO_FRDA_PER_VENDA_24'' then c.valornumerico            '+#13+
              'end ROUBO_FURTO_DA_24                                             '+#13+
              'from configuracoes c where c.tag = ''SEGURO_FRDA_PER_VENDA_24'' ),'+#13+
              '                                                                  '+#13+
              '(select                                                           '+#13+
              'case c.tag                                                        '+#13+
              'when ''SEGURO_FRDA_PER_CUSTO_24'' then c.valornumerico            '+#13+
              'end ROUBO_FURTO_CUSTO_DA_24                                      '+#13+
              'from configuracoes c where c.tag = ''SEGURO_FRDA_PER_CUSTO_24'' ) '+#13+
              '                                                                  '+#13+
              '                                                                  '+#13+
              '                                                                  '+#13+
              'from configuracoes c                                              '+#13+
              '                                                                  '+#13+
              'where                                                             '+#13+
              'c.tag in (''SEGURO_FRDA_PER_VENDA_12'',                           '+#13+
              '''SEGURO_FRDA_PER_CUSTO_12'',                                     '+#13+
              '''SEGURO_FR_PER_VENDA_12'',                                       '+#13+
              '''SEGURO_FR_PER_CUSTO_12'',                                       '+#13+
              '''SEGURO_FRDA_PER_VENDA_24'',                                     '+#13+
              '''SEGURO_FRDA_PER_CUSTO_24'',                                     '+#13+
              '''SEGURO_FR_PER_VENDA_24'',                                       '+#13+
              '''SEGURO_FR_PER_CUSTO_24'')                                       '+#13;

      lQry.SQL.Clear;
      lQry.SQL.Add(lSQL);
      lQry.Open(lSQL);

      Result.ROUBO_FURTO_12              := 0;
      Result.ROUBO_FURTO_24              := 0;
      Result.ROUBO_FURTO_CUSTO_12        := 0;
      Result.ROUBO_FURTO_CUSTO_24        := 0;
      Result.ROUBO_FURTO_DA_12           := 0;
      Result.ROUBO_FURTO_DA_24           := 0;
      Result.ROUBO_FURTO_CUSTO_DA_12     := 0;
      Result.ROUBO_FURTO_CUSTO_DA_24     := 0;

      if lQry.FieldByName('ROUBO_FURTO_12').AsString <> '' then
      Result.ROUBO_FURTO_12              := pValorFaixa * (lQry.FieldByName('ROUBO_FURTO_12').AsFloat/100);
      if lQry.FieldByName('ROUBO_FURTO_24').AsString <> '' then
      Result.ROUBO_FURTO_24              := pValorFaixa * (lQry.FieldByName('ROUBO_FURTO_24').AsFloat/100);
      if lQry.FieldByName('ROUBO_FURTO_CUSTO_12').AsString <> '' then
      Result.ROUBO_FURTO_CUSTO_12        := pValorFaixa * (lQry.FieldByName('ROUBO_FURTO_CUSTO_12').AsFloat/100);
      if lQry.FieldByName('ROUBO_FURTO_CUSTO_24').AsString <> '' then
      Result.ROUBO_FURTO_CUSTO_24        := pValorFaixa * (lQry.FieldByName('ROUBO_FURTO_CUSTO_24').AsFloat/100);
      if lQry.FieldByName('ROUBO_FURTO_DA_12').AsString <> '' then
      Result.ROUBO_FURTO_DA_12           := pValorFaixa * (lQry.FieldByName('ROUBO_FURTO_DA_12').AsFloat/100);
      if lQry.FieldByName('ROUBO_FURTO_DA_24').AsString <> '' then
      Result.ROUBO_FURTO_DA_24           := pValorFaixa * (lQry.FieldByName('ROUBO_FURTO_DA_24').AsFloat/100);
      if lQry.FieldByName('ROUBO_FURTO_CUSTO_DA_12').AsString <> '' then
      Result.ROUBO_FURTO_CUSTO_DA_12     := pValorFaixa * (lQry.FieldByName('ROUBO_FURTO_CUSTO_DA_12').AsFloat/100);
      if lQry.FieldByName('ROUBO_FURTO_CUSTO_DA_24').AsString <> '' then
      Result.ROUBO_FURTO_CUSTO_DA_24     := pValorFaixa * (lQry.FieldByName('ROUBO_FURTO_CUSTO_DA_24').AsFloat/100);
    end;

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
