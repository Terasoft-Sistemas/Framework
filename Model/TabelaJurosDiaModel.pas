unit TabelaJurosDiaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TTabelaJurosDiaModel = class

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
    FPORTADOR_ID: Variant;
    FINDICE: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FDIA: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetINDICE(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetDIA(const Value: Variant);

  public

    property ID          : Variant read FID write SetID;
    property DIA         : Variant read FDIA write SetDIA;
    property INDICE      : Variant read FINDICE write SetINDICE;
    property PORTADOR_ID : Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property SYSTIME     : Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TTabelaJurosDiaModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TTabelaJurosDiaModel;
    function obterLista: IFDDataset;
    function obterIndice (pDia, pPortador_id : String) : Double;

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
  TabelaJurosDiaDao,  
  System.Classes, 
  System.SysUtils;

{ TTabelaJurosDiaModel }

function TTabelaJurosDiaModel.Alterar(pID: String): TTabelaJurosDiaModel;
var
  lTabelaJurosDiaModel : TTabelaJurosDiaModel;
begin
  lTabelaJurosDiaModel := TTabelaJurosDiaModel.Create(vIConexao);
  try
    lTabelaJurosDiaModel       := lTabelaJurosDiaModel.carregaClasse(pID);
    lTabelaJurosDiaModel.Acao  := tacAlterar;
    Result            	       := lTabelaJurosDiaModel;
  finally
  end;
end;

function TTabelaJurosDiaModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TTabelaJurosDiaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TTabelaJurosDiaModel.carregaClasse(pId : String): TTabelaJurosDiaModel;
var
  lTabelaJurosDiaDao: TTabelaJurosDiaDao;
begin
  lTabelaJurosDiaDao := TTabelaJurosDiaDao.Create(vIConexao);

  try
    Result := lTabelaJurosDiaDao.carregaClasse(pID);
  finally
    lTabelaJurosDiaDao.Free;
  end;
end;

constructor TTabelaJurosDiaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTabelaJurosDiaModel.Destroy;
begin
  inherited;
end;

function TTabelaJurosDiaModel.obterIndice(pDia, pPortador_id: String): Double;
var
  lTabelaJurosDia: TTabelaJurosDiaDao;
begin
  lTabelaJurosDia := TTabelaJurosDiaDao.Create(vIConexao);
  try
    lTabelaJurosDia.WhereView := 'and tabelajuros_dia.dia = '+pDia+' and tabelajuros_dia.portador_id = '+pPortador_id+' ';
    result := lTabelaJurosDia.obterLista.objeto.FieldByName('INDICE').AsFloat;
  finally
    lTabelaJurosDia.Free;
  end;
end;

function TTabelaJurosDiaModel.obterLista: IFDDataset;
var
  lTabelaJurosDiaLista: TTabelaJurosDiaDao;
begin
  lTabelaJurosDiaLista := TTabelaJurosDiaDao.Create(vIConexao);

  try
    lTabelaJurosDiaLista.TotalRecords    := FTotalRecords;
    lTabelaJurosDiaLista.WhereView       := FWhereView;
    lTabelaJurosDiaLista.CountView       := FCountView;
    lTabelaJurosDiaLista.OrderView       := FOrderView;
    lTabelaJurosDiaLista.StartRecordView := FStartRecordView;
    lTabelaJurosDiaLista.LengthPageView  := FLengthPageView;
    lTabelaJurosDiaLista.IDRecordView    := FIDRecordView;

    Result := lTabelaJurosDiaLista.obterLista;

    FTotalRecords := lTabelaJurosDiaLista.TotalRecords;

  finally
    lTabelaJurosDiaLista.Free;
  end;
end;

function TTabelaJurosDiaModel.Salvar: String;
var
  lTabelaJurosDiaDao: TTabelaJurosDiaDao;
begin
  lTabelaJurosDiaDao := TTabelaJurosDiaDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lTabelaJurosDiaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lTabelaJurosDiaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lTabelaJurosDiaDao.excluir(Self);
    end;
  finally
    lTabelaJurosDiaDao.Free;
  end;
end;

procedure TTabelaJurosDiaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TTabelaJurosDiaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosDiaModel.SetDIA(const Value: Variant);
begin
  FDIA := Value;
end;

procedure TTabelaJurosDiaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosDiaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosDiaModel.SetINDICE(const Value: Variant);
begin
  FINDICE := Value;
end;

procedure TTabelaJurosDiaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosDiaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TTabelaJurosDiaModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TTabelaJurosDiaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TTabelaJurosDiaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TTabelaJurosDiaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TTabelaJurosDiaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
