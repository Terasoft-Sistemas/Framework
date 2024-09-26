unit MovimentoSerialModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TMovimentoSerialModel = class;
  ITMovimentoSerialModel=IObject<TMovimentoSerialModel>;

  TMovimentoSerialModel = class
  private
    [unsafe] mySelf:ITMovimentoSerialModel;
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
    FSUB_ID: Variant;
    FPRODUTO: Variant;
    FLOGISTICA: Variant;
    FDH_MOVIMENTO: Variant;
    FTIPO_MOVIMENTO: Variant;
    FNUMERO: Variant;
    FID_DOCUMENTO: Variant;
    FSYSTIME: Variant;
    FTIPO_SERIAL: Variant;
    FTIPO_DOCUMENTO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    procedure SetID(const Value: Variant);
    procedure SetDH_MOVIMENTO(const Value: Variant);
    procedure SetID_DOCUMENTO(const Value: Variant);
    procedure SetLOGISTICA(const Value: Variant);
    procedure SetNUMERO(const Value: Variant);
    procedure SetPRODUTO(const Value: Variant);
    procedure SetSUB_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO_DOCUMENTO(const Value: Variant);
    procedure SetTIPO_MOVIMENTO(const Value: Variant);
    procedure SetTIPO_SERIAL(const Value: Variant);

  public

    property ID : Variant read FID write SetID;
    property LOGISTICA : Variant read FLOGISTICA write SetLOGISTICA;
    property TIPO_SERIAL : Variant read FTIPO_SERIAL write SetTIPO_SERIAL;
    property NUMERO : Variant read FNUMERO write SetNUMERO;
    property PRODUTO : Variant read FPRODUTO write SetPRODUTO;
    property DH_MOVIMENTO : Variant read FDH_MOVIMENTO write SetDH_MOVIMENTO;
    property TIPO_DOCUMENTO : Variant read FTIPO_DOCUMENTO write SetTIPO_DOCUMENTO;
    property ID_DOCUMENTO : Variant read FID_DOCUMENTO write SetID_DOCUMENTO;
    property SUB_ID : Variant read FSUB_ID write SetSUB_ID;
    property TIPO_MOVIMENTO : Variant read FTIPO_MOVIMENTO write SetTIPO_MOVIMENTO;
    property SYSTIME : Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITMovimentoSerialModel;

    function Incluir: String;
    function Alterar(pID : String): ITMovimentoSerialModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pID : String): ITMovimentoSerialModel;
    function obterLista: IFDDataset;
    function ConsultaSerial: IFDDataset;

    function ValidaVendaSerial(pProduto: String): Boolean;
    function SaldoProdutoSerial(pProduto: String): Real;
    function RetornaSerialVenda(pProduto: String): String;

    function EstornaMovimentoSerial(pTipoDoc, pID_Doc, pSubId: String): String;

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
  MovimentoSerialDao,
  System.Classes,
  System.SysUtils;

{ TMovimentoSerialModel }

function TMovimentoSerialModel.ValidaVendaSerial(pProduto: String): Boolean;
var
  lMovimentoSerialDao: ITMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.getNewIface(vIConexao);
  try
    Result := lMovimentoSerialDao.objeto.ValidaVendaSerial(pProduto);
  finally
    lMovimentoSerialDao:=nil;
  end;
end;

function TMovimentoSerialModel.Alterar(pID: String): ITMovimentoSerialModel;
var
  lMovimentoSerialModel : ITMovimentoSerialModel;
begin
  lMovimentoSerialModel := TMovimentoSerialModel.getNewIface(vIConexao);
  try
    lMovimentoSerialModel      := lMovimentoSerialModel.objeto.carregaClasse(pID);
    lMovimentoSerialModel.objeto.Acao := tacAlterar;
    Result            	       := lMovimentoSerialModel;
  finally

  end;
end;

function TMovimentoSerialModel.Excluir(pID: String): String;
begin
  self.ID    := pID;
  self.FAcao := tacExcluir;
  Result     := self.Salvar;
end;

class function TMovimentoSerialModel.getNewIface(pIConexao: IConexao): ITMovimentoSerialModel;
begin
  Result := TImplObjetoOwner<TMovimentoSerialModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TMovimentoSerialModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TMovimentoSerialModel.carregaClasse(pId : String): ITMovimentoSerialModel;
var
  lMovimentoSerialDao: ITMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.getNewIface(vIConexao);
  try
    Result := lMovimentoSerialDao.objeto.carregaClasse(pID);
  finally
    lMovimentoSerialDao:=nil;
  end;
end;

function TMovimentoSerialModel.ConsultaSerial: IFDDataset;
var
  lMovimentoSerial: ITMovimentoSerialDao;
