unit ObtemAliquotasModel;

interface

uses
  System.Generics.Collections;

type
  TObtemAliquotasModel = class

  private
    FDESTINATARIO_UF: String;
    FICMS_SOMA_FRETE_BASE: String;
    FICMS_REDUCAO: Real;
    FPIS_VALOR_BASE_EXCLUIR_VALOR_ICMS: String;
    FCOFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS: String;
    FPIS_CST: String;
    FIPI_ALIQUOTA: Real;
    FCOFINS_CST: String;
    FPFCP: Real;
    FICMSST_ALIQUOTA: Real;
    FCONSUMIDOR_FINAL: String;
    FICMS_MODADEDADE: String;
    FCONTRIBUINTE_IPI: String;
    FICMSST_MODALIDADE: String;
    FEMITENTE_UF: String;
    FIPI_CST: String;
    FICMS_ALIQUOTA: Real;
    FCFOP: String;
    FICMS_ALIQUOTA_INTERESTADUAL: Real;
    FCONTRIBUINTE_ICMS: String;
    FICMSST_REDUCAO: Real;
    FICMS_CST: String;
    FABATEDESCONTO_IPI: String;
    FREGIME_TRIBUTARIO: String;
    FPIS_ALIQUOTA: Real;
    FICMS_CSOSN: String;
    FCOFINS_ALIQUOTA: Real;
    FICMSST_MVA: Real;
    FCODIGO_PRODUTO: String;
    FCODIGO_CLIENTE: String;
    FMODELO_NF: String;
    procedure SetABATEDESCONTO_IPI(const Value: String);
    procedure SetCFOP(const Value: String);
    procedure SetCOFINS_ALIQUOTA(const Value: Real);
    procedure SetCOFINS_CST(const Value: String);
    procedure SetCOFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS(const Value: String);
    procedure SetCONSUMIDOR_FINAL(const Value: String);
    procedure SetCONTRIBUINTE_ICMS(const Value: String);
    procedure SetCONTRIBUINTE_IPI(const Value: String);
    procedure SetDESTINATARIO_UF(const Value: String);
    procedure SetEMITENTE_UF(const Value: String);
    procedure SetICMS_ALIQUOTA(const Value: Real);
    procedure SetICMS_ALIQUOTA_INTERESTADUAL(const Value: Real);
    procedure SetICMS_CSOSN(const Value: String);
    procedure SetICMS_CST(const Value: String);
    procedure SetICMS_MODADEDADE(const Value: String);
    procedure SetICMS_REDUCAO(const Value: Real);
    procedure SetICMS_SOMA_FRETE_BASE(const Value: String);
    procedure SetICMSST_ALIQUOTA(const Value: Real);
    procedure SetICMSST_MODALIDADE(const Value: String);
    procedure SetICMSST_MVA(const Value: Real);
    procedure SetICMSST_REDUCAO(const Value: Real);
    procedure SetIPI_ALIQUOTA(const Value: Real);
    procedure SetIPI_CST(const Value: String);
    procedure SetPFCP(const Value: Real);
    procedure SetPIS_ALIQUOTA(const Value: Real);
    procedure SetPIS_CST(const Value: String);
    procedure SetPIS_VALOR_BASE_EXCLUIR_VALOR_ICMS(const Value: String);
    procedure SetREGIME_TRIBUTARIO(const Value: String);
    procedure SetCODIGO_PRODUTO(const Value: String);
    procedure SetCODIGO_CLIENTE(const Value: String);
    procedure SetMODELO_NF(const Value: String);

  public
    property CFOP                        : String read FCFOP write SetCFOP;
    property ICMS_CST                    : String read FICMS_CST write SetICMS_CST;
    property ICMS_CSOSN                  : String read FICMS_CSOSN write SetICMS_CSOSN;
    property ICMS_MODADEDADE             : String read FICMS_MODADEDADE write SetICMS_MODADEDADE;
    property ICMS_REDUCAO                : Real read FICMS_REDUCAO write SetICMS_REDUCAO;
    property ICMS_ALIQUOTA               : Real read FICMS_ALIQUOTA write SetICMS_ALIQUOTA;
    property ICMS_ALIQUOTA_INTERESTADUAL : Real read FICMS_ALIQUOTA_INTERESTADUAL write SetICMS_ALIQUOTA_INTERESTADUAL;
    property ICMSST_MODALIDADE           : String read FICMSST_MODALIDADE write SetICMSST_MODALIDADE;
    property ICMSST_REDUCAO              : Real read FICMSST_REDUCAO write SetICMSST_REDUCAO;
    property ICMSST_MVA                  : Real read FICMSST_MVA write SetICMSST_MVA;
    property ICMSST_ALIQUOTA             : Real read FICMSST_ALIQUOTA write SetICMSST_ALIQUOTA;
    property PFCP                        : Real read FPFCP write SetPFCP;
    property PIS_CST                     : String read FPIS_CST write SetPIS_CST;
    property PIS_ALIQUOTA                : Real read FPIS_ALIQUOTA write SetPIS_ALIQUOTA;
    property COFINS_CST                  : String read FCOFINS_CST write SetCOFINS_CST;
    property COFINS_ALIQUOTA             : Real read FCOFINS_ALIQUOTA write SetCOFINS_ALIQUOTA;
    property IPI_CST                     : String read FIPI_CST write SetIPI_CST;
    property IPI_ALIQUOTA                : Real read FIPI_ALIQUOTA write SetIPI_ALIQUOTA;

    property CONSUMIDOR_FINAL            : String read FCONSUMIDOR_FINAL write SetCONSUMIDOR_FINAL;
    property REGIME_TRIBUTARIO           : String read FREGIME_TRIBUTARIO write SetREGIME_TRIBUTARIO;
    property CONTRIBUINTE_ICMS           : String read FCONTRIBUINTE_ICMS write SetCONTRIBUINTE_ICMS;
    property CONTRIBUINTE_IPI            : String read FCONTRIBUINTE_IPI write SetCONTRIBUINTE_IPI;
    property ABATEDESCONTO_IPI           : String read FABATEDESCONTO_IPI write SetABATEDESCONTO_IPI;

    property ICMS_SOMA_FRETE_BASE                 : String read FICMS_SOMA_FRETE_BASE write SetICMS_SOMA_FRETE_BASE;
    property COFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS : String read FCOFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS write SetCOFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS;
    property PIS_VALOR_BASE_EXCLUIR_VALOR_ICMS    : String read FPIS_VALOR_BASE_EXCLUIR_VALOR_ICMS write SetPIS_VALOR_BASE_EXCLUIR_VALOR_ICMS;


    property CODIGO_PRODUTO  : String read FCODIGO_PRODUTO write SetCODIGO_PRODUTO;
    property CODIGO_CLIENTE  : String read FCODIGO_CLIENTE write SetCODIGO_CLIENTE;
    property EMITENTE_UF     : String read FEMITENTE_UF write SetEMITENTE_UF;
    property DESTINATARIO_UF : String read FDESTINATARIO_UF write SetDESTINATARIO_UF;
    property MODELO_NF       : String read FMODELO_NF write SetMODELO_NF;

  	constructor Create;
    destructor Destroy; override;

    function obterImpostos: TObtemAliquotasModel;

  end;

