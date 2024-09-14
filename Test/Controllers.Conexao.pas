{$i definicoes.inc}

unit Controllers.Conexao;

interface
  uses
    FireDAC.Comp.Client,
    Terasoft.FuncoesTexto,
    Terasoft.Types,
    Terasoft.Framework.DB,
    FuncoesDB,
    Terasoft.Framework.Types,
    Terasoft.Framework.Texto,
    Terasoft.Framework.EventosUso,
    Interfaces.Conexao;

  type
    TControllersConexao = class(TInterfacedObject, IInterface, IConexao)

      private
        FConexao         : TFDConnection;
        FConexaoExterna  : TFDConnection;

        vLoja            : String;
        vUser            : TUsuario;
        vEmpresa         : TEmpresa;
        vConfiguracoesNF : TConfiguracoesNF;
        vTerasoftConfiguracao : IUnknown;

        function criarQuery                                                : TFDQuery;
        function criaIfaceQuery                                            : IFDQuery;
        function criaIfaceQueryExterna                                     : IFDQuery;

        function connection                                                : IConexao; overload;
        function connection(pLoja: String; pHost : String = '')            : IConexao; overload;

        function NovaConexao(pLoja: String; pHost : String = '')           : IConexao;
        function criarQueryExterna                                         : TFDQuery;
        function ConfigConexaoExterna(pLoja: String; _pHost : String = '')  : Boolean;
        function Generetor(pValue: String; pCtrGen : Boolean = false)      : String;
        function getConnection                                             : TFDConnection;
        function getLojaConectada                                          : String;
        function DataServer                                                : TDate;
        function HoraServer                                                : TTime;
        function DataHoraServer                                            : TDateTime;

        function getUSer                                                   : TUsuario;
        function setUser(pUser : TUsuario)                                 : Boolean;

        function setEmpresa(pEmpresa: TEmpresa)                            : Boolean;
        function getEmpresa                                                : TEmpresa;

        function setConfiguracoesNF(pConfiguracoes : TConfiguracoesNF)     : Boolean;
        function getConfiguracoes                                          : TConfiguracoesNF;

        procedure setTerasoftConfiguracoes(const pConfiguracoes : IUnknown);
        function getTerasoftConfiguracoes                                  : IUnknown;

        procedure setContextModoSistema(pSistema: String);
        procedure setContext(pUsuario: String);
      protected
        fGDB: IGDB;
        fGDBExterno: IGDB;
        fUltimoAcessoDB: TDateTime;
        fEventosUsoSessao: IEventosUsoSessao;

      //property estatistica getter/setter
        function getEventosUsoSessao: IUnknown;
        procedure setEventosUsoSessao(const pValue: IUnknown);

        procedure registraEvento(const pEvento: TipoWideStringFramework; pObjeto: TipoWideStringFramework=''; pDescricao: TipoWideStringFramework = '');

      //property ultimoAcessoDB getter/setter
        function getUltimoAcessoDB: TDateTime;
        procedure setUltimoAcessoDB(const pValue: TDateTime);

      //property gdbExterno getter/setter
        function getGDBExterno: IGDB;

        function getGDB: IGDB;
        function getValidador: IValidadorDatabase;

        function _AddRef: Integer; stdcall;
        function _Release: Integer; stdcall;

      public
        Constructor Create;
        Destructor Destroy; override;
        Class function New: IConexao;


    end;

implementation

uses
  uTeste,
  Terasoft.Framework.DB.DAO,
  Terasoft.Framework.ObjectIface,
  System.SysUtils,
  LojasModel, GeneratorNewDao, System.IniFiles, Vcl.Forms;

{ TControllersConexao }

function TControllersConexao.ConfigConexaoExterna(pLoja: String; _pHost : String = ''): Boolean;
var
  lLojaModel : ITLojasModel;
begin
  lLojaModel := TLojasModel.getNewIface(self);
  try
    lLojaModel.objeto.LojaView := pLoja;
    lLojaModel.objeto.obterLista;

    lLojaModel := lLojaModel.objeto.LojassLista.First;

    vLoja  := pLoja;
    fGDBExterno := nil;

    if(FConexaoExterna=nil) then
      FConexaoExterna := TFDConnection.Create(nil);
    FConexaoExterna.Params.Clear;
    FConexaoExterna.Params.Add('Server='+lLojaModel.objeto.SERVER);
    FConexaoExterna.Params.Add('user_name='+ 'SYSDBA');
    FConexaoExterna.Params.Add('password='+ 'masterkey');
    FConexaoExterna.Params.Add('port='+lLojaModel.objeto.PORT);
    FConexaoExterna.Params.Add('Database='+ lLojaModel.objeto.DATABASE);
    FConexaoExterna.Params.Add('DriverID='+ 'FB');
    FConexaoExterna.Params.Add('Protocol='+ 'TCPIP');
    FConexaoExterna.Params.Add('LoginPrompt='+ 'False');
    {$if defined(__USE_WIN1252__)}
      FConexaoExterna.Params.Values['CharacterSet'] := GDBFIB_CHARSETPTBR;
    {$endif}

    Result := true;
  finally
  end;
