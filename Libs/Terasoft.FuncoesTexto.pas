unit Terasoft.FuncoesTexto;

interface

uses
  Classes,
  Terasoft.Framework.Texto,
  Terasoft.Types,
  DB;

  function textoEntreTags ( Texto, TagInicio, TagFim: String; PrimeiraOcorrencia: PInteger = nil; caseSensitive: boolean = true ): string;
  function validaCaracteresArquivo(Arquivo: String): String;
  function converteXMLNFeUTF8 ( conteudo: string; somenteUTF: boolean = false ): string;
  function converteTexto(Lista: TStrings;value:String): String;
  function doubleQuotedStr(const S: string): string;
  function valorNaListaPalavras(const valor: string; const listaPalavras: String; separador: char = ';'; padraoAntigo: String = ''; novoPadrao: String = '' ): boolean;
  function converteTextoSemAcento(const str: String ): String;
  function formatoTelefoneGenerico(field: TField;  texto: String; displayText: Boolean): String;
  function formatoCNPJCPFGenerico(field: TField;  texto: String; displayText: Boolean): String;
  function formatoCEPGenerico(field: TField;  texto: String; displayText: Boolean): String;
  function removeCaracteresGraficos(texto: String): String;
  function transformaDataFireBird(data:Variant; separador:String = '-';formato: String = 'mda'):Variant;
  function transformaDataFireBirdWhere(data:Variant; separador:String = '.'):Variant;
  function transformaDataHoraFireBird(data:Variant):Variant;
  function formataResultado(valor: TField; tipoCampo: TTipoColunas = tcoString): string;
  function removeEnter(texto: String): string;
  function ConverteFloat(pMascara, pValor: String): String;
  function RemovePonto(pValor: String): Variant;
  function FormataFloatFireBird(pValor: String): String;
  function StringForStringList(BaseString, BreakString: string; StringList: IListaTextoEX): IListaTextoEX;
  function ZeroLeft(vZero: string; vQtd: integer): string;
  function FormatarTelefone(Telefone : String):String;
  function FormataFireBirdToFloat(pValor: String): Variant;
  function FormataDinheiro(pValor: Real ; pCasasDecimais: String = '00'): String;
  function FormataFloat(pValor: Real ; pCasasDecimais: String = '00'): String;
  function completaComBranco(AValue:string; AQuantidade:integer; ALado: tlado):string;
  function Extenso(valor: real): String;
  function WriteConexao(pHost : String): THost;
  procedure converteDateRangePicker(pData: String; out Data1, Data2: TDate);
  function ValidaCPF(num: string): boolean;
  function ValidaCNPJ(num: string): boolean;
  function ValidaCPFCNPJ(num: string): boolean;
  function ValidaGTIN(codigo: string): boolean;
  function retiraPonto(pValor: string): String;
  function formatarDataInvertida(const data: string): String;
  function codigoUF(pUF : String): Integer;
  function StringToBase64(const Input: string): string;
  function DifDias2(DataVenc:TDateTime; DataAtual:TDateTime): String;

implementation
uses
  Terasoft.Framework.DB,
  StrUtils,
  SysUtils,
  MaskUtils,
  System.Variants,
  Soap.EncdDecd;

function FormataDinheiro(pValor: Real ; pCasasDecimais: String = '00'): String;
begin
  Result := 'R$ '+ FormataFloat(pValor, pCasasDecimais);
end;

function FormataFloat(pValor: Real ; pCasasDecimais: String = '00'): String;
begin
  Result := FormatFloat('#,##0.'+pCasasDecimais,pValor);
end;

function DifDias2(DataVenc:TDateTime; DataAtual:TDateTime): String;
var
  Data: TDateTime;
  dia, mes, ano: Word;
begin

  if DataAtual < DataVenc then
  begin
    Result := '0';
  end
  else
  begin
    Data   := DataAtual - DataVenc;
    DecodeDate( Data, ano, mes, dia);
    Result := FormatFloat('####0',(Data));
  end;

end;

function FormatarTelefone(Telefone : String):String;
  function SomenteNumero(snum : String) : String;
  VAR s1, s2: STRING;
    i: Integer;
  BEGIN
    s1 := snum;
    s2 := '';
    FOR i := 1 TO Length(s1) DO
      IF s1[i] IN ['0'..'9'] THEN
        s2 := s2 + s1[i];
    result := s2;
  End;
