﻿unit CEPModel;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  REST.Client,
  REST.Types, System.Classes,
  Interfaces.Conexao,
  Terasoft.Configuracoes,
  REST.Authenticator.Basic,
  ACBrBase,
  ACBrSocket,
  ACBrCEP,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ObjectIface,
  Data.DB;

type
  TCEPModel = class;
  ITCEPModel=IObject<TCEPModel>;

  TRetornoCEP = record
    CEP: string;
    Logradouro: string;
    Bairro: string;
    Cidade: string;
    Cod_Municipio: string;
    UF: string;
    DDD: string;
    Complemento: string;
  end;

  TApi = (tApiBrasil, tApiViaCep);

  TCEPModel = class
    private
      [unsafe] mySelf: ITCEPModel;
      fRestClient          :  TRESTClient;
      fRestRequest         :  TRESTRequest;
      fRestResponse        :  TRESTResponse;
      vConfiguracoes       :  ITerasoftConfiguracoes;
      vACBrCEP             :  TACBrCEP;
      vMemtable            : TFDMemtable;
      FAPI                 : TApi;

      procedure SetAPI(const Value: TApi);
      procedure vACBrCEPBuscaEfetuada(Sender: TObject);

    public
      constructor _Create(pConfiguracoes : ITerasoftConfiguracoes);
      destructor Destroy; override;

      class function getNewIface(pConfiguracoes : ITerasoftConfiguracoes): ITCEPModel;

      function consultarCEP(pCEP: String): TRetornoCEP;
      function cepApiBrasil(pCep: String): TRetornoCEP;
      function cepApiViaCep(pCep: String): TRetornoCEP;

      property API: TApi read FAPI write SetAPI;

      function retornarCEP(pEndereco, pCidade, pUF: String): TFDMemtable;

  end;

implementation

uses
System.JSON, System.SysUtils, Terasoft.Types;

{ TCEPModel }

constructor TCEPModel._Create(pConfiguracoes : ITerasoftConfiguracoes);
begin
  fRestClient    := TRESTClient.Create(nil);
  fRestRequest   := TRESTRequest.Create(nil);
  fRestResponse  := TRESTResponse.Create(nil);

  vConfiguracoes := pConfiguracoes;

  fRestRequest.Client   := fRestClient;
  fRestRequest.Response := fRestResponse;

  fRestRequest.Timeout := 120000;

  if vConfiguracoes.objeto.valorTag('API_CEP_PADRAO','N', tvBool) = 'S' then
    self.FAPI := tApiBrasil
  else
    self.FAPI := tApiViaCep;

  vACBrCEP := TACBrCEP.Create(nil);
  vACBrCEP.URL;
  vACBrCEP.ParseText := True;
  vACBrCEP.TimeOut := 2000;
  vACBrCEP.WebService := wsViaCep;
  vACBrCEP.OnBuscaEfetuada := vACBrCEPBuscaEfetuada;
end;

procedure TCEPModel.vACBrCEPBuscaEfetuada(Sender: TObject);
var
  I : Integer;
begin
  if vACBrCEP.Enderecos.Count < 1 then begin
    criaException('Nenhum Endere�o encontrado');
  end
  else
  begin
    try
      vMemtable := TFDMemTable.Create(nil);

      vMemtable.FieldDefs.Add('CEP_CLI', ftString, 8);
      vMemtable.FieldDefs.Add('ENDERECO_CLI', ftString, 40);
      vMemtable.FieldDefs.Add('COMPLEMENTO', ftString, 50);
      vMemtable.FieldDefs.Add('BAIRRO_CLI', ftString, 20);
      vMemtable.FieldDefs.Add('CIDADE_CLI', ftString, 30);
      vMemtable.FieldDefs.Add('COD_MUNICIPIO', ftString, 10);
      vMemtable.FieldDefs.Add('UF_CLI', ftString, 2);

      vMemtable.CreateDataSet;

    for I := 0 to vACBrCEP.Enderecos.Count - 1 do
      begin
        with vACBrCEP.Enderecos[I] do
        begin
          vMemtable.InsertRecord([
            removeCaracteresGraficos(CEP),
            UpperCase(converteTextoSemAcento(Logradouro)),
            UpperCase(Complemento),
            UpperCase(Bairro),
            UpperCase(converteTextoSemAcento(Municipio)),
            IBGE_Municipio,
            UpperCase(UF)
          ]);
        end;
      end;

      vMemtable.Open;
    except
    on E:Exception do
      criaException(E.Message);
    end;
  end;
