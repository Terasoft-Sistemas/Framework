unit ContasModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TContasModel = class;
  ITContasModel=IObject<TContasModel>;

  TContasModel = class
  private
    [weak] mySelf: ITContasModel;
    vIConexao : IConexao;
    FContassLista: IList<ITContasModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    Fextrato_cta: Variant;
    Fgrupo_cta: Variant;
    Fbaixapagar_cta: Variant;
    Fbanco_cta: Variant;
    Fdr_cta: Variant;
    Fcredito_fornecedor_cta: Variant;
    Freceitaxdespesas: Variant;
    Fcodigo_cta: Variant;
    Ftiposemdr_cta: Variant;
    Fid: Variant;
    Fstatus: Variant;
    Floja: Variant;
    Fcentrocusto_cta: Variant;
    Fsystime: Variant;
    Femprestimo_cta: Variant;
    Fcredito_icms: Variant;
    Fordem: Variant;
    Fsubgrupo_cta: Variant;
    Fusuario_cta: Variant;
    Fnome_cta: Variant;
    Fclassificacao: Variant;
    Fcredito_cliente_cta: Variant;
    Ftiposemdr_cta_recebimento: Variant;
    Ftipo_cta: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetContassLista(const Value: IList<ITContasModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure Setbaixapagar_cta(const Value: Variant);
    procedure Setbanco_cta(const Value: Variant);
    procedure Setcentrocusto_cta(const Value: Variant);
    procedure Setclassificacao(const Value: Variant);
    procedure Setcodigo_cta(const Value: Variant);
    procedure Setcredito_cliente_cta(const Value: Variant);
    procedure Setcredito_fornecedor_cta(const Value: Variant);
    procedure Setcredito_icms(const Value: Variant);
    procedure Setdr_cta(const Value: Variant);
    procedure Setemprestimo_cta(const Value: Variant);
    procedure Setextrato_cta(const Value: Variant);
    procedure Setgrupo_cta(const Value: Variant);
    procedure Setloja(const Value: Variant);
    procedure Setnome_cta(const Value: Variant);
    procedure Setordem(const Value: Variant);
    procedure Setreceitaxdespesas(const Value: Variant);
    procedure Setstatus(const Value: Variant);
    procedure Setsubgrupo_cta(const Value: Variant);
    procedure Settipo_cta(const Value: Variant);
    procedure Settiposemdr_cta(const Value: Variant);
    procedure Settiposemdr_cta_recebimento(const Value: Variant);
    procedure Setusuario_cta(const Value: Variant);
  public
    property id: Variant read Fid write Setid;
    property classificacao: Variant read Fclassificacao write Setclassificacao;
    property codigo_cta: Variant read Fcodigo_cta write Setcodigo_cta;
    property nome_cta: Variant read Fnome_cta write Setnome_cta;
    property tipo_cta: Variant read Ftipo_cta write Settipo_cta;
    property dr_cta: Variant read Fdr_cta write Setdr_cta;
    property usuario_cta: Variant read Fusuario_cta write Setusuario_cta;
    property banco_cta: Variant read Fbanco_cta write Setbanco_cta;
    property baixapagar_cta: Variant read Fbaixapagar_cta write Setbaixapagar_cta;
    property tiposemdr_cta: Variant read Ftiposemdr_cta write Settiposemdr_cta;
    property tiposemdr_cta_recebimento: Variant read Ftiposemdr_cta_recebimento write Settiposemdr_cta_recebimento;
    property grupo_cta: Variant read Fgrupo_cta write Setgrupo_cta;
    property subgrupo_cta: Variant read Fsubgrupo_cta write Setsubgrupo_cta;
    property centrocusto_cta: Variant read Fcentrocusto_cta write Setcentrocusto_cta;
    property extrato_cta: Variant read Fextrato_cta write Setextrato_cta;
    property ordem: Variant read Fordem write Setordem;
    property loja: Variant read Floja write Setloja;
    property emprestimo_cta: Variant read Femprestimo_cta write Setemprestimo_cta;
    property status: Variant read Fstatus write Setstatus;
    property credito_icms: Variant read Fcredito_icms write Setcredito_icms;
    property receitaxdespesas: Variant read Freceitaxdespesas write Setreceitaxdespesas;
    property systime: Variant read Fsystime write Setsystime;
    property credito_cliente_cta: Variant read Fcredito_cliente_cta write Setcredito_cliente_cta;
    property credito_fornecedor_cta: Variant read Fcredito_fornecedor_cta write Setcredito_fornecedor_cta;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITContasModel;

    function Incluir : String;
    function Salvar  : String;
    function Alterar(pID : String) : ITContasModel;
    function Excluir(pID : String) : String;
    function carregaClasse(pID : String) : ITContasModel;
    procedure obterLista;

    property ContassLista: IList<ITContasModel> read FContassLista write SetContassLista;
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
  ContasDao;

{ TContasModel }

function TContasModel.Alterar(pID: String): ITContasModel;
var
  lContasModel : ITContasModel;
begin
  lContasModel := TContasModel.getNewIface(vIConexao);
  try
    lContasModel      := lContasModel.objeto.carregaClasse(pID);
    lContasModel.objeto.Acao := tacAlterar;
    Result            := lContasModel;
  finally

  end;
end;

function TContasModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  result    := self.Salvar;
end;

class function TContasModel.getNewIface(pIConexao: IConexao): ITContasModel;
begin
  Result := TImplObjetoOwner<TContasModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TContasModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  self.Salvar;
end;

function TContasModel.carregaClasse(pID: String): ITContasModel;
begin

end;

constructor TContasModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContasModel.Destroy;
begin
  FContassLista := nil;
  vIConexao := nil;
  inherited;
end;

procedure TContasModel.obterLista;
var
  lContasLista: ITContasDao;
begin
  lContasLista := TContasDao.getNewIface(vIConexao);

  try
    lContasLista.objeto.TotalRecords    := FTotalRecords;
    lContasLista.objeto.WhereView       := FWhereView;
    lContasLista.objeto.CountView       := FCountView;
    lContasLista.objeto.OrderView       := FOrderView;
    lContasLista.objeto.StartRecordView := FStartRecordView;
    lContasLista.objeto.LengthPageView  := FLengthPageView;
    lContasLista.objeto.IDRecordView    := FIDRecordView;

    lContasLista.objeto.obterLista;

    FTotalRecords   := lContasLista.objeto.TotalRecords;
    FContassLista   := lContasLista.objeto.ContassLista;

  finally
    lContasLista:=nil;
  end;
end;

function TContasModel.Salvar: String;
var
  lContasDao: ITContasDao;
begin
  lContasDao := TContasDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lContasDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lContasDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lContasDao.objeto.excluir(mySelf);
    end;

  finally
    lContasDao:=nil;
  end;
end;

procedure TContasModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TContasModel.Setbaixapagar_cta(const Value: Variant);
begin
  Fbaixapagar_cta := Value;
end;

procedure TContasModel.Setbanco_cta(const Value: Variant);
begin
  Fbanco_cta := Value;
end;

procedure TContasModel.Setcentrocusto_cta(const Value: Variant);
begin
  Fcentrocusto_cta := Value;
end;

procedure TContasModel.Setclassificacao(const Value: Variant);
begin
  Fclassificacao := Value;
end;

procedure TContasModel.Setcodigo_cta(const Value: Variant);
begin
  Fcodigo_cta := Value;
end;

procedure TContasModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasModel.Setcredito_cliente_cta(const Value: Variant);
begin
  Fcredito_cliente_cta := Value;
end;

procedure TContasModel.Setcredito_fornecedor_cta(const Value: Variant);
begin
  Fcredito_fornecedor_cta := Value;
end;

procedure TContasModel.Setcredito_icms(const Value: Variant);
begin
  Fcredito_icms := Value;
end;

procedure TContasModel.SetDATA_CADASTRO(const Value: Variant);
begin

end;

procedure TContasModel.Setdr_cta(const Value: Variant);
begin
  Fdr_cta := Value;
end;

procedure TContasModel.Setemprestimo_cta(const Value: Variant);
begin
  Femprestimo_cta := Value;
end;

procedure TContasModel.Setextrato_cta(const Value: Variant);
begin
  Fextrato_cta := Value;
end;

procedure TContasModel.Setgrupo_cta(const Value: Variant);
begin
  Fgrupo_cta := Value;
end;

procedure TContasModel.SetContassLista;
begin
  FContassLista := Value;
end;

procedure TContasModel.SetID(const Value: Variant);
begin

end;

procedure TContasModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasModel.Setloja(const Value: Variant);
begin
  Floja := Value;
end;

procedure TContasModel.Setnome_cta(const Value: Variant);
begin
  Fnome_cta := Value;
end;

procedure TContasModel.Setordem(const Value: Variant);
begin
  Fordem := Value;
end;

procedure TContasModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasModel.Setreceitaxdespesas(const Value: Variant);
begin
  Freceitaxdespesas := Value;
end;

procedure TContasModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasModel.Setstatus(const Value: Variant);
begin
  Fstatus := Value;
end;

procedure TContasModel.Setsubgrupo_cta(const Value: Variant);
begin
  Fsubgrupo_cta := Value;
end;

procedure TContasModel.SetSYSTIME(const Value: Variant);
begin

end;

procedure TContasModel.Settiposemdr_cta(const Value: Variant);
begin
  Ftiposemdr_cta := Value;
end;

procedure TContasModel.Settiposemdr_cta_recebimento(const Value: Variant);
begin
  Ftiposemdr_cta_recebimento := Value;
end;

procedure TContasModel.Settipo_cta(const Value: Variant);
begin
  Ftipo_cta := Value;
end;

procedure TContasModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasModel.Setusuario_cta(const Value: Variant);
begin
  Fusuario_cta := Value;
end;

procedure TContasModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
