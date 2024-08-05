unit EntradaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  System.Classes,
  Interfaces.Conexao,
  Terasoft.Utils,
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes,
  ACBrNFe,
  ACBrNFeDANFeRLClass,
  pcnConversao,
  pcnConversaoNFe,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TEntradaItensParams = record
    NUMERO_ENT,
    CODIGO_FOR,
    CODIGO_PRO,
    QUANTIDADE_ENT,
    VALORUNI_ENT : String;
  end;

  TEntradaResultado = record
    NUMERO_ENT,
    CODIGO_FOR : String;
  end;

  TEntradaModel = class;
  ITEntradaModel=IObject<TEntradaModel>;

  TEntradaModel = class
  private
    [weak] mySelf: ITEntradaModel;
    vIConexao : IConexao;
    ACBrNFe: TACBrNFe;
    ACBrNFeDANFeRL: TACBrNFeDANFeRL;
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
    FPathXML: Variant;
    FNumeroView: String;
    FFornecedorView: String;
    FLOGISTICA: Variant;
    FINFCPL: Variant;
    FINFADFISCO: Variant;

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
    procedure SetPathXML(const Value: Variant);
    procedure SetFornecedorView(const Value: String);
    procedure SetNumeroView(const Value: String);
    procedure SetLOGISTICA(const Value: Variant);
    procedure SetINFADFISCO(const Value: Variant);
    procedure SetINFCPL(const Value: Variant);

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
    property LOGISTICA: Variant read FLOGISTICA write SetLOGISTICA;
    property INFADFISCO: Variant read FINFADFISCO write SetINFADFISCO;
    property INFCPL: Variant read FINFCPL write SetINFCPL;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEntradaModel;

    function Incluir: String;
    function Alterar(pID, pFornecedor : String): ITEntradaModel;
    function Excluir(pID, pFornecedor : String): String;
    function Salvar : String;

    function EntradaItens(pEntradaItensParams : TEntradaItensParams) : String;
    function carregaClasse(pId, pFornecedor : String): ITEntradaModel;

    function ValidaCFOP(pCFOP: String): String;

    function obterLista       : IFDDataset;
    function obterTotalizador : IFDDataset;

    function importaXML       : TEntradaResultado;
    function importaCabecalho : TEntradaResultado;

    procedure ImportarItens(pEntrada, pFornecedor: String);

    function obterFornecedor(pCNPJCPF : String): String;

    function VisualizarXML(pIDEntrada, pCodigoFornecedor: String; pImprimir, pMostraPreview, pGerarPDF: Boolean; pPathPDF: String = ''): String;
    function SalvarXML(pIDEntrada, pCodigoFornecedor, pPath: String): String;



    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property PathXML : Variant read FPathXML write SetPathXML;
    property NumeroView: String read FNumeroView write SetNumeroView;
    property FornecedorView: String read FFornecedorView write SetFornecedorView;
  end;

implementation

uses
  EntradaDao,
  ProdutosModel,
  EntradaItensModel,
  CFOPModel,
  System.SysUtils, FornecedorModel;

{ TEntradaModel }



function TEntradaModel.SalvarXML(pIDEntrada, pCodigoFornecedor, pPath: String): String;
var
 lXML: TStringList;
 lEntradaModel: ITEntradaModel;
