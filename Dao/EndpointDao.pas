
{$i definicoes.inc}

unit EndpointDao;

interface
uses
  Terasoft.Framework.Types,
  EndpointModel,
  DB,
  FireDAC.Comp.Client,
  System.SysUtils,
  Interfaces.Conexao,
  Terasoft.Framework.Texto,
  Terasoft.Utils,
  Spring.Collections,
  Terasoft.Framework.DB,
  Terasoft.Framework.ObjectIface,
  Terasoft.Configuracoes,
  Terasoft.ConstrutorDao;

type
  TEndpointDao=class;
  ITEndpointDao=IObject<TEndpointDao>;

  TEndpointDao=class
  protected
    [unsafe] mySelf: ITEndpointDao;
    vIConexao   : IConexao;
    vIConstrutorDao: IConstrutorDao;
    vConfiguracoes: ITerasoftConfiguracoes;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEndpointDao;

    function getEndpointListXML: TListaEndpointModel;
    function getEndpointXMLByName(const pName: TipoWideStringFramework): ITEndpointModel;

    function getByName(pName: TipoWideStringFramework): ITEndpointModel;
    function getLista(pFiltro: IListaTexto=nil; pStartingWith: boolean = false; pOrdem: Integer = 2): TListaEndpointModel;

    function getFromRecord(pDataset: TDataset): ITEndpointModel;

  end;

implementation
  uses
    FuncoesConfig,FuncoesArquivos,
    FuncoesPesquisaDB;

{ TEndpointDao }
const
  METODO  = 'RELATORIO';

constructor TEndpointDao.Create;
begin
  vIConexao := pIConexao;
  vIConstrutorDao:=criaConstrutorDao(pIConexao);
  Supports(vIConexao.terasoftConfiguracoes,ITerasoftConfiguracoes,vConfiguracoes);
  if(vConfiguracoes=nil) then
    raise Exception.Create('Não existe configuração disponível');
end;

destructor TEndpointDao.Destroy;
begin
  vIConstrutorDao := nil;
  vIConexao := nil;
  inherited;
end;

function TEndpointDao.getByName(pName: TipoWideStringFramework): ITEndpointModel;
var
  lQry: IDataset;
begin
  lQry := vIConexao.gdb.criaDataset;
  Result := getNewEndpointModel(vIConexao);
  pName := UpperCase(trim(pName));
  lQry.query(
      'select ep.* from endpoint ep where ep.metodo = :metodo and ep.nome = :nome ',
      'metodo;nome', [ METODO, pName ]);

  if(lQry.dataset.RecordCount=0) then
    Result := getEndpointXMLByName(pName)
  else
  begin
    vIConstrutorDao.setDatasetToModel(Result.objeto._TABELA_,lQry.dataset,Result.objeto);
    Result.objeto.loaded;
  end;

  if(vConfiguracoes.objeto.verificaPerfil(Result.objeto.permissao)=false) then
    Result := nil;

end;

function sortNome(const Left, Right: ITEndpointModel): Integer;
begin
  Result := CompareText(Left.objeto.NOME,Right.objeto.NOME);
end;

function sortDescricao(const Left, Right: ITEndpointModel): Integer;
begin
  Result := CompareText(Left.objeto.DESCRICAO,Right.objeto.DESCRICAO);
end;

function TEndpointDao.getLista;
var
  lQry: IDataset;
  lSQL: String;
  s: TipoWideStringFramework;
  tmp: String;
  lIn: String;
  lModel: ITEndpointModel;
  usePtbr: boolean;
  i: Integer;
