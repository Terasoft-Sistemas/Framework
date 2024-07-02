unit CalcularImpostosModel;

interface

uses
  System.Generics.Collections,
  mcibr.motor,
  mcibr.interfaces,
  mcibr.enum.contribuinte.ipi,
  mcibr.enum.contribuinte.icms,
  mcibr.pis,
  mcibr.enum.piscofins,
  mcibr.pisst,
  mcibr.produto,
  mcibr.enum.ipi,
  mcibr.enum.tipo.venda,
  mcibr.utils,
  Interfaces.Conexao;

type
  TCalcularImpostosModel = class

  private
    vIConexao : IConexao;

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
    FTOTAL_PRODUTO: Real;
    FVALORUNITARIO: Real;
    FQUANTIDADE: Real;
    FVALOR_DESCONTO_TOTAL: Real;
    FICMS_VALOR: Real;
    FVICMSUFREMET: Real;
    FVBCUFDEST: Real;
    FVTOTTRIB_FEDERAL: Real;
    FVTOTTRIB_MUNICIPAL: Real;
    FVFCP: Real;
    FPICMSINTER: Real;
    FIPI_BASE: Real;
    FICMSST_BASE: Real;
    FICMS_PCREDSN: Real;
    FVBCFCPST: Real;
    FPIS_VALOR: Real;
    FCOFINS_VALOR: Real;
    FVTOTTRIB_ESTADUAL: Real;
    FICMS_BASE: Real;
    FICMS_VCREDICMSSN: Real;
    FVBCCFP: Real;
    FIPI_VALOR: Real;
    FICMSST_VALOR: Real;
    FPFCPST: Real;
    FPICMSUFDEST: Real;
    FVFCPST: Real;
    FVICMSUFDEST: Real;
    FPIS_BASE: Real;
    FCOFINS_BASE: Real;
    FPICMSINTERPART: Real;
    FCFOP_ID: String;
    FVALOR_ACRESCIMO: Real;
    FACRESCIMO_ITEM: Real;
    FDESCONTO_ITEM: Real;
    FALIQUOTA_FEDERAL: Real;
    FALIQUOTA_MUNICIPAL: Real;
    FALIQUOTA_ESTADUAL: Real;
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
    procedure SetQUANTIDADE(const Value: Real);
    procedure SetTOTAL_PRODUTO(const Value: Real);
    procedure SetVALOR_DESCONTO_TOTAL(const Value: Real);
    procedure SetVALORUNITARIO(const Value: Real);
    procedure SetCOFINS_BASE(const Value: Real);
    procedure SetCOFINS_VALOR(const Value: Real);
    procedure SetICMS_BASE(const Value: Real);
    procedure SetICMS_PCREDSN(const Value: Real);
    procedure SetICMS_VALOR(const Value: Real);
    procedure SetICMS_VCREDICMSSN(const Value: Real);
    procedure SetICMSST_BASE(const Value: Real);
    procedure SetICMSST_VALOR(const Value: Real);
    procedure SetIPI_BASE(const Value: Real);
    procedure SetIPI_VALOR(const Value: Real);
    procedure SetPFCPST(const Value: Real);
    procedure SetPICMSINTER(const Value: Real);
    procedure SetPICMSINTERPART(const Value: Real);
    procedure SetPICMSUFDEST(const Value: Real);
    procedure SetPIS_BASE(const Value: Real);
    procedure SetPIS_VALOR(const Value: Real);
    procedure SetVBCCFP(const Value: Real);
    procedure SetVBCFCPST(const Value: Real);
    procedure SetVBCUFDEST(const Value: Real);
    procedure SetVFCP(const Value: Real);
    procedure SetVFCPST(const Value: Real);
    procedure SetVICMSUFDEST(const Value: Real);
    procedure SetVICMSUFREMET(const Value: Real);
    procedure SetVTOTTRIB_ESTADUAL(const Value: Real);
    procedure SetVTOTTRIB_FEDERAL(const Value: Real);
    procedure SetVTOTTRIB_MUNICIPAL(const Value: Real);
    procedure SetCFOP_ID(const Value: String);

    function obterAliquotas: TCalcularImpostosModel;
    procedure SetVALOR_ACRESCIMO(const Value: Real);
    procedure SetACRESCIMO_ITEM(const Value: Real);
    procedure SetDESCONTO_ITEM(const Value: Real);
    procedure SetALIQUOTA_ESTADUAL(const Value: Real);
    procedure SetALIQUOTA_FEDERAL(const Value: Real);
    procedure SetALIQUOTA_MUNICIPAL(const Value: Real);

  public
    property CFOP_ID                     : String read FCFOP_ID write SetCFOP_ID;
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


    property ICMS_BASE          : Real read FICMS_BASE write SetICMS_BASE;
    property ICMS_VALOR         : Real read FICMS_VALOR write SetICMS_VALOR;
    property ICMS_VCREDICMSSN   : Real read FICMS_VCREDICMSSN write SetICMS_VCREDICMSSN;
    property ICMS_PCREDSN       : Real read FICMS_PCREDSN write SetICMS_PCREDSN;
    property ICMSST_BASE        : Real read FICMSST_BASE write SetICMSST_BASE;
    property ICMSST_VALOR       : Real read FICMSST_VALOR write SetICMSST_VALOR;
    property PICMSINTERPART     : Real read FPICMSINTERPART write SetPICMSINTERPART;
    property PIS_BASE           : Real read FPIS_BASE write SetPIS_BASE;
    property PIS_VALOR          : Real read FPIS_VALOR write SetPIS_VALOR;
    property COFINS_BASE        : Real read FCOFINS_BASE write SetCOFINS_BASE;
    property COFINS_VALOR       : Real read FCOFINS_VALOR write SetCOFINS_VALOR;
    property IPI_BASE           : Real read FIPI_BASE write SetIPI_BASE;
    property IPI_VALOR          : Real read FIPI_VALOR write SetIPI_VALOR;
    property VTOTTRIB_FEDERAL   : Real read FVTOTTRIB_FEDERAL write SetVTOTTRIB_FEDERAL;
    property VTOTTRIB_ESTADUAL  : Real read FVTOTTRIB_ESTADUAL write SetVTOTTRIB_ESTADUAL;
    property VTOTTRIB_MUNICIPAL : Real read FVTOTTRIB_MUNICIPAL write SetVTOTTRIB_MUNICIPAL;
    property VBCUFDEST          : Real read FVBCUFDEST write SetVBCUFDEST;
    property PICMSUFDEST        : Real read FPICMSUFDEST write SetPICMSUFDEST;
    property PICMSINTER         : Real read FPICMSINTER write SetPICMSINTER;
    property VICMSUFDEST        : Real read FVICMSUFDEST write SetVICMSUFDEST;
    property VICMSUFREMET       : Real read FVICMSUFREMET write SetVICMSUFREMET;
    property VBCCFP             : Real read FVBCCFP write SetVBCCFP;
    property VFCP               : Real read FVFCP write SetVFCP;
    property VBCFCPST           : Real read FVBCFCPST write SetVBCFCPST;
    property VFCPST             : Real read FVFCPST write SetVFCPST;
    property PFCPST             : Real read FPFCPST write SetPFCPST;

    //Propriedades para prcessar o calculo
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
    property QUANTIDADE           : Real read FQUANTIDADE write SetQUANTIDADE;
    property VALORUNITARIO        : Real read FVALORUNITARIO write SetVALORUNITARIO;
    property VALOR_DESCONTO_TOTAL : Real read FVALOR_DESCONTO_TOTAL write SetVALOR_DESCONTO_TOTAL;
    property VALOR_ACRESCIMO      : Real read FVALOR_ACRESCIMO write SetVALOR_ACRESCIMO;
    property TOTAL_PRODUTO        : Real read FTOTAL_PRODUTO write SetTOTAL_PRODUTO;

    property DESCONTO_ITEM  : Real read FDESCONTO_ITEM write SetDESCONTO_ITEM;
    property ACRESCIMO_ITEM : Real read FACRESCIMO_ITEM write SetACRESCIMO_ITEM;

    property ALIQUOTA_FEDERAL: Real read FALIQUOTA_FEDERAL write SetALIQUOTA_FEDERAL;
    property ALIQUOTA_ESTADUAL: Real read FALIQUOTA_ESTADUAL write SetALIQUOTA_ESTADUAL;
    property ALIQUOTA_MUNICIPAL: Real read FALIQUOTA_MUNICIPAL write SetALIQUOTA_MUNICIPAL;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Processar: TCalcularImpostosModel;

  end;

