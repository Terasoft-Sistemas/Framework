unit DashbordModel;

interface

uses
  Terasoft.Types,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TDashbordModel = class

  private
    vIConexao : IConexao;
  public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
    function ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;

    function ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
  end;

implementation

uses
  DashbordDao, System.SysUtils;

{ TDashbordModel }

constructor TDashbordModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDashbordModel.Destroy;
begin

  inherited;
end;

function TDashbordModel.ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lDashbordDao: TDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.Create(vIconexao);

  try
    lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
    lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
    lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
    lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
    lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
    lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
    lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
    lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
    lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

    Result := lDashbordDao.ObterQuery1_Totalizador(lDashbord_Parametros);

  finally
    lDashbordDao.Free;
  end;
end;

function TDashbordModel.ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lDashbordDao: TDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.Create(vIConexao);

  try
    lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
    lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
    lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
    lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
    lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
    lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
    lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
    lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
    lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

    Result := lDashbordDao.ObterQuery2_VendaPorDia(lDashbord_Parametros);

  finally
    lDashbordDao.Free;
  end;
end;

function TDashbordModel.ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lDashbordDao: TDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.Create(vIConexao);

  try
    lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
    lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
    lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
    lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
    lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
    lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
    lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
    lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
    lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

    Result := lDashbordDao.ObterQuery3_VendaPorAno(lDashbord_Parametros);

  finally
    lDashbordDao.Free;
  end;
end;

function TDashbordModel.ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lDashbordDao: TDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.Create(vIConexao);

  try
    lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
    lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
    lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
    lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
    lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
    lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
    lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
    lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
    lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

    Result := lDashbordDao.ObterQuery4_VendaPorHora(lDashbord_Parametros);

  finally
    lDashbordDao.Free;
  end;
end;

function TDashbordModel.ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lDashbordDao: TDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.Create(vIConexao);

  try
    lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
    lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
    lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
    lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
    lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
    lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
    lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
    lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
    lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

    Result := lDashbordDao.ObterQuery6_RankingVendedores(lDashbord_Parametros);

  finally
    lDashbordDao.Free;
  end;
end;

function TDashbordModel.ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lDashbordDao: TDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.Create(vIConexao);

  try
    lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
    lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
    lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
    lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
    lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
    lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
    lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
    lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
    lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

    Result := lDashbordDao.ObterQuery7_RankingFiliais(lDashbord_Parametros);

  finally
    lDashbordDao.Free;
  end;
end;

function TDashbordModel.ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): TFDMemTable;
var
  lDashbordDao: TDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.Create(vIConexao);

  try
    lDashbord_Parametros.Lojas := pDashbord_Parametros.Lojas;

    Result := lDashbordDao.ObterQuery_Anos(lDashbord_Parametros);

  finally
    lDashbordDao.Free;
  end;
end;

end.
