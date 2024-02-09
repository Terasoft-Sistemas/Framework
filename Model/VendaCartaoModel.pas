unit VendaCartaoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TVendaCartaoModel = class

  private
    vIConexao : IConexao;
    FVendaCartaosLista: TObjectList<TVendaCartaoModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FNUMERO_OS: Variant;
    FVENDA_CAR: Variant;
    FPARCELAS_TEF: Variant;
    FTAXA: Variant;
    FVALOR_CAR: Variant;
    FCANCELAMENTO_DATA: Variant;
    FNUMERO_VENDA: Variant;
    FPARCELA_TEF: Variant;
    FVENCIMENTO_CAR: Variant;
    FPARCELADO_CAR: Variant;
    FNUMERO_CAR: Variant;
    FCODIGO_CLI: Variant;
    FAUTORIZACAO_CAR: Variant;
    FID: Variant;
    FCANCELAMENTO_CODIGO: Variant;
    FLOJA: Variant;
    FFATURA_ID: Variant;
    FPARCELAS_CAR: Variant;
    FSYSTIME: Variant;
    FADM_CAR: Variant;
    FPARCELA_CAR: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetVendaCartaosLista(const Value: TObjectList<TVendaCartaoModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetADM_CAR(const Value: Variant);
    procedure SetAUTORIZACAO_CAR(const Value: Variant);
    procedure SetCANCELAMENTO_CODIGO(const Value: Variant);
    procedure SetCANCELAMENTO_DATA(const Value: Variant);
    procedure SetCODIGO_CLI(const Value: Variant);
    procedure SetFATURA_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetNUMERO_CAR(const Value: Variant);
    procedure SetNUMERO_OS(const Value: Variant);
    procedure SetNUMERO_VENDA(const Value: Variant);
    procedure SetPARCELA_CAR(const Value: Variant);
    procedure SetPARCELA_TEF(const Value: Variant);
    procedure SetPARCELADO_CAR(const Value: Variant);
    procedure SetPARCELAS_CAR(const Value: Variant);
    procedure SetPARCELAS_TEF(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAXA(const Value: Variant);
    procedure SetVALOR_CAR(const Value: Variant);
    procedure SetVENCIMENTO_CAR(const Value: Variant);
    procedure SetVENDA_CAR(const Value: Variant);
  public
    property ID: Variant read FID write SetID;
    property NUMERO_CAR: Variant read FNUMERO_CAR write SetNUMERO_CAR;
    property AUTORIZACAO_CAR: Variant read FAUTORIZACAO_CAR write SetAUTORIZACAO_CAR;
    property PARCELA_CAR: Variant read FPARCELA_CAR write SetPARCELA_CAR;
    property PARCELAS_CAR: Variant read FPARCELAS_CAR write SetPARCELAS_CAR;
    property VALOR_CAR: Variant read FVALOR_CAR write SetVALOR_CAR;
    property CODIGO_CLI: Variant read FCODIGO_CLI write SetCODIGO_CLI;
    property ADM_CAR: Variant read FADM_CAR write SetADM_CAR;
    property VENDA_CAR: Variant read FVENDA_CAR write SetVENDA_CAR;
    property PARCELADO_CAR: Variant read FPARCELADO_CAR write SetPARCELADO_CAR;
    property VENCIMENTO_CAR: Variant read FVENCIMENTO_CAR write SetVENCIMENTO_CAR;
    property NUMERO_VENDA: Variant read FNUMERO_VENDA write SetNUMERO_VENDA;
    property LOJA: Variant read FLOJA write SetLOJA;
    property NUMERO_OS: Variant read FNUMERO_OS write SetNUMERO_OS;
    property FATURA_ID: Variant read FFATURA_ID write SetFATURA_ID;
    property CANCELAMENTO_DATA: Variant read FCANCELAMENTO_DATA write SetCANCELAMENTO_DATA;
    property CANCELAMENTO_CODIGO: Variant read FCANCELAMENTO_CODIGO write SetCANCELAMENTO_CODIGO;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property TAXA: Variant read FTAXA write SetTAXA;
    property PARCELA_TEF: Variant read FPARCELA_TEF write SetPARCELA_TEF;
    property PARCELAS_TEF: Variant read FPARCELAS_TEF write SetPARCELAS_TEF;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String) : TVendaCartaoModel;
    function Excluir(pID : String) : String;
    function Salvar: String;
    function carregaClasse(pID: String): TVendaCartaoModel;
    procedure obterLista;

    property VendaCartaosLista: TObjectList<TVendaCartaoModel> read FVendaCartaosLista write SetVendaCartaosLista;
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
  VendaCartaoDao;

{ TVendaCartaoModel }

function TVendaCartaoModel.Alterar(pID: String): TVendaCartaoModel;
var
  lVendaCartaoModel : TVendaCartaoModel;
begin
  lVendaCartaoModel := TVendaCartaoModel.Create(vIConexao);
  try
    lVendaCartaoModel       := lVendaCartaoModel.carregaClasse(pID);
    lVendaCartaoModel.Acao  := tacAlterar;
    Result                  := lVendaCartaoModel;
  finally

  end;
end;

function TVendaCartaoModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

function TVendaCartaoModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TVendaCartaoModel.carregaClasse(pID: String): TVendaCartaoModel;
var
  lVendaCartaoDao: TVendaCartaoDao;
begin
  lVendaCartaoDao := TVendaCartaoDao.Create(vIConexao);
  try
    Result  := lVendaCartaoDao.carregaClasse(pId);
  finally
    lVendaCartaoDao.Free;
  end;
end;

constructor TVendaCartaoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TVendaCartaoModel.Destroy;
begin

  inherited;
end;

procedure TVendaCartaoModel.obterLista;
var
  lVendaCartaoLista: TVendaCartaoDao;
begin
  lVendaCartaoLista := TVendaCartaoDao.Create(vIConexao);

  try
    lVendaCartaoLista.TotalRecords    := FTotalRecords;
    lVendaCartaoLista.WhereView       := FWhereView;
    lVendaCartaoLista.CountView       := FCountView;
    lVendaCartaoLista.OrderView       := FOrderView;
    lVendaCartaoLista.StartRecordView := FStartRecordView;
    lVendaCartaoLista.LengthPageView  := FLengthPageView;
    lVendaCartaoLista.IDRecordView    := FIDRecordView;

    lVendaCartaoLista.obterLista;

    FTotalRecords  := lVendaCartaoLista.TotalRecords;
    FVendaCartaosLista := lVendaCartaoLista.VendaCartaosLista;

  finally
    lVendaCartaoLista.Free;
  end;
end;

function TVendaCartaoModel.Salvar: String;
var
  lVendaCartaoDao: TVendaCartaoDao;
begin
  lVendaCartaoDao := TVendaCartaoDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lVendaCartaoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lVendaCartaoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lVendaCartaoDao.excluir(Self);
    end;

  finally
    lVendaCartaoDao.Free;
  end;
end;

procedure TVendaCartaoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TVendaCartaoModel.SetADM_CAR(const Value: Variant);
begin
  FADM_CAR := Value;
end;

procedure TVendaCartaoModel.SetAUTORIZACAO_CAR(const Value: Variant);
begin
  FAUTORIZACAO_CAR := Value;
end;

procedure TVendaCartaoModel.SetCANCELAMENTO_CODIGO(const Value: Variant);
begin
  FCANCELAMENTO_CODIGO := Value;
end;

procedure TVendaCartaoModel.SetCANCELAMENTO_DATA(const Value: Variant);
begin
  FCANCELAMENTO_DATA := Value;
end;

procedure TVendaCartaoModel.SetCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TVendaCartaoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVendaCartaoModel.SetFATURA_ID(const Value: Variant);
begin
  FFATURA_ID := Value;
end;

procedure TVendaCartaoModel.SetVALOR_CAR(const Value: Variant);
begin
  FVALOR_CAR := Value;
end;

procedure TVendaCartaoModel.SetVENCIMENTO_CAR(const Value: Variant);
begin
  FVENCIMENTO_CAR := Value;
end;

procedure TVendaCartaoModel.SetVendaCartaosLista(const Value: TObjectList<TVendaCartaoModel>);
begin
  FVendaCartaosLista := Value;
end;

procedure TVendaCartaoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TVendaCartaoModel.SetVENDA_CAR(const Value: Variant);
begin
  FVENDA_CAR := Value;
end;

procedure TVendaCartaoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TVendaCartaoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVendaCartaoModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TVendaCartaoModel.SetNUMERO_CAR(const Value: Variant);
begin
  FNUMERO_CAR := Value;
end;

procedure TVendaCartaoModel.SetNUMERO_OS(const Value: Variant);
begin
  FNUMERO_OS := Value;
end;

procedure TVendaCartaoModel.SetNUMERO_VENDA(const Value: Variant);
begin
  FNUMERO_VENDA := Value;
end;

procedure TVendaCartaoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TVendaCartaoModel.SetPARCELADO_CAR(const Value: Variant);
begin
  FPARCELADO_CAR := Value;
end;

procedure TVendaCartaoModel.SetPARCELAS_CAR(const Value: Variant);
begin
  FPARCELAS_CAR := Value;
end;

procedure TVendaCartaoModel.SetPARCELAS_TEF(const Value: Variant);
begin
  FPARCELAS_TEF := Value;
end;

procedure TVendaCartaoModel.SetPARCELA_CAR(const Value: Variant);
begin
  FPARCELA_CAR := Value;
end;

procedure TVendaCartaoModel.SetPARCELA_TEF(const Value: Variant);
begin
  FPARCELA_TEF := Value;
end;

procedure TVendaCartaoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TVendaCartaoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TVendaCartaoModel.SetTAXA(const Value: Variant);
begin
  FTAXA := Value;
end;

procedure TVendaCartaoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TVendaCartaoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