var
  lMotor : IImpostoMotor;
  lMotorUtils: TUtils;

implementation

uses
  Terasoft.Utils,
  CalcularImpostosDao,
  System.SysUtils;

{ TCalcularImpostosModel }

constructor TCalcularImpostosModel.Create(pIConexao : IConexao);
begin
  lMotor    := TImpostoMotor.New;
  vIConexao := pIConexao;
end;

destructor TCalcularImpostosModel.Destroy;
begin

  inherited;
end;

function TCalcularImpostosModel.obterAliquotas: TCalcularImpostosModel;
var
  lCalcularImpostosDao: TCalcularImpostosDao;
begin
  lCalcularImpostosDao := TCalcularImpostosDao.Create(vIConexao);

  if (FCODIGO_PRODUTO = '') or (FMODELO_NF = '') or (FDESTINATARIO_UF = '') or (FEMITENTE_UF = '')  then
    CriaException('Produto/modelo nf/uf emitente/uf destinatario devem ser informdos.');

  try
    lCalcularImpostosDao.CODIGO_PRODUTO    := FCODIGO_PRODUTO;
    lCalcularImpostosDao.CODIGO_CLIENTE    := FCODIGO_CLIENTE;
    lCalcularImpostosDao.EMITENTE_UF       := FEMITENTE_UF;
    lCalcularImpostosDao.DESTINATARIO_UF   := FDESTINATARIO_UF;
    lCalcularImpostosDao.MODELO_NF         := FMODELO_NF;

    Result := lCalcularImpostosDao.obterAliquotas;
  finally
    lCalcularImpostosDao.Free;
  end;
