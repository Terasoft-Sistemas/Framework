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
      [weak] mySelf: ITFiltroDao;
      vIConexao   : IConexao;
      vIConstrutorDao: IConstrutorDao;
    public
      constructor Create(pIConexao : IConexao);
      destructor Destroy; override;

      class function getNewIface(pIConexao: IConexao): ITFiltroDao;

      function getByName(pName: TipoWideStringFramework): ITFiltroModel;
      function getLista(pNames: IListaString): TListaFiltroModel;

    end;

implementation

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
begin
  lQry := vIConexao.gdb.criaDataset;
  Result := TFiltroModel.getNewIface(vIConexao);
  pName := UpperCase(trim(pName));
  lQry.query(
      'select f.* from filtros f where f.nome = :nome ',
      'nome', [ pName ]);

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

end.
