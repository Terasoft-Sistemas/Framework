// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://www.credipar.com.br/analisador/analisador.asmx?WSDL
//  >Import : https://www.credipar.com.br/analisador/analisador.asmx?WSDL>0
//  >Import : https://www.credipar.com.br/analisador/analisador.asmx?WSDL>1
// Encoding : utf-8
// Version  : 1.0
// (05/06/2024 08:27:45 - - $Rev: 56641 $)
// ************************************************************************ //

unit Credipar.Analisador.Webservice;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

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
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]

  stRetornoProposta2   = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoProposta    = class;                 { "http://tempuri.org/"[GblElm] }
  stRetornoStatusBordero2 = class;              { "http://tempuri.org/"[GblCplx] }
  stRetornoStatusBordero = class;               { "http://tempuri.org/"[GblElm] }
  stProposta           = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoMensagem2   = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoMensagem    = class;                 { "http://tempuri.org/"[GblElm] }
  stCartao             = class;                 { "http://tempuri.org/"[GblCplx] }
  stPJ                 = class;                 { "http://tempuri.org/"[GblCplx] }
  stPF                 = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoCancelamento2 = class;               { "http://tempuri.org/"[GblCplx] }
  stRetornoCancelamento = class;                { "http://tempuri.org/"[GblElm] }
  stRetornoStatus2     = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetornoStatus      = class;                 { "http://tempuri.org/"[GblElm] }
  stRetornoPropostaNova2 = class;               { "http://tempuri.org/"[GblCplx] }
  stRetornoPropostaNova = class;                { "http://tempuri.org/"[GblElm] }
  stNovaProposta       = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetorno2           = class;                 { "http://tempuri.org/"[GblCplx] }
  stRetorno            = class;                 { "http://tempuri.org/"[GblElm] }

  string_         =  type string;      { "http://tempuri.org/"[GblElm] }


  // ************************************************************************ //
  // XML       : stRetornoProposta, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoProposta2 = class(TRemotable)
  private
    Floja: Integer;
    Fproposta: string;
    Fproposta_Specified: boolean;
    Fstatus: string;
    Fstatus_Specified: boolean;
    Fcontrato: Int64;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    Fconcatenado: string;
    Fconcatenado_Specified: boolean;
    procedure Setproposta(Index: Integer; const Astring: string);
    function  proposta_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure Setconcatenado(Index: Integer; const Astring: string);
    function  concatenado_Specified(Index: Integer): boolean;
  published
    property loja:        Integer  read Floja write Floja;
    property proposta:    string   Index (IS_OPTN) read Fproposta write Setproposta stored proposta_Specified;
    property status:      string   Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
    property contrato:    Int64    read Fcontrato write Fcontrato;
    property mensagem:    string   Index (IS_OPTN) read Fmensagem write Setmensagem stored mensagem_Specified;
    property concatenado: string   Index (IS_OPTN) read Fconcatenado write Setconcatenado stored concatenado_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoProposta, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoProposta = class(stRetornoProposta2)
  private
  published
  end;

  StringArray = array of string;                { "http://tempuri.org/AbstractTypes"[GblCplx] }


  // ************************************************************************ //
  // XML       : stRetornoStatusBordero, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoStatusBordero2 = class(TRemotable)
  private
    Fstatus: string;
    Fstatus_Specified: boolean;
    Fvalor: string;
    Fvalor_Specified: boolean;
    Fcontrato: string;
    Fcontrato_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    FPrevisaoPgto: string;
    FPrevisaoPgto_Specified: boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): boolean;
    procedure Setvalor(Index: Integer; const Astring: string);
    function  valor_Specified(Index: Integer): boolean;
    procedure Setcontrato(Index: Integer; const Astring: string);
    function  contrato_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure SetPrevisaoPgto(Index: Integer; const Astring: string);
    function  PrevisaoPgto_Specified(Index: Integer): boolean;
  published
    property status:       string  Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
    property valor:        string  Index (IS_OPTN) read Fvalor write Setvalor stored valor_Specified;
    property contrato:     string  Index (IS_OPTN) read Fcontrato write Setcontrato stored contrato_Specified;
    property mensagem:     string  Index (IS_OPTN) read Fmensagem write Setmensagem stored mensagem_Specified;
    property PrevisaoPgto: string  Index (IS_OPTN) read FPrevisaoPgto write SetPrevisaoPgto stored PrevisaoPgto_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoStatusBordero, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoStatusBordero = class(stRetornoStatusBordero2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : stProposta, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stProposta = class(TRemotable)
  private
    Fproposta: string;
    Fproposta_Specified: boolean;
    Floja: Integer;
    Fqt_parcela: Integer;
    Fcd_pedido: Integer;
    Fidtabela: Integer;
    Fcd_tipo_financ: Integer;
    Fid_lj_tabela: Integer;
    Fcd_empresa: Integer;
    Fvl_compra: Double;
    Fvl_entrada: Double;
    Fvl_parcela: Double;
    Fvl_juros: Double;
    Fvl_juros_rev: Double;
    Fvl_tac: Double;
    Fvl_doc: Double;
    Fvl_financiado: Double;
    Fvl_iof: Double;
    Fvl_dcl: Double;
    Fvl_retencao: Double;
    Fvl_taxaret: Double;
    Ffator_efetivo: Double;
    Ffator_rev: Double;
    Ffator: Double;
    Fvl_comissao_overprice: Double;
    FTACComissaoPercentual: Double;
    FTacComissaoValor: Double;
    FEPComissaoPercentual: Double;
    Fdt_compra: TXSDateTime;
    Fdt_pri_vencto: TXSDateTime;
    Ftipo_dcl: string;
    Ftipo_dcl_Specified: boolean;
    Fmodalidade: string;
    Fmodalidade_Specified: boolean;
    Fmercadoria: string;
    Fmercadoria_Specified: boolean;
    Fnumero_cartao: string;
    Fnumero_cartao_Specified: boolean;
    Fvencto_cartao: string;
    Fvencto_cartao_Specified: boolean;
    Fdigito_cartao: string;
    Fdigito_cartao_Specified: boolean;
    Fconversacao: string;
    Fconversacao_Specified: boolean;
    Fseguro_mm: string;
    Fseguro_mm_Specified: boolean;
    Ffone_preferencial: string;
    Ffone_preferencial_Specified: boolean;
    Fnumero_celular_mercadoria: string;
    Fnumero_celular_mercadoria_Specified: boolean;
    Fimei_celular_mercadoria: string;
    Fimei_celular_mercadoria_Specified: boolean;
    Fmercadoria_entregue: string;
    Fmercadoria_entregue_Specified: boolean;
    Fno_reserva_loja: string;
    Fno_reserva_loja_Specified: boolean;
    Fno_cmc7_cheques: string;
    Fno_cmc7_cheques_Specified: boolean;
    FclienteDiamante: string;
    FclienteDiamante_Specified: boolean;
    FnomeVendedor: string;
    FnomeVendedor_Specified: boolean;
    FcodigoVendedor: string;
    FcodigoVendedor_Specified: boolean;
    FplanoSic: string;
    FplanoSic_Specified: boolean;
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
    FSeguro: string;
    FSeguro_Specified: boolean;
    procedure Setproposta(Index: Integer; const Astring: string);
    function  proposta_Specified(Index: Integer): boolean;
    procedure Settipo_dcl(Index: Integer; const Astring: string);
    function  tipo_dcl_Specified(Index: Integer): boolean;
    procedure Setmodalidade(Index: Integer; const Astring: string);
    function  modalidade_Specified(Index: Integer): boolean;
    procedure Setmercadoria(Index: Integer; const Astring: string);
    function  mercadoria_Specified(Index: Integer): boolean;
    procedure Setnumero_cartao(Index: Integer; const Astring: string);
    function  numero_cartao_Specified(Index: Integer): boolean;
    procedure Setvencto_cartao(Index: Integer; const Astring: string);
    function  vencto_cartao_Specified(Index: Integer): boolean;
    procedure Setdigito_cartao(Index: Integer; const Astring: string);
    function  digito_cartao_Specified(Index: Integer): boolean;
    procedure Setconversacao(Index: Integer; const Astring: string);
    function  conversacao_Specified(Index: Integer): boolean;
    procedure Setseguro_mm(Index: Integer; const Astring: string);
    function  seguro_mm_Specified(Index: Integer): boolean;
    procedure Setfone_preferencial(Index: Integer; const Astring: string);
    function  fone_preferencial_Specified(Index: Integer): boolean;
    procedure Setnumero_celular_mercadoria(Index: Integer; const Astring: string);
    function  numero_celular_mercadoria_Specified(Index: Integer): boolean;
    procedure Setimei_celular_mercadoria(Index: Integer; const Astring: string);
    function  imei_celular_mercadoria_Specified(Index: Integer): boolean;
    procedure Setmercadoria_entregue(Index: Integer; const Astring: string);
    function  mercadoria_entregue_Specified(Index: Integer): boolean;
    procedure Setno_reserva_loja(Index: Integer; const Astring: string);
    function  no_reserva_loja_Specified(Index: Integer): boolean;
    procedure Setno_cmc7_cheques(Index: Integer; const Astring: string);
    function  no_cmc7_cheques_Specified(Index: Integer): boolean;
    procedure SetclienteDiamante(Index: Integer; const Astring: string);
    function  clienteDiamante_Specified(Index: Integer): boolean;
    procedure SetnomeVendedor(Index: Integer; const Astring: string);
    function  nomeVendedor_Specified(Index: Integer): boolean;
    procedure SetcodigoVendedor(Index: Integer; const Astring: string);
    function  codigoVendedor_Specified(Index: Integer): boolean;
    procedure SetplanoSic(Index: Integer; const Astring: string);
    function  planoSic_Specified(Index: Integer): boolean;
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
    procedure SetSeguro(Index: Integer; const Astring: string);
    function  Seguro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property proposta:                  string       Index (IS_OPTN) read Fproposta write Setproposta stored proposta_Specified;
    property loja:                      Integer      read Floja write Floja;
    property qt_parcela:                Integer      read Fqt_parcela write Fqt_parcela;
    property cd_pedido:                 Integer      read Fcd_pedido write Fcd_pedido;
    property idtabela:                  Integer      read Fidtabela write Fidtabela;
    property cd_tipo_financ:            Integer      read Fcd_tipo_financ write Fcd_tipo_financ;
    property id_lj_tabela:              Integer      read Fid_lj_tabela write Fid_lj_tabela;
    property cd_empresa:                Integer      read Fcd_empresa write Fcd_empresa;
    property vl_compra:                 Double       read Fvl_compra write Fvl_compra;
    property vl_entrada:                Double       read Fvl_entrada write Fvl_entrada;
    property vl_parcela:                Double       read Fvl_parcela write Fvl_parcela;
    property vl_juros:                  Double       read Fvl_juros write Fvl_juros;
    property vl_juros_rev:              Double       read Fvl_juros_rev write Fvl_juros_rev;
    property vl_tac:                    Double       read Fvl_tac write Fvl_tac;
    property vl_doc:                    Double       read Fvl_doc write Fvl_doc;
    property vl_financiado:             Double       read Fvl_financiado write Fvl_financiado;
    property vl_iof:                    Double       read Fvl_iof write Fvl_iof;
    property vl_dcl:                    Double       read Fvl_dcl write Fvl_dcl;
    property vl_retencao:               Double       read Fvl_retencao write Fvl_retencao;
    property vl_taxaret:                Double       read Fvl_taxaret write Fvl_taxaret;
    property fator_efetivo:             Double       read Ffator_efetivo write Ffator_efetivo;
    property fator_rev:                 Double       read Ffator_rev write Ffator_rev;
    property fator:                     Double       read Ffator write Ffator;
    property vl_comissao_overprice:     Double       read Fvl_comissao_overprice write Fvl_comissao_overprice;
    property TACComissaoPercentual:     Double       read FTACComissaoPercentual write FTACComissaoPercentual;
    property TacComissaoValor:          Double       read FTacComissaoValor write FTacComissaoValor;
    property EPComissaoPercentual:      Double       read FEPComissaoPercentual write FEPComissaoPercentual;
    property dt_compra:                 TXSDateTime  read Fdt_compra write Fdt_compra;
    property dt_pri_vencto:             TXSDateTime  read Fdt_pri_vencto write Fdt_pri_vencto;
    property tipo_dcl:                  string       Index (IS_OPTN) read Ftipo_dcl write Settipo_dcl stored tipo_dcl_Specified;
    property modalidade:                string       Index (IS_OPTN) read Fmodalidade write Setmodalidade stored modalidade_Specified;
    property mercadoria:                string       Index (IS_OPTN) read Fmercadoria write Setmercadoria stored mercadoria_Specified;
    property numero_cartao:             string       Index (IS_OPTN) read Fnumero_cartao write Setnumero_cartao stored numero_cartao_Specified;
    property vencto_cartao:             string       Index (IS_OPTN) read Fvencto_cartao write Setvencto_cartao stored vencto_cartao_Specified;
    property digito_cartao:             string       Index (IS_OPTN) read Fdigito_cartao write Setdigito_cartao stored digito_cartao_Specified;
    property conversacao:               string       Index (IS_OPTN) read Fconversacao write Setconversacao stored conversacao_Specified;
    property seguro_mm:                 string       Index (IS_OPTN) read Fseguro_mm write Setseguro_mm stored seguro_mm_Specified;
    property fone_preferencial:         string       Index (IS_OPTN) read Ffone_preferencial write Setfone_preferencial stored fone_preferencial_Specified;
    property numero_celular_mercadoria: string       Index (IS_OPTN) read Fnumero_celular_mercadoria write Setnumero_celular_mercadoria stored numero_celular_mercadoria_Specified;
    property imei_celular_mercadoria:   string       Index (IS_OPTN) read Fimei_celular_mercadoria write Setimei_celular_mercadoria stored imei_celular_mercadoria_Specified;
    property mercadoria_entregue:       string       Index (IS_OPTN) read Fmercadoria_entregue write Setmercadoria_entregue stored mercadoria_entregue_Specified;
    property no_reserva_loja:           string       Index (IS_OPTN) read Fno_reserva_loja write Setno_reserva_loja stored no_reserva_loja_Specified;
    property no_cmc7_cheques:           string       Index (IS_OPTN) read Fno_cmc7_cheques write Setno_cmc7_cheques stored no_cmc7_cheques_Specified;
    property clienteDiamante:           string       Index (IS_OPTN) read FclienteDiamante write SetclienteDiamante stored clienteDiamante_Specified;
    property nomeVendedor:              string       Index (IS_OPTN) read FnomeVendedor write SetnomeVendedor stored nomeVendedor_Specified;
    property codigoVendedor:            string       Index (IS_OPTN) read FcodigoVendedor write SetcodigoVendedor stored codigoVendedor_Specified;
    property planoSic:                  string       Index (IS_OPTN) read FplanoSic write SetplanoSic stored planoSic_Specified;
    property CorrespondenteCpf:         string       Index (IS_OPTN) read FCorrespondenteCpf write SetCorrespondenteCpf stored CorrespondenteCpf_Specified;
    property CorrespondenteNome:        string       Index (IS_OPTN) read FCorrespondenteNome write SetCorrespondenteNome stored CorrespondenteNome_Specified;
    property ArogoCPF:                  string       Index (IS_OPTN) read FArogoCPF write SetArogoCPF stored ArogoCPF_Specified;
    property ArogoNome:                 string       Index (IS_OPTN) read FArogoNome write SetArogoNome stored ArogoNome_Specified;
    property ArogoParentesco:           string       Index (IS_OPTN) read FArogoParentesco write SetArogoParentesco stored ArogoParentesco_Specified;
    property Seguro:                    string       Index (IS_OPTN) read FSeguro write SetSeguro stored Seguro_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoMensagem, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoMensagem2 = class(TRemotable)
  private
    Fsituacao: string;
    Fsituacao_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    Ftipo: string;
    Ftipo_Specified: boolean;
    procedure Setsituacao(Index: Integer; const Astring: string);
    function  situacao_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure Settipo(Index: Integer; const Astring: string);
    function  tipo_Specified(Index: Integer): boolean;
  published
    property situacao: string  Index (IS_OPTN) read Fsituacao write Setsituacao stored situacao_Specified;
    property mensagem: string  Index (IS_OPTN) read Fmensagem write Setmensagem stored mensagem_Specified;
    property tipo:     string  Index (IS_OPTN) read Ftipo write Settipo stored tipo_Specified;
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
  // XML       : stCartao, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stCartao = class(TRemotable)
  private
    Floja: Integer;
    FtipoCartao: Integer;
    FnomeImpressaoCartaoTitular: string;
    FnomeImpressaoCartaoTitular_Specified: boolean;
    FtipoPessoa: string;
    FtipoPessoa_Specified: boolean;
    FenderecoEnvioFatura: string;
    FenderecoEnvioFatura_Specified: boolean;
    Femissor: Integer;
    FdataVencimento: Integer;
    FenvioPlastico: string;
    FenvioPlastico_Specified: boolean;
    FnomeImpressaoCartao1: string;
    FnomeImpressaoCartao1_Specified: boolean;
    FdataNascimento1: TXSDateTime;
    FtipoPessoa1: string;
    FtipoPessoa1_Specified: boolean;
    FnomeImpressaoCartao2: string;
    FnomeImpressaoCartao2_Specified: boolean;
    FdataNascimento2: TXSDateTime;
    FtipoPessoa2: string;
    FtipoPessoa2_Specified: boolean;
    procedure SetnomeImpressaoCartaoTitular(Index: Integer; const Astring: string);
    function  nomeImpressaoCartaoTitular_Specified(Index: Integer): boolean;
    procedure SettipoPessoa(Index: Integer; const Astring: string);
    function  tipoPessoa_Specified(Index: Integer): boolean;
    procedure SetenderecoEnvioFatura(Index: Integer; const Astring: string);
    function  enderecoEnvioFatura_Specified(Index: Integer): boolean;
    procedure SetenvioPlastico(Index: Integer; const Astring: string);
    function  envioPlastico_Specified(Index: Integer): boolean;
    procedure SetnomeImpressaoCartao1(Index: Integer; const Astring: string);
    function  nomeImpressaoCartao1_Specified(Index: Integer): boolean;
    procedure SettipoPessoa1(Index: Integer; const Astring: string);
    function  tipoPessoa1_Specified(Index: Integer): boolean;
    procedure SetnomeImpressaoCartao2(Index: Integer; const Astring: string);
    function  nomeImpressaoCartao2_Specified(Index: Integer): boolean;
    procedure SettipoPessoa2(Index: Integer; const Astring: string);
    function  tipoPessoa2_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property loja:                       Integer      read Floja write Floja;
    property tipoCartao:                 Integer      read FtipoCartao write FtipoCartao;
    property nomeImpressaoCartaoTitular: string       Index (IS_OPTN) read FnomeImpressaoCartaoTitular write SetnomeImpressaoCartaoTitular stored nomeImpressaoCartaoTitular_Specified;
    property tipoPessoa:                 string       Index (IS_OPTN) read FtipoPessoa write SettipoPessoa stored tipoPessoa_Specified;
    property enderecoEnvioFatura:        string       Index (IS_OPTN) read FenderecoEnvioFatura write SetenderecoEnvioFatura stored enderecoEnvioFatura_Specified;
    property emissor:                    Integer      read Femissor write Femissor;
    property dataVencimento:             Integer      read FdataVencimento write FdataVencimento;
    property envioPlastico:              string       Index (IS_OPTN) read FenvioPlastico write SetenvioPlastico stored envioPlastico_Specified;
    property nomeImpressaoCartao1:       string       Index (IS_OPTN) read FnomeImpressaoCartao1 write SetnomeImpressaoCartao1 stored nomeImpressaoCartao1_Specified;
    property dataNascimento1:            TXSDateTime  read FdataNascimento1 write FdataNascimento1;
    property tipoPessoa1:                string       Index (IS_OPTN) read FtipoPessoa1 write SettipoPessoa1 stored tipoPessoa1_Specified;
    property nomeImpressaoCartao2:       string       Index (IS_OPTN) read FnomeImpressaoCartao2 write SetnomeImpressaoCartao2 stored nomeImpressaoCartao2_Specified;
    property dataNascimento2:            TXSDateTime  read FdataNascimento2 write FdataNascimento2;
    property tipoPessoa2:                string       Index (IS_OPTN) read FtipoPessoa2 write SettipoPessoa2 stored tipoPessoa2_Specified;
  end;



  // ************************************************************************ //
  // XML       : stPJ, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stPJ = class(TRemotable)
  private
    FID: string;
    FID_Specified: boolean;
    FCNPJ: string;
    FCNPJ_Specified: boolean;
    FRazaoSocial: string;
    FRazaoSocial_Specified: boolean;
    FNomeFantasia: string;
    FNomeFantasia_Specified: boolean;
    FInscEstadual: string;
    FInscEstadual_Specified: boolean;
    FDataFundacao: string;
    FDataFundacao_Specified: boolean;
    FRamoAtividade: string;
    FRamoAtividade_Specified: boolean;
    FCapitalSocial: string;
    FCapitalSocial_Specified: boolean;
    FCapitalImoveis: string;
    FCapitalImoveis_Specified: boolean;
    FCapitalEquipamento: string;
    FCapitalEquipamento_Specified: boolean;
    FCapitalVeiculos: string;
    FCapitalVeiculos_Specified: boolean;
    FFaturamentoMensal: string;
    FFaturamentoMensal_Specified: boolean;
    FNoFuncionarios: string;
    FNoFuncionarios_Specified: boolean;
    FValorEstoque: string;
    FValorEstoque_Specified: boolean;
    FCapitalGiro: string;
    FCapitalGiro_Specified: boolean;
    FValorFolhaPgto: string;
    FValorFolhaPgto_Specified: boolean;
    FEmail: string;
    FEmail_Specified: boolean;
    FEndereco: string;
    FEndereco_Specified: boolean;
    FNumero: string;
    FNumero_Specified: boolean;
    FComplemento: string;
    FComplemento_Specified: boolean;
    FBairro: string;
    FBairro_Specified: boolean;
    FCidade: string;
    FCidade_Specified: boolean;
    FUF: string;
    FUF_Specified: boolean;
    FCEP: string;
    FCEP_Specified: boolean;
    FTempo: string;
    FTempo_Specified: boolean;
    FDDD: string;
    FDDD_Specified: boolean;
    FTelefone: string;
    FTelefone_Specified: boolean;
    FDDDFax: string;
    FDDDFax_Specified: boolean;
    FTelefoneFax: string;
    FTelefoneFax_Specified: boolean;
    FNomeSoc1: string;
    FNomeSoc1_Specified: boolean;
    FNomeSoc2: string;
    FNomeSoc2_Specified: boolean;
    FNomeSoc3: string;
    FNomeSoc3_Specified: boolean;
    FNomeSoc4: string;
    FNomeSoc4_Specified: boolean;
    FCPFSoc1: string;
    FCPFSoc1_Specified: boolean;
    FCPFSoc2: string;
    FCPFSoc2_Specified: boolean;
    FCPFSoc3: string;
    FCPFSoc3_Specified: boolean;
    FCPFSoc4: string;
    FCPFSoc4_Specified: boolean;
    FRGSoc1: string;
    FRGSoc1_Specified: boolean;
    FRGSoc2: string;
    FRGSoc2_Specified: boolean;
    FRGSoc3: string;
    FRGSoc3_Specified: boolean;
    FRGSoc4: string;
    FRGSoc4_Specified: boolean;
    FCotaSoc1: string;
    FCotaSoc1_Specified: boolean;
    FCotaSoc2: string;
    FCotaSoc2_Specified: boolean;
    FCotaSoc3: string;
    FCotaSoc3_Specified: boolean;
    FCotaSoc4: string;
    FCotaSoc4_Specified: boolean;
    FDtNascimentoSoc1: string;
    FDtNascimentoSoc1_Specified: boolean;
    FDtNascimentoSoc2: string;
    FDtNascimentoSoc2_Specified: boolean;
    FDtNascimentoSoc3: string;
    FDtNascimentoSoc3_Specified: boolean;
    FDtNascimentoSoc4: string;
    FDtNascimentoSoc4_Specified: boolean;
    FEnderecoSoc1: string;
    FEnderecoSoc1_Specified: boolean;
    FEnderecoSoc2: string;
    FEnderecoSoc2_Specified: boolean;
    FEnderecoSoc3: string;
    FEnderecoSoc3_Specified: boolean;
    FNumeroSoc1: string;
    FNumeroSoc1_Specified: boolean;
    FNumeroSoc2: string;
    FNumeroSoc2_Specified: boolean;
    FNumeroSoc3: string;
    FNumeroSoc3_Specified: boolean;
    FComplementoSoc1: string;
    FComplementoSoc1_Specified: boolean;
    FComplementoSoc2: string;
    FComplementoSoc2_Specified: boolean;
    FComplementoSoc3: string;
    FComplementoSoc3_Specified: boolean;
    FBairroSoc1: string;
    FBairroSoc1_Specified: boolean;
    FBairroSoc2: string;
    FBairroSoc2_Specified: boolean;
    FBairroSoc3: string;
    FBairroSoc3_Specified: boolean;
    FCidadeSoc1: string;
    FCidadeSoc1_Specified: boolean;
    FCidadeSoc2: string;
    FCidadeSoc2_Specified: boolean;
    FCidadeSoc3: string;
    FCidadeSoc3_Specified: boolean;
    FUFSoc1: string;
    FUFSoc1_Specified: boolean;
    FUFSoc2: string;
    FUFSoc2_Specified: boolean;
    FUFSoc3: string;
    FUFSoc3_Specified: boolean;
    FDDDTelefoneSoc1: string;
    FDDDTelefoneSoc1_Specified: boolean;
    FDDDTelefoneSoc2: string;
    FDDDTelefoneSoc2_Specified: boolean;
    FDDDTelefoneSoc3: string;
    FDDDTelefoneSoc3_Specified: boolean;
    FNoTelefoneSoc1: string;
    FNoTelefoneSoc1_Specified: boolean;
    FNoTelefoneSoc2: string;
    FNoTelefoneSoc2_Specified: boolean;
    FNoTelefoneSoc3: string;
    FNoTelefoneSoc3_Specified: boolean;
    FTipoPoderSoc1: string;
    FTipoPoderSoc1_Specified: boolean;
    FTipoPoderSoc2: string;
    FTipoPoderSoc2_Specified: boolean;
    FTipoPoderSoc3: string;
    FTipoPoderSoc3_Specified: boolean;
    FTipoPoderSoc4: string;
    FTipoPoderSoc4_Specified: boolean;
    FLocalizacao1: string;
    FLocalizacao1_Specified: boolean;
    FLocalizacao2: string;
    FLocalizacao2_Specified: boolean;
    FAreaTerreno1: string;
    FAreaTerreno1_Specified: boolean;
    FAreaTerreno2: string;
    FAreaTerreno2_Specified: boolean;
    FAreaConstruida1: string;
    FAreaConstruida1_Specified: boolean;
    FAreaConstruida2: string;
    FAreaConstruida2_Specified: boolean;
    FValor1: string;
    FValor1_Specified: boolean;
    FValor2: string;
    FValor2_Specified: boolean;
    FCNPJPart: string;
    FCNPJPart_Specified: boolean;
    FRazaoSocialPart: string;
    FRazaoSocialPart_Specified: boolean;
    FNomeFantasiaPart: string;
    FNomeFantasiaPart_Specified: boolean;
    FInscEstadualPart: string;
    FInscEstadualPart_Specified: boolean;
    FDataFundacaoPart: string;
    FDataFundacaoPart_Specified: boolean;
    FRamoAtividadePart: string;
    FRamoAtividadePart_Specified: boolean;
    FCapitalSocialPart: string;
    FCapitalSocialPart_Specified: boolean;
    FNome1: string;
    FNome1_Specified: boolean;
    FDDD1: string;
    FDDD1_Specified: boolean;
    FFone1: string;
    FFone1_Specified: boolean;
    FRamal1: string;
    FRamal1_Specified: boolean;
    FNome2: string;
    FNome2_Specified: boolean;
    FDDD2: string;
    FDDD2_Specified: boolean;
    FFone2: string;
    FFone2_Specified: boolean;
    FRamal2: string;
    FRamal2_Specified: boolean;
    FNome3: string;
    FNome3_Specified: boolean;
    FDDD3: string;
    FDDD3_Specified: boolean;
    FFone3: string;
    FFone3_Specified: boolean;
    FRamal3: string;
    FRamal3_Specified: boolean;
    FNome4: string;
    FNome4_Specified: boolean;
    FDDD4: string;
    FDDD4_Specified: boolean;
    FFone4: string;
    FFone4_Specified: boolean;
    FRamal4: string;
    FRamal4_Specified: boolean;
    FNomeCom1: string;
    FNomeCom1_Specified: boolean;
    FDDDCom1: string;
    FDDDCom1_Specified: boolean;
    FFoneCom1: string;
    FFoneCom1_Specified: boolean;
    FRamalCom1: string;
    FRamalCom1_Specified: boolean;
    FNomeCom2: string;
    FNomeCom2_Specified: boolean;
    FDDDCom2: string;
    FDDDCom2_Specified: boolean;
    FFoneCom2: string;
    FFoneCom2_Specified: boolean;
    FRamalCom2: string;
    FRamalCom2_Specified: boolean;
    FBanco: string;
    FBanco_Specified: boolean;
    FAgencia: string;
    FAgencia_Specified: boolean;
    FConta: string;
    FConta_Specified: boolean;
    FEspecial: string;
    FEspecial_Specified: boolean;
    FContadesde: string;
    FContadesde_Specified: boolean;
    FCidadeConta: string;
    FCidadeConta_Specified: boolean;
    FNomeContador: string;
    FNomeContador_Specified: boolean;
    FDDDContador: string;
    FDDDContador_Specified: boolean;
    FFoneContador: string;
    FFoneContador_Specified: boolean;
    FRamalContador: string;
    FRamalContador_Specified: boolean;
    procedure SetID(Index: Integer; const Astring: string);
    function  ID_Specified(Index: Integer): boolean;
    procedure SetCNPJ(Index: Integer; const Astring: string);
    function  CNPJ_Specified(Index: Integer): boolean;
    procedure SetRazaoSocial(Index: Integer; const Astring: string);
    function  RazaoSocial_Specified(Index: Integer): boolean;
    procedure SetNomeFantasia(Index: Integer; const Astring: string);
    function  NomeFantasia_Specified(Index: Integer): boolean;
    procedure SetInscEstadual(Index: Integer; const Astring: string);
    function  InscEstadual_Specified(Index: Integer): boolean;
    procedure SetDataFundacao(Index: Integer; const Astring: string);
    function  DataFundacao_Specified(Index: Integer): boolean;
    procedure SetRamoAtividade(Index: Integer; const Astring: string);
    function  RamoAtividade_Specified(Index: Integer): boolean;
    procedure SetCapitalSocial(Index: Integer; const Astring: string);
    function  CapitalSocial_Specified(Index: Integer): boolean;
    procedure SetCapitalImoveis(Index: Integer; const Astring: string);
    function  CapitalImoveis_Specified(Index: Integer): boolean;
    procedure SetCapitalEquipamento(Index: Integer; const Astring: string);
    function  CapitalEquipamento_Specified(Index: Integer): boolean;
    procedure SetCapitalVeiculos(Index: Integer; const Astring: string);
    function  CapitalVeiculos_Specified(Index: Integer): boolean;
    procedure SetFaturamentoMensal(Index: Integer; const Astring: string);
    function  FaturamentoMensal_Specified(Index: Integer): boolean;
    procedure SetNoFuncionarios(Index: Integer; const Astring: string);
    function  NoFuncionarios_Specified(Index: Integer): boolean;
    procedure SetValorEstoque(Index: Integer; const Astring: string);
    function  ValorEstoque_Specified(Index: Integer): boolean;
    procedure SetCapitalGiro(Index: Integer; const Astring: string);
    function  CapitalGiro_Specified(Index: Integer): boolean;
    procedure SetValorFolhaPgto(Index: Integer; const Astring: string);
    function  ValorFolhaPgto_Specified(Index: Integer): boolean;
    procedure SetEmail(Index: Integer; const Astring: string);
    function  Email_Specified(Index: Integer): boolean;
    procedure SetEndereco(Index: Integer; const Astring: string);
    function  Endereco_Specified(Index: Integer): boolean;
    procedure SetNumero(Index: Integer; const Astring: string);
    function  Numero_Specified(Index: Integer): boolean;
    procedure SetComplemento(Index: Integer; const Astring: string);
    function  Complemento_Specified(Index: Integer): boolean;
    procedure SetBairro(Index: Integer; const Astring: string);
    function  Bairro_Specified(Index: Integer): boolean;
    procedure SetCidade(Index: Integer; const Astring: string);
    function  Cidade_Specified(Index: Integer): boolean;
    procedure SetUF(Index: Integer; const Astring: string);
    function  UF_Specified(Index: Integer): boolean;
    procedure SetCEP(Index: Integer; const Astring: string);
    function  CEP_Specified(Index: Integer): boolean;
    procedure SetTempo(Index: Integer; const Astring: string);
    function  Tempo_Specified(Index: Integer): boolean;
    procedure SetDDD(Index: Integer; const Astring: string);
    function  DDD_Specified(Index: Integer): boolean;
    procedure SetTelefone(Index: Integer; const Astring: string);
    function  Telefone_Specified(Index: Integer): boolean;
    procedure SetDDDFax(Index: Integer; const Astring: string);
    function  DDDFax_Specified(Index: Integer): boolean;
    procedure SetTelefoneFax(Index: Integer; const Astring: string);
    function  TelefoneFax_Specified(Index: Integer): boolean;
    procedure SetNomeSoc1(Index: Integer; const Astring: string);
    function  NomeSoc1_Specified(Index: Integer): boolean;
    procedure SetNomeSoc2(Index: Integer; const Astring: string);
    function  NomeSoc2_Specified(Index: Integer): boolean;
    procedure SetNomeSoc3(Index: Integer; const Astring: string);
    function  NomeSoc3_Specified(Index: Integer): boolean;
    procedure SetNomeSoc4(Index: Integer; const Astring: string);
    function  NomeSoc4_Specified(Index: Integer): boolean;
    procedure SetCPFSoc1(Index: Integer; const Astring: string);
    function  CPFSoc1_Specified(Index: Integer): boolean;
    procedure SetCPFSoc2(Index: Integer; const Astring: string);
    function  CPFSoc2_Specified(Index: Integer): boolean;
    procedure SetCPFSoc3(Index: Integer; const Astring: string);
    function  CPFSoc3_Specified(Index: Integer): boolean;
    procedure SetCPFSoc4(Index: Integer; const Astring: string);
    function  CPFSoc4_Specified(Index: Integer): boolean;
    procedure SetRGSoc1(Index: Integer; const Astring: string);
    function  RGSoc1_Specified(Index: Integer): boolean;
    procedure SetRGSoc2(Index: Integer; const Astring: string);
    function  RGSoc2_Specified(Index: Integer): boolean;
    procedure SetRGSoc3(Index: Integer; const Astring: string);
    function  RGSoc3_Specified(Index: Integer): boolean;
    procedure SetRGSoc4(Index: Integer; const Astring: string);
    function  RGSoc4_Specified(Index: Integer): boolean;
    procedure SetCotaSoc1(Index: Integer; const Astring: string);
    function  CotaSoc1_Specified(Index: Integer): boolean;
    procedure SetCotaSoc2(Index: Integer; const Astring: string);
    function  CotaSoc2_Specified(Index: Integer): boolean;
    procedure SetCotaSoc3(Index: Integer; const Astring: string);
    function  CotaSoc3_Specified(Index: Integer): boolean;
    procedure SetCotaSoc4(Index: Integer; const Astring: string);
    function  CotaSoc4_Specified(Index: Integer): boolean;
    procedure SetDtNascimentoSoc1(Index: Integer; const Astring: string);
    function  DtNascimentoSoc1_Specified(Index: Integer): boolean;
    procedure SetDtNascimentoSoc2(Index: Integer; const Astring: string);
    function  DtNascimentoSoc2_Specified(Index: Integer): boolean;
    procedure SetDtNascimentoSoc3(Index: Integer; const Astring: string);
    function  DtNascimentoSoc3_Specified(Index: Integer): boolean;
    procedure SetDtNascimentoSoc4(Index: Integer; const Astring: string);
    function  DtNascimentoSoc4_Specified(Index: Integer): boolean;
    procedure SetEnderecoSoc1(Index: Integer; const Astring: string);
    function  EnderecoSoc1_Specified(Index: Integer): boolean;
    procedure SetEnderecoSoc2(Index: Integer; const Astring: string);
    function  EnderecoSoc2_Specified(Index: Integer): boolean;
    procedure SetEnderecoSoc3(Index: Integer; const Astring: string);
    function  EnderecoSoc3_Specified(Index: Integer): boolean;
    procedure SetNumeroSoc1(Index: Integer; const Astring: string);
    function  NumeroSoc1_Specified(Index: Integer): boolean;
    procedure SetNumeroSoc2(Index: Integer; const Astring: string);
    function  NumeroSoc2_Specified(Index: Integer): boolean;
    procedure SetNumeroSoc3(Index: Integer; const Astring: string);
    function  NumeroSoc3_Specified(Index: Integer): boolean;
    procedure SetComplementoSoc1(Index: Integer; const Astring: string);
    function  ComplementoSoc1_Specified(Index: Integer): boolean;
    procedure SetComplementoSoc2(Index: Integer; const Astring: string);
    function  ComplementoSoc2_Specified(Index: Integer): boolean;
    procedure SetComplementoSoc3(Index: Integer; const Astring: string);
    function  ComplementoSoc3_Specified(Index: Integer): boolean;
    procedure SetBairroSoc1(Index: Integer; const Astring: string);
    function  BairroSoc1_Specified(Index: Integer): boolean;
    procedure SetBairroSoc2(Index: Integer; const Astring: string);
    function  BairroSoc2_Specified(Index: Integer): boolean;
    procedure SetBairroSoc3(Index: Integer; const Astring: string);
    function  BairroSoc3_Specified(Index: Integer): boolean;
    procedure SetCidadeSoc1(Index: Integer; const Astring: string);
    function  CidadeSoc1_Specified(Index: Integer): boolean;
    procedure SetCidadeSoc2(Index: Integer; const Astring: string);
    function  CidadeSoc2_Specified(Index: Integer): boolean;
    procedure SetCidadeSoc3(Index: Integer; const Astring: string);
    function  CidadeSoc3_Specified(Index: Integer): boolean;
    procedure SetUFSoc1(Index: Integer; const Astring: string);
    function  UFSoc1_Specified(Index: Integer): boolean;
    procedure SetUFSoc2(Index: Integer; const Astring: string);
    function  UFSoc2_Specified(Index: Integer): boolean;
    procedure SetUFSoc3(Index: Integer; const Astring: string);
    function  UFSoc3_Specified(Index: Integer): boolean;
    procedure SetDDDTelefoneSoc1(Index: Integer; const Astring: string);
    function  DDDTelefoneSoc1_Specified(Index: Integer): boolean;
    procedure SetDDDTelefoneSoc2(Index: Integer; const Astring: string);
    function  DDDTelefoneSoc2_Specified(Index: Integer): boolean;
    procedure SetDDDTelefoneSoc3(Index: Integer; const Astring: string);
    function  DDDTelefoneSoc3_Specified(Index: Integer): boolean;
    procedure SetNoTelefoneSoc1(Index: Integer; const Astring: string);
    function  NoTelefoneSoc1_Specified(Index: Integer): boolean;
    procedure SetNoTelefoneSoc2(Index: Integer; const Astring: string);
    function  NoTelefoneSoc2_Specified(Index: Integer): boolean;
    procedure SetNoTelefoneSoc3(Index: Integer; const Astring: string);
    function  NoTelefoneSoc3_Specified(Index: Integer): boolean;
    procedure SetTipoPoderSoc1(Index: Integer; const Astring: string);
    function  TipoPoderSoc1_Specified(Index: Integer): boolean;
    procedure SetTipoPoderSoc2(Index: Integer; const Astring: string);
    function  TipoPoderSoc2_Specified(Index: Integer): boolean;
    procedure SetTipoPoderSoc3(Index: Integer; const Astring: string);
    function  TipoPoderSoc3_Specified(Index: Integer): boolean;
    procedure SetTipoPoderSoc4(Index: Integer; const Astring: string);
    function  TipoPoderSoc4_Specified(Index: Integer): boolean;
    procedure SetLocalizacao1(Index: Integer; const Astring: string);
    function  Localizacao1_Specified(Index: Integer): boolean;
    procedure SetLocalizacao2(Index: Integer; const Astring: string);
    function  Localizacao2_Specified(Index: Integer): boolean;
    procedure SetAreaTerreno1(Index: Integer; const Astring: string);
    function  AreaTerreno1_Specified(Index: Integer): boolean;
    procedure SetAreaTerreno2(Index: Integer; const Astring: string);
    function  AreaTerreno2_Specified(Index: Integer): boolean;
    procedure SetAreaConstruida1(Index: Integer; const Astring: string);
    function  AreaConstruida1_Specified(Index: Integer): boolean;
    procedure SetAreaConstruida2(Index: Integer; const Astring: string);
    function  AreaConstruida2_Specified(Index: Integer): boolean;
    procedure SetValor1(Index: Integer; const Astring: string);
    function  Valor1_Specified(Index: Integer): boolean;
    procedure SetValor2(Index: Integer; const Astring: string);
    function  Valor2_Specified(Index: Integer): boolean;
    procedure SetCNPJPart(Index: Integer; const Astring: string);
    function  CNPJPart_Specified(Index: Integer): boolean;
    procedure SetRazaoSocialPart(Index: Integer; const Astring: string);
    function  RazaoSocialPart_Specified(Index: Integer): boolean;
    procedure SetNomeFantasiaPart(Index: Integer; const Astring: string);
    function  NomeFantasiaPart_Specified(Index: Integer): boolean;
    procedure SetInscEstadualPart(Index: Integer; const Astring: string);
    function  InscEstadualPart_Specified(Index: Integer): boolean;
    procedure SetDataFundacaoPart(Index: Integer; const Astring: string);
    function  DataFundacaoPart_Specified(Index: Integer): boolean;
    procedure SetRamoAtividadePart(Index: Integer; const Astring: string);
    function  RamoAtividadePart_Specified(Index: Integer): boolean;
    procedure SetCapitalSocialPart(Index: Integer; const Astring: string);
    function  CapitalSocialPart_Specified(Index: Integer): boolean;
    procedure SetNome1(Index: Integer; const Astring: string);
    function  Nome1_Specified(Index: Integer): boolean;
    procedure SetDDD1(Index: Integer; const Astring: string);
    function  DDD1_Specified(Index: Integer): boolean;
    procedure SetFone1(Index: Integer; const Astring: string);
    function  Fone1_Specified(Index: Integer): boolean;
    procedure SetRamal1(Index: Integer; const Astring: string);
    function  Ramal1_Specified(Index: Integer): boolean;
    procedure SetNome2(Index: Integer; const Astring: string);
    function  Nome2_Specified(Index: Integer): boolean;
    procedure SetDDD2(Index: Integer; const Astring: string);
    function  DDD2_Specified(Index: Integer): boolean;
    procedure SetFone2(Index: Integer; const Astring: string);
    function  Fone2_Specified(Index: Integer): boolean;
    procedure SetRamal2(Index: Integer; const Astring: string);
    function  Ramal2_Specified(Index: Integer): boolean;
    procedure SetNome3(Index: Integer; const Astring: string);
    function  Nome3_Specified(Index: Integer): boolean;
    procedure SetDDD3(Index: Integer; const Astring: string);
    function  DDD3_Specified(Index: Integer): boolean;
    procedure SetFone3(Index: Integer; const Astring: string);
    function  Fone3_Specified(Index: Integer): boolean;
    procedure SetRamal3(Index: Integer; const Astring: string);
    function  Ramal3_Specified(Index: Integer): boolean;
    procedure SetNome4(Index: Integer; const Astring: string);
    function  Nome4_Specified(Index: Integer): boolean;
    procedure SetDDD4(Index: Integer; const Astring: string);
    function  DDD4_Specified(Index: Integer): boolean;
    procedure SetFone4(Index: Integer; const Astring: string);
    function  Fone4_Specified(Index: Integer): boolean;
    procedure SetRamal4(Index: Integer; const Astring: string);
    function  Ramal4_Specified(Index: Integer): boolean;
    procedure SetNomeCom1(Index: Integer; const Astring: string);
    function  NomeCom1_Specified(Index: Integer): boolean;
    procedure SetDDDCom1(Index: Integer; const Astring: string);
    function  DDDCom1_Specified(Index: Integer): boolean;
    procedure SetFoneCom1(Index: Integer; const Astring: string);
    function  FoneCom1_Specified(Index: Integer): boolean;
    procedure SetRamalCom1(Index: Integer; const Astring: string);
    function  RamalCom1_Specified(Index: Integer): boolean;
    procedure SetNomeCom2(Index: Integer; const Astring: string);
    function  NomeCom2_Specified(Index: Integer): boolean;
    procedure SetDDDCom2(Index: Integer; const Astring: string);
    function  DDDCom2_Specified(Index: Integer): boolean;
    procedure SetFoneCom2(Index: Integer; const Astring: string);
    function  FoneCom2_Specified(Index: Integer): boolean;
    procedure SetRamalCom2(Index: Integer; const Astring: string);
    function  RamalCom2_Specified(Index: Integer): boolean;
    procedure SetBanco(Index: Integer; const Astring: string);
    function  Banco_Specified(Index: Integer): boolean;
    procedure SetAgencia(Index: Integer; const Astring: string);
    function  Agencia_Specified(Index: Integer): boolean;
    procedure SetConta(Index: Integer; const Astring: string);
    function  Conta_Specified(Index: Integer): boolean;
    procedure SetEspecial(Index: Integer; const Astring: string);
    function  Especial_Specified(Index: Integer): boolean;
    procedure SetContadesde(Index: Integer; const Astring: string);
    function  Contadesde_Specified(Index: Integer): boolean;
    procedure SetCidadeConta(Index: Integer; const Astring: string);
    function  CidadeConta_Specified(Index: Integer): boolean;
    procedure SetNomeContador(Index: Integer; const Astring: string);
    function  NomeContador_Specified(Index: Integer): boolean;
    procedure SetDDDContador(Index: Integer; const Astring: string);
    function  DDDContador_Specified(Index: Integer): boolean;
    procedure SetFoneContador(Index: Integer; const Astring: string);
    function  FoneContador_Specified(Index: Integer): boolean;
    procedure SetRamalContador(Index: Integer; const Astring: string);
    function  RamalContador_Specified(Index: Integer): boolean;
  published
    property ID:                 string  Index (IS_OPTN) read FID write SetID stored ID_Specified;
    property CNPJ:               string  Index (IS_OPTN) read FCNPJ write SetCNPJ stored CNPJ_Specified;
    property RazaoSocial:        string  Index (IS_OPTN) read FRazaoSocial write SetRazaoSocial stored RazaoSocial_Specified;
    property NomeFantasia:       string  Index (IS_OPTN) read FNomeFantasia write SetNomeFantasia stored NomeFantasia_Specified;
    property InscEstadual:       string  Index (IS_OPTN) read FInscEstadual write SetInscEstadual stored InscEstadual_Specified;
    property DataFundacao:       string  Index (IS_OPTN) read FDataFundacao write SetDataFundacao stored DataFundacao_Specified;
    property RamoAtividade:      string  Index (IS_OPTN) read FRamoAtividade write SetRamoAtividade stored RamoAtividade_Specified;
    property CapitalSocial:      string  Index (IS_OPTN) read FCapitalSocial write SetCapitalSocial stored CapitalSocial_Specified;
    property CapitalImoveis:     string  Index (IS_OPTN) read FCapitalImoveis write SetCapitalImoveis stored CapitalImoveis_Specified;
    property CapitalEquipamento: string  Index (IS_OPTN) read FCapitalEquipamento write SetCapitalEquipamento stored CapitalEquipamento_Specified;
    property CapitalVeiculos:    string  Index (IS_OPTN) read FCapitalVeiculos write SetCapitalVeiculos stored CapitalVeiculos_Specified;
    property FaturamentoMensal:  string  Index (IS_OPTN) read FFaturamentoMensal write SetFaturamentoMensal stored FaturamentoMensal_Specified;
    property NoFuncionarios:     string  Index (IS_OPTN) read FNoFuncionarios write SetNoFuncionarios stored NoFuncionarios_Specified;
    property ValorEstoque:       string  Index (IS_OPTN) read FValorEstoque write SetValorEstoque stored ValorEstoque_Specified;
    property CapitalGiro:        string  Index (IS_OPTN) read FCapitalGiro write SetCapitalGiro stored CapitalGiro_Specified;
    property ValorFolhaPgto:     string  Index (IS_OPTN) read FValorFolhaPgto write SetValorFolhaPgto stored ValorFolhaPgto_Specified;
    property Email:              string  Index (IS_OPTN) read FEmail write SetEmail stored Email_Specified;
    property Endereco:           string  Index (IS_OPTN) read FEndereco write SetEndereco stored Endereco_Specified;
    property Numero:             string  Index (IS_OPTN) read FNumero write SetNumero stored Numero_Specified;
    property Complemento:        string  Index (IS_OPTN) read FComplemento write SetComplemento stored Complemento_Specified;
    property Bairro:             string  Index (IS_OPTN) read FBairro write SetBairro stored Bairro_Specified;
    property Cidade:             string  Index (IS_OPTN) read FCidade write SetCidade stored Cidade_Specified;
    property UF:                 string  Index (IS_OPTN) read FUF write SetUF stored UF_Specified;
    property CEP:                string  Index (IS_OPTN) read FCEP write SetCEP stored CEP_Specified;
    property Tempo:              string  Index (IS_OPTN) read FTempo write SetTempo stored Tempo_Specified;
    property DDD:                string  Index (IS_OPTN) read FDDD write SetDDD stored DDD_Specified;
    property Telefone:           string  Index (IS_OPTN) read FTelefone write SetTelefone stored Telefone_Specified;
    property DDDFax:             string  Index (IS_OPTN) read FDDDFax write SetDDDFax stored DDDFax_Specified;
    property TelefoneFax:        string  Index (IS_OPTN) read FTelefoneFax write SetTelefoneFax stored TelefoneFax_Specified;
    property NomeSoc1:           string  Index (IS_OPTN) read FNomeSoc1 write SetNomeSoc1 stored NomeSoc1_Specified;
    property NomeSoc2:           string  Index (IS_OPTN) read FNomeSoc2 write SetNomeSoc2 stored NomeSoc2_Specified;
    property NomeSoc3:           string  Index (IS_OPTN) read FNomeSoc3 write SetNomeSoc3 stored NomeSoc3_Specified;
    property NomeSoc4:           string  Index (IS_OPTN) read FNomeSoc4 write SetNomeSoc4 stored NomeSoc4_Specified;
    property CPFSoc1:            string  Index (IS_OPTN) read FCPFSoc1 write SetCPFSoc1 stored CPFSoc1_Specified;
    property CPFSoc2:            string  Index (IS_OPTN) read FCPFSoc2 write SetCPFSoc2 stored CPFSoc2_Specified;
    property CPFSoc3:            string  Index (IS_OPTN) read FCPFSoc3 write SetCPFSoc3 stored CPFSoc3_Specified;
    property CPFSoc4:            string  Index (IS_OPTN) read FCPFSoc4 write SetCPFSoc4 stored CPFSoc4_Specified;
    property RGSoc1:             string  Index (IS_OPTN) read FRGSoc1 write SetRGSoc1 stored RGSoc1_Specified;
    property RGSoc2:             string  Index (IS_OPTN) read FRGSoc2 write SetRGSoc2 stored RGSoc2_Specified;
    property RGSoc3:             string  Index (IS_OPTN) read FRGSoc3 write SetRGSoc3 stored RGSoc3_Specified;
    property RGSoc4:             string  Index (IS_OPTN) read FRGSoc4 write SetRGSoc4 stored RGSoc4_Specified;
    property CotaSoc1:           string  Index (IS_OPTN) read FCotaSoc1 write SetCotaSoc1 stored CotaSoc1_Specified;
    property CotaSoc2:           string  Index (IS_OPTN) read FCotaSoc2 write SetCotaSoc2 stored CotaSoc2_Specified;
    property CotaSoc3:           string  Index (IS_OPTN) read FCotaSoc3 write SetCotaSoc3 stored CotaSoc3_Specified;
    property CotaSoc4:           string  Index (IS_OPTN) read FCotaSoc4 write SetCotaSoc4 stored CotaSoc4_Specified;
    property DtNascimentoSoc1:   string  Index (IS_OPTN) read FDtNascimentoSoc1 write SetDtNascimentoSoc1 stored DtNascimentoSoc1_Specified;
    property DtNascimentoSoc2:   string  Index (IS_OPTN) read FDtNascimentoSoc2 write SetDtNascimentoSoc2 stored DtNascimentoSoc2_Specified;
    property DtNascimentoSoc3:   string  Index (IS_OPTN) read FDtNascimentoSoc3 write SetDtNascimentoSoc3 stored DtNascimentoSoc3_Specified;
    property DtNascimentoSoc4:   string  Index (IS_OPTN) read FDtNascimentoSoc4 write SetDtNascimentoSoc4 stored DtNascimentoSoc4_Specified;
    property EnderecoSoc1:       string  Index (IS_OPTN) read FEnderecoSoc1 write SetEnderecoSoc1 stored EnderecoSoc1_Specified;
    property EnderecoSoc2:       string  Index (IS_OPTN) read FEnderecoSoc2 write SetEnderecoSoc2 stored EnderecoSoc2_Specified;
    property EnderecoSoc3:       string  Index (IS_OPTN) read FEnderecoSoc3 write SetEnderecoSoc3 stored EnderecoSoc3_Specified;
    property NumeroSoc1:         string  Index (IS_OPTN) read FNumeroSoc1 write SetNumeroSoc1 stored NumeroSoc1_Specified;
    property NumeroSoc2:         string  Index (IS_OPTN) read FNumeroSoc2 write SetNumeroSoc2 stored NumeroSoc2_Specified;
    property NumeroSoc3:         string  Index (IS_OPTN) read FNumeroSoc3 write SetNumeroSoc3 stored NumeroSoc3_Specified;
    property ComplementoSoc1:    string  Index (IS_OPTN) read FComplementoSoc1 write SetComplementoSoc1 stored ComplementoSoc1_Specified;
    property ComplementoSoc2:    string  Index (IS_OPTN) read FComplementoSoc2 write SetComplementoSoc2 stored ComplementoSoc2_Specified;
    property ComplementoSoc3:    string  Index (IS_OPTN) read FComplementoSoc3 write SetComplementoSoc3 stored ComplementoSoc3_Specified;
    property BairroSoc1:         string  Index (IS_OPTN) read FBairroSoc1 write SetBairroSoc1 stored BairroSoc1_Specified;
    property BairroSoc2:         string  Index (IS_OPTN) read FBairroSoc2 write SetBairroSoc2 stored BairroSoc2_Specified;
    property BairroSoc3:         string  Index (IS_OPTN) read FBairroSoc3 write SetBairroSoc3 stored BairroSoc3_Specified;
    property CidadeSoc1:         string  Index (IS_OPTN) read FCidadeSoc1 write SetCidadeSoc1 stored CidadeSoc1_Specified;
    property CidadeSoc2:         string  Index (IS_OPTN) read FCidadeSoc2 write SetCidadeSoc2 stored CidadeSoc2_Specified;
    property CidadeSoc3:         string  Index (IS_OPTN) read FCidadeSoc3 write SetCidadeSoc3 stored CidadeSoc3_Specified;
    property UFSoc1:             string  Index (IS_OPTN) read FUFSoc1 write SetUFSoc1 stored UFSoc1_Specified;
    property UFSoc2:             string  Index (IS_OPTN) read FUFSoc2 write SetUFSoc2 stored UFSoc2_Specified;
    property UFSoc3:             string  Index (IS_OPTN) read FUFSoc3 write SetUFSoc3 stored UFSoc3_Specified;
    property DDDTelefoneSoc1:    string  Index (IS_OPTN) read FDDDTelefoneSoc1 write SetDDDTelefoneSoc1 stored DDDTelefoneSoc1_Specified;
    property DDDTelefoneSoc2:    string  Index (IS_OPTN) read FDDDTelefoneSoc2 write SetDDDTelefoneSoc2 stored DDDTelefoneSoc2_Specified;
    property DDDTelefoneSoc3:    string  Index (IS_OPTN) read FDDDTelefoneSoc3 write SetDDDTelefoneSoc3 stored DDDTelefoneSoc3_Specified;
    property NoTelefoneSoc1:     string  Index (IS_OPTN) read FNoTelefoneSoc1 write SetNoTelefoneSoc1 stored NoTelefoneSoc1_Specified;
    property NoTelefoneSoc2:     string  Index (IS_OPTN) read FNoTelefoneSoc2 write SetNoTelefoneSoc2 stored NoTelefoneSoc2_Specified;
    property NoTelefoneSoc3:     string  Index (IS_OPTN) read FNoTelefoneSoc3 write SetNoTelefoneSoc3 stored NoTelefoneSoc3_Specified;
    property TipoPoderSoc1:      string  Index (IS_OPTN) read FTipoPoderSoc1 write SetTipoPoderSoc1 stored TipoPoderSoc1_Specified;
    property TipoPoderSoc2:      string  Index (IS_OPTN) read FTipoPoderSoc2 write SetTipoPoderSoc2 stored TipoPoderSoc2_Specified;
    property TipoPoderSoc3:      string  Index (IS_OPTN) read FTipoPoderSoc3 write SetTipoPoderSoc3 stored TipoPoderSoc3_Specified;
    property TipoPoderSoc4:      string  Index (IS_OPTN) read FTipoPoderSoc4 write SetTipoPoderSoc4 stored TipoPoderSoc4_Specified;
    property Localizacao1:       string  Index (IS_OPTN) read FLocalizacao1 write SetLocalizacao1 stored Localizacao1_Specified;
    property Localizacao2:       string  Index (IS_OPTN) read FLocalizacao2 write SetLocalizacao2 stored Localizacao2_Specified;
    property AreaTerreno1:       string  Index (IS_OPTN) read FAreaTerreno1 write SetAreaTerreno1 stored AreaTerreno1_Specified;
    property AreaTerreno2:       string  Index (IS_OPTN) read FAreaTerreno2 write SetAreaTerreno2 stored AreaTerreno2_Specified;
    property AreaConstruida1:    string  Index (IS_OPTN) read FAreaConstruida1 write SetAreaConstruida1 stored AreaConstruida1_Specified;
    property AreaConstruida2:    string  Index (IS_OPTN) read FAreaConstruida2 write SetAreaConstruida2 stored AreaConstruida2_Specified;
    property Valor1:             string  Index (IS_OPTN) read FValor1 write SetValor1 stored Valor1_Specified;
    property Valor2:             string  Index (IS_OPTN) read FValor2 write SetValor2 stored Valor2_Specified;
    property CNPJPart:           string  Index (IS_OPTN) read FCNPJPart write SetCNPJPart stored CNPJPart_Specified;
    property RazaoSocialPart:    string  Index (IS_OPTN) read FRazaoSocialPart write SetRazaoSocialPart stored RazaoSocialPart_Specified;
    property NomeFantasiaPart:   string  Index (IS_OPTN) read FNomeFantasiaPart write SetNomeFantasiaPart stored NomeFantasiaPart_Specified;
    property InscEstadualPart:   string  Index (IS_OPTN) read FInscEstadualPart write SetInscEstadualPart stored InscEstadualPart_Specified;
    property DataFundacaoPart:   string  Index (IS_OPTN) read FDataFundacaoPart write SetDataFundacaoPart stored DataFundacaoPart_Specified;
    property RamoAtividadePart:  string  Index (IS_OPTN) read FRamoAtividadePart write SetRamoAtividadePart stored RamoAtividadePart_Specified;
    property CapitalSocialPart:  string  Index (IS_OPTN) read FCapitalSocialPart write SetCapitalSocialPart stored CapitalSocialPart_Specified;
    property Nome1:              string  Index (IS_OPTN) read FNome1 write SetNome1 stored Nome1_Specified;
    property DDD1:               string  Index (IS_OPTN) read FDDD1 write SetDDD1 stored DDD1_Specified;
    property Fone1:              string  Index (IS_OPTN) read FFone1 write SetFone1 stored Fone1_Specified;
    property Ramal1:             string  Index (IS_OPTN) read FRamal1 write SetRamal1 stored Ramal1_Specified;
    property Nome2:              string  Index (IS_OPTN) read FNome2 write SetNome2 stored Nome2_Specified;
    property DDD2:               string  Index (IS_OPTN) read FDDD2 write SetDDD2 stored DDD2_Specified;
    property Fone2:              string  Index (IS_OPTN) read FFone2 write SetFone2 stored Fone2_Specified;
    property Ramal2:             string  Index (IS_OPTN) read FRamal2 write SetRamal2 stored Ramal2_Specified;
    property Nome3:              string  Index (IS_OPTN) read FNome3 write SetNome3 stored Nome3_Specified;
    property DDD3:               string  Index (IS_OPTN) read FDDD3 write SetDDD3 stored DDD3_Specified;
    property Fone3:              string  Index (IS_OPTN) read FFone3 write SetFone3 stored Fone3_Specified;
    property Ramal3:             string  Index (IS_OPTN) read FRamal3 write SetRamal3 stored Ramal3_Specified;
    property Nome4:              string  Index (IS_OPTN) read FNome4 write SetNome4 stored Nome4_Specified;
    property DDD4:               string  Index (IS_OPTN) read FDDD4 write SetDDD4 stored DDD4_Specified;
    property Fone4:              string  Index (IS_OPTN) read FFone4 write SetFone4 stored Fone4_Specified;
    property Ramal4:             string  Index (IS_OPTN) read FRamal4 write SetRamal4 stored Ramal4_Specified;
    property NomeCom1:           string  Index (IS_OPTN) read FNomeCom1 write SetNomeCom1 stored NomeCom1_Specified;
    property DDDCom1:            string  Index (IS_OPTN) read FDDDCom1 write SetDDDCom1 stored DDDCom1_Specified;
    property FoneCom1:           string  Index (IS_OPTN) read FFoneCom1 write SetFoneCom1 stored FoneCom1_Specified;
    property RamalCom1:          string  Index (IS_OPTN) read FRamalCom1 write SetRamalCom1 stored RamalCom1_Specified;
    property NomeCom2:           string  Index (IS_OPTN) read FNomeCom2 write SetNomeCom2 stored NomeCom2_Specified;
    property DDDCom2:            string  Index (IS_OPTN) read FDDDCom2 write SetDDDCom2 stored DDDCom2_Specified;
    property FoneCom2:           string  Index (IS_OPTN) read FFoneCom2 write SetFoneCom2 stored FoneCom2_Specified;
    property RamalCom2:          string  Index (IS_OPTN) read FRamalCom2 write SetRamalCom2 stored RamalCom2_Specified;
    property Banco:              string  Index (IS_OPTN) read FBanco write SetBanco stored Banco_Specified;
    property Agencia:            string  Index (IS_OPTN) read FAgencia write SetAgencia stored Agencia_Specified;
    property Conta:              string  Index (IS_OPTN) read FConta write SetConta stored Conta_Specified;
    property Especial:           string  Index (IS_OPTN) read FEspecial write SetEspecial stored Especial_Specified;
    property Contadesde:         string  Index (IS_OPTN) read FContadesde write SetContadesde stored Contadesde_Specified;
    property CidadeConta:        string  Index (IS_OPTN) read FCidadeConta write SetCidadeConta stored CidadeConta_Specified;
    property NomeContador:       string  Index (IS_OPTN) read FNomeContador write SetNomeContador stored NomeContador_Specified;
    property DDDContador:        string  Index (IS_OPTN) read FDDDContador write SetDDDContador stored DDDContador_Specified;
    property FoneContador:       string  Index (IS_OPTN) read FFoneContador write SetFoneContador stored FoneContador_Specified;
    property RamalContador:      string  Index (IS_OPTN) read FRamalContador write SetRamalContador stored RamalContador_Specified;
  end;



  // ************************************************************************ //
  // XML       : stPF, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stPF = class(TRemotable)
  private
    FID: string;
    FID_Specified: boolean;
    FCPF: string;
    FCPF_Specified: boolean;
    FNome: string;
    FNome_Specified: boolean;
    FNascimento: string;
    FNascimento_Specified: boolean;
    FSexo: string;
    FSexo_Specified: boolean;
    FRG: string;
    FRG_Specified: boolean;
    FTipoDocIdentificacao: string;
    FTipoDocIdentificacao_Specified: boolean;
    FEmissorRG: string;
    FEmissorRG_Specified: boolean;
    FDataEmissaoRG: string;
    FDataEmissaoRG_Specified: boolean;
    FEstadoCivil: string;
    FEstadoCivil_Specified: boolean;
    FNacionalidade: string;
    FNacionalidade_Specified: boolean;
    FCTPS: string;
    FCTPS_Specified: boolean;
    FSerieCTPS: string;
    FSerieCTPS_Specified: boolean;
    FMae: string;
    FMae_Specified: boolean;
    FPai: string;
    FPai_Specified: boolean;
    FNaturalidade: string;
    FNaturalidade_Specified: boolean;
    FUFNaturalidade: string;
    FUFNaturalidade_Specified: boolean;
    FEscolaridade: string;
    FEscolaridade_Specified: boolean;
    FPIS: string;
    FPIS_Specified: boolean;
    FBeneficio: string;
    FBeneficio_Specified: boolean;
    FBeneficio2: string;
    FBeneficio2_Specified: boolean;
    FVlrBeneficio: string;
    FVlrBeneficio_Specified: boolean;
    FOcupacao: string;
    FOcupacao_Specified: boolean;
    FDependentes: string;
    FDependentes_Specified: boolean;
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
    FFonePref: string;
    FFonePref_Specified: boolean;
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
    FTempoResAno: string;
    FTempoResAno_Specified: boolean;
    FTempoResMes: string;
    FTempoResMes_Specified: boolean;
    FDDDRes: string;
    FDDDRes_Specified: boolean;
    FTelefoneRes: string;
    FTelefoneRes_Specified: boolean;
    FSituacaoRes: string;
    FSituacaoRes_Specified: boolean;
    FVlrAluguelRes: string;
    FVlrAluguelRes_Specified: boolean;
    FEmpresa: string;
    FEmpresa_Specified: boolean;
    FCargo: string;
    FCargo_Specified: boolean;
    FTempoEmp: string;
    FTempoEmp_Specified: boolean;
    FTempoEmpAno: string;
    FTempoEmpAno_Specified: boolean;
    FTempoEmpMes: string;
    FTempoEmpMes_Specified: boolean;
    FSalario: string;
    FSalario_Specified: boolean;
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
    FVlrOutrasRendas: string;
    FVlrOutrasRendas_Specified: boolean;
    FEmpresaAnt: string;
    FEmpresaAnt_Specified: boolean;
    FAdmissaoAnt: string;
    FAdmissaoAnt_Specified: boolean;
    FDemissaoAnt: string;
    FDemissaoAnt_Specified: boolean;
    FDDDAnt: string;
    FDDDAnt_Specified: boolean;
    FFoneAnt: string;
    FFoneAnt_Specified: boolean;
    FRamalAnt: string;
    FRamalAnt_Specified: boolean;
    FNomeConj: string;
    FNomeConj_Specified: boolean;
    FCPFConj: string;
    FCPFConj_Specified: boolean;
    FNascimentoConj: string;
    FNascimentoConj_Specified: boolean;
    FMaeConj: string;
    FMaeConj_Specified: boolean;
    FRGConj: string;
    FRGConj_Specified: boolean;
    FEmissorRGConj: string;
    FEmissorRGConj_Specified: boolean;
    FDataEmissaoRGConj: string;
    FDataEmissaoRGConj_Specified: boolean;
    FEmpresaConj: string;
    FEmpresaConj_Specified: boolean;
    FCargoConj: string;
    FCargoConj_Specified: boolean;
    FTempoConj: string;
    FTempoConj_Specified: boolean;
    FTempoConjAno: string;
    FTempoConjAno_Specified: boolean;
    FTempoConjMes: string;
    FTempoConjMes_Specified: boolean;
    FSalarioConj: string;
    FSalarioConj_Specified: boolean;
    FEnderecoConj: string;
    FEnderecoConj_Specified: boolean;
    FNumeroConj: string;
    FNumeroConj_Specified: boolean;
    FComplementoConj: string;
    FComplementoConj_Specified: boolean;
    FBairroConj: string;
    FBairroConj_Specified: boolean;
    FCidadeConj: string;
    FCidadeConj_Specified: boolean;
    FUFConj: string;
    FUFConj_Specified: boolean;
    FCEPConj: string;
    FCEPConj_Specified: boolean;
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
    FOutrasRendasConj: string;
    FOutrasRendasConj_Specified: boolean;
    FVlrOutrasRendasConj: string;
    FVlrOutrasRendasConj_Specified: boolean;
    FNome1: string;
    FNome1_Specified: boolean;
    FDDD1: string;
    FDDD1_Specified: boolean;
    FFone1: string;
    FFone1_Specified: boolean;
    FRamal1: string;
    FRamal1_Specified: boolean;
    FRef1GrauParentesco: string;
    FRef1GrauParentesco_Specified: boolean;
    FNome2: string;
    FNome2_Specified: boolean;
    FDDD2: string;
    FDDD2_Specified: boolean;
    FFone2: string;
    FFone2_Specified: boolean;
    FRamal2: string;
    FRamal2_Specified: boolean;
    FRef2GrauParentesco: string;
    FRef2GrauParentesco_Specified: boolean;
    FNome3: string;
    FNome3_Specified: boolean;
    FDDD3: string;
    FDDD3_Specified: boolean;
    FFone3: string;
    FFone3_Specified: boolean;
    FRamal3: string;
    FRamal3_Specified: boolean;
    FRef3GrauParentesco: string;
    FRef3GrauParentesco_Specified: boolean;
    FNome4: string;
    FNome4_Specified: boolean;
    FDDD4: string;
    FDDD4_Specified: boolean;
    FFone4: string;
    FFone4_Specified: boolean;
    FRamal4: string;
    FRamal4_Specified: boolean;
    FRef4GrauParentesco: string;
    FRef4GrauParentesco_Specified: boolean;
    FNomeCom1: string;
    FNomeCom1_Specified: boolean;
    FDDDCom1: string;
    FDDDCom1_Specified: boolean;
    FFoneCom1: string;
    FFoneCom1_Specified: boolean;
    FRamalCom1: string;
    FRamalCom1_Specified: boolean;
    FNomeCom2: string;
    FNomeCom2_Specified: boolean;
    FDDDCom2: string;
    FDDDCom2_Specified: boolean;
    FFoneCom2: string;
    FFoneCom2_Specified: boolean;
    FRamalCom2: string;
    FRamalCom2_Specified: boolean;
    FBanco: string;
    FBanco_Specified: boolean;
    FAgencia: string;
    FAgencia_Specified: boolean;
    FConta: string;
    FConta_Specified: boolean;
    FEspecial: string;
    FEspecial_Specified: boolean;
    FContadesde: string;
    FContadesde_Specified: boolean;
    FCidadeConta: string;
    FCidadeConta_Specified: boolean;
    FVeiculo: string;
    FVeiculo_Specified: boolean;
    FRenavan: string;
    FRenavan_Specified: boolean;
    FCartaoCredito: string;
    FCartaoCredito_Specified: boolean;
    Fno_ddd_or: string;
    Fno_ddd_or_Specified: boolean;
    Fno_fone_or: string;
    Fno_fone_or_Specified: boolean;
    Fno_ramal_or: string;
    Fno_ramal_or_Specified: boolean;
    Fno_ddd_or_conj: string;
    Fno_ddd_or_conj_Specified: boolean;
    Fno_fone_or_conj: string;
    Fno_fone_or_conj_Specified: boolean;
    Fno_ramal_or_conj: string;
    Fno_ramal_or_conj_Specified: boolean;
    Fno_beneficio_conj: string;
    Fno_beneficio_conj_Specified: boolean;
    Fno_cgc: string;
    Fno_cgc_Specified: boolean;
    Fds_contador: string;
    Fds_contador_Specified: boolean;
    Fcd_dddcontador: string;
    Fcd_dddcontador_Specified: boolean;
    Fno_fonecontador: string;
    Fno_fonecontador_Specified: boolean;
    Fno_ramalcontador: string;
    Fno_ramalcontador_Specified: boolean;
    FcrgId: string;
    FcrgId_Specified: boolean;
    FcrgIdConj: string;
    FcrgIdConj_Specified: boolean;
    FcodIBGE: string;
    FcodIBGE_Specified: boolean;
    procedure SetID(Index: Integer; const Astring: string);
    function  ID_Specified(Index: Integer): boolean;
    procedure SetCPF(Index: Integer; const Astring: string);
    function  CPF_Specified(Index: Integer): boolean;
    procedure SetNome(Index: Integer; const Astring: string);
    function  Nome_Specified(Index: Integer): boolean;
    procedure SetNascimento(Index: Integer; const Astring: string);
    function  Nascimento_Specified(Index: Integer): boolean;
    procedure SetSexo(Index: Integer; const Astring: string);
    function  Sexo_Specified(Index: Integer): boolean;
    procedure SetRG(Index: Integer; const Astring: string);
    function  RG_Specified(Index: Integer): boolean;
    procedure SetTipoDocIdentificacao(Index: Integer; const Astring: string);
    function  TipoDocIdentificacao_Specified(Index: Integer): boolean;
    procedure SetEmissorRG(Index: Integer; const Astring: string);
    function  EmissorRG_Specified(Index: Integer): boolean;
    procedure SetDataEmissaoRG(Index: Integer; const Astring: string);
    function  DataEmissaoRG_Specified(Index: Integer): boolean;
    procedure SetEstadoCivil(Index: Integer; const Astring: string);
    function  EstadoCivil_Specified(Index: Integer): boolean;
    procedure SetNacionalidade(Index: Integer; const Astring: string);
    function  Nacionalidade_Specified(Index: Integer): boolean;
    procedure SetCTPS(Index: Integer; const Astring: string);
    function  CTPS_Specified(Index: Integer): boolean;
    procedure SetSerieCTPS(Index: Integer; const Astring: string);
    function  SerieCTPS_Specified(Index: Integer): boolean;
    procedure SetMae(Index: Integer; const Astring: string);
    function  Mae_Specified(Index: Integer): boolean;
    procedure SetPai(Index: Integer; const Astring: string);
    function  Pai_Specified(Index: Integer): boolean;
    procedure SetNaturalidade(Index: Integer; const Astring: string);
    function  Naturalidade_Specified(Index: Integer): boolean;
    procedure SetUFNaturalidade(Index: Integer; const Astring: string);
    function  UFNaturalidade_Specified(Index: Integer): boolean;
    procedure SetEscolaridade(Index: Integer; const Astring: string);
    function  Escolaridade_Specified(Index: Integer): boolean;
    procedure SetPIS(Index: Integer; const Astring: string);
    function  PIS_Specified(Index: Integer): boolean;
    procedure SetBeneficio(Index: Integer; const Astring: string);
    function  Beneficio_Specified(Index: Integer): boolean;
    procedure SetBeneficio2(Index: Integer; const Astring: string);
    function  Beneficio2_Specified(Index: Integer): boolean;
    procedure SetVlrBeneficio(Index: Integer; const Astring: string);
    function  VlrBeneficio_Specified(Index: Integer): boolean;
    procedure SetOcupacao(Index: Integer; const Astring: string);
    function  Ocupacao_Specified(Index: Integer): boolean;
    procedure SetDependentes(Index: Integer; const Astring: string);
    function  Dependentes_Specified(Index: Integer): boolean;
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
    procedure SetFonePref(Index: Integer; const Astring: string);
    function  FonePref_Specified(Index: Integer): boolean;
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
    procedure SetTempoResAno(Index: Integer; const Astring: string);
    function  TempoResAno_Specified(Index: Integer): boolean;
    procedure SetTempoResMes(Index: Integer; const Astring: string);
    function  TempoResMes_Specified(Index: Integer): boolean;
    procedure SetDDDRes(Index: Integer; const Astring: string);
    function  DDDRes_Specified(Index: Integer): boolean;
    procedure SetTelefoneRes(Index: Integer; const Astring: string);
    function  TelefoneRes_Specified(Index: Integer): boolean;
    procedure SetSituacaoRes(Index: Integer; const Astring: string);
    function  SituacaoRes_Specified(Index: Integer): boolean;
    procedure SetVlrAluguelRes(Index: Integer; const Astring: string);
    function  VlrAluguelRes_Specified(Index: Integer): boolean;
    procedure SetEmpresa(Index: Integer; const Astring: string);
    function  Empresa_Specified(Index: Integer): boolean;
    procedure SetCargo(Index: Integer; const Astring: string);
    function  Cargo_Specified(Index: Integer): boolean;
    procedure SetTempoEmp(Index: Integer; const Astring: string);
    function  TempoEmp_Specified(Index: Integer): boolean;
    procedure SetTempoEmpAno(Index: Integer; const Astring: string);
    function  TempoEmpAno_Specified(Index: Integer): boolean;
    procedure SetTempoEmpMes(Index: Integer; const Astring: string);
    function  TempoEmpMes_Specified(Index: Integer): boolean;
    procedure SetSalario(Index: Integer; const Astring: string);
    function  Salario_Specified(Index: Integer): boolean;
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
    procedure SetVlrOutrasRendas(Index: Integer; const Astring: string);
    function  VlrOutrasRendas_Specified(Index: Integer): boolean;
    procedure SetEmpresaAnt(Index: Integer; const Astring: string);
    function  EmpresaAnt_Specified(Index: Integer): boolean;
    procedure SetAdmissaoAnt(Index: Integer; const Astring: string);
    function  AdmissaoAnt_Specified(Index: Integer): boolean;
    procedure SetDemissaoAnt(Index: Integer; const Astring: string);
    function  DemissaoAnt_Specified(Index: Integer): boolean;
    procedure SetDDDAnt(Index: Integer; const Astring: string);
    function  DDDAnt_Specified(Index: Integer): boolean;
    procedure SetFoneAnt(Index: Integer; const Astring: string);
    function  FoneAnt_Specified(Index: Integer): boolean;
    procedure SetRamalAnt(Index: Integer; const Astring: string);
    function  RamalAnt_Specified(Index: Integer): boolean;
    procedure SetNomeConj(Index: Integer; const Astring: string);
    function  NomeConj_Specified(Index: Integer): boolean;
    procedure SetCPFConj(Index: Integer; const Astring: string);
    function  CPFConj_Specified(Index: Integer): boolean;
    procedure SetNascimentoConj(Index: Integer; const Astring: string);
    function  NascimentoConj_Specified(Index: Integer): boolean;
    procedure SetMaeConj(Index: Integer; const Astring: string);
    function  MaeConj_Specified(Index: Integer): boolean;
    procedure SetRGConj(Index: Integer; const Astring: string);
    function  RGConj_Specified(Index: Integer): boolean;
    procedure SetEmissorRGConj(Index: Integer; const Astring: string);
    function  EmissorRGConj_Specified(Index: Integer): boolean;
    procedure SetDataEmissaoRGConj(Index: Integer; const Astring: string);
    function  DataEmissaoRGConj_Specified(Index: Integer): boolean;
    procedure SetEmpresaConj(Index: Integer; const Astring: string);
    function  EmpresaConj_Specified(Index: Integer): boolean;
    procedure SetCargoConj(Index: Integer; const Astring: string);
    function  CargoConj_Specified(Index: Integer): boolean;
    procedure SetTempoConj(Index: Integer; const Astring: string);
    function  TempoConj_Specified(Index: Integer): boolean;
    procedure SetTempoConjAno(Index: Integer; const Astring: string);
    function  TempoConjAno_Specified(Index: Integer): boolean;
    procedure SetTempoConjMes(Index: Integer; const Astring: string);
    function  TempoConjMes_Specified(Index: Integer): boolean;
    procedure SetSalarioConj(Index: Integer; const Astring: string);
    function  SalarioConj_Specified(Index: Integer): boolean;
    procedure SetEnderecoConj(Index: Integer; const Astring: string);
    function  EnderecoConj_Specified(Index: Integer): boolean;
    procedure SetNumeroConj(Index: Integer; const Astring: string);
    function  NumeroConj_Specified(Index: Integer): boolean;
    procedure SetComplementoConj(Index: Integer; const Astring: string);
    function  ComplementoConj_Specified(Index: Integer): boolean;
    procedure SetBairroConj(Index: Integer; const Astring: string);
    function  BairroConj_Specified(Index: Integer): boolean;
    procedure SetCidadeConj(Index: Integer; const Astring: string);
    function  CidadeConj_Specified(Index: Integer): boolean;
    procedure SetUFConj(Index: Integer; const Astring: string);
    function  UFConj_Specified(Index: Integer): boolean;
    procedure SetCEPConj(Index: Integer; const Astring: string);
    function  CEPConj_Specified(Index: Integer): boolean;
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
    procedure SetOutrasRendasConj(Index: Integer; const Astring: string);
    function  OutrasRendasConj_Specified(Index: Integer): boolean;
    procedure SetVlrOutrasRendasConj(Index: Integer; const Astring: string);
    function  VlrOutrasRendasConj_Specified(Index: Integer): boolean;
    procedure SetNome1(Index: Integer; const Astring: string);
    function  Nome1_Specified(Index: Integer): boolean;
    procedure SetDDD1(Index: Integer; const Astring: string);
    function  DDD1_Specified(Index: Integer): boolean;
    procedure SetFone1(Index: Integer; const Astring: string);
    function  Fone1_Specified(Index: Integer): boolean;
    procedure SetRamal1(Index: Integer; const Astring: string);
    function  Ramal1_Specified(Index: Integer): boolean;
    procedure SetRef1GrauParentesco(Index: Integer; const Astring: string);
    function  Ref1GrauParentesco_Specified(Index: Integer): boolean;
    procedure SetNome2(Index: Integer; const Astring: string);
    function  Nome2_Specified(Index: Integer): boolean;
    procedure SetDDD2(Index: Integer; const Astring: string);
    function  DDD2_Specified(Index: Integer): boolean;
    procedure SetFone2(Index: Integer; const Astring: string);
    function  Fone2_Specified(Index: Integer): boolean;
    procedure SetRamal2(Index: Integer; const Astring: string);
    function  Ramal2_Specified(Index: Integer): boolean;
    procedure SetRef2GrauParentesco(Index: Integer; const Astring: string);
    function  Ref2GrauParentesco_Specified(Index: Integer): boolean;
    procedure SetNome3(Index: Integer; const Astring: string);
    function  Nome3_Specified(Index: Integer): boolean;
    procedure SetDDD3(Index: Integer; const Astring: string);
    function  DDD3_Specified(Index: Integer): boolean;
    procedure SetFone3(Index: Integer; const Astring: string);
    function  Fone3_Specified(Index: Integer): boolean;
    procedure SetRamal3(Index: Integer; const Astring: string);
    function  Ramal3_Specified(Index: Integer): boolean;
    procedure SetRef3GrauParentesco(Index: Integer; const Astring: string);
    function  Ref3GrauParentesco_Specified(Index: Integer): boolean;
    procedure SetNome4(Index: Integer; const Astring: string);
    function  Nome4_Specified(Index: Integer): boolean;
    procedure SetDDD4(Index: Integer; const Astring: string);
    function  DDD4_Specified(Index: Integer): boolean;
    procedure SetFone4(Index: Integer; const Astring: string);
    function  Fone4_Specified(Index: Integer): boolean;
    procedure SetRamal4(Index: Integer; const Astring: string);
    function  Ramal4_Specified(Index: Integer): boolean;
    procedure SetRef4GrauParentesco(Index: Integer; const Astring: string);
    function  Ref4GrauParentesco_Specified(Index: Integer): boolean;
    procedure SetNomeCom1(Index: Integer; const Astring: string);
    function  NomeCom1_Specified(Index: Integer): boolean;
    procedure SetDDDCom1(Index: Integer; const Astring: string);
    function  DDDCom1_Specified(Index: Integer): boolean;
    procedure SetFoneCom1(Index: Integer; const Astring: string);
    function  FoneCom1_Specified(Index: Integer): boolean;
    procedure SetRamalCom1(Index: Integer; const Astring: string);
    function  RamalCom1_Specified(Index: Integer): boolean;
    procedure SetNomeCom2(Index: Integer; const Astring: string);
    function  NomeCom2_Specified(Index: Integer): boolean;
    procedure SetDDDCom2(Index: Integer; const Astring: string);
    function  DDDCom2_Specified(Index: Integer): boolean;
    procedure SetFoneCom2(Index: Integer; const Astring: string);
    function  FoneCom2_Specified(Index: Integer): boolean;
    procedure SetRamalCom2(Index: Integer; const Astring: string);
    function  RamalCom2_Specified(Index: Integer): boolean;
    procedure SetBanco(Index: Integer; const Astring: string);
    function  Banco_Specified(Index: Integer): boolean;
    procedure SetAgencia(Index: Integer; const Astring: string);
    function  Agencia_Specified(Index: Integer): boolean;
    procedure SetConta(Index: Integer; const Astring: string);
    function  Conta_Specified(Index: Integer): boolean;
    procedure SetEspecial(Index: Integer; const Astring: string);
    function  Especial_Specified(Index: Integer): boolean;
    procedure SetContadesde(Index: Integer; const Astring: string);
    function  Contadesde_Specified(Index: Integer): boolean;
    procedure SetCidadeConta(Index: Integer; const Astring: string);
    function  CidadeConta_Specified(Index: Integer): boolean;
    procedure SetVeiculo(Index: Integer; const Astring: string);
    function  Veiculo_Specified(Index: Integer): boolean;
    procedure SetRenavan(Index: Integer; const Astring: string);
    function  Renavan_Specified(Index: Integer): boolean;
    procedure SetCartaoCredito(Index: Integer; const Astring: string);
    function  CartaoCredito_Specified(Index: Integer): boolean;
    procedure Setno_ddd_or(Index: Integer; const Astring: string);
    function  no_ddd_or_Specified(Index: Integer): boolean;
    procedure Setno_fone_or(Index: Integer; const Astring: string);
    function  no_fone_or_Specified(Index: Integer): boolean;
    procedure Setno_ramal_or(Index: Integer; const Astring: string);
    function  no_ramal_or_Specified(Index: Integer): boolean;
    procedure Setno_ddd_or_conj(Index: Integer; const Astring: string);
    function  no_ddd_or_conj_Specified(Index: Integer): boolean;
    procedure Setno_fone_or_conj(Index: Integer; const Astring: string);
    function  no_fone_or_conj_Specified(Index: Integer): boolean;
    procedure Setno_ramal_or_conj(Index: Integer; const Astring: string);
    function  no_ramal_or_conj_Specified(Index: Integer): boolean;
    procedure Setno_beneficio_conj(Index: Integer; const Astring: string);
    function  no_beneficio_conj_Specified(Index: Integer): boolean;
    procedure Setno_cgc(Index: Integer; const Astring: string);
    function  no_cgc_Specified(Index: Integer): boolean;
    procedure Setds_contador(Index: Integer; const Astring: string);
    function  ds_contador_Specified(Index: Integer): boolean;
    procedure Setcd_dddcontador(Index: Integer; const Astring: string);
    function  cd_dddcontador_Specified(Index: Integer): boolean;
    procedure Setno_fonecontador(Index: Integer; const Astring: string);
    function  no_fonecontador_Specified(Index: Integer): boolean;
    procedure Setno_ramalcontador(Index: Integer; const Astring: string);
    function  no_ramalcontador_Specified(Index: Integer): boolean;
    procedure SetcrgId(Index: Integer; const Astring: string);
    function  crgId_Specified(Index: Integer): boolean;
    procedure SetcrgIdConj(Index: Integer; const Astring: string);
    function  crgIdConj_Specified(Index: Integer): boolean;
    procedure SetcodIBGE(Index: Integer; const Astring: string);
    function  codIBGE_Specified(Index: Integer): boolean;
  published
    property ID:                   string  Index (IS_OPTN) read FID write SetID stored ID_Specified;
    property CPF:                  string  Index (IS_OPTN) read FCPF write SetCPF stored CPF_Specified;
    property Nome:                 string  Index (IS_OPTN) read FNome write SetNome stored Nome_Specified;
    property Nascimento:           string  Index (IS_OPTN) read FNascimento write SetNascimento stored Nascimento_Specified;
    property Sexo:                 string  Index (IS_OPTN) read FSexo write SetSexo stored Sexo_Specified;
    property RG:                   string  Index (IS_OPTN) read FRG write SetRG stored RG_Specified;
    property TipoDocIdentificacao: string  Index (IS_OPTN) read FTipoDocIdentificacao write SetTipoDocIdentificacao stored TipoDocIdentificacao_Specified;
    property EmissorRG:            string  Index (IS_OPTN) read FEmissorRG write SetEmissorRG stored EmissorRG_Specified;
    property DataEmissaoRG:        string  Index (IS_OPTN) read FDataEmissaoRG write SetDataEmissaoRG stored DataEmissaoRG_Specified;
    property EstadoCivil:          string  Index (IS_OPTN) read FEstadoCivil write SetEstadoCivil stored EstadoCivil_Specified;
    property Nacionalidade:        string  Index (IS_OPTN) read FNacionalidade write SetNacionalidade stored Nacionalidade_Specified;
    property CTPS:                 string  Index (IS_OPTN) read FCTPS write SetCTPS stored CTPS_Specified;
    property SerieCTPS:            string  Index (IS_OPTN) read FSerieCTPS write SetSerieCTPS stored SerieCTPS_Specified;
    property Mae:                  string  Index (IS_OPTN) read FMae write SetMae stored Mae_Specified;
    property Pai:                  string  Index (IS_OPTN) read FPai write SetPai stored Pai_Specified;
    property Naturalidade:         string  Index (IS_OPTN) read FNaturalidade write SetNaturalidade stored Naturalidade_Specified;
    property UFNaturalidade:       string  Index (IS_OPTN) read FUFNaturalidade write SetUFNaturalidade stored UFNaturalidade_Specified;
    property Escolaridade:         string  Index (IS_OPTN) read FEscolaridade write SetEscolaridade stored Escolaridade_Specified;
    property PIS:                  string  Index (IS_OPTN) read FPIS write SetPIS stored PIS_Specified;
    property Beneficio:            string  Index (IS_OPTN) read FBeneficio write SetBeneficio stored Beneficio_Specified;
    property Beneficio2:           string  Index (IS_OPTN) read FBeneficio2 write SetBeneficio2 stored Beneficio2_Specified;
    property VlrBeneficio:         string  Index (IS_OPTN) read FVlrBeneficio write SetVlrBeneficio stored VlrBeneficio_Specified;
    property Ocupacao:             string  Index (IS_OPTN) read FOcupacao write SetOcupacao stored Ocupacao_Specified;
    property Dependentes:          string  Index (IS_OPTN) read FDependentes write SetDependentes stored Dependentes_Specified;
    property DDDCelular:           string  Index (IS_OPTN) read FDDDCelular write SetDDDCelular stored DDDCelular_Specified;
    property FoneCelular:          string  Index (IS_OPTN) read FFoneCelular write SetFoneCelular stored FoneCelular_Specified;
    property DDDCelular2:          string  Index (IS_OPTN) read FDDDCelular2 write SetDDDCelular2 stored DDDCelular2_Specified;
    property FoneCelular2:         string  Index (IS_OPTN) read FFoneCelular2 write SetFoneCelular2 stored FoneCelular2_Specified;
    property Email:                string  Index (IS_OPTN) read FEmail write SetEmail stored Email_Specified;
    property FonePref:             string  Index (IS_OPTN) read FFonePref write SetFonePref stored FonePref_Specified;
    property GrauInstrucao:        string  Index (IS_OPTN) read FGrauInstrucao write SetGrauInstrucao stored GrauInstrucao_Specified;
    property EnderecoRes:          string  Index (IS_OPTN) read FEnderecoRes write SetEnderecoRes stored EnderecoRes_Specified;
    property NumeroRes:            string  Index (IS_OPTN) read FNumeroRes write SetNumeroRes stored NumeroRes_Specified;
    property ComplementoRes:       string  Index (IS_OPTN) read FComplementoRes write SetComplementoRes stored ComplementoRes_Specified;
    property BairroRes:            string  Index (IS_OPTN) read FBairroRes write SetBairroRes stored BairroRes_Specified;
    property CidadeRes:            string  Index (IS_OPTN) read FCidadeRes write SetCidadeRes stored CidadeRes_Specified;
    property UFRes:                string  Index (IS_OPTN) read FUFRes write SetUFRes stored UFRes_Specified;
    property CEPRes:               string  Index (IS_OPTN) read FCEPRes write SetCEPRes stored CEPRes_Specified;
    property TempoRes:             string  Index (IS_OPTN) read FTempoRes write SetTempoRes stored TempoRes_Specified;
    property TempoResAno:          string  Index (IS_OPTN) read FTempoResAno write SetTempoResAno stored TempoResAno_Specified;
    property TempoResMes:          string  Index (IS_OPTN) read FTempoResMes write SetTempoResMes stored TempoResMes_Specified;
    property DDDRes:               string  Index (IS_OPTN) read FDDDRes write SetDDDRes stored DDDRes_Specified;
    property TelefoneRes:          string  Index (IS_OPTN) read FTelefoneRes write SetTelefoneRes stored TelefoneRes_Specified;
    property SituacaoRes:          string  Index (IS_OPTN) read FSituacaoRes write SetSituacaoRes stored SituacaoRes_Specified;
    property VlrAluguelRes:        string  Index (IS_OPTN) read FVlrAluguelRes write SetVlrAluguelRes stored VlrAluguelRes_Specified;
    property Empresa:              string  Index (IS_OPTN) read FEmpresa write SetEmpresa stored Empresa_Specified;
    property Cargo:                string  Index (IS_OPTN) read FCargo write SetCargo stored Cargo_Specified;
    property TempoEmp:             string  Index (IS_OPTN) read FTempoEmp write SetTempoEmp stored TempoEmp_Specified;
    property TempoEmpAno:          string  Index (IS_OPTN) read FTempoEmpAno write SetTempoEmpAno stored TempoEmpAno_Specified;
    property TempoEmpMes:          string  Index (IS_OPTN) read FTempoEmpMes write SetTempoEmpMes stored TempoEmpMes_Specified;
    property Salario:              string  Index (IS_OPTN) read FSalario write SetSalario stored Salario_Specified;
    property EnderecoEmp:          string  Index (IS_OPTN) read FEnderecoEmp write SetEnderecoEmp stored EnderecoEmp_Specified;
    property NumeroEmp:            string  Index (IS_OPTN) read FNumeroEmp write SetNumeroEmp stored NumeroEmp_Specified;
    property ComplementoEmp:       string  Index (IS_OPTN) read FComplementoEmp write SetComplementoEmp stored ComplementoEmp_Specified;
    property BairroEmp:            string  Index (IS_OPTN) read FBairroEmp write SetBairroEmp stored BairroEmp_Specified;
    property CidadeEmp:            string  Index (IS_OPTN) read FCidadeEmp write SetCidadeEmp stored CidadeEmp_Specified;
    property UFEmp:                string  Index (IS_OPTN) read FUFEmp write SetUFEmp stored UFEmp_Specified;
    property CEPEmp:               string  Index (IS_OPTN) read FCEPEmp write SetCEPEmp stored CEPEmp_Specified;
    property DDDEmp:               string  Index (IS_OPTN) read FDDDEmp write SetDDDEmp stored DDDEmp_Specified;
    property TelefoneEmp:          string  Index (IS_OPTN) read FTelefoneEmp write SetTelefoneEmp stored TelefoneEmp_Specified;
    property RamalEmp:             string  Index (IS_OPTN) read FRamalEmp write SetRamalEmp stored RamalEmp_Specified;
    property DDDEmp2:              string  Index (IS_OPTN) read FDDDEmp2 write SetDDDEmp2 stored DDDEmp2_Specified;
    property TelefoneEmp2:         string  Index (IS_OPTN) read FTelefoneEmp2 write SetTelefoneEmp2 stored TelefoneEmp2_Specified;
    property RamalEmp2:            string  Index (IS_OPTN) read FRamalEmp2 write SetRamalEmp2 stored RamalEmp2_Specified;
    property OutrasRendas:         string  Index (IS_OPTN) read FOutrasRendas write SetOutrasRendas stored OutrasRendas_Specified;
    property VlrOutrasRendas:      string  Index (IS_OPTN) read FVlrOutrasRendas write SetVlrOutrasRendas stored VlrOutrasRendas_Specified;
    property EmpresaAnt:           string  Index (IS_OPTN) read FEmpresaAnt write SetEmpresaAnt stored EmpresaAnt_Specified;
    property AdmissaoAnt:          string  Index (IS_OPTN) read FAdmissaoAnt write SetAdmissaoAnt stored AdmissaoAnt_Specified;
    property DemissaoAnt:          string  Index (IS_OPTN) read FDemissaoAnt write SetDemissaoAnt stored DemissaoAnt_Specified;
    property DDDAnt:               string  Index (IS_OPTN) read FDDDAnt write SetDDDAnt stored DDDAnt_Specified;
    property FoneAnt:              string  Index (IS_OPTN) read FFoneAnt write SetFoneAnt stored FoneAnt_Specified;
    property RamalAnt:             string  Index (IS_OPTN) read FRamalAnt write SetRamalAnt stored RamalAnt_Specified;
    property NomeConj:             string  Index (IS_OPTN) read FNomeConj write SetNomeConj stored NomeConj_Specified;
    property CPFConj:              string  Index (IS_OPTN) read FCPFConj write SetCPFConj stored CPFConj_Specified;
    property NascimentoConj:       string  Index (IS_OPTN) read FNascimentoConj write SetNascimentoConj stored NascimentoConj_Specified;
    property MaeConj:              string  Index (IS_OPTN) read FMaeConj write SetMaeConj stored MaeConj_Specified;
    property RGConj:               string  Index (IS_OPTN) read FRGConj write SetRGConj stored RGConj_Specified;
    property EmissorRGConj:        string  Index (IS_OPTN) read FEmissorRGConj write SetEmissorRGConj stored EmissorRGConj_Specified;
    property DataEmissaoRGConj:    string  Index (IS_OPTN) read FDataEmissaoRGConj write SetDataEmissaoRGConj stored DataEmissaoRGConj_Specified;
    property EmpresaConj:          string  Index (IS_OPTN) read FEmpresaConj write SetEmpresaConj stored EmpresaConj_Specified;
    property CargoConj:            string  Index (IS_OPTN) read FCargoConj write SetCargoConj stored CargoConj_Specified;
    property TempoConj:            string  Index (IS_OPTN) read FTempoConj write SetTempoConj stored TempoConj_Specified;
    property TempoConjAno:         string  Index (IS_OPTN) read FTempoConjAno write SetTempoConjAno stored TempoConjAno_Specified;
    property TempoConjMes:         string  Index (IS_OPTN) read FTempoConjMes write SetTempoConjMes stored TempoConjMes_Specified;
    property SalarioConj:          string  Index (IS_OPTN) read FSalarioConj write SetSalarioConj stored SalarioConj_Specified;
    property EnderecoConj:         string  Index (IS_OPTN) read FEnderecoConj write SetEnderecoConj stored EnderecoConj_Specified;
    property NumeroConj:           string  Index (IS_OPTN) read FNumeroConj write SetNumeroConj stored NumeroConj_Specified;
    property ComplementoConj:      string  Index (IS_OPTN) read FComplementoConj write SetComplementoConj stored ComplementoConj_Specified;
    property BairroConj:           string  Index (IS_OPTN) read FBairroConj write SetBairroConj stored BairroConj_Specified;
    property CidadeConj:           string  Index (IS_OPTN) read FCidadeConj write SetCidadeConj stored CidadeConj_Specified;
    property UFConj:               string  Index (IS_OPTN) read FUFConj write SetUFConj stored UFConj_Specified;
    property CEPConj:              string  Index (IS_OPTN) read FCEPConj write SetCEPConj stored CEPConj_Specified;
    property DDDConj:              string  Index (IS_OPTN) read FDDDConj write SetDDDConj stored DDDConj_Specified;
    property TelefoneConj:         string  Index (IS_OPTN) read FTelefoneConj write SetTelefoneConj stored TelefoneConj_Specified;
    property RamalConj:            string  Index (IS_OPTN) read FRamalConj write SetRamalConj stored RamalConj_Specified;
    property DDDConj2:             string  Index (IS_OPTN) read FDDDConj2 write SetDDDConj2 stored DDDConj2_Specified;
    property TelefoneConj2:        string  Index (IS_OPTN) read FTelefoneConj2 write SetTelefoneConj2 stored TelefoneConj2_Specified;
    property RamalConj2:           string  Index (IS_OPTN) read FRamalConj2 write SetRamalConj2 stored RamalConj2_Specified;
    property OutrasRendasConj:     string  Index (IS_OPTN) read FOutrasRendasConj write SetOutrasRendasConj stored OutrasRendasConj_Specified;
    property VlrOutrasRendasConj:  string  Index (IS_OPTN) read FVlrOutrasRendasConj write SetVlrOutrasRendasConj stored VlrOutrasRendasConj_Specified;
    property Nome1:                string  Index (IS_OPTN) read FNome1 write SetNome1 stored Nome1_Specified;
    property DDD1:                 string  Index (IS_OPTN) read FDDD1 write SetDDD1 stored DDD1_Specified;
    property Fone1:                string  Index (IS_OPTN) read FFone1 write SetFone1 stored Fone1_Specified;
    property Ramal1:               string  Index (IS_OPTN) read FRamal1 write SetRamal1 stored Ramal1_Specified;
    property Ref1GrauParentesco:   string  Index (IS_OPTN) read FRef1GrauParentesco write SetRef1GrauParentesco stored Ref1GrauParentesco_Specified;
    property Nome2:                string  Index (IS_OPTN) read FNome2 write SetNome2 stored Nome2_Specified;
    property DDD2:                 string  Index (IS_OPTN) read FDDD2 write SetDDD2 stored DDD2_Specified;
    property Fone2:                string  Index (IS_OPTN) read FFone2 write SetFone2 stored Fone2_Specified;
    property Ramal2:               string  Index (IS_OPTN) read FRamal2 write SetRamal2 stored Ramal2_Specified;
    property Ref2GrauParentesco:   string  Index (IS_OPTN) read FRef2GrauParentesco write SetRef2GrauParentesco stored Ref2GrauParentesco_Specified;
    property Nome3:                string  Index (IS_OPTN) read FNome3 write SetNome3 stored Nome3_Specified;
    property DDD3:                 string  Index (IS_OPTN) read FDDD3 write SetDDD3 stored DDD3_Specified;
    property Fone3:                string  Index (IS_OPTN) read FFone3 write SetFone3 stored Fone3_Specified;
    property Ramal3:               string  Index (IS_OPTN) read FRamal3 write SetRamal3 stored Ramal3_Specified;
    property Ref3GrauParentesco:   string  Index (IS_OPTN) read FRef3GrauParentesco write SetRef3GrauParentesco stored Ref3GrauParentesco_Specified;
    property Nome4:                string  Index (IS_OPTN) read FNome4 write SetNome4 stored Nome4_Specified;
    property DDD4:                 string  Index (IS_OPTN) read FDDD4 write SetDDD4 stored DDD4_Specified;
    property Fone4:                string  Index (IS_OPTN) read FFone4 write SetFone4 stored Fone4_Specified;
    property Ramal4:               string  Index (IS_OPTN) read FRamal4 write SetRamal4 stored Ramal4_Specified;
    property Ref4GrauParentesco:   string  Index (IS_OPTN) read FRef4GrauParentesco write SetRef4GrauParentesco stored Ref4GrauParentesco_Specified;
    property NomeCom1:             string  Index (IS_OPTN) read FNomeCom1 write SetNomeCom1 stored NomeCom1_Specified;
    property DDDCom1:              string  Index (IS_OPTN) read FDDDCom1 write SetDDDCom1 stored DDDCom1_Specified;
    property FoneCom1:             string  Index (IS_OPTN) read FFoneCom1 write SetFoneCom1 stored FoneCom1_Specified;
    property RamalCom1:            string  Index (IS_OPTN) read FRamalCom1 write SetRamalCom1 stored RamalCom1_Specified;
    property NomeCom2:             string  Index (IS_OPTN) read FNomeCom2 write SetNomeCom2 stored NomeCom2_Specified;
    property DDDCom2:              string  Index (IS_OPTN) read FDDDCom2 write SetDDDCom2 stored DDDCom2_Specified;
    property FoneCom2:             string  Index (IS_OPTN) read FFoneCom2 write SetFoneCom2 stored FoneCom2_Specified;
    property RamalCom2:            string  Index (IS_OPTN) read FRamalCom2 write SetRamalCom2 stored RamalCom2_Specified;
    property Banco:                string  Index (IS_OPTN) read FBanco write SetBanco stored Banco_Specified;
    property Agencia:              string  Index (IS_OPTN) read FAgencia write SetAgencia stored Agencia_Specified;
    property Conta:                string  Index (IS_OPTN) read FConta write SetConta stored Conta_Specified;
    property Especial:             string  Index (IS_OPTN) read FEspecial write SetEspecial stored Especial_Specified;
    property Contadesde:           string  Index (IS_OPTN) read FContadesde write SetContadesde stored Contadesde_Specified;
    property CidadeConta:          string  Index (IS_OPTN) read FCidadeConta write SetCidadeConta stored CidadeConta_Specified;
    property Veiculo:              string  Index (IS_OPTN) read FVeiculo write SetVeiculo stored Veiculo_Specified;
    property Renavan:              string  Index (IS_OPTN) read FRenavan write SetRenavan stored Renavan_Specified;
    property CartaoCredito:        string  Index (IS_OPTN) read FCartaoCredito write SetCartaoCredito stored CartaoCredito_Specified;
    property no_ddd_or:            string  Index (IS_OPTN) read Fno_ddd_or write Setno_ddd_or stored no_ddd_or_Specified;
    property no_fone_or:           string  Index (IS_OPTN) read Fno_fone_or write Setno_fone_or stored no_fone_or_Specified;
    property no_ramal_or:          string  Index (IS_OPTN) read Fno_ramal_or write Setno_ramal_or stored no_ramal_or_Specified;
    property no_ddd_or_conj:       string  Index (IS_OPTN) read Fno_ddd_or_conj write Setno_ddd_or_conj stored no_ddd_or_conj_Specified;
    property no_fone_or_conj:      string  Index (IS_OPTN) read Fno_fone_or_conj write Setno_fone_or_conj stored no_fone_or_conj_Specified;
    property no_ramal_or_conj:     string  Index (IS_OPTN) read Fno_ramal_or_conj write Setno_ramal_or_conj stored no_ramal_or_conj_Specified;
    property no_beneficio_conj:    string  Index (IS_OPTN) read Fno_beneficio_conj write Setno_beneficio_conj stored no_beneficio_conj_Specified;
    property no_cgc:               string  Index (IS_OPTN) read Fno_cgc write Setno_cgc stored no_cgc_Specified;
    property ds_contador:          string  Index (IS_OPTN) read Fds_contador write Setds_contador stored ds_contador_Specified;
    property cd_dddcontador:       string  Index (IS_OPTN) read Fcd_dddcontador write Setcd_dddcontador stored cd_dddcontador_Specified;
    property no_fonecontador:      string  Index (IS_OPTN) read Fno_fonecontador write Setno_fonecontador stored no_fonecontador_Specified;
    property no_ramalcontador:     string  Index (IS_OPTN) read Fno_ramalcontador write Setno_ramalcontador stored no_ramalcontador_Specified;
    property crgId:                string  Index (IS_OPTN) read FcrgId write SetcrgId stored crgId_Specified;
    property crgIdConj:            string  Index (IS_OPTN) read FcrgIdConj write SetcrgIdConj stored crgIdConj_Specified;
    property codIBGE:              string  Index (IS_OPTN) read FcodIBGE write SetcodIBGE stored codIBGE_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoCancelamento, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoCancelamento2 = class(TRemotable)
  private
    Fstatus: string;
    Fstatus_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
  published
    property status:   string  Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
    property mensagem: string  Index (IS_OPTN) read Fmensagem write Setmensagem stored mensagem_Specified;
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
  // XML       : stRetornoStatus, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoStatus2 = class(TRemotable)
  private
    Fstatus: string;
    Fstatus_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    Fcontrato: string;
    Fcontrato_Specified: boolean;
    FPrevisaoPgto: string;
    FPrevisaoPgto_Specified: boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure Setcontrato(Index: Integer; const Astring: string);
    function  contrato_Specified(Index: Integer): boolean;
    procedure SetPrevisaoPgto(Index: Integer; const Astring: string);
    function  PrevisaoPgto_Specified(Index: Integer): boolean;
  published
    property status:       string  Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
    property mensagem:     string  Index (IS_OPTN) read Fmensagem write Setmensagem stored mensagem_Specified;
    property contrato:     string  Index (IS_OPTN) read Fcontrato write Setcontrato stored contrato_Specified;
    property PrevisaoPgto: string  Index (IS_OPTN) read FPrevisaoPgto write SetPrevisaoPgto stored PrevisaoPgto_Specified;
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
  // XML       : stRetornoPropostaNova, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoPropostaNova2 = class(TRemotable)
  private
    Floja: Integer;
    Fproposta: string;
    Fproposta_Specified: boolean;
    Fstatus: string;
    Fstatus_Specified: boolean;
    Fcontrato: Int64;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    Fconcatenado: string;
    Fconcatenado_Specified: boolean;
    Fprocessamento: string;
    Fprocessamento_Specified: boolean;
    procedure Setproposta(Index: Integer; const Astring: string);
    function  proposta_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const Astring: string);
    function  status_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure Setconcatenado(Index: Integer; const Astring: string);
    function  concatenado_Specified(Index: Integer): boolean;
    procedure Setprocessamento(Index: Integer; const Astring: string);
    function  processamento_Specified(Index: Integer): boolean;
  published
    property loja:          Integer  read Floja write Floja;
    property proposta:      string   Index (IS_OPTN) read Fproposta write Setproposta stored proposta_Specified;
    property status:        string   Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
    property contrato:      Int64    read Fcontrato write Fcontrato;
    property mensagem:      string   Index (IS_OPTN) read Fmensagem write Setmensagem stored mensagem_Specified;
    property concatenado:   string   Index (IS_OPTN) read Fconcatenado write Setconcatenado stored concatenado_Specified;
    property processamento: string   Index (IS_OPTN) read Fprocessamento write Setprocessamento stored processamento_Specified;
  end;



  // ************************************************************************ //
  // XML       : stRetornoPropostaNova, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetornoPropostaNova = class(stRetornoPropostaNova2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : stNovaProposta, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stNovaProposta = class(TRemotable)
  private
    FstDadosPessoaFisica: stPF;
    FstDadosProposta: stProposta;
  public
    destructor Destroy; override;
  published
    property stDadosPessoaFisica: stPF        read FstDadosPessoaFisica write FstDadosPessoaFisica;
    property stDadosProposta:     stProposta  read FstDadosProposta write FstDadosProposta;
  end;



  // ************************************************************************ //
  // XML       : stRetorno, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  stRetorno2 = class(TRemotable)
  private
    FaditivoBoleto: TByteDynArray;
    FaditivoBoleto_Specified: boolean;
    Fsituacao: string;
    Fsituacao_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    procedure SetaditivoBoleto(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  aditivoBoleto_Specified(Index: Integer): boolean;
    procedure Setsituacao(Index: Integer; const Astring: string);
    function  situacao_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
  published
    property aditivoBoleto: TByteDynArray  Index (IS_OPTN) read FaditivoBoleto write SetaditivoBoleto stored aditivoBoleto_Specified;
    property situacao:      string         Index (IS_OPTN) read Fsituacao write Setsituacao stored situacao_Specified;
    property mensagem:      string         Index (IS_OPTN) read Fmensagem write Setmensagem stored mensagem_Specified;
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
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : analisadorSoap
  // service   : analisador
  // port      : analisadorSoap
  // URL       : https://www.credipar.com.br/analisador/analisador.asmx
  // ************************************************************************ //
  analisadorSoap = interface(IInvokable)
  ['{ADE32938-EB43-D298-4489-2785A70DEE40}']
    function  StatusPropostaS(const login: string; const senha: string; const loja: Integer; const proposta: string): string; stdcall;
    function  StatusProposta(const login: string; const senha: string; const loja: Integer; const proposta: string): stRetornoProposta2; stdcall;
    function  FechamentoBordero(const proposta: string; const loja: string): stRetornoStatusBordero2; stdcall;
    function  Conciliacao(const lojista: string; const token: string; const dtPagamento: TXSDateTime): string; stdcall;
    procedure TransferFile; stdcall;
    procedure EnviaStatusParaMM(const loja: Integer; const proposta: string); stdcall;
    function  StatusPropostaNovo(const loja: Integer; const proposta: string): stRetornoPropostaNova2; stdcall;
    function  StatusProcessamentoProposta(const loja: Integer; const proposta: string): stRetornoStatus2; stdcall;
    function  CancelamentoProposta(const loja: Integer; const proposta: string; const motivo: string): stRetornoCancelamento2; stdcall;
    function  NovaPropostaJuridica(const login: string; const senha: string; const loja: Integer; const proposta: string; const buffer: string; const mensagem: string
                                   ): stRetornoProposta2; stdcall;
    function  RetornaAditivoEBoleto(const loja: Integer; const proposta: string): stRetorno2; stdcall;
    function  PropostaPessoaFisica(const stcNovaProposta: stNovaProposta): stRetornoProposta2; stdcall;
    function  PropostaRetorno(const iCodLoja: Integer; const lNumProposta: Int64): stRetornoProposta2; stdcall;
    function  NovaPropostaFisica(const login: string; const senha: string; const loja: Integer; const proposta: string; const buffer: string; const mensagem: string
                                 ): stRetornoProposta2; stdcall;
    function  NovaPropostaJuridicaEstrutura(const pessoaJuridica: stPJ; const proposta: stProposta): stRetornoPropostaNova2; stdcall;
    function  NovaPropostaFisicaEstrutura(const pessoaFisica: stPF; const proposta: stProposta): stRetornoPropostaNova2; stdcall;
    function  NovaPropostaFisicaCartaoEstrutura(const pessoaFisica: stPF; const proposta: stProposta; const cartao: stCartao): stRetornoPropostaNova2; stdcall;
    function  AnexarDocumento(const arquivoBytes: TByteDynArray; const formatoArquivo: string; const proposta: string; const loja: Integer): stRetornoMensagem2; stdcall;
    function  AnexarDocumentoControladoria(const arquivoBytes: TByteDynArray; const formatoArquivo: string; const proposta: string; const loja: Integer): stRetornoMensagem2; stdcall;
    function  Metodo02(const arquivoBytes: TByteDynArray; const formatoArquivo: string; const proposta: string; const loja: Integer; const tipo: string; const usuid: Integer
                       ): stRetornoMensagem2; stdcall;
    function  Metodo03(const arquivoBytes: TByteDynArray; const formatoArquivo: string; const proposta: string; const loja: Integer; const tipo: string; const usuid: Integer; 
                       const tipoDoc: string): stRetornoMensagem2; stdcall;
    function  Metodo01(const login: string; const senha: string; const loja: string): stRetornoMensagem2; stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // style     : ????
  // use       : ????
  // binding   : analisadorHttpGet
  // service   : analisador
  // port      : analisadorHttpGet
  // ************************************************************************ //
  analisadorHttpGet = interface(IInvokable)
  ['{EB5B1C57-B589-A4BD-EBC5-066A660E7C8F}']
    function  StatusPropostaS(const login: string; const senha: string; const loja: string; const proposta: string): string_; stdcall;
    function  StatusProposta(const login: string; const senha: string; const loja: string; const proposta: string): stRetornoProposta; stdcall;
    function  FechamentoBordero(const proposta: string; const loja: string): stRetornoStatusBordero; stdcall;
    function  Conciliacao(const lojista: string; const token: string; const dtPagamento: string): string_; stdcall;
    procedure TransferFile; stdcall;
    procedure EnviaStatusParaMM(const loja: string; const proposta: string); stdcall;
    function  StatusPropostaNovo(const loja: string; const proposta: string): stRetornoPropostaNova; stdcall;
    function  StatusProcessamentoProposta(const loja: string; const proposta: string): stRetornoStatus; stdcall;
    function  CancelamentoProposta(const loja: string; const proposta: string; const motivo: string): stRetornoCancelamento; stdcall;
    function  NovaPropostaJuridica(const login: string; const senha: string; const loja: string; const proposta: string; const buffer: string; const mensagem: string
                                   ): stRetornoProposta; stdcall;
    function  RetornaAditivoEBoleto(const loja: string; const proposta: string): stRetorno; stdcall;
    function  PropostaRetorno(const iCodLoja: string; const lNumProposta: string): stRetornoProposta; stdcall;
    function  NovaPropostaFisica(const login: string; const senha: string; const loja: string; const proposta: string; const buffer: string; const mensagem: string
                                 ): stRetornoProposta; stdcall;
    function  AnexarDocumento(const arquivoBytes: StringArray; const formatoArquivo: string; const proposta: string; const loja: string): stRetornoMensagem; stdcall;
    function  AnexarDocumentoControladoria(const arquivoBytes: StringArray; const formatoArquivo: string; const proposta: string; const loja: string): stRetornoMensagem; stdcall;
    function  Metodo02(const arquivoBytes: StringArray; const formatoArquivo: string; const proposta: string; const loja: string; const tipo: string; const usuid: string
                       ): stRetornoMensagem; stdcall;
    function  Metodo03(const arquivoBytes: StringArray; const formatoArquivo: string; const proposta: string; const loja: string; const tipo: string; const usuid: string; 
                       const tipoDoc: string): stRetornoMensagem; stdcall;
    function  Metodo01(const login: string; const senha: string; const loja: string): stRetornoMensagem; stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // style     : ????
  // use       : ????
  // binding   : analisadorHttpPost
  // service   : analisador
  // port      : analisadorHttpPost
  // ************************************************************************ //
  analisadorHttpPost = interface(IInvokable)
  ['{EF94B8C6-1384-0C0E-D086-2214E6D20A3D}']
    function  StatusPropostaS(const login: string; const senha: string; const loja: string; const proposta: string): string_; stdcall;
    function  StatusProposta(const login: string; const senha: string; const loja: string; const proposta: string): stRetornoProposta; stdcall;
    function  FechamentoBordero(const proposta: string; const loja: string): stRetornoStatusBordero; stdcall;
    function  Conciliacao(const lojista: string; const token: string; const dtPagamento: string): string_; stdcall;
    procedure TransferFile; stdcall;
    procedure EnviaStatusParaMM(const loja: string; const proposta: string); stdcall;
    function  StatusPropostaNovo(const loja: string; const proposta: string): stRetornoPropostaNova; stdcall;
    function  StatusProcessamentoProposta(const loja: string; const proposta: string): stRetornoStatus; stdcall;
    function  CancelamentoProposta(const loja: string; const proposta: string; const motivo: string): stRetornoCancelamento; stdcall;
    function  NovaPropostaJuridica(const login: string; const senha: string; const loja: string; const proposta: string; const buffer: string; const mensagem: string
                                   ): stRetornoProposta; stdcall;
    function  RetornaAditivoEBoleto(const loja: string; const proposta: string): stRetorno; stdcall;
    function  PropostaRetorno(const iCodLoja: string; const lNumProposta: string): stRetornoProposta; stdcall;
    function  NovaPropostaFisica(const login: string; const senha: string; const loja: string; const proposta: string; const buffer: string; const mensagem: string
                                 ): stRetornoProposta; stdcall;
    function  AnexarDocumento(const arquivoBytes: StringArray; const formatoArquivo: string; const proposta: string; const loja: string): stRetornoMensagem; stdcall;
    function  AnexarDocumentoControladoria(const arquivoBytes: StringArray; const formatoArquivo: string; const proposta: string; const loja: string): stRetornoMensagem; stdcall;
    function  Metodo02(const arquivoBytes: StringArray; const formatoArquivo: string; const proposta: string; const loja: string; const tipo: string; const usuid: string
                       ): stRetornoMensagem; stdcall;
    function  Metodo03(const arquivoBytes: StringArray; const formatoArquivo: string; const proposta: string; const loja: string; const tipo: string; const usuid: string; 
                       const tipoDoc: string): stRetornoMensagem; stdcall;
    function  Metodo01(const login: string; const senha: string; const loja: string): stRetornoMensagem; stdcall;
  end;

function GetanalisadorSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): analisadorSoap;
function GetanalisadorHttpGet(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): analisadorHttpGet;
function GetanalisadorHttpPost(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): analisadorHttpPost;


