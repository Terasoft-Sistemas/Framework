unit PrevisaoPedidoCompraModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client,
  PedidoCompraModel;

type

  TPrevisaoPedidoCompraModel = class

  private
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


  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TPrevisaoPedidoCompraModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TPrevisaoPedidoCompraModel;

    function ObterLista: TFDMemTable; overload;

    function SaldoFinanceiro(pNumeroPedido, pFornecedorID: String): Double;

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

function TPrevisaoPedidoCompraModel.Alterar(pID: String): TPrevisaoPedidoCompraModel;
var
  lPrevisaoPedidoCompraModel : TPrevisaoPedidoCompraModel;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.Create(vIConexao);
  try
    lPrevisaoPedidoCompraModel       := lPrevisaoPedidoCompraModel.carregaClasse(pID);
    lPrevisaoPedidoCompraModel.Acao  := tacAlterar;
    Result            := lPrevisaoPedidoCompraModel;
  finally
  end;
end;

function TPrevisaoPedidoCompraModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TPrevisaoPedidoCompraModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TPrevisaoPedidoCompraModel.carregaClasse(pId : String): TPrevisaoPedidoCompraModel;
var
  lPrevisaoPedidoCompraDao: TPrevisaoPedidoCompraDao;
begin
  lPrevisaoPedidoCompraDao := TPrevisaoPedidoCompraDao.Create(vIConexao);

  try
    Result := lPrevisaoPedidoCompraDao.carregaClasse(pId);
  finally
    lPrevisaoPedidoCompraDao.Free;
  end;
end;

constructor TPrevisaoPedidoCompraModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPrevisaoPedidoCompraModel.Destroy;
begin
  inherited;
end;

function TPrevisaoPedidoCompraModel.obterLista: TFDMemTable;
var
  lPrevisaoPedidoCompraDao: TPrevisaoPedidoCompraDao;
begin
  lPrevisaoPedidoCompraDao:= TPrevisaoPedidoCompraDao.Create(vIConexao);

  try
    lPrevisaoPedidoCompraDao.TotalRecords    := FTotalRecords;
    lPrevisaoPedidoCompraDao.WhereView       := FWhereView;
    lPrevisaoPedidoCompraDao.CountView       := FCountView;
    lPrevisaoPedidoCompraDao.OrderView       := FOrderView;
    lPrevisaoPedidoCompraDao.StartRecordView := FStartRecordView;
    lPrevisaoPedidoCompraDao.LengthPageView  := FLengthPageView;
    lPrevisaoPedidoCompraDao.IDRecordView    := FIDRecordView;

    Result := lPrevisaoPedidoCompraDao.obterLista;

    FTotalRecords := lPrevisaoPedidoCompraDao.TotalRecords;

  finally
    lPrevisaoPedidoCompraDao.Free;
  end;
end;

function TPrevisaoPedidoCompraModel.SaldoFinanceiro(pNumeroPedido, pFornecedorID: String): Double;
var
  lPrevisaoPedidoCompraDao: TPrevisaoPedidoCompraDao;
  lPedidoCompraModel: TPedidoCompraModel;
  lTotalizador: TFDMemTable;
  lTotalFinanceiro: Double;
  lTotalPedido: Double;
begin
  lPrevisaoPedidoCompraDao := TPrevisaoPedidoCompraDao.Create(vIConexao);
  lPedidoCompraModel := TPedidoCompraModel.Create(vIConexao);
  try

    lPedidoCompraModel.NumeroView     := pNumeroPedido;
    lPedidoCompraModel.FornecedorView := pFornecedorID;

    lTotalizador := lPedidoCompraModel.ObterTotalizador;

    lTotalPedido     := RoundTo(StrToFloat(FloatToStr(lTotalizador.FieldByName('valor_total_pedido').AsFloat)), -2);
    lTotalFinanceiro := RoundTo(lPrevisaoPedidoCompraDao.TotalFinanceiro(pNumeroPedido), -2);

    Result :=  lTotalPedido - lTotalFinanceiro;

  finally
    lPrevisaoPedidoCompraDao.Free;
    lPedidoCompraModel.Free;
  end;
end;

procedure TPrevisaoPedidoCompraModel.ValidaTotalFinanceiro(pValor: Double);
var
  lPrevisaoPedidoCompraDao: TPrevisaoPedidoCompraDao;
  lPedidoCompraModel: TPedidoCompraModel;
  lTotalizador  : TFDMemTable;
  lTotalFinanceiro: Double;
begin
  lPrevisaoPedidoCompraDao := TPrevisaoPedidoCompraDao.Create(vIConexao);
  lPedidoCompraModel := TPedidoCompraModel.Create(vIConexao);
  try

     lPedidoCompraModel.NumeroView   := FNUMERO_PED;
     lTotalizador                    := lPedidoCompraModel.obterTotalizador;
     lTotalFinanceiro                := lPrevisaoPedidoCompraDao.TotalFinanceiro(FNUMERO_PED);

     if (Round(lTotalFinanceiro + pValor )) > (Round(lTotalizador.FieldByName('valor_total_pedido').AsFloat)) then
       raise Exception.Create('Financeiro já informado ou valor informado maior que o saldo a informar (Total já informado: '+FormatFloat(',0.00', lTotalFinanceiro)+')');

  finally
    lPrevisaoPedidoCompraDao.Free;
    lPedidoCompraModel.Free;
  end;
end;

function TPrevisaoPedidoCompraModel.Salvar: String;
var
  lPrevisaoPedidoCompraDao: TPrevisaoPedidoCompraDao;
begin
  lPrevisaoPedidoCompraDao := TPrevisaoPedidoCompraDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPrevisaoPedidoCompraDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lPrevisaoPedidoCompraDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lPrevisaoPedidoCompraDao.excluir(Self);
    end;
  finally
    lPrevisaoPedidoCompraDao.Free;
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
