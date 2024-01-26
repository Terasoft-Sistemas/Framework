unit Interfaces.Conexao;

interface
  uses
    FireDAC.Comp.Client;

  type
    TUsuario = record
      ID     : string;
      NOME   : string;
      PERFIL : String;
    end;

    TEmpresa = record
      ID   : String;
      LOJA : String;
    end;

    IConexao = interface
      ['{66A98734-B254-4482-A4EA-8D3D1CD8C974}']

      function criarQuery                              : TFDQuery;
      function criarQueryExterna                       : TFDQuery;
      function criaConexao                             : IConexao;
      function ConfigConexao                           : Boolean;
      function ConfigConexaoExterna(pLoja: String)     : Boolean;
      function Generetor(pValue: String)               : String;
      function getConnection                           : TFDConnection;
      function getLojaConectada                        : String;
      function DataServer                              : TDate;
      function HoraServer                              : TTime;
      function DataHoraServer                          : TDateTime;

      function getUSer                                 : TUsuario;
      function setUser(pUser : TUsuario)               : Boolean;

      function setEmpresa(pEmpresa: TEmpresa)          : Boolean;
      function getEmpresa                              : TEmpresa;

      procedure setContext(pUsuario: String);

    end;

implementation

end.
