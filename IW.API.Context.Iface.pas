unit IW.API.Context.Iface;

interface
  uses
    Classes,
    SysUtils,
    IWApplication,
    IW.HTTP.Request,
    IW.HTTP.Reply,
    Terasoft.Framework.MultiConfig,
    Terasoft.Framework.JSON,
    Terasoft.Framework.Types,
    UsuarioModel,
    Terasoft.Framework.Texto;

  type

    IContextoAPIIW = interface
    //property request getter/setter
      function getRequest: THttpRequest;
      procedure setRequest(const pValue: THttpRequest);

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property retorno getter/setter
      function getRetorno: ITlkJSONObject;
      procedure setRetorno(const pValue: ITlkJSONObject);

    //property reply getter/setter
      function getReply: THttpReply;
      procedure setReply(const pValue: THttpReply);

    //property path getter/setter
      function getPath: TipoWideStringFramework;
      procedure setPath(const pValue: TipoWideStringFramework);

    //property params getter/setter
      function getParams: TStrings;
      procedure setParams(const pValue: TStrings);

    //property session getter/setter
      function getSession: TIWApplication;
      procedure setSession(const pValue: TIWApplication);

      function auth: boolean;

    //property cfg getter/setter
      function getCfg: IMultiConfig;
      procedure setCfg(const pValue: IMultiConfig);

    //property usuarioModel getter/setter
      function getUsuarioModel: ITUsuarioModel;
      procedure setUsuarioModel(const pValue: ITUsuarioModel);

    //property usuarioAPI getter/setter
      function getUsuarioAPI: TipoWideStringFramework;
      procedure setUsuarioAPI(const pValue: TipoWideStringFramework);

      property usuarioAPI: TipoWideStringFramework read getUsuarioAPI write setUsuarioAPI;
      property usuarioModel: ITUsuarioModel read getUsuarioModel write setUsuarioModel;
      property cfg: IMultiConfig read getCfg write setCfg;
      property session: TIWApplication read getSession write setSession;
      property params: TStrings read getParams write setParams;
      property path: TipoWideStringFramework read getPath write setPath;
      property reply: THttpReply read getReply write setReply;
      property retorno: ITlkJSONObject read getRetorno write setRetorno;
      property resultado: IResultadoOperacao read getResultado write setResultado;
      property request: THttpRequest read getRequest write setRequest;
    end;



  function getContextoAPIIW: IContextoAPIIW;

implementation
  uses
    UserSessionUnit,
    IW.API.Engine;

  type
    TContextoAPIIWImpl=class(TInterfacedObject, IContextoAPIIW)
    protected
      fRequest: THttpRequest;
      fResultado: IResultadoOperacao;
      fRetorno: ITlkJSONObject;
      fReply: THttpReply;
      fPath: TipoWideStringFramework;
      fParams: TStrings;
      fSession: TIWApplication;
      fCfg: IMultiConfig;
      fUsuarioModel: ITUsuarioModel;
      fUsuarioAPI: TipoWideStringFramework;

    //property usuarioAPI getter/setter
      function getUsuarioAPI: TipoWideStringFramework;
      procedure setUsuarioAPI(const pValue: TipoWideStringFramework);

    //property cfg getter/setter
      function getCfg: IMultiConfig;
      procedure setCfg(const pValue: IMultiConfig);

    //property usuarioModel getter/setter
      function getUsuarioModel: ITUsuarioModel;
      procedure setUsuarioModel(const pValue: ITUsuarioModel);

      function auth: boolean;

    //property session getter/setter
      function getSession: TIWApplication;
      procedure setSession(const pValue: TIWApplication);

    //property params getter/setter
      function getParams: TStrings;
      procedure setParams(const pValue: TStrings);

    //property path getter/setter
      function getPath: TipoWideStringFramework;
      procedure setPath(const pValue: TipoWideStringFramework);

    //property reply getter/setter
      function getReply: THttpReply;
      procedure setReply(const pValue: THttpReply);

    //property retorno getter/setter
      function getRetorno: ITlkJSONObject;
      procedure setRetorno(const pValue: ITlkJSONObject);

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property request getter/setter
      function getRequest: THttpRequest;
      procedure setRequest(const pValue: THttpRequest);
    end;

