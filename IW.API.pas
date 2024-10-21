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
    Login;

constructor TRunAPI.Create;
begin
  inherited;
  mFileMustExist := False;
end;

procedure test;
var
  LSessionList: TStringList;
  i: Integer;
  s: String;
begin
  // First, create a session list to hold the session IDs
  LSessionList := TStringList.Create;
  try
    // Retrieve the session list using GetList() method from TIWSessions class
    gSessions.GetList(LSessionList);

    // The session list contains a session of SessionIDs, not the actual session object.
    // You can obtain the session corresponding to a specific session Id, calling the TIWSessions.Execute() method
    // Execute() is a method that receives a SessionId as the first paramter, and an anonymous method as the second parameter
    // The anonymous method, when executed, will pass the aSession as the parameter. See below:
    for i := 0 to LSessionList.Count - 1 do begin
      gSessions.Execute(LSessionList[i],
        procedure(aSession: TObject)
        var
          LSession: TIWApplication absolute aSession;
        begin
          s := 'Session ID: ' + LSession.AppId + ' - Last access time: ' + DateTimeToStr(LSession.LastAccess);
        end
      );
    end;
  finally
    LSessionList.Free;
  end;
end;

function TRunAPI.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
  var
    p: TIWUserSession;
    ext: String;
    login: TfLogin;
    lPathOriginal: String;
    lDoc: String;
begin
  Result := True;
  if Assigned(aReply) then
  begin
    lPathOriginal := aRequest.PathInfo;
    lDoc := StringReplace(lPathOriginal,IWAPIPATH,'/',[rfIgnoreCase]);
    //test;
    //login :=  TIWUserSession(aSession.Data).AcaoMenu('TfLogin', False) as TfLogin;
    //login.testarDashboard;

    aReply.WriteString('Done');
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
