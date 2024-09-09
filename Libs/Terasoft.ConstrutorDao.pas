unit Terasoft.ConstrutorDao;

interface

uses
  FireDAC.Comp.Client,
  Clipbrd,
  SysUtils,
  System.Classes,
  Data.DB,
  Terasoft.Framework.Types,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.Texto,
  Terasoft.Framework.ObjectIface,
  Terasoft.Types,
  Interfaces.Conexao;

type
  TConstrutorDao = class(TInterfacedObject, IConstrutorDao)

  private
    vIConexao : IConexao;

  public
    function gerarInsert(pTabela, pFieldReturning: String; pGerarID: Boolean = false): String;
    function gerarUpdateOrInsert(pTabela, pMatch, pFieldReturning: String; pGerarID: Boolean = false): String;
    function gerarUpdate(pTabela, pFieldWhere: String): String;
    function queryTabela(pTabela: String): String;
    function carregaFields(pQry: TDataset; pTabela: String; pGerarID: Boolean): TDadosFields;
    procedure copiarEstruturaCampos(pSource: TDataSet; pDest: TDataset);
    procedure atribuirRegistros(pSource: TDataSet; pDest:TDataset); overload;
    function atribuirRegistros(pSource: TDataSet): IFDDataset; overload;
    function getColumns(pTabela: String): IFDDataset;
    function getValue(pTabela: TDataset; pColumn: String; pValue: String ): String;
    function getSQL(pSource: TFDQuery): String;
    procedure setParams(pTabela: String; pQry: TFDQuery; pModel: TObject);
    procedure setDatasetToModel(pTabela: String; pDataset: TDataset; pModel: TObject);
    function expandIn(pCampo: String; pValues: IListaString): String;
    procedure sincronizarDados(pTabela: String; pChave: String; pModelo: TObject; pAcao: TAcao; pEspera: boolean = false);
    function getValuesFromModel(pCampos: String; pModel: TObject): TVariantArray;

  	constructor Create(pIConexao: IConexao);
    destructor Destroy; override;

  end;

implementation

uses
  Terasoft.Configuracoes,
  System.Rtti,
  DBClient,
  System.Variants,
  TypInfo,
  Terasoft.Utils,
  Interfaces.QueryLojaAsync,
  System.StrUtils, Vcl.Dialogs;

{ TGeradorModel }

procedure TConstrutorDao.atribuirRegistros(pSource: TDataSet; pDest: TDataset);
begin
  copiarEstruturaCampos(pSource, pDest);

  if(pDest is TFDMemTable) then
    TFDMemTable(pDest).EmptyDataSet
  else if(pDest is TClientDataset) then
    TClientDataset(pDest).EmptyDataSet
  else begin
    pDest.First;
    while not pDest.eof do
      pDest.Delete;
  end;

  pSource.First;
  while not pSource.Eof do
  begin
    pDest.Append;
    pDest.CopyFields(pSource);
    pDest.Post;
    pSource.Next;
  end;
end;

function TConstrutorDao.atribuirRegistros(pSource: TDataSet): IFDDataset;
var
  lTable : TFDMemTable;
begin
  lTable := TFDMemTable.Create(nil);
  Result := TImplObjetoOwner<TDataset>.CreateOwner(lTable);
  atribuirRegistros(pSource, lTable);
end;

function TConstrutorDao.carregaFields(pQry: TDataSet; pTabela: String; pGerarID: Boolean): TDadosFields;
  var
    s: String;
begin
  Result.tabela := pTabela;
  Result.listaCampos := getStringList;
  Result.listaNames := '';
  Result.listaValues := '';
  Result.listaUpdate := '';

  pQry.First;
  while not pQry.eof do
  begin
    s := trim(pQry.FieldByName('NOME').AsString);
    if not AnsiMatchStr(s, ['SYSTIME']) and
       (pQry.FieldByName('COMPUTED').AsString = 'N') and
       ((pQry.FieldByName('NOME').AsString <> 'ID') or (pGerarID = true)) then
    begin
      Result.listaCampos.Add(s);
      if(Result.listaNames<>'') then
      begin
        Result.listaNames := Result.listaNames +',';
        Result.listaValues := Result.listaValues +',';
        Result.listaUpdate := Result.listaUpdate +',';
      end;
      Result.listaNames := Result.listaNames + s;
      Result.listaValues := Result.listaValues + ':' +s;
      Result.listaUpdate := Result.listaUpdate + format('%s=:%s', [ s, s ]);

    end;

    pQry.Next;
  end;