end;

function TControllersConexao.connection(pLoja, pHost: String): IConexao;
var
  lLojaModel : ITLojasModel;
  lHost      : THost;
begin
  lLojaModel := TLojasModel.getNewIface(Form1.vIConexao);
  fGDB := nil;

  try
    if pHost <> '' then
      lHost := Terasoft.FuncoesTexto.WriteConexao(pHost)
    else
    begin
      lLojaModel.objeto.LojaView := pLoja;
      lLojaModel.objeto.obterLista;

      lLojaModel := lLojaModel.objeto.LojassLista.First;

      lHost.Server   := lLojaModel.objeto.SERVER;
      lHost.Port     := lLojaModel.objeto.PORT;
      lHost.DataBase := lLojaModel.objeto.DATABASE;
    end;

    FConexao.Params.clear;
    FConexao.Params.Add('Pooling=True');
    FConexao.Params.Add('MaxPoolSize=20');
    FConexao.Params.Add('Server='+lHost.Server);
    FConexao.Params.Add('user_name='+ 'SYSDBA');
    FConexao.Params.Add('password='+ 'masterkey');
    FConexao.Params.Add('port='+lHost.Port);
    FConexao.Params.Add('Database='+ lHost.DataBase);
    FConexao.Params.Add('DriverID='+ 'FB');
    FConexao.Params.Add('Protocol='+ 'TCPIP');
    FConexao.Params.Add('LoginPrompt='+ 'False');
    {$if defined(__USE_WIN1252__)}
      FConexao.Params.Values['CharacterSet'] := GDBFIB_CHARSETPTBR;
    {$endif}

    FConexao.Connected := False;
    FConexao.Connected := True;

    Result := Self;
  finally
  end;
end;

function TControllersConexao.connection: IConexao;
Var
  IniFile : String;
  Ini     : TIniFile;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;
  Ini     := TIniFile.Create( IniFile );

  try
    FConexao.Params.Add('Pooling=True');
    FConexao.Params.Add('MaxPoolSize=20');
    FConexao.Params.Add('Server='+ ( Ini.ReadString( 'Configuracao','Servidor' ,'' ) ) );
    FConexao.Params.Add('user_name='+ (  Ini.ReadString( 'Acesso','Login','' ) ));
    FConexao.Params.Add('password='+ ( Ini.ReadString( 'Acesso','Senha','' ) ));
    FConexao.Params.Add('port='+ ( Ini.ReadString( 'Configuracao','Porta' ,'' ) ));
    FConexao.Params.Add('Database='+ ( Ini.ReadString( 'Configuracao','DataBaseName','' ) ));
    FConexao.Params.Add('DriverID='+ 'FB');
    FConexao.Params.Add('Protocol='+ 'TCPIP');
    FConexao.Params.Add('LoginPrompt='+ 'False');
    {$if defined(__USE_WIN1252__)}
      FConexao.Params.Values['CharacterSet'] := GDBFIB_CHARSETPTBR;
    {$endif}

    FConexao.Connected := false;
    FConexao.Connected := true;

    Result:= Self;
  finally
    Ini.Free;
  end;
end;

constructor TControllersConexao.Create;
begin
  {$if defined(__USE_WIN1252__)}
    ativaWINPTBR;
  {$endif}
  FConexao := TFDConnection.Create(nil);
end;

function TControllersConexao.criaIfaceQuery: IFDQuery;
begin
  Result:=TImplObjetoOwner<TFDQuery>.CreateOwner(TFDQuery.Create(nil));
  Result.objeto.Connection := FConexao;
end;

function TControllersConexao.criaIfaceQueryExterna: IFDQuery;
begin
  Result:=TImplObjetoOwner<TFDQuery>.CreateOwner(TFDQuery.Create(nil));
  Result.objeto.Connection := FConexaoExterna;
end;

function TControllersConexao.criarQuery: TFDQuery;
var
  VQuery: TFDQuery;
begin
   try
     VQuery := TFDQuery.Create(FConexao);
     VQuery.Connection := FConexao;

     Result := VQuery;
   finally

   end;
end;

function TControllersConexao.criarQueryExterna: TFDQuery;
var
 VQuery: TFDQuery;
begin
  try
    VQuery             := TFDQuery.Create(FConexaoExterna);
    VQuery.Connection  := FConexaoExterna;
    Result             := VQuery;
  finally
  end;
end;

function TControllersConexao.DataHoraServer: TDateTime;
begin
  Result := self.FConexao.ExecSQLScalar('select current_timestamp from rdb$database');
