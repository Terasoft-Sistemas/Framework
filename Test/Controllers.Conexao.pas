unit Controllers.Conexao;

interface
  uses
    FireDAC.Comp.Client,
    Interfaces.Conexao;

  type
    TControllersConexao = class(TInterfacedObject, IConexao)

      private
        function criarQuery                              : TFDQuery;
        function criaConexao                             : IConexao;
        function ConfigConexao                           : Boolean;
        function criarQueryExterna                       : TFDQuery;
        function ConfigConexaoExterna(pLoja: String)     : Boolean;
        function Generetor(pValue: String)               : String;
        function getConnection                           : TFDConnection;
        function getLojaConectada                        : String;
        function DataServer                              : TDate;
        function HoraServer                              : TTime;

        function getUSer                                 : TUsuario;
        function setUser(pUser : TUsuario)               : Boolean;

        function setEmpresa(pEmpresa: TEmpresa)          : Boolean;
        function getEmpresa                              : TEmpresa;

        procedure setContext(pUsuario: String);
      public
        Constructor Create;
        Destructor Destroy; override;
        Class function New: IConexao;


    end;

implementation

uses
  uTeste;

{ TControllersConexao }

function TControllersConexao.ConfigConexao: Boolean;
begin

end;

function TControllersConexao.ConfigConexaoExterna(pLoja: String): Boolean;
begin

end;

constructor TControllersConexao.Create;
begin

end;

function TControllersConexao.criaConexao: IConexao;
begin

end;

function TControllersConexao.criarQuery: TFDQuery;
begin
  Result := Form1.vConexao.criarQuery;
end;

function TControllersConexao.criarQueryExterna: TFDQuery;
begin
  Result := Form1.vConexao.criarQueryExterna;
end;

function TControllersConexao.DataServer: TDate;
begin
  Result := Form1.vConexao.DataServer;
end;

destructor TControllersConexao.Destroy;
begin
  inherited;
end;

function TControllersConexao.Generetor(pValue: String): String;
begin
  Result := Form1.vConexao.Generetor(pValue);
end;

function TControllersConexao.getConnection: TFDConnection;
begin
  Result := Form1.vConexao.getConnection;
end;

function TControllersConexao.getEmpresa: TEmpresa;
begin

end;

function TControllersConexao.getLojaConectada: String;
begin

end;

function TControllersConexao.getUSer: TUsuario;
begin

end;

function TControllersConexao.HoraServer: TTime;
begin
  Result := Form1.vConexao.HoraServer;
end;

class function TControllersConexao.New: IConexao;
begin
  Result := Self.Create;
end;

procedure TControllersConexao.setContext(pUsuario: String);
begin

end;

function TControllersConexao.setEmpresa(pEmpresa: TEmpresa): Boolean;
begin

end;

function TControllersConexao.setUser(pUser: TUsuario): Boolean;
begin

end;

end.
