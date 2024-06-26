
{$i Credipar.inc}

unit Terasoft.Framework.Credipar.Analisador.iface;

interface
  uses
    Terasoft.Framework.Texto,
    Terasoft.Framework.DB,
    Terasoft.Framework.Types;

  const
    RETORNO_CREDIPAR_LOJA           = 'Credipar.loja';
    RETORNO_CREDIPAR_MENSAGEM       = 'Credipar.mensagem';
    RETORNO_CREDIPAR_CONTRATO       = 'Credipar.contrato';
    RETORNO_CREDIPAR_PROCESSAMENTO  = 'Credipar.processamento';
    RETORNO_CREDIPAR_ERRO           = 'Credipar.erro';

    RETORNO_CREDIPAR_DADOSCLIENTE   = 'Cliente.dados';
    RETORNO_CREDIPAR_DADOSPROPOSTA  = 'Proposta.dados';

  type

    //ICredipar_PessoaJuridica = interface
    //['{B2D41380-46B9-4937-B8BE-926813959765}']
    //  function loadFromPathReaderWriter(const pPathRW: IPathReaderWriter; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    //end;

    ICredipar_PessoaFisica = interface
    ['{B2D41380-46B9-4937-B8BE-926813959765}']
      function getAddr: Pointer;
      function loadFromPathReaderWriter(const pPathRW: IUnknown; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    end;

    ICredipar_Proposta = interface
    ['{7BFA61DA-E339-44BB-9AE1-BCDD55FBDF47}']

      function getAddr: Pointer;
      function loadFromPathReaderWriter(const pPathRW: IUnknown; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

    (*
    //property proposta getter/setter
      procedure setProposta(const pValue: TipoWideStringFramework);
      function getProposta: TipoWideStringFramework;

    //property loja getter/setter
      function getLoja: Integer;
      procedure setLoja(const pValue: Integer);

    //property qt_parcela getter/setter
      function getQt_parcela: Integer;
      procedure setQt_parcela(const pValue: Integer);

    //property cd_pedido getter/setter
      function getCd_pedido: Integer;
      procedure setCd_pedido(const pValue: Integer);

    //property idtabela getter/setter
      function getIdtabela: Integer;
      procedure setIdtabela(const pValue: Integer);

    //property cd_tipo_financ getter/setter
      function getCd_tipo_financ: Integer;
      procedure setCd_tipo_financ(const pValue: Integer);

    //property id_lj_tabela getter/setter
      function getId_lj_tabela: Integer;
      procedure setId_lj_tabela(const pValue: Integer);

    //property cd_empresa getter/setter
      function getCd_empresa: Integer;
      procedure setCd_empresa(const pValue: Integer);

      property cd_empresa: Integer read getCd_empresa write setCd_empresa;
      property id_lj_tabela: Integer read getId_lj_tabela write setId_lj_tabela;
      property cd_tipo_financ: Integer read getCd_tipo_financ write setCd_tipo_financ;
      property idtabela: Integer read getIdtabela write setIdtabela;
      property cd_pedido: Integer read getCd_pedido write setCd_pedido;
      property qt_parcela: Integer read getQt_parcela write setQt_parcela;
      property loja: Integer read getLoja write setLoja;
      property proposta: TipoWideStringFramework read getProposta write setProposta;
     *)
    end;

    ICredipar = interface
    ['{5E234CAB-1B84-42F7-A94E-5F76F58B7901}']
    //property proposta getter/setter
      function getAddr: Pointer;

      function getProposta: ICredipar_Proposta;
      procedure setProposta(const pValue: ICredipar_Proposta);

      function getNovaProposta: ICredipar_Proposta;

      function critica(pResultado: IResultadoOperacao): boolean;

    //property pessoaFisica getter/setter
      function getPessoaFisica: ICredipar_PessoaFisica;
      procedure setPessoaFisica(const pValue: ICredipar_PessoaFisica);

      function envia(pResultado: IResultadoOperacao): IResultadoOperacao;

    //property diretorioArquivos getter/setter
      function getDiretorioArquivos: tipoWideStringFramework;
      procedure setDiretorioArquivos(const pValue: tipoWideStringFramework);

    //property modoProducao getter/setter
      function getModoProducao: boolean;
      procedure setModoProducao(const pValue: boolean);

    //property urlWS getter/setter
      function getUrlWS: TipoWideStringFramework;
      procedure setUrlWS(const pValue: TipoWideStringFramework);

    //property token getter/setter
      function getToken: TipoWideStringFramework;
      procedure setToken(const pValue: TipoWideStringFramework);

    //property codLojaCred getter/setter
      function getCodigoLojaCredipar: Integer;
      procedure setCodigoLojaCredipar(const pValue: Integer);

    //property codigoProdutoCredipar getter/setter
      function getCodigoProdutoCredipar: Integer;
      procedure setCodigoProdutoCredipar(const pValue: Integer);

      function editarDados(pDadosCliente, pDadosProposta: IUnknown; pResultado: IResultadoOperacao=nil): IResultadoOperacao;

      property codigoProdutoCredipar: Integer read getCodigoProdutoCredipar write setCodigoProdutoCredipar;
      property codigoLojaCredipar: Integer read getCodigoLojaCredipar write setCodigoLojaCredipar;
      property token: TipoWideStringFramework read getToken write setToken;
      property urlWS: TipoWideStringFramework read getUrlWS write setUrlWS;
      property modoProducao: boolean read getModoProducao write setModoProducao;
      property diretorioArquivos: tipoWideStringFramework read getDiretorioArquivos write setDiretorioArquivos;
      property pessoaFisica: ICredipar_PessoaFisica read getPessoaFisica write setPessoaFisica;
      property proposta: ICredipar_Proposta read getProposta write setProposta;
    end;

  {$if not defined(__DLL__)}
    function createCredipar: ICredipar ; stdcall;
    function getCredipar: ICredipar;
  {$ifend}

implementation
  uses
    FuncoesConfig;

{$if not defined(__DLL__)}
    function createCredipar: ICredipar; stdcall; external 'Credipar_DLL' name 'createCredipar' delayed;

function getCredipar: ICredipar;
begin
  Result := createCredipar;
  if(gdbPadrao<>nil) then
  begin
    Result.urlWS := ValorTagConfig(tagConfig_CREDIPAR_ENDERECO_WS,'',tvString);
    Result.modoProducao := true;
    Result.diretorioArquivos := ValorTagConfig(tagConfig_CREDIPAR_DIRETORIO_ARQUIVOS,'',tvString);
    Result.token := ValorTagConfig(tagConfig_CREDIPAR_TOKEN,'',tvString);
    Result.codigoLojaCredipar := ValorTagConfig(tagConfig_CREDIPAR_CODIGO_LOJA,0,tvInteiro);
  end;
end;
  {$ifend}


end.
