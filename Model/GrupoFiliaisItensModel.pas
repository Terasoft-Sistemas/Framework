unit GrupoFiliaisItensModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TGrupoFiliaisItensModel = class;
  ITGrupoFiliaisItensModel=IObject<TGrupoFiliaisItensModel>;

  TGrupoFiliaisItensModel = class
  private
    [weak] mySelf: ITGrupoFiliaisItensModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FREGISTRO_ID: Variant;
    FTABELA: Variant;
    FID: Variant;
    FDOCUMENTO_ID: Variant;
    FSYSTIME: Variant;
    FDESCRICAO: Variant;
    FDATA_CADASTRO: Variant;
    FGRUPO_LOJA_ID: Variant;
    FLOJA: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetDATA_CADASTRO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetGRUPO_LOJA_ID(const Value: Variant);
    procedure SetLOJA(const Value: Variant);

  public

    property ID               : Variant read FID write SetID;
    property GRUPO_FILIAIS_ID : Variant read FGRUPO_LOJA_ID write SetGRUPO_LOJA_ID;
    property LOJA             : Variant read FLOJA write SetLOJA;
    property DATA_CADASTRO    : Variant read FDATA_CADASTRO write SetDATA_CADASTRO;
    propertY SYSTIME          : Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITGrupoFiliaisItensModel;

    function Incluir: String;
    function Alterar(pID : String): ITGrupoFiliaisItensModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITGrupoFiliaisItensModel;
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
  GrupoFiliaisItensDao,  
  System.Classes, 
  System.SysUtils;

{ TGrupoFiliaisItensModel }

function TGrupoFiliaisItensModel.Alterar(pID: String): ITGrupoFiliaisItensModel;
var
  lGrupoFiliaisItensModel : ITGrupoFiliaisItensModel;
begin
  lGrupoFiliaisItensModel := TGrupoFiliaisItensModel.getNewIface(vIConexao);
  try
    lGrupoFiliaisItensModel             := lGrupoFiliaisItensModel.objeto.carregaClasse(pID);
    lGrupoFiliaisItensModel.objeto.Acao := tacAlterar;
    Result            	                := lGrupoFiliaisItensModel;
  finally
  end;
end;

function TGrupoFiliaisItensModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TGrupoFiliaisItensModel.getNewIface(pIConexao: IConexao): ITGrupoFiliaisItensModel;
begin
  Result := TImplObjetoOwner<TGrupoFiliaisItensModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TGrupoFiliaisItensModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TGrupoFiliaisItensModel.carregaClasse(pId : String): ITGrupoFiliaisItensModel;
var
  lGrupoFiliaisItensDao: ITGrupoFiliaisItensDao;
begin
  lGrupoFiliaisItensDao := TGrupoFiliaisItensDao.getNewIface(vIConexao);

  try
    Result := lGrupoFiliaisItensDao.objeto.carregaClasse(pID);
  finally
    lGrupoFiliaisItensDao:=nil;
  end;
end;

constructor TGrupoFiliaisItensModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoFiliaisItensModel.Destroy;
begin
  inherited;
end;

function TGrupoFiliaisItensModel.obterLista: IFDDataset;
var
  lGrupoFiliaisItensLista: ITGrupoFiliaisItensDao;
begin
  lGrupoFiliaisItensLista := TGrupoFiliaisItensDao.getNewIface(vIConexao);

  try
    lGrupoFiliaisItensLista.objeto.TotalRecords    := FTotalRecords;
    lGrupoFiliaisItensLista.objeto.WhereView       := FWhereView;
    lGrupoFiliaisItensLista.objeto.CountView       := FCountView;
    lGrupoFiliaisItensLista.objeto.OrderView       := FOrderView;
    lGrupoFiliaisItensLista.objeto.StartRecordView := FStartRecordView;
    lGrupoFiliaisItensLista.objeto.LengthPageView  := FLengthPageView;
    lGrupoFiliaisItensLista.objeto.IDRecordView    := FIDRecordView;

    Result := lGrupoFiliaisItensLista.objeto.obterLista;

    FTotalRecords := lGrupoFiliaisItensLista.objeto.TotalRecords;

  finally
    lGrupoFiliaisItensLista:=nil;
  end;
end;

function TGrupoFiliaisItensModel.Salvar: String;
var
  lGrupoFiliaisItensDao: ITGrupoFiliaisItensDao;
begin
  lGrupoFiliaisItensDao := TGrupoFiliaisItensDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lGrupoFiliaisItensDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lGrupoFiliaisItensDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lGrupoFiliaisItensDao.objeto.excluir(mySelf);
    end;
  finally
    lGrupoFiliaisItensDao:=nil;
  end;
end;

procedure TGrupoFiliaisItensModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TGrupoFiliaisItensModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoFiliaisItensModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;

procedure TGrupoFiliaisItensModel.SetGRUPO_LOJA_ID(const Value: Variant);
begin
  FGRUPO_LOJA_ID := Value;
end;

procedure TGrupoFiliaisItensModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoFiliaisItensModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoFiliaisItensModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoFiliaisItensModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TGrupoFiliaisItensModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TGrupoFiliaisItensModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TGrupoFiliaisItensModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TGrupoFiliaisItensModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TGrupoFiliaisItensModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
