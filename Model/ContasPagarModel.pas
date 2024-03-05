unit ContasPagarModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TContasPagarModel = class

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
    FSUB_ID: Variant;
    FPREVISAO: Variant;
    FGESTAO_PAGAMENTO: Variant;
    FLOCAL_BAIXA: Variant;
    FGESTAO_PAGAMENTO_CONTA_FAVORECI: Variant;
    FCENTRO_CUSTO: Variant;
    FCODIGO_FOR: Variant;
    FPORTADOR_ID: Variant;
    FOBS_PAG: Variant;
    FFUNCIONARIO_ID: Variant;
    FDUPLICATA_PAG: Variant;
    FVALOR_PAG: Variant;
    FOBS_COMPLEMENTAR: Variant;
    FPRIMEIRO_VENC: Variant;
    FGESTAO_PAGAMENTO_BANCO_FAVORECI: Variant;
    FCODIGO_CTA: Variant;
    FGESTAO_PAGAMENTO_FORMA_ID: Variant;
    FID: Variant;
    FEMPRESTIMO_RECEBER_ID: Variant;
    FLOJA: Variant;
    FCONDICOES_PAG: Variant;
    FDATACOM_PAG: Variant;
    FLOCACAO_ID: Variant;
    FGESTAO_PAGAMENTO_NOME_FAVORECID: Variant;
    FGESTAO_PAGAMENTO_TIPO_ID: Variant;
    FSYSTIME: Variant;
    FDUPLICATA_REP: Variant;
    FDATAEMI_PAG: Variant;
    FSITUACAO_PAG: Variant;
    FDUPLICATA_ANTIGA: Variant;
    FCOMPETENCIA: Variant;
    FTIPO: Variant;
    FGESTAO_PAGAMENTO_AGENCIA_FAVORE: Variant;
    FUSUARIO_PAG: Variant;
    FOS_ID: Variant;
    FTIPO_PAG: Variant;
    FFornecedorView: Variant;
    FDuplicataView: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCENTRO_CUSTO(const Value: Variant);
    procedure SetCODIGO_CTA(const Value: Variant);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCOMPETENCIA(const Value: Variant);
    procedure SetCONDICOES_PAG(const Value: Variant);
    procedure SetDATACOM_PAG(const Value: Variant);
    procedure SetDATAEMI_PAG(const Value: Variant);
    procedure SetDUPLICATA_ANTIGA(const Value: Variant);
    procedure SetDUPLICATA_PAG(const Value: Variant);
    procedure SetDUPLICATA_REP(const Value: Variant);
    procedure SetEMPRESTIMO_RECEBER_ID(const Value: Variant);
    procedure SetFUNCIONARIO_ID(const Value: Variant);
    procedure SetGESTAO_PAGAMENTO(const Value: Variant);
    procedure SetGESTAO_PAGAMENTO_AGENCIA_FAVORE(const Value: Variant);
    procedure SetGESTAO_PAGAMENTO_BANCO_FAVORECI(const Value: Variant);
    procedure SetGESTAO_PAGAMENTO_CONTA_FAVORECI(const Value: Variant);
    procedure SetGESTAO_PAGAMENTO_FORMA_ID(const Value: Variant);
    procedure SetGESTAO_PAGAMENTO_NOME_FAVORECID(const Value: Variant);
    procedure SetGESTAO_PAGAMENTO_TIPO_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLOCACAO_ID(const Value: Variant);
    procedure SetLOCAL_BAIXA(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetOBS_COMPLEMENTAR(const Value: Variant);
    procedure SetOBS_PAG(const Value: Variant);
    procedure SetOS_ID(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetPREVISAO(const Value: Variant);
    procedure SetPRIMEIRO_VENC(const Value: Variant);
    procedure SetSITUACAO_PAG(const Value: Variant);
    procedure SetSUB_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetTIPO_PAG(const Value: Variant);
    procedure SetUSUARIO_PAG(const Value: Variant);
    procedure SetVALOR_PAG(const Value: Variant);
    procedure SetFornecedorView(const Value: Variant);
    procedure SetDuplicataView(const Value: Variant);

  public

    property DUPLICATA_PAG                      : Variant  read FDUPLICATA_PAG write SetDUPLICATA_PAG;
    property CODIGO_FOR                         : Variant  read FCODIGO_FOR write SetCODIGO_FOR;
    property DATAEMI_PAG                        : Variant  read FDATAEMI_PAG write SetDATAEMI_PAG;
    property DATACOM_PAG                        : Variant  read FDATACOM_PAG write SetDATACOM_PAG;
    property VALOR_PAG                          : Variant  read FVALOR_PAG write SetVALOR_PAG;
    property OBS_PAG                            : Variant  read FOBS_PAG write SetOBS_PAG;
    property SITUACAO_PAG                       : Variant  read FSITUACAO_PAG write SetSITUACAO_PAG;
    property USUARIO_PAG                        : Variant  read FUSUARIO_PAG write SetUSUARIO_PAG;
    property TIPO_PAG                           : Variant  read FTIPO_PAG write SetTIPO_PAG;
    property CODIGO_CTA                         : Variant  read FCODIGO_CTA write SetCODIGO_CTA;
    property LOJA                               : Variant  read FLOJA write SetLOJA;
    property TIPO                               : Variant  read FTIPO write SetTIPO;
    property ID                                 : Variant  read FID write SetID;
    property LOCAL_BAIXA                        : Variant  read FLOCAL_BAIXA write SetLOCAL_BAIXA;
    property PORTADOR_ID                        : Variant  read FPORTADOR_ID write SetPORTADOR_ID;
    property OBS_COMPLEMENTAR                   : Variant  read FOBS_COMPLEMENTAR write SetOBS_COMPLEMENTAR;
    property SYSTIME                            : Variant  read FSYSTIME write SetSYSTIME;
    property DUPLICATA_ANTIGA                   : Variant  read FDUPLICATA_ANTIGA write SetDUPLICATA_ANTIGA;
    property SUB_ID                             : Variant  read FSUB_ID write SetSUB_ID;
    property LOCACAO_ID                         : Variant  read FLOCACAO_ID write SetLOCACAO_ID;
    property CENTRO_CUSTO                       : Variant  read FCENTRO_CUSTO write SetCENTRO_CUSTO;
    property EMPRESTIMO_RECEBER_ID              : Variant  read FEMPRESTIMO_RECEBER_ID write SetEMPRESTIMO_RECEBER_ID;
    property FUNCIONARIO_ID                     : Variant  read FFUNCIONARIO_ID write SetFUNCIONARIO_ID;
    property CONDICOES_PAG                      : Variant  read FCONDICOES_PAG write SetCONDICOES_PAG;
    property PRIMEIRO_VENC                      : Variant  read FPRIMEIRO_VENC write SetPRIMEIRO_VENC;
    property PREVISAO                           : Variant  read FPREVISAO write SetPREVISAO;
    property COMPETENCIA                        : Variant  read FCOMPETENCIA write SetCOMPETENCIA;
    property OS_ID                              : Variant  read FOS_ID write SetOS_ID;
    property GESTAO_PAGAMENTO_FORMA_ID          : Variant  read FGESTAO_PAGAMENTO_FORMA_ID write SetGESTAO_PAGAMENTO_FORMA_ID;
    property GESTAO_PAGAMENTO_TIPO_ID           : Variant  read FGESTAO_PAGAMENTO_TIPO_ID write SetGESTAO_PAGAMENTO_TIPO_ID;
    property GESTAO_PAGAMENTO                   : Variant  read FGESTAO_PAGAMENTO write SetGESTAO_PAGAMENTO;
    property GESTAO_PAGAMENTO_BANCO_FAVORECI    : Variant  read FGESTAO_PAGAMENTO_BANCO_FAVORECI write SetGESTAO_PAGAMENTO_BANCO_FAVORECI;
    property GESTAO_PAGAMENTO_AGENCIA_FAVORE    : Variant  read FGESTAO_PAGAMENTO_AGENCIA_FAVORE write SetGESTAO_PAGAMENTO_AGENCIA_FAVORE;
    property GESTAO_PAGAMENTO_NOME_FAVORECID    : Variant  read FGESTAO_PAGAMENTO_NOME_FAVORECID write SetGESTAO_PAGAMENTO_NOME_FAVORECID;
    property GESTAO_PAGAMENTO_CONTA_FAVORECI    : Variant  read FGESTAO_PAGAMENTO_CONTA_FAVORECI write SetGESTAO_PAGAMENTO_CONTA_FAVORECI;
    property DUPLICATA_REP                      : Variant  read FDUPLICATA_REP write SetDUPLICATA_REP;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID, pFornecedor : String): TContasPagarModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId, pFornecedor: String): TContasPagarModel;
    function obterLista: TFDMemTable;
    function obterValorEntrada(pEntrada, pFornecedor: String): TFDMemTable;
    procedure gerarDuplicatas(pID, pFornecedor : String);

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property FornecedorView :Variant read FFornecedorView write SetFornecedorView;
    property DuplicataView: Variant read FDuplicataView write SetDuplicataView;
  end;

