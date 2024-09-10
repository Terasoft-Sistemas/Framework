unit Terasot.Framework.IW.Health;

{
    https://atozed.com/forums//thread-3163-post-10773.html
}

interface

uses
  Classes, SysUtils,IW.Content.Base, HTTPApp, IWApplication, IW.HTTP.Request,
  IW.HTTP.Reply;

type
  TContentHealth = class(TContentBase)
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean; override;
  public
    constructor Create; override;
  end;

implementation

uses
  __versaoautomaticaTerasoft_Gestao_Web,
  ServerController,
  UserSessionUnit,
  IW.Content.Handlers,
  IWMimeTypes;

constructor TContentHealth.Create;
begin
  inherited;
  mFileMustExist := False;
end;

function TContentHealth.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
  var
    p: TIWUserSession;
    ext: String;
begin
  Result := True;
  if Assigned(aReply) then
  begin
    ext := aRequest.GetQueryFieldValue('tipo');
    if(ext='') then
      ext := 'json';
    if(ext='json') then
      aReply.ContentType := MIME_JSON
    else
      aReply.ContentType := MIME_TXT;
    TIWUserSession(aSession.Data).xOmitirDump:=true;
    dumpToFile;
    aReply.WriteString(dumpToString(ext));
  end;
  aSession.Terminate;
end;

end.
