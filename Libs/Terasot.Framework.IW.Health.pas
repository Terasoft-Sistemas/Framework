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
begin
  Result := True;
  if Assigned(aReply) then
  begin
    aReply.ContentType := MIME_TXT;
    aReply.WriteString(format('ALLOK=%s',[DateTimeToStr(gUltimoTick)]));
    gUltimoTick := Now;
  end;
  aSession.Terminate;
end;

end.
