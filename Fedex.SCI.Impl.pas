
{$i definicoes.inc}

unit Fedex.SCI.Impl;

interface
  uses
    Classes,
    Terasoft.Framework.Types,
    Terasoft.Framework.Texto,
    Terasoft.Framework.ControleAlteracoes,
    Fedex.API.Iface;


  {$define MODO_HOMOLOGACAO}


//  const
//    SISTEMA_LOGISTICA_FEDEX = 'FEDEX';
//    SISTEMA_LOGISTICA_FEDEX_ = 'FEDEX-';

//    CONTROLE_LOGISTICA_FEDEX_SKU = 'SKU.CONTROLE';


  {
    STATUS Logistica
    A - Enviado
  }



  function criaFedexApiSCI(const pCNPJ: TipoWideStringFramework = ''; const pRazaoSocial: TipoWideStringFramework = ''): IFedexAPI;
  function getPurchaseOrderList(pAPI: IFedexAPI; pResultado: IResultadoOperacao = nil): TFedex_PurchaseOrderList;
  function getShipmentOrderList(pAPI: IFedexAPI; pResultado: IResultadoOperacao = nil): TFedex_ShipmentOrderList;
  function getSKUList(pAPI: IFedexAPI; pID: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): TFedex_SKUList;
  function fedex_PrecisaEnviarSKU(const pCodigo: TipoWideStringFramework): boolean;
  function criaControleAlteracoesFedex: IControleAlteracoes;
  function testFedexAPISCI(pResultado: IResultadoOperacao = nil): IResultadoOperacao;

implementation
  uses
    Terasoft.Framework.DB,
    FuncoesMensagem,
    Terasoft.Framework.Lock,
    Terasoft.Framework.ListaSimples.Impl,
    Terasoft.Framework.ListaSimples,
    SysUtils,
    FuncoesConfig;

function testFedexAPISCI;
  var
    lAPI: IFedexAPI;
    pLista: TFedex_PurchaseOrderList;
begin
  //Fedex.SCI.Impl.test;  //
  Result := checkResultadoOperacao(pResultado);
  lAPI := criaFedexApiSCI;
//  pResultado.propriedade['id'].asString := '1';
  pLista := getPurchaseOrderList(lAPI,pResultado);
  lAPI.sendPurchaseOrderList(pLista,pResultado);

  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;

function criaFedexApiSCI;
  var
    fedex: IFedexAPI;
    depositante: IFedexDepositante;
    lHost,lPorta,lUser: String;
    s: String;
begin
  fedex := createFedexAPI;
  {$if not defined(MODO_HOMOLOGACAO)}
    fedex.parameters.modoProducao := true;//true;
  {$else}
    fedex.parameters.modoProducao := true;//true;
  {$ifend}
  fedex.parameters.controleAlteracoes := criaControleAlteracoesFedex;
  fedex.parameters.urlWS := ValorTagConfig(tagConfig_FEDEX_WEBSERVICE,'',tvString);
  if(fedex.parameters.urlWS='') then
      fedex.parameters.urlWS :=
          {$if not defined(MODO_HOMOLOGACAO)}
            URLPRODUCAOFEDEX
          {$else}
            URLHOMOLOGACAOFEDEX
          {$ifend}
      ;
  fedex.parameters.diretorioLock := {$if defined(__RELEASE__)} getDiretorioLock {$else} 'c:\temp\lock'{$ifend};
  fedex.parameters.diretorioLDB := ValorTagConfig(tagConfig_FEDEX_DIRETORIOLDB,'',tvString);
  fedex.parameters.diretorioArquivos := ValorTagConfig(tagConfig_FEDEX_DIRETORIOLOCAL,'',tvString);

  s := ValorTagConfig(tagConfig_FEDEX_HOSTSSH,'',tvString);
  if(s<>'') then begin
    lUser := textoEntreTags(s,'','@');
    lPorta := textoEntreTags(s,':','');
    lHost := textoEntreTags(s,'@',':');
    fedex.parameters.portaSSH := StrToIntDef(lPorta,-1);
    fedex.parameters.hostSSH := lHost;
    fedex.parameters.usuarioSSH := lUser;
  end;

  fedex.parameters.senhaSSH := ValorTagConfig(tagConfig_FEDEX_SENHASSH,'',tvString);
  //ForceDirectories(fedex.parameters.diretorioLock);

  depositante := fedex.parameters.depositante;
  depositante.codigo := ValorTagConfig(tagConfig_FEDEX_DESPOSITANTE,'',tvString);
  depositante.cnpj := pCNPJ;
  depositante.nome := pRazaoSocial;
  fedex.parameters.depositante.auth.usuario := ValorTagConfig(tagConfig_FEDEX_AUTHUSER,'',tvString);
  fedex.parameters.depositante.auth.senha   := ValorTagConfig(tagConfig_FEDEX_AUTHSENHA,'',tvString);
  fedex.parameters.depositante.chave := ValorTagConfig(tagConfig_FEDEX_CHAVE,'',tvString);

  if(pCNPJ='') and assigned(gdbPadrao) then
    with gdbPadrao.criaDataset.query('select * from empresa','',[]) do begin
      depositante.cnpj := dataset.FieldByName('CNPJ_EMP').AsString;
      depositante.nome := dataset.FieldByName('RAZAO_EMP').AsString;
    end;

  Result := fedex;