implementation

uses
  ContasPagarDao, ContasPagarItensModel, System.Classes, System.SysUtils, System.Math,
  EntradaModel, Data.DB;

{ TContasPagarModel }

function TContasPagarModel.Alterar(pID, pFornecedor: String): TContasPagarModel;
var
  lContasPagarModel : TContasPagarModel;
begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);
  try
    lContasPagarModel       := lContasPagarModel.carregaClasse(pID, pFornecedor);
    lContasPagarModel.Acao  := tacAlterar;
    Result              	  := lContasPagarModel;
  finally
  end;
end;

function TContasPagarModel.Excluir(pID: String): String;
begin
  self.DUPLICATA_PAG := pID;
  self.FAcao         := tacExcluir;
  Result             := self.Salvar;
end;

procedure TContasPagarModel.gerarDuplicatas(pID, pFornecedor : String);
var
  lValorTotal,
  lValorParcela     : Double;
  lParcelas         : Integer;
  lCondicoes        : TStringList;
  lVencimento       : TDate;
  i                 : Integer;
  lContasPagarItensModel : TContasPagarItensModel;
begin

  lContasPagarItensModel := TContasPagarItensModel.Create(vIConexao);
  lCondicoes             := TStringList.Create;

  try
    self := self.carregaClasse(pID, pFornecedor);
    lValorTotal := self.FVALOR_PAG;

    lCondicoes.Delimiter := '/';
    lCondicoes.StrictDelimiter := True;
    lCondicoes.DelimitedText := self.FCONDICOES_PAG;

    lParcelas := lCondicoes.Count;

    lValorParcela := lValorTotal / lParcelas;

    for i := 0 to lParcelas -1 do
    begin
      lVencimento := StrToDate(self.DATAEMI_PAG) + StrToInt(lCondicoes.Strings[i]);

      lContasPagarItensModel.DUPLIACATA_PAG    := self.DUPLICATA_PAG;
      lContasPagarItensModel.CODIGO_FOR        := self.CODIGO_FOR;
      lContasPagarItensModel.VENC_PAG          := DateToStr(lVencimento);
      lContasPagarItensModel.PACELA_PAG        := (i+1).ToString;
      lContasPagarItensModel.TOTALPARCELAS     := lParcelas.ToString;
      lContasPagarItensModel.VALORPARCELA_PAG  := lValorParcela.ToString;
      lContasPagarItensModel.SITUACAO_PAG      := 'A';
      lContasPagarItensModel.LOJA              := self.LOJA;
      lContasPagarItensModel.PORTADOR_ID       := self.PORTADOR_ID;
      lContasPagarItensModel.VALORPARCELA_BASE := lValorParcela.ToString;
      lContasPagarItensModel.Incluir;
    end;

  finally
    lContasPagarItensModel.Free;
    lCondicoes.Free;
  end;

