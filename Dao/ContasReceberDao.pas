unit ContasReceberDao;

interface

uses
  ContasReceberModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TContasReceberDao = class
  private
    vIConexao : IConexao;

    FContasRecebersLista: TObjectList<TContasReceberModel>;
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
    procedure SetContasRecebersLista(const Value: TObjectList<TContasReceberModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function montaCondicaoQuery: String;
    procedure SetIDPedidoView(const Value: String);
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;
    property ContasRecebersLista: TObjectList<TContasReceberModel> read FContasRecebersLista write SetContasRecebersLista;

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

    function carregaClasse(pFatura: String): TContasReceberModel;
    procedure setParams(var pQry: TFDQuery; pContasReceberModel: TContasReceberModel);
    function pedidoContasReceber(pFatura: String): String;

end;

implementation

{ TContasReceber }

function TContasReceberDao.carregaClasse(pFatura: String): TContasReceberModel;
var
  lQry: TFDQuery;
  lModel: TContasReceberModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContasReceberModel.Create(vIConexao);

  try
    lQry.Open('  select first 1 contasreceber.*, contasreceberitens.totalparcelas_rec                        '+
              '    from contasreceber                                                                       '+
              '   inner join contasreceberitens on contasreceberitens.fatura_rec = contasreceber.fatura_rec '+
              '   where contasreceber.fatura_rec = '+QuotedStr(pFatura));

    if lQry.IsEmpty then
      Exit;

    lModel.FATURA_REC         := lQry.FieldByName('FATURA_REC').AsString;
    lModel.CODIGO_CLI         := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.CODIGO_CTA         := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.DATAEMI_REC        := lQry.FieldByName('DATAEMI_REC').AsString;
    lModel.VALOR_REC          := lQry.FieldByName('VALOR_REC').AsString;
    lModel.OBS_REC            := lQry.FieldByName('OBS_REC').AsString;
    lModel.SITUACAO_REC       := lQry.FieldByName('SITUACAO_REC').AsString;
    lModel.USUARIO_REC        := lQry.FieldByName('USUARIO_REC').AsString;
    lModel.VENDEDOR_REC       := lQry.FieldByName('VENDEDOR_REC').AsString;
    lModel.TIPO_REC           := lQry.FieldByName('TIPO_REC').AsString;
    lModel.OS_REC             := lQry.FieldByName('OS_REC').AsString;
    lModel.PEDIDO_REC         := lQry.FieldByName('PEDIDO_REC').AsString;
    lModel.CODIGO_POR         := lQry.FieldByName('CODIGO_POR').AsString;
    lModel.LOJA               := lQry.FieldByName('LOJA').AsString;
    lModel.CENTERCOB          := lQry.FieldByName('CENTERCOB').AsString;
    lModel.AVALISTA           := lQry.FieldByName('AVALISTA').AsString;
    lModel.DATA_AGENDAMENTO   := lQry.FieldByName('DATA_AGENDAMENTO').AsString;
    lModel.ID                 := lQry.FieldByName('ID').AsString;
    lModel.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;
    lModel.INDICE_JUROS_ID    := lQry.FieldByName('INDICE_JUROS_ID').AsString;
    lModel.JUROS_FIXO         := lQry.FieldByName('JUROS_FIXO').AsString;
    lModel.PRIMEIRO_VENC      := lQry.FieldByName('PRIMEIRO_VENC').AsString;
    lModel.ULTIMO_DIA_MES     := lQry.FieldByName('ULTIMO_DIA_MES').AsString;
    lModel.CONDICOES_PAG      := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.SUB_ID             := lQry.FieldByName('SUB_ID').AsString;
    lModel.LOCACAO_ID         := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.CENTRO_CUSTO       := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.OBS_COMPLEMENTAR   := lQry.FieldByName('OBS_COMPLEMENTAR').AsString;
    lModel.FICHA_ID           := lQry.FieldByName('FICHA_ID').AsString;
    lModel.FUNCIONARIO_ID     := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.CONTRATO           := lQry.FieldByName('CONTRATO').AsString;
    lModel.CONFERIDO          := lQry.FieldByName('CONFERIDO').AsString;
    lModel.LOCAL_BAIXA        := lQry.FieldByName('LOCAL_BAIXA').AsString;
    lModel.SAIDA_REC          := lQry.FieldByName('SAIDA_REC').AsString;
    lModel.CODIGO_ANTERIOR    := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.DESENVOLVIMENTO_ID := lQry.FieldByName('DESENVOLVIMENTO_ID').AsString;
    lModel.PEDIDO_SITE        := lQry.FieldByName('PEDIDO_SITE').AsString;
    lModel.TOTAL_PARCELAS     := lQry.FieldByName('TOTALPARCELAS_REC').AsString;
    lModel.ACRESCIMO          := lQry.FieldByName('ACRESCIMO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;

  Result := lModel;
end;

constructor TContasReceberDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContasReceberDao.Destroy;
begin
  inherited;
end;
function TContasReceberDao.incluir(AContasReceberModel: TContasReceberModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=         '   insert into contasreceber (fatura_rec,          '+SLineBreak+
                  '                              codigo_cli,          '+SLineBreak+
                  '                              codigo_cta,          '+SLineBreak+
                  '                              dataemi_rec,         '+SLineBreak+
                  '                              valor_rec,           '+SLineBreak+
                  '                              obs_rec,             '+SLineBreak+
                  '                              situacao_rec,        '+SLineBreak+
                  '                              usuario_rec,         '+SLineBreak+
                  '                              vendedor_rec,        '+SLineBreak+
                  '                              tipo_rec,            '+SLineBreak+
                  '                              os_rec,              '+SLineBreak+
                  '                              pedido_rec,          '+SLineBreak+
                  '                              codigo_por,          '+SLineBreak+
                  '                              loja,                '+SLineBreak+
                  '                              centercob,           '+SLineBreak+
                  '                              avalista,            '+SLineBreak+
                  '                              data_agendamento,    '+SLineBreak+
                  '                              indice_juros_id,     '+SLineBreak+
                  '                              juros_fixo,          '+SLineBreak+
                  '                              primeiro_venc,       '+SLineBreak+
                  '                              ultimo_dia_mes,      '+SLineBreak+
                  '                              condicoes_pag,       '+SLineBreak+
                  '                              sub_id,              '+SLineBreak+
                  '                              locacao_id,          '+SLineBreak+
                  '                              centro_custo,        '+SLineBreak+
                  '                              obs_complementar,    '+SLineBreak+
                  '                              ficha_id,            '+SLineBreak+
                  '                              funcionario_id,      '+SLineBreak+
                  '                              contrato,            '+SLineBreak+
                  '                              conferido,           '+SLineBreak+
                  '                              local_baixa,         '+SLineBreak+
                  '                              saida_rec,           '+SLineBreak+
                  '                              codigo_anterior,     '+SLineBreak+
                  '                              desenvolvimento_id,  '+SLineBreak+
                  '                              pedido_site,         '+SLineBreak+
                  '                              acrescimo)           '+SLineBreak+
                  '   values (:fatura_rec,                            '+SLineBreak+
                  '           :codigo_cli,                            '+SLineBreak+
                  '           :codigo_cta,                            '+SLineBreak+
                  '           :dataemi_rec,                           '+SLineBreak+
                  '           :valor_rec,                             '+SLineBreak+
                  '           :obs_rec,                               '+SLineBreak+
                  '           :situacao_rec,                          '+SLineBreak+
                  '           :usuario_rec,                           '+SLineBreak+
                  '           :vendedor_rec,                          '+SLineBreak+
                  '           :tipo_rec,                              '+SLineBreak+
                  '           :os_rec,                                '+SLineBreak+
                  '           :pedido_rec,                            '+SLineBreak+
                  '           :codigo_por,                            '+SLineBreak+
                  '           :loja,                                  '+SLineBreak+
                  '           :centercob,                             '+SLineBreak+
                  '           :avalista,                              '+SLineBreak+
                  '           :data_agendamento,                      '+SLineBreak+
                  '           :indice_juros_id,                       '+SLineBreak+
                  '           :juros_fixo,                            '+SLineBreak+
                  '           :primeiro_venc,                         '+SLineBreak+
                  '           :ultimo_dia_mes,                        '+SLineBreak+
                  '           :condicoes_pag,                         '+SLineBreak+
                  '           :sub_id,                                '+SLineBreak+
                  '           :locacao_id,                            '+SLineBreak+
                  '           :centro_custo,                          '+SLineBreak+
                  '           :obs_complementar,                      '+SLineBreak+
                  '           :ficha_id,                              '+SLineBreak+
                  '           :funcionario_id,                        '+SLineBreak+
                  '           :contrato,                              '+SLineBreak+
                  '           :conferido,                             '+SLineBreak+
                  '           :local_baixa,                           '+SLineBreak+
                  '           :saida_rec,                             '+SLineBreak+
                  '           :codigo_anterior,                       '+SLineBreak+
                  '           :desenvolvimento_id,                    '+SLineBreak+
                  '           :pedido_site,                           '+SLineBreak+
                  '           :acrescimo)                             '+SLineBreak+
                  ' returning FATURA_REC                              '+SLineBreak;
  try

    lQry.SQL.Add(lSQL);
    lQry.ParamByName('fatura_rec').Value := vIConexao.Generetor('GEN_CRECEBER');
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

  lSQL :=  '   update contasreceber                              '+SLineBreak+
           '      set codigo_cli = :codigo_cli,                  '+SLineBreak+
           '          codigo_cta = :codigo_cta,                  '+SLineBreak+
           '          dataemi_rec = :dataemi_rec,                '+SLineBreak+
           '          valor_rec = :valor_rec,                    '+SLineBreak+
           '          obs_rec = :obs_rec,                        '+SLineBreak+
           '          situacao_rec = :situacao_rec,              '+SLineBreak+
           '          usuario_rec = :usuario_rec,                '+SLineBreak+
           '          vendedor_rec = :vendedor_rec,              '+SLineBreak+
           '          tipo_rec = :tipo_rec,                      '+SLineBreak+
           '          os_rec = :os_rec,                          '+SLineBreak+
           '          pedido_rec = :pedido_rec,                  '+SLineBreak+
           '          codigo_por = :codigo_por,                  '+SLineBreak+
           '          loja = :loja,                              '+SLineBreak+
           '          centercob = :centercob,                    '+SLineBreak+
           '          avalista = :avalista,                      '+SLineBreak+
           '          data_agendamento = :data_agendamento,      '+SLineBreak+
           '          indice_juros_id = :indice_juros_id,        '+SLineBreak+
           '          juros_fixo = :juros_fixo,                  '+SLineBreak+
           '          primeiro_venc = :primeiro_venc,            '+SLineBreak+
           '          ultimo_dia_mes = :ultimo_dia_mes,          '+SLineBreak+
           '          condicoes_pag = :condicoes_pag,            '+SLineBreak+
           '          sub_id = :sub_id,                          '+SLineBreak+
           '          locacao_id = :locacao_id,                  '+SLineBreak+
           '          centro_custo = :centro_custo,              '+SLineBreak+
           '          obs_complementar = :obs_complementar,      '+SLineBreak+
           '          ficha_id = :ficha_id,                      '+SLineBreak+
           '          funcionario_id = :funcionario_id,          '+SLineBreak+
           '          contrato = :contrato,                      '+SLineBreak+
           '          conferido = :conferido,                    '+SLineBreak+
           '          local_baixa = :local_baixa,                '+SLineBreak+
           '          saida_rec = :saida_rec,                    '+SLineBreak+
           '          codigo_anterior = :codigo_anterior,        '+SLineBreak+
           '          desenvolvimento_id = :desenvolvimento_id,  '+SLineBreak+
           '          pedido_site = :pedido_site,                '+SLineBreak+
           '          acrescimo = :acrescimo                     '+SLineBreak+
           '    where (fatura_rec = :fatura_rec) ';
  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('fatura_rec').Value  := IIF(AContasReceberModel.FATURA_REC   = '', Unassigned, AContasReceberModel.FATURA_REC);
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
function TContasReceberDao.montaCondicaoQuery: String;
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

    lSql := lSql + montaCondicaoQuery;
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  if FIDPedidoView = '' then
    CriaException('ID do pedido não informado');

  FContasRecebersLista := TObjectList<TContasReceberModel>.Create;
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
    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FContasRecebersLista.Add(TContasReceberModel.Create(vIConexao));
      i := FContasRecebersLista.Count -1;
      FContasRecebersLista[i].FATURA_REC      := lQry.FieldByName('FATURA_REC').AsString;
      FContasRecebersLista[i].CODIGO_POR      := lQry.FieldByName('CODIGO_POR').AsString;
      FContasRecebersLista[i].VALOR_REC       := lQry.FieldByName('VALOR_REC').AsString;
      FContasRecebersLista[i].PORTADOR_NOME   := lQry.FieldByName('NOME_PORT').AsString;
      FContasRecebersLista[i].VALOR_PARCELA   := lQry.FieldByName('VALOR_PARCELA').AsString;
      FContasRecebersLista[i].TOTAL_PARCELAS  := lQry.FieldByName('TOTAL_PARCELAS').AsString;
      FContasRecebersLista[i].VALOR_PAGO      := lQry.FieldByName('VALOR_PAGO').AsString;
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FContasRecebersLista := TObjectList<TContasReceberModel>.Create;
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
    lSql := lSql + montaCondicaoQuery;
    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;
    lQry.Open(lSQL);
    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FContasRecebersLista.Add(TContasReceberModel.Create(vIConexao));
      i := FContasRecebersLista.Count -1;
      FContasRecebersLista[i].FATURA_REC           := lQry.FieldByName('FATURA_REC').AsString;
      FContasRecebersLista[i].CODIGO_CLI           := lQry.FieldByName('CODIGO_CLI').AsString;
      FContasRecebersLista[i].CODIGO_CTA           := lQry.FieldByName('CODIGO_CTA').AsString;
      FContasRecebersLista[i].DATAEMI_REC          := lQry.FieldByName('DATAEMI_REC').AsString;
      FContasRecebersLista[i].VALOR_REC            := lQry.FieldByName('VALOR_REC').AsString;
      FContasRecebersLista[i].OBS_REC              := lQry.FieldByName('OBS_REC').AsString;
      FContasRecebersLista[i].SITUACAO_REC         := lQry.FieldByName('SITUACAO_REC').AsString;
      FContasRecebersLista[i].USUARIO_REC          := lQry.FieldByName('USUARIO_REC').AsString;
      FContasRecebersLista[i].VENDEDOR_REC         := lQry.FieldByName('VENDEDOR_REC').AsString;
      FContasRecebersLista[i].TIPO_REC             := lQry.FieldByName('TIPO_REC').AsString;
      FContasRecebersLista[i].OS_REC               := lQry.FieldByName('OS_REC').AsString;
      FContasRecebersLista[i].PEDIDO_REC           := lQry.FieldByName('PEDIDO_REC').AsString;
      FContasRecebersLista[i].CODIGO_POR           := lQry.FieldByName('CODIGO_POR').AsString;
      FContasRecebersLista[i].LOJA                 := lQry.FieldByName('LOJA').AsString;
      FContasRecebersLista[i].CENTERCOB            := lQry.FieldByName('CENTERCOB').AsString;
      FContasRecebersLista[i].AVALISTA             := lQry.FieldByName('AVALISTA').AsString;
      FContasRecebersLista[i].DATA_AGENDAMENTO     := lQry.FieldByName('DATA_AGENDAMENTO').AsString;
      FContasRecebersLista[i].ID                   := lQry.FieldByName('ID').AsString;
      FContasRecebersLista[i].SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      FContasRecebersLista[i].INDICE_JUROS_ID      := lQry.FieldByName('INDICE_JUROS_ID').AsString;
      FContasRecebersLista[i].JUROS_FIXO           := lQry.FieldByName('JUROS_FIXO').AsString;
      FContasRecebersLista[i].PRIMEIRO_VENC        := lQry.FieldByName('PRIMEIRO_VENC').AsString;
      FContasRecebersLista[i].ULTIMO_DIA_MES       := lQry.FieldByName('ULTIMO_DIA_MES').AsString;
      FContasRecebersLista[i].CONDICOES_PAG        := lQry.FieldByName('CONDICOES_PAG').AsString;
      FContasRecebersLista[i].SUB_ID               := lQry.FieldByName('SUB_ID').AsString;
      FContasRecebersLista[i].LOCACAO_ID           := lQry.FieldByName('LOCACAO_ID').AsString;
      FContasRecebersLista[i].CENTRO_CUSTO         := lQry.FieldByName('CENTRO_CUSTO').AsString;
      FContasRecebersLista[i].OBS_COMPLEMENTAR     := lQry.FieldByName('OBS_COMPLEMENTAR').AsString;
      FContasRecebersLista[i].FICHA_ID             := lQry.FieldByName('FICHA_ID').AsString;
      FContasRecebersLista[i].FUNCIONARIO_ID       := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      FContasRecebersLista[i].CONTRATO             := lQry.FieldByName('CONTRATO').AsString;
      FContasRecebersLista[i].CONFERIDO            := lQry.FieldByName('CONFERIDO').AsString;
      FContasRecebersLista[i].LOCAL_BAIXA          := lQry.FieldByName('LOCAL_BAIXA').AsString;
      FContasRecebersLista[i].SAIDA_REC            := lQry.FieldByName('SAIDA_REC').AsString;
      FContasRecebersLista[i].CODIGO_ANTERIOR      := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
      FContasRecebersLista[i].DESENVOLVIMENTO_ID   := lQry.FieldByName('DESENVOLVIMENTO_ID').AsString;
      FContasRecebersLista[i].PEDIDO_SITE          := lQry.FieldByName('PEDIDO_SITE').AsString;
      FContasRecebersLista[i].PORTADOR_NOME        := lQry.FieldByName('NOME_PORT').AsString;
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
procedure TContasReceberDao.SetContasRecebersLista(const Value: TObjectList<TContasReceberModel>);
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
begin
  pQry.ParamByName('codigo_cli').Value            := IIF(pContasReceberModel.CODIGO_CLI          = '', Unassigned, pContasReceberModel.CODIGO_CLI);
  pQry.ParamByName('codigo_cta').Value            := IIF(pContasReceberModel.CODIGO_CTA          = '', Unassigned, pContasReceberModel.CODIGO_CTA);
  pQry.ParamByName('dataemi_rec').Value           := IIF(pContasReceberModel.DATAEMI_REC         = '', Unassigned, transformaDataFireBird(pContasReceberModel.DATAEMI_REC));
  pQry.ParamByName('valor_rec').Value             := IIF(pContasReceberModel.VALOR_REC           = '', Unassigned, FormataFloatFireBird(pContasReceberModel.VALOR_REC));
  pQry.ParamByName('obs_rec').Value               := IIF(pContasReceberModel.OBS_REC             = '', Unassigned, pContasReceberModel.OBS_REC);
  pQry.ParamByName('situacao_rec').Value          := IIF(pContasReceberModel.SITUACAO_REC        = '', Unassigned, pContasReceberModel.SITUACAO_REC);
  pQry.ParamByName('usuario_rec').Value           := IIF(pContasReceberModel.USUARIO_REC         = '', Unassigned, pContasReceberModel.USUARIO_REC);
  pQry.ParamByName('vendedor_rec').Value          := IIF(pContasReceberModel.VENDEDOR_REC        = '', Unassigned, pContasReceberModel.VENDEDOR_REC);
  pQry.ParamByName('tipo_rec').Value              := IIF(pContasReceberModel.TIPO_REC            = '', Unassigned, pContasReceberModel.TIPO_REC);
  pQry.ParamByName('os_rec').Value                := IIF(pContasReceberModel.OS_REC              = '', Unassigned, pContasReceberModel.OS_REC);
  pQry.ParamByName('pedido_rec').Value            := IIF(pContasReceberModel.PEDIDO_REC          = '', Unassigned, pContasReceberModel.PEDIDO_REC);
  pQry.ParamByName('codigo_por').Value            := IIF(pContasReceberModel.CODIGO_POR          = '', Unassigned, pContasReceberModel.CODIGO_POR);
  pQry.ParamByName('loja').Value                  := IIF(pContasReceberModel.LOJA                = '', Unassigned, pContasReceberModel.LOJA);
  pQry.ParamByName('centercob').Value             := IIF(pContasReceberModel.CENTERCOB           = '', Unassigned, pContasReceberModel.CENTERCOB);
  pQry.ParamByName('avalista').Value              := IIF(pContasReceberModel.AVALISTA            = '', Unassigned, pContasReceberModel.AVALISTA);
  pQry.ParamByName('data_agendamento').Value      := IIF(pContasReceberModel.DATA_AGENDAMENTO    = '', Unassigned, transformaDataFireBird(pContasReceberModel.DATA_AGENDAMENTO));
  pQry.ParamByName('indice_juros_id').Value       := IIF(pContasReceberModel.INDICE_JUROS_ID     = '', Unassigned, pContasReceberModel.INDICE_JUROS_ID);
  pQry.ParamByName('juros_fixo').Value            := IIF(pContasReceberModel.JUROS_FIXO          = '', Unassigned, FormataFloatFireBird(pContasReceberModel.JUROS_FIXO));
  pQry.ParamByName('primeiro_venc').Value         := IIF(pContasReceberModel.PRIMEIRO_VENC       = '', Unassigned, transformaDataFireBird(pContasReceberModel.PRIMEIRO_VENC));
  pQry.ParamByName('ultimo_dia_mes').Value        := IIF(pContasReceberModel.ULTIMO_DIA_MES      = '', Unassigned, pContasReceberModel.ULTIMO_DIA_MES);
  pQry.ParamByName('condicoes_pag').Value         := IIF(pContasReceberModel.CONDICOES_PAG       = '', Unassigned, pContasReceberModel.CONDICOES_PAG);
  pQry.ParamByName('sub_id').Value                := IIF(pContasReceberModel.SUB_ID              = '', Unassigned, pContasReceberModel.SUB_ID);
  pQry.ParamByName('locacao_id').Value            := IIF(pContasReceberModel.LOCACAO_ID          = '', Unassigned, pContasReceberModel.LOCACAO_ID);
  pQry.ParamByName('centro_custo').Value          := IIF(pContasReceberModel.CENTRO_CUSTO        = '', Unassigned, pContasReceberModel.CENTRO_CUSTO);
  pQry.ParamByName('obs_complementar').Value      := IIF(pContasReceberModel.OBS_COMPLEMENTAR    = '', Unassigned, pContasReceberModel.OBS_COMPLEMENTAR);
  pQry.ParamByName('ficha_id').Value              := IIF(pContasReceberModel.FICHA_ID            = '', Unassigned, pContasReceberModel.FICHA_ID);
  pQry.ParamByName('funcionario_id').Value        := IIF(pContasReceberModel.FUNCIONARIO_ID      = '', Unassigned, pContasReceberModel.FUNCIONARIO_ID);
  pQry.ParamByName('contrato').Value              := IIF(pContasReceberModel.CONTRATO            = '', Unassigned, pContasReceberModel.CONTRATO);
  pQry.ParamByName('conferido').Value             := IIF(pContasReceberModel.CONFERIDO           = '', Unassigned, pContasReceberModel.CONFERIDO);
  pQry.ParamByName('local_baixa').Value           := IIF(pContasReceberModel.LOCAL_BAIXA         = '', Unassigned, pContasReceberModel.LOCAL_BAIXA);
  pQry.ParamByName('saida_rec').Value             := IIF(pContasReceberModel.SAIDA_REC           = '', Unassigned, pContasReceberModel.SAIDA_REC);
  pQry.ParamByName('codigo_anterior').Value       := IIF(pContasReceberModel.CODIGO_ANTERIOR     = '', Unassigned, pContasReceberModel.CODIGO_ANTERIOR);
  pQry.ParamByName('desenvolvimento_id').Value    := IIF(pContasReceberModel.DESENVOLVIMENTO_ID  = '', Unassigned, pContasReceberModel.DESENVOLVIMENTO_ID);
  pQry.ParamByName('pedido_site').Value           := IIF(pContasReceberModel.PEDIDO_SITE         = '', Unassigned, pContasReceberModel.PEDIDO_SITE);
  pQry.ParamByName('acrescimo').Value             := IIF(pContasReceberModel.ACRESCIMO           = '', Unassigned, FormataFloatFireBird(pContasReceberModel.ACRESCIMO));
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
