unit Controllers.Conexao;

interface
  uses
    FireDAC.Comp.Client,
    Terasoft.FuncoesTexto,
    Interfaces.Conexao;

  type
    TControllersConexao = class(TInterfacedObject, IConexao)

      private
        vLoja            : String;
        vUser            : TUsuario;
        vEmpresa         : TEmpresa;
        vConfiguracoesNF : TConfiguracoesNF;
        vTerasoftConfiguracao : TObject;

        function criarQuery                                                : TFDQuery;
        function criaConexao                                               : IConexao;
        function ConfigConexao                                             : Boolean;
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
  LojasModel, Terasoft.Types, GeneratorNewDao;

{ TControllersConexao }

function TControllersConexao.ConfigConexao: Boolean;
begin

end;

function TControllersConexao.ConfigConexaoExterna(pLoja: String; pHost : String = ''): Boolean;
var
  lLojaModel : TLojasModel;
  lHost      : THost;
begin
  lLojaModel := TLojasModel.Create(Form1.vIConexao);

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

    Form1.vConexao.ConfigConexaoExterna(lHost.Server, lHost.Port, lHost.DataBase);

    Result := True;
    vLoja  := pLoja;
  finally
    lLojaModel.Free;
  end;
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

function TControllersConexao.DataHoraServer: TDateTime;
begin
  Result := Form1.vConexao.DataHoraServer;
end;

function TControllersConexao.DataServer: TDate;
begin
  Result := Form1.vConexao.DataServer;
end;

destructor TControllersConexao.Destroy;
begin
  inherited;
end;

function TControllersConexao.Generetor(pValue: String; pCtrGen : Boolean = false): String;
var
  lGeneratorDao : TGeneratorNewDao;
begin
  lGeneratorDao := TGeneratorNewDao.Create(self);
  try
    if pCtrGen then
    begin
      Result := lGeneratorDao.generator(pValue);
      exit;
    end;

    Result := Form1.vConexao.Generetor(pValue);
  finally
    lGeneratorDao.Free;
  end;
end;

function TControllersConexao.getConfiguracoes: TConfiguracoesNF;
begin
  Result := vConfiguracoesNF;
end;

function TControllersConexao.getConnection: TFDConnection;
begin
  Result := Form1.vConexao.getConnection;
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
  Result := Form1.vConexao.HoraServer;
end;

class function TControllersConexao.New: IConexao;
begin
  Result := Self.Create;
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
