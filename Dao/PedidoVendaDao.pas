unit PedidoVendaDao;
interface
uses
  PedidoVendaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Terasoft.Framework.ObjectIface,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao,
  Spring.Collections,
  Terasoft.Utils;

type
  TPedidoVendaDao = class;
  ITPedidoVendaDao=IObject<TPedidoVendaDao>;

  TPedidoVendaDao = class
  private
    [weak] mySelf: ITPedidoVendaDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FPedidoVendasLista: IList<ITPedidoVendaModel>;
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
    procedure SetPedidoVendasLista(const Value: ILIst<ITPedidoVendaModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;
    procedure SetIDRecordView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPedidoVendaModel: ITPedidoVendaModel);

  public
    constructor _Create(pConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPedidoVendaDao;

    property PedidoVendasLista: IList<ITPedidoVendaModel> read FPedidoVendasLista write SetPedidoVendasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pPedidoVendaModel: ITPedidoVendaModel): String;
    function alterar(pPedidoVendaModel: ITPedidoVendaModel): String;
    function excluir(pPedidoVendaModel: ITPedidoVendaModel): String;

    procedure obterLista;

    function ObterProdutoBalanca(pBarrasProduto: String): String;

    function obterPedido(pNumeroPedido: String): ITPedidoVendaModel;
    function carregaClasse(pId: String): ITPedidoVendaModel;
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
  lValor_ped,
  lDesc_ped,
  lAcres_ped   : Double;
  modelo: ITPedidoVendaModel;

begin
  lQry := vIConexao.CriarQuery;
  FPedidoVendasLista := TCollections.CreateList<ITPedidoVendaModel>;

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
      '         i.quantidade_ped * i.valorunitario_ped / p.valor_ped * p.acres_ped acrescimo_item,        '+SLineBreak+
      '         i.valor_acrescimo                                                                         '+SLineBreak+
      '   from pedidovenda p                                                                              '+SLineBreak+
      '   left join pedidoitens i on i.numero_ped = p.numero_ped                                          '+SLineBreak+
      '   left join clientes c on c.codigo_cli = p.codigo_cli                                             '+SLineBreak+
      '  where coalesce(i.tipo_venda, ''LJ'') = ''LJ''                                                    '+SLineBreak+
      '    and p.numero_ped = '+QuotedStr(pNumeroPedido);

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPedidoVendaModel.getNewIface(vIConexao);
      FPedidoVendasLista.Add(modelo);

      modelo.objeto.PEDIDOITENS_ID    := lQry.FieldByName('PEDIDOITENS_ID').AsString;
      modelo.objeto.VALOR_PED         := lQry.FieldByName('VALOR_PED').AsString;
      modelo.objeto.DESC_PED          := lQry.FieldByName('DESC_PED').AsString;
      modelo.objeto.ACRES_PED         := lQry.FieldByName('ACRES_PED').AsString;
      modelo.objeto.UF_CLI            := lQry.FieldByName('UF_CLI').AsString;
      modelo.objeto.CODIGO_PRO        := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.objeto.QUANTIDADE_PED    := lQry.FieldByName('QUANTIDADE_PED').AsString;
      modelo.objeto.VALORUNITARIO_PED := lQry.FieldByName('VALORUNITARIO_PED').AsString;
      modelo.objeto.VALOR_ACRESCIMO   := lQry.FieldByName('VALOR_ACRESCIMO').AsString;
      lValor_ped := lValor_ped   + lQry.FieldByName('TOTAL_PRODUTO').AsFloat;
      lDesc_ped  := lDesc_ped    + lQry.FieldByName('DESCONTO_ITEM').AsFloat;
      lAcres_ped := lAcres_ped   + lQry.FieldByName('ACRESCIMO_ITEM').AsFloat;

      lQry.Next;
    end;

    for modelo in fPedidoVendasLista do
    begin
      modelo.objeto.VALOR_PED         := FloatToStr(lValor_ped);
      modelo.objeto.DESC_PED          := FloatToStr(lDesc_ped);
      modelo.objeto.ACRES_PED         := FloatToStr(lAcres_ped);
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

