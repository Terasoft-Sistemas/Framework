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
  System.Rtti,
  Interfaces.Conexao;

type
  TOSDao = class

  private
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
      vConstrutorDao : TConstrutorDao;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property TotalRecords      : Integer      read FTotalRecords        write SetTotalRecords;
    property WhereView         : String       read FWhereView           write SetWhereView;
    property CountView         : String       read FCountView           write SetCountView;
    property OrderView         : String       read FOrderView           write SetOrderView;
    property StartRecordView   : String       read FStartRecordView     write SetStartRecordView;
    property LengthPageView    : String       read FLengthPageView      write SetLengthPageView;
    property IDRecordView      : String read FIDRecordView write SetIDRecordView;

    function incluir(pOSModel: TOSModel): String;
    function alterar(pOSModel: TOSModel): String;
    function excluir(pOSModel: TOSModel): String;

    function carregaClasse(pID : String): TOSModel;

    procedure setParams(var pQry : TFDQuery; pOSModel: TOSModel);

    function ObterLista: IFDDataset;
end;

implementation

{ TOS }

function TOSDao.carregaClasse(pID: String): TOSModel;
var
  lQry: TFDQuery;
  lModel: TOSModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TOSModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from OS where numero_os = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_OS                := lQry.FieldByName('NUMERO_OS').AsString;
    lModel.CODIGO_CLI               := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.DATA_OS                  := lQry.FieldByName('DATA_OS').AsString;
    lModel.ORCAMENTO_OS             := lQry.FieldByName('ORCAMENTO_OS').AsString;
    lModel.APROVACAO_OS             := lQry.FieldByName('APROVACAO_OS').AsString;
    lModel.MANUTENCAO_OS            := lQry.FieldByName('MANUTENCAO_OS').AsString;
    lModel.FECHAMENTO_OS            := lQry.FieldByName('FECHAMENTO_OS').AsString;
    lModel.ENTREGA_OS               := lQry.FieldByName('ENTREGA_OS').AsString;
    lModel.PREVISAO_OS              := lQry.FieldByName('PREVISAO_OS').AsString;
    lModel.RESPONSAVEL_OS           := lQry.FieldByName('RESPONSAVEL_OS').AsString;
    lModel.VALORPECAS_OS            := lQry.FieldByName('VALORPECAS_OS').AsString;
    lModel.DESLOCAMENTO_OS          := lQry.FieldByName('DESLOCAMENTO_OS').AsString;
    lModel.TOTAL_OS                 := lQry.FieldByName('TOTAL_OS').AsString;
    lModel.DESCONTO_OS              := lQry.FieldByName('DESCONTO_OS').AsString;
    lModel.OBSERVACAO_OS            := lQry.FieldByName('OBSERVACAO_OS').AsString;
    lModel.RECLAMADO_OS             := lQry.FieldByName('RECLAMADO_OS').AsString;
    lModel.PROBLEMA_OS              := lQry.FieldByName('PROBLEMA_OS').AsString;
    lModel.SOLUCAO_OS               := lQry.FieldByName('SOLUCAO_OS').AsString;
    lModel.AUTORIZA_OS              := lQry.FieldByName('AUTORIZA_OS').AsString;
    lModel.HORA_OS                  := lQry.FieldByName('HORA_OS').AsString;
    lModel.CODIGO_TEC               := lQry.FieldByName('CODIGO_TEC').AsString;
    lModel.CODIGO_SIT               := lQry.FieldByName('CODIGO_SIT').AsString;
    lModel.PRODUTO_OS               := lQry.FieldByName('PRODUTO_OS').AsString;
    lModel.PRIMEIROVEN_OS           := lQry.FieldByName('PRIMEIROVEN_OS').AsString;
    lModel.QTDEPARCELA_OS           := lQry.FieldByName('QTDEPARCELA_OS').AsString;
    lModel.HORAORCA_OS              := lQry.FieldByName('HORAORCA_OS').AsString;
    lModel.HORAAPROVA_OS            := lQry.FieldByName('HORAAPROVA_OS').AsString;
    lModel.HORAMANU_OS              := lQry.FieldByName('HORAMANU_OS').AsString;
    lModel.HORAENTREGA_OS           := lQry.FieldByName('HORAENTREGA_OS').AsString;
    lModel.USUARIO_OS               := lQry.FieldByName('USUARIO_OS').AsString;
    lModel.CODIGO_TIP               := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.DESCRICAOO_OS            := lQry.FieldByName('DESCRICAOO_OS').AsString;
    lModel.MODELO_OS                := lQry.FieldByName('MODELO_OS').AsString;
    lModel.MARCA_OS                 := lQry.FieldByName('MARCA_OS').AsString;
    lModel.MAOOBRA_OS               := lQry.FieldByName('MAOOBRA_OS').AsString;
    lModel.USUARIOABERTURA_OS       := lQry.FieldByName('USUARIOABERTURA_OS').AsString;
    lModel.STATUS_OS                := lQry.FieldByName('STATUS_OS').AsString;
    lModel.FONE_OS                  := lQry.FieldByName('FONE_OS').AsString;
    lModel.ENTRADA_OS               := lQry.FieldByName('ENTRADA_OS').AsString;
    lModel.ACRESCIMO_OS             := lQry.FieldByName('ACRESCIMO_OS').AsString;
    lModel.VALORPARCELA_OS          := lQry.FieldByName('VALORPARCELA_OS').AsString;
    lModel.CODIGO_PRT               := lQry.FieldByName('CODIGO_PRT').AsString;
    lModel.TIPO_OS                  := lQry.FieldByName('TIPO_OS').AsString;
    lModel.TOTALPAGAR_OS            := lQry.FieldByName('TOTALPAGAR_OS').AsString;
    lModel.COMISSAO_OS              := lQry.FieldByName('COMISSAO_OS').AsString;
    lModel.SITUACAO_OS              := lQry.FieldByName('SITUACAO_OS').AsString;
    lModel.TABJUROS_OS              := lQry.FieldByName('TABJUROS_OS').AsString;
    lModel.CTR_IMPRESSAO_PED        := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
    lModel.LOJA                     := lQry.FieldByName('LOJA').AsString;
    lModel.DESC_OS                  := lQry.FieldByName('DESC_OS').AsString;
    lModel.HISTORICO_OS             := lQry.FieldByName('HISTORICO_OS').AsString;
    lModel.USUARIO_FECHAMENTO_OS    := lQry.FieldByName('USUARIO_FECHAMENTO_OS').AsString;
    lModel.LOG_OS                   := lQry.FieldByName('LOG_OS').AsString;
    lModel.KM_OS                    := lQry.FieldByName('KM_OS').AsString;
    lModel.PLACA                    := lQry.FieldByName('PLACA').AsString;
    lModel.ID                       := lQry.FieldByName('ID').AsString;
    lModel.DESCONTO_ADD             := lQry.FieldByName('DESCONTO_ADD').AsString;
    lModel.DATAHORA_INI             := lQry.FieldByName('DATAHORA_INI').AsString;
    lModel.DATAHORA_FIM             := lQry.FieldByName('DATAHORA_FIM').AsString;
    lModel.STATUS_ID                := lQry.FieldByName('STATUS_ID').AsString;
    lModel.CARGA_ID                 := lQry.FieldByName('CARGA_ID').AsString;
    lModel.ORDEM                    := lQry.FieldByName('ORDEM').AsString;
    lModel.NUMERO_NF                := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.ANO                      := lQry.FieldByName('ANO').AsString;
    lModel.FATURA_ID                := lQry.FieldByName('FATURA_ID').AsString;
    lModel.DATA_FECHAMENTO_OLD      := lQry.FieldByName('DATA_FECHAMENTO_OLD').AsString;
    lModel.HORA_FECHAMENTO_OLD      := lQry.FieldByName('HORA_FECHAMENTO_OLD').AsString;
    lModel.CNPJ_CPF_CONSUMIDOR      := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
    lModel.ENTRADA_PORTADOR_ID      := lQry.FieldByName('ENTRADA_PORTADOR_ID').AsString;
    lModel.NUMERO_NFSE              := lQry.FieldByName('NUMERO_NFSE').AsString;
    lModel.CONTRATO_OTTO_ID         := lQry.FieldByName('CONTRATO_OTTO_ID').AsString;
    lModel.SYSTIME                  := lQry.FieldByName('SYSTIME').AsString;
    lModel.CTR_MSG                  := lQry.FieldByName('CTR_MSG').AsString;
    lModel.QTD_MSG                  := lQry.FieldByName('QTD_MSG').AsString;
    lModel.CONDICOES_PAG            := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.MOTOR                    := lQry.FieldByName('MOTOR').AsString;
    lModel.TRANSMISSAO              := lQry.FieldByName('TRANSMISSAO').AsString;


    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TOSDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutorDao := TConstrutorDao.Create(vIConexao);