implementation
  uses SysUtils;

function GetanalisadorSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): analisadorSoap;
const
  defWSDL = 'https://www.credipar.com.br/analisador/analisador.asmx?WSDL';
  defURL  = 'https://www.credipar.com.br/analisador/analisador.asmx';
  defSvc  = 'analisador';
  defPrt  = 'analisadorSoap';
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
    Result := (RIO as analisadorSoap);
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


function GetanalisadorHttpGet(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): analisadorHttpGet;
const
  defWSDL = 'https://www.credipar.com.br/analisador/analisador.asmx?WSDL';
  defURL  = '';
  defSvc  = 'analisador';
  defPrt  = 'analisadorHttpGet';
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
    Result := (RIO as analisadorHttpGet);
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


function GetanalisadorHttpPost(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): analisadorHttpPost;
const
  defWSDL = 'https://www.credipar.com.br/analisador/analisador.asmx?WSDL';
  defURL  = '';
  defSvc  = 'analisador';
  defPrt  = 'analisadorHttpPost';
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
    Result := (RIO as analisadorHttpPost);
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


procedure stRetornoProposta2.Setproposta(Index: Integer; const Astring: string);
begin
  Fproposta := Astring;
  Fproposta_Specified := True;
end;

function stRetornoProposta2.proposta_Specified(Index: Integer): boolean;
begin
  Result := Fproposta_Specified;
