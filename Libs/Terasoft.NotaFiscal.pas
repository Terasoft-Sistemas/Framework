unit Terasoft.NotaFiscal;
interface
uses
  blcksock,
  Clipbrd,
  System.Classes,
  System.SysUtils,
  ACBrUtil.Base,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrDFeConfiguracoes,
  ACBrDFeSSL,
  ACBrDFeOpenSSL,
  ACBrDFeUtil,
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes,
  ACBrNFe,
  ACBrDANFCeFortesFr,
  pcnNFe,
  pcnConversao,
  pcnConversaoNFe,
  ACBrDFeDANFeReport,
  ACBrDFeReport,
  ACBrNFeDANFEClass,
  ACBrNFeDANFeRLClass,
  Terasoft.NotaFiscal.Configuracoes,
  FireDAC.Comp.Client,
  NFControl,
  Terasoft.Types,
  Interfaces.Conexao;

type
  TNotaFiscal = class

  private
    vIConexao: IConexao;
    ACBrNFe: TACBrNFe;
    NotaF: NotaFiscal;
    ACBrNFeDANFeRL: TACBrNFeDANFeRL;
    ACBrNFeDANFCeFortes: TACBrNFeDANFCeFortes;
    vConfiguracoesNotaFiscal: TConfiguracoesNotaFiscal;
    Duplicata: TDupCollectionItem;
    InfoPgto: TpagCollectionItem;
    Produto: TDetCollectionItem;
    Rastro: TrastroCollectionItem;
    Medicamento: TMedCollectionItem;
    Referenciadas: TNFrefCollectionItem;
    Volume: TVolCollectionItem;
    ObsComplementar: TobsContCollectionItem;
    ObsFisco: TobsFiscoCollectionItem;
    FgerarPDF: Boolean;
    FMostraPreview: Boolean;
    FPathPDF: String;
    FidPedido: String;
    FimprimirDANF: Boolean;
    FidNotaFiscal: String;
    function identificacao(pidNF: String): Boolean;
    function referenciada: Boolean;
    function emitente: Boolean;
    function destinatario(pidNF: String): Boolean;
    function enderecoEntrega: Boolean;
    function itens(pidNF: String): Boolean;
    function totais(pidNF: String): Boolean;
    function transporte(pidNF: String): Boolean;
    function cobranca(pidNF: String): Boolean;
    function Observacoes(pidNF: String): Boolean;
    function responsavelTecnico: Boolean;
    function configuraComponenteNFe: Boolean;
    procedure processar(idNotaFiscal: String);
    procedure SetgerarPDF(const Value: Boolean);
    procedure SetidNotaFiscal(const Value: String);
    procedure SetidPedido(const Value: String);
    procedure SetimprimirDANF(const Value: Boolean);
    procedure SetMostraPreview(const Value: Boolean);
    procedure SetPathPDF(const Value: String);

  public
    property idNotaFiscal  : String read FidNotaFiscal write SetidNotaFiscal;
    property idPedido      : String read FidPedido write SetidPedido;
    property PathPDF       : String read FPathPDF write SetPathPDF;
    property imprimirDANF      : Boolean read FimprimirDANF write SetimprimirDANF;
    property MostraPreview : Boolean read FMostraPreview write SetMostraPreview;
    property gerarPDF      : Boolean read FgerarPDF write SetgerarPDF;

    constructor Create(pIConexao: IConexao);
    destructor Destroy; override;

    function transmitir(idNotaFiscal: String): TStringList;
    function imprimir: String;
    function gerarXML(idNotaFiscal, pPath: String): String;
    function VencimentoCertificado: TDateTime;
  end;
implementation

{ TNotaFiscal }

uses
  Terasoft.Utils,
  System.Variants,
  PedidoVendaModel;

function TNotaFiscal.configuraComponenteNFe: Boolean;
begin
  ACBrNFe.NotasFiscais.Clear;
  ACBrNFe.Configuracoes.Certificados.ArquivoPFX  := vConfiguracoesNotaFiscal.certificadoArquivoPFX;
  ACBrNFe.Configuracoes.Certificados.Senha       := vConfiguracoesNotaFiscal.certificadoSenha;
  ACBrNFe.SSL.DescarregarCertificado;

  with ACBrNFe.Configuracoes.Geral do
  begin
    SSLLib        := libCustom;
    SSLCryptLib   := cryWinCrypt;
    SSLHttpLib    := httpWinINet;
    SSLXmlSignLib := xsMsXml;
//    SSLXmlSignLib := xsLibXml2;
    AtualizarXMLCancelado := True;
    Salvar           := True;
    ExibirErroSchema := true;
    RetirarAcentos   := True;
    FormaEmissao     := vConfiguracoesNotaFiscal.tipoEmissao;
    VersaoDF         := vConfiguracoesNotaFiscal.versaoDF;
    IdCSC            := vConfiguracoesNotaFiscal.IdCSC;
    CSC              := vConfiguracoesNotaFiscal.CSC;
    VersaoQRCode     := vConfiguracoesNotaFiscal.versaoQRCode;
  end;
  with ACBrNFe.Configuracoes.WebServices do
  begin
    UF         := vConfiguracoesNotaFiscal.ufEmissao;
    Ambiente   := vConfiguracoesNotaFiscal.ambiente;
    Visualizar := False;
    Salvar     := True;
  end;
  ACBrNFe.SSL.SSLType := TSSLType(0);
  with ACBrNFe.Configuracoes.Arquivos do
  begin
    Salvar           := vConfiguracoesNotaFiscal.arquivosSalvar;
    SepararPorMes    := vConfiguracoesNotaFiscal.arquivosSepararPorMes;
    AdicionarLiteral := vConfiguracoesNotaFiscal.arquivosAdicionarLiteral;
    EmissaoPathNFe   := vConfiguracoesNotaFiscal.arquivosEmissaoPathNFe;
    SalvarEvento     := vConfiguracoesNotaFiscal.arquivosSalvarEvento;
    SepararPorCNPJ   := vConfiguracoesNotaFiscal.arquivosSepararPorCNPJ;
    SepararPorModelo := vConfiguracoesNotaFiscal.arquivosSepararPorModelo;
    PathSchemas      := vConfiguracoesNotaFiscal.arquivosPathSchemas;
    PathNFe          := vConfiguracoesNotaFiscal.arquivosPathNFe;
    PathInu          := vConfiguracoesNotaFiscal.arquivosPathInu;
    PathEvento       := vConfiguracoesNotaFiscal.arquivosPathEvento;
    PathSalvar       := vConfiguracoesNotaFiscal.arquivosPathSalvar;
  end;
end;
function TNotaFiscal.cobranca(pidNF: String): Boolean;
var
 lSQL: String;
 lQry: TFDQuery;
