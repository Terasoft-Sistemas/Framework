unit Terasoft.NotaFiscal.Eventos;

interface

uses
  blcksock,
  Terasoft.Framework.Texto,
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
  Interfaces.Conexao,
  Terasoft.Configuracoes,
  EventosNFeControl,
  Terasoft.Types,
  NFControl,
  Terasoft.Framework.ObjectIface,
  NFModel;

type
  TEventosNotaFiscal = class;
  ITEventosNotaFiscal=IObject<TEventosNotaFiscal>;

  TEventosNotaFiscal=class
  private
    [unsafe] mySelf: ITEventosNotaFiscal;
    vIConexao: IConexao;
    ACBrNFe: TACBrNFe;
    Eventos: ITEventosNotaFiscal;
    vConfiguracoesNotaFiscal: ITConfiguracoesNotaFiscal;

    function configuraComponenteNFe: Boolean;
    function enviarEvento(idNotaFiscal, justificativa: String; ptpEvento: TpcnTpEvento): IListaTextoEx;

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEventosNotaFiscal;

    function cancelar(idNotaFiscal, justificativa: String): IListaTextoEx;
    function inutilizar(idNotaFiscal, justificativa: String): IListaTextoEx;
    function enviarCartaCorrecao(idNotaFiscal: String): IListaTextoEx;
    function consultarPelaChave(pChave: String): IListaTextoEx;

  end;

implementation

{ TEventosNotaFiscal }

function TEventosNotaFiscal.configuraComponenteNFe: Boolean;
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
    Salvar           := True;
    ExibirErroSchema := true;
    RetirarAcentos   := True;
    FormaEmissao     := vConfiguracoesNotaFiscal.objeto.tipoEmissao;
    VersaoDF         := vConfiguracoesNotaFiscal.objeto.versaoDF;
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

function TEventosNotaFiscal.consultarPelaChave(pChave: String): IListaTextoEx;
var
  lRetorno: IListaTextoEX;
begin
  lRetorno  := novaListaTexto;

  ACBrNFe.NotasFiscais.Clear;
  ACBrNFe.WebServices.Consulta.NFeChave := pChave;
  ACBrNFe.WebServices.Consulta.Executar;

  lRetorno.strings.Add(ACBrNFe.WebServices.Consulta.cStat.ToString);
  lRetorno.strings.Add(ACBrNFe.WebServices.Consulta.XMotivo);
  lRetorno.strings.Add(ACBrNFe.WebServices.Consulta.Protocolo);
  lRetorno.strings.Add(DateToStr(ACBrNFe.WebServices.Consulta.DhRecbto));
  lRetorno.strings.Add('CANCEL.: '+ACBrNFe.WebServices.Consulta.retCancNFe.xMotivo);

  Result := lRetorno;
end;

function TEventosNotaFiscal.cancelar(idNotaFiscal, justificativa: String): IListaTextoEx;
begin
  Result := enviarEvento(idNotaFiscal, justificativa, teCancelamento);
end;

constructor TEventosNotaFiscal._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConfiguracoesNotaFiscal := TConfiguracoesNotaFiscal.getNewIface(vIConexao);
  ACBrNFe := TACBrNFe.Create(nil);
  configuraComponenteNFe;
end;

destructor TEventosNotaFiscal.Destroy;
begin
  FreeAndNil(ACBrNFe);
  inherited;
end;

class function TEventosNotaFiscal.getNewIface(pIConexao: IConexao): ITEventosNotaFiscal;
begin
  Result := TImplObjetoOwner<TEventosNotaFiscal>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TEventosNotaFiscal.enviarCartaCorrecao(idNotaFiscal: String): IListaTextoEX;
begin

end;

function TEventosNotaFiscal.enviarEvento(idNotaFiscal, justificativa: String; ptpEvento: TpcnTpEvento): IListaTextoEX;
var
  idLote: Integer;
  lRetorno: IListaTextoEX;
  lprotocolo : String;
  lcStat : Integer;
  lEventosNFeControl: ITEventosNFeControl;
  lDescricaoEvendto: String;
  lTPEVENTO: String;
  lNFContol: ITNFContol;
