unit CreditoClienteUsoModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TCreditoClienteUsoModel = class;
  ITCreditoClienteUsoModel=IObject<TCreditoClienteUsoModel>;

  TCreditoClienteUsoModel = class
  private
    [weak] mySelf:ITCreditoClienteUsoModel;
    vIConexao : IConexao;
    FCreditoClienteUsosLista: IList<ITCreditoClienteUsoModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FLOCAL: Variant;
    FDATAHORA: Variant;
    FVALOR: Variant;
    FRECEBER_ID: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FUSUARIO_ID: Variant;
    FDATA: Variant;
    FPARCELA: Variant;
    FCREDITO_CLIENTE_ID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetCreditoClienteUsosLista(const Value: IList<ITCreditoClienteUsoModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCREDITO_CLIENTE_ID(const Value: Variant);
    procedure SetDATA(const Value: Variant);
    procedure SetDATAHORA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLOCAL(const Value: Variant);
    procedure SetPARCELA(const Value: Variant);
    procedure SetRECEBER_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUSUARIO_ID(const Value: Variant);
    procedure SetVALOR(const Value: Variant);
  public
    property ID: Variant read FID write SetID;
    property CREDITO_CLIENTE_ID: Variant read FCREDITO_CLIENTE_ID write SetCREDITO_CLIENTE_ID;
    property DATA: Variant read FDATA write SetDATA;
    property VALOR: Variant read FVALOR write SetVALOR;
    property PARCELA: Variant read FPARCELA write SetPARCELA;
    property RECEBER_ID: Variant read FRECEBER_ID write SetRECEBER_ID;
    property LOCAL: Variant read FLOCAL write SetLOCAL;
    property USUARIO_ID: Variant read FUSUARIO_ID write SetUSUARIO_ID;
    property DATAHORA: Variant read FDATAHORA write SetDATAHORA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCreditoClienteUsoModel;

    function Incluir : String;
    function Alterar(pID : String) : ITCreditoClienteUsoModel;
    function Excluir(pID : String) : String;
    function Salvar: String;
    function carregaClasse(pID : String) : ITCreditoClienteUsoModel;
    procedure obterLista;

    property CreditoClienteUsosLista: IList<ITCreditoClienteUsoModel> read FCreditoClienteUsosLista write SetCreditoClienteUsosLista;

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
  CreditoClienteUsoDao;

{ TCreditoClienteUsoModel }

function TCreditoClienteUsoModel.Alterar(pID: String): ITCreditoClienteUsoModel;
var
  lCreditoClienteUsoModel : ITCreditoClienteUsoModel;
begin
  lCreditoClienteUsoModel := TCreditoClienteUsoModel.getNewIface(vIConexao);
  try
    lCreditoClienteUsoModel      := lCreditoClienteUsoModel.objeto.carregaClasse(pID);
    lCreditoClienteUsoModel.objeto.Acao := tacAlterar;
    Result                       := lCreditoClienteUsoModel;
  finally

  end;
end;

function TCreditoClienteUsoModel.carregaClasse(pID: String): ITCreditoClienteUsoModel;
var
  lCreditoClienteUsoDao: ITCreditoClienteUsoDao;
begin

  lCreditoClienteUsoDao := TCreditoClienteUsoDao.getNewIface(vIConexao);
  try
    Result := lCreditoClienteUsoDao.objeto.carregaClasse(pId);
  finally
    lCreditoClienteUsoDao:=nil;
  end;
end;

constructor TCreditoClienteUsoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCreditoClienteUsoModel.Destroy;
begin
  FCreditoClienteUsosLista:=nil;
  vIConexao:=nil;
  inherited;
end;

function TCreditoClienteUsoModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TCreditoClienteUsoModel.getNewIface(pIConexao: IConexao): ITCreditoClienteUsoModel;
begin
  Result := TImplObjetoOwner<TCreditoClienteUsoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCreditoClienteUsoModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

procedure TCreditoClienteUsoModel.obterLista;
var
  lCreditoClienteUsoLista: ITCreditoClienteUsoDao;
begin
  lCreditoClienteUsoLista := TCreditoClienteUsoDao.getNewIface(vIConexao);

  try
    lCreditoClienteUsoLista.objeto.TotalRecords    := FTotalRecords;
    lCreditoClienteUsoLista.objeto.WhereView       := FWhereView;
    lCreditoClienteUsoLista.objeto.CountView       := FCountView;
    lCreditoClienteUsoLista.objeto.OrderView       := FOrderView;
    lCreditoClienteUsoLista.objeto.StartRecordView := FStartRecordView;
    lCreditoClienteUsoLista.objeto.LengthPageView  := FLengthPageView;
    lCreditoClienteUsoLista.objeto.IDRecordView    := FIDRecordView;

    lCreditoClienteUsoLista.objeto.obterLista;

    FTotalRecords  := lCreditoClienteUsoLista.objeto.TotalRecords;
    FCreditoClienteUsosLista := lCreditoClienteUsoLista.objeto.CreditoClienteUsosLista;

  finally
    lCreditoClienteUsoLista:=nil;
  end;
end;

function TCreditoClienteUsoModel.Salvar: String;
var
  lCreditoClienteUsoDao: ITCreditoClienteUsoDao;
begin
  lCreditoClienteUsoDao := TCreditoClienteUsoDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCreditoClienteUsoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lCreditoClienteUsoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lCreditoClienteUsoDao.objeto.excluir(mySelf);
    end;

  finally
    lCreditoClienteUsoDao:=nil;
  end;
end;

procedure TCreditoClienteUsoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TCreditoClienteUsoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCreditoClienteUsoModel.SetCreditoClienteUsosLista;
begin
  FCreditoClienteUsosLista := Value;
end;

procedure TCreditoClienteUsoModel.SetCREDITO_CLIENTE_ID(const Value: Variant);
begin
  FCREDITO_CLIENTE_ID := Value;
end;

procedure TCreditoClienteUsoModel.SetDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TCreditoClienteUsoModel.SetDATAHORA(const Value: Variant);
begin
  FDATAHORA := Value;
end;

procedure TCreditoClienteUsoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCreditoClienteUsoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCreditoClienteUsoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCreditoClienteUsoModel.SetLOCAL(const Value: Variant);
begin
  FLOCAL := Value;
end;

procedure TCreditoClienteUsoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCreditoClienteUsoModel.SetPARCELA(const Value: Variant);
begin
  FPARCELA := Value;
end;

procedure TCreditoClienteUsoModel.SetRECEBER_ID(const Value: Variant);
begin
  FRECEBER_ID := Value;
end;

procedure TCreditoClienteUsoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCreditoClienteUsoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TCreditoClienteUsoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCreditoClienteUsoModel.SetUSUARIO_ID(const Value: Variant);
begin
  FUSUARIO_ID := Value;
end;

procedure TCreditoClienteUsoModel.SetVALOR(const Value: Variant);
begin
  FVALOR := Value;
end;

procedure TCreditoClienteUsoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
