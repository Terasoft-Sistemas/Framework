unit PedidoVendaDao;
interface
uses
  PedidoVendaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao,
  Terasoft.Utils;

type
  TPedidoVendaDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPedidoVendasLista: TObjectList<TPedidoVendaModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPedidoVendasLista(const Value: TObjectList<TPedidoVendaModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;
    procedure SetIDRecordView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPedidoVendaModel: TPedidoVendaModel);

  public
    constructor Create(pConexao : IConexao);
    destructor Destroy; override;
    property PedidoVendasLista: TObjectList<TPedidoVendaModel> read FPedidoVendasLista write SetPedidoVendasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pPedidoVendaModel: TPedidoVendaModel): String;
    function alterar(pPedidoVendaModel: TPedidoVendaModel): String;
    function excluir(pPedidoVendaModel: TPedidoVendaModel): String;

    procedure obterLista;

    function ObterProdutoBalanca(pBarrasProduto: String): String;

    function obterPedido(pNumeroPedido: String): TPedidoVendaModel;
    function carregaClasse(pId: String): TPedidoVendaModel;
    function statusPedido(pId: String): String;
    procedure obterUpdateImpostos(pNumeroPedido: String);

end;
implementation

uses
  Vcl.Dialogs, System.Rtti, Terasoft.Configuracoes, Terasoft.Types;
{ TPedidoVenda }
procedure TPedidoVendaDao.obterUpdateImpostos(pNumeroPedido: String);
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoVendasLista := TObjectList<TPedidoVendaModel>.Create;
  try
    lSQL :=
    ' select                                                   '+#13+
    '     i.id pedidoitens_id,                                 '+#13+
    '     p.valor_ped,                                         '+#13+
    '     p.desc_ped,                                          '+#13+
    '     p.acres_ped,                                         '+#13+
    '     c.uf_cli,                                            '+#13+
    '     i.codigo_pro,                                        '+#13+
    '     i.quantidade_ped,                                    '+#13+
    '     i.valorunitario_ped                                  '+#13+
    '                                                          '+#13+
    ' from                                                     '+#13+
    '     pedidovenda p                                        '+#13+
    '                                                          '+#13+
    ' left join pedidoitens i on i.numero_ped = p.numero_ped   '+#13+
    ' left join clientes c on c.codigo_cli = p.codigo_cli      '+#13+
    '                                                          '+#13+
    '                                                          '+#13+
    ' where                                                    '+#13+
    '     p.numero_ped = '+QuotedStr(pNumeroPedido);
    lQry.Open(lSQL);
    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPedidoVendasLista.Add(TPedidoVendaModel.Create(vIConexao));
      i := FPedidoVendasLista.Count -1;
      FPedidoVendasLista[i].PEDIDOITENS_ID    := lQry.FieldByName('PEDIDOITENS_ID').AsString;
      FPedidoVendasLista[i].VALOR_PED         := lQry.FieldByName('VALOR_PED').AsString;
      FPedidoVendasLista[i].DESC_PED          := lQry.FieldByName('DESC_PED').AsString;
      FPedidoVendasLista[i].ACRES_PED         := lQry.FieldByName('ACRES_PED').AsString;
      FPedidoVendasLista[i].UF_CLI            := lQry.FieldByName('UF_CLI').AsString;
      FPedidoVendasLista[i].CODIGO_PRO        := lQry.FieldByName('CODIGO_PRO').AsString;
      FPedidoVendasLista[i].QUANTIDADE_PED    := lQry.FieldByName('QUANTIDADE_PED').AsString;
      FPedidoVendasLista[i].VALORUNITARIO_PED := lQry.FieldByName('VALORUNITARIO_PED').AsString;
      lQry.Next;
    end;
  finally
    lQry.Free;
  end;
