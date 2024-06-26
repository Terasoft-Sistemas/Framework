unit CaixaControleModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Utils,
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

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

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
  CaixaControleDao, System.SysUtils, UsuarioModel, FireDAC.Comp.Client;

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
  Result := self.CaixaAberto(self.vIConexao.getUSer.ID) <> '';
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

function TCaixaControleModel.vendaCaixaFechado(pDataHora: String): boolean;
var
  lCaixaControleDao : TCaixaControleDao;
begin
  lCaixaControleDao := TCaixaControleDao.Create(vIConexao);
  try
    Result := lCaixaControleDao.vendaCaixaFechado(pDataHora);
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
  lCaixaModel : TCaixaModel;
  lMemTable: TFDMemTable;
begin
  lCaixaControleDao  := TCaixaControleDao.Create(vIConexao);
  lCaixaAberto       := TCaixaControleModel.Create(vIConexao);
  lCaixaFechamento   := TCaixaControleModel.Create(vIConexao);
  lCaixaModel        := TCaixaModel.Create(vIConexao);

  try
    lCaixaControleDao.WhereView := ' and caixa_ctr.status = ''I''     '+
                                   ' and caixa_ctr.data_fecha is null '+
                                   ' and caixa_ctr.usuario = '+ QuotedStr(self.vIConexao.getUSer.ID);
    lCaixaControleDao.obterLista;

    if lCaixaControleDao.TotalRecords = 0 then
      CriaException('Nenhum caixa aberto localizado.');

    lCaixaAberto := lCaixaControleDao.CaixaControlesLista[0];

    lCaixaAberto.Acao       := tacAlterar;
    lCaixaAberto.data_fecha := DateToStr(vIConexao.DataServer);
    lCaixaAberto.Salvar;

    lCaixaFechamento.Acao    := tacIncluir;
    lCaixaFechamento.data    := DateToStr(vIConexao.DataServer);
    lCaixaFechamento.status  := 'F';
    lCaixaFechamento.usuario := self.vIConexao.getUSer.ID;
    lCaixaFechamento.hora    := TimeToStr(vIConexao.HoraServer);
    lCaixaFechamento.Salvar;

    lMemTable := lCaixaModel.obterSaldo(self.vIConexao.getUSer.ID);
    //Cr�dito
    incluirFechamento('200000', vIConexao.DataServer, 'Fec.Final '+self.vIConexao.getUSer.NOME+' '+TimeToStr(vIConexao.HoraServer), lMemTable.FieldByName('SaldoTotal').AsFloat, '000000', 'C', '', '', '', 0, '', '000004', '.', self.vIConexao.getEmpresa.LOJA);
    //D�bito
    incluirFechamento('200000', vIConexao.DataServer, 'Fec.Final '+self.vIConexao.getUSer.NOME+' '+TimeToStr(vIConexao.HoraServer), lMemTable.FieldByName('SaldoTotal').AsFloat, self.vIConexao.getUSer.ID, 'D', '', '', '', 0, '', '000004', '.', self.vIConexao.getEmpresa.LOJA);

    Result := lCaixaAberto.id;
  finally
    lCaixaAberto.Free;
    lCaixaFechamento.Free;
    lCaixaControleDao.Free;
    lCaixaModel.Free;
    lMemTable.Free;
  end;
end;

procedure TCaixaControleModel.incluirFechamento(pCodigoCta: string; pDataCai: TDateTime; pHistoricoCai: string; pValorCai: real; pUsuarioCai: string; pTipoCai: string; pClienteCai: string; pNumeroPed: string; pFaturaCai: string; pParcelaCai: INTEGER; pStatus: string; pPortadorCai: string; pConciliadoCai: string; pLoja: String);
var
  lCaixaModel : TCaixaModel;
begin
  lCaixaModel := TCaixaModel.Create(vIConexao);
  try
    lCaixaModel.carregaClasse(pCodigoCta);

    lCaixaModel.CODIGO_CTA     := pCodigoCta;
    lCaixaModel.DATA_CAI       := pDataCai;
    lCaixaModel.HISTORICO_CAI  := copy(pHistoricoCai,1,100);
    lCaixaModel.VALOR_CAI      := pValorCai;
    lCaixaModel.USUARIO_CAI    := pUsuarioCai;
    lCaixaModel.TIPO_CAI       := pTipoCai;
    lCaixaModel.CLIENTE_CAI    := pClienteCai;
    lCaixaModel.NUMERO_PED     := pNumeroPed;
    lCaixaModel.FATURA_CAI     := pFaturaCai;
    lCaixaModel.PARCELA_CAI    := pParcelaCai;
    lCaixaModel.STATUS         := pStatus;
    lCaixaModel.PORTADOR_CAI   := pPortadorCai;
    lCaixaModel.CONCILIADO_CAI := pConciliadoCai;
    lCaixaModel.LOJA           := pLoja;

    lCaixaModel.Incluir;
  finally
    lCaixaModel.Free;
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
  lCaixaModel   : TCaixaModel;
  lUsuarioModel : TUsuarioModel;
  lNomeUsuario  : String;
