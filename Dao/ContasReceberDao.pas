unit ContasReceberDao;

interface

uses
  ContasReceberModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Spring.Collections,
  Interfaces.Conexao;

type
  TContasReceberDao = class
  private
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FContasRecebersLista: IList<TContasReceberModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDPedidoView: String;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetContasRecebersLista(const Value: IList<TContasReceberModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDPedidoView(const Value: String);
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;
    property ContasRecebersLista: IList<TContasReceberModel> read FContasRecebersLista write SetContasRecebersLista;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDPedidoView: String read FIDPedidoView write SetIDPedidoView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(AContasReceberModel: TContasReceberModel): String;
    function alterar(AContasReceberModel: TContasReceberModel): String;
    function excluir(AContasReceberModel: TContasReceberModel): String;

    procedure obterLista;
    procedure obterContasReceberPedido;
    procedure setParams(var pQry: TFDQuery; pContasReceberModel: TContasReceberModel);

    function where: String;
    function carregaClasse(pFatura: String; pLoja: String = ''): TContasReceberModel;
    function pedidoContasReceber(pFatura: String): String;

end;

implementation

uses
  System.Rtti;

{ TContasReceber }

function TContasReceberDao.carregaClasse(pFatura: String; pLoja: String = ''): TContasReceberModel;
var
  lQry: TFDQuery;
  lModel: TContasReceberModel;
begin

  if (pLoja <> '') and (vIConexao.getEmpresa.LOJA <> pLoja) then
  begin
    vIConexao.ConfigConexaoExterna(pLoja);
    lQry := vIConexao.criarQueryExterna;
  end
  else
    lQry := vIConexao.CriarQuery;

  lModel   := TContasReceberModel.Create(vIConexao);

  try
    lQry.Open('  select first 1 contasreceber.*, contasreceberitens.totalparcelas_rec                       '+
              '    from contasreceber                                                                       '+
              '   inner join contasreceberitens on contasreceberitens.fatura_rec = contasreceber.fatura_rec '+
              '   where contasreceber.fatura_rec = '+QuotedStr(pFatura));

    if lQry.IsEmpty then
      Exit;

    lModel.FATURA_REC            := lQry.FieldByName('FATURA_REC').AsString;
    lModel.CODIGO_CLI            := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.DATAEMI_REC           := lQry.FieldByName('DATAEMI_REC').AsString;
    lModel.VALOR_REC             := lQry.FieldByName('VALOR_REC').AsString;
    lModel.OBS_REC               := lQry.FieldByName('OBS_REC').AsString;
    lModel.SITUACAO_REC          := lQry.FieldByName('SITUACAO_REC').AsString;
    lModel.USUARIO_REC           := lQry.FieldByName('USUARIO_REC').AsString;
    lModel.VENDEDOR_REC          := lQry.FieldByName('VENDEDOR_REC').AsString;
    lModel.TIPO_REC              := lQry.FieldByName('TIPO_REC').AsString;
    lModel.OS_REC                := lQry.FieldByName('OS_REC').AsString;
    lModel.PEDIDO_REC            := lQry.FieldByName('PEDIDO_REC').AsString;
    lModel.CODIGO_POR            := lQry.FieldByName('CODIGO_POR').AsString;
    lModel.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.CENTERCOB             := lQry.FieldByName('CENTERCOB').AsString;
    lModel.AVALISTA              := lQry.FieldByName('AVALISTA').AsString;
    lModel.DATA_AGENDAMENTO      := lQry.FieldByName('DATA_AGENDAMENTO').AsString;
    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.INDICE_JUROS_ID       := lQry.FieldByName('INDICE_JUROS_ID').AsString;
    lModel.JUROS_FIXO            := lQry.FieldByName('JUROS_FIXO').AsString;
    lModel.PRIMEIRO_VENC         := lQry.FieldByName('PRIMEIRO_VENC').AsString;
    lModel.ULTIMO_DIA_MES        := lQry.FieldByName('ULTIMO_DIA_MES').AsString;
    lModel.CONDICOES_PAG         := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
    lModel.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.OBS_COMPLEMENTAR      := lQry.FieldByName('OBS_COMPLEMENTAR').AsString;
    lModel.FICHA_ID              := lQry.FieldByName('FICHA_ID').AsString;
    lModel.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.CONTRATO              := lQry.FieldByName('CONTRATO').AsString;
    lModel.CONFERIDO             := lQry.FieldByName('CONFERIDO').AsString;
    lModel.LOCAL_BAIXA           := lQry.FieldByName('LOCAL_BAIXA').AsString;
    lModel.SAIDA_REC             := lQry.FieldByName('SAIDA_REC').AsString;
    lModel.CODIGO_ANTERIOR       := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.DESENVOLVIMENTO_ID    := lQry.FieldByName('DESENVOLVIMENTO_ID').AsString;
    lModel.PEDIDO_SITE           := lQry.FieldByName('PEDIDO_SITE').AsString;
    lModel.TOTAL_PARCELAS        := lQry.FieldByName('TOTALPARCELAS_REC').AsString;
    lModel.ACRESCIMO             := lQry.FieldByName('ACRESCIMO').AsString;
    lModel.FATURA_PIX            := lQry.FieldByName('FATURA_PIX').AsString;
    lModel.RECEBIMENTO_CARTAO_ID := lQry.FieldByName('RECEBIMENTO_CARTAO_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;

  Result := lModel;
end;

constructor TContasReceberDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TContasReceberDao.Destroy;
begin
  FContasRecebersLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TContasReceberDao.incluir(AContasReceberModel: TContasReceberModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTASRECEBER','FATURA_REC', True);

  try

    lQry.SQL.Add(lSQL);
    AContasReceberModel.FATURA_REC := vIConexao.Generetor('GEN_CRECEBER');
    setParams(lQry, AContasReceberModel);
    lQry.Open;

    Result := lQry.FieldByName('FATURA_REC').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasReceberDao.alterar(AContasReceberModel: TContasReceberModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CONTASRECEBER','FATURA_REC');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasReceberModel);
    lQry.ExecSQL;
    Result := AContasReceberModel.FATURA_REC;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasReceberDao.excluir(AContasReceberModel: TContasReceberModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from contasreceber where FATURA_REC = :FATURA_REC',[AContasReceberModel.FATURA_REC]);
   lQry.ExecSQL;
   Result := AContasReceberModel.FATURA_REC;
  finally
    lQry.Free;
  end;
end;

function TContasReceberDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';
  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;
  if FIDRecordView <> '' then
    lSQL := lSQL + ' and contasreceber.fatura_rec = '+ QuotedStr(FIDRecordView);
  if FIDPedidoView <> ''  then
    lSQL := lSQL + ' and contasreceber.pedido_rec = '+QuotedStr(FIDPedidoView);
  Result := lSQL;
end;

procedure TContasReceberDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := ' select count(*) records '+
            '   From contasreceber    '+
            '  inner join portador on contasreceber.codigo_por = portador.codigo_port '+
            '  where 1=1 ';

    lSql := lSql + where;
    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;

function TContasReceberDao.pedidoContasReceber(pFatura: String): String;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select pedido_rec from contasreceber where fatura_rec = '+ QuotedStr(pFatura));
end;

procedure TContasReceberDao.obterContasReceberPedido;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: TContasReceberModel;
begin
  lQry := vIConexao.CriarQuery;

  if FIDPedidoView = '' then
  Abort;

  FContasRecebersLista := TCollections.CreateList<TContasReceberModel>(true);
  try
    lSQL := ' select contasreceber.fatura_rec,                                                                                                    '+
            '        contasreceber.codigo_por,                                                                                                    '+
            '        contasreceber.valor_rec,                                                                                                     '+
            '        portador.nome_port,                                                                                                          '+
            '        (select first 1 i.vlrparcela_rec from contasreceberitens i where i.fatura_rec = contasreceber.fatura_rec) valor_parcela,     '+
            '        (select first 1 i.totalparcelas_rec from contasreceberitens i where i.fatura_rec = contasreceber.fatura_rec) total_parcelas, '+
            '        (select sum(coalesce(contasreceberitens.valor_pago, 0))                                                                      '+
            '           from contasreceberitens                                                                                                   '+
            '          where contasreceberitens.fatura_rec = contasreceber.fatura_rec) valor_pago                                                 '+
            '   from contasreceber                                                                                                                '+
            '  inner join portador on contasreceber.codigo_por = portador.codigo_port                                                             '+
            '  where contasreceber.pedido_rec = '+ QuotedStr(FIDPedidoView);
    if FWhereView <> '' then
      lSQL := lSQL + FWhereView;
    lQry.Open(lSQL);
    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TContasReceberModel.Create(vIConexao);
      FContasRecebersLista.Add(modelo);
      modelo.FATURA_REC      := lQry.FieldByName('FATURA_REC').AsString;
      modelo.CODIGO_POR      := lQry.FieldByName('CODIGO_POR').AsString;
      modelo.VALOR_REC       := lQry.FieldByName('VALOR_REC').AsString;
      modelo.PORTADOR_NOME   := lQry.FieldByName('NOME_PORT').AsString;
      modelo.VALOR_PARCELA   := lQry.FieldByName('VALOR_PARCELA').AsString;
      modelo.TOTAL_PARCELAS  := lQry.FieldByName('TOTAL_PARCELAS').AsString;
      modelo.VALOR_PAGO      := lQry.FieldByName('VALOR_PAGO').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TContasReceberDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: TContasReceberModel;
begin
  lQry := vIConexao.CriarQuery;

  FContasRecebersLista := TCollections.CreateList<TContasReceberModel>(true);


  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';
    lSQL := lSQL +
      '       contasreceber.*,                                                    '+
      '       portador.nome_port                                                  '+
	    '  from contasreceber                                                       '+
      ' inner join portador on contasreceber.codigo_por = portador.codigo_port    '+
      ' where 1=1                ';
    lSql := lSql + where;
    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;
    lQry.Open(lSQL);
    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TContasReceberModel.Create(vIConexao);
      FContasRecebersLista.Add(modelo);
      modelo.FATURA_REC           := lQry.FieldByName('FATURA_REC').AsString;
      modelo.CODIGO_CLI           := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.CODIGO_CTA           := lQry.FieldByName('CODIGO_CTA').AsString;
      modelo.DATAEMI_REC          := lQry.FieldByName('DATAEMI_REC').AsString;
      modelo.VALOR_REC            := lQry.FieldByName('VALOR_REC').AsString;
      modelo.OBS_REC              := lQry.FieldByName('OBS_REC').AsString;
      modelo.SITUACAO_REC         := lQry.FieldByName('SITUACAO_REC').AsString;
      modelo.USUARIO_REC          := lQry.FieldByName('USUARIO_REC').AsString;
      modelo.VENDEDOR_REC         := lQry.FieldByName('VENDEDOR_REC').AsString;
      modelo.TIPO_REC             := lQry.FieldByName('TIPO_REC').AsString;
      modelo.OS_REC               := lQry.FieldByName('OS_REC').AsString;
      modelo.PEDIDO_REC           := lQry.FieldByName('PEDIDO_REC').AsString;
      modelo.CODIGO_POR           := lQry.FieldByName('CODIGO_POR').AsString;
      modelo.LOJA                 := lQry.FieldByName('LOJA').AsString;
      modelo.CENTERCOB            := lQry.FieldByName('CENTERCOB').AsString;
      modelo.AVALISTA             := lQry.FieldByName('AVALISTA').AsString;
      modelo.DATA_AGENDAMENTO     := lQry.FieldByName('DATA_AGENDAMENTO').AsString;
      modelo.ID                   := lQry.FieldByName('ID').AsString;
      modelo.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      modelo.INDICE_JUROS_ID      := lQry.FieldByName('INDICE_JUROS_ID').AsString;
      modelo.JUROS_FIXO           := lQry.FieldByName('JUROS_FIXO').AsString;
      modelo.PRIMEIRO_VENC        := lQry.FieldByName('PRIMEIRO_VENC').AsString;
      modelo.ULTIMO_DIA_MES       := lQry.FieldByName('ULTIMO_DIA_MES').AsString;
      modelo.CONDICOES_PAG        := lQry.FieldByName('CONDICOES_PAG').AsString;
      modelo.SUB_ID               := lQry.FieldByName('SUB_ID').AsString;
      modelo.LOCACAO_ID           := lQry.FieldByName('LOCACAO_ID').AsString;
      modelo.CENTRO_CUSTO         := lQry.FieldByName('CENTRO_CUSTO').AsString;
      modelo.OBS_COMPLEMENTAR     := lQry.FieldByName('OBS_COMPLEMENTAR').AsString;
      modelo.FICHA_ID             := lQry.FieldByName('FICHA_ID').AsString;
      modelo.FUNCIONARIO_ID       := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      modelo.CONTRATO             := lQry.FieldByName('CONTRATO').AsString;
      modelo.CONFERIDO            := lQry.FieldByName('CONFERIDO').AsString;
      modelo.LOCAL_BAIXA          := lQry.FieldByName('LOCAL_BAIXA').AsString;
      modelo.SAIDA_REC            := lQry.FieldByName('SAIDA_REC').AsString;
      modelo.CODIGO_ANTERIOR      := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
      modelo.DESENVOLVIMENTO_ID   := lQry.FieldByName('DESENVOLVIMENTO_ID').AsString;
      modelo.PEDIDO_SITE          := lQry.FieldByName('PEDIDO_SITE').AsString;
      modelo.PORTADOR_NOME        := lQry.FieldByName('NOME_PORT').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TContasReceberDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasReceberDao.SetContasRecebersLista;
begin
  FContasRecebersLista := Value;
end;

procedure TContasReceberDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasReceberDao.SetIDPedidoView(const Value: String);
begin
  FIDPedidoView := Value;
end;

procedure TContasReceberDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TContasReceberDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasReceberDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasReceberDao.setParams(var pQry: TFDQuery; pContasReceberModel: TContasReceberModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONTASRECEBER');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TContasReceberModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pContasReceberModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pContasReceberModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TContasReceberDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasReceberDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasReceberDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
end.
