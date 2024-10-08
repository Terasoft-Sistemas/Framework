unit CreditoClienteModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TCreditoClienteModel = class;
  ITCreditoClienteModel=IObject<TCreditoClienteModel>;

  TCreditoClienteModel = class
  private
    [unsafe] mySelf: ITCreditoClienteModel;
    vIConexao : IConexao;
    FCreditoClientesLista: IList<ITCreditoClienteModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    Fpedido_site: Variant;
    Fvenda_casada: Variant;
    Fobs: Variant;
    Fvalor: Variant;
    Fentrada_id: Variant;
    Fcliente_anterior_id: Variant;
    Fcliente_id: Variant;
    Fcontacorrente_id: Variant;
    Ffatura_id: Variant;
    Fdevolucao_id: Variant;
    Ffornecedor_id: Variant;
    Ftipo: Variant;
    Fdata: Variant;
    Fvalor_aberto: Variant;
    Fdata_cadastro: Variant;
    Fid: Variant;
    Fsystime: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetCreditoClientesLista(const Value: IList<ITCreditoClienteModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure Setcliente_anterior_id(const Value: Variant);
    procedure Setcliente_id(const Value: Variant);
    procedure Setcontacorrente_id(const Value: Variant);
    procedure Setdata(const Value: Variant);
    procedure Setdevolucao_id(const Value: Variant);
    procedure Setentrada_id(const Value: Variant);
    procedure Setfatura_id(const Value: Variant);
    procedure Setfornecedor_id(const Value: Variant);
    procedure Setobs(const Value: Variant);
    procedure Setpedido_site(const Value: Variant);
    procedure Settipo(const Value: Variant);
    procedure Setvalor(const Value: Variant);
    procedure Setvenda_casada(const Value: Variant);
    procedure Setvalor_aberto(const Value: Variant);
    procedure Setdata_cadastro(const Value: Variant);
    procedure Setid(const Value: Variant);
    procedure Setsystime(const Value: Variant);
  public
    property cliente_id: Variant read Fcliente_id write Setcliente_id;
    property devolucao_id: Variant read Fdevolucao_id write Setdevolucao_id;
    property data: Variant read Fdata write Setdata;
    property valor: Variant read Fvalor write Setvalor;
    property tipo: Variant read Ftipo write Settipo;
    property obs: Variant read Fobs write Setobs;
    property entrada_id: Variant read Fentrada_id write Setentrada_id;
    property fornecedor_id: Variant read Ffornecedor_id write Setfornecedor_id;
    property fatura_id: Variant read Ffatura_id write Setfatura_id;
    property pedido_site: Variant read Fpedido_site write Setpedido_site;
    property contacorrente_id: Variant read Fcontacorrente_id write Setcontacorrente_id;
    property cliente_anterior_id: Variant read Fcliente_anterior_id write Setcliente_anterior_id;
    property venda_casada: Variant read Fvenda_casada write Setvenda_casada;
    property valor_aberto: Variant read Fvalor_aberto write Setvalor_aberto;
    property id: Variant read Fid write Setid;
    property data_cadastro: Variant read Fdata_cadastro write Setdata_cadastro;
    property systime: Variant read Fsystime write Setsystime;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCreditoClienteModel;

    function Incluir : String;
    function Alterar(pID : String) : ITCreditoClienteModel;
    function Excluir(pID : String) : String;
    function Salvar: String;
    function carregaClasse(pID : String) : ITCreditoClienteModel;
    procedure obterLista;
    procedure creditosAbertos(pCliente : String);
    function totalCreditosAberto(pCliente: String) : Double;

    property CreditoClientesLista: IList<ITCreditoClienteModel> read FCreditoClientesLista write SetCreditoClientesLista;
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
  CreditoClienteDao;

{ TCreditoClienteModel }

function TCreditoClienteModel.Alterar(pID: String): ITCreditoClienteModel;
var
  lCreditoClienteModel : ITCreditoClienteModel;
begin
  lCreditoClienteModel := TCreditoClienteModel.getNewIface(vIConexao);
  try
    lCreditoClienteModel      := lCreditoClienteModel.objeto.carregaClasse(pID);
    lCreditoClienteModel.objeto.Acao := tacAlterar;
    Result                    := lCreditoClienteModel;
  finally

  end;
end;

function TCreditoClienteModel.carregaClasse(pID: String): ITCreditoClienteModel;
var
  lCreditoClienteDao: ITCreditoClienteDao;
begin

  lCreditoClienteDao := TCreditoClienteDao.getNewIface(vIConexao);
  try
    Result := lCreditoClienteDao.objeto.carregaClasse(pId);
  finally
    lCreditoClienteDao:=nil;
  end;
end;

function TCreditoClienteModel.Excluir(pID: String): String;
begin
  self.Fid  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TCreditoClienteModel.getNewIface(pIConexao: IConexao): ITCreditoClienteModel;
begin
  Result := TImplObjetoOwner<TCreditoClienteModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCreditoClienteModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

constructor TCreditoClienteModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

procedure TCreditoClienteModel.creditosAbertos(pCliente: String);
var
  lCreditoClienteLista: ITCreditoClienteDao;
begin
  lCreditoClienteLista := TCreditoClienteDao.getNewIface(vIConexao);
  try
    lCreditoClienteLista.objeto.creditosAbertos(pCliente);
    FCreditoClientesLista := lCreditoClienteLista.objeto.CreditoClientesLista;
  finally
    lCreditoClienteLista:=nil;
  end;
end;

destructor TCreditoClienteModel.Destroy;
begin

  inherited;
end;

procedure TCreditoClienteModel.obterLista;
var
  lCreditoClienteLista: ITCreditoClienteDao;
begin
  lCreditoClienteLista := TCreditoClienteDao.getNewIface(vIConexao);

  try
    lCreditoClienteLista.objeto.TotalRecords    := FTotalRecords;
    lCreditoClienteLista.objeto.WhereView       := FWhereView;
    lCreditoClienteLista.objeto.CountView       := FCountView;
    lCreditoClienteLista.objeto.OrderView       := FOrderView;
    lCreditoClienteLista.objeto.StartRecordView := FStartRecordView;
    lCreditoClienteLista.objeto.LengthPageView  := FLengthPageView;
    lCreditoClienteLista.objeto.IDRecordView    := FIDRecordView;

    lCreditoClienteLista.objeto.obterLista;

    FTotalRecords  := lCreditoClienteLista.objeto.TotalRecords;
    FCreditoClientesLista := lCreditoClienteLista.objeto.CreditoClientesLista;

  finally
    lCreditoClienteLista:=nil;
  end;
end;

function TCreditoClienteModel.Salvar: String;
var
  lCreditoClienteDao: ITCreditoClienteDao;
begin
  lCreditoClienteDao := TCreditoClienteDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCreditoClienteDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lCreditoClienteDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lCreditoClienteDao.objeto.excluir(mySelf);
    end;

  finally
    lCreditoClienteDao:=nil;
  end;
end;

procedure TCreditoClienteModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TCreditoClienteModel.Setcliente_anterior_id(const Value: Variant);
begin
  Fcliente_anterior_id := Value;
end;

procedure TCreditoClienteModel.Setcliente_id(const Value: Variant);
begin
  Fcliente_id := Value;
end;

procedure TCreditoClienteModel.Setcontacorrente_id(const Value: Variant);
begin
  Fcontacorrente_id := Value;
end;

procedure TCreditoClienteModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCreditoClienteModel.SetCreditoClientesLista;
begin
  FCreditoClientesLista := Value;
end;

procedure TCreditoClienteModel.Setdata(const Value: Variant);
begin
  Fdata := Value;
end;

procedure TCreditoClienteModel.Setdata_cadastro(const Value: Variant);
begin
  Fdata_cadastro := Value;
end;

procedure TCreditoClienteModel.Setdevolucao_id(const Value: Variant);
begin
  Fdevolucao_id := Value;
end;

procedure TCreditoClienteModel.Setentrada_id(const Value: Variant);
begin
  Fentrada_id := Value;
end;

procedure TCreditoClienteModel.Setfatura_id(const Value: Variant);
begin
  Ffatura_id := Value;
end;

procedure TCreditoClienteModel.Setfornecedor_id(const Value: Variant);
begin
  Ffornecedor_id := Value;
end;

procedure TCreditoClienteModel.Setid(const Value: Variant);
begin
  Fid := Value;
end;

procedure TCreditoClienteModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCreditoClienteModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCreditoClienteModel.Setobs(const Value: Variant);
begin
  Fobs := Value;
end;

procedure TCreditoClienteModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCreditoClienteModel.Setpedido_site(const Value: Variant);
begin
  Fpedido_site := Value;
end;

procedure TCreditoClienteModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCreditoClienteModel.Setsystime(const Value: Variant);
begin
  Fsystime := Value;
end;

procedure TCreditoClienteModel.Settipo(const Value: Variant);
begin
  Ftipo := Value;
end;

procedure TCreditoClienteModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCreditoClienteModel.Setvalor(const Value: Variant);
begin
  Fvalor := Value;
end;

procedure TCreditoClienteModel.Setvalor_aberto(const Value: Variant);
begin
  Fvalor_aberto := Value;
end;

procedure TCreditoClienteModel.Setvenda_casada(const Value: Variant);
begin
  Fvenda_casada := Value;
end;

procedure TCreditoClienteModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TCreditoClienteModel.totalCreditosAberto(pCliente: String): Double;
var
  lCreditos : ITCreditoClienteModel;
begin
  self.creditosAbertos(pCliente);

  Result := 0;

  for lCreditos in self.FCreditoClientesLista do
  begin
    Result := Result + lCreditos.objeto.valor_aberto;
  end;
end;

end.
