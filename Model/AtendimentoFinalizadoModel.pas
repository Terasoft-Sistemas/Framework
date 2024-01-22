unit AtendimentoFinalizadoModel;

interface

uses
  Terasoft.Enumerado,
  FireDAC.Comp.Client;

type
  TAtendimentoFinalizadoModel = class

  private
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FATENDIMENTO_ID: Variant;
    FDATAHORA_FINALIZADO: Variant;
    FDATAHORA_INCLUSAO: Variant;
    FID: Variant;
    FSTATUS: Variant;
    FSYSTIME: Variant;
    FUSUARIO_ID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetATENDIMENTO_ID(const Value: Variant);
    procedure SetDATAHORA_FINALIZADO(const Value: Variant);
    procedure SetDATAHORA_INCLUSAO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUSUARIO_ID(const Value: Variant);

  public
    property ID                       : Variant read FID                   write SetID;
    property ATENDIMENTO_ID           : Variant read FATENDIMENTO_ID       write SetATENDIMENTO_ID;
    property USUARIO_ID               : Variant read FUSUARIO_ID           write SetUSUARIO_ID;
    property STATUS                   : Variant read FSTATUS               write SetSTATUS;
    property DATAHORA_INCLUSAO        : Variant read FDATAHORA_INCLUSAO    write SetDATAHORA_INCLUSAO;
    property DATAHORA_FINALIZADO      : Variant read FDATAHORA_FINALIZADO  write SetDATAHORA_FINALIZADO;
    property SYSTIME                  : Variant read FSYSTIME              write SetSYSTIME;

	  property Acao               : TAcao       read FAcao               write SetAcao;
    property TotalRecords       : Integer     read FTotalRecords       write SetTotalRecords;
    property WhereView          : String      read FWhereView          write SetWhereView;
    property CountView          : String      read FCountView          write SetCountView;
    property OrderView          : String      read FOrderView          write SetOrderView;
    property StartRecordView    : String      read FStartRecordView    write SetStartRecordView;
    property LengthPageView     : String      read FLengthPageView     write SetLengthPageView;
    property IDRecordView       : Integer     read FIDRecordView       write SetIDRecordView;

  	constructor Create;
    destructor Destroy; override;

    function Salvar: String;
    function obterLista: TFDMemTable;

  end;

implementation

uses
  AtendimentoFinalizadoDao;

{ TAtendimentoFinalizadoModel }

constructor TAtendimentoFinalizadoModel.Create;
begin

end;

destructor TAtendimentoFinalizadoModel.Destroy;
begin

  inherited;
end;

function TAtendimentoFinalizadoModel.obterLista: TFDMemTable;
var
  lAtendimentoFinalizadoLista: TAtendimentoFinalizadoDao;
begin
  lAtendimentoFinalizadoLista := TAtendimentoFinalizadoDao.Create;
  try
    lAtendimentoFinalizadoLista.TotalRecords    := FTotalRecords;
    lAtendimentoFinalizadoLista.WhereView       := FWhereView;
    lAtendimentoFinalizadoLista.CountView       := FCountView;
    lAtendimentoFinalizadoLista.OrderView       := FOrderView;
    lAtendimentoFinalizadoLista.StartRecordView := FStartRecordView;
    lAtendimentoFinalizadoLista.LengthPageView  := FLengthPageView;
    lAtendimentoFinalizadoLista.IDRecordView    := FIDRecordView;

    Result        := lAtendimentoFinalizadoLista.obterLista;
    FTotalRecords := lAtendimentoFinalizadoLista.TotalRecords;
  finally
    lAtendimentoFinalizadoLista.Free;
  end;
end;

function TAtendimentoFinalizadoModel.Salvar: String;
var
  lAtendimentoFinalizadoDao: TAtendimentoFinalizadoDao;
begin
  lAtendimentoFinalizadoDao := TAtendimentoFinalizadoDao.Create;

  Result := '';

  try
    case FAcao of
      Terasoft.Enumerado.tacIncluir: Result := lAtendimentoFinalizadoDao.incluir(Self);
      Terasoft.Enumerado.tacAlterar: Result := lAtendimentoFinalizadoDao.alterar(Self);
      Terasoft.Enumerado.tacExcluir: Result := lAtendimentoFinalizadoDao.excluir(Self);
    end;

  finally
    lAtendimentoFinalizadoDao.Free;
  end;
end;

procedure TAtendimentoFinalizadoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TAtendimentoFinalizadoModel.SetATENDIMENTO_ID(const Value: Variant);
begin
  FATENDIMENTO_ID := Value;
end;

procedure TAtendimentoFinalizadoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAtendimentoFinalizadoModel.SetDATAHORA_FINALIZADO(
  const Value: Variant);
begin
  FDATAHORA_FINALIZADO := Value;
end;

procedure TAtendimentoFinalizadoModel.SetDATAHORA_INCLUSAO(
  const Value: Variant);
begin
  FDATAHORA_INCLUSAO := Value;
end;

procedure TAtendimentoFinalizadoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAtendimentoFinalizadoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAtendimentoFinalizadoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAtendimentoFinalizadoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAtendimentoFinalizadoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAtendimentoFinalizadoModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TAtendimentoFinalizadoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TAtendimentoFinalizadoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAtendimentoFinalizadoModel.SetUSUARIO_ID(const Value: Variant);
begin
  FUSUARIO_ID := Value;
end;

procedure TAtendimentoFinalizadoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
