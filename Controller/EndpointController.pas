unit EndpointController;

interface
uses
  Terasoft.Framework.Types,
  Terasoft.Framework.Texto,
  System.SysUtils,
  EndpointModel,
  DB,
  Terasoft.Framework.DB,
  Interfaces.Conexao;

type

  IController_Endpoint = interface
  ['{A1E3DBAB-512C-46E3-82C5-773443E8F779}']
    function getByName(pName: TipoWideStringFramework): ITEndpointModel;
    function getNovaLista(pFiltro: IListaTexto=nil; pStartingWith: boolean = false; pOrdem: Integer = 2): TListaEndpointModel; overload;
    function getNovaLista(pFiltro: TipoWideStringFramework = ''; pStartingWith: boolean = false; pOrdem: Integer = 2): TListaEndpointModel; overload;
    function getLista: TListaEndpointModel;
    function getFromRecord(pDataset: TDataset): ITEndpointModel;
    property lista: TListaEndpointModel read getLista;
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
    function getFromRecord(pDataset: TDataset): ITEndpointModel;
    function getByName(pName: TipoWideStringFramework): ITEndpointModel;
    function getNovaLista(pFiltro: IListaTexto=nil;pStartingWith:boolean=false;pOrdem: Integer = 2): TListaEndpointModel; overload;
    function getNovaLista(pFiltro: TipoWideStringFramework = ''; pStartingWith: boolean = false; pOrdem: Integer = 2): TListaEndpointModel; overload;
    function getLista: TListaEndpointModel;
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

function TControllerEndpoint.getFromRecord(pDataset: TDataset): ITEndpointModel;
begin
  Result := TEndpointDao.getNewIface(vIConexao).objeto.getFromRecord(pDataset);
end;

function TControllerEndpoint.getLista;
begin
  if(fLista=nil) then
    fLista := getNovaLista(nil);
  Result := fLista;
end;

function TControllerEndpoint.getNovaLista(pFiltro: TipoWideStringFramework = ''; pStartingWith: boolean = false; pOrdem: Integer = 2): TListaEndpointModel;
begin
  Result := self.getNovaLista(novaListaTexto(false,pFiltro),pStartingWith, pOrdem);
end;

function TControllerEndpoint.getNovaLista(pFiltro: IListaTexto=nil;pStartingWith: boolean = false;pOrdem: Integer = 2): TListaEndpointModel;
begin
  Result := TEndpointDao.getNewIface(vIConexao).objeto.getLista(pFiltro,pStartingWith,pOrdem);
  if(fLista=nil) then
    fLista := Result;
end;

end.
