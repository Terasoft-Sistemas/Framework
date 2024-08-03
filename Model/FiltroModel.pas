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
  Interfaces.Conexao;

type
  TFiltroModel=class;
  ITFiltroModel=IObject<TFiltroModel>;
  TListaFiltroModel=IList<ITFiltroModel>;

  TFiltroModel=class
  private
    [weak] mySelf: ITFiltroModel;
    //function getValores: IDatasetSimples;
  protected
    vIConexao   : IConexao;

    fID: TipoWideStringFramework;
    fNOME: TipoWideStringFramework;
    fDESCRICAO: TipoWideStringFramework;
    fPROPRIEDADES: TipoWideStringFramework;
    fCHAVE: TipoWideStringFramework;
    fCampo: TipoWideStringFramework;
    fOpcoesSelecionadas: IListaTextoEx;
    fRegistros: Integer;
    fPrimeiro: Integer;

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

    //Nome do campo utilizado na tabela pesquisada. Inicializado pelo endpoint
    property campo: TipoWideStringFramework read getCampo write setCampo;

    //Se não é válido, deverá usar BUSCA AVNÇADA...
    property valido: boolean read getValido;

    // Contém a lista de valores que serão usados no query
    property opcoesSelecionadas: IListaTextoEx read getOpcoesSelecionadas write setOpcoesSelecionadas;

    property registros: Integer read getRegistros write setRegistros;
    property primeiro: Integer read getPrimeiro write setPrimeiro;

  protected
    function getCFG: IMultiConfig;
    function listaOpcoes: IListaTextoEX;

  public
    const
      _TABELA_ = 'FILTROS';
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITFiltroModel;

    function getOpcoes(pBusca: TipoWideStringFramework=''): IDatasetSimples;
    function query: TipoWideStringFramework;

  end;


implementation
  uses
    {$if defined(DEBUG)}
      ClipBrd,
    {$endif}
    FuncoesPesquisaDB,
    DBClient;
{ TFiltroModel }

constructor TFiltroModel.Create(pIConexao: IConexao);
begin
  inherited Create;
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

begin
  Result := nil;
  if not valido then
    exit;
  pBusca := trim(pBusca);

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
        lAdicional := format('%sskip %d ', [ lAdicional, fPrimeiro ]);

      lWhere := '';
      if(pBusca<>'') then
        lWhere := ExpandeWhere(format('%s;%s', [ fChave,lFieldNames]),pBusca,tewcprefixodata_And,false );

      if(lWhere<>'') then
        lWhere := ' where 1=1 ' + lWhere;
      lSQL := format('select %s %s %s from %s %s', [lAdicional, fChave,lFieldNames, lName, lWhere]);

      Clipboard.AsText := lSQL;

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
    end;
  end;
end;

function TFiltroModel.getCFG: IMultiConfig;
begin
  Result := criaMultiConfig.adicionaInterface(criaConfigIniString(fPROPRIEDADES));
end;

function TFiltroModel.listaOpcoes: IListaTextoEX;
begin
  Result := getCFG.ReadSectionValuesLista('opcoes');
end;

function TFiltroModel.query: TipoWideStringFramework;
  var
    s: TipoWideStringFramework;
    lIn: String;
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

end.
