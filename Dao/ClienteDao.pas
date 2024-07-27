unit ClienteDao;

interface

uses
  ClienteModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TClienteDao = class

  private
    vIConexao : Iconexao;
    vConstrutor : TConstrutorDao;

    FClientesLista: IList<TClienteModel>;
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
    procedure SetClientesLista(const Value: IList<TClienteModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pClienteModel: TClienteModel);

  public
    const
      NomeTabela = 'CLIENTES';
    constructor Create(pIConexao : Iconexao);
    destructor Destroy; override;
    property ClientesLista: IList<TClienteModel> read FClientesLista write SetClientesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pClienteModel: TClienteModel): String;
    function alterar(pClienteModel: TClienteModel): String;
    function excluir(pClienteModel: TClienteModel): String;

    function sincronizarDados(pClienteModel: TClienteModel): String;

    procedure obterLista;

    function where: String;
    function carregaClasse(pId: String): TClienteModel;
    function ufCliente(pId: String): Variant;
    function nomeCliente(pId: String): Variant;
    function comissaoCliente(pId: String): Variant;
    function diasAtraso(pCodigoCliente: String): Variant;
    function obterListaConsulta: IFDDataset;
    function ObterListaMemTable: IFDDataset;
    function ObterBairros: IFDDataset;
    procedure bloquearCNPJCPF(pCliente, pCNPJCPF: String);
end;
implementation

uses
  System.Rtti, Terasoft.Configuracoes, LojasModel, Terasoft.Types;

{ TCliente }

