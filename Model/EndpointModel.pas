{$i definicoes.inc}

unit EndpointModel;

interface
uses
  Classes,
  SysUtils,
  Terasoft.Configuracoes,
  Terasoft.Framework.Types,
  Terasoft.Framework.MultiConfig,
  Spring.Collections,
  Interfaces.QueryLojaAsync,
  Terasoft.Framework.ObjectIface,
  Terasoft.Framework.Conversoes,
  FiltroController,
  FiltroModel,
  LojasModel,
  DB,
  DBClient,
  Terasoft.Framework.Processos,
  Terasoft.Framework.Texto,
  Terasoft.Framework.DB,
  Interfaces.Conexao;

  type
    TOrientacaoImpressao = ( oiRetrato, oiPaisagem );

    TEndpointModel=class;
    ITEndpointModel=IObject<TEndpointModel>;
    TListaEndpointModel=IList<ITEndpointModel>;

    TEstadoConsulta = record
      filiais,agrupamento, query: String;
      datasetCompleta, datasetPaginada: IDatasetSimples;
    end;

    IDadosImpressao = interface
    ['{F3DE5DA9-78CD-4E18-B00F-5A7F2F394ABB}']

      procedure liberaEndpoint;
    //property titulo getter/setter
      function getTitulo: TipoWideStringFramework;
      procedure setTitulo(const pValue: TipoWideStringFramework);

    //property orientacao getter/setter
      function getOrientacao: TOrientacaoImpressao;
      procedure setOrientacao(const pValue: TOrientacaoImpressao);

    //property nome getter/setter
      function getNome: TipoWideStringFramework;
      procedure setNome(const pValue: TipoWideStringFramework);

      function dataset: IDatasetSimples;

      function sumario: IDatasetSimples;

    //property descricao getter/setter
      function getDescricao: TipoWideStringFramework;
      procedure setDescricao(const pValue: TipoWideStringFramework);

      property descricao: TipoWideStringFramework read getDescricao write setDescricao;
      property nome: TipoWideStringFramework read getNome write setNome;
      property orientacao: TOrientacaoImpressao read getOrientacao write setOrientacao;
      property titulo: TipoWideStringFramework read getTitulo write setTitulo;

    end;

    IListaImpressao = IList<IDadosImpressao>;

    TEndpointModel=class
    private
      [weak] mySelf: ITEndpointModel;
    protected
      vIConexao   : IConexao;
      vConfiguracoes: ITerasoftConfiguracoes;

      fFiltroController: IController_Filtro;
      fCfg: IMultiConfig;
      vEstadoConsulta, vEstadoConsultaSumario: TEstadoConsulta;

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
      vAsync: IResultadoOperacao;

      fFiltroLojas: ITFiltroModel;
      fFiltroAgrupamentos: ITFiltroModel;

      fOperacoes: IListaTextoEx;

      fRegistros: Integer;
      fPrimeiro: Integer;
      fOrdem: TipoWideStringFramework;
      fPermissao: TipoWideStringFramework;
      fPermissaoLoja: TipoWideStringFramework;
      fListaImpressao: IListaImpressao;
      fContagem: Integer;
      fUseVCL: boolean;

      function getAsyncQueryFilial(const loja: ITLojasModel): IQueryLojaAsync;

    //property useVCL getter/setter
      function getUseVCL: boolean;
      procedure setUseVCL(const pValue: boolean);

    //property listaImpressao getter/setter
      function getListaImpressao: IListaImpressao;
      procedure setListaImpressao(const pValue: IListaImpressao);

    //property permissao getter/setter
      function getPermissao: TipoWideStringFramework;
      procedure setPermissao(const pValue: TipoWideStringFramework);

    //property permissao getter/setter
      function getPermissaoLoja: TipoWideStringFramework;
      procedure setPermissaoLoja(const pValue: TipoWideStringFramework);

      function getFiltroLojas: ITFiltroModel;
      function getFiltroAgrupamentos: ITFiltroModel;
      function getCampoAgrupamento: TipoWideStringFramework;

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

      procedure queryLoja(pLojaModel: ITLojasModel; const pQuery: TipoWideStringFramework; pCriaOperacoes: boolean);

      function precisaExecutar(var pEstadoConsulta: TEstadoConsulta): boolean;

      function getOperacoes: IListaTextoEx;

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

      property permissao: TipoWideStringFramework read getPermissao write setPermissao;
      property permissaoLoja: TipoWideStringFramework read getPermissaoLoja write setPermissaoLoja;

      property listaImpressao: IListaImpressao read getListaImpressao write setListaImpressao;
      property useVCL: boolean read getUseVCL write setUseVCL;
      property operacoes: IListaTextoEX read getOperacoes;
      property campoAgrupamento: TipoWideStringFramework read getCampoAgrupamento;

    public
      procedure loaded;

      function getQuery: TipoWideStringFramework;
      function executaQuery(const pFormatar: boolean = true): IDatasetSimples;
      function sumario: IDatasetSimples;
      function toTxt(const pVisiveis: boolean = true; pFormatado: boolean = true): IListaTextoEx;
      procedure formatarDataset(pDataset: TDataset);
      function impressaoPorNome(const pNome: TipoWideStringFramework): IDadosImpressao;

    end;

  function getNewEndpointModel(pIConexao : IConexao): ITEndpointModel;