end;

function TContasPagarModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TContasPagarModel.carregaClasse(pId, pFornecedor: String): TContasPagarModel;
var
  lContasPagarDao: TContasPagarDao;
begin
  lContasPagarDao := TContasPagarDao.Create(vIConexao);

  try
    Result := lContasPagarDao.carregaClasse(pId, pFornecedor);
  finally
    lContasPagarDao.Free;
  end;
end;

constructor TContasPagarModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContasPagarModel.Destroy;
begin
  inherited;
end;

function TContasPagarModel.obterLista: TFDMemTable;
var
  lContasPagarLista: TContasPagarDao;
begin
  lContasPagarLista := TContasPagarDao.Create(vIConexao);

  try
    lContasPagarLista.TotalRecords    := FTotalRecords;
    lContasPagarLista.WhereView       := FWhereView;
    lContasPagarLista.CountView       := FCountView;
    lContasPagarLista.OrderView       := FOrderView;
    lContasPagarLista.StartRecordView := FStartRecordView;
    lContasPagarLista.LengthPageView  := FLengthPageView;
    lContasPagarLista.IDRecordView    := FIDRecordView;

    Result := lContasPagarLista.obterLista;

    FTotalRecords := lContasPagarLista.TotalRecords;

  finally
    lContasPagarLista.Free;
  end;
