unit TipoVendaModel;

interface

uses
  Terasoft.Enumerado,
  Terasoft.Web.Types,
  TipoVendaDao,
  FireDAC.Comp.Client;

type
  TTipoVendaModel = class

  private

 public

  	constructor Create;
    destructor Destroy; override;

    function ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TTipoVendaModel }

constructor TTipoVendaModel.Create;
begin

end;

destructor TTipoVendaModel.Destroy;
begin

  inherited;
end;

function TTipoVendaModel.ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): TFDMemTable;
var
  lTipoVendaDao: TTipoVendaDao;
  lTipoVenda_Parametros: TTipoVenda_Parametros;
begin
  lTipoVendaDao := TTipoVendaDao.Create;

  try
    lTipoVenda_Parametros.TipoVendas := pTipoVenda_Parametros.TipoVendas;

    Result := lTipoVendaDao.ObterLista(lTipoVenda_Parametros);

  finally
    lTipoVendaDao.Free;
  end;
end;

end.
