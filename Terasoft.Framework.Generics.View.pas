
{$i definicoes.inc}

unit Terasoft.Framework.Generics.View;

interface
  uses
    Classes, SysUtils,
    Forms,
    Terasoft.Framework.Texto,
    Terasoft.Framework.Types;

  type
    PForm = ^TForm;

    IGeneric_View = interface
    ['{FD041182-06DA-4829-9CEB-3A81C6EF9ECA}']
      function view(pResultado: IResultadoOperacao): IResultadoOperacao;
      function viewModal(pResultado: IResultadoOperacao): IResultadoOperacao;
      //
    end;

    TGenericViewVCLForm = class(TInterfacedObject,
          IGeneric_View)
    protected
      fFormClass: TFormClass;
      fFormVar: PForm;
      fForm: TForm;
      function view(pResultado: IResultadoOperacao): IResultadoOperacao;
      function viewModal(pResultado: IResultadoOperacao): IResultadoOperacao;
      procedure createForm;
    public
      destructor Destroy; override;
    end;

  procedure registerView(pPerfil: TipoWideStringFramework; pViewName: TipoWideStringFramework; pViewCreator: TGenericCreator);

  //procedure registerGenerciViewVCLForm(pPerfil: TipoWideStringFramework; pViewName: TipoWideStringFramework; pViewCreator: TGenericCreator);

implementation
  uses
    Terasoft.Framework.Generics.Controller;

procedure registerView;
begin
  Terasoft.Framework.Generics.Controller.registerView(pPerfil,pViewName,pViewCreator);
end;

{ TGenericViewVCLForm }

procedure TGenericViewVCLForm.createForm;
begin
  if (fForm <> nil)  or (fFormClass=nil) then
    exit;
  fForm :=fFormClass.Create(nil);
  if(fFormVar<>nil) then
    fFormVar^ := fForm;
end;

destructor TGenericViewVCLForm.Destroy;
begin
  freeAndNil(fForm);
  if assigned(fFormVar) then
    fFormVar^ := nil;

  inherited;
end;

function TGenericViewVCLForm.view;
begin
  Result := checkResultadoOperacao(pResultado);
  createForm;
  if(fForm=nil) then
  begin
    pResultado.formataErro('%s: Classe do view não especificada.',[ClassName]);
    exit;
  end;
  fForm.Show;
end;

function TGenericViewVCLForm.viewModal;
begin
  Result := checkResultadoOperacao(pResultado);
  createForm;
  if(fForm=nil) then
  begin
    pResultado.formataErro('%s: Classe do view não especificada.',[ClassName]);
    exit;
  end;
  fForm.ShowModal;
end;

end.
