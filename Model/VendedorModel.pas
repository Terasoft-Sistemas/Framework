unit VendedorModel;

interface

uses
  Terasoft.Types,
  VendedorDao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TVendedorModel = class

  private
    vIConexao : IConexao;
  public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pVendedor_Parametros: TVendedor_Parametros): IFDDataset;
    function obterMeta(pVendedor : String; pDataInicial, pDataFinal : TDate): Double;

  end;

implementation

uses
  System.SysUtils;

{ TVendedorModel }

constructor TVendedorModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TVendedorModel.Destroy;
begin

  inherited;
end;

function TVendedorModel.ObterLista(pVendedor_Parametros: TVendedor_Parametros): IFDDataset;
var
  lVendedorDao: TVendedorDao;
  lVendedor_Parametros: TVendedor_Parametros;
begin
  lVendedorDao := TVendedorDao.Create(vIConexao);

  try
    lVendedor_Parametros.Vendedores := pVendedor_Parametros.Vendedores;

    Result := lVendedorDao.ObterLista(lVendedor_Parametros);

  finally
    lVendedorDao.Free;
  end;
end;

function TVendedorModel.obterMeta(pVendedor: String; pDataInicial, pDataFinal: TDate): Double;
var
  lVendedorDao: TVendedorDao;
begin
  lVendedorDao := TVendedorDao.Create(vIConexao);

  try
    Result := lVendedorDao.obterMeta(pVendedor, pDataInicial, pDataFinal);
  finally
    lVendedorDao.Free;
  end;
end;

end.
