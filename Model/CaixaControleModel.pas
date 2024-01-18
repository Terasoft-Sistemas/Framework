unit CaixaControleModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Utils,
  VariaveisGlobais,
  CaixaModel,
  Interfaces.Conexao;

type
  TCaixaControleModel = class

  private
    vIConexao : IConexao;

    FCaixaControlesLista: TObjectList<TCaixaControleModel>;
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
    procedure SetCaixaControlesLista(const Value: TObjectList<TCaixaControleModel>);
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

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;
    procedure ultimosCaixa(pUsuario: String);

    procedure InicializarCaixa(pValor: Double);
    function FecharCaixa : String;
    function CaixaAberto(pUsuario: String): String; overload;
    function CaixaAberto: Boolean; overload;
    procedure Sangria(pValor: Double);
    procedure Suprimento(pValor: Double);

    function ultimoCaixa(pUsuario: String) : String;
    function dataFechamento(pIdCaixa, pUsuario: String): String;

    property CaixaControlesLista: TObjectList<TCaixaControleModel> read FCaixaControlesLista write SetCaixaControlesLista;
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
  CaixaControleDao, System.SysUtils;

{ TCaixaControleModel }

function TCaixaControleModel.CaixaAberto(pUsuario: String): String;
var
  lCaixaControleDao: TCaixaControleDao;
begin
  lCaixaControleDao := TCaixaControleDao.Create(vIConexao);
  try
    lCaixaControleDao.WhereView := ' and caixa_ctr.status = ''I''     '+
                                   ' and caixa_ctr.data_fecha is null '+
                                   ' and caixa_ctr.usuario = '+ QuotedStr(pUsuario);
    lCaixaControleDao.obterLista;

    if lCaixaControleDao.TotalRecords = 0 then
    begin
      Result := '';
      exit;
    end;

    Result := lCaixaControleDao.CaixaControlesLista[0].DATA;

  finally
    lCaixaControleDao.Free;
  end;
end;

function TCaixaControleModel.CaixaAberto: Boolean;
begin
  Result := self.CaixaAberto(VariaveisGlobais.xUsuarioID) <> '';
end;

constructor TCaixaControleModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

function TCaixaControleModel.dataFechamento(pIdCaixa, pUsuario: String): String;
var
  lCaixaControleDao : TCaixaControleDao;
begin
  lCaixaControleDao := TCaixaControleDao.Create(vIConexao);
  try
    Result := lCaixaControleDao.dataFechamento(pIdCaixa, pUsuario);
  finally
    lCaixaControleDao.Free;
  end;
end;

destructor TCaixaControleModel.Destroy;
begin

  inherited;
end;

function TCaixaControleModel.FecharCaixa : String;
var
  lCaixaControleDao  : TCaixaControleDao;
  lCaixaAberto,
  lCaixaFechamento   : TCaixaControleModel;
begin
  lCaixaControleDao  := TCaixaControleDao.Create(vIConexao);
  lCaixaAberto       := TCaixaControleModel.Create(vIConexao);
  lCaixaFechamento   := TCaixaControleModel.Create(vIConexao);

  try
    lCaixaControleDao.WhereView := ' and caixa_ctr.status = ''I''     '+
                                   ' and caixa_ctr.data_fecha is null '+
                                   ' and caixa_ctr.usuario = '+ QuotedStr(VariaveisGlobais.xUsuarioID);
    lCaixaControleDao.obterLista;

    if lCaixaControleDao.TotalRecords = 0 then
      CriaException('Nenhum caixa aberto localizado.');

    lCaixaAberto := lCaixaControleDao.CaixaControlesLista[0];

    lCaixaAberto.Acao       := tacAlterar;
    lCaixaAberto.data_fecha := DateToStr(xConexao.DataServer);
    lCaixaAberto.Salvar;

    lCaixaFechamento.Acao    := tacIncluir;
    lCaixaFechamento.data    := DateToStr(xConexao.DataServer);
    lCaixaFechamento.status  := 'F';
    lCaixaFechamento.usuario := VariaveisGlobais.xUsuarioID;
    lCaixaFechamento.hora    := TimeToStr(xConexao.HoraServer);
    lCaixaFechamento.Salvar;

    Result := lCaixaAberto.id;

  finally
    lCaixaAberto.Free;
    lCaixaFechamento.Free;
    lCaixaControleDao.Free;
  end;
