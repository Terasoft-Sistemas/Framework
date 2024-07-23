unit ComissaoVendedorModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao, FireDAC.Comp.Client;

type
  TComissaoVendedorModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FTIPO_COMISSAO: Variant;
    FDESCONTO_MAXIMO: Variant;
    FID: Variant;
    FVENDEDOR: Variant;
    FCOMISSAO: Variant;
    FTIPO_VENDA: Variant;
    FSYSTIME: Variant;
    FABATIMENTO_COMISSAO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetABATIMENTO_COMISSAO(const Value: Variant);
    procedure SetCOMISSAO(const Value: Variant);
    procedure SetDESCONTO_MAXIMO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO_COMISSAO(const Value: Variant);
    procedure SetTIPO_VENDA(const Value: Variant);
    procedure SetVENDEDOR(const Value: Variant);

  public
    property VENDEDOR: Variant read FVENDEDOR write SetVENDEDOR;
    property TIPO_VENDA: Variant read FTIPO_VENDA write SetTIPO_VENDA;
    property COMISSAO: Variant read FCOMISSAO write SetCOMISSAO;
    property ID: Variant read FID write SetID;
    property DESCONTO_MAXIMO: Variant read FDESCONTO_MAXIMO write SetDESCONTO_MAXIMO;
    property ABATIMENTO_COMISSAO: Variant read FABATIMENTO_COMISSAO write SetABATIMENTO_COMISSAO;
    property TIPO_COMISSAO: Variant read FTIPO_COMISSAO write SetTIPO_COMISSAO;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TComissaoVendedorModel;
    function Excluir(pID : String): String;
    function Salvar      : String;

    function obterLista: IFDDataset;

    function carregaClasse(pId: String): TComissaoVendedorModel;

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
  ComissaoVendedorDao;

{ TComissaoVendedorModel }

function TComissaoVendedorModel.Alterar(pID: String): TComissaoVendedorModel;
var
  lComissaoVendedorModel : TComissaoVendedorModel;
begin
  lComissaoVendedorModel := TComissaoVendedorModel.Create(vIConexao);

  try
    lComissaoVendedorModel      := lComissaoVendedorModel.carregaClasse(pID);
    lComissaoVendedorModel.Acao := tacAlterar;
    Result               := lComissaoVendedorModel;
  finally
    lComissaoVendedorModel.Free
  end;
end;

function TComissaoVendedorModel.carregaClasse(pId: String): TComissaoVendedorModel;
var
  lComissaoVendedorDao: TComissaoVendedorDao;
begin
  lComissaoVendedorDao := TComissaoVendedorDao.Create(vIConexao);

  try
    Result := lComissaoVendedorDao.carregaClasse(pId);
  finally
    lComissaoVendedorDao.Free;
  end;
end;

constructor TComissaoVendedorModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TComissaoVendedorModel.Destroy;
begin

  inherited;
end;

function TComissaoVendedorModel.Excluir(pID: String): String;
begin
  self.FID := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar
end;

function TComissaoVendedorModel.Incluir: String;
var
  lComissaoVendedorModel : TComissaoVendedorModel;
begin
  lComissaoVendedorModel := TComissaoVendedorModel.Create(vIConexao);
  try
    self.Acao := tacIncluir ;
    Result    := self.Salvar;
  finally
    lComissaoVendedorModel.Free;
  end;
end;

function TComissaoVendedorModel.obterLista: IFDDataset;
var
  lComissaoVendedorDao: TComissaoVendedorDao;
begin
  lComissaoVendedorDao := TComissaoVendedorDao.Create(vIConexao);

  try
    lComissaoVendedorDao.TotalRecords    := FTotalRecords;
    lComissaoVendedorDao.WhereView       := FWhereView;
    lComissaoVendedorDao.CountView       := FCountView;
    lComissaoVendedorDao.OrderView       := FOrderView;
    lComissaoVendedorDao.StartRecordView := FStartRecordView;
    lComissaoVendedorDao.LengthPageView  := FLengthPageView;
    lComissaoVendedorDao.IDRecordView    := FIDRecordView;

    Result := lComissaoVendedorDao.obterLista;

    FTotalRecords := lComissaoVendedorDao.TotalRecords;

  finally
    lComissaoVendedorDao.Free;
  end;
end;

function TComissaoVendedorModel.Salvar: String;
var
  lComissaoVendedorDao: TComissaoVendedorDao;
begin
  lComissaoVendedorDao := TComissaoVendedorDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lComissaoVendedorDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lComissaoVendedorDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lComissaoVendedorDao.excluir(Self);
    end;

  finally
    lComissaoVendedorDao.Free;
  end;
end;

procedure TComissaoVendedorModel.SetABATIMENTO_COMISSAO(const Value: Variant);
begin
  FABATIMENTO_COMISSAO := Value;
end;

procedure TComissaoVendedorModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TComissaoVendedorModel.SetCOMISSAO(const Value: Variant);
begin
  FCOMISSAO := Value;
end;

procedure TComissaoVendedorModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TComissaoVendedorModel.SetDESCONTO_MAXIMO(const Value: Variant);
begin
  FDESCONTO_MAXIMO := Value;
end;

procedure TComissaoVendedorModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TComissaoVendedorModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TComissaoVendedorModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TComissaoVendedorModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TComissaoVendedorModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TComissaoVendedorModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TComissaoVendedorModel.SetTIPO_COMISSAO(const Value: Variant);
begin
  FTIPO_COMISSAO := Value;
end;

procedure TComissaoVendedorModel.SetTIPO_VENDA(const Value: Variant);
begin
  FTIPO_VENDA := Value;
end;

procedure TComissaoVendedorModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TComissaoVendedorModel.SetVENDEDOR(const Value: Variant);
begin
  FVENDEDOR := Value;
end;

procedure TComissaoVendedorModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