begin
  Result := getEndpointListXML;
  //Result := TCollections.CreateList<ITEndpointModel>;
  lQry := vIConexao.gdb.criaDataset;
  if(pFiltro=nil) then
    pFiltro:=novaListaTexto;
  pFiltro.text := uppercase(retiraAcentos(pFiltro.text));

  lSQL := 'select ep.nome from endpoint ep where ep.metodo = :metodo '+#13
          + lIn;

  lQry.query(
      lSQL,
      'metodo', [ 'RELATORIO' ]);

  while not lQry.dataset.eof do
  begin
    lModel := getByName(lQry.dataset.FieldByName('nome').AsString);//
    if(lModel<>nil) then
    begin
      i:=Result.Count;
      while i > 0 do
      begin
        dec(i);
        if(Result[i].objeto.NOME=lModel.objeto.NOME) then
        begin
          Result.Delete(i);
          break;
        end;
      end;
      Result.add(lModel);
    end;

    lQry.dataset.Next;
  end;

  i := Result.Count;
  while i > 0 do
  begin
    dec(i);
    lModel := Result[i];
    if(vConfiguracoes.objeto.verificaPerfil(lModel.objeto.permissao)=false) or (listaValoresMatch([lModel.objeto.DESCRICAO,lModel.objeto.NOME],pFiltro.text,pStartingWith)=false) then
      Result.Delete(i);
  end;

  if(pOrdem = 1) then
    Result.Sort(sortNome)
  else if(pOrdem = 2) then
    Result.Sort(sortDescricao);

end;

class function TEndpointDao.getNewIface;
begin
  Result := TImplObjetoOwner<TEndpointDao>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TEndpointDao.getEndpointListXML: TListaEndpointModel;
  var
    local: String;
    ds: IDatasetSimples;
    lModel: ITEndpointModel;
  const
    XMLENDPOINT = 'ENDPOINT.xml';
begin
  Result := TCollections.CreateList<ITEndpointModel>;
  local := '';
  {$if defined(DEBUG)}
    local := 'C:\FTS\Tags\dados\';
    if (not FileExists(local + XMLENDPOINT )) then
      local := '';
  {$endif}

  if (local='') then
    local := config_DiretorioAtualizado + 'tags\';

  local := local + XMLENDPOINT;
  if (not FileExists(local)) then exit;

  ds := getDatasetFromFile(local);
  if(ds=nil) then exit;
  ds.dataset.First;
  while not ds.dataset.eof do
  begin
     if (inDebugMode) or (Pos('DEBUG', UpperCase(retiraAcentos(ds.dataset.FieldByName('nome').AsString)),1)=0) then
      begin
        lModel := getNewEndpointModel(vIConexao);
        vIConstrutorDao.setDatasetToModel(lModel.objeto._TABELA_,ds.dataset,lModel.objeto);
        lModel.objeto.loaded;
        Result.add(lModel);
      end;

    ds.dataset.Next;
  end;

end;

function TEndpointDao.getEndpointXMLByName;
  var
    local: String;
    ds: IDatasetSimples;
  const
    XMLENDPOINT = 'ENDPOINT.xml';
begin
  Result := TEndpointModel.getNewIface(vIConexao);
  local := '';
  {$if defined(DEBUG)}
    local := 'C:\FTS\Tags\dados\';
    if (not FileExists(local + XMLENDPOINT )) then
      local := '';
  {$endif}

  if (local='') then
    local := config_DiretorioAtualizado + 'tags';

  local := local + XMLENDPOINT;
  if (not FileExists(local)) then exit;

  ds := getDatasetFromFile(local);
  if(ds=nil) then exit;
  ds.dataset.First;
  while not ds.dataset.eof do
  begin
    if(CompareText(ds.dataset.FieldByName('nome').AsString,pName)=0) then
    begin
      vIConstrutorDao.setDatasetToModel(Result.objeto._TABELA_,ds.dataset,Result.objeto);
      Result.objeto.loaded;
      exit;
    end;
    ds.dataset.Next;
  end;

end;

function TEndpointDao.getFromRecord(pDataset: TDataset): ITEndpointModel;
begin
  Result := TEndpointModel.getNewIface(vIConexao);
  if(pDataset=nil) or (pDataset.recordCount=0) then
    exit;
  vIConstrutorDao.setDatasetToModel(Result.objeto._TABELA_,pDataset,Result.objeto);
  Result.objeto.loaded;

end;

end.
