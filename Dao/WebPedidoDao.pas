unit WebPedidoDao;

interface

uses
  WebPedidoModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TWebPedidoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FWebPedidosLista: TObjectList<TWebPedidoModel>;
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
    procedure SetWebPedidosLista(const Value: TObjectList<TWebPedidoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

    procedure setParams(var pQry: TFDQuery; pWebPedidoModel: TWebPedidoModel);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property WebPedidosLista: TObjectList<TWebPedidoModel> read FWebPedidosLista write SetWebPedidosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pWebPedidoModel: TWebPedidoModel): String;
    function alterar(pWebPedidoModel: TWebPedidoModel): String;
    function excluir(pWebPedidoModel: TWebPedidoModel): String;

    function obterLista: TFDMemTable;
    function carregaClasse(pId: String): TWebPedidoModel;
end;

implementation

uses
  System.Rtti;

{ TWebPedido }

function TWebPedidoDao.alterar(pWebPedidoModel: TWebPedidoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('WEB_PEDIDO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pWebPedidoModel);
    lQry.ExecSQL;

    Result := pWebPedidoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TWebPedidoDao.carregaClasse(pId: String): TWebPedidoModel;
var
  lQry: TFDQuery;
  lModel: TWebPedidoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TWebPedidoModel.Create(vIConexao);
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

constructor TWebPedidoDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TWebPedidoDao.Destroy;
begin

  inherited;
end;

function TWebPedidoDao.excluir(pWebPedidoModel: TWebPedidoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from WEB_PEDIDO where ID = :ID',[pWebPedidoModel.ID]);
   lQry.ExecSQL;
   Result := pWebPedidoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TWebPedidoDao.incluir(pWebPedidoModel: TWebPedidoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('WEB_PEDIDO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pWebPedidoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TWebPedidoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TWebPedidoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From web_pedido where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TWebPedidoDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  i          : Integer;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  FWebPedidosLista := TObjectList<TWebPedidoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := 'first ' + LengthPageView + ' SKIP ' + StartRecordView;


    lSQL := '    select  '+lPaginacao+'                                                                                                     '+SLineBreak+
            '        ID,                                                                                                                    '+SLineBreak+
            '        CODIGO_CLI,                                                                                                            '+SLineBreak+
            '        CLIENTE_NOME,                                                                                                          '+SLineBreak+
            '        ENTREGA_ENDERECO,                                                                                                      '+SLineBreak+
            '        ENTREGA_NUMERO,                                                                                                        '+SLineBreak+
            '        ENTREGA_COD_MUNICIPIO,                                                                                                 '+SLineBreak+
            '        ENTREGA_CEP,                                                                                                           '+SLineBreak+
            '        ENTREGA_COMPLEMENTO,                                                                                                   '+SLineBreak+
            '        ENTREGA_CIDADE,                                                                                                        '+SLineBreak+
            '        ENTREGA_BAIRRO,                                                                                                        '+SLineBreak+
            '        ENTREGA_UF,                                                                                                            '+SLineBreak+
            '        MONTAGEM_DATA,                                                                                                         '+SLineBreak+
            '        MONTAGEM_HORA,                                                                                                         '+SLineBreak+
            '        ENTREGA_DATA,                                                                                                          '+SLineBreak+
            '        ENTREGA_HORA,                                                                                                          '+SLineBreak+
            '        REGIAO,                                                                                                                '+SLineBreak+
            '        VALOR_FRETE,                                                                                                           '+SLineBreak+
            '        ACRESCIMO,                                                                                                             '+SLineBreak+
            '        VALOR_ITENS,                                                                                                           '+SLineBreak+
            '        VALOR_GARANTIA,                                                                                                        '+SLineBreak+
            '        VALOR_CUPOM_DESCONTO,                                                                                                  '+SLineBreak+
            '        VALOR_TOTAL                                                                                                            '+SLineBreak+
			      '                                                                                                                               '+SLineBreak+
            '    from (                                                                                                                     '+SLineBreak+
            '                                                                                                                               '+SLineBreak+
            '    			select                                                                                                                '+SLineBreak+
            '    				id,                                                                                                                 '+SLineBreak+
            '    				codigo_cli,                                                                                                         '+SLineBreak+
            '    				cliente_nome,                                                                                                       '+SLineBreak+
            '    				entrega_endereco,                                                                                                   '+SLineBreak+
            '    				entrega_numero,                                                                                                     '+SLineBreak+
            '    				entrega_cod_municipio,                                                                                              '+SLineBreak+
            '    				entrega_cep,                                                                                                        '+SLineBreak+
            '    				entrega_complemento,                                                                                                '+SLineBreak+
            '    				entrega_cidade,                                                                                                     '+SLineBreak+
            '    				entrega_bairro,                                                                                                     '+SLineBreak+
            '    				entrega_uf,                                                                                                         '+SLineBreak+
            '    				montagem_data,                                                                                                      '+SLineBreak+
            '    				montagem_hora,                                                                                                      '+SLineBreak+
            '    				entrega_data,                                                                                                       '+SLineBreak+
            '    				entrega_hora,                                                                                                       '+SLineBreak+
            '    				regiao,                                                                                                             '+SLineBreak+
            '    				sum(valor_frete) valor_frete,                                                                                       '+SLineBreak+
            '    				sum(acrescimo) acrescimo,                                                                                           '+SLineBreak+
            '    				sum(valor_itens) valor_itens,                                                                                       '+SLineBreak+
            '    				sum(valor_garantia) valor_garantia,                                                                                 '+SLineBreak+
            '    				sum(valor_cupom_desconto) valor_cupom_desconto,                                                                     '+SLineBreak+
            '    				sum(valor_itens) + sum(valor_frete) + sum(valor_garantia) + sum(acrescimo) - sum(valor_cupom_desconto) valor_total  '+SLineBreak+
            '                                                                                                                               '+SLineBreak+
            '      		from (                                                                                                                '+SLineBreak+
            '																												                                                                        '+SLineBreak+
            '      			  select web_pedido.id,                                                                                             '+SLineBreak+
            '      					 clientes.codigo_cli,                                                                                           '+SLineBreak+
            '      					 coalesce(clientes.fantasia_cli, clientes.razao_cli) cliente_nome,                                              '+SLineBreak+
            '      					 web_pedido.entrega_endereco,                                                                                   '+SLineBreak+
            '      					 web_pedido.entrega_numero,                                                                                     '+SLineBreak+
            '      					 web_pedido.entrega_cod_municipio,                                                                              '+SLineBreak+
            '      					 web_pedido.entrega_cep,                                                                                        '+SLineBreak+
            '      					 web_pedido.entrega_complemento,                                                                                '+SLineBreak+
            '      					 web_pedido.entrega_cidade,                                                                                     '+SLineBreak+
            '      					 web_pedido.entrega_bairro,                                                                                     '+SLineBreak+
            '      					 web_pedido.entrega_uf,                                                                                         '+SLineBreak+
            '      					 web_pedido.montagem_data,                                                                                      '+SLineBreak+
            '      					 web_pedido.montagem_hora,                                                                                      '+SLineBreak+
            '      					 web_pedido.entrega_data,                                                                                       '+SLineBreak+
            '      					 web_pedido.entrega_hora,                                                                                       '+SLineBreak+
            '      					 regiao.descricao regiao,                                                                                       '+SLineBreak+
            '      					 web_pedido.valor_frete valor_frete,                                                                            '+SLineBreak+
            '      					 coalesce(web_pedido.acrescimo,0) acrescimo,                                                                    '+SLineBreak+
            '      					 web_pedidoitens.quantidade * web_pedidoitens.valor_unitario valor_itens,                                       '+SLineBreak+
            '      					 web_pedidoitens.quantidade * coalesce(web_pedidoitens.vlr_garantia,0) valor_garantia,                          '+SLineBreak+
            '      					 coalesce(web_pedido.valor_cupom_desconto,0) valor_cupom_desconto                                               '+SLineBreak+
            '      				from web_pedido                                                                                                   '+SLineBreak+
            '      			   inner join clientes on web_pedido.cliente_id = clientes.codigo_cli                                               '+SLineBreak+
            '      				left join web_pedidoitens on web_pedidoitens.web_pedido_id = web_pedido.id                                        '+SLineBreak+
            '      				left join regiao on regiao.id = web_pedido.regiao_id                                                              '+SLineBreak+
            '      			   ) t1                                                                                                             '+SLineBreak+
            '                                                                                                                               '+SLineBreak+
            '    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 ) web_pedido                                                               '+SLineBreak+
            '    where 1=1                                                                                                                  '+SLineBreak;

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TWebPedidoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TWebPedidoDao.SetWebPedidosLista(const Value: TObjectList<TWebPedidoModel>);
begin
  FWebPedidosLista := Value;
end;

procedure TWebPedidoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TWebPedidoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TWebPedidoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TWebPedidoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TWebPedidoDao.setParams(var pQry: TFDQuery; pWebPedidoModel: TWebPedidoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('WEB_PEDIDO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TWebPedidoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pWebPedidoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pWebPedidoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TWebPedidoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TWebPedidoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TWebPedidoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
