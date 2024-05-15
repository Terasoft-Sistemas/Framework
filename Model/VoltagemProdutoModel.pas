unit VoltagemProdutoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TVoltagemProdutoModel = class

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
    property DESCRICAO      : Variant  read FDESCRICAO write SetDESCRICAO;
    property DATA_CADASTRO  : Variant  read FDATA_CADASTRO write SetDATA_CADASTRO;
    propertY SYSTIME        : Variant  read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TVoltagemProdutoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TVoltagemProdutoModel;
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
  VoltagemProdutoDao,  
  System.Classes, 
  System.SysUtils;

{ TVoltagemProdutoModel }

function TVoltagemProdutoModel.Alterar(pID: String): TVoltagemProdutoModel;
var
  lVoltagemProdutoModel : TVoltagemProdutoModel;
begin
  lVoltagemProdutoModel := TVoltagemProdutoModel.Create(vIConexao);
  try
    lVoltagemProdutoModel       := lVoltagemProdutoModel.carregaClasse(pID);
    lVoltagemProdutoModel.Acao  := tacAlterar;
    Result               		    := lVoltagemProdutoModel;
  finally
  end;
end;

function TVoltagemProdutoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TVoltagemProdutoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TVoltagemProdutoModel.carregaClasse(pID : String): TVoltagemProdutoModel;
var
  lVoltagemProdutoDao: TVoltagemProdutoDao;
begin
  lVoltagemProdutoDao := TVoltagemProdutoDao.Create(vIConexao);

  try
    Result := lVoltagemProdutoDao.carregaClasse(pID);
  finally
    lVoltagemProdutoDao.Free;
  end;
end;

constructor TVoltagemProdutoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TVoltagemProdutoModel.Destroy;
begin
  inherited;
end;

function TVoltagemProdutoModel.obterLista: TFDMemTable;
var
  lVoltagemProdutoLista: TVoltagemProdutoDao;
begin
  lVoltagemProdutoLista := TVoltagemProdutoDao.Create(vIConexao);

  try
    lVoltagemProdutoLista.TotalRecords    := FTotalRecords;
    lVoltagemProdutoLista.WhereView       := FWhereView;
    lVoltagemProdutoLista.CountView       := FCountView;
    lVoltagemProdutoLista.OrderView       := FOrderView;
    lVoltagemProdutoLista.StartRecordView := FStartRecordView;
    lVoltagemProdutoLista.LengthPageView  := FLengthPageView;
    lVoltagemProdutoLista.IDRecordView    := FIDRecordView;

    Result := lVoltagemProdutoLista.obterLista;

    FTotalRecords := lVoltagemProdutoLista.TotalRecords;

  finally
    lVoltagemProdutoLista.Free;
  end;
end;

function TVoltagemProdutoModel.Salvar: String;
var
  lVoltagemProdutoDao: TVoltagemProdutoDao;
begin
  lVoltagemProdutoDao := TVoltagemProdutoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lVoltagemProdutoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lVoltagemProdutoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lVoltagemProdutoDao.excluir(Self);
    end;
  finally
    lVoltagemProdutoDao.Free;
  end;
end;

procedure TVoltagemProdutoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TVoltagemProdutoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVoltagemProdutoModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;

procedure TVoltagemProdutoModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TVoltagemProdutoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TVoltagemProdutoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TVoltagemProdutoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVoltagemProdutoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TVoltagemProdutoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TVoltagemProdutoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TVoltagemProdutoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TVoltagemProdutoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
