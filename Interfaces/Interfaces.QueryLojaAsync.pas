
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
    Terasoft.Types,
    Interfaces.Conexao,
    Spring.Collections,
    Terasoft.Framework.PoolThreads,

    Terasoft.Framework.Collections,
    LojasModel;

  type
    IQueryLojaAsync=interface;

    IListaQueryAsync=IList<IQueryLojaAsync>;

    IQueryLojaAsync = interface(IProcesso)
    ['{AD9398AF-B0B4-4FAD-A65E-68B8D7C0D9CF}']
    //property GDB getter/setter
      function getGDB: IGDB;
      procedure setGDB(const pValue: IGDB);

      //procedure run;

      {
        execQuery executa pQuery com os campos e parametros fornecidos.
        Ao Executar, transfere os registros para uma memtable,
        na propriedade dataset: IDatasetSimples abaixo.
        Erros são reportados na propriedade resultado: IResultadoOperacao
      }
      procedure execQuery(const pQuery, pCampos: TipoWideStringFramework; pParametros: TVariantArray);

      {
        openQuery faz o OPEN simplesmente do objeto IFDQuery.
        Ao abrir, transfere os registros para uma memtable,
        na propriedade dataset: IDatasetSimples abaixo.
        Erros são reportados na propriedade resultado: IResultadoOperacao
      }
      procedure openQuery(pQuery: IFDQuery; pExecute: boolean =false; pSQL: TipoWideStringFramework='');

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
      property parametros: TVariantArray read getParametros write setParametros;
      property campos: TipoWideStringFramework read getCampos write setCampos;
      property query: TipoWideStringFramework read getQuery write setQuery;
      property loja: ITLojasModel read getLoja write setLoja;
      property GDB: IGDB read getGDB write setGDB;
    end;

    function getQueryLojaAsync(pLoja: ITLojasModel; pRotulo: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IQueryLojaAsync;

    function getQueryLojaAsyncList(pIConexao:IConexao; pView: String=''): IListaQueryAsync;
    function getQueryLojaAsyncHostsList(pIConexao:IConexao; pView: String=''): IListaQueryAsync;


implementation
  uses
    System.SyncObjs,
    Terasoft.Framework.LOG;

  type
    TQueryLojaAsync = class(TBaseProcessoThread,
        IQueryLojaAsync,
        IInterface
        )
    protected
      vExecute: boolean;
      fGDB: IGDB;
      fLoja: ITLojasModel;
      fQuery: TipoWideStringFramework;
      fCampos: TipoWideStringFramework;
      fParametros: TVariantArray;
      fDataset: IDatasetSimples;
      fCriaOperacoes: boolean;
      fFdQuery: IFDQuery;
      procedure doExecutar; override;

    //property fdQuery getter/setter
      function getFdQuery: IFDQuery;
      procedure setFdQuery(const pValue: IFDQuery);

      function _Release: Integer; stdcall;

    //property criaOperacoes getter/setter
      function getCriaOperacoes: boolean;
      procedure setCriaOperacoes(const pValue: boolean);

    //property dataset getter/setter
      function getDataset: IDatasetSimples;

      procedure execQuery(const pQuery, pCampos: TipoWideStringFramework; pParametros: TVariantArray);
      procedure openQuery(pQuery: IFDQuery; pExecute: boolean; pSQL: TipoWideStringFramework);

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
      constructor Create(pRotulo: TipoWideStringFramework; pResultado: IResultadoOperacao);
      destructor Destroy; override;
    end;


function getQueryLojaAsyncList;
  var
    lLojas,lLoja: ITLojasModel;
    lQLA: IQueryLojaAsync;
begin
  Result := TCollections.CreateList<IQueryLojaAsync>;

  lLojas := TLojasModel.getNewIface(pIConexao);

  lLojas.objeto.LojaView := pView;
  //lLojas.objeto.obterHosts;

  for lLoja in lLojas.objeto.obterLista do
  begin
    lQLA := getQueryLojaAsync(lLoja);
    Result.Add(lQLA);
  end;

end;

function getQueryLojaAsyncHostsList;
  var
    lLojas,lLoja: ITLojasModel;
    lQLA: IQueryLojaAsync;
begin
  Result := TCollections.CreateList<IQueryLojaAsync>;

  lLojas := TLojasModel.getNewIface(pIConexao);

  lLojas.objeto.LojaView := pView;
  lLojas.objeto.obterHosts;

  for lLoja in lLojas.objeto.LojassLista do
  begin
    lQLA := getQueryLojaAsync(lLoja);
    Result.Add(lQLA);
  end;

end;

function getQueryLojaAsync;
begin
  Result := TQueryLojaAsync.Create(pRotulo,pResultado);
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
//  if(getStatus=sqal_Running) and (FRefCount=2) then
//    monitora(self);
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

procedure TQueryLojaAsync.doExecutar;
  var
    ds: IDataset;
begin
  try

    logaByTagSeNivel('',format('Executando query [%s] async para a loja [%s] em [%s]: [%s]',[fRotulo, fLoja.objeto.LOJA, getGDB.databaseName, fQuery] ), LOG_LEVEL_DEBUG);

    if(self.fQuery<>'') and (self.fFdQuery=nil) then
    begin

      if(getGDB.ativo=false) then
        raise Exception.Create('TQueryLojaAsync.AsyncRun: Banco de dados não conetado.');

      logaByTagSeNivel('',format('Executando query [%s] async para a loja [%s] em [%s]: [%s]',[fRotulo,fLoja.objeto.LOJA, getGDB.databaseName, fQuery] ), LOG_LEVEL_DEBUG);

      ds := self.fGDB.criaDataset.query(self.fQuery,self.fCampos,self.fParametros);

      //clone como TFDMemTable e cria campos operações
      if(ds.dataset.Active) then
      begin
        fDataset := criaDatasetSimples(cloneDataset(ds.dataset,false,fCriaOperacoes));
        fDataset.dataset.First;
        logaByTagSeNivel('',format('Executando query [%s] async para a loja [%s] retornou [%d / %d] registros:',[fRotulo,fLoja.objeto.LOJA, ds.dataset.recordcount, fDataset.dataset.recordCount] ), LOG_LEVEL_DEBUG);
      end;

    end else if (fQuery<>'') and (fFdQuery<>nil) then
    begin
      fFdQuery.objeto.close;
      logaByTagSeNivel('',format('Executando query [%s] async para a loja [%s] em [%s]: [%s]',[fRotulo,fLoja.objeto.LOJA, getGDB.databaseName, fQuery] ), LOG_LEVEL_DEBUG);
      if(vExecute) then
        fFdQuery.objeto.ExecSQL(fQuery)
      else
        fFdQuery.objeto.Open(fQuery);
      //clone como TFDMemTable e cria campos operações
      if(fFdQuery.objeto.Active) then
      begin
        fDataset := criaDatasetSimples(cloneDataset(fFdQuery.objeto,false,fCriaOperacoes));
        fDataset.dataset.First;
        logaByTagSeNivel('',format('Executando query [%s] async para a loja [%s] retornou [%d / %d] registros:',[fRotulo,fLoja.objeto.LOJA, fFdQuery.objeto.recordcount, fDataset.dataset.recordCount] ), LOG_LEVEL_DEBUG);
      end;

    end else if (fFdQuery<>nil) and (fFdQuery.objeto.SQL.Text<>'') then
    begin
      fFdQuery.objeto.close;
      logaByTagSeNivel('',format('Executando query [%s] async para a loja [%s] em [%s]: [%s]',[fRotulo,fLoja.objeto.LOJA, getGDB.databaseName, fFdQuery.objeto.SQL.Text] ), LOG_LEVEL_DEBUG);
      if(vExecute) then
        fFdQuery.objeto.ExecSQL
      else
        fFdQuery.objeto.Open;
      //clone como TFDMemTable e cria campos operações
      if(fFdQuery.objeto.Active) then
      begin
        fDataset := criaDatasetSimples(cloneDataset(fFdQuery.objeto,false,fCriaOperacoes));
        fDataset.dataset.First;
        logaByTagSeNivel('',format('Executando query [%s] async para a loja [%s] retornou [%d / %d] registros:',[fRotulo,fLoja.objeto.LOJA, fFdQuery.objeto.recordcount, fDataset.dataset.recordCount] ), LOG_LEVEL_DEBUG);
      end;
    end else
      raise Exception.Create('TQueryLojaAsync.AsyncRun: Query não especificado.');


  except
    on e: Exception do
    begin
      getResultado.formataErro('TQueryLojaAsync.AsyncRun [%s]: %s: %s', [ fRotulo, e.ClassName, e.Message ]);
      if(self.fQuery<>'') then
        logaByTagSeNivel('',format('TQueryLojaAsync.AsyncRun: Exception query [%s] async para a loja [%s] query [%s]: %s: %s',[fRotulo,fLoja.objeto.LOJA, fQuery, e.className, e.message ] ), LOG_LEVEL_DEBUG)
      else if(self.fQuery<>'') then
        logaByTagSeNivel('',format('TQueryLojaAsync.AsyncRun: Exception query [%s] async para a loja [%s] query [%s]: %s: %s',[fRotulo,fLoja.objeto.LOJA, fFdQuery.objeto.sql.text, e.className, e.message ] ), LOG_LEVEL_DEBUG);
    end;
  end;
end;

constructor TQueryLojaAsync.Create;
begin
  inherited;
end;

destructor TQueryLojaAsync.Destroy;
begin
  inherited;
end;

procedure TQueryLojaAsync.execQuery(const pQuery, pCampos: TipoWideStringFramework; pParametros: TVariantArray);
begin
  esperar;
  fQuery := pQuery;
  fFdQuery:=nil;
  fCampos := pCampos;
  fParametros := pParametros;
  runAsync;
end;

procedure TQueryLojaAsync.openQuery;
begin
  esperar;
  vExecute := pExecute;
  fFdQuery := pQuery;
  fQuery := pSQL;
  fCampos := '';
  fParametros := [];
  runAsync;
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

initialization

finalization

end.
