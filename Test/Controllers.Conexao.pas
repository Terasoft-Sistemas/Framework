unit Controllers.Conexao;

interface
  uses
    FireDAC.Comp.Client,
    Terasoft.FuncoesTexto,
    Interfaces.Conexao;

  type
    TControllersConexao = class(TInterfacedObject, IConexao)

      private
        FConexao         : TFDConnection;
        FConexaoExterna  : TFDConnection;

        vLoja            : String;
        vUser            : TUsuario;
        vEmpresa         : TEmpresa;
        vConfiguracoesNF : TConfiguracoesNF;
        vTerasoftConfiguracao : TObject;

        function criarQuery                                                : TFDQuery;
        function criaConexao                                               : IConexao;
        function ConfigConexao                                             : Boolean;
        function NovaConexao(pLoja: String; pHost : String = '')          : IConexao;
        function criarQueryExterna                                         : TFDQuery;
        function ConfigConexaoExterna(pLoja: String; pHost : String = '')  : Boolean;
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

        function setTerasoftConfiguracoes(pConfiguracoes : TObject)        : IConexao;
        function getTerasoftConfiguracoes                                  : TObject;

        procedure setContextModoSistema(pSistema: String);
        procedure setContext(pUsuario: String);
      public
        Constructor Create;
        Destructor Destroy; override;
        Class function New: IConexao;


    end;

implementation

uses
  uTeste,
  System.SysUtils,
  LojasModel, Terasoft.Types, GeneratorNewDao, System.IniFiles, Vcl.Forms;

{ TControllersConexao }

function TControllersConexao.ConfigConexao: Boolean;
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
  finally
     Ini.Free;
     Result:= True;
  end;
end;

function TControllersConexao.ConfigConexaoExterna(pLoja: String; pHost : String = ''): Boolean;
var
  lLojaModel : TLojasModel;
begin
  lLojaModel := TLojasModel.Create(self);
  try
    lLojaModel.LojaView := pLoja;
    lLojaModel.obterLista;

    lLojaModel := lLojaModel.LojassLista[0];

    vLoja  := pLoja;

    FConexaoExterna := TFDConnection.Create(nil);
    FConexaoExterna.Params.Add('Server='+lLojaModel.SERVER);
    FConexaoExterna.Params.Add('user_name='+ 'SYSDBA');
    FConexaoExterna.Params.Add('password='+ 'masterkey');
    FConexaoExterna.Params.Add('port='+lLojaModel.PORT);
    FConexaoExterna.Params.Add('Database='+ lLojaModel.DATABASE);
    FConexaoExterna.Params.Add('DriverID='+ 'FB');
    FConexaoExterna.Params.Add('Protocol='+ 'TCPIP');
    FConexaoExterna.Params.Add('LoginPrompt='+ 'False');

    Result := true;
  finally
    lLojaModel.Free;
  end;
end;

constructor TControllersConexao.Create;
begin
  FConexao := TFDConnection.Create(nil);
  ConfigConexao;
end;

function TControllersConexao.criaConexao: IConexao;
begin

end;

function TControllersConexao.criarQuery: TFDQuery;
var
  VQuery: TFDQuery;
begin
   try
     VQuery := TFDQuery.Create(nil);
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
    VQuery             := TFDQuery.Create(nil);
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

function TControllersConexao.getLojaConectada: String;
begin
  Result := vLoja;
end;

function TControllersConexao.getTerasoftConfiguracoes: TObject;
begin
  Result := vTerasoftConfiguracao;
end;

function TControllersConexao.getUSer: TUsuario;
begin
  Result := vUser;
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
  lLojaModel  : TLojasModel;
  lHost       : THost;
  lConexao    : IConexao;
begin
  lConexao   := self.New;
  lLojaModel := TLojasModel.Create(self);

  try
    if pHost <> '' then
      lHost := Terasoft.FuncoesTexto.WriteConexao(pHost)
    else
    begin
      lLojaModel.LojaView := pLoja;
      lLojaModel.obterLista;

      lLojaModel := lLojaModel.LojassLista[0];

      lHost.Server   := lLojaModel.SERVER;
      lHost.Port     := lLojaModel.PORT;
      lHost.DataBase := lLojaModel.DATABASE;
    end;

    lConexao.getConnection.Params.Clear;
    lConexao.getConnection.Params.Add('Pooling=True');
    lConexao.getConnection.Params.Add('MaxPoolSize=20');
    lConexao.getConnection.Params.Add('Server='+lHost.Server);
    lConexao.getConnection.Params.Add('user_name='+ 'SYSDBA');
    lConexao.getConnection.Params.Add('password='+ 'masterkey');
    lConexao.getConnection.Params.Add('port='+lHost.Port);
    lConexao.getConnection.Params.Add('Database='+ lHost.DataBase);
    lConexao.getConnection.Params.Add('DriverID='+ 'FB');
    lConexao.getConnection.Params.Add('Protocol='+ 'TCPIP');
    lConexao.getConnection.Params.Add('LoginPrompt='+ 'False');

    Result := lConexao;
  finally
    lLojaModel.Free;
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

function TControllersConexao.setTerasoftConfiguracoes(pConfiguracoes: TObject): IConexao;
begin
  vTerasoftConfiguracao := pConfiguracoes;
  Result := Self;
end;

function TControllersConexao.setUser(pUser: TUsuario): Boolean;
begin
  vUser := pUser;
end;

end.
