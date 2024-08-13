unit FiltroModel;

interface
uses
  Terasoft.Framework.Types,
  System.SysUtils,
  Spring.Collections,
  Terasoft.Framework.MultiConfig,
  Terasoft.Framework.Texto,
  Terasoft.Framework.ObjectIface,
  Terasoft.Framework.DB,
  DB,
  LojasModel,
  Interfaces.Conexao;

type
  TTipoFiltro = (
      tipoFiltro_Desconhecido,
      tipoFiltro_Busca,
      tipoFiltro_Set,
      tipoFiltro_SetSincrono,
      tipoFiltro_Lojas,
      tipoFiltro_DataPeriodo,
      tipoFiltro_HoraPeriodo,
      tipoFiltro_DataHoraPeriodo
    );

  TFiltroModel=class;
  ITFiltroModel=IObject<TFiltroModel>;
  TListaFiltroModel=IList<ITFiltroModel>;

  TFiltroModel=class
  private
    [weak] mySelf: ITFiltroModel;
    //function getValores: IDatasetSimples;
  protected
    vIConexao   : IConexao;

    fAceitaNull: boolean;

    fID: TipoWideStringFramework;
    fNOME: TipoWideStringFramework;
    fDESCRICAO: TipoWideStringFramework;
    fPROPRIEDADES: TipoWideStringFramework;
    fCHAVE: TipoWideStringFramework;
    fCampo: TipoWideStringFramework;
    fOpcoesSelecionadas: IListaTextoEx;
    fRegistros: Integer;
    fPrimeiro: Integer;
    fTipo: TTipoFiltro;
    fBuscaAdicional: TipoWideStringFramework;
    fMultiploValor: boolean;

  //property multiploValor getter/setter
    function getMultiploValor: boolean;
    procedure setMultiploValor(const pValue: boolean);

    function getListaLojas: TILojasModelList;

  //property filtroAdicional getter/setter
    function getBuscaAdicional: TipoWideStringFramework;
    procedure setBuscaAdicional(const pValue: TipoWideStringFramework);

  //property dhInicial getter/setter
    function getDHInicial: Variant;
    procedure setDHInicial(const pValue: Variant);

    function getDHFinal: Variant;
    procedure setDHFinal(const pValue: Variant);

    procedure setDhPorIndice(const indice: Integer; const pValue: Variant);
    function getDhPorIndice(const indice: Integer): Variant;

  //property tipo getter/setter
    function getTipo: TTipoFiltro;
    procedure setTipo(const pValue: TTipoFiltro);

  //property primeiro getter/setter
    function getPrimeiro: Integer;
    procedure setPrimeiro(const pValue: Integer);

  //property registros getter/setter
    function getRegistros: Integer;
    procedure setRegistros(const pValue: Integer);

  //property opcoesSelecionadas getter/setter
    function getOpcoesSelecionadas: IListaTextoEx;
    procedure setOpcoesSelecionadas(const pValue: IListaTextoEx);

  //property CHAVE getter/setter
    function getCHAVE: TipoWideStringFramework;
    procedure setCHAVE(const pValue: TipoWideStringFramework);

    function getValido: boolean;

  //property ID getter/setter
    function getID: TipoWideStringFramework;
    procedure setID(const pValue: TipoWideStringFramework);

  //property DESCRICAO getter/setter
    function getDESCRICAO: TipoWideStringFramework;
    procedure setDESCRICAO(const pValue: TipoWideStringFramework);

  //property QUERY getter/setter
    function getPROPRIEDADES: TipoWideStringFramework;
    procedure setPROPRIEDADES(const pValue: TipoWideStringFramework);

  //property NOME getter/setter
    function getNOME: TipoWideStringFramework;
    procedure setNOME(const pValue: TipoWideStringFramework);

  //property campo getter/setter
    function getCampo: TipoWideStringFramework;
    procedure setCampo(const pValue: TipoWideStringFramework);

  public
    property ID: TipoWideStringFramework read getID write setID;
    property NOME: TipoWideStringFramework read getNOME write setNOME;
    property DESCRICAO: TipoWideStringFramework read getDESCRICAO write setDESCRICAO;
    property PROPRIEDADES: TipoWideStringFramework read getPROPRIEDADES write setPROPRIEDADES;
    property CHAVE: TipoWideStringFramework read getCHAVE write setCHAVE;
    property TIPO: TTipoFiltro read getTipo write setTipo;

    //Nome do campo utilizado na tabela pesquisada. Inicializado pelo endpoint
    property campo: TipoWideStringFramework read getCampo write setCampo;

    //Se não é válido, deverá usar BUSCA AVNÇADA...
    property valido: boolean read getValido;

    // Contém a lista de valores que serão usados no query
    property opcoesSelecionadas: IListaTextoEx read getOpcoesSelecionadas write setOpcoesSelecionadas;

    property registros: Integer read getRegistros write setRegistros;
    property primeiro: Integer read getPrimeiro write setPrimeiro;
    property dhInicial: Variant read getDHInicial write setDHInicial;
    property dhFinal: Variant read getDHFinal write setDHFinal;
    property buscaAdicional: TipoWideStringFramework read getBuscaAdicional write setBuscaAdicional;

    property listaLojas: TILojasModelList read getListaLojas;
    property multiploValor: boolean read getMultiploValor write setMultiploValor;


  protected
    fCfg: IMultiConfig;
    function getCFG: IMultiConfig;
    function listaOpcoes: IListaTextoEX;

  public
    const
      _TABELA_ = 'FILTROS';
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITFiltroModel;

    function getOpcoes(pBusca: TipoWideStringFramework=''; pOrdem: Integer = 2): IDatasetSimples;
    function query: TipoWideStringFramework;
    function setTipoPorNome(pNome: TipoWideStringFramework): TTipoFiltro;

  end;


