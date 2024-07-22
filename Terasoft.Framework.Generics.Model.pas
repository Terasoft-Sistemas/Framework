
{$i definicoes.inc}

unit Terasoft.Framework.Generics.Model;

interface
  uses
    Terasoft.Framework.Types;

  type
    IGeneric_Model = interface
    ['{A163221B-01BC-40AA-BC94-EC368F742F49}']
      //
    end;

  procedure registerModel(pPerfil: TipoWideStringFramework; pModelName: TipoWideStringFramework; pModelCreator: TGenericCreator);

implementation
  uses
    Terasoft.Framework.Generics.Controller;

procedure registerModel;
begin
  Terasoft.Framework.Generics.Controller.registerModel(pPerfil,pModelName,pModelCreator);
end;

end.
implementation

end.
