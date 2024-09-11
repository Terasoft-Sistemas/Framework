unit Terasoft.NotaFiscal.Eventos;

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
  Interfaces.Conexao,
  Terasoft.Configuracoes,
  EventosNFeControl,
  Terasoft.Types,
  NFControl,
  NFModel;

type
  TEventosNotaFiscal = class

  private
    vIConexao: IConexao;
    ACBrNFe: TACBrNFe;
    Eventos: TEventosNotaFiscal;
    vConfiguracoesNotaFiscal: TConfiguracoesNotaFiscal;

    function configuraComponenteNFe: Boolean;
    function enviarEvento(idNotaFiscal, justificativa: String; ptpEvento: TpcnTpEvento): TStringList;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function cancelar(idNotaFiscal, justificativa: String): TStringList;
    function inutilizar(idNotaFiscal, justificativa: String): TStringList;
    function enviarCartaCorrecao(idNotaFiscal: String): TStringList;
    function consultarPelaChave(pChave: String): TStringList;

  end;

implementation

{ TEventosNotaFiscal }

function TEventosNotaFiscal.configuraComponenteNFe: Boolean;
begin
  ACBrNFe.NotasFiscais.Clear;


  if(Length(vConfiguracoesNotaFiscal.certificadoArquivoPFX)>256) or not FileExists(vConfiguracoesNotaFiscal.certificadoArquivoPFX) then
    ACBrNFe.Configuracoes.Certificados.DadosPFX  := vConfiguracoesNotaFiscal.certificadoArquivoPFX
  else
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
    Salvar           := True;
    ExibirErroSchema := true;
    RetirarAcentos   := True;
    FormaEmissao     := vConfiguracoesNotaFiscal.tipoEmissao;
    VersaoDF         := vConfiguracoesNotaFiscal.versaoDF;
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

function TEventosNotaFiscal.consultarPelaChave(pChave: String): TStringList;
var
  lRetorno: TStringList;
begin
  lRetorno  := TStringList.Create;

  ACBrNFe.NotasFiscais.Clear;
  ACBrNFe.WebServices.Consulta.NFeChave := pChave;
  ACBrNFe.WebServices.Consulta.Executar;

  lRetorno.Add(ACBrNFe.WebServices.Consulta.cStat.ToString);
  lRetorno.Add(ACBrNFe.WebServices.Consulta.XMotivo);
  lRetorno.Add(ACBrNFe.WebServices.Consulta.Protocolo);
  lRetorno.Add(DateToStr(ACBrNFe.WebServices.Consulta.DhRecbto));
  lRetorno.Add('CANCEL.: '+ACBrNFe.WebServices.Consulta.retCancNFe.xMotivo);

  Result := lRetorno;
end;

function TEventosNotaFiscal.cancelar(idNotaFiscal, justificativa: String): TStringList;
begin
  Result := enviarEvento(idNotaFiscal, justificativa, teCancelamento);
end;

constructor TEventosNotaFiscal.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConfiguracoesNotaFiscal := TConfiguracoesNotaFiscal.Create(vIConexao);
  ACBrNFe := TACBrNFe.Create(nil);
  configuraComponenteNFe;
end;

destructor TEventosNotaFiscal.Destroy;
begin

  inherited;
end;

function TEventosNotaFiscal.enviarCartaCorrecao(idNotaFiscal: String): TStringList;
begin

end;

function TEventosNotaFiscal.enviarEvento(idNotaFiscal, justificativa: String; ptpEvento: TpcnTpEvento): TStringList;
var
  idLote: Integer;
  lRetorno: TStringList;
  lprotocolo : String;
  lcStat : Integer;
  lEventosNFeControl: TEventosNFeControl;
  lDescricaoEvendto: String;
  lTPEVENTO: String;
  lNFContol: ITNFContol;
begin
    lEventosNFeControl := TEventosNFeControl.Create(vIConexao);
    lNFContol := TNFContol.getNewIface(idNotaFiscal, vIConexao);
    lRetorno  := TStringList.Create;

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
        lEventosNFeControl.EventosNFeModel.objeto.Acao              := Terasoft.Types.tacIncluir;
        lEventosNFeControl.EventosNFeModel.objeto.ID_NFE            := idNotaFiscal;
        lEventosNFeControl.EventosNFeModel.objeto.DATAHORA          := Now;
        lEventosNFeControl.EventosNFeModel.objeto.EVENTO            := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.tpEvento;
        lEventosNFeControl.EventosNFeModel.objeto.ID_EVENTO         := lTPEVENTO;
        lEventosNFeControl.EventosNFeModel.objeto.CHNFE             := lNFContol.objeto.NFModel.objeto.ID_NF3;
        lEventosNFeControl.EventosNFeModel.objeto.TPEVENTO          := lTPEVENTO;
        lEventosNFeControl.EventosNFeModel.objeto.NSEQEVENTO        := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nSeqEvento;
        lEventosNFeControl.EventosNFeModel.objeto.VEREVENTO         := '1.00';
        lEventosNFeControl.EventosNFeModel.objeto.DESCEVENTO        := lDescricaoEvendto;
        lEventosNFeControl.EventosNFeModel.objeto.XML               := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XML;
        lEventosNFeControl.EventosNFeModel.objeto.STATUS            := '0';
        lEventosNFeControl.EventosNFeModel.objeto.PROTOCOLO_RETORNO := ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt;
        lEventosNFeControl.EventosNFeModel.objeto.RETORNO_SEFAZ     := 'Evento registrado e vinculado a NF-e';
        lEventosNFeControl.EventosNFeModel.objeto.JUSTIFICATIVA     := ACBrNFe.EventoNFe.Evento.Items[0].infEvento.detEvento.xJust;
        lEventosNFeControl.EventosNFeModel.objeto.XCORRECAO         := ACBrNFe.EventoNFe.Evento.Items[0].infEvento.detEvento.xCorrecao;
        lEventosNFeControl.Salvar;

        if ptpEvento = teCancelamento then
        begin
          lNFContol.objeto.NFModel.objeto.Acao              := Terasoft.Types.tacAlterar;
          lNFContol.objeto.NFModel.objeto.DATA_CANCELAMENTO := Now;
          lNFContol.objeto.NFModel.objeto.STATUS_NF         := 'X';
          lNFContol.objeto.NFModel.objeto.NOME_XML          := 'Cancelamento de NF-e homologado';
          lNFContol.objeto.NFModel.objeto.NUMERO_NF         := idNotaFiscal;
          lNFContol.objeto.Salvar;
        end;

        lRetorno.Add('Cancelamento de NF-e homologado');
      end else
        lRetorno.Add(ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo);

      lRetorno.Add(IntToStr(lcStat));
      lRetorno.Add(lprotocolo);

      Result := lRetorno;
    finally
      lEventosNFeControl.Free;
      lNFContol := nil;
    end;
