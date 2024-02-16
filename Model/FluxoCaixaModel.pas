unit FluxoCaixaModel;

interface

uses
  Terasoft.Types,
  Interfaces.Conexao,
  System.Generics.Collections,
  FireDAC.Comp.Client;

type
  TFluxoCaixaModel = class

  private
    vIConexao : IConexao;

    FFluxoCaixasLista: TObjectList<TFluxoCaixaModel>;
    FWhereView: String;
    FSomarBancosView: Boolean;
    FPorcentagemInadimplenciaView: Real;
    FBancoView: String;
    FPortadorView: String;
    FDataFinalView: Variant;
    FDataInicialView: Variant;
    FResumo_A_Pagar: Real;
    FResumo_A_Receber: Real;
    FResumo_A_Receber_Registros: Integer;
    FResumo_A_Pagar_Registros: Integer;
    FResultado_APagar: Real;
    FResultado_SaldoAtualBancos: Real;
    FResultado_Inadimplencia: Real;
    FResultado_Total: Real;
    FResultado_AReceber: Real;
    FOrderView: String;

    procedure SetFluxoCaixasLista(const Value: TObjectList<TFluxoCaixaModel>);
    procedure SetWhereView(const Value: String);
    procedure SetBancoView(const Value: String);
    procedure SetDataFinalView(const Value: Variant);
    procedure SetDataInicialView(const Value: Variant);
    procedure SetPorcentagemInadimplenciaView(const Value: Real);
    procedure SetPortadorView(const Value: String);
    procedure SetSomarBancosView(const Value: Boolean);
    procedure SetResumo_A_Pagar(const Value: Real);
    procedure SetResumo_A_Receber(const Value: Real);
    procedure SetResumo_A_Pagar_Registros(const Value: Integer);
    procedure SetResumo_A_Receber_Registros(const Value: Integer);
    procedure SetResultado_APagar(const Value: Real);
    procedure SetResultado_AReceber(const Value: Real);
    procedure SetResultado_Inadimplencia(const Value: Real);
    procedure SetResultado_SaldoAtualBancos(const Value: Real);
    procedure SetResultado_Total(const Value: Real);
    procedure SetOrderView(const Value: String);

  public

    property Resumo_A_Receber: Real read FResumo_A_Receber write SetResumo_A_Receber;
    property Resumo_A_Receber_Registros: Integer read FResumo_A_Receber_Registros write SetResumo_A_Receber_Registros;
    property Resumo_A_Pagar: Real read FResumo_A_Pagar write SetResumo_A_Pagar;
    property Resumo_A_Pagar_Registros: Integer read FResumo_A_Pagar_Registros write SetResumo_A_Pagar_Registros;

    property Resultado_SaldoAtualBancos: Real read FResultado_SaldoAtualBancos write SetResultado_SaldoAtualBancos;
    property Resultado_AReceber: Real read FResultado_AReceber write SetResultado_AReceber;
    property Resultado_Inadimplencia: Real read FResultado_Inadimplencia write SetResultado_Inadimplencia;
    property Resultado_APagar: Real read FResultado_APagar write SetResultado_APagar;
    property Resultado_Total: Real read FResultado_Total write SetResultado_Total;

  	constructor Create (pIConexao : IConexao);
    destructor Destroy; override;

    function obterFluxoCaixaSintetico: TFDMemTable;
    function obterFluxoCaixaAnalitico: TFDMemTable;

    procedure obterResultadoFluxoCaixa;

    property FluxoCaixasLista: TObjectList<TFluxoCaixaModel> read FFluxoCaixasLista write SetFluxoCaixasLista;

    property WhereView: String read FWhereView write SetWhereView;
    property OrderView: String read FOrderView write SetOrderView;
    property DataInicialView: Variant read FDataInicialView write SetDataInicialView;
    property DataFinalView: Variant read FDataFinalView write SetDataFinalView;
    property BancoView: String read FBancoView write SetBancoView;
    property PortadorView: String read FPortadorView write SetPortadorView;
    property PorcentagemInadimplenciaView: Real read FPorcentagemInadimplenciaView write SetPorcentagemInadimplenciaView;
    property SomarBancosView: Boolean read FSomarBancosView write SetSomarBancosView;
  end;

implementation

uses
  FluxoCaixaDao;

{ TFluxoCaixaModel }

constructor TFluxoCaixaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFluxoCaixaModel.Destroy;
begin

  inherited;
end;

procedure TFluxoCaixaModel.obterResultadoFluxoCaixa;
var
  lFluxoCaixa: TFluxoCaixaDao;