end;

function TCalcularImpostosModel.Processar: TCalcularImpostosModel;
var
  lQUANTIDADE            : Real;
  lVALORUNITARIO         : Real;
  lVALOR_DESCONTO_TOTAL  : Real;
  lVALOR_ACRESCIMO_TOTAL : Real;
  lTOTAL_PRODUTO         : Real;
  lRegimeTributario      : String;
begin
  try
    lQUANTIDADE            := Self.FQUANTIDADE;
    lVALORUNITARIO         := Self.FVALORUNITARIO;
    lVALOR_DESCONTO_TOTAL  := Self.FVALOR_DESCONTO_TOTAL;
    lVALOR_ACRESCIMO_TOTAL := Self.FVALOR_ACRESCIMO;
    lTOTAL_PRODUTO         := Self.FTOTAL_PRODUTO;
    lRegimeTributario      := Self.FREGIME_TRIBUTARIO;

    Self := Self.obterAliquotas;

    Self.FQUANTIDADE           := lQUANTIDADE;
    Self.FVALORUNITARIO        := lVALORUNITARIO;
    Self.FVALOR_DESCONTO_TOTAL := lVALOR_DESCONTO_TOTAL;
    Self.FTOTAL_PRODUTO        := lTOTAL_PRODUTO;
    Self.FREGIME_TRIBUTARIO    := lRegimeTributario;

    //Configuracoes
    lMotor.CalcParam.CalcTipo                                  := ctRound;
    lMotor.CalcParam.CalcDecimal                               := 2;
    lMotor.NotaFiscal.Emitente.UFSigla                         := Self.FEMITENTE_UF;
    lMotor.NotaFiscal.Destinatario.UFSigla                     := Self.FDESTINATARIO_UF;
    lMotor.TipoOperacao                                        := lMotorUtils.SelecionaOperacaiDestino(Self.EMITENTE_UF,Self.DESTINATARIO_UF);

    lMotor.NotaFiscal.Emitente.RegimeTributario                := lMotorUtils.SelecionaRegime(Self.FREGIME_TRIBUTARIO);
    lMotor.NotaFiscal.Emitente.ContribuinteIPI                 := lMotorUtils.SelecionaContriIPIRegime('0');
    lMotor.NotaFiscal.Destinatario.ContribuinteICMS            := lMotorUtils.SelecionaContriICMS('1');
    lMotor.NotaFiscal.Produto.TipoVenda                        := lMotorUtils.SelecionaTipoVenda('Revenda');

    lMotor.NotaFiscal.Destinatario.ConsumidorFinal             := True;
    lMotor.NotaFiscal.Destinatario.SomaFreteBaseICMS           := True;
    lMotor.NotaFiscal.Produto.COFINS.ValorBaseExcluirValorICMS := True;
    lMotor.NotaFiscal.Produto.PIS.ValorBaseExcluirValorICMS    := True;
    lMotor.NotaFiscal.Destinatario.AbateDescontoIPI            := True;

     //Dados da nota
    if lTOTAL_PRODUTO > 0 then
      lMotor.NotaFiscal.TotalProdutosNF := lTOTAL_PRODUTO;

    lMotor.NotaFiscal.FreteEmbutidoNF      := 0;
    lMotor.NotaFiscal.AcrescimoNF          := lVALOR_ACRESCIMO_TOTAL;
    lMotor.NotaFiscal.DescontoNF           := lVALOR_DESCONTO_TOTAL;
    lMotor.NotaFiscal.SeguroNF             := 0;
    lMotor.NotaFiscal.DespesasAcessoriasNF := 0;
    lMotor.NotaFiscal.ServicosNF           := 0;

    //Dados do produto
    lMotor.NotaFiscal.Produto.ZerarValores;
    lMotor.NotaFiscal.Produto.CFOP          := StrToIntDef(Self.FCFOP,0);
    lMotor.NotaFiscal.Produto.Quantidade    := lQUANTIDADE;
    lMotor.NotaFiscal.Produto.PrecoUnitario := lVALORUNITARIO;
    lMotor.NotaFiscal.Produto.Acrescimo     := 0;
    lMotor.NotaFiscal.Produto.Desconto      := 0;

    //Dados do ICMS do produto
    lMotor.NotaFiscal.Produto.ICMS.AliquotaInterna     := Self.FICMS_ALIQUOTA;
    lMotor.NotaFiscal.Produto.ICMS.AliquotaInterUF     := Self.FICMS_ALIQUOTA_INTERESTADUAL;
    lMotor.NotaFiscal.Produto.ICMS.BaseReducao         := Self.FICMS_REDUCAO;
    lMotor.NotaFiscal.Produto.ICMS.AliquotaDiferimento := Self.FICMS_REDUCAO;

    if lMotor.NotaFiscal.Emitente.RegimeTributario = TEnumRegimeTributario.rtbSimplesNacional then
      lMotor.NotaFiscal.Produto.ICMS.CSTCSOSN := lMotorUtils.SelecionaCSTCSOSN(Self.FICMS_CSOSN)
    else
      lMotor.NotaFiscal.Produto.ICMS.CSTCSOSN := lMotorUtils.SelecionaCSTCSOSN(Self.FICMS_CST);

    //Dados do st do produto
    lMotor.NotaFiscal.Produto.ICMS.ICMSST.Aliquota            := Self.FICMSST_ALIQUOTA;
    lMotor.NotaFiscal.Produto.ICMS.ICMSST.MargemValorAgregado := Self.FICMSST_MVA;
    lMotor.NotaFiscal.Produto.ICMS.ICMSST.Modalidade          := lMotorUtils.SelecionaModalidadeICMS(Self.FICMSST_MODALIDADE);

    //CST60 Sub
    lMotor.NotaFiscal.Produto.ICMS.ICMSST.ICMSSub.BaseCalculo         := 0;
    lMotor.NotaFiscal.Produto.ICMS.ICMSST.ICMSSub.Aliquota            := 0;
    lMotor.NotaFiscal.Produto.ICMS.ICMSST.ICMSSub.ValorICMSSubstituto := 0;

    //Dados do IPI do produto
    lMotor.NotaFiscal.Produto.IPI.Aliquota := Self.FIPI_ALIQUOTA;
    lMotor.NotaFiscal.Produto.IPI.CST      := lMotorUtils.SelecionaCSTIPI(Self.FIPI_CST);

    //Dados do PIS do produto
    lMotor.NotaFiscal.Produto.PIS.Aliquota := Self.PIS_ALIQUOTA;
    lMotor.NotaFiscal.Produto.PIS.CST      := lMotorUtils.SelecionaCSTPisCofins(Self.FPIS_CST);

    //Dados do COFINS do produto
    lMotor.NotaFiscal.Produto.COFINS.Aliquota := Self.COFINS_ALIQUOTA;
    lMotor.NotaFiscal.Produto.COFINS.CST      := lMotorUtils.SelecionaCSTPisCofins(Self.FCOFINS_CST);

    //Dados do FCP do produto
    lMotor.NotaFiscal.Produto.ICMS.FCP.Aliquota := Self.FPFCP;

    //Dados Partilha
    lMotor.NotaFiscal.Produto.ICMS.DIFAL.AliquotaInter := Self.FICMS_ALIQUOTA_INTERESTADUAL;
    lMotor.NotaFiscal.Produto.ICMS.DIFAL.AliquotaIntra := Self.FICMS_ALIQUOTA;

    //IBPT
    lMotor.NotaFiscal.Produto.IBPT.AliquotaMunicipal := self.ALIQUOTA_MUNICIPAL;
    lMotor.NotaFiscal.Produto.IBPT.AliquotaEstadual  := self.ALIQUOTA_ESTADUAL;
    lMotor.NotaFiscal.Produto.IBPT.AliquotaNacional  := self.ALIQUOTA_FEDERAL;

    lMotor.Processar;

    //======= Rateio =======
    Self.FDESCONTO_ITEM  := lMotor.NotaFiscal.Produto.AsDescontoRateio;
    Self.FACRESCIMO_ITEM := lMotor.NotaFiscal.Produto.AsAcrescimoRateio;



    //======= ICMS =======
    Self.FICMS_ALIQUOTA  := lMotor.NotaFiscal.Produto.ICMS.AsAliquotaUsada;
    Self.FICMS_REDUCAO   := lMotor.NotaFiscal.Produto.ICMS.BaseReducao;
    Self.FICMS_BASE      := lMotor.NotaFiscal.Produto.ICMS.AsValorBase;
    Self.FICMS_VALOR     := lMotor.NotaFiscal.Produto.ICMS.AsValor;

   //======= ISSQN =======
    if lMotor.NotaFiscal.Emitente.RegimeTributario = TEnumRegimeTributario.rtbSimplesNacional then
    begin
      Self.FICMS_VCREDICMSSN := lMotor.NotaFiscal.Produto.ICMS.CreditoSN.AsValor;
      Self.FICMS_PCREDSN     := lMotor.NotaFiscal.Produto.ICMS.CreditoSN.Aliquota;
    end;

    //======= ICMS ST =======

    if lMotor.NotaFiscal.Produto.ICMS.ICMSST.Aliquota > 0 then
    begin
      Self.FICMSST_ALIQUOTA := lMotor.NotaFiscal.Produto.ICMS.ICMSST.Aliquota;
      Self.FICMSST_BASE     := lMotor.NotaFiscal.Produto.ICMS.ICMSST.AsValorBase;
      Self.FICMSST_VALOR    := lMotor.NotaFiscal.Produto.ICMS.ICMSST.AsValor;
      Self.FICMSST_MVA      := lMotor.NotaFiscal.Produto.ICMS.ICMSST.MargemValorAgregado;
      Self.FICMSST_REDUCAO  := lMotor.NotaFiscal.Produto.ICMS.BaseReducao;
      Self.Fpicmsinterpart  := 100;
    end else
    begin
      Self.FICMSST_ALIQUOTA := 0;
      Self.FICMSST_BASE     := 0;
      Self.FICMSST_VALOR    := 0;
      Self.FICMSST_MVA      := 0;
      Self.FICMSST_REDUCAO  := 0;
      Self.Fpicmsinterpart  := 0;
    end;


    //======= PIS =======
    Self.FPIS_BASE     := lMotor.NotaFiscal.Produto.PIS.AsValorBase;
    Self.FPIS_VALOR    := lMotor.NotaFiscal.Produto.PIS.AsValor;
    Self.FPIS_ALIQUOTA := lMotor.NotaFiscal.Produto.PIS.Aliquota;

    //'======= COFINS =======
    Self.FCOFINS_BASE     := lMotor.NotaFiscal.Produto.COFINS.AsValorBase;
    Self.FCOFINS_VALOR    := lMotor.NotaFiscal.Produto.COFINS.AsValor;
    Self.FCOFINS_ALIQUOTA := lMotor.NotaFiscal.Produto.COFINS.Aliquota;

    //======= IPI =======
    if lMotor.NotaFiscal.Produto.IPI.AsValor > 0 then
    begin
      Self.FIPI_BASE     := lMotor.NotaFiscal.Produto.IPI.AsValorBase;
      Self.FIPI_VALOR    := lMotor.NotaFiscal.Produto.IPI.AsValor;
      Self.FIPI_ALIQUOTA := lMotor.NotaFiscal.Produto.IPI.Aliquota;
    end else
    begin
      Self.FIPI_BASE     := 0;
      Self.FIPI_VALOR    := 0;
      Self.FIPI_ALIQUOTA := 0;
    end;

    //======= IBPT =======
    Self.FVTOTTRIB_FEDERAL    := lMotor.NotaFiscal.Produto.IBPT.AsValorNacional;
    Self.FVTOTTRIB_ESTADUAL   := lMotor.NotaFiscal.Produto.IBPT.AsValorEstadual;
    Self.FVTOTTRIB_MUNICIPAL  := lMotor.NotaFiscal.Produto.IBPT.AsValorMunicipal;

    //======= DIFAL =======
    if lMotor.NotaFiscal.Produto.ICMS.DIFAL.AsValorDIFALDestinatario > 0 then
    begin
      Self.Fvbcufdest      := lMotor.NotaFiscal.Produto.ICMS.DIFAL.AsValorBase;
      Self.FPICMSUFDEST    := lMotor.NotaFiscal.Produto.ICMS.DIFAL.AsAliquotaIntra;
      Self.FPICMSINTER     := lMotor.NotaFiscal.Produto.ICMS.DIFAL.AsAliquotaInter;
      Self.FVICMSUFDEST    := lMotor.NotaFiscal.Produto.ICMS.DIFAL.AsValorDIFALDestinatario;
      Self.FPICMSINTERPART := 0;
      Self.FVICMSUFREMET   := 0;
    end else
    begin
      Self.Fvbcufdest      := 0;
      Self.FPICMSUFDEST    := 0;
      Self.FPICMSINTER     := 0;
      Self.FVICMSUFDEST    := 0;
      Self.FPICMSINTERPART := 0;
      Self.FVICMSUFREMET   := 0;
    end;

    //======= FCP =======
    if lMotor.NotaFiscal.Produto.ICMS.FCP.AsValor > 0 then
    begin
      Self.FVBCCFP := lMotor.NotaFiscal.Produto.ICMS.FCP.AsValorBase;
      Self.FVFCP   := lMotor.NotaFiscal.Produto.ICMS.FCP.AsValor;
      Self.FPFCP   := lMotor.NotaFiscal.Produto.ICMS.FCP.Aliquota;
    end else
    begin
      Self.FVBCCFP := 0;
      Self.FVFCP   := 0;
      Self.FPFCP   := 0;
    end;

    //======= FCP ST ====
    if lMotor.NotaFiscal.Produto.ICMS.FCP.FCPST.AsValor > 0 then
    begin
      Self.FVBCFCPST := lMotor.NotaFiscal.Produto.ICMS.FCP.FCPST.AsValorBase;
      Self.FVFCPST   := lMotor.NotaFiscal.Produto.ICMS.FCP.FCPST.AsValor;
      Self.FPFCPST   := lMotor.NotaFiscal.Produto.ICMS.FCP.Aliquota;
    end else
    begin
      Self.FVBCFCPST := 0;
      Self.FVFCPST   := 0;
      Self.FPFCPST   := 0;
    end;

    Result := Self;

  finally

  end;
