unit MunicipiosIBGEModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  Spring.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Terasoft.FuncoesTexto;

type
  TMunicipiosIBGEModel=class;
  ITMunicipiosIBGEModel=IObject<TMunicipiosIBGEModel>;

  TMunicipiosIBGEModel = class
  private
    [unsafe] mySelf: ITMunicipiosIBGEModel;
    vIConexao : IConexao;

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITMunicipiosIBGEModel;

    function obterLista(pMunicipio, pUF : String): IFDDataset;

  end;

implementation

uses
  MunicipiosIBGEDao,
  System.Classes, 
  System.SysUtils;

{ TMunicipiosIBGEModel }

constructor TMunicipiosIBGEModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TMunicipiosIBGEModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

class function TMunicipiosIBGEModel.getNewIface(pIConexao: IConexao): ITMunicipiosIBGEModel;
begin
  Result := TImplObjetoOwner<TMunicipiosIBGEModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TMunicipiosIBGEModel.obterLista(pMunicipio, pUF : String): IFDDataset;
var
  lMunicipiosIBGELista: ITMunicipiosIBGEDao;
begin
  lMunicipiosIBGELista := TMunicipiosIBGEDao.getNewIface(vIConexao);

  Result := lMunicipiosIBGELista.objeto.obterLista(pMunicipio, codigoUF(pUF));
end;

end.