begin
    lEventosNFeControl := TEventosNFeControl.getNewIface(vIConexao);
    lNFContol := TNFContol.getNewIface(idNotaFiscal, vIConexao);
    lRetorno  := novaListaTexto;

    try

      ACBrNFe.NotasFiscais.Clear;

      ACBrNFe.NotasFiscais.LoadFromString(lNFContol.objeto.NFModel.objeto.XML_NFE);

      idLote := 1;

      ACBrNFe.EventoNFe.Evento.Clear;
      ACBrNFe.EventoNFe.idLote := idLote;

      with ACBrNFe.EventoNFe.Evento.New do
      begin
        infEvento.dhEvento := Now;
        infEvento.tpEvento := ptpEvento;

        if ptpEvento = teCancelamento then
        begin
          infEvento.detEvento.xJust := justificativa;
          lDescricaoEvendto := 'Cancelamento';
          lTPEVENTO := '110111';
        end else
        if ptpEvento = teCCe then
        begin
          infEvento.detEvento.xCorrecao := justificativa;
          lDescricaoEvendto := 'Carta de Correcao';
          lTPEVENTO := '110110';
        end;
      end;

      ACBrNFe.EnviarEvento(idLote);

      lcStat     := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat;
      lprotocolo := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt;

      if lcStat = 135 then
      begin
        lEventosNFeControl.objeto.EventosNFeModel.objeto.Acao              := Terasoft.Types.tacIncluir;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.ID_NFE            := idNotaFiscal;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.DATAHORA          := Now;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.EVENTO            := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.tpEvento;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.ID_EVENTO         := lTPEVENTO;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.CHNFE             := lNFContol.objeto.NFModel.objeto.ID_NF3;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.TPEVENTO          := lTPEVENTO;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.NSEQEVENTO        := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nSeqEvento;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.VEREVENTO         := '1.00';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.DESCEVENTO        := lDescricaoEvendto;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.XML               := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XML;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.STATUS            := '0';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.PROTOCOLO_RETORNO := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.RETORNO_SEFAZ     := 'Evento registrado e vinculado a NF-e';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.JUSTIFICATIVA     := ACBrNFe.EventoNFe.Evento.Items[0].infEvento.detEvento.xJust;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.XCORRECAO         := ACBrNFe.EventoNFe.Evento.Items[0].infEvento.detEvento.xCorrecao;
        lEventosNFeControl.objeto.Salvar;

        if ptpEvento = teCancelamento then
        begin
          lNFContol.objeto.NFModel.objeto.Acao              := Terasoft.Types.tacAlterar;
          lNFContol.objeto.NFModel.objeto.DATA_CANCELAMENTO := Now;
          lNFContol.objeto.NFModel.objeto.STATUS_NF         := 'X';
          lNFContol.objeto.NFModel.objeto.NOME_XML          := 'Cancelamento de NF-e homologado';
          lNFContol.objeto.NFModel.objeto.NUMERO_NF         := idNotaFiscal;
          lNFContol.objeto.Salvar;
        end;

        lRetorno.strings.Add('Cancelamento de NF-e homologado');
      end else
        lRetorno.strings.Add(ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo);

      lRetorno.strings.Add(IntToStr(lcStat));
      lRetorno.strings.Add(lprotocolo);

      Result := lRetorno;
    finally
      lEventosNFeControl:=nil;
      lNFContol := nil;
    end;
end;

function TEventosNotaFiscal.inutilizar(idNotaFiscal, justificativa: String): IListaTextoEX;
var
  lEventosNFeControl: ITEventosNFeControl;
  lAno: String;
  lRetorno: IListaTextoEX;
  lNFContol: ITNFContol;
begin
    lEventosNFeControl := TEventosNFeControl.getNewIface(vIConexao);
    lNFContol := TNFContol.getNewIface(idNotaFiscal, vIConexao);
    lRetorno  := novaListaTexto;
    try

      ACBrNFe.NotasFiscais.Clear;
      ACBrNFe.NotasFiscais.LoadFromString(lNFContol.objeto.NFModel.objeto.XML_NFE);

      lAno := FormatDateTime('yyyy', Date);

      ACBrNFe.WebServices.Inutiliza(vIConexao.getEmpresa.EMPRESA_CNPJ, Justificativa, StrToInt(lAno), lNFContol.objeto.NFModel.objeto.MODELO, lNFContol.objeto.NFModel.objeto.SERIE_NF, StrToInt(idNotaFiscal), StrToInt(idNotaFiscal));

      if ACBrNFe.WebServices.Inutilizacao.cStat = 102 then
      begin

        lEventosNFeControl.objeto.EventosNFeModel.objeto.Acao              := Terasoft.Types.tacIncluir;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.ID_NFE            := idNotaFiscal;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.DATAHORA          := Now;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.EVENTO            := 2;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.ID_EVENTO         := '110111';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.CHNFE             := lNFContol.objeto.NFModel.objeto.ID_NF3;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.TPEVENTO          := '110111';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.NSEQEVENTO        := '';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.VEREVENTO         := '1.00';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.DESCEVENTO        := 'Inutilização';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.XML               := ACBrNFe.WebServices.Inutilizacao.RetornoWS;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.STATUS            := '0';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.PROTOCOLO_RETORNO := ACBrNFe.WebServices.Inutilizacao.Protocolo;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.RETORNO_SEFAZ     := 'Evento registrado e vinculado a NF-e';
        lEventosNFeControl.objeto.EventosNFeModel.objeto.JUSTIFICATIVA     := Justificativa;
        lEventosNFeControl.objeto.EventosNFeModel.objeto.XCORRECAO         := '';
        lEventosNFeControl.objeto.Salvar;

        lNFContol.objeto.NFModel.objeto.Acao              := Terasoft.Types.tacAlterar;
        lNFContol.objeto.NFModel.objeto.DATA_CANCELAMENTO := Now;
        lNFContol.objeto.NFModel.objeto.STATUS_NF         := 'X';
        lNFContol.objeto.NFModel.objeto.NOME_XML          := 'Inutilização de Número homologado';
        lNFContol.objeto.NFModel.objeto.NUMERO_NF         := idNotaFiscal;
        lNFContol.objeto.Salvar;

        lRetorno.strings.Add('Inutilização de Número homologado');
      end
      else
        lRetorno.strings.Add(ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo);

      lRetorno.strings.Add(IntToStr(ACBrNFe.WebServices.Inutilizacao.cStat));
      lRetorno.strings.Add(ACBrNFe.WebServices.Inutilizacao.Protocolo);

      Result := lRetorno;

    finally
      lEventosNFeControl:=nil;
      lNFContol:=nil;
    end;

end;

end.
