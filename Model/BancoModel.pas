unit BancoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type

  TBancoModel = class;

  ITBancoModel = IObject<TBancoModel>;

  TBancoModel = class
  private
    [unsafe] mySelf: ITBancoModel;
    vIConexao : IConexao;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    Fclient_id: Variant;
    Fconvenio: Variant;
    Fclient_secret: Variant;
    Flimite_ban: Variant;
    Fcnpj: Variant;
    Ffantasia: Variant;
    Fusuario_ban: Variant;
    Fagencia_ban: Variant;
    Fnome_ban: Variant;
    Fdias_protesto_devolucao: Variant;
    Fbairro: Variant;
    Fcodigo_convenio_pagamento: Variant;
    Fbanco_referente: Variant;
    Flocal_pagamento: Variant;
    Foutras_configuracoes: Variant;
    Furl_atualizacao_boleto: Variant;
    Ftelefone_ban: Variant;
    Flayout_remessa: Variant;
    Fuf: Variant;
    Fconta_juros_antecipacao: Variant;
    Fcaminho_remessa: Variant;
    Fcodigotransmissao: Variant;
    Fconta_iof_antecipacao: Variant;
    Fscope: Variant;
    Fdeveloper_application_key: Variant;
    Fcaminho_remessa_pagamento: Variant;
    Fcep: Variant;
    Fsequencia_remessa_pagamento: Variant;
    Fid: Variant;
    Fnum_ban: Variant;
    Fpersonalizacao_boleto: Variant;
    Fdrg: Variant;
    Fdetalhamento_remessa: Variant;
    Fstatus: Variant;
    Floja: Variant;
    Flicenca: Variant;
    Ftipo_impressao: Variant;
    FLOG: Variant;
    Fsystime: Variant;
    Fcodigo_cedente2: Variant;
    Flimite_troca: Variant;
    Fvalor_boleto: Variant;
    Flayout_retorno: Variant;
    Fnumero_ban: Variant;
    Ftipo_cobranca: Variant;
    Fatualizar_boleto: Variant;
    Fdigconta_ban: Variant;
    Fmodalidade: Variant;
    Findicadorpix: Variant;
    Fcaminho_retorno: Variant;
    Fcidade: Variant;
    Fconta_aplicacao: Variant;
    Foutras_configuracoes2: Variant;
    Fdespesa_boleto_conta_id: Variant;
    Fendereco: Variant;
    Ftelefone: Variant;
    Frazao: Variant;
    Fconta_estorno_antecipacao: Variant;
    Fcodigo_protesto_devolucao: Variant;
    Fcodigo_cedente: Variant;
    Fdigagencia_ban: Variant;
    Fconta_ban: Variant;
    Fcaracteristica_titulo: Variant;
    Ftipo_emitente: Variant;
    Fcaminho_retorno_pagamento: Variant;
    Fcontato_ban: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure Setagencia_ban(const Value: Variant);
    procedure Setatualizar_boleto(const Value: Variant);
    procedure Setbairro(const Value: Variant);
    procedure Setbanco_referente(const Value: Variant);
    procedure Setcaminho_remessa(const Value: Variant);
    procedure Setcaminho_remessa_pagamento(const Value: Variant);
    procedure Setcaminho_retorno(const Value: Variant);
    procedure Setcaminho_retorno_pagamento(const Value: Variant);
    procedure Setcaracteristica_titulo(const Value: Variant);
    procedure Setcep(const Value: Variant);
    procedure Setcidade(const Value: Variant);
    procedure Setclient_id(const Value: Variant);
    procedure Setclient_secret(const Value: Variant);
    procedure Setcnpj(const Value: Variant);
    procedure Setcodigo_cedente(const Value: Variant);
    procedure Setcodigo_cedente2(const Value: Variant);
    procedure Setcodigo_convenio_pagamento(const Value: Variant);
    procedure Setcodigo_protesto_devolucao(const Value: Variant);
    procedure Setcodigotransmissao(const Value: Variant);
    procedure Setconta_aplicacao(const Value: Variant);
    procedure Setconta_ban(const Value: Variant);
    procedure Setconta_estorno_antecipacao(const Value: Variant);
    procedure Setconta_iof_antecipacao(const Value: Variant);
    procedure Setconta_juros_antecipacao(const Value: Variant);
    procedure Setcontato_ban(const Value: Variant);
    procedure Setconvenio(const Value: Variant);
    procedure Setdespesa_boleto_conta_id(const Value: Variant);
    procedure Setdetalhamento_remessa(const Value: Variant);
    procedure Setdeveloper_application_key(const Value: Variant);
    procedure Setdias_protesto_devolucao(const Value: Variant);
    procedure Setdigagencia_ban(const Value: Variant);
    procedure Setdigconta_ban(const Value: Variant);
    procedure Setdrg(const Value: Variant);
    procedure Setendereco(const Value: Variant);
    procedure Setfantasia(const Value: Variant);
    procedure Setindicadorpix(const Value: Variant);
    procedure Setlayout_remessa(const Value: Variant);
    procedure Setlayout_retorno(const Value: Variant);
    procedure Setlicenca(const Value: Variant);
    procedure Setlimite_ban(const Value: Variant);
    procedure Setlimite_troca(const Value: Variant);
    procedure Setlocal_pagamento(const Value: Variant);
    procedure SetLOG(const Value: Variant);
    procedure Setloja(const Value: Variant);
    procedure Setmodalidade(const Value: Variant);
    procedure Setnome_ban(const Value: Variant);
    procedure Setnum_ban(const Value: Variant);
    procedure Setnumero_ban(const Value: Variant);
    procedure Setoutras_configuracoes(const Value: Variant);
    procedure Setoutras_configuracoes2(const Value: Variant);
    procedure Setpersonalizacao_boleto(const Value: Variant);
    procedure Setrazao(const Value: Variant);
    procedure Setscope(const Value: Variant);
    procedure Setsequencia_remessa_pagamento(const Value: Variant);
    procedure Setstatus(const Value: Variant);
    procedure Settelefone(const Value: Variant);
    procedure Settelefone_ban(const Value: Variant);
    procedure Settipo_cobranca(const Value: Variant);
    procedure Settipo_emitente(const Value: Variant);
    procedure Settipo_impressao(const Value: Variant);
    procedure Setuf(const Value: Variant);
    procedure Seturl_atualizacao_boleto(const Value: Variant);
    procedure Setusuario_ban(const Value: Variant);
    procedure Setvalor_boleto(const Value: Variant);

  public

    property numero_ban: Variant read Fnumero_ban write Setnumero_ban;
    property nome_ban: Variant read Fnome_ban write Setnome_ban;
    property agencia_ban: Variant read Fagencia_ban write Setagencia_ban;
    property conta_ban: Variant read Fconta_ban write Setconta_ban;
    property contato_ban: Variant read Fcontato_ban write Setcontato_ban;
    property telefone_ban: Variant read Ftelefone_ban write Settelefone_ban;
    property usuario_ban: Variant read Fusuario_ban write Setusuario_ban;
    property digagencia_ban: Variant read Fdigagencia_ban write Setdigagencia_ban;
    property digconta_ban: Variant read Fdigconta_ban write Setdigconta_ban;
    property num_ban: Variant read Fnum_ban write Setnum_ban;
    property codigo_cedente: Variant read Fcodigo_cedente write Setcodigo_cedente;
    property licenca: Variant read Flicenca write Setlicenca;
    property layout_retorno: Variant read Flayout_retorno write Setlayout_retorno;
    property layout_remessa: Variant read Flayout_remessa write Setlayout_remessa;
    property caminho_retorno: Variant read Fcaminho_retorno write Setcaminho_retorno;
    property caminho_remessa: Variant read Fcaminho_remessa write Setcaminho_remessa;
    property limite_ban: Variant read Flimite_ban write Setlimite_ban;
    property id: Variant read Fid write Setid;
    property valor_boleto: Variant read Fvalor_boleto write Setvalor_boleto;
    property despesa_boleto_conta_id: Variant read Fdespesa_boleto_conta_id write Setdespesa_boleto_conta_id;
    property codigo_cedente2: Variant read Fcodigo_cedente2 write Setcodigo_cedente2;
    property outras_configuracoes: Variant read Foutras_configuracoes write Setoutras_configuracoes;
    property loja: Variant read Floja write Setloja;
    property tipo_impressao: Variant read Ftipo_impressao write Settipo_impressao;
    property limite_troca: Variant read Flimite_troca write Setlimite_troca;
    property status: Variant read Fstatus write Setstatus;
    property outras_configuracoes2: Variant read Foutras_configuracoes2 write Setoutras_configuracoes2;
    property dias_protesto_devolucao: Variant read Fdias_protesto_devolucao write Setdias_protesto_devolucao;
    property codigo_protesto_devolucao: Variant read Fcodigo_protesto_devolucao write Setcodigo_protesto_devolucao;
    property conta_aplicacao: Variant read Fconta_aplicacao write Setconta_aplicacao;
    property local_pagamento: Variant read Flocal_pagamento write Setlocal_pagamento;
    property banco_referente: Variant read Fbanco_referente write Setbanco_referente;
    property detalhamento_remessa: Variant read Fdetalhamento_remessa write Setdetalhamento_remessa;
    property url_atualizacao_boleto: Variant read Furl_atualizacao_boleto write Seturl_atualizacao_boleto;
    property atualizar_boleto: Variant read Fatualizar_boleto write Setatualizar_boleto;
    property drg: Variant read Fdrg write Setdrg;
    property personalizacao_boleto: Variant read Fpersonalizacao_boleto write Setpersonalizacao_boleto;
    property sequencia_remessa_pagamento: Variant read Fsequencia_remessa_pagamento write Setsequencia_remessa_pagamento;
    property codigo_convenio_pagamento: Variant read Fcodigo_convenio_pagamento write Setcodigo_convenio_pagamento;
    property caminho_retorno_pagamento: Variant read Fcaminho_retorno_pagamento write Setcaminho_retorno_pagamento;
    property caminho_remessa_pagamento: Variant read Fcaminho_remessa_pagamento write Setcaminho_remessa_pagamento;
    property conta_juros_antecipacao: Variant read Fconta_juros_antecipacao write Setconta_juros_antecipacao;
    property conta_iof_antecipacao: Variant read Fconta_iof_antecipacao write Setconta_iof_antecipacao;
    property conta_estorno_antecipacao: Variant read Fconta_estorno_antecipacao write Setconta_estorno_antecipacao;
    property systime: Variant read Fsystime write Setsystime;
    property tipo_cobranca: Variant read Ftipo_cobranca write Settipo_cobranca;
    property developer_application_key: Variant read Fdeveloper_application_key write Setdeveloper_application_key;
    property client_id: Variant read Fclient_id write Setclient_id;
    property client_secret: Variant read Fclient_secret write Setclient_secret;
    property LOG: Variant read FLOG write SetLOG;
    property fantasia: Variant read Ffantasia write Setfantasia;
    property razao: Variant read Frazao write Setrazao;
    property cnpj: Variant read Fcnpj write Setcnpj;
    property endereco: Variant read Fendereco write Setendereco;
    property bairro: Variant read Fbairro write Setbairro;
    property cidade: Variant read Fcidade write Setcidade;
    property uf: Variant read Fuf write Setuf;
    property cep: Variant read Fcep write Setcep;
    property telefone: Variant read Ftelefone write Settelefone;
    property tipo_emitente: Variant read Ftipo_emitente write Settipo_emitente;
    property indicadorpix: Variant read Findicadorpix write Setindicadorpix;
    property convenio: Variant read Fconvenio write Setconvenio;
    property modalidade: Variant read Fmodalidade write Setmodalidade;
    property codigotransmissao: Variant read Fcodigotransmissao write Setcodigotransmissao;
    property scope: Variant read Fscope write Setscope;
    property caracteristica_titulo: Variant read Fcaracteristica_titulo write Setcaracteristica_titulo;

    constructor _Create(pIConexao: IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITBancoModel;

    function Incluir: String;
    function Alterar(pID : String): ITBancoModel;
    function Exlcuir(pID : String): String;
    function Salvar: String;
    function carregaClasse(pID: String): ITBancoModel;

    function obterLista: IFDDataset;

   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  SysUtils,
  BancoDao;

{ TBancoModel }

function TBancoModel.Alterar(pID: String): ITBancoModel;
var
  lBancoModel : ITBancoModel;
begin
  lBancoModel := TBancoModel.getNewIface(vIConexao);
  try
    lBancoModel       := lBancoModel.objeto.carregaClasse(pID);
    lBancoModel.objeto.Acao  := tacAlterar;
    Result            := lBancoModel;
  finally
  end;
end;

function TBancoModel.Exlcuir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TBancoModel.getNewIface(pIConexao: IConexao): ITBancoModel;
begin
  Result := TImplObjetoOwner<TBancoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TBancoModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  self.Salvar;
end;

function TBancoModel.obterLista: IFDDataset;
var
  lBancoLista: ITBancoDao;
begin
  lBancoLista := TBancoDao.getNewIface(vIConexao);

  try
    lBancoLista.objeto.TotalRecords    := FTotalRecords;
    lBancoLista.objeto.WhereView       := FWhereView;
    lBancoLista.objeto.CountView       := FCountView;
    lBancoLista.objeto.OrderView       := FOrderView;
    lBancoLista.objeto.StartRecordView := FStartRecordView;
    lBancoLista.objeto.LengthPageView  := FLengthPageView;
    lBancoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lBancoLista.objeto.obterLista;

    FTotalRecords  := lBancoLista.objeto.TotalRecords;

  finally
    lBancoLista := nil;
  end;
end;

function TBancoModel.carregaClasse(pID: String): ITBancoModel;
var
  lBancoDao: ITBancoDao;
begin
  lBancoDao := TBancoDao.getNewIface(vIConexao);
  try
    Result  := lBancoDao.objeto.carregaClasse(pId);
  finally
    lBancoDao := nil;
  end;
end;

constructor TBancoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TBancoModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TBancoModel.Salvar: String;
var
  lBancoDao: ITBancoDao;
begin
  lBancoDao := TBancoDao.getNewIface(vIConexao);
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lBancoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lBancoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lBancoDao.objeto.excluir(mySelf);
    end;
  finally
    lBancoDao:=nil;
  end;
end;

procedure TBancoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TBancoModel.Setagencia_ban(const Value: Variant);
begin
  Fagencia_ban := Value;
end;

procedure TBancoModel.Setatualizar_boleto(const Value: Variant);
begin
  Fatualizar_boleto := Value;
end;

procedure TBancoModel.Setbairro(const Value: Variant);
begin
  Fbairro := Value;
end;

procedure TBancoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TBancoModel.SetDATA_CADASTRO(const Value: Variant);
begin

end;

procedure TBancoModel.Setdespesa_boleto_conta_id(const Value: Variant);
begin
  Fdespesa_boleto_conta_id := Value;
end;

procedure TBancoModel.Setdetalhamento_remessa(const Value: Variant);
begin
  Fdetalhamento_remessa := Value;
end;

procedure TBancoModel.Setdeveloper_application_key(const Value: Variant);
begin
  Fdeveloper_application_key := Value;
end;

procedure TBancoModel.Setdias_protesto_devolucao(const Value: Variant);
begin
  Fdias_protesto_devolucao := Value;
end;

procedure TBancoModel.Setdigagencia_ban(const Value: Variant);
begin
  Fdigagencia_ban := Value;
end;

procedure TBancoModel.Setdigconta_ban(const Value: Variant);
begin
  Fdigconta_ban := Value;
end;

procedure TBancoModel.Setdrg(const Value: Variant);
begin
  Fdrg := Value;
end;

procedure TBancoModel.Setendereco(const Value: Variant);
begin
  Fendereco := Value;
end;

procedure TBancoModel.Setfantasia(const Value: Variant);
begin
  Ffantasia := Value;
end;

procedure TBancoModel.Setbanco_referente(const Value: Variant);
begin
  Fbanco_referente := Value;
end;

procedure TBancoModel.Setcaminho_remessa(const Value: Variant);
begin
  Fcaminho_remessa := Value;
end;

procedure TBancoModel.Setcaminho_remessa_pagamento(const Value: Variant);
begin
  Fcaminho_remessa_pagamento := Value;
end;

procedure TBancoModel.Setcaminho_retorno(const Value: Variant);
begin
  Fcaminho_retorno := Value;
end;

procedure TBancoModel.Setcaminho_retorno_pagamento(const Value: Variant);
begin
  Fcaminho_retorno_pagamento := Value;
end;

procedure TBancoModel.Setcaracteristica_titulo(const Value: Variant);
begin
  Fcaracteristica_titulo := Value;
end;

procedure TBancoModel.Setcep(const Value: Variant);
begin
  Fcep := Value;
end;

procedure TBancoModel.Setcidade(const Value: Variant);
begin
  Fcidade := Value;
end;

procedure TBancoModel.Setclient_id(const Value: Variant);
begin
  Fclient_id := Value;
end;

procedure TBancoModel.Setclient_secret(const Value: Variant);
begin
  Fclient_secret := Value;
end;

procedure TBancoModel.Setcnpj(const Value: Variant);
begin
  Fcnpj := Value;
end;

procedure TBancoModel.Setcodigotransmissao(const Value: Variant);
begin
  Fcodigotransmissao := Value;
end;

procedure TBancoModel.Setcodigo_cedente(const Value: Variant);
begin
  Fcodigo_cedente := Value;
end;

procedure TBancoModel.Setcodigo_cedente2(const Value: Variant);
begin
  Fcodigo_cedente2 := Value;
end;

procedure TBancoModel.Setcodigo_convenio_pagamento(const Value: Variant);
begin
  Fcodigo_convenio_pagamento := Value;
end;

procedure TBancoModel.Setcodigo_protesto_devolucao(const Value: Variant);
begin
  Fcodigo_protesto_devolucao := Value;
end;

procedure TBancoModel.Setcontato_ban(const Value: Variant);
begin
  Fcontato_ban := Value;
end;

procedure TBancoModel.Setconta_aplicacao(const Value: Variant);
begin
  Fconta_aplicacao := Value;
end;

procedure TBancoModel.Setconta_ban(const Value: Variant);
begin
  Fconta_ban := Value;
end;

procedure TBancoModel.Setconta_estorno_antecipacao(const Value: Variant);
begin
  Fconta_estorno_antecipacao := Value;
end;

procedure TBancoModel.Setconta_iof_antecipacao(const Value: Variant);
begin
  Fconta_iof_antecipacao := Value;
end;

procedure TBancoModel.Setconta_juros_antecipacao(const Value: Variant);
begin
  Fconta_juros_antecipacao := Value;
end;

procedure TBancoModel.Setconvenio(const Value: Variant);
begin
  Fconvenio := Value;
end;

procedure TBancoModel.SetID(const Value: Variant);
begin

end;

procedure TBancoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TBancoModel.Setindicadorpix(const Value: Variant);
begin
  Findicadorpix := Value;
end;

procedure TBancoModel.Setlayout_remessa(const Value: Variant);
begin
  Flayout_remessa := Value;
end;

procedure TBancoModel.Setlayout_retorno(const Value: Variant);
begin
  Flayout_retorno := Value;
end;

procedure TBancoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TBancoModel.Setlicenca(const Value: Variant);
begin
  Flicenca := Value;
end;

procedure TBancoModel.Setlimite_ban(const Value: Variant);
begin
  Flimite_ban := Value;
end;

procedure TBancoModel.Setlimite_troca(const Value: Variant);
begin
  Flimite_troca := Value;
end;

procedure TBancoModel.Setlocal_pagamento(const Value: Variant);
begin
  Flocal_pagamento := Value;
end;

procedure TBancoModel.SetLOG(const Value: Variant);
begin
  FLOG := Value;
end;

procedure TBancoModel.Setloja(const Value: Variant);
begin
  Floja := Value;
end;

procedure TBancoModel.Setmodalidade(const Value: Variant);
begin
  Fmodalidade := Value;
end;

procedure TBancoModel.Setnome_ban(const Value: Variant);
begin
  Fnome_ban := Value;
end;

procedure TBancoModel.Setnumero_ban(const Value: Variant);
begin
  Fnumero_ban := Value;
end;

procedure TBancoModel.Setnum_ban(const Value: Variant);
begin
  Fnum_ban := Value;
end;

procedure TBancoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TBancoModel.Setoutras_configuracoes(const Value: Variant);
begin
  Foutras_configuracoes := Value;
end;

procedure TBancoModel.Setoutras_configuracoes2(const Value: Variant);
begin
  Foutras_configuracoes2 := Value;
end;

procedure TBancoModel.Setpersonalizacao_boleto(const Value: Variant);
begin
  Fpersonalizacao_boleto := Value;
end;

procedure TBancoModel.Setrazao(const Value: Variant);
begin
  Frazao := Value;
end;

procedure TBancoModel.Setscope(const Value: Variant);
begin
  Fscope := Value;
end;

procedure TBancoModel.Setsequencia_remessa_pagamento(const Value: Variant);
begin
  Fsequencia_remessa_pagamento := Value;
end;

procedure TBancoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TBancoModel.Setstatus(const Value: Variant);
begin
  Fstatus := Value;
end;

procedure TBancoModel.SetSYSTIME(const Value: Variant);
begin

end;

procedure TBancoModel.Settelefone(const Value: Variant);
begin
  Ftelefone := Value;
end;

procedure TBancoModel.Settelefone_ban(const Value: Variant);
begin
  Ftelefone_ban := Value;
end;

procedure TBancoModel.Settipo_cobranca(const Value: Variant);
begin
  Ftipo_cobranca := Value;
end;

procedure TBancoModel.Settipo_emitente(const Value: Variant);
begin
  Ftipo_emitente := Value;
end;

procedure TBancoModel.Settipo_impressao(const Value: Variant);
begin
  Ftipo_impressao := Value;
end;

procedure TBancoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TBancoModel.Setuf(const Value: Variant);
begin
  Fuf := Value;
end;

procedure TBancoModel.Seturl_atualizacao_boleto(const Value: Variant);
begin
  Furl_atualizacao_boleto := Value;
end;

procedure TBancoModel.Setusuario_ban(const Value: Variant);
begin
  Fusuario_ban := Value;
end;

procedure TBancoModel.Setvalor_boleto(const Value: Variant);
begin
  Fvalor_boleto := Value;
end;

procedure TBancoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
