unit MarcaModel;

interface

uses
  Terasoft.Types,
  MarcaDao,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TMarcaModel = class

  private
    vIConexao : IConexao;
  public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pMarca_Parametros: TMarca_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TMarcaModel }

constructor TMarcaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
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
  lMarcaDao := TMarcaDao.Create(vIConexao);

  try
    lMarca_Parametros.Marcas := pMarca_Parametros.Marcas;

    Result := lMarcaDao.ObterLista(lMarca_Parametros);

  finally
    lMarcaDao.Free;
  end;
end;

end.
