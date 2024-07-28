unit DevolucaoItensModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TDevolucaoItensModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    FVALOR_UNITARIO: Variant;
    FPRODUTO: Variant;
    FALTURA_M: Variant;
    FCOMISSAO_PERCENTUAL: Variant;
    FPEDIDO_ID: Variant;
    FVALOR_SUFRAMA: Variant;
    FDESCONTO_PED: Variant;
    FLARGURA_M: Variant;
    FVALOR_ST: Variant;
    FID: Variant;
    FLOJA: Variant;
    FITEM: Variant;
    FSYSTIME: Variant;
    FVALOR_IPI: Variant;
    FCOMANDA: Variant;
    FQUANTIDADE: Variant;
    FPROFUNDIDADE_M: Variant;
    FFRETE: Variant;
    FVFCPST: Variant;
    FVALOR_ACRESCIMO: Variant;
    FCOMISSAO_DEV: Variant;
    FCUSTO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);
    procedure SetALTURA_M(const Value: Variant);
    procedure SetCOMANDA(const Value: Variant);
    procedure SetCOMISSAO_DEV(const Value: Variant);
    procedure SetCOMISSAO_PERCENTUAL(const Value: Variant);
    procedure SetCUSTO(const Value: Variant);
    procedure SetDESCONTO_PED(const Value: Variant);
    procedure SetFRETE(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetITEM(const Value: Variant);
    procedure SetLARGURA_M(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetPEDIDO_ID(const Value: Variant);
    procedure SetPRODUTO(const Value: Variant);
    procedure SetPROFUNDIDADE_M(const Value: Variant);
    procedure SetQUANTIDADE(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR_ACRESCIMO(const Value: Variant);
    procedure SetVALOR_IPI(const Value: Variant);
    procedure SetVALOR_ST(const Value: Variant);
    procedure SetVALOR_SUFRAMA(const Value: Variant);
    procedure SetVALOR_UNITARIO(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);

  public
    property ID: Variant read FID write SetID;
    property PRODUTO: Variant read FPRODUTO write SetPRODUTO;
    property VALOR_UNITARIO: Variant read FVALOR_UNITARIO write SetVALOR_UNITARIO;
    property QUANTIDADE: Variant read FQUANTIDADE write SetQUANTIDADE;
    property LOJA: Variant read FLOJA write SetLOJA;
    property CUSTO: Variant read FCUSTO write SetCUSTO;
    property COMISSAO_DEV: Variant read FCOMISSAO_DEV write SetCOMISSAO_DEV;
    property PEDIDO_ID: Variant read FPEDIDO_ID write SetPEDIDO_ID;
    property VALOR_ST: Variant read FVALOR_ST write SetVALOR_ST;
    property COMISSAO_PERCENTUAL: Variant read FCOMISSAO_PERCENTUAL write SetCOMISSAO_PERCENTUAL;
    property FRETE: Variant read FFRETE write SetFRETE;
    property COMANDA: Variant read FCOMANDA write SetCOMANDA;
    property ALTURA_M: Variant read FALTURA_M write SetALTURA_M;
    property LARGURA_M: Variant read FLARGURA_M write SetLARGURA_M;
    property PROFUNDIDADE_M: Variant read FPROFUNDIDADE_M write SetPROFUNDIDADE_M;
    property ITEM: Variant read FITEM write SetITEM;
    property DESCONTO_PED: Variant read FDESCONTO_PED write SetDESCONTO_PED;
    property VALOR_SUFRAMA: Variant read FVALOR_SUFRAMA write SetVALOR_SUFRAMA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property VALOR_IPI: Variant read FVALOR_IPI write SetVALOR_IPI;
    property VALOR_ACRESCIMO: Variant read FVALOR_ACRESCIMO write SetVALOR_ACRESCIMO;
    property VFCPST: Variant read FVFCPST write SetVFCPST;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID, pProduto, pITEM : String): TDevolucaoItensModel;
    function Excluir(pID, pProduto, pITEM : String): String;
    function Salvar : String;

    function carregaClasse(pID, pProduto, pItem : String): TDevolucaoItensModel;
    function obterLista: IFDDataset;
    function proximoItem(pDevolucao : String): String;
    function calculaTotais(pDevolucao : String): IFDDataset;
    procedure gerarEstoque;
    procedure excluirEstoque;

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
  DevolucaoItensDao,  
  System.Classes, 
  System.SysUtils, MovimentoModel, ProdutosModel, DevolucaoModel;

{ TDevolucaoItensModel }

function TDevolucaoItensModel.Alterar(pID, pProduto, pITEM: String): TDevolucaoItensModel;
var
  lDevolucaoItensModel : TDevolucaoItensModel;
begin
  lDevolucaoItensModel := TDevolucaoItensModel.Create(vIConexao);
  try
    lDevolucaoItensModel       := lDevolucaoItensModel.carregaClasse(pID, pProduto, pITEM);
    lDevolucaoItensModel.Acao  := tacAlterar;
    Result            := lDevolucaoItensModel;
  finally
  end;
end;

function TDevolucaoItensModel.Excluir(pID, pProduto, pITEM : String): String;
begin
  self.ID       := pID;
  self.PRODUTO  := pProduto;
  self.ITEM     := pITEM;
  self.FAcao    := tacExcluir;
  Result        := self.Salvar;
end;

procedure TDevolucaoItensModel.excluirEstoque;
var
  lMovimentoModel   : TMovimentoModel;
  lProdutosModel    : ITProdutosModel;
begin
  lMovimentoModel   := TMovimentoModel.Create(vIConexao);
  lProdutosModel    := TProdutosModel.getNewIface(vIConexao);

  try
    lMovimentoModel.WhereView := ' and movimento.documento_mov = '+ QuotedStr(self.FID) +
                                 ' and movimento.codigo_pro = ' + QuotedStr(self.FPRODUTO) +
                                 ' and movimento.tabela_origem = ''DEVOLUCAOITENS'' ' +
                                 ' and movimento.tipo_doc = ''D'' ';
    lMovimentoModel.obterLista;

    for lMovimentoModel in lMovimentoModel.MovimentosLista do
    begin
      lMovimentoModel.Acao := tacExcluir;
      lMovimentoModel.Salvar;
      lProdutosModel.objeto.subtrairSaldo(self.FPRODUTO, self.FQUANTIDADE);
    end;

  finally
    lMovimentoModel.Free;
    lProdutosModel:=nil;
  end;
end;

procedure TDevolucaoItensModel.gerarEstoque;
var
  lMovimentoModel   : TMovimentoModel;
  lProdutosModel    : ITProdutosModel;
  lDevolucaoModel   : ITDevolucaoModel;
begin
  lMovimentoModel   := TMovimentoModel.Create(vIConexao);
  lProdutosModel    := TProdutosModel.getNewIface(vIConexao);
  lDevolucaoModel   := TDevolucaoModel.getNewIface(vIConexao);

  try
    lDevolucaoModel := lDevolucaoModel.objeto.carregaClasse(self.ID);

    lMovimentoModel.Acao := tacIncluir;
    lMovimentoModel.DOCUMENTO_MOV   := lDevolucaoModel.objeto.ID;
    lMovimentoModel.CODIGO_PRO      := self.FPRODUTO;
    lMovimentoModel.CODIGO_FOR      := lDevolucaoModel.objeto.CLIENTE;
    lMovimentoModel.OBS_MOV         := 'Troca Venda: ' + lDevolucaoModel.objeto.PEDIDO;
    lMovimentoModel.TIPO_DOC        := 'D';
    lMovimentoModel.DATA_MOV        := DateToStr(vIConexao.DataServer);
    lMovimentoModel.DATA_DOC        := DateToStr(vIConexao.DataServer);
    lMovimentoModel.QUANTIDADE_MOV  := self.FQUANTIDADE;
    lMovimentoModel.VALOR_MOV       := self.FVALOR_UNITARIO;
    lMovimentoModel.CUSTO_ATUAL     := '0';
    lMovimentoModel.VENDA_ATUAL     := '0';
    lMovimentoModel.STATUS          := '0';
    lMovimentoModel.LOJA            := lDevolucaoModel.objeto.LOJA;
    lMovimentoModel.tabela_origem   := 'DEVOLUCAOITENS';
    lMovimentoModel.id_origem       := self.FID;
    lMovimentoModel.Salvar;

    lProdutosModel.objeto.adicionarSaldo(self.FPRODUTO, self.FQUANTIDADE);

  finally
    lProdutosModel:=nil;
    lMovimentoModel.Free;
  end;
end;

function TDevolucaoItensModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TDevolucaoItensModel.calculaTotais(pDevolucao: String): IFDDataset;
var
  lDevolucaoItensDao : TDevolucaoItensDao;
begin
  lDevolucaoItensDao := TDevolucaoItensDao.Create(vIConexao);
  try
    Result := lDevolucaoItensDao.calculaTotais(pDevolucao);
  finally
    lDevolucaoItensDao.Free;
  end;
end;

function TDevolucaoItensModel.carregaClasse(pID, pProduto, pItem : String): TDevolucaoItensModel;
var
  lDevolucaoItensDao: TDevolucaoItensDao;
begin
  lDevolucaoItensDao := TDevolucaoItensDao.Create(vIConexao);

  try
    Result := lDevolucaoItensDao.carregaClasse(pID, pProduto, pItem);
  finally
    lDevolucaoItensDao.Free;
  end;
end;

constructor TDevolucaoItensModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDevolucaoItensModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TDevolucaoItensModel.obterLista: IFDDataset;
var
  lDevolucaoItensLista: TDevolucaoItensDao;
begin
  lDevolucaoItensLista := TDevolucaoItensDao.Create(vIConexao);

  try
    lDevolucaoItensLista.TotalRecords    := FTotalRecords;
    lDevolucaoItensLista.WhereView       := FWhereView;
    lDevolucaoItensLista.CountView       := FCountView;
    lDevolucaoItensLista.OrderView       := FOrderView;
    lDevolucaoItensLista.StartRecordView := FStartRecordView;
    lDevolucaoItensLista.LengthPageView  := FLengthPageView;
    lDevolucaoItensLista.IDRecordView    := FIDRecordView;

    Result := lDevolucaoItensLista.obterLista;

    FTotalRecords := lDevolucaoItensLista.TotalRecords;

  finally
    lDevolucaoItensLista.Free;
  end;
end;

function TDevolucaoItensModel.proximoItem(pDevolucao: String): String;
var
  lDevolucaoItensDao : TDevolucaoItensDao;
begin
  lDevolucaoItensDao := TDevolucaoItensDao.Create(vIConexao);
  try
    Result := lDevolucaoItensDao.proximoItem(pDevolucao);
  finally
    lDevolucaoItensDao.Free;
  end;
end;

function TDevolucaoItensModel.Salvar: String;
var
  lDevolucaoItensDao: TDevolucaoItensDao;
begin
  lDevolucaoItensDao := TDevolucaoItensDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lDevolucaoItensDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lDevolucaoItensDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lDevolucaoItensDao.excluir(Self);
    end;
  finally
    lDevolucaoItensDao.Free;
  end;
end;

procedure TDevolucaoItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TDevolucaoItensModel.SetALTURA_M(const Value: Variant);
begin
  FALTURA_M := Value;
end;

procedure TDevolucaoItensModel.SetCOMANDA(const Value: Variant);
begin
  FCOMANDA := Value;
end;

procedure TDevolucaoItensModel.SetCOMISSAO_DEV(const Value: Variant);
begin
  FCOMISSAO_DEV := Value;
end;

procedure TDevolucaoItensModel.SetCOMISSAO_PERCENTUAL(const Value: Variant);
begin
  FCOMISSAO_PERCENTUAL := Value;
end;

procedure TDevolucaoItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDevolucaoItensModel.SetCUSTO(const Value: Variant);
begin
  FCUSTO := Value;
end;

procedure TDevolucaoItensModel.SetDESCONTO_PED(const Value: Variant);
begin
  FDESCONTO_PED := Value;
end;

procedure TDevolucaoItensModel.SetFRETE(const Value: Variant);
begin
  FFRETE := Value;
end;

procedure TDevolucaoItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDevolucaoItensModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TDevolucaoItensModel.SetITEM(const Value: Variant);
begin
  FITEM := Value;
end;

procedure TDevolucaoItensModel.SetLARGURA_M(const Value: Variant);
begin
  FLARGURA_M := Value;
end;

procedure TDevolucaoItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDevolucaoItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TDevolucaoItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TDevolucaoItensModel.SetPEDIDO_ID(const Value: Variant);
begin
  FPEDIDO_ID := Value;
end;

procedure TDevolucaoItensModel.SetPRODUTO(const Value: Variant);
begin
  FPRODUTO := Value;
end;

procedure TDevolucaoItensModel.SetPROFUNDIDADE_M(const Value: Variant);
begin
  FPROFUNDIDADE_M := Value;
end;

procedure TDevolucaoItensModel.SetQUANTIDADE(const Value: Variant);
begin
  FQUANTIDADE := Value;
end;

procedure TDevolucaoItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TDevolucaoItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TDevolucaoItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TDevolucaoItensModel.SetVALOR_ACRESCIMO(const Value: Variant);
begin
  FVALOR_ACRESCIMO := Value;
end;

procedure TDevolucaoItensModel.SetVALOR_IPI(const Value: Variant);
begin
  FVALOR_IPI := Value;
end;

procedure TDevolucaoItensModel.SetVALOR_ST(const Value: Variant);
begin
  FVALOR_ST := Value;
end;

procedure TDevolucaoItensModel.SetVALOR_SUFRAMA(const Value: Variant);
begin
  FVALOR_SUFRAMA := Value;
end;

procedure TDevolucaoItensModel.SetVALOR_UNITARIO(const Value: Variant);
begin
  FVALOR_UNITARIO := Value;
end;

procedure TDevolucaoItensModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TDevolucaoItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