begin
  self.Incluir;

  lCaixaModel   := TCaixaModel.Create(vIConexao);
  lUsuarioModel := TUsuarioModel.Create(vIConexao);

  try

    lCaixaModel.CODIGO_CTA        := '500000';
    lCaixaModel.DATA_CAI          := DateToStr(vIConexao.DataServer);
    lCaixaModel.HISTORICO_CAI     := 'Inicializa��o '+ self.vIConexao.getUSer.NOME +' '+ TimeToStr(vIConexao.HoraServer);
    lCaixaModel.VALOR_CAI         := FloatToStr(pValor);
    lCaixaModel.USUARIO_CAI       := self.vIConexao.getUSer.ID;
    lCaixaModel.TIPO_CAI          := 'C';
    lCaixaModel.CLIENTE_CAI       := '';
    lCaixaModel.NUMERO_PED        := '999999';
    lCaixaModel.FATURA_CAI        := '';
    lCaixaModel.PARCELA_CAI       := '0';
    lCaixaModel.STATUS            := '';
    lCaixaModel.PORTADOR_CAI      := '000004';
    lCaixaModel.CONCILIADO_CAI    := '.';
    lCaixaModel.LOJA              := self.vIConexao.getEmpresa.LOJA;

    lCaixaModel.Incluir;

    lCaixaModel.HISTORICO_CAI     := 'Transferencia '+ self.vIConexao.getUSer.NOME +' '+ TimeToStr(vIConexao.HoraServer);
    lCaixaModel.USUARIO_CAI       := '000000';
    lCaixaModel.TIPO_CAI          := 'D';

    lCaixaModel.Incluir;

  finally
    lCaixaModel.Free;
    lUsuarioModel.Free;
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

procedure TCaixaControleModel.Sangria(pValor: Double; pHistorico: String);
var
  lCaixaModel   : TCaixaModel;
  lUsuarioModel : TUsuarioModel;
begin
  lCaixaModel   := TCaixaModel.Create(vIConexao);
  lUsuarioModel := TUsuarioModel.Create(vIConexao);

  try
    lCaixaModel.CODIGO_CTA          := '400000';
    lCaixaModel.DATA_CAI            := DateToStr(vIConexao.DataServer);
    lCaixaModel.VALOR_CAI           := FloatToStr(pValor);
    lCaixaModel.USUARIO_CAI         := self.vIConexao.getUSer.ID;
    lCaixaModel.TIPO_CAI            := 'D';
    lCaixaModel.CLIENTE_CAI         := '';
    lCaixaModel.NUMERO_PED          := '999999';
    lCaixaModel.FATURA_CAI          := '';
    lCaixaModel.PARCELA_CAI         := '0';
    lCaixaModel.STATUS              := '';
    lCaixaModel.PORTADOR_CAI        := '000004';
    lCaixaModel.CONCILIADO_CAI      := '.';
    lCaixaModel.LOJA                := self.vIConexao.getEmpresa.LOJA;

    if pHistorico = '' then
      lCaixaModel.HISTORICO_CAI := 'Sangria '+ self.vIConexao.getUSer.NOME + ' ' + TimeToStr(vIConexao.HoraServer)
    else
      lCaixaModel.HISTORICO_CAI := pHistorico;

    lCaixaModel.Incluir;

    lCaixaModel.USUARIO_CAI         := '000000';
    lCaixaModel.TIPO_CAI            := 'C';

    lCaixaModel.Incluir;;

  finally
    lCaixaModel.Free;
    lUsuarioModel.Free;
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

procedure TCaixaControleModel.Suprimento(pValor: Double; pHistorico: String);
var
  lCaixaModel   : TCaixaModel;
  lUsuarioModel : TUsuarioModel;
begin
  lCaixaModel   := TCaixaModel.Create(vIConexao);
  lUsuarioModel := TUsuarioModel.Create(vIConexao);

  try
    lCaixaModel.CODIGO_CTA          := '400000';
    lCaixaModel.DATA_CAI            := DateToStr(vIConexao.DataServer);
    lCaixaModel.VALOR_CAI           := FloatToStr(pValor);
    lCaixaModel.USUARIO_CAI         := self.vIConexao.getUSer.ID;
    lCaixaModel.TIPO_CAI            := 'C';
    lCaixaModel.CLIENTE_CAI         := '';
    lCaixaModel.NUMERO_PED          := '999999';
    lCaixaModel.FATURA_CAI          := '';
    lCaixaModel.PARCELA_CAI         := '0';
    lCaixaModel.STATUS              := '';
    lCaixaModel.PORTADOR_CAI        := '000004';
    lCaixaModel.CONCILIADO_CAI      := '.';
    lCaixaModel.LOJA                := self.vIConexao.getEmpresa.LOJA;

    if pHistorico = '' then
      lCaixaModel.HISTORICO_CAI := 'Suprimento '+ self.vIConexao.getUSer.NOME + ' ' + TimeToStr(vIConexao.HoraServer)
    else
      lCaixaModel.HISTORICO_CAI := pHistorico;

    lCaixaModel.Incluir;

    lCaixaModel.USUARIO_CAI         := '000000';
    lCaixaModel.TIPO_CAI            := 'D';

    lCaixaModel.Incluir;

  finally
    lCaixaModel.Free;
    lUsuarioModel.Free;
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
