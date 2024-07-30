unit EndpointModel;

interface
uses
  Terasoft.Framework.Types,
  System.SysUtils,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  FiltroModel,
  FiltroController,
  Interfaces.Conexao;

type
  TEndpointModel=class;
  ITEndpointModel=IObject<TEndpointModel>;
  TListaEndpointModel=IList<ITEndpointModel>;

  TEndpointModel=class
  private
    [weak] mySelf: ITEndpointModel;
  protected
    vIConexao   : IConexao;
    fFiltroController: IController_Filtro;

    fID: TipoWideStringFramework;
    fMETODO: TipoWideStringFramework;
    fNOME: TipoWideStringFramework;
    fQUERY: TipoWideStringFramework;
    fPROPRIEDADES: TipoWideStringFramework;
    fDESCRICAO: TipoWideStringFramework;
    fFILTROS: TListaFiltroModel;

    procedure carregaFiltros;

  public
    const
      _TABELA_ = 'ENDPOINT';

  //property DESCRICAO getter/setter
    function getDESCRICAO: TipoWideStringFramework;
    procedure setDESCRICAO(const pValue: TipoWideStringFramework);

  //property PROPRIEDADES getter/setter
    function getPROPRIEDADES: TipoWideStringFramework;
    procedure setPROPRIEDADES(const pValue: TipoWideStringFramework);

  //property QUERY getter/setter
    function getQUERY: TipoWideStringFramework;
    procedure setQUERY(const pValue: TipoWideStringFramework);

  //property NOME getter/setter
    function getNOME: TipoWideStringFramework;
    procedure setNOME(const pValue: TipoWideStringFramework);

  //property METODO getter/setter
    function getMETODO: TipoWideStringFramework;
    procedure setMETODO(const pValue: TipoWideStringFramework);

    //property ID getter/setter
    function getID: TipoWideStringFramework;
    procedure setID(const pValue: TipoWideStringFramework);

  //property LISTAFILTROMODEL getter/setter
    function getFILTROS: TListaFiltroModel;
    procedure setFILTROS(const pValue: TListaFiltroModel);

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEndpointModel;

  public
    property ID: TipoWideStringFramework read getID write setID;
    property METODO: TipoWideStringFramework read getMETODO write setMETODO;
    property NOME: TipoWideStringFramework read getNOME write setNOME;
    property QUERY: TipoWideStringFramework read getQUERY write setQUERY;
    property PROPRIEDADES: TipoWideStringFramework read getPROPRIEDADES write setPROPRIEDADES;
    property DESCRICAO: TipoWideStringFramework read getDESCRICAO write setDESCRICAO;
    property FILTROS: TListaFiltroModel read getFILTROS write setFILTROS;
  end;

implementation
  uses
    Terasoft.Framework.MultiConfig,
    Terasoft.Framework.Texto;

{ TEndpointModel }

constructor TEndpointModel.Create(pIConexao: IConexao);
begin
  inherited Create;
  vIConexao := pIConexao;
end;

destructor TEndpointModel.Destroy;
begin
  fFiltroController := nil;
  vIConexao:=nil;
  inherited;
end;

class function TEndpointModel.getNewIface(pIConexao: IConexao): ITEndpointModel;
begin
  Result := TImplObjetoOwner<TEndpointModel>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TEndpointModel.setID(const pValue: TipoWideStringFramework);
begin
  fID := pValue;
end;

function TEndpointModel.getID: TipoWideStringFramework;
begin
  Result := fID;
end;

procedure TEndpointModel.setMETODO(const pValue: TipoWideStringFramework);
begin
  fMETODO := pValue;
end;

function TEndpointModel.getMETODO: TipoWideStringFramework;
begin
  Result := fMETODO;
end;

procedure TEndpointModel.setNOME(const pValue: TipoWideStringFramework);
begin
  fNOME := pValue;
end;

function TEndpointModel.getNOME: TipoWideStringFramework;
begin
  Result := fNOME;
end;

procedure TEndpointModel.setQUERY(const pValue: TipoWideStringFramework);
begin
  fQUERY := pValue;
end;

function TEndpointModel.getQUERY: TipoWideStringFramework;
begin
  Result := fQUERY;
end;

procedure TEndpointModel.carregaFiltros;
  var
    cfg: IMultiConfig;
    lTxt: IListaTextoEx;
    i: Integer;
    sName, sValue: String;
    lFiltro: ITFiltroModel;
begin
  if fFiltroController=nil then
    fFiltroController := getFiltroController(vIConexao);

  //Limpa os filtros anteriores
  getFILTROS.Clear;

  cfg := criaMultiConfig.adicionaInterface(criaConfigIniString(fPROPRIEDADES));
  lTxt := cfg.ReadSectionValuesLista('filtros');

  for i := 0 to lTxt.strings.Count - 1 do
  begin
    sName := uppercase(trim( lTxt.strings.Names[i]));
    if(sName='') then continue;
    lFiltro := fFiltroController.getByName(sName);
    fFILTROS.Add(lFiltro);
  end;
end;

procedure TEndpointModel.setPROPRIEDADES(const pValue: TipoWideStringFramework);
begin
  fPROPRIEDADES := pValue;
  carregaFiltros;
end;

function TEndpointModel.getPROPRIEDADES: TipoWideStringFramework;
begin
  Result := fPROPRIEDADES;
end;

procedure TEndpointModel.setDESCRICAO(const pValue: TipoWideStringFramework);
begin
  fDESCRICAO := pValue;
end;

function TEndpointModel.getDESCRICAO: TipoWideStringFramework;
begin
  Result := fDESCRICAO;
end;

procedure TEndpointModel.setFILTROS(const pValue: TListaFiltroModel);
begin
  fFILTROS := pValue;
end;

function TEndpointModel.getFILTROS: TListaFiltroModel;
begin
  if(fFILTROS=nil) then
    fFILTROS := tCollections.CreateList<ITFiltroModel>;
  Result := fFILTROS;
end;

end.
