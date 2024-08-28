
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
    Interfaces.Conexao,
    Spring.Collections,
    Terasoft.Framework.Collections,
    LojasModel;

  type
    IQueryLojaAsync=interface;

    IListaQueryAsync=IList<IQueryLojaAsync>;

    TVariantArray = array of Variant;

    TStatusQueryAsyncLoja = (sqal_Idle, sqal_Running);

    IQueryLojaAsync = interface
    ['{AD9398AF-B0B4-4FAD-A65E-68B8D7C0D9CF}']
    //property GDB getter/setter
      function getGDB: IGDB;
      procedure setGDB(const pValue: IGDB);

      procedure run;
      procedure execQuery(const pQuery, pCampos: TipoWideStringFramework; pParametros: TVariantArray);
      procedure openQuery(pQuery: IFDQuery);

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

    //property fdQuery getter/setter
      function getFdQuery: IFDQuery;
      procedure setFdQuery(const pValue: IFDQuery);

      property FDQuery: IFDQuery read getFdQuery write setFdQuery;
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

    function getQueryLojaAsyncList(pIConexao:IConexao): IListaQueryAsync;


implementation
  uses
    AsyncCalls;

  type
    TQueryLojaAsync = class(TInterfacedObject,
        IQueryLojaAsync,
        IInterface,
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
      fFdQuery: IFDQuery;

    //property fdQuery getter/setter
      function getFdQuery: IFDQuery;
      procedure setFdQuery(const pValue: IFDQuery);

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
      procedure openQuery(pQuery: IFDQuery);

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


  TThreadMonitoramento = class(TThread)
  protected
    procedure Execute; override;
  public
    destructor Destroy; override;
  end;

  var
    gListaLocal: ILockList<IQueryLojaAsync>;
    th: TThreadMonitoramento;


procedure monitora(pQuery: IQueryLojaAsync);
begin
  if(gListaLocal=nil) then
    gListaLocal := TLockListImpl<IQueryLojaAsync>.Create;
  gListaLocal.add(pQuery);
  if(th=nil) then
  begin
    th := TThreadMonitoramento.Create;
    th.FreeOnTerminate:=true;
  end;
end;

function getQueryLojaAsyncList;
  var
    lLojas,lLoja: ITLojasModel;
    lQLA: IQueryLojaAsync;
begin
  Result := TCollections.CreateList<IQueryLojaAsync>;

  lLojas := TLojasModel.getNewIface(pIConexao);
  lLojas.objeto.obterHosts;

  for lLoja in lLojas.objeto.LojassLista do
  begin
    lQLA := getQueryLojaAsync(lLoja);
    Result.Add(lQLA);
  end;

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
  if(getStatus=sqal_Running) and (FRefCount=2) then
    monitora(self);
  inherited;
end;

procedure TQueryLojaAsync.setFdQuery(const pValue: IFDQuery);
begin
  fFdQuery := pValue;
end;

function TQueryLojaAsync.getFdQuery: IFDQuery;
begin
  Result := fFdQuery;
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
    if(fQuery<>'') and (fFdQuery=nil) then
    begin

      if(getGDB.ativo=false) then
        raise Exception.Create('TQueryLojaAsync.AsyncRun: Banco de dados não conetado.');

      ds := fGDB.criaDataset.query(fQuery,fCampos,fParametros);

      //clone como TFDMemTable e cria campos operações
      fDataset := criaDatasetSimples(cloneDataset(ds.dataset,false,fCriaOperacoes));
      fDataset.dataset.First;

    end else if (fQuery<>'') and (fFdQuery<>nil) then
    begin
      fFdQuery.objeto.Open(fQuery);
      //clone como TFDMemTable e cria campos operações
      fDataset := criaDatasetSimples(cloneDataset(fFdQuery.objeto,false,fCriaOperacoes));
      fDataset.dataset.First;

    end else if (fFdQuery<>nil) and (fFdQuery.objeto.SQL.Text<>'') then
    begin
      fFdQuery.objeto.Open;
      //clone como TFDMemTable e cria campos operações
      fDataset := criaDatasetSimples(cloneDataset(fFdQuery.objeto,false,fCriaOperacoes));
      fDataset.dataset.First;


    end else
      raise Exception.Create('TQueryLojaAsync.AsyncRun: Query não especificado.');


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
  fFdQuery:=nil;
  fCampos := pCampos;
  fParametros := pParametros;
  run;
end;

procedure TQueryLojaAsync.openQuery(pQuery: IFDQuery);
begin
  espera;
  fFdQuery := pQuery;
  fCampos := '';
  fParametros := [];
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

{ TThreadMonitoramento }

destructor TThreadMonitoramento.Destroy;
begin
  Terminate;
  WaitFor;
  th := nil;
  inherited;
end;

procedure TThreadMonitoramento.Execute;
  var
    p: IQueryLojaAsync;
begin
  inherited;
  while not Terminated do
    while gListaLocal.count>0 do
      try
        sleep(50);
        if(gListaLocal.dequeue(p)) then
        begin
          p.espera
        end;
      except

      end;

end;

initialization


finalization
  FreeAndNil(th);

end.