end;

procedure stRetornoProposta2.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function stRetornoProposta2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure stRetornoProposta2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function stRetornoProposta2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure stRetornoProposta2.Setconcatenado(Index: Integer; const Astring: string);
begin
  Fconcatenado := Astring;
  Fconcatenado_Specified := True;
end;

function stRetornoProposta2.concatenado_Specified(Index: Integer): boolean;
begin
  Result := Fconcatenado_Specified;
end;

procedure stRetornoStatusBordero2.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function stRetornoStatusBordero2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure stRetornoStatusBordero2.Setvalor(Index: Integer; const Astring: string);
begin
  Fvalor := Astring;
  Fvalor_Specified := True;
end;

function stRetornoStatusBordero2.valor_Specified(Index: Integer): boolean;
begin
  Result := Fvalor_Specified;
end;

procedure stRetornoStatusBordero2.Setcontrato(Index: Integer; const Astring: string);
begin
  Fcontrato := Astring;
  Fcontrato_Specified := True;
end;

function stRetornoStatusBordero2.contrato_Specified(Index: Integer): boolean;
begin
  Result := Fcontrato_Specified;
end;

procedure stRetornoStatusBordero2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function stRetornoStatusBordero2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure stRetornoStatusBordero2.SetPrevisaoPgto(Index: Integer; const Astring: string);
begin
  FPrevisaoPgto := Astring;
  FPrevisaoPgto_Specified := True;