begin
  lMovimentoSerial := TMovimentoSerialDao.getNewIface(vIConexao);
  try
    lMovimentoSerial.objeto.WhereView       := FWhereView;
    lMovimentoSerial.objeto.CountView       := FCountView;
    lMovimentoSerial.objeto.OrderView       := FOrderView;
    lMovimentoSerial.objeto.StartRecordView := FStartRecordView;
    lMovimentoSerial.objeto.LengthPageView  := FLengthPageView;
    lMovimentoSerial.objeto.IDRecordView    := FIDRecordView;

    Result := lMovimentoSerial.objeto.ConsultaSerial;
  finally
    lMovimentoSerial:=nil;
  end;
end;

constructor TMovimentoSerialModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TMovimentoSerialModel.Destroy;
begin
  inherited;
end;

function TMovimentoSerialModel.obterLista: IFDDataset;
var
  lMovimentoSerialLista: ITMovimentoSerialDao;
begin
  lMovimentoSerialLista := TMovimentoSerialDao.getNewIface(vIConexao);

  try
    lMovimentoSerialLista.objeto.TotalRecords    := FTotalRecords;
    lMovimentoSerialLista.objeto.WhereView       := FWhereView;
    lMovimentoSerialLista.objeto.CountView       := FCountView;
    lMovimentoSerialLista.objeto.OrderView       := FOrderView;
    lMovimentoSerialLista.objeto.StartRecordView := FStartRecordView;
    lMovimentoSerialLista.objeto.LengthPageView  := FLengthPageView;
    lMovimentoSerialLista.objeto.IDRecordView    := FIDRecordView;

    Result := lMovimentoSerialLista.objeto.obterLista;

    FTotalRecords := lMovimentoSerialLista.objeto.TotalRecords;

  finally
    lMovimentoSerialLista:=nil;
  end;
end;

function TMovimentoSerialModel.RetornaSerialVenda(pProduto: String): String;
var
  lMovimentoSerialDao: ITMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.getNewIface(vIConexao);
  try
    Result := lMovimentoSerialDao.objeto.RetornaSerialVenda(pProduto);
  finally
    lMovimentoSerialDao:=nil;
  end;
end;


function TMovimentoSerialModel.EstornaMovimentoSerial(pTipoDoc, pID_Doc, pSubId: String): String;
var
  lMovimentoSerialDao: ITMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.getNewIface(vIConexao);
  try
    Result := lMovimentoSerialDao.objeto.EstornaMovimentoSerial(pTipoDoc,pID_Doc,pSubId);
  finally
    lMovimentoSerialDao:=nil;
  end;
end;

function TMovimentoSerialModel.SaldoProdutoSerial(pProduto: String): Real;
var
  lMovimentoSerialDao: ITMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.getNewIface(vIConexao);
  try
    Result := lMovimentoSerialDao.objeto.SaldoProdutoSerial(pProduto);
  finally
    lMovimentoSerialDao:=nil;
  end;
end;

function TMovimentoSerialModel.Salvar: String;
var
  lMovimentoSerialDao: ITMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lMovimentoSerialDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lMovimentoSerialDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lMovimentoSerialDao.objeto.excluir(mySelf);
    end;
  finally
    lMovimentoSerialDao:=nil;
  end;
end;

procedure TMovimentoSerialModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TMovimentoSerialModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMovimentoSerialModel.SetDH_MOVIMENTO(const Value: Variant);
begin
  FDH_MOVIMENTO := Value;
end;

procedure TMovimentoSerialModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMovimentoSerialModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TMovimentoSerialModel.SetID_DOCUMENTO(const Value: Variant);
begin
  FID_DOCUMENTO := Value;
end;

procedure TMovimentoSerialModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMovimentoSerialModel.SetLOGISTICA(const Value: Variant);
begin
  FLOGISTICA := Value;
end;

procedure TMovimentoSerialModel.SetNUMERO(const Value: Variant);
begin
  FNUMERO := Value;
end;

procedure TMovimentoSerialModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TMovimentoSerialModel.SetPRODUTO(const Value: Variant);
begin
  FPRODUTO := Value;
end;

procedure TMovimentoSerialModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TMovimentoSerialModel.SetSUB_ID(const Value: Variant);
begin
  FSUB_ID := Value;
end;

procedure TMovimentoSerialModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TMovimentoSerialModel.SetTIPO_DOCUMENTO(const Value: Variant);
begin
  FTIPO_DOCUMENTO := Value;
end;

procedure TMovimentoSerialModel.SetTIPO_MOVIMENTO(const Value: Variant);
begin
  FTIPO_MOVIMENTO := Value;
end;

procedure TMovimentoSerialModel.SetTIPO_SERIAL(const Value: Variant);
begin
  FTIPO_SERIAL := Value;
end;

procedure TMovimentoSerialModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TMovimentoSerialModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;



end.
