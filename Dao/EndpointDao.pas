unit EndpointDao;

interface
uses
  Terasoft.Framework.Types,
  EndpointModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  Interfaces.Conexao,
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
    function getLista(pNames: IListaString): TListaEndpointModel;

  end;

implementation

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
  Result := TEndpointModel.getNewIface(vIConexao);
  pName := UpperCase(trim(pName));
  lQry.query(
      'select ep.* from endpoint ep where ep.metodo = :metodo and ep.nome = :nome ',
      'metodo;nome', [ METODO, pName ]);

  vIConstrutorDao.setDatasetToModel(Result.objeto._TABELA_,lQry.dataset,Result.objeto);

end;

function TEndpointDao.getLista(pNames: IListaString): TListaEndpointModel;
var
  lQry: IDataset;
  s: TipoWideStringFramework;
  tmp: String;
  lIn: String;
  lModel: ITEndpointModel;
begin
  Result := TCollections.CreateList<ITEndpointModel>;
  lQry := vIConexao.gdb.criaDataset;
  if(pNames=nil) then
    pNames:=getStringList;
  lIn := vIConstrutorDao.expandIn('ep.nome',pNames);
  lQry.query(
      'select ep.* from endpoint ep where ep.metodo = :metodo '+#13
          + lIn,
      'metodo', [ 'RELATORIO' ]);
  while not lQry.dataset.eof do
  begin
    lModel := TEndpointModel.getNewIface(vIConexao);
    vIConstrutorDao.setDatasetToModel(lModel.objeto._TABELA_,lQry.dataset,lModel.objeto);
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
