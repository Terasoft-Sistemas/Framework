unit GrupoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TGrupoModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    Fcodigo_gru: Variant;
    Fecf: Variant;
    Fcor: Variant;
    Fid_ecommerce: Variant;
    Ficms: Variant;
    Fdestaque_pre_venda: Variant;
    Farredondamento: Variant;
    Fredutor_icms_st: Variant;
    Fid: Variant;
    Fusuario_gru: Variant;
    Fnome_gru: Variant;
    Fstatus: Variant;
    Fmargerm_produto: Variant;
    Fimagem: Variant;
    Floja: Variant;
    Fsystime: Variant;
    Fsigla: Variant;
    Fmargem_imposto: Variant;
    Freferencia: Variant;
    Fordem: Variant;
    Fdescricao_ecommerce: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure Setarredondamento(const Value: Variant);
    procedure Setcodigo_gru(const Value: Variant);
    procedure Setcor(const Value: Variant);
    procedure Setdescricao_ecommerce(const Value: Variant);
    procedure Setdestaque_pre_venda(const Value: Variant);
    procedure Setecf(const Value: Variant);
    procedure Seticms(const Value: Variant);
    procedure Setid_ecommerce(const Value: Variant);
    procedure Setimagem(const Value: Variant);
    procedure Setloja(const Value: Variant);
    procedure Setmargem_imposto(const Value: Variant);
    procedure Setmargerm_produto(const Value: Variant);
    procedure Setnome_gru(const Value: Variant);
    procedure Setordem(const Value: Variant);
    procedure Setredutor_icms_st(const Value: Variant);
    procedure Setreferencia(const Value: Variant);
    procedure Setsigla(const Value: Variant);
    procedure Setstatus(const Value: Variant);
    procedure Setusuario_gru(const Value: Variant);
    procedure SetIDRecordview(const Value: String);
    procedure SetID(const Value: Variant);

  public

    property codigo_gru               :Variant read Fcodigo_gru write Setcodigo_gru;
    property nome_gru                 :Variant read Fnome_gru write Setnome_gru;
    property usuario_gru              :Variant read Fusuario_gru write Setusuario_gru;
    property loja                     :Variant read Floja write Setloja;
    property ecf                      :Variant read Fecf write Setecf;
    property icms                     :Variant read Ficms write Seticms;
    property redutor_icms_st          :Variant read Fredutor_icms_st write Setredutor_icms_st;
    property id                       :Variant read Fid write Setid;
    property arredondamento           :Variant read Farredondamento write Setarredondamento;
    property destaque_pre_venda       :Variant read Fdestaque_pre_venda write Setdestaque_pre_venda;
    property imagem                   :Variant read Fimagem write Setimagem;
    property sigla                    :Variant read Fsigla write Setsigla;
    property referencia               :Variant read Freferencia write Setreferencia;
    property cor                      :Variant read Fcor write Setcor;
    property ordem                    :Variant read Fordem write Setordem;
    property margem_imposto           :Variant read Fmargem_imposto write Setmargem_imposto;
    property margerm_produto          :Variant read Fmargerm_produto write Setmargerm_produto;
    property id_ecommerce             :Variant read Fid_ecommerce write Setid_ecommerce;
    property descricao_ecommerce      :Variant read Fdescricao_ecommerce write Setdescricao_ecommerce;
    property status                   :Variant read Fstatus write Setstatus;


  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pGrupo_Parametros: TGrupo_Parametros): IFDDataset; overload;
    function ObterLista: IFDDataset; overload;


    function Incluir: String;
    function Alterar(pID : String): TGrupoModel;
    function Excluir(CODIGO_GRU : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TGrupoModel;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordview : String read FIDRecordview write SetIDRecordview;
  end;

implementation

uses
  GrupoDao,
  System.Classes,
  System.SysUtils;

{ TGrupoModel }

function TGrupoModel.Alterar(pID: String): TGrupoModel;
var
  lGrupoModel : TGrupoModel;
begin
  lGrupoModel := TGrupoModel.Create(vIConexao);
  try
    lGrupoModel       := lGrupoModel.carregaClasse(pID);
    lGrupoModel.FAcao := tacAlterar;
    Result            := lGrupoModel;
  finally
  end;
end;
function TGrupoModel.carregaClasse(pId: String): TGrupoModel;
var
  lGrupoDao: TGrupoDao;
begin
  lGrupoDao := TGrupoDao.Create(vIConexao);

  try
    Result := lGrupoDao.carregaClasse(pId);
  finally
    lGrupoDao.Free;
  end;
end;

constructor TGrupoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoModel.Destroy;
begin

  inherited;
end;

function TGrupoModel.Excluir(CODIGO_GRU: String): String;
begin
  self.CODIGO_GRU   := CODIGO_GRU;
  self.FAcao        := tacExcluir;
  Result            := self.Salvar;
end;

function TGrupoModel.Incluir: String;
begin
    self.FAcao := tacIncluir;
    Result     := self.Salvar;
end;


function TGrupoModel.ObterLista: IFDDataset;
var
  lGrupoLista: TGrupoDao;
begin
  lGrupoLista := TGrupoDao.Create(vIConexao);

  try
    lGrupoLista.TotalRecords    := FTotalRecords;
    lGrupoLista.WhereView       := FWhereView;
    lGrupoLista.CountView       := FCountView;
    lGrupoLista.OrderView       := FOrderView;
    lGrupoLista.StartRecordView := FStartRecordView;
    lGrupoLista.LengthPageView  := FLengthPageView;
    lGrupoLista.IDRecordView    := FIDRecordView;

    Result := lGrupoLista.obterLista;

    FTotalRecords := lGrupoLista.TotalRecords;

  finally
    lGrupoLista.Free;
  end;
end;
function TGrupoModel.ObterLista(pGrupo_Parametros: TGrupo_Parametros): IFDDataset;
var
  lGrupoDao: TGrupoDao;
  lGrupo_Parametros: TGrupo_Parametros;
begin
  lGrupoDao := TGrupoDao.Create(vIConexao);
  try
    lGrupo_Parametros.Grupos := pGrupo_Parametros.Grupos;

    Result := lGrupoDao.ObterLista(lGrupo_Parametros);

  finally
    lGrupoDao.Free;
  end;
end;

function TGrupoModel.Salvar: String;
var
  lGrupoDao : TGrupoDao;
begin
  lGrupoDao := TGrupoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lGrupoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lGrupoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lGrupoDao.excluir(Self);
    end;
  finally
    lGrupoDao.Free;
  end;
end;

procedure TGrupoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TGrupoModel.Setarredondamento(const Value: Variant);
begin
  Farredondamento := Value;
end;

procedure TGrupoModel.Setcodigo_gru(const Value: Variant);
begin
  Fcodigo_gru := Value;
end;

procedure TGrupoModel.Setcor(const Value: Variant);
begin
  Fcor := Value;
end;

procedure TGrupoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoModel.Setdescricao_ecommerce(const Value: Variant);
begin
  Fdescricao_ecommerce := Value;
end;

procedure TGrupoModel.Setdestaque_pre_venda(const Value: Variant);
begin
  Fdestaque_pre_venda := Value;
end;

procedure TGrupoModel.Setecf(const Value: Variant);
begin
  Fecf := Value;
end;

procedure TGrupoModel.Seticms(const Value: Variant);
begin
  Ficms := Value;
end;

procedure TGrupoModel.SetID(const Value: Variant);
begin
  FID :=  Value;
end;

procedure TGrupoModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TGrupoModel.Setid_ecommerce(const Value: Variant);
begin
  Fid_ecommerce := Value;
end;

procedure TGrupoModel.Setimagem(const Value: Variant);
begin
  Fimagem := Value;
end;

procedure TGrupoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoModel.Setloja(const Value: Variant);
begin
  Floja := Value;
end;

procedure TGrupoModel.Setmargem_imposto(const Value: Variant);
begin
  Fmargem_imposto := Value;
end;

procedure TGrupoModel.Setmargerm_produto(const Value: Variant);
begin
  Fmargerm_produto := Value;
end;

procedure TGrupoModel.Setnome_gru(const Value: Variant);
begin
  Fnome_gru := Value;
end;

procedure TGrupoModel.Setordem(const Value: Variant);
begin
  Fordem := Value;
end;

procedure TGrupoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TGrupoModel.Setredutor_icms_st(const Value: Variant);
begin
  Fredutor_icms_st := Value;
end;

procedure TGrupoModel.Setreferencia(const Value: Variant);
begin
  Freferencia := Value;
end;

procedure TGrupoModel.Setsigla(const Value: Variant);
begin
  Fsigla := Value;
end;

procedure TGrupoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TGrupoModel.Setstatus(const Value: Variant);
begin
  Fstatus := Value;
end;

procedure TGrupoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TGrupoModel.Setusuario_gru(const Value: Variant);
begin
  Fusuario_gru := Value;
end;

procedure TGrupoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