end;

function TControllersConexao.DataServer: TDate;
begin
  Result := self.FConexao.ExecSQLScalar('select current_date from rdb$database');
end;

destructor TControllersConexao.Destroy;
begin
  if assigned(fEventosUsoSessao) then
    fEventosUsoSessao.conexao := nil;
  fGDB := nil;
  fGDBExterno := nil;
  FreeAndNil(FConexaoExterna);
  FreeAndNil(FConexao);
  inherited;
end;

function TControllersConexao.Generetor(pValue: String; pCtrGen : Boolean = false): String;
var
  lQry  : TFDQuery;
  lSQL  : String;
begin
  lQry := Self.CriarQuery;
  try
    lQry.open('select gen_id('+pValue+',1) from rdb$Database');
    Result := FormatFloat('000000',(lQry.Fields[0].AsInteger));
  finally
    lQry.Free;
  end;
end;

function TControllersConexao.getConfiguracoes: TConfiguracoesNF;
begin
  Result := vConfiguracoesNF;
end;

function TControllersConexao.getConnection: TFDConnection;
begin
  Result := self.FConexao;
end;

function TControllersConexao.getEmpresa: TEmpresa;
begin
  Result := vEmpresa;
end;

function TControllersConexao.getGDBExterno: IGDB;
begin
  if(fGDBExterno=nil) then
  begin
    fGDBExterno := criaGDB(GDBDRIVER_FIREDAC,GDBPARAM_USEPOINTER,Integer(FConexaoExterna));
    executeAfterConnectDatabase(fGDBExterno);
  end;
  Result := fGDBExterno;
end;

function TControllersConexao.getGDB: IGDB;
begin
  if(fGDB=nil) then
  begin
    fGDB := criaGDB(GDBDRIVER_FIREDAC,GDBPARAM_USEPOINTER,Integer(FConexao));
    executeAfterConnectDatabase(fGDB);
  end;
  Result := fGDB;
end;

function TControllersConexao.getLojaConectada: String;
begin
  Result := vLoja;
end;

function TControllersConexao.getTerasoftConfiguracoes: IUnknown;
begin
  Result := vTerasoftConfiguracao;
end;

function TControllersConexao.getUSer: TUsuario;
begin
  Result := vUser;
end;

function TControllersConexao.getValidador: IValidadorDatabase;
begin
  Supports(getGDB.validador, IValidadorDatabase, Result);
end;

function TControllersConexao.HoraServer: TTime;
begin
  Result := self.FConexao.ExecSQLScalar('select current_time from rdb$database');
end;

class function TControllersConexao.New: IConexao;
begin
  Result := Self.Create;
end;

function TControllersConexao.NovaConexao(pLoja, pHost: String): IConexao;
var
  lConexao : IConexao;
begin
  try
    lConexao := self.New;
    lConexao.connection(pLoja, pHost);
    Result := lConexao;
  except
    Result := nil;
  end;
end;

function TControllersConexao.setConfiguracoesNF(pConfiguracoes: TConfiguracoesNF): Boolean;
begin
  vConfiguracoesNF := pConfiguracoes;
  Result := true;
end;

procedure TControllersConexao.setContext(pUsuario: String);
begin

end;

procedure TControllersConexao.setContextModoSistema(pSistema: String);
begin

end;

function TControllersConexao.setEmpresa(pEmpresa: TEmpresa): Boolean;
begin
  vEmpresa := pEmpresa;
end;

procedure TControllersConexao.setTerasoftConfiguracoes(const pConfiguracoes: IUnknown);
begin
  vTerasoftConfiguracao := pConfiguracoes;
end;

function TControllersConexao.setUser(pUser: TUsuario): Boolean;
begin
  vUser := pUser;
end;

function TControllersConexao._AddRef: Integer;
begin
  setUltimoAcessoDB(Now);
  inherited;
end;

function TControllersConexao._Release: Integer;
begin
  setUltimoAcessoDB(Now);
  inherited;
end;

procedure TControllersConexao.setUltimoAcessoDB(const pValue: TDateTime);
begin
  fUltimoAcessoDB := pValue;
end;

function TControllersConexao.getUltimoAcessoDB: TDateTime;
begin
  Result := fUltimoAcessoDB;
end;

procedure TControllersConexao.setEventosUsoSessao(const pValue: IUnknown);
begin
  Supports(pValue,IEventosUsoSessao,fEventosUsoSessao);
end;

function TControllersConexao.getEventosUsoSessao: IUnknown;
begin
  Result := fEventosUsoSessao;
end;

procedure TControllersConexao.registraEvento;
begin
  if assigned(fEventosUsoSessao) then
    fEventosUsoSessao.registraEvento(Now,pEvento,getStringListFromItens([pDescricao,pObjeto]));
end;

end.
