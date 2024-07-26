unit PrecoVendaProdutoModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TPrecoVendaProdutoModel = class;
  ITPrecoVendaProdutoModel=IObject<TPrecoVendaProdutoModel>;

  TPrecoVendaProdutoModel = class
  private
    [weak] mySelf: ITPrecoVendaProdutoModel;
    vIConexao : IConexao;
    FPrecoVendaProdutosLista: IList<ITPrecoVendaProdutoModel>;
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
    procedure SetPrecoVendaProdutosLista(const Value: IList<ITPrecoVendaProdutoModel>);
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

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPrecoVendaProdutoModel;

    function Incluir : String;
    function Alterar(pID : String) : ITPrecoVendaProdutoModel;
    function Excluir(pID : String) : String;
    function Salvar  : String;
    function carregaClasse(pID : String) : ITPrecoVendaProdutoModel;
    procedure obterLista;

    property PrecoVendaProdutosLista: IList<ITPrecoVendaProdutoModel> read FPrecoVendaProdutosLista write SetPrecoVendaProdutosLista;
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

function TPrecoVendaProdutoModel.Alterar(pID: String): ITPrecoVendaProdutoModel;
var
  lPrecoVendaProdutoModel : ITPrecoVendaProdutoModel;
begin
  lPrecoVendaProdutoModel := TPrecoVendaProdutoModel.getNewIface(vIConexao);
  try
    lPrecoVendaProdutoModel       := lPrecoVendaProdutoModel.objeto.carregaClasse(pID);
    lPrecoVendaProdutoModel.objeto.Acao  := tacAlterar;
    Result                        := lPrecoVendaProdutoModel;
  finally

  end;
end;

function TPrecoVendaProdutoModel.carregaClasse(pID: String): ITPrecoVendaProdutoModel;
var
  lPrecoVendaProdutoModel: ITPrecoVendaProdutoDao;
begin
  lPrecoVendaProdutoModel := TPrecoVendaProdutoDao.getNewIface(vIConexao);
  try
    Result := lPrecoVendaProdutoModel.objeto.carregaClasse(ID);
  finally
    lPrecoVendaProdutoModel:=nil;
  end;
end;

constructor TPrecoVendaProdutoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPrecoVendaProdutoModel.Destroy;
begin
  FPrecoVendaProdutosLista:=nil;
  vIConexao:=nil;
  inherited;
end;

function TPrecoVendaProdutoModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TPrecoVendaProdutoModel.getNewIface(pIConexao: IConexao): ITPrecoVendaProdutoModel;
begin
  Result := TImplObjetoOwner<TPrecoVendaProdutoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPrecoVendaProdutoModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

procedure TPrecoVendaProdutoModel.obterLista;
var
  lPrecoVendaProdutoLista: ITPrecoVendaProdutoDao;
begin
  lPrecoVendaProdutoLista := TPrecoVendaProdutoDao.getNewIface(vIConexao);

  try
    lPrecoVendaProdutoLista.objeto.TotalRecords    := FTotalRecords;
    lPrecoVendaProdutoLista.objeto.WhereView       := FWhereView;
    lPrecoVendaProdutoLista.objeto.CountView       := FCountView;
    lPrecoVendaProdutoLista.objeto.OrderView       := FOrderView;
    lPrecoVendaProdutoLista.objeto.StartRecordView := FStartRecordView;
    lPrecoVendaProdutoLista.objeto.LengthPageView  := FLengthPageView;
    lPrecoVendaProdutoLista.objeto.IDRecordView    := FIDRecordView;

    lPrecoVendaProdutoLista.objeto.obterLista;

    FTotalRecords  := lPrecoVendaProdutoLista.objeto.TotalRecords;
    FPrecoVendaProdutosLista := lPrecoVendaProdutoLista.objeto.PrecoVendaProdutosLista;

  finally
    lPrecoVendaProdutoLista:=nil;
  end;
end;

function TPrecoVendaProdutoModel.Salvar: String;
var
  lPrecoVendaProdutoDao: ITPrecoVendaProdutoDao;
begin
  lPrecoVendaProdutoDao := TPrecoVendaProdutoDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPrecoVendaProdutoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lPrecoVendaProdutoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lPrecoVendaProdutoDao.objeto.excluir(mySelf);
    end;

  finally
    lPrecoVendaProdutoDao:=nil;
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

procedure TPrecoVendaProdutoModel.SetPrecoVendaProdutosLista;
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
