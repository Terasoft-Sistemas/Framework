unit CaixaModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao, FireDAC.Comp.Client, Terasoft.Utils, System.SysUtils;

type
  TCaixaModel = class;
  ITCaixaModel=IObject<TCaixaModel>;
  TCaixaModel = class
  private
    [unsafe] mySelf: ITCaixaModel;
    vIConexao : IConexao;

    FCaixasLista: IList<ITCaixaModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FSUB_ID: Variant;
    FDATA_CON: Variant;
    FCARGA_ID: Variant;
    FOBSERVACAO: Variant;
    FCONCILIADO_CAI: Variant;
    FUSUARIO_CAI: Variant;
    FTROCO: Variant;
    FDR: Variant;
    FCENTRO_CUSTO: Variant;
    FTIPO_CAI: Variant;
    FDATA_CAI: Variant;
    FFUNCIONARIO_ID: Variant;
    FPARCELA_CAI: Variant;
    FHISTORICO_CAI: Variant;
    FPEDIDO_ID: Variant;
    FPORTADOR_CAI: Variant;
    FVALOR_CAI: Variant;
    FHORA_CAI: Variant;
    FCODIGO_CTA: Variant;
    FTRANSFERENCIA_ID: Variant;
    FRELATORIO: Variant;
    FLOJA: Variant;
    FSTATUS: Variant;
    FCLIENTE_CAI: Variant;
    FLOCACAO_ID: Variant;
    FSYSTIME: Variant;
    FLOJA_REMOTO: Variant;
    FNUMERO_PED: Variant;
    FNUMERO_CAI: Variant;
    FFATURA_CAI: Variant;
    FPLACA: Variant;
    FRECIBO: Variant;
    FCOMPETENCIA: Variant;
    FTIPO: Variant;
    FTRANSFERENCIA_ORIGEM: Variant;
    FOS_ID: Variant;
    FIDRecordView: String;
    FID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetCaixasLista(const Value: IList<ITCaixaModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCARGA_ID(const Value: Variant);
    procedure SetCENTRO_CUSTO(const Value: Variant);
    procedure SetCLIENTE_CAI(const Value: Variant);
    procedure SetCODIGO_CTA(const Value: Variant);
    procedure SetCOMPETENCIA(const Value: Variant);
    procedure SetCONCILIADO_CAI(const Value: Variant);
    procedure SetDATA_CAI(const Value: Variant);
    procedure SetDATA_CON(const Value: Variant);
    procedure SetDR(const Value: Variant);
    procedure SetFATURA_CAI(const Value: Variant);
    procedure SetFUNCIONARIO_ID(const Value: Variant);
    procedure SetHISTORICO_CAI(const Value: Variant);
    procedure SetHORA_CAI(const Value: Variant);
    procedure SetLOCACAO_ID(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLOJA_REMOTO(const Value: Variant);
    procedure SetNUMERO_CAI(const Value: Variant);
    procedure SetNUMERO_PED(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetOS_ID(const Value: Variant);
    procedure SetPARCELA_CAI(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetPLACA(const Value: Variant);
    procedure SetPORTADOR_CAI(const Value: Variant);
    procedure SetRECIBO(const Value: Variant);
    procedure SetRELATORIO(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSUB_ID(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetTIPO_CAI(const Value: Variant);
    procedure SetTRANSFERENCIA_ID(const Value: Variant);
    procedure SetTRANSFERENCIA_ORIGEM(const Value: Variant);
    procedure SetTROCO(const Value: Variant);
    procedure SetUSUARIO_CAI(const Value: Variant);
    procedure SetVALOR_CAI(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetID(const Value: Variant);
  public
    property NUMERO_CAI: Variant read FNUMERO_CAI write SetNUMERO_CAI;
    property CODIGO_CTA: Variant read FCODIGO_CTA write SetCODIGO_CTA;
    property DATA_CAI: Variant read FDATA_CAI write SetDATA_CAI;
    property HORA_CAI: Variant read FHORA_CAI write SetHORA_CAI;
    property HISTORICO_CAI: Variant read FHISTORICO_CAI write SetHISTORICO_CAI;
    property VALOR_CAI: Variant read FVALOR_CAI write SetVALOR_CAI;
    property USUARIO_CAI: Variant read FUSUARIO_CAI write SetUSUARIO_CAI;
    property TIPO_CAI: Variant read FTIPO_CAI write SetTIPO_CAI;
    property CLIENTE_CAI: Variant read FCLIENTE_CAI write SetCLIENTE_CAI;
    property NUMERO_PED: Variant read FNUMERO_PED write SetNUMERO_PED;
    property FATURA_CAI: Variant read FFATURA_CAI write SetFATURA_CAI;
    property PARCELA_CAI: Variant read FPARCELA_CAI write SetPARCELA_CAI;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property PORTADOR_CAI: Variant read FPORTADOR_CAI write SetPORTADOR_CAI;
    property CONCILIADO_CAI: Variant read FCONCILIADO_CAI write SetCONCILIADO_CAI;
    property DATA_CON: Variant read FDATA_CON write SetDATA_CON;
    property CENTRO_CUSTO: Variant read FCENTRO_CUSTO write SetCENTRO_CUSTO;
    property LOJA: Variant read FLOJA write SetLOJA;
    property RECIBO: Variant read FRECIBO write SetRECIBO;
    property RELATORIO: Variant read FRELATORIO write SetRELATORIO;
    property OBSERVACAO: Variant read FOBSERVACAO write SetOBSERVACAO;
    property DR: Variant read FDR write SetDR;
    property TROCO: Variant read FTROCO write SetTROCO;
    property CARGA_ID: Variant read FCARGA_ID write SetCARGA_ID;
    property TIPO: Variant read FTIPO write SetTIPO;
    property SUB_ID: Variant read FSUB_ID write SetSUB_ID;
    property LOCACAO_ID: Variant read FLOCACAO_ID write SetLOCACAO_ID;
    property FUNCIONARIO_ID: Variant read FFUNCIONARIO_ID write SetFUNCIONARIO_ID;
    property OS_ID: Variant read FOS_ID write SetOS_ID;
    property PLACA: Variant read FPLACA write SetPLACA;
    property TRANSFERENCIA_ORIGEM: Variant read FTRANSFERENCIA_ORIGEM write SetTRANSFERENCIA_ORIGEM;
    property TRANSFERENCIA_ID: Variant read FTRANSFERENCIA_ID write SetTRANSFERENCIA_ID;
    property COMPETENCIA: Variant read FCOMPETENCIA write SetCOMPETENCIA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property LOJA_REMOTO: Variant read FLOJA_REMOTO write SetLOJA_REMOTO;
    property PEDIDO_ID: Variant read FPEDIDO_ID write SetPEDIDO_ID;
    property ID: Variant read FID write SetID;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCaixaModel;

    function Incluir: String;
    function Salvar: String;
    procedure obterLista;
    function obterSaldo(pUsario: String): IFDDataset;

    function carregaClasse(pIdCaixa: String): ITCaixaModel;
    function carregaClasseIndexOf(pIndex: Integer): ITCaixaModel;

    procedure excluirRegistro(pIdRegistro: String);

    procedure AlterarStatus(out pValor: Double; out pParcela: Integer; out pTipo, pPortador, pDuplicata, pCliente, pLoja, pConciliado, pConta: String; pNumero, pStatus: String; out pSubGrupo: String);
    procedure RegistroEstorno(pConta, pCliente, pNumero, pFatura, pLoja, pConciliado: String; pValor: Double; pSubGrupo: String);

    property CaixasLista: IList<ITCaixaModel> read FCaixasLista write SetCaixasLista;
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
  CaixaDao;

{ TCaixaModel }

function TCaixaModel.carregaClasse(pIdCaixa: String): ITCaixaModel;
var
  lCaixaDao: ITCaixaDao;
begin
  lCaixaDao := TCaixaDao.getNewIface(vIConexao);

  try
    Result := lCaixaDao.objeto.carregaClasse(pIdCaixa);
  finally
    lCaixaDao:=nil;
  end;
end;

function TCaixaModel.carregaClasseIndexOf(pIndex: Integer): ITCaixaModel;
begin
  Result := self.FCaixasLista[pIndex];
end;

constructor TCaixaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCaixaModel.Destroy;
begin

  inherited;
end;

procedure TCaixaModel.excluirRegistro(pIdRegistro: String);
var
  lCaixaAlterar, lCaixaExclusao: ITCaixaModel;
begin

  lCaixaAlterar  := TCaixaModel.getNewIface(vIConexao);
  lCaixaExclusao := TCaixaModel.getNewIface(vIConexao);

  try
    lCaixaAlterar  := self.carregaClasse(pIdRegistro);
    lCaixaExclusao := lCaixaAlterar;

    lCaixaAlterar.objeto.Acao := tacAlterar;
    lCaixaAlterar.objeto.STATUS := 'X';
    lCaixaAlterar.objeto.Salvar;

    lCaixaExclusao.objeto.Acao := tacIncluir;
    lCaixaExclusao.objeto.STATUS        := 'X';
    lCaixaExclusao.objeto.TIPO_CAI      := 'D';
    lCaixaExclusao.objeto.HISTORICO_CAI := 'Estorno lanšamento: ' + lCaixaAlterar.objeto.NUMERO_CAI;
    lCaixaExclusao.objeto.Salvar;

  finally
    lCaixaAlterar:=nil;
  end;
end;

class function TCaixaModel.getNewIface(pIConexao: IConexao): ITCaixaModel;
begin
  Result := TImplObjetoOwner<TCaixaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCaixaModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

procedure TCaixaModel.obterLista;
var
  lCaixaLista: ITCaixaDao;
begin
  lCaixaLista := TCaixaDao.getNewIface(vIConexao);

  try
    lCaixaLista.objeto.TotalRecords    := FTotalRecords;
    lCaixaLista.objeto.WhereView       := FWhereView;
    lCaixaLista.objeto.CountView       := FCountView;
    lCaixaLista.objeto.OrderView       := FOrderView;
    lCaixaLista.objeto.StartRecordView := FStartRecordView;
    lCaixaLista.objeto.LengthPageView  := FLengthPageView;
    lCaixaLista.objeto.IDRecordView    := FIDRecordView;

    lCaixaLista.objeto.obterLista;

    FTotalRecords   := lCaixaLista.objeto.TotalRecords;
    FCaixasLista    := lCaixaLista.objeto.CaixasLista;

  finally
    lCaixaLista:=nil;
  end;
end;

function TCaixaModel.obterSaldo(pUsario: String): IFDDataset;
var
  lCaixaLista: ITCaixaDao;
begin
  lCaixaLista := TCaixaDao.getNewIface(vIConexao);
  try
    Result := lCaixaLista.objeto.obterSaldo(pUsario);
  finally
    lCaixaLista:=nil;
  end;
end;

function TCaixaModel.Salvar: String;
var
  lCaixaDao: ITCaixaDao;
begin
  lCaixaDao := TCaixaDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCaixaDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lCaixaDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lCaixaDao.objeto.excluir(mySelf);
    end;

  finally
    lCaixaDao:=nil;
  end;
end;

procedure TCaixaModel.AlterarStatus(out pValor: Double; out pParcela: Integer; out pTipo, pPortador, pDuplicata, pCliente, pLoja, pConciliado, pConta: String; pNumero, pStatus: String; out pSubGrupo: String);
var
  lCaixaModel : ITCaixaModel;
begin
  lCaixaModel := TCaixaModel.getNewIface(vIConexao);
  try
    try
      lCaixaModel := lCaixaModel.objeto.carregaClasse(pNumero);
      lCaixaModel.objeto.Acao := tacAlterar;

      lCaixaModel.objeto.STATUS := pStatus;

      pValor      := lCaixaModel.objeto.VALOR_CAI;
      pTipo       := lCaixaModel.objeto.TIPO_CAI;
      pPortador   := lCaixaModel.objeto.PORTADOR_CAI;
      pParcela    := lCaixaModel.objeto.PARCELA_CAI;
      pDuplicata  := lCaixaModel.objeto.FATURA_CAI;
      pCliente    := lCaixaModel.objeto.CLIENTE_CAI;
      pLoja       := lCaixaModel.objeto.LOJA;
      pConciliado := lCaixaModel.objeto.CONCILIADO_CAI;
      pConta      := lCaixaModel.objeto.CODIGO_CTA;
      pSubGrupo   := lCaixaModel.objeto.CENTRO_CUSTO;
      lCaixaModel.objeto.Salvar;
    except
      on E:Exception do
        CriaException('Erro: '+ E.Message);
    end;
  finally
    lCaixaModel := nil;
  end;
end;

procedure TCaixaModel.RegistroEstorno(pConta, pCliente, pNumero, pFatura, pLoja, pConciliado: String; pValor: Double; pSubGrupo: String);
var
  lCaixaModel : ITCaixaModel;
begin
  lCaixaModel := TCaixaModel.getNewIface(vIConexao);
  try
    try
      lCaixaModel.objeto.CODIGO_CTA     := pConta;
      lCaixaModel.objeto.CENTRO_CUSTO   := pSubGrupo;
      lCaixaModel.objeto.CLIENTE_CAI    := pCliente;
      lCaixaModel.objeto.DATA_CAI       := DateToStr(vIConexao.DataServer);
      lCaixaModel.objeto.DATA_CON       := DateToStr(vIConexao.DataServer);
      lCaixaModel.objeto.VALOR_CAI      := pValor;
      lCaixaModel.objeto.HISTORICO_CAI := 'Estorno lanšamento: '+pNumero;
      lCaixaModel.objeto.STATUS         := 'X';
      lCaixaModel.objeto.FATURA_CAI     := pFatura;
      lCaixaModel.objeto.LOJA           := pLoja;
      lCaixaModel.objeto.TIPO_CAI       := 'D';
      lCaixaModel.objeto.CONCILIADO_CAI := pConciliado;
      lCaixaModel.objeto.Incluir;
    except
      on E:Exception do
        CriaException('Erro: '+ E.Message);
    end;
  finally
    lCaixaModel := nil;
  end;
end;

procedure TCaixaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TCaixaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCaixaModel.SetDATA_CADASTRO(const Value: Variant);
begin

end;

procedure TCaixaModel.SetDATA_CAI(const Value: Variant);
begin
  FDATA_CAI := Value;
end;

procedure TCaixaModel.SetDATA_CON(const Value: Variant);
begin
  FDATA_CON := Value;
end;

procedure TCaixaModel.SetDR(const Value: Variant);
begin
  FDR := Value;
end;

procedure TCaixaModel.SetFATURA_CAI(const Value: Variant);
begin
  FFATURA_CAI := Value;
end;

procedure TCaixaModel.SetFUNCIONARIO_ID(const Value: Variant);
begin
  FFUNCIONARIO_ID := Value;
end;

procedure TCaixaModel.SetHISTORICO_CAI(const Value: Variant);
begin
  FHISTORICO_CAI := Value;
end;

procedure TCaixaModel.SetHORA_CAI(const Value: Variant);
begin
  FHORA_CAI := Value;
end;

procedure TCaixaModel.SetCaixasLista;
begin
  FCaixasLista := Value;
end;

procedure TCaixaModel.SetCARGA_ID(const Value: Variant);
begin
  FCARGA_ID := Value;
end;

procedure TCaixaModel.SetCENTRO_CUSTO(const Value: Variant);
begin
  FCENTRO_CUSTO := Value;
end;

procedure TCaixaModel.SetCLIENTE_CAI(const Value: Variant);
begin
  FCLIENTE_CAI := Value;
end;

procedure TCaixaModel.SetCODIGO_CTA(const Value: Variant);
begin
  FCODIGO_CTA := Value;
end;

procedure TCaixaModel.SetCOMPETENCIA(const Value: Variant);
begin
  FCOMPETENCIA := Value;
end;

procedure TCaixaModel.SetCONCILIADO_CAI(const Value: Variant);
begin
  FCONCILIADO_CAI := Value;
end;

procedure TCaixaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCaixaModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TCaixaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCaixaModel.SetLOCACAO_ID(const Value: Variant);
begin
  FLOCACAO_ID := Value;
end;

procedure TCaixaModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TCaixaModel.SetLOJA_REMOTO(const Value: Variant);
begin
  FLOJA_REMOTO := Value;
end;

procedure TCaixaModel.SetNUMERO_CAI(const Value: Variant);
begin
  FNUMERO_CAI := Value;
end;

procedure TCaixaModel.SetNUMERO_PED(const Value: Variant);
begin
  FNUMERO_PED := Value;
end;

procedure TCaixaModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TCaixaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCaixaModel.SetOS_ID(const Value: Variant);
begin
  FOS_ID := Value;
end;

procedure TCaixaModel.SetPARCELA_CAI(const Value: Variant);
begin
  FPARCELA_CAI := Value;
end;

procedure TCaixaModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TCaixaModel.SetPLACA(const Value: Variant);
begin
  FPLACA := Value;
end;

procedure TCaixaModel.SetPORTADOR_CAI(const Value: Variant);
begin
  FPORTADOR_CAI := Value;
end;

procedure TCaixaModel.SetRECIBO(const Value: Variant);
begin
  FRECIBO := Value;
end;

procedure TCaixaModel.SetRELATORIO(const Value: Variant);
begin
  FRELATORIO := Value;
end;

procedure TCaixaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCaixaModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TCaixaModel.SetSUB_ID(const Value: Variant);
begin
  FSUB_ID := Value;
end;

procedure TCaixaModel.SetSYSTIME(const Value: Variant);
begin

end;

procedure TCaixaModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TCaixaModel.SetTIPO_CAI(const Value: Variant);
begin
  FTIPO_CAI := Value;
end;

procedure TCaixaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCaixaModel.SetTRANSFERENCIA_ID(const Value: Variant);
begin
  FTRANSFERENCIA_ID := Value;
end;

procedure TCaixaModel.SetTRANSFERENCIA_ORIGEM(const Value: Variant);
begin
  FTRANSFERENCIA_ORIGEM := Value;
end;

procedure TCaixaModel.SetTROCO(const Value: Variant);
begin
  FTROCO := Value;
end;

procedure TCaixaModel.SetUSUARIO_CAI(const Value: Variant);
begin
  FUSUARIO_CAI := Value;
end;

procedure TCaixaModel.SetVALOR_CAI(const Value: Variant);
begin
  FVALOR_CAI := Value;
end;

procedure TCaixaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
