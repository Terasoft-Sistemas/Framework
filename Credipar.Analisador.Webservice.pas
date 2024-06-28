// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://homologacao.credipar.com.br/wscredipar/wscredipar.asmx?WSDL
//  >Import : https://homologacao.credipar.com.br/wscredipar/wscredipar.asmx?WSDL>0
//  >Import : https://homologacao.credipar.com.br/wscredipar/wscredipar.asmx?WSDL>1
// Encoding : utf-8
// Version  : 1.0
// (19/06/2024 17:01:13 - - $Rev: 56641 $)
// ************************************************************************ //

unit Credipar.Analisador.Webservice;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,Terasoft.Framework.Texto;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_UNQL = $0008;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]

  stDadosCliente       = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetorno2           = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetorno            = class;                 { "http://tempuri.org/"[GblElm] }
  stRetornoStatus2     = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoStatus      = class;                 { "http://tempuri.org/"[GblElm] }
  stRetornoCancelamento2 = class;               { "http://tempuri.org/"[GblCplx] }
  stRetornoCancelamento = class;                { "http://tempuri.org/"[GblElm] }
  stRetornoSimulacao2  = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoSimulacao   = class;                 { "http://tempuri.org/"[GblElm] }
  stRetornoMensagem2   = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoMensagem    = class;                 { "http://tempuri.org/"[GblElm] }
  stProposta           = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoStatusProposta2 = class;             { "http://tempuri.org/"[GblCplx] }
  stRetornoStatusProposta = class;              { "http://tempuri.org/"[GblElm] }
  stRetornoProposta    = class;                 { "http://tempuri.org/"[GblCplx] }



  // ************************************************************************ //
  // XML       : stDadosCliente, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stDadosCliente = class(TRemotable)
  private
    FID: string;
    FID_Specified: boolean;
    FCPF: string;
    FCPF_Specified: boolean;
    FNomeCliente: string;
    FNomeCliente_Specified: boolean;
    FDtNascimento: string;
    FDtNascimento_Specified: boolean;
    FSexo: string;
    FSexo_Specified: boolean;
    FTipoDocIdentificacao: string;
    FTipoDocIdentificacao_Specified: boolean;
    FDocIdentificacao: string;
    FDocIdentificacao_Specified: boolean;
    FUFEmissorDocIdentificacao: string;
    FUFEmissorDocIdentificacao_Specified: boolean;
    FDataEmissaoDocIdentificacao: string;
    FDataEmissaoDocIdentificacao_Specified: boolean;
    FCodEstadoCivil: string;
    FCodEstadoCivil_Specified: boolean;
    FNacionalidade: string;
    FNacionalidade_Specified: boolean;
    FMae: string;
    FMae_Specified: boolean;
    FPai: string;
    FPai_Specified: boolean;
    FCidadeNaturalidade: string;
    FCidadeNaturalidade_Specified: boolean;
    FUFNaturalidade: string;
    FUFNaturalidade_Specified: boolean;
    FNumBeneficio: string;
    FNumBeneficio_Specified: boolean;
    FCodOcupacao: string;
    FCodOcupacao_Specified: boolean;
    FDDDCelular: string;
    FDDDCelular_Specified: boolean;
    FFoneCelular: string;
    FFoneCelular_Specified: boolean;
    FDDDCelular2: string;
    FDDDCelular2_Specified: boolean;
    FFoneCelular2: string;
    FFoneCelular2_Specified: boolean;
    FEmail: string;
    FEmail_Specified: boolean;
    FGrauInstrucao: string;
    FGrauInstrucao_Specified: boolean;
    FEnderecoRes: string;
    FEnderecoRes_Specified: boolean;
    FNumeroRes: string;
    FNumeroRes_Specified: boolean;
    FComplementoRes: string;
    FComplementoRes_Specified: boolean;
    FBairroRes: string;
    FBairroRes_Specified: boolean;
    FCidadeRes: string;
    FCidadeRes_Specified: boolean;
    FUFRes: string;
    FUFRes_Specified: boolean;
    FCEPRes: string;
    FCEPRes_Specified: boolean;
    FTempoRes: string;
    FTempoRes_Specified: boolean;
    FTipoResidencia: string;
    FTipoResidencia_Specified: boolean;
    FDDDRes: string;
    FDDDRes_Specified: boolean;
    FTelefoneRes: string;
    FTelefoneRes_Specified: boolean;
    FEmpresa: string;
    FEmpresa_Specified: boolean;
    FCargo: string;
    FCargo_Specified: boolean;
    FDataAdmissao: string;
    FDataAdmissao_Specified: boolean;
    FEnderecoEmp: string;
    FEnderecoEmp_Specified: boolean;
    FNumeroEmp: string;
    FNumeroEmp_Specified: boolean;
    FComplementoEmp: string;
    FComplementoEmp_Specified: boolean;
    FBairroEmp: string;
    FBairroEmp_Specified: boolean;
    FCidadeEmp: string;
    FCidadeEmp_Specified: boolean;
    FUFEmp: string;
    FUFEmp_Specified: boolean;
    FCEPEmp: string;
    FCEPEmp_Specified: boolean;
    FDDDEmp: string;
    FDDDEmp_Specified: boolean;
    FTelefoneEmp: string;
    FTelefoneEmp_Specified: boolean;
    FRamalEmp: string;
    FRamalEmp_Specified: boolean;
    FDDDEmp2: string;
    FDDDEmp2_Specified: boolean;
    FTelefoneEmp2: string;
    FTelefoneEmp2_Specified: boolean;
    FRamalEmp2: string;
    FRamalEmp2_Specified: boolean;
    FOutrasRendas: string;
    FOutrasRendas_Specified: boolean;
    FDDDOutrasRendas: string;
    FDDDOutrasRendas_Specified: boolean;
    FFoneOutrasRendas: string;
    FFoneOutrasRendas_Specified: boolean;
    FRamalOutrasRendas: string;
    FRamalOutrasRendas_Specified: boolean;
    FTipoFuncPublico: string;
    FTipoFuncPublico_Specified: boolean;
    FFontePagadoraBeneficio: string;
    FFontePagadoraBeneficio_Specified: boolean;
    FEspecieBeneficio: string;
    FEspecieBeneficio_Specified: boolean;
    FNumRegConselhoClasse: string;
    FNumRegConselhoClasse_Specified: boolean;
    FUFRegConselhoClasse: string;
    FUFRegConselhoClasse_Specified: boolean;
    FCNPJProprietario: string;
    FCNPJProprietario_Specified: boolean;
    FNomeConj: string;
    FNomeConj_Specified: boolean;
    FCPFConj: string;
    FCPFConj_Specified: boolean;
    FNascimentoConj: string;
    FNascimentoConj_Specified: boolean;
    FMaeConj: string;
    FMaeConj_Specified: boolean;
    FTipoDocIdentificacaoConj: string;
    FTipoDocIdentificacaoConj_Specified: boolean;
    FDocIdentificacaoConj: string;
    FDocIdentificacaoConj_Specified: boolean;
    FUFEmissorDocIdentificacaoConj: string;
    FUFEmissorDocIdentificacaoConj_Specified: boolean;
    FDataEmissaoDocIdentificacaoConj: string;
    FDataEmissaoDocIdentificacaoConj_Specified: boolean;
    FEmpresaConj: string;
    FEmpresaConj_Specified: boolean;
    FCargoConj: string;
    FCargoConj_Specified: boolean;
    FDataAdmissaoConj: string;
    FDataAdmissaoConj_Specified: boolean;
    FDDDConj: string;
    FDDDConj_Specified: boolean;
    FTelefoneConj: string;
    FTelefoneConj_Specified: boolean;
    FRamalConj: string;
    FRamalConj_Specified: boolean;
    FDDDConj2: string;
    FDDDConj2_Specified: boolean;
    FTelefoneConj2: string;
    FTelefoneConj2_Specified: boolean;
    FRamalConj2: string;
    FRamalConj2_Specified: boolean;
    FNumBeneficioConj: string;
    FNumBeneficioConj_Specified: boolean;
    FOutrasRendasConj: string;
    FOutrasRendasConj_Specified: boolean;
    FDDDOutrasRendasConj: string;
    FDDDOutrasRendasConj_Specified: boolean;
    FFoneOutrasRendasConj: string;
    FFoneOutrasRendasConj_Specified: boolean;
    FRamalOutrasRendasConj: string;
    FRamalOutrasRendasConj_Specified: boolean;
    FRef1Nome: string;
    FRef1Nome_Specified: boolean;
    FRef1DDD: string;
    FRef1DDD_Specified: boolean;
    FRef1Fone: string;
    FRef1Fone_Specified: boolean;
    FRef1Ramal: string;
    FRef1Ramal_Specified: boolean;
    FRef1GrauParentesco: string;
    FRef1GrauParentesco_Specified: boolean;
    FRef2Nome: string;
    FRef2Nome_Specified: boolean;
    FRef2DDD: string;
    FRef2DDD_Specified: boolean;
    FRef2Fone: string;
    FRef2Fone_Specified: boolean;
    FRef2Ramal: string;
    FRef2Ramal_Specified: boolean;
    FRef2GrauParentesco: string;
    FRef2GrauParentesco_Specified: boolean;
    FRef3Nome: string;
    FRef3Nome_Specified: boolean;
    FRef3DDD: string;
    FRef3DDD_Specified: boolean;
    FRef3Fone: string;
    FRef3Fone_Specified: boolean;
    FRef3Ramal: string;
    FRef3Ramal_Specified: boolean;
    FRef3GrauParentesco: string;
    FRef3GrauParentesco_Specified: boolean;
    FRef4Nome: string;
    FRef4Nome_Specified: boolean;
    FRef4DDD: string;
    FRef4DDD_Specified: boolean;
    FRef4Fone: string;
    FRef4Fone_Specified: boolean;
    FRef4Ramal: string;
    FRef4Ramal_Specified: boolean;
    FRef4GrauParentesco: string;
    FRef4GrauParentesco_Specified: boolean;
    FRefComercialDesc: string;
    FRefComercialDesc_Specified: boolean;
    FSalario: Double;
    FSalarioConj: Double;
    FVlrOutrasRendas: Double;
    FVlrOutrasRendasConj: Double;
    FCodBanco: string;
    FCodBanco_Specified: boolean;
    FAgencia: string;
    FAgencia_Specified: boolean;
    FConta: string;
    FConta_Specified: boolean;
    FContador: string;
    FContador_Specified: boolean;
    FDDDContador: string;
    FDDDContador_Specified: boolean;
    FFoneContador: string;
    FFoneContador_Specified: boolean;
    FRamalContador: string;
    FRamalContador_Specified: boolean;
    procedure SetID(Index: Integer; const Astring: string);
    function  ID_Specified(Index: Integer): boolean;
    procedure SetCPF(Index: Integer; const Astring: string);
    function  CPF_Specified(Index: Integer): boolean;
    procedure SetNomeCliente(Index: Integer; const Astring: string);
    function  NomeCliente_Specified(Index: Integer): boolean;
    procedure SetDtNascimento(Index: Integer; const Astring: string);
    function  DtNascimento_Specified(Index: Integer): boolean;
    procedure SetSexo(Index: Integer; const Astring: string);
    function  Sexo_Specified(Index: Integer): boolean;
    procedure SetTipoDocIdentificacao(Index: Integer; const Astring: string);
    function  TipoDocIdentificacao_Specified(Index: Integer): boolean;
    procedure SetDocIdentificacao(Index: Integer; const Astring: string);
    function  DocIdentificacao_Specified(Index: Integer): boolean;
    procedure SetUFEmissorDocIdentificacao(Index: Integer; const Astring: string);
    function  UFEmissorDocIdentificacao_Specified(Index: Integer): boolean;
    procedure SetDataEmissaoDocIdentificacao(Index: Integer; const Astring: string);
    function  DataEmissaoDocIdentificacao_Specified(Index: Integer): boolean;
    procedure SetCodEstadoCivil(Index: Integer; const Astring: string);
    function  CodEstadoCivil_Specified(Index: Integer): boolean;
    procedure SetNacionalidade(Index: Integer; const Astring: string);
    function  Nacionalidade_Specified(Index: Integer): boolean;
    procedure SetMae(Index: Integer; const Astring: string);
    function  Mae_Specified(Index: Integer): boolean;
    procedure SetPai(Index: Integer; const Astring: string);
    function  Pai_Specified(Index: Integer): boolean;
    procedure SetCidadeNaturalidade(Index: Integer; const Astring: string);
    function  CidadeNaturalidade_Specified(Index: Integer): boolean;
    procedure SetUFNaturalidade(Index: Integer; const Astring: string);
    function  UFNaturalidade_Specified(Index: Integer): boolean;
    procedure SetNumBeneficio(Index: Integer; const Astring: string);
    function  NumBeneficio_Specified(Index: Integer): boolean;
    procedure SetCodOcupacao(Index: Integer; const Astring: string);
    function  CodOcupacao_Specified(Index: Integer): boolean;
    procedure SetDDDCelular(Index: Integer; const Astring: string);
    function  DDDCelular_Specified(Index: Integer): boolean;
    procedure SetFoneCelular(Index: Integer; const Astring: string);
    function  FoneCelular_Specified(Index: Integer): boolean;
    procedure SetDDDCelular2(Index: Integer; const Astring: string);
    function  DDDCelular2_Specified(Index: Integer): boolean;
    procedure SetFoneCelular2(Index: Integer; const Astring: string);
    function  FoneCelular2_Specified(Index: Integer): boolean;
    procedure SetEmail(Index: Integer; const Astring: string);
    function  Email_Specified(Index: Integer): boolean;
    procedure SetGrauInstrucao(Index: Integer; const Astring: string);
    function  GrauInstrucao_Specified(Index: Integer): boolean;
    procedure SetEnderecoRes(Index: Integer; const Astring: string);
    function  EnderecoRes_Specified(Index: Integer): boolean;
    procedure SetNumeroRes(Index: Integer; const Astring: string);
    function  NumeroRes_Specified(Index: Integer): boolean;
    procedure SetComplementoRes(Index: Integer; const Astring: string);
    function  ComplementoRes_Specified(Index: Integer): boolean;
    procedure SetBairroRes(Index: Integer; const Astring: string);
    function  BairroRes_Specified(Index: Integer): boolean;
    procedure SetCidadeRes(Index: Integer; const Astring: string);
    function  CidadeRes_Specified(Index: Integer): boolean;
    procedure SetUFRes(Index: Integer; const Astring: string);
    function  UFRes_Specified(Index: Integer): boolean;
    procedure SetCEPRes(Index: Integer; const Astring: string);
    function  CEPRes_Specified(Index: Integer): boolean;
    procedure SetTempoRes(Index: Integer; const Astring: string);
    function  TempoRes_Specified(Index: Integer): boolean;
    procedure SetTipoResidencia(Index: Integer; const Astring: string);
    function  TipoResidencia_Specified(Index: Integer): boolean;
    procedure SetDDDRes(Index: Integer; const Astring: string);
    function  DDDRes_Specified(Index: Integer): boolean;
    procedure SetTelefoneRes(Index: Integer; const Astring: string);
    function  TelefoneRes_Specified(Index: Integer): boolean;
    procedure SetEmpresa(Index: Integer; const Astring: string);
    function  Empresa_Specified(Index: Integer): boolean;
    procedure SetCargo(Index: Integer; const Astring: string);
    function  Cargo_Specified(Index: Integer): boolean;
    procedure SetDataAdmissao(Index: Integer; const Astring: string);
    function  DataAdmissao_Specified(Index: Integer): boolean;
    procedure SetEnderecoEmp(Index: Integer; const Astring: string);
    function  EnderecoEmp_Specified(Index: Integer): boolean;
    procedure SetNumeroEmp(Index: Integer; const Astring: string);
    function  NumeroEmp_Specified(Index: Integer): boolean;
    procedure SetComplementoEmp(Index: Integer; const Astring: string);
    function  ComplementoEmp_Specified(Index: Integer): boolean;
    procedure SetBairroEmp(Index: Integer; const Astring: string);
    function  BairroEmp_Specified(Index: Integer): boolean;
    procedure SetCidadeEmp(Index: Integer; const Astring: string);
    function  CidadeEmp_Specified(Index: Integer): boolean;
    procedure SetUFEmp(Index: Integer; const Astring: string);
    function  UFEmp_Specified(Index: Integer): boolean;
    procedure SetCEPEmp(Index: Integer; const Astring: string);
    function  CEPEmp_Specified(Index: Integer): boolean;
    procedure SetDDDEmp(Index: Integer; const Astring: string);
    function  DDDEmp_Specified(Index: Integer): boolean;
    procedure SetTelefoneEmp(Index: Integer; const Astring: string);
    function  TelefoneEmp_Specified(Index: Integer): boolean;
    procedure SetRamalEmp(Index: Integer; const Astring: string);
    function  RamalEmp_Specified(Index: Integer): boolean;
    procedure SetDDDEmp2(Index: Integer; const Astring: string);
    function  DDDEmp2_Specified(Index: Integer): boolean;
    procedure SetTelefoneEmp2(Index: Integer; const Astring: string);
    function  TelefoneEmp2_Specified(Index: Integer): boolean;
    procedure SetRamalEmp2(Index: Integer; const Astring: string);
    function  RamalEmp2_Specified(Index: Integer): boolean;
    procedure SetOutrasRendas(Index: Integer; const Astring: string);
    function  OutrasRendas_Specified(Index: Integer): boolean;
    procedure SetDDDOutrasRendas(Index: Integer; const Astring: string);
    function  DDDOutrasRendas_Specified(Index: Integer): boolean;
    procedure SetFoneOutrasRendas(Index: Integer; const Astring: string);
    function  FoneOutrasRendas_Specified(Index: Integer): boolean;
    procedure SetRamalOutrasRendas(Index: Integer; const Astring: string);
    function  RamalOutrasRendas_Specified(Index: Integer): boolean;
    procedure SetTipoFuncPublico(Index: Integer; const Astring: string);
    function  TipoFuncPublico_Specified(Index: Integer): boolean;
    procedure SetFontePagadoraBeneficio(Index: Integer; const Astring: string);
    function  FontePagadoraBeneficio_Specified(Index: Integer): boolean;
    procedure SetEspecieBeneficio(Index: Integer; const Astring: string);
    function  EspecieBeneficio_Specified(Index: Integer): boolean;
    procedure SetNumRegConselhoClasse(Index: Integer; const Astring: string);
    function  NumRegConselhoClasse_Specified(Index: Integer): boolean;
    procedure SetUFRegConselhoClasse(Index: Integer; const Astring: string);
    function  UFRegConselhoClasse_Specified(Index: Integer): boolean;
    procedure SetCNPJProprietario(Index: Integer; const Astring: string);
    function  CNPJProprietario_Specified(Index: Integer): boolean;
    procedure SetNomeConj(Index: Integer; const Astring: string);
    function  NomeConj_Specified(Index: Integer): boolean;
    procedure SetCPFConj(Index: Integer; const Astring: string);
    function  CPFConj_Specified(Index: Integer): boolean;
    procedure SetNascimentoConj(Index: Integer; const Astring: string);
    function  NascimentoConj_Specified(Index: Integer): boolean;
    procedure SetMaeConj(Index: Integer; const Astring: string);
    function  MaeConj_Specified(Index: Integer): boolean;
    procedure SetTipoDocIdentificacaoConj(Index: Integer; const Astring: string);
    function  TipoDocIdentificacaoConj_Specified(Index: Integer): boolean;
    procedure SetDocIdentificacaoConj(Index: Integer; const Astring: string);
    function  DocIdentificacaoConj_Specified(Index: Integer): boolean;
    procedure SetUFEmissorDocIdentificacaoConj(Index: Integer; const Astring: string);
    function  UFEmissorDocIdentificacaoConj_Specified(Index: Integer): boolean;
    procedure SetDataEmissaoDocIdentificacaoConj(Index: Integer; const Astring: string);
    function  DataEmissaoDocIdentificacaoConj_Specified(Index: Integer): boolean;
    procedure SetEmpresaConj(Index: Integer; const Astring: string);
    function  EmpresaConj_Specified(Index: Integer): boolean;
    procedure SetCargoConj(Index: Integer; const Astring: string);
    function  CargoConj_Specified(Index: Integer): boolean;
    procedure SetDataAdmissaoConj(Index: Integer; const Astring: string);
    function  DataAdmissaoConj_Specified(Index: Integer): boolean;
    procedure SetDDDConj(Index: Integer; const Astring: string);
    function  DDDConj_Specified(Index: Integer): boolean;
    procedure SetTelefoneConj(Index: Integer; const Astring: string);
    function  TelefoneConj_Specified(Index: Integer): boolean;
    procedure SetRamalConj(Index: Integer; const Astring: string);
    function  RamalConj_Specified(Index: Integer): boolean;
    procedure SetDDDConj2(Index: Integer; const Astring: string);
    function  DDDConj2_Specified(Index: Integer): boolean;
    procedure SetTelefoneConj2(Index: Integer; const Astring: string);
    function  TelefoneConj2_Specified(Index: Integer): boolean;
    procedure SetRamalConj2(Index: Integer; const Astring: string);
    function  RamalConj2_Specified(Index: Integer): boolean;
    procedure SetNumBeneficioConj(Index: Integer; const Astring: string);
    function  NumBeneficioConj_Specified(Index: Integer): boolean;
    procedure SetOutrasRendasConj(Index: Integer; const Astring: string);
    function  OutrasRendasConj_Specified(Index: Integer): boolean;
    procedure SetDDDOutrasRendasConj(Index: Integer; const Astring: string);
    function  DDDOutrasRendasConj_Specified(Index: Integer): boolean;
    procedure SetFoneOutrasRendasConj(Index: Integer; const Astring: string);
    function  FoneOutrasRendasConj_Specified(Index: Integer): boolean;
    procedure SetRamalOutrasRendasConj(Index: Integer; const Astring: string);
    function  RamalOutrasRendasConj_Specified(Index: Integer): boolean;
    procedure SetRef1Nome(Index: Integer; const Astring: string);
    function  Ref1Nome_Specified(Index: Integer): boolean;
    procedure SetRef1DDD(Index: Integer; const Astring: string);
    function  Ref1DDD_Specified(Index: Integer): boolean;
    procedure SetRef1Fone(Index: Integer; const Astring: string);
    function  Ref1Fone_Specified(Index: Integer): boolean;
    procedure SetRef1Ramal(Index: Integer; const Astring: string);
    function  Ref1Ramal_Specified(Index: Integer): boolean;
    procedure SetRef1GrauParentesco(Index: Integer; const Astring: string);
    function  Ref1GrauParentesco_Specified(Index: Integer): boolean;
    procedure SetRef2Nome(Index: Integer; const Astring: string);
    function  Ref2Nome_Specified(Index: Integer): boolean;
    procedure SetRef2DDD(Index: Integer; const Astring: string);
    function  Ref2DDD_Specified(Index: Integer): boolean;
    procedure SetRef2Fone(Index: Integer; const Astring: string);
    function  Ref2Fone_Specified(Index: Integer): boolean;
    procedure SetRef2Ramal(Index: Integer; const Astring: string);
    function  Ref2Ramal_Specified(Index: Integer): boolean;
    procedure SetRef2GrauParentesco(Index: Integer; const Astring: string);
    function  Ref2GrauParentesco_Specified(Index: Integer): boolean;
    procedure SetRef3Nome(Index: Integer; const Astring: string);
    function  Ref3Nome_Specified(Index: Integer): boolean;
    procedure SetRef3DDD(Index: Integer; const Astring: string);
    function  Ref3DDD_Specified(Index: Integer): boolean;
    procedure SetRef3Fone(Index: Integer; const Astring: string);
    function  Ref3Fone_Specified(Index: Integer): boolean;
    procedure SetRef3Ramal(Index: Integer; const Astring: string);
    function  Ref3Ramal_Specified(Index: Integer): boolean;
    procedure SetRef3GrauParentesco(Index: Integer; const Astring: string);
    function  Ref3GrauParentesco_Specified(Index: Integer): boolean;
    procedure SetRef4Nome(Index: Integer; const Astring: string);
    function  Ref4Nome_Specified(Index: Integer): boolean;
    procedure SetRef4DDD(Index: Integer; const Astring: string);
    function  Ref4DDD_Specified(Index: Integer): boolean;
    procedure SetRef4Fone(Index: Integer; const Astring: string);
    function  Ref4Fone_Specified(Index: Integer): boolean;
    procedure SetRef4Ramal(Index: Integer; const Astring: string);
    function  Ref4Ramal_Specified(Index: Integer): boolean;
    procedure SetRef4GrauParentesco(Index: Integer; const Astring: string);
    function  Ref4GrauParentesco_Specified(Index: Integer): boolean;
    procedure SetRefComercialDesc(Index: Integer; const Astring: string);
    function  RefComercialDesc_Specified(Index: Integer): boolean;
    procedure SetCodBanco(Index: Integer; const Astring: string);
    function  CodBanco_Specified(Index: Integer): boolean;
    procedure SetAgencia(Index: Integer; const Astring: string);
    function  Agencia_Specified(Index: Integer): boolean;
    procedure SetConta(Index: Integer; const Astring: string);
    function  Conta_Specified(Index: Integer): boolean;
    procedure SetContador(Index: Integer; const Astring: string);
    function  Contador_Specified(Index: Integer): boolean;
    procedure SetDDDContador(Index: Integer; const Astring: string);
    function  DDDContador_Specified(Index: Integer): boolean;
    procedure SetFoneContador(Index: Integer; const Astring: string);
    function  FoneContador_Specified(Index: Integer): boolean;
    procedure SetRamalContador(Index: Integer; const Astring: string);
    function  RamalContador_Specified(Index: Integer): boolean;
  public
    function critica(pResultado: IResultadoOperacao): boolean;
  published
    property ID:                              string  Index (IS_OPTN) read FID write SetID stored ID_Specified;
    property CPF:                             string  Index (IS_OPTN) read FCPF write SetCPF stored CPF_Specified;
    property NomeCliente:                     string  Index (IS_OPTN) read FNomeCliente write SetNomeCliente stored NomeCliente_Specified;
    property DtNascimento:                    string  Index (IS_OPTN) read FDtNascimento write SetDtNascimento stored DtNascimento_Specified;
    property Sexo:                            string  Index (IS_OPTN) read FSexo write SetSexo stored Sexo_Specified;
    property TipoDocIdentificacao:            string  Index (IS_OPTN) read FTipoDocIdentificacao write SetTipoDocIdentificacao stored TipoDocIdentificacao_Specified;
    property DocIdentificacao:                string  Index (IS_OPTN) read FDocIdentificacao write SetDocIdentificacao stored DocIdentificacao_Specified;
    property UFEmissorDocIdentificacao:       string  Index (IS_OPTN) read FUFEmissorDocIdentificacao write SetUFEmissorDocIdentificacao stored UFEmissorDocIdentificacao_Specified;
    property DataEmissaoDocIdentificacao:     string  Index (IS_OPTN) read FDataEmissaoDocIdentificacao write SetDataEmissaoDocIdentificacao stored DataEmissaoDocIdentificacao_Specified;
    property CodEstadoCivil:                  string  Index (IS_OPTN) read FCodEstadoCivil write SetCodEstadoCivil stored CodEstadoCivil_Specified;
    property Nacionalidade:                   string  Index (IS_OPTN) read FNacionalidade write SetNacionalidade stored Nacionalidade_Specified;
    property Mae:                             string  Index (IS_OPTN) read FMae write SetMae stored Mae_Specified;
    property Pai:                             string  Index (IS_OPTN) read FPai write SetPai stored Pai_Specified;
    property CidadeNaturalidade:              string  Index (IS_OPTN) read FCidadeNaturalidade write SetCidadeNaturalidade stored CidadeNaturalidade_Specified;
    property UFNaturalidade:                  string  Index (IS_OPTN) read FUFNaturalidade write SetUFNaturalidade stored UFNaturalidade_Specified;
    property NumBeneficio:                    string  Index (IS_OPTN) read FNumBeneficio write SetNumBeneficio stored NumBeneficio_Specified;
    property CodOcupacao:                     string  Index (IS_OPTN) read FCodOcupacao write SetCodOcupacao stored CodOcupacao_Specified;
    property DDDCelular:                      string  Index (IS_OPTN) read FDDDCelular write SetDDDCelular stored DDDCelular_Specified;
    property FoneCelular:                     string  Index (IS_OPTN) read FFoneCelular write SetFoneCelular stored FoneCelular_Specified;
    property DDDCelular2:                     string  Index (IS_OPTN) read FDDDCelular2 write SetDDDCelular2 stored DDDCelular2_Specified;
    property FoneCelular2:                    string  Index (IS_OPTN) read FFoneCelular2 write SetFoneCelular2 stored FoneCelular2_Specified;
    property Email:                           string  Index (IS_OPTN) read FEmail write SetEmail stored Email_Specified;
    property GrauInstrucao:                   string  Index (IS_OPTN) read FGrauInstrucao write SetGrauInstrucao stored GrauInstrucao_Specified;
    property EnderecoRes:                     string  Index (IS_OPTN) read FEnderecoRes write SetEnderecoRes stored EnderecoRes_Specified;
    property NumeroRes:                       string  Index (IS_OPTN) read FNumeroRes write SetNumeroRes stored NumeroRes_Specified;
    property ComplementoRes:                  string  Index (IS_OPTN) read FComplementoRes write SetComplementoRes stored ComplementoRes_Specified;
    property BairroRes:                       string  Index (IS_OPTN) read FBairroRes write SetBairroRes stored BairroRes_Specified;
    property CidadeRes:                       string  Index (IS_OPTN) read FCidadeRes write SetCidadeRes stored CidadeRes_Specified;
    property UFRes:                           string  Index (IS_OPTN) read FUFRes write SetUFRes stored UFRes_Specified;
    property CEPRes:                          string  Index (IS_OPTN) read FCEPRes write SetCEPRes stored CEPRes_Specified;
    property TempoRes:                        string  Index (IS_OPTN) read FTempoRes write SetTempoRes stored TempoRes_Specified;
    property TipoResidencia:                  string  Index (IS_OPTN) read FTipoResidencia write SetTipoResidencia stored TipoResidencia_Specified;
    property DDDRes:                          string  Index (IS_OPTN) read FDDDRes write SetDDDRes stored DDDRes_Specified;
    property TelefoneRes:                     string  Index (IS_OPTN) read FTelefoneRes write SetTelefoneRes stored TelefoneRes_Specified;
    property Empresa:                         string  Index (IS_OPTN) read FEmpresa write SetEmpresa stored Empresa_Specified;
    property Cargo:                           string  Index (IS_OPTN) read FCargo write SetCargo stored Cargo_Specified;
    property DataAdmissao:                    string  Index (IS_OPTN) read FDataAdmissao write SetDataAdmissao stored DataAdmissao_Specified;
    property EnderecoEmp:                     string  Index (IS_OPTN) read FEnderecoEmp write SetEnderecoEmp stored EnderecoEmp_Specified;
    property NumeroEmp:                       string  Index (IS_OPTN) read FNumeroEmp write SetNumeroEmp stored NumeroEmp_Specified;
    property ComplementoEmp:                  string  Index (IS_OPTN) read FComplementoEmp write SetComplementoEmp stored ComplementoEmp_Specified;
    property BairroEmp:                       string  Index (IS_OPTN) read FBairroEmp write SetBairroEmp stored BairroEmp_Specified;
    property CidadeEmp:                       string  Index (IS_OPTN) read FCidadeEmp write SetCidadeEmp stored CidadeEmp_Specified;
    property UFEmp:                           string  Index (IS_OPTN) read FUFEmp write SetUFEmp stored UFEmp_Specified;
    property CEPEmp:                          string  Index (IS_OPTN) read FCEPEmp write SetCEPEmp stored CEPEmp_Specified;
    property DDDEmp:                          string  Index (IS_OPTN) read FDDDEmp write SetDDDEmp stored DDDEmp_Specified;
    property TelefoneEmp:                     string  Index (IS_OPTN) read FTelefoneEmp write SetTelefoneEmp stored TelefoneEmp_Specified;
    property RamalEmp:                        string  Index (IS_OPTN) read FRamalEmp write SetRamalEmp stored RamalEmp_Specified;
    property DDDEmp2:                         string  Index (IS_OPTN) read FDDDEmp2 write SetDDDEmp2 stored DDDEmp2_Specified;
    property TelefoneEmp2:                    string  Index (IS_OPTN) read FTelefoneEmp2 write SetTelefoneEmp2 stored TelefoneEmp2_Specified;
    property RamalEmp2:                       string  Index (IS_OPTN) read FRamalEmp2 write SetRamalEmp2 stored RamalEmp2_Specified;
    property OutrasRendas:                    string  Index (IS_OPTN) read FOutrasRendas write SetOutrasRendas stored OutrasRendas_Specified;
    property DDDOutrasRendas:                 string  Index (IS_OPTN) read FDDDOutrasRendas write SetDDDOutrasRendas stored DDDOutrasRendas_Specified;
    property FoneOutrasRendas:                string  Index (IS_OPTN) read FFoneOutrasRendas write SetFoneOutrasRendas stored FoneOutrasRendas_Specified;
    property RamalOutrasRendas:               string  Index (IS_OPTN) read FRamalOutrasRendas write SetRamalOutrasRendas stored RamalOutrasRendas_Specified;
    property TipoFuncPublico:                 string  Index (IS_OPTN) read FTipoFuncPublico write SetTipoFuncPublico stored TipoFuncPublico_Specified;
    property FontePagadoraBeneficio:          string  Index (IS_OPTN) read FFontePagadoraBeneficio write SetFontePagadoraBeneficio stored FontePagadoraBeneficio_Specified;
    property EspecieBeneficio:                string  Index (IS_OPTN) read FEspecieBeneficio write SetEspecieBeneficio stored EspecieBeneficio_Specified;
    property NumRegConselhoClasse:            string  Index (IS_OPTN) read FNumRegConselhoClasse write SetNumRegConselhoClasse stored NumRegConselhoClasse_Specified;
    property UFRegConselhoClasse:             string  Index (IS_OPTN) read FUFRegConselhoClasse write SetUFRegConselhoClasse stored UFRegConselhoClasse_Specified;
    property CNPJProprietario:                string  Index (IS_OPTN) read FCNPJProprietario write SetCNPJProprietario stored CNPJProprietario_Specified;
    property NomeConj:                        string  Index (IS_OPTN) read FNomeConj write SetNomeConj stored NomeConj_Specified;
    property CPFConj:                         string  Index (IS_OPTN) read FCPFConj write SetCPFConj stored CPFConj_Specified;
    property NascimentoConj:                  string  Index (IS_OPTN) read FNascimentoConj write SetNascimentoConj stored NascimentoConj_Specified;
    property MaeConj:                         string  Index (IS_OPTN) read FMaeConj write SetMaeConj stored MaeConj_Specified;
    property TipoDocIdentificacaoConj:        string  Index (IS_OPTN) read FTipoDocIdentificacaoConj write SetTipoDocIdentificacaoConj stored TipoDocIdentificacaoConj_Specified;
    property DocIdentificacaoConj:            string  Index (IS_OPTN) read FDocIdentificacaoConj write SetDocIdentificacaoConj stored DocIdentificacaoConj_Specified;
    property UFEmissorDocIdentificacaoConj:   string  Index (IS_OPTN) read FUFEmissorDocIdentificacaoConj write SetUFEmissorDocIdentificacaoConj stored UFEmissorDocIdentificacaoConj_Specified;
    property DataEmissaoDocIdentificacaoConj: string  Index (IS_OPTN) read FDataEmissaoDocIdentificacaoConj write SetDataEmissaoDocIdentificacaoConj stored DataEmissaoDocIdentificacaoConj_Specified;
    property EmpresaConj:                     string  Index (IS_OPTN) read FEmpresaConj write SetEmpresaConj stored EmpresaConj_Specified;
    property CargoConj:                       string  Index (IS_OPTN) read FCargoConj write SetCargoConj stored CargoConj_Specified;
    property DataAdmissaoConj:                string  Index (IS_OPTN) read FDataAdmissaoConj write SetDataAdmissaoConj stored DataAdmissaoConj_Specified;
    property DDDConj:                         string  Index (IS_OPTN) read FDDDConj write SetDDDConj stored DDDConj_Specified;
    property TelefoneConj:                    string  Index (IS_OPTN) read FTelefoneConj write SetTelefoneConj stored TelefoneConj_Specified;
    property RamalConj:                       string  Index (IS_OPTN) read FRamalConj write SetRamalConj stored RamalConj_Specified;
    property DDDConj2:                        string  Index (IS_OPTN) read FDDDConj2 write SetDDDConj2 stored DDDConj2_Specified;
    property TelefoneConj2:                   string  Index (IS_OPTN) read FTelefoneConj2 write SetTelefoneConj2 stored TelefoneConj2_Specified;
    property RamalConj2:                      string  Index (IS_OPTN) read FRamalConj2 write SetRamalConj2 stored RamalConj2_Specified;
    property NumBeneficioConj:                string  Index (IS_OPTN) read FNumBeneficioConj write SetNumBeneficioConj stored NumBeneficioConj_Specified;
    property OutrasRendasConj:                string  Index (IS_OPTN) read FOutrasRendasConj write SetOutrasRendasConj stored OutrasRendasConj_Specified;
    property DDDOutrasRendasConj:             string  Index (IS_OPTN) read FDDDOutrasRendasConj write SetDDDOutrasRendasConj stored DDDOutrasRendasConj_Specified;
    property FoneOutrasRendasConj:            string  Index (IS_OPTN) read FFoneOutrasRendasConj write SetFoneOutrasRendasConj stored FoneOutrasRendasConj_Specified;
    property RamalOutrasRendasConj:           string  Index (IS_OPTN) read FRamalOutrasRendasConj write SetRamalOutrasRendasConj stored RamalOutrasRendasConj_Specified;
    property Ref1Nome:                        string  Index (IS_OPTN) read FRef1Nome write SetRef1Nome stored Ref1Nome_Specified;
    property Ref1DDD:                         string  Index (IS_OPTN) read FRef1DDD write SetRef1DDD stored Ref1DDD_Specified;
    property Ref1Fone:                        string  Index (IS_OPTN) read FRef1Fone write SetRef1Fone stored Ref1Fone_Specified;
    property Ref1Ramal:                       string  Index (IS_OPTN) read FRef1Ramal write SetRef1Ramal stored Ref1Ramal_Specified;
    property Ref1GrauParentesco:              string  Index (IS_OPTN) read FRef1GrauParentesco write SetRef1GrauParentesco stored Ref1GrauParentesco_Specified;
    property Ref2Nome:                        string  Index (IS_OPTN) read FRef2Nome write SetRef2Nome stored Ref2Nome_Specified;
    property Ref2DDD:                         string  Index (IS_OPTN) read FRef2DDD write SetRef2DDD stored Ref2DDD_Specified;
    property Ref2Fone:                        string  Index (IS_OPTN) read FRef2Fone write SetRef2Fone stored Ref2Fone_Specified;
    property Ref2Ramal:                       string  Index (IS_OPTN) read FRef2Ramal write SetRef2Ramal stored Ref2Ramal_Specified;
    property Ref2GrauParentesco:              string  Index (IS_OPTN) read FRef2GrauParentesco write SetRef2GrauParentesco stored Ref2GrauParentesco_Specified;
    property Ref3Nome:                        string  Index (IS_OPTN) read FRef3Nome write SetRef3Nome stored Ref3Nome_Specified;
    property Ref3DDD:                         string  Index (IS_OPTN) read FRef3DDD write SetRef3DDD stored Ref3DDD_Specified;
    property Ref3Fone:                        string  Index (IS_OPTN) read FRef3Fone write SetRef3Fone stored Ref3Fone_Specified;
    property Ref3Ramal:                       string  Index (IS_OPTN) read FRef3Ramal write SetRef3Ramal stored Ref3Ramal_Specified;
    property Ref3GrauParentesco:              string  Index (IS_OPTN) read FRef3GrauParentesco write SetRef3GrauParentesco stored Ref3GrauParentesco_Specified;
    property Ref4Nome:                        string  Index (IS_OPTN) read FRef4Nome write SetRef4Nome stored Ref4Nome_Specified;
    property Ref4DDD:                         string  Index (IS_OPTN) read FRef4DDD write SetRef4DDD stored Ref4DDD_Specified;
    property Ref4Fone:                        string  Index (IS_OPTN) read FRef4Fone write SetRef4Fone stored Ref4Fone_Specified;
    property Ref4Ramal:                       string  Index (IS_OPTN) read FRef4Ramal write SetRef4Ramal stored Ref4Ramal_Specified;
    property Ref4GrauParentesco:              string  Index (IS_OPTN) read FRef4GrauParentesco write SetRef4GrauParentesco stored Ref4GrauParentesco_Specified;
    property RefComercialDesc:                string  Index (IS_OPTN) read FRefComercialDesc write SetRefComercialDesc stored RefComercialDesc_Specified;
    property Salario:                         Double  read FSalario write FSalario;
    property SalarioConj:                     Double  read FSalarioConj write FSalarioConj;
    property VlrOutrasRendas:                 Double  read FVlrOutrasRendas write FVlrOutrasRendas;
    property VlrOutrasRendasConj:             Double  read FVlrOutrasRendasConj write FVlrOutrasRendasConj;
    property CodBanco:                        string  Index (IS_OPTN) read FCodBanco write SetCodBanco stored CodBanco_Specified;
    property Agencia:                         string  Index (IS_OPTN) read FAgencia write SetAgencia stored Agencia_Specified;
    property Conta:                           string  Index (IS_OPTN) read FConta write SetConta stored Conta_Specified;
    property Contador:                        string  Index (IS_OPTN) read FContador write SetContador stored Contador_Specified;
    property DDDContador:                     string  Index (IS_OPTN) read FDDDContador write SetDDDContador stored DDDContador_Specified;
    property FoneContador:                    string  Index (IS_OPTN) read FFoneContador write SetFoneContador stored FoneContador_Specified;
    property RamalContador:                   string  Index (IS_OPTN) read FRamalContador write SetRamalContador stored RamalContador_Specified;
  end;

  StringArray = array of string;                { "http://tempuri.org/AbstractTypes"[GblCplx] }
  string_         =  type string;      { "http://tempuri.org/"[GblElm] }


  // ************************************************************************ //
  // XML       : stRetorno, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetorno2 = class(TRemotable)
  private
    FBoletoCCB: TByteDynArray;
    FBoletoCCB_Specified: boolean;
    FSituacao: string;
    FSituacao_Specified: boolean;
    FMensagem: string;
    FMensagem_Specified: boolean;
    procedure SetBoletoCCB(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  BoletoCCB_Specified(Index: Integer): boolean;
    procedure SetSituacao(Index: Integer; const Astring: string);
    function  Situacao_Specified(Index: Integer): boolean;
    procedure SetMensagem(Index: Integer; const Astring: string);
    function  Mensagem_Specified(Index: Integer): boolean;
  published
    property BoletoCCB: TByteDynArray  Index (IS_OPTN) read FBoletoCCB write SetBoletoCCB stored BoletoCCB_Specified;
    property Situacao:  string         Index (IS_OPTN) read FSituacao write SetSituacao stored Situacao_Specified;
    property Mensagem:  string         Index (IS_OPTN) read FMensagem write SetMensagem stored Mensagem_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetorno, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetorno = class(stRetorno2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : stRetornoStatus, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoStatus2 = class(TRemotable)
  private
    FStatus: string;
    FStatus_Specified: boolean;
    FMensagem: string;
    FMensagem_Specified: boolean;
    FContrato: string;
    FContrato_Specified: boolean;
    FPrevisaoPgto: string;
    FPrevisaoPgto_Specified: boolean;
    FAnexoCCB: string;
    FAnexoCCB_Specified: boolean;
    procedure SetStatus(Index: Integer; const Astring: string);
    function  Status_Specified(Index: Integer): boolean;
    procedure SetMensagem(Index: Integer; const Astring: string);
    function  Mensagem_Specified(Index: Integer): boolean;
    procedure SetContrato(Index: Integer; const Astring: string);
    function  Contrato_Specified(Index: Integer): boolean;
    procedure SetPrevisaoPgto(Index: Integer; const Astring: string);
    function  PrevisaoPgto_Specified(Index: Integer): boolean;
    procedure SetAnexoCCB(Index: Integer; const Astring: string);
    function  AnexoCCB_Specified(Index: Integer): boolean;
  published
    property Status:       string  Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
    property Mensagem:     string  Index (IS_OPTN) read FMensagem write SetMensagem stored Mensagem_Specified;
    property Contrato:     string  Index (IS_OPTN) read FContrato write SetContrato stored Contrato_Specified;
    property PrevisaoPgto: string  Index (IS_OPTN) read FPrevisaoPgto write SetPrevisaoPgto stored PrevisaoPgto_Specified;
    property AnexoCCB:     string  Index (IS_OPTN) read FAnexoCCB write SetAnexoCCB stored AnexoCCB_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoStatus, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoStatus = class(stRetornoStatus2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : stRetornoCancelamento, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoCancelamento2 = class(TRemotable)
  private
    FStatus: string;
    FStatus_Specified: boolean;
    FMensagem: string;
    FMensagem_Specified: boolean;
    procedure SetStatus(Index: Integer; const Astring: string);
    function  Status_Specified(Index: Integer): boolean;
    procedure SetMensagem(Index: Integer; const Astring: string);
    function  Mensagem_Specified(Index: Integer): boolean;
  published
    property Status:   string  Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
    property Mensagem: string  Index (IS_OPTN) read FMensagem write SetMensagem stored Mensagem_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoCancelamento, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoCancelamento = class(stRetornoCancelamento2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : stRetornoSimulacao, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoSimulacao2 = class(TRemotable)
  private
    FStatus: string;
    FStatus_Specified: boolean;
    FMensagem: string;
    FMensagem_Specified: boolean;
    FValorParcela: Double;
    FCoeficiente: Double;
    FValorIOF: Double;
    FValorCet: Double;
    procedure SetStatus(Index: Integer; const Astring: string);
    function  Status_Specified(Index: Integer): boolean;
    procedure SetMensagem(Index: Integer; const Astring: string);
    function  Mensagem_Specified(Index: Integer): boolean;
  published
    property Status:       string  Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
    property Mensagem:     string  Index (IS_OPTN) read FMensagem write SetMensagem stored Mensagem_Specified;
    property ValorParcela: Double  read FValorParcela write FValorParcela;
    property Coeficiente:  Double  read FCoeficiente write FCoeficiente;
    property ValorIOF:     Double  read FValorIOF write FValorIOF;
    property ValorCet:     Double  read FValorCet write FValorCet;
  end;



  // ************************************************************************ //
  // XML       : stRetornoSimulacao, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoSimulacao = class(stRetornoSimulacao2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : stRetornoMensagem, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoMensagem2 = class(TRemotable)
  private
    FSituacao: string;
    FSituacao_Specified: boolean;
    FMensagem: string;
    FMensagem_Specified: boolean;
    FTipo: string;
    FTipo_Specified: boolean;
    procedure SetSituacao(Index: Integer; const Astring: string);
    function  Situacao_Specified(Index: Integer): boolean;
    procedure SetMensagem(Index: Integer; const Astring: string);
    function  Mensagem_Specified(Index: Integer): boolean;
    procedure SetTipo(Index: Integer; const Astring: string);
    function  Tipo_Specified(Index: Integer): boolean;
  published
    property Situacao: string  Index (IS_OPTN) read FSituacao write SetSituacao stored Situacao_Specified;
    property Mensagem: string  Index (IS_OPTN) read FMensagem write SetMensagem stored Mensagem_Specified;
    property Tipo:     string  Index (IS_OPTN) read FTipo write SetTipo stored Tipo_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoMensagem, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoMensagem = class(stRetornoMensagem2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : stProposta, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stProposta = class(TRemotable)
  private
    FcodPropostaLojista: string;
    FcodPropostaLojista_Specified: boolean;
    FcodSeguroCredipar: string;
    FcodSeguroCredipar_Specified: boolean;
    FtipoSeguro: string;
    FtipoSeguro_Specified: boolean;
    FCorrespondenteCpf: string;
    FCorrespondenteCpf_Specified: boolean;
    FCorrespondenteNome: string;
    FCorrespondenteNome_Specified: boolean;
    FArogoCPF: string;
    FArogoCPF_Specified: boolean;
    FArogoNome: string;
    FArogoNome_Specified: boolean;
    FArogoParentesco: string;
    FArogoParentesco_Specified: boolean;
    FmercadoriaEntrega: string;
    FmercadoriaEntrega_Specified: boolean;
    FnomeVendedor: string;
    FnomeVendedor_Specified: boolean;
    FcodigoVendedor: string;
    FcodigoVendedor_Specified: boolean;
    Fmercadoria: string;
    Fmercadoria_Specified: boolean;
    Fconversacao: string;
    Fconversacao_Specified: boolean;
    FcodLojaCred: Integer;
    FqtdParcela: Integer;
    FcodTabelaCred: Integer;
    FcodProdutoCredipar: Integer;
    FPedido: Integer;
    FvlrCompra: Double;
    FvlrEntrada: Double;
    FvlrParcela: Double;
    FdtCompra: TXSDate;
    FdtPriVcto: TXSDate;
    Fno_reserva_loja: string;
    Fno_reserva_loja_Specified: boolean;
    FclienteDiamante: string;
    FclienteDiamante_Specified: boolean;
    FplanoSic: string;
    FplanoSic_Specified: boolean;
    procedure SetcodPropostaLojista(Index: Integer; const Astring: string);
    function  codPropostaLojista_Specified(Index: Integer): boolean;
    procedure SetcodSeguroCredipar(Index: Integer; const Astring: string);
    function  codSeguroCredipar_Specified(Index: Integer): boolean;
    procedure SettipoSeguro(Index: Integer; const Astring: string);
    function  tipoSeguro_Specified(Index: Integer): boolean;
    procedure SetCorrespondenteCpf(Index: Integer; const Astring: string);
    function  CorrespondenteCpf_Specified(Index: Integer): boolean;
    procedure SetCorrespondenteNome(Index: Integer; const Astring: string);
    function  CorrespondenteNome_Specified(Index: Integer): boolean;
    procedure SetArogoCPF(Index: Integer; const Astring: string);
    function  ArogoCPF_Specified(Index: Integer): boolean;
    procedure SetArogoNome(Index: Integer; const Astring: string);
    function  ArogoNome_Specified(Index: Integer): boolean;
    procedure SetArogoParentesco(Index: Integer; const Astring: string);
    function  ArogoParentesco_Specified(Index: Integer): boolean;
    procedure SetmercadoriaEntrega(Index: Integer; const Astring: string);
    function  mercadoriaEntrega_Specified(Index: Integer): boolean;
    procedure SetnomeVendedor(Index: Integer; const Astring: string);
    function  nomeVendedor_Specified(Index: Integer): boolean;
    procedure SetcodigoVendedor(Index: Integer; const Astring: string);
    function  codigoVendedor_Specified(Index: Integer): boolean;
    procedure Setmercadoria(Index: Integer; const Astring: string);
    function  mercadoria_Specified(Index: Integer): boolean;
    procedure Setconversacao(Index: Integer; const Astring: string);
    function  conversacao_Specified(Index: Integer): boolean;
    procedure Setno_reserva_loja(Index: Integer; const Astring: string);
    function  no_reserva_loja_Specified(Index: Integer): boolean;
    procedure SetclienteDiamante(Index: Integer; const Astring: string);
    function  clienteDiamante_Specified(Index: Integer): boolean;
    procedure SetplanoSic(Index: Integer; const Astring: string);
    function  planoSic_Specified(Index: Integer): boolean;
  public
    function critica(pResultado: IResultadoOperacao): boolean;
    destructor Destroy; override;
  published
    property codPropostaLojista: string       Index (IS_OPTN) read FcodPropostaLojista write SetcodPropostaLojista stored codPropostaLojista_Specified;
    property codSeguroCredipar:  string       Index (IS_OPTN) read FcodSeguroCredipar write SetcodSeguroCredipar stored codSeguroCredipar_Specified;
    property tipoSeguro:         string       Index (IS_OPTN) read FtipoSeguro write SettipoSeguro stored tipoSeguro_Specified;
    property CorrespondenteCpf:  string       Index (IS_OPTN) read FCorrespondenteCpf write SetCorrespondenteCpf stored CorrespondenteCpf_Specified;
    property CorrespondenteNome: string       Index (IS_OPTN) read FCorrespondenteNome write SetCorrespondenteNome stored CorrespondenteNome_Specified;
    property ArogoCPF:           string       Index (IS_OPTN) read FArogoCPF write SetArogoCPF stored ArogoCPF_Specified;
    property ArogoNome:          string       Index (IS_OPTN) read FArogoNome write SetArogoNome stored ArogoNome_Specified;
    property ArogoParentesco:    string       Index (IS_OPTN) read FArogoParentesco write SetArogoParentesco stored ArogoParentesco_Specified;
    property mercadoriaEntrega:  string       Index (IS_OPTN) read FmercadoriaEntrega write SetmercadoriaEntrega stored mercadoriaEntrega_Specified;
    property nomeVendedor:       string       Index (IS_OPTN) read FnomeVendedor write SetnomeVendedor stored nomeVendedor_Specified;
    property codigoVendedor:     string       Index (IS_OPTN) read FcodigoVendedor write SetcodigoVendedor stored codigoVendedor_Specified;
    property mercadoria:         string       Index (IS_OPTN) read Fmercadoria write Setmercadoria stored mercadoria_Specified;
    property conversacao:        string       Index (IS_OPTN) read Fconversacao write Setconversacao stored conversacao_Specified;
    property codLojaCred:        Integer      read FcodLojaCred write FcodLojaCred;
    property qtdParcela:         Integer      read FqtdParcela write FqtdParcela;
    property codTabelaCred:      Integer      read FcodTabelaCred write FcodTabelaCred;
    property codProdutoCredipar: Integer      read FcodProdutoCredipar write FcodProdutoCredipar;
    property Pedido:             Integer      read FPedido write FPedido;
    property vlrCompra:          Double       read FvlrCompra write FvlrCompra;
    property vlrEntrada:         Double       read FvlrEntrada write FvlrEntrada;
    property vlrParcela:         Double       read FvlrParcela write FvlrParcela;
    property dtCompra:           TXSDate  read FdtCompra write FdtCompra;
    property dtPriVcto:          TXSDate  read FdtPriVcto write FdtPriVcto;
    property no_reserva_loja:    string       Index (IS_OPTN) read Fno_reserva_loja write Setno_reserva_loja stored no_reserva_loja_Specified;
    property clienteDiamante:    string       Index (IS_OPTN) read FclienteDiamante write SetclienteDiamante stored clienteDiamante_Specified;
    property planoSic:           string       Index (IS_OPTN) read FplanoSic write SetplanoSic stored planoSic_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoStatusProposta, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoStatusProposta2 = class(TRemotable)
  private
    FLoja: Integer;
    FProposta: string;
    FProposta_Specified: boolean;
    FStatus: string;
    FStatus_Specified: boolean;
    FContrato: Int64;
    FMensagem: string;
    FMensagem_Specified: boolean;
    FProcessamento: string;
    FProcessamento_Specified: boolean;
    procedure SetProposta(Index: Integer; const Astring: string);
    function  Proposta_Specified(Index: Integer): boolean;
    procedure SetStatus(Index: Integer; const Astring: string);
    function  Status_Specified(Index: Integer): boolean;
    procedure SetMensagem(Index: Integer; const Astring: string);
    function  Mensagem_Specified(Index: Integer): boolean;
    procedure SetProcessamento(Index: Integer; const Astring: string);
    function  Processamento_Specified(Index: Integer): boolean;
  published
    property Loja:          Integer  read FLoja write FLoja;
    property Proposta:      string   Index (IS_OPTN) read FProposta write SetProposta stored Proposta_Specified;
    property Status:        string   Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
    property Contrato:      Int64    read FContrato write FContrato;
    property Mensagem:      string   Index (IS_OPTN) read FMensagem write SetMensagem stored Mensagem_Specified;
    property Processamento: string   Index (IS_OPTN) read FProcessamento write SetProcessamento stored Processamento_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoStatusProposta, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoStatusProposta = class(stRetornoStatusProposta2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : stRetornoProposta, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoProposta = class(TRemotable)
  private
    FLoja: Integer;
    FProposta: string;
    FProposta_Specified: boolean;
    FContrato: Int64;
    FMensagem: string;
    FMensagem_Specified: boolean;
    FProcessamento: string;
    FProcessamento_Specified: boolean;
    procedure SetProposta(Index: Integer; const Astring: string);
    function  Proposta_Specified(Index: Integer): boolean;
    procedure SetMensagem(Index: Integer; const Astring: string);
    function  Mensagem_Specified(Index: Integer): boolean;
    procedure SetProcessamento(Index: Integer; const Astring: string);
    function  Processamento_Specified(Index: Integer): boolean;
  published
    property Loja:          Integer  read FLoja write FLoja;
    property Proposta:      string   Index (IS_OPTN) read FProposta write SetProposta stored Proposta_Specified;
    property Contrato:      Int64    read FContrato write FContrato;
    property Mensagem:      string   Index (IS_OPTN) read FMensagem write SetMensagem stored Mensagem_Specified;
    property Processamento: string   Index (IS_OPTN) read FProcessamento write SetProcessamento stored Processamento_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : wsCrediparSoap
  // service   : wsCredipar
  // port      : wsCrediparSoap
  // URL       : https://homologacao.credipar.com.br/wscredipar/wscredipar.asmx
  // ************************************************************************ //
  wsCrediparSoap = interface(IInvokable)
  ['{6982685B-96D4-72EE-1AB9-5A224B3BE67A}']
    function  EnviarPropostaCliente(const pessoaFisica: stDadosCliente; const proposta: stProposta; const Token: string): stRetornoProposta; stdcall;
    function  ConsultarStatusProposta(const Token: string; const Proposta: string; const Loja: Integer): stRetornoStatusProposta2; stdcall;
    function  AnexarDocumentoAnalise(const Token: string; const Proposta: string; const Loja: Integer; const ArquivoBytes: TByteDynArray; const FormatoArquivo: string; const Tipo: string
                                     ): stRetornoMensagem2; stdcall;
    function  AnexarDocumentoProcessamento(const Token: string; const Contrato: string; const Loja: Integer; const ArquivoBytes: TByteDynArray; const FormatoArquivo: string; const Tipo: string
                                           ): stRetornoMensagem2; stdcall;
    function  GerarCCBeBoleto(const Token: string; const Proposta: string; const Loja: Integer): stRetorno2; stdcall;
    function  ConsultarProcessamentoProposta(const Token: string; const Proposta: string; const Loja: Integer): stRetornoStatus2; stdcall;
    function  GerarConciliacao(const Token: string; const Lojista: string; const DtPagamento: TXSDateTime): string; stdcall;
    function  Simulacao(const Token: string; const Loja: Integer; const vlrCompra: Double; const VlrEntrada: Double; const qtdParcela: Integer; const dtPriVcto: TXSDateTime; 
                        const codProdutoCredipar: Integer; const codSeguroCredipar: Integer): stRetornoSimulacao2; stdcall;
    function  CancelarProposta(const Token: string; const Loja: Integer; const Proposta: string; const Motivo: string): stRetornoCancelamento2; stdcall;
    function  HelloWorld: string; stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // style     : ????
  // use       : ????
  // binding   : wsCrediparHttpGet
  // service   : wsCredipar
  // port      : wsCrediparHttpGet
  // ************************************************************************ //
  wsCrediparHttpGet = interface(IInvokable)
  ['{C4434618-7A0B-68CF-1C2B-66B38A86C282}']
    function  ConsultarStatusProposta(const Token: string; const Proposta: string; const Loja: string): stRetornoStatusProposta; stdcall;
    function  AnexarDocumentoAnalise(const Token: string; const Proposta: string; const Loja: string; const ArquivoBytes: StringArray; const FormatoArquivo: string; const Tipo: string
                                     ): stRetornoMensagem; stdcall;
    function  AnexarDocumentoProcessamento(const Token: string; const Contrato: string; const Loja: string; const ArquivoBytes: StringArray; const FormatoArquivo: string; const Tipo: string
                                           ): stRetornoMensagem; stdcall;
    function  GerarCCBeBoleto(const Token: string; const Proposta: string; const Loja: string): stRetorno; stdcall;
    function  ConsultarProcessamentoProposta(const Token: string; const Proposta: string; const Loja: string): stRetornoStatus; stdcall;
    function  GerarConciliacao(const Token: string; const Lojista: string; const DtPagamento: string): string_; stdcall;
    function  Simulacao(const Token: string; const Loja: string; const vlrCompra: string; const VlrEntrada: string; const qtdParcela: string; const dtPriVcto: string; 
                        const codProdutoCredipar: string; const codSeguroCredipar: string): stRetornoSimulacao; stdcall;
    function  CancelarProposta(const Token: string; const Loja: string; const Proposta: string; const Motivo: string): stRetornoCancelamento; stdcall;
    function  HelloWorld: string_; stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // style     : ????
  // use       : ????
  // binding   : wsCrediparHttpPost
  // service   : wsCredipar
  // port      : wsCrediparHttpPost
  // ************************************************************************ //
  wsCrediparHttpPost = interface(IInvokable)
  ['{C1C72ECF-24BA-6C2D-D991-1B060C2EEAC2}']
    function  ConsultarStatusProposta(const Token: string; const Proposta: string; const Loja: string): stRetornoStatusProposta; stdcall;
    function  AnexarDocumentoAnalise(const Token: string; const Proposta: string; const Loja: string; const ArquivoBytes: StringArray; const FormatoArquivo: string; const Tipo: string
                                     ): stRetornoMensagem; stdcall;
    function  AnexarDocumentoProcessamento(const Token: string; const Contrato: string; const Loja: string; const ArquivoBytes: StringArray; const FormatoArquivo: string; const Tipo: string
                                           ): stRetornoMensagem; stdcall;
    function  GerarCCBeBoleto(const Token: string; const Proposta: string; const Loja: string): stRetorno; stdcall;
    function  ConsultarProcessamentoProposta(const Token: string; const Proposta: string; const Loja: string): stRetornoStatus; stdcall;
    function  GerarConciliacao(const Token: string; const Lojista: string; const DtPagamento: string): string_; stdcall;
    function  Simulacao(const Token: string; const Loja: string; const vlrCompra: string; const VlrEntrada: string; const qtdParcela: string; const dtPriVcto: string; 
                        const codProdutoCredipar: string; const codSeguroCredipar: string): stRetornoSimulacao; stdcall;
    function  CancelarProposta(const Token: string; const Loja: string; const Proposta: string; const Motivo: string): stRetornoCancelamento; stdcall;
    function  HelloWorld: string_; stdcall;
  end;

function GetwsCrediparSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): wsCrediparSoap;
function GetwsCrediparHttpGet(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): wsCrediparHttpGet;
function GetwsCrediparHttpPost(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): wsCrediparHttpPost;


implementation
  uses
    Terasoft.Framework.FuncoesDiversas,
    SysUtils;

function GetwsCrediparSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): wsCrediparSoap;
const
  defWSDL = 'https://homologacao.credipar.com.br/wscredipar/wscredipar.asmx?WSDL';
  defURL  = 'https://homologacao.credipar.com.br/wscredipar/wscredipar.asmx';
  defSvc  = 'wsCredipar';
  defPrt  = 'wsCrediparSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as wsCrediparSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


function GetwsCrediparHttpGet(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): wsCrediparHttpGet;
const
  defWSDL = 'https://homologacao.credipar.com.br/wscredipar/wscredipar.asmx?WSDL';
  defURL  = '';
  defSvc  = 'wsCredipar';
  defPrt  = 'wsCrediparHttpGet';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as wsCrediparHttpGet);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


function GetwsCrediparHttpPost(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): wsCrediparHttpPost;
const
  defWSDL = 'https://homologacao.credipar.com.br/wscredipar/wscredipar.asmx?WSDL';
  defURL  = '';
  defSvc  = 'wsCredipar';
  defPrt  = 'wsCrediparHttpPost';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as wsCrediparHttpPost);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure stDadosCliente.SetID(Index: Integer; const Astring: string);
begin
  FID := Astring;
  FID_Specified := True;
end;

function stDadosCliente.ID_Specified(Index: Integer): boolean;
begin
  Result := FID_Specified;
end;

procedure stDadosCliente.SetCPF(Index: Integer; const Astring: string);
begin
  FCPF := Astring;
  FCPF_Specified := True;
end;

function stDadosCliente.CPF_Specified(Index: Integer): boolean;
begin
  Result := FCPF_Specified;
end;

function stDadosCliente.critica(pResultado: IResultadoOperacao): boolean;
  var
    lSave: Integer;
    i: Integer;
begin
  checkResultadoOperacao(pResultado);
  lSave := pResultado.erros;
  i := StrToIntDef(fCodOcupacao,-1);
  if( i<0) or (i>9) then
    pResultado.formataErro('stDadosCliente.critica: Código de ocupação inválido: [ %s ]', [FCodOcupacao] );
  if(stringForaArray(FCodEstadoCivil,['0','1','2'])) then
    pResultado.formataErro('stDadosCliente.critica: Código de estado civil inválido: [ %s ]', [FCodEstadoCivil] );
  if(stringForaArray(FGrauInstrucao,['1','2','3'])) then
    pResultado.formataErro('stDadosCliente.critica: Grau de insttrução: [ %s ]', [FGrauInstrucao] );
  i := StrToIntDef(FTipoDocIdentificacao,-1);
  if( i<1) or (i>7) then
    pResultado.formataErro('stDadosCliente.critica: Tipo de documento de identificação inválido: [ %s ]', [FTipoDocIdentificacao] );
  i := StrToIntDef(FTempoRes,-1);
  if( i<1) or (i>4) then
    pResultado.formataErro('stDadosCliente.critica: Tempo de residência inválido: [ %s ]', [FTempoRes] );
  Result := pResultado.erros<>lSave;
end;

procedure stDadosCliente.SetNomeCliente(Index: Integer; const Astring: string);
begin
  FNomeCliente := Astring;
  FNomeCliente_Specified := True;
end;

function stDadosCliente.NomeCliente_Specified(Index: Integer): boolean;
begin
  Result := FNomeCliente_Specified;
end;

procedure stDadosCliente.SetDtNascimento(Index: Integer; const Astring: string);
begin
  FDtNascimento := Astring;
  FDtNascimento_Specified := True;
end;

function stDadosCliente.DtNascimento_Specified(Index: Integer): boolean;
begin
  Result := FDtNascimento_Specified;
end;

procedure stDadosCliente.SetSexo(Index: Integer; const Astring: string);
begin
  FSexo := Astring;
  FSexo_Specified := True;
end;

function stDadosCliente.Sexo_Specified(Index: Integer): boolean;
begin
  Result := FSexo_Specified;
end;

procedure stDadosCliente.SetTipoDocIdentificacao(Index: Integer; const Astring: string);
begin
  FTipoDocIdentificacao := Astring;
  FTipoDocIdentificacao_Specified := True;
end;

function stDadosCliente.TipoDocIdentificacao_Specified(Index: Integer): boolean;
begin
  Result := FTipoDocIdentificacao_Specified;
end;

procedure stDadosCliente.SetDocIdentificacao(Index: Integer; const Astring: string);
begin
  FDocIdentificacao := Astring;
  FDocIdentificacao_Specified := True;
end;

function stDadosCliente.DocIdentificacao_Specified(Index: Integer): boolean;
begin
  Result := FDocIdentificacao_Specified;
end;

procedure stDadosCliente.SetUFEmissorDocIdentificacao(Index: Integer; const Astring: string);
begin
  FUFEmissorDocIdentificacao := Astring;
  FUFEmissorDocIdentificacao_Specified := True;
end;

function stDadosCliente.UFEmissorDocIdentificacao_Specified(Index: Integer): boolean;
begin
  Result := FUFEmissorDocIdentificacao_Specified;
end;

procedure stDadosCliente.SetDataEmissaoDocIdentificacao(Index: Integer; const Astring: string);
begin
  FDataEmissaoDocIdentificacao := Astring;
  FDataEmissaoDocIdentificacao_Specified := True;
end;

function stDadosCliente.DataEmissaoDocIdentificacao_Specified(Index: Integer): boolean;
begin
  Result := FDataEmissaoDocIdentificacao_Specified;
end;

procedure stDadosCliente.SetCodEstadoCivil(Index: Integer; const Astring: string);
begin
  FCodEstadoCivil := Astring;
  FCodEstadoCivil_Specified := True;
end;

function stDadosCliente.CodEstadoCivil_Specified(Index: Integer): boolean;
begin
  Result := FCodEstadoCivil_Specified;
end;

procedure stDadosCliente.SetNacionalidade(Index: Integer; const Astring: string);
begin
  FNacionalidade := Astring;
  FNacionalidade_Specified := True;
end;

function stDadosCliente.Nacionalidade_Specified(Index: Integer): boolean;
begin
  Result := FNacionalidade_Specified;
end;

procedure stDadosCliente.SetMae(Index: Integer; const Astring: string);
begin
  FMae := Astring;
  FMae_Specified := True;
end;

function stDadosCliente.Mae_Specified(Index: Integer): boolean;
begin
  Result := FMae_Specified;
end;

procedure stDadosCliente.SetPai(Index: Integer; const Astring: string);
begin
  FPai := Astring;
  FPai_Specified := True;
end;

function stDadosCliente.Pai_Specified(Index: Integer): boolean;
begin
  Result := FPai_Specified;
end;

procedure stDadosCliente.SetCidadeNaturalidade(Index: Integer; const Astring: string);
begin
  FCidadeNaturalidade := Astring;
  FCidadeNaturalidade_Specified := True;
end;

function stDadosCliente.CidadeNaturalidade_Specified(Index: Integer): boolean;
begin
  Result := FCidadeNaturalidade_Specified;
end;

procedure stDadosCliente.SetUFNaturalidade(Index: Integer; const Astring: string);
begin
  FUFNaturalidade := Astring;
  FUFNaturalidade_Specified := True;
end;

function stDadosCliente.UFNaturalidade_Specified(Index: Integer): boolean;
begin
  Result := FUFNaturalidade_Specified;
end;

procedure stDadosCliente.SetNumBeneficio(Index: Integer; const Astring: string);
begin
  FNumBeneficio := Astring;
  FNumBeneficio_Specified := True;
end;

function stDadosCliente.NumBeneficio_Specified(Index: Integer): boolean;
begin
  Result := FNumBeneficio_Specified;
end;

procedure stDadosCliente.SetCodOcupacao(Index: Integer; const Astring: string);
begin
  FCodOcupacao := Astring;
  FCodOcupacao_Specified := True;
end;

function stDadosCliente.CodOcupacao_Specified(Index: Integer): boolean;
begin
  Result := FCodOcupacao_Specified;
end;

procedure stDadosCliente.SetDDDCelular(Index: Integer; const Astring: string);
begin
  FDDDCelular := Astring;
  FDDDCelular_Specified := True;
end;

function stDadosCliente.DDDCelular_Specified(Index: Integer): boolean;
begin
  Result := FDDDCelular_Specified;
end;

procedure stDadosCliente.SetFoneCelular(Index: Integer; const Astring: string);
begin
  FFoneCelular := Astring;
  FFoneCelular_Specified := True;
end;

function stDadosCliente.FoneCelular_Specified(Index: Integer): boolean;
begin
  Result := FFoneCelular_Specified;
end;

procedure stDadosCliente.SetDDDCelular2(Index: Integer; const Astring: string);
begin
  FDDDCelular2 := Astring;
  FDDDCelular2_Specified := True;
end;

function stDadosCliente.DDDCelular2_Specified(Index: Integer): boolean;
begin
  Result := FDDDCelular2_Specified;
end;

procedure stDadosCliente.SetFoneCelular2(Index: Integer; const Astring: string);
begin
  FFoneCelular2 := Astring;
  FFoneCelular2_Specified := True;
end;

function stDadosCliente.FoneCelular2_Specified(Index: Integer): boolean;
begin
  Result := FFoneCelular2_Specified;
end;

procedure stDadosCliente.SetEmail(Index: Integer; const Astring: string);
begin
  FEmail := Astring;
  FEmail_Specified := True;
end;

function stDadosCliente.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure stDadosCliente.SetGrauInstrucao(Index: Integer; const Astring: string);
begin
  FGrauInstrucao := Astring;
  FGrauInstrucao_Specified := True;
end;

function stDadosCliente.GrauInstrucao_Specified(Index: Integer): boolean;
begin
  Result := FGrauInstrucao_Specified;
end;

procedure stDadosCliente.SetEnderecoRes(Index: Integer; const Astring: string);
begin
  FEnderecoRes := Astring;
  FEnderecoRes_Specified := True;
end;

function stDadosCliente.EnderecoRes_Specified(Index: Integer): boolean;
begin
  Result := FEnderecoRes_Specified;
end;

procedure stDadosCliente.SetNumeroRes(Index: Integer; const Astring: string);
begin
  FNumeroRes := Astring;
  FNumeroRes_Specified := True;
end;

function stDadosCliente.NumeroRes_Specified(Index: Integer): boolean;
begin
  Result := FNumeroRes_Specified;
end;

procedure stDadosCliente.SetComplementoRes(Index: Integer; const Astring: string);
begin
  FComplementoRes := Astring;
  FComplementoRes_Specified := True;
end;

function stDadosCliente.ComplementoRes_Specified(Index: Integer): boolean;
begin
  Result := FComplementoRes_Specified;
end;

procedure stDadosCliente.SetBairroRes(Index: Integer; const Astring: string);
begin
  FBairroRes := Astring;
  FBairroRes_Specified := True;
end;

function stDadosCliente.BairroRes_Specified(Index: Integer): boolean;
begin
  Result := FBairroRes_Specified;
end;

procedure stDadosCliente.SetCidadeRes(Index: Integer; const Astring: string);
begin
  FCidadeRes := Astring;
  FCidadeRes_Specified := True;
end;

function stDadosCliente.CidadeRes_Specified(Index: Integer): boolean;
begin
  Result := FCidadeRes_Specified;
end;

procedure stDadosCliente.SetUFRes(Index: Integer; const Astring: string);
begin
  FUFRes := Astring;
  FUFRes_Specified := True;
end;

function stDadosCliente.UFRes_Specified(Index: Integer): boolean;
begin
  Result := FUFRes_Specified;
end;

procedure stDadosCliente.SetCEPRes(Index: Integer; const Astring: string);
begin
  FCEPRes := Astring;
  FCEPRes_Specified := True;
end;

function stDadosCliente.CEPRes_Specified(Index: Integer): boolean;
begin
  Result := FCEPRes_Specified;
end;

procedure stDadosCliente.SetTempoRes(Index: Integer; const Astring: string);
begin
  FTempoRes := Astring;
  FTempoRes_Specified := True;
end;

function stDadosCliente.TempoRes_Specified(Index: Integer): boolean;
begin
  Result := FTempoRes_Specified;
end;

procedure stDadosCliente.SetTipoResidencia(Index: Integer; const Astring: string);
begin
  FTipoResidencia := Astring;
  FTipoResidencia_Specified := True;
end;

function stDadosCliente.TipoResidencia_Specified(Index: Integer): boolean;
begin
  Result := FTipoResidencia_Specified;
end;

procedure stDadosCliente.SetDDDRes(Index: Integer; const Astring: string);
begin
  FDDDRes := Astring;
  FDDDRes_Specified := True;
end;

function stDadosCliente.DDDRes_Specified(Index: Integer): boolean;
begin
  Result := FDDDRes_Specified;
end;

procedure stDadosCliente.SetTelefoneRes(Index: Integer; const Astring: string);
begin
  FTelefoneRes := Astring;
  FTelefoneRes_Specified := True;
end;

function stDadosCliente.TelefoneRes_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneRes_Specified;
end;

procedure stDadosCliente.SetEmpresa(Index: Integer; const Astring: string);
begin
  FEmpresa := Astring;
  FEmpresa_Specified := True;
end;

function stDadosCliente.Empresa_Specified(Index: Integer): boolean;
begin
  Result := FEmpresa_Specified;
end;

procedure stDadosCliente.SetCargo(Index: Integer; const Astring: string);
begin
  FCargo := Astring;
  FCargo_Specified := True;
end;

function stDadosCliente.Cargo_Specified(Index: Integer): boolean;
begin
  Result := FCargo_Specified;
end;

procedure stDadosCliente.SetDataAdmissao(Index: Integer; const Astring: string);
begin
  FDataAdmissao := Astring;
  FDataAdmissao_Specified := True;
end;

function stDadosCliente.DataAdmissao_Specified(Index: Integer): boolean;
begin
  Result := FDataAdmissao_Specified;
end;

procedure stDadosCliente.SetEnderecoEmp(Index: Integer; const Astring: string);
begin
  FEnderecoEmp := Astring;
  FEnderecoEmp_Specified := True;
end;

function stDadosCliente.EnderecoEmp_Specified(Index: Integer): boolean;
begin
  Result := FEnderecoEmp_Specified;
end;

procedure stDadosCliente.SetNumeroEmp(Index: Integer; const Astring: string);
begin
  FNumeroEmp := Astring;
  FNumeroEmp_Specified := True;
end;

function stDadosCliente.NumeroEmp_Specified(Index: Integer): boolean;
begin
  Result := FNumeroEmp_Specified;
end;

procedure stDadosCliente.SetComplementoEmp(Index: Integer; const Astring: string);
begin
  FComplementoEmp := Astring;
  FComplementoEmp_Specified := True;
end;

function stDadosCliente.ComplementoEmp_Specified(Index: Integer): boolean;
begin
  Result := FComplementoEmp_Specified;
end;

procedure stDadosCliente.SetBairroEmp(Index: Integer; const Astring: string);
begin
  FBairroEmp := Astring;
  FBairroEmp_Specified := True;
end;

function stDadosCliente.BairroEmp_Specified(Index: Integer): boolean;
begin
  Result := FBairroEmp_Specified;
end;

procedure stDadosCliente.SetCidadeEmp(Index: Integer; const Astring: string);
begin
  FCidadeEmp := Astring;
  FCidadeEmp_Specified := True;
end;

function stDadosCliente.CidadeEmp_Specified(Index: Integer): boolean;
begin
  Result := FCidadeEmp_Specified;
end;

procedure stDadosCliente.SetUFEmp(Index: Integer; const Astring: string);
begin
  FUFEmp := Astring;
  FUFEmp_Specified := True;
end;

function stDadosCliente.UFEmp_Specified(Index: Integer): boolean;
begin
  Result := FUFEmp_Specified;
end;

procedure stDadosCliente.SetCEPEmp(Index: Integer; const Astring: string);
begin
  FCEPEmp := Astring;
  FCEPEmp_Specified := True;
end;

function stDadosCliente.CEPEmp_Specified(Index: Integer): boolean;
begin
  Result := FCEPEmp_Specified;
end;

procedure stDadosCliente.SetDDDEmp(Index: Integer; const Astring: string);
begin
  FDDDEmp := Astring;
  FDDDEmp_Specified := True;
end;

function stDadosCliente.DDDEmp_Specified(Index: Integer): boolean;
begin
  Result := FDDDEmp_Specified;
end;

procedure stDadosCliente.SetTelefoneEmp(Index: Integer; const Astring: string);
begin
  FTelefoneEmp := Astring;
  FTelefoneEmp_Specified := True;
end;

function stDadosCliente.TelefoneEmp_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneEmp_Specified;
end;

procedure stDadosCliente.SetRamalEmp(Index: Integer; const Astring: string);
begin
  FRamalEmp := Astring;
  FRamalEmp_Specified := True;
end;

function stDadosCliente.RamalEmp_Specified(Index: Integer): boolean;
begin
  Result := FRamalEmp_Specified;
end;

procedure stDadosCliente.SetDDDEmp2(Index: Integer; const Astring: string);
begin
  FDDDEmp2 := Astring;
  FDDDEmp2_Specified := True;
end;

function stDadosCliente.DDDEmp2_Specified(Index: Integer): boolean;
begin
  Result := FDDDEmp2_Specified;
end;

procedure stDadosCliente.SetTelefoneEmp2(Index: Integer; const Astring: string);
begin
  FTelefoneEmp2 := Astring;
  FTelefoneEmp2_Specified := True;
end;

function stDadosCliente.TelefoneEmp2_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneEmp2_Specified;
end;

procedure stDadosCliente.SetRamalEmp2(Index: Integer; const Astring: string);
begin
  FRamalEmp2 := Astring;
  FRamalEmp2_Specified := True;
end;

function stDadosCliente.RamalEmp2_Specified(Index: Integer): boolean;
begin
  Result := FRamalEmp2_Specified;
end;

procedure stDadosCliente.SetOutrasRendas(Index: Integer; const Astring: string);
begin
  FOutrasRendas := Astring;
  FOutrasRendas_Specified := True;
end;

function stDadosCliente.OutrasRendas_Specified(Index: Integer): boolean;
begin
  Result := FOutrasRendas_Specified;
end;

procedure stDadosCliente.SetDDDOutrasRendas(Index: Integer; const Astring: string);
begin
  FDDDOutrasRendas := Astring;
  FDDDOutrasRendas_Specified := True;
end;

function stDadosCliente.DDDOutrasRendas_Specified(Index: Integer): boolean;
begin
  Result := FDDDOutrasRendas_Specified;
end;

procedure stDadosCliente.SetFoneOutrasRendas(Index: Integer; const Astring: string);
begin
  FFoneOutrasRendas := Astring;
  FFoneOutrasRendas_Specified := True;
end;

function stDadosCliente.FoneOutrasRendas_Specified(Index: Integer): boolean;
begin
  Result := FFoneOutrasRendas_Specified;
end;

procedure stDadosCliente.SetRamalOutrasRendas(Index: Integer; const Astring: string);
begin
  FRamalOutrasRendas := Astring;
  FRamalOutrasRendas_Specified := True;
end;

function stDadosCliente.RamalOutrasRendas_Specified(Index: Integer): boolean;
begin
  Result := FRamalOutrasRendas_Specified;
end;

procedure stDadosCliente.SetTipoFuncPublico(Index: Integer; const Astring: string);
begin
  FTipoFuncPublico := Astring;
  FTipoFuncPublico_Specified := True;
end;

function stDadosCliente.TipoFuncPublico_Specified(Index: Integer): boolean;
begin
  Result := FTipoFuncPublico_Specified;
end;

procedure stDadosCliente.SetFontePagadoraBeneficio(Index: Integer; const Astring: string);
begin
  FFontePagadoraBeneficio := Astring;
  FFontePagadoraBeneficio_Specified := True;
end;

function stDadosCliente.FontePagadoraBeneficio_Specified(Index: Integer): boolean;
begin
  Result := FFontePagadoraBeneficio_Specified;
end;

procedure stDadosCliente.SetEspecieBeneficio(Index: Integer; const Astring: string);
begin
  FEspecieBeneficio := Astring;
  FEspecieBeneficio_Specified := True;
end;

function stDadosCliente.EspecieBeneficio_Specified(Index: Integer): boolean;
begin
  Result := FEspecieBeneficio_Specified;
end;

procedure stDadosCliente.SetNumRegConselhoClasse(Index: Integer; const Astring: string);
begin
  FNumRegConselhoClasse := Astring;
  FNumRegConselhoClasse_Specified := True;
end;

function stDadosCliente.NumRegConselhoClasse_Specified(Index: Integer): boolean;
begin
  Result := FNumRegConselhoClasse_Specified;
end;

procedure stDadosCliente.SetUFRegConselhoClasse(Index: Integer; const Astring: string);
begin
  FUFRegConselhoClasse := Astring;
  FUFRegConselhoClasse_Specified := True;
end;

function stDadosCliente.UFRegConselhoClasse_Specified(Index: Integer): boolean;
begin
  Result := FUFRegConselhoClasse_Specified;
end;

procedure stDadosCliente.SetCNPJProprietario(Index: Integer; const Astring: string);
begin
  FCNPJProprietario := Astring;
  FCNPJProprietario_Specified := True;
end;

function stDadosCliente.CNPJProprietario_Specified(Index: Integer): boolean;
begin
  Result := FCNPJProprietario_Specified;
end;

procedure stDadosCliente.SetNomeConj(Index: Integer; const Astring: string);
begin
  FNomeConj := Astring;
  FNomeConj_Specified := True;
end;

function stDadosCliente.NomeConj_Specified(Index: Integer): boolean;
begin
  Result := FNomeConj_Specified;
end;

procedure stDadosCliente.SetCPFConj(Index: Integer; const Astring: string);
begin
  FCPFConj := Astring;
  FCPFConj_Specified := True;
end;

function stDadosCliente.CPFConj_Specified(Index: Integer): boolean;
begin
  Result := FCPFConj_Specified;
end;

procedure stDadosCliente.SetNascimentoConj(Index: Integer; const Astring: string);
begin
  FNascimentoConj := Astring;
  FNascimentoConj_Specified := True;
end;

function stDadosCliente.NascimentoConj_Specified(Index: Integer): boolean;
begin
  Result := FNascimentoConj_Specified;
end;

procedure stDadosCliente.SetMaeConj(Index: Integer; const Astring: string);
begin
  FMaeConj := Astring;
  FMaeConj_Specified := True;
end;

function stDadosCliente.MaeConj_Specified(Index: Integer): boolean;
begin
  Result := FMaeConj_Specified;
end;

procedure stDadosCliente.SetTipoDocIdentificacaoConj(Index: Integer; const Astring: string);
begin
  FTipoDocIdentificacaoConj := Astring;
  FTipoDocIdentificacaoConj_Specified := True;
end;

function stDadosCliente.TipoDocIdentificacaoConj_Specified(Index: Integer): boolean;
begin
  Result := FTipoDocIdentificacaoConj_Specified;
end;

procedure stDadosCliente.SetDocIdentificacaoConj(Index: Integer; const Astring: string);
begin
  FDocIdentificacaoConj := Astring;
  FDocIdentificacaoConj_Specified := True;
end;

function stDadosCliente.DocIdentificacaoConj_Specified(Index: Integer): boolean;
begin
  Result := FDocIdentificacaoConj_Specified;
end;

procedure stDadosCliente.SetUFEmissorDocIdentificacaoConj(Index: Integer; const Astring: string);
begin
  FUFEmissorDocIdentificacaoConj := Astring;
  FUFEmissorDocIdentificacaoConj_Specified := True;
end;

function stDadosCliente.UFEmissorDocIdentificacaoConj_Specified(Index: Integer): boolean;
begin
  Result := FUFEmissorDocIdentificacaoConj_Specified;
end;

procedure stDadosCliente.SetDataEmissaoDocIdentificacaoConj(Index: Integer; const Astring: string);
begin
  FDataEmissaoDocIdentificacaoConj := Astring;
  FDataEmissaoDocIdentificacaoConj_Specified := True;
end;

function stDadosCliente.DataEmissaoDocIdentificacaoConj_Specified(Index: Integer): boolean;
begin
  Result := FDataEmissaoDocIdentificacaoConj_Specified;
end;

procedure stDadosCliente.SetEmpresaConj(Index: Integer; const Astring: string);
begin
  FEmpresaConj := Astring;
  FEmpresaConj_Specified := True;
end;

function stDadosCliente.EmpresaConj_Specified(Index: Integer): boolean;
begin
  Result := FEmpresaConj_Specified;
end;

procedure stDadosCliente.SetCargoConj(Index: Integer; const Astring: string);
begin
  FCargoConj := Astring;
  FCargoConj_Specified := True;
end;

function stDadosCliente.CargoConj_Specified(Index: Integer): boolean;
begin
  Result := FCargoConj_Specified;
end;

procedure stDadosCliente.SetDataAdmissaoConj(Index: Integer; const Astring: string);
begin
  FDataAdmissaoConj := Astring;
  FDataAdmissaoConj_Specified := True;
end;

function stDadosCliente.DataAdmissaoConj_Specified(Index: Integer): boolean;
begin
  Result := FDataAdmissaoConj_Specified;
end;

procedure stDadosCliente.SetDDDConj(Index: Integer; const Astring: string);
begin
  FDDDConj := Astring;
  FDDDConj_Specified := True;
end;

function stDadosCliente.DDDConj_Specified(Index: Integer): boolean;
begin
  Result := FDDDConj_Specified;
end;

procedure stDadosCliente.SetTelefoneConj(Index: Integer; const Astring: string);
begin
  FTelefoneConj := Astring;
  FTelefoneConj_Specified := True;
end;

function stDadosCliente.TelefoneConj_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneConj_Specified;
end;

procedure stDadosCliente.SetRamalConj(Index: Integer; const Astring: string);
begin
  FRamalConj := Astring;
  FRamalConj_Specified := True;
end;

function stDadosCliente.RamalConj_Specified(Index: Integer): boolean;
begin
  Result := FRamalConj_Specified;
end;

procedure stDadosCliente.SetDDDConj2(Index: Integer; const Astring: string);
begin
  FDDDConj2 := Astring;
  FDDDConj2_Specified := True;
end;

function stDadosCliente.DDDConj2_Specified(Index: Integer): boolean;
begin
  Result := FDDDConj2_Specified;
end;

procedure stDadosCliente.SetTelefoneConj2(Index: Integer; const Astring: string);
begin
  FTelefoneConj2 := Astring;
  FTelefoneConj2_Specified := True;
end;

function stDadosCliente.TelefoneConj2_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneConj2_Specified;
end;

procedure stDadosCliente.SetRamalConj2(Index: Integer; const Astring: string);
begin
  FRamalConj2 := Astring;
  FRamalConj2_Specified := True;
end;

function stDadosCliente.RamalConj2_Specified(Index: Integer): boolean;
begin
  Result := FRamalConj2_Specified;
end;

procedure stDadosCliente.SetNumBeneficioConj(Index: Integer; const Astring: string);
begin
  FNumBeneficioConj := Astring;
  FNumBeneficioConj_Specified := True;
end;

function stDadosCliente.NumBeneficioConj_Specified(Index: Integer): boolean;
begin
  Result := FNumBeneficioConj_Specified;
end;

procedure stDadosCliente.SetOutrasRendasConj(Index: Integer; const Astring: string);
begin
  FOutrasRendasConj := Astring;
  FOutrasRendasConj_Specified := True;
end;

function stDadosCliente.OutrasRendasConj_Specified(Index: Integer): boolean;
begin
  Result := FOutrasRendasConj_Specified;
end;

procedure stDadosCliente.SetDDDOutrasRendasConj(Index: Integer; const Astring: string);
begin
  FDDDOutrasRendasConj := Astring;
  FDDDOutrasRendasConj_Specified := True;
end;

function stDadosCliente.DDDOutrasRendasConj_Specified(Index: Integer): boolean;
begin
  Result := FDDDOutrasRendasConj_Specified;
end;

procedure stDadosCliente.SetFoneOutrasRendasConj(Index: Integer; const Astring: string);
begin
  FFoneOutrasRendasConj := Astring;
  FFoneOutrasRendasConj_Specified := True;
end;

function stDadosCliente.FoneOutrasRendasConj_Specified(Index: Integer): boolean;
begin
  Result := FFoneOutrasRendasConj_Specified;
end;

procedure stDadosCliente.SetRamalOutrasRendasConj(Index: Integer; const Astring: string);
begin
  FRamalOutrasRendasConj := Astring;
  FRamalOutrasRendasConj_Specified := True;
end;

function stDadosCliente.RamalOutrasRendasConj_Specified(Index: Integer): boolean;
begin
  Result := FRamalOutrasRendasConj_Specified;
end;

procedure stDadosCliente.SetRef1Nome(Index: Integer; const Astring: string);
begin
  FRef1Nome := Astring;
  FRef1Nome_Specified := True;
end;

function stDadosCliente.Ref1Nome_Specified(Index: Integer): boolean;
begin
  Result := FRef1Nome_Specified;
end;

procedure stDadosCliente.SetRef1DDD(Index: Integer; const Astring: string);
begin
  FRef1DDD := Astring;
  FRef1DDD_Specified := True;
end;

function stDadosCliente.Ref1DDD_Specified(Index: Integer): boolean;
begin
  Result := FRef1DDD_Specified;
end;

procedure stDadosCliente.SetRef1Fone(Index: Integer; const Astring: string);
begin
  FRef1Fone := Astring;
  FRef1Fone_Specified := True;
end;

function stDadosCliente.Ref1Fone_Specified(Index: Integer): boolean;
begin
  Result := FRef1Fone_Specified;
end;

procedure stDadosCliente.SetRef1Ramal(Index: Integer; const Astring: string);
begin
  FRef1Ramal := Astring;
  FRef1Ramal_Specified := True;
end;

function stDadosCliente.Ref1Ramal_Specified(Index: Integer): boolean;
begin
  Result := FRef1Ramal_Specified;
end;

procedure stDadosCliente.SetRef1GrauParentesco(Index: Integer; const Astring: string);
begin
  FRef1GrauParentesco := Astring;
  FRef1GrauParentesco_Specified := True;
end;

function stDadosCliente.Ref1GrauParentesco_Specified(Index: Integer): boolean;
begin
  Result := FRef1GrauParentesco_Specified;
end;

procedure stDadosCliente.SetRef2Nome(Index: Integer; const Astring: string);
begin
  FRef2Nome := Astring;
  FRef2Nome_Specified := True;
end;

function stDadosCliente.Ref2Nome_Specified(Index: Integer): boolean;
begin
  Result := FRef2Nome_Specified;
end;

procedure stDadosCliente.SetRef2DDD(Index: Integer; const Astring: string);
begin
  FRef2DDD := Astring;
  FRef2DDD_Specified := True;
end;

function stDadosCliente.Ref2DDD_Specified(Index: Integer): boolean;
begin
  Result := FRef2DDD_Specified;
end;

procedure stDadosCliente.SetRef2Fone(Index: Integer; const Astring: string);
begin
  FRef2Fone := Astring;
  FRef2Fone_Specified := True;
end;

function stDadosCliente.Ref2Fone_Specified(Index: Integer): boolean;
begin
  Result := FRef2Fone_Specified;
end;

procedure stDadosCliente.SetRef2Ramal(Index: Integer; const Astring: string);
begin
  FRef2Ramal := Astring;
  FRef2Ramal_Specified := True;
end;

function stDadosCliente.Ref2Ramal_Specified(Index: Integer): boolean;
begin
  Result := FRef2Ramal_Specified;
end;

procedure stDadosCliente.SetRef2GrauParentesco(Index: Integer; const Astring: string);
begin
  FRef2GrauParentesco := Astring;
  FRef2GrauParentesco_Specified := True;
end;

function stDadosCliente.Ref2GrauParentesco_Specified(Index: Integer): boolean;
begin
  Result := FRef2GrauParentesco_Specified;
end;

procedure stDadosCliente.SetRef3Nome(Index: Integer; const Astring: string);
begin
  FRef3Nome := Astring;
  FRef3Nome_Specified := True;
end;

function stDadosCliente.Ref3Nome_Specified(Index: Integer): boolean;
begin
  Result := FRef3Nome_Specified;
end;

procedure stDadosCliente.SetRef3DDD(Index: Integer; const Astring: string);
begin
  FRef3DDD := Astring;
  FRef3DDD_Specified := True;
end;

function stDadosCliente.Ref3DDD_Specified(Index: Integer): boolean;
begin
  Result := FRef3DDD_Specified;
end;

procedure stDadosCliente.SetRef3Fone(Index: Integer; const Astring: string);
begin
  FRef3Fone := Astring;
  FRef3Fone_Specified := True;
end;

function stDadosCliente.Ref3Fone_Specified(Index: Integer): boolean;
begin
  Result := FRef3Fone_Specified;
end;

procedure stDadosCliente.SetRef3Ramal(Index: Integer; const Astring: string);
begin
  FRef3Ramal := Astring;
  FRef3Ramal_Specified := True;
end;

function stDadosCliente.Ref3Ramal_Specified(Index: Integer): boolean;
begin
  Result := FRef3Ramal_Specified;
end;

procedure stDadosCliente.SetRef3GrauParentesco(Index: Integer; const Astring: string);
begin
  FRef3GrauParentesco := Astring;
  FRef3GrauParentesco_Specified := True;
end;

function stDadosCliente.Ref3GrauParentesco_Specified(Index: Integer): boolean;
begin
  Result := FRef3GrauParentesco_Specified;
end;

procedure stDadosCliente.SetRef4Nome(Index: Integer; const Astring: string);
begin
  FRef4Nome := Astring;
  FRef4Nome_Specified := True;
end;

function stDadosCliente.Ref4Nome_Specified(Index: Integer): boolean;
begin
  Result := FRef4Nome_Specified;
end;

procedure stDadosCliente.SetRef4DDD(Index: Integer; const Astring: string);
begin
  FRef4DDD := Astring;
  FRef4DDD_Specified := True;
end;

function stDadosCliente.Ref4DDD_Specified(Index: Integer): boolean;
begin
  Result := FRef4DDD_Specified;
end;

procedure stDadosCliente.SetRef4Fone(Index: Integer; const Astring: string);
begin
  FRef4Fone := Astring;
  FRef4Fone_Specified := True;
end;

function stDadosCliente.Ref4Fone_Specified(Index: Integer): boolean;
begin
  Result := FRef4Fone_Specified;
end;

procedure stDadosCliente.SetRef4Ramal(Index: Integer; const Astring: string);
begin
  FRef4Ramal := Astring;
  FRef4Ramal_Specified := True;
end;

function stDadosCliente.Ref4Ramal_Specified(Index: Integer): boolean;
begin
  Result := FRef4Ramal_Specified;
end;

procedure stDadosCliente.SetRef4GrauParentesco(Index: Integer; const Astring: string);
begin
  FRef4GrauParentesco := Astring;
  FRef4GrauParentesco_Specified := True;
end;

function stDadosCliente.Ref4GrauParentesco_Specified(Index: Integer): boolean;
begin
  Result := FRef4GrauParentesco_Specified;
end;

procedure stDadosCliente.SetRefComercialDesc(Index: Integer; const Astring: string);
begin
  FRefComercialDesc := Astring;
  FRefComercialDesc_Specified := True;
end;

function stDadosCliente.RefComercialDesc_Specified(Index: Integer): boolean;
begin
  Result := FRefComercialDesc_Specified;
end;

procedure stDadosCliente.SetCodBanco(Index: Integer; const Astring: string);
begin
  FCodBanco := Astring;
  FCodBanco_Specified := True;
end;

function stDadosCliente.CodBanco_Specified(Index: Integer): boolean;
begin
  Result := FCodBanco_Specified;
end;

procedure stDadosCliente.SetAgencia(Index: Integer; const Astring: string);
begin
  FAgencia := Astring;
  FAgencia_Specified := True;
end;

function stDadosCliente.Agencia_Specified(Index: Integer): boolean;
begin
  Result := FAgencia_Specified;
end;

procedure stDadosCliente.SetConta(Index: Integer; const Astring: string);
begin
  FConta := Astring;
  FConta_Specified := True;
end;

function stDadosCliente.Conta_Specified(Index: Integer): boolean;
begin
  Result := FConta_Specified;
end;

procedure stDadosCliente.SetContador(Index: Integer; const Astring: string);
begin
  FContador := Astring;
  FContador_Specified := True;
end;

function stDadosCliente.Contador_Specified(Index: Integer): boolean;
begin
  Result := FContador_Specified;
end;

procedure stDadosCliente.SetDDDContador(Index: Integer; const Astring: string);
begin
  FDDDContador := Astring;
  FDDDContador_Specified := True;
end;

function stDadosCliente.DDDContador_Specified(Index: Integer): boolean;
begin
  Result := FDDDContador_Specified;
end;

procedure stDadosCliente.SetFoneContador(Index: Integer; const Astring: string);
begin
  FFoneContador := Astring;
  FFoneContador_Specified := True;
end;

function stDadosCliente.FoneContador_Specified(Index: Integer): boolean;
begin
  Result := FFoneContador_Specified;
end;

procedure stDadosCliente.SetRamalContador(Index: Integer; const Astring: string);
begin
  FRamalContador := Astring;
  FRamalContador_Specified := True;
end;

function stDadosCliente.RamalContador_Specified(Index: Integer): boolean;
begin
  Result := FRamalContador_Specified;
end;

procedure stRetorno2.SetBoletoCCB(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FBoletoCCB := ATByteDynArray;
  FBoletoCCB_Specified := True;
end;

function stRetorno2.BoletoCCB_Specified(Index: Integer): boolean;
begin
  Result := FBoletoCCB_Specified;
end;

procedure stRetorno2.SetSituacao(Index: Integer; const Astring: string);
begin
  FSituacao := Astring;
  FSituacao_Specified := True;
end;

function stRetorno2.Situacao_Specified(Index: Integer): boolean;
begin
  Result := FSituacao_Specified;
end;

procedure stRetorno2.SetMensagem(Index: Integer; const Astring: string);
begin
  FMensagem := Astring;
  FMensagem_Specified := True;
end;

function stRetorno2.Mensagem_Specified(Index: Integer): boolean;
begin
  Result := FMensagem_Specified;
end;

procedure stRetornoStatus2.SetStatus(Index: Integer; const Astring: string);
begin
  FStatus := Astring;
  FStatus_Specified := True;
end;

function stRetornoStatus2.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure stRetornoStatus2.SetMensagem(Index: Integer; const Astring: string);
begin
  FMensagem := Astring;
  FMensagem_Specified := True;
end;

function stRetornoStatus2.Mensagem_Specified(Index: Integer): boolean;
begin
  Result := FMensagem_Specified;
end;

procedure stRetornoStatus2.SetContrato(Index: Integer; const Astring: string);
begin
  FContrato := Astring;
  FContrato_Specified := True;
end;

function stRetornoStatus2.Contrato_Specified(Index: Integer): boolean;
begin
  Result := FContrato_Specified;
end;

procedure stRetornoStatus2.SetPrevisaoPgto(Index: Integer; const Astring: string);
begin
  FPrevisaoPgto := Astring;
  FPrevisaoPgto_Specified := True;
end;

function stRetornoStatus2.PrevisaoPgto_Specified(Index: Integer): boolean;
begin
  Result := FPrevisaoPgto_Specified;
end;

procedure stRetornoStatus2.SetAnexoCCB(Index: Integer; const Astring: string);
begin
  FAnexoCCB := Astring;
  FAnexoCCB_Specified := True;
end;

function stRetornoStatus2.AnexoCCB_Specified(Index: Integer): boolean;
begin
  Result := FAnexoCCB_Specified;
end;

procedure stRetornoCancelamento2.SetStatus(Index: Integer; const Astring: string);
begin
  FStatus := Astring;
  FStatus_Specified := True;
end;

function stRetornoCancelamento2.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure stRetornoCancelamento2.SetMensagem(Index: Integer; const Astring: string);
begin
  FMensagem := Astring;
  FMensagem_Specified := True;
end;

function stRetornoCancelamento2.Mensagem_Specified(Index: Integer): boolean;
begin
  Result := FMensagem_Specified;
end;

procedure stRetornoSimulacao2.SetStatus(Index: Integer; const Astring: string);
begin
  FStatus := Astring;
  FStatus_Specified := True;
end;

function stRetornoSimulacao2.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure stRetornoSimulacao2.SetMensagem(Index: Integer; const Astring: string);
begin
  FMensagem := Astring;
  FMensagem_Specified := True;
end;

function stRetornoSimulacao2.Mensagem_Specified(Index: Integer): boolean;
begin
  Result := FMensagem_Specified;
end;

procedure stRetornoMensagem2.SetSituacao(Index: Integer; const Astring: string);
begin
  FSituacao := Astring;
  FSituacao_Specified := True;
end;

function stRetornoMensagem2.Situacao_Specified(Index: Integer): boolean;
begin
  Result := FSituacao_Specified;
end;

procedure stRetornoMensagem2.SetMensagem(Index: Integer; const Astring: string);
begin
  FMensagem := Astring;
  FMensagem_Specified := True;
end;

function stRetornoMensagem2.Mensagem_Specified(Index: Integer): boolean;
begin
  Result := FMensagem_Specified;
end;

procedure stRetornoMensagem2.SetTipo(Index: Integer; const Astring: string);
begin
  FTipo := Astring;
  FTipo_Specified := True;
end;

function stRetornoMensagem2.Tipo_Specified(Index: Integer): boolean;
begin
  Result := FTipo_Specified;
end;

destructor stProposta.Destroy;
begin
  SysUtils.FreeAndNil(FdtCompra);
  SysUtils.FreeAndNil(FdtPriVcto);
  inherited Destroy;
end;

procedure stProposta.SetcodPropostaLojista(Index: Integer; const Astring: string);
begin
  FcodPropostaLojista := Astring;
  FcodPropostaLojista_Specified := True;
end;

function stProposta.codPropostaLojista_Specified(Index: Integer): boolean;
begin
  Result := FcodPropostaLojista_Specified;
end;

procedure stProposta.SetcodSeguroCredipar(Index: Integer; const Astring: string);
begin
  FcodSeguroCredipar := Astring;
  FcodSeguroCredipar_Specified := True;
end;

function stProposta.codSeguroCredipar_Specified(Index: Integer): boolean;
begin
  Result := FcodSeguroCredipar_Specified;
end;

procedure stProposta.SettipoSeguro(Index: Integer; const Astring: string);
begin
  FtipoSeguro := Astring;
  FtipoSeguro_Specified := True;
end;

function stProposta.tipoSeguro_Specified(Index: Integer): boolean;
begin
  Result := FtipoSeguro_Specified;
end;

procedure stProposta.SetCorrespondenteCpf(Index: Integer; const Astring: string);
begin
  FCorrespondenteCpf := Astring;
  FCorrespondenteCpf_Specified := True;
end;

function stProposta.CorrespondenteCpf_Specified(Index: Integer): boolean;
begin
  Result := FCorrespondenteCpf_Specified;
end;

procedure stProposta.SetCorrespondenteNome(Index: Integer; const Astring: string);
begin
  FCorrespondenteNome := Astring;
  FCorrespondenteNome_Specified := True;
end;

function stProposta.CorrespondenteNome_Specified(Index: Integer): boolean;
begin
  Result := FCorrespondenteNome_Specified;
end;

function stProposta.critica(pResultado: IResultadoOperacao): boolean;
  var
    lSave: Integer;
begin
  checkResultadoOperacao(pResultado);
  lSave := pResultado.erros;
  pResultado.adicionaErro('stProposta.critica: Não implementado.');
  Result := pResultado.erros<>lSave;
end;

procedure stProposta.SetArogoCPF(Index: Integer; const Astring: string);
begin
  FArogoCPF := Astring;
  FArogoCPF_Specified := True;
end;

function stProposta.ArogoCPF_Specified(Index: Integer): boolean;
begin
  Result := FArogoCPF_Specified;
end;

procedure stProposta.SetArogoNome(Index: Integer; const Astring: string);
begin
  FArogoNome := Astring;
  FArogoNome_Specified := True;
end;

function stProposta.ArogoNome_Specified(Index: Integer): boolean;
begin
  Result := FArogoNome_Specified;
end;

procedure stProposta.SetArogoParentesco(Index: Integer; const Astring: string);
begin
  FArogoParentesco := Astring;
  FArogoParentesco_Specified := True;
end;

function stProposta.ArogoParentesco_Specified(Index: Integer): boolean;
begin
  Result := FArogoParentesco_Specified;
end;

procedure stProposta.SetmercadoriaEntrega(Index: Integer; const Astring: string);
begin
  FmercadoriaEntrega := Astring;
  FmercadoriaEntrega_Specified := True;
end;

function stProposta.mercadoriaEntrega_Specified(Index: Integer): boolean;
begin
  Result := FmercadoriaEntrega_Specified;
end;

procedure stProposta.SetnomeVendedor(Index: Integer; const Astring: string);
begin
  FnomeVendedor := Astring;
  FnomeVendedor_Specified := True;
end;

function stProposta.nomeVendedor_Specified(Index: Integer): boolean;
begin
  Result := FnomeVendedor_Specified;
end;

procedure stProposta.SetcodigoVendedor(Index: Integer; const Astring: string);
begin
  FcodigoVendedor := Astring;
  FcodigoVendedor_Specified := True;
end;

function stProposta.codigoVendedor_Specified(Index: Integer): boolean;
begin
  Result := FcodigoVendedor_Specified;
end;

procedure stProposta.Setmercadoria(Index: Integer; const Astring: string);
begin
  Fmercadoria := Astring;
  Fmercadoria_Specified := True;
end;

function stProposta.mercadoria_Specified(Index: Integer): boolean;
begin
  Result := Fmercadoria_Specified;
end;

procedure stProposta.Setconversacao(Index: Integer; const Astring: string);
begin
  Fconversacao := Astring;
  Fconversacao_Specified := True;
end;

function stProposta.conversacao_Specified(Index: Integer): boolean;
begin
  Result := Fconversacao_Specified;
end;

procedure stProposta.Setno_reserva_loja(Index: Integer; const Astring: string);
begin
  Fno_reserva_loja := Astring;
  Fno_reserva_loja_Specified := True;
end;

function stProposta.no_reserva_loja_Specified(Index: Integer): boolean;
begin
  Result := Fno_reserva_loja_Specified;
end;

procedure stProposta.SetclienteDiamante(Index: Integer; const Astring: string);
begin
  FclienteDiamante := Astring;
  FclienteDiamante_Specified := True;
end;

function stProposta.clienteDiamante_Specified(Index: Integer): boolean;
begin
  Result := FclienteDiamante_Specified;
end;

procedure stProposta.SetplanoSic(Index: Integer; const Astring: string);
begin
  FplanoSic := Astring;
  FplanoSic_Specified := True;
end;

function stProposta.planoSic_Specified(Index: Integer): boolean;
begin
  Result := FplanoSic_Specified;
end;

procedure stRetornoStatusProposta2.SetProposta(Index: Integer; const Astring: string);
begin
  FProposta := Astring;
  FProposta_Specified := True;
end;

function stRetornoStatusProposta2.Proposta_Specified(Index: Integer): boolean;
begin
  Result := FProposta_Specified;
end;

procedure stRetornoStatusProposta2.SetStatus(Index: Integer; const Astring: string);
begin
  FStatus := Astring;
  FStatus_Specified := True;
end;

function stRetornoStatusProposta2.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure stRetornoStatusProposta2.SetMensagem(Index: Integer; const Astring: string);
begin
  FMensagem := Astring;
  FMensagem_Specified := True;
end;

function stRetornoStatusProposta2.Mensagem_Specified(Index: Integer): boolean;
begin
  Result := FMensagem_Specified;
end;

procedure stRetornoStatusProposta2.SetProcessamento(Index: Integer; const Astring: string);
begin
  FProcessamento := Astring;
  FProcessamento_Specified := True;
end;

function stRetornoStatusProposta2.Processamento_Specified(Index: Integer): boolean;
begin
  Result := FProcessamento_Specified;
end;

procedure stRetornoProposta.SetProposta(Index: Integer; const Astring: string);
begin
  FProposta := Astring;
  FProposta_Specified := True;
end;

function stRetornoProposta.Proposta_Specified(Index: Integer): boolean;
begin
  Result := FProposta_Specified;
end;

procedure stRetornoProposta.SetMensagem(Index: Integer; const Astring: string);
begin
  FMensagem := Astring;
  FMensagem_Specified := True;
end;

function stRetornoProposta.Mensagem_Specified(Index: Integer): boolean;
begin
  Result := FMensagem_Specified;
end;

procedure stRetornoProposta.SetProcessamento(Index: Integer; const Astring: string);
begin
  FProcessamento := Astring;
  FProcessamento_Specified := True;
end;

function stRetornoProposta.Processamento_Specified(Index: Integer): boolean;
begin
  Result := FProcessamento_Specified;
end;

initialization
  { wsCrediparSoap }
  InvRegistry.RegisterInterface(TypeInfo(wsCrediparSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(wsCrediparSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(wsCrediparSoap), ioDocument);
  { wsCrediparSoap.EnviarPropostaCliente }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'EnviarPropostaCliente', '',
                                 '[ReturnName="EnviarPropostaClienteResult"]');
  { wsCrediparSoap.ConsultarStatusProposta }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'ConsultarStatusProposta', '',
                                 '[ReturnName="ConsultarStatusPropostaResult"]');
  { wsCrediparSoap.AnexarDocumentoAnalise }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'AnexarDocumentoAnalise', '',
                                 '[ReturnName="AnexarDocumentoAnaliseResult"]');
  { wsCrediparSoap.AnexarDocumentoProcessamento }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'AnexarDocumentoProcessamento', '',
                                 '[ReturnName="AnexarDocumentoProcessamentoResult"]');
  { wsCrediparSoap.GerarCCBeBoleto }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'GerarCCBeBoleto', '',
                                 '[ReturnName="GerarCCBeBoletoResult"]');
  { wsCrediparSoap.ConsultarProcessamentoProposta }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'ConsultarProcessamentoProposta', '',
                                 '[ReturnName="ConsultarProcessamentoPropostaResult"]');
  { wsCrediparSoap.GerarConciliacao }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'GerarConciliacao', '',
                                 '[ReturnName="GerarConciliacaoResult"]', IS_OPTN);
  { wsCrediparSoap.Simulacao }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'Simulacao', '',
                                 '[ReturnName="SimulacaoResult"]');
  { wsCrediparSoap.CancelarProposta }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'CancelarProposta', '',
                                 '[ReturnName="CancelarPropostaResult"]');
  { wsCrediparSoap.HelloWorld }
  InvRegistry.RegisterMethodInfo(TypeInfo(wsCrediparSoap), 'HelloWorld', '',
                                 '[ReturnName="HelloWorldResult"]', IS_OPTN);
  { wsCrediparHttpGet }
  InvRegistry.RegisterInterface(TypeInfo(wsCrediparHttpGet), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(wsCrediparHttpGet), '');
  { wsCrediparHttpGet.AnexarDocumentoAnalise }
  InvRegistry.RegisterParamInfo(TypeInfo(wsCrediparHttpGet), 'AnexarDocumentoAnalise', 'ArquivoBytes', '',
                                '[ArrayItemName="String"]');
  { wsCrediparHttpGet.AnexarDocumentoProcessamento }
  InvRegistry.RegisterParamInfo(TypeInfo(wsCrediparHttpGet), 'AnexarDocumentoProcessamento', 'ArquivoBytes', '',
                                '[ArrayItemName="String"]');
  { wsCrediparHttpPost }
  InvRegistry.RegisterInterface(TypeInfo(wsCrediparHttpPost), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(wsCrediparHttpPost), '');
  { wsCrediparHttpPost.AnexarDocumentoAnalise }
  InvRegistry.RegisterParamInfo(TypeInfo(wsCrediparHttpPost), 'AnexarDocumentoAnalise', 'ArquivoBytes', '',
                                '[ArrayItemName="String"]');
  { wsCrediparHttpPost.AnexarDocumentoProcessamento }
  InvRegistry.RegisterParamInfo(TypeInfo(wsCrediparHttpPost), 'AnexarDocumentoProcessamento', 'ArquivoBytes', '',
                                '[ArrayItemName="String"]');
  RemClassRegistry.RegisterXSClass(stDadosCliente, 'http://tempuri.org/', 'stDadosCliente');
  RemClassRegistry.RegisterXSInfo(TypeInfo(StringArray), 'http://tempuri.org/AbstractTypes', 'StringArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(string_), 'http://tempuri.org/', 'string_', 'string');
  RemClassRegistry.RegisterXSClass(stRetorno2, 'http://tempuri.org/', 'stRetorno2', 'stRetorno');
  RemClassRegistry.RegisterXSClass(stRetorno, 'http://tempuri.org/', 'stRetorno');
  RemClassRegistry.RegisterXSClass(stRetornoStatus2, 'http://tempuri.org/', 'stRetornoStatus2', 'stRetornoStatus');
  RemClassRegistry.RegisterXSClass(stRetornoStatus, 'http://tempuri.org/', 'stRetornoStatus');
  RemClassRegistry.RegisterXSClass(stRetornoCancelamento2, 'http://tempuri.org/', 'stRetornoCancelamento2', 'stRetornoCancelamento');
  RemClassRegistry.RegisterXSClass(stRetornoCancelamento, 'http://tempuri.org/', 'stRetornoCancelamento');
  RemClassRegistry.RegisterXSClass(stRetornoSimulacao2, 'http://tempuri.org/', 'stRetornoSimulacao2', 'stRetornoSimulacao');
  RemClassRegistry.RegisterXSClass(stRetornoSimulacao, 'http://tempuri.org/', 'stRetornoSimulacao');
  RemClassRegistry.RegisterXSClass(stRetornoMensagem2, 'http://tempuri.org/', 'stRetornoMensagem2', 'stRetornoMensagem');
  RemClassRegistry.RegisterXSClass(stRetornoMensagem, 'http://tempuri.org/', 'stRetornoMensagem');
  RemClassRegistry.RegisterXSClass(stProposta, 'http://tempuri.org/', 'stProposta');
  RemClassRegistry.RegisterXSClass(stRetornoStatusProposta2, 'http://tempuri.org/', 'stRetornoStatusProposta2', 'stRetornoStatusProposta');
  RemClassRegistry.RegisterXSClass(stRetornoStatusProposta, 'http://tempuri.org/', 'stRetornoStatusProposta');
  RemClassRegistry.RegisterXSClass(stRetornoProposta, 'http://tempuri.org/', 'stRetornoProposta');

end.