unit Terasoft.NotaFiscal;
interface
uses
  Terasoft.Framework.Texto,
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
  NFModel,
  Terasoft.Types,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  ConfiguracoesLocaisModel;

type
  TNotaFiscal = class;
  ITNotaFiscal=IObject<TNotaFiscal>;

  TNotaFiscal = class
  private
    [unsafe] mySelf: ITNotaFiscal;
    vIConexao: IConexao;
    ACBrNFe: TACBrNFe;
    NotaF: NotaFiscal;
    ACBrNFeDANFeRL: TACBrNFeDANFeRL;
    ACBrNFeDANFCeFortes: TACBrNFeDANFCeFortes;
    vConfiguracoesNotaFiscal: ITConfiguracoesNotaFiscal;
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
    FImpressoraNFC: String;
    vTransmitir : String;
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
    function retornaIBPT(pNF : String): String;
    procedure processar(idNotaFiscal: String);
    procedure SetgerarPDF(const Value: Boolean);
    procedure SetidNotaFiscal(const Value: String);
    procedure SetidPedido(const Value: String);
    procedure SetimprimirDANF(const Value: Boolean);
    procedure SetMostraPreview(const Value: Boolean);
    procedure SetPathPDF(const Value: String);
    procedure SetImpressoraNFC(const Value: String);

  public
    property idNotaFiscal  : String read FidNotaFiscal write SetidNotaFiscal;
    property idPedido      : String read FidPedido write SetidPedido;
    property PathPDF       : String read FPathPDF write SetPathPDF;
    property imprimirDANF      : Boolean read FimprimirDANF write SetimprimirDANF;
    property MostraPreview : Boolean read FMostraPreview write SetMostraPreview;
    property gerarPDF      : Boolean read FgerarPDF write SetgerarPDF;
    property ImpressoraNFC : String read FImpressoraNFC write SetImpressoraNFC;

    constructor _Create(pIConexao: IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITNotaFiscal;

    function transmitir(idNotaFiscal: String): IListaTextoEx;
    function consultarNota(idNotaFiscal: String): boolean;
    function imprimir: String;
    function gerarXML(idNotaFiscal, pPath: String): String;
    function VencimentoCertificado: TDateTime;

  end;
implementation

uses
  Terasoft.Utils,
  System.Variants,
  PedidoVendaModel,
  Terasoft.FuncoesTexto, System.StrUtils, System.Math, Terasoft.Configuracoes,
  IbptModel;

{ TNotaFiscal }

function TNotaFiscal.configuraComponenteNFe: Boolean;
begin
  ACBrNFe.NotasFiscais.Clear;

  if(Length(vConfiguracoesNotaFiscal.objeto.certificadoArquivoPFX)>256) or not FileExists(vConfiguracoesNotaFiscal.objeto.certificadoArquivoPFX) then
    ACBrNFe.Configuracoes.Certificados.DadosPFX  := vConfiguracoesNotaFiscal.objeto.certificadoArquivoPFX
  else
    ACBrNFe.Configuracoes.Certificados.ArquivoPFX  := vConfiguracoesNotaFiscal.objeto.certificadoArquivoPFX;

  ACBrNFe.Configuracoes.Certificados.Senha       := vConfiguracoesNotaFiscal.objeto.certificadoSenha;
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
    FormaEmissao     := vConfiguracoesNotaFiscal.objeto.tipoEmissao;
    VersaoDF         := vConfiguracoesNotaFiscal.objeto.versaoDF;
    IdCSC            := vConfiguracoesNotaFiscal.objeto.IdCSC;
    CSC              := vConfiguracoesNotaFiscal.objeto.CSC;
    VersaoQRCode     := vConfiguracoesNotaFiscal.objeto.versaoQRCode;
  end;
  with ACBrNFe.Configuracoes.WebServices do
  begin
    UF         := vConfiguracoesNotaFiscal.objeto.ufEmissao;
    Ambiente   := vConfiguracoesNotaFiscal.objeto.ambiente;
    Visualizar := False;
    Salvar     := True;
  end;
  ACBrNFe.SSL.SSLType := TSSLType(0);
  with ACBrNFe.Configuracoes.Arquivos do
  begin
    Salvar           := vConfiguracoesNotaFiscal.objeto.arquivosSalvar;
    SepararPorMes    := vConfiguracoesNotaFiscal.objeto.arquivosSepararPorMes;
    AdicionarLiteral := vConfiguracoesNotaFiscal.objeto.arquivosAdicionarLiteral;
    EmissaoPathNFe   := vConfiguracoesNotaFiscal.objeto.arquivosEmissaoPathNFe;
    SalvarEvento     := vConfiguracoesNotaFiscal.objeto.arquivosSalvarEvento;
    SepararPorCNPJ   := vConfiguracoesNotaFiscal.objeto.arquivosSepararPorCNPJ;
    SepararPorModelo := vConfiguracoesNotaFiscal.objeto.arquivosSepararPorModelo;
    PathSchemas      := vConfiguracoesNotaFiscal.objeto.arquivosPathSchemas;
    PathNFe          := vConfiguracoesNotaFiscal.objeto.arquivosPathNFe;
    PathInu          := vConfiguracoesNotaFiscal.objeto.arquivosPathInu;
    PathEvento       := vConfiguracoesNotaFiscal.objeto.arquivosPathEvento;
    PathSalvar       := vConfiguracoesNotaFiscal.objeto.arquivosPathSalvar;
  end;
end;

function TNotaFiscal.consultarNota(idNotaFiscal: String): boolean;
var
  lNFContol : ITNFContol;
begin
  Result := False;

  lNFContol := TNFContol.getNewIface(idNotaFiscal, vIConexao);
  try
    processar(idNotaFiscal);
    ACBrNFe.NotasFiscais.Assinar;
    ACBrNFe.Consultar;

    if ACBrNFe.WebServices.Consulta.cStat = 100 then
    begin
      lNFContol.objeto.NFModel.objeto.Acao                 := Terasoft.Types.tacAlterar;
      lNFContol.objeto.NFModel.objeto.STATUS_TRANSMISSAO := '8';
      lNFContol.objeto.NFModel.objeto.NOME_XML           := ACBrNFe.WebServices.Consulta.XMotivo;
      lNFContol.objeto.NFModel.objeto.ID_NF3             := ACBrNFe.WebServices.Consulta.NFeChave;
      lNFContol.objeto.NFModel.objeto.PROTOCOLO_NFE      := ACBrNFe.WebServices.Consulta.Protocolo;
      lNFContol.objeto.NFModel.objeto.XML_NFE            := ACBrNFe.NotasFiscais.Items[0].GerarXML;
      lNFContol.objeto.Salvar;

      Result := True;
    end;
  finally
    lNFContol := nil;
  end;
end;

function TNotaFiscal.cobranca(pidNF: String): Boolean;
var
 lSQL,
 lSQLItens,
 lFatura      : String;
 lQry,
 lQryItens    : TFDQuery;
 lPercentual,
 lTotalFinanceiro,
 lSomaDup,
 lTotalNF     : Extended;
 lPortador    : String;
begin
  try
    try
      lQryItens := vIConexao.CriarQuery;
      lQry      := vIConexao.CriarQuery;

      lSQLItens :=  ' select                                                     '+#13+
                    '     sum(coalesce(n.vicmsst_n23,0)) vST,                    '+#13+
                    '     sum(coalesce(n.v_prod2,0)) as vprod,                   '+#13+
                    '     sum(coalesce(n.frete,0)) vFrete,                       '+#13+
                    '     sum(coalesce(n.vseg,0)) as vseg,                       '+#13+
                    '     sum(coalesce(cast(n.vdesc as numeric(18,2)),0)) vDesc, '+#13+
                    '     sum(coalesce(n.valor_ipi,0)) vIPI,                     '+#13+
                    '     sum(coalesce(n.voutros,0)) vOutro,                     '+#13+
                    '     sum(coalesce(n.vfcpst,0)) vFCPST                       '+#13+
                    ' from                                                       '+#13+
                    '     nfitens n                                              '+#13+
                    ' where                                                      '+#13+
                    '      n.numero_nf = '+QuotedStr(pidNF);

      lQryItens.Open(lSQLItens);

      lTotalNF := (lQryItens.FieldByName('vProd').AsFloat  +
                   lQryItens.FieldByName('vST').AsFloat    +
                   lQryItens.FieldByName('vFrete').AsFloat +
                   lQryItens.FieldByName('vSeg').AsFloat   +
                   lQryItens.FieldByName('vIPI').AsFloat   +
                   lQryItens.FieldByName('vOutro').AsFloat +
                   lQryItens.FieldByName('vFCPST').AsFloat ) - lQryItens.FieldByName('vDesc').AsFloat;

      lSQL :=
        ' select n.modelo            modeloNF,                                      '+#13+
        '        n.numero_ecf        nFat,                                          '+#13+
        '        n.total_nf          vOrig,                                         '+#13+
        '        c.codigo_por        codigo_por,                                    '+#13+
        '        c.valor_rec         valor_rec,                                     '+#13+
        '        ci.pacela_rec       nDup,                                          '+#13+
        '        ci.vlrparcela_rec   vDup,                                          '+#13+
        '        ci.vencimento_rec   dVenc,                                         '+#13+
        '        p.tpag_nfe          tPag,                                          '+#13+
        '        c.fatura_rec        nFatura                                        '+#13+
        '   from nf n                                                               '+#13+
        '  inner join contasreceber c on c.pedido_rec = n.pedido_id                 '+#13+
        '  inner join contasreceberitens ci on ci.fatura_rec = c.fatura_rec         '+#13+
        '  inner join portador p on p.codigo_port = c.codigo_por                    '+#13+
        '  where n.numero_nf = '+QuotedStr(pidNF) + '                               '+#13+
        '  order by c.codigo_por ';

      lQry.Open(lSQL);

      lTotalFinanceiro := 0;
      lSomaDup         := 0;

      lQry.First;
      while not lQry.Eof do
      begin
        lTotalFinanceiro := lTotalFinanceiro + lQry.FieldByName('vDup').AsFloat;
        lQry.Next;
      end;

      lPercentual := lTotalNF / lTotalFinanceiro;
      
      if lQry.FieldByName('modeloNF').AsInteger = 55 then
      begin

        if lQry.IsEmpty then
        begin
          InfoPgto := NotaF.NFe.pag.New;
          InfoPgto.indPag := ipNenhum;
          InfoPgto.tPag   := fpSemPagamento;
          exit;
        end;

        lQry.First;
        while not lQry.Eof do
        begin
          if not AnsiMatchStr(lQry.FieldByName('tPag').AsString, ['01', '03', '04', '99']) then
          begin
          
            if lFatura = '' then
              lFatura := lQry.FieldByName('nFatura').AsString
            else
            if lFatura <> lQry.FieldByName('nFatura').AsString then
              Break;

            with NotaF.NFe.Cobr.Fat do
            begin
              nFat  := lQry.FieldByName('nFat').AsString;
              vOrig := vOrig + lQry.FieldByName('vDup').AsFloat;
              vDesc := 0;
              vLiq  := vLiq + lQry.FieldByName('vDup').AsFloat;
            end;

            lFatura := lQry.FieldByName('nFatura').AsString;
            
          end;
          lQry.Next;
        end;

        lFatura := '';

        lQry.First;
        while not lQry.Eof do
        begin
          if not AnsiMatchStr(lQry.FieldByName('tPag').AsString, ['01', '03', '04', '99']) then
          begin

            if lFatura = '' then
              lFatura := lQry.FieldByName('nFatura').AsString
            else
            if lFatura <> lQry.FieldByName('nFatura').AsString then
              Break;

            Duplicata :=  NotaF.NFe.Cobr.Dup.New;
            Duplicata.nDup  := FormatFloat('000',lQry.FieldByName('nDup').AsInteger);
            Duplicata.dVenc := lQry.FieldByName('dVenc').Value;
            Duplicata.vDup  := lPercentual * lQry.FieldByName('vDup').AsFloat;

            lFatura := lQry.FieldByName('nFatura').AsString;
            
          end;
          lQry.Next;
        end;

      end;

      lPortador := '';

      lQry.First;
      while not lQry.Eof do
      begin

        if lPortador <> lQry.FieldByName('codigo_por').AsString then
        begin
          lPortador := lQry.FieldByName('codigo_por').AsString;

          InfoPgto := NotaF.NFe.pag.New;
          InfoPgto.indPag := ipPrazo;
          InfoPgto.tPag   := vConfiguracoesNotaFiscal.objeto.tPag(lQry.FieldByName('tPag').AsString);
          InfoPgto.vPag   := RoundTo(lPercentual * lQry.FieldByName('valor_rec').AsFloat, -2);

          lSomaDup        := lSomaDup + InfoPgto.vPag;

          if InfoPgto.tPag in [fpCartaoCredito, fpCartaoDebito, fpPagamentoInstantaneo] then
            InfoPgto.tpIntegra := tiPagNaoIntegrado;
        end;

        lQry.Next;

        if lQry.Eof then
        begin
          if lTotalNF <> lSomaDup then
            InfoPgto.vPag := InfoPgto.vPag + (lTotalNF - lSomaDup);
        end;
      end;

    except
    on E:Exception do
      CriaException('Erro: '+ E.Message);
    end;

  finally
    lSQLItens := '';
    lSQL      := '';
    lQryItens.Free;
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

      lSQL := ' select                                                       '+#13+
              ' c.cnpj_cpf_cli CNPJCPF,                                      '+#13+
              ' pv.cnpj_cpf_consumidor cpf_consumidor,                       '+#13+
              ' c.inscricao_rg_cli IE,                                       '+#13+
              ' c.SUFRAMA ISUF,                                              '+#13+
              ' c.CONSUMIDOR_FINAL indFinal,                                 '+#13+
              ' c.NAO_CONTRIBUINTE indIEDest,                                '+#13+
              ' IIF (c.tipo_cli = ''F'', c.fantasia_cli, c.razao_cli) xNome, '+#13+
              ' c.telefone_cli Fone,                                         '+#13+
              ' c.cep_cli CEP,                                               '+#13+
              ' c.endereco_cli xLgr,                                         '+#13+
              ' coalesce(c.numero_end, 0) nro,                               '+#13+
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
              ' left join pedidovenda pv on pv.numero_nf = n.numero_ecf      '+#13+
              '                                                              '+#13+
              ' where                                                        '+#13+
              '     n.numero_nf = '+QuotedStr(pidNF);

      lQry.Open(lSQL);

      with NotaF.NFe.Dest do
      begin

        CNPJCPF           := IIF(lQry.FieldByName('CNPJCPF').AsString <> ''    , lQry.FieldByName('CNPJCPF').AsString,  Unassigned);
        ISUF              := IIF(lQry.FieldByName('ISUF').AsString <> ''       , lQry.FieldByName('ISUF').AsString,     Unassigned);
        xNome             := IIF(lQry.FieldByName('xNome').AsString <> ''      , lQry.FieldByName('xNome').AsString,    Unassigned);

        if StrToIntDef(lQry.FieldByName('IE').AsString, 0) = 0 then
        begin
          IE := '';
          indIEDest := inIsento;
        end
        else
        begin
          IE        := IIF(lQry.FieldByName('IE').AsString <> ''         , lQry.FieldByName('IE').AsString,       Unassigned);
          indIEDest := IIF(lQry.FieldByName('indIEDest').AsString <> ''  , vConfiguracoesNotaFiscal.objeto.indIEDest(lQry.FieldByName('indIEDest').AsString),  Unassigned);
        end;

        if vConfiguracoesNotaFiscal.objeto.modeloDF(lQry.FieldByName('modelo').AsInteger) = moNFCe then
        begin
          if (lQry.FieldByName('xLgr').AsString <> '') and (lQry.FieldByName('xBairro').AsString <> '') and (lQry.FieldByName('cMun').AsString <> '') and (Length(IntToStr(lQry.FieldByName('cMun').AsInteger)) = 7) and
          (Length(lQry.FieldByName('CEP').AsString) = 8) and (Trim(lQry.FieldByName('Fone').AsString) <> '') and (lQry.FieldByName('xMun').AsString <> '') and
          (Trim(lQry.FieldByName('UF').AsString) <> '') and (vConfiguracoesNotaFiscal.objeto.emitUF = Trim(lQry.FieldByName('UF').AsString)) then
          begin
            EnderDest.xBairro := lQry.FieldByName('xBairro').AsString;
            EnderDest.cMun    := lQry.FieldByName('cMun').AsInteger;
            EnderDest.UF      := lQry.FieldByName('UF').AsString;
            EnderDest.Fone    := lQry.FieldByName('Fone').AsString;
            EnderDest.CEP     := lQry.FieldByName('CEP').AsInteger;
            EnderDest.xLgr    := lQry.FieldByName('xLgr').AsString;
            EnderDest.nro     := lQry.FieldByName('nro').AsString;
            EnderDest.xCpl    := lQry.FieldByName('xCpl').AsString;
            EnderDest.xMun    := lQry.FieldByName('xMun').AsString;
            EnderDest.cPais   := lQry.FieldByName('cPais').AsInteger;
            EnderDest.xPais   := lQry.FieldByName('xPais').AsString;
          end;
        end
        else
        begin
          EnderDest.Fone    := IIF(lQry.FieldByName('Fone').AsString <> ''       , lQry.FieldByName('Fone').AsString,     Unassigned);
          EnderDest.CEP     := IIF(lQry.FieldByName('CEP').AsString <> ''        , lQry.FieldByName('CEP').AsString,      Unassigned);
          EnderDest.xLgr    := IIF(lQry.FieldByName('xLgr').AsString <> ''       , lQry.FieldByName('xLgr').AsString,     Unassigned);
          EnderDest.nro     := IIF(lQry.FieldByName('nro').AsString <> ''        , lQry.FieldByName('nro').AsString,      Unassigned);
          EnderDest.xCpl    := IIF(lQry.FieldByName('xCpl').AsString <> ''       , lQry.FieldByName('xCpl').AsString,     Unassigned);
          EnderDest.xMun    := IIF(lQry.FieldByName('xMun').AsString <> ''       , lQry.FieldByName('xMun').AsString,     Unassigned);
          EnderDest.cPais   := IIF(lQry.FieldByName('cPais').AsString <> ''      , lQry.FieldByName('cPais').AsString,    Unassigned);
          EnderDest.xPais   := IIF(lQry.FieldByName('xPais').AsString <> ''      , lQry.FieldByName('xPais').AsString,    Unassigned);
          EnderDest.xBairro := IIF(lQry.FieldByName('xBairro').AsString <> ''    , lQry.FieldByName('xBairro').AsString,  Unassigned);
          EnderDest.cMun    := IIF(lQry.FieldByName('cMun').AsString <> ''       , lQry.FieldByName('cMun').AsString,     Unassigned);
          EnderDest.UF      := IIF(lQry.FieldByName('UF').AsString <> ''         , lQry.FieldByName('UF').AsString,       Unassigned);
        end;

        if vConfiguracoesNotaFiscal.objeto.modeloDF(lQry.FieldByName('modelo').AsInteger) = moNFCe then
        begin
          indIEDest := inNaoContribuinte;
          IE        := '';
          CNPJCPF   := lQry.FieldByName('cpf_consumidor').AsString;
        end;

      end;

      with NotaF.NFe.Ide do
      begin
       if vConfiguracoesNotaFiscal.objeto.modeloDF(lQry.FieldByName('modelo').AsInteger) = moNFCe then
         indFinal := cfConsumidorFinal
       else
         indFinal := vConfiguracoesNotaFiscal.objeto.indFinal(lQry.FieldByName('indFinal').AsString);
      end;
       with NotaF.NFe.Emit do
      begin
       if vConfiguracoesNotaFiscal.objeto.modeloDF(lQry.FieldByName('modelo').AsInteger) <> moNFCe then
         IEST := vConfiguracoesNotaFiscal.objeto.emitIEST(NotaF.NFe.Dest.EnderDest.UF);
      end

    except
    on E:Exception do
      CriaException('Erro: '+ E.Message);
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
    CNPJCPF           := vConfiguracoesNotaFiscal.objeto.emitCNPJCPF;
    IE                := vConfiguracoesNotaFiscal.objeto.emitIE;
    xNome             := vConfiguracoesNotaFiscal.objeto.emitxNome;
    xFant             := vConfiguracoesNotaFiscal.objeto.emitxFant;
    EnderEmit.fone    := vConfiguracoesNotaFiscal.objeto.emitfone;
    EnderEmit.CEP     := vConfiguracoesNotaFiscal.objeto.emitCEP.ToInteger;
    EnderEmit.xLgr    := vConfiguracoesNotaFiscal.objeto.emitxLgr;
    EnderEmit.nro     := vConfiguracoesNotaFiscal.objeto.eEmitnro;
    EnderEmit.xCpl    := vConfiguracoesNotaFiscal.objeto.emitxCpl;
    EnderEmit.xBairro := vConfiguracoesNotaFiscal.objeto.emitxBairro;
    EnderEmit.cMun    := vConfiguracoesNotaFiscal.objeto.eEmitcMun.ToInteger;
    EnderEmit.xMun    := vConfiguracoesNotaFiscal.objeto.emitxMun;
    EnderEmit.UF      := vConfiguracoesNotaFiscal.objeto.emitUF;
    enderEmit.cPais   := vConfiguracoesNotaFiscal.objeto.emitcPais;
    enderEmit.xPais   := vConfiguracoesNotaFiscal.objeto.emitxPais;
    CRT               := vConfiguracoesNotaFiscal.objeto.emitCRT;
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
  lQry := nil;
  lXML := nil;
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
        CriaException('Erro: '+ E.Message);
    end;
  finally
    lSQL := '';
    FreeAndNil(lQry);
    freeAndNil(lXML);
  end;
end;

class function TNotaFiscal.getNewIface(pIConexao: IConexao): ITNotaFiscal;
begin
  Result := TImplObjetoOwner<TNotaFiscal>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TNotaFiscal.identificacao(pidNF: String): Boolean;
var
 lSQL: String;
 lQry: TFDQuery;
 lConfiguracoesLocaisModel : ITConfiguracoesLocaisModel;
 lDataSet : IFDDataset;
begin

  lConfiguracoesLocaisModel := TConfiguracoesLocaisModel.getNewIface(vIConexao);

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
      '    n.cnf cNF,                             '+#13+
      '    n.data_nf dEmi,                        '+#13+
      '    n.hora_nf hEmi,                        '+#13+
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
        cNF         := lQry.FieldByName('cNF').AsInteger;
        dEmi        := StrToDateTime(lQry.FieldByName('dEmi').AsString + ' ' + lQry.FieldByName('hEmi').AsString);
        dSaiEnt     := StrToDateTime(lQry.FieldByName('dSaiEnt').AsString + ' ' +lQry.FieldByName('hSaiEnt').AsString);
        hSaiEnt     := lQry.FieldByName('hSaiEnt').Value;
        tpNF        := vConfiguracoesNotaFiscal.objeto.tpNF(lQry.FieldByName('tpNF').AsString);
        verProc     := 'ERP_TERASOFT';
        cUF         := UFtoCUF(vConfiguracoesNotaFiscal.objeto.emitUF);
        cMunFG      := vConfiguracoesNotaFiscal.objeto.eEmitcMun.ToInteger;
        finNFe      := vConfiguracoesNotaFiscal.objeto.finNFe(lQry.FieldByName('finNFe').AsString);
        indIntermed := vConfiguracoesNotaFiscal.objeto.indIntermed(lQry.FieldByName('indIntermed').AsString);
        indPres     := vConfiguracoesNotaFiscal.objeto.indPres(lQry.FieldByName('indPres').AsString);
        idDest      := vConfiguracoesNotaFiscal.objeto.idDest(lQry.FieldByName('idDest').AsString);

        if vConfiguracoesNotaFiscal.objeto.modeloDF(lQry.FieldByName('modelo').AsInteger) = moNFCe then
         tpImp      := tiNFCe;

        if tpEmis <> teNormal then
        begin
          dhCont := vConfiguracoesNotaFiscal.objeto.dhCont;
          xJust  := 'Problemas no WebService';
        end;

        lConfiguracoesLocaisModel.objeto.WhereView := 'AND CONFIGURACOESLOCAIS.TAG = ''STATUS_NFCE'' ';
        lDataSet := lConfiguracoesLocaisModel.objeto.obterLista;

        if lDataSet.objeto.RecordCount > 0 then
          vTransmitir := lDataSet.objeto.FieldByName('VALORSTRING').AsString;

        if (vTransmitir = 'F') and (modelo = 65) then
        begin
          tpEmis := teOffLine;
          dhCont := vIConexao.DataServer;
          xJust  :='Entrada em contingência por falhas na conexão com o web service.';
        end;
      end;

      with ACBrNFe.Configuracoes.Geral do
      begin
        ModeloDF := vConfiguracoesNotaFiscal.objeto.modeloDF(lQry.FieldByName('modelo').AsInteger);
      end;

      if NotaF.NFe.Ide.indIntermed = iiOperacaoComIntermediador then
      begin
        NotaF.NFe.infIntermed.CNPJ := lQry.FieldByName('CNPJ').AsString;
        NotaF.NFe.infIntermed.idCadIntTran := lQry.FieldByName('idCadIntTran').AsString;
      end;

    except
    on E:Exception do
        CriaException('Erro: '+ E.Message);
    end;
  finally
    lSQL := '';
    lQry.Free;
    lConfiguracoesLocaisModel := nil;
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

      lSQL := ' select               '+#13+
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

      if (copy(Trim(lQry.FieldByName('nome_xml').AsString),1,10) <> 'Autorizado') and (lQry.FieldByName('nome_xml').AsString <> 'Emitido em Off-Line') then
        CriaException('Não é possível imprimir uma nota não autorizada.');

      if lQry.FieldByName('status_nf').AsString = 'X' then
        CriaException('Não foi possível imprimir uma nota cancelada ou inutilizada.');

      if lQry.FieldByName('pmoNFe').AsInteger = 65 then
      begin
        ACBrNFeDANFCeFortes := TACBrNFeDANFCeFortes.Create(ACBrNFe);
        ACBrNFe.DANFE       := ACBrNFeDANFCeFortes;

        if ImpressoraNFC <> '' then
          ACBrNFe.DANFE.Impressora := ImpressoraNFC;

        ACBrNFeDANFCeFortes.ImprimeQRCodeLateral := True;
        ACBrNFeDANFCeFortes.FormularioContinuo   := True;
      end
      else
      begin
        ACBrNFeDANFeRL := TACBrNFeDANFeRL.Create(ACBrNFe);
        ACBrNFe.DANFE  := ACBrNFeDANFeRL;
        ACBrNFe.DANFE.TipoDANFE := vConfiguracoesNotaFiscal.objeto.DANFETipoDANFE;
        MostraPreview := true;
      end;

      ACBrNFe.DANFE.Logo    := vConfiguracoesNotaFiscal.objeto.DANFEPathLogo(lQry.FieldByName('pmoNFe').AsInteger);
      ACBrNFe.DANFE.PathPDF := vConfiguracoesNotaFiscal.objeto.DANFEPathPDF(FPathPDF);
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
        CriaException('Erro: '+ E.Message);
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
    '    n.obs_nf infCpl,        '+#13+
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
      infCpl     := retornaIBPT(pidNF) + lQry.FieldByName('infCpl').AsString;
      infAdFisco :=  lQry.FieldByName('infAdFisco').AsString;
    end;

    except
    on E:Exception do
        CriaException('Erro: '+ E.Message);
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
    ' select                                                                             '+SLineBreak+
    '    n.item_nf nItem,                                                                '+SLineBreak+
    '    n.codigo_pro cProd,                                                             '+SLineBreak+
    '    p.barras_pro cEAN,                                                              '+SLineBreak+
    '    p.nome_pro xProd,                                                               '+SLineBreak+
    '    p.codigo_fornecedor NCM,                                                        '+SLineBreak+
    '    '''' EXTIPI,                                                                    '+SLineBreak+
    '    n.cfop CFOP,                                                                    '+SLineBreak+
    '    substring(p.unidade_pro from 1 for 3) uCom,                                     '+SLineBreak+
    '    n.quantidade_nf qCom,                                                           '+SLineBreak+
    '    n.valorunitario_nf vUnCom,                                                      '+SLineBreak+
    '    n.v_prod2 vProd,                                                                '+SLineBreak+
    '    n.cbenef cBenef,                                                                '+SLineBreak+
    '    p.barras_pro cEANTrib,                                                          '+SLineBreak+
    '    substring(p.unidade_pro from 1 for 3) uTrib,                                    '+SLineBreak+
    '    n.quantidade_nf qTrib,                                                          '+SLineBreak+
    '    n.valorunitario_nf vUnTrib,                                                     '+SLineBreak+
    '    n.voutros vOutro,                                                               '+SLineBreak+
    '    n.frete vFrete,                                                                 '+SLineBreak+
    '    n.vseg vSeg,                                                                    '+SLineBreak+
    '    n.vdesc vDesc,                                                                  '+SLineBreak+
    '    p.cest CEST,                                                                    '+SLineBreak+
    '    p.barras_pro cBarra,                                                            '+SLineBreak+
    '    p.barras_pro cBarraTrib,                                                        '+SLineBreak+
    '    p.obs_nf infAdProd,                                                             '+SLineBreak+
    '    n.vtottrib vTotTrib,                                                            '+SLineBreak+
    '    p.TIPO$_PRO orig,                                                               '+SLineBreak+
    '    n.cst_n12 CST,                                                                  '+SLineBreak+
    '    '''' modBC,                                                                     '+SLineBreak+
    '    n.csosn CSOSN,                                                                  '+SLineBreak+
    '    n.pcredsn pCredSN,                                                              '+SLineBreak+
    '    n.vcredicmssn vCredICMSSN,                                                      '+SLineBreak+
    '    n.vbc_n15 vBC,                                                                  '+SLineBreak+
    '    n.icms_nf pICMS,                                                                '+SLineBreak+
    '    n.vicms_n17 vICMS,                                                              '+SLineBreak+
    '    n.modbcst_n18 modBCST,                                                          '+SLineBreak+
    '    n.pmvast_n19 pMVAST,                                                            '+SLineBreak+
    '    n.predbcst_n20 pRedBCST,                                                        '+SLineBreak+
    '    n.vbcst_n21 vBCST,                                                              '+SLineBreak+
    '    n.picmsst_n22 pICMSST,                                                          '+SLineBreak+
    '    n.vicmsst_n23 vICMSST,                                                          '+SLineBreak+
    '    n.predbcst_n20 pRedBC,                                                          '+SLineBreak+
    '    n.vbcfcpst vBCFCPST,                                                            '+SLineBreak+
    '    n.pfcpst pFCPST,                                                                '+SLineBreak+
    '    n.vfcpst vFCPST,                                                                '+SLineBreak+
    '    n.vbcstret vBCSTRet,                                                            '+SLineBreak+
    '    n.picmsstret pST,                                                               '+SLineBreak+
    '    n.vicmssubistitutoret vICMSSubstituto,                                          '+SLineBreak+
    '    n.vicmsstret vICMSSTRet,                                                        '+SLineBreak+
    '    n.vbcfcpstret vBCFCPSTRet,                                                      '+SLineBreak+
    '    n.pfcpstret pFCPSTRet,                                                          '+SLineBreak+
    '    n.vfcpstret vFCPSTRet,                                                          '+SLineBreak+
    '    n.predbcefet pRedBCEfet,                                                        '+SLineBreak+
    '    n.vbcefet vBCEfet,                                                              '+SLineBreak+
    '    n.picmsefet pICMSEfet,                                                          '+SLineBreak+
    '    n.vicmsefet vICMSEfet,                                                          '+SLineBreak+
    '    n.vBCUFDest,                                                                    '+SLineBreak+
    '    n.vBCFCPUFDest,                                                                 '+SLineBreak+
    '    n.pFCPUFDest,                                                                   '+SLineBreak+
    '    n.pICMSUFDest,                                                                  '+SLineBreak+
    '    n.pICMSInter,                                                                   '+SLineBreak+
    '    n.pICMSInterPart,                                                               '+SLineBreak+
    '    n.vFCPUFDest,                                                                   '+SLineBreak+
    '    n.vICMSUFDest,                                                                  '+SLineBreak+
    '    n.vICMSUFRemet,                                                                 '+SLineBreak+
    '    coalesce(n.cenq,''999'') cEnq,                                                  '+SLineBreak+
    '    n.cst_ipi cstipi,                                                               '+SLineBreak+
    '    n.vbc_ipi vBCipi,                                                               '+SLineBreak+
    '    n.ipi_nf pIPI,                                                                  '+SLineBreak+
    '    n.valor_ipi vIPI,                                                               '+SLineBreak+
    '    '''' CNPJProd,                                                                  '+SLineBreak+
    '    '''' cSelo,                                                                     '+SLineBreak+
    '    0  qSelo,                                                                       '+SLineBreak+
    '    n.VBC_P02 vBCII,                                                                '+SLineBreak+
    '    n.VDESPADU_P03 vDespAdu,                                                        '+SLineBreak+
    '    n.VII_P04 vII,                                                                  '+SLineBreak+
    '    n.VIOF_P05 vIOF,                                                                '+SLineBreak+
    '    n.cst_q06 CSTPIS,                                                               '+SLineBreak+
    '    n.VBC_Q07 vBCPIS,                                                               '+SLineBreak+
    '    n.PPIS_Q08 pPIS,                                                                '+SLineBreak+
    '    n.VPIS_Q09 vPIS,                                                                '+SLineBreak+
    '    n.QBCPROD_Q10 qBCProd,                                                          '+SLineBreak+
    '    n.VALIQPROD_Q11 vAliqProd,                                                      '+SLineBreak+
    '    n.cst_s06 CSTCOFINS,                                                            '+SLineBreak+
    '    n.VBC_S07 vBCCOFINS,                                                            '+SLineBreak+
    '    n.PCOFINS_S08 pCOFINS,                                                          '+SLineBreak+
    '    n.VCOFINS_S11 vCOFINS,                                                          '+SLineBreak+
    '    n.QBCPROD_S09 qBCProdCOFINS,                                                    '+SLineBreak+
    '    n.VALIQPROD_S10 vAliqProdCOFINS,                                                '+SLineBreak+
    '    CPRODANVISA     cProdANVISA ,                                                   '+SLineBreak+
    '    XMOTIVOISENCAO  xMotivoIsencao,                                                 '+SLineBreak+
    '    VPMC            vPMC,                                                           '+SLineBreak+
    '    l.LOTE       nLote,                                                             '+SLineBreak+
    '    l.QUANTIDADE qLote,                                                             '+SLineBreak+
    '    l.FABRICACAO dFab,                                                              '+SLineBreak+
    '    l.VENCIMENTO dVal,                                                              '+SLineBreak+
    '    n.OBS_ITEM                                                                      '+SLineBreak+
    ' from                                                                               '+SLineBreak+
    '     nfitens n                                                                      '+SLineBreak+
    '                                                                                    '+SLineBreak+
    ' left join produto p on p.codigo_pro = n.codigo_pro                                 '+SLineBreak+
    ' left join lote_new l on l.produto_id = n.codigo_pro and l.documento = n.numero_nf  '+SLineBreak+
    '                                                                                    '+SLineBreak+
    ' where                                                                              '+SLineBreak+
    '      n.numero_nf = '+QuotedStr(pidNF);

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do begin
      Produto := NotaF.NFe.Det.New;

      with Produto.Prod do
      begin
        nItem             := lQry.FieldByName('nItem').AsInteger;
        cProd             := lQry.FieldByName('cProd').AsString;

        if ValidaGTIN(lQry.FieldByName('cEAN').AsString) then
          cEAN            := lQry.FieldByName('cEAN').AsString
        else
          cEAN            := 'SEM GTIN';

        xProd             := lQry.FieldByName('xProd').AsString;
        NCM               := lQry.FieldByName('NCM').AsString;
        EXTIPI            := lQry.FieldByName('EXTIPI').AsString;
        CFOP              := lQry.FieldByName('CFOP').AsString;
        uCom              := lQry.FieldByName('uCom').AsString;
        qCom              := lQry.FieldByName('qCom').AsFloat;
        vUnCom            := lQry.FieldByName('vUnCom').AsFloat;
        vProd             := lQry.FieldByName('vProd').AsFloat;
        cBenef            := lQry.FieldByName('cBenef').AsString;

        if ValidaGTIN(lQry.FieldByName('cEANTrib').AsString) then
          cEANTrib        := lQry.FieldByName('cEANTrib').AsString
        else
          cEANTrib        := 'SEM GTIN';

        uTrib             := lQry.FieldByName('uTrib').AsString;
        qTrib             := lQry.FieldByName('qTrib').AsCurrency;
        vUnTrib           := lQry.FieldByName('vUnTrib').AsFloat;
        vOutro            := lQry.FieldByName('vOutro').AsFloat;
        vFrete            := lQry.FieldByName('vFrete').AsFloat;
        vSeg              := lQry.FieldByName('vSeg').AsFloat;
        vDesc             := lQry.FieldByName('vDesc').AsFloat;

        if Length(lQry.FieldByName('CEST').AsString) = 7 then
          CEST            := lQry.FieldByName('CEST').AsString;

        cBarra            := lQry.FieldByName('cBarra').AsString;
        cBarraTrib        := lQry.FieldByName('cBarraTrib').AsString;
        Produto.infAdProd := lQry.FieldByName('infAdProd').AsString;

        if lQry.FieldByName('OBS_ITEM').AsString <> '' then
          Produto.infAdProd := Produto.infAdProd + ' ' +lQry.FieldByName('OBS_ITEM').AsString;
      end;


      with Produto.Imposto do
      begin
        vTotTrib := lQry.FieldByName('vTotTrib').AsFloat;
        with ICMS do
        begin
          orig :=  vConfiguracoesNotaFiscal.objeto.orig(lQry.FieldByName('orig').AsString);
          if NotaF.NFe.Emit.CRT in [crtSimplesExcessoReceita, crtRegimeNormal] then
          begin
            CST     := vConfiguracoesNotaFiscal.objeto.CST(lQry.FieldByName('CST').AsString);
          end else
          begin
            CSOSN       := vConfiguracoesNotaFiscal.objeto.CSOSN(lQry.FieldByName('CSOSN').AsString);
            pCredSN     := lQry.FieldByName('pCredSN').Value;
            vCredICMSSN := lQry.FieldByName('vCredICMSSN').Value;
          end;
          modBC           := vConfiguracoesNotaFiscal.objeto.modBC(lQry.FieldByName('modBC').AsString);
          vBC             := lQry.FieldByName('vBC').AsFloat;
          pICMS           := lQry.FieldByName('pICMS').AsFloat;
          vICMS           := lQry.FieldByName('vICMS').AsFloat;
          modBCST         := vConfiguracoesNotaFiscal.objeto.modBCST(lQry.FieldByName('modBCST').AsString);
          pMVAST          := lQry.FieldByName('pMVAST').AsFloat;
          pRedBCST        := lQry.FieldByName('pRedBCST').AsFloat;
          vBCST           := lQry.FieldByName('vBCST').AsFloat;
          pICMSST         := lQry.FieldByName('pICMSST').AsFloat;
          vICMSST         := lQry.FieldByName('vICMSST').AsFloat;
          pRedBC          := lQry.FieldByName('pRedBC').AsFloat;
          vBCFCPST        := lQry.FieldByName('vBCFCPST').AsFloat;
          pFCPST          := lQry.FieldByName('pFCPST').AsFloat;
          vFCPST          := lQry.FieldByName('vFCPST').AsFloat;
          vBCSTRet        := lQry.FieldByName('vBCSTRet').AsFloat;
          pST             := lQry.FieldByName('pST').AsFloat;
          vICMSSubstituto := lQry.FieldByName('vICMSSubstituto').AsFloat;
          vICMSSTRet      := lQry.FieldByName('vICMSSTRet').AsFloat;
          vBCFCPSTRet     := lQry.FieldByName('vBCFCPSTRet').AsFloat;
          pFCPSTRet       := lQry.FieldByName('pFCPSTRet').AsFloat;
          vFCPSTRet       := lQry.FieldByName('vFCPSTRet').AsFloat;
          pRedBCEfet      := lQry.FieldByName('pRedBCEfet').AsFloat;
          vBCEfet         := lQry.FieldByName('vBCEfet').AsFloat;
          pICMSEfet       := lQry.FieldByName('pICMSEfet').AsFloat;
          vICMSEfet       := lQry.FieldByName('vICMSEfet').AsFloat;
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
          CST      := vConfiguracoesNotaFiscal.objeto.cstipi(lQry.FieldByName('cstipi').AsString);
          CNPJProd := lQry.FieldByName('CNPJProd').AsString;
          cSelo    := lQry.FieldByName('cSelo').AsString;
          qSelo    := lQry.FieldByName('qSelo').AsInteger;
          cEnq     := lQry.FieldByName('cEnq').AsString;
          vBC      := lQry.FieldByName('vBCipi').AsFloat;
          vUnid    := lQry.FieldByName('vBCUFDest').AsFloat;
          pIPI     := lQry.FieldByName('pIPI').AsFloat;
          vIPI     := lQry.FieldByName('vIPI').AsFloat;
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
          CST       :=  vConfiguracoesNotaFiscal.objeto.cstpis(lQry.FieldByName('CSTPIS').AsString);
          vBC       :=  lQry.FieldByName('vBCPIS').AsFloat;
          pPIS      :=  lQry.FieldByName('pPIS').AsFloat;
          vPIS      :=  lQry.FieldByName('vPIS').AsFloat;
          qBCProd   :=  lQry.FieldByName('qBCProd').AsFloat;
          vAliqProd :=  lQry.FieldByName('vAliqProd').AsFloat;
        end;

        with COFINS do
        begin
          CST       := vConfiguracoesNotaFiscal.objeto.cstcof(lQry.FieldByName('CSTCOFINS').AsString); ;
          vBC       := lQry.FieldByName('vBCCOFINS').AsFloat;
          pCOFINS   := lQry.FieldByName('pCOFINS').AsFloat;
          vCOFINS   := lQry.FieldByName('vCOFINS').AsFloat;
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
        Medicamento                := Produto.Prod.med.Add;
        Medicamento.cProdANVISA    := lQry.FieldByName('cProdANVISA').AsString;
        Medicamento.vPMC           := lQry.FieldByName('vPMC').AsFloat;
        Medicamento.xMotivoIsencao := lQry.FieldByName('xMotivoIsencao').AsString;
      end;

      lQry.Next;
    end;
    except
    on E:Exception do
        CriaException('Erro: '+ E.Message);
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

function TNotaFiscal.retornaIBPT(pNF : String): String;
var
  lNFModel        : ITNFModel;
  lTribFederal,
  lTribEstadual,
  lTribMunicipal  : extended;
  lMsg            : String;
  lConfiguracoes  : ITerasoftConfiguracoes;
  lIBPTModel      : ITIBPTModel;
begin
  lConfiguracoes := TerasoftConfiguracoes.getNewIface(vIConexao);
  lNFModel       := TNFModel.getNewIface(vIConexao);
  lIBPTModel     := TIBPTModel.getNewIface(vIConexao);

  try
    lNFModel := lNFModel.objeto.carregaClasse(pNF);

    if lNFModel.objeto.VTOTTRIB > 0 then
    begin
      lTribFederal   := lNFModel.objeto.VTOTTRIB_FEDERAL * 100 / lNFModel.objeto.VALOR_NF;
      lTribEstadual  := lNFModel.objeto.VTOTTRIB_ESTADUAL * 100 / lNFModel.objeto.VALOR_NF;
      lTribMunicipal := lNFModel.objeto.VTOTTRIB_MUNICIPAL * 100 / lNFModel.objeto.VALOR_NF;

      lMsg := lMsg + 'Trib. aprox.: ';

      if (lNFModel.objeto.VTOTTRIB_FEDERAL > 0.0) then
        lMsg := lMsg + FormataDinheiro(lNFModel.objeto.VTOTTRIB_FEDERAL) + ' (' + FormatFloat('0.00', lTribFederal) + '%) Federal';

      if (lNFModel.objeto.VTOTTRIB_ESTADUAL > 0.0) then
        lMsg := lMsg + ' / ' + formataDinheiro(lNFModel.objeto.VTOTTRIB_ESTADUAL) + ' (' + FormatFloat('0.00', lTribEstadual) + '%) Estadual';

      if (lNFModel.objeto.VTOTTRIB_MUNICIPAL > 0.0) then
        lMsg := lMsg + ' / ' + formataDinheiro(lNFModel.objeto.VTOTTRIB_MUNICIPAL) + ' (' + FormatFloat('0.00', lTribMunicipal) + '%) Municipal';

      if (lConfiguracoes.objeto.valorTag('PERCENTUAL_IBPT_FEDERAL', '0', tvNumero) = 0) and (lConfiguracoes.objeto.valorTag('PERCENTUAL_IBPT_ESTADUAL', '0', tvNumero) = 0) then
        lMsg := lMsg + ' - Fonte: ' + lIBPTModel.objeto.fonteIBPT + ' ' + lIBPTModel.objeto.chaveIBPT + ' ';

      lMSg := lMsg + sLineBreak;
    end;

    Result := lMsg;

  finally
    lConfiguracoes := nil;
    lIBPTModel := nil;
    lNFModel := nil;
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

procedure TNotaFiscal.SetImpressoraNFC(const Value: String);
begin
  FImpressoraNFC := Value;
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
        CriaException('Erro: '+ E.Message);
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
        modFrete := vConfiguracoesNotaFiscal.objeto.modFrete(lQry.FieldByName('modFrete').Value);
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
        CriaException('Erro: '+ E.Message);
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

constructor TNotaFiscal._Create(pIConexao: IConexao);
begin
  vIConexao := pIConexao;
  ACBrNFe   := TACBrNFe.Create(nil);
  vConfiguracoesNotaFiscal := TConfiguracoesNotaFiscal.getNewIface(vIConexao);
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
  FreeAndNil(ACBrNFe);
  inherited;
end;

procedure TNotaFiscal.processar(idNotaFiscal: String);
begin
  ACBrNFe.NotasFiscais.Clear;

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

function TNotaFiscal.transmitir(idNotaFiscal: String): IListaTextoEX;
var
  lRetorno          : IListaTextoEX;
  lQry              : TFDQuery;
  loteEnvio         : Integer;
  lchavenfe         : String;
  lprotocolo        : String;
  lrecibo           : String;
  lxMotivo          : String;
  lCSTAT            : String;
  lNFContol         : ITNFContol;
  lPedidoVendaModel : ITPedidoVendaModel;
begin

  lNFContol         := TNFContol.getNewIface(idNotaFiscal, vIConexao);
  loteEnvio         := idNotaFiscal.ToInteger;
  lPedidoVendaModel := TPedidoVendaModel.getNewIface(vIConexao);
  lRetorno := novaListaTexto;
  try
    try
      if consultarNota(idNotaFiscal) then
      begin
        lRetorno.strings.Add(ACBrNFe.WebServices.Consulta.cStat.ToString);
        lRetorno.strings.Add(ACBrNFe.WebServices.Consulta.XMotivo);
        lRetorno.strings.Add('');
        lRetorno.strings.Add(ACBrNFe.WebServices.Consulta.Protocolo);
        Result := lRetorno;

        exit;
      end;

      processar(idNotaFiscal);
      ACBrNFe.NotasFiscais.GerarNFe;
      ACBrNFe.NotasFiscais.Assinar;

      if (ACBrNFe.NotasFiscais.Items[0].NFe.Ide.modelo = 55) or (vTransmitir = 'L') then
      begin
        try
          ACBrNFe.Enviar(loteEnvio, false, true);
        finally
          lchavenfe  := ACBrNFe.NotasFiscais[0].NFe.procNFe.chNFe;
          lprotocolo := ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.nProt;
          lrecibo    := ACBrNFe.WebServices.Enviar.Recibo;
          lxMotivo   := ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.xMotivo;
          lCSTAT     := IntToStr(ACBrNFe.NotasFiscais.Items[0].NFe.procNFe.cStat);
        end;
      end;

      if (lCSTAT <> '100') and (vTransmitir = 'L') then
        lxMotivo := 'NOTA NAO AUTORIZADA: ' + lxMotivo;

      lNFContol.objeto.NFModel.objeto.Acao               := Terasoft.Types.tacAlterar;
      lNFContol.objeto.NFModel.objeto.STATUS_TRANSMISSAO := IIF((vTransmitir = 'F') and (ACBrNFe.NotasFiscais.Items[0].NFe.Ide.modelo = 65), '7', '8');
      lNFContol.objeto.NFModel.objeto.NOME_XML           := IIF((vTransmitir = 'F') and (ACBrNFe.NotasFiscais.Items[0].NFe.Ide.modelo = 65), 'Emitido em Off-Line', copy(lxMotivo, 1, 500));
      lNFContol.objeto.NFModel.objeto.ID_NF3             := lchavenfe;
      lNFContol.objeto.NFModel.objeto.PROTOCOLO_NFE      := lprotocolo;
      lNFContol.objeto.NFModel.objeto.RECIBO_NFE         := lrecibo;
      lNFContol.objeto.NFModel.objeto.XML_NFE            := ACBrNFe.NotasFiscais.Items[0].GerarXML;
      lNFContol.objeto.NFModel.objeto.NUMERO_NF          := idNotaFiscal;
      lNFContol.objeto.Salvar;

      if lNFContol.objeto.NFModel.objeto.NUMERO_PED <> '' then
      begin
        lPedidoVendaModel := lPedidoVendaModel.objeto.carregaClasse(lNFContol.objeto.NFModel.objeto.NUMERO_PED);
        lPedidoVendaModel.objeto.faturado(lNFContol.objeto.NFModel.objeto.NUMERO_ECF);
      end;

      lRetorno.strings.Add(lCSTAT);
      lRetorno.strings.Add(lxMotivo);
      lRetorno.strings.Add(lrecibo);
      lRetorno.strings.Add(lprotocolo);
      Result := lRetorno;

    except on E: Exception do
      begin
        lNFContol.objeto.NFModel.objeto.Acao          := Terasoft.Types.tacAlterar;
        lNFContol.objeto.NFModel.objeto.NOME_XML      := copy('NOTA NAO AUTORIZADA: '+e.Message, 1, 500);
        lNFContol.objeto.NFModel.objeto.XML_NFE       := ACBrNFe.NotasFiscais.Items[0].GerarXML;
        lNFContol.objeto.NFModel.objeto.NUMERO_NF     := idNotaFiscal;
        lNFContol.objeto.Salvar;

        lRetorno.strings.Add(lCSTAT);
        lRetorno.strings.Add(e.Message);
        lRetorno.strings.Add(lrecibo);
        lRetorno.strings.Add(lprotocolo);

        Result := lRetorno;
      end;
    end;

   finally
     FreeAndNil(lQry);
     lNFContol := nil;
     lPedidoVendaModel:=nil;
   end;
end;

end.
