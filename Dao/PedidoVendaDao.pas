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
  Spring.Collections,
  Terasoft.Utils;

type
  TPedidoVendaDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPedidoVendasLista: IList<TPedidoVendaModel>;
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
    procedure SetPedidoVendasLista(const Value: ILIst<TPedidoVendaModel>);
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

    property PedidoVendasLista: IList<TPedidoVendaModel> read FPedidoVendasLista write SetPedidoVendasLista;
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
    function obterComprasRealizadas(pCliente: String): IFDDataset;
    function retornaGarantia(pNumeroPedido: String) : Boolean;

end;
implementation

uses
  Vcl.Dialogs, System.Rtti, Terasoft.Configuracoes, Terasoft.Types;

{ TPedidoVenda }

procedure TPedidoVendaDao.obterUpdateImpostos(pNumeroPedido: String);
var
  lQry         : TFDQuery;
  lSQL         : String;
  i            : Integer;
  lValor_ped,
  lDesc_ped,
  lAcres_ped   : Double;

begin
  lQry := vIConexao.CriarQuery;
  FPedidoVendasLista := TCollections.CreateList<TPedidoVendaModel>(true);

  lValor_ped := 0;
  lDesc_ped  := 0;
  lAcres_ped := 0;

  try
    lSQL :=
      ' select i.id pedidoitens_id,                                                                       '+SLineBreak+
      '        p.valor_ped,                                                                               '+SLineBreak+
      '        p.desc_ped,                                                                                '+SLineBreak+
      '        p.acres_ped,                                                                               '+SLineBreak+
      '        c.uf_cli,                                                                                  '+SLineBreak+
      '        i.codigo_pro,                                                                              '+SLineBreak+
      '        i.quantidade_ped,                                                                          '+SLineBreak+
      '        i.valorunitario_ped,                                                                       '+SLineBreak+
      '        (i.quantidade_ped * i.valorunitario_ped) total_produto,                                    '+SLineBreak+
      '         i.vdesc desconto_item,                                                                    '+SLineBreak+
      '         i.quantidade_ped * i.valorunitario_ped / p.valor_ped * p.acres_ped acrescimo_item         '+SLineBreak+
      '   from pedidovenda p                                                                              '+SLineBreak+
      '   left join pedidoitens i on i.numero_ped = p.numero_ped                                          '+SLineBreak+
      '   left join clientes c on c.codigo_cli = p.codigo_cli                                             '+SLineBreak+
      '  where coalesce(i.tipo_venda, ''LJ'') = ''LJ''                                                    '+SLineBreak+
      '    and p.numero_ped = '+QuotedStr(pNumeroPedido);

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

      lValor_ped := lValor_ped   + lQry.FieldByName('TOTAL_PRODUTO').AsFloat;
      lDesc_ped  := lDesc_ped    + lQry.FieldByName('DESCONTO_ITEM').AsFloat;
      lAcres_ped := lAcres_ped   + lQry.FieldByName('ACRESCIMO_ITEM').AsFloat;

      lQry.Next;
    end;

    for i := 0 to FPedidoVendasLista.Count -1 do
    begin
      FPedidoVendasLista[i].VALOR_PED         := FloatToStr(lValor_ped);
      FPedidoVendasLista[i].DESC_PED          := FloatToStr(lDesc_ped);
      FPedidoVendasLista[i].ACRES_PED         := FloatToStr(lAcres_ped);
    end;

  finally
    lQry.Free;
  end;
end;
function TPedidoVendaDao.retornaGarantia(pNumeroPedido: String): Boolean;
var
  lQry       : TFDQuery;
  lSQL       : String;
