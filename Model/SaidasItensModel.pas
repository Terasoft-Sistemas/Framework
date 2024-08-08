unit SaidasItensModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TSaidasItensModel = class

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
    FSYSTIME: Variant;
    FICMS_SAI: Variant;
    FQTD_CHECAGEM: Variant;
    FAVULSO: Variant;
    FALTURA_M: Variant;
    FNUMERO_SAI: Variant;
    FRESERVA_ID: Variant;
    FLARGURA_M: Variant;
    FDESCONTO_PED: Variant;
    FQUANTIDADE_SAI: Variant;
    FCODIGO_CLI: Variant;
    FDATA_CAD: Variant;
    FLOJA: Variant;
    FSTATUS: Variant;
    FCODIGO_PRO: Variant;
    FVALOR_UNI_SAI: Variant;
    FREPOSICAO_ID: Variant;
    FIPI_SAI: Variant;
    FPRODUCAO_ID: Variant;
    FPROFUNDIDADE_M: Variant;
    FSAIDA_ID: Variant;
    FQUANTIDADE_ATE: Variant;
    FNumeroSaidaView: String;

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
    procedure SetAVULSO(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCODIGO_PRO(const Value: Variant);
    procedure SetDATA_CAD(const Value: Variant);
    procedure SetDESCONTO_PED(const Value: Variant);
    procedure SetICMS_SAI(const Value: Variant);
    procedure SetIPI_SAI(const Value: Variant);
    procedure SetLARGURA_M(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetNUMERO_SAI(const Value: Variant);
    procedure SetPRODUCAO_ID(const Value: Variant);
    procedure SetPROFUNDIDADE_M(const Value: Variant);
    procedure SetQTD_CHECAGEM(const Value: Variant);
    procedure SetQUANTIDADE_ATE(const Value: Variant);
    procedure SetQUANTIDADE_SAI(const Value: Variant);
    procedure SetREPOSICAO_ID(const Value: Variant);
    procedure SetRESERVA_ID(const Value: Variant);
    procedure SetSAIDA_ID(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR_UNI_SAI(const Value: Variant);
    procedure SetNumeroSaidaView(const Value: String);

  public

    property NUMERO_SAI     : Variant read FNUMERO_SAI write SetNUMERO_SAI;
    property CODIGO_CLI     : Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property CODIGO_PRO     : Variant read FCODIGO_PRO write SetCODIGO_PRO;
    property QUANTIDADE_SAI : Variant read FQUANTIDADE_SAI write SetQUANTIDADE_SAI;
    property QUANTIDADE_ATE : Variant read FQUANTIDADE_ATE write SetQUANTIDADE_ATE;
    property VALOR_UNI_SAI  : Variant read FVALOR_UNI_SAI write SetVALOR_UNI_SAI;
    property IPI_SAI        : Variant read FIPI_SAI write SetIPI_SAI;
    property ICMS_SAI       : Variant read FICMS_SAI write SetICMS_SAI;
    property STATUS         : Variant read FSTATUS write SetSTATUS;
    property LOJA           : Variant read FLOJA write SetLOJA;
    property ID             : Variant read FID write SetID;
    property RESERVA_ID     : Variant read FRESERVA_ID write SetRESERVA_ID;
    property AVULSO         : Variant read FAVULSO write SetAVULSO;
    property DESCONTO_PED   : Variant read FDESCONTO_PED write SetDESCONTO_PED;
    property ALTURA_M       : Variant read FALTURA_M write SetALTURA_M;
    property LARGURA_M      : Variant read FLARGURA_M write SetLARGURA_M;
    property PROFUNDIDADE_M : Variant read FPROFUNDIDADE_M write SetPROFUNDIDADE_M;
    property DATA_CAD       : Variant read FDATA_CAD write SetDATA_CAD;
    property QTD_CHECAGEM   : Variant read FQTD_CHECAGEM write SetQTD_CHECAGEM;
    property REPOSICAO_ID   : Variant read FREPOSICAO_ID write SetREPOSICAO_ID;
    property PRODUCAO_ID    : Variant read FPRODUCAO_ID write SetPRODUCAO_ID;
    property SAIDA_ID       : Variant read FSAIDA_ID write SetSAIDA_ID;
    property SYSTIME        : Variant read FSYSTIME write SetSYSTIME;

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
    property NumeroSaidaView : String read FNumeroSaidaView write SetNumeroSaidaView;

    function Incluir: String;
    function Alterar(pID : String): TSaidasItensModel;
    function Excluir(pID : String): String;
    function Salvar : String;
    function carregaClasse(pID : String): TSaidasItensModel;
    function obterLista: IFDDataset;

    procedure getDadosProduto;
    function ObterTotais(pNumeroSaida : String) : IFDDataset;

  end;

implementation

uses
  SaidasItensDao,  
  System.Classes, 
  System.SysUtils, SaidasModel, ProdutosModel, Terasoft.Configuracoes,
  System.Rtti;

{ TSaidasItensModel }

function TSaidasItensModel.Alterar(pID: String): TSaidasItensModel;
var
  lSaidasItensModel : TSaidasItensModel;
begin
  lSaidasItensModel := TSaidasItensModel.Create(vIConexao);
  try
    lSaidasItensModel       := lSaidasItensModel.carregaClasse(pID);
    lSaidasItensModel.Acao  := tacAlterar;
    Result                  := lSaidasItensModel;
  finally
  end;
end;

function TSaidasItensModel.Excluir(pID: String): String;
var
  lSaidasModel : ITSaidasModel;
begin
  lSaidasModel := TSaidasModel.getNewIface(vIConexao);
  try
    self         := self.carregaClasse(pID);
    self.FAcao   := tacExcluir;
    Result       := self.Salvar;

    lSaidasModel.objeto.NUMERO_SAI := self.FNUMERO_SAI;
    lSaidasModel.objeto.CalcularTotais;
  finally
    lSaidasModel:=nil;
  end;
end;

procedure TSaidasItensModel.getDadosProduto;
var
  lProdutosModel : ITProdutosModel;
  lConfiguracoes : ITerasoftConfiguracoes;
  lBaseCusto     : String;
  lCtx           : TRttiContext;
  lProp          : TRttiProperty;
begin
  if self.FCODIGO_PRO = '' then
    Exit;

  lProdutosModel := TProdutosModel.getNewIface(vIConexao);
  lCtx           := TRttiContext.Create;
  try
    lProdutosModel.objeto.IDRecordView := self.FCODIGO_PRO;
    lProdutosModel.objeto.obterLista;
    lProdutosModel := lProdutosModel.objeto.ProdutossLista.First;

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    lBaseCusto := lConfiguracoes.objeto.valorTag('BASE_CUSTO_PADRAO', 'CUSTOMEDIO_PRO', tvString);

    lProp := lCtx.GetType(TProdutosModel).GetProperty(lBaseCusto);

    self.FICMS_SAI      := lProp.GetValue(lProdutosModel.objeto).AsString;
    self.FVALOR_UNI_SAI := lProp.GetValue(lProdutosModel.objeto).AsString;

  finally
    lProdutosModel:=nil;
  end;
end;

function TSaidasItensModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TSaidasItensModel.carregaClasse(pID : String): TSaidasItensModel;
var
  lSaidasItensDao: TSaidasItensDao;
begin
  lSaidasItensDao := TSaidasItensDao.Create(vIConexao);

  try
    Result := lSaidasItensDao.carregaClasse(pID);
  finally
    lSaidasItensDao.Free;
  end;
end;

constructor TSaidasItensModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TSaidasItensModel.Destroy;
begin
  inherited;
end;

function TSaidasItensModel.obterLista: IFDDataset;
var
  lSaidasItensLista: TSaidasItensDao;
begin
  lSaidasItensLista := TSaidasItensDao.Create(vIConexao);

  try
    lSaidasItensLista.TotalRecords    := FTotalRecords;
    lSaidasItensLista.WhereView       := FWhereView;
    lSaidasItensLista.CountView       := FCountView;
    lSaidasItensLista.OrderView       := FOrderView;
    lSaidasItensLista.StartRecordView := FStartRecordView;
    lSaidasItensLista.LengthPageView  := FLengthPageView;
    lSaidasItensLista.IDRecordView    := FIDRecordView;
    lSaidasItensLista.NumeroSaidaView := FNumeroSaidaView;

    Result := lSaidasItensLista.obterLista;

    FTotalRecords := lSaidasItensLista.TotalRecords;

  finally
    lSaidasItensLista.Free;
  end;
end;

function TSaidasItensModel.ObterTotais(pNumeroSaida : String): IFDDataset;
var
  lSaidasItens: TSaidasItensDao;
begin
  lSaidasItens := TSaidasItensDao.Create(vIConexao);
  try
    Result := lSaidasItens.ObterTotais(pNumeroSaida);

    FTotalRecords := lSaidasItens.TotalRecords;
  finally
    lSaidasItens.Free;
  end;
end;

function TSaidasItensModel.Salvar: String;
var
  lSaidasItensDao: TSaidasItensDao;
begin
  lSaidasItensDao := TSaidasItensDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lSaidasItensDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lSaidasItensDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lSaidasItensDao.excluir(Self);
    end;
  finally
    lSaidasItensDao.Free;
  end;
end;

procedure TSaidasItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TSaidasItensModel.SetALTURA_M(const Value: Variant);
begin
  FALTURA_M := Value;
end;

procedure TSaidasItensModel.SetAVULSO(const Value: Variant);
begin
  FAVULSO := Value;
end;

procedure TSaidasItensModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TSaidasItensModel.SetCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
  getDadosProduto;
end;

procedure TSaidasItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSaidasItensModel.SetDATA_CAD(const Value: Variant);
begin
  FDATA_CAD := Value;
end;

procedure TSaidasItensModel.SetDESCONTO_PED(const Value: Variant);
begin
  FDESCONTO_PED := Value;
end;

procedure TSaidasItensModel.SetICMS_SAI(const Value: Variant);
begin
  FICMS_SAI := Value;
end;

procedure TSaidasItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSaidasItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TSaidasItensModel.SetIPI_SAI(const Value: Variant);
begin
  FIPI_SAI := Value;
end;

procedure TSaidasItensModel.SetLARGURA_M(const Value: Variant);
begin
  FLARGURA_M := Value;
end;

procedure TSaidasItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSaidasItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TSaidasItensModel.SetNumeroSaidaView(const Value: String);
begin
  FNumeroSaidaView := Value;
end;

procedure TSaidasItensModel.SetNUMERO_SAI(const Value: Variant);
begin
  FNUMERO_SAI := Value;
end;

procedure TSaidasItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TSaidasItensModel.SetPRODUCAO_ID(const Value: Variant);
begin
  FPRODUCAO_ID := Value;
end;

procedure TSaidasItensModel.SetPROFUNDIDADE_M(const Value: Variant);
begin
  FPROFUNDIDADE_M := Value;
end;

procedure TSaidasItensModel.SetQTD_CHECAGEM(const Value: Variant);
begin
  FQTD_CHECAGEM := Value;
end;

procedure TSaidasItensModel.SetQUANTIDADE_ATE(const Value: Variant);
begin
  FQUANTIDADE_ATE := Value;
end;

procedure TSaidasItensModel.SetQUANTIDADE_SAI(const Value: Variant);
begin
  FQUANTIDADE_SAI := Value;
end;

procedure TSaidasItensModel.SetREPOSICAO_ID(const Value: Variant);
begin
  FREPOSICAO_ID := Value;
end;

procedure TSaidasItensModel.SetRESERVA_ID(const Value: Variant);
begin
  FRESERVA_ID := Value;
end;

procedure TSaidasItensModel.SetSAIDA_ID(const Value: Variant);
begin
  FSAIDA_ID := Value;
end;

procedure TSaidasItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TSaidasItensModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TSaidasItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TSaidasItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TSaidasItensModel.SetVALOR_UNI_SAI(const Value: Variant);
begin
  FVALOR_UNI_SAI := Value;
end;

procedure TSaidasItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