end;

function criaControleAlteracoesFedex: IControleAlteracoes;
begin
  {$if not defined(MODO_HOMOLOGACAO)}
    Result := criaControleAlteracoes(SISTEMA_LOGISTICA_FEDEX_PRODUCAO);
  {$else}
    Result := criaControleAlteracoes(SISTEMA_LOGISTICA_FEDEX_HOMOLOGACAO);
  {$ifend}
end;

function fedex_PrecisaEnviarSKU;
  var
    ctr: IControleAlteracoes;
begin
  Result := false;
  if(pCodigo='') then
    exit;
  ctr := criaControleAlteracoesFedex;
  Result := ctr.getValor(CONTROLE_LOGISTICA_FEDEX_SKU,pCodigo)='';
end;

function getSKUList;
  var
    gdb: IGDB;
    save: Integer;
    lID, lQuery: String;
    datasets: TFedexDatasets;
    lSKU: IDataset;
begin
  checkResultadoOperacao(pResultado);
  Result := nil;
  try
    save := pResultado.erros;
    if(pID='') then
      pResultado.adicionaErro('getSKUList: Não especificou um Produto válido.');
    if(pAPI=nil) then
      pResultado.adicionaErro('getSKUList: Não especificou um API válido.');
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getSKUList: Não especificou um DB válido.');

    if(pResultado.erros<>save) then
      exit;

    datasets := getFedexDatasets;

    lQuery := 'select ' +
        '   p.codigo_pro id, p.barras_pro barras, p.peso_pro peso, p.codigo_gru grupo, ' +
        '   p.codigo_sub subgrupo, p.nome_pro nome ' +
        ' from produto p where p.codigo_pro=:id';

    lSKU := gdb.criaDataset.query(lQuery,'id', [pID]);

    if(lSKU.dataset.RecordCount=0) then begin
      pResultado.formataErro('getSKUList: Produto [%s] não existe.', [ pID ]);
      exit;
    end;

    atribuirRegistros(lSKU.dataset,datasets.sku.dataset);

    Result := pAPI.getSKUList(getXMLFromDataset(datasets.sku.dataset),false,pResultado);
  except
    on e: Exception do
      pResultado.formataErro('getSKUList: %s: %s', [ e.ClassName, e.Message ] );
  end;
end;

function getShipmentOrderList;
  var
    gdb: IGDB;
    save1,save2: Integer;
begin
  checkResultadoOperacao(pResultado);
  Result := nil;
  try
    save1 := pResultado.erros;
    if(pAPI=nil) then
      pResultado.adicionaErro('getPurchaseOrderList: Não especificou um API válido.');
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getPurchaseOrderList: Não especificou um DB válido.');

    if(pResultado.erros<>save1) then
      exit;

  except
    on e: Exception do
      pResultado.formataErro('getPurchaseOrderList: %s: %s', [ e.ClassName, e.Message ] );
  end;

end;

function getPurchaseOrderList;
  var
    gdb: IGDB;
    save1,save2: Integer;
    orders,items: IDataset;
    lFieldNames: String;
    lParameters: array of Variant;
    lID, lQuery: String;
    datasets: TFedexDatasets;
    lSKUList: TFedex_SKUList;
    ctr: IControleAlteracoes;
    lXMLDataList: IDicionarioSimples<TipoWideStringFramework, TipoWideStringFramework>;
