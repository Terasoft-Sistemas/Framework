
{$i definicoes.inc}

unit Terasoft.Framework.Generics.View;

interface
  uses
    Terasoft.Framework.Types;

  type
    IGeneric_View = interface
    ['{FD041182-06DA-4829-9CEB-3A81C6EF9ECA}']
      //
    end;

  procedure registerView(pPerfil: TipoWideStringFramework; pViewName: TipoWideStringFramework; pViewCreator: TGenericCreator);


implementation
  uses
    Terasoft.Framework.Generics.Controller;

procedure registerView;
begin
  Terasoft.Framework.Generics.Controller.registerView(pPerfil,pViewName,pViewCreator);
end;

end.