end;

procedure TCalcularImpostosModel.SetABATEDESCONTO_IPI(const Value: String);
begin
  FABATEDESCONTO_IPI := Value;
end;

procedure TCalcularImpostosModel.SetACRESCIMO_ITEM(const Value: Real);
begin
  FACRESCIMO_ITEM := Value;
end;

procedure TCalcularImpostosModel.SetALIQUOTA_ESTADUAL(const Value: Real);
begin
  FALIQUOTA_ESTADUAL := Value;
end;

procedure TCalcularImpostosModel.SetALIQUOTA_FEDERAL(const Value: Real);
begin
  FALIQUOTA_FEDERAL := Value;
end;

procedure TCalcularImpostosModel.SetALIQUOTA_MUNICIPAL(const Value: Real);
begin
  FALIQUOTA_MUNICIPAL := Value;
end;

procedure TCalcularImpostosModel.SetCFOP(const Value: String);
begin
  FCFOP := Value;
end;

procedure TCalcularImpostosModel.SetCFOP_ID(const Value: String);
begin
  FCFOP_ID := Value;
end;

procedure TCalcularImpostosModel.SetCODIGO_CLIENTE(const Value: String);
begin
  FCODIGO_CLIENTE := Value;
end;

procedure TCalcularImpostosModel.SetCODIGO_PRODUTO(const Value: String);
begin
  FCODIGO_PRODUTO := Value;