implementation
  uses
    {$if defined(DEBUG)}
      ClipBrd,
    {$endif}
    Terasoft.FuncoesTexto,
    Variants,
    Terasoft.Framework.FuncoesDiversas,
    FuncoesPesquisaDB,
    DBClient;
{ TFiltroModel }

constructor TFiltroModel.Create(pIConexao: IConexao);
begin
  inherited Create;
  fMultiploValor := true;
//  fRegistros := 1000;
//  fPrimeiro := 0;
  vIConexao := pIConexao;
end;

destructor TFiltroModel.Destroy;
begin
  vIConexao:=nil;
  inherited;
end;

class function TFiltroModel.getNewIface(pIConexao: IConexao): ITFiltroModel;
begin
  Result := TImplObjetoOwner<TFiltroModel>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TFiltroModel.setID(const pValue: TipoWideStringFramework);
begin
  fID := pValue;
end;

function TFiltroModel.getID: TipoWideStringFramework;
begin
  Result := fID;
end;

procedure TFiltroModel.setNOME(const pValue: TipoWideStringFramework);
begin
  fNOME := pValue;
end;

function TFiltroModel.getNOME: TipoWideStringFramework;
begin
  Result := fNOME;
end;

procedure TFiltroModel.setCampo(const pValue: TipoWideStringFramework);
begin
  fCampo := pValue;
end;

function TFiltroModel.getCampo: TipoWideStringFramework;
begin
  Result := fCampo;
end;

procedure TFiltroModel.setPROPRIEDADES(const pValue: TipoWideStringFramework);
begin
  fPROPRIEDADES := pValue;
end;

function TFiltroModel.getPROPRIEDADES: TipoWideStringFramework;
begin
  Result := fPROPRIEDADES;
end;

function TFiltroModel.getValido: boolean;
begin
  Result := (fPROPRIEDADES<>'')// and (textoEntreTags(lName,'@','')<>'');
end;

