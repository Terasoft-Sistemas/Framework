unit MedidaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TMedidaModel = class;
  ITMedidaModel=IObject<TMedidaModel>;

  TMedidaModel = class
  private
    [weak] mySelf: ITMedidaModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCODIGO_MED: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FDESCRICAO_MED: Variant;
    FIDRecordView: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO_MED(const Value: Variant);
    procedure SetDESCRICAO_MED(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetIDRecordView(const Value: String);


    public

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITMedidaModel;

    property CODIGO_MED      : Variant read FCODIGO_MED write SetCODIGO_MED;
    property DESCRICAO_MED   : Variant read FDESCRICAO_MED write SetDESCRICAO_MED;
    property ID              : Variant read FID write SetID;
    property SYSTIME         : Variant read FSYSTIME write SetSYSTIME;
    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function Salvar : String;
    function Incluir: String;
    function carregaClasse(pId : String): ITMedidaModel;
    function Alterar(pID : String): ITMedidaModel;
    function Excluir(pID : String): String;

    function ObterLista : IFDDataset; overload;

  end;

implementation

uses
  System.SysUtils, MedidaDao;

{ TMedidaModel }

function TMedidaModel.Alterar(pID: String): ITMedidaModel;
var
  lMedidaModel : ITMedidaModel;
begin
  lMedidaModel := TMedidaModel.getNewIface(vIConexao);
  try
    lMedidaModel       := lMedidaModel.objeto.carregaClasse(pID);
    lMedidaModel.objeto.Acao  := tacAlterar;
    Result            := lMedidaModel;
  finally
  end;
end;

function TMedidaModel.carregaClasse(pId: String): ITMedidaModel;
var
  lMedidaModel: ITMedidaModel;
begin
  lMedidaModel := TMedidaModel.getNewIface(vIConexao);

  try
    Result := lMedidaModel.objeto.carregaClasse(pId);
  finally
    lMedidaModel:=nil;
  end;
end;

constructor TMedidaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TMedidaModel.Destroy;
begin
  inherited;
end;

function TMedidaModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TMedidaModel.getNewIface(pIConexao: IConexao): ITMedidaModel;
begin
  Result := TImplObjetoOwner<TMedidaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TMedidaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TMedidaModel.ObterLista: IFDDataset;
var
  lMedida: ITMedidaDao;
begin
  lMedida := TMedidaDao.getNewIface(vIConexao);
  try
    lMedida.objeto.TotalRecords    := FTotalRecords;
    lMedida.objeto.WhereView       := FWhereView;
    lMedida.objeto.CountView       := FCountView;
    lMedida.objeto.OrderView       := FOrderView;
    lMedida.objeto.StartRecordView := FStartRecordView;
    lMedida.objeto.LengthPageView  := FLengthPageView;
    lMedida.objeto.IDRecordView    := FIDRecordView;

    Result := lMedida.objeto.obterLista;
    FTotalRecords := lMedida.objeto.TotalRecords;
  finally
    lMedida:=nil;
  end;
end;

function TMedidaModel.Salvar: String;
var
  lMedidaDao: ITMedidaDao;
begin
  lMedidaDao := TMedidaDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lMedidaDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lMedidaDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lMedidaDao.objeto.excluir(mySelf);
    end;
  finally
    lMedidaDao:=nil;
  end;
end;

procedure TMedidaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TMedidaModel.SetCODIGO_MED(const Value: Variant);
begin
  FCODIGO_MED := Value;
end;

procedure TMedidaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMedidaModel.SetDESCRICAO_MED(const Value: Variant);
begin
  FDESCRICAO_MED := Value;
end;

procedure TMedidaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMedidaModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TMedidaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMedidaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TMedidaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TMedidaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TMedidaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TMedidaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
