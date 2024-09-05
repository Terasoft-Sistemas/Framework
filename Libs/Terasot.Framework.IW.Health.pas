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
    lStream: TStringStream;
begin
  Result := True;
  if Assigned(aReply) then
  begin
    aReply.ContentType := MIME_TXT;
    if(CompareText(aRequest.PathInfo,'/health-dump')=0) then
    begin
      lStream := TStringStream.Create;
      try
        dumpToStream(lStream);
        //lStream.Position := 0;
        aReply.WriteString(lStream.DataString);
      finally
        FreeAndNil(lStream);
      end;
    end else
    begin
      aReply.WriteString(format('TICKS=%d'+#10,[AtomicIncrement(gTicks)]));
      aReply.WriteString(format('BUILD=%s'+#10,[RC_BUILD_Terasoft_Gestao_Web_DATETIME]));
      aReply.WriteString(format('VERSAO=%s'+#10,[VERSAORC_Terasoft_Gestao_Web]));
      aReply.WriteString(format('SESSOES=%d'+#10,[gListaSessoes.count]));
    end;
  end;
  aSession.Terminate;
end;

end.