implementation
  uses
    Terasoft.Eval,
    Terasoft.Framework.FuncoesDiversas,
    FireDAC.Comp.Client,
    Terasoft.Framework.LOG,
    FuncoesConfig;

  type
    TDadosImpressaoImpl = class(TInterfacedObject, IDadosImpressao)
    protected
      vModel: TEndpointModel;
      fTitulo: TipoWideStringFramework;
      fOrientacao: TOrientacaoImpressao;
      fNome: TipoWideStringFramework;
      fDescricao: TipoWideStringFramework;

      function dataset: IDatasetSimples;
      function sumario: IDatasetSimples;

      procedure liberaEndpoint;

    //property descricao getter/setter
      function getDescricao: TipoWideStringFramework;
      procedure setDescricao(const pValue: TipoWideStringFramework);

    //property nome getter/setter
      function getNome: TipoWideStringFramework;
      procedure setNome(const pValue: TipoWideStringFramework);

    //property orientacao getter/setter
      function getOrientacao: TOrientacaoImpressao;
      procedure setOrientacao(const pValue: TOrientacaoImpressao);

    //property titulo getter/setter
      function getTitulo: TipoWideStringFramework;
      procedure setTitulo(const pValue: TipoWideStringFramework);
    end;

function getNewEndpointModel(pIConexao : IConexao): ITEndpointModel;
begin
  Result := TEndpointModel.getNewIface(pIConexao);
end;

{ TEndpointModel }

constructor TEndpointModel._Create(pIConexao: IConexao);
begin
  inherited Create;
  vIConexao := pIConexao;
  fContagem := -1;
  Supports(vIConexao.terasoftConfiguracoes,ITerasoftConfiguracoes,vConfiguracoes);
  if(vConfiguracoes=nil) then
    raise Exception.Create('Não existe configuração disponível');

end;

destructor TEndpointModel.Destroy;
  var
    p: IDadosImpressao;
begin
  vAsync := nil;
  if(fListaImpressao<>nil) then
    for p in fListaImpressao do
      p.liberaEndpoint;
  vAsync := nil;

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
  var
    lListaLojas:TILojasModelList;
    lQuery: String;
    lQueryMain: String;
    save: boolean;
begin
{  lListaLojas:=getFiltroLojas.objeto.listaLojas;
  if(lListaLojas.Count=1) then
  begin
    save := fIgnoraPaginacao;
    fIgnoraPaginacao := true;
    try
      if precisaExecutar(vEstadoConsulta) then
        fContagem := -1;
      if(fContagem <> -1) then
      begin
        Result := fContagem;
        exit;
      end;
      lQuery := getQuery;
    finally
      fIgnoraPaginacao:=save;
    end;

    vIConexao.ConfigConexaoExterna(lListaLojas.First.objeto.LOJA);

    lQueryMain  := 'select count(*) c from (%s) ';
    if(campoAgrupamento<>'') then
      lQueryMain := 'group by ' + campoAgrupamento;

    fContagem := vIConexao.gdb.criaDataset.query(format(lQueryMain, [ lQuery ]),'',[]).dataset.Fields[0].AsInteger;
    Result := fContagem;

  end else}
  begin
    if precisaExecutar(vEstadoConsulta) then
      executaQuery;
    Result := vEstadoConsulta.datasetCompleta.dataset.RecordCount;
  end;
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

