unit EntradaItensXMLModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TEntradaItensXMLModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCOFINS_ST_VCOFINS: Variant;
    FICMS_PFCP: Variant;
    FICMS_MODBC: Variant;
    FII_VBC: Variant;
    FICMS_VFCP: Variant;
    FPIS_CST: Variant;
    FII_VIOF: Variant;
    FIPI_CENQ: Variant;
    FICMS_ORIG: Variant;
    FCOFINS_CST: Variant;
    FPRODUTO_ID_VINCULO: Variant;
    FIPI_CIENQ: Variant;
    FICMS_VBC: Variant;
    FCENAN: Variant;
    FIPI_PIPI: Variant;
    FICMS_VBCFCPST: Variant;
    FIPI_VIPI: Variant;
    FICMS_VBCFCPSTRET: Variant;
    FCPROD: Variant;
    FICMS_PREDBCST: Variant;
    FQCOM: Variant;
    FVSEG: Variant;
    FPIS_VALIQPROD: Variant;
    FIPI_CST: Variant;
    FVUNCOM: Variant;
    FCOFINS_VALIQPROD: Variant;
    FID: Variant;
    FUCOM: Variant;
    FCFOP: Variant;
    FPIS_QBCPROD: Variant;
    FPIS_VBC: Variant;
    FNCM: Variant;
    FCOFINS_QBCPROD: Variant;
    FCOFINS_VBC: Variant;
    FICMS_VBCFCP: Variant;
    FICMS_PICMSST: Variant;
    FXPROD: Variant;
    FPIS_PPIS: Variant;
    FII_VDESPADU: Variant;
    FICMS_VICMSST: Variant;
    FSYSTIME: Variant;
    FCOFINS_PCOFINS: Variant;
    FPIS_VPIS: Variant;
    FICMS_PMVAST: Variant;
    FVOUTRO: Variant;
    FICMS_PFCPST: Variant;
    FICMS_VICMSSTRET: Variant;
    FICMS_PREDBC: Variant;
    FVDESC: Variant;
    FVFRETE: Variant;
    FCOFINS_VCOFINS: Variant;
    FPIS_ST_VALIQPROD: Variant;
    FII_VII: Variant;
    FICMS_MODBCST: Variant;
    FCOFINS_ST_VALIQPROD: Variant;
    FICMS_VFCPST: Variant;
    FICMS_PFCPSTRET: Variant;
    FICMS_CST: Variant;
    FPIS_ST_QBCPROD: Variant;
    FPIS_ST_VBC: Variant;
    FICMS_VFCPSTRET: Variant;
    FCOFINS_ST_QBCPROD: Variant;
    FCOFINS_ST_VBC: Variant;
    FIPI_QUNID: Variant;
    FIPI_VBC: Variant;
    FICMS_CSOSN: Variant;
    FICMS_VBCST: Variant;
    FPIS_ST_PPIS: Variant;
    FIPI_VUNID: Variant;
    FVPROD: Variant;
    FICMS_VBCSTRET: Variant;
    FICMS_PICMS: Variant;
    FCOFINS_ST_PCOFINS: Variant;
    FPIS_ST_VPIS: Variant;
    FICMS_VICMS: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCENAN(const Value: Variant);
    procedure SetCFOP(const Value: Variant);
    procedure SetCOFINS_CST(const Value: Variant);
    procedure SetCOFINS_PCOFINS(const Value: Variant);
    procedure SetCOFINS_QBCPROD(const Value: Variant);
    procedure SetCOFINS_ST_PCOFINS(const Value: Variant);
    procedure SetCOFINS_ST_QBCPROD(const Value: Variant);
    procedure SetCOFINS_ST_VALIQPROD(const Value: Variant);
    procedure SetCOFINS_ST_VBC(const Value: Variant);
    procedure SetCOFINS_ST_VCOFINS(const Value: Variant);
    procedure SetCOFINS_VALIQPROD(const Value: Variant);
    procedure SetCOFINS_VBC(const Value: Variant);
    procedure SetCOFINS_VCOFINS(const Value: Variant);
    procedure SetCPROD(const Value: Variant);
    procedure SetICMS_CSOSN(const Value: Variant);
    procedure SetICMS_CST(const Value: Variant);
    procedure SetICMS_MODBC(const Value: Variant);
    procedure SetICMS_MODBCST(const Value: Variant);
    procedure SetICMS_ORIG(const Value: Variant);
    procedure SetICMS_PFCP(const Value: Variant);
    procedure SetICMS_PFCPST(const Value: Variant);
    procedure SetICMS_PFCPSTRET(const Value: Variant);
    procedure SetICMS_PICMS(const Value: Variant);
    procedure SetICMS_PICMSST(const Value: Variant);
    procedure SetICMS_PMVAST(const Value: Variant);
    procedure SetICMS_PREDBC(const Value: Variant);
    procedure SetICMS_PREDBCST(const Value: Variant);
    procedure SetICMS_VBC(const Value: Variant);
    procedure SetICMS_VBCFCP(const Value: Variant);
    procedure SetICMS_VBCFCPST(const Value: Variant);
    procedure SetICMS_VBCFCPSTRET(const Value: Variant);
    procedure SetICMS_VBCST(const Value: Variant);
    procedure SetICMS_VBCSTRET(const Value: Variant);
    procedure SetICMS_VFCP(const Value: Variant);
    procedure SetICMS_VFCPST(const Value: Variant);
    procedure SetICMS_VFCPSTRET(const Value: Variant);
    procedure SetICMS_VICMS(const Value: Variant);
    procedure SetICMS_VICMSST(const Value: Variant);
    procedure SetICMS_VICMSSTRET(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetII_VBC(const Value: Variant);
    procedure SetII_VDESPADU(const Value: Variant);
    procedure SetII_VII(const Value: Variant);
    procedure SetII_VIOF(const Value: Variant);
    procedure SetIPI_CENQ(const Value: Variant);
    procedure SetIPI_CIENQ(const Value: Variant);
    procedure SetIPI_CST(const Value: Variant);
    procedure SetIPI_PIPI(const Value: Variant);
    procedure SetIPI_QUNID(const Value: Variant);
    procedure SetIPI_VBC(const Value: Variant);
    procedure SetIPI_VIPI(const Value: Variant);
    procedure SetIPI_VUNID(const Value: Variant);
    procedure SetNCM(const Value: Variant);
    procedure SetPIS_CST(const Value: Variant);
    procedure SetPIS_PPIS(const Value: Variant);
    procedure SetPIS_QBCPROD(const Value: Variant);
    procedure SetPIS_ST_PPIS(const Value: Variant);
    procedure SetPIS_ST_QBCPROD(const Value: Variant);
    procedure SetPIS_ST_VALIQPROD(const Value: Variant);
    procedure SetPIS_ST_VBC(const Value: Variant);
    procedure SetPIS_ST_VPIS(const Value: Variant);
    procedure SetPIS_VALIQPROD(const Value: Variant);
    procedure SetPIS_VBC(const Value: Variant);
    procedure SetPIS_VPIS(const Value: Variant);
    procedure SetPRODUTO_ID_VINCULO(const Value: Variant);
    procedure SetQCOM(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUCOM(const Value: Variant);
    procedure SetVDESC(const Value: Variant);
    procedure SetVFRETE(const Value: Variant);
    procedure SetVOUTRO(const Value: Variant);
    procedure SetVPROD(const Value: Variant);
    procedure SetVSEG(const Value: Variant);
    procedure SetVUNCOM(const Value: Variant);
    procedure SetXPROD(const Value: Variant);

  public

    property ID                   : Variant  read FID write SetID;
    property CPROD                : Variant  read FCPROD write SetCPROD;
    property CENAN                : Variant  read FCENAN write SetCENAN;
    property XPROD                : Variant  read FXPROD write SetXPROD;
    property NCM                  : Variant  read FNCM write SetNCM;
    property CFOP                 : Variant  read FCFOP write SetCFOP;
    property UCOM                 : Variant  read FUCOM write SetUCOM;
    property QCOM                 : Variant  read FQCOM write SetQCOM;
    property VUNCOM               : Variant  read FVUNCOM write SetVUNCOM;
    property VPROD                : Variant  read FVPROD write SetVPROD;
    property VFRETE               : Variant  read FVFRETE write SetVFRETE;
    property VSEG                 : Variant  read FVSEG write SetVSEG;
    property VDESC                : Variant  read FVDESC write SetVDESC;
    property VOUTRO               : Variant  read FVOUTRO write SetVOUTRO;
    property ICMS_CST             : Variant  read FICMS_CST write SetICMS_CST;
    property ICMS_VBC             : Variant  read FICMS_VBC write SetICMS_VBC;
    property ICMS_PICMS           : Variant  read FICMS_PICMS write SetICMS_PICMS;
    property ICMS_VICMS           : Variant  read FICMS_VICMS write SetICMS_VICMS;
    property ICMS_PMVAST          : Variant  read FICMS_PMVAST write SetICMS_PMVAST;
    property ICMS_PREDBCST        : Variant  read FICMS_PREDBCST write SetICMS_PREDBCST;
    property ICMS_VBCST           : Variant  read FICMS_VBCST write SetICMS_VBCST;
    property ICMS_PICMSST         : Variant  read FICMS_PICMSST write SetICMS_PICMSST;
    property ICMS_VICMSST         : Variant  read FICMS_VICMSST write SetICMS_VICMSST;
    property ICMS_VBCSTRET        : Variant  read FICMS_VBCSTRET write SetICMS_VBCSTRET;
    property ICMS_PREDBC          : Variant  read FICMS_PREDBC write SetICMS_PREDBC;
    property ICMS_VICMSSTRET      : Variant  read FICMS_VICMSSTRET write SetICMS_VICMSSTRET;
    property ICMS_VBCFCPSTRET     : Variant  read FICMS_VBCFCPSTRET write SetICMS_VBCFCPSTRET;
    property ICMS_PFCPSTRET       : Variant  read FICMS_PFCPSTRET write SetICMS_PFCPSTRET;
    property ICMS_VFCPSTRET       : Variant  read FICMS_VFCPSTRET write SetICMS_VFCPSTRET;
    property ICMS_VBCFCP          : Variant  read FICMS_VBCFCP write SetICMS_VBCFCP;
    property ICMS_PFCP            : Variant  read FICMS_PFCP write SetICMS_PFCP;
    property ICMS_VFCP            : Variant  read FICMS_VFCP write SetICMS_VFCP;
    property ICMS_PFCPST          : Variant  read FICMS_PFCPST write SetICMS_PFCPST;
    property ICMS_VBCFCPST        : Variant  read FICMS_VBCFCPST write SetICMS_VBCFCPST;
    property ICMS_VFCPST          : Variant  read FICMS_VFCPST write SetICMS_VFCPST;
    property ICMS_MODBCST         : Variant  read FICMS_MODBCST write SetICMS_MODBCST;
    property ICMS_CSOSN           : Variant  read FICMS_CSOSN write SetICMS_CSOSN;
    property IPI_CST              : Variant  read FIPI_CST write SetIPI_CST;
    property IPI_CIENQ            : Variant  read FIPI_CIENQ write SetIPI_CIENQ;
    property IPI_CENQ             : Variant  read FIPI_CENQ write SetIPI_CENQ;
    property IPI_VBC              : Variant  read FIPI_VBC write SetIPI_VBC;
    property IPI_QUNID            : Variant  read FIPI_QUNID write SetIPI_QUNID;
    property IPI_VUNID            : Variant  read FIPI_VUNID write SetIPI_VUNID;
    property IPI_PIPI             : Variant  read FIPI_PIPI write SetIPI_PIPI;
    property IPI_VIPI             : Variant  read FIPI_VIPI write SetIPI_VIPI;
    property II_VBC               : Variant  read FII_VBC write SetII_VBC;
    property II_VDESPADU          : Variant  read FII_VDESPADU write SetII_VDESPADU;
    property II_VII               : Variant  read FII_VII write SetII_VII;
    property II_VIOF              : Variant  read FII_VIOF write SetII_VIOF;
    property PIS_CST              : Variant  read FPIS_CST write SetPIS_CST;
    property PIS_VBC              : Variant  read FPIS_VBC write SetPIS_VBC;
    property PIS_PPIS             : Variant  read FPIS_PPIS write SetPIS_PPIS;
    property PIS_VPIS             : Variant  read FPIS_VPIS write SetPIS_VPIS;
    property PIS_QBCPROD          : Variant  read FPIS_QBCPROD write SetPIS_QBCPROD;
    property PIS_VALIQPROD        : Variant  read FPIS_VALIQPROD write SetPIS_VALIQPROD;
    property PIS_ST_VBC           : Variant  read FPIS_ST_VBC write SetPIS_ST_VBC;
    property PIS_ST_PPIS          : Variant  read FPIS_ST_PPIS write SetPIS_ST_PPIS;
    property PIS_ST_QBCPROD       : Variant  read FPIS_ST_QBCPROD write SetPIS_ST_QBCPROD;
    property PIS_ST_VALIQPROD     : Variant  read FPIS_ST_VALIQPROD write SetPIS_ST_VALIQPROD;
    property PIS_ST_VPIS          : Variant  read FPIS_ST_VPIS write SetPIS_ST_VPIS;
    property COFINS_CST           : Variant  read FCOFINS_CST write SetCOFINS_CST;
    property COFINS_VBC           : Variant  read FCOFINS_VBC write SetCOFINS_VBC;
    property COFINS_PCOFINS       : Variant  read FCOFINS_PCOFINS write SetCOFINS_PCOFINS;
    property COFINS_VCOFINS       : Variant  read FCOFINS_VCOFINS write SetCOFINS_VCOFINS;
    property COFINS_QBCPROD       : Variant  read FCOFINS_QBCPROD write SetCOFINS_QBCPROD;
    property COFINS_VALIQPROD     : Variant  read FCOFINS_VALIQPROD write SetCOFINS_VALIQPROD;
    property COFINS_ST_VBC        : Variant  read FCOFINS_ST_VBC write SetCOFINS_ST_VBC;
    property COFINS_ST_PCOFINS    : Variant  read FCOFINS_ST_PCOFINS write SetCOFINS_ST_PCOFINS;
    property COFINS_ST_QBCPROD    : Variant  read FCOFINS_ST_QBCPROD write SetCOFINS_ST_QBCPROD;
    property COFINS_ST_VALIQPROD  : Variant  read FCOFINS_ST_VALIQPROD write SetCOFINS_ST_VALIQPROD;
    property COFINS_ST_VCOFINS    : Variant  read FCOFINS_ST_VCOFINS write SetCOFINS_ST_VCOFINS;
    property PRODUTO_ID_VINCULO   : Variant  read FPRODUTO_ID_VINCULO write SetPRODUTO_ID_VINCULO;
    property ICMS_ORIG            : Variant  read FICMS_ORIG write SetICMS_ORIG;
    property ICMS_MODBC           : Variant  read FICMS_MODBC write SetICMS_MODBC;
    property SYSTIME              : Variant  read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TEntradaItensXMLModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId: String): TEntradaItensXMLModel;
    function obterLista: TFDMemTable;

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
  EntradaItensXMLDao;

{ TEntradaItensXMLModel }

function TEntradaItensXMLModel.Alterar(pID: String): TEntradaItensXMLModel;
var
  lEntradaItensXMLModel : TEntradaItensXMLModel;
begin
  lEntradaItensXMLModel := TEntradaItensXMLModel.Create(vIConexao);
  try
    lEntradaItensXMLModel       := lEntradaItensXMLModel.carregaClasse(pID);
    lEntradaItensXMLModel.Acao  := tacAlterar;
    Result                      := lEntradaItensXMLModel;
  finally
  end;
end;

function TEntradaItensXMLModel.Excluir(pID: String): String;
begin
  self.FID   := pID;
  self.FAcao := tacExcluir;
  Result     := self.Salvar;
end;

function TEntradaItensXMLModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TEntradaItensXMLModel.carregaClasse(pId: String): TEntradaItensXMLModel;
var
  lEntradaItensXMLDao: TEntradaItensXMLDao;
begin
  lEntradaItensXMLDao := TEntradaItensXMLDao.Create(vIConexao);

  try
    Result := lEntradaItensXMLDao.carregaClasse(pId);
  finally
    lEntradaItensXMLDao.Free;
  end;
end;

constructor TEntradaItensXMLModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TEntradaItensXMLModel.Destroy;
begin

  inherited;
end;

function TEntradaItensXMLModel.obterLista: TFDMemTable;
var
  lEntradaItensXMLLista: TEntradaItensXMLDao;
begin
  lEntradaItensXMLLista := TEntradaItensXMLDao.Create(vIConexao);

  try
    lEntradaItensXMLLista.TotalRecords    := FTotalRecords;
    lEntradaItensXMLLista.WhereView       := FWhereView;
    lEntradaItensXMLLista.CountView       := FCountView;
    lEntradaItensXMLLista.OrderView       := FOrderView;
    lEntradaItensXMLLista.StartRecordView := FStartRecordView;
    lEntradaItensXMLLista.LengthPageView  := FLengthPageView;
    lEntradaItensXMLLista.IDRecordView    := FIDRecordView;

    Result := lEntradaItensXMLLista.obterLista;

    FTotalRecords := lEntradaItensXMLLista.TotalRecords;

  finally
    lEntradaItensXMLLista.Free;
  end;
end;

function TEntradaItensXMLModel.Salvar: String;
var
  lEntradaItensXMLDao: TEntradaItensXMLDao;
begin
  lEntradaItensXMLDao := TEntradaItensXMLDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lEntradaItensXMLDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lEntradaItensXMLDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lEntradaItensXMLDao.excluir(Self);
    end;

  finally
    lEntradaItensXMLDao.Free;
  end;
end;

procedure TEntradaItensXMLModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TEntradaItensXMLModel.SetCENAN(const Value: Variant);
begin
  FCENAN := Value;
end;

procedure TEntradaItensXMLModel.SetCFOP(const Value: Variant);
begin
  FCFOP := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_CST(const Value: Variant);
begin
  FCOFINS_CST := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_PCOFINS(const Value: Variant);
begin
  FCOFINS_PCOFINS := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_QBCPROD(const Value: Variant);
begin
  FCOFINS_QBCPROD := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_ST_PCOFINS(const Value: Variant);
begin
  FCOFINS_ST_PCOFINS := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_ST_QBCPROD(const Value: Variant);
begin
  FCOFINS_ST_QBCPROD := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_ST_VALIQPROD(const Value: Variant);
begin
  FCOFINS_ST_VALIQPROD := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_ST_VBC(const Value: Variant);
begin
  FCOFINS_ST_VBC := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_ST_VCOFINS(const Value: Variant);
begin
  FCOFINS_ST_VCOFINS := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_VALIQPROD(const Value: Variant);
begin
  FCOFINS_VALIQPROD := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_VBC(const Value: Variant);
begin
  FCOFINS_VBC := Value;
end;

procedure TEntradaItensXMLModel.SetCOFINS_VCOFINS(const Value: Variant);
begin
  FCOFINS_VCOFINS := Value;
end;

procedure TEntradaItensXMLModel.SetCountView(const Value: String);
begin

end;

procedure TEntradaItensXMLModel.SetCPROD(const Value: Variant);
begin
  FCPROD := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_CSOSN(const Value: Variant);
begin
  FICMS_CSOSN := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_CST(const Value: Variant);
begin
  FICMS_CST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_MODBC(const Value: Variant);
begin
  FICMS_MODBC := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_MODBCST(const Value: Variant);
begin
  FICMS_MODBCST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_ORIG(const Value: Variant);
begin
  FICMS_ORIG := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_PFCP(const Value: Variant);
begin
  FICMS_PFCP := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_PFCPST(const Value: Variant);
begin
  FICMS_PFCPST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_PFCPSTRET(const Value: Variant);
begin
  FICMS_PFCPSTRET := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_PICMS(const Value: Variant);
begin
  FICMS_PICMS := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_PICMSST(const Value: Variant);
begin
  FICMS_PICMSST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_PMVAST(const Value: Variant);
begin
  FICMS_PMVAST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_PREDBC(const Value: Variant);
begin
  FICMS_PREDBC := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_PREDBCST(const Value: Variant);
begin
  FICMS_PREDBCST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VBC(const Value: Variant);
begin
  FICMS_VBC := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VBCFCP(const Value: Variant);
begin
  FICMS_VBCFCP := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VBCFCPST(const Value: Variant);
begin
  FICMS_VBCFCPST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VBCFCPSTRET(const Value: Variant);
begin
  FICMS_VBCFCPSTRET := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VBCST(const Value: Variant);
begin
  FICMS_VBCST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VBCSTRET(const Value: Variant);
begin
  FICMS_VBCSTRET := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VFCP(const Value: Variant);
begin
  FICMS_VFCP := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VFCPST(const Value: Variant);
begin
  FICMS_VFCPST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VFCPSTRET(const Value: Variant);
begin
  FICMS_VFCPSTRET := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VICMS(const Value: Variant);
begin
  FICMS_VICMS := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VICMSST(const Value: Variant);
begin
  FICMS_VICMSST := Value;
end;

procedure TEntradaItensXMLModel.SetICMS_VICMSSTRET(const Value: Variant);
begin
  FICMS_VICMSSTRET := Value;
end;

procedure TEntradaItensXMLModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEntradaItensXMLModel.SetIDRecordView(const Value: Integer);
begin

end;

procedure TEntradaItensXMLModel.SetII_VBC(const Value: Variant);
begin
  FII_VBC := Value;
end;

procedure TEntradaItensXMLModel.SetII_VDESPADU(const Value: Variant);
begin
  FII_VDESPADU := Value;
end;

procedure TEntradaItensXMLModel.SetII_VII(const Value: Variant);
begin
  FII_VII := Value;
end;

procedure TEntradaItensXMLModel.SetII_VIOF(const Value: Variant);
begin
  FII_VIOF := Value;
end;

procedure TEntradaItensXMLModel.SetIPI_CENQ(const Value: Variant);
begin
  FIPI_CENQ := Value;
end;

procedure TEntradaItensXMLModel.SetIPI_CIENQ(const Value: Variant);
begin
  FIPI_CIENQ := Value;
end;

procedure TEntradaItensXMLModel.SetIPI_CST(const Value: Variant);
begin
  FIPI_CST := Value;
end;

procedure TEntradaItensXMLModel.SetIPI_PIPI(const Value: Variant);
begin
  FIPI_PIPI := Value;
end;

procedure TEntradaItensXMLModel.SetIPI_QUNID(const Value: Variant);
begin
  FIPI_QUNID := Value;
end;

procedure TEntradaItensXMLModel.SetIPI_VBC(const Value: Variant);
begin
  FIPI_VBC := Value;
end;

procedure TEntradaItensXMLModel.SetIPI_VIPI(const Value: Variant);
begin
  FIPI_VIPI := Value;
end;

procedure TEntradaItensXMLModel.SetIPI_VUNID(const Value: Variant);
begin
  FIPI_VUNID := Value;
end;

procedure TEntradaItensXMLModel.SetLengthPageView(const Value: String);
begin

end;

procedure TEntradaItensXMLModel.SetNCM(const Value: Variant);
begin
  FNCM := Value;
end;

procedure TEntradaItensXMLModel.SetOrderView(const Value: String);
begin

end;

procedure TEntradaItensXMLModel.SetPIS_CST(const Value: Variant);
begin
  FPIS_CST := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_PPIS(const Value: Variant);
begin
  FPIS_PPIS := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_QBCPROD(const Value: Variant);
begin
  FPIS_QBCPROD := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_ST_PPIS(const Value: Variant);
begin
  FPIS_ST_PPIS := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_ST_QBCPROD(const Value: Variant);
begin
  FPIS_ST_QBCPROD := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_ST_VALIQPROD(const Value: Variant);
begin
  FPIS_ST_VALIQPROD := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_ST_VBC(const Value: Variant);
begin
  FPIS_ST_VBC := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_ST_VPIS(const Value: Variant);
begin
  FPIS_ST_VPIS := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_VALIQPROD(const Value: Variant);
begin
  FPIS_VALIQPROD := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_VBC(const Value: Variant);
begin
  FPIS_VBC := Value;
end;

procedure TEntradaItensXMLModel.SetPIS_VPIS(const Value: Variant);
begin
  FPIS_VPIS := Value;
end;

procedure TEntradaItensXMLModel.SetPRODUTO_ID_VINCULO(const Value: Variant);
begin
  FPRODUTO_ID_VINCULO := Value;
end;

procedure TEntradaItensXMLModel.SetQCOM(const Value: Variant);
begin
  FQCOM := Value;
end;

procedure TEntradaItensXMLModel.SetStartRecordView(const Value: String);
begin

end;

procedure TEntradaItensXMLModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TEntradaItensXMLModel.SetTotalRecords(const Value: Integer);
begin

end;

procedure TEntradaItensXMLModel.SetUCOM(const Value: Variant);
begin
  FUCOM := Value;
end;

procedure TEntradaItensXMLModel.SetVDESC(const Value: Variant);
begin
  FVDESC := Value;
end;

procedure TEntradaItensXMLModel.SetVFRETE(const Value: Variant);
begin
  FVFRETE := Value;
end;

procedure TEntradaItensXMLModel.SetVOUTRO(const Value: Variant);
begin
  FVOUTRO := Value;
end;

procedure TEntradaItensXMLModel.SetVPROD(const Value: Variant);
begin
  FVPROD := Value;
end;

procedure TEntradaItensXMLModel.SetVSEG(const Value: Variant);
begin
  FVSEG := Value;
end;

procedure TEntradaItensXMLModel.SetVUNCOM(const Value: Variant);
begin
  FVUNCOM := Value;
end;

procedure TEntradaItensXMLModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TEntradaItensXMLModel.SetXPROD(const Value: Variant);
begin
  FXPROD := Value;
end;

end.
