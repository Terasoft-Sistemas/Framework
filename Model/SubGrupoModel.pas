unit SubGrupoModel;

interface

uses

  Terasoft.Types,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TSubGrupoModel = class;
  ITSubGrupoModel=IObject<TSubGrupoModel>;

  TSubGrupoModel = class
  private
    [unsafe] mySelf: ITSubGrupoModel;
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

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITSubGrupoModel;

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
    function carregaClasse(pId : String): ITSubGrupoModel;
    function Alterar(pID : String): ITSubGrupoModel;
    function Excluir(pID : String): String;

    function ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): IFDDataset; overload;
    function ObterLista: IFDDataset; overload;

  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  SubGrupoDao,
  GrupoModel;

{ TSubGrupoModel }

function TSubGrupoModel.Alterar(pID: String): ITSubGrupoModel;
var
  lSubGrupoModel : ITSubGrupoModel;
begin
  lSubGrupoModel := TSubGrupoModel.getNewIface(vIConexao);
  try
    lSubGrupoModel       := lSubGrupoModel.objeto.carregaClasse(pID);
    lSubGrupoModel.objeto.Acao  := tacAlterar;
    Result               := lSubGrupoModel;
  finally
  end;
end;

function TSubGrupoModel.carregaClasse(pId: String): ITSubGrupoModel;
var
  lSubGrupoModel: ITSubGrupoModel;
begin
  lSubGrupoModel := TSubGrupoModel.getNewIface(vIConexao);

  try
    Result := lSubGrupoModel.objeto.carregaClasse(pId);
  finally
    lSubGrupoModel:=nil;
  end;
end;

constructor TSubGrupoModel._Create(pIConexao : IConexao);
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

class function TSubGrupoModel.getNewIface(pIConexao: IConexao): ITSubGrupoModel;
begin
  Result := TImplObjetoOwner<TSubGrupoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TSubGrupoModel.Incluir: String;
var
  lGrupoModel : ITGrupoModel;
begin
  lGrupoModel := TGrupoModel.getNewIface(vIConexao);
  try
    lGrupoModel.objeto.StartRecordView := '0';
    lGrupoModel.objeto.LengthPageView  := '1';
    lGrupoModel.objeto.OrderView       := 'CODIGO_GRU';
    self.CODIGO_GRU := lGrupoModel.objeto.ObterLista.objeto.FieldByName('CODIGO_GRU').AsString;

    self.Acao := tacIncluir;
    Result    := self.Salvar;
  finally
    lGrupoModel:=nil;
  end;
end;

function TSubGrupoModel.ObterLista: IFDDataset;
var
  lSubGrupo: ITSubGrupoDao;
begin
  lSubGrupo := TSubGrupoDao.getNewIface(vIConexao);
  try
    lSubGrupo.objeto.TotalRecords    := FTotalRecords;
    lSubGrupo.objeto.WhereView       := FWhereView;
    lSubGrupo.objeto.CountView       := FCountView;
    lSubGrupo.objeto.OrderView       := FOrderView;
    lSubGrupo.objeto.StartRecordView := FStartRecordView;
    lSubGrupo.objeto.LengthPageView  := FLengthPageView;
    lSubGrupo.objeto.IDRecordView    := FIDRecordView;

    Result := lSubGrupo.objeto.obterLista;
    FTotalRecords := lSubGrupo.objeto.TotalRecords;
  finally
    lSubGrupo:=nil;
  end;
end;

function TSubGrupoModel.ObterLista(pSubGrupo_Parametros: TSubGrupo_Parametros): IFDDataset;
var
  lSubGrupoDao: ITSubGrupoDao;
  lSubGrupo_Parametros: TSubGrupo_Parametros;
begin
  lSubGrupoDao := TSubGrupoDao.getNewIface(vIConexao);

  try
    lSubGrupo_Parametros.SubGrupos := pSubGrupo_Parametros.SubGrupos;

    Result := lSubGrupoDao.objeto.ObterLista(lSubGrupo_Parametros);

  finally
    lSubGrupoDao:=nil;
  end;
end;

function TSubGrupoModel.Salvar: String;
var
  lSubGrupoDao: ITSubGrupoDao;
begin
  lSubGrupoDao := TSubGrupoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lSubGrupoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lSubGrupoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lSubGrupoDao.objeto.excluir(mySelf);
    end;
  finally
    lSubGrupoDao:=nil;
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
