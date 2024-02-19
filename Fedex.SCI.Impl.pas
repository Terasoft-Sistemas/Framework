
{$i definicoes.inc}

unit Fedex.SCI.Impl;

interface
  uses
    Terasoft.Framework.Types,
    Terasoft.Framework.Texto,
    Fedex.API.Iface;

  function criaFedexApiSCI(const pCNPJ: TipoWideStringFramework; const pRazaoSocial: TipoWideStringFramework): IFedexAPI;
  function getPurchaseOrderList(pAPI: IFedexAPI; pResultado: IResultadoOperacao = nil): TFedex_PurchaseOrderList;
  procedure test;

implementation
  uses
    Terasoft.Framework.DB,
    Terasoft.Framework.Lock,
    SysUtils,
    FuncoesConfig;

procedure test;
begin
  //
end;

function criaFedexApiSCI;
  var
    fedex: IFedexAPI;
    depositante: IFedexDepositante;
    lHost,lPorta,lUser: String;
    s: String;
begin
  fedex := createFedexAPI;
  fedex.parameters.modoProducao := false;//true;
  fedex.parameters.urlWS := ValorTagConfig(tagConfig_FEDEX_WEBSERVICE,'',tvString);

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

  Result := fedex;

end;

function getPurchaseOrderList;
  var
    gdb: IGDB;
    save: Integer;
    orders,items: IDataset;
    lID, lQuery: String;
    datasets: TPurchaseOrderDataset;
begin
  checkResultadoOperacao(pResultado);
  Result := nil;
  try
    save := pResultado.erros;
    if(pAPI=nil) then
      pResultado.adicionaErro('getPurchaseOrderList: Não especificou um API válido.');
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getPurchaseOrderList: Não especificou um DB válido.');

    if(pResultado.erros<>save) then
      exit;

    orders := gdb.criaDataset;
    items := gdb.criaDataset;

    lQuery := 'select p.id, cfop.cfop, fornecedor.cnpj_cpf_for fornecedor, p.datanota_ent data_movimento, ' +
            ' case when ( p.devolucao_pedido_id is null ) then ''E'' else ''D'' end operacao, ' +
            ' p.numero_ent numero_nfe, p.codigo_for ' +
            ' from entrada p ' +
            ' left join cfop on cfop.id = p.cfop_id ' +
            ' left join fornecedor on fornecedor.codigo_for=p.codigo_for ';

    orders.query(lQuery,'',[]);

    datasets := getPurchaseOrderDataset;

    atribuirRegistros(orders.dataset,datasets.po.dataset);
    orders.query(lQuery,'',[]);

    while not orders.dataset.Eof do begin
      lQuery := 'select ' + QuotedStr(orders.dataset.FieldByName('codigo_for').AsString) + ' id, ' +
        ' p.numero_ent, p.codigo_for, p.codigo_pro produto, p.quantidade_ent quantidade, ' +
        ' p.valoruni_ent unitario, produto.barras_pro barras ' +
        ' from entradaitens p ' +
        ' left join produto on produto.codigo_pro=p.codigo_pro ' +
        ' where p.numero_ent=:numero_ent and p.codigo_for = :codigo_for ';

      items.query(lQuery,'numero_ent;codigo_for', [ orders.dataset.FieldByName('codigo_for').AsString, orders.dataset.FieldByName('codigo_for').AsString ]);
      atribuirRegistros(items.dataset,datasets.poItens.dataset);
      orders.dataset.Next;
    end;


//    orders.query('select id, cfop, fornecedor,
      //data_movimento, xml, operacao, numero_nfe from entrada','',[]);


  except
    on e: Exception do
      pResultado.formataErro('getPurchaseOrderList: %s: %s', [ e.ClassName, e.Message ] );
  end;
end;

end.
