unit LocalizacaoEstoqueModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TLocalizacaoEstoqueModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FID: Variant;
    FSYSTIME: Variant;
    FNOME: Variant;
    FIDRecordView: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetIDRecordView(const Value: String);

    public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID      :Variant read FID write SetID;
    property NOME    :Variant read FNOME write SetNOME;
    property SYSTIME :Variant read FSYSTIME write SetSYSTIME;
    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function Salvar : String;
    function Incluir: String;
    function carregaClasse(pId : String): TLocalizacaoEstoqueModel;
    function Alterar(pID : String): TLocalizacaoEstoqueModel;
    function Excluir(pID : String): String;

    function ObterLista : TFDMemTable; overload;

  end;

implementation

uses
  System.SysUtils, LocalizacaoEstoqueDao;

{ TLocalizacaoEstoqueModel }

function TLocalizacaoEstoqueModel.Alterar(pID: String): TLocalizacaoEstoqueModel;
var
  lLocalizacaoEstoqueModel : TLocalizacaoEstoqueModel;
begin
  lLocalizacaoEstoqueModel := TLocalizacaoEstoqueModel.Create(vIConexao);
  try
    lLocalizacaoEstoqueModel       := lLocalizacaoEstoqueModel.carregaClasse(pID);
    lLocalizacaoEstoqueModel.Acao  := tacAlterar;
    Result            := lLocalizacaoEstoqueModel;
  finally
  end;
end;

function TLocalizacaoEstoqueModel.carregaClasse(pId: String): TLocalizacaoEstoqueModel;
var
  lLocalizacaoEstoqueModel: TLocalizacaoEstoqueModel;
begin
  lLocalizacaoEstoqueModel := TLocalizacaoEstoqueModel.Create(vIConexao);

  try
    Result := lLocalizacaoEstoqueModel.carregaClasse(pId);
  finally
    lLocalizacaoEstoqueModel.Free;
  end;
end;

constructor TLocalizacaoEstoqueModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TLocalizacaoEstoqueModel.Destroy;
begin
  inherited;
end;

function TLocalizacaoEstoqueModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TLocalizacaoEstoqueModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TLocalizacaoEstoqueModel.ObterLista: TFDMemTable;
var
  lLocalizacaoEstoque: TLocalizacaoEstoqueDao;
begin
  lLocalizacaoEstoque := TLocalizacaoEstoqueDao.Create(vIConexao);
  try
    lLocalizacaoEstoque.TotalRecords    := FTotalRecords;
    lLocalizacaoEstoque.WhereView       := FWhereView;
    lLocalizacaoEstoque.CountView       := FCountView;
    lLocalizacaoEstoque.OrderView       := FOrderView;
    lLocalizacaoEstoque.StartRecordView := FStartRecordView;
    lLocalizacaoEstoque.LengthPageView  := FLengthPageView;
    lLocalizacaoEstoque.IDRecordView    := FIDRecordView;

    Result := lLocalizacaoEstoque.obterLista;
    FTotalRecords := lLocalizacaoEstoque.TotalRecords;
  finally
    lLocalizacaoEstoque.Free;
  end;
end;

function TLocalizacaoEstoqueModel.Salvar: String;
var
  lLocalizacaoEstoqueDao: TLocalizacaoEstoqueDao;
begin
  lLocalizacaoEstoqueDao := TLocalizacaoEstoqueDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lLocalizacaoEstoqueDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lLocalizacaoEstoqueDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lLocalizacaoEstoqueDao.excluir(Self);
    end;
  finally
    lLocalizacaoEstoqueDao.Free;
  end;
end;

procedure TLocalizacaoEstoqueModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TLocalizacaoEstoqueModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TLocalizacaoEstoqueModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TLocalizacaoEstoqueModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TLocalizacaoEstoqueModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TLocalizacaoEstoqueModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TLocalizacaoEstoqueModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TLocalizacaoEstoqueModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TLocalizacaoEstoqueModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TLocalizacaoEstoqueModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TLocalizacaoEstoqueModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
