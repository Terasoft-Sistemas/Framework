unit AnexoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TAnexoModel = class;
  ITAnexoModel=IObject<TAnexoModel>;

  TAnexoModel = class
  private
    [unsafe] mySelf:ITAnexoModel;
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
    FEXTENSAO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetDOCUMENTO_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetREGISTRO_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTABELA(const Value: Variant);
    procedure SetEXTENSAO(const Value: Variant);

  public

    property ID             : Variant read FID write SetID;
    property TABELA         : Variant read FTABELA write SetTABELA;
    property REGISTRO_ID    : Variant read FREGISTRO_ID write SetREGISTRO_ID;
    property DOCUMENTO_ID   : Variant read FDOCUMENTO_ID write SetDOCUMENTO_ID;
    property SYSTIME        : Variant read FSYSTIME write SetSYSTIME;
    property EXTENSAO       : Variant read FEXTENSAO write SetEXTENSAO;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITAnexoModel;

    function Incluir: String;
    function Alterar(pID : String): ITAnexoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITAnexoModel;
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
  AnexoDao,  
  System.Classes, 
  System.SysUtils;

{ TAnexoModel }

function TAnexoModel.Alterar(pID: String): ITAnexoModel;
var
  lAnexoModel : ITAnexoModel;
begin
  lAnexoModel := TAnexoModel.getNewIface(vIConexao);
  try
    lAnexoModel       := lAnexoModel.objeto.carregaClasse(pID);
    lAnexoModel.objeto.Acao  := tacAlterar;
    Result            := lAnexoModel;
  finally
  end;
end;

function TAnexoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TAnexoModel.getNewIface(pIConexao: IConexao): ITAnexoModel;
begin
  Result := TImplObjetoOwner<TAnexoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TAnexoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TAnexoModel.carregaClasse(pId : String): ITAnexoModel;
var
  lAnexoDao: ITAnexoDao;
begin
  lAnexoDao := TAnexoDao.getNewIface(vIConexao);

  try
    Result := lAnexoDao.objeto.carregaClasse(pId);
  finally
    lAnexoDao:=nil;
  end;
end;

constructor TAnexoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TAnexoModel.Destroy;
begin
  inherited;
end;

function TAnexoModel.obterLista: IFDDataset;
var
  lAnexoLista: ITAnexoDao;
begin
  lAnexoLista := TAnexoDao.getNewIface(vIConexao);

  try
    lAnexoLista.objeto.TotalRecords    := FTotalRecords;
    lAnexoLista.objeto.WhereView       := FWhereView;
    lAnexoLista.objeto.CountView       := FCountView;
    lAnexoLista.objeto.OrderView       := FOrderView;
    lAnexoLista.objeto.StartRecordView := FStartRecordView;
    lAnexoLista.objeto.LengthPageView  := FLengthPageView;
    lAnexoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lAnexoLista.objeto.obterLista;

    FTotalRecords := lAnexoLista.objeto.TotalRecords;

  finally
    lAnexoLista:=nil;
  end;
end;

function TAnexoModel.Salvar: String;
var
  lAnexoDao: ITAnexoDao;
begin
  lAnexoDao := TAnexoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lAnexoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lAnexoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lAnexoDao.objeto.excluir(mySelf);
    end;
  finally
    lAnexoDao:=nil;
  end;
end;

procedure TAnexoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TAnexoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAnexoModel.SetDOCUMENTO_ID(const Value: Variant);
begin
  FDOCUMENTO_ID := Value;
end;

procedure TAnexoModel.SetEXTENSAO(const Value: Variant);
begin
  FEXTENSAO := Value;
end;

procedure TAnexoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAnexoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAnexoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAnexoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TAnexoModel.SetREGISTRO_ID(const Value: Variant);
begin
  FREGISTRO_ID := Value;
end;

procedure TAnexoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;


procedure TAnexoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TAnexoModel.SetTABELA(const Value: Variant);
begin
  FTABELA := Value;
end;

procedure TAnexoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TAnexoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
