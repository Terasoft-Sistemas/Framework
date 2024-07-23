unit ContasReceberModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.FuncoesTexto,
  ContasReceberItensDao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TContasReceberModel = class
  private

    vIConexao : IConexao;

    FContasRecebersLista: IObject<TObjectList<TContasReceberModel>>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPEDIDO_SITE: Variant;
    FDESENVOLVIMENTO_ID: Variant;
    FSUB_ID: Variant;
    FLOCAL_BAIXA: Variant;
    FFICHA_ID: Variant;
    FCENTRO_CUSTO: Variant;
    FOBS_REC: Variant;
    FJUROS_FIXO: Variant;
    FVALOR_REC: Variant;
    FFUNCIONARIO_ID: Variant;
    FDATA_AGENDAMENTO: Variant;
    FPEDIDO_REC: Variant;
    FOBS_COMPLEMENTAR: Variant;
    FCODIGO_ANTERIOR: Variant;
    FPRIMEIRO_VENC: Variant;
    FCONTRATO: Variant;
    FCENTERCOB: Variant;
    FCODIGO_CTA: Variant;
    FCODIGO_CLI: Variant;
    FID: Variant;
    FVENDEDOR_REC: Variant;
    FINDICE_JUROS_ID: Variant;
    FCONFERIDO: Variant;
    FLOJA: Variant;
    FFATURA_REC: Variant;
    FCONDICOES_PAG: Variant;
    FCODIGO_POR: Variant;
    FLOCACAO_ID: Variant;
    FSYSTIME: Variant;
    FAVALISTA: Variant;
    FDATAEMI_REC: Variant;
    FSITUACAO_REC: Variant;
    FULTIMO_DIA_MES: Variant;
    FSAIDA_REC: Variant;
    FUSUARIO_REC: Variant;
    FOS_REC: Variant;
    FTIPO_REC: Variant;
    FIDPedidoView: String;
    FPORTADOR_NOME: Variant;
    FTOTAL_PARCELAS: Variant;
    FVALOR_PARCELA: Variant;
    FIDRecordView: String;
    FIDAdmCartao: String;
    FVALOR_PAGO: Variant;
    FRECEBIMENTO_CONCLUIDO: Boolean;
    FACRESCIMO: Variant;
    FIDUsuarioOperacao: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetContasRecebersLista(const Value: IObject<TObjectList<TContasReceberModel>>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetAVALISTA(const Value: Variant);
    procedure SetCENTERCOB(const Value: Variant);
    procedure SetCENTRO_CUSTO(const Value: Variant);
    procedure SetCODIGO_ANTERIOR(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCODIGO_CTA(const Value: Variant);
    procedure SetCODIGO_POR(const Value: Variant);
    procedure SetCONDICOES_PAG(const Value: Variant);
    procedure SetCONFERIDO(const Value: Variant);
    procedure SetCONTRATO(const Value: Variant);
    procedure SetDATA_AGENDAMENTO(const Value: Variant);
    procedure SetDATAEMI_REC(const Value: Variant);
    procedure SetDESENVOLVIMENTO_ID(const Value: Variant);
    procedure SetFATURA_REC(const Value: Variant);
    procedure SetFICHA_ID(const Value: Variant);
    procedure SetFUNCIONARIO_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetINDICE_JUROS_ID(const Value: Variant);
    procedure SetJUROS_FIXO(const Value: Variant);
    procedure SetLOCACAO_ID(const Value: Variant);
    procedure SetLOCAL_BAIXA(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetOBS_COMPLEMENTAR(const Value: Variant);
    procedure SetOBS_REC(const Value: Variant);
    procedure SetOS_REC(const Value: Variant);
    procedure SetPEDIDO_REC(const Value: Variant);
    procedure SetPEDIDO_SITE(const Value: Variant);
    procedure SetPRIMEIRO_VENC(const Value: Variant);
    procedure SetSAIDA_REC(const Value: Variant);
    procedure SetSITUACAO_REC(const Value: Variant);
    procedure SetSUB_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO_REC(const Value: Variant);
    procedure SetULTIMO_DIA_MES(const Value: Variant);
    procedure SetUSUARIO_REC(const Value: Variant);
    procedure SetVALOR_REC(const Value: Variant);
    procedure SetVENDEDOR_REC(const Value: Variant);
    procedure SetIDPedidoView(const Value: String);
    procedure SetPORTADOR_NOME(const Value: Variant);
    procedure SetTOTAL_PARCELAS(const Value: Variant);
    procedure SetVALOR_PARCELA(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetIDAdmCartao(const Value: String);
    procedure SetVALOR_PAGO(const Value: Variant);
    procedure SetRECEBIMENTO_CONCLUIDO(const Value: Boolean);
    procedure SetACRESCIMO(const Value: Variant);
    procedure SetIDUsuarioOperacao(const Value: String);
  public
    property FATURA_REC: Variant read FFATURA_REC write SetFATURA_REC;
    property CODIGO_CLI: Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property CODIGO_CTA: Variant read FCODIGO_CTA write SetCODIGO_CTA;
    property DATAEMI_REC: Variant read FDATAEMI_REC write SetDATAEMI_REC;
    property VALOR_REC: Variant read FVALOR_REC write SetVALOR_REC;
    property OBS_REC: Variant read FOBS_REC write SetOBS_REC;
    property SITUACAO_REC: Variant read FSITUACAO_REC write SetSITUACAO_REC;
    property USUARIO_REC: Variant read FUSUARIO_REC write SetUSUARIO_REC;
    property VENDEDOR_REC: Variant read FVENDEDOR_REC write SetVENDEDOR_REC;
    property TIPO_REC: Variant read FTIPO_REC write SetTIPO_REC;
    property OS_REC: Variant read FOS_REC write SetOS_REC;
    property PEDIDO_REC: Variant read FPEDIDO_REC write SetPEDIDO_REC;
    property CODIGO_POR: Variant read FCODIGO_POR write SetCODIGO_POR;
    property LOJA: Variant read FLOJA write SetLOJA;
    property CENTERCOB: Variant read FCENTERCOB write SetCENTERCOB;
    property AVALISTA: Variant read FAVALISTA write SetAVALISTA;
    property DATA_AGENDAMENTO: Variant read FDATA_AGENDAMENTO write SetDATA_AGENDAMENTO;
    property ID: Variant read FID write SetID;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property INDICE_JUROS_ID: Variant read FINDICE_JUROS_ID write SetINDICE_JUROS_ID;
    property JUROS_FIXO: Variant read FJUROS_FIXO write SetJUROS_FIXO;
    property PRIMEIRO_VENC: Variant read FPRIMEIRO_VENC write SetPRIMEIRO_VENC;
    property ULTIMO_DIA_MES: Variant read FULTIMO_DIA_MES write SetULTIMO_DIA_MES;
    property CONDICOES_PAG: Variant read FCONDICOES_PAG write SetCONDICOES_PAG;
    property SUB_ID: Variant read FSUB_ID write SetSUB_ID;
    property LOCACAO_ID: Variant read FLOCACAO_ID write SetLOCACAO_ID;
    property CENTRO_CUSTO: Variant read FCENTRO_CUSTO write SetCENTRO_CUSTO;
    property OBS_COMPLEMENTAR: Variant read FOBS_COMPLEMENTAR write SetOBS_COMPLEMENTAR;
    property FICHA_ID: Variant read FFICHA_ID write SetFICHA_ID;
    property FUNCIONARIO_ID: Variant read FFUNCIONARIO_ID write SetFUNCIONARIO_ID;
    property CONTRATO: Variant read FCONTRATO write SetCONTRATO;
    property CONFERIDO: Variant read FCONFERIDO write SetCONFERIDO;
    property LOCAL_BAIXA: Variant read FLOCAL_BAIXA write SetLOCAL_BAIXA;
    property SAIDA_REC: Variant read FSAIDA_REC write SetSAIDA_REC;
    property CODIGO_ANTERIOR: Variant read FCODIGO_ANTERIOR write SetCODIGO_ANTERIOR;
    property DESENVOLVIMENTO_ID: Variant read FDESENVOLVIMENTO_ID write SetDESENVOLVIMENTO_ID;
    property PEDIDO_SITE: Variant read FPEDIDO_SITE write SetPEDIDO_SITE;
    property VALOR_PAGO: Variant read FVALOR_PAGO write SetVALOR_PAGO;
    property PORTADOR_NOME: Variant read FPORTADOR_NOME write SetPORTADOR_NOME;
    property VALOR_PARCELA: Variant read FVALOR_PARCELA write SetVALOR_PARCELA;
    property TOTAL_PARCELAS: Variant read FTOTAL_PARCELAS write SetTOTAL_PARCELAS;
    property RECEBIMENTO_CONCLUIDO: Boolean read FRECEBIMENTO_CONCLUIDO write SetRECEBIMENTO_CONCLUIDO;
    property ACRESCIMO: Variant read FACRESCIMO write SetACRESCIMO;

  	constructor Create(pConexao : IConexao);
    destructor Destroy; override;

    function Incluir : String;
    function Alterar(pID : String) : TContasReceberModel;
    function Excluir(pFatura : String) : String;
    function Salvar: String;
    procedure obterLista;
    procedure obterContasReceberPedido;
    function carregaClasse(pFatura: String): TContasReceberModel;
    function concluirContasReceber(pFatura: String): TConclusaoContasReceber;
    function gerarChamadaTEF(pTefModalidade, pTefParcelamento, pTefAdquirente: String): String;
    function pedidoContasReceber(pFatura: String): String;
    procedure excluirBaixa;
    procedure excluirVendaCartao;
    procedure validaExclusao;

    property ContasRecebersLista: IObject<TObjectList<TContasReceberModel>> read FContasRecebersLista write SetContasRecebersLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDPedidoView: String read FIDPedidoView write SetIDPedidoView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property IDAdmCartao: String read FIDAdmCartao write SetIDAdmCartao;
    property IDUsuarioOperacao: String read FIDUsuarioOperacao write SetIDUsuarioOperacao;
  end;

implementation

uses
  ContasReceberDao,
  AdmCartaoModel,
  System.SysUtils,
  ContasReceberItensModel,
  VendaCartaoModel,
  PortadorModel,
  System.Variants,
  System.StrUtils,
  CaixaModel,
  TEFModel;
{ TContasReceberModel }

function TContasReceberModel.Incluir: String;
begin
  self.FAcao := tacIncluir;
  Result     := self.Salvar;
end;

function TContasReceberModel.Alterar(pID: String): TContasReceberModel;
var
  lContasReceberModel : TContasReceberModel;
begin
  lContasReceberModel := TContasReceberModel.Create(vIConexao);
  try
    lContasReceberModel      := lContasReceberModel.carregaClasse(pID);
    lContasReceberModel.Acao := tacAlterar;
    Result                   := lContasReceberModel;
  finally

  end;
end;

function TContasReceberModel.Excluir(pFatura: String): String;
begin
  self := self.carregaClasse(pFatura);

  self.validaExclusao;
  self.excluirVendaCartao;

  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

function TContasReceberModel.carregaClasse(pFatura: String): TContasReceberModel;
var
  lContasReceberDao: TContasReceberDao;
begin
  lContasReceberDao := TContasReceberDao.Create(vIConexao);
  try
    Result := lContasReceberDao.carregaClasse(pFatura);
  finally
    lContasReceberDao.Free;
  end;
end;

function TContasReceberModel.concluirContasReceber(pFatura: String): TConclusaoContasReceber;
var
  lContasReceberItensModel, lContasReceberitensAtualizar: TContasReceberItensModel;
  lPortadorModel : TPortadorModel;
  pHistorico,
  lConta : String;
begin

  lContasReceberItensModel      := TContasReceberItensModel.Create(vIConexao);
  lContasReceberitensAtualizar  := TContasReceberItensModel.Create(vIConexao);
  lPortadorModel                := TPortadorModel.Create(vIConexao);

  try
    lPortadorModel := lPortadorModel.carregaClasse(self.FCODIGO_POR);

    if not self.FRECEBIMENTO_CONCLUIDO then begin

      if lPortadorModel.TIPO = 'T' then
      begin
        Result := tcReceberTef;
        exit;
      end;

      if AnsiMatchStr(lPortadorModel.TPAG_NFE,['03','04']) then
      begin
        Result := tcReceberCartao;
        exit;
      end;

      if AnsiMatchStr(lPortadorModel.TPAG_NFE,['17']) and (lPortadorModel.PIX_CHAVE <> '') then
      begin
        Result := tcReceberPix;
        exit;
      end;
    end;

    if self.FCODIGO_POR = '777777' then
    begin
      if lContasReceberItensModel.parcelasAberta(pFatura) then
      begin
        Result := tcReceberEntrada;
        exit;
      end;
    end;

    lContasReceberItensModel.IDContasReceberView := pFatura;
    lContasReceberItensModel.WhereView           := '';
    lContasReceberItensModel.obterLista;

    for lContasReceberItensModel in lContasReceberItensModel.ContasReceberItenssLista do begin
      lContasReceberitensAtualizar := lContasReceberitensAtualizar.carregaClasse(VarToStr(lContasReceberItensModel.ID));

      lContasReceberitensAtualizar.IDUsuarioOperacao := self.vIConexao.getUSer.ID;

      if self.FIDAdmCartao <> '' then begin
        lContasReceberitensAtualizar.IDAdmCartao    := self.FIDAdmCartao;
        lContasReceberitensAtualizar.IDPedidoCartao := self.FPEDIDO_REC;
        lContasReceberitensAtualizar.gerarVendaCartao;
      end;

      lConta := IIF(lPortadorModel.RECEITA_CONTA_ID <> '', lPortadorModel.RECEITA_CONTA_ID , '888888');

      if self.FCODIGO_POR = '000004' then
      begin
        pHistorico := 'Venda N: '+ self.PEDIDO_REC +' '+ lPortadorModel.NOME_PORT;
        lContasReceberitensAtualizar.baixarCaixa(lContasReceberitensAtualizar.VLRPARCELA_REC, self.FCODIGO_POR, lConta, pHistorico);
      end;

      if self.FCODIGO_POR = '555555' then
        lContasReceberitensAtualizar.baixarCreditoCliente(lContasReceberitensAtualizar.VLRPARCELA_REC);

      lContasReceberitensAtualizar.Acao       := tacAlterar;
      lContasReceberitensAtualizar.VALOR_PAGO := lContasReceberitensAtualizar.VLRPARCELA_REC;
      lContasReceberitensAtualizar.Salvar;
    end;

    Result := tcConcluido;
  finally
    lContasReceberitensAtualizar.Free;
    lContasReceberItensModel.Free;
    lPortadorModel.Free;
  end;
end;

constructor TContasReceberModel.Create(pConexao : IConexao);
begin
  vIConexao := pConexao;
end;

destructor TContasReceberModel.Destroy;
begin
  inherited;
end;

procedure TContasReceberModel.excluirBaixa;
var
  lContasReceberItensModel,
  lItensExclusaoModel: TContasReceberItensModel;
  i: Integer;
begin
  if self.FFATURA_REC = '' then
    CriaException('Fatura não informada.');

  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);
  lItensExclusaoModel      := TContasReceberItensModel.Create(vIConexao);
  try
    lContasReceberItensModel.IDContasReceberView := self.FFATURA_REC;
    lContasReceberItensModel.obterLista;

    for i := 0 to lContasReceberItensModel.ContasReceberItenssLista.Count -1 do
    begin
      lItensExclusaoModel := lContasReceberItensModel.ContasReceberItenssLista[i];
      lItensExclusaoModel.excluirBaixa;
    end;

  finally
    lContasReceberItensModel.Free;
    lItensExclusaoModel.Free;
  end;
end;

procedure TContasReceberModel.excluirVendaCartao;
var
  lVendaCartaoModel: TVendaCartaoModel;
begin
  if self.FFATURA_REC = '' then
    CriaException('Fatura não informada.');

  lVendaCartaoModel := TVendaCartaoModel.Create(vIConexao);
  try
    lVendaCartaoModel.WhereView := ' and vendacartao.fatura_id = ' + QuotedStr(self.FFATURA_REC);
    lVendaCartaoModel.obterLista;

    for lVendaCartaoModel in lVendaCartaoModel.VendaCartaosLista do
    begin
      lVendaCartaoModel.Acao := tacExcluir;
      lVendaCartaoModel.Salvar;
    end;
  finally
    lVendaCartaoModel.Free;
  end;
end;

function TContasReceberModel.gerarChamadaTEF(pTefModalidade, pTefParcelamento, pTefAdquirente: String): String;
var
  lContasReceberItensDao: TContasReceberItensDao;
begin
  lContasReceberItensDao := TContasReceberItensDao.Create(vIConexao);
  try
    Result := lContasReceberItensDao.gerarChamadaTEF(self.FATURA_REC, pTefModalidade, pTefParcelamento, pTefAdquirente);
  finally
    lContasReceberItensDao.Free;
  end;
end;

procedure TContasReceberModel.obterContasReceberPedido;
var
  lContasReceberLista: TContasReceberDao;
begin
  lContasReceberLista := TContasReceberDao.Create(vIConexao);
  try
    lContasReceberLista.TotalRecords    := FTotalRecords;
    lContasReceberLista.WhereView       := FWhereView;
    lContasReceberLista.CountView       := FCountView;
    lContasReceberLista.OrderView       := FOrderView;
    lContasReceberLista.StartRecordView := FStartRecordView;
    lContasReceberLista.LengthPageView  := FLengthPageView;
    lContasReceberLista.IDRecordView    := FIDRecordView;
    lContasReceberLista.IDPedidoView    := FIDPedidoView;
    lContasReceberLista.obterContasReceberPedido;
    FTotalRecords  := lContasReceberLista.TotalRecords;
    FContasRecebersLista := lContasReceberLista.ContasRecebersLista;
  finally
    lContasReceberLista.Free;
  end;
end;

procedure TContasReceberModel.obterLista;
var
  lContasReceberLista: TContasReceberDao;
begin
  lContasReceberLista := TContasReceberDao.Create(vIConexao);
  try
    lContasReceberLista.TotalRecords    := FTotalRecords;
    lContasReceberLista.WhereView       := FWhereView;
    lContasReceberLista.CountView       := FCountView;
    lContasReceberLista.OrderView       := FOrderView;
    lContasReceberLista.StartRecordView := FStartRecordView;
    lContasReceberLista.LengthPageView  := FLengthPageView;
    lContasReceberLista.IDRecordView    := FIDRecordView;
    lContasReceberLista.IDPedidoView    := FIDPedidoView;
    lContasReceberLista.obterLista;
    FTotalRecords  := lContasReceberLista.TotalRecords;
    FContasRecebersLista := lContasReceberLista.ContasRecebersLista;
  finally
    lContasReceberLista.Free;
  end;
end;

function TContasReceberModel.pedidoContasReceber(pFatura: String): String;
var
  lContasReceberDao: TContasReceberDao;
begin
  lContasReceberDao := TContasReceberDao.Create(vIConexao);
  try
    Result := lContasReceberDao.pedidoContasReceber(pFatura);
  finally
    lContasReceberDao.Free;
  end;
end;

function TContasReceberModel.Salvar: String;
var
  lContasReceberDao: TContasReceberDao;
begin
  Result := '';
  if FAcao = tacExcluir then
    validaExclusao;

  lContasReceberDao := TContasReceberDao.Create(vIConexao);
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lContasReceberDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lContasReceberDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lContasReceberDao.excluir(Self);
    end;
  finally
    lContasReceberDao.Free;
  end;
end;

procedure TContasReceberModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TContasReceberModel.SetACRESCIMO(const Value: Variant);
begin
  FACRESCIMO := Value;
end;

procedure TContasReceberModel.SetAVALISTA(const Value: Variant);
begin
  FAVALISTA := Value;
end;

procedure TContasReceberModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasReceberModel.SetCENTERCOB(const Value: Variant);
begin
  FCENTERCOB := Value;
end;

procedure TContasReceberModel.SetCENTRO_CUSTO(const Value: Variant);
begin
  FCENTRO_CUSTO := Value;
end;

procedure TContasReceberModel.SetCODIGO_ANTERIOR(const Value: Variant);
begin
  FCODIGO_ANTERIOR := Value;
end;

procedure TContasReceberModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TContasReceberModel.SetCODIGO_CTA(const Value: Variant);
begin
  FCODIGO_CTA := Value;
end;

procedure TContasReceberModel.SetCODIGO_POR(const Value: Variant);
begin
  FCODIGO_POR := Value;
end;

procedure TContasReceberModel.SetCONDICOES_PAG(const Value: Variant);
begin
  FCONDICOES_PAG := Value;
end;

procedure TContasReceberModel.SetCONFERIDO(const Value: Variant);
begin
  FCONFERIDO := Value;
end;

procedure TContasReceberModel.SetDATAEMI_REC(const Value: Variant);
begin
  FDATAEMI_REC := Value;
end;

procedure TContasReceberModel.SetDATA_AGENDAMENTO(const Value: Variant);
begin
  FDATA_AGENDAMENTO := Value;
end;

procedure TContasReceberModel.SetDESENVOLVIMENTO_ID(const Value: Variant);
begin
  FDESENVOLVIMENTO_ID := Value;
end;

procedure TContasReceberModel.SetFATURA_REC(const Value: Variant);
begin
  FFATURA_REC := Value;
end;

procedure TContasReceberModel.SetFICHA_ID(const Value: Variant);
begin
  FFICHA_ID := Value;
end;

procedure TContasReceberModel.SetFUNCIONARIO_ID(const Value: Variant);
begin
  FFUNCIONARIO_ID := Value;
end;

procedure TContasReceberModel.SetContasRecebersLista;
begin
  FContasRecebersLista := Value;
end;

procedure TContasReceberModel.SetCONTRATO(const Value: Variant);
begin
  FCONTRATO := Value;
end;

procedure TContasReceberModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasReceberModel.SetIDAdmCartao(const Value: String);
begin
  FIDAdmCartao := Value;
end;

procedure TContasReceberModel.SetIDPedidoView(const Value: String);
begin
  FIDPedidoView := Value;
end;

procedure TContasReceberModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TContasReceberModel.SetIDUsuarioOperacao(const Value: String);
begin
  FIDUsuarioOperacao := Value;
end;

procedure TContasReceberModel.SetINDICE_JUROS_ID(const Value: Variant);
begin
  FINDICE_JUROS_ID := Value;
end;

procedure TContasReceberModel.SetJUROS_FIXO(const Value: Variant);
begin
  FJUROS_FIXO := Value;
end;

procedure TContasReceberModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasReceberModel.SetLOCACAO_ID(const Value: Variant);
begin
  FLOCACAO_ID := Value;
end;

procedure TContasReceberModel.SetLOCAL_BAIXA(const Value: Variant);
begin
  FLOCAL_BAIXA := Value;
end;

procedure TContasReceberModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TContasReceberModel.SetOBS_COMPLEMENTAR(const Value: Variant);
begin
  FOBS_COMPLEMENTAR := Value;
end;

procedure TContasReceberModel.SetOBS_REC(const Value: Variant);
begin
  FOBS_REC := Value;
end;

procedure TContasReceberModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasReceberModel.SetOS_REC(const Value: Variant);
begin
  FOS_REC := Value;
end;

procedure TContasReceberModel.SetRECEBIMENTO_CONCLUIDO(const Value: Boolean);
begin
  FRECEBIMENTO_CONCLUIDO := Value;
end;

procedure TContasReceberModel.SetPEDIDO_REC(const Value: Variant);
begin
  FPEDIDO_REC := Value;
end;

procedure TContasReceberModel.SetPEDIDO_SITE(const Value: Variant);
begin
  FPEDIDO_SITE := Value;
end;

procedure TContasReceberModel.SetPORTADOR_NOME(const Value: Variant);
begin
  FPORTADOR_NOME := Value;
end;

procedure TContasReceberModel.SetPRIMEIRO_VENC(const Value: Variant);
begin
  FPRIMEIRO_VENC := Value;
end;

procedure TContasReceberModel.SetSAIDA_REC(const Value: Variant);
begin
  FSAIDA_REC := Value;
end;

procedure TContasReceberModel.SetSITUACAO_REC(const Value: Variant);
begin
  FSITUACAO_REC := Value;
end;

procedure TContasReceberModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasReceberModel.SetSUB_ID(const Value: Variant);
begin
  FSUB_ID := Value;
end;

procedure TContasReceberModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TContasReceberModel.SetTIPO_REC(const Value: Variant);
begin
  FTIPO_REC := Value;
end;

procedure TContasReceberModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasReceberModel.SetTOTAL_PARCELAS(const Value: Variant);
begin
  FTOTAL_PARCELAS := Value;
end;

procedure TContasReceberModel.SetULTIMO_DIA_MES(const Value: Variant);
begin
  FULTIMO_DIA_MES := Value;
end;

procedure TContasReceberModel.SetUSUARIO_REC(const Value: Variant);
begin
  FUSUARIO_REC := Value;
end;

procedure TContasReceberModel.SetVALOR_PAGO(const Value: Variant);
begin
  FVALOR_PAGO := Value;
end;

procedure TContasReceberModel.SetVALOR_PARCELA(const Value: Variant);
begin
  FVALOR_PARCELA := Value;
end;

procedure TContasReceberModel.SetVALOR_REC(const Value: Variant);
begin
  FVALOR_REC := Value;
end;

procedure TContasReceberModel.SetVENDEDOR_REC(const Value: Variant);
begin
  FVENDEDOR_REC := Value;
end;

procedure TContasReceberModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;


procedure TContasReceberModel.validaExclusao;
var
  lPortadorModel           : TPortadorModel;
  lContasReceberItensModel : TContasReceberItensModel;
  lTefModel                : TTefModel;
begin
  if self.FCODIGO_POR = '' then
    CriaException('Informe o portador do contas a receber');

  if self.FATURA_REC = '' then
    CriaException('Informe a fatura do contas a receber');

  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);
  lPortadorModel           := TPortadorModel.Create(vIConexao);
  lTefModel                := TTefModel.Create(vIConexao);

  try
    lPortadorModel := lPortadorModel.carregaClasse(self.FCODIGO_POR);
    lContasReceberItensModel.IDContasReceberView := self.FATURA_REC;
    lContasReceberItensModel.WhereView := ' and contasreceberitens.valorrec_rec > 0 ';
    lContasReceberItensModel.obterLista;

    if (lPortadorModel.TPAG_NFE = '17') and (lContasReceberItensModel.TotalRecords > 0) then
      CriaException('Não é possível excluir pagamento realizado no PIX.');

    lTefModel.WhereView := ' and coalesce(tef.status, '''') <> ''X'' and tef.contasreceber_fatura = '+ QuotedStr(self.FFATURA_REC);
    lTefModel.obterLista;

    if lTefModel.TotalRecords > 0 then
      CriaException('Não é possível excluir pagamento realizado no TEF.');
  finally
    lContasReceberItensModel.free;
    lPortadorModel.free;
    lTefModel.free;
  end;
end;

end.
