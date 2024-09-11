unit GrupoFiliaisModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TGrupoFiliaisModel = class;
  ITGrupoFiliaisModel=IObject<TGrupoFiliaisModel>;

  TGrupoFiliaisModel = class
  private
    [weak] mySelf: ITGrupoFiliaisModel;
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
    FDESCRICAO: Variant;
    FDATA_CADASTRO: Variant;
    FSTATUS: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);

  public

    property ID             : Variant read FID write SetID;
    property DESCRICAO      : Variant read FDESCRICAO write SetDESCRICAO;
    property DATA_CADASTRO  : Variant read FDATA_CADASTRO write SetDATA_CADASTRO;
    property SYSTIME        : Variant read FSYSTIME write SetSYSTIME;
    property STATUS         : Variant read FSTATUS write SetSTATUS;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITGrupoFiliaisModel;

    function Incluir: String;
    function Alterar(pID : String): ITGrupoFiliaisModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITGrupoFiliaisModel;
    function obterLista: IFDDataset;

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
  GrupoFiliaisDao,  
  System.Classes, 
  System.SysUtils;

{ TGrupoFiliaisModel }

function TGrupoFiliaisModel.Alterar(pID: String): ITGrupoFiliaisModel;
var
  lGrupoFiliaisModel : ITGrupoFiliaisModel;
begin
  lGrupoFiliaisModel := TGrupoFiliaisModel.getNewIface(vIConexao);
  try
    lGrupoFiliaisModel       		:= lGrupoFiliaisModel.objeto.carregaClasse(pID);
    lGrupoFiliaisModel.objeto.Acao  := tacAlterar;
    Result            	   		    := lGrupoFiliaisModel;
  finally
  end;
end;

function TGrupoFiliaisModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TGrupoFiliaisModel.getNewIface(pIConexao: IConexao): ITGrupoFiliaisModel;
begin
  Result := TImplObjetoOwner<TGrupoFiliaisModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TGrupoFiliaisModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TGrupoFiliaisModel.carregaClasse(pId : String): ITGrupoFiliaisModel;
var
  lGrupoFiliaisDao: ITGrupoFiliaisDao;
begin
  lGrupoFiliaisDao := TGrupoFiliaisDao.getNewIface(vIConexao);

  try
    Result := lGrupoFiliaisDao.objeto.carregaClasse(pID);
  finally
    lGrupoFiliaisDao:=nil;
  end;
end;

constructor TGrupoFiliaisModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoFiliaisModel.Destroy;
begin
  inherited;
end;

function TGrupoFiliaisModel.obterLista: IFDDataset;
var
  lGrupoFiliaisLista: ITGrupoFiliaisDao;
begin
  lGrupoFiliaisLista := TGrupoFiliaisDao.getNewIface(vIConexao);

  try
    lGrupoFiliaisLista.objeto.TotalRecords    := FTotalRecords;
    lGrupoFiliaisLista.objeto.WhereView       := FWhereView;
    lGrupoFiliaisLista.objeto.CountView       := FCountView;
    lGrupoFiliaisLista.objeto.OrderView       := FOrderView;
    lGrupoFiliaisLista.objeto.StartRecordView := FStartRecordView;
    lGrupoFiliaisLista.objeto.LengthPageView  := FLengthPageView;
    lGrupoFiliaisLista.objeto.IDRecordView    := FIDRecordView;

    Result := lGrupoFiliaisLista.objeto.obterLista;

    FTotalRecords := lGrupoFiliaisLista.objeto.TotalRecords;

  finally
    lGrupoFiliaisLista := nil;
  end;
end;

function TGrupoFiliaisModel.Salvar: String;
var
  lGrupoFiliaisDao: ITGrupoFiliaisDao;
begin
  lGrupoFiliaisDao := TGrupoFiliaisDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lGrupoFiliaisDao.objeto.incluir(MySelf);
      Terasoft.Types.tacAlterar: Result := lGrupoFiliaisDao.objeto.alterar(MySelf);
      Terasoft.Types.tacExcluir: Result := lGrupoFiliaisDao.objeto.excluir(MySelf);
    end;
  finally
    lGrupoFiliaisDao:=nil;
  end;
end;

procedure TGrupoFiliaisModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TGrupoFiliaisModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoFiliaisModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;

procedure TGrupoFiliaisModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TGrupoFiliaisModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoFiliaisModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoFiliaisModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoFiliaisModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TGrupoFiliaisModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TGrupoFiliaisModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TGrupoFiliaisModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TGrupoFiliaisModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TGrupoFiliaisModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
