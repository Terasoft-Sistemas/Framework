unit ContasPagarItensModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao, 
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TContasPagarItensModel = class;
  ITContasPagarItensModel=IObject<TContasPagarItensModel>;

  TContasPagarItensModel = class
  private
    [weak] mySelf: ITContasPagarItensModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FBOLETO_PAG: Variant;
    FDESCONTO: Variant;
    FOBS: Variant;
    FTOTALPARCELAS: Variant;
    FCODIGO_FOR: Variant;
    FPORTADOR_ID: Variant;
    FVALORPARCELA_PAG: Variant;
    FREMESSA_GESTAO_PAGAMENTO: Variant;
    FLIMITE_ATRAZO: Variant;
    FPACELA_PAG: Variant;
    FDOCUMENTO: Variant;
    FVALORPARCELA_BASE: Variant;
    FDATABAIXA_PAG: Variant;
    FID: Variant;
    FCTR_CHEQUE_ID: Variant;
    FDUPLIACATA_PAG: Variant;
    FLOJA: Variant;
    FBARRAS_BOLETO: Variant;
    FSYSTIME: Variant;
    FVENC_PAG: Variant;
    FSITUACAO_PAG: Variant;
    FVALORPAGO_PAG: Variant;
    FUSUARIO_ACEITE: Variant;
    FDATA_ACEITE: Variant;
    FDuplicataView: String;
    FFornecedorView: String;


    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetBARRAS_BOLETO(const Value: Variant);
    procedure SetBOLETO_PAG(const Value: Variant);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCTR_CHEQUE_ID(const Value: Variant);
    procedure SetDATA_ACEITE(const Value: Variant);
    procedure SetDATABAIXA_PAG(const Value: Variant);
    procedure SetDESCONTO(const Value: Variant);
    procedure SetDOCUMENTO(const Value: Variant);
    procedure SetDUPLIACATA_PAG(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLIMITE_ATRAZO(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetOBS(const Value: Variant);
    procedure SetPACELA_PAG(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetREMESSA_GESTAO_PAGAMENTO(const Value: Variant);
    procedure SetSITUACAO_PAG(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTOTALPARCELAS(const Value: Variant);
    procedure SetUSUARIO_ACEITE(const Value: Variant);
    procedure SetVALORPAGO_PAG(const Value: Variant);
    procedure SetVALORPARCELA_BASE(const Value: Variant);
    procedure SetVALORPARCELA_PAG(const Value: Variant);
    procedure SetVENC_PAG(const Value: Variant);
    procedure SetDuplicataView(const Value: String);
    procedure SetFornecedorView(const Value: String);

  public

    property ID                      : Variant  read FID write SetID;
    property DUPLIACATA_PAG          : Variant  read FDUPLIACATA_PAG write SetDUPLIACATA_PAG;
    property CODIGO_FOR              : Variant  read FCODIGO_FOR write SetCODIGO_FOR;
    property VENC_PAG                : Variant  read FVENC_PAG write SetVENC_PAG;
    property PACELA_PAG              : Variant  read FPACELA_PAG write SetPACELA_PAG;
    property TOTALPARCELAS           : Variant  read FTOTALPARCELAS write SetTOTALPARCELAS;
    property VALORPARCELA_PAG        : Variant  read FVALORPARCELA_PAG write SetVALORPARCELA_PAG;
    property VALORPAGO_PAG           : Variant  read FVALORPAGO_PAG write SetVALORPAGO_PAG;
    property DATABAIXA_PAG           : Variant  read FDATABAIXA_PAG write SetDATABAIXA_PAG;
    property SITUACAO_PAG            : Variant  read FSITUACAO_PAG write SetSITUACAO_PAG;
    property BOLETO_PAG              : Variant  read FBOLETO_PAG write SetBOLETO_PAG;
    property DATA_ACEITE             : Variant  read FDATA_ACEITE write SetDATA_ACEITE;
    property USUARIO_ACEITE          : Variant  read FUSUARIO_ACEITE write SetUSUARIO_ACEITE;
    property LOJA                    : Variant  read FLOJA write SetLOJA;
    property PORTADOR_ID             : Variant  read FPORTADOR_ID write SetPORTADOR_ID;
    property OBS                     : Variant  read FOBS write SetOBS;
    property SYSTIME                 : Variant  read FSYSTIME write SetSYSTIME;
    property CTR_CHEQUE_ID           : Variant  read FCTR_CHEQUE_ID write SetCTR_CHEQUE_ID;
    property LIMITE_ATRAZO           : Variant  read FLIMITE_ATRAZO write SetLIMITE_ATRAZO;
    property DESCONTO                : Variant  read FDESCONTO write SetDESCONTO;
    property VALORPARCELA_BASE       : Variant  read FVALORPARCELA_BASE write SetVALORPARCELA_BASE;
    property BARRAS_BOLETO           : Variant  read FBARRAS_BOLETO write SetBARRAS_BOLETO;
    property REMESSA_GESTAO_PAGAMENTO: Variant  read FREMESSA_GESTAO_PAGAMENTO write SetREMESSA_GESTAO_PAGAMENTO;
    property DOCUMENTO               : Variant  read FDOCUMENTO write SetDOCUMENTO;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITContasPagarItensModel;

    function Incluir: String;
    function Alterar(pID, pIDItem : String): ITContasPagarItensModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId, pIDItem: String): ITContasPagarItensModel;
    function obterLista: IFDDataset;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property DuplicataView: String read FDuplicataView write SetDuplicataView;
    property FornecedorView: String read FFornecedorView write SetFornecedorView;

  end;

implementation

uses
  ContasPagarItensDao;

{ TContasPagarItensModel }

function TContasPagarItensModel.Alterar(pID, pIDItem: String): ITContasPagarItensModel;
var
  lContasPagarItensModel : ITContasPagarItensModel;
begin
  lContasPagarItensModel := TContasPagarItensModel.getNewIface(vIConexao);
  try
    lContasPagarItensModel       := lContasPagarItensModel.objeto.carregaClasse(pID, pIDItem);
    lContasPagarItensModel.objeto.Acao  := tacAlterar;
    Result              		     := lContasPagarItensModel;
  finally
  end;
end;

function TContasPagarItensModel.Excluir(pID: String): String;
begin
  self.FID   := pID;
  self.FAcao := tacExcluir;
  Result     := self.Salvar;
end;

class function TContasPagarItensModel.getNewIface(pIConexao: IConexao): ITContasPagarItensModel;
begin
  Result := TImplObjetoOwner<TContasPagarItensModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TContasPagarItensModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    self.Salvar;
end;

function TContasPagarItensModel.carregaClasse(pId, pIDItem: String): ITContasPagarItensModel;
var
  lContasPagarItensDao: ITContasPagarItensDao;
begin
  lContasPagarItensDao := TContasPagarItensDao.getNewIface(vIConexao);

  try
    Result := lContasPagarItensDao.objeto.carregaClasse(pId, pIDItem);
  finally
    lContasPagarItensDao:=nil;
  end;
end;

constructor TContasPagarItensModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContasPagarItensModel.Destroy;
begin

  inherited;
end;

function TContasPagarItensModel.obterLista: IFDDataset;
var
  lContasPagarDao: ITContasPagarItensDao;
begin
  lContasPagarDao := TContasPagarItensDao.getNewIface(vIConexao);

  try
    lContasPagarDao.objeto.TotalRecords    := self.FTotalRecords;
    lContasPagarDao.objeto.WhereView       := self.FWhereView;
    lContasPagarDao.objeto.CountView       := self.FCountView;
    lContasPagarDao.objeto.OrderView       := self.FOrderView;
    lContasPagarDao.objeto.StartRecordView := self.FStartRecordView;
    lContasPagarDao.objeto.LengthPageView  := self.FLengthPageView;
    lContasPagarDao.objeto.IDRecordView    := self.FIDRecordView;
    lContasPagarDao.objeto.DuplicataView   := self.DuplicataView;
    lContasPagarDao.objeto.FornecedorView  := self.FornecedorView;

    Result := lContasPagarDao.objeto.obterLista;

    FTotalRecords := lContasPagarDao.objeto.TotalRecords;

  finally
    lContasPagarDao:=nil;
  end;
end;

function TContasPagarItensModel.Salvar: String;
var
  lContasPagarItensDao: ITContasPagarItensDao;
begin
  lContasPagarItensDao := TContasPagarItensDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lContasPagarItensDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lContasPagarItensDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lContasPagarItensDao.objeto.excluir(mySelf);
    end;

  finally
    lContasPagarItensDao:=nil;
  end;
end;

procedure TContasPagarItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TContasPagarItensModel.SetBARRAS_BOLETO(const Value: Variant);
begin
  FBARRAS_BOLETO := Value;
end;

procedure TContasPagarItensModel.SetBOLETO_PAG(const Value: Variant);
begin
  FBOLETO_PAG := Value;
end;

procedure TContasPagarItensModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;

procedure TContasPagarItensModel.SetCountView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TContasPagarItensModel.SetCTR_CHEQUE_ID(const Value: Variant);
begin
  FCTR_CHEQUE_ID := Value;
end;

procedure TContasPagarItensModel.SetDATABAIXA_PAG(const Value: Variant);
begin
  FDATABAIXA_PAG := Value;
end;

procedure TContasPagarItensModel.SetDATA_ACEITE(const Value: Variant);
begin
  FDATA_ACEITE := Value;
end;

procedure TContasPagarItensModel.SetDESCONTO(const Value: Variant);
begin
  FDESCONTO := Value;
end;

procedure TContasPagarItensModel.SetDOCUMENTO(const Value: Variant);
begin
  FDOCUMENTO := Value;
end;

procedure TContasPagarItensModel.SetDUPLIACATA_PAG(const Value: Variant);
begin
  FDUPLIACATA_PAG := Value;
end;

procedure TContasPagarItensModel.SetDuplicataView(const Value: String);
begin
  FDuplicataView := Value;
end;

procedure TContasPagarItensModel.SetFornecedorView(const Value: String);
begin
  FFornecedorView := Value;
end;

procedure TContasPagarItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasPagarItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasPagarItensModel.SetLengthPageView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TContasPagarItensModel.SetLIMITE_ATRAZO(const Value: Variant);
begin
  FLIMITE_ATRAZO := Value;
end;

procedure TContasPagarItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TContasPagarItensModel.SetOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TContasPagarItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasPagarItensModel.SetPACELA_PAG(const Value: Variant);
begin
  FPACELA_PAG := Value;
end;

procedure TContasPagarItensModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TContasPagarItensModel.SetREMESSA_GESTAO_PAGAMENTO(
  const Value: Variant);
begin
  FREMESSA_GESTAO_PAGAMENTO := Value;
end;

procedure TContasPagarItensModel.SetSITUACAO_PAG(const Value: Variant);
begin
  FSITUACAO_PAG := Value;
end;

procedure TContasPagarItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasPagarItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TContasPagarItensModel.SetTOTALPARCELAS(const Value: Variant);
begin
  FTOTALPARCELAS := Value;
end;

procedure TContasPagarItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasPagarItensModel.SetUSUARIO_ACEITE(const Value: Variant);
begin
  FUSUARIO_ACEITE := Value;
end;

procedure TContasPagarItensModel.SetVALORPAGO_PAG(const Value: Variant);
begin
  FVALORPAGO_PAG := Value;
end;

procedure TContasPagarItensModel.SetVALORPARCELA_BASE(const Value: Variant);
begin
  FVALORPARCELA_BASE := Value;
end;

procedure TContasPagarItensModel.SetVALORPARCELA_PAG(const Value: Variant);
begin
  FVALORPARCELA_PAG := Value;
end;

procedure TContasPagarItensModel.SetVENC_PAG(const Value: Variant);
begin
  FVENC_PAG := Value;
end;

procedure TContasPagarItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