end;

function TEventosNotaFiscal.inutilizar(idNotaFiscal, justificativa: String): TStringList;
var
  lEventosNFeControl: TEventosNFeControl;
  lAno: String;
  lRetorno: TStringList;
  lNFContol: ITNFContol;
begin
    lEventosNFeControl := TEventosNFeControl.Create(vIConexao);
    lNFContol := TNFContol.getNewIface(idNotaFiscal, vIConexao);
    lRetorno  := TStringList.Create;
    try

      ACBrNFe.NotasFiscais.Clear;
      ACBrNFe.NotasFiscais.LoadFromString(lNFContol.objeto.NFModel.objeto.XML_NFE);

      lAno := FormatDateTime('yyyy', Date);

      ACBrNFe.WebServices.Inutiliza(vIConexao.getEmpresa.EMPRESA_CNPJ, Justificativa, StrToInt(lAno), lNFContol.objeto.NFModel.objeto.MODELO, lNFContol.objeto.NFModel.objeto.SERIE_NF, StrToInt(idNotaFiscal), StrToInt(idNotaFiscal));

      if ACBrNFe.WebServices.Inutilizacao.cStat = 102 then
      begin

        lEventosNFeControl.EventosNFeModel.objeto.Acao              := Terasoft.Types.tacIncluir;
        lEventosNFeControl.EventosNFeModel.objeto.ID_NFE            := idNotaFiscal;
        lEventosNFeControl.EventosNFeModel.objeto.DATAHORA          := Now;
        lEventosNFeControl.EventosNFeModel.objeto.EVENTO            := 2;
        lEventosNFeControl.EventosNFeModel.objeto.ID_EVENTO         := '110111';
        lEventosNFeControl.EventosNFeModel.objeto.CHNFE             := lNFContol.objeto.NFModel.objeto.ID_NF3;
        lEventosNFeControl.EventosNFeModel.objeto.TPEVENTO          := '110111';
        lEventosNFeControl.EventosNFeModel.objeto.NSEQEVENTO        := '';
        lEventosNFeControl.EventosNFeModel.objeto.VEREVENTO         := '1.00';
        lEventosNFeControl.EventosNFeModel.objeto.DESCEVENTO        := 'Inutilização';
        lEventosNFeControl.EventosNFeModel.objeto.XML               := ACBrNFe.WebServices.Inutilizacao.RetornoWS;
        lEventosNFeControl.EventosNFeModel.objeto.STATUS            := '0';
        lEventosNFeControl.EventosNFeModel.objeto.PROTOCOLO_RETORNO := ACBrNFe.WebServices.Inutilizacao.Protocolo;
        lEventosNFeControl.EventosNFeModel.objeto.RETORNO_SEFAZ     := 'Evento registrado e vinculado a NF-e';
        lEventosNFeControl.EventosNFeModel.objeto.JUSTIFICATIVA     := Justificativa;
        lEventosNFeControl.EventosNFeModel.objeto.XCORRECAO         := '';
        lEventosNFeControl.Salvar;

        lNFContol.objeto.NFModel.objeto.Acao              := Terasoft.Types.tacAlterar;
        lNFContol.objeto.NFModel.objeto.DATA_CANCELAMENTO := Now;
        lNFContol.objeto.NFModel.objeto.STATUS_NF         := 'X';
        lNFContol.objeto.NFModel.objeto.NOME_XML          := 'Inutilização de Número homologado';
        lNFContol.objeto.NFModel.objeto.NUMERO_NF         := idNotaFiscal;
        lNFContol.objeto.Salvar;

        lRetorno.Add('Inutilização de Número homologado');
      end
      else
        lRetorno.Add(ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo);

      lRetorno.Add(IntToStr(ACBrNFe.WebServices.Inutilizacao.cStat));
      lRetorno.Add(ACBrNFe.WebServices.Inutilizacao.Protocolo);

      Result := lRetorno;

    finally
      lEventosNFeControl.Free;
      lNFContol:=nil;
    end;

end;

end.
