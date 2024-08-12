unit WebPedidoDao;

interface

uses
  WebPedidoModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Spring.Collections,
  Terasoft.FuncoesTexto,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TWebPedidoDao = class;
  ITWebPedidoDao=IObject<TWebPedidoDao>;

  TWebPedidoDao = class
  private
    [weak] mySelf: ITWebPedidoDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FWebPedidosLista: IList<ITWebPedidoModel>;
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
    procedure SetWebPedidosLista(const Value: IList<ITWebPedidoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

    procedure setParams(var pQry: TFDQuery; pWebPedidoModel: ITWebPedidoModel);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITWebPedidoDao;

    property WebPedidosLista: IList<ITWebPedidoModel> read FWebPedidosLista write SetWebPedidosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pWebPedidoModel: ITWebPedidoModel): String;
    function alterar(pWebPedidoModel: ITWebPedidoModel): String;
    function excluir(pWebPedidoModel: ITWebPedidoModel): String;

    function obterLista: IFDDataset;
    function carregaClasse(pId: String): ITWebPedidoModel;
end;

implementation

uses
  System.Rtti, Clipbrd;

{ TWebPedido }

function TWebPedidoDao.alterar(pWebPedidoModel: ITWebPedidoModel): String;
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

    Result := pWebPedidoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TWebPedidoDao.carregaClasse(pId: String): ITWebPedidoModel;