function TPedidoVendaDao.carregaClasse(pId: String): ITPedidoVendaModel;
var
  lQry: TFDQuery;
  lModel: ITPedidoVendaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPedidoVendaModel.getNewIface(vIConexao);
  Result   := lModel;
  try
    lQry.Open('select * from pedidovenda where numero_ped = '+pId);
    if lQry.IsEmpty then
      Exit;
    lModel.objeto.NUMERO_PED               := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.objeto.CODIGO_CLI               := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.objeto.CODIGO_VEN               := lQry.FieldByName('CODIGO_VEN').AsString;
    lModel.objeto.CODIGO_PORT              := lQry.FieldByName('CODIGO_PORT').AsString;
    lModel.objeto.CODIGO_TIP               := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.objeto.DATA_PED                 := lQry.FieldByName('DATA_PED').AsString;
    lModel.objeto.VALOR_PED                := lQry.FieldByName('VALOR_PED').AsString;
    lModel.objeto.DESC_PED                 := lQry.FieldByName('DESC_PED').AsString;
    lModel.objeto.ACRES_PED                := lQry.FieldByName('ACRES_PED').AsString;
    lModel.objeto.TOTAL_PED                := lQry.FieldByName('TOTAL_PED').AsString;
    lModel.objeto.USUARIO_PED              := lQry.FieldByName('USUARIO_PED').AsString;
    lModel.objeto.NUMERO_ORC               := lQry.FieldByName('NUMERO_ORC').AsString;
    lModel.objeto.INFORMACOES_PED          := lQry.FieldByName('INFORMACOES_PED').AsString;
    lModel.objeto.TIPO_PED                 := lQry.FieldByName('TIPO_PED').AsString;
    lModel.objeto.INDCE_PED                := lQry.FieldByName('INDCE_PED').AsString;
    lModel.objeto.CFOP_ID                  := lQry.FieldByName('CFOP_ID').AsString;
    lModel.objeto.PRIMEIROVENC_PED         := lQry.FieldByName('PRIMEIROVENC_PED').AsString;
    lModel.objeto.VALORENTADA_PED          := lQry.FieldByName('VALORENTADA_PED').AsString;
    lModel.objeto.PARCELAS_PED             := lQry.FieldByName('PARCELAS_PED').AsString;
    lModel.objeto.PARCELA_PED              := lQry.FieldByName('PARCELA_PED').AsString;
    lModel.objeto.STATUS_PED               := lQry.FieldByName('STATUS_PED').AsString;
    lModel.objeto.TABJUROS_PED             := lQry.FieldByName('TABJUROS_PED').AsString;
    lModel.objeto.CONTATO_PED              := lQry.FieldByName('CONTATO_PED').AsString;
    lModel.objeto.DESCONTO_PED             := lQry.FieldByName('DESCONTO_PED').AsString;
    lModel.objeto.CTR_IMPRESSAO_PED        := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
    lModel.objeto.FRETE_PED                := lQry.FieldByName('FRETE_PED').AsString;
    lModel.objeto.CONDICOES_PAG            := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.objeto.TOTAL1_PED               := lQry.FieldByName('TOTAL1_PED').AsString;
    lModel.objeto.TOTAL2_PED               := lQry.FieldByName('TOTAL2_PED').AsString;
    lModel.objeto.LOCAL_PED                := lQry.FieldByName('LOCAL_PED').AsString;
    lModel.objeto.TELEVENDA_PED            := lQry.FieldByName('TELEVENDA_PED').AsString;
    lModel.objeto.PESO_PED                 := lQry.FieldByName('PESO_PED').AsString;
    lModel.objeto.PRIMEIROVENC2_PED        := lQry.FieldByName('PRIMEIROVENC2_PED').AsString;
    lModel.objeto.PARCELAS2_PED            := lQry.FieldByName('PARCELAS2_PED').AsString;
    lModel.objeto.VALOR_IPI                := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.objeto.CONDICOES2_PAG           := lQry.FieldByName('CONDICOES2_PAG').AsString;
    lModel.objeto.LOJA                     := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.DOLAR                    := lQry.FieldByName('DOLAR').AsString;
    lModel.objeto.CTR_EXPORTACAO           := lQry.FieldByName('CTR_EXPORTACAO').AsString;
    lModel.objeto.ID                       := lQry.FieldByName('ID').AsString;
    lModel.objeto.NUMERO_CF                := lQry.FieldByName('NUMERO_CF').AsString;
    lModel.objeto.CF_ABERTO                := lQry.FieldByName('CF_ABERTO').AsString;
    lModel.objeto.NAO_FISCAL_ABERTO        := lQry.FieldByName('NAO_FISCAL_ABERTO').AsString;
    lModel.objeto.HORA_PED                 := lQry.FieldByName('HORA_PED').AsString;
    lModel.objeto.TIPO_FRETE               := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.objeto.VALOR_PAGO               := lQry.FieldByName('VALOR_PAGO').AsString;
    lModel.objeto.STATUS                   := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.DATA_FATURADO            := lQry.FieldByName('DATA_FATURADO').AsString;
    lModel.objeto.NUMERO_NF                := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.objeto.VALOR_SUFRAMA            := lQry.FieldByName('VALOR_SUFRAMA').AsString;
    lModel.objeto.CARGA_ID                 := lQry.FieldByName('CARGA_ID').AsString;
    lModel.objeto.LISTA_NOIVA_ID           := lQry.FieldByName('LISTA_NOIVA_ID').AsString;
    lModel.objeto.VALOR_RESTITUICAO        := lQry.FieldByName('VALOR_RESTITUICAO').AsString;
    lModel.objeto.SYSTIME                  := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.DESCONTO_DRG             := lQry.FieldByName('DESCONTO_DRG').AsString;
    lModel.objeto.STATUS_ID                := lQry.FieldByName('STATUS_ID').AsString;
    lModel.objeto.PRECO_VENDA_ID           := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.objeto.RNTRC                    := lQry.FieldByName('RNTRC').AsString;
    lModel.objeto.PLACA                    := lQry.FieldByName('PLACA').AsString;
    lModel.objeto.PESO_LIQUIDO             := lQry.FieldByName('PESO_LIQUIDO').AsString;
    lModel.objeto.PESO_BRUTO               := lQry.FieldByName('PESO_BRUTO').AsString;
    lModel.objeto.QTDE_VOLUME              := lQry.FieldByName('QTDE_VOLUME').AsString;
    lModel.objeto.ESPECIE_VOLUME           := lQry.FieldByName('ESPECIE_VOLUME').AsString;
    lModel.objeto.UF_TRANSPORTADORA        := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
    lModel.objeto.PRODUCAO_ID              := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.objeto.REGIAO_ID                := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.objeto.ORDEM                    := lQry.FieldByName('ORDEM').AsString;
    lModel.objeto.CNPJ_CPF_CONSUMIDOR      := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
    lModel.objeto.PEDIDO_COMPRA            := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.objeto.DATA_FINALIZADO          := lQry.FieldByName('DATA_FINALIZADO').AsString;
    lModel.objeto.NUMERO_SENHA             := lQry.FieldByName('NUMERO_SENHA').AsString;
    lModel.objeto.ARQUITETO_ID             := lQry.FieldByName('ARQUITETO_ID').AsString;
    lModel.objeto.ARQUITETO_COMISSAO       := lQry.FieldByName('ARQUITETO_COMISSAO').AsString;
    lModel.objeto.LOTE_CARGA_ID            := lQry.FieldByName('LOTE_CARGA_ID').AsString;
    lModel.objeto.ENTREGA                  := lQry.FieldByName('ENTREGA').AsString;
    lModel.objeto.VALOR_DESPESA_VENDA      := lQry.FieldByName('VALOR_DESPESA_VENDA').AsString;
    lModel.objeto.ENTREGA_ENDERECO         := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
    lModel.objeto.ENTREGA_COMPLEMENTO      := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
    lModel.objeto.ENTREGA_NUMERO           := lQry.FieldByName('ENTREGA_NUMERO').AsString;
    lModel.objeto.ENTREGA_BAIRRO           := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
    lModel.objeto.ENTREGA_CIDADE           := lQry.FieldByName('ENTREGA_CIDADE').AsString;
    lModel.objeto.ENTREGA_CEP              := lQry.FieldByName('ENTREGA_CEP').AsString;
    lModel.objeto.ENTREGA_UF               := lQry.FieldByName('ENTREGA_UF').AsString;
    lModel.objeto.ENTREGA_COD_MUNICIPIO    := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
    lModel.objeto.ENTREGA_TELEFONE         := lQry.FieldByName('ENTREGA_TELEFONE').AsString;
    lModel.objeto.ENTREGA_CELULAR          := lQry.FieldByName('ENTREGA_CELULAR').AsString;
    lModel.objeto.ENTREGA_OBSERVACAO       := lQry.FieldByName('ENTREGA_OBSERVACAO').AsString;
    lModel.objeto.ENTREGA_HORA             := lQry.FieldByName('ENTREGA_HORA').AsString;
    lModel.objeto.ENTREGA_CONTATO          := lQry.FieldByName('ENTREGA_CONTATO').AsString;
    lModel.objeto.ENTREGA_AGENDA_ID        := lQry.FieldByName('ENTREGA_AGENDA_ID').AsString;
    lModel.objeto.ENTREGA_REGIAO_ID        := lQry.FieldByName('ENTREGA_REGIAO_ID').AsString;
    lModel.objeto.ENTREGADOR_ID            := lQry.FieldByName('ENTREGADOR_ID').AsString;
    lModel.objeto.FATURA_ID                := lQry.FieldByName('FATURA_ID').AsString;
    lModel.objeto.DATAHORA_IMPRESSO        := lQry.FieldByName('DATAHORA_IMPRESSO').AsString;
    lModel.objeto.CTR_IMPRESSAO_ITENS      := lQry.FieldByName('CTR_IMPRESSAO_ITENS').AsString;
    lModel.objeto.RESERVADO                := lQry.FieldByName('RESERVADO').AsString;
    lModel.objeto.PATRIMONIO_OBSERVACAO    := lQry.FieldByName('PATRIMONIO_OBSERVACAO').AsString;
    lModel.objeto.OBS_GERAL                := lQry.FieldByName('OBS_GERAL').AsString;
    lModel.objeto.SMS                      := lQry.FieldByName('SMS').AsString;
    lModel.objeto.IMP_TICKET               := lQry.FieldByName('IMP_TICKET').AsString;
    lModel.objeto.COMANDA                  := lQry.FieldByName('COMANDA').AsString;
    lModel.objeto.VALOR_TAXA_SERVICO       := lQry.FieldByName('VALOR_TAXA_SERVICO').AsString;
    lModel.objeto.VFCPUFDEST               := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.objeto.VICMSUFDEST              := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.objeto.VICMSUFREMET             := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.objeto.ENTREGUE                 := lQry.FieldByName('ENTREGUE').AsString;
    lModel.objeto.INDICACAO_ID             := lQry.FieldByName('INDICACAO_ID').AsString;
    lModel.objeto.ZERAR_ST                 := lQry.FieldByName('ZERAR_ST').AsString;
    lModel.objeto.PEDIDO_VIDRACARIA        := lQry.FieldByName('PEDIDO_VIDRACARIA').AsString;
    lModel.objeto.CHAVE_XML_NF             := lQry.FieldByName('CHAVE_XML_NF').AsString;
    lModel.objeto.ARQUIVO_XML_NF           := lQry.FieldByName('ARQUIVO_XML_NF').AsString;
    lModel.objeto.GERENTE_ID               := lQry.FieldByName('GERENTE_ID').AsString;
    lModel.objeto.ENTRADA_PORTADOR_ID      := lQry.FieldByName('ENTRADA_PORTADOR_ID').AsString;
    lModel.objeto.DATA_COTACAO             := lQry.FieldByName('DATA_COTACAO').AsString;
    lModel.objeto.TIPO_COMISSAO            := lQry.FieldByName('TIPO_COMISSAO').AsString;
    lModel.objeto.GERENTE_TIPO_COMISSAO    := lQry.FieldByName('GERENTE_TIPO_COMISSAO').AsString;
    lModel.objeto.POS_VENDA                := lQry.FieldByName('POS_VENDA').AsString;
    lModel.objeto.VLR_GARANTIA             := lQry.FieldByName('VLR_GARANTIA').AsString;
    lModel.objeto.WEB_PEDIDO_ID            := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    lModel.objeto.LACA_OU_GLASS            := lQry.FieldByName('LACA_OU_GLASS').AsString;
    lModel.objeto.VFCPST                   := lQry.FieldByName('VFCPST').AsString;
    lModel.objeto.MONTAGEM_DATA            := lQry.FieldByName('MONTAGEM_DATA').AsString;
    lModel.objeto.MONTAGEM_HORA            := lQry.FieldByName('MONTAGEM_HORA').AsString;
    lModel.objeto.FORM                     := lQry.FieldByName('FORM').AsString;
    lModel.objeto.VICMSDESON               := lQry.FieldByName('VICMSDESON').AsString;
    lModel.objeto.QTDEITENS                := lQry.FieldByName('QTDEITENS').AsString;
    lModel.objeto.CTR_ENVIO_PEDIDO         := lQry.FieldByName('CTR_ENVIO_PEDIDO').AsString;
    lModel.objeto.CTR_ENVIO_BOLETO         := lQry.FieldByName('CTR_ENVIO_BOLETO').AsString;
    lModel.objeto.CTR_ENVIO_NFE            := lQry.FieldByName('CTR_ENVIO_NFE').AsString;
    lModel.objeto.DATAHORA_COLETA          := lQry.FieldByName('DATAHORA_COLETA').AsString;
    lModel.objeto.DATAHORA_RETIRADA        := lQry.FieldByName('DATAHORA_RETIRADA').AsString;
    lModel.objeto.CFOP_NF                  := lQry.FieldByName('CFOP_NF').AsString;
    lModel.objeto.SEGURO_PRESTAMISTA_VALOR := lQry.FieldByName('SEGURO_PRESTAMISTA_VALOR').AsString;
    lModel.objeto.SEGURO_PRESTAMISTA_CUSTO := lQry.FieldByName('SEGURO_PRESTAMISTA_CUSTO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPedidoVendaDao._Create(pConexao : IConexao);
begin
  vIConexao   := pConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPedidoVendaDao.Destroy;
begin
  FPedidoVendasLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TPedidoVendaDao.incluir(pPedidoVendaModel: ITPedidoVendaModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PEDIDOVENDA', 'NUMERO_PED');

  try
    lQry.SQL.Add(lSQL);
    pPedidoVendaModel.objeto.NUMERO_PED := vIConexao.Generetor('GEN_PEDIDOVENDA');
    setParams(lQry, pPedidoVendaModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_PED').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoVendaDao.alterar(pPedidoVendaModel: ITPedidoVendaModel): String;
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
    Result := pPedidoVendaModel.objeto.ID;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoVendaDao.excluir(pPedidoVendaModel: ITPedidoVendaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from pedidovenda where NUMERO_PED = :NUMERO_PED',[pPedidoVendaModel.objeto.NUMERO_PED]);
   lQry.ExecSQL;
   Result := pPedidoVendaModel.objeto.NUMERO_PED;
  finally
    lQry.Free;
  end;
end;

class function TPedidoVendaDao.getNewIface(pIConexao: IConexao): ITPedidoVendaDao;
begin
  Result := TImplObjetoOwner<TPedidoVendaDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
  modelo: ITPedidoVendaModel;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoVendasLista := TCollections.CreateList<ITPedidoVendaModel>;
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
      modelo := TPedidoVendaModel.getNewIface(vIConexao);
      FPedidoVendasLista.Add(modelo);
      modelo.objeto.ID                        := lQry.FieldByName('ID').AsString;
      modelo.objeto.NUMERO_PED                := lQry.FieldByName('NUMERO_PED').AsString;
      modelo.objeto.CODIGO_CLI                := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.objeto.CODIGO_VEN                := lQry.FieldByName('CODIGO_VEN').AsString;
      modelo.objeto.CODIGO_PORT               := lQry.FieldByName('CODIGO_PORT').AsString;
      modelo.objeto.CODIGO_TIP                := lQry.FieldByName('CODIGO_TIP').AsString;
      modelo.objeto.DATA_PED                  := lQry.FieldByName('DATA_PED').AsString;
      modelo.objeto.VALOR_PED                 := lQry.FieldByName('VALOR_PED').AsString;
      modelo.objeto.DESC_PED                  := lQry.FieldByName('DESC_PED').AsString;
      modelo.objeto.ACRES_PED                 := lQry.FieldByName('ACRES_PED').AsString;
      modelo.objeto.TOTAL_PED                 := lQry.FieldByName('TOTAL_PED').AsString;
      modelo.objeto.USUARIO_PED               := lQry.FieldByName('USUARIO_PED').AsString;
      modelo.objeto.NUMERO_ORC                := lQry.FieldByName('NUMERO_ORC').AsString;
      modelo.objeto.INFORMACOES_PED           := lQry.FieldByName('INFORMACOES_PED').AsString;
      modelo.objeto.TIPO_PED                  := lQry.FieldByName('TIPO_PED').AsString;
      modelo.objeto.INDCE_PED                 := lQry.FieldByName('INDCE_PED').AsString;
      modelo.objeto.CFOP_ID                   := lQry.FieldByName('CFOP_ID').AsString;
      modelo.objeto.PRIMEIROVENC_PED          := lQry.FieldByName('PRIMEIROVENC_PED').AsString;
      modelo.objeto.VALORENTADA_PED           := lQry.FieldByName('VALORENTADA_PED').AsString;
      modelo.objeto.PARCELAS_PED              := lQry.FieldByName('PARCELAS_PED').AsString;
      modelo.objeto.PARCELA_PED               := lQry.FieldByName('PARCELA_PED').AsString;
      modelo.objeto.STATUS_PED                := lQry.FieldByName('STATUS_PED').AsString;
      modelo.objeto.TABJUROS_PED              := lQry.FieldByName('TABJUROS_PED').AsString;
      modelo.objeto.CONTATO_PED               := lQry.FieldByName('CONTATO_PED').AsString;
      modelo.objeto.DESCONTO_PED              := lQry.FieldByName('DESCONTO_PED').AsString;
      modelo.objeto.CTR_IMPRESSAO_PED         := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
      modelo.objeto.FRETE_PED                 := lQry.FieldByName('FRETE_PED').AsString;
      modelo.objeto.CONDICOES_PAG             := lQry.FieldByName('CONDICOES_PAG').AsString;
      modelo.objeto.TOTAL1_PED                := lQry.FieldByName('TOTAL1_PED').AsString;
      modelo.objeto.TOTAL2_PED                := lQry.FieldByName('TOTAL2_PED').AsString;
      modelo.objeto.LOCAL_PED                 := lQry.FieldByName('LOCAL_PED').AsString;
      modelo.objeto.TELEVENDA_PED             := lQry.FieldByName('TELEVENDA_PED').AsString;
      modelo.objeto.PESO_PED                  := lQry.FieldByName('PESO_PED').AsString;
      modelo.objeto.PRIMEIROVENC2_PED         := lQry.FieldByName('PRIMEIROVENC2_PED').AsString;
      modelo.objeto.PARCELAS2_PED             := lQry.FieldByName('PARCELAS2_PED').AsString;
      modelo.objeto.VALOR_IPI                 := lQry.FieldByName('VALOR_IPI').AsString;
      modelo.objeto.CONDICOES2_PAG            := lQry.FieldByName('CONDICOES2_PAG').AsString;
      modelo.objeto.LOJA                      := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.DOLAR                     := lQry.FieldByName('DOLAR').AsString;
      modelo.objeto.CTR_EXPORTACAO            := lQry.FieldByName('CTR_EXPORTACAO').AsString;
      modelo.objeto.ID                        := lQry.FieldByName('ID').AsString;
      modelo.objeto.NUMERO_CF                 := lQry.FieldByName('NUMERO_CF').AsString;
      modelo.objeto.CF_ABERTO                 := lQry.FieldByName('CF_ABERTO').AsString;
      modelo.objeto.NAO_FISCAL_ABERTO         := lQry.FieldByName('NAO_FISCAL_ABERTO').AsString;
      modelo.objeto.HORA_PED                  := lQry.FieldByName('HORA_PED').AsString;
      modelo.objeto.TIPO_FRETE                := lQry.FieldByName('TIPO_FRETE').AsString;
      modelo.objeto.VALOR_PAGO                := lQry.FieldByName('VALOR_PAGO').AsString;
      modelo.objeto.STATUS                    := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.DATA_FATURADO             := lQry.FieldByName('DATA_FATURADO').AsString;
      modelo.objeto.NUMERO_NF                 := lQry.FieldByName('NUMERO_NF').AsString;
      modelo.objeto.VALOR_SUFRAMA             := lQry.FieldByName('VALOR_SUFRAMA').AsString;
      modelo.objeto.CARGA_ID                  := lQry.FieldByName('CARGA_ID').AsString;
      modelo.objeto.LISTA_NOIVA_ID            := lQry.FieldByName('LISTA_NOIVA_ID').AsString;
      modelo.objeto.VALOR_RESTITUICAO         := lQry.FieldByName('VALOR_RESTITUICAO').AsString;
      modelo.objeto.SYSTIME                   := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.DESCONTO_DRG              := lQry.FieldByName('DESCONTO_DRG').AsString;
      modelo.objeto.STATUS_ID                 := lQry.FieldByName('STATUS_ID').AsString;
      modelo.objeto.PRECO_VENDA_ID            := lQry.FieldByName('PRECO_VENDA_ID').AsString;
      modelo.objeto.RNTRC                     := lQry.FieldByName('RNTRC').AsString;
      modelo.objeto.PLACA                     := lQry.FieldByName('PLACA').AsString;
      modelo.objeto.PESO_LIQUIDO              := lQry.FieldByName('PESO_LIQUIDO').AsString;
      modelo.objeto.PESO_BRUTO                := lQry.FieldByName('PESO_BRUTO').AsString;
      modelo.objeto.QTDE_VOLUME               := lQry.FieldByName('QTDE_VOLUME').AsString;
      modelo.objeto.ESPECIE_VOLUME            := lQry.FieldByName('ESPECIE_VOLUME').AsString;
      modelo.objeto.UF_TRANSPORTADORA         := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
      modelo.objeto.PRODUCAO_ID               := lQry.FieldByName('PRODUCAO_ID').AsString;
      modelo.objeto.REGIAO_ID                 := lQry.FieldByName('REGIAO_ID').AsString;
      modelo.objeto.ORDEM                     := lQry.FieldByName('ORDEM').AsString;
      modelo.objeto.CNPJ_CPF_CONSUMIDOR       := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
      modelo.objeto.PEDIDO_COMPRA             := lQry.FieldByName('PEDIDO_COMPRA').AsString;
      modelo.objeto.DATA_FINALIZADO           := lQry.FieldByName('DATA_FINALIZADO').AsString;
      modelo.objeto.NUMERO_SENHA              := lQry.FieldByName('NUMERO_SENHA').AsString;
      modelo.objeto.ARQUITETO_ID              := lQry.FieldByName('ARQUITETO_ID').AsString;
      modelo.objeto.ARQUITETO_COMISSAO        := lQry.FieldByName('ARQUITETO_COMISSAO').AsString;
      modelo.objeto.LOTE_CARGA_ID             := lQry.FieldByName('LOTE_CARGA_ID').AsString;
      modelo.objeto.ENTREGA                   := lQry.FieldByName('ENTREGA').AsString;
      modelo.objeto.VALOR_DESPESA_VENDA       := lQry.FieldByName('VALOR_DESPESA_VENDA').AsString;
      modelo.objeto.ENTREGA_ENDERECO          := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
      modelo.objeto.ENTREGA_COMPLEMENTO       := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
      modelo.objeto.ENTREGA_NUMERO            := lQry.FieldByName('ENTREGA_NUMERO').AsString;
      modelo.objeto.ENTREGA_BAIRRO            := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
      modelo.objeto.ENTREGA_CIDADE            := lQry.FieldByName('ENTREGA_CIDADE').AsString;
      modelo.objeto.ENTREGA_CEP               := lQry.FieldByName('ENTREGA_CEP').AsString;
      modelo.objeto.ENTREGA_UF                := lQry.FieldByName('ENTREGA_UF').AsString;
      modelo.objeto.ENTREGA_COD_MUNICIPIO     := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
      modelo.objeto.ENTREGA_TELEFONE          := lQry.FieldByName('ENTREGA_TELEFONE').AsString;
      modelo.objeto.ENTREGA_CELULAR           := lQry.FieldByName('ENTREGA_CELULAR').AsString;
      modelo.objeto.ENTREGA_OBSERVACAO        := lQry.FieldByName('ENTREGA_OBSERVACAO').AsString;
      modelo.objeto.ENTREGA_HORA              := lQry.FieldByName('ENTREGA_HORA').AsString;
      modelo.objeto.ENTREGA_CONTATO           := lQry.FieldByName('ENTREGA_CONTATO').AsString;
      modelo.objeto.ENTREGA_AGENDA_ID         := lQry.FieldByName('ENTREGA_AGENDA_ID').AsString;
      modelo.objeto.ENTREGA_REGIAO_ID         := lQry.FieldByName('ENTREGA_REGIAO_ID').AsString;
      modelo.objeto.ENTREGADOR_ID             := lQry.FieldByName('ENTREGADOR_ID').AsString;
      modelo.objeto.FATURA_ID                 := lQry.FieldByName('FATURA_ID').AsString;
      modelo.objeto.DATAHORA_IMPRESSO         := lQry.FieldByName('DATAHORA_IMPRESSO').AsString;
      modelo.objeto.CTR_IMPRESSAO_ITENS       := lQry.FieldByName('CTR_IMPRESSAO_ITENS').AsString;
      modelo.objeto.RESERVADO                 := lQry.FieldByName('RESERVADO').AsString;
      modelo.objeto.PATRIMONIO_OBSERVACAO     := lQry.FieldByName('PATRIMONIO_OBSERVACAO').AsString;
      modelo.objeto.OBS_GERAL                 := lQry.FieldByName('OBS_GERAL').AsString;
      modelo.objeto.SMS                       := lQry.FieldByName('SMS').AsString;
      modelo.objeto.IMP_TICKET                := lQry.FieldByName('IMP_TICKET').AsString;
      modelo.objeto.COMANDA                   := lQry.FieldByName('COMANDA').AsString;
      modelo.objeto.VALOR_TAXA_SERVICO        := lQry.FieldByName('VALOR_TAXA_SERVICO').AsString;
      modelo.objeto.VFCPUFDEST                := lQry.FieldByName('VFCPUFDEST').AsString;
      modelo.objeto.VICMSUFDEST               := lQry.FieldByName('VICMSUFDEST').AsString;
      modelo.objeto.VICMSUFREMET              := lQry.FieldByName('VICMSUFREMET').AsString;
      modelo.objeto.ENTREGUE                  := lQry.FieldByName('ENTREGUE').AsString;
      modelo.objeto.INDICACAO_ID              := lQry.FieldByName('INDICACAO_ID').AsString;
      modelo.objeto.ZERAR_ST                  := lQry.FieldByName('ZERAR_ST').AsString;
      modelo.objeto.PEDIDO_VIDRACARIA         := lQry.FieldByName('PEDIDO_VIDRACARIA').AsString;
      modelo.objeto.CHAVE_XML_NF              := lQry.FieldByName('CHAVE_XML_NF').AsString;
      modelo.objeto.ARQUIVO_XML_NF            := lQry.FieldByName('ARQUIVO_XML_NF').AsString;
      modelo.objeto.GERENTE_ID                := lQry.FieldByName('GERENTE_ID').AsString;
      modelo.objeto.ENTRADA_PORTADOR_ID       := lQry.FieldByName('ENTRADA_PORTADOR_ID').AsString;
      modelo.objeto.DATA_COTACAO              := lQry.FieldByName('DATA_COTACAO').AsString;
      modelo.objeto.TIPO_COMISSAO             := lQry.FieldByName('TIPO_COMISSAO').AsString;
      modelo.objeto.GERENTE_TIPO_COMISSAO     := lQry.FieldByName('GERENTE_TIPO_COMISSAO').AsString;
      modelo.objeto.POS_VENDA                 := lQry.FieldByName('POS_VENDA').AsString;
      modelo.objeto.VLR_GARANTIA              := lQry.FieldByName('VLR_GARANTIA').AsString;
      modelo.objeto.WEB_PEDIDO_ID             := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
      modelo.objeto.LACA_OU_GLASS             := lQry.FieldByName('LACA_OU_GLASS').AsString;
      modelo.objeto.VFCPST                    := lQry.FieldByName('VFCPST').AsString;
      modelo.objeto.MONTAGEM_DATA             := lQry.FieldByName('MONTAGEM_DATA').AsString;
      modelo.objeto.MONTAGEM_HORA             := lQry.FieldByName('MONTAGEM_HORA').AsString;
      modelo.objeto.FORM                      := lQry.FieldByName('FORM').AsString;
      modelo.objeto.VICMSDESON                := lQry.FieldByName('VICMSDESON').AsString;
      modelo.objeto.QTDEITENS                 := lQry.FieldByName('QTDEITENS').AsString;
      modelo.objeto.CTR_ENVIO_PEDIDO          := lQry.FieldByName('CTR_ENVIO_PEDIDO').AsString;
      modelo.objeto.CTR_ENVIO_BOLETO          := lQry.FieldByName('CTR_ENVIO_BOLETO').AsString;
      modelo.objeto.CTR_ENVIO_NFE             := lQry.FieldByName('CTR_ENVIO_NFE').AsString;
      modelo.objeto.DATAHORA_COLETA           := lQry.FieldByName('DATAHORA_COLETA').AsString;
      modelo.objeto.DATAHORA_RETIRADA         := lQry.FieldByName('DATAHORA_RETIRADA').AsString;
      modelo.objeto.FANTASIA_CLI              := lQry.FieldByName('FANTASIA_CLI').AsString;
      modelo.objeto.NOME_VENDEDOR             := lQry.FieldByName('NOME_FUN').AsString;
      modelo.objeto.CFOP_NF                   := lQry.FieldByName('CFOP_NF').AsString;
      modelo.objeto.SEGURO_PRESTAMISTA_CUSTO  := lQry.FieldByName('SEGURO_PRESTAMISTA_CUSTO').AsString;
      modelo.objeto.SEGURO_PRESTAMISTA_VALOR  := lQry.FieldByName('SEGURO_PRESTAMISTA_VALOR').AsString;

      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;
function TPedidoVendaDao.obterPedido(pNumeroPedido: String): ITPedidoVendaModel;
var
  lQry: TFDQuery;
  lSQL:String;
  lPedidoVendaModel: ITPedidoVendaModel;
begin
  lQry := vIConexao.CriarQuery;
  lPedidoVendaModel := TPedidoVendaModel.getNewIface(vIConexao);
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
    lPedidoVendaModel.objeto.NUMERO_PED     :=  lQry.FieldByName('NUMERO_PED').AsString;
    lPedidoVendaModel.objeto.CODIGO_CLI     :=  lQry.FieldByName('CODIGO_CLI').AsString;
    lPedidoVendaModel.objeto.CODIGO_PORT    :=  lQry.FieldByName('CODIGO_PORT').AsString;
    lPedidoVendaModel.objeto.CODIGO_VEN     :=  lQry.FieldByName('CODIGO_VEN').AsString;
    lPedidoVendaModel.objeto.DATA_PED       :=  lQry.FieldByName('DATA_PED').AsString;
    lPedidoVendaModel.objeto.HORA_PED       :=  lQry.FieldByName('HORA_PED').AsString;
    lPedidoVendaModel.objeto.FANTASIA_CLI   :=  lQry.FieldByName('FANTASIA_CLI').AsString;
    lPedidoVendaModel.objeto.ENDERECO       :=  lQry.FieldByName('ENDERECO').AsString;
    lPedidoVendaModel.objeto.BAIRRO_CLI     :=  lQry.FieldByName('BAIRRO_CLI').AsString;
    lPedidoVendaModel.objeto.CIDADE_CLI     :=  lQry.FieldByName('CIDADE_CLI').AsString;
    lPedidoVendaModel.objeto.UF_CLI         :=  lQry.FieldByName('UF_CLI').AsString;
    lPedidoVendaModel.objeto.CNPJ_CPF_CLI   :=  lQry.FieldByName('CNPJ_CPF_CLI').AsString;
    lPedidoVendaModel.objeto.VALOR_PED      :=  lQry.FieldByName('VALOR_PED').AsString;
    lPedidoVendaModel.objeto.FRETE_PED      :=  lQry.FieldByName('FRETE_PED').AsString;
    lPedidoVendaModel.objeto.ACRES_PED      :=  lQry.FieldByName('ACRES_PED').AsString;
    lPedidoVendaModel.objeto.DESC_PED       :=  lQry.FieldByName('DESC_PED').AsString;
    lPedidoVendaModel.objeto.DESCONTO_PED   :=  lQry.FieldByName('DESCONTO_PED').AsString;
    lPedidoVendaModel.objeto.TOTAL_PED      :=  lQry.FieldByName('TOTAL_PED').AsString;
    lPedidoVendaModel.objeto.STATUS_PED     :=  lQry.FieldByName('STATUS_PED').AsString;
    lPedidoVendaModel.objeto.NOME_VENDEDOR  :=  lQry.FieldByName('NOME_FUN').AsString;
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

procedure TPedidoVendaDao.setParams(var pQry: TFDQuery; pPedidoVendaModel: ITPedidoVendaModel);
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPedidoVendaModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPedidoVendaModel.objeto).AsString))
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
