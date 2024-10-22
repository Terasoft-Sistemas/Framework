unit IW.API.Engine;

interface
  uses
    Sysutils,Classes,
    IW.API.Context.Iface,
    Terasoft.Framework.Types,
    System.SyncObjs,
    Spring.Collections,
    Terasoft.Framework.Texto;

  const
    IWAPISERVER_PROCESSOPADRAO    = 'PADRAO';

  type
    TProcessoIWAPI = reference to procedure(pCtx: IContextoAPIIW);


  procedure registraProcessoComandoAPIIW(comando: String; caminho: String; const processo: TProcessoIWAPI);
  procedure removeProcessoComandoAPIIW(const comando: String; caminho: String);
  function retornaProcessoAPIIW(const comando: string; caminho: String; pRetornaPadrao: boolean = true): TProcessoIWAPI;
  function retornaProcessoAuthAPIIW(caminho: String; pRetornaPadrao: boolean = true): TProcessoIWAPI;

  procedure registraProcessoPatchAPIIW(const caminho: String; const processo: TProcessoIWAPI);
  procedure registraProcessoGetAPIIW(const caminho: String; const processo: TProcessoIWAPI);
  procedure registraProcessoPostAPIIW(const caminho: String; const processo: TProcessoIWAPI);
  procedure registraAuthAPIIW(const caminho: String; const processo: TProcessoIWAPI);

  procedure removeProcessoPatchAPIIW(const caminho: String);
  procedure removeProcessoGetAPIIW(const caminho: String);
  procedure removeProcessoPostAPIIW(const caminho: String);
  procedure removeAuthAPIIW(const caminho: String);


implementation

  var
    cs: TCriticalSection;


  type
    TDicionario = IDictionary<TipoWideStringFramework,TProcessoIWAPI>;

  var
    listaProcessos: IDictionary<TipoWideStringFramework,TDicionario>;


procedure registraProcessoComandoAPIIW(comando: String; caminho: String; const processo: TProcessoIWAPI);
  var
    lista: TDicionario;
begin
  lista := nil;
  caminho := uppercase(caminho);
  if(caminho<>IWAPISERVER_PROCESSOPADRAO) then
    caminho := IncludeTrailingDocDelimiter(caminho);
  comando := trim(uppercase(comando));
  if not assigned(processo) then exit;
  cs.Acquire;
  try
    if(listaProcessos=nil) then begin
      listaProcessos := TCollections.CreateDictionary<TipoWideStringFramework,TDicionario>(getComparadorOrdinalTipoWideStringFramework);
    end;
    if not listaProcessos.TryGetValue(comando, lista) then begin
      lista := TCollections.CreateDictionary<TipoWideStringFramework,TProcessoIWAPI>(getComparadorOrdinalTipoWideStringFramework);
      listaProcessos.Add(comando,lista);
    end;
    lista.AddOrSetValue(caminho,processo);
  finally
    cs.Release;
  end;
end;

procedure removeProcessoComandoAPIIW(const comando: String; caminho: String);
  var
    lista: TDicionario;
begin
  if(listaProcessos=nil) then
      exit;
  caminho := IncludeTrailingDocDelimiter(trim(uppercase(caminho)));
  cs.Acquire;
  try
    if not listaProcessos.TryGetValue(uppercase(trim(comando)), lista) then
      exit;
    lista.Remove(caminho);
  finally
    cs.Release;
  end;
end;

function retornaProcessoAuthAPIIW;
begin
  Result := retornaProcessoAPIIW('auth',caminho,pRetornaPadrao);
end;

function retornaProcessoAPIIW;
  var
    lista: TDicionario;
begin
  Result := nil;
  if(listaProcessos=nil) then
    exit;
  caminho := IncludeTrailingDocDelimiter(trim(uppercase(caminho)));
  cs.Acquire;
  try
    if listaProcessos.TryGetValue(uppercase(trim(comando)), lista) then begin
      lista.TryGetValue(caminho,Result);
      if (not Assigned(Result)) and pRetornaPadrao then
        lista.TryGetValue(IWAPISERVER_PROCESSOPADRAO,Result);
    end;
  finally
    cs.Release;
  end;
end;

procedure registraProcessoPatchAPIIW;
begin
  registraProcessoComandoAPIIW('patch', caminho, processo);
end;

procedure removeProcessoPatchAPIIW(const caminho: String);
begin
  removeProcessoComandoAPIIW('patch', caminho);
end;

procedure registraProcessoGetAPIIW;
begin
  registraProcessoComandoAPIIW('get', caminho, processo);
end;

procedure removeProcessoGetAPIIW(const caminho: String);
begin
  removeProcessoComandoAPIIW('get', caminho);
end;

procedure registraProcessoPostAPIIW;
begin
  registraProcessoComandoAPIIW('post', caminho, processo);
end;

procedure removeProcessoPostAPIIW(const caminho: String);
begin
  removeProcessoComandoAPIIW('post', caminho);
end;

procedure registraAuthAPIIW;
begin
  registraProcessoComandoAPIIW('auth', caminho, processo);
end;

procedure removeAuthAPIIW(const caminho: String);
begin
  removeProcessoComandoAPIIW('auth', caminho);
end;

initialization
  cs:=TCriticalSection.Create;

finalization
  freeAndNil(cs);

end.
