
{$i definicoes.inc}

unit Terasoft.Framework.Generics.Controller;

interface
  uses
    Classes,Sysutils,
    Terasoft.Framework.Types, Terasoft.Framework.Texto;

  const
    GENERIC_TEXT_PADRAO = 'PADRAO';

  type

    IGeneric_Controller = interface
    ['{73BAA3FD-417C-4C90-A307-897E1B2381A0}']
    //property perfil getter/setter
      function getPerfil: TipoWideStringFramework;

      property perfil: TipoWideStringFramework read getPerfil;
    end;

    function getGenericController(pPerfil, pNome: TipoWideStringFramework): IGeneric_Controller;

    procedure genericRegister(pTable: TipoWideStringFramework; pPerfil: TipoWideStringFramework; pName: TipoWideStringFramework; pGenericCreator: TGenericCreator);
    procedure registerModel(pPerfil: TipoWideStringFramework; pModelName: TipoWideStringFramework; pModelCreator: TGenericCreator);
    procedure registerDAO(pPerfil: TipoWideStringFramework; pDAOName: TipoWideStringFramework; pDAOCreator: TGenericCreator);
    procedure registerView(pPerfil: TipoWideStringFramework; pViewName: TipoWideStringFramework; pViewCreator: TGenericCreator);
    procedure registerController(pPerfil: TipoWideStringFramework; pControllerName: TipoWideStringFramework; pControllerCreator: TGenericCreator);

//    function createGeneric(pPerfil: TipoWideStringFramework; pName: TipoWideStringFramework; pResultado: IUnknown): IUnknown;
    function createGenericIface(pTable, pPerfil, pNome, pRole: TipoWideStringFramework; pParam1: TipoWideStringFramework; pParam2: TipoWideStringFramework; pResultado: IUnknown): IUnknown;


implementation
  uses
    Terasoft.Framework.Exceptions,
    strUtils,
    System.SyncObjs,
    Terasoft.Framework.Collections,
    Generics.Collections;

  const
    GENERICTABLE_CONTROLLER = 'CONTROLLER';
    GENERICTABLE_MODEL = 'MODEL';
    GENERICTABLE_VIEW  = 'VIEW';
    GENERICTABLE_DAO   = 'DAO';

  type
    TGenericControllerImpl = class(TInterfacedObject, IGeneric_Controller)
    protected
      fPerfil: TipoWideStringFramework;

    //property perfil getter/setter
      function getPerfil: TipoWideStringFramework;
    public
      constructor Create(pPerfil: TipoWideStringFramework);
    end;

  TPairNameCreator = TPair<TipoWideStringFramework,TGenericCreator>;
  TPairPerfilCreator = TPair<TipoWideStringFramework,TPairNameCreator>;
  TPairTablePerfilCreator = TPair<TipoWideStringFramework,TPairPerfilCreator>;

  ILockNameCreator = ILockDictionary<TipoWideStringFramework,TGenericCreator>;
  ILockPerfilCreator = ILockDictionary<TipoWideStringFramework,ILockNameCreator>;
  ILockTablePerfilCreator = ILockDictionary<TipoWideStringFramework,ILockPerfilCreator>;

  var
    gDic: ILockTablePerfilCreator;

function getGenericCreator(pTable: TipoWideStringFramework; pPerfil: TipoWideStringFramework; pName: TipoWideStringFramework): TGenericCreator;
  var
    lpc: ILockPerfilCreator;
    lnc: ILockNameCreator;
    gc: TGenericCreator;
begin

  pTable := UpperCase(trim(pTable));

  if(pTable = '') then
    pTable := GENERIC_TEXT_PADRAO;

  pPerfil := UpperCase(trim(pPerfil));
  if(pPerfil='')then
    pPerfil:=GENERIC_TEXT_PADRAO;

  pName := UpperCase(trim(pName));
  if(pName='')then
    raise EValorIncorreto.Create('genericRegister: Parâmetro pName não inválido.');

  if(gDic=nil) then
    gDic := Terasoft.Framework.Collections.TCreateLock.CreateDictionary<TipoWideStringFramework,ILockPerfilCreator>(getComparadorOrdinalTipoWideStringFramework);

  if not gDic.TryGetValue(pTable,lpc) then
  begin
    lpc := Terasoft.Framework.Collections.TCreateLock.CreateDictionary<TipoWideStringFramework,ILockNameCreator>(getComparadorOrdinalTipoWideStringFramework);
    gDic.addOrSetValue(pPerfil,lpc);
  end;

  if not lpc.TryGetValue(pPerfil,lnc) then
  begin
    lnc := Terasoft.Framework.Collections.TCreateLock.CreateDictionary<TipoWideStringFramework,TGenericCreator>(getComparadorOrdinalTipoWideStringFramework);
    lpc.addOrSetValue(pPerfil,lnc);
  end;

  if not lnc.TryGetValue(pName, Result) then
    Result := nil;

