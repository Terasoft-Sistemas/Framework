unit CNPJModel;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  REST.Client,
  REST.Types, System.Classes,
  Terasoft.Configuracoes,
  Terasoft.Framework.ObjectIface,
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

  TCNPJModel=class;
  ITCNPJModel=IObject<TCNPJModel>;

  TCNPJModel = class
 private
  [weak] mySelf: ITCNPJModel;
  fRestClient          :  TRESTClient;
  fRestRequest         :  TRESTRequest;
  fRestResponse        :  TRESTResponse;
  vConfiguracoes       :  ITerasoftConfiguracoes;

  FAPI: TApi;
  procedure SetAPI(const Value: TApi);
 public

    constructor _Create(pConfiguracoes : ITerasoftConfiguracoes);
    destructor Destroy; override;

    class function getNewIface(pConfiguracoes: ITerasoftConfiguracoes): ITCNPJModel;


    function consultarCnpj(pCnpj: String): TRetornoCnpj;
    function cnpjApiBrasil(pCnpj: String): TRetornoCnpj;
    function cnpjApiReceita(pCnpj: String): TRetornoCnpj;

    property API: TApi read FAPI write SetAPI;

  end;

implementation

uses
System.JSON, System.SysUtils, Terasoft.Types, Terasoft.FuncoesTexto;

{ TCNPJModel }

constructor TCNPJModel._Create(pConfiguracoes : ITerasoftConfiguracoes);
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
  FreeAndNil(fRestRequest);
  FreeAndNil(fRestResponse);
  FreeAndNil(fRestClient);
  vConfiguracoes:=nil;

  inherited;
end;

class function TCNPJModel.getNewIface(pConfiguracoes: ITerasoftConfiguracoes): ITCNPJModel;
begin
  Result := TImplObjetoOwner<TCNPJModel>.CreateOwner(self._Create(pConfiguracoes));
  Result.objeto.myself := Result;
end;

procedure TCNPJModel.SetAPI(const Value: TApi);
begin
  FAPI := Value;
end;

function TCNPJModel.cnpjApiBrasil(pCnpj: String): TRetornoCnpj;
var
  lJsonObj, lJsonObjResponse, lJsonObjCNPJ, lJsonObjMunicipio, lJsonObjEmpresa: TJSONObject;
  lJsonValue: TJSONValue;
  lToken, lDeviceToken : String;