function TFiltroModel.getOpcoes;///: IDatasetSimples;
  var
    lOpcoesTxt: IListaTextoEx;
    i: Integer;
    lName, lValue,lRegrasValores: String;
    cfg: IMultiConfig;
    lDao: IConstrutorDao;
    lCampos: IFDDataset;
    lDS: IDataset;
    lListaCampos: IListaTextoEX;
    validador: IValidadorDatabase;
    lFieldNames: String;
    s: TipoWideStringFramework;
    f: TField;
    lAdicional: String;
    lWhere: String;
    lSQL: String;
    lBusca: IListaTextoEX;
    txt: TipoWideStringFramework;
    found: boolean;
    lOrdem: String;
    lojaModel: ITLojasModel;
    lojasLista: TILojasModelList;
begin
  Result := nil;
  case getTipo of
    tipoFiltro_Busca,tipoFiltro_DataPeriodo,tipoFiltro_HoraPeriodo,tipoFiltro_DataHoraPeriodo:
      exit;
    tipoFiltro_Lojas:
    begin
      lojasLista := TLojasModel.getNewIface(vIConexao).objeto.obterLista;
      Result := getGenericID_DescricaoDataset;
      Result.dataset.fieldByName('ID').DisplayLabel := 'Loja';
      Result.dataset.fieldByName('descricao').DisplayLabel := 'Descrição';
      //fDatasetLojas := Result;
      for lojaModel in lojasLista do
      begin
        if(lojaModel.objeto.DATABASE='')then
          continue;
        Result.dataset.Append;
        Result.dataset.fieldByName('ID').AsString := lojaModel.objeto.LOJA;
        Result.dataset.fieldByName('descricao').AsString := lojaModel.objeto.DESCRICAO;
        Result.dataset.CheckBrowseMode;
      end;
      exit;
    end;
    tipoFiltro_Set,tipoFiltro_SetSincrono:;

    else
      Exception.CreateFmt('TFiltroModel.getOpcoes: Tipo [%d] desconhecido.', [ Ord(fTipo)] );
  end;

  pBusca := trim(pBusca);

  lRegrasValores:='';

  lOpcoesTxt := listaOpcoes;

  if (lOpcoesTxt.strings.Count>0) then
  begin
    Result := getGenericID_DescricaoDataset;
    Result.dataset.Fields[0].DisplayLabel := 'Código';
    Result.dataset.Fields[1].DisplayLabel := 'Descrição';
    for i := 0 to lOpcoesTxt.strings.Count - 1 do
    begin
      lName := lOpcoesTxt.strings.Names[i];
      lValue := lOpcoesTxt.strings.ValueFromIndex[i];
      Result.dataset.Append;
      Result.dataset.FieldValues['ID;DESCRICAO'] := array2Variant([lName,lValue]);
      Result.dataset.CheckBrowseMode;
    end;
  end else
  begin
    lOrdem:='';
    if pOrdem in [ 1, 2 ] then
    begin
      lOrdem := format(' order by %d ', [ pOrdem ]);
    end;

    cfg := getCFG;
    lName  := cfg.ReadString('query','tabela',fNOME);
    lRegrasValores:=textoEntreTags(lName,'@','');
    if(lRegrasValores='') then
    begin
      fCHAVE := cfg.ReadString('query','chave','');
      if(fCHAVE='') then
      begin
        lDao := criaConstrutorDao(vIConexao);
        lCampos := lDao.getColumns(lName);
        lCampos.objeto.First;
        if(lCampos.objeto.RecordCount=0) then
        begin
          //invalida tudo...
          fPROPRIEDADES := '';
          exit;
        end;
        fCHAVE := trim(lCampos.objeto.Fields[0].AsString);
      end;
      lDS := vIConexao.gdb.criaDataset;
      lListaCampos := cfg.ReadSectionValuesLista('campos');
      lFieldNames := '';
      if(lListaCampos.strings.Count = 0) then
      begin
        if(lDao=nil) then
          lDao := criaConstrutorDao(vIConexao);
        if(lCampos=nil) then
          lCampos := lDao.getColumns(lName);
      end;
      if(lFieldNames='') then
        for i := 0 to lListaCampos.strings.Count - 1 do
        begin
          s := trim(lListaCampos.strings.Names[i]);
          if(CompareText(s,fCHAVE)=0) then continue;
          lFieldNames := ','+lFieldNames;
          lFieldNames := lFieldNames + s;
        end;

      lAdicional := '';
      if(fRegistros>0) then
        lAdicional := format('%sfirst %d ', [ lAdicional, fRegistros ]);
      if(fPrimeiro>0) then
        lAdicional := format('%sskip %d ', [ lAdicional, fPrimeiro-1 ]);

      lWhere := '';
      if(pBusca<>'') then
        if(vIConexao.gdb.charset=GDBFIB_CHARSETPTBR) then
        lWhere := ExpandeWhere(format('%s;%s', [ fChave,lFieldNames]),pBusca,tewcprefixodata_And,true)
      else
        lWhere := ExpandeWhere(format('%s;%s', [ fChave,lFieldNames]),UpperCase(retiraAcentos(pBusca)),tewcprefixodata_And,false);

      if(lWhere<>'') then
        lWhere := ' where 1=1 ' + lWhere;
      lSQL := format('select %s %s %s from %s %s %s', [lAdicional, fChave,lFieldNames, lName, lWhere, lOrdem]);

      {$if defined(DEBUG)}
        Clipboard.AsText := lSQL;
      {$endif}

      lDS.query(lSQL,
                '', []);
      Supports(lDS,IDatasetSimples,Result);

      for i := 0 to lListaCampos.strings.Count - 1 do
      begin
        s := trim(lListaCampos.strings.Names[i]);
        f:= lDS.dataset.FieldByName(s);
        f.DisplayLabel := lListaCampos.strings.ValueFromIndex[i];
      end;
    end else
    begin
      //Valor em REGRASVALORES
      Supports(vIConexao.gdb.validador,IValidadorDatabase,validador);
      Result := validador.getValoresByName(lRegrasValores);
      Supports(cloneDatasource(Result),IDatasetSimples,Result);
      Result := criaDatasetSimples(cloneDataset(Result.dataset));
      Result.dataset.First;
      lBusca:=novaListaTexto;
      lBusca.strings.Delimiter := ' ';
      lBusca.strings.DelimitedText := UpperCase(retiraAcentos(pBusca));
      if(pBusca<>'') then
        while not Result.dataset.Eof do
        begin
          found := true;
          for txt in lBusca do
          begin
            if( Pos(String(txt),UpperCase(retiraAcentos(Result.dataset.Fields[1].AsString)))=0) then
            begin
              found := false;
              break;
            end;
          end;
          if(found=false) then
            Result.dataset.Delete
          else
            Result.dataset.Next;
        end;

      if(pOrdem in [1,2]) then
        TClientDataSet(Result.dataset).IndexFieldNames := Result.dataset.Fields[pOrdem - 1].FieldName;
    end;
  end;
