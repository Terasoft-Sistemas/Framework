
{$i definicoes.inc}

unit Terasoft.Framework.WebBrowser.iface;

interface
  uses
    Terasoft.Framework.Types, Classes, Windows //,WebView2.Iface
      {$if not defined(__ISDLL__)}
        , Terasoft.Framework.Log
      {$ifend}
    ;

  {$if defined(__ISDLL__)}

    {$i defsLOG.inc}

  {$ifend}

  type

    TOnExecuteScriptCallEvent = reference to procedure (pIface: IUnknown; pText: TipoWideStringFramework);

    TNotifyWV = reference to function (uri: TipoWideStringFramework; usuarioIniciou: boolean): boolean;
    TNotifyWVGeneric = reference to function (iface: IUnknown; uri: TipoWideStringFramework): boolean;

    //INotifyWV = interface
    //['{00AF8B4F-3E23-4705-B019-7A597B02FD0A}']
    //  function procedure doNavegacaoEB(parametros:IUnknown);
    //end;

    {$if defined(__ISDLL__)}
      ILog=IUnkNown;
      ILogSimples = interface
        ['{72816E78-E94E-4E2B-9201-F54BA310CC50}']
        function log(const texto: TipoWideStringFramework; const severidade: TLogSeveridade{ = ls_Normal}; level: Integer{ = LOGLEVEL_PADRAO} ): IUnknown; stdcall;
      end;
    {$ifend}

    IWebBrowserIface_00 = interface
    ['{18E305C2-BBA2-48C6-B7AD-CC72D16A203F}']
      function show: integer;
      function showModal: integer;
      procedure __open(const url: TipoWideStringFramework);
      procedure setParent(const value: HWND);
      procedure restoreParent;
      procedure posiciona(x: Integer = -1; y: Integer = -1; width: Integer = -1; height: Integer = -1);
      procedure setLogger(value: ILogSimples);
      procedure ___open(const url: TipoWideStringFramework; logger: ILogSimples=nil); overload;
      procedure open(const url: TipoWideStringFramework; logger: ILogSimples=nil; dataFolder: TipoWideStringFramework=''); overload;
      procedure setNotifyWV(const value: TNotifyWV);
      function getNotifyWV: TNotifyWV;
      property ebNavigationStarting: TNotifyWV read getNotifyWV write setNotifyWV;
    end;
    IWebBrowserIface_01 = interface(IWebBrowserIface_00)
    ['{0EC567D3-8CBD-4B39-A381-9C62E48D03FC}']
      function getText: TipoWideStringFramework;
      procedure setText(const value: TipoWideStringFramework);
      procedure createWebView(logger: ILogSimples; dataFolder: TipoWideStringFramework);
      procedure showControl;
      procedure colocaElemento(nome,valor: TipoWideStringFramework);
      function getElemento(nome: TipoWideStringFramework): TipoWideStringFramework;

      property text: TipoWideStringFramework read getText write setText;
    end;

    IWebBrowserIface_02 = interface(IWebBrowserIface_01)
    ['{E5BF434E-FF78-4FA9-862A-648D459DC198}']
      procedure setNotifyWVEndNavigate(const value: TNotifyWVGeneric);
      function getNotifyWVEndNavigate: TNotifyWVGeneric;
      procedure getHTML(pCallbak: TOnExecuteScriptCallEvent);
      property ebNavigationFinished: TNotifyWVGeneric read getNotifyWVEndNavigate write setNotifyWVEndNavigate;
    end;

    IWebBrowserIface = interface(IWebBrowserIface_02)
    ['{3F7D0962-6EE3-4D66-AC99-8283582BD722}']
      procedure executeJavaScript(pScript: TipoWideStringFramework);
    end;


    TGetWBI = function: IWebBrowserIface; stdcall;

  var
    doGetWBI: TGetWBI = nil;



{$if not defined(__ISDLL__)}
  function loadDll: HModule;
  procedure FinalizaDLL;
  function criaWBI: IWebBrowserIface; stdcall;
{$ifend}





implementation




{$if not defined(__ISDLL__)}

  var
    DLLHandle: HModule = 0;

function loadDll: HModule;
  var
    fName: String;
begin
  Result := DLLHandle;
  if(DLLHandle<>0) then
    exit;
  fName := 'WebBrowserD11.dll';
  DLLHandle := LoadLibraryEx (pChar(String(fName)), 0, LOAD_WITH_ALTERED_SEARCH_PATH);
  Result := DLLHandle;
end;

function criaWBI: IWebBrowserIface; stdcall;
begin
  Result := nil;
  loadDLl;
  if(DLLHandle<>0) then begin
    if not assigned(doGetWBI) then
      @doGetWBI := GetProcAddress(DLLHandle, 'criaWBI');
    if (  @doGetWBI <> nil ) then
      Result := doGetWBI;
  end;
end;

procedure FinalizaDLL;
begin
  if ( DLLHandle <> 0 ) then
    try
      FreeLibrary(DLLHandle);
    except
    end;
    DLLHandle := 0;
end;



{$ifend}


end.