end;
function TPedidoVendaDao.carregaClasse(pId: String): TPedidoVendaModel;
var
  lQry: TFDQuery;
  lModel: TPedidoVendaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPedidoVendaModel.Create(vIConexao);
  Result   := lModel;
  try
    lQry.Open('select * from pedidovenda where numero_ped = '+pId);
    if lQry.IsEmpty then
      Exit;
    lModel.NUMERO_PED              := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.CODIGO_CLI              := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.CODIGO_VEN              := lQry.FieldByName('CODIGO_VEN').AsString;
    lModel.CODIGO_PORT             := lQry.FieldByName('CODIGO_PORT').AsString;
    lModel.CODIGO_TIP              := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.DATA_PED                := lQry.FieldByName('DATA_PED').AsString;
    lModel.VALOR_PED               := lQry.FieldByName('VALOR_PED').AsString;
    lModel.DESC_PED                := lQry.FieldByName('DESC_PED').AsString;
    lModel.ACRES_PED               := lQry.FieldByName('ACRES_PED').AsString;
    lModel.TOTAL_PED               := lQry.FieldByName('TOTAL_PED').AsString;
    lModel.USUARIO_PED             := lQry.FieldByName('USUARIO_PED').AsString;
    lModel.NUMERO_ORC              := lQry.FieldByName('NUMERO_ORC').AsString;
    lModel.INFORMACOES_PED         := lQry.FieldByName('INFORMACOES_PED').AsString;
    lModel.TIPO_PED                := lQry.FieldByName('TIPO_PED').AsString;
    lModel.INDCE_PED               := lQry.FieldByName('INDCE_PED').AsString;
    lModel.CFOP_ID                 := lQry.FieldByName('CFOP_ID').AsString;
    lModel.PRIMEIROVENC_PED        := lQry.FieldByName('PRIMEIROVENC_PED').AsString;
    lModel.VALORENTADA_PED         := lQry.FieldByName('VALORENTADA_PED').AsString;
    lModel.PARCELAS_PED            := lQry.FieldByName('PARCELAS_PED').AsString;
    lModel.PARCELA_PED             := lQry.FieldByName('PARCELA_PED').AsString;
    lModel.STATUS_PED              := lQry.FieldByName('STATUS_PED').AsString;
    lModel.TABJUROS_PED            := lQry.FieldByName('TABJUROS_PED').AsString;
    lModel.CONTATO_PED             := lQry.FieldByName('CONTATO_PED').AsString;
    lModel.DESCONTO_PED            := lQry.FieldByName('DESCONTO_PED').AsString;
    lModel.CTR_IMPRESSAO_PED       := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
    lModel.FRETE_PED               := lQry.FieldByName('FRETE_PED').AsString;
    lModel.CONDICOES_PAG           := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.TOTAL1_PED              := lQry.FieldByName('TOTAL1_PED').AsString;
    lModel.TOTAL2_PED              := lQry.FieldByName('TOTAL2_PED').AsString;
    lModel.LOCAL_PED               := lQry.FieldByName('LOCAL_PED').AsString;
    lModel.TELEVENDA_PED           := lQry.FieldByName('TELEVENDA_PED').AsString;
    lModel.PESO_PED                := lQry.FieldByName('PESO_PED').AsString;
    lModel.PRIMEIROVENC2_PED       := lQry.FieldByName('PRIMEIROVENC2_PED').AsString;
    lModel.PARCELAS2_PED           := lQry.FieldByName('PARCELAS2_PED').AsString;
    lModel.VALOR_IPI               := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.CONDICOES2_PAG          := lQry.FieldByName('CONDICOES2_PAG').AsString;
    lModel.LOJA                    := lQry.FieldByName('LOJA').AsString;
    lModel.DOLAR                   := lQry.FieldByName('DOLAR').AsString;
    lModel.CTR_EXPORTACAO          := lQry.FieldByName('CTR_EXPORTACAO').AsString;
    lModel.ID                      := lQry.FieldByName('ID').AsString;
    lModel.NUMERO_CF               := lQry.FieldByName('NUMERO_CF').AsString;
    lModel.CF_ABERTO               := lQry.FieldByName('CF_ABERTO').AsString;
    lModel.NAO_FISCAL_ABERTO       := lQry.FieldByName('NAO_FISCAL_ABERTO').AsString;
    lModel.HORA_PED                := lQry.FieldByName('HORA_PED').AsString;
    lModel.TIPO_FRETE              := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.VALOR_PAGO              := lQry.FieldByName('VALOR_PAGO').AsString;
    lModel.STATUS                  := lQry.FieldByName('STATUS').AsString;
    lModel.DATA_FATURADO           := lQry.FieldByName('DATA_FATURADO').AsString;
    lModel.NUMERO_NF               := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.VALOR_SUFRAMA           := lQry.FieldByName('VALOR_SUFRAMA').AsString;
    lModel.CARGA_ID                := lQry.FieldByName('CARGA_ID').AsString;
    lModel.LISTA_NOIVA_ID          := lQry.FieldByName('LISTA_NOIVA_ID').AsString;
    lModel.VALOR_RESTITUICAO       := lQry.FieldByName('VALOR_RESTITUICAO').AsString;
    lModel.SYSTIME                 := lQry.FieldByName('SYSTIME').AsString;
    lModel.DESCONTO_DRG            := lQry.FieldByName('DESCONTO_DRG').AsString;
    lModel.STATUS_ID               := lQry.FieldByName('STATUS_ID').AsString;
    lModel.PRECO_VENDA_ID          := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.RNTRC                   := lQry.FieldByName('RNTRC').AsString;
    lModel.PLACA                   := lQry.FieldByName('PLACA').AsString;
    lModel.PESO_LIQUIDO            := lQry.FieldByName('PESO_LIQUIDO').AsString;
    lModel.PESO_BRUTO              := lQry.FieldByName('PESO_BRUTO').AsString;
    lModel.QTDE_VOLUME             := lQry.FieldByName('QTDE_VOLUME').AsString;
    lModel.ESPECIE_VOLUME          := lQry.FieldByName('ESPECIE_VOLUME').AsString;
    lModel.UF_TRANSPORTADORA       := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
    lModel.PRODUCAO_ID             := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.REGIAO_ID               := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.ORDEM                   := lQry.FieldByName('ORDEM').AsString;
    lModel.CNPJ_CPF_CONSUMIDOR     := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
    lModel.PEDIDO_COMPRA           := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.DATA_FINALIZADO         := lQry.FieldByName('DATA_FINALIZADO').AsString;
    lModel.NUMERO_SENHA            := lQry.FieldByName('NUMERO_SENHA').AsString;
    lModel.ARQUITETO_ID            := lQry.FieldByName('ARQUITETO_ID').AsString;
    lModel.ARQUITETO_COMISSAO      := lQry.FieldByName('ARQUITETO_COMISSAO').AsString;
    lModel.LOTE_CARGA_ID           := lQry.FieldByName('LOTE_CARGA_ID').AsString;
    lModel.ENTREGA                 := lQry.FieldByName('ENTREGA').AsString;
    lModel.VALOR_DESPESA_VENDA     := lQry.FieldByName('VALOR_DESPESA_VENDA').AsString;
    lModel.ENTREGA_ENDERECO        := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
    lModel.ENTREGA_COMPLEMENTO     := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
    lModel.ENTREGA_NUMERO          := lQry.FieldByName('ENTREGA_NUMERO').AsString;
    lModel.ENTREGA_BAIRRO          := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
    lModel.ENTREGA_CIDADE          := lQry.FieldByName('ENTREGA_CIDADE').AsString;
    lModel.ENTREGA_CEP             := lQry.FieldByName('ENTREGA_CEP').AsString;
    lModel.ENTREGA_UF              := lQry.FieldByName('ENTREGA_UF').AsString;
    lModel.ENTREGA_COD_MUNICIPIO   := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
    lModel.ENTREGA_TELEFONE        := lQry.FieldByName('ENTREGA_TELEFONE').AsString;
    lModel.ENTREGA_CELULAR         := lQry.FieldByName('ENTREGA_CELULAR').AsString;
    lModel.ENTREGA_OBSERVACAO      := lQry.FieldByName('ENTREGA_OBSERVACAO').AsString;
    lModel.ENTREGA_HORA            := lQry.FieldByName('ENTREGA_HORA').AsString;
    lModel.ENTREGA_CONTATO         := lQry.FieldByName('ENTREGA_CONTATO').AsString;
    lModel.ENTREGA_AGENDA_ID       := lQry.FieldByName('ENTREGA_AGENDA_ID').AsString;
    lModel.ENTREGA_REGIAO_ID       := lQry.FieldByName('ENTREGA_REGIAO_ID').AsString;
    lModel.ENTREGADOR_ID           := lQry.FieldByName('ENTREGADOR_ID').AsString;
    lModel.FATURA_ID               := lQry.FieldByName('FATURA_ID').AsString;
    lModel.DATAHORA_IMPRESSO       := lQry.FieldByName('DATAHORA_IMPRESSO').AsString;
    lModel.CTR_IMPRESSAO_ITENS     := lQry.FieldByName('CTR_IMPRESSAO_ITENS').AsString;
    lModel.RESERVADO               := lQry.FieldByName('RESERVADO').AsString;
    lModel.PATRIMONIO_OBSERVACAO   := lQry.FieldByName('PATRIMONIO_OBSERVACAO').AsString;
    lModel.OBS_GERAL               := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.SMS                     := lQry.FieldByName('SMS').AsString;
    lModel.IMP_TICKET              := lQry.FieldByName('IMP_TICKET').AsString;
    lModel.COMANDA                 := lQry.FieldByName('COMANDA').AsString;
    lModel.VALOR_TAXA_SERVICO      := lQry.FieldByName('VALOR_TAXA_SERVICO').AsString;
    lModel.VFCPUFDEST              := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.VICMSUFDEST             := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.VICMSUFREMET            := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.ENTREGUE                := lQry.FieldByName('ENTREGUE').AsString;
    lModel.INDICACAO_ID            := lQry.FieldByName('INDICACAO_ID').AsString;
    lModel.ZERAR_ST                := lQry.FieldByName('ZERAR_ST').AsString;
    lModel.PEDIDO_VIDRACARIA       := lQry.FieldByName('PEDIDO_VIDRACARIA').AsString;
    lModel.CHAVE_XML_NF            := lQry.FieldByName('CHAVE_XML_NF').AsString;
    lModel.ARQUIVO_XML_NF          := lQry.FieldByName('ARQUIVO_XML_NF').AsString;
    lModel.GERENTE_ID              := lQry.FieldByName('GERENTE_ID').AsString;
    lModel.ENTRADA_PORTADOR_ID     := lQry.FieldByName('ENTRADA_PORTADOR_ID').AsString;
    lModel.DATA_COTACAO            := lQry.FieldByName('DATA_COTACAO').AsString;
    lModel.TIPO_COMISSAO           := lQry.FieldByName('TIPO_COMISSAO').AsString;
    lModel.GERENTE_TIPO_COMISSAO   := lQry.FieldByName('GERENTE_TIPO_COMISSAO').AsString;
    lModel.POS_VENDA               := lQry.FieldByName('POS_VENDA').AsString;
    lModel.VLR_GARANTIA            := lQry.FieldByName('VLR_GARANTIA').AsString;
    lModel.WEB_PEDIDO_ID           := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    lModel.LACA_OU_GLASS           := lQry.FieldByName('LACA_OU_GLASS').AsString;
    lModel.VFCPST                  := lQry.FieldByName('VFCPST').AsString;
    lModel.MONTAGEM_DATA           := lQry.FieldByName('MONTAGEM_DATA').AsString;
    lModel.MONTAGEM_HORA           := lQry.FieldByName('MONTAGEM_HORA').AsString;
    lModel.FORM                    := lQry.FieldByName('FORM').AsString;
    lModel.VICMSDESON              := lQry.FieldByName('VICMSDESON').AsString;
    lModel.QTDEITENS               := lQry.FieldByName('QTDEITENS').AsString;
    lModel.CTR_ENVIO_PEDIDO        := lQry.FieldByName('CTR_ENVIO_PEDIDO').AsString;
    lModel.CTR_ENVIO_BOLETO        := lQry.FieldByName('CTR_ENVIO_BOLETO').AsString;
    lModel.CTR_ENVIO_NFE           := lQry.FieldByName('CTR_ENVIO_NFE').AsString;
    lModel.DATAHORA_COLETA         := lQry.FieldByName('DATAHORA_COLETA').AsString;
    lModel.DATAHORA_RETIRADA       := lQry.FieldByName('DATAHORA_RETIRADA').AsString;
    lModel.CFOP_NF                 := lQry.FieldByName('CFOP_NF').AsString;
    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPedidoVendaDao.Create(pConexao : IConexao);
