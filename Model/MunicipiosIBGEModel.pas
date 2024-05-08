unit MunicipiosIBGEModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client,
  Terasoft.FuncoesTexto;

type

  TMunicipiosIBGEModel = class

  private
    vIConexao : IConexao;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function obterLista(pMunicipio, pUF : String): TFDMemTable;

  end;

implementation

uses
  MunicipiosIBGEDao,
  System.Classes, 
  System.SysUtils;

{ TMunicipiosIBGEModel }

constructor TMunicipiosIBGEModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TMunicipiosIBGEModel.Destroy;
begin
  inherited;
end;

function TMunicipiosIBGEModel.obterLista(pMunicipio, pUF : String): TFDMemTable;
var
  lMunicipiosIBGELista: TMunicipiosIBGEDao;
begin
  lMunicipiosIBGELista := TMunicipiosIBGEDao.Create(vIConexao);

  try
    Result := lMunicipiosIBGELista.obterLista(pMunicipio, codigoUF(pUF));
  finally
    lMunicipiosIBGELista.Free;
  end;
end;

end.
