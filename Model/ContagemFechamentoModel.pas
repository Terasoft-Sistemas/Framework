unit ContagemFechamentoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TContagemFechamentoModel = class

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
    FCAIXA_CTR_ID: Variant;
    FDATAHORA: Variant;
    FVALOR: Variant;
    FPORTADOR_ID: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FBANDEIRA_ID: Variant;
    FJUSTIFICATIVA: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetBANDEIRA_ID(const Value: Variant);
    procedure SetCAIXA_CTR_ID(const Value: Variant);
    procedure SetDATAHORA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetJUSTIFICATIVA(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR(const Value: Variant);

  public
    property ID: Variant read FID write SetID;
    property PORTADOR_ID: Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property BANDEIRA_ID: Variant read FBANDEIRA_ID write SetBANDEIRA_ID;
    property VALOR: Variant read FVALOR write SetVALOR;
    property DATAHORA: Variant read FDATAHORA write SetDATAHORA;
    property CAIXA_CTR_ID: Variant read FCAIXA_CTR_ID write SetCAIXA_CTR_ID;
    property JUSTIFICATIVA: Variant read FJUSTIFICATIVA write SetJUSTIFICATIVA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TContagemFechamentoModel;
    function Excluir(pID : String): String;
    function Salvar      : String;
    procedure obterLista;

    function carregaClasse(pId: String): TContagemFechamentoModel;

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
  ContagemFechamentoDao;

{ TContagemFechamentoModel }

function TContagemFechamentoModel.Alterar(pID: String): TContagemFechamentoModel;
var
  lContagemFechamentoModel : TContagemFechamentoModel;
begin
  lContagemFechamentoModel := TContagemFechamentoModel.Create(vIConexao);

  try
    lContagemFechamentoModel      := lContagemFechamentoModel.carregaClasse(pID);

    lContagemFechamentoModel.Acao := tacAlterar;
    Result               := lContagemFechamentoModel;
  finally
    lContagemFechamentoModel.Free
  end;
end;

function TContagemFechamentoModel.carregaClasse(pId: String): TContagemFechamentoModel;
var
  lContagemFechamentoDao: TContagemFechamentoDao;
begin
  lContagemFechamentoDao := TContagemFechamentoDao.Create(vIConexao);

  try
    Result := lContagemFechamentoDao.carregaClasse(pId);
  finally
    lContagemFechamentoDao.Free;
  end;
end;

constructor TContagemFechamentoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContagemFechamentoModel.Destroy;
begin

  inherited;
end;

function TContagemFechamentoModel.Excluir(pID: String): String;
begin
  self.FID := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar
end;

function TContagemFechamentoModel.Incluir: String;
var
  lContagemFechamentoModel : TContagemFechamentoModel;
begin
  lContagemFechamentoModel := TContagemFechamentoModel.Create(vIConexao);
  try
    self.Acao := tacIncluir ;
    Result    := self.Salvar;
  finally
    lContagemFechamentoModel.Free;
  end;
end;

procedure TContagemFechamentoModel.obterLista;
var
  lContagemFechamentoModel : TContagemFechamentoModel;
begin
  lContagemFechamentoModel := TContagemFechamentoModel.Create(vIConexao);

  try
    lContagemFechamentoModel.TotalRecords    := FTotalRecords;
    lContagemFechamentoModel.WhereView       := FWhereView;
    lContagemFechamentoModel.CountView       := FCountView;
    lContagemFechamentoModel.OrderView       := FOrderView;                                           d
    lContagemFechamentoModel.StartRecordView := FStartRecordView;
    lContagemFechamentoModel.LengthPageView  := FLengthPageView;
    lContagemFechamentoModel.IDRecordView    := FIDRecordView;

    lContagemFechamentoModel.obterLista;

    FTotalRecords  := lContagemFechamentoModel.TotalRecords;

  finally
    lContagemFechamentoModel.Free;
  end;
end;

function TContagemFechamentoModel.Salvar: String;
var
  lContagemFechamentoDao: TContagemFechamentoDao;
begin
  lContagemFechamentoDao := TContagemFechamentoDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lAdmCartaoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lAdmCartaoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lAdmCartaoDao.excluir(Self);
    end;

  finally
    lAdmCartaoDao.Free;
  end;
end;

procedure TContagemFechamentoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TContagemFechamentoModel.SetBANDEIRA_ID(const Value: Variant);
begin
  FBANDEIRA_ID := Value;
end;

procedure TContagemFechamentoModel.SetCAIXA_CTR_ID(const Value: Variant);
begin
  FCAIXA_CTR_ID := Value;
end;

procedure TContagemFechamentoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContagemFechamentoModel.SetDATAHORA(const Value: Variant);
begin
  FDATAHORA := Value;
end;

procedure TContagemFechamentoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContagemFechamentoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContagemFechamentoModel.SetJUSTIFICATIVA(const Value: Variant);
begin
  FJUSTIFICATIVA := Value;
end;

procedure TContagemFechamentoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContagemFechamentoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContagemFechamentoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TContagemFechamentoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContagemFechamentoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TContagemFechamentoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContagemFechamentoModel.SetVALOR(const Value: Variant);
begin
  FVALOR := Value;
end;

procedure TContagemFechamentoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
