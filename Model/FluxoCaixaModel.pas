unit FluxoCaixaModel;

interface

uses
  Terasoft.Types,
  Interfaces.Conexao,
  System.Generics.Collections,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TFluxoCaixaModel = class;
  ITFluxoCaixaModel=IObject<TFluxoCaixaModel>;

  TFluxoCaixaModel = class
  private
    [weak] mySelf: ITFluxoCaixaModel;
    vIConexao : IConexao;

    FWhereView: String;
    FSomarBancosView: Boolean;
    FPorcentagemInadimplenciaView: Real;
    FBancoView: String;
    FPortadorView: String;
    FDataFinalView: Variant;
    FDataInicialView: Variant;
    FOrderView: String;
    FTipoView: String;
    FLojaView: Variant;

    procedure SetWhereView(const Value: String);
    procedure SetBancoView(const Value: String);
    procedure SetDataFinalView(const Value: Variant);
    procedure SetDataInicialView(const Value: Variant);
    procedure SetPorcentagemInadimplenciaView(const Value: Real);
    procedure SetPortadorView(const Value: String);
    procedure SetSomarBancosView(const Value: Boolean);
    procedure SetOrderView(const Value: String);
    procedure SetTipoView(const Value: String);
    procedure SetLojaView(const Value: Variant);

  public

  	constructor _Create (pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITFluxoCaixaModel;

    function obterFluxoCaixaSintetico : IFDDataset;
    function obterFluxoCaixaAnalitico : IFDDataset;
    function obterResumo              : IFDDataset;
    function obterResultadoFluxoCaixa : IFDDataset;

    property WhereView: String read FWhereView write SetWhereView;
    property OrderView: String read FOrderView write SetOrderView;
    property DataInicialView: Variant read FDataInicialView write SetDataInicialView;
    property DataFinalView: Variant read FDataFinalView write SetDataFinalView;
    property BancoView: String read FBancoView write SetBancoView;
    property PortadorView: String read FPortadorView write SetPortadorView;
    property PorcentagemInadimplenciaView: Real read FPorcentagemInadimplenciaView write SetPorcentagemInadimplenciaView;
    property SomarBancosView: Boolean read FSomarBancosView write SetSomarBancosView;
    property TipoView: String read FTipoView write SetTipoView;
    property LojaView : Variant read FLojaView write SetLojaView;
  end;

implementation

uses
  FluxoCaixaDao;

{ TFluxoCaixaModel }

constructor TFluxoCaixaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFluxoCaixaModel.Destroy;
begin

  inherited;
end;

class function TFluxoCaixaModel.getNewIface(pIConexao: IConexao): ITFluxoCaixaModel;
begin
  Result := TImplObjetoOwner<TFluxoCaixaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TFluxoCaixaModel.obterResultadoFluxoCaixa : IFDDataset;
var
  lFluxoCaixa: ITFluxoCaixaDao;
begin
  lFluxoCaixa := TFluxoCaixaDao.getNewIface(vIConexao);
  try
    lFluxoCaixa.objeto.WhereView                    := FWhereView;
    lFluxoCaixa.objeto.OrderView                    := FOrderView;
    lFluxoCaixa.objeto.DataInicialView              := FDataInicialView;
    lFluxoCaixa.objeto.DataFinalView                := FDataFinalView;
    lFluxoCaixa.objeto.BancoView                    := FBancoView;
    lFluxoCaixa.objeto.PortadorView                 := FPortadorView;
    lFluxoCaixa.objeto.PorcentagemInadimplenciaView := FPorcentagemInadimplenciaView;
    lFluxoCaixa.objeto.SomarBancosView              := FSomarBancosView;
    lFluxoCaixa.objeto.TipoView                     := FTipoView;
    lFluxoCaixa.objeto.LojaView                     := FLojaView;

    Result := lFluxoCaixa.objeto.obterResultadoFluxoCaixa;
  finally
    lFluxoCaixa:=nil;
  end;
end;

function TFluxoCaixaModel.obterResumo: IFDDataset;
var
  lFluxoCaixa: ITFluxoCaixaDao;
begin
  lFluxoCaixa := TFluxoCaixaDao.getNewIface(vIConexao);
  try
    lFluxoCaixa.objeto.WhereView                    := FWhereView;
    lFluxoCaixa.objeto.OrderView                    := FOrderView;
    lFluxoCaixa.objeto.DataInicialView              := FDataInicialView;
    lFluxoCaixa.objeto.DataFinalView                := FDataFinalView;
    lFluxoCaixa.objeto.BancoView                    := FBancoView;
    lFluxoCaixa.objeto.PortadorView                 := FPortadorView;
    lFluxoCaixa.objeto.PorcentagemInadimplenciaView := FPorcentagemInadimplenciaView;
    lFluxoCaixa.objeto.SomarBancosView              := FSomarBancosView;
    lFluxoCaixa.objeto.TipoView                     := FTipoView;
    lFluxoCaixa.objeto.LojaView                     := FLojaView;

    Result := lFluxoCaixa.objeto.obterResumo;
  finally
    lFluxoCaixa:=nil;
  end;
end;

function TFluxoCaixaModel.obterFluxoCaixaSintetico: IFDDataset;
var
  lFluxoCaixaLista: ITFluxoCaixaDao;

begin
  lFluxoCaixaLista := TFluxoCaixaDao.getNewIface(vIConexao);

  try
    lFluxoCaixaLista.objeto.WhereView                    := FWhereView;
    lFluxoCaixaLista.objeto.OrderView                    := FOrderView;
    lFluxoCaixaLista.objeto.DataInicialView              := FDataInicialView;
    lFluxoCaixaLista.objeto.DataFinalView                := FDataFinalView;
    lFluxoCaixaLista.objeto.BancoView                    := FBancoView;
    lFluxoCaixaLista.objeto.PortadorView                 := FPortadorView;
    lFluxoCaixaLista.objeto.PorcentagemInadimplenciaView := FPorcentagemInadimplenciaView;
    lFluxoCaixaLista.objeto.SomarBancosView              := FSomarBancosView;
    lFluxoCaixaLista.objeto.TipoView                     := FTipoView;
    lFluxoCaixaLista.objeto.LojaView                     := FLojaView;

    Result := lFluxoCaixaLista.objeto.obterFluxoCaixaSintetico;

  finally
    lFluxoCaixaLista:=nil;
  end;
end;

function TFluxoCaixaModel.obterFluxoCaixaAnalitico: IFDDataset;
var
  lFluxoCaixaLista: ITFluxoCaixaDao;
begin
  lFluxoCaixaLista := TFluxoCaixaDao.getNewIface(vIConexao);
  try
    lFluxoCaixaLista.objeto.WhereView                    := FWhereView;
    lFluxoCaixaLista.objeto.OrderView                    := FOrderView;
    lFluxoCaixaLista.objeto.DataInicialView              := FDataInicialView;
    lFluxoCaixaLista.objeto.DataFinalView                := FDataFinalView;
    lFluxoCaixaLista.objeto.BancoView                    := FBancoView;
    lFluxoCaixaLista.objeto.PortadorView                 := FPortadorView;
    lFluxoCaixaLista.objeto.PorcentagemInadimplenciaView := FPorcentagemInadimplenciaView;
    lFluxoCaixaLista.objeto.SomarBancosView              := FSomarBancosView;
    lFluxoCaixaLista.objeto.TipoView                     := FTipoView;
    lFluxoCaixaLista.objeto.LojaView                     := FLojaView;

    Result := lFluxoCaixaLista.objeto.obterFluxoCaixaAnalitico;

  finally
    lFluxoCaixaLista:=nil;
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

procedure TFluxoCaixaModel.SetLojaView(const Value: Variant);
begin
  FLojaView := Value;
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

procedure TFluxoCaixaModel.SetTipoView(const Value: String);
begin
  FTipoView := Value;
end;

procedure TFluxoCaixaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
