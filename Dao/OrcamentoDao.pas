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
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  OrcamentoModel;

type
  TOrcamentoDao = class

  private
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
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pOrcamentoModel: TOrcamentoModel): String;
    function alterar(pOrcamentoModel: TOrcamentoModel): String;
    function excluir(pOrcamentoModel: TOrcamentoModel): String;

    function carregaClasse(pID : String): TOrcamentoModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pOrcamentoModel: TOrcamentoModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TOrcamento }

function TOrcamentoDao.alterar(pOrcamentoModel: TOrcamentoModel): String;
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

    Result := pOrcamentoModel.NUMERO_ORC;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TOrcamentoDao.carregaClasse(pID: String): TOrcamentoModel;
var
  lQry: TFDQuery;
  lModel: TOrcamentoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TOrcamentoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ORCAMENTO where NUMERO_ORC = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_ORC            := lQry.FieldByName('NUMERO_ORC').AsString;
    lModel.CODIGO_CLI            := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.CODIGO_VEN            := lQry.FieldByName('CODIGO_VEN').AsString;
    lModel.CODIGO_PORT           := lQry.FieldByName('CODIGO_PORT').AsString;
    lModel.DATA_ORC              := lQry.FieldByName('DATA_ORC').AsString;
    lModel.CONDICAO_ORC          := lQry.FieldByName('CONDICAO_ORC').AsString;
    lModel.VALOR_ORC             := lQry.FieldByName('VALOR_ORC').AsString;
    lModel.DESC_ORC              := lQry.FieldByName('DESC_ORC').AsString;
    lModel.ACRES_ORC             := lQry.FieldByName('ACRES_ORC').AsString;
    lModel.TOTAL_ORC             := lQry.FieldByName('TOTAL_ORC').AsString;
    lModel.INFORMACOES_ORC       := lQry.FieldByName('INFORMACOES_ORC').AsString;
    lModel.USUARIO_ORC           := lQry.FieldByName('USUARIO_ORC').AsString;
    lModel.CONTATO_ORC           := lQry.FieldByName('CONTATO_ORC').AsString;
    lModel.CODIGO_TIP            := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.NUMERO_CF             := lQry.FieldByName('NUMERO_CF').AsString;
    lModel.NUMERO_SERIE_ECF      := lQry.FieldByName('NUMERO_SERIE_ECF').AsString;
    lModel.SERIE_CF              := lQry.FieldByName('SERIE_CF').AsString;
    lModel.VLRENTRADA_ORC        := lQry.FieldByName('VLRENTRADA_ORC').AsString;
    lModel.PRIMEIROVCTO_ORC      := lQry.FieldByName('PRIMEIROVCTO_ORC').AsString;
    lModel.SEGURO_ORC            := lQry.FieldByName('SEGURO_ORC').AsString;
    lModel.FATURA_ORC            := lQry.FieldByName('FATURA_ORC').AsString;
    lModel.VLRPARCELA_ORC        := lQry.FieldByName('VLRPARCELA_ORC').AsString;
    lModel.SITUACAO_ORC          := lQry.FieldByName('SITUACAO_ORC').AsString;
    lModel.QTDEPARCELAS_ORC      := lQry.FieldByName('QTDEPARCELAS_ORC').AsString;
    lModel.HORA                  := lQry.FieldByName('HORA').AsString;
    lModel.DATAFECHAMENTO        := lQry.FieldByName('DATAFECHAMENTO').AsString;
    lModel.HORAFECHAMENTO        := lQry.FieldByName('HORAFECHAMENTO').AsString;
    lModel.PAGAMENTO_STATUS      := lQry.FieldByName('PAGAMENTO_STATUS').AsString;
    lModel.ENTREGA_LOCAL         := lQry.FieldByName('ENTREGA_LOCAL').AsString;
    lModel.OBS_PEDIDO_VINCULADO  := lQry.FieldByName('OBS_PEDIDO_VINCULADO').AsString;
    lModel.DATA_CONCRETIZADO     := lQry.FieldByName('DATA_CONCRETIZADO').AsString;
    lModel.HORA_CONCRETIZADO     := lQry.FieldByName('HORA_CONCRETIZADO').AsString;
    lModel.DATA_CANCELAMENTO     := lQry.FieldByName('DATA_CANCELAMENTO').AsString;
    lModel.USUARIO_CONCRETIZADO  := lQry.FieldByName('USUARIO_CONCRETIZADO').AsString;
    lModel.VALOR_IPI             := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.BASE_IPI              := lQry.FieldByName('BASE_IPI').AsString;
    lModel.VALOR_ST              := lQry.FieldByName('VALOR_ST').AsString;
    lModel.BASE_ST               := lQry.FieldByName('BASE_ST').AsString;
    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.PARCELAS_ORC          := lQry.FieldByName('PARCELAS_ORC').AsString;
    lModel.FRETE                 := lQry.FieldByName('FRETE').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.TRANPORTADORA_ID      := lQry.FieldByName('TRANPORTADORA_ID').AsString;
    lModel.RNTRC                 := lQry.FieldByName('RNTRC').AsString;
    lModel.PLACA                 := lQry.FieldByName('PLACA').AsString;
    lModel.PESO_LIQUIDO          := lQry.FieldByName('PESO_LIQUIDO').AsString;
    lModel.PESO_BRUTO            := lQry.FieldByName('PESO_BRUTO').AsString;
    lModel.QTDE_VOLUME           := lQry.FieldByName('QTDE_VOLUME').AsString;
    lModel.ESPECIE_VOLUME        := lQry.FieldByName('ESPECIE_VOLUME').AsString;
    lModel.TIPO_FRETE            := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.UF_TRANSPORTADORA     := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
    lModel.PRECO_VENDA_ID        := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.PEDIDO_COMPRA         := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.TABJUROS_ORC          := lQry.FieldByName('TABJUROS_ORC').AsString;
    lModel.STATUS_ID             := lQry.FieldByName('STATUS_ID').AsString;
    lModel.DESCONTO_ORC          := lQry.FieldByName('DESCONTO_ORC').AsString;
    lModel.OBS_GERAL             := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.VFCPUFDEST            := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.VICMSUFDEST           := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.VICMSUFREMET          := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.ZERAR_ST              := lQry.FieldByName('ZERAR_ST').AsString;
    lModel.PRODUTO_TIPO_ID       := lQry.FieldByName('PRODUTO_TIPO_ID').AsString;
    lModel.PREVISAO_EM_DIAS      := lQry.FieldByName('PREVISAO_EM_DIAS').AsString;
    lModel.HORAENTREGA           := lQry.FieldByName('HORAENTREGA').AsString;
    lModel.CONCLUIDO             := lQry.FieldByName('CONCLUIDO').AsString;
    lModel.ENVIADO               := lQry.FieldByName('ENVIADO').AsString;
    lModel.LOCALOBRA             := lQry.FieldByName('LOCALOBRA').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TOrcamentoDao.Create(pIConexao : IConexao);
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

function TOrcamentoDao.excluir(pOrcamentoModel: TOrcamentoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ORCAMENTO where NUMERO_ORC = :ID' ,[pOrcamentoModel.NUMERO_ORC]);
   lQry.ExecSQL;
   Result := pOrcamentoModel.ID;

  finally
    lQry.Free;
  end;
end;
function TOrcamentoDao.incluir(pOrcamentoModel: TOrcamentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ORCAMENTO', 'NUMERO_ORC', true);

  try
    lQry.SQL.Add(lSQL);
    pOrcamentoModel.NUMERO_ORC := vIConexao.Generetor('GEN_ORCAMENTO');
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

procedure TOrcamentoDao.setParams(var pQry: TFDQuery; pOrcamentoModel: TOrcamentoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('ORCAMENTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TOrcamentoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pOrcamentoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pOrcamentoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
