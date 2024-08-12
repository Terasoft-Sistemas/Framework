unit ProdutoTipoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TProdutoTipoModel = class;
  ITProdutoTipoModel=IObject<TProdutoTipoModel>;

  TProdutoTipoModel = class
  private
    [weak] mySelf: ITProdutoTipoModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCOTACAO: Variant;
    FUSA_PECA: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FNOME: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCOTACAO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUSA_PECA(const Value: Variant);

    public

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITProdutoTipoModel;

    property ID        :Variant read FID write SetID;
    property NOME      :Variant read FNOME write SetNOME;
    property USA_PECA  :Variant read FUSA_PECA write SetUSA_PECA;
    property COTACAO   :Variant read FCOTACAO write SetCOTACAO;
    property SYSTIME   :Variant read FSYSTIME write SetSYSTIME;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function Salvar : String;
    function Incluir: String;
    function carregaClasse(pId : String): ITProdutoTipoModel;
    function Alterar(pID : String): ITProdutoTipoModel;
    function Excluir(pID : String): String;
    function ObterLista : IFDDataset; overload;

  end;

implementation

uses
  System.SysUtils, ProdutoTipoDao;

{ TProdutoTipoModel }

function TProdutoTipoModel.Alterar(pID: String): ITProdutoTipoModel;
var
  lProdutoTipoModel : ITProdutoTipoModel;
begin
  lProdutoTipoModel := TProdutoTipoModel.getNewIface(vIConexao);
  try
    lProdutoTipoModel       := lProdutoTipoModel.objeto.carregaClasse(pID);
    lProdutoTipoModel.objeto.Acao  := tacAlterar;
    Result                  := lProdutoTipoModel;
  finally
  end;
end;

function TProdutoTipoModel.carregaClasse(pId: String): ITProdutoTipoModel;
var
  lProdutoTipoModel: ITProdutoTipoModel;
begin
  lProdutoTipoModel := TProdutoTipoModel.getNewIface(vIConexao);

  try
    Result := lProdutoTipoModel.objeto.carregaClasse(pId);
  finally
    lProdutoTipoModel:=nil;
  end;
end;

constructor TProdutoTipoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TProdutoTipoModel.Destroy;
begin
  inherited;
end;

function TProdutoTipoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TProdutoTipoModel.getNewIface(pIConexao: IConexao): ITProdutoTipoModel;
begin
  Result := TImplObjetoOwner<TProdutoTipoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TProdutoTipoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TProdutoTipoModel.ObterLista: IFDDataset;
var
  lProdutoTipo: ITProdutoTipoDao;
begin
  lProdutoTipo := TProdutoTipoDao.getNewIface(vIConexao);
  try
    lProdutoTipo.objeto.TotalRecords    := FTotalRecords;
    lProdutoTipo.objeto.WhereView       := FWhereView;
    lProdutoTipo.objeto.CountView       := FCountView;
    lProdutoTipo.objeto.OrderView       := FOrderView;
    lProdutoTipo.objeto.StartRecordView := FStartRecordView;
    lProdutoTipo.objeto.LengthPageView  := FLengthPageView;
    lProdutoTipo.objeto.IDRecordView    := FIDRecordView;

    Result := lProdutoTipo.objeto.obterLista;
    FTotalRecords := lProdutoTipo.objeto.TotalRecords;
  finally
    lProdutoTipo:=nil;
  end;
end;

function TProdutoTipoModel.Salvar: String;
var
  lProdutoTipoDao: ITProdutoTipoDao;
begin
  lProdutoTipoDao := TProdutoTipoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lProdutoTipoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lProdutoTipoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lProdutoTipoDao.objeto.excluir(mySelf);
    end;
  finally
    lProdutoTipoDao:=nil;
  end;
end;

procedure TProdutoTipoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TProdutoTipoModel.SetCOTACAO(const Value: Variant);
begin
  FCOTACAO := Value;
end;

procedure TProdutoTipoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TProdutoTipoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TProdutoTipoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TProdutoTipoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TProdutoTipoModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TProdutoTipoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TProdutoTipoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TProdutoTipoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TProdutoTipoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TProdutoTipoModel.SetUSA_PECA(const Value: Variant);
begin
  FUSA_PECA := Value;
end;

procedure TProdutoTipoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
