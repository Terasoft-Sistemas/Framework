unit ChequeModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TChequeModel = class

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
    FDATAHORA: Variant;
    FDEVOLVIDO_CHQ: Variant;
    FBAIXA_CHQ: Variant;
    FVENCIMENTO_CHQ: Variant;
    FEMITENTE_CHQ: Variant;
    FNUMERO_CHQ: Variant;
    FEMISSAO_CHQ: Variant;
    FCONTA_CHQ: Variant;
    FCODIGO_CLI: Variant;
    FID: Variant;
    FNUMERO: Variant;
    FDESTINO_CHQ: Variant;
    FCMC7: Variant;
    FLOJA: Variant;
    FUSUARIO_CHQ: Variant;
    FAGENCIA_CHQ: Variant;
    FCNPJ_CPF_CHEQUE: Variant;
    FSYSTIME: Variant;
    FBANCO_CHQ: Variant;
    FHISTORICO_CHQ: Variant;
    FOBS_CHQ: Variant;
    FDEVOLVIDO2_CHQ: Variant;
    FTIPO: Variant;
    FVALOR_CHQ: Variant;
    FNUMERO_DOC: Variant;
    FFORMA_PAGAMENTO_ID: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetAGENCIA_CHQ(const Value: Variant);
    procedure SetBAIXA_CHQ(const Value: Variant);
    procedure SetBANCO_CHQ(const Value: Variant);
    procedure SetCMC7(const Value: Variant);
    procedure SetCNPJ_CPF_CHEQUE(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCONTA_CHQ(const Value: Variant);
    procedure SetDATAHORA(const Value: Variant);
    procedure SetDESTINO_CHQ(const Value: Variant);
    procedure SetDEVOLVIDO_CHQ(const Value: Variant);
    procedure SetDEVOLVIDO2_CHQ(const Value: Variant);
    procedure SetEMISSAO_CHQ(const Value: Variant);
    procedure SetEMITENTE_CHQ(const Value: Variant);
    procedure SetFORMA_PAGAMENTO_ID(const Value: Variant);
    procedure SetHISTORICO_CHQ(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetNUMERO(const Value: Variant);
    procedure SetNUMERO_CHQ(const Value: Variant);
    procedure SetNUMERO_DOC(const Value: Variant);
    procedure SetOBS_CHQ(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetUSUARIO_CHQ(const Value: Variant);
    procedure SetVALOR_CHQ(const Value: Variant);
    procedure SetVENCIMENTO_CHQ(const Value: Variant);

  public

    property NUMERO_CHQ : Variant read FNUMERO_CHQ write SetNUMERO_CHQ;
    property BANCO_CHQ : Variant read FBANCO_CHQ write SetBANCO_CHQ;
    property EMITENTE_CHQ : Variant read FEMITENTE_CHQ write SetEMITENTE_CHQ;
    property EMISSAO_CHQ : Variant read FEMISSAO_CHQ write SetEMISSAO_CHQ;
    property VALOR_CHQ : Variant read FVALOR_CHQ write SetVALOR_CHQ;
    property HISTORICO_CHQ : Variant read FHISTORICO_CHQ write SetHISTORICO_CHQ;
    property VENCIMENTO_CHQ : Variant read FVENCIMENTO_CHQ write SetVENCIMENTO_CHQ;
    property BAIXA_CHQ : Variant read FBAIXA_CHQ write SetBAIXA_CHQ;
    property DEVOLVIDO_CHQ : Variant read FDEVOLVIDO_CHQ write SetDEVOLVIDO_CHQ;
    property DEVOLVIDO2_CHQ : Variant read FDEVOLVIDO2_CHQ write SetDEVOLVIDO2_CHQ;
    property CODIGO_CLI : Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property DESTINO_CHQ : Variant read FDESTINO_CHQ write SetDESTINO_CHQ;
    property AGENCIA_CHQ : Variant read FAGENCIA_CHQ write SetAGENCIA_CHQ;
    property CONTA_CHQ : Variant read FCONTA_CHQ write SetCONTA_CHQ;
    property USUARIO_CHQ : Variant read FUSUARIO_CHQ write SetUSUARIO_CHQ;
    property OBS_CHQ : Variant read FOBS_CHQ write SetOBS_CHQ;
    property TIPO : Variant read FTIPO write SetTIPO;
    property NUMERO_DOC : Variant read FNUMERO_DOC write SetNUMERO_DOC;
    property NUMERO : Variant read FNUMERO write SetNUMERO;
    property LOJA : Variant read FLOJA write SetLOJA;
    property CNPJ_CPF_CHEQUE : Variant read FCNPJ_CPF_CHEQUE write SetCNPJ_CPF_CHEQUE;
    property ID : Variant read FID write SetID;
    property CMC7 : Variant read FCMC7 write SetCMC7;
    property FORMA_PAGAMENTO_ID : Variant read FFORMA_PAGAMENTO_ID write SetFORMA_PAGAMENTO_ID;
    property DATAHORA : Variant read FDATAHORA write SetDATAHORA;
    property SYSTIME : Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TChequeModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pID : String): TChequeModel;
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
  ChequeDao,
  System.Classes,
  System.SysUtils;

{ TChequeModel }

function TChequeModel.Alterar(pID: String): TChequeModel;
var
  lChequeModel : TChequeModel;
begin
  lChequeModel := TChequeModel.Create(vIConexao);
  try
    lChequeModel      := lChequeModel.carregaClasse(pID);
    lChequeModel.Acao := tacAlterar;
    Result            := lChequeModel;
  finally

  end;
end;

function TChequeModel.Excluir(pID: String): String;
begin
  self.ID    := pID;
  self.FAcao := tacExcluir;
  Result     := self.Salvar;
end;

function TChequeModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TChequeModel.carregaClasse(pId : String): TChequeModel;
var
  lChequeDao: TChequeDao;
begin
  lChequeDao := TChequeDao.Create(vIConexao);
  try
    Result := lChequeDao.carregaClasse(pID);
  finally
    lChequeDao.Free;
  end;
end;

constructor TChequeModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TChequeModel.Destroy;
begin
  inherited;
end;

function TChequeModel.obterLista: TFDMemTable;
var
  lCheque: TChequeDao;
begin
  lCheque := TChequeDao.Create(vIConexao);

  try
    lCheque.TotalRecords    := FTotalRecords;
    lCheque.WhereView       := FWhereView;
    lCheque.CountView       := FCountView;
    lCheque.OrderView       := FOrderView;
    lCheque.StartRecordView := FStartRecordView;
    lCheque.LengthPageView  := FLengthPageView;
    lCheque.IDRecordView    := FIDRecordView;

    Result := lCheque.obterLista;

    FTotalRecords := lCheque.TotalRecords;

  finally
    lCheque.Free;
  end;
end;

function TChequeModel.Salvar: String;
var
  lChequeDao: TChequeDao;
begin
  lChequeDao := TChequeDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lChequeDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lChequeDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lChequeDao.excluir(Self);
    end;
  finally
    lChequeDao.Free;
  end;
end;

procedure TChequeModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TChequeModel.SetAGENCIA_CHQ(const Value: Variant);
begin
  FAGENCIA_CHQ := Value;
end;

procedure TChequeModel.SetBAIXA_CHQ(const Value: Variant);
begin
  FBAIXA_CHQ := Value;
end;

procedure TChequeModel.SetBANCO_CHQ(const Value: Variant);
begin
  FBANCO_CHQ := Value;
end;

procedure TChequeModel.SetCMC7(const Value: Variant);
begin
  FCMC7 := Value;
end;

procedure TChequeModel.SetCNPJ_CPF_CHEQUE(const Value: Variant);
begin
  FCNPJ_CPF_CHEQUE := Value;
end;

procedure TChequeModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TChequeModel.SetCONTA_CHQ(const Value: Variant);
begin
  FCONTA_CHQ := Value;
end;

procedure TChequeModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TChequeModel.SetDATAHORA(const Value: Variant);
begin
  FDATAHORA := Value;
end;

procedure TChequeModel.SetDESTINO_CHQ(const Value: Variant);
begin
  FDESTINO_CHQ := Value;
end;

procedure TChequeModel.SetDEVOLVIDO2_CHQ(const Value: Variant);
begin
  FDEVOLVIDO2_CHQ := Value;
end;

procedure TChequeModel.SetDEVOLVIDO_CHQ(const Value: Variant);
begin
  FDEVOLVIDO_CHQ := Value;
end;

procedure TChequeModel.SetEMISSAO_CHQ(const Value: Variant);
begin
  FEMISSAO_CHQ := Value;
end;

procedure TChequeModel.SetEMITENTE_CHQ(const Value: Variant);
begin
  FEMITENTE_CHQ := Value;
end;

procedure TChequeModel.SetFORMA_PAGAMENTO_ID(const Value: Variant);
begin
  FFORMA_PAGAMENTO_ID := Value;
end;

procedure TChequeModel.SetHISTORICO_CHQ(const Value: Variant);
begin
  FHISTORICO_CHQ := Value;
end;

procedure TChequeModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TChequeModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TChequeModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TChequeModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TChequeModel.SetNUMERO(const Value: Variant);
begin
  FNUMERO := Value;
end;

procedure TChequeModel.SetNUMERO_CHQ(const Value: Variant);
begin
  FNUMERO_CHQ := Value;
end;

procedure TChequeModel.SetNUMERO_DOC(const Value: Variant);
begin
  FNUMERO_DOC := Value;
end;

procedure TChequeModel.SetOBS_CHQ(const Value: Variant);
begin
  FOBS_CHQ := Value;
end;

procedure TChequeModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TChequeModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TChequeModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TChequeModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TChequeModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TChequeModel.SetUSUARIO_CHQ(const Value: Variant);
begin
  FUSUARIO_CHQ := Value;
end;

procedure TChequeModel.SetVALOR_CHQ(const Value: Variant);
begin
  FVALOR_CHQ := Value;
end;

procedure TChequeModel.SetVENCIMENTO_CHQ(const Value: Variant);
begin
  FVENCIMENTO_CHQ := Value;
end;

procedure TChequeModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
