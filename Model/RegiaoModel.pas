unit RegiaoModel;

interface

uses
  Terasoft.Enumerado,
  FireDAC.Comp.Client;

type
  TRegiaoModel = class

  private
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FDESCRICAO: Variant;
    FID: Variant;
    FSTATUS: Variant;
    FSYSTIME: Variant;
    FTAXA_ENTREGA: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAXA_ENTREGA(const Value: Variant);
        
  public

    property ID                 : Variant read FID            write SetID;
    property DESCRICAO          : Variant read FDESCRICAO     write SetDESCRICAO;
    property TAXA_ENTREGA       : Variant read FTAXA_ENTREGA  write SetTAXA_ENTREGA;
    property STATUS             : Variant read FSTATUS        write SetSTATUS;
    property SYSTIME            : Variant read FSYSTIME       write SetSYSTIME;

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
  RegiaoDao;

{ TRegiaoModel }

constructor TRegiaoModel.Create;
begin

end;

destructor TRegiaoModel.Destroy;
begin

  inherited;
end;

function TRegiaoModel.obterLista: TFDMemTable;
var
  lRegiaoLista: TRegiaoDao;
begin
  lRegiaoLista := TRegiaoDao.Create;
  try
    lRegiaoLista.TotalRecords    := FTotalRecords;
    lRegiaoLista.WhereView       := FWhereView;
    lRegiaoLista.CountView       := FCountView;
    lRegiaoLista.OrderView       := FOrderView;
    lRegiaoLista.StartRecordView := FStartRecordView;
    lRegiaoLista.LengthPageView  := FLengthPageView;
    lRegiaoLista.IDRecordView    := FIDRecordView;

    Result        := lRegiaoLista.obterLista;
    FTotalRecords := lRegiaoLista.TotalRecords;
  finally
    lRegiaoLista.Free;
  end;
end;

function TRegiaoModel.Salvar: String;
var
  lRegiaoDao: TRegiaoDao;
begin
  lRegiaoDao := TRegiaoDao.Create;

  Result := '';

  try
    case FAcao of
      Terasoft.Enumerado.tacIncluir: Result := lRegiaoDao.incluir(Self);
      Terasoft.Enumerado.tacAlterar: Result := lRegiaoDao.alterar(Self);
      Terasoft.Enumerado.tacExcluir: Result := lRegiaoDao.excluir(Self);
    end;

  finally
    lRegiaoDao.Free;
  end;
end;

procedure TRegiaoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TRegiaoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TRegiaoModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TRegiaoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TRegiaoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TRegiaoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TRegiaoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TRegiaoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TRegiaoModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TRegiaoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TRegiaoModel.SetTAXA_ENTREGA(const Value: Variant);
begin
  FTAXA_ENTREGA := Value;
end;

procedure TRegiaoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TRegiaoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