begin
  fRestClient.BaseURL := vConfiguracoes.objeto.valorTag('API_URL_CNPJ','https://gateway.apibrasil.io/api/v2/dados/cnpj', tvString);

  fRestClient.ContentType            := 'application/json';
  fRestRequest.Client                := fRestClient;
  fRestRequest.AcceptCharset         := 'utf-8, *;q=0.8';
  fRestRequest.Method                := rmPOST;
  fRestRequest.Response              := fRestResponse;
  fRestRequest.Params.Clear;

  lDeviceToken := vConfiguracoes.objeto.valorTag('API_DEVICE_TOKEN_CNPJ','c496858e-1457-4927-a10d-6c8b3de1f4c7', tvString);
  lToken       := vConfiguracoes.objeto.valorTag('API_TOKEN','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BsYXRhZm9ybWEuYXBpYnJhc2lsLmNvbS5ici9hdXRoL2xvZ2luIiwiaWF0IjoxNzIzMDM1MDQzLCJleHAiOjE3NTQ1NzEwNDMsIm5iZiI6MTcyMzAzNTA0MywianRpIjoiY0tQVHFhQWxr'+'Q3E5ZElkZSIsInN1YiI6IjQ0ODgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.TYRqhMHjQPGqASa1qSxf1vLBIUzMaHxElOemjmFZTWE', tvMemo);

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

  try
    if Assigned(lJsonObj.Get('response').JsonValue) then
      lJsonObjResponse := lJsonObj.Get('response').JsonValue as TJSONObject;

    if Assigned(lJsonObjResponse.Get('cnpj').JsonValue) then
      lJsonObjCNPJ := lJsonObjResponse.Get('cnpj').JsonValue as TJSONObject;

    if Assigned(lJsonObjCNPJ.Get('municipio').JsonValue) then
      lJsonObjMunicipio := lJsonObjCNPJ.Get('municipio').JsonValue as TJSONObject;

    if Assigned(lJsonObjCNPJ.Get('empresa').JsonValue) then
      lJsonObjEmpresa := lJsonObjCNPJ.Get('empresa').JsonValue as TJSONObject;


    if Assigned(lJsonObjCNPJ.Get('nome_fantasia')) then
      Result.Fantasia := lJsonObjCNPJ.Values['nome_fantasia'].Value;

    if Assigned(lJsonObjEmpresa.Get('razao_social')) then
      Result.Nome := lJsonObjEmpresa.Values['razao_social'].Value;

    if Assigned(lJsonObjCNPJ.Get('data_situacao_cadastral')) then
      Result.Abertura := formatarDataInvertida(lJsonObjCNPJ.Values['data_situacao_cadastral'].Value);

    if Assigned(lJsonObjCNPJ.Get('cep')) then
      Result.Cep := lJsonObjCNPJ.Values['cep'].Value;

    if Assigned(lJsonObjCNPJ.Get('logradouro')) then
      Result.Logradouro := lJsonObjCNPJ.Values['logradouro'].Value;

    if Assigned(lJsonObjCNPJ.Get('numero')) then
      Result.Numero := lJsonObjCNPJ.Values['numero'].Value;

    if Assigned(lJsonObjCNPJ.Get('complemento')) then
      Result.Complemento := lJsonObjCNPJ.Values['complemento'].Value;

    if Assigned(lJsonObjCNPJ.Get('bairro')) then
      Result.Bairro := lJsonObjCNPJ.Values['bairro'].Value;

    if Assigned(lJsonObjCNPJ.Get('uf')) then
      Result.UF := lJsonObjCNPJ.Values['uf'].Value;

    if Assigned(lJsonObjMunicipio.Get('descricao')) then
      Result.Municipio := lJsonObjMunicipio.Values['descricao'].Value;

    if Assigned(lJsonObjCNPJ.Get('ddd1')) then
      Result.DDD := lJsonObjCNPJ.Values['ddd1'].Value;

    if Assigned(lJsonObjCNPJ.Get('telefone1')) then
      Result.Telefone := lJsonObjCNPJ.Values['telefone1'].Value;

    if Assigned(lJsonObjCNPJ.Get('correio_eletronico')) then
      Result.Email := lJsonObjCNPJ.Values['correio_eletronico'].Value;
  finally
    FreeAndNil(lJsonObj);
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
  try
    // Início da validação do CNPJ
    if Assigned(lJsonObj.Get('status')) then
      Result.Status := lJsonObj.Values['status'].Value;

    if Assigned(lJsonObj.Get('message')) then
      Result.Message := lJsonObj.Values['message'].Value;

    if Result.Status = 'ERROR' then
       CriaException(Result.Message);
    // Fim da validação do CNPJ

    if Assigned(lJsonObj.Get('nome')) then
      Result.Nome := lJsonObj.Values['nome'].Value;

    if Assigned(lJsonObj.Get('fantasia')) then
      Result.Fantasia := lJsonObj.Values['fantasia'].Value;

    if Assigned(lJsonObj.Get('cep')) then
      Result.CEP := lJsonObj.Values['cep'].Value;

    if Assigned(lJsonObj.Get('logradouro')) then
      Result.Logradouro := lJsonObj.Values['logradouro'].Value;

    if Assigned(lJsonObj.Get('numero')) then
      Result.Numero := lJsonObj.Values['numero'].Value;

    if Assigned(lJsonObj.Get('complemento')) then
      Result.Complemento := lJsonObj.Values['complemento'].Value;

    if Assigned(lJsonObj.Get('bairro')) then
      Result.Bairro := lJsonObj.Values['bairro'].Value;

    if Assigned(lJsonObj.Get('municipio')) then
      Result.Municipio := lJsonObj.Values['municipio'].Value;

    if Assigned(lJsonObj.Get('uf')) then
      Result.UF := lJsonObj.Values['uf'].Value;

    if Assigned(lJsonObj.Get('telefone')) then
      Result.Telefone := lJsonObj.Values['telefone'].Value;

    if Assigned(lJsonObj.Get('email')) then
      Result.Email := lJsonObj.Values['email'].Value;

    if Assigned(lJsonObj.Get('abertura')) then
      Result.Abertura := lJsonObj.Values['abertura'].Value;
  finally
    freeAndNil(lJsonObj);
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
