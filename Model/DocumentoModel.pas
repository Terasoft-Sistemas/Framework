unit DocumentoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TDocumentoModel = class;
  ITDocumentoModel=IObject<TDocumentoModel>;

  TDocumentoModel = class
  private
    [weak] mySelf: ITDocumentoModel;
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
    FNOME: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);

  public

    property ID       : Variant read FID write SetID;
    property NOME     : Variant read FNOME write SetNOME;
    property SYSTIME  : Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDocumentoModel;

    function Incluir: String;
    function Alterar(pID : String): ITDocumentoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITDocumentoModel;
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
  DocumentoDao,  
  System.Classes, 
  System.SysUtils;

{ TDocumentoModel }

function TDocumentoModel.Alterar(pID: String): ITDocumentoModel;
var
  lDocumentoModel : ITDocumentoModel;
begin
  lDocumentoModel := TDocumentoModel.getNewIface(vIConexao);
  try
    lDocumentoModel       := lDocumentoModel.objeto.carregaClasse(pID);
    lDocumentoModel.objeto.Acao  := tacAlterar;
    Result                := lDocumentoModel;
  finally
  end;
end;

function TDocumentoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TDocumentoModel.getNewIface(pIConexao: IConexao): ITDocumentoModel;
begin
  Result := TImplObjetoOwner<TDocumentoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDocumentoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TDocumentoModel.carregaClasse(pId : String): ITDocumentoModel;
var
  lDocumentoDao: ITDocumentoDao;
begin
  lDocumentoDao := TDocumentoDao.getNewIface(vIConexao);

  try
    Result := lDocumentoDao.objeto.carregaClasse(pId);
  finally
    lDocumentoDao:=nil;
  end;
end;

constructor TDocumentoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDocumentoModel.Destroy;
begin
  inherited;
end;

function TDocumentoModel.obterLista: IFDDataset;
var
  lDocumentoLista: ITDocumentoDao;
begin
  lDocumentoLista := TDocumentoDao.getNewIface(vIConexao);

  try
    lDocumentoLista.objeto.TotalRecords    := FTotalRecords;
    lDocumentoLista.objeto.WhereView       := FWhereView;
    lDocumentoLista.objeto.CountView       := FCountView;
    lDocumentoLista.objeto.OrderView       := FOrderView;
    lDocumentoLista.objeto.StartRecordView := FStartRecordView;
    lDocumentoLista.objeto.LengthPageView  := FLengthPageView;
    lDocumentoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lDocumentoLista.objeto.obterLista;

    FTotalRecords := lDocumentoLista.objeto.TotalRecords;

  finally
    lDocumentoLista:=nil;
  end;
end;

function TDocumentoModel.Salvar: String;
var
  lDocumentoDao: ITDocumentoDao;
begin
  lDocumentoDao := TDocumentoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lDocumentoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lDocumentoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lDocumentoDao.objeto.excluir(mySelf);
    end;
  finally
    lDocumentoDao:=nil;
  end;
end;

procedure TDocumentoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TDocumentoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDocumentoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDocumentoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TDocumentoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDocumentoModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TDocumentoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TDocumentoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;


procedure TDocumentoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TDocumentoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TDocumentoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
