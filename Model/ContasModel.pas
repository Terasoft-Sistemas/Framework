unit ContasModel;

interface

uses
  Terasoft.Enumerado,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TContasModel = class

  private
    vIConexao : IConexao;
    FContassLista: TObjectList<TContasModel>;
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
    procedure SetContassLista(const Value: TObjectList<TContasModel>);
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

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;

    property ContassLista: TObjectList<TContasModel> read FContassLista write SetContassLista;
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

constructor TContasModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContasModel.Destroy;
begin

  inherited;
end;

procedure TContasModel.obterLista;
var
  lContasLista: TContasDao;
begin
  lContasLista := TContasDao.Create;

  try
    lContasLista.TotalRecords    := FTotalRecords;
    lContasLista.WhereView       := FWhereView;
    lContasLista.CountView       := FCountView;
    lContasLista.OrderView       := FOrderView;
    lContasLista.StartRecordView := FStartRecordView;
    lContasLista.LengthPageView  := FLengthPageView;
    lContasLista.IDRecordView    := FIDRecordView;

    lContasLista.obterLista;

    FTotalRecords  := lContasLista.TotalRecords;
    FContassLista := lContasLista.ContassLista;

  finally
    lContasLista.Free;
  end;
end;

function TContasModel.Salvar: String;
var
  lContasDao: TContasDao;
begin
  lContasDao := TContasDao.Create;

  Result := '';

  try
    case FAcao of
      Terasoft.Enumerado.tacIncluir: Result := lContasDao.incluir(Self);
      Terasoft.Enumerado.tacAlterar: Result := lContasDao.alterar(Self);
      Terasoft.Enumerado.tacExcluir: Result := lContasDao.excluir(Self);
    end;

  finally
    lContasDao.Free;
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

procedure TContasModel.SetContassLista(const Value: TObjectList<TContasModel>);
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
