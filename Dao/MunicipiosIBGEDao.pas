unit MunicipiosIBGEDao;

interface

uses
  MunicipiosIBGEModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TMunicipiosIBGEDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function obterLista(pMunicipio : String; pUF : Integer): IFDDataset;
end;

implementation

{ TMunicipiosIBGE }


constructor TMunicipiosIBGEDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TMunicipiosIBGEDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TMunicipiosIBGEDao.obterLista(pMunicipio : String; pUF : Integer): IFDDataset;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  try

    lSql := ' select cogigo_ibga codigo_ibge,                                          '+sLineBreak+
            '        municipio                                                         '+sLineBreak+
            '   from municipios_ibge                                                   '+sLineBreak+
            '  where municipio = '+QuotedStr(pMunicipio)                                +sLineBreak+
            '    and substring(cogigo_ibga from 1 for 2) = ' + QuotedStr(IntToStr(pUF)) +sLineBreak+
            '  order by municipio ';

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

end.
