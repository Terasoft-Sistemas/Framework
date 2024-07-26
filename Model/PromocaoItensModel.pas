unit PromocaoItensModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TPromocaoItensModel = class;
  ITPromocaoItensModel=IObject<TPromocaoItensModel>;

  TPromocaoItensModel = class
  private
    [weak] mySelf: ITPromocaoItensModel;
    vIConexao : IConexao;
    FPromocaoItenssLista: IList<ITPromocaoItensModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    Fproduto_id: Variant;
    Fvalor_promocao: Variant;
    Fid: Variant;
    Fsystime: Variant;
    Fpromocao_id: Variant;
    Fsaldo: Variant;
    Fpreco_venda_id: Variant;
    Fcliente_id: Variant;
    FProdutoView: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPromocaoItenssLista(const Value: IList<ITPromocaoItensModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure Setid(const Value: Variant);
    procedure Setproduto_id(const Value: Variant);
    procedure Setpromocao_id(const Value: Variant);
    procedure Setsaldo(const Value: Variant);
    procedure Setsystime(const Value: Variant);
    procedure Setvalor_promocao(const Value: Variant);
    procedure Setcliente_id(const Value: Variant);
    procedure Setpreco_venda_id(const Value: Variant);
    procedure SetProdutoView(const Value: String);

  public

    property id: Variant read Fid write Setid;
    property promocao_id: Variant read Fpromocao_id write Setpromocao_id;
    property produto_id: Variant read Fproduto_id write Setproduto_id;
    property valor_promocao: Variant read Fvalor_promocao write Setvalor_promocao;
    property saldo: Variant read Fsaldo write Setsaldo;
    property systime: Variant read Fsystime write Setsystime;
    property preco_venda_id: Variant read Fpreco_venda_id write Setpreco_venda_id;
    property cliente_id: Variant read Fcliente_id write Setcliente_id;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPromocaoItensModel;

    function Incluir: String;
    function Alterar(pID : String) : ITPromocaoItensModel;
    function Excluir(pID : String) : String;
    function Salvar: String;
    function carregaClasse(pID : String) : ITPromocaoItensModel;
    procedure obterLista;

    property PromocaoItenssLista: IList<ITPromocaoItensModel> read FPromocaoItenssLista write SetPromocaoItenssLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property ProdutoView: String read FProdutoView write SetProdutoView;
  end;

implementation

uses
  PromocaoItensDao;

{ TPromocaoItensModel }

function TPromocaoItensModel.Alterar(pID: String): ITPromocaoItensModel;
var
  lPromocaoItensModel: ITPromocaoItensModel;
begin
  lPromocaoItensModel := TPromocaoItensModel.getNewIface(vIConexao);
  try
    lPromocaoItensModel       := lPromocaoItensModel.objeto.carregaClasse(pID);
    lPromocaoItensModel.objeto.Acao  := tacAlterar;
    Result                    := lPromocaoItensModel;
  finally

  end;
end;

function TPromocaoItensModel.Excluir(pID: String): String;
begin
  self.Fid  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TPromocaoItensModel.getNewIface(
  pIConexao: IConexao): ITPromocaoItensModel;
begin
  Result := TImplObjetoOwner<TPromocaoItensModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPromocaoItensModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TPromocaoItensModel.carregaClasse(pID: String): ITPromocaoItensModel;
var
  lPromocaoItensModel: ITPromocaoItensDao;
begin
  lPromocaoItensModel := TPromocaoItensDao.getNewIface(vIConexao);
  try
    Result := lPromocaoItensModel.objeto.carregaClasse(ID);
  finally
    lPromocaoItensModel:=nil;
  end;
end;

constructor TPromocaoItensModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPromocaoItensModel.Destroy;
begin
  FPromocaoItenssLista := nil;
  vIConexao := nil;
  inherited;
end;

procedure TPromocaoItensModel.obterLista;
var
  lPromocaoItensLista: ITPromocaoItensDao;
begin
  lPromocaoItensLista := TPromocaoItensDao.getNewIface(vIConexao);

  try
    lPromocaoItensLista.objeto.TotalRecords    := FTotalRecords;
    lPromocaoItensLista.objeto.WhereView       := FWhereView;
    lPromocaoItensLista.objeto.CountView       := FCountView;
    lPromocaoItensLista.objeto.OrderView       := FOrderView;
    lPromocaoItensLista.objeto.StartRecordView := FStartRecordView;
    lPromocaoItensLista.objeto.LengthPageView  := FLengthPageView;
    lPromocaoItensLista.objeto.IDRecordView    := FIDRecordView;
    lPromocaoItensLista.objeto.ProdutoView     := FProdutoView;

    lPromocaoItensLista.objeto.obterLista;

    FTotalRecords  := lPromocaoItensLista.objeto.TotalRecords;
    FPromocaoItenssLista := lPromocaoItensLista.objeto.PromocaoItenssLista;

  finally
    lPromocaoItensLista:=nil;
  end;
end;

function TPromocaoItensModel.Salvar: String;
var
  lPromocaoItensDao: ITPromocaoItensDao;
begin
  lPromocaoItensDao := TPromocaoItensDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPromocaoItensDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lPromocaoItensDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lPromocaoItensDao.objeto.excluir(mySelf);
    end;

  finally
    lPromocaoItensDao:=nil;
  end;
end;

procedure TPromocaoItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPromocaoItensModel.Setcliente_id(const Value: Variant);
begin
  Fcliente_id := Value;
end;

procedure TPromocaoItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPromocaoItensModel.Setid(const Value: Variant);
begin
  Fid := Value;
end;

procedure TPromocaoItensModel.SetPromocaoItenssLista;
begin
  FPromocaoItenssLista := Value;
end;

procedure TPromocaoItensModel.Setpromocao_id(const Value: Variant);
begin
  Fpromocao_id := Value;
end;

procedure TPromocaoItensModel.Setsaldo(const Value: Variant);
begin
  Fsaldo := Value;
end;

procedure TPromocaoItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPromocaoItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPromocaoItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPromocaoItensModel.Setpreco_venda_id(const Value: Variant);
begin
  Fpreco_venda_id := Value;
end;

procedure TPromocaoItensModel.SetProdutoView(const Value: String);
begin
  FProdutoView := Value;
end;

procedure TPromocaoItensModel.Setproduto_id(const Value: Variant);
begin
  Fproduto_id := Value;
end;

procedure TPromocaoItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPromocaoItensModel.Setsystime(const Value: Variant);
begin
  Fsystime := Value;
end;

procedure TPromocaoItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPromocaoItensModel.Setvalor_promocao(const Value: Variant);
begin
  Fvalor_promocao := Value;
end;

procedure TPromocaoItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