end;

function createGenericIface;//(pTable: TipoWideStringFramework; pPerfil: TipoWideStringFramework; pName: TipoWideStringFramework; pResultado: IUnknown): IUnknown;
  var
    p: TGenericCreator;
    lRes: IResultadoOperacao;
begin
  Result := nil;
  lRes := checkResultadoOperacao(pResultado,pResultado);
  try
    p := getGenericCreator(pTable,pPerfil,pNome);
    if not assigned(p) then
    begin
      lRes.formataErro('createGeneric: Não existe creator para [%s] [%s] [%s]', [pTable,pPerfil, pNome]);
    end;
  except
    on e: Exception do
      lRes.formataErro('createGeneric: %s: %s', [e.ClassName, e.Message]);
  end;
end;

procedure genericRegister(pTable: TipoWideStringFramework; pPerfil: TipoWideStringFramework; pName: TipoWideStringFramework; pGenericCreator: TGenericCreator);
  var
    lpc: ILockPerfilCreator;
    lnc: ILockNameCreator;
    gc: TGenericCreator;
begin
  if not assigned(pGenericCreator) then
    raise EValorIncorreto.Create('genericRegister: Parâmetro pGenericCreator não informado.');

  pTable := UpperCase(trim(pTable));
  if(pTable = '') then
    pTable := GENERIC_TEXT_PADRAO;

  pPerfil := UpperCase(trim(pPerfil));
  if(pPerfil='')then
    pPerfil:=GENERIC_TEXT_PADRAO;

  pName := UpperCase(trim(pName));
  if(pName='')then
    raise EValorIncorreto.Create('genericRegister: Parâmetro pName não é inválido.');

  if(gDic=nil) then
    gDic := Terasoft.Framework.Collections.TCreateLock.CreateDictionary<TipoWideStringFramework,ILockPerfilCreator>(getComparadorOrdinalTipoWideStringFramework);

  if not gDic.TryGetValue(pTable,lpc) then
  begin
    lpc := Terasoft.Framework.Collections.TCreateLock.CreateDictionary<TipoWideStringFramework,ILockNameCreator>(getComparadorOrdinalTipoWideStringFramework);
    gDic.addOrSetValue(pPerfil,lpc);
  end;

  if not lpc.TryGetValue(pPerfil,lnc) then
  begin
    lnc := Terasoft.Framework.Collections.TCreateLock.CreateDictionary<TipoWideStringFramework,TGenericCreator>(getComparadorOrdinalTipoWideStringFramework);
    lpc.addOrSetValue(pPerfil,lnc);
  end;

  lnc.addOrSetValue(pName, pGenericCreator);
end;

function getGenericController;//(pPerfil: TipoWideStringFramework): IGeneric_Controller;
begin
  Result := TGenericControllerImpl.Create(pPerfil);
end;

{ TGenericControllerImpl }

constructor TGenericControllerImpl.Create(pPerfil: TipoWideStringFramework);
begin
  if(pPerfil='') then
    pPerfil := GENERIC_TEXT_PADRAO;
  fPerfil := pPerfil;
end;

function TGenericControllerImpl.getPerfil: TipoWideStringFramework;
begin
  Result := fPerfil;
end;

procedure registerModel;
begin
  genericRegister(GENERICTABLE_MODEL,pPerfil,pModelName,pModelCreator);
end;

procedure registerDAO;
begin
  genericRegister(GENERICTABLE_DAO,pPerfil,pDAOName,pDAOCreator);
end;

procedure registerView;
begin
  genericRegister(GENERICTABLE_VIEW,pPerfil,pViewName,pViewCreator);
end;

procedure registerController;
begin
  genericRegister(GENERICTABLE_CONTROLLER,pPerfil,pControllerName,pControllerCreator);
end;

function criaLocal(pTable, pPerfil, pNome, pRole: TipoWideStringFramework; pParam1: TipoWideStringFramework; pParam2: TipoWideStringFramework; pResultado: IUnknown): IUnknown;
  var
    p: TGenericCreator;
    lRes: IResultadoOperacao;
begin
  Result := nil;
  lRes := checkResultadoOperacao(pResultado,pResultado);
  try
    Result := TGenericControllerImpl.Create(pPerfil);
  except
    on e: Exception do
      lRes.formataErro('criaLocal: %s: %s', [e.ClassName, e.Message]);
  end;

end;

procedure registra;
begin
  registerController('main','main',criaLocal);

end;


initialization
  registra;

finalization

end.
