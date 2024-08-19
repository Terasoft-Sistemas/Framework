{$i definicoes.inc}

unit EndpointModel;

interface
uses
  Terasoft.Framework.Types,
  System.SysUtils,
  Terasoft.Framework.MultiConfig,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Terasoft.Framework.Conversoes,
  FiltroController,
  FiltroModel,
  LojasModel,
  DB,
  DBClient,
  Terasoft.Framework.Texto,
  Terasoft.Framework.DB,
  Interfaces.Conexao;

type
  TEndpointModel=class;
  ITEndpointModel=IObject<TEndpointModel>;
  TListaEndpointModel=IList<ITEndpointModel>;

  TEstadoConsulta = record
    filiais, query: String;
    datasetCompleta, dataset, sumario: IDatasetSimples;
  end;

  TEndpointModel=class
  private
    [weak] mySelf: ITEndpointModel;
  protected

    vIConexao   : IConexao;
    fFiltroController: IController_Filtro;
    fCfg: IMultiConfig;
    vEstadoConsulta: TEstadoConsulta;

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
    //fContextoAtual: String;
    //fDatasetCompleta, fDataset, fDatasetSumario: IDatasetSimples;
    fRegistros: Integer;
    fPrimeiro: Integer;
    fOldQuery: String;
    fOrdem: TipoWideStringFramework;
    fPercentagens: boolean;
    fPermissao: TipoWideStringFramework;

  //property permissao getter/setter
    function getPermissao: TipoWideStringFramework;
    procedure setPermissao(const pValue: TipoWideStringFramework);

  //property percentagens getter/setter
    function getPercentagens: boolean;
    procedure setPercentagens(const pValue: boolean);

    function getFiltroLojas: ITFiltroModel;

  //property ordem getter/setter
    function getOrdem: TipoWideStringFramework;
    procedure setOrdem(const pValue: TipoWideStringFramework);

  //property filtroAdicional getter/setter
    function getBuscaAdicional: TipoWideStringFramework;
    procedure setBuscaAdicional(const pValue: TipoWideStringFramework);

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

    function getBuscaAvancada: ITFiltroModel;

    function queryLoja(pLojaModel: ITLojasModel; const pQuery: TipoWideStringFramework; pFields: TipoWideStringFramework; pParams: array of Variant): IDataset;

    function precisaExecutar: boolean;

  public

    constructor _Create(pIConexao : IConexao);
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
    property buscaAdicional: TipoWideStringFramework read getBuscaAdicional write setBuscaAdicional;
    property buscaAvancadada: ITFiltroModel read getBuscaAvancada;
    property ordem: TipoWideStringFramework read getOrdem write setOrdem;

    property filtroLojas: ITFiltroModel read getFiltroLojas;

    property percentagens: boolean read getPercentagens write setPercentagens;

    property permissao: TipoWideStringFramework read getPermissao write setPermissao;

  public
    procedure loaded;

    function getQuery: TipoWideStringFramework;
    function executaQuery(const pFormatar: boolean = true): IDatasetSimples;
    function sumario: IDatasetSimples;
    function toTxt(const pVisiveis: boolean = true; pFormatado: boolean = true): IListaTextoEx;
    procedure formatarDataset(pDataset: TDataset);

  end;

  function getNewEndpointModel(pIConexao : IConexao): ITEndpointModel;

implementation
  uses
    {$if defined(__DEBUG_ANTONIO__)}
      ClipBrd,
    {$endif}
    Terasoft.Framework.LOG,
    FuncoesConfig;

function getNewEndpointModel(pIConexao : IConexao): ITEndpointModel;
begin
  Result := TEndpointModel.getNewIface(pIConexao);
end;

{ TEndpointModel }

constructor TEndpointModel._Create(pIConexao: IConexao);
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
  Result := TImplObjetoOwner<TEndpointModel>.CreateOwner(self._Create(pIConexao));
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
begin
  if(precisaExecutar) then
    executaQuery;
  Result := vEstadoConsulta.datasetCompleta.dataset.RecordCount;
end;

