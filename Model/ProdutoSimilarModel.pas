unit ProdutoSimilarModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TProdutoSimilarModel = class;
  ITProdutoSimilarModel=IObject<TProdutoSimilarModel>;

  TProdutoSimilarModel = class
  private
    [unsafe] mySelf: ITProdutoSimilarModel;
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
    FPRODUTO_ID: Variant;
    FACESSORIO: Variant;
    FSYSTIME: Variant;
    FPRODUTO_SIMILAR_ID: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetACESSORIO(const Value: Variant);
    procedure SetPRODUTO_ID(const Value: Variant);
    procedure SetPRODUTO_SIMILAR_ID(const Value: Variant);

  public

    property ID : Variant read FID write SetID;
    property PRODUTO_ID : Variant read FPRODUTO_ID write SetPRODUTO_ID;
    property PRODUTO_SIMILAR_ID : Variant read FPRODUTO_SIMILAR_ID write SetPRODUTO_SIMILAR_ID;
    property ACESSORIO : Variant read FACESSORIO write SetACESSORIO;
    property SYSTIME : Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITProdutoSimilarModel;

    function Incluir: String;
    function Alterar(pID : String): ITProdutoSimilarModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pID : String): ITProdutoSimilarModel;
    function obterLista: IFDDataset;
    function ConsultaProdutosSimilar(pProduto: String): IFDDataset;
    function VerificarProduto(pProduto, pSimilar : String) : String;

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
  ProdutoSimilarDao,
  System.Classes,
  System.SysUtils;

{ TProdutoSimilarModel }

function TProdutoSimilarModel.Alterar(pID: String): ITProdutoSimilarModel;
var
  lProdutoSimilarModel : ITProdutoSimilarModel;
begin
  lProdutoSimilarModel := TProdutoSimilarModel.getNewIface(vIConexao);
  try
    lProdutoSimilarModel      		   := lProdutoSimilarModel.objeto.carregaClasse(pID);
    lProdutoSimilarModel.objeto.Acao := tacAlterar;
    Result            				       := lProdutoSimilarModel;
  finally

  end;
end;

function TProdutoSimilarModel.Excluir(pID: String): String;
begin
  self.ID    := pID;
  self.FAcao := tacExcluir;
  Result     := self.Salvar;
end;

class function TProdutoSimilarModel.getNewIface(pIConexao: IConexao): ITProdutoSimilarModel;
begin
  Result := TImplObjetoOwner<TProdutoSimilarModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TProdutoSimilarModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TProdutoSimilarModel.carregaClasse(pId : String): ITProdutoSimilarModel;
var
  lProdutoSimilarDao: ITProdutoSimilarDao;
begin
  lProdutoSimilarDao := TProdutoSimilarDao.getNewIface(vIConexao);
  try
    Result := lProdutoSimilarDao.objeto.carregaClasse(pID);
  finally
    lProdutoSimilarDao:=nil;
  end;
end;

function TProdutoSimilarModel.ConsultaProdutosSimilar(pProduto: String): IFDDataset;
var
  lProdutoSimilarDao: ITProdutoSimilarDao;
begin
  lProdutoSimilarDao := TProdutoSimilarDao.getNewIface(vIConexao);
  try
    Result := lProdutoSimilarDao.objeto.ConsultaProdutosSimilar(pProduto);
  finally
    lProdutoSimilarDao:=nil;
  end;
end;

constructor TProdutoSimilarModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TProdutoSimilarModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TProdutoSimilarModel.VerificarProduto(pProduto, pSimilar: String): String;
var
  lProdutoSimilar: ITProdutoSimilarDao;
begin
  lProdutoSimilar := TProdutoSimilarDao.getNewIface(vIConexao);
  try
    Result := lProdutoSimilar.objeto.VerificarProduto(pProduto, pSimilar);
  finally
    lProdutoSimilar:=nil;
  end;
end;

function TProdutoSimilarModel.obterLista: IFDDataset;
var
  lProdutoSimilar: ITProdutoSimilarDao;
begin
  lProdutoSimilar := TProdutoSimilarDao.getNewIface(vIConexao);

  try
    lProdutoSimilar.objeto.TotalRecords    := FTotalRecords;
    lProdutoSimilar.objeto.WhereView       := FWhereView;
    lProdutoSimilar.objeto.CountView       := FCountView;
    lProdutoSimilar.objeto.OrderView       := FOrderView;
    lProdutoSimilar.objeto.StartRecordView := FStartRecordView;
    lProdutoSimilar.objeto.LengthPageView  := FLengthPageView;
    lProdutoSimilar.objeto.IDRecordView    := FIDRecordView;

    Result := lProdutoSimilar.objeto.obterLista;

    FTotalRecords := lProdutoSimilar.objeto.TotalRecords;

  finally
    lProdutoSimilar:=nil;
  end;
end;

function TProdutoSimilarModel.Salvar: String;
var
  lProdutoSimilarDao: ITProdutoSimilarDao;
begin
  lProdutoSimilarDao := TProdutoSimilarDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lProdutoSimilarDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lProdutoSimilarDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lProdutoSimilarDao.objeto.excluir(mySelf);
    end;
  finally
    lProdutoSimilarDao:=nil;
  end;
end;

procedure TProdutoSimilarModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TProdutoSimilarModel.SetACESSORIO(const Value: Variant);
begin
  FACESSORIO := Value;
end;

procedure TProdutoSimilarModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TProdutoSimilarModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TProdutoSimilarModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TProdutoSimilarModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TProdutoSimilarModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TProdutoSimilarModel.SetPRODUTO_ID(const Value: Variant);
begin
  FPRODUTO_ID := Value;
end;

procedure TProdutoSimilarModel.SetPRODUTO_SIMILAR_ID(const Value: Variant);
begin
  FPRODUTO_SIMILAR_ID := Value;
end;

procedure TProdutoSimilarModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TProdutoSimilarModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TProdutoSimilarModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TProdutoSimilarModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
