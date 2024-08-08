unit Terasoft.PesquisaDB;


interface
  uses
    Classes;

  type
    TEWPrefixoWhereData = ( tewcprefixodata_None, tewcprefixodata_And, tewcprefixodata_Or );
    TDadosExpansaoPesquisa = class ( TOwnedCollection )

    private

    end;

  function pesquisaAvancadaDB ( listaCampos, listaValores: TStrings; prefixo: TEWPrefixoWhereData = tewcprefixodata_And; pt_br: boolean = true ): String; overload;
  function pesquisaAvancadaDB ( listaCampos, listaValores: String; prefixo: TEWPrefixoWhereData = tewcprefixodata_And; pt_br: boolean = true ): String; overload;

implementation
  uses
    SysUtils,
    Terasoft.FuncoesTexto;


function pesquisaAvancadaDB ( listaCampos, listaValores: TStrings; prefixo: TEWPrefixoWhereData = tewcprefixodata_And; pt_br: boolean = true ): String;
  var
    valor, campo: String;
    iValor, iCampo: Integer;
    ors: String;
    collate_str: String;
    nega: String;
    likeKeyword: String;
begin
  likeKeyword :=  ' like ';

  Result := '';

  for iValor := 0 to listaValores.Count - 1 do begin
    valor := listaValores.Strings[iValor];

    if ( valor = '' ) then continue;

    nega := '';
    if ( valor[1] = '!' ) then begin
      nega := ' not ';
      valor := pchar(@valor[2]);
      if ( valor = '' ) then continue;
    end;


    valor := DoubleQuotedStr(Valor);
    valor := StringReplace ( valor, '"', '', [ rfReplaceAll ] );

    ors := '';

    for iCampo := 0 to listaCampos.Count - 1 do begin
      //
      campo := listaCampos.Strings[iCampo];

      if ( campo = '' ) then continue;

      if ( ors <> '' ) then
        ors := ors + ' or ';

      ors := ors + 'Upper(coalesce( ' + campo + ', '''')) ' + collate_str + likeKeyword + ' ''%' + valor + '%''' + #13;
    end;

    if ( ors <> '' ) then begin
      if ( Result <> '' ) then
        Result := Result + ' and ';
      Result := Result + nega + ' (' + ors + ')';
    end;
  end;
  if( Result <> '' ) then
    case prefixo of
      tewcprefixodata_None:
        ;
      tewcprefixodata_And:
        Result := ' and ' + Result;

      tewcprefixodata_Or:
        Result := ' or ' + Result;
    end;

end;

var
  fListaLocal_campos, fListaLocal_valores: TStrings;

function pesquisaAvancadaDB ( listaCampos, listaValores: String; prefixo: TEWPrefixoWhereData = tewcprefixodata_And; pt_br: boolean = true ): String;
begin
  Result := '';
  if ( listaCampos = '' ) or ( listaValores = '' ) then exit;
  if ( not Assigned ( fListaLocal_campos ) ) then begin
    fListaLocal_campos := TStringList.Create;
    fListaLocal_campos.Delimiter := ';';
  end;

  fListaLocal_campos.DelimitedText := listaCampos;

  if ( not Assigned ( fListaLocal_valores ) ) then begin
    fListaLocal_valores := TStringList.Create;
    fListaLocal_valores.Delimiter := ' ';
  end;

  fListaLocal_valores.DelimitedText := listaValores;

  Result := pesquisaAvancadaDB( fListaLocal_campos, fListaLocal_valores, prefixo, pt_br );

end;

initialization

finalization

  FreeAndNil(fListaLocal_campos);
  FreeAndNil(fListaLocal_valores);

end.
