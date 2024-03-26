unit PedidoCompraItensModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TPedidoCompraItensModel = class

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

    FID: Variant;
    FVBCICMS_N15: Variant;
    FVLR_OUTRAS: Variant;
    FOBSERVACAO: Variant;
    FFRETE_PED: Variant;
    FALTURA_M: Variant;
    FCST_N12: Variant;
    FIPI_PED: Variant;
    FCODIGO_FOR: Variant;
    FVFCP: Variant;
    FVBCST_N21: Variant;
    FORCAMENTO_ID: Variant;
    FPREDBC_N14: Variant;
    FRESERVA_ID: Variant;
    FVENDACALC_PED: Variant;
    FLARGURA_M: Variant;
    FPICMS_N16: Variant;
    FVLR_DESCONTO: Variant;
    FMARGEM_PED: Variant;
    FVICMS_N17: Variant;
    FQUANTIDADE_ATE_ORIGINAL: Variant;
    FVALORUNI_PED: Variant;
    FLOJA: Variant;
    FPST_N22: Variant;
    FCFOP_ID: Variant;
    FCODIGO_PRO: Variant;
    FSYSTIME: Variant;
    FPREDBCST_N20: Variant;
    FVST_N23: Variant;
    FVENDAANTERIOR_PED: Variant;
    FNUMERO_PED: Variant;
    FSTATUS_PED: Variant;
    FPROFUNDIDADE_M: Variant;
    FPMVAST_N19: Variant;
    FVFCPST: Variant;
    FVIPI_014: Variant;
    FVFCPSTRET: Variant;
    FQUANTIDADE_PED: Variant;
    FQUANTIDADE_ATE: Variant;
    FNumeroView: String;
    FFornecedorView: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    procedure SetID(const Value: Variant);
    procedure SetALTURA_M(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCODIGO_PRO(const Value: Variant);
    procedure SetCST_N12(const Value: Variant);
    procedure SetFRETE_PED(const Value: Variant);
    procedure SetIPI_PED(const Value: Variant);
    procedure SetLARGURA_M(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetMARGEM_PED(const Value: Variant);
    procedure SetNUMERO_PED(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetORCAMENTO_ID(const Value: Variant);
    procedure SetPICMS_N16(const Value: Variant);
    procedure SetPMVAST_N19(const Value: Variant);
    procedure SetPREDBC_N14(const Value: Variant);
    procedure SetPREDBCST_N20(const Value: Variant);
    procedure SetPROFUNDIDADE_M(const Value: Variant);
    procedure SetPST_N22(const Value: Variant);
    procedure SetQUANTIDADE_ATE(const Value: Variant);
    procedure SetQUANTIDADE_ATE_ORIGINAL(const Value: Variant);
    procedure SetQUANTIDADE_PED(const Value: Variant);
    procedure SetRESERVA_ID(const Value: Variant);
    procedure SetSTATUS_PED(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALORUNI_PED(const Value: Variant);
    procedure SetVBCICMS_N15(const Value: Variant);
    procedure SetVBCST_N21(const Value: Variant);
    procedure SetVENDAANTERIOR_PED(const Value: Variant);
    procedure SetVENDACALC_PED(const Value: Variant);
    procedure SetVFCP(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetVFCPSTRET(const Value: Variant);
    procedure SetVICMS_N17(const Value: Variant);
    procedure SetVIPI_014(const Value: Variant);
    procedure SetVLR_DESCONTO(const Value: Variant);
    procedure SetVLR_OUTRAS(const Value: Variant);
    procedure SetVST_N23(const Value: Variant);
    procedure SetFornecedorView(const Value: String);
    procedure SetNumeroView(const Value: String);

  public

    property ID                      : Variant read FID write SetID;
    property NUMERO_PED              : Variant read FNUMERO_PED write SetNUMERO_PED;
    property CODIGO_FOR              : Variant read FCODIGO_FOR write SetCODIGO_FOR;
    property CODIGO_PRO              : Variant read FCODIGO_PRO write SetCODIGO_PRO;
    property QUANTIDADE_PED          : Variant read FQUANTIDADE_PED write SetQUANTIDADE_PED;
    property VALORUNI_PED            : Variant read FVALORUNI_PED write SetVALORUNI_PED;
    property IPI_PED                 : Variant read FIPI_PED write SetIPI_PED;
    property FRETE_PED               : Variant read FFRETE_PED write SetFRETE_PED;
    property MARGEM_PED              : Variant read FMARGEM_PED write SetMARGEM_PED;
    property VENDAANTERIOR_PED       : Variant read FVENDAANTERIOR_PED write SetVENDAANTERIOR_PED;
    property QUANTIDADE_ATE          : Variant read FQUANTIDADE_ATE write SetQUANTIDADE_ATE;
    property STATUS_PED              : Variant read FSTATUS_PED write SetSTATUS_PED;
    property VENDACALC_PED           : Variant read FVENDACALC_PED write SetVENDACALC_PED;
    property LOJA                    : Variant read FLOJA write SetLOJA;
    property OBSERVACAO              : Variant read FOBSERVACAO write SetOBSERVACAO;
    property QUANTIDADE_ATE_ORIGINAL : Variant read FQUANTIDADE_ATE_ORIGINAL write SetQUANTIDADE_ATE_ORIGINAL;
    property CFOP_ID                 : Variant read FCFOP_ID write SetCFOP_ID;
    property CST_N12                 : Variant read FCST_N12 write SetCST_N12;
    property VIPI_014                : Variant read FVIPI_014 write SetVIPI_014;
    property VBCICMS_N15             : Variant read FVBCICMS_N15 write SetVBCICMS_N15;
    property VICMS_N17               : Variant read FVICMS_N17 write SetVICMS_N17;
    property PICMS_N16               : Variant read FPICMS_N16 write SetPICMS_N16;
    property VBCST_N21               : Variant read FVBCST_N21 write SetVBCST_N21;
    property VST_N23                 : Variant read FVST_N23 write SetVST_N23;
    property PST_N22                 : Variant read FPST_N22 write SetPST_N22;
    property VLR_DESCONTO            : Variant read FVLR_DESCONTO write SetVLR_DESCONTO;
    property VLR_OUTRAS              : Variant read FVLR_OUTRAS write SetVLR_OUTRAS;
    property VFCP                    : Variant read FVFCP write SetVFCP;
    property VFCPST                  : Variant read FVFCPST write SetVFCPST;
    property VFCPSTRET               : Variant read FVFCPSTRET write SetVFCPSTRET;
    property PREDBC_N14              : Variant read FPREDBC_N14 write SetPREDBC_N14;
    property PMVAST_N19              : Variant read FPMVAST_N19 write SetPMVAST_N19;
    property PREDBCST_N20            : Variant read FPREDBCST_N20 write SetPREDBCST_N20;
    property ORCAMENTO_ID            : Variant read FORCAMENTO_ID write SetORCAMENTO_ID;
    property SYSTIME                 : Variant read FSYSTIME write SetSYSTIME;
    property ALTURA_M                : Variant read FALTURA_M write SetALTURA_M;
    property LARGURA_M               : Variant read FLARGURA_M write SetLARGURA_M;
    property PROFUNDIDADE_M          : Variant read FPROFUNDIDADE_M write SetPROFUNDIDADE_M;
    property RESERVA_ID              : Variant read FRESERVA_ID write SetRESERVA_ID;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TPedidoCompraItensModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TPedidoCompraItensModel;
    function obterLista: TFDMemTable;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property NumeroView : String read FNumeroView write SetNumeroView;
    property FornecedorView : String read FFornecedorView write SetFornecedorView;
  end;

implementation

uses
  PedidoCompraItensDao,  
  System.Classes, 
  System.SysUtils;

{ TPedidoCompraItensModel }

function TPedidoCompraItensModel.Alterar(pID: String): TPedidoCompraItensModel;
var
  lPedidoCompraItensModel : TPedidoCompraItensModel;
begin
  lPedidoCompraItensModel := TPedidoCompraItensModel.Create(vIConexao);
  try
    lPedidoCompraItensModel       := lPedidoCompraItensModel.carregaClasse(pID);
    lPedidoCompraItensModel.Acao  := tacAlterar;
    Result            			      := lPedidoCompraItensModel;
  finally
  end;
end;

function TPedidoCompraItensModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TPedidoCompraItensModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TPedidoCompraItensModel.carregaClasse(pId : String): TPedidoCompraItensModel;
var
  lPedidoCompraItensDao: TPedidoCompraItensDao;
begin
  lPedidoCompraItensDao := TPedidoCompraItensDao.Create(vIConexao);

  try
    Result := lPedidoCompraItensDao.carregaClasse(pId);
  finally
    lPedidoCompraItensDao.Free;
  end;
end;

constructor TPedidoCompraItensModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPedidoCompraItensModel.Destroy;
begin
  inherited;
end;

function TPedidoCompraItensModel.obterLista: TFDMemTable;
var
  lPedidoCompraItensLista: TPedidoCompraItensDao;
begin
  lPedidoCompraItensLista := TPedidoCompraItensDao.Create(vIConexao);

  try
    lPedidoCompraItensLista.TotalRecords    := FTotalRecords;
    lPedidoCompraItensLista.WhereView       := FWhereView;
    lPedidoCompraItensLista.CountView       := FCountView;
    lPedidoCompraItensLista.OrderView       := FOrderView;
    lPedidoCompraItensLista.StartRecordView := FStartRecordView;
    lPedidoCompraItensLista.LengthPageView  := FLengthPageView;
    lPedidoCompraItensLista.IDRecordView    := FIDRecordView;
    lPedidoCompraItensLista.FornecedorView  := FFornecedorView;
    lPedidoCompraItensLista.NumeroView      := FNumeroView;

    Result := lPedidoCompraItensLista.obterLista;

    FTotalRecords := lPedidoCompraItensLista.TotalRecords;

  finally
    lPedidoCompraItensLista.Free;
  end;
end;

function TPedidoCompraItensModel.Salvar: String;
var
  lPedidoCompraItensDao: TPedidoCompraItensDao;
begin
  lPedidoCompraItensDao := TPedidoCompraItensDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPedidoCompraItensDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lPedidoCompraItensDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lPedidoCompraItensDao.excluir(Self);
    end;
  finally
    lPedidoCompraItensDao.Free;
  end;
end;

procedure TPedidoCompraItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPedidoCompraItensModel.SetALTURA_M(const Value: Variant);
begin
  FALTURA_M := Value;
end;

procedure TPedidoCompraItensModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;

procedure TPedidoCompraItensModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;

procedure TPedidoCompraItensModel.SetCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
end;

procedure TPedidoCompraItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoCompraItensModel.SetCST_N12(const Value: Variant);
begin
  FCST_N12 := Value;
end;

procedure TPedidoCompraItensModel.SetFornecedorView(const Value: String);
begin
  FFornecedorView := Value;
end;

procedure TPedidoCompraItensModel.SetFRETE_PED(const Value: Variant);
begin
  FFRETE_PED := Value;
end;

procedure TPedidoCompraItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPedidoCompraItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPedidoCompraItensModel.SetIPI_PED(const Value: Variant);
begin
  FIPI_PED := Value;
end;

procedure TPedidoCompraItensModel.SetLARGURA_M(const Value: Variant);
begin
  FLARGURA_M := Value;
end;

procedure TPedidoCompraItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoCompraItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TPedidoCompraItensModel.SetMARGEM_PED(const Value: Variant);
begin
  FMARGEM_PED := Value;
end;

procedure TPedidoCompraItensModel.SetNumeroView(const Value: String);
begin
  FNumeroView := Value;
end;

procedure TPedidoCompraItensModel.SetNUMERO_PED(const Value: Variant);
begin
  FNUMERO_PED := Value;
end;

procedure TPedidoCompraItensModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TPedidoCompraItensModel.SetORCAMENTO_ID(const Value: Variant);
begin
  FORCAMENTO_ID := Value;
end;

procedure TPedidoCompraItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TPedidoCompraItensModel.SetPICMS_N16(const Value: Variant);
begin
  FPICMS_N16 := Value;
end;

procedure TPedidoCompraItensModel.SetPMVAST_N19(const Value: Variant);
begin
  FPMVAST_N19 := Value;
end;

procedure TPedidoCompraItensModel.SetPREDBCST_N20(const Value: Variant);
begin
  FPREDBCST_N20 := Value;
end;

procedure TPedidoCompraItensModel.SetPREDBC_N14(const Value: Variant);
begin
  FPREDBC_N14 := Value;
end;

procedure TPedidoCompraItensModel.SetPROFUNDIDADE_M(const Value: Variant);
begin
  FPROFUNDIDADE_M := Value;
end;

procedure TPedidoCompraItensModel.SetPST_N22(const Value: Variant);
begin
  FPST_N22 := Value;
end;

procedure TPedidoCompraItensModel.SetQUANTIDADE_ATE(const Value: Variant);
begin
  FQUANTIDADE_ATE := Value;
end;

procedure TPedidoCompraItensModel.SetQUANTIDADE_ATE_ORIGINAL(
  const Value: Variant);
begin
  FQUANTIDADE_ATE_ORIGINAL := Value;
end;

procedure TPedidoCompraItensModel.SetQUANTIDADE_PED(const Value: Variant);
begin
  FQUANTIDADE_PED := Value;
end;

procedure TPedidoCompraItensModel.SetRESERVA_ID(const Value: Variant);
begin
  FRESERVA_ID := Value;
end;

procedure TPedidoCompraItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TPedidoCompraItensModel.SetSTATUS_PED(const Value: Variant);
begin
  FSTATUS_PED := Value;
end;

procedure TPedidoCompraItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPedidoCompraItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TPedidoCompraItensModel.SetVALORUNI_PED(const Value: Variant);
begin
  FVALORUNI_PED := Value;
end;

procedure TPedidoCompraItensModel.SetVBCICMS_N15(const Value: Variant);
begin
  FVBCICMS_N15 := Value;
end;

procedure TPedidoCompraItensModel.SetVBCST_N21(const Value: Variant);
begin
  FVBCST_N21 := Value;
end;

procedure TPedidoCompraItensModel.SetVENDAANTERIOR_PED(const Value: Variant);
begin
  FVENDAANTERIOR_PED := Value;
end;

procedure TPedidoCompraItensModel.SetVENDACALC_PED(const Value: Variant);
begin
  FVENDACALC_PED := Value;
end;

procedure TPedidoCompraItensModel.SetVFCP(const Value: Variant);
begin
  FVFCP := Value;
end;

procedure TPedidoCompraItensModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TPedidoCompraItensModel.SetVFCPSTRET(const Value: Variant);
begin
  FVFCPSTRET := Value;
end;

procedure TPedidoCompraItensModel.SetVICMS_N17(const Value: Variant);
begin
  FVICMS_N17 := Value;
end;

procedure TPedidoCompraItensModel.SetVIPI_014(const Value: Variant);
begin
  FVIPI_014 := Value;
end;

procedure TPedidoCompraItensModel.SetVLR_DESCONTO(const Value: Variant);
begin
  FVLR_DESCONTO := Value;
end;

procedure TPedidoCompraItensModel.SetVLR_OUTRAS(const Value: Variant);
begin
  FVLR_OUTRAS := Value;
end;

procedure TPedidoCompraItensModel.SetVST_N23(const Value: Variant);
begin
  FVST_N23 := Value;
end;

procedure TPedidoCompraItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
