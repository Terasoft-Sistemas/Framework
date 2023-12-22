
{$i definicoes.inc}

unit Framework.Random;

interface
  uses
    SysUtils,Classes;

  function randomByte: Byte;
  function randomWord: Word;
  function randomUINT32: UInt32;
  function randomInt64: UInt64;
  function randomBytes(tamanho: Word=0): TBytes;

implementation
  uses
    JwaWinCrypt;

function randomInt64: UInt64;
  var
    b: TBytes;
begin
  b := randomBytes(sizeof(UINT64));
  Result := PUINT64(b)^;
end;
  type
  PUINT32 = ^UINT32;

function randomUINT32: UInt32;
  var
    b: TBytes;
begin
  b := randomBytes(sizeof(UINT32));
  Result := PUINT32(b)^;
end;

function randomByte;
begin
  Result := randomBytes(1)[0];
end;

function randomWord;
  var
    b: TBytes;
begin
  b := randomBytes(2);
  Result := PWORD(b)^;
end;

function randomBytes(tamanho: Word): TBytes;
  var
    hProv : HCRYPTPROV;
begin
  if(tamanho<1) then
    tamanho := randomWord;
  if not CryptAcquireContext(hProv,
                             nil,
                             MS_ENHANCED_PROV,
                             PROV_RSA_FULL,
                             CRYPT_VERIFYCONTEXT) then
    CryptAcquireContext(hProv,
                        nil,
                        MS_ENHANCED_PROV,
                        PROV_RSA_FULL,
                        CRYPT_NEWKEYSET + CRYPT_VERIFYCONTEXT);
  if hProv > 0 then
  try
    SetLength(Result,tamanho);
    CryptGenRandom(hProv,tamanho,@Result[0]);
  finally
    CryptReleaseContext(hProv,0);
  end;
end;

end.