function TClienteDao.carregaClasse(pId: String): TClienteModel;
var
  lQry: TFDQuery;
  lModel: TClienteModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TClienteModel.Create(vIConexao);
  Result   := lModel;
  try
    lQry.Open('select * from ' + self.NomeTabela + ' where CODIGO_CLI = '+ QuotedStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.CODIGO_CLI                  := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.FANTASIA_CLI                := lQry.FieldByName('FANTASIA_CLI').AsString;
    lModel.RAZAO_CLI                   := lQry.FieldByName('RAZAO_CLI').AsString;
    lModel.CNPJ_CPF_CLI                := lQry.FieldByName('CNPJ_CPF_CLI').AsString;
    lModel.INSCRICAO_RG_CLI            := lQry.FieldByName('INSCRICAO_RG_CLI').AsString;
    lModel.ENDERECO_CLI                := lQry.FieldByName('ENDERECO_CLI').AsString;
    lModel.ENDERECO                    := lQry.FieldByName('ENDERECO').AsString;
    lModel.BAIRRO_CLI                  := lQry.FieldByName('BAIRRO_CLI').AsString;
    lModel.CIDADE_CLI                  := lQry.FieldByName('CIDADE_CLI').AsString;
    lModel.UF_CLI                      := lQry.FieldByName('UF_CLI').AsString;
    lModel.CEP_CLI                     := lQry.FieldByName('CEP_CLI').AsString;
    lModel.TELEFONE_CLI                := lQry.FieldByName('TELEFONE_CLI').AsString;
    lModel.FAX_CLI                     := lQry.FieldByName('FAX_CLI').AsString;
    lModel.EMAIL_CLI                   := lQry.FieldByName('EMAIL_CLI').AsString;
    lModel.URL_CLI                     := lQry.FieldByName('URL_CLI').AsString;
    lModel.TIPO_CLI                    := lQry.FieldByName('TIPO_CLI').AsString;
    lModel.ATIVIDADE_CLI               := lQry.FieldByName('ATIVIDADE_CLI').AsString;
    lModel.ENDCOBRANCA_CLI             := lQry.FieldByName('ENDCOBRANCA_CLI').AsString;
    lModel.BAIRCOBRANCA_CLI            := lQry.FieldByName('BAIRCOBRANCA_CLI').AsString;
    lModel.CIDCOBRANCA_CLI             := lQry.FieldByName('CIDCOBRANCA_CLI').AsString;
    lModel.UFCOBRANCA_CLI              := lQry.FieldByName('UFCOBRANCA_CLI').AsString;
    lModel.CEPCOBRANCA_CLI             := lQry.FieldByName('CEPCOBRANCA_CLI').AsString;
    lModel.LOCALTRABALHO_CLI           := lQry.FieldByName('LOCALTRABALHO_CLI').AsString;
    lModel.ENDTRABALHO_CLI             := lQry.FieldByName('ENDTRABALHO_CLI').AsString;
    lModel.BAIRTRABALHO_CLI            := lQry.FieldByName('BAIRTRABALHO_CLI').AsString;
    lModel.CIDTRABALHO_CLI             := lQry.FieldByName('CIDTRABALHO_CLI').AsString;
    lModel.UFTRABALHO_CLI              := lQry.FieldByName('UFTRABALHO_CLI').AsString;
    lModel.CEPTRABALHO_CLI             := lQry.FieldByName('CEPTRABALHO_CLI').AsString;
    lModel.FONETRABALHO_CLI            := lQry.FieldByName('FONETRABALHO_CLI').AsString;
    lModel.FUNCAOTRABALHO_CLI          := lQry.FieldByName('FUNCAOTRABALHO_CLI').AsString;
    lModel.REFERENCIA2_CLI             := lQry.FieldByName('REFERENCIA2_CLI').AsString;
    lModel.FONEREF2_CLI                := lQry.FieldByName('FONEREF2_CLI').AsString;
    lModel.REFERENCIA3_CLI             := lQry.FieldByName('REFERENCIA3_CLI').AsString;
    lModel.FONEREF3_CLI                := lQry.FieldByName('FONEREF3_CLI').AsString;
    lModel.SEPROCADO_CLI               := lQry.FieldByName('SEPROCADO_CLI').AsString;
    lModel.REFERENCIA1_CLI             := lQry.FieldByName('REFERENCIA1_CLI').AsString;
    lModel.FONEREF1_CLI                := lQry.FieldByName('FONEREF1_CLI').AsString;
    lModel.CADASTRO_CLI                := lQry.FieldByName('CADASTRO_CLI').AsString;
    lModel.NASCIMENTO_CLI              := lQry.FieldByName('NASCIMENTO_CLI').AsString;
    lModel.CELULAR_CLI                 := lQry.FieldByName('CELULAR_CLI').AsString;
    lModel.PAI_CLI                     := lQry.FieldByName('PAI_CLI').AsString;
    lModel.MAE_CLI                     := lQry.FieldByName('MAE_CLI').AsString;
    lModel.CONTATO_CLI                 := lQry.FieldByName('CONTATO_CLI').AsString;
    lModel.OBSERVACAO_CLI              := lQry.FieldByName('OBSERVACAO_CLI').AsString;
    lModel.BANCO_CLI                   := lQry.FieldByName('BANCO_CLI').AsString;
    lModel.AGENCIA_CLI                 := lQry.FieldByName('AGENCIA_CLI').AsString;
    lModel.CONTA_CLI                   := lQry.FieldByName('CONTA_CLI').AsString;
    lModel.RENDA_CLI                   := lQry.FieldByName('RENDA_CLI').AsString;
    lModel.FONEAGENCIA_CLI             := lQry.FieldByName('FONEAGENCIA_CLI').AsString;
    lModel.CONTATOAGENCIA_CLI          := lQry.FieldByName('CONTATOAGENCIA_CLI').AsString;
    lModel.CODIGO_VEN                  := lQry.FieldByName('CODIGO_VEN').AsString;
    lModel.USUARIO_CLI                 := lQry.FieldByName('USUARIO_CLI').AsString;
    lModel.ESTADOCIVIL_CLI             := lQry.FieldByName('ESTADOCIVIL_CLI').AsString;
    lModel.NOMECON_CLI                 := lQry.FieldByName('NOMECON_CLI').AsString;
    lModel.CPFCON_CLI                  := lQry.FieldByName('CPFCON_CLI').AsString;
    lModel.RGCON_CLI                   := lQry.FieldByName('RGCON_CLI').AsString;
    lModel.PROFCON_CLI                 := lQry.FieldByName('PROFCON_CLI').AsString;
    lModel.SALARIOCON_CLI              := lQry.FieldByName('SALARIOCON_CLI').AsString;
    lModel.CONVENIO_CLI                := lQry.FieldByName('CONVENIO_CLI').AsString;
    lModel.CONVENIO_COD                := lQry.FieldByName('CONVENIO_COD').AsString;
    lModel.CARTA_CLI                   := lQry.FieldByName('CARTA_CLI').AsString;
    lModel.EXPEDICAO_RG                := lQry.FieldByName('EXPEDICAO_RG').AsString;
    lModel.NATURALIDADE_CLI            := lQry.FieldByName('NATURALIDADE_CLI').AsString;
    lModel.uf_naturalidade_cli         := lQry.FieldByName('UF_NATURALIDADE_CLI').AsString;
    lModel.escolaridade_cli            := lQry.FieldByName('ESCOLARIDADE_CLI').AsString;
    lModel.TEMPO_SERVICO               := lQry.FieldByName('TEMPO_SERVICO').AsString;
    lModel.BENEFICIO_CLI               := lQry.FieldByName('BENEFICIO_CLI').AsString;
    lModel.DESCRICAO                   := lQry.FieldByName('DESCRICAO').AsString;
    lModel.REDUZIR_BASE_ICMS           := lQry.FieldByName('REDUZIR_BASE_ICMS').AsString;
    lModel.ISENTO_ICMS                 := lQry.FieldByName('ISENTO_ICMS').AsString;
    lModel.LOJA                        := lQry.FieldByName('LOJA').AsString;
    lModel.DATA_ALTERACAO              := lQry.FieldByName('DATA_ALTERACAO').AsString;
    lModel.LIMITE_COMPRA               := lQry.FieldByName('LIMITE_COMPRA').AsString;
    lModel.TIPO_SAIDA                  := lQry.FieldByName('TIPO_SAIDA').AsString;
    lModel.COD_MUNICIPIO               := lQry.FieldByName('COD_MUNICIPIO').AsString;
    lModel.ULTIMA_COMPRA               := lQry.FieldByName('ULTIMA_COMPRA').AsString;
    lModel.STATUS                      := lQry.FieldByName('STATUS').AsString;
    lModel.PORTADOR                    := lQry.FieldByName('PORTADOR').AsString;
    lModel.SEXO_CLI                    := lQry.FieldByName('SEXO_CLI').AsString;
    lModel.CLASSIF_CLI                 := lQry.FieldByName('CLASSIF_CLI').AsString;
    lModel.DATA_RETORNO                := lQry.FieldByName('DATA_RETORNO').AsString;
    lModel.HORA_RETORNO                := lQry.FieldByName('HORA_RETORNO').AsString;
    lModel.AVALISTA_CLI                := lQry.FieldByName('AVALISTA_CLI').AsString;
    lModel.CNPJ_CPF_AVAL_CLI           := lQry.FieldByName('CNPJ_CPF_AVAL_CLI').AsString;
    lModel.BAIRRO_AVAL_CLI             := lQry.FieldByName('BAIRRO_AVAL_CLI').AsString;
    lModel.CIDADE_AVAL_CLI             := lQry.FieldByName('CIDADE_AVAL_CLI').AsString;
    lModel.TELEFONE_AVAL_CLI           := lQry.FieldByName('TELEFONE_AVAL_CLI').AsString;
    lModel.CELULAR_AVAL_CLI            := lQry.FieldByName('CELULAR_AVAL_CLI').AsString;
    lModel.ENDERECO_AVAL_CLI           := lQry.FieldByName('ENDERECO_AVAL_CLI').AsString;
    lModel.ISENTO_IPI                  := lQry.FieldByName('ISENTO_IPI').AsString;
    lModel.REVENDEDOR                  := lQry.FieldByName('REVENDEDOR').AsString;
    lModel.CREDITO_CLI                 := lQry.FieldByName('CREDITO_CLI').AsString;
    lModel.FONE_COM_AVAL               := lQry.FieldByName('FONE_COM_AVAL').AsString;
    lModel.RG_AVAL                     := lQry.FieldByName('RG_AVAL').AsString;
    lModel.MAE_AVAL                    := lQry.FieldByName('MAE_AVAL').AsString;
    lModel.DATA_NASC_AVAL              := lQry.FieldByName('DATA_NASC_AVAL').AsString;
    lModel.UNIDADE_CONSUMIDORA_CB      := lQry.FieldByName('UNIDADE_CONSUMIDORA_CB').AsString;
    lModel.CODIGO_CONCESSIONARIA_CB    := lQry.FieldByName('CODIGO_CONCESSIONARIA_CB').AsString;
    lModel.CODIGO_VENDEDOR_CB          := lQry.FieldByName('CODIGO_VENDEDOR_CB').AsString;
    lModel.TITULAR_CONTA_CB            := lQry.FieldByName('TITULAR_CONTA_CB').AsString;
    lModel.DATA_FATURAMENTO_CB         := lQry.FieldByName('DATA_FATURAMENTO_CB').AsString;
    lModel.DATA_VENCIMENTO_CB          := lQry.FieldByName('DATA_VENCIMENTO_CB').AsString;
    lModel.CELULAR_CLI2                := lQry.FieldByName('CELULAR_CLI2').AsString;
    lModel.OPERADORA_CELULAR           := lQry.FieldByName('OPERADORA_CELULAR').AsString;
    lModel.DATA_NASC_CONJUGUE          := lQry.FieldByName('DATA_NASC_CONJUGUE').AsString;
    lModel.EMAIL2                      := lQry.FieldByName('EMAIL2').AsString;
    lModel.DESCRICAO_REPARCELAMENTO    := lQry.FieldByName('DESCRICAO_REPARCELAMENTO').AsString;
    lModel.ID                          := lQry.FieldByName('ID').AsString;
    lModel.DEPENDENTE                  := lQry.FieldByName('DEPENDENTE').AsString;
    lModel.NASCIMENTO_DEPENDENTE       := lQry.FieldByName('NASCIMENTO_DEPENDENTE').AsString;
    lModel.SEXO_DEPENDENTE             := lQry.FieldByName('SEXO_DEPENDENTE').AsString;
    lModel.DEPENDENTE2                 := lQry.FieldByName('DEPENDENTE2').AsString;
    lModel.NASCIMENTO_DEPENDENTE2      := lQry.FieldByName('NASCIMENTO_DEPENDENTE2').AsString;
    lModel.SEXO_DEPENDENTE2            := lQry.FieldByName('SEXO_DEPENDENTE2').AsString;
    lModel.DEPENDENTE3                 := lQry.FieldByName('DEPENDENTE3').AsString;
    lModel.NASCIMENTO_DEPENDENTE3      := lQry.FieldByName('NASCIMENTO_DEPENDENTE3').AsString;
    lModel.SEXO_DEPENDENTE3            := lQry.FieldByName('SEXO_DEPENDENTE3').AsString;
    lModel.OBSERVACAO_PED_ORC          := lQry.FieldByName('OBSERVACAO_PED_ORC').AsString;
    lModel.PRECO_ID                    := lQry.FieldByName('PRECO_ID').AsString;
    lModel.SUFRAMA                     := lQry.FieldByName('SUFRAMA').AsString;
    lModel.COMPLEMENTO                 := lQry.FieldByName('COMPLEMENTO').AsString;
    lModel.NUMERO_END                  := lQry.FieldByName('NUMERO_END').AsString;
    lModel.ATIVIDADE_ID                := lQry.FieldByName('ATIVIDADE_ID').AsString;
    lModel.PAIS_ID                     := lQry.FieldByName('PAIS_ID').AsString;
    lModel.REGIAO_ID                   := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.CFOP_ID                     := lQry.FieldByName('CFOP_ID').AsString;
    lModel.TIPO_SUFRAMA                := lQry.FieldByName('TIPO_SUFRAMA').AsString;
    lModel.TIPO_APURACAO               := lQry.FieldByName('TIPO_APURACAO').AsString;
    lModel.CONDICOES_PAGAMENTO         := lQry.FieldByName('CONDICOES_PAGAMENTO').AsString;
    lModel.CONSUMIDOR_FINAL            := lQry.FieldByName('CONSUMIDOR_FINAL').AsString;
    lModel.NFE                         := lQry.FieldByName('NFE').AsString;
    lModel.CARGA_TRIBUTARIA            := lQry.FieldByName('CARGA_TRIBUTARIA').AsString;
    lModel.DESCONTO_FINANCEIRO         := lQry.FieldByName('DESCONTO_FINANCEIRO').AsString;
    lModel.QUANTIDADE_TERMINAIS        := lQry.FieldByName('QUANTIDADE_TERMINAIS').AsString;
    lModel.TELEFONE_INTERNACIONAL      := lQry.FieldByName('TELEFONE_INTERNACIONAL').AsString;
    lModel.CNAE                        := lQry.FieldByName('CNAE').AsString;
    lModel.ENDERECO_ENTREGA            := lQry.FieldByName('ENDERECO_ENTREGA').AsString;
    lModel.BAIRRO_ENTREGA              := lQry.FieldByName('BAIRRO_ENTREGA').AsString;
    lModel.CIDADE_ENTREGA              := lQry.FieldByName('CIDADE_ENTREGA').AsString;
    lModel.UF_ENTREGA                  := lQry.FieldByName('UF_ENTREGA').AsString;
    lModel.CEP_ENTREGA                 := lQry.FieldByName('CEP_ENTREGA').AsString;
    lModel.STATUS_CARTA                := lQry.FieldByName('STATUS_CARTA').AsString;
    lModel.EMAIL_COBRANCA              := lQry.FieldByName('EMAIL_COBRANCA').AsString;
    lModel.CONTATO_COBRANCA            := lQry.FieldByName('CONTATO_COBRANCA').AsString;
    lModel.TELEFONE_COBRANCA           := lQry.FieldByName('TELEFONE_COBRANCA').AsString;
    lModel.CELULAR_COBRNACA            := lQry.FieldByName('CELULAR_COBRNACA').AsString;
    lModel.OBSERVACAO_COBRANCA         := lQry.FieldByName('OBSERVACAO_COBRANCA').AsString;
    lModel.COMPLEMENTO_COBRANCA        := lQry.FieldByName('COMPLEMENTO_COBRANCA').AsString;
    lModel.OBSERVACAO_NFE              := lQry.FieldByName('OBSERVACAO_NFE').AsString;
    lModel.DESCONTO_NF                 := lQry.FieldByName('DESCONTO_NF').AsString;
    lModel.OBS_GERAL                   := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.SYSTIME                     := lQry.FieldByName('SYSTIME').AsString;
    lModel.TELA                        := lQry.FieldByName('TELA').AsString;
    lModel.LIMITE_SMS                  := lQry.FieldByName('LIMITE_SMS').AsString;
    lModel.TELEFONE_PAI                := lQry.FieldByName('TELEFONE_PAI').AsString;
    lModel.TELEFONE_MAE                := lQry.FieldByName('TELEFONE_MAE').AsString;
    lModel.TELEFONE_CONJUGE            := lQry.FieldByName('TELEFONE_CONJUGE').AsString;
    lModel.MULTA                       := lQry.FieldByName('MULTA').AsString;
    lModel.JUROS_BOL                   := lQry.FieldByName('JUROS_BOL').AsString;
    lModel.INDICE_JUROS_ID             := lQry.FieldByName('INDICE_JUROS_ID').AsString;
    lModel.CTB                         := lQry.FieldByName('CTB').AsString;
    lModel.BANCO_ID                    := lQry.FieldByName('BANCO_ID').AsString;
    lModel.INSTRUCAO_BOLETO            := lQry.FieldByName('INSTRUCAO_BOLETO').AsString;
    lModel.DEPENDENTE4                 := lQry.FieldByName('DEPENDENTE4').AsString;
    lModel.NASCIMENTO_DEPENDENTE4      := lQry.FieldByName('NASCIMENTO_DEPENDENTE4').AsString;
    lModel.SEXO_DEPENDENTE4            := lQry.FieldByName('SEXO_DEPENDENTE4').AsString;
    lModel.DEPENDENTE5                 := lQry.FieldByName('DEPENDENTE5').AsString;
    lModel.NASCIMENTO_DEPENDENTE5      := lQry.FieldByName('NASCIMENTO_DEPENDENTE5').AsString;
    lModel.SEXO_DEPENDENTE5            := lQry.FieldByName('SEXO_DEPENDENTE5').AsString;
    lModel.DEPENDENTE6                 := lQry.FieldByName('DEPENDENTE6').AsString;
    lModel.NASCIMENTO_DEPENDENTE6      := lQry.FieldByName('NASCIMENTO_DEPENDENTE6').AsString;
    lModel.SEXO_DEPENDENTE6            := lQry.FieldByName('SEXO_DEPENDENTE6').AsString;
    lModel.ISENTO_ST                   := lQry.FieldByName('ISENTO_ST').AsString;
    lModel.FRETE                       := lQry.FieldByName('FRETE').AsString;
    lModel.PROSPECCAO_ID               := lQry.FieldByName('PROSPECCAO_ID').AsString;
    lModel.DESC_FINANCEIRO             := lQry.FieldByName('DESC_FINANCEIRO').AsString;
    lModel.IMAGEM                      := lQry.FieldByName('IMAGEM').AsString;
    lModel.PRATICA_ESPORTE             := lQry.FieldByName('PRATICA_ESPORTE').AsString;
    lModel.FREQUENCIA                  := lQry.FieldByName('FREQUENCIA').AsString;
    lModel.DESTRO_CANHOTO              := lQry.FieldByName('DESTRO_CANHOTO').AsString;
    lModel.NUMERO_CALCADO              := lQry.FieldByName('NUMERO_CALCADO').AsString;
    lModel.CALCADO_MAIS_USADO          := lQry.FieldByName('CALCADO_MAIS_USADO').AsString;
    lModel.MATERIAL                    := lQry.FieldByName('MATERIAL').AsString;
    lModel.CIRURGIA_MMII               := lQry.FieldByName('CIRURGIA_MMII').AsString;
    lModel.TRATAMENTO_MEDICAMENTO      := lQry.FieldByName('TRATAMENTO_MEDICAMENTO').AsString;
    lModel.ALERGICO                    := lQry.FieldByName('ALERGICO').AsString;
    lModel.ALERGICO_OBS                := lQry.FieldByName('ALERGICO_OBS').AsString;
    lModel.PATOLOGIA                   := lQry.FieldByName('PATOLOGIA').AsString;
    lModel.PATOLOGIA_OBS               := lQry.FieldByName('PATOLOGIA_OBS').AsString;
    lModel.DIABETES                    := lQry.FieldByName('DIABETES').AsString;
    lModel.DIABETES_FAMILIARES         := lQry.FieldByName('DIABETES_FAMILIARES').AsString;
    lModel.ETILISTA                    := lQry.FieldByName('ETILISTA').AsString;
    lModel.CARDIOPATIAS                := lQry.FieldByName('CARDIOPATIAS').AsString;
    lModel.TABAGISMO                   := lQry.FieldByName('TABAGISMO').AsString;
    lModel.DST                         := lQry.FieldByName('DST').AsString;
    lModel.PRESSAO                     := lQry.FieldByName('PRESSAO').AsString;
    lModel.GRAVIDEZ                    := lQry.FieldByName('GRAVIDEZ').AsString;
    lModel.OUTRAS_PATOLOGIAS           := lQry.FieldByName('OUTRAS_PATOLOGIAS').AsString;
    lModel.MOTIVO_VISITA               := lQry.FieldByName('MOTIVO_VISITA').AsString;
    lModel.FORMATO_UNHA                := lQry.FieldByName('FORMATO_UNHA').AsString;
    lModel.ONICOTROFIA                 := lQry.FieldByName('ONICOTROFIA').AsString;
    lModel.ONICORREXE                  := lQry.FieldByName('ONICORREXE').AsString;
    lModel.ONICOGRIFOSE                := lQry.FieldByName('ONICOGRIFOSE').AsString;
    lModel.ONICOLISE                   := lQry.FieldByName('ONICOLISE').AsString;
    lModel.ONICOMICOSE                 := lQry.FieldByName('ONICOMICOSE').AsString;
    lModel.PSORIASE                    := lQry.FieldByName('PSORIASE').AsString;
    lModel.ONICOCRIPTOSE               := lQry.FieldByName('ONICOCRIPTOSE').AsString;
    lModel.GRANULADA                   := lQry.FieldByName('GRANULADA').AsString;
    lModel.ALTERACAO_COR               := lQry.FieldByName('ALTERACAO_COR').AsString;
    lModel.ONICOFOSE                   := lQry.FieldByName('ONICOFOSE').AsString;
    lModel.EXOSTOSE_SUBUNGUEAL         := lQry.FieldByName('EXOSTOSE_SUBUNGUEAL').AsString;
    lModel.UNGUEAL                     := lQry.FieldByName('UNGUEAL').AsString;
    lModel.OUTRAS_ALTERACAO_LAMINAS    := lQry.FieldByName('OUTRAS_ALTERACAO_LAMINAS').AsString;
    lModel.BROMIDROSE                  := lQry.FieldByName('BROMIDROSE').AsString;
    lModel.ANIDROSE                    := lQry.FieldByName('ANIDROSE').AsString;
    lModel.HIPERHIDROSE                := lQry.FieldByName('HIPERHIDROSE').AsString;
    lModel.ISQUEMICA                   := lQry.FieldByName('ISQUEMICA').AsString;
    lModel.FRIEIRA                     := lQry.FieldByName('FRIEIRA').AsString;
    lModel.TINEA_PEDIS                 := lQry.FieldByName('TINEA_PEDIS').AsString;
    lModel.NEUROPATICA                 := lQry.FieldByName('NEUROPATICA').AsString;
    lModel.FISSURAS                    := lQry.FieldByName('FISSURAS').AsString;
    lModel.DISIDROSE                   := lQry.FieldByName('DISIDROSE').AsString;
    lModel.MAL_PERFURANTE              := lQry.FieldByName('MAL_PERFURANTE').AsString;
    lModel.PSORIASE_PE                 := lQry.FieldByName('PSORIASE_PE').AsString;
    lModel.ALTERACAO_PELE              := lQry.FieldByName('ALTERACAO_PELE').AsString;
    lModel.HALUX_VALGUS                := lQry.FieldByName('HALUX_VALGUS').AsString;
    lModel.HALUX_RIGIDUS               := lQry.FieldByName('HALUX_RIGIDUS').AsString;
    lModel.ESPORAO_CALCANEO            := lQry.FieldByName('ESPORAO_CALCANEO').AsString;
    lModel.PE_CAVO                     := lQry.FieldByName('PE_CAVO').AsString;
    lModel.PE_PLANO                    := lQry.FieldByName('PE_PLANO').AsString;
    lModel.DEDOS_GARRA                 := lQry.FieldByName('DEDOS_GARRA').AsString;
    lModel.PODACTILIA                  := lQry.FieldByName('PODACTILIA').AsString;
    lModel.ALTERACAO_ORTOPEDICAS       := lQry.FieldByName('ALTERACAO_ORTOPEDICAS').AsString;
    lModel.INDICACAO                   := lQry.FieldByName('INDICACAO').AsString;
    lModel.MONOFILAMENTO               := lQry.FieldByName('MONOFILAMENTO').AsString;
    lModel.DIAPASAO                    := lQry.FieldByName('DIAPASAO').AsString;
    lModel.DIGITAPRESSAO               := lQry.FieldByName('DIGITAPRESSAO').AsString;
    lModel.PULSOS                      := lQry.FieldByName('PULSOS').AsString;
    lModel.PERFUSAO_D                  := lQry.FieldByName('PERFUSAO_D').AsString;
    lModel.PERFUSAO_E                  := lQry.FieldByName('PERFUSAO_E').AsString;
    lModel.USA_NFE                     := lQry.FieldByName('USA_NFE').AsString;
    lModel.USA_NFCE                    := lQry.FieldByName('USA_NFCE').AsString;
    lModel.USA_MDFE                    := lQry.FieldByName('USA_MDFE').AsString;
    lModel.USA_CTE                     := lQry.FieldByName('USA_CTE').AsString;
    lModel.USA_NFSE                    := lQry.FieldByName('USA_NFSE').AsString;
    lModel.USAR_CONTROLE_KG            := lQry.FieldByName('USAR_CONTROLE_KG').AsString;
    lModel.COMPLEMENTO_ENTREGA         := lQry.FieldByName('COMPLEMENTO_ENTREGA').AsString;
    lModel.NUMERO_ENTREGA              := lQry.FieldByName('NUMERO_ENTREGA').AsString;
    lModel.COD_MUNICIPIO_ENTREGA       := lQry.FieldByName('COD_MUNICIPIO_ENTREGA').AsString;
    lModel.EX_CODIGO_POSTAL            := lQry.FieldByName('EX_CODIGO_POSTAL').AsString;
    lModel.EX_ESTADO                   := lQry.FieldByName('EX_ESTADO').AsString;
    lModel.PARCELA_MAXIMA              := lQry.FieldByName('PARCELA_MAXIMA').AsString;
    lModel.TRANSPORTADORA_ID           := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.COMISSAO                    := lQry.FieldByName('COMISSAO').AsString;
    lModel.DIA_VENCIMENTO              := lQry.FieldByName('DIA_VENCIMENTO').AsString;
    lModel.LISTAR_RAD                  := lQry.FieldByName('LISTAR_RAD').AsString;
    lModel.CONTADOR_ID                 := lQry.FieldByName('CONTADOR_ID').AsString;
    lModel.VAUCHER                     := lQry.FieldByName('VAUCHER').AsString;
    lModel.MATRIZ_CLIENTE_ID           := lQry.FieldByName('MATRIZ_CLIENTE_ID').AsString;
    lModel.INSCRICAO_MUNICIPAL         := lQry.FieldByName('INSCRICAO_MUNICIPAL').AsString;
    lModel.ENVIA_SMS                   := lQry.FieldByName('ENVIA_SMS').AsString;
    lModel.VALOR_ALUGUEL               := lQry.FieldByName('VALOR_ALUGUEL').AsString;
    lModel.TEMPO_RESIDENCIA            := lQry.FieldByName('TEMPO_RESIDENCIA').AsString;
    lModel.TIPO_RESIDENCIA             := lQry.FieldByName('TIPO_RESIDENCIA').AsString;
    lModel.PARENTESCO_REF1             := lQry.FieldByName('PARENTESCO_REF1').AsString;
    lModel.PARENTESCO_REF2             := lQry.FieldByName('PARENTESCO_REF2').AsString;
    lModel.TRABALHO_ADMISSAO           := lQry.FieldByName('TRABALHO_ADMISSAO').AsString;
    lModel.TRABALHO_ANTERIOR_ADMISSAO  := lQry.FieldByName('TRABALHO_ANTERIOR_ADMISSAO').AsString;
    lModel.NOME_TRABALHO_ANTERIOR      := lQry.FieldByName('NOME_TRABALHO_ANTERIOR').AsString;
    lModel.TELEFONE_TRABALHO_ANTERIOR  := lQry.FieldByName('TELEFONE_TRABALHO_ANTERIOR').AsString;
    lModel.FUNCAO_TRABALHO_ANTERIOR    := lQry.FieldByName('FUNCAO_TRABALHO_ANTERIOR').AsString;
    lModel.RENDA_TRABALHO_ANTERIOR     := lQry.FieldByName('RENDA_TRABALHO_ANTERIOR').AsString;
    lModel.REGIME_TRABALHO             := lQry.FieldByName('REGIME_TRABALHO').AsString;
    lModel.CONFIRM_ENDERECO            := lQry.FieldByName('CONFIRM_ENDERECO').AsString;
    lModel.CONFIRM_ENDERECO_ANTERIOR   := lQry.FieldByName('CONFIRM_ENDERECO_ANTERIOR').AsString;
    lModel.CONFIRM_TRABALHO            := lQry.FieldByName('CONFIRM_TRABALHO').AsString;
    lModel.CONFIRM_TRABALHO_CONJUGE     := lQry.FieldByName('CONFIRM_TRABALHO_CONJUGE').AsString;
    lModel.DESCONTO_BOL                 := lQry.FieldByName('DESCONTO_BOL').AsString;
    lModel.PRODUTO_TIPO_ID              := lQry.FieldByName('PRODUTO_TIPO_ID').AsString;
    lModel.PEDIDO_MINIMO                := lQry.FieldByName('PEDIDO_MINIMO').AsString;
    lModel.REDUCAO_ICMS                 := lQry.FieldByName('REDUCAO_ICMS').AsString;
    lModel.ABATIMENTO_BOL               := lQry.FieldByName('ABATIMENTO_BOL').AsString;
    lModel.USAR_DESCONTO_PRODUTO        := lQry.FieldByName('USAR_DESCONTO_PRODUTO').AsString;
    lModel.CODIGO_ANTERIOR              := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.SENHA                        := lQry.FieldByName('SENHA').AsString;
    lModel.OCUPACAO_ID                  := lQry.FieldByName('OCUPACAO_ID').AsString;
    lModel.SUB_ATIVIDADE_ID             := lQry.FieldByName('SUB_ATIVIDADE_ID').AsString;
    lModel.ZEMOPAY                      := lQry.FieldByName('ZEMOPAY').AsString;
    lModel.ZEMOPAY_TAXA_ID              := lQry.FieldByName('ZEMOPAY_TAXA_ID').AsString;
    lModel.ZEMOPAY_ID                   := lQry.FieldByName('ZEMOPAY_ID').AsString;
    lModel.ZEMOPAY_BANCO_ID             := lQry.FieldByName('ZEMOPAY_BANCO_ID').AsString;
    lModel.DATA_INATIVIDADE             := lQry.FieldByName('DATA_INATIVIDADE').AsString;
    lModel.IMPORTACAO_DADOS             := lQry.FieldByName('IMPORTACAO_DADOS').AsString;
    lModel.OBSERVACAO_IMPLANTACAO       := lQry.FieldByName('OBSERVACAO_IMPLANTACAO').AsString;
    lModel.STATUS_IMPLANTACAO           := lQry.FieldByName('STATUS_IMPLANTACAO').AsString;
    lModel.NAO_CONTRIBUINTE             := lQry.FieldByName('NAO_CONTRIBUINTE').AsString;
    lModel.GRUPO_ECONOMICO_ID           := lQry.FieldByName('GRUPO_ECONOMICO_ID').AsString;
    lModel.ACEITE_BOL                   := lQry.FieldByName('ACEITE_BOL').AsString;
    lModel.BLOQUEAR_ALTERACAO_TABELA    := lQry.FieldByName('BLOQUEAR_ALTERACAO_TABELA').AsString;
    lModel.TIPO_EMISSAO_NFE             := lQry.FieldByName('TIPO_EMISSAO_NFE').AsString;
    lModel.PERCENTUAL_DESCONTO          := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
    lModel.TIPO_FUNCIONARIO_PUBLICO_CLI := lQry.FieldByName('TIPO_FUNCIONARIO_PUBLICO_CLI').AsString;
    lModel.NUMBENEFICIO_CLI             := lQry.FieldByName('NUMBENEFICIO_CLI').AsString;
    lModel.FONTE_BENEFICIO_CLI          := lQry.FieldByName('FONTE_BENEFICIO_CLI').AsString;
    lModel.CODIGO_OCUPACAO_CLI          := lQry.FieldByName('CODIGO_OCUPACAO_CLI').AsString;
    lModel.DOCIDENTIFICACAOCONJ_CLI     := lQry.FieldByName('DOCIDENTIFICACAOCONJ_CLI').AsString;
    lModel.TIPODOCIDENTIFICACAOCONJ_CLI := lQry.FieldByName('TIPODOCIDENTIFICACAOCONJ_CLI').AsString;
    lModel.TIPODOC_CLI                  := lQry.FieldByName('TIPODOC_CLI').AsString;
    lModel.NOME_CONTADOR_CLI            := lQry.FieldByName('NOME_CONTADOR_CLI').AsString;
    lModel.TELEFONE_CONTADOR_CLI        := lQry.FieldByName('TELEFONE_CONTADOR_CLI').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TClienteDao.comissaoCliente(pId: String): Variant;
begin
  Result := vIConexao.getConnection.ExecSQLScalar('select coalesce(COMISSAO, 0) from ' + self.NomeTabela +' where CODIGO_CLI = '+ QuotedStr(pId));
end;

constructor TClienteDao.Create(pIConexao : Iconexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TClienteDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TClienteDao.diasAtraso(pCodigoCliente: String): Variant;
var
  lResult : Variant;
begin
  lResult := vIConexao
              .getConnection
              .ExecSQLScalar('SELECT R.VENCIMENTO_REC                                  '+
                             '  FROM CONTASRECEBERITENS R,                             '+
                             '       CONTASRECEBER,                                    '+
                             '       CLIENTES C,                                       '+
                             '       PORTADOR P                                        '+
                             ' WHERE R.CODIGO_CLI = C.CODIGO_CLI                       '+
                             '   AND CONTASRECEBER.FATURA_REC = R.FATURA_REC           '+
                             '   AND R.CODIGO_POR = P.CODIGO_PORT                      '+
                             '   AND R.VALORREC_REC < R.VLRPARCELA_REC                 '+
                             '   AND COALESCE(P.SITUACAO_CLIENTE, ''S'') = ''S''       '+
                             '   AND R.SITUACAO_REC NOT IN (''R'',                     '+
                             '                              ''X'')                     '+
                             '   AND R.CODIGO_POR <> ''000002''                        '+
                             '   AND P.TIPO <> ''T''                                   '+
                             '   AND C.CODIGO_CLI = ' + QuotedStr(pCodigoCliente)       +
                             ' ORDER BY R.VENCIMENTO_REC');

  if VarIsClear(lResult) then
    Result := vIConexao.DataServer
  else
    Result := lResult;
end;

function TClienteDao.incluir(pClienteModel: TClienteModel): String;
var
  lQry           : TFDQuery;
  lSQL,
  lResult        : String;
  lConfiguracoes : ITerasoftConfiguracoes;
  lLojasModel,
  lLojas         : ITLojasModel;
begin
  lQry := vIConexao.CriarQuery;

  lLojasModel := TLojasModel.getNewIface(vIConexao);
  try
    lSQL := vConstrutor.gerarInsert(self.NomeTabela, 'CODIGO_CLI', true);

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    lQry.SQL.Add(lSQL);
    pClienteModel.CODIGO_CLI := vIConexao.Generetor('GEN_CLIENTE', true);
    setParams(lQry, pClienteModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_CLI').AsString;

    if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
      sincronizarDados(pClienteModel);

  finally
    lLojasModel:=nil;
    lSQL := '';
    lQry.Free;
  end;
end;

function TClienteDao.alterar(pClienteModel: TClienteModel): String;
var
  lQry           : TFDQuery;
  lSQL           : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate(self.NomeTabela, 'CODIGO_CLI');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pClienteModel);
    lQry.ExecSQL;

    Result := pClienteModel.CODIGO_CLI;

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
      sincronizarDados(pClienteModel);

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TClienteDao.excluir(pClienteModel: TClienteModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from ' + self.NomeTabela + ' where CODIGO_CLI = :CODIGO_CLI',[pClienteModel.CODIGO_CLI]);
   lQry.ExecSQL;
   Result := pClienteModel.CODIGO_CLI;
  finally
    lQry.Free;
  end;
end;

function TClienteDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';
  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;
  if FIDRecordView <> '' then
    lSQL := lSQL + ' and CLIENTES.CODIGO_CLI = '+ QuotedStr(FIDRecordView);
  Result := lSQL;
end;

function TClienteDao.nomeCliente(pId: String): Variant;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select coalesce(RAZAO_CLI, FANTASIA_CLI) from ' + self.NomeTabela + ' where CODIGO_CLI = '+ QuotedStr(pId));
end;

procedure TClienteDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := 'select count(*) records From ' + self.NomeTabela + ' where 1=1 ';
    lSql := lSql + where;
    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;

procedure TClienteDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: TClienteModel;
begin
  lQry := vIConexao.CriarQuery;
  FClientesLista := TCollections.CreateList<TClienteModel>(true);
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       clientes.*            '+
	    '  from clientes              '+
      ' where 1=1                   ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TClienteModel.Create(vIConexao);
      FClientesLista.Add(modelo);
      modelo.codigo_cli                 := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.fantasia_cli               := lQry.FieldByName('FANTASIA_CLI').AsString;
      modelo.razao_cli                  := lQry.FieldByName('RAZAO_CLI').AsString;
      modelo.cnpj_cpf_cli               := lQry.FieldByName('CNPJ_CPF_CLI').AsString;
      modelo.inscricao_rg_cli           := lQry.FieldByName('INSCRICAO_RG_CLI').AsString;
      modelo.endereco_cli               := lQry.FieldByName('ENDERECO_CLI').AsString;
      modelo.endereco                   := lQry.FieldByName('ENDERECO').AsString;
      modelo.bairro_cli                 := lQry.FieldByName('BAIRRO_CLI').AsString;
      modelo.cidade_cli                 := lQry.FieldByName('CIDADE_CLI').AsString;
      modelo.uf_cli                     := lQry.FieldByName('UF_CLI').AsString;
      modelo.cep_cli                    := lQry.FieldByName('CEP_CLI').AsString;
      modelo.telefone_cli               := lQry.FieldByName('TELEFONE_CLI').AsString;
      modelo.fax_cli                    := lQry.FieldByName('FAX_CLI').AsString;
      modelo.email_cli                  := lQry.FieldByName('EMAIL_CLI').AsString;
      modelo.url_cli                    := lQry.FieldByName('URL_CLI').AsString;
      modelo.tipo_cli                   := lQry.FieldByName('TIPO_CLI').AsString;
      modelo.atividade_cli              := lQry.FieldByName('ATIVIDADE_CLI').AsString;
      modelo.endcobranca_cli            := lQry.FieldByName('ENDCOBRANCA_CLI').AsString;
      modelo.baircobranca_cli           := lQry.FieldByName('BAIRCOBRANCA_CLI').AsString;
      modelo.cidcobranca_cli            := lQry.FieldByName('CIDCOBRANCA_CLI').AsString;
      modelo.ufcobranca_cli             := lQry.FieldByName('UFCOBRANCA_CLI').AsString;
      modelo.cepcobranca_cli            := lQry.FieldByName('CEPCOBRANCA_CLI').AsString;
      modelo.localtrabalho_cli          := lQry.FieldByName('LOCALTRABALHO_CLI').AsString;
      modelo.cnpj_trabalho_cli          := lQry.FieldByName('CNPJ_TRABALHO_CLI').AsString;
      modelo.endtrabalho_cli            := lQry.FieldByName('ENDTRABALHO_CLI').AsString;
      modelo.bairtrabalho_cli           := lQry.FieldByName('BAIRTRABALHO_CLI').AsString;
      modelo.cidtrabalho_cli            := lQry.FieldByName('CIDTRABALHO_CLI').AsString;
      modelo.uftrabalho_cli             := lQry.FieldByName('UFTRABALHO_CLI').AsString;
      modelo.ceptrabalho_cli            := lQry.FieldByName('CEPTRABALHO_CLI').AsString;
      modelo.fonetrabalho_cli           := lQry.FieldByName('FONETRABALHO_CLI').AsString;
      modelo.funcaotrabalho_cli         := lQry.FieldByName('FUNCAOTRABALHO_CLI').AsString;
      modelo.referencia2_cli            := lQry.FieldByName('REFERENCIA2_CLI').AsString;
      modelo.foneref2_cli               := lQry.FieldByName('FONEREF2_CLI').AsString;
      modelo.referencia3_cli            := lQry.FieldByName('REFERENCIA3_CLI').AsString;
      modelo.foneref3_cli               := lQry.FieldByName('FONEREF3_CLI').AsString;
      modelo.seprocado_cli              := lQry.FieldByName('SEPROCADO_CLI').AsString;
      modelo.referencia1_cli            := lQry.FieldByName('REFERENCIA1_CLI').AsString;
      modelo.foneref1_cli               := lQry.FieldByName('FONEREF1_CLI').AsString;
      modelo.cadastro_cli               := lQry.FieldByName('CADASTRO_CLI').AsString;
      modelo.nascimento_cli             := lQry.FieldByName('NASCIMENTO_CLI').AsString;
      modelo.celular_cli                := lQry.FieldByName('CELULAR_CLI').AsString;
      modelo.pai_cli                    := lQry.FieldByName('PAI_CLI').AsString;
      modelo.mae_cli                    := lQry.FieldByName('MAE_CLI').AsString;
      modelo.contato_cli                := lQry.FieldByName('CONTATO_CLI').AsString;
      modelo.observacao_cli             := lQry.FieldByName('OBSERVACAO_CLI').AsString;
      modelo.banco_cli                  := lQry.FieldByName('BANCO_CLI').AsString;
      modelo.agencia_cli                := lQry.FieldByName('AGENCIA_CLI').AsString;
      modelo.conta_cli                  := lQry.FieldByName('CONTA_CLI').AsString;
      modelo.renda_cli                  := lQry.FieldByName('RENDA_CLI').AsString;
      modelo.foneagencia_cli            := lQry.FieldByName('FONEAGENCIA_CLI').AsString;
      modelo.contatoagencia_cli         := lQry.FieldByName('CONTATOAGENCIA_CLI').AsString;
      modelo.codigo_ven                 := lQry.FieldByName('CODIGO_VEN').AsString;
      modelo.usuario_cli                := lQry.FieldByName('USUARIO_CLI').AsString;
      modelo.estadocivil_cli            := lQry.FieldByName('ESTADOCIVIL_CLI').AsString;
      modelo.nomecon_cli                := lQry.FieldByName('NOMECON_CLI').AsString;
      modelo.cpfcon_cli                 := lQry.FieldByName('CPFCON_CLI').AsString;
      modelo.rgcon_cli                  := lQry.FieldByName('RGCON_CLI').AsString;
      modelo.profcon_cli                := lQry.FieldByName('PROFCON_CLI').AsString;
      modelo.salariocon_cli             := lQry.FieldByName('SALARIOCON_CLI').AsString;
      modelo.convenio_cli               := lQry.FieldByName('CONVENIO_CLI').AsString;
      modelo.convenio_cod               := lQry.FieldByName('CONVENIO_COD').AsString;
      modelo.carta_cli                  := lQry.FieldByName('CARTA_CLI').AsString;
      modelo.expedicao_rg               := lQry.FieldByName('EXPEDICAO_RG').AsString;
      modelo.naturalidade_cli           := lQry.FieldByName('NATURALIDADE_CLI').AsString;
      modelo.uf_naturalidade_cli        := lQry.FieldByName('UF_NATURALIDADE_CLI').AsString;
      modelo.escolaridade_cli           := lQry.FieldByName('ESCOLARIDADE_CLI').AsString;
      modelo.tempo_servico              := lQry.FieldByName('TEMPO_SERVICO').AsString;
      modelo.beneficio_cli              := lQry.FieldByName('BENEFICIO_CLI').AsString;
      modelo.descricao                  := lQry.FieldByName('DESCRICAO').AsString;
      modelo.reduzir_base_icms          := lQry.FieldByName('REDUZIR_BASE_ICMS').AsString;
      modelo.isento_icms                := lQry.FieldByName('ISENTO_ICMS').AsString;
      modelo.loja                       := lQry.FieldByName('LOJA').AsString;
      modelo.data_alteracao             := lQry.FieldByName('DATA_ALTERACAO').AsString;
      modelo.limite_compra              := lQry.FieldByName('LIMITE_COMPRA').AsString;
      modelo.tipo_saida                 := lQry.FieldByName('TIPO_SAIDA').AsString;
      modelo.cod_municipio              := lQry.FieldByName('COD_MUNICIPIO').AsString;
      modelo.ultima_compra              := lQry.FieldByName('ULTIMA_COMPRA').AsString;
      modelo.status                     := lQry.FieldByName('STATUS').AsString;
      modelo.portador                   := lQry.FieldByName('PORTADOR').AsString;
      modelo.sexo_cli                   := lQry.FieldByName('SEXO_CLI').AsString;
      modelo.classif_cli                := lQry.FieldByName('CLASSIF_CLI').AsString;
      modelo.data_retorno               := lQry.FieldByName('DATA_RETORNO').AsString;
      modelo.hora_retorno               := lQry.FieldByName('HORA_RETORNO').AsString;
      modelo.avalista_cli               := lQry.FieldByName('AVALISTA_CLI').AsString;
      modelo.cnpj_cpf_aval_cli          := lQry.FieldByName('CNPJ_CPF_AVAL_CLI').AsString;
      modelo.bairro_aval_cli            := lQry.FieldByName('BAIRRO_AVAL_CLI').AsString;
      modelo.cidade_aval_cli            := lQry.FieldByName('CIDADE_AVAL_CLI').AsString;
      modelo.telefone_aval_cli          := lQry.FieldByName('TELEFONE_AVAL_CLI').AsString;
      modelo.celular_aval_cli           := lQry.FieldByName('CELULAR_AVAL_CLI').AsString;
      modelo.endereco_aval_cli          := lQry.FieldByName('ENDERECO_AVAL_CLI').AsString;
      modelo.isento_ipi                 := lQry.FieldByName('ISENTO_IPI').AsString;
      modelo.revendedor                 := lQry.FieldByName('REVENDEDOR').AsString;
      modelo.credito_cli                := lQry.FieldByName('CREDITO_CLI').AsString;
      modelo.fone_com_aval              := lQry.FieldByName('FONE_COM_AVAL').AsString;
      modelo.rg_aval                    := lQry.FieldByName('RG_AVAL').AsString;
      modelo.mae_aval                   := lQry.FieldByName('MAE_AVAL').AsString;
      modelo.data_nasc_aval             := lQry.FieldByName('DATA_NASC_AVAL').AsString;
      modelo.unidade_consumidora_cb     := lQry.FieldByName('UNIDADE_CONSUMIDORA_CB').AsString;
      modelo.codigo_concessionaria_cb   := lQry.FieldByName('CODIGO_CONCESSIONARIA_CB').AsString;
      modelo.codigo_vendedor_cb         := lQry.FieldByName('CODIGO_VENDEDOR_CB').AsString;
      modelo.titular_conta_cb           := lQry.FieldByName('TITULAR_CONTA_CB').AsString;
      modelo.data_faturamento_cb        := lQry.FieldByName('DATA_FATURAMENTO_CB').AsString;
      modelo.data_vencimento_cb         := lQry.FieldByName('DATA_VENCIMENTO_CB').AsString;
      modelo.celular_cli2               := lQry.FieldByName('CELULAR_CLI2').AsString;
      modelo.operadora_celular          := lQry.FieldByName('OPERADORA_CELULAR').AsString;
      modelo.data_nasc_conjugue         := lQry.FieldByName('DATA_NASC_CONJUGUE').AsString;
      modelo.email2                     := lQry.FieldByName('EMAIL2').AsString;
      modelo.descricao_reparcelamento   := lQry.FieldByName('DESCRICAO_REPARCELAMENTO').AsString;
      modelo.id                         := lQry.FieldByName('ID').AsString;
      modelo.dependente                 := lQry.FieldByName('DEPENDENTE').AsString;
      modelo.nascimento_dependente      := lQry.FieldByName('NASCIMENTO_DEPENDENTE').AsString;
      modelo.sexo_dependente            := lQry.FieldByName('SEXO_DEPENDENTE').AsString;
      modelo.dependente2                := lQry.FieldByName('DEPENDENTE2').AsString;
      modelo.nascimento_dependente2     := lQry.FieldByName('NASCIMENTO_DEPENDENTE2').AsString;
      modelo.sexo_dependente2           := lQry.FieldByName('SEXO_DEPENDENTE2').AsString;
      modelo.dependente3                := lQry.FieldByName('DEPENDENTE3').AsString;
      modelo.nascimento_dependente3     := lQry.FieldByName('NASCIMENTO_DEPENDENTE3').AsString;
      modelo.sexo_dependente3           := lQry.FieldByName('SEXO_DEPENDENTE3').AsString;
      modelo.observacao_ped_orc         := lQry.FieldByName('OBSERVACAO_PED_ORC').AsString;
      modelo.preco_id                   := lQry.FieldByName('PRECO_ID').AsString;
      modelo.suframa                    := lQry.FieldByName('SUFRAMA').AsString;
      modelo.complemento                := lQry.FieldByName('COMPLEMENTO').AsString;
      modelo.numero_end                 := lQry.FieldByName('NUMERO_END').AsString;
      modelo.atividade_id               := lQry.FieldByName('ATIVIDADE_ID').AsString;
      modelo.pais_id                    := lQry.FieldByName('PAIS_ID').AsString;
      modelo.regiao_id                  := lQry.FieldByName('REGIAO_ID').AsString;
      modelo.cfop_id                    := lQry.FieldByName('CFOP_ID').AsString;
      modelo.tipo_suframa               := lQry.FieldByName('TIPO_SUFRAMA').AsString;
      modelo.tipo_apuracao              := lQry.FieldByName('TIPO_APURACAO').AsString;
      modelo.condicoes_pagamento        := lQry.FieldByName('CONDICOES_PAGAMENTO').AsString;
      modelo.consumidor_final           := lQry.FieldByName('CONSUMIDOR_FINAL').AsString;
      modelo.nfe                        := lQry.FieldByName('NFE').AsString;
      modelo.carga_tributaria           := lQry.FieldByName('CARGA_TRIBUTARIA').AsString;
      modelo.desconto_financeiro        := lQry.FieldByName('DESCONTO_FINANCEIRO').AsString;
      modelo.quantidade_terminais       := lQry.FieldByName('QUANTIDADE_TERMINAIS').AsString;
      modelo.telefone_internacional     := lQry.FieldByName('TELEFONE_INTERNACIONAL').AsString;
      modelo.cnae                       := lQry.FieldByName('CNAE').AsString;
      modelo.endereco_entrega           := lQry.FieldByName('ENDERECO_ENTREGA').AsString;
      modelo.bairro_entrega             := lQry.FieldByName('BAIRRO_ENTREGA').AsString;
      modelo.cidade_entrega             := lQry.FieldByName('CIDADE_ENTREGA').AsString;
      modelo.uf_entrega                 := lQry.FieldByName('UF_ENTREGA').AsString;
      modelo.cep_entrega                := lQry.FieldByName('CEP_ENTREGA').AsString;
      modelo.status_carta               := lQry.FieldByName('STATUS_CARTA').AsString;
      modelo.email_cobranca             := lQry.FieldByName('EMAIL_COBRANCA').AsString;
      modelo.contato_cobranca           := lQry.FieldByName('CONTATO_COBRANCA').AsString;
      modelo.telefone_cobranca          := lQry.FieldByName('TELEFONE_COBRANCA').AsString;
      modelo.celular_cobrnaca           := lQry.FieldByName('CELULAR_COBRNACA').AsString;
      modelo.observacao_cobranca        := lQry.FieldByName('OBSERVACAO_COBRANCA').AsString;
      modelo.complemento_cobranca       := lQry.FieldByName('COMPLEMENTO_COBRANCA').AsString;
      modelo.observacao_nfe             := lQry.FieldByName('OBSERVACAO_NFE').AsString;
      modelo.desconto_nf                := lQry.FieldByName('DESCONTO_NF').AsString;
      modelo.obs_geral                  := lQry.FieldByName('OBS_GERAL').AsString;
      modelo.systime                    := lQry.FieldByName('SYSTIME').AsString;
      modelo.tela                       := lQry.FieldByName('TELA').AsString;
      modelo.limite_sms                 := lQry.FieldByName('LIMITE_SMS').AsString;
      modelo.telefone_pai               := lQry.FieldByName('TELEFONE_PAI').AsString;
      modelo.telefone_mae               := lQry.FieldByName('TELEFONE_MAE').AsString;
      modelo.telefone_conjuge           := lQry.FieldByName('TELEFONE_CONJUGE').AsString;
      modelo.multa                      := lQry.FieldByName('MULTA').AsString;
      modelo.juros_bol                  := lQry.FieldByName('JUROS_BOL').AsString;
      modelo.indice_juros_id            := lQry.FieldByName('INDICE_JUROS_ID').AsString;
      modelo.ctb                        := lQry.FieldByName('CTB').AsString;
      modelo.banco_id                   := lQry.FieldByName('BANCO_ID').AsString;
      modelo.instrucao_boleto           := lQry.FieldByName('INSTRUCAO_BOLETO').AsString;
      modelo.dependente4                := lQry.FieldByName('DEPENDENTE4').AsString;
      modelo.nascimento_dependente4     := lQry.FieldByName('NASCIMENTO_DEPENDENTE4').AsString;
      modelo.sexo_dependente4           := lQry.FieldByName('SEXO_DEPENDENTE4').AsString;
      modelo.dependente5                := lQry.FieldByName('DEPENDENTE5').AsString;
      modelo.nascimento_dependente5     := lQry.FieldByName('NASCIMENTO_DEPENDENTE5').AsString;
      modelo.sexo_dependente5           := lQry.FieldByName('SEXO_DEPENDENTE5').AsString;
      modelo.dependente6                := lQry.FieldByName('DEPENDENTE6').AsString;
      modelo.nascimento_dependente6     := lQry.FieldByName('NASCIMENTO_DEPENDENTE6').AsString;
      modelo.sexo_dependente6           := lQry.FieldByName('SEXO_DEPENDENTE6').AsString;
      modelo.isento_st                  := lQry.FieldByName('ISENTO_ST').AsString;
      modelo.frete                      := lQry.FieldByName('FRETE').AsString;
      modelo.prospeccao_id              := lQry.FieldByName('PROSPECCAO_ID').AsString;
      modelo.desc_financeiro            := lQry.FieldByName('DESC_FINANCEIRO').AsString;
      modelo.imagem                     := lQry.FieldByName('IMAGEM').AsString;
      modelo.pratica_esporte            := lQry.FieldByName('PRATICA_ESPORTE').AsString;
      modelo.frequencia                 := lQry.FieldByName('FREQUENCIA').AsString;
      modelo.destro_canhoto             := lQry.FieldByName('DESTRO_CANHOTO').AsString;
      modelo.numero_calcado             := lQry.FieldByName('NUMERO_CALCADO').AsString;
      modelo.calcado_mais_usado         := lQry.FieldByName('CALCADO_MAIS_USADO').AsString;
      modelo.material                   := lQry.FieldByName('MATERIAL').AsString;
      modelo.cirurgia_mmii              := lQry.FieldByName('CIRURGIA_MMII').AsString;
      modelo.tratamento_medicamento     := lQry.FieldByName('TRATAMENTO_MEDICAMENTO').AsString;
      modelo.alergico                   := lQry.FieldByName('ALERGICO').AsString;
      modelo.alergico_obs               := lQry.FieldByName('ALERGICO_OBS').AsString;
      modelo.patologia                  := lQry.FieldByName('PATOLOGIA').AsString;
      modelo.patologia_obs              := lQry.FieldByName('PATOLOGIA_OBS').AsString;
      modelo.diabetes                   := lQry.FieldByName('DIABETES').AsString;
      modelo.diabetes_familiares        := lQry.FieldByName('DIABETES_FAMILIARES').AsString;
      modelo.etilista                   := lQry.FieldByName('ETILISTA').AsString;
      modelo.cardiopatias               := lQry.FieldByName('CARDIOPATIAS').AsString;
      modelo.tabagismo                  := lQry.FieldByName('TABAGISMO').AsString;
      modelo.dst                        := lQry.FieldByName('DST').AsString;
      modelo.pressao                    := lQry.FieldByName('PRESSAO').AsString;
      modelo.gravidez                   := lQry.FieldByName('GRAVIDEZ').AsString;
      modelo.outras_patologias          := lQry.FieldByName('OUTRAS_PATOLOGIAS').AsString;
      modelo.motivo_visita              := lQry.FieldByName('MOTIVO_VISITA').AsString;
      modelo.formato_unha               := lQry.FieldByName('FORMATO_UNHA').AsString;
      modelo.onicotrofia                := lQry.FieldByName('ONICOTROFIA').AsString;
      modelo.onicorrexe                 := lQry.FieldByName('ONICORREXE').AsString;
      modelo.onicogrifose               := lQry.FieldByName('ONICOGRIFOSE').AsString;
      modelo.onicolise                  := lQry.FieldByName('ONICOLISE').AsString;
      modelo.onicomicose                := lQry.FieldByName('ONICOMICOSE').AsString;
      modelo.psoriase                   := lQry.FieldByName('PSORIASE').AsString;
      modelo.onicocriptose              := lQry.FieldByName('ONICOCRIPTOSE').AsString;
      modelo.granulada                  := lQry.FieldByName('GRANULADA').AsString;
      modelo.alteracao_cor              := lQry.FieldByName('ALTERACAO_COR').AsString;
      modelo.onicofose                  := lQry.FieldByName('ONICOFOSE').AsString;
      modelo.exostose_subungueal        := lQry.FieldByName('EXOSTOSE_SUBUNGUEAL').AsString;
      modelo.ungueal                    := lQry.FieldByName('UNGUEAL').AsString;
      modelo.outras_alteracao_laminas   := lQry.FieldByName('OUTRAS_ALTERACAO_LAMINAS').AsString;
      modelo.bromidrose                 := lQry.FieldByName('BROMIDROSE').AsString;
      modelo.anidrose                   := lQry.FieldByName('ANIDROSE').AsString;
      modelo.hiperhidrose               := lQry.FieldByName('HIPERHIDROSE').AsString;
      modelo.isquemica                  := lQry.FieldByName('ISQUEMICA').AsString;
      modelo.frieira                    := lQry.FieldByName('FRIEIRA').AsString;
      modelo.tinea_pedis                := lQry.FieldByName('TINEA_PEDIS').AsString;
      modelo.neuropatica                := lQry.FieldByName('NEUROPATICA').AsString;
      modelo.fissuras                   := lQry.FieldByName('FISSURAS').AsString;
      modelo.disidrose                  := lQry.FieldByName('DISIDROSE').AsString;
      modelo.mal_perfurante             := lQry.FieldByName('MAL_PERFURANTE').AsString;
      modelo.psoriase_pe                := lQry.FieldByName('PSORIASE_PE').AsString;
      modelo.alteracao_pele             := lQry.FieldByName('ALTERACAO_PELE').AsString;
      modelo.halux_valgus               := lQry.FieldByName('HALUX_VALGUS').AsString;
      modelo.halux_rigidus              := lQry.FieldByName('HALUX_RIGIDUS').AsString;
      modelo.esporao_calcaneo           := lQry.FieldByName('ESPORAO_CALCANEO').AsString;
      modelo.pe_cavo                    := lQry.FieldByName('PE_CAVO').AsString;
      modelo.pe_plano                   := lQry.FieldByName('PE_PLANO').AsString;
      modelo.dedos_garra                := lQry.FieldByName('DEDOS_GARRA').AsString;
      modelo.podactilia                 := lQry.FieldByName('PODACTILIA').AsString;
      modelo.alteracao_ortopedicas      := lQry.FieldByName('ALTERACAO_ORTOPEDICAS').AsString;
      modelo.indicacao                  := lQry.FieldByName('INDICACAO').AsString;
      modelo.monofilamento              := lQry.FieldByName('MONOFILAMENTO').AsString;
      modelo.diapasao                   := lQry.FieldByName('DIAPASAO').AsString;
      modelo.digitapressao              := lQry.FieldByName('DIGITAPRESSAO').AsString;
      modelo.pulsos                     := lQry.FieldByName('PULSOS').AsString;
      modelo.perfusao_d                 := lQry.FieldByName('PERFUSAO_D').AsString;
      modelo.perfusao_e                 := lQry.FieldByName('PERFUSAO_E').AsString;
      modelo.usa_nfe                    := lQry.FieldByName('USA_NFE').AsString;
      modelo.usa_nfce                   := lQry.FieldByName('USA_NFCE').AsString;
      modelo.usa_mdfe                   := lQry.FieldByName('USA_MDFE').AsString;
      modelo.usa_cte                    := lQry.FieldByName('USA_CTE').AsString;
      modelo.usa_nfse                   := lQry.FieldByName('USA_NFSE').AsString;
      modelo.usar_controle_kg           := lQry.FieldByName('USAR_CONTROLE_KG').AsString;
      modelo.complemento_entrega        := lQry.FieldByName('COMPLEMENTO_ENTREGA').AsString;
      modelo.numero_entrega             := lQry.FieldByName('NUMERO_ENTREGA').AsString;
      modelo.cod_municipio_entrega      := lQry.FieldByName('COD_MUNICIPIO_ENTREGA').AsString;
      modelo.ex_codigo_postal           := lQry.FieldByName('EX_CODIGO_POSTAL').AsString;
      modelo.ex_estado                  := lQry.FieldByName('EX_ESTADO').AsString;
      modelo.parcela_maxima             := lQry.FieldByName('PARCELA_MAXIMA').AsString;
      modelo.transportadora_id          := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
      modelo.comissao                   := lQry.FieldByName('COMISSAO').AsString;
      modelo.dia_vencimento             := lQry.FieldByName('DIA_VENCIMENTO').AsString;
      modelo.listar_rad                 := lQry.FieldByName('LISTAR_RAD').AsString;
      modelo.contador_id                := lQry.FieldByName('CONTADOR_ID').AsString;
      modelo.vaucher                    := lQry.FieldByName('VAUCHER').AsString;
      modelo.matriz_cliente_id          := lQry.FieldByName('MATRIZ_CLIENTE_ID').AsString;
      modelo.inscricao_municipal        := lQry.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      modelo.envia_sms                  := lQry.FieldByName('ENVIA_SMS').AsString;
      modelo.valor_aluguel              := lQry.FieldByName('VALOR_ALUGUEL').AsString;
      modelo.tempo_residencia           := lQry.FieldByName('TEMPO_RESIDENCIA').AsString;
      modelo.tipo_residencia            := lQry.FieldByName('TIPO_RESIDENCIA').AsString;
      modelo.parentesco_ref1            := lQry.FieldByName('PARENTESCO_REF1').AsString;
      modelo.parentesco_ref2            := lQry.FieldByName('PARENTESCO_REF2').AsString;
      modelo.trabalho_admissao          := lQry.FieldByName('TRABALHO_ADMISSAO').AsString;
      modelo.trabalho_anterior_admissao := lQry.FieldByName('TRABALHO_ANTERIOR_ADMISSAO').AsString;
      modelo.nome_trabalho_anterior     := lQry.FieldByName('NOME_TRABALHO_ANTERIOR').AsString;
      modelo.telefone_trabalho_anterior := lQry.FieldByName('TELEFONE_TRABALHO_ANTERIOR').AsString;
      modelo.funcao_trabalho_anterior   := lQry.FieldByName('FUNCAO_TRABALHO_ANTERIOR').AsString;
      modelo.renda_trabalho_anterior    := lQry.FieldByName('RENDA_TRABALHO_ANTERIOR').AsString;
      modelo.regime_trabalho            := lQry.FieldByName('REGIME_TRABALHO').AsString;
      modelo.confirm_endereco           := lQry.FieldByName('CONFIRM_ENDERECO').AsString;
      modelo.confirm_endereco_anterior  := lQry.FieldByName('CONFIRM_ENDERECO_ANTERIOR').AsString;
      modelo.confirm_trabalho           := lQry.FieldByName('CONFIRM_TRABALHO').AsString;
      modelo.confirm_trabalho_conjuge   := lQry.FieldByName('CONFIRM_TRABALHO_CONJUGE').AsString;
      modelo.desconto_bol               := lQry.FieldByName('DESCONTO_BOL').AsString;
      modelo.produto_tipo_id            := lQry.FieldByName('PRODUTO_TIPO_ID').AsString;
      modelo.pedido_minimo              := lQry.FieldByName('PEDIDO_MINIMO').AsString;
      modelo.reducao_icms               := lQry.FieldByName('REDUCAO_ICMS').AsString;
      modelo.abatimento_bol             := lQry.FieldByName('ABATIMENTO_BOL').AsString;
      modelo.usar_desconto_produto      := lQry.FieldByName('USAR_DESCONTO_PRODUTO').AsString;
      modelo.codigo_anterior            := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
      modelo.senha                      := lQry.FieldByName('SENHA').AsString;
      modelo.ocupacao_id                := lQry.FieldByName('OCUPACAO_ID').AsString;
      modelo.sub_atividade_id           := lQry.FieldByName('SUB_ATIVIDADE_ID').AsString;
      modelo.zemopay                    := lQry.FieldByName('ZEMOPAY').AsString;
      modelo.zemopay_taxa_id            := lQry.FieldByName('ZEMOPAY_TAXA_ID').AsString;
      modelo.zemopay_id                 := lQry.FieldByName('ZEMOPAY_ID').AsString;
      modelo.zemopay_banco_id           := lQry.FieldByName('ZEMOPAY_BANCO_ID').AsString;
      modelo.data_inatividade           := lQry.FieldByName('DATA_INATIVIDADE').AsString;
      modelo.importacao_dados           := lQry.FieldByName('IMPORTACAO_DADOS').AsString;
      modelo.observacao_implantacao     := lQry.FieldByName('OBSERVACAO_IMPLANTACAO').AsString;
      modelo.status_implantacao         := lQry.FieldByName('STATUS_IMPLANTACAO').AsString;
      modelo.nao_contribuinte           := lQry.FieldByName('NAO_CONTRIBUINTE').AsString;
      modelo.grupo_economico_id         := lQry.FieldByName('GRUPO_ECONOMICO_ID').AsString;
      modelo.aceite_bol                 := lQry.FieldByName('ACEITE_BOL').AsString;
      modelo.bloquear_alteracao_tabela  := lQry.FieldByName('BLOQUEAR_ALTERACAO_TABELA').AsString;
      modelo.tipo_emissao_nfe           := lQry.FieldByName('TIPO_EMISSAO_NFE').AsString;
      modelo.percentual_desconto        := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
      modelo.sacador_avalista_id        := lQry.FieldByName('SACADOR_AVALISTA_ID').AsString;
      modelo.tipo_funcionario_publico_cli := lQry.FieldByName('TIPO_FUNCIONARIO_PUBLICO_CLI').AsString;
      modelo.naturalidade_cli           := lQry.FieldByName('NATURALIDADE_CLI').AsString;
      modelo.numbeneficio_cli           := lQry.FieldByName('NUMBENEFICIO_CLI').AsString;
      modelo.fonte_beneficio_cli        := lQry.FieldByName('FONTE_BENEFICIO_CLI').AsString;
      modelo.codigo_ocupacao_cli        := lQry.FieldByName('CODIGO_OCUPACAO_CLI').AsString;
      modelo.docidentificacaoconj_cli   := lQry.FieldByName('DOCIDENTIFICACAOCONJ_CLI').AsString;
      modelo.tipodocidentificacaoconj_cli := lQry.FieldByName('TIPODOCIDENTIFICACAOCONJ_CLI').AsString;
      modelo.tipodoc_cli                := lQry.FieldByName('TIPODOC_CLI').AsString;
      modelo.nome_contador_cli          := lQry.FieldByName('NOME_CONTADOR_CLI').AsString;
      modelo.telefone_contador_cli      := lQry.FieldByName('TELEFONE_CONTADOR_CLI').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

function TClienteDao.obterListaConsulta: IFDDataset;
var
  lQry : TFDQuery;
  lSql,
  lPaginacao : String;
begin
  try
    lQry := vIConexao.CriarQuery;

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := 'first ' + LengthPageView + ' SKIP ' + StartRecordView;

    lSql := 'select '+lPaginacao+'   '+sLineBreak+
            '        codigo_cli,     '+sLineBreak+
            '        fantasia_cli,   '+sLineBreak+
            '        razao_cli,      '+sLineBreak+
            '        telefone_cli,   '+sLineBreak+
            '        cnpj_cpf_cli    '+sLineBreak+
            '   from ' + self.NomeTabela + sLineBreak+
            '  where 1=1             '+sLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by '+FOrderView;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

function TClienteDao.ObterListaMemTable: IFDDataset;
var
  lQry       : TFDQuery;
  lSql,
  lPaginacao : String;

begin
  try

    lQry     := vIConexao.CriarQuery;

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := 'first ' + LengthPageView + ' SKIP ' + StartRecordView;

    lSql := 'select '+ lPaginacao + ' codigo_cli, fantasia_cli, razao_cli, cnpj_cpf_cli, cidade_cli, telefone_cli, email_cli from ' + self.NomeTabela +' where 1=1 ';
    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by '+FOrderView;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

function TClienteDao.ObterBairros: IFDDataset;
var
  lQry : TFDQuery;
  lSql : String;

begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select distinct trim(clientes.bairro_cli) bairro_cli from ' +self.NomeTabela +' where 1=1 ';
    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by '+FOrderView;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TClienteDao.bloquearCNPJCPF(pCliente, pCNPJCPF: String);
var
  lQry : TFDQuery;
  lSql : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  try
    lQry := vIConexao.CriarQuery;

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    lSql := 'select clientes.codigo_cli from ' + self.NomeTabela +
            '  where clientes.codigo_cli <> '+ QuotedStr(pCliente)   +
            '  and clientes.CNPJ_CPF_CLI =  '+ QuotedStr(pCNPJCPF)   ;

    lQry.Open(lSql);

    if not lQry.IsEmpty then begin
      if lConfiguracoes.objeto.valorTag('UNIQUE_CLIENTE', 'S', tvBool) = 'N' then
          if lConfiguracoes.objeto.verificaPerfil('CLIENTES_CPF_CNPJ_DUPLICADO') then
            exit;

      criaException('Existe um cliente cadastrado com o código '+ lQry.FieldByName('CODIGO_CLI').AsString +' associado a este CPF/CNPJ');
    end;

  finally
    lQry.Free;
  end;
end;

procedure TClienteDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TClienteDao.SetClientesLista;
begin
  FClientesLista := Value;
end;

procedure TClienteDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TClienteDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TClienteDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TClienteDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TClienteDao.setParams(var pQry: TFDQuery; pClienteModel: TClienteModel);
begin
  vConstrutor.setParams(NomeTabela,pQry,pClienteModel);
end;

procedure TClienteDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TClienteDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TClienteDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TClienteDao.sincronizarDados(pClienteModel: TClienteModel): String;
var
  lLojasModel,
  lLojas      : ITLojasModel;
  lQry        : TFDQuery;
  lSQL        : String;
begin

  lLojasModel := TLojasModel.getNewIface(vIConexao);

  try
    lLojasModel.objeto.obterHosts;

    lSQL := vConstrutor.gerarUpdateOrInsert('CLIENTES','CODIGO_CLI', 'CODIGO_CLI', true);

    for lLojas in lLojasModel.objeto.LojassLista do
    begin
      if lLojas.objeto.LOJA <> vIConexao.getEmpresa.LOJA then
      begin
        vIConexao.ConfigConexaoExterna('', lLojas.objeto.STRING_CONEXAO);
        lQry := vIConexao.criarQueryExterna;

        lQry.SQL.Clear;
        lQry.SQL.Add(lSQL);
        setParams(lQry, pClienteModel);
        lQry.Open(lSQL);

        Result := lQry.FieldByName('CODIGO_CLI').AsString;
      end;
    end;

  finally
    lLojasModel:=nil;
    lQry.Free;
  end;
end;

function TClienteDao.ufCliente(pId: String): Variant;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select UF_CLI from ' + self.NomeTabela + ' where CODIGO_CLI = '+ QuotedStr(pId));
end;

end.
