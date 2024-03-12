
{$i Fedex_API.inc}

unit Fedex.SCI.Impl;

interface
  uses
    Classes,
    Terasoft.Framework.Types,
    Terasoft.Framework.Texto,
    Terasoft.Framework.ControleAlteracoes,
    Fedex.API.Iface;

  {$if not defined(__RELEASE__)}
    function testaFedexAPISOSCI(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function testaFedexAPIPOSCI(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
    function testaRetornoSCI(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  {$endif}

implementation
  uses
    Terasoft.Framework.DB,
    FuncoesMensagem,
    DB,
    Terasoft.Framework.FuncoesDiversas,
    Spring.Collections,
    Terasoft.Framework.Validacoes,
    Terasoft.Framework.DB.FIBPlus,
    Terasoft.Framework.Lock,
    Terasoft.Framework.ListaSimples.Impl,
    Terasoft.Framework.ListaSimples,
    SysUtils,
    FuncoesConfig, Terasoft.Framework.Logistica;

    type
      TLogisticaFedex = class(TInterfacedObject, ILogistica)
      protected
        function fedex_SCI_GetPurchaseOrderList(pResultado: IResultadoOperacao = nil): TFedex_PurchaseOrderList;
        function fedex_SCI_GetShipmentOrderList(pResultado: IResultadoOperacao = nil): TFedex_ShipmentOrderList;
        function fedex_SCI_GetSKUList(pCodigoPro: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): TFedex_SKUList;
        function fedex_SCI_criaAPI(const pCNPJ: TipoWideStringFramework = ''; const pRazaoSocial: TipoWideStringFramework = ''): IFedexAPI;
        function criaControleAlteracoes: IControleAlteracoes;

      protected
        fAPI: IFedexAPI;

        function precisaEnviarProduto(const pCodigoPro: TipoWideStringFramework): boolean;
        function enviaProduto(pID: String = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
        function getStatusProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;
        procedure setStatusProduto(const pCodigoPro: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
        function getResultadoProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;

        function precisaEnviarEntrada(const pID: TipoWideStringFramework): boolean;
        function getStatusEntrada(const pID: TipoWideStringFramework): TipoWideStringFramework;
        procedure setStatusEntrada(const pID: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
        function getResultadoEntrada(const pID: TipoWideStringFramework): TipoWideStringFramework;
        function entradaFinalizada(const pID: TipoWideStringFramework): boolean;

        function precisaEnviarVenda(const pNumeroPed: TipoWideStringFramework): boolean;
        function getStatusVenda(const pNumeroPed: TipoWideStringFramework): TipoWideStringFramework;
        procedure setStatusVenda(const pNumeroPed: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
        function getResultadoVenda(const pNumeroPed: TipoWideStringFramework): TipoWideStringFramework;
        function vendaFinalizada(const pNumeroPed: TipoWideStringFramework): boolean;

        function getControleAlteracoes: IControleAlteracoes;
        procedure setControleAlteracoes(const pValue: IControleAlteracoes);

        function enviaVenda(pNumeroPed: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
        function enviaEntrada(pID: String = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
        function processaRetorno(pResultado: IResultadoOperacao = nil): IResultadoOperacao;

        function getVersao: TipoWideStringFramework;
        function getCompilacao: Int64;
        procedure setAPI(const pValue: IUnknown);
        function getAPI: IUnknown;

        constructor Create(const pCNPJ: TipoWideStringFramework = ''; const pRazaoSocial: TipoWideStringFramework = '');
      end;

{$if not defined(__RELEASE__)}
function testaFedexAPIPOSCI;
  var
    p: ILogistica;
begin
  Result := checkResultadoOperacao(pResultado);
  p := TLogisticaFedex.Create;
  Result := p.enviaEntrada('',Result);
  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;

function testaRetornoSCI;
  var
    p: ILogistica;
begin
  p := TLogisticaFedex.Create;
  Result := p.processaRetorno(checkResultadoOperacao(pResultado));
  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;

function testaFedexAPISOSCI;
  var
    p: ILogistica;
begin
  Result := checkResultadoOperacao(pResultado);
  p := TLogisticaFedex.Create;
  Result := p.enviaVenda('',Result);
  if(pResultado.eventos>0) then
    msgAviso(pResultado.toString);
end;
{$endif}

{$REGION 'processaArquivoExpedicao'}
function processaArquivoExpedicao(pUnkAPI: IUnknown; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    lArquivo,lPedido,lProduto,lIMEI: String;
    lTexto, lLinha: IListaTexto;
    lTmp: TipoWideStringFramework;
    ctr: IControleAlteracoes;
    lDivergencias, lSave: Integer;
    lDSEntrada,lDSItens,lDSIMEI: IDataset;
    lCancelamento: boolean;
    lLista: IDicionarioSimples<TipoWideStringFramework,IListaString>;
    lListaIMEIS: IListaString;
    i: Integer;
    lCDS: TDataset;
    lFieldQtde: TField;
    pAPI: IFedexAPI;

begin
  Result := checkResultadoOperacao(pResultado);
  lSave := pResultado.erros;
  lDSEntrada := nil;
  lDSItens := nil;
  lCDS := nil;
  lLista := TListaSimplesCreator.CreateDictionary<TipoWideStringFramework,IListaString>;
  try
    if not Supports(pUnkAPI, IFedexAPI, pAPI) then begin
      pResultado.adicionaErro('processaArquivoExpedicao: API não definida.');
      exit;
    end;

    if(gdbPadrao=nil)or(gdbPadrao.conectado=false) then begin
      pResultado.adicionaErro('processaArquivoExpedicao: GDB não definido.');
      exit;
    end;

    ctr := pAPI.parameters.controleAlteracoes;
    if(ctr=nil) then begin
      pResultado.adicionaErro('processaArquivoExpedicao: Controle de alterações não definido.');
      exit;
    end;

    lArquivo := pResultado.propriedade['ARQUIVO'].asString;
    if (lArquivo='') or not FileExists(lArquivo) then begin
      pResultado.formataErro('processaArquivoExpedicao: arquivo [%s] não existe.', [lArquivo]);
      pResultado.acumulador['Saidas rejeitadas'].incrementa;
      rejeitarArquivoFedex(true,pResultado);
      exit;
    end;
    if (pAPI=nil) or (pAPI.parameters.depositante.cnpj='') then begin
      pResultado.formataErro('processaArquivoExpedicao: Não especificou um API/DEPOSITANTE válido.', [lArquivo]);
      exit;
    end;

    lTexto := novaListaTexto;
    lLinha := novaListaTexto;
    lLinha.strings.Delimiter := '|';
    lTexto.strings.LoadFromFile(lArquivo);
    for i := 0 to lTexto.lines.Count - 1 do begin
      lLinha.strings.DelimitedText := lTexto.strings.Strings[i];
      lLinha.strings.DelimitedText := lTexto.strings.Strings[i];
      if(i=0) then begin
        lCancelamento:=UpperCase(ChangeFileExt(ExtractFileName(lArquivo),''))=UpperCase(lLinha.strings.Strings[0]);
        if(lCancelamento) then begin
         if(lPedido='') then
            lPedido := textoEntreTags(lLinha.strings.Strings[0],'_','_');
          break;
        end;
      end;

      if(lLinha.strings.Count < 5 ) then begin
        pResultado.formataErro('processaArquivoExpedicao [%s]: Registro %d não possui 5 campos especificados: %d', [ lArquivo, (i + 1), lLinha.strings.Count ] );
        continue;
      end;

      if(lPedido='') then begin
        lPedido := lLinha.strings.Strings[0];
        if (lPedido='') or(Length(lPedido)>6) then begin
          pResultado.formataErro('processaArquivoExpedicao [%s]: Número de pedido inválido: %s', [ lArquivo, lPedido ] );
          break;
        end;
        lDSEntrada := gdbPadrao.criaDataset.query( 'select p.numero_ped id, p.* from pedidovenda p where p.numero_ped=:id', 'id', [ lPedido ]);
        if(lDSEntrada.dataset.RecordCount=0) then begin
          pResultado.formataErro('processaArquivoExpedicao [%s]: Pedido [%s] não existe.', [ lArquivo, lPedido ] );
          break;
        end else if(ctr.getValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SO, lDSEntrada.dataset.FieldByName('id').AsString,'')<>CONTROLE_LOGISTICA_STATUS_ENVIADO) then begin
          pResultado.formataErro('processaArquivoExpedicao [%s]: Pedido [%s] não está no status ENVIADO: [%s]', [ lArquivo, lPedido, ctr.getValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SO, lDSEntrada.dataset.FieldByName('id').AsString,'') ] );
          break;
        end;

        if(lDSItens=nil) then begin
          lDSItens := gdbPadrao.criaDataset.query('select p.id id_item, p.numero_ped id, p.codigo_pro produto_id, p.quantidade_ped quantidade, 0 as quantidade_atendida from pedidoitens p ' +
                                             ' where p.numero_ped = :id order by 1 ', 'id', [ lPedido ] );
          if(lDSItens.dataset.RecordCount = 0 ) then begin
            pResultado.formataErro('processaArquivoExpedicao: Pedido [%s]: Não possui itens na tabela de itens', [ lPedido ] );
            break;
          end;
          lCDS := getCDSDataset(lDSItens.dataset);
          lFieldQtde := lCDS.FindField('quantidade_atendida');
        end;
        if (lCDS = nil) or (lFieldQtde=nil) then begin
          result.formataErro('processaArquivoExpedicao [%s]: Não possui itens na tabela de itens', [ lPedido ] );
          break;
        end;
      end;
      lProduto := textoEntreTags(lLinha.strings.Strings[3],'','_');
      if(lProduto='') then
        lProduto := lLinha.strings.Strings[3];

      lIMEI    := lLinha.strings.Strings[4];
      if not validaIMEI(lIMEI) then begin
        pResultado.formataErro('processaArquivoExpedicao [%s]: IMEI [%s] inválido para item %d', [ lArquivo, lIMEI, i ] );
        continue;
      end;
      if not lLista.get(lProduto,lListaIMEIS) then begin
        lListaIMEIS := getStringList;
        lLista.add(lProduto,lListaIMEIS);
      end;
      lListaIMEIS.Add(lIMEI);

      lCDS.First;
      while not lCDS.eof do begin
        if(lCDS.FieldByName('produto_id').AsString = lProduto) then begin
          lCDS.Edit;
          lFieldQtde.AsCurrency := lFieldQtde.AsCurrency + 1.0;
          lCDS.CheckBrowseMode;
          break;
        end;
        lCDS.Next;
      end;
      if(lCDS.Eof) then begin
        pResultado.formataErro('processaArquivoExpedicao Pedido[%s]: Não localizou o produto [%s]', [ lPedido, lProduto ] );
        result.formataAviso('Pedido [%s] marcado como DIVERGENTE', [ lPedido ] );
        divergenciaArquivoFedex(true,pResultado);
        ctr.setValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SO, lPedido, CONTROLE_LOGISTICA_STATUS_DIVERGENTE);
        pResultado.acumulador['Pedidos divergentes'].incrementa;
        exit;
      end;
    end;

    if(lCDS<>nil) then begin
      lDivergencias := 0;
      lCDS.First;
      while not lCDS.Eof do begin
        gdbPadrao.updateDB('pedidoitens', [ 'id' ], [ lCDS.FieldByName('id_item').AsInteger ], [ 'quantidade_atendida'], [ lFieldQtde.AsInteger ] );
        if(lFieldQtde.AsInteger <> lCDS.FieldByName('quantidade').AsInteger) then begin
          result.formataErro('processaArquivoExpedicao: Pedido [%s], Produto[%s] divergente na quantidade: Vendida: %d, Atendida: %d',
          [ lPedido, lCDS.FieldByName('produto_id').AsString, lCDS.FieldByName('quantidade').AsInteger, lCDS.FieldByName('quantidade_atendida').AsInteger ] );
          inc(lDivergencias);
        end;
        lCDS.Next;
      end;
      gdbPadrao.commit(true);
    end;
    if(lDivergencias>0) then begin
      divergenciaArquivoFedex(true,pResultado);
      pResultado.formataAviso('Pedido [%s] marcado como DIVERGENTE', [ lPedido ] );
      ctr.setValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SO, lPedido, CONTROLE_LOGISTICA_STATUS_DIVERGENTE);
      result.acumulador['Pedidos divergentes'].incrementa;
      exit;
    end;

    if(pResultado.erros<>lSave) then begin
      rejeitarArquivoFedex(true,pResultado);
      pResultado.acumulador['Saidas rejeitadas'].incrementa;
      exit;
    end;

    try
      lDSIMEI := gdbPadrao.criaDataset;
      lCDS.First;
      while not lCDS.eof do begin
        lProduto := lCDS.FieldByName('produto_id').AsString;
        if not lLista.get(lProduto,lListaIMEIS) then begin
          pResultado.formataErro('processaArquivoExpedicao [%s]: Produto [%s] não possui IMEI de retorno', [ lArquivo, lProduto ] );
          lDSItens.dataset.Next;
          continue;
        end;
        for lTmp in lListaIMEIS do begin
          gdbPadrao.insereDB('movimento_serial',
              ['tipo_serial','numero','produto','tipo_documento','id_documento'],
              ['I',lTmp,lProduto,'P',lPedido]);
        end;

        lCDS.Next;
      end;
      gdbPadrao.commit(true);
      ctr.setValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SO, lPedido,CONTROLE_LOGISTICA_STATUS_FINALIZADO);
      apagarArquivoFedex(false,pResultado);
    finally
      gdbPadrao.rollback(true);
    end;

  except
    on e: Exception do begin
      pResultado.formataErro('processaArquivoExpedicao: %s: %s', [ e.ClassName, e.Message ] );
      pResultado.acumulador['Saidas com problemas'].incrementa;
    end;
  end;
end;

{$ENDREGION}

{$REGION 'processaArquivoRecebimento'}
function processaArquivoRecebimento(pUnkAPI: IUnknown; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    lIMEI,lProduto, lArquivo, lNF, lCNPJ: String;
    lTmp: TipoWideStringFramework;
    lTexto,lLinha: IListaTexto;
    i: Integer;
    lSave: Integer;
    lTransferencia: boolean;
    lDSIMEI, lDSFornecedor, lDSEntrada, lDSItens: IDataset;
    ctr: IControleAlteracoes;
    lLista: IDicionarioSimples<TipoWideStringFramework,IListaString>;
    lListaIMEIS: IListaString;
    pAPI: IFedexAPI;
begin
  //processamento entrada

  Result := checkResultadoOperacao(pResultado);
  lSave := pResultado.erros;
  lLista := TListaSimplesCreator.CreateDictionary<TipoWideStringFramework,IListaString>;
  try
    if not Supports(pUnkAPI,IFedexAPI, pAPI) then begin
      pResultado.adicionaErro('processaArquivoRecebimento: API não definida.');
      exit;
    end;
    if(gdbPadrao=nil)or(gdbPadrao.conectado=false) then begin
      pResultado.adicionaErro('processaArquivoRecebimento: GDB não definido.');
      exit;
    end;
    lArquivo := pResultado.propriedade['ARQUIVO'].asString;
    if (lArquivo='') or not FileExists(lArquivo) then begin
      pResultado.formataErro('processaArquivoRecebimento: arquivo [%s] não existe.', [lArquivo]);
      pResultado.acumulador['Entradas rejeitadas'].incrementa;
      rejeitarArquivoFedex(true,pResultado);
      exit;
    end;
    if (pAPI=nil) or (pAPI.parameters.depositante.cnpj='') then begin
      pResultado.formataErro('processaArquivoRecebimento: Não especificou um API/DEPOSITANTE válido.', [lArquivo]);
      exit;
    end;
    ctr := pAPI.parameters.controleAlteracoes;
    if(ctr=nil) then begin
      pResultado.adicionaErro('processaArquivoRecebimento: Controle de alterações não definido.');
      exit;
    end;

    lTexto := novaListaTexto;
    lLinha := novaListaTexto;
    lLinha.strings.Delimiter := '|';
    lTexto.strings.LoadFromFile(lArquivo);

    lNF := '';
    lCNPJ := '';

    if(lTexto.lines.Count<1) then begin
      pResultado.formataErro('processaArquivoRecebimento: arquivo [%s] não possui dados validos.', [lArquivo]);
      pResultado.acumulador['Entradas rejeitadas'].incrementa;
      rejeitarArquivoFedex(true,pResultado);
      exit;
    end;

    for i := 0 to lTexto.lines.Count - 1 do begin
      lLinha.strings.DelimitedText := lTexto.strings.Strings[i];
      if(lLinha.strings.Count < 4 ) then begin
        pResultado.formataErro('processaArquivoRecebimento [%s]: Registro %d não possui 4 campos especificados: %d', [ lArquivo, (i + 1), lLinha.strings.Count ] )
      end;
      if(lNF='') then
        lNF := lLinha.strings.Strings[0];
      if(lCNPJ='') then
        lCNPJ    := lLinha.strings.Strings[1];

      if(lNF<>lLinha.strings.Strings[0]) then
        pResultado.formataErro('processaArquivoRecebimento [%s]: Registro %d não possui Número de NF igual ao início: [%s] e [%s]', [ lArquivo, (i + 1), lNF, lLinha.strings.Strings[0] ] );

      if(lCNPJ<>lLinha.strings.Strings[1]) then begin
        pResultado.formataErro('processaArquivoRecebimento [%s]: Registro %d não possui CNPJ igual ao início: [%s] e [%s]', [ lArquivo, (i + 1), lCNPJ, lLinha.strings.Strings[1] ] )
      end;

      lProduto := textoEntreTags(lLinha.strings.Strings[2],'','_');

      if(lProduto='') then
        lProduto := lLinha.strings.Strings[2];

      lIMEI    := lLinha.strings.Strings[3];
      if not validaIMEI(lIMEI) then begin
        pResultado.formataErro('processaArquivoRecebimento [%s]: IMEI [%s] inválido para item %d', [ lArquivo, lIMEI, i ] );
        continue;
      end;

      if not lLista.get(lProduto,lListaIMEIS) then begin
        lListaIMEIS := getStringList;
        lLista.add(lProduto,lListaIMEIS);
      end;
      lListaIMEIS.Add(lIMEI);

    end;
    if(pResultado.erros<>lSave) then begin
      rejeitarArquivoFedex(true,pResultado);
      pResultado.acumulador['Entradas rejeitadas'].incrementa;
      exit;
    end;

    lTransferencia := (copy(lCNPJ,1,8) = copy(pAPI.parameters.depositante.cnpj,1,8)) and (lCNPJ<>pAPI.parameters.depositante.cnpj);

    lDSIMEI := gdbPadrao.criaDataset;

    lDSFornecedor := gdbPadrao.criaDataset.query('select f.id, f.codigo_for from fornecedor f where f.cnpj_cpf_for = :cnpj',
      'cnpj', [ lCNPJ ] );

    if(lDSFornecedor.dataset.RecordCount=0) then begin
      pResultado.formataErro('processaArquivoRecebimento [%s]: Fornecedor [%s] não existe', [ lArquivo, lCNPJ ] );
      rejeitarArquivoFedex(true,pResultado);
      pResultado.acumulador['Entradas rejeitadas'].incrementa;
      exit;
    end;

    lDSEntrada := gdbPadrao.criaDataset.query('select e.* from entrada e ' +
            ' where e.codigo_for = :fornecedor and e.numero_ent =:numero ',

            'fornecedor;numero', [ lDSFornecedor.fieldByName('codigo_for').AsString, lNF ] );

    if(lDSEntrada.dataset.RecordCount=0) then begin
      pResultado.formataErro('processaArquivoRecebimento: NF [%s] do Fornecedor [%s] não existe ou já foi processada',
        [ lNF, lCNPJ ] );
      pResultado.propriedade['ACAO_ARQUIVO'].asString := FEDEX_ACAOARQUIVO_REJEITAR;
      result.acumulador['Entradas rejeitadas'].incrementa;
      exit;
    end else if(ctr.getValor(CONTROLE_LOGISTICA_FEDEX_STATUS_PO, lDSEntrada.dataset.FieldByName('id').AsString,'')<>CONTROLE_LOGISTICA_STATUS_ENVIADO) then begin
      pResultado.acumulador['Entradas divergentes'].incrementa;
      rejeitarArquivoFedex(true,pResultado);
      exit;
    end;

    lDSItens := gdbPadrao.criaDataset.query('select e.* from entradaitens e ' +
        ' where e.codigo_for = :fornecedor and e.numero_ent =:numero ', 'fornecedor;numero', [ lDSFornecedor.fieldByName('codigo_for').AsString, lNF]);

    if(lDSItens.dataset.RecordCount=0) then begin
      pResultado.acumulador['Entradas divergentes'].incrementa;
      rejeitarArquivoFedex(true,pResultado);
      exit;
    end;

    try

      while not lDSItens.dataset.eof do begin
        lProduto := lDSItens.dataset.FieldByName('codigo_pro').AsString;;

        if not lLista.get(lProduto,lListaIMEIS) then begin
          pResultado.formataErro('processaArquivoRecebimento [%s]: Produto [%s] não possui IMEI de retorno', [ lArquivo, lProduto ] );
          lDSItens.dataset.Next;
          continue;
        end;
        if(lDSItens.fieldByName('QUANTIDADE_ENT').AsFloat <> lListaIMEIS.Count) then begin
          pResultado.formataErro('processaArquivoRecebimento [%s]: Produto [%s] não possui IMEI suficientes na entrada: %d', [ lArquivo, lProduto, lListaIMEIS.Count ] );
          lDSItens.dataset.Next;
          continue;
        end;
        for lTmp in lListaIMEIS do begin
          gdbPadrao.insereDB('movimento_serial',
              ['tipo_serial','numero','produto','tipo_documento','id_documento'],
              ['I',lTmp,lProduto,'E',lDSEntrada.fieldByName('id').AsString]);
        end;
        lDSItens.dataset.Next;
      end;

      if(pResultado.erros<>lSave) then begin
        rejeitarArquivoFedex(true,pResultado);
        pResultado.acumulador['Entradas rejeitadas'].incrementa;
        exit;
      end;
      gdbPadrao.commit(true);
      ctr.setValor(CONTROLE_LOGISTICA_FEDEX_STATUS_PO, lDSEntrada.dataset.FieldByName('id').AsString,CONTROLE_LOGISTICA_STATUS_FINALIZADO);
      apagarArquivoFedex(false,pResultado);
    finally
      gdbPadrao.rollback(true);
    end;

{
    for i := 0 to lTexto.strings.Count-1 do begin
      lLinha.strings.DelimitedText := lTexto.strings.Strings[i];
      lProduto := textoEntreTags(lLinha.strings.Strings[2],'','_');

      if(lProduto='') then
        lProduto := lLinha.strings.Strings[2];

      lIMEI    := lLinha.strings.Strings[3];
      if not validaIMEI(lIMEI) then begin
        pResultado.formataErro('processaArquivoRecebimento [%s]: IMEI [%s] inválido para item %d', [ lArquivo, lIMEI, i ] );
        continue;
      end;

      if not lLista.get(lProduto,lListaIMEIS) then begin
        lListaIMEIS := getStringList;
        lLista.add(lProduto,lListaIMEIS);
      end;
      lListaIMEIS.Add(lIMEI);
    end;
    if(lSave<>pResultado.erros) then begin
      pResultado.acumulador['Entradas rejeitadas'].incrementa;
      rejeitarArquivoFedex(true,pResultado);
      exit;
    end;
}

  except
    on e: Exception do begin
      pResultado.formataErro('processaArquivoRecebimento: %s: %s', [ e.ClassName, e.Message ] );
      pResultado.acumulador['Entradas com problemas'].incrementa;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'SCI'}
function TLogisticaFedex.fedex_SCI_criaAPI;
  var
    fedex: IFedexAPI;
    depositante: IFedexDepositante;
    lHost,lPorta,lUser: String;
    s: String;
begin
  Result := nil;
  if not sci_logistica_usa_fedex then
    exit;
  fedex := createFedexAPI;

  fedex.setProcessador('S',processaArquivoExpedicao);
  fedex.setProcessador('R',processaArquivoRecebimento);

  {$if not defined(MODO_HOMOLOGACAO)}
    fedex.parameters.modoProducao := true;//true;
  {$else}
    fedex.parameters.modoProducao := true;//true;
  {$endif}
  fedex.parameters.controleAlteracoes := criaControleAlteracoes;
  fedex.parameters.urlWS := ValorTagConfig(tagConfig_FEDEX_WEBSERVICE,'',tvString);
  if(fedex.parameters.urlWS='') then
      fedex.parameters.urlWS :=
          {$if not defined(MODO_HOMOLOGACAO)}
            URLPRODUCAOFEDEX
          {$else}
            URLHOMOLOGACAOFEDEX
          {$endif}
      ;
  fedex.parameters.diretorioLock := {$if defined(__RELEASE__)} getDiretorioLock {$else} 'c:\temp\lock'{$endif};
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

function TLogisticaFedex.criaControleAlteracoes: IControleAlteracoes;
begin
  {$if not defined(MODO_HOMOLOGACAO)}
    Result := Terasoft.Framework.ControleAlteracoes.criaControleAlteracoes(SISTEMA_LOGISTICA_FEDEX_PRODUCAO);
  {$else}
    Result := Terasoft.Framework.ControleAlteracoes.criaControleAlteracoes(SISTEMA_LOGISTICA_FEDEX_HOMOLOGACAO);
  {$endif}
end;

function TLogisticaFedex.getControleAlteracoes: IControleAlteracoes;
begin
  Result := fAPI.parameters.controleAlteracoes;
end;

function TLogisticaFedex.precisaEnviarVenda(const pNumeroPed: TipoWideStringFramework): boolean;
begin
  Result := false;
  if(pNumeroPed='') then
    exit;
  Result := getStatusVenda(pNumeroPed)=CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO;
end;

function TLogisticaFedex.precisaEnviarEntrada;
begin
  Result := false;
  if(pID='') then
    exit;
  Result := getStatusEntrada(pID)=CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO;
end;

function TLogisticaFedex.fedex_SCI_GetSKUList;
  var
    gdb: IGDB;
    save: Integer;
    lID, lQuery: String;
    datasets: TFedexDatasets;
    lSKU: IDataset;
begin
  checkResultadoOperacao(pResultado);
  Result := nil;
  if not sci_logistica_usa_fedex then begin
    pResultado.adicionaErro('getPurchaseOrderList: Não utiliza fedex na Logística.');
    exit;
  end;

  try
    save := pResultado.erros;
    if(pCodigoPro='') then
      pResultado.adicionaErro('getSKUList: Não especificou um Produto válido.');
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

    lSKU := gdb.criaDataset.query(lQuery,'id', [pCodigoPro]);

    if(lSKU.dataset.RecordCount=0) then begin
      pResultado.formataErro('getSKUList: Produto [%s] não existe.', [ pCodigoPro ]);
      exit;
    end;

    atribuirRegistros(lSKU.dataset,datasets.sku.dataset);

    Result := fAPI.getSKUList(getXMLFromDataset(datasets.sku.dataset),false,pResultado);
    if(Result=nil) or (Result.count=0) then
      pResultado.formataErro('getSKUList: Produto [%s] não existe.', [ pCodigoPro ]);
  except
    on e: Exception do
      pResultado.formataErro('getSKUList: %s: %s', [ e.ClassName, e.Message ] );
  end;
end;

function TLogisticaFedex.fedex_SCI_GetShipmentOrderList;
  var
    gdb: IGDB;
    save1,save2: Integer;
    ctr: IControleAlteracoes;
    orders,items,cliente,transportador: IDataset;
    lTmp: String;
    lID, lQuery: String;
    lFieldNames: String;
    lParameters: array of Variant;
    datasets: TFedexDatasets;
    lXMLDataList: IDicionarioSimples<TipoWideStringFramework, TipoWideStringFramework>;
    lSKUList: TFedex_SKUList;
begin
  checkResultadoOperacao(pResultado);
  Result := nil;
  if not sci_logistica_usa_fedex then begin
    pResultado.adicionaErro('getPurchaseOrderList: Não utiliza fedex na Logística.');
    exit;
  end;

  try
    save1 := pResultado.erros;
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getShipmentOrderList: Não especificou um DB válido.');

    if(pResultado.erros<>save1) then
      exit;

    ctr := fAPI.parameters.controleAlteracoes;
    orders := gdb.criaDataset;
    items := gdb.criaDataset;
    cliente := gdb.criaDataset;
    transportador := gdb.criaDataset;

    lQuery := 'select p.numero_ped id, p.data_ped data_emissao, p.total_ped valor_total, c.cnpj_cpf_cli cnpj_cpf, ' +
              ' t.cnpj_cpf_tra transportador, p.codigo_cli cliente_codigo, p.televenda_ped transportadora_codigo ' +
//            ' case when ( p.devolucao_pedido_id is null ) then ''E'' else ''D'' end operacao, ' +
//            ' p.numero_ent numero_nfe, p.codigo_for,p.arq_nfe xml ' +
            ' from pedidovenda p ' +
            ' left join clientes c on c.codigo_cli = p.codigo_cli ' +
            ' left join transportadora t on t.codigo_tra = p.televenda_ped ';

    lID := pResultado.propriedade['id'].asString;
    SetLength(lParameters,0);
    lFieldNames := '';
    if(lID<>'') then begin
      //Saida específica
      lFieldNames := 'numero_ped';
      SetLength(lParameters,1);
      lParameters[0] := lID;
      lQuery := lQuery + ' where p.numero_ped=:numero_ped ';
    end else begin
// Listar saidas que não estão no controle e precisam enviar
      lQuery := lQuery + ' left join controlealteracoes ca on ca.sistema = :sistema and ca.identificador = :identificador and ca.chave = p.numero_ped ' +
                ' where ca.valor = :status ';
      SetLength(lParameters,3);
      lParameters[0] := ctr.sistema;
      lParameters[1] := CONTROLE_LOGISTICA_FEDEX_STATUS_SO;
      lParameters[2] := CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO;
      lFieldNames := 'sistema;identificador;status';
      lQuery := lQuery + ' order by 1 ';
    end;

    orders.query(lQuery,lFieldNames,lParameters);

    datasets := getFedexDatasets;

    atribuirRegistros(orders.dataset,datasets.so.dataset);

    datasets.so.dataset.First;
    while not datasets.so.dataset.Eof do begin

      save1 := pResultado.erros;

      cliente.query('select p.cnpj_cpf_cli cnpj_cpf, p.razao_cli razao_social, p.fantasia_cli fantasia, ' +
          ' p.endereco_cli endereco, p.numero_end numero, p.complemento complemento, p.cidade_cli cidade, ' +
          ' p.uf_cli uf, p.cep_cli cep ' +
          ' from clientes p ' +
          ' where p.codigo_cli = :cliente ', 'cliente', [datasets.so.dataset.FieldByName('cliente_codigo').AsString]);

      if(cliente.dataset.RecordCount=0) then begin
        pResultado.formataErro('getShipmentOrderList: Pedido [%s] não possui um cliente válido.', [ datasets.so.dataset.FieldByName('id').AsString ] );
        break;
      end;

      if not datasets.cliente.dataset.Locate('cnpj_cpf', cliente.dataset.FieldByName('cnpj_cpf').AsString, []) then
        atribuirRegistros(cliente.dataset, datasets.cliente.dataset);

      lTmp := datasets.so.dataset.FieldByName('transportadora_codigo').AsString;
      if(lTmp='') then
        lTmp := ValorTagConfig(tagConfig_LOGISTICA_TRANSPORTADOR_PADRAO,'',tvString);

      transportador.query(' select p.cnpj_cpf_tra cnpj_cpf, p.razao_tra razao_social, ' +
          ' p.fantasia_tra fantasia, p.endereco_tra endereco, p.numero_end numero, p.complemento complemento, ' +
          ' p.cidade_tra cidade, p.uf_tra uf, p.cep_tra cep,''BR'' PAIS, p.telefone_tra telefone ' +
          ' from transportadora p ' +
          ' where p.codigo_tra = :id ', 'id', [lTmp]);

      if( transportador.dataset.RecordCount=0) then begin
        pResultado.formataErro('getShipmentOrderList: Pedido [%s] não possui um transportador válido.', [ datasets.so.dataset.FieldByName('id').AsString ] );
        break;
      end;

      if not datasets.transportador.dataset.Locate('cnpj_cpf', transportador.dataset.FieldByName('cnpj_cpf').AsString, []) then
        atribuirRegistros(transportador.dataset, datasets.transportador.dataset);

      lQuery := 'select p.numero_ped id, id item, p.codigo_pro produto_id, p.quantidade_ped quantidade ' +
        ' from pedidoitens p ' +
        ' where p.numero_ped=:id ';

      items.query(lQuery,'id', [ datasets.so.dataset.FieldByName('id').AsString ]);

      while not items.dataset.eof do begin
        if precisaEnviarProduto(items.dataset.FieldByName('produto_id').AsString) then begin
          save2 := pResultado.erros;
          fAPI.parameters.modoProducao := true;
          lSKUList := fedex_SCI_GetSKUList(items.dataset.FieldByName('produto_id').AsString,pResultado);
          if(save2=pResultado.erros) then
            fAPI.sendSKUList(lSKUList,pResultado);
        end;
        items.dataset.Next;
      end;
      items.dataset.First;
      if(items.dataset.RecordCount=0) or (pResultado.erros<>save1) then
        datasets.so.dataset.Delete
      else
        atribuirRegistros(items.dataset,datasets.soItens.dataset);
      datasets.so.dataset.Next;
    end;

    lXMLDataList := TListaSimplesCreator.CreateDictionary<TipoWideStringFramework,TipoWideStringFramework>;
    lXMLDataList.add('ordem',datasets.so.getXML);
    lXMLDataList.add('itens',datasets.soItens.getXML);
    lXMLDataList.add('cliente',datasets.cliente.getXML);
    lXMLDataList.add('transportador',datasets.transportador.getXML);
    Result := fAPI.getShipmentOrderList(lXMLDataList,FEDEX_PRIORIDADE_MEDIA,true,nil,pResultado);

    if (Result=nil) or (Result.count=0) then
      pResultado.adicionaAviso('getShipmentOrderList: Não existem ordens de envio.');

  except
    on e: Exception do
      pResultado.formataErro('getShipmentOrderList: %s: %s', [ e.ClassName, e.Message ] );
  end;

end;

function TLogisticaFedex.fedex_SCI_GetPurchaseOrderList;
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

  if not sci_logistica_usa_fedex then begin
    pResultado.adicionaErro('getPurchaseOrderList: Não utiliza fedex na Logística.');
    exit;
  end;

  try
    save1 := pResultado.erros;
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getPurchaseOrderList: Não especificou um DB válido.');

    if(pResultado.erros<>save1) then
      exit;

    ctr := fAPI.parameters.controleAlteracoes;

    orders := gdb.criaDataset;
    items := gdb.criaDataset;

    lQuery := 'select cast(p.id as varchar(30)) id, cfop.cfop, fornecedor.cnpj_cpf_for fornecedor, p.datanota_ent data_movimento, ' +
            ' case when ( p.devolucao_pedido_id is null ) then ''E'' else ''D'' end operacao, ' +
            ' p.numero_ent numero_nfe, p.codigo_for,p.arq_nfe xml ' +
            ' from entrada p ' +
            ' left join cfop on cfop.id = p.cfop_id ' +
            ' left join fornecedor on fornecedor.codigo_for=p.codigo_for ';

    lID := pResultado.propriedade['id'].asString;
    SetLength(lParameters,0);
    lFieldNames := '';
    if(lID<>'') then begin
      //Entrada específica
      lFieldNames := 'id';
      SetLength(lParameters,1);
      lParameters[0] := lID;
      lQuery := lQuery + ' where p.id=:id ';
    end else begin
      //Listar entradas que não estão no controle ou STATUS nulo ou espaço
      lQuery := lQuery + ' left join controlealteracoes c on c.sistema = :sistema and c.identificador = :identificador and c.chave = cast(p.id as varchar(22)) ' +
                ' where c.valor in ( ''A'' ) ';
      SetLength(lParameters,2);
      lParameters[0] := ctr.sistema;
      lParameters[1] := CONTROLE_LOGISTICA_FEDEX_STATUS_PO;
      lFieldNames := 'sistema;identificador';
      //Usar controle alterações...
    end;

    orders.query(lQuery,lFieldNames,lParameters);

    datasets := getFedexDatasets;

    atribuirRegistros(orders.dataset,datasets.po.dataset);

    datasets.po.dataset.First;
    while not datasets.po.dataset.Eof do begin

      lQuery := 'select ' + QuotedStr(datasets.po.dataset.FieldByName('id').AsString) + ' id, ' +
        ' p.numero_ent, p.codigo_for, p.codigo_pro produto, p.quantidade_ent quantidade, ' +
        ' p.valoruni_ent unitario, produto.barras_pro barras ' +
        ' from entradaitens p ' +
        ' left join produto on produto.codigo_pro=p.codigo_pro ' +
        ' where p.numero_ent=:numero_ent and p.codigo_for = :codigo_for ';

      items.query(lQuery,'numero_ent;codigo_for', [ datasets.po.dataset.FieldByName('numero_nfe').AsString, datasets.po.dataset.FieldByName('codigo_for').AsString ]);
      save1 := pResultado.erros;

      while not items.dataset.eof do begin
        if precisaEnviarProduto(items.dataset.FieldByName('produto').AsString) then begin
          save2 := pResultado.erros;
          lSKUList := fedex_SCI_GetSKUList(items.dataset.FieldByName('produto').AsString,pResultado);
          if(save2=pResultado.erros) then
            fAPI.sendSKUList(lSKUList,pResultado);
        end;
        items.dataset.Next;
      end;
      items.dataset.First;
      if(pResultado.erros<>save1) then
        datasets.po.dataset.Delete
      else
        atribuirRegistros(items.dataset,datasets.poItens.dataset);
      datasets.po.dataset.Next;
    end;

    lXMLDataList := TListaSimplesCreator.CreateDictionary<TipoWideStringFramework,TipoWideStringFramework>;
    lXMLDataList.add('ordem',datasets.po.getXML);
    lXMLDataList.add('itens',datasets.poItens.getXML);

    Result := fAPI.getPurchaseOrderList(lXMLDataList,false,nil,pResultado);

    if (Result=nil) or (Result.count=0) then
      pResultado.adicionaAviso('getPurchaseOrderList: Não existem ordens de recebimento a enviar.');

  except
    on e: Exception do
      pResultado.formataErro('getPurchaseOrderList: %s: %s', [ e.ClassName, e.Message ] );
  end;

end;

function TLogisticaFedex.processaRetorno(pResultado: IResultadoOperacao = nil): IResultadoOperacao;
begin
  Result := checkResultadoOperacao(pResultado);
  Result := fAPI.processaRetorno(nil,pResultado);
end;

function TLogisticaFedex.getStatusProduto;
begin
  Result := fAPI.parameters.controleAlteracoes.getValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SKU,pCodigoPro);
end;

procedure TLogisticaFedex.setStatusProduto;
begin
  if(pCodigoPro<>'') then
    getControleAlteracoes.setValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SKU,pCodigoPro,pStatus);
end;

function TLogisticaFedex.getStatusEntrada;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_FEDEX_STATUS_PO,pID);
end;

procedure TLogisticaFedex.setStatusEntrada;
begin
  if(pID<>'') then
    getControleAlteracoes.setValor(CONTROLE_LOGISTICA_FEDEX_STATUS_PO,pID,pStatus);
end;

function TLogisticaFedex.getStatusVenda;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SO,pNumeroPed);
end;

procedure TLogisticaFedex.setStatusVenda;
begin
  if(pNumeroPed<>'') then
    getControleAlteracoes.setValor(CONTROLE_LOGISTICA_FEDEX_STATUS_SO,pNumeroPed,pStatus);
end;

function TLogisticaFedex.vendaFinalizada;
begin
  Result := getStatusVenda(pNumeroPed)=CONTROLE_LOGISTICA_STATUS_FINALIZADO;
end;

function TLogisticaFedex.entradaFinalizada;
begin
  Result := getStatusEntrada(pID)=CONTROLE_LOGISTICA_STATUS_FINALIZADO;
end;

function TLogisticaFedex.getResultadoProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_RESULTADO_SKU,pCodigoPro);
end;

