unit CNPJModel;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  REST.Client,
  REST.Types, System.Classes,
  Terasoft.Configuracoes,
  Interfaces.Conexao;

type

  TRetornoCnpj = record
  Nome: string;
  Fantasia: string;
  Cep: string;
  Logradouro: string;
  Numero: string;
  Complemento: string;
  Bairro: string;
  Municipio: string;
  UF: string;
  Telefone: string;
  DDD: string;
  Email: string;
  Abertura: string;
  Status: string;
  Message: string;
  end;

  TApi = (tApiBrasil, tApiReceita);


  TCNPJModel = class


 private

  fRestClient          :  TRESTClient;
  fRestRequest         :  TRESTRequest;
  fRestResponse        :  TRESTResponse;
  vIConexao            :  IConexao;
  vConfiguracoes       :  TerasoftConfiguracoes;

  FAPI: TApi;
  procedure SetAPI(const Value: TApi);
 public

    constructor Create(pConfiguracoes : TerasoftConfiguracoes);
    destructor Destroy; override;
    function consultarCnpj(pCnpj: String): TRetornoCnpj;
    function cnpjApiBrasil(pCnpj: String): TRetornoCnpj;
    function cnpjApiReceita(pCnpj: String): TRetornoCnpj;

    property API: TApi read FAPI write SetAPI;

  end;

implementation

uses
System.JSON, System.SysUtils, Terasoft.Types;

{ TCNPJModel }

constructor TCNPJModel.Create(pConfiguracoes : TerasoftConfiguracoes);
begin
  fRestClient    := TRESTClient.Create(nil);
  fRestRequest   := TRESTRequest.Create(nil);
  fRestResponse  := TRESTResponse.Create(nil);

  vConfiguracoes := pConfiguracoes;

  fRestRequest.Client   := fRestClient;
  fRestRequest.Response := fRestResponse;

  fRestRequest.Timeout := 120000;

  self.FAPI := tApiBrasil;
end;

destructor TCNPJModel.Destroy;
begin
inherited;
end;

procedure TCNPJModel.SetAPI(const Value: TApi);
begin
  FAPI := Value;
end;

function TCNPJModel.cnpjApiBrasil(pCnpj: String): TRetornoCnpj;
var
  lJsonObj, lJsonObjResponse, lJsonObjCNPJ, lJsonObjMunicipio: TJSONObject;
  lJsonValue: TJSONValue;
  lToken, lDeviceToken : String;
begin
  fRestClient.BaseURL := vConfiguracoes.valorTag('API_URL_CNPJ','https://gateway.apibrasil.io/api/v2/dados/cnpj', tvString);

  fRestClient.ContentType            := 'application/json';
  fRestRequest.Client                := fRestClient;
  fRestRequest.AcceptCharset         := 'utf-8, *;q=0.8';
  fRestRequest.Method                := rmPOST;
  fRestRequest.Response              := fRestResponse;
  fRestRequest.Params.Clear;

  lDeviceToken := vConfiguracoes.valorTag('API_DEVICE_TOKEN_CNPJ','c496858e-1457-4927-a10d-6c8b3de1f4c7', tvString);
  lToken       := vConfiguracoes.valorTag('API_TOKEN','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BsYXRhZm9ybWEuYXBpYnJhc2lsLmNvbS5ici9hdXRoL2xvZ2luIiwiaWF0IjoxNjkxNDI4NDE5LCJleHAiOjE3MjI5NjQ0MTksIm5iZiI6MTY5MTQyODQxOSwianRpIj'+'oiMGtKSXFUd2lXRnVlRlhmcSIsInN1YiI6IjQ0ODgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.AWbyUffVXO7gEceuEFWVBklOWJyBnAdRyVlfpweSS0c', tvMemo);

  fRestRequest.params.AddItem;
  fRestRequest.Params.Items[0].Value := '{"cnpj":"'+pCnpj+'"}';
  fRestRequest.Params.Items[0].Kind  := pkREQUESTBODY;
  fRestRequest.Params.Items[0].ContentType := ctAPPLICATION_JSON;


  fRestRequest.Params.AddHeader('DeviceToken', lDeviceToken);
  fRestRequest.Params.ParameterByName('DeviceToken').Options := [poDoNotEncode];


  fRestRequest.Params.AddHeader('Authorization', 'Bearer '+lToken);
  fRestRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];

  fRestRequest.Execute;

  if fRestResponse.StatusCode = 400 then
    CriaException('CNPJ invalido');

  lJsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(fRestRequest.Response.Content), 0) as TJSONObject;

  if Assigned(lJsonObj.Get('response').JsonValue) then
    lJsonObjResponse := lJsonObj.Get('response').JsonValue as TJSONObject;

  if Assigned(lJsonObjResponse.Get('cnpj').JsonValue) then
    lJsonObjCNPJ := lJsonObjResponse.Get('cnpj').JsonValue as TJSONObject;

  if Assigned(lJsonObjCNPJ.Get('municipio').JsonValue) then
    lJsonObjMunicipio := lJsonObjCNPJ.Get('municipio').JsonValue as TJSONObject;


  if Assigned(lJsonObjCNPJ.Get('nome_fantasia')) then begin
    Result.Fantasia := lJsonObjCNPJ.Values['nome_fantasia'].Value;
  end;

  if Assigned(lJsonObjCNPJ.Get('cep')) then begin
    Result.Cep := lJsonObjCNPJ.Values['cep'].Value;
  end;

  if Assigned(lJsonObjCNPJ.Get('logradouro')) then begin
    Result.Logradouro := lJsonObjCNPJ.Values['logradouro'].Value;
  end;

  if Assigned(lJsonObjCNPJ.Get('numero')) then begin
    Result.Numero := lJsonObjCNPJ.Values['numero'].Value;
  end;

  if Assigned(lJsonObjCNPJ.Get('complemento')) then begin
    Result.Complemento := lJsonObjCNPJ.Values['complemento'].Value;
  end;

  if Assigned(lJsonObjCNPJ.Get('uf')) then begin
    Result.UF := lJsonObjCNPJ.Values['uf'].Value;
  end;

  if Assigned(lJsonObjMunicipio.Get('descricao')) then begin
    Result.Municipio := lJsonObjMunicipio.Values['descricao'].Value;
  end;

  if Assigned(lJsonObjCNPJ.Get('ddd1')) then begin
    Result.DDD := lJsonObjCNPJ.Values['ddd1'].Value;
  end;

  if Assigned(lJsonObjCNPJ.Get('telefone1')) then begin
    Result.Telefone := lJsonObjCNPJ.Values['telefone1'].Value;
  end;

  if Assigned(lJsonObjCNPJ.Get('correio_eletronico')) then begin
    Result.Email := lJsonObjCNPJ.Values['correio_eletronico'].Value;
  end;
