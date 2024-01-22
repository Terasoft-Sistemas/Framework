unit SubGrupoModel;

interface

uses
  Terasoft.Enumerado,
  Terasoft.Web.Types,
  SubGrupoDao,
  FireDAC.Comp.Client;

type
  TSubGrupoModel = class

  private

 public

  	constructor Create;
    destructor Destroy; override;

    function ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TSubGrupoModel }

constructor TSubGrupoModel.Create;
begin

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
  lSubGrupoDao := TSubGrupoDao.Create;

  try
    lSubGrupo_Parametros.SubGrupos := pSubGrupo_Parametros.SubGrupos;

    Result := lSubGrupoDao.ObterLista(lSubGrupo_Parametros);

  finally
    lSubGrupoDao.Free;
  end;
end;

end.
