unit TabelaJurosDiaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TTabelaJurosDiaModel = class;
  ITTabelaJurosDiaModel=IObject<TTabelaJurosDiaModel>;

  TTabelaJurosDiaModel = class
  private
    [weak] mySelf: ITTabelaJurosDiaModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPORTADOR_ID: Variant;
    FINDICE: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FDIA: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetINDICE(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetDIA(const Value: Variant);

  public

    property ID          : Variant read FID write SetID;
    property DIA         : Variant read FDIA write SetDIA;
    property INDICE      : Variant read FINDICE write SetINDICE;
    property PORTADOR_ID : Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property SYSTIME     : Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITTabelaJurosDiaModel;

    function Incluir: String;
    function Alterar(pID : String): ITTabelaJurosDiaModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITTabelaJurosDiaModel;
    function obterLista: IFDDataset;
    function obterIndice (pDia, pPortador_id : String) : Double;

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
  TabelaJurosDiaDao,  
  System.Classes, 
  System.SysUtils;

{ TTabelaJurosDiaModel }

function TTabelaJurosDiaModel.Alterar(pID: String): ITTabelaJurosDiaModel;
var
  lTabelaJurosDiaModel : ITTabelaJurosDiaModel;
begin
  lTabelaJurosDiaModel := TTabelaJurosDiaModel.getNewIface(vIConexao);
  try
    lTabelaJurosDiaModel       := lTabelaJurosDiaModel.objeto.carregaClasse(pID);
    lTabelaJurosDiaModel.objeto.Acao  := tacAlterar;
    Result            	       := lTabelaJurosDiaModel;
  finally
  end;
end;

function TTabelaJurosDiaModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TTabelaJurosDiaModel.getNewIface(pIConexao: IConexao): ITTabelaJurosDiaModel;
begin
  Result := TImplObjetoOwner<TTabelaJurosDiaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TTabelaJurosDiaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TTabelaJurosDiaModel.carregaClasse(pId : String): ITTabelaJurosDiaModel;
var
  lTabelaJurosDiaDao: ITTabelaJurosDiaDao;
begin
  lTabelaJurosDiaDao := TTabelaJurosDiaDao.getNewIface(vIConexao);

  try
    Result := lTabelaJurosDiaDao.objeto.carregaClasse(pID);
  finally
    lTabelaJurosDiaDao:=nil;
  end;
end;

constructor TTabelaJurosDiaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTabelaJurosDiaModel.Destroy;
begin
  inherited;
end;

function TTabelaJurosDiaModel.obterIndice(pDia, pPortador_id: String): Double;
var
  lTabelaJurosDia: ITTabelaJurosDiaDao;
begin
  lTabelaJurosDia := TTabelaJurosDiaDao.getNewIface(vIConexao);
  try
    lTabelaJurosDia.objeto.WhereView := 'and tabelajuros_dia.dia = '+pDia+' and tabelajuros_dia.portador_id = '+pPortador_id+' ';
    result := lTabelaJurosDia.objeto.obterLista.objeto.FieldByName('INDICE').AsFloat;
  finally
    lTabelaJurosDia:=nil;
  end;
end;

function TTabelaJurosDiaModel.obterLista: IFDDataset;
var
  lTabelaJurosDiaLista: ITTabelaJurosDiaDao;
begin
  lTabelaJurosDiaLista := TTabelaJurosDiaDao.getNewIface(vIConexao);

  try
    lTabelaJurosDiaLista.objeto.TotalRecords    := FTotalRecords;
    lTabelaJurosDiaLista.objeto.WhereView       := FWhereView;
    lTabelaJurosDiaLista.objeto.CountView       := FCountView;
    lTabelaJurosDiaLista.objeto.OrderView       := FOrderView;
    lTabelaJurosDiaLista.objeto.StartRecordView := FStartRecordView;
    lTabelaJurosDiaLista.objeto.LengthPageView  := FLengthPageView;
    lTabelaJurosDiaLista.objeto.IDRecordView    := FIDRecordView;

    Result := lTabelaJurosDiaLista.objeto.obterLista;

    FTotalRecords := lTabelaJurosDiaLista.objeto.TotalRecords;

  finally
    lTabelaJurosDiaLista:=nil;
  end;
end;

function TTabelaJurosDiaModel.Salvar: String;
var
  lTabelaJurosDiaDao: ITTabelaJurosDiaDao;
begin
  lTabelaJurosDiaDao := TTabelaJurosDiaDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lTabelaJurosDiaDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lTabelaJurosDiaDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lTabelaJurosDiaDao.objeto.excluir(mySelf);
    end;
  finally
    lTabelaJurosDiaDao:=nil;
  end;
end;

procedure TTabelaJurosDiaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TTabelaJurosDiaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosDiaModel.SetDIA(const Value: Variant);
begin
  FDIA := Value;
end;

procedure TTabelaJurosDiaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosDiaModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosDiaModel.SetINDICE(const Value: Variant);
begin
  FINDICE := Value;
end;

procedure TTabelaJurosDiaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosDiaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TTabelaJurosDiaModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TTabelaJurosDiaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TTabelaJurosDiaModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TTabelaJurosDiaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TTabelaJurosDiaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