function getContextoAPIIW: IContextoAPIIW;
begin
  Result := TContextoAPIIWImpl.Create;
end;

{ TContextoAPIIWImpl }

procedure TContextoAPIIWImpl.setUsuarioAPI(const pValue: TipoWideStringFramework);
begin
  fUsuarioAPI := pValue;
end;

function TContextoAPIIWImpl.getUsuarioAPI: TipoWideStringFramework;
begin
  Result := fUsuarioAPI;
end;

procedure TContextoAPIIWImpl.setUsuarioModel(const pValue: ITUsuarioModel);
begin
  fUsuarioModel := pValue;
end;

function TContextoAPIIWImpl.getUsuarioModel: ITUsuarioModel;
begin
  if(fUsuarioModel=nil) then
    fUsuarioModel := TUsuarioModel.getNewIface(TIWUserSession(fSession.Data).xConexao);
  Result := fUsuarioModel;
end;

procedure TContextoAPIIWImpl.setCfg(const pValue: IMultiConfig);
begin
  fCfg := pValue;
end;

function TContextoAPIIWImpl.getCfg: IMultiConfig;
begin
  if(fCfg=nil) then
  begin
    fCfg := criaMultiConfig;
    fCfg.adicionaInterface(criaConfigCmdLine);
    fCfg.adicionaInterface(criaConfigEnvVar);
    fCfg.adicionaInterface(criaConfigRegistry);
  end;
  Result := fCfg;
end;

procedure TContextoAPIIWImpl.setSession(const pValue: TIWApplication);
begin
  fSession := pValue;
end;

function TContextoAPIIWImpl.getSession: TIWApplication;
begin
  Result := fSession;
end;

procedure TContextoAPIIWImpl.setParams(const pValue: TStrings);
begin
  fParams := pValue;
end;

function TContextoAPIIWImpl.auth: boolean;
  var
    proc: TProcessoIWAPI;
    save: Integer;
begin
  Result := false;
  proc := retornaProcessoAuthAPIIW(IWAPISERVER_PROCESSOPADRAO);
  save := getResultado.erros;
  if assigned(proc)=false then
    fResultado.adicionaErro('Não existe processo de autenticação registrado');

  if fResultado.erros<>save then
    exit;
  proc(self);
  Result := fResultado.erros=save;
end;

function TContextoAPIIWImpl.getParams: TStrings;
begin
  Result := fParams;
end;

procedure TContextoAPIIWImpl.setPath(const pValue: TipoWideStringFramework);
begin
  fPath := pValue;
end;

function TContextoAPIIWImpl.getPath: TipoWideStringFramework;
begin
  Result := fPath;
end;

procedure TContextoAPIIWImpl.setReply(const pValue: THttpReply);
begin
  fReply := pValue;
end;

function TContextoAPIIWImpl.getReply: THttpReply;
begin
  Result := fReply;
end;

procedure TContextoAPIIWImpl.setRetorno(const pValue: ITlkJSONObject);
begin
  fRetorno := pValue;
end;

function TContextoAPIIWImpl.getRetorno: ITlkJSONObject;
begin
  if(fRetorno=nil) then
    fRetorno := TlkJSON.cria;
  Result := fRetorno;
end;

procedure TContextoAPIIWImpl.setResultado(const pValue: IResultadoOperacao);
begin
  fResultado := pValue;
end;

function TContextoAPIIWImpl.getResultado: IResultadoOperacao;
begin
  Result := checkResultadoOperacao(fResultado);
end;

procedure TContextoAPIIWImpl.setRequest(const pValue: THttpRequest);
begin
  fRequest := pValue;
end;

function TContextoAPIIWImpl.getRequest: THttpRequest;
begin
  Result := fRequest;
end;


end.