implementation

uses
  ObtemAliquotasDao, mcibr.utils, Terasoft.Utils;

{ TObtemAliquotasModel }



constructor TObtemAliquotasModel.Create;
begin

end;

destructor TObtemAliquotasModel.Destroy;
begin

  inherited;
end;

function TObtemAliquotasModel.obterImpostos: TObtemAliquotasModel;
var
  lObtemAliquotasDao: TObtemAliquotasDao;
begin
  lObtemAliquotasDao := TObtemAliquotasDao.Create;

  if (FCODIGO_PRODUTO = '') or (FMODELO_NF = '') or (FDESTINATARIO_UF = '') or (FEMITENTE_UF = '')  then
    CriaException('Produto/modelo nf/uf emitente/uf destinatario devem ser informdos.');

  try
    lObtemAliquotasDao.CODIGO_PRODUTO    := FCODIGO_PRODUTO;
    lObtemAliquotasDao.CODIGO_CLIENTE    := FCODIGO_CLIENTE;
    lObtemAliquotasDao.EMITENTE_UF       := FEMITENTE_UF;
    lObtemAliquotasDao.DESTINATARIO_UF   := FDESTINATARIO_UF;
    lObtemAliquotasDao.MODELO_NF         := FMODELO_NF;

    Result := lObtemAliquotasDao.obterImpostos;
  finally
    lObtemAliquotasDao.Free;
  end;
end;


procedure TObtemAliquotasModel.SetABATEDESCONTO_IPI(const Value: String);
begin
  FABATEDESCONTO_IPI := Value;
end;

procedure TObtemAliquotasModel.SetCFOP(const Value: String);
begin
  FCFOP := Value;
end;