end;

procedure TConstrutorDao.copiarEstruturaCampos(pSource: TDataSet; pDest: TDataSet);
var
  i: Integer;
begin
  pDest.FieldDefs.Clear;

  for i := 0 to pSource.FieldDefs.Count - 1 do
    pDest.FieldDefs.Add(pSource.FieldDefs[i].Name, pSource.FieldDefs[i].DataType,
      pSource.FieldDefs[i].Size, pSource.FieldDefs[i].Required);

  if(pDest is TFDMemTable) then
    TFDMemTable(pDest).CreateDataSet
  else if(pDest is TClientDataset) then
    TClientDataset(pDest).CreateDataSet
  else
    raise Exception.Create('Dataset não suportada');
end;

constructor TConstrutorDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vIConexao.ultimoAcessoDB := Now;
end;

destructor TConstrutorDao.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TConstrutorDao.expandIn(pCampo: String; pValues: IListaString): String;
  var
    s: TipoWideStringFramework;
    tmp: String;
begin
  Result := '';
  if(pCampo='') or (pValues=nil) or (pValues.Count=0) then
    exit;
  if(pValues.count=1) then
  begin
    tmp := uppercase(trim(pValues.first));
    if(tmp='') then
      exit;
    Result := format(' and %s = %s ', [ pCampo, quotedStr(tmp) ]);
  end else begin
    for s in pValues do
    begin
      tmp := uppercase(trim(s));
      if(tmp='') then continue;
      if(Result<>'') then
        Result := Result+','+#13;
      Result:=Result+QuotedStr(tmp);
    end;
    if(Result<>'') then
      Result := format(' and %s in (%s) ', [ pCampo, Result ]);
  end;
end;

function TConstrutorDao.gerarInsert(pTabela, pFieldReturning: String; pGerarID: Boolean = false): String;
var
  lQry     : TFDQuery;
  lFields  : TDadosFields;
begin
  lQry     := vIConexao.CriarQuery;
  try
    lQry.Open(queryTabela(pTabela));

    lFields := carregaFields(lQry, pTabela, pGerarID);

    Result := 'INSERT INTO '+ pTabela + ' ( ' + lFields.listaNames + ') VALUES ( '+lFields.listaValues+' ) '+ IfThen(pFieldReturning <> '', 'returning '+pFieldReturning, '');
  finally
    lQry.Free;
  end;

end;

function TConstrutorDao.gerarUpdate(pTabela, pFieldWhere: String): String;
var
  lQry     : TFDQuery;
  lUpdate  : String;
  lFields  : TDadosFields;
  i        : Integer;
begin
  lQry     := vIConexao.CriarQuery;
  try
    lQry.Open(queryTabela(pTabela));
    lFields := carregaFields(lQry, pTabela, false);

    lUpdate := 'UPDATE '+ pTabela + ' SET ' +lFields.listaUpdate;

    lUpdate := lUpdate + ' WHERE '+ pFieldWhere + ' = :' + pFieldWhere;

    Result := lUpdate;
  finally
    lQry.Free;
  end;
end;

function TConstrutorDao.gerarUpdateOrInsert(pTabela, pMatch,
  pFieldReturning: String; pGerarID: Boolean): String;
var
  lQry     : TFDQuery;
  lFields  : TDadosFields;
  i        : Integer;
begin
  lQry     := vIConexao.CriarQuery;

  try
    lQry.Open(queryTabela(pTabela));

    lFields := carregaFields(lQry, pTabela, pGerarID);

    Result := 'UPDATE OR INSERT INTO '+ pTabela + ' ( ' + lFields.listaNames + ') VALUES ( '+lFields.listaValues+' ) MATCHING ('+pMatch+') '+ IfThen(pFieldReturning <> '', 'returning '+pFieldReturning, '');
  finally
    lQry.Free;
  end;
