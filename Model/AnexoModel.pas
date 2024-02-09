unit AnexoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TAnexoModel = class

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
    FREGISTRO_ID: Variant;
    FTABELA: Variant;
    FID: Variant;
    FDOCUMENTO_ID: Variant;
    FSYSTIME: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetDOCUMENTO_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetREGISTRO_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTABELA(const Value: Variant);

  public

    property ID             : Variant read FID write SetID;
    property TABELA         : Variant read FTABELA write SetTABELA;
    property REGISTRO_ID    : Variant read FREGISTRO_ID write SetREGISTRO_ID;
    property DOCUMENTO_ID   : Variant read FDOCUMENTO_ID write SetDOCUMENTO_ID;
    property SYSTIME        : Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TAnexoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TAnexoModel;
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
  AnexoDao,  
  System.Classes, 
  System.SysUtils;

{ TAnexoModel }

function TAnexoModel.Alterar(pID: String): TAnexoModel;
var
  lAnexoModel : TAnexoModel;
begin
  lAnexoModel := TAnexoModel.Create(vIConexao);
  try
    lAnexoModel       := lAnexoModel.carregaClasse(pID);
    lAnexoModel.Acao  := tacAlterar;
    Result            := lAnexoModel;
  finally
  end;
end;

function TAnexoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TAnexoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TAnexoModel.carregaClasse(pId : String): TAnexoModel;
var
  lAnexoDao: TAnexoDao;
begin
  lAnexoDao := TAnexoDao.Create(vIConexao);

  try
    Result := lAnexoDao.carregaClasse(pId);
  finally
    lAnexoDao.Free;
  end;
end;

constructor TAnexoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TAnexoModel.Destroy;
begin
  inherited;
end;

function TAnexoModel.obterLista: TFDMemTable;
var
  lAnexoLista: TAnexoDao;
begin
  lAnexoLista := TAnexoDao.Create(vIConexao);

  try
    lAnexoLista.TotalRecords    := FTotalRecords;
    lAnexoLista.WhereView       := FWhereView;
    lAnexoLista.CountView       := FCountView;
    lAnexoLista.OrderView       := FOrderView;
    lAnexoLista.StartRecordView := FStartRecordView;
    lAnexoLista.LengthPageView  := FLengthPageView;
    lAnexoLista.IDRecordView    := FIDRecordView;

    Result := lAnexoLista.obterLista;

    FTotalRecords := lAnexoLista.TotalRecords;

  finally
    lAnexoLista.Free;
  end;
end;

function TAnexoModel.Salvar: String;
var
  lAnexoDao: TAnexoDao;
begin
  lAnexoDao := TAnexoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lAnexoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lAnexoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lAnexoDao.excluir(Self);
    end;
  finally
    lAnexoDao.Free;
  end;
end;

procedure TAnexoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TAnexoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAnexoModel.SetDOCUMENTO_ID(const Value: Variant);
begin
  FDOCUMENTO_ID := Value;
end;

procedure TAnexoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAnexoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAnexoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAnexoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TAnexoModel.SetREGISTRO_ID(const Value: Variant);
begin
  FREGISTRO_ID := Value;
end;

procedure TAnexoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;


procedure TAnexoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TAnexoModel.SetTABELA(const Value: Variant);
begin
  FTABELA := Value;
end;

procedure TAnexoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TAnexoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
