unit PromocaoItensModel;

interface

uses
  Terasoft.Enumerado,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TPromocaoItensModel = class

  private
    vIConexao : IConexao;
    FPromocaoItenssLista: TObjectList<TPromocaoItensModel>;
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
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPromocaoItenssLista(const Value: TObjectList<TPromocaoItensModel>);
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
  public
    property id: Variant read Fid write Setid;
    property promocao_id: Variant read Fpromocao_id write Setpromocao_id;
    property produto_id: Variant read Fproduto_id write Setproduto_id;
    property valor_promocao: Variant read Fvalor_promocao write Setvalor_promocao;
    property saldo: Variant read Fsaldo write Setsaldo;
    property systime: Variant read Fsystime write Setsystime;
    property preco_venda_id: Variant read Fpreco_venda_id write Setpreco_venda_id;
    property cliente_id: Variant read Fcliente_id write Setcliente_id;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;

    property PromocaoItenssLista: TObjectList<TPromocaoItensModel> read FPromocaoItenssLista write SetPromocaoItenssLista;
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
  PromocaoItensDao;

{ TPromocaoItensModel }

constructor TPromocaoItensModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPromocaoItensModel.Destroy;
begin

  inherited;
end;

procedure TPromocaoItensModel.obterLista;
var
  lPromocaoItensLista: TPromocaoItensDao;
begin
  lPromocaoItensLista := TPromocaoItensDao.Create(vIConexao);

  try
    lPromocaoItensLista.TotalRecords    := FTotalRecords;
    lPromocaoItensLista.WhereView       := FWhereView;
    lPromocaoItensLista.CountView       := FCountView;
    lPromocaoItensLista.OrderView       := FOrderView;
    lPromocaoItensLista.StartRecordView := FStartRecordView;
    lPromocaoItensLista.LengthPageView  := FLengthPageView;
    lPromocaoItensLista.IDRecordView    := FIDRecordView;

    lPromocaoItensLista.obterLista;

    FTotalRecords  := lPromocaoItensLista.TotalRecords;
    FPromocaoItenssLista := lPromocaoItensLista.PromocaoItenssLista;

  finally
    lPromocaoItensLista.Free;
  end;
end;

function TPromocaoItensModel.Salvar: String;
var
  lPromocaoItensDao: TPromocaoItensDao;
begin
  lPromocaoItensDao := TPromocaoItensDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Enumerado.tacIncluir: Result := lPromocaoItensDao.incluir(Self);
      Terasoft.Enumerado.tacAlterar: Result := lPromocaoItensDao.alterar(Self);
      Terasoft.Enumerado.tacExcluir: Result := lPromocaoItensDao.excluir(Self);
    end;

  finally
    lPromocaoItensDao.Free;
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

procedure TPromocaoItensModel.SetPromocaoItenssLista(const Value: TObjectList<TPromocaoItensModel>);
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
