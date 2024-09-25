unit TipoVendaModel;

interface

uses

  Terasoft.Types,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TTipoVendaModel = class;
  ITTipoVendaModel=IObject<TTipoVendaModel>;

  TTipoVendaModel = class
  private
    [unsafe] mySelf: ITTipoVendaModel;
    vConexao : IConexao;
  public

  	constructor _Create(pConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITTipoVendaModel;

    function ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): IFDDataset;

  end;

implementation

uses
  TipoVendaDao,
  System.SysUtils;

{ TTipoVendaModel }

constructor TTipoVendaModel._Create(pConexao : IConexao);
begin
    vConexao := pConexao;
end;

destructor TTipoVendaModel.Destroy;
begin
  vConexao := nil;
  inherited;
end;

class function TTipoVendaModel.getNewIface(pIConexao: IConexao): ITTipoVendaModel;
begin
  Result := TImplObjetoOwner<TTipoVendaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TTipoVendaModel.ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): IFDDataset;
var
  lTipoVendaDao: ITTipoVendaDao;
  lTipoVenda_Parametros: TTipoVenda_Parametros;
begin
  lTipoVendaDao := TTipoVendaDao.getNewIface(vConexao);

  try
    lTipoVenda_Parametros.TipoVendas := pTipoVenda_Parametros.TipoVendas;

    Result := lTipoVendaDao.objeto.ObterLista(lTipoVenda_Parametros);

  finally
    lTipoVendaDao:=nil;
  end;
end;

end.
