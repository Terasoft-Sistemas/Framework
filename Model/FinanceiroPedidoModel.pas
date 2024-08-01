unit FinanceiroPedidoModel;

interface

uses
  System.Math,
  Terasoft.Types,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  FireDAC.Comp.Client, WebPedidoModel;

type
  TFinanceiroPedidoModel = class;
  ITFinanceiroPedidoModel=IObject<TFinanceiroPedidoModel>;

  TFinanceiroParams = record
    WEB_PEDIDO_ID,
    WEB_PEDIDOITENS_ID,
    PORTADOR_ID           : String;
    PRIMEIRO_VENCIMENTO   : TDate;
    QUANTIDADE_PARCELAS   : Integer;
    INDCE_APLICADO        : Double;
    VALOR_ACRESCIMO       : Double;
    VALOR_LIQUIDO         : Double;
    VALOR_TOTAL           : Double;
    VALOR_SEG_PRESTAMISTA : Double;
    PER_SEG_PRESTAMSTA    : Double;
    VALOR_ACRESCIMO_SEG_PRESTAMISTA : Double;
  end;

  TFinanceiroPedidoModel = class
  private
    [weak] mySelf: ITFinanceiroPedidoModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FQUANTIDADE_PARCELAS: Variant;
    FPEDIDO_VENDA_ID: Variant;
    FOBSERVACAO: Variant;
    FVALOR_TOTAL: Variant;
    FPORTADOR_ID: Variant;
    FDATA_CADASTRO: Variant;
    FVENCIMENTO: Variant;
    FWEB_PEDIDO_ID: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FVALOR_PARCELA: Variant;
    FCONDICAO_PAGAMENTO: Variant;
    FPARCELA: Variant;
    FINDCE_APLICADO: Variant;
    FVALOR_ACRESCIMO: Variant;
    FID_FINANCEIRO: Variant;
    FVALOR_LIQUIDO: Variant;
    FVALOR_SEG_PRESTAMISTA: Variant;
    FPER_SEG_PRESTAMSTA: Variant;
    FVALOR_ACRESCIMO_SEG_PRESTAMISTA: Variant;
    FWEB_PEDIDOITENS_ID: Variant;
    FORIGINAL_VALOR_PARCELA: Variant;
    FORIGINAL_INDCE_APLICADO: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCONDICAO_PAGAMENTO(const Value: Variant);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetOBSERVACAO(const Value: Variant);
    procedure SetPARCELA(const Value: Variant);
    procedure SetPEDIDO_VENDA_ID(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetQUANTIDADE_PARCELAS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR_PARCELA(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);
    procedure SetVENCIMENTO(const Value: Variant);
    procedure SetWEB_PEDIDO_ID(const Value: Variant);
    procedure SetINDCE_APLICADO(const Value: Variant);
    procedure SetVALOR_ACRESCIMO(const Value: Variant);
    procedure SetID_FINANCEIRO(const Value: Variant);
    procedure SetVALOR_LIQUIDO(const Value: Variant);
    procedure SetPER_SEG_PRESTAMSTA(const Value: Variant);
    procedure SetVALOR_SEG_PRESTAMISTA(const Value: Variant);
    procedure SetVALOR_ACRESCIMO_SEG_PRESTAMISTA(const Value: Variant);
    procedure SetWEB_PEDIDOITENS_ID(const Value: Variant);
    procedure SetORIGINAL_INDCE_APLICADO(const Value: Variant);
    procedure SetORIGINAL_VALOR_PARCELA(const Value: Variant);

  public

    property  ID                    : Variant read FID write SetID;
    property  SYSTIME               : Variant read FSYSTIME write SetSYSTIME;
    property  DATA_CADASTRO         : Variant read FDATA_CADASTRO write SetDATA_CADASTRO;
    property  WEB_PEDIDO_ID         : Variant read FWEB_PEDIDO_ID write SetWEB_PEDIDO_ID;
    property  PEDIDO_VENDA_ID       : Variant read FPEDIDO_VENDA_ID write SetPEDIDO_VENDA_ID;
    property  WEB_PEDIDOITENS_ID    : Variant read FWEB_PEDIDOITENS_ID write SetWEB_PEDIDOITENS_ID;
    property  PORTADOR_ID           : Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property  VALOR_TOTAL           : Variant read FVALOR_TOTAL write SetVALOR_TOTAL;
    property  QUANTIDADE_PARCELAS   : Variant read FQUANTIDADE_PARCELAS write SetQUANTIDADE_PARCELAS;
    property  PARCELA               : Variant read FPARCELA write SetPARCELA;
    property  VALOR_PARCELA         : Variant read FVALOR_PARCELA write SetVALOR_PARCELA;
    property  VENCIMENTO            : Variant read FVENCIMENTO write SetVENCIMENTO;
    property  CONDICAO_PAGAMENTO    : Variant read FCONDICAO_PAGAMENTO write SetCONDICAO_PAGAMENTO;
    property  OBSERVACAO            : Variant read FOBSERVACAO write SetOBSERVACAO;
    property  INDCE_APLICADO        : Variant read FINDCE_APLICADO write SetINDCE_APLICADO;
    property  VALOR_ACRESCIMO       : Variant read FVALOR_ACRESCIMO write SetVALOR_ACRESCIMO;
    property  ID_FINANCEIRO         : Variant read FID_FINANCEIRO write SetID_FINANCEIRO;
    property  VALOR_LIQUIDO         : Variant read FVALOR_LIQUIDO write SetVALOR_LIQUIDO;
    property  VALOR_SEG_PRESTAMISTA : Variant read FVALOR_SEG_PRESTAMISTA write SetVALOR_SEG_PRESTAMISTA;
    property  PER_SEG_PRESTAMSTA    : Variant read FPER_SEG_PRESTAMSTA write SetPER_SEG_PRESTAMSTA;
    property  VALOR_ACRESCIMO_SEG_PRESTAMISTA : Variant read FVALOR_ACRESCIMO_SEG_PRESTAMISTA write SetVALOR_ACRESCIMO_SEG_PRESTAMISTA;

    property  ORIGINAL_VALOR_PARCELA : Variant read FORIGINAL_VALOR_PARCELA write SetORIGINAL_VALOR_PARCELA;
    property  ORIGINAL_INDCE_APLICADO : Variant read FORIGINAL_INDCE_APLICADO write SetORIGINAL_INDCE_APLICADO;

    property Acao               : TAcao       read FAcao               write SetAcao;
    property TotalRecords       : Integer     read FTotalRecords       write SetTotalRecords;
    property WhereView          : String      read FWhereView          write SetWhereView;
    property CountView          : String      read FCountView          write SetCountView;
    property OrderView          : String      read FOrderView          write SetOrderView;
    property StartRecordView    : String      read FStartRecordView    write SetStartRecordView;
    property LengthPageView     : String      read FLengthPageView     write SetLengthPageView;
    property IDRecordView       : Integer     read FIDRecordView       write SetIDRecordView;


  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITFinanceiroPedidoModel;

    function Salvar  : String;

    function Incluir : String;
    function Alterar(pID: String): ITFinanceiroPedidoModel;
    function Excluir(pID: String) : String;
    function ExcluirPromocao(pID: String): String;

    function carregaClasse(pId: String): ITFinanceiroPedidoModel;
    function obterLista: IFDDataset;
    function obterResumo(pIDPedido : String) : IFDDataset;
    function qtdePagamentoPrazo(pWebPedido : String): Integer;
    function obterResumoFinanceiro : IFDDataset;

    procedure UpdateDadosFinanceiro(pWebPedidoModel: TWebPedidoModel);

    procedure gerarFinanceiro(pFinanceiroParams: TFinanceiroParams);

    procedure ArredondaParcela(pNovaParcela: Extended; pID_Financeiro: String);


  end;

implementation

uses
  FinanceiroPedidoDao, System.Classes, System.SysUtils, PortadorModel,
  System.StrUtils;

{ TFinanceiroPedidoModel }

procedure TFinanceiroPedidoModel.ArredondaParcela(pNovaParcela: Extended; pID_Financeiro: String);
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  lFinanceiroPedidoDao : ITFinanceiroPedidoDao;

  lTotal, lValorParcelaNew, lIndiceNew, lIndiceOriginal, lValorAcrescimoNew, lValorLiquido, lParcelaOriginal : Extended;

begin
    lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);
    lFinanceiroPedidoDao := TFinanceiroPedidoDao.getNewIface(vIConexao);

  try
    lFinanceiroPedidoModel := lFinanceiroPedidoModel.objeto.carregaClasse(pID_Financeiro);

    if pNovaParcela < (lFinanceiroPedidoModel.objeto.ORIGINAL_VALOR_PARCELA-0.99) then
      CriaException('Arredondamento da parcela não pode ser superior a R$ 0.99');

    lIndiceOriginal  := StrToFloat(lFinanceiroPedidoModel.objeto.ORIGINAL_INDCE_APLICADO);
    lParcelaOriginal := StrToFloat(lFinanceiroPedidoModel.objeto.ORIGINAL_VALOR_PARCELA);
    lValorLiquido    := (StrToFloat(lFinanceiroPedidoModel.objeto.VALOR_LIQUIDO) + StrToFloat(lFinanceiroPedidoModel.objeto.VALOR_SEG_PRESTAMISTA));

    lIndiceNew         := (pNovaParcela * lIndiceOriginal)/lParcelaOriginal;
    lValorParcelaNew   := lValorLiquido * lIndiceNew;
    lTotal             := lValorParcelaNew * StrToInt(lFinanceiroPedidoModel.objeto.QUANTIDADE_PARCELAS);
    lValorAcrescimoNew := lTotal - lValorLiquido;

    lFinanceiroPedidoDao.objeto.UpdateArredondaParcela(lTotal, lValorParcelaNew, lIndiceNew, lValorAcrescimoNew, pID_Financeiro);

  finally
    lFinanceiroPedidoModel:=nil;
    lFinanceiroPedidoDao:=nil;
  end;

end;

function TFinanceiroPedidoModel.Incluir: String;
begin
  if self.FWEB_PEDIDO_ID = '' then
    CriaException('WebPedido não informado.');

  if self.FPORTADOR_ID = '' then
    CriaException('Portador não informado.');

  if self.FVALOR_TOTAL = '' then
    CriaException('Valor Total não informado.');

  if self.FQUANTIDADE_PARCELAS = '' then
    CriaException('Quantidade de Parcelas não informada.');

  if self.FPARCELA = '' then
    CriaException('Parcela não informada.');

  if self.FVALOR_PARCELA = '' then
    CriaException('Valor da Parcela não informado.');

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TFinanceiroPedidoModel.Alterar(pID: String): ITFinanceiroPedidoModel;
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);
  try
    lFinanceiroPedidoModel := lFinanceiroPedidoModel.objeto.carregaClasse(pID);
    lFinanceiroPedidoModel.objeto.Acao := tacAlterar;
    Result := lFinanceiroPedidoModel;
  finally
  end;
end;

function TFinanceiroPedidoModel.Excluir(pID: String): String;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

  self.FID_FINANCEIRO  := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar;
end;

function TFinanceiroPedidoModel.ExcluirPromocao(pID: String): String;
var
  lFinanceiroPedidoDao : ITFinanceiroPedidoDao;
begin
  if pID = '' then
    CriaException('ID é obrigatório.');

  lFinanceiroPedidoDao := TFinanceiroPedidoDao.getNewIface(vIConexao);
  try
    Result := lFinanceiroPedidoDao.objeto.excluirPromocao(pId);
  finally
    lFinanceiroPedidoDao:=nil;
  end;

end;

procedure TFinanceiroPedidoModel.gerarFinanceiro(pFinanceiroParams: TFinanceiroParams);
var
  i                   : Integer;
  lValorParcela,
  lSoma               : Double;
  lPrimeiroVencimento : TDate;
  lIDFinanceiro       : String;
  lRetorno            : String;
  lPortadorModel      : ITPortadorModel;
begin

  lPortadorModel := TPortadorModel.getNewIface(vIConexao);

  try
    lPortadorModel.objeto.IDRecordView := pFinanceiroParams.PORTADOR_ID;
    lPortadorModel.objeto.obterLista;

    if not AnsiMatchStr(lPortadorModel.objeto.PortadorsLista[0].objeto.TPAG_NFE, ['01', '03', '04', '99']) and (lPortadorModel.objeto.PortadorsLista[0].objeto.CODIGO_PORT <> '777777') then
    begin
      if self.qtdePagamentoPrazo(pFinanceiroParams.WEB_PEDIDO_ID) > 0 then
        CriaException('Pagamento similar já realizado. Por favor, refazer o pagamento.');
    end;

    lPrimeiroVencimento   := pFinanceiroParams.PRIMEIRO_VENCIMENTO;
    lIDFinanceiro := '';
    lSoma         := 0;
    lValorParcela := RoundTo(pFinanceiroParams.VALOR_TOTAL / pFinanceiroParams.QUANTIDADE_PARCELAS, -2);

    for i := 0 to pFinanceiroParams.QUANTIDADE_PARCELAS -1 do
    begin
      self.WEB_PEDIDO_ID        := pFinanceiroParams.WEB_PEDIDO_ID;
      self.PORTADOR_ID          := pFinanceiroParams.PORTADOR_ID;
      self.VALOR_LIQUIDO        := FloatToStr(pFinanceiroParams.VALOR_LIQUIDO);
      self.VALOR_TOTAL          := FloatToStr(pFinanceiroParams.VALOR_TOTAL);
      self.QUANTIDADE_PARCELAS  := IntToStr(pFinanceiroParams.QUANTIDADE_PARCELAS);
      self.PARCELA              := IntToStr(i+1);
      self.VALOR_PARCELA        := FloatToStr(lValorParcela);
      self.INDCE_APLICADO       := FloatToStr(pFinanceiroParams.INDCE_APLICADO);
      self.VALOR_ACRESCIMO      := FloatToStr(pFinanceiroParams.VALOR_ACRESCIMO);
      self.ID_FINANCEIRO        := lIDFinanceiro;
      self.WEB_PEDIDOITENS_ID   := pFinanceiroParams.WEB_PEDIDOITENS_ID;

      self.VALOR_SEG_PRESTAMISTA           := pFinanceiroParams.VALOR_SEG_PRESTAMISTA;
      self.PER_SEG_PRESTAMSTA              := pFinanceiroParams.PER_SEG_PRESTAMSTA;
      self.VALOR_ACRESCIMO_SEG_PRESTAMISTA := pFinanceiroParams.VALOR_ACRESCIMO_SEG_PRESTAMISTA;

      self.ORIGINAL_VALOR_PARCELA  := self.VALOR_PARCELA;
      self.ORIGINAL_INDCE_APLICADO := self.INDCE_APLICADO;

      if i = 0 then
        self.VENCIMENTO := DateToStr(lPrimeiroVencimento)
      else
      begin
        self.VENCIMENTO := DateToStr(IncMonth(lPrimeiroVencimento, i));
      end;

      lSoma := lSoma + self.VALOR_PARCELA;

      if self.PARCELA = pFinanceiroParams.QUANTIDADE_PARCELAS then
        self.VALOR_PARCELA := FloatToStr(self.VALOR_PARCELA + (pFinanceiroParams.VALOR_TOTAL - lSoma));

      lRetorno := self.Incluir;

      if i = 0 then
        lIDFinanceiro := lRetorno;

    end;
  finally
    lPortadorModel := nil;
  end;
end;

class function TFinanceiroPedidoModel.getNewIface(pIConexao: IConexao): ITFinanceiroPedidoModel;
begin
  Result := TImplObjetoOwner<TFinanceiroPedidoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TFinanceiroPedidoModel.carregaClasse(pId: String): ITFinanceiroPedidoModel;
var
  lFinanceiroPedidoDao : ITFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.getNewIface(vIConexao);
  try
    Result := lFinanceiroPedidoDao.objeto.carregaClasse(pId);
  finally
    lFinanceiroPedidoDao:=nil;
  end;
end;

constructor TFinanceiroPedidoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFinanceiroPedidoModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TFinanceiroPedidoModel.obterResumo(pIDPedido : String): IFDDataset;
var
  lFinanceiroPedidoDao : ITFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.getNewIface(vIConexao);
  try
    Result := lFinanceiroPedidoDao.objeto.obterResumo(pIDPedido);
  finally
    lFinanceiroPedidoDao:=nil;
  end;
end;

function TFinanceiroPedidoModel.obterResumoFinanceiro: IFDDataset;
var
  lFinanceiroPedidoDao : ITFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.getNewIface(vIConexao);
  try
    lFinanceiroPedidoDao.objeto.WhereView := FWhereView;

    Result := lFinanceiroPedidoDao.objeto.obterResumoFinanceiro;
  finally
    lFinanceiroPedidoDao:=nil;
  end;
end;

function TFinanceiroPedidoModel.qtdePagamentoPrazo(pWebPedido: String): Integer;
var
  lFinanceiroPedidoDao: ITFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.getNewIface(vIConexao);
  try
    Result := lFinanceiroPedidoDao.objeto.qtdePagamentoPrazo(pWebPedido);
  finally
    lFinanceiroPedidoDao:=nil;
  end;
end;

function TFinanceiroPedidoModel.obterLista: IFDDataset;
var
  lFinanceiroPedidoLista: ITFinanceiroPedidoDao;
begin
  lFinanceiroPedidoLista := TFinanceiroPedidoDao.getNewIface(vIConexao);
  try
    lFinanceiroPedidoLista.objeto.TotalRecords    := FTotalRecords;
    lFinanceiroPedidoLista.objeto.WhereView       := FWhereView;
    lFinanceiroPedidoLista.objeto.CountView       := FCountView;
    lFinanceiroPedidoLista.objeto.OrderView       := FOrderView;
    lFinanceiroPedidoLista.objeto.StartRecordView := FStartRecordView;
    lFinanceiroPedidoLista.objeto.LengthPageView  := FLengthPageView;
    lFinanceiroPedidoLista.objeto.IDRecordView    := FIDRecordView;

    Result        := lFinanceiroPedidoLista.objeto.obterLista;
    FTotalRecords := lFinanceiroPedidoLista.objeto.TotalRecords;
  finally
    lFinanceiroPedidoLista:=nil;
  end;
