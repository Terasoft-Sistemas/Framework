unit ClienteDao;

interface

uses
  ClienteModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TClienteDao = class

  private
    vIConexao : Iconexao;
    vConstrutor : TConstrutorDao;

    FClientesLista: TObjectList<TClienteModel>;
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
    procedure SetClientesLista(const Value: TObjectList<TClienteModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pClienteModel: TClienteModel);

  public
    constructor Create(pIConexao : Iconexao);
    destructor Destroy; override;
    property ClientesLista: TObjectList<TClienteModel> read FClientesLista write SetClientesLista;
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

    procedure obterLista;

    function where: String;
    function carregaClasse(pId: String): TClienteModel;
    function ufCliente(pId: String): Variant;
    function nomeCliente(pId: String): Variant;
    function diasAtraso(pCodigoCliente: String): Variant;

end;
implementation

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
    lQry.Open('select * from CLIENTES where CODIGO_CLI = '+ QuotedStr(pId));

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
    lModel.CONFIRM_TRABALHO_CONJUGE    := lQry.FieldByName('CONFIRM_TRABALHO_CONJUGE').AsString;
    lModel.DESCONTO_BOL                := lQry.FieldByName('DESCONTO_BOL').AsString;
    lModel.PRODUTO_TIPO_ID             := lQry.FieldByName('PRODUTO_TIPO_ID').AsString;
    lModel.PEDIDO_MINIMO               := lQry.FieldByName('PEDIDO_MINIMO').AsString;
    lModel.REDUCAO_ICMS                := lQry.FieldByName('REDUCAO_ICMS').AsString;
    lModel.ABATIMENTO_BOL              := lQry.FieldByName('ABATIMENTO_BOL').AsString;
    lModel.USAR_DESCONTO_PRODUTO       := lQry.FieldByName('USAR_DESCONTO_PRODUTO').AsString;
    lModel.CODIGO_ANTERIOR             := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.SENHA                       := lQry.FieldByName('SENHA').AsString;
    lModel.OCUPACAO_ID                 := lQry.FieldByName('OCUPACAO_ID').AsString;
    lModel.SUB_ATIVIDADE_ID            := lQry.FieldByName('SUB_ATIVIDADE_ID').AsString;
    lModel.ZEMOPAY                     := lQry.FieldByName('ZEMOPAY').AsString;
    lModel.ZEMOPAY_TAXA_ID             := lQry.FieldByName('ZEMOPAY_TAXA_ID').AsString;
    lModel.ZEMOPAY_ID                  := lQry.FieldByName('ZEMOPAY_ID').AsString;
    lModel.ZEMOPAY_BANCO_ID            := lQry.FieldByName('ZEMOPAY_BANCO_ID').AsString;
    lModel.DATA_INATIVIDADE            := lQry.FieldByName('DATA_INATIVIDADE').AsString;
    lModel.IMPORTACAO_DADOS            := lQry.FieldByName('IMPORTACAO_DADOS').AsString;
    lModel.OBSERVACAO_IMPLANTACAO      := lQry.FieldByName('OBSERVACAO_IMPLANTACAO').AsString;
    lModel.STATUS_IMPLANTACAO          := lQry.FieldByName('STATUS_IMPLANTACAO').AsString;
    lModel.NAO_CONTRIBUINTE            := lQry.FieldByName('NAO_CONTRIBUINTE').AsString;
    lModel.GRUPO_ECONOMICO_ID          := lQry.FieldByName('GRUPO_ECONOMICO_ID').AsString;
    lModel.ACEITE_BOL                  := lQry.FieldByName('ACEITE_BOL').AsString;
    lModel.BLOQUEAR_ALTERACAO_TABELA   := lQry.FieldByName('BLOQUEAR_ALTERACAO_TABELA').AsString;
    lModel.TIPO_EMISSAO_NFE            := lQry.FieldByName('TIPO_EMISSAO_NFE').AsString;
    lModel.PERCENTUAL_DESCONTO         := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TClienteDao.Create(pIConexao : Iconexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TClienteDao.Destroy;
begin
  inherited;
end;

function TClienteDao.diasAtraso(pCodigoCliente: String): Variant;
begin
  Result := vIConexao
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
end;

function TClienteDao.incluir(pClienteModel: TClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CLIENTES', 'CODIGO_CLI', true);

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('CODIGO_CLI').Value := vIConexao.Generetor('GEN_CLIENTE');
    setParams(lQry, pClienteModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_CLI').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TClienteDao.alterar(pClienteModel: TClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CLIENTES', 'CODIGO_CLI');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('CODIGO_CLI').Value   := ifThen(pClienteModel.CODIGO_CLI   = '', Unassigned, pClienteModel.CODIGO_CLI);
    setParams(lQry, pClienteModel);
    lQry.ExecSQL;

    Result := pClienteModel.CODIGO_CLI;

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
   lQry.ExecSQL('delete from CLIENTES where CODIGO_CLI = :CODIGO_CLI',[pClienteModel.CODIGO_CLI]);
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
  Result   := lConexao.ExecSQLScalar('select coalesce(RAZAO_CLI, FANTASIA_CLI) from CLIENTES where CODIGO_CLI = '+ QuotedStr(pId));
end;

procedure TClienteDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := 'select count(*) records From CLIENTES where 1=1 ';
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;
  FClientesLista := TObjectList<TClienteModel>.Create;
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
    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FClientesLista.Add(TClienteModel.Create(vIConexao));
      i := FClientesLista.Count -1;
      FClientesLista[i].codigo_cli                 := lQry.FieldByName('CODIGO_CLI').AsString;
      FClientesLista[i].fantasia_cli               := lQry.FieldByName('FANTASIA_CLI').AsString;
      FClientesLista[i].razao_cli                  := lQry.FieldByName('RAZAO_CLI').AsString;
      FClientesLista[i].cnpj_cpf_cli               := lQry.FieldByName('CNPJ_CPF_CLI').AsString;
      FClientesLista[i].inscricao_rg_cli           := lQry.FieldByName('INSCRICAO_RG_CLI').AsString;
      FClientesLista[i].endereco_cli               := lQry.FieldByName('ENDERECO_CLI').AsString;
      FClientesLista[i].endereco                   := lQry.FieldByName('ENDERECO').AsString;
      FClientesLista[i].bairro_cli                 := lQry.FieldByName('BAIRRO_CLI').AsString;
      FClientesLista[i].cidade_cli                 := lQry.FieldByName('CIDADE_CLI').AsString;
      FClientesLista[i].uf_cli                     := lQry.FieldByName('UF_CLI').AsString;
      FClientesLista[i].cep_cli                    := lQry.FieldByName('CEP_CLI').AsString;
      FClientesLista[i].telefone_cli               := lQry.FieldByName('TELEFONE_CLI').AsString;
      FClientesLista[i].fax_cli                    := lQry.FieldByName('FAX_CLI').AsString;
      FClientesLista[i].email_cli                  := lQry.FieldByName('EMAIL_CLI').AsString;
      FClientesLista[i].url_cli                    := lQry.FieldByName('URL_CLI').AsString;
      FClientesLista[i].tipo_cli                   := lQry.FieldByName('TIPO_CLI').AsString;
      FClientesLista[i].atividade_cli              := lQry.FieldByName('ATIVIDADE_CLI').AsString;
      FClientesLista[i].endcobranca_cli            := lQry.FieldByName('ENDCOBRANCA_CLI').AsString;
      FClientesLista[i].baircobranca_cli           := lQry.FieldByName('BAIRCOBRANCA_CLI').AsString;
      FClientesLista[i].cidcobranca_cli            := lQry.FieldByName('CIDCOBRANCA_CLI').AsString;
      FClientesLista[i].ufcobranca_cli             := lQry.FieldByName('UFCOBRANCA_CLI').AsString;
      FClientesLista[i].cepcobranca_cli            := lQry.FieldByName('CEPCOBRANCA_CLI').AsString;
      FClientesLista[i].localtrabalho_cli          := lQry.FieldByName('LOCALTRABALHO_CLI').AsString;
      FClientesLista[i].endtrabalho_cli            := lQry.FieldByName('ENDTRABALHO_CLI').AsString;
      FClientesLista[i].bairtrabalho_cli           := lQry.FieldByName('BAIRTRABALHO_CLI').AsString;
      FClientesLista[i].cidtrabalho_cli            := lQry.FieldByName('CIDTRABALHO_CLI').AsString;
      FClientesLista[i].uftrabalho_cli             := lQry.FieldByName('UFTRABALHO_CLI').AsString;
      FClientesLista[i].ceptrabalho_cli            := lQry.FieldByName('CEPTRABALHO_CLI').AsString;
      FClientesLista[i].fonetrabalho_cli           := lQry.FieldByName('FONETRABALHO_CLI').AsString;
      FClientesLista[i].funcaotrabalho_cli         := lQry.FieldByName('FUNCAOTRABALHO_CLI').AsString;
      FClientesLista[i].referencia2_cli            := lQry.FieldByName('REFERENCIA2_CLI').AsString;
      FClientesLista[i].foneref2_cli               := lQry.FieldByName('FONEREF2_CLI').AsString;
      FClientesLista[i].referencia3_cli            := lQry.FieldByName('REFERENCIA3_CLI').AsString;
      FClientesLista[i].foneref3_cli               := lQry.FieldByName('FONEREF3_CLI').AsString;
      FClientesLista[i].seprocado_cli              := lQry.FieldByName('SEPROCADO_CLI').AsString;
      FClientesLista[i].referencia1_cli            := lQry.FieldByName('REFERENCIA1_CLI').AsString;
      FClientesLista[i].foneref1_cli               := lQry.FieldByName('FONEREF1_CLI').AsString;
      FClientesLista[i].cadastro_cli               := lQry.FieldByName('CADASTRO_CLI').AsString;
      FClientesLista[i].nascimento_cli             := lQry.FieldByName('NASCIMENTO_CLI').AsString;
      FClientesLista[i].celular_cli                := lQry.FieldByName('CELULAR_CLI').AsString;
      FClientesLista[i].pai_cli                    := lQry.FieldByName('PAI_CLI').AsString;
      FClientesLista[i].mae_cli                    := lQry.FieldByName('MAE_CLI').AsString;
      FClientesLista[i].contato_cli                := lQry.FieldByName('CONTATO_CLI').AsString;
      FClientesLista[i].observacao_cli             := lQry.FieldByName('OBSERVACAO_CLI').AsString;
      FClientesLista[i].banco_cli                  := lQry.FieldByName('BANCO_CLI').AsString;
      FClientesLista[i].agencia_cli                := lQry.FieldByName('AGENCIA_CLI').AsString;
      FClientesLista[i].conta_cli                  := lQry.FieldByName('CONTA_CLI').AsString;
      FClientesLista[i].renda_cli                  := lQry.FieldByName('RENDA_CLI').AsString;
      FClientesLista[i].foneagencia_cli            := lQry.FieldByName('FONEAGENCIA_CLI').AsString;
      FClientesLista[i].contatoagencia_cli         := lQry.FieldByName('CONTATOAGENCIA_CLI').AsString;
      FClientesLista[i].codigo_ven                 := lQry.FieldByName('CODIGO_VEN').AsString;
      FClientesLista[i].usuario_cli                := lQry.FieldByName('USUARIO_CLI').AsString;
      FClientesLista[i].estadocivil_cli            := lQry.FieldByName('ESTADOCIVIL_CLI').AsString;
      FClientesLista[i].nomecon_cli                := lQry.FieldByName('NOMECON_CLI').AsString;
      FClientesLista[i].cpfcon_cli                 := lQry.FieldByName('CPFCON_CLI').AsString;
      FClientesLista[i].rgcon_cli                  := lQry.FieldByName('RGCON_CLI').AsString;
      FClientesLista[i].profcon_cli                := lQry.FieldByName('PROFCON_CLI').AsString;
      FClientesLista[i].salariocon_cli             := lQry.FieldByName('SALARIOCON_CLI').AsString;
      FClientesLista[i].convenio_cli               := lQry.FieldByName('CONVENIO_CLI').AsString;
      FClientesLista[i].convenio_cod               := lQry.FieldByName('CONVENIO_COD').AsString;
      FClientesLista[i].carta_cli                  := lQry.FieldByName('CARTA_CLI').AsString;
      FClientesLista[i].expedicao_rg               := lQry.FieldByName('EXPEDICAO_RG').AsString;
      FClientesLista[i].naturalidade_cli           := lQry.FieldByName('NATURALIDADE_CLI').AsString;
      FClientesLista[i].tempo_servico              := lQry.FieldByName('TEMPO_SERVICO').AsString;
      FClientesLista[i].beneficio_cli              := lQry.FieldByName('BENEFICIO_CLI').AsString;
      FClientesLista[i].descricao                  := lQry.FieldByName('DESCRICAO').AsString;
      FClientesLista[i].reduzir_base_icms          := lQry.FieldByName('REDUZIR_BASE_ICMS').AsString;
      FClientesLista[i].isento_icms                := lQry.FieldByName('ISENTO_ICMS').AsString;
      FClientesLista[i].loja                       := lQry.FieldByName('LOJA').AsString;
      FClientesLista[i].data_alteracao             := lQry.FieldByName('DATA_ALTERACAO').AsString;
      FClientesLista[i].limite_compra              := lQry.FieldByName('LIMITE_COMPRA').AsString;
      FClientesLista[i].tipo_saida                 := lQry.FieldByName('TIPO_SAIDA').AsString;
      FClientesLista[i].cod_municipio              := lQry.FieldByName('COD_MUNICIPIO').AsString;
      FClientesLista[i].ultima_compra              := lQry.FieldByName('ULTIMA_COMPRA').AsString;
      FClientesLista[i].status                     := lQry.FieldByName('STATUS').AsString;
      FClientesLista[i].portador                   := lQry.FieldByName('PORTADOR').AsString;
      FClientesLista[i].sexo_cli                   := lQry.FieldByName('SEXO_CLI').AsString;
      FClientesLista[i].classif_cli                := lQry.FieldByName('CLASSIF_CLI').AsString;
      FClientesLista[i].data_retorno               := lQry.FieldByName('DATA_RETORNO').AsString;
      FClientesLista[i].hora_retorno               := lQry.FieldByName('HORA_RETORNO').AsString;
      FClientesLista[i].avalista_cli               := lQry.FieldByName('AVALISTA_CLI').AsString;
      FClientesLista[i].cnpj_cpf_aval_cli          := lQry.FieldByName('CNPJ_CPF_AVAL_CLI').AsString;
      FClientesLista[i].bairro_aval_cli            := lQry.FieldByName('BAIRRO_AVAL_CLI').AsString;
      FClientesLista[i].cidade_aval_cli            := lQry.FieldByName('CIDADE_AVAL_CLI').AsString;
      FClientesLista[i].telefone_aval_cli          := lQry.FieldByName('TELEFONE_AVAL_CLI').AsString;
      FClientesLista[i].celular_aval_cli           := lQry.FieldByName('CELULAR_AVAL_CLI').AsString;
      FClientesLista[i].endereco_aval_cli          := lQry.FieldByName('ENDERECO_AVAL_CLI').AsString;
      FClientesLista[i].isento_ipi                 := lQry.FieldByName('ISENTO_IPI').AsString;
      FClientesLista[i].revendedor                 := lQry.FieldByName('REVENDEDOR').AsString;
      FClientesLista[i].credito_cli                := lQry.FieldByName('CREDITO_CLI').AsString;
      FClientesLista[i].fone_com_aval              := lQry.FieldByName('FONE_COM_AVAL').AsString;
      FClientesLista[i].rg_aval                    := lQry.FieldByName('RG_AVAL').AsString;
      FClientesLista[i].mae_aval                   := lQry.FieldByName('MAE_AVAL').AsString;
      FClientesLista[i].data_nasc_aval             := lQry.FieldByName('DATA_NASC_AVAL').AsString;
      FClientesLista[i].unidade_consumidora_cb     := lQry.FieldByName('UNIDADE_CONSUMIDORA_CB').AsString;
      FClientesLista[i].codigo_concessionaria_cb   := lQry.FieldByName('CODIGO_CONCESSIONARIA_CB').AsString;
      FClientesLista[i].codigo_vendedor_cb         := lQry.FieldByName('CODIGO_VENDEDOR_CB').AsString;
      FClientesLista[i].titular_conta_cb           := lQry.FieldByName('TITULAR_CONTA_CB').AsString;
      FClientesLista[i].data_faturamento_cb        := lQry.FieldByName('DATA_FATURAMENTO_CB').AsString;
      FClientesLista[i].data_vencimento_cb         := lQry.FieldByName('DATA_VENCIMENTO_CB').AsString;
      FClientesLista[i].celular_cli2               := lQry.FieldByName('CELULAR_CLI2').AsString;
      FClientesLista[i].operadora_celular          := lQry.FieldByName('OPERADORA_CELULAR').AsString;
      FClientesLista[i].data_nasc_conjugue         := lQry.FieldByName('DATA_NASC_CONJUGUE').AsString;
      FClientesLista[i].email2                     := lQry.FieldByName('EMAIL2').AsString;
      FClientesLista[i].descricao_reparcelamento   := lQry.FieldByName('DESCRICAO_REPARCELAMENTO').AsString;
      FClientesLista[i].id                         := lQry.FieldByName('ID').AsString;
      FClientesLista[i].dependente                 := lQry.FieldByName('DEPENDENTE').AsString;
      FClientesLista[i].nascimento_dependente      := lQry.FieldByName('NASCIMENTO_DEPENDENTE').AsString;
      FClientesLista[i].sexo_dependente            := lQry.FieldByName('SEXO_DEPENDENTE').AsString;
      FClientesLista[i].dependente2                := lQry.FieldByName('DEPENDENTE2').AsString;
      FClientesLista[i].nascimento_dependente2     := lQry.FieldByName('NASCIMENTO_DEPENDENTE2').AsString;
      FClientesLista[i].sexo_dependente2           := lQry.FieldByName('SEXO_DEPENDENTE2').AsString;
      FClientesLista[i].dependente3                := lQry.FieldByName('DEPENDENTE3').AsString;
      FClientesLista[i].nascimento_dependente3     := lQry.FieldByName('NASCIMENTO_DEPENDENTE3').AsString;
      FClientesLista[i].sexo_dependente3           := lQry.FieldByName('SEXO_DEPENDENTE3').AsString;
      FClientesLista[i].observacao_ped_orc         := lQry.FieldByName('OBSERVACAO_PED_ORC').AsString;
      FClientesLista[i].preco_id                   := lQry.FieldByName('PRECO_ID').AsString;
      FClientesLista[i].suframa                    := lQry.FieldByName('SUFRAMA').AsString;
      FClientesLista[i].complemento                := lQry.FieldByName('COMPLEMENTO').AsString;
      FClientesLista[i].numero_end                 := lQry.FieldByName('NUMERO_END').AsString;
      FClientesLista[i].atividade_id               := lQry.FieldByName('ATIVIDADE_ID').AsString;
      FClientesLista[i].pais_id                    := lQry.FieldByName('PAIS_ID').AsString;
      FClientesLista[i].regiao_id                  := lQry.FieldByName('REGIAO_ID').AsString;
      FClientesLista[i].cfop_id                    := lQry.FieldByName('CFOP_ID').AsString;
      FClientesLista[i].tipo_suframa               := lQry.FieldByName('TIPO_SUFRAMA').AsString;
      FClientesLista[i].tipo_apuracao              := lQry.FieldByName('TIPO_APURACAO').AsString;
      FClientesLista[i].condicoes_pagamento        := lQry.FieldByName('CONDICOES_PAGAMENTO').AsString;
      FClientesLista[i].consumidor_final           := lQry.FieldByName('CONSUMIDOR_FINAL').AsString;
      FClientesLista[i].nfe                        := lQry.FieldByName('NFE').AsString;
      FClientesLista[i].carga_tributaria           := lQry.FieldByName('CARGA_TRIBUTARIA').AsString;
      FClientesLista[i].desconto_financeiro        := lQry.FieldByName('DESCONTO_FINANCEIRO').AsString;
      FClientesLista[i].quantidade_terminais       := lQry.FieldByName('QUANTIDADE_TERMINAIS').AsString;
      FClientesLista[i].telefone_internacional     := lQry.FieldByName('TELEFONE_INTERNACIONAL').AsString;
      FClientesLista[i].cnae                       := lQry.FieldByName('CNAE').AsString;
      FClientesLista[i].endereco_entrega           := lQry.FieldByName('ENDERECO_ENTREGA').AsString;
      FClientesLista[i].bairro_entrega             := lQry.FieldByName('BAIRRO_ENTREGA').AsString;
      FClientesLista[i].cidade_entrega             := lQry.FieldByName('CIDADE_ENTREGA').AsString;
      FClientesLista[i].uf_entrega                 := lQry.FieldByName('UF_ENTREGA').AsString;
      FClientesLista[i].cep_entrega                := lQry.FieldByName('CEP_ENTREGA').AsString;
      FClientesLista[i].status_carta               := lQry.FieldByName('STATUS_CARTA').AsString;
      FClientesLista[i].email_cobranca             := lQry.FieldByName('EMAIL_COBRANCA').AsString;
      FClientesLista[i].contato_cobranca           := lQry.FieldByName('CONTATO_COBRANCA').AsString;
      FClientesLista[i].telefone_cobranca          := lQry.FieldByName('TELEFONE_COBRANCA').AsString;
      FClientesLista[i].celular_cobrnaca           := lQry.FieldByName('CELULAR_COBRNACA').AsString;
      FClientesLista[i].observacao_cobranca        := lQry.FieldByName('OBSERVACAO_COBRANCA').AsString;
      FClientesLista[i].complemento_cobranca       := lQry.FieldByName('COMPLEMENTO_COBRANCA').AsString;
      FClientesLista[i].observacao_nfe             := lQry.FieldByName('OBSERVACAO_NFE').AsString;
      FClientesLista[i].desconto_nf                := lQry.FieldByName('DESCONTO_NF').AsString;
      FClientesLista[i].obs_geral                  := lQry.FieldByName('OBS_GERAL').AsString;
      FClientesLista[i].systime                    := lQry.FieldByName('SYSTIME').AsString;
      FClientesLista[i].tela                       := lQry.FieldByName('TELA').AsString;
      FClientesLista[i].limite_sms                 := lQry.FieldByName('LIMITE_SMS').AsString;
      FClientesLista[i].telefone_pai               := lQry.FieldByName('TELEFONE_PAI').AsString;
      FClientesLista[i].telefone_mae               := lQry.FieldByName('TELEFONE_MAE').AsString;
      FClientesLista[i].telefone_conjuge           := lQry.FieldByName('TELEFONE_CONJUGE').AsString;
      FClientesLista[i].multa                      := lQry.FieldByName('MULTA').AsString;
      FClientesLista[i].juros_bol                  := lQry.FieldByName('JUROS_BOL').AsString;
      FClientesLista[i].indice_juros_id            := lQry.FieldByName('INDICE_JUROS_ID').AsString;
      FClientesLista[i].ctb                        := lQry.FieldByName('CTB').AsString;
      FClientesLista[i].banco_id                   := lQry.FieldByName('BANCO_ID').AsString;
      FClientesLista[i].instrucao_boleto           := lQry.FieldByName('INSTRUCAO_BOLETO').AsString;
      FClientesLista[i].dependente4                := lQry.FieldByName('DEPENDENTE4').AsString;
      FClientesLista[i].nascimento_dependente4     := lQry.FieldByName('NASCIMENTO_DEPENDENTE4').AsString;
      FClientesLista[i].sexo_dependente4           := lQry.FieldByName('SEXO_DEPENDENTE4').AsString;
      FClientesLista[i].dependente5                := lQry.FieldByName('DEPENDENTE5').AsString;
      FClientesLista[i].nascimento_dependente5     := lQry.FieldByName('NASCIMENTO_DEPENDENTE5').AsString;
      FClientesLista[i].sexo_dependente5           := lQry.FieldByName('SEXO_DEPENDENTE5').AsString;
      FClientesLista[i].dependente6                := lQry.FieldByName('DEPENDENTE6').AsString;
      FClientesLista[i].nascimento_dependente6     := lQry.FieldByName('NASCIMENTO_DEPENDENTE6').AsString;
      FClientesLista[i].sexo_dependente6           := lQry.FieldByName('SEXO_DEPENDENTE6').AsString;
      FClientesLista[i].isento_st                  := lQry.FieldByName('ISENTO_ST').AsString;
      FClientesLista[i].frete                      := lQry.FieldByName('FRETE').AsString;
      FClientesLista[i].prospeccao_id              := lQry.FieldByName('PROSPECCAO_ID').AsString;
      FClientesLista[i].desc_financeiro            := lQry.FieldByName('DESC_FINANCEIRO').AsString;
      FClientesLista[i].imagem                     := lQry.FieldByName('IMAGEM').AsString;
      FClientesLista[i].pratica_esporte            := lQry.FieldByName('PRATICA_ESPORTE').AsString;
      FClientesLista[i].frequencia                 := lQry.FieldByName('FREQUENCIA').AsString;
      FClientesLista[i].destro_canhoto             := lQry.FieldByName('DESTRO_CANHOTO').AsString;
      FClientesLista[i].numero_calcado             := lQry.FieldByName('NUMERO_CALCADO').AsString;
      FClientesLista[i].calcado_mais_usado         := lQry.FieldByName('CALCADO_MAIS_USADO').AsString;
      FClientesLista[i].material                   := lQry.FieldByName('MATERIAL').AsString;
      FClientesLista[i].cirurgia_mmii              := lQry.FieldByName('CIRURGIA_MMII').AsString;
      FClientesLista[i].tratamento_medicamento     := lQry.FieldByName('TRATAMENTO_MEDICAMENTO').AsString;
      FClientesLista[i].alergico                   := lQry.FieldByName('ALERGICO').AsString;
      FClientesLista[i].alergico_obs               := lQry.FieldByName('ALERGICO_OBS').AsString;
      FClientesLista[i].patologia                  := lQry.FieldByName('PATOLOGIA').AsString;
      FClientesLista[i].patologia_obs              := lQry.FieldByName('PATOLOGIA_OBS').AsString;
      FClientesLista[i].diabetes                   := lQry.FieldByName('DIABETES').AsString;
      FClientesLista[i].diabetes_familiares        := lQry.FieldByName('DIABETES_FAMILIARES').AsString;
      FClientesLista[i].etilista                   := lQry.FieldByName('ETILISTA').AsString;
      FClientesLista[i].cardiopatias               := lQry.FieldByName('CARDIOPATIAS').AsString;
      FClientesLista[i].tabagismo                  := lQry.FieldByName('TABAGISMO').AsString;
      FClientesLista[i].dst                        := lQry.FieldByName('DST').AsString;
      FClientesLista[i].pressao                    := lQry.FieldByName('PRESSAO').AsString;
      FClientesLista[i].gravidez                   := lQry.FieldByName('GRAVIDEZ').AsString;
      FClientesLista[i].outras_patologias          := lQry.FieldByName('OUTRAS_PATOLOGIAS').AsString;
      FClientesLista[i].motivo_visita              := lQry.FieldByName('MOTIVO_VISITA').AsString;
      FClientesLista[i].formato_unha               := lQry.FieldByName('FORMATO_UNHA').AsString;
      FClientesLista[i].onicotrofia                := lQry.FieldByName('ONICOTROFIA').AsString;
      FClientesLista[i].onicorrexe                 := lQry.FieldByName('ONICORREXE').AsString;
      FClientesLista[i].onicogrifose               := lQry.FieldByName('ONICOGRIFOSE').AsString;
      FClientesLista[i].onicolise                  := lQry.FieldByName('ONICOLISE').AsString;
      FClientesLista[i].onicomicose                := lQry.FieldByName('ONICOMICOSE').AsString;
      FClientesLista[i].psoriase                   := lQry.FieldByName('PSORIASE').AsString;
      FClientesLista[i].onicocriptose              := lQry.FieldByName('ONICOCRIPTOSE').AsString;
      FClientesLista[i].granulada                  := lQry.FieldByName('GRANULADA').AsString;
      FClientesLista[i].alteracao_cor              := lQry.FieldByName('ALTERACAO_COR').AsString;
      FClientesLista[i].onicofose                  := lQry.FieldByName('ONICOFOSE').AsString;
      FClientesLista[i].exostose_subungueal        := lQry.FieldByName('EXOSTOSE_SUBUNGUEAL').AsString;
      FClientesLista[i].ungueal                    := lQry.FieldByName('UNGUEAL').AsString;
      FClientesLista[i].outras_alteracao_laminas   := lQry.FieldByName('OUTRAS_ALTERACAO_LAMINAS').AsString;
      FClientesLista[i].bromidrose                 := lQry.FieldByName('BROMIDROSE').AsString;
      FClientesLista[i].anidrose                   := lQry.FieldByName('ANIDROSE').AsString;
      FClientesLista[i].hiperhidrose               := lQry.FieldByName('HIPERHIDROSE').AsString;
      FClientesLista[i].isquemica                  := lQry.FieldByName('ISQUEMICA').AsString;
      FClientesLista[i].frieira                    := lQry.FieldByName('FRIEIRA').AsString;
      FClientesLista[i].tinea_pedis                := lQry.FieldByName('TINEA_PEDIS').AsString;
      FClientesLista[i].neuropatica                := lQry.FieldByName('NEUROPATICA').AsString;
      FClientesLista[i].fissuras                   := lQry.FieldByName('FISSURAS').AsString;
      FClientesLista[i].disidrose                  := lQry.FieldByName('DISIDROSE').AsString;
      FClientesLista[i].mal_perfurante             := lQry.FieldByName('MAL_PERFURANTE').AsString;
      FClientesLista[i].psoriase_pe                := lQry.FieldByName('PSORIASE_PE').AsString;
      FClientesLista[i].alteracao_pele             := lQry.FieldByName('ALTERACAO_PELE').AsString;
      FClientesLista[i].halux_valgus               := lQry.FieldByName('HALUX_VALGUS').AsString;
      FClientesLista[i].halux_rigidus              := lQry.FieldByName('HALUX_RIGIDUS').AsString;
      FClientesLista[i].esporao_calcaneo           := lQry.FieldByName('ESPORAO_CALCANEO').AsString;
      FClientesLista[i].pe_cavo                    := lQry.FieldByName('PE_CAVO').AsString;
      FClientesLista[i].pe_plano                   := lQry.FieldByName('PE_PLANO').AsString;
      FClientesLista[i].dedos_garra                := lQry.FieldByName('DEDOS_GARRA').AsString;
      FClientesLista[i].podactilia                 := lQry.FieldByName('PODACTILIA').AsString;
      FClientesLista[i].alteracao_ortopedicas      := lQry.FieldByName('ALTERACAO_ORTOPEDICAS').AsString;
      FClientesLista[i].indicacao                  := lQry.FieldByName('INDICACAO').AsString;
      FClientesLista[i].monofilamento              := lQry.FieldByName('MONOFILAMENTO').AsString;
      FClientesLista[i].diapasao                   := lQry.FieldByName('DIAPASAO').AsString;
      FClientesLista[i].digitapressao              := lQry.FieldByName('DIGITAPRESSAO').AsString;
      FClientesLista[i].pulsos                     := lQry.FieldByName('PULSOS').AsString;
      FClientesLista[i].perfusao_d                 := lQry.FieldByName('PERFUSAO_D').AsString;
      FClientesLista[i].perfusao_e                 := lQry.FieldByName('PERFUSAO_E').AsString;
      FClientesLista[i].usa_nfe                    := lQry.FieldByName('USA_NFE').AsString;
      FClientesLista[i].usa_nfce                   := lQry.FieldByName('USA_NFCE').AsString;
      FClientesLista[i].usa_mdfe                   := lQry.FieldByName('USA_MDFE').AsString;
      FClientesLista[i].usa_cte                    := lQry.FieldByName('USA_CTE').AsString;
      FClientesLista[i].usa_nfse                   := lQry.FieldByName('USA_NFSE').AsString;
      FClientesLista[i].usar_controle_kg           := lQry.FieldByName('USAR_CONTROLE_KG').AsString;
      FClientesLista[i].complemento_entrega        := lQry.FieldByName('COMPLEMENTO_ENTREGA').AsString;
      FClientesLista[i].numero_entrega             := lQry.FieldByName('NUMERO_ENTREGA').AsString;
      FClientesLista[i].cod_municipio_entrega      := lQry.FieldByName('COD_MUNICIPIO_ENTREGA').AsString;
      FClientesLista[i].ex_codigo_postal           := lQry.FieldByName('EX_CODIGO_POSTAL').AsString;
      FClientesLista[i].ex_estado                  := lQry.FieldByName('EX_ESTADO').AsString;
      FClientesLista[i].parcela_maxima             := lQry.FieldByName('PARCELA_MAXIMA').AsString;
      FClientesLista[i].transportadora_id          := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
      FClientesLista[i].comissao                   := lQry.FieldByName('COMISSAO').AsString;
      FClientesLista[i].dia_vencimento             := lQry.FieldByName('DIA_VENCIMENTO').AsString;
      FClientesLista[i].listar_rad                 := lQry.FieldByName('LISTAR_RAD').AsString;
      FClientesLista[i].contador_id                := lQry.FieldByName('CONTADOR_ID').AsString;
      FClientesLista[i].vaucher                    := lQry.FieldByName('VAUCHER').AsString;
      FClientesLista[i].matriz_cliente_id          := lQry.FieldByName('MATRIZ_CLIENTE_ID').AsString;
      FClientesLista[i].inscricao_municipal        := lQry.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      FClientesLista[i].envia_sms                  := lQry.FieldByName('ENVIA_SMS').AsString;
      FClientesLista[i].valor_aluguel              := lQry.FieldByName('VALOR_ALUGUEL').AsString;
      FClientesLista[i].tempo_residencia           := lQry.FieldByName('TEMPO_RESIDENCIA').AsString;
      FClientesLista[i].tipo_residencia            := lQry.FieldByName('TIPO_RESIDENCIA').AsString;
      FClientesLista[i].parentesco_ref1            := lQry.FieldByName('PARENTESCO_REF1').AsString;
      FClientesLista[i].parentesco_ref2            := lQry.FieldByName('PARENTESCO_REF2').AsString;
      FClientesLista[i].trabalho_admissao          := lQry.FieldByName('TRABALHO_ADMISSAO').AsString;
      FClientesLista[i].trabalho_anterior_admissao := lQry.FieldByName('TRABALHO_ANTERIOR_ADMISSAO').AsString;
      FClientesLista[i].nome_trabalho_anterior     := lQry.FieldByName('NOME_TRABALHO_ANTERIOR').AsString;
      FClientesLista[i].telefone_trabalho_anterior := lQry.FieldByName('TELEFONE_TRABALHO_ANTERIOR').AsString;
      FClientesLista[i].funcao_trabalho_anterior   := lQry.FieldByName('FUNCAO_TRABALHO_ANTERIOR').AsString;
      FClientesLista[i].renda_trabalho_anterior    := lQry.FieldByName('RENDA_TRABALHO_ANTERIOR').AsString;
      FClientesLista[i].regime_trabalho            := lQry.FieldByName('REGIME_TRABALHO').AsString;
      FClientesLista[i].confirm_endereco           := lQry.FieldByName('CONFIRM_ENDERECO').AsString;
      FClientesLista[i].confirm_endereco_anterior  := lQry.FieldByName('CONFIRM_ENDERECO_ANTERIOR').AsString;
      FClientesLista[i].confirm_trabalho           := lQry.FieldByName('CONFIRM_TRABALHO').AsString;
      FClientesLista[i].confirm_trabalho_conjuge   := lQry.FieldByName('CONFIRM_TRABALHO_CONJUGE').AsString;
      FClientesLista[i].desconto_bol               := lQry.FieldByName('DESCONTO_BOL').AsString;
      FClientesLista[i].produto_tipo_id            := lQry.FieldByName('PRODUTO_TIPO_ID').AsString;
      FClientesLista[i].pedido_minimo              := lQry.FieldByName('PEDIDO_MINIMO').AsString;
      FClientesLista[i].reducao_icms               := lQry.FieldByName('REDUCAO_ICMS').AsString;
      FClientesLista[i].abatimento_bol             := lQry.FieldByName('ABATIMENTO_BOL').AsString;
      FClientesLista[i].usar_desconto_produto      := lQry.FieldByName('USAR_DESCONTO_PRODUTO').AsString;
      FClientesLista[i].codigo_anterior            := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
      FClientesLista[i].senha                      := lQry.FieldByName('SENHA').AsString;
      FClientesLista[i].ocupacao_id                := lQry.FieldByName('OCUPACAO_ID').AsString;
      FClientesLista[i].sub_atividade_id           := lQry.FieldByName('SUB_ATIVIDADE_ID').AsString;
      FClientesLista[i].zemopay                    := lQry.FieldByName('ZEMOPAY').AsString;
      FClientesLista[i].zemopay_taxa_id            := lQry.FieldByName('ZEMOPAY_TAXA_ID').AsString;
      FClientesLista[i].zemopay_id                 := lQry.FieldByName('ZEMOPAY_ID').AsString;
      FClientesLista[i].zemopay_banco_id           := lQry.FieldByName('ZEMOPAY_BANCO_ID').AsString;
      FClientesLista[i].data_inatividade           := lQry.FieldByName('DATA_INATIVIDADE').AsString;
      FClientesLista[i].importacao_dados           := lQry.FieldByName('IMPORTACAO_DADOS').AsString;
      FClientesLista[i].observacao_implantacao     := lQry.FieldByName('OBSERVACAO_IMPLANTACAO').AsString;
      FClientesLista[i].status_implantacao         := lQry.FieldByName('STATUS_IMPLANTACAO').AsString;
      FClientesLista[i].nao_contribuinte           := lQry.FieldByName('NAO_CONTRIBUINTE').AsString;
      FClientesLista[i].grupo_economico_id         := lQry.FieldByName('GRUPO_ECONOMICO_ID').AsString;
      FClientesLista[i].aceite_bol                 := lQry.FieldByName('ACEITE_BOL').AsString;
      FClientesLista[i].bloquear_alteracao_tabela  := lQry.FieldByName('BLOQUEAR_ALTERACAO_TABELA').AsString;
      FClientesLista[i].tipo_emissao_nfe           := lQry.FieldByName('TIPO_EMISSAO_NFE').AsString;
      FClientesLista[i].percentual_desconto        := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
      FClientesLista[i].sacador_avalista_id        := lQry.FieldByName('SACADOR_AVALISTA_ID').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TClienteDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TClienteDao.SetClientesLista(const Value: TObjectList<TClienteModel>);
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

procedure TClienteDao.setParams(var pQry: TFDQuery;
  pClienteModel: TClienteModel);
begin
  pQry.ParamByName('codigo_cli').Value    				:= ifThen(pClienteModel.CODIGO_CLI							= '', Unassigned, pClienteModel.codigo_cli.CODIGO_CLI);
  pQry.ParamByName('fantasia_cli').Value    				:= ifThen(pClienteModel.FANTASIA_CLI						= '', Unassigned, pClienteModel.fantasia_cli.FANTASIA_CLI);
  pQry.ParamByName('razao_cli').Value    					:= ifThen(pClienteModel.RAZAO_CLI							= '', Unassigned, pClienteModel.razao_cli.RAZAO_CLI);
  pQry.ParamByName('cnpj_cpf_cli').Value    				:= ifThen(pClienteModel.CNPJ_CPF_CLI						= '', Unassigned, pClienteModel.cnpj_cpf_cli.CNPJ_CPF_CLI);
  pQry.ParamByName('inscricao_rg_cli').Value    			:= ifThen(pClienteModel.INSCRICAO_RG_CLI					= '', Unassigned, pClienteModel.inscricao_rg_cli.INSCRICAO_RG_CLI);
  pQry.ParamByName('endereco_cli').Value    				:= ifThen(pClienteModel.ENDERECO_CLI						= '', Unassigned, pClienteModel.endereco_cli.ENDERECO_CLI);
  pQry.ParamByName('endereco').Value    					:= ifThen(pClienteModel.ENDERECO							= '', Unassigned, pClienteModel.endereco.ENDERECO);
  pQry.ParamByName('bairro_cli').Value    				:= ifThen(pClienteModel.BAIRRO_CLI							= '', Unassigned, pClienteModel.bairro_cli.BAIRRO_CLI);
  pQry.ParamByName('cidade_cli').Value    				:= ifThen(pClienteModel.CIDADE_CLI							= '', Unassigned, pClienteModel.cidade_cli.CIDADE_CLI);
  pQry.ParamByName('uf_cli').Value    					:= ifThen(pClienteModel.UF_CLI								= '', Unassigned, pClienteModel.uf_cli.UF_CLI);
  pQry.ParamByName('cep_cli').Value    					:= ifThen(pClienteModel.CEP_CLI								= '', Unassigned, pClienteModel.cep_cli.CEP_CLI);
  pQry.ParamByName('telefone_cli').Value    				:= ifThen(pClienteModel.TELEFONE_CLI						= '', Unassigned, pClienteModel.telefone_cli.TELEFONE_CLI);
  pQry.ParamByName('fax_cli').Value    					:= ifThen(pClienteModel.FAX_CLI								= '', Unassigned, pClienteModel.fax_cli.FAX_CLI);
  pQry.ParamByName('email_cli').Value    					:= ifThen(pClienteModel.EMAIL_CLI							= '', Unassigned, pClienteModel.email_cli.EMAIL_CLI);
  pQry.ParamByName('url_cli').Value    					:= ifThen(pClienteModel.URL_CLI								= '', Unassigned, pClienteModel.url_cli.URL_CLI);
  pQry.ParamByName('tipo_cli').Value    					:= ifThen(pClienteModel.TIPO_CLI							= '', Unassigned, pClienteModel.tipo_cli.TIPO_CLI);
  pQry.ParamByName('atividade_cli').Value    				:= ifThen(pClienteModel.ATIVIDADE_CLI						= '', Unassigned, pClienteModel.atividade_cli.ATIVIDADE_CLI);
  pQry.ParamByName('endcobranca_cli').Value    			:= ifThen(pClienteModel.ENDCOBRANCA_CLI						= '', Unassigned, pClienteModel.endcobranca_cli.ENDCOBRANCA_CLI);
  pQry.ParamByName('baircobranca_cli').Value    			:= ifThen(pClienteModel.BAIRCOBRANCA_CLI					= '', Unassigned, pClienteModel.baircobranca_cli.BAIRCOBRANCA_CLI);
  pQry.ParamByName('cidcobranca_cli').Value    			:= ifThen(pClienteModel.CIDCOBRANCA_CLI						= '', Unassigned, pClienteModel.cidcobranca_cli.CIDCOBRANCA_CLI);
  pQry.ParamByName('ufcobranca_cli').Value    			:= ifThen(pClienteModel.UFCOBRANCA_CLI						= '', Unassigned, pClienteModel.ufcobranca_cli.UFCOBRANCA_CLI);
  pQry.ParamByName('cepcobranca_cli').Value    			:= ifThen(pClienteModel.CEPCOBRANCA_CLI						= '', Unassigned, pClienteModel.cepcobranca_cli.CEPCOBRANCA_CLI);
  pQry.ParamByName('localtrabalho_cli').Value    			:= ifThen(pClienteModel.LOCALTRABALHO_CLI					= '', Unassigned, pClienteModel.localtrabalho_cli.LOCALTRABALHO_CLI);
  pQry.ParamByName('endtrabalho_cli').Value    			:= ifThen(pClienteModel.ENDTRABALHO_CLI						= '', Unassigned, pClienteModel.endtrabalho_cli.ENDTRABALHO_CLI);
  pQry.ParamByName('bairtrabalho_cli').Value    			:= ifThen(pClienteModel.BAIRTRABALHO_CLI					= '', Unassigned, pClienteModel.bairtrabalho_cli.BAIRTRABALHO_CLI);
  pQry.ParamByName('cidtrabalho_cli').Value    			:= ifThen(pClienteModel.CIDTRABALHO_CLI						= '', Unassigned, pClienteModel.cidtrabalho_cli.CIDTRABALHO_CLI);
  pQry.ParamByName('uftrabalho_cli').Value    			:= ifThen(pClienteModel.UFTRABALHO_CLI						= '', Unassigned, pClienteModel.uftrabalho_cli.UFTRABALHO_CLI);
  pQry.ParamByName('ceptrabalho_cli').Value    			:= ifThen(pClienteModel.CEPTRABALHO_CLI						= '', Unassigned, pClienteModel.ceptrabalho_cli.CEPTRABALHO_CLI);
  pQry.ParamByName('fonetrabalho_cli').Value    			:= ifThen(pClienteModel.FONETRABALHO_CLI					= '', Unassigned, pClienteModel.fonetrabalho_cli.FONETRABALHO_CLI);
  pQry.ParamByName('funcaotrabalho_cli').Value    		:= ifThen(pClienteModel.FUNCAOTRABALHO_CLI					= '', Unassigned, pClienteModel.funcaotrabalho_cli.FUNCAOTRABALHO_CLI);
  pQry.ParamByName('referencia2_cli').Value    			:= ifThen(pClienteModel.REFERENCIA2_CLI						= '', Unassigned, pClienteModel.referencia2_cli.REFERENCIA2_CLI);
  pQry.ParamByName('foneref2_cli').Value    				:= ifThen(pClienteModel.FONEREF2_CLI						= '', Unassigned, pClienteModel.foneref2_cli.FONEREF2_CLI);
  pQry.ParamByName('referencia3_cli').Value    			:= ifThen(pClienteModel.REFERENCIA3_CLI						= '', Unassigned, pClienteModel.referencia3_cli.REFERENCIA3_CLI);
  pQry.ParamByName('foneref3_cli').Value    				:= ifThen(pClienteModel.FONEREF3_CLI						= '', Unassigned, pClienteModel.foneref3_cli.FONEREF3_CLI);
  pQry.ParamByName('seprocado_cli').Value    				:= ifThen(pClienteModel.SEPROCADO_CLI						= '', Unassigned, pClienteModel.seprocado_cli.SEPROCADO_CLI);
  pQry.ParamByName('referencia1_cli').Value    			:= ifThen(pClienteModel.REFERENCIA1_CLI						= '', Unassigned, pClienteModel.referencia1_cli.REFERENCIA1_CLI);
  pQry.ParamByName('foneref1_cli').Value    				:= ifThen(pClienteModel.FONEREF1_CLI						= '', Unassigned, pClienteModel.foneref1_cli.FONEREF1_CLI);
  pQry.ParamByName('cadastro_cli').Value    				:= ifThen(pClienteModel.CADASTRO_CLI						= '', Unassigned, pClienteModel.cadastro_cli.CADASTRO_CLI);
  pQry.ParamByName('nascimento_cli').Value    			:= ifThen(pClienteModel.NASCIMENTO_CLI						= '', Unassigned, pClienteModel.nascimento_cli.NASCIMENTO_CLI);
  pQry.ParamByName('celular_cli').Value    	  			:= ifThen(pClienteModel.CELULAR_CLI							= '', Unassigned, pClienteModel.celular_cli.CELULAR_CLI);
  pQry.ParamByName('pai_cli').Value    					:= ifThen(pClienteModel.PAI_CLI								= '', Unassigned, pClienteModel.pai_cli.PAI_CLI);
  pQry.ParamByName('mae_cli').Value    					:= ifThen(pClienteModel.MAE_CLI								= '', Unassigned, pClienteModel.mae_cli.MAE_CLI);
  pQry.ParamByName('contato_cli').Value    				:= ifThen(pClienteModel.CONTATO_CLI							= '', Unassigned, pClienteModel.contato_cli.CONTATO_CLI);
  pQry.ParamByName('observacao_cli').Value    			:= ifThen(pClienteModel.OBSERVACAO_CLI						= '', Unassigned, pClienteModel.observacao_cli.OBSERVACAO_CLI);
  pQry.ParamByName('banco_cli').Value    					:= ifThen(pClienteModel.BANCO_CLI							= '', Unassigned, pClienteModel.banco_cli.BANCO_CLI);
  pQry.ParamByName('agencia_cli').Value    				:= ifThen(pClienteModel.AGENCIA_CLI							= '', Unassigned, pClienteModel.agencia_cli.AGENCIA_CLI);
  pQry.ParamByName('conta_cli').Value    					:= ifThen(pClienteModel.CONTA_CLI							= '', Unassigned, pClienteModel.conta_cli.CONTA_CLI);
  pQry.ParamByName('renda_cli').Value    					:= ifThen(pClienteModel.RENDA_CLI							= '', Unassigned, pClienteModel.renda_cli.RENDA_CLI);
  pQry.ParamByName('foneagencia_cli').Value    			:= ifThen(pClienteModel.FONEAGENCIA_CLI						= '', Unassigned, pClienteModel.foneagencia_cli.FONEAGENCIA_CLI);
  pQry.ParamByName('contatoagencia_cli').Value    		:= ifThen(pClienteModel.CONTATOAGENCIA_CLI					= '', Unassigned, pClienteModel.contatoagencia_cli.CONTATOAGENCIA_CLI);
  pQry.ParamByName('codigo_ven').Value    				:= ifThen(pClienteModel.CODIGO_VEN							= '', Unassigned, pClienteModel.codigo_ven.CODIGO_VEN);
  pQry.ParamByName('usuario_cli').Value    				:= ifThen(pClienteModel.USUARIO_CLI							= '', Unassigned, pClienteModel.usuario_cli.USUARIO_CLI);
  pQry.ParamByName('estadocivil_cli').Value    			:= ifThen(pClienteModel.ESTADOCIVIL_CLI						= '', Unassigned, pClienteModel.estadocivil_cli.ESTADOCIVIL_CLI);
  pQry.ParamByName('nomecon_cli').Value    				:= ifThen(pClienteModel.NOMECON_CLI							= '', Unassigned, pClienteModel.nomecon_cli.NOMECON_CLI);
  pQry.ParamByName('cpfcon_cli').Value    				:= ifThen(pClienteModel.CPFCON_CLI							= '', Unassigned, pClienteModel.cpfcon_cli.CPFCON_CLI);
  pQry.ParamByName('rgcon_cli').Value    					:= ifThen(pClienteModel.RGCON_CLI							= '', Unassigned, pClienteModel.rgcon_cli.RGCON_CLI);
  pQry.ParamByName('profcon_cli').Value    				:= ifThen(pClienteModel.PROFCON_CLI							= '', Unassigned, pClienteModel.profcon_cli.PROFCON_CLI);
  pQry.ParamByName('salariocon_cli').Value    			:= ifThen(pClienteModel.SALARIOCON_CLI						= '', Unassigned, pClienteModel.salariocon_cli.SALARIOCON_CLI);
  pQry.ParamByName('convenio_cli').Value    				:= ifThen(pClienteModel.CONVENIO_CLI						= '', Unassigned, pClienteModel.convenio_cli.CONVENIO_CLI);
  pQry.ParamByName('convenio_cod').Value    				:= ifThen(pClienteModel.CONVENIO_COD						= '', Unassigned, pClienteModel.convenio_cod.CONVENIO_COD);
  pQry.ParamByName('carta_cli').Value    					:= ifThen(pClienteModel.CARTA_CLI							= '', Unassigned, pClienteModel.carta_cli.CARTA_CLI);
  pQry.ParamByName('expedicao_rg').Value    				:= ifThen(pClienteModel.EXPEDICAO_RG						= '', Unassigned, pClienteModel.expedicao_rg.EXPEDICAO_RG);
  pQry.ParamByName('naturalidade_cli').Value    			:= ifThen(pClienteModel.NATURALIDADE_CLI					= '', Unassigned, pClienteModel.naturalidade_cli.NATURALIDADE_CLI);
  pQry.ParamByName('tempo_servico').Value    				:= ifThen(pClienteModel.TEMPO_SERVICO						= '', Unassigned, pClienteModel.tempo_servico.TEMPO_SERVICO);
  pQry.ParamByName('beneficio_cli').Value    				:= ifThen(pClienteModel.BENEFICIO_CLI						= '', Unassigned, pClienteModel.beneficio_cli.BENEFICIO_CLI);
  pQry.ParamByName('descricao').Value    					:= ifThen(pClienteModel.DESCRICAO							= '', Unassigned, pClienteModel.descricao.DESCRICAO);
  pQry.ParamByName('reduzir_base_icms').Value    			:= ifThen(pClienteModel.REDUZIR_BASE_ICMS					= '', Unassigned, pClienteModel.reduzir_base_icms.REDUZIR_BASE_ICMS);
  pQry.ParamByName('isento_icms').Value    				:= ifThen(pClienteModel.ISENTO_ICMS							= '', Unassigned, pClienteModel.isento_icms.ISENTO_ICMS);
  pQry.ParamByName('loja').Value    						:= ifThen(pClienteModel.LOJA								= '', Unassigned, pClienteModel.loja.LOJA);
  pQry.ParamByName('data_alteracao').Value    			:= ifThen(pClienteModel.DATA_ALTERACAO						= '', Unassigned, pClienteModel.data_alteracao.DATA_ALTERACAO);
  pQry.ParamByName('limite_compra').Value    				:= ifThen(pClienteModel.LIMITE_COMPRA						= '', Unassigned, pClienteModel.limite_compra.LIMITE_COMPRA);
  pQry.ParamByName('tipo_saida').Value    				:= ifThen(pClienteModel.TIPO_SAIDA							= '', Unassigned, pClienteModel.tipo_saida.TIPO_SAIDA);
  pQry.ParamByName('cod_municipio').Value    				:= ifThen(pClienteModel.COD_MUNICIPIO						= '', Unassigned, pClienteModel.cod_municipio.COD_MUNICIPIO);
  pQry.ParamByName('ultima_compra').Value    				:= ifThen(pClienteModel.ULTIMA_COMPRA						= '', Unassigned, pClienteModel.ultima_compra.ULTIMA_COMPRA);
  pQry.ParamByName('status').Value    					:= ifThen(pClienteModel.STATUS								= '', Unassigned, pClienteModel.status.STATUS);
  pQry.ParamByName('portador').Value    					:= ifThen(pClienteModel.PORTADOR							= '', Unassigned, pClienteModel.portador.PORTADOR);
  pQry.ParamByName('sexo_cli').Value    					:= ifThen(pClienteModel.SEXO_CLI							= '', Unassigned, pClienteModel.sexo_cli.SEXO_CLI);
  pQry.ParamByName('classif_cli').Value    				:= ifThen(pClienteModel.CLASSIF_CLI							= '', Unassigned, pClienteModel.classif_cli.CLASSIF_CLI);
  pQry.ParamByName('data_retorno').Value    				:= ifThen(pClienteModel.DATA_RETORNO						= '', Unassigned, pClienteModel.data_retorno.DATA_RETORNO);
  pQry.ParamByName('hora_retorno').Value    				:= ifThen(pClienteModel.HORA_RETORNO						= '', Unassigned, pClienteModel.hora_retorno.HORA_RETORNO);
  pQry.ParamByName('avalista_cli').Value    				:= ifThen(pClienteModel.AVALISTA_CLI						= '', Unassigned, pClienteModel.avalista_cli.AVALISTA_CLI);
  pQry.ParamByName('cnpj_cpf_aval_cli').Value    			:= ifThen(pClienteModel.CNPJ_CPF_AVAL_CLI					= '', Unassigned, pClienteModel.cnpj_cpf_aval_cli.CNPJ_CPF_AVAL_CLI);
  pQry.ParamByName('bairro_aval_cli').Value    			:= ifThen(pClienteModel.BAIRRO_AVAL_CLI						= '', Unassigned, pClienteModel.bairro_aval_cli.BAIRRO_AVAL_CLI);
  pQry.ParamByName('cidade_aval_cli').Value    			:= ifThen(pClienteModel.CIDADE_AVAL_CLI						= '', Unassigned, pClienteModel.cidade_aval_cli.CIDADE_AVAL_CLI);
  pQry.ParamByName('telefone_aval_cli').Value    			:= ifThen(pClienteModel.TELEFONE_AVAL_CLI					= '', Unassigned, pClienteModel.telefone_aval_cli.TELEFONE_AVAL_CLI);
  pQry.ParamByName('celular_aval_cli').Value    			:= ifThen(pClienteModel.CELULAR_AVAL_CLI					= '', Unassigned, pClienteModel.celular_aval_cli.CELULAR_AVAL_CLI);
  pQry.ParamByName('endereco_aval_cli').Value    			:= ifThen(pClienteModel.ENDERECO_AVAL_CLI					= '', Unassigned, pClienteModel.endereco_aval_cli.ENDERECO_AVAL_CLI);
  pQry.ParamByName('isento_ipi').Value    				:= ifThen(pClienteModel.ISENTO_IPI							= '', Unassigned, pClienteModel.isento_ipi.ISENTO_IPI);
  pQry.ParamByName('revendedor').Value    				:= ifThen(pClienteModel.REVENDEDOR							= '', Unassigned, pClienteModel.revendedor.REVENDEDOR);
  pQry.ParamByName('credito_cli').Value    				:= ifThen(pClienteModel.CREDITO_CLI							= '', Unassigned, pClienteModel.credito_cli.CREDITO_CLI);
  pQry.ParamByName('fone_com_aval').Value    				:= ifThen(pClienteModel.FONE_COM_AVAL						= '', Unassigned, pClienteModel.fone_com_aval.FONE_COM_AVAL);
  pQry.ParamByName('rg_aval').Value    					:= ifThen(pClienteModel.RG_AVAL								= '', Unassigned, pClienteModel.rg_aval.RG_AVAL);
  pQry.ParamByName('mae_aval').Value    					:= ifThen(pClienteModel.MAE_AVAL							= '', Unassigned, pClienteModel.mae_aval.MAE_AVAL);
  pQry.ParamByName('data_nasc_aval').Value    			:= ifThen(pClienteModel.DATA_NASC_AVAL						= '', Unassigned, pClienteModel.data_nasc_aval.DATA_NASC_AVAL);
  pQry.ParamByName('unidade_consumidora_cb').Value    	:= ifThen(pClienteModel.UNIDADE_CONSUMIDORA_CB				= '', Unassigned, pClienteModel.unidade_consumidora_cb.UNIDADE_CONSUMIDORA_CB);
  pQry.ParamByName('codigo_concessionaria_cb').Value    	:= ifThen(pClienteModel.CODIGO_CONCESSIONARIA_CB			= '', Unassigned, pClienteModel.codigo_concessionaria_cb.CODIGO_CONCESSIONARIA_CB);
  pQry.ParamByName('codigo_vendedor_cb').Value    		:= ifThen(pClienteModel.CODIGO_VENDEDOR_CB					= '', Unassigned, pClienteModel.codigo_vendedor_cb.CODIGO_VENDEDOR_CB);
  pQry.ParamByName('titular_conta_cb').Value    			:= ifThen(pClienteModel.TITULAR_CONTA_CB					= '', Unassigned, pClienteModel.titular_conta_cb.TITULAR_CONTA_CB);
  pQry.ParamByName('data_faturamento_cb').Value    		:= ifThen(pClienteModel.DATA_FATURAMENTO_CB					= '', Unassigned, pClienteModel.data_faturamento_cb.DATA_FATURAMENTO_CB);
  pQry.ParamByName('data_vencimento_cb').Value    		:= ifThen(pClienteModel.DATA_VENCIMENTO_CB					= '', Unassigned, pClienteModel.data_vencimento_cb.DATA_VENCIMENTO_CB);
  pQry.ParamByName('celular_cli2').Value    				:= ifThen(pClienteModel.CELULAR_CLI2						= '', Unassigned, pClienteModel.celular_cli2.CELULAR_CLI2);
  pQry.ParamByName('operadora_celular').Value    			:= ifThen(pClienteModel.OPERADORA_CELULAR					= '', Unassigned, pClienteModel.operadora_celular.OPERADORA_CELULAR);
  pQry.ParamByName('data_nasc_conjugue').Value    		:= ifThen(pClienteModel.DATA_NASC_CONJUGUE					= '', Unassigned, pClienteModel.data_nasc_conjugue.DATA_NASC_CONJUGUE);
  pQry.ParamByName('email2').Value    					:= ifThen(pClienteModel.EMAIL2								= '', Unassigned, pClienteModel.email2.EMAIL2);
  pQry.ParamByName('descricao_reparcelamento').Value    	:= ifThen(pClienteModel.DESCRICAO_REPARCELAMENTO			= '', Unassigned, pClienteModel.descricao_reparcelamento.DESCRICAO_REPARCELAMENTO);
  pQry.ParamByName('id').Value    						:= ifThen(pClienteModel.ID									= '', Unassigned, pClienteModel.id.ID);
  pQry.ParamByName('dependente').Value    				:= ifThen(pClienteModel.DEPENDENTE							= '', Unassigned, pClienteModel.dependente.DEPENDENTE);
  pQry.ParamByName('nascimento_dependente').Value    		:= ifThen(pClienteModel.NASCIMENTO_DEPENDENTE				= '', Unassigned, pClienteModel.nascimento_dependente.NASCIMENTO_DEPENDENTE);
  pQry.ParamByName('sexo_dependente').Value    			:= ifThen(pClienteModel.SEXO_DEPENDENTE						= '', Unassigned, pClienteModel.sexo_dependente.SEXO_DEPENDENTE);
  pQry.ParamByName('dependente2').Value    				:= ifThen(pClienteModel.DEPENDENTE2							= '', Unassigned, pClienteModel.dependente2.DEPENDENTE2);
  pQry.ParamByName('nascimento_dependente2').Value    	:= ifThen(pClienteModel.NASCIMENTO_DEPENDENTE2				= '', Unassigned, pClienteModel.nascimento_dependente2.NASCIMENTO_DEPENDENTE2);
  pQry.ParamByName('sexo_dependente2').Value    			:= ifThen(pClienteModel.SEXO_DEPENDENTE2					= '', Unassigned, pClienteModel.sexo_dependente2.SEXO_DEPENDENTE2);
  pQry.ParamByName('dependente3').Value    				:= ifThen(pClienteModel.DEPENDENTE3							= '', Unassigned, pClienteModel.dependente3.DEPENDENTE3);
  pQry.ParamByName('nascimento_dependente3').Value    	:= ifThen(pClienteModel.NASCIMENTO_DEPENDENTE3				= '', Unassigned, pClienteModel.nascimento_dependente3.NASCIMENTO_DEPENDENTE3);
  pQry.ParamByName('sexo_dependente3').Value    			:= ifThen(pClienteModel.SEXO_DEPENDENTE3					= '', Unassigned, pClienteModel.sexo_dependente3.SEXO_DEPENDENTE3);
  pQry.ParamByName('observacao_ped_orc').Value    		:= ifThen(pClienteModel.OBSERVACAO_PED_ORC					= '', Unassigned, pClienteModel.observacao_ped_orc.OBSERVACAO_PED_ORC);
  pQry.ParamByName('preco_id').Value    					:= ifThen(pClienteModel.PRECO_ID							= '', Unassigned, pClienteModel.preco_id.PRECO_ID);
  pQry.ParamByName('suframa').Value    					:= ifThen(pClienteModel.SUFRAMA								= '', Unassigned, pClienteModel.suframa.SUFRAMA);
  pQry.ParamByName('complemento').Value    				:= ifThen(pClienteModel.COMPLEMENTO							= '', Unassigned, pClienteModel.complemento.COMPLEMENTO);
  pQry.ParamByName('numero_end').Value    				:= ifThen(pClienteModel.NUMERO_END							= '', Unassigned, pClienteModel.numero_end.NUMERO_END);
  pQry.ParamByName('atividade_id').Value    				:= ifThen(pClienteModel.ATIVIDADE_ID						= '', Unassigned, pClienteModel.atividade_id.ATIVIDADE_ID);
  pQry.ParamByName('pais_id').Value    					:= ifThen(pClienteModel.PAIS_ID								= '', Unassigned, pClienteModel.pais_id.PAIS_ID);
  pQry.ParamByName('regiao_id').Value    					:= ifThen(pClienteModel.REGIAO_ID							= '', Unassigned, pClienteModel.regiao_id.REGIAO_ID);
  pQry.ParamByName('cfop_id').Value    					:= ifThen(pClienteModel.CFOP_ID								= '', Unassigned, pClienteModel.cfop_id.CFOP_ID);
  pQry.ParamByName('tipo_suframa').Value    				:= ifThen(pClienteModel.TIPO_SUFRAMA						= '', Unassigned, pClienteModel.tipo_suframa.TIPO_SUFRAMA);
  pQry.ParamByName('tipo_apuracao').Value    				:= ifThen(pClienteModel.TIPO_APURACAO						= '', Unassigned, pClienteModel.tipo_apuracao.TIPO_APURACAO);
  pQry.ParamByName('condicoes_pagamento').Value    		:= ifThen(pClienteModel.CONDICOES_PAGAMENTO					= '', Unassigned, pClienteModel.condicoes_pagamento.CONDICOES_PAGAMENTO);
  pQry.ParamByName('consumidor_final').Value    			:= ifThen(pClienteModel.CONSUMIDOR_FINAL					= '', Unassigned, pClienteModel.consumidor_final.CONSUMIDOR_FINAL);
  pQry.ParamByName('nfe').Value    						:= ifThen(pClienteModel.NFE									= '', Unassigned, pClienteModel.nfe.NFE);
  pQry.ParamByName('carga_tributaria').Value    			:= ifThen(pClienteModel.CARGA_TRIBUTARIA					= '', Unassigned, pClienteModel.carga_tributaria.CARGA_TRIBUTARIA);
  pQry.ParamByName('desconto_financeiro').Value    		:= ifThen(pClienteModel.DESCONTO_FINANCEIRO					= '', Unassigned, pClienteModel.desconto_financeiro.DESCONTO_FINANCEIRO);
  pQry.ParamByName('quantidade_terminais').Value    		:= ifThen(pClienteModel.QUANTIDADE_TERMINAIS				= '', Unassigned, pClienteModel.quantidade_terminais.QUANTIDADE_TERMINAIS);
  pQry.ParamByName('telefone_internacional').Value    	:= ifThen(pClienteModel.TELEFONE_INTERNACIONAL				= '', Unassigned, pClienteModel.telefone_internacional.TELEFONE_INTERNACIONAL);
  pQry.ParamByName('cnae').Value    						:= ifThen(pClienteModel.CNAE								= '', Unassigned, pClienteModel.cnae.CNAE);
  pQry.ParamByName('endereco_entrega').Value    			:= ifThen(pClienteModel.ENDERECO_ENTREGA					= '', Unassigned, pClienteModel.endereco_entrega.ENDERECO_ENTREGA);
  pQry.ParamByName('bairro_entrega').Value    			:= ifThen(pClienteModel.BAIRRO_ENTREGA						= '', Unassigned, pClienteModel.bairro_entrega.BAIRRO_ENTREGA);
  pQry.ParamByName('cidade_entrega').Value    			:= ifThen(pClienteModel.CIDADE_ENTREGA						= '', Unassigned, pClienteModel.cidade_entrega.CIDADE_ENTREGA);
  pQry.ParamByName('uf_entrega').Value    				:= ifThen(pClienteModel.UF_ENTREGA							= '', Unassigned, pClienteModel.uf_entrega.UF_ENTREGA);
  pQry.ParamByName('cep_entrega').Value    				:= ifThen(pClienteModel.CEP_ENTREGA							= '', Unassigned, pClienteModel.cep_entrega.CEP_ENTREGA);
  pQry.ParamByName('status_carta').Value    				:= ifThen(pClienteModel.STATUS_CARTA						= '', Unassigned, pClienteModel.status_carta.STATUS_CARTA);
  pQry.ParamByName('email_cobranca').Value    			:= ifThen(pClienteModel.EMAIL_COBRANCA						= '', Unassigned, pClienteModel.email_cobranca.EMAIL_COBRANCA);
  pQry.ParamByName('contato_cobranca').Value    			:= ifThen(pClienteModel.CONTATO_COBRANCA					= '', Unassigned, pClienteModel.contato_cobranca.CONTATO_COBRANCA);
  pQry.ParamByName('telefone_cobranca').Value    			:= ifThen(pClienteModel.TELEFONE_COBRANCA					= '', Unassigned, pClienteModel.telefone_cobranca.TELEFONE_COBRANCA);
  pQry.ParamByName('celular_cobrnaca').Value    			:= ifThen(pClienteModel.CELULAR_COBRNACA					= '', Unassigned, pClienteModel.celular_cobrnaca.CELULAR_COBRNACA);
  pQry.ParamByName('observacao_cobranca').Value    		:= ifThen(pClienteModel.OBSERVACAO_COBRANCA					= '', Unassigned, pClienteModel.observacao_cobranca.OBSERVACAO_COBRANCA);
  pQry.ParamByName('complemento_cobranca').Value    		:= ifThen(pClienteModel.COMPLEMENTO_COBRANCA				= '', Unassigned, pClienteModel.complemento_cobranca.COMPLEMENTO_COBRANCA);
  pQry.ParamByName('observacao_nfe').Value    			:= ifThen(pClienteModel.OBSERVACAO_NFE						= '', Unassigned, pClienteModel.observacao_nfe.OBSERVACAO_NFE);
  pQry.ParamByName('desconto_nf').Value    				:= ifThen(pClienteModel.DESCONTO_NF							= '', Unassigned, pClienteModel.desconto_nf.DESCONTO_NF);
  pQry.ParamByName('obs_geral').Value    					:= ifThen(pClienteModel.OBS_GERAL							= '', Unassigned, pClienteModel.obs_geral.OBS_GERAL);
  pQry.ParamByName('systime').Value    					:= ifThen(pClienteModel.SYSTIME								= '', Unassigned, pClienteModel.systime.SYSTIME);
  pQry.ParamByName('tela').Value    						:= ifThen(pClienteModel.TELA								= '', Unassigned, pClienteModel.tela.TELA);
  pQry.ParamByName('limite_sms').Value    				:= ifThen(pClienteModel.LIMITE_SMS							= '', Unassigned, pClienteModel.limite_sms.LIMITE_SMS);
  pQry.ParamByName('telefone_pai').Value    				:= ifThen(pClienteModel.TELEFONE_PAI						= '', Unassigned, pClienteModel.telefone_pai.TELEFONE_PAI);
  pQry.ParamByName('telefone_mae').Value    				:= ifThen(pClienteModel.TELEFONE_MAE						= '', Unassigned, pClienteModel.telefone_mae.TELEFONE_MAE);
  pQry.ParamByName('telefone_conjuge').Value    			:= ifThen(pClienteModel.TELEFONE_CONJUGE					= '', Unassigned, pClienteModel.telefone_conjuge.TELEFONE_CONJUGE);
  pQry.ParamByName('multa').Value    						:= ifThen(pClienteModel.MULTA								= '', Unassigned, pClienteModel.multa.MULTA);
  pQry.ParamByName('juros_bol').Value    					:= ifThen(pClienteModel.JUROS_BOL							= '', Unassigned, pClienteModel.juros_bol.JUROS_BOL);
  pQry.ParamByName('indice_juros_id').Value    			:= ifThen(pClienteModel.INDICE_JUROS_ID						= '', Unassigned, pClienteModel.indice_juros_id.INDICE_JUROS_ID);
  pQry.ParamByName('ctb').Value    						:= ifThen(pClienteModel.CTB									= '', Unassigned, pClienteModel.ctb.CTB);
  pQry.ParamByName('banco_id').Value    					:= ifThen(pClienteModel.BANCO_ID							= '', Unassigned, pClienteModel.banco_id.BANCO_ID);
  pQry.ParamByName('instrucao_boleto').Value    			:= ifThen(pClienteModel.INSTRUCAO_BOLETO					= '', Unassigned, pClienteModel.instrucao_boleto.INSTRUCAO_BOLETO);
  pQry.ParamByName('dependente4').Value    				:= ifThen(pClienteModel.DEPENDENTE4							= '', Unassigned, pClienteModel.dependente4.DEPENDENTE4);
  pQry.ParamByName('nascimento_dependente4').Value    	:= ifThen(pClienteModel.NASCIMENTO_DEPENDENTE4				= '', Unassigned, pClienteModel.nascimento_dependente4.NASCIMENTO_DEPENDENTE4);
  pQry.ParamByName('sexo_dependente4').Value    			:= ifThen(pClienteModel.SEXO_DEPENDENTE4					= '', Unassigned, pClienteModel.sexo_dependente4.SEXO_DEPENDENTE4);
  pQry.ParamByName('dependente5').Value    				:= ifThen(pClienteModel.DEPENDENTE5							= '', Unassigned, pClienteModel.dependente5.DEPENDENTE5);
  pQry.ParamByName('nascimento_dependente5').Value    	:= ifThen(pClienteModel.NASCIMENTO_DEPENDENTE5				= '', Unassigned, pClienteModel.nascimento_dependente5.NASCIMENTO_DEPENDENTE5);
  pQry.ParamByName('sexo_dependente5').Value    			:= ifThen(pClienteModel.SEXO_DEPENDENTE5					= '', Unassigned, pClienteModel.sexo_dependente5.SEXO_DEPENDENTE5);
  pQry.ParamByName('dependente6').Value    				:= ifThen(pClienteModel.DEPENDENTE6							= '', Unassigned, pClienteModel.dependente6.DEPENDENTE6);
  pQry.ParamByName('nascimento_dependente6').Value    	:= ifThen(pClienteModel.NASCIMENTO_DEPENDENTE6				= '', Unassigned, pClienteModel.nascimento_dependente6.NASCIMENTO_DEPENDENTE6);
  pQry.ParamByName('sexo_dependente6').Value    			:= ifThen(pClienteModel.SEXO_DEPENDENTE6					= '', Unassigned, pClienteModel.sexo_dependente6.SEXO_DEPENDENTE6);
  pQry.ParamByName('isento_st').Value    					:= ifThen(pClienteModel.ISENTO_ST							= '', Unassigned, pClienteModel.isento_st.ISENTO_ST);
  pQry.ParamByName('frete').Value    						:= ifThen(pClienteModel.FRETE								= '', Unassigned, pClienteModel.frete.FRETE);
  pQry.ParamByName('prospeccao_id').Value    				:= ifThen(pClienteModel.PROSPECCAO_ID						= '', Unassigned, pClienteModel.prospeccao_id.PROSPECCAO_ID);
  pQry.ParamByName('desc_financeiro').Value    			:= ifThen(pClienteModel.DESC_FINANCEIRO						= '', Unassigned, pClienteModel.desc_financeiro.DESC_FINANCEIRO);
  pQry.ParamByName('imagem').Value    					:= ifThen(pClienteModel.IMAGEM								= '', Unassigned, pClienteModel.imagem.IMAGEM);
  pQry.ParamByName('pratica_esporte').Value    			:= ifThen(pClienteModel.PRATICA_ESPORTE						= '', Unassigned, pClienteModel.pratica_esporte.PRATICA_ESPORTE);
  pQry.ParamByName('frequencia').Value    				:= ifThen(pClienteModel.FREQUENCIA							= '', Unassigned, pClienteModel.frequencia.FREQUENCIA);
  pQry.ParamByName('destro_canhoto').Value    			:= ifThen(pClienteModel.DESTRO_CANHOTO						= '', Unassigned, pClienteModel.destro_canhoto.DESTRO_CANHOTO);
  pQry.ParamByName('numero_calcado').Value    			:= ifThen(pClienteModel.NUMERO_CALCADO						= '', Unassigned, pClienteModel.numero_calcado.NUMERO_CALCADO);
  pQry.ParamByName('calcado_mais_usado').Value    		:= ifThen(pClienteModel.CALCADO_MAIS_USADO					= '', Unassigned, pClienteModel.calcado_mais_usado.CALCADO_MAIS_USADO);
  pQry.ParamByName('material').Value    					:= ifThen(pClienteModel.MATERIAL							= '', Unassigned, pClienteModel.material.MATERIAL);
  pQry.ParamByName('cirurgia_mmii').Value    				:= ifThen(pClienteModel.CIRURGIA_MMII						= '', Unassigned, pClienteModel.cirurgia_mmii.CIRURGIA_MMII);
  pQry.ParamByName('tratamento_medicamento').Value    	:= ifThen(pClienteModel.TRATAMENTO_MEDICAMENTO				= '', Unassigned, pClienteModel.tratamento_medicamento.TRATAMENTO_MEDICAMENTO);
  pQry.ParamByName('alergico').Value    					:= ifThen(pClienteModel.ALERGICO							= '', Unassigned, pClienteModel.alergico.ALERGICO);
  pQry.ParamByName('alergico_obs').Value    				:= ifThen(pClienteModel.ALERGICO_OBS						= '', Unassigned, pClienteModel.alergico_obs.ALERGICO_OBS);
  pQry.ParamByName('patologia').Value    					:= ifThen(pClienteModel.PATOLOGIA							= '', Unassigned, pClienteModel.patologia.PATOLOGIA);
  pQry.ParamByName('patologia_obs').Value    				:= ifThen(pClienteModel.PATOLOGIA_OBS						= '', Unassigned, pClienteModel.patologia_obs.PATOLOGIA_OBS);
  pQry.ParamByName('diabetes').Value    					:= ifThen(pClienteModel.DIABETES							= '', Unassigned, pClienteModel.diabetes.DIABETES);
  pQry.ParamByName('diabetes_familiares').Value    		:= ifThen(pClienteModel.DIABETES_FAMILIARES					= '', Unassigned, pClienteModel.diabetes_familiares.DIABETES_FAMILIARES);
  pQry.ParamByName('etilista').Value    					:= ifThen(pClienteModel.ETILISTA							= '', Unassigned, pClienteModel.etilista.ETILISTA);
  pQry.ParamByName('cardiopatias').Value    				:= ifThen(pClienteModel.CARDIOPATIAS						= '', Unassigned, pClienteModel.cardiopatias.CARDIOPATIAS);
  pQry.ParamByName('tabagismo').Value    					:= ifThen(pClienteModel.TABAGISMO							= '', Unassigned, pClienteModel.tabagismo.TABAGISMO);
  pQry.ParamByName('dst').Value    						:= ifThen(pClienteModel.DST									= '', Unassigned, pClienteModel.dst.DST);
  pQry.ParamByName('pressao').Value    					:= ifThen(pClienteModel.PRESSAO								= '', Unassigned, pClienteModel.pressao.PRESSAO);
  pQry.ParamByName('gravidez').Value    					:= ifThen(pClienteModel.GRAVIDEZ							= '', Unassigned, pClienteModel.gravidez.GRAVIDEZ);
  pQry.ParamByName('outras_patologias').Value    			:= ifThen(pClienteModel.OUTRAS_PATOLOGIAS					= '', Unassigned, pClienteModel.outras_patologias.OUTRAS_PATOLOGIAS);
  pQry.ParamByName('motivo_visita').Value    				:= ifThen(pClienteModel.MOTIVO_VISITA						= '', Unassigned, pClienteModel.motivo_visita.MOTIVO_VISITA);
  pQry.ParamByName('formato_unha').Value    				:= ifThen(pClienteModel.FORMATO_UNHA						= '', Unassigned, pClienteModel.formato_unha.FORMATO_UNHA);
  pQry.ParamByName('onicotrofia').Value    				:= ifThen(pClienteModel.ONICOTROFIA							= '', Unassigned, pClienteModel.onicotrofia.ONICOTROFIA);
  pQry.ParamByName('onicorrexe').Value    				:= ifThen(pClienteModel.ONICORREXE							= '', Unassigned, pClienteModel.onicorrexe.ONICORREXE);
  pQry.ParamByName('onicogrifose').Value    				:= ifThen(pClienteModel.ONICOGRIFOSE						= '', Unassigned, pClienteModel.onicogrifose.ONICOGRIFOSE);
  pQry.ParamByName('onicolise').Value    					:= ifThen(pClienteModel.ONICOLISE							= '', Unassigned, pClienteModel.onicolise.ONICOLISE);
  pQry.ParamByName('onicomicose').Value    				:= ifThen(pClienteModel.ONICOMICOSE							= '', Unassigned, pClienteModel.onicomicose.ONICOMICOSE);
  pQry.ParamByName('psoriase').Value    					:= ifThen(pClienteModel.PSORIASE							= '', Unassigned, pClienteModel.psoriase.PSORIASE);
  pQry.ParamByName('onicocriptose').Value    				:= ifThen(pClienteModel.ONICOCRIPTOSE						= '', Unassigned, pClienteModel.onicocriptose.ONICOCRIPTOSE);
  pQry.ParamByName('granulada').Value    					:= ifThen(pClienteModel.GRANULADA							= '', Unassigned, pClienteModel.granulada.GRANULADA);
  pQry.ParamByName('alteracao_cor').Value    				:= ifThen(pClienteModel.ALTERACAO_COR						= '', Unassigned, pClienteModel.alteracao_cor.ALTERACAO_COR);
  pQry.ParamByName('onicofose').Value    					:= ifThen(pClienteModel.ONICOFOSE							= '', Unassigned, pClienteModel.onicofose.ONICOFOSE);
  pQry.ParamByName('exostose_subungueal').Value    		:= ifThen(pClienteModel.EXOSTOSE_SUBUNGUEAL					= '', Unassigned, pClienteModel.exostose_subungueal.EXOSTOSE_SUBUNGUEAL);
  pQry.ParamByName('ungueal').Value    					:= ifThen(pClienteModel.UNGUEAL								= '', Unassigned, pClienteModel.ungueal.UNGUEAL);
  pQry.ParamByName('outras_alteracao_laminas').Value    	:= ifThen(pClienteModel.OUTRAS_ALTERACAO_LAMINAS			= '', Unassigned, pClienteModel.outras_alteracao_laminas.OUTRAS_ALTERACAO_LAMINAS);
  pQry.ParamByName('bromidrose').Value    				:= ifThen(pClienteModel.BROMIDROSE							= '', Unassigned, pClienteModel.bromidrose.BROMIDROSE);
  pQry.ParamByName('anidrose').Value    					:= ifThen(pClienteModel.ANIDROSE							= '', Unassigned, pClienteModel.anidrose.ANIDROSE);
  pQry.ParamByName('hiperhidrose').Value    				:= ifThen(pClienteModel.HIPERHIDROSE						= '', Unassigned, pClienteModel.hiperhidrose.HIPERHIDROSE);
  pQry.ParamByName('isquemica').Value    					:= ifThen(pClienteModel.ISQUEMICA							= '', Unassigned, pClienteModel.isquemica.ISQUEMICA);
  pQry.ParamByName('frieira').Value    					:= ifThen(pClienteModel.FRIEIRA								= '', Unassigned, pClienteModel.frieira.FRIEIRA);
  pQry.ParamByName('tinea_pedis').Value    				:= ifThen(pClienteModel.TINEA_PEDIS							= '', Unassigned, pClienteModel.tinea_pedis.TINEA_PEDIS);
  pQry.ParamByName('neuropatica').Value    				:= ifThen(pClienteModel.NEUROPATICA							= '', Unassigned, pClienteModel.neuropatica.NEUROPATICA);
  pQry.ParamByName('fissuras').Value    					:= ifThen(pClienteModel.FISSURAS							= '', Unassigned, pClienteModel.fissuras.FISSURAS);
  pQry.ParamByName('disidrose').Value    					:= ifThen(pClienteModel.DISIDROSE							= '', Unassigned, pClienteModel.disidrose.DISIDROSE);
  pQry.ParamByName('mal_perfurante').Value    			:= ifThen(pClienteModel.MAL_PERFURANTE						= '', Unassigned, pClienteModel.mal_perfurante.MAL_PERFURANTE);
  pQry.ParamByName('psoriase_pe').Value    				:= ifThen(pClienteModel.PSORIASE_PE							= '', Unassigned, pClienteModel.psoriase_pe.PSORIASE_PE);
  pQry.ParamByName('alteracao_pele').Value    			:= ifThen(pClienteModel.ALTERACAO_PELE						= '', Unassigned, pClienteModel.alteracao_pele.ALTERACAO_PELE);
  pQry.ParamByName('halux_valgus').Value    				:= ifThen(pClienteModel.HALUX_VALGUS						= '', Unassigned, pClienteModel.halux_valgus.HALUX_VALGUS);
  pQry.ParamByName('halux_rigidus').Value    				:= ifThen(pClienteModel.HALUX_RIGIDUS						= '', Unassigned, pClienteModel.halux_rigidus.HALUX_RIGIDUS);
  pQry.ParamByName('esporao_calcaneo').Value    			:= ifThen(pClienteModel.ESPORAO_CALCANEO					= '', Unassigned, pClienteModel.esporao_calcaneo.ESPORAO_CALCANEO);
  pQry.ParamByName('pe_cavo').Value    					:= ifThen(pClienteModel.PE_CAVO								= '', Unassigned, pClienteModel.pe_cavo.PE_CAVO);
  pQry.ParamByName('pe_plano').Value    					:= ifThen(pClienteModel.PE_PLANO							= '', Unassigned, pClienteModel.pe_plano.PE_PLANO);
  pQry.ParamByName('dedos_garra').Value    				:= ifThen(pClienteModel.DEDOS_GARRA							= '', Unassigned, pClienteModel.dedos_garra.DEDOS_GARRA);
  pQry.ParamByName('podactilia').Value    				:= ifThen(pClienteModel.PODACTILIA							= '', Unassigned, pClienteModel.podactilia.PODACTILIA);
  pQry.ParamByName('alteracao_ortopedicas').Value    		:= ifThen(pClienteModel.ALTERACAO_ORTOPEDICAS				= '', Unassigned, pClienteModel.alteracao_ortopedicas.ALTERACAO_ORTOPEDICAS);
  pQry.ParamByName('indicacao').Value    					:= ifThen(pClienteModel.INDICACAO							= '', Unassigned, pClienteModel.indicacao.INDICACAO);
  pQry.ParamByName('monofilamento').Value    				:= ifThen(pClienteModel.MONOFILAMENTO						= '', Unassigned, pClienteModel.monofilamento.MONOFILAMENTO);
  pQry.ParamByName('diapasao').Value    					:= ifThen(pClienteModel.DIAPASAO							= '', Unassigned, pClienteModel.diapasao.DIAPASAO);
  pQry.ParamByName('digitapressao').Value    				:= ifThen(pClienteModel.DIGITAPRESSAO						= '', Unassigned, pClienteModel.digitapressao.DIGITAPRESSAO);
  pQry.ParamByName('pulsos').Value    					:= ifThen(pClienteModel.PULSOS								= '', Unassigned, pClienteModel.pulsos.PULSOS);
  pQry.ParamByName('perfusao_d').Value    				:= ifThen(pClienteModel.PERFUSAO_D							= '', Unassigned, pClienteModel.perfusao_d.PERFUSAO_D);
  pQry.ParamByName('perfusao_e').Value    				:= ifThen(pClienteModel.PERFUSAO_E							= '', Unassigned, pClienteModel.perfusao_e.PERFUSAO_E);
  pQry.ParamByName('usa_nfe').Value    					:= ifThen(pClienteModel.USA_NFE								= '', Unassigned, pClienteModel.usa_nfe.USA_NFE);
  pQry.ParamByName('usa_nfce').Value    					:= ifThen(pClienteModel.USA_NFCE							= '', Unassigned, pClienteModel.usa_nfce.USA_NFCE);
  pQry.ParamByName('usa_mdfe').Value    					:= ifThen(pClienteModel.USA_MDFE							= '', Unassigned, pClienteModel.usa_mdfe.USA_MDFE);
  pQry.ParamByName('usa_cte').Value    					:= ifThen(pClienteModel.USA_CTE								= '', Unassigned, pClienteModel.usa_cte.USA_CTE);
  pQry.ParamByName('usa_nfse').Value    					:= ifThen(pClienteModel.USA_NFSE							= '', Unassigned, pClienteModel.usa_nfse.USA_NFSE);
  pQry.ParamByName('usar_controle_kg').Value    			:= ifThen(pClienteModel.USAR_CONTROLE_KG					= '', Unassigned, pClienteModel.usar_controle_kg.USAR_CONTROLE_KG);
  pQry.ParamByName('complemento_entrega').Value    		:= ifThen(pClienteModel.COMPLEMENTO_ENTREGA					= '', Unassigned, pClienteModel.complemento_entrega.COMPLEMENTO_ENTREGA);
  pQry.ParamByName('numero_entrega').Value    			:= ifThen(pClienteModel.NUMERO_ENTREGA						= '', Unassigned, pClienteModel.numero_entrega.NUMERO_ENTREGA);
  pQry.ParamByName('cod_municipio_entrega').Value    		:= ifThen(pClienteModel.COD_MUNICIPIO_ENTREGA				= '', Unassigned, pClienteModel.cod_municipio_entrega.COD_MUNICIPIO_ENTREGA);
  pQry.ParamByName('ex_codigo_postal').Value    			:= ifThen(pClienteModel.EX_CODIGO_POSTAL					= '', Unassigned, pClienteModel.ex_codigo_postal.EX_CODIGO_POSTAL);
  pQry.ParamByName('ex_estado').Value    					:= ifThen(pClienteModel.EX_ESTADO							= '', Unassigned, pClienteModel.ex_estado.EX_ESTADO);
  pQry.ParamByName('parcela_maxima').Value    			:= ifThen(pClienteModel.PARCELA_MAXIMA						= '', Unassigned, pClienteModel.parcela_maxima.PARCELA_MAXIMA);
  pQry.ParamByName('transportadora_id').Value    			:= ifThen(pClienteModel.TRANSPORTADORA_ID					= '', Unassigned, pClienteModel.transportadora_id.TRANSPORTADORA_ID);
  pQry.ParamByName('comissao').Value    					:= ifThen(pClienteModel.COMISSAO							= '', Unassigned, pClienteModel.comissao.COMISSAO);
  pQry.ParamByName('dia_vencimento').Value    			:= ifThen(pClienteModel.DIA_VENCIMENTO						= '', Unassigned, pClienteModel.dia_vencimento.DIA_VENCIMENTO);
  pQry.ParamByName('listar_rad').Value    				:= ifThen(pClienteModel.LISTAR_RAD							= '', Unassigned, pClienteModel.listar_rad.LISTAR_RAD);
  pQry.ParamByName('contador_id').Value    				:= ifThen(pClienteModel.CONTADOR_ID							= '', Unassigned, pClienteModel.contador_id.CONTADOR_ID);
  pQry.ParamByName('vaucher').Value    					:= ifThen(pClienteModel.VAUCHER								= '', Unassigned, pClienteModel.vaucher.VAUCHER);
  pQry.ParamByName('matriz_cliente_id').Value    			:= ifThen(pClienteModel.MATRIZ_CLIENTE_ID					= '', Unassigned, pClienteModel.matriz_cliente_id.MATRIZ_CLIENTE_ID);
  pQry.ParamByName('inscricao_municipal').Value    		:= ifThen(pClienteModel.INSCRICAO_MUNICIPAL					= '', Unassigned, pClienteModel.inscricao_municipal.INSCRICAO_MUNICIPAL);
  pQry.ParamByName('envia_sms').Value    					:= ifThen(pClienteModel.ENVIA_SMS							= '', Unassigned, pClienteModel.envia_sms.ENVIA_SMS);
  pQry.ParamByName('valor_aluguel').Value    				:= ifThen(pClienteModel.VALOR_ALUGUEL						= '', Unassigned, pClienteModel.valor_aluguel.VALOR_ALUGUEL);
  pQry.ParamByName('tempo_residencia').Value    			:= ifThen(pClienteModel.TEMPO_RESIDENCIA					= '', Unassigned, pClienteModel.tempo_residencia.TEMPO_RESIDENCIA);
  pQry.ParamByName('tipo_residencia').Value    			:= ifThen(pClienteModel.TIPO_RESIDENCIA						= '', Unassigned, pClienteModel.tipo_residencia.TIPO_RESIDENCIA);
  pQry.ParamByName('parentesco_ref1').Value    			:= ifThen(pClienteModel.PARENTESCO_REF1						= '', Unassigned, pClienteModel.parentesco_ref1.PARENTESCO_REF1);
  pQry.ParamByName('parentesco_ref2').Value    			:= ifThen(pClienteModel.PARENTESCO_REF2						= '', Unassigned, pClienteModel.parentesco_ref2.PARENTESCO_REF2);
  pQry.ParamByName('trabalho_admissao').Value    			:= ifThen(pClienteModel.TRABALHO_ADMISSAO					= '', Unassigned, pClienteModel.trabalho_admissao.TRABALHO_ADMISSAO);
  pQry.ParamByName('trabalho_anterior_admissao').Value    := ifThen(pClienteModel.TRABALHO_ANTERIOR_ADMISSAO			= '', Unassigned, pClienteModel.trabalho_anterior_admissao.TRABALHO_ANTERIOR_ADMISSAO);
  pQry.ParamByName('nome_trabalho_anterior').Value    	:= ifThen(pClienteModel.NOME_TRABALHO_ANTERIOR				= '', Unassigned, pClienteModel.nome_trabalho_anterior.NOME_TRABALHO_ANTERIOR);
  pQry.ParamByName('telefone_trabalho_anterior').Value    := ifThen(pClienteModel.TELEFONE_TRABALHO_ANTERIOR			= '', Unassigned, pClienteModel.telefone_trabalho_anterior.TELEFONE_TRABALHO_ANTERIOR);
  pQry.ParamByName('funcao_trabalho_anterior').Value    	:= ifThen(pClienteModel.FUNCAO_TRABALHO_ANTERIOR			= '', Unassigned, pClienteModel.funcao_trabalho_anterior.FUNCAO_TRABALHO_ANTERIOR);
  pQry.ParamByName('renda_trabalho_anterior').Value    	:= ifThen(pClienteModel.RENDA_TRABALHO_ANTERIOR				= '', Unassigned, pClienteModel.renda_trabalho_anterior.RENDA_TRABALHO_ANTERIOR);
  pQry.ParamByName('regime_trabalho').Value    			:= ifThen(pClienteModel.REGIME_TRABALHO						= '', Unassigned, pClienteModel.regime_trabalho.REGIME_TRABALHO);
  pQry.ParamByName('confirm_endereco').Value    			:= ifThen(pClienteModel.CONFIRM_ENDERECO					= '', Unassigned, pClienteModel.confirm_endereco.CONFIRM_ENDERECO);
  pQry.ParamByName('confirm_endereco_anterior').Value    	:= ifThen(pClienteModel.CONFIRM_ENDERECO_ANTERIOR			= '', Unassigned, pClienteModel.confirm_endereco_anterior.CONFIRM_ENDERECO_ANTERIOR);
  pQry.ParamByName('confirm_trabalho').Value    			:= ifThen(pClienteModel.CONFIRM_TRABALHO					= '', Unassigned, pClienteModel.confirm_trabalho.CONFIRM_TRABALHO);
  pQry.ParamByName('confirm_trabalho_conjuge').Value    	:= ifThen(pClienteModel.CONFIRM_TRABALHO_CONJUGE			= '', Unassigned, pClienteModel.confirm_trabalho_conjuge.CONFIRM_TRABALHO_CONJUGE);
  pQry.ParamByName('desconto_bol').Value    				:= ifThen(pClienteModel.DESCONTO_BOL						= '', Unassigned, pClienteModel.desconto_bol.DESCONTO_BOL);
  pQry.ParamByName('produto_tipo_id').Value    			:= ifThen(pClienteModel.PRODUTO_TIPO_ID						= '', Unassigned, pClienteModel.produto_tipo_id.PRODUTO_TIPO_ID);
  pQry.ParamByName('pedido_minimo').Value    				:= ifThen(pClienteModel.PEDIDO_MINIMO						= '', Unassigned, pClienteModel.pedido_minimo.PEDIDO_MINIMO);
  pQry.ParamByName('reducao_icms').Value    				:= ifThen(pClienteModel.REDUCAO_ICMS						= '', Unassigned, pClienteModel.reducao_icms.REDUCAO_ICMS);
  pQry.ParamByName('abatimento_bol').Value    			:= ifThen(pClienteModel.ABATIMENTO_BOL						= '', Unassigned, pClienteModel.abatimento_bol.ABATIMENTO_BOL);
  pQry.ParamByName('usar_desconto_produto').Value    		:= ifThen(pClienteModel.USAR_DESCONTO_PRODUTO				= '', Unassigned, pClienteModel.usar_desconto_produto.USAR_DESCONTO_PRODUTO);
  pQry.ParamByName('codigo_anterior').Value    			:= ifThen(pClienteModel.CODIGO_ANTERIOR						= '', Unassigned, pClienteModel.codigo_anterior.CODIGO_ANTERIOR);
  pQry.ParamByName('senha').Value    						:= ifThen(pClienteModel.SENHA								= '', Unassigned, pClienteModel.senha.SENHA);
  pQry.ParamByName('ocupacao_id').Value    				:= ifThen(pClienteModel.OCUPACAO_ID							= '', Unassigned, pClienteModel.ocupacao_id.OCUPACAO_ID);
  pQry.ParamByName('sub_atividade_id').Value    			:= ifThen(pClienteModel.SUB_ATIVIDADE_ID					= '', Unassigned, pClienteModel.sub_atividade_id.SUB_ATIVIDADE_ID);
  pQry.ParamByName('zemopay').Value    					:= ifThen(pClienteModel.ZEMOPAY								= '', Unassigned, pClienteModel.zemopay.ZEMOPAY);
  pQry.ParamByName('zemopay_taxa_id').Value    			:= ifThen(pClienteModel.ZEMOPAY_TAXA_ID						= '', Unassigned, pClienteModel.zemopay_taxa_id.ZEMOPAY_TAXA_ID);
  pQry.ParamByName('zemopay_id').Value    				:= ifThen(pClienteModel.ZEMOPAY_ID							= '', Unassigned, pClienteModel.zemopay_id.ZEMOPAY_ID);
  pQry.ParamByName('zemopay_banco_id').Value    			:= ifThen(pClienteModel.ZEMOPAY_BANCO_ID					= '', Unassigned, pClienteModel.zemopay_banco_id.ZEMOPAY_BANCO_ID);
  pQry.ParamByName('data_inatividade').Value    			:= ifThen(pClienteModel.DATA_INATIVIDADE					= '', Unassigned, pClienteModel.data_inatividade.DATA_INATIVIDADE);
  pQry.ParamByName('importacao_dados').Value    			:= ifThen(pClienteModel.IMPORTACAO_DADOS					= '', Unassigned, pClienteModel.importacao_dados.IMPORTACAO_DADOS);
  pQry.ParamByName('observacao_implantacao').Value    	:= ifThen(pClienteModel.OBSERVACAO_IMPLANTACAO				= '', Unassigned, pClienteModel.observacao_implantacao.OBSERVACAO_IMPLANTACAO);
  pQry.ParamByName('status_implantacao').Value    		:= ifThen(pClienteModel.STATUS_IMPLANTACAO					= '', Unassigned, pClienteModel.status_implantacao.STATUS_IMPLANTACAO);
  pQry.ParamByName('nao_contribuinte').Value    			:= ifThen(pClienteModel.NAO_CONTRIBUINTE					= '', Unassigned, pClienteModel.nao_contribuinte.NAO_CONTRIBUINTE);
  pQry.ParamByName('grupo_economico_id').Value    		:= ifThen(pClienteModel.GRUPO_ECONOMICO_ID					= '', Unassigned, pClienteModel.grupo_economico_id.GRUPO_ECONOMICO_ID);
  pQry.ParamByName('aceite_bol').Value    				:= ifThen(pClienteModel.ACEITE_BOL							= '', Unassigned, pClienteModel.aceite_bol.ACEITE_BOL);
  pQry.ParamByName('bloquear_alteracao_tabela').Value    	:= ifThen(pClienteModel.BLOQUEAR_ALTERACAO_TABELA			= '', Unassigned, pClienteModel.bloquear_alteracao_tabela.BLOQUEAR_ALTERACAO_TABELA);
  pQry.ParamByName('tipo_emissao_nfe').Value    			:= ifThen(pClienteModel.TIPO_EMISSAO_NFE					= '', Unassigned, pClienteModel.tipo_emissao_nfe.TIPO_EMISSAO_NFE);
  pQry.ParamByName('percentual_desconto').Value    		:= ifThen(pClienteModel.PERCENTUAL_DESCONTO					= '', Unassigned, pClienteModel.percentual_desconto.PERCENTUAL_DESCONTO);
  pQry.ParamByName('sacador_avalista_id').Value    		:= ifThen(pClienteModel.SACADOR_AVALISTA_ID					= '', Unassigned, pClienteModel.sacador_avalista_id.SACADOR_AVALISTA_ID);
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

function TClienteDao.ufCliente(pId: String): Variant;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select UF_CLI from CLIENTES where CODIGO_CLI = '+ QuotedStr(pId));
end;

end.
