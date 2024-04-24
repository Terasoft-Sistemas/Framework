unit Terasoft.NotaFiscal.Configuracoes;

interface

uses
  pcnNFe,
  pcnConversao,
  pcnConversaoNFe,
  //Terasoft.Sistema.Configura,
  System.SysUtils,
  ACBrUtil.Base,
  Terasoft.Types,
  Interfaces.Conexao;

type
  TConfiguracoesNotaFiscal = class

  private
    vIConexao : IConexao;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy;

    function tipoEmissao: TpcnTipoEmissao;
    function ambiente: TpcnTipoAmbiente;
    function ufEmissao: String;
    function arquivosSalvar: Boolean;
    function arquivosSepararPorMes: Boolean;
    function arquivosAdicionarLiteral: Boolean;
    function arquivosEmissaoPathNFe: Boolean;
    function arquivosSalvarEvento: Boolean;
    function arquivosSepararPorCNPJ: Boolean;
    function arquivosSepararPorModelo: Boolean;
    function arquivosPathSchemas: String;
    function arquivosPathNFe: String;
    function arquivosPathInu: String;
    function arquivosPathEvento: String;
    function arquivosPathSalvar: String;
    function certificadoArquivoPFX: AnsiString;
    Function certificadoSenha: String;
    function DANFETipoDANFE: TpcnTipoImpressao;
    function DANFEPathLogo(pMOdNF: Integer): String;
    function DANFEPathPDF(pPathPDF: String): String;
    function IdCSC: String;
    function CSC: String;
    function modeloDF(pmoNFe: Integer): TpcnModeloDF;
    function versaoDF: TpcnVersaoDF;
    function versaoQRCode:  TpcnVersaoQrCode;
    function dhCont: TDateTime;
    function emitCNPJCPF: String;
    function emitIE: String;
    function emitxNome: String;
    function emitxFant: String;
    function emitfone: String;
    function emitCEP: String;
    function emitxLgr: String;
    function eEmitnro: String;
    function emitxCpl: String;
    function emitxBairro: String;
    function eEmitcMun: String;
    function emitxMun: String;
    function emitUF: String;
    function emitcPais: Integer;
    function emitxPais: String;
    function emitIEST(ufDestino:String): String;
    function emitCRT: TpcnCRT;
    function tpNF(ptpNF: String): TpcnTipoNFe;
    function finNFe(pfinNFe: String): TpcnFinalidadeNFe;
    function indIntermed(pindIntermed: String): TindIntermed;
    function indPres(PindPres: String): TpcnPresencaComprador;
    function idDest(pidDest: String): TpcnDestinoOperacao;
    function orig(porig: String): TpcnOrigemMercadoria;
    function CST(pCST: String): TpcnCSTIcms;
    function modBC(pmodBC: String): TpcnDeterminacaoBaseIcms;
    function CSOSN(pCSOSN: String): TpcnCSOSNIcms;
    function modBCST(pmodBCST: String): TpcnDeterminacaoBaseIcmsST;
    function cstipi(pcstipi: String): TpcnCstIpi;
    function cstpis(pcstpis: String): TpcnCstPis;
    function cstcof(pcstcof: String): TpcnCstCofins;
    function modFrete(pmodFrete: String): TpcnModalidadeFrete;
    function tPag(ptPag: String): TpcnFormaPagamento;
    function indIEDest(pindIEDest: String): TpcnindIEDest;
    function indFinal(pindFinal: String): TpcnConsumidorFinal;
  end;

implementation

{ TConfiguracoesNotaFiscal }

constructor TConfiguracoesNotaFiscal.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

function TConfiguracoesNotaFiscal.ambiente: TpcnTipoAmbiente;
begin
  case vIConexao.getConfiguracoes.NFE_AMBIENTE of
    1: Result := taProducao;
    2: Result := taHomologacao;
  end;

  Result := taHomologacao;
end;

function TConfiguracoesNotaFiscal.arquivosAdicionarLiteral: Boolean;
begin
  Result := True;
end;

function TConfiguracoesNotaFiscal.arquivosEmissaoPathNFe: Boolean;
begin
  Result := True;
end;