procedure TEndpointModel.queryLoja(pLojaModel: ITLojasModel; const pQuery: TipoWideStringFramework; pCriaOperacoes: boolean);
  var
    qAsync: IQueryLojaAsync;
begin
  if(pLojaModel=nil) or (pQuery='') then
    exit;

  qAsync := getAsyncQueryFilial(pLojaModel);
  qAsync.criaOperacoes := pCriaOperacoes;
  qAsync.execQuery(pQuery,'',[]);

end;

function TEndpointModel.precisaExecutar;
begin
  Result := (pEstadoConsulta.query<>getQuery) or (pEstadoConsulta.filiais<>getFiltroLojas.objeto.opcoesSelecionadas.text)
          or (pEstadoConsulta.agrupamento<>campoAgrupamento)
          or (pEstadoConsulta.datasetCompleta=nil);
  if(Result) then
  begin
    pEstadoConsulta.datasetPaginada := nil;
    pEstadoConsulta.datasetCompleta := nil;
    pEstadoConsulta.agrupamento := '';
    pEstadoConsulta.filiais := '';
    pEstadoConsulta.query := '';
  end;

end;


function TEndpointModel.getOperacoes: IListaTextoEx;
begin
  if(fOperacoes=nil) then
  begin
    fOperacoes := getCfg.ReadSectionValuesLista('operacoes');
    TStringList(fOperacoes.strings).OwnsObjects := true;
  end;
  Result := fOperacoes;
end;

function TEndpointModel.executaQuery;
  var
    lSql: String;
    //lDS: IDataset;
    lLojaModel: ITLojasModel;
    lPrecisaOrder: boolean;
    sField,sdir: String;
    f: TField;
    i: Integer;
    index: TIndexDef;
    save: boolean;
    lListaLojas: TILojasModelList;
    lLojaAsync: IQueryLojaAsync;
begin
  Result := nil;

  lListaLojas := getFiltroLojas.objeto.listaLojas;

  if precisaExecutar(vEstadoConsulta) then begin
    fContagem := -1;

    save := fIgnoraPaginacao;
    if(fRegistros<>1) {and (lListaLojas.Count<>1)}  then
      fIgnoraPaginacao := true;

    try
      //lDS := nil;
      lSQL := getQuery;
      logaByTagSeNivel('', format('TEndpointModel(%s).executaQuery: [%s]',[fNOME, lSql]),LOG_LEVEL_DEBUG);
      vEstadoConsulta.query := lSQL;

    finally
      fIgnoraPaginacao:=save;
    end;

    lPrecisaOrder := false;

    i := 0;
    for lLojaModel in getFiltroLojas.objeto.listaLojas do
    begin
      queryLoja(lLojaModel, lSQL,i=0);
      if(fRegistros=1) then
        break;
      inc(i);
    end;

    for lLojaModel in getFiltroLojas.objeto.listaLojas do
    begin
      lLojaAsync := getAsyncQueryFilial(lLojaModel);
      lLojaAsync.esperar;
      if(lLojaAsync.resultado.erros=0) then
      begin
        if(Result = nil) then
        begin
          Result := criadatasetSimples(cloneDataset(lLojaAsync.dataset.dataset,false,false,true));
          //Result := lLojaAsync.dataset;
          TFDMemTable(Result.dataset).IndexFieldNames := campoAgrupamento;
          TFDMemTable(Result.dataset).IndexesActive := true;
        end;
        atribuirRegistrosSoma(lLojaAsync.dataset.dataset,Result.dataset,campoAgrupamento,'','',operacoes);
        lPrecisaOrder := true;
      end else
        raise Exception.CreateFmt('Erro ao consultar loja [%s]: [%s]', [lLojaModel.objeto.LOJA, lLojaAsync.resultado.toString ]);
      if(fRegistros=1) then
        break;
    end;


  end else begin
    Result := vEstadoConsulta.datasetCompleta;
    lPrecisaOrder := true;
  end;

  if assigned(Result) and pFormatar then
    formatarDataset(Result.dataset);

  vEstadoConsulta.datasetPaginada := Result;
  if(fRegistros<>1) then
    vEstadoConsulta.datasetCompleta := criaDatasetSimples(cloneDataset(Result.dataset,false));
  vEstadoConsulta.filiais := getFiltroLojas.objeto.opcoesSelecionadas.text;
  vEstadoConsulta.agrupamento := campoAgrupamento;

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
      TFDMemTable(Result.dataset).IndexesActive := false;
      if(CompareText(sDir,'desc')=0) then
      begin
        TFDMemTable(Result.dataset).IndexFieldNames := f.FieldName+':DN';
      end else
      begin
        TFDMemTable(Result.dataset).IndexFieldNames := f.FieldName+':AN';
      end;
      TFDMemTable(Result.dataset).IndexesActive := true;
    end else
      TFDMemTable(Result.dataset).IndexFieldNames := '';

  end;
  if (fIgnoraPaginacao=false) {and (lListaLojas.Count<>1)} then
  begin
    i := fPrimeiro-1;
    while (Result.dataset.RecordCount>0) and (i > 0) do
    begin
      dec(i);
      Result.dataset.Delete;
    end;
    Result.dataset.Last;
    if(fRegistros>0) then
      while (Result.dataset.RecordCount>fRegistros) do
        Result.dataset.Delete;
  end;
  if assigned(Result) then
    Result.dataset.First;
