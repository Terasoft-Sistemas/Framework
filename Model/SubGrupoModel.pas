unit SubGrupoModel;

interface

uses

  Terasoft.Types,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TSubGrupoModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;

    FCODIGO_GRU: Variant;
    FDESTAQUE_PRE_VENDA: Variant;
    FUSUARIO_SUB: Variant;
    FNOME_SUB: Variant;
    FID: Variant;
    FIMAGEM: Variant;
    FSIGLA: Variant;
    FORDEM: Variant;
    FCODIGO_SUB: Variant;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO_GRU(const Value: Variant);
    procedure SetCODIGO_SUB(const Value: Variant);
    procedure SetDESTAQUE_PRE_VENDA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIMAGEM(const Value: Variant);
    procedure SetNOME_SUB(const Value: Variant);
    procedure SetORDEM(const Value: Variant);
    procedure SetSIGLA(const Value: Variant);
    procedure SetUSUARIO_SUB(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
  public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    property CODIGO_SUB         :Variant read FCODIGO_SUB write SetCODIGO_SUB;
    property NOME_SUB           :Variant read FNOME_SUB write SetNOME_SUB;
    property USUARIO_SUB        :Variant read FUSUARIO_SUB write SetUSUARIO_SUB;
    property CODIGO_GRU         :Variant read FCODIGO_GRU write SetCODIGO_GRU;
    property ID                 :Variant read FID write SetID;
    property SIGLA              :Variant read FSIGLA write SetSIGLA;
    property ORDEM              :Variant read FORDEM write SetORDEM;
    property IMAGEM             :Variant read FIMAGEM write SetIMAGEM;
    property DESTAQUE_PRE_VENDA :Variant read FDESTAQUE_PRE_VENDA write SetDESTAQUE_PRE_VENDA;

    function Salvar : String;
    function Incluir: String;
    function carregaClasse(pId : String): TSubGrupoModel;
    function Alterar(pID : String): TSubGrupoModel;
    function Excluir(pID : String): String;

    function ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): TFDMemTable; overload;
    function ObterLista: IFDDataset; overload;

  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  SubGrupoDao,
  GrupoModel;

{ TSubGrupoModel }

function TSubGrupoModel.Alterar(pID: String): TSubGrupoModel;
var
  lSubGrupoModel : TSubGrupoModel;
begin
  lSubGrupoModel := TSubGrupoModel.Create(vIConexao);
  try
    lSubGrupoModel       := lSubGrupoModel.carregaClasse(pID);
    lSubGrupoModel.Acao  := tacAlterar;
    Result               := lSubGrupoModel;
  finally
  end;
end;

function TSubGrupoModel.carregaClasse(pId: String): TSubGrupoModel;
var
  lSubGrupoModel: TSubGrupoModel;
begin
  lSubGrupoModel := TSubGrupoModel.Create(vIConexao);

  try
    Result := lSubGrupoModel.carregaClasse(pId);
  finally
    lSubGrupoModel.Free;
  end;
end;

constructor TSubGrupoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TSubGrupoModel.Destroy;
begin
  inherited;
end;

function TSubGrupoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TSubGrupoModel.Incluir: String;
var
  lGrupoModel : TGrupoModel;
begin
  lGrupoModel := TGrupoModel.Create(vIConexao);
  try
    lGrupoModel.StartRecordView := '0';
    lGrupoModel.LengthPageView  := '1';
    lGrupoModel.OrderView       := 'CODIGO_GRU';
    self.CODIGO_GRU := lGrupoModel.ObterLista.objeto.FieldByName('CODIGO_GRU').AsString;

    self.Acao := tacIncluir;
    Result    := self.Salvar;
  finally
    lGrupoModel.Free;
  end;
end;

function TSubGrupoModel.ObterLista: IFDDataset;
var
  lSubGrupo: TSubGrupoDao;
begin
  lSubGrupo := TSubGrupoDao.Create(vIConexao);
  try
    lSubGrupo.TotalRecords    := FTotalRecords;
    lSubGrupo.WhereView       := FWhereView;
    lSubGrupo.CountView       := FCountView;
    lSubGrupo.OrderView       := FOrderView;
    lSubGrupo.StartRecordView := FStartRecordView;
    lSubGrupo.LengthPageView  := FLengthPageView;
    lSubGrupo.IDRecordView    := FIDRecordView;

    Result := lSubGrupo.obterLista;
    FTotalRecords := lSubGrupo.TotalRecords;
  finally
    lSubGrupo.Free;
  end;
end;

function TSubGrupoModel.ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): TFDMemTable;
var
  lSubGrupoDao: TSubGrupoDao;
  lSubGrupo_Parametros: TSubGrupo_Parametros;
begin
  lSubGrupoDao := TSubGrupoDao.Create(vIConexao);

  try
    lSubGrupo_Parametros.SubGrupos := pSubGrupo_Parametros.SubGrupos;

    Result := lSubGrupoDao.ObterLista(lSubGrupo_Parametros);

  finally
    lSubGrupoDao.Free;
  end;
end;

function TSubGrupoModel.Salvar: String;
var
  lSubGrupoDao: TSubGrupoDao;
begin
  lSubGrupoDao := TSubGrupoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lSubGrupoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lSubGrupoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lSubGrupoDao.excluir(Self);
    end;
  finally
    lSubGrupoDao.Free;
  end;
end;

procedure TSubGrupoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TSubGrupoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSubGrupoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSubGrupoModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TSubGrupoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSubGrupoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TSubGrupoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TSubGrupoModel.SetSIGLA(const Value: Variant);
begin
  FSIGLA := Value;
end;

procedure TSubGrupoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TSubGrupoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TSubGrupoModel.SetCODIGO_GRU(const Value: Variant);
begin
  FCODIGO_GRU := Value;
end;

procedure TSubGrupoModel.SetCODIGO_SUB(const Value: Variant);
begin
  FCODIGO_SUB := Value;
end;

procedure TSubGrupoModel.SetDESTAQUE_PRE_VENDA(const Value: Variant);
begin
  FDESTAQUE_PRE_VENDA := Value;
end;

procedure TSubGrupoModel.SetIMAGEM(const Value: Variant);
begin
  FIMAGEM := Value;
end;

procedure TSubGrupoModel.SetNOME_SUB(const Value: Variant);
begin
  FNOME_SUB := Value;
end;

procedure TSubGrupoModel.SetORDEM(const Value: Variant);
begin
  FORDEM := Value;
end;

procedure TSubGrupoModel.SetUSUARIO_SUB(const Value: Variant);
begin
  FUSUARIO_SUB := Value;
end;

end.
