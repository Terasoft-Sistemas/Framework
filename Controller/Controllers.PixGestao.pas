unit Controllers.PixGestao;

interface

uses
  ServerController,
  Terasoft.Types,
  Terasoft.Utils,
  Terasoft.PIX.Types,
  Interfaces.PixGestao;

  type
    TControllersPixGestao = class(TInterfacedObject, IPixGestao)

      private

        vData,
        vValor,
        vStatus,
        vEndToEndId,
        vIdentificadorId,
        Sender_Nome,
        vSender_CPF_CNPJ,
        vPixID : String;
        pixpdv : IPixPdv;

        function consultarPix(pID: String) : IPixGestao;
        function resultado                 : TResultadoPixGestao;
        function inicializaPixPDV          : IPixPdv;

      public

        Constructor Create;
        Destructor Destroy; override;
        Class function New : IPixGestao;

    end;

implementation

uses
  System.SysUtils;

{ TControllersPixGestao }

constructor TControllersPixGestao.Create;
begin

end;

function TControllersPixGestao.inicializaPixPDV: IPixPdv;
var
  lParametros: IPIXPDV_Parametros;
begin
  lParametros := getIPIXPDV_Parametros;
  Result      := pixpdv;

  if (pixpdv <> nil) then
   pixpdv := nil;

  lParametros.CNPJ      := Controller.xConfiguracoes.objeto.valorTag('PIXPDV_CNPJ', '', tvString);
  lParametros.Token     := Controller.xConfiguracoes.objeto.valorTag('PIXPDV_TOKEN', '', tvString);
  lParametros.SecretKey := Controller.xConfiguracoes.objeto.valorTag('PIXPDV_SECRETKEY', '', tvString);

  pixpdv := Terasoft.PIX.Types.createPIXPDV(lParametros);
  Result := pixpdv;
end;

function TControllersPixGestao.consultarPix(pID: String): IPixGestao;
var
  lParametros : IPIXPDV_Parametros;
  lRetorno    : IPIXPDV_RetornoGenericoPix;
begin
  lParametros    := getIPIXPDV_Parametros;
  lParametros.ID := pID;

  lRetorno := inicializaPixPDV.ConsultaPixIndividual(lParametros);

  if lRetorno.erro <> '' then
    CriaException('Erro: ' +lRetorno.erro);

  vData             := DateTimeToStr(lRetorno.Data);
  vValor            := FloatToStr(lRetorno.Valor);
  vStatus           := lRetorno.Status;
  vEndToEndId       := lRetorno.EndToEndId;
  vIdentificadorId  := lRetorno.IdentificadorId;
  Sender_Nome       := lRetorno.Sender_Nome;
  vSender_CPF_CNPJ  := lRetorno.Sender_CPF_CNPJ;

end;

destructor TControllersPixGestao.Destroy;
begin
  inherited;
end;

class function TControllersPixGestao.New: IPixGestao;
begin
  Result := Self.Create;
end;

function TControllersPixGestao.resultado: TResultadoPixGestao;
begin
  Result.Data            := vData;
  Result.Valor           := vValor;
  Result.Status          := vStatus;
  Result.EndToEndId      := vEndToEndId;
  Result.IdentificadorId := vIdentificadorId;
  Result.Sender_Nome     := Sender_Nome;
  Result.Sender_CPF_CNPJ := vSender_CPF_CNPJ;
end;

end.