end;

procedure TCalcularImpostosModel.SetCOFINS_ALIQUOTA(const Value: Real);
begin
  FCOFINS_ALIQUOTA := Value;
end;

procedure TCalcularImpostosModel.SetCOFINS_BASE(const Value: Real);
begin
  FCOFINS_BASE := Value;
end;

procedure TCalcularImpostosModel.SetCOFINS_CST(const Value: String);
begin
  FCOFINS_CST := Value;
end;

procedure TCalcularImpostosModel.SetCOFINS_VALOR(const Value: Real);
begin
  FCOFINS_VALOR := Value;
end;

procedure TCalcularImpostosModel.SetCOFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS(
  const Value: String);
begin
  FCOFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS := Value;
end;

procedure TCalcularImpostosModel.SetCONSUMIDOR_FINAL(const Value: String);
begin
  FCONSUMIDOR_FINAL := Value;
end;

procedure TCalcularImpostosModel.SetCONTRIBUINTE_ICMS(const Value: String);
begin
  FCONTRIBUINTE_ICMS := Value;
end;

procedure TCalcularImpostosModel.SetCONTRIBUINTE_IPI(const Value: String);
begin
  FCONTRIBUINTE_IPI := Value;
end;

procedure TCalcularImpostosModel.SetDESCONTO_ITEM(const Value: Real);
begin
  FDESCONTO_ITEM := Value;
