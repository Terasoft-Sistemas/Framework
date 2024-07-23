unit ProdutoTipoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TProdutoTipoModel = class

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
    FCOTACAO: Variant;
    FUSA_PECA: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FNOME: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCOTACAO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUSA_PECA(const Value: Variant);

    public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID        :Variant read FID write SetID;
    property NOME      :Variant read FNOME write SetNOME;
    property USA_PECA  :Variant read FUSA_PECA write SetUSA_PECA;
    property COTACAO   :Variant read FCOTACAO write SetCOTACAO;
    property SYSTIME   :Variant read FSYSTIME write SetSYSTIME;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function Salvar : String;
    function Incluir: String;
    function carregaClasse(pId : String): TProdutoTipoModel;
    function Alterar(pID : String): TProdutoTipoModel;
    function Excluir(pID : String): String;
    function ObterLista : IFDDataset; overload;

  end;

implementation

uses
  System.SysUtils, ProdutoTipoDao;

{ TProdutoTipoModel }

function TProdutoTipoModel.Alterar(pID: String): TProdutoTipoModel;
var
  lProdutoTipoModel : TProdutoTipoModel;
begin
  lProdutoTipoModel := TProdutoTipoModel.Create(vIConexao);
  try
    lProdutoTipoModel       := lProdutoTipoModel.carregaClasse(pID);
    lProdutoTipoModel.Acao  := tacAlterar;
    Result                  := lProdutoTipoModel;
  finally
  end;
end;

function TProdutoTipoModel.carregaClasse(pId: String): TProdutoTipoModel;
var
  lProdutoTipoModel: TProdutoTipoModel;
begin
  lProdutoTipoModel := TProdutoTipoModel.Create(vIConexao);

  try
    Result := lProdutoTipoModel.carregaClasse(pId);
  finally
    lProdutoTipoModel.Free;
  end;
end;

constructor TProdutoTipoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TProdutoTipoModel.Destroy;
begin
  inherited;
end;

function TProdutoTipoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TProdutoTipoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TProdutoTipoModel.ObterLista: IFDDataset;
var
  lProdutoTipo: TProdutoTipoDao;
begin
  lProdutoTipo := TProdutoTipoDao.Create(vIConexao);
  try
    lProdutoTipo.TotalRecords    := FTotalRecords;
    lProdutoTipo.WhereView       := FWhereView;
    lProdutoTipo.CountView       := FCountView;
    lProdutoTipo.OrderView       := FOrderView;
    lProdutoTipo.StartRecordView := FStartRecordView;
    lProdutoTipo.LengthPageView  := FLengthPageView;
    lProdutoTipo.IDRecordView    := FIDRecordView;

    Result := lProdutoTipo.obterLista;
    FTotalRecords := lProdutoTipo.TotalRecords;
  finally
    lProdutoTipo.Free;
  end;
end;

function TProdutoTipoModel.Salvar: String;
var
  lProdutoTipoDao: TProdutoTipoDao;
begin
  lProdutoTipoDao := TProdutoTipoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lProdutoTipoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lProdutoTipoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lProdutoTipoDao.excluir(Self);
    end;
  finally
    lProdutoTipoDao.Free;
  end;
end;

procedure TProdutoTipoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TProdutoTipoModel.SetCOTACAO(const Value: Variant);
begin
  FCOTACAO := Value;
end;

procedure TProdutoTipoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TProdutoTipoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TProdutoTipoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TProdutoTipoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TProdutoTipoModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TProdutoTipoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TProdutoTipoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TProdutoTipoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TProdutoTipoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TProdutoTipoModel.SetUSA_PECA(const Value: Variant);
begin
  FUSA_PECA := Value;
end;

procedure TProdutoTipoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
