unit VoltagemProdutoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TVoltagemProdutoModel = class;
  ITVoltagemProdutoModel=IObject<TVoltagemProdutoModel>;

  TVoltagemProdutoModel = class
  private
    [unsafe] mySelf: ITVoltagemProdutoModel;
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
    property DESCRICAO      : Variant  read FDESCRICAO write SetDESCRICAO;
    property DATA_CADASTRO  : Variant  read FDATA_CADASTRO write SetDATA_CADASTRO;
    propertY SYSTIME        : Variant  read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITVoltagemProdutoModel;

    function Incluir: String;
    function Alterar(pID : String): ITVoltagemProdutoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITVoltagemProdutoModel;
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
  VoltagemProdutoDao,  
  System.Classes, 
  System.SysUtils;

{ TVoltagemProdutoModel }

function TVoltagemProdutoModel.Alterar(pID: String): ITVoltagemProdutoModel;
var
  lVoltagemProdutoModel : ITVoltagemProdutoModel;
begin
  lVoltagemProdutoModel := TVoltagemProdutoModel.getNewIface(vIConexao);
  try
    lVoltagemProdutoModel       := lVoltagemProdutoModel.objeto.carregaClasse(pID);
    lVoltagemProdutoModel.objeto.Acao  := tacAlterar;
    Result               		    := lVoltagemProdutoModel;
  finally
  end;
end;

function TVoltagemProdutoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TVoltagemProdutoModel.getNewIface(pIConexao: IConexao): ITVoltagemProdutoModel;
begin
  Result := TImplObjetoOwner<TVoltagemProdutoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TVoltagemProdutoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TVoltagemProdutoModel.carregaClasse(pID : String): ITVoltagemProdutoModel;
var
  lVoltagemProdutoDao: ITVoltagemProdutoDao;
begin
  lVoltagemProdutoDao := TVoltagemProdutoDao.getNewIface(vIConexao);

  try
    Result := lVoltagemProdutoDao.objeto.carregaClasse(pID);
  finally
    lVoltagemProdutoDao:=nil;
  end;
end;

constructor TVoltagemProdutoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TVoltagemProdutoModel.Destroy;
begin
  inherited;
end;

function TVoltagemProdutoModel.obterLista: IFDDataset;
var
  lVoltagemProdutoLista: ITVoltagemProdutoDao;
begin
  lVoltagemProdutoLista := TVoltagemProdutoDao.getNewIface(vIConexao);

  try
    lVoltagemProdutoLista.objeto.TotalRecords    := FTotalRecords;
    lVoltagemProdutoLista.objeto.WhereView       := FWhereView;
    lVoltagemProdutoLista.objeto.CountView       := FCountView;
    lVoltagemProdutoLista.objeto.OrderView       := FOrderView;
    lVoltagemProdutoLista.objeto.StartRecordView := FStartRecordView;
    lVoltagemProdutoLista.objeto.LengthPageView  := FLengthPageView;
    lVoltagemProdutoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lVoltagemProdutoLista.objeto.obterLista;

    FTotalRecords := lVoltagemProdutoLista.objeto.TotalRecords;

  finally
    lVoltagemProdutoLista:=nil;
  end;
end;

function TVoltagemProdutoModel.Salvar: String;
var
  lVoltagemProdutoDao: ITVoltagemProdutoDao;
begin
  lVoltagemProdutoDao := TVoltagemProdutoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lVoltagemProdutoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lVoltagemProdutoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lVoltagemProdutoDao.objeto.excluir(mySelf);
    end;
  finally
    lVoltagemProdutoDao:=nil;
  end;
end;

procedure TVoltagemProdutoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TVoltagemProdutoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVoltagemProdutoModel.SetDATA_CADASTRO(const Value: Variant);
begin
  FDATA_CADASTRO := Value;
end;

procedure TVoltagemProdutoModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TVoltagemProdutoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TVoltagemProdutoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TVoltagemProdutoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVoltagemProdutoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TVoltagemProdutoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TVoltagemProdutoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TVoltagemProdutoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TVoltagemProdutoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
