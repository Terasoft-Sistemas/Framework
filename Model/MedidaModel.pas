unit MedidaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TMedidaModel = class

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
    FCODIGO_MED: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FDESCRICAO_MED: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO_MED(const Value: Variant);
    procedure SetDESCRICAO_MED(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);


    public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;



    property CODIGO_MED      :Variant read FCODIGO_MED write SetCODIGO_MED;
    property DESCRICAO_MED   :Variant read FDESCRICAO_MED write SetDESCRICAO_MED;
    property ID              :Variant read FID write SetID;
    property SYSTIME         :Variant read FSYSTIME write SetSYSTIME;
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
    function carregaClasse(pId : String): TMedidaModel;
    function Alterar(pID : String): TMedidaModel;
    function Excluir(pID : String): String;

    function ObterLista : TFDMemTable; overload;

  end;

implementation

uses
  System.SysUtils, MedidaDao;

{ TMedidaModel }

function TMedidaModel.Alterar(pID: String): TMedidaModel;
var
  lMedidaModel : TMedidaModel;
begin
  lMedidaModel := TMedidaModel.Create(vIConexao);
  try
    lMedidaModel       := lMedidaModel.carregaClasse(pID);
    lMedidaModel.Acao  := tacAlterar;
    Result            := lMedidaModel;
  finally
  end;
end;

function TMedidaModel.carregaClasse(pId: String): TMedidaModel;
var
  lMedidaModel: TMedidaModel;
begin
  lMedidaModel := TMedidaModel.Create(vIConexao);

  try
    Result := lMedidaModel.carregaClasse(pId);
  finally
    lMedidaModel.Free;
  end;
end;

constructor TMedidaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TMedidaModel.Destroy;
begin
  inherited;
end;

function TMedidaModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TMedidaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TMedidaModel.ObterLista: TFDMemTable;
var
  lMedida: TMedidaDao;
begin
  lMedida := TMedidaDao.Create(vIConexao);
  try
    lMedida.TotalRecords    := FTotalRecords;
    lMedida.WhereView       := FWhereView;
    lMedida.CountView       := FCountView;
    lMedida.OrderView       := FOrderView;
    lMedida.StartRecordView := FStartRecordView;
    lMedida.LengthPageView  := FLengthPageView;
    lMedida.IDRecordView    := FIDRecordView;

    Result := lMedida.obterLista;
    FTotalRecords := lMedida.TotalRecords;
  finally
    lMedida.Free;
  end;
end;

function TMedidaModel.Salvar: String;
var
  lMedidaDao: TMedidaDao;
begin
  lMedidaDao := TMedidaDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lMedidaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lMedidaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lMedidaDao.excluir(Self);
    end;
  finally
    lMedidaDao.Free;
  end;
end;


procedure TMedidaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TMedidaModel.SetCODIGO_MED(const Value: Variant);
begin
  FCODIGO_MED := Value;
end;

procedure TMedidaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMedidaModel.SetDESCRICAO_MED(const Value: Variant);
begin
  FDESCRICAO_MED := Value;
end;

procedure TMedidaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMedidaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TMedidaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMedidaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TMedidaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TMedidaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TMedidaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TMedidaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
