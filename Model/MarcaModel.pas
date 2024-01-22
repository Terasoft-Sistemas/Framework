unit MarcaModel;

interface

uses
  Terasoft.Enumerado,
  Terasoft.Web.Types,
  MarcaDao,
  FireDAC.Comp.Client;

type
  TMarcaModel = class

  private

 public

  	constructor Create;
    destructor Destroy; override;

    function ObterLista(pMarca_Parametros: TMarca_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TMarcaModel }

constructor TMarcaModel.Create;
begin

end;

destructor TMarcaModel.Destroy;
begin

  inherited;
end;

function TMarcaModel.ObterLista(pMarca_Parametros: TMarca_Parametros): TFDMemTable;
var
  lMarcaDao: TMarcaDao;
  lMarca_Parametros: TMarca_Parametros;
begin
  lMarcaDao := TMarcaDao.Create;

  try
    lMarca_Parametros.Marcas := pMarca_Parametros.Marcas;

    Result := lMarcaDao.ObterLista(lMarca_Parametros);

  finally
    lMarcaDao.Free;
  end;
end;

end.