begin
  lXMl :=  nil;
  lEntradaModel   := TEntradaModel.getNewIface(vIConexao);

  try
    lEntradaModel := lEntradaModel.objeto.carregaClasse(pIDEntrada, pCodigoFornecedor);
    lXML := TStringList.Create;

    if lEntradaModel.objeto.ARQ_NFE = '' then
      CriaException('NF não localizada '+lEntradaModel.objeto.ID_A03);

    lXML.Text := lEntradaModel.objeto.ARQ_NFE;

    if not DirectoryExists (pPath) then
      ForceDirectories(pPath);
    if DirectoryExists (pPath) then
      lXML.SaveToFile(pPath+'\'+lEntradaModel.objeto.ID_A03+'.xml');

    Result := lEntradaModel.objeto.ID_A03+'.xml';
  finally
    lEntradaModel:=nil;
    FreeAndNil(lXML);
  end;
end;


function TEntradaModel.VisualizarXML(pIDEntrada, pCodigoFornecedor: String; pImprimir, pMostraPreview, pGerarPDF: Boolean; pPathPDF: String = ''): String;
var
 lEntradaModel: ITEntradaModel;
begin
  lEntradaModel   := TEntradaModel.getNewIface(vIConexao);

  try
    lEntradaModel := lEntradaModel.objeto.carregaClasse(pIDEntrada, pCodigoFornecedor);

    ACBrNFeDANFeRL := TACBrNFeDANFeRL.Create(nil);
    ACBrNFe.DANFE  := ACBrNFeDANFeRL;

    ACBrNFe.DANFE.TipoDANFE := tiRetrato;

    //ACBrNFe.DANFE.Logo    := vConfiguracoesNotaFiscal.DANFEPathLogo(lNFModel.MODELO);
    ACBrNFe.DANFE.PathPDF := pPathPDF;
    ACBrNFe.DANFE.Sistema := 'Emissão: ERP Terasoft';

    if FileExists(ACBrNFe.DANFE.Logo) then
    begin
      ACBrNFe.DANFE.ExpandeLogoMarca := True;
      ACBrNFe.DANFE.ExpandeLogoMarcaConfig.Esticar := False;
    end;

    ACBrNFe.NotasFiscais.Clear;
    ACBrNFe.NotasFiscais.LoadFromString(lEntradaModel.objeto.ARQ_NFE);


    if pGerarPDF then begin
      ACBrNFe.DANFE.MostraStatus := pMostraPreview;
      ACBrNFe.DANFE.ImprimirDANFEPDF;
    end;

    if pImprimir then begin
      ACBrNFe.DANFE.MostraStatus  := pMostraPreview;
      ACBrNFe.DANFE.MostraPreview := pMostraPreview;
      ACBrNFe.DANFE.ImprimirDANFE;
    end;

    Result := lEntradaModel.objeto.ID_A03;

  finally
    lEntradaModel:=nil;
  end;

end;


function TEntradaModel.Alterar(pID, pFornecedor: String): ITEntradaModel;
var
  lEntradaModel : ITEntradaModel;
begin
  lEntradaModel := TEntradaModel.getNewIface(vIConexao);
  try
    lEntradaModel       := lEntradaModel.objeto.carregaClasse(pID, pFornecedor);
    lEntradaModel.objeto.Acao  := tacAlterar;
    Result              := lEntradaModel;
  finally
  end;
end;

function TEntradaModel.EntradaItens(pEntradaItensParams: TEntradaItensParams): String;
var
  lEntradaItensModel  : TEntradaItensModel;
  p,lEntradaModel       : ITEntradaModel;
  lProdutosModel      : ITProdutosModel;

begin
  lEntradaItensModel  := TEntradaItensModel.Create(vIConexao);
  lEntradaModel       := TEntradaModel.getNewIface(vIConexao);
  lProdutosModel      := TProdutosModel.getNewIface(vIConexao);

  if pEntradaItensParams.CODIGO_FOR = '' then
    CriaException('Fornecedor não informado');

  if pEntradaItensParams.CODIGO_PRO = '' then
    CriaException('Produto não informado');

  if StrToFloatDef(pEntradaItensParams.QUANTIDADE_ENT, 0) = 0 then
    CriaException('Quantidade não informada');

  try
    p := self.carregaClasse(pEntradaItensParams.NUMERO_ENT, pEntradaItensParams.CODIGO_FOR);

    lProdutosModel.objeto.IDRecordView := pEntradaItensParams.CODIGO_PRO;
    lProdutosModel.objeto.obterLista;
    lProdutosModel := lProdutosModel.objeto.ProdutossLista.First;

    lEntradaItensModel.CFOP_ID        := p.objeto.FCFOP_ID;
    lEntradaItensModel.NUMERO_ENT     := p.objeto.FNUMERO_ENT;
    lEntradaItensModel.CODIGO_FOR     := p.objeto.FCODIGO_FOR;
    lEntradaItensModel.CODIGO_PRO     := pEntradaItensParams.CODIGO_PRO;
    lEntradaItensModel.QUANTIDADE_ENT := pEntradaItensParams.QUANTIDADE_ENT;
    lEntradaItensModel.VALORUNI_ENT   := pEntradaItensParams.VALORUNI_ENT;
    lEntradaItensModel.STATUS         := '0';
    lEntradaItensModel.CST_ENT        := '00';

    Result := lEntradaItensModel.Incluir;

  finally
    lEntradaItensModel.Free;
    lProdutosModel:=nil;
  end;
end;

function TEntradaModel.Excluir(pID, pFornecedor : String): String;
begin
  self.NUMERO_ENT   := pID;
  self.CODIGO_FOR   := pFornecedor;
  self.FAcao        := tacExcluir;
  Result            := self.Salvar;
end;

class function TEntradaModel.getNewIface(pIConexao: IConexao): ITEntradaModel;
begin
  Result := TImplObjetoOwner<TEntradaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TEntradaModel.importaCabecalho: TEntradaResultado;
var
 i: Integer;
 lEntrada,
 lFornecedor: String;
 lEntradaModel: ITEntradaModel;
begin

  lEntradaModel := TEntradaModel.getNewIface(vIConexao);

  try
    with ACBrNFe.NotasFiscais.Items[0] do
    begin
      lFornecedor := Self.ObterFornecedor(NFe.Emit.CNPJCPF);

      lEntradaModel.objeto.NumeroView     := Format('%10.10d', [NFe.Ide.nNF]);
      lEntradaModel.objeto.FornecedorView := lFornecedor;
      lEntradaModel.objeto.obterLista;

      if lEntradaModel.objeto.TotalRecords > 0 then
        CriaException('Nota fiscal '+Format('%10.10d', [NFe.Ide.nNF])+', do fornecedor '+lFornecedor+' já importada');

      self.FSTATUS                      := '0';
      self.NUMERO_ENT                   := Format('%10.10d', [NFe.Ide.nNF]);
      self.FSERIE_ENT                   := Format('%3.3d', [(NFe.Ide.serie)]);
      self.FMODELO_ENT                  := Format('%2.2d', [(NFe.Ide.modelo)]);
      self.FCODIGO_FOR                  := lFornecedor;
      self.DATANOTA_ENT                 := DateToStr(NFe.Ide.dEmi);
      self.FDATAMOVI_ENT                := DateToStr(vIConexao.DataServer);
      self.FID_A03                      := copy(NFe.infNFe.ID, 4, 44);
      self.FARQ_NFE                     := GerarXML;
      self.FFRETE_ENT                   := FloatToStr(NFe.Total.ICMSTot.vFrete);
      self.FIPI_ENT                     := FloatToStr(NFe.Total.ICMSTot.vIPI);
      self.FICMS_ENT                    := FloatToStr(NFe.Total.ICMSTot.vICMS);
      self.FOUTROS_ENT                  := FloatToStr(NFe.Total.ICMSTot.vOutro);
      self.FDESC_ENT                    := FloatToStr(NFe.Total.ICMSTot.vDesc);
      self.FPIS_ENT                     := FloatToStr(NFe.Total.ICMSTot.vPIS);
      self.FCOFINS_ENT                  := FloatToStr(NFe.Total.ICMSTot.vCOFINS);
      self.FICMS_ST                     := FloatToStr(NFe.Total.ICMSTot.vST);
      self.FBASE_ST                     := FloatToStr(NFe.Total.ICMSTot.vBCST);
      self.FSEG_W09                     := FloatToStr(NFe.Total.ICMSTot.vSeg);
      self.FVII_W11                     := FloatToStr(NFe.Total.ICMSTot.vII);
      self.FTOTALPRODUTOS_ENT           := FloatToStr(NFe.Total.ICMSTot.vProd);
      self.FTOTAL_ENT                   := FloatToStr(NFe.Total.ICMSTot.vNF);
      self.FFINALIZADE                  := FinNFeToStr(NFe.Ide.finNFe);
      self.FTIPO_FRETE                  := modFreteToStr(NFe.Transp.modFrete);
      self.FUSUARIO_ENT                 := vIConexao.getUSer.ID;
      self.FINFADFISCO                  := NFe.InfAdic.infAdFisco;
      self.FINFCPL                      := NFe.InfAdic.infCpl;

      lEntrada := Self.Incluir;
      Self.ImportarItens(lEntrada, FCODIGO_FOR);

      result.NUMERO_ENT := lEntrada;
      result.CODIGO_FOR := lFornecedor;
    end;
  finally
    lEntradaModel:=nil;
  end;
end;

procedure TEntradaModel.ImportarItens(pEntrada, pFornecedor: String);
var
 lEntradaItensModel : TEntradaItensModel;
 lProdutoModel      : ITProdutosModel;
 i: Integer;
begin
  lEntradaItensModel := TEntradaItensModel.Create(vIConexao);
  lProdutoModel      := TProdutosModel.getNewIface(vIConexao);

  try
    with ACBrNFe.NotasFiscais.Items[0].NFe do
    begin

      lProdutoModel.objeto.IDRecordView := '999999';
      lProdutoModel.objeto.obterLista;

      if lProdutoModel.objeto.TotalRecords = 0 then
      begin
        lProdutoModel.objeto.CODIGO_PRO   := '999999';
        lProdutoModel.objeto.NOME_PRO     := 'PRODUTO NÃO VINCULADO';
        lProdutoModel.objeto.CODIGO_GRU   := '000000';
        lProdutoModel.objeto.CODIGO_FOR   := '000000';
        lProdutoModel.objeto.CODIGO_MAR   := '000000';
        lProdutoModel.objeto.CODIGO_SUB   := '000000';
        lProdutoModel.objeto.Incluir;
      end;

      for i := 0 to Det.Count - 1 do
      begin
        lEntradaItensModel.Acao       := tacIncluir;
        lEntradaItensModel.NUMERO_ENT := pEntrada;

        with Det.Items[i] do
        begin
          lEntradaItensModel.LOJA := self.FLOJA;

          lEntradaItensModel.STATUS            := '0';
          lEntradaItensModel.ITEM_ENT          := Prod.nItem.ToString;
          lEntradaItensModel.CODIGO_PRO        := '999999';
          lEntradaItensModel.CODIGO_FOR        := self.FCODIGO_FOR;
          lEntradaItensModel.NUMERO_ENT        := self.FNUMERO_ENT;
          lEntradaItensModel.CPROD             := Prod.cProd;
          lEntradaItensModel.CEAN              := Prod.cEAN;
          lEntradaItensModel.CBARRA            := Prod.cBarra;
          lEntradaItensModel.XPROD             := Prod.xProd;
          lEntradaItensModel.CEST              := Prod.CEST;
          lEntradaItensModel.UCOM              := Prod.uCom;
          lEntradaItensModel.NCM_I05           := Prod.NCM;
          lEntradaItensModel.CFOP              := Prod.CFOP;
          lEntradaItensModel.QUANTIDADE_ENT    := FloatToStr(Prod.qCom);
          lEntradaItensModel.VALORUNI_ENT      := FloatToStr(Prod.vUnCom);
          lEntradaItensModel.QUANTIDADE_NF     := FloatToStr(Prod.qCom);
          lEntradaItensModel.VALOR_UNITARIO_NF := FloatToStr(Prod.vUnCom);
          lEntradaItensModel.DESC_I17          := FloatToStr(Prod.vDesc);
          lEntradaItensModel.VSEG_I16          := FloatToStr(Prod.vSeg + Prod.vOutro);
          lEntradaItensModel.VFRETE_I15        := FloatToStr(Prod.vFrete);
        end;

        with Det.Items[i].Imposto.ICMS do
        begin

          // Verificar sobre os ifs que tem no legado para tratar os cst e csosn
          if CSTICMSToStr(CST) <> '' then
            lEntradaItensModel.CST_ENT         := CSTICMSToStr(CST)
          else
            lEntradaItensModel.CST_ENT         := CSOSNIcmsToStr(CSOSN);

          lEntradaItensModel.ORIG_N11          := OrigToStr(orig);
          lEntradaItensModel.MOBIBC_N13        := modBCToStr(modBC);
          lEntradaItensModel.ICMS_ENT          := FloatToStr(pICMS);
          lEntradaItensModel.PREDBC_N14        := FloatToStr(pRedBC);
          lEntradaItensModel.BASE_ICMS_ENT     := FloatToStr(vBC);
          lEntradaItensModel.VICMS_N17         := FloatToStr(vICMS);
          lEntradaItensModel.MDBCST_N18        := modBCSTToStr(modBCST);
          lEntradaItensModel.ICMS_ST_ENT       := FloatToStr(pICMSST);
          lEntradaItensModel.ICMS_ST_ORIGINAL  := FloatToStr(pICMSST);
          lEntradaItensModel.PMVAST_N19        := FloatToStr(pMVAST);
          lEntradaItensModel.PREDBCST_N20      := FloatToStr(pRedBCST);
          lEntradaItensModel.BASE_ST_ENT       := FloatToStr(vBCST);
          lEntradaItensModel.BASE_ST_ORIGINAL  := FloatToStr(vBCST);
          lEntradaItensModel.VICMS_ST_ENT      := FloatToStr(vICMSST);
          lEntradaItensModel.VICMS_ST_ORIGINAL := FloatToStr(vICMSST);

          // Não encontrado
          // lEntradaItensModel.PCREDSN           := FloatToStr(pCredSN);
          // lEntradaItensModel.VCREDICMSSN       := FloatToStr(vCredICMSSN);

          lEntradaItensModel.VBCSTRET          := FloatToStr(vBCSTRet);
          lEntradaItensModel.VICMSSTRET        := FloatToStr(vICMSSTRet);
          lEntradaItensModel.PFCPST            := FloatToStr(pFCPST);
          lEntradaItensModel.VFCPST            := FloatToStr(vFCPST);
          lEntradaItensModel.VBCFPC            := FloatToStr(vBCFCP);
          lEntradaItensModel.PFCP              := FloatToStr(pFCP);
          lEntradaItensModel.VFCP              := FloatToStr(vFCP);
          lEntradaItensModel.VBCFCPSTRET       := FloatToStr(vBCFCPSTRet);
          lEntradaItensModel.PFCPSTRET         := FloatToStr(pFCPSTRet);
          lEntradaItensModel.VFCPSTRET         := FloatToStr(vFCPSTRet);

          // Não encontrado
          // lEntradaItensModel.PREDBCEFET        := FloatToStr(pRedBCEfet);
          // lEntradaItensModel.VBCEFET           := FloatToStr(vBCEfet);
          // lEntradaItensModel.PICMSEFET         := FloatToStr(pICMSEfet);
          // lEntradaItensModel.VICMSEFET         := FloatToStr(vICMSEfet);
          // lEntradaItensModel.VICMSDESON        := FloatToStr(vICMSDeson);
          // lEntradaItensModel.MOTDESICMS        := motDesICMSToStr(motDesICMS);
        end;

        with Det.Items[i].Imposto.PIS do
        begin
          lEntradaItensModel.CST_Q06      := CSTPISToStr(CST);
          lEntradaItensModel.PPIS_Q08     := FloatToStr(pPIS);
          lEntradaItensModel.vBC_Q07      := FloatToStr(vBC);
          lEntradaItensModel.VPIS_Q09     := FloatToStr(vPIS);
          lEntradaItensModel.PIS          := FloatToStr(vPIS);
        end;

        with Det.Items[i].Imposto.COFINS do
        begin
          lEntradaItensModel.CST_S06      := CSTCOFINSToStr(CST);
          lEntradaItensModel.PCOFINS_S08  := FloatToStr(pCOFINS);
          lEntradaItensModel.vBC_S07      := FloatToStr(vBC);
          lEntradaItensModel.COFINS       := FloatToStr(vCOFINS);
        end;

        with Det.Items[i].Imposto.IPI do
        begin
          lEntradaItensModel.CST_O09      := CSTIPIToStr(CST);
          lEntradaItensModel.CIENQ_O02    := clEnq;
          lEntradaItensModel.CENQ_O06     := cEnq;
          lEntradaItensModel.VBC_O10      := FloatToStr(vBC);
          lEntradaItensModel.QUNID_O11    := FloatToStr(qUnid);
          lEntradaItensModel.VUNID_O12    := FloatToStr(vUnid);
          lEntradaItensModel.IPI_ENT      := FloatToStr(pIPI);
          lEntradaItensModel.VIPI_014     := FloatToStr(vIPI);
        end;

        // with Det.Items[i].Imposto.ICMSUFDest do
        // begin
        //   lEntradaItensModel.VBCUFDEST      := FormataFloatFireBird(FloatToStr(vBCUFDest));
        //   lEntradaItensModel.PFCPUFDEST     := FormataFloatFireBird(FloatToStr(pFCPUFDest));
        //   lEntradaItensModel.PICMSUFDEST    := FormataFloatFireBird(FloatToStr(pICMSUFDest));
        //   lEntradaItensModel.PICMSINTER     := FormataFloatFireBird(FloatToStr(pICMSInter));
        //   lEntradaItensModel.PICMSINTERPART := FormataFloatFireBird(FloatToStr(pICMSInterPart));
        //   lEntradaItensModel.VFCPUFDEST     := FormataFloatFireBird(FloatToStr(vFCPUFDest));
        //   lEntradaItensModel.VICMSUFDEST    := FormataFloatFireBird(FloatToStr(vICMSUFDest));
        //   lEntradaItensModel.VICMSUFREMET   := FormataFloatFireBird(FloatToStr(vICMSUFRemet));
        // end;

        lEntradaItensModel.Salvar;
      end;
    end;

  finally
    lEntradaItensModel.Free;
    lProdutoModel:=nil;
  end;
end;

function TEntradaModel.importaXML: TEntradaResultado;
begin
  if not FileExists(FPathXML) then
    CriaException('Arquivo XML não localizado');

  ACBrNFe.NotasFiscais.Clear;
  ACBrNFe.NotasFiscais.LoadFromFile(FPathXML);

  result := Self.ImportaCabecalho;
end;

function TEntradaModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TEntradaModel.carregaClasse(pId, pFornecedor: String): ITEntradaModel;
var
  lEntradaDao: ITEntradaDao;
begin
  lEntradaDao := TEntradaDao.getNewIface(vIConexao);
  try
    Result := lEntradaDao.objeto.carregaClasse(pId, pFornecedor);
  finally
    lEntradaDao:=nil;
  end;
end;

constructor TEntradaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  ACBrNFe   := TACBrNFe.Create(nil);
end;

destructor TEntradaModel.Destroy;
begin

  inherited;
end;

function TEntradaModel.obterFornecedor(pCNPJCPF: String): String;
var
 lFornecedorModel : TFornecedorModel;
 lTableFornecedor : IFDDataset;
begin
  lFornecedorModel := TFornecedorModel.Create(vIConexao);

  try
    lFornecedorModel.CNPJCPFRecordView := pCNPJCPF;
    lTableFornecedor := lFornecedorModel.obterLista;

    if lTableFornecedor.objeto.RecordCount > 0 then
    begin
      Result := lTableFornecedor.objeto.fieldByName('CODIGO_FOR').Value;
      exit;
    end;

    with ACBrNFe.NotasFiscais.Items[0].NFe.Emit do
    begin
      lFornecedorModel.TIPO_FOR          := 'J';
      lFornecedorModel.STATUS            := '1';
      lFornecedorModel.FANTASIA_FOR      := UpperCase(copy(IIF(xFant = '',xNome, xFant),1,40));
      lFornecedorModel.RAZAO_FOR         := UpperCase(copy(xNome,1,40));
      lFornecedorModel.CNPJ_CPF_FOR      := CNPJCPF;
      lFornecedorModel.INSCRICAO_RG_FOR  := IE;
      lFornecedorModel.CEP_FOR           := EnderEmit.CEP.ToString;
      lFornecedorModel.ENDERECO_FOR      := UpperCase(EnderEmit.xLgr);
      lFornecedorModel.NUMERO_END        := EnderEmit.nro;
      lFornecedorModel.COD_MUNICIPIO     := EnderEmit.cMun.ToString;
      lFornecedorModel.COMPLEMENTO       := UpperCase(EnderEmit.xCpl);
      lFornecedorModel.BAIRRO_FOR        := UpperCase(EnderEmit.xBairro);
      lFornecedorModel.CIDADE_FOR        := UpperCase(EnderEmit.xMun);
      lFornecedorModel.UF_FOR            := UpperCase(EnderEmit.UF);
      lFornecedorModel.TELEFONE_FOR      := EnderEmit.fone;
      lFornecedorModel.OBSERVACAO_FOR    := 'CADASTRO PELA ENTRADA DE FORNECEDOR';
    end;

    Result := lFornecedorModel.Incluir;

  finally
    lFornecedorModel.Free;
  end;
end;

function TEntradaModel.obterLista: IFDDataset;
var
  lEntradaLista: ITEntradaDao;
begin
  lEntradaLista := TEntradaDao.getNewIface(vIConexao);
  try
    lEntradaLista.objeto.TotalRecords    := FTotalRecords;
    lEntradaLista.objeto.WhereView       := FWhereView;
    lEntradaLista.objeto.CountView       := FCountView;
    lEntradaLista.objeto.OrderView       := FOrderView;
    lEntradaLista.objeto.StartRecordView := FStartRecordView;
    lEntradaLista.objeto.LengthPageView  := FLengthPageView;
    lEntradaLista.objeto.IDRecordView    := FIDRecordView;
    lEntradaLista.objeto.NumeroView      := FNumeroView;
    lEntradaLista.objeto.FornecedorView  := FFornecedorView;

    Result        := lEntradaLista.objeto.obterLista;
    FTotalRecords := lEntradaLista.objeto.TotalRecords;
  finally
    lEntradaLista:=nil;
  end;
end;

function TEntradaModel.obterTotalizador: IFDDataset;
var
  lEntradaDao: ITEntradaDao;
begin
  lEntradaDao := TEntradaDao.getNewIface(vIConexao);

  try
    lEntradaDao.objeto.NumeroView     := FNumeroView;
    lEntradaDao.objeto.FornecedorView := FFornecedorView;

    Result := lEntradaDao.objeto.obterTotalizador;

  finally
    lEntradaDao:=nil;
  end;
end;

function TEntradaModel.Salvar: String;
var
  lEntradaDao: ITEntradaDao;
begin
  lEntradaDao := TEntradaDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lEntradaDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lEntradaDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lEntradaDao.objeto.excluir(mySelf);
    end;

  finally
    lEntradaDao:=nil;
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

procedure TEntradaModel.SetFornecedorView(const Value: String);
begin
  FFornecedorView := Value;
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

procedure TEntradaModel.SetINFADFISCO(const Value: Variant);
begin
  FINFADFISCO := Value;
end;

procedure TEntradaModel.SetINFCPL(const Value: Variant);
begin
  FINFCPL := Value;
end;

procedure TEntradaModel.SetIPI_ENT(const Value: Variant);
begin
  FIPI_ENT := Value;
end;

procedure TEntradaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TEntradaModel.SetLOGISTICA(const Value: Variant);
begin
  FLOGISTICA := Value;
end;

procedure TEntradaModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TEntradaModel.SetMODELO_ENT(const Value: Variant);
begin
  FMODELO_ENT := Value;
end;

procedure TEntradaModel.SetNumeroView(const Value: String);
begin
  FNumeroView := Value;
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

procedure TEntradaModel.SetPathXML(const Value: Variant);
begin
  FPathXML := Value;
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

function TEntradaModel.ValidaCFOP(pCFOP: String): String;
var
 lCFOPModel : ITCFOPModel;
begin
  lCFOPModel := TCFOPModel.getNewIface(vIConexao);

  try
    lCFOPModel.objeto.WhereView := ' and CFOP.CFOP = '+QuotedStr(pCFOP)+' and CFOP.CFOP_REFERENCIA is not NULL ';

    lCFOPModel.objeto.obterLista;

    if lCFOPModel.objeto.TotalRecords > 0 then
    begin
      lCFOPModel.objeto.WhereView := 'and CFOP.CFOP = '+QuotedStr(lCFOPModel.objeto.CFOPsLista.First.objeto.CFOP_REFERENCIA);
      lCFOPModel.objeto.obterLista;

      if lCFOPModel.objeto.TotalRecords > 0 then
        Result := lCFOPModel.objeto.CFOPsLista.First.objeto.ID;
    end;

  finally
     lCFOPModel := nil;
  end
end;

end.
