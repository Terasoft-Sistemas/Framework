unit EndpointController;

interface
uses
  Terasoft.Framework.Types,
  System.SysUtils,
  EndpointModel,
  Interfaces.Conexao;

type

  IController_Endpoint = interface
  ['{A1E3DBAB-512C-46E3-82C5-773443E8F779}']
    function getByName(pName: TipoWideStringFramework): ITEndpointModel;
    function getLista(pNames: IListaString=nil): TListaEndpointModel;
  end;

  function getEndpointController(pIConexao:IConexao):IController_Endpoint;

implementation
  uses
    EndpointDao;

type
  TControllerEndpoint = class(TInterfacedObject, IController_Endpoint)
  protected
    fModel: ITEndpointModel;
    fLista: TListaEndpointModel;
    function getByName(pName: TipoWideStringFramework): ITEndpointModel;
    function getLista(pNames: IListaString): TListaEndpointModel;
  public
    vIConexao : IConexao;
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;
  end;

function getEndpointController;
begin
  Result := TControllerEndpoint.Create(pIConexao);
end;

{ TControllerEndpoint }

constructor TControllerEndpoint.Create(pIConexao: IConexao);
begin
  inherited Create;
  vIConexao := pIConexao;
end;

destructor TControllerEndpoint.Destroy;
begin
  fModel := nil;
  fLista := nil;
  vIConexao := nil;
  inherited;
end;

function TControllerEndpoint.getByName(pName: TipoWideStringFramework): ITEndpointModel;
begin
  fModel := TEndpointDao.getNewIface(vIConexao).objeto.getByName(pName);
  Result := fModel;
end;

function TControllerEndpoint.getLista;
begin
  fLista := TEndpointDao.getNewIface(vIConexao).objeto.getLista(pNames);
  Result := fLista;
end;

end.