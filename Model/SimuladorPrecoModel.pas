unit SimuladorPrecoModel;

interface

uses
  Terasoft.Types,
  Terasoft.Utils,
  System.Generics.Collections;

type

  TResultado = record
    CustoBruto,
    CustoLiquido,
    CustoCompra    : Double;
  end;

  TSimuladorPrecoModel = class

  private
    FPERCENTUAL_MVA: Double;
    FPERCENTUAL_CREDITO_PIS_COFINS: Double;
    FPERCENTUAL_REDUCAO_ST: Double;
    FPERCENTUAL_ICMS_ST: Double;
    FVALOR_AQUISICAO: Double;
    FPERCENTUAL_FRETE: Double;
    FPERCENTUAL_IPI: Double;
    FPERCENTUAL_REDUCAO_ICMS: Double;
    FPERCENTUAL_MARGEM: Double;
    FPERCENTUAL_ICMS: Double;
    FTIPO_FRETE: String;
    FVALOR_ICMS: Double;
    FVALOR_CREDITO_PIS_COFINS: Double;
    FVALOR_ICMS_ST: Double;
    FVALOR_FRETE: Double;
    FVALOR_IPI: Double;
    procedure SetPERCENTUAL_CREDITO_PIS_COFINS(const Value: Double);
    procedure SetPERCENTUAL_FRETE(const Value: Double);
    procedure SetPERCENTUAL_ICMS(const Value: Double);
    procedure SetPERCENTUAL_ICMS_ST(const Value: Double);
    procedure SetPERCENTUAL_IPI(const Value: Double);
    procedure SetPERCENTUAL_MARGEM(const Value: Double);
    procedure SetPERCENTUAL_MVA(const Value: Double);
    procedure SetPERCENTUAL_REDUCAO_ICMS(const Value: Double);
    procedure SetPERCENTUAL_REDUCAO_ST(const Value: Double);
    procedure SetVALOR_AQUISICAO(const Value: Double);
    procedure SetTIPO_FRETE(const Value: String);
    procedure SetVALOR_CREDITO_PIS_COFINS(const Value: Double);
    procedure SetVALOR_FRETE(const Value: Double);
    procedure SetVALOR_ICMS(const Value: Double);
    procedure SetVALOR_ICMS_ST(const Value: Double);
    procedure SetVALOR_IPI(const Value: Double);

  public
    property VALOR_AQUISICAO: Double read FVALOR_AQUISICAO write SetVALOR_AQUISICAO;
    property PERCENTUAL_IPI: Double read FPERCENTUAL_IPI write SetPERCENTUAL_IPI;
    property PERCENTUAL_FRETE: Double read FPERCENTUAL_FRETE write SetPERCENTUAL_FRETE;
    property PERCENTUAL_MVA: Double read FPERCENTUAL_MVA write SetPERCENTUAL_MVA;
    property PERCENTUAL_ICMS_ST: Double read FPERCENTUAL_ICMS_ST write SetPERCENTUAL_ICMS_ST;
    property PERCENTUAL_ICMS: Double read FPERCENTUAL_ICMS write SetPERCENTUAL_ICMS;
    property PERCENTUAL_CREDITO_PIS_COFINS: Double read FPERCENTUAL_CREDITO_PIS_COFINS write SetPERCENTUAL_CREDITO_PIS_COFINS;
    property PERCENTUAL_REDUCAO_ST: Double read FPERCENTUAL_REDUCAO_ST write SetPERCENTUAL_REDUCAO_ST;
    property PERCENTUAL_REDUCAO_ICMS: Double read FPERCENTUAL_REDUCAO_ICMS write SetPERCENTUAL_REDUCAO_ICMS;
    property PERCENTUAL_MARGEM: Double read FPERCENTUAL_MARGEM write SetPERCENTUAL_MARGEM;
    property TIPO_FRETE: String read FTIPO_FRETE write SetTIPO_FRETE;

    property VALOR_IPI: Double read FVALOR_IPI write SetVALOR_IPI;
    property VALOR_FRETE: Double read FVALOR_FRETE write SetVALOR_FRETE;
    property VALOR_ICMS_ST: Double read FVALOR_ICMS_ST write SetVALOR_ICMS_ST;
    property VALOR_ICMS: Double read FVALOR_ICMS write SetVALOR_ICMS;
    property VALOR_CREDITO_PIS_COFINS: Double read FVALOR_CREDITO_PIS_COFINS write SetVALOR_CREDITO_PIS_COFINS;

    function simular: TResultado;
    function calcular: TResultado;

  	constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TSimuladorPrecoModel }


function TSimuladorPrecoModel.calcular: TResultado;
var
  lCreditoICMS,
  lIcmsST,
  lBaseST,
  lCustoIPI,
  lBase : Double;
begin
  if not (FVALOR_AQUISICAO > 0) then
    CriaException('Valor de aquisição deve ser informado.');

  lCustoIPI := VALOR_AQUISICAO + VALOR_IPI;

  if PERCENTUAL_REDUCAO_ST > 0 then
    lBase := lCustoIPI - (PERCENTUAL_REDUCAO_ST / 100 * lCustoIPI)
  else
    lBase := lCustoIPI;

  if PERCENTUAL_MVA > 0 then begin
   if TIPO_FRETE = 'CIF' then
     lBase  := lBase + VALOR_FRETE;
    lBaseST := lBase + (PERCENTUAL_MVA / 100 * lBase);
    lIcmsST := lBaseST * (PERCENTUAL_ICMS_ST / 100);
  end
  else begin
    lIcmsST := 0;
  end;

  if lIcmsST = 0 then
    lCreditoICMS := VALOR_ICMS;

  Result.CustoBruto    := lCustoIPI + VALOR_ICMS_ST + VALOR_FRETE;
  Result.CustoLiquido  := VALOR_AQUISICAO;
  Result.CustoCompra   := ( lCustoIPI + VALOR_ICMS_ST + VALOR_FRETE ) - (VALOR_CREDITO_PIS_COFINS + lCreditoICMS);
end;

constructor TSimuladorPrecoModel.Create;
begin

end;

destructor TSimuladorPrecoModel.Destroy;
begin
  inherited;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_CREDITO_PIS_COFINS(
  const Value: Double);
begin
  FPERCENTUAL_CREDITO_PIS_COFINS := Value;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_FRETE(const Value: Double);
begin
  FPERCENTUAL_FRETE := Value;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_ICMS(const Value: Double);
begin
  FPERCENTUAL_ICMS := Value;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_ICMS_ST(const Value: Double);
begin
  FPERCENTUAL_ICMS_ST := Value;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_IPI(const Value: Double);
begin
  FPERCENTUAL_IPI := Value;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_MARGEM(const Value: Double);
begin
  FPERCENTUAL_MARGEM := Value;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_MVA(const Value: Double);
begin
  FPERCENTUAL_MVA := Value;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_REDUCAO_ICMS(const Value: Double);
begin
  FPERCENTUAL_REDUCAO_ICMS := Value;
end;

procedure TSimuladorPrecoModel.SetPERCENTUAL_REDUCAO_ST(const Value: Double);
begin
  FPERCENTUAL_REDUCAO_ST := Value;
end;

procedure TSimuladorPrecoModel.SetTIPO_FRETE(const Value: String);
begin
  FTIPO_FRETE := Value;
end;

procedure TSimuladorPrecoModel.SetVALOR_AQUISICAO(const Value: Double);
begin
  FVALOR_AQUISICAO := Value;
end;

procedure TSimuladorPrecoModel.SetVALOR_CREDITO_PIS_COFINS(const Value: Double);
begin
  FVALOR_CREDITO_PIS_COFINS := Value;
