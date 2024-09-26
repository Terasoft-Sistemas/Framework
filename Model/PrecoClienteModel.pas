unit PrecoClienteModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TPrecoClienteModel = class;
  ITPrecoClienteModel=IObject<TPrecoClienteModel>;

  TPrecoClienteModel = class
  private
    [unsafe] mySelf: ITPrecoClienteModel;
    vIConexao : IConexao;
    FPrecoClientesLista: IList<ITPrecoClienteModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPRODUTO: Variant;
    FVALOR: Variant;
    FCLIENTE: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPrecoClientesLista(const Value: IList<ITPrecoClienteModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCLIENTE(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetPRODUTO(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR(const Value: Variant);
  public
    property PRODUTO: Variant read FPRODUTO write SetPRODUTO;
    property CLIENTE: Variant read FCLIENTE write SetCLIENTE;
    property VALOR: Variant read FVALOR write SetVALOR;
    property ID: Variant read FID write SetID;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPrecoClienteModel;

    function Incluir : String;
    function Excluir(pID : String) : String;
    function Salvar : String;
    procedure obterLista;

    property PrecoClientesLista: IList<ITPrecoClienteModel> read FPrecoClientesLista write SetPrecoClientesLista;
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
  PrecoClienteDao;

{ TPrecoClienteModel }

function TPrecoClienteModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TPrecoClienteModel.getNewIface(pIConexao: IConexao): ITPrecoClienteModel;
begin
  Result := TImplObjetoOwner<TPrecoClienteModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPrecoClienteModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

constructor TPrecoClienteModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPrecoClienteModel.Destroy;
begin
  FPrecoClientesLista:=nil;
  vIConexao:=nil;
  inherited;
end;

procedure TPrecoClienteModel.obterLista;
var
  lPrecoClienteLista: ITPrecoClienteDao;
begin
  lPrecoClienteLista := TPrecoClienteDao.getNewIface(vIConexao);

  try
    lPrecoClienteLista.objeto.TotalRecords    := FTotalRecords;
    lPrecoClienteLista.objeto.WhereView       := FWhereView;
    lPrecoClienteLista.objeto.CountView       := FCountView;
    lPrecoClienteLista.objeto.OrderView       := FOrderView;
    lPrecoClienteLista.objeto.StartRecordView := FStartRecordView;
    lPrecoClienteLista.objeto.LengthPageView  := FLengthPageView;
    lPrecoClienteLista.objeto.IDRecordView    := FIDRecordView;

    lPrecoClienteLista.objeto.obterLista;

    FTotalRecords  := lPrecoClienteLista.objeto.TotalRecords;
    FPrecoClientesLista := lPrecoClienteLista.objeto.PrecoClientesLista;

  finally
    lPrecoClienteLista:=nil;
  end;
end;

function TPrecoClienteModel.Salvar: String;
var
  lPrecoClienteDao: ITPrecoClienteDao;
begin
  lPrecoClienteDao := TPrecoClienteDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPrecoClienteDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lPrecoClienteDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lPrecoClienteDao.objeto.excluir(mySelf);
    end;

  finally
    lPrecoClienteDao:=nil;
  end;
end;

procedure TPrecoClienteModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPrecoClienteModel.SetCLIENTE(const Value: Variant);
begin
  FCLIENTE := Value;
end;

procedure TPrecoClienteModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPrecoClienteModel.SetPrecoClientesLista;
begin
  FPrecoClientesLista := Value;
end;

procedure TPrecoClienteModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPrecoClienteModel.SetPRODUTO(const Value: Variant);
begin
  FPRODUTO := Value;
end;

procedure TPrecoClienteModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPrecoClienteModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPrecoClienteModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoClienteModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPrecoClienteModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPrecoClienteModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPrecoClienteModel.SetVALOR(const Value: Variant);
begin
  FVALOR := Value;
end;

procedure TPrecoClienteModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
