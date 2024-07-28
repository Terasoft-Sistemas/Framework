unit OrcamentoDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  OrcamentoModel;

type
  TOrcamentoDao = class;
  ITOrcamentoDao=IObject<TOrcamentoDao>;

  TOrcamentoDao = class
  private
    [weak] mySelf: ITOrcamentoDao;
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

    function where: String;

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITOrcamentoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pOrcamentoModel: ITOrcamentoModel): String;
    function alterar(pOrcamentoModel: ITOrcamentoModel): String;
    function excluir(pOrcamentoModel: ITOrcamentoModel): String;

    function carregaClasse(pID : String): ITOrcamentoModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pOrcamentoModel: ITOrcamentoModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TOrcamento }

function TOrcamentoDao.alterar(pOrcamentoModel: ITOrcamentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('ORCAMENTO','NUMERO_ORC');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pOrcamentoModel);
    lQry.ExecSQL;

    Result := pOrcamentoModel.objeto.NUMERO_ORC;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TOrcamentoDao.carregaClasse(pID: String): ITOrcamentoModel;
var
  lQry: TFDQuery;
  lModel: ITOrcamentoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TOrcamentoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ORCAMENTO where NUMERO_ORC = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_ORC            := lQry.FieldByName('NUMERO_ORC').AsString;
    lModel.objeto.CODIGO_CLI            := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.objeto.CODIGO_VEN            := lQry.FieldByName('CODIGO_VEN').AsString;
    lModel.objeto.CODIGO_PORT           := lQry.FieldByName('CODIGO_PORT').AsString;
    lModel.objeto.DATA_ORC              := lQry.FieldByName('DATA_ORC').AsString;
    lModel.objeto.CONDICAO_ORC          := lQry.FieldByName('CONDICAO_ORC').AsString;
    lModel.objeto.VALOR_ORC             := lQry.FieldByName('VALOR_ORC').AsString;
    lModel.objeto.DESC_ORC              := lQry.FieldByName('DESC_ORC').AsString;
    lModel.objeto.ACRES_ORC             := lQry.FieldByName('ACRES_ORC').AsString;
    lModel.objeto.TOTAL_ORC             := lQry.FieldByName('TOTAL_ORC').AsString;
    lModel.objeto.INFORMACOES_ORC       := lQry.FieldByName('INFORMACOES_ORC').AsString;
    lModel.objeto.USUARIO_ORC           := lQry.FieldByName('USUARIO_ORC').AsString;
    lModel.objeto.CONTATO_ORC           := lQry.FieldByName('CONTATO_ORC').AsString;
    lModel.objeto.CODIGO_TIP            := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.objeto.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.NUMERO_CF             := lQry.FieldByName('NUMERO_CF').AsString;
    lModel.objeto.NUMERO_SERIE_ECF      := lQry.FieldByName('NUMERO_SERIE_ECF').AsString;
    lModel.objeto.SERIE_CF              := lQry.FieldByName('SERIE_CF').AsString;
    lModel.objeto.VLRENTRADA_ORC        := lQry.FieldByName('VLRENTRADA_ORC').AsString;
    lModel.objeto.PRIMEIROVCTO_ORC      := lQry.FieldByName('PRIMEIROVCTO_ORC').AsString;
    lModel.objeto.SEGURO_ORC            := lQry.FieldByName('SEGURO_ORC').AsString;
    lModel.objeto.FATURA_ORC            := lQry.FieldByName('FATURA_ORC').AsString;
    lModel.objeto.VLRPARCELA_ORC        := lQry.FieldByName('VLRPARCELA_ORC').AsString;
    lModel.objeto.SITUACAO_ORC          := lQry.FieldByName('SITUACAO_ORC').AsString;
    lModel.objeto.QTDEPARCELAS_ORC      := lQry.FieldByName('QTDEPARCELAS_ORC').AsString;
    lModel.objeto.HORA                  := lQry.FieldByName('HORA').AsString;
    lModel.objeto.DATAFECHAMENTO        := lQry.FieldByName('DATAFECHAMENTO').AsString;
    lModel.objeto.HORAFECHAMENTO        := lQry.FieldByName('HORAFECHAMENTO').AsString;
    lModel.objeto.PAGAMENTO_STATUS      := lQry.FieldByName('PAGAMENTO_STATUS').AsString;
    lModel.objeto.ENTREGA_LOCAL         := lQry.FieldByName('ENTREGA_LOCAL').AsString;
    lModel.objeto.OBS_PEDIDO_VINCULADO  := lQry.FieldByName('OBS_PEDIDO_VINCULADO').AsString;
    lModel.objeto.DATA_CONCRETIZADO     := lQry.FieldByName('DATA_CONCRETIZADO').AsString;
    lModel.objeto.HORA_CONCRETIZADO     := lQry.FieldByName('HORA_CONCRETIZADO').AsString;
    lModel.objeto.DATA_CANCELAMENTO     := lQry.FieldByName('DATA_CANCELAMENTO').AsString;
    lModel.objeto.USUARIO_CONCRETIZADO  := lQry.FieldByName('USUARIO_CONCRETIZADO').AsString;
    lModel.objeto.VALOR_IPI             := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.objeto.BASE_IPI              := lQry.FieldByName('BASE_IPI').AsString;
    lModel.objeto.VALOR_ST              := lQry.FieldByName('VALOR_ST').AsString;
    lModel.objeto.BASE_ST               := lQry.FieldByName('BASE_ST').AsString;
    lModel.objeto.ID                    := lQry.FieldByName('ID').AsString;
    lModel.objeto.PARCELAS_ORC          := lQry.FieldByName('PARCELAS_ORC').AsString;
    lModel.objeto.FRETE                 := lQry.FieldByName('FRETE').AsString;
    lModel.objeto.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.TRANPORTADORA_ID      := lQry.FieldByName('TRANPORTADORA_ID').AsString;
    lModel.objeto.RNTRC                 := lQry.FieldByName('RNTRC').AsString;
    lModel.objeto.PLACA                 := lQry.FieldByName('PLACA').AsString;
    lModel.objeto.PESO_LIQUIDO          := lQry.FieldByName('PESO_LIQUIDO').AsString;
    lModel.objeto.PESO_BRUTO            := lQry.FieldByName('PESO_BRUTO').AsString;
    lModel.objeto.QTDE_VOLUME           := lQry.FieldByName('QTDE_VOLUME').AsString;
    lModel.objeto.ESPECIE_VOLUME        := lQry.FieldByName('ESPECIE_VOLUME').AsString;
    lModel.objeto.TIPO_FRETE            := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.objeto.UF_TRANSPORTADORA     := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
    lModel.objeto.PRECO_VENDA_ID        := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.objeto.PEDIDO_COMPRA         := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.objeto.TABJUROS_ORC          := lQry.FieldByName('TABJUROS_ORC').AsString;
    lModel.objeto.STATUS_ID             := lQry.FieldByName('STATUS_ID').AsString;
    lModel.objeto.DESCONTO_ORC          := lQry.FieldByName('DESCONTO_ORC').AsString;
    lModel.objeto.OBS_GERAL             := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.objeto.VFCPUFDEST            := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.objeto.VICMSUFDEST           := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.objeto.VICMSUFREMET          := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.objeto.ZERAR_ST              := lQry.FieldByName('ZERAR_ST').AsString;
    lModel.objeto.PRODUTO_TIPO_ID       := lQry.FieldByName('PRODUTO_TIPO_ID').AsString;
    lModel.objeto.PREVISAO_EM_DIAS      := lQry.FieldByName('PREVISAO_EM_DIAS').AsString;
    lModel.objeto.HORAENTREGA           := lQry.FieldByName('HORAENTREGA').AsString;
    lModel.objeto.CONCLUIDO             := lQry.FieldByName('CONCLUIDO').AsString;
    lModel.objeto.ENVIADO               := lQry.FieldByName('ENVIADO').AsString;
    lModel.objeto.LOCALOBRA             := lQry.FieldByName('LOCALOBRA').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TOrcamentoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TOrcamentoDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TOrcamentoDao.excluir(pOrcamentoModel: ITOrcamentoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ORCAMENTO where NUMERO_ORC = :ID' ,[pOrcamentoModel.objeto.NUMERO_ORC]);
   lQry.ExecSQL;
   Result := pOrcamentoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TOrcamentoDao.getNewIface(pIConexao: IConexao): ITOrcamentoDao;
begin
  Result := TImplObjetoOwner<TOrcamentoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TOrcamentoDao.incluir(pOrcamentoModel: ITOrcamentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ORCAMENTO', 'NUMERO_ORC', true);

  try
    lQry.SQL.Add(lSQL);
    pOrcamentoModel.objeto.NUMERO_ORC := vIConexao.Generetor('GEN_ORCAMENTO');
    setParams(lQry, pOrcamentoModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_ORC').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TOrcamentoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                     '+SLineBreak+
              '         ORCAMENTO.NUMERO_ORC,                                             '+SLineBreak+
              '         ORCAMENTO.DATA_ORC,                                               '+SLineBreak+
              '         CLIENTES.FANTASIA_CLI,                                            '+SLineBreak+
              '         FUNCIONARIO.NOME_FUN,                                             '+SLineBreak+
              '         ORCAMENTO.TOTAL_ORC                                               '+SLineBreak+
              '    from ORCAMENTO                                                         '+SLineBreak+
              '    inner join CLIENTES on CLIENTES.CODIGO_CLI = ORCAMENTO.CODIGO_CLI      '+SLineBreak+
              '    left join FUNCIONARIO on FUNCIONARIO.CODIGO_FUN = ORCAMENTO.CODIGO_VEN '+SLineBreak+
              '   where 1=1                                                               '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TOrcamentoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From ORCAMENTO                                     '+SLineBreak+
            '    inner join CLIENTES on CLIENTES.CODIGO_CLI = ORCAMENTO.CODIGO_CLI      '+SLineBreak+
            '    left join FUNCIONARIO on FUNCIONARIO.CODIGO_FUN = ORCAMENTO.CODIGO_VEN '+SLineBreak+
            '   where 1=1                                                               '+SLineBreak;

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TOrcamentoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TOrcamentoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TOrcamentoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TOrcamentoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TOrcamentoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TOrcamentoDao.setParams(var pQry: TFDQuery; pOrcamentoModel: ITOrcamentoModel);
begin
  vConstrutor.setParams('ORCAMENTO',pQry,pOrcamentoModel.objeto);
end;

procedure TOrcamentoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TOrcamentoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TOrcamentoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TOrcamentoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and NUMERO_ORC = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

end.