end;

function TFinanceiroPedidoModel.Salvar: String;
var
  lFinanceiroPedidoDao : ITFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.getNewIface(vIConexao);
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lFinanceiroPedidoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lFinanceiroPedidoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lFinanceiroPedidoDao.objeto.excluir(mySelf);
    end;
  finally
    lFinanceiroPedidoDao:=nil;
  end;
end;

procedure TFinanceiroPedidoModel.UpdateDadosFinanceiro(pWebPedidoModel: TWebPedidoModel);
var
  lFinanceiroPedidoDao : ITFinanceiroPedidoDao;
begin
  lFinanceiroPedidoDao := TFinanceiroPedidoDao.getNewIface(vIConexao);
  try
    lFinanceiroPedidoDao.objeto.UpdateDadosFinanceiro(pWebPedidoModel);
  finally
    lFinanceiroPedidoDao:=nil;
  end;
end;

procedure TFinanceiroPedidoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TFinanceiroPedidoModel.SetCONDICAO_PAGAMENTO(const Value: Variant);
begin
  FCONDICAO_PAGAMENTO := Value;
end;

procedure TFinanceiroPedidoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFinanceiroPedidoModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;

procedure TFinanceiroPedidoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TFinanceiroPedidoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TFinanceiroPedidoModel.SetID_FINANCEIRO(const Value: Variant);
begin
  FID_FINANCEIRO := Value;
end;

procedure TFinanceiroPedidoModel.SetINDCE_APLICADO(const Value: Variant);
begin
  FINDCE_APLICADO := Value;
end;

procedure TFinanceiroPedidoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFinanceiroPedidoModel.SetOBSERVACAO(const Value: Variant);
begin
  FOBSERVACAO := Value;
end;

procedure TFinanceiroPedidoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFinanceiroPedidoModel.SetORIGINAL_INDCE_APLICADO(
  const Value: Variant);
begin
  FORIGINAL_INDCE_APLICADO := Value;
end;

procedure TFinanceiroPedidoModel.SetORIGINAL_VALOR_PARCELA(
  const Value: Variant);
begin
  FORIGINAL_VALOR_PARCELA := Value;
end;

procedure TFinanceiroPedidoModel.SetPARCELA(const Value: Variant);
begin
  FPARCELA := Value;
end;

procedure TFinanceiroPedidoModel.SetPEDIDO_VENDA_ID(const Value: Variant);
begin
  FPEDIDO_VENDA_ID := Value;
end;

procedure TFinanceiroPedidoModel.SetPER_SEG_PRESTAMSTA(const Value: Variant);
begin
  FPER_SEG_PRESTAMSTA := Value;
end;

procedure TFinanceiroPedidoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TFinanceiroPedidoModel.SetQUANTIDADE_PARCELAS(const Value: Variant);
begin
  FQUANTIDADE_PARCELAS := Value;
end;

procedure TFinanceiroPedidoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFinanceiroPedidoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TFinanceiroPedidoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_ACRESCIMO(const Value: Variant);
begin
  FVALOR_ACRESCIMO := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_ACRESCIMO_SEG_PRESTAMISTA(
  const Value: Variant);
begin
  FVALOR_ACRESCIMO_SEG_PRESTAMISTA := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_LIQUIDO(const Value: Variant);
begin
  FVALOR_LIQUIDO := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_PARCELA(const Value: Variant);
begin
  FVALOR_PARCELA := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_SEG_PRESTAMISTA(const Value: Variant);
begin
  FVALOR_SEG_PRESTAMISTA := Value;
end;

procedure TFinanceiroPedidoModel.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;

procedure TFinanceiroPedidoModel.SetVENCIMENTO(const Value: Variant);
begin
  FVENCIMENTO := Value;
end;

procedure TFinanceiroPedidoModel.SetWEB_PEDIDOITENS_ID(const Value: Variant);
begin
  FWEB_PEDIDOITENS_ID := Value;
end;

procedure TFinanceiroPedidoModel.SetWEB_PEDIDO_ID(const Value: Variant);
begin
  FWEB_PEDIDO_ID := Value;
end;

procedure TFinanceiroPedidoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
