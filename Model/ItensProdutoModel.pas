unit ItensProdutoModel;

interface

uses
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  Interfaces.Conexao, FireDAC.Comp.Client;

type
  TItensProdutoModel = class;
  ITItensProdutoModel=IObject<TItensProdutoModel>;

  TItensProdutoModel = class
  private
    [unsafe] mySelf: ITItensProdutoModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVIDRO: Variant;
    FALTURA_M: Variant;
    FLARGURA_M: Variant;
    FUNICO: Variant;
    FID: Variant;
    FCUSTO_PRODUTO: Variant;
    FCODIGO_MATERIA_PRIMA: Variant;
    FSYSTIME: Variant;
    FPADRAO: Variant;
    FSALDO: Variant;
    FLojaView: String;
    FQTDE_MATERIA_PRIMA: Variant;
    FPROFUNDIDADE_M: Variant;
    FORDEM: Variant;
    FVALOR_VENDA: Variant;
    FLISTAR: Variant;
    FUNIDADE_MATERIA_PRIMA: Variant;
    FMDF: Variant;
    FCODIGO_PRODUTO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetALTURA_M(const Value: Variant);
    procedure SetCODIGO_MATERIA_PRIMA(const Value: Variant);
    procedure SetCODIGO_PRODUTO(const Value: Variant);
    procedure SetCUSTO_PRODUTO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLARGURA_M(const Value: Variant);
    procedure SetLISTAR(const Value: Variant);
    procedure SetLojaView(const Value: String);
    procedure SetMDF(const Value: Variant);
    procedure SetORDEM(const Value: Variant);
    procedure SetPADRAO(const Value: Variant);
    procedure SetPROFUNDIDADE_M(const Value: Variant);
    procedure SetQTDE_MATERIA_PRIMA(const Value: Variant);
    procedure SetSALDO(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUNICO(const Value: Variant);
    procedure SetUNIDADE_MATERIA_PRIMA(const Value: Variant);
    procedure SetVALOR_VENDA(const Value: Variant);
    procedure SetVIDRO(const Value: Variant);

  public

    property CODIGO_PRODUTO : Variant read FCODIGO_PRODUTO write SetCODIGO_PRODUTO;
    property CODIGO_MATERIA_PRIMA   : Variant read FCODIGO_MATERIA_PRIMA write SetCODIGO_MATERIA_PRIMA;
    property QTDE_MATERIA_PRIMA     : Variant read FQTDE_MATERIA_PRIMA write SetQTDE_MATERIA_PRIMA;
    property UNIDADE_MATERIA_PRIMA  : Variant read FUNIDADE_MATERIA_PRIMA write SetUNIDADE_MATERIA_PRIMA;
    property VALOR_VENDA    : Variant read FVALOR_VENDA write SetVALOR_VENDA;
    property ORDEM  : Variant read FORDEM write SetORDEM;
    property ID     : Variant read FID write SetID;
    property CUSTO_PRODUTO  : Variant read FCUSTO_PRODUTO write SetCUSTO_PRODUTO;
    property SALDO  : Variant read FSALDO write SetSALDO;
    property ALTURA_M       : Variant read FALTURA_M write SetALTURA_M;
    property LARGURA_M      : Variant read FLARGURA_M write SetLARGURA_M;
    property PROFUNDIDADE_M : Variant read FPROFUNDIDADE_M write SetPROFUNDIDADE_M;
    property VIDRO  : Variant read FVIDRO write SetVIDRO;
    property MDF    : Variant read FMDF write SetMDF;
    property PADRAO : Variant read FPADRAO write SetPADRAO;
    property UNICO  : Variant read FUNICO write SetUNICO;
    property SYSTIME        : Variant read FSYSTIME write SetSYSTIME;
    property LISTAR : Variant read FLISTAR write SetLISTAR;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITItensProdutoModel;

    function Salvar: String;
    function obterLista: IFDDataset;
    function carregaClasse(pId: String): ITItensProdutoModel;

   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property LojaView: String read FLojaView write SetLojaView;
  end;

implementation

uses
  ItensProdutoDao;

{ TItensProdutoModel }

constructor TItensProdutoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

function TItensProdutoModel.carregaClasse(pID : String): ITItensProdutoModel;
var
  lItensProdutoDao: ITItensProdutoDao;
begin
  lItensProdutoDao := TItensProdutoDao.getNewIface(vIConexao);
  try
    Result := lItensProdutoDao.objeto.carregaClasse(pID);
  finally
    lItensProdutoDao := nil;
  end;
end;

destructor TItensProdutoModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

class function TItensProdutoModel.getNewIface(pIConexao: IConexao): ITItensProdutoModel;
begin
  Result := TImplObjetoOwner<TItensProdutoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;


function TItensProdutoModel.obterLista: IFDDataset;
var
  lItensProdutoLista: ITItensProdutoDao;
begin
  lItensProdutoLista := TItensProdutoDao.getNewIface(vIConexao);

  try
    lItensProdutoLista.objeto.TotalRecords    := FTotalRecords;
    lItensProdutoLista.objeto.WhereView       := FWhereView;
    lItensProdutoLista.objeto.CountView       := FCountView;
    lItensProdutoLista.objeto.OrderView       := FOrderView;
    lItensProdutoLista.objeto.StartRecordView := FStartRecordView;
    lItensProdutoLista.objeto.LengthPageView  := FLengthPageView;
    lItensProdutoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lItensProdutoLista.objeto.obterLista;

    FTotalRecords := lItensProdutoLista.objeto.TotalRecords;

  finally
    lItensProdutoLista := nil;
  end;
end;

function TItensProdutoModel.Salvar: String;
var
  lItensProdutoDao: ITItensProdutoDao;
begin
  lItensProdutoDao := TItensProdutoDao.getNewIface(vIConexao);

  Result := '';

  try
  finally
    lItensProdutoDao:=nil;
  end;
end;

procedure TItensProdutoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TItensProdutoModel.SetALTURA_M(const Value: Variant);
begin
  FALTURA_M := Value;
end;

procedure TItensProdutoModel.SetCODIGO_MATERIA_PRIMA(const Value: Variant);
begin
  FCODIGO_MATERIA_PRIMA := Value;
end;

procedure TItensProdutoModel.SetCODIGO_PRODUTO(const Value: Variant);
begin
  FCODIGO_PRODUTO := Value;
end;

procedure TItensProdutoModel.SetCUSTO_PRODUTO(const Value: Variant);
begin
  FCUSTO_PRODUTO := Value;
end;

procedure TItensProdutoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TItensProdutoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TItensProdutoModel.SetLARGURA_M(const Value: Variant);
begin
  FLARGURA_M := Value;
end;

procedure TItensProdutoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TItensProdutoModel.SetLISTAR(const Value: Variant);
begin
  FLISTAR := Value;
end;

procedure TItensProdutoModel.SetLojaView(const Value: String);
begin
  FLojaView := Value;
end;

procedure TItensProdutoModel.SetMDF(const Value: Variant);
begin
  FMDF := Value;
end;

procedure TItensProdutoModel.SetORDEM(const Value: Variant);
begin
  FORDEM := Value;
end;

procedure TItensProdutoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TItensProdutoModel.SetPADRAO(const Value: Variant);
begin
  FPADRAO := Value;
end;

procedure TItensProdutoModel.SetPROFUNDIDADE_M(const Value: Variant);
begin
  FPROFUNDIDADE_M := Value;
end;

procedure TItensProdutoModel.SetQTDE_MATERIA_PRIMA(const Value: Variant);
begin
  FQTDE_MATERIA_PRIMA := Value;
end;

procedure TItensProdutoModel.SetSALDO(const Value: Variant);
begin
  FSALDO := Value;
end;

procedure TItensProdutoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TItensProdutoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TItensProdutoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TItensProdutoModel.SetUNICO(const Value: Variant);
begin
  FUNICO := Value;
end;

procedure TItensProdutoModel.SetUNIDADE_MATERIA_PRIMA(const Value: Variant);
begin
  FUNIDADE_MATERIA_PRIMA := Value;
end;

procedure TItensProdutoModel.SetVALOR_VENDA(const Value: Variant);
begin
  FVALOR_VENDA := Value;
end;

procedure TItensProdutoModel.SetVIDRO(const Value: Variant);
begin
  FVIDRO := Value;
end;

procedure TItensProdutoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