end;

function TConstrutorDao.getColumns;
  var
    lQry : TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
    lQry.Open(queryTabela(pTabela));

    Result :=  atribuirRegistros(lQry);
    Result.objeto.First;
  finally
    lQry.Free;
  end;
end;

function TConstrutorDao.getSQL(pSource: TFDQuery): String;
var
  lSql  : String;
  i     : Integer;

begin
  lSql := pSource.SQL.Text;

  for i := 0 to pSource.Params.Count -1 do
  begin
    lSql := StringReplace(lSql, ':'+pSource.Params[i].Name+',', QuotedStr(pSource.Params[i].Value)+',', []);
  end;

  Result := lSql;
end;

function TConstrutorDao.getValue(pTabela: TDataset; pColumn, pValue: String): String;
begin
  Result := pValue;
  if pTabela.Locate('NOME', pColumn,[]) then
  begin
    if AnsiMatchStr(pTabela.FieldByName('TIPO').AsString, ['INTEGER', 'INT64', 'FLOAT', 'NUMERIC']) then
      Result := FormataFloatFireBird(Result)
    else if pTabela.FieldByName('TIPO').AsString = 'DATE' then
      Result := transformaDataFireBird(Result)
    else if pTabela.FieldByName('TIPO').AsString = 'TIMESTAMP' then
      Result := transformaDataHoraFireBird(Result);
  end;
end;

