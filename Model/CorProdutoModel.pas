unit CorProdutoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TCorProdutoModel = class;
  ITCorProdutoModel=IObject<TCorProdutoModel>;

  TCorProdutoModel = class
  private
    [weak] mySelf: ITCorProdutoModel;
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

  public

    property ID             : Variant read FID write SetID;
    property DESCRICAO      : Variant read FDESCRICAO write SetDESCRICAO;
    property DATA_CADASTRO  : Variant read FDATA_CADASTRO write SetDATA_CADASTRO;
    propertY SYSTIME        : Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCorProdutoModel;

    function Incluir: String;
    function Alterar(pID : String): ITCorProdutoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITCorProdutoModel;
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
  CorProdutoDao,  
  System.Classes, 
  System.SysUtils;

{ TCorProdutoModel }

function TCorProdutoModel.Alterar(pID: String): ITCorProdutoModel;
var
  lCorProdutoModel : ITCorProdutoModel;
begin
  lCorProdutoModel := TCorProdutoModel.getNewIface(vIConexao);
  try
    lCorProdutoModel       := lCorProdutoModel.objeto.carregaClasse(pID);
    lCorProdutoModel.objeto.Acao  := tacAlterar;
    Result            	   := lCorProdutoModel;
  finally
  end;
end;

function TCorProdutoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TCorProdutoModel.getNewIface(pIConexao: IConexao): ITCorProdutoModel;
begin
  Result := TImplObjetoOwner<TCorProdutoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCorProdutoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TCorProdutoModel.carregaClasse(pId : String): ITCorProdutoModel;
var
  lCorProdutoDao: ITCorProdutoDao;
begin
  lCorProdutoDao := TCorProdutoDao.getNewIface(vIConexao);

  try
    Result := lCorProdutoDao.objeto.carregaClasse(pID);
  finally
    lCorProdutoDao:=nil;
  end;
end;

constructor TCorProdutoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCorProdutoModel.Destroy;
begin
  inherited;
end;

function TCorProdutoModel.obterLista: IFDDataset;
var
  lCorProdutoLista: ITCorProdutoDao;
begin
  lCorProdutoLista := TCorProdutoDao.getNewIface(vIConexao);

  try
    lCorProdutoLista.objeto.TotalRecords    := FTotalRecords;
    lCorProdutoLista.objeto.WhereView       := FWhereView;
    lCorProdutoLista.objeto.CountView       := FCountView;
    lCorProdutoLista.objeto.OrderView       := FOrderView;
    lCorProdutoLista.objeto.StartRecordView := FStartRecordView;
    lCorProdutoLista.objeto.LengthPageView  := FLengthPageView;
    lCorProdutoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lCorProdutoLista.objeto.obterLista;

    FTotalRecords := lCorProdutoLista.objeto.TotalRecords;

  finally
    lCorProdutoLista:=nil;
  end;
end;

function TCorProdutoModel.Salvar: String;
var
  lCorProdutoDao: ITCorProdutoDao;
begin
  lCorProdutoDao := TCorProdutoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lCorProdutoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lCorProdutoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lCorProdutoDao.objeto.excluir(mySelf);
    end;
  finally
    lCorProdutoDao:=nil;
  end;
end;

procedure TCorProdutoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TCorProdutoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCorProdutoModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;

procedure TCorProdutoModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TCorProdutoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCorProdutoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCorProdutoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCorProdutoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TCorProdutoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TCorProdutoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TCorProdutoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TCorProdutoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
