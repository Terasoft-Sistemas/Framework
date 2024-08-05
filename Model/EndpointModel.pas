{$i definicoes.inc}

unit EndpointModel;

interface
uses
  Terasoft.Framework.Types,
  System.SysUtils,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  FiltroModel,
  Terasoft.Framework.DB,
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
    fQUERYInterno: TipoWideStringFramework;
    fPROPRIEDADES: TipoWideStringFramework;
    fDESCRICAO: TipoWideStringFramework;
    fFILTROS: TListaFiltroModel;

    procedure carregaFiltros;

  public
    const
      _TABELA_ = 'ENDPOINT';

  protected
    fRegistros: Integer;
    fPrimeiro: Integer;

  //property primeiro getter/setter
    function getPrimeiro: Integer;
    procedure setPrimeiro(const pValue: Integer);

  //property registros getter/setter
    function getRegistros: Integer;
    procedure setRegistros(const pValue: Integer);

  //property DESCRICAO getter/setter
    function getDESCRICAO: TipoWideStringFramework;
    procedure setDESCRICAO(const pValue: TipoWideStringFramework);

  //property PROPRIEDADES getter/setter
    function getPROPRIEDADES: TipoWideStringFramework;
    procedure setPROPRIEDADES(const pValue: TipoWideStringFramework);

  //property QUERY getter/setter
    function getQUERYInterno: TipoWideStringFramework;
    procedure setQUERYInterno(const pValue: TipoWideStringFramework);

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
    property QUERY: TipoWideStringFramework read getQUERYInterno write setQUERYInterno;
    property PROPRIEDADES: TipoWideStringFramework read getPROPRIEDADES write setPROPRIEDADES;
    property DESCRICAO: TipoWideStringFramework read getDESCRICAO write setDESCRICAO;
    property FILTROS: TListaFiltroModel read getFILTROS write setFILTROS;

    property registros: Integer read getRegistros write setRegistros;
    property primeiro: Integer read getPrimeiro write setPrimeiro;

  public
    function getQuery: TipoWideStringFramework;
    function executaQuery: IDatasetSimples;

  end;

  function getNewEndpointModel(pIConexao : IConexao): ITEndpointModel;

implementation
  uses
    {$if defined(DEBUG)}
      ClipBrd,
    {$endif}
    Terasoft.Framework.MultiConfig,
    Terasoft.Framework.Texto;

function getNewEndpointModel(pIConexao : IConexao): ITEndpointModel;
begin
  Result := TEndpointModel.getNewIface(pIConexao);
end;

{ TEndpointModel }

constructor TEndpointModel.Create(pIConexao: IConexao);
begin
  inherited Create;
//  fRegistros := 1000;
//  fPrimeiro := 0;
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

procedure TEndpointModel.setQUERYInterno(const pValue: TipoWideStringFramework);
begin
  fQUERYInterno := pValue;
end;

function TEndpointModel.getQUERYInterno: TipoWideStringFramework;
begin
  Result := fQUERYInterno;
end;

function TEndpointModel.getQuery: TipoWideStringFramework;
  var
    fFiltro: ITFiltroModel;
    lSql, lWhere, lIn: String;
    lAdicional: String;
begin
  lSql := fQUERYInterno;
  lAdicional := '';
  if(fRegistros>0) then
    lAdicional := format('%sfirst %d ', [ lAdicional, fRegistros ]);
  if(fPrimeiro>0) then
    lAdicional := format('%sskip %d ', [ lAdicional, fPrimeiro ]);

  if(lAdicional<>'') then
    lSql := StringReplace(lSql, 'select', format('select %s', [ lAdicional ]), [rfIgnoreCase]);

  lWhere:='';
  for fFiltro in getFILTROS do
  begin
    lIn := fFiltro.objeto.query;
    if(lIn <> '') then
    begin
      if(lWhere<>'') then
        lWhere := lWhere + #13 + ' and ';
      lWhere := lWhere + lIn;
    end;
  end;

  if(lWhere <>'') then
    lWhere := 'where'+#13 + '   ' +lWhere;

  Result := lSql +#13+ lWhere;
end;

function TEndpointModel.executaQuery: IDatasetSimples;
  var
    lSql: String;
    lDS: IDataset;
begin
  lDS := vIConexao.gdb.criaDataset;
  lSQL := getQuery;
  lDS.query(lSql,'',[]);
  Supports(lDS,IDatasetSimples,Result);
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
    sValue := uppercase(trim( lTxt.strings.ValueFromIndex[i]));
    lFiltro := fFiltroController.getByName(sName);
    lFiltro.objeto.campo := sValue;
    lFiltro.objeto.setTipoPorNome(sName);
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

procedure TEndpointModel.setPrimeiro(const pValue: Integer);
begin
  fPrimeiro := pValue;
end;

function TEndpointModel.getPrimeiro: Integer;
begin
  Result := fPrimeiro;
end;

procedure TEndpointModel.setRegistros(const pValue: Integer);
begin
  fRegistros := pValue;
end;

function TEndpointModel.getRegistros: Integer;
begin
  Result := fRegistros;
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