end;

function TFiltroModel.getCFG: IMultiConfig;
begin
  if(fCfg=nil) then
  begin
    fCFG := criaMultiConfig.adicionaInterface(criaConfigIniString(fPROPRIEDADES));
    fMultiploValor := fCFG.ReadBool('filtro.propriedades', format('%s.multiplo',[fNome]),fMultiploValor);
  end;
  Result := fCFG;
end;

function TFiltroModel.listaOpcoes: IListaTextoEX;
begin
  Result := getCFG.ReadSectionValuesLista('opcoes');
end;

function TFiltroModel.query: TipoWideStringFramework;
  function getTipoBusca: String;
    var
      lIn: String;
      s: TipoWideStringFramework;
      usePtBr: boolean;
  begin
    Result := '';
    lIn := '';
    usePtBr := vIConexao.gdb.charset=GDBFIB_CHARSETPTBR;
    if(getOpcoesSelecionadas.text<>'') then
      if(usePtBr) then
        Result := ExpandeWhere(fCampo,fOpcoesSelecionadas.text,tewcprefixodata_None,true)
      else
        Result := ExpandeWhere(fCampo,uppercase(retiraAcentos(fOpcoesSelecionadas.text)),tewcprefixodata_None,false);
    if(usePtBr) then
      lIn := ExpandeWhere(fCampo,fBuscaAdicional,tewcprefixodata_None,true)
    else
      lIn := ExpandeWhere(fCampo,UpperCase(retiraAcentos(fBuscaAdicional)),tewcprefixodata_None,false);
    if(lIn<>'') then
    begin
      if(Result <> '') then
        Result := Result +#13+ '   and ';
      Result := Result + lIn;
    end;
  end;

  function getTipoSet: String;
    var
      lIn: String;
      s: TipoWideStringFramework;
  begin
    Result := '';
    lIn := '';
    if(getOpcoesSelecionadas.strings.Count=0) then exit;

    if(fOpcoesSelecionadas.strings.Count=1) then
      Result := fCampo + '=' + QuotedStr(fOpcoesSelecionadas.strings.Strings[0])
    else
    begin
      for s in fOpcoesSelecionadas do
      begin
        if(lIn<>'') then
          lIn:=lIn+','+#13;
        lIn := lIn + quotedStr(trim(s));
      end;
      lIn := '('+#13 + lIn + #13 + ')'+#13;
      Result := format('%s in %s', [fCampo, lIn]);

      if(fAceitaNull) and (Result<>'') then
      begin
        Result := format('(%s or %s is null)', [ Result, fCampo ]);
      end;
    end;
  end;

  function formata_Data(dt: TDateTime): String;
  begin
    case fTipo of

      tipoFiltro_DataPeriodo:
        Result := Terasoft.FuncoesTexto.transformaDataFireBird(dt);

      tipoFiltro_HoraPeriodo:
        Result := TimeToStr(dt);

      tipoFiltro_DataHoraPeriodo:
        Result := Terasoft.FuncoesTexto.transformaDataHoraFireBird(dt);
    end;

  end;

  function getTipoPeriodo: String;
    var
      di,df: Variant;
      lIn: String;
      s: TipoWideStringFramework;
  begin
    Result := '';
    lIn := '';
    di := getDhInicial;
    df := getDHFinal;

    if(VarIsNull(di) and VarIsNull(df)) then exit;

    if(VarIsNull(df)) then
      Result := fCampo + '>=' + QuotedStr(formata_Data(di))
    else if(VarIsNull(di)) then
      Result := fCampo + '<=' + QuotedStr(formata_Data(df))
    else
      Result := format( '%s between %s and %s ', [ fCampo, QuotedStr(formata_Data(di)), QuotedStr(formata_Data(df))]);

    if(fAceitaNull) and (Result<>'') then
    begin
      Result := format('(%s or %s is null)', [ Result, fCampo ]);
    end;

  end;