end;

procedure TCaixaControleModel.InicializarCaixa(pValor: Double);
var
  lCaixaModel : TCaixaModel;
begin
  self.Acao    := tacIncluir;
  self.DATA    := DateToStr(xConexao.DataServer);
  self.STATUS  := 'I';
  self.USUARIO := VariaveisGLobais.xUsuarioID;
  self.HORA    := TimeToStr(xConexao.HoraServer);
  self.Salvar;

  lCaixaModel := TCaixaModel.Create(vIConexao);

  try
    lCaixaModel.CODIGO_CTA        := '500000';
    lCaixaModel.DATA_CAI          := DateToStr(xConexao.DataServer);
    lCaixaModel.HISTORICO_CAI     := 'Inicialização '+ VariaveisGLobais.xUsuarioNome +' '+ TimeToStr(xConexao.HoraServer);
    lCaixaModel.VALOR_CAI         := FloatToStr(pValor);
    lCaixaModel.USUARIO_CAI       := VariaveisGLobais.xUsuarioID;
    lCaixaModel.TIPO_CAI          := 'C';
    lCaixaModel.CLIENTE_CAI       := '';
    lCaixaModel.NUMERO_PED        := '999999';
    lCaixaModel.FATURA_CAI        := '';
    lCaixaModel.PARCELA_CAI       := '0';
    lCaixaModel.STATUS            := '';
    lCaixaModel.PORTADOR_CAI      := '000004';
    lCaixaModel.CONCILIADO_CAI    := '.';
    lCaixaModel.LOJA              := VariaveisGLobais.xEmpresaLoja;

    lCaixaModel.Acao := tacIncluir;
    lCaixaModel.Salvar;

    lCaixaModel.HISTORICO_CAI     := 'Transferencia '+ VariaveisGLobais.xUsuarioNome +' '+ TimeToStr(xConexao.HoraServer);
    lCaixaModel.USUARIO_CAI       := '000000';
    lCaixaModel.TIPO_CAI          := 'D';

    lCaixaModel.Acao := tacIncluir;
    lCaixaModel.Salvar;

  finally
    lCaixaModel.Free;
  end;

end;

procedure TCaixaControleModel.obterLista;
var
  lCaixaControleLista: TCaixaControleDao;
begin
  lCaixaControleLista := TCaixaControleDao.Create(vIConexao);

  try
    lCaixaControleLista.TotalRecords    := FTotalRecords;
    lCaixaControleLista.WhereView       := FWhereView;
    lCaixaControleLista.CountView       := FCountView;
    lCaixaControleLista.OrderView       := FOrderView;
    lCaixaControleLista.StartRecordView := FStartRecordView;
    lCaixaControleLista.LengthPageView  := FLengthPageView;
    lCaixaControleLista.IDRecordView    := FIDRecordView;

    lCaixaControleLista.obterLista;

    FTotalRecords  := lCaixaControleLista.TotalRecords;
    FCaixaControlesLista := lCaixaControleLista.CaixaControlesLista;

  finally
    lCaixaControleLista.Free;
  end;
end;

function TCaixaControleModel.Salvar: String;
var
  lCaixaControleDao: TCaixaControleDao;
begin
  lCaixaControleDao := TCaixaControleDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCaixaControleDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lCaixaControleDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lCaixaControleDao.excluir(Self);
    end;

  finally
    lCaixaControleDao.Free;
  end;
end;

procedure TCaixaControleModel.Sangria(pValor: Double);
var
  lCaixaModel : TCaixaModel;
