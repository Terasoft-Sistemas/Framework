unit OSDao;

interface

uses
  OSModel,
  Terasoft.Utils,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TOSDao = class;
  ITOSDao=IObject<TOSDao>;

  TOSDao = class
  private
    [weak] mySelf: ITOSDao;
    vIConexao : IConexao;

    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;
    procedure SetIDRecordView(const Value: String);

    var
      vConstrutorDao : IConstrutorDao;

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITOSDao;

    property TotalRecords      : Integer      read FTotalRecords        write SetTotalRecords;
    property WhereView         : String       read FWhereView           write SetWhereView;
    property CountView         : String       read FCountView           write SetCountView;
    property OrderView         : String       read FOrderView           write SetOrderView;
    property StartRecordView   : String       read FStartRecordView     write SetStartRecordView;
    property LengthPageView    : String       read FLengthPageView      write SetLengthPageView;
    property IDRecordView      : String read FIDRecordView write SetIDRecordView;

    function incluir(pOSModel: ITOSModel): String;
    function alterar(pOSModel: ITOSModel): String;
    function excluir(pOSModel: ITOSModel): String;

    function carregaClasse(pID : String): ITOSModel;

    procedure setParams(var pQry : TFDQuery; pOSModel: ITOSModel);

    function ObterLista: IFDDataset;
end;

implementation

{ TOS }

