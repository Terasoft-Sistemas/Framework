
{$i definicoes.inc}

unit Terasoft.Framework.OpcoesCamposTabelas;

interface
  uses
    DB,SysUtils,Classes,
    Terasoft.Framework.Types, Terasoft.Framework.DB,
    Spring.Collections,
    Generics.Collections,
    Vcl.Controls,
    Terasoft.Framework.Texto;

  type

    TDependenciaRegra = TPair<TipoWideStringFramework,TipoWideStringFramework>;
    TListaDependenciaRegra = IList<TDependenciaRegra>;

    IDadosSetOpcoes = interface
    ['{81EEF943-D7CD-478A-9A89-51DC4C453619}']
    //property nome getter/setter
      function getNome: TipoWideStringFramework;
      procedure setNome(const pValue: TipoWideStringFramework);

    //property descricao getter/setter
      function getDescricao: TipoWideStringFramework;
      procedure setDescricao(const pValue: TipoWideStringFramework);

    //property listaValores getter/setter
      function getListaValores: IListaTextoEX;
      procedure setListaValores(const pValue: IListaTextoEX);

    //property listaDescricoes getter/setter
      function getListaDescricoes: IListaTextoEX;
      procedure setListaDescricoes(const pValue: IListaTextoEX);

    //property dataset getter/setter
      function getDataset: IDatasetSimples;
      procedure setDataset(const pValue: IDatasetSimples);

      procedure adicionaID_Descricao(const pID,pDescricao: TipoWideStringFramework);

      function match(pValue: TipoWideStringFramework): boolean;

      property dataset: IDatasetSimples read getDataset write setDataset;
      property listaDescricoes: IListaTextoEX read getListaDescricoes write setListaDescricoes;
      property listaValores: IListaTextoEX read getListaValores write setListaValores;
      property descricao: TipoWideStringFramework read getDescricao write setDescricao;
      property nome: TipoWideStringFramework read getNome write setNome;
    end;

    IDadosCamposValidacoes = interface
    ['{B468E846-321E-451A-B321-E46B50B382A8}']
    //property nome getter/setter
      function getNome: TipoWideStringFramework;
      procedure setNome(const pValue: TipoWideStringFramework);

    //property descricao getter/setter
      function getDescricao: TipoWideStringFramework;
      procedure setDescricao(const pValue: TipoWideStringFramework);

    //property obrigatorio getter/setter
      function getObrigatorio: boolean;
      procedure setObrigatorio(const pValue: boolean);

    //property opcoes getter/setter
      function getOpcoes: TipoWideStringFramework;
      procedure setOpcoes(const pValue: TipoWideStringFramework);

    //property tabela getter/setter
      function getTabela: TipoWideStringFramework;
      procedure setTabela(const pValue: TipoWideStringFramework);

    //property campo getter/setter
      function getCampo: TipoWideStringFramework;
      procedure setCampo(const pValue: TipoWideStringFramework);

    //property dadosOpcoes getter/setter
      function getDadosOpcoes: IDadosSetOpcoes;

    //property dependencias getter/setter
      function getDependencias: TListaDependenciaRegra;
      procedure setDependencias(const pValue: TListaDependenciaRegra);

      procedure adicionaDependencia(pDenpendencia: TipoWideStringFramework; pValor: TipoWideStringFramework);
      function verificaDependencias(pContexto: TDataset; pResultado: IResultadoOperacao=nil): boolean;

      property dependencias: TListaDependenciaRegra read getDependencias write setDependencias;
      property dadosOpcoes: IDadosSetOpcoes read getDadosOpcoes;
      property nome: TipoWideStringFramework read getNome write setNome;
      property descricao: TipoWideStringFramework read getDescricao write setDescricao;
      property tabela: TipoWideStringFramework read getTabela write setTabela;
      property campo: TipoWideStringFramework read getCampo write setCampo;
      property opcoes: TipoWideStringFramework read getOpcoes write setOpcoes;
      property obrigatorio: boolean read getObrigatorio write setObrigatorio;
    end;

    TDicionarioDadosCamposValidacoesTabela = IDictionary<TipoWideStringFramework,IDadosCamposValidacoes>;
    TDicionarioDadosCamposValidacoes = IDictionary<TipoWideStringFramework,TDicionarioDadosCamposValidacoesTabela>;
    TDicionarioSetValores = IDictionary<TipoWideStringFramework,IDadosSetOpcoes>;

  function registraOpcoesCampos(pNome, pOpcao, pOpcaoDescricao: String; pDescricao: String = ''): IDadosSetOpcoes;
  function registraValidacaoCampoTabela(pTabela, pCampo, pOpcoes: String; pDescricao: String = ''; pObrigatorio: boolean = false;pIgnoraExistente: boolean=false): IDadosCamposValidacoes;
  procedure configuraControlesEditOpcoesCampoTabela(pTabela: String; pOwner: TComponent; pDataSource: TDataSource);
  //procedure configuraEditOpcoesCampoTabela(pTabela: String; pObject: TComponent; pDataSource: TDataSource);
  function validaDataset(pTabela: String; pDataset: TDataset; pListaCampos: IListaString = nil; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  function retornaControleDataField(pCampo: String; pDatasource: TDataSource; pParent: TWinControl): TWinControl;
  function setFocoControleDataField(pCampo: String; pDatasource: TDataSource; pParent: TWinControl): TWinControl;

  var
    gOpcoesDefaultRegistradas: boolean;

implementation
  uses
    Terasoft.Framework.Validacoes,
    Terasoft.Framework.Log,
    Math,strUtils,
    Vcl.DBCtrls;

  type

    TDadosCamposValidacoesImpl=class(TInterfacedObject,IDadosCamposValidacoes)
    protected
      fNome: TipoWideStringFramework;
      fDescricao: TipoWideStringFramework;
      fObrigatorio: boolean;
      fOpcoes: TipoWideStringFramework;
      fTabela: TipoWideStringFramework;
      fCampo: TipoWideStringFramework;
      fDependencias: TListaDependenciaRegra;

      procedure adicionaDependencia(pDependencia: TipoWideStringFramework; pValor: TipoWideStringFramework);
      function verificaDependencias(pContexto: TDataset; pResultado: IResultadoOperacao): boolean;

    //property dependencias getter/setter
      function getDependencias: TListaDependenciaRegra;
      procedure setDependencias(const pValue: TListaDependenciaRegra);

    //property dadosOpcoes getter/setter
      function getDadosOpcoes: IDadosSetOpcoes;

    //property campo getter/setter
      function getCampo: TipoWideStringFramework;
      procedure setCampo(const pValue: TipoWideStringFramework);

    //property tabela getter/setter
      function getTabela: TipoWideStringFramework;
      procedure setTabela(const pValue: TipoWideStringFramework);

    //property opcoes getter/setter
      function getOpcoes: TipoWideStringFramework;
      procedure setOpcoes(const pValue: TipoWideStringFramework);

    //property obrigatorio getter/setter
      function getObrigatorio: boolean;
      procedure setObrigatorio(const pValue: boolean);

    //property descricao getter/setter
      function getDescricao: TipoWideStringFramework;
      procedure setDescricao(const pValue: TipoWideStringFramework);

    //property nome getter/setter
      function getNome: TipoWideStringFramework;
      procedure setNome(const pValue: TipoWideStringFramework);
    end;

    TDadosSetOpcoesImpl=class(TInterfacedObject,IDadosSetOpcoes)
    protected
      fNome: TipoWideStringFramework;
      fDescricao: TipoWideStringFramework;
      fListaValores: IListaTextoEX;
      fListaDescricoes: IListaTextoEX;
      fDataset: IDatasetSimples;

      function match(pValue: TipoWideStringFramework): boolean;
      procedure adicionaID_Descricao(const pID,pDescricao: TipoWideStringFramework);

    //property dataset getter/setter
      function getDataset: IDatasetSimples;
      procedure setDataset(const pValue: IDatasetSimples);

    //property listaDescricoes getter/setter
      function getListaDescricoes: IListaTextoEX;
      procedure setListaDescricoes(const pValue: IListaTextoEX);

    //property listaValores getter/setter
      function getListaValores: IListaTextoEX;
      procedure setListaValores(const pValue: IListaTextoEX);

    //property descricao getter/setter
      function getDescricao: TipoWideStringFramework;
      procedure setDescricao(const pValue: TipoWideStringFramework);

    //property nome getter/setter
      function getNome: TipoWideStringFramework;
      procedure setNome(const pValue: TipoWideStringFramework);
    end;

  var
    dicionarioDadosCamposValidacoes: TDicionarioDadosCamposValidacoes;
    dicionarioDadosCamposValidacoesInicializado: boolean;

    dicionarioSetValores: TDicionarioSetValores;
    dicionarioSetValoresInicializado: boolean;

procedure loadDicionarioCamposValidacoes;
  var
    dsRegras, dsDependencias: IDataset;
    dic: TDicionarioDadosCamposValidacoes;
    lTabela,lCampo,lNome: TipoWideStringFramework;
    validacacoesTabelas: TDicionarioDadosCamposValidacoesTabela;
    validacao: IDadosCamposValidacoes;
  label
    proximo1,proximo2;
begin
  if(dicionarioDadosCamposValidacoes=nil) then
    exit;
  dic := dicionarioDadosCamposValidacoes;
  dicionarioDadosCamposValidacoesInicializado := true;

  dsRegras := gdbPadrao.criaDataset;
  dsDependencias := gdbPadrao.criaDataset;
  dsRegras.query(
        'select'+#13+
        '    r.*'+#13+
        'from'+#13+
        '    regras r',
    '',[]);

  while not dsRegras.dataset.Eof do begin
    lTabela := UpperCase(trim(dsRegras.dataset.FieldByName('tabela').AsString));
    lCampo := UpperCase(trim(dsRegras.dataset.FieldByName('campo').AsString));
    lNome := UpperCase(trim(dsRegras.dataset.FieldByName('nome').AsString));
    if(lTabela='') or (lCampo='') or (lNome='') then goto proximo1;
    logaByTagSeNivel(TAGLOG_VALIDACOES,format('Registrando opção [%s] com valor [%s] e descrição [%s]', []),LOG_LEVEL_DEBUG);

    if not dic.TryGetValue(lTabela,validacacoesTabelas) then
    begin
      validacacoesTabelas := TCollections.CreateDictionary<TipoWideStringFramework,IDadosCamposValidacoes>(getComparadorOrdinalTipoWideStringFramework);
      dic.AddOrSetValue(lTabela,validacacoesTabelas);
    end;
    if not validacacoesTabelas.TryGetValue(lCampo,validacao) then
    begin
      validacao := TDadosCamposValidacoesImpl.Create;
      validacacoesTabelas.AddOrSetValue(lCampo,validacao);
    end;
    validacao.nome := lNome;
    validacao.descricao := dsRegras.dataset.FieldByName('descricao').AsString;
    validacao.tabela := lTabela;
    validacao.campo := lCampo;
    validacao.opcoes := dsRegras.dataset.FieldByName('valores').AsString;
    validacao.obrigatorio := dsRegras.dataset.FieldByName('obrigatorio').AsString<>'N';
    dsDependencias.query(
      'select'+#13+
         '    d.*'+#13+
         'from'+#13+
         '    regras_dependecias d'+#13+
         'where'+#13+
         '    d.regra=:regra',
      'regra',[lNome]
    );

    while not dsDependencias.dataset.Eof do
    begin
      validacao.adicionaDependencia(dsDependencias.dataset.FieldByName('dependencia').AsString, dsDependencias.dataset.FieldByName('valor_dependencia').AsString);
     proximo2:
      dsDependencias.dataset.Next;
    end;

   proximo1:
    dsRegras.dataset.Next;
  end;
end;

function getDicionarioDadosCamposValidacoes: TDicionarioDadosCamposValidacoes;
begin
  if(dicionarioDadosCamposValidacoes=nil) then
    dicionarioDadosCamposValidacoes:=TCollections.CreateDictionary<TipoWideStringFramework,TDicionarioDadosCamposValidacoesTabela>(getComparadorOrdinalTipoWideStringFramework);
  if(dicionarioDadosCamposValidacoesInicializado=false) and (gdbPadrao<>nil) and (gOpcoesDefaultRegistradas=true) then
    loadDicionarioCamposValidacoes;
  Result := dicionarioDadosCamposValidacoes;
end;

procedure loadDicionarioSetValores;
  var
    dsValores, dsDadosValores: IDataset;
    dic: TDicionarioSetValores;
    lNome: TipoWideStringFramework;
    dados: IDadosSetOpcoes;
    cnt: Integer;
  label
    proximo1,proximo2;
begin
  if(dicionarioSetValores=nil) then
    exit;
  logaByTagSeNivel(TAGLOG_VALIDACOES,'Inicio da leitura de regras_valores.',LOG_LEVEL_DEBUG);

  cnt := 0;
  try
    dic := dicionarioSetValores;
    dicionarioSetValoresInicializado := true;
    dsValores := gdbPadrao.criaDataset;
    dsDadosValores := gdbPadrao.criaDataset;
    dsValores.query(
          'select'+#13+
          '    v.nome'+#13+
          'from'+#13+
          '    regras_valores v'+#13+
          'group by'+#13+
          '    1',
      '',[]);

    while not dsValores.dataset.Eof do begin
      lNome := UpperCase(trim(dsValores.dataset.FieldByName('nome').AsString));
      if(lNome='') then goto proximo1;
      dsDadosValores.query(
          'select'+#13+
             '    v.*'+#13+
             'from'+#13+
             '    regras_valores v'+#13+
             'where'+#13+
             '    v.nome=:nome'+#13+
             'order by v.ordem',
      'nome',[lNome]);
      if(dsDadosValores.dataset.RecordCount=0) then goto proximo1;

      dados:=nil;
      if(dic.TryGetValue(lNome,dados)) then
      begin
        dados.dataset := nil;
        dados.listaDescricoes.Clear;
        dados.listaValores.Clear;
      end else
      begin
        dados := TDadosSetOpcoesImpl.Create;
        dados.nome := lNome;
        dados.descricao := lNome;
        dic.AddOrSetValue(lNome,dados);
      end;

      while not dsDadosValores.dataset.Eof do
      begin
        dados.adicionaID_Descricao(dsDadosValores.dataset.FieldByName('valor').AsString,dsDadosValores.dataset.FieldByName('descricao').AsString);
        inc(cnt);
       proximo2:
        dsDadosValores.dataset.Next;
      end;

     proximo1:
      dsValores.dataset.Next;
    end;
  finally
    logaByTagSeNivel(TAGLOG_VALIDACOES,format('Final da leitura de regras_valores com [%d] registros importados.',[cnt]),LOG_LEVEL_DEBUG);
  end;

end;

function getDicionarioSetValores: TDicionarioSetValores;
begin
  if(dicionarioSetValores=nil) then
    dicionarioSetValores:=TCollections.CreateDictionary<TipoWideStringFramework,IDadosSetOpcoes>(getComparadorOrdinalTipoWideStringFramework);
  Result := dicionarioSetValores;
  if(dicionarioSetValoresInicializado=false) and (gdbPadrao<>nil) and (gOpcoesDefaultRegistradas=true) then
    //Le da tabela...
    loadDicionarioSetValores
end;

function getValidacaoPorNome(pNome: String): IDadosCamposValidacoes;
  var
    dic: TDicionarioDadosCamposValidacoes;
    p: TPair<TipoWideStringFramework, TDicionarioDadosCamposValidacoesTabela>;
    r: TPair<TipoWideStringFramework,IDadosCamposValidacoes>;
begin
  Result := nil;
  pNome := UpperCase(trim(pNome));
  dic := getDicionarioDadosCamposValidacoes;
  for p in dic do
    for r in p.Value do
    begin
      if(r.Value.nome=pNome) then
      begin
        Result := r.Value;
        exit;
      end;
    end;
end;


function registraOpcoesCampos;//(const pNome, pOpcao, pOpcaoDescricao: String; pDescricao: String = ''): TDadosSetOpcoes;
  var
    dic: TDicionarioSetValores;
begin
  pNome := UpperCase(trim(pNome));
  if(pNome='') then exit;
  dic := getDicionarioSetValores;
  if not dic.TryGetValue(pNome,Result) then
  begin
    Result := TDadosSetOpcoesImpl.Create;
    Result.nome := pNome;
    Result.descricao := pDescricao;
    //Result.listaValores := novaListaTexto;
    //Result.listaDescricoes := novaListaTexto;
    //Result.dataset := getGenericID_DescricaoDataset;
    dic.AddOrSetValue(pNome,Result);
  end;

  Result.adicionaID_Descricao(pOpcao,pOpcaoDescricao);

end;

function registraValidacaoCampoTabela;//(pTabela, pCampo, pOpcoes: String; pDescricao: String = ''; pObrigatorio: boolean = false): IDadosSetOpcoes;
  var
    dic: TDicionarioDadosCamposValidacoes;
    dadosTabela: TDicionarioDadosCamposValidacoesTabela;
    //dadosCampo: IDadosCamposValidacoes;
begin
  dic := getDicionarioDadosCamposValidacoes;
  pTabela := UpperCase(trim(pTabela));
  pCampo := UpperCase(trim(pCampo));
  if(pTabela='') then exit;
  if(pCampo='') then exit;

  logaByTagSeNivel(TAGLOG_VALIDACOES,format('registraValidacaoCampoTabela: Tabela [%s], Campo [%s], Opções [%s], Descrição [%s], Obrigatório [%s].',[pTabela,pCampo,pOpcoes,pDescricao,ifThen(pObrigatorio,'S','N')]),LOG_LEVEL_DEBUG );

  if not dic.TryGetValue(pTabela,dadosTabela) then
  begin
    dadosTabela := TCollections.CreateDictionary<TipoWideStringFramework,IDadosCamposValidacoes>(getComparadorOrdinalTipoWideStringFramework);
    dic.AddOrSetValue(pTabela,dadosTabela);
  end;
  if not dadosTabela.TryGetValue(pCampo,Result) then
  begin
    Result := TDadosCamposValidacoesImpl.Create;
    dadosTabela.AddOrSetValue(pCampo,Result);
  end else if pIgnoraExistente=true then
  begin
    logaByTagSeNivel(TAGLOG_VALIDACOES,format('registraValidacaoCampoTabela: Configuração ja existe e sendo ignorada sua inclusão: Tabela [%s], Campo [%s], Opções [%s], Descrição [%s], Obrigatório [%s].',[pTabela,pCampo,pOpcoes,pDescricao,ifThen(pObrigatorio,'S','N')]),LOG_LEVEL_DEBUG,ls_Warning );
    exit;
  end;
  Result.tabela := pTabela;
  Result.campo := pCampo;
  Result.descricao := pDescricao;
  Result.opcoes := UpperCase(trim(pOpcoes));
  Result.obrigatorio := pObrigatorio;
end;

function validaDataset(pTabela: String; pDataset: TDataset; pListaCampos: IListaString = nil; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  var
    i: Integer;
    lValor, p1, lNomeCampo: TipoWideStringFramework;
    dic: TDicionarioDadosCamposValidacoes;
    dadosTabela: TDicionarioDadosCamposValidacoesTabela;
    dadosCampo: IDadosCamposValidacoes;
    lDependenciaMatch: boolean;
    opcoes: IDadosSetOpcoes;
    f: TField;
    save: Integer;
begin
  Result := CheckResultadoOperacao(pResultado);
  if(usaValidacoesNovas=false) then exit;
  save := pResultado.erros;
  pTabela := uppercase(trim(pTabela));
  if(pTabela='') then
  begin
    pResultado.adicionaErro('Nome da tabela inválida.');
    exit;
  end;

  if( (pDataset=nil) or (pDataset.Active=false) ) then
  begin
    pResultado.adicionaErro('validaDataset: Não informou um dataset válido');
    exit;
  end;
  if(pListaCampos=nil) then
    pListaCampos := getStringList;

  if(pListaCampos.Count=0) then
  begin
    for i := 0 to pDataset.Fields.Count - 1 do
      pListaCampos.Add(pDataset.Fields[i].FieldName);
  end;

  dic := getDicionarioDadosCamposValidacoes;
  if not dic.TryGetValue(pTabela,dadosTabela) then
    exit;

  for p1 in pListaCampos do
  begin
    lNomeCampo := uppercase(trim(p1));
    if(lNomeCampo='') then continue;
    if not dadosTabela.TryGetValue(lNomeCampo,dadosCampo) then continue;
    if(dadosCampo.obrigatorio=false) then continue;

    f := pDataset.FindField(lNomeCampo);
    if(f=nil) then
    begin
      pResultado.formataErro('validaDataset: Campo [%s] [%s] não fornecido', [lNomeCampo, dadosCampo.descricao ]);
      continue;
    end;
    opcoes := dadosCampo.dadosOpcoes;
    if(opcoes=nil) then
    begin
      pResultado.formataErro('validaDataset: Campo [%s] [%s] não configurado lista de opções', [lNomeCampo, dadosCampo.descricao ]);
      continue;
    end;

    lDependenciaMatch := dadosCampo.verificaDependencias(pDataset,pResultado);
    //Implementar dependencias

    if(lDependenciaMatch=false) or (pResultado.erros<>save) then continue;

    lDependenciaMatch := opcoes.match(f.AsString);// false;
    {for lValor in opcoes.listaValores do
    begin
      if(CompareText(lValor,'null')=0) then
        lDependenciaMatch := f.AsString='' //f.IsNull=true
      else if(CompareText(lValor,'notnull')=0) then
        lDependenciaMatch := f.AsString<>''// f.IsNull=false
      else
        lDependenciaMatch := f.AsString=lValor;

      if(lDependenciaMatch=true) then
        break;
    end;}
    if(lDependenciaMatch=false) then begin
      pResultado.propriedade['campo.erro'].asString := dadosCampo.campo;
      pResultado.formataErro('Valor do Campo [%s] inválido', [ dadosCampo.descricao ]);
    end;
  end;
end;

function setFocoControleDataField;//(pCampo: String; pDatasource: TDataSource): TWinControl;
  var
    controle: TWinControl;
begin
  controle := retornaControleDataField(pCampo, pDatasource, pParent);
  if(assigned(controle)) then
  begin
    controle.Show;
    if(controle.CanFocus) then
      controle.SetFocus;
  end;

end;

function retornaControleDataField(pCampo: String; pDatasource: TDataSource; pParent: TWinControl): TWinControl;
  var
    i: Integer;

  procedure testa(cmp: TControl);
  begin
    if(cmp=nil) then
      exit;
    if(cmp is TDBEdit) then
    begin
      with TDBEdit(cmp) do
      begin
        if(DataSource=pDatasource) and (DataField=pCampo) then
          Result := TDBEdit(cmp);
      end;
    end else if(cmp is TDBRadioGroup) then
    begin
      with TDBRadioGroup(cmp) do
      begin
        if(DataSource=pDatasource) and (DataField=pCampo) then
          Result := TDBRadioGroup(cmp);
      end;
    end else if(cmp is TDBComboBox) then
    begin
      with TDBComboBox(cmp) do
      begin
        if(DataSource=pDatasource) and (DataField=pCampo) then
          Result := TDBComboBox(cmp);
      end;
    end else if(cmp is TDBLookupComboBox) then
    begin
      with TDBLookupComboBox(cmp) do
      begin
        if(DataSource=pDatasource) and (DataField=pCampo) then
          Result := TDBLookupComboBox(cmp);
      end;
    end;
  end;

begin
  Result := nil;
  testa(pParent);
  if(Result<>nil) then exit;
  if(pParent<>nil) then
    for i := 0 to pParent.ControlCount - 1 do
    begin
      if not (pParent.Controls[i] is TWinControl) then continue;
      
      Result := retornaControleDataField(pCampo,pDataSource,TWinControl(pParent.Controls[i]));
      //testa(pParent.Controls[i]);
      if(Result<>nil) then exit;
    end;
end;

procedure configuraEditOpcoesCampoTabela(pTabela: String; pObject: TComponent; pDataSource: TDataSource);
  var
//    dados: TDadosCamposLookupOld;
    lRG: TDBRadioGroup;
    lLkp: TDBLookupComboBox;
    dataField: String;
    dic: TDicionarioDadosCamposValidacoes;
    dadosTabela: TDicionarioDadosCamposValidacoesTabela;
    dadosCampo: IDadosCamposValidacoes;
    opcoes: IDadosSetOpcoes;
begin
  dic := getDicionarioDadosCamposValidacoes;
  if(pObject=nil) then exit;
  pTabela := UpperCase(trim(pTabela));
  if(pTabela='') then exit;
  if not dic.TryGetValue(pTabela,dadosTabela) then exit;

  lRG:=nil;
  lLkp := nil;
  dataField:='';
  if (pObject is TDBRadioGroup) then
  begin
    lRG := TDBRadioGroup(pObject);
    if(lRG.DataSource=pDataSource) then
      dataField := lRG.DataField;
  end else if (pObject is TDBLookupComboBox) then
  begin
    lLkp := TDBLookupComboBox(pObject);
    if(lLkp.DataSource=pDataSource) then
      dataField := lLkp.DataField;
  end;
//    logaByTagSeNivel(TAGLOG_VALIDACOES,format('Controle TDBLookupComboBox [%s] [%s] para a tabela [%s] não possui um tipo reconhecido ', [pObject.ClassName, pObject.Name, pTabela]),LOG_LEVEL_DEBUG);

  dataField := UpperCase(trim(dataField));
  if(dataField='') then exit;

  if dadosTabela.TryGetValue(dataField,dadosCampo) then
  begin
    opcoes := dadosCampo.dadosOpcoes;
    if(opcoes=nil) then exit;
    if assigned(lRG) then
    begin
      lRG.Values.Text := opcoes.listaValores.text;
      lRG.Items.Text := opcoes.listaDescricoes.text;
      logaByTagSeNivel(TAGLOG_VALIDACOES,format('Configurando controle TDBRadioGroup [%s] para a tabela [%s]: campo [%s]: Valores [%s]: Items [%s] ', [pObject.Name, pTabela,dataField, opcoes.listaValores.text, opcoes.listaDescricoes.text]),LOG_LEVEL_DEBUG);
      exit;
    end else if assigned(lLkp) then begin
      lLkp.ListField := 'descricao';
      lLkp.KeyField := 'ID';
      logaByTagSeNivel(TAGLOG_VALIDACOES,format('Configurando controle TDBLookupComboBox [%s] para a tabela [%s]: campo [%s]: Valores [%s]: Items [%s] ', [pObject.Name, pTabela,dataField, opcoes.listaValores.text, opcoes.listaDescricoes.text]),LOG_LEVEL_DEBUG);
      lLkp.ListSource := opcoes.dataset.dataSource;
      exit;
    end;
  end;
end;

procedure configuraControlesEditOpcoesCampoTabela;//(pTabela: String; pOwner: TWinControl);
  var
    i: Integer;
    p: TComponent;
begin
  if(usaValidacoesNovas=false) then exit;
  pTabela := UpperCase(trim(pTabela));
  if(pTabela='') or not assigned(pOwner) then exit;

//  logaByTagSeNivel(TAGLOG_VALIDACOES,format('Configurando controle configura owner [%s] para a tabela [%s]', [pOwner.Name,pTabela]),LOG_LEVEL_DEBUG);

  configuraEditOpcoesCampoTabela(pTabela,pOwner,pDataSOurce);

  if not (pOwner is TWinControl) then exit;

  with TWinControl(pOwner) do
  begin
    i := ControlCount;
    while i > 0 do
    begin
      dec(i);
      configuraControlesEditOpcoesCampoTabela(pTabela,Controls[i],pDataSource);
      //configuraEditOpcoesCampoTabela(pTabela,Controls[i],pDataSource);
    end;
  end;
end;


{ TDadosCamposValidacoesImpl }

procedure TDadosCamposValidacoesImpl.setDependencias(const pValue: TListaDependenciaRegra);
begin
  fDependencias := pValue;
end;

function TDadosCamposValidacoesImpl.getDependencias: TListaDependenciaRegra;
begin
  if(fDependencias=nil) then
    fDependencias := TCollections.CreateList<TDependenciaRegra>;
  Result := fDependencias;
end;

function TDadosCamposValidacoesImpl.getDadosOpcoes: IDadosSetOpcoes;
begin
  getDicionarioSetValores.TryGetValue(fOpcoes,Result);
end;

procedure TDadosCamposValidacoesImpl.setCampo(const pValue: TipoWideStringFramework);
begin
  fCampo := UpperCase(trim(pValue));
end;

procedure TDadosCamposValidacoesImpl.adicionaDependencia(pDependencia,  pValor: TipoWideStringFramework);
begin
  getDependencias.Add(TDependenciaRegra.Create(pDependencia,pValor));
end;

function TDadosCamposValidacoesImpl.getCampo: TipoWideStringFramework;
begin
  Result := fCampo;
end;

procedure TDadosCamposValidacoesImpl.setTabela(const pValue: TipoWideStringFramework);
begin
  fTabela := UpperCase(trim(pValue));
end;

function TDadosCamposValidacoesImpl.verificaDependencias;
  var
    p: TDependenciaRegra;
    regra: IDadosCamposValidacoes;
    f: TField;
    lValor: String;
    lLista: IListaTextoEX;
begin
  checkResultadoOperacao(pResultado);
  Result := getDependencias.Count=0;
  if Result or (pContexto=nil) or (pContexto.Active=false) then
    exit;

  lLista := novaListaTexto;

  for p in fDependencias do
  begin
    regra := getValidacaoPorNome(p.Key);
    if(regra=nil) then continue;
    if(regra.tabela<>fTabela) then begin
      pResultado.formataErro('TDadosCamposValidacoesImpl.verificaDependencias: Tabela da dependencia [%s.%s] diferente da tabela dependente[%s.%s].', [regra.nome, regra.tabela,fNome,fTabela]);
      exit;
    end;
    f := pContexto.FindField(regra.campo);
    if(f=nil) then
    begin
      pResultado.formataErro('TDadosCamposValidacoesImpl.verificaDependencias: Campo da regra [%s.%s] não existe no contexto fornecido.', [regra.nome, regra.campo]);
      exit;
    end;
    lValor:=trim(p.Value);
    if(lValor='') then
      Result := f.AsString=''// f.IsNull=true
    else if(CompareText(lValor,'notnull')=0) then
      Result := f.AsString<>''// f.IsNull=false
    else
    begin
      lLista.text := lValor;
      Result := lLista.strings.IndexOf(f.AsString)<>-1;
    end;
    if(Result) then exit;
  end;
end;

function TDadosCamposValidacoesImpl.getTabela: TipoWideStringFramework;
begin
  Result := fTabela;
end;

procedure TDadosCamposValidacoesImpl.setOpcoes(const pValue: TipoWideStringFramework);
begin
  fOpcoes := UpperCase(trim(pValue));
end;

function TDadosCamposValidacoesImpl.getOpcoes: TipoWideStringFramework;
begin
  Result := fOpcoes;
end;

procedure TDadosCamposValidacoesImpl.setObrigatorio(const pValue: boolean);
begin
  fObrigatorio := pValue;
end;

function TDadosCamposValidacoesImpl.getObrigatorio: boolean;
begin
  Result := fObrigatorio;
end;

procedure TDadosCamposValidacoesImpl.setDescricao(const pValue: TipoWideStringFramework);
begin
  if(pValue<>'') then
    fDescricao := pValue;
end;

function TDadosCamposValidacoesImpl.getDescricao: TipoWideStringFramework;
begin
  Result := fDescricao;
end;

procedure TDadosCamposValidacoesImpl.setNome(const pValue: TipoWideStringFramework);
begin
  fNome := UpperCase(trim(pValue));
end;

function TDadosCamposValidacoesImpl.getNome: TipoWideStringFramework;
begin
  Result := fNome;
end;

{ TDadosSetOpcoesImpl }

procedure TDadosSetOpcoesImpl.setDataset(const pValue: IDatasetSimples);
begin
  fDataset := pValue;
end;

procedure TDadosSetOpcoesImpl.adicionaID_Descricao(const pID,  pDescricao: TipoWideStringFramework);
begin
  logaByTagSeNivel(TAGLOG_VALIDACOES,format('Registrando opção [%s] com valor [%s] e descrição [%s]', [fNome,pID,pDescricao]),LOG_LEVEL_DEBUG);
  getListaValores.strings.Add(pID);
  getListaDescricoes.strings.Add(pDescricao);
  with getDataset.dataset do
  begin
    Append;
    FieldByName('ID').AsString := pID;
    FieldByName('descricao').AsString := pDescricao;
    CheckBrowseMode;
  end;
end;

function TDadosSetOpcoesImpl.getDataset: IDatasetSimples;
begin
  if(fDataset=nil) then
    fDataset:=getGenericID_DescricaoDataset;
  Result := fDataset;
end;

procedure TDadosSetOpcoesImpl.setListaDescricoes(const pValue: IListaTextoEX);
begin
  fListaDescricoes := pValue;
end;

function TDadosSetOpcoesImpl.getListaDescricoes: IListaTextoEX;
begin
  if(fListaDescricoes=nil) then
    fListaDescricoes := novaListaTexto;
  Result := fListaDescricoes;
end;

procedure TDadosSetOpcoesImpl.setListaValores(const pValue: IListaTextoEX);
begin
  fListaValores := pValue;
end;

function TDadosSetOpcoesImpl.getListaValores: IListaTextoEX;
begin
  if(fListaValores=nil) then
    fListaValores := novaListaTexto;
  Result := fListaValores;
end;

procedure TDadosSetOpcoesImpl.setDescricao(const pValue: TipoWideStringFramework);
begin
  fDescricao := pValue;
end;

function TDadosSetOpcoesImpl.getDescricao: TipoWideStringFramework;
begin
  Result := fDescricao;
end;

procedure TDadosSetOpcoesImpl.setNome(const pValue: TipoWideStringFramework);
begin
  fNome := UpperCase(trim(pValue));
end;

function TDadosSetOpcoesImpl.getNome: TipoWideStringFramework;
begin
  Result := fNome;
end;

function TDadosSetOpcoesImpl.match(pValue: TipoWideStringFramework): boolean;
  var
    s: TipoWideStringFramework;
    lValor: String;
    _not: boolean;
begin
  Result := false;
  for s in getListaValores do
  begin
    _not:=false;
    lValor := trim(s);
    //_not := Pos('<!>',lValor) > 0;
    if(CompareText(lValor,'null')=0) then
      Result := pValue=''
    else if(CompareText(lValor,'notnull')=0) then
      Result := pValue<>''
    else if(CompareText(lValor,'<@>')=0) then
      Result := validaEmail(pValue)
    else if(CompareText(lValor,'<cnpj>')=0) then
      Result := validaCNPJ(pValue)
    else if(CompareText(lValor,'<cpf>')=0) then
      Result := validaCPF(pValue)
    else if(CompareText(lValor,'<cnpjcpf>')=0) then
      Result := validaCNPJCPF(pValue)
    else if(CompareText(lValor,'<chavenfe>')=0) then
      Result := validaChaveNFe(pValue)
    else if(CompareText(lValor,'<uf>')=0) then
      Result := validaUF(pValue)
    else if(CompareText(lValor,'<imei>')=0) then
      Result := validaIMEI(pValue)
    else
      Result := pValue=lValor;
      if(Result=true) then
        exit;
  end;
end;

{

function validaDatasetOld;//(pDataset: TDataset; pListaCampos: IListaString = nil; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  var
    i: Integer;
    lDSRegra,lDSDependencia,lDSValores: IDataset;
    p: TipoWideStringFramework;
    lNomeCampo: String;
    lDependenciaMatch: boolean;
    lValor: String;
    f: TField;
    lLista: IListaTextoEX;

    label proximo1,proximo2;

begin
  Result := CheckResultadoOperacao(pResultado);
  pTabela := uppercase(trim(pTabela));
  if(pTabela='') then
  begin
    pResultado.adicionaErro('Nome da tabela inválida.');
    exit;
  end;

  if( (pDataset=nil) or (pDataset.Active=false) ) then
  begin
    pResultado.adicionaErro('validaDataset: Não informou um dataset válido');
    exit;
  end;
  if(pListaCampos=nil) then
    pListaCampos := getStringList;

  if(pListaCampos.Count=0) then
  begin
    for i := 0 to pDataset.Fields.Count - 1 do
      pListaCampos.Add(pDataset.Fields[i].FieldName);
  end;

  lDSRegra := gdbPadrao.criaDataset;
  lDSDependencia := gdbPadrao.criaDataset;
  lDSValores := gdbPadrao.criaDataset;

  lLista := novaListaTextoEx(false,'');

  for p in pListaCampos do
  begin
    lNomeCampo := uppercase(trim(p));
    if(p='') then continue;
    lDSRegra.query('select r.*'+#13+
         '    from regras r'+#13+
         '        where'+#13+
         '            r.tabela=:tabela'+#13+
         '            and r.campo=:campo',
     'tabela;campo',[pTabela,lNomeCampo]);

    if((lDSRegra.dataset.RecordCount=0) or (lDSRegra.dataset.FieldByName('obrigatorio').AsString<>'S')) then continue;


    lDSDependencia.query(
         'select'+#13+
         '    r.*,'+#13+
         '    d.valor_dependencia'+#13+
         '    from'+#13+
         '        regras_dependecias d,'+#13+
         '        regras r'+#13+
         '    where'+#13+
         '        r.nome=d.dependencia'+#13+
         '        and d.regra=:regra',
      'regra',[lDSRegra.dataset.FieldByName('nome').AsString]);

    lDependenciaMatch := lDSDependencia.dataset.RecordCount=0;

    if(lDependenciaMatch=false) then
    begin
      while not lDSDependencia.dataset.Eof do
      begin
        if(lDSDependencia.dataset.FieldByName('tabela').AsString<>pTabela) then begin
          pResultado.formataErro('validaDataset: Tabela de dependência diverge da tabela requerida: [%s] e [%s]', [ lDSDependencia.dataset.FieldByName('tabela').AsString, pTabela ]);
          goto proximo1;
        end;
        lValor:=trim(lDSDependencia.dataset.FieldByName('valor_dependencia').AsString);
        f := pDataset.FindField(lDSDependencia.dataset.FieldByName('campo').AsString);
        if(f=nil) then
        begin
          pResultado.formataErro('validaDataset: Campo [%s] [%s] não fornecido', [ lDSDependencia.dataset.FieldByName('campo').AsString, lDSDependencia.dataset.FieldByName('descricaocampo').AsString ]);
          goto proximo1;
        end;
        if(lValor='') then
        begin
          lDependenciaMatch := f.IsNull=true;
        end else if(CompareText(lValor,'notnull')=0) then
        begin
          lDependenciaMatch := f.IsNull=false;
        end else begin
          lLista.text := lValor;
          lDependenciaMatch := lLista.strings.IndexOf(f.AsString)<>-1;
        end;
       proximo1:
        if(lDependenciaMatch=true) then break;
        lDSDependencia.dataset.Next;
      end;
      if(lDependenciaMatch=false) then continue;
    end;
    lDSValores.query(
          'select'+#13+
          '    v.*'+#13+
          '    from'+#13+
          '       regras_valores v'+#13+
          '    where'+#13+
          '        v.nome = :nome',
        'nome', [ lDSRegra.dataset.FieldByName('valores').AsString ]);
    if(lDSValores.dataset.RecordCount=0) then
    begin
       pResultado.formataErro('validaDataset: Não existem valores configurados para a regra [%s]', [ lDSRegra.dataset.FieldByName('valores').AsString ]);
       continue;
    end;
    f := pDataset.FindField(lDSRegra.dataset.FieldByName('campo').AsString);
    if(f=nil) then
    begin
      pResultado.formataErro('validaDataset: Campo [%s] [%s] não fornecido', [ lDSRegra.dataset.FieldByName('campo').AsString, lDSRegra.dataset.FieldByName('descricaocampo').AsString ]);
      continue;
    end;

    lDependenciaMatch := false;

    while not lDSValores.dataset.Eof do
    begin
      lValor:=trim(lDSValores.dataset.FieldByName('valor').AsString);
      if(CompareText(lValor,'null')=0) then
      begin
        lDependenciaMatch := f.IsNull=true;
      end else if(CompareText(lValor,'notnull')=0) then
      begin
        lDependenciaMatch := f.IsNull=false;
      end else
        lDependenciaMatch := f.AsString=lValor;

     proximo2:
      if(lDependenciaMatch=true) then
        break;
      lDSValores.dataset.Next;
    end;
    if(lDependenciaMatch=false) then
      pResultado.formataErro('validaDataset: Valor do Campo [%s] inválido', [ lDSRegra.dataset.FieldByName('descricaocampo').AsString ]);
  end;
end;

function getDadosCamposLookupOld;//(pTabela: String; pCampos: IListaString): TDadosCampos;
  var
    lDS: IDataset;
    p: TipoWideStringFramework;
    lCampo: String;
    lRec: TDadosCamposRecOld;
    tmp: String;
    lDadosCampoLookup: TDadosCamposLookupOld;
    par: TPair<TipoWideStringFramework,TDadosCamposRecOld>;
begin
  Result := TCollections.CreateDictionary<TipoWideStringFramework,TDadosCamposRecOld>(getComparadorOrdinalTipoWideStringFramework);
  lRec.valido := true;
  pTabela := uppercase(trim(pTabela));
  if(pTabela='') then exit;

  if not dicionarioDadosOld.TryGetValue(pTabela,lDadosCampoLookup) then
  begin
    lDadosCampoLookup := TCollections.CreateDictionary<TipoWideStringFramework,TDadosCamposRecOld>(getComparadorOrdinalTipoWideStringFramework);
    dicionarioDadosOld.AddOrSetValue(pTabela,lDadosCampoLookup);
  end;

  if(dicionarioDadosOld=nil) then
    dicionarioDadosOld := TCollections.CreateDictionary<TipoWideStringFramework,TDadosCamposLookupOld>(getComparadorOrdinalTipoWideStringFramework);

  if (pCampos=nil) then
    pCampos := getStringList;

  lDS := gdbPadrao.criaDataset;
  if(pCampos.Count=0)then
  begin
    lDS.query('select campo from regras where tabela=:tabela','tabela',[pTabela]);
    while not lDS.dataset.Eof do
    begin
      pCampos.Add(lDS.dataset.FieldByName('campo').AsString);
      lDS.dataset.Next;
    end;
  end;
  for par in lDadosCampoLookup do
    if(par.Value.valido) then
      pCampos.Add(par.Value.campo);

  lRec.tabela := pTabela;
  lRec.campo := '';

  for p in pCampos do
  begin
    lCampo := uppercase(trim(p));
    if(lCampo='') then continue;
    if not lDadosCampoLookup.TryGetValue(lCampo,lRec) then
    begin
      lRec.valido := true;
      lRec.padrao :=true;
      lRec.campo  := lCampo;
      lRec.tabela := pTabela;
      //lRec.listaValores := novaListaTextoEx;
      //lRec.listaDescricoes := novaListaTextoEx;
      //lRec.dataset := getGenericID_DescricaoDataset;
    end else
      Result.AddOrSetValue(lRec.campo,lRec);

    if(lRec.padrao=false) then
    begin
      Result.AddOrSetValue(lRec.campo,lRec);
      continue;
    end;
    lRec.padrao :=false;
    lRec.campo  := lCampo;
    //lRec.listaValores := novaListaTextoEx;
    //lRec.listaDescricoes := novaListaTextoEx;
    //lRec.dataset := getGenericID_DescricaoDataset;
    lDS.query(
          'select'+#13+
          '    r.*, v.valor, v.descricao descricaovalor'+#13+
          'from'+#13+
          '    regras r'+#13+
          'left join'+#13+
          '    regras_valores v'+#13+
          '        on'+#13+
          '            v.nome=r.valores'+#13+
          'where'+#13+
          '    r.tabela=:tabela'+#13+
          '    and r.campo=:campo'+#13+
          'order by'+#13+
          '    r.tabela, r.campo, v.ordem',
      'tabela;campo', [ pTabela, lCampo ]);

    if(lDS.dataset.FieldByName('descricaocampo').AsString<>'') then
      lRec.descricao := lDS.dataset.FieldByName('descricaocampo').AsString;

    while not lDS.dataset.Eof do
    begin
      tmp := lDS.dataset.FieldByName('valor').AsString;
      if((CompareText(tmp,'null')<>0) and (CompareText(tmp,'notnull')<>0) and (tmp<>'') ) then
      begin
        lRec.listaValores.strings.Add(tmp);
        lRec.listaDescricoes.strings.Add(lDS.dataset.FieldByName('descricaovalor').AsString);
        lRec.dataset.dataset.Append;
        lRec.dataset.dataset.FieldByName('id').AsString := tmp;
        lRec.dataset.dataset.FieldByName('descricao').AsString := lDS.dataset.FieldByName('descricaovalor').AsString;
        lRec.dataset.dataset.CheckBrowseMode;
      end;
      lDS.dataset.Next;
    end;
    Result.AddOrSetValue(lRec.campo,lRec);
    lDadosCampoLookup.AddOrSetValue(lRec.campo,lRec);
  end;

end;
}

initialization
  registraLogger(TAGLOG_VALIDACOES,'Validacoes',true);


end.