end;

destructor TCEPModel.Destroy;
begin
  inherited;
  FreeAndNil(fRestClient);
  FreeAndNil(fRestRequest);
  FreeAndNil(fRestResponse);

  vConfiguracoes := nil;

  FreeAndNil(vACBrCEP);

end;

class function TCEPModel.getNewIface(pConfiguracoes: ITerasoftConfiguracoes): ITCEPModel;
begin
  Result := TImplObjetoOwner<TCEPModel>.CreateOwner(self._Create(pConfiguracoes));
  Result.objeto.myself := Result;
end;

function TCEPModel.retornarCEP(pEndereco, pCidade, pUF: String): TFDMemtable;
begin

  try
    vACBrCEP.BuscarPorLogradouro(converteTextoSemAcento(pCidade), '', trim(retiraPonto(converteTextoSemAcento(pEndereco))), pUF,'');
  except
  on E:Exception do
    criaException(E.Message);
  end;

  Result := vMemtable;
end;

procedure TCEPModel.SetAPI(const Value: TApi);
begin
  FAPI := Value;
end;

function TCEPModel.cepApiBrasil(pCep: String): TRetornoCEP;
var
  lJsonObj, lJsonObjResponse, lJsonObjCEP, lJsonObjCidade, lJsonObjBairro : TJSONObject;
  lJsonValue: TJSONValue;
  lToken, lDeviceToken : String;
