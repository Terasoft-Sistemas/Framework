unit TEFModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TTEFModel = class;
  ITTEFModel=IObject<TTEFModel>;

  TTEFModel = class
  private
    [weak] mySelf: ITTEFModel;
    vIConexao : IConexao;
    FTEFsLista: IList<ITTEFModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FHORA_TRANSACAO_COMPROVANTE: Variant;
    FQUANTIDADE_PARCELAS: Variant;
    FSTATUS_TRANSACAOO: Variant;
    FIMPRESSAO: Variant;
    FTIMESTAMP_LOCAL: Variant;
    FTIPO_PARCELAMENTO: Variant;
    FCNPJ_CREDENCIADORA: Variant;
    FCONTASRECEBER_PARCELA: Variant;
    FDOCUMENTO_PESSOA: Variant;
    FTIPO_TRANSACAO: Variant;
    FPEDIDO_ID: Variant;
    FNSU_PARCELA: Variant;
    FCLIENTE_ID: Variant;
    FCONTACORRENTE_ID: Variant;
    FMOEDA: Variant;
    FNOME_REDE: Variant;
    FID: Variant;
    FCODIGO_CREDENCIADORA: Variant;
    FCODIGO_AUTORIZACAO: Variant;
    FAUTORIZACAO: Variant;
    FCAIXA_ID: Variant;
    FSTATUS: Variant;
    FVALORTOTAL: Variant;
    FDATA_VENCIMENTO_PARCELA: Variant;
    FSYSTIME: Variant;
    FTIPO_PESSOA: Variant;
    FRETORNO_COMPLETO: Variant;
    FTIMESTAMP_CANCELAMENTO: Variant;
    FDATA_TRANSACAO_COMPROVANTE: Variant;
    FVALOR_PARCELA: Variant;
    FNUMERO_LOTE: Variant;
    FDOCUMENTO_FISCAL_VINCULADO: Variant;
    FCHAMADA: Variant;
    FCONTASRECEBER_FATURA: Variant;
    FNOME_ADMINISTRADORA: Variant;
    FMSU: Variant;
    FDATA: Variant;
    FNSU_CANCELAMENTO: Variant;
    FPARCELA: Variant;
    FTIMESTAMP_HOST: Variant;
    FIDRecordView: String;
    FMOTIVO_CANCELAMENTO: Variant;
    FPARCELAS_BAIXADAS: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetTEFsLista(const Value: IList<ITTEFModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetAUTORIZACAO(const Value: Variant);
    procedure SetCAIXA_ID(const Value: Variant);
    procedure SetCHAMADA(const Value: Variant);
    procedure SetCLIENTE_ID(const Value: Variant);
    procedure SetCNPJ_CREDENCIADORA(const Value: Variant);
    procedure SetCODIGO_AUTORIZACAO(const Value: Variant);
    procedure SetCODIGO_CREDENCIADORA(const Value: Variant);
    procedure SetCONTACORRENTE_ID(const Value: Variant);
    procedure SetCONTASRECEBER_FATURA(const Value: Variant);
    procedure SetCONTASRECEBER_PARCELA(const Value: Variant);
    procedure SetDATA(const Value: Variant);
    procedure SetDATA_TRANSACAO_COMPROVANTE(const Value: Variant);
    procedure SetDATA_VENCIMENTO_PARCELA(const Value: Variant);
    procedure SetDOCUMENTO_FISCAL_VINCULADO(const Value: Variant);
    procedure SetDOCUMENTO_PESSOA(const Value: Variant);
    procedure SetHORA_TRANSACAO_COMPROVANTE(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIMPRESSAO(const Value: Variant);
    procedure SetMOEDA(const Value: Variant);
    procedure SetMSU(const Value: Variant);
    procedure SetNOME_ADMINISTRADORA(const Value: Variant);
    procedure SetNOME_REDE(const Value: Variant);
    procedure SetNSU_CANCELAMENTO(const Value: Variant);
    procedure SetNSU_PARCELA(const Value: Variant);
    procedure SetNUMERO_LOTE(const Value: Variant);
    procedure SetPARCELA(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetQUANTIDADE_PARCELAS(const Value: Variant);
    procedure SetRETORNO_COMPLETO(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSTATUS_TRANSACAOO(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIMESTAMP_CANCELAMENTO(const Value: Variant);
    procedure SetTIMESTAMP_HOST(const Value: Variant);
    procedure SetTIMESTAMP_LOCAL(const Value: Variant);
    procedure SetTIPO_PARCELAMENTO(const Value: Variant);
    procedure SetTIPO_PESSOA(const Value: Variant);
    procedure SetTIPO_TRANSACAO(const Value: Variant);
    procedure SetVALOR_PARCELA(const Value: Variant);
    procedure SetVALORTOTAL(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetMOTIVO_CANCELAMENTO(const Value: Variant);
    procedure SetPARCELAS_BAIXADAS(const Value: String);
  public
    property ID: Variant read FID write SetID;
    property NOME_REDE: Variant read FNOME_REDE write SetNOME_REDE;
    property VALORTOTAL: Variant read FVALORTOTAL write SetVALORTOTAL;
    property TIPO_TRANSACAO: Variant read FTIPO_TRANSACAO write SetTIPO_TRANSACAO;
    property MSU: Variant read FMSU write SetMSU;
    property AUTORIZACAO: Variant read FAUTORIZACAO write SetAUTORIZACAO;
    property NUMERO_LOTE: Variant read FNUMERO_LOTE write SetNUMERO_LOTE;
    property TIMESTAMP_HOST: Variant read FTIMESTAMP_HOST write SetTIMESTAMP_HOST;
    property TIMESTAMP_LOCAL: Variant read FTIMESTAMP_LOCAL write SetTIMESTAMP_LOCAL;
    property DATA: Variant read FDATA write SetDATA;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property TIMESTAMP_CANCELAMENTO: Variant read FTIMESTAMP_CANCELAMENTO write SetTIMESTAMP_CANCELAMENTO;
    property DOCUMENTO_FISCAL_VINCULADO: Variant read FDOCUMENTO_FISCAL_VINCULADO write SetDOCUMENTO_FISCAL_VINCULADO;
    property MOEDA: Variant read FMOEDA write SetMOEDA;
    property TIPO_PESSOA: Variant read FTIPO_PESSOA write SetTIPO_PESSOA;
    property DOCUMENTO_PESSOA: Variant read FDOCUMENTO_PESSOA write SetDOCUMENTO_PESSOA;
    property STATUS_TRANSACAOO: Variant read FSTATUS_TRANSACAOO write SetSTATUS_TRANSACAOO;
    property NOME_ADMINISTRADORA: Variant read FNOME_ADMINISTRADORA write SetNOME_ADMINISTRADORA;
    property CODIGO_AUTORIZACAO: Variant read FCODIGO_AUTORIZACAO write SetCODIGO_AUTORIZACAO;
    property TIPO_PARCELAMENTO: Variant read FTIPO_PARCELAMENTO write SetTIPO_PARCELAMENTO;
    property QUANTIDADE_PARCELAS: Variant read FQUANTIDADE_PARCELAS write SetQUANTIDADE_PARCELAS;
    property PARCELA: Variant read FPARCELA write SetPARCELA;
    property DATA_VENCIMENTO_PARCELA: Variant read FDATA_VENCIMENTO_PARCELA write SetDATA_VENCIMENTO_PARCELA;
    property VALOR_PARCELA: Variant read FVALOR_PARCELA write SetVALOR_PARCELA;
    property NSU_PARCELA: Variant read FNSU_PARCELA write SetNSU_PARCELA;
    property DATA_TRANSACAO_COMPROVANTE: Variant read FDATA_TRANSACAO_COMPROVANTE write SetDATA_TRANSACAO_COMPROVANTE;
    property HORA_TRANSACAO_COMPROVANTE: Variant read FHORA_TRANSACAO_COMPROVANTE write SetHORA_TRANSACAO_COMPROVANTE;
    property NSU_CANCELAMENTO: Variant read FNSU_CANCELAMENTO write SetNSU_CANCELAMENTO;
    property CLIENTE_ID: Variant read FCLIENTE_ID write SetCLIENTE_ID;
    property CONTASRECEBER_FATURA: Variant read FCONTASRECEBER_FATURA write SetCONTASRECEBER_FATURA;
    property CONTASRECEBER_PARCELA: Variant read FCONTASRECEBER_PARCELA write SetCONTASRECEBER_PARCELA;
    property PEDIDO_ID: Variant read FPEDIDO_ID write SetPEDIDO_ID;
    property CAIXA_ID: Variant read FCAIXA_ID write SetCAIXA_ID;
    property CONTACORRENTE_ID: Variant read FCONTACORRENTE_ID write SetCONTACORRENTE_ID;
    property IMPRESSAO: Variant read FIMPRESSAO write SetIMPRESSAO;
    property RETORNO_COMPLETO: Variant read FRETORNO_COMPLETO write SetRETORNO_COMPLETO;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property CHAMADA: Variant read FCHAMADA write SetCHAMADA;
    property CNPJ_CREDENCIADORA: Variant read FCNPJ_CREDENCIADORA write SetCNPJ_CREDENCIADORA;
    property CODIGO_CREDENCIADORA: Variant read FCODIGO_CREDENCIADORA write SetCODIGO_CREDENCIADORA;
    property MOTIVO_CANCELAMENTO: Variant read FMOTIVO_CANCELAMENTO write SetMOTIVO_CANCELAMENTO;
    property PARCELAS_BAIXADAS: String read FPARCELAS_BAIXADAS write SetPARCELAS_BAIXADAS;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITTEFModel;

    function Salvar: String;
    procedure obterLista;

    function carregaClasse(pId: String): ITTEFModel;

    property TEFsLista: IList<ITTEFModel> read FTEFsLista write SetTEFsLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  TEFDao;

{ TTEFModel }

function TTEFModel.carregaClasse(pId: String): ITTEFModel;
var
  lTEFDao: ITTEFDao;
begin
  lTEFDao := TTEFDao.getNewIface(vIConexao);
  try
    Result := lTEFDao.objeto.carregaClasse(pId);
  finally
    lTEFDao:=nil;
  end;
end;

constructor TTEFModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTEFModel.Destroy;
begin
  FTEFsLista:=nil;
  vIConexao := nil;
  inherited;
end;

class function TTEFModel.getNewIface(pIConexao: IConexao): ITTEFModel;
begin
  Result := TImplObjetoOwner<TTEFModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TTEFModel.obterLista;
var
  lTEFLista: ITTEFDao;
begin
  lTEFLista := TTEFDao.getNewIface(vIConexao);

  try
    lTEFLista.objeto.TotalRecords    := FTotalRecords;
    lTEFLista.objeto.WhereView       := FWhereView;
    lTEFLista.objeto.CountView       := FCountView;
    lTEFLista.objeto.OrderView       := FOrderView;
    lTEFLista.objeto.StartRecordView := FStartRecordView;
    lTEFLista.objeto.LengthPageView  := FLengthPageView;
    lTEFLista.objeto.IDRecordView    := FIDRecordView;

    lTEFLista.objeto.obterLista;

    FTotalRecords  := lTEFLista.objeto.TotalRecords;
    FTEFsLista := lTEFLista.objeto.TEFsLista;

  finally
    lTEFLista:=nil;
  end;
end;

function TTEFModel.Salvar: String;
var
  lTEFDao: ITTEFDao;
begin
  lTEFDao := TTEFDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lTEFDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lTEFDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lTEFDao.objeto.excluir(mySelf);
    end;

  finally
    lTEFDao:=nil;
  end;
end;

procedure TTEFModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TTEFModel.SetAUTORIZACAO(const Value: Variant);
begin
  FAUTORIZACAO := Value;
end;

procedure TTEFModel.SetCAIXA_ID(const Value: Variant);
begin
  FCAIXA_ID := Value;
end;

procedure TTEFModel.SetCHAMADA(const Value: Variant);
begin
  FCHAMADA := Value;
end;

procedure TTEFModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TTEFModel.SetCNPJ_CREDENCIADORA(const Value: Variant);
begin
  FCNPJ_CREDENCIADORA := Value;
end;

procedure TTEFModel.SetCODIGO_AUTORIZACAO(const Value: Variant);
begin
  FCODIGO_AUTORIZACAO := Value;
end;

procedure TTEFModel.SetCODIGO_CREDENCIADORA(const Value: Variant);
begin
  FCODIGO_CREDENCIADORA := Value;
end;

procedure TTEFModel.SetCONTACORRENTE_ID(const Value: Variant);
begin
  FCONTACORRENTE_ID := Value;
end;

procedure TTEFModel.SetCONTASRECEBER_FATURA(const Value: Variant);
begin
  FCONTASRECEBER_FATURA := Value;
end;

procedure TTEFModel.SetCONTASRECEBER_PARCELA(const Value: Variant);
begin
  FCONTASRECEBER_PARCELA := Value;
end;

procedure TTEFModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTEFModel.SetDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TTEFModel.SetDATA_TRANSACAO_COMPROVANTE(const Value: Variant);
begin
  FDATA_TRANSACAO_COMPROVANTE := Value;
end;

procedure TTEFModel.SetDATA_VENCIMENTO_PARCELA(const Value: Variant);
begin
  FDATA_VENCIMENTO_PARCELA := Value;
end;

procedure TTEFModel.SetDOCUMENTO_FISCAL_VINCULADO(const Value: Variant);
begin
  FDOCUMENTO_FISCAL_VINCULADO := Value;
end;

procedure TTEFModel.SetDOCUMENTO_PESSOA(const Value: Variant);
begin
  FDOCUMENTO_PESSOA := Value;
end;

procedure TTEFModel.SetHORA_TRANSACAO_COMPROVANTE(const Value: Variant);
begin
  FHORA_TRANSACAO_COMPROVANTE := Value;
end;

procedure TTEFModel.SetTEFsLista;
begin
  FTEFsLista := Value;
end;

procedure TTEFModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTEFModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TTEFModel.SetTIMESTAMP_CANCELAMENTO(const Value: Variant);
begin
  FTIMESTAMP_CANCELAMENTO := Value;
end;

procedure TTEFModel.SetTIMESTAMP_HOST(const Value: Variant);
begin
  FTIMESTAMP_HOST := Value;
end;

procedure TTEFModel.SetTIMESTAMP_LOCAL(const Value: Variant);
begin
  FTIMESTAMP_LOCAL := Value;
end;

procedure TTEFModel.SetTIPO_PARCELAMENTO(const Value: Variant);
begin
  FTIPO_PARCELAMENTO := Value;
end;

procedure TTEFModel.SetTIPO_PESSOA(const Value: Variant);
begin
  FTIPO_PESSOA := Value;
end;

procedure TTEFModel.SetTIPO_TRANSACAO(const Value: Variant);
begin
  FTIPO_TRANSACAO := Value;
end;

procedure TTEFModel.SetIMPRESSAO(const Value: Variant);
begin
  FIMPRESSAO := Value;
end;

procedure TTEFModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTEFModel.SetMOEDA(const Value: Variant);
begin
  FMOEDA := Value;
end;

procedure TTEFModel.SetMOTIVO_CANCELAMENTO(const Value: Variant);
begin
  FMOTIVO_CANCELAMENTO := Value;
end;

procedure TTEFModel.SetMSU(const Value: Variant);
begin
  FMSU := Value;
end;

procedure TTEFModel.SetNOME_ADMINISTRADORA(const Value: Variant);
begin
  FNOME_ADMINISTRADORA := Value;
end;

procedure TTEFModel.SetNOME_REDE(const Value: Variant);
begin
  FNOME_REDE := Value;
end;

procedure TTEFModel.SetNSU_CANCELAMENTO(const Value: Variant);
begin
  FNSU_CANCELAMENTO := Value;
end;

procedure TTEFModel.SetNSU_PARCELA(const Value: Variant);
begin
  FNSU_PARCELA := Value;
end;

procedure TTEFModel.SetNUMERO_LOTE(const Value: Variant);
begin
  FNUMERO_LOTE := Value;
end;

procedure TTEFModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTEFModel.SetPARCELA(const Value: Variant);
begin
  FPARCELA := Value;
end;

procedure TTEFModel.SetPARCELAS_BAIXADAS(const Value: String);
begin
  FPARCELAS_BAIXADAS := Value;
end;

procedure TTEFModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TTEFModel.SetQUANTIDADE_PARCELAS(const Value: Variant);
begin
  FQUANTIDADE_PARCELAS := Value;
end;

procedure TTEFModel.SetRETORNO_COMPLETO(const Value: Variant);
begin
  FRETORNO_COMPLETO := Value;
end;

procedure TTEFModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTEFModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TTEFModel.SetSTATUS_TRANSACAOO(const Value: Variant);
begin
  FSTATUS_TRANSACAOO := Value;
end;

procedure TTEFModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TTEFModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTEFModel.SetVALORTOTAL(const Value: Variant);
begin
  FVALORTOTAL := Value;
end;

procedure TTEFModel.SetVALOR_PARCELA(const Value: Variant);
begin
  FVALOR_PARCELA := Value;
end;

procedure TTEFModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
