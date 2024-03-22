unit CEPModel;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  REST.Client,
  REST.Types, System.Classes,
  Interfaces.Conexao;

type

  TRetornoCEP = record
  CEP: string;
  Logradouro: string;
  Complemento: string;
  Bairro: string;
  Localidade: string;
  UF: string;
  IBGE: string;
  GIA: string;
  DDD: string;
  Siafi: string;
  end;

  TCEPModel = class

 private

  fRestClient          :  TRESTClient;
  fRestRequest         :  TRESTRequest;
  fRestResponse        :  TRESTResponse;
  vIConexao            :  IConexao;

 public

  constructor Create(pIConexao : IConexao);
  destructor Destroy; override;
  function consultarCEP(pCEP: String): TRetornoCEP;

  end;

  const
  URL = 'https://viacep.com.br/ws/%s/json/';

implementation

uses
System.JSON, System.SysUtils;

{ TCEPModel }

constructor TCEPModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;

  fRestClient    := TRESTClient.Create(nil);
  fRestRequest   := TRESTRequest.Create(nil);
  fRestResponse  := TRESTResponse.Create(nil);

  fRestRequest.Client   := fRestClient;
  fRestRequest.Response := fRestResponse;

  fRestRequest.Timeout := 120000;

end;

destructor TCEPModel.Destroy;
begin
inherited;
end;

function TCEPModel.consultarCEP(pCEP: String): TRetornoCEP;
var
  lJsonObj: TJSONObject;
  lJsonValue: TJSONValue;
begin

    fRestClient.BaseURL := format(URL, [pCEP]);

    fRestRequest.Method := rmGET;

    fRestRequest.Execute;

    if fRestResponse.StatusCode = 400 then
      CriaException('CEP invalido');

    lJsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(fRestRequest.Response.Content), 0) as TJSONObject;

    if Assigned(lJsonObj.Get('cep')) then begin
      Result.CEP := lJsonObj.Values['cep'].Value;
    end;
    if Assigned(lJsonObj.Get('logradouro')) then begin
      Result.Logradouro := lJsonObj.Values['logradouro'].Value;
    end;
    if Assigned(lJsonObj.Get('complemento')) then begin
      Result.Complemento := lJsonObj.Values['complemento'].Value;
    end;
    if Assigned(lJsonObj.Get('bairro')) then begin
      Result.Bairro := lJsonObj.Values['bairro'].Value;
    end;
    if Assigned(lJsonObj.Get('localidade')) then begin
      Result.Localidade := lJsonObj.Values['localidade'].Value;
    end;
    if Assigned(lJsonObj.Get('uf')) then begin
      Result.UF := lJsonObj.Values['uf'].Value;
    end;
    if Assigned(lJsonObj.Get('ibge')) then begin
      Result.IBGE := lJsonObj.Values['ibge'].Value;
    end;
    if Assigned(lJsonObj.Get('gia')) then begin
      Result.GIA := lJsonObj.Values['gia'].Value;
    end;
    if Assigned(lJsonObj.Get('ddd')) then begin
      Result.DDD := lJsonObj.Values['ddd'].Value;
    end;
    if Assigned(lJsonObj.Get('siafi')) then begin
      Result.Siafi := lJsonObj.Values['siafi'].Value;
    end;

end;

end.