function TOSDao.carregaClasse(pID: String): ITOSModel;
var
  lQry: TFDQuery;
  lModel: ITOSModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TOSModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from OS where numero_os = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_OS                := lQry.FieldByName('NUMERO_OS').AsString;
    lModel.objeto.CODIGO_CLI               := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.objeto.DATA_OS                  := lQry.FieldByName('DATA_OS').AsString;
    lModel.objeto.ORCAMENTO_OS             := lQry.FieldByName('ORCAMENTO_OS').AsString;
    lModel.objeto.APROVACAO_OS             := lQry.FieldByName('APROVACAO_OS').AsString;
    lModel.objeto.MANUTENCAO_OS            := lQry.FieldByName('MANUTENCAO_OS').AsString;
    lModel.objeto.FECHAMENTO_OS            := lQry.FieldByName('FECHAMENTO_OS').AsString;
    lModel.objeto.ENTREGA_OS               := lQry.FieldByName('ENTREGA_OS').AsString;
    lModel.objeto.PREVISAO_OS              := lQry.FieldByName('PREVISAO_OS').AsString;
    lModel.objeto.RESPONSAVEL_OS           := lQry.FieldByName('RESPONSAVEL_OS').AsString;
    lModel.objeto.VALORPECAS_OS            := lQry.FieldByName('VALORPECAS_OS').AsString;
    lModel.objeto.DESLOCAMENTO_OS          := lQry.FieldByName('DESLOCAMENTO_OS').AsString;
    lModel.objeto.TOTAL_OS                 := lQry.FieldByName('TOTAL_OS').AsString;
    lModel.objeto.DESCONTO_OS              := lQry.FieldByName('DESCONTO_OS').AsString;
    lModel.objeto.OBSERVACAO_OS            := lQry.FieldByName('OBSERVACAO_OS').AsString;
    lModel.objeto.RECLAMADO_OS             := lQry.FieldByName('RECLAMADO_OS').AsString;
    lModel.objeto.PROBLEMA_OS              := lQry.FieldByName('PROBLEMA_OS').AsString;
    lModel.objeto.SOLUCAO_OS               := lQry.FieldByName('SOLUCAO_OS').AsString;
    lModel.objeto.AUTORIZA_OS              := lQry.FieldByName('AUTORIZA_OS').AsString;
    lModel.objeto.HORA_OS                  := lQry.FieldByName('HORA_OS').AsString;
    lModel.objeto.CODIGO_TEC               := lQry.FieldByName('CODIGO_TEC').AsString;
    lModel.objeto.CODIGO_SIT               := lQry.FieldByName('CODIGO_SIT').AsString;
    lModel.objeto.PRODUTO_OS               := lQry.FieldByName('PRODUTO_OS').AsString;
    lModel.objeto.PRIMEIROVEN_OS           := lQry.FieldByName('PRIMEIROVEN_OS').AsString;
    lModel.objeto.QTDEPARCELA_OS           := lQry.FieldByName('QTDEPARCELA_OS').AsString;
    lModel.objeto.HORAORCA_OS              := lQry.FieldByName('HORAORCA_OS').AsString;
    lModel.objeto.HORAAPROVA_OS            := lQry.FieldByName('HORAAPROVA_OS').AsString;
    lModel.objeto.HORAMANU_OS              := lQry.FieldByName('HORAMANU_OS').AsString;
    lModel.objeto.HORAENTREGA_OS           := lQry.FieldByName('HORAENTREGA_OS').AsString;
    lModel.objeto.USUARIO_OS               := lQry.FieldByName('USUARIO_OS').AsString;
    lModel.objeto.CODIGO_TIP               := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.objeto.DESCRICAOO_OS            := lQry.FieldByName('DESCRICAOO_OS').AsString;
    lModel.objeto.MODELO_OS                := lQry.FieldByName('MODELO_OS').AsString;
    lModel.objeto.MARCA_OS                 := lQry.FieldByName('MARCA_OS').AsString;
    lModel.objeto.MAOOBRA_OS               := lQry.FieldByName('MAOOBRA_OS').AsString;
    lModel.objeto.USUARIOABERTURA_OS       := lQry.FieldByName('USUARIOABERTURA_OS').AsString;
    lModel.objeto.STATUS_OS                := lQry.FieldByName('STATUS_OS').AsString;
    lModel.objeto.FONE_OS                  := lQry.FieldByName('FONE_OS').AsString;
    lModel.objeto.ENTRADA_OS               := lQry.FieldByName('ENTRADA_OS').AsString;
    lModel.objeto.ACRESCIMO_OS             := lQry.FieldByName('ACRESCIMO_OS').AsString;
    lModel.objeto.VALORPARCELA_OS          := lQry.FieldByName('VALORPARCELA_OS').AsString;
    lModel.objeto.CODIGO_PRT               := lQry.FieldByName('CODIGO_PRT').AsString;
    lModel.objeto.TIPO_OS                  := lQry.FieldByName('TIPO_OS').AsString;
    lModel.objeto.TOTALPAGAR_OS            := lQry.FieldByName('TOTALPAGAR_OS').AsString;
    lModel.objeto.COMISSAO_OS              := lQry.FieldByName('COMISSAO_OS').AsString;
    lModel.objeto.SITUACAO_OS              := lQry.FieldByName('SITUACAO_OS').AsString;
    lModel.objeto.TABJUROS_OS              := lQry.FieldByName('TABJUROS_OS').AsString;
    lModel.objeto.CTR_IMPRESSAO_PED        := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
    lModel.objeto.LOJA                     := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.DESC_OS                  := lQry.FieldByName('DESC_OS').AsString;
    lModel.objeto.HISTORICO_OS             := lQry.FieldByName('HISTORICO_OS').AsString;
    lModel.objeto.USUARIO_FECHAMENTO_OS    := lQry.FieldByName('USUARIO_FECHAMENTO_OS').AsString;
    lModel.objeto.LOG_OS                   := lQry.FieldByName('LOG_OS').AsString;
    lModel.objeto.KM_OS                    := lQry.FieldByName('KM_OS').AsString;
    lModel.objeto.PLACA                    := lQry.FieldByName('PLACA').AsString;
    lModel.objeto.ID                       := lQry.FieldByName('ID').AsString;
    lModel.objeto.DESCONTO_ADD             := lQry.FieldByName('DESCONTO_ADD').AsString;
    lModel.objeto.DATAHORA_INI             := lQry.FieldByName('DATAHORA_INI').AsString;
    lModel.objeto.DATAHORA_FIM             := lQry.FieldByName('DATAHORA_FIM').AsString;
    lModel.objeto.STATUS_ID                := lQry.FieldByName('STATUS_ID').AsString;
    lModel.objeto.CARGA_ID                 := lQry.FieldByName('CARGA_ID').AsString;
    lModel.objeto.ORDEM                    := lQry.FieldByName('ORDEM').AsString;
    lModel.objeto.NUMERO_NF                := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.objeto.ANO                      := lQry.FieldByName('ANO').AsString;
    lModel.objeto.FATURA_ID                := lQry.FieldByName('FATURA_ID').AsString;
    lModel.objeto.DATA_FECHAMENTO_OLD      := lQry.FieldByName('DATA_FECHAMENTO_OLD').AsString;
    lModel.objeto.HORA_FECHAMENTO_OLD      := lQry.FieldByName('HORA_FECHAMENTO_OLD').AsString;
    lModel.objeto.CNPJ_CPF_CONSUMIDOR      := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
    lModel.objeto.ENTRADA_PORTADOR_ID      := lQry.FieldByName('ENTRADA_PORTADOR_ID').AsString;
    lModel.objeto.NUMERO_NFSE              := lQry.FieldByName('NUMERO_NFSE').AsString;
    lModel.objeto.CONTRATO_OTTO_ID         := lQry.FieldByName('CONTRATO_OTTO_ID').AsString;
    lModel.objeto.SYSTIME                  := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.CTR_MSG                  := lQry.FieldByName('CTR_MSG').AsString;
    lModel.objeto.QTD_MSG                  := lQry.FieldByName('QTD_MSG').AsString;
    lModel.objeto.CONDICOES_PAG            := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.objeto.MOTOR                    := lQry.FieldByName('MOTOR').AsString;
    lModel.objeto.TRANSMISSAO              := lQry.FieldByName('TRANSMISSAO').AsString;


    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TOSDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutorDao := TConstrutorDao.Create(vIConexao);