begin
  vIConexao   := pConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPedidoVendaDao.Destroy;
begin
  inherited;
end;

function TPedidoVendaDao.incluir(pPedidoVendaModel: TPedidoVendaModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PEDIDOVENDA', 'NUMERO_PED');

  try
    lQry.SQL.Add(lSQL);
    pPedidoVendaModel.NUMERO_PED := vIConexao.Generetor('GEN_PEDIDOVENDA', true);
    setParams(lQry, pPedidoVendaModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_PED').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoVendaDao.alterar(pPedidoVendaModel: TPedidoVendaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarUpdate('PEDIDOVENDA', 'NUMERO_PED');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoVendaModel);
    lQry.ExecSQL;
    Result := pPedidoVendaModel.ID;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoVendaDao.excluir(pPedidoVendaModel: TPedidoVendaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from pedidovenda where NUMERO_PED = :NUMERO_PED',[pPedidoVendaModel.NUMERO_PED]);
   lQry.ExecSQL;
   Result := pPedidoVendaModel.NUMERO_PED;
  finally
    lQry.Free;
  end;
end;
function TPedidoVendaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';
  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;
  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and pedidovenda.numero_ped = '+FIDRecordView;
  Result := lSQL;
end;
procedure TPedidoVendaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := 'select count(*) records From pedidovenda  '+
            '  left join clientes on clientes.codigo_cli = pedidovenda.codigo_cli '+#13+
            ' where 1=1 ';
    lSql := lSql + where;
    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;
procedure TPedidoVendaDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoVendasLista := TObjectList<TPedidoVendaModel>.Create;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';
    lSQL := lSQL +
      '       pedidovenda.*,           '+SLineBreak+
      '       clientes.fantasia_cli,   '+SLineBreak+
      '       funcionario.nome_fun     '+SLineBreak+
	    '  from pedidovenda              '+SLineBreak+
      '  left join clientes on clientes.codigo_cli = pedidovenda.codigo_cli '+SLineBreak+
      '  left join funcionario on funcionario.codigo_fun = pedidovenda.codigo_ven '+SLineBreak+
      ' where 1=1              ';
    lSql := lSql + where;
    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;
    lQry.Open(lSQL);
    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPedidoVendasLista.Add(TPedidoVendaModel.Create(vIConexao));
      i := FPedidoVendasLista.Count -1;
      FPedidoVendasLista[i].ID                        := lQry.FieldByName('ID').AsString;
      FPedidoVendasLista[i].NUMERO_PED                := lQry.FieldByName('NUMERO_PED').AsString;
      FPedidoVendasLista[i].CODIGO_CLI                := lQry.FieldByName('CODIGO_CLI').AsString;
      FPedidoVendasLista[i].CODIGO_VEN                := lQry.FieldByName('CODIGO_VEN').AsString;
      FPedidoVendasLista[i].CODIGO_PORT               := lQry.FieldByName('CODIGO_PORT').AsString;
      FPedidoVendasLista[i].CODIGO_TIP                := lQry.FieldByName('CODIGO_TIP').AsString;
      FPedidoVendasLista[i].DATA_PED                  := lQry.FieldByName('DATA_PED').AsString;
      FPedidoVendasLista[i].VALOR_PED                 := lQry.FieldByName('VALOR_PED').AsString;
      FPedidoVendasLista[i].DESC_PED                  := lQry.FieldByName('DESC_PED').AsString;
      FPedidoVendasLista[i].ACRES_PED                 := lQry.FieldByName('ACRES_PED').AsString;
      FPedidoVendasLista[i].TOTAL_PED                 := lQry.FieldByName('TOTAL_PED').AsString;
      FPedidoVendasLista[i].USUARIO_PED               := lQry.FieldByName('USUARIO_PED').AsString;
      FPedidoVendasLista[i].NUMERO_ORC                := lQry.FieldByName('NUMERO_ORC').AsString;
      FPedidoVendasLista[i].INFORMACOES_PED           := lQry.FieldByName('INFORMACOES_PED').AsString;
      FPedidoVendasLista[i].TIPO_PED                  := lQry.FieldByName('TIPO_PED').AsString;
      FPedidoVendasLista[i].INDCE_PED                 := lQry.FieldByName('INDCE_PED').AsString;
      FPedidoVendasLista[i].CFOP_ID                   := lQry.FieldByName('CFOP_ID').AsString;
      FPedidoVendasLista[i].PRIMEIROVENC_PED          := lQry.FieldByName('PRIMEIROVENC_PED').AsString;
      FPedidoVendasLista[i].VALORENTADA_PED           := lQry.FieldByName('VALORENTADA_PED').AsString;
      FPedidoVendasLista[i].PARCELAS_PED              := lQry.FieldByName('PARCELAS_PED').AsString;
      FPedidoVendasLista[i].PARCELA_PED               := lQry.FieldByName('PARCELA_PED').AsString;
      FPedidoVendasLista[i].STATUS_PED                := lQry.FieldByName('STATUS_PED').AsString;
      FPedidoVendasLista[i].TABJUROS_PED              := lQry.FieldByName('TABJUROS_PED').AsString;
      FPedidoVendasLista[i].CONTATO_PED               := lQry.FieldByName('CONTATO_PED').AsString;
      FPedidoVendasLista[i].DESCONTO_PED              := lQry.FieldByName('DESCONTO_PED').AsString;
      FPedidoVendasLista[i].CTR_IMPRESSAO_PED         := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
      FPedidoVendasLista[i].FRETE_PED                 := lQry.FieldByName('FRETE_PED').AsString;
      FPedidoVendasLista[i].CONDICOES_PAG             := lQry.FieldByName('CONDICOES_PAG').AsString;
      FPedidoVendasLista[i].TOTAL1_PED                := lQry.FieldByName('TOTAL1_PED').AsString;
      FPedidoVendasLista[i].TOTAL2_PED                := lQry.FieldByName('TOTAL2_PED').AsString;
      FPedidoVendasLista[i].LOCAL_PED                 := lQry.FieldByName('LOCAL_PED').AsString;
      FPedidoVendasLista[i].TELEVENDA_PED             := lQry.FieldByName('TELEVENDA_PED').AsString;
      FPedidoVendasLista[i].PESO_PED                  := lQry.FieldByName('PESO_PED').AsString;
      FPedidoVendasLista[i].PRIMEIROVENC2_PED         := lQry.FieldByName('PRIMEIROVENC2_PED').AsString;
      FPedidoVendasLista[i].PARCELAS2_PED             := lQry.FieldByName('PARCELAS2_PED').AsString;
      FPedidoVendasLista[i].VALOR_IPI                 := lQry.FieldByName('VALOR_IPI').AsString;
      FPedidoVendasLista[i].CONDICOES2_PAG            := lQry.FieldByName('CONDICOES2_PAG').AsString;
      FPedidoVendasLista[i].LOJA                      := lQry.FieldByName('LOJA').AsString;
      FPedidoVendasLista[i].DOLAR                     := lQry.FieldByName('DOLAR').AsString;
      FPedidoVendasLista[i].CTR_EXPORTACAO            := lQry.FieldByName('CTR_EXPORTACAO').AsString;
      FPedidoVendasLista[i].ID                        := lQry.FieldByName('ID').AsString;
      FPedidoVendasLista[i].NUMERO_CF                 := lQry.FieldByName('NUMERO_CF').AsString;
      FPedidoVendasLista[i].CF_ABERTO                 := lQry.FieldByName('CF_ABERTO').AsString;
      FPedidoVendasLista[i].NAO_FISCAL_ABERTO         := lQry.FieldByName('NAO_FISCAL_ABERTO').AsString;
      FPedidoVendasLista[i].HORA_PED                  := lQry.FieldByName('HORA_PED').AsString;
      FPedidoVendasLista[i].TIPO_FRETE                := lQry.FieldByName('TIPO_FRETE').AsString;
      FPedidoVendasLista[i].VALOR_PAGO                := lQry.FieldByName('VALOR_PAGO').AsString;
      FPedidoVendasLista[i].STATUS                    := lQry.FieldByName('STATUS').AsString;
      FPedidoVendasLista[i].DATA_FATURADO             := lQry.FieldByName('DATA_FATURADO').AsString;
      FPedidoVendasLista[i].NUMERO_NF                 := lQry.FieldByName('NUMERO_NF').AsString;
      FPedidoVendasLista[i].VALOR_SUFRAMA             := lQry.FieldByName('VALOR_SUFRAMA').AsString;
      FPedidoVendasLista[i].CARGA_ID                  := lQry.FieldByName('CARGA_ID').AsString;
      FPedidoVendasLista[i].LISTA_NOIVA_ID            := lQry.FieldByName('LISTA_NOIVA_ID').AsString;
      FPedidoVendasLista[i].VALOR_RESTITUICAO         := lQry.FieldByName('VALOR_RESTITUICAO').AsString;
      FPedidoVendasLista[i].SYSTIME                   := lQry.FieldByName('SYSTIME').AsString;
      FPedidoVendasLista[i].DESCONTO_DRG              := lQry.FieldByName('DESCONTO_DRG').AsString;
      FPedidoVendasLista[i].STATUS_ID                 := lQry.FieldByName('STATUS_ID').AsString;
      FPedidoVendasLista[i].PRECO_VENDA_ID            := lQry.FieldByName('PRECO_VENDA_ID').AsString;
      FPedidoVendasLista[i].RNTRC                     := lQry.FieldByName('RNTRC').AsString;
      FPedidoVendasLista[i].PLACA                     := lQry.FieldByName('PLACA').AsString;
      FPedidoVendasLista[i].PESO_LIQUIDO              := lQry.FieldByName('PESO_LIQUIDO').AsString;
      FPedidoVendasLista[i].PESO_BRUTO                := lQry.FieldByName('PESO_BRUTO').AsString;
      FPedidoVendasLista[i].QTDE_VOLUME               := lQry.FieldByName('QTDE_VOLUME').AsString;
      FPedidoVendasLista[i].ESPECIE_VOLUME            := lQry.FieldByName('ESPECIE_VOLUME').AsString;
      FPedidoVendasLista[i].UF_TRANSPORTADORA         := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
      FPedidoVendasLista[i].PRODUCAO_ID               := lQry.FieldByName('PRODUCAO_ID').AsString;
      FPedidoVendasLista[i].REGIAO_ID                 := lQry.FieldByName('REGIAO_ID').AsString;
      FPedidoVendasLista[i].ORDEM                     := lQry.FieldByName('ORDEM').AsString;
      FPedidoVendasLista[i].CNPJ_CPF_CONSUMIDOR       := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
      FPedidoVendasLista[i].PEDIDO_COMPRA             := lQry.FieldByName('PEDIDO_COMPRA').AsString;
      FPedidoVendasLista[i].DATA_FINALIZADO           := lQry.FieldByName('DATA_FINALIZADO').AsString;
      FPedidoVendasLista[i].NUMERO_SENHA              := lQry.FieldByName('NUMERO_SENHA').AsString;
      FPedidoVendasLista[i].ARQUITETO_ID              := lQry.FieldByName('ARQUITETO_ID').AsString;
      FPedidoVendasLista[i].ARQUITETO_COMISSAO        := lQry.FieldByName('ARQUITETO_COMISSAO').AsString;
      FPedidoVendasLista[i].LOTE_CARGA_ID             := lQry.FieldByName('LOTE_CARGA_ID').AsString;
      FPedidoVendasLista[i].ENTREGA                   := lQry.FieldByName('ENTREGA').AsString;
      FPedidoVendasLista[i].VALOR_DESPESA_VENDA       := lQry.FieldByName('VALOR_DESPESA_VENDA').AsString;
      FPedidoVendasLista[i].ENTREGA_ENDERECO          := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
      FPedidoVendasLista[i].ENTREGA_COMPLEMENTO       := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
      FPedidoVendasLista[i].ENTREGA_NUMERO            := lQry.FieldByName('ENTREGA_NUMERO').AsString;
      FPedidoVendasLista[i].ENTREGA_BAIRRO            := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
      FPedidoVendasLista[i].ENTREGA_CIDADE            := lQry.FieldByName('ENTREGA_CIDADE').AsString;
      FPedidoVendasLista[i].ENTREGA_CEP               := lQry.FieldByName('ENTREGA_CEP').AsString;
      FPedidoVendasLista[i].ENTREGA_UF                := lQry.FieldByName('ENTREGA_UF').AsString;
      FPedidoVendasLista[i].ENTREGA_COD_MUNICIPIO     := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
      FPedidoVendasLista[i].ENTREGA_TELEFONE          := lQry.FieldByName('ENTREGA_TELEFONE').AsString;
      FPedidoVendasLista[i].ENTREGA_CELULAR           := lQry.FieldByName('ENTREGA_CELULAR').AsString;
      FPedidoVendasLista[i].ENTREGA_OBSERVACAO        := lQry.FieldByName('ENTREGA_OBSERVACAO').AsString;
      FPedidoVendasLista[i].ENTREGA_HORA              := lQry.FieldByName('ENTREGA_HORA').AsString;
      FPedidoVendasLista[i].ENTREGA_CONTATO           := lQry.FieldByName('ENTREGA_CONTATO').AsString;
      FPedidoVendasLista[i].ENTREGA_AGENDA_ID         := lQry.FieldByName('ENTREGA_AGENDA_ID').AsString;
      FPedidoVendasLista[i].ENTREGA_REGIAO_ID         := lQry.FieldByName('ENTREGA_REGIAO_ID').AsString;
      FPedidoVendasLista[i].ENTREGADOR_ID             := lQry.FieldByName('ENTREGADOR_ID').AsString;
      FPedidoVendasLista[i].FATURA_ID                 := lQry.FieldByName('FATURA_ID').AsString;
      FPedidoVendasLista[i].DATAHORA_IMPRESSO         := lQry.FieldByName('DATAHORA_IMPRESSO').AsString;
      FPedidoVendasLista[i].CTR_IMPRESSAO_ITENS       := lQry.FieldByName('CTR_IMPRESSAO_ITENS').AsString;
      FPedidoVendasLista[i].RESERVADO                 := lQry.FieldByName('RESERVADO').AsString;
      FPedidoVendasLista[i].PATRIMONIO_OBSERVACAO     := lQry.FieldByName('PATRIMONIO_OBSERVACAO').AsString;
      FPedidoVendasLista[i].OBS_GERAL                 := lQry.FieldByName('OBS_GERAL').AsString;
      FPedidoVendasLista[i].SMS                       := lQry.FieldByName('SMS').AsString;
      FPedidoVendasLista[i].IMP_TICKET                := lQry.FieldByName('IMP_TICKET').AsString;
      FPedidoVendasLista[i].COMANDA                   := lQry.FieldByName('COMANDA').AsString;
      FPedidoVendasLista[i].VALOR_TAXA_SERVICO        := lQry.FieldByName('VALOR_TAXA_SERVICO').AsString;
      FPedidoVendasLista[i].VFCPUFDEST                := lQry.FieldByName('VFCPUFDEST').AsString;
      FPedidoVendasLista[i].VICMSUFDEST               := lQry.FieldByName('VICMSUFDEST').AsString;
      FPedidoVendasLista[i].VICMSUFREMET              := lQry.FieldByName('VICMSUFREMET').AsString;
      FPedidoVendasLista[i].ENTREGUE                  := lQry.FieldByName('ENTREGUE').AsString;
      FPedidoVendasLista[i].INDICACAO_ID              := lQry.FieldByName('INDICACAO_ID').AsString;
      FPedidoVendasLista[i].ZERAR_ST                  := lQry.FieldByName('ZERAR_ST').AsString;
      FPedidoVendasLista[i].PEDIDO_VIDRACARIA         := lQry.FieldByName('PEDIDO_VIDRACARIA').AsString;
      FPedidoVendasLista[i].CHAVE_XML_NF              := lQry.FieldByName('CHAVE_XML_NF').AsString;
      FPedidoVendasLista[i].ARQUIVO_XML_NF            := lQry.FieldByName('ARQUIVO_XML_NF').AsString;
      FPedidoVendasLista[i].GERENTE_ID                := lQry.FieldByName('GERENTE_ID').AsString;
      FPedidoVendasLista[i].ENTRADA_PORTADOR_ID       := lQry.FieldByName('ENTRADA_PORTADOR_ID').AsString;
      FPedidoVendasLista[i].DATA_COTACAO              := lQry.FieldByName('DATA_COTACAO').AsString;
      FPedidoVendasLista[i].TIPO_COMISSAO             := lQry.FieldByName('TIPO_COMISSAO').AsString;
      FPedidoVendasLista[i].GERENTE_TIPO_COMISSAO     := lQry.FieldByName('GERENTE_TIPO_COMISSAO').AsString;
      FPedidoVendasLista[i].POS_VENDA                 := lQry.FieldByName('POS_VENDA').AsString;
      FPedidoVendasLista[i].VLR_GARANTIA              := lQry.FieldByName('VLR_GARANTIA').AsString;
      FPedidoVendasLista[i].WEB_PEDIDO_ID             := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
      FPedidoVendasLista[i].LACA_OU_GLASS             := lQry.FieldByName('LACA_OU_GLASS').AsString;
      FPedidoVendasLista[i].VFCPST                    := lQry.FieldByName('VFCPST').AsString;
      FPedidoVendasLista[i].MONTAGEM_DATA             := lQry.FieldByName('MONTAGEM_DATA').AsString;
      FPedidoVendasLista[i].MONTAGEM_HORA             := lQry.FieldByName('MONTAGEM_HORA').AsString;
      FPedidoVendasLista[i].FORM                      := lQry.FieldByName('FORM').AsString;
      FPedidoVendasLista[i].VICMSDESON                := lQry.FieldByName('VICMSDESON').AsString;
      FPedidoVendasLista[i].QTDEITENS                 := lQry.FieldByName('QTDEITENS').AsString;
      FPedidoVendasLista[i].CTR_ENVIO_PEDIDO          := lQry.FieldByName('CTR_ENVIO_PEDIDO').AsString;
      FPedidoVendasLista[i].CTR_ENVIO_BOLETO          := lQry.FieldByName('CTR_ENVIO_BOLETO').AsString;
      FPedidoVendasLista[i].CTR_ENVIO_NFE             := lQry.FieldByName('CTR_ENVIO_NFE').AsString;
      FPedidoVendasLista[i].DATAHORA_COLETA           := lQry.FieldByName('DATAHORA_COLETA').AsString;
      FPedidoVendasLista[i].DATAHORA_RETIRADA         := lQry.FieldByName('DATAHORA_RETIRADA').AsString;
      FPedidoVendasLista[i].FANTASIA_CLI              := lQry.FieldByName('FANTASIA_CLI').AsString;
      FPedidoVendasLista[i].NOME_VENDEDOR             := lQry.FieldByName('NOME_FUN').AsString;
      FPedidoVendasLista[i].CFOP_NF                   := lQry.FieldByName('CFOP_NF').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;
function TPedidoVendaDao.obterPedido(pNumeroPedido: String): TPedidoVendaModel;
var
  lQry: TFDQuery;
  lSQL:String;
  lPedidoVendaModel: TPedidoVendaModel;
begin
  lQry := vIConexao.CriarQuery;
  lPedidoVendaModel := TPedidoVendaModel.Create(vIConexao);
  try
    lSql :=
          ' select                                                 '+#13+
          '     p.numero_ped,                                      '+#13+
          '     p.codigo_cli,                                      '+#13+
          '     p.codigo_port,                                     '+#13+
          '     p.codigo_ven,                                      '+#13+
          '     p.data_ped,                                        '+#13+
          '     p.hora_ped,                                        '+#13+
          '     c.fantasia_cli,                                    '+#13+
          '     c.endereco,                                        '+#13+
          '     c.bairro_cli,                                      '+#13+
          '     c.cidade_cli,                                      '+#13+
          '     c.uf_cli,                                          '+#13+
          '     c.cnpj_cpf_cli,                                    '+#13+
          '     p.valor_ped,                                       '+#13+
          '     p.acres_ped,                                       '+#13+
          '     p.frete_ped,                                       '+#13+
          '     p.desc_ped,                                        '+#13+
          '     p.total_ped,                                       '+#13+
          '     p.status_ped,                                      '+#13+
          '     f.nome_fun                                         '+#13+
          '                                                        '+#13+
          ' from                                                   '+#13+
          '     pedidovenda p                                      '+#13+
          '                                                        '+#13+
          ' left join clientes c on c.codigo_cli = p.codigo_cli    '+#13+
          ' left join funcionario f on f.codigo_fun = p.codigo_ven '+#13+
          '                                                        '+#13+
          ' where                                                  '+#13+
          '     p.numero_ped = '+QuotedStr(pNumeroPedido);
    lQry.Open(lSQL);
    lPedidoVendaModel.NUMERO_PED     :=  lQry.FieldByName('NUMERO_PED').AsString;
    lPedidoVendaModel.CODIGO_CLI     :=  lQry.FieldByName('CODIGO_CLI').AsString;
    lPedidoVendaModel.CODIGO_PORT    :=  lQry.FieldByName('CODIGO_PORT').AsString;
    lPedidoVendaModel.CODIGO_VEN     :=  lQry.FieldByName('CODIGO_VEN').AsString;
    lPedidoVendaModel.DATA_PED       :=  lQry.FieldByName('DATA_PED').AsString;
    lPedidoVendaModel.HORA_PED       :=  lQry.FieldByName('HORA_PED').AsString;
    lPedidoVendaModel.FANTASIA_CLI   :=  lQry.FieldByName('FANTASIA_CLI').AsString;
    lPedidoVendaModel.ENDERECO       :=  lQry.FieldByName('ENDERECO').AsString;
    lPedidoVendaModel.BAIRRO_CLI     :=  lQry.FieldByName('BAIRRO_CLI').AsString;
    lPedidoVendaModel.CIDADE_CLI     :=  lQry.FieldByName('CIDADE_CLI').AsString;
    lPedidoVendaModel.UF_CLI         :=  lQry.FieldByName('UF_CLI').AsString;
    lPedidoVendaModel.CNPJ_CPF_CLI   :=  lQry.FieldByName('CNPJ_CPF_CLI').AsString;
    lPedidoVendaModel.VALOR_PED      :=  lQry.FieldByName('VALOR_PED').AsString;
    lPedidoVendaModel.FRETE_PED      :=  lQry.FieldByName('FRETE_PED').AsString;
    lPedidoVendaModel.ACRES_PED      :=  lQry.FieldByName('ACRES_PED').AsString;
    lPedidoVendaModel.DESC_PED       :=  lQry.FieldByName('DESC_PED').AsString;
    lPedidoVendaModel.TOTAL_PED      :=  lQry.FieldByName('TOTAL_PED').AsString;
    lPedidoVendaModel.STATUS_PED     :=  lQry.FieldByName('STATUS_PED').AsString;
    lPedidoVendaModel.NOME_VENDEDOR  :=  lQry.FieldByName('NOME_FUN').AsString;
    Result := lPedidoVendaModel;
  finally
    lQry.Free;
  end;
end;

function TPedidoVendaDao.ObterProdutoBalanca(pBarrasProduto: String): String;
var
  lQry           : TFDQuery;
  lSQL           : String;
  lConfiguracoes : TerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;
  lConfiguracoes := vIConexao.getTerasoftConfiguracoes as TerasoftConfiguracoes;
  try

    if (Length(pBarrasProduto) = 13) and (Copy(pBarrasProduto, 1, 1) = '1') then
    begin
      lSQL := 'SELECT * FROM PRODUTO P WHERE P.USAR_BALANCA = ''S'' AND P.CODIGO_PRO = '+ QuotedStr(((Copy(pBarrasProduto, StrToInt(lConfiguracoes.valorTag('tagConfig_BALANCA_COPY_INI_PRODUTO', '2', tvString)), StrToInt(lConfiguracoes.valorTag('tagConfig_BALANCA_COPY_FIM_PRODUTO', '6', tvString))))));
      lQry.Open(lSQL);
    end
    else if (Length(pBarrasProduto) = 13) and (Copy(pBarrasProduto, 1, 1) = '2') then
    begin
      lSQL := 'SELECT * FROM PRODUTO P WHERE P.USAR_BALANCA = ''S'' AND P.BARRAS_PRO = '+ QuotedStr(IntToStr(StrToInt(Copy(pBarrasProduto,StrToInt(lConfiguracoes.valorTag('tagConfig_BALANCA_COPY_INI_PRODUTO', '2', tvString)), StrToInt(lConfiguracoes.valorTag('tagConfig_BALANCA_COPY_FIM_PRODUTO', '6', tvString))))));
      lQry.Open(lSQL);
    end;

    if lQry.RecordCount = 0 then
      Result := ''
    else
      Result := lQry.FieldByName('BARRAS_PRO').AsString;
  finally
    lQry.Free;
  end;
end;

procedure TPedidoVendaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TPedidoVendaDao.SetPedidoVendasLista(const Value: TObjectList<TPedidoVendaModel>);
begin
  FPedidoVendasLista := Value;
end;
procedure TPedidoVendaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;
procedure TPedidoVendaDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;
procedure TPedidoVendaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;
procedure TPedidoVendaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoVendaDao.setParams(var pQry: TFDQuery; pPedidoVendaModel: TPedidoVendaModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PEDIDOVENDA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPedidoVendaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPedidoVendaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pPedidoVendaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPedidoVendaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TPedidoVendaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TPedidoVendaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
function TPedidoVendaDao.statusPedido(pId: String): String;
begin
  Result := vIConexao
              .getConnection
              .ExecSQLScalar('select status_ped from pedidovenda where numero_ped = '+ QuotedStr(pId));
end;
end.