end;

procedure TSimuladorPrecoModel.SetVALOR_FRETE(const Value: Double);
begin
  FVALOR_FRETE := Value;
end;

procedure TSimuladorPrecoModel.SetVALOR_ICMS(const Value: Double);
begin
  FVALOR_ICMS := Value;
end;

procedure TSimuladorPrecoModel.SetVALOR_ICMS_ST(const Value: Double);
begin
  FVALOR_ICMS_ST := Value;
end;

procedure TSimuladorPrecoModel.SetVALOR_IPI(const Value: Double);
begin
  FVALOR_IPI := Value;
end;

function TSimuladorPrecoModel.simular: TResultado;
var
  lValorFrete,
  lValorIPI,
  lCustoIPI,
  lValorCreditoPisCofins,
  lBase,
  lBaseST,
  lIcmsST,
  lIcmsProprio,
  lValorST,
  lCreditoICMS : Double;
begin
  if not (FVALOR_AQUISICAO > 0) then
    CriaException('Valor de aquisição deve ser informado.');

  lValorFrete := PERCENTUAL_FRETE / 100 * VALOR_AQUISICAO;

  if TIPO_FRETE = 'CIF' then
    lValorIPI := PERCENTUAL_IPI / 100 * (VALOR_AQUISICAO + lValorFrete)
  else
    lValorIPI := PERCENTUAL_IPI / 100 * VALOR_AQUISICAO;

  lCustoIPI := VALOR_AQUISICAO + lValorIPI;

  lValorCreditoPisCofins := PERCENTUAL_CREDITO_PIS_COFINS / 100 * lCustoIPI;

  if PERCENTUAL_REDUCAO_ST > 0 then
    lBase := lCustoIPI - (PERCENTUAL_REDUCAO_ST / 100 * lCustoIPI)
  else
    lBase := lCustoIPI;

  if PERCENTUAL_ICMS > 0 then begin
    if PERCENTUAL_REDUCAO_ICMS > 0 then begin
     if TIPO_FRETE = 'CIF' then
       lIcmsProprio := ((VALOR_AQUISICAO + lValorFrete) - ((VALOR_AQUISICAO + lValorFrete) * (PERCENTUAL_REDUCAO_ICMS / 100 ))) * (PERCENTUAL_ICMS / 100)
     else
       lIcmsProprio := ((VALOR_AQUISICAO) - (VALOR_AQUISICAO * ( PERCENTUAL_REDUCAO_ICMS / 100 ))) * (PERCENTUAL_ICMS / 100)
    end
    else begin
     if TIPO_FRETE = 'CIF' then
       lIcmsProprio := (VALOR_AQUISICAO + lValorFrete) * (PERCENTUAL_ICMS / 100)
     else
       lIcmsProprio := VALOR_AQUISICAO * (PERCENTUAL_ICMS / 100);
    end;
  end
  else
    lIcmsProprio := 0;

  if PERCENTUAL_MVA > 0 then begin
   if TIPO_FRETE = 'CIF' then
     lBase  := lBase + lValorFrete;
    lBaseST := lBase + (PERCENTUAL_MVA / 100 * lBase);
    lIcmsST := lBaseST * (PERCENTUAL_ICMS_ST / 100);
  end
  else begin
    lBaseST    := 0;
    lIcmsST    := 0;
    lValorST   := 0;
  end;

  if lIcmsST > 0 then begin
    lValorST := lIcmsST - lIcmsProprio
  end
  else begin
    lValorST := 0;
    lCreditoICMS := lIcmsProprio;
  end;

  Result.CustoBruto    := lCustoIPI + lValorST + lValorFrete;
  Result.CustoLiquido  := VALOR_AQUISICAO;
  Result.CustoCompra   := ( lCustoIPI + lValorST + lValorFrete ) - (lValorCreditoPisCofins+lCreditoICMS);
end;

end.