end;

function stRetornoStatusBordero2.PrevisaoPgto_Specified(Index: Integer): boolean;
begin
  Result := FPrevisaoPgto_Specified;
end;

destructor stProposta.Destroy;
begin
  SysUtils.FreeAndNil(Fdt_compra);
  SysUtils.FreeAndNil(Fdt_pri_vencto);
  inherited Destroy;
end;

procedure stProposta.Setproposta(Index: Integer; const Astring: string);
begin
  Fproposta := Astring;
  Fproposta_Specified := True;
end;

function stProposta.proposta_Specified(Index: Integer): boolean;
begin
  Result := Fproposta_Specified;
end;

procedure stProposta.Settipo_dcl(Index: Integer; const Astring: string);
begin
  Ftipo_dcl := Astring;
  Ftipo_dcl_Specified := True;
end;

function stProposta.tipo_dcl_Specified(Index: Integer): boolean;
begin
  Result := Ftipo_dcl_Specified;
end;

procedure stProposta.Setmodalidade(Index: Integer; const Astring: string);
begin
  Fmodalidade := Astring;
  Fmodalidade_Specified := True;
end;

function stProposta.modalidade_Specified(Index: Integer): boolean;
begin
  Result := Fmodalidade_Specified;
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

procedure stProposta.Setnumero_cartao(Index: Integer; const Astring: string);
begin
  Fnumero_cartao := Astring;
  Fnumero_cartao_Specified := True;
