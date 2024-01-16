unit FuncionarioModel;

interface

uses
  Terasoft.Enumerado,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TFuncionarioModel = class

  private
    vIConexao : IConexao;
    FFuncionariosLista: TObjectList<TFuncionarioModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FTIPO_COMISSAO: Variant;
    FGERENTE_ID: Variant;
    FIDRecordView: String;
    FCODIGO_FUN: Variant;
    FNOME_FUN: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetFuncionariosLista(const Value: TObjectList<TFuncionarioModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetGERENTE_ID(const Value: Variant);
    procedure SetTIPO_COMISSAO(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetCODIGO_FUN(const Value: Variant);
    procedure SetNOME_FUN(const Value: Variant);

  public
    property GERENTE_ID: Variant read FGERENTE_ID write SetGERENTE_ID;
    property TIPO_COMISSAO: Variant read FTIPO_COMISSAO write SetTIPO_COMISSAO;
    property CODIGO_FUN: Variant read FCODIGO_FUN write SetCODIGO_FUN;
    property NOME_FUN: Variant read FNOME_FUN write SetNOME_FUN;

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;

    function comissaoVendedor(pIdVendedor, pIdTipoVenda : String): Double;

    property FuncionariosLista: TObjectList<TFuncionarioModel> read FFuncionariosLista write SetFuncionariosLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
  end;

implementation

uses
  FuncionarioDao;

{ TFuncionarioModel }

function TFuncionarioModel.comissaoVendedor(pIdVendedor, pIdTipoVenda: String): Double;
var
  lFuncionarioDao: TFuncionarioDao;
begin

  lFuncionarioDao := TFuncionarioDao.Create;

  try
    Result := lFuncionarioDao.comissaoVendedor(pIdVendedor, pIdTipoVenda);
  finally
    lFuncionarioDao.Free;
  end;

end;

constructor TFuncionarioModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFuncionarioModel.Destroy;
begin

  inherited;
end;

procedure TFuncionarioModel.obterLista;
var
  lFuncionarioLista: TFuncionarioDao;
begin
  lFuncionarioLista := TFuncionarioDao.Create;

  try
    lFuncionarioLista.TotalRecords    := FTotalRecords;
    lFuncionarioLista.WhereView       := FWhereView;
    lFuncionarioLista.CountView       := FCountView;
    lFuncionarioLista.OrderView       := FOrderView;
    lFuncionarioLista.StartRecordView := FStartRecordView;
    lFuncionarioLista.LengthPageView  := FLengthPageView;
    lFuncionarioLista.IDRecordView    := FIDRecordView;

    lFuncionarioLista.obterLista;

    FTotalRecords  := lFuncionarioLista.TotalRecords;
    FFuncionariosLista := lFuncionarioLista.FuncionariosLista;

  finally
    lFuncionarioLista.Free;
  end;
end;

function TFuncionarioModel.Salvar: String;
var
  lFuncionarioDao: TFuncionarioDao;
begin
  lFuncionarioDao := TFuncionarioDao.Create;

  Result := '';

  try

  finally
    lFuncionarioDao.Free;
  end;
end;

procedure TFuncionarioModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TFuncionarioModel.SetCODIGO_FUN(const Value: Variant);
begin
  FCODIGO_FUN := Value;
end;

procedure TFuncionarioModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFuncionarioModel.SetFuncionariosLista(const Value: TObjectList<TFuncionarioModel>);
begin
  FFuncionariosLista := Value;
end;

procedure TFuncionarioModel.SetGERENTE_ID(const Value: Variant);
begin
  FGERENTE_ID := Value;
end;

procedure TFuncionarioModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TFuncionarioModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFuncionarioModel.SetNOME_FUN(const Value: Variant);
begin
  FNOME_FUN := Value;
end;

procedure TFuncionarioModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFuncionarioModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFuncionarioModel.SetTIPO_COMISSAO(const Value: Variant);
begin
  FTIPO_COMISSAO := Value;
end;

procedure TFuncionarioModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFuncionarioModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