begin
  Result := '';
  case getTipo of

    tipoFiltro_Set,tipoFiltro_SetSincrono:
    begin
      Result := getTipoSet;
    end;

    tipoFiltro_Busca:
    begin
      Result := getTipoBusca;
    end;

    tipoFiltro_Lojas: ;// Não faz nada

    tipoFiltro_DataPeriodo,tipoFiltro_HoraPeriodo,tipoFiltro_DataHoraPeriodo:
    begin
      Result := getTipoPeriodo;
    end

    else
    begin
      raise Exception.CreateFmt('Tipo desconhecido: [%d]', [Ord(fTipo)]);
    end;

  end;

end;

procedure TFiltroModel.setDESCRICAO(const pValue: TipoWideStringFramework);
begin
  fDESCRICAO := pValue;
end;

function TFiltroModel.getDESCRICAO: TipoWideStringFramework;
begin
  Result := fDESCRICAO;
end;

procedure TFiltroModel.setCHAVE(const pValue: TipoWideStringFramework);
begin
  fCHAVE := pValue;
end;

function TFiltroModel.getCHAVE: TipoWideStringFramework;
begin
  Result := fCHAVE;
end;

procedure TFiltroModel.setOpcoesSelecionadas(const pValue: IListaTextoEx);
begin
  fOpcoesSelecionadas := pValue;