function TConfiguracoesNotaFiscal.arquivosPathEvento: String;
begin
  Result := ExtractFileDir(GetCurrentDir)+'\EVENTO';

  if vIConexao.getConfiguracoes.NFE_EVENTO_PATH <> '' then
    Result := vIConexao.getConfiguracoes.NFE_EVENTO_PATH;
end;

function TConfiguracoesNotaFiscal.arquivosPathInu: String;
begin
  Result := ExtractFileDir(GetCurrentDir);

  if vIConexao.getConfiguracoes.NFE_INUTILIZADO_PATH <> '' then
    Result := vIConexao.getConfiguracoes.NFE_INUTILIZADO_PATH;
end;

function TConfiguracoesNotaFiscal.arquivosPathNFe: String;
begin
  Result := ExtractFileDir(GetCurrentDir);

  if vIConexao.getConfiguracoes.NFE_XML_PATH <> '' then
    Result := vIConexao.getConfiguracoes.NFE_XML_PATH;
end;

function TConfiguracoesNotaFiscal.arquivosPathSalvar: String;
begin
  Result := ExtractFileDir(GetCurrentDir)+'\SALVAR';

  if vIConexao.getConfiguracoes.NFE_SALVAR_PATH <> '' then
    Result := vIConexao.getConfiguracoes.NFE_SALVAR_PATH;
end;

function TConfiguracoesNotaFiscal.arquivosPathSchemas: String;
begin
  Result := ExtractFileDir(GetCurrentDir)+'\Schemas';;

  if vIConexao.getConfiguracoes.NFE_SCHEMAS_PATH <> '' then
    Result := vIConexao.getConfiguracoes.NFE_SCHEMAS_PATH;
end;

function TConfiguracoesNotaFiscal.arquivosSalvar: Boolean;
begin
  Result := True;
end;

function TConfiguracoesNotaFiscal.arquivosSalvarEvento: Boolean;
begin
  Result := True;
end;

function TConfiguracoesNotaFiscal.arquivosSepararPorCNPJ: Boolean;
begin
  Result := True;
end;

function TConfiguracoesNotaFiscal.arquivosSepararPorMes: Boolean;
begin
  Result := True;
end;

function TConfiguracoesNotaFiscal.arquivosSepararPorModelo: Boolean;
begin
  Result := True;
end;

function TConfiguracoesNotaFiscal.certificadoArquivoPFX: AnsiString;
begin
  Result := vIConexao.getConfiguracoes.EMPRESA_CERTIFICADO;
end;

function TConfiguracoesNotaFiscal.certificadoSenha: String;
begin
  Result := vIConexao.getConfiguracoes.EMPRESA_CERTIFICADO_SENHA;
end;

function TConfiguracoesNotaFiscal.CSC: String;
begin
  Result := vIConexao.getConfiguracoes.NFCE_TOKEN;
end;

function TConfiguracoesNotaFiscal.CSOSN(pCSOSN: String): TpcnCSOSNIcms;
begin
  if EstaVazio(pCSOSN) then
    pCSOSN := '101';

  case pCSOSN.ToInteger of
    101: Result := csosn101;
    102: Result := csosn102;
    103: Result := csosn103;
    201: Result := csosn201;
    202: Result := csosn202;
    203: Result := csosn203;
    300: Result := csosn300;
    400: Result := csosn400;
    500: Result := csosn500;
    900: Result := csosn900;
  end;
end;

function TConfiguracoesNotaFiscal.CST(pCST: String): TpcnCSTIcms;
begin
  if EstaVazio(pCST) then
   pCST := '00';

  case pCST.ToInteger of
     0: Result := cst00;
    10: Result := cst10;
    20: Result := cst20;
    30: Result := cst30;
    40: Result := cst40;
    41: Result := cst41;
    45: Result := cst45;
    50: Result := cst50;
    51: Result := cst51;
    60: Result := cst60;
    70: Result := cst70;
    80: Result := cst80;
    81: Result := cst81;
    90: Result := cst90;
  end;
end;