begin
  lCaixaModel := TCaixaModel.Create(vIConexao);

  try
    lCaixaModel.CODIGO_CTA          := '400000';
    lCaixaModel.DATA_CAI            := DateToStr(xConexao.DataServer);
    lCaixaModel.HISTORICO_CAI       := 'Sangria '+ VariaveisGlobais.xUsuarioNome + ' ' + TimeToStr(xConexao.HoraServer);
    lCaixaModel.VALOR_CAI           := FloatToStr(pValor);
    lCaixaModel.USUARIO_CAI         := VariaveisGlobais.xUsuarioID;
    lCaixaModel.TIPO_CAI            := 'D';
    lCaixaModel.CLIENTE_CAI         := '';
    lCaixaModel.NUMERO_PED          := '999999';
    lCaixaModel.FATURA_CAI          := '';
    lCaixaModel.PARCELA_CAI         := '0';
    lCaixaModel.STATUS              := '';
    lCaixaModel.PORTADOR_CAI        := '000004';
    lCaixaModel.CONCILIADO_CAI      := '.';
    lCaixaModel.LOJA                := VariaveisGlobais.xEmpresaLoja;

    lCaixaModel.Acao := tacIncluir;
    lCaixaModel.Salvar;

    lCaixaModel.USUARIO_CAI         := '000000';
    lCaixaModel.TIPO_CAI            := 'C';

    lCaixaModel.Acao := tacIncluir;
    lCaixaModel.Salvar;

  finally
    lCaixaModel.Free;
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

procedure TCaixaControleModel.SetCaixaControlesLista(const Value: TObjectList<TCaixaControleModel>);
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

procedure TCaixaControleModel.Suprimento(pValor: Double);
var
  lCaixaModel : TCaixaModel;
begin
  lCaixaModel := TCaixaModel.Create(vIConexao);

  try
    lCaixaModel.CODIGO_CTA          := '400000';
    lCaixaModel.DATA_CAI            := DateToStr(xConexao.DataServer);
    lCaixaModel.HISTORICO_CAI       := 'Suprimento '+ VariaveisGlobais.xUsuarioNome + ' ' + TimeToStr(xConexao.HoraServer);
    lCaixaModel.VALOR_CAI           := FloatToStr(pValor);
    lCaixaModel.USUARIO_CAI         := VariaveisGlobais.xUsuarioID;
    lCaixaModel.TIPO_CAI            := 'C';
    lCaixaModel.CLIENTE_CAI         := '';
    lCaixaModel.NUMERO_PED          := '999999';
    lCaixaModel.FATURA_CAI          := '';
    lCaixaModel.PARCELA_CAI         := '0';
    lCaixaModel.STATUS              := '';
    lCaixaModel.PORTADOR_CAI        := '000004';
    lCaixaModel.CONCILIADO_CAI      := '.';
    lCaixaModel.LOJA                := VariaveisGlobais.xEmpresaLoja;

    lCaixaModel.Acao := tacIncluir;
    lCaixaModel.Salvar;

    lCaixaModel.USUARIO_CAI         := '000000';
    lCaixaModel.TIPO_CAI            := 'D';

    lCaixaModel.Acao := tacIncluir;
    lCaixaModel.Salvar;

  finally
    lCaixaModel.Free;
  end;
end;

function TCaixaControleModel.ultimoCaixa(pUsuario: String): String;
var
  lCaixaControleDao : TCaixaControleDao;
begin
  lCaixaControleDao := TCaixaControleDao.Create(vIConexao);
  try
    Result := lCaixaControleDao.ultimoCaixa(pUsuario);
  finally
    lCaixaControleDao.Free;
  end;
end;

procedure TCaixaControleModel.ultimosCaixa(pUsuario: String);
var
  lCaixaControleLista: TCaixaControleDao;
begin
  lCaixaControleLista := TCaixaControleDao.Create(vIConexao);
  try
    lCaixaControleLista.ultimosCaixa(pUsuario);
    FCaixaControlesLista := lCaixaControleLista.CaixaControlesLista;

  finally
    lCaixaControleLista.Free;
  end;
end;

end.
