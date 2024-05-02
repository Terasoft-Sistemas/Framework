unit SaidasModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TSaidaItensParams = Record
    CODIGO_PRO,
    QUANTIDADE_SAI,
    VALOR_UNI_SAI : String;
  End;

  TSaidasModel = class

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
    FSYSTIME: Variant;
    FDATAHORA_CHECAGEM: Variant;
    FPREVISAO: Variant;
    FCARGA_ID: Variant;
    FUF_TRANSPORTADORA: Variant;
    FPRECO_VENDA_ID: Variant;
    FTOTAL_SAI: Variant;
    FNF_SAI: Variant;
    FPEDIDO_COMPRA: Variant;
    FORCAMENTO_ID: Variant;
    FCFOP_SAI: Variant;
    FNUMERO_SAI: Variant;
    FPESO_LIQUIDO: Variant;
    FTRANSPORTADORA_ID: Variant;
    FICMS_ST_SAI: Variant;
    FSTATUS_SAI: Variant;
    FOUTROS_SAI: Variant;
    FPIS_SAI: Variant;
    FBASE_ICMS_SAI: Variant;
    FCOFINS_SAI: Variant;
    FTRANSFERENCIA: Variant;
    FCODIGO_CTA: Variant;
    FCODIGO_CLI: Variant;
    FESPECIE_VOLUME: Variant;
    FTOTAL_PRODUTOS_SAI: Variant;
    FVENDEDOR_ID: Variant;
    FLOJA: Variant;
    FCFOP_ID: Variant;
    FCONCLUIDA: Variant;
    FUSUARIO_SAI: Variant;
    FDESC_SAI: Variant;
    FPESO_BRUTO: Variant;
    FIPI_SAI: Variant;
    FRNTRC: Variant;
    FDATA_SAI: Variant;
    FUSUARIO_CHECAGEM: Variant;
    FBASE_ST_SAI: Variant;
    FVALOR_ICMS_SAI: Variant;
    FPLACA: Variant;
    FTAXA_SAI: Variant;
    FOBSERVACAO_SAI: Variant;
    FCTR_IMPRESSAO_PED: Variant;
    FQTDE_VOLUME: Variant;
    FORDEM: Variant;
    FID: Variant;
    FSaidaView: String;
    FLojaView: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetBASE_ICMS_SAI(const Value: Variant);
    procedure SetBASE_ST_SAI(const Value: Variant);
    procedure SetCARGA_ID(const Value: Variant);
    procedure SetCFOP_ID(const Value: Variant);
    procedure SetCFOP_SAI(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCODIGO_CTA(const Value: Variant);
    procedure SetCOFINS_SAI(const Value: Variant);
    procedure SetCONCLUIDA(const Value: Variant);
    procedure SetCTR_IMPRESSAO_PED(const Value: Variant);
    procedure SetDATA_SAI(const Value: Variant);
    procedure SetDATAHORA_CHECAGEM(const Value: Variant);
    procedure SetDESC_SAI(const Value: Variant);
    procedure SetESPECIE_VOLUME(const Value: Variant);
    procedure SetICMS_ST_SAI(const Value: Variant);
    procedure SetIPI_SAI(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetNF_SAI(const Value: Variant);
    procedure SetNUMERO_SAI(const Value: Variant);
    procedure SetOBSERVACAO_SAI(const Value: Variant);
    procedure SetORCAMENTO_ID(const Value: Variant);
    procedure SetORDEM(const Value: Variant);
    procedure SetOUTROS_SAI(const Value: Variant);
    procedure SetPEDIDO_COMPRA(const Value: Variant);
    procedure SetPESO_BRUTO(const Value: Variant);
    procedure SetPESO_LIQUIDO(const Value: Variant);
    procedure SetPIS_SAI(const Value: Variant);
    procedure SetPLACA(const Value: Variant);
    procedure SetPRECO_VENDA_ID(const Value: Variant);
    procedure SetPREVISAO(const Value: Variant);
    procedure SetQTDE_VOLUME(const Value: Variant);
    procedure SetRNTRC(const Value: Variant);
    procedure SetSTATUS_SAI(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAXA_SAI(const Value: Variant);
    procedure SetTOTAL_PRODUTOS_SAI(const Value: Variant);
    procedure SetTOTAL_SAI(const Value: Variant);
    procedure SetTRANSFERENCIA(const Value: Variant);
    procedure SetTRANSPORTADORA_ID(const Value: Variant);
    procedure SetUF_TRANSPORTADORA(const Value: Variant);
    procedure SetUSUARIO_CHECAGEM(const Value: Variant);
    procedure SetUSUARIO_SAI(const Value: Variant);
    procedure SetVALOR_ICMS_SAI(const Value: Variant);
    procedure SetVENDEDOR_ID(const Value: Variant);
    procedure SetSaidaView(const Value: String);
    procedure SetLojaView(const Value: String);

  public

    property NUMERO_SAI         : Variant read FNUMERO_SAI write SetNUMERO_SAI;
    property CODIGO_CLI         : Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property DATA_SAI           : Variant read FDATA_SAI write SetDATA_SAI;
    property IPI_SAI            : Variant read FIPI_SAI write SetIPI_SAI;
    property VALOR_ICMS_SAI     : Variant read FVALOR_ICMS_SAI write SetVALOR_ICMS_SAI;
    property BASE_ICMS_SAI      : Variant read FBASE_ICMS_SAI write SetBASE_ICMS_SAI;
    property OUTROS_SAI         : Variant read FOUTROS_SAI write SetOUTROS_SAI;
    property DESC_SAI           : Variant read FDESC_SAI write SetDESC_SAI;
    property TOTAL_SAI          : Variant read FTOTAL_SAI write SetTOTAL_SAI;
    property OBSERVACAO_SAI     : Variant read FOBSERVACAO_SAI write SetOBSERVACAO_SAI;
    property USUARIO_SAI        : Variant read FUSUARIO_SAI write SetUSUARIO_SAI;
    property STATUS_SAI         : Variant read FSTATUS_SAI write SetSTATUS_SAI;
    property TOTAL_PRODUTOS_SAI : Variant read FTOTAL_PRODUTOS_SAI write SetTOTAL_PRODUTOS_SAI;
    property CFOP_SAI           : Variant read FCFOP_SAI write SetCFOP_SAI;
    property PIS_SAI            : Variant read FPIS_SAI write SetPIS_SAI;
    property COFINS_SAI         : Variant read FCOFINS_SAI write SetCOFINS_SAI;
    property TAXA_SAI           : Variant read FTAXA_SAI write SetTAXA_SAI;
    property LOJA               : Variant read FLOJA write SetLOJA;
    property ICMS_ST_SAI        : Variant read FICMS_ST_SAI write SetICMS_ST_SAI;
    property BASE_ST_SAI        : Variant read FBASE_ST_SAI write SetBASE_ST_SAI;
    property NF_SAI             : Variant read FNF_SAI write SetNF_SAI;
    property CONCLUIDA          : Variant read FCONCLUIDA write SetCONCLUIDA;
    property ID                 : Variant read FID write SetID;
    property CARGA_ID           : Variant read FCARGA_ID write SetCARGA_ID;
    property VENDEDOR_ID        : Variant read FVENDEDOR_ID write SetVENDEDOR_ID;
    property ORDEM              : Variant read FORDEM write SetORDEM;
    property ORCAMENTO_ID       : Variant read FORCAMENTO_ID write SetORCAMENTO_ID;
    property CODIGO_CTA         : Variant read FCODIGO_CTA write SetCODIGO_CTA;
    property PREVISAO           : Variant read FPREVISAO write SetPREVISAO;
    property PRECO_VENDA_ID     : Variant read FPRECO_VENDA_ID write SetPRECO_VENDA_ID;
    property USUARIO_CHECAGEM   : Variant read FUSUARIO_CHECAGEM write SetUSUARIO_CHECAGEM;
    property DATAHORA_CHECAGEM  : Variant read FDATAHORA_CHECAGEM write SetDATAHORA_CHECAGEM;
    property TRANSPORTADORA_ID  : Variant read FTRANSPORTADORA_ID write SetTRANSPORTADORA_ID;
    property RNTRC              : Variant read FRNTRC write SetRNTRC;
    property PLACA              : Variant read FPLACA write SetPLACA;
    property UF_TRANSPORTADORA  : Variant read FUF_TRANSPORTADORA write SetUF_TRANSPORTADORA;
    property PESO_LIQUIDO       : Variant read FPESO_LIQUIDO write SetPESO_LIQUIDO;
    property PESO_BRUTO         : Variant read FPESO_BRUTO write SetPESO_BRUTO;
    property QTDE_VOLUME        : Variant read FQTDE_VOLUME write SetQTDE_VOLUME;
    property ESPECIE_VOLUME     : Variant read FESPECIE_VOLUME write SetESPECIE_VOLUME;
    property TRANSFERENCIA      : Variant read FTRANSFERENCIA write SetTRANSFERENCIA;
    property CFOP_ID            : Variant read FCFOP_ID write SetCFOP_ID;
    property PEDIDO_COMPRA      : Variant read FPEDIDO_COMPRA write SetPEDIDO_COMPRA;
    property CTR_IMPRESSAO_PED  : Variant read FCTR_IMPRESSAO_PED write SetCTR_IMPRESSAO_PED;
    property SYSTIME            : Variant read FSYSTIME write SetSYSTIME;

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property SaidaView : String read FSaidaView write SetSaidaView;
    property LojaView : String read FLojaView write SetLojaView;

    function Incluir: String;
    function Alterar(pID : String): TSaidasModel;
    function Excluir(pNumero_Saida: String): String;
    function Salvar : String;
    function carregaClasse(pID : String): TSaidasModel;
    function obterLista: TFDMemTable;

    function AdicionarItens(pSaidaItemParams : TSaidaItensParams) : String;
    procedure CalcularTotais;
    procedure GetDadosCFOP;

  end;

implementation

uses
  SaidasDao,
  System.Classes, 
  System.SysUtils, CFOPModel, ProdutosModel, SaidasItensModel;

{ TSaidasModel }

function TSaidasModel.AdicionarItens(pSaidaItemParams: TSaidaItensParams): string;
var
  lSaidasItensModel : TSaidasItensModel;
begin
  lSaidasItensModel := TSaidasItensModel.Create(vIConexao);

  if pSaidaItemParams.CODIGO_PRO = '' then
    CriaException('Produto não informado');

  if StrToFloatDef(pSaidaItemParams.QUANTIDADE_SAI, 0) = 0 then
    CriaException('Quantidade não informado');

  try
    lSaidasItensModel.NUMERO_SAI       := self.FNUMERO_SAI;
    lSaidasItensModel.CODIGO_CLI       := self.FCODIGO_CLI;
    lSaidasItensModel.LOJA             := self.FLOJA;
    lSaidasItensModel.CODIGO_PRO       := pSaidaItemParams.CODIGO_PRO;
    lSaidasItensModel.QUANTIDADE_SAI   := pSaidaItemParams.QUANTIDADE_SAI;
    lSaidasItensModel.VALOR_UNI_SAI    := pSaidaItemParams.VALOR_UNI_SAI;

    Result := lSaidasItensModel.Incluir;

    self.CalcularTotais;

  finally
    lSaidasItensModel.Free;
  end;
end;

function TSaidasModel.Alterar(pID: String): TSaidasModel;
var
  lSaidasModel : TSaidasModel;
begin
  lSaidasModel := TSaidasModel.Create(vIConexao);
  try
    lSaidasModel       := lSaidasModel.carregaClasse(pID);
    lSaidasModel.Acao  := tacAlterar;
    Result             := lSaidasModel;
  finally
  end;
end;

procedure TSaidasModel.CalcularTotais;
var
  lSaidasItens : TSaidasItensModel;
  lMemTable    : TFDMemTable;
begin
  lSaidasItens := TSaidasItensModel.Create(vIConexao);
  try
    lMemTable := lSaidasItens.ObterTotais(self.NUMERO_SAI);

    self.Alterar(self.FNUMERO_SAI);

    self.FVALOR_ICMS_SAI     := lMemTable.FieldByName('custo').AsFloat;
    self.FTOTAL_PRODUTOS_SAI := lMemTable.FieldByName('valor').AsFloat;
    self.FTOTAL_SAI          := lMemTable.FieldByName('valor').AsFloat;

    self.Salvar;
  finally
    lSaidasItens.Free;
  end;
end;

function TSaidasModel.Excluir(pNumero_Saida: String): String;
begin
  self.NUMERO_SAI := pNumero_Saida;
  self.FAcao      := tacExcluir;
  Result          := self.Salvar;
end;

procedure TSaidasModel.GetDadosCFOP;
var
  lCFOPModel : TCFOPModel;
begin
  if Self.FCFOP_ID = '' then
    Exit;

  lCFOPModel := TCFOPModel.Create(vIConexao);
  try
    lCFOPModel     := lCFOPModel.carregaClasse(Self.FCFOP_ID);
    self.FCFOP_SAI := lCFOPModel.CFOP;

  finally
    lCFOPModel.Free;
  end;
end;

function TSaidasModel.Incluir: String;
begin
  self.FUSUARIO_SAI := vIConexao.getUSer.ID;
  self.FDATA_SAI    := DateToStr(vIConexao.DataServer);
  self.FSTATUS_SAI  := '0';
  self.FCONCLUIDA   := 'N';
  self.FLOJA        := vIConexao.getEmpresa.LOJA;

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TSaidasModel.carregaClasse(pID : String): TSaidasModel;
var
  lSaidasDao: TSaidasDao;
begin
  lSaidasDao := TSaidasDao.Create(vIConexao);
  try
    Result := lSaidasDao.carregaClasse(pID);
  finally
    lSaidasDao.Free;
  end;
end;

constructor TSaidasModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TSaidasModel.Destroy;
begin
  inherited;
end;

function TSaidasModel.obterLista: TFDMemTable;
var
  lSaidasLista: TSaidasDao;
begin
  lSaidasLista := TSaidasDao.Create(vIConexao);

  try
    lSaidasLista.TotalRecords    := FTotalRecords;
    lSaidasLista.WhereView       := FWhereView;
    lSaidasLista.CountView       := FCountView;
    lSaidasLista.OrderView       := FOrderView;
    lSaidasLista.StartRecordView := FStartRecordView;
    lSaidasLista.LengthPageView  := FLengthPageView;
    lSaidasLista.IDRecordView    := FIDRecordView;
    lSaidasLista.SaidaView       := FSaidaView;
    lSaidasLista.LojaView        := FLojaView;

    Result := lSaidasLista.obterLista;

    FTotalRecords := lSaidasLista.TotalRecords;

  finally
    lSaidasLista.Free;
  end;
end;

function TSaidasModel.Salvar: String;
var
  lSaidasDao: TSaidasDao;
begin
  lSaidasDao := TSaidasDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lSaidasDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lSaidasDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lSaidasDao.excluir(Self);
    end;
  finally
    lSaidasDao.Free;
  end;
end;

procedure TSaidasModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TSaidasModel.SetBASE_ICMS_SAI(const Value: Variant);
begin
  FBASE_ICMS_SAI := Value;
end;

procedure TSaidasModel.SetBASE_ST_SAI(const Value: Variant);
begin
  FBASE_ST_SAI := Value;
end;

procedure TSaidasModel.SetCARGA_ID(const Value: Variant);
begin
  FCARGA_ID := Value;
end;

procedure TSaidasModel.SetCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
  GetDadosCFOP;
end;

procedure TSaidasModel.SetCFOP_SAI(const Value: Variant);
begin
  FCFOP_SAI := Value;
end;

procedure TSaidasModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TSaidasModel.SetCODIGO_CTA(const Value: Variant);
begin
  FCODIGO_CTA := Value;
end;

procedure TSaidasModel.SetCOFINS_SAI(const Value: Variant);
begin
  FCOFINS_SAI := Value;
end;

procedure TSaidasModel.SetCONCLUIDA(const Value: Variant);
begin
  FCONCLUIDA := Value;
end;

procedure TSaidasModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSaidasModel.SetCTR_IMPRESSAO_PED(const Value: Variant);
begin
  FCTR_IMPRESSAO_PED := Value;
end;

procedure TSaidasModel.SetDATAHORA_CHECAGEM(const Value: Variant);
begin
  FDATAHORA_CHECAGEM := Value;
end;

procedure TSaidasModel.SetDATA_SAI(const Value: Variant);
begin
  FDATA_SAI := Value;
end;

procedure TSaidasModel.SetDESC_SAI(const Value: Variant);
begin
  FDESC_SAI := Value;
end;

procedure TSaidasModel.SetESPECIE_VOLUME(const Value: Variant);
begin
  FESPECIE_VOLUME := Value;
end;

procedure TSaidasModel.SetICMS_ST_SAI(const Value: Variant);
begin
  FICMS_ST_SAI := Value;
end;

procedure TSaidasModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSaidasModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TSaidasModel.SetIPI_SAI(const Value: Variant);
begin
  FIPI_SAI := Value;
end;

procedure TSaidasModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSaidasModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TSaidasModel.SetLojaView(const Value: String);
begin
  FLojaView := Value;
end;

procedure TSaidasModel.SetNF_SAI(const Value: Variant);
begin
  FNF_SAI := Value;
end;

procedure TSaidasModel.SetNUMERO_SAI(const Value: Variant);
begin
  FNUMERO_SAI := Value;
end;

procedure TSaidasModel.SetOBSERVACAO_SAI(const Value: Variant);
begin
  FOBSERVACAO_SAI := Value;
end;

procedure TSaidasModel.SetORCAMENTO_ID(const Value: Variant);
begin
  FORCAMENTO_ID := Value;
end;

procedure TSaidasModel.SetORDEM(const Value: Variant);
begin
  FORDEM := Value;
end;

procedure TSaidasModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TSaidasModel.SetOUTROS_SAI(const Value: Variant);
begin
  FOUTROS_SAI := Value;
end;

procedure TSaidasModel.SetPEDIDO_COMPRA(const Value: Variant);
begin
  FPEDIDO_COMPRA := Value;
end;

procedure TSaidasModel.SetPESO_BRUTO(const Value: Variant);
begin
  FPESO_BRUTO := Value;
end;

procedure TSaidasModel.SetPESO_LIQUIDO(const Value: Variant);
begin
  FPESO_LIQUIDO := Value;
end;

procedure TSaidasModel.SetPIS_SAI(const Value: Variant);
begin
  FPIS_SAI := Value;
end;

procedure TSaidasModel.SetPLACA(const Value: Variant);
begin
  FPLACA := Value;
end;

procedure TSaidasModel.SetPRECO_VENDA_ID(const Value: Variant);
begin
  FPRECO_VENDA_ID := Value;
end;

procedure TSaidasModel.SetPREVISAO(const Value: Variant);
begin
  FPREVISAO := Value;
end;

procedure TSaidasModel.SetQTDE_VOLUME(const Value: Variant);
begin
  FQTDE_VOLUME := Value;
end;

procedure TSaidasModel.SetRNTRC(const Value: Variant);
begin
  FRNTRC := Value;
end;

procedure TSaidasModel.SetSaidaView(const Value: String);
begin
  FSaidaView := Value;
end;

procedure TSaidasModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TSaidasModel.SetSTATUS_SAI(const Value: Variant);
begin
  FSTATUS_SAI := Value;
end;

procedure TSaidasModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TSaidasModel.SetTAXA_SAI(const Value: Variant);
begin
  FTAXA_SAI := Value;
end;

procedure TSaidasModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TSaidasModel.SetTOTAL_PRODUTOS_SAI(const Value: Variant);
begin
  FTOTAL_PRODUTOS_SAI := Value;
end;

procedure TSaidasModel.SetTOTAL_SAI(const Value: Variant);
begin
  FTOTAL_SAI := Value;
end;

procedure TSaidasModel.SetTRANSFERENCIA(const Value: Variant);
begin
  FTRANSFERENCIA := Value;
end;

procedure TSaidasModel.SetTRANSPORTADORA_ID(const Value: Variant);
begin
  FTRANSPORTADORA_ID := Value;
end;

procedure TSaidasModel.SetUF_TRANSPORTADORA(const Value: Variant);
begin
  FUF_TRANSPORTADORA := Value;
end;

procedure TSaidasModel.SetUSUARIO_CHECAGEM(const Value: Variant);
begin
  FUSUARIO_CHECAGEM := Value;
end;

procedure TSaidasModel.SetUSUARIO_SAI(const Value: Variant);
begin
  FUSUARIO_SAI := Value;
end;

procedure TSaidasModel.SetVALOR_ICMS_SAI(const Value: Variant);
begin
  FVALOR_ICMS_SAI := Value;
end;

procedure TSaidasModel.SetVENDEDOR_ID(const Value: Variant);
begin
  FVENDEDOR_ID := Value;
end;

procedure TSaidasModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
