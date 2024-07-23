
{$i definicoes.inc}

unit Terasoft.Framework.Controller.Boot.FormVCL;

interface
  uses
    Classes,
    SysUtils,
    Terasoft.Framework.Types,
    Terasoft.Framework.Texto,
    Terasoft.Framework.Generics.Controller;

  const
    PERFIL_VCL_FORM  = 'VCL.FORM';

  type
    TFormInitProc = reference to procedure;

  procedure registraFormInit(pProc: TFormInitProc; pOrdem: Integer = MaxInt);

implementation
  uses
    Terasoft.Framework.DB,
    Math,
    Spring.Collections,
    Forms, Terasoft.Framework.Generics.DAO;

  type

    TBootImpl = class(TBaseGenericControllerImpl,
      IGeneric_Controller,
      IGeneric_BootController
    )
    protected
      function doBoot(pResultado: IResultadoOperacao): IResultadoOperacao; override;
    end;

  var
    gListaProc: IList<TFormInitProc>;

function criaBoot(pTable, pPerfil, pNome, pRole: TipoWideStringFramework; pParam1: TipoWideStringFramework; pParam2: TipoWideStringFramework; pResultado: IUnknown): IUnknown;
  var
    p: TGenericCreator;
    lRes: IResultadoOperacao;
    c: TBootImpl;
begin
  Result := nil;
  lRes := checkResultadoOperacao(pResultado,pResultado);
  try
    c := TBootImpl.Create(pPerfil);
    Result := c;
  except
    on e: Exception do
      lRes.formataErro('criaBoot: %s: %s', [e.ClassName, e.Message]);
  end;
end;

procedure registra;
begin
  registerController(PERFIL_VCL_FORM,CONTROLLER_BOOT,criaBoot);
end;

{ TBootImpl }

function TBootImpl.doBoot(pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    p: TFormInitProc;
begin
  Result := checkResultadoOperacao(pResultado);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  getDao;

  if assigned(gListaProc) then
    for p in gListaProc do
      p();

  Application.Run;

end;

procedure registraFormInit(pProc: TFormInitProc; pOrdem: Integer = MaxInt);
begin
  if(gListaProc=nil) then
    gListaProc := TCollections.CreateList<TFormInitProc>;

  pOrdem := min(pOrdem,gListaProc.Count);

  gListaProc.Insert(pOrdem,pProc);

end;

initialization
  registra;

end.