begin
  try
    try
    lQry := vIConexao.CriarQuery;
    lSQL :=
    ' select                                                              '+#13+
    ' n.modelo                  modeloNF,                                 '+#13+
    ' n.numero_ecf              nFat,                                     '+#13+
    ' n.total_nf                vOrig,                                    '+#13+
    ' ci.pacela_rec             nDup,                                     '+#13+
    ' ci.vlrparcela_rec         vDup,                                     '+#13+
    ' ci.vencimento_rec         dVenc,                                    '+#13+
    ' p.tpag_nfe                tPag                                      '+#13+
    '                                                                     '+#13+
    ' from nf n                                                           '+#13+
    '                                                                     '+#13+
    ' inner join contasreceber c on c.pedido_rec = n.pedido_id            '+#13+
    ' inner join contasreceberitens ci on ci.fatura_rec = c.fatura_rec    '+#13+
    ' inner join portador p on p.codigo_port = c.codigo_por               '+#13+
    '                                                                     '+#13+
    '                                                                     '+#13+
    ' where                                                               '+#13+
    '     n.numero_nf = '+QuotedStr(pidNF);
    lQry.Open(lSQL);

    if lQry.FieldByName('nFat').AsInteger = 55 then
    begin
      if lQry.IsEmpty then
      begin
        InfoPgto := NotaF.NFe.pag.New;
        InfoPgto.indPag := ipNenhum;
        InfoPgto.tPag   := fpSemPagamento;
        exit;
      end;
      with NotaF.NFe.Cobr.Fat do
      begin
        nFat  := lQry.FieldByName('nFat').AsString;
        vOrig := lQry.FieldByName('vOrig').AsFloat;
        vDesc := 0;
        vLiq  := lQry.FieldByName('vOrig').AsFloat;
      end;
      lQry.First;
      while not lQry.Eof do begin
        Duplicata :=  NotaF.NFe.Cobr.Dup.New;
        Duplicata.nDup  := FormatFloat('000',lQry.FieldByName('nDup').AsInteger);
        Duplicata.dVenc := lQry.FieldByName('dVenc').Value;
        Duplicata.vDup  := lQry.FieldByName('vDup').AsFloat;
        lQry.Next;
      end;
    end;
    InfoPgto := NotaF.NFe.pag.New;
    InfoPgto.indPag := ipPrazo;
    InfoPgto.tPag   := vConfiguracoesNotaFiscal.tPag(lQry.FieldByName('tPag').AsString);
    InfoPgto.vPag   := lQry.FieldByName('vOrig').AsFloat;;
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TNotaFiscal.destinatario(pidNF: String): Boolean;
var
 lSQL: String;
 lQry: TFDQuery;
begin
  try
    try
    lQry := vIConexao.CriarQuery;
    lSQL :=
    ' select                                                       '+#13+
    ' c.cnpj_cpf_cli CNPJCPF,                                      '+#13+
    ' c.inscricao_rg_cli IE,                                       '+#13+
    ' c.SUFRAMA ISUF,                                              '+#13+
    ' c.CONSUMIDOR_FINAL indFinal,                                 '+#13+
    ' c.NAO_CONTRIBUINTE indIEDest,                                '+#13+
    ' IIF (c.tipo_cli = ''F'', c.fantasia_cli, c.razao_cli) xNome, '+#13+
    ' c.telefone_cli Fone,                                         '+#13+
    ' c.cep_cli CEP,                                               '+#13+
    ' c.endereco_cli xLgr,                                         '+#13+
    ' c.numero_end nro,                                            '+#13+
    ' c.complemento xCpl,                                          '+#13+
    ' c.bairro_cli xBairro,                                        '+#13+
    ' c.cod_municipio cMun,                                        '+#13+
    ' c.cidade_cli xMun,                                           '+#13+
    ' c.uf_cli UF,                                                 '+#13+
    ' coalesce(p.codigo, ''1058'') cPais,                          '+#13+
    ' coalesce(p.descricao, ''BRASIL'') xPais,                     '+#13+
    ' n.modelo                                                     '+#13+
    '                                                              '+#13+
    ' from                                                         '+#13+
    '    nf n                                                      '+#13+
    '                                                              '+#13+
    ' left join clientes c on c.codigo_cli = n.codigo_cli          '+#13+
    ' left join pais p on p.id = c.pais_id                         '+#13+
    '                                                              '+#13+
    ' where                                                        '+#13+
    '     n.numero_nf = '+QuotedStr(pidNF);
    lQry.Open(lSQL);
    with NotaF.NFe.Dest do
    begin
      CNPJCPF           := IIF(lQry.FieldByName('CNPJCPF').AsString <> ''    , lQry.FieldByName('CNPJCPF').AsString,  Unassigned);
      IE                := IIF(lQry.FieldByName('IE').AsString <> ''         , lQry.FieldByName('IE').AsString,       Unassigned);
      ISUF              := IIF(lQry.FieldByName('ISUF').AsString <> ''       , lQry.FieldByName('ISUF').AsString,     Unassigned);
      xNome             := IIF(lQry.FieldByName('xNome').AsString <> ''      , lQry.FieldByName('xNome').AsString,    Unassigned);
      indIEDest         := IIF(lQry.FieldByName('indIEDest').AsString <> ''  , vConfiguracoesNotaFiscal.indIEDest(lQry.FieldByName('indIEDest').AsString),  Unassigned);
      EnderDest.Fone    := IIF(lQry.FieldByName('Fone').AsString <> ''       , lQry.FieldByName('Fone').AsString,     Unassigned);
      EnderDest.CEP     := IIF(lQry.FieldByName('CEP').AsString <> ''        , lQry.FieldByName('CEP').AsString,      Unassigned);
      EnderDest.xLgr    := IIF(lQry.FieldByName('xLgr').AsString <> ''       , lQry.FieldByName('xLgr').AsString,     Unassigned);
      EnderDest.nro     := IIF(lQry.FieldByName('nro').AsString <> ''        , lQry.FieldByName('nro').AsString,      Unassigned);
      EnderDest.xCpl    := IIF(lQry.FieldByName('xCpl').AsString <> ''       , lQry.FieldByName('xCpl').AsString,     Unassigned);
      EnderDest.xBairro := IIF(lQry.FieldByName('xBairro').AsString <> ''    , lQry.FieldByName('xBairro').AsString,  Unassigned);
      EnderDest.cMun    := IIF(lQry.FieldByName('cMun').AsString <> ''       , lQry.FieldByName('cMun').AsString,     Unassigned);
      EnderDest.xMun    := IIF(lQry.FieldByName('xMun').AsString <> ''       , lQry.FieldByName('xMun').AsString,     Unassigned);
      EnderDest.UF      := IIF(lQry.FieldByName('UF').AsString <> ''         , lQry.FieldByName('UF').AsString,       Unassigned);
      EnderDest.cPais   := IIF(lQry.FieldByName('cPais').AsString <> ''      , lQry.FieldByName('cPais').AsString,    Unassigned);
      EnderDest.xPais   := IIF(lQry.FieldByName('xPais').AsString <> ''      , lQry.FieldByName('xPais').AsString,    Unassigned);

      if vConfiguracoesNotaFiscal.modeloDF(lQry.FieldByName('modelo').AsInteger) = moNFCe then
      begin
        indIEDest := inNaoContribuinte;
        IE        := '';
        //Colocar o cpf
      end;
    end;

    with NotaF.NFe.Ide do
    begin
     if vConfiguracoesNotaFiscal.modeloDF(lQry.FieldByName('modelo').AsInteger) = moNFCe then
       indFinal := cfConsumidorFinal
     else
       indFinal := vConfiguracoesNotaFiscal.indFinal(lQry.FieldByName('indFinal').AsString);
    end;
     with NotaF.NFe.Emit do
    begin
     if vConfiguracoesNotaFiscal.modeloDF(lQry.FieldByName('modelo').AsInteger) <> moNFCe then
       IEST := vConfiguracoesNotaFiscal.emitIEST(NotaF.NFe.Dest.EnderDest.UF);
    end
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TNotaFiscal.emitente: Boolean;
begin
  with NotaF.NFe.Emit do
  begin
    CNPJCPF           := vConfiguracoesNotaFiscal.emitCNPJCPF;
    IE                := vConfiguracoesNotaFiscal.emitIE;
    xNome             := vConfiguracoesNotaFiscal.emitxNome;
    xFant             := vConfiguracoesNotaFiscal.emitxFant;
    EnderEmit.fone    := vConfiguracoesNotaFiscal.emitfone;
    EnderEmit.CEP     := vConfiguracoesNotaFiscal.emitCEP.ToInteger;
    EnderEmit.xLgr    := vConfiguracoesNotaFiscal.emitxLgr;
    EnderEmit.nro     := vConfiguracoesNotaFiscal.eEmitnro;
    EnderEmit.xCpl    := vConfiguracoesNotaFiscal.emitxCpl;
    EnderEmit.xBairro := vConfiguracoesNotaFiscal.emitxBairro;
    EnderEmit.cMun    := vConfiguracoesNotaFiscal.eEmitcMun.ToInteger;
    EnderEmit.xMun    := vConfiguracoesNotaFiscal.emitxMun;
    EnderEmit.UF      := vConfiguracoesNotaFiscal.emitUF;
    enderEmit.cPais   := vConfiguracoesNotaFiscal.emitcPais;
    enderEmit.xPais   := vConfiguracoesNotaFiscal.emitxPais;
    CRT               := vConfiguracoesNotaFiscal.emitCRT;
  end;
