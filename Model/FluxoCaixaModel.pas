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

    FWhereView: String;
    FSomarBancosView: Boolean;
    FPorcentagemInadimplenciaView: Real;
    FBancoView: String;
    FPortadorView: String;
    FDataFinalView: Variant;
    FDataInicialView: Variant;
    FOrderView: String;

    procedure SetWhereView(const Value: String);
    procedure SetBancoView(const Value: String);
    procedure SetDataFinalView(const Value: Variant);
    procedure SetDataInicialView(const Value: Variant);
    procedure SetPorcentagemInadimplenciaView(const Value: Real);
    procedure SetPortadorView(const Value: String);
    procedure SetSomarBancosView(const Value: Boolean);
    procedure SetOrderView(const Value: String);

  public

  	constructor Create (pIConexao : IConexao);
    destructor Destroy; override;

    function obterFluxoCaixaSintetico : TFDMemTable;
    function obterFluxoCaixaAnalitico : TFDMemTable;
    function obterResumo              : TFDMemTable;
    function obterResultadoFluxoCaixa : TFDMemTable;

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

function TFluxoCaixaModel.obterResultadoFluxoCaixa : TFDMemTable;
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

    Result := lFluxoCaixa.obterResultadoFluxoCaixa;
  finally
    lFluxoCaixa.Free;
  end;
end;

function TFluxoCaixaModel.obterResumo: TFDMemTable;
var
  lFluxoCaixa: TFluxoCaixaDao;
begin
  lFluxoCaixa := TFluxoCaixaDao.Create(vIConexao);
  try
    lFluxoCaixa.DataInicialView              := FDataInicialView;
    lFluxoCaixa.DataFinalView                := FDataFinalView;
    lFluxoCaixa.PortadorView                 := FPortadorView;

    Result := lFluxoCaixa.obterResumo;
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

procedure TFluxoCaixaModel.SetSomarBancosView(const Value: Boolean);
begin
  FSomarBancosView := Value;
end;

procedure TFluxoCaixaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
