unit GrupoModel;

interface

uses
  Terasoft.Enumerado,
  Terasoft.Web.Types,
  GrupoDao,
  FireDAC.Comp.Client;

type
  TGrupoModel = class

  private

 public

  	constructor Create;
    destructor Destroy; override;

    function ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TGrupoModel }

constructor TGrupoModel.Create;
begin

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
  lGrupoDao := TGrupoDao.Create;

  try
    lGrupo_Parametros.Grupos := pGrupo_Parametros.Grupos;

    Result := lGrupoDao.ObterLista(lGrupo_Parametros);

  finally
    lGrupoDao.Free;
  end;
end;

end.
