unit VendedorModel;

interface

uses
  Terasoft.Enumerado,
  Terasoft.Web.Types,
  VendedorDao,
  FireDAC.Comp.Client;

type
  TVendedorModel = class

  private

 public

  	constructor Create;
    destructor Destroy; override;

    function ObterLista(pVendedor_Parametros: TVendedor_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TVendedorModel }

constructor TVendedorModel.Create;
begin

end;

destructor TVendedorModel.Destroy;
begin

  inherited;
end;

function TVendedorModel.ObterLista(pVendedor_Parametros: TVendedor_Parametros): TFDMemTable;
var
  lVendedorDao: TVendedorDao;
  lVendedor_Parametros: TVendedor_Parametros;
begin
  lVendedorDao := TVendedorDao.Create;

  try
    lVendedor_Parametros.Vendedores := pVendedor_Parametros.Vendedores;

    Result := lVendedorDao.ObterLista(lVendedor_Parametros);

  finally
    lVendedorDao.Free;
  end;
end;

end.