end;

procedure TEndpointModel.formatarDataset(pDataset: TDataset);
  var
    l: IListaTextoEX;
    i,j: Integer;
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
    lVisible := f.Visible and not (( f.DataType in [ftBytes])  or ((f is TBlobField) and  (TBlobField(f).BlobType=ftBlob)) or
                    (f is TByteField)) and (pos(DBFIELDINTERNO, f.FieldName,1)=0);

    // tamanho padrão
    if(fUseVCL=false) then
      f.DisplayWidth := 1;

    fCfg.ReadInteger('width',f.FieldName,f.DisplayWidth);

    f.Visible := lVisible and fCfg.ReadBool('visible',f.FieldName, lVisible);
    f.DisplayLabel := capitalizarTexto(StringReplace(f.FieldName,'_',' ', [rfReplaceAll]));
    if(f is TNumericField) and not ( f.DataType in [ ftLargeint ] ) then
      TNumericField(f).DisplayFormat := ',0.00';
  end;

  l := getCfg.ReadSectionValuesLista('formato');
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


  l := getCfg.ReadSectionValuesLista('posicao');
  for j := 0 to 5 do
    for i := 0 to l.strings.Count-1 do
    begin
      sNome := trim(l.strings.Names[i]);
      f:= pDataset.findField(sNome);
      if(f=nil) then continue;
      sFormato := l.strings.ValueFromIndex[i];
      f.Index := StrToIntDef(sformato,f.Index);
    end;

  l := getCfg.ReadSectionValuesLista('alinhamento');
  for i := 0 to l.strings.Count-1 do
  begin
    sNome := trim(l.strings.Names[i]);
    f:= pDataset.findField(sNome);
    if(f=nil) then continue;
    sFormato := l.strings.ValueFromIndex[i];
    j := StrToIntDef(sformato,Integer(f.Alignment));
    if j in [ 0,1,2] then
      f.Alignment := TAlignment(j);
  end;

end;

procedure TEndpointModel.carregaFiltros;
  var
    lTxt: IListaTextoEx;
    i,j: Integer;
    sName, sValue, lDescricao, lTitulo: String;
    lFiltro: ITFiltroModel;
    lImpressao: TDadosImpressaoImpl;
