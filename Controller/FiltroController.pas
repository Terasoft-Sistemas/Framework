unit FiltroController;

interface
uses
  Terasoft.Framework.Types,
  Terasoft.Framework.DB,
  System.SysUtils,
  FiltroModel,
  Interfaces.Conexao;

type
  IController_Filtro = interface
  ['{835102D1-5AA6-4C21-A264-440438217997}']
    function getByName(pName: TipoWideStringFramework): ITFiltroModel;
    function getLista(pNames: IListaString=nil): TListaFiltroModel;
  end;

  function getFiltroController(pIConexao:IConexao):IController_Filtro;

implementation
  uses
    filtroDao;

  type
    TControllerFiltro=class(TInterfacedObject,IController_Filtro)
    protected
      fModel: ITFiltroModel;
      fLista: TListaFiltroModel;
      function getByName(pName: TipoWideStringFramework): ITFiltroModel;
      function getLista(pNames: IListaString=nil): TListaFiltroModel;
    public
      vIConexao : IConexao;
      constructor Create(pIConexao : IConexao);
      destructor Destroy; override;
    end;

function getFiltroController(pIConexao:IConexao):IController_Filtro;
begin
  Result := TControllerFiltro.Create(pIConexao);
end;

{ TControllerFiltro }

constructor TControllerFiltro.Create(pIConexao: IConexao);
begin
  vIConexao:=pIConexao;
end;

destructor TControllerFiltro.Destroy;
begin
  fModel := nil;
  fLista := nil;
  vIConexao:=nil;
  inherited;
end;

function TControllerFiltro.getByName(pName: TipoWideStringFramework): ITFiltroModel;
begin
  fModel := TFiltroDao.getNewIface(vIConexao).objeto.getByName(pName);
  Result := fModel;
end;

function TControllerFiltro.getLista(pNames: IListaString): TListaFiltroModel;
begin

end;

end.