end;

function stProposta.numero_cartao_Specified(Index: Integer): boolean;
begin
  Result := Fnumero_cartao_Specified;
end;

procedure stProposta.Setvencto_cartao(Index: Integer; const Astring: string);
begin
  Fvencto_cartao := Astring;
  Fvencto_cartao_Specified := True;
end;

function stProposta.vencto_cartao_Specified(Index: Integer): boolean;
begin
  Result := Fvencto_cartao_Specified;
end;

procedure stProposta.Setdigito_cartao(Index: Integer; const Astring: string);
begin
  Fdigito_cartao := Astring;
  Fdigito_cartao_Specified := True;
end;

function stProposta.digito_cartao_Specified(Index: Integer): boolean;
begin
  Result := Fdigito_cartao_Specified;
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

procedure stProposta.Setseguro_mm(Index: Integer; const Astring: string);
begin
  Fseguro_mm := Astring;
  Fseguro_mm_Specified := True;
end;

function stProposta.seguro_mm_Specified(Index: Integer): boolean;
begin
  Result := Fseguro_mm_Specified;
end;

procedure stProposta.Setfone_preferencial(Index: Integer; const Astring: string);
begin
  Ffone_preferencial := Astring;
  Ffone_preferencial_Specified := True;
end;

function stProposta.fone_preferencial_Specified(Index: Integer): boolean;
begin
  Result := Ffone_preferencial_Specified;
end;

procedure stProposta.Setnumero_celular_mercadoria(Index: Integer; const Astring: string);
begin
  Fnumero_celular_mercadoria := Astring;
  Fnumero_celular_mercadoria_Specified := True;
end;

function stProposta.numero_celular_mercadoria_Specified(Index: Integer): boolean;
begin
  Result := Fnumero_celular_mercadoria_Specified;
end;

procedure stProposta.Setimei_celular_mercadoria(Index: Integer; const Astring: string);
begin
  Fimei_celular_mercadoria := Astring;
  Fimei_celular_mercadoria_Specified := True;
end;

function stProposta.imei_celular_mercadoria_Specified(Index: Integer): boolean;
begin
  Result := Fimei_celular_mercadoria_Specified;
end;

procedure stProposta.Setmercadoria_entregue(Index: Integer; const Astring: string);
begin
  Fmercadoria_entregue := Astring;
  Fmercadoria_entregue_Specified := True;
end;

function stProposta.mercadoria_entregue_Specified(Index: Integer): boolean;
begin
  Result := Fmercadoria_entregue_Specified;
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

procedure stProposta.Setno_cmc7_cheques(Index: Integer; const Astring: string);
begin
  Fno_cmc7_cheques := Astring;
  Fno_cmc7_cheques_Specified := True;
end;

function stProposta.no_cmc7_cheques_Specified(Index: Integer): boolean;
begin
  Result := Fno_cmc7_cheques_Specified;
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

procedure stProposta.SetplanoSic(Index: Integer; const Astring: string);
begin
  FplanoSic := Astring;
  FplanoSic_Specified := True;
end;

function stProposta.planoSic_Specified(Index: Integer): boolean;
begin
  Result := FplanoSic_Specified;
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

procedure stProposta.SetSeguro(Index: Integer; const Astring: string);
begin
  FSeguro := Astring;
  FSeguro_Specified := True;
end;

function stProposta.Seguro_Specified(Index: Integer): boolean;
begin
  Result := FSeguro_Specified;
end;

procedure stRetornoMensagem2.Setsituacao(Index: Integer; const Astring: string);
begin
  Fsituacao := Astring;
  Fsituacao_Specified := True;
end;

function stRetornoMensagem2.situacao_Specified(Index: Integer): boolean;
begin
  Result := Fsituacao_Specified;
end;

procedure stRetornoMensagem2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function stRetornoMensagem2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure stRetornoMensagem2.Settipo(Index: Integer; const Astring: string);
begin
  Ftipo := Astring;
  Ftipo_Specified := True;
end;

function stRetornoMensagem2.tipo_Specified(Index: Integer): boolean;
begin
  Result := Ftipo_Specified;
end;

destructor stCartao.Destroy;
begin
  SysUtils.FreeAndNil(FdataNascimento1);
  SysUtils.FreeAndNil(FdataNascimento2);
  inherited Destroy;
end;

procedure stCartao.SetnomeImpressaoCartaoTitular(Index: Integer; const Astring: string);
begin
  FnomeImpressaoCartaoTitular := Astring;
  FnomeImpressaoCartaoTitular_Specified := True;
end;

function stCartao.nomeImpressaoCartaoTitular_Specified(Index: Integer): boolean;
begin
  Result := FnomeImpressaoCartaoTitular_Specified;
end;

procedure stCartao.SettipoPessoa(Index: Integer; const Astring: string);
begin
  FtipoPessoa := Astring;
  FtipoPessoa_Specified := True;
end;

function stCartao.tipoPessoa_Specified(Index: Integer): boolean;
begin
  Result := FtipoPessoa_Specified;
end;

procedure stCartao.SetenderecoEnvioFatura(Index: Integer; const Astring: string);
begin
  FenderecoEnvioFatura := Astring;
  FenderecoEnvioFatura_Specified := True;
end;

function stCartao.enderecoEnvioFatura_Specified(Index: Integer): boolean;
begin
  Result := FenderecoEnvioFatura_Specified;
end;

procedure stCartao.SetenvioPlastico(Index: Integer; const Astring: string);
begin
  FenvioPlastico := Astring;
  FenvioPlastico_Specified := True;
end;

function stCartao.envioPlastico_Specified(Index: Integer): boolean;
begin
  Result := FenvioPlastico_Specified;
end;

procedure stCartao.SetnomeImpressaoCartao1(Index: Integer; const Astring: string);
begin
  FnomeImpressaoCartao1 := Astring;
  FnomeImpressaoCartao1_Specified := True;
end;

function stCartao.nomeImpressaoCartao1_Specified(Index: Integer): boolean;
begin
  Result := FnomeImpressaoCartao1_Specified;
end;

procedure stCartao.SettipoPessoa1(Index: Integer; const Astring: string);
begin
  FtipoPessoa1 := Astring;
  FtipoPessoa1_Specified := True;
end;

function stCartao.tipoPessoa1_Specified(Index: Integer): boolean;
begin
  Result := FtipoPessoa1_Specified;
end;

procedure stCartao.SetnomeImpressaoCartao2(Index: Integer; const Astring: string);
begin
  FnomeImpressaoCartao2 := Astring;
  FnomeImpressaoCartao2_Specified := True;
end;

function stCartao.nomeImpressaoCartao2_Specified(Index: Integer): boolean;
begin
  Result := FnomeImpressaoCartao2_Specified;
end;

procedure stCartao.SettipoPessoa2(Index: Integer; const Astring: string);
begin
  FtipoPessoa2 := Astring;
  FtipoPessoa2_Specified := True;
end;

function stCartao.tipoPessoa2_Specified(Index: Integer): boolean;
begin
  Result := FtipoPessoa2_Specified;
end;

procedure stPJ.SetID(Index: Integer; const Astring: string);
begin
  FID := Astring;
  FID_Specified := True;
end;

function stPJ.ID_Specified(Index: Integer): boolean;
begin
  Result := FID_Specified;
end;

procedure stPJ.SetCNPJ(Index: Integer; const Astring: string);
begin
  FCNPJ := Astring;
  FCNPJ_Specified := True;
end;

function stPJ.CNPJ_Specified(Index: Integer): boolean;
begin
  Result := FCNPJ_Specified;
end;

procedure stPJ.SetRazaoSocial(Index: Integer; const Astring: string);
begin
  FRazaoSocial := Astring;
  FRazaoSocial_Specified := True;
end;

function stPJ.RazaoSocial_Specified(Index: Integer): boolean;
begin
  Result := FRazaoSocial_Specified;
end;

procedure stPJ.SetNomeFantasia(Index: Integer; const Astring: string);
begin
  FNomeFantasia := Astring;
  FNomeFantasia_Specified := True;
end;

function stPJ.NomeFantasia_Specified(Index: Integer): boolean;
begin
  Result := FNomeFantasia_Specified;
end;

procedure stPJ.SetInscEstadual(Index: Integer; const Astring: string);
begin
  FInscEstadual := Astring;
  FInscEstadual_Specified := True;
end;

function stPJ.InscEstadual_Specified(Index: Integer): boolean;
begin
  Result := FInscEstadual_Specified;
end;

procedure stPJ.SetDataFundacao(Index: Integer; const Astring: string);
begin
  FDataFundacao := Astring;
  FDataFundacao_Specified := True;
end;

function stPJ.DataFundacao_Specified(Index: Integer): boolean;
begin
  Result := FDataFundacao_Specified;
end;

procedure stPJ.SetRamoAtividade(Index: Integer; const Astring: string);
begin
  FRamoAtividade := Astring;
  FRamoAtividade_Specified := True;
end;

function stPJ.RamoAtividade_Specified(Index: Integer): boolean;
begin
  Result := FRamoAtividade_Specified;
end;

procedure stPJ.SetCapitalSocial(Index: Integer; const Astring: string);
begin
  FCapitalSocial := Astring;
  FCapitalSocial_Specified := True;
end;

function stPJ.CapitalSocial_Specified(Index: Integer): boolean;
begin
  Result := FCapitalSocial_Specified;
end;

procedure stPJ.SetCapitalImoveis(Index: Integer; const Astring: string);
begin
  FCapitalImoveis := Astring;
  FCapitalImoveis_Specified := True;
end;

function stPJ.CapitalImoveis_Specified(Index: Integer): boolean;
begin
  Result := FCapitalImoveis_Specified;
end;

procedure stPJ.SetCapitalEquipamento(Index: Integer; const Astring: string);
begin
  FCapitalEquipamento := Astring;
  FCapitalEquipamento_Specified := True;
end;

function stPJ.CapitalEquipamento_Specified(Index: Integer): boolean;
begin
  Result := FCapitalEquipamento_Specified;
end;

procedure stPJ.SetCapitalVeiculos(Index: Integer; const Astring: string);
begin
  FCapitalVeiculos := Astring;
  FCapitalVeiculos_Specified := True;
end;

function stPJ.CapitalVeiculos_Specified(Index: Integer): boolean;
begin
  Result := FCapitalVeiculos_Specified;
end;

procedure stPJ.SetFaturamentoMensal(Index: Integer; const Astring: string);
begin
  FFaturamentoMensal := Astring;
  FFaturamentoMensal_Specified := True;
end;

function stPJ.FaturamentoMensal_Specified(Index: Integer): boolean;
begin
  Result := FFaturamentoMensal_Specified;
end;

procedure stPJ.SetNoFuncionarios(Index: Integer; const Astring: string);
begin
  FNoFuncionarios := Astring;
  FNoFuncionarios_Specified := True;
end;

function stPJ.NoFuncionarios_Specified(Index: Integer): boolean;
begin
  Result := FNoFuncionarios_Specified;
end;

procedure stPJ.SetValorEstoque(Index: Integer; const Astring: string);
begin
  FValorEstoque := Astring;
  FValorEstoque_Specified := True;
end;

function stPJ.ValorEstoque_Specified(Index: Integer): boolean;
begin
  Result := FValorEstoque_Specified;
end;

procedure stPJ.SetCapitalGiro(Index: Integer; const Astring: string);
begin
  FCapitalGiro := Astring;
  FCapitalGiro_Specified := True;
end;

function stPJ.CapitalGiro_Specified(Index: Integer): boolean;
begin
  Result := FCapitalGiro_Specified;
end;

procedure stPJ.SetValorFolhaPgto(Index: Integer; const Astring: string);
begin
  FValorFolhaPgto := Astring;
  FValorFolhaPgto_Specified := True;
end;

function stPJ.ValorFolhaPgto_Specified(Index: Integer): boolean;
begin
  Result := FValorFolhaPgto_Specified;
end;

procedure stPJ.SetEmail(Index: Integer; const Astring: string);
begin
  FEmail := Astring;
  FEmail_Specified := True;
end;

function stPJ.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure stPJ.SetEndereco(Index: Integer; const Astring: string);
begin
  FEndereco := Astring;
  FEndereco_Specified := True;
end;

function stPJ.Endereco_Specified(Index: Integer): boolean;
begin
  Result := FEndereco_Specified;
end;

procedure stPJ.SetNumero(Index: Integer; const Astring: string);
begin
  FNumero := Astring;
  FNumero_Specified := True;
end;

function stPJ.Numero_Specified(Index: Integer): boolean;
begin
  Result := FNumero_Specified;
end;

procedure stPJ.SetComplemento(Index: Integer; const Astring: string);
begin
  FComplemento := Astring;
  FComplemento_Specified := True;
end;

function stPJ.Complemento_Specified(Index: Integer): boolean;
begin
  Result := FComplemento_Specified;
end;

procedure stPJ.SetBairro(Index: Integer; const Astring: string);
begin
  FBairro := Astring;
  FBairro_Specified := True;
end;

function stPJ.Bairro_Specified(Index: Integer): boolean;
begin
  Result := FBairro_Specified;
end;

procedure stPJ.SetCidade(Index: Integer; const Astring: string);
begin
  FCidade := Astring;
  FCidade_Specified := True;
end;

function stPJ.Cidade_Specified(Index: Integer): boolean;
begin
  Result := FCidade_Specified;
end;

procedure stPJ.SetUF(Index: Integer; const Astring: string);
begin
  FUF := Astring;
  FUF_Specified := True;
end;

function stPJ.UF_Specified(Index: Integer): boolean;
begin
  Result := FUF_Specified;
end;

procedure stPJ.SetCEP(Index: Integer; const Astring: string);
begin
  FCEP := Astring;
  FCEP_Specified := True;
end;

function stPJ.CEP_Specified(Index: Integer): boolean;
begin
  Result := FCEP_Specified;
end;

procedure stPJ.SetTempo(Index: Integer; const Astring: string);
begin
  FTempo := Astring;
  FTempo_Specified := True;
end;

function stPJ.Tempo_Specified(Index: Integer): boolean;
begin
  Result := FTempo_Specified;
end;

procedure stPJ.SetDDD(Index: Integer; const Astring: string);
begin
  FDDD := Astring;
  FDDD_Specified := True;
end;

function stPJ.DDD_Specified(Index: Integer): boolean;
begin
  Result := FDDD_Specified;
end;

procedure stPJ.SetTelefone(Index: Integer; const Astring: string);
begin
  FTelefone := Astring;
  FTelefone_Specified := True;
end;

function stPJ.Telefone_Specified(Index: Integer): boolean;
begin
  Result := FTelefone_Specified;
end;

procedure stPJ.SetDDDFax(Index: Integer; const Astring: string);
begin
  FDDDFax := Astring;
  FDDDFax_Specified := True;
end;

