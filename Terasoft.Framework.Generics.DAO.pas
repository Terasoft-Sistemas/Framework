
{$i definicoes.inc}

unit Terasoft.Framework.Generics.DAO;

interface
  uses
    Terasoft.Framework.Types;

  type
    IGeneric_DAO = interface
    ['{08AC6E5D-79B4-4534-9D72-CAB6815908F1}']
      //
    end;

  procedure registerDAO(pPerfil: TipoWideStringFramework; pDAOName: TipoWideStringFramework; pDAOCreator: TGenericCreator);


implementation
  uses
    Terasoft.Framework.Generics.Controller;

procedure registerDAO;
begin
  Terasoft.Framework.Generics.Controller.registerDAO(pPerfil,pDAOName,pDAOCreator);
end;

end.
implementation

end.