function TConstrutorDao.queryTabela(pTabela: String): String;
begin
  Result := '  SELECT R.RDB$FIELD_NAME AS NOME,                                                    '+SLineBreak+
            '         CASE                                                                         '+SLineBreak+
            '         WHEN F.RDB$COMPUTED_SOURCE <> '''' THEN ''S'' ELSE ''N'' END AS COMPUTED,    '+SLineBreak+
            '         F.RDB$FIELD_LENGTH AS TAMANHO,                                               '+SLineBreak+
            '         CASE F.RDB$FIELD_TYPE                                                        '+SLineBreak+
            '         WHEN 261 THEN ''BLOB''                                                       '+SLineBreak+
            '         WHEN 14 THEN ''CHAR''                                                        '+SLineBreak+
            '         WHEN 40 THEN ''CSTRING''                                                     '+SLineBreak+
            '         WHEN 11 THEN ''D_FLOAT''                                                     '+SLineBreak+
            '         WHEN 27 THEN ''DOUBLE''                                                      '+SLineBreak+
            '         WHEN 10 THEN ''FLOAT''                                                       '+SLineBreak+
            '         WHEN 16 THEN ''INT64''                                                       '+SLineBreak+
            '         WHEN 8 THEN ''INTEGER''                                                      '+SLineBreak+
            '         WHEN 9 THEN ''QUAD''                                                         '+SLineBreak+
            '         WHEN 7 THEN ''SMALLINT''                                                     '+SLineBreak+
            '         WHEN 12 THEN ''DATE''                                                        '+SLineBreak+
            '         WHEN 13 THEN ''TIME''                                                        '+SLineBreak+
            '         WHEN 35 THEN ''TIMESTAMP''                                                   '+SLineBreak+
            '         WHEN 37 THEN ''VARCHAR''                                                     '+SLineBreak+
            '         ELSE ''UNKNOWN''                                                             '+SLineBreak+
            '         END AS TIPO                                                                  '+SLineBreak+
            '    FROM RDB$RELATION_FIELDS R                                                        '+SLineBreak+
            '    LEFT JOIN RDB$FIELDS F ON R.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME                   '+SLineBreak+
            '   WHERE R.RDB$RELATION_NAME='+ QuotedStr(pTabela) +
            '   ORDER BY R.RDB$FIELD_POSITION';
end;

procedure TConstrutorDao.setDatasetToModel;
  var
    lTabela : IFDDataset;
    lCtx    : TRttiContext;
    lProp   : TRttiProperty;
    i       : Integer;
    f       : TField;
    v       : TValue;
begin
  if(pModel=nil) or (pDataset=nil) then
    exit;
  lCtx := TRttiContext.Create;
  try
    lTabela := getColumns(pTabela);
    for i := 0 to pDataset.FieldCount - 1 do
    begin
      f := pDataset.Fields.Fields[i];
      lProp := lCtx.GetType(pModel.ClassType).GetProperty(f.FieldName);
      if Assigned(lProp) and (lProp.IsWritable) then
      begin
        v := TValue.FromVariant(getValue(lTabela.objeto, f.FieldName, f.AsString));
        lProp.SetValue(pModel,v);
      end;
    end;
  finally
    lCtx.Free;
  end;
end;

function TConstrutorDao.getValuesFromModel;
  var
    l: IListaTextoEx;
    i: Integer;
    lCtx    : TRttiContext;
    lProp   : TRttiProperty;
    s: TipoWideStringFramework;
begin
  SetLength(Result,0);
  if(pModel=nil) then exit;
  l := novaListaTexto;
  l.strings.Delimiter := ';';
  l.strings.StrictDelimiter := true;
  l.strings.DelimitedText := trim(pCampos);
  SetLength(Result,l.strings.Count);
  lCtx := TRttiContext.Create;
  i:=0;
  try
    for s in l do
    begin
      inc(i);
      lProp := lCtx.GetType(pModel.ClassType).GetProperty(s);
      Result[i-1]:=null;
      if(lProp=nil) then continue;
      Result[i-1]:=lProp.GetValue(pModel).AsString;
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TConstrutorDao.setParams(pTabela: String; pQry: TFDQuery; pModel: TObject);
  var
    lTabela : IFDDataset;
    lCtx    : TRttiContext;
    lProp   : TRttiProperty;
    i       : Integer;
begin
  if(pModel=nil) or (pTabela='') then
    exit;
  lTabela := nil;
  lCtx := TRttiContext.Create;
  try
    lTabela := getColumns(pTabela);
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(pModel.ClassType).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pModel).AsString = '',
        Unassigned, getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pModel).AsString))
    end;
  finally
    lTabela := nil;
    lCtx.Free;
  end;
end;

procedure TConstrutorDao.sincronizarDados(pTabela: String; pChave: String; pModelo: TObject; pAcao: TAcao; pEspera: boolean = false);
var
  lQry        : IFDQuery;
  lSQL        : String;
  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
  lConfiguracoes : ITerasoftConfiguracoes;

begin
  Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);
  if(lConfiguracoes=nil) then
    exit;

  if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) <> 'S' then
    exit;

  lAsyncList := getQueryLojaAsyncHostsList(vIConexao);
  if(pTabela='') then
    raise Exception.Create('TConstrutorDao.sincronizarDados: Nome da tabela não especificada.');

  if trim(pChave)='' then
    pChave := 'ID';

  lSQL := '';

  if pAcao in [tacIncluir, tacAlterar] then
    lSQL := self.gerarUpdateOrInsert(pTabela, pChave, '', true)

  else if pAcao in [tacExcluir] then
    lSQL := format('delete from %s where %s = :%s', [ pTabela, pChave, pChave ])
  else
    exit;

  try
  if(lSQL<>'') then
    for lQA in lAsyncList do
    begin
      if lQA.loja.objeto.LOJA <> vIConexao.getEmpresa.LOJA then
      begin
        //Se a conexão é inválida, ou não consegue conectar, parte para a próxima
        conexao := lQA.loja.objeto.conexaoLoja;
        if(conexao=nil) then continue;

        lQry := conexao.criaIfaceQuery;

        if pAcao = tacExcluir then
        begin
          lQA.execQuery(lSQL, pChave, self.getValuesFromModel(pChave,pModelo));
        end else
        begin
          lQry.objeto.SQL.Text := lSQL;
          setParams(pTabela, lQry.objeto, pModelo);
          lQA.openQuery(lQry,true);
        end;

      end;
    end;
  finally
    if(pEspera) then
      for lQA in lAsyncList do
        lQA.espera;
  end;

end;

end.
