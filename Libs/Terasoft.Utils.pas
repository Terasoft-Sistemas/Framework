unit Terasoft.Utils;
interface
uses
  Classes,
  Terasoft.Framework.Texto,
  StrUtils,
  SysUtils,
  MaskUtils,
  Vcl.Imaging.pngimage,
  Interfaces.Conexao,
  Vcl.ExtCtrls,
  Soap.EncdDecd,
  IdHTTP,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  Winapi.Windows,
  Vcl.Graphics,
  Vcl.StdCtrls,
  JPeg,
  Data.DB,
  FireDAC.Comp.Client,
  GIFImage,
  Vcl.Forms,
  DateUtils;


  function IIF(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
  procedure Base64ToImage(data, path: string);
  function CheckFileOnlineExists(const OnlineFile: string; var Size: Int64): Boolean;
  function CalculaMargem(pCusto, pVenda: Double): Double;
  function IgualZero(pValue: Variant): Boolean;
  function DiferenteZero(pValue: Variant): Boolean;
  function MaiorQueZero(pValue: Variant): Boolean;
  procedure CriaException(pMSG: String);
  function Base64ToImagePNG(pBase64PNG: string):TMemoryStream;
  procedure gravaSQL(pSQL, pNome: String);
  function DiaDaSemana(pData : TDate) : String;
  function DiferencaEntreValoresPercentual(valor1, Valor2: Real): Real;
  function CalculaPercentual(pValorItem, pValorTotal: Real): Real;
  function DiferencaEntreDatas(pDataInicial, pDataFinal: TDate ): Integer;
  function RetornaCoeficiente(pTaxa: Double;  pQuantidadeParcelas: Integer): IFDDataset;
  function corrigeValorExtended(p1: Extended; pCasasDecimais: Integer = 2): Extended;
  function StringToBase64(pValue: String): String;

  function memoriaEmUso(var blocos: Int64; var bytes: Int64): Int64;
  procedure logaMemoriaEmUso;

implementation

uses
  {$IFDEF VCL}
    LbString,
  {$ENDIF}
  Math,
  Terasoft.Framework.LOG,
  FastMM4,
  System.NetEncoding,
  Terasoft.Types;


function DiferencaEntreDatas(pDataInicial, pDataFinal: TDate ): Integer;
begin
  Result := DaysBetween(pDataInicial, pDataFinal);
end;

function CalculaPercentual(pValorItem, pValorTotal: Real): Real;
begin
  Result := 0;

  if pValorTotal <> 0 then
    Result := ((pValorItem*100)/pValorTotal)/100
end;

function DiferencaEntreValoresPercentual(valor1, Valor2: Real): Real;
begin
  Result := 0;

  if valor1 > 0 then
   Result := -1*(((Valor2/Valor1)*100)-100)
end;


function Base64ToImagePNG(pBase64PNG: string):TMemoryStream;
var
  stream: TMemoryStream;
  bytes: TBytes;
  png: TPNGImage;
  x: integer;
  d: string;
begin
  try
    x := pos(',', pBase64PNG);
    d := copy(pBase64PNG, x + 1, Length(pBase64PNG));
    bytes := decodebase64(d);
    if Length(bytes) > 0 then
    begin
      stream := TMemoryStream.Create;
      stream.WriteData(bytes, Length(bytes));
      stream.Position := 0;
      png := TPNGImage.Create;
      png.LoadFromStream(stream);
      png.SaveToFile('c:\sci\teste.png');
      png.SaveToStream(Result);
     // Result := stream;
    end;
  finally
   png.Destroy;
   stream.Free;
  end;
end;
function MaiorQueZero(pValue: Variant): Boolean;
begin
  Result := pValue > 0;
end;
function DiferenteZero(pValue: Variant): Boolean;
begin
  Result := pValue <> 0;
end;
function IgualZero(pValue: Variant): Boolean;
begin
  Result := pValue = 0;
end;
procedure CriaException(pMSG: String);
begin
  raise Exception.Create(pMSG);
end;
function CalculaMargem(pCusto, pVenda: Double): Double;
begin
  if (pVenda > 0) and (pCusto > 0) then
    Result := (pCusto * 100) / pVenda
  else
    Result := 0;
end;

function IIF(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
begin
  if Expressao then
   Result := ParteTRUE
  else
   Result := ParteFALSE;
end;

procedure Base64ToImage(data, path: string);
var
  stream: TMemoryStream;
  bytes : TBytes;
  jpg   : TJPEGImage;
  x     : integer;
  d     : string;
begin
  x     := pos(',', data);
  d     := copy(data, x + 1, 9165536);
  bytes := decodebase64(d);

  if Length(bytes) > 0 then
  begin
    stream := TMemoryStream.Create;
    stream.WriteData(bytes, Length(bytes));
    stream.Position := 0;

    jpg := TJPEGImage.Create;
    jpg.LoadFromStream(stream);
    jpg.SaveToFile(path);
    jpg.Destroy;
  end;

  stream.Free;
end;

function CheckFileOnlineExists(const OnlineFile: string; var Size: Int64): Boolean;
var
 IdHttp: TIdHTTP;
begin
  try
    IdHttp := TIdHTTP.Create(nil);
    try
      IdHttp.Head(OnlineFile);
      Size := IdHttp.Response.ContentLength;
      if Size > 0 then
        Result := True
      else
        Result := False;
    except on E: EIdHTTPProtocolException do
      begin
        // Fazer algo aqui caso você queira tratar alguma exceção do IdHttp
        Result := False;
      end;
    end;
  finally
    IdHttp.Free;
  end;
end;
procedure gravaSQL(pSQL, pNome: String);
var
 lSQL: TStringList;
begin
  try
    ForceDirectories(ExtractFileDir(Application.ExeName) + '\temp');
    try
      lSQL := TStringList.Create;

      lSQL.Clear;
      lSQL.Add(pSQL);
      lSQL.SaveToFile(ExtractFileDir(Application.ExeName) + '\temp\'+pNome+'.sql');

    finally
      lSQL.Free;
    end;
  except
  end;

end;

function DiaDaSemana(pData : TDate) : String;
var
  lDia: String;
begin
  case (dayofweek(pData)) of
    1: lDia := 'DOMINGO';
		2: lDia := 'SEGUNDA';
		3: lDia := 'TERCA';
		4: lDia := 'QUARTA';
		5: lDia := 'QUINTA';
		6: lDia := 'SEXTA';
		7: lDia := 'SABADO';
  end;
  Result := lDia;
end;

function RetornaCoeficiente(pTaxa: Double;  pQuantidadeParcelas: Integer): IFDDataset;
var
 lTaxa         : Double;
 lCoeficiente  : Double;
 i             : Integer;
 lConta1,
 lConta2,
 lConta3       : Double;
 lMSG          : String;
 lMemTable     : TFDMemTable;
begin
  lMemTable := TFDMemTable.Create(nil);
  Result := criaIFDDataset(lMemTable);
  lTaxa     := pTaxa / 100;
  lMSG      := '';
  lConta1   := 1 + ltaxa;

  with lMemTable.IndexDefs.AddIndexDef do
  begin
    Name := 'OrdenacaoParcela';
    Fields := 'PARCELA';
    Options := [TIndexOption.ixCaseInsensitive];
  end;

  lMemTable.IndexName := '';

  lMemTable.FieldDefs.Add('PARCELA'     , ftInteger);
  lMemTable.FieldDefs.Add('COEFICIENTE' , ftFloat);
  lMemTable.CreateDataSet;

  for i := 1 to pQuantidadeParcelas do
  begin
    if i = 1 then
      lConta2 := lConta1
    else
      lConta2 := lConta2 * lConta1;

    lConta3 := 1 / lConta2;

    lCoeficiente := lTaxa/(1-lConta3);

    lMemTable.InsertRecord([
                            i,
                            lCoeficiente
                           ]);

  end;

  lMemTable.IndexName := 'OrdenacaoParcela';
  lMemTable.Open;
end;

function corrigeValorExtended(p1: Extended; pCasasDecimais: Integer = 2): Extended;
  var
    p: Extended;
begin
  p := Power(10,pCasasDecimais);
  Result := Trunc(((p1)* p) / p);
end;

function StringToBase64(pValue: String): String;
begin
  Result := TNetEncoding.Base64.Encode(AnsiString(pValue));
end;

function memoriaEmUso;
 var
   Estado: FastMM4.TMemoryManagerState;
   I: Integer;
begin
   Blocos := 0;
   Bytes := 0;

   FastMM4.GetMemoryManagerState(Estado);

   for I := 0 to High(Estado.SmallBlockTypeStates) do begin

     Inc(Blocos, Estado.SmallBlockTypeStates[I].AllocatedBlockCount);
     Inc(Bytes, Estado.SmallBlockTypeStates[I].AllocatedBlockCount
       * Estado.SmallBlockTypeStates[I].UseableBlockSize);
   end;

   Inc(Blocos, Estado.AllocatedMediumBlockCount);
   Inc(Bytes, Estado.TotalAllocatedMediumBlockSize);

   Inc(Blocos, Estado.AllocatedLargeBlockCount);
   Inc(Bytes, Estado.TotalAllocatedLargeBlockSize);

   Result := Bytes;

end;

procedure logaMemoriaEmUso;
  var
    blocos,bytes: Int64;
begin
  memoriaEmUso(blocos,bytes);
  logaByTagSeNivel(TAGLOG_CONDICIONAL, format('Blocos de memória: [%d]: Bytes: [%d]', [blocos,bytes]),LOG_LEVEL_DEBUG);
end;


end.

