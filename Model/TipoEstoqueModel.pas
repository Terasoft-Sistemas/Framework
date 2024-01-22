unit TipoEstoqueModel;

interface

uses
  Terasoft.Enumerado,
  Terasoft.Web.Types,
  TipoEstoqueDao,
  FireDAC.Comp.Client;

type
  TTipoEstoqueModel = class

  private

 public

  	constructor Create;
    destructor Destroy; override;

    function ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TTipoEstoqueModel }

constructor TTipoEstoqueModel.Create;
begin

end;

destructor TTipoEstoqueModel.Destroy;
begin

  inherited;
end;

function TTipoEstoqueModel.ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): TFDMemTable;
var
  lTipoEstoqueDao: TTipoEstoqueDao;
  lTipoEstoque_Parametros: TTipoEstoque_Parametros;
begin
  lTipoEstoqueDao := TTipoEstoqueDao.Create;

  try
    lTipoEstoque_Parametros.TipoEstoques := pTipoEstoque_Parametros.TipoEstoques;

    Result := lTipoEstoqueDao.ObterLista(lTipoEstoque_Parametros);

  finally
    lTipoEstoqueDao.Free;
  end;
end;

end.