begin
  if fFiltroController=nil then
    fFiltroController := getFiltroController(vIConexao);

  //Limpa os filtros anteriores
  getFILTROS.Clear;

  fListaImpressao := TCollections.CreateList<IDadosImpressao>;

  fFiltroLojas := nil;
  lTxt := getcfg.ReadSectionValuesLista('filtros');

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
      fFiltroLojas := lFiltro;
    end else
      fFILTROS.Add(lFiltro);
  end;

  if(fFiltroLojas=nil) then
  begin
    fFiltroLojas := fFiltroController.getByName('');
    fFiltroLojas.objeto.setTipoPorNome('@lojas');
  end;
  fFILTROS.Insert(0,fFiltroLojas);

  lTxt := getcfg.ReadSectionValuesLista('impressoes');
  if(lTxt.strings.Count=0) then
    lTxt.strings.Values['Padrao'] := 'Impressão Padrão';

  for i := 0 to lTxt.strings.Count - 1 do
  begin
    sName := Uppercase(trim( lTxt.strings.Names[i]));
    if(sName='') then continue;
    sValue := trim( lTxt.strings.ValueFromIndex[i]);
    lImpressao := TDadosImpressaoImpl.Create;
    fListaImpressao.Add(lImpressao);
    lImpressao.vModel := self;
    lImpressao.fNome := sName;
    lDescricao := textoEntreTags(sValue,'','|');
    lTitulo := '';
    if(lDescricao='') then
    begin
      lDescricao := sValue;
    end else
    begin
      lTitulo := textoEntreTags(sValue,'|','');
    end;
    if(lDescricao='') then
      lDescricao := fDESCRICAO;

    if(lTitulo='') then
      lTitulo := fDESCRICAO;
    lImpressao.fTitulo := lTitulo;
    lImpressao.fDescricao := lDescricao;
    j := fCfg.ReadInteger('impressao.'+lImpressao.fNome,'pagina.orientacao',0);
    lImpressao.fOrientacao := TOrientacaoImpressao(j);
    if not (lImpressao.fOrientacao in [ oiRetrato, oiPaisagem ]) then
      raise Exception.CreateFmt('Valor da Orientação [%d] inválido para a impressão [%s] de [%s]', [ i, lImpressao.fNome, fNOME ]);
  end;

  fPermissao := getCfg.ReadString('permissao','executar',tagConfig_GESTAO_RELATORIO_PERMISSAO);
  fPermissaoLoja := getCfg.ReadString('permissao','loja.executar',tagConfig_GESTAO_RELATORIO_LOJAS);
  fFiltroLojas.objeto.permissaoLojas := vConfiguracoes.objeto.verificaPerfil(getPermissaoLoja);
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
    //lDS: IDataset;
    f: TField;
    i: Integer;
    lCampos, lSql: String;
    lLojaModel: ITLojasModel;
    save: boolean;
    op: String;
    lTmp: IDatasetSimples;
    lLojaAsync: IQueryLojaAsync;