end;

function TFiltroModel.getOpcoesSelecionadas: IListaTextoEx;
begin
  if(fOpcoesSelecionadas=nil) then
    fOpcoesSelecionadas := novaListaTexto;
  Result := fOpcoesSelecionadas;
end;

procedure TFiltroModel.setRegistros(const pValue: Integer);
begin
  fRegistros := pValue;
end;

function TFiltroModel.getRegistros: Integer;
begin
  Result := fRegistros;
end;

procedure TFiltroModel.setPrimeiro(const pValue: Integer);
begin
  fPrimeiro := pValue;
end;

function TFiltroModel.getPrimeiro: Integer;
begin
  Result := fPrimeiro;
end;

procedure TFiltroModel.setTipo(const pValue: TTipoFiltro);
begin
  fAceitaNull := false;
  fTipo := pValue;
end;

function TFiltroModel.setTipoPorNome;
  var
    lNome, lDescricao: String;
begin
  lNome := textoEntreTags(pNome,'','|');
  if(lNome='') then
    lNome := pNome;
  lNome := UpperCase(retiraAcentos(lNome));
  lDescricao:=textoEntreTags(pNome,'|','');
  if(lDescricao='') then
    lDescricao:=fCampo;

  if(fDESCRICAO='') then
    fDESCRICAO := lDescricao;

  if(stringNoArray(lNome, ['@periodo','@periodo.data'],[osna_CaseInsensitive,osna_SemAcento])) then
  begin
    setTipo(tipoFiltro_DataPeriodo);
    fDESCRICAO := 'Período por data  ' + lDescricao;

  end else if(stringNoArray(lNome, ['@periodo.null'],[osna_CaseInsensitive,osna_SemAcento])) then
  begin
    setTipo(tipoFiltro_DataPeriodo);
    fDESCRICAO := 'Período por data ' + lDescricao;
    fAceitaNull := true;

  end else if(stringNoArray(lNome, ['@busca'],[osna_CaseInsensitive,osna_SemAcento])) then
  begin
    fDESCRICAO := 'Busca em Campos';
    setTipo(tipoFiltro_Busca);

  end else if(stringNoArray(lNome, ['@hora','@periodo.hora'],[osna_CaseInsensitive,osna_SemAcento])) then
  begin
    fDESCRICAO := 'Período por hora ' + lDescricao;
    setTipo(tipoFiltro_HoraPeriodo);

  end else if(stringNoArray(lNome, ['@loja','@lojas'],[osna_CaseInsensitive,osna_SemAcento])) then
  begin
    if(fNome='') then
      fNome := pNome;
    setTipo(tipoFiltro_Lojas);
    fCampo := fCampo;

    fDESCRICAO:=textoEntreTags(pNome,'|','');
    if(fDESCRICAO='') then
      fDESCRICAO := 'Lojas';

  end else if(stringNoArray(lNome, ['@datahora','@periodo.datahora'],[osna_CaseInsensitive,osna_SemAcento])) then
  begin
    fDESCRICAO := 'Período de data e hora ' + lDescricao;
    setTipo(tipoFiltro_DataHoraPeriodo);
  end else if(Copy(lNome,1,1)='@') then
  begin
    setTipo(tipoFiltro_SetSincrono);
    getCFG;
    if(fCfg.ReadString('query','tabela','')='') then
    begin
      fCfg.WriteString('query','tabela',lNome);
      if(fDESCRICAO='') then
        fDESCRICAO := textoEntreTags(lNome,'@','');
    end;
  end;
  Result := getTipo;
