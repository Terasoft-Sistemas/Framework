unit PrecoUFModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Interfaces.Conexao;

type
  TPrecoUFModel = class

  private
    vIConexao : IConexao;
    FPrecoUFsLista: IList<TPrecoUFModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPRODUTO_ID: Variant;
    FSIMPLES: Variant;
    FUF: Variant;
    FID: Variant;
    FICMS_ST: Variant;
    FCOMISSAO: Variant;
    FSYSTIME: Variant;
    FTOTAL: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPrecoUFsLista(const Value: IList<TPrecoUFModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCOMISSAO(const Value: Variant);
    procedure SetICMS_ST(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetPRODUTO_ID(const Value: Variant);
    procedure SetSIMPLES(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUF(const Value: Variant);
    procedure SetTOTAL(const Value: Variant);
  public
	  property ID: Variant read FID write SetID;
    property PRODUTO_ID: Variant read FPRODUTO_ID write SetPRODUTO_ID;
    property UF: Variant read FUF write SetUF;
    property COMISSAO: Variant read FCOMISSAO write SetCOMISSAO;
    property SIMPLES: Variant read FSIMPLES write SetSIMPLES;
    property ICMS_ST: Variant read FICMS_ST write SetICMS_ST;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property TOTAL: Variant read FTOTAL write SetTOTAL;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir : String;
    function Alterar(pID : String): TPrecoUFModel;
    function Excluir(pID : String): String;
    function carregaClasse(ID: String): TPrecoUFModel;
    function Salvar  : String;
    procedure obterLista;

    property PrecoUFsLista: IList<TPrecoUFModel> read FPrecoUFsLista write SetPrecoUFsLista;
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
  PrecoUFDao;

{ TPrecoUFModel }

function TPrecoUFModel.Alterar(pID: String): TPrecoUFModel;
var
  lPrecoUFModel : TPrecoUFModel;
begin
  lPrecoUFModel := TPrecoUFModel.Create(vIConexao);
  try
    lPrecoUFModel       := lPrecoUFModel.carregaClasse(pID);
    lPrecoUFModel.Acao  := tacAlterar;
    Result              := lPrecoUFModel;
  finally

  end;
end;

function TPrecoUFModel.carregaClasse(ID: String): TPrecoUFModel;
var
  lPrecoUFModel: TPrecoUFDao;
begin
  lPrecoUFModel := TPrecoUFDao.Create(vIConexao);
  try
    Result := lPrecoUFModel.carregaClasse(ID);
  finally
    lPrecoUFModel.Free;
  end;
end;

constructor TPrecoUFModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPrecoUFModel.Destroy;
begin

  inherited;
end;

function TPrecoUFModel.Excluir(pID: String): String;
begin
  self.FID    := pID;
  self.FAcao  := tacExcluir;
  Result      := self.Salvar;
end;

function TPrecoUFModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

procedure TPrecoUFModel.obterLista;
var
  lPrecoUFLista: TPrecoUFDao;
begin
  lPrecoUFLista := TPrecoUFDao.Create(vIConexao);

  try
    lPrecoUFLista.TotalRecords    := FTotalRecords;
    lPrecoUFLista.WhereView       := FWhereView;
    lPrecoUFLista.CountView       := FCountView;
    lPrecoUFLista.OrderView       := FOrderView;
    lPrecoUFLista.StartRecordView := FStartRecordView;
    lPrecoUFLista.LengthPageView  := FLengthPageView;
    lPrecoUFLista.IDRecordView    := FIDRecordView;

    lPrecoUFLista.obterLista;

    FTotalRecords  := lPrecoUFLista.TotalRecords;
    FPrecoUFsLista := lPrecoUFLista.PrecoUFsLista;

  finally
    lPrecoUFLista.Free;
  end;
end;

function TPrecoUFModel.Salvar: String;
var
  lPrecoUFDao: TPrecoUFDao;
begin
  lPrecoUFDao := TPrecoUFDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPrecoUFDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lPrecoUFDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lPrecoUFDao.excluir(Self);
    end;

  finally
    lPrecoUFDao.Free;
  end;
end;

procedure TPrecoUFModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPrecoUFModel.SetCOMISSAO(const Value: Variant);
begin
  FCOMISSAO := Value;
end;

procedure TPrecoUFModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPrecoUFModel.SetPrecoUFsLista;
begin
  FPrecoUFsLista := Value;
end;

procedure TPrecoUFModel.SetICMS_ST(const Value: Variant);
begin
  FICMS_ST := Value;
end;

procedure TPrecoUFModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPrecoUFModel.SetPRODUTO_ID(const Value: Variant);
begin
  FPRODUTO_ID := Value;
end;

procedure TPrecoUFModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPrecoUFModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPrecoUFModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoUFModel.SetSIMPLES(const Value: Variant);
begin
  FSIMPLES := Value;
end;

procedure TPrecoUFModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPrecoUFModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPrecoUFModel.SetTOTAL(const Value: Variant);
begin
  FTOTAL := Value;
end;

procedure TPrecoUFModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPrecoUFModel.SetUF(const Value: Variant);
begin
  FUF := Value;
end;

procedure TPrecoUFModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