begin
  lTmp := vEstadoConsulta.datasetPaginada;
  precisaExecutar(vEstadoConsultaSumario);
  if (lTmp=nil) then
  begin
    executaQuery;
    lTmp := vEstadoConsulta.datasetPaginada;
  end;

  Result := vEstadoConsultaSumario.datasetCompleta;
  if(Result<>nil) then exit;
  save := fIgnoraPaginacao;
  fIgnoraPaginacao := true;
  try
    lQueryOriginal := getQuery;
  finally
    fIgnoraPaginacao := save;
  end;

  lCampos := '';
  getOperacoes;

  for i := 0 to lTmp.dataset.FieldCount - 1 do
  begin
    f := lTmp.dataset.Fields[i];
    if (not (f is TNumericField)) or (Pos(DBFIELDINTERNO, f.FieldName, 1)>0) or (fCfg.ReadBool('sumario',f.FieldName,true)=false) then continue;

    op := opFieldToStr(strToOpField(operacoes.strings.Values[f.FieldName]));
    if stringNoArray(op,['','n'],[osna_CaseInsensitive]) then continue;
    if(op='expr') then
      op := 'sum';

    if(lCampos<>'') then
      lCampos := lCampos + ',' + #13;
    lCampos := format('%s %s(coalesce(%s,0.0)) %s', [ lCampos, op, f.FieldName, f.FieldName ]);
  end;

  if(lCampos='') then
    exit;

  lSql := format( 'select %s from (%s) ', [ lCampos, lQueryOriginal ]);
  logaByTagSeNivel('', format('TEndpointModel(%s).sumario: [%s]',[fNOME, lSql]),LOG_LEVEL_DEBUG);


  i:=0;
  for lLojaModel in getFiltroLojas.objeto.listaLojas do
  begin
    queryLoja(lLojaModel,lSQL,i=0);
    inc(i);
  end;

  for lLojaModel in getFiltroLojas.objeto.listaLojas do
  begin
    lLojaAsync := getAsyncQueryFilial(lLojaModel);

    lLojaAsync.esperar;

    if(lLojaAsync.resultado.erros=0) then
    begin
      if(Result = nil) then
        Result := criadatasetSimples(cloneDataset(lLojaAsync.dataset.dataset,false,false,true));
      atribuirRegistrosSoma(lLojaAsync.dataset.dataset,Result.dataset,'*','','',operacoes);
    end else
      raise Exception.CreateFmt('Erro ao consultar loja [%s]: [%s]', [lLojaModel.objeto.LOJA, lLojaAsync.resultado.toString ]);
  end;

  formatarDataset(Result.dataset);
  getCfg;

  for i := 0 to Result.dataset.FieldCount - 1 do
  begin
    f := Result.dataset.Fields[i];
    f.Visible := fCfg.ReadBool('sumario',f.FieldName,f.Visible);
  end;
  vEstadoConsultaSumario.datasetCompleta := Result;
  vEstadoConsultaSumario.query:=getQuery;
  vEstadoConsultaSumario.filiais := getFiltroLojas.objeto.opcoesSelecionadas.text;
  vEstadoConsultaSumario.agrupamento := campoAgrupamento;
end;

function TEndpointModel.toTxt;
  var
    save: boolean;
begin
  if precisaExecutar(vEstadoConsulta) then
  try
    save := fIgnoraPaginacao;
    executaQuery;
  finally
    fIgnoraPaginacao := save;
  end;
  Result := datasetToTXT(vEstadoConsulta.datasetCompleta.dataset,pVisiveis,pFormatado);
end;

function TEndpointModel.getRegistros: Integer;
begin
  Result := fRegistros;
end;

function TEndpointModel.impressaoPorNome(const pNome: TipoWideStringFramework): IDadosImpressao;
  var
    p: IDadosImpressao;
begin
  for p in fListaImpressao do
    if(CompareText(p.nome,uppercase(trim(pNome)))=0) then
    begin
      Result := p;
      exit;
    end;
  if(Result=nil) then
    Result := fListaImpressao.First;
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
  var
    m: ITFiltroModel;
begin
  m := getBuscaAvancada;
  if(m<>nil) then
    Result := getBuscaAvancada.objeto.buscaAdicional
  else
    Result := '';
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

//  raise Exception.CreateFmt('Falta definir a busca adicional para [%s] ', [ fNOME]);
end;

function TEndpointModel.getFiltroAgrupamentos: ITFiltroModel;
  var
    p: ITFiltroModel;
begin
  if(fFiltroAgrupamentos=nil) then
    for p in FILTROS do
    begin
      if (p.objeto.TIPO=tipoFiltro_SetSincrono) and (p.objeto.subTipo=expressao_subtipoFiltro_Agrupamento) then
      begin
        fFiltroAgrupamentos := p;
        break;
      end;
    end;
  Result := fFiltroAgrupamentos;
end;

function TEndpointModel.getCampoAgrupamento: TipoWideStringFramework;
begin
  if(getFiltroAgrupamentos=nil) then
    Result := fFiltroLojas.objeto.campo
  else
    Result := trim(fFiltroAgrupamentos.objeto.opcoesSelecionadas.text);

end;

function TEndpointModel.getFiltroLojas: ITFiltroModel;
  var
    p: ITFiltroModel;
begin
  if(fFiltroLojas=nil) then
    for p in FILTROS do
    begin
      if p.objeto.TIPO=tipoFiltro_Lojas then
      begin
        fFiltroLojas := p;
        break;
      end;
    end;
  Result := fFiltroLojas;

  if(Result=nil) then
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

