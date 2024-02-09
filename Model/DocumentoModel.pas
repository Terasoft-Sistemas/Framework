unit DocumentoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TDocumentoModel = class

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

    property ID       : Variant read FID write SetID;
    property NOME     : Variant read FNOME write SetNOME;
    property SYSTIME  : Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TDocumentoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TDocumentoModel;
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
  DocumentoDao,  
  System.Classes, 
  System.SysUtils;

{ TDocumentoModel }

function TDocumentoModel.Alterar(pID: String): TDocumentoModel;
var
  lDocumentoModel : TDocumentoModel;
begin
  lDocumentoModel := TDocumentoModel.Create(vIConexao);
  try
    lDocumentoModel       := lDocumentoModel.carregaClasse(pID);
    lDocumentoModel.Acao  := tacAlterar;
    Result                := lDocumentoModel;
  finally
  end;
end;

function TDocumentoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TDocumentoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TDocumentoModel.carregaClasse(pId : String): TDocumentoModel;
var
  lDocumentoDao: TDocumentoDao;
begin
  lDocumentoDao := TDocumentoDao.Create(vIConexao);

  try
    Result := lDocumentoDao.carregaClasse(pId);
  finally
    lDocumentoDao.Free;
  end;
end;

constructor TDocumentoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDocumentoModel.Destroy;
begin
  inherited;
end;

function TDocumentoModel.obterLista: TFDMemTable;
var
  lDocumentoLista: TDocumentoDao;
begin
  lDocumentoLista := TDocumentoDao.Create(vIConexao);

  try
    lDocumentoLista.TotalRecords    := FTotalRecords;
    lDocumentoLista.WhereView       := FWhereView;
    lDocumentoLista.CountView       := FCountView;
    lDocumentoLista.OrderView       := FOrderView;
    lDocumentoLista.StartRecordView := FStartRecordView;
    lDocumentoLista.LengthPageView  := FLengthPageView;
    lDocumentoLista.IDRecordView    := FIDRecordView;

    Result := lDocumentoLista.obterLista;

    FTotalRecords := lDocumentoLista.TotalRecords;

  finally
    lDocumentoLista.Free;
  end;
end;

function TDocumentoModel.Salvar: String;
var
  lDocumentoDao: TDocumentoDao;
begin
  lDocumentoDao := TDocumentoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lDocumentoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lDocumentoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lDocumentoDao.excluir(Self);
    end;
  finally
    lDocumentoDao.Free;
  end;
end;

procedure TDocumentoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TDocumentoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDocumentoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDocumentoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TDocumentoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDocumentoModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TDocumentoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TDocumentoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;


procedure TDocumentoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TDocumentoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TDocumentoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
