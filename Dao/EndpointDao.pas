unit EndpointDao;

interface
uses
  Terasoft.Framework.Types,
  EndpointModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  Interfaces.Conexao,
  Terasoft.Framework.Texto,
  Terasoft.Utils,
  Spring.Collections,
  Terasoft.Framework.DB,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TEndpointDao=class;
  ITEndpointDao=IObject<TEndpointDao>;

  TEndpointDao=class
  protected
    [weak] mySelf: ITEndpointDao;
    vIConexao   : IConexao;
    vIConstrutorDao: IConstrutorDao;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEndpointDao;

    function getByName(pName: TipoWideStringFramework): ITEndpointModel;
    function getLista(pFiltro: IListaTexto=nil; pOrdem: Integer = 2): TListaEndpointModel;

  end;

implementation
  uses
    FuncoesPesquisaDB;

{ TEndpointDao }
const
  METODO  = 'RELATORIO';

constructor TEndpointDao.Create(pIConexao: IConexao);
begin
  vIConexao := pIConexao;
  vIConstrutorDao:=criaConstrutorDao(pIConexao);
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

  vIConstrutorDao.setDatasetToModel(Result.objeto._TABELA_,lQry.dataset,Result.objeto);
  Result.objeto.loaded;

end;

function TEndpointDao.getLista;//
var
  lQry: IDataset;
  lSQL: String;
  s: TipoWideStringFramework;
  tmp: String;
  lIn: String;
  lModel: ITEndpointModel;
  usePtbr: boolean;
begin
  Result := TCollections.CreateList<ITEndpointModel>;
  lQry := vIConexao.gdb.criaDataset;
  if(pFiltro=nil) then
    pFiltro:=novaListaTexto;
  pFiltro.text := uppercase(retiraAcentos(pFiltro.text));
  usePtBr := vIConexao.gdb.charset=GDBFIB_CHARSETPTBR;
  if(usePtbr) then
    lIn := FuncoesPesquisaDB.ExpandeWhere('ep.nome,ep.descricao',pFiltro.text,tewcprefixodata_And,true)
  else
    lIn := FuncoesPesquisaDB.ExpandeWhere('upper(ep.nome),upper(ep.descricao)',pFiltro.text,tewcprefixodata_And,false);
  lSQL := 'select ep.* from endpoint ep where ep.metodo = :metodo '+#13
          + lIn;
  if(pOrdem = 1) then
    lSQL := lSQL + ' order by ep.nome '
  else if(pOrdem = 2) then
    lSQL := lSQL + ' order by cast(ep.descricao as varchar(256)) ';
  lQry.query(
      lSQL,
      'metodo', [ 'RELATORIO' ]);
  while not lQry.dataset.eof do
  begin
    lModel := getNewEndpointModel(vIConexao);
    vIConstrutorDao.setDatasetToModel(lModel.objeto._TABELA_,lQry.dataset,lModel.objeto);
    lModel.objeto.loaded;
    Result.add(lModel);

    lQry.dataset.Next;
  end;

end;

class function TEndpointDao.getNewIface(pIConexao: IConexao): ITEndpointDao;
begin
  Result := TImplObjetoOwner<TEndpointDao>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

end.
