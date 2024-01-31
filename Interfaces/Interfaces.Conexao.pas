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
      ID                                   : String;
      LOJA                                 : String;
      STRING_CONEXAO_RESERVA               : String;
      EMPRESA_ENDERECO_CODIGO_MUNICIPIO    : String;
      EMPRESA_ENDERECO_LOGRADOURO          : String;
      EMPRESA_ENDERE_NUMERO                : String;
      EMPRESA_ENDERECO_CEP                 : String;
      EMPRESA_ENDERECO_BAIRRO              : String;
      EMPRESA_ENDERECO_CIDADE              : String;
      EMPRESA_ENDERECO_UF                  : String;
      EMPRESA_ENDERECO_COMPLEMENTO         : String;
      EMPRESA_FANTASIA                     : String;
      EMPRESA_RAZAOSOCIAL                  : String;
      EMPRESA_CNPJ                         : String;
      EMPRESA_INSCICAO_ESTADUAL            : String;
      EMPRESA_REGIME_NFE                   : Integer;
      EMPRESA_TELEFONE                     : String;
    end;

    TConfiguracoesNF = record
      NFE_AMBIENTE                         : Integer;
      NFE_EVENTO_PATH                      : String;
      NFE_INUTILIZADO_PATH                 : String;
      NFE_XML_PATH                         : String;
      NFE_SALVAR_PATH                      : String;
      NFE_SCHEMAS_PATH                     : String;
      EMPRESA_CERTIFICADO_PATH             : String;
      EMPRESA_CERTIFICADO_SENHA            : String;
      NFCE_TOKEN                           : String;
      NFE_LOGO_PATH                        : String;
      NFCE_LOGO_PATH                       : String;
      EMPRESA_SCAN                         : TDateTime;
      NFCE_ID_TOKEN                        : String;
      NFE_TIPO_EMISSAO                     : Integer;
    end;

    IConexao = interface
      ['{66A98734-B254-4482-A4EA-8D3D1CD8C974}']

      function criarQuery                                                  : TFDQuery;
      function criarQueryExterna                                           : TFDQuery;
      function criaConexao                                                 : IConexao;
      function ConfigConexao                                               : Boolean;
      function ConfigConexaoExterna(pLoja: String; pHost : String = '')    : Boolean;
      function Generetor(pValue: String)                                   : String;
      function getConnection                                               : TFDConnection;
      function getLojaConectada                                            : String;
      function DataServer                                                  : TDate;
      function HoraServer                                                  : TTime;
      function DataHoraServer                                              : TDateTime;

      function getUSer                                                     : TUsuario;
      function setUser(pUser : TUsuario)                                   : Boolean;

      function setEmpresa(pEmpresa: TEmpresa)                              : Boolean;
      function getEmpresa                                                  : TEmpresa;

      function setConfiguracoesNF(pConfiguracoes : TConfiguracoesNF)       : Boolean;
      function getConfiguracoes                                            : TConfiguracoesNF;

      procedure setContext(pUsuario: String);

    end;

implementation

end.