procedure TObtemAliquotasModel.SetCODIGO_CLIENTE(const Value: String);
begin
  FCODIGO_CLIENTE := Value;
end;

procedure TObtemAliquotasModel.SetCODIGO_PRODUTO(const Value: String);
begin
  FCODIGO_PRODUTO := Value;
end;

procedure TObtemAliquotasModel.SetCOFINS_ALIQUOTA(const Value: Real);
begin
  FCOFINS_ALIQUOTA := Value;
end;

procedure TObtemAliquotasModel.SetCOFINS_CST(const Value: String);
begin
  FCOFINS_CST := Value;
end;

procedure TObtemAliquotasModel.SetCOFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS(
  const Value: String);
begin
  FCOFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS := Value;
end;

procedure TObtemAliquotasModel.SetCONSUMIDOR_FINAL(const Value: String);
begin
  FCONSUMIDOR_FINAL := Value;
end;

procedure TObtemAliquotasModel.SetCONTRIBUINTE_ICMS(const Value: String);
begin
  FCONTRIBUINTE_ICMS := Value;
end;

procedure TObtemAliquotasModel.SetCONTRIBUINTE_IPI(const Value: String);
begin
  FCONTRIBUINTE_IPI := Value;
end;

procedure TObtemAliquotasModel.SetDESTINATARIO_UF(const Value: String);
begin
  FDESTINATARIO_UF := Value;
end;

procedure TObtemAliquotasModel.SetEMITENTE_UF(const Value: String);
begin
  FEMITENTE_UF := Value;
end;

procedure TObtemAliquotasModel.SetICMSST_ALIQUOTA(const Value: Real);
begin
  FICMSST_ALIQUOTA := Value;
end;

procedure TObtemAliquotasModel.SetICMSST_MODALIDADE(const Value: String);
begin
  FICMSST_MODALIDADE := Value;
end;

procedure TObtemAliquotasModel.SetICMSST_MVA(const Value: Real);
begin
  FICMSST_MVA := Value;
end;

procedure TObtemAliquotasModel.SetICMSST_REDUCAO(const Value: Real);
begin
  FICMSST_REDUCAO := Value;
end;

procedure TObtemAliquotasModel.SetICMS_ALIQUOTA(const Value: Real);
begin
  FICMS_ALIQUOTA := Value;
end;

procedure TObtemAliquotasModel.SetICMS_ALIQUOTA_INTERESTADUAL(
  const Value: Real);
begin
  FICMS_ALIQUOTA_INTERESTADUAL := Value;
end;

procedure TObtemAliquotasModel.SetICMS_CSOSN(const Value: String);
begin
  FICMS_CSOSN := Value;
end;

procedure TObtemAliquotasModel.SetICMS_CST(const Value: String);
begin
  FICMS_CST := Value;
end;

procedure TObtemAliquotasModel.SetICMS_MODADEDADE(const Value: String);
begin
  FICMS_MODADEDADE := Value;
end;

procedure TObtemAliquotasModel.SetICMS_REDUCAO(const Value: Real);
begin
  FICMS_REDUCAO := Value;
end;

procedure TObtemAliquotasModel.SetICMS_SOMA_FRETE_BASE(const Value: String);
begin
  FICMS_SOMA_FRETE_BASE := Value;
end;

procedure TObtemAliquotasModel.SetIPI_ALIQUOTA(const Value: Real);
begin
  FIPI_ALIQUOTA := Value;
end;

procedure TObtemAliquotasModel.SetIPI_CST(const Value: String);
begin
  FIPI_CST := Value;
end;

procedure TObtemAliquotasModel.SetMODELO_NF(const Value: String);
begin
  FMODELO_NF := Value;
end;

procedure TObtemAliquotasModel.SetPFCP(const Value: Real);
begin
  FPFCP := Value;
end;

procedure TObtemAliquotasModel.SetPIS_ALIQUOTA(const Value: Real);
begin
  FPIS_ALIQUOTA := Value;
end;

procedure TObtemAliquotasModel.SetPIS_CST(const Value: String);
begin
  FPIS_CST := Value;
end;

procedure TObtemAliquotasModel.SetPIS_VALOR_BASE_EXCLUIR_VALOR_ICMS(
  const Value: String);
begin
  FPIS_VALOR_BASE_EXCLUIR_VALOR_ICMS := Value;
end;

procedure TObtemAliquotasModel.SetREGIME_TRIBUTARIO(const Value: String);
begin
  FREGIME_TRIBUTARIO := Value;
end;

end.