end;

procedure TCalcularImpostosModel.SetDESTINATARIO_UF(const Value: String);
begin
  FDESTINATARIO_UF := Value;
end;

procedure TCalcularImpostosModel.SetEMITENTE_UF(const Value: String);
begin
  FEMITENTE_UF := Value;
end;

procedure TCalcularImpostosModel.SetICMSST_ALIQUOTA(const Value: Real);
begin
  FICMSST_ALIQUOTA := Value;
end;

procedure TCalcularImpostosModel.SetICMSST_BASE(const Value: Real);
begin
  FICMSST_BASE := Value;
end;

procedure TCalcularImpostosModel.SetICMSST_MODALIDADE(const Value: String);
begin
  FICMSST_MODALIDADE := Value;
end;

procedure TCalcularImpostosModel.SetICMSST_MVA(const Value: Real);
begin
  FICMSST_MVA := Value;
end;

procedure TCalcularImpostosModel.SetICMSST_REDUCAO(const Value: Real);
begin
  FICMSST_REDUCAO := Value;
end;

procedure TCalcularImpostosModel.SetICMSST_VALOR(const Value: Real);
begin
  FICMSST_VALOR := Value;
end;

procedure TCalcularImpostosModel.SetICMS_ALIQUOTA(const Value: Real);
begin
  FICMS_ALIQUOTA := Value;
