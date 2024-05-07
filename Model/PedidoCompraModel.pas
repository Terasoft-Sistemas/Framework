unit PedidoCompraModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  Terasoft.FuncoesTexto,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TPedidoItensParams = record
    NUMERO_PED,
    CODIGO_FOR,
    CODIGO_PRO,
    QUANTIDADE_PED,
    VALORUNI_PED,
    STATUS_PED,
    PERCENTUAL_DESCONTO,
    VALOR_DESCONTO,
    VALOR_OUTRAS_DESPESAS,
    OBSERVACAO,
    CFOP,
    CST,
    ALIQUOTA_IPI,
    VALOR_BASE_IPI,
    VALOR_IPI,
    PERCENTUAL_REDUCAO_ICMS,
    ALIQUOTA_ICMS,
    VALOR_BASE_ICMS,
    VALOR_ICMS,
    PERCENTUAL_MVA,
    PERCENTUAL_REDUCAO_ICMS_ST,
    PERCENTUAL_ICMS_ST,
    VALOR_BASE_ICMS_ST,
    VALOR_ICMS_ST: String;
  end;

  TPedidoCompraModel = class

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

    FNumeroView: String;
    FFornecedorView: String;
    FBASE_ST: Variant;
    FAUTORIZACAO_ESTOQUE_USUARIO: Variant;
    FCALCULAR_VALORES: Variant;
    FUSUARIO_PED: Variant;
    FDESC_PED: Variant;
    FFRETE_PED: Variant;
    FAUTORIZACAO_FINANCEIRO_USUARIO: Variant;
    FTIPO_PRO: Variant;
    FIPI_PED: Variant;
    FCODIGO_FOR: Variant;
    FPORTADOR_ID: Variant;
    FDATA_PED: Variant;
    FFRETE_NO_IPI: Variant;
    FHORAPREV_PED: Variant;
    FVFCP: Variant;
    FAUTORIZACAO_ESTOQUE_OBS: Variant;
    FENVIADO: Variant;
    FTRANSPORTADORA_ID: Variant;
    FAUTORIZACAO_ESTOQUE_DATAHORA: Variant;
    FTIPO_FRETE: Variant;
    FOBSERVACAO_PED: Variant;
    FAUTORIZACAO_FINANCEIRO_OBS: Variant;
    FAUTORIZADO: Variant;
    FAUTORIZACAO_FINANCEIRO_DATAHORA: Variant;
    FTOTALPRODUTOS_PED: Variant;
    FID: Variant;
    FPEDIDO_FORNECEDOR: Variant;
    FICMS_PED: Variant;
    FLOJA: Variant;
    FBASE_ICMS: Variant;
    FCONDICOES_PAG: Variant;
    FSYSTIME: Variant;
    FSTATUS_ID: Variant;
    FTOTAL_PED: Variant;
    FTIPO_MOEDA_ESTRANGEIRA: Variant;
    FDOLAR: Variant;
    FCONTATOPREV_PED: Variant;
    FAUTORIZACAO_ESTOQUE_STATUS: Variant;
    FNUMERO_PED: Variant;
    FSTATUS_PED: Variant;
    FOUTROS_PED: Variant;
    FAUTORIZACAO_FINANCEIRO_STATUS: Variant;
    FVFCPST: Variant;
    FCTR_IMPRESSAO_PED: Variant;
    FUSO_CONSUMO: Variant;
    FST_PED: Variant;
    FENVIO_WHATSAPP: Variant;
    FTELEFONEPREV_PED: Variant;
    FDATA_ACEITE: Variant;
    FPRIMEIROVENC_PED: Variant;
    FPARCELAS_PED: Variant;
    FDATAPREV_PED: Variant;
    FDATA_COTACAO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    procedure SetNumeroView(const Value: String);
    procedure SetFornecedorView(const Value: String);
    procedure SetAUTORIZACAO_ESTOQUE_DATAHORA(const Value: Variant);
    procedure SetAUTORIZACAO_ESTOQUE_OBS(const Value: Variant);
    procedure SetAUTORIZACAO_ESTOQUE_STATUS(const Value: Variant);
    procedure SetAUTORIZACAO_ESTOQUE_USUARIO(const Value: Variant);
    procedure SetAUTORIZACAO_FINANCEIRO_DATAHORA(const Value: Variant);
    procedure SetAUTORIZACAO_FINANCEIRO_OBS(const Value: Variant);
    procedure SetAUTORIZACAO_FINANCEIRO_STATUS(const Value: Variant);
    procedure SetAUTORIZACAO_FINANCEIRO_USUARIO(const Value: Variant);
    procedure SetAUTORIZADO(const Value: Variant);
    procedure SetBASE_ICMS(const Value: Variant);
    procedure SetBASE_ST(const Value: Variant);
    procedure SetCALCULAR_VALORES(const Value: Variant);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCONDICOES_PAG(const Value: Variant);
    procedure SetCONTATOPREV_PED(const Value: Variant);
    procedure SetCTR_IMPRESSAO_PED(const Value: Variant);
    procedure SetDATA_ACEITE(const Value: Variant);
    procedure SetDATA_PED(const Value: Variant);
    procedure SetDATAPREV_PED(const Value: Variant);
    procedure SetDESC_PED(const Value: Variant);
    procedure SetDOLAR(const Value: Variant);
    procedure SetENVIADO(const Value: Variant);
    procedure SetENVIO_WHATSAPP(const Value: Variant);
    procedure SetFRETE_NO_IPI(const Value: Variant);
    procedure SetFRETE_PED(const Value: Variant);
    procedure SetHORAPREV_PED(const Value: Variant);
    procedure SetICMS_PED(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIPI_PED(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetNUMERO_PED(const Value: Variant);
    procedure SetOBSERVACAO_PED(const Value: Variant);
    procedure SetOUTROS_PED(const Value: Variant);
    procedure SetPARCELAS_PED(const Value: Variant);
    procedure SetPEDIDO_FORNECEDOR(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetPRIMEIROVENC_PED(const Value: Variant);
    procedure SetST_PED(const Value: Variant);
    procedure SetSTATUS_ID(const Value: Variant);
    procedure SetSTATUS_PED(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTELEFONEPREV_PED(const Value: Variant);
    procedure SetTIPO_FRETE(const Value: Variant);
    procedure SetTIPO_MOEDA_ESTRANGEIRA(const Value: Variant);
    procedure SetTIPO_PRO(const Value: Variant);
    procedure SetTOTAL_PED(const Value: Variant);
    procedure SetTOTALPRODUTOS_PED(const Value: Variant);
    procedure SetTRANSPORTADORA_ID(const Value: Variant);
    procedure SetUSO_CONSUMO(const Value: Variant);
    procedure SetUSUARIO_PED(const Value: Variant);
    procedure SetVFCP(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetDATA_COTACAO(const Value: Variant);

  public

    property NUMERO_PED                      : Variant read FNUMERO_PED write SetNUMERO_PED;
    property CODIGO_FOR                      : Variant read FCODIGO_FOR write SetCODIGO_FOR;
    property DATA_PED                        : Variant read FDATA_PED write SetDATA_PED;
    property DATAPREV_PED                    : Variant read FDATAPREV_PED write SetDATAPREV_PED;
    property PARCELAS_PED                    : Variant read FPARCELAS_PED write SetPARCELAS_PED;
    property PRIMEIROVENC_PED                : Variant read FPRIMEIROVENC_PED write SetPRIMEIROVENC_PED;
    property FRETE_PED                       : Variant read FFRETE_PED write SetFRETE_PED;
    property ICMS_PED                        : Variant read FICMS_PED write SetICMS_PED;
    property OUTROS_PED                      : Variant read FOUTROS_PED write SetOUTROS_PED;
    property DESC_PED                        : Variant read FDESC_PED write SetDESC_PED;
    property TOTAL_PED                       : Variant read FTOTAL_PED write SetTOTAL_PED;
    property OBSERVACAO_PED                  : Variant read FOBSERVACAO_PED write SetOBSERVACAO_PED;
    property USUARIO_PED                     : Variant read FUSUARIO_PED write SetUSUARIO_PED;
    property STATUS_PED                      : Variant read FSTATUS_PED write SetSTATUS_PED;
    property TOTALPRODUTOS_PED               : Variant read FTOTALPRODUTOS_PED write SetTOTALPRODUTOS_PED;
    property TIPO_PRO                        : Variant read FTIPO_PRO write SetTIPO_PRO;
    property CTR_IMPRESSAO_PED               : Variant read FCTR_IMPRESSAO_PED write SetCTR_IMPRESSAO_PED;
    property LOJA                            : Variant read FLOJA write SetLOJA;
    property DOLAR                           : Variant read FDOLAR write SetDOLAR;
    property CONDICOES_PAG                   : Variant read FCONDICOES_PAG write SetCONDICOES_PAG;
    property ID                              : Variant read FID write SetID;
    property TRANSPORTADORA_ID               : Variant read FTRANSPORTADORA_ID write SetTRANSPORTADORA_ID;
    property STATUS_ID                       : Variant read FSTATUS_ID write SetSTATUS_ID;
    property AUTORIZADO                      : Variant read FAUTORIZADO write SetAUTORIZADO;
    property ENVIADO                         : Variant read FENVIADO write SetENVIADO;
    property IPI_PED                         : Variant read FIPI_PED write SetIPI_PED;
    property ST_PED                          : Variant read FST_PED write SetST_PED;
    property TIPO_MOEDA_ESTRANGEIRA          : Variant read FTIPO_MOEDA_ESTRANGEIRA write SetTIPO_MOEDA_ESTRANGEIRA;
    property PEDIDO_FORNECEDOR               : Variant read FPEDIDO_FORNECEDOR write SetPEDIDO_FORNECEDOR;
    property DATA_ACEITE                     : Variant read FDATA_ACEITE write SetDATA_ACEITE;
    property AUTORIZACAO_ESTOQUE_STATUS      : Variant read FAUTORIZACAO_ESTOQUE_STATUS write SetAUTORIZACAO_ESTOQUE_STATUS;
    property AUTORIZACAO_ESTOQUE_USUARIO     : Variant read FAUTORIZACAO_ESTOQUE_USUARIO write SetAUTORIZACAO_ESTOQUE_USUARIO;
    property AUTORIZACAO_ESTOQUE_DATAHORA    : Variant read FAUTORIZACAO_ESTOQUE_DATAHORA write SetAUTORIZACAO_ESTOQUE_DATAHORA;
    property AUTORIZACAO_ESTOQUE_OBS         : Variant read FAUTORIZACAO_ESTOQUE_OBS write SetAUTORIZACAO_ESTOQUE_OBS;
    property AUTORIZACAO_FINANCEIRO_STATUS   : Variant read FAUTORIZACAO_FINANCEIRO_STATUS write SetAUTORIZACAO_FINANCEIRO_STATUS;
    property AUTORIZACAO_FINANCEIRO_USUARIO  : Variant read FAUTORIZACAO_FINANCEIRO_USUARIO write SetAUTORIZACAO_FINANCEIRO_USUARIO;
    property AUTORIZACAO_FINANCEIRO_DATAHORA : Variant read FAUTORIZACAO_FINANCEIRO_DATAHORA write SetAUTORIZACAO_FINANCEIRO_DATAHORA;
    property AUTORIZACAO_FINANCEIRO_OBS      : Variant read FAUTORIZACAO_FINANCEIRO_OBS write SetAUTORIZACAO_FINANCEIRO_OBS;
    property TIPO_FRETE                      : Variant read FTIPO_FRETE write SetTIPO_FRETE;
    property BASE_ICMS                       : Variant read FBASE_ICMS write SetBASE_ICMS;
    property BASE_ST                         : Variant read FBASE_ST write SetBASE_ST;
    property VFCP                            : Variant read FVFCP write SetVFCP;
    property VFCPST                          : Variant read FVFCPST write SetVFCPST;
    property HORAPREV_PED                    : Variant read FHORAPREV_PED write SetHORAPREV_PED;
    property CONTATOPREV_PED                 : Variant read FCONTATOPREV_PED write SetCONTATOPREV_PED;
    property TELEFONEPREV_PED                : Variant read FTELEFONEPREV_PED write SetTELEFONEPREV_PED;
    property CALCULAR_VALORES                : Variant read FCALCULAR_VALORES write SetCALCULAR_VALORES;
    property USO_CONSUMO                     : Variant read FUSO_CONSUMO write SetUSO_CONSUMO;
    property FRETE_NO_IPI                    : Variant read FFRETE_NO_IPI write SetFRETE_NO_IPI;
    property PORTADOR_ID                     : Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property SYSTIME                         : Variant read FSYSTIME write SetSYSTIME;
    property ENVIO_WHATSAPP                  : Variant read FENVIO_WHATSAPP write SetENVIO_WHATSAPP;
    property DATA_COTACAO                    : Variant read FDATA_COTACAO write SetDATA_COTACAO;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID, pFornecedor : String): TPedidoCompraModel;
    function Excluir(pID, pFornecedor : String): String;
    function Salvar : String;
    function AdicionarItens(pPedidoItensParams : TPedidoItensParams)  : String;
    function carregaClasse(pID, pFornecedor : String): TPedidoCompraModel;
    function obterLista: TFDMemTable;
    function ObterTotalizador : TFDMemTable;

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

    procedure getDadosFornecedor;

  end;

implementation

uses
  PedidoCompraDao,  
  System.Classes,
  System.SysUtils, ProdutosModel, PedidoCompraItensModel, FornecedorModel;

{ TPedidoCompraModel }

function TPedidoCompraModel.AdicionarItens(pPedidoItensParams: TPedidoItensParams): String;
var
  lPedidoCompraModel      : TPedidoCompraModel;
  lPedidoCompraItensModel : TPedidoCompraItensModel;
begin
  lPedidoCompraModel      := TPedidoCompraModel.Create(vIConexao);
  lPedidoCompraItensModel := TPedidoCompraItensModel.Create(vIConexao);

  if pPedidoItensParams.NUMERO_PED = '' then
     CriaException('Pedido não informado');

  if pPedidoItensParams.CODIGO_FOR = '' then
     CriaException('Fornecedor não informado');

  if pPedidoItensParams.CODIGO_PRO = '' then
     CriaException('Produto não informado');

  if StrToFloatDef(pPedidoItensParams.QUANTIDADE_PED, 0) = 0 then
     CriaException('Quantidade não informado');

  if StrToFloatDef(pPedidoItensParams.VALORUNI_PED, 0) = 0 then
     CriaException('Valor Unitario não informado');

  try
    self := self.carregaClasse(pPedidoItensParams.NUMERO_PED, pPedidoItensParams.CODIGO_FOR);

    lPedidoCompraItensModel.NUMERO_PED           := self.FNUMERO_PED;
    lPedidoCompraItensModel.CODIGO_FOR           := self.FCODIGO_FOR;
    lPedidoCompraItensModel.CODIGO_PRO           := pPedidoItensParams.CODIGO_PRO;
    lPedidoCompraItensModel.QUANTIDADE_PED       := pPedidoItensParams.QUANTIDADE_PED;
    lPedidoCompraItensModel.VALORUNI_PED         := pPedidoItensParams.VALORUNI_PED;
    lPedidoCompraItensModel.STATUS_PED           := 'A';
    lPedidoCompraItensModel.PERCENTUAL_DESCONTO  := pPedidoItensParams.PERCENTUAL_DESCONTO;
    lPedidoCompraItensModel.VLR_DESCONTO         := (lPedidoCompraItensModel.QUANTIDADE_PED  * lPedidoCompraItensModel.VALORUNI_PED) * ( StrToFloatDef(lPedidoCompraItensModel.PERCENTUAL_DESCONTO, 0) / 100);
    lPedidoCompraItensModel.VLR_OUTRAS           := pPedidoItensParams.VALOR_OUTRAS_DESPESAS;
    lPedidoCompraItensModel.OBSERVACAO           := pPedidoItensParams.OBSERVACAO;
    lPedidoCompraItensModel.CFOP_ID              := pPedidoItensParams.CFOP;
    lPedidoCompraItensModel.CST_N12              := pPedidoItensParams.CST;
    lPedidoCompraItensModel.IPI_PED              := pPedidoItensParams.ALIQUOTA_IPI;
    lPedidoCompraItensModel.VALOR_BASE_IPI       := pPedidoItensParams.VALOR_BASE_IPI;
    lPedidoCompraItensModel.VIPI_014             := pPedidoItensParams.VALOR_IPI;
    lPedidoCompraItensModel.PREDBC_N14           := pPedidoItensParams.PERCENTUAL_REDUCAO_ICMS;
    lPedidoCompraItensModel.PICMS_N16            := pPedidoItensParams.ALIQUOTA_ICMS;
    lPedidoCompraItensModel.VBCICMS_N15          := pPedidoItensParams.VALOR_BASE_ICMS;
    lPedidoCompraItensModel.VICMS_N17            := pPedidoItensParams.VALOR_ICMS;
    lPedidoCompraItensModel.PMVAST_N19           := pPedidoItensParams.PERCENTUAL_MVA;
    lPedidoCompraItensModel.PREDBCST_N20         := pPedidoItensParams.PERCENTUAL_REDUCAO_ICMS_ST;
    lPedidoCompraItensModel.PST_N22              := pPedidoItensParams.PERCENTUAL_ICMS_ST;
    lPedidoCompraItensModel.VBCST_N21            := pPedidoItensParams.VALOR_BASE_ICMS_ST;
    lPedidoCompraItensModel.VST_N23              := pPedidoItensParams.VALOR_ICMS_ST;

    Result := lPedidoCompraItensModel.Incluir;

  finally
    lPedidoCompraItensModel.Free;
  end;
end;

function TPedidoCompraModel.Alterar(pID, pFornecedor: String): TPedidoCompraModel;
var
  lPedidoCompraModel : TPedidoCompraModel;
begin
  lPedidoCompraModel := TPedidoCompraModel.Create(vIConexao);
  try
    lPedidoCompraModel       := lPedidoCompraModel.carregaClasse(pID, pFornecedor);
    lPedidoCompraModel.Acao  := tacAlterar;
    Result                   := lPedidoCompraModel;
  finally
  end;
end;

function TPedidoCompraModel.Excluir(pID, pFornecedor: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

procedure TPedidoCompraModel.getDadosFornecedor;
var
  lFornecedorModel : TFornecedorModel;
begin
  if self.FCODIGO_FOR = '' then
    Exit;

  lFornecedorModel := TFornecedorModel.Create(vIConexao);
  try
    lFornecedorModel.IDRecordView := self.CODIGO_FOR;
    lFornecedorModel.obterLista;

    self.FCONDICOES_PAG     := lFornecedorModel.CONDICOES_PAG;
    self.FTRANSPORTADORA_ID := lFornecedorModel.TRANSPORTADORA_ID;

    if lFornecedorModel.PREVISAO_ENTREGA <> '' then
      self.FDATAPREV_PED := vIConexao.DataServer + lFornecedorModel.PREVISAO_ENTREGA;

  finally
    lFornecedorModel.Free;
  end;
end;

function TPedidoCompraModel.Incluir: String;
begin
  self.FTIPO_PRO         := 'N';
  self.FCALCULAR_VALORES := 'S';
  self.FUSO_CONSUMO      := 'N';
  self.FTIPO_FRETE       := 'P';
  self.FFRETE_NO_IPI     := 'S';
  self.FAUTORIZADO       := 'S';

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TPedidoCompraModel.carregaClasse(pID, pFornecedor : String): TPedidoCompraModel;
var
  lPedidoCompraDao: TPedidoCompraDao;
begin
  lPedidoCompraDao := TPedidoCompraDao.Create(vIConexao);
  try
    Result := lPedidoCompraDao.carregaClasse(pId);
  finally
    lPedidoCompraDao.Free;
  end;
end;

constructor TPedidoCompraModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPedidoCompraModel.Destroy;
begin
  inherited;
end;

function TPedidoCompraModel.obterLista: TFDMemTable;
var
  lPedidoCompraLista: TPedidoCompraDao;
begin
  lPedidoCompraLista := TPedidoCompraDao.Create(vIConexao);

  try
    lPedidoCompraLista.TotalRecords    := FTotalRecords;
    lPedidoCompraLista.WhereView       := FWhereView;
    lPedidoCompraLista.CountView       := FCountView;
    lPedidoCompraLista.OrderView       := FOrderView;
    lPedidoCompraLista.StartRecordView := FStartRecordView;
    lPedidoCompraLista.LengthPageView  := FLengthPageView;
    lPedidoCompraLista.IDRecordView    := FIDRecordView;
    lPedidoCompraLista.NumeroView      := FNumeroView;
    lPedidoCompraLista.FornecedorVew   := FFornecedorView;

    Result := lPedidoCompraLista.obterLista;

    FTotalRecords := lPedidoCompraLista.TotalRecords;

  finally
    lPedidoCompraLista.Free;
  end;
end;

function TPedidoCompraModel.ObterTotalizador: TFDMemTable;
var
  lPedidoCompra: TPedidoCompraDao;
begin
  lPedidoCompra := TPedidoCompraDao.Create(vIConexao);

  try
    lPedidoCompra.NumeroView    := FNumeroView;
    lPedidoCompra.FornecedorVew := FFornecedorView;

    Result := lPedidoCompra.ObterTotalizador;

    FTotalRecords := lPedidoCompra.TotalRecords;
  finally
    lPedidoCompra.Free;
  end;
end;

function TPedidoCompraModel.Salvar: String;
var
  lPedidoCompraDao: TPedidoCompraDao;
begin
  lPedidoCompraDao := TPedidoCompraDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPedidoCompraDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lPedidoCompraDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lPedidoCompraDao.excluir(Self);
    end;
  finally
    lPedidoCompraDao.Free;
  end;
end;

procedure TPedidoCompraModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZACAO_ESTOQUE_DATAHORA(
  const Value: Variant);
begin
  FAUTORIZACAO_ESTOQUE_DATAHORA := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZACAO_ESTOQUE_OBS(const Value: Variant);
begin
  FAUTORIZACAO_ESTOQUE_OBS := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZACAO_ESTOQUE_STATUS(
  const Value: Variant);
begin
  FAUTORIZACAO_ESTOQUE_STATUS := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZACAO_ESTOQUE_USUARIO(
  const Value: Variant);
begin
  FAUTORIZACAO_ESTOQUE_USUARIO := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZACAO_FINANCEIRO_DATAHORA(
  const Value: Variant);
begin
  FAUTORIZACAO_FINANCEIRO_DATAHORA := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZACAO_FINANCEIRO_OBS(
  const Value: Variant);
begin
  FAUTORIZACAO_FINANCEIRO_OBS := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZACAO_FINANCEIRO_STATUS(
  const Value: Variant);
begin
  FAUTORIZACAO_FINANCEIRO_STATUS := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZACAO_FINANCEIRO_USUARIO(
  const Value: Variant);
begin
  FAUTORIZACAO_FINANCEIRO_USUARIO := Value;
end;

procedure TPedidoCompraModel.SetAUTORIZADO(const Value: Variant);
begin
  FAUTORIZADO := Value;
end;

procedure TPedidoCompraModel.SetBASE_ICMS(const Value: Variant);
begin
  FBASE_ICMS := Value;
end;

procedure TPedidoCompraModel.SetBASE_ST(const Value: Variant);
begin
  FBASE_ST := Value;
end;

procedure TPedidoCompraModel.SetCALCULAR_VALORES(const Value: Variant);
begin
  FCALCULAR_VALORES := Value;
end;

procedure TPedidoCompraModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
  getDadosFornecedor;
end;

procedure TPedidoCompraModel.SetCONDICOES_PAG(const Value: Variant);
begin
  FCONDICOES_PAG := Value;
end;

procedure TPedidoCompraModel.SetCONTATOPREV_PED(const Value: Variant);
begin
  FCONTATOPREV_PED := Value;
end;

procedure TPedidoCompraModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoCompraModel.SetCTR_IMPRESSAO_PED(const Value: Variant);
begin
  FCTR_IMPRESSAO_PED := Value;
end;

procedure TPedidoCompraModel.SetDATAPREV_PED(const Value: Variant);
begin
  FDATAPREV_PED := Value;
end;

procedure TPedidoCompraModel.SetDATA_ACEITE(const Value: Variant);
begin
  FDATA_ACEITE := Value;
end;

procedure TPedidoCompraModel.SetDATA_COTACAO(const Value: Variant);
begin
  FDATA_COTACAO := Value;
end;

procedure TPedidoCompraModel.SetDATA_PED(const Value: Variant);
begin
  FDATA_PED := Value;
end;

procedure TPedidoCompraModel.SetDESC_PED(const Value: Variant);
begin
  FDESC_PED := Value;
end;

procedure TPedidoCompraModel.SetDOLAR(const Value: Variant);
begin
  FDOLAR := Value;
end;

procedure TPedidoCompraModel.SetENVIADO(const Value: Variant);
begin
  FENVIADO := Value;
end;

procedure TPedidoCompraModel.SetENVIO_WHATSAPP(const Value: Variant);
begin
  FENVIO_WHATSAPP := Value;
end;

procedure TPedidoCompraModel.SetFornecedorView(const Value: String);
begin
  FFornecedorView := Value;
end;

procedure TPedidoCompraModel.SetFRETE_NO_IPI(const Value: Variant);
begin
  FFRETE_NO_IPI := Value;
end;

procedure TPedidoCompraModel.SetFRETE_PED(const Value: Variant);
begin
  FFRETE_PED := Value;
end;

procedure TPedidoCompraModel.SetHORAPREV_PED(const Value: Variant);
begin
  FHORAPREV_PED := Value;
end;

procedure TPedidoCompraModel.SetICMS_PED(const Value: Variant);
begin
  FICMS_PED := Value;
end;

procedure TPedidoCompraModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPedidoCompraModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPedidoCompraModel.SetIPI_PED(const Value: Variant);
begin
  FIPI_PED := Value;
end;

procedure TPedidoCompraModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoCompraModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TPedidoCompraModel.SetNumeroView(const Value: String);
begin
  FNumeroView := Value;
end;

procedure TPedidoCompraModel.SetNUMERO_PED(const Value: Variant);
begin
  FNUMERO_PED := Value;
end;

procedure TPedidoCompraModel.SetOBSERVACAO_PED(const Value: Variant);
begin
  FOBSERVACAO_PED := Value;
end;

procedure TPedidoCompraModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TPedidoCompraModel.SetOUTROS_PED(const Value: Variant);
begin
  FOUTROS_PED := Value;
end;

procedure TPedidoCompraModel.SetPARCELAS_PED(const Value: Variant);
begin
  FPARCELAS_PED := Value;
end;

procedure TPedidoCompraModel.SetPEDIDO_FORNECEDOR(const Value: Variant);
begin
  FPEDIDO_FORNECEDOR := Value;
end;

procedure TPedidoCompraModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TPedidoCompraModel.SetPRIMEIROVENC_PED(const Value: Variant);
begin
  FPRIMEIROVENC_PED := Value;
end;

procedure TPedidoCompraModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TPedidoCompraModel.SetSTATUS_ID(const Value: Variant);
begin
  FSTATUS_ID := Value;
end;

procedure TPedidoCompraModel.SetSTATUS_PED(const Value: Variant);
begin
  FSTATUS_PED := Value;
end;

procedure TPedidoCompraModel.SetST_PED(const Value: Variant);
begin
  FST_PED := Value;
end;

procedure TPedidoCompraModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPedidoCompraModel.SetTELEFONEPREV_PED(const Value: Variant);
begin
  FTELEFONEPREV_PED := Value;
end;

procedure TPedidoCompraModel.SetTIPO_FRETE(const Value: Variant);
begin
  FTIPO_FRETE := Value;
end;

procedure TPedidoCompraModel.SetTIPO_MOEDA_ESTRANGEIRA(const Value: Variant);
begin
  FTIPO_MOEDA_ESTRANGEIRA := Value;
end;

procedure TPedidoCompraModel.SetTIPO_PRO(const Value: Variant);
begin
  FTIPO_PRO := Value;
end;

procedure TPedidoCompraModel.SetTOTALPRODUTOS_PED(const Value: Variant);
begin
  FTOTALPRODUTOS_PED := Value;
end;

procedure TPedidoCompraModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TPedidoCompraModel.SetTOTAL_PED(const Value: Variant);
begin
  FTOTAL_PED := Value;
end;

procedure TPedidoCompraModel.SetTRANSPORTADORA_ID(const Value: Variant);
begin
  FTRANSPORTADORA_ID := Value;
end;

procedure TPedidoCompraModel.SetUSO_CONSUMO(const Value: Variant);
begin
  FUSO_CONSUMO := Value;
end;

procedure TPedidoCompraModel.SetUSUARIO_PED(const Value: Variant);
begin
  FUSUARIO_PED := Value;
end;

procedure TPedidoCompraModel.SetVFCP(const Value: Variant);
begin
  FVFCP := Value;
end;

procedure TPedidoCompraModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TPedidoCompraModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