function stPJ.DDDFax_Specified(Index: Integer): boolean;
begin
  Result := FDDDFax_Specified;
end;

procedure stPJ.SetTelefoneFax(Index: Integer; const Astring: string);
begin
  FTelefoneFax := Astring;
  FTelefoneFax_Specified := True;
end;

function stPJ.TelefoneFax_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneFax_Specified;
end;

procedure stPJ.SetNomeSoc1(Index: Integer; const Astring: string);
begin
  FNomeSoc1 := Astring;
  FNomeSoc1_Specified := True;
end;

function stPJ.NomeSoc1_Specified(Index: Integer): boolean;
begin
  Result := FNomeSoc1_Specified;
end;

procedure stPJ.SetNomeSoc2(Index: Integer; const Astring: string);
begin
  FNomeSoc2 := Astring;
  FNomeSoc2_Specified := True;
end;

function stPJ.NomeSoc2_Specified(Index: Integer): boolean;
begin
  Result := FNomeSoc2_Specified;
end;

procedure stPJ.SetNomeSoc3(Index: Integer; const Astring: string);
begin
  FNomeSoc3 := Astring;
  FNomeSoc3_Specified := True;
end;

function stPJ.NomeSoc3_Specified(Index: Integer): boolean;
begin
  Result := FNomeSoc3_Specified;
end;

procedure stPJ.SetNomeSoc4(Index: Integer; const Astring: string);
begin
  FNomeSoc4 := Astring;
  FNomeSoc4_Specified := True;
end;

function stPJ.NomeSoc4_Specified(Index: Integer): boolean;
begin
  Result := FNomeSoc4_Specified;
end;

procedure stPJ.SetCPFSoc1(Index: Integer; const Astring: string);
begin
  FCPFSoc1 := Astring;
  FCPFSoc1_Specified := True;
end;

function stPJ.CPFSoc1_Specified(Index: Integer): boolean;
begin
  Result := FCPFSoc1_Specified;
end;

procedure stPJ.SetCPFSoc2(Index: Integer; const Astring: string);
begin
  FCPFSoc2 := Astring;
  FCPFSoc2_Specified := True;
end;

function stPJ.CPFSoc2_Specified(Index: Integer): boolean;
begin
  Result := FCPFSoc2_Specified;
end;

procedure stPJ.SetCPFSoc3(Index: Integer; const Astring: string);
begin
  FCPFSoc3 := Astring;
  FCPFSoc3_Specified := True;
end;

function stPJ.CPFSoc3_Specified(Index: Integer): boolean;
begin
  Result := FCPFSoc3_Specified;
end;

procedure stPJ.SetCPFSoc4(Index: Integer; const Astring: string);
begin
  FCPFSoc4 := Astring;
  FCPFSoc4_Specified := True;
end;

function stPJ.CPFSoc4_Specified(Index: Integer): boolean;
begin
  Result := FCPFSoc4_Specified;
end;

procedure stPJ.SetRGSoc1(Index: Integer; const Astring: string);
begin
  FRGSoc1 := Astring;
  FRGSoc1_Specified := True;
end;

function stPJ.RGSoc1_Specified(Index: Integer): boolean;
begin
  Result := FRGSoc1_Specified;
end;

procedure stPJ.SetRGSoc2(Index: Integer; const Astring: string);
begin
  FRGSoc2 := Astring;
  FRGSoc2_Specified := True;
end;

function stPJ.RGSoc2_Specified(Index: Integer): boolean;
begin
  Result := FRGSoc2_Specified;
end;

procedure stPJ.SetRGSoc3(Index: Integer; const Astring: string);
begin
  FRGSoc3 := Astring;
  FRGSoc3_Specified := True;
end;

function stPJ.RGSoc3_Specified(Index: Integer): boolean;
begin
  Result := FRGSoc3_Specified;
end;

procedure stPJ.SetRGSoc4(Index: Integer; const Astring: string);
begin
  FRGSoc4 := Astring;
  FRGSoc4_Specified := True;
end;

function stPJ.RGSoc4_Specified(Index: Integer): boolean;
begin
  Result := FRGSoc4_Specified;
end;

procedure stPJ.SetCotaSoc1(Index: Integer; const Astring: string);
begin
  FCotaSoc1 := Astring;
  FCotaSoc1_Specified := True;
end;

function stPJ.CotaSoc1_Specified(Index: Integer): boolean;
begin
  Result := FCotaSoc1_Specified;
end;

procedure stPJ.SetCotaSoc2(Index: Integer; const Astring: string);
begin
  FCotaSoc2 := Astring;
  FCotaSoc2_Specified := True;
end;

function stPJ.CotaSoc2_Specified(Index: Integer): boolean;
begin
  Result := FCotaSoc2_Specified;
end;

procedure stPJ.SetCotaSoc3(Index: Integer; const Astring: string);
begin
  FCotaSoc3 := Astring;
  FCotaSoc3_Specified := True;
end;

function stPJ.CotaSoc3_Specified(Index: Integer): boolean;
begin
  Result := FCotaSoc3_Specified;
end;

procedure stPJ.SetCotaSoc4(Index: Integer; const Astring: string);
begin
  FCotaSoc4 := Astring;
  FCotaSoc4_Specified := True;
end;

function stPJ.CotaSoc4_Specified(Index: Integer): boolean;
begin
  Result := FCotaSoc4_Specified;
end;

procedure stPJ.SetDtNascimentoSoc1(Index: Integer; const Astring: string);
begin
  FDtNascimentoSoc1 := Astring;
  FDtNascimentoSoc1_Specified := True;
end;

function stPJ.DtNascimentoSoc1_Specified(Index: Integer): boolean;
begin
  Result := FDtNascimentoSoc1_Specified;
end;

procedure stPJ.SetDtNascimentoSoc2(Index: Integer; const Astring: string);
begin
  FDtNascimentoSoc2 := Astring;
  FDtNascimentoSoc2_Specified := True;
end;

function stPJ.DtNascimentoSoc2_Specified(Index: Integer): boolean;
begin
  Result := FDtNascimentoSoc2_Specified;
end;

procedure stPJ.SetDtNascimentoSoc3(Index: Integer; const Astring: string);
begin
  FDtNascimentoSoc3 := Astring;
  FDtNascimentoSoc3_Specified := True;
end;

function stPJ.DtNascimentoSoc3_Specified(Index: Integer): boolean;
begin
  Result := FDtNascimentoSoc3_Specified;
end;

procedure stPJ.SetDtNascimentoSoc4(Index: Integer; const Astring: string);
begin
  FDtNascimentoSoc4 := Astring;
  FDtNascimentoSoc4_Specified := True;
end;

function stPJ.DtNascimentoSoc4_Specified(Index: Integer): boolean;
begin
  Result := FDtNascimentoSoc4_Specified;
end;

procedure stPJ.SetEnderecoSoc1(Index: Integer; const Astring: string);
begin
  FEnderecoSoc1 := Astring;
  FEnderecoSoc1_Specified := True;
end;

function stPJ.EnderecoSoc1_Specified(Index: Integer): boolean;
begin
  Result := FEnderecoSoc1_Specified;
end;

procedure stPJ.SetEnderecoSoc2(Index: Integer; const Astring: string);
begin
  FEnderecoSoc2 := Astring;
  FEnderecoSoc2_Specified := True;
end;

function stPJ.EnderecoSoc2_Specified(Index: Integer): boolean;
begin
  Result := FEnderecoSoc2_Specified;
end;

procedure stPJ.SetEnderecoSoc3(Index: Integer; const Astring: string);
begin
  FEnderecoSoc3 := Astring;
  FEnderecoSoc3_Specified := True;
end;

function stPJ.EnderecoSoc3_Specified(Index: Integer): boolean;
begin
  Result := FEnderecoSoc3_Specified;
end;

procedure stPJ.SetNumeroSoc1(Index: Integer; const Astring: string);
begin
  FNumeroSoc1 := Astring;
  FNumeroSoc1_Specified := True;
end;

function stPJ.NumeroSoc1_Specified(Index: Integer): boolean;
begin
  Result := FNumeroSoc1_Specified;
end;

procedure stPJ.SetNumeroSoc2(Index: Integer; const Astring: string);
begin
  FNumeroSoc2 := Astring;
  FNumeroSoc2_Specified := True;
end;

function stPJ.NumeroSoc2_Specified(Index: Integer): boolean;
begin
  Result := FNumeroSoc2_Specified;
end;

procedure stPJ.SetNumeroSoc3(Index: Integer; const Astring: string);
begin
  FNumeroSoc3 := Astring;
  FNumeroSoc3_Specified := True;
end;

function stPJ.NumeroSoc3_Specified(Index: Integer): boolean;
begin
  Result := FNumeroSoc3_Specified;
end;

procedure stPJ.SetComplementoSoc1(Index: Integer; const Astring: string);
begin
  FComplementoSoc1 := Astring;
  FComplementoSoc1_Specified := True;
end;

function stPJ.ComplementoSoc1_Specified(Index: Integer): boolean;
begin
  Result := FComplementoSoc1_Specified;
end;

procedure stPJ.SetComplementoSoc2(Index: Integer; const Astring: string);
begin
  FComplementoSoc2 := Astring;
  FComplementoSoc2_Specified := True;
end;

function stPJ.ComplementoSoc2_Specified(Index: Integer): boolean;
begin
  Result := FComplementoSoc2_Specified;
end;

procedure stPJ.SetComplementoSoc3(Index: Integer; const Astring: string);
begin
  FComplementoSoc3 := Astring;
  FComplementoSoc3_Specified := True;
end;

function stPJ.ComplementoSoc3_Specified(Index: Integer): boolean;
begin
  Result := FComplementoSoc3_Specified;
end;

procedure stPJ.SetBairroSoc1(Index: Integer; const Astring: string);
begin
  FBairroSoc1 := Astring;
  FBairroSoc1_Specified := True;
end;

function stPJ.BairroSoc1_Specified(Index: Integer): boolean;
begin
  Result := FBairroSoc1_Specified;
end;

procedure stPJ.SetBairroSoc2(Index: Integer; const Astring: string);
begin
  FBairroSoc2 := Astring;
  FBairroSoc2_Specified := True;
end;

function stPJ.BairroSoc2_Specified(Index: Integer): boolean;
begin
  Result := FBairroSoc2_Specified;
end;

procedure stPJ.SetBairroSoc3(Index: Integer; const Astring: string);
begin
  FBairroSoc3 := Astring;
  FBairroSoc3_Specified := True;
end;

function stPJ.BairroSoc3_Specified(Index: Integer): boolean;
begin
  Result := FBairroSoc3_Specified;
end;

procedure stPJ.SetCidadeSoc1(Index: Integer; const Astring: string);
begin
  FCidadeSoc1 := Astring;
  FCidadeSoc1_Specified := True;
end;

function stPJ.CidadeSoc1_Specified(Index: Integer): boolean;
begin
  Result := FCidadeSoc1_Specified;
end;

procedure stPJ.SetCidadeSoc2(Index: Integer; const Astring: string);
begin
  FCidadeSoc2 := Astring;
  FCidadeSoc2_Specified := True;
end;

function stPJ.CidadeSoc2_Specified(Index: Integer): boolean;
begin
  Result := FCidadeSoc2_Specified;
end;

procedure stPJ.SetCidadeSoc3(Index: Integer; const Astring: string);
begin
  FCidadeSoc3 := Astring;
  FCidadeSoc3_Specified := True;
end;

function stPJ.CidadeSoc3_Specified(Index: Integer): boolean;
begin
  Result := FCidadeSoc3_Specified;
end;

procedure stPJ.SetUFSoc1(Index: Integer; const Astring: string);
begin
  FUFSoc1 := Astring;
  FUFSoc1_Specified := True;
end;

function stPJ.UFSoc1_Specified(Index: Integer): boolean;
begin
  Result := FUFSoc1_Specified;
end;

procedure stPJ.SetUFSoc2(Index: Integer; const Astring: string);
begin
  FUFSoc2 := Astring;
  FUFSoc2_Specified := True;
end;

function stPJ.UFSoc2_Specified(Index: Integer): boolean;
begin
  Result := FUFSoc2_Specified;
end;

procedure stPJ.SetUFSoc3(Index: Integer; const Astring: string);
begin
  FUFSoc3 := Astring;
  FUFSoc3_Specified := True;
end;

function stPJ.UFSoc3_Specified(Index: Integer): boolean;
begin
  Result := FUFSoc3_Specified;
end;

procedure stPJ.SetDDDTelefoneSoc1(Index: Integer; const Astring: string);
begin
  FDDDTelefoneSoc1 := Astring;
  FDDDTelefoneSoc1_Specified := True;
end;

function stPJ.DDDTelefoneSoc1_Specified(Index: Integer): boolean;
begin
  Result := FDDDTelefoneSoc1_Specified;
end;

procedure stPJ.SetDDDTelefoneSoc2(Index: Integer; const Astring: string);
begin
  FDDDTelefoneSoc2 := Astring;
  FDDDTelefoneSoc2_Specified := True;
end;

function stPJ.DDDTelefoneSoc2_Specified(Index: Integer): boolean;
begin
  Result := FDDDTelefoneSoc2_Specified;
end;

procedure stPJ.SetDDDTelefoneSoc3(Index: Integer; const Astring: string);
begin
  FDDDTelefoneSoc3 := Astring;
  FDDDTelefoneSoc3_Specified := True;
end;

function stPJ.DDDTelefoneSoc3_Specified(Index: Integer): boolean;
begin
  Result := FDDDTelefoneSoc3_Specified;
end;

procedure stPJ.SetNoTelefoneSoc1(Index: Integer; const Astring: string);
begin
  FNoTelefoneSoc1 := Astring;
  FNoTelefoneSoc1_Specified := True;
end;

function stPJ.NoTelefoneSoc1_Specified(Index: Integer): boolean;
begin
  Result := FNoTelefoneSoc1_Specified;
end;

procedure stPJ.SetNoTelefoneSoc2(Index: Integer; const Astring: string);
begin
  FNoTelefoneSoc2 := Astring;
  FNoTelefoneSoc2_Specified := True;
end;

function stPJ.NoTelefoneSoc2_Specified(Index: Integer): boolean;
begin
  Result := FNoTelefoneSoc2_Specified;
end;

procedure stPJ.SetNoTelefoneSoc3(Index: Integer; const Astring: string);
begin
  FNoTelefoneSoc3 := Astring;
  FNoTelefoneSoc3_Specified := True;
end;

function stPJ.NoTelefoneSoc3_Specified(Index: Integer): boolean;
begin
  Result := FNoTelefoneSoc3_Specified;
end;

procedure stPJ.SetTipoPoderSoc1(Index: Integer; const Astring: string);
begin
  FTipoPoderSoc1 := Astring;
  FTipoPoderSoc1_Specified := True;
end;

function stPJ.TipoPoderSoc1_Specified(Index: Integer): boolean;
begin
  Result := FTipoPoderSoc1_Specified;
end;

procedure stPJ.SetTipoPoderSoc2(Index: Integer; const Astring: string);
begin
  FTipoPoderSoc2 := Astring;
  FTipoPoderSoc2_Specified := True;
end;

function stPJ.TipoPoderSoc2_Specified(Index: Integer): boolean;
begin
  Result := FTipoPoderSoc2_Specified;
end;

procedure stPJ.SetTipoPoderSoc3(Index: Integer; const Astring: string);
begin
  FTipoPoderSoc3 := Astring;
  FTipoPoderSoc3_Specified := True;
end;

function stPJ.TipoPoderSoc3_Specified(Index: Integer): boolean;
begin
  Result := FTipoPoderSoc3_Specified;
end;

procedure stPJ.SetTipoPoderSoc4(Index: Integer; const Astring: string);
begin
  FTipoPoderSoc4 := Astring;
  FTipoPoderSoc4_Specified := True;
end;

function stPJ.TipoPoderSoc4_Specified(Index: Integer): boolean;
begin
  Result := FTipoPoderSoc4_Specified;
end;

procedure stPJ.SetLocalizacao1(Index: Integer; const Astring: string);
begin
  FLocalizacao1 := Astring;
  FLocalizacao1_Specified := True;
end;

function stPJ.Localizacao1_Specified(Index: Integer): boolean;
begin
  Result := FLocalizacao1_Specified;
end;

procedure stPJ.SetLocalizacao2(Index: Integer; const Astring: string);
begin
  FLocalizacao2 := Astring;
  FLocalizacao2_Specified := True;
end;

function stPJ.Localizacao2_Specified(Index: Integer): boolean;
begin
  Result := FLocalizacao2_Specified;
end;

procedure stPJ.SetAreaTerreno1(Index: Integer; const Astring: string);
begin
  FAreaTerreno1 := Astring;
  FAreaTerreno1_Specified := True;
end;

function stPJ.AreaTerreno1_Specified(Index: Integer): boolean;
begin
  Result := FAreaTerreno1_Specified;
end;

procedure stPJ.SetAreaTerreno2(Index: Integer; const Astring: string);
begin
  FAreaTerreno2 := Astring;
  FAreaTerreno2_Specified := True;
end;

function stPJ.AreaTerreno2_Specified(Index: Integer): boolean;
begin
  Result := FAreaTerreno2_Specified;
end;

procedure stPJ.SetAreaConstruida1(Index: Integer; const Astring: string);
begin
  FAreaConstruida1 := Astring;
  FAreaConstruida1_Specified := True;
end;

function stPJ.AreaConstruida1_Specified(Index: Integer): boolean;
begin
  Result := FAreaConstruida1_Specified;
end;

procedure stPJ.SetAreaConstruida2(Index: Integer; const Astring: string);
begin
  FAreaConstruida2 := Astring;
  FAreaConstruida2_Specified := True;
end;

function stPJ.AreaConstruida2_Specified(Index: Integer): boolean;
begin
  Result := FAreaConstruida2_Specified;
end;

procedure stPJ.SetValor1(Index: Integer; const Astring: string);
begin
  FValor1 := Astring;
  FValor1_Specified := True;
end;

function stPJ.Valor1_Specified(Index: Integer): boolean;
begin
  Result := FValor1_Specified;
end;

procedure stPJ.SetValor2(Index: Integer; const Astring: string);
begin
  FValor2 := Astring;
  FValor2_Specified := True;
end;

function stPJ.Valor2_Specified(Index: Integer): boolean;
begin
  Result := FValor2_Specified;
end;

procedure stPJ.SetCNPJPart(Index: Integer; const Astring: string);
begin
  FCNPJPart := Astring;
  FCNPJPart_Specified := True;
end;

function stPJ.CNPJPart_Specified(Index: Integer): boolean;
begin
  Result := FCNPJPart_Specified;
end;

procedure stPJ.SetRazaoSocialPart(Index: Integer; const Astring: string);
begin
  FRazaoSocialPart := Astring;
  FRazaoSocialPart_Specified := True;
end;

function stPJ.RazaoSocialPart_Specified(Index: Integer): boolean;
begin
  Result := FRazaoSocialPart_Specified;
end;

procedure stPJ.SetNomeFantasiaPart(Index: Integer; const Astring: string);
begin
  FNomeFantasiaPart := Astring;
  FNomeFantasiaPart_Specified := True;
end;

function stPJ.NomeFantasiaPart_Specified(Index: Integer): boolean;
begin
  Result := FNomeFantasiaPart_Specified;
end;

procedure stPJ.SetInscEstadualPart(Index: Integer; const Astring: string);
begin
  FInscEstadualPart := Astring;
  FInscEstadualPart_Specified := True;
end;

function stPJ.InscEstadualPart_Specified(Index: Integer): boolean;
begin
  Result := FInscEstadualPart_Specified;
end;

procedure stPJ.SetDataFundacaoPart(Index: Integer; const Astring: string);
begin
  FDataFundacaoPart := Astring;
  FDataFundacaoPart_Specified := True;
end;

function stPJ.DataFundacaoPart_Specified(Index: Integer): boolean;
begin
  Result := FDataFundacaoPart_Specified;
end;

procedure stPJ.SetRamoAtividadePart(Index: Integer; const Astring: string);
begin
  FRamoAtividadePart := Astring;
  FRamoAtividadePart_Specified := True;
end;

function stPJ.RamoAtividadePart_Specified(Index: Integer): boolean;
begin
  Result := FRamoAtividadePart_Specified;
end;

procedure stPJ.SetCapitalSocialPart(Index: Integer; const Astring: string);
begin
  FCapitalSocialPart := Astring;
  FCapitalSocialPart_Specified := True;
end;

function stPJ.CapitalSocialPart_Specified(Index: Integer): boolean;
begin
  Result := FCapitalSocialPart_Specified;
end;

procedure stPJ.SetNome1(Index: Integer; const Astring: string);
begin
  FNome1 := Astring;
  FNome1_Specified := True;
end;

function stPJ.Nome1_Specified(Index: Integer): boolean;
begin
  Result := FNome1_Specified;
end;

procedure stPJ.SetDDD1(Index: Integer; const Astring: string);
begin
  FDDD1 := Astring;
  FDDD1_Specified := True;
end;

function stPJ.DDD1_Specified(Index: Integer): boolean;
begin
  Result := FDDD1_Specified;
end;

procedure stPJ.SetFone1(Index: Integer; const Astring: string);
begin
  FFone1 := Astring;
  FFone1_Specified := True;
end;

function stPJ.Fone1_Specified(Index: Integer): boolean;
begin
  Result := FFone1_Specified;
end;

procedure stPJ.SetRamal1(Index: Integer; const Astring: string);
begin
  FRamal1 := Astring;
  FRamal1_Specified := True;
end;

function stPJ.Ramal1_Specified(Index: Integer): boolean;
begin
  Result := FRamal1_Specified;
end;

procedure stPJ.SetNome2(Index: Integer; const Astring: string);
begin
  FNome2 := Astring;
  FNome2_Specified := True;
end;

function stPJ.Nome2_Specified(Index: Integer): boolean;
begin
  Result := FNome2_Specified;
end;

procedure stPJ.SetDDD2(Index: Integer; const Astring: string);
begin
  FDDD2 := Astring;
  FDDD2_Specified := True;
end;

function stPJ.DDD2_Specified(Index: Integer): boolean;
begin
  Result := FDDD2_Specified;
end;

procedure stPJ.SetFone2(Index: Integer; const Astring: string);
begin
  FFone2 := Astring;
  FFone2_Specified := True;
end;

function stPJ.Fone2_Specified(Index: Integer): boolean;
begin
  Result := FFone2_Specified;
end;

procedure stPJ.SetRamal2(Index: Integer; const Astring: string);
begin
  FRamal2 := Astring;
  FRamal2_Specified := True;
end;

function stPJ.Ramal2_Specified(Index: Integer): boolean;
begin
  Result := FRamal2_Specified;
end;

procedure stPJ.SetNome3(Index: Integer; const Astring: string);
begin
  FNome3 := Astring;
  FNome3_Specified := True;
end;

function stPJ.Nome3_Specified(Index: Integer): boolean;
begin
  Result := FNome3_Specified;
end;

procedure stPJ.SetDDD3(Index: Integer; const Astring: string);
begin
  FDDD3 := Astring;
  FDDD3_Specified := True;
end;

function stPJ.DDD3_Specified(Index: Integer): boolean;
begin
  Result := FDDD3_Specified;
end;

procedure stPJ.SetFone3(Index: Integer; const Astring: string);
begin
  FFone3 := Astring;
  FFone3_Specified := True;
end;

function stPJ.Fone3_Specified(Index: Integer): boolean;
begin
  Result := FFone3_Specified;
end;

procedure stPJ.SetRamal3(Index: Integer; const Astring: string);
begin
  FRamal3 := Astring;
  FRamal3_Specified := True;
end;

function stPJ.Ramal3_Specified(Index: Integer): boolean;
begin
  Result := FRamal3_Specified;
end;

procedure stPJ.SetNome4(Index: Integer; const Astring: string);
begin
  FNome4 := Astring;
  FNome4_Specified := True;
end;

function stPJ.Nome4_Specified(Index: Integer): boolean;
begin
  Result := FNome4_Specified;
end;

procedure stPJ.SetDDD4(Index: Integer; const Astring: string);
begin
  FDDD4 := Astring;
  FDDD4_Specified := True;
end;

function stPJ.DDD4_Specified(Index: Integer): boolean;
begin
  Result := FDDD4_Specified;
end;

procedure stPJ.SetFone4(Index: Integer; const Astring: string);
begin
  FFone4 := Astring;
  FFone4_Specified := True;
end;

function stPJ.Fone4_Specified(Index: Integer): boolean;
begin
  Result := FFone4_Specified;
end;

procedure stPJ.SetRamal4(Index: Integer; const Astring: string);
begin
  FRamal4 := Astring;
  FRamal4_Specified := True;
end;

function stPJ.Ramal4_Specified(Index: Integer): boolean;
begin
  Result := FRamal4_Specified;
end;

procedure stPJ.SetNomeCom1(Index: Integer; const Astring: string);
begin
  FNomeCom1 := Astring;
  FNomeCom1_Specified := True;
end;

function stPJ.NomeCom1_Specified(Index: Integer): boolean;
begin
  Result := FNomeCom1_Specified;
end;

procedure stPJ.SetDDDCom1(Index: Integer; const Astring: string);
begin
  FDDDCom1 := Astring;
  FDDDCom1_Specified := True;
end;

function stPJ.DDDCom1_Specified(Index: Integer): boolean;
begin
  Result := FDDDCom1_Specified;
end;

procedure stPJ.SetFoneCom1(Index: Integer; const Astring: string);
begin
  FFoneCom1 := Astring;
  FFoneCom1_Specified := True;
end;

function stPJ.FoneCom1_Specified(Index: Integer): boolean;
begin
  Result := FFoneCom1_Specified;
end;

procedure stPJ.SetRamalCom1(Index: Integer; const Astring: string);
begin
  FRamalCom1 := Astring;
  FRamalCom1_Specified := True;
end;

function stPJ.RamalCom1_Specified(Index: Integer): boolean;
begin
  Result := FRamalCom1_Specified;
end;

procedure stPJ.SetNomeCom2(Index: Integer; const Astring: string);
begin
  FNomeCom2 := Astring;
  FNomeCom2_Specified := True;
end;

function stPJ.NomeCom2_Specified(Index: Integer): boolean;
begin
  Result := FNomeCom2_Specified;
end;

procedure stPJ.SetDDDCom2(Index: Integer; const Astring: string);
begin
  FDDDCom2 := Astring;
  FDDDCom2_Specified := True;
end;

function stPJ.DDDCom2_Specified(Index: Integer): boolean;
begin
  Result := FDDDCom2_Specified;
end;

procedure stPJ.SetFoneCom2(Index: Integer; const Astring: string);
begin
  FFoneCom2 := Astring;
  FFoneCom2_Specified := True;
end;

function stPJ.FoneCom2_Specified(Index: Integer): boolean;
begin
  Result := FFoneCom2_Specified;
end;

procedure stPJ.SetRamalCom2(Index: Integer; const Astring: string);
begin
  FRamalCom2 := Astring;
  FRamalCom2_Specified := True;
end;

function stPJ.RamalCom2_Specified(Index: Integer): boolean;
begin
  Result := FRamalCom2_Specified;
end;

procedure stPJ.SetBanco(Index: Integer; const Astring: string);
begin
  FBanco := Astring;
  FBanco_Specified := True;
end;

function stPJ.Banco_Specified(Index: Integer): boolean;
begin
  Result := FBanco_Specified;
end;

procedure stPJ.SetAgencia(Index: Integer; const Astring: string);
begin
  FAgencia := Astring;
  FAgencia_Specified := True;
end;

function stPJ.Agencia_Specified(Index: Integer): boolean;
begin
  Result := FAgencia_Specified;
end;

procedure stPJ.SetConta(Index: Integer; const Astring: string);
begin
  FConta := Astring;
  FConta_Specified := True;
end;

function stPJ.Conta_Specified(Index: Integer): boolean;
begin
  Result := FConta_Specified;
end;

procedure stPJ.SetEspecial(Index: Integer; const Astring: string);
begin
  FEspecial := Astring;
  FEspecial_Specified := True;
end;