end;

procedure TCalcularImpostosModel.SetICMS_ALIQUOTA_INTERESTADUAL(
  const Value: Real);
begin
  FICMS_ALIQUOTA_INTERESTADUAL := Value;
end;

procedure TCalcularImpostosModel.SetICMS_BASE(const Value: Real);
begin
  FICMS_BASE := Value;
end;

procedure TCalcularImpostosModel.SetICMS_CSOSN(const Value: String);
begin
  FICMS_CSOSN := Value;
end;

procedure TCalcularImpostosModel.SetICMS_CST(const Value: String);
begin
  FICMS_CST := Value;
end;

procedure TCalcularImpostosModel.SetICMS_MODADEDADE(const Value: String);
begin
  FICMS_MODADEDADE := Value;
end;

procedure TCalcularImpostosModel.SetICMS_PCREDSN(const Value: Real);
begin
  FICMS_PCREDSN := Value;
end;

procedure TCalcularImpostosModel.SetICMS_REDUCAO(const Value: Real);
begin
  FICMS_REDUCAO := Value;
end;

procedure TCalcularImpostosModel.SetICMS_SOMA_FRETE_BASE(const Value: String);
begin
  FICMS_SOMA_FRETE_BASE := Value;
end;

procedure TCalcularImpostosModel.SetICMS_VALOR(const Value: Real);
begin
  FICMS_VALOR := Value;
end;

procedure TCalcularImpostosModel.SetICMS_VCREDICMSSN(const Value: Real);
begin
  FICMS_VCREDICMSSN := Value;
end;

procedure TCalcularImpostosModel.SetIPI_ALIQUOTA(const Value: Real);
begin
  FIPI_ALIQUOTA := Value;
end;

