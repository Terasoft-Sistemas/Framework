unit CNPJModel;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  REST.Client,
  REST.Types, System.Classes,
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
  Email: string;
  Status: string;
  Message: string;
  end;


  TCNPJModel = class


 private

  fRestClient          :  TRESTClient;
  fRestRequest         :  TRESTRequest;
  fRestResponse        :  TRESTResponse;
  vIConexao            :  IConexao;

 public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;
    function consultarCnpj(pCnpj: String): TRetornoCnpj;

  end;

  const
  URL = 'https://www.receitaws.com.br/v1/cnpj/%s';

implementation

uses
System.JSON, System.SysUtils;

{ TCNPJModel }

constructor TCNPJModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;

  fRestClient    := TRESTClient.Create(nil);
  fRestRequest   := TRESTRequest.Create(nil);
  fRestResponse  := TRESTResponse.Create(nil);

  fRestRequest.Client   := fRestClient;
  fRestRequest.Response := fRestResponse;

  fRestRequest.Timeout := 120000;

end;

destructor TCNPJModel.Destroy;
begin
inherited;
end;

function TCNPJModel.consultarCnpj(pCnpj: String): TRetornoCnpj;
var
  lJsonObj: TJSONObject;
  lJsonValue: TJSONValue;
begin

    fRestClient.BaseURL := format(URL, [pCnpj]);

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

end;

end.
