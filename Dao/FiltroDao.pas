unit FiltroDao;

interface
uses
  Terasoft.Framework.Types,
  FiltroModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  Interfaces.Conexao,
  Terasoft.Utils,
  Spring.Collections,
  Terasoft.Framework.DB,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

  type

    TFiltroDao=class;
    ITFiltroDao=IObject<TFiltroDao>;

    TFiltroDao=class
    private
      [unsafe] mySelf: ITFiltroDao;
      vIConexao   : IConexao;
      vIConstrutorDao: IConstrutorDao;
    public
      constructor Create(pIConexao : IConexao);
      destructor Destroy; override;

      class function getNewIface(pIConexao: IConexao): ITFiltroDao;

      function getByName(pName: TipoWideStringFramework): ITFiltroModel;
      function getLista(pNames: IListaString): TListaFiltroModel;

      function getFiltroXMLByName(const pNome: String): ITFiltroModel;


    end;

implementation
  uses
    FuncoesArquivos, FuncoesConfig,
    Terasoft.Framework.Texto;

{ TFiltroDao }

constructor TFiltroDao.Create(pIConexao: IConexao);
begin
  vIConexao := pIConexao;
  vIConstrutorDao := criaConstrutorDao(pIConexao);
end;

destructor TFiltroDao.Destroy;
begin
  vIConstrutorDao := nil;
  vIConexao := nil;
  inherited;
end;

function TFiltroDao.getByName(pName: TipoWideStringFramework): ITFiltroModel;
  var
    lQry: IDataset;
    lName: String;
begin
  lQry := vIConexao.gdb.criaDataset;

  Result := TFiltroModel.getNewIface(vIConexao);

  pName := trim(pName);
  if(pName='') or (pName[1]='@') then
    exit;

  lName := textoEntreTags(pName,'','|');
  if(lName='') then
    lName := pName;

  lName := UpperCase(retiraAcentos(lName));
  lQry.query(
      'select f.* from filtros f where f.nome = :nome ',
      'nome', [ lName ]);

  if(lQry.dataset.RecordCount=0) then
    Result := getFiltroXMLByName(lName)
  else
    vIConstrutorDao.setDatasetToModel(Result.objeto._TABELA_,lQry.dataset,Result.objeto);

end;

function TFiltroDao.getLista(pNames: IListaString): TListaFiltroModel;
begin

end;

class function TFiltroDao.getNewIface(pIConexao: IConexao): ITFiltroDao;
begin
  Result := TImplObjetoOwner<TFiltroDao>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TFiltroDao.getFiltroXMLByName(const pNome: String): ITFiltroModel;
  var
    local: String;
    ds: IDatasetSimples;
  const
    XMLFILTROS = 'FILTROS.xml';
begin
  Result := TFiltroModel.getNewIface(vIConexao);
  local := '';
  {$if defined(DEBUG)}
    local := 'C:\FTS\Tags\dados\';
    if (not FileExists(local + XMLFILTROS )) then
      local := '';
  {$endif}

  if (local='') then
    local := config_DiretorioAtualizado + 'tags\';

  local := local + XMLFILTROS;
  if (not FileExists(local)) then exit;

  ds := getDatasetFromFile(local);
  if(ds=nil) then exit;
  ds.dataset.First;
  while not ds.dataset.eof do
  begin
    if(CompareText(ds.dataset.FieldByName('nome').AsString,pNome)=0) then
    begin
      vIConstrutorDao.setDatasetToModel(Result.objeto._TABELA_,ds.dataset,Result.objeto);
      exit;
    end;
    ds.dataset.Next;
  end;

end;


end.
