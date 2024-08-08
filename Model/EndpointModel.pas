{$i definicoes.inc}

unit EndpointModel;

interface
uses
  Terasoft.Framework.Types,
  System.SysUtils,
  Terasoft.Framework.MultiConfig,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  FiltroModel,
  DB,
  DBClient,
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
    fCfg: IMultiConfig;

    fID: TipoWideStringFramework;
    fMETODO: TipoWideStringFramework;
    fNOME: TipoWideStringFramework;
    fQUERYInterno: TipoWideStringFramework;
    fPROPRIEDADES: TipoWideStringFramework;
    fDESCRICAO: TipoWideStringFramework;
    fFILTROS: TListaFiltroModel;
    fIgnoraPaginacao: boolean;

    procedure carregaFiltros;

  public
    const
      _TABELA_ = 'ENDPOINT';

  protected
    fRegistros: Integer;
    fPrimeiro: Integer;
    fContagem: Integer;
    fOldQuery: String;

    function getCfg: IMultiConfig;

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

    function getContagem: Integer;

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

    property contagem: Integer read getContagem;

  public

    function getQuery: TipoWideStringFramework;
    function executaQuery(const pFormatar: boolean = true): IDatasetSimples;
    procedure formatarDataset(pDataset: TDataset);

  end;

  function getNewEndpointModel(pIConexao : IConexao): ITEndpointModel;

implementation
  uses
    {$if defined(DEBUG)}
      ClipBrd,
    {$endif}
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

function TEndpointModel.getCfg: IMultiConfig;
begin
  if(fcfg=nil) then
    fCfg := criaMultiConfig.adicionaInterface(criaConfigIniString(fPROPRIEDADES));
  Result := fCFG;
end;

function TEndpointModel.getContagem: Integer;
  var
    lQuery: String;
begin
  fIgnoraPaginacao := true;
  try
    lQuery := getQuery;
    if (lQuery=fOldQuery) then
    begin
      Result := fContagem;
      exit;
    end;
    fContagem := vIConexao.gdb.criaDataset.query(format('select count(*) c from (%s)', [ lQuery ]),'',[]).dataset.Fields[0].AsInteger;
    Result := fContagem;
    fOldQuery := lQuery;
  finally
    fIgnoraPaginacao := false;
  end;
end;

function TEndpointModel.getQuery: TipoWideStringFramework;
  var
    fFiltro: ITFiltroModel;
    lSql, lWhere, lGroup, lIn: String;
    l: IListaTextoEX;
    lAdicional,lOrder: String;
    i: Integer;
begin
  lSql := fQUERYInterno;
  if(pos('<where>',lSql,1)=0) then
    lSql := lSql + #13 + '<where>';
  if(pos('<group>',lSql,1)=0) then
    lSql := lSql + #13 + '<group>';

  if(pos('<order>',lSql,1)=0) then
    lSql := lSql + #13 + '<order>';

  lAdicional := '';
  lOrder := '';
  if(fIgnoraPaginacao=false) then
  begin
    if(fRegistros>0) then
      lAdicional := format('%sfirst %d ', [ lAdicional, fRegistros ]);
    if(fPrimeiro>0) then
      lAdicional := format('%sskip %d ', [ lAdicional, fPrimeiro - 1 ]);
  end;

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

  //Where adicional
  l := getCfg.ReadSectionValuesLista('where');
  lAdicional := '';

  for i := 0 to l.strings.Count - 1 do
  begin
    lIn := l.strings.ValueFromIndex[i];
    if(lIn='') then continue;
    lAdicional := lAdicional + lIn + #13;
  end;
  if(lAdicional<>'') then
  begin
    if(lWhere <> '') then
      lWhere := lWhere + #13 + '    and ';
    lWhere :=  lWhere + lAdicional;
  end;

  if(lWhere <>'') then
    lWhere := 'where'+#13 + '   ' +lWhere;

  //Group
  lGroup := '';
  l := getCfg.ReadSectionValuesLista('group');
  lAdicional := '';

  for i := 0 to l.strings.Count - 1 do
  begin
    lIn := l.strings.ValueFromIndex[i];
    if(lIn='') then continue;
    lAdicional := lAdicional + lIn + #13;
  end;
  if(lAdicional<>'') then
  begin
    lGroup := format('group by %s', [ lAdicional ]);
  end;

  //Order
  lOrder := '';
  l := getCfg.ReadSectionValuesLista('order');
  lAdicional := '';
  for i := 0 to l.strings.Count - 1 do
  begin
    lIn := l.strings.ValueFromIndex[i];
    if(lIn='') then continue;
    lAdicional := lAdicional + lIn + #13;
  end;
  if(lAdicional<>'') then
  begin
    lOrder := format('order by %s', [ lAdicional ]);
  end;



  Result := StringReplace(lSql, '<where>', lWhere,[rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '<order>', lOrder,[rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '<group>', lGroup,[rfReplaceAll,rfIgnoreCase]);

  //Clipboard.AsText := Result;
end;

function TEndpointModel.executaQuery;
  var
    lSql: String;
    lDS: IDataset;
begin
  lDS := vIConexao.gdb.criaDataset;
  lSQL := getQuery;
  lDS.query(lSql,'',[]);
  Supports(lDS,IDatasetSimples,Result);
  if assigned(Result) and pFormatar then
    formatarDataset(Result.dataset);
end;

procedure TEndpointModel.formatarDataset(pDataset: TDataset);
  var
    l: IListaTextoEX;
    i: Integer;
    f: TField;
    sNome,sFormato: String;
begin
  if(pDataset=nil) then
    exit;

  for i := 0 to pDataset.FieldCount - 1 do
  begin
    f:=pDataset.Fields[i];
    if(f is TNumericField) and not ( f.DataType in [ ftLargeint ] ) then
      TNumericField(f).DisplayFormat := ',0.00';
  end;

  l := getCfg.ReadSectionValuesLista('formatos');
  for i := 0 to l.strings.Count-1 do
  begin
    sNome := l.strings.Names[i];
    sFormato := l.strings.ValueFromIndex[i];
    f:= pDataset.findField(sNome);
    if(f=nil) then continue;
    if(f is TNumericField) then
      TNumericField(f).DisplayFormat := sFormato
    else if f is TDateTimeField then
      TDateTimeField(f).DisplayFormat := sFormato
    else if f is TSQLTimeStampField then
      TSQLTimeStampField(f).DisplayFormat := sformato
    else if f is TAggregateField then
      TAggregateField(f).DisplayFormat := sFormato;
  end;

end;

procedure TEndpointModel.carregaFiltros;
  var
    lTxt: IListaTextoEx;
    i: Integer;
    sName, sValue: String;
    lFiltro: ITFiltroModel;
begin
  if fFiltroController=nil then
    fFiltroController := getFiltroController(vIConexao);

  //Limpa os filtros anteriores
  getFILTROS.Clear;

  lTxt := getcfg.ReadSectionValuesLista('filtros');

  for i := 0 to lTxt.strings.Count - 1 do
  begin
    sName := trim( lTxt.strings.Names[i]);
    if(sName='') then continue;
    sValue := trim( lTxt.strings.ValueFromIndex[i]);
    lFiltro := fFiltroController.getByName(sName);
    lFiltro.objeto.campo := sValue;
    lFiltro.objeto.setTipoPorNome(sName);
    fFILTROS.Add(lFiltro);
  end;
end;

procedure TEndpointModel.setPROPRIEDADES(const pValue: TipoWideStringFramework);
begin
  fCFG := nil;
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
