unit AdmCartaoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TAdmCartaoModel = class

  private
    vIConexao : IConexao;

    FAdmCartaosLista: TObjectList<TAdmCartaoModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FNOME_WEB: Variant;
    FPARCELADO_ADM: Variant;
    FTAXA: Variant;
    FCOMISSAO_ADM: Variant;
    FPORTADOR_ID: Variant;
    FNOME_ADM: Variant;
    FCREDITO_ADM: Variant;
    FID: Variant;
    FIMAGEM: Variant;
    FVENCIMENTO_DIA_SEMANA: Variant;
    FLOJA: Variant;
    FSTATUS: Variant;
    FSYSTIME: Variant;
    FDEBITO_ADM: Variant;
    FGERENCIADOR: Variant;
    FCONCILIADORA_ID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetAdmCartaosLista(const Value: TObjectList<TAdmCartaoModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCOMISSAO_ADM(const Value: Variant);
    procedure SetCONCILIADORA_ID(const Value: Variant);
    procedure SetCREDITO_ADM(const Value: Variant);
    procedure SetDEBITO_ADM(const Value: Variant);
    procedure SetGERENCIADOR(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIMAGEM(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetNOME_ADM(const Value: Variant);
    procedure SetNOME_WEB(const Value: Variant);
    procedure SetPARCELADO_ADM(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAXA(const Value: Variant);
    procedure SetVENCIMENTO_DIA_SEMANA(const Value: Variant);
  public
    property ID                    : Variant read FID write SetID;
    property NOME_ADM              : Variant read FNOME_ADM write SetNOME_ADM;
    property CREDITO_ADM           : Variant read FCREDITO_ADM write SetCREDITO_ADM;
    property DEBITO_ADM            : Variant read FDEBITO_ADM write SetDEBITO_ADM;
    property PARCELADO_ADM         : Variant read FPARCELADO_ADM write SetPARCELADO_ADM;
    property STATUS                : Variant read FSTATUS write SetSTATUS;
    property COMISSAO_ADM          : Variant read FCOMISSAO_ADM write SetCOMISSAO_ADM;
    property LOJA                  : Variant read FLOJA write SetLOJA;
    property GERENCIADOR           : Variant read FGERENCIADOR write SetGERENCIADOR;
    property VENCIMENTO_DIA_SEMANA : Variant read FVENCIMENTO_DIA_SEMANA write SetVENCIMENTO_DIA_SEMANA;
    property PORTADOR_ID           : Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property IMAGEM                : Variant read FIMAGEM write SetIMAGEM;
    property TAXA                  : Variant read FTAXA write SetTAXA;
    property SYSTIME               : Variant read FSYSTIME write SetSYSTIME;
    property NOME_WEB              : Variant read FNOME_WEB write SetNOME_WEB;
    property CONCILIADORA_ID       : Variant read FCONCILIADORA_ID write SetCONCILIADORA_ID;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;

    function carregaClasse(pId: String): TAdmCartaoModel;

    property AdmCartaosLista: TObjectList<TAdmCartaoModel> read FAdmCartaosLista write SetAdmCartaosLista;
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
  AdmCartaoDao;

{ TAdmCartaoModel }

function TAdmCartaoModel.carregaClasse(pId: String): TAdmCartaoModel;
var
  lAdmCartaoDao: TAdmCartaoDao;
begin
  lAdmCartaoDao := TAdmCartaoDao.Create(vIConexao);

  try
    Result := lAdmCartaoDao.carregaClasse(pId);
  finally
    lAdmCartaoDao.Free;
  end;
end;

constructor TAdmCartaoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TAdmCartaoModel.Destroy;
begin

  inherited;
end;

procedure TAdmCartaoModel.obterLista;
var
  lAdmCartaoLista: TAdmCartaoDao;
begin
  lAdmCartaoLista := TAdmCartaoDao.Create(vIConexao);

  try
    lAdmCartaoLista.TotalRecords    := FTotalRecords;
    lAdmCartaoLista.WhereView       := FWhereView;
    lAdmCartaoLista.CountView       := FCountView;
    lAdmCartaoLista.OrderView       := FOrderView;
    lAdmCartaoLista.StartRecordView := FStartRecordView;
    lAdmCartaoLista.LengthPageView  := FLengthPageView;
    lAdmCartaoLista.IDRecordView    := FIDRecordView;

    lAdmCartaoLista.obterLista;

    FTotalRecords  := lAdmCartaoLista.TotalRecords;
    FAdmCartaosLista := lAdmCartaoLista.AdmCartaosLista;

  finally
    lAdmCartaoLista.Free;
  end;
end;

function TAdmCartaoModel.Salvar: String;
var
  lAdmCartaoDao: TAdmCartaoDao;
begin
  lAdmCartaoDao := TAdmCartaoDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lAdmCartaoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lAdmCartaoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lAdmCartaoDao.excluir(Self);
    end;

  finally
    lAdmCartaoDao.Free;
  end;
end;

procedure TAdmCartaoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TAdmCartaoModel.SetCOMISSAO_ADM(const Value: Variant);
begin
  FCOMISSAO_ADM := Value;
end;

procedure TAdmCartaoModel.SetCONCILIADORA_ID(const Value: Variant);
begin
  FCONCILIADORA_ID := Value;
end;

procedure TAdmCartaoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAdmCartaoModel.SetCREDITO_ADM(const Value: Variant);
begin
  FCREDITO_ADM := Value;
end;

procedure TAdmCartaoModel.SetDEBITO_ADM(const Value: Variant);
begin
  FDEBITO_ADM := Value;
end;

procedure TAdmCartaoModel.SetGERENCIADOR(const Value: Variant);
begin
  FGERENCIADOR := Value;
end;

procedure TAdmCartaoModel.SetAdmCartaosLista(const Value: TObjectList<TAdmCartaoModel>);
begin
  FAdmCartaosLista := Value;
end;

procedure TAdmCartaoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAdmCartaoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAdmCartaoModel.SetIMAGEM(const Value: Variant);
begin
  FIMAGEM := Value;
end;

procedure TAdmCartaoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAdmCartaoModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TAdmCartaoModel.SetNOME_ADM(const Value: Variant);
begin
  FNOME_ADM := Value;
end;

procedure TAdmCartaoModel.SetNOME_WEB(const Value: Variant);
begin
  FNOME_WEB := Value;
end;

procedure TAdmCartaoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAdmCartaoModel.SetPARCELADO_ADM(const Value: Variant);
begin
  FPARCELADO_ADM := Value;
end;

procedure TAdmCartaoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TAdmCartaoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAdmCartaoModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TAdmCartaoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TAdmCartaoModel.SetTAXA(const Value: Variant);
begin
  FTAXA := Value;
end;

procedure TAdmCartaoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAdmCartaoModel.SetVENCIMENTO_DIA_SEMANA(const Value: Variant);
begin
  FVENCIMENTO_DIA_SEMANA := Value;
end;

procedure TAdmCartaoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
