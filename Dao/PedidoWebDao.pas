unit PedidoWebDao;

interface

uses
  PedidoWebModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto;

type
  TPedidoWebDao = class

  private
    FPedidoWebsLista: TObjectList<TPedidoWebModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPedidoWebsLista(const Value: TObjectList<TPedidoWebModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;

    procedure setParams(var pQry: TFDQuery; pPedidoWebModel: TPedidoWebModel);

  public
    constructor Create;
    destructor Destroy; override;

    property PedidoWebsLista: TObjectList<TPedidoWebModel> read FPedidoWebsLista write SetPedidoWebsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function alterar(APedidoWebModel: TPedidoWebModel): String;

    procedure obterListaVendaAssistida;
    function carregaClasse(pId: String): TPedidoWebModel;
end;

implementation

{ TPedidoWeb }

uses VariaveisGlobais;

function TPedidoWebDao.alterar(APedidoWebModel: TPedidoWebModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := xConexao.CriarQuery;

  lSQL := '    update web_pedido                                                             '+SLineBreak+
          '       set loja = :loja,                                                          '+SLineBreak+
          '           datahora = :datahora,                                                  '+SLineBreak+
          '           cliente_id = :cliente_id,                                              '+SLineBreak+
          '           vendedor_id = :vendedor_id,                                            '+SLineBreak+
          '           portador_id = :portador_id,                                            '+SLineBreak+
          '           tipovenda_id = :tipovenda_id,                                          '+SLineBreak+
          '           condicoes_pagamento = :condicoes_pagamento,                            '+SLineBreak+
          '           percentual_desconto = :percentual_desconto,                            '+SLineBreak+
          '           valor_frete = :valor_frete,                                            '+SLineBreak+
          '           valor_st = :valor_st,                                                  '+SLineBreak+
          '           observacao = :observacao,                                              '+SLineBreak+
          '           observacoes = :observacoes,                                            '+SLineBreak+
          '           status = :status,                                                      '+SLineBreak+
          '           substatus = :substatus,                                                '+SLineBreak+
          '           pedido_id = :pedido_id,                                                '+SLineBreak+
          '           origem_pedido = :origem_pedido,                                        '+SLineBreak+
          '           pedido_compra = :pedido_compra,                                        '+SLineBreak+
          '           acrescimo = :acrescimo,                                                '+SLineBreak+
          '           isgift = :isgift,                                                      '+SLineBreak+
          '           valor_total = :valor_total,                                            '+SLineBreak+
          '           codigo_cupom_desconto = :codigo_cupom_desconto,                        '+SLineBreak+
          '           valor_cupom_desconto = :valor_cupom_desconto,                          '+SLineBreak+
          '           dados_adicionais = :dados_adicionais,                                  '+SLineBreak+
          '           controlealteracao = :controlealteracao,                                '+SLineBreak+
          '           usuario = :usuario,                                                    '+SLineBreak+
          '           transportadora_id = :transportadora_id,                                '+SLineBreak+
          '           impressao = :impressao,                                                '+SLineBreak+
          '           idpedidosovis = :idpedidosovis,                                        '+SLineBreak+
          '           correio_volume = :correio_volume,                                      '+SLineBreak+
          '           correio_data = :correio_data,                                          '+SLineBreak+
          '           correio_hora = :correio_hora,                                          '+SLineBreak+
          '           enviar_email = :enviar_email,                                          '+SLineBreak+
          '           transportadora_dados_adicionais = :transportadora_dados_adicionais,    '+SLineBreak+
          '           dados_autorizacao = :dados_autorizacao,                                '+SLineBreak+
          '           parcelas = :parcelas,                                                  '+SLineBreak+
          '           valor_entrada = :valor_entrada,                                        '+SLineBreak+
          '           primeiro_vencimento = :primeiro_vencimento,                            '+SLineBreak+
          '           idpedidosovisusuario = :idpedidosovisusuario,                          '+SLineBreak+
          '           usar_tabela_preco = :usar_tabela_preco,                                '+SLineBreak+
          '           tipo = :tipo,                                                          '+SLineBreak+
          '           data_hora_analise = :data_hora_analise,                                '+SLineBreak+
          '           usuario_analise = :usuario_analise,                                    '+SLineBreak+
          '           data_hora_aprovacao = :data_hora_aprovacao,                            '+SLineBreak+
          '           usuario_aprovacao = :usuario_aprovacao,                                '+SLineBreak+
          '           mensagem_analise = :mensagem_analise,                                  '+SLineBreak+
          '           status_sovis = :status_sovis,                                          '+SLineBreak+
          '           faturar = :faturar,                                                    '+SLineBreak+
          '           caminho_boleto = :caminho_boleto,                                      '+SLineBreak+
          '           caminho_nfe = :caminho_nfe,                                            '+SLineBreak+
          '           uuid_sovis = :uuid_sovis,                                              '+SLineBreak+
          '           entrega_data = :entrega_data,                                          '+SLineBreak+
          '           entrega_hora = :entrega_hora,                                          '+SLineBreak+
          '           montagem_data = :montagem_data,                                        '+SLineBreak+
          '           montagem_hora = :montagem_hora,                                        '+SLineBreak+
          '           usuario_analisando = :usuario_analisando,                              '+SLineBreak+
          '           entrega_endereco = :entrega_endereco,                                  '+SLineBreak+
          '           entrega_complemento = :entrega_complemento,                            '+SLineBreak+
          '           entrega_numero = :entrega_numero,                                      '+SLineBreak+
          '           entrega_bairro = :entrega_bairro,                                      '+SLineBreak+
          '           entrega_cidade = :entrega_cidade,                                      '+SLineBreak+
          '           entrega_uf = :entrega_uf,                                              '+SLineBreak+
          '           entrega_cep = :entrega_cep,                                            '+SLineBreak+
          '           entrega_cod_municipio = :entrega_cod_municipio,                        '+SLineBreak+
          '           pre_analise_status = :pre_analise_status,                              '+SLineBreak+
          '           pre_analise_usuario_id = :pre_analise_usuario_id,                      '+SLineBreak+
          '           pre_analise_datahora = :pre_analise_datahora,                          '+SLineBreak+
          '           period = :period,                                                      '+SLineBreak+
          '           data_hora_reprovado = :data_hora_reprovado,                            '+SLineBreak+
          '           usuario_reprovado = :usuario_reprovado,                                '+SLineBreak+
          '           condicoes2_pag = :condicoes2_pag,                                      '+SLineBreak+
          '           saida_id = :saida_id,                                                  '+SLineBreak+
          '           proposta = :proposta,                                                  '+SLineBreak+
          '           frete_altura = :frete_altura,                                          '+SLineBreak+
          '           frete_profundidade = :frete_profundidade,                              '+SLineBreak+
          '           frete_largura = :frete_largura,                                        '+SLineBreak+
          '           frete_peso = :frete_peso,                                              '+SLineBreak+
          '           frete_valor = :frete_valor,                                            '+SLineBreak+
          '           cupom_desconto = :cupom_desconto,                                      '+SLineBreak+
          '           cupom_tipo = :cupom_tipo,                                              '+SLineBreak+
          '           cupom_valor = :cupom_valor,                                            '+SLineBreak+
          '           marketplace = :marketplace,                                            '+SLineBreak+
          '           regiao_id = :regiao_id,                                                '+SLineBreak+
          '           preco_venda_id = :preco_venda_id,                                      '+SLineBreak+
          '           data_consumo_ominione = :data_consumo_ominione,                        '+SLineBreak+
          '           intermediador_id = :intermediador_id,                                  '+SLineBreak+
          '           lote_exportacao = :lote_exportacao,                                    '+SLineBreak+
          '           data_exportacao = :data_exportacao,                                    '+SLineBreak+
          '           status_analise = :status_analise,                                      '+SLineBreak+
          '           ped_plataforma = :ped_plataforma,                                      '+SLineBreak+
          '           codigo_autorizacao_cartao = :codigo_autorizacao_cartao                 '+SLineBreak+
          '     where (id = :id)                                                             '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := IIF(APedidoWebModel.ID = '', Unassigned, APedidoWebModel.ID);
    setParams(lQry, APedidoWebModel);
    lQry.ExecSQL;

    Result := APedidoWebModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoWebDao.carregaClasse(pId: String): TPedidoWebModel;
var
  lQry: TFDQuery;
  lModel: TPedidoWebModel;
begin
  lQry     := xConexao.CriarQuery;
  lModel   := TPedidoWebModel.Create;
  Result   := lModel;

  try
    lQry.Open('select * from web_pedido where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                              := ZeroLeft(lQry.FieldByName('ID').AsString, 6);
    lModel.LOJA                            := lQry.FieldByName('LOJA').AsString;
    lModel.DATAHORA                        := lQry.FieldByName('DATAHORA').AsString;
    lModel.CLIENTE_ID                      := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.VENDEDOR_ID                     := lQry.FieldByName('VENDEDOR_ID').AsString;
    lModel.PORTADOR_ID                     := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.TIPOVENDA_ID                    := lQry.FieldByName('TIPOVENDA_ID').AsString;
    lModel.CONDICOES_PAGAMENTO             := lQry.FieldByName('CONDICOES_PAGAMENTO').AsString;
    lModel.PERCENTUAL_DESCONTO             := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
    lModel.VALOR_FRETE                     := lQry.FieldByName('VALOR_FRETE').AsString;
    lModel.VALOR_ST                        := lQry.FieldByName('VALOR_ST').AsString;
    lModel.OBSERVACAO                      := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.OBSERVACOES                     := lQry.FieldByName('OBSERVACOES').AsString;
    lModel.STATUS                          := lQry.FieldByName('STATUS').AsString;
    lModel.SUBSTATUS                       := lQry.FieldByName('SUBSTATUS').AsString;
    lModel.PEDIDO_ID                       := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.ORIGEM_PEDIDO                   := lQry.FieldByName('ORIGEM_PEDIDO').AsString;
    lModel.PEDIDO_COMPRA                   := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.ACRESCIMO                       := lQry.FieldByName('ACRESCIMO').AsString;
    lModel.ISGIFT                          := lQry.FieldByName('ISGIFT').AsString;
    lModel.VALOR_TOTAL                     := lQry.FieldByName('VALOR_TOTAL').AsString;
    lModel.CODIGO_CUPOM_DESCONTO           := lQry.FieldByName('CODIGO_CUPOM_DESCONTO').AsString;
    lModel.VALOR_CUPOM_DESCONTO            := lQry.FieldByName('VALOR_CUPOM_DESCONTO').AsString;
    lModel.DADOS_ADICIONAIS                := lQry.FieldByName('DADOS_ADICIONAIS').AsString;
    lModel.DATA                            := lQry.FieldByName('DATA').AsString;
    lModel.CONTROLEALTERACAO               := lQry.FieldByName('CONTROLEALTERACAO').AsString;
    lModel.USUARIO                         := lQry.FieldByName('USUARIO').AsString;
    lModel.TRANSPORTADORA_ID               := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.EVENTO                          := lQry.FieldByName('EVENTO').AsString;
    lModel.IMPRESSAO                       := lQry.FieldByName('IMPRESSAO').AsString;
    lModel.IDPEDIDOSOVIS                   := lQry.FieldByName('IDPEDIDOSOVIS').AsString;
    lModel.CORREIO_VOLUME                  := lQry.FieldByName('CORREIO_VOLUME').AsString;
    lModel.CORREIO_DATA                    := lQry.FieldByName('CORREIO_DATA').AsString;
    lModel.CORREIO_HORA                    := lQry.FieldByName('CORREIO_HORA').AsString;
    lModel.ENVIAR_EMAIL                    := lQry.FieldByName('ENVIAR_EMAIL').AsString;
    lModel.TRANSPORTADORA_DADOS_ADICIONAIS := lQry.FieldByName('TRANSPORTADORA_DADOS_ADICIONAIS').AsString;
    lModel.DADOS_AUTORIZACAO               := lQry.FieldByName('DADOS_AUTORIZACAO').AsString;
    lModel.PARCELAS                        := lQry.FieldByName('PARCELAS').AsString;
    lModel.VALOR_ENTRADA                   := lQry.FieldByName('VALOR_ENTRADA').AsString;
    lModel.PRIMEIRO_VENCIMENTO             := lQry.FieldByName('PRIMEIRO_VENCIMENTO').AsString;
    lModel.IDPEDIDOSOVISUSUARIO            := lQry.FieldByName('IDPEDIDOSOVISUSUARIO').AsString;
    lModel.USAR_TABELA_PRECO               := lQry.FieldByName('USAR_TABELA_PRECO').AsString;
    lModel.TIPO                            := lQry.FieldByName('TIPO').AsString;
    lModel.DATA_HORA_ANALISE               := lQry.FieldByName('DATA_HORA_ANALISE').AsString;
    lModel.USUARIO_ANALISE                 := lQry.FieldByName('USUARIO_ANALISE').AsString;
    lModel.DATA_HORA_APROVACAO             := lQry.FieldByName('DATA_HORA_APROVACAO').AsString;
    lModel.USUARIO_APROVACAO               := lQry.FieldByName('USUARIO_APROVACAO').AsString;
    lModel.MENSAGEM_ANALISE                := lQry.FieldByName('MENSAGEM_ANALISE').AsString;
    lModel.STATUS_SOVIS                    := lQry.FieldByName('STATUS_SOVIS').AsString;
    lModel.FATURAR                         := lQry.FieldByName('FATURAR').AsString;
    lModel.CAMINHO_BOLETO                  := lQry.FieldByName('CAMINHO_BOLETO').AsString;
    lModel.CAMINHO_NFE                     := lQry.FieldByName('CAMINHO_NFE').AsString;
    lModel.UUID_SOVIS                      := lQry.FieldByName('UUID_SOVIS').AsString;
    lModel.ENTREGA_DATA                    := lQry.FieldByName('ENTREGA_DATA').AsString;
    lModel.ENTREGA_HORA                    := lQry.FieldByName('ENTREGA_HORA').AsString;
    lModel.MONTAGEM_DATA                   := lQry.FieldByName('MONTAGEM_DATA').AsString;
    lModel.MONTAGEM_HORA                   := lQry.FieldByName('MONTAGEM_HORA').AsString;
    lModel.USUARIO_ANALISANDO              := lQry.FieldByName('USUARIO_ANALISANDO').AsString;
    lModel.ENTREGA_ENDERECO                := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
    lModel.ENTREGA_COMPLEMENTO             := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
    lModel.ENTREGA_NUMERO                  := lQry.FieldByName('ENTREGA_NUMERO').AsString;
    lModel.ENTREGA_BAIRRO                  := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
    lModel.ENTREGA_CIDADE                  := lQry.FieldByName('ENTREGA_CIDADE').AsString;
    lModel.ENTREGA_UF                      := lQry.FieldByName('ENTREGA_UF').AsString;
    lModel.ENTREGA_CEP                     := lQry.FieldByName('ENTREGA_CEP').AsString;
    lModel.ENTREGA_COD_MUNICIPIO           := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
    lModel.PRE_ANALISE_STATUS              := lQry.FieldByName('PRE_ANALISE_STATUS').AsString;
    lModel.PRE_ANALISE_USUARIO_ID          := lQry.FieldByName('PRE_ANALISE_USUARIO_ID').AsString;
    lModel.PRE_ANALISE_DATAHORA            := lQry.FieldByName('PRE_ANALISE_DATAHORA').AsString;
    lModel.PERIOD                          := lQry.FieldByName('PERIOD').AsString;
    lModel.SYSTIME                         := lQry.FieldByName('SYSTIME').AsString;
    lModel.DATA_HORA_REPROVADO             := lQry.FieldByName('DATA_HORA_REPROVADO').AsString;
    lModel.USUARIO_REPROVADO               := lQry.FieldByName('USUARIO_REPROVADO').AsString;
    lModel.CONDICOES2_PAG                  := lQry.FieldByName('CONDICOES2_PAG').AsString;
    lModel.SAIDA_ID                        := lQry.FieldByName('SAIDA_ID').AsString;
    lModel.PROPOSTA                        := lQry.FieldByName('PROPOSTA').AsString;
    lModel.FRETE_ALTURA                    := lQry.FieldByName('FRETE_ALTURA').AsString;
    lModel.FRETE_PROFUNDIDADE              := lQry.FieldByName('FRETE_PROFUNDIDADE').AsString;
    lModel.FRETE_LARGURA                   := lQry.FieldByName('FRETE_LARGURA').AsString;
    lModel.FRETE_PESO                      := lQry.FieldByName('FRETE_PESO').AsString;
    lModel.FRETE_VALOR                     := lQry.FieldByName('FRETE_VALOR').AsString;
    lModel.CUPOM_DESCONTO                  := lQry.FieldByName('CUPOM_DESCONTO').AsString;
    lModel.CUPOM_TIPO                      := lQry.FieldByName('CUPOM_TIPO').AsString;
    lModel.CUPOM_VALOR                     := lQry.FieldByName('CUPOM_VALOR').AsString;
    lModel.MARKETPLACE                     := lQry.FieldByName('MARKETPLACE').AsString;
    lModel.REGIAO_ID                       := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.PRECO_VENDA_ID                  := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.DATA_CONSUMO_OMINIONE           := lQry.FieldByName('DATA_CONSUMO_OMINIONE').AsString;
    lModel.INTERMEDIADOR_ID                := lQry.FieldByName('INTERMEDIADOR_ID').AsString;
    lModel.LOTE_EXPORTACAO                 := lQry.FieldByName('LOTE_EXPORTACAO').AsString;
    lModel.DATA_EXPORTACAO                 := lQry.FieldByName('DATA_EXPORTACAO').AsString;
    lModel.STATUS_ANALISE                  := lQry.FieldByName('STATUS_ANALISE').AsString;
    lModel.PED_PLATAFORMA                  := lQry.FieldByName('PED_PLATAFORMA').AsString;
    lModel.CODIGO_AUTORIZACAO_CARTAO       := lQry.FieldByName('CODIGO_AUTORIZACAO_CARTAO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPedidoWebDao.Create;
begin

end;

destructor TPedidoWebDao.Destroy;
begin

  inherited;
end;

function TPedidoWebDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and web_pedido.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TPedidoWebDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := xConexao.CriarQuery;

    lSql := 'select count(*) records From web_pedido where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPedidoWebDao.obterListaVendaAssistida;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := xConexao.CriarQuery;

  FPedidoWebsLista := TObjectList<TPedidoWebModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSQL := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSQL := 'select ';

    lSQL := lSQL +
      '  web_pedido.id,                                                                                                                                   '+SLineBreak+
      '  coalesce(clientes.fantasia_cli, clientes.razao_cli) cliente_nome,                                                                                '+SLineBreak+
      '  web_pedido.valor_frete,                                                                                                                          '+SLineBreak+
      '  coalesce(web_pedido.acrescimo,0) acrescimo,                                                                                                      '+SLineBreak+
      '  coalesce((select sum(i.quantidade * i.valor_unitario) from web_pedidoitens i where i.web_pedido_id = web_pedido.id),0) valor_itens,              '+SLineBreak+
      '  coalesce((select sum(i.quantidade * coalesce(i.vlr_garantia,0)) from web_pedidoitens i where i.web_pedido_id = web_pedido.id),0) valor_garantia, '+SLineBreak+

      '  coalesce(cast(( select sum(i.quantidade * (i.valor_unitario + coalesce(i.vlr_garantia,0)))                                                       '+SLineBreak+
      '                    from web_pedidoitens i                                                                                                         '+SLineBreak+
      '                   where i.web_pedido_id = web_pedido.id) as decimal(18,6)),0)                                                                     '+SLineBreak+
      '    - coalesce(web_pedido.valor_cupom_desconto,0)                                                                                                  '+SLineBreak+
      '    + coalesce(web_pedido.acrescimo,0)                                                                                                             '+SLineBreak+
      '    + coalesce(web_pedido.valor_frete,0) valor_total,                                                                                              '+SLineBreak+

      '  coalesce(web_pedido.valor_cupom_desconto,0) valor_cupom_desconto                                                                                 '+SLineBreak+
      ' from web_pedido inner join clientes on web_pedido.cliente_id = clientes.codigo_cli                                                                '+SLineBreak+
      ' where 1=1 ';

    lSQL := lSQL + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPedidoWebsLista.Add(TPedidoWebModel.Create);

      i := FPedidoWebsLista.Count -1;

      FPedidoWebsLista[i].ID                   := lQry.FieldByName('ID').AsString;
      FPedidoWebsLista[i].CLIENTE_NOME         := lQry.FieldByName('CLIENTE_NOME').AsString;
      FPedidoWebsLista[i].VALOR_FRETE          := lQry.FieldByName('VALOR_FRETE').AsString;
      FPedidoWebsLista[i].ACRESCIMO            := lQry.FieldByName('ACRESCIMO').AsString;
      FPedidoWebsLista[i].VALOR_ITENS          := lQry.FieldByName('VALOR_ITENS').AsString;
      FPedidoWebsLista[i].VALOR_GARANTIA       := lQry.FieldByName('VALOR_GARANTIA').AsString;
      FPedidoWebsLista[i].VALOR_TOTAL          := lQry.FieldByName('VALOR_TOTAL').AsString;
      FPedidoWebsLista[i].VALOR_CUPOM_DESCONTO := lQry.FieldByName('VALOR_CUPOM_DESCONTO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPedidoWebDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoWebDao.SetPedidoWebsLista(const Value: TObjectList<TPedidoWebModel>);
begin
  FPedidoWebsLista := Value;
end;

procedure TPedidoWebDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPedidoWebDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPedidoWebDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoWebDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoWebDao.setParams(var pQry: TFDQuery; pPedidoWebModel: TPedidoWebModel);
begin
  pQry.ParamByName('loja').Value                              := IIF(pPedidoWebModel.LOJA                            = '', Unassigned, pPedidoWebModel.LOJA);
  pQry.ParamByName('datahora').Value                          := IIF(pPedidoWebModel.DATAHORA                        = '', Unassigned, transformaDataHoraFireBird(pPedidoWebModel.DATAHORA));
  pQry.ParamByName('cliente_id').Value                        := IIF(pPedidoWebModel.CLIENTE_ID                      = '', Unassigned, pPedidoWebModel.CLIENTE_ID);
  pQry.ParamByName('vendedor_id').Value                       := IIF(pPedidoWebModel.VENDEDOR_ID                     = '', Unassigned, pPedidoWebModel.VENDEDOR_ID);
  pQry.ParamByName('portador_id').Value                       := IIF(pPedidoWebModel.PORTADOR_ID                     = '', Unassigned, pPedidoWebModel.PORTADOR_ID);
  pQry.ParamByName('tipovenda_id').Value                      := IIF(pPedidoWebModel.TIPOVENDA_ID                    = '', Unassigned, pPedidoWebModel.TIPOVENDA_ID);
  pQry.ParamByName('condicoes_pagamento').Value               := IIF(pPedidoWebModel.CONDICOES_PAGAMENTO             = '', Unassigned, pPedidoWebModel.CONDICOES_PAGAMENTO);
  pQry.ParamByName('percentual_desconto').Value               := IIF(pPedidoWebModel.PERCENTUAL_DESCONTO             = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.PERCENTUAL_DESCONTO));
  pQry.ParamByName('valor_frete').Value                       := IIF(pPedidoWebModel.VALOR_FRETE                     = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.VALOR_FRETE));
  pQry.ParamByName('valor_st').Value                          := IIF(pPedidoWebModel.VALOR_ST                        = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.VALOR_ST));
  pQry.ParamByName('observacao').Value                        := IIF(pPedidoWebModel.OBSERVACAO                      = '', Unassigned, pPedidoWebModel.OBSERVACAO);
  pQry.ParamByName('observacoes').Value                       := IIF(pPedidoWebModel.OBSERVACOES                     = '', Unassigned, pPedidoWebModel.OBSERVACOES);
  pQry.ParamByName('status').Value                            := IIF(pPedidoWebModel.STATUS                          = '', Unassigned, pPedidoWebModel.STATUS);
  pQry.ParamByName('substatus').Value                         := IIF(pPedidoWebModel.SUBSTATUS                       = '', Unassigned, pPedidoWebModel.SUBSTATUS);
  pQry.ParamByName('pedido_id').Value                         := IIF(pPedidoWebModel.PEDIDO_ID                       = '', Unassigned, pPedidoWebModel.PEDIDO_ID);
  pQry.ParamByName('origem_pedido').Value                     := IIF(pPedidoWebModel.ORIGEM_PEDIDO                   = '', Unassigned, pPedidoWebModel.ORIGEM_PEDIDO);
  pQry.ParamByName('pedido_compra').Value                     := IIF(pPedidoWebModel.PEDIDO_COMPRA                   = '', Unassigned, pPedidoWebModel.PEDIDO_COMPRA);
  pQry.ParamByName('acrescimo').Value                         := IIF(pPedidoWebModel.ACRESCIMO                       = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.ACRESCIMO));
  pQry.ParamByName('isgift').Value                            := IIF(pPedidoWebModel.ISGIFT                          = '', Unassigned, pPedidoWebModel.ISGIFT);
  pQry.ParamByName('valor_total').Value                       := IIF(pPedidoWebModel.VALOR_TOTAL                     = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.VALOR_TOTAL));
  pQry.ParamByName('codigo_cupom_desconto').Value             := IIF(pPedidoWebModel.CODIGO_CUPOM_DESCONTO           = '', Unassigned, pPedidoWebModel.CODIGO_CUPOM_DESCONTO);
  pQry.ParamByName('valor_cupom_desconto').Value              := IIF(pPedidoWebModel.VALOR_CUPOM_DESCONTO            = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.VALOR_CUPOM_DESCONTO));
  pQry.ParamByName('dados_adicionais').Value                  := IIF(pPedidoWebModel.DADOS_ADICIONAIS                = '', Unassigned, pPedidoWebModel.DADOS_ADICIONAIS);
  pQry.ParamByName('controlealteracao').Value                 := IIF(pPedidoWebModel.CONTROLEALTERACAO               = '', Unassigned, pPedidoWebModel.CONTROLEALTERACAO);
  pQry.ParamByName('usuario').Value                           := IIF(pPedidoWebModel.USUARIO                         = '', Unassigned, pPedidoWebModel.USUARIO);
  pQry.ParamByName('transportadora_id').Value                 := IIF(pPedidoWebModel.TRANSPORTADORA_ID               = '', Unassigned, pPedidoWebModel.TRANSPORTADORA_ID);
  pQry.ParamByName('impressao').Value                         := IIF(pPedidoWebModel.IMPRESSAO                       = '', Unassigned, pPedidoWebModel.IMPRESSAO);
  pQry.ParamByName('idpedidosovis').Value                     := IIF(pPedidoWebModel.IDPEDIDOSOVIS                   = '', Unassigned, pPedidoWebModel.IDPEDIDOSOVIS);
  pQry.ParamByName('correio_volume').Value                    := IIF(pPedidoWebModel.CORREIO_VOLUME                  = '', Unassigned, pPedidoWebModel.CORREIO_VOLUME);
  pQry.ParamByName('correio_data').Value                      := IIF(pPedidoWebModel.CORREIO_DATA                    = '', Unassigned, transformaDataFireBird(pPedidoWebModel.CORREIO_DATA));
  pQry.ParamByName('correio_hora').Value                      := IIF(pPedidoWebModel.CORREIO_HORA                    = '', Unassigned, pPedidoWebModel.CORREIO_HORA);
  pQry.ParamByName('enviar_email').Value                      := IIF(pPedidoWebModel.ENVIAR_EMAIL                    = '', Unassigned, pPedidoWebModel.ENVIAR_EMAIL);
  pQry.ParamByName('transportadora_dados_adicionais').Value   := IIF(pPedidoWebModel.TRANSPORTADORA_DADOS_ADICIONAIS = '', Unassigned, pPedidoWebModel.TRANSPORTADORA_DADOS_ADICIONAIS);
  pQry.ParamByName('dados_autorizacao').Value                 := IIF(pPedidoWebModel.DADOS_AUTORIZACAO               = '', Unassigned, pPedidoWebModel.DADOS_AUTORIZACAO);
  pQry.ParamByName('parcelas').Value                          := IIF(pPedidoWebModel.PARCELAS                        = '', Unassigned, pPedidoWebModel.PARCELAS);
  pQry.ParamByName('valor_entrada').Value                     := IIF(pPedidoWebModel.VALOR_ENTRADA                   = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.VALOR_ENTRADA));
  pQry.ParamByName('primeiro_vencimento').Value               := IIF(pPedidoWebModel.PRIMEIRO_VENCIMENTO             = '', Unassigned, transformaDataFireBird(pPedidoWebModel.PRIMEIRO_VENCIMENTO));
  pQry.ParamByName('idpedidosovisusuario').Value              := IIF(pPedidoWebModel.IDPEDIDOSOVISUSUARIO            = '', Unassigned, pPedidoWebModel.IDPEDIDOSOVISUSUARIO);
  pQry.ParamByName('usar_tabela_preco').Value                 := IIF(pPedidoWebModel.USAR_TABELA_PRECO               = '', Unassigned, pPedidoWebModel.USAR_TABELA_PRECO);
  pQry.ParamByName('tipo').Value                              := IIF(pPedidoWebModel.TIPO                            = '', Unassigned, pPedidoWebModel.TIPO);
  pQry.ParamByName('data_hora_analise').Value                 := IIF(pPedidoWebModel.DATA_HORA_ANALISE               = '', Unassigned, transformaDataHoraFireBird(pPedidoWebModel.DATA_HORA_ANALISE));
  pQry.ParamByName('usuario_analise').Value                   := IIF(pPedidoWebModel.USUARIO_ANALISE                 = '', Unassigned, pPedidoWebModel.USUARIO_ANALISE);
  pQry.ParamByName('data_hora_aprovacao').Value               := IIF(pPedidoWebModel.DATA_HORA_APROVACAO             = '', Unassigned, transformaDataHoraFireBird(pPedidoWebModel.DATA_HORA_APROVACAO));
  pQry.ParamByName('usuario_aprovacao').Value                 := IIF(pPedidoWebModel.USUARIO_APROVACAO               = '', Unassigned, pPedidoWebModel.USUARIO_APROVACAO);
  pQry.ParamByName('mensagem_analise').Value                  := IIF(pPedidoWebModel.MENSAGEM_ANALISE                = '', Unassigned, pPedidoWebModel.MENSAGEM_ANALISE);
  pQry.ParamByName('status_sovis').Value                      := IIF(pPedidoWebModel.STATUS_SOVIS                    = '', Unassigned, pPedidoWebModel.STATUS_SOVIS);
  pQry.ParamByName('faturar').Value                           := IIF(pPedidoWebModel.FATURAR                         = '', Unassigned, pPedidoWebModel.FATURAR);
  pQry.ParamByName('caminho_boleto').Value                    := IIF(pPedidoWebModel.CAMINHO_BOLETO                  = '', Unassigned, pPedidoWebModel.CAMINHO_BOLETO);
  pQry.ParamByName('caminho_nfe').Value                       := IIF(pPedidoWebModel.CAMINHO_NFE                     = '', Unassigned, pPedidoWebModel.CAMINHO_NFE);
  pQry.ParamByName('uuid_sovis').Value                        := IIF(pPedidoWebModel.UUID_SOVIS                      = '', Unassigned, pPedidoWebModel.UUID_SOVIS);
  pQry.ParamByName('entrega_data').Value                      := IIF(pPedidoWebModel.ENTREGA_DATA                    = '', Unassigned, pPedidoWebModel.ENTREGA_DATA);
  pQry.ParamByName('entrega_hora').Value                      := IIF(pPedidoWebModel.ENTREGA_HORA                    = '', Unassigned, pPedidoWebModel.ENTREGA_HORA);
  pQry.ParamByName('montagem_data').Value                     := IIF(pPedidoWebModel.MONTAGEM_DATA                   = '', Unassigned, transformaDataFireBird(pPedidoWebModel.MONTAGEM_DATA));
  pQry.ParamByName('montagem_hora').Value                     := IIF(pPedidoWebModel.MONTAGEM_HORA                   = '', Unassigned, pPedidoWebModel.MONTAGEM_HORA);
  pQry.ParamByName('usuario_analisando').Value                := IIF(pPedidoWebModel.USUARIO_ANALISANDO              = '', Unassigned, pPedidoWebModel.USUARIO_ANALISANDO);
  pQry.ParamByName('entrega_endereco').Value                  := IIF(pPedidoWebModel.ENTREGA_ENDERECO                = '', Unassigned, pPedidoWebModel.ENTREGA_ENDERECO);
  pQry.ParamByName('entrega_complemento').Value               := IIF(pPedidoWebModel.ENTREGA_COMPLEMENTO             = '', Unassigned, pPedidoWebModel.ENTREGA_COMPLEMENTO);
  pQry.ParamByName('entrega_numero').Value                    := IIF(pPedidoWebModel.ENTREGA_NUMERO                  = '', Unassigned, pPedidoWebModel.ENTREGA_NUMERO);
  pQry.ParamByName('entrega_bairro').Value                    := IIF(pPedidoWebModel.ENTREGA_BAIRRO                  = '', Unassigned, pPedidoWebModel.ENTREGA_BAIRRO);
  pQry.ParamByName('entrega_cidade').Value                    := IIF(pPedidoWebModel.ENTREGA_CIDADE                  = '', Unassigned, pPedidoWebModel.ENTREGA_CIDADE);
  pQry.ParamByName('entrega_uf').Value                        := IIF(pPedidoWebModel.ENTREGA_UF                      = '', Unassigned, pPedidoWebModel.ENTREGA_UF);
  pQry.ParamByName('entrega_cep').Value                       := IIF(pPedidoWebModel.ENTREGA_CEP                     = '', Unassigned, pPedidoWebModel.ENTREGA_CEP);
  pQry.ParamByName('entrega_cod_municipio').Value             := IIF(pPedidoWebModel.ENTREGA_COD_MUNICIPIO           = '', Unassigned, pPedidoWebModel.ENTREGA_COD_MUNICIPIO);
  pQry.ParamByName('pre_analise_status').Value                := IIF(pPedidoWebModel.PRE_ANALISE_STATUS              = '', Unassigned, pPedidoWebModel.PRE_ANALISE_STATUS);
  pQry.ParamByName('pre_analise_usuario_id').Value            := IIF(pPedidoWebModel.PRE_ANALISE_USUARIO_ID          = '', Unassigned, pPedidoWebModel.PRE_ANALISE_USUARIO_ID);
  pQry.ParamByName('pre_analise_datahora').Value              := IIF(pPedidoWebModel.PRE_ANALISE_DATAHORA            = '', Unassigned, transformaDataHoraFireBird(pPedidoWebModel.PRE_ANALISE_DATAHORA));
  pQry.ParamByName('period').Value                            := IIF(pPedidoWebModel.PERIOD                          = '', Unassigned, pPedidoWebModel.PERIOD);
  pQry.ParamByName('data_hora_reprovado').Value               := IIF(pPedidoWebModel.DATA_HORA_REPROVADO             = '', Unassigned, transformaDataHoraFireBird(pPedidoWebModel.DATA_HORA_REPROVADO));
  pQry.ParamByName('usuario_reprovado').Value                 := IIF(pPedidoWebModel.USUARIO_REPROVADO               = '', Unassigned, pPedidoWebModel.USUARIO_REPROVADO);
  pQry.ParamByName('condicoes2_pag').Value                    := IIF(pPedidoWebModel.CONDICOES2_PAG                  = '', Unassigned, pPedidoWebModel.CONDICOES2_PAG);
  pQry.ParamByName('saida_id').Value                          := IIF(pPedidoWebModel.SAIDA_ID                        = '', Unassigned, pPedidoWebModel.SAIDA_ID);
  pQry.ParamByName('proposta').Value                          := IIF(pPedidoWebModel.PROPOSTA                        = '', Unassigned, pPedidoWebModel.PROPOSTA);
  pQry.ParamByName('frete_altura').Value                      := IIF(pPedidoWebModel.FRETE_ALTURA                    = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.FRETE_ALTURA));
  pQry.ParamByName('frete_profundidade').Value                := IIF(pPedidoWebModel.FRETE_PROFUNDIDADE              = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.FRETE_PROFUNDIDADE));
  pQry.ParamByName('frete_largura').Value                     := IIF(pPedidoWebModel.FRETE_LARGURA                   = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.FRETE_LARGURA));
  pQry.ParamByName('frete_peso').Value                        := IIF(pPedidoWebModel.FRETE_PESO                      = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.FRETE_PESO));
  pQry.ParamByName('frete_valor').Value                       := IIF(pPedidoWebModel.FRETE_VALOR                     = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.FRETE_VALOR));
  pQry.ParamByName('cupom_desconto').Value                    := IIF(pPedidoWebModel.CUPOM_DESCONTO                  = '', Unassigned, pPedidoWebModel.CUPOM_DESCONTO);
  pQry.ParamByName('cupom_tipo').Value                        := IIF(pPedidoWebModel.CUPOM_TIPO                      = '', Unassigned, pPedidoWebModel.CUPOM_TIPO);
  pQry.ParamByName('cupom_valor').Value                       := IIF(pPedidoWebModel.CUPOM_VALOR                     = '', Unassigned, FormataFloatFireBird(pPedidoWebModel.CUPOM_VALOR));
  pQry.ParamByName('marketplace').Value                       := IIF(pPedidoWebModel.MARKETPLACE                     = '', Unassigned, pPedidoWebModel.MARKETPLACE);
  pQry.ParamByName('regiao_id').Value                         := IIF(pPedidoWebModel.REGIAO_ID                       = '', Unassigned, pPedidoWebModel.REGIAO_ID);
  pQry.ParamByName('preco_venda_id').Value                    := IIF(pPedidoWebModel.PRECO_VENDA_ID                  = '', Unassigned, pPedidoWebModel.PRECO_VENDA_ID);
  pQry.ParamByName('data_consumo_ominione').Value             := IIF(pPedidoWebModel.DATA_CONSUMO_OMINIONE           = '', Unassigned, transformaDataHoraFireBird(pPedidoWebModel.DATA_CONSUMO_OMINIONE));
  pQry.ParamByName('intermediador_id').Value                  := IIF(pPedidoWebModel.INTERMEDIADOR_ID                = '', Unassigned, pPedidoWebModel.INTERMEDIADOR_ID);
  pQry.ParamByName('lote_exportacao').Value                   := IIF(pPedidoWebModel.LOTE_EXPORTACAO                 = '', Unassigned, pPedidoWebModel.LOTE_EXPORTACAO);
  pQry.ParamByName('data_exportacao').Value                   := IIF(pPedidoWebModel.DATA_EXPORTACAO                 = '', Unassigned, transformaDataFireBird(pPedidoWebModel.DATA_EXPORTACAO));
  pQry.ParamByName('status_analise').Value                    := IIF(pPedidoWebModel.STATUS_ANALISE                  = '', Unassigned, pPedidoWebModel.STATUS_ANALISE);
  pQry.ParamByName('ped_plataforma').Value                    := IIF(pPedidoWebModel.PED_PLATAFORMA                  = '', Unassigned, pPedidoWebModel.PED_PLATAFORMA);
  pQry.ParamByName('codigo_autorizacao_cartao').Value         := IIF(pPedidoWebModel.CODIGO_AUTORIZACAO_CARTAO       = '', Unassigned, pPedidoWebModel.CODIGO_AUTORIZACAO_CARTAO);
end;

procedure TPedidoWebDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPedidoWebDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPedidoWebDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
