unit ContaCorrenteModel;

interface

uses
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  Interfaces.Conexao;

type
  TContaCorrenteModel = class;

  ITContaCorrenteModel = IObject<TContaCorrenteModel>;

  TContaCorrenteModel = class
  private
    [weak] mySelf: ITContaCorrenteModel;
    vIConexao : IConexao;
    FContaCorrentesLista: IList<ITContaCorrenteModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FOS_NEW_ID: Variant;
    FSUB_ID: Variant;
    FDATA_CON: Variant;
    FCLIENTE_COR: Variant;
    FCONCILIACAO_ID: Variant;
    FTROCO: Variant;
    FDR: Variant;
    FCENTRO_CUSTO: Variant;
    FFUNCIONARIO_ID: Variant;
    FNUMERO_CHQ: Variant;
    FNUMERO_COR: Variant;
    FFATURA_COR: Variant;
    FPEDIDO_ID: Variant;
    FPAGARME_LOTE: Variant;
    FIUGU_ID: Variant;
    FCODIGO_CTA: Variant;
    FID: Variant;
    FTRANSFERENCIA_ID: Variant;
    FEMPRESTIMO_RECEBER_ID: Variant;
    FUSUARIO_COR: Variant;
    FLOJA: Variant;
    FCONCILIADO_COR: Variant;
    FSTATUS: Variant;
    FCODIGO_BAN: Variant;
    FLOCACAO_ID: Variant;
    FSYSTIME: Variant;
    FDATA_COR: Variant;
    FLOJA_REMOTO: Variant;
    FPARCELA_COR: Variant;
    FPLACA: Variant;
    FPORTADOR_COR: Variant;
    FOBSERVACAO_COR: Variant;
    FCOMPETENCIA: Variant;
    FTIPO: Variant;
    FVALOR_COR: Variant;
    FHORA_COR: Variant;
    FTRANSFERENCIA_ORIGEM: Variant;
    FTIPO_CTA: Variant;
    FIDRecordView: String;
    FIDBancoView: String;
    FSaldo: Real;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetContaCorrentesLista(const Value: IList<ITContaCorrenteModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCENTRO_CUSTO(const Value: Variant);
    procedure SetCLIENTE_COR(const Value: Variant);
    procedure SetCODIGO_BAN(const Value: Variant);
    procedure SetCODIGO_CTA(const Value: Variant);
    procedure SetCOMPETENCIA(const Value: Variant);
    procedure SetCONCILIACAO_ID(const Value: Variant);
    procedure SetCONCILIADO_COR(const Value: Variant);
    procedure SetDATA_CON(const Value: Variant);
    procedure SetDATA_COR(const Value: Variant);
    procedure SetDR(const Value: Variant);
    procedure SetEMPRESTIMO_RECEBER_ID(const Value: Variant);
    procedure SetFATURA_COR(const Value: Variant);
    procedure SetFUNCIONARIO_ID(const Value: Variant);
    procedure SetHORA_COR(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIUGU_ID(const Value: Variant);
    procedure SetLOCACAO_ID(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLOJA_REMOTO(const Value: Variant);
    procedure SetNUMERO_CHQ(const Value: Variant);
    procedure SetNUMERO_COR(const Value: Variant);
    procedure SetOBSERVACAO_COR(const Value: Variant);
    procedure SetOS_NEW_ID(const Value: Variant);
    procedure SetPAGARME_LOTE(const Value: Variant);
    procedure SetPARCELA_COR(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetPLACA(const Value: Variant);
    procedure SetPORTADOR_COR(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSUB_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetTIPO_CTA(const Value: Variant);
    procedure SetTRANSFERENCIA_ID(const Value: Variant);
    procedure SetTRANSFERENCIA_ORIGEM(const Value: Variant);
    procedure SetTROCO(const Value: Variant);
    procedure SetUSUARIO_COR(const Value: Variant);
    procedure SetVALOR_COR(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetIDBancoView(const Value: String);
    procedure SetSaldo(const Value: Real);

  public

    property NUMERO_COR: Variant read FNUMERO_COR write SetNUMERO_COR;
    property DATA_COR: Variant read FDATA_COR write SetDATA_COR;
    property HORA_COR: Variant read FHORA_COR write SetHORA_COR;
    property CODIGO_CTA: Variant read FCODIGO_CTA write SetCODIGO_CTA;
    property CODIGO_BAN: Variant read FCODIGO_BAN write SetCODIGO_BAN;
    property OBSERVACAO_COR: Variant read FOBSERVACAO_COR write SetOBSERVACAO_COR;
    property VALOR_COR: Variant read FVALOR_COR write SetVALOR_COR;
    property TIPO_CTA: Variant read FTIPO_CTA write SetTIPO_CTA;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property CONCILIADO_COR: Variant read FCONCILIADO_COR write SetCONCILIADO_COR;
    property DATA_CON: Variant read FDATA_CON write SetDATA_CON;
    property CLIENTE_COR: Variant read FCLIENTE_COR write SetCLIENTE_COR;
    property FATURA_COR: Variant read FFATURA_COR write SetFATURA_COR;
    property PARCELA_COR: Variant read FPARCELA_COR write SetPARCELA_COR;
    property CENTRO_CUSTO: Variant read FCENTRO_CUSTO write SetCENTRO_CUSTO;
    property LOJA: Variant read FLOJA write SetLOJA;
    property NUMERO_CHQ: Variant read FNUMERO_CHQ write SetNUMERO_CHQ;
    property DR: Variant read FDR write SetDR;
    property ID: Variant read FID write SetID;
    property PORTADOR_COR: Variant read FPORTADOR_COR write SetPORTADOR_COR;
    property TROCO: Variant read FTROCO write SetTROCO;
    property USUARIO_COR: Variant read FUSUARIO_COR write SetUSUARIO_COR;
    property TIPO: Variant read FTIPO write SetTIPO;
    property SUB_ID: Variant read FSUB_ID write SetSUB_ID;
    property LOCACAO_ID: Variant read FLOCACAO_ID write SetLOCACAO_ID;
    property EMPRESTIMO_RECEBER_ID: Variant read FEMPRESTIMO_RECEBER_ID write SetEMPRESTIMO_RECEBER_ID;
    property FUNCIONARIO_ID: Variant read FFUNCIONARIO_ID write SetFUNCIONARIO_ID;
    property OS_NEW_ID: Variant read FOS_NEW_ID write SetOS_NEW_ID;
    property CONCILIACAO_ID: Variant read FCONCILIACAO_ID write SetCONCILIACAO_ID;
    property PLACA: Variant read FPLACA write SetPLACA;
    property TRANSFERENCIA_ORIGEM: Variant read FTRANSFERENCIA_ORIGEM write SetTRANSFERENCIA_ORIGEM;
    property TRANSFERENCIA_ID: Variant read FTRANSFERENCIA_ID write SetTRANSFERENCIA_ID;
    property COMPETENCIA: Variant read FCOMPETENCIA write SetCOMPETENCIA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property PAGARME_LOTE: Variant read FPAGARME_LOTE write SetPAGARME_LOTE;
    property LOJA_REMOTO: Variant read FLOJA_REMOTO write SetLOJA_REMOTO;
    property PEDIDO_ID: Variant read FPEDIDO_ID write SetPEDIDO_ID;
    property IUGU_ID: Variant read FIUGU_ID write SetIUGU_ID;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITContaCorrenteModel;

    function Incluir : String;
    function Alterar(pID : String) : ITContaCorrenteModel;
    function Excluir(pID : String) : String;
    function Salvar: String;
    procedure obterLista;
    procedure obterSaldo(pLoja: String = '');

    function carregaClasse(pId: String): ITContaCorrenteModel;
    procedure excluirRegistro(pIdRegistro: String);

    property ContaCorrentesLista: IList<ITContaCorrenteModel> read FContaCorrentesLista write SetContaCorrentesLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property IDBancoView: String read FIDBancoView write SetIDBancoView;
    property Saldo: Real read FSaldo write SetSaldo;

  end;

implementation

uses
  SysUtils,
  ContaCorrenteDao;

{ TContaCorrenteModel }

function TContaCorrenteModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TContaCorrenteModel.Alterar(pID: String): ITContaCorrenteModel;
var
  lContaCorrenteModel : ITContaCorrenteModel;
begin
  lContaCorrenteModel := TContaCorrenteModel.getNewIface(vIConexao);
  try
    lContaCorrenteModel      := lContaCorrenteModel.objeto.carregaClasse(pID);
    lContaCorrenteModel.objeto.Acao := tacAlterar;
    Result                   := lContaCorrenteModel;
  finally

  end;
end;

function TContaCorrenteModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

function TContaCorrenteModel.carregaClasse(pId: String): ITContaCorrenteModel;
var
  lContaCorrenteDao: ITContaCorrenteDao;
begin

  lContaCorrenteDao := TContaCorrenteDao.getNewIface(vIConexao);
  try
    Result := lContaCorrenteDao.objeto.carregaClasse(pId);
  finally
    lContaCorrenteDao:=nil;
  end;
end;

constructor TContaCorrenteModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContaCorrenteModel.Destroy;
begin
  FContaCorrentesLista := nil;
  vIConexao := nil;
  inherited;
end;

procedure TContaCorrenteModel.excluirRegistro(pIdRegistro: String);
var
  lContaCorrenteAlterar, lContaCorrenteExclusao: ITContaCorrenteModel;
begin

  lContaCorrenteAlterar  := TContaCorrenteModel.getNewIface(vIConexao);
  lContaCorrenteExclusao := TContaCorrenteModel.getNewIface(vIConexao);

  try
    lContaCorrenteAlterar  := self.carregaClasse(pIdRegistro);
    lContaCorrenteExclusao := lContaCorrenteAlterar;

    lContaCorrenteAlterar.objeto.Acao := tacAlterar;
    lContaCorrenteAlterar.objeto.STATUS := 'X';
    lContaCorrenteAlterar.objeto.Salvar;

    lContaCorrenteExclusao.objeto.Acao := tacIncluir;
    lContaCorrenteExclusao.objeto.STATUS          := 'X';
    lContaCorrenteExclusao.objeto.TIPO_CTA        := 'D';
    lContaCorrenteExclusao.objeto.OBSERVACAO_COR  := 'Estorno lançamento: ' + lContaCorrenteAlterar.objeto.NUMERO_COR;
    lContaCorrenteExclusao.objeto.Salvar;

  finally
    lContaCorrenteAlterar:=nil;
    lContaCorrenteExclusao:=nil;
  end;
end;

class function TContaCorrenteModel.getNewIface(pIConexao: IConexao): ITContaCorrenteModel;
begin
  Result := TImplObjetoOwner<TContaCorrenteModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TContaCorrenteModel.obterLista;
var
  lContaCorrenteLista: ITContaCorrenteDao;
begin
  lContaCorrenteLista := TContaCorrenteDao.getNewIface(vIConexao);

  try
    lContaCorrenteLista.objeto.TotalRecords    := FTotalRecords;
    lContaCorrenteLista.objeto.WhereView       := FWhereView;
    lContaCorrenteLista.objeto.CountView       := FCountView;
    lContaCorrenteLista.objeto.OrderView       := FOrderView;
    lContaCorrenteLista.objeto.StartRecordView := FStartRecordView;
    lContaCorrenteLista.objeto.LengthPageView  := FLengthPageView;
    lContaCorrenteLista.objeto.IDRecordView    := FIDRecordView;

    lContaCorrenteLista.objeto.obterLista;

    FTotalRecords  := lContaCorrenteLista.objeto.TotalRecords;
    FContaCorrentesLista := lContaCorrenteLista.objeto.ContaCorrentesLista;

  finally
    lContaCorrenteLista:=nil;
  end;
end;

procedure TContaCorrenteModel.ObterSaldo(pLoja: String = '');
var
  lContaCorrenteDao: ITContaCorrenteDao;
begin
  lContaCorrenteDao := TContaCorrenteDao.getNewIface(vIConexao);

  try
    lContaCorrenteDao.objeto.IDBancoView := FIDBancoView;
    lContaCorrenteDao.objeto.obterSaldo(pLoja);
    Saldo := lContaCorrenteDao.objeto.Saldo;

  finally
    lContaCorrenteDao:=nil;
  end;
end;

function TContaCorrenteModel.Salvar: String;
var
  lContaCorrenteDao: ITContaCorrenteDao;
begin
  lContaCorrenteDao := TContaCorrenteDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lContaCorrenteDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lContaCorrenteDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lContaCorrenteDao.objeto.excluir(mySelf);
    end;

  finally
    lContaCorrenteDao:=nil;
  end;
end;

procedure TContaCorrenteModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TContaCorrenteModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContaCorrenteModel.SetCENTRO_CUSTO(const Value: Variant);
begin
  FCENTRO_CUSTO := Value;
end;

procedure TContaCorrenteModel.SetCLIENTE_COR(const Value: Variant);
begin
  FCLIENTE_COR := Value;
end;

procedure TContaCorrenteModel.SetCODIGO_BAN(const Value: Variant);
begin
  FCODIGO_BAN := Value;
end;

procedure TContaCorrenteModel.SetCODIGO_CTA(const Value: Variant);
begin
  FCODIGO_CTA := Value;
end;

procedure TContaCorrenteModel.SetCOMPETENCIA(const Value: Variant);
begin
  FCOMPETENCIA := Value;
end;

procedure TContaCorrenteModel.SetCONCILIACAO_ID(const Value: Variant);
begin
  FCONCILIACAO_ID := Value;
end;

procedure TContaCorrenteModel.SetCONCILIADO_COR(const Value: Variant);
begin
  FCONCILIADO_COR := Value;
end;

procedure TContaCorrenteModel.SetDATA_CON(const Value: Variant);
begin
  FDATA_CON := Value;
end;

procedure TContaCorrenteModel.SetDATA_COR(const Value: Variant);
begin
  FDATA_COR := Value;
end;

procedure TContaCorrenteModel.SetDR(const Value: Variant);
begin
  FDR := Value;
end;

procedure TContaCorrenteModel.SetEMPRESTIMO_RECEBER_ID(const Value: Variant);
begin
  FEMPRESTIMO_RECEBER_ID := Value;
end;

procedure TContaCorrenteModel.SetFATURA_COR(const Value: Variant);
begin
  FFATURA_COR := Value;
end;

procedure TContaCorrenteModel.SetFUNCIONARIO_ID(const Value: Variant);
begin
  FFUNCIONARIO_ID := Value;
end;

procedure TContaCorrenteModel.SetHORA_COR(const Value: Variant);
begin
  FHORA_COR := Value;
end;

procedure TContaCorrenteModel.SetContaCorrentesLista;
begin
  FContaCorrentesLista := Value;
end;

procedure TContaCorrenteModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContaCorrenteModel.SetIDBancoView(const Value: String);
begin
  FIDBancoView := Value;
end;

procedure TContaCorrenteModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TContaCorrenteModel.SetIUGU_ID(const Value: Variant);
begin
  FIUGU_ID := Value;
end;

procedure TContaCorrenteModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContaCorrenteModel.SetLOCACAO_ID(const Value: Variant);
begin
  FLOCACAO_ID := Value;
end;

procedure TContaCorrenteModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TContaCorrenteModel.SetLOJA_REMOTO(const Value: Variant);
begin
  FLOJA_REMOTO := Value;
end;

procedure TContaCorrenteModel.SetNUMERO_CHQ(const Value: Variant);
begin
  FNUMERO_CHQ := Value;
end;

procedure TContaCorrenteModel.SetNUMERO_COR(const Value: Variant);
begin
  FNUMERO_COR := Value;
end;

procedure TContaCorrenteModel.SetOBSERVACAO_COR(const Value: Variant);
begin
  FOBSERVACAO_COR := Value;
end;

procedure TContaCorrenteModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContaCorrenteModel.SetOS_NEW_ID(const Value: Variant);
begin
  FOS_NEW_ID := Value;
end;

procedure TContaCorrenteModel.SetPAGARME_LOTE(const Value: Variant);
begin
  FPAGARME_LOTE := Value;
end;

procedure TContaCorrenteModel.SetPARCELA_COR(const Value: Variant);
begin
  FPARCELA_COR := Value;
end;

procedure TContaCorrenteModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TContaCorrenteModel.SetPLACA(const Value: Variant);
begin
  FPLACA := Value;
end;

procedure TContaCorrenteModel.SetPORTADOR_COR(const Value: Variant);
begin
  FPORTADOR_COR := Value;
end;

procedure TContaCorrenteModel.SetSaldo(const Value: Real);
begin
  FSaldo := Value;
end;

procedure TContaCorrenteModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContaCorrenteModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TContaCorrenteModel.SetSUB_ID(const Value: Variant);
begin
  FSUB_ID := Value;
end;

procedure TContaCorrenteModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TContaCorrenteModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TContaCorrenteModel.SetTIPO_CTA(const Value: Variant);
begin
  FTIPO_CTA := Value;
end;

procedure TContaCorrenteModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContaCorrenteModel.SetTRANSFERENCIA_ID(const Value: Variant);
begin
  FTRANSFERENCIA_ID := Value;
end;

procedure TContaCorrenteModel.SetTRANSFERENCIA_ORIGEM(const Value: Variant);
begin
  FTRANSFERENCIA_ORIGEM := Value;
end;

procedure TContaCorrenteModel.SetTROCO(const Value: Variant);
begin
  FTROCO := Value;
end;

procedure TContaCorrenteModel.SetUSUARIO_COR(const Value: Variant);
begin
  FUSUARIO_COR := Value;
end;

procedure TContaCorrenteModel.SetVALOR_COR(const Value: Variant);
begin
  FVALOR_COR := Value;
end;

procedure TContaCorrenteModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