function TEndpointModel.getQuery: TipoWideStringFramework;
  var
    lFiltro: ITFiltroModel;
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
{  if(fIgnoraPaginacao=false) then
  begin
    if(fRegistros>0) then
      lAdicional := format('%sfirst %d ', [ lAdicional, fRegistros ]);
    if(fPrimeiro>0) then
      lAdicional := format('%sskip %d ', [ lAdicional, fPrimeiro - 1 ]);
  end;
}
  if(lAdicional<>'') then
    lSql := StringReplace(lSql, 'select', format('select %s', [ lAdicional ]), [rfIgnoreCase]);

  lWhere:='';
  for lFiltro in getFILTROS do
  begin

    if(lFiltro.objeto.TIPO=tipoFiltro_Expressao) then continue;

    lIn := lFiltro.objeto.query;

    if(lFiltro.objeto.TIPO=tipoFiltro_Expressao) then
    begin
      lSQL := StringReplace(lSQL,lFiltro.objeto.campo,lIn,[rfReplaceAll,rfIgnoreCase]);
    end else
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
  if(fOrdem = '') then
  begin
    lOrder := '';
    l := getCfg.ReadSectionValuesLista('order');
    lAdicional := '';
    for i := 0 to l.strings.Count - 1 do
    begin
      lIn := l.strings.ValueFromIndex[i];
      if(lIn='') then continue;
      lAdicional := lAdicional + lIn + #13;
    end;
  end else
    lAdicional := fOrdem;
  if(lAdicional<>'') then
  begin
    lOrder := format('order by %s', [ lAdicional ]);
  end;

  Result := StringReplace(lSql, '<where>', lWhere,[rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '<order>', lOrder,[rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '<group>', lGroup,[rfReplaceAll,rfIgnoreCase]);

  for lFiltro in getFILTROS do
  begin

    if(lFiltro.objeto.TIPO<>tipoFiltro_Expressao) then continue;

    lIn := lFiltro.objeto.query;

    Result := StringReplace(Result,lFiltro.objeto.campo,lIn,[rfReplaceAll,rfIgnoreCase]);
  end;

  Result := StringReplace(Result, '<igual>', '=',[rfReplaceAll,rfIgnoreCase]);

end;

function TEndpointModel.queryLoja(pLojaModel: ITLojasModel;
    const pQuery: TipoWideStringFramework; pFields: TipoWideStringFramework;
    pParams: array of Variant): IDataset;
begin
  if(pLojaModel=nil) or (pQuery='') then
    exit;
  vIConexao.ConfigConexaoExterna(pLojaModel.objeto.LOJA);
  Result := vIConexao.gdbExterno.criaDataset.query(pQuery,pFields,pParams);
end;

function TEndpointModel.precisaExecutar: boolean;
begin
  Result := (vEstadoConsulta.query<>getQuery) or (vEstadoConsulta.filiais<>getFiltroLojas.objeto.opcoesSelecionadas.text)
          or (vEstadoConsulta.datasetCompleta=nil);
end;

function TEndpointModel.executaQuery;
  var
    lSql: String;
    lDS: IDataset;
    lLojaModel: ITLojasModel;
    lPrecisaOrder: boolean;
    sField,sdir: String;
    f: TField;
    i: Integer;
    index: TIndexDef;
    save: boolean;
begin
  Result := nil;
  if(precisaExecutar) then begin
    vEstadoConsulta.dataset := nil;
    vEstadoConsulta.datasetCompleta := nil;
    vEstadoConsulta.sumario := nil;
    vEstadoConsulta.filiais := '';
    vEstadoConsulta.query := '';

    save := fIgnoraPaginacao;
    fIgnoraPaginacao := true;

    try
      lDS := nil;
      lSQL := getQuery;
      logaByTagSeNivel('', format('TEndpointModel.executaQuery: [%s]',[lSql]),LOG_LEVEL_DEBUG);
      vEstadoConsulta.query := lSQL;

    finally
      fIgnoraPaginacao:=save;
    end;

    lPrecisaOrder := false;

    for lLojaModel in getFiltroLojas.objeto.listaLojas do
    begin
      lDS := queryLoja(lLojaModel, lSQL,'',[]);
      if(Result = nil) then
        Result := criaDatasetSimples(cloneDataset(lDS.dataset))
      else
      begin
        atribuirRegistrosSoma(lDS.dataset,Result.dataset,filtroLojas.objeto.campo);
        lPrecisaOrder := true;
      end;
    end;
  end else
    Result := vEstadoConsulta.datasetCompleta;

  if assigned(Result) and pFormatar then
    formatarDataset(Result.dataset);

  vEstadoConsulta.dataset := Result;
  vEstadoConsulta.datasetCompleta := criaDatasetSimples(cloneDataset(Result.dataset));
  vEstadoConsulta.filiais := getFiltroLojas.objeto.opcoesSelecionadas.text;

  Result.dataset.First;
  if(lPrecisaOrder) then
  begin
    sField := textoEntreTags(fOrdem,'',' ');
    if(sField='') then
      sField := fOrdem;
    sDir := textoEntreTags(fOrdem,' ','');
    f := Result.dataset.FindField(sField);
    if(f = nil) then
    begin
      i := StrToIntDef(sField,0) - 1;
      if (i>-1) and (i<Result.dataset.FieldCount) then
        f := Result.dataset.Fields[i];
    end;
    if (f<>nil)  then
    begin
      if(CompareText(sDir,'desc')=0) then
      begin
        index := TClientDataSet(Result.dataset).IndexDefs.AddIndexDef;
        index.Name := f.FieldName;
        index.Options := [ixDescending,ixCaseInsensitive];
        TClientDataSet(Result.dataset).IndexName := f.FieldName;
      end else
      begin
        TClientDataSet(Result.dataset).IndexName := '';
        TClientDataSet(Result.dataset).IndexFieldNames := f.FieldName;
      end;
    end;
  end;
  if(fPercentagens) then
  begin
//    sumario;
//    configuraCamposSumarioGenerico(Result.Dataset, fDatasetSumario.Dataset);
  end;
  if (fIgnoraPaginacao=false) then
  begin
    i := fPrimeiro;
    while i > 0 do
    begin
      dec(i);
      Result.dataset.Delete;
    end;
    Result.dataset.Last;
    if(fRegistros>0) then
      while (Result.dataset.RecordCount>fRegistros) do
        Result.dataset.Delete;
  end;
end;

procedure TEndpointModel.formatarDataset(pDataset: TDataset);
  var
    l: IListaTextoEX;
    i: Integer;
    f: TField;
    sNome,sFormato: String;
    posicao: Integer;
    lVisible: boolean;
begin
  if(pDataset=nil) then
    exit;
  getCfg;

  for i := 0 to pDataset.FieldCount - 1 do
  begin
    f:=pDataset.Fields[i];
    lVisible := not (( f.DataType in [ftBytes])  or ((f is TBlobField) and (TBlobField(f).BlobType=ftBlob)) or
                    (f is TByteField));

    f.Visible := fCfg.ReadBool('visible',f.DisplayName, lVisible);
    f.DisplayLabel := capitalizarTexto(StringReplace(f.DisplayName,'_',' ', [rfReplaceAll]));
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

  l := getCfg.ReadSectionValuesLista('label');
  for i := 0 to l.strings.Count-1 do
  begin
    sNome := l.strings.Names[i];
    sFormato := l.strings.ValueFromIndex[i];
    f:= pDataset.findField(sNome);
    if(f=nil) then continue;
    f.DisplayLabel := sFormato;
  end;

{  i:=0;
  posicao:=-1;
  while i < pDataset.FieldCount do
  begin
    f:=pDataset.Fields[i];
    inc(posicao);
    if(f.Visible=true) then
    begin
      f.Tag := posicao;
      inc(i);
      continue;
    end;
    if(f.Tag=-1) then break;
    f.Tag := -1;
    f.Index := pDataset.FieldCount - 1;
    inc(i);
  end;
}

end;

procedure TEndpointModel.carregaFiltros;
  var
    lTxt: IListaTextoEx;
    i: Integer;
    sName, sValue: String;
    lFiltroLojas, lFiltro: ITFiltroModel;
begin
  if fFiltroController=nil then
    fFiltroController := getFiltroController(vIConexao);

  //Limpa os filtros anteriores
  getFILTROS.Clear;

  lTxt := getcfg.ReadSectionValuesLista('filtros');

{  lFiltro := fFiltroController.getByName('');
  lFiltro.objeto.setTipoPorNome('@loja');
  lFiltro.objeto.campo := 'dummy';
  fFILTROS.Add(lFiltro);}

  lFiltroLojas := nil;

  for i := 0 to lTxt.strings.Count - 1 do
  begin
    sName := trim( lTxt.strings.Names[i]);
    if(sName='') then continue;
    sValue := trim( lTxt.strings.ValueFromIndex[i]);
    lFiltro := fFiltroController.getByName(sName);
    lFiltro.objeto.campo := sValue;
    lFiltro.objeto.setTipoPorNome(sName);
    if(lFiltro.objeto.tipo=tipoFiltro_Lojas) then
    begin
      lFiltroLojas := lFiltro;
    end else
      fFILTROS.Add(lFiltro);
  end;

  if(lFiltroLojas=nil) then
  begin
    lFiltroLojas := fFiltroController.getByName(sName);
    lFiltroLojas.objeto.setTipoPorNome('@lojas');
  end;
  fFILTROS.Insert(0,lFiltroLojas);

  fPermissao := getCfg.ReadString('permissao','executar',tagConfig_GESTAO_RELATORIO_PERMISSAO);
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

function TEndpointModel.sumario: IDatasetSimples;
  var
    lQueryOriginal: TipoWideStringFramework;
    lDS: IDataset;
    f: TField;
    i: Integer;
    lCampos, lSql: String;
    lLojaModel: ITLojasModel;
    save: boolean;
begin
  if(precisaExecutar) then
  begin
    vEstadoConsulta.sumario := nil;
    vEstadoConsulta.datasetCompleta:=nil;
    vEstadoConsulta.dataset:=nil;
    executaQuery;
  end;

  Result := vEstadoConsulta.sumario;
  if(Result<>nil) then exit;
  save := fIgnoraPaginacao;
  fIgnoraPaginacao := true;
  try
    lQueryOriginal := getQuery;
  finally
    fIgnoraPaginacao := save;
  end;

  lCampos := '';

  for i := 0 to vEstadoConsulta.dataset.dataset.FieldCount - 1 do
  begin
    f := vEstadoConsulta.dataset.dataset.Fields[i];
    if (not (f is TNumericField)) or (fCfg.ReadBool('sumario',f.FieldName,true)=false) then continue;

    if(lCampos<>'') then
      lCampos := lCampos + ',' + #13;
    lCampos := format('%s  sum(%s) %s', [ lCampos, f.FieldName, f.FieldName ]);
  end;

  if(lCampos='') then
    exit;

  lSql := format( 'select %s from (%s) ', [ lCampos, lQueryOriginal ]);
  logaByTagSeNivel('', format('TEndpointModel.sumario: [%s]',[lSql]),LOG_LEVEL_DEBUG);


  for lLojaModel in getFiltroLojas.objeto.listaLojas do
  begin
    lDS := queryLoja(lLojaModel,lSQL,'',[]);
    if(Result = nil) then
      Result := criaDatasetSimples(cloneDataset(lDS.dataset))
    else
      atribuirRegistrosSoma(lDS.dataset,Result.dataset,'*');
  end;

  formatarDataset(Result.dataset);
  getCfg;

  for i := 0 to lDS.dataset.FieldCount - 1 do
  begin
    f := lDS.dataset.Fields[i];
    f.Visible := fCfg.ReadBool('sumario',f.FieldName,true);
  end;
  vEstadoConsulta.sumario := Result;
end;

function TEndpointModel.toTxt;
  var
    save: boolean;
begin
  save := fIgnoraPaginacao;
  fIgnoraPaginacao := true;
  try
    executaQuery;
    Result := datasetToTXT(vEstadoConsulta.dataset.dataset,pVisiveis,pFormatado);
  finally
    fIgnoraPaginacao := save;
  end;

end;

function TEndpointModel.getRegistros: Integer;
begin
  Result := fRegistros;
end;

procedure TEndpointModel.loaded;
begin
  getBuscaAdicional;
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

procedure TEndpointModel.setBuscaAdicional(const pValue: TipoWideStringFramework);
begin
  getBuscaAvancada.objeto.buscaAdicional := pValue;
end;

function TEndpointModel.getBuscaAdicional: TipoWideStringFramework;
begin
  Result := getBuscaAvancada.objeto.buscaAdicional;
end;

function TEndpointModel.getBuscaAvancada: ITFiltroModel;
  var
    p: ITFiltroModel;
begin
  for p in FILTROS do
  begin
    if p.objeto.TIPO=tipoFiltro_Busca then
    begin
      Result := p;
      exit;
    end;
  end;

  raise Exception.CreateFmt('Falta definir a busca adicional para [%s] ', [ fNOME]);
end;

function TEndpointModel.getFiltroLojas: ITFiltroModel;
  var
    p: ITFiltroModel;
begin
  for p in FILTROS do
  begin
    if p.objeto.TIPO=tipoFiltro_Lojas then
    begin
      Result := p;
      exit;
    end;
  end;

  raise Exception.CreateFmt('Falta definir o filtro de lojas para [%s] ', [ fNOME]);
end;

procedure TEndpointModel.setOrdem(const pValue: TipoWideStringFramework);
begin
  fOrdem := pValue;
end;

function TEndpointModel.getOrdem: TipoWideStringFramework;
begin
  Result := fOrdem;
end;

procedure TEndpointModel.setPercentagens(const pValue: boolean);
begin
  fPercentagens := pValue;
end;

function TEndpointModel.getPercentagens: boolean;
begin
  Result := fPercentagens;
end;

procedure TEndpointModel.setPermissao(const pValue: TipoWideStringFramework);
begin
  fPermissao := pValue;
end;

function TEndpointModel.getPermissao: TipoWideStringFramework;
begin
  if(fPermissao='') then
    fPermissao := tagConfig_GESTAO_RELATORIO_PERMISSAO;
  Result := fPermissao;
end;

end.
