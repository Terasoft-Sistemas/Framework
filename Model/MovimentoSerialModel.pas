unit MovimentoSerialModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TMovimentoSerialModel = class

  private
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

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TMovimentoSerialModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pID : String): TMovimentoSerialModel;
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
  lMovimentoSerialDao: TMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.Create(vIConexao);
  try
    Result := lMovimentoSerialDao.ValidaVendaSerial(pProduto);
  finally
    lMovimentoSerialDao.Free;
  end;
end;

function TMovimentoSerialModel.Alterar(pID: String): TMovimentoSerialModel;
var
  lMovimentoSerialModel : TMovimentoSerialModel;
begin
  lMovimentoSerialModel := TMovimentoSerialModel.Create(vIConexao);
  try
    lMovimentoSerialModel      := lMovimentoSerialModel.carregaClasse(pID);
    lMovimentoSerialModel.Acao := tacAlterar;
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

function TMovimentoSerialModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TMovimentoSerialModel.carregaClasse(pId : String): TMovimentoSerialModel;
var
  lMovimentoSerialDao: TMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.Create(vIConexao);
  try
    Result := lMovimentoSerialDao.carregaClasse(pID);
  finally
    lMovimentoSerialDao.Free;
  end;
end;

function TMovimentoSerialModel.ConsultaSerial: IFDDataset;
var
  lMovimentoSerial: TMovimentoSerialDao;
begin
  lMovimentoSerial := TMovimentoSerialDao.Create(vIConexao);
  try
    lMovimentoSerial.WhereView       := FWhereView;
    lMovimentoSerial.CountView       := FCountView;
    lMovimentoSerial.OrderView       := FOrderView;
    lMovimentoSerial.StartRecordView := FStartRecordView;
    lMovimentoSerial.LengthPageView  := FLengthPageView;
    lMovimentoSerial.IDRecordView    := FIDRecordView;

    Result := lMovimentoSerial.ConsultaSerial;
  finally
    lMovimentoSerial.Free;
  end;
end;

constructor TMovimentoSerialModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TMovimentoSerialModel.Destroy;
begin
  inherited;
end;

function TMovimentoSerialModel.obterLista: IFDDataset;
var
  lMovimentoSerialLista: TMovimentoSerialDao;
begin
  lMovimentoSerialLista := TMovimentoSerialDao.Create(vIConexao);

  try
    lMovimentoSerialLista.TotalRecords    := FTotalRecords;
    lMovimentoSerialLista.WhereView       := FWhereView;
    lMovimentoSerialLista.CountView       := FCountView;
    lMovimentoSerialLista.OrderView       := FOrderView;
    lMovimentoSerialLista.StartRecordView := FStartRecordView;
    lMovimentoSerialLista.LengthPageView  := FLengthPageView;
    lMovimentoSerialLista.IDRecordView    := FIDRecordView;

    Result := lMovimentoSerialLista.obterLista;

    FTotalRecords := lMovimentoSerialLista.TotalRecords;

  finally
    lMovimentoSerialLista.Free;
  end;
end;

function TMovimentoSerialModel.RetornaSerialVenda(pProduto: String): String;
var
  lMovimentoSerialDao: TMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.Create(vIConexao);
  try
    Result := lMovimentoSerialDao.RetornaSerialVenda(pProduto);
  finally
    lMovimentoSerialDao.Free;
  end;
end;


function TMovimentoSerialModel.EstornaMovimentoSerial(pTipoDoc, pID_Doc, pSubId: String): String;
var
  lMovimentoSerialDao: TMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.Create(vIConexao);
  try
    Result := lMovimentoSerialDao.EstornaMovimentoSerial(pTipoDoc,pID_Doc,pSubId);
  finally
    lMovimentoSerialDao.Free;
  end;
end;

function TMovimentoSerialModel.SaldoProdutoSerial(pProduto: String): Real;
var
  lMovimentoSerialDao: TMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.Create(vIConexao);
  try
    Result := lMovimentoSerialDao.SaldoProdutoSerial(pProduto);
  finally
    lMovimentoSerialDao.Free;
  end;
end;

function TMovimentoSerialModel.Salvar: String;
var
  lMovimentoSerialDao: TMovimentoSerialDao;
begin
  lMovimentoSerialDao := TMovimentoSerialDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lMovimentoSerialDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lMovimentoSerialDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lMovimentoSerialDao.excluir(Self);
    end;
  finally
    lMovimentoSerialDao.Free;
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