end;
function TNotaFiscal.enderecoEntrega: Boolean;
begin
  with NotaF.NFe.Entrega do
  begin
    CNPJCPF := '';
    xLgr    := '';
    nro     := '';
    xCpl    := '';
    xBairro := '';
    cMun    := 0;
    xMun    := '';
    UF      := '';
  end;
end;
function TNotaFiscal.gerarXML(idNotaFiscal, pPath: String): String;
var
 lSQL: String;
 lQry: TFDQuery;
 lXML: TStringList;
begin
  try
    try
    lQry := vIConexao.CriarQuery;
    lXML := TStringList.Create;
    lSQL :=
    ' select             '+#13+
    '    n.xml_nfe xml,  '+#13+
    '    n.id_nf3 chave  '+#13+
    '                    '+#13+
    ' from               '+#13+
    '    nf n            '+#13+
    '                    '+#13+
    ' where              '+#13+
    '     n.numero_nf = '+QuotedStr(idNotaFiscal);
    lQry.Open(lSQL);
    lXML.Text := lQry.FieldByName('xml').AsString;
    lXML.SaveToFile(pPath+'\'+lQry.FieldByName('chave').AsString+'.xml');
    Result := lQry.FieldByName('chave').AsString+'.xml';
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TNotaFiscal.identificacao(pidNF: String): Boolean;
var
 lSQL: String;
 lQry: TFDQuery;
begin
  try
    try
    lQry := vIConexao.CriarQuery;
    lSQL :=
    ' select                                    '+#13+
    '    c.descricao natOp,                     '+#13+
    '    substring(c.CFOP from 1 for 1) idDest, '+#13+
    '    n.modelo modelo,                       '+#13+
    '    n.serie_nf serie,                      '+#13+
    '    n.numero_ecf nNF,                      '+#13+
    '    n.numero_ecf cNF,                      '+#13+
    '    n.data_nf dEmi,                        '+#13+
    '    n.data_saida dSaiEnt,                  '+#13+
    '    n.hora_saida hSaiEnt,                  '+#13+
    '    c.tipo tpNF,                           '+#13+
    '    n.EMAIL_NFE finNFe,                    '+#13+
    '    n.INTERMEDIADOR_CNPJ indIntermed,      '+#13+
    '    N.INDPRES,                             '+#13+
    '    N.INTERMEDIADOR_CNPJ CNPJ,             '+#13+
    '    N.INTERMEDIADOR_NOME idCadIntTran      '+#13+
    ' from                                      '+#13+
    '    nf n                                   '+#13+
    '                                           '+#13+
    ' left join cfop c on c.id = n.cfop_id      '+#13+
    '                                           '+#13+
    ' where                                     '+#13+
    '     n.numero_nf = '+QuotedStr(pidNF);
    lQry.Open(lSQL);

    NotaF := ACBrNFe.NotasFiscais.Add;
    with NotaF.NFe.Ide do
    begin
      natOp       := lQry.FieldByName('natOp').AsString;
      indPag      := ipOutras;
      modelo      := lQry.FieldByName('modelo').AsInteger;
      serie       := lQry.FieldByName('serie').AsInteger;
      nNF         := lQry.FieldByName('nNF').AsInteger;
      cNF         := GerarCodigoDFe(lQry.FieldByName('cNF').AsInteger);
      dEmi        := NOW;// lQry.FieldByName('dEmi').AsDateTime;
      dSaiEnt     := NOW;//lQry.FieldByName('dSaiEnt').AsDateTime;
      hSaiEnt     := NOW;//lQry.FieldByName('hSaiEnt').Value;
      tpNF        := vConfiguracoesNotaFiscal.tpNF(lQry.FieldByName('tpNF').AsString);
      verProc     := 'ERP_TERASOFT';
      cUF         := UFtoCUF(vConfiguracoesNotaFiscal.emitUF);
      cMunFG      := vConfiguracoesNotaFiscal.eEmitcMun.ToInteger;
      finNFe      := vConfiguracoesNotaFiscal.finNFe(lQry.FieldByName('finNFe').AsString);
      indIntermed := vConfiguracoesNotaFiscal.indIntermed(lQry.FieldByName('indIntermed').AsString);
      indPres     := vConfiguracoesNotaFiscal.indPres(lQry.FieldByName('indPres').AsString);
      idDest      := vConfiguracoesNotaFiscal.idDest(lQry.FieldByName('idDest').AsString);
      if vConfiguracoesNotaFiscal.modeloDF(lQry.FieldByName('modelo').AsInteger) = moNFCe then
       tpImp       := tiNFCe;
      if tpEmis <> teNormal then
      begin
        dhCont := vConfiguracoesNotaFiscal.dhCont;
        xJust  := 'Problemas no WebService';
      end;
    end;
    with ACBrNFe.Configuracoes.Geral do
    begin
      ModeloDF := vConfiguracoesNotaFiscal.modeloDF(lQry.FieldByName('modelo').AsInteger);
    end;
    if NotaF.NFe.Ide.indIntermed = iiOperacaoComIntermediador then
    begin
      NotaF.NFe.infIntermed.CNPJ := lQry.FieldByName('CNPJ').AsString;
      NotaF.NFe.infIntermed.idCadIntTran := lQry.FieldByName('idCadIntTran').AsString;
    end;
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TNotaFiscal.imprimir: String;
var
 lSQL: String;
 lQry: TFDQuery;
begin
   if (FidPedido = '') and (FidNotaFiscal = '') then
     CriaException('Número de pedido ou ID da NF deve ser informado.');

   if (FPathPDF = '') and (FgerarPDF = True) then
     CriaException('Para gerar PDF path deve ser informado.');
  try
    try
    lQry := vIConexao.CriarQuery;
    lSQL :=
    ' select               '+#13+
    '    n.xml_nfe xml,    '+#13+
    '    n.id_nf3 ,        '+#13+
    '    n.modelo pmoNFe,  '+#13+
    '    n.nome_xml,       '+#13+
    '    n.status_nf       '+#13+
    ' from                 '+#13+
    '    nf n              '+#13+
    ' where 1=1            '+#13;

    if FidNotaFiscal <> '' then
      lSQL := lSQL +  '  and  n.numero_nf = '+QuotedStr(FidNotaFiscal);

    if FidPedido <> '' then
      lSQL := lSQL +  '  and  n.numero_ped = '+QuotedStr(FidPedido);

    lQry.Open(lSQL);

    if copy(Trim(lQry.FieldByName('nome_xml').AsString),1,10) <> 'Autorizado' then
      CriaException('Não é possível imprimir uma nota não autorizada.');
    if lQry.FieldByName('status_nf').AsString = 'X' then
      CriaException('Não foi possível imprimir uma nota cancelada ou inútilizada.');
    if lQry.FieldByName('pmoNFe').AsInteger = 65 then begin
      ACBrNFeDANFCeFortes := TACBrNFeDANFCeFortes.Create(nil);
      ACBrNFe.DANFE       := ACBrNFeDANFCeFortes;
      ACBrNFeDANFCeFortes.ImprimeQRCodeLateral := True;
      ACBrNFeDANFCeFortes.FormularioContinuo   := True;
    end
    else
    begin
      ACBrNFeDANFeRL := TACBrNFeDANFeRL.Create(nil);
      ACBrNFe.DANFE  := ACBrNFeDANFeRL;
      ACBrNFe.DANFE.TipoDANFE := vConfiguracoesNotaFiscal.DANFETipoDANFE;
    end;

    ACBrNFe.DANFE.Logo    := vConfiguracoesNotaFiscal.DANFEPathLogo(lQry.FieldByName('pmoNFe').AsInteger);
    ACBrNFe.DANFE.PathPDF := vConfiguracoesNotaFiscal.DANFEPathPDF(FPathPDF);
    ACBrNFe.DANFE.Sistema := 'Emissão: ERP Terasoft';
    ACBrNFe.NotasFiscais.Clear;
    ACBrNFe.NotasFiscais.LoadFromString(lQry.FieldByName('xml').AsString);

    if FgerarPDF then begin
      ACBrNFe.DANFE.MostraStatus := MostraPreview;
      ACBrNFe.DANFE.ImprimirDANFEPDF;
    end;

    if FimprimirDANF then begin
      ACBrNFe.DANFE.MostraStatus := MostraPreview;
      ACBrNFe.DANFE.MostraPreview := MostraPreview;
      ACBrNFe.DANFE.ImprimirDANFE;
    end;

    Result := lQry.FieldByName('id_nf3').AsString;
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TNotaFiscal.Observacoes(pidNF: String): Boolean;
var
 lSQL: String;
 lQry: TFDQuery;
begin
  try
    try
    lQry := vIConexao.CriarQuery;
    lSQL :=
    ' select                     '+#13+
    '    n.obs_nf infCpl, '+#13+
    '    n.fisco_nf infAdFisco   '+#13+
    '                            '+#13+
    ' from                       '+#13+
    '    nf n                    '+#13+
    '                            '+#13+
    ' where                      '+#13+
    '     n.numero_nf = '+QuotedStr(pidNF);
    lQry.Open(lSQL);
    with NotaF.NFe.InfAdic do
    begin
      infCpl     :=  lQry.FieldByName('infCpl').AsString;
      infAdFisco :=  lQry.FieldByName('infAdFisco').AsString;
    end;
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TNotaFiscal.itens(pidNF: String): Boolean;
var
 lSQL: String;
 lQry: TFDQuery;
begin
  try
    try
    lQry := vIConexao.CriarQuery;
    lSQL :=
    ' select                                          '+#13+
    ' n.item_nf nItem,                                '+#13+
    ' n.codigo_pro cProd,                             '+#13+
    ' p.barras_pro cEAN,                              '+#13+
    ' p.nome_pro xProd,                               '+#13+
    ' p.codigo_fornecedor NCM,                        '+#13+
    ' '''' EXTIPI,                                    '+#13+
    ' n.cfop CFOP,                                    '+#13+
    ' substring(p.unidade_pro from 1 for 3) uCom,     '+#13+
    ' n.quantidade_nf qCom,                           '+#13+
    ' n.valorunitario_nf vUnCom,                      '+#13+
    ' n.v_prod2 vProd,                                '+#13+
    ' p.barras_pro cEANTrib,                          '+#13+
    ' substring(p.unidade_pro from 1 for 3) uTrib,    '+#13+
    ' n.quantidade_nf qTrib,                          '+#13+
    ' n.valorunitario_nf vUnTrib,                     '+#13+
    ' n.voutros vOutro,                               '+#13+
    ' n.frete vFrete,                                 '+#13+
    ' n.vseg vSeg,                                    '+#13+
    ' n.vdesc vDesc,                                  '+#13+
    ' p.cest CEST,                                    '+#13+
    ' p.barras_pro cBarra,                            '+#13+
    ' p.barras_pro cBarraTrib,                        '+#13+
    ' p.obs_nf infAdProd,                             '+#13+
    ' n.vtottrib vTotTrib,                            '+#13+
    ' p.TIPO$_PRO orig,                                   '+#13+
    ' n.cst_n12 CST,                                      '+#13+
    ' '''' modBC,                                         '+#13+
    ' n.csosn CSOSN,                                      '+#13+
    ' n.pcredsn pCredSN,                                  '+#13+
    ' n.vcredicmssn vCredICMSSN,                          '+#13+
    ' n.vbc_n15 vBC,                                      '+#13+
    ' n.icms_nf pICMS,                                    '+#13+
    ' n.vicms_n17 vICMS,                                  '+#13+
    ' n.modbcst_n18 modBCST,                              '+#13+
    ' n.pmvast_n19 pMVAST,                                '+#13+
    ' n.predbcst_n20 pRedBCST,                            '+#13+
    ' n.vbcst_n21 vBCST,                                  '+#13+
    ' n.picmsst_n22 pICMSST,                              '+#13+
    ' n.vicmsst_n23 vICMSST,                              '+#13+
    ' n.predbcst_n20 pRedBC,                              '+#13+
    ' n.vbcfcpst vBCFCPST,                                '+#13+
    ' n.pfcpst pFCPST,                                    '+#13+
    ' n.vfcpst vFCPST,                                    '+#13+
    ' n.vbcstret vBCSTRet,                                '+#13+
    ' n.picmsstret pST,                                   '+#13+
    ' n.vicmssubistitutoret vICMSSubstituto,              '+#13+
    ' n.vicmsstret vICMSSTRet,                            '+#13+
    ' n.vbcfcpstret vBCFCPSTRet,                          '+#13+
    ' n.pfcpstret pFCPSTRet,                              '+#13+
    ' n.vfcpstret vFCPSTRet,                              '+#13+
    ' n.predbcefet pRedBCEfet,                            '+#13+
    ' n.vbcefet vBCEfet,                                  '+#13+
    ' n.picmsefet pICMSEfet,                              '+#13+
    ' n.vicmsefet vICMSEfet,                              '+#13+
    ' n.vBCUFDest,                                        '+#13+
    ' n.vBCFCPUFDest,                                     '+#13+
    ' n.pFCPUFDest,                                       '+#13+
    ' n.pICMSUFDest,                                      '+#13+
    ' n.pICMSInter,                                       '+#13+
    ' n.pICMSInterPart,                                   '+#13+
    ' n.vFCPUFDest,                                       '+#13+
    ' n.vICMSUFDest,                                      '+#13+
    ' n.vICMSUFRemet,                                     '+#13+
    ' coalesce(n.cenq,''999'') cEnq,                      '+#13+
    ' n.cst_ipi cstipi,                                   '+#13+
    ' n.vbc_ipi vBCipi,                                   '+#13+
    ' n.ipi_nf pIPI,                                      '+#13+
    ' n.valor_ipi vIPI,                                   '+#13+
    ' '''' CNPJProd,                                      '+#13+
    ' '''' cSelo,                                         '+#13+
    ' 0  qSelo,                                            '+#13+
    ' n.VBC_P02 vBCII,                                    '+#13+
    ' n.VDESPADU_P03 vDespAdu,                            '+#13+
    ' n.VII_P04 vII,                                      '+#13+
    ' n.VIOF_P05 vIOF,                                     '+#13+
    ' n.cst_q06 CSTPIS,                                   '+#13+
    ' n.VBC_Q07 vBCPIS,                                   '+#13+
    ' n.PPIS_Q08 pPIS,                                    '+#13+
    ' n.VPIS_Q09 vPIS,                                    '+#13+
    ' n.QBCPROD_Q10 qBCProd,                              '+#13+
    ' n.VALIQPROD_Q11 vAliqProd,                          '+#13+
    ' n.cst_s06 CSTCOFINS,                                '+#13+
    ' n.VBC_S07 vBCCOFINS,                                '+#13+
    ' n.PCOFINS_S08 pCOFINS,                              '+#13+
    ' n.VCOFINS_S11 vCOFINS,                              '+#13+
    ' n.QBCPROD_S09 qBCProdCOFINS,                        '+#13+
    ' n.VALIQPROD_S10 vAliqProdCOFINS,                    '+#13+
    ' CPRODANVISA     cProdANVISA ,                        '+#13+
    ' XMOTIVOISENCAO  xMotivoIsencao,                      '+#13+
    ' VPMC            vPMC,                                '+#13+
    ' l.LOTE       nLote,                                  '+#13+
    ' l.QUANTIDADE qLote,                                  '+#13+
    ' l.FABRICACAO dFab,                                   '+#13+
    ' l.VENCIMENTO dVal                                    '+#13+
    ' from                                                '+#13+
    '     nfitens n                                       '+#13+
    '                                                     '+#13+
    ' left join produto p on p.codigo_pro = n.codigo_pro  '+#13+
    ' left join lote_new l on l.produto_id = n.codigo_pro and l.documento = n.numero_nf '+
    '                                                     '+#13+
    ' where                                               '+#13+
    '      n.numero_nf = '+QuotedStr(pidNF);
    lQry.Open(lSQL);
    lQry.First;
    while not lQry.Eof do begin
      Produto := NotaF.NFe.Det.New;
      with Produto.Prod do
      begin
        nItem    := lQry.FieldByName('nItem').AsInteger;
        cProd    := lQry.FieldByName('cProd').AsString;
        cEAN     := lQry.FieldByName('cEAN').AsString;
        xProd    := lQry.FieldByName('xProd').AsString;
        NCM      := lQry.FieldByName('NCM').AsString;
        EXTIPI   := lQry.FieldByName('EXTIPI').AsString;
        CFOP     := lQry.FieldByName('CFOP').AsString;
        uCom     := lQry.FieldByName('uCom').AsString;
        qCom     := lQry.FieldByName('qCom').AsFloat;
        vUnCom   := lQry.FieldByName('vUnCom').AsFloat;
        vProd    := lQry.FieldByName('vProd').AsFloat;
        cEANTrib  := lQry.FieldByName('cEANTrib').AsString;
        uTrib     := lQry.FieldByName('uTrib').AsString;
        qTrib     := lQry.FieldByName('qTrib').AsCurrency;
        vUnTrib   := lQry.FieldByName('vUnTrib').AsFloat;
        vOutro    := lQry.FieldByName('vOutro').AsFloat;
        vFrete    := lQry.FieldByName('vFrete').AsFloat;
        vSeg      := lQry.FieldByName('vSeg').AsFloat;
        vDesc     := lQry.FieldByName('vDesc').AsFloat;
        CEST       := lQry.FieldByName('CEST').AsString;
        cBarra     := lQry.FieldByName('cBarra').AsString;
        cBarraTrib := lQry.FieldByName('cBarraTrib').AsString;
        Produto.infAdProd := lQry.FieldByName('infAdProd').AsString;
      end;
      with Produto.Imposto do
      begin
        vTotTrib := lQry.FieldByName('vTotTrib').AsFloat;
        with ICMS do
        begin
          orig :=  vConfiguracoesNotaFiscal.orig(lQry.FieldByName('orig').Value);
          if NotaF.NFe.Emit.CRT in [crtSimplesExcessoReceita, crtRegimeNormal] then
          begin
            CST     := vConfiguracoesNotaFiscal.CST(lQry.FieldByName('CST').AsString);
          end else
          begin
            CSOSN   := vConfiguracoesNotaFiscal.CSOSN(lQry.FieldByName('CSOSN').AsString);
            pCredSN := lQry.FieldByName('pCredSN').Value;
            vCredICMSSN := lQry.FieldByName('vCredICMSSN').Value;
          end;
          modBC   := vConfiguracoesNotaFiscal.modBC(lQry.FieldByName('modBC').AsString);
          vBC     := lQry.FieldByName('vBC').AsFloat;
          pICMS   := lQry.FieldByName('pICMS').AsFloat;
          vICMS   := lQry.FieldByName('vICMS').AsFloat;
          modBCST := vConfiguracoesNotaFiscal.modBCST(lQry.FieldByName('modBCST').AsString);
          pMVAST  := lQry.FieldByName('pMVAST').AsFloat;
          pRedBCST:= lQry.FieldByName('pRedBCST').AsFloat;
          vBCST   := lQry.FieldByName('vBCST').AsFloat;
          pICMSST := lQry.FieldByName('pICMSST').AsFloat;
          vICMSST := lQry.FieldByName('vICMSST').AsFloat;
          pRedBC  := lQry.FieldByName('pRedBC').AsFloat;
          vBCFCPST := lQry.FieldByName('vBCFCPST').AsFloat;
          pFCPST   := lQry.FieldByName('pFCPST').AsFloat;
          vFCPST   := lQry.FieldByName('vFCPST').AsFloat;
          vBCSTRet := lQry.FieldByName('vBCSTRet').AsFloat;
          pST      := lQry.FieldByName('pST').AsFloat;
          vICMSSubstituto := lQry.FieldByName('vICMSSubstituto').AsFloat;
          vICMSSTRet      := lQry.FieldByName('vICMSSTRet').AsFloat;
          vBCFCPSTRet := lQry.FieldByName('vBCFCPSTRet').AsFloat;
          pFCPSTRet   := lQry.FieldByName('pFCPSTRet').AsFloat;
          vFCPSTRet   := lQry.FieldByName('vFCPSTRet').AsFloat;
          pRedBCEfet  := lQry.FieldByName('pRedBCEfet').AsFloat;
          vBCEfet     := lQry.FieldByName('vBCEfet').AsFloat;
          pICMSEfet   := lQry.FieldByName('pICMSEfet').AsFloat;
          vICMSEfet   := lQry.FieldByName('vICMSEfet').AsFloat;
        end;
        with ICMSUFDest do
        begin
          vBCUFDest      := lQry.FieldByName('vBCUFDest').AsFloat;
          pFCPUFDest     := lQry.FieldByName('pFCPUFDest').AsFloat;
          pICMSUFDest    := lQry.FieldByName('pICMSUFDest').AsFloat;
          pICMSInter     := lQry.FieldByName('pICMSInter').AsFloat;
          pICMSInterPart := lQry.FieldByName('pICMSInterPart').AsFloat;
          vFCPUFDest     := lQry.FieldByName('vFCPUFDest').AsFloat;
          vICMSUFDest    := lQry.FieldByName('vICMSUFDest').AsFloat;
          vICMSUFRemet   := lQry.FieldByName('vICMSUFRemet').AsFloat;
        end;
        with IPI do
        begin
          CST      := vConfiguracoesNotaFiscal.cstipi(lQry.FieldByName('cstipi').AsString);
          CNPJProd := lQry.FieldByName('CNPJProd').AsString;
          cSelo    := lQry.FieldByName('cSelo').AsString;
          qSelo    := lQry.FieldByName('qSelo').AsInteger;
          cEnq     := lQry.FieldByName('cEnq').AsString;
          vBC    := lQry.FieldByName('vBCipi').AsFloat;
          vUnid  := lQry.FieldByName('vBCUFDest').AsFloat;
          pIPI   := lQry.FieldByName('pIPI').AsFloat;
          vIPI   := lQry.FieldByName('vIPI').AsFloat;
        end;
        with II do
        begin
          vBc      := lQry.FieldByName('vBcII').AsFloat;
          vDespAdu := lQry.FieldByName('vDespAdu').AsFloat;
          vII      := lQry.FieldByName('vII').AsFloat;
          vIOF     := lQry.FieldByName('vIOF').AsFloat;
        end;
        with PIS do
        begin
          CST  :=  vConfiguracoesNotaFiscal.cstpis(lQry.FieldByName('CSTPIS').AsString);
          vBC  :=  lQry.FieldByName('vBCPIS').AsFloat;
          pPIS :=  lQry.FieldByName('pPIS').AsFloat;
          vPIS :=  lQry.FieldByName('vPIS').AsFloat;
          qBCProd   :=  lQry.FieldByName('qBCProd').AsFloat;
          vAliqProd :=  lQry.FieldByName('vAliqProd').AsFloat;
        end;
        with COFINS do
        begin
          CST     := vConfiguracoesNotaFiscal.cstcof(lQry.FieldByName('CSTCOFINS').AsString); ;
          vBC     := lQry.FieldByName('vBCCOFINS').AsFloat;
          pCOFINS := lQry.FieldByName('pCOFINS').AsFloat;
          vCOFINS := lQry.FieldByName('vCOFINS').AsFloat;
          qBCProd   := lQry.FieldByName('qBCProdCOFINS').AsFloat;
          vAliqProd := lQry.FieldByName('vAliqProdCOFINS').AsFloat;
        end;
      end;

      if not lQry.FieldByName('nLote').IsNull then begin
        Rastro := Produto.Prod.rastro.Add;
        Rastro.nLote  := lQry.FieldByName('nLote').AsString;
        Rastro.qLote  := lQry.FieldByName('qLote').AsInteger;
        Rastro.dFab   := lQry.FieldByName('dFab').AsDateTime;
        Rastro.dVal   := lQry.FieldByName('dVal').AsDateTime;
      end;

      if not lQry.FieldByName('cProdANVISA').IsNull then begin
        Medicamento := Produto.Prod.med.Add;
        Medicamento.cProdANVISA := lQry.FieldByName('cProdANVISA').AsString;
        Medicamento.vPMC        := lQry.FieldByName('vPMC').AsFloat;
        Medicamento.xMotivoIsencao := lQry.FieldByName('xMotivoIsencao').AsString;
      end;
      lQry.Next;
    end;
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TNotaFiscal.referenciada: Boolean;
begin
  //NFe referenciada
//  Referenciadas :=NotaF.NFe.Ide.NFref.Add;
//
//  Referenciadas.refNFe       := ''; //NFe Eletronica
//  Referenciadas.RefNF.cUF    := 0;  // |
//  Referenciadas.RefNF.AAMM   := ''; // |
//  Referenciadas.RefNF.CNPJ   := ''; // |
//  Referenciadas.RefNF.modelo := 1;  // |- NFe Modelo 1/1A
//  Referenciadas.RefNF.serie  := 1;  // |
//  Referenciadas.RefNF.nNF    := 0;  // |
//
//  Referenciadas.RefNFP.cUF     := 0;  // |
//  Referenciadas.RefNFP.AAMM    := ''; // |
//  Referenciadas.RefNFP.CNPJCPF := ''; // |
//  Referenciadas.RefNFP.IE      := ''; // |- NF produtor Rural
//  Referenciadas.RefNFP.modelo  := ''; // |
//  Referenciadas.RefNFP.serie   := 1;  // |
//  Referenciadas.RefNFP.nNF     := 0;  // |
//
//  Referenciadas.RefECF.modelo  := ECFModRef2B; // |
//  Referenciadas.RefECF.nECF    := '';          // |- Cupom Fiscal
//  Referenciadas.RefECF.nCOO    := '';          // |
end;
function TNotaFiscal.responsavelTecnico: Boolean;
begin
  with NotaF.NFe.infRespTec do
  begin
    CNPJ     := '09020312000131';
    xContato := 'Claudio Rogério Palma';
    email    := 'suporte@terasoft.inf.br';
    fone     := '4332533958';
  end;
end;
procedure TNotaFiscal.SetgerarPDF(const Value: Boolean);
begin
  FgerarPDF := Value;
end;
procedure TNotaFiscal.SetidNotaFiscal(const Value: String);
begin
  FidNotaFiscal := Value;
end;
procedure TNotaFiscal.SetidPedido(const Value: String);
begin
  FidPedido := Value;
end;
procedure TNotaFiscal.SetimprimirDANF(const Value: Boolean);
begin
  FimprimirDANF := Value;
end;
procedure TNotaFiscal.SetMostraPreview(const Value: Boolean);
begin
  FMostraPreview := Value;
end;
procedure TNotaFiscal.SetPathPDF(const Value: String);
begin
  FPathPDF := Value;
end;
function TNotaFiscal.totais(pidNF: String): Boolean;
var
 lSQL: String;
 lQry: TFDQuery;
begin
  try
    try
     lQry := vIConexao.CriarQuery;
     lSQL :=
    ' select                                                     '+#13+
    '     sum(coalesce(n.vbc_n15,0)) vBC,                        '+#13+
    '     sum(coalesce(n.vicms_n17,0)) vICMS,                    '+#13+
    '     sum(coalesce(n.vbcst_n21,0)) vBCST,                    '+#13+
    '     sum(coalesce(n.vicmsst_n23,0)) vST,                    '+#13+
    '     sum(coalesce(n.v_prod2,0)) as vprod,                   '+#13+
    '     sum(coalesce(n.frete,0)) vFrete,                       '+#13+
    '     sum(coalesce(n.vseg,0)) as vseg,                       '+#13+
    '     sum(coalesce(cast(n.vdesc as numeric(18,2)),0)) vDesc, '+#13+
    '     sum(coalesce(n.vii_p04,0)) vII,                        '+#13+
    '     sum(coalesce(n.valor_ipi,0)) vIPI,                     '+#13+
    '     sum(coalesce(n.vpis_q09,0)) vPIS,                      '+#13+
    '     sum(coalesce(n.vcofins_s11,0)) vCOFINS,                '+#13+
    '     sum(coalesce(n.voutros,0)) vOutro,                     '+#13+
    '     sum(coalesce(n.vTotTrib,0)) vTotTrib,                  '+#13+
    '     sum(coalesce(n.vfcpufdest,0)) vFCPUFDest,              '+#13+
    '     sum(coalesce(n.vicmsufdest,0)) vICMSUFDest,            '+#13+
    '     sum(coalesce(n.vicmsufremet,0)) vICMSUFRemet,          '+#13+
    '     sum(coalesce(n.vfcpst,0)) vFCPST,                      '+#13+
    '     sum(coalesce(n.vfcpstret,0)) vFCPSTRet,                '+#13+
    '     sum(coalesce(0,0)) vRetPIS,                            '+#13+
    '     sum(coalesce(0,0)) vRetCOFINS,                         '+#13+
    '     sum(coalesce(0,0)) vRetCSLL,                           '+#13+
    '     sum(coalesce(0,0)) vBCIRRF,                            '+#13+
    '     sum(coalesce(0,0)) vIRRF,                              '+#13+
    '     sum(coalesce(0,0)) vBCRetPrev,                         '+#13+
    '     sum(coalesce(0,0)) vRetPrev                            '+#13+
    ' from                                                       '+#13+
    '     nfitens n                                              '+#13+
    ' where                                                      '+#13+
    '      n.numero_nf = '+QuotedStr(pidNF);
     lQry.Open(lSQL);
      with NotaF.NFe.Total.ICMSTot do
      begin
        vBC          := lQry.FieldByName('vBC').Value;
        vICMS        := lQry.FieldByName('vICMS').Value;
        vBCST        := lQry.FieldByName('vBCST').Value;
        vST          := lQry.FieldByName('vST').Value;
        vProd        := lQry.FieldByName('vProd').Value;
        vFrete       := lQry.FieldByName('vFrete').Value;
        vSeg         := lQry.FieldByName('vSeg').Value;
        vDesc        := lQry.FieldByName('vDesc').Value;
        vII          := lQry.FieldByName('vII').Value;
        vIPI         := lQry.FieldByName('vIPI').Value;
        vPIS         := lQry.FieldByName('vPIS').Value;
        vCOFINS      := lQry.FieldByName('vCOFINS').Value;
        vOutro       := lQry.FieldByName('vOutro').Value;
        vTotTrib     := lQry.FieldByName('vTotTrib').Value;
        vFCPUFDest   := lQry.FieldByName('vFCPUFDest').Value;
        vICMSUFDest  := lQry.FieldByName('vICMSUFDest').Value;
        vICMSUFRemet := lQry.FieldByName('vICMSUFRemet').Value;
        vFCPST       := lQry.FieldByName('vFCPST').Value;
        vFCPSTRet    := lQry.FieldByName('vFCPSTRet').Value;
        vNF          := (vProd+vST+vFrete+vSeg+vIPI+vOutro+vFCPST)-vDesc;
      end;
      with NotaF.NFe.Total.retTrib do
      begin
        vRetPIS      := lQry.FieldByName('vRetPIS').Value;
        vRetCOFINS   := lQry.FieldByName('vRetCOFINS').Value;
        vRetCSLL     := lQry.FieldByName('vRetCSLL').Value;
        vBCIRRF      := lQry.FieldByName('vBCIRRF').Value;
        vIRRF        := lQry.FieldByName('vIRRF').Value;
        vBCRetPrev   := lQry.FieldByName('vBCRetPrev').Value;
        vRetPrev     := lQry.FieldByName('vRetPrev').Value;
      end;
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TNotaFiscal.transporte(pidNF: String): Boolean;
var
 lSQL: String;
 lQry: TFDQuery;
begin
  try
    try
     lQry := vIConexao.CriarQuery;
     lSQL :=
    ' select                                                         '+#13+
    '     n.tipo_frete         modFrete,                             '+#13+
    '     t.CNPJ_CPF_TRA       CNPJCPF,                              '+#13+
    '     t.RAZAO_TRA          xNome,                                '+#13+
    '     t.INSCRICAO_RG_TRA   IE,                                   '+#13+
    '     t.ENDERECO_TRA       xEnder,                               '+#13+
    '     t.CIDADE_TRA         xMun,                                 '+#13+
    '     t.UF_TRA             UF,                                   '+#13+
    '     n.qtde_volume        qVol,                                 '+#13+
    '     n.especie_volume     esp,                                  '+#13+
    '     n.tra_marca          marca,                                '+#13+
    '     n.tra_numeracao      nVol,                                 '+#13+
    '     coalesce(n.peso_liquido_new, n.peso_liquido) pesoL,        '+#13+
    '     coalesce(n.peso_bruto_new, n.peso_bruto)     pesoB,        '+#13+
    '     n.uf_embarque    UFembarq,                                 '+#13+
    '     n.local_embarque xLocEmbarq                                '+#13+
    '                                                                '+#13+
    ' from nf n                                                      '+#13+
    '                                                                '+#13+
    ' left join transportadora t on t.codigo_tra = n.transportadora  '+#13+
    '                                                                '+#13+
    ' where                                                          '+#13+
    '      n.numero_nf = '+QuotedStr(pidNF);
     lQry.Open(lSQL);
      with NotaF.NFe.Transp do
      begin
        modFrete := vConfiguracoesNotaFiscal.modFrete(lQry.FieldByName('modFrete').Value);
        Transporta.CNPJCPF  := lQry.FieldByName('CNPJCPF').AsString;
        Transporta.xNome    := lQry.FieldByName('xNome').AsString;
        Transporta.IE       := lQry.FieldByName('IE').AsString;
        Transporta.xEnder   := lQry.FieldByName('xEnder').AsString;
        Transporta.xMun     := lQry.FieldByName('xMun').AsString;
        Transporta.UF       := lQry.FieldByName('UF').AsString;
      end;
      Volume := NotaF.NFe.Transp.Vol.New;
      Volume.qVol  :=  lQry.FieldByName('qVol').AsInteger;
      Volume.esp   :=  lQry.FieldByName('esp').AsString;
      Volume.marca :=  lQry.FieldByName('marca').AsString;
      Volume.nVol  :=  lQry.FieldByName('nVol').AsString;
      Volume.pesoL :=  lQry.FieldByName('pesoL').AsFloat;
      Volume.pesoB :=  lQry.FieldByName('pesoB').AsFloat;
      NotaF.NFe.exporta.UFembarq   := lQry.FieldByName('UFembarq').AsString;
      NotaF.NFe.exporta.xLocEmbarq := lQry.FieldByName('xLocEmbarq').AsString;
    except
    on E:Exception do
       CriaException('Erro: ' + E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TNotaFiscal.VencimentoCertificado: TDateTime;
begin
  Self.configuraComponenteNFe;
  Result := ACBrNFe.SSL.CertDataVenc;
end;

constructor TNotaFiscal.Create(pIConexao: IConexao);
begin
  vIConexao := pIConexao;
  ACBrNFe   := TACBrNFe.Create(nil);

  vConfiguracoesNotaFiscal := TConfiguracoesNotaFiscal.Create(vIConexao);

  configuraComponenteNFe;
  FidNotaFiscal  := '';
  FidPedido      := '';
  FPathPDF       := '';
  FimprimirDANF  := True;
  FMostraPreview := True;
  FgerarPDF      := False;
end;

destructor TNotaFiscal.Destroy;
begin
  vConfiguracoesNotaFiscal.Free;
  inherited;
end;

procedure TNotaFiscal.processar(idNotaFiscal: String);
begin
  identificacao(idNotaFiscal);
  referenciada;
  emitente;
  destinatario(idNotaFiscal);
  enderecoEntrega;
  itens(idNotaFiscal);
  totais(idNotaFiscal);
  transporte(idNotaFiscal);
  cobranca(idNotaFiscal);
  Observacoes(idNotaFiscal);
  responsavelTecnico;
end;

function TNotaFiscal.transmitir(idNotaFiscal: String): TStringList;
var
  lRetorno: TStringList;
  lQry: TFDQuery;
  loteEnvio: Integer;
  lchavenfe : String;
  lprotocolo : String;
  lrecibo  : String;
  lxMotivo : String;
  lCSTAT : String;
  lNFContol: TNFContol;
  lPedidoVendaModel: TPedidoVendaModel;
begin

 try
  lRetorno  := TStringList.Create;
  lNFContol := TNFContol.Create(idNotaFiscal, vIConexao);
  loteEnvio := idNotaFiscal.ToInteger;
  lPedidoVendaModel := TPedidoVendaModel.Create(vIConexao);

  try
    processar(idNotaFiscal);
    ACBrNFe.NotasFiscais.GerarNFe;
    ACBrNFe.NotasFiscais.Assinar;

    if ACBrNFe.NotasFiscais.Items[0].NFe.Ide.modelo = 55 then
    begin
      try
        ACBrNFe.Enviar(loteEnvio, false);
      finally
        lchavenfe  := ACBrNFe.NotasFiscais[0].NFe.procNFe.chNFe;
        lprotocolo := ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.nProt;
        lrecibo    := ACBrNFe.WebServices.Enviar.Recibo;
        lxMotivo   := ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.xMotivo;
        lCSTAT     := IntToStr(ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.cStat);
      end;
    end
    else
    begin
      try
        ACBrNFe.Enviar(loteEnvio, false, True);
      finally
        lchavenfe  := ACBrNFe.NotasFiscais[0].NFe.procNFe.chNFe;
        lprotocolo := ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.nProt;
        lrecibo    := ACBrNFe.WebServices.Enviar.Recibo;
        lxMotivo   := ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.xMotivo;
        lCSTAT     := IntToStr(ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.cStat);
      end;
    end;

    if lCSTAT <> '100' then
      lxMotivo := 'NOTA NAO AUTORIZADA: ' + lxMotivo;

    lNFContol.NFModel.Acao          := Terasoft.Types.tacAlterar;
    lNFContol.NFModel.NOME_XML      := copy(lxMotivo, 1, 500);
    lNFContol.NFModel.ID_NF3        := lchavenfe;
    lNFContol.NFModel.PROTOCOLO_NFE := lprotocolo;
    lNFContol.NFModel.RECIBO_NFE    := lrecibo;
    lNFContol.NFModel.XML_NFE       := ACBrNFe.NotasFiscais.Items[0].GerarXML;
    lNFContol.NFModel.NUMERO_NF     := idNotaFiscal;
    lNFContol.Salvar;

    if lNFContol.NFModel.NUMERO_PED <> '' then
    begin
      lPedidoVendaModel := lPedidoVendaModel.carregaClasse(lNFContol.NFModel.NUMERO_PED);
      lPedidoVendaModel.faturado(lNFContol.NFModel.NUMERO_ECF);
    end;

    lRetorno.Add(lCSTAT);
    lRetorno.Add(lxMotivo);
    lRetorno.Add(lrecibo);
    lRetorno.Add(lprotocolo);
    Result := lRetorno;

  except on E: Exception do
   begin
    lNFContol.NFModel.Acao       := Terasoft.Types.tacAlterar;
    lNFContol.NFModel.NOME_XML   := copy('NOTA NAO AUTORIZADA: '+e.Message, 1, 500);
    lNFContol.NFModel.XML_NFE    := ACBrNFe.NotasFiscais.Items[0].GerarXML;
    lNFContol.NFModel.NUMERO_NF  := idNotaFiscal;
    lNFContol.Salvar;

    lRetorno.Add(lCSTAT);
    lRetorno.Add(e.Message);
    lRetorno.Add(lrecibo);
    lRetorno.Add(lprotocolo);

    Result := lRetorno;
   end;
  end;

 finally
    lQry.Free;
    lNFContol.Free;
    lPedidoVendaModel.Free;
 end;
end;

end.