procedure TEndpointModel.setPermissaoLoja(const pValue: TipoWideStringFramework);
begin
  fPermissaoLoja := pValue;
end;

function TEndpointModel.getPermissaoLoja: TipoWideStringFramework;
begin
  if(fPermissaoLoja='') then
    fPermissaoLoja := tagConfig_GESTAO_RELATORIO_LOJAS;
  Result := fPermissaoLoja;
end;

procedure TEndpointModel.setListaImpressao(const pValue: IListaImpressao);
begin
  fListaImpressao := pValue;
end;

function TEndpointModel.getListaImpressao: IListaImpressao;
begin
  Result := fListaImpressao;
end;

procedure TEndpointModel.setUseVCL(const pValue: boolean);
begin
  fUseVCL := pValue;
end;

function TEndpointModel.getUseVCL: boolean;
begin
  Result := fUseVCL;
end;

function TEndpointModel.getAsyncQueryFilial(const loja: ITLojasModel): IQueryLojaAsync;
begin
  checkResultadoOperacao(vAsync);
  Result := nil;

  supports(vAsync.propriedade[loja.objeto.LOJA].asInterface,IQueryLojaAsync, Result);

  if(Result = nil)then begin
    Result := getQueryLojaAsync(loja);
    vAsync.propriedade[loja.objeto.LOJA].asInterface := Result;
  end;
end;


{ TDadosImpressaoImpl }

procedure TDadosImpressaoImpl.setOrientacao(const pValue: TOrientacaoImpressao);
begin
  fOrientacao := pValue;
end;

function TDadosImpressaoImpl.getOrientacao: TOrientacaoImpressao;
begin
  Result := fOrientacao;
end;

procedure TDadosImpressaoImpl.setTitulo(const pValue: TipoWideStringFramework);
begin
  fTitulo := pValue;
end;

function TDadosImpressaoImpl.getTitulo: TipoWideStringFramework;
begin
  Result := fTitulo;
end;

procedure TDadosImpressaoImpl.liberaEndpoint;
begin
  vModel := nil;
end;

procedure TDadosImpressaoImpl.setNome(const pValue: TipoWideStringFramework);
begin
  fNome := pValue;
end;

function TDadosImpressaoImpl.getNome: TipoWideStringFramework;
begin
  Result := fNome;
end;

procedure TDadosImpressaoImpl.setDescricao(const pValue: TipoWideStringFramework);
begin
  fDescricao := pValue;
end;

function TDadosImpressaoImpl.sumario: IDatasetSimples;
  var
    f: TField;
    i,j,k: Integer;
    l: IListaTextoEX;
    sNome, sValue: String;