function TConfiguracoesNotaFiscal.cstcof(pcstcof: String): TpcnCstCofins;
begin
  if EstaVazio(pcstcof) then
    pcstcof := '01';

  case pcstcof.ToInteger of
     1: Result := cof01;
     2: Result := cof02;
     3: Result := cof03;
     4: Result := cof04;
     5: Result := cof05;
     6: Result := cof06;
     7: Result := cof07;
     8: Result := cof08;
     9: Result := cof09;
    49: Result := cof49;
    50: Result := cof50;
    51: Result := cof51;
    52: Result := cof52;
    53: Result := cof53;
    54: Result := cof54;
    55: Result := cof55;
    56: Result := cof56;
    60: Result := cof60;
    61: Result := cof61;
    62: Result := cof62;
    63: Result := cof63;
    64: Result := cof64;
    65: Result := cof65;
    66: Result := cof66;
    67: Result := cof67;
    70: Result := cof70;
    71: Result := cof71;
    72: Result := cof72;
    73: Result := cof73;
    74: Result := cof74;
    75: Result := cof75;
    98: Result := cof98;
    99: Result := cof99;
  end;
end;

function TConfiguracoesNotaFiscal.cstipi(pcstipi: String): TpcnCstIpi;
begin
  if EstaVazio(pcstipi) then
     Result := ipi00;

  case pcstipi.ToInteger of
     0: Result := ipi00;
     1: Result := ipi01;
     2: Result := ipi02;
     3: Result := ipi03;
     4: Result := ipi04;
     5: Result := ipi05;
    49: Result := ipi49;
    50: Result := ipi50;
    99: Result := ipi99;
    51: Result := ipi51;
    52: Result := ipi52;
    53: Result := ipi53;
    54: Result := ipi54;
    55: Result := ipi55;
  end;
end;

function TConfiguracoesNotaFiscal.cstpis(pcstpis: String): TpcnCstPis;
begin
   if EstaVazio(pcstpis) then
    pcstpis := '01';

   case pcstpis.ToInteger of
      1:  Result := pis01;
      2:  Result := pis02;
      3:  Result := pis03;
      4:  Result := pis04;
      5:  Result := pis05;
      6:  Result := pis06;
      7:  Result := pis07;
      8:  Result := pis08;
      9:  Result := pis09;
      49: Result := pis49;
      50: Result := pis50;
      51: Result := pis51;
      52: Result := pis52;
      53: Result := pis53;
      54: Result := pis54;
      55: Result := pis55;
      56: Result := pis56;
      60: Result := pis60;
      61: Result := pis61;
      62: Result := pis62;
      63: Result := pis63;
      64: Result := pis64;
      65: Result := pis65;
      66: Result := pis66;
      67: Result := pis67;
      70: Result := pis70;
      71: Result := pis71;
      72: Result := pis72;
      73: Result := pis73;
      74: Result := pis74;
      75: Result := pis75;
      98: Result := pis98;
      99: Result := pis99;
   end;
end;

function TConfiguracoesNotaFiscal.DANFEPathPDF(pPathPDF: String): String;
begin
   if EstaVazio(pPathPDF) then
     Result := ExtractFileDir(GetCurrentDir)+'\PDF'
   else
     Result := pPathPDF;
end;

function TConfiguracoesNotaFiscal.DANFEPathLogo(pMOdNF: Integer): String;
begin
  case pMOdNF of
    55: Result := vIConexao.getConfiguracoes.NFE_LOGO_PATH;
    65: Result := vIConexao.getConfiguracoes.NFCE_LOGO_PATH;
  end;
end;

destructor TConfiguracoesNotaFiscal.Destroy;
begin

  inherited;
end;

function TConfiguracoesNotaFiscal.dhCont: TDateTime;
begin
  Result := vIConexao.getConfiguracoes.EMPRESA_SCAN;
end;

function TConfiguracoesNotaFiscal.eEmitcMun: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERECO_CODIGO_MUNICIPIO;
end;

function TConfiguracoesNotaFiscal.eEmitnro: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERE_NUMERO;
end;

function TConfiguracoesNotaFiscal.emitCEP: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERECO_CEP;
end;

function TConfiguracoesNotaFiscal.emitCNPJCPF: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_CNPJ;
end;

function TConfiguracoesNotaFiscal.emitcPais: Integer;
begin
  Result := 1058;
end;

