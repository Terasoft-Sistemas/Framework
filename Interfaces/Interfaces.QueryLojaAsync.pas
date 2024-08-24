
{$i definicoes.inc}

unit Interfaces.QueryLojaAsync;

interface
  uses
    Classes,
    SysUtils,
    Terasoft.Framework.Types,
    Terasoft.Framework.DB,
    Terasoft.Framework.Texto,
    Variants,
    LojasModel;

  type
    TVariantArray = array of Variant;

    TStatusQueryAsyncLoja = (sqal_Idle, sqal_Running);

    IQueryLojaAsync = interface
    ['{AD9398AF-B0B4-4FAD-A65E-68B8D7C0D9CF}']
    //property GDB getter/setter
      function getGDB: IGDB;
      procedure setGDB(const pValue: IGDB);

      procedure run;
      procedure execQuery(const pQuery, pCampos: TipoWideStringFramework; pParametros: TVariantArray);

    //property loja getter/setter
      function getLoja: ITLojasModel;
      procedure setLoja(const pValue: ITLojasModel);

    //property query getter/setter
      function getQuery: TipoWideStringFramework;
      procedure setQuery(const pValue: TipoWideStringFramework);

    //property campos getter/setter
      function getCampos: TipoWideStringFramework;
      procedure setCampos(const pValue: TipoWideStringFramework);

    //property parametros getter/setter
      function getParametros: TVariantArray;
      procedure setParametros(const pValue: TVariantArray);

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property status getter/setter
      function getStatus: TStatusQueryAsyncLoja;

      procedure espera;

    //property dataset getter/setter
      function getDataset: IDatasetSimples;

    //property criaOperacoes getter/setter
      function getCriaOperacoes: boolean;
      procedure setCriaOperacoes(const pValue: boolean);

      property criaOperacoes: boolean read getCriaOperacoes write setCriaOperacoes;
      property dataset: IDatasetSimples read getDataset;
      property status: TStatusQueryAsyncLoja read getStatus;
      property resultado: IResultadoOperacao read getResultado write setResultado;
      property parametros: TVariantArray read getParametros write setParametros;
      property campos: TipoWideStringFramework read getCampos write setCampos;
      property query: TipoWideStringFramework read getQuery write setQuery;
      property loja: ITLojasModel read getLoja write setLoja;
      property GDB: IGDB read getGDB write setGDB;
    end;

    function getQueryLojaAsync(pLoja: ITLojasModel): IQueryLojaAsync;


implementation
  uses
    AsyncCalls;

  type
    TQueryLojaAsync = class(TInterfacedObject,
        IQueryLojaAsync,
        IINterface,
        IAsyncRunnable)
    protected
      [volatile] vCall: IAsyncCall;
      fGDB: IGDB;
      fLoja: ITLojasModel;
      fQuery: TipoWideStringFramework;
      fCampos: TipoWideStringFramework;
      fParametros: TVariantArray;
      fResultado: IResultadoOperacao;
      fDataset: IDatasetSimples;
      fCriaOperacoes: boolean;

      function _Release: Integer; stdcall;

    //property criaOperacoes getter/setter
      function getCriaOperacoes: boolean;
      procedure setCriaOperacoes(const pValue: boolean);

    //property dataset getter/setter
      function getDataset: IDatasetSimples;

      procedure run;
      procedure espera;
      procedure AsyncRun;
      procedure execQuery(const pQuery, pCampos: TipoWideStringFramework; pParametros: TVariantArray);

    //property status getter/setter
      function getStatus: TStatusQueryAsyncLoja;

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property parametros getter/setter
      function getParametros: TVariantArray;
      procedure setParametros(const pValue: TVariantArray);

    //property campos getter/setter
      function getCampos: TipoWideStringFramework;
      procedure setCampos(const pValue: TipoWideStringFramework);

    //property query getter/setter
      function getQuery: TipoWideStringFramework;
      procedure setQuery(const pValue: TipoWideStringFramework);

    //property loja getter/setter
      function getLoja: ITLojasModel;
      procedure setLoja(const pValue: ITLojasModel);

    //property GDB getter/setter
      function getGDB: IGDB;
      procedure setGDB(const pValue: IGDB);
    public
      destructor Destroy; override;
    end;