end;

destructor TOSDao.Destroy;
begin
  vConstrutorDao:=nil;
  inherited;
end;

function TOSDao.incluir(pOSModel: ITOSModel): String;
var
  lQry  : TFDQuery;
  lSQL  : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSQL := vConstrutorDao.gerarInsert('OS', 'NUMERO_OS');

    lQry.SQL.Add(lSQL);
    pOSModel.objeto.NUMERO_OS := vIConexao.Generetor('GEN_OS');
    setParams(lQry, pOSModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_OS').AsString;
  finally
    lQry.Free;
  end;
end;

function TOSDao.alterar(pOSModel: ITOSModel): String;
var
  lQry      : TFDQuery;
  lSQL      : String;
begin
  lQry      := vIConexao.CriarQuery;

  lSQL := vConstrutorDao.gerarUpdate('OS', 'NUMERO_OS');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pOSModel);
    lQry.ExecSQL;

    Result := pOSModel.objeto.NUMERO_OS;

  finally
    lQry.Free;
  end;
end;

function TOSDao.excluir(pOSModel: ITOSModel): String;
var
  lQry     : TFDQuery;
begin
  lQry     := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from OS where NUMERO_OS = :NUMERO_OS',[pOSModel.objeto.NUMERO_OS]);
   lQry.ExecSQL;

   Result := pOSModel.objeto.NUMERO_OS;
  finally
    lQry.Free;
  end;
end;

class function TOSDao.getNewIface(pIConexao: IConexao): ITOSDao;
begin
  Result := TImplObjetoOwner<TOSDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TOSDao.where: String;
var
  lSQL: String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and OS.NUMERO_OS = '+ QuotedStr(FIDRecordView);

  Result := lSql;
end;

procedure TOSDao.obterTotalRegistros;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From OS where 1=1 ';

    lSQL := lSQL + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TOSDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := 'select '+lPaginacao+' * From OS where 1=1 ';
    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutorDao.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TOSDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TOSDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TOSDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TOSDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TOSDao.setParams(var pQry: TFDQuery; pOSModel: ITOSModel);
begin
  vConstrutorDao.setParams('OS',pQry,pOSModel.objeto);
end;

procedure TOSDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TOSDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TOSDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
