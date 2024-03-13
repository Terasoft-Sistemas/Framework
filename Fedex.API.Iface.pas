{$i Logistica.inc}

unit Fedex.API.Iface;

interface
  uses
    Terasoft.Framework.ListaSimples,
    Terasoft.Framework.Logistica,
    Data.FmtBcd,
    Terasoft.Framework.ControleAlteracoes,
    Terasoft.Framework.DB,
    Terasoft.Framework.Texto,
    Terasoft.Framework.Types;

  const
    FEDEX_PRIORIDADE_ALTA         = '1';
    FEDEX_PRIORIDADE_MEDIAALTA    = '2';
    FEDEX_PRIORIDADE_MEDIA        = '3';
    FEDEX_PRIORIDADE_MEDIABAIXA   = '4';
    FEDEX_PRIORIDADE_BAIXA        = '5';

    FEDEX_TIPO_ENTRADA_NORMAL     = '1';
    FEDEX_TIPO_ENTRADA_DEVOLUCAO  = '2';

    FEDEX_ACAOARQUIVO_MANTER      = 'M';
    FEDEX_ACAOARQUIVO_REJEITAR    = 'R';
    FEDEX_ACAOARQUIVO_DIVERGENTE  = 'D';
    FEDEX_ACAOARQUIVO_APAGAR      = 'A';


    DEF_DIRETORIO_LB = '/PROD/LDB';

    URLPRODUCAOFEDEX     = 'https://celular.rapidaocometa.com.br:51040/soap-new?service=WMS10_GENERIC';
    URLHOMOLOGACAOFEDEX  = 'https://internet.rapidaocometa.com.br:6060/soap-new?service=WMS10_GENERIC';

    SISTEMA_LOGISTICA_FEDEX_PRODUCAO     = 'FEDEX';
    SISTEMA_LOGISTICA_FEDEX_HOMOLOGACAO  = 'FED.HOM';

  {
    STATUS Logistica
    CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO(A) - DISPONIVEL PARA ENVIO -
        Está pronto para envio para a logística
    CONTROLE_LOGISTICA_STATUS_ENVIADO(E) - Enviado
        Processo enviou e aguarda um retorno da logística
    CONTROLE_LOGISTICA_STATUS_DIVERGENTE - Divergente
        Ocorreu alguma inconsitencia no envio / recebimento
    CONTROLE_LOGISTICA_STATUS_FINALIZADO - Processo de envio / recebimento finalizado
  }

  type


    IFedexAuth = interface;
    IFedexDepositante = interface;
    IFedexSKU = interface;
    IFedexAPI = interface;

    // Movido para logistica
    //TFedexProcessadorArquivoRetorno = function (pAPI: IFedexAPI; pResultado: IResultadoOperacao): IResultadoOperacao;

    IFedexParam = interface
      ['{D60B5541-FADF-4799-A008-CEECCAC004EB}']

      function checkParametros(pResultado: IResultadoOperacao): boolean;

      procedure setDiretorioLock(const value: TipoWideStringFramework);
      function getDiretorioLock: TipoWideStringFramework;

      function getDepositante: IFedexDepositante;

      function getAuth: IFedexAuth;

      procedure setUrlWS(const value: TipoWideStringFramework);
      function getUrlWS: TipoWideStringFramework;

      procedure setDiretorioArquivos(const value: TipoWideStringFramework);
      function getDiretorioArquivos: TipoWideStringFramework;

      procedure setModoProducao(const value: boolean);
      function getModoProducao: boolean;

      procedure setDiretorioLDB(const pValue: TipoWideStringFramework);
      function getDiretorioLDB: TipoWideStringFramework;

      //procedure setDiretorioLocal(const pValue: TipoWideStringFramework);
      //function getDiretorioLocal: TipoWideStringFramework;

      procedure setSshUser(const pValue: TipoWideStringFramework);
      function getSshUser: TipoWideStringFramework;

      procedure setSenhaSSH(const pValue: TipoWideStringFramework);
      function getSenhaSSH: TipoWideStringFramework;

      procedure setHostSSH(const pValue: TipoWideStringFramework);
      function getHostSSH: TipoWideStringFramework;

      procedure setPortaSSH(const pValue: Integer);
      function getPortaSSH: Integer;

      procedure setControleAlteracoes(const pValue: IControleAlteracoes);
      function getControleAlteracoes: IControleAlteracoes;

      property controleAlteracoes: IControleAlteracoes read getControleAlteracoes write setControleAlteracoes;
      property portaSSH: Integer read getPortaSSH write setPortaSSH;
      property hostSSH: TipoWideStringFramework read getHostSSH write setHostSSH;
      property senhaSSH: TipoWideStringFramework read getSenhaSSH write setSenhaSSH;
      property usuarioSSH: TipoWideStringFramework read getSshUser write setSshUser;
      //property diretorioSSHLocal: TipoWideStringFramework read getDiretorioLocal write setDiretorioLocal;
      property diretorioLDB: TipoWideStringFramework read getDiretorioLDB write setDiretorioLDB;
      property modoProducao: boolean read getModoProducao write setModoProducao;
      property diretorioArquivos: TipoWideStringFramework read getDiretorioArquivos write setDiretorioArquivos;
      property urlWS: TipoWideStringFramework read getUrlWS write setUrlWS;
      property auth: IFedexAuth read getAuth;
      property depositante: IFedexDepositante read getDepositante;
      property diretorioLock: TipoWideStringFramework read getDiretorioLock write setDiretorioLock;

    end;

    IFedexAuth = interface
      ['{59B9BE25-D7E6-4860-9177-40CA0B4F7891}']

      procedure setUsuario(const value: TipoWideStringFramework);
      function getUsuario: TipoWideStringFramework;

      procedure setSenha(const value: TipoWideStringFramework);
      function getSenha: TipoWideStringFramework;

      property senha: TipoWideStringFramework read getSenha write setSenha;
      property usuario: TipoWideStringFramework read getUsuario write setUsuario;
    end;

    IFedexDepositante = interface
      ['{783508E2-58B9-4768-AEF2-F128717D2AE6}']

      procedure setCodigo(const value: TipoWideStringFramework);
      function getCodigo: TipoWideStringFramework;

      procedure setCnpj(const value: TipoWideStringFramework);
      function getCnpj: TipoWideStringFramework;

      procedure setNome(const value: TipoWideStringFramework);
      function getNome: TipoWideStringFramework;

      function getAuth: IFedexAuth;

      procedure setChave(const value: TipoWideStringFramework);
      function getChave: TipoWideStringFramework;

      property chave: TipoWideStringFramework read getChave write setChave;
      property auth: IFedexAuth read getAuth;
      property nome: TipoWideStringFramework read getNome write setNome;
      property cnpj: TipoWideStringFramework read getCnpj write setCnpj;
      property codigo: TipoWideStringFramework read getCodigo write setCodigo;
    end;

    IFedexSKU = interface
      ['{5865214A-0864-409C-9436-ADCECC777AD4}']

      procedure inicializa;
      function critica(pResultado: IResultadoOperacao): boolean;

      procedure setSku(const value: TipoWideStringFramework);
      function getSku: TipoWideStringFramework;
      procedure setAltSKU(const value: TipoWideStringFramework);
      function getAltSKU: TipoWideStringFramework;

      procedure setUtilizado(const value: boolean);
      function getUtilizado: boolean;

      procedure setPeso(const value: TBCD);
      function getPeso: TBCD;

      procedure setDescricao(const value: TipoWideStringFramework);
      function getDescricao: TipoWideStringFramework;

      procedure setGrupo(const value: TipoWideStringFramework);
      function getGrupo: TipoWideStringFramework;

      procedure setSubGrupo(const value: TipoWideStringFramework);
      function getSubGrupo: TipoWideStringFramework;

      procedure setParametros(const value: IFedexParam);
      function getParametros: IFedexParam;

      procedure setResultadoOperacao(const value: IResultadoOperacao);
      function getResultadoOperacao: IResultadoOperacao;

      property resultadoOperacao: IResultadoOperacao read getResultadoOperacao write setResultadoOperacao;
      property parametros: IFedexParam read getParametros write setParametros;
      property subGrupo: TipoWideStringFramework read getSubGrupo write setSubGrupo;
      property grupo: TipoWideStringFramework read getGrupo write setGrupo;
      property descricao: TipoWideStringFramework read getDescricao write setDescricao;
      property peso: TBCD read getPeso write setPeso;
      property utilizado: boolean read getUtilizado write setUtilizado;
      property sku: TipoWideStringFramework read getSku write setSku;
      property altSKU: TipoWideStringFramework read getAltSKU write setAltSKU;
    end;

    IFedexPurchaseOrder = interface
    ['{7F5F1094-DDB0-42F2-83BF-B5B4E9D61FE1}']
      procedure inicializa;

      function critica(pResultado: IResultadoOperacao): boolean;

      procedure setParameters(const pValue: IFedexParam);
      function getParameters: IFedexParam;

      procedure setResultadoOperacao(const pValue: IResultadoOperacao);
      function getResultadoOperacao: IResultadoOperacao;

      procedure setId(const pValue: TipoWideStringFramework);
      function getId: TipoWideStringFramework;

      property id: TipoWideStringFramework read getId write setID;
      property resultadoOperacao: IResultadoOperacao read getResultadoOperacao write setResultadoOperacao;
      property parameters: IFedexParam read getParameters write setParameters;
    end;

    //SO - Shipment Order
    IFedexShipmentOrder= interface
    ['{1E6B0E23-0763-46C8-8FA3-D83B3DA8EB1E}']

      procedure inicializa;

      function critica(pResultado: IResultadoOperacao): boolean;

      procedure setId(const pValue: TipoWideStringFramework);
      function getId: TipoWideStringFramework;

      procedure setResultadoOperacao(const pValue: IResultadoOperacao);
      function getResultadoOperacao: IResultadoOperacao;

      procedure setUtilizado(const pValue: boolean);
      function getUtilizado: boolean;
      procedure setParameters(const value: IFedexParam);
      function getParameters: IFedexParam;

      procedure setEmissao(const pValue: TDate);
      function getEmissao: TDate;

      property emissao: TDate read getEmissao write setEmissao;
      property parameters: IFedexParam read getParameters write setParameters;
      property utilizado: boolean read getUtilizado write setUtilizado;
      property resultadoOperacao: IResultadoOperacao read getResultadoOperacao write setResultadoOperacao;
      property id: TipoWideStringFramework read getId write setId;
    end;

    //Listas
    TFedex_SKUList = IListaSimples<IFedexSKU>;
    TFedex_PurchaseOrderList = IListaSimples<IFedexPurchaseOrder>;
    TFedex_ShipmentOrderList = IListaSimples<IFedexShipmentOrder>;

    IFedexAPI = interface
      ['{159D6DD7-2B62-4D84-AC6A-7AE473B3F286}']

      procedure setProcessador(pInterface: TipoWideStringFramework; pProcessador: TLogisticaProcessadorArquivoRetorno);
      function getProcessador(pInterface: TipoWideStringFramework): TLogisticaProcessadorArquivoRetorno;

      function getSKUList(pXMLData: TipoWideStringFramework; critica: boolean; pResultado: IResultadoOperacao): TFedex_SKUList;
      function sendSKU(pSku: IFedexSKU; pResultado: IResultadoOperacao): IResultadoOperacao;
      function sendSKUList(pLista: TFedex_SKUList; pResultado: IResultadoOperacao): IResultadoOperacao;

      function getShipmentOrderList(pXMLDataList: IDicionarioSimples<TipoWideStringFramework, TipoWideStringFramework>; pPrioridade: TipoWideStringFramework = FEDEX_PRIORIDADE_MEDIA; pCritica: boolean = true; pLista: TFedex_ShipmentOrderList = nil; pResultado: IResultadoOperacao = nil): TFedex_ShipmentOrderList;
      function sendShipmentOrder(pOrder: IFedexShipmentOrder; pResultado: IResultadoOperacao): IResultadoOperacao;
      function sendShipmentOrderList(pList: TFedex_ShipmentOrderList; pResultado: IResultadoOperacao): IResultadoOperacao;

      function getPurchaseOrderList(pXMLDataList: IDicionarioSimples<TipoWideStringFramework, TipoWideStringFramework>; critica: boolean; pLista: TFedex_PurchaseOrderList = nil; pResultado: IResultadoOperacao = nil): TFedex_PurchaseOrderList;
      function sendPurchaseOrderList(pList: TFedex_PurchaseOrderList; pResultado: IResultadoOperacao): IResultadoOperacao;
      function sendPurchaseOrder(pOrder: IFedexPurchaseOrder; pResultado: IResultadoOperacao): IResultadoOperacao;

      function processaRetorno(pProcessador: TLogisticaProcessadorArquivoRetorno; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

      function getParameters: IFedexParam;

      function getVersao: TipoWideStringFramework;
      function getCompilacao: Int64;

      property parameters: IFedexParam read getParameters;
      property versao: TipoWideStringFramework read getVersao;
      property compilacao: Int64 read getCompilacao;

    end;

  {$if not defined(__DLL__)}
    function createFedexAPI: IFedexAPI; stdcall;
  {$ifend}

  type

    TFedexDatasets = record
      valido: boolean;
      po, poItens, sku,
      so, soItens,
      cliente, transportador: IDatasetSimples;
    end;

  function getFedexDatasets: TFedexDatasets;

  function rejeitarArquivoFedex(pNotificarUsuario: boolean;pResultado: IResultadoOperacao): IResultadoOperacao;
  function manterArquivoFedex(pNotificarUsuario: boolean;pResultado: IResultadoOperacao): IResultadoOperacao;
  function divergenciaArquivoFedex(pNotificarUsuario: boolean;pResultado: IResultadoOperacao): IResultadoOperacao;
  function apagarArquivoFedex(pNotificarUsuario: boolean;pResultado: IResultadoOperacao): IResultadoOperacao;

implementation
  uses
    DBClient, DB;

  {$if not defined(__DLL__)}
    function createFedexAPI: IFedexAPI; stdcall; external 'FedexAPI_DLL' name 'createFedexAPI' delayed;
  {$ifend}

function getFedexDatasets: TFedexDatasets;
  var
    ds: TClientDataSet;
begin
  Result.valido := true;
  Result.po := criaDatasetSimples;
  ds := TClientDataSet(Result.po.dataset);
  ds.Close;
  ds.FieldDefs.Add('id',ftString,30,false);
  ds.FieldDefs.Add('cfop',ftString,50,false);
  ds.FieldDefs.Add('fornecedor',ftString,30,false);
  ds.FieldDefs.Add('codigo_for',ftString,30,false);
  ds.FieldDefs.Add('data_movimento',ftDate,0,false);
  ds.FieldDefs.Add('operacao',ftString,1,false);
  ds.FieldDefs.Add('xml',ftMemo,1,false);
  ds.FieldDefs.Add('numero_nfe',ftString,50,false);
  ds.CreateDataSet;
  ds.LogChanges := false;

  Result.poItens := criaDatasetSimples;
  ds := TClientDataSet(Result.poItens.dataset);
  ds.Close;
  ds.FieldDefs.Add('id',ftString,50,false);
  ds.FieldDefs.Add('item',ftString,50,false);
  ds.FieldDefs.Add('produto',ftString,50,false);
  ds.FieldDefs.Add('quantidade',ftFloat,0,false);
  ds.FieldDefs.Add('unitario',ftFloat,0,false);
  ds.FieldDefs.Add('barras',ftString,50,false);
  ds.CreateDataSet;
  ds.LogChanges := false;

  Result.sku := criaDatasetSimples;
  ds := TClientDataSet(Result.sku.dataset);
  ds.Close;
  ds.FieldDefs.Add('id',ftString,50,false);
  ds.FieldDefs.Add('barras',ftString,50,false);
  ds.FieldDefs.Add('nome',ftString,50,false);
  ds.FieldDefs.Add('peso',ftFloat,0,false);
  ds.FieldDefs.Add('grupo',ftString,50,false);
  ds.FieldDefs.Add('subgrupo',ftString,50,false);
  ds.CreateDataSet;
  ds.LogChanges := false;

  Result.so := criaDatasetSimples;
  ds := TClientDataSet(Result.so.dataset);
  ds.Close;
  ds.FieldDefs.Add('id',ftString,50,false);
  ds.FieldDefs.Add('data_emissao',ftDate,0,false);
  ds.FieldDefs.Add('valor_total',ftFloat,0,false);
  ds.FieldDefs.Add('cliente_codigo',ftString,30,false);
  ds.FieldDefs.Add('cnpj_cpf',ftString,30,false);
  ds.FieldDefs.Add('transportador',ftString,30,false);
  ds.FieldDefs.Add('transportadora_codigo',ftString,30,false);
  ds.CreateDataSet;
  ds.LogChanges := false;

  Result.soItens := criaDatasetSimples;
  ds := TClientDataSet(Result.soItens.dataset);
  ds.Close;
  ds.FieldDefs.Add('id',ftString,50,false);
  ds.FieldDefs.Add('item',ftString,30,false);
  ds.FieldDefs.Add('produto_id',ftString,30,false);
  ds.FieldDefs.Add('quantidade',ftFloat,0,false);
  ds.CreateDataSet;
  ds.LogChanges := false;

  Result.cliente := criaDatasetSimples;
  ds := TClientDataSet(Result.cliente.dataset);
  ds.Close;
  ds.FieldDefs.Add('cnpj_cpf',ftString,30,false);
  ds.FieldDefs.Add('razao_social',ftString,100,false);
  ds.FieldDefs.Add('fantasia',ftString,100,false);
  ds.FieldDefs.Add('endereco',ftString,100,false);
  ds.FieldDefs.Add('numero',ftString,20,false);
  ds.FieldDefs.Add('complemento',ftString,100,false);
  ds.FieldDefs.Add('cidade',ftString,100,false);
  ds.FieldDefs.Add('uf',ftString,10,false);
  ds.FieldDefs.Add('cep',ftString,30,false);
  ds.CreateDataSet;
  ds.LogChanges := false;

  Result.transportador := criaDatasetSimples;
  ds := TClientDataSet(Result.transportador.dataset);
  ds.Close;
  ds.FieldDefs.Add('cnpj_cpf',ftString,30,false);
  ds.FieldDefs.Add('razao_social',ftString,100,false);
  ds.FieldDefs.Add('fantasia',ftString,100,false);
  ds.FieldDefs.Add('endereco',ftString,100,false);
  ds.FieldDefs.Add('numero',ftString,20,false);
  ds.FieldDefs.Add('complemento',ftString,100,false);
  ds.FieldDefs.Add('cidade',ftString,100,false);
  ds.FieldDefs.Add('uf',ftString,10,false);
  ds.FieldDefs.Add('cep',ftString,30,false);
  ds.FieldDefs.Add('pais',ftString,30,false);
  ds.FieldDefs.Add('telefone',ftString,30,false);
  ds.CreateDataSet;
  ds.LogChanges := false;

end;

function rejeitarArquivoFedex(pNotificarUsuario: boolean;pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  Result := checkResultadoOperacao(pResultado);
  pResultado.propriedade['ACAO_ARQUIVO'].asString := FEDEX_ACAOARQUIVO_REJEITAR;
  if(pNotificarUsuario) then
    pResultado.propriedade['NOTIFICAR_USUARIO'].asBoolean := true;
end;

function manterArquivoFedex(pNotificarUsuario: boolean;pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  Result := checkResultadoOperacao(pResultado);
  pResultado.propriedade['ACAO_ARQUIVO'].asString := FEDEX_ACAOARQUIVO_MANTER;
  if(pNotificarUsuario) then
    pResultado.propriedade['NOTIFICAR_USUARIO'].asBoolean := true;
end;

function divergenciaArquivoFedex(pNotificarUsuario: boolean;pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  Result := checkResultadoOperacao(pResultado);
  pResultado.propriedade['ACAO_ARQUIVO'].asString := FEDEX_ACAOARQUIVO_DIVERGENTE;
  if(pNotificarUsuario) then
    pResultado.propriedade['NOTIFICAR_USUARIO'].asBoolean := true;
end;

function apagarArquivoFedex(pNotificarUsuario: boolean;pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  Result := checkResultadoOperacao(pResultado);
  pResultado.propriedade['ACAO_ARQUIVO'].asString := FEDEX_ACAOARQUIVO_APAGAR;
  if(pNotificarUsuario) then
    pResultado.propriedade['NOTIFICAR_USUARIO'].asBoolean := true;
end;


end.