end;

function TContasPagarModel.Salvar: String;
var
  lContasPagarDao: TContasPagarDao;
begin
  lContasPagarDao := TContasPagarDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lContasPagarDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lContasPagarDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lContasPagarDao.excluir(Self);
    end;

  finally
    lContasPagarDao.Free;
  end;
end;

function TContasPagarModel.obterValorEntrada(pEntrada, pFornecedor: String): TFDMemTable;
var
  lContasPagarDao: TContasPagarDao;
  lEntradaModel: TEntradaModel;
  lTotalFinanceiro: Double;
  lTotalEntradaFornecedor: Double;
  lMemTable : TFDMemTable;
begin

  lContasPagarDao := TContasPagarDao.Create(vIConexao);
  lEntradaModel   := TEntradaModel.Create(vIConexao);
  lMemTable       := TFDMemTable.Create(nil);

  try
    lEntradaModel.NumeroView     := pEntrada;
    lEntradaModel.FornecedorView := pFornecedor;

    lTotalEntradaFornecedor := lEntradaModel.obterTotalizador.fieldByName('TOTAL_ENTRADA').AsFloat;
    lTotalFinanceiro        := lContasPagarDao.FinanceiroEntrada(pEntrada, pFornecedor);

    lMemTable.FieldDefs.Add('VALOR', ftFloat);
    lMemTable.CreateDataSet;

    lMemTable.InsertRecord([lTotalEntradaFornecedor - lTotalFinanceiro]);

    Result := lMemTable;

  finally
    lContasPagarDao.Free;
    lEntradaModel.Free;
  end;
end;

procedure TContasPagarModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TContasPagarModel.SetCENTRO_CUSTO(const Value: Variant);
begin
  FCENTRO_CUSTO := Value;
end;

procedure TContasPagarModel.SetCODIGO_CTA(const Value: Variant);
begin
  FCODIGO_CTA := Value;
end;

procedure TContasPagarModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;

procedure TContasPagarModel.SetCOMPETENCIA(const Value: Variant);
begin
  FCOMPETENCIA := Value;
end;

procedure TContasPagarModel.SetCONDICOES_PAG(const Value: Variant);
begin
  FCONDICOES_PAG := Value;
end;

procedure TContasPagarModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasPagarModel.SetDATACOM_PAG(const Value: Variant);
begin
  FDATACOM_PAG := Value;
end;

procedure TContasPagarModel.SetDATAEMI_PAG(const Value: Variant);
begin
  FDATAEMI_PAG := Value;
end;

procedure TContasPagarModel.SetDuplicataView(const Value: Variant);
begin
  FDuplicataView := Value;
end;

procedure TContasPagarModel.SetDUPLICATA_ANTIGA(const Value: Variant);
begin
  FDUPLICATA_ANTIGA := Value;
end;

procedure TContasPagarModel.SetDUPLICATA_PAG(const Value: Variant);
begin
  FDUPLICATA_PAG := Value;