begin
  lQry := vIConexao.CriarQuery;

  try
      lSQL := ' SELECT COUNT(*) RECORDS FROM PEDIDOVENDA P                                             '+SLineBreak+
              '    LEFT JOIN PEDIDOITENS PI                                                            '+SLineBreak+
              '    ON P.NUMERO_PED = PI.NUMERO_PED                                                     '+SLineBreak+
              '  WHERE P.NUMERO_PED = '+QuotedStr(pNumeroPedido)+' AND                                 '+SLineBreak+
              '   (PI.QUANTIDADE_TIPO > 0 OR PI.VLR_GARANTIA_FR > 0 OR P.SEGURO_PRESTAMISTA_VALOR > 0) '+SLineBreak;

    lQry.Open(lSQL);

    if lQry.FieldByName('RECORDS').AsInteger = 0 then
      Result := False
    else
      Result := True;

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
    lModel.NUMERO_PED               := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.CODIGO_CLI               := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.CODIGO_VEN               := lQry.FieldByName('CODIGO_VEN').AsString;
    lModel.CODIGO_PORT              := lQry.FieldByName('CODIGO_PORT').AsString;
    lModel.CODIGO_TIP               := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.DATA_PED                 := lQry.FieldByName('DATA_PED').AsString;
    lModel.VALOR_PED                := lQry.FieldByName('VALOR_PED').AsString;
    lModel.DESC_PED                 := lQry.FieldByName('DESC_PED').AsString;
    lModel.ACRES_PED                := lQry.FieldByName('ACRES_PED').AsString;
    lModel.TOTAL_PED                := lQry.FieldByName('TOTAL_PED').AsString;
    lModel.USUARIO_PED              := lQry.FieldByName('USUARIO_PED').AsString;
    lModel.NUMERO_ORC               := lQry.FieldByName('NUMERO_ORC').AsString;
    lModel.INFORMACOES_PED          := lQry.FieldByName('INFORMACOES_PED').AsString;
    lModel.TIPO_PED                 := lQry.FieldByName('TIPO_PED').AsString;
    lModel.INDCE_PED                := lQry.FieldByName('INDCE_PED').AsString;
    lModel.CFOP_ID                  := lQry.FieldByName('CFOP_ID').AsString;
    lModel.PRIMEIROVENC_PED         := lQry.FieldByName('PRIMEIROVENC_PED').AsString;
    lModel.VALORENTADA_PED          := lQry.FieldByName('VALORENTADA_PED').AsString;
    lModel.PARCELAS_PED             := lQry.FieldByName('PARCELAS_PED').AsString;
    lModel.PARCELA_PED              := lQry.FieldByName('PARCELA_PED').AsString;
    lModel.STATUS_PED               := lQry.FieldByName('STATUS_PED').AsString;
    lModel.TABJUROS_PED             := lQry.FieldByName('TABJUROS_PED').AsString;
    lModel.CONTATO_PED              := lQry.FieldByName('CONTATO_PED').AsString;
    lModel.DESCONTO_PED             := lQry.FieldByName('DESCONTO_PED').AsString;
    lModel.CTR_IMPRESSAO_PED        := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
    lModel.FRETE_PED                := lQry.FieldByName('FRETE_PED').AsString;
    lModel.CONDICOES_PAG            := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.TOTAL1_PED               := lQry.FieldByName('TOTAL1_PED').AsString;
    lModel.TOTAL2_PED               := lQry.FieldByName('TOTAL2_PED').AsString;
    lModel.LOCAL_PED                := lQry.FieldByName('LOCAL_PED').AsString;
    lModel.TELEVENDA_PED            := lQry.FieldByName('TELEVENDA_PED').AsString;
    lModel.PESO_PED                 := lQry.FieldByName('PESO_PED').AsString;
    lModel.PRIMEIROVENC2_PED        := lQry.FieldByName('PRIMEIROVENC2_PED').AsString;
    lModel.PARCELAS2_PED            := lQry.FieldByName('PARCELAS2_PED').AsString;
    lModel.VALOR_IPI                := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.CONDICOES2_PAG           := lQry.FieldByName('CONDICOES2_PAG').AsString;
    lModel.LOJA                     := lQry.FieldByName('LOJA').AsString;
    lModel.DOLAR                    := lQry.FieldByName('DOLAR').AsString;
    lModel.CTR_EXPORTACAO           := lQry.FieldByName('CTR_EXPORTACAO').AsString;
    lModel.ID                       := lQry.FieldByName('ID').AsString;
    lModel.NUMERO_CF                := lQry.FieldByName('NUMERO_CF').AsString;
    lModel.CF_ABERTO                := lQry.FieldByName('CF_ABERTO').AsString;
    lModel.NAO_FISCAL_ABERTO        := lQry.FieldByName('NAO_FISCAL_ABERTO').AsString;
    lModel.HORA_PED                 := lQry.FieldByName('HORA_PED').AsString;
    lModel.TIPO_FRETE               := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.VALOR_PAGO               := lQry.FieldByName('VALOR_PAGO').AsString;
    lModel.STATUS                   := lQry.FieldByName('STATUS').AsString;
    lModel.DATA_FATURADO            := lQry.FieldByName('DATA_FATURADO').AsString;
    lModel.NUMERO_NF                := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.VALOR_SUFRAMA            := lQry.FieldByName('VALOR_SUFRAMA').AsString;
    lModel.CARGA_ID                 := lQry.FieldByName('CARGA_ID').AsString;
    lModel.LISTA_NOIVA_ID           := lQry.FieldByName('LISTA_NOIVA_ID').AsString;
    lModel.VALOR_RESTITUICAO        := lQry.FieldByName('VALOR_RESTITUICAO').AsString;
    lModel.SYSTIME                  := lQry.FieldByName('SYSTIME').AsString;
    lModel.DESCONTO_DRG             := lQry.FieldByName('DESCONTO_DRG').AsString;
    lModel.STATUS_ID                := lQry.FieldByName('STATUS_ID').AsString;
    lModel.PRECO_VENDA_ID           := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.RNTRC                    := lQry.FieldByName('RNTRC').AsString;
    lModel.PLACA                    := lQry.FieldByName('PLACA').AsString;
    lModel.PESO_LIQUIDO             := lQry.FieldByName('PESO_LIQUIDO').AsString;
    lModel.PESO_BRUTO               := lQry.FieldByName('PESO_BRUTO').AsString;
    lModel.QTDE_VOLUME              := lQry.FieldByName('QTDE_VOLUME').AsString;
    lModel.ESPECIE_VOLUME           := lQry.FieldByName('ESPECIE_VOLUME').AsString;
    lModel.UF_TRANSPORTADORA        := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
    lModel.PRODUCAO_ID              := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.REGIAO_ID                := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.ORDEM                    := lQry.FieldByName('ORDEM').AsString;
    lModel.CNPJ_CPF_CONSUMIDOR      := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
    lModel.PEDIDO_COMPRA            := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.DATA_FINALIZADO          := lQry.FieldByName('DATA_FINALIZADO').AsString;
    lModel.NUMERO_SENHA             := lQry.FieldByName('NUMERO_SENHA').AsString;
    lModel.ARQUITETO_ID             := lQry.FieldByName('ARQUITETO_ID').AsString;
    lModel.ARQUITETO_COMISSAO       := lQry.FieldByName('ARQUITETO_COMISSAO').AsString;
    lModel.LOTE_CARGA_ID            := lQry.FieldByName('LOTE_CARGA_ID').AsString;
    lModel.ENTREGA                  := lQry.FieldByName('ENTREGA').AsString;
    lModel.VALOR_DESPESA_VENDA      := lQry.FieldByName('VALOR_DESPESA_VENDA').AsString;
    lModel.ENTREGA_ENDERECO         := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
    lModel.ENTREGA_COMPLEMENTO      := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
    lModel.ENTREGA_NUMERO           := lQry.FieldByName('ENTREGA_NUMERO').AsString;
    lModel.ENTREGA_BAIRRO           := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
    lModel.ENTREGA_CIDADE           := lQry.FieldByName('ENTREGA_CIDADE').AsString;
    lModel.ENTREGA_CEP              := lQry.FieldByName('ENTREGA_CEP').AsString;
    lModel.ENTREGA_UF               := lQry.FieldByName('ENTREGA_UF').AsString;
    lModel.ENTREGA_COD_MUNICIPIO    := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
    lModel.ENTREGA_TELEFONE         := lQry.FieldByName('ENTREGA_TELEFONE').AsString;
    lModel.ENTREGA_CELULAR          := lQry.FieldByName('ENTREGA_CELULAR').AsString;
    lModel.ENTREGA_OBSERVACAO       := lQry.FieldByName('ENTREGA_OBSERVACAO').AsString;
    lModel.ENTREGA_HORA             := lQry.FieldByName('ENTREGA_HORA').AsString;
    lModel.ENTREGA_CONTATO          := lQry.FieldByName('ENTREGA_CONTATO').AsString;
    lModel.ENTREGA_AGENDA_ID        := lQry.FieldByName('ENTREGA_AGENDA_ID').AsString;
    lModel.ENTREGA_REGIAO_ID        := lQry.FieldByName('ENTREGA_REGIAO_ID').AsString;
    lModel.ENTREGADOR_ID            := lQry.FieldByName('ENTREGADOR_ID').AsString;
    lModel.FATURA_ID                := lQry.FieldByName('FATURA_ID').AsString;
    lModel.DATAHORA_IMPRESSO        := lQry.FieldByName('DATAHORA_IMPRESSO').AsString;
    lModel.CTR_IMPRESSAO_ITENS      := lQry.FieldByName('CTR_IMPRESSAO_ITENS').AsString;
    lModel.RESERVADO                := lQry.FieldByName('RESERVADO').AsString;
    lModel.PATRIMONIO_OBSERVACAO    := lQry.FieldByName('PATRIMONIO_OBSERVACAO').AsString;
    lModel.OBS_GERAL                := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.SMS                      := lQry.FieldByName('SMS').AsString;
    lModel.IMP_TICKET               := lQry.FieldByName('IMP_TICKET').AsString;
    lModel.COMANDA                  := lQry.FieldByName('COMANDA').AsString;
    lModel.VALOR_TAXA_SERVICO       := lQry.FieldByName('VALOR_TAXA_SERVICO').AsString;
    lModel.VFCPUFDEST               := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.VICMSUFDEST              := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.VICMSUFREMET             := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.ENTREGUE                 := lQry.FieldByName('ENTREGUE').AsString;
    lModel.INDICACAO_ID             := lQry.FieldByName('INDICACAO_ID').AsString;
    lModel.ZERAR_ST                 := lQry.FieldByName('ZERAR_ST').AsString;
    lModel.PEDIDO_VIDRACARIA        := lQry.FieldByName('PEDIDO_VIDRACARIA').AsString;
    lModel.CHAVE_XML_NF             := lQry.FieldByName('CHAVE_XML_NF').AsString;
    lModel.ARQUIVO_XML_NF           := lQry.FieldByName('ARQUIVO_XML_NF').AsString;
    lModel.GERENTE_ID               := lQry.FieldByName('GERENTE_ID').AsString;
    lModel.ENTRADA_PORTADOR_ID      := lQry.FieldByName('ENTRADA_PORTADOR_ID').AsString;
    lModel.DATA_COTACAO             := lQry.FieldByName('DATA_COTACAO').AsString;
    lModel.TIPO_COMISSAO            := lQry.FieldByName('TIPO_COMISSAO').AsString;
    lModel.GERENTE_TIPO_COMISSAO    := lQry.FieldByName('GERENTE_TIPO_COMISSAO').AsString;
    lModel.POS_VENDA                := lQry.FieldByName('POS_VENDA').AsString;
    lModel.VLR_GARANTIA             := lQry.FieldByName('VLR_GARANTIA').AsString;
    lModel.WEB_PEDIDO_ID            := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    lModel.LACA_OU_GLASS            := lQry.FieldByName('LACA_OU_GLASS').AsString;
    lModel.VFCPST                   := lQry.FieldByName('VFCPST').AsString;
    lModel.MONTAGEM_DATA            := lQry.FieldByName('MONTAGEM_DATA').AsString;
    lModel.MONTAGEM_HORA            := lQry.FieldByName('MONTAGEM_HORA').AsString;
    lModel.FORM                     := lQry.FieldByName('FORM').AsString;
    lModel.VICMSDESON               := lQry.FieldByName('VICMSDESON').AsString;
    lModel.QTDEITENS                := lQry.FieldByName('QTDEITENS').AsString;
    lModel.CTR_ENVIO_PEDIDO         := lQry.FieldByName('CTR_ENVIO_PEDIDO').AsString;
    lModel.CTR_ENVIO_BOLETO         := lQry.FieldByName('CTR_ENVIO_BOLETO').AsString;
    lModel.CTR_ENVIO_NFE            := lQry.FieldByName('CTR_ENVIO_NFE').AsString;
    lModel.DATAHORA_COLETA          := lQry.FieldByName('DATAHORA_COLETA').AsString;
    lModel.DATAHORA_RETIRADA        := lQry.FieldByName('DATAHORA_RETIRADA').AsString;
    lModel.CFOP_NF                  := lQry.FieldByName('CFOP_NF').AsString;
    lModel.SEGURO_PRESTAMISTA_VALOR := lQry.FieldByName('SEGURO_PRESTAMISTA_VALOR').AsString;
    lModel.SEGURO_PRESTAMISTA_CUSTO := lQry.FieldByName('SEGURO_PRESTAMISTA_CUSTO').AsString;

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
  FPedidoVendasLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
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
    pPedidoVendaModel.NUMERO_PED := vIConexao.Generetor('GEN_PEDIDOVENDA');
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
  modelo: TPedidoVendaModel;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoVendasLista := TCollections.CreateList<TPedidoVendaModel>(true);
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
    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPedidoVendaModel.Create(vIConexao);
      FPedidoVendasLista.Add(modelo);
      modelo.ID                        := lQry.FieldByName('ID').AsString;
      modelo.NUMERO_PED                := lQry.FieldByName('NUMERO_PED').AsString;
      modelo.CODIGO_CLI                := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.CODIGO_VEN                := lQry.FieldByName('CODIGO_VEN').AsString;
      modelo.CODIGO_PORT               := lQry.FieldByName('CODIGO_PORT').AsString;
      modelo.CODIGO_TIP                := lQry.FieldByName('CODIGO_TIP').AsString;
      modelo.DATA_PED                  := lQry.FieldByName('DATA_PED').AsString;
      modelo.VALOR_PED                 := lQry.FieldByName('VALOR_PED').AsString;
      modelo.DESC_PED                  := lQry.FieldByName('DESC_PED').AsString;
      modelo.ACRES_PED                 := lQry.FieldByName('ACRES_PED').AsString;
      modelo.TOTAL_PED                 := lQry.FieldByName('TOTAL_PED').AsString;
      modelo.USUARIO_PED               := lQry.FieldByName('USUARIO_PED').AsString;
      modelo.NUMERO_ORC                := lQry.FieldByName('NUMERO_ORC').AsString;
      modelo.INFORMACOES_PED           := lQry.FieldByName('INFORMACOES_PED').AsString;
      modelo.TIPO_PED                  := lQry.FieldByName('TIPO_PED').AsString;
      modelo.INDCE_PED                 := lQry.FieldByName('INDCE_PED').AsString;
      modelo.CFOP_ID                   := lQry.FieldByName('CFOP_ID').AsString;
      modelo.PRIMEIROVENC_PED          := lQry.FieldByName('PRIMEIROVENC_PED').AsString;
      modelo.VALORENTADA_PED           := lQry.FieldByName('VALORENTADA_PED').AsString;
      modelo.PARCELAS_PED              := lQry.FieldByName('PARCELAS_PED').AsString;
      modelo.PARCELA_PED               := lQry.FieldByName('PARCELA_PED').AsString;
      modelo.STATUS_PED                := lQry.FieldByName('STATUS_PED').AsString;
      modelo.TABJUROS_PED              := lQry.FieldByName('TABJUROS_PED').AsString;
      modelo.CONTATO_PED               := lQry.FieldByName('CONTATO_PED').AsString;
      modelo.DESCONTO_PED              := lQry.FieldByName('DESCONTO_PED').AsString;
      modelo.CTR_IMPRESSAO_PED         := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
      modelo.FRETE_PED                 := lQry.FieldByName('FRETE_PED').AsString;
      modelo.CONDICOES_PAG             := lQry.FieldByName('CONDICOES_PAG').AsString;
      modelo.TOTAL1_PED                := lQry.FieldByName('TOTAL1_PED').AsString;
      modelo.TOTAL2_PED                := lQry.FieldByName('TOTAL2_PED').AsString;
      modelo.LOCAL_PED                 := lQry.FieldByName('LOCAL_PED').AsString;
      modelo.TELEVENDA_PED             := lQry.FieldByName('TELEVENDA_PED').AsString;
      modelo.PESO_PED                  := lQry.FieldByName('PESO_PED').AsString;
      modelo.PRIMEIROVENC2_PED         := lQry.FieldByName('PRIMEIROVENC2_PED').AsString;
      modelo.PARCELAS2_PED             := lQry.FieldByName('PARCELAS2_PED').AsString;
      modelo.VALOR_IPI                 := lQry.FieldByName('VALOR_IPI').AsString;
      modelo.CONDICOES2_PAG            := lQry.FieldByName('CONDICOES2_PAG').AsString;
      modelo.LOJA                      := lQry.FieldByName('LOJA').AsString;
      modelo.DOLAR                     := lQry.FieldByName('DOLAR').AsString;
      modelo.CTR_EXPORTACAO            := lQry.FieldByName('CTR_EXPORTACAO').AsString;
      modelo.ID                        := lQry.FieldByName('ID').AsString;
      modelo.NUMERO_CF                 := lQry.FieldByName('NUMERO_CF').AsString;
      modelo.CF_ABERTO                 := lQry.FieldByName('CF_ABERTO').AsString;
      modelo.NAO_FISCAL_ABERTO         := lQry.FieldByName('NAO_FISCAL_ABERTO').AsString;
      modelo.HORA_PED                  := lQry.FieldByName('HORA_PED').AsString;
      modelo.TIPO_FRETE                := lQry.FieldByName('TIPO_FRETE').AsString;
      modelo.VALOR_PAGO                := lQry.FieldByName('VALOR_PAGO').AsString;
      modelo.STATUS                    := lQry.FieldByName('STATUS').AsString;
      modelo.DATA_FATURADO             := lQry.FieldByName('DATA_FATURADO').AsString;
      modelo.NUMERO_NF                 := lQry.FieldByName('NUMERO_NF').AsString;
      modelo.VALOR_SUFRAMA             := lQry.FieldByName('VALOR_SUFRAMA').AsString;
      modelo.CARGA_ID                  := lQry.FieldByName('CARGA_ID').AsString;
      modelo.LISTA_NOIVA_ID            := lQry.FieldByName('LISTA_NOIVA_ID').AsString;
      modelo.VALOR_RESTITUICAO         := lQry.FieldByName('VALOR_RESTITUICAO').AsString;
      modelo.SYSTIME                   := lQry.FieldByName('SYSTIME').AsString;
      modelo.DESCONTO_DRG              := lQry.FieldByName('DESCONTO_DRG').AsString;
      modelo.STATUS_ID                 := lQry.FieldByName('STATUS_ID').AsString;
      modelo.PRECO_VENDA_ID            := lQry.FieldByName('PRECO_VENDA_ID').AsString;
      modelo.RNTRC                     := lQry.FieldByName('RNTRC').AsString;
      modelo.PLACA                     := lQry.FieldByName('PLACA').AsString;
      modelo.PESO_LIQUIDO              := lQry.FieldByName('PESO_LIQUIDO').AsString;
      modelo.PESO_BRUTO                := lQry.FieldByName('PESO_BRUTO').AsString;
      modelo.QTDE_VOLUME               := lQry.FieldByName('QTDE_VOLUME').AsString;
      modelo.ESPECIE_VOLUME            := lQry.FieldByName('ESPECIE_VOLUME').AsString;
      modelo.UF_TRANSPORTADORA         := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
      modelo.PRODUCAO_ID               := lQry.FieldByName('PRODUCAO_ID').AsString;
      modelo.REGIAO_ID                 := lQry.FieldByName('REGIAO_ID').AsString;
      modelo.ORDEM                     := lQry.FieldByName('ORDEM').AsString;
      modelo.CNPJ_CPF_CONSUMIDOR       := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
      modelo.PEDIDO_COMPRA             := lQry.FieldByName('PEDIDO_COMPRA').AsString;
      modelo.DATA_FINALIZADO           := lQry.FieldByName('DATA_FINALIZADO').AsString;
      modelo.NUMERO_SENHA              := lQry.FieldByName('NUMERO_SENHA').AsString;
      modelo.ARQUITETO_ID              := lQry.FieldByName('ARQUITETO_ID').AsString;
      modelo.ARQUITETO_COMISSAO        := lQry.FieldByName('ARQUITETO_COMISSAO').AsString;
      modelo.LOTE_CARGA_ID             := lQry.FieldByName('LOTE_CARGA_ID').AsString;
      modelo.ENTREGA                   := lQry.FieldByName('ENTREGA').AsString;
      modelo.VALOR_DESPESA_VENDA       := lQry.FieldByName('VALOR_DESPESA_VENDA').AsString;
      modelo.ENTREGA_ENDERECO          := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
      modelo.ENTREGA_COMPLEMENTO       := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
      modelo.ENTREGA_NUMERO            := lQry.FieldByName('ENTREGA_NUMERO').AsString;
      modelo.ENTREGA_BAIRRO            := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
      modelo.ENTREGA_CIDADE            := lQry.FieldByName('ENTREGA_CIDADE').AsString;
      modelo.ENTREGA_CEP               := lQry.FieldByName('ENTREGA_CEP').AsString;
      modelo.ENTREGA_UF                := lQry.FieldByName('ENTREGA_UF').AsString;
      modelo.ENTREGA_COD_MUNICIPIO     := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
      modelo.ENTREGA_TELEFONE          := lQry.FieldByName('ENTREGA_TELEFONE').AsString;
      modelo.ENTREGA_CELULAR           := lQry.FieldByName('ENTREGA_CELULAR').AsString;
      modelo.ENTREGA_OBSERVACAO        := lQry.FieldByName('ENTREGA_OBSERVACAO').AsString;
      modelo.ENTREGA_HORA              := lQry.FieldByName('ENTREGA_HORA').AsString;
      modelo.ENTREGA_CONTATO           := lQry.FieldByName('ENTREGA_CONTATO').AsString;
      modelo.ENTREGA_AGENDA_ID         := lQry.FieldByName('ENTREGA_AGENDA_ID').AsString;
      modelo.ENTREGA_REGIAO_ID         := lQry.FieldByName('ENTREGA_REGIAO_ID').AsString;
      modelo.ENTREGADOR_ID             := lQry.FieldByName('ENTREGADOR_ID').AsString;
      modelo.FATURA_ID                 := lQry.FieldByName('FATURA_ID').AsString;
      modelo.DATAHORA_IMPRESSO         := lQry.FieldByName('DATAHORA_IMPRESSO').AsString;
      modelo.CTR_IMPRESSAO_ITENS       := lQry.FieldByName('CTR_IMPRESSAO_ITENS').AsString;
      modelo.RESERVADO                 := lQry.FieldByName('RESERVADO').AsString;
      modelo.PATRIMONIO_OBSERVACAO     := lQry.FieldByName('PATRIMONIO_OBSERVACAO').AsString;
      modelo.OBS_GERAL                 := lQry.FieldByName('OBS_GERAL').AsString;
      modelo.SMS                       := lQry.FieldByName('SMS').AsString;
      modelo.IMP_TICKET                := lQry.FieldByName('IMP_TICKET').AsString;
      modelo.COMANDA                   := lQry.FieldByName('COMANDA').AsString;
      modelo.VALOR_TAXA_SERVICO        := lQry.FieldByName('VALOR_TAXA_SERVICO').AsString;
      modelo.VFCPUFDEST                := lQry.FieldByName('VFCPUFDEST').AsString;
      modelo.VICMSUFDEST               := lQry.FieldByName('VICMSUFDEST').AsString;
      modelo.VICMSUFREMET              := lQry.FieldByName('VICMSUFREMET').AsString;
      modelo.ENTREGUE                  := lQry.FieldByName('ENTREGUE').AsString;
      modelo.INDICACAO_ID              := lQry.FieldByName('INDICACAO_ID').AsString;
      modelo.ZERAR_ST                  := lQry.FieldByName('ZERAR_ST').AsString;
      modelo.PEDIDO_VIDRACARIA         := lQry.FieldByName('PEDIDO_VIDRACARIA').AsString;
      modelo.CHAVE_XML_NF              := lQry.FieldByName('CHAVE_XML_NF').AsString;
      modelo.ARQUIVO_XML_NF            := lQry.FieldByName('ARQUIVO_XML_NF').AsString;
      modelo.GERENTE_ID                := lQry.FieldByName('GERENTE_ID').AsString;
      modelo.ENTRADA_PORTADOR_ID       := lQry.FieldByName('ENTRADA_PORTADOR_ID').AsString;
      modelo.DATA_COTACAO              := lQry.FieldByName('DATA_COTACAO').AsString;
      modelo.TIPO_COMISSAO             := lQry.FieldByName('TIPO_COMISSAO').AsString;
      modelo.GERENTE_TIPO_COMISSAO     := lQry.FieldByName('GERENTE_TIPO_COMISSAO').AsString;
      modelo.POS_VENDA                 := lQry.FieldByName('POS_VENDA').AsString;
      modelo.VLR_GARANTIA              := lQry.FieldByName('VLR_GARANTIA').AsString;
      modelo.WEB_PEDIDO_ID             := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
      modelo.LACA_OU_GLASS             := lQry.FieldByName('LACA_OU_GLASS').AsString;
      modelo.VFCPST                    := lQry.FieldByName('VFCPST').AsString;
      modelo.MONTAGEM_DATA             := lQry.FieldByName('MONTAGEM_DATA').AsString;
      modelo.MONTAGEM_HORA             := lQry.FieldByName('MONTAGEM_HORA').AsString;
      modelo.FORM                      := lQry.FieldByName('FORM').AsString;
      modelo.VICMSDESON                := lQry.FieldByName('VICMSDESON').AsString;
      modelo.QTDEITENS                 := lQry.FieldByName('QTDEITENS').AsString;
      modelo.CTR_ENVIO_PEDIDO          := lQry.FieldByName('CTR_ENVIO_PEDIDO').AsString;
      modelo.CTR_ENVIO_BOLETO          := lQry.FieldByName('CTR_ENVIO_BOLETO').AsString;
      modelo.CTR_ENVIO_NFE             := lQry.FieldByName('CTR_ENVIO_NFE').AsString;
      modelo.DATAHORA_COLETA           := lQry.FieldByName('DATAHORA_COLETA').AsString;
      modelo.DATAHORA_RETIRADA         := lQry.FieldByName('DATAHORA_RETIRADA').AsString;
      modelo.FANTASIA_CLI              := lQry.FieldByName('FANTASIA_CLI').AsString;
      modelo.NOME_VENDEDOR             := lQry.FieldByName('NOME_FUN').AsString;
      modelo.CFOP_NF                   := lQry.FieldByName('CFOP_NF').AsString;
      modelo.SEGURO_PRESTAMISTA_CUSTO  := lQry.FieldByName('SEGURO_PRESTAMISTA_CUSTO').AsString;
      modelo.SEGURO_PRESTAMISTA_VALOR  := lQry.FieldByName('SEGURO_PRESTAMISTA_VALOR').AsString;

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
          '     p.desconto_ped,                                    '+#13+
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
    lPedidoVendaModel.DESCONTO_PED   :=  lQry.FieldByName('DESCONTO_PED').AsString;
    lPedidoVendaModel.TOTAL_PED      :=  lQry.FieldByName('TOTAL_PED').AsString;
    lPedidoVendaModel.STATUS_PED     :=  lQry.FieldByName('STATUS_PED').AsString;
    lPedidoVendaModel.NOME_VENDEDOR  :=  lQry.FieldByName('NOME_FUN').AsString;
    Result := lPedidoVendaModel;
  finally
    lQry.Free;
  end;
