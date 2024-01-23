unit SubGrupoModel;

interface

uses
  Terasoft.Types,
  SubGrupoDao,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TSubGrupoModel = class

  private
    vIConexao : IConexao;
  public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TSubGrupoModel }

constructor TSubGrupoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TSubGrupoModel.Destroy;
begin

  inherited;
end;

function TSubGrupoModel.ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): TFDMemTable;
var
  lSubGrupoDao: TSubGrupoDao;
  lSubGrupo_Parametros: TSubGrupo_Parametros;
begin
  lSubGrupoDao := TSubGrupoDao.Create(vIConexao);

  try
    lSubGrupo_Parametros.SubGrupos := pSubGrupo_Parametros.SubGrupos;

    Result := lSubGrupoDao.ObterLista(lSubGrupo_Parametros);

  finally
    lSubGrupoDao.Free;
  end;
end;

end.