function TConfiguracoesNotaFiscal.emitCRT: TpcnCRT;
begin
  case vIConexao.getEmpresa.EMPRESA_REGIME_NFE of
    1: Result := crtRegimeNormal;
    2: Result := crtSimplesNacional;
    3: Result := crtSimplesExcessoReceita;
  end;
end;

function TConfiguracoesNotaFiscal.emitfone: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_TELEFONE;
end;

function TConfiguracoesNotaFiscal.emitIE: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_INSCICAO_ESTADUAL;
end;

function TConfiguracoesNotaFiscal.emitIEST(ufDestino:String): String;
begin
  //Result := valorTag('INSCRICAOST_'+ufDestino,'',tvString);
end;

function TConfiguracoesNotaFiscal.emitUF: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERECO_UF;
end;

function TConfiguracoesNotaFiscal.emitxBairro: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERECO_BAIRRO;
end;

function TConfiguracoesNotaFiscal.emitxCpl: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERECO_COMPLEMENTO;
end;

function TConfiguracoesNotaFiscal.emitxFant: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_FANTASIA;
end;

function TConfiguracoesNotaFiscal.emitxLgr: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERECO_LOGRADOURO;
end;

function TConfiguracoesNotaFiscal.emitxMun: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERECO_CIDADE;
end;

function TConfiguracoesNotaFiscal.emitxNome: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_RAZAOSOCIAL;
end;

function TConfiguracoesNotaFiscal.emitxPais: String;
begin
  Result := 'BRASIL';
end;

function TConfiguracoesNotaFiscal.finNFe(pfinNFe: String): TpcnFinalidadeNFe;
begin
  Result := fnNormal;

  case pfinNFe.ToInteger of
    1: Result := fnNormal;
    2: Result := fnComplementar;
    3: Result := fnAjuste;
    4: Result := fnDevolucao;
   end;
end;

function TConfiguracoesNotaFiscal.IdCSC: String;
begin
  Result := vIConexao.getConfiguracoes.NFCE_ID_TOKEN;
end;

function TConfiguracoesNotaFiscal.idDest(pidDest: String): TpcnDestinoOperacao;
begin
  case pidDest.ToInteger of
    1: Result := doInterna;
    5: Result := doInterna;
    2: Result := doInterestadual;
    6: Result := doInterestadual;
    3: Result := doExterior;
    7: Result := doExterior;
  end;
end;

function TConfiguracoesNotaFiscal.indFinal(pindFinal: String): TpcnConsumidorFinal;
begin
  if pindFinal = 'S' then
    Result :=  cfConsumidorFinal
  else if pindFinal = 'N' then
    Result :=  cfNao;
end;

function TConfiguracoesNotaFiscal.indIEDest(pindIEDest: String): TpcnindIEDest;
begin
   if pindIEDest = 'S' then
    Result :=  inNaoContribuinte
  else if pindIEDest = 'N' then
    Result :=  inContribuinte
  else
    Result :=  inContribuinte;

end;

function TConfiguracoesNotaFiscal.indIntermed(pindIntermed: String): TindIntermed;
begin
   if pindIntermed <> '' then
    Result := iiOperacaoComIntermediador
   else
    Result := iiOperacaoSemIntermediador;
end;

function TConfiguracoesNotaFiscal.indPres(pindPres: String): TpcnPresencaComprador;
begin
  if EstaVazio(PindPres) then
    PindPres := '1';

  case PindPres.ToInteger of
    1: Result := pcPresencial;
    2: Result := pcInternet;
    3: Result := pcTeleatendimento;
    4: Result := pcEntregaDomicilio;
    9: Result := pcOutros;
  end;
end;

function TConfiguracoesNotaFiscal.modBC(pmodBC: String): TpcnDeterminacaoBaseIcms;
begin
  Result := dbiValorOperacao;
end;

function TConfiguracoesNotaFiscal.modBCST(pmodBCST: String): TpcnDeterminacaoBaseIcmsST;
begin
   if EstaVazio(pmodBCST) then
     pmodBCST := '4';

   case pmodBCST.ToInteger of
      0: Result := dbisPrecoTabelado;
      1: Result := dbisListaNegativa;
      2: Result := dbisListaPositiva;
      3: Result := dbisListaNeutra;
      4: Result := dbisMargemValorAgregado;
      5: Result := dbisPauta;
      6: Result := dbisValordaOperacao;
   end;