begin
  lFluxoCaixa := TFluxoCaixaDao.Create(vIConexao);

  try
    lFluxoCaixa.DataInicialView              := FDataInicialView;
    lFluxoCaixa.DataFinalView                := FDataFinalView;
    lFluxoCaixa.BancoView                    := FBancoView;
    lFluxoCaixa.PortadorView                 := FPortadorView;
    lFluxoCaixa.PorcentagemInadimplenciaView := FPorcentagemInadimplenciaView;
    lFluxoCaixa.SomarBancosView              := FSomarBancosView;


    lFluxoCaixa.obterResultadoFluxoCaixa;

    FResultado_SaldoAtualBancos := lFluxoCaixa.Resultado_SaldoAtualBancos;
    FResultado_AReceber         := lFluxoCaixa.Resultado_AReceber;
    FResultado_Inadimplencia    := lFluxoCaixa.Resultado_Inadimplencia;
    FResultado_APagar           := lFluxoCaixa.Resultado_APagar;
    FResultado_Total            := lFluxoCaixa.Resultado_Total;

  finally
    lFluxoCaixa.Free;
  end;
end;

function TFluxoCaixaModel.obterFluxoCaixaSintetico: TFDMemTable;
var
  lFluxoCaixaLista: TFluxoCaixaDao;
begin
  lFluxoCaixaLista := TFluxoCaixaDao.Create(vIConexao);

  try
    lFluxoCaixaLista.WhereView                    := FWhereView;
    lFluxoCaixaLista.OrderView                    := FOrderView;
    lFluxoCaixaLista.DataInicialView              := FDataInicialView;
    lFluxoCaixaLista.DataFinalView                := FDataFinalView;
    lFluxoCaixaLista.BancoView                    := FBancoView;
    lFluxoCaixaLista.PortadorView                 := FPortadorView;
    lFluxoCaixaLista.PorcentagemInadimplenciaView := FPorcentagemInadimplenciaView;
    lFluxoCaixaLista.SomarBancosView              := FSomarBancosView;

    Result := lFluxoCaixaLista.obterFluxoCaixaSintetico;

  finally
    lFluxoCaixaLista.Free;
  end;
end;

function TFluxoCaixaModel.obterFluxoCaixaAnalitico: TFDMemTable;
var
  lFluxoCaixaLista: TFluxoCaixaDao;
begin
  lFluxoCaixaLista := TFluxoCaixaDao.Create(vIConexao);

  try
    lFluxoCaixaLista.WhereView                    := FWhereView;
    lFluxoCaixaLista.OrderView                    := FOrderView;
    lFluxoCaixaLista.DataInicialView              := FDataInicialView;
    lFluxoCaixaLista.DataFinalView                := FDataFinalView;
    lFluxoCaixaLista.BancoView                    := FBancoView;
    lFluxoCaixaLista.PortadorView                 := FPortadorView;
    lFluxoCaixaLista.PorcentagemInadimplenciaView := FPorcentagemInadimplenciaView;
    lFluxoCaixaLista.SomarBancosView              := FSomarBancosView;

    Result := lFluxoCaixaLista.obterFluxoCaixaAnalitico;

  finally
    lFluxoCaixaLista.Free;
  end;
end;

procedure TFluxoCaixaModel.SetBancoView(const Value: String);
begin
  FBancoView := Value;
end;

procedure TFluxoCaixaModel.SetDataFinalView(const Value: Variant);
begin
  FDataFinalView := Value;
end;

procedure TFluxoCaixaModel.SetDataInicialView(const Value: Variant);
begin
  FDataInicialView := Value;
end;

procedure TFluxoCaixaModel.SetFluxoCaixasLista(const Value: TObjectList<TFluxoCaixaModel>);
begin
  FFluxoCaixasLista := Value;
end;

procedure TFluxoCaixaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFluxoCaixaModel.SetPorcentagemInadimplenciaView(const Value: Real);
begin
  FPorcentagemInadimplenciaView := Value;
end;

procedure TFluxoCaixaModel.SetPortadorView(const Value: String);
begin
  FPortadorView := Value;
end;

procedure TFluxoCaixaModel.SetResultado_APagar(const Value: Real);
begin
  FResultado_APagar := Value;
end;

procedure TFluxoCaixaModel.SetResultado_AReceber(const Value: Real);
begin
  FResultado_AReceber := Value;
end;

procedure TFluxoCaixaModel.SetResultado_Inadimplencia(const Value: Real);
begin
  FResultado_Inadimplencia := Value;
end;

procedure TFluxoCaixaModel.SetResultado_SaldoAtualBancos(const Value: Real);
begin
  FResultado_SaldoAtualBancos := Value;
end;

procedure TFluxoCaixaModel.SetResultado_Total(const Value: Real);
begin
  FResultado_Total := Value;
end;

procedure TFluxoCaixaModel.SetResumo_A_Pagar(const Value: Real);
begin
  FResumo_A_Pagar := Value;
end;

procedure TFluxoCaixaModel.SetResumo_A_Pagar_Registros(const Value: Integer);
begin
  FResumo_A_Pagar_Registros := Value;
end;

procedure TFluxoCaixaModel.SetResumo_A_Receber(const Value: Real);
begin
  FResumo_A_Receber := Value;
end;

procedure TFluxoCaixaModel.SetResumo_A_Receber_Registros(const Value: Integer);
begin
  FResumo_A_Receber_Registros := Value;
end;

procedure TFluxoCaixaModel.SetSomarBancosView(const Value: Boolean);
begin
  FSomarBancosView := Value;
end;

procedure TFluxoCaixaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