end;

procedure TContasPagarModel.SetDUPLICATA_REP(const Value: Variant);
begin
  FDUPLICATA_REP := Value;
end;

procedure TContasPagarModel.SetEMPRESTIMO_RECEBER_ID(const Value: Variant);
begin
  FEMPRESTIMO_RECEBER_ID := Value;
end;

procedure TContasPagarModel.SetFornecedorView(const Value: Variant);
begin
  FFornecedorView := Value;
end;

procedure TContasPagarModel.SetFUNCIONARIO_ID(const Value: Variant);
begin
  FFUNCIONARIO_ID := Value;
end;

procedure TContasPagarModel.SetGESTAO_PAGAMENTO(const Value: Variant);
begin
  FGESTAO_PAGAMENTO := Value;
end;

procedure TContasPagarModel.SetGESTAO_PAGAMENTO_AGENCIA_FAVORE(
  const Value: Variant);
begin
  FGESTAO_PAGAMENTO_AGENCIA_FAVORE := Value;
end;

procedure TContasPagarModel.SetGESTAO_PAGAMENTO_BANCO_FAVORECI(
  const Value: Variant);
begin
  FGESTAO_PAGAMENTO_BANCO_FAVORECI := Value;
end;

procedure TContasPagarModel.SetGESTAO_PAGAMENTO_CONTA_FAVORECI(
  const Value: Variant);
begin
  FGESTAO_PAGAMENTO_CONTA_FAVORECI := Value;
end;

procedure TContasPagarModel.SetGESTAO_PAGAMENTO_FORMA_ID(const Value: Variant);
begin
  FGESTAO_PAGAMENTO_FORMA_ID := Value;
end;

procedure TContasPagarModel.SetGESTAO_PAGAMENTO_NOME_FAVORECID(
  const Value: Variant);
begin
  FGESTAO_PAGAMENTO_NOME_FAVORECID := Value;
end;

procedure TContasPagarModel.SetGESTAO_PAGAMENTO_TIPO_ID(const Value: Variant);
begin
  FGESTAO_PAGAMENTO_TIPO_ID := Value;
end;

procedure TContasPagarModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasPagarModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasPagarModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasPagarModel.SetLOCACAO_ID(const Value: Variant);
begin
  FLOCACAO_ID := Value;
end;

procedure TContasPagarModel.SetLOCAL_BAIXA(const Value: Variant);
begin
  FLOCAL_BAIXA := Value;
end;

procedure TContasPagarModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TContasPagarModel.SetOBS_COMPLEMENTAR(const Value: Variant);
begin
  FOBS_COMPLEMENTAR := Value;
end;

procedure TContasPagarModel.SetOBS_PAG(const Value: Variant);
begin
  FOBS_PAG := Value;
end;

procedure TContasPagarModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TContasPagarModel.SetOS_ID(const Value: Variant);
begin
  FOS_ID := Value;
end;

procedure TContasPagarModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TContasPagarModel.SetPREVISAO(const Value: Variant);
begin
  FPREVISAO := Value;
end;

procedure TContasPagarModel.SetPRIMEIRO_VENC(const Value: Variant);
begin
  FPRIMEIRO_VENC := Value;
end;

procedure TContasPagarModel.SetSITUACAO_PAG(const Value: Variant);
begin
  FSITUACAO_PAG := Value;
end;

procedure TContasPagarModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TContasPagarModel.SetSUB_ID(const Value: Variant);
begin
  FSUB_ID := Value;
end;

procedure TContasPagarModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TContasPagarModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TContasPagarModel.SetTIPO_PAG(const Value: Variant);
begin
  FTIPO_PAG := Value;
end;

procedure TContasPagarModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TContasPagarModel.SetUSUARIO_PAG(const Value: Variant);
begin
  FUSUARIO_PAG := Value;
end;

procedure TContasPagarModel.SetVALOR_PAG(const Value: Variant);
begin
  FVALOR_PAG := Value;
end;

procedure TContasPagarModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
