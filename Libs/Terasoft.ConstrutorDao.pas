unit Terasoft.ConstrutorDao;

interface

uses
  FireDAC.Comp.Client,
  Clipbrd,
  System.Classes,
  Data.DB,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TConstrutorDao = class

  private
    vIConexao : IConexao;

  public
    function gerarInsert(pTabela, pFieldReturning: String; pGerarID: Boolean = false): String;
    function gerarUpdate(pTabela, pFieldWhere: String): String;
    function queryTabela(pTabela: String): String;
    function carregaFields(pQry: TFDQuery; pTabela: String; pGerarID: Boolean): TStringList;
    procedure copiarEstruturaCampos(pSource: TDataSet; var pDest: TFDMemTable);
    procedure atribuirRegistros(pSource: TDataSet; var pDest: TFDMemTable); overload;
    function atribuirRegistros(pSource: TDataSet): TFDMemTable; overload;
    function getColumns(pTabela: String): TFDMemTable;
    function getValue(pTabela: TFDMemTable; pColumn: String; pValue: String ): String;
    function getSQL(pSource: TFDQuery): String;

  	constructor Create(pIConexao: IConexao);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, System.StrUtils, Vcl.Dialogs;

{ TGeradorModel }

procedure TConstrutorDao.atribuirRegistros(pSource: TDataSet; var pDest: TFDMemTable);
begin
  copiarEstruturaCampos(pSource, pDest);

  pDest.EmptyDataSet;

  pSource.First;
  while not pSource.Eof do
  begin
    pDest.Append;
    pDest.CopyFields(pSource);
    pDest.Post;
    pSource.Next;
  end;
end;

function TConstrutorDao.atribuirRegistros(pSource: TDataSet): TFDMemTable;
var
  lTable : TFDMemTable;
begin
  lTable := TFDMemTable.Create(nil);
  atribuirRegistros(pSource, lTable);
  Result := lTable;
end;

function TConstrutorDao.carregaFields(pQry: TFDQuery; pTabela: String; pGerarID: Boolean): TStringList;
var
  lFields : TStringList;
begin
  lFields := TStringList.Create;

  pQry.First;
  while not pQry.eof do
  begin
    if not AnsiMatchStr(pQry.FieldByName('NOME').AsString, ['SYSTIME', 'FORM']) and
       (pQry.FieldByName('COMPUTED').AsString = 'N') and
       ((pQry.FieldByName('NOME').AsString <> 'ID') or (pGerarID = true)) then

      lFields.Add(pQry.FieldByName('NOME').AsString);

    pQry.Next;
  end;

  Result := lFields;
end;

procedure TConstrutorDao.copiarEstruturaCampos(pSource: TDataSet; var pDest: TFDMemTable);
var
  i: Integer;
begin
  pDest.FieldDefs.Clear;

  for i := 0 to pSource.FieldDefs.Count - 1 do
    pDest.FieldDefs.Add(pSource.FieldDefs[i].Name, pSource.FieldDefs[i].DataType,
      pSource.FieldDefs[i].Size, pSource.FieldDefs[i].Required);

  pDest.CreateDataSet;
end;

constructor TConstrutorDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TConstrutorDao.Destroy;
begin

  inherited;
end;

function TConstrutorDao.gerarInsert(pTabela, pFieldReturning: String; pGerarID: Boolean = false): String;
var
  lQry     : TFDQuery;
  lColums,
  lParams  : String;
  lFields  : TStringList;
  i        : Integer;
begin
  lQry     := vIConexao.CriarQuery;
  lFields  := TStringList.Create;

  try
    lQry.Open(queryTabela(pTabela));

    lColums := '';
    lParams := '';

    lFields := carregaFields(lQry, pTabela, pGerarID);

    for i := 0 to lFields.Count -1 do
    begin
      if i > 0 then
      begin
        lColums := lColums + ', ';
        lParams := lParams + ', ';
      end;

      lColums := lColums + lFields.Strings[i];
      lParams := lParams + ':'+lFields.Strings[i];
    end;

    Result := 'INSERT INTO '+ pTabela + ' ( ' + lColums + ') VALUES ( '+lParams+' ) '+ IfThen(pFieldReturning <> '', 'returning '+pFieldReturning, '');
  finally
    lFields.Free;
    lQry.Free;
  end;

end;

function TConstrutorDao.gerarUpdate(pTabela, pFieldWhere: String): String;
var
  lQry     : TFDQuery;
  lUpdate  : String;
  lFields  : TStringList;
  i        : Integer;
begin
  lQry     := vIConexao.CriarQuery;
  lFields  := TStringList.Create;
  try
    lQry.Open(queryTabela(pTabela));
    lFields := carregaFields(lQry, pTabela, false);

    lUpdate := 'UPDATE '+ pTabela + ' SET ' ;

    for i := 0 to lFields.Count -1 do
    begin
      lUpdate := lUpdate + lFields.Strings[i] + ' = :'+ lFields.Strings[i];

      if i < (lFields.Count -1) then
        lUpdate := lUpdate + ', ';
    end;

    lUpdate := lUpdate + ' WHERE '+ pFieldWhere + ' = :' + pFieldWhere;

    Result := lUpdate;
  finally
    lFields.Free;
    lQry.Free;
  end;
end;

function TConstrutorDao.getColumns(pTabela: String): TFDMemTable;
var
  lQry : TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
    lQry.Open(queryTabela(pTabela));

    Result := atribuirRegistros(lQry);
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

  Clipboard.AsText := lSql;

  Result := lSql;
end;

function TConstrutorDao.getValue(pTabela: TFDMemTable; pColumn, pValue: String): String;
begin
  if pTabela.Locate('NOME', pColumn) then
  begin
    if AnsiMatchStr(pTabela.FieldByName('TIPO').AsString, ['INTEGER', 'INT64', 'FLOAT', 'NUMERIC']) then
      Result := FormataFloatFireBird(pValue)
    else if pTabela.FieldByName('TIPO').AsString = 'DATE' then
      Result := transformaDataFireBird(pValue)
    else if pTabela.FieldByName('TIPO').AsString = 'TIMESTAMP' then
      Result := transformaDataHoraFireBird(pValue)
    else
      Result := pValue;
  end
  else
    Result := pValue;
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

end.