end;

destructor TOSDao.Destroy;
begin
  vConstrutorDao.Free;
  inherited;
end;

function TOSDao.incluir(pOSModel: TOSModel): String;
var
  lQry  : TFDQuery;
  lSQL  : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSQL := vConstrutorDao.gerarInsert('OS', 'NUMERO_OS');

    lQry.SQL.Add(lSQL);
    pOSModel.NUMERO_OS := vIConexao.Generetor('GEN_OS');
    setParams(lQry, pOSModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_OS').AsString;
  finally
    lQry.Free;
  end;
end;

function TOSDao.alterar(pOSModel: TOSModel): String;
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

    Result := pOSModel.NUMERO_OS;

  finally
    lQry.Free;
  end;
end;

function TOSDao.excluir(pOSModel: TOSModel): String;
var
  lQry     : TFDQuery;
begin
  lQry     := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from OS where NUMERO_OS = :NUMERO_OS',[pOSModel.NUMERO_OS]);
   lQry.ExecSQL;

   Result := pOSModel.NUMERO_OS;
  finally
    lQry.Free;
  end;
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

procedure TOSDao.setParams(var pQry: TFDQuery; pOSModel: TOSModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutorDao.getColumns('OS');
  lCtx    := TRttiContext.Create;

  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TOSModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pOSModel).AsString = '', Unassigned, vConstrutorDao.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pOSModel).AsString));
    end;
  finally
    lCtx.Free;
  end;
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
