unit GrupoModel;

interface

uses
  Terasoft.Types,
  GrupoDao,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TGrupoModel = class

  private
    vIConexao : IConexao;
  public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TGrupoModel }

constructor TGrupoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoModel.Destroy;
begin

  inherited;
end;

function TGrupoModel.ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable;
var
  lGrupoDao: TGrupoDao;
  lGrupo_Parametros: TGrupo_Parametros;
begin
  lGrupoDao := TGrupoDao.Create(vIConexao);
  try
    lGrupo_Parametros.Grupos := pGrupo_Parametros.Grupos;

    Result := lGrupoDao.ObterLista(lGrupo_Parametros);

  finally
    lGrupoDao.Free;
  end;
end;

end.