procedure TCalcularImpostosModel.SetIPI_BASE(const Value: Real);
begin
  FIPI_BASE := Value;
end;

procedure TCalcularImpostosModel.SetIPI_CST(const Value: String);
begin
  FIPI_CST := Value;
end;

procedure TCalcularImpostosModel.SetIPI_VALOR(const Value: Real);
begin
  FIPI_VALOR := Value;
end;

procedure TCalcularImpostosModel.SetMODELO_NF(const Value: String);
begin
  FMODELO_NF := Value;
end;

procedure TCalcularImpostosModel.SetPFCP(const Value: Real);
begin
  FPFCP := Value;
end;

procedure TCalcularImpostosModel.SetPFCPST(const Value: Real);
begin
  FPFCPST := Value;
end;

procedure TCalcularImpostosModel.SetPICMSINTER(const Value: Real);
begin
  FPICMSINTER := Value;
end;

procedure TCalcularImpostosModel.SetPICMSINTERPART(const Value: Real);
begin
  FPICMSINTERPART := Value;
end;

procedure TCalcularImpostosModel.SetPICMSUFDEST(const Value: Real);
begin
  FPICMSUFDEST := Value;
end;

procedure TCalcularImpostosModel.SetPIS_ALIQUOTA(const Value: Real);
begin
  FPIS_ALIQUOTA := Value;
end;

procedure TCalcularImpostosModel.SetPIS_BASE(const Value: Real);
begin
  FPIS_BASE := Value;
end;

procedure TCalcularImpostosModel.SetPIS_CST(const Value: String);
begin
  FPIS_CST := Value;
end;

procedure TCalcularImpostosModel.SetPIS_VALOR(const Value: Real);
begin
  FPIS_VALOR := Value;
end;

procedure TCalcularImpostosModel.SetPIS_VALOR_BASE_EXCLUIR_VALOR_ICMS(
  const Value: String);
begin
  FPIS_VALOR_BASE_EXCLUIR_VALOR_ICMS := Value;
end;

procedure TCalcularImpostosModel.SetQUANTIDADE(const Value: Real);
begin
  FQUANTIDADE := Value;
end;

procedure TCalcularImpostosModel.SetREGIME_TRIBUTARIO(const Value: String);
begin
  FREGIME_TRIBUTARIO := Value;
end;

procedure TCalcularImpostosModel.SetTOTAL_PRODUTO(const Value: Real);
begin
  FTOTAL_PRODUTO := Value;
end;

procedure TCalcularImpostosModel.SetVALORUNITARIO(const Value: Real);
begin
  FVALORUNITARIO := Value;
end;

procedure TCalcularImpostosModel.SetVALOR_ACRESCIMO(const Value: Real);
begin
  FVALOR_ACRESCIMO := Value;
end;

procedure TCalcularImpostosModel.SetVALOR_DESCONTO_TOTAL(const Value: Real);
begin
  FVALOR_DESCONTO_TOTAL := Value;
end;

procedure TCalcularImpostosModel.SetVBCCFP(const Value: Real);
begin
  FVBCCFP := Value;
end;

procedure TCalcularImpostosModel.SetVBCFCPST(const Value: Real);
begin
  FVBCFCPST := Value;
end;

procedure TCalcularImpostosModel.SetVBCUFDEST(const Value: Real);
begin
  FVBCUFDEST := Value;
end;

procedure TCalcularImpostosModel.SetVFCP(const Value: Real);
begin
  FVFCP := Value;
end;

procedure TCalcularImpostosModel.SetVFCPST(const Value: Real);
begin
  FVFCPST := Value;
end;

procedure TCalcularImpostosModel.SetVICMSUFDEST(const Value: Real);
begin
  FVICMSUFDEST := Value;
end;

procedure TCalcularImpostosModel.SetVICMSUFREMET(const Value: Real);
begin
  FVICMSUFREMET := Value;
end;

procedure TCalcularImpostosModel.SetVTOTTRIB_ESTADUAL(const Value: Real);
begin
  FVTOTTRIB_ESTADUAL := Value;
end;

procedure TCalcularImpostosModel.SetVTOTTRIB_FEDERAL(const Value: Real);
begin
  FVTOTTRIB_FEDERAL := Value;
end;

procedure TCalcularImpostosModel.SetVTOTTRIB_MUNICIPAL(const Value: Real);
begin
  FVTOTTRIB_MUNICIPAL := Value;
end;

end.
