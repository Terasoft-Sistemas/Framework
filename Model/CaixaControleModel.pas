unit CaixaControleModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Utils,
  CaixaModel,
  Terasoft.Framework.ObjectIface,
  sPRING.Collections,
  Interfaces.Conexao;

type
  TCaixaControleModel = class;
  ITCaixaControleModel=IObject<TCaixaControleModel>;

  TCaixaControleModel = class
  private
    [weak] mySelf: ITCaixaControleModel;

    vIConexao : IConexao;
    FCaixaControlesLista: IList<ITCaixaControleModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    Fhora: Variant;
    Fcontagem_credito: Variant;
    Fcontagem_dinheiro: Variant;
    Fcontagem_debito: Variant;
    Fid: Variant;
    Fstatus: Variant;
    Fsystime: Variant;
    Fjustificativa: Variant;
    Fusuario: Variant;
    Fdata_fecha: Variant;
    Fdata: Variant;
    FIDRecordView: String;
    Fhora_fecha: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetCaixaControlesLista(const Value: IList<ITCaixaControleModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure Setcontagem_credito(const Value: Variant);
    procedure Setcontagem_debito(const Value: Variant);
    procedure Setcontagem_dinheiro(const Value: Variant);
    procedure Setdata(const Value: Variant);
    procedure Setdata_fecha(const Value: Variant);
    procedure Sethora(const Value: Variant);
    procedure Setid(const Value: Variant);
    procedure Setjustificativa(const Value: Variant);
    procedure Setstatus(const Value: Variant);
    procedure Setsystime(const Value: Variant);
    procedure Setusuario(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure Sethora_fecha(const Value: Variant);
    procedure incluirFechamento(pCodigoCta: string; pDataCai: TDateTime; pHistoricoCai: string; pValorCai: real; pUsuarioCai: string; pTipoCai: string; pClienteCai: string; pNumeroPed: string; pFaturaCai: string; pParcelaCai: INTEGER; pStatus: string; pPortadorCai: string; pConciliadoCai: string; pLoja: String);
  public
    property id: Variant read Fid write Setid;
    property data: Variant read Fdata write Setdata;
    property status: Variant read Fstatus write Setstatus;
    property usuario: Variant read Fusuario write Setusuario;
    property hora: Variant read Fhora write Sethora;
    property data_fecha: Variant read Fdata_fecha write Setdata_fecha;
    property contagem_dinheiro: Variant read Fcontagem_dinheiro write Setcontagem_dinheiro;
    property contagem_credito: Variant read Fcontagem_credito write Setcontagem_credito;
    property contagem_debito: Variant read Fcontagem_debito write Setcontagem_debito;
    property justificativa: Variant read Fjustificativa write Setjustificativa;
    property systime: Variant read Fsystime write Setsystime;
    property hora_fecha: Variant read Fhora_fecha write Sethora_fecha;

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCaixaControleModel;

    function Incluir: String;
    function Salvar: String;
    procedure obterLista;

    procedure ultimosCaixa(pUsuario: String);
    function ultimoCaixa(pUsuario: String) : String;

    procedure InicializarCaixa(pValor: Double);
    function FecharCaixa : String;

    function CaixaAberto(pUsuario: String): String; overload;
    function CaixaAberto: Boolean; overload;

    procedure Sangria(pValor: Double; pHistorico : String);
    procedure Suprimento(pValor: Double; pHistorico : String);

    function dataFechamento(pIdCaixa, pUsuario: String): String;

    function vendaCaixaFechado(pDataHora: String): boolean;

    property CaixaControlesLista: IList<ITCaixaControleModel> read FCaixaControlesLista write SetCaixaControlesLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
  end;

implementation

uses
  CaixaControleDao, System.SysUtils, UsuarioModel, FireDAC.Comp.Client;

{ TCaixaControleModel }

function TCaixaControleModel.CaixaAberto(pUsuario: String): String;
var
  lCaixaControleDao: ITCaixaControleDao;
begin
  lCaixaControleDao := TCaixaControleDao.getNewIface(vIConexao);
  try
    lCaixaControleDao.objeto.WhereView := ' and caixa_ctr.status = ''I''     '+
                                   ' and caixa_ctr.data_fecha is null '+
                                   ' and caixa_ctr.usuario = '+ QuotedStr(pUsuario);
    lCaixaControleDao.objeto.obterLista;

    if lCaixaControleDao.objeto.TotalRecords = 0 then
    begin
      Result := '';
      exit;
    end;

    Result := lCaixaControleDao.objeto.CaixaControlesLista.First.objeto.DATA;

  finally
    lCaixaControleDao:=nil;
  end;
end;

function TCaixaControleModel.CaixaAberto: Boolean;
begin
  Result := self.CaixaAberto(self.vIConexao.getUSer.ID) <> '';
end;

constructor TCaixaControleModel._Create(pIConexao : IConexao);
begin
  FCaixaControlesLista := nil;
  vIConexao := pIConexao;
end;

function TCaixaControleModel.dataFechamento(pIdCaixa, pUsuario: String): String;
begin
  Result := TCaixaControleDao.getNewIface(vIConexao).objeto.dataFechamento(pIdCaixa, pUsuario);
end;

function TCaixaControleModel.vendaCaixaFechado(pDataHora: String): boolean;
begin
  Result := TCaixaControleDao.getNewIface(vIConexao).objeto.vendaCaixaFechado(pDataHora);
end;

destructor TCaixaControleModel.Destroy;
begin
  FCaixaControlesLista := nil;
  vIConexao := nil;
  inherited;
end;

function TCaixaControleModel.FecharCaixa : String;
var
  lCaixaControleDao  : ITCaixaControleDao;
  lCaixaAberto,
  lCaixaFechamento   : ITCaixaControleModel;
  lCaixaModel : ITCaixaModel;
  lMemTable: IFDDataset;
begin
  lCaixaControleDao  := TCaixaControleDao.getNewIface(vIConexao);
  lCaixaAberto       := TCaixaControleModel.getNewIface(vIConexao);
  lCaixaFechamento   := TCaixaControleModel.getNewIface(vIConexao);
  lCaixaModel        := TCaixaModel.getNewIface(vIConexao);

  try
    lCaixaControleDao.objeto.WhereView := ' and caixa_ctr.status = ''I''     '+
                                   ' and caixa_ctr.data_fecha is null '+
                                   ' and caixa_ctr.usuario = '+ QuotedStr(self.vIConexao.getUSer.ID);
    lCaixaControleDao.objeto.obterLista;

    if lCaixaControleDao.objeto.TotalRecords = 0 then
      CriaException('Nenhum caixa aberto localizado.');

    lCaixaAberto := lCaixaControleDao.objeto.CaixaControlesLista.First;

    lCaixaAberto.objeto.Acao       := tacAlterar;
    lCaixaAberto.objeto.data_fecha := DateToStr(vIConexao.DataServer);
    lCaixaAberto.objeto.Salvar;

    lCaixaFechamento.objeto.Acao    := tacIncluir;
    lCaixaFechamento.objeto.data    := DateToStr(vIConexao.DataServer);
    lCaixaFechamento.objeto.status  := 'F';
    lCaixaFechamento.objeto.usuario := self.vIConexao.getUSer.ID;
    lCaixaFechamento.objeto.hora    := TimeToStr(vIConexao.HoraServer);
    lCaixaFechamento.objeto.Salvar;

    lMemTable := lCaixaModel.objeto.obterSaldo(self.vIConexao.getUSer.ID);
    //Crédito
    incluirFechamento('200000', vIConexao.DataServer, 'Fec.Final '+self.vIConexao.getUSer.NOME+' '+TimeToStr(vIConexao.HoraServer), lMemTable.objeto.FieldByName('SaldoTotal').AsFloat, '000000', 'C', '', '', '', 0, '', '000004', '.', self.vIConexao.getEmpresa.LOJA);
    //Débito
    incluirFechamento('200000', vIConexao.DataServer, 'Fec.Final '+self.vIConexao.getUSer.NOME+' '+TimeToStr(vIConexao.HoraServer), lMemTable.objeto.FieldByName('SaldoTotal').AsFloat, self.vIConexao.getUSer.ID, 'D', '', '', '', 0, '', '000004', '.', self.vIConexao.getEmpresa.LOJA);

    Result := lCaixaAberto.objeto.id;
  finally
    lCaixaFechamento:=nil;
    lCaixaControleDao:=nil;
    lCaixaModel:=nil;
  end;
end;

class function TCaixaControleModel.getNewIface(pIConexao: IConexao): ITCaixaControleModel;
begin
  Result := TImplObjetoOwner<TCaixaControleModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TCaixaControleModel.incluirFechamento(pCodigoCta: string; pDataCai: TDateTime; pHistoricoCai: string; pValorCai: real; pUsuarioCai: string; pTipoCai: string; pClienteCai: string; pNumeroPed: string; pFaturaCai: string; pParcelaCai: INTEGER; pStatus: string; pPortadorCai: string; pConciliadoCai: string; pLoja: String);
var
  lCaixaModel : ITCaixaModel;
begin
  lCaixaModel := TCaixaModel.getNewIface(vIConexao);
  try
    lCaixaModel.objeto.carregaClasse(pCodigoCta);

    lCaixaModel.objeto.CODIGO_CTA     := pCodigoCta;
    lCaixaModel.objeto.DATA_CAI       := pDataCai;
    lCaixaModel.objeto.HISTORICO_CAI  := copy(pHistoricoCai,1,100);
    lCaixaModel.objeto.VALOR_CAI      := pValorCai;
    lCaixaModel.objeto.USUARIO_CAI    := pUsuarioCai;
    lCaixaModel.objeto.TIPO_CAI       := pTipoCai;
    lCaixaModel.objeto.CLIENTE_CAI    := pClienteCai;
    lCaixaModel.objeto.NUMERO_PED     := pNumeroPed;
    lCaixaModel.objeto.FATURA_CAI     := pFaturaCai;
    lCaixaModel.objeto.PARCELA_CAI    := pParcelaCai;
    lCaixaModel.objeto.STATUS         := pStatus;
    lCaixaModel.objeto.PORTADOR_CAI   := pPortadorCai;
    lCaixaModel.objeto.CONCILIADO_CAI := pConciliadoCai;
    lCaixaModel.objeto.LOJA           := pLoja;

    lCaixaModel.objeto.Incluir;
  finally
    lCaixaModel:=nil;
  end;
end;

function TCaixaControleModel.Incluir: String;
begin
  self.DATA    := DateToStr(vIConexao.DataServer);
  self.STATUS  := 'I';
  self.USUARIO := self.vIConexao.getUSer.ID;
  self.HORA    := TimeToStr(vIConexao.HoraServer);

  self.Acao := tacIncluir;
  self.Salvar;
end;

procedure TCaixaControleModel.InicializarCaixa(pValor: Double);
var
  lCaixaModel   : ITCaixaModel;
  lUsuarioModel : ITUsuarioModel;
  lNomeUsuario  : String;
begin
  self.Incluir;

  lCaixaModel   := TCaixaModel.getNewIface(vIConexao);
  lUsuarioModel := TUsuarioModel.getNewIface(vIConexao);

  try

    lCaixaModel.objeto.CODIGO_CTA        := '500000';
    lCaixaModel.objeto.DATA_CAI          := DateToStr(vIConexao.DataServer);
    lCaixaModel.objeto.HISTORICO_CAI     := 'Inicialização '+ self.vIConexao.getUSer.NOME +' '+ TimeToStr(vIConexao.HoraServer);
    lCaixaModel.objeto.VALOR_CAI         := FloatToStr(pValor);
    lCaixaModel.objeto.USUARIO_CAI       := self.vIConexao.getUSer.ID;
    lCaixaModel.objeto.TIPO_CAI          := 'C';
    lCaixaModel.objeto.CLIENTE_CAI       := '';
    lCaixaModel.objeto.NUMERO_PED        := '999999';
    lCaixaModel.objeto.FATURA_CAI        := '';
    lCaixaModel.objeto.PARCELA_CAI       := '0';
    lCaixaModel.objeto.STATUS            := '';
    lCaixaModel.objeto.PORTADOR_CAI      := '000004';
    lCaixaModel.objeto.CONCILIADO_CAI    := '.';
    lCaixaModel.objeto.LOJA              := self.vIConexao.getEmpresa.LOJA;

    lCaixaModel.objeto.Incluir;

    lCaixaModel.objeto.HISTORICO_CAI     := 'Transferencia '+ self.vIConexao.getUSer.NOME +' '+ TimeToStr(vIConexao.HoraServer);
    lCaixaModel.objeto.USUARIO_CAI       := '000000';
    lCaixaModel.objeto.TIPO_CAI          := 'D';

    lCaixaModel.objeto.Incluir;

  finally
    lCaixaModel:=nil;
    lUsuarioModel := nil;
  end;

end;

procedure TCaixaControleModel.obterLista;
var
  lCaixaControleLista: ITCaixaControleDao;
begin
  lCaixaControleLista := TCaixaControleDao.getNewIface(vIConexao);

  try
    lCaixaControleLista.objeto.TotalRecords    := FTotalRecords;
    lCaixaControleLista.objeto.WhereView       := FWhereView;
    lCaixaControleLista.objeto.CountView       := FCountView;
    lCaixaControleLista.objeto.OrderView       := FOrderView;
    lCaixaControleLista.objeto.StartRecordView := FStartRecordView;
    lCaixaControleLista.objeto.LengthPageView  := FLengthPageView;
    lCaixaControleLista.objeto.IDRecordView    := FIDRecordView;

    lCaixaControleLista.objeto.obterLista;

    FTotalRecords  := lCaixaControleLista.objeto.TotalRecords;
    FCaixaControlesLista := lCaixaControleLista.objeto.CaixaControlesLista;

  finally
    lCaixaControleLista:=nil;
  end;
end;

function TCaixaControleModel.Salvar: String;
var
  lCaixaControleDao: ITCaixaControleDao;
begin
  lCaixaControleDao := TCaixaControleDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCaixaControleDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lCaixaControleDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lCaixaControleDao.objeto.excluir(mySelf);
    end;

  finally
    lCaixaControleDao:=nil;
  end;
end;

procedure TCaixaControleModel.Sangria(pValor: Double; pHistorico: String);
var
  lCaixaModel   : ITCaixaModel;
  lUsuarioModel : ITUsuarioModel;
begin
  lCaixaModel   := TCaixaModel.getNewIface(vIConexao);
  lUsuarioModel := TUsuarioModel.getNewIface(vIConexao);

  try
    lCaixaModel.objeto.CODIGO_CTA          := '400000';
    lCaixaModel.objeto.DATA_CAI            := DateToStr(vIConexao.DataServer);
    lCaixaModel.objeto.VALOR_CAI           := FloatToStr(pValor);
    lCaixaModel.objeto.USUARIO_CAI         := self.vIConexao.getUSer.ID;
    lCaixaModel.objeto.TIPO_CAI            := 'D';
    lCaixaModel.objeto.CLIENTE_CAI         := '';
    lCaixaModel.objeto.NUMERO_PED          := '999999';
    lCaixaModel.objeto.FATURA_CAI          := '';
    lCaixaModel.objeto.PARCELA_CAI         := '0';
    lCaixaModel.objeto.STATUS              := '';
    lCaixaModel.objeto.PORTADOR_CAI        := '000004';
    lCaixaModel.objeto.CONCILIADO_CAI      := '.';
    lCaixaModel.objeto.LOJA                := self.vIConexao.getEmpresa.LOJA;

    if pHistorico = '' then
      lCaixaModel.objeto.HISTORICO_CAI := 'Sangria '+ self.vIConexao.getUSer.NOME + ' ' + TimeToStr(vIConexao.HoraServer)
    else
      lCaixaModel.objeto.HISTORICO_CAI := pHistorico;

    lCaixaModel.objeto.Incluir;

    lCaixaModel.objeto.USUARIO_CAI         := '000000';
    lCaixaModel.objeto.TIPO_CAI            := 'C';

    lCaixaModel.objeto.Incluir;;

  finally
    lCaixaModel:=nil;
    lUsuarioModel := nil;
  end;
end;

procedure TCaixaControleModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TCaixaControleModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCaixaControleModel.Setdata(const Value: Variant);
begin
  Fdata := Value;
end;

procedure TCaixaControleModel.Setdata_fecha(const Value: Variant);
begin
  Fdata_fecha := Value;
end;

procedure TCaixaControleModel.Sethora(const Value: Variant);
begin
  Fhora := Value;
end;

procedure TCaixaControleModel.Sethora_fecha(const Value: Variant);
begin
  Fhora_fecha := Value;
end;

procedure TCaixaControleModel.Setid(const Value: Variant);
begin
  Fid := Value;
end;

procedure TCaixaControleModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TCaixaControleModel.SetCaixaControlesLista;
begin
  FCaixaControlesLista := Value;
end;

procedure TCaixaControleModel.Setcontagem_credito(const Value: Variant);
begin
  Fcontagem_credito := Value;
end;

procedure TCaixaControleModel.Setcontagem_debito(const Value: Variant);
begin
  Fcontagem_debito := Value;
end;

procedure TCaixaControleModel.Setcontagem_dinheiro(const Value: Variant);
begin
  Fcontagem_dinheiro := Value;
end;

procedure TCaixaControleModel.Setjustificativa(const Value: Variant);
begin
  Fjustificativa := Value;
end;

procedure TCaixaControleModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCaixaControleModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCaixaControleModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCaixaControleModel.Setstatus(const Value: Variant);
begin
  Fstatus := Value;
end;

procedure TCaixaControleModel.Setsystime(const Value: Variant);
begin
  Fsystime := Value;
end;

procedure TCaixaControleModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCaixaControleModel.Setusuario(const Value: Variant);
begin
  Fusuario := Value;
end;

procedure TCaixaControleModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TCaixaControleModel.Suprimento(pValor: Double; pHistorico: String);
var
  lCaixaModel   : ITCaixaModel;
  lUsuarioModel : ITUsuarioModel;
begin
  lCaixaModel   := TCaixaModel.getNewIface(vIConexao);
  lUsuarioModel := TUsuarioModel.getNewIface(vIConexao);

  try
    lCaixaModel.objeto.CODIGO_CTA          := '400000';
    lCaixaModel.objeto.DATA_CAI            := DateToStr(vIConexao.DataServer);
    lCaixaModel.objeto.VALOR_CAI           := FloatToStr(pValor);
    lCaixaModel.objeto.USUARIO_CAI         := self.vIConexao.getUSer.ID;
    lCaixaModel.objeto.TIPO_CAI            := 'C';
    lCaixaModel.objeto.CLIENTE_CAI         := '';
    lCaixaModel.objeto.NUMERO_PED          := '999999';
    lCaixaModel.objeto.FATURA_CAI          := '';
    lCaixaModel.objeto.PARCELA_CAI         := '0';
    lCaixaModel.objeto.STATUS              := '';
    lCaixaModel.objeto.PORTADOR_CAI        := '000004';
    lCaixaModel.objeto.CONCILIADO_CAI      := '.';
    lCaixaModel.objeto.LOJA                := self.vIConexao.getEmpresa.LOJA;

    if pHistorico = '' then
      lCaixaModel.objeto.HISTORICO_CAI := 'Suprimento '+ self.vIConexao.getUSer.NOME + ' ' + TimeToStr(vIConexao.HoraServer)
    else
      lCaixaModel.objeto.HISTORICO_CAI := pHistorico;

    lCaixaModel.objeto.Incluir;

    lCaixaModel.objeto.USUARIO_CAI         := '000000';
    lCaixaModel.objeto.TIPO_CAI            := 'D';

    lCaixaModel.objeto.Incluir;

  finally
    lCaixaModel:=nil;
    lUsuarioModel := nil;
  end;
end;

function TCaixaControleModel.ultimoCaixa(pUsuario: String): String;
var
  lCaixaControleDao : ITCaixaControleDao;
begin
  lCaixaControleDao := TCaixaControleDao.getNewIface(vIConexao);
  try
    Result := lCaixaControleDao.objeto.ultimoCaixa(pUsuario);
  finally
    lCaixaControleDao:=nil;
  end;
end;

procedure TCaixaControleModel.ultimosCaixa(pUsuario: String);
var
  lCaixaControleLista: ITCaixaControleDao;
begin
  lCaixaControleLista := TCaixaControleDao.getNewIface(vIConexao);
  try
    lCaixaControleLista.objeto.ultimosCaixa(pUsuario);
    FCaixaControlesLista := lCaixaControleLista.objeto.CaixaControlesLista;

  finally
    lCaixaControleLista:=nil;
  end;
end;

end.
