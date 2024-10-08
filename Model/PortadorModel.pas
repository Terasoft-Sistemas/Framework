unit PortadorModel;

interface

uses
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TPortadorModel = class;

  ITPortadorModel = IObject<TPortadorModel>;

  TPortadorModel = class
  private
    [unsafe] mySelf: ITPortadorModel;
    vIConexao : IConexao;
    FPortadorsLista: IList<ITPortadorModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    FUSUARIO_PORT: Variant;
    FNOME_PORT: Variant;
    FTEF_PARCELAMENTO: Variant;
    FOBS: Variant;
    FTEF_MODALIDADE: Variant;
    FDF_CONTA_ID: Variant;
    FPERCENTUAL_COMISSAO: Variant;
    FPERCENTUAL_DESPESA_VENDA: Variant;
    FDESCONTO_PORT: Variant;
    FRECEBIMENTO_CONTA_ID: Variant;
    FCREDITO_CONTA_ID: Variant;
    FTELA_RECEBIMENTO: Variant;
    FCUSTO_CONTA_ID: Variant;
    FTEF_ADQUIRENTE: Variant;
    FPEDIR_VENCIMENTO: Variant;
    FID: Variant;
    FXPAG_NFE: Variant;
    FCODIGO_PORT: Variant;
    FBANCO_BAIXA_DIRETA: Variant;
    FRECEITA_CONTA_ID: Variant;
    FSTATUS: Variant;
    FCONDICOES_PAG: Variant;
    FSITUACAO_CLIENTE: Variant;
    FSYSTIME: Variant;
    FDIRETO: Variant;
    FCONTAGEM: Variant;
    FVR_PORT: Variant;
    FDIA_VENCIMENTO: Variant;
    FPIX_CHAVE: Variant;
    FTPAG_NFE: Variant;
    FTIPO: Variant;
    FPER_SEGURO_PRESTAMISTA: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPortadorsLista(const Value: IList<ITPortadorModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);
    procedure SetBANCO_BAIXA_DIRETA(const Value: Variant);
    procedure SetCODIGO_PORT(const Value: Variant);
    procedure SetCONDICOES_PAG(const Value: Variant);
    procedure SetCONTAGEM(const Value: Variant);
    procedure SetCREDITO_CONTA_ID(const Value: Variant);
    procedure SetCUSTO_CONTA_ID(const Value: Variant);
    procedure SetDESCONTO_PORT(const Value: Variant);
    procedure SetDF_CONTA_ID(const Value: Variant);
    procedure SetDIA_VENCIMENTO(const Value: Variant);
    procedure SetDIRETO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetNOME_PORT(const Value: Variant);
    procedure SetOBS(const Value: Variant);
    procedure SetPEDIR_VENCIMENTO(const Value: Variant);
    procedure SetPERCENTUAL_COMISSAO(const Value: Variant);
    procedure SetPERCENTUAL_DESPESA_VENDA(const Value: Variant);
    procedure SetPIX_CHAVE(const Value: Variant);
    procedure SetRECEBIMENTO_CONTA_ID(const Value: Variant);
    procedure SetRECEITA_CONTA_ID(const Value: Variant);
    procedure SetSITUACAO_CLIENTE(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTEF_ADQUIRENTE(const Value: Variant);
    procedure SetTEF_MODALIDADE(const Value: Variant);
    procedure SetTEF_PARCELAMENTO(const Value: Variant);
    procedure SetTELA_RECEBIMENTO(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetTPAG_NFE(const Value: Variant);
    procedure SetUSUARIO_PORT(const Value: Variant);
    procedure SetVR_PORT(const Value: Variant);
    procedure SetXPAG_NFE(const Value: Variant);
    procedure SetPER_SEGURO_PRESTAMISTA(const Value: Variant);
  public
    property CODIGO_PORT: Variant read FCODIGO_PORT write SetCODIGO_PORT;
    property NOME_PORT: Variant read FNOME_PORT write SetNOME_PORT;
    property VR_PORT: Variant read FVR_PORT write SetVR_PORT;
    property DESCONTO_PORT: Variant read FDESCONTO_PORT write SetDESCONTO_PORT;
    property USUARIO_PORT: Variant read FUSUARIO_PORT write SetUSUARIO_PORT;
    property ID: Variant read FID write SetID;
    property TIPO: Variant read FTIPO write SetTIPO;
    property CONDICOES_PAG: Variant read FCONDICOES_PAG write SetCONDICOES_PAG;
    property OBS: Variant read FOBS write SetOBS;
    property RECEITA_CONTA_ID: Variant read FRECEITA_CONTA_ID write SetRECEITA_CONTA_ID;
    property CUSTO_CONTA_ID: Variant read FCUSTO_CONTA_ID write SetCUSTO_CONTA_ID;
    property DF_CONTA_ID: Variant read FDF_CONTA_ID write SetDF_CONTA_ID;
    property RECEBIMENTO_CONTA_ID: Variant read FRECEBIMENTO_CONTA_ID write SetRECEBIMENTO_CONTA_ID;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property DIA_VENCIMENTO: Variant read FDIA_VENCIMENTO write SetDIA_VENCIMENTO;
    property PERCENTUAL_DESPESA_VENDA: Variant read FPERCENTUAL_DESPESA_VENDA write SetPERCENTUAL_DESPESA_VENDA;
    property DIRETO: Variant read FDIRETO write SetDIRETO;
    property PEDIR_VENCIMENTO: Variant read FPEDIR_VENCIMENTO write SetPEDIR_VENCIMENTO;
    property TELA_RECEBIMENTO: Variant read FTELA_RECEBIMENTO write SetTELA_RECEBIMENTO;
    property TPAG_NFE: Variant read FTPAG_NFE write SetTPAG_NFE;
    property CREDITO_CONTA_ID: Variant read FCREDITO_CONTA_ID write SetCREDITO_CONTA_ID;
    property CONTAGEM: Variant read FCONTAGEM write SetCONTAGEM;
    property PERCENTUAL_COMISSAO: Variant read FPERCENTUAL_COMISSAO write SetPERCENTUAL_COMISSAO;
    property SITUACAO_CLIENTE: Variant read FSITUACAO_CLIENTE write SetSITUACAO_CLIENTE;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property BANCO_BAIXA_DIRETA: Variant read FBANCO_BAIXA_DIRETA write SetBANCO_BAIXA_DIRETA;
    property TEF_MODALIDADE: Variant read FTEF_MODALIDADE write SetTEF_MODALIDADE;
    property TEF_PARCELAMENTO: Variant read FTEF_PARCELAMENTO write SetTEF_PARCELAMENTO;
    property TEF_ADQUIRENTE: Variant read FTEF_ADQUIRENTE write SetTEF_ADQUIRENTE;
    property PIX_CHAVE: Variant read FPIX_CHAVE write SetPIX_CHAVE;
    property XPAG_NFE: Variant read FXPAG_NFE write SetXPAG_NFE;
    property PER_SEGURO_PRESTAMISTA: Variant read FPER_SEGURO_PRESTAMISTA write SetPER_SEGURO_PRESTAMISTA;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPortadorModel;

    function Incluir : String;
    function Alterar(pID : String) : ITPortadorModel;
    function Excluir(pID : String) : String;
    function Salvar: String;
    procedure obterLista;

    function carregaClasse(pId: String): ITPortadorModel;
    function PortadorTabelaJuros : IFDDataset;
    function possuiBandeira(pPortador: String): Boolean;

    property PortadorsLista: IList<ITPortadorModel> read FPortadorsLista write SetPortadorsLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  PortadorDao, AdmCartaoDao, System.SysUtils;

{ TPortadorModel }

function TPortadorModel.Alterar(pID: String): ITPortadorModel;
var
  lPortadorModel : ITPortadorModel;
begin
  lPortadorModel := TPortadorModel.getNewIface(vIConexao);
  try
    lPortadorModel := lPortadorModel.objeto.carregaClasse(pID);
    lPortadorModel.objeto.Acao := tacAlterar;
    Result := lPortadorModel;
  finally

  end;
end;

function TPortadorModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TPortadorModel.getNewIface(pIConexao: IConexao): ITPortadorModel;
begin
  Result := TImplObjetoOwner<TPortadorModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPortadorModel.Incluir: String;
begin
  self.FAcao := tacIncluir;
  Result     := self.Salvar;
end;

function TPortadorModel.carregaClasse(pId: String): ITPortadorModel;
var
  lPortadorDao: ITPortadorDao;
begin
  lPortadorDao := TPortadorDao.getNewIface(vIConexao);

  try
    Result := lPortadorDao.objeto.carregaClasse(pId);
  finally
    lPortadorDao:=nil;
  end;
end;

constructor TPortadorModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPortadorModel.Destroy;
begin
  FPortadorsLista := nil;
  vIConexao := nil;
  inherited;
end;

procedure TPortadorModel.obterLista;
var
  lPortadorLista: ITPortadorDao;
begin
  lPortadorLista := TPortadorDao.getNewIface(vIConexao);

  try
    lPortadorLista.objeto.TotalRecords    := FTotalRecords;
    lPortadorLista.objeto.WhereView       := FWhereView;
    lPortadorLista.objeto.CountView       := FCountView;
    lPortadorLista.objeto.OrderView       := FOrderView;
    lPortadorLista.objeto.StartRecordView := FStartRecordView;
    lPortadorLista.objeto.LengthPageView  := FLengthPageView;
    lPortadorLista.objeto.IDRecordView    := FIDRecordView;

    lPortadorLista.objeto.obterLista;

    FTotalRecords  := lPortadorLista.objeto.TotalRecords;
    FPortadorsLista := lPortadorLista.objeto.PortadorsLista;

  finally
    lPortadorLista:=nil;
  end;
end;

function TPortadorModel.PortadorTabelaJuros: IFDDataset;
var
  lPortadorTabelaJuros: ITPortadorDao;
begin
  lPortadorTabelaJuros := TPortadorDao.getNewIface(vIConexao);
  try

    lPortadorTabelaJuros.objeto.IDRecordView := FIDRecordView;
    Result := lPortadorTabelaJuros.objeto.PortadorTabelaJuros;

  finally
    lPortadorTabelaJuros:=nil;
  end;
end;

function TPortadorModel.possuiBandeira(pPortador: String): Boolean;
var
  lAdmCartaoDao: ITAdmCartaoDao;
begin
  lAdmCartaoDao := TAdmCartaoDao.getNewIface(vIConexao);
  try
    lAdmCartaoDao.objeto.WhereView := 'and coalesce(status,''A'') = ''A'' and portador_id = ' + QuotedStr(pPortador);
    lAdmCartaoDao.objeto.obterTotalRegistros;

    Result := (lAdmCartaoDao.objeto.TotalRecords > 0);
  finally
    lAdmCartaoDao:=nil;
  end;
end;

function TPortadorModel.Salvar: String;
var
  lPortadorDao: ITPortadorDao;
begin
  lPortadorDao := TPortadorDao.getNewIface(vIConexao);

  Result := '';

  try

  finally
    lPortadorDao:=nil;
  end;
end;

procedure TPortadorModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPortadorModel.SetBANCO_BAIXA_DIRETA(const Value: Variant);
begin
  FBANCO_BAIXA_DIRETA := Value;
end;

procedure TPortadorModel.SetCODIGO_PORT(const Value: Variant);
begin
  FCODIGO_PORT := Value;
end;

procedure TPortadorModel.SetCONDICOES_PAG(const Value: Variant);
begin
  FCONDICOES_PAG := Value;
end;

procedure TPortadorModel.SetCONTAGEM(const Value: Variant);
begin
  FCONTAGEM := Value;
end;

procedure TPortadorModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPortadorModel.SetCREDITO_CONTA_ID(const Value: Variant);
begin
  FCREDITO_CONTA_ID := Value;
end;

procedure TPortadorModel.SetCUSTO_CONTA_ID(const Value: Variant);
begin
  FCUSTO_CONTA_ID := Value;
end;

procedure TPortadorModel.SetDESCONTO_PORT(const Value: Variant);
begin
  FDESCONTO_PORT := Value;
end;

procedure TPortadorModel.SetDF_CONTA_ID(const Value: Variant);
begin
  FDF_CONTA_ID := Value;
end;

procedure TPortadorModel.SetDIA_VENCIMENTO(const Value: Variant);
begin
  FDIA_VENCIMENTO := Value;
end;

procedure TPortadorModel.SetDIRETO(const Value: Variant);
begin
  FDIRETO := Value;
end;

procedure TPortadorModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPortadorModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPortadorModel.SetPEDIR_VENCIMENTO(const Value: Variant);
begin
  FPEDIR_VENCIMENTO := Value;
end;

procedure TPortadorModel.SetPERCENTUAL_COMISSAO(const Value: Variant);
begin
  FPERCENTUAL_COMISSAO := Value;
end;

procedure TPortadorModel.SetPERCENTUAL_DESPESA_VENDA(const Value: Variant);
begin
  FPERCENTUAL_DESPESA_VENDA := Value;
end;

procedure TPortadorModel.SetPER_SEGURO_PRESTAMISTA(const Value: Variant);
begin
  FPER_SEGURO_PRESTAMISTA := Value;
end;

procedure TPortadorModel.SetPIX_CHAVE(const Value: Variant);
begin
  FPIX_CHAVE := Value;
end;

procedure TPortadorModel.SetPortadorsLista;
begin
  FPortadorsLista := Value;
end;

procedure TPortadorModel.SetRECEBIMENTO_CONTA_ID(const Value: Variant);
begin
  FRECEBIMENTO_CONTA_ID := Value;
end;

procedure TPortadorModel.SetRECEITA_CONTA_ID(const Value: Variant);
begin
  FRECEITA_CONTA_ID := Value;
end;

procedure TPortadorModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPortadorModel.SetNOME_PORT(const Value: Variant);
begin
  FNOME_PORT := Value;
end;

procedure TPortadorModel.SetOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TPortadorModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPortadorModel.SetSITUACAO_CLIENTE(const Value: Variant);
begin
  FSITUACAO_CLIENTE := Value;
end;

procedure TPortadorModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPortadorModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TPortadorModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPortadorModel.SetTEF_ADQUIRENTE(const Value: Variant);
begin
  FTEF_ADQUIRENTE := Value;
end;

procedure TPortadorModel.SetTEF_MODALIDADE(const Value: Variant);
begin
  FTEF_MODALIDADE := Value;
end;

procedure TPortadorModel.SetTEF_PARCELAMENTO(const Value: Variant);
begin
  FTEF_PARCELAMENTO := Value;
end;

procedure TPortadorModel.SetTELA_RECEBIMENTO(const Value: Variant);
begin
  FTELA_RECEBIMENTO := Value;
end;

procedure TPortadorModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TPortadorModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPortadorModel.SetTPAG_NFE(const Value: Variant);
begin
  FTPAG_NFE := Value;
end;

procedure TPortadorModel.SetUSUARIO_PORT(const Value: Variant);
begin
  FUSUARIO_PORT := Value;
end;

procedure TPortadorModel.SetVR_PORT(const Value: Variant);
begin
  FVR_PORT := Value;
end;

procedure TPortadorModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TPortadorModel.SetXPAG_NFE(const Value: Variant);
begin
  FXPAG_NFE := Value;
end;

end.
