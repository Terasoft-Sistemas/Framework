
{$i definicoes.inc}

unit Terasoft.Framework.Certificados;

interface

  function vencimentoDoCertificado(pCertificado: String): TDateTime;

implementation
  uses
    CAPICOM_TLB, DateUtils, Classes, SysUtils;

function vencimentoDoCertificado(pCertificado: String): TDateTime;
  var
    cert: ICertificate2;
begin
  Result := 0;
  if not FileExists(pCertificado) then
    exit;
  try
    cert := CoCertificate.Create;
    cert.Load(pCertificado,'',CAPICOM_KEY_STORAGE_DEFAULT,CAPICOM_CURRENT_USER_KEY);
    Result := cert.ValidToDate;
  except
  end;
end;

end.