function getQueryLojaAsync(pLoja: ITLojasModel): IQueryLojaAsync;
begin
  Result := TQueryLojaAsync.Create;
  Result.loja := pLoja;
end;

{ TQueryLojaAsync }

procedure TQueryLojaAsync.setCriaOperacoes(const pValue: boolean);
begin
  fCriaOperacoes := pValue;
end;

function TQueryLojaAsync.getCriaOperacoes: boolean;
begin
  Result := fCriaOperacoes;
end;

function TQueryLojaAsync.getDataset: IDatasetSimples;
begin
  Result := fDataset;
end;

function TQueryLojaAsync._Release: Integer;
begin
  getStatus;
  inherited;
end;

function TQueryLojaAsync.getStatus: TStatusQueryAsyncLoja;
begin
  if(vCall<>nil) and (vCall.Finished=false) then
    Result := sqal_Running
  else
  begin
    vCall := nil;
    Result := sqal_Idle;
  end;
end;

procedure TQueryLojaAsync.run;
begin
  espera;
  fResultado := nil;
  vCall:=AsyncCall(self);
end;

procedure TQueryLojaAsync.setResultado(const pValue: IResultadoOperacao);
begin
  fResultado := pValue;
end;

function TQueryLojaAsync.getResultado: IResultadoOperacao;
begin
  Result := checkResultadoOperacao(fResultado);
end;

procedure TQueryLojaAsync.setParametros;
begin
  fParametros := pValue;
end;

function TQueryLojaAsync.getParametros;
begin
  Result := fParametros;
end;

procedure TQueryLojaAsync.setCampos(const pValue: TipoWideStringFramework);
begin
  fCampos := pValue;
end;

procedure TQueryLojaAsync.AsyncRun;
  var
    ds: IDataset;
begin
  try
    if(fQuery='') then
      raise Exception.Create('TQueryLojaAsync.AsyncRun: Query não especificado.');

    if(getGDB.ativo=false) then
      raise Exception.Create('TQueryLojaAsync.AsyncRun: Banco de dados não conetado.');

    ds := fGDB.criaDataset.query(fQuery,fCampos,fParametros);

    //clone como TFDMemTable e cria campos operações
    fDataset := criaDatasetSimples(cloneDataset(ds.dataset,false,fCriaOperacoes));
    fDataset.dataset.First;

  except
    on e: Exception do
      getResultado.formataErro('TQueryLojaAsync.AsyncRun: %s: %s', [ e.ClassName, e.Message ]);
  end;
end;

destructor TQueryLojaAsync.Destroy;
begin
  if(vCall<>nil) then
  begin
    //espera acabar...
    espera;
    //espera mais um pouco...
    sleep(100);
    vCall := nil;
  end;

  inherited;
end;

procedure TQueryLojaAsync.espera;
begin
  while getStatus<>sqal_Idle do
    sleep(50);
  vCall := nil;
end;

procedure TQueryLojaAsync.execQuery(const pQuery, pCampos: TipoWideStringFramework; pParametros: TVariantArray);
begin
  espera;
  fQuery := pQuery;
  fCampos := pCampos;
  fParametros := pParametros;
  run;
end;

function TQueryLojaAsync.getCampos: TipoWideStringFramework;
begin
  Result := fCampos;
end;

procedure TQueryLojaAsync.setQuery(const pValue: TipoWideStringFramework);
begin
  fQuery := pValue;
end;

function TQueryLojaAsync.getQuery: TipoWideStringFramework;
begin
  Result := fQuery;
end;

procedure TQueryLojaAsync.setLoja;
begin
  fLoja := pValue;
end;

function TQueryLojaAsync.getLoja;
begin
  Result := fLoja;
end;

procedure TQueryLojaAsync.setGDB(const pValue: IGDB);
begin
  fGDB := pValue;
end;

function TQueryLojaAsync.getGDB: IGDB;
begin
  if(fGDB=nil) then
  begin
    if(fLoja=nil) then
      raise Exception.Create('TQueryLojaAsync.getGDB: Não especificou uma loja válida');
    fGDB := fLoja.objeto.conexaoLoja.gdb;
  end;
  Result := fGDB;
end;

end.
