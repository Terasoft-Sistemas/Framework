unit ContasReceberItensModel;
interface
uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Utils, FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TRecebimentoContasReceber = class
    private
      FVALOR: Variant;
      FTIPO: Variant;
      FORIGEM: Variant;
      FID: Variant;
      procedure SetTIPO(const Value: Variant);
      procedure SetVALOR(const Value: Variant);
      procedure SetORIGEM(const Value: Variant);
      procedure SetID(const Value: Variant);

    public
      property ID: Variant read FID write SetID;
      property TIPO: Variant read FTIPO write SetTIPO;
      property VALOR: Variant read FVALOR write SetVALOR;
      property ORIGEM: Variant read FORIGEM write SetORIGEM;
  end;

  TContasReceberItensModel = class
  private
    vIConexao : IConexao;

    FContasReceberItenssLista: TObjectList<TContasReceberItensModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FTEF_PARCELAMENTO: Variant;
    FVENCIMENTO_BOLETO: Variant;
    FOBS: Variant;
    FOBSERVACAO: Variant;
    FTEF_MODALIDADE: Variant;
    FTEF_CHAMADA: Variant;
    FVALOR_DESCONTO_CARTAO: Variant;
    FTOTALPARCELAS_REC: Variant;
    FPIX_IDENTIFICADOR: Variant;
    FFATURA_RECEBIDA_CARTAO: Variant;
    FPACELA_REC: Variant;
    FVALOR_PAGO: Variant;
    FDATABAIXA_REC: Variant;
    FTEF_ADQUIRENTE: Variant;
    FCODIGO_CON: Variant;
    FCODIGO_CLI: Variant;
    FPIX_EMV: Variant;
    FVENCIMENTO_REC: Variant;
    FID: Variant;
    FPOSICAO_ID: Variant;
    FPIX_EXPIRACAO: Variant;
    FVALOR_JUROS_CARTAO: Variant;
    FLOJA: Variant;
    FCOMISSAO: Variant;
    FFATURA_REC: Variant;
    FVAUCHER_CLIENTE_ID: Variant;
    FNF_FATURA: Variant;
    FCODIGO_POR: Variant;
    FVALORREC_REC: Variant;
    FCARTAO: Variant;
    FSYSTIME: Variant;
    FVALOR_RECEBIDO_CARTAO: Variant;
    FSITUACAO_REC: Variant;
    FDESTITULO_REC: Variant;
    FVLRPARCELA_REC: Variant;
    FUSUARIO_ACEITE: Variant;
    FCOMISSAO_BASE: Variant;
    FDATA_ACEITE: Variant;
    FNOSSO_NUMERO: Variant;
    FIDContasReceberView: String;
    FPORTADOR_NOME: Variant;
    FIDAdmCartao: String;
    FIDPedidoCartao: String;
    FIDUsuarioOperacao: String;
    FPEDIDO_REC: Variant;
    FCLIENTE_NOME: Variant;
    FRecebimentoContasReceberLista: TObjectList<TRecebimentoContasReceber>;
    FParcelaView: String;
    FNUMERO_PED: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetContasReceberItenssLista(const Value: TObjectList<TContasReceberItensModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCARTAO(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetCODIGO_CON(const Value: Variant);
    procedure SetCODIGO_POR(const Value: Variant);
    procedure SetCOMISSAO(const Value: Variant);
    procedure SetCOMISSAO_BASE(const Value: Variant);
    procedure SetDATA_ACEITE(const Value: Variant);
    procedure SetDATABAIXA_REC(const Value: Variant);
    procedure SetDESTITULO_REC(const Value: Variant);
    procedure SetFATURA_REC(const Value: Variant);
    procedure SetFATURA_RECEBIDA_CARTAO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetNF_FATURA(const Value: Variant);
    procedure SetNOSSO_NUMERO(const Value: Variant);
    procedure SetOBS(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetPACELA_REC(const Value: Variant);
    procedure SetPIX_EMV(const Value: Variant);
    procedure SetPIX_EXPIRACAO(const Value: Variant);
    procedure SetPIX_IDENTIFICADOR(const Value: Variant);
    procedure SetPOSICAO_ID(const Value: Variant);
    procedure SetSITUACAO_REC(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTEF_ADQUIRENTE(const Value: Variant);
    procedure SetTEF_CHAMADA(const Value: Variant);
    procedure SetTEF_MODALIDADE(const Value: Variant);
    procedure SetTEF_PARCELAMENTO(const Value: Variant);
    procedure SetTOTALPARCELAS_REC(const Value: Variant);
    procedure SetUSUARIO_ACEITE(const Value: Variant);
    procedure SetVALOR_DESCONTO_CARTAO(const Value: Variant);
    procedure SetVALOR_JUROS_CARTAO(const Value: Variant);
    procedure SetVALOR_PAGO(const Value: Variant);
    procedure SetVALOR_RECEBIDO_CARTAO(const Value: Variant);
    procedure SetVALORREC_REC(const Value: Variant);
    procedure SetVAUCHER_CLIENTE_ID(const Value: Variant);
    procedure SetVENCIMENTO_BOLETO(const Value: Variant);
    procedure SetVENCIMENTO_REC(const Value: Variant);
    procedure SetVLRPARCELA_REC(const Value: Variant);
    procedure SetIDContasReceberView(const Value: String);
    procedure SetPORTADOR_NOME(const Value: Variant);
    procedure SetIDAdmCartao(const Value: String);
    procedure SetIDPedidoCartao(const Value: String);
    procedure SetIDUsuarioOperacao(const Value: String);
    procedure SetPEDIDO_REC(const Value: Variant);
    procedure SetCLIENTE_NOME(const Value: Variant);
    procedure SetRecebimentoContasReceberLista(
    const Value: TObjectList<TRecebimentoContasReceber>);
    procedure SetParcelaView(const Value: String);
    procedure SetNUMERO_PED(const Value: Variant);

  public
    property ID: Variant read FID write SetID;
    property FATURA_REC: Variant read FFATURA_REC write SetFATURA_REC;
    property CODIGO_CLI: Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property POSICAO_ID: Variant read FPOSICAO_ID write SetPOSICAO_ID;
    property VENCIMENTO_REC: Variant read FVENCIMENTO_REC write SetVENCIMENTO_REC;
    property PACELA_REC: Variant read FPACELA_REC write SetPACELA_REC;
    property VLRPARCELA_REC: Variant read FVLRPARCELA_REC write SetVLRPARCELA_REC;
    property VALORREC_REC: Variant read FVALORREC_REC write SetVALORREC_REC;
    property DATABAIXA_REC: Variant read FDATABAIXA_REC write SetDATABAIXA_REC;
    property SITUACAO_REC: Variant read FSITUACAO_REC write SetSITUACAO_REC;
    property TOTALPARCELAS_REC: Variant read FTOTALPARCELAS_REC write SetTOTALPARCELAS_REC;
    property CODIGO_POR: Variant read FCODIGO_POR write SetCODIGO_POR;
    property CODIGO_CON: Variant read FCODIGO_CON write SetCODIGO_CON;
    property DESTITULO_REC: Variant read FDESTITULO_REC write SetDESTITULO_REC;
    property NOSSO_NUMERO: Variant read FNOSSO_NUMERO write SetNOSSO_NUMERO;
    property CARTAO: Variant read FCARTAO write SetCARTAO;
    property OBSERVACAO: Variant read FOBSERVACAO write SetOBSERVACAO;
    property VENCIMENTO_BOLETO: Variant read FVENCIMENTO_BOLETO write SetVENCIMENTO_BOLETO;
    property COMISSAO: Variant read FCOMISSAO write SetCOMISSAO;
    property COMISSAO_BASE: Variant read FCOMISSAO_BASE write SetCOMISSAO_BASE;
    property LOJA: Variant read FLOJA write SetLOJA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property DATA_ACEITE: Variant read FDATA_ACEITE write SetDATA_ACEITE;
    property USUARIO_ACEITE: Variant read FUSUARIO_ACEITE write SetUSUARIO_ACEITE;
    property VALOR_PAGO: Variant read FVALOR_PAGO write SetVALOR_PAGO;
    property NF_FATURA: Variant read FNF_FATURA write SetNF_FATURA;
    property OBS: Variant read FOBS write SetOBS;
    property VAUCHER_CLIENTE_ID: Variant read FVAUCHER_CLIENTE_ID write SetVAUCHER_CLIENTE_ID;
    property VALOR_DESCONTO_CARTAO: Variant read FVALOR_DESCONTO_CARTAO write SetVALOR_DESCONTO_CARTAO;
    property VALOR_RECEBIDO_CARTAO: Variant read FVALOR_RECEBIDO_CARTAO write SetVALOR_RECEBIDO_CARTAO;
    property FATURA_RECEBIDA_CARTAO: Variant read FFATURA_RECEBIDA_CARTAO write SetFATURA_RECEBIDA_CARTAO;
    property VALOR_JUROS_CARTAO: Variant read FVALOR_JUROS_CARTAO write SetVALOR_JUROS_CARTAO;
    property TEF_CHAMADA: Variant read FTEF_CHAMADA write SetTEF_CHAMADA;
    property TEF_MODALIDADE: Variant read FTEF_MODALIDADE write SetTEF_MODALIDADE;
    property TEF_PARCELAMENTO: Variant read FTEF_PARCELAMENTO write SetTEF_PARCELAMENTO;
    property TEF_ADQUIRENTE: Variant read FTEF_ADQUIRENTE write SetTEF_ADQUIRENTE;
    property PIX_IDENTIFICADOR: Variant read FPIX_IDENTIFICADOR write SetPIX_IDENTIFICADOR;
    property PIX_EMV: Variant read FPIX_EMV write SetPIX_EMV;
    property PIX_EXPIRACAO: Variant read FPIX_EXPIRACAO write SetPIX_EXPIRACAO;
    property PORTADOR_NOME: Variant read FPORTADOR_NOME write SetPORTADOR_NOME;
    property PEDIDO_REC: Variant read FPEDIDO_REC write SetPEDIDO_REC;
    property CLIENTE_NOME: Variant read FCLIENTE_NOME write SetCLIENTE_NOME;
    property NUMERO_PED: Variant read FNUMERO_PED write SetNUMERO_PED;

  	constructor Create(pConexao: IConexao);
    destructor Destroy; override;
    function Salvar  : String;
    function Incluir : String;
    function Alterar(pID : String) : TContasReceberItensModel;
    function Excluir(pID : String) : String;
    procedure obterLista;
    procedure obterRecebimentoContasReceber;

    function carregaClasse(pId: String; pLoja: String = ''): TContasReceberItensModel;
    function carregaClasseIndexOf(pIndex: Integer): TContasReceberItensModel;

    function obterContaCliente(pContaClienteParametros: TContaClienteParametros): TListaContaClienteRetorno;
    function obterReceberPixCobranca(pPedido : String) : IFDDataset;

    procedure gerarVendaCartao;
    procedure excluirBaixa;

    function lancarContaCorrente(pValor, pPortador, pConta, pContaCorrente, pHistorico, pTipo: String) : String;
    function lancarJurosContaCorrente(pJuros, pPortador : String) : String;

    function baixarCaixa(pValor, pPortador, pConta, pHistorico : String): String;
    function baixarJurosCaixa(pJuros, pPortador, pHistorico : String) : String;

    function baixarContaCorrente(pValor, pPortador, pContaCorrente, pHistorico: String): String;
    function baixarPix(pValor, pPortador, pContaCorrente, pValorTaxa, pContaTaxa: String): String;
    function baixar(pValor: String): String;
    function baixarCreditoCliente(pValor: Double) : Boolean;

    function recebimentoCartao(pValor, pIdAdmCartao, pVencimento: String; pIdTef: String = ''): String;
    function gerarContasReceberCartao(pValor, pPortador, pIdAdmCartao, pObs, pObsComprementar: String; pParcelas: Integer): String;
    function parcelasAberta(pFatura: String): Boolean;

    function gerarContasReceberRecebimento(pValor, pParcela, pPortador, pConta, pObs : String) : String;

    function valorAberto(pCliente : String) : Double;

    property ContasReceberItenssLista: TObjectList<TContasReceberItensModel> read FContasReceberItenssLista write SetContasReceberItenssLista;
    property RecebimentoContasReceberLista: TObjectList<TRecebimentoContasReceber> read FRecebimentoContasReceberLista write SetRecebimentoContasReceberLista;

   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDContasReceberView: String read FIDContasReceberView write SetIDContasReceberView;
    property IDPedidoCartao: String read FIDPedidoCartao write SetIDPedidoCartao;
    property IDAdmCartao: String read FIDAdmCartao write SetIDAdmCartao;
    property IDUsuarioOperacao: String read FIDUsuarioOperacao write SetIDUsuarioOperacao;
    property ParcelaView: String read FParcelaView write SetParcelaView;
  end;

  const
    cCENTRO_CUSTO_PADRAO = '000000';
    cTIPO_DEBITO         = 'D';
    cTIPO_CREDITO        = 'C';

implementation

uses
  ContasReceberItensDao,
  VendaCartaoModel,
  System.SysUtils,
  CaixaModel,
  RecebimentoCartaoModel,
  AdmCartaoModel,
  ContasReceberModel,
  ContaCorrenteModel,
  CreditoClienteModel,
  CreditoClienteUsoModel;

{ TContasReceberItensModel }

function TContasReceberItensModel.Alterar(pID: String): TContasReceberItensModel;
var
  lContasReceberItensModel : TContasReceberItensModel;
begin
  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);
  try
    lContasReceberItensModel      := lContasReceberItensModel.carregaClasse(pID);
    lContasReceberItensModel.Acao := tacAlterar;
    Result                        := lContasReceberItensModel;
  finally

  end;
end;

function TContasReceberItensModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

function TContasReceberItensModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TContasReceberItensModel.baixar(pValor: String): String;
begin
  self.FAcao           := tacAlterar;

  if (StrToFloat(self.FVALORREC_REC) + StrToFloat(pValor)) > StrToFloat(self.VLRPARCELA_REC) then
    self.FVALORREC_REC := self.VLRPARCELA_REC
  else
    self.FVALORREC_REC := FloatToStr(StrToFloat(self.FVALORREC_REC) + StrToFloat(pValor));

  self.FDATABAIXA_REC  := DateToStr(vIConexao.DataServer);

  if StrToFloat(self.FVALORREC_REC) >= StrToFloat(self.VLRPARCELA_REC) then
    self.FSITUACAO_REC := 'B';

  self.Salvar;
end;

function TContasReceberItensModel.baixarCaixa(pValor, pPortador, pConta, pHistorico: String): String;
var
  lCaixaModel: TCaixaModel;
begin
  lCaixaModel := TCaixaModel.Create(vIConexao);
  try
    lCaixaModel.Acao := tacIncluir;
    lCaixaModel.USUARIO_CAI     := self.vIConexao.getUSer.ID;
    lCaixaModel.DATA_CAI        := DateToStr(vIConexao.DataServer);
    lCaixaModel.HORA_CAI        := TimeToStr(vIConexao.HoraServer);
    lCaixaModel.NUMERO_PED      := self.NUMERO_PED;
    lCaixaModel.CONCILIADO_CAI  := '.';
    lCaixaModel.TIPO            := 'V';
    lCaixaModel.CODIGO_CTA      := pConta;
    lCaixaModel.CLIENTE_CAI     := self.FCODIGO_CLI;
    lCaixaModel.TIPO_CAI        := cTIPO_CREDITO;
    lCaixaModel.FATURA_CAI      := self.FFATURA_REC;
    lCaixaModel.PARCELA_CAI     := self.FPACELA_REC;
    lCaixaModel.STATUS          := 'I';
    lCaixaModel.LOJA_REMOTO     := self.FLOJA;
    lCaixaModel.CENTRO_CUSTO    := cCENTRO_CUSTO_PADRAO;
    lCaixaModel.PORTADOR_CAI    := pPortador;
    lCaixaModel.VALOR_CAI       := pValor;
    lCaixaModel.HISTORICO_CAI   := pHistorico;
    lCaixaModel.COMPETENCIA     := copy(self.VENCIMENTO_REC, 4, 2) + copy(self.VENCIMENTO_REC, 7, 4);
    Result := lCaixaModel.Salvar;

    self.baixar(pValor);

  finally
    lCaixaModel.Free;
  end;
end;

function TContasReceberItensModel.baixarContaCorrente(pValor, pPortador, pContaCorrente, pHistorico: String): String;
var
  lContasReceberModel: TContasReceberModel;
begin
  lContasReceberModel := TContasReceberModel.Create(vIConexao);
  try
    lContasReceberModel := lContasReceberModel.carregaClasse(self.FFATURA_REC);
    self.lancarContaCorrente(pValor, pPortador, lContasReceberModel.CODIGO_CTA, pContaCorrente, pHistorico, 'C');
    self.baixar(pValor);
  finally
    lContasReceberModel.Free;
  end;
end;

function TContasReceberItensModel.baixarCreditoCliente(pValor: Double): Boolean;
var
  lCreditoClienteUsoModel : TCreditoClienteUsoModel;
  lCreditoClienteModel,
  lCreditos               : TCreditoClienteModel;
  lRestante,
  lBaixa                  : Double;
begin
  lCreditoClienteUsoModel := TCreditoClienteUsoModel.Create(vIConexao);
  lCreditoClienteModel    := TCreditoClienteModel.Create(vIConexao);
  lRestante := pValor;

  try
    lCreditoClienteModel.creditosAbertos(self.FCODIGO_CLI);

    for lCreditos in lCreditoClienteModel.CreditoClientesLista do
    begin
      if lRestante = 0 then
        Break;

      if lCreditos.valor > lRestante then
      begin
        lBaixa    := lRestante;
        lRestante := 0;
      end
      else
      begin
        lBaixa    := lCreditos.valor;
        lRestante := lRestante - lBaixa;
      end;

      if lBaixa > 0 then
      begin
        lCreditoClienteUsoModel.Acao := tacIncluir;
        lCreditoClienteUsoModel.USUARIO_ID           := self.vIConexao.getUSer.ID;
        lCreditoClienteUsoModel.DATAHORA             := DateToStr(vIConexao.DataServer) + ' ' + TimeToStr(vIConexao.HoraServer);
        lCreditoClienteUsoModel.CREDITO_CLIENTE_ID   := lCreditos.id;
        lCreditoClienteUsoModel.DATA                 := DateToStr(vIConexao.DataServer);
        lCreditoClienteUsoModel.PARCELA              := self.PACELA_REC;
        lCreditoClienteUsoModel.RECEBER_ID           := self.FATURA_REC;
        lCreditoClienteUsoModel.VALOR                := FloatToStr(lBaixa);
        lCreditoClienteUsoModel.Salvar;
        self.baixar(lBaixa.ToString);
      end;
    end;

  finally
    lCreditoClienteUsoModel.Free;
    lCreditoClienteModel.Free;
  end;
end;

function TContasReceberItensModel.baixarJurosCaixa(pJuros, pPortador, pHistorico: String): String;
var
  lCaixaModel: TCaixaModel;
begin
  lCaixaModel := TCaixaModel.Create(vIConexao);
  try
    lCaixaModel.Acao := tacIncluir;
    lCaixaModel.USUARIO_CAI     := self.vIConexao.getUSer.ID;
    lCaixaModel.DATA_CAI        := DateToStr(vIConexao.DataServer);
    lCaixaModel.HORA_CAI        := TimeToStr(vIConexao.HoraServer);
    lCaixaModel.TIPO            := 'S';
    lCaixaModel.CODIGO_CTA      := '222222';
    lCaixaModel.CLIENTE_CAI     := self.FCODIGO_CLI;
    lCaixaModel.TIPO_CAI        := cTIPO_CREDITO;
    lCaixaModel.FATURA_CAI      := self.FFATURA_REC;
    lCaixaModel.PARCELA_CAI     := self.FPACELA_REC;
    lCaixaModel.STATUS          := 'A';
    lCaixaModel.LOJA_REMOTO     := self.FLOJA;
    lCaixaModel.PORTADOR_CAI    := pPortador;
    lCaixaModel.VALOR_CAI       := pJuros;
    lCaixaModel.HISTORICO_CAI   := pHistorico;
    lCaixaModel.COMPETENCIA     := copy(self.VENCIMENTO_REC, 4, 2) + copy(self.VENCIMENTO_REC, 7, 4);

    Result := lCaixaModel.Salvar;

  finally
    lCaixaModel.Free;
  end;
end;

function TContasReceberItensModel.lancarJurosContaCorrente(pJuros, pPortador : String) : String;
var
  lContaCorrenteModel : TContaCorrenteModel;
  lContasReceberModel : TContasReceberModel;
begin
  lContaCorrenteModel := TContaCorrenteModel.Create(vIConexao);
  lContasReceberModel := TContasReceberModel.Create(vIConexao);

  try
    lContasReceberModel := lContasReceberModel.carregaClasse(self.FFATURA_REC);

    lContaCorrenteModel.Acao           := tacIncluir;
    lContaCorrenteModel.CONCILIADO_COR := '.';
    lContaCorrenteModel.USUARIO_COR    := self.vIConexao.getUSer.ID;
    lContaCorrenteModel.CENTRO_CUSTO   := cCENTRO_CUSTO_PADRAO;
    lContaCorrenteModel.DR             := 'N';
    lContaCorrenteModel.DATA_COR       := DateToStr(vIConexao.DataServer);
    lContaCorrenteModel.CODIGO_CTA     := '222222';
    lContaCorrenteModel.VALOR_COR      := pJuros;
    lContaCorrenteModel.OBSERVACAO_COR := 'Juros: '+ self.PACELA_REC+'/'+self.TOTALPARCELAS_REC+' PED: '+lContasReceberModel.PEDIDO_REC;
    lContaCorrenteModel.CLIENTE_COR    := self.FCODIGO_CLI;
    lContaCorrenteModel.FATURA_COR     := self.FFATURA_REC;
    lContaCorrenteModel.PARCELA_COR    := self.FPACELA_REC;
    lContaCorrenteModel.TIPO_CTA       := cTIPO_CREDITO;
    lContaCorrenteModel.LOJA           := self.FLOJA;
    lContaCorrenteModel.PORTADOR_COR   := pPortador;
    lContaCorrenteModel.STATUS         := 'I';
    lContaCorrenteModel.TIPO           := 'S';

    Result := lContaCorrenteModel.Salvar;
  finally
    lContaCorrenteModel.Free;
    lContasReceberModel.Free;
  end;
end;

function TContasReceberItensModel.baixarPix(pValor, pPortador, pContaCorrente, pValorTaxa, pContaTaxa: String): String;
var
  lHistorico: String;
  lContaCorrenteModel: TContaCorrenteModel;
  lContasReceberModel: TContasReceberModel;
begin
  lContaCorrenteModel := TContaCorrenteModel.Create(vIConexao);
  lContasReceberModel := TContasReceberModel.Create(vIConexao);
  try
    lContasReceberModel := lContasReceberModel.carregaClasse(self.FFATURA_REC);

    lHistorico := 'FC PIX: '+ self.FPACELA_REC+'/'+self.FTOTALPARCELAS_REC+' PED: '+lContasReceberModel.PEDIDO_REC;

    Result := self.lancarContaCorrente(pValor, pPortador, lContasReceberModel.CODIGO_CTA, pContaCorrente, lHistorico, 'C');
              self.lancarContaCorrente(pValorTaxa, pPortador, pContaTaxa, pContaCorrente, 'TAXA '+lHistorico, 'D');

    self.baixar(pValor);
  finally
    lContaCorrenteModel.Free;
    lContasReceberModel.Free;
  end;
end;

function TContasReceberItensModel.carregaClasse(pId: String; pLoja: String = ''): TContasReceberItensModel;
var
  lContasReceberItensDao: TContasReceberItensDao;
begin
  lContasReceberItensDao := TContasReceberItensDao.Create(vIConexao);
  try
    Result := lContasReceberItensDao.carregaClasse(pId, pLoja);
  finally
    lContasReceberItensDao.Free;
  end;
end;

function TContasReceberItensModel.carregaClasseIndexOf(pIndex: Integer): TContasReceberItensModel;
begin
  if pIndex < 0 then
    CriaException('Index não definido');
  Result := FContasReceberItenssLista[pIndex];
end;

constructor TContasReceberItensModel.Create(pConexao : IConexao);
begin
  vIConexao := pConexao;
end;

destructor TContasReceberItensModel.Destroy;
begin
  FreeAndNil(FContasReceberItenssLista);
  vIConexao := nil;
  inherited;
end;

procedure TContasReceberItensModel.excluirBaixa;
var
  lCaixaModel: TCaixaModel;
  lVendaCartaoModel, lVendaCartaoExclusao: TVendaCartaoModel;
  lRecebimentoCartaoModel, lRecebimentoExclusao: TRecebimentoCartaoModel;
  i: Integer;
begin
  lCaixaModel             := TCaixaModel.Create(vIConexao);
  lVendaCartaoModel       := TVendaCartaoModel.Create(vIConexao);
  lVendaCartaoExclusao    := TVendaCartaoModel.Create(vIConexao);
  lRecebimentoCartaoModel := TRecebimentoCartaoModel.Create(vIConexao);
  lRecebimentoExclusao    := TRecebimentoCartaoModel.Create(vIConexao);

  try
    lCaixaModel.WhereView := ' and caixa.status <> ''X'' '+
                             ' and caixa.fatura_cai = '+QuotedStr(self.FFATURA_REC) +
                             ' and caixa.parcela_cai = '+ self.FPACELA_REC;
    lCaixaModel.obterLista;

    for i := 0 to lCaixaModel.CaixasLista.Count -1 do
    begin
      lCaixaModel.excluirRegistro(lCaixaModel.CaixasLista[i].NUMERO_CAI);
    end;

    lVendaCartaoModel.WhereView := ' and vendacartao.numero_venda = ' + QuotedStr(self.FPEDIDO_REC) +
                                   ' and vendacartao.parcela_car = '+ self.FPACELA_REC;
    lVendaCartaoModel.obterLista;
    for i := 0 to lVendaCartaoModel.VendaCartaosLista.Count -1 do
    begin
      lVendaCartaoExclusao := lVendaCartaoModel.VendaCartaosLista[i];
      lVendaCartaoExclusao.Acao := tacExcluir;
      lVendaCartaoExclusao.Salvar;
    end;

    lRecebimentoCartaoModel.WhereView := ' and recebimento_cartao.fatura  = ' + QuotedStr(self.FFATURA_REC) +
                                         ' and recebimento_cartao.parcela = ' + self.FPACELA_REC;

    lRecebimentoCartaoModel.obterLista;

    for i := 0 to lRecebimentoCartaoModel.RecebimentoCartaosLista.Count -1 do
    begin
      lRecebimentoExclusao := lRecebimentoCartaoModel.RecebimentoCartaosLista[i];

      lRecebimentoExclusao.Acao := tacExcluir;
      lRecebimentoExclusao.Salvar;
    end;

  finally
    lRecebimentoCartaoModel.Free;
    lRecebimentoExclusao.Free;
    lVendaCartaoExclusao.Free;
    lVendaCartaoModel.Free;
    lCaixaModel.Free;
  end;
end;

function TContasReceberItensModel.gerarContasReceberCartao(pValor, pPortador, pIdAdmCartao, pObs, pObsComprementar: String; pParcelas: Integer): String;
var
  lContasReceberModel: TContasReceberModel;
  lContasReceberItensInserir, lModel: TContasReceberItensModel;
  lAdmCartaoModel: TAdmCartaoModel;
  lFaturaReceber: String;
  lValorParcela: Double;
  lVencimento: TDate;
  i: Integer;
begin
  lContasReceberItensInserir := TContasReceberItensModel.Create(vIConexao);
  lContasReceberModel        := TContasReceberModel.Create(vIConexao);
  lAdmCartaoModel            := TAdmCartaoModel.Create(vIConexao);

  try
    lContasReceberModel := lContasReceberModel.carregaClasse(self.FFATURA_REC);

    lAdmCartaoModel.IDRecordView := StrToInt(pIdAdmCartao);
    lAdmCartaoModel.obterLista;

    lContasReceberModel.Acao              := tacIncluir;
    lContasReceberModel.LOJA              := self.FLOJA;
    lContasReceberModel.PEDIDO_REC        := '999999';
    lContasReceberModel.CODIGO_CLI        := self.FCODIGO_CLI;
    lContasReceberModel.DATAEMI_REC       := DateToStr(vIConexao.DataServer);
    lContasReceberModel.VALOR_REC         := pValor;
    lContasReceberModel.SITUACAO_REC      := 'A';
    lContasReceberModel.VENDEDOR_REC      := lContasReceberModel.VENDEDOR_REC;
    lContasReceberModel.USUARIO_REC       := self.vIConexao.getUSer.ID;
    lContasReceberModel.TIPO_REC          := 'R';
    lContasReceberModel.CODIGO_POR        := pPortador;
    lContasReceberModel.JUROS_FIXO        := lContasReceberModel.JUROS_FIXO;
    lContasReceberModel.CODIGO_CTA        := '555555';
    lContasReceberModel.OBS_REC           := pObs;
    lContasReceberModel.OBS_COMPLEMENTAR  := pObsComprementar;
    lFaturaReceber := lContasReceberModel.Salvar;
    lValorParcela  := StrToFloat(pValor) / pParcelas;
    lVencimento    := vIConexao.DataServer + lAdmCartaoModel.AdmCartaosLista[0].PARCELADO_ADM;
    lContasReceberItensInserir.ContasReceberItenssLista := TObjectList<TContasReceberItensModel>.Create;
    lContasReceberItensInserir.Acao := tacIncluir;

    for i := 0 to Pred(pParcelas) do
    begin
      lContasReceberItensInserir.ContasReceberItenssLista.Add(TContasReceberItensModel.Create(vIConexao));
      lContasReceberItensInserir.ContasReceberItenssLista[i].FATURA_REC         := lFaturaReceber;
      lContasReceberItensInserir.ContasReceberItenssLista[i].CODIGO_POR         := pPortador;
      lContasReceberItensInserir.ContasReceberItenssLista[i].CODIGO_CLI         := self.FCODIGO_CLI;
      lContasReceberItensInserir.ContasReceberItenssLista[i].SITUACAO_REC       := 'A';
      lContasReceberItensInserir.ContasReceberItenssLista[i].VALORREC_REC       := '0';
      lContasReceberItensInserir.ContasReceberItenssLista[i].VALOR_PAGO         := '0';
      lContasReceberItensInserir.ContasReceberItenssLista[i].LOJA               := self.FLOJA;
      lContasReceberItensInserir.ContasReceberItenssLista[i].VLRPARCELA_REC     := lValorParcela.ToString;
      lContasReceberItensInserir.ContasReceberItenssLista[i].PACELA_REC         := (i + 1).ToString;
      lContasReceberItensInserir.ContasReceberItenssLista[i].TOTALPARCELAS_REC  := pParcelas.ToString;
      if i > 0 then
        lVencimento := IncMonth(lVencimento,1);
      lContasReceberItensInserir.ContasReceberItenssLista[i].VENCIMENTO_REC := DateToStr(lVencimento);
    end;

    lContasReceberItensInserir.Salvar;
    lContasReceberItensInserir.IDContasReceberView := lFaturaReceber;
    lContasReceberItensInserir.obterLista;

    for lModel in lContasReceberItensInserir.ContasReceberItenssLista do
    begin
      lModel.IDAdmCartao    := pIdAdmCartao;
      lModel.IDPedidoCartao := lContasReceberModel.PEDIDO_REC;
      lModel.gerarVendaCartao;
    end;

    self.Acao := tacAlterar;

    if (self.FVALORREC_REC + StrToFloat(pValor)) > self.VLRPARCELA_REC then
      self.FVALORREC_REC         := self.VLRPARCELA_REC
    else
      self.FVALORREC_REC         := FloatToStr(self.FVALORREC_REC + StrToFloat(pValor));

    self.FVALOR_RECEBIDO_CARTAO  := pValor;
    self.FFATURA_RECEBIDA_CARTAO := lFaturaReceber;
    self.FDATABAIXA_REC          := DateToStr(vIConexao.DataServer);

    if StrToFloat(self.FVALORREC_REC) >= StrToFloat(self.VLRPARCELA_REC) then
      self.FSITUACAO_REC := 'B';

    self.Salvar;

    Result := lFaturaReceber;
  finally
    lContasReceberItensInserir.Free;
    lContasReceberModel.Free;
    lAdmCartaoModel.Free;
  end;
end;

function TContasReceberItensModel.gerarContasReceberRecebimento(pValor, pParcela, pPortador, pConta, pObs : String): String;
var
  lContasReceberModel : TContasReceberModel;
  lContasReceberItensInserir,
  lModel              : TContasReceberItensModel;
  lFaturaReceber      : String;
  lValorParcela       : Double;
  lVencimento         : TDate;
  i : Integer;
begin
  lContasReceberItensInserir := TContasReceberItensModel.Create(vIConexao);
  lContasReceberModel        := TContasReceberModel.Create(vIConexao);

  try
    lContasReceberModel := lContasReceberModel.carregaClasse(self.FFATURA_REC);

    lContasReceberModel.Acao              := tacIncluir;
    lContasReceberModel.LOJA              := self.FLOJA;
    lContasReceberModel.PEDIDO_REC        := '999999';
    lContasReceberModel.CODIGO_CLI        := self.FCODIGO_CLI;
    lContasReceberModel.DATAEMI_REC       := DateToStr(vIConexao.DataServer);
    lContasReceberModel.VALOR_REC         := pValor;
    lContasReceberModel.SITUACAO_REC      := 'A';
    lContasReceberModel.TIPO_REC          := 'R';
    lContasReceberModel.CODIGO_POR        := pPortador;
    lContasReceberModel.JUROS_FIXO        := lContasReceberModel.JUROS_FIXO;
    lContasReceberModel.CENTRO_CUSTO      := '000030';
    lContasReceberModel.CODIGO_CTA        := '555555';
    lContasReceberModel.OBS_REC           := 'CONTA CLIENTE';
    lContasReceberModel.OBS_COMPLEMENTAR  := pObs;

    lFaturaReceber := lContasReceberModel.Salvar;
    lValorParcela  := StrToFloat(pValor) / pParcela.ToInteger;
    lVencimento    := vIConexao.DataServer;

    lContasReceberItensInserir.ContasReceberItenssLista := TObjectList<TContasReceberItensModel>.Create;
    lContasReceberItensInserir.Acao := tacIncluir;

    for i := 0 to Pred(pParcela.ToInteger) do
    begin
      lContasReceberItensInserir.ContasReceberItenssLista.Add(TContasReceberItensModel.Create(vIConexao));

      lContasReceberItensInserir.ContasReceberItenssLista[i].FATURA_REC         := lFaturaReceber;
      lContasReceberItensInserir.ContasReceberItenssLista[i].CODIGO_POR         := pPortador;
      lContasReceberItensInserir.ContasReceberItenssLista[i].CODIGO_CLI         := self.FCODIGO_CLI;
      lContasReceberItensInserir.ContasReceberItenssLista[i].SITUACAO_REC       := 'A';
      lContasReceberItensInserir.ContasReceberItenssLista[i].VALORREC_REC       := '0';
      lContasReceberItensInserir.ContasReceberItenssLista[i].VALOR_PAGO         := pValor;
      lContasReceberItensInserir.ContasReceberItenssLista[i].LOJA               := self.FLOJA;
      lContasReceberItensInserir.ContasReceberItenssLista[i].VLRPARCELA_REC     := lValorParcela.ToString;
      lContasReceberItensInserir.ContasReceberItenssLista[i].PACELA_REC         := (i + 1).ToString;
      lContasReceberItensInserir.ContasReceberItenssLista[i].TOTALPARCELAS_REC  := pParcela;

      if i > 0 then
        lVencimento := IncMonth(lVencimento, 1);
      lContasReceberItensInserir.ContasReceberItenssLista[i].VENCIMENTO_REC := DateToStr(lVencimento);
    end;

    lContasReceberItensInserir.Salvar;
    lContasReceberItensInserir.IDContasReceberView := lFaturaReceber;
    lContasReceberItensInserir.obterLista;

    self.Acao := tacAlterar;
    self.FVALORREC_REC           := FloatToStr(self.FVALORREC_REC + StrToFloat(pValor));
    self.FDATABAIXA_REC          := DateToStr(vIConexao.DataServer);

    if StrToFloat(self.FVALORREC_REC) >= StrToFloat(self.VLRPARCELA_REC) then
      self.FSITUACAO_REC := 'B';

    self.Salvar;

    Result := lFaturaReceber;
  finally
    lContasReceberItensInserir.Free;
    lContasReceberModel.Free;
  end;
end;

procedure TContasReceberItensModel.gerarVendaCartao;
var
  lVendaCartaoModel : TVendaCartaoModel;
begin
  if self.FIDAdmCartao = '' then
    CriaException('ID do cartão não informado');
  if self.FIDPedidoCartao = '' then
    CriaException('ID do pedido não informado');
  lVendaCartaoModel := TVendaCartaoModel.Create(vIConexao);
  try
    lVendaCartaoModel.Acao := tacIncluir;
    lVendaCartaoModel.NUMERO_CAR      := '1';
    lVendaCartaoModel.AUTORIZACAO_CAR := '1';
    lVendaCartaoModel.FATURA_ID       := self.FFATURA_REC;
    lVendaCartaoModel.PARCELA_CAR     := self.FPACELA_REC;
    lVendaCartaoModel.PARCELAS_CAR    := self.FTOTALPARCELAS_REC;
    lVendaCartaoModel.PARCELA_TEF     := self.FPACELA_REC;
    lVendaCartaoModel.PARCELAS_TEF    := self.FTOTALPARCELAS_REC;
    lVendaCartaoModel.VALOR_CAR       := self.FVLRPARCELA_REC;
    lVendaCartaoModel.CODIGO_CLI      := self.FCODIGO_CLI;
    lVendaCartaoModel.NUMERO_VENDA    := self.FIDPedidoCartao;
    lVendaCartaoModel.ADM_CAR         := self.FIDAdmCartao;
    lVendaCartaoModel.VENCIMENTO_CAR  := self.FVENCIMENTO_REC;
    lVendaCartaoModel.VENDA_CAR       := DateToStr(vIConexao.DataServer);
    lVendaCartaoModel.LOJA            := self.FLOJA;
    lVendaCartaoModel.Salvar;
  finally
    lVendaCartaoModel.Free;
  end;
end;

function TContasReceberItensModel.lancarContaCorrente(pValor, pPortador, pConta, pContaCorrente, pHistorico, pTipo: String): String;
var
  lContaCorrenteModel: TContaCorrenteModel;
begin
  lContaCorrenteModel := TContaCorrenteModel.Create(vIConexao);
  try
    lContaCorrenteModel.Acao           := tacIncluir;
    lContaCorrenteModel.CONCILIADO_COR := '.';
    lContaCorrenteModel.USUARIO_COR    := self.vIConexao.getUSer.ID;
    lContaCorrenteModel.CENTRO_CUSTO   := cCENTRO_CUSTO_PADRAO;
    lContaCorrenteModel.DR             := 'N';
    lContaCorrenteModel.DATA_COR       := DateToStr(vIConexao.DataServer);
    lContaCorrenteModel.CODIGO_CTA     := pConta;
    lContaCorrenteModel.VALOR_COR      := pValor;
    lContaCorrenteModel.OBSERVACAO_COR := pHistorico;
    lContaCorrenteModel.CLIENTE_COR    := self.FCODIGO_CLI;
    lContaCorrenteModel.FATURA_COR     := self.FFATURA_REC;
    lContaCorrenteModel.PARCELA_COR    := self.FPACELA_REC;
    lContaCorrenteModel.TIPO_CTA       := pTipo;
    lContaCorrenteModel.CODIGO_BAN     := pContaCorrente;
    lContaCorrenteModel.LOJA           := self.FLOJA;
    lContaCorrenteModel.PORTADOR_COR   := pPortador;
    lContaCorrenteModel.STATUS         := 'I';
    lContaCorrenteModel.TIPO           := 'S';
    Result := lContaCorrenteModel.Salvar;
  finally
    lContaCorrenteModel.Free;
  end;
end;

function TContasReceberItensModel.obterContaCliente(pContaClienteParametros: TContaClienteParametros): TListaContaClienteRetorno;
var
  lContasReceberItensDao: TContasReceberItensDao;
begin
  lContasReceberItensDao := TContasReceberItensDao.Create(vIConexao);
  try
    Result := lContasReceberItensDao.obterContaCliente(pContaClienteParametros);
  finally
    lContasReceberItensDao.Free;
  end;
end;

procedure TContasReceberItensModel.obterLista;
var
  lContasReceberItensLista: TContasReceberItensDao;
begin
  lContasReceberItensLista := TContasReceberItensDao.Create(vIConexao);
  try
    lContasReceberItensLista.TotalRecords         := FTotalRecords;
    lContasReceberItensLista.WhereView            := FWhereView;
    lContasReceberItensLista.CountView            := FCountView;
    lContasReceberItensLista.OrderView            := FOrderView;
    lContasReceberItensLista.StartRecordView      := FStartRecordView;
    lContasReceberItensLista.LengthPageView       := FLengthPageView;
    lContasReceberItensLista.IDRecordView         := FIDRecordView;
    lContasReceberItensLista.IDContasReceberView  := FIDContasReceberView;
    lContasReceberItensLista.obterLista;
    FTotalRecords  := lContasReceberItensLista.TotalRecords;
    FContasReceberItenssLista := lContasReceberItensLista.ContasReceberItenssLista;
  finally
    lContasReceberItensLista.Free;
  end;
end;

function TContasReceberItensModel.obterReceberPixCobranca(pPedido: String): IFDDataset;
var
  lContasReceberItensDao : TContasReceberItensDao;
begin
  lContasReceberItensDao := TContasReceberItensDao.Create(vIConexao);
  try
    Result := lContasReceberItensDao.obterReceberPixCobranca(pPedido);
  finally
    lContasReceberItensDao.Free;
  end;
end;

procedure TContasReceberItensModel.obterRecebimentoContasReceber;
var
  lContasReceberItensLista: TContasReceberItensDao;
begin
  lContasReceberItensLista := TContasReceberItensDao.Create(vIConexao);
  try
    lContasReceberItensLista.TotalRecords         := FTotalRecords;
    lContasReceberItensLista.WhereView            := FWhereView;
    lContasReceberItensLista.CountView            := FCountView;
    lContasReceberItensLista.OrderView            := FOrderView;
    lContasReceberItensLista.StartRecordView      := FStartRecordView;
    lContasReceberItensLista.LengthPageView       := FLengthPageView;
    lContasReceberItensLista.IDRecordView         := FIDRecordView;
    lContasReceberItensLista.IDContasReceberView  := FIDContasReceberView;
    lContasReceberItensLista.ParcelaView          := FParcelaView;
    lContasReceberItensLista.obterRecebimentoContasReceber;
    FRecebimentoContasReceberLista := lContasReceberItensLista.RecebimentoContasReceberLista;
  finally
    lContasReceberItensLista.Free;
  end;
end;

function TContasReceberItensModel.parcelasAberta(pFatura: String): Boolean;
var
  lContasReceberItensDao: TContasReceberItensDao;
begin
  lContasReceberItensDao := TContasReceberItensDao.Create(vIConexao);
  try
    lContasReceberItensDao.IDContasReceberView := pFatura;
    lContasReceberItensDao.WhereView           := 'and contasreceberitens.situacao_rec <> ''B'' ';
    lContasReceberItensDao.obterTotalRegistros;
    Result := (lContasReceberItensDao.TotalRecords > 0);
  finally
    lContasReceberItensDao.Free;
  end;
end;

function TContasReceberItensModel.recebimentoCartao(pValor, pIdAdmCartao, pVencimento: String; pIdTef: String = ''): String;
var
  lRecebimentoCartaoModel: TRecebimentoCartaoModel;
begin
  lRecebimentoCartaoModel := TRecebimentoCartaoModel.Create(vIConexao);

  try
    lRecebimentoCartaoModel.Acao := tacIncluir;
    if pIdTef <> '' then
      lRecebimentoCartaoModel.TEF_ID       := pIdTef;
    lRecebimentoCartaoModel.USUARIO_ID     := vIConexao.getUSer.ID;
    lRecebimentoCartaoModel.DATA_HORA      := DateTimeToStr(vIConexao.DataHoraServer);
    lRecebimentoCartaoModel.CLIENTE_ID     := self.FCODIGO_CLI;
    lRecebimentoCartaoModel.FATURA         := self.FFATURA_REC;
    lRecebimentoCartaoModel.PARCELA        := self.FPACELA_REC;
    lRecebimentoCartaoModel.VALOR          := pValor;
    lRecebimentoCartaoModel.BANDEIRA_ID    := pIdAdmCartao;
    lRecebimentoCartaoModel.VENCIMENTO     := pVencimento;
    Result := lRecebimentoCartaoModel.Salvar;
  finally
    lRecebimentoCartaoModel.Free;
  end;
end;

function TContasReceberItensModel.Salvar: String;
var
  lContasReceberItensDao: TContasReceberItensDao;
begin
  lContasReceberItensDao := TContasReceberItensDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lContasReceberItensDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lContasReceberItensDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lContasReceberItensDao.excluir(Self);
    end;
  finally
    lContasReceberItensDao.Free;
  end;
end;

procedure TContasReceberItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TContasReceberItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasReceberItensModel.SetCARTAO(const Value: Variant);
begin
  FCARTAO := Value;
end;

procedure TContasReceberItensModel.SetCLIENTE_NOME(const Value: Variant);
begin
  FCLIENTE_NOME := Value;
end;

procedure TContasReceberItensModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TContasReceberItensModel.SetCODIGO_CON(const Value: Variant);
begin
  FCODIGO_CON := Value;
end;

procedure TContasReceberItensModel.SetCODIGO_POR(const Value: Variant);
begin
  FCODIGO_POR := Value;
end;

procedure TContasReceberItensModel.SetCOMISSAO(const Value: Variant);
begin
  FCOMISSAO := Value;
end;

procedure TContasReceberItensModel.SetCOMISSAO_BASE(const Value: Variant);
begin
  FCOMISSAO_BASE := Value;
end;

procedure TContasReceberItensModel.SetDATABAIXA_REC(const Value: Variant);
begin
  FDATABAIXA_REC := Value;
end;

procedure TContasReceberItensModel.SetDATA_ACEITE(const Value: Variant);
begin
  FDATA_ACEITE := Value;
end;

procedure TContasReceberItensModel.SetDESTITULO_REC(const Value: Variant);
begin
  FDESTITULO_REC := Value;
end;

procedure TContasReceberItensModel.SetFATURA_REC(const Value: Variant);
begin
  FFATURA_REC := Value;
end;

procedure TContasReceberItensModel.SetFATURA_RECEBIDA_CARTAO(
  const Value: Variant);
begin
  FFATURA_RECEBIDA_CARTAO := Value;
end;

procedure TContasReceberItensModel.SetContasReceberItenssLista(const Value: TObjectList<TContasReceberItensModel>);
begin
  FContasReceberItenssLista := Value;
end;

procedure TContasReceberItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasReceberItensModel.SetIDAdmCartao(const Value: String);
begin
  FIDAdmCartao := Value;
end;

procedure TContasReceberItensModel.SetIDContasReceberView(const Value: String);
begin
  FIDContasReceberView := Value;
end;

procedure TContasReceberItensModel.SetIDPedidoCartao(const Value: String);
begin
  FIDPedidoCartao := Value;
end;

procedure TContasReceberItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasReceberItensModel.SetIDUsuarioOperacao(const Value: String);
begin
  FIDUsuarioOperacao := Value;
end;

procedure TContasReceberItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasReceberItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TContasReceberItensModel.SetNF_FATURA(const Value: Variant);
begin
  FNF_FATURA := Value;
end;

procedure TContasReceberItensModel.SetNOSSO_NUMERO(const Value: Variant);
begin
  FNOSSO_NUMERO := Value;
end;

procedure TContasReceberItensModel.SetNUMERO_PED(const Value: Variant);
begin
  FNUMERO_PED := Value;
end;

procedure TContasReceberItensModel.SetOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TContasReceberItensModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TContasReceberItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasReceberItensModel.SetPACELA_REC(const Value: Variant);
begin
  FPACELA_REC := Value;
end;

procedure TContasReceberItensModel.SetParcelaView(const Value: String);
begin
  FParcelaView := Value;
end;

procedure TContasReceberItensModel.SetPEDIDO_REC(const Value: Variant);
begin
  FPEDIDO_REC := Value;
end;

procedure TContasReceberItensModel.SetPIX_EMV(const Value: Variant);
begin
  FPIX_EMV := Value;
end;

procedure TContasReceberItensModel.SetPIX_EXPIRACAO(const Value: Variant);
begin
  FPIX_EXPIRACAO := Value;
end;

procedure TContasReceberItensModel.SetPIX_IDENTIFICADOR(const Value: Variant);
begin
  FPIX_IDENTIFICADOR := Value;
end;

procedure TContasReceberItensModel.SetPORTADOR_NOME(const Value: Variant);
begin
  FPORTADOR_NOME := Value;
end;

procedure TContasReceberItensModel.SetPOSICAO_ID(const Value: Variant);
begin
  FPOSICAO_ID := Value;
end;

procedure TContasReceberItensModel.SetRecebimentoContasReceberLista(
  const Value: TObjectList<TRecebimentoContasReceber>);
begin
  FRecebimentoContasReceberLista := Value;
end;

procedure TContasReceberItensModel.SetSITUACAO_REC(const Value: Variant);
begin
  FSITUACAO_REC := Value;
end;

procedure TContasReceberItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasReceberItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TContasReceberItensModel.SetTEF_ADQUIRENTE(const Value: Variant);
begin
  FTEF_ADQUIRENTE := Value;
end;

procedure TContasReceberItensModel.SetTEF_CHAMADA(const Value: Variant);
begin
  FTEF_CHAMADA := Value;
end;

procedure TContasReceberItensModel.SetTEF_MODALIDADE(const Value: Variant);
begin
  FTEF_MODALIDADE := Value;
end;

procedure TContasReceberItensModel.SetTEF_PARCELAMENTO(const Value: Variant);
begin
  FTEF_PARCELAMENTO := Value;
end;

procedure TContasReceberItensModel.SetTOTALPARCELAS_REC(const Value: Variant);
begin
  FTOTALPARCELAS_REC := Value;
end;

procedure TContasReceberItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasReceberItensModel.SetUSUARIO_ACEITE(const Value: Variant);
begin
  FUSUARIO_ACEITE := Value;
end;

procedure TContasReceberItensModel.SetVALORREC_REC(const Value: Variant);
begin
  FVALORREC_REC := Value;
end;

procedure TContasReceberItensModel.SetVALOR_DESCONTO_CARTAO(
  const Value: Variant);
begin
  FVALOR_DESCONTO_CARTAO := Value;
end;

procedure TContasReceberItensModel.SetVALOR_JUROS_CARTAO(const Value: Variant);
begin
  FVALOR_JUROS_CARTAO := Value;
end;

procedure TContasReceberItensModel.SetVALOR_PAGO(const Value: Variant);
begin
  FVALOR_PAGO := Value;
end;

procedure TContasReceberItensModel.SetVALOR_RECEBIDO_CARTAO(
  const Value: Variant);
begin
  FVALOR_RECEBIDO_CARTAO := Value;
end;

procedure TContasReceberItensModel.SetVAUCHER_CLIENTE_ID(const Value: Variant);
begin
  FVAUCHER_CLIENTE_ID := Value;
end;

procedure TContasReceberItensModel.SetVENCIMENTO_BOLETO(const Value: Variant);
begin
  FVENCIMENTO_BOLETO := Value;
end;

procedure TContasReceberItensModel.SetVENCIMENTO_REC(const Value: Variant);
begin
  FVENCIMENTO_REC := Value;
end;

procedure TContasReceberItensModel.SetVLRPARCELA_REC(const Value: Variant);
begin
  FVLRPARCELA_REC := Value;
end;

procedure TContasReceberItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TContasReceberItensModel.valorAberto(pCliente: String): Double;
var
  lContasReceberItensDao : TContasReceberItensDao;
begin
  lContasReceberItensDao := TContasReceberItensDao.Create(vIConexao);
  try
    Result := lContasReceberItensDao.valorAberto(pCliente);
  finally
    lContasReceberItensDao.Free;
  end;
end;

{ TRecebimentoContasReceber }

procedure TRecebimentoContasReceber.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TRecebimentoContasReceber.SetORIGEM(const Value: Variant);
begin
  FORIGEM := Value;
end;

procedure TRecebimentoContasReceber.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TRecebimentoContasReceber.SetVALOR(const Value: Variant);
begin
  FVALOR := Value;
end;

end.