end;

function TPedidoVendaDao.obterComprasRealizadas(pCliente: String): IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL :=  '    SELECT '+lPaginacao+'                                                                   '+SLineBreak+
              '        P.NUMERO_PED,                                                                        '+SLineBreak+
              '        PEDIDOVENDA.DATA_PED,                                                                '+SLineBreak+
              '        PR.CODIGO_PRO,                                                                       '+SLineBreak+
              '        PR.NOME_PRO,                                                                         '+SLineBreak+
              '        CAST(P.QTDE_CALCULADA AS FLOAT) AS QTDE,                                             '+SLineBreak+
              '        (P.VALORUNITARIO_PED-((PEDIDOVENDA.DESCONTO_PED/100)*P.VALORUNITARIO_PED)) AS VALOR, '+SLineBreak+
              '        ''PED'' AS TIPO,                                                                     '+SLineBreak+
              '        PEDIDOVENDA.NUMERO_NF,                                                               '+SLineBreak+
              '        PEDIDOVENDA.DATA_FATURADO,                                                           '+SLineBreak+
              '        CAST('''' AS VARCHAR (6)) AS DEVOLUCAO,                                              '+SLineBreak+
              '        F.NOME_FUN,                                                                          '+SLineBreak+
              '        PEDIDOVENDA.CONTATO_PED AS CONTATO,                                                  '+SLineBreak+
              '        PR.CODLISTA_COD,                                                                     '+SLineBreak+
              '        PR.BARRAS_PRO,                                                                       '+SLineBreak+
              '        PR.REFERENCIA_NEW,                                                                   '+SLineBreak+
              '        T.NOME_TV,                                                                           '+SLineBreak+
              '        E.LOJA                                                                               '+SLineBreak+
              '    FROM                                                                                     '+SLineBreak+
              '        PEDIDOITENS P                                                                        '+SLineBreak+
              '    INNER JOIN PEDIDOVENDA ON                                                                '+SLineBreak+
              '        PEDIDOVENDA.NUMERO_PED = P.NUMERO_PED                                                '+SLineBreak+
              '    INNER JOIN PRODUTO PR ON                                                                 '+SLineBreak+
              '        PR.CODIGO_PRO = P.CODIGO_PRO                                                         '+SLineBreak+
              '    INNER JOIN FUNCIONARIO F ON                                                              '+SLineBreak+
              '        F.CODIGO_FUN = PEDIDOVENDA.CODIGO_VEN                                                '+SLineBreak+
              '    LEFT JOIN TIPOVENDA T ON                                                                 '+SLineBreak+
              '        PEDIDOVENDA.CODIGO_TIP = T.CODIGO_TV                                                 '+SLineBreak+
              '    LEFT JOIN EMPRESA E ON                                                                   '+SLineBreak+
              '        1=1                                                                                  '+SLineBreak+
              '    WHERE                                                                                    '+SLineBreak+
              '        PEDIDOVENDA.CODIGO_CLI = '+ QuotedStr(pCliente);

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

function TPedidoVendaDao.ObterProdutoBalanca(pBarrasProduto: String): String;
var
  lQry           : TFDQuery;
  lSQL           : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;
  Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);
  try

    if (Length(pBarrasProduto) = 13) and (Copy(pBarrasProduto, 1, 1) = '1') then
    begin
      lSQL := 'SELECT BARRAS_PRO FROM PRODUTO P WHERE P.USAR_BALANCA = ''S'' AND P.CODIGO_PRO = '+ QuotedStr(((Copy(pBarrasProduto, StrToInt(lConfiguracoes.objeto.valorTag('BALANCA_COPY_INI_PRODUTO', '2', tvString)), StrToInt(lConfiguracoes.objeto.valorTag('BALANCA_COPY_FIM_PRODUTO', '6', tvString))))));
      lQry.Open(lSQL);
    end
    else if (Length(pBarrasProduto) = 13) and (Copy(pBarrasProduto, 1, 1) = '2') then
    begin
      lSQL := 'SELECT BARRAS_PRO FROM PRODUTO P WHERE P.USAR_BALANCA = ''S'' AND P.BARRAS_PRO = '+ QuotedStr(IntToStr(StrToInt(Copy(pBarrasProduto,StrToInt(lConfiguracoes.objeto.valorTag('BALANCA_COPY_INI_PRODUTO', '2', tvString)), StrToInt(lConfiguracoes.objeto.valorTag('BALANCA_COPY_FIM_PRODUTO', '6', tvString))))));
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

procedure TPedidoVendaDao.SetPedidoVendasLista;
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
  lTabela : IFDDataset;
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
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPedidoVendaModel).AsString))
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
              .ExecSQLScalar('select status from pedidovenda where numero_ped = '+ QuotedStr(pId));
end;
end.
