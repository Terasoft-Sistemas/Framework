unit TipoVendaModel;

interface

uses

  Terasoft.Types,
  TipoVendaDao,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TTipoVendaModel = class

  private
    vConexao : IConexao;
 public

  	constructor Create(pConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): IFDDataset;

  end;

implementation

uses
  System.SysUtils;

{ TTipoVendaModel }

constructor TTipoVendaModel.Create(pConexao : IConexao);
begin
    vConexao := pConexao;
end;

destructor TTipoVendaModel.Destroy;
begin

  inherited;
end;

function TTipoVendaModel.ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): IFDDataset;
var
  lTipoVendaDao: TTipoVendaDao;
  lTipoVenda_Parametros: TTipoVenda_Parametros;
begin
  lTipoVendaDao := TTipoVendaDao.Create(vConexao);

  try
    lTipoVenda_Parametros.TipoVendas := pTipoVenda_Parametros.TipoVendas;

    Result := lTipoVendaDao.ObterLista(lTipoVenda_Parametros);

  finally
    lTipoVendaDao.Free;
  end;
end;

end.
