unit PedidoVendaDao;

interface

uses
  PedidoVendaModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Enumerado,
  Terasoft.Framework.ListaSimples.Impl,
  Interfaces.Conexao;

type
  TPedidoVendaDao = class

  private
    vIConexao : IConexao;

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

    function montaCondicaoQuery: String;
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

    function incluir(APedidoVendaModel: TPedidoVendaModel): String;
    function alterar(APedidoVendaModel: TPedidoVendaModel): String;
    function excluir(APedidoVendaModel: TPedidoVendaModel): String;
	
    procedure obterLista;

    function obterPedido(pNumeroPedido: String): TPedidoVendaModel;
    function carregaClasse(pId: String): TPedidoVendaModel;
    function statusPedido(pId: String): String;

    procedure obterUpdateImpostos(pNumeroPedido: String);



end;

implementation

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
  vIConexao := pConexao;
end;

destructor TPedidoVendaDao.Destroy;
begin

  inherited;
end;

function TPedidoVendaDao.incluir(APedidoVendaModel: TPedidoVendaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := ' insert into pedidovenda (numero_ped,                          '+SLineBreak+
          '                         codigo_cli,                           '+SLineBreak+
          '                         codigo_ven,                           '+SLineBreak+
          '                         codigo_port,                          '+SLineBreak+
          '                         codigo_tip,                           '+SLineBreak+
          '                         data_ped,                             '+SLineBreak+
          '                         valor_ped,                            '+SLineBreak+
          '                         desc_ped,                             '+SLineBreak+
          '                         acres_ped,                            '+SLineBreak+
          '                         total_ped,                            '+SLineBreak+
          '                         usuario_ped,                          '+SLineBreak+
          '                         numero_orc,                           '+SLineBreak+
          '                         informacoes_ped,                      '+SLineBreak+
          '                         tipo_ped,                             '+SLineBreak+
          '                         indce_ped,                            '+SLineBreak+
          '                         cfop_id,                              '+SLineBreak+
          '                         primeirovenc_ped,                     '+SLineBreak+
          '                         valorentada_ped,                      '+SLineBreak+
          '                         parcelas_ped,                         '+SLineBreak+
          '                         parcela_ped,                          '+SLineBreak+
          '                         status_ped,                           '+SLineBreak+
          '                         tabjuros_ped,                         '+SLineBreak+
          '                         contato_ped,                          '+SLineBreak+
          '                         desconto_ped,                         '+SLineBreak+
          '                         ctr_impressao_ped,                    '+SLineBreak+
          '                         frete_ped,                            '+SLineBreak+
          '                         condicoes_pag,                        '+SLineBreak+
          '                         total1_ped,                           '+SLineBreak+
          '                         total2_ped,                           '+SLineBreak+
          '                         local_ped,                            '+SLineBreak+
          '                         televenda_ped,                        '+SLineBreak+
          '                         peso_ped,                             '+SLineBreak+
          '                         primeirovenc2_ped,                    '+SLineBreak+
          '                         parcelas2_ped,                        '+SLineBreak+
          '                         valor_ipi,                            '+SLineBreak+
          '                         condicoes2_pag,                       '+SLineBreak+
          '                         loja,                                 '+SLineBreak+
          '                         dolar,                                '+SLineBreak+
          '                         ctr_exportacao,                       '+SLineBreak+
          '                         numero_cf,                            '+SLineBreak+
          '                         cf_aberto,                            '+SLineBreak+
          '                         nao_fiscal_aberto,                    '+SLineBreak+
          '                         hora_ped,                             '+SLineBreak+
          '                         tipo_frete,                           '+SLineBreak+
          '                         valor_pago,                           '+SLineBreak+
          '                         status,                               '+SLineBreak+
          '                         data_faturado,                        '+SLineBreak+
          '                         numero_nf,                            '+SLineBreak+
          '                         valor_suframa,                        '+SLineBreak+
          '                         carga_id,                             '+SLineBreak+
          '                         lista_noiva_id,                       '+SLineBreak+
          '                         valor_restituicao,                    '+SLineBreak+
          '                         desconto_drg,                         '+SLineBreak+
          '                         status_id,                            '+SLineBreak+
          '                         preco_venda_id,                       '+SLineBreak+
          '                         rntrc,                                '+SLineBreak+
          '                         placa,                                '+SLineBreak+
          '                         peso_liquido,                         '+SLineBreak+
          '                         peso_bruto,                           '+SLineBreak+
          '                         qtde_volume,                          '+SLineBreak+
          '                         especie_volume,                       '+SLineBreak+
          '                         uf_transportadora,                    '+SLineBreak+
          '                         producao_id,                          '+SLineBreak+
          '                         regiao_id,                            '+SLineBreak+
          '                         ordem,                                '+SLineBreak+
          '                         cnpj_cpf_consumidor,                  '+SLineBreak+
          '                         pedido_compra,                        '+SLineBreak+
          '                         data_finalizado,                      '+SLineBreak+
          '                         numero_senha,                         '+SLineBreak+
          '                         arquiteto_id,                         '+SLineBreak+
          '                         arquiteto_comissao,                   '+SLineBreak+
          '                         lote_carga_id,                        '+SLineBreak+
          '                         entrega,                              '+SLineBreak+
          '                         valor_despesa_venda,                  '+SLineBreak+
          '                         entrega_endereco,                     '+SLineBreak+
          '                         entrega_complemento,                  '+SLineBreak+
          '                         entrega_numero,                       '+SLineBreak+
          '                         entrega_bairro,                       '+SLineBreak+
          '                         entrega_cidade,                       '+SLineBreak+
          '                         entrega_cep,                          '+SLineBreak+
          '                         entrega_uf,                           '+SLineBreak+
          '                         entrega_cod_municipio,                '+SLineBreak+
          '                         entrega_telefone,                     '+SLineBreak+
          '                         entrega_celular,                      '+SLineBreak+
          '                         entrega_observacao,                   '+SLineBreak+
          '                         entrega_hora,                         '+SLineBreak+
          '                         entrega_contato,                      '+SLineBreak+
          '                         entrega_agenda_id,                    '+SLineBreak+
          '                         entrega_regiao_id,                    '+SLineBreak+
          '                         entregador_id,                        '+SLineBreak+
          '                         fatura_id,                            '+SLineBreak+
          '                         datahora_impresso,                    '+SLineBreak+
          '                         ctr_impressao_itens,                  '+SLineBreak+
          '                         reservado,                            '+SLineBreak+
          '                         patrimonio_observacao,                '+SLineBreak+
          '                         obs_geral,                            '+SLineBreak+
          '                         sms,                                  '+SLineBreak+
          '                         imp_ticket,                           '+SLineBreak+
          '                         comanda,                              '+SLineBreak+
          '                         valor_taxa_servico,                   '+SLineBreak+
          '                         vfcpufdest,                           '+SLineBreak+
          '                         vicmsufdest,                          '+SLineBreak+
          '                         vicmsufremet,                         '+SLineBreak+
          '                         entregue,                             '+SLineBreak+
          '                         indicacao_id,                         '+SLineBreak+
          '                         zerar_st,                             '+SLineBreak+
          '                         pedido_vidracaria,                    '+SLineBreak+
          '                         chave_xml_nf,                         '+SLineBreak+
          '                         arquivo_xml_nf,                       '+SLineBreak+
          '                         gerente_id,                           '+SLineBreak+
          '                         entrada_portador_id,                  '+SLineBreak+
          '                         data_cotacao,                         '+SLineBreak+
          '                         tipo_comissao,                        '+SLineBreak+
          '                         gerente_tipo_comissao,                '+SLineBreak+
          '                         pos_venda,                            '+SLineBreak+
          '                         vlr_garantia,                         '+SLineBreak+
          '                         web_pedido_id,                        '+SLineBreak+
          '                         laca_ou_glass,                        '+SLineBreak+
          '                         vfcpst,                               '+SLineBreak+
          '                         montagem_data,                        '+SLineBreak+
          '                         montagem_hora,                        '+SLineBreak+
          '                         vicmsdeson,                           '+SLineBreak+
          '                         qtdeitens,                            '+SLineBreak+
          '                         ctr_envio_pedido,                     '+SLineBreak+
          '                         ctr_envio_boleto,                     '+SLineBreak+
          '                         ctr_envio_nfe,                        '+SLineBreak+
          '                         datahora_coleta,                      '+SLineBreak+
          '                         datahora_retirada,                    '+SLineBreak+
          '                         cfop_nf)                              '+SLineBreak+
          'values (:numero_ped,                                           '+SLineBreak+
          '        :codigo_cli,                                           '+SLineBreak+
          '        :codigo_ven,                                           '+SLineBreak+
          '        :codigo_port,                                          '+SLineBreak+
          '        :codigo_tip,                                           '+SLineBreak+
          '        :data_ped,                                             '+SLineBreak+
          '        :valor_ped,                                            '+SLineBreak+
          '        :desc_ped,                                             '+SLineBreak+
          '        :acres_ped,                                            '+SLineBreak+
          '        :total_ped,                                            '+SLineBreak+
          '        :usuario_ped,                                          '+SLineBreak+
          '        :numero_orc,                                           '+SLineBreak+
          '        :informacoes_ped,                                      '+SLineBreak+
          '        :tipo_ped,                                             '+SLineBreak+
          '        :indce_ped,                                            '+SLineBreak+
          '        :cfop_id,                                              '+SLineBreak+
          '        :primeirovenc_ped,                                     '+SLineBreak+
          '        :valorentada_ped,                                      '+SLineBreak+
          '        :parcelas_ped,                                         '+SLineBreak+
          '        :parcela_ped,                                          '+SLineBreak+
          '        :status_ped,                                           '+SLineBreak+
          '        :tabjuros_ped,                                         '+SLineBreak+
          '        :contato_ped,                                          '+SLineBreak+
          '        :desconto_ped,                                         '+SLineBreak+
          '        :ctr_impressao_ped,                                    '+SLineBreak+
          '        :frete_ped,                                            '+SLineBreak+
          '        :condicoes_pag,                                        '+SLineBreak+
          '        :total1_ped,                                           '+SLineBreak+
          '        :total2_ped,                                           '+SLineBreak+
          '        :local_ped,                                            '+SLineBreak+
          '        :televenda_ped,                                        '+SLineBreak+
          '        :peso_ped,                                             '+SLineBreak+
          '        :primeirovenc2_ped,                                    '+SLineBreak+
          '        :parcelas2_ped,                                        '+SLineBreak+
          '        :valor_ipi,                                            '+SLineBreak+
          '        :condicoes2_pag,                                       '+SLineBreak+
          '        :loja,                                                 '+SLineBreak+
          '        :dolar,                                                '+SLineBreak+
          '        :ctr_exportacao,                                       '+SLineBreak+
          '        :numero_cf,                                            '+SLineBreak+
          '        :cf_aberto,                                            '+SLineBreak+
          '        :nao_fiscal_aberto,                                    '+SLineBreak+
          '        :hora_ped,                                             '+SLineBreak+
          '        :tipo_frete,                                           '+SLineBreak+
          '        :valor_pago,                                           '+SLineBreak+
          '        :status,                                               '+SLineBreak+
          '        :data_faturado,                                        '+SLineBreak+
          '        :numero_nf,                                            '+SLineBreak+
          '        :valor_suframa,                                        '+SLineBreak+
          '        :carga_id,                                             '+SLineBreak+
          '        :lista_noiva_id,                                       '+SLineBreak+
          '        :valor_restituicao,                                    '+SLineBreak+
          '        :desconto_drg,                                         '+SLineBreak+
          '        :status_id,                                            '+SLineBreak+
          '        :preco_venda_id,                                       '+SLineBreak+
          '        :rntrc,                                                '+SLineBreak+
          '        :placa,                                                '+SLineBreak+
          '        :peso_liquido,                                         '+SLineBreak+
          '        :peso_bruto,                                           '+SLineBreak+
          '        :qtde_volume,                                          '+SLineBreak+
          '        :especie_volume,                                       '+SLineBreak+
          '        :uf_transportadora,                                    '+SLineBreak+
          '        :producao_id,                                          '+SLineBreak+
          '        :regiao_id,                                            '+SLineBreak+
          '        :ordem,                                                '+SLineBreak+
          '        :cnpj_cpf_consumidor,                                  '+SLineBreak+
          '        :pedido_compra,                                        '+SLineBreak+
          '        :data_finalizado,                                      '+SLineBreak+
          '        :numero_senha,                                         '+SLineBreak+
          '        :arquiteto_id,                                         '+SLineBreak+
          '        :arquiteto_comissao,                                   '+SLineBreak+
          '        :lote_carga_id,                                        '+SLineBreak+
          '        :entrega,                                              '+SLineBreak+
          '        :valor_despesa_venda,                                  '+SLineBreak+
          '        :entrega_endereco,                                     '+SLineBreak+
          '        :entrega_complemento,                                  '+SLineBreak+
          '        :entrega_numero,                                       '+SLineBreak+
          '        :entrega_bairro,                                       '+SLineBreak+
          '        :entrega_cidade,                                       '+SLineBreak+
          '        :entrega_cep,                                          '+SLineBreak+
          '        :entrega_uf,                                           '+SLineBreak+
          '        :entrega_cod_municipio,                                '+SLineBreak+
          '        :entrega_telefone,                                     '+SLineBreak+
          '        :entrega_celular,                                      '+SLineBreak+
          '        :entrega_observacao,                                   '+SLineBreak+
          '        :entrega_hora,                                         '+SLineBreak+
          '        :entrega_contato,                                      '+SLineBreak+
          '        :entrega_agenda_id,                                    '+SLineBreak+
          '        :entrega_regiao_id,                                    '+SLineBreak+
          '        :entregador_id,                                        '+SLineBreak+
          '        :fatura_id,                                            '+SLineBreak+
          '        :datahora_impresso,                                    '+SLineBreak+
          '        :ctr_impressao_itens,                                  '+SLineBreak+
          '        :reservado,                                            '+SLineBreak+
          '        :patrimonio_observacao,                                '+SLineBreak+
          '        :obs_geral,                                            '+SLineBreak+
          '        :sms,                                                  '+SLineBreak+
          '        :imp_ticket,                                           '+SLineBreak+
          '        :comanda,                                              '+SLineBreak+
          '        :valor_taxa_servico,                                   '+SLineBreak+
          '        :vfcpufdest,                                           '+SLineBreak+
          '        :vicmsufdest,                                          '+SLineBreak+
          '        :vicmsufremet,                                         '+SLineBreak+
          '        :entregue,                                             '+SLineBreak+
          '        :indicacao_id,                                         '+SLineBreak+
          '        :zerar_st,                                             '+SLineBreak+
          '        :pedido_vidracaria,                                    '+SLineBreak+
          '        :chave_xml_nf,                                         '+SLineBreak+
          '        :arquivo_xml_nf,                                       '+SLineBreak+
          '        :gerente_id,                                           '+SLineBreak+
          '        :entrada_portador_id,                                  '+SLineBreak+
          '        :data_cotacao,                                         '+SLineBreak+
          '        :tipo_comissao,                                        '+SLineBreak+
          '        :gerente_tipo_comissao,                                '+SLineBreak+
          '        :pos_venda,                                            '+SLineBreak+
          '        :vlr_garantia,                                         '+SLineBreak+
          '        :web_pedido_id,                                        '+SLineBreak+
          '        :laca_ou_glass,                                        '+SLineBreak+
          '        :vfcpst,                                               '+SLineBreak+
          '        :montagem_data,                                        '+SLineBreak+
          '        :montagem_hora,                                        '+SLineBreak+
          '        :vicmsdeson,                                           '+SLineBreak+
          '        :qtdeitens,                                            '+SLineBreak+
          '        :ctr_envio_pedido,                                     '+SLineBreak+
          '        :ctr_envio_boleto,                                     '+SLineBreak+
          '        :ctr_envio_nfe,                                        '+SLineBreak+
          '        :datahora_coleta,                                      '+SLineBreak+
          '        :datahora_retirada,                                    '+SLineBreak+
          '        :cfop_nf)                                              '+SLineBreak+
          ' returning NUMERO_PED                                          '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_ped').Value := vIConexao.Generetor('GEN_PEDIDOVENDA');
    setParams(lQry, APedidoVendaModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_PED').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoVendaDao.alterar(APedidoVendaModel: TPedidoVendaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := ' update pedidovenda                                         '+SLineBreak+
          '    set codigo_cli = :codigo_cli,                           '+SLineBreak+
          '        codigo_ven = :codigo_ven,                           '+SLineBreak+
          '        codigo_port = :codigo_port,                         '+SLineBreak+
          '        codigo_tip = :codigo_tip,                           '+SLineBreak+
          '        data_ped = :data_ped,                               '+SLineBreak+
          '        valor_ped = :valor_ped,                             '+SLineBreak+
          '        desc_ped = :desc_ped,                               '+SLineBreak+
          '        acres_ped = :acres_ped,                             '+SLineBreak+
          '        total_ped = :total_ped,                             '+SLineBreak+
          '        usuario_ped = :usuario_ped,                         '+SLineBreak+
          '        numero_orc = :numero_orc,                           '+SLineBreak+
          '        informacoes_ped = :informacoes_ped,                 '+SLineBreak+
          '        tipo_ped = :tipo_ped,                               '+SLineBreak+
          '        indce_ped = :indce_ped,                             '+SLineBreak+
          '        cfop_id = :cfop_id,                                 '+SLineBreak+
          '        primeirovenc_ped = :primeirovenc_ped,               '+SLineBreak+
          '        valorentada_ped = :valorentada_ped,                 '+SLineBreak+
          '        parcelas_ped = :parcelas_ped,                       '+SLineBreak+
          '        parcela_ped = :parcela_ped,                         '+SLineBreak+
          '        status_ped = :status_ped,                           '+SLineBreak+
          '        tabjuros_ped = :tabjuros_ped,                       '+SLineBreak+
          '        contato_ped = :contato_ped,                         '+SLineBreak+
          '        desconto_ped = :desconto_ped,                       '+SLineBreak+
          '        ctr_impressao_ped = :ctr_impressao_ped,             '+SLineBreak+
          '        frete_ped = :frete_ped,                             '+SLineBreak+
          '        condicoes_pag = :condicoes_pag,                     '+SLineBreak+
          '        total1_ped = :total1_ped,                           '+SLineBreak+
          '        total2_ped = :total2_ped,                           '+SLineBreak+
          '        local_ped = :local_ped,                             '+SLineBreak+
          '        televenda_ped = :televenda_ped,                     '+SLineBreak+
          '        peso_ped = :peso_ped,                               '+SLineBreak+
          '        primeirovenc2_ped = :primeirovenc2_ped,             '+SLineBreak+
          '        parcelas2_ped = :parcelas2_ped,                     '+SLineBreak+
          '        valor_ipi = :valor_ipi,                             '+SLineBreak+
          '        condicoes2_pag = :condicoes2_pag,                   '+SLineBreak+
          '        loja = :loja,                                       '+SLineBreak+
          '        dolar = :dolar,                                     '+SLineBreak+
          '        ctr_exportacao = :ctr_exportacao,                   '+SLineBreak+
          '        numero_cf = :numero_cf,                             '+SLineBreak+
          '        cf_aberto = :cf_aberto,                             '+SLineBreak+
          '        nao_fiscal_aberto = :nao_fiscal_aberto,             '+SLineBreak+
          '        hora_ped = :hora_ped,                               '+SLineBreak+
          '        tipo_frete = :tipo_frete,                           '+SLineBreak+
          '        valor_pago = :valor_pago,                           '+SLineBreak+
          '        status = :status,                                   '+SLineBreak+
          '        data_faturado = :data_faturado,                     '+SLineBreak+
          '        numero_nf = :numero_nf,                             '+SLineBreak+
          '        valor_suframa = :valor_suframa,                     '+SLineBreak+
          '        carga_id = :carga_id,                               '+SLineBreak+
          '        lista_noiva_id = :lista_noiva_id,                   '+SLineBreak+
          '        valor_restituicao = :valor_restituicao,             '+SLineBreak+
          '        desconto_drg = :desconto_drg,                       '+SLineBreak+
          '        status_id = :status_id,                             '+SLineBreak+
          '        preco_venda_id = :preco_venda_id,                   '+SLineBreak+
          '        rntrc = :rntrc,                                     '+SLineBreak+
          '        placa = :placa,                                     '+SLineBreak+
          '        peso_liquido = :peso_liquido,                       '+SLineBreak+
          '        peso_bruto = :peso_bruto,                           '+SLineBreak+
          '        qtde_volume = :qtde_volume,                         '+SLineBreak+
          '        especie_volume = :especie_volume,                   '+SLineBreak+
          '        uf_transportadora = :uf_transportadora,             '+SLineBreak+
          '        producao_id = :producao_id,                         '+SLineBreak+
          '        regiao_id = :regiao_id,                             '+SLineBreak+
          '        ordem = :ordem,                                     '+SLineBreak+
          '        cnpj_cpf_consumidor = :cnpj_cpf_consumidor,         '+SLineBreak+
          '        pedido_compra = :pedido_compra,                     '+SLineBreak+
          '        data_finalizado = :data_finalizado,                 '+SLineBreak+
          '        numero_senha = :numero_senha,                       '+SLineBreak+
          '        arquiteto_id = :arquiteto_id,                       '+SLineBreak+
          '        arquiteto_comissao = :arquiteto_comissao,           '+SLineBreak+
          '        lote_carga_id = :lote_carga_id,                     '+SLineBreak+
          '        entrega = :entrega,                                 '+SLineBreak+
          '        valor_despesa_venda = :valor_despesa_venda,         '+SLineBreak+
          '        entrega_endereco = :entrega_endereco,               '+SLineBreak+
          '        entrega_complemento = :entrega_complemento,         '+SLineBreak+
          '        entrega_numero = :entrega_numero,                   '+SLineBreak+
          '        entrega_bairro = :entrega_bairro,                   '+SLineBreak+
          '        entrega_cidade = :entrega_cidade,                   '+SLineBreak+
          '        entrega_cep = :entrega_cep,                         '+SLineBreak+
          '        entrega_uf = :entrega_uf,                           '+SLineBreak+
          '        entrega_cod_municipio = :entrega_cod_municipio,     '+SLineBreak+
          '        entrega_telefone = :entrega_telefone,               '+SLineBreak+
          '        entrega_celular = :entrega_celular,                 '+SLineBreak+
          '        entrega_observacao = :entrega_observacao,           '+SLineBreak+
          '        entrega_hora = :entrega_hora,                       '+SLineBreak+
          '        entrega_contato = :entrega_contato,                 '+SLineBreak+
          '        entrega_agenda_id = :entrega_agenda_id,             '+SLineBreak+
          '        entrega_regiao_id = :entrega_regiao_id,             '+SLineBreak+
          '        entregador_id = :entregador_id,                     '+SLineBreak+
          '        fatura_id = :fatura_id,                             '+SLineBreak+
          '        datahora_impresso = :datahora_impresso,             '+SLineBreak+
          '        ctr_impressao_itens = :ctr_impressao_itens,         '+SLineBreak+
          '        reservado = :reservado,                             '+SLineBreak+
          '        patrimonio_observacao = :patrimonio_observacao,     '+SLineBreak+
          '        obs_geral = :obs_geral,                             '+SLineBreak+
          '        sms = :sms,                                         '+SLineBreak+
          '        imp_ticket = :imp_ticket,                           '+SLineBreak+
          '        comanda = :comanda,                                 '+SLineBreak+
          '        valor_taxa_servico = :valor_taxa_servico,           '+SLineBreak+
          '        vfcpufdest = :vfcpufdest,                           '+SLineBreak+
          '        vicmsufdest = :vicmsufdest,                         '+SLineBreak+
          '        vicmsufremet = :vicmsufremet,                       '+SLineBreak+
          '        entregue = :entregue,                               '+SLineBreak+
          '        indicacao_id = :indicacao_id,                       '+SLineBreak+
          '        zerar_st = :zerar_st,                               '+SLineBreak+
          '        pedido_vidracaria = :pedido_vidracaria,             '+SLineBreak+
          '        chave_xml_nf = :chave_xml_nf,                       '+SLineBreak+
          '        arquivo_xml_nf = :arquivo_xml_nf,                   '+SLineBreak+
          '        gerente_id = :gerente_id,                           '+SLineBreak+
          '        entrada_portador_id = :entrada_portador_id,         '+SLineBreak+
          '        data_cotacao = :data_cotacao,                       '+SLineBreak+
          '        tipo_comissao = :tipo_comissao,                     '+SLineBreak+
          '        gerente_tipo_comissao = :gerente_tipo_comissao,     '+SLineBreak+
          '        pos_venda = :pos_venda,                             '+SLineBreak+
          '        vlr_garantia = :vlr_garantia,                       '+SLineBreak+
          '        web_pedido_id = :web_pedido_id,                     '+SLineBreak+
          '        laca_ou_glass = :laca_ou_glass,                     '+SLineBreak+
          '        vfcpst = :vfcpst,                                   '+SLineBreak+
          '        montagem_data = :montagem_data,                     '+SLineBreak+
          '        montagem_hora = :montagem_hora,                     '+SLineBreak+
          '        vicmsdeson = :vicmsdeson,                           '+SLineBreak+
          '        qtdeitens = :qtdeitens,                             '+SLineBreak+
          '        ctr_envio_pedido = :ctr_envio_pedido,               '+SLineBreak+
          '        ctr_envio_boleto = :ctr_envio_boleto,               '+SLineBreak+
          '        ctr_envio_nfe = :ctr_envio_nfe,                     '+SLineBreak+
          '        datahora_coleta = :datahora_coleta,                 '+SLineBreak+
          '        datahora_retirada = :datahora_retirada,             '+SLineBreak+
          '        cfop_nf = :cfop_nf                                  '+SLineBreak+
          '  where (numero_ped = :numero_ped)                          '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_ped').Value := IIF(APedidoVendaModel.NUMERO_PED = '', Unassigned, APedidoVendaModel.NUMERO_PED);
    setParams(lQry, APedidoVendaModel);
    lQry.ExecSQL;

    Result := APedidoVendaModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoVendaDao.excluir(APedidoVendaModel: TPedidoVendaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from pedidovenda where NUMERO_PED = :NUMERO_PED',[APedidoVendaModel.NUMERO_PED]);
   lQry.ExecSQL;
   Result := APedidoVendaModel.NUMERO_PED;

  finally
    lQry.Free;
  end;
end;

function TPedidoVendaDao.montaCondicaoQuery: String;
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

    lSql := lSql + montaCondicaoQuery;

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
      '       pedidovenda.*,           '+#13+
      '       clientes.fantasia_cli    '+#13+
	    '  from pedidovenda              '+#13+

      '  left join clientes on clientes.codigo_cli = pedidovenda.codigo_cli '+#13+

      ' where 1=1              ';

    lSql := lSql + montaCondicaoQuery;

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
begin
  pQry.ParamByName('codigo_cli').Value            := IIF(pPedidoVendaModel.CODIGO_CLI            = '', Unassigned, pPedidoVendaModel.CODIGO_CLI);
  pQry.ParamByName('codigo_ven').Value            := IIF(pPedidoVendaModel.CODIGO_VEN            = '', Unassigned, pPedidoVendaModel.CODIGO_VEN);
  pQry.ParamByName('codigo_port').Value           := IIF(pPedidoVendaModel.CODIGO_PORT           = '', Unassigned, pPedidoVendaModel.CODIGO_PORT);
  pQry.ParamByName('codigo_tip').Value            := IIF(pPedidoVendaModel.CODIGO_TIP            = '', Unassigned, pPedidoVendaModel.CODIGO_TIP);
  pQry.ParamByName('data_ped').Value              := IIF(pPedidoVendaModel.DATA_PED              = '', Unassigned, transformaDataFireBird(pPedidoVendaModel.DATA_PED));
  pQry.ParamByName('valor_ped').Value             := IIF(pPedidoVendaModel.VALOR_PED             = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VALOR_PED));
  pQry.ParamByName('desc_ped').Value              := IIF(pPedidoVendaModel.DESC_PED              = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.DESC_PED));
  pQry.ParamByName('acres_ped').Value             := IIF(pPedidoVendaModel.ACRES_PED             = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.ACRES_PED));
  pQry.ParamByName('total_ped').Value             := IIF(pPedidoVendaModel.TOTAL_PED             = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.TOTAL_PED));
  pQry.ParamByName('usuario_ped').Value           := IIF(pPedidoVendaModel.USUARIO_PED           = '', Unassigned, pPedidoVendaModel.USUARIO_PED);
  pQry.ParamByName('numero_orc').Value            := IIF(pPedidoVendaModel.NUMERO_ORC            = '', Unassigned, pPedidoVendaModel.NUMERO_ORC);
  pQry.ParamByName('informacoes_ped').Value       := IIF(pPedidoVendaModel.INFORMACOES_PED       = '', Unassigned, pPedidoVendaModel.INFORMACOES_PED);
  pQry.ParamByName('tipo_ped').Value              := IIF(pPedidoVendaModel.TIPO_PED              = '', Unassigned, pPedidoVendaModel.TIPO_PED);
  pQry.ParamByName('indce_ped').Value             := IIF(pPedidoVendaModel.INDCE_PED             = '', Unassigned, pPedidoVendaModel.INDCE_PED);
  pQry.ParamByName('cfop_id').Value               := IIF(pPedidoVendaModel.CFOP_ID               = '', Unassigned, pPedidoVendaModel.CFOP_ID);
  pQry.ParamByName('primeirovenc_ped').Value      := IIF(pPedidoVendaModel.PRIMEIROVENC_PED      = '', Unassigned, transformaDataFireBird(pPedidoVendaModel.PRIMEIROVENC_PED));
  pQry.ParamByName('valorentada_ped').Value       := IIF(pPedidoVendaModel.VALORENTADA_PED       = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VALORENTADA_PED));
  pQry.ParamByName('parcelas_ped').Value          := IIF(pPedidoVendaModel.PARCELAS_PED          = '', Unassigned, pPedidoVendaModel.PARCELAS_PED);
  pQry.ParamByName('parcela_ped').Value           := IIF(pPedidoVendaModel.PARCELA_PED           = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.PARCELA_PED));
  pQry.ParamByName('status_ped').Value            := IIF(pPedidoVendaModel.STATUS_PED            = '', Unassigned, pPedidoVendaModel.STATUS_PED);
  pQry.ParamByName('tabjuros_ped').Value          := IIF(pPedidoVendaModel.TABJUROS_PED          = '', Unassigned, pPedidoVendaModel.TABJUROS_PED);
  pQry.ParamByName('contato_ped').Value           := IIF(pPedidoVendaModel.CONTATO_PED           = '', Unassigned, pPedidoVendaModel.CONTATO_PED);
  pQry.ParamByName('desconto_ped').Value          := IIF(pPedidoVendaModel.DESCONTO_PED          = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.DESCONTO_PED));
  pQry.ParamByName('ctr_impressao_ped').Value     := IIF(pPedidoVendaModel.CTR_IMPRESSAO_PED     = '', Unassigned, pPedidoVendaModel.CTR_IMPRESSAO_PED);
  pQry.ParamByName('frete_ped').Value             := IIF(pPedidoVendaModel.FRETE_PED             = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.FRETE_PED));
  pQry.ParamByName('condicoes_pag').Value         := IIF(pPedidoVendaModel.CONDICOES_PAG         = '', Unassigned, pPedidoVendaModel.CONDICOES_PAG);
  pQry.ParamByName('total1_ped').Value            := IIF(pPedidoVendaModel.TOTAL1_PED            = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.TOTAL1_PED));
  pQry.ParamByName('total2_ped').Value            := IIF(pPedidoVendaModel.TOTAL2_PED            = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.TOTAL2_PED));
  pQry.ParamByName('local_ped').Value             := IIF(pPedidoVendaModel.LOCAL_PED             = '', Unassigned, pPedidoVendaModel.LOCAL_PED);
  pQry.ParamByName('televenda_ped').Value         := IIF(pPedidoVendaModel.TELEVENDA_PED         = '', Unassigned, pPedidoVendaModel.TELEVENDA_PED);
  pQry.ParamByName('peso_ped').Value              := IIF(pPedidoVendaModel.PESO_PED              = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.PESO_PED));
  pQry.ParamByName('primeirovenc2_ped').Value     := IIF(pPedidoVendaModel.PRIMEIROVENC2_PED     = '', Unassigned, transformaDataFireBird(pPedidoVendaModel.PRIMEIROVENC2_PED));
  pQry.ParamByName('parcelas2_ped').Value         := IIF(pPedidoVendaModel.PARCELAS2_PED         = '', Unassigned, pPedidoVendaModel.PARCELAS2_PED);
  pQry.ParamByName('valor_ipi').Value             := IIF(pPedidoVendaModel.VALOR_IPI             = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VALOR_IPI));
  pQry.ParamByName('condicoes2_pag').Value        := IIF(pPedidoVendaModel.CONDICOES2_PAG        = '', Unassigned, pPedidoVendaModel.CONDICOES2_PAG);
  pQry.ParamByName('loja').Value                  := IIF(pPedidoVendaModel.LOJA                  = '', Unassigned, pPedidoVendaModel.LOJA);
  pQry.ParamByName('dolar').Value                 := IIF(pPedidoVendaModel.DOLAR                 = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.DOLAR));
  pQry.ParamByName('ctr_exportacao').Value        := IIF(pPedidoVendaModel.CTR_EXPORTACAO        = '', Unassigned, pPedidoVendaModel.CTR_EXPORTACAO);
  pQry.ParamByName('numero_cf').Value             := IIF(pPedidoVendaModel.NUMERO_CF             = '', Unassigned, pPedidoVendaModel.NUMERO_CF);
  pQry.ParamByName('cf_aberto').Value             := IIF(pPedidoVendaModel.CF_ABERTO             = '', Unassigned, pPedidoVendaModel.CF_ABERTO);
  pQry.ParamByName('nao_fiscal_aberto').Value     := IIF(pPedidoVendaModel.NAO_FISCAL_ABERTO     = '', Unassigned, pPedidoVendaModel.NAO_FISCAL_ABERTO);
  pQry.ParamByName('hora_ped').Value              := IIF(pPedidoVendaModel.HORA_PED              = '', Unassigned, pPedidoVendaModel.HORA_PED);
  pQry.ParamByName('tipo_frete').Value            := IIF(pPedidoVendaModel.TIPO_FRETE            = '', Unassigned, pPedidoVendaModel.TIPO_FRETE);
  pQry.ParamByName('valor_pago').Value            := IIF(pPedidoVendaModel.VALOR_PAGO            = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VALOR_PAGO));
  pQry.ParamByName('status').Value                := IIF(pPedidoVendaModel.STATUS                = '', Unassigned, pPedidoVendaModel.STATUS);
  pQry.ParamByName('data_faturado').Value         := IIF(pPedidoVendaModel.DATA_FATURADO         = '', Unassigned, transformaDataFireBird(pPedidoVendaModel.DATA_FATURADO));
  pQry.ParamByName('numero_nf').Value             := IIF(pPedidoVendaModel.NUMERO_NF             = '', Unassigned, pPedidoVendaModel.NUMERO_NF);
  pQry.ParamByName('valor_suframa').Value         := IIF(pPedidoVendaModel.VALOR_SUFRAMA         = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VALOR_SUFRAMA));
  pQry.ParamByName('carga_id').Value              := IIF(pPedidoVendaModel.CARGA_ID              = '', Unassigned, pPedidoVendaModel.CARGA_ID);
  pQry.ParamByName('lista_noiva_id').Value        := IIF(pPedidoVendaModel.LISTA_NOIVA_ID        = '', Unassigned, pPedidoVendaModel.LISTA_NOIVA_ID);
  pQry.ParamByName('valor_restituicao').Value     := IIF(pPedidoVendaModel.VALOR_RESTITUICAO     = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VALOR_RESTITUICAO));
  pQry.ParamByName('desconto_drg').Value          := IIF(pPedidoVendaModel.DESCONTO_DRG          = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.DESCONTO_DRG));
  pQry.ParamByName('status_id').Value             := IIF(pPedidoVendaModel.STATUS_ID             = '', Unassigned, pPedidoVendaModel.STATUS_ID);
  pQry.ParamByName('preco_venda_id').Value        := IIF(pPedidoVendaModel.PRECO_VENDA_ID        = '', Unassigned, pPedidoVendaModel.PRECO_VENDA_ID);
  pQry.ParamByName('rntrc').Value                 := IIF(pPedidoVendaModel.RNTRC                 = '', Unassigned, pPedidoVendaModel.RNTRC);
  pQry.ParamByName('placa').Value                 := IIF(pPedidoVendaModel.PLACA                 = '', Unassigned, pPedidoVendaModel.PLACA);
  pQry.ParamByName('peso_liquido').Value          := IIF(pPedidoVendaModel.PESO_LIQUIDO          = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.PESO_LIQUIDO));
  pQry.ParamByName('peso_bruto').Value            := IIF(pPedidoVendaModel.PESO_BRUTO            = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.PESO_BRUTO));
  pQry.ParamByName('qtde_volume').Value           := IIF(pPedidoVendaModel.QTDE_VOLUME           = '', Unassigned, pPedidoVendaModel.QTDE_VOLUME);
  pQry.ParamByName('especie_volume').Value        := IIF(pPedidoVendaModel.ESPECIE_VOLUME        = '', Unassigned, pPedidoVendaModel.ESPECIE_VOLUME);
  pQry.ParamByName('uf_transportadora').Value     := IIF(pPedidoVendaModel.UF_TRANSPORTADORA     = '', Unassigned, pPedidoVendaModel.UF_TRANSPORTADORA);
  pQry.ParamByName('producao_id').Value           := IIF(pPedidoVendaModel.PRODUCAO_ID           = '', Unassigned, pPedidoVendaModel.PRODUCAO_ID);
  pQry.ParamByName('regiao_id').Value             := IIF(pPedidoVendaModel.REGIAO_ID             = '', Unassigned, pPedidoVendaModel.REGIAO_ID);
  pQry.ParamByName('ordem').Value                 := IIF(pPedidoVendaModel.ORDEM                 = '', Unassigned, pPedidoVendaModel.ORDEM);
  pQry.ParamByName('cnpj_cpf_consumidor').Value   := IIF(pPedidoVendaModel.CNPJ_CPF_CONSUMIDOR   = '', Unassigned, pPedidoVendaModel.CNPJ_CPF_CONSUMIDOR);
  pQry.ParamByName('pedido_compra').Value         := IIF(pPedidoVendaModel.PEDIDO_COMPRA         = '', Unassigned, pPedidoVendaModel.PEDIDO_COMPRA);
  pQry.ParamByName('data_finalizado').Value       := IIF(pPedidoVendaModel.DATA_FINALIZADO       = '', Unassigned, transformaDataFireBird(pPedidoVendaModel.DATA_FINALIZADO));
  pQry.ParamByName('numero_senha').Value          := IIF(pPedidoVendaModel.NUMERO_SENHA          = '', Unassigned, pPedidoVendaModel.NUMERO_SENHA);
  pQry.ParamByName('arquiteto_id').Value          := IIF(pPedidoVendaModel.ARQUITETO_ID          = '', Unassigned, pPedidoVendaModel.ARQUITETO_ID);
  pQry.ParamByName('arquiteto_comissao').Value    := IIF(pPedidoVendaModel.ARQUITETO_COMISSAO    = '', Unassigned, pPedidoVendaModel.ARQUITETO_COMISSAO);
  pQry.ParamByName('lote_carga_id').Value         := IIF(pPedidoVendaModel.LOTE_CARGA_ID         = '', Unassigned, pPedidoVendaModel.LOTE_CARGA_ID);
  pQry.ParamByName('entrega').Value               := IIF(pPedidoVendaModel.ENTREGA               = '', Unassigned, pPedidoVendaModel.ENTREGA);
  pQry.ParamByName('valor_despesa_venda').Value   := IIF(pPedidoVendaModel.VALOR_DESPESA_VENDA   = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VALOR_DESPESA_VENDA));
  pQry.ParamByName('entrega_endereco').Value      := IIF(pPedidoVendaModel.ENTREGA_ENDERECO      = '', Unassigned, pPedidoVendaModel.ENTREGA_ENDERECO);
  pQry.ParamByName('entrega_complemento').Value   := IIF(pPedidoVendaModel.ENTREGA_COMPLEMENTO   = '', Unassigned, pPedidoVendaModel.ENTREGA_COMPLEMENTO);
  pQry.ParamByName('entrega_numero').Value        := IIF(pPedidoVendaModel.ENTREGA_NUMERO        = '', Unassigned, pPedidoVendaModel.ENTREGA_NUMERO);
  pQry.ParamByName('entrega_bairro').Value        := IIF(pPedidoVendaModel.ENTREGA_BAIRRO        = '', Unassigned, pPedidoVendaModel.ENTREGA_BAIRRO);
  pQry.ParamByName('entrega_cidade').Value        := IIF(pPedidoVendaModel.ENTREGA_CIDADE        = '', Unassigned, pPedidoVendaModel.ENTREGA_CIDADE);
  pQry.ParamByName('entrega_cep').Value           := IIF(pPedidoVendaModel.ENTREGA_CEP           = '', Unassigned, pPedidoVendaModel.ENTREGA_CEP);
  pQry.ParamByName('entrega_uf').Value            := IIF(pPedidoVendaModel.ENTREGA_UF            = '', Unassigned, pPedidoVendaModel.ENTREGA_UF);
  pQry.ParamByName('entrega_cod_municipio').Value := IIF(pPedidoVendaModel.ENTREGA_COD_MUNICIPIO = '', Unassigned, pPedidoVendaModel.ENTREGA_COD_MUNICIPIO);
  pQry.ParamByName('entrega_telefone').Value      := IIF(pPedidoVendaModel.ENTREGA_TELEFONE      = '', Unassigned, pPedidoVendaModel.ENTREGA_TELEFONE);
  pQry.ParamByName('entrega_celular').Value       := IIF(pPedidoVendaModel.ENTREGA_CELULAR       = '', Unassigned, pPedidoVendaModel.ENTREGA_CELULAR);
  pQry.ParamByName('entrega_observacao').Value    := IIF(pPedidoVendaModel.ENTREGA_OBSERVACAO    = '', Unassigned, pPedidoVendaModel.ENTREGA_OBSERVACAO);
  pQry.ParamByName('entrega_hora').Value          := IIF(pPedidoVendaModel.ENTREGA_HORA          = '', Unassigned, pPedidoVendaModel.ENTREGA_HORA);
  pQry.ParamByName('entrega_contato').Value       := IIF(pPedidoVendaModel.ENTREGA_CONTATO       = '', Unassigned, pPedidoVendaModel.ENTREGA_CONTATO);
  pQry.ParamByName('entrega_agenda_id').Value     := IIF(pPedidoVendaModel.ENTREGA_AGENDA_ID     = '', Unassigned, pPedidoVendaModel.ENTREGA_AGENDA_ID);
  pQry.ParamByName('entrega_regiao_id').Value     := IIF(pPedidoVendaModel.ENTREGA_REGIAO_ID     = '', Unassigned, pPedidoVendaModel.ENTREGA_REGIAO_ID);
  pQry.ParamByName('entregador_id').Value         := IIF(pPedidoVendaModel.ENTREGADOR_ID         = '', Unassigned, pPedidoVendaModel.ENTREGADOR_ID);
  pQry.ParamByName('fatura_id').Value             := IIF(pPedidoVendaModel.FATURA_ID             = '', Unassigned, pPedidoVendaModel.FATURA_ID);
  pQry.ParamByName('datahora_impresso').Value     := IIF(pPedidoVendaModel.DATAHORA_IMPRESSO     = '', Unassigned, pPedidoVendaModel.DATAHORA_IMPRESSO);
  pQry.ParamByName('ctr_impressao_itens').Value   := IIF(pPedidoVendaModel.CTR_IMPRESSAO_ITENS   = '', Unassigned, pPedidoVendaModel.CTR_IMPRESSAO_ITENS);
  pQry.ParamByName('reservado').Value             := IIF(pPedidoVendaModel.RESERVADO             = '', Unassigned, pPedidoVendaModel.RESERVADO);
  pQry.ParamByName('patrimonio_observacao').Value := IIF(pPedidoVendaModel.PATRIMONIO_OBSERVACAO = '', Unassigned, pPedidoVendaModel.PATRIMONIO_OBSERVACAO);
  pQry.ParamByName('obs_geral').Value             := IIF(pPedidoVendaModel.OBS_GERAL             = '', Unassigned, pPedidoVendaModel.OBS_GERAL);
  pQry.ParamByName('sms').Value                   := IIF(pPedidoVendaModel.SMS                   = '', Unassigned, pPedidoVendaModel.SMS);
  pQry.ParamByName('imp_ticket').Value            := IIF(pPedidoVendaModel.IMP_TICKET            = '', Unassigned, pPedidoVendaModel.IMP_TICKET);
  pQry.ParamByName('comanda').Value               := IIF(pPedidoVendaModel.COMANDA               = '', Unassigned, pPedidoVendaModel.COMANDA);
  pQry.ParamByName('valor_taxa_servico').Value    := IIF(pPedidoVendaModel.VALOR_TAXA_SERVICO    = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VALOR_TAXA_SERVICO));
  pQry.ParamByName('vfcpufdest').Value            := IIF(pPedidoVendaModel.VFCPUFDEST            = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VFCPUFDEST));
  pQry.ParamByName('vicmsufdest').Value           := IIF(pPedidoVendaModel.VICMSUFDEST           = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VICMSUFDEST));
  pQry.ParamByName('vicmsufremet').Value          := IIF(pPedidoVendaModel.VICMSUFREMET          = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VICMSUFREMET));
  pQry.ParamByName('entregue').Value              := IIF(pPedidoVendaModel.ENTREGUE              = '', Unassigned, pPedidoVendaModel.ENTREGUE);
  pQry.ParamByName('indicacao_id').Value          := IIF(pPedidoVendaModel.INDICACAO_ID          = '', Unassigned, pPedidoVendaModel.INDICACAO_ID);
  pQry.ParamByName('zerar_st').Value              := IIF(pPedidoVendaModel.ZERAR_ST              = '', Unassigned, pPedidoVendaModel.ZERAR_ST);
  pQry.ParamByName('pedido_vidracaria').Value     := IIF(pPedidoVendaModel.PEDIDO_VIDRACARIA     = '', Unassigned, pPedidoVendaModel.PEDIDO_VIDRACARIA);
  pQry.ParamByName('chave_xml_nf').Value          := IIF(pPedidoVendaModel.CHAVE_XML_NF          = '', Unassigned, pPedidoVendaModel.CHAVE_XML_NF);
  pQry.ParamByName('arquivo_xml_nf').Value        := IIF(pPedidoVendaModel.ARQUIVO_XML_NF        = '', Unassigned, pPedidoVendaModel.ARQUIVO_XML_NF);
  pQry.ParamByName('gerente_id').Value            := IIF(pPedidoVendaModel.GERENTE_ID            = '', Unassigned, pPedidoVendaModel.GERENTE_ID);
  pQry.ParamByName('entrada_portador_id').Value   := IIF(pPedidoVendaModel.ENTRADA_PORTADOR_ID   = '', Unassigned, pPedidoVendaModel.ENTRADA_PORTADOR_ID);
  pQry.ParamByName('data_cotacao').Value          := IIF(pPedidoVendaModel.DATA_COTACAO          = '', Unassigned, transformaDataFireBird(pPedidoVendaModel.DATA_COTACAO));
  pQry.ParamByName('tipo_comissao').Value         := IIF(pPedidoVendaModel.TIPO_COMISSAO         = '', Unassigned, pPedidoVendaModel.TIPO_COMISSAO);
  pQry.ParamByName('gerente_tipo_comissao').Value := IIF(pPedidoVendaModel.GERENTE_TIPO_COMISSAO = '', Unassigned, pPedidoVendaModel.GERENTE_TIPO_COMISSAO);
  pQry.ParamByName('pos_venda').Value             := IIF(pPedidoVendaModel.POS_VENDA             = '', Unassigned, pPedidoVendaModel.POS_VENDA);
  pQry.ParamByName('vlr_garantia').Value          := IIF(pPedidoVendaModel.VLR_GARANTIA          = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VLR_GARANTIA));
  pQry.ParamByName('web_pedido_id').Value         := IIF(pPedidoVendaModel.WEB_PEDIDO_ID         = '', Unassigned, pPedidoVendaModel.WEB_PEDIDO_ID);
  pQry.ParamByName('laca_ou_glass').Value         := IIF(pPedidoVendaModel.LACA_OU_GLASS         = '', Unassigned, pPedidoVendaModel.LACA_OU_GLASS);
  pQry.ParamByName('vfcpst').Value                := IIF(pPedidoVendaModel.VFCPST                = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VFCPST));
  pQry.ParamByName('montagem_data').Value         := IIF(pPedidoVendaModel.MONTAGEM_DATA         = '', Unassigned, transformaDataFireBird(pPedidoVendaModel.MONTAGEM_DATA));
  pQry.ParamByName('montagem_hora').Value         := IIF(pPedidoVendaModel.MONTAGEM_HORA         = '', Unassigned, pPedidoVendaModel.MONTAGEM_HORA);
  pQry.ParamByName('vicmsdeson').Value            := IIF(pPedidoVendaModel.VICMSDESON            = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.VICMSDESON));
  pQry.ParamByName('qtdeitens').Value             := IIF(pPedidoVendaModel.QTDEITENS             = '', Unassigned, FormataFloatFireBird(pPedidoVendaModel.QTDEITENS));
  pQry.ParamByName('ctr_envio_pedido').Value      := IIF(pPedidoVendaModel.CTR_ENVIO_PEDIDO      = '', Unassigned, pPedidoVendaModel.CTR_ENVIO_PEDIDO);
  pQry.ParamByName('ctr_envio_boleto').Value      := IIF(pPedidoVendaModel.CTR_ENVIO_BOLETO      = '', Unassigned, pPedidoVendaModel.CTR_ENVIO_BOLETO);
  pQry.ParamByName('ctr_envio_nfe').Value         := IIF(pPedidoVendaModel.CTR_ENVIO_NFE         = '', Unassigned, pPedidoVendaModel.CTR_ENVIO_NFE);
  pQry.ParamByName('datahora_coleta').Value       := IIF(pPedidoVendaModel.DATAHORA_COLETA       = '', Unassigned, pPedidoVendaModel.DATAHORA_COLETA);
  pQry.ParamByName('datahora_retirada').Value     := IIF(pPedidoVendaModel.DATAHORA_RETIRADA     = '', Unassigned, pPedidoVendaModel.DATAHORA_RETIRADA);
  pQry.ParamByName('cfop_nf').Value               := IIF(pPedidoVendaModel.CFOP_NF               = '', Unassigned, pPedidoVendaModel.CFOP_NF);
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
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select status_ped from pedidovenda where numero_ped = '+ QuotedStr(pId));
end;

end.
