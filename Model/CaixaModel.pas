unit CaixaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao, FireDAC.Comp.Client;

type
  TCaixaModel = class

  private
    vIConexao : IConexao;

    FCaixasLista: TObjectList<TCaixaModel>;
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
    procedure SetCaixasLista(const Value: TObjectList<TCaixaModel>);
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

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Salvar: String;
    procedure obterLista;
    function obterSaldo(pUsario: String): TFDMemTable;

    function carregaClasse(pIdCaixa: String): TCaixaModel;
    function carregaClasseIndexOf(pIndex: Integer): TCaixaModel;

    procedure excluirRegistro(pIdRegistro: String);

    property CaixasLista: TObjectList<TCaixaModel> read FCaixasLista write SetCaixasLista;
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

function TCaixaModel.carregaClasse(pIdCaixa: String): TCaixaModel;
var
  lCaixaDao: TCaixaDao;
begin
  lCaixaDao := TCaixaDao.Create(vIConexao);

  try
    Result := lCaixaDao.carregaClasse(pIdCaixa);
  finally
    lCaixaDao.Free;
  end;
end;

function TCaixaModel.carregaClasseIndexOf(pIndex: Integer): TCaixaModel;
begin
  Result := self.FCaixasLista[pIndex];
end;

constructor TCaixaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCaixaModel.Destroy;
begin

  inherited;
end;

procedure TCaixaModel.excluirRegistro(pIdRegistro: String);
var
  lCaixaAlterar, lCaixaExclusao: TCaixaModel;
begin

  lCaixaAlterar  := TCaixaModel.Create(vIConexao);
  lCaixaExclusao := TCaixaModel.Create(vIConexao);

  try
    lCaixaAlterar  := self.carregaClasse(pIdRegistro);
    lCaixaExclusao := lCaixaAlterar;

    lCaixaAlterar.Acao := tacAlterar;
    lCaixaAlterar.STATUS := 'X';
    lCaixaAlterar.Salvar;

    lCaixaExclusao.Acao := tacIncluir;
    lCaixaExclusao.STATUS        := 'X';
    lCaixaExclusao.TIPO_CAI      := 'D';
    lCaixaExclusao.HISTORICO_CAI := 'Estorno lançamento: ' + lCaixaAlterar.NUMERO_CAI;
    lCaixaExclusao.Salvar;

  finally
    lCaixaAlterar.Free;
  end;
end;

function TCaixaModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

procedure TCaixaModel.obterLista;
var
  lCaixaLista: TCaixaDao;
begin
  lCaixaLista := TCaixaDao.Create(vIConexao);

  try
    lCaixaLista.TotalRecords    := FTotalRecords;
    lCaixaLista.WhereView       := FWhereView;
    lCaixaLista.CountView       := FCountView;
    lCaixaLista.OrderView       := FOrderView;
    lCaixaLista.StartRecordView := FStartRecordView;
    lCaixaLista.LengthPageView  := FLengthPageView;
    lCaixaLista.IDRecordView    := FIDRecordView;

    lCaixaLista.obterLista;

    FTotalRecords   := lCaixaLista.TotalRecords;
    FCaixasLista    := lCaixaLista.CaixasLista;

  finally
    lCaixaLista.Free;
  end;
end;

function TCaixaModel.obterSaldo(pUsario: String): TFDMemTable;
var
  lCaixaLista: TCaixaDao;
begin
  lCaixaLista := TCaixaDao.Create(vIConexao);
  try
    Result := lCaixaLista.obterSaldo(pUsario);
  finally
    lCaixaLista.Free;
  end;
end;

function TCaixaModel.Salvar: String;
var
  lCaixaDao: TCaixaDao;
begin
  lCaixaDao := TCaixaDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCaixaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lCaixaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lCaixaDao.excluir(Self);
    end;

  finally
    lCaixaDao.Free;
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

procedure TCaixaModel.SetCaixasLista(const Value: TObjectList<TCaixaModel>);
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
