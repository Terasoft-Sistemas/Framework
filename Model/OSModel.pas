unit OSModel;

interface

uses
  Terasoft.Types,
  FireDAC.Comp.Client,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TOSModel = class;
  ITOSModel=IObject<TOSModel>;

  TOSModel = class
  private
    [weak] mySelf: ITOSModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FENTRADA_PORTADOR_ID: Variant;
    FDATA_FECHAMENTO_OLD: Variant;
    FNUMERO_OS: Variant;
    FQTDEPARCELA_OS: Variant;
    FMOTOR: Variant;
    FQTD_MSG: Variant;
    FCARGA_ID: Variant;
    FCOMISSAO_OS: Variant;
    FSTATUS_OS: Variant;
    FUSUARIO_FECHAMENTO_OS: Variant;
    FHORAORCA_OS: Variant;
    FLOG_OS: Variant;
    FSITUACAO_OS: Variant;
    FSOLUCAO_OS: Variant;
    FMANUTENCAO_OS: Variant;
    FVALORPECAS_OS: Variant;
    FCONTRATO_OTTO_ID: Variant;
    FHORAMANU_OS: Variant;
    FHORA_FECHAMENTO_OLD: Variant;
    FMARCA_OS: Variant;
    FAPROVACAO_OS: Variant;
    FDATAHORA_FIM: Variant;
    FDESC_OS: Variant;
    FUSUARIO_OS: Variant;
    FAUTORIZA_OS: Variant;
    FCNPJ_CPF_CONSUMIDOR: Variant;
    FTIPO_OS: Variant;
    FCODIGO_PRT: Variant;
    FTOTALPAGAR_OS: Variant;
    FRECLAMADO_OS: Variant;
    FTABJUROS_OS: Variant;
    FPROBLEMA_OS: Variant;
    FDATA_OS: Variant;
    FCODIGO_CLI: Variant;
    FID: Variant;
    FFONE_OS: Variant;
    FMAOOBRA_OS: Variant;
    FPRODUTO_OS: Variant;
    FANO: Variant;
    FHISTORICO_OS: Variant;
    FPREVISAO_OS: Variant;
    FNUMERO_NF: Variant;
    FLOJA: Variant;
    FCODIGO_TEC: Variant;
    FCONDICOES_PAG: Variant;
    FACRESCIMO_OS: Variant;
    FOBSERVACAO_OS: Variant;
    FDESCONTO_OS: Variant;
    FFATURA_ID: Variant;
    FVALORPARCELA_OS: Variant;
    FFECHAMENTO_OS: Variant;
    FSYSTIME: Variant;
    FSTATUS_ID: Variant;
    FORCAMENTO_OS: Variant;
    FKM_OS: Variant;
    FENTRADA_OS: Variant;
    FCODIGO_SIT: Variant;
    FHORA_OS: Variant;
    FDESLOCAMENTO_OS: Variant;
    FCODIGO_TIP: Variant;
    FNUMERO_NFSE: Variant;
    FHORAAPROVA_OS: Variant;
    FENTREGA_OS: Variant;
    FCTR_MSG: Variant;
    FPLACA: Variant;
    FDESCONTO_ADD: Variant;
    FORDEM: Variant;
    FCTR_IMPRESSAO_PED: Variant;
    FUSUARIOABERTURA_OS: Variant;
    FTOTAL_OS: Variant;
    FRESPONSAVEL_OS: Variant;
    FMODELO_OS: Variant;
    FDESCRICAOO_OS: Variant;
    FTRANSMISSAO: Variant;
    FDATAHORA_INI: Variant;
    FHORAENTREGA_OS: Variant;
    FPRIMEIROVEN_OS: Variant;
    FIDRecordView: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetACRESCIMO_OS(const Value: Variant);
    procedure SetANO(const Value: Variant);
    procedure SetAPROVACAO_OS(const Value: Variant);
    procedure SetAUTORIZA_OS(const Value: Variant);
    procedure SetCARGA_ID(const Value: Variant);
    procedure SetCNPJ_CPF_CONSUMIDOR(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCODIGO_PRT(const Value: Variant);
    procedure SetCODIGO_SIT(const Value: Variant);
    procedure SetCODIGO_TEC(const Value: Variant);
    procedure SetCODIGO_TIP(const Value: Variant);
    procedure SetCOMISSAO_OS(const Value: Variant);
    procedure SetCONDICOES_PAG(const Value: Variant);
    procedure SetCONTRATO_OTTO_ID(const Value: Variant);
    procedure SetCTR_IMPRESSAO_PED(const Value: Variant);
    procedure SetCTR_MSG(const Value: Variant);
    procedure SetDATA_FECHAMENTO_OLD(const Value: Variant);
    procedure SetDATA_OS(const Value: Variant);
    procedure SetDATAHORA_FIM(const Value: Variant);
    procedure SetDATAHORA_INI(const Value: Variant);
    procedure SetDESC_OS(const Value: Variant);
    procedure SetDESCONTO_ADD(const Value: Variant);
    procedure SetDESCONTO_OS(const Value: Variant);
    procedure SetDESCRICAOO_OS(const Value: Variant);
    procedure SetDESLOCAMENTO_OS(const Value: Variant);
    procedure SetENTRADA_OS(const Value: Variant);
    procedure SetENTRADA_PORTADOR_ID(const Value: Variant);
    procedure SetENTREGA_OS(const Value: Variant);
    procedure SetFATURA_ID(const Value: Variant);
    procedure SetFECHAMENTO_OS(const Value: Variant);
    procedure SetFONE_OS(const Value: Variant);
    procedure SetHISTORICO_OS(const Value: Variant);
    procedure SetHORA_FECHAMENTO_OLD(const Value: Variant);
    procedure SetHORA_OS(const Value: Variant);
    procedure SetHORAAPROVA_OS(const Value: Variant);
    procedure SetHORAENTREGA_OS(const Value: Variant);
    procedure SetHORAMANU_OS(const Value: Variant);
    procedure SetHORAORCA_OS(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetKM_OS(const Value: Variant);
    procedure SetLOG_OS(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetMANUTENCAO_OS(const Value: Variant);
    procedure SetMAOOBRA_OS(const Value: Variant);
    procedure SetMARCA_OS(const Value: Variant);
    procedure SetMODELO_OS(const Value: Variant);
    procedure SetMOTOR(const Value: Variant);
    procedure SetNUMERO_NF(const Value: Variant);
    procedure SetNUMERO_NFSE(const Value: Variant);
    procedure SetNUMERO_OS(const Value: Variant);
    procedure SetOBSERVACAO_OS(const Value: Variant);
    procedure SetORCAMENTO_OS(const Value: Variant);
    procedure SetORDEM(const Value: Variant);
    procedure SetPLACA(const Value: Variant);
    procedure SetPREVISAO_OS(const Value: Variant);
    procedure SetPRIMEIROVEN_OS(const Value: Variant);
    procedure SetPROBLEMA_OS(const Value: Variant);
    procedure SetPRODUTO_OS(const Value: Variant);
    procedure SetQTD_MSG(const Value: Variant);
    procedure SetQTDEPARCELA_OS(const Value: Variant);
    procedure SetRECLAMADO_OS(const Value: Variant);
    procedure SetRESPONSAVEL_OS(const Value: Variant);
    procedure SetSITUACAO_OS(const Value: Variant);
    procedure SetSOLUCAO_OS(const Value: Variant);
    procedure SetSTATUS_ID(const Value: Variant);
    procedure SetSTATUS_OS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTABJUROS_OS(const Value: Variant);
    procedure SetTIPO_OS(const Value: Variant);
    procedure SetTOTAL_OS(const Value: Variant);
    procedure SetTOTALPAGAR_OS(const Value: Variant);
    procedure SetTRANSMISSAO(const Value: Variant);
    procedure SetUSUARIO_FECHAMENTO_OS(const Value: Variant);
    procedure SetUSUARIO_OS(const Value: Variant);
    procedure SetUSUARIOABERTURA_OS(const Value: Variant);
    procedure SetVALORPARCELA_OS(const Value: Variant);
    procedure SetVALORPECAS_OS(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
        
  public
    property NUMERO_OS                : Variant read FNUMERO_OS write SetNUMERO_OS;
    property CODIGO_CLI               : Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property DATA_OS                  : Variant read FDATA_OS write SetDATA_OS;
    property ORCAMENTO_OS             : Variant read FORCAMENTO_OS write SetORCAMENTO_OS;
    property APROVACAO_OS             : Variant read FAPROVACAO_OS write SetAPROVACAO_OS;
    property MANUTENCAO_OS            : Variant read FMANUTENCAO_OS write SetMANUTENCAO_OS;
    property FECHAMENTO_OS            : Variant read FFECHAMENTO_OS write SetFECHAMENTO_OS;
    property ENTREGA_OS               : Variant read FENTREGA_OS write SetENTREGA_OS;
    property PREVISAO_OS              : Variant read FPREVISAO_OS write SetPREVISAO_OS;
    property RESPONSAVEL_OS           : Variant read FRESPONSAVEL_OS write SetRESPONSAVEL_OS;
    property VALORPECAS_OS            : Variant read FVALORPECAS_OS write SetVALORPECAS_OS;
    property DESLOCAMENTO_OS          : Variant read FDESLOCAMENTO_OS write SetDESLOCAMENTO_OS;
    property TOTAL_OS                 : Variant read FTOTAL_OS write SetTOTAL_OS;
    property DESCONTO_OS              : Variant read FDESCONTO_OS write SetDESCONTO_OS;
    property OBSERVACAO_OS            : Variant read FOBSERVACAO_OS write SetOBSERVACAO_OS;
    property RECLAMADO_OS             : Variant read FRECLAMADO_OS write SetRECLAMADO_OS;
    property PROBLEMA_OS              : Variant read FPROBLEMA_OS write SetPROBLEMA_OS;
    property SOLUCAO_OS               : Variant read FSOLUCAO_OS write SetSOLUCAO_OS;
    property AUTORIZA_OS              : Variant read FAUTORIZA_OS write SetAUTORIZA_OS;
    property HORA_OS                  : Variant read FHORA_OS write SetHORA_OS;
    property CODIGO_TEC               : Variant read FCODIGO_TEC write SetCODIGO_TEC;
    property CODIGO_SIT               : Variant read FCODIGO_SIT write SetCODIGO_SIT;
    property PRODUTO_OS               : Variant read FPRODUTO_OS write SetPRODUTO_OS;
    property PRIMEIROVEN_OS           : Variant read FPRIMEIROVEN_OS write SetPRIMEIROVEN_OS;
    property QTDEPARCELA_OS           : Variant read FQTDEPARCELA_OS write SetQTDEPARCELA_OS;
    property HORAORCA_OS              : Variant read FHORAORCA_OS write SetHORAORCA_OS;
    property HORAAPROVA_OS            : Variant read FHORAAPROVA_OS write SetHORAAPROVA_OS;
    property HORAMANU_OS              : Variant read FHORAMANU_OS write SetHORAMANU_OS;
    property HORAENTREGA_OS           : Variant read FHORAENTREGA_OS write SetHORAENTREGA_OS;
    property USUARIO_OS               : Variant read FUSUARIO_OS write SetUSUARIO_OS;
    property CODIGO_TIP               : Variant read FCODIGO_TIP write SetCODIGO_TIP;
    property DESCRICAOO_OS            : Variant read FDESCRICAOO_OS write SetDESCRICAOO_OS;
    property MODELO_OS                : Variant read FMODELO_OS write SetMODELO_OS;
    property MARCA_OS                 : Variant read FMARCA_OS write SetMARCA_OS;
    property MAOOBRA_OS               : Variant read FMAOOBRA_OS write SetMAOOBRA_OS;
    property USUARIOABERTURA_OS       : Variant read FUSUARIOABERTURA_OS write SetUSUARIOABERTURA_OS;
    property STATUS_OS                : Variant read FSTATUS_OS write SetSTATUS_OS;
    property FONE_OS                  : Variant read FFONE_OS write SetFONE_OS;
    property ENTRADA_OS               : Variant read FENTRADA_OS write SetENTRADA_OS;
    property ACRESCIMO_OS             : Variant read FACRESCIMO_OS write SetACRESCIMO_OS;
    property VALORPARCELA_OS          : Variant read FVALORPARCELA_OS write SetVALORPARCELA_OS;
    property CODIGO_PRT               : Variant read FCODIGO_PRT write SetCODIGO_PRT;
    property TIPO_OS                  : Variant read FTIPO_OS write SetTIPO_OS;
    property TOTALPAGAR_OS            : Variant read FTOTALPAGAR_OS write SetTOTALPAGAR_OS;
    property COMISSAO_OS              : Variant read FCOMISSAO_OS write SetCOMISSAO_OS;
    property SITUACAO_OS              : Variant read FSITUACAO_OS write SetSITUACAO_OS;
    property TABJUROS_OS              : Variant read FTABJUROS_OS write SetTABJUROS_OS;
    property CTR_IMPRESSAO_PED        : Variant read FCTR_IMPRESSAO_PED write SetCTR_IMPRESSAO_PED;
    property LOJA                     : Variant read FLOJA write SetLOJA;
    property DESC_OS                  : Variant read FDESC_OS write SetDESC_OS;
    property HISTORICO_OS             : Variant read FHISTORICO_OS write SetHISTORICO_OS;
    property USUARIO_FECHAMENTO_OS    : Variant read FUSUARIO_FECHAMENTO_OS write SetUSUARIO_FECHAMENTO_OS;
    property LOG_OS                   : Variant read FLOG_OS write SetLOG_OS;
    property KM_OS                    : Variant read FKM_OS write SetKM_OS;
    property PLACA                    : Variant read FPLACA write SetPLACA;
    property ID                       : Variant read FID write SetID;
    property DESCONTO_ADD             : Variant read FDESCONTO_ADD write SetDESCONTO_ADD;
    property DATAHORA_INI             : Variant read FDATAHORA_INI write SetDATAHORA_INI;
    property DATAHORA_FIM             : Variant read FDATAHORA_FIM write SetDATAHORA_FIM;
    property STATUS_ID                : Variant read FSTATUS_ID write SetSTATUS_ID;
    property CARGA_ID                 : Variant read FCARGA_ID write SetCARGA_ID;
    property ORDEM                    : Variant read FORDEM write SetORDEM;
    property NUMERO_NF                : Variant read FNUMERO_NF write SetNUMERO_NF;
    property ANO                      : Variant read FANO write SetANO;
    property FATURA_ID                : Variant read FFATURA_ID write SetFATURA_ID;
    property DATA_FECHAMENTO_OLD      : Variant read FDATA_FECHAMENTO_OLD write SetDATA_FECHAMENTO_OLD;
    property HORA_FECHAMENTO_OLD      : Variant read FHORA_FECHAMENTO_OLD write SetHORA_FECHAMENTO_OLD;
    property CNPJ_CPF_CONSUMIDOR      : Variant read FCNPJ_CPF_CONSUMIDOR write SetCNPJ_CPF_CONSUMIDOR;
    property ENTRADA_PORTADOR_ID      : Variant read FENTRADA_PORTADOR_ID write SetENTRADA_PORTADOR_ID;
    property NUMERO_NFSE              : Variant read FNUMERO_NFSE write SetNUMERO_NFSE;
    property CONTRATO_OTTO_ID         : Variant read FCONTRATO_OTTO_ID write SetCONTRATO_OTTO_ID;
    property SYSTIME                  : Variant read FSYSTIME write SetSYSTIME;
    property CTR_MSG                  : Variant read FCTR_MSG write SetCTR_MSG;
    property QTD_MSG                  : Variant read FQTD_MSG write SetQTD_MSG;
    property CONDICOES_PAG            : Variant read FCONDICOES_PAG write SetCONDICOES_PAG;
    property MOTOR                    : Variant read FMOTOR write SetMOTOR;
    property TRANSMISSAO              : Variant read FTRANSMISSAO write SetTRANSMISSAO;


    property Acao               : TAcao       read FAcao               write SetAcao;
    property TotalRecords       : Integer     read FTotalRecords       write SetTotalRecords;
    property WhereView          : String      read FWhereView          write SetWhereView;
    property CountView          : String      read FCountView          write SetCountView;
    property OrderView          : String      read FOrderView          write SetOrderView;
    property StartRecordView    : String      read FStartRecordView    write SetStartRecordView;
    property LengthPageView     : String      read FLengthPageView     write SetLengthPageView;
    property IDRecordView       : String read FIDRecordView write SetIDRecordView;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITOSModel;

    function Incluir: String;
    function Alterar(pID : String): ITOSModel;
    function Excluir(pID : String): String;

    function carregaClasse(pId : String): ITOSModel;

    function Salvar: String;
    function obterLista: IFDDataset;

  end;

implementation

uses
  OSDao;

{ TOSModel }

function TOSModel.Alterar(pID: String): ITOSModel;
var
  lOSModel : ITOSModel;
begin
  lOSModel := TOSModel.getNewIface(vIConexao);
  try
    lOSModel       := lOSModel.objeto.carregaClasse(pID);
    lOSModel.objeto.Acao  := tacAlterar;
    Result         := lOSModel;
  finally
  end
end;

function TOSModel.carregaClasse(pId: String): ITOSModel;
var
  lOSDao: ITOSDao;
begin
  lOSDao := TOSDao.getNewIface(vIConexao);

  try
    Result := lOSDao.objeto.carregaClasse(pId);
  finally
    lOSDao:=nil;
  end;
end;

constructor TOSModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TOSModel.Destroy;
begin

  inherited;
end;

function TOSModel.Excluir(pID: String): String;
begin

  if self.STATUS_OS = 'F' then
    CriaException('Os já finalizada');

  self.NUMERO_OS  := pID;
  self.FAcao      := tacExcluir;
  Result          := self.Salvar;
end;

class function TOSModel.getNewIface(pIConexao: IConexao): ITOSModel;
begin
  Result := TImplObjetoOwner<TOSModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TOSModel.Incluir: String;
begin
   self.Acao := tacIncluir;
   Result    := self.Salvar;
end;

function TOSModel.obterLista: IFDDataset;
var
  lOSLista: ITOSDao;
begin
  lOSLista := TOSDao.getNewIface(vIConexao);
  try
    lOSLista.objeto.TotalRecords    := FTotalRecords;
    lOSLista.objeto.WhereView       := FWhereView;
    lOSLista.objeto.CountView       := FCountView;
    lOSLista.objeto.OrderView       := FOrderView;
    lOSLista.objeto.StartRecordView := FStartRecordView;
    lOSLista.objeto.LengthPageView  := FLengthPageView;
    lOSLista.objeto.IDRecordView    := FIDRecordView;

    Result        := lOSLista.objeto.obterLista;
    FTotalRecords := lOSLista.objeto.TotalRecords;
  finally
    lOSLista:=nil;
  end;
end;

function TOSModel.Salvar: String;
var
  lOSDao: ITOSDao;
begin
  lOSDao := TOSDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lOSDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lOSDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lOSDao.objeto.excluir(mySelf);
    end;

  finally
    lOSDao:=nil;
  end;
end;

procedure TOSModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TOSModel.SetACRESCIMO_OS(const Value: Variant);
begin
  FACRESCIMO_OS := Value;
end;

procedure TOSModel.SetANO(const Value: Variant);
begin
  FANO := Value;
end;

procedure TOSModel.SetAPROVACAO_OS(const Value: Variant);
begin
  FAPROVACAO_OS := Value;
end;

procedure TOSModel.SetAUTORIZA_OS(const Value: Variant);
begin
  FAUTORIZA_OS := Value;
end;

procedure TOSModel.SetCARGA_ID(const Value: Variant);
begin
  FCARGA_ID := Value;
end;

procedure TOSModel.SetCNPJ_CPF_CONSUMIDOR(const Value: Variant);
begin
  FCNPJ_CPF_CONSUMIDOR := Value;
end;

procedure TOSModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TOSModel.SetCODIGO_PRT(const Value: Variant);
begin
  FCODIGO_PRT := Value;
end;

procedure TOSModel.SetCODIGO_SIT(const Value: Variant);
begin
  FCODIGO_SIT := Value;
end;

procedure TOSModel.SetCODIGO_TEC(const Value: Variant);
begin
  FCODIGO_TEC := Value;
end;

procedure TOSModel.SetCODIGO_TIP(const Value: Variant);
begin
  FCODIGO_TIP := Value;
end;

procedure TOSModel.SetCOMISSAO_OS(const Value: Variant);
begin
  FCOMISSAO_OS := Value;
end;

procedure TOSModel.SetCONDICOES_PAG(const Value: Variant);
begin
  FCONDICOES_PAG := Value;
end;

procedure TOSModel.SetCONTRATO_OTTO_ID(const Value: Variant);
begin
  FCONTRATO_OTTO_ID := Value;
end;

procedure TOSModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TOSModel.SetCTR_IMPRESSAO_PED(const Value: Variant);
begin
  FCTR_IMPRESSAO_PED := Value;
end;

procedure TOSModel.SetCTR_MSG(const Value: Variant);
begin
  FCTR_MSG := Value;
end;

procedure TOSModel.SetDATAHORA_FIM(const Value: Variant);
begin
  FDATAHORA_FIM := Value;
end;

procedure TOSModel.SetDATAHORA_INI(const Value: Variant);
begin
  FDATAHORA_INI := Value;
end;

procedure TOSModel.SetDATA_FECHAMENTO_OLD(const Value: Variant);
begin
  FDATA_FECHAMENTO_OLD := Value;
end;

procedure TOSModel.SetDATA_OS(const Value: Variant);
begin
  FDATA_OS := Value;
end;

procedure TOSModel.SetDESCONTO_ADD(const Value: Variant);
begin
  FDESCONTO_ADD := Value;
end;

procedure TOSModel.SetDESCONTO_OS(const Value: Variant);
begin
  FDESCONTO_OS := Value;
end;

procedure TOSModel.SetDESCRICAOO_OS(const Value: Variant);
begin
  FDESCRICAOO_OS := Value;
end;

procedure TOSModel.SetDESC_OS(const Value: Variant);
begin
  FDESC_OS := Value;
end;

procedure TOSModel.SetDESLOCAMENTO_OS(const Value: Variant);
begin
  FDESLOCAMENTO_OS := Value;
end;

procedure TOSModel.SetENTRADA_OS(const Value: Variant);
begin
  FENTRADA_OS := Value;
end;

procedure TOSModel.SetENTRADA_PORTADOR_ID(const Value: Variant);
begin
  FENTRADA_PORTADOR_ID := Value;
end;

procedure TOSModel.SetENTREGA_OS(const Value: Variant);
begin
  FENTREGA_OS := Value;
end;

procedure TOSModel.SetFATURA_ID(const Value: Variant);
begin
  FFATURA_ID := Value;
end;

procedure TOSModel.SetFECHAMENTO_OS(const Value: Variant);
begin
  FFECHAMENTO_OS := Value;
end;

procedure TOSModel.SetFONE_OS(const Value: Variant);
begin
  FFONE_OS := Value;
end;

procedure TOSModel.SetHISTORICO_OS(const Value: Variant);
begin
  FHISTORICO_OS := Value;
end;

procedure TOSModel.SetHORAAPROVA_OS(const Value: Variant);
begin
  FHORAAPROVA_OS := Value;
end;

procedure TOSModel.SetHORAENTREGA_OS(const Value: Variant);
begin
  FHORAENTREGA_OS := Value;
end;

procedure TOSModel.SetHORAMANU_OS(const Value: Variant);
begin
  FHORAMANU_OS := Value;
end;

procedure TOSModel.SetHORAORCA_OS(const Value: Variant);
begin
  FHORAORCA_OS := Value;
end;

procedure TOSModel.SetHORA_FECHAMENTO_OLD(const Value: Variant);
begin
  FHORA_FECHAMENTO_OLD := Value;
end;

procedure TOSModel.SetHORA_OS(const Value: Variant);
begin
  FHORA_OS := Value;
end;

procedure TOSModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TOSModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TOSModel.SetKM_OS(const Value: Variant);
begin
  FKM_OS := Value;
end;

procedure TOSModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TOSModel.SetLOG_OS(const Value: Variant);
begin
  FLOG_OS := Value;
end;

procedure TOSModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TOSModel.SetMANUTENCAO_OS(const Value: Variant);
begin
  FMANUTENCAO_OS := Value;
end;

procedure TOSModel.SetMAOOBRA_OS(const Value: Variant);
begin
  FMAOOBRA_OS := Value;
end;

procedure TOSModel.SetMARCA_OS(const Value: Variant);
begin
  FMARCA_OS := Value;
end;

procedure TOSModel.SetMODELO_OS(const Value: Variant);
begin
  FMODELO_OS := Value;
end;

procedure TOSModel.SetMOTOR(const Value: Variant);
begin
  FMOTOR := Value;
end;

procedure TOSModel.SetNUMERO_NF(const Value: Variant);
begin
  FNUMERO_NF := Value;
end;

procedure TOSModel.SetNUMERO_NFSE(const Value: Variant);
begin
  FNUMERO_NFSE := Value;
end;

procedure TOSModel.SetNUMERO_OS(const Value: Variant);
begin
  FNUMERO_OS := Value;
end;

procedure TOSModel.SetOBSERVACAO_OS(const Value: Variant);
begin
  FOBSERVACAO_OS := Value;
end;

procedure TOSModel.SetORCAMENTO_OS(const Value: Variant);
begin
  FORCAMENTO_OS := Value;
end;

procedure TOSModel.SetORDEM(const Value: Variant);
begin
  FORDEM := Value;
end;

procedure TOSModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TOSModel.SetPLACA(const Value: Variant);
begin
  FPLACA := Value;
end;

procedure TOSModel.SetPREVISAO_OS(const Value: Variant);
begin
  FPREVISAO_OS := Value;
end;

procedure TOSModel.SetPRIMEIROVEN_OS(const Value: Variant);
begin
  FPRIMEIROVEN_OS := Value;
end;

procedure TOSModel.SetPROBLEMA_OS(const Value: Variant);
begin
  FPROBLEMA_OS := Value;
end;

procedure TOSModel.SetPRODUTO_OS(const Value: Variant);
begin
  FPRODUTO_OS := Value;
end;

procedure TOSModel.SetQTDEPARCELA_OS(const Value: Variant);
begin
  FQTDEPARCELA_OS := Value;
end;

procedure TOSModel.SetQTD_MSG(const Value: Variant);
begin
  FQTD_MSG := Value;
end;

procedure TOSModel.SetRECLAMADO_OS(const Value: Variant);
begin
  FRECLAMADO_OS := Value;
end;

procedure TOSModel.SetRESPONSAVEL_OS(const Value: Variant);
begin
  FRESPONSAVEL_OS := Value;
end;

procedure TOSModel.SetSITUACAO_OS(const Value: Variant);
begin
  FSITUACAO_OS := Value;
end;

procedure TOSModel.SetSOLUCAO_OS(const Value: Variant);
begin
  FSOLUCAO_OS := Value;
end;

procedure TOSModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TOSModel.SetSTATUS_ID(const Value: Variant);
begin
  FSTATUS_ID := Value;
end;

procedure TOSModel.SetSTATUS_OS(const Value: Variant);
begin
  FSTATUS_OS := Value;
end;

procedure TOSModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TOSModel.SetTABJUROS_OS(const Value: Variant);
begin
  FTABJUROS_OS := Value;
end;

procedure TOSModel.SetTIPO_OS(const Value: Variant);
begin
  FTIPO_OS := Value;
end;

procedure TOSModel.SetTOTALPAGAR_OS(const Value: Variant);
begin
  FTOTALPAGAR_OS := Value;
end;

procedure TOSModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TOSModel.SetTOTAL_OS(const Value: Variant);
begin
  FTOTAL_OS := Value;
end;

procedure TOSModel.SetTRANSMISSAO(const Value: Variant);
begin
  FTRANSMISSAO := Value;
end;

procedure TOSModel.SetUSUARIOABERTURA_OS(const Value: Variant);
begin
  FUSUARIOABERTURA_OS := Value;
end;

procedure TOSModel.SetUSUARIO_FECHAMENTO_OS(const Value: Variant);
begin
  FUSUARIO_FECHAMENTO_OS := Value;
end;

procedure TOSModel.SetUSUARIO_OS(const Value: Variant);
begin
  FUSUARIO_OS := Value;
end;

procedure TOSModel.SetVALORPARCELA_OS(const Value: Variant);
begin
  FVALORPARCELA_OS := Value;
end;

procedure TOSModel.SetVALORPECAS_OS(const Value: Variant);
begin
  FVALORPECAS_OS := Value;
end;

procedure TOSModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
