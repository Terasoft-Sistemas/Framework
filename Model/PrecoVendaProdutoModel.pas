unit PrecoVendaProdutoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TPrecoVendaProdutoModel = class

  private
    vIConexao : IConexao;
    FPrecoVendaProdutosLista: TObjectList<TPrecoVendaProdutoModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPRODUTO_ID: Variant;
    FPRECO_VENDA_ID: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FVALOR_VENDA: Variant;
    FIDRecordView: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPrecoVendaProdutosLista(const Value: TObjectList<TPrecoVendaProdutoModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetPRECO_VENDA_ID(const Value: Variant);
    procedure SetPRODUTO_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR_VENDA(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
  public
    property ID: Variant read FID write SetID;
    property PRECO_VENDA_ID: Variant read FPRECO_VENDA_ID write SetPRECO_VENDA_ID;
    property PRODUTO_ID: Variant read FPRODUTO_ID write SetPRODUTO_ID;
    property VALOR_VENDA: Variant read FVALOR_VENDA write SetVALOR_VENDA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir : String;
    function Alterar(pID : String) : TPrecoVendaProdutoModel;
    function Excluir(pID : String) : String;
    function Salvar  : String;
    function carregaClasse(pID : String) : TPrecoVendaProdutoModel;
    procedure obterLista;

    property PrecoVendaProdutosLista: TObjectList<TPrecoVendaProdutoModel> read FPrecoVendaProdutosLista write SetPrecoVendaProdutosLista;
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
  PrecoVendaProdutoDao;

{ TPrecoVendaProdutoModel }

function TPrecoVendaProdutoModel.Alterar(pID: String): TPrecoVendaProdutoModel;
var
  lPrecoVendaProdutoModel : TPrecoVendaProdutoModel;
begin
  lPrecoVendaProdutoModel := TPrecoVendaProdutoModel.Create(vIConexao);
  try
    lPrecoVendaProdutoModel       := lPrecoVendaProdutoModel.carregaClasse(pID);
    lPrecoVendaProdutoModel.Acao  := tacAlterar;
    Result                        := lPrecoVendaProdutoModel;
  finally

  end;
end;

function TPrecoVendaProdutoModel.carregaClasse(pID: String): TPrecoVendaProdutoModel;
var
  lPrecoVendaProdutoModel: TPrecoVendaProdutoDao;
begin
  lPrecoVendaProdutoModel := TPrecoVendaProdutoDao.Create(vIConexao);
  try
    Result := lPrecoVendaProdutoModel.carregaClasse(ID);
  finally
    lPrecoVendaProdutoModel.Free;
  end;
end;

constructor TPrecoVendaProdutoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPrecoVendaProdutoModel.Destroy;
begin

  inherited;
end;

function TPrecoVendaProdutoModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

function TPrecoVendaProdutoModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

procedure TPrecoVendaProdutoModel.obterLista;
var
  lPrecoVendaProdutoLista: TPrecoVendaProdutoDao;
begin
  lPrecoVendaProdutoLista := TPrecoVendaProdutoDao.Create(vIConexao);

  try
    lPrecoVendaProdutoLista.TotalRecords    := FTotalRecords;
    lPrecoVendaProdutoLista.WhereView       := FWhereView;
    lPrecoVendaProdutoLista.CountView       := FCountView;
    lPrecoVendaProdutoLista.OrderView       := FOrderView;
    lPrecoVendaProdutoLista.StartRecordView := FStartRecordView;
    lPrecoVendaProdutoLista.LengthPageView  := FLengthPageView;
    lPrecoVendaProdutoLista.IDRecordView    := FIDRecordView;

    lPrecoVendaProdutoLista.obterLista;

    FTotalRecords  := lPrecoVendaProdutoLista.TotalRecords;
    FPrecoVendaProdutosLista := lPrecoVendaProdutoLista.PrecoVendaProdutosLista;

  finally
    lPrecoVendaProdutoLista.Free;
  end;
end;

function TPrecoVendaProdutoModel.Salvar: String;
var
  lPrecoVendaProdutoDao: TPrecoVendaProdutoDao;
begin
  lPrecoVendaProdutoDao := TPrecoVendaProdutoDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPrecoVendaProdutoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lPrecoVendaProdutoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lPrecoVendaProdutoDao.excluir(Self);
    end;

  finally
    lPrecoVendaProdutoDao.Free;
  end;
end;

procedure TPrecoVendaProdutoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPrecoVendaProdutoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPrecoVendaProdutoModel.SetPrecoVendaProdutosLista(const Value: TObjectList<TPrecoVendaProdutoModel>);
begin
  FPrecoVendaProdutosLista := Value;
end;

procedure TPrecoVendaProdutoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPrecoVendaProdutoModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPrecoVendaProdutoModel.SetPRECO_VENDA_ID(const Value: Variant);
begin
  FPRECO_VENDA_ID := Value;
end;

procedure TPrecoVendaProdutoModel.SetPRODUTO_ID(const Value: Variant);
begin
  FPRODUTO_ID := Value;
end;

procedure TPrecoVendaProdutoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPrecoVendaProdutoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoVendaProdutoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPrecoVendaProdutoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPrecoVendaProdutoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPrecoVendaProdutoModel.SetVALOR_VENDA(const Value: Variant);
begin
  FVALOR_VENDA := Value;
end;

procedure TPrecoVendaProdutoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