end;

function TFiltroModel.getTipo: TTipoFiltro;
  var
    cfg: IMultiConfig;
    lName, lRegrasValores: String;
begin
  try
    if(fTipo=tipoFiltro_Desconhecido) then
    begin
      //Precisamos inicializar...
      if(getValido=false) then
      begin
        fTipo := tipoFiltro_Busca;
        exit;
      end else
      begin
        cfg := getCFG;
        lName  := cfg.ReadString('query','tabela',fNOME);
        lRegrasValores:=textoEntreTags(lName,'@','');
        if(cfg.ReadBool('query','assincrono',false)=true) then
        begin
          fTipo := tipoFiltro_Set;
          if(fRegistros=0) then
            fRegistros := 100;
        end else
          fTipo := tipoFiltro_SetSincrono;
      end;
    end;
  finally
    Result := fTipo;
  end;
end;

procedure TFiltroModel.setDhInicial(const pValue: Variant);
begin
  setDhPorIndice(0,pValue);
end;

procedure TFiltroModel.setDhPorIndice(const indice: Integer;
  const pValue: Variant);
begin
  if(indice<0) then exit;
  while  getOpcoesSelecionadas.strings.Count <= indice do
    fOpcoesSelecionadas.strings.Add('');

  if VarIsNull(pValue) then
    fOpcoesSelecionadas.strings.Strings[indice]:=''
  else
    fOpcoesSelecionadas.strings.Strings[indice]:=pValue;

end;

function TFiltroModel.getDhPorIndice(const indice: Integer): Variant;
  var
    d: TDateTime;
begin
  Result := Null;
  if(getOpcoesSelecionadas.strings.Count>indice) then
  begin
    d := StrToDateTimeDef(fOpcoesSelecionadas.strings.Strings[indice],-1);
    if(d>-1) then
      Result := d;
  end;
end;

function TFiltroModel.getDhInicial: Variant;
begin
  Result := getDhPorIndice(0);
end;

function TFiltroModel.getDHFinal: Variant;
begin
  Result := getDhPorIndice(1);
end;

procedure TFiltroModel.setDHFinal(const pValue: Variant);
begin
  setDhPorIndice(1,pValue);
end;

procedure TFiltroModel.setBuscaAdicional(const pValue: TipoWideStringFramework);
begin
  fBuscaAdicional := pValue;
end;

function TFiltroModel.getBuscaAdicional: TipoWideStringFramework;
begin
  Result := fBuscaAdicional;
end;

function TFiltroModel.getListaLojas: TILojasModelList;
  var
    p: ITLojasModel;
    i: Integer;
begin
  Result := TLojasModel.getNewIface(vIConexao).objeto.obterLista;
  if(getOpcoesSelecionadas.strings.Count>0) then
  begin
    i := Result.Count;
    while i>0 do
    begin
      dec(i);
      p := Result[i];
      if(getOpcoesSelecionadas.strings.IndexOf(p.objeto.LOJA)=-1) then
      begin
        Result.Remove(p);
      end;
    end;
  end;

  i := Result.Count;
  while i>0 do
  begin
    dec(i);
    p := Result[i];
    if(p.objeto.DATABASE='') then
      Result.Remove(p);
  end;
  if(Result.Count=0) then
    Result := TLojasModel.getNewIface(vIConexao).objeto.obterLista;

  if(fMultiploValor=false) then
    while Result.Count>1 do
      Result.Delete(Result.Count-1);
end;

procedure TFiltroModel.setMultiploValor(const pValue: boolean);
begin
  fMultiploValor := pValue;
end;

function TFiltroModel.getMultiploValor: boolean;
begin
  //Força leitura
  getCFG;
  Result := fMultiploValor;
end;

end.