end;

function TCNPJModel.cnpjApiReceita(pCnpj: String): TRetornoCnpj;
var
  lJsonObj: TJSONObject;
  lJsonValue: TJSONValue;
begin

  fRestClient.BaseURL := format('https://www.receitaws.com.br/v1/cnpj/%s', [pCnpj]);

  fRestRequest.Method := rmGET;

  fRestRequest.Execute;

  lJsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(fRestRequest.Response.Content), 0) as TJSONObject;

  // Início da validação do CNPJ
  if Assigned(lJsonObj.Get('status')) then begin
    Result.Status := lJsonObj.Values['status'].Value;
  end;

  if Assigned(lJsonObj.Get('message')) then begin
    Result.Message := lJsonObj.Values['message'].Value;
  end;

  if Result.Status = 'ERROR' then begin
     CriaException(Result.Message);
  end;
  // Fim da validação do CNPJ

  if Assigned(lJsonObj.Get('nome')) then begin
    Result.Nome := lJsonObj.Values['nome'].Value;
  end;
  if Assigned(lJsonObj.Get('fantasia')) then begin
    Result.Fantasia := lJsonObj.Values['fantasia'].Value;
  end;
  if Assigned(lJsonObj.Get('cep')) then begin
    Result.CEP := lJsonObj.Values['cep'].Value;
  end;
  if Assigned(lJsonObj.Get('logradouro')) then begin
    Result.Logradouro := lJsonObj.Values['logradouro'].Value;
  end;
  if Assigned(lJsonObj.Get('numero')) then begin
    Result.Numero := lJsonObj.Values['numero'].Value;
  end;
  if Assigned(lJsonObj.Get('complemento')) then begin
    Result.Complemento := lJsonObj.Values['complemento'].Value;
  end;
  if Assigned(lJsonObj.Get('bairro')) then begin
    Result.Bairro := lJsonObj.Values['bairro'].Value;
  end;
  if Assigned(lJsonObj.Get('municipio')) then begin
    Result.Municipio := lJsonObj.Values['municipio'].Value;
  end;
  if Assigned(lJsonObj.Get('uf')) then begin
    Result.UF := lJsonObj.Values['uf'].Value;
  end;
  if Assigned(lJsonObj.Get('telefone')) then begin
    Result.Telefone := lJsonObj.Values['telefone'].Value;
  end;
  if Assigned(lJsonObj.Get('email')) then begin
    Result.Email := lJsonObj.Values['email'].Value;
  end;
  if Assigned(lJsonObj.Get('abertura')) then begin
    Result.Abertura := lJsonObj.Values['abertura'].Value;
  end;
end;

function TCNPJModel.consultarCnpj(pCnpj: String): TRetornoCnpj;
begin
  case self.FAPI of
   tApiBrasil : Result := cnpjApiBrasil(pCnpj);
   tApiReceita : Result := cnpjApiReceita(pCnpj);
  end;
end;

end.
