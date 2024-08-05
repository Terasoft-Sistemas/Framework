unit TabelaJurosPromocaoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TTabelaJurosPromocaoModel = class;
  ITTabelaJurosPromocaoModel=IObject<TTabelaJurosPromocaoModel>;

  TTabelaJurosPromocaoModel = class
  private
    [weak] mySelf: ITTabelaJurosPromocaoModel;
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

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITTabelaJurosPromocaoModel;

    function Incluir: String;
    function Alterar(pID : String): ITTabelaJurosPromocaoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITTabelaJurosPromocaoModel;
    function obterLista: IFDDataset;
    function obterTabelaJurosProduto(pProduto : String): IFDDataset;

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

function TTabelaJurosPromocaoModel.Alterar(pID: String): ITTabelaJurosPromocaoModel;
var
  lTabelaJurosPromocaoModel : ITTabelaJurosPromocaoModel;
begin
  lTabelaJurosPromocaoModel := TTabelaJurosPromocaoModel.getNewIface(vIConexao);
  try
    lTabelaJurosPromocaoModel       := lTabelaJurosPromocaoModel.objeto.carregaClasse(pID);
    lTabelaJurosPromocaoModel.objeto.Acao  := tacAlterar;
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

class function TTabelaJurosPromocaoModel.getNewIface(pIConexao: IConexao): ITTabelaJurosPromocaoModel;
begin
  Result := TImplObjetoOwner<TTabelaJurosPromocaoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TTabelaJurosPromocaoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TTabelaJurosPromocaoModel.carregaClasse(pId : String): ITTabelaJurosPromocaoModel;
var
  lTabelaJurosPromocaoDao: ITTabelaJurosPromocaoDao;
begin
  lTabelaJurosPromocaoDao := TTabelaJurosPromocaoDao.getNewIface(vIConexao);

  try
    Result := lTabelaJurosPromocaoDao.objeto.carregaClasse(pID);
  finally
    lTabelaJurosPromocaoDao:=nil;
  end;
end;

constructor TTabelaJurosPromocaoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTabelaJurosPromocaoModel.Destroy;
begin
  inherited;
end;

function TTabelaJurosPromocaoModel.obterLista: IFDDataset;
var
  lTabelaJurosPromocaoLista: ITTabelaJurosPromocaoDao;
begin
  lTabelaJurosPromocaoLista := TTabelaJurosPromocaoDao.getNewIface(vIConexao);

  try
    lTabelaJurosPromocaoLista.objeto.TotalRecords    := FTotalRecords;
    lTabelaJurosPromocaoLista.objeto.WhereView       := FWhereView;
    lTabelaJurosPromocaoLista.objeto.CountView       := FCountView;
    lTabelaJurosPromocaoLista.objeto.OrderView       := FOrderView;
    lTabelaJurosPromocaoLista.objeto.StartRecordView := FStartRecordView;
    lTabelaJurosPromocaoLista.objeto.LengthPageView  := FLengthPageView;
    lTabelaJurosPromocaoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lTabelaJurosPromocaoLista.objeto.obterLista;

    FTotalRecords := lTabelaJurosPromocaoLista.objeto.TotalRecords;

  finally
    lTabelaJurosPromocaoLista:=nil;
  end;
end;

function TTabelaJurosPromocaoModel.obterTabelaJurosProduto(pProduto: String): IFDDataset;
var
  lTabelaJurosPromocaoDao : ITTabelaJurosPromocaoDao;
begin
  lTabelaJurosPromocaoDao := TTabelaJurosPromocaoDao.getNewIface(vIConexao);

  try
    Result := lTabelaJurosPromocaoDao.objeto.obterTabelaJurosProduto(pProduto);
  finally
    lTabelaJurosPromocaoDao:=nil;
  end;
end;

function TTabelaJurosPromocaoModel.Salvar: String;
var
  lTabelaJurosPromocaoDao: ITTabelaJurosPromocaoDao;
begin
  lTabelaJurosPromocaoDao := TTabelaJurosPromocaoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lTabelaJurosPromocaoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lTabelaJurosPromocaoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lTabelaJurosPromocaoDao.objeto.excluir(mySelf);
    end;
  finally
    lTabelaJurosPromocaoDao:=nil;
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
