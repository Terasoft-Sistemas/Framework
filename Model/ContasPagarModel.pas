unit ContasPagarModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TContasPagarModel = class;
  ITContasPagarModel=IObject<TContasPagarModel>;

  TContasPagarModel = class
  private
    [unsafe] mySelf:  ITContasPagarModel;
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

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITContasPagarModel;

    function Incluir: String;
    function Alterar(pID, pFornecedor : String): ITContasPagarModel;
    function Excluir(pID, pFornecedor : String): String;
    function Salvar : String;

    function carregaClasse(pId, pFornecedor: String): ITContasPagarModel;
    function obterLista: IFDDataset;
    function obterValorEntrada(pEntrada, pFornecedor: String): IFDDataset;
    procedure gerarDuplicatas(pID, pFornecedor : String);
    procedure GerarFinanceiroEntrada;

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

function TContasPagarModel.Alterar(pID, pFornecedor: String): ITContasPagarModel;
var
  lContasPagarModel : ITContasPagarModel;
begin
  lContasPagarModel := TContasPagarModel.getNewIface(vIConexao);
  try
    lContasPagarModel       := lContasPagarModel.objeto.carregaClasse(pID, pFornecedor);
    lContasPagarModel.objeto.Acao  := tacAlterar;
    Result              	  := lContasPagarModel;
  finally
  end;
end;

function TContasPagarModel.Excluir(pID, pFornecedor: String): String;
begin
  self.DUPLICATA_PAG := pID;
  self.CODIGO_FOR    := pFornecedor;
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
  p: ITContasPagarModel;
  lContasPagarItensModel : ITContasPagarItensModel;
begin

  lContasPagarItensModel := TContasPagarItensModel.getNewIface(vIConexao);
  lCondicoes             := TStringList.Create;

  try
    p := p.objeto.carregaClasse(pID, pFornecedor);
    lValorTotal := p.objeto.FVALOR_PAG;

    lCondicoes.Delimiter := '/';
    lCondicoes.StrictDelimiter := True;
    lCondicoes.DelimitedText := p.objeto.FCONDICOES_PAG;

    lParcelas := lCondicoes.Count;

    lValorParcela := lValorTotal / lParcelas;

    for i := 0 to lParcelas -1 do
    begin
      lVencimento := StrToDate(p.objeto.DATAEMI_PAG) + StrToInt(lCondicoes.Strings[i]);

      lContasPagarItensModel.objeto.DUPLIACATA_PAG    := p.objeto.DUPLICATA_PAG;
      lContasPagarItensModel.objeto.CODIGO_FOR        := p.objeto.CODIGO_FOR;
      lContasPagarItensModel.objeto.VENC_PAG          := DateToStr(lVencimento);
      lContasPagarItensModel.objeto.PACELA_PAG        := (i+1).ToString;
      lContasPagarItensModel.objeto.TOTALPARCELAS     := lParcelas.ToString;
      lContasPagarItensModel.objeto.VALORPARCELA_PAG  := lValorParcela.ToString;
      lContasPagarItensModel.objeto.SITUACAO_PAG      := 'A';
      lContasPagarItensModel.objeto.LOJA              := p.objeto.LOJA;
      lContasPagarItensModel.objeto.PORTADOR_ID       := p.objeto.PORTADOR_ID;
      lContasPagarItensModel.objeto.VALORPARCELA_BASE := lValorParcela.ToString;
      lContasPagarItensModel.objeto.Incluir;
    end;

  finally
    lContasPagarItensModel:=nil;
    FreeAndNil(lCondicoes);
  end;

end;

procedure TContasPagarModel.GerarFinanceiroEntrada;
var
  lValorTotal,
  lValorParcela     : Double;
  lSoma             : Double;
  lParcelas         : Integer;
  lCondicoes        : TStringList;
  lVencimento       : TDate;
  i                 : Integer;
  lContasPagarItensModel : ITContasPagarItensModel;
  p: ITContasPagarModel;
