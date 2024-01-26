unit Conexao;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.FB,
  FireDAC.DApt,
  FireDAC.VCLUI.Wait,
  System.IniFiles,
  Vcl.Forms,
  System.Types;

type
  TConexao = class
  private
    FConexao: TFDConnection;
    FConexaoExterna: TFDConnection;
    function configurarConexao: Boolean;

  public
    constructor Create;
    destructor Destroy; override;

    function DataServer: TDate;
    function HoraServer: TTime;
    function DataHoraServer: TDateTime;

    function criarQuery: TFDQuery;
    procedure setContext(pUsuario: String);
    procedure setContextModoSistema(pSistema: String);
    function Generetor(pGeneretor: String): String;
    function getConnection: TFDConnection;

    function ConfigConexaoExterna(pServer, pPort, pDataBase: String): Boolean;
    function CriarQueryExterna: TFDQuery;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils;

{ TConexao }

function TConexao.ConfigConexaoExterna(pServer, pPort, pDataBase: String): Boolean;
begin
  try
    FConexaoExterna := TFDConnection.Create(nil);
    FConexaoExterna.Params.Add('Server='+pServer);
    FConexaoExterna.Params.Add('user_name='+ 'SYSDBA');
    FConexaoExterna.Params.Add('password='+ 'masterkey');
    FConexaoExterna.Params.Add('port='+pPort);
    FConexaoExterna.Params.Add('Database='+ pDataBase);
    FConexaoExterna.Params.Add('DriverID='+ 'FB');
    FConexaoExterna.Params.Add('Protocol='+ 'TCPIP');
    FConexaoExterna.Params.Add('LoginPrompt='+ 'False');
  finally
     Result:= True;
  end;
end;

function TConexao.configurarConexao: Boolean;
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

constructor TConexao.Create;
begin
  FConexao := TFDConnection.Create(nil);
  Self.ConfigurarConexao;
end;

function TConexao.criarQuery: TFDQuery;
var
 VQuery: TFDQuery;
begin
   try
     VQuery := TFDQuery.Create(nil);
     VQuery.Connection := FConexao;

     Result := VQuery;
   finally
     //VQuery.Free;
   end;
end;


function TConexao.CriarQueryExterna: TFDQuery;
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

destructor TConexao.Destroy;
begin
  FConexaoExterna.Free;
  FConexao.Free;
  inherited;
end;

procedure TConexao.setContext(pUsuario: String);
var
  lQry :TFDQuery;
begin
  if pUsuario = '' then
   Exit;

  lQry := Self.criarQuery;

  lQry.Open('select rdb$set_context ( ''USER_SESSION'', ''USUARIO'','+QuotedStr(pUsuario)+' ) from rdb$database');

end;

procedure TConexao.setContextModoSistema(pSistema: String);
var
  lQry :TFDQuery;
begin
  if pSistema = '' then
   Exit;

  lQry := Self.criarQuery;
  lQry.Open('select rdb$set_context ( ''USER_SESSION'', ''MODOSISTEMA'', '+QuotedStr(pSistema)+' ) from rdb$database');
end;

function TConexao.DataHoraServer: TDateTime;
begin
  Result := self.FConexao.ExecSQLScalar('select current_timestamp from rdb$database');
end;

function TConexao.DataServer: TDate;
begin
  Result := self.FConexao.ExecSQLScalar('select current_date from rdb$database');
end;

function TConexao.HoraServer: TTime;
begin
  Result := self.FConexao.ExecSQLScalar('select current_time from rdb$database');
end;

function TConexao.Generetor(pGeneretor: String): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := Self.CriarQuery;

  try
    try
      lQry.open('select gen_id('+pGeneretor+',1) from rdb$Database');

      Result := FormatFloat('000000',(lQry.Fields[0].AsInteger));
    finally
      lQry.close;
    end;
  finally
    lQry.Free;
  end;
end;

function TConexao.getConnection: TFDConnection;
begin
  Result := FConexao;
end;

end.

