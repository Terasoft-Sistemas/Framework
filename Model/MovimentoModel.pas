unit MovimentoModel;

interface

uses
  Spring.Collections,
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TMovimentoModel = class;
  ITMovimentoModel=IObject<TMovimentoModel>;

  TMovimentoModel = class
  private
    [unsafe] mySelf: ITMovimentoModel;
    vIConexao : IConexao;
    FMovimentosLista: IList<ITMovimentoModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FID_ORIGEM: Variant;
    FDATAHORA: Variant;
    FCODIGO_FOR: Variant;
    FCUSTO_ATUAL: Variant;
    FDOCUMENTO_MOV: Variant;
    FTIPO_DOC: Variant;
    FVENDA_ATUAL: Variant;
    FDATA_DOC: Variant;
    FID: Variant;
    FQUANTIDADE_MOV: Variant;
    FLOJA: Variant;
    FSTATUS: Variant;
    FCODIGO_PRO: Variant;
    FSYSTIME: Variant;
    FDATA_MOV: Variant;
    FTABELA_ORIGEM: Variant;
    FOBS_MOV: Variant;
    FUSUARIO_ID: Variant;
    FVALOR_MOV: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetMovimentosLista(const Value: IList<ITMovimentoModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCODIGO_PRO(const Value: Variant);
    procedure SetCUSTO_ATUAL(const Value: Variant);
    procedure SetDATA_DOC(const Value: Variant);
    procedure SetDATA_MOV(const Value: Variant);
    procedure SetDATAHORA(const Value: Variant);
    procedure SetDOCUMENTO_MOV(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetID_ORIGEM(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetOBS_MOV(const Value: Variant);
    procedure SetQUANTIDADE_MOV(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTABELA_ORIGEM(const Value: Variant);
    procedure SetTIPO_DOC(const Value: Variant);
    procedure SetUSUARIO_ID(const Value: Variant);
    procedure SetVALOR_MOV(const Value: Variant);
    procedure SetVENDA_ATUAL(const Value: Variant);

  public

    property DOCUMENTO_MOV: Variant read FDOCUMENTO_MOV write SetDOCUMENTO_MOV;
    property CODIGO_PRO: Variant read FCODIGO_PRO write SetCODIGO_PRO;
    property CODIGO_FOR: Variant read FCODIGO_FOR write SetCODIGO_FOR;
    property OBS_MOV: Variant read FOBS_MOV write SetOBS_MOV;
    property TIPO_DOC: Variant read FTIPO_DOC write SetTIPO_DOC;
    property DATA_MOV: Variant read FDATA_MOV write SetDATA_MOV;
    property DATA_DOC: Variant read FDATA_DOC write SetDATA_DOC;
    property QUANTIDADE_MOV: Variant read FQUANTIDADE_MOV write SetQUANTIDADE_MOV;
    property VALOR_MOV: Variant read FVALOR_MOV write SetVALOR_MOV;
    property CUSTO_ATUAL: Variant read FCUSTO_ATUAL write SetCUSTO_ATUAL;
    property VENDA_ATUAL: Variant read FVENDA_ATUAL write SetVENDA_ATUAL;
    property STATUS: Variant read FSTATUS write SetSTATUS;
    property LOJA: Variant read FLOJA write SetLOJA;
    property ID: Variant read FID write SetID;
    property USUARIO_ID: Variant read FUSUARIO_ID write SetUSUARIO_ID;
    property DATAHORA: Variant read FDATAHORA write SetDATAHORA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property TABELA_ORIGEM: Variant read FTABELA_ORIGEM write SetTABELA_ORIGEM;
    property ID_ORIGEM: Variant read FID_ORIGEM write SetID_ORIGEM;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITMovimentoModel;

    function Salvar: String;
    procedure obterLista;
    function carregaClasse(pId: String): ITMovimentoModel;
    function obterListaMemTable : IFDDataset;
    function obterFichaProduto(pFicha_Parametros : TFicha_Parametros) : IFDDataset;

    property MovimentosLista: IList<ITMovimentoModel> read FMovimentosLista write SetMovimentosLista;
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
  MovimentoDao;

{ TMovimentoModel }

function TMovimentoModel.carregaClasse(pId: String): ITMovimentoModel;
var
  lMovimentoDao: ITMovimentoDao;
begin
  lMovimentoDao := TMovimentoDao.getNewIface(vIConexao);
  try
    Result := lMovimentoDao.objeto.carregaClasse(pId);
  finally
    lMovimentoDao:=nil;
  end;
end;

constructor TMovimentoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TMovimentoModel.Destroy;
begin
  FMovimentosLista:=nil;
  vIConexao:=nil;
  inherited;
end;

class function TMovimentoModel.getNewIface(pIConexao: IConexao): ITMovimentoModel;
begin
  Result := TImplObjetoOwner<TMovimentoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TMovimentoModel.obterFichaProduto(pFicha_Parametros: TFicha_Parametros): IFDDataset;
var
  lMovimento : ITMovimentoDao;
  lFichaParametros : TFicha_Parametros;
begin
  lMovimento := TMovimentoDao.getNewIface(vIConexao);
  try
    lFichaParametros.CodigoProduto := pFicha_Parametros.CodigoProduto;
    lFichaParametros.DataInicio    := pFicha_Parametros.DataInicio;
    lFichaParametros.DataFim       := pFicha_Parametros.DataFim;

    Result := lMovimento.objeto.obterFichaProduto(lFichaParametros);
  finally
    lMovimento := nil;
  end;
end;

procedure TMovimentoModel.obterLista;
var
  lMovimentoLista: ITMovimentoDao;
begin
  lMovimentoLista := TMovimentoDao.getNewIface(vIConexao);

  try
    lMovimentoLista.objeto.TotalRecords    := FTotalRecords;
    lMovimentoLista.objeto.WhereView       := FWhereView;
    lMovimentoLista.objeto.CountView       := FCountView;
    lMovimentoLista.objeto.OrderView       := FOrderView;
    lMovimentoLista.objeto.StartRecordView := FStartRecordView;
    lMovimentoLista.objeto.LengthPageView  := FLengthPageView;
    lMovimentoLista.objeto.IDRecordView    := FIDRecordView;

    lMovimentoLista.objeto.obterLista;

    FTotalRecords  := lMovimentoLista.objeto.TotalRecords;
    FMovimentosLista := lMovimentoLista.objeto.MovimentosLista;

  finally
    lMovimentoLista:=nil;
  end;
end;

function TMovimentoModel.obterListaMemTable: IFDDataset;
var
  lMovimento: ITMovimentoDao;
begin
  lMovimento := TMovimentoDao.getNewIface(vIConexao);
  try
    lMovimento.objeto.TotalRecords    := FTotalRecords;
    lMovimento.objeto.WhereView       := FWhereView;
    lMovimento.objeto.CountView       := FCountView;
    lMovimento.objeto.OrderView       := FOrderView;
    lMovimento.objeto.StartRecordView := FStartRecordView;
    lMovimento.objeto.LengthPageView  := FLengthPageView;
    lMovimento.objeto.IDRecordView    := FIDRecordView;

    Result := lMovimento.objeto.obterListaMemTable;

    FTotalRecords := lMovimento.objeto.TotalRecords;
  finally
    lMovimento:=nil;
  end;
end;

function TMovimentoModel.Salvar: String;
var
  lMovimentoDao: ITMovimentoDao;
begin
  lMovimentoDao := TMovimentoDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lMovimentoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lMovimentoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lMovimentoDao.objeto.excluir(mySelf);
    end;

  finally
    lMovimentoDao:=nil;
  end;
end;

procedure TMovimentoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TMovimentoModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;

procedure TMovimentoModel.SetCODIGO_PRO(const Value: Variant);
begin
  FCODIGO_PRO := Value;
end;

procedure TMovimentoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMovimentoModel.SetCUSTO_ATUAL(const Value: Variant);
begin
  FCUSTO_ATUAL := Value;
end;

procedure TMovimentoModel.SetDATAHORA(const Value: Variant);
begin
  FDATAHORA := Value;
end;

procedure TMovimentoModel.SetDATA_DOC(const Value: Variant);
begin
  FDATA_DOC := Value;
end;

procedure TMovimentoModel.SetDATA_MOV(const Value: Variant);
begin
  FDATA_MOV := Value;
end;

procedure TMovimentoModel.SetDOCUMENTO_MOV(const Value: Variant);
begin
  FDOCUMENTO_MOV := Value;
end;

procedure TMovimentoModel.SetMovimentosLista;
begin
  FMovimentosLista := Value;
end;

procedure TMovimentoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMovimentoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TMovimentoModel.SetID_ORIGEM(const Value: Variant);
begin
  FID_ORIGEM := Value;
end;

procedure TMovimentoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMovimentoModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TMovimentoModel.SetOBS_MOV(const Value: Variant);
begin
  FOBS_MOV := Value;
end;

procedure TMovimentoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TMovimentoModel.SetQUANTIDADE_MOV(const Value: Variant);
begin
  FQUANTIDADE_MOV := Value;
end;

procedure TMovimentoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TMovimentoModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TMovimentoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TMovimentoModel.SetTABELA_ORIGEM(const Value: Variant);
begin
  FTABELA_ORIGEM := Value;
end;

procedure TMovimentoModel.SetTIPO_DOC(const Value: Variant);
begin
  FTIPO_DOC := Value;
end;

procedure TMovimentoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TMovimentoModel.SetUSUARIO_ID(const Value: Variant);
begin
  FUSUARIO_ID := Value;
end;

procedure TMovimentoModel.SetVALOR_MOV(const Value: Variant);
begin
  FVALOR_MOV := Value;
end;

procedure TMovimentoModel.SetVENDA_ATUAL(const Value: Variant);
begin
  FVENDA_ATUAL := Value;
end;

procedure TMovimentoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
