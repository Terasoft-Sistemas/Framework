
{$i Logistica.inc}

unit Fedex.SCI.Impl;

interface

implementation
{$REGION 'uses implementation'}
  uses
    Classes,
    Terasoft.Framework.Types,
    Terasoft.Framework.Texto,
    Terasoft.Framework.ControleAlteracoes,
    Fedex.API.Iface,
    Terasoft.Framework.DB,
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
{$endREGION}

{$REGION 'type implementation'}
    type
      TLogisticaFedex = class(TInterfacedObject, ILogistica)
      protected
        function fedex_SCI_GetPurchaseOrderList(pResultado: IResultadoOperacao = nil): TFedex_PurchaseOrderList;
        function fedex_SCI_GetShipmentOrderList(pResultado: IResultadoOperacao = nil): TFedex_ShipmentOrderList;
        function fedex_SCI_GetSKUList(pCodigoPro: TipoWideStringFramework; pResultado: IResultadoOperacao = nil): TFedex_SKUList;
        function fedex_SCI_criaAPI(const pCNPJ: TipoWideStringFramework = ''; const pRazaoSocial: TipoWideStringFramework = ''): IFedexAPI;
        function criaControleAlteracoes: IControleAlteracoes;
        function getName: TipoWideStringFramework;

      protected
        fAPI: IFedexAPI;

        function precisaEnviarProduto(const pCodigoPro: TipoWideStringFramework): boolean;
        function getStatusProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;
        procedure setStatusProduto(const pCodigoPro: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
        function getResultadoProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;

        function precisaEnviarEntrada(const pID: TipoWideStringFramework): boolean;
        function getStatusEntrada(const pID: TipoWideStringFramework): TipoWideStringFramework;
        procedure setStatusEntrada(const pID: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
        function getResultadoEntrada(const pID: TipoWideStringFramework): TipoWideStringFramework;
        function entradaFinalizada(const pID: TipoWideStringFramework): boolean;


        function precisaEnviarSaida(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): boolean;
        function getStatusSaida(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): TipoWideStringFramework;
        procedure setStatusSaida(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework; const pStatus: TipoWideStringFramework);
        function getResultadoSaida(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): TipoWideStringFramework;
        function saidaFinalizada(const pTipo: TipoWideStringFramework; const pNumeroDoc: TipoWideStringFramework): boolean;

        function getControleAlteracoes: IControleAlteracoes;
        procedure setControleAlteracoes(const pValue: IControleAlteracoes);

        function enviaProduto(pCodigoPro: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
        function enviaSaida(pTipo: TipoWideStringFramework = ''; pNumeroDoc: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
        function enviaEntrada(pID: TipoWideStringFramework = ''; pResultado: IResultadoOperacao = nil): IResultadoOperacao;

        function processaRetorno(pResultado: IResultadoOperacao = nil): IResultadoOperacao;

        function processaServico(pResultado: IResultadoOperacao = nil): IResultadoOperacao;

        function getVersao: TipoWideStringFramework;
        function getCompilacao: Int64;
        procedure setAPI(const pValue: IUnknown);
        function getAPI: IUnknown;

        constructor Create(const pCNPJ: TipoWideStringFramework = ''; const pRazaoSocial: TipoWideStringFramework = '');
      end;
{$ENDREGION}


{$REGION 'processaArquivoExpedicao'}
function processaArquivoExpedicao(pUnkAPI: IUnknown; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    lArquivo,lDocumento,lTipoDocumento,lTipo,lProduto,lIMEI: String;
    lTexto, lLinha: IListaTexto;
    lTmp: TipoWideStringFramework;
    ctr: IControleAlteracoes;
    lDivergencias, lSave: Integer;
    lDS,lDSItens,lDSIMEI,lMovimento: IDataset;
    lCancelamento: boolean;
    lLista: IDicionarioSimples<TipoWideStringFramework,IListaString>;
    lListaIMEIS: IListaString;
    i: Integer;
    lCDS: TDataset;
    lFieldQtde: TField;
    pAPI: IFedexAPI;
    lRes: IResultadoOperacao;
    lDataHoraAtual: TDateTime;
    strObs: String;
    lVolumes: Integer;
    lPeso: Extended;
    lStatus: String;
begin
  Result := checkResultadoOperacao(pResultado);
  lRes := nil;
  lSave := pResultado.erros;
  ctr := nil;
  pAPI := nil;
  lDocumento := '';
  lTipo := '';
  lDS := nil;
  lDSItens := nil;
  lCDS := nil;
  lLista := TListaSimplesCreator.CreateDictionary<TipoWideStringFramework,IListaString>;
  lVolumes := 0;
  lPeso := 0;
  try
    try
      if not Supports(pUnkAPI, IFedexAPI, pAPI) then begin
        pResultado.adicionaErro('processaArquivoExpedicao: API n�o definida.');
        exit;
      end;

      if(gdbPadrao=nil)or(gdbPadrao.conectado=false) then begin
        pResultado.adicionaErro('processaArquivoExpedicao: GDB n�o definido.');
        exit;
      end;

      lDSIMEI := gdbPadrao.criaDataset;
      lDataHoraAtual := gdbPadrao.dataHoraServer;

      ctr := pAPI.parameters.controleAlteracoes;
      if(ctr=nil) then begin
        pResultado.adicionaErro('processaArquivoExpedicao: Controle de altera��es n�o definido.');
        exit;
      end;

      lArquivo := pResultado.propriedade['ARQUIVO'].asString;
      if (lArquivo='') or not FileExists(lArquivo) then begin
        pResultado.formataErro('processaArquivoExpedicao: arquivo [%s] n�o existe.', [lArquivo]);
        pResultado.acumulador['Saidas rejeitadas'].incrementa;
        rejeitarArquivoFedex(true,pResultado);
        exit;
      end;
      if (pAPI=nil) or (pAPI.parameters.depositante.cnpj='') then begin
        pResultado.formataErro('processaArquivoExpedicao: N�o especificou um API/DEPOSITANTE v�lido.', [lArquivo]);
        exit;
      end;

      lTexto := novaListaTexto;
      lLinha := novaListaTexto;
      lLinha.strings.Delimiter := '|';
      lTexto.strings.LoadFromFile(lArquivo);
      for i := 0 to lTexto.lines.Count - 1 do begin
        lLinha.strings.DelimitedText := lTexto.strings.Strings[i];
        if(i=0) then begin
          lCancelamento:=UpperCase(ChangeFileExt(ExtractFileName(lArquivo),''))=UpperCase(lLinha.strings.Strings[0]);
          if(lCancelamento) then begin
           if(lDocumento='') then
              lDocumento := textoEntreTags(lLinha.strings.Strings[0],'_','_');
            break;
          end;
          lPeso := StrToFloatDef(lLinha.strings.Strings[1],0);
          lVolumes := StrToIntDef(lLinha.strings.Strings[2],0);
        end;

        if(lLinha.strings.Count < 5 ) then begin
          pResultado.formataErro('processaArquivoExpedicao [%s]: Registro %d n�o possui 5 campos especificados: %d', [ lArquivo, (i + 1), lLinha.strings.Count ] );
          continue;
        end;

        if(lDocumento='') then begin
          lTipoDocumento := lLinha.strings.Strings[0];
          lDocumento := lTipoDocumento;
          if (lDocumento='') or(Length(lDocumento)<>7) then begin
            pResultado.formataErro('processaArquivoExpedicao [%s]: N�mero do documento inv�lido: %s', [ lArquivo, lTipoDocumento ] );
            break;
          end;
          lTipo := copy(lDocumento,1,1);
          lDocumento := copy(lDocumento,2);
          lRes := pResultado.getSavePoint('so.' + lTipoDocumento);

          if(lTipo=LOGISTICA_TIPOSAIDA_PEDIDO) then
          begin
            lDS := gdbPadrao.criaDataset.query( 'select p.numero_ped id, p.* from pedidovenda p where p.numero_ped=:id', 'id', [ lDocumento ]);
          end else if(lTipo=LOGISTICA_TIPOSAIDA_SAIDATRANSF) then
          begin
            lDS := gdbPadrao.criaDataset.query( 'select p.numero_sai id, p.* from saidas p where p.numero_sai=:id and p.transferencia=''S'' ', 'id', [ lDocumento ]);
          end else begin
            pResultado.formataErro('processaArquivoExpedicao [%s]: Tipo n�o reconhecido: %s', [ lArquivo, lTipo ] );
            break;
          end;

          if(lDS.dataset.RecordCount=0) then begin
            pResultado.formataErro('processaArquivoExpedicao [%s]: Documento [%s] n�o existe.', [ lArquivo, lTipoDocumento ] );
            divergenciaArquivoFedex(true,pResultado);
            pResultado.acumulador['Saidas divergentes'].incrementa;
            exit;
          end;
          lStatus := ctr.getValor(CONTROLE_LOGISTICA_STATUS_SAIDA, lTipo + lDS.dataset.FieldByName('id').AsString,'');
          if (lStatus = CONTROLE_LOGISTICA_STATUS_FINALIZADO) then
          begin
            pResultado.formataErro('processaArquivoExpedicao [%s]: Documento [%s] j� foi finalizado', [ lArquivo, lTipoDocumento ] );
            rejeitarArquivoFedex(true,pResultado);
            pResultado.acumulador['Saidas rejeitadas'].incrementa;
            lRes:=nil;
            exit;
          end;

          if  stringForaArray(lStatus, [CONTROLE_LOGISTICA_STATUS_ENVIADO,CONTROLE_LOGISTICA_STATUS_DIVERGENTE]) then begin
            pResultado.formataErro('processaArquivoExpedicao [%s]: Documento [%s] n�o est� no status ENVIADO ou DIVERGENTE: [%s]', [ lArquivo, lTipoDocumento, lStatus ] );
            divergenciaArquivoFedex(true,pResultado);
            pResultado.acumulador['Saidas divergentes'].incrementa;
            exit;
          end;

          if(lDSItens=nil) then begin
            if(lTipo=LOGISTICA_TIPOSAIDA_PEDIDO) then
            begin
              lDSItens := gdbPadrao.criaDataset.query('select p.id id_item, p.numero_ped id, p.codigo_pro produto_id, p.quantidade_ped quantidade, 0 as quantidade_atendida from pedidoitens p ' +
                                               ' where p.numero_ped = :id order by 1 ', 'id', [ lDocumento ] );
            end else if(lTipo=LOGISTICA_TIPOSAIDA_SAIDATRANSF) then
            begin
              lDSItens := gdbPadrao.criaDataset.query('select p.id id_item, p.numero_sai id, p.codigo_pro produto_id, p.quantidade_sai quantidade, 0 as quantidade_atendida from saidasitens p ' +
                                               ' where p.numero_sai = :id order by 1 ', 'id', [ lDocumento ] );
            end else begin
              pResultado.formataErro('processaArquivoExpedicao [%s]: Tipo n�o reconhecido: %s', [ lArquivo, lTipo ] );
              break;
            end;

            if(lDSItens.dataset.RecordCount = 0 ) then
            begin
              pResultado.formataErro('processaArquivoExpedicao: Documento [%s]: N�o possui itens na tabela de itens', [ lTipoDocumento ] );
              break;
            end;
            lCDS := getCDSDataset(lDSItens.dataset);
            lFieldQtde := lCDS.FindField('quantidade_atendida');
          end;
          if (lCDS = nil) or (lFieldQtde=nil) then begin
            result.formataErro('processaArquivoExpedicao [%s]: N�o possui itens na tabela de itens', [ lTipoDocumento ] );
            break;
          end;
        end;
        lProduto := textoEntreTags(lLinha.strings.Strings[3],'','_');
        if(lProduto='') then
          lProduto := lLinha.strings.Strings[3];

        lIMEI    := lLinha.strings.Strings[4];
        if not validaIMEI(lIMEI) then
        begin
          pResultado.formataErro('processaArquivoExpedicao [%s]: IMEI [%s] inv�lido para item %d', [ lArquivo, lIMEI, i ] );
          continue;
        end;
        lDSImei.query('select * from movimento_serial m where m.numero=:imei and m.produto=:produto and m.tipo_movimento = ''E''', 'imei;produto', [lIMEI,lProduto]);
        if(lDSIMEI.dataset.RecordCount = 0 ) then
        begin
          pResultado.formataErro('processaArquivoExpedicao [%s]: IMEI [%s] inv�lido para produto %s', [ lArquivo, lIMEI, lProduto ] );
          continue;
        end;
        if not lLista.get(lProduto,lListaIMEIS) then
        begin
          lListaIMEIS := getStringList;
          lLista.add(lProduto,lListaIMEIS);
        end;
        if not (lListaIMEIS.IndexOf(lIMEI)<0) then
        begin
          pResultado.formataErro('processaArquivoExpedicao [%s]: IMEI [%s] j� informado para item %d', [ lArquivo, lIMEI, i ] );
          continue;
        end;

        lListaIMEIS.Add(lIMEI);

        lCDS.First;
        while not lCDS.eof do
        begin
          if(lCDS.FieldByName('produto_id').AsString = lProduto) then
          begin
            if(lFieldQtde.AsCurrency<lCDS.FieldByName('quantidade').AsCurrency) then
            begin
              lCDS.Edit;
              lFieldQtde.AsCurrency := lFieldQtde.AsCurrency + 1.0;
              lCDS.CheckBrowseMode;
              break;
            end;
          end;
          lCDS.Next;
        end;
        if(lCDS.Eof) then
        begin
          pResultado.formataErro('processaArquivoExpedicao Documento[%s]: N�o localizou o produto [%s]', [ lDocumento, lProduto ] );
          result.formataAviso('Documento [%s%s] marcado como DIVERGENTE', [ lTipo, lDocumento ] );
          divergenciaArquivoFedex(true,pResultado);
          ctr.setValor(CONTROLE_LOGISTICA_STATUS_SAIDA, lTipoDocumento, CONTROLE_LOGISTICA_STATUS_DIVERGENTE);
          pResultado.acumulador['Pedidos divergentes'].incrementa;
          exit;
        end;
      end;

      if(lCDS<>nil) then
      begin
        lDivergencias := 0;
        lCDS.First;
        while not lCDS.Eof do
        begin
          strObs := '';

          if lLista.get(lCDS.FieldByName('produto_id').AsString, lListaIMEIS) then
          for lIMEI in lListaIMEIS do
          begin
            if(strObs<>'') then
              strObs:=strObs+' ';
            strObs := strObs + lIMEI;
          end;

          if(strObs<>'') then
            strObs := 'Seriais:' + strObs;

          if(lTipo=LOGISTICA_TIPOSAIDA_PEDIDO) then
          begin
            gdbPadrao.insereDB('PEDIDOVENDA_EXPEDICAO',
                ['id','pedido_id', 'item_id', 'produto_id', 'quantidade', 'quantidade_original', 'status'],
                [gdbPadrao.genValue('GEN_PEDIDOVENDA_EXPEDICAO'),lCDS.FieldByName('id').AsString, lCDS.FieldByName('id_item').AsString, lCDS.FieldByName('produto_id').AsString, lFieldQtde.AsInteger, lCDS.FieldByName('quantidade').AsInteger, '0'],false,false,'pedido_id,item_id');
            gdbPadrao.updateDB('pedidoitens', [ 'id' ], [ lCDS.FieldByName('id_item').AsInteger ], [ 'OBS_ITEM', 'quantidade_atendida'], [ strObs, lFieldQtde.AsInteger ] );
            if(lFieldQtde.AsInteger <> lCDS.FieldByName('quantidade').AsInteger) then begin
              result.formataErro('processaArquivoExpedicao: Pedido [%s], Produto[%s] divergente na quantidade: Vendida: %d, Atendida: %d',
              [ lTipoDocumento, lCDS.FieldByName('produto_id').AsString, lCDS.FieldByName('quantidade').AsInteger, lCDS.FieldByName('quantidade_atendida').AsInteger ] );
              inc(lDivergencias);
            end;
            if(lCDS.RecNo=1) then
              gdbPadrao.updateDB('pedidovenda', [ 'numero_ped' ], [ lDocumento ], [ 'PESO_BRUTO', 'PESO_LIQUIDO', 'QTDE_VOLUME','ESPECIE_VOLUME'], [ lPeso, lPeso, lVolumes, 'CAIXA' ] );
          end else if(lTipo=LOGISTICA_TIPOSAIDA_SAIDATRANSF) then
          begin
            gdbPadrao.updateDB('saidasitens', [ 'id' ], [ lCDS.FieldByName('id_item').AsInteger ], [ 'OBS_ITEM', 'qtd_checagem'], [ strObs, lFieldQtde.AsInteger ] );
            if(lFieldQtde.AsInteger <> lCDS.FieldByName('quantidade').AsInteger) then begin
              result.formataErro('processaArquivoExpedicao: Transferencia [%s], Produto[%s] divergente na quantidade: Vendida: %d, Atendida: %d',
              [ lTipoDocumento, lCDS.FieldByName('produto_id').AsString, lCDS.FieldByName('quantidade').AsInteger, lCDS.FieldByName('quantidade_atendida').AsInteger ] );
              inc(lDivergencias);
            end;
            if(lCDS.RecNo=1) then
              gdbPadrao.updateDB('saidas', [ 'numero_sai' ], [ lDocumento ], [ 'PESO_BRUTO', 'PESO_LIQUIDO', 'QTDE_VOLUME','ESPECIE_VOLUME'], [ lPeso, lPeso, lVolumes, 'CAIXA' ] );
          end else begin
            pResultado.formataErro('processaArquivoExpedicao [%s]: Tipo n�o reconhecido: %s', [ lArquivo, lTipo ] );
          end;
          lCDS.Next;
        end;
        gdbPadrao.commit(true);
      end;
      if(lDivergencias>0) then
      begin
        divergenciaArquivoFedex(true,pResultado);
        pResultado.formataAviso('Pedido [%s] marcado como DIVERGENTE', [ lTipoDocumento ] );
        ctr.setValor(CONTROLE_LOGISTICA_STATUS_SAIDA, lTipoDocumento, CONTROLE_LOGISTICA_STATUS_DIVERGENTE);
        result.acumulador['Pedidos divergentes'].incrementa;
        exit;
      end;

      if(pResultado.erros<>lSave) then
      begin
        rejeitarArquivoFedex(true,pResultado);
        pResultado.acumulador['Saidas rejeitadas'].incrementa;
        exit;
      end;

      try

        lMovimento := gdbPadrao.criaDataset.query('select * from movimento_serial s where s.tipo_documento = :tipo and id_documento=:id ', 'tipo;id', [ lTipo, lDocumento ]);
        if(lMovimento.dataset.RecordCount>0) then
        begin
          rejeitarArquivoFedex(true,pResultado);
          pResultado.formataErro('processaArquivoRecebimento [%s]: J� possui movimento de seriais para esse documento [%s]', [ lArquivo, lTipoDocumento ] );
          pResultado.acumulador['Saidas rejeitadas'].incrementa;
          exit;
        end;

        lCDS.First;
        while not lCDS.eof do
        begin
          lProduto := lCDS.FieldByName('produto_id').AsString;
          if not lLista.get(lProduto,lListaIMEIS) then
          begin
            pResultado.formataErro('processaArquivoExpedicao [%s]: Produto [%s] n�o possui IMEI de retorno', [ lArquivo, lProduto ] );
            lDSItens.dataset.Next;
            continue;
          end;
          for lTmp in lListaIMEIS do
          begin
            gdbPadrao.insereDB('movimento_serial',
                ['tipo_serial','numero','produto','tipo_documento','id_documento', 'logistica', 'dh_movimento'],
                ['I',lTmp,lProduto,lTipo,lDocumento,LOGISTTICA_FEDEX,lDataHoraAtual]);
          end;

          lCDS.Next;
        end;
        gdbPadrao.commit(true);
        ctr.setValor(CONTROLE_LOGISTICA_STATUS_SAIDA, lTipoDocumento,CONTROLE_LOGISTICA_STATUS_FINALIZADO);
        apagarArquivoFedex(false,pResultado);
      finally
        gdbPadrao.rollback(true);
      end;

    except
      on e: Exception do
      begin
        pResultado.formataErro('processaArquivoExpedicao: %s: %s', [ e.ClassName, e.Message ] );
        pResultado.acumulador['Saidas com problemas'].incrementa;
      end;
    end;
  finally
    if assigned(lRes) and assigned(ctr) then begin
      pAPI.parameters.controleAlteracoes.setValor(CONTROLE_LOGISTICA_RESULTADO_SAIDA,lTipoDocumento,
          lRes.toHTML('', 'Resultado de processamento do RETORNO da FEDEX @' + DateTimeToStr(Now), [ orosh_semHeader ]));
      pResultado.getSavePoint('');
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
    lMovimento, lDSIMEI, lDSFornecedor, lDS, lDSItens: IDataset;
    ctr: IControleAlteracoes;
    lLista: IDicionarioSimples<TipoWideStringFramework,IListaString>;
    lListaIMEIS: IListaString;
    pAPI: IFedexAPI;
    lRes: IResultadoOperacao;
    lID: TipoWideStringFramework;
    lDataHoraAtual: TDateTime;
    lStatus: String;
begin
  //processamento entrada

  Result := checkResultadoOperacao(pResultado);
  lID := '';
  lSave := pResultado.erros;
  lRes := nil;
  ctr := nil;
  lLista := TListaSimplesCreator.CreateDictionary<TipoWideStringFramework,IListaString>;
  lStatus := '';
  try
    try
      if not Supports(pUnkAPI,IFedexAPI, pAPI) then begin
        pResultado.adicionaErro('processaArquivoRecebimento: API n�o definida.');
        exit;
      end;
      if(gdbPadrao=nil)or(gdbPadrao.conectado=false) then begin
        pResultado.adicionaErro('processaArquivoRecebimento: GDB n�o definido.');
        exit;
      end;

      lDataHoraAtual := gdbPadrao.dataHoraServer;

      lArquivo := pResultado.propriedade['ARQUIVO'].asString;
      if (lArquivo='') or not FileExists(lArquivo) then begin
        pResultado.formataErro('processaArquivoRecebimento: arquivo [%s] n�o existe.', [lArquivo]);
        pResultado.acumulador['Entradas rejeitadas'].incrementa;
        rejeitarArquivoFedex(true,pResultado);
        exit;
      end;
      if (pAPI=nil) or (pAPI.parameters.depositante.cnpj='') then begin
        pResultado.formataErro('processaArquivoRecebimento: N�o especificou um API/DEPOSITANTE v�lido.', [lArquivo]);
        exit;
      end;
      ctr := pAPI.parameters.controleAlteracoes;
      if(ctr=nil) then begin
        pResultado.adicionaErro('processaArquivoRecebimento: Controle de altera��es n�o definido.');
        exit;
      end;

      lTexto := novaListaTexto;
      lLinha := novaListaTexto;
      lLinha.strings.Delimiter := '|';
      lTexto.strings.LoadFromFile(lArquivo);

      lNF := '';
      lCNPJ := '';

      if(lTexto.lines.Count<1) then begin
        pResultado.formataErro('processaArquivoRecebimento: arquivo [%s] n�o possui dados validos.', [lArquivo]);
        pResultado.acumulador['Entradas rejeitadas'].incrementa;
        rejeitarArquivoFedex(true,pResultado);
        exit;
      end;

      for i := 0 to lTexto.lines.Count - 1 do begin
        lLinha.strings.DelimitedText := lTexto.strings.Strings[i];
        if(lLinha.strings.Count < 4 ) then begin
          pResultado.formataErro('processaArquivoRecebimento [%s]: Registro %d n�o possui 4 campos especificados: %d', [ lArquivo, (i + 1), lLinha.strings.Count ] )
        end;

        if(lCNPJ='') then begin
          lCNPJ    := lLinha.strings.Strings[1];
          lDSFornecedor := gdbPadrao.criaDataset.query('select f.id, f.codigo_for from fornecedor f where f.cnpj_cpf_for = :cnpj',
            'cnpj', [ lCNPJ ] );

          if(lDSFornecedor.dataset.RecordCount=0) then begin
            pResultado.formataErro('processaArquivoRecebimento [%s]: Fornecedor [%s] n�o existe', [ lArquivo, lCNPJ ] );
            rejeitarArquivoFedex(true,pResultado);
            pResultado.acumulador['Entradas rejeitadas'].incrementa;
            exit;
          end;
        end;

        if(lNF='') then begin
          lNF := lLinha.strings.Strings[0];
          lDS := gdbPadrao.criaDataset.query('select e.* from entrada e ' +
              ' where e.codigo_for = :fornecedor and e.numero_ent =:numero ',

              'fornecedor;numero', [ lDSFornecedor.fieldByName('codigo_for').AsString, lNF ] );
          if(lDS.dataset.RecordCount=0) then begin
            pResultado.formataErro('processaArquivoRecebimento: NF [%s] do Fornecedor [%s] n�o existe.',
              [ lNF, lCNPJ ] );
            pResultado.propriedade['ACAO_ARQUIVO'].asString := FEDEX_ACAOARQUIVO_REJEITAR;
            result.acumulador['Entradas rejeitadas'].incrementa;
            exit;
          end;

          lStatus:=ctr.getValor(CONTROLE_LOGISTICA_STATUS_ENTRADA, lDS.dataset.FieldByName('id').AsString,'');
          lID := lDS.dataset.FieldByName('id').AsString;
          lRes := pResultado.getSavePoint('po.' + lID);

          if(lStatus=CONTROLE_LOGISTICA_STATUS_FINALIZADO) then
          begin
            rejeitarArquivoFedex(true,pResultado);
            pResultado.formataErro('processaArquivoRecebimento: NF [%s] do Fornecedor [%s] j� foi processada',
              [ lNF, lCNPJ ] );
            pResultado.acumulador['Entradas rejeitadas'].incrementa;
            lRes := nil;
            exit;
          end else if stringNoArray(lStatus,[CONTROLE_LOGISTICA_STATUS_ENVIADO, CONTROLE_LOGISTICA_STATUS_DIVERGENTE]) then begin
            pResultado.formataErro('processaArquivoRecebimento: NF [%s] do Fornecedor [%s] divergente. N�o est� no status [ENVIADA] ou [DIVERGENTE].',
              [ lNF, lCNPJ ] );
            pResultado.acumulador['Entradas divergentes'].incrementa;
            divergenciaArquivoFedex(true,pResultado);
            exit;
          end;
        end;

        if(lNF<>lLinha.strings.Strings[0]) then
          pResultado.formataErro('processaArquivoRecebimento [%s]: Registro %d n�o possui N�mero de NF igual ao in�cio: [%s] e [%s]', [ lArquivo, (i + 1), lNF, lLinha.strings.Strings[0] ] );

        if(lCNPJ<>lLinha.strings.Strings[1]) then begin
          pResultado.formataErro('processaArquivoRecebimento [%s]: Registro %d n�o possui CNPJ igual ao in�cio: [%s] e [%s]', [ lArquivo, (i + 1), lCNPJ, lLinha.strings.Strings[1] ] )
        end;

        lProduto := textoEntreTags(lLinha.strings.Strings[2],'','_');

        if(lProduto='') then
          lProduto := lLinha.strings.Strings[2];

        lIMEI    := lLinha.strings.Strings[3];
        if not validaIMEI(lIMEI) then begin
          pResultado.formataErro('processaArquivoRecebimento [%s]: IMEI [%s] inv�lido para item %d', [ lArquivo, lIMEI, i ] );
          continue;
        end;

        if not lLista.get(lProduto,lListaIMEIS) then begin
          lListaIMEIS := getStringList;
          lLista.add(lProduto,lListaIMEIS);
        end;
        if not (lListaIMEIS.IndexOf(lIMEI)<0) then begin
          pResultado.formataErro('processaArquivoRecebimento [%s]: IMEI [%s] j� informado para item %d', [ lArquivo, lIMEI, i ] );
          continue;
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


      lDS := gdbPadrao.criaDataset.query('select e.* from entrada e ' +
              ' where e.codigo_for = :fornecedor and e.numero_ent =:numero ',

              'fornecedor;numero', [ lDSFornecedor.fieldByName('codigo_for').AsString, lNF ] );

      if(lDS.dataset.RecordCount=0) then begin
        pResultado.formataErro('processaArquivoRecebimento: NF [%s] do Fornecedor [%s] n�o existe ou j� foi processada',
          [ lNF, lCNPJ ] );
        pResultado.propriedade['ACAO_ARQUIVO'].asString := FEDEX_ACAOARQUIVO_REJEITAR;
        result.acumulador['Entradas rejeitadas'].incrementa;
        exit;
      end;

      lDSItens := gdbPadrao.criaDataset.query('select e.* from entradaitens e ' +
          ' where e.codigo_for = :fornecedor and e.numero_ent =:numero ', 'fornecedor;numero', [ lDSFornecedor.fieldByName('codigo_for').AsString, lNF]);

      if(lDSItens.dataset.RecordCount=0) then begin
        pResultado.formataErro('processaArquivoRecebimento: NF [%s] do Fornecedor [%s] n�o existe items par serem processados',
          [ lNF, lCNPJ ] );
        pResultado.acumulador['Entradas divergentes'].incrementa;
        divergenciaArquivoFedex(true,pResultado);
        exit;
      end;

      try

        lMovimento := gdbPadrao.criaDataset.query('select * from movimento_serial s where s.tipo_documento = ''E'' and id_documento=:id ', 'id', [ lDS.fieldByName('id').AsString ]);
        if(lMovimento.dataset.RecordCount>0) then begin
          rejeitarArquivoFedex(true,pResultado);
          pResultado.formataErro('processaArquivoRecebimento [%s]: J� possui movimento de seriais para essa entrada [%s]', [ lArquivo, lDS.fieldByName('id').AsString ] );
          pResultado.acumulador['Entradas rejeitadas'].incrementa;
          exit;
        end;

        while not lDSItens.dataset.eof do
        begin
          lProduto := lDSItens.dataset.FieldByName('codigo_pro').AsString;;

          if not lLista.get(lProduto,lListaIMEIS) then
          begin
            pResultado.formataErro('processaArquivoRecebimento [%s]: Produto [%s] n�o possui IMEI de retorno', [ lArquivo, lProduto ] );
            lDSItens.dataset.Next;
            continue;
          end;
          if(lDSItens.dataset.fieldByName('QUANTIDADE_ENT').AsFloat <> lListaIMEIS.Count) then
          begin
            pResultado.formataErro('processaArquivoRecebimento [%s]: Produto [%s] n�o possui IMEI suficientes na entrada: %d', [ lArquivo, lProduto, lListaIMEIS.Count ] );
            lDSItens.dataset.Next;
            continue;
          end else
          begin
            lDSItens.dataset.Edit;
            lDSItens.dataset.FieldByName('qtd_checagem').AsFloat := lDSItens.dataset.fieldByName('QUANTIDADE_ENT').AsFloat;
            lDSItens.dataset.CheckBrowseMode;
          end;
          i := 0;

          while (i < lDSItens.dataset.fieldByName('QUANTIDADE_ENT').AsFloat) and (lListaIMEIS.Count>0) do
          //for lTmp in lListaIMEIS do
          begin
            lTmp := lListaIMEIS.Items[0];
            lListaIMEIS.Delete(0);
            inc(i);
            if(i>lDSItens.dataset.fieldByName('QUANTIDADE_ENT').AsFloat) then break;
            if(lListaIMEIS.Count=0) then
              lLista.get(lProduto,lListaIMEIS,true);

            gdbPadrao.insereDB('movimento_serial',
                ['tipo_serial','numero','produto','tipo_documento','id_documento','logistica','dh_movimento'],
                ['I',lTmp,lProduto,'E',lDS.fieldByName('id').AsString,LOGISTTICA_FEDEX,lDataHoraAtual]);

          end;
          lDSItens.dataset.Next;
        end;
        if(lLista.count>0) then
          pResultado.formataErro('processaArquivoRecebimento [%s]: O retorno possui mais produtos do que o necess�rio', [ lArquivo ] );

        if(pResultado.erros<>lSave) then
        begin
          rejeitarArquivoFedex(true,pResultado);
          pResultado.acumulador['Entradas rejeitadas'].incrementa;
          exit;
        end;
        gdbPadrao.commit(true);
        ctr.setValor(CONTROLE_LOGISTICA_STATUS_ENTRADA, lDS.dataset.FieldByName('id').AsString,CONTROLE_LOGISTICA_STATUS_FINALIZADO);
        apagarArquivoFedex(false,pResultado);
      finally
        gdbPadrao.rollback(true);
      end;
    except
      on e: Exception do begin
        pResultado.formataErro('processaArquivoRecebimento: %s: %s', [ e.ClassName, e.Message ] );
        pResultado.acumulador['Entradas com problemas'].incrementa;
      end;
    end;

  finally
    if assigned(lRes) and assigned(ctr) then begin
      pAPI.parameters.controleAlteracoes.setValor(CONTROLE_LOGISTICA_RESULTADO_ENTRADA,lID,
          lRes.toHTML('', 'Resultado de processamento do RETORNO da FEDEX @' + DateTimeToStr(Now), [ orosh_semHeader ]));
      pResultado.getSavePoint('');
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

function TLogisticaFedex.getName: TipoWideStringFramework;
begin
  Result := LOGISTTICA_FEDEX;
end;

function TLogisticaFedex.precisaEnviarSaida;
begin
  Result := false;
  if(pNumeroDoc='') then
    exit;
  Result := getStatusSaida(pTipo, pNumeroDoc)=CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO;
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
    lFieldNames: String;
    lParameters: array of Variant;

begin
  checkResultadoOperacao(pResultado);
  Result := nil;

  try
    save := pResultado.erros;
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getSKUList: N�o especificou um DB v�lido.');

    if(pResultado.erros<>save) then
      exit;

    datasets := getFedexDatasets;


    lQuery := 'select ' +
        '   p.codigo_pro id, p.barras_pro barras, p.peso_pro peso, p.codigo_gru grupo, ' +
        '   p.codigo_sub subgrupo, p.nome_pro nome ' +
        ' from produto p ';//where p.codigo_pro=:id';


    lFieldNames := '';
    SetLength(lParameters,0);

    if(pCodigoPro<>'') then begin
      lFieldNames := 'id';
      SetLength(lParameters,1);
      lParameters[0] := pCodigoPro;
      lQuery := lQuery + ' where p.codigo_pro=:id '
    end else begin
      lQuery := lQuery + ' left join controlealteracoes ca on ca.sistema = :sistema and ca.identificador = :identificador and ca.chave = p.codigo_pro ' +
                ' where ca.valor = :status ';
      SetLength(lParameters,3);
      lParameters[0] := getControleAlteracoes.sistema;
      lParameters[1] := CONTROLE_LOGISTICA_STATUS_PRODUTO;
      lParameters[2] := CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO;
      lFieldNames := 'sistema;identificador;status';
      lQuery := lQuery + ' order by 1 ';


    end;

    lSKU := gdb.criaDataset.query(lQuery,lFieldNames,lParameters);

    if(lSKU.dataset.RecordCount=0) then begin
      if(pCodigoPro<>'') then
        pResultado.formataErro('getSKUList: Produto [%s] n�o existe.', [ pCodigoPro ])
      else
        pResultado.adicionaAviso('getSKUList: N�o existe produto dipon�vel.' );
      exit;
    end;

    atribuirRegistros(lSKU.dataset,datasets.sku.dataset);

    Result := fAPI.getSKUList(getXMLFromDataset(datasets.sku.dataset),false,pResultado);
    if(Result=nil) or (Result.count=0) then
      pResultado.formataErro('getSKUList: Produto [%s] n�o existe.', [ pCodigoPro ]);
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
    lID,lTipo, lQuery: String;
    lFieldNames: String;
    lParameters: array of Variant;
    datasets: TFedexDatasets;
    lXMLDataList: IDicionarioSimples<TipoWideStringFramework, TipoWideStringFramework>;
    lSKUList: TFedex_SKUList;
    p: TFedex_ShipmentOrderList;
    l: IListaString;
    t: IFedexShipmentOrder;
begin
  checkResultadoOperacao(pResultado);
  Result := nil;

  try
    save1 := pResultado.erros;
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getShipmentOrderList: N�o especificou um DB v�lido.');

    if(pResultado.erros<>save1) then
      exit;

    ctr := fAPI.parameters.controleAlteracoes;
    orders := gdb.criaDataset;
    items := gdb.criaDataset;
    cliente := gdb.criaDataset;
    transportador := gdb.criaDataset;
    lID   := pResultado.propriedade['id'].asString;
    lTipo := pResultado.propriedade['tipo'].asString;

    if(lTipo = '') then begin
      l := getStringList;
      l.Add(LOGISTICA_TIPOSAIDA_PEDIDO);
      l.Add(LOGISTICA_TIPOSAIDA_SAIDATRANSF);
      for lTipo in l do
      begin
        pResultado.propriedade['tipo'].asString := lTipo;
        p := fedex_SCI_GetShipmentOrderList(pResultado);
        if assigned(p) then
        begin
          if(Result=nil) then
          begin
            Result := p;
            continue;
          end;

          for t in p do
            Result.add(t);
        end;
        exit;
      end;
    end;

    if(lTipo=LOGISTICA_TIPOSAIDA_PEDIDO) then
    begin
      lQuery := 'select ''P'' || p.numero_ped id, p.numero_ped pid, p.data_ped data_emissao, p.total_ped valor_total, c.cnpj_cpf_cli cnpj_cpf, ' +
                ' t.cnpj_cpf_tra transportador, p.codigo_cli cliente_codigo, p.televenda_ped transportadora_codigo ' +
  //            ' case when ( p.devolucao_pedido_id is null ) then ''E'' else ''D'' end operacao, ' +
  //            ' p.numero_ent numero_nfe, p.codigo_for,p.arq_nfe xml ' +
              ' from pedidovenda p ' +
              ' left join clientes c on c.codigo_cli = p.codigo_cli ' +
              ' left join transportadora t on t.codigo_tra = p.televenda_ped ';
    end else if(lTipo=LOGISTICA_TIPOSAIDA_SAIDATRANSF) then
    begin
      lQuery := 'select ''T'' || p.numero_sai id, p.numero_sai pid, p.data_sai data_emissao, p.total_sai valor_total, c.cnpj_cpf_cli cnpj_cpf, ' +
                ' t.cnpj_cpf_tra transportador, p.codigo_cli cliente_codigo, p.TRANSPORTADORA_ID transportadora_codigo ' +
  //            ' case when ( p.devolucao_pedido_id is null ) then ''E'' else ''D'' end operacao, ' +
  //            ' p.numero_ent numero_nfe, p.codigo_for,p.arq_nfe xml ' +
              ' from saidas p ' +
              ' left join clientes c on c.codigo_cli = p.codigo_cli ' +
              ' left join transportadora t on t.codigo_tra = p.TRANSPORTADORA_ID ';

    end else
    begin
      pResultado.formataErro('getShipmentOrderList: Tipo n�o reconhecido: [%s]', [ lTIpo ]);
      exit;
    end;

    SetLength(lParameters,0);
    lFieldNames := '';
    if(lID<>'') then begin
      if(lTipo=LOGISTICA_TIPOSAIDA_PEDIDO) then
      begin
        //PEDIDO espec�fica
        lFieldNames := 'numero_ped';
        SetLength(lParameters,1);
        lParameters[0] := lID;
        lQuery := lQuery + ' where p.numero_ped=:numero_ped ';
      end else if(stringNoArray(lTipo, [LOGISTICA_TIPOSAIDA_SAIDATRANSF])) then
      begin
        //SAIDAS espec�fica
        lFieldNames := 'numero_sai';
        SetLength(lParameters,1);
        lParameters[0] := lID;
        lQuery := lQuery + ' where p.numero_sai=:numero_sai and p.transferencia=''S''';

      end else begin
        pResultado.formataErro('getShipmentOrderList: Tipo n�o reconhecido: [%s]', [ lTIpo ]);
        exit;
      end;
    end else begin
      if(lTipo=LOGISTICA_TIPOSAIDA_PEDIDO) then
      begin
        // Listar PEDIDOS que est�o no controle e precisam enviar
        lQuery := lQuery + ' left join controlealteracoes ca on ca.sistema = :sistema and ca.identificador = :identificador and ca.chave = ''P''||p.numero_ped ' +
                  ' where ca.valor = :status ';
        SetLength(lParameters,3);
        lParameters[0] := ctr.sistema;
        lParameters[1] := CONTROLE_LOGISTICA_STATUS_SAIDA;
        lParameters[2] := CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO;
        lFieldNames := 'sistema;identificador;status';
        lQuery := lQuery + ' order by 1 ';
      end else if(lTipo = LOGISTICA_TIPOSAIDA_SAIDATRANSF) then
      begin
        // Listar PEDIDOS que est�o no controle e precisam enviar
        lQuery := lQuery + ' left join controlealteracoes ca on ca.sistema = :sistema and ca.identificador = :identificador and ca.chave = ''T''||p.numero_sai ' +
                  ' where ca.valor = :status and p.transferencia=''S'' ';
        SetLength(lParameters,3);
        lParameters[0] := ctr.sistema;
        lParameters[1] := CONTROLE_LOGISTICA_STATUS_SAIDA;
        lParameters[2] := CONTROLE_LOGISTICA_STATUS_DISPONIVEL_PARA_ENVIO;
        lFieldNames := 'sistema;identificador;status';
        lQuery := lQuery + ' order by 1 ';
      end else begin
        pResultado.formataErro('getShipmentOrderList: Tipo n�o reconhecido: [%s]', [ lTIpo ]);
        exit;
      end;
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
        pResultado.formataErro('getShipmentOrderList: Pedido [%s] n�o possui um cliente v�lido.', [ datasets.so.dataset.FieldByName('id').AsString ] );
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
        pResultado.formataErro('getShipmentOrderList: Documento [%s] n�o possui um transportador v�lido.', [ datasets.so.dataset.FieldByName('id').AsString ] );
        break;
      end;

      if not datasets.transportador.dataset.Locate('cnpj_cpf', transportador.dataset.FieldByName('cnpj_cpf').AsString, []) then
        atribuirRegistros(transportador.dataset, datasets.transportador.dataset);

      if(lTipo=LOGISTICA_TIPOSAIDA_PEDIDO) then
      begin
        lQuery := 'select p.numero_ped id, id item, p.codigo_pro produto_id, p.quantidade_ped quantidade ' +
          ' from pedidoitens p ' +
          ' where p.numero_ped=:id ';
      end else if(stringNoArray(lTipo, [LOGISTICA_TIPOSAIDA_SAIDATRANSF])) then
      begin
        lQuery := 'select p.numero_sai id, id item, p.codigo_pro produto_id, p.quantidade_sai quantidade ' +
          ' from saidasitens p ' +
          ' where p.numero_sai=:id ';
      end else begin
        pResultado.formataErro('getShipmentOrderList: Documento [%s] n�o possui u query para o tipo [%s]', [ datasets.so.dataset.FieldByName('id').AsString, lTipo ] );
        break;
      end;

      items.query(lQuery,'id', [ datasets.so.dataset.FieldByName('pid').AsString ]);

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

    datasets.soItens.dataset.First;
    while not datasets.soItens.dataset.eof do
    begin
      datasets.soItens.dataset.Edit;
      datasets.soItens.dataset.FieldByName('id').AsString := lTipo + datasets.soItens.dataset.FieldByName('id').AsString;
      datasets.soItens.dataset.CheckBrowseMode;

      datasets.soItens.dataset.Next;
    end;

    lXMLDataList := TListaSimplesCreator.CreateDictionary<TipoWideStringFramework,TipoWideStringFramework>;
    lXMLDataList.add('ordem',datasets.so.getXML);
    lXMLDataList.add('itens',datasets.soItens.getXML);
    lXMLDataList.add('cliente',datasets.cliente.getXML);
    lXMLDataList.add('transportador',datasets.transportador.getXML);
    Result := fAPI.getShipmentOrderList(lXMLDataList,FEDEX_PRIORIDADE_MEDIA,true,nil,pResultado);

    if (Result=nil) or (Result.count=0) then
      pResultado.adicionaAviso('getShipmentOrderList: N�o existe ordem de envio dispon�vel.');

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

  try
    save1 := pResultado.erros;
    gdb := gdbPadrao;
    if(gdb=nil) or not gdb.conectado then
      pResultado.adicionaErro('getPurchaseOrderList: N�o especificou um DB v�lido.');

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
      //Entrada espec�fica
      lFieldNames := 'id';
      SetLength(lParameters,1);
      lParameters[0] := lID;
      lQuery := lQuery + ' where p.id=:id ';
    end else begin
      //Listar entradas que n�o est�o no controle ou STATUS nulo ou espa�o
      lQuery := lQuery + ' left join controlealteracoes c on c.sistema = :sistema and c.identificador = :identificador and c.chave = cast(p.id as varchar(22)) ' +
                ' where c.valor in ( ''A'' ) ';
      SetLength(lParameters,2);
      lParameters[0] := ctr.sistema;
      lParameters[1] := CONTROLE_LOGISTICA_STATUS_ENTRADA;
      lFieldNames := 'sistema;identificador';
      //Usar controle altera��es...
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
      pResultado.adicionaAviso('getPurchaseOrderList: N�o existe ordem de recebimento dispon�vel.');

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

function TLogisticaFedex.processaServico(pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  Result := checkResultadoOperacao(pResultado);
  try
    Result := enviaProduto('',Result);
  except
    on e: Exception do
      Result.formataErro('TLogisticaFedex.processaServico(enviaProduto): %s: %s', [e.ClassName, e.Message ] );
  end;
  try
    Result := enviaEntrada('',Result);
  except
    on e: Exception do
      Result.formataErro('TLogisticaFedex.processaServico(enviaEntrada): %s: %s', [e.ClassName, e.Message ] );
  end;
  try
    Result := enviaSaida('','',Result);
  except
    on e: Exception do
      Result.formataErro('TLogisticaFedex.processaServico(enviaSaida): %s: %s', [e.ClassName, e.Message ] );
  end;
  try
    Result := processaRetorno(Result);
  except
    on e: Exception do
      Result.formataErro('TLogisticaFedex.processaServico(processaRetorno): %s: %s', [e.ClassName, e.Message ] );
  end;
end;

function TLogisticaFedex.getStatusProduto;
begin
  Result := fAPI.parameters.controleAlteracoes.getValor(CONTROLE_LOGISTICA_STATUS_PRODUTO,pCodigoPro);
end;

procedure TLogisticaFedex.setStatusProduto;
begin
  if(pCodigoPro<>'') then
    getControleAlteracoes.setValor(CONTROLE_LOGISTICA_STATUS_PRODUTO,pCodigoPro,pStatus);
end;

function TLogisticaFedex.getStatusEntrada;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_STATUS_ENTRADA,pID);
end;

procedure TLogisticaFedex.setStatusEntrada;
begin
  if(pID<>'') then
    getControleAlteracoes.setValor(CONTROLE_LOGISTICA_STATUS_ENTRADA,pID,pStatus);
end;

function TLogisticaFedex.getStatusSaida;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_STATUS_SAIDA,pTipo+pNumeroDoc);
end;

procedure TLogisticaFedex.setStatusSaida;
begin
  if(pNumeroDoc<>'') then
    getControleAlteracoes.setValor(CONTROLE_LOGISTICA_STATUS_SAIDA,pTipo+pNumeroDoc,pStatus);
end;

function TLogisticaFedex.saidaFinalizada;
begin
  Result := getStatusSaida(pTipo,pNumeroDoc)=CONTROLE_LOGISTICA_STATUS_FINALIZADO;
end;

function TLogisticaFedex.entradaFinalizada;
begin
  Result := getStatusEntrada(pID)=CONTROLE_LOGISTICA_STATUS_FINALIZADO;
end;

function TLogisticaFedex.getResultadoProduto(const pCodigoPro: TipoWideStringFramework): TipoWideStringFramework;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_RESULTADO_PRODUTO,pCodigoPro);
end;

function TLogisticaFedex.getResultadoSaida;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_RESULTADO_SAIDA,pTipo+pNumeroDoc);
end;

function TLogisticaFedex.getResultadoEntrada;
begin
  Result := getControleAlteracoes.getValor(CONTROLE_LOGISTICA_RESULTADO_ENTRADA,pID);
end;

{$ENDREGION}


{$REGION 'TLogisticaFedex'}

{ TLogisticaFedex }


constructor TLogisticaFedex.Create;
begin
  inherited Create;
  fAPI := fedex_SCI_criaAPI(pCNPJ,pRazaoSocial);
end;

function TLogisticaFedex.enviaEntrada;//(pID: String; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    lLista: TFedex_PurchaseOrderList;
begin
  Result := checkResultadoOperacao(pResultado);

  pResultado.propriedade['id'].asString := pID;
  lLista := fedex_SCI_getPurchaseOrderList(pResultado);
  if assigned(lLista) and (lLista.count>0) then
    fAPI.sendPurchaseOrderList(lLista,pResultado);
end;

function TLogisticaFedex.enviaProduto(pCodigoPro: TipoWideStringFramework;  pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    lLista: TFedex_SKUList;
begin
  Result := checkResultadoOperacao(pResultado);
  lLista := fedex_SCI_GetSKUList(pCodigoPro, pResultado);
  if assigned(lLista) and (lLista.count>0) then
    fAPI.sendSKUList(lLista,pResultado);
end;

function TLogisticaFedex.enviaSaida;//(pTipo: TipoWideStringFramework = ''; pNumeroPed: TipoWideStringFramework; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    lLista: TFedex_ShipmentOrderList;
begin
  Result := checkResultadoOperacao(pResultado);
  pResultado.propriedade['id'].asString := pNumeroDoc;
  pResultado.propriedade['tipo'].asString := pTipo;
  lLista := fedex_SCI_getShipmentOrderList(pResultado);
  if assigned(lLista) and (lLista.count>0) then
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
{$ENDREGION'}

{$REGION 'initialization'}

initialization
  registraLogistica(CONTROLE_LOGISTICA_FEDEX,criaLogisticaFedex);
{$ENDREGION}

end.
