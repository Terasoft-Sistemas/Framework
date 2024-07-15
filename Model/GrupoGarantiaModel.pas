unit GrupoGarantiaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TGrupoGarantiaModel = class

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
    FID: Variant;
    FSYSTIME: Variant;
    FNOME: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);

  public

    property ID      : Variant read FID write SetID;
    property NOME    : Variant read FNOME write SetNOME;
    property SYSTIME : Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TGrupoGarantiaModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TGrupoGarantiaModel;
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
  GrupoGarantiaDao,  
  System.Classes, 
  System.SysUtils;

{ TGrupoGarantiaModel }

function TGrupoGarantiaModel.Alterar(pID: String): TGrupoGarantiaModel;
var
  lGrupoGarantiaModel : TGrupoGarantiaModel;
begin
  lGrupoGarantiaModel := TGrupoGarantiaModel.Create(vIConexao);
  try
    lGrupoGarantiaModel       := lGrupoGarantiaModel.carregaClasse(pID);
    lGrupoGarantiaModel.Acao  := tacAlterar;
    Result            	      := lGrupoGarantiaModel;
  finally
  end;
end;

function TGrupoGarantiaModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TGrupoGarantiaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TGrupoGarantiaModel.carregaClasse(pId : String): TGrupoGarantiaModel;
var
  lGrupoGarantiaDao: TGrupoGarantiaDao;
begin
  lGrupoGarantiaDao := TGrupoGarantiaDao.Create(vIConexao);

  try
    Result := lGrupoGarantiaDao.carregaClasse(pID);
  finally
    lGrupoGarantiaDao.Free;
  end;
end;

constructor TGrupoGarantiaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoGarantiaModel.Destroy;
begin
  inherited;
end;

function TGrupoGarantiaModel.obterLista: TFDMemTable;
var
  lGrupoGarantiaLista: TGrupoGarantiaDao;
begin
  lGrupoGarantiaLista := TGrupoGarantiaDao.Create(vIConexao);

  try
    lGrupoGarantiaLista.TotalRecords    := FTotalRecords;
    lGrupoGarantiaLista.WhereView       := FWhereView;
    lGrupoGarantiaLista.CountView       := FCountView;
    lGrupoGarantiaLista.OrderView       := FOrderView;
    lGrupoGarantiaLista.StartRecordView := FStartRecordView;
    lGrupoGarantiaLista.LengthPageView  := FLengthPageView;
    lGrupoGarantiaLista.IDRecordView    := FIDRecordView;

    Result := lGrupoGarantiaLista.obterLista;

    FTotalRecords := lGrupoGarantiaLista.TotalRecords;

  finally
    lGrupoGarantiaLista.Free;
  end;
end;

function TGrupoGarantiaModel.Salvar: String;
var
  lGrupoGarantiaDao: TGrupoGarantiaDao;
begin
  lGrupoGarantiaDao := TGrupoGarantiaDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lGrupoGarantiaDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lGrupoGarantiaDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lGrupoGarantiaDao.excluir(Self);
    end;
  finally
    lGrupoGarantiaDao.Free;
  end;
end;

procedure TGrupoGarantiaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TGrupoGarantiaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoGarantiaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoGarantiaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoGarantiaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoGarantiaModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TGrupoGarantiaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TGrupoGarantiaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TGrupoGarantiaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TGrupoGarantiaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TGrupoGarantiaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
