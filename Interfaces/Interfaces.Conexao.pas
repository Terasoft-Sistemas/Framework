unit Interfaces.Conexao;

interface
  uses
    Terasoft.Framework.Types,
    Terasoft.Framework.DB,
    Terasoft.Framework.Texto,
    FireDAC.Comp.Client,
    System.SysUtils,
    System.Classes,
    DB,
    Terasoft.Framework.ObjectIface,
    Terasoft.Types,
    System.Generics.Defaults;

  type

    IFDQuery = IObject<TFDQuery>;
    IFDMemTable = IObject<TFDMemTable>;
    IFDDataset = IObject<TDataset>;

    TUsuario = record
      ID              : string;
      NOME            : string;
      PERFIL          : String;
      URL_WINDOWS     : String;
      USUARIO_WINDOWS : String;
      SENHA_WINDOWS   : String;
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
      BLOQUEAR_SALDO_NEGATIVO              : String;
    end;

    TConfiguracoesNF = record
      NFE_AMBIENTE                         : Integer;
      NFE_EVENTO_PATH                      : String;
      NFE_INUTILIZADO_PATH                 : String;
      NFE_XML_PATH                         : String;
      NFE_SALVAR_PATH                      : String;
      NFE_SCHEMAS_PATH                     : String;
      EMPRESA_CERTIFICADO                  : AnsiString;
      EMPRESA_CERTIFICADO_SENHA            : String;
      NFCE_TOKEN                           : String;
      NFE_LOGO_PATH                        : String;
      NFCE_LOGO_PATH                       : String;
      EMPRESA_SCAN                         : TDateTime;
      NFCE_ID_TOKEN                        : String;
      NFE_TIPO_EMISSAO                     : Integer;
    end;

    TDadosFields = record
      tabela,
      listaNames,
      listaValues: TipoWideStringFramework;
      listaUpdate: TipoWideStringFramework;
      listaCampos: IListaString;
    end;

    IConstrutorDao = interface
    ['{B57D1A1D-1220-49A2-BA20-15BD9079C1AC}']
      function gerarInsert(pTabela, pFieldReturning: String; pGerarID: Boolean = false): String;
      function gerarUpdateOrInsert(pTabela, pMatch, pFieldReturning: String; pGerarID: Boolean = false): String;
      function gerarUpdate(pTabela, pFieldWhere: String): String;
      function queryTabela(pTabela: String): String;
      function carregaFields(pQry: TDataset; pTabela: String; pGerarID: Boolean): TDadosFields;
      procedure copiarEstruturaCampos(pSource: TDataSet; pDest: TDataset);
      procedure atribuirRegistros(pSource: TDataSet; pDest: TDataset); overload;
      function atribuirRegistros(pSource: TDataSet): IFDDataset; overload;
      function getColumns(pTabela: String): IFDDataset;
      function getValue(pTabela: TDataset; pColumn: String; pValue: String ): String;
      function getSQL(pSource: TFDQuery): String;
      procedure setParams(pTabela: String; pQry: TFDQuery; pModel: TObject);
      procedure setDatasetToModel(pTabela: String; pDataset: TDataset; pModel: TObject);
      function expandIn(pCampo: String; pValues: IListaString): String;
      procedure sincronizarDados(pTabela: String; pChave: String; pModelo: TObject; pAcao: TAcao; pEspera: boolean = false);
      function getValuesFromModel(pCampos: String; pModel: TObject): TVariantArray;
    end;

    IConexao = interface
      ['{66A98734-B254-4482-A4EA-8D3D1CD8C974}']

      function criarQuery                                                  : TFDQuery;
      function criaIfaceQuery                                              : IFDQuery;
      function criarQueryExterna                                           : TFDQuery;
      function criaIfaceQueryExterna                                       : IFDQuery;
      function connection                                                  : IConexao; overload;
      function connection(pLoja: String; pHost : String = '')              : IConexao; overload;
      function NovaConexao(pLoja: String; pHost : String = '')             : IConexao;
      function ConfigConexaoExterna(pLoja: String; pHost : String = '')    : Boolean;
      function Generetor(pValue: String; pCrtGen : Boolean = false)        : String;
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

      procedure setTerasoftConfiguracoes(const pConfiguracoes : IUnknown);
      function getTerasoftConfiguracoes                                    : IUnknown;

      procedure setContext(pUsuario: String);
      procedure setContextModoSistema(pSistema: String);

      function getGDB: IGDB;
      function getValidador: IValidadorDatabase;

      function getGDBExterno: IGDB;

      procedure registraEvento(const pEvento: TipoWideStringFramework; pObjeto: TipoWideStringFramework=''; pDescricao: TipoWideStringFramework = ''; pParam2: TipoWideStringFramework = ''; pParam3: TipoWideStringFramework = '');

    //property ultimoAcessoDB getter/setter
      function getUltimoAcessoDB: TDateTime;
      procedure setUltimoAcessoDB(const pValue: TDateTime);

    //property estatistica getter/setter
      function getEventosUsoSessao: IUnknown;
      procedure setEventosUsoSessao(const pValue: IUnknown);

      property eventosUsoSessao: IUnknown read getEventosUsoSessao write setEventosUsoSessao;
      property ultimoAcessoDB: TDateTime read getUltimoAcessoDB write setUltimoAcessoDB;
      property empresa: TEmpresa read getEmpresa;
      property gdbExterno: IGDB read getgdbExterno;
      property gdb: IGDB                       read getGDB;
      property validador: IValidadorDatabase   read getValidador;
      property terasoftConfiguracoes: IUnknown read getTerasoftConfiguracoes write setTerasoftConfiguracoes;

    end;

    function criaIFDDataset(const obj: TDataSet): IFDDataset;
    function criaConstrutorDao(pIConexao: IConexao): IConstrutorDao;
    function criaIFDMemTable(const obj: TFDMemTable): IFDMemTable;

implementation
  uses
    Terasoft.ConstrutorDao;

function criaConstrutorDao(pIConexao: IConexao): IConstrutorDao;
begin
  Result := TConstrutorDao.Create(pIConexao);
end;

function criaIFDDataset(const obj: TDataSet): IFDDataset;
begin
  Result := TImplObjetoOwner<TDataset>.CreateOwner(obj);
end;

function criaIFDMemTable(const obj: TFDMemTable): IFDMemTable;
begin
  Result := TImplObjetoOwner<TFDMemTable>.CreateOwner(obj);
end;

end.
