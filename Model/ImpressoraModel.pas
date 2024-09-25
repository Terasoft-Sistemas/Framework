unit ImpressoraModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TImpressoraModel = class;
  ITImpressoraModel=IObject<TImpressoraModel>;

  TImpressoraModel = class
  private
    [unsafe] mySelf: ITImpressoraModel;
    vIConexao : IConexao;
    FImpressorasLista: IList<ITImpressoraModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCORPO: Variant;
    FCAMINHO: Variant;
    FCABECALHO: Variant;
    FMODELO: Variant;
    FCORTE: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FRODAPE: Variant;
    FPORTA: Variant;
    FDIRETA: Variant;
    FNOME: Variant;
    FLISTA_IMPRESSAO: Variant;
    FVIAS: Variant;
    FRECIBO: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetImpressorasLista(const Value: IList<ITImpressoraModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCABECALHO(const Value: Variant);
    procedure SetCAMINHO(const Value: Variant);
    procedure SetCORPO(const Value: Variant);
    procedure SetCORTE(const Value: Variant);
    procedure SetDIRETA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLISTA_IMPRESSAO(const Value: Variant);
    procedure SetMODELO(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetPORTA(const Value: Variant);
    procedure SetRODAPE(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVIAS(const Value: Variant);
    procedure SetRECIBO(const Value: Variant);

  public
    property ID: Variant read FID write SetID;
    property NOME: Variant read FNOME write SetNOME;
    property CAMINHO: Variant read FCAMINHO write SetCAMINHO;
    property VIAS: Variant read FVIAS write SetVIAS;
    property DIRETA: Variant read FDIRETA write SetDIRETA;
    property LISTA_IMPRESSAO: Variant read FLISTA_IMPRESSAO write SetLISTA_IMPRESSAO;
    property CORTE: Variant read FCORTE write SetCORTE;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property CABECALHO: Variant read FCABECALHO write SetCABECALHO;
    property CORPO: Variant read FCORPO write SetCORPO;
    property RODAPE: Variant read FRODAPE write SetRODAPE;
    property PORTA: Variant read FPORTA write SetPORTA;
    property MODELO: Variant read FMODELO write SetMODELO;
    property RECIBO: Variant read FRECIBO write SetRECIBO;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITImpressoraModel;

    function Salvar: String;
    procedure obterLista;
    function carregaClasse(pId: Integer): ITImpressoraModel;

    property ImpressorasLista: IList<ITImpressoraModel> read FImpressorasLista write SetImpressorasLista;
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
  ImpressoraDao;

{ TImpressoraModel }

function TImpressoraModel.carregaClasse(pId: Integer): ITImpressoraModel;
var
  lImpressoraDao: ITImpressoraDao;
begin
  lImpressoraDao := TImpressoraDao.getNewIface(vIConexao);
  try
    Result := lImpressoraDao.objeto.carregaClasse(pId);
  finally
    lImpressoraDao:=nil;
  end;
end;

constructor TImpressoraModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TImpressoraModel.Destroy;
begin
  FImpressorasLista:=nil;
  vIConexao:=nil;
  inherited;
end;

class function TImpressoraModel.getNewIface(pIConexao: IConexao): ITImpressoraModel;
begin
  Result := TImplObjetoOwner<TImpressoraModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TImpressoraModel.obterLista;
var
  lImpressoraLista: ITImpressoraDao;
begin
  lImpressoraLista := TImpressoraDao.getNewIface(vIConexao);

  try
    lImpressoraLista.objeto.TotalRecords    := FTotalRecords;
    lImpressoraLista.objeto.WhereView       := FWhereView;
    lImpressoraLista.objeto.CountView       := FCountView;
    lImpressoraLista.objeto.OrderView       := FOrderView;
    lImpressoraLista.objeto.StartRecordView := FStartRecordView;
    lImpressoraLista.objeto.LengthPageView  := FLengthPageView;
    lImpressoraLista.objeto.IDRecordView    := FIDRecordView;

    lImpressoraLista.objeto.obterLista;

    FTotalRecords  := lImpressoraLista.objeto.TotalRecords;
    FImpressorasLista := lImpressoraLista.objeto.ImpressorasLista;

  finally
    lImpressoraLista:=nil;
  end;
end;

function TImpressoraModel.Salvar: String;
var
  lImpressoraDao: ITImpressoraDao;
begin
  lImpressoraDao := TImpressoraDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lImpressoraDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lImpressoraDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lImpressoraDao.objeto.excluir(mySelf);
    end;

  finally
    lImpressoraDao:=nil;
  end;
end;

procedure TImpressoraModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TImpressoraModel.SetCABECALHO(const Value: Variant);
begin
  FCABECALHO := Value;
end;

procedure TImpressoraModel.SetCAMINHO(const Value: Variant);
begin
  FCAMINHO := Value;
end;

procedure TImpressoraModel.SetCORPO(const Value: Variant);
begin
  FCORPO := Value;
end;

procedure TImpressoraModel.SetCORTE(const Value: Variant);
begin
  FCORTE := Value;
end;

procedure TImpressoraModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TImpressoraModel.SetDIRETA(const Value: Variant);
begin
  FDIRETA := Value;
end;

procedure TImpressoraModel.SetImpressorasLista;
begin
  FImpressorasLista := Value;
end;

procedure TImpressoraModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TImpressoraModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TImpressoraModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TImpressoraModel.SetLISTA_IMPRESSAO(const Value: Variant);
begin
  FLISTA_IMPRESSAO := Value;
end;

procedure TImpressoraModel.SetMODELO(const Value: Variant);
begin
  FMODELO := Value;
end;

procedure TImpressoraModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TImpressoraModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TImpressoraModel.SetPORTA(const Value: Variant);
begin
  FPORTA := Value;
end;

procedure TImpressoraModel.SetRECIBO(const Value: Variant);
begin
  FRECIBO := Value;
end;

procedure TImpressoraModel.SetRODAPE(const Value: Variant);
begin
  FRODAPE := Value;
end;

procedure TImpressoraModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TImpressoraModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TImpressoraModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TImpressoraModel.SetVIAS(const Value: Variant);
begin
  FVIAS := Value;
end;

procedure TImpressoraModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