begin
  checkResultadoOperacao(pResultado);
  Result := nil;
  try
    save1 := pResultado.erros;
    if(pAPI=nil) then
      pResultado.adicionaErro('getPurchaseOrderList: Não especificou um API válido.');
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getPurchaseOrderList: Não especificou um DB válido.');

    if(pResultado.erros<>save1) then
      exit;


    ctr := pAPI.parameters.controleAlteracoes;

    orders := gdb.criaDataset;
    items := gdb.criaDataset;

    lQuery := 'select p.id, cfop.cfop, fornecedor.cnpj_cpf_for fornecedor, p.datanota_ent data_movimento, ' +
            ' case when ( p.devolucao_pedido_id is null ) then ''E'' else ''D'' end operacao, ' +
            ' p.numero_ent numero_nfe, p.codigo_for,p.arq_nfe xml ' +
            ' from entrada p ' +
            ' left join cfop on cfop.id = p.cfop_id ' +
            ' left join fornecedor on fornecedor.codigo_for=p.codigo_for ';

    lID := pResultado.propriedade['id'].asString;
    SetLength(lParameters,0);
    lFieldNames := '';
    if(lID<>'') then begin
      lFieldNames := 'id';
      SetLength(lParameters,1);
      lParameters[0] := lID;
      lQuery := lQuery + ' where p.id=:id ';
    end else begin
      lQuery := lQuery + ' left join controlealteracoes c on c.sistema = :sistema and c.identificador = :identificador and c.chave = cast(p.id as varchar(22)) ' +
                ' where ( (c.id is null) or (coalesce(c.valor, '' '') in ( '''', '' '' )) ) ';
      SetLength(lParameters,2);
      lParameters[0] := ctr.sistema;
      lParameters[1] := CONTROLE_LOGISTICA_FEDEX_STATUS_PO;
      lFieldNames := 'sistema;identificador';
      //Usar controle alterações...
    end;

    orders.query(lQuery,lFieldNames,lParameters);

    datasets := getFedexDatasets;

    atribuirRegistros(orders.dataset,datasets.po.dataset);
    orders.query(lQuery,'',[]);

    orders.dataset.First;
    while not orders.dataset.Eof do begin

      lQuery := 'select ' + QuotedStr(orders.dataset.FieldByName('codigo_for').AsString) + ' id, ' +
        ' p.numero_ent, p.codigo_for, p.codigo_pro produto, p.quantidade_ent quantidade, ' +
        ' p.valoruni_ent unitario, produto.barras_pro barras ' +
        ' from entradaitens p ' +
        ' left join produto on produto.codigo_pro=p.codigo_pro ' +
        ' where p.numero_ent=:numero_ent and p.codigo_for = :codigo_for ';

      items.query(lQuery,'numero_ent;codigo_for', [ orders.dataset.FieldByName('numero_nfe').AsString, orders.dataset.FieldByName('codigo_for').AsString ]);
      save1 := pResultado.erros;

      while not items.dataset.eof do begin
        if Fedex_PrecisaEnviarSKU(items.dataset.FieldByName('produto').AsString) then begin
          save2 := pResultado.erros;
          lSKUList := getSKUList(pAPI,items.dataset.FieldByName('produto').AsString,pResultado);
          if(save2<>pResultado.erros) then
            exit;
          pAPI.sendSKUList(lSKUList,pResultado);
          //if(save2=pResultado.erros) then
          //  ctr.setValor(CONTROLE_LOGISTICA_FEDEX_SKU,items.dataset.FieldByName('produto').AsString,DateTimeToStr(Now));
        end;
        items.dataset.Next;
      end;
      items.dataset.First;
      if(pResultado.erros<>save1) then
        orders.dataset.Delete
      else
        atribuirRegistros(items.dataset,datasets.poItens.dataset);
      orders.dataset.Next;
    end;

    lXMLDataList := TListaSimplesCreator.CreateDictionary<TipoWideStringFramework,TipoWideStringFramework>;
    lXMLDataList.add('ordem',getXMLFromDataset(datasets.po.dataset));
    lXMLDataList.add('itens',getXMLFromDataset(datasets.poItens.dataset));

    Result := pAPI.getPurchaseOrderList(lXMLDataList,false,nil,pResultado);

    if(Result.count=0) then
      pResultado.adicionaAviso('getPurchaseOrderList: Não existem ordens de recebimento a enviar.');

  except
    on e: Exception do
      pResultado.formataErro('getPurchaseOrderList: %s: %s', [ e.ClassName, e.Message ] );
  end;

end;

end.