function TLogisticaFedex.getResultadoVenda;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_RESULTADO_SO,pNumeroPed);
end;

function TLogisticaFedex.getResultadoEntrada;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_RESULTADO_PO,pID);
end;

{$ENDREGION}

{ TLogisticaFedex }

constructor TLogisticaFedex.Create;
begin
  inherited Create;
  fAPI := fedex_SCI_criaAPI(pCNPJ,pRazaoSocial);
end;

function TLogisticaFedex.enviaEntrada(pID: String; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    pLista: TFedex_PurchaseOrderList;
begin
  Result := checkResultadoOperacao(pResultado);

  pResultado.propriedade['id'].asString := pID;
  pLista := fedex_SCI_getPurchaseOrderList(pResultado);
  fAPI.sendPurchaseOrderList(pLista,pResultado);
end;

function TLogisticaFedex.enviaProduto(pID: String;  pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  raise Exception.Create('Não implementado');
end;

function TLogisticaFedex.enviaVenda(pNumeroPed: TipoWideStringFramework; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    lLista: TFedex_ShipmentOrderList;
begin
  Result := checkResultadoOperacao(pResultado);
  pResultado.propriedade['id'].asString := pNumeroPed;
  lLista := fedex_SCI_getShipmentOrderList(pResultado);
  fAPI.sendShipmentOrderList(lLista,pResultado);
end;

function TLogisticaFedex.getAPI: IUnknown;
begin
  Result := fAPI;
end;

function TLogisticaFedex.getCompilacao: Int64;
begin
  Result := fAPI.compilacao;
end;

function TLogisticaFedex.getVersao: TipoWideStringFramework;
begin
  Result := fAPI.versao;
end;

function TLogisticaFedex.precisaEnviarProduto(const pCodigoPro: TipoWideStringFramework): boolean;
begin
  Result := false;
  if(pCodigoPro='') then
    exit;
  Result := stringNoArray(getStatusProduto(pCodigoPro), [' ','',CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO]);
end;

procedure TLogisticaFedex.setAPI(const pValue: IInterface);
begin
  supports(pValue, IFedexAPI, fAPI);
end;

procedure TLogisticaFedex.setControleAlteracoes(const pValue: IControleAlteracoes);
begin
  if assigned(pValue) then
    fAPI.parameters.controleAlteracoes := pValue
  else
    fAPI.parameters.controleAlteracoes := criaControleAlteracoes;
end;

function criaLogisticaFedex(const pCNPJ: TipoWideStringFramework; const pRazaoSocial: TipoWideStringFramework): ILogistica;
begin
  Result := TLogisticaFedex.Create(pCNPJ, pRazaoSocial);
end;

initialization
  registraLogistica(CONTROLE_LOGISTICA_FEDEX,criaLogisticaFedex);

end.
