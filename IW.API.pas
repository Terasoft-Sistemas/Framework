unit IW.API;

interface
  uses
    IW.Content.Handlers,
    UserSessionUnit,
    Classes, SysUtils,IW.Content.Base, HTTPApp, IWApplication, IW.HTTP.Request,
    IW.HTTP.Reply;

  const
    IWAPIPATH = '/API/';

  type
    TRunAPI = class(TContentBase)
    protected
      function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean; override;
    public
      constructor Create; override;
    end;



implementation

{ TRunTests }

  uses
    IW.API.Context.Iface,
    Terasoft.Framework.Texto,
    Terasoft.Framework.JSON,
    IW.API.Engine,
    Login;

constructor TRunAPI.Create;
begin
  inherited;
  mFileMustExist := False;
end;

function getHTTPMethodStr(const pMetodo: THttpMethod): String;
begin
  case pMetodo of
    hmGet: Result := 'get';
    hmPost: Result := 'post';
    hmPut: Result := 'put';
    hmHead: Result := 'head';
    hmDelete: Result := 'delete';
    hmOptions: Result := 'options';
    else //{hmNone:
      Result := 'none';
  end;
end;

function TRunAPI.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
  var
    ctx: IContextoAPIIW;
    //p: TIWUserSession;
    //ext: String;
    //login: TfLogin;
    lPathOriginal: String;
    lDoc: String;
    proc: TProcessoIWAPI;
begin
  Result := True;
  if Assigned(aReply) then
  try
    ctx := getContextoAPIIW;
    ctx.request := aRequest;
    ctx.reply := aReply;
    ctx.params := aParams;
    ctx.session := aSession;

    lPathOriginal := aRequest.PathInfo;
    lDoc := StringReplace(lPathOriginal,IWAPIPATH,'/',[rfIgnoreCase]);
    ctx.path := lDoc;

    aReply.ContentType := 'text/json';
    //aReply.CharSet := 'UTF-8';
    aReply.Headers.Add('Access-Control-Allow-Origin: *');

    if not ctx.auth then
      exit;

    proc := retornaProcessoAPIIW(getHTTPMethodStr(aRequest.HttpMethod),lDoc);
    if assigned(proc)=false then
    begin
      ctx.resultado.formataErro('Comando [%s] para o caminho [%s] não existe.', [ getHTTPMethodStr(aRequest.HttpMethod),lDoc ] );
    end;
    if(ctx.resultado.erros=0) then
      proc(ctx);


    //test;
    //login :=  TIWUserSession(aSession.Data).AcaoMenu('TfLogin', False) as TfLogin;
    //login.testarDashboard;

    //aReply.WriteString('Done');
  finally
    if(ctx.resultado.erros>0) then
    begin
      ctx.retorno.json.Add('sucesso',false);
      ctx.retorno.json.Add('erro', 1);
      //retorno.json.Add('fase',  res.propriedade[HTTDPMINISERVER_PROCESSOFASE].asInteger );
      ctx.retorno.json.Add('mensagem',ctx.resultado.toString([oros_SemResumos]));
    end;
    aReply.WriteString(GenerateText(ctx.retorno.json));
  end;

end;

initialization

end.

{

Estrutura:
https://terasoft.ip.inf.br:12067/API/consulta?ep=expedicao&data_inicio=30/04/2024&data_fim=30/04/2024"
RAIZ=https://terasoft.ip.inf.br:12067/API/
doc=consulta
query=demais campos

}
