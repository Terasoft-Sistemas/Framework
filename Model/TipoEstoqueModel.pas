unit TipoEstoqueModel;

interface

uses
  Terasoft.Types,
  TipoEstoqueDao,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TTipoEstoqueModel = class

  private
    vIConexao : IConexao;
  public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): IFDDataset;

  end;

implementation

uses
  System.SysUtils;

{ TTipoEstoqueModel }

constructor TTipoEstoqueModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTipoEstoqueModel.Destroy;
begin

  inherited;
end;

function TTipoEstoqueModel.ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): IFDDataset;
var
  lTipoEstoqueDao: TTipoEstoqueDao;
  lTipoEstoque_Parametros: TTipoEstoque_Parametros;
begin
  lTipoEstoqueDao := TTipoEstoqueDao.Create(vICOnexao);

  try
    lTipoEstoque_Parametros.TipoEstoques := pTipoEstoque_Parametros.TipoEstoques;

    Result := lTipoEstoqueDao.ObterLista(lTipoEstoque_Parametros);

  finally
    lTipoEstoqueDao.Free;
  end;
end;

end.