begin
  if(vModel=nil) then
    raise Exception.Create('Modelo de relatório não existe mais.');

  Result := vModel.sumario;
  if(Result=nil) then exit;

  //Força leitura da cfg;
  vModel.getCfg;
  for i := 0 to Result.dataset.Fields.Count - 1 do
  begin
    f := Result.dataset.Fields[i];
    f.Visible := vModel.fCfg.ReadBool('impressao.'+fNome,f.FieldName,f.Visible);
    f.Visible := vModel.fCfg.ReadBool('impressao.sumario.'+fNome,f.FieldName,f.Visible);
    f.DisplayWidth := vModel.fCfg.ReadInteger('impressao.largura.'+fNome,f.FieldName,f.DisplayWidth);
    f.DisplayWidth := vModel.fCfg.ReadInteger('impressao.sumario.largura.'+fNome,f.FieldName,f.DisplayWidth);

    if f is TNumericField then
      f.Alignment := taRightJustify
    else
      f.Alignment := taLeftJustify;
    j := vModel.fCfg.ReadInteger('impressao.alinhamento.'+fNome,f.FieldName,-1);
    j := vModel.fCfg.ReadInteger('impressao.sumario.alinhamento.'+fNome,f.FieldName,j);
    if(j<>-1) then
      f.Alignment := TAlignment(j);
    if not (f.Alignment in [ taLeftJustify, taRightJustify, taCenter ]) then
      f.Alignment := taLeftJustify;

    f.DisplayLabel := vModel.fCfg.ReadString('impressao.label.'+fNome,f.FieldName,f.DisplayLabel);
    f.DisplayLabel := vModel.fCfg.ReadString('impressao.sumario.label.'+fNome,f.FieldName,f.DisplayLabel);
    if(f is TNumericField) then
    begin
      TNumericField(f).DisplayFormat := vModel.fCfg.ReadString('impressao.formato.'+fNome,f.FieldName,TNumericField(f).DisplayFormat);
      TNumericField(f).DisplayFormat := vModel.fCfg.ReadString('impressao.sumario.formato.'+fNome,f.FieldName,TNumericField(f).DisplayFormat);
    end;

    l := vModel.getCfg.ReadSectionValuesLista('impressao.posicao.'+fNome);
    for j := 0 to 5 do
    begin
      for k := 0 to l.strings.Count-1 do
      begin
        sNome := trim(l.strings.Names[k]);
        f:= Result.dataset.findField(sNome);
        if(f=nil) then continue;
        sValue := l.strings.ValueFromIndex[k];
        f.Index := StrToIntDef(sValue,f.Index);
      end;

      l := vModel.getCfg.ReadSectionValuesLista('impressao.sumario.posicao.'+fNome);
      for k := 0 to l.strings.Count-1 do
      begin
        sNome := trim(l.strings.Names[k]);
        f:= Result.dataset.findField(sNome);
        if(f=nil) then continue;
        sValue := l.strings.ValueFromIndex[k];
        f.Index := StrToIntDef(sValue,f.Index);
      end;
    end;

  end;
end;

function TDadosImpressaoImpl.dataset: IDatasetSimples;
  var
    save: boolean;
    f: TField;
    i,j,k: Integer;
    l: IListaTextoEX;
    sNome,sValue: String;
begin
  if(vModel=nil) then
    raise Exception.Create('Modelo de relatório não existe mais.');

  save := vModel.fIgnoraPaginacao;
  vModel.fIgnoraPaginacao := true;
  try
    Result := vModel.executaQuery(true);

    //Força leitura da cfg;
    vModel.getCfg;
    for i := 0 to Result.dataset.Fields.Count - 1 do
    begin
      f := Result.dataset.Fields[i];
      if(f.Visible=true) or ((f.tag and $8000)=0) then
        f.Visible := vModel.fCfg.ReadBool('impressao.'+fNome,f.FieldName,f.Visible);
      f.DisplayWidth := vModel.fCfg.ReadInteger('impressao.largura.'+fNome,f.FieldName,f.DisplayWidth);
      j := vModel.fCfg.ReadInteger('impressao.alinhamento.'+fNome,f.FieldName,-1);
      if f is TNumericField then
        f.Alignment := taRightJustify
      else
        f.Alignment := taLeftJustify;
      if(j<>-1) then
        f.Alignment := TAlignment(j);

      if not (f.Alignment in [ taLeftJustify, taRightJustify, taCenter ]) then
        f.Alignment := taLeftJustify;

      f.DisplayLabel := vModel.fCfg.ReadString('impressao.label.'+fNome,f.FieldName,f.DisplayLabel);
      if(f is TNumericField) then
        TNumericField(f).DisplayFormat := vModel.fCfg.ReadString('impressao.formato.'+fNome,f.FieldName,TNumericField(f).DisplayFormat);


      l := vModel.getCfg.ReadSectionValuesLista('impressao.posicao.'+fNome);
      for j := 0 to 5 do
        for k := 0 to l.strings.Count-1 do
        begin
          sNome := trim(l.strings.Names[k]);
          f:= Result.dataset.findField(sNome);
          if(f=nil) then continue;
          sValue := l.strings.ValueFromIndex[k];
          f.Index := StrToIntDef(sValue,f.Index);
        end;

    end;
  finally
    vModel.fIgnoraPaginacao := save;
  end;
end;

function TDadosImpressaoImpl.getDescricao: TipoWideStringFramework;
begin
  Result := fDescricao;
end;

end.