begin

  lContasPagarItensModel := TContasPagarItensModel.getNewIface(vIConexao);
  lCondicoes             := TStringList.Create;

  try

    self.DUPLICATA_PAG  := DUPLICATA_PAG;
    self.CODIGO_FOR     := CODIGO_FOR;
    self.PORTADOR_ID    := PORTADOR_ID;
    self.DATAEMI_PAG    := DATAEMI_PAG;
    self.TIPO_PAG       := 'S';
    self.VALOR_PAG      := VALOR_PAG;
    self.CONDICOES_PAG  := CONDICOES_PAG;
    self.SITUACAO_PAG   := 'A';
    self.USUARIO_PAG    := USUARIO_PAG;
    self.OBS_PAG        := Copy(OBS_PAG,1,40);
    self.CODIGO_CTA     := CODIGO_CTA;
    self.LOJA           := LOJA;
    self.TIPO           := 'N';
    self.Incluir;

    p := self.carregaClasse(Self.DUPLICATA_PAG, Self.CODIGO_FOR);
    lValorTotal := p.objeto.FVALOR_PAG;

    lCondicoes.Delimiter := '/';
    lCondicoes.StrictDelimiter := True;
    lCondicoes.DelimitedText := self.FCONDICOES_PAG;

    lParcelas := lCondicoes.Count;

    lValorParcela := lValorTotal / lParcelas;

    for i := 0 to lParcelas -1 do
    begin
      lVencimento := StrToDate(p.objeto.DATAEMI_PAG) + StrToInt(lCondicoes.Strings[i]);

      lContasPagarItensModel.objeto.DUPLIACATA_PAG    := p.objeto.DUPLICATA_PAG;
      lContasPagarItensModel.objeto.CODIGO_FOR        := p.objeto.CODIGO_FOR;
      lContasPagarItensModel.objeto.VENC_PAG          := DateToStr(lVencimento);
      lContasPagarItensModel.objeto.PACELA_PAG        := (i+1).ToString;
      lContasPagarItensModel.objeto.TOTALPARCELAS     := lParcelas.ToString;
      lContasPagarItensModel.objeto.VALORPARCELA_PAG  := lValorParcela.ToString;
      lContasPagarItensModel.objeto.SITUACAO_PAG      := 'A';
      lContasPagarItensModel.objeto.LOJA              := p.objeto.LOJA;
      lContasPagarItensModel.objeto.PORTADOR_ID       := p.objeto.PORTADOR_ID;
      lContasPagarItensModel.objeto.VALORPARCELA_BASE := lValorParcela.ToString;

      lSoma := RoundTo(lSoma + StrToFloat(lValorParcela.ToString),-2);

      if i = lContasPagarItensModel.objeto.TOTALPARCELAS -1 then
       lContasPagarItensModel.objeto.VALORPARCELA_PAG := FloatToStr(StrToFloat(lValorParcela.ToString) + (p.objeto.VALOR_PAG - lSoma));


      lContasPagarItensModel.objeto.Incluir;
    end;

  finally
    lContasPagarItensModel:=nil;
    FreeAndNil(lCondicoes);
  end;

end;

class function TContasPagarModel.getNewIface(pIConexao: IConexao): ITContasPagarModel;
begin
  Result := TImplObjetoOwner<TContasPagarModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TContasPagarModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TContasPagarModel.carregaClasse(pId, pFornecedor: String): ITContasPagarModel;
var
  lContasPagarDao: ITContasPagarDao;
begin
  lContasPagarDao := TContasPagarDao.getNewIface(vIConexao);

  try
    Result := lContasPagarDao.objeto.carregaClasse(pId, pFornecedor);
  finally
    lContasPagarDao:=nil;
  end;
end;

constructor TContasPagarModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContasPagarModel.Destroy;
begin
  inherited;
end;

function TContasPagarModel.obterLista: IFDDataset;
var
  lContasPagarLista: ITContasPagarDao;
begin
  lContasPagarLista := TContasPagarDao.getNewIface(vIConexao);

  try
    lContasPagarLista.objeto.TotalRecords    := FTotalRecords;
    lContasPagarLista.objeto.WhereView       := FWhereView;
    lContasPagarLista.objeto.CountView       := FCountView;
    lContasPagarLista.objeto.OrderView       := FOrderView;
    lContasPagarLista.objeto.StartRecordView := FStartRecordView;
    lContasPagarLista.objeto.LengthPageView  := FLengthPageView;
    lContasPagarLista.objeto.IDRecordView    := FIDRecordView;
    lContasPagarLista.objeto.FornecedorView  := FFornecedorView;
    lContasPagarLista.objeto.DuplicataView   := FDuplicataView;

    Result := lContasPagarLista.objeto.obterLista;

    FTotalRecords := lContasPagarLista.objeto.TotalRecords;

  finally
    lContasPagarLista:=nil;
  end;
end;

function TContasPagarModel.Salvar: String;
var
  lContasPagarDao: ITContasPagarDao;
begin
  lContasPagarDao := TContasPagarDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lContasPagarDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lContasPagarDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lContasPagarDao.objeto.excluir(mySelf);
    end;

  finally
    lContasPagarDao:=nil;
  end;
end;

function TContasPagarModel.obterValorEntrada(pEntrada, pFornecedor: String): IFDDataset;
var
  lContasPagarDao: ITContasPagarDao;
  lEntradaModel: ITEntradaModel;
  lTotalFinanceiro: Double;
  lTotalEntradaFornecedor: Double;
  lMemTable : IFDDataset;
begin

  lContasPagarDao := TContasPagarDao.getNewIface(vIConexao);
  lEntradaModel   := TEntradaModel.getNewIface(vIConexao);
  lMemTable       := criaIFDDataset(TFDMemTable.Create(nil));

  try
    lEntradaModel.objeto.NumeroView     := pEntrada;
    lEntradaModel.objeto.FornecedorView := pFornecedor;

    lTotalEntradaFornecedor := lEntradaModel.objeto.obterTotalizador.objeto.fieldByName('TOTAL_ENTRADA').AsFloat;
    lTotalFinanceiro        := lContasPagarDao.objeto.FinanceiroEntrada(pEntrada, pFornecedor);

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('VALOR', ftFloat);
    TFDMemTable(lMemTable.objeto).CreateDataSet;

    lMemTable.objeto.InsertRecord([RoundTo(lTotalEntradaFornecedor - lTotalFinanceiro, -2)]);

    Result := lMemTable;

  finally
    lContasPagarDao:=nil;
    lEntradaModel:=nil;
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
