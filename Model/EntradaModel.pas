unit EntradaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao, FireDAC.Comp.Client;

type
  TEntradaModel = class

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
    FCONDICOES_XML: Variant;
    FOBS_CHECAGEM: Variant;
    FTRANSFERENCIA_SAIDA_ID: Variant;
    FBASE_ST: Variant;
    FDATAHORA_CHECAGEM: Variant;
    FVII_W11: Variant;
    FTAXA_ENT: Variant;
    FTIPO_PRO: Variant;
    FOBSERVACAO_ENT: Variant;
    FCODIGO_FOR: Variant;
    FPORTADOR_ID: Variant;
    FPARCELAS_XML: Variant;
    FVFCP: Variant;
    FPEDIDO_COMPRA: Variant;
    FTOTALPRODUTOS_ENT: Variant;
    FDATAMOVI_ENT: Variant;
    FORCAMENTO_ID: Variant;
    FFRETE_ENT_2: Variant;
    FNUMERO_SAI: Variant;
    FVBCIRRF_W27: Variant;
    FCHECAGEM: Variant;
    FVRETCSLL_W26: Variant;
    FDATAHORA_CHECAGEM_INICIO: Variant;
    FPEDIDO_ID: Variant;
    FICMS_ENT: Variant;
    FARQ_NFE: Variant;
    FTIPO_FRETE: Variant;
    FSEG_W09: Variant;
    FVIRRF_W28: Variant;
    FDATANOTA_ENT: Variant;
    FID: Variant;
    FSERIE_ENT: Variant;
    FTOTAL_ENT: Variant;
    FMODELO_ENT: Variant;
    FDEVOLUCAO_PEDIDO_ID: Variant;
    FDESCONTO_NO_CUSTO: Variant;
    FICMS_ST: Variant;
    FNUMERO_NF: Variant;
    FLOJA: Variant;
    FCFOP_ENT: Variant;
    FSTATUS: Variant;
    FNUMERO_ENT: Variant;
    FCFOP_ID: Variant;
    FCONDICOES_PAG: Variant;
    FDESPESAS_ADUANEIRAS: Variant;
    FTRANSFERENCIA_LOJA: Variant;
    FEMPRESA: Variant;
    FVRETPIS_W24: Variant;
    FOUTROS_ENT: Variant;
    FFINALIZADE: Variant;
    FSYSTIME: Variant;
    FPIS_ENT: Variant;
    FSAIDAS_ID: Variant;
    FPEDIDOCOMPRA_ID: Variant;
    FVRETCOFINS_W25: Variant;
    FCOFINS_ENT: Variant;
    FCONTROLE_CHECAGEM: Variant;
    FVRETPREV_W30: Variant;
    FDOLAR: Variant;
    FPRODUCAO_ID: Variant;
    FUSUARIO_CHECAGEM: Variant;
    FCONTA_ID: Variant;
    FPRIMEIROVENC_ENT: Variant;
    FPARCELAS_ENT: Variant;
    FVFCPST: Variant;
    FAGUARDANDO_ENTREGA: Variant;
    FUSUARIO_ENT: Variant;
    FDESC_ENT: Variant;
    FFRETE_ENT: Variant;
    FVBCRETPREV_W29: Variant;
    FID_A03: Variant;
    FOS_ID: Variant;
    FST_GUIA: Variant;
    FIPI_ENT: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetAGUARDANDO_ENTREGA(const Value: Variant);
    procedure SetARQ_NFE(const Value: Variant);
    procedure SetBASE_ST(const Value: Variant);
    procedure SetCFOP_ENT(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCHECAGEM(const Value: Variant);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCOFINS_ENT(const Value: Variant);
    procedure SetCONDICOES_PAG(const Value: Variant);
    procedure SetCONDICOES_XML(const Value: Variant);
    procedure SetCONTA_ID(const Value: Variant);
    procedure SetCONTROLE_CHECAGEM(const Value: Variant);
    procedure SetDATAHORA_CHECAGEM(const Value: Variant);
    procedure SetDATAHORA_CHECAGEM_INICIO(const Value: Variant);
    procedure SetDATAMOVI_ENT(const Value: Variant);
    procedure SetDATANOTA_ENT(const Value: Variant);
    procedure SetDESC_ENT(const Value: Variant);
    procedure SetDESCONTO_NO_CUSTO(const Value: Variant);
    procedure SetDESPESAS_ADUANEIRAS(const Value: Variant);
    procedure SetDEVOLUCAO_PEDIDO_ID(const Value: Variant);
    procedure SetDOLAR(const Value: Variant);
    procedure SetEMPRESA(const Value: Variant);
    procedure SetFINALIZADE(const Value: Variant);
    procedure SetFRETE_ENT(const Value: Variant);
    procedure SetFRETE_ENT_2(const Value: Variant);
    procedure SetICMS_ENT(const Value: Variant);
    procedure SetICMS_ST(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetID_A03(const Value: Variant);
    procedure SetIPI_ENT(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetMODELO_ENT(const Value: Variant);
    procedure SetNUMERO_ENT(const Value: Variant);
    procedure SetNUMERO_NF(const Value: Variant);
    procedure SetNUMERO_SAI(const Value: Variant);
    procedure SetOBS_CHECAGEM(const Value: Variant);
    procedure SetOBSERVACAO_ENT(const Value: Variant);
    procedure SetORCAMENTO_ID(const Value: Variant);
    procedure SetOS_ID(const Value: Variant);
    procedure SetOUTROS_ENT(const Value: Variant);
    procedure SetPARCELAS_ENT(const Value: Variant);
    procedure SetPARCELAS_XML(const Value: Variant);
    procedure SetPEDIDO_COMPRA(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetPEDIDOCOMPRA_ID(const Value: Variant);
    procedure SetPIS_ENT(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetPRIMEIROVENC_ENT(const Value: Variant);
    procedure SetPRODUCAO_ID(const Value: Variant);
    procedure SetSAIDAS_ID(const Value: Variant);
    procedure SetSEG_W09(const Value: Variant);
    procedure SetSERIE_ENT(const Value: Variant);
    procedure SetST_GUIA(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAXA_ENT(const Value: Variant);
    procedure SetTIPO_FRETE(const Value: Variant);
    procedure SetTIPO_PRO(const Value: Variant);
    procedure SetTOTAL_ENT(const Value: Variant);
    procedure SetTOTALPRODUTOS_ENT(const Value: Variant);
    procedure SetTRANSFERENCIA_LOJA(const Value: Variant);
    procedure SetTRANSFERENCIA_SAIDA_ID(const Value: Variant);
    procedure SetUSUARIO_CHECAGEM(const Value: Variant);
    procedure SetUSUARIO_ENT(const Value: Variant);
    procedure SetVBCIRRF_W27(const Value: Variant);
    procedure SetVBCRETPREV_W29(const Value: Variant);
    procedure SetVFCP(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetVII_W11(const Value: Variant);
    procedure SetVIRRF_W28(const Value: Variant);
    procedure SetVRETCOFINS_W25(const Value: Variant);
    procedure SetVRETCSLL_W26(const Value: Variant);
    procedure SetVRETPIS_W24(const Value: Variant);
    procedure SetVRETPREV_W30(const Value: Variant);

  public

    property NUMERO_ENT : Variant  read FNUMERO_ENT write SetNUMERO_ENT;
    property CODIGO_FOR : Variant  read FCODIGO_FOR write SetCODIGO_FOR;
    property DATANOTA_ENT : Variant  read FDATANOTA_ENT write SetDATANOTA_ENT;
    property DATAMOVI_ENT : Variant  read FDATAMOVI_ENT write SetDATAMOVI_ENT;
    property PARCELAS_ENT : Variant  read FPARCELAS_ENT write SetPARCELAS_ENT;
    property PRIMEIROVENC_ENT : Variant  read FPRIMEIROVENC_ENT write SetPRIMEIROVENC_ENT;
    property FRETE_ENT : Variant  read FFRETE_ENT write SetFRETE_ENT;
    property IPI_ENT : Variant  read FIPI_ENT write SetIPI_ENT;
    property ICMS_ENT : Variant  read FICMS_ENT write SetICMS_ENT;
    property OUTROS_ENT : Variant  read FOUTROS_ENT write SetOUTROS_ENT;
    property DESC_ENT : Variant  read FDESC_ENT write SetDESC_ENT;
    property TOTAL_ENT : Variant  read FTOTAL_ENT write SetTOTAL_ENT;
    property OBSERVACAO_ENT : Variant  read FOBSERVACAO_ENT write SetOBSERVACAO_ENT;
    property USUARIO_ENT : Variant  read FUSUARIO_ENT write SetUSUARIO_ENT;
    property STATUS : Variant  read FSTATUS write SetSTATUS;
    property TOTALPRODUTOS_ENT : Variant  read FTOTALPRODUTOS_ENT write SetTOTALPRODUTOS_ENT;
    property TIPO_PRO : Variant  read FTIPO_PRO write SetTIPO_PRO;
    property CFOP_ENT : Variant  read FCFOP_ENT write SetCFOP_ENT;
    property DESPESAS_ADUANEIRAS : Variant  read FDESPESAS_ADUANEIRAS write SetDESPESAS_ADUANEIRAS;
    property PIS_ENT : Variant  read FPIS_ENT write SetPIS_ENT;
    property COFINS_ENT : Variant  read FCOFINS_ENT write SetCOFINS_ENT;
    property TAXA_ENT : Variant  read FTAXA_ENT write SetTAXA_ENT;
    property LOJA : Variant  read FLOJA write SetLOJA;
    property DOLAR : Variant  read FDOLAR write SetDOLAR;
    property ICMS_ST : Variant  read FICMS_ST write SetICMS_ST;
    property BASE_ST : Variant  read FBASE_ST write SetBASE_ST;
    property TIPO_FRETE : Variant  read FTIPO_FRETE write SetTIPO_FRETE;
    property NUMERO_NF : Variant  read FNUMERO_NF write SetNUMERO_NF;
    property SERIE_ENT : Variant  read FSERIE_ENT write SetSERIE_ENT;
    property MODELO_ENT : Variant  read FMODELO_ENT write SetMODELO_ENT;
    property CONDICOES_PAG : Variant  read FCONDICOES_PAG write SetCONDICOES_PAG;
    property ID_A03 : Variant  read FID_A03 write SetID_A03;
    property SEG_W09 : Variant  read FSEG_W09 write SetSEG_W09;
    property VII_W11 : Variant  read FVII_W11 write SetVII_W11;
    property VRETPIS_W24 : Variant  read FVRETPIS_W24 write SetVRETPIS_W24;
    property VRETCOFINS_W25 : Variant  read FVRETCOFINS_W25 write SetVRETCOFINS_W25;
    property VRETCSLL_W26 : Variant  read FVRETCSLL_W26 write SetVRETCSLL_W26;
    property VBCIRRF_W27 : Variant  read FVBCIRRF_W27 write SetVBCIRRF_W27;
    property VIRRF_W28 : Variant  read FVIRRF_W28 write SetVIRRF_W28;
    property VBCRETPREV_W29 : Variant  read FVBCRETPREV_W29 write SetVBCRETPREV_W29;
    property VRETPREV_W30 : Variant  read FVRETPREV_W30 write SetVRETPREV_W30;
    property ARQ_NFE : Variant  read FARQ_NFE write SetARQ_NFE;
    property EMPRESA : Variant  read FEMPRESA write SetEMPRESA;
    property PEDIDO_COMPRA : Variant  read FPEDIDO_COMPRA write SetPEDIDO_COMPRA;
    property ID : Variant  read FID write SetID;
    property ST_GUIA : Variant  read FST_GUIA write SetST_GUIA;
    property CFOP_ID : Variant  read FCFOP_ID write SetCFOP_ID;
    property PEDIDOCOMPRA_ID : Variant  read FPEDIDOCOMPRA_ID write SetPEDIDOCOMPRA_ID;
    property CONTA_ID : Variant  read FCONTA_ID write SetCONTA_ID;
    property NUMERO_SAI : Variant  read FNUMERO_SAI write SetNUMERO_SAI;
    property SYSTIME : Variant  read FSYSTIME write SetSYSTIME;
    property USUARIO_CHECAGEM : Variant  read FUSUARIO_CHECAGEM write SetUSUARIO_CHECAGEM;
    property DATAHORA_CHECAGEM : Variant  read FDATAHORA_CHECAGEM write SetDATAHORA_CHECAGEM;
    property DESCONTO_NO_CUSTO : Variant  read FDESCONTO_NO_CUSTO write SetDESCONTO_NO_CUSTO;
    property PEDIDO_ID : Variant  read FPEDIDO_ID write SetPEDIDO_ID;
    property AGUARDANDO_ENTREGA : Variant  read FAGUARDANDO_ENTREGA write SetAGUARDANDO_ENTREGA;
    property SAIDAS_ID : Variant  read FSAIDAS_ID write SetSAIDAS_ID;
    property FINALIZADE : Variant  read FFINALIZADE write SetFINALIZADE;
    property PRODUCAO_ID : Variant  read FPRODUCAO_ID write SetPRODUCAO_ID;
    property DEVOLUCAO_PEDIDO_ID : Variant  read FDEVOLUCAO_PEDIDO_ID write SetDEVOLUCAO_PEDIDO_ID;
    property TRANSFERENCIA_SAIDA_ID : Variant  read FTRANSFERENCIA_SAIDA_ID write SetTRANSFERENCIA_SAIDA_ID;
    property TRANSFERENCIA_LOJA : Variant  read FTRANSFERENCIA_LOJA write SetTRANSFERENCIA_LOJA;
    property VFCP : Variant  read FVFCP write SetVFCP;
    property VFCPST : Variant  read FVFCPST write SetVFCPST;
    property FRETE_ENT_2 : Variant  read FFRETE_ENT_2 write SetFRETE_ENT_2;
    property CHECAGEM : Variant  read FCHECAGEM write SetCHECAGEM;
    property OBS_CHECAGEM : Variant  read FOBS_CHECAGEM write SetOBS_CHECAGEM;
    property PORTADOR_ID : Variant  read FPORTADOR_ID write SetPORTADOR_ID;
    property OS_ID : Variant  read FOS_ID write SetOS_ID;
    property CONTROLE_CHECAGEM : Variant  read FCONTROLE_CHECAGEM write SetCONTROLE_CHECAGEM;
    property DATAHORA_CHECAGEM_INICIO : Variant  read FDATAHORA_CHECAGEM_INICIO write SetDATAHORA_CHECAGEM_INICIO;
    property CONDICOES_XML : Variant  read FCONDICOES_XML write SetCONDICOES_XML;
    property PARCELAS_XML : Variant  read FPARCELAS_XML write SetPARCELAS_XML;
    property ORCAMENTO_ID : Variant  read FORCAMENTO_ID write SetORCAMENTO_ID;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID, pFornecedor : String): TEntradaModel;
    function Excluir(pID, pFornecedor : String): String;
    function Salvar : String;

    function carregaClasse(pId, pFornecedor: String): TEntradaModel;
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
  EntradaDao;

{ TEntradaModel }

function TEntradaModel.Alterar(pID, pFornecedor: String): TEntradaModel;
var
  lEntradaModel : TEntradaModel;
begin
  lEntradaModel := TEntradaModel.Create(vIConexao);
  try
    lEntradaModel       := lEntradaModel.carregaClasse(pID, pFornecedor);
    lEntradaModel.Acao  := tacAlterar;
    Result              := lEntradaModel;
  finally
  end;
end;

function TEntradaModel.Excluir(pID, pFornecedor : String): String;
begin
  self.NUMERO_ENT   := pID;
  self.CODIGO_FOR   := pFornecedor;
  self.FAcao        := tacExcluir;
  Result            := self.Salvar;
end;

function TEntradaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    self.Salvar;
end;

function TEntradaModel.carregaClasse(pId, pFornecedor: String): TEntradaModel;
var
  lEntradaDao: TEntradaDao;
begin
  lEntradaDao := TEntradaDao.Create(vIConexao);

  try
    Result := lEntradaDao.carregaClasse(pId, pFornecedor);
  finally
    lEntradaDao.Free;
  end;
end;

constructor TEntradaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TEntradaModel.Destroy;
begin

  inherited;
end;

function TEntradaModel.obterLista: TFDMemTable;
var
  lEntradaLista: TEntradaDao;
begin
  lEntradaLista := TEntradaDao.Create(vIConexao);
  try
    lEntradaLista.TotalRecords    := FTotalRecords;
    lEntradaLista.WhereView       := FWhereView;
    lEntradaLista.CountView       := FCountView;
    lEntradaLista.OrderView       := FOrderView;
    lEntradaLista.StartRecordView := FStartRecordView;
    lEntradaLista.LengthPageView  := FLengthPageView;
    lEntradaLista.IDRecordView    := FIDRecordView;

    Result        := lEntradaLista.obterLista;
    FTotalRecords := lEntradaLista.TotalRecords;

  finally
    lEntradaLista.Free;
  end;
end;

function TEntradaModel.Salvar: String;
var
  lEntradaDao: TEntradaDao;
begin
  lEntradaDao := TEntradaDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lEntradaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lEntradaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lEntradaDao.excluir(Self);
    end;

  finally
    lEntradaDao.Free;
  end;
end;

procedure TEntradaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TEntradaModel.SetCFOP_ENT(const Value: Variant);
begin
  FCFOP_ENT := Value;
end;

procedure TEntradaModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;

procedure TEntradaModel.SetCHECAGEM(const Value: Variant);
begin
  FCHECAGEM := Value;
end;

procedure TEntradaModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;

procedure TEntradaModel.SetCOFINS_ENT(const Value: Variant);
begin
  FCOFINS_ENT := Value;
end;

procedure TEntradaModel.SetCONDICOES_PAG(const Value: Variant);
begin
  FCONDICOES_PAG := Value;
end;

procedure TEntradaModel.SetCONDICOES_XML(const Value: Variant);
begin
  FCONDICOES_XML := Value;
end;

procedure TEntradaModel.SetCONTA_ID(const Value: Variant);
begin
  FCONTA_ID := Value;
end;

procedure TEntradaModel.SetCONTROLE_CHECAGEM(const Value: Variant);
begin
  FCONTROLE_CHECAGEM := Value;
end;

procedure TEntradaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TEntradaModel.SetDATAHORA_CHECAGEM(const Value: Variant);
begin
  FDATAHORA_CHECAGEM := Value;
end;

procedure TEntradaModel.SetDATAHORA_CHECAGEM_INICIO(const Value: Variant);
begin
  FDATAHORA_CHECAGEM_INICIO := Value;
end;

procedure TEntradaModel.SetDATAMOVI_ENT(const Value: Variant);
begin
  FDATAMOVI_ENT := Value;
end;

procedure TEntradaModel.SetDATANOTA_ENT(const Value: Variant);
begin
  FDATANOTA_ENT := Value;
end;

procedure TEntradaModel.SetDESCONTO_NO_CUSTO(const Value: Variant);
begin
  FDESCONTO_NO_CUSTO := Value;
end;

procedure TEntradaModel.SetDESC_ENT(const Value: Variant);
begin
  FDESC_ENT := Value;
end;

procedure TEntradaModel.SetDESPESAS_ADUANEIRAS(const Value: Variant);
begin
  FDESPESAS_ADUANEIRAS := Value;
end;

procedure TEntradaModel.SetDEVOLUCAO_PEDIDO_ID(const Value: Variant);
begin
  FDEVOLUCAO_PEDIDO_ID := Value;
end;

procedure TEntradaModel.SetDOLAR(const Value: Variant);
begin
  FDOLAR := Value;
end;

procedure TEntradaModel.SetEMPRESA(const Value: Variant);
begin
  FEMPRESA := Value;
end;

procedure TEntradaModel.SetFINALIZADE(const Value: Variant);
begin
  FFINALIZADE := Value;
end;

procedure TEntradaModel.SetFRETE_ENT(const Value: Variant);
begin
  FFRETE_ENT := Value;
end;

procedure TEntradaModel.SetFRETE_ENT_2(const Value: Variant);
begin
  FFRETE_ENT_2 := Value;
end;

procedure TEntradaModel.SetAGUARDANDO_ENTREGA(const Value: Variant);
begin
  FAGUARDANDO_ENTREGA := Value;
end;

procedure TEntradaModel.SetARQ_NFE(const Value: Variant);
begin
  FARQ_NFE := Value;
end;

procedure TEntradaModel.SetBASE_ST(const Value: Variant);
begin
  FBASE_ST := Value;
end;

procedure TEntradaModel.SetICMS_ENT(const Value: Variant);
begin
  FICMS_ENT := Value;
end;

procedure TEntradaModel.SetICMS_ST(const Value: Variant);
begin
  FICMS_ST := Value;
end;

procedure TEntradaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEntradaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TEntradaModel.SetID_A03(const Value: Variant);
begin
  FID_A03 := Value;
end;

procedure TEntradaModel.SetIPI_ENT(const Value: Variant);
begin
  FIPI_ENT := Value;
end;

procedure TEntradaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TEntradaModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TEntradaModel.SetMODELO_ENT(const Value: Variant);
begin
  FMODELO_ENT := Value;
end;

procedure TEntradaModel.SetNUMERO_ENT(const Value: Variant);
begin
  FNUMERO_ENT := Value;
end;

procedure TEntradaModel.SetNUMERO_NF(const Value: Variant);
begin
  FNUMERO_NF := Value;
end;

procedure TEntradaModel.SetNUMERO_SAI(const Value: Variant);
begin
  FNUMERO_SAI := Value;
end;

procedure TEntradaModel.SetOBSERVACAO_ENT(const Value: Variant);
begin
  FOBSERVACAO_ENT := Value;
end;

procedure TEntradaModel.SetOBS_CHECAGEM(const Value: Variant);
begin
  FOBS_CHECAGEM := Value;
end;

procedure TEntradaModel.SetORCAMENTO_ID(const Value: Variant);
begin
  FORCAMENTO_ID := Value;
end;

procedure TEntradaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TEntradaModel.SetOS_ID(const Value: Variant);
begin
  FOS_ID := Value;
end;

procedure TEntradaModel.SetOUTROS_ENT(const Value: Variant);
begin
  FOUTROS_ENT := Value;
end;

procedure TEntradaModel.SetPARCELAS_ENT(const Value: Variant);
begin
  FPARCELAS_ENT := Value;
end;

procedure TEntradaModel.SetPARCELAS_XML(const Value: Variant);
begin
  FPARCELAS_XML := Value;
end;

procedure TEntradaModel.SetPEDIDOCOMPRA_ID(const Value: Variant);
begin
  FPEDIDOCOMPRA_ID := Value;
end;

procedure TEntradaModel.SetPEDIDO_COMPRA(const Value: Variant);
begin
  FPEDIDO_COMPRA := Value;
end;

procedure TEntradaModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TEntradaModel.SetPIS_ENT(const Value: Variant);
begin
  FPIS_ENT := Value;
end;

procedure TEntradaModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TEntradaModel.SetPRIMEIROVENC_ENT(const Value: Variant);
begin
  FPRIMEIROVENC_ENT := Value;
end;

procedure TEntradaModel.SetPRODUCAO_ID(const Value: Variant);
begin
  FPRODUCAO_ID := Value;
end;

procedure TEntradaModel.SetSAIDAS_ID(const Value: Variant);
begin
  FSAIDAS_ID := Value;
end;

procedure TEntradaModel.SetSEG_W09(const Value: Variant);
begin
  FSEG_W09 := Value;
end;

procedure TEntradaModel.SetSERIE_ENT(const Value: Variant);
begin
  FSERIE_ENT := Value;
end;

procedure TEntradaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TEntradaModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TEntradaModel.SetST_GUIA(const Value: Variant);
begin
  FST_GUIA := Value;
end;

procedure TEntradaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TEntradaModel.SetTAXA_ENT(const Value: Variant);
begin
  FTAXA_ENT := Value;
end;

procedure TEntradaModel.SetTIPO_FRETE(const Value: Variant);
begin
  FTIPO_FRETE := Value;
end;

procedure TEntradaModel.SetTIPO_PRO(const Value: Variant);
begin
  FTIPO_PRO := Value;
end;

procedure TEntradaModel.SetTOTALPRODUTOS_ENT(const Value: Variant);
begin
  FTOTALPRODUTOS_ENT := Value;
end;

procedure TEntradaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TEntradaModel.SetTOTAL_ENT(const Value: Variant);
begin
  FTOTAL_ENT := Value;
end;

procedure TEntradaModel.SetTRANSFERENCIA_LOJA(const Value: Variant);
begin
  FTRANSFERENCIA_LOJA := Value;
end;

procedure TEntradaModel.SetTRANSFERENCIA_SAIDA_ID(const Value: Variant);
begin
  FTRANSFERENCIA_SAIDA_ID := Value;
end;

procedure TEntradaModel.SetUSUARIO_CHECAGEM(const Value: Variant);
begin
  FUSUARIO_CHECAGEM := Value;
end;

procedure TEntradaModel.SetUSUARIO_ENT(const Value: Variant);
begin
  FUSUARIO_ENT := Value;
end;

procedure TEntradaModel.SetVBCIRRF_W27(const Value: Variant);
begin
  FVBCIRRF_W27 := Value;
end;

procedure TEntradaModel.SetVBCRETPREV_W29(const Value: Variant);
begin
  FVBCRETPREV_W29 := Value;
end;

procedure TEntradaModel.SetVFCP(const Value: Variant);
begin
  FVFCP := Value;
end;

procedure TEntradaModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TEntradaModel.SetVII_W11(const Value: Variant);
begin
  FVII_W11 := Value;
end;

procedure TEntradaModel.SetVIRRF_W28(const Value: Variant);
begin
  FVIRRF_W28 := Value;
end;

procedure TEntradaModel.SetVRETCOFINS_W25(const Value: Variant);
begin
  FVRETCOFINS_W25 := Value;
end;

procedure TEntradaModel.SetVRETCSLL_W26(const Value: Variant);
begin
  FVRETCSLL_W26 := Value;
end;

procedure TEntradaModel.SetVRETPIS_W24(const Value: Variant);
begin
  FVRETPIS_W24 := Value;
end;

procedure TEntradaModel.SetVRETPREV_W30(const Value: Variant);
begin
  FVRETPREV_W30 := Value;
end;

procedure TEntradaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