end;

function TConfiguracoesNotaFiscal.modeloDF(pmoNFe: Integer): TpcnModeloDF;
begin
  case pmoNFe of
    55: Result := moNFe;
    65: Result := moNFCe;
  end;
end;

function TConfiguracoesNotaFiscal.modFrete(pmodFrete: String): TpcnModalidadeFrete;
begin
   case pmodFrete.ToInteger of
     0: Result := mfContaEmitente;
     1: Result := mfContaDestinatario;
     2: Result := mfContaTerceiros;
     3: Result := mfProprioRemetente;
     4: Result := mfProprioDestinatario;
     9: Result := mfSemFrete;
   end;
 end;

function TConfiguracoesNotaFiscal.orig(porig: String): TpcnOrigemMercadoria;
begin
   Result :=oeNacional;

   if porig = 'N' then
     Result :=oeNacional
   else if porig = 'I' then
     Result :=oeEstrangeiraImportacaoDireta
   else if porig = 'E' then
     Result :=oeEstrangeiraAdquiridaBrasil
   else if porig = '3' then
     Result :=oeNacionalConteudoImportacaoSuperior40
   else if porig = '4' then
     Result :=oeNacionalProcessosBasicos
   else if porig = '5' then
     Result :=oeNacionalConteudoImportacaoInferiorIgual40
   else if porig = '6' then
     Result :=oeEstrangeiraImportacaoDiretaSemSimilar
   else if porig = '7' then
     Result :=oeEstrangeiraAdquiridaBrasilSemSimilar
   else if porig = '8' then
     Result :=oeNacionalConteudoImportacaoSuperior70;
end;

function TConfiguracoesNotaFiscal.DANFEtipoDANFE: TpcnTipoImpressao;
begin
  Result := tiRetrato;
end;

function TConfiguracoesNotaFiscal.tipoEmissao: TpcnTipoEmissao;
begin
   case vIConexao.getConfiguracoes.NFE_TIPO_EMISSAO of
     1: Result := teNormal;
     2: Result := teContingencia;
     3: Result := teSCAN;
     4: Result := teDPEC;
     5: Result := teFSDA;
     6: Result := teSVCRS;
     7: Result := teSVCSP;
   end;
end;

function TConfiguracoesNotaFiscal.tPag(ptPag: String): TpcnFormaPagamento;
begin
  if EstaVazio(ptPag) then
   ptPag := '15';

  case ptPag.ToInteger of
    1:  Result := fpDinheiro;
    2:  Result := fpCheque;
    3:  Result := fpCartaoCredito;
    4:  Result := fpCartaoDebito;
    5:  Result := fpCreditoLoja;
    10: Result := fpValeAlimentacao;
    11: Result := fpValeRefeicao;
    12: Result := fpValePresente;
    13: Result := fpValeCombustivel;
    14: Result := fpDuplicataMercantil;
    15: Result := fpBoletoBancario;
    16: Result := fpDepositoBancario;
    17: Result := fpPagamentoInstantaneo;
    18: Result := fpTransfBancario;
    28: Result := fpTransfBancario;
    19: Result := fpProgramaFidelidade;
    29: Result := fpProgramaFidelidade;
    39: Result := fpProgramaFidelidade;
    90: Result := fpSemPagamento;
    99: Result := fpOutro;
  end;

end;

function TConfiguracoesNotaFiscal.tpNF(ptpNF: String): TpcnTipoNFe;
begin
  Result := tnSaida;

  if ptpNF = 'S' then
    Result := tnSaida;
  if ptpNF = 'E' then
    Result := tnEntrada;
end;

function TConfiguracoesNotaFiscal.ufEmissao: String;
begin
  Result := vIConexao.getEmpresa.EMPRESA_ENDERECO_UF;
end;

function TConfiguracoesNotaFiscal.versaoDF: TpcnVersaoDF;
begin
  Result := ve400;
end;

function TConfiguracoesNotaFiscal.versaoQRCode: TpcnVersaoQrCode;
begin
  Result := veqr200;
end;

end.



