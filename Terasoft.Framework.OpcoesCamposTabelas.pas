
{$i definicoes.inc}

unit Terasoft.Framework.OpcoesCamposTabelas;

interface
  uses
    DB,SysUtils,Classes,
    Terasoft.Framework.Types, Terasoft.Framework.DB,
    Spring.Collections,
    Generics.Collections,
    Terasoft.Framework.Texto;

  type
    TDadosCamposRec = record
      valido,padrao: boolean;
      tabela, campo, descricao: TipoWideStringFramework;
      listaValores, listaDescricoes: IListaTextoEX;
      dataset: IDatasetSimples;
    end;

    TDadosCamposLookup = IDictionary<TipoWideStringFramework,TDadosCamposRec>;

  function validaDataset(pTabela: String; pDataset: TDataset; pListaCampos: IListaString = nil; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
  function getDadosCamposLookup(pTabela: String; pCampos: IListaString=nil): TDadosCamposLookup;

  procedure registraOpcoesCampoTabela(const pTabela, pCampo, pOpcao, pOpcaoDescricao: String);
  procedure configuraEditOpcoesCampoTabela(pTabela: String; pObjet: TComponent);

implementation
  uses
    Vcl.DBCtrls;

  var
    dicionarioDados: IDictionary<TipoWideStringFramework,TDadosCamposLookup>;

procedure registraOpcoesCampoTabela;
  var
    p: TDadosCamposLookup;
    dados: TDadosCamposRec;
begin
  p := nil;
  if(dicionarioDados=nil) then
    dicionarioDados := TCollections.CreateDictionary<TipoWideStringFramework,TDadosCamposLookup>(getComparadorOrdinalTipoWideStringFramework);
  if not dicionarioDados.TryGetValue(pTabela,p) then
  begin
    p := TCollections.CreateDictionary<TipoWideStringFramework,TDadosCamposRec>(getComparadorOrdinalTipoWideStringFramework);
    dicionarioDados.AddOrSetValue(pTabela,p);
  end;
  if not p.TryGetValue(pCampo,dados) then
  begin
    dados.valido := true;
    dados.padrao := true;
    dados.tabela := UpperCase(pTabela);
    dados.campo := UpperCase(pCampo);
    dados.listaValores := novaListaTexto;
    dados.listaDescricoes := novaListaTexto;
    dados.dataset := getGenericID_DescricaoDataset;
    p.AddOrSetValue(pCampo,dados);
  end;

  dados.listaValores.strings.Add(pOpcao);
  dados.listaDescricoes.strings.Add(pOpcaoDescricao);
  dados.dataset.dataset.Append;
  dados.dataset.dataset.FieldByName('id').AsString := pOpcao;
  dados.dataset.dataset.FieldByName('descricao').AsString := pOpcaoDescricao;
  dados.dataset.dataset.CheckBrowseMode;
end;

function validaDataset;//(pDataset: TDataset; pListaCampos: IListaString = nil; pResultado: IResultadoOperacao = nil): IResultadoOperacao;
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

function getDadosCamposLookup;//(pTabela: String; pCampos: IListaString): TDadosCampos;
  var
    lDS: IDataset;
    p: TipoWideStringFramework;
    lCampo: String;
    lRec: TDadosCamposRec;
    tmp: String;
    lDadosCampoLookup: TDadosCamposLookup;
    par: TPair<TipoWideStringFramework,TDadosCamposRec>;
begin
  Result := TCollections.CreateDictionary<TipoWideStringFramework,TDadosCamposRec>(getComparadorOrdinalTipoWideStringFramework);
  lRec.valido := true;
  pTabela := uppercase(trim(pTabela));
  if(pTabela='') then exit;

  if not dicionarioDados.TryGetValue(pTabela,lDadosCampoLookup) then
  begin
    lDadosCampoLookup := TCollections.CreateDictionary<TipoWideStringFramework,TDadosCamposRec>(getComparadorOrdinalTipoWideStringFramework);
    dicionarioDados.AddOrSetValue(pTabela,lDadosCampoLookup);
  end;

  if(dicionarioDados=nil) then
    dicionarioDados := TCollections.CreateDictionary<TipoWideStringFramework,TDadosCamposLookup>(getComparadorOrdinalTipoWideStringFramework);


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
      lRec.listaValores := novaListaTextoEx;
      lRec.listaDescricoes := novaListaTextoEx;
      lRec.dataset := getGenericID_DescricaoDataset;
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

procedure configuraEditOpcoesCampoTabela(pTabela: String; pObjet: TComponent);
  var
    dados: TDadosCamposLookup;
    lRG: TDBRadioGroup;
    dataField: String;
    par: TPair<TipoWideStringFramework,TDadosCamposRec>;
begin
  if(pObjet=nil) then exit;
  pTabela := UpperCase(trim(pTabela));
  if(pTabela='') then exit;
  lRG:=nil;
  if (pObjet is TDBRadioGroup) then
  begin
    lRG := TDBRadioGroup(pObjet);
    dataField := lRG.DataField;
  end;
  dataField := UpperCase(trim(pTabela));

  if(dataField<>'') then
  begin
    dados := getDadosCamposLookup(pTabela);
    for par in dados do
    begin

    end;

  end;

end;

end.