var sTel : String;
    bZero : Boolean;
    iDigitos : Integer;
begin
   sTel := SomenteNumero(Telefone); //Remove qualquer formata��o que o usu�rio possa ter colocado.
   if sTel='' then
    Result := ''
   else
   begin
     if sTel[1]='0' then //Verifica se foi adicionado o 0 no in�cio do n�mero
     begin
       bZero:= True;
       sTel := Trim( copy(sTel,2,Length(sTel)) ); //Remove para fazer a formata��o depois adiciona
     end
     else
       bZero := False;
     iDigitos := Length(sTel);
     //Formata de acordo com a quantidade de n�meros encontrados.
     case iDigitos of
       8 : Result := FormatMaskText('9999-9999;0;_',sTel); //8 digitos SEM DDD (ex: 34552318)
       9 : Result := FormatMaskText('9 9999-9999;0;_',sTel); //9 digitos SEM DDD (ex: 991916889)
      10 : Result := FormatMaskText('(99) 9999-9999;0;_',sTel); //8 Digitos (convencional, ex: 7734552318)
      11 : Result := FormatMaskText('(99) 9 9999-9999;0;_',sTel); //9 Digitos (novos n�meros, ex: 77991916889)
      12 : Result := FormatMaskText('99(99)9999-9999;0;_',sTel); //Se foram 12 digitos poss�velmente digitou a operadora tamb�m
      13 : Result := FormatMaskText('99(99)9 9999-9999;0;_',sTel); //Se foram 13 digitos poss�velmente digitou a operadora tamb�m
     else
       Result := Telefone; //Mant�m na forma que o usu�rio digitou
     end;
     if bZero then //Para ficar com a prefer�ncia do usu�rio, se ele digitou o "0" eu mantenho.
       Result := '0'+Result;
   end;
end;

function ZeroLeft(vZero: string; vQtd: integer): string;
var
  i, vTam: integer;
  vAux: string;
begin
  if vZero = '' then
  begin
   Result := '';
   Exit;
  end;
  vAux  := vZero;
  vTam  := length(vZero);
  vZero := '';
  for i := 1 to vQtd - vTam do
    vZero := '0' + vZero;
  vAux   := vZero + vAux;
  result := vAux;
end;
function StringForStringList;//(BaseString, BreakString: string; StringList: TStrings): TStrings;
var
  EndOfCurrentString: byte;
begin
  Result := StringList;
  if(Result=nil) then
    exit;
  repeat
    EndOfCurrentString := Pos(BreakString, BaseString);
    if EndOfCurrentString = 0 then
      StringList.strings.Add(BaseString)
    else
      StringList.strings.Add(copy(BaseString, 1, EndOfCurrentString - 1));
    BaseString := copy(BaseString, EndOfCurrentString + Length(BreakString),
      Length(BaseString) - EndOfCurrentString);
  until EndOfCurrentString = 0;
  result := StringList;
end;

function FormataFloatFireBird(pValor: String): String;
begin
  result := StringReplace(pValor, ',', '.', [rfReplaceAll]);
end;

function FormataFireBirdToFloat(pValor: String): Variant;
begin
  if pValor = '' then
   pValor := '0';

  result := StringReplace(pValor, '.', ',', [rfReplaceAll]);
end;

function RemovePonto(pValor: String): Variant;
begin
  result := StringReplace(pValor, '.', '', [rfReplaceAll]);
end;


function ConverteFloat(pMascara, pValor: String): String;
var
  lNovoValor : real;
begin
  try
    lNovoValor := StrToFloatDef(pValor, 0);

  except
    lNovoValor := 0;

  end;

  if lNovoValor = 0 then
    result := ''
  else
    if pMascara <> '' then
      result := FormatFloat(pMascara, lNovoValor)
    else
      result := FloatToStr(lNovoValor);
end;

