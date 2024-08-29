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
  Terasoft.Framework.ObjectIface,
  Interfaces.QueryLojaAsync,
  Interfaces.Conexao;

type
  TClienteDao = class;
  ITClienteDao=IObject<TClienteDao>;

  TClienteDao = class
  private
    [weak] mySelf: ITClienteDao;
    vIConexao : Iconexao;
    vConstrutor : IConstrutorDao;

    FClientesLista: IList<ITClienteModel>;
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
    procedure SetClientesLista(const Value: IList<ITClienteModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);
    procedure setParams(pQry: TFDQuery; pClienteModel: ITClienteModel);

  public
    const
      NomeTabela = 'CLIENTES';

    constructor _Create(pIConexao : Iconexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITClienteDao;

    property ClientesLista: IList<ITClienteModel> read FClientesLista write SetClientesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pClienteModel: ITClienteModel): String;
    function alterar(pClienteModel: ITClienteModel): String;
    function excluir(pClienteModel: ITClienteModel): String;

    function sincronizarDados(pClienteModel: ITClienteModel): String;

    procedure obterLista;

    function where: String;
    function carregaClasse(pId: String): ITClienteModel;
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

function TClienteDao.carregaClasse(pId: String): ITClienteModel;
var
  lQry: TFDQuery;
  lModel: ITClienteModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TClienteModel.getNewIface(vIConexao);
  Result   := lModel;
  try
    lQry.Open('select * from ' + self.NomeTabela + ' where CODIGO_CLI = '+ QuotedStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.CODIGO_CLI                  := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.objeto.FANTASIA_CLI                := lQry.FieldByName('FANTASIA_CLI').AsString;
    lModel.objeto.RAZAO_CLI                   := lQry.FieldByName('RAZAO_CLI').AsString;
    lModel.objeto.CNPJ_CPF_CLI                := lQry.FieldByName('CNPJ_CPF_CLI').AsString;
    lModel.objeto.INSCRICAO_RG_CLI            := lQry.FieldByName('INSCRICAO_RG_CLI').AsString;
    lModel.objeto.ENDERECO_CLI                := lQry.FieldByName('ENDERECO_CLI').AsString;
    lModel.objeto.ENDERECO                    := lQry.FieldByName('ENDERECO').AsString;
    lModel.objeto.BAIRRO_CLI                  := lQry.FieldByName('BAIRRO_CLI').AsString;
    lModel.objeto.CIDADE_CLI                  := lQry.FieldByName('CIDADE_CLI').AsString;
    lModel.objeto.UF_CLI                      := lQry.FieldByName('UF_CLI').AsString;
    lModel.objeto.CEP_CLI                     := lQry.FieldByName('CEP_CLI').AsString;
    lModel.objeto.TELEFONE_CLI                := lQry.FieldByName('TELEFONE_CLI').AsString;
    lModel.objeto.FAX_CLI                     := lQry.FieldByName('FAX_CLI').AsString;
    lModel.objeto.EMAIL_CLI                   := lQry.FieldByName('EMAIL_CLI').AsString;
    lModel.objeto.URL_CLI                     := lQry.FieldByName('URL_CLI').AsString;
    lModel.objeto.TIPO_CLI                    := lQry.FieldByName('TIPO_CLI').AsString;
    lModel.objeto.ATIVIDADE_CLI               := lQry.FieldByName('ATIVIDADE_CLI').AsString;
    lModel.objeto.ENDCOBRANCA_CLI             := lQry.FieldByName('ENDCOBRANCA_CLI').AsString;
    lModel.objeto.BAIRCOBRANCA_CLI            := lQry.FieldByName('BAIRCOBRANCA_CLI').AsString;
    lModel.objeto.CIDCOBRANCA_CLI             := lQry.FieldByName('CIDCOBRANCA_CLI').AsString;
    lModel.objeto.UFCOBRANCA_CLI              := lQry.FieldByName('UFCOBRANCA_CLI').AsString;
    lModel.objeto.CEPCOBRANCA_CLI             := lQry.FieldByName('CEPCOBRANCA_CLI').AsString;
    lModel.objeto.LOCALTRABALHO_CLI           := lQry.FieldByName('LOCALTRABALHO_CLI').AsString;
    lModel.objeto.ENDTRABALHO_CLI             := lQry.FieldByName('ENDTRABALHO_CLI').AsString;
    lModel.objeto.BAIRTRABALHO_CLI            := lQry.FieldByName('BAIRTRABALHO_CLI').AsString;
    lModel.objeto.CIDTRABALHO_CLI             := lQry.FieldByName('CIDTRABALHO_CLI').AsString;
    lModel.objeto.UFTRABALHO_CLI              := lQry.FieldByName('UFTRABALHO_CLI').AsString;
    lModel.objeto.CEPTRABALHO_CLI             := lQry.FieldByName('CEPTRABALHO_CLI').AsString;
    lModel.objeto.FONETRABALHO_CLI            := lQry.FieldByName('FONETRABALHO_CLI').AsString;
    lModel.objeto.FUNCAOTRABALHO_CLI          := lQry.FieldByName('FUNCAOTRABALHO_CLI').AsString;
    lModel.objeto.REFERENCIA2_CLI             := lQry.FieldByName('REFERENCIA2_CLI').AsString;
    lModel.objeto.FONEREF2_CLI                := lQry.FieldByName('FONEREF2_CLI').AsString;
    lModel.objeto.REFERENCIA3_CLI             := lQry.FieldByName('REFERENCIA3_CLI').AsString;
    lModel.objeto.FONEREF3_CLI                := lQry.FieldByName('FONEREF3_CLI').AsString;
    lModel.objeto.SEPROCADO_CLI               := lQry.FieldByName('SEPROCADO_CLI').AsString;
    lModel.objeto.REFERENCIA1_CLI             := lQry.FieldByName('REFERENCIA1_CLI').AsString;
    lModel.objeto.FONEREF1_CLI                := lQry.FieldByName('FONEREF1_CLI').AsString;
    lModel.objeto.CADASTRO_CLI                := lQry.FieldByName('CADASTRO_CLI').AsString;
    lModel.objeto.NASCIMENTO_CLI              := lQry.FieldByName('NASCIMENTO_CLI').AsString;
    lModel.objeto.CELULAR_CLI                 := lQry.FieldByName('CELULAR_CLI').AsString;
    lModel.objeto.PAI_CLI                     := lQry.FieldByName('PAI_CLI').AsString;
    lModel.objeto.MAE_CLI                     := lQry.FieldByName('MAE_CLI').AsString;
    lModel.objeto.CONTATO_CLI                 := lQry.FieldByName('CONTATO_CLI').AsString;
    lModel.objeto.OBSERVACAO_CLI              := lQry.FieldByName('OBSERVACAO_CLI').AsString;
    lModel.objeto.BANCO_CLI                   := lQry.FieldByName('BANCO_CLI').AsString;
    lModel.objeto.AGENCIA_CLI                 := lQry.FieldByName('AGENCIA_CLI').AsString;
    lModel.objeto.CONTA_CLI                   := lQry.FieldByName('CONTA_CLI').AsString;
    lModel.objeto.RENDA_CLI                   := lQry.FieldByName('RENDA_CLI').AsString;
    lModel.objeto.FONEAGENCIA_CLI             := lQry.FieldByName('FONEAGENCIA_CLI').AsString;
    lModel.objeto.CONTATOAGENCIA_CLI          := lQry.FieldByName('CONTATOAGENCIA_CLI').AsString;
    lModel.objeto.CODIGO_VEN                  := lQry.FieldByName('CODIGO_VEN').AsString;
    lModel.objeto.USUARIO_CLI                 := lQry.FieldByName('USUARIO_CLI').AsString;
    lModel.objeto.ESTADOCIVIL_CLI             := lQry.FieldByName('ESTADOCIVIL_CLI').AsString;
    lModel.objeto.NOMECON_CLI                 := lQry.FieldByName('NOMECON_CLI').AsString;
    lModel.objeto.CPFCON_CLI                  := lQry.FieldByName('CPFCON_CLI').AsString;
    lModel.objeto.RGCON_CLI                   := lQry.FieldByName('RGCON_CLI').AsString;
    lModel.objeto.PROFCON_CLI                 := lQry.FieldByName('PROFCON_CLI').AsString;
    lModel.objeto.SALARIOCON_CLI              := lQry.FieldByName('SALARIOCON_CLI').AsString;
    lModel.objeto.CONVENIO_CLI                := lQry.FieldByName('CONVENIO_CLI').AsString;
    lModel.objeto.CONVENIO_COD                := lQry.FieldByName('CONVENIO_COD').AsString;
    lModel.objeto.CARTA_CLI                   := lQry.FieldByName('CARTA_CLI').AsString;
    lModel.objeto.EXPEDICAO_RG                := lQry.FieldByName('EXPEDICAO_RG').AsString;
    lModel.objeto.NATURALIDADE_CLI            := lQry.FieldByName('NATURALIDADE_CLI').AsString;
    lModel.objeto.uf_naturalidade_cli         := lQry.FieldByName('UF_NATURALIDADE_CLI').AsString;
    lModel.objeto.escolaridade_cli            := lQry.FieldByName('ESCOLARIDADE_CLI').AsString;
    lModel.objeto.TEMPO_SERVICO               := lQry.FieldByName('TEMPO_SERVICO').AsString;
    lModel.objeto.BENEFICIO_CLI               := lQry.FieldByName('BENEFICIO_CLI').AsString;
    lModel.objeto.DESCRICAO                   := lQry.FieldByName('DESCRICAO').AsString;
    lModel.objeto.REDUZIR_BASE_ICMS           := lQry.FieldByName('REDUZIR_BASE_ICMS').AsString;
    lModel.objeto.ISENTO_ICMS                 := lQry.FieldByName('ISENTO_ICMS').AsString;
    lModel.objeto.LOJA                        := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.DATA_ALTERACAO              := lQry.FieldByName('DATA_ALTERACAO').AsString;
    lModel.objeto.LIMITE_COMPRA               := lQry.FieldByName('LIMITE_COMPRA').AsString;
    lModel.objeto.TIPO_SAIDA                  := lQry.FieldByName('TIPO_SAIDA').AsString;
    lModel.objeto.COD_MUNICIPIO               := lQry.FieldByName('COD_MUNICIPIO').AsString;
    lModel.objeto.ULTIMA_COMPRA               := lQry.FieldByName('ULTIMA_COMPRA').AsString;
    lModel.objeto.STATUS                      := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.PORTADOR                    := lQry.FieldByName('PORTADOR').AsString;
    lModel.objeto.SEXO_CLI                    := lQry.FieldByName('SEXO_CLI').AsString;
    lModel.objeto.CLASSIF_CLI                 := lQry.FieldByName('CLASSIF_CLI').AsString;
    lModel.objeto.DATA_RETORNO                := lQry.FieldByName('DATA_RETORNO').AsString;
    lModel.objeto.HORA_RETORNO                := lQry.FieldByName('HORA_RETORNO').AsString;
    lModel.objeto.AVALISTA_CLI                := lQry.FieldByName('AVALISTA_CLI').AsString;
    lModel.objeto.CNPJ_CPF_AVAL_CLI           := lQry.FieldByName('CNPJ_CPF_AVAL_CLI').AsString;
    lModel.objeto.BAIRRO_AVAL_CLI             := lQry.FieldByName('BAIRRO_AVAL_CLI').AsString;
    lModel.objeto.CIDADE_AVAL_CLI             := lQry.FieldByName('CIDADE_AVAL_CLI').AsString;
    lModel.objeto.TELEFONE_AVAL_CLI           := lQry.FieldByName('TELEFONE_AVAL_CLI').AsString;
    lModel.objeto.CELULAR_AVAL_CLI            := lQry.FieldByName('CELULAR_AVAL_CLI').AsString;
    lModel.objeto.ENDERECO_AVAL_CLI           := lQry.FieldByName('ENDERECO_AVAL_CLI').AsString;
    lModel.objeto.ISENTO_IPI                  := lQry.FieldByName('ISENTO_IPI').AsString;
    lModel.objeto.REVENDEDOR                  := lQry.FieldByName('REVENDEDOR').AsString;
    lModel.objeto.CREDITO_CLI                 := lQry.FieldByName('CREDITO_CLI').AsString;
    lModel.objeto.FONE_COM_AVAL               := lQry.FieldByName('FONE_COM_AVAL').AsString;
    lModel.objeto.RG_AVAL                     := lQry.FieldByName('RG_AVAL').AsString;
    lModel.objeto.MAE_AVAL                    := lQry.FieldByName('MAE_AVAL').AsString;
    lModel.objeto.DATA_NASC_AVAL              := lQry.FieldByName('DATA_NASC_AVAL').AsString;
    lModel.objeto.UNIDADE_CONSUMIDORA_CB      := lQry.FieldByName('UNIDADE_CONSUMIDORA_CB').AsString;
    lModel.objeto.CODIGO_CONCESSIONARIA_CB    := lQry.FieldByName('CODIGO_CONCESSIONARIA_CB').AsString;
    lModel.objeto.CODIGO_VENDEDOR_CB          := lQry.FieldByName('CODIGO_VENDEDOR_CB').AsString;
    lModel.objeto.TITULAR_CONTA_CB            := lQry.FieldByName('TITULAR_CONTA_CB').AsString;
    lModel.objeto.DATA_FATURAMENTO_CB         := lQry.FieldByName('DATA_FATURAMENTO_CB').AsString;
    lModel.objeto.DATA_VENCIMENTO_CB          := lQry.FieldByName('DATA_VENCIMENTO_CB').AsString;
    lModel.objeto.CELULAR_CLI2                := lQry.FieldByName('CELULAR_CLI2').AsString;
    lModel.objeto.OPERADORA_CELULAR           := lQry.FieldByName('OPERADORA_CELULAR').AsString;
    lModel.objeto.DATA_NASC_CONJUGUE          := lQry.FieldByName('DATA_NASC_CONJUGUE').AsString;
    lModel.objeto.EMAIL2                      := lQry.FieldByName('EMAIL2').AsString;
    lModel.objeto.DESCRICAO_REPARCELAMENTO    := lQry.FieldByName('DESCRICAO_REPARCELAMENTO').AsString;
    lModel.objeto.ID                          := lQry.FieldByName('ID').AsString;
    lModel.objeto.DEPENDENTE                  := lQry.FieldByName('DEPENDENTE').AsString;
    lModel.objeto.NASCIMENTO_DEPENDENTE       := lQry.FieldByName('NASCIMENTO_DEPENDENTE').AsString;
    lModel.objeto.SEXO_DEPENDENTE             := lQry.FieldByName('SEXO_DEPENDENTE').AsString;
    lModel.objeto.DEPENDENTE2                 := lQry.FieldByName('DEPENDENTE2').AsString;
    lModel.objeto.NASCIMENTO_DEPENDENTE2      := lQry.FieldByName('NASCIMENTO_DEPENDENTE2').AsString;
    lModel.objeto.SEXO_DEPENDENTE2            := lQry.FieldByName('SEXO_DEPENDENTE2').AsString;
    lModel.objeto.DEPENDENTE3                 := lQry.FieldByName('DEPENDENTE3').AsString;
    lModel.objeto.NASCIMENTO_DEPENDENTE3      := lQry.FieldByName('NASCIMENTO_DEPENDENTE3').AsString;
    lModel.objeto.SEXO_DEPENDENTE3            := lQry.FieldByName('SEXO_DEPENDENTE3').AsString;
    lModel.objeto.OBSERVACAO_PED_ORC          := lQry.FieldByName('OBSERVACAO_PED_ORC').AsString;
    lModel.objeto.PRECO_ID                    := lQry.FieldByName('PRECO_ID').AsString;
    lModel.objeto.SUFRAMA                     := lQry.FieldByName('SUFRAMA').AsString;
    lModel.objeto.COMPLEMENTO                 := lQry.FieldByName('COMPLEMENTO').AsString;
    lModel.objeto.NUMERO_END                  := lQry.FieldByName('NUMERO_END').AsString;
    lModel.objeto.ATIVIDADE_ID                := lQry.FieldByName('ATIVIDADE_ID').AsString;
    lModel.objeto.PAIS_ID                     := lQry.FieldByName('PAIS_ID').AsString;
    lModel.objeto.REGIAO_ID                   := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.objeto.CFOP_ID                     := lQry.FieldByName('CFOP_ID').AsString;
    lModel.objeto.TIPO_SUFRAMA                := lQry.FieldByName('TIPO_SUFRAMA').AsString;
    lModel.objeto.TIPO_APURACAO               := lQry.FieldByName('TIPO_APURACAO').AsString;
    lModel.objeto.CONDICOES_PAGAMENTO         := lQry.FieldByName('CONDICOES_PAGAMENTO').AsString;
    lModel.objeto.CONSUMIDOR_FINAL            := lQry.FieldByName('CONSUMIDOR_FINAL').AsString;
    lModel.objeto.NFE                         := lQry.FieldByName('NFE').AsString;
    lModel.objeto.CARGA_TRIBUTARIA            := lQry.FieldByName('CARGA_TRIBUTARIA').AsString;
    lModel.objeto.DESCONTO_FINANCEIRO         := lQry.FieldByName('DESCONTO_FINANCEIRO').AsString;
    lModel.objeto.QUANTIDADE_TERMINAIS        := lQry.FieldByName('QUANTIDADE_TERMINAIS').AsString;
    lModel.objeto.TELEFONE_INTERNACIONAL      := lQry.FieldByName('TELEFONE_INTERNACIONAL').AsString;
    lModel.objeto.CNAE                        := lQry.FieldByName('CNAE').AsString;
    lModel.objeto.ENDERECO_ENTREGA            := lQry.FieldByName('ENDERECO_ENTREGA').AsString;
    lModel.objeto.BAIRRO_ENTREGA              := lQry.FieldByName('BAIRRO_ENTREGA').AsString;
    lModel.objeto.CIDADE_ENTREGA              := lQry.FieldByName('CIDADE_ENTREGA').AsString;
    lModel.objeto.UF_ENTREGA                  := lQry.FieldByName('UF_ENTREGA').AsString;
    lModel.objeto.CEP_ENTREGA                 := lQry.FieldByName('CEP_ENTREGA').AsString;
    lModel.objeto.STATUS_CARTA                := lQry.FieldByName('STATUS_CARTA').AsString;
    lModel.objeto.EMAIL_COBRANCA              := lQry.FieldByName('EMAIL_COBRANCA').AsString;
    lModel.objeto.CONTATO_COBRANCA            := lQry.FieldByName('CONTATO_COBRANCA').AsString;
    lModel.objeto.TELEFONE_COBRANCA           := lQry.FieldByName('TELEFONE_COBRANCA').AsString;
    lModel.objeto.CELULAR_COBRNACA            := lQry.FieldByName('CELULAR_COBRNACA').AsString;
    lModel.objeto.OBSERVACAO_COBRANCA         := lQry.FieldByName('OBSERVACAO_COBRANCA').AsString;
    lModel.objeto.COMPLEMENTO_COBRANCA        := lQry.FieldByName('COMPLEMENTO_COBRANCA').AsString;
    lModel.objeto.OBSERVACAO_NFE              := lQry.FieldByName('OBSERVACAO_NFE').AsString;
    lModel.objeto.DESCONTO_NF                 := lQry.FieldByName('DESCONTO_NF').AsString;
    lModel.objeto.OBS_GERAL                   := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.objeto.SYSTIME                     := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.TELA                        := lQry.FieldByName('TELA').AsString;
    lModel.objeto.LIMITE_SMS                  := lQry.FieldByName('LIMITE_SMS').AsString;
    lModel.objeto.TELEFONE_PAI                := lQry.FieldByName('TELEFONE_PAI').AsString;
    lModel.objeto.TELEFONE_MAE                := lQry.FieldByName('TELEFONE_MAE').AsString;
    lModel.objeto.TELEFONE_CONJUGE            := lQry.FieldByName('TELEFONE_CONJUGE').AsString;
    lModel.objeto.MULTA                       := lQry.FieldByName('MULTA').AsString;
    lModel.objeto.JUROS_BOL                   := lQry.FieldByName('JUROS_BOL').AsString;
    lModel.objeto.INDICE_JUROS_ID             := lQry.FieldByName('INDICE_JUROS_ID').AsString;
    lModel.objeto.CTB                         := lQry.FieldByName('CTB').AsString;
    lModel.objeto.BANCO_ID                    := lQry.FieldByName('BANCO_ID').AsString;
    lModel.objeto.INSTRUCAO_BOLETO            := lQry.FieldByName('INSTRUCAO_BOLETO').AsString;
    lModel.objeto.DEPENDENTE4                 := lQry.FieldByName('DEPENDENTE4').AsString;
    lModel.objeto.NASCIMENTO_DEPENDENTE4      := lQry.FieldByName('NASCIMENTO_DEPENDENTE4').AsString;
    lModel.objeto.SEXO_DEPENDENTE4            := lQry.FieldByName('SEXO_DEPENDENTE4').AsString;
    lModel.objeto.DEPENDENTE5                 := lQry.FieldByName('DEPENDENTE5').AsString;
    lModel.objeto.NASCIMENTO_DEPENDENTE5      := lQry.FieldByName('NASCIMENTO_DEPENDENTE5').AsString;
    lModel.objeto.SEXO_DEPENDENTE5            := lQry.FieldByName('SEXO_DEPENDENTE5').AsString;
    lModel.objeto.DEPENDENTE6                 := lQry.FieldByName('DEPENDENTE6').AsString;
    lModel.objeto.NASCIMENTO_DEPENDENTE6      := lQry.FieldByName('NASCIMENTO_DEPENDENTE6').AsString;
    lModel.objeto.SEXO_DEPENDENTE6            := lQry.FieldByName('SEXO_DEPENDENTE6').AsString;
    lModel.objeto.ISENTO_ST                   := lQry.FieldByName('ISENTO_ST').AsString;
    lModel.objeto.FRETE                       := lQry.FieldByName('FRETE').AsString;
    lModel.objeto.PROSPECCAO_ID               := lQry.FieldByName('PROSPECCAO_ID').AsString;
    lModel.objeto.DESC_FINANCEIRO             := lQry.FieldByName('DESC_FINANCEIRO').AsString;
    lModel.objeto.IMAGEM                      := lQry.FieldByName('IMAGEM').AsString;
    lModel.objeto.PRATICA_ESPORTE             := lQry.FieldByName('PRATICA_ESPORTE').AsString;
    lModel.objeto.FREQUENCIA                  := lQry.FieldByName('FREQUENCIA').AsString;
    lModel.objeto.DESTRO_CANHOTO              := lQry.FieldByName('DESTRO_CANHOTO').AsString;
    lModel.objeto.NUMERO_CALCADO              := lQry.FieldByName('NUMERO_CALCADO').AsString;
    lModel.objeto.CALCADO_MAIS_USADO          := lQry.FieldByName('CALCADO_MAIS_USADO').AsString;
    lModel.objeto.MATERIAL                    := lQry.FieldByName('MATERIAL').AsString;
    lModel.objeto.CIRURGIA_MMII               := lQry.FieldByName('CIRURGIA_MMII').AsString;
    lModel.objeto.TRATAMENTO_MEDICAMENTO      := lQry.FieldByName('TRATAMENTO_MEDICAMENTO').AsString;
    lModel.objeto.ALERGICO                    := lQry.FieldByName('ALERGICO').AsString;
    lModel.objeto.ALERGICO_OBS                := lQry.FieldByName('ALERGICO_OBS').AsString;
    lModel.objeto.PATOLOGIA                   := lQry.FieldByName('PATOLOGIA').AsString;
    lModel.objeto.PATOLOGIA_OBS               := lQry.FieldByName('PATOLOGIA_OBS').AsString;
    lModel.objeto.DIABETES                    := lQry.FieldByName('DIABETES').AsString;
    lModel.objeto.DIABETES_FAMILIARES         := lQry.FieldByName('DIABETES_FAMILIARES').AsString;
    lModel.objeto.ETILISTA                    := lQry.FieldByName('ETILISTA').AsString;
    lModel.objeto.CARDIOPATIAS                := lQry.FieldByName('CARDIOPATIAS').AsString;
    lModel.objeto.TABAGISMO                   := lQry.FieldByName('TABAGISMO').AsString;
    lModel.objeto.DST                         := lQry.FieldByName('DST').AsString;
    lModel.objeto.PRESSAO                     := lQry.FieldByName('PRESSAO').AsString;
    lModel.objeto.GRAVIDEZ                    := lQry.FieldByName('GRAVIDEZ').AsString;
    lModel.objeto.OUTRAS_PATOLOGIAS           := lQry.FieldByName('OUTRAS_PATOLOGIAS').AsString;
    lModel.objeto.MOTIVO_VISITA               := lQry.FieldByName('MOTIVO_VISITA').AsString;
    lModel.objeto.FORMATO_UNHA                := lQry.FieldByName('FORMATO_UNHA').AsString;
    lModel.objeto.ONICOTROFIA                 := lQry.FieldByName('ONICOTROFIA').AsString;
    lModel.objeto.ONICORREXE                  := lQry.FieldByName('ONICORREXE').AsString;
    lModel.objeto.ONICOGRIFOSE                := lQry.FieldByName('ONICOGRIFOSE').AsString;
    lModel.objeto.ONICOLISE                   := lQry.FieldByName('ONICOLISE').AsString;
    lModel.objeto.ONICOMICOSE                 := lQry.FieldByName('ONICOMICOSE').AsString;
    lModel.objeto.PSORIASE                    := lQry.FieldByName('PSORIASE').AsString;
    lModel.objeto.ONICOCRIPTOSE               := lQry.FieldByName('ONICOCRIPTOSE').AsString;
    lModel.objeto.GRANULADA                   := lQry.FieldByName('GRANULADA').AsString;
    lModel.objeto.ALTERACAO_COR               := lQry.FieldByName('ALTERACAO_COR').AsString;
    lModel.objeto.ONICOFOSE                   := lQry.FieldByName('ONICOFOSE').AsString;
    lModel.objeto.EXOSTOSE_SUBUNGUEAL         := lQry.FieldByName('EXOSTOSE_SUBUNGUEAL').AsString;
    lModel.objeto.UNGUEAL                     := lQry.FieldByName('UNGUEAL').AsString;
    lModel.objeto.OUTRAS_ALTERACAO_LAMINAS    := lQry.FieldByName('OUTRAS_ALTERACAO_LAMINAS').AsString;
    lModel.objeto.BROMIDROSE                  := lQry.FieldByName('BROMIDROSE').AsString;
    lModel.objeto.ANIDROSE                    := lQry.FieldByName('ANIDROSE').AsString;
    lModel.objeto.HIPERHIDROSE                := lQry.FieldByName('HIPERHIDROSE').AsString;
    lModel.objeto.ISQUEMICA                   := lQry.FieldByName('ISQUEMICA').AsString;
    lModel.objeto.FRIEIRA                     := lQry.FieldByName('FRIEIRA').AsString;
    lModel.objeto.TINEA_PEDIS                 := lQry.FieldByName('TINEA_PEDIS').AsString;
    lModel.objeto.NEUROPATICA                 := lQry.FieldByName('NEUROPATICA').AsString;
    lModel.objeto.FISSURAS                    := lQry.FieldByName('FISSURAS').AsString;
    lModel.objeto.DISIDROSE                   := lQry.FieldByName('DISIDROSE').AsString;
    lModel.objeto.MAL_PERFURANTE              := lQry.FieldByName('MAL_PERFURANTE').AsString;
    lModel.objeto.PSORIASE_PE                 := lQry.FieldByName('PSORIASE_PE').AsString;
    lModel.objeto.ALTERACAO_PELE              := lQry.FieldByName('ALTERACAO_PELE').AsString;
    lModel.objeto.HALUX_VALGUS                := lQry.FieldByName('HALUX_VALGUS').AsString;
    lModel.objeto.HALUX_RIGIDUS               := lQry.FieldByName('HALUX_RIGIDUS').AsString;
    lModel.objeto.ESPORAO_CALCANEO            := lQry.FieldByName('ESPORAO_CALCANEO').AsString;
    lModel.objeto.PE_CAVO                     := lQry.FieldByName('PE_CAVO').AsString;
    lModel.objeto.PE_PLANO                    := lQry.FieldByName('PE_PLANO').AsString;
    lModel.objeto.DEDOS_GARRA                 := lQry.FieldByName('DEDOS_GARRA').AsString;
    lModel.objeto.PODACTILIA                  := lQry.FieldByName('PODACTILIA').AsString;
    lModel.objeto.ALTERACAO_ORTOPEDICAS       := lQry.FieldByName('ALTERACAO_ORTOPEDICAS').AsString;
    lModel.objeto.INDICACAO                   := lQry.FieldByName('INDICACAO').AsString;
    lModel.objeto.MONOFILAMENTO               := lQry.FieldByName('MONOFILAMENTO').AsString;
    lModel.objeto.DIAPASAO                    := lQry.FieldByName('DIAPASAO').AsString;
    lModel.objeto.DIGITAPRESSAO               := lQry.FieldByName('DIGITAPRESSAO').AsString;
    lModel.objeto.PULSOS                      := lQry.FieldByName('PULSOS').AsString;
    lModel.objeto.PERFUSAO_D                  := lQry.FieldByName('PERFUSAO_D').AsString;
    lModel.objeto.PERFUSAO_E                  := lQry.FieldByName('PERFUSAO_E').AsString;
    lModel.objeto.USA_NFE                     := lQry.FieldByName('USA_NFE').AsString;
    lModel.objeto.USA_NFCE                    := lQry.FieldByName('USA_NFCE').AsString;
    lModel.objeto.USA_MDFE                    := lQry.FieldByName('USA_MDFE').AsString;
    lModel.objeto.USA_CTE                     := lQry.FieldByName('USA_CTE').AsString;
    lModel.objeto.USA_NFSE                    := lQry.FieldByName('USA_NFSE').AsString;
    lModel.objeto.USAR_CONTROLE_KG            := lQry.FieldByName('USAR_CONTROLE_KG').AsString;
    lModel.objeto.COMPLEMENTO_ENTREGA         := lQry.FieldByName('COMPLEMENTO_ENTREGA').AsString;
    lModel.objeto.NUMERO_ENTREGA              := lQry.FieldByName('NUMERO_ENTREGA').AsString;
    lModel.objeto.COD_MUNICIPIO_ENTREGA       := lQry.FieldByName('COD_MUNICIPIO_ENTREGA').AsString;
    lModel.objeto.EX_CODIGO_POSTAL            := lQry.FieldByName('EX_CODIGO_POSTAL').AsString;
    lModel.objeto.EX_ESTADO                   := lQry.FieldByName('EX_ESTADO').AsString;
    lModel.objeto.PARCELA_MAXIMA              := lQry.FieldByName('PARCELA_MAXIMA').AsString;
    lModel.objeto.TRANSPORTADORA_ID           := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.objeto.COMISSAO                    := lQry.FieldByName('COMISSAO').AsString;
    lModel.objeto.DIA_VENCIMENTO              := lQry.FieldByName('DIA_VENCIMENTO').AsString;
    lModel.objeto.LISTAR_RAD                  := lQry.FieldByName('LISTAR_RAD').AsString;
    lModel.objeto.CONTADOR_ID                 := lQry.FieldByName('CONTADOR_ID').AsString;
    lModel.objeto.VAUCHER                     := lQry.FieldByName('VAUCHER').AsString;
    lModel.objeto.MATRIZ_CLIENTE_ID           := lQry.FieldByName('MATRIZ_CLIENTE_ID').AsString;
    lModel.objeto.INSCRICAO_MUNICIPAL         := lQry.FieldByName('INSCRICAO_MUNICIPAL').AsString;
    lModel.objeto.ENVIA_SMS                   := lQry.FieldByName('ENVIA_SMS').AsString;
    lModel.objeto.VALOR_ALUGUEL               := lQry.FieldByName('VALOR_ALUGUEL').AsString;
    lModel.objeto.TEMPO_RESIDENCIA            := lQry.FieldByName('TEMPO_RESIDENCIA').AsString;
    lModel.objeto.TIPO_RESIDENCIA             := lQry.FieldByName('TIPO_RESIDENCIA').AsString;
    lModel.objeto.PARENTESCO_REF1             := lQry.FieldByName('PARENTESCO_REF1').AsString;
    lModel.objeto.PARENTESCO_REF2             := lQry.FieldByName('PARENTESCO_REF2').AsString;
    lModel.objeto.TRABALHO_ADMISSAO           := lQry.FieldByName('TRABALHO_ADMISSAO').AsString;
    lModel.objeto.TRABALHO_ANTERIOR_ADMISSAO  := lQry.FieldByName('TRABALHO_ANTERIOR_ADMISSAO').AsString;
    lModel.objeto.NOME_TRABALHO_ANTERIOR      := lQry.FieldByName('NOME_TRABALHO_ANTERIOR').AsString;
    lModel.objeto.TELEFONE_TRABALHO_ANTERIOR  := lQry.FieldByName('TELEFONE_TRABALHO_ANTERIOR').AsString;
    lModel.objeto.FUNCAO_TRABALHO_ANTERIOR    := lQry.FieldByName('FUNCAO_TRABALHO_ANTERIOR').AsString;
    lModel.objeto.RENDA_TRABALHO_ANTERIOR     := lQry.FieldByName('RENDA_TRABALHO_ANTERIOR').AsString;
    lModel.objeto.REGIME_TRABALHO             := lQry.FieldByName('REGIME_TRABALHO').AsString;
    lModel.objeto.CONFIRM_ENDERECO            := lQry.FieldByName('CONFIRM_ENDERECO').AsString;
    lModel.objeto.CONFIRM_ENDERECO_ANTERIOR   := lQry.FieldByName('CONFIRM_ENDERECO_ANTERIOR').AsString;
    lModel.objeto.CONFIRM_TRABALHO            := lQry.FieldByName('CONFIRM_TRABALHO').AsString;
    lModel.objeto.CONFIRM_TRABALHO_CONJUGE     := lQry.FieldByName('CONFIRM_TRABALHO_CONJUGE').AsString;
    lModel.objeto.DESCONTO_BOL                 := lQry.FieldByName('DESCONTO_BOL').AsString;
    lModel.objeto.PRODUTO_TIPO_ID              := lQry.FieldByName('PRODUTO_TIPO_ID').AsString;
    lModel.objeto.PEDIDO_MINIMO                := lQry.FieldByName('PEDIDO_MINIMO').AsString;
    lModel.objeto.REDUCAO_ICMS                 := lQry.FieldByName('REDUCAO_ICMS').AsString;
    lModel.objeto.ABATIMENTO_BOL               := lQry.FieldByName('ABATIMENTO_BOL').AsString;
    lModel.objeto.USAR_DESCONTO_PRODUTO        := lQry.FieldByName('USAR_DESCONTO_PRODUTO').AsString;
    lModel.objeto.CODIGO_ANTERIOR              := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.objeto.SENHA                        := lQry.FieldByName('SENHA').AsString;
    lModel.objeto.OCUPACAO_ID                  := lQry.FieldByName('OCUPACAO_ID').AsString;
    lModel.objeto.SUB_ATIVIDADE_ID             := lQry.FieldByName('SUB_ATIVIDADE_ID').AsString;
    lModel.objeto.ZEMOPAY                      := lQry.FieldByName('ZEMOPAY').AsString;
    lModel.objeto.ZEMOPAY_TAXA_ID              := lQry.FieldByName('ZEMOPAY_TAXA_ID').AsString;
    lModel.objeto.ZEMOPAY_ID                   := lQry.FieldByName('ZEMOPAY_ID').AsString;
    lModel.objeto.ZEMOPAY_BANCO_ID             := lQry.FieldByName('ZEMOPAY_BANCO_ID').AsString;
    lModel.objeto.DATA_INATIVIDADE             := lQry.FieldByName('DATA_INATIVIDADE').AsString;
    lModel.objeto.IMPORTACAO_DADOS             := lQry.FieldByName('IMPORTACAO_DADOS').AsString;
    lModel.objeto.OBSERVACAO_IMPLANTACAO       := lQry.FieldByName('OBSERVACAO_IMPLANTACAO').AsString;
    lModel.objeto.STATUS_IMPLANTACAO           := lQry.FieldByName('STATUS_IMPLANTACAO').AsString;
    lModel.objeto.NAO_CONTRIBUINTE             := lQry.FieldByName('NAO_CONTRIBUINTE').AsString;
    lModel.objeto.GRUPO_ECONOMICO_ID           := lQry.FieldByName('GRUPO_ECONOMICO_ID').AsString;
    lModel.objeto.ACEITE_BOL                   := lQry.FieldByName('ACEITE_BOL').AsString;
    lModel.objeto.BLOQUEAR_ALTERACAO_TABELA    := lQry.FieldByName('BLOQUEAR_ALTERACAO_TABELA').AsString;
    lModel.objeto.TIPO_EMISSAO_NFE             := lQry.FieldByName('TIPO_EMISSAO_NFE').AsString;
    lModel.objeto.PERCENTUAL_DESCONTO          := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
    lModel.objeto.TIPO_FUNCIONARIO_PUBLICO_CLI := lQry.FieldByName('TIPO_FUNCIONARIO_PUBLICO_CLI').AsString;
    lModel.objeto.NUMBENEFICIO_CLI             := lQry.FieldByName('NUMBENEFICIO_CLI').AsString;
    lModel.objeto.FONTE_BENEFICIO_CLI          := lQry.FieldByName('FONTE_BENEFICIO_CLI').AsString;
    lModel.objeto.CODIGO_OCUPACAO_CLI          := lQry.FieldByName('CODIGO_OCUPACAO_CLI').AsString;
    lModel.objeto.DOCIDENTIFICACAOCONJ_CLI     := lQry.FieldByName('DOCIDENTIFICACAOCONJ_CLI').AsString;
    lModel.objeto.TIPODOCIDENTIFICACAOCONJ_CLI := lQry.FieldByName('TIPODOCIDENTIFICACAOCONJ_CLI').AsString;
    lModel.objeto.TIPODOC_CLI                  := lQry.FieldByName('TIPODOC_CLI').AsString;
    lModel.objeto.NOME_CONTADOR_CLI            := lQry.FieldByName('NOME_CONTADOR_CLI').AsString;
    lModel.objeto.TELEFONE_CONTADOR_CLI        := lQry.FieldByName('TELEFONE_CONTADOR_CLI').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TClienteDao.comissaoCliente(pId: String): Variant;
begin
  Result := vIConexao.getConnection.ExecSQLScalar('select coalesce(COMISSAO, 0) from ' + self.NomeTabela +' where CODIGO_CLI = '+ QuotedStr(pId));
end;

constructor TClienteDao._Create(pIConexao : Iconexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TClienteDao.Destroy;
begin
  vConstrutor:=nil;
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

function TClienteDao.incluir(pClienteModel: ITClienteModel): String;
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
    pClienteModel.objeto.CODIGO_CLI := vIConexao.Generetor('GEN_CLIENTE', true);
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

function TClienteDao.alterar(pClienteModel: ITClienteModel): String;
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

    Result := pClienteModel.objeto.CODIGO_CLI;

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
      sincronizarDados(pClienteModel);

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TClienteDao.excluir(pClienteModel: ITClienteModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from ' + self.NomeTabela + ' where CODIGO_CLI = :CODIGO_CLI',[pClienteModel.objeto.CODIGO_CLI]);
   lQry.ExecSQL;
   Result := pClienteModel.objeto.CODIGO_CLI;
  finally
    lQry.Free;
  end;
end;

class function TClienteDao.getNewIface(pIConexao: IConexao): ITClienteDao;
begin
  Result := TImplObjetoOwner<TClienteDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
  modelo: ITClienteModel;
begin
  lQry := vIConexao.CriarQuery;
  FClientesLista := TCollections.CreateList<ITClienteModel>;
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
      modelo := TClienteModel.getNewIface(vIConexao);
      FClientesLista.Add(modelo);
      modelo.objeto.codigo_cli                 := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.objeto.fantasia_cli               := lQry.FieldByName('FANTASIA_CLI').AsString;
      modelo.objeto.razao_cli                  := lQry.FieldByName('RAZAO_CLI').AsString;
      modelo.objeto.cnpj_cpf_cli               := lQry.FieldByName('CNPJ_CPF_CLI').AsString;
      modelo.objeto.inscricao_rg_cli           := lQry.FieldByName('INSCRICAO_RG_CLI').AsString;
      modelo.objeto.endereco_cli               := lQry.FieldByName('ENDERECO_CLI').AsString;
      modelo.objeto.endereco                   := lQry.FieldByName('ENDERECO').AsString;
      modelo.objeto.bairro_cli                 := lQry.FieldByName('BAIRRO_CLI').AsString;
      modelo.objeto.cidade_cli                 := lQry.FieldByName('CIDADE_CLI').AsString;
      modelo.objeto.uf_cli                     := lQry.FieldByName('UF_CLI').AsString;
      modelo.objeto.cep_cli                    := lQry.FieldByName('CEP_CLI').AsString;
      modelo.objeto.telefone_cli               := lQry.FieldByName('TELEFONE_CLI').AsString;
      modelo.objeto.fax_cli                    := lQry.FieldByName('FAX_CLI').AsString;
      modelo.objeto.email_cli                  := lQry.FieldByName('EMAIL_CLI').AsString;
      modelo.objeto.url_cli                    := lQry.FieldByName('URL_CLI').AsString;
      modelo.objeto.tipo_cli                   := lQry.FieldByName('TIPO_CLI').AsString;
      modelo.objeto.atividade_cli              := lQry.FieldByName('ATIVIDADE_CLI').AsString;
      modelo.objeto.endcobranca_cli            := lQry.FieldByName('ENDCOBRANCA_CLI').AsString;
      modelo.objeto.baircobranca_cli           := lQry.FieldByName('BAIRCOBRANCA_CLI').AsString;
      modelo.objeto.cidcobranca_cli            := lQry.FieldByName('CIDCOBRANCA_CLI').AsString;
      modelo.objeto.ufcobranca_cli             := lQry.FieldByName('UFCOBRANCA_CLI').AsString;
      modelo.objeto.cepcobranca_cli            := lQry.FieldByName('CEPCOBRANCA_CLI').AsString;
      modelo.objeto.localtrabalho_cli          := lQry.FieldByName('LOCALTRABALHO_CLI').AsString;
      modelo.objeto.cnpj_trabalho_cli          := lQry.FieldByName('CNPJ_TRABALHO_CLI').AsString;
      modelo.objeto.endtrabalho_cli            := lQry.FieldByName('ENDTRABALHO_CLI').AsString;
      modelo.objeto.bairtrabalho_cli           := lQry.FieldByName('BAIRTRABALHO_CLI').AsString;
      modelo.objeto.cidtrabalho_cli            := lQry.FieldByName('CIDTRABALHO_CLI').AsString;
      modelo.objeto.uftrabalho_cli             := lQry.FieldByName('UFTRABALHO_CLI').AsString;
      modelo.objeto.ceptrabalho_cli            := lQry.FieldByName('CEPTRABALHO_CLI').AsString;
      modelo.objeto.fonetrabalho_cli           := lQry.FieldByName('FONETRABALHO_CLI').AsString;
      modelo.objeto.funcaotrabalho_cli         := lQry.FieldByName('FUNCAOTRABALHO_CLI').AsString;
      modelo.objeto.referencia2_cli            := lQry.FieldByName('REFERENCIA2_CLI').AsString;
      modelo.objeto.foneref2_cli               := lQry.FieldByName('FONEREF2_CLI').AsString;
      modelo.objeto.referencia3_cli            := lQry.FieldByName('REFERENCIA3_CLI').AsString;
      modelo.objeto.foneref3_cli               := lQry.FieldByName('FONEREF3_CLI').AsString;
      modelo.objeto.seprocado_cli              := lQry.FieldByName('SEPROCADO_CLI').AsString;
      modelo.objeto.referencia1_cli            := lQry.FieldByName('REFERENCIA1_CLI').AsString;
      modelo.objeto.foneref1_cli               := lQry.FieldByName('FONEREF1_CLI').AsString;
      modelo.objeto.cadastro_cli               := lQry.FieldByName('CADASTRO_CLI').AsString;
      modelo.objeto.nascimento_cli             := lQry.FieldByName('NASCIMENTO_CLI').AsString;
      modelo.objeto.celular_cli                := lQry.FieldByName('CELULAR_CLI').AsString;
      modelo.objeto.pai_cli                    := lQry.FieldByName('PAI_CLI').AsString;
      modelo.objeto.mae_cli                    := lQry.FieldByName('MAE_CLI').AsString;
      modelo.objeto.contato_cli                := lQry.FieldByName('CONTATO_CLI').AsString;
      modelo.objeto.observacao_cli             := lQry.FieldByName('OBSERVACAO_CLI').AsString;
      modelo.objeto.banco_cli                  := lQry.FieldByName('BANCO_CLI').AsString;
      modelo.objeto.agencia_cli                := lQry.FieldByName('AGENCIA_CLI').AsString;
      modelo.objeto.conta_cli                  := lQry.FieldByName('CONTA_CLI').AsString;
      modelo.objeto.renda_cli                  := lQry.FieldByName('RENDA_CLI').AsString;
      modelo.objeto.foneagencia_cli            := lQry.FieldByName('FONEAGENCIA_CLI').AsString;
      modelo.objeto.contatoagencia_cli         := lQry.FieldByName('CONTATOAGENCIA_CLI').AsString;
      modelo.objeto.codigo_ven                 := lQry.FieldByName('CODIGO_VEN').AsString;
      modelo.objeto.usuario_cli                := lQry.FieldByName('USUARIO_CLI').AsString;
      modelo.objeto.estadocivil_cli            := lQry.FieldByName('ESTADOCIVIL_CLI').AsString;
      modelo.objeto.nomecon_cli                := lQry.FieldByName('NOMECON_CLI').AsString;
      modelo.objeto.cpfcon_cli                 := lQry.FieldByName('CPFCON_CLI').AsString;
      modelo.objeto.rgcon_cli                  := lQry.FieldByName('RGCON_CLI').AsString;
      modelo.objeto.profcon_cli                := lQry.FieldByName('PROFCON_CLI').AsString;
      modelo.objeto.salariocon_cli             := lQry.FieldByName('SALARIOCON_CLI').AsString;
      modelo.objeto.convenio_cli               := lQry.FieldByName('CONVENIO_CLI').AsString;
      modelo.objeto.convenio_cod               := lQry.FieldByName('CONVENIO_COD').AsString;
      modelo.objeto.carta_cli                  := lQry.FieldByName('CARTA_CLI').AsString;
      modelo.objeto.expedicao_rg               := lQry.FieldByName('EXPEDICAO_RG').AsString;
      modelo.objeto.naturalidade_cli           := lQry.FieldByName('NATURALIDADE_CLI').AsString;
      modelo.objeto.uf_naturalidade_cli        := lQry.FieldByName('UF_NATURALIDADE_CLI').AsString;
      modelo.objeto.escolaridade_cli           := lQry.FieldByName('ESCOLARIDADE_CLI').AsString;
      modelo.objeto.tempo_servico              := lQry.FieldByName('TEMPO_SERVICO').AsString;
      modelo.objeto.beneficio_cli              := lQry.FieldByName('BENEFICIO_CLI').AsString;
      modelo.objeto.descricao                  := lQry.FieldByName('DESCRICAO').AsString;
      modelo.objeto.reduzir_base_icms          := lQry.FieldByName('REDUZIR_BASE_ICMS').AsString;
      modelo.objeto.isento_icms                := lQry.FieldByName('ISENTO_ICMS').AsString;
      modelo.objeto.loja                       := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.data_alteracao             := lQry.FieldByName('DATA_ALTERACAO').AsString;
      modelo.objeto.limite_compra              := lQry.FieldByName('LIMITE_COMPRA').AsString;
      modelo.objeto.tipo_saida                 := lQry.FieldByName('TIPO_SAIDA').AsString;
      modelo.objeto.cod_municipio              := lQry.FieldByName('COD_MUNICIPIO').AsString;
      modelo.objeto.ultima_compra              := lQry.FieldByName('ULTIMA_COMPRA').AsString;
      modelo.objeto.status                     := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.portador                   := lQry.FieldByName('PORTADOR').AsString;
      modelo.objeto.sexo_cli                   := lQry.FieldByName('SEXO_CLI').AsString;
      modelo.objeto.classif_cli                := lQry.FieldByName('CLASSIF_CLI').AsString;
      modelo.objeto.data_retorno               := lQry.FieldByName('DATA_RETORNO').AsString;
      modelo.objeto.hora_retorno               := lQry.FieldByName('HORA_RETORNO').AsString;
      modelo.objeto.avalista_cli               := lQry.FieldByName('AVALISTA_CLI').AsString;
      modelo.objeto.cnpj_cpf_aval_cli          := lQry.FieldByName('CNPJ_CPF_AVAL_CLI').AsString;
      modelo.objeto.bairro_aval_cli            := lQry.FieldByName('BAIRRO_AVAL_CLI').AsString;
      modelo.objeto.cidade_aval_cli            := lQry.FieldByName('CIDADE_AVAL_CLI').AsString;
      modelo.objeto.telefone_aval_cli          := lQry.FieldByName('TELEFONE_AVAL_CLI').AsString;
      modelo.objeto.celular_aval_cli           := lQry.FieldByName('CELULAR_AVAL_CLI').AsString;
      modelo.objeto.endereco_aval_cli          := lQry.FieldByName('ENDERECO_AVAL_CLI').AsString;
      modelo.objeto.isento_ipi                 := lQry.FieldByName('ISENTO_IPI').AsString;
      modelo.objeto.revendedor                 := lQry.FieldByName('REVENDEDOR').AsString;
      modelo.objeto.credito_cli                := lQry.FieldByName('CREDITO_CLI').AsString;
      modelo.objeto.fone_com_aval              := lQry.FieldByName('FONE_COM_AVAL').AsString;
      modelo.objeto.rg_aval                    := lQry.FieldByName('RG_AVAL').AsString;
      modelo.objeto.mae_aval                   := lQry.FieldByName('MAE_AVAL').AsString;
      modelo.objeto.data_nasc_aval             := lQry.FieldByName('DATA_NASC_AVAL').AsString;
      modelo.objeto.unidade_consumidora_cb     := lQry.FieldByName('UNIDADE_CONSUMIDORA_CB').AsString;
      modelo.objeto.codigo_concessionaria_cb   := lQry.FieldByName('CODIGO_CONCESSIONARIA_CB').AsString;
      modelo.objeto.codigo_vendedor_cb         := lQry.FieldByName('CODIGO_VENDEDOR_CB').AsString;
      modelo.objeto.titular_conta_cb           := lQry.FieldByName('TITULAR_CONTA_CB').AsString;
      modelo.objeto.data_faturamento_cb        := lQry.FieldByName('DATA_FATURAMENTO_CB').AsString;
      modelo.objeto.data_vencimento_cb         := lQry.FieldByName('DATA_VENCIMENTO_CB').AsString;
      modelo.objeto.celular_cli2               := lQry.FieldByName('CELULAR_CLI2').AsString;
      modelo.objeto.operadora_celular          := lQry.FieldByName('OPERADORA_CELULAR').AsString;
      modelo.objeto.data_nasc_conjugue         := lQry.FieldByName('DATA_NASC_CONJUGUE').AsString;
      modelo.objeto.email2                     := lQry.FieldByName('EMAIL2').AsString;
      modelo.objeto.descricao_reparcelamento   := lQry.FieldByName('DESCRICAO_REPARCELAMENTO').AsString;
      modelo.objeto.id                         := lQry.FieldByName('ID').AsString;
      modelo.objeto.dependente                 := lQry.FieldByName('DEPENDENTE').AsString;
      modelo.objeto.nascimento_dependente      := lQry.FieldByName('NASCIMENTO_DEPENDENTE').AsString;
      modelo.objeto.sexo_dependente            := lQry.FieldByName('SEXO_DEPENDENTE').AsString;
      modelo.objeto.dependente2                := lQry.FieldByName('DEPENDENTE2').AsString;
      modelo.objeto.nascimento_dependente2     := lQry.FieldByName('NASCIMENTO_DEPENDENTE2').AsString;
      modelo.objeto.sexo_dependente2           := lQry.FieldByName('SEXO_DEPENDENTE2').AsString;
      modelo.objeto.dependente3                := lQry.FieldByName('DEPENDENTE3').AsString;
      modelo.objeto.nascimento_dependente3     := lQry.FieldByName('NASCIMENTO_DEPENDENTE3').AsString;
      modelo.objeto.sexo_dependente3           := lQry.FieldByName('SEXO_DEPENDENTE3').AsString;
      modelo.objeto.observacao_ped_orc         := lQry.FieldByName('OBSERVACAO_PED_ORC').AsString;
      modelo.objeto.preco_id                   := lQry.FieldByName('PRECO_ID').AsString;
      modelo.objeto.suframa                    := lQry.FieldByName('SUFRAMA').AsString;
      modelo.objeto.complemento                := lQry.FieldByName('COMPLEMENTO').AsString;
      modelo.objeto.numero_end                 := lQry.FieldByName('NUMERO_END').AsString;
      modelo.objeto.atividade_id               := lQry.FieldByName('ATIVIDADE_ID').AsString;
      modelo.objeto.pais_id                    := lQry.FieldByName('PAIS_ID').AsString;
      modelo.objeto.regiao_id                  := lQry.FieldByName('REGIAO_ID').AsString;
      modelo.objeto.cfop_id                    := lQry.FieldByName('CFOP_ID').AsString;
      modelo.objeto.tipo_suframa               := lQry.FieldByName('TIPO_SUFRAMA').AsString;
      modelo.objeto.tipo_apuracao              := lQry.FieldByName('TIPO_APURACAO').AsString;
      modelo.objeto.condicoes_pagamento        := lQry.FieldByName('CONDICOES_PAGAMENTO').AsString;
      modelo.objeto.consumidor_final           := lQry.FieldByName('CONSUMIDOR_FINAL').AsString;
      modelo.objeto.nfe                        := lQry.FieldByName('NFE').AsString;
      modelo.objeto.carga_tributaria           := lQry.FieldByName('CARGA_TRIBUTARIA').AsString;
      modelo.objeto.desconto_financeiro        := lQry.FieldByName('DESCONTO_FINANCEIRO').AsString;
      modelo.objeto.quantidade_terminais       := lQry.FieldByName('QUANTIDADE_TERMINAIS').AsString;
      modelo.objeto.telefone_internacional     := lQry.FieldByName('TELEFONE_INTERNACIONAL').AsString;
      modelo.objeto.cnae                       := lQry.FieldByName('CNAE').AsString;
      modelo.objeto.endereco_entrega           := lQry.FieldByName('ENDERECO_ENTREGA').AsString;
      modelo.objeto.bairro_entrega             := lQry.FieldByName('BAIRRO_ENTREGA').AsString;
      modelo.objeto.cidade_entrega             := lQry.FieldByName('CIDADE_ENTREGA').AsString;
      modelo.objeto.uf_entrega                 := lQry.FieldByName('UF_ENTREGA').AsString;
      modelo.objeto.cep_entrega                := lQry.FieldByName('CEP_ENTREGA').AsString;
      modelo.objeto.status_carta               := lQry.FieldByName('STATUS_CARTA').AsString;
      modelo.objeto.email_cobranca             := lQry.FieldByName('EMAIL_COBRANCA').AsString;
      modelo.objeto.contato_cobranca           := lQry.FieldByName('CONTATO_COBRANCA').AsString;
      modelo.objeto.telefone_cobranca          := lQry.FieldByName('TELEFONE_COBRANCA').AsString;
      modelo.objeto.celular_cobrnaca           := lQry.FieldByName('CELULAR_COBRNACA').AsString;
      modelo.objeto.observacao_cobranca        := lQry.FieldByName('OBSERVACAO_COBRANCA').AsString;
      modelo.objeto.complemento_cobranca       := lQry.FieldByName('COMPLEMENTO_COBRANCA').AsString;
      modelo.objeto.observacao_nfe             := lQry.FieldByName('OBSERVACAO_NFE').AsString;
      modelo.objeto.desconto_nf                := lQry.FieldByName('DESCONTO_NF').AsString;
      modelo.objeto.obs_geral                  := lQry.FieldByName('OBS_GERAL').AsString;
      modelo.objeto.systime                    := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.tela                       := lQry.FieldByName('TELA').AsString;
      modelo.objeto.limite_sms                 := lQry.FieldByName('LIMITE_SMS').AsString;
      modelo.objeto.telefone_pai               := lQry.FieldByName('TELEFONE_PAI').AsString;
      modelo.objeto.telefone_mae               := lQry.FieldByName('TELEFONE_MAE').AsString;
      modelo.objeto.telefone_conjuge           := lQry.FieldByName('TELEFONE_CONJUGE').AsString;
      modelo.objeto.multa                      := lQry.FieldByName('MULTA').AsString;
      modelo.objeto.juros_bol                  := lQry.FieldByName('JUROS_BOL').AsString;
      modelo.objeto.indice_juros_id            := lQry.FieldByName('INDICE_JUROS_ID').AsString;
      modelo.objeto.ctb                        := lQry.FieldByName('CTB').AsString;
      modelo.objeto.banco_id                   := lQry.FieldByName('BANCO_ID').AsString;
      modelo.objeto.instrucao_boleto           := lQry.FieldByName('INSTRUCAO_BOLETO').AsString;
      modelo.objeto.dependente4                := lQry.FieldByName('DEPENDENTE4').AsString;
      modelo.objeto.nascimento_dependente4     := lQry.FieldByName('NASCIMENTO_DEPENDENTE4').AsString;
      modelo.objeto.sexo_dependente4           := lQry.FieldByName('SEXO_DEPENDENTE4').AsString;
      modelo.objeto.dependente5                := lQry.FieldByName('DEPENDENTE5').AsString;
      modelo.objeto.nascimento_dependente5     := lQry.FieldByName('NASCIMENTO_DEPENDENTE5').AsString;
      modelo.objeto.sexo_dependente5           := lQry.FieldByName('SEXO_DEPENDENTE5').AsString;
      modelo.objeto.dependente6                := lQry.FieldByName('DEPENDENTE6').AsString;
      modelo.objeto.nascimento_dependente6     := lQry.FieldByName('NASCIMENTO_DEPENDENTE6').AsString;
      modelo.objeto.sexo_dependente6           := lQry.FieldByName('SEXO_DEPENDENTE6').AsString;
      modelo.objeto.isento_st                  := lQry.FieldByName('ISENTO_ST').AsString;
      modelo.objeto.frete                      := lQry.FieldByName('FRETE').AsString;
      modelo.objeto.prospeccao_id              := lQry.FieldByName('PROSPECCAO_ID').AsString;
      modelo.objeto.desc_financeiro            := lQry.FieldByName('DESC_FINANCEIRO').AsString;
      modelo.objeto.imagem                     := lQry.FieldByName('IMAGEM').AsString;
      modelo.objeto.pratica_esporte            := lQry.FieldByName('PRATICA_ESPORTE').AsString;
      modelo.objeto.frequencia                 := lQry.FieldByName('FREQUENCIA').AsString;
      modelo.objeto.destro_canhoto             := lQry.FieldByName('DESTRO_CANHOTO').AsString;
      modelo.objeto.numero_calcado             := lQry.FieldByName('NUMERO_CALCADO').AsString;
      modelo.objeto.calcado_mais_usado         := lQry.FieldByName('CALCADO_MAIS_USADO').AsString;
      modelo.objeto.material                   := lQry.FieldByName('MATERIAL').AsString;
      modelo.objeto.cirurgia_mmii              := lQry.FieldByName('CIRURGIA_MMII').AsString;
      modelo.objeto.tratamento_medicamento     := lQry.FieldByName('TRATAMENTO_MEDICAMENTO').AsString;
      modelo.objeto.alergico                   := lQry.FieldByName('ALERGICO').AsString;
      modelo.objeto.alergico_obs               := lQry.FieldByName('ALERGICO_OBS').AsString;
      modelo.objeto.patologia                  := lQry.FieldByName('PATOLOGIA').AsString;
      modelo.objeto.patologia_obs              := lQry.FieldByName('PATOLOGIA_OBS').AsString;
      modelo.objeto.diabetes                   := lQry.FieldByName('DIABETES').AsString;
      modelo.objeto.diabetes_familiares        := lQry.FieldByName('DIABETES_FAMILIARES').AsString;
      modelo.objeto.etilista                   := lQry.FieldByName('ETILISTA').AsString;
      modelo.objeto.cardiopatias               := lQry.FieldByName('CARDIOPATIAS').AsString;
      modelo.objeto.tabagismo                  := lQry.FieldByName('TABAGISMO').AsString;
      modelo.objeto.dst                        := lQry.FieldByName('DST').AsString;
      modelo.objeto.pressao                    := lQry.FieldByName('PRESSAO').AsString;
      modelo.objeto.gravidez                   := lQry.FieldByName('GRAVIDEZ').AsString;
      modelo.objeto.outras_patologias          := lQry.FieldByName('OUTRAS_PATOLOGIAS').AsString;
      modelo.objeto.motivo_visita              := lQry.FieldByName('MOTIVO_VISITA').AsString;
      modelo.objeto.formato_unha               := lQry.FieldByName('FORMATO_UNHA').AsString;
      modelo.objeto.onicotrofia                := lQry.FieldByName('ONICOTROFIA').AsString;
      modelo.objeto.onicorrexe                 := lQry.FieldByName('ONICORREXE').AsString;
      modelo.objeto.onicogrifose               := lQry.FieldByName('ONICOGRIFOSE').AsString;
      modelo.objeto.onicolise                  := lQry.FieldByName('ONICOLISE').AsString;
      modelo.objeto.onicomicose                := lQry.FieldByName('ONICOMICOSE').AsString;
      modelo.objeto.psoriase                   := lQry.FieldByName('PSORIASE').AsString;
      modelo.objeto.onicocriptose              := lQry.FieldByName('ONICOCRIPTOSE').AsString;
      modelo.objeto.granulada                  := lQry.FieldByName('GRANULADA').AsString;
      modelo.objeto.alteracao_cor              := lQry.FieldByName('ALTERACAO_COR').AsString;
      modelo.objeto.onicofose                  := lQry.FieldByName('ONICOFOSE').AsString;
      modelo.objeto.exostose_subungueal        := lQry.FieldByName('EXOSTOSE_SUBUNGUEAL').AsString;
      modelo.objeto.ungueal                    := lQry.FieldByName('UNGUEAL').AsString;
      modelo.objeto.outras_alteracao_laminas   := lQry.FieldByName('OUTRAS_ALTERACAO_LAMINAS').AsString;
      modelo.objeto.bromidrose                 := lQry.FieldByName('BROMIDROSE').AsString;
      modelo.objeto.anidrose                   := lQry.FieldByName('ANIDROSE').AsString;
      modelo.objeto.hiperhidrose               := lQry.FieldByName('HIPERHIDROSE').AsString;
      modelo.objeto.isquemica                  := lQry.FieldByName('ISQUEMICA').AsString;
      modelo.objeto.frieira                    := lQry.FieldByName('FRIEIRA').AsString;
      modelo.objeto.tinea_pedis                := lQry.FieldByName('TINEA_PEDIS').AsString;
      modelo.objeto.neuropatica                := lQry.FieldByName('NEUROPATICA').AsString;
      modelo.objeto.fissuras                   := lQry.FieldByName('FISSURAS').AsString;
      modelo.objeto.disidrose                  := lQry.FieldByName('DISIDROSE').AsString;
      modelo.objeto.mal_perfurante             := lQry.FieldByName('MAL_PERFURANTE').AsString;
      modelo.objeto.psoriase_pe                := lQry.FieldByName('PSORIASE_PE').AsString;
      modelo.objeto.alteracao_pele             := lQry.FieldByName('ALTERACAO_PELE').AsString;
      modelo.objeto.halux_valgus               := lQry.FieldByName('HALUX_VALGUS').AsString;
      modelo.objeto.halux_rigidus              := lQry.FieldByName('HALUX_RIGIDUS').AsString;
      modelo.objeto.esporao_calcaneo           := lQry.FieldByName('ESPORAO_CALCANEO').AsString;
      modelo.objeto.pe_cavo                    := lQry.FieldByName('PE_CAVO').AsString;
      modelo.objeto.pe_plano                   := lQry.FieldByName('PE_PLANO').AsString;
      modelo.objeto.dedos_garra                := lQry.FieldByName('DEDOS_GARRA').AsString;
      modelo.objeto.podactilia                 := lQry.FieldByName('PODACTILIA').AsString;
      modelo.objeto.alteracao_ortopedicas      := lQry.FieldByName('ALTERACAO_ORTOPEDICAS').AsString;
      modelo.objeto.indicacao                  := lQry.FieldByName('INDICACAO').AsString;
      modelo.objeto.monofilamento              := lQry.FieldByName('MONOFILAMENTO').AsString;
      modelo.objeto.diapasao                   := lQry.FieldByName('DIAPASAO').AsString;
      modelo.objeto.digitapressao              := lQry.FieldByName('DIGITAPRESSAO').AsString;
      modelo.objeto.pulsos                     := lQry.FieldByName('PULSOS').AsString;
      modelo.objeto.perfusao_d                 := lQry.FieldByName('PERFUSAO_D').AsString;
      modelo.objeto.perfusao_e                 := lQry.FieldByName('PERFUSAO_E').AsString;
      modelo.objeto.usa_nfe                    := lQry.FieldByName('USA_NFE').AsString;
      modelo.objeto.usa_nfce                   := lQry.FieldByName('USA_NFCE').AsString;
      modelo.objeto.usa_mdfe                   := lQry.FieldByName('USA_MDFE').AsString;
      modelo.objeto.usa_cte                    := lQry.FieldByName('USA_CTE').AsString;
      modelo.objeto.usa_nfse                   := lQry.FieldByName('USA_NFSE').AsString;
      modelo.objeto.usar_controle_kg           := lQry.FieldByName('USAR_CONTROLE_KG').AsString;
      modelo.objeto.complemento_entrega        := lQry.FieldByName('COMPLEMENTO_ENTREGA').AsString;
      modelo.objeto.numero_entrega             := lQry.FieldByName('NUMERO_ENTREGA').AsString;
      modelo.objeto.cod_municipio_entrega      := lQry.FieldByName('COD_MUNICIPIO_ENTREGA').AsString;
      modelo.objeto.ex_codigo_postal           := lQry.FieldByName('EX_CODIGO_POSTAL').AsString;
      modelo.objeto.ex_estado                  := lQry.FieldByName('EX_ESTADO').AsString;
      modelo.objeto.parcela_maxima             := lQry.FieldByName('PARCELA_MAXIMA').AsString;
      modelo.objeto.transportadora_id          := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
      modelo.objeto.comissao                   := lQry.FieldByName('COMISSAO').AsString;
      modelo.objeto.dia_vencimento             := lQry.FieldByName('DIA_VENCIMENTO').AsString;
      modelo.objeto.listar_rad                 := lQry.FieldByName('LISTAR_RAD').AsString;
      modelo.objeto.contador_id                := lQry.FieldByName('CONTADOR_ID').AsString;
      modelo.objeto.vaucher                    := lQry.FieldByName('VAUCHER').AsString;
      modelo.objeto.matriz_cliente_id          := lQry.FieldByName('MATRIZ_CLIENTE_ID').AsString;
      modelo.objeto.inscricao_municipal        := lQry.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      modelo.objeto.envia_sms                  := lQry.FieldByName('ENVIA_SMS').AsString;
      modelo.objeto.valor_aluguel              := lQry.FieldByName('VALOR_ALUGUEL').AsString;
      modelo.objeto.tempo_residencia           := lQry.FieldByName('TEMPO_RESIDENCIA').AsString;
      modelo.objeto.tipo_residencia            := lQry.FieldByName('TIPO_RESIDENCIA').AsString;
      modelo.objeto.parentesco_ref1            := lQry.FieldByName('PARENTESCO_REF1').AsString;
      modelo.objeto.parentesco_ref2            := lQry.FieldByName('PARENTESCO_REF2').AsString;
      modelo.objeto.trabalho_admissao          := lQry.FieldByName('TRABALHO_ADMISSAO').AsString;
      modelo.objeto.trabalho_anterior_admissao := lQry.FieldByName('TRABALHO_ANTERIOR_ADMISSAO').AsString;
      modelo.objeto.nome_trabalho_anterior     := lQry.FieldByName('NOME_TRABALHO_ANTERIOR').AsString;
      modelo.objeto.telefone_trabalho_anterior := lQry.FieldByName('TELEFONE_TRABALHO_ANTERIOR').AsString;
      modelo.objeto.funcao_trabalho_anterior   := lQry.FieldByName('FUNCAO_TRABALHO_ANTERIOR').AsString;
      modelo.objeto.renda_trabalho_anterior    := lQry.FieldByName('RENDA_TRABALHO_ANTERIOR').AsString;
      modelo.objeto.regime_trabalho            := lQry.FieldByName('REGIME_TRABALHO').AsString;
      modelo.objeto.confirm_endereco           := lQry.FieldByName('CONFIRM_ENDERECO').AsString;
      modelo.objeto.confirm_endereco_anterior  := lQry.FieldByName('CONFIRM_ENDERECO_ANTERIOR').AsString;
      modelo.objeto.confirm_trabalho           := lQry.FieldByName('CONFIRM_TRABALHO').AsString;
      modelo.objeto.confirm_trabalho_conjuge   := lQry.FieldByName('CONFIRM_TRABALHO_CONJUGE').AsString;
      modelo.objeto.desconto_bol               := lQry.FieldByName('DESCONTO_BOL').AsString;
      modelo.objeto.produto_tipo_id            := lQry.FieldByName('PRODUTO_TIPO_ID').AsString;
      modelo.objeto.pedido_minimo              := lQry.FieldByName('PEDIDO_MINIMO').AsString;
      modelo.objeto.reducao_icms               := lQry.FieldByName('REDUCAO_ICMS').AsString;
      modelo.objeto.abatimento_bol             := lQry.FieldByName('ABATIMENTO_BOL').AsString;
      modelo.objeto.usar_desconto_produto      := lQry.FieldByName('USAR_DESCONTO_PRODUTO').AsString;
      modelo.objeto.codigo_anterior            := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
      modelo.objeto.senha                      := lQry.FieldByName('SENHA').AsString;
      modelo.objeto.ocupacao_id                := lQry.FieldByName('OCUPACAO_ID').AsString;
      modelo.objeto.sub_atividade_id           := lQry.FieldByName('SUB_ATIVIDADE_ID').AsString;
      modelo.objeto.zemopay                    := lQry.FieldByName('ZEMOPAY').AsString;
      modelo.objeto.zemopay_taxa_id            := lQry.FieldByName('ZEMOPAY_TAXA_ID').AsString;
      modelo.objeto.zemopay_id                 := lQry.FieldByName('ZEMOPAY_ID').AsString;
      modelo.objeto.zemopay_banco_id           := lQry.FieldByName('ZEMOPAY_BANCO_ID').AsString;
      modelo.objeto.data_inatividade           := lQry.FieldByName('DATA_INATIVIDADE').AsString;
      modelo.objeto.importacao_dados           := lQry.FieldByName('IMPORTACAO_DADOS').AsString;
      modelo.objeto.observacao_implantacao     := lQry.FieldByName('OBSERVACAO_IMPLANTACAO').AsString;
      modelo.objeto.status_implantacao         := lQry.FieldByName('STATUS_IMPLANTACAO').AsString;
      modelo.objeto.nao_contribuinte           := lQry.FieldByName('NAO_CONTRIBUINTE').AsString;
      modelo.objeto.grupo_economico_id         := lQry.FieldByName('GRUPO_ECONOMICO_ID').AsString;
      modelo.objeto.aceite_bol                 := lQry.FieldByName('ACEITE_BOL').AsString;
      modelo.objeto.bloquear_alteracao_tabela  := lQry.FieldByName('BLOQUEAR_ALTERACAO_TABELA').AsString;
      modelo.objeto.tipo_emissao_nfe           := lQry.FieldByName('TIPO_EMISSAO_NFE').AsString;
      modelo.objeto.percentual_desconto        := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
      modelo.objeto.sacador_avalista_id        := lQry.FieldByName('SACADOR_AVALISTA_ID').AsString;
      modelo.objeto.tipo_funcionario_publico_cli := lQry.FieldByName('TIPO_FUNCIONARIO_PUBLICO_CLI').AsString;
      modelo.objeto.naturalidade_cli           := lQry.FieldByName('NATURALIDADE_CLI').AsString;
      modelo.objeto.numbeneficio_cli           := lQry.FieldByName('NUMBENEFICIO_CLI').AsString;
      modelo.objeto.fonte_beneficio_cli        := lQry.FieldByName('FONTE_BENEFICIO_CLI').AsString;
      modelo.objeto.codigo_ocupacao_cli        := lQry.FieldByName('CODIGO_OCUPACAO_CLI').AsString;
      modelo.objeto.docidentificacaoconj_cli   := lQry.FieldByName('DOCIDENTIFICACAOCONJ_CLI').AsString;
      modelo.objeto.tipodocidentificacaoconj_cli := lQry.FieldByName('TIPODOCIDENTIFICACAOCONJ_CLI').AsString;
      modelo.objeto.tipodoc_cli                := lQry.FieldByName('TIPODOC_CLI').AsString;
      modelo.objeto.nome_contador_cli          := lQry.FieldByName('NOME_CONTADOR_CLI').AsString;
      modelo.objeto.telefone_contador_cli      := lQry.FieldByName('TELEFONE_CONTADOR_CLI').AsString;
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

procedure TClienteDao.setParams(pQry: TFDQuery; pClienteModel: ITClienteModel);
begin
  vConstrutor.setParams(NomeTabela,pQry,pClienteModel.objeto);
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

function TClienteDao.sincronizarDados(pClienteModel: ITClienteModel): String;
var
  lQry        : IFDQuery;
  lSQL        : String;
  lAsyncList  : IListaQueryAsync;
  lQA: IQueryLojaAsync;
begin
  Result := '';
  lAsyncList := getQueryLojaAsyncList(vIConexao);
  try
    lSQL := vConstrutor.gerarUpdateOrInsert('CLIENTES','CODIGO_CLI', 'CODIGO_CLI', true);

    for lQA in lAsyncList do
    begin
      if lQA.loja.objeto.LOJA <> vIConexao.getEmpresa.LOJA then
      begin
        lQry := lQA.loja.objeto.conexaoLoja.criaIfaceQuery;

        lQry.objeto.SQL.Clear;
        lQry.objeto.SQL.Add(lSQL);
        setParams(lQry.objeto, pClienteModel);

          {
            openQuery faz o OPEN simplesmente do objeto IFDQuery.
            Ao abrir, transfere os registros para uma memtable,
            na propriedade dataset: IDatasetSimples abaixo.
            Erros são reportados na propriedade lQA.resultado: IResultadoOperacao
          }
        lQA.openQuery(lQry);
      end;
    end;

  finally
  //Desabilitado a espera, mas comentado para exemplificação
    {
      for lQA in lAsyncList do
      begin
        lQA.espera;
        if(lQA.FDQuery=nil) or (lQA.FDQuery.objeto.Active=false) then continue;

        if(Result='') then
          Result := lQA.FDQuery.objeto.FieldByName('CODIGO_CLI').AsString;
      end;
    }
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
