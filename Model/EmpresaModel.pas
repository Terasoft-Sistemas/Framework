unit EmpresaModel;

interface

uses
  System.SysUtils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TEmpresaModel = class;

  ITEmpresaModel = IObject<TEmpresaModel>;

  TEmpresaModel = class
  private
    [weak] mySelf: ITEmpresaModel;
    vIConexao : IConexao;
    FINSCRICAO_MUNICIPAL: Variant;
    FCNPJ: Variant;
    FFANTASIA: Variant;
    FEMAIL: Variant;
    FBAIRRO: Variant;
    FRAZAO_SOCIAL: Variant;
    FUF: Variant;
    FCONTRIBUINTE_IPI: Variant;
    FDATA_CADASTRO: Variant;
    FCODIGO: Variant;
    FCODIGO_MUNUCIPIO: Variant;
    FCEP: Variant;
    FINSCRICAO_ESTADUAL: Variant;
    FID: Variant;
    FNUMERO: Variant;
    FSYSTIME: Variant;
    FCOMPLEMENTO: Variant;
    FCONTATO: Variant;
    FREGIME_TRIBUTARIO: Variant;
    FURL: Variant;
    FCIDADE: Variant;
    FENDERECO: Variant;
    FTELEFONE: Variant;
    FJUROS_BOL: Variant;
    FLOJA: Variant;
    FLIMITE_ATRASO: Variant;
    FSTRING_CONEXAO_RESERVA: Variant;
    FAVISARNEGATIVO_EMP: Variant;
    FLOGO: Variant;
    FMULTA_BOL: Variant;
    procedure SetBAIRRO(const Value: Variant);
    procedure SetCEP(const Value: Variant);
    procedure SetCIDADE(const Value: Variant);
    procedure SetCNPJ(const Value: Variant);
    procedure SetCODIGO(const Value: Variant);
    procedure SetCODIGO_MUNUCIPIO(const Value: Variant);
    procedure SetCOMPLEMENTO(const Value: Variant);
    procedure SetCONTATO(const Value: Variant);
    procedure SetCONTRIBUINTE_IPI(const Value: Variant);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetEMAIL(const Value: Variant);
    procedure SetENDERECO(const Value: Variant);
    procedure SetFANTASIA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetINSCRICAO_ESTADUAL(const Value: Variant);
    procedure SetINSCRICAO_MUNICIPAL(const Value: Variant);
    procedure SetNUMERO(const Value: Variant);
    procedure SetRAZAO_SOCIAL(const Value: Variant);
    procedure SetREGIME_TRIBUTARIO(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTELEFONE(const Value: Variant);
    procedure SetUF(const Value: Variant);
    procedure SetURL(const Value: Variant);
    procedure SetJUROS_BOL(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLIMITE_ATRASO(const Value: Variant);
    procedure SetSTRING_CONEXAO_RESERVA(const Value: Variant);
    procedure SetAVISARNEGATIVO_EMP(const Value: Variant);
    procedure SetLOGO(const Value: Variant);
    procedure SetMULTA_BOL(const Value: Variant);
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEmpresaModel;

    property ID                     :Variant read FID write SetID;
    property SYSTIME                :Variant read FSYSTIME write SetSYSTIME;
    property CODIGO                 :Variant read FCODIGO write SetCODIGO;
    property FANTASIA               :Variant read FFANTASIA write SetFANTASIA;
    property RAZAO_SOCIAL           :Variant read FRAZAO_SOCIAL write SetRAZAO_SOCIAL;
    property CNPJ                   :Variant read FCNPJ write SetCNPJ;
    property INSCRICAO_ESTADUAL     :Variant read FINSCRICAO_ESTADUAL write SetINSCRICAO_ESTADUAL;
    property INSCRICAO_MUNICIPAL    :Variant read FINSCRICAO_MUNICIPAL write SetINSCRICAO_MUNICIPAL;
    property ENDERECO               :Variant read FENDERECO write SetENDERECO;
    property BAIRRO                 :Variant read FBAIRRO write SetBAIRRO;
    property CIDADE                 :Variant read FCIDADE write SetCIDADE;
    property UF                     :Variant read FUF write SetUF;
    property NUMERO                 :Variant read FNUMERO write SetNUMERO;
    property COMPLEMENTO            :Variant read FCOMPLEMENTO write SetCOMPLEMENTO;
    property CODIGO_MUNUCIPIO       :Variant read FCODIGO_MUNUCIPIO write SetCODIGO_MUNUCIPIO;
    property TELEFONE               :Variant read FTELEFONE write SetTELEFONE;
    property CONTATO                :Variant read FCONTATO write SetCONTATO;
    property EMAIL                  :Variant read FEMAIL write SetEMAIL;
    property URL                    :Variant read FURL write SetURL;
    property CEP                    :Variant read FCEP write SetCEP;
    property REGIME_TRIBUTARIO      :Variant read FREGIME_TRIBUTARIO write SetREGIME_TRIBUTARIO;
    property JUROS_BOL              :Variant read FJUROS_BOL write SetJUROS_BOL;
    property LOJA                   :Variant read FLOJA write SetLOJA;
    property LIMITE_ATRASO          :Variant read FLIMITE_ATRASO write SetLIMITE_ATRASO;
    property STRING_CONEXAO_RESERVA :Variant read FSTRING_CONEXAO_RESERVA write SetSTRING_CONEXAO_RESERVA;
    property AVISARNEGATIVO_EMP     :Variant read FAVISARNEGATIVO_EMP write SetAVISARNEGATIVO_EMP;
    property LOGO                   :Variant read FLOGO write SetLOGO;
    property MULTA_BOL              :Variant read FMULTA_BOL write SetMULTA_BOL;

    procedure Carregar;
  end;

implementation
  uses
    Terasoft.Framework.MultiConfig,
    EmpresaDao;

{ TEmpresa }

procedure TEmpresaModel.Carregar;
var
  VEmpresaDao: ITEmpresaDao;
begin
  VEmpresaDao := TEmpresaDao.getNewIface(vIConexao);
  try
    VEmpresaDao.objeto.carregar(mySelf);
  finally
    VEmpresaDao := nil;
  end;
end;

constructor TEmpresaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TEmpresaModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

class function TEmpresaModel.getNewIface(pIConexao: IConexao): ITEmpresaModel;
begin
  Result := TImplObjetoOwner<TEmpresaModel>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TEmpresaModel.SetAVISARNEGATIVO_EMP(const Value: Variant);
begin
  FAVISARNEGATIVO_EMP := Value;
end;

procedure TEmpresaModel.SetBAIRRO(const Value: Variant);
begin
  FBAIRRO := Value;
end;
procedure TEmpresaModel.SetCEP(const Value: Variant);
begin
  FCEP := Value;
end;
procedure TEmpresaModel.SetCIDADE(const Value: Variant);
begin
  FCIDADE := Value;
end;
procedure TEmpresaModel.SetCNPJ(const Value: Variant);
begin
  FCNPJ := Value;
end;
procedure TEmpresaModel.SetCODIGO(const Value: Variant);
begin
  FCODIGO := Value;
end;
procedure TEmpresaModel.SetCODIGO_MUNUCIPIO(const Value: Variant);
begin
  FCODIGO_MUNUCIPIO := Value;
end;
procedure TEmpresaModel.SetCOMPLEMENTO(const Value: Variant);
begin
  FCOMPLEMENTO := Value;
end;
procedure TEmpresaModel.SetCONTATO(const Value: Variant);
begin
  FCONTATO := Value;
end;
procedure TEmpresaModel.SetCONTRIBUINTE_IPI(const Value: Variant);
begin
  FCONTRIBUINTE_IPI := Value;
end;
procedure TEmpresaModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;
procedure TEmpresaModel.SetEMAIL(const Value: Variant);
begin
  FEMAIL := Value;
end;
procedure TEmpresaModel.SetENDERECO(const Value: Variant);
begin
  FENDERECO := Value;
end;
procedure TEmpresaModel.SetFANTASIA(const Value: Variant);
begin
  FFANTASIA := Value;
end;
procedure TEmpresaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;
procedure TEmpresaModel.SetINSCRICAO_ESTADUAL(const Value: Variant);
begin
  FINSCRICAO_ESTADUAL := Value;
end;
procedure TEmpresaModel.SetINSCRICAO_MUNICIPAL(const Value: Variant);
begin
  FINSCRICAO_MUNICIPAL := Value;
end;
procedure TEmpresaModel.SetJUROS_BOL(const Value: Variant);
begin
  FJUROS_BOL := Value;
end;
procedure TEmpresaModel.SetLIMITE_ATRASO(const Value: Variant);
begin
  FLIMITE_ATRASO := Value;
end;

procedure TEmpresaModel.SetLOGO(const Value: Variant);
begin
  FLOGO := Value;
end;

procedure TEmpresaModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;
procedure TEmpresaModel.SetMULTA_BOL(const Value: Variant);
begin
  FMULTA_BOL := Value;
end;

procedure TEmpresaModel.SetNUMERO(const Value: Variant);
begin
  FNUMERO := Value;
end;
procedure TEmpresaModel.SetRAZAO_SOCIAL(const Value: Variant);
begin
  FRAZAO_SOCIAL := Value;
end;
procedure TEmpresaModel.SetREGIME_TRIBUTARIO(const Value: Variant);
begin
  FREGIME_TRIBUTARIO := Value;
end;

procedure TEmpresaModel.SetSTRING_CONEXAO_RESERVA(const Value: Variant);
  var
    ini: IMultiConfig;
begin
  ini := instanciaMultiConfig;
  FSTRING_CONEXAO_RESERVA := readStringCripto(ini,'reserva', 'conexao', value);
  FSTRING_CONEXAO_RESERVA := ini.traduzir(FSTRING_CONEXAO_RESERVA,'$(',')');
  //Exemplo de configuração...
  //FSTRING_CONEXAO_RESERVA           := '$(local.database.servidor)/$(local.database.porta):c:\XYZ.FDB';
end;

procedure TEmpresaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;
procedure TEmpresaModel.SetTELEFONE(const Value: Variant);
begin
  FTELEFONE := Value;
end;
procedure TEmpresaModel.SetUF(const Value: Variant);
begin
  FUF := Value;
end;
procedure TEmpresaModel.SetURL(const Value: Variant);
begin
  FURL := Value;
end;
end.