var
  lQry: TFDQuery;
  lModel: ITWebPedidoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TWebPedidoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from web_pedido where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                              := lQry.FieldByName('ID').AsString;
    lModel.objeto.LOJA                            := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.DATAHORA                        := lQry.FieldByName('DATAHORA').AsString;
    lModel.objeto.CLIENTE_ID                      := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.objeto.VENDEDOR_ID                     := lQry.FieldByName('VENDEDOR_ID').AsString;
    lModel.objeto.PORTADOR_ID                     := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.TIPOVENDA_ID                    := lQry.FieldByName('TIPOVENDA_ID').AsString;
    lModel.objeto.CONDICOES_PAGAMENTO             := lQry.FieldByName('CONDICOES_PAGAMENTO').AsString;
    lModel.objeto.PERCENTUAL_DESCONTO             := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
    lModel.objeto.VALOR_FRETE                     := lQry.FieldByName('VALOR_FRETE').AsString;
    lModel.objeto.VALOR_ST                        := lQry.FieldByName('VALOR_ST').AsString;
    lModel.objeto.OBSERVACAO                      := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.objeto.OBSERVACOES                     := lQry.FieldByName('OBSERVACOES').AsString;
    lModel.objeto.STATUS                          := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.SUBSTATUS                       := lQry.FieldByName('SUBSTATUS').AsString;
    lModel.objeto.PEDIDO_ID                       := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.objeto.ORIGEM_PEDIDO                   := lQry.FieldByName('ORIGEM_PEDIDO').AsString;
    lModel.objeto.PEDIDO_COMPRA                   := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.objeto.ACRESCIMO                       := lQry.FieldByName('ACRESCIMO').AsString;
    lModel.objeto.ISGIFT                          := lQry.FieldByName('ISGIFT').AsString;
    lModel.objeto.VALOR_TOTAL                     := lQry.FieldByName('VALOR_TOTAL').AsString;
    lModel.objeto.CODIGO_CUPOM_DESCONTO           := lQry.FieldByName('CODIGO_CUPOM_DESCONTO').AsString;
    lModel.objeto.VALOR_CUPOM_DESCONTO            := lQry.FieldByName('VALOR_CUPOM_DESCONTO').AsString;
    lModel.objeto.DADOS_ADICIONAIS                := lQry.FieldByName('DADOS_ADICIONAIS').AsString;
    lModel.objeto.DATA                            := lQry.FieldByName('DATA').AsString;
    lModel.objeto.CONTROLEALTERACAO               := lQry.FieldByName('CONTROLEALTERACAO').AsString;
    lModel.objeto.USUARIO                         := lQry.FieldByName('USUARIO').AsString;
    lModel.objeto.TRANSPORTADORA_ID               := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.objeto.EVENTO                          := lQry.FieldByName('EVENTO').AsString;
    lModel.objeto.IMPRESSAO                       := lQry.FieldByName('IMPRESSAO').AsString;
    lModel.objeto.IDPEDIDOSOVIS                   := lQry.FieldByName('IDPEDIDOSOVIS').AsString;
    lModel.objeto.CORREIO_VOLUME                  := lQry.FieldByName('CORREIO_VOLUME').AsString;
    lModel.objeto.CORREIO_DATA                    := lQry.FieldByName('CORREIO_DATA').AsString;
    lModel.objeto.CORREIO_HORA                    := lQry.FieldByName('CORREIO_HORA').AsString;
    lModel.objeto.ENVIAR_EMAIL                    := lQry.FieldByName('ENVIAR_EMAIL').AsString;
    lModel.objeto.TRANSPORTADORA_DADOS_ADICIONAIS := lQry.FieldByName('TRANSPORTADORA_DADOS_ADICIONAIS').AsString;
    lModel.objeto.DADOS_AUTORIZACAO               := lQry.FieldByName('DADOS_AUTORIZACAO').AsString;
    lModel.objeto.PARCELAS                        := lQry.FieldByName('PARCELAS').AsString;
    lModel.objeto.VALOR_ENTRADA                   := lQry.FieldByName('VALOR_ENTRADA').AsString;
    lModel.objeto.PRIMEIRO_VENCIMENTO             := lQry.FieldByName('PRIMEIRO_VENCIMENTO').AsString;
    lModel.objeto.IDPEDIDOSOVISUSUARIO            := lQry.FieldByName('IDPEDIDOSOVISUSUARIO').AsString;
    lModel.objeto.USAR_TABELA_PRECO               := lQry.FieldByName('USAR_TABELA_PRECO').AsString;
    lModel.objeto.TIPO                            := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.DATA_HORA_ANALISE               := lQry.FieldByName('DATA_HORA_ANALISE').AsString;
    lModel.objeto.USUARIO_ANALISE                 := lQry.FieldByName('USUARIO_ANALISE').AsString;
    lModel.objeto.DATA_HORA_APROVACAO             := lQry.FieldByName('DATA_HORA_APROVACAO').AsString;
    lModel.objeto.USUARIO_APROVACAO               := lQry.FieldByName('USUARIO_APROVACAO').AsString;
    lModel.objeto.MENSAGEM_ANALISE                := lQry.FieldByName('MENSAGEM_ANALISE').AsString;
    lModel.objeto.STATUS_SOVIS                    := lQry.FieldByName('STATUS_SOVIS').AsString;
    lModel.objeto.FATURAR                         := lQry.FieldByName('FATURAR').AsString;
    lModel.objeto.CAMINHO_BOLETO                  := lQry.FieldByName('CAMINHO_BOLETO').AsString;
    lModel.objeto.CAMINHO_NFE                     := lQry.FieldByName('CAMINHO_NFE').AsString;
    lModel.objeto.UUID_SOVIS                      := lQry.FieldByName('UUID_SOVIS').AsString;
    lModel.objeto.ENTREGA_DATA                    := lQry.FieldByName('ENTREGA_DATA').AsString;
    lModel.objeto.ENTREGA_HORA                    := lQry.FieldByName('ENTREGA_HORA').AsString;
    lModel.objeto.MONTAGEM_DATA                   := lQry.FieldByName('MONTAGEM_DATA').AsString;
    lModel.objeto.MONTAGEM_HORA                   := lQry.FieldByName('MONTAGEM_HORA').AsString;
    lModel.objeto.USUARIO_ANALISANDO              := lQry.FieldByName('USUARIO_ANALISANDO').AsString;
    lModel.objeto.ENTREGA_ENDERECO                := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
    lModel.objeto.ENTREGA_COMPLEMENTO             := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
    lModel.objeto.ENTREGA_NUMERO                  := lQry.FieldByName('ENTREGA_NUMERO').AsString;
    lModel.objeto.ENTREGA_BAIRRO                  := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
    lModel.objeto.ENTREGA_CIDADE                  := lQry.FieldByName('ENTREGA_CIDADE').AsString;
    lModel.objeto.ENTREGA_UF                      := lQry.FieldByName('ENTREGA_UF').AsString;
    lModel.objeto.ENTREGA_CEP                     := lQry.FieldByName('ENTREGA_CEP').AsString;
    lModel.objeto.ENTREGA_COD_MUNICIPIO           := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
    lModel.objeto.PRE_ANALISE_STATUS              := lQry.FieldByName('PRE_ANALISE_STATUS').AsString;
    lModel.objeto.PRE_ANALISE_USUARIO_ID          := lQry.FieldByName('PRE_ANALISE_USUARIO_ID').AsString;
    lModel.objeto.PRE_ANALISE_DATAHORA            := lQry.FieldByName('PRE_ANALISE_DATAHORA').AsString;
    lModel.objeto.PERIOD                          := lQry.FieldByName('PERIOD').AsString;
    lModel.objeto.SYSTIME                         := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.DATA_HORA_REPROVADO             := lQry.FieldByName('DATA_HORA_REPROVADO').AsString;
    lModel.objeto.USUARIO_REPROVADO               := lQry.FieldByName('USUARIO_REPROVADO').AsString;
    lModel.objeto.CONDICOES2_PAG                  := lQry.FieldByName('CONDICOES2_PAG').AsString;
    lModel.objeto.SAIDA_ID                        := lQry.FieldByName('SAIDA_ID').AsString;
    lModel.objeto.PROPOSTA                        := lQry.FieldByName('PROPOSTA').AsString;
    lModel.objeto.FRETE_ALTURA                    := lQry.FieldByName('FRETE_ALTURA').AsString;
    lModel.objeto.FRETE_PROFUNDIDADE              := lQry.FieldByName('FRETE_PROFUNDIDADE').AsString;
    lModel.objeto.FRETE_LARGURA                   := lQry.FieldByName('FRETE_LARGURA').AsString;
    lModel.objeto.FRETE_PESO                      := lQry.FieldByName('FRETE_PESO').AsString;
    lModel.objeto.FRETE_VALOR                     := lQry.FieldByName('FRETE_VALOR').AsString;
    lModel.objeto.CUPOM_DESCONTO                  := lQry.FieldByName('CUPOM_DESCONTO').AsString;
    lModel.objeto.CUPOM_TIPO                      := lQry.FieldByName('CUPOM_TIPO').AsString;
    lModel.objeto.CUPOM_VALOR                     := lQry.FieldByName('CUPOM_VALOR').AsString;
    lModel.objeto.MARKETPLACE                     := lQry.FieldByName('MARKETPLACE').AsString;
    lModel.objeto.REGIAO_ID                       := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.objeto.PRECO_VENDA_ID                  := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.objeto.DATA_CONSUMO_OMINIONE           := lQry.FieldByName('DATA_CONSUMO_OMINIONE').AsString;
    lModel.objeto.INTERMEDIADOR_ID                := lQry.FieldByName('INTERMEDIADOR_ID').AsString;
    lModel.objeto.LOTE_EXPORTACAO                 := lQry.FieldByName('LOTE_EXPORTACAO').AsString;
    lModel.objeto.DATA_EXPORTACAO                 := lQry.FieldByName('DATA_EXPORTACAO').AsString;
    lModel.objeto.STATUS_ANALISE                  := lQry.FieldByName('STATUS_ANALISE').AsString;
    lModel.objeto.PED_PLATAFORMA                  := lQry.FieldByName('PED_PLATAFORMA').AsString;
    lModel.objeto.CODIGO_AUTORIZACAO_CARTAO       := lQry.FieldByName('CODIGO_AUTORIZACAO_CARTAO').AsString;
    lModel.objeto.SEGURO_PRESTAMISTA_VALOR        := lQry.FieldByName('SEGURO_PRESTAMISTA_VALOR').AsString;
    lModel.objeto.SEGURO_PRESTAMISTA_CUSTO        := lQry.FieldByName('SEGURO_PRESTAMISTA_CUSTO').AsString;
    lModel.objeto.VALOR_FINANCIADO                := lQry.FieldByName('VALOR_FINANCIADO').AsString;
    lModel.objeto.AVALISTA_ID                     := lQry.FieldByName('AVALISTA_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TWebPedidoDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TWebPedidoDao.Destroy;
begin
  FWebPedidosLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TWebPedidoDao.excluir(pWebPedidoModel: ITWebPedidoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from WEB_PEDIDO where ID = :ID',[pWebPedidoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pWebPedidoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TWebPedidoDao.getNewIface(pIConexao: IConexao): ITWebPedidoDao;
begin
  Result := TImplObjetoOwner<TWebPedidoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TWebPedidoDao.incluir(pWebPedidoModel: ITWebPedidoModel): String;
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
    lSQL := lSQL + ' and webpedido.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TWebPedidoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := ' select count(*) records                                                                                                       '+sLineBreak+
            ' from (                                                                                                                        '+sLineBreak+
            ' select                                                                                                                        '+sLineBreak+
            '        ID,                                                                                                                    '+SLineBreak+
            '        OBSERVACAO,                                                                                                            '+SLineBreak+
            '        CODIGO_CLI, cliente_id,                                                                                                '+SLineBreak+
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
            '        DATAHORA,                                                                                                              '+SLineBreak+
            '        VENDEDOR_ID,                                                                                                           '+SLineBreak+
            '        VENDEDOR,                                                                                                              '+SLineBreak+
            '        STATUS,                                                                                                                '+SLineBreak+
            '        REGIAO_ID,                                                                                                             '+SLineBreak+
            '        MENSAGEM_ANALISE,                                                                                                      '+SLineBreak+
            '        VALOR_FRETE,                                                                                                           '+SLineBreak+
            '        ACRESCIMO,                                                                                                             '+SLineBreak+
            '        ORIGEM_PEDIDO,                                                                                                         '+SLineBreak+
            '        VALOR_ITENS,                                                                                                           '+SLineBreak+
            '        VALOR_GARANTIA,                                                                                                        '+SLineBreak+
            '        VALOR_CUPOM_DESCONTO,                                                                                                  '+SLineBreak+
            '        VALOR_TOTAL                                                                                                            '+SLineBreak+
            '    from (                                                                                                                     '+SLineBreak+
            '    			select                                                                                                                '+SLineBreak+
            '    				id,                                                                                                                 '+SLineBreak+
            '           observacao,                                                                                                         '+SLineBreak+
            '    				codigo_cli, cliente_id,                                                                                             '+SLineBreak+
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
            '           datahora,                                                                                                           '+SLineBreak+
            '           vendedor_id,                                                                                                        '+SLineBreak+
            '           vendedor,                                                                                                           '+SLineBreak+
            '           status,                                                                                                             '+SLineBreak+
            '           regiao_id,                                                                                                          '+SLineBreak+
            '           mensagem_analise,                                                                                                   '+SLineBreak+
            '    				valor_frete valor_frete,                                                                                            '+SLineBreak+
            '    				acrescimo acrescimo,                                                                                                '+SLineBreak+
            '    				origem_pedido,                                                                                                      '+SLineBreak+
            '    				sum(valor_itens) valor_itens,                                                                                       '+SLineBreak+
            '    				sum(valor_garantia) valor_garantia,                                                                                 '+SLineBreak+
            '    				sum(valor_cupom_desconto) valor_cupom_desconto,                                                                     '+SLineBreak+
            '    				sum(valor_itens + valor_frete + valor_garantia + acrescimo - valor_cupom_desconto) valor_total                      '+SLineBreak+
            '      		from (                                                                                                                '+SLineBreak+
            '      			  select web_pedido.id,                                                                                             '+SLineBreak+
            '                    web_pedido.observacao,                                                                                     '+SLineBreak+
            '         					 clientes.codigo_cli, web_pedido.cliente_id,                                                                '+SLineBreak+
            '         					 coalesce(clientes.fantasia_cli, clientes.razao_cli) cliente_nome,                                          '+SLineBreak+
            '      	    				 web_pedido.entrega_endereco,                                                                               '+SLineBreak+
            '      			   		   web_pedido.entrega_numero,                                                                                 '+SLineBreak+
            '      				    	 web_pedido.entrega_cod_municipio,                                                                          '+SLineBreak+
            '         					 web_pedido.entrega_cep,                                                                                    '+SLineBreak+
            '         					 web_pedido.entrega_complemento,                                                                            '+SLineBreak+
            '         					 web_pedido.entrega_cidade,                                                                                 '+SLineBreak+
            '      		   	  		 web_pedido.entrega_bairro,                                                                                 '+SLineBreak+
            '      			   	  	 web_pedido.entrega_uf,                                                                                     '+SLineBreak+
            '         					 web_pedido.montagem_data,                                                                                  '+SLineBreak+
            '         					 web_pedido.montagem_hora,                                                                                  '+SLineBreak+
            '         					 web_pedido.entrega_data,                                                                                   '+SLineBreak+
            '         					 web_pedido.entrega_hora,                                                                                   '+SLineBreak+
            '         					 regiao.descricao regiao,                                                                                   '+SLineBreak+
            '                    web_pedido.datahora,                                                                                       '+SLineBreak+
            '                    web_pedido.vendedor_id vendedor_id,                                                                        '+SLineBreak+
            '                    funcionario.nome_fun vendedor,                                                                             '+SLineBreak+
            '                    web_pedido.status,                                                                                         '+SLineBreak+
            '                    web_pedido.regiao_id,                                                                                      '+SLineBreak+
            '                    web_pedido.mensagem_analise,                                                                               '+SLineBreak+
            '         					 coalesce(web_pedido.valor_frete,0) valor_frete,                                                            '+SLineBreak+
            '         					 coalesce(web_pedido.acrescimo,0) acrescimo,                                                                '+SLineBreak+
            '                    web_pedido.origem_pedido,                                                                                  '+SLineBreak+
            '         					 coalesce(web_pedidoitens.quantidade,0) * coalesce(web_pedidoitens.valor_unitario,0) valor_itens,           '+SLineBreak+
            '         					 coalesce(web_pedidoitens.quantidade,0) * coalesce(web_pedidoitens.vlr_garantia,0) valor_garantia,          '+SLineBreak+
            '         					 coalesce(web_pedido.valor_cupom_desconto,0) valor_cupom_desconto                                           '+SLineBreak+
            '       				from web_pedido                                                                                                 '+SLineBreak+
            '      			    left join clientes on web_pedido.cliente_id = clientes.codigo_cli                                               '+SLineBreak+
            '      				  left join web_pedidoitens on web_pedidoitens.web_pedido_id = web_pedido.id                                      '+SLineBreak+
            '      				  left join regiao on regiao.id = web_pedido.regiao_id                                                            '+SLineBreak+
            '               left join funcionario on funcionario.codigo_fun = web_pedido.vendedor_id                                        '+SLineBreak+
            '             ) t1                                                                                                              '+sLineBreak+
            '          group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19, 20, 21, 22, 23, 24, 25, 26, 27 ) webpedido                 '+sLineBreak+
            '          where 1=1 '+ where +'                                                                                                '+sLineBreak+
            '    )';

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TWebPedidoDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
  modelo: ITWebPedidoModel;
begin
  lQry := vIConexao.CriarQuery;

  FWebPedidosLista := TCollections.CreateList<ITWebPedidoModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := 'first ' + LengthPageView + ' SKIP ' + StartRecordView;


    lSQL := '    select  '+lPaginacao+'                                                                                                                                                   '+SLineBreak+
            '        ID,                                                                                                                                                                  '+SLineBreak+
            '        OBSERVACAO,                                                                                                                                                          '+SLineBreak+
            '        CODIGO_CLI, cliente_id,                                                                                                                                              '+SLineBreak+
            '        CLIENTE_NOME,                                                                                                                                                        '+SLineBreak+
            '        ENTREGA_ENDERECO,                                                                                                                                                    '+SLineBreak+
            '        ENTREGA_NUMERO,                                                                                                                                                      '+SLineBreak+
            '        ENTREGA_COD_MUNICIPIO,                                                                                                                                               '+SLineBreak+
            '        ENTREGA_CEP,                                                                                                                                                         '+SLineBreak+
            '        ENTREGA_COMPLEMENTO,                                                                                                                                                 '+SLineBreak+
            '        ENTREGA_CIDADE,                                                                                                                                                      '+SLineBreak+
            '        ENTREGA_BAIRRO,                                                                                                                                                      '+SLineBreak+
            '        ENTREGA_UF,                                                                                                                                                          '+SLineBreak+
            '        MONTAGEM_DATA,                                                                                                                                                       '+SLineBreak+
            '        MONTAGEM_HORA,                                                                                                                                                       '+SLineBreak+
            '        ENTREGA_DATA,                                                                                                                                                        '+SLineBreak+
            '        ENTREGA_HORA,                                                                                                                                                        '+SLineBreak+
            '        AVALISTA_ID,                                                                                                                                                         '+SLineBreak+
            '        AVALISTA_NOME,                                                                                                                                                       '+SLineBreak+
            '        REGIAO,                                                                                                                                                              '+SLineBreak+
            '        DATAHORA,                                                                                                                                                            '+SLineBreak+
            '        VENDEDOR_ID,                                                                                                                                                         '+SLineBreak+
            '        VENDEDOR,                                                                                                                                                            '+SLineBreak+
            '        STATUS,                                                                                                                                                              '+SLineBreak+
            '        REGIAO_ID,                                                                                                                                                           '+SLineBreak+
            '        MENSAGEM_ANALISE,                                                                                                                                                    '+SLineBreak+
            '        VALOR_FRETE,                                                                                                                                                         '+SLineBreak+
            '        ACRESCIMO,                                                                                                                                                           '+SLineBreak+
            '        ORIGEM_PEDIDO,                                                                                                                                                       '+SLineBreak+
            '        SEGURO_PRESTAMISTA_VALOR,                                                                                                                                            '+SLineBreak+
            '        SEGURO_PRESTAMISTA_CUSTO,   	                                                                                                                                      '+SLineBreak+
            '        VALOR_ITENS,                                                                                                                                                         '+SLineBreak+
            '        VALOR_GARANTIA,                                                                                                                                                      '+SLineBreak+
            '        VALOR_CUPOM_DESCONTO,                                                                                                                                                '+SLineBreak+
            '        VALOR_TOTAL + SEGURO_PRESTAMISTA_VALOR + VALOR_FRETE + ACRESCIMO - VALOR_CUPOM_DESCONTO VALOR_TOTAL                                                                  '+SLineBreak+
			      '                                                                                                                                                                       '+SLineBreak+
            '    from (                                                                                                                                                                   '+SLineBreak+
            '                                                                                                                                                                             '+SLineBreak+
            '    			select                                                                                                                                                        '+SLineBreak+
            '    				id,                                                                                                                                                       '+SLineBreak+
            '           observacao,                                                                                                                                                       '+SLineBreak+
            '    				codigo_cli, cliente_id,                                                                                                                                   '+SLineBreak+
            '    				cliente_nome,                                                                                                                                             '+SLineBreak+
            '    				entrega_endereco,                                                                                                                                         '+SLineBreak+
            '    				entrega_numero,                                                                                                                                           '+SLineBreak+
            '    				entrega_cod_municipio,                                                                                                                                    '+SLineBreak+
            '    				entrega_cep,                                                                                                                                              '+SLineBreak+
            '    				entrega_complemento,                                                                                                                                      '+SLineBreak+
            '    				entrega_cidade,                                                                                                                                           '+SLineBreak+
            '    				entrega_bairro,                                                                                                                                           '+SLineBreak+
            '    				entrega_uf,                                                                                                                                               '+SLineBreak+
            '    				montagem_data,                                                                                                                                            '+SLineBreak+
            '    				montagem_hora,                                                                                                                                            '+SLineBreak+
            '    				entrega_data,                                                                                                                                             '+SLineBreak+
            '    				entrega_hora,                                                                                                                                             '+SLineBreak+
            '    				avalista_id,                                                                                                                                              '+SLineBreak+
            '    				cliente_nome avalista_nome,                                                                                                                               '+SLineBreak+
            '    				regiao,                                                                                                                                                   '+SLineBreak+
            '           datahora,                                                                                                                                                 '+SLineBreak+
            '           vendedor_id,                                                                                                                                              '+SLineBreak+
            '           vendedor,                                                                                                                                                 '+SLineBreak+
            '           status,                                                                                                                                                   '+SLineBreak+
            '           regiao_id,                                                                                                                                                '+SLineBreak+
            '           mensagem_analise,                                                                                                                                         '+SLineBreak+
            '    				valor_frete valor_frete,                                                                                                                                  '+SLineBreak+
            '    				acrescimo acrescimo,                                                                                                                                      '+SLineBreak+
            '    				origem_pedido,                                                                                                                                            '+SLineBreak+
            '           seguro_prestamista_valor,                                                                                                                                 '+SLineBreak+
            '           seguro_prestamista_custo,   	                                                                                                                            '+SLineBreak+
            '    				valor_cupom_desconto,                                                                                                                                     '+SLineBreak+
            '    				sum(valor_itens) valor_itens,                                                                                                                             '+SLineBreak+
            '    				sum(valor_garantia) valor_garantia,                                                                                                                       '+SLineBreak+
            '    				sum(valor_itens + valor_garantia) valor_total                                                                                                             '+SLineBreak+
            '                                                                                                                                                                     '+SLineBreak+
            '      		from (                                                                                                                                                      '+SLineBreak+
            '																												                                                                                                              '+SLineBreak+
            '      			  select web_pedido.id,                                                                                                                                   '+SLineBreak+
            '                    web_pedido.observacao,                                                                                                                           '+SLineBreak+
            '         					 clientes.codigo_cli, web_pedido.cliente_id,                                                                                                      '+SLineBreak+
            '         					 coalesce(clientes.fantasia_cli, clientes.razao_cli) cliente_nome,                                                                                '+SLineBreak+
            '      	    				 web_pedido.entrega_endereco,                                                                                                                     '+SLineBreak+
            '      			   		   web_pedido.entrega_numero,                                                                                                                       '+SLineBreak+
            '      				    	 web_pedido.entrega_cod_municipio,                                                                                                                '+SLineBreak+
            '         					 web_pedido.entrega_cep,                                                                                                                          '+SLineBreak+
            '         					 web_pedido.entrega_complemento,                                                                                                                  '+SLineBreak+
            '         					 web_pedido.entrega_cidade,                                                                                                                       '+SLineBreak+
            '      		   	  		 web_pedido.entrega_bairro,                                                                                                                       '+SLineBreak+
            '      			   	  	 web_pedido.entrega_uf,                                                                                                                           '+SLineBreak+
            '         					 web_pedido.montagem_data,                                                                                                                        '+SLineBreak+
            '         					 web_pedido.montagem_hora,                                                                                                                        '+SLineBreak+
            '         					 web_pedido.entrega_data,                                                                                                                         '+SLineBreak+
            '         					 web_pedido.entrega_hora,                                                                                                                         '+SLineBreak+
            '    				         web_pedido.avalista_id,                                                                                                                          '+SLineBreak+
            '    			           coalesce(clientes2.fantasia_cli, clientes2.razao_cli) avalista_nome,                                                                             '+SLineBreak+
            '         					 regiao.descricao regiao,                                                                                                                         '+SLineBreak+
            '                    web_pedido.datahora,                                                                                                                             '+SLineBreak+
            '                    web_pedido.vendedor_id vendedor_id,                                                                                                              '+SLineBreak+
            '                    funcionario.nome_fun vendedor,                                                                                                                   '+SLineBreak+
            '                    web_pedido.status,                                                                                                                               '+SLineBreak+
            '                    web_pedido.regiao_id,                                                                                                                            '+SLineBreak+
            '                    web_pedido.mensagem_analise,                                                                                                                     '+SLineBreak+
            '         					 coalesce(web_pedido.valor_frete,0) valor_frete,                                                                                                  '+SLineBreak+
            '         					 coalesce(web_pedido.acrescimo,0) acrescimo,                                                                                                      '+SLineBreak+
            '                    web_pedido.origem_pedido,                                                                                                                        '+SLineBreak+
            '                    coalesce(web_pedido.seguro_prestamista_valor, 0) seguro_prestamista_valor,                                                                       '+SLineBreak+
            '                    coalesce(web_pedido.seguro_prestamista_custo, 0) seguro_prestamista_custo,                                                                       '+SLineBreak+
            '         					 coalesce(web_pedidoitens.quantidade,0) * coalesce(web_pedidoitens.valor_unitario,0) valor_itens,                                                 '+SLineBreak+
            '         					 coalesce(web_pedidoitens.quantidade, 0) * (coalesce(web_pedidoitens.vlr_garantia,0)+coalesce(web_pedidoitens.vlr_garantia_fr,0)) valor_garantia, '+SLineBreak+
            '         					 coalesce(web_pedido.valor_cupom_desconto,0) valor_cupom_desconto                                                                                 '+SLineBreak+
            '       				from web_pedido                                                                                                                                       '+SLineBreak+
            '      			    left join clientes on web_pedido.cliente_id = clientes.codigo_cli                                                                                     '+SLineBreak+
            '      			    left join clientes clientes2 on web_pedido.avalista_id = clientes2.codigo_cli                                                                         '+SLineBreak+
            '      				  left join web_pedidoitens on web_pedidoitens.web_pedido_id = web_pedido.id                                                                            '+SLineBreak+
            '      				  left join regiao on regiao.id = web_pedido.regiao_id                                                                                                  '+SLineBreak+
            '               left join funcionario on funcionario.codigo_fun = web_pedido.vendedor_id                                                                              '+SLineBreak+
            '      			   ) t1                                                                                                                                                   '+SLineBreak+
            '                                                                                                                                                                     '+SLineBreak+
            '    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 ) webpedido                                         '+SLineBreak+
            '    where 1=1                                                                                                                                                        '+SLineBreak;

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

procedure TWebPedidoDao.SetWebPedidosLista;
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

procedure TWebPedidoDao.setParams(var pQry: TFDQuery; pWebPedidoModel: ITWebPedidoModel);
begin
  vConstrutor.setParams('WEB_PEDIDO',pQry,pWebPedidoModel.objeto);
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