begin
  fRestClient.BaseURL := vConfiguracoes.objeto.valorTag('API_URL_CEP','https://gateway.apibrasil.io/api/v2/cep/cep', tvString);

  fRestClient.ContentType            := 'application/json';
  fRestRequest.Client                := fRestClient;
  fRestRequest.AcceptCharset         := 'utf-8, *;q=0.8';
  fRestRequest.Method                := rmPOST;
  fRestRequest.Response              := fRestResponse;
  fRestRequest.Params.Clear;

  lDeviceToken := vConfiguracoes.objeto.valorTag('API_DEVICE_TOKEN_CEP','aab31101-b8a4-4d8e-8611-fce6bc4c5055', tvString);
  lToken       := vConfiguracoes.objeto.valorTag('API_TOKEN','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BsYXRhZm9ybWEuYXBpYnJhc2lsLmNvbS5ici9hdXRoL2xvZ2luIiwiaWF0IjoxNzIzMDM1MDQzLCJleHAiOjE3NTQ1NzEwNDMsIm5iZiI6MTcyMzAzNTA0MywianRpIjoiY0tQVHFhQWxr'+'Q3E5ZElkZSIsInN1YiI6IjQ0ODgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.TYRqhMHjQPGqASa1qSxf1vLBIUzMaHxElOemjmFZTWE', tvMemo);

  fRestRequest.params.AddItem;
  fRestRequest.Params.Items[0].Value := '{"cep":"'+pCEP+'"}';
  fRestRequest.Params.Items[0].Kind  := pkREQUESTBODY;
  fRestRequest.Params.Items[0].ContentType := ctAPPLICATION_JSON;



  fRestRequest.Params.AddHeader('DeviceToken', lDeviceToken);
  fRestRequest.Params.ParameterByName('DeviceToken').Options := [poDoNotEncode];



  fRestRequest.Params.AddHeader('Authorization', 'Bearer '+lToken);
  fRestRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];

  fRestRequest.Execute;

  if fRestResponse.StatusCode = 401 then
    CriaException('Token n�o autorizado para a consulta!');

  if fRestResponse.StatusCode >= 400 then
    Abort;

  lJsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(fRestRequest.Response.Content), 0) as TJSONObject;
  try
    if Assigned(lJsonObj.Get('response').JsonValue) and (lJsonObj.Get('response').JsonValue is TJSONObject) then
      lJsonObjResponse := lJsonObj.Get('response').JsonValue as TJSONObject;

    if Assigned(lJsonObjResponse.Get('cep').JsonValue) and (lJsonObjResponse.Get('cep').JsonValue is TJSONObject) then
      lJsonObjCEP := lJsonObjResponse.Get('cep').JsonValue as TJSONObject;

    if Assigned(lJsonObjCEP.Get('cidade').JsonValue) and (lJsonObjCEP.Get('cidade').JsonValue is TJSONObject) then
      lJsonObjCidade := lJsonObjCEP.Get('cidade').JsonValue as TJSONObject;

    if Assigned(lJsonObjCEP.Get('bairro').JsonValue) and (lJsonObjCEP.Get('bairro').JsonValue is TJSONObject) then
      lJsonObjBairro := lJsonObjCEP.Get('bairro').JsonValue as TJSONObject;

    if Assigned(lJsonObjCEP) and  Assigned(lJsonObjCEP.Get('cep')) then
      Result.CEP := lJsonObjCEP.Values['cep'].Value;

    if Assigned(lJsonObjCEP) and Assigned(lJsonObjCEP.Get('logradouro_sem_acento')) then
      Result.Logradouro := lJsonObjCEP.Values['logradouro_sem_acento'].Value;

    if Assigned(lJsonObjCEP) and Assigned(lJsonObjCEP.Get('estado')) then
      Result.UF := lJsonObjCEP.Values['estado'].Value;

    if Assigned(lJsonObjCidade) and Assigned(lJsonObjCidade.Get('cidade_sem_acento')) then
      Result.Cidade := lJsonObjCidade.Values['cidade_sem_acento'].Value;

    if Assigned(lJsonObjCidade) and Assigned(lJsonObjCidade.Get('cidade_ibge')) then
      Result.Cod_Municipio := lJsonObjCidade.Values['cidade_ibge'].Value;

    if Assigned(lJsonObjBairro) and Assigned(lJsonObjBairro.Get('bairro_sem_acento')) then
      Result.Bairro := TJSONString(lJsonObjBairro.Get('bairro_sem_acento').JsonValue).Value;
  finally
    freeAndNil(lJsonObj);
  end;
end;

function TCEPModel.cepApiViaCep(pCep: String): TRetornoCEP;
var
  lJsonObj: TJSONObject;
  lJsonValue: TJSONValue;
begin

  fRestClient.BaseURL := format('https://viacep.com.br/ws/%s/json/', [pCEP]);

  fRestRequest.Method := rmGET;

  fRestRequest.Execute;

  if fRestResponse.StatusCode >= 400 then
    Abort;

  lJsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(fRestRequest.Response.Content), 0) as TJSONObject;

  try
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
      Result.Cidade := lJsonObj.Values['localidade'].Value;
    end;

    if Assigned(lJsonObj.Get('uf')) then begin
      Result.UF := lJsonObj.Values['uf'].Value;
    end;
    if Assigned(lJsonObj.Get('ibge')) then begin
      Result.Cod_Municipio := lJsonObj.Values['ibge'].Value;
    end;
  finally
    freeAndNil(lJsonObj);
  end;
end;

function TCEPModel.consultarCEP(pCEP: String): TRetornoCEP;
begin

  case self.FAPI of

    tApiBrasil : Result := cepApiBrasil(pCEP);
    tApiViaCep : Result := cepApiViaCep(pCEP);

  end;

end;

end.