function stPJ.Especial_Specified(Index: Integer): boolean;
begin
  Result := FEspecial_Specified;
end;

procedure stPJ.SetContadesde(Index: Integer; const Astring: string);
begin
  FContadesde := Astring;
  FContadesde_Specified := True;
end;

function stPJ.Contadesde_Specified(Index: Integer): boolean;
begin
  Result := FContadesde_Specified;
end;

procedure stPJ.SetCidadeConta(Index: Integer; const Astring: string);
begin
  FCidadeConta := Astring;
  FCidadeConta_Specified := True;
end;

function stPJ.CidadeConta_Specified(Index: Integer): boolean;
begin
  Result := FCidadeConta_Specified;
end;

procedure stPJ.SetNomeContador(Index: Integer; const Astring: string);
begin
  FNomeContador := Astring;
  FNomeContador_Specified := True;
end;

function stPJ.NomeContador_Specified(Index: Integer): boolean;
begin
  Result := FNomeContador_Specified;
end;

procedure stPJ.SetDDDContador(Index: Integer; const Astring: string);
begin
  FDDDContador := Astring;
  FDDDContador_Specified := True;
end;

function stPJ.DDDContador_Specified(Index: Integer): boolean;
begin
  Result := FDDDContador_Specified;
end;

procedure stPJ.SetFoneContador(Index: Integer; const Astring: string);
begin
  FFoneContador := Astring;
  FFoneContador_Specified := True;
end;

function stPJ.FoneContador_Specified(Index: Integer): boolean;
begin
  Result := FFoneContador_Specified;
end;

procedure stPJ.SetRamalContador(Index: Integer; const Astring: string);
begin
  FRamalContador := Astring;
  FRamalContador_Specified := True;
end;

function stPJ.RamalContador_Specified(Index: Integer): boolean;
begin
  Result := FRamalContador_Specified;
end;

procedure stPF.SetID(Index: Integer; const Astring: string);
begin
  FID := Astring;
  FID_Specified := True;
end;

function stPF.ID_Specified(Index: Integer): boolean;
begin
  Result := FID_Specified;
end;

procedure stPF.SetCPF(Index: Integer; const Astring: string);
begin
  FCPF := Astring;
  FCPF_Specified := True;
end;

function stPF.CPF_Specified(Index: Integer): boolean;
begin
  Result := FCPF_Specified;
end;

procedure stPF.SetNome(Index: Integer; const Astring: string);
begin
  FNome := Astring;
  FNome_Specified := True;
end;

function stPF.Nome_Specified(Index: Integer): boolean;
begin
  Result := FNome_Specified;
end;

procedure stPF.SetNascimento(Index: Integer; const Astring: string);
begin
  FNascimento := Astring;
  FNascimento_Specified := True;
end;

function stPF.Nascimento_Specified(Index: Integer): boolean;
begin
  Result := FNascimento_Specified;
end;

procedure stPF.SetSexo(Index: Integer; const Astring: string);
begin
  FSexo := Astring;
  FSexo_Specified := True;
end;

function stPF.Sexo_Specified(Index: Integer): boolean;
begin
  Result := FSexo_Specified;
end;

procedure stPF.SetRG(Index: Integer; const Astring: string);
begin
  FRG := Astring;
  FRG_Specified := True;
end;

function stPF.RG_Specified(Index: Integer): boolean;
begin
  Result := FRG_Specified;
end;

procedure stPF.SetTipoDocIdentificacao(Index: Integer; const Astring: string);
begin
  FTipoDocIdentificacao := Astring;
  FTipoDocIdentificacao_Specified := True;
end;

function stPF.TipoDocIdentificacao_Specified(Index: Integer): boolean;
begin
  Result := FTipoDocIdentificacao_Specified;
end;

procedure stPF.SetEmissorRG(Index: Integer; const Astring: string);
begin
  FEmissorRG := Astring;
  FEmissorRG_Specified := True;
end;

function stPF.EmissorRG_Specified(Index: Integer): boolean;
begin
  Result := FEmissorRG_Specified;
end;

procedure stPF.SetDataEmissaoRG(Index: Integer; const Astring: string);
begin
  FDataEmissaoRG := Astring;
  FDataEmissaoRG_Specified := True;
end;

function stPF.DataEmissaoRG_Specified(Index: Integer): boolean;
begin
  Result := FDataEmissaoRG_Specified;
end;

procedure stPF.SetEstadoCivil(Index: Integer; const Astring: string);
begin
  FEstadoCivil := Astring;
  FEstadoCivil_Specified := True;
end;

function stPF.EstadoCivil_Specified(Index: Integer): boolean;
begin
  Result := FEstadoCivil_Specified;
end;

procedure stPF.SetNacionalidade(Index: Integer; const Astring: string);
begin
  FNacionalidade := Astring;
  FNacionalidade_Specified := True;
end;

function stPF.Nacionalidade_Specified(Index: Integer): boolean;
begin
  Result := FNacionalidade_Specified;
end;

procedure stPF.SetCTPS(Index: Integer; const Astring: string);
begin
  FCTPS := Astring;
  FCTPS_Specified := True;
end;

function stPF.CTPS_Specified(Index: Integer): boolean;
begin
  Result := FCTPS_Specified;
end;

procedure stPF.SetSerieCTPS(Index: Integer; const Astring: string);
begin
  FSerieCTPS := Astring;
  FSerieCTPS_Specified := True;
end;

function stPF.SerieCTPS_Specified(Index: Integer): boolean;
begin
  Result := FSerieCTPS_Specified;
end;

procedure stPF.SetMae(Index: Integer; const Astring: string);
begin
  FMae := Astring;
  FMae_Specified := True;
end;

function stPF.Mae_Specified(Index: Integer): boolean;
begin
  Result := FMae_Specified;
end;

procedure stPF.SetPai(Index: Integer; const Astring: string);
begin
  FPai := Astring;
  FPai_Specified := True;
end;

function stPF.Pai_Specified(Index: Integer): boolean;
begin
  Result := FPai_Specified;
end;

procedure stPF.SetNaturalidade(Index: Integer; const Astring: string);
begin
  FNaturalidade := Astring;
  FNaturalidade_Specified := True;
end;

function stPF.Naturalidade_Specified(Index: Integer): boolean;
begin
  Result := FNaturalidade_Specified;
end;

procedure stPF.SetUFNaturalidade(Index: Integer; const Astring: string);
begin
  FUFNaturalidade := Astring;
  FUFNaturalidade_Specified := True;
end;

function stPF.UFNaturalidade_Specified(Index: Integer): boolean;
begin
  Result := FUFNaturalidade_Specified;
end;

procedure stPF.SetEscolaridade(Index: Integer; const Astring: string);
begin
  FEscolaridade := Astring;
  FEscolaridade_Specified := True;
end;

function stPF.Escolaridade_Specified(Index: Integer): boolean;
begin
  Result := FEscolaridade_Specified;
end;

procedure stPF.SetPIS(Index: Integer; const Astring: string);
begin
  FPIS := Astring;
  FPIS_Specified := True;
end;

function stPF.PIS_Specified(Index: Integer): boolean;
begin
  Result := FPIS_Specified;
end;

procedure stPF.SetBeneficio(Index: Integer; const Astring: string);
begin
  FBeneficio := Astring;
  FBeneficio_Specified := True;
end;

function stPF.Beneficio_Specified(Index: Integer): boolean;
begin
  Result := FBeneficio_Specified;
end;

procedure stPF.SetBeneficio2(Index: Integer; const Astring: string);
begin
  FBeneficio2 := Astring;
  FBeneficio2_Specified := True;
end;

function stPF.Beneficio2_Specified(Index: Integer): boolean;
begin
  Result := FBeneficio2_Specified;
end;

procedure stPF.SetVlrBeneficio(Index: Integer; const Astring: string);
begin
  FVlrBeneficio := Astring;
  FVlrBeneficio_Specified := True;
end;

function stPF.VlrBeneficio_Specified(Index: Integer): boolean;
begin
  Result := FVlrBeneficio_Specified;
end;

procedure stPF.SetOcupacao(Index: Integer; const Astring: string);
begin
  FOcupacao := Astring;
  FOcupacao_Specified := True;
end;

function stPF.Ocupacao_Specified(Index: Integer): boolean;
begin
  Result := FOcupacao_Specified;
end;

procedure stPF.SetDependentes(Index: Integer; const Astring: string);
begin
  FDependentes := Astring;
  FDependentes_Specified := True;
end;

function stPF.Dependentes_Specified(Index: Integer): boolean;
begin
  Result := FDependentes_Specified;
end;

procedure stPF.SetDDDCelular(Index: Integer; const Astring: string);
begin
  FDDDCelular := Astring;
  FDDDCelular_Specified := True;
end;

function stPF.DDDCelular_Specified(Index: Integer): boolean;
begin
  Result := FDDDCelular_Specified;
end;

procedure stPF.SetFoneCelular(Index: Integer; const Astring: string);
begin
  FFoneCelular := Astring;
  FFoneCelular_Specified := True;
end;

function stPF.FoneCelular_Specified(Index: Integer): boolean;
begin
  Result := FFoneCelular_Specified;
end;

procedure stPF.SetDDDCelular2(Index: Integer; const Astring: string);
begin
  FDDDCelular2 := Astring;
  FDDDCelular2_Specified := True;
end;

function stPF.DDDCelular2_Specified(Index: Integer): boolean;
begin
  Result := FDDDCelular2_Specified;
end;

procedure stPF.SetFoneCelular2(Index: Integer; const Astring: string);
begin
  FFoneCelular2 := Astring;
  FFoneCelular2_Specified := True;
end;

function stPF.FoneCelular2_Specified(Index: Integer): boolean;
begin
  Result := FFoneCelular2_Specified;
end;

procedure stPF.SetEmail(Index: Integer; const Astring: string);
begin
  FEmail := Astring;
  FEmail_Specified := True;
end;

function stPF.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure stPF.SetFonePref(Index: Integer; const Astring: string);
begin
  FFonePref := Astring;
  FFonePref_Specified := True;
end;

function stPF.FonePref_Specified(Index: Integer): boolean;
begin
  Result := FFonePref_Specified;
end;

procedure stPF.SetGrauInstrucao(Index: Integer; const Astring: string);
begin
  FGrauInstrucao := Astring;
  FGrauInstrucao_Specified := True;
end;

function stPF.GrauInstrucao_Specified(Index: Integer): boolean;
begin
  Result := FGrauInstrucao_Specified;
end;

procedure stPF.SetEnderecoRes(Index: Integer; const Astring: string);
begin
  FEnderecoRes := Astring;
  FEnderecoRes_Specified := True;
end;

function stPF.EnderecoRes_Specified(Index: Integer): boolean;
begin
  Result := FEnderecoRes_Specified;
end;

procedure stPF.SetNumeroRes(Index: Integer; const Astring: string);
begin
  FNumeroRes := Astring;
  FNumeroRes_Specified := True;
end;

function stPF.NumeroRes_Specified(Index: Integer): boolean;
begin
  Result := FNumeroRes_Specified;
end;

procedure stPF.SetComplementoRes(Index: Integer; const Astring: string);
begin
  FComplementoRes := Astring;
  FComplementoRes_Specified := True;
end;

function stPF.ComplementoRes_Specified(Index: Integer): boolean;
begin
  Result := FComplementoRes_Specified;
end;

procedure stPF.SetBairroRes(Index: Integer; const Astring: string);
begin
  FBairroRes := Astring;
  FBairroRes_Specified := True;
end;

function stPF.BairroRes_Specified(Index: Integer): boolean;
begin
  Result := FBairroRes_Specified;
end;

procedure stPF.SetCidadeRes(Index: Integer; const Astring: string);
begin
  FCidadeRes := Astring;
  FCidadeRes_Specified := True;
end;

function stPF.CidadeRes_Specified(Index: Integer): boolean;
begin
  Result := FCidadeRes_Specified;
end;

procedure stPF.SetUFRes(Index: Integer; const Astring: string);
begin
  FUFRes := Astring;
  FUFRes_Specified := True;
end;

function stPF.UFRes_Specified(Index: Integer): boolean;
begin
  Result := FUFRes_Specified;
end;

procedure stPF.SetCEPRes(Index: Integer; const Astring: string);
begin
  FCEPRes := Astring;
  FCEPRes_Specified := True;
end;

function stPF.CEPRes_Specified(Index: Integer): boolean;
begin
  Result := FCEPRes_Specified;
end;

procedure stPF.SetTempoRes(Index: Integer; const Astring: string);
begin
  FTempoRes := Astring;
  FTempoRes_Specified := True;
end;

function stPF.TempoRes_Specified(Index: Integer): boolean;
begin
  Result := FTempoRes_Specified;
end;

procedure stPF.SetTempoResAno(Index: Integer; const Astring: string);
begin
  FTempoResAno := Astring;
  FTempoResAno_Specified := True;
end;

function stPF.TempoResAno_Specified(Index: Integer): boolean;
begin
  Result := FTempoResAno_Specified;
end;

procedure stPF.SetTempoResMes(Index: Integer; const Astring: string);
begin
  FTempoResMes := Astring;
  FTempoResMes_Specified := True;
end;

function stPF.TempoResMes_Specified(Index: Integer): boolean;
begin
  Result := FTempoResMes_Specified;
end;

procedure stPF.SetDDDRes(Index: Integer; const Astring: string);
begin
  FDDDRes := Astring;
  FDDDRes_Specified := True;
end;

function stPF.DDDRes_Specified(Index: Integer): boolean;
begin
  Result := FDDDRes_Specified;
end;

procedure stPF.SetTelefoneRes(Index: Integer; const Astring: string);
begin
  FTelefoneRes := Astring;
  FTelefoneRes_Specified := True;
end;

function stPF.TelefoneRes_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneRes_Specified;
end;

procedure stPF.SetSituacaoRes(Index: Integer; const Astring: string);
begin
  FSituacaoRes := Astring;
  FSituacaoRes_Specified := True;
end;

function stPF.SituacaoRes_Specified(Index: Integer): boolean;
begin
  Result := FSituacaoRes_Specified;
end;

procedure stPF.SetVlrAluguelRes(Index: Integer; const Astring: string);
begin
  FVlrAluguelRes := Astring;
  FVlrAluguelRes_Specified := True;
end;

function stPF.VlrAluguelRes_Specified(Index: Integer): boolean;
begin
  Result := FVlrAluguelRes_Specified;
end;

procedure stPF.SetEmpresa(Index: Integer; const Astring: string);
begin
  FEmpresa := Astring;
  FEmpresa_Specified := True;
end;

function stPF.Empresa_Specified(Index: Integer): boolean;
begin
  Result := FEmpresa_Specified;
end;

procedure stPF.SetCargo(Index: Integer; const Astring: string);
begin
  FCargo := Astring;
  FCargo_Specified := True;
end;

function stPF.Cargo_Specified(Index: Integer): boolean;
begin
  Result := FCargo_Specified;
end;

procedure stPF.SetTempoEmp(Index: Integer; const Astring: string);
begin
  FTempoEmp := Astring;
  FTempoEmp_Specified := True;
end;

function stPF.TempoEmp_Specified(Index: Integer): boolean;
begin
  Result := FTempoEmp_Specified;
end;

procedure stPF.SetTempoEmpAno(Index: Integer; const Astring: string);
begin
  FTempoEmpAno := Astring;
  FTempoEmpAno_Specified := True;
end;

function stPF.TempoEmpAno_Specified(Index: Integer): boolean;
begin
  Result := FTempoEmpAno_Specified;
end;

procedure stPF.SetTempoEmpMes(Index: Integer; const Astring: string);
begin
  FTempoEmpMes := Astring;
  FTempoEmpMes_Specified := True;
end;

function stPF.TempoEmpMes_Specified(Index: Integer): boolean;
begin
  Result := FTempoEmpMes_Specified;
end;

procedure stPF.SetSalario(Index: Integer; const Astring: string);
begin
  FSalario := Astring;
  FSalario_Specified := True;
end;

function stPF.Salario_Specified(Index: Integer): boolean;
begin
  Result := FSalario_Specified;
end;

procedure stPF.SetEnderecoEmp(Index: Integer; const Astring: string);
begin
  FEnderecoEmp := Astring;
  FEnderecoEmp_Specified := True;
end;

function stPF.EnderecoEmp_Specified(Index: Integer): boolean;
begin
  Result := FEnderecoEmp_Specified;
end;

procedure stPF.SetNumeroEmp(Index: Integer; const Astring: string);
begin
  FNumeroEmp := Astring;
  FNumeroEmp_Specified := True;
end;

function stPF.NumeroEmp_Specified(Index: Integer): boolean;
begin
  Result := FNumeroEmp_Specified;
end;

procedure stPF.SetComplementoEmp(Index: Integer; const Astring: string);
begin
  FComplementoEmp := Astring;
  FComplementoEmp_Specified := True;
end;

function stPF.ComplementoEmp_Specified(Index: Integer): boolean;
begin
  Result := FComplementoEmp_Specified;
end;

procedure stPF.SetBairroEmp(Index: Integer; const Astring: string);
begin
  FBairroEmp := Astring;
  FBairroEmp_Specified := True;
end;

function stPF.BairroEmp_Specified(Index: Integer): boolean;
begin
  Result := FBairroEmp_Specified;
end;

procedure stPF.SetCidadeEmp(Index: Integer; const Astring: string);
begin
  FCidadeEmp := Astring;
  FCidadeEmp_Specified := True;
end;

function stPF.CidadeEmp_Specified(Index: Integer): boolean;
begin
  Result := FCidadeEmp_Specified;
end;

procedure stPF.SetUFEmp(Index: Integer; const Astring: string);
begin
  FUFEmp := Astring;
  FUFEmp_Specified := True;
end;

function stPF.UFEmp_Specified(Index: Integer): boolean;
begin
  Result := FUFEmp_Specified;
end;

procedure stPF.SetCEPEmp(Index: Integer; const Astring: string);
begin
  FCEPEmp := Astring;
  FCEPEmp_Specified := True;
end;

function stPF.CEPEmp_Specified(Index: Integer): boolean;
begin
  Result := FCEPEmp_Specified;
end;

procedure stPF.SetDDDEmp(Index: Integer; const Astring: string);
begin
  FDDDEmp := Astring;
  FDDDEmp_Specified := True;
end;

function stPF.DDDEmp_Specified(Index: Integer): boolean;
begin
  Result := FDDDEmp_Specified;
end;

procedure stPF.SetTelefoneEmp(Index: Integer; const Astring: string);
begin
  FTelefoneEmp := Astring;
  FTelefoneEmp_Specified := True;
end;

function stPF.TelefoneEmp_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneEmp_Specified;
end;

procedure stPF.SetRamalEmp(Index: Integer; const Astring: string);
begin
  FRamalEmp := Astring;
  FRamalEmp_Specified := True;
end;

function stPF.RamalEmp_Specified(Index: Integer): boolean;
begin
  Result := FRamalEmp_Specified;
end;

procedure stPF.SetDDDEmp2(Index: Integer; const Astring: string);
begin
  FDDDEmp2 := Astring;
  FDDDEmp2_Specified := True;
end;

function stPF.DDDEmp2_Specified(Index: Integer): boolean;
begin
  Result := FDDDEmp2_Specified;
end;

procedure stPF.SetTelefoneEmp2(Index: Integer; const Astring: string);
begin
  FTelefoneEmp2 := Astring;
  FTelefoneEmp2_Specified := True;
end;

function stPF.TelefoneEmp2_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneEmp2_Specified;
end;

procedure stPF.SetRamalEmp2(Index: Integer; const Astring: string);
begin
  FRamalEmp2 := Astring;
  FRamalEmp2_Specified := True;
end;

function stPF.RamalEmp2_Specified(Index: Integer): boolean;
begin
  Result := FRamalEmp2_Specified;
end;

procedure stPF.SetOutrasRendas(Index: Integer; const Astring: string);
begin
  FOutrasRendas := Astring;
  FOutrasRendas_Specified := True;
end;

function stPF.OutrasRendas_Specified(Index: Integer): boolean;
begin
  Result := FOutrasRendas_Specified;
end;

procedure stPF.SetVlrOutrasRendas(Index: Integer; const Astring: string);
begin
  FVlrOutrasRendas := Astring;
  FVlrOutrasRendas_Specified := True;
end;

function stPF.VlrOutrasRendas_Specified(Index: Integer): boolean;
begin
  Result := FVlrOutrasRendas_Specified;
end;

procedure stPF.SetEmpresaAnt(Index: Integer; const Astring: string);
begin
  FEmpresaAnt := Astring;
  FEmpresaAnt_Specified := True;
end;

function stPF.EmpresaAnt_Specified(Index: Integer): boolean;
begin
  Result := FEmpresaAnt_Specified;
end;

procedure stPF.SetAdmissaoAnt(Index: Integer; const Astring: string);
begin
  FAdmissaoAnt := Astring;
  FAdmissaoAnt_Specified := True;
end;

function stPF.AdmissaoAnt_Specified(Index: Integer): boolean;
begin
  Result := FAdmissaoAnt_Specified;
end;

procedure stPF.SetDemissaoAnt(Index: Integer; const Astring: string);
begin
  FDemissaoAnt := Astring;
  FDemissaoAnt_Specified := True;
end;

function stPF.DemissaoAnt_Specified(Index: Integer): boolean;
begin
  Result := FDemissaoAnt_Specified;
end;

procedure stPF.SetDDDAnt(Index: Integer; const Astring: string);
begin
  FDDDAnt := Astring;
  FDDDAnt_Specified := True;
end;

function stPF.DDDAnt_Specified(Index: Integer): boolean;
begin
  Result := FDDDAnt_Specified;
end;

procedure stPF.SetFoneAnt(Index: Integer; const Astring: string);
begin
  FFoneAnt := Astring;
  FFoneAnt_Specified := True;
end;

function stPF.FoneAnt_Specified(Index: Integer): boolean;
begin
  Result := FFoneAnt_Specified;
end;

procedure stPF.SetRamalAnt(Index: Integer; const Astring: string);
begin
  FRamalAnt := Astring;
  FRamalAnt_Specified := True;
end;

function stPF.RamalAnt_Specified(Index: Integer): boolean;
begin
  Result := FRamalAnt_Specified;
end;

procedure stPF.SetNomeConj(Index: Integer; const Astring: string);
begin
  FNomeConj := Astring;
  FNomeConj_Specified := True;
end;

function stPF.NomeConj_Specified(Index: Integer): boolean;
begin
  Result := FNomeConj_Specified;
end;

procedure stPF.SetCPFConj(Index: Integer; const Astring: string);
begin
  FCPFConj := Astring;
  FCPFConj_Specified := True;
end;

function stPF.CPFConj_Specified(Index: Integer): boolean;
begin
  Result := FCPFConj_Specified;
end;

procedure stPF.SetNascimentoConj(Index: Integer; const Astring: string);
begin
  FNascimentoConj := Astring;
  FNascimentoConj_Specified := True;
end;

function stPF.NascimentoConj_Specified(Index: Integer): boolean;
begin
  Result := FNascimentoConj_Specified;
end;

procedure stPF.SetMaeConj(Index: Integer; const Astring: string);
begin
  FMaeConj := Astring;
  FMaeConj_Specified := True;
end;

function stPF.MaeConj_Specified(Index: Integer): boolean;
begin
  Result := FMaeConj_Specified;
end;

procedure stPF.SetRGConj(Index: Integer; const Astring: string);
begin
  FRGConj := Astring;
  FRGConj_Specified := True;
end;

function stPF.RGConj_Specified(Index: Integer): boolean;
begin
  Result := FRGConj_Specified;
end;

procedure stPF.SetEmissorRGConj(Index: Integer; const Astring: string);
begin
  FEmissorRGConj := Astring;
  FEmissorRGConj_Specified := True;
end;

function stPF.EmissorRGConj_Specified(Index: Integer): boolean;
begin
  Result := FEmissorRGConj_Specified;
end;

procedure stPF.SetDataEmissaoRGConj(Index: Integer; const Astring: string);
begin
  FDataEmissaoRGConj := Astring;
  FDataEmissaoRGConj_Specified := True;
end;

function stPF.DataEmissaoRGConj_Specified(Index: Integer): boolean;
begin
  Result := FDataEmissaoRGConj_Specified;
end;

procedure stPF.SetEmpresaConj(Index: Integer; const Astring: string);
begin
  FEmpresaConj := Astring;
  FEmpresaConj_Specified := True;
end;

function stPF.EmpresaConj_Specified(Index: Integer): boolean;
begin
  Result := FEmpresaConj_Specified;
end;

procedure stPF.SetCargoConj(Index: Integer; const Astring: string);
begin
  FCargoConj := Astring;
  FCargoConj_Specified := True;
end;

function stPF.CargoConj_Specified(Index: Integer): boolean;
begin
  Result := FCargoConj_Specified;
end;

procedure stPF.SetTempoConj(Index: Integer; const Astring: string);
begin
  FTempoConj := Astring;
  FTempoConj_Specified := True;
end;

function stPF.TempoConj_Specified(Index: Integer): boolean;
begin
  Result := FTempoConj_Specified;
end;

procedure stPF.SetTempoConjAno(Index: Integer; const Astring: string);
begin
  FTempoConjAno := Astring;
  FTempoConjAno_Specified := True;
end;

function stPF.TempoConjAno_Specified(Index: Integer): boolean;
begin
  Result := FTempoConjAno_Specified;
end;

procedure stPF.SetTempoConjMes(Index: Integer; const Astring: string);
begin
  FTempoConjMes := Astring;
  FTempoConjMes_Specified := True;
end;

function stPF.TempoConjMes_Specified(Index: Integer): boolean;
begin
  Result := FTempoConjMes_Specified;
end;

procedure stPF.SetSalarioConj(Index: Integer; const Astring: string);
begin
  FSalarioConj := Astring;
  FSalarioConj_Specified := True;
end;

function stPF.SalarioConj_Specified(Index: Integer): boolean;
begin
  Result := FSalarioConj_Specified;
end;

procedure stPF.SetEnderecoConj(Index: Integer; const Astring: string);
begin
  FEnderecoConj := Astring;
  FEnderecoConj_Specified := True;
end;

function stPF.EnderecoConj_Specified(Index: Integer): boolean;
begin
  Result := FEnderecoConj_Specified;
end;

procedure stPF.SetNumeroConj(Index: Integer; const Astring: string);
begin
  FNumeroConj := Astring;
  FNumeroConj_Specified := True;
end;

function stPF.NumeroConj_Specified(Index: Integer): boolean;
begin
  Result := FNumeroConj_Specified;
end;

procedure stPF.SetComplementoConj(Index: Integer; const Astring: string);
begin
  FComplementoConj := Astring;
  FComplementoConj_Specified := True;
end;

function stPF.ComplementoConj_Specified(Index: Integer): boolean;
begin
  Result := FComplementoConj_Specified;
end;

procedure stPF.SetBairroConj(Index: Integer; const Astring: string);
begin
  FBairroConj := Astring;
  FBairroConj_Specified := True;
end;

function stPF.BairroConj_Specified(Index: Integer): boolean;
begin
  Result := FBairroConj_Specified;
end;

procedure stPF.SetCidadeConj(Index: Integer; const Astring: string);
begin
  FCidadeConj := Astring;
  FCidadeConj_Specified := True;
end;

function stPF.CidadeConj_Specified(Index: Integer): boolean;
begin
  Result := FCidadeConj_Specified;
end;

procedure stPF.SetUFConj(Index: Integer; const Astring: string);
begin
  FUFConj := Astring;
  FUFConj_Specified := True;
end;

function stPF.UFConj_Specified(Index: Integer): boolean;
begin
  Result := FUFConj_Specified;
end;

procedure stPF.SetCEPConj(Index: Integer; const Astring: string);
begin
  FCEPConj := Astring;
  FCEPConj_Specified := True;
end;

function stPF.CEPConj_Specified(Index: Integer): boolean;
begin
  Result := FCEPConj_Specified;
end;

procedure stPF.SetDDDConj(Index: Integer; const Astring: string);
begin
  FDDDConj := Astring;
  FDDDConj_Specified := True;
end;

