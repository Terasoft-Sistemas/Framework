unit DevolucaoModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TDevolucaoModel = class;
  ITDevolucaoModel=IObject<TDevolucaoModel>;
  TDevolucaoModel = class
  private
    [weak] mySelf: ITDevolucaoModel;
    vIConexao : IConexao;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FDESCONTO: Variant;
    FOBS: Variant;
    FPORTADOR_ID: Variant;
    FHORA: Variant;
    FUSO_VALE: Variant;
    FVALOR_TOTAL: Variant;
    FPEDIDO: Variant;
    FNF_ENTRADA: Variant;
    FVALOR_SUFRAMA: Variant;
    FCLIENTE: Variant;
    FVALOR_ST: Variant;
    FVENDEDOR: Variant;
    FID: Variant;
    FLOJA: Variant;
    FSYSTIME: Variant;
    FSTATUS_ID: Variant;
    FVALOR_IPI: Variant;
    FCODIGO_TIP: Variant;
    FDATA_USO_VALE: Variant;
    FVALE: Variant;
    FFRETE: Variant;
    FUSUARIO: Variant;
    FVFCPST: Variant;
    FVALOR_ACRESCIMO: Variant;
    FDATA: Variant;
    FIDRecordView: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCLIENTE(const Value: Variant);
    procedure SetCODIGO_TIP(const Value: Variant);
    procedure SetDATA(const Value: Variant);
    procedure SetDATA_USO_VALE(const Value: Variant);
    procedure SetDESCONTO(const Value: Variant);
    procedure SetFRETE(const Value: Variant);
    procedure SetHORA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetNF_ENTRADA(const Value: Variant);
    procedure SetOBS(const Value: Variant);
    procedure SetPEDIDO(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetSTATUS_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetUSO_VALE(const Value: Variant);
    procedure SetUSUARIO(const Value: Variant);
    procedure SetVALE(const Value: Variant);
    procedure SetVALOR_ACRESCIMO(const Value: Variant);
    procedure SetVALOR_IPI(const Value: Variant);
    procedure SetVALOR_ST(const Value: Variant);
    procedure SetVALOR_SUFRAMA(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);
    procedure SetVENDEDOR(const Value: Variant);
    procedure SetVFCPST(const Value: Variant);
    procedure SetIDRecordView(const Value: String);

  public
    property ID: Variant read FID write SetID;
    property PEDIDO: Variant read FPEDIDO write SetPEDIDO;
    property CLIENTE: Variant read FCLIENTE write SetCLIENTE;
    property DATA: Variant read FDATA write SetDATA;
    property VALOR_TOTAL: Variant read FVALOR_TOTAL write SetVALOR_TOTAL;
    property USUARIO: Variant read FUSUARIO write SetUSUARIO;
    property OBS: Variant read FOBS write SetOBS;
    property LOJA: Variant read FLOJA write SetLOJA;
    property VALE: Variant read FVALE write SetVALE;
    property DATA_USO_VALE: Variant read FDATA_USO_VALE write SetDATA_USO_VALE;
    property USO_VALE: Variant read FUSO_VALE write SetUSO_VALE;
    property NF_ENTRADA: Variant read FNF_ENTRADA write SetNF_ENTRADA;
    property DESCONTO: Variant read FDESCONTO write SetDESCONTO;
    property VENDEDOR: Variant read FVENDEDOR write SetVENDEDOR;
    property CODIGO_TIP: Variant read FCODIGO_TIP write SetCODIGO_TIP;
    property HORA: Variant read FHORA write SetHORA;
    property VALOR_IPI: Variant read FVALOR_IPI write SetVALOR_IPI;
    property VALOR_ST: Variant read FVALOR_ST write SetVALOR_ST;
    property FRETE: Variant read FFRETE write SetFRETE;
    property VALOR_SUFRAMA: Variant read FVALOR_SUFRAMA write SetVALOR_SUFRAMA;
    property STATUS_ID: Variant read FSTATUS_ID write SetSTATUS_ID;
    property PORTADOR_ID: Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property VALOR_ACRESCIMO: Variant read FVALOR_ACRESCIMO write SetVALOR_ACRESCIMO;
    property VFCPST: Variant read FVFCPST write SetVFCPST;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDevolucaoModel;

    function Incluir: String;
    function Alterar(pID : String): ITDevolucaoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITDevolucaoModel;
    function obterLista: IFDDataset;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
  end;

implementation

uses
  DevolucaoDao,  
  System.Classes, 
  System.SysUtils;

{ TDevolucaoModel }

function TDevolucaoModel.Alterar(pID: String): ITDevolucaoModel;
var
  lDevolucaoModel : ITDevolucaoModel;
begin
  lDevolucaoModel := TDevolucaoModel.getNewIface(vIConexao);
  try
    lDevolucaoModel       := lDevolucaoModel.objeto.carregaClasse(pID);
    lDevolucaoModel.objeto.Acao  := tacAlterar;
    Result            := lDevolucaoModel;
  finally
  end;
end;

function TDevolucaoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TDevolucaoModel.getNewIface(pIConexao: IConexao): ITDevolucaoModel;
begin
  Result := TImplObjetoOwner<TDevolucaoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDevolucaoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TDevolucaoModel.carregaClasse(pId : String): ITDevolucaoModel;
var
  lDevolucaoDao: ITDevolucaoDao;
begin
  lDevolucaoDao := TDevolucaoDao.getNewIface(vIConexao);

  try
    Result := lDevolucaoDao.objeto.carregaClasse(pId);
  finally
    lDevolucaoDao:=nil;
  end;
end;

constructor TDevolucaoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDevolucaoModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TDevolucaoModel.obterLista: IFDDataset;
var
  lDevolucaoLista: ITDevolucaoDao;
begin
  lDevolucaoLista := TDevolucaoDao.getNewIface(vIConexao);

  try
    lDevolucaoLista.objeto.TotalRecords    := FTotalRecords;
    lDevolucaoLista.objeto.WhereView       := FWhereView;
    lDevolucaoLista.objeto.CountView       := FCountView;
    lDevolucaoLista.objeto.OrderView       := FOrderView;
    lDevolucaoLista.objeto.StartRecordView := FStartRecordView;
    lDevolucaoLista.objeto.LengthPageView  := FLengthPageView;
    lDevolucaoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lDevolucaoLista.objeto.obterLista;

    FTotalRecords := lDevolucaoLista.objeto.TotalRecords;

  finally
    lDevolucaoLista:=nil;
  end;
end;

function TDevolucaoModel.Salvar: String;
var
  lDevolucaoDao: ITDevolucaoDao;
begin
  lDevolucaoDao := TDevolucaoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lDevolucaoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lDevolucaoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lDevolucaoDao.objeto.excluir(mySelf);
    end;
  finally
    lDevolucaoDao:=nil;
  end;
end;

procedure TDevolucaoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TDevolucaoModel.SetCLIENTE(const Value: Variant);
begin
  FCLIENTE := Value;
end;

procedure TDevolucaoModel.SetCODIGO_TIP(const Value: Variant);
begin
  FCODIGO_TIP := Value;
end;

procedure TDevolucaoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDevolucaoModel.SetDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TDevolucaoModel.SetDATA_USO_VALE(const Value: Variant);
begin
  FDATA_USO_VALE := Value;
end;

procedure TDevolucaoModel.SetDESCONTO(const Value: Variant);
begin
  FDESCONTO := Value;
end;

procedure TDevolucaoModel.SetFRETE(const Value: Variant);
begin
  FFRETE := Value;
end;

procedure TDevolucaoModel.SetHORA(const Value: Variant);
begin
  FHORA := Value;
end;

procedure TDevolucaoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDevolucaoModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TDevolucaoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDevolucaoModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TDevolucaoModel.SetNF_ENTRADA(const Value: Variant);
begin
  FNF_ENTRADA := Value;
end;

procedure TDevolucaoModel.SetOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TDevolucaoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TDevolucaoModel.SetPEDIDO(const Value: Variant);
begin
  FPEDIDO := Value;
end;

procedure TDevolucaoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TDevolucaoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TDevolucaoModel.SetSTATUS_ID(const Value: Variant);
begin
  FSTATUS_ID := Value;
end;

procedure TDevolucaoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TDevolucaoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TDevolucaoModel.SetUSO_VALE(const Value: Variant);
begin
  FUSO_VALE := Value;
end;

procedure TDevolucaoModel.SetUSUARIO(const Value: Variant);
begin
  FUSUARIO := Value;
end;

procedure TDevolucaoModel.SetVALE(const Value: Variant);
begin
  FVALE := Value;
end;

procedure TDevolucaoModel.SetVALOR_ACRESCIMO(const Value: Variant);
begin
  FVALOR_ACRESCIMO := Value;
end;

procedure TDevolucaoModel.SetVALOR_IPI(const Value: Variant);
begin
  FVALOR_IPI := Value;
end;

procedure TDevolucaoModel.SetVALOR_ST(const Value: Variant);
begin
  FVALOR_ST := Value;
end;

procedure TDevolucaoModel.SetVALOR_SUFRAMA(const Value: Variant);
begin
  FVALOR_SUFRAMA := Value;
end;

procedure TDevolucaoModel.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;

procedure TDevolucaoModel.SetVENDEDOR(const Value: Variant);
begin
  FVENDEDOR := Value;
end;

procedure TDevolucaoModel.SetVFCPST(const Value: Variant);
begin
  FVFCPST := Value;
end;

procedure TDevolucaoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