function removeEnter(texto: String): string;
begin
  Result := StringReplace(StringReplace(StringReplace(texto, #13, ' ', [rfReplaceAll]), #10, ' ', [rfReplaceAll]), '\', '\\', [rfReplaceAll]);
end;

procedure converteDateRangePicker(pData: String; out Data1, Data2: TDate);
begin
  Data1 := StrToDate(copy(pData, 1,10));
  Data2 := StrToDate(copy(pData,14,10));
end;

function ValidaCPF(num: string): boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9: integer;
  d1,d2: integer;
  digitado, calculado: string;
begin

  if (Length(num) <> 11 ) or (num = '11111111111') or (num = '22222222222') or (num = '33333333333') or (num = '55555555555') or (num = '66666666666') or (num = '77777777777') or (num = '88888888888') or (num = '99999999999')  then begin
    ValidaCPF := false;
    exit;
  end;

  try

    n1:=StrToInt(num[1]);
    n2:=StrToInt(num[2]);
    n3:=StrToInt(num[3]);
    n4:=StrToInt(num[4]);
    n5:=StrToInt(num[5]);
    n6:=StrToInt(num[6]);
    n7:=StrToInt(num[7]);
    n8:=StrToInt(num[8]);
    n9:=StrToInt(num[9]);
    d1:=n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
    d1:=11-(d1 mod 11);
    if d1>=10 then d1:=0;
    d2:=d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
    d2:=11-(d2 mod 11);
    if d2>=10 then d2:=0;
    calculado := inttostr(d1)+inttostr(d2);
    digitado  := num[10]+num[11];
    if calculado=digitado then
      ValidaCPF := true
    else
      ValidaCPF := false;
  except
    ValidaCPF := false;
  end;
end;

function ValidaCNPJ(num: string): boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12: integer;
  d1,d2: integer;
  digitado, calculado: string;
begin
  if (Length(num) <> 14 ) or (num = '11111111111') or (num = '22222222222') or (num = '33333333333') or (num = '55555555555') or (num = '66666666666') or (num = '77777777777') or (num = '88888888888') or (num = '99999999999')  then
  begin
    ValidaCNPJ := false;
    exit;
  end;

  try
    n1  := StrToInt(num[1]);
    n2  := StrToInt(num[2]);
    n3  := StrToInt(num[3]);
    n4  := StrToInt(num[4]);
    n5  := StrToInt(num[5]);
    n6  := StrToInt(num[6]);
    n7  := StrToInt(num[7]);
    n8  := StrToInt(num[8]);
    n9  := StrToInt(num[9]);
    n10 := StrToInt(num[10]);
    n11 := StrToInt(num[11]);
    n12 := StrToInt(num[12]);
    d1  := n12*2+n11*3+n10*4+n9*5+n8*6+n7*7+n6*8+n5*9+n4*2+n3*3+n2*4+n1*5;
    d1  := 11-(d1 mod 11);

    if d1>=10 then d1:=0;
    d2 := d1*2+n12*3+n11*4+n10*5+n9*6+n8*7+n7*8+n6*9+n5*2+n4*3+n3*4+n2*5+n1*6;
    d2 := 11-(d2 mod 11);
    if d2>=10 then d2:=0;
    calculado:=inttostr(d1)+inttostr(d2);
    digitado:=num[13]+num[14];
    if calculado=digitado then
      ValidaCNPJ := true
    else
      ValidaCNPJ := false;
  except
    ValidaCNPJ := false;
  end;
end;

function ValidaCPFCNPJ(num: string): boolean;
begin
  if (ValidaCPF(num) = false) and (ValidaCNPJ(num) = false) then
    Result := false
  else
    Result := true;
end;

function ValidaGTIN(codigo: string): boolean;
var
  i, j, total, digitoVerificador, auxiliar, prefixo:Integer;
  arrayChar:array[1..14] of Char;
begin

  try
    if Length(codigo) = 14 then
      prefixo := StrToInt(copy(trim(codigo),2,3))
    else
      prefixo := StrToInt(copy(trim(codigo),1,3));

    if ((prefixo > 139) and (prefixo < 200)) or
       ((prefixo > 380) and (prefixo < 383)) or
       (prefixo = 384) or
       (prefixo = 386) or
       (prefixo = 388) or
       ((prefixo > 389) and (prefixo < 400)) or
       ((prefixo > 440) and (prefixo < 450)) or
       ((prefixo > 471) and (prefixo < 474)) or
       ((prefixo > 509) and (prefixo < 520)) or
       ((prefixo > 521) and (prefixo < 528)) or
       ((prefixo > 531) and (prefixo < 535)) or
       ((prefixo > 535) and (prefixo < 539)) or
       ((prefixo > 549) and (prefixo < 560)) or
       ((prefixo > 560) and (prefixo < 569)) or
       ((prefixo > 579) and (prefixo < 590)) or
       ((prefixo > 590) and (prefixo < 594)) or
       ((prefixo > 594) and (prefixo < 599)) or
       (prefixo = 602) or
       ((prefixo > 604) and (prefixo < 608)) or
       (prefixo = 610) or
       (prefixo = 612) or
       (prefixo = 614) or
       (prefixo = 617) or
       ((prefixo > 629) and (prefixo < 640)) or
       ((prefixo > 649) and (prefixo < 690)) or
       ((prefixo > 709) and (prefixo < 729)) or
       ((prefixo > 746) and (prefixo < 750)) or
       ((prefixo > 750) and (prefixo < 754)) or
       ((prefixo > 755) and (prefixo < 759)) or
       (prefixo = 772) or
       (prefixo = 774) or
       (prefixo = 776) or
       ((prefixo > 780) and (prefixo < 784)) or
       (prefixo = 785) or
       ((prefixo > 786) and (prefixo < 789)) or
       ((prefixo > 790) and (prefixo < 800)) or
       ((prefixo > 850) and (prefixo < 858)) or
       ((prefixo > 860) and (prefixo < 865)) or
       (prefixo = 866) or
       ((prefixo > 880) and (prefixo < 884)) or
       ((prefixo > 885) and (prefixo < 888)) or
       (prefixo = 889) or
       ((prefixo > 890) and (prefixo < 893)) or
       ((prefixo > 893) and (prefixo < 896)) or
       ((prefixo > 896) and (prefixo < 899)) or
       ((prefixo > 919) and (prefixo < 930)) or
       ((prefixo > 951) and (prefixo < 955)) or
       ((prefixo > 955) and (prefixo < 958)) or
       (prefixo = 959) or
       ((prefixo > 969) and (prefixo < 977)) or
       ((prefixo > 984) and (prefixo < 990))
    then begin
      Result := false;
      Exit;
    end;

    j     :=Length(trim(codigo));
    total := 0;

    if not AnsiMatchStr(IntToStr(j),['8','12','13','14']) then begin
      Result := false;
      Exit;
    end;

    for i:=j downto 1 do Begin
      arrayChar[(j+1)-i]:=codigo[i];
    end;

    for i:=2 to j do Begin

      auxiliar := ord(arrayChar[i])-48;

      if (auxiliar < 0) or (auxiliar > 9) then begin
        Result := false;
        Exit;
      end;

      if (i mod 2) > 0 then
        total := total + auxiliar
      else
        total := total + (auxiliar * 3);

    end;

    if (total mod 10) = 0 then
      digitoVerificador := 0
    else
      digitoVerificador := 10 - (total mod 10);

    if digitoVerificador = (ord(arrayChar[1])-48) then
      Result := true
    else
      Result := false;
  except
    Result := false;
  end;
end;

function retiraPonto(pValor : string): String;
var
 l: string ;
begin
  l := StringReplace(pValor,'.','',[rfReplaceAll]);
  Result := l;
end;

Function transformaDataFireBird(data:Variant; separador:String = '-';formato: String = 'mda'):Variant;
var
 dataInformada, dia, mes, ano:string;
begin
  dataInformada := VarToStr(data);
  dia := copy(dataInformada,1,2);
  mes := copy(dataInformada,4,2);
  ano := copy(dataInformada,7,4);

  if dia = '' then
    Result := Unassigned
  else if formato = 'dma' then
         Result := dia + separador + mes + separador + ano
       else if formato = 'mda' then
              Result := mes + separador + dia + separador + ano
            else if formato = 'amd' then
                   Result := ano + separador + mes + separador + dia;
end;
Function transformaDataFireBirdWhere(data:Variant; separador:String = '.'):Variant;
var
 dataInformada, dia, mes, ano:string;
begin
  dataInformada := VarToStr(data);
  dia := copy(dataInformada,1,2);
  mes := copy(dataInformada,4,2);
  ano := copy(dataInformada,7,4);

  if dia = '' then
    Result := Unassigned
  else
    Result := dia + separador + mes + separador + ano;
end;

Function transformaDataHoraFireBird(data:Variant):Variant;
var
 dataInformada, dia, mes, ano, hora: string;
begin
  dataInformada := VarToStr(data);
  dia  := copy(dataInformada, 1, 2);
  mes  := copy(dataInformada, 4, 2);
  ano  := copy(dataInformada, 7, 4);
  hora := copy(dataInformada, 11, 9);
  if dia = '' then
    Result := Unassigned
  else
    Result := mes + '-' + dia + '-' + ano + ' ' + hora;
end;
function converteTextoSemAcento(const str: String): String;
var
  i: Integer;
  c: char;
begin
  SetLength(Result,Length(str));
  for i := 1 to Length (str) do begin
    c := str[i];
    case c of
      '�': c := 'a';
      '�': c := 'e';
      '�': c := 'i';
      '�': c := 'o';
      '�': c := 'u';
      '�': c := 'a';
      '�': c := 'e';
      '�': c := 'i';
      '�': c := 'o';
      '�': c := 'u';
      '�': c := 'a';
      '�': c := 'e';
      '�': c := 'i';
      '�': c := 'o';
      '�': c := 'u';
      '�': c := 'a';
      '�': c := 'e';
      '�': c := 'i';
      '�': c := 'o';
      '�': c := 'u';
      '�': c := 'a';
      '�': c := 'o';
      '�': c := 'n';
      '�': c := 'c';
      '�': c := 'A';
      '�': c := 'E';
      '�': c := 'I';
      '�': c := 'O';
      '�': c := 'U';
      '�': c := 'A';
      '�': c := 'E';
      '�': c := 'I';
      '�': c := 'O';
      '�': c := 'U';
      '�': c := 'A';
      '�': c := 'E';
      '�': c := 'I';
      '�': c := 'O';
      '�': c := 'U';
      '�': c := 'A';
      '�': c := 'E';
      '�': c := 'I';
      '�': c := 'O';
      '�': c := 'U';
      '�': c := 'A';
      '�': c := 'O';
      '�': c := 'N';
    end;
    Result[i] := c;
  end;
end;
function doubleQuotedStr(const S: string): string;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do
    if Result[I] = '''' then Insert('''', Result, I);
end;

function converteTexto(Lista: TStrings;value:String): String;
  var
    i: Integer;
    sO, sD: String;
begin
  Result := value;
  if ( value = '' ) or ( Lista.Count = 0 ) then exit;
  for i := 0 to Lista.Count - 1 do begin
    sO := lista.Names[i];
    if ( sO = '' ) then continue;
    sD := lista.ValueFromIndex[i];
    Result := StringReplace(Result, sO, sD, [ rfReplaceAll ] );
  end;
end;
function validaCaracteresArquivo(Arquivo: String): String;
  var i: Integer;
    c: Char;
begin
  Result := '';
  for i := 1 to Length(Arquivo ) do begin
    c := Arquivo[i];
    if c in [ '[', ']', '/' ]  then
      c := '_';
    Result := Result + c;
  end;
end;
function textoEntreTags ( Texto, TagInicio, TagFim: String; PrimeiraOcorrencia: PInteger = nil; caseSensitive: boolean = true ): string;
  var
    inicio, fim: Integer;
    textoCompleto: String;
begin
  Result := '';
  if(caseSensitive)then
    textoCompleto := texto
  else begin
    textoCompleto := LowerCase(Texto);
    TagInicio := LowerCase(TagInicio);
    TagFim := LowerCase(TagFim);
  end;
	if (length(Texto) < ( length(TagInicio) + length(TagFim) ) ) then exit;
	inicio := 1;
	if ( PrimeiraOcorrencia <> nil ) then begin
    inicio := PrimeiraOcorrencia^;
		PrimeiraOcorrencia^ := 0;
	end;
	if ( TagInicio = '' ) then
		inicio := 1
	else begin
		inicio := PosEx( TagInicio, textoCompleto, inicio );
		if ( inicio = 0 ) then exit;
		inc(inicio, length(TagInicio));
	end;
	if ( TagFim = '' ) then
		fim := ( length(Texto) - length(TagFim) ) + 1
	else begin
		fim := PosEx ( TagFim, textoCompleto, inicio );
		if ( fim = 0 ) then exit;
	end;
	if ( ( fim - inicio ) < 1 ) then exit;
	if ( ( PrimeiraOcorrencia <> nil ) and ( fim > inicio ) ) then
		PrimeiraOcorrencia^ := inicio;
//	Result := Texto.SubString(inicio, fim - inicio );
  Result := Copy ( Texto, inicio, fim - inicio );
end;

function converteXMLNFeUTF8 ( conteudo: string; somenteUTF: boolean = false ): string;
  const Assinatura1 = #239 + #187 + #191;
    tg1a = '<NFe ';
    tg1b = '<NFe>';
    tg2 = '</NFe>';
  var
    save: string;
begin
  if ( Copy ( Conteudo, 1, 3 ) = Assinatura1 ) then
    Result := Utf8ToAnsi(Copy(Conteudo, 4, Length(Conteudo ) - 3 ))
  else
    Result := Utf8ToAnsi(Conteudo);
  if ( somenteUTF ) then exit;
  save := Result;
  Result := TextoEntreTags(Result, tg1a, tg2 );
  if ( Result = '' ) then begin
    Result := TextoEntreTags(save, tg1b, tg2 );
    if ( Result = '' ) then
      Result := save
    else
      Result := tg1b + Result + tg2;
  end else
    Result := tg1a + Result + tg2;
end;
function formataResultado(valor: TField; tipoCampo: TTipoColunas = tcoString): string;
var
  lResultado : String;
begin
  lResultado := valor.AsString;
  if tipoCampo = tcoString then
    lResultado := valor.AsString
  else
    if tipoCampo = tcoFloat then
      lResultado := FormatFloat(',0.00', valor.AsFloat)
    else
      if tipoCampo = tcoCNPJCPF then
        lResultado := formatoCNPJCPFGenerico(valor, '', true)
      else
        if tipoCampo = tcoFone then
          lResultado := formatoTelefoneGenerico(valor, '', true)
        else
          if tipoCampo = tcoCEP then
            lResultado := formatoCEPGenerico(valor, '', true)
          else
            if tipoCampo = tcoData then
              lResultado := FormatDateTime('dd/mm/yyyy', valor.AsDateTime)
            else
              if tipoCampo = tcoDataHora then
                lResultado := FormatDateTime('dd/mm/yyyy hh:nn:ss', valor.AsDateTime)
              else
                if tipoCampo = tcoHora then
                  lResultado := FormatDateTime('hh:nn', valor.AsDateTime);
  lResultado := removeEnter(lResultado);
  result := '"' + lResultado + '"';
end;
function formatoCNPJCPFGenerico(field: TField;  texto: String; displayText: Boolean): String;
  var
    mascara: string;
begin
  if(field=nil) then
    Result := texto
  else
    Result := field.AsString;
  if Result <> '' then
  begin
    if DisplayText then begin
      case Length(Result) of
        11 : mascara := '999.999.999-99;0;_';
        14 : mascara := '99.999.999/9999-99;0;_';
        else mascara := '999.999.999-99;0;_';
      end;
      Result := FormatMaskText(Mascara, Result);
    end;
  end;
end;

function valorNaListaPalavras(const valor: string; const listaPalavras: String; separador: char = ';'; padraoAntigo: String = ''; novoPadrao: String = '' ): boolean;
  var
    lista: TStrings;
    str: String;
begin
  lista := TStringList.Create;
  Result := false;
  try
    if ( padraoAntigo<> '' ) then
      str := StringReplace(listaPalavras, padraoAntigo, novoPadrao, [ rfReplaceAll ])
    else
      str := listaPalavras;
    lista.Delimiter := separador;
    lista.DelimitedText := str;
    Result := lista.IndexOf(valor)>=0;
  finally
    lista.Free;
  end
end;
function formatoTelefoneGenerico(field: TField;   texto: String; displayText: Boolean): String;
  var
    mascara: string;
begin
  if(field=nil) then
    Result := texto
  else
    Result := field.AsString;
  if Result <> '' then
  begin
    if DisplayText then begin
      case Length(Result) of
        10 : mascara := '\(00\) 0000-00000;0;_';
        11 : mascara := '\(00\) 00000-0000;0;_';
        else mascara := '\(00\) 000000000;0;_';
      end;
      Result := FormatMaskText(Mascara, Result);
    end;
  end;
end;

function formatoCEPGenerico(field: TField;  texto: String; displayText: Boolean): String;
  var
    mascara: string;
begin
  if(field=nil) then
    Result := texto
  else
    Result := field.AsString;
  if not Result.IsEmpty then
  begin
    if DisplayText then
    begin
      mascara := '00\.000\-000;0;_';
      Result := FormatMaskText(Mascara, Result);
    end;
  end;
end;

function removeCaracteresGraficos(texto: String): String;
var
  remove, final: string;
  I: Integer;
begin
  remove := '`~!@#$%^&*()-_+={}[]|\:;"<>,.?/'' ';
  final := '';
  for I := 1 to Length(texto) do
  begin
    if pos(texto[I], remove) = 0 then
      final := final + texto[I];
  end;
  Result := final;
end;
function completaComBranco(AValue:string; AQuantidade:integer; ALado: tlado):string;
var
  contador:integer;
begin
  Result := '';
  for contador := 1 to abs(AQuantidade - length(AValue)) do
  begin
    Result := Result + ' ';
  end;
  if Alado = lEsquerdo then
     Result := Result + AValue
  else
    Result := AValue + Result
end;
function Extenso(valor: real): String;
var
  Centavos, Centena, Milhar, Milhao, Bilhao, Texto : string;
const
  Unidades: array [1..9] of string = ('um', 'dois', 'tr�s','quatro','cinco',
  'seis', 'sete', 'oito','nove');
  Dez     : array [1..9] of string = ('onze', 'doze', 'treze', 'quatorze',
  'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  Dezenas : array [1..9] of string = ('dez', 'vinte', 'trinta',
  'quarenta', 'cinq�enta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  Centenas: array [1..9] of string = ('cento', 'duzentos', 'trezentos',
  'quatrocentos', 'quinhentos', 'seiscentos', 'setecentos', 'oitocentos',
  'novecentos');
  function ifs( Expressao: Boolean; CasoVerdadeiro, CasoFalso:String): String;
  begin
    if Expressao then
      Result := CasoVerdadeiro
    else
      Result :=CasoFalso;
  end;
  function MiniExtenso( Valor: ShortString ): string;
  var
    Unidade, Dezena, Centena: String;
  begin
    if (Valor[2] = '1') and (Valor[3] <> '0') then
    begin
      Unidade := Dez[StrToInt(Valor[3])];
      Dezena := '';
    end
    else
    begin
     if Valor[2] <> '0' then
       Dezena := Dezenas[StrToInt(Valor[2])];
     if Valor[3] <> '0' then
       unidade := Unidades[StrToInt(Valor[3])];
    end;
    if (Valor[1] = '1') and (Unidade = '') and (Dezena = '') then
      centena := 'cem'
    else
      if Valor[1] <> '0' then
        Centena := Centenas[StrToInt(Valor[1])]
      else
        Centena := '';
    Result := Centena + ifs( (Centena <> '') and ((Dezena <> '') or
    (Unidade <> '')),' e ', '') + Dezena + ifs( (Dezena <> '') and
    (Unidade <> ''), ' e ','') + Unidade;
  end;
begin
  if valor  <= 0 then
  Exit;
  if Valor = 0 then
  begin
    Result := '';
    Exit;
  end;
  Texto    := FormatFloat( '000000000000.00', Valor );
  Centavos := MiniExtenso( '0' + Copy( Texto, 14, 2 ) );
  Centena  := MiniExtenso( Copy( Texto, 10, 3 ) );
  Milhar   := MiniExtenso( Copy( Texto,  7, 3 ) );
  if Milhar <> '' then
    Milhar := Milhar + ' mil';
  Milhao   := MiniExtenso( Copy( Texto,  4, 3 ) );
  if Milhao <> '' then
  begin
    Milhao := Milhao
    + ifs( Copy( Texto, 4,
    3 ) = '001', ' milh�o', ' milh�es');
  end;
  Bilhao   := MiniExtenso( Copy( Texto,  1, 3 ) );
  if Bilhao <> '' then
  begin
    Bilhao := Bilhao + ifs( Copy( Texto, 1, 3 ) = '001', ' bilh�o',
    ' bilh�es');
  end;
  Result := Bilhao + ifs( (Bilhao <> '') and (Milhao + Milhar +
  Centena <> ''),
  ifs((Pos(' e ', Bilhao) > 0) or (Pos( ' e ',
  Milhao + Milhar + Centena ) > 0), ', ', ' e '), '') +
  Milhao + ifs( (Milhao <> '') and (Milhar + Centena <> ''),
  ifs((Pos(' e ', Milhao) > 0) or
  (Pos( ' e ', Milhar + Centena ) > 0 ),', ',    ' e '), '') +
  Milhar + ifs( (Milhar <> '') and
  (Centena <> ''), ifs(Pos( ' e ', Centena ) > 0, ', ', ' e '),'') + Centena;
  if (Bilhao <> '') and (Milhao + Milhar + Centena = '') then
    Result := Bilhao + ' de reais'
  else
  if (Milhao <> '') and (Milhar + Centena = '') then
    Result := Milhao + ' de reais'
  else
    Result := Bilhao + ifs( (Bilhao <> '') and (Milhao + Milhar +
    Centena <> ''), ifs((Pos(' e ', Bilhao) > 0) or (Pos( ' e ',
    Milhao +Milhar + Centena ) > 0), ', ', ' e '), '') + Milhao + ifs(
    (Milhao <> '') and (Milhar + Centena <> ''), ifs((Pos(' e ',
    Milhao) > 0) or (Pos( ' e ', Milhar + Centena ) > 0 ),', ',
    ' e '), '') + Milhar + ifs( (Milhar <> '') and (Centena <> ''),
    ifs(Pos( ' e ', Centena ) > 0, ', ', ' e '),'') +
    Centena + ifs( Int(Valor) = 1, ' real', ' reais');
  if Centavos <> '' then
  begin
    if Valor > 1 then
      Result := Result + ' e ' + Centavos + ifs( Copy(
      Texto, 14, 2 )= '01', ' centavo', ' centavos' )
    else
      Result := Centavos + ifs( Copy( Texto, 14, 2 )= '01',
      ' centavo', ' centavos' );
  end;
end;
function WriteConexao(pHost : String): THost;
  var
    parts: TDatabaseParts;
begin
  parts := getDatabaseParts(traduzirDatabaseName(pHost));
  Result.Server := parts.host;
  Result.Port := IntToStr(parts.port);
  Result.Database := parts.path;
{
  Result.Server   := Copy(pHost, 1, pos('/', pHost) -1);
  Result.Port     := Copy(pHost, pos('/', pHost) + 1, pos(':', pHost) - (pos('/', pHost) + 1));
  Result.DataBase := Copy(pHost, pos(':', pHost) + 1, pHost.Length);
  Result.DataBase := StringReplace(Result.DataBase, '\\', '\', [rfReplaceAll]);
}
end;

function formatarDataInvertida(const data: String): String;
var
  dataFormatada: TDateTime;
begin
  dataFormatada := StrToDate(Format('%s/%s/%s', [Copy(data, 7, 2), Copy(data, 5, 2), Copy(data, 1, 4)]));
  Result := FormatDateTime('dd/mm/yyyy', dataFormatada);
end;

function codigoUF(pUF : String): Integer;
begin
  if pUF = 'AC' then
    Result := 12
  else if pUF = 'AL' then
    Result := 27
  else if pUF = 'AP' then
    Result := 16
  else if pUF = 'AM' then
    Result := 13
  else if pUF = 'BA' then
    Result := 29
  else if pUF = 'CE' then
    Result := 23
  else if pUF = 'DF' then
    Result := 53
  else if pUF = 'ES' then
    Result := 32
  else if pUF = 'GO' then
    Result := 52
  else if pUF = 'MA' then
    Result := 21
  else if pUF = 'MT' then
    Result := 51
  else if pUF = 'MS' then
    Result := 50
  else if pUF = 'MG' then
    Result := 31
  else if pUF = 'PA' then
    Result := 15
  else if pUF = 'PB' then
    Result := 25
  else if pUF = 'PR' then
    Result := 41
  else if pUF = 'PE' then
    Result := 26
  else if pUF = 'PI' then
    Result := 22
  else if pUF = 'RJ' then
    Result := 33
  else if pUF = 'RN' then
    Result := 24
  else if pUF = 'RS' then
    Result := 43
  else if pUF = 'RO' then
    Result := 11
  else if pUF = 'RR' then
    Result := 14
  else if pUF = 'SC' then
    Result := 42
  else if pUF = 'SP' then
    Result := 35
  else if pUF = 'SE' then
    Result := 28
  else if pUF = 'TO' then
    Result := 17;
end;

function StringToBase64(const Input: string): string;
var
  InputBytes: TBytes;
  InputStream: TBytesStream;
  OutputStream: TStringStream;
begin
  // Converte a string de entrada em bytes
  InputBytes := TEncoding.UTF8.GetBytes(Input);

  // Cria um stream a partir dos bytes de entrada
  InputStream := TBytesStream.Create(InputBytes);
  try
    // Cria um stream para a sa�da codificada
    OutputStream := TStringStream.Create('');
    try
      // Codifica o stream de entrada em Base64 e escreve no stream de sa�da
      EncodeStream(InputStream, OutputStream);
      // Converte o stream de sa�da em string
      Result := OutputStream.DataString;
    finally
      OutputStream.Free;
    end;
  finally
    InputStream.Free;
  end;
end;

initialization
finalization
end.
