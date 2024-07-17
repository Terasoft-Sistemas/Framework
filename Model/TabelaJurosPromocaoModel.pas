unit TabelaJurosPromocaoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TTabelaJurosPromocaoModel = class

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
    FTAXA_JUROS: Variant;
    FPORTADOR_ID: Variant;
    FCOM_ENTRADA: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FPROMOCAO_ID: Variant;
    FLIMITADO_PARCELA: Variant;
    FPARCELA: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCOM_ENTRADA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLIMITADO_PARCELA(const Value: Variant);
    procedure SetPARCELA(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetPROMOCAO_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAXA_JUROS(const Value: Variant);

  public
    property ID                : Variant read FID write SetID;
    property PROMOCAO_ID       : Variant read FPROMOCAO_ID write SetPROMOCAO_ID;
    property PORTADOR_ID       : Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property PARCELA           : Variant read FPARCELA write SetPARCELA;
    property TAXA_JUROS        : Variant read FTAXA_JUROS write SetTAXA_JUROS;
    property SYSTIME           : Variant read FSYSTIME write SetSYSTIME;
    property COM_ENTRADA       : Variant read FCOM_ENTRADA write SetCOM_ENTRADA;
    property LIMITADO_PARCELA  : Variant read FLIMITADO_PARCELA write SetLIMITADO_PARCELA;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TTabelaJurosPromocaoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TTabelaJurosPromocaoModel;
    function obterLista: TFDMemTable;

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
  TabelaJurosPromocaoDao,  
  System.Classes, 
  System.SysUtils;

{ TTabelaJurosPromocaoModel }

function TTabelaJurosPromocaoModel.Alterar(pID: String): TTabelaJurosPromocaoModel;
var
  lTabelaJurosPromocaoModel : TTabelaJurosPromocaoModel;
begin
  lTabelaJurosPromocaoModel := TTabelaJurosPromocaoModel.Create(vIConexao);
  try
    lTabelaJurosPromocaoModel       := lTabelaJurosPromocaoModel.carregaClasse(pID);
    lTabelaJurosPromocaoModel.Acao  := tacAlterar;
    Result            	   := lTabelaJurosPromocaoModel;
  finally
  end;
end;

function TTabelaJurosPromocaoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TTabelaJurosPromocaoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TTabelaJurosPromocaoModel.carregaClasse(pId : String): TTabelaJurosPromocaoModel;
var
  lTabelaJurosPromocaoDao: TTabelaJurosPromocaoDao;
begin
  lTabelaJurosPromocaoDao := TTabelaJurosPromocaoDao.Create(vIConexao);

  try
    Result := lTabelaJurosPromocaoDao.carregaClasse(pID);
  finally
    lTabelaJurosPromocaoDao.Free;
  end;
end;

constructor TTabelaJurosPromocaoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTabelaJurosPromocaoModel.Destroy;
begin
  inherited;
end;

function TTabelaJurosPromocaoModel.obterLista: TFDMemTable;
var
  lTabelaJurosPromocaoLista: TTabelaJurosPromocaoDao;
begin
  lTabelaJurosPromocaoLista := TTabelaJurosPromocaoDao.Create(vIConexao);

  try
    lTabelaJurosPromocaoLista.TotalRecords    := FTotalRecords;
    lTabelaJurosPromocaoLista.WhereView       := FWhereView;
    lTabelaJurosPromocaoLista.CountView       := FCountView;
    lTabelaJurosPromocaoLista.OrderView       := FOrderView;
    lTabelaJurosPromocaoLista.StartRecordView := FStartRecordView;
    lTabelaJurosPromocaoLista.LengthPageView  := FLengthPageView;
    lTabelaJurosPromocaoLista.IDRecordView    := FIDRecordView;

    Result := lTabelaJurosPromocaoLista.obterLista;

    FTotalRecords := lTabelaJurosPromocaoLista.TotalRecords;

  finally
    lTabelaJurosPromocaoLista.Free;
  end;
end;

function TTabelaJurosPromocaoModel.Salvar: String;
var
  lTabelaJurosPromocaoDao: TTabelaJurosPromocaoDao;
begin
  lTabelaJurosPromocaoDao := TTabelaJurosPromocaoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lTabelaJurosPromocaoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lTabelaJurosPromocaoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lTabelaJurosPromocaoDao.excluir(Self);
    end;
  finally
    lTabelaJurosPromocaoDao.Free;
  end;
end;

procedure TTabelaJurosPromocaoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TTabelaJurosPromocaoModel.SetCOM_ENTRADA(const Value: Variant);
begin
  FCOM_ENTRADA := Value;
end;

procedure TTabelaJurosPromocaoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosPromocaoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosPromocaoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosPromocaoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosPromocaoModel.SetLIMITADO_PARCELA(const Value: Variant);
begin
  FLIMITADO_PARCELA := Value;
end;

procedure TTabelaJurosPromocaoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TTabelaJurosPromocaoModel.SetPARCELA(const Value: Variant);
begin
  FPARCELA := Value;
end;

procedure TTabelaJurosPromocaoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TTabelaJurosPromocaoModel.SetPROMOCAO_ID(const Value: Variant);
begin
  FPROMOCAO_ID := Value;
end;

procedure TTabelaJurosPromocaoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TTabelaJurosPromocaoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TTabelaJurosPromocaoModel.SetTAXA_JUROS(const Value: Variant);
begin
  FTAXA_JUROS := Value;
end;

procedure TTabelaJurosPromocaoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TTabelaJurosPromocaoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
