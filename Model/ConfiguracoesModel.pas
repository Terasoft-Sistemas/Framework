unit ConfiguracoesModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TConfiguracoesModel = class

  private
    vIConexao : IConexao;

    FConfiguracoessLista: TObjectList<TConfiguracoesModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVALORSTRING: Variant;
    FVALORDATA: Variant;
    FVALORMEMO: Variant;
    FVALORDATAHORA: Variant;
    FVALORHORA: Variant;
    FF_ID: Variant;
    FVALORCHAR: Variant;
    FID: Variant;
    FVALORINTEIRO: Variant;
    FPERFIL_ID: Variant;
    FTAG: Variant;
    FSYSTIME: Variant;
    FVALORNUMERICO: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetConfiguracoessLista(const Value: TObjectList<TConfiguracoesModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetF_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetPERFIL_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAG(const Value: Variant);
    procedure SetVALORCHAR(const Value: Variant);
    procedure SetVALORDATA(const Value: Variant);
    procedure SetVALORDATAHORA(const Value: Variant);
    procedure SetVALORHORA(const Value: Variant);
    procedure SetVALORINTEIRO(const Value: Variant);
    procedure SetVALORMEMO(const Value: Variant);
    procedure SetVALORNUMERICO(const Value: Variant);
    procedure SetVALORSTRING(const Value: Variant);
  public
    property ID: Variant read FID write SetID;
    property TAG: Variant read FTAG write SetTAG;
    property F_ID: Variant read FF_ID write SetF_ID;
    property PERFIL_ID: Variant read FPERFIL_ID write SetPERFIL_ID;
    property VALORINTEIRO: Variant read FVALORINTEIRO write SetVALORINTEIRO;
    property VALORSTRING: Variant read FVALORSTRING write SetVALORSTRING;
    property VALORMEMO: Variant read FVALORMEMO write SetVALORMEMO;
    property VALORNUMERICO: Variant read FVALORNUMERICO write SetVALORNUMERICO;
    property VALORCHAR: Variant read FVALORCHAR write SetVALORCHAR;
    property VALORDATA: Variant read FVALORDATA write SetVALORDATA;
    property VALORHORA: Variant read FVALORHORA write SetVALORHORA;
    property VALORDATAHORA: Variant read FVALORDATAHORA write SetVALORDATAHORA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;

    property ConfiguracoessLista: TObjectList<TConfiguracoesModel> read FConfiguracoessLista write SetConfiguracoessLista;
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
  ConfiguracoesDao;

{ TConfiguracoesModel }

constructor TConfiguracoesModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TConfiguracoesModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

procedure TConfiguracoesModel.obterLista;
var
  lConfiguracoesLista: TConfiguracoesDao;
begin
  lConfiguracoesLista := TConfiguracoesDao.Create(vIConexao);

  try
    lConfiguracoesLista.TotalRecords    := FTotalRecords;
    lConfiguracoesLista.WhereView       := FWhereView;
    lConfiguracoesLista.CountView       := FCountView;
    lConfiguracoesLista.OrderView       := FOrderView;
    lConfiguracoesLista.StartRecordView := FStartRecordView;
    lConfiguracoesLista.LengthPageView  := FLengthPageView;
    lConfiguracoesLista.IDRecordView    := FIDRecordView;

    lConfiguracoesLista.obterLista;

    FTotalRecords := lConfiguracoesLista.TotalRecords;
    FConfiguracoessLista := lConfiguracoesLista.ConfiguracoessLista;

  finally
    lConfiguracoesLista.Free;
  end;
end;

function TConfiguracoesModel.Salvar: String;
var
  lConfiguracoesDao: TConfiguracoesDao;
begin
  lConfiguracoesDao := TConfiguracoesDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lConfiguracoesDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lConfiguracoesDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lConfiguracoesDao.excluir(Self);
    end;

  finally
    lConfiguracoesDao.Free;
  end;
end;

procedure TConfiguracoesModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TConfiguracoesModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TConfiguracoesModel.SetF_ID(const Value: Variant);
begin
  FF_ID := Value;
end;

procedure TConfiguracoesModel.SetConfiguracoessLista(const Value: TObjectList<TConfiguracoesModel>);
begin
  FConfiguracoessLista := Value;
end;

procedure TConfiguracoesModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TConfiguracoesModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TConfiguracoesModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TConfiguracoesModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TConfiguracoesModel.SetPERFIL_ID(const Value: Variant);
begin
  FPERFIL_ID := Value;
end;

procedure TConfiguracoesModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TConfiguracoesModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TConfiguracoesModel.SetTAG(const Value: Variant);
begin
  FTAG := Value;
end;

procedure TConfiguracoesModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TConfiguracoesModel.SetVALORCHAR(const Value: Variant);
begin
  FVALORCHAR := Value;
end;

procedure TConfiguracoesModel.SetVALORDATA(const Value: Variant);
begin
  FVALORDATA := Value;
end;

procedure TConfiguracoesModel.SetVALORDATAHORA(const Value: Variant);
begin
  FVALORDATAHORA := Value;
end;

procedure TConfiguracoesModel.SetVALORHORA(const Value: Variant);
begin
  FVALORHORA := Value;
end;

procedure TConfiguracoesModel.SetVALORINTEIRO(const Value: Variant);
begin
  FVALORINTEIRO := Value;
end;

procedure TConfiguracoesModel.SetVALORMEMO(const Value: Variant);
begin
  FVALORMEMO := Value;
end;

procedure TConfiguracoesModel.SetVALORNUMERICO(const Value: Variant);
begin
  FVALORNUMERICO := Value;
end;

procedure TConfiguracoesModel.SetVALORSTRING(const Value: Variant);
begin
  FVALORSTRING := Value;
end;

procedure TConfiguracoesModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
