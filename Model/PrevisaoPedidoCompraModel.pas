unit PrevisaoPedidoCompraModel;

interface

uses
  Terasoft.Types,
  System.DateUtils,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ObjectIface,
  PedidoCompraModel;

type

  TPrevisaoPedidoCompraModel = class;
  ITPrevisaoPedidoCompraModel=IObject<TPrevisaoPedidoCompraModel>;

  TPrevisaoPedidoCompraModel = class
  private
    [weak] mySelf: ITPrevisaoPedidoCompraModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCODIGO_FOR: Variant;
    FVENCIMENTO: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FNUMERO_PED: Variant;
    FVALOR_PARCELA: Variant;
    FPARCELA: Variant;


    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetNUMERO_PED(const Value: Variant);
    procedure SetPARCELA(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR_PARCELA(const Value: Variant);
    procedure SetVENCIMENTO(const Value: Variant);

  public

    property ID             : Variant read FID             write SetID;
    property VENCIMENTO     : Variant read FVENCIMENTO     write SetVENCIMENTO;
    property VALOR_PARCELA  : Variant read FVALOR_PARCELA  write SetVALOR_PARCELA;
    property PARCELA        : Variant read FPARCELA        write SetPARCELA;
    property NUMERO_PED     : Variant read FNUMERO_PED     write SetNUMERO_PED;
    property CODIGO_FOR     : Variant read FCODIGO_FOR     write SetCODIGO_FOR;
    property SYSTIME        : Variant read FSYSTIME        write SetSYSTIME;


  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPrevisaoPedidoCompraModel;

    function Incluir: String;
    function Alterar(pID : String): ITPrevisaoPedidoCompraModel;
    function Excluir(pNumeroPed, pCodigoFor : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITPrevisaoPedidoCompraModel;
    function SaldoFinanceiro(pNumeroPedido, pCodigoFornecedor: String): Double;
    function ObterLista: IFDDataset; overload;
    procedure gerarFinanceiro(pPedidoCompraModel : ITPedidoCompraModel);
    procedure ValidaTotalFinanceiro(pValor: Double);

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordview : String read FIDRecordview write SetIDRecordview;

  end;

implementation

uses
  PrevisaoPedidoCompraDao,
  System.Classes,
  System.SysUtils, System.Math;

{ TPrevisaoPedidoCompraModel }

function TPrevisaoPedidoCompraModel.Alterar(pID: String): ITPrevisaoPedidoCompraModel;
var
  lPrevisaoPedidoCompraModel : ITPrevisaoPedidoCompraModel;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.getNewIface(vIConexao);
  try
    lPrevisaoPedidoCompraModel       := lPrevisaoPedidoCompraModel.objeto.carregaClasse(pID);
    lPrevisaoPedidoCompraModel.objeto.Acao  := tacAlterar;
    Result            := lPrevisaoPedidoCompraModel;
  finally
  end;
end;

function TPrevisaoPedidoCompraModel.Excluir(pNumeroPed, pCodigoFor: String): String;
begin
  self.NUMERO_PED := pNumeroPed;
  self.CODIGO_FOR := pCodigoFor;
  self.FAcao      := tacExcluir;
  Result          := self.Salvar;
end;

procedure TPrevisaoPedidoCompraModel.gerarFinanceiro(pPedidoCompraModel : ITPedidoCompraModel);
var
  lVencimentos : TStringList;
  i            : Integer;
  lSoma        : Double;
begin
  lVencimentos := TStringList.create;

  StringForStringList(pPedidoCompraModel.objeto.CONDICOES_PAG, '/', lVencimentos);

  lSoma := 0;
  i     := 0;

  for i := 0 to lVencimentos.Count - 1 do
  begin
    self.FVENCIMENTO     := DateToStr(IncDay(StrToDate(pPedidoCompraModel.objeto.DATA_PED), StrToInt(lVencimentos.Strings[i])) );
    self.FVALOR_PARCELA  := RoundTo(pPedidoCompraModel.objeto.TOTAL_PED / lVencimentos.Count, -2);
    self.FPARCELA        := (i + 1).ToString;
    self.FNUMERO_PED     := pPedidoCompraModel.objeto.NUMERO_PED;
    self.FCODIGO_FOR     := pPedidoCompraModel.objeto.CODIGO_FOR;

    lSoma := lSoma + self.FVALOR_PARCELA;

    if self.FPARCELA = lVencimentos.Count then
      self.FVALOR_PARCELA := self.FVALOR_PARCELA + (pPedidoCompraModel.objeto.TOTAL_PED - lSoma);

    Self.incluir;
  end;
end;

class function TPrevisaoPedidoCompraModel.getNewIface(pIConexao: IConexao): ITPrevisaoPedidoCompraModel;
begin
  Result := TImplObjetoOwner<TPrevisaoPedidoCompraModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPrevisaoPedidoCompraModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TPrevisaoPedidoCompraModel.carregaClasse(pId : String): ITPrevisaoPedidoCompraModel;
var
  lPrevisaoPedidoCompraDao: ITPrevisaoPedidoCompraDao;
begin
  lPrevisaoPedidoCompraDao := TPrevisaoPedidoCompraDao.getNewIface(vIConexao);

  try
    Result := lPrevisaoPedidoCompraDao.objeto.carregaClasse(pId);
  finally
    lPrevisaoPedidoCompraDao:=nil;
  end;
end;

constructor TPrevisaoPedidoCompraModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPrevisaoPedidoCompraModel.Destroy;
begin
  inherited;
end;

function TPrevisaoPedidoCompraModel.obterLista: IFDDataset;
var
  lPrevisaoPedidoCompraDao: ITPrevisaoPedidoCompraDao;
begin
  lPrevisaoPedidoCompraDao:= TPrevisaoPedidoCompraDao.getNewIface(vIConexao);

  try
    lPrevisaoPedidoCompraDao.objeto.TotalRecords    := FTotalRecords;
    lPrevisaoPedidoCompraDao.objeto.WhereView       := FWhereView;
    lPrevisaoPedidoCompraDao.objeto.CountView       := FCountView;
    lPrevisaoPedidoCompraDao.objeto.OrderView       := FOrderView;
    lPrevisaoPedidoCompraDao.objeto.StartRecordView := FStartRecordView;
    lPrevisaoPedidoCompraDao.objeto.LengthPageView  := FLengthPageView;
    lPrevisaoPedidoCompraDao.objeto.IDRecordView    := FIDRecordView;

    Result := lPrevisaoPedidoCompraDao.objeto.obterLista;

    FTotalRecords := lPrevisaoPedidoCompraDao.objeto.TotalRecords;

  finally
    lPrevisaoPedidoCompraDao:=nil;
  end;
end;

function TPrevisaoPedidoCompraModel.SaldoFinanceiro(pNumeroPedido, pCodigoFornecedor: String): Double;
var
  lPrevisaoPedidoCompraDao: ITPrevisaoPedidoCompraDao;
  lPedidoCompraModel: ITPedidoCompraModel;
  lTotalizador: IFDDataset;
  lTotalFinanceiro: Double;
  lTotalPedido: Double;
begin
  lPrevisaoPedidoCompraDao := TPrevisaoPedidoCompraDao.getNewIface(vIConexao);
  lPedidoCompraModel := TPedidoCompraModel.getNewIface(vIConexao);
  try

    lPedidoCompraModel.objeto.NumeroView     := pNumeroPedido;
    lPedidoCompraModel.objeto.FornecedorView := pCodigoFornecedor;

    lTotalizador := lPedidoCompraModel.objeto.ObterTotalizador;

    lTotalPedido     := RoundTo(StrToFloat(FloatToStr(lTotalizador.objeto.FieldByName('valor_total_pedido').AsFloat)), -2);
    lTotalFinanceiro := RoundTo(lPrevisaoPedidoCompraDao.objeto.TotalFinanceiro(pNumeroPedido), -2);

    Result :=  lTotalPedido - lTotalFinanceiro;

  finally
    lPrevisaoPedidoCompraDao:=nil;
    lPedidoCompraModel:=nil;
  end;
end;

procedure TPrevisaoPedidoCompraModel.ValidaTotalFinanceiro(pValor: Double);
var
  lPrevisaoPedidoCompraDao: ITPrevisaoPedidoCompraDao;
  lPedidoCompraModel: ITPedidoCompraModel;
  lTotalizador  : IFDDataset;
  lTotalFinanceiro: Double;
begin
  lPrevisaoPedidoCompraDao := TPrevisaoPedidoCompraDao.getNewIface(vIConexao);
  lPedidoCompraModel := TPedidoCompraModel.getNewIface(vIConexao);
  try

     lPedidoCompraModel.objeto.NumeroView   := FNUMERO_PED;
     lTotalizador                    := lPedidoCompraModel.objeto.obterTotalizador;
     lTotalFinanceiro                := lPrevisaoPedidoCompraDao.objeto.TotalFinanceiro(FNUMERO_PED);

     if (Round(lTotalFinanceiro + pValor )) > (Round(lTotalizador.objeto.FieldByName('valor_total_pedido').AsFloat)) then
       raise Exception.Create('Financeiro já informado ou valor informado maior que o saldo a informar (Total já informado: '+FormatFloat(',0.00', lTotalFinanceiro)+')');

  finally
    lPrevisaoPedidoCompraDao:=nil;
    lPedidoCompraModel:=nil;
  end;
end;

function TPrevisaoPedidoCompraModel.Salvar: String;
var
  lPrevisaoPedidoCompraDao: ITPrevisaoPedidoCompraDao;
begin
  lPrevisaoPedidoCompraDao := TPrevisaoPedidoCompraDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPrevisaoPedidoCompraDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lPrevisaoPedidoCompraDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lPrevisaoPedidoCompraDao.objeto.excluir(mySelf);
    end;
  finally
    lPrevisaoPedidoCompraDao:=nil;
  end;
end;

procedure TPrevisaoPedidoCompraModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetNUMERO_PED(const Value: Variant);
begin
  FNUMERO_PED := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TPrevisaoPedidoCompraModel.SetPARCELA(const Value: Variant);
begin
  FPARCELA := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TPrevisaoPedidoCompraModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TPrevisaoPedidoCompraModel.SetVALOR_PARCELA(const Value: Variant);
begin
  FVALOR_PARCELA := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetVENCIMENTO(const Value: Variant);
begin
  FVENCIMENTO := Value;
end;

procedure TPrevisaoPedidoCompraModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
