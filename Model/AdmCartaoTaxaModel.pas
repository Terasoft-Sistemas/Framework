unit AdmCartaoTaxaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TAdmCartaoTaxaModel   = class;
  ITAdmCartaoTaxaModel  = IObject<TAdmCartaoTaxaModel>;

  TAdmCartaoTaxaModel   = class
  private
    [unsafe] mySelf: ITAdmCartaoTaxaModel;
    vIConexao : IConexao;

    FAdmCartaoTaxasLista: IList<ITAdmCartaoTaxaModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FADM_ID: Variant;
    FTAXA: Variant;
    FID: Variant;
    FDIAS_VENCIMENTO: Variant;
    FSYSTIME: Variant;
    FCONCILIADORA_ID: Variant;
    FPARCELA: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetAdmCartaoTaxasLista(const Value: IList<ITAdmCartaoTaxaModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetADM_ID(const Value: Variant);
    procedure SetCONCILIADORA_ID(const Value: Variant);
    procedure SetDIAS_VENCIMENTO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetPARCELA(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAXA(const Value: Variant);
  public
    property ID: Variant read FID write SetID;
    property ADM_ID: Variant read FADM_ID write SetADM_ID;
    property PARCELA: Variant read FPARCELA write SetPARCELA;
    property TAXA: Variant read FTAXA write SetTAXA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property DIAS_VENCIMENTO: Variant read FDIAS_VENCIMENTO write SetDIAS_VENCIMENTO;
    property CONCILIADORA_ID: Variant read FCONCILIADORA_ID write SetCONCILIADORA_ID;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITAdmCartaoTaxaModel;

    function Incluir: String;
    function Alterar(pID : String): ITAdmCartaoTaxaModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId: String): ITAdmCartaoTaxaModel;
    procedure obterLista;

    property AdmCartaoTaxasLista: IList<ITAdmCartaoTaxaModel> read FAdmCartaoTaxasLista write SetAdmCartaoTaxasLista;
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
  AdmCartaoTaxaDao;

{ TAdmCartaoTaxaModel }

function TAdmCartaoTaxaModel.Alterar(pID: String): ITAdmCartaoTaxaModel;
var
  lAdmCartaoTaxaModel : ITAdmCartaoTaxaModel;
begin
  lAdmCartaoTaxaModel := TAdmCartaoTaxaModel.getNewIface(vIConexao);
  try
    lAdmCartaoTaxaModel       := lAdmCartaoTaxaModel.objeto.carregaClasse(pID);
    lAdmCartaoTaxaModel.objeto.Acao  := tacAlterar;
    Result                    := lAdmCartaoTaxaModel;
  finally
  end;
end;

function TAdmCartaoTaxaModel.Excluir(pID: String): String;
begin
  self.FID := pID;
  self.FAcao := tacExcluir;
  Result := self.Salvar;
end;

class function TAdmCartaoTaxaModel.getNewIface(pIConexao: IConexao): ITAdmCartaoTaxaModel;
begin
  Result := TImplObjetoOwner<TAdmCartaoTaxaModel>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TAdmCartaoTaxaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    self.Salvar;
end;

function TAdmCartaoTaxaModel.carregaClasse(pId: String): ITAdmCartaoTaxaModel;
var
  lAdmCartaoTaxaDao: ITAdmCartaoTaxaDao;
begin
  lAdmCartaoTaxaDao := TAdmCartaoTaxaDao.getNewIface(vIConexao);

  try
    Result := lAdmCartaoTaxaDao.objeto.carregaClasse(pId);
  finally
    lAdmCartaoTaxaDao := nil;
  end;
end;

constructor TAdmCartaoTaxaModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TAdmCartaoTaxaModel.Destroy;
begin
  FAdmCartaoTaxasLista := nil;
  vIConexao := nil;
  inherited;
end;

procedure TAdmCartaoTaxaModel.obterLista;
var
  lAdmCartaoTaxaLista: ITAdmCartaoTaxaDao;
begin
  lAdmCartaoTaxaLista := TAdmCartaoTaxaDao.getNewIface(vIConexao);

  try
    lAdmCartaoTaxaLista.objeto.TotalRecords    := FTotalRecords;
    lAdmCartaoTaxaLista.objeto.WhereView       := FWhereView;
    lAdmCartaoTaxaLista.objeto.CountView       := FCountView;
    lAdmCartaoTaxaLista.objeto.OrderView       := FOrderView;
    lAdmCartaoTaxaLista.objeto.StartRecordView := FStartRecordView;
    lAdmCartaoTaxaLista.objeto.LengthPageView  := FLengthPageView;
    lAdmCartaoTaxaLista.objeto.IDRecordView    := FIDRecordView;

    lAdmCartaoTaxaLista.objeto.obterLista;

    FTotalRecords  := lAdmCartaoTaxaLista.objeto.TotalRecords;
    FAdmCartaoTaxasLista := lAdmCartaoTaxaLista.objeto.AdmCartaoTaxasLista;

  finally
    lAdmCartaoTaxaLista := nil;
  end;
end;

function TAdmCartaoTaxaModel.Salvar: String;
var
  lAdmCartaoTaxaDao: ITAdmCartaoTaxaDao;
begin
  lAdmCartaoTaxaDao := TAdmCartaoTaxaDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lAdmCartaoTaxaDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lAdmCartaoTaxaDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lAdmCartaoTaxaDao.objeto.excluir(mySelf);
    end;

  finally
    lAdmCartaoTaxaDao := nil;
  end;
end;

procedure TAdmCartaoTaxaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TAdmCartaoTaxaModel.SetCONCILIADORA_ID(const Value: Variant);
begin
  FCONCILIADORA_ID := Value;
end;

procedure TAdmCartaoTaxaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAdmCartaoTaxaModel.SetDIAS_VENCIMENTO(const Value: Variant);
begin
  FDIAS_VENCIMENTO := Value;
end;

procedure TAdmCartaoTaxaModel.SetAdmCartaoTaxasLista;
begin
  FAdmCartaoTaxasLista := Value;
end;

procedure TAdmCartaoTaxaModel.SetADM_ID(const Value: Variant);
begin
  FADM_ID := Value;
end;

procedure TAdmCartaoTaxaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAdmCartaoTaxaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAdmCartaoTaxaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAdmCartaoTaxaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAdmCartaoTaxaModel.SetPARCELA(const Value: Variant);
begin
  FPARCELA := Value;
end;

procedure TAdmCartaoTaxaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAdmCartaoTaxaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TAdmCartaoTaxaModel.SetTAXA(const Value: Variant);
begin
  FTAXA := Value;
end;

procedure TAdmCartaoTaxaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAdmCartaoTaxaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
