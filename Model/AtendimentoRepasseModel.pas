unit AtendimentoRepasseModel;

interface

uses
  Terasoft.types,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TAtendimentoRepasseModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVISUALIZAR_REPASSE: Variant;
    FSYSTIME: Variant;
    FUSUARIO_REPASSE_ID: Variant;
    FUSUARIO_ID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUSUARIO_ID(const Value: Variant);
    procedure SetUSUARIO_REPASSE_ID(const Value: Variant);
    procedure SetVISUALIZAR_REPASSE(const Value: Variant);

  public

	  property ID 					        : Variant read FID write SetID;
	  property USUARIO_ID 			    : Variant read FUSUARIO_ID write SetUSUARIO_ID;
	  property USUARIO_REPASSE_ID 	: Variant read FUSUARIO_REPASSE_ID write SetUSUARIO_REPASSE_ID;
	  property SYSTIME 				      : Variant read FSYSTIME write SetSYSTIME;
	  property VISUALIZAR_REPASSE 	: Variant read FVISUALIZAR_REPASSE write SetVISUALIZAR_REPASSE;

   	property Acao               : TAcao       read FAcao               write SetAcao;
    property TotalRecords       : Integer     read FTotalRecords       write SetTotalRecords;
    property WhereView          : String      read FWhereView          write SetWhereView;
    property CountView          : String      read FCountView          write SetCountView;
    property OrderView          : String      read FOrderView          write SetOrderView;
    property StartRecordView    : String      read FStartRecordView    write SetStartRecordView;
    property LengthPageView     : String      read FLengthPageView     write SetLengthPageView;
    property IDRecordView       : Integer     read FIDRecordView       write SetIDRecordView;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    function obterLista: TFDMemTable;

  end;

implementation

uses
  AtendimentoRepasseDao;

{ TAtendimentoRepasseModel }

constructor TAtendimentoRepasseModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TAtendimentoRepasseModel.Destroy;
begin

  inherited;
end;

function TAtendimentoRepasseModel.obterLista: TFDMemTable;
var
  lAtendimentoRepasseLista: TAtendimentoRepasseDao;
begin
  lAtendimentoRepasseLista := TAtendimentoRepasseDao.Create(vIConexao);
  try
    lAtendimentoRepasseLista.TotalRecords    := FTotalRecords;
    lAtendimentoRepasseLista.WhereView       := FWhereView;
    lAtendimentoRepasseLista.CountView       := FCountView;
    lAtendimentoRepasseLista.OrderView       := FOrderView;
    lAtendimentoRepasseLista.StartRecordView := FStartRecordView;
    lAtendimentoRepasseLista.LengthPageView  := FLengthPageView;
    lAtendimentoRepasseLista.IDRecordView    := FIDRecordView;

    Result        := lAtendimentoRepasseLista.obterLista;
    FTotalRecords := lAtendimentoRepasseLista.TotalRecords;
  finally
    lAtendimentoRepasseLista.Free;
  end;
end;

function TAtendimentoRepasseModel.Salvar: String;
var
  lAtendimentoRepasseDao: TAtendimentoRepasseDao;
begin
  lAtendimentoRepasseDao := TAtendimentoRepasseDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lAtendimentoRepasseDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lAtendimentoRepasseDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lAtendimentoRepasseDao.excluir(Self);
    end;

  finally
    lAtendimentoRepasseDao.Free;
  end;
end;

procedure TAtendimentoRepasseModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TAtendimentoRepasseModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAtendimentoRepasseModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAtendimentoRepasseModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAtendimentoRepasseModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAtendimentoRepasseModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAtendimentoRepasseModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAtendimentoRepasseModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TAtendimentoRepasseModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAtendimentoRepasseModel.SetUSUARIO_ID(const Value: Variant);
begin
  FUSUARIO_ID := Value;
end;

procedure TAtendimentoRepasseModel.SetUSUARIO_REPASSE_ID(const Value: Variant);
begin
  FUSUARIO_REPASSE_ID := Value;
end;

procedure TAtendimentoRepasseModel.SetVISUALIZAR_REPASSE(const Value: Variant);
begin
  FVISUALIZAR_REPASSE := Value;
end;

procedure TAtendimentoRepasseModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
