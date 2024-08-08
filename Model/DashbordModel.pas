unit DashbordModel;

interface

uses
  Terasoft.Types,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TDashbordModel = class;
  ITDashbordModel=IObject<TDashbordModel>;

  TDashbordModel = class
  private
    [weak] mySelf: ITDashbordModel;
    vIConexao : IConexao;
  public

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDashbordModel;

    function ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
    function ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;

    function ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
  end;

implementation

uses
  DashbordDao, System.SysUtils;

{ TDashbordModel }

constructor TDashbordModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDashbordModel.Destroy;
begin

  inherited;
end;

class function TDashbordModel.getNewIface(pIConexao: IConexao): ITDashbordModel;
begin
  Result := TImplObjetoOwner<TDashbordModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDashbordModel.ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(vIconexao);

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

    Result := lDashbordDao.objeto.ObterQuery1_Totalizador(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;

function TDashbordModel.ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(vIConexao);

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

    Result := lDashbordDao.objeto.ObterQuery2_VendaPorDia(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;

function TDashbordModel.ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(vIConexao);

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

    Result := lDashbordDao.objeto.ObterQuery3_VendaPorAno(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;

function TDashbordModel.ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(vIConexao);

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

    Result := lDashbordDao.objeto.ObterQuery4_VendaPorHora(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;

function TDashbordModel.ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(vIConexao);

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

    Result := lDashbordDao.objeto.ObterQuery6_RankingVendedores(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;

function TDashbordModel.ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(vIConexao);

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

    Result := lDashbordDao.objeto.ObterQuery7_RankingFiliais(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;

function TDashbordModel.ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(vIConexao);

  try
    lDashbord_Parametros.Lojas := pDashbord_Parametros.Lojas;

    Result := lDashbordDao.objeto.ObterQuery_Anos(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;

end.
