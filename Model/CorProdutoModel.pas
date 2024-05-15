unit CorProdutoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TCorProdutoModel = class

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
    FREGISTRO_ID: Variant;
    FTABELA: Variant;
    FID: Variant;
    FDOCUMENTO_ID: Variant;
    FSYSTIME: Variant;
    FDESCRICAO: Variant;
    FDATA_CADASTRO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);

  public

    property ID             : Variant read FID write SetID;
    property DESCRICAO      : Variant read FDESCRICAO write SetDESCRICAO;
    property DATA_CADASTRO  : Variant read FDATA_CADASTRO write SetDATA_CADASTRO;
    propertY SYSTIME        : Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TCorProdutoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TCorProdutoModel;
    function obterLista: TFDMemTable;

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
  CorProdutoDao,  
  System.Classes, 
  System.SysUtils;

{ TCorProdutoModel }

function TCorProdutoModel.Alterar(pID: String): TCorProdutoModel;
var
  lCorProdutoModel : TCorProdutoModel;
begin
  lCorProdutoModel := TCorProdutoModel.Create(vIConexao);
  try
    lCorProdutoModel       := lCorProdutoModel.carregaClasse(pID);
    lCorProdutoModel.Acao  := tacAlterar;
    Result            	   := lCorProdutoModel;
  finally
  end;
end;

function TCorProdutoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TCorProdutoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TCorProdutoModel.carregaClasse(pId : String): TCorProdutoModel;
var
  lCorProdutoDao: TCorProdutoDao;
begin
  lCorProdutoDao := TCorProdutoDao.Create(vIConexao);

  try
    Result := lCorProdutoDao.carregaClasse(pID);
  finally
    lCorProdutoDao.Free;
  end;
end;

constructor TCorProdutoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCorProdutoModel.Destroy;
begin
  inherited;
end;

function TCorProdutoModel.obterLista: TFDMemTable;
var
  lCorProdutoLista: TCorProdutoDao;
begin
  lCorProdutoLista := TCorProdutoDao.Create(vIConexao);

  try
    lCorProdutoLista.TotalRecords    := FTotalRecords;
    lCorProdutoLista.WhereView       := FWhereView;
    lCorProdutoLista.CountView       := FCountView;
    lCorProdutoLista.OrderView       := FOrderView;
    lCorProdutoLista.StartRecordView := FStartRecordView;
    lCorProdutoLista.LengthPageView  := FLengthPageView;
    lCorProdutoLista.IDRecordView    := FIDRecordView;

    Result := lCorProdutoLista.obterLista;

    FTotalRecords := lCorProdutoLista.TotalRecords;

  finally
    lCorProdutoLista.Free;
  end;
end;

function TCorProdutoModel.Salvar: String;
var
  lCorProdutoDao: TCorProdutoDao;
begin
  lCorProdutoDao := TCorProdutoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCorProdutoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lCorProdutoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lCorProdutoDao.excluir(Self);
    end;
  finally
    lCorProdutoDao.Free;
  end;
end;

procedure TCorProdutoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TCorProdutoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCorProdutoModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;

procedure TCorProdutoModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TCorProdutoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCorProdutoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCorProdutoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCorProdutoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TCorProdutoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TCorProdutoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TCorProdutoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TCorProdutoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