function stPF.DDDConj_Specified(Index: Integer): boolean;
begin
  Result := FDDDConj_Specified;
end;

procedure stPF.SetTelefoneConj(Index: Integer; const Astring: string);
begin
  FTelefoneConj := Astring;
  FTelefoneConj_Specified := True;
end;

function stPF.TelefoneConj_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneConj_Specified;
end;

procedure stPF.SetRamalConj(Index: Integer; const Astring: string);
begin
  FRamalConj := Astring;
  FRamalConj_Specified := True;
end;

function stPF.RamalConj_Specified(Index: Integer): boolean;
begin
  Result := FRamalConj_Specified;
end;

procedure stPF.SetDDDConj2(Index: Integer; const Astring: string);
begin
  FDDDConj2 := Astring;
  FDDDConj2_Specified := True;
end;

function stPF.DDDConj2_Specified(Index: Integer): boolean;
begin
  Result := FDDDConj2_Specified;
end;

procedure stPF.SetTelefoneConj2(Index: Integer; const Astring: string);
begin
  FTelefoneConj2 := Astring;
  FTelefoneConj2_Specified := True;
end;

function stPF.TelefoneConj2_Specified(Index: Integer): boolean;
begin
  Result := FTelefoneConj2_Specified;
end;

procedure stPF.SetRamalConj2(Index: Integer; const Astring: string);
begin
  FRamalConj2 := Astring;
  FRamalConj2_Specified := True;
end;

function stPF.RamalConj2_Specified(Index: Integer): boolean;
begin
  Result := FRamalConj2_Specified;
end;

procedure stPF.SetOutrasRendasConj(Index: Integer; const Astring: string);
begin
  FOutrasRendasConj := Astring;
  FOutrasRendasConj_Specified := True;
end;

function stPF.OutrasRendasConj_Specified(Index: Integer): boolean;
begin
  Result := FOutrasRendasConj_Specified;
end;

procedure stPF.SetVlrOutrasRendasConj(Index: Integer; const Astring: string);
begin
  FVlrOutrasRendasConj := Astring;
  FVlrOutrasRendasConj_Specified := True;
end;

function stPF.VlrOutrasRendasConj_Specified(Index: Integer): boolean;
begin
  Result := FVlrOutrasRendasConj_Specified;
end;

procedure stPF.SetNome1(Index: Integer; const Astring: string);
begin
  FNome1 := Astring;
  FNome1_Specified := True;
end;

function stPF.Nome1_Specified(Index: Integer): boolean;
begin
  Result := FNome1_Specified;
end;

procedure stPF.SetDDD1(Index: Integer; const Astring: string);
begin
  FDDD1 := Astring;
  FDDD1_Specified := True;
end;

function stPF.DDD1_Specified(Index: Integer): boolean;
begin
  Result := FDDD1_Specified;
end;

procedure stPF.SetFone1(Index: Integer; const Astring: string);
begin
  FFone1 := Astring;
  FFone1_Specified := True;
end;

function stPF.Fone1_Specified(Index: Integer): boolean;
begin
  Result := FFone1_Specified;
end;

procedure stPF.SetRamal1(Index: Integer; const Astring: string);
begin
  FRamal1 := Astring;
  FRamal1_Specified := True;
end;

function stPF.Ramal1_Specified(Index: Integer): boolean;
begin
  Result := FRamal1_Specified;
end;

procedure stPF.SetRef1GrauParentesco(Index: Integer; const Astring: string);
begin
  FRef1GrauParentesco := Astring;
  FRef1GrauParentesco_Specified := True;
end;

function stPF.Ref1GrauParentesco_Specified(Index: Integer): boolean;
begin
  Result := FRef1GrauParentesco_Specified;
end;

procedure stPF.SetNome2(Index: Integer; const Astring: string);
begin
  FNome2 := Astring;
  FNome2_Specified := True;
end;

function stPF.Nome2_Specified(Index: Integer): boolean;
begin
  Result := FNome2_Specified;
end;

procedure stPF.SetDDD2(Index: Integer; const Astring: string);
begin
  FDDD2 := Astring;
  FDDD2_Specified := True;
end;

function stPF.DDD2_Specified(Index: Integer): boolean;
begin
  Result := FDDD2_Specified;
end;

procedure stPF.SetFone2(Index: Integer; const Astring: string);
begin
  FFone2 := Astring;
  FFone2_Specified := True;
end;

function stPF.Fone2_Specified(Index: Integer): boolean;
begin
  Result := FFone2_Specified;
end;

procedure stPF.SetRamal2(Index: Integer; const Astring: string);
begin
  FRamal2 := Astring;
  FRamal2_Specified := True;
end;

function stPF.Ramal2_Specified(Index: Integer): boolean;
begin
  Result := FRamal2_Specified;
end;

procedure stPF.SetRef2GrauParentesco(Index: Integer; const Astring: string);
begin
  FRef2GrauParentesco := Astring;
  FRef2GrauParentesco_Specified := True;
end;

function stPF.Ref2GrauParentesco_Specified(Index: Integer): boolean;
begin
  Result := FRef2GrauParentesco_Specified;
end;

procedure stPF.SetNome3(Index: Integer; const Astring: string);
begin
  FNome3 := Astring;
  FNome3_Specified := True;
end;

function stPF.Nome3_Specified(Index: Integer): boolean;
begin
  Result := FNome3_Specified;
end;

procedure stPF.SetDDD3(Index: Integer; const Astring: string);
begin
  FDDD3 := Astring;
  FDDD3_Specified := True;
end;

function stPF.DDD3_Specified(Index: Integer): boolean;
begin
  Result := FDDD3_Specified;
end;

procedure stPF.SetFone3(Index: Integer; const Astring: string);
begin
  FFone3 := Astring;
  FFone3_Specified := True;
end;

function stPF.Fone3_Specified(Index: Integer): boolean;
begin
  Result := FFone3_Specified;
end;

procedure stPF.SetRamal3(Index: Integer; const Astring: string);
begin
  FRamal3 := Astring;
  FRamal3_Specified := True;
end;

function stPF.Ramal3_Specified(Index: Integer): boolean;
begin
  Result := FRamal3_Specified;
end;

procedure stPF.SetRef3GrauParentesco(Index: Integer; const Astring: string);
begin
  FRef3GrauParentesco := Astring;
  FRef3GrauParentesco_Specified := True;
end;

function stPF.Ref3GrauParentesco_Specified(Index: Integer): boolean;
begin
  Result := FRef3GrauParentesco_Specified;
end;

procedure stPF.SetNome4(Index: Integer; const Astring: string);
begin
  FNome4 := Astring;
  FNome4_Specified := True;
end;

function stPF.Nome4_Specified(Index: Integer): boolean;
begin
  Result := FNome4_Specified;
end;

procedure stPF.SetDDD4(Index: Integer; const Astring: string);
begin
  FDDD4 := Astring;
  FDDD4_Specified := True;
end;

function stPF.DDD4_Specified(Index: Integer): boolean;
begin
  Result := FDDD4_Specified;
end;

procedure stPF.SetFone4(Index: Integer; const Astring: string);
begin
  FFone4 := Astring;
  FFone4_Specified := True;
end;

function stPF.Fone4_Specified(Index: Integer): boolean;
begin
  Result := FFone4_Specified;
end;

procedure stPF.SetRamal4(Index: Integer; const Astring: string);
begin
  FRamal4 := Astring;
  FRamal4_Specified := True;
end;

function stPF.Ramal4_Specified(Index: Integer): boolean;
begin
  Result := FRamal4_Specified;
end;

procedure stPF.SetRef4GrauParentesco(Index: Integer; const Astring: string);
begin
  FRef4GrauParentesco := Astring;
  FRef4GrauParentesco_Specified := True;
end;

function stPF.Ref4GrauParentesco_Specified(Index: Integer): boolean;
begin
  Result := FRef4GrauParentesco_Specified;
end;

procedure stPF.SetNomeCom1(Index: Integer; const Astring: string);
begin
  FNomeCom1 := Astring;
  FNomeCom1_Specified := True;
end;

function stPF.NomeCom1_Specified(Index: Integer): boolean;
begin
  Result := FNomeCom1_Specified;
end;

procedure stPF.SetDDDCom1(Index: Integer; const Astring: string);
begin
  FDDDCom1 := Astring;
  FDDDCom1_Specified := True;
end;

function stPF.DDDCom1_Specified(Index: Integer): boolean;
begin
  Result := FDDDCom1_Specified;
end;

procedure stPF.SetFoneCom1(Index: Integer; const Astring: string);
begin
  FFoneCom1 := Astring;
  FFoneCom1_Specified := True;
end;

function stPF.FoneCom1_Specified(Index: Integer): boolean;
begin
  Result := FFoneCom1_Specified;
end;

procedure stPF.SetRamalCom1(Index: Integer; const Astring: string);
begin
  FRamalCom1 := Astring;
  FRamalCom1_Specified := True;
end;

function stPF.RamalCom1_Specified(Index: Integer): boolean;
begin
  Result := FRamalCom1_Specified;
end;

procedure stPF.SetNomeCom2(Index: Integer; const Astring: string);
begin
  FNomeCom2 := Astring;
  FNomeCom2_Specified := True;
end;

function stPF.NomeCom2_Specified(Index: Integer): boolean;
begin
  Result := FNomeCom2_Specified;
end;

procedure stPF.SetDDDCom2(Index: Integer; const Astring: string);
begin
  FDDDCom2 := Astring;
  FDDDCom2_Specified := True;
end;

function stPF.DDDCom2_Specified(Index: Integer): boolean;
begin
  Result := FDDDCom2_Specified;
end;

procedure stPF.SetFoneCom2(Index: Integer; const Astring: string);
begin
  FFoneCom2 := Astring;
  FFoneCom2_Specified := True;
end;

function stPF.FoneCom2_Specified(Index: Integer): boolean;
begin
  Result := FFoneCom2_Specified;
end;

procedure stPF.SetRamalCom2(Index: Integer; const Astring: string);
begin
  FRamalCom2 := Astring;
  FRamalCom2_Specified := True;
end;

function stPF.RamalCom2_Specified(Index: Integer): boolean;
begin
  Result := FRamalCom2_Specified;
end;

procedure stPF.SetBanco(Index: Integer; const Astring: string);
begin
  FBanco := Astring;
  FBanco_Specified := True;
end;

function stPF.Banco_Specified(Index: Integer): boolean;
begin
  Result := FBanco_Specified;
end;

procedure stPF.SetAgencia(Index: Integer; const Astring: string);
begin
  FAgencia := Astring;
  FAgencia_Specified := True;
end;

function stPF.Agencia_Specified(Index: Integer): boolean;
begin
  Result := FAgencia_Specified;
end;

procedure stPF.SetConta(Index: Integer; const Astring: string);
begin
  FConta := Astring;
  FConta_Specified := True;
end;

function stPF.Conta_Specified(Index: Integer): boolean;
begin
  Result := FConta_Specified;
end;

procedure stPF.SetEspecial(Index: Integer; const Astring: string);
begin
  FEspecial := Astring;
  FEspecial_Specified := True;
end;

function stPF.Especial_Specified(Index: Integer): boolean;
begin
  Result := FEspecial_Specified;
end;

procedure stPF.SetContadesde(Index: Integer; const Astring: string);
begin
  FContadesde := Astring;
  FContadesde_Specified := True;
end;

function stPF.Contadesde_Specified(Index: Integer): boolean;
begin
  Result := FContadesde_Specified;
end;

procedure stPF.SetCidadeConta(Index: Integer; const Astring: string);
begin
  FCidadeConta := Astring;
  FCidadeConta_Specified := True;
end;

function stPF.CidadeConta_Specified(Index: Integer): boolean;
begin
  Result := FCidadeConta_Specified;
end;

procedure stPF.SetVeiculo(Index: Integer; const Astring: string);
begin
  FVeiculo := Astring;
  FVeiculo_Specified := True;
end;

function stPF.Veiculo_Specified(Index: Integer): boolean;
begin
  Result := FVeiculo_Specified;
end;

procedure stPF.SetRenavan(Index: Integer; const Astring: string);
begin
  FRenavan := Astring;
  FRenavan_Specified := True;
end;

function stPF.Renavan_Specified(Index: Integer): boolean;
begin
  Result := FRenavan_Specified;
end;

procedure stPF.SetCartaoCredito(Index: Integer; const Astring: string);
begin
  FCartaoCredito := Astring;
  FCartaoCredito_Specified := True;
end;

function stPF.CartaoCredito_Specified(Index: Integer): boolean;
begin
  Result := FCartaoCredito_Specified;
end;

procedure stPF.Setno_ddd_or(Index: Integer; const Astring: string);
begin
  Fno_ddd_or := Astring;
  Fno_ddd_or_Specified := True;
end;

function stPF.no_ddd_or_Specified(Index: Integer): boolean;
begin
  Result := Fno_ddd_or_Specified;
end;

procedure stPF.Setno_fone_or(Index: Integer; const Astring: string);
begin
  Fno_fone_or := Astring;
  Fno_fone_or_Specified := True;
end;

function stPF.no_fone_or_Specified(Index: Integer): boolean;
begin
  Result := Fno_fone_or_Specified;
end;

procedure stPF.Setno_ramal_or(Index: Integer; const Astring: string);
begin
  Fno_ramal_or := Astring;
  Fno_ramal_or_Specified := True;
end;

function stPF.no_ramal_or_Specified(Index: Integer): boolean;
begin
  Result := Fno_ramal_or_Specified;
end;

procedure stPF.Setno_ddd_or_conj(Index: Integer; const Astring: string);
begin
  Fno_ddd_or_conj := Astring;
  Fno_ddd_or_conj_Specified := True;
end;

function stPF.no_ddd_or_conj_Specified(Index: Integer): boolean;
begin
  Result := Fno_ddd_or_conj_Specified;
end;

procedure stPF.Setno_fone_or_conj(Index: Integer; const Astring: string);
begin
  Fno_fone_or_conj := Astring;
  Fno_fone_or_conj_Specified := True;
end;

function stPF.no_fone_or_conj_Specified(Index: Integer): boolean;
begin
  Result := Fno_fone_or_conj_Specified;
end;

procedure stPF.Setno_ramal_or_conj(Index: Integer; const Astring: string);
begin
  Fno_ramal_or_conj := Astring;
  Fno_ramal_or_conj_Specified := True;
end;

function stPF.no_ramal_or_conj_Specified(Index: Integer): boolean;
begin
  Result := Fno_ramal_or_conj_Specified;
end;

procedure stPF.Setno_beneficio_conj(Index: Integer; const Astring: string);
begin
  Fno_beneficio_conj := Astring;
  Fno_beneficio_conj_Specified := True;
end;

function stPF.no_beneficio_conj_Specified(Index: Integer): boolean;
begin
  Result := Fno_beneficio_conj_Specified;
end;

procedure stPF.Setno_cgc(Index: Integer; const Astring: string);
begin
  Fno_cgc := Astring;
  Fno_cgc_Specified := True;
end;

function stPF.no_cgc_Specified(Index: Integer): boolean;
begin
  Result := Fno_cgc_Specified;
end;

procedure stPF.Setds_contador(Index: Integer; const Astring: string);
begin
  Fds_contador := Astring;
  Fds_contador_Specified := True;
end;

function stPF.ds_contador_Specified(Index: Integer): boolean;
begin
  Result := Fds_contador_Specified;
end;

procedure stPF.Setcd_dddcontador(Index: Integer; const Astring: string);
begin
  Fcd_dddcontador := Astring;
  Fcd_dddcontador_Specified := True;
end;

function stPF.cd_dddcontador_Specified(Index: Integer): boolean;
begin
  Result := Fcd_dddcontador_Specified;
end;

procedure stPF.Setno_fonecontador(Index: Integer; const Astring: string);
begin
  Fno_fonecontador := Astring;
  Fno_fonecontador_Specified := True;
end;

function stPF.no_fonecontador_Specified(Index: Integer): boolean;
begin
  Result := Fno_fonecontador_Specified;
end;

procedure stPF.Setno_ramalcontador(Index: Integer; const Astring: string);
begin
  Fno_ramalcontador := Astring;
  Fno_ramalcontador_Specified := True;
end;

function stPF.no_ramalcontador_Specified(Index: Integer): boolean;
begin
  Result := Fno_ramalcontador_Specified;
end;

procedure stPF.SetcrgId(Index: Integer; const Astring: string);
begin
  FcrgId := Astring;
  FcrgId_Specified := True;
end;

function stPF.crgId_Specified(Index: Integer): boolean;
begin
  Result := FcrgId_Specified;
end;

procedure stPF.SetcrgIdConj(Index: Integer; const Astring: string);
begin
  FcrgIdConj := Astring;
  FcrgIdConj_Specified := True;
end;

function stPF.crgIdConj_Specified(Index: Integer): boolean;
begin
  Result := FcrgIdConj_Specified;
end;

procedure stPF.SetcodIBGE(Index: Integer; const Astring: string);
begin
  FcodIBGE := Astring;
  FcodIBGE_Specified := True;
end;

function stPF.codIBGE_Specified(Index: Integer): boolean;
begin
  Result := FcodIBGE_Specified;
end;

procedure stRetornoCancelamento2.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function stRetornoCancelamento2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure stRetornoCancelamento2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function stRetornoCancelamento2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure stRetornoStatus2.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function stRetornoStatus2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure stRetornoStatus2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function stRetornoStatus2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure stRetornoStatus2.Setcontrato(Index: Integer; const Astring: string);
begin
  Fcontrato := Astring;
  Fcontrato_Specified := True;
end;

function stRetornoStatus2.contrato_Specified(Index: Integer): boolean;
begin
  Result := Fcontrato_Specified;
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

procedure stRetornoPropostaNova2.Setproposta(Index: Integer; const Astring: string);
begin
  Fproposta := Astring;
  Fproposta_Specified := True;
end;

function stRetornoPropostaNova2.proposta_Specified(Index: Integer): boolean;
begin
  Result := Fproposta_Specified;
end;

procedure stRetornoPropostaNova2.Setstatus(Index: Integer; const Astring: string);
begin
  Fstatus := Astring;
  Fstatus_Specified := True;
end;

function stRetornoPropostaNova2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure stRetornoPropostaNova2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function stRetornoPropostaNova2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure stRetornoPropostaNova2.Setconcatenado(Index: Integer; const Astring: string);
begin
  Fconcatenado := Astring;
  Fconcatenado_Specified := True;
end;

function stRetornoPropostaNova2.concatenado_Specified(Index: Integer): boolean;
begin
  Result := Fconcatenado_Specified;
end;

procedure stRetornoPropostaNova2.Setprocessamento(Index: Integer; const Astring: string);
begin
  Fprocessamento := Astring;
  Fprocessamento_Specified := True;
end;

function stRetornoPropostaNova2.processamento_Specified(Index: Integer): boolean;
begin
  Result := Fprocessamento_Specified;
end;

destructor stNovaProposta.Destroy;
begin
  SysUtils.FreeAndNil(FstDadosPessoaFisica);
  SysUtils.FreeAndNil(FstDadosProposta);
  inherited Destroy;
end;

procedure stRetorno2.SetaditivoBoleto(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FaditivoBoleto := ATByteDynArray;
  FaditivoBoleto_Specified := True;
end;

function stRetorno2.aditivoBoleto_Specified(Index: Integer): boolean;
begin
  Result := FaditivoBoleto_Specified;
end;

procedure stRetorno2.Setsituacao(Index: Integer; const Astring: string);
begin
  Fsituacao := Astring;
  Fsituacao_Specified := True;
end;

function stRetorno2.situacao_Specified(Index: Integer): boolean;
begin
  Result := Fsituacao_Specified;
end;

procedure stRetorno2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function stRetorno2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

initialization
  { analisadorSoap }
  InvRegistry.RegisterInterface(TypeInfo(analisadorSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(analisadorSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(analisadorSoap), ioDocument);
  { analisadorSoap.StatusPropostaS }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'StatusPropostaS', '',
                                 '[ReturnName="StatusPropostaSResult"]', IS_OPTN);
  { analisadorSoap.StatusProposta }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'StatusProposta', '',
                                 '[ReturnName="StatusPropostaResult"]');
  { analisadorSoap.FechamentoBordero }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'FechamentoBordero', '',
                                 '[ReturnName="FechamentoBorderoResult"]');
  { analisadorSoap.Conciliacao }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'Conciliacao', '',
                                 '[ReturnName="ConciliacaoResult"]', IS_OPTN);
  { analisadorSoap.StatusPropostaNovo }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'StatusPropostaNovo', '',
                                 '[ReturnName="StatusPropostaNovoResult"]');
  { analisadorSoap.StatusProcessamentoProposta }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'StatusProcessamentoProposta', '',
                                 '[ReturnName="StatusProcessamentoPropostaResult"]');
  { analisadorSoap.CancelamentoProposta }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'CancelamentoProposta', '',
                                 '[ReturnName="CancelamentoPropostaResult"]');
  { analisadorSoap.NovaPropostaJuridica }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'NovaPropostaJuridica', '',
                                 '[ReturnName="NovaPropostaJuridicaResult"]');
  { analisadorSoap.RetornaAditivoEBoleto }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'RetornaAditivoEBoleto', '',
                                 '[ReturnName="RetornaAditivoEBoletoResult"]');
  { analisadorSoap.PropostaPessoaFisica }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'PropostaPessoaFisica', '',
                                 '[ReturnName="PropostaPessoaFisicaResult"]');
  { analisadorSoap.PropostaRetorno }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'PropostaRetorno', '',
                                 '[ReturnName="PropostaRetornoResult"]');
  { analisadorSoap.NovaPropostaFisica }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'NovaPropostaFisica', '',
                                 '[ReturnName="NovaPropostaFisicaResult"]');
  { analisadorSoap.NovaPropostaJuridicaEstrutura }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'NovaPropostaJuridicaEstrutura', '',
                                 '[ReturnName="NovaPropostaJuridicaEstruturaResult"]');
  { analisadorSoap.NovaPropostaFisicaEstrutura }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'NovaPropostaFisicaEstrutura', '',
                                 '[ReturnName="NovaPropostaFisicaEstruturaResult"]');
  { analisadorSoap.NovaPropostaFisicaCartaoEstrutura }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'NovaPropostaFisicaCartaoEstrutura', '',
                                 '[ReturnName="NovaPropostaFisicaCartaoEstruturaResult"]');
  { analisadorSoap.AnexarDocumento }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'AnexarDocumento', '',
                                 '[ReturnName="AnexarDocumentoResult"]');
  { analisadorSoap.AnexarDocumentoControladoria }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'AnexarDocumentoControladoria', '',
                                 '[ReturnName="AnexarDocumentoControladoriaResult"]');
  { analisadorSoap.Metodo02 }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'Metodo02', '',
                                 '[ReturnName="Metodo02Result"]');
  { analisadorSoap.Metodo03 }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'Metodo03', '',
                                 '[ReturnName="Metodo03Result"]');
  { analisadorSoap.Metodo01 }
  InvRegistry.RegisterMethodInfo(TypeInfo(analisadorSoap), 'Metodo01', '',
                                 '[ReturnName="Metodo01Result"]');
  { analisadorHttpGet }
  InvRegistry.RegisterInterface(TypeInfo(analisadorHttpGet), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(analisadorHttpGet), '');
  { analisadorHttpGet.AnexarDocumento }
  InvRegistry.RegisterParamInfo(TypeInfo(analisadorHttpGet), 'AnexarDocumento', 'arquivoBytes', '',
                                '[ArrayItemName="String"]');
  { analisadorHttpGet.AnexarDocumentoControladoria }
  InvRegistry.RegisterParamInfo(TypeInfo(analisadorHttpGet), 'AnexarDocumentoControladoria', 'arquivoBytes', '',
                                '[ArrayItemName="String"]');
  { analisadorHttpGet.Metodo02 }
  InvRegistry.RegisterParamInfo(TypeInfo(analisadorHttpGet), 'Metodo02', 'arquivoBytes', '',
                                '[ArrayItemName="String"]');
  { analisadorHttpGet.Metodo03 }
  InvRegistry.RegisterParamInfo(TypeInfo(analisadorHttpGet), 'Metodo03', 'arquivoBytes', '',
                                '[ArrayItemName="String"]');
  { analisadorHttpPost }
  InvRegistry.RegisterInterface(TypeInfo(analisadorHttpPost), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(analisadorHttpPost), '');
  { analisadorHttpPost.AnexarDocumento }
  InvRegistry.RegisterParamInfo(TypeInfo(analisadorHttpPost), 'AnexarDocumento', 'arquivoBytes', '',
                                '[ArrayItemName="String"]');
  { analisadorHttpPost.AnexarDocumentoControladoria }
  InvRegistry.RegisterParamInfo(TypeInfo(analisadorHttpPost), 'AnexarDocumentoControladoria', 'arquivoBytes', '',
                                '[ArrayItemName="String"]');
  { analisadorHttpPost.Metodo02 }
  InvRegistry.RegisterParamInfo(TypeInfo(analisadorHttpPost), 'Metodo02', 'arquivoBytes', '',
                                '[ArrayItemName="String"]');
  { analisadorHttpPost.Metodo03 }
  InvRegistry.RegisterParamInfo(TypeInfo(analisadorHttpPost), 'Metodo03', 'arquivoBytes', '',
                                '[ArrayItemName="String"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(string_), 'http://tempuri.org/', 'string_', 'string');
  RemClassRegistry.RegisterXSClass(stRetornoProposta2, 'http://tempuri.org/', 'stRetornoProposta2', 'stRetornoProposta');
  RemClassRegistry.RegisterXSClass(stRetornoProposta, 'http://tempuri.org/', 'stRetornoProposta');
  RemClassRegistry.RegisterXSInfo(TypeInfo(StringArray), 'http://tempuri.org/AbstractTypes', 'StringArray');
  RemClassRegistry.RegisterXSClass(stRetornoStatusBordero2, 'http://tempuri.org/', 'stRetornoStatusBordero2', 'stRetornoStatusBordero');
  RemClassRegistry.RegisterXSClass(stRetornoStatusBordero, 'http://tempuri.org/', 'stRetornoStatusBordero');
  RemClassRegistry.RegisterXSClass(stProposta, 'http://tempuri.org/', 'stProposta');
  RemClassRegistry.RegisterXSClass(stRetornoMensagem2, 'http://tempuri.org/', 'stRetornoMensagem2', 'stRetornoMensagem');
  RemClassRegistry.RegisterXSClass(stRetornoMensagem, 'http://tempuri.org/', 'stRetornoMensagem');
  RemClassRegistry.RegisterXSClass(stCartao, 'http://tempuri.org/', 'stCartao');
  RemClassRegistry.RegisterXSClass(stPJ, 'http://tempuri.org/', 'stPJ');
  RemClassRegistry.RegisterXSClass(stPF, 'http://tempuri.org/', 'stPF');
  RemClassRegistry.RegisterXSClass(stRetornoCancelamento2, 'http://tempuri.org/', 'stRetornoCancelamento2', 'stRetornoCancelamento');
  RemClassRegistry.RegisterXSClass(stRetornoCancelamento, 'http://tempuri.org/', 'stRetornoCancelamento');
  RemClassRegistry.RegisterXSClass(stRetornoStatus2, 'http://tempuri.org/', 'stRetornoStatus2', 'stRetornoStatus');
  RemClassRegistry.RegisterXSClass(stRetornoStatus, 'http://tempuri.org/', 'stRetornoStatus');
  RemClassRegistry.RegisterXSClass(stRetornoPropostaNova2, 'http://tempuri.org/', 'stRetornoPropostaNova2', 'stRetornoPropostaNova');
  RemClassRegistry.RegisterXSClass(stRetornoPropostaNova, 'http://tempuri.org/', 'stRetornoPropostaNova');
  RemClassRegistry.RegisterXSClass(stNovaProposta, 'http://tempuri.org/', 'stNovaProposta');
  RemClassRegistry.RegisterXSClass(stRetorno2, 'http://tempuri.org/', 'stRetorno2', 'stRetorno');
  RemClassRegistry.RegisterXSClass(stRetorno, 'http://tempuri.org/', 'stRetorno');

end.