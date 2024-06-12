unit OrcamentoItensModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TOrcamentoItensModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVFCPUFDEST: Variant;
    FBASE_ST: Variant;
    FQTD_CHECAGEM: Variant;
    FVALOR_ICMS: Variant;
    FVICMSUFREMET: Variant;
    FVBCUFDEST: Variant;
    FOBS: Variant;
    FOBSERVACAO: Variant;
    FVALORUNITARIO_ORC: Variant;
    FCOMBO_ITEM: Variant;
    FALTURA_M: Variant;
    FNUMERO_ORC: Variant;
    FPICMSINTER: Variant;
    FVALOR_VENDA_CADASTRO: Variant;
    FPERCENTUAL_ST: Variant;
    FVBCFCPST: Variant;
    FLARGURA_M: Variant;
    FVLRCUSTO_ORC: Variant;
    FQUANTIDADE_ORC: Variant;
    FVALOR_ST: Variant;
    FID: Variant;
    FREDUTOR_ST: Variant;
    FCODBARRAS_ORC: Variant;
    FVLRGARANTIA_ORC: Variant;
    FPERCENTUAL_IPI: Variant;
    FLOJA: Variant;
    FCFOP_ID: Variant;
    FBASE_ICMS: Variant;
    FCODIGO_PRO: Variant;
    FPCRED_PRESUMIDO: Variant;
    FMVA_ST: Variant;
    FSYSTIME: Variant;
    FPEDIDOCOMPRA_ID: Variant;
    FVALOR_IPI: Variant;
    FQUANTIDADE_ATE_ORC: Variant;
    FNUMERO_SERIE_ITEM: Variant;
    FCST_ICMS: Variant;
    FPFCPST: Variant;
    FPICMSUFDEST: Variant;
    FDESCONTO_ORC: Variant;
    FPROFUNDIDADE_M: Variant;
    FVFCPST: Variant;
    FVICMSUFDEST: Variant;
    FPERCENTUAL_ICMS: Variant;
    FDESCRICAO_PRODUTO: Variant;
    FPEDIDOCOMPRAITENS_ID: Variant;
    FPFCPUFDEST: Variant;
    FPICMSINTERPART: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetFALTURA_M(const Value: Variant);
    procedure SetFBASE_ICMS(const Value: Variant);
    procedure SetFBASE_ST(const Value: Variant);
    procedure SetFCFOP_ID(const Value: Variant);
    procedure SetFCODBARRAS_ORC(const Value: Variant);
    procedure SetFCODIGO_PRO(const Value: Variant);
    procedure SetFCOMBO_ITEM(const Value: Variant);
    procedure SetFCST_ICMS(const Value: Variant);
    procedure SetFDESCONTO_ORC(const Value: Variant);
    procedure SetFDESCRICAO_PRODUTO(const Value: Variant);
    procedure SetFID(const Value: Variant);
    procedure SetFLARGURA_M(const Value: Variant);
    procedure SetFLOJA(const Value: Variant);
    procedure SetFMVA_ST(const Value: Variant);
    procedure SetFNUMERO_ORC(const Value: Variant);
    procedure SetFNUMERO_SERIE_ITEM(const Value: Variant);
    procedure SetFOBS(const Value: Variant);
    procedure SetFOBSERVACAO(const Value: Variant);
    procedure SetFPCRED_PRESUMIDO(const Value: Variant);
    procedure SetFPEDIDOCOMPRA_ID(const Value: Variant);
    procedure SetFPEDIDOCOMPRAITENS_ID(const Value: Variant);
    procedure SetFPERCENTUAL_ICMS(const Value: Variant);
    procedure SetFPERCENTUAL_IPI(const Value: Variant);
    procedure SetFPERCENTUAL_ST(const Value: Variant);
    procedure SetFPFCPST(const Value: Variant);
    procedure SetFPFCPUFDEST(const Value: Variant);
    procedure SetFPICMSINTER(const Value: Variant);
    procedure SetFPICMSINTERPART(const Value: Variant);
    procedure SetFPICMSUFDEST(const Value: Variant);
    procedure SetFPROFUNDIDADE_M(const Value: Variant);
    procedure SetFQTD_CHECAGEM(const Value: Variant);
    procedure SetFQUANTIDADE_ATE_ORC(const Value: Variant);
    procedure SetFQUANTIDADE_ORC(const Value: Variant);
    procedure SetFREDUTOR_ST(const Value: Variant);
    procedure SetFSYSTIME(const Value: Variant);
    procedure SetFVALOR_ICMS(const Value: Variant);
    procedure SetFVALOR_IPI(const Value: Variant);
    procedure SetFVALOR_ST(const Value: Variant);
    procedure SetFVALOR_VENDA_CADASTRO(const Value: Variant);
    procedure SetFVALORUNITARIO_ORC(const Value: Variant);
    procedure SetFVBCFCPST(const Value: Variant);
    procedure SetFVBCUFDEST(const Value: Variant);
    procedure SetFVFCPST(const Value: Variant);
    procedure SetFVFCPUFDEST(const Value: Variant);
    procedure SetFVICMSUFDEST(const Value: Variant);
    procedure SetFVICMSUFREMET(const Value: Variant);
    procedure SetFVLRCUSTO_ORC(const Value: Variant);
    procedure SetFVLRGARANTIA_ORC(const Value: Variant);

  public

    property  NUMERO_ORC            : Variant read FNUMERO_ORC            write SetFNUMERO_ORC;
    property  CODIGO_PRO            : Variant read FCODIGO_PRO            write SetFCODIGO_PRO;
    property  VALORUNITARIO_ORC     : Variant read FVALORUNITARIO_ORC     write SetFVALORUNITARIO_ORC;
    property  QUANTIDADE_ORC        : Variant read FQUANTIDADE_ORC        write SetFQUANTIDADE_ORC;
    property  LOJA                  : Variant read FLOJA                  write SetFLOJA;
    property  OBSERVACAO            : Variant read FOBSERVACAO            write SetFOBSERVACAO;
    property  OBS                   : Variant read FOBS                   write SetFOBS;
    property  ID                    : Variant read FID                    write SetFID;
    property  QUANTIDADE_ATE_ORC    : Variant read FQUANTIDADE_ATE_ORC    write SetFQUANTIDADE_ATE_ORC;
    property  NUMERO_SERIE_ITEM     : Variant read FNUMERO_SERIE_ITEM     write SetFNUMERO_SERIE_ITEM;
    property  VLRGARANTIA_ORC       : Variant read FVLRGARANTIA_ORC       write SetFVLRGARANTIA_ORC;
    property  CODBARRAS_ORC         : Variant read FCODBARRAS_ORC         write SetFCODBARRAS_ORC;
    property  PERCENTUAL_IPI        : Variant read FPERCENTUAL_IPI        write SetFPERCENTUAL_IPI;
    property  VALOR_IPI             : Variant read FVALOR_IPI             write SetFVALOR_IPI;
    property  MVA_ST                : Variant read FMVA_ST                write SetFMVA_ST;
    property  BASE_ST               : Variant read FBASE_ST               write SetFBASE_ST;
    property  REDUTOR_ST            : Variant read FREDUTOR_ST            write SetFREDUTOR_ST;
    property  PERCENTUAL_ST         : Variant read FPERCENTUAL_ST         write SetFPERCENTUAL_ST;
    property  VALOR_ST              : Variant read FVALOR_ST              write SetFVALOR_ST;
    property  BASE_ICMS             : Variant read FBASE_ICMS             write SetFBASE_ICMS;
    property  PERCENTUAL_ICMS       : Variant read FPERCENTUAL_ICMS       write SetFPERCENTUAL_ICMS;
    property  CST_ICMS              : Variant read FCST_ICMS              write SetFCST_ICMS;
    property  VALOR_ICMS            : Variant read FVALOR_ICMS            write SetFVALOR_ICMS;
    property  DESCONTO_ORC          : Variant read FDESCONTO_ORC          write SetFDESCONTO_ORC;
    property  VLRCUSTO_ORC          : Variant read FVLRCUSTO_ORC          write SetFVLRCUSTO_ORC;
    property  ALTURA_M              : Variant read FALTURA_M              write SetFALTURA_M;
    property  LARGURA_M             : Variant read FLARGURA_M             write SetFLARGURA_M;
    property  PROFUNDIDADE_M        : Variant read FPROFUNDIDADE_M        write SetFPROFUNDIDADE_M;
    property  VBCUFDEST             : Variant read FVBCUFDEST             write SetFVBCUFDEST;
    property  PFCPUFDEST            : Variant read FPFCPUFDEST            write SetFPFCPUFDEST;
    property  PICMSUFDEST           : Variant read FPICMSUFDEST           write SetFPICMSUFDEST;
    property  PICMSINTER            : Variant read FPICMSINTER            write SetFPICMSINTER;
    property  PICMSINTERPART        : Variant read FPICMSINTERPART        write SetFPICMSINTERPART;
    property  VFCPUFDEST            : Variant read FVFCPUFDEST            write SetFVFCPUFDEST;
    property  VICMSUFDEST           : Variant read FVICMSUFDEST           write SetFVICMSUFDEST;
    property  VICMSUFREMET          : Variant read FVICMSUFREMET          write SetFVICMSUFREMET;
    property  CFOP_ID               : Variant read FCFOP_ID               write SetFCFOP_ID;
    property  SYSTIME               : Variant read FSYSTIME               write SetFSYSTIME;
    property  PEDIDOCOMPRA_ID       : Variant read FPEDIDOCOMPRA_ID       write SetFPEDIDOCOMPRA_ID;
    property  PEDIDOCOMPRAITENS_ID  : Variant read FPEDIDOCOMPRAITENS_ID  write SetFPEDIDOCOMPRAITENS_ID;
    property  VBCFCPST              : Variant read FVBCFCPST              write SetFVBCFCPST;
    property  PFCPST                : Variant read FPFCPST                write SetFPFCPST;
    property  VFCPST                : Variant read FVFCPST                write SetFVFCPST;
    property  VALOR_VENDA_CADASTRO  : Variant read FVALOR_VENDA_CADASTRO  write SetFVALOR_VENDA_CADASTRO;
    property  DESCRICAO_PRODUTO     : Variant read FDESCRICAO_PRODUTO     write SetFDESCRICAO_PRODUTO;
    property  PCRED_PRESUMIDO       : Variant read FPCRED_PRESUMIDO       write SetFPCRED_PRESUMIDO;
    property  COMBO_ITEM            : Variant read FCOMBO_ITEM            write SetFCOMBO_ITEM;
    property  QTD_CHECAGEM          : Variant read FQTD_CHECAGEM          write SetFQTD_CHECAGEM;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TOrcamentoItensModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TOrcamentoItensModel;

    function ObterLista: TFDMemTable; overload;

    procedure quantidadeAtendida(pNumeroOrc: String);

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordview : String read FIDRecordview write SetIDRecordview;

  end;

implementation

uses
  OrcamentoItensDao,
  System.Classes,
  System.SysUtils;

{ TOrcamentoItensModel }

function TOrcamentoItensModel.Alterar(pID: String): TOrcamentoItensModel;
var
  lOrcamentoItensModel : TOrcamentoItensModel;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.Create(vIConexao);
  try
    lOrcamentoItensModel       := lOrcamentoItensModel.carregaClasse(pID);
    lOrcamentoItensModel.Acao  := tacAlterar;
    Result            := lOrcamentoItensModel;
  finally
  end;
end;

function TOrcamentoItensModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TOrcamentoItensModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TOrcamentoItensModel.carregaClasse(pId : String): TOrcamentoItensModel;
var
  lOrcamentoItensDao: TOrcamentoItensDao;
begin
  lOrcamentoItensDao := TOrcamentoItensDao.Create(vIConexao);

  try
    Result := lOrcamentoItensDao.carregaClasse(pId);
  finally
    lOrcamentoItensDao.Free;
  end;
end;

constructor TOrcamentoItensModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TOrcamentoItensModel.Destroy;
begin
  inherited;
end;

function TOrcamentoItensModel.obterLista: TFDMemTable;
var
  lOrcamentoItensLista: TOrcamentoItensDao;
begin
  lOrcamentoItensLista := TOrcamentoItensDao.Create(vIConexao);

  try
    lOrcamentoItensLista.TotalRecords    := FTotalRecords;
    lOrcamentoItensLista.WhereView       := FWhereView;
    lOrcamentoItensLista.CountView       := FCountView;
    lOrcamentoItensLista.OrderView       := FOrderView;
    lOrcamentoItensLista.StartRecordView := FStartRecordView;
    lOrcamentoItensLista.LengthPageView  := FLengthPageView;
    lOrcamentoItensLista.IDRecordView    := FIDRecordView;

    Result := lOrcamentoItensLista.obterLista;

    FTotalRecords := lOrcamentoItensLista.TotalRecords;

  finally
    lOrcamentoItensLista.Free;
  end;
end;

procedure TOrcamentoItensModel.quantidadeAtendida(pNumeroOrc: String);
var
  lOrcamentoItensLista: TOrcamentoItensDao;
begin
  lOrcamentoItensLista := TOrcamentoItensDao.Create(vIConexao);
  try
    lOrcamentoItensLista.quantidadeAtendida(pNumeroOrc);
  finally
    lOrcamentoItensLista.Free;
  end;
end;

function TOrcamentoItensModel.Salvar: String;
var
  lOrcamentoItensDao: TOrcamentoItensDao;
begin
  lOrcamentoItensDao := TOrcamentoItensDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lOrcamentoItensDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lOrcamentoItensDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lOrcamentoItensDao.excluir(Self);
    end;
  finally
    lOrcamentoItensDao.Free;
  end;
end;

procedure TOrcamentoItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TOrcamentoItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TOrcamentoItensModel.SetFALTURA_M(const Value: Variant);
begin
  FALTURA_M := Value;
end;

procedure TOrcamentoItensModel.SetFBASE_ICMS(const Value: Variant);
begin
  FBASE_ICMS := Value;
end;

procedure TOrcamentoItensModel.SetFBASE_ST(const Value: Variant);
begin
  FBASE_ST := Value;
end;

procedure TOrcamentoItensModel.SetFCFOP_ID(const Value: Variant);
begin
  FCFOP_ID := Value;
end;

procedure TOrcamentoItensModel.SetFCODBARRAS_ORC(const Value: Variant);
begin
  FCODBARRAS_ORC := Value;
end;

procedure TOrcamentoItensModel.SetFCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
end;

procedure TOrcamentoItensModel.SetFCOMBO_ITEM(const Value: Variant);
begin
  FCOMBO_ITEM := Value;
end;

procedure TOrcamentoItensModel.SetFCST_ICMS(const Value: Variant);
begin
  FCST_ICMS := Value;
end;

procedure TOrcamentoItensModel.SetFDESCONTO_ORC(const Value: Variant);
begin
  FDESCONTO_ORC := Value;
end;

procedure TOrcamentoItensModel.SetFDESCRICAO_PRODUTO(const Value: Variant);
begin
  FDESCRICAO_PRODUTO := Value;
end;

procedure TOrcamentoItensModel.SetFID(const Value: Variant);
begin
  FID := Value;
end;

procedure TOrcamentoItensModel.SetFLARGURA_M(const Value: Variant);
begin
  FLARGURA_M := Value;
end;

procedure TOrcamentoItensModel.SetFLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TOrcamentoItensModel.SetFMVA_ST(const Value: Variant);
begin
  FMVA_ST := Value;
end;

procedure TOrcamentoItensModel.SetFNUMERO_ORC(const Value: Variant);
begin
  FNUMERO_ORC := Value;
end;

procedure TOrcamentoItensModel.SetFNUMERO_SERIE_ITEM(const Value: Variant);
begin
  FNUMERO_SERIE_ITEM := Value;
end;

procedure TOrcamentoItensModel.SetFOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TOrcamentoItensModel.SetFOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TOrcamentoItensModel.SetFPCRED_PRESUMIDO(const Value: Variant);
begin
  FPCRED_PRESUMIDO := Value;
end;

procedure TOrcamentoItensModel.SetFPEDIDOCOMPRAITENS_ID(const Value: Variant);
begin
  FPEDIDOCOMPRAITENS_ID := Value;
end;

procedure TOrcamentoItensModel.SetFPEDIDOCOMPRA_ID(const Value: Variant);
begin
  FPEDIDOCOMPRA_ID := Value;
end;

procedure TOrcamentoItensModel.SetFPERCENTUAL_ICMS(const Value: Variant);
begin
  FPERCENTUAL_ICMS := Value;
end;

procedure TOrcamentoItensModel.SetFPERCENTUAL_IPI(const Value: Variant);
begin
  FPERCENTUAL_IPI := Value;
end;

procedure TOrcamentoItensModel.SetFPERCENTUAL_ST(const Value: Variant);
begin
  FPERCENTUAL_ST := Value;
end;

procedure TOrcamentoItensModel.SetFPFCPST(const Value: Variant);
begin
  FPFCPST := Value;
end;

procedure TOrcamentoItensModel.SetFPFCPUFDEST(const Value: Variant);
begin
  FPFCPUFDEST := Value;
end;

procedure TOrcamentoItensModel.SetFPICMSINTER(const Value: Variant);
begin
  FPICMSINTER := Value;
end;

procedure TOrcamentoItensModel.SetFPICMSINTERPART(const Value: Variant);
begin
  FPICMSINTERPART := Value;
end;

procedure TOrcamentoItensModel.SetFPICMSUFDEST(const Value: Variant);
begin
  FPICMSUFDEST := Value;
end;

procedure TOrcamentoItensModel.SetFPROFUNDIDADE_M(const Value: Variant);
begin
  FPROFUNDIDADE_M := Value;
end;

procedure TOrcamentoItensModel.SetFQTD_CHECAGEM(const Value: Variant);
begin
  FQTD_CHECAGEM := Value;
end;

procedure TOrcamentoItensModel.SetFQUANTIDADE_ATE_ORC(const Value: Variant);
begin
  FQUANTIDADE_ATE_ORC := Value;
end;

procedure TOrcamentoItensModel.SetFQUANTIDADE_ORC(const Value: Variant);
begin
  FQUANTIDADE_ORC := Value;
end;

procedure TOrcamentoItensModel.SetFREDUTOR_ST(const Value: Variant);
begin
  FREDUTOR_ST := Value;
end;

procedure TOrcamentoItensModel.SetFSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TOrcamentoItensModel.SetFVALORUNITARIO_ORC(const Value: Variant);
begin
  FVALORUNITARIO_ORC := Value;
end;

procedure TOrcamentoItensModel.SetFVALOR_ICMS(const Value: Variant);
begin
  FVALOR_ICMS := Value;
end;

procedure TOrcamentoItensModel.SetFVALOR_IPI(const Value: Variant);
begin
  FVALOR_IPI := Value;
end;

procedure TOrcamentoItensModel.SetFVALOR_ST(const Value: Variant);
begin
  FVALOR_ST := Value;
end;

procedure TOrcamentoItensModel.SetFVALOR_VENDA_CADASTRO(const Value: Variant);
begin
  FVALOR_VENDA_CADASTRO := Value;
end;

procedure TOrcamentoItensModel.SetFVBCFCPST(const Value: Variant);
begin
  FVBCFCPST := Value;
end;

procedure TOrcamentoItensModel.SetFVBCUFDEST(const Value: Variant);
begin
  FVBCUFDEST := Value;
end;

procedure TOrcamentoItensModel.SetFVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TOrcamentoItensModel.SetFVFCPUFDEST(const Value: Variant);
begin
  FVFCPUFDEST := Value;
end;

procedure TOrcamentoItensModel.SetFVICMSUFDEST(const Value: Variant);
begin
  FVICMSUFDEST := Value;
end;

procedure TOrcamentoItensModel.SetFVICMSUFREMET(const Value: Variant);
begin
  FVICMSUFREMET := Value;
end;

procedure TOrcamentoItensModel.SetFVLRCUSTO_ORC(const Value: Variant);
begin
  FVLRCUSTO_ORC := Value;
end;

procedure TOrcamentoItensModel.SetFVLRGARANTIA_ORC(const Value: Variant);
begin
  FVLRGARANTIA_ORC := Value;
end;

procedure TOrcamentoItensModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TOrcamentoItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TOrcamentoItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TOrcamentoItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TOrcamentoItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TOrcamentoItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
