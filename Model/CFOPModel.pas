unit CFOPModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Interfaces.Conexao;

type
  TCFOPModel = class

  private
    vIConexao : IConexao;

    FCFOPsLista: IList<TCFOPModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FMOTDESICMS: Variant;
    FSOMAR_ICMS_TOTAL_NF: Variant;
    FOPERACAO: Variant;
    FOBS: Variant;
    FAPROVEITAMENTO_ICMS: Variant;
    FCST_PIS: Variant;
    FALIQUOTA_IPI: Variant;
    FCST_COFINS: Variant;
    FVALOR: Variant;
    FSOMAR_PIS_COFINS_EM_OUTRAS: Variant;
    FPREDBC_N14: Variant;
    FICMS: Variant;
    FDESCRICAO: Variant;
    FESTOQUE: Variant;
    FLISTAR_IPI_SPED: Variant;
    FCST_IPI: Variant;
    FALTERA_CUSTO: Variant;
    FCONTA_CONTABIL: Variant;
    FID: Variant;
    FDESCONTO_SOBRE_IPI: Variant;
    FCFOP: Variant;
    FSTATUS: Variant;
    FCENQ: Variant;
    FCONSIGNADO: Variant;
    FPIS: Variant;
    FPCRED_PRESUMIDO: Variant;
    FCOFINS: Variant;
    FSYSTIME: Variant;
    FCFOP_DEVOLUCAO: Variant;
    FCST_ENTRADA: Variant;
    FESTOQUE_2: Variant;
    FDESCONTO_ICMS_BASE_PIS_COFINS: Variant;
    FCBENEF: Variant;
    FOUTRAS_DESPESAS_ENTRADA: Variant;
    FDESCONTO_SOBRE_ICMS: Variant;
    FSOMAR_IPI_BASE_ICMS: Variant;
    FALIQUOTA_PIS: Variant;
    FALIQUOTA_COFINS: Variant;
    FTIPO: Variant;
    FRESERVADO_FISCO: Variant;
    FCST: Variant;
    FREDUCAO_APROVEITAMENTO_ICMS: Variant;
    FCFOP_REFERENCIA: Variant;
    FIBPT: Variant;
    FCSOSN: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetCFOPsLista(const Value: IList<TCFOPModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetALIQUOTA_COFINS(const Value: Variant);
    procedure SetALIQUOTA_IPI(const Value: Variant);
    procedure SetALIQUOTA_PIS(const Value: Variant);
    procedure SetALTERA_CUSTO(const Value: Variant);
    procedure SetAPROVEITAMENTO_ICMS(const Value: Variant);
    procedure SetCBENEF(const Value: Variant);
    procedure SetCENQ(const Value: Variant);
    procedure SetCFOP(const Value: Variant);
    procedure SetCFOP_DEVOLUCAO(const Value: Variant);
    procedure SetCFOP_REFERENCIA(const Value: Variant);
    procedure SetCOFINS(const Value: Variant);
    procedure SetCONSIGNADO(const Value: Variant);
    procedure SetCONTA_CONTABIL(const Value: Variant);
    procedure SetCSOSN(const Value: Variant);
    procedure SetCST(const Value: Variant);
    procedure SetCST_COFINS(const Value: Variant);
    procedure SetCST_ENTRADA(const Value: Variant);
    procedure SetCST_IPI(const Value: Variant);
    procedure SetCST_PIS(const Value: Variant);
    procedure SetDESCONTO_ICMS_BASE_PIS_COFINS(const Value: Variant);
    procedure SetDESCONTO_SOBRE_ICMS(const Value: Variant);
    procedure SetDESCONTO_SOBRE_IPI(const Value: Variant);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetESTOQUE(const Value: Variant);
    procedure SetESTOQUE_2(const Value: Variant);
    procedure SetIBPT(const Value: Variant);
    procedure SetICMS(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLISTAR_IPI_SPED(const Value: Variant);
    procedure SetMOTDESICMS(const Value: Variant);
    procedure SetOBS(const Value: Variant);
    procedure SetOPERACAO(const Value: Variant);
    procedure SetOUTRAS_DESPESAS_ENTRADA(const Value: Variant);
    procedure SetPCRED_PRESUMIDO(const Value: Variant);
    procedure SetPIS(const Value: Variant);
    procedure SetPREDBC_N14(const Value: Variant);
    procedure SetREDUCAO_APROVEITAMENTO_ICMS(const Value: Variant);
    procedure SetRESERVADO_FISCO(const Value: Variant);
    procedure SetSOMAR_ICMS_TOTAL_NF(const Value: Variant);
    procedure SetSOMAR_IPI_BASE_ICMS(const Value: Variant);
    procedure SetSOMAR_PIS_COFINS_EM_OUTRAS(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetVALOR(const Value: Variant);
  public
    property ID: Variant read FID write SetID;
    property CFOP: Variant read FCFOP write SetCFOP;
    property DESCRICAO: Variant read FDESCRICAO write SetDESCRICAO;
    property TIPO: Variant read FTIPO write SetTIPO;
    property ESTOQUE: Variant read FESTOQUE write SetESTOQUE;
    property ICMS: Variant read FICMS write SetICMS;
    property CST: Variant read FCST write SetCST;
    property OBS: Variant read FOBS write SetOBS;
    property PIS: Variant read FPIS write SetPIS;
    property COFINS: Variant read FCOFINS write SetCOFINS;
    property VALOR: Variant read FVALOR write SetVALOR;
    property CONSIGNADO: Variant read FCONSIGNADO write SetCONSIGNADO;
    property CSOSN: Variant read FCSOSN write SetCSOSN;
    property CFOP_REFERENCIA: Variant read FCFOP_REFERENCIA write SetCFOP_REFERENCIA;
    property CONTA_CONTABIL: Variant read FCONTA_CONTABIL write SetCONTA_CONTABIL;
    property CST_ENTRADA: Variant read FCST_ENTRADA write SetCST_ENTRADA;
    property RESERVADO_FISCO: Variant read FRESERVADO_FISCO write SetRESERVADO_FISCO;
    property ALTERA_CUSTO: Variant read FALTERA_CUSTO write SetALTERA_CUSTO;
    property IBPT: Variant read FIBPT write SetIBPT;
    property OPERACAO: Variant read FOPERACAO write SetOPERACAO;
    property ESTOQUE_2: Variant read FESTOQUE_2 write SetESTOQUE_2;
    property CST_PIS: Variant read FCST_PIS write SetCST_PIS;
    property CST_COFINS: Variant read FCST_COFINS write SetCST_COFINS;
    property CST_IPI: Variant read FCST_IPI write SetCST_IPI;
    property ALIQUOTA_PIS: Variant read FALIQUOTA_PIS write SetALIQUOTA_PIS;
    property ALIQUOTA_COFINS: Variant read FALIQUOTA_COFINS write SetALIQUOTA_COFINS;
    property ALIQUOTA_IPI: Variant read FALIQUOTA_IPI write SetALIQUOTA_IPI;
    property SOMAR_IPI_BASE_ICMS: Variant read FSOMAR_IPI_BASE_ICMS write SetSOMAR_IPI_BASE_ICMS;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property LISTAR_IPI_SPED: Variant read FLISTAR_IPI_SPED write SetLISTAR_IPI_SPED;
    property APROVEITAMENTO_ICMS: Variant read FAPROVEITAMENTO_ICMS write SetAPROVEITAMENTO_ICMS;
    property REDUCAO_APROVEITAMENTO_ICMS: Variant read FREDUCAO_APROVEITAMENTO_ICMS write SetREDUCAO_APROVEITAMENTO_ICMS;
    property DESCONTO_SOBRE_IPI: Variant read FDESCONTO_SOBRE_IPI write SetDESCONTO_SOBRE_IPI;
    property SOMAR_PIS_COFINS_EM_OUTRAS: Variant read FSOMAR_PIS_COFINS_EM_OUTRAS write SetSOMAR_PIS_COFINS_EM_OUTRAS;
    property SOMAR_ICMS_TOTAL_NF: Variant read FSOMAR_ICMS_TOTAL_NF write SetSOMAR_ICMS_TOTAL_NF;
    property CFOP_DEVOLUCAO: Variant read FCFOP_DEVOLUCAO write SetCFOP_DEVOLUCAO;
    property MOTDESICMS: Variant read FMOTDESICMS write SetMOTDESICMS;
    property CBENEF: Variant read FCBENEF write SetCBENEF;
    property PREDBC_N14: Variant read FPREDBC_N14 write SetPREDBC_N14;
    property CENQ: Variant read FCENQ write SetCENQ;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property PCRED_PRESUMIDO: Variant read FPCRED_PRESUMIDO write SetPCRED_PRESUMIDO;
    property DESCONTO_SOBRE_ICMS: Variant read FDESCONTO_SOBRE_ICMS write SetDESCONTO_SOBRE_ICMS;
    property DESCONTO_ICMS_BASE_PIS_COFINS: Variant read FDESCONTO_ICMS_BASE_PIS_COFINS write SetDESCONTO_ICMS_BASE_PIS_COFINS;
    property OUTRAS_DESPESAS_ENTRADA: Variant read FOUTRAS_DESPESAS_ENTRADA write SetOUTRAS_DESPESAS_ENTRADA;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir     : String;
    function Salvar      : String;
    function Alterar(pID : String) : TCFOPModel;
    function Excluir(pID : String) : String;

    procedure obterLista;
    function carregaClasse(pId: String): TCFOPModel;

    function obterCFOP(pIdCFOP: String): String;

    property CFOPsLista: IList<TCFOPModel> read FCFOPsLista write SetCFOPsLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  CFOPDao;

{ TCFOPModel }

function TCFOPModel.Excluir(pID: String): String;
begin
  self.FID    := pID;
  self.Acao   := tacExcluir;
end;

function TCFOPModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TCFOPModel.Alterar(pID: String): TCFOPModel;
var
  lCFOPModel : TCFOPModel;
begin
  lCFOPModel := TCFOPModel.Create(vIConexao);
  try
    lCFOPModel      := lCFOPModel.carregaClasse(pID);
    lCFOPModel.Acao := tacAlterar;
    Result          := lCFOPModel;
  finally
  end;
end;

function TCFOPModel.carregaClasse(pId: String): TCFOPModel;
var
  lCFOPDao: TCFOPDao;
begin
  lCFOPDao := TCFOPDao.Create(vIConexao);
  try
    Result := lCFOPDao.carregaClasse(pId);
  finally
    lCFOPDao.Free;
  end;
end;

constructor TCFOPModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCFOPModel.Destroy;
begin
  FCFOPsLista := nil;
  vIConexao := nil;
  inherited;
end;

function TCFOPModel.obterCFOP(pIdCFOP: String): String;
var
  lCFOPDao: TCFOPDao;
begin
  lCFOPDao := TCFOPDao.Create(vIConexao);
  try
    Result := lCFOPDao.obterCFOP(pIdCFOP);
  finally
    lCFOPDao.Free;
  end;
end;

procedure TCFOPModel.obterLista;
var
  lCFOPLista: TCFOPDao;
begin
  lCFOPLista := TCFOPDao.Create(vIConexao);

  try
    lCFOPLista.TotalRecords    := FTotalRecords;
    lCFOPLista.WhereView       := FWhereView;
    lCFOPLista.CountView       := FCountView;
    lCFOPLista.OrderView       := FOrderView;
    lCFOPLista.StartRecordView := FStartRecordView;
    lCFOPLista.LengthPageView  := FLengthPageView;
    lCFOPLista.IDRecordView    := FIDRecordView;

    lCFOPLista.obterLista;

    FTotalRecords  := lCFOPLista.TotalRecords;
    FCFOPsLista := lCFOPLista.CFOPsLista;

  finally
    lCFOPLista.Free;
  end;
end;

function TCFOPModel.Salvar: String;
var
  lCFOPDao: TCFOPDao;
begin
  lCFOPDao := TCFOPDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCFOPDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lCFOPDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lCFOPDao.excluir(Self);
    end;

  finally
    lCFOPDao.Free;
  end;
end;

procedure TCFOPModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TCFOPModel.SetALIQUOTA_COFINS(const Value: Variant);
begin
  FALIQUOTA_COFINS := Value;
end;

procedure TCFOPModel.SetALIQUOTA_IPI(const Value: Variant);
begin
  FALIQUOTA_IPI := Value;
end;

procedure TCFOPModel.SetALIQUOTA_PIS(const Value: Variant);
begin
  FALIQUOTA_PIS := Value;
end;

procedure TCFOPModel.SetALTERA_CUSTO(const Value: Variant);
begin
  FALTERA_CUSTO := Value;
end;

procedure TCFOPModel.SetAPROVEITAMENTO_ICMS(const Value: Variant);
begin
  FAPROVEITAMENTO_ICMS := Value;
end;

procedure TCFOPModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCFOPModel.SetCBENEF(const Value: Variant);
begin
  FCBENEF := Value;
end;

procedure TCFOPModel.SetCENQ(const Value: Variant);
begin
  FCENQ := Value;
end;

procedure TCFOPModel.SetCFOP(const Value: Variant);
begin
  FCFOP := Value;
end;

procedure TCFOPModel.SetCSOSN(const Value: Variant);
begin
  FCSOSN := Value;
end;

procedure TCFOPModel.SetCST(const Value: Variant);
begin
  FCST := Value;
end;

procedure TCFOPModel.SetCST_COFINS(const Value: Variant);
begin
  FCST_COFINS := Value;
end;

procedure TCFOPModel.SetCST_ENTRADA(const Value: Variant);
begin
  FCST_ENTRADA := Value;
end;

procedure TCFOPModel.SetCST_IPI(const Value: Variant);
begin
  FCST_IPI := Value;
end;

procedure TCFOPModel.SetCST_PIS(const Value: Variant);
begin
  FCST_PIS := Value;
end;

procedure TCFOPModel.SetDESCONTO_ICMS_BASE_PIS_COFINS(const Value: Variant);
begin
  FDESCONTO_ICMS_BASE_PIS_COFINS := Value;
end;

procedure TCFOPModel.SetDESCONTO_SOBRE_ICMS(const Value: Variant);
begin
  FDESCONTO_SOBRE_ICMS := Value;
end;

procedure TCFOPModel.SetDESCONTO_SOBRE_IPI(const Value: Variant);
begin
  FDESCONTO_SOBRE_IPI := Value;
end;

procedure TCFOPModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TCFOPModel.SetESTOQUE(const Value: Variant);
begin
  FESTOQUE := Value;
end;

procedure TCFOPModel.SetESTOQUE_2(const Value: Variant);
begin
  FESTOQUE_2 := Value;
end;

procedure TCFOPModel.SetCFOPsLista;
begin
  FCFOPsLista := Value;
end;

procedure TCFOPModel.SetCFOP_DEVOLUCAO(const Value: Variant);
begin
  FCFOP_DEVOLUCAO := Value;
end;

procedure TCFOPModel.SetCFOP_REFERENCIA(const Value: Variant);
begin
  FCFOP_REFERENCIA := Value;
end;

procedure TCFOPModel.SetCOFINS(const Value: Variant);
begin
  FCOFINS := Value;
end;

procedure TCFOPModel.SetCONSIGNADO(const Value: Variant);
begin
  FCONSIGNADO := Value;
end;

procedure TCFOPModel.SetCONTA_CONTABIL(const Value: Variant);
begin
  FCONTA_CONTABIL := Value;
end;

procedure TCFOPModel.SetIBPT(const Value: Variant);
begin
  FIBPT := Value;
end;

procedure TCFOPModel.SetICMS(const Value: Variant);
begin
  FICMS := Value;
end;

procedure TCFOPModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCFOPModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCFOPModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCFOPModel.SetLISTAR_IPI_SPED(const Value: Variant);
begin
  FLISTAR_IPI_SPED := Value;
end;

procedure TCFOPModel.SetMOTDESICMS(const Value: Variant);
begin
  FMOTDESICMS := Value;
end;

procedure TCFOPModel.SetOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TCFOPModel.SetOPERACAO(const Value: Variant);
begin
  FOPERACAO := Value;
end;

procedure TCFOPModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCFOPModel.SetOUTRAS_DESPESAS_ENTRADA(const Value: Variant);
begin
  FOUTRAS_DESPESAS_ENTRADA := Value;
end;

procedure TCFOPModel.SetPCRED_PRESUMIDO(const Value: Variant);
begin
  FPCRED_PRESUMIDO := Value;
end;

procedure TCFOPModel.SetPIS(const Value: Variant);
begin
  FPIS := Value;
end;

procedure TCFOPModel.SetPREDBC_N14(const Value: Variant);
begin
  FPREDBC_N14 := Value;
end;

procedure TCFOPModel.SetREDUCAO_APROVEITAMENTO_ICMS(const Value: Variant);
begin
  FREDUCAO_APROVEITAMENTO_ICMS := Value;
end;

procedure TCFOPModel.SetRESERVADO_FISCO(const Value: Variant);
begin
  FRESERVADO_FISCO := Value;
end;

procedure TCFOPModel.SetSOMAR_ICMS_TOTAL_NF(const Value: Variant);
begin
  FSOMAR_ICMS_TOTAL_NF := Value;
end;

procedure TCFOPModel.SetSOMAR_IPI_BASE_ICMS(const Value: Variant);
begin
  FSOMAR_IPI_BASE_ICMS := Value;
end;

procedure TCFOPModel.SetSOMAR_PIS_COFINS_EM_OUTRAS(const Value: Variant);
begin
  FSOMAR_PIS_COFINS_EM_OUTRAS := Value;
end;

procedure TCFOPModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCFOPModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TCFOPModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TCFOPModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TCFOPModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCFOPModel.SetVALOR(const Value: Variant);
begin
  FVALOR := Value;
end;

procedure TCFOPModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
