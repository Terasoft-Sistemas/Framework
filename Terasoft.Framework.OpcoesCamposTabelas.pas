
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

  function getValidadorDatabase(pGDB: IGDB): IValidadorDatabase;

  procedure configuraControlesEditOpcoesCampoTabela(pTabela: String; pOwner: TComponent; pDataSource: TDataSource; pGDB: IGDB=nil );

implementation
  uses
    Terasoft.Framework.Validacoes,
    Terasoft.Framework.Log,
    Math,strUtils,
    Vcl.DBCtrls;

  type
    TValidadorDatabaseImpl = class(TInterfacedObject, IValidadorDatabase)
    protected

      fGDB: IGDB;

      dicionarioRegrasDadosCamposValidacoesInicializado: boolean;
      dicionarioRegrasDadosCamposValidacoes: TDicionarioRegrasDadosCamposValidacoes;

      dicionarioSetValores: TDicionarioSetValores;
      dicionarioSetValoresInicializado: boolean;

      fOpcoesDefaultRegistradas: boolean;

    //property gdb getter/setter
      function getGDB: IGDB;
      procedure setGDB(const pValue: IGDB);

    //property opcoesDefaultRegistradas getter/setter
      function getOpcoesDefaultRegistradas: boolean;
      procedure setOpcoesDefaultRegistradas(const pValue: boolean);

      function registraOpcoesCampos(pNome, pOpcao: String; pOpcaoDescricao: String = ''; pDescricao: String = ''): IDadosSetOpcoes;
      function registraValidacaoCampoTabela(pRegra,pTabela, pCampo, pOpcoes: String; pDescricao: String = ''; pObrigatorio: boolean = false;pIgnoraExistente: boolean=false): IDadosCamposValidacoes;
      procedure configuraControlesEditOpcoesCampoTabela(pTabela: String; pOwner: TComponent; pDataSource: TDataSource);
      function validaDataset(pRegra, pTabela: String; pDataset: TDataset; pListaCampos: IListaString = nil; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
      function retornaControleDataField(pCampo: String; pDatasource: TDataSource; pParent: TWinControl): TWinControl;
      function setFocoControleDataField(pCampo: String; pDatasource: TDataSource; pParent: TComponent): TComponent;
      function getDicionarioRegrasDadosCamposValidacoes(pRegra: TipoWideStringFramework = ''): TDicionarioDadosCamposValidacoes;
      function getDicionarioSetValores: TDicionarioSetValores;
      procedure configuraEditOpcoesCampoTabela(pTabela: String; pObject: TComponent; pDataSource: TDataSource);
      procedure loadDicionarioSetValores;
      procedure loadDicionarioCamposValidacoes;
      function getValidacaoPorNome(pNome: String): IDadosCamposValidacoes;
    public
      destructor Destroy; override;
    end;

    TDadosCamposValidacoesImpl=class(TInterfacedObject,IDadosCamposValidacoes)
    protected
      fNome: TipoWideStringFramework;
      fDescricao: TipoWideStringFramework;
      fObrigatorio: boolean;
      fOpcoes: TipoWideStringFramework;
      fTabela: TipoWideStringFramework;
      fCampo: TipoWideStringFramework;
      fDependencias: TListaDependenciaRegra;
      fRegra: TipoWideStringFramework;

    //property regra getter/setter
      function getRegra: TipoWideStringFramework;
      procedure setRegra(const pValue: TipoWideStringFramework);

      procedure adicionaDependencia(pDependencia: TipoWideStringFramework; pValor: TipoWideStringFramework);
      function verificaDependencias(pContexto: TDataset; pValidador: IValidadorDatabase; pResultado: IResultadoOperacao): boolean;

    //property dependencias getter/setter
      function getDependencias: TListaDependenciaRegra;
      procedure setDependencias(const pValue: TListaDependenciaRegra);

    //property dadosOpcoes getter/setter
      function getDadosOpcoes(pValidador: IValidadorDatabase): IDadosSetOpcoes;
      //function getDadosOpcoes: IDadosSetOpcoes;

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
    public
      destructor Destroy; override;
    end;
{
  var
    dicionarioRegrasDadosCamposValidacoesInicializado: boolean;
    dicionarioRegrasDadosCamposValidacoes: TDicionarioRegrasDadosCamposValidacoes;

    dicionarioSetValores: TDicionarioSetValores;
    dicionarioSetValoresInicializado: boolean;

function getDicionarioRegrasDadosCamposValidacoes(pRegra: TipoWideStringFramework = ''): TDicionarioDadosCamposValidacoes;
begin
  if(pRegra='') then
    pRegra := 'padrao';
  pRegra := uppercase(trim(pRegra));
  if(dicionarioRegrasDadosCamposValidacoes=nil) then
    dicionarioRegrasDadosCamposValidacoes:=TCollections.CreateDictionary<TipoWideStringFramework,TDicionarioDadosCamposValidacoes>(getComparadorOrdinalTipoWideStringFramework);
  if(dicionarioRegrasDadosCamposValidacoesInicializado=false) and (gdbPadrao<>nil) and (gOpcoesDefaultRegistradas=true) then
    loadDicionarioCamposValidacoes;
  if not dicionarioRegrasDadosCamposValidacoes.TryGetValue(pRegra,Result) then
  begin
    Result := TCollections.CreateDictionary<TipoWideStringFramework,TDicionarioDadosCamposValidacoesTabela>(getComparadorOrdinalTipoWideStringFramework);
    dicionarioRegrasDadosCamposValidacoes.AddOrSetValue(pRegra,Result);
  end;
end;

function registraOpcoesCampos;
  var
    dic: TDicionarioSetValores;
begin
  if(pOpcaoDescricao='') then
    pOpcaoDescricao:=pOpcao;
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
  if(pRegra='') then
    pRegra:='padrao';
  pRegra := uppercase(trim(pRegra));
  dic := getDicionarioRegrasDadosCamposValidacoes(pRegra);
  pTabela := UpperCase(trim(pTabela));
  pCampo := UpperCase(trim(pCampo));
  if(pTabela='') then exit;
  if(pCampo='') then exit;

  logaByTagSeNivel(TAGLOG_VALIDACOES,format('registraValidacaoCampoTabela: Regra: [%s], Tabela [%s], Campo [%s], Opções [%s], Descrição [%s], Obrigatório [%s].',[pRegra,pTabela,pCampo,pOpcoes,pDescricao,ifThen(pObrigatorio,'S','N')]),LOG_LEVEL_DEBUG );

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
  Result.regra := pRegra;
  Result.tabela := pTabela;
  Result.campo := pCampo;
  Result.descricao := pDescricao;
  Result.opcoes := UpperCase(trim(pOpcoes));
  Result.obrigatorio := pObrigatorio;
end;


function validaDataset;
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
  if(pRegra='') then
    pRegra := 'padrao';
  if(pTabela='') then
  begin
    pResultado.adicionaErro('validaDataset: Nome da tabela inválida.');
    exit;
  end;

  if( (pDataset=nil) or (pDataset.Active=false) ) then
  begin
    pResultado.adicionaErro('validaDataset: Não informou um dataset válido');
    exit;
  end;
  if( not pDataset.RecordCount=0) and (pDataset.State = dsBrowse) then
  begin
    pResultado.adicionaErro('validaDataset: Não possui registros para serem validados');
    exit;
  end;

  if(pListaCampos=nil) then
    pListaCampos := getStringList;

  pRegra := uppercase(trim(pRegra));
  pTabela := uppercase(trim(pTabela));

  if(pListaCampos.Count=0) then
  begin
    for i := 0 to pDataset.Fields.Count - 1 do
      pListaCampos.Add(pDataset.Fields[i].FieldName);
  end;

  dic := getDicionarioRegrasDadosCamposValidacoes(pRegra);
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

    if(lDependenciaMatch=false) then continue;

    lDependenciaMatch := opcoes.match(f.AsString);// false;
    if(lDependenciaMatch=false) then begin
      if(pResultado.propriedade['campo.erro'].asString='') then
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
}

{ TDadosCamposValidacoesImpl }

procedure TDadosCamposValidacoesImpl.setRegra(const pValue: TipoWideStringFramework);
begin
  fRegra := uppercase(trim(pValue));
end;

function TDadosCamposValidacoesImpl.getRegra: TipoWideStringFramework;
begin
  if(fRegra='') then
    fRegra := 'PADRAO';
  Result := fRegra;
end;

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

function TDadosCamposValidacoesImpl.getDadosOpcoes;//: IDadosSetOpcoes;
begin
  pValidador.getDicionarioSetValores.TryGetValue(fOpcoes,Result);
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
  if Result or (pContexto=nil) or (pContexto.Active=false) or (pValidador=nil) then
    exit;

  lLista := novaListaTexto;

  for p in fDependencias do
  begin
    regra := pValidador.getValidacaoPorNome(p.Key);
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

destructor TDadosSetOpcoesImpl.Destroy;
begin
  fListaValores:=nil;
  fListaDescricoes:=nil;
  fDataset:=nil;
  inherited;
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
    else if(CompareText(lValor,'<naozero>')=0) then
      Result := StrToFloatDef(somenteNumeros(pValue),0)<>0.0
    else
      Result := pValue=lValor;
      if(Result=true) then
        exit;
  end;
end;

{ TValidadorDatabaseImpl }

procedure TValidadorDatabaseImpl.setGDB(const pValue: IGDB);
begin
  fGDB := pValue;
end;

function TValidadorDatabaseImpl.getGDB: IGDB;
begin
  Result := fGDB;
end;

procedure TValidadorDatabaseImpl.setOpcoesDefaultRegistradas(const pValue: boolean);
begin
  fOpcoesDefaultRegistradas := pValue;
end;

function TValidadorDatabaseImpl.getOpcoesDefaultRegistradas: boolean;
begin
  Result := fOpcoesDefaultRegistradas;
end;

function getValidadorDatabase(pGDB: IGDB): IValidadorDatabase;
begin
  Result := TValidadorDatabaseImpl.Create;
  Result.gdb := pGDB;
end;

procedure TValidadorDatabaseImpl.configuraControlesEditOpcoesCampoTabela;
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

function TValidadorDatabaseImpl.registraOpcoesCampos;
  var
    dic: TDicionarioSetValores;
begin
  if(pOpcaoDescricao='') then
    pOpcaoDescricao:=pOpcao;
  pNome := UpperCase(trim(pNome));
  if(pNome='') then exit;
  dic := getDicionarioSetValores;
  if not dic.TryGetValue(pNome,Result) then
  begin
    Result := TDadosSetOpcoesImpl.Create;
    Result.nome := pNome;
    Result.descricao := pDescricao;
    dic.AddOrSetValue(pNome,Result);
  end;

  Result.adicionaID_Descricao(pOpcao,pOpcaoDescricao);

end;

function TValidadorDatabaseImpl.registraValidacaoCampoTabela;
  var
    dic: TDicionarioDadosCamposValidacoes;
    dadosTabela: TDicionarioDadosCamposValidacoesTabela;
    //dadosCampo: IDadosCamposValidacoes;
begin
  if(pRegra='') then
    pRegra:='padrao';
  pRegra := uppercase(trim(pRegra));
  dic := getDicionarioRegrasDadosCamposValidacoes(pRegra);
  pTabela := UpperCase(trim(pTabela));
  pCampo := UpperCase(trim(pCampo));
  if(pTabela='') then exit;
  if(pCampo='') then exit;

  logaByTagSeNivel(TAGLOG_VALIDACOES,format('registraValidacaoCampoTabela: Regra: [%s], Tabela [%s], Campo [%s], Opções [%s], Descrição [%s], Obrigatório [%s].',[pRegra,pTabela,pCampo,pOpcoes,pDescricao,ifThen(pObrigatorio,'S','N')]),LOG_LEVEL_DEBUG );

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
  Result.regra := pRegra;
  Result.tabela := pTabela;
  Result.campo := pCampo;
  Result.descricao := pDescricao;
  Result.opcoes := UpperCase(trim(pOpcoes));
  Result.obrigatorio := pObrigatorio;
end;

function TValidadorDatabaseImpl.validaDataset;
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
  if(pRegra='') then
    pRegra := 'padrao';
  if(pTabela='') then
  begin
    pResultado.adicionaErro('validaDataset: Nome da tabela inválida.');
    exit;
  end;

  if( (pDataset=nil) or (pDataset.Active=false) ) then
  begin
    pResultado.adicionaErro('validaDataset: Não informou um dataset válido');
    exit;
  end;
  if( not pDataset.RecordCount=0) and (pDataset.State = dsBrowse) then
  begin
    pResultado.adicionaErro('validaDataset: Não possui registros para serem validados');
    exit;
  end;

  if(pListaCampos=nil) then
    pListaCampos := getStringList;

  pRegra := uppercase(trim(pRegra));
  pTabela := uppercase(trim(pTabela));

  if(pListaCampos.Count=0) then
  begin
    for i := 0 to pDataset.Fields.Count - 1 do
      pListaCampos.Add(pDataset.Fields[i].FieldName);
  end;

  dic := getDicionarioRegrasDadosCamposValidacoes(pRegra);
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
    opcoes := dadosCampo.getDadosOpcoes(self);
    if(opcoes=nil) then
    begin
      pResultado.formataErro('validaDataset: Campo [%s] [%s] não configurado lista de opções', [lNomeCampo, dadosCampo.descricao ]);
      continue;
    end;

    lDependenciaMatch := dadosCampo.verificaDependencias(pDataset,self,pResultado);
    //Implementar dependencias

    if(lDependenciaMatch=false) {or (pResultado.erros<>save)} then continue;

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
      if(pResultado.propriedade['campo.erro'].asString='') then
        pResultado.propriedade['campo.erro'].asString := dadosCampo.campo;
      pResultado.formataErro('Valor do Campo [%s] inválido', [ dadosCampo.descricao ]);
    end;
  end;
end;

function TValidadorDatabaseImpl.retornaControleDataField;
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

function TValidadorDatabaseImpl.setFocoControleDataField;//(pCampo: String; pDatasource: TDataSource): TWinControl;
  var
    controle: TWinControl;
begin
  Result := nil;
  if not (pParent is TWinControl) then
    exit;
  controle := TWinControl(retornaControleDataField(pCampo, pDatasource, TWinControl(pParent)));
  if(assigned(controle)) then
  begin
    controle.Show;
    if(controle.CanFocus) then
      controle.SetFocus;
  end;

end;

function TValidadorDatabaseImpl.getDicionarioRegrasDadosCamposValidacoes(pRegra: TipoWideStringFramework = ''): TDicionarioDadosCamposValidacoes;
begin
  if(pRegra='') then
    pRegra := 'padrao';
  pRegra := uppercase(trim(pRegra));
  if(dicionarioRegrasDadosCamposValidacoes=nil) then
    dicionarioRegrasDadosCamposValidacoes:=TCollections.CreateDictionary<TipoWideStringFramework,TDicionarioDadosCamposValidacoes>(getComparadorOrdinalTipoWideStringFramework);
  if(dicionarioRegrasDadosCamposValidacoesInicializado=false) and (fGDB<>nil) and (fOpcoesDefaultRegistradas=true) then
    loadDicionarioCamposValidacoes;
  if not dicionarioRegrasDadosCamposValidacoes.TryGetValue(pRegra,Result) then
  begin
    Result := TCollections.CreateDictionary<TipoWideStringFramework,TDicionarioDadosCamposValidacoesTabela>(getComparadorOrdinalTipoWideStringFramework);
    dicionarioRegrasDadosCamposValidacoes.AddOrSetValue(pRegra,Result);
  end;
end;

procedure TValidadorDatabaseImpl.loadDicionarioCamposValidacoes;
  var
    dsRegras, dsDependencias: IDataset;
    dic: TDicionarioDadosCamposValidacoes;
    lRegra,lTabela,lCampo,lNome: TipoWideStringFramework;
    validacacoesTabelas: TDicionarioDadosCamposValidacoesTabela;
    validacao: IDadosCamposValidacoes;
  label
    proximo1,proximo2;
begin
  if(dicionarioRegrasDadosCamposValidacoes=nil) then
    exit;
  dicionarioRegrasDadosCamposValidacoesInicializado := true;


  dsRegras := fGDB.criaDataset;
  dsDependencias := fGDB.criaDataset;
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
    lRegra := UpperCase(trim(dsRegras.dataset.FieldByName('regra').AsString));
    if(lTabela='') or (lCampo='') or (lNome='') or (lRegra='') then goto proximo1;
    dic:=getDicionarioRegrasDadosCamposValidacoes(lRegra);

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
    validacao.regra := lRegra;
    validacao.nome := lNome;
    validacao.descricao := dsRegras.dataset.FieldByName('descricao').AsString;
    validacao.tabela := lTabela;
    validacao.campo := lCampo;
    validacao.opcoes := dsRegras.dataset.FieldByName('valores').AsString;
    validacao.obrigatorio := dsRegras.dataset.FieldByName('obrigatorio').AsString<>'N';
    logaByTagSeNivel(TAGLOG_VALIDACOES,format('Registrando regra validação [%s] para tabela [%s], campo [%s], descrição [%s] e opções [%s], obrigatório=[%s] ',
        [validacao.nome,validacao.tabela,validacao.campo,validacao.descricao,validacao.opcoes,ifThen(validacao.obrigatorio,'S','N')]),LOG_LEVEL_DEBUG);
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
      logaByTagSeNivel(TAGLOG_VALIDACOES,format('Registrando dependencia [%s] para regra [%s] com valor [%s] ',
        [dsDependencias.dataset.FieldByName('dependencia').AsString, validacao.nome,dsDependencias.dataset.FieldByName('valor_dependencia').AsString]),LOG_LEVEL_DEBUG);
      validacao.adicionaDependencia(dsDependencias.dataset.FieldByName('dependencia').AsString, dsDependencias.dataset.FieldByName('valor_dependencia').AsString);
     proximo2:
      dsDependencias.dataset.Next;
    end;

   proximo1:
    dsRegras.dataset.Next;
  end;

end;

function TValidadorDatabaseImpl.getDicionarioSetValores: TDicionarioSetValores;
begin
  if(dicionarioSetValores=nil) then
    dicionarioSetValores:=TCollections.CreateDictionary<TipoWideStringFramework,IDadosSetOpcoes>(getComparadorOrdinalTipoWideStringFramework);
  Result := dicionarioSetValores;
  if(dicionarioSetValoresInicializado=false) and (fGDB<>nil) and (fOpcoesDefaultRegistradas=true) then
    //Le da tabela...
    loadDicionarioSetValores
end;

procedure TValidadorDatabaseImpl.configuraEditOpcoesCampoTabela(pTabela: String; pObject: TComponent; pDataSource: TDataSource);
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
  //Aqui vamos assumir somente a regra PADRAO por enquanto
  dic := getDicionarioRegrasDadosCamposValidacoes;
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
    opcoes := dadosCampo.getDadosOpcoes(self);
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

destructor TValidadorDatabaseImpl.Destroy;
begin
  fGDB := nil;
  dicionarioRegrasDadosCamposValidacoes:=nil;
  dicionarioSetValores:=nil;
  inherited;
end;

procedure TValidadorDatabaseImpl.loadDicionarioSetValores;
  var
    lDSValores, dsDadosValores: IDataset;
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
    lDSValores := fGDB.criaDataset;
    dsDadosValores := fGDB.criaDataset;
    lDSValores.query(
          'select'+#13+
          '    v.nome'+#13+
          'from'+#13+
          '    regras_valores v'+#13+
          'group by'+#13+
          '    1',
      '',[]);

    while not lDSValores.dataset.Eof do begin
      lNome := UpperCase(trim(lDSValores.dataset.FieldByName('nome').AsString));
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
      lDSValores.dataset.Next;
    end;
  finally
    logaByTagSeNivel(TAGLOG_VALIDACOES,format('Final da leitura de regras_valores com [%d] registros importados.',[cnt]),LOG_LEVEL_DEBUG);
  end;

end;

function TValidadorDatabaseImpl.getValidacaoPorNome(pNome: String): IDadosCamposValidacoes;
  var
    dic: TDicionarioDadosCamposValidacoes;
    p1: TPair<TipoWideStringFramework, TDicionarioDadosCamposValidacoes>;
    p2: TPair<TipoWideStringFramework, TDicionarioDadosCamposValidacoesTabela>;
    r: TPair<TipoWideStringFramework,IDadosCamposValidacoes>;
begin
  Result := nil;
  pNome := UpperCase(trim(pNome));
  if(dicionarioRegrasDadosCamposValidacoes=nil) then
    exit;
  for p1 in dicionarioRegrasDadosCamposValidacoes do
  begin
    dic := p1.Value;
    for p2 in dic do
      for r in p2.Value do
      begin
        if(r.Value.nome=pNome) then
        begin
          Result := r.Value;
          exit;
        end;
      end;
  end;
end;

procedure configuraControlesEditOpcoesCampoTabela(pTabela: String; pOwner: TComponent; pDataSource: TDataSource; pGDB: IGDB=nil );
  var
    validador: IValidadorDatabase;
begin
  if(pGDB=nil) then
  begin
    pGDB := gdbPadrao;
    if(pGDB=nil) then
      exit;
  end;

  if not Supports(pGDB.validador, IValidadorDatabase, validador) then exit;

  validador.configuraControlesEditOpcoesCampoTabela(pTabela,pOwner,pDataSource);

end;

initialization
  registraLogger(TAGLOG_VALIDACOES,'Validacoes',true);

end.
