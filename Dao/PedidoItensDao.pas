unit PedidoItensDao;
interface
uses
  PedidoItensModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;


type
  TPedidoItensDao = class
  private
    vIConexao : IConexao;

    FPedidoItenssLista: TObjectList<TPedidoItensModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    FIDPedidoVendaView: String;
    FVALOR_TOTAL_ITENS: Variant;
    FVALOR_TOTAL_DESCONTO: Variant;
    FVALOR_TOTAL_GARANTIA: Variant;
    FVALOR_TOTAL: Variant;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPedidoItenssLista(const Value: TObjectList<TPedidoItensModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function montaCondicaoQuery: String;
    procedure SetIDRecordView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPedidoItensModel: TPedidoItensModel);
    procedure setParamsArray(var pQry: TFDQuery; pPedidoItensModel: TPedidoItensModel);
    procedure SetIDPedidoVendaView(const Value: String);
    procedure SetVALOR_TOTAL_DESCONTO(const Value: Variant);
    procedure SetVALOR_TOTAL_GARANTIA(const Value: Variant);
    procedure SetVALOR_TOTAL_ITENS(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);
  public
    constructor Create(pConexao : IConexao);
    destructor Destroy; override;
    property PedidoItenssLista: TObjectList<TPedidoItensModel> read FPedidoItenssLista write SetPedidoItenssLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property IDPedidoVendaView: String read FIDPedidoVendaView write SetIDPedidoVendaView;
    property VALOR_TOTAL_ITENS: Variant read FVALOR_TOTAL_ITENS write SetVALOR_TOTAL_ITENS;
    property VALOR_TOTAL_GARANTIA: Variant read FVALOR_TOTAL_GARANTIA write SetVALOR_TOTAL_GARANTIA;
    property VALOR_TOTAL_DESCONTO: Variant read FVALOR_TOTAL_DESCONTO write SetVALOR_TOTAL_DESCONTO;
    property VALOR_TOTAL: Variant read FVALOR_TOTAL write SetVALOR_TOTAL;

    function incluir(APedidoItensModel: TPedidoItensModel): String;
    function incluirLote(APedidoItensModel: TPedidoItensModel): String;
    function alterar(APedidoItensModel: TPedidoItensModel): String;
    function excluir(APedidoItensModel: TPedidoItensModel): String;

    procedure obterLista;
    procedure obterItensPedido(pNumeroPedido: String);
    procedure obterTotaisItens(pNumeroPedido: String);
    function carregaClasse(pId: String): TPedidoItensModel;
end;

implementation

{ TPedidoItens }

uses Terasoft.FuncoesTexto, VariaveisGlobais;

function TPedidoItensDao.carregaClasse(pId: String): TPedidoItensModel;
var
  lQry: TFDQuery;
  lModel: TPedidoItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPedidoItensModel.Create(vIConexao);
  Result   := lModel;
  try
    lQry.Open('select * from pedidoitens where id = '+pId);
    if lQry.IsEmpty then
      Exit;
    lModel.ID                           := lQry.FieldByName('ID').AsString;
    lModel.CODIGO_CLI                   := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.NUMERO_PED                   := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.CODIGO_PRO                   := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.QUANTIDADE_PED               := lQry.FieldByName('QUANTIDADE_PED').AsString;
    lModel.QUANTIDADE_TROCA             := lQry.FieldByName('QUANTIDADE_TROCA').AsString;
    lModel.VALORUNITARIO_PED            := lQry.FieldByName('VALORUNITARIO_PED').AsString;
    lModel.DESCONTO_PED                 := lQry.FieldByName('DESCONTO_PED').AsString;
    lModel.DESCONTO_UF                  := lQry.FieldByName('DESCONTO_UF').AsString;
    lModel.VALOR_IPI                    := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.VALOR_ST                     := lQry.FieldByName('VALOR_ST').AsString;
    lModel.VLRVENDA_PRO                 := lQry.FieldByName('VLRVENDA_PRO').AsString;
    lModel.VLRCUSTO_PRO                 := lQry.FieldByName('VLRCUSTO_PRO').AsString;
    lModel.COMISSAO_PED                 := lQry.FieldByName('COMISSAO_PED').AsString;
    lModel.TIPO_NF                      := lQry.FieldByName('TIPO_NF').AsString;
    lModel.QUANTIDADE_TIPO              := lQry.FieldByName('QUANTIDADE_TIPO').AsString;
    lModel.OBSERVACAO                   := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.CTR_EXPORTACAO               := lQry.FieldByName('CTR_EXPORTACAO').AsString;
    lModel.PRODUTO_REFERENCIA           := lQry.FieldByName('PRODUTO_REFERENCIA').AsString;
    lModel.OBS_ITEM                     := lQry.FieldByName('OBS_ITEM').AsString;
    lModel.RESERVA_ID                   := lQry.FieldByName('RESERVA_ID').AsString;
    lModel.LOJA                         := lQry.FieldByName('LOJA').AsString;
    lModel.ALIQ_IPI                     := lQry.FieldByName('ALIQ_IPI').AsString;
    lModel.VALOR_RESTITUICAO_ST         := lQry.FieldByName('VALOR_RESTITUICAO_ST').AsString;
    lModel.CFOP_ID                      := lQry.FieldByName('CFOP_ID').AsString;
    lModel.CST                          := lQry.FieldByName('CST').AsString;
    lModel.ALIQ_ICMS                    := lQry.FieldByName('ALIQ_ICMS').AsString;
    lModel.ALIQ_ICMS_ST                 := lQry.FieldByName('ALIQ_ICMS_ST').AsString;
    lModel.REDUCAO_ST                   := lQry.FieldByName('REDUCAO_ST').AsString;
    lModel.MVA                          := lQry.FieldByName('MVA').AsString;
    lModel.REDUCAO_ICMS                 := lQry.FieldByName('REDUCAO_ICMS').AsString;
    lModel.BASE_ICMS                    := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.VALOR_ICMS                   := lQry.FieldByName('VALOR_ICMS').AsString;
    lModel.BASE_ST                      := lQry.FieldByName('BASE_ST').AsString;
    lModel.DESC_RESTITUICAO_ST          := lQry.FieldByName('DESC_RESTITUICAO_ST').AsString;
    lModel.ICMS_SUFRAMA                 := lQry.FieldByName('ICMS_SUFRAMA').AsString;
    lModel.PIS_SUFRAMA                  := lQry.FieldByName('PIS_SUFRAMA').AsString;
    lModel.COFINS_SUFRAMA               := lQry.FieldByName('COFINS_SUFRAMA').AsString;
    lModel.IPI_SUFRAMA                  := lQry.FieldByName('IPI_SUFRAMA').AsString;
    lModel.ALIQ_PIS                     := lQry.FieldByName('ALIQ_PIS').AsString;
    lModel.ALIQ_COFINS                  := lQry.FieldByName('ALIQ_COFINS').AsString;
    lModel.BASE_PIS                     := lQry.FieldByName('BASE_PIS').AsString;
    lModel.BASE_COFINS                  := lQry.FieldByName('BASE_COFINS').AsString;
    lModel.VALOR_PIS                    := lQry.FieldByName('VALOR_PIS').AsString;
    lModel.VALOR_COFINS                 := lQry.FieldByName('VALOR_COFINS').AsString;
    lModel.PREVENDA_ID                  := lQry.FieldByName('PREVENDA_ID').AsString;
    lModel.AVULSO                       := lQry.FieldByName('AVULSO').AsString;
    lModel.QUANTIDADE_NEW               := lQry.FieldByName('QUANTIDADE_NEW').AsString;
    lModel.BALANCA                      := lQry.FieldByName('BALANCA').AsString;
    lModel.QTDE_CALCULADA               := lQry.FieldByName('QTDE_CALCULADA').AsString;
    lModel.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
    lModel.AMBIENTE_ID                  := lQry.FieldByName('AMBIENTE_ID').AsString;
    lModel.AMBIENTE_OBS                 := lQry.FieldByName('AMBIENTE_OBS').AsString;
    lModel.PROJETO_ID                   := lQry.FieldByName('PROJETO_ID').AsString;
    lModel.LARGURA                      := lQry.FieldByName('LARGURA').AsString;
    lModel.ALTURA                       := lQry.FieldByName('ALTURA').AsString;
    lModel.ITEM                         := lQry.FieldByName('ITEM').AsString;
    lModel.DUN14                        := lQry.FieldByName('DUN14').AsString;
    lModel.SAIDAS_ID                    := lQry.FieldByName('SAIDAS_ID').AsString;
    lModel.CUSTO_DRG                    := lQry.FieldByName('CUSTO_DRG').AsString;
    lModel.POS_VENDA_STATUS             := lQry.FieldByName('POS_VENDA_STATUS').AsString;
    lModel.POS_VENDA_RETORNO            := lQry.FieldByName('POS_VENDA_RETORNO').AsString;
    lModel.POS_VENDA_OBS                := lQry.FieldByName('POS_VENDA_OBS').AsString;
    lModel.VALOR_SUFRAMA_ITEM_NEW       := lQry.FieldByName('VALOR_SUFRAMA_ITEM_NEW').AsString;
    lModel.VALOR_SUFRAMA_ITEM           := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
    lModel.BONUS                        := lQry.FieldByName('BONUS').AsString;
    lModel.BONUS_USO                    := lQry.FieldByName('BONUS_USO').AsString;
    lModel.FUNCIONARIO_ID               := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.PRODUCAO_ID                  := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.QUANTIDADE_KG                := lQry.FieldByName('QUANTIDADE_KG').AsString;
    lModel.RESERVADO                    := lQry.FieldByName('RESERVADO').AsString;
    lModel.DESCRICAO_PRODUTO            := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
    lModel.COMISSAO_PERCENTUAL          := lQry.FieldByName('COMISSAO_PERCENTUAL').AsString;
    lModel.QTD_CHECAGEM                 := lQry.FieldByName('QTD_CHECAGEM').AsString;
    lModel.QTD_CHECAGEM_CORTE           := lQry.FieldByName('QTD_CHECAGEM_CORTE').AsString;
    lModel.ALTURA_M                     := lQry.FieldByName('ALTURA_M').AsString;
    lModel.LARGURA_M                    := lQry.FieldByName('LARGURA_M').AsString;
    lModel.PROFUNDIDADE_M               := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.VBCUFDEST                    := lQry.FieldByName('VBCUFDEST').AsString;
    lModel.PFCPUFDEST                   := lQry.FieldByName('PFCPUFDEST').AsString;
    lModel.PICMSUFDEST                  := lQry.FieldByName('PICMSUFDEST').AsString;
    lModel.PICMSINTER                   := lQry.FieldByName('PICMSINTER').AsString;
    lModel.PICMSINTERPART               := lQry.FieldByName('PICMSINTERPART').AsString;
    lModel.VFCPUFDEST                   := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.VICMSUFDEST                  := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.VICMSUFREMET                 := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.COMBO_ITEM                   := lQry.FieldByName('COMBO_ITEM').AsString;
    lModel.VLRVENDA_MINIMO              := lQry.FieldByName('VLRVENDA_MINIMO').AsString;
    lModel.VLRVENDA_MAXIMO              := lQry.FieldByName('VLRVENDA_MAXIMO').AsString;
    lModel.IMPRESSO                     := lQry.FieldByName('IMPRESSO').AsString;
    lModel.ORCAMENTO_TSB_ID             := lQry.FieldByName('ORCAMENTO_TSB_ID').AsString;
    lModel.GERENTE_COMISSAO_PERCENTUAL  := lQry.FieldByName('GERENTE_COMISSAO_PERCENTUAL').AsString;
    lModel.XPED                         := lQry.FieldByName('XPED').AsString;
    lModel.NITEMPED2                    := lQry.FieldByName('NITEMPED2').AsString;
    lModel.VOUTROS                      := lQry.FieldByName('VOUTROS').AsString;
    lModel.VFRETE                       := lQry.FieldByName('VFRETE').AsString;
    lModel.ORIGINAL_PEDIDO_ID           := lQry.FieldByName('ORIGINAL_PEDIDO_ID').AsString;
    lModel.VALOR_VENDA_CADASTRO         := lQry.FieldByName('VALOR_VENDA_CADASTRO').AsString;
    lModel.WEB_PEDIDOITENS_ID           := lQry.FieldByName('WEB_PEDIDOITENS_ID').AsString;
    lModel.TIPO_VENDA                   := lQry.FieldByName('TIPO_VENDA').AsString;
    lModel.ENTREGA                      := lQry.FieldByName('ENTREGA').AsString;
    lModel.VBCFCPST                     := lQry.FieldByName('VBCFCPST').AsString;
    lModel.PFCPST                       := lQry.FieldByName('PFCPST').AsString;
    lModel.VFCPST                       := lQry.FieldByName('VFCPST').AsString;
    lModel.VALOR_BONUS_SERVICO          := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
    lModel.CBENEF                       := lQry.FieldByName('CBENEF').AsString;
    lModel.VICMSDESON                   := lQry.FieldByName('VICMSDESON').AsString;
    lModel.MOTDESICMS                   := lQry.FieldByName('MOTDESICMS').AsString;
    lModel.VALOR_DIFERIMENTO            := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
    lModel.VALOR_MONTADOR               := lQry.FieldByName('VALOR_MONTADOR').AsString;
    lModel.MONTAGEM                     := lQry.FieldByName('MONTAGEM').AsString;
    lModel.PCRED_PRESUMIDO              := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
    lModel.PEDIDOCOMPRAITENS_ID         := lQry.FieldByName('PEDIDOCOMPRAITENS_ID').AsString;
    lModel.PEDIDOITENS_ID               := lQry.FieldByName('PEDIDOITENS_ID').AsString;
    lModel.PIS_CST                      := lQry.FieldByName('PIS_CST').AsString;
    lModel.COFINS_CST                   := lQry.FieldByName('COFINS_CST').AsString;
    lModel.IPI_CST                      := lQry.FieldByName('IPI_CST').AsString;
    lModel.VDESC                        := lQry.FieldByName('VDESC').AsString;
    lModel.CSOSN                        := lQry.FieldByName('CSOSN').AsString;
    lModel.CFOP                         := lQry.FieldByName('CFOP').AsString;
    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPedidoItensDao.Create(pConexao : IConexao);
begin
  vIConexao := pConexao;
end;

destructor TPedidoItensDao.Destroy;
begin
  inherited;
end;

function TPedidoItensDao.incluir(APedidoItensModel: TPedidoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry     := vIConexao.CriarQuery;

  lSQL :=  '     insert into pedidoitens (codigo_cli,                                   '+SLineBreak+
           '                              numero_ped,                                   '+SLineBreak+
           '                              codigo_pro,                                   '+SLineBreak+
           '                              quantidade_ped,                               '+SLineBreak+
           '                              quantidade_troca,                             '+SLineBreak+
           '                              valorunitario_ped,                            '+SLineBreak+
           '                              desconto_ped,                                 '+SLineBreak+
           '                              desconto_uf,                                  '+SLineBreak+
           '                              valor_ipi,                                    '+SLineBreak+
           '                              valor_st,                                     '+SLineBreak+
           '                              vlrvenda_pro,                                 '+SLineBreak+
           '                              vlrcusto_pro,                                 '+SLineBreak+
           '                              comissao_ped,                                 '+SLineBreak+
           '                              tipo_nf,                                      '+SLineBreak+
           '                              quantidade_tipo,                              '+SLineBreak+
           '                              observacao,                                   '+SLineBreak+
           '                              ctr_exportacao,                               '+SLineBreak+
           '                              produto_referencia,                           '+SLineBreak+
           '                              obs_item,                                     '+SLineBreak+
           '                              reserva_id,                                   '+SLineBreak+
           '                              loja,                                         '+SLineBreak+
           '                              aliq_ipi,                                     '+SLineBreak+
           '                              valor_restituicao_st,                         '+SLineBreak+
           '                              cfop_id,                                      '+SLineBreak+
           '                              cst,                                          '+SLineBreak+
           '                              aliq_icms,                                    '+SLineBreak+
           '                              aliq_icms_st,                                 '+SLineBreak+
           '                              reducao_st,                                   '+SLineBreak+
           '                              mva,                                          '+SLineBreak+
           '                              reducao_icms,                                 '+SLineBreak+
           '                              base_icms,                                    '+SLineBreak+
           '                              valor_icms,                                   '+SLineBreak+
           '                              base_st,                                      '+SLineBreak+
           '                              desc_restituicao_st,                          '+SLineBreak+
           '                              icms_suframa,                                 '+SLineBreak+
           '                              pis_suframa,                                  '+SLineBreak+
           '                              cofins_suframa,                               '+SLineBreak+
           '                              ipi_suframa,                                  '+SLineBreak+
           '                              aliq_pis,                                     '+SLineBreak+
           '                              aliq_cofins,                                  '+SLineBreak+
           '                              base_pis,                                     '+SLineBreak+
           '                              base_cofins,                                  '+SLineBreak+
           '                              valor_pis,                                    '+SLineBreak+
           '                              valor_cofins,                                 '+SLineBreak+
           '                              prevenda_id,                                  '+SLineBreak+
           '                              avulso,                                       '+SLineBreak+
           '                              quantidade_new,                               '+SLineBreak+
           '                              balanca,                                      '+SLineBreak+
           '                              ambiente_id,                                  '+SLineBreak+
           '                              ambiente_obs,                                 '+SLineBreak+
           '                              projeto_id,                                   '+SLineBreak+
           '                              largura,                                      '+SLineBreak+
           '                              altura,                                       '+SLineBreak+
           '                              item,                                         '+SLineBreak+
           '                              dun14,                                        '+SLineBreak+
           '                              saidas_id,                                    '+SLineBreak+
           '                              custo_drg,                                    '+SLineBreak+
           '                              pos_venda_status,                             '+SLineBreak+
           '                              pos_venda_retorno,                            '+SLineBreak+
           '                              pos_venda_obs,                                '+SLineBreak+
           '                              bonus,                                        '+SLineBreak+
           '                              bonus_uso,                                    '+SLineBreak+
           '                              funcionario_id,                               '+SLineBreak+
           '                              producao_id,                                  '+SLineBreak+
           '                              quantidade_kg,                                '+SLineBreak+
           '                              reservado,                                    '+SLineBreak+
           '                              descricao_produto,                            '+SLineBreak+
           '                              comissao_percentual,                          '+SLineBreak+
           '                              qtd_checagem,                                 '+SLineBreak+
           '                              qtd_checagem_corte,                           '+SLineBreak+
           '                              altura_m,                                     '+SLineBreak+
           '                              largura_m,                                    '+SLineBreak+
           '                              profundidade_m,                               '+SLineBreak+
           '                              vbcufdest,                                    '+SLineBreak+
           '                              pfcpufdest,                                   '+SLineBreak+
           '                              picmsufdest,                                  '+SLineBreak+
           '                              picmsinter,                                   '+SLineBreak+
           '                              picmsinterpart,                               '+SLineBreak+
           '                              vfcpufdest,                                   '+SLineBreak+
           '                              vicmsufdest,                                  '+SLineBreak+
           '                              vicmsufremet,                                 '+SLineBreak+
           '                              combo_item,                                   '+SLineBreak+
           '                              vlrvenda_minimo,                              '+SLineBreak+
           '                              vlrvenda_maximo,                              '+SLineBreak+
           '                              impresso,                                     '+SLineBreak+
           '                              orcamento_tsb_id,                             '+SLineBreak+
           '                              gerente_comissao_percentual,                  '+SLineBreak+
           '                              xped,                                         '+SLineBreak+
           '                              nitemped2,                                    '+SLineBreak+
           '                              voutros,                                      '+SLineBreak+
           '                              vfrete,                                       '+SLineBreak+
           '                              original_pedido_id,                           '+SLineBreak+
           '                              valor_venda_cadastro,                         '+SLineBreak+
           '                              web_pedidoitens_id,                           '+SLineBreak+
           '                              tipo_venda,                                   '+SLineBreak+
           '                              entrega,                                      '+SLineBreak+
           '                              vbcfcpst,                                     '+SLineBreak+
           '                              pfcpst,                                       '+SLineBreak+
           '                              vfcpst,                                       '+SLineBreak+
           '                              valor_bonus_servico,                          '+SLineBreak+
           '                              cbenef,                                       '+SLineBreak+
           '                              vicmsdeson,                                   '+SLineBreak+
           '                              motdesicms,                                   '+SLineBreak+
           '                              valor_diferimento,                            '+SLineBreak+
           '                              valor_montador,                               '+SLineBreak+
           '                              montagem,                                     '+SLineBreak+
           '                              pcred_presumido,                              '+SLineBreak+
           '                              pedidocompraitens_id,                         '+SLineBreak+
           '                              pedidoitens_id,                               '+SLineBreak+
           '                              pis_cst,                                      '+SLineBreak+
           '                              cofins_cst,                                   '+SLineBreak+
           '                              ipi_cst,                                      '+SLineBreak+
           '                              csosn,                                        '+SLineBreak+
           '                              cfop)                                         '+SLineBreak+
           '     values (:codigo_cli,                                                   '+SLineBreak+
           '             :numero_ped,                                                   '+SLineBreak+
           '             :codigo_pro,                                                   '+SLineBreak+
           '             :quantidade_ped,                                               '+SLineBreak+
           '             :quantidade_troca,                                             '+SLineBreak+
           '             :valorunitario_ped,                                            '+SLineBreak+
           '             :desconto_ped,                                                 '+SLineBreak+
           '             :desconto_uf,                                                  '+SLineBreak+
           '             :valor_ipi,                                                    '+SLineBreak+
           '             :valor_st,                                                     '+SLineBreak+
           '             :vlrvenda_pro,                                                 '+SLineBreak+
           '             :vlrcusto_pro,                                                 '+SLineBreak+
           '             :comissao_ped,                                                 '+SLineBreak+
           '             :tipo_nf,                                                      '+SLineBreak+
           '             :quantidade_tipo,                                              '+SLineBreak+
           '             :observacao,                                                   '+SLineBreak+
           '             :ctr_exportacao,                                               '+SLineBreak+
           '             :produto_referencia,                                           '+SLineBreak+
           '             :obs_item,                                                     '+SLineBreak+
           '             :reserva_id,                                                   '+SLineBreak+
           '             :loja,                                                         '+SLineBreak+
           '             :aliq_ipi,                                                     '+SLineBreak+
           '             :valor_restituicao_st,                                         '+SLineBreak+
           '             :cfop_id,                                                      '+SLineBreak+
           '             :cst,                                                          '+SLineBreak+
           '             :aliq_icms,                                                    '+SLineBreak+
           '             :aliq_icms_st,                                                 '+SLineBreak+
           '             :reducao_st,                                                   '+SLineBreak+
           '             :mva,                                                          '+SLineBreak+
           '             :reducao_icms,                                                 '+SLineBreak+
           '             :base_icms,                                                    '+SLineBreak+
           '             :valor_icms,                                                   '+SLineBreak+
           '             :base_st,                                                      '+SLineBreak+
           '             :desc_restituicao_st,                                          '+SLineBreak+
           '             :icms_suframa,                                                 '+SLineBreak+
           '             :pis_suframa,                                                  '+SLineBreak+
           '             :cofins_suframa,                                               '+SLineBreak+
           '             :ipi_suframa,                                                  '+SLineBreak+
           '             :aliq_pis,                                                     '+SLineBreak+
           '             :aliq_cofins,                                                  '+SLineBreak+
           '             :base_pis,                                                     '+SLineBreak+
           '             :base_cofins,                                                  '+SLineBreak+
           '             :valor_pis,                                                    '+SLineBreak+
           '             :valor_cofins,                                                 '+SLineBreak+
           '             :prevenda_id,                                                  '+SLineBreak+
           '             :avulso,                                                       '+SLineBreak+
           '             :quantidade_new,                                               '+SLineBreak+
           '             :balanca,                                                      '+SLineBreak+
           '             :ambiente_id,                                                  '+SLineBreak+
           '             :ambiente_obs,                                                 '+SLineBreak+
           '             :projeto_id,                                                   '+SLineBreak+
           '             :largura,                                                      '+SLineBreak+
           '             :altura,                                                       '+SLineBreak+
           '             :item,                                                         '+SLineBreak+
           '             :dun14,                                                        '+SLineBreak+
           '             :saidas_id,                                                    '+SLineBreak+
           '             :custo_drg,                                                    '+SLineBreak+
           '             :pos_venda_status,                                             '+SLineBreak+
           '             :pos_venda_retorno,                                            '+SLineBreak+
           '             :pos_venda_obs,                                                '+SLineBreak+
           '             :bonus,                                                        '+SLineBreak+
           '             :bonus_uso,                                                    '+SLineBreak+
           '             :funcionario_id,                                               '+SLineBreak+
           '             :producao_id,                                                  '+SLineBreak+
           '             :quantidade_kg,                                                '+SLineBreak+
           '             :reservado,                                                    '+SLineBreak+
           '             :descricao_produto,                                            '+SLineBreak+
           '             :comissao_percentual,                                          '+SLineBreak+
           '             :qtd_checagem,                                                 '+SLineBreak+
           '             :qtd_checagem_corte,                                           '+SLineBreak+
           '             :altura_m,                                                     '+SLineBreak+
           '             :largura_m,                                                    '+SLineBreak+
           '             :profundidade_m,                                               '+SLineBreak+
           '             :vbcufdest,                                                    '+SLineBreak+
           '             :pfcpufdest,                                                   '+SLineBreak+
           '             :picmsufdest,                                                  '+SLineBreak+
           '             :picmsinter,                                                   '+SLineBreak+
           '             :picmsinterpart,                                               '+SLineBreak+
           '             :vfcpufdest,                                                   '+SLineBreak+
           '             :vicmsufdest,                                                  '+SLineBreak+
           '             :vicmsufremet,                                                 '+SLineBreak+
           '             :combo_item,                                                   '+SLineBreak+
           '             :vlrvenda_minimo,                                              '+SLineBreak+
           '             :vlrvenda_maximo,                                              '+SLineBreak+
           '             :impresso,                                                     '+SLineBreak+
           '             :orcamento_tsb_id,                                             '+SLineBreak+
           '             :gerente_comissao_percentual,                                  '+SLineBreak+
           '             :xped,                                                         '+SLineBreak+
           '             :nitemped2,                                                    '+SLineBreak+
           '             :voutros,                                                      '+SLineBreak+
           '             :vfrete,                                                       '+SLineBreak+
           '             :original_pedido_id,                                           '+SLineBreak+
           '             :valor_venda_cadastro,                                         '+SLineBreak+
           '             :web_pedidoitens_id,                                           '+SLineBreak+
           '             :tipo_venda,                                                   '+SLineBreak+
           '             :entrega,                                                      '+SLineBreak+
           '             :vbcfcpst,                                                     '+SLineBreak+
           '             :pfcpst,                                                       '+SLineBreak+
           '             :vfcpst,                                                       '+SLineBreak+
           '             :valor_bonus_servico,                                          '+SLineBreak+
           '             :cbenef,                                                       '+SLineBreak+
           '             :vicmsdeson,                                                   '+SLineBreak+
           '             :motdesicms,                                                   '+SLineBreak+
           '             :valor_diferimento,                                            '+SLineBreak+
           '             :valor_montador,                                               '+SLineBreak+
           '             :montagem,                                                     '+SLineBreak+
           '             :pcred_presumido,                                              '+SLineBreak+
           '             :pedidocompraitens_id,                                         '+SLineBreak+
           '             :pedidoitens_id,                                               '+SLineBreak+
           '             :pis_cst,                                                      '+SLineBreak+
           '             :cofins_cst,                                                   '+SLineBreak+
           '             :ipi_cst,                                                      '+SLineBreak+
           '             :csosn,                                                        '+SLineBreak+
           '             :cfop)                                                         '+SLineBreak+
           ' returning ID                                                               '+SLineBreak;
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, APedidoItensModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPedidoItensDao.incluirLote(APedidoItensModel: TPedidoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry     := vIConexao.CriarQuery;
  lSQL :=  '     insert into pedidoitens (codigo_cli,                                   '+SLineBreak+
           '                              numero_ped,                                   '+SLineBreak+
           '                              codigo_pro,                                   '+SLineBreak+
           '                              quantidade_ped,                               '+SLineBreak+
           '                              quantidade_troca,                             '+SLineBreak+
           '                              valorunitario_ped,                            '+SLineBreak+
           '                              desconto_ped,                                 '+SLineBreak+
           '                              desconto_uf,                                  '+SLineBreak+
           '                              valor_ipi,                                    '+SLineBreak+
           '                              valor_st,                                     '+SLineBreak+
           '                              vlrvenda_pro,                                 '+SLineBreak+
           '                              vlrcusto_pro,                                 '+SLineBreak+
           '                              comissao_ped,                                 '+SLineBreak+
           '                              tipo_nf,                                      '+SLineBreak+
           '                              quantidade_tipo,                              '+SLineBreak+
           '                              observacao,                                   '+SLineBreak+
           '                              ctr_exportacao,                               '+SLineBreak+
           '                              produto_referencia,                           '+SLineBreak+
           '                              obs_item,                                     '+SLineBreak+
           '                              reserva_id,                                   '+SLineBreak+
           '                              loja,                                         '+SLineBreak+
           '                              aliq_ipi,                                     '+SLineBreak+
           '                              valor_restituicao_st,                         '+SLineBreak+
           '                              cfop_id,                                      '+SLineBreak+
           '                              cst,                                          '+SLineBreak+
           '                              aliq_icms,                                    '+SLineBreak+
           '                              aliq_icms_st,                                 '+SLineBreak+
           '                              reducao_st,                                   '+SLineBreak+
           '                              mva,                                          '+SLineBreak+
           '                              reducao_icms,                                 '+SLineBreak+
           '                              base_icms,                                    '+SLineBreak+
           '                              valor_icms,                                   '+SLineBreak+
           '                              base_st,                                      '+SLineBreak+
           '                              desc_restituicao_st,                          '+SLineBreak+
           '                              icms_suframa,                                 '+SLineBreak+
           '                              pis_suframa,                                  '+SLineBreak+
           '                              cofins_suframa,                               '+SLineBreak+
           '                              ipi_suframa,                                  '+SLineBreak+
           '                              aliq_pis,                                     '+SLineBreak+
           '                              aliq_cofins,                                  '+SLineBreak+
           '                              base_pis,                                     '+SLineBreak+
           '                              base_cofins,                                  '+SLineBreak+
           '                              valor_pis,                                    '+SLineBreak+
           '                              valor_cofins,                                 '+SLineBreak+
           '                              prevenda_id,                                  '+SLineBreak+
           '                              avulso,                                       '+SLineBreak+
           '                              quantidade_new,                               '+SLineBreak+
           '                              balanca,                                      '+SLineBreak+
           '                              ambiente_id,                                  '+SLineBreak+
           '                              ambiente_obs,                                 '+SLineBreak+
           '                              projeto_id,                                   '+SLineBreak+
           '                              largura,                                      '+SLineBreak+
           '                              altura,                                       '+SLineBreak+
           '                              item,                                         '+SLineBreak+
           '                              dun14,                                        '+SLineBreak+
           '                              saidas_id,                                    '+SLineBreak+
           '                              custo_drg,                                    '+SLineBreak+
           '                              pos_venda_status,                             '+SLineBreak+
           '                              pos_venda_retorno,                            '+SLineBreak+
           '                              pos_venda_obs,                                '+SLineBreak+
           '                              bonus,                                        '+SLineBreak+
           '                              bonus_uso,                                    '+SLineBreak+
           '                              funcionario_id,                               '+SLineBreak+
           '                              producao_id,                                  '+SLineBreak+
           '                              quantidade_kg,                                '+SLineBreak+
           '                              reservado,                                    '+SLineBreak+
           '                              descricao_produto,                            '+SLineBreak+
           '                              comissao_percentual,                          '+SLineBreak+
           '                              qtd_checagem,                                 '+SLineBreak+
           '                              qtd_checagem_corte,                           '+SLineBreak+
           '                              altura_m,                                     '+SLineBreak+
           '                              largura_m,                                    '+SLineBreak+
           '                              profundidade_m,                               '+SLineBreak+
           '                              vbcufdest,                                    '+SLineBreak+
           '                              pfcpufdest,                                   '+SLineBreak+
           '                              picmsufdest,                                  '+SLineBreak+
           '                              picmsinter,                                   '+SLineBreak+
           '                              picmsinterpart,                               '+SLineBreak+
           '                              vfcpufdest,                                   '+SLineBreak+
           '                              vicmsufdest,                                  '+SLineBreak+
           '                              vicmsufremet,                                 '+SLineBreak+
           '                              combo_item,                                   '+SLineBreak+
           '                              vlrvenda_minimo,                              '+SLineBreak+
           '                              vlrvenda_maximo,                              '+SLineBreak+
           '                              impresso,                                     '+SLineBreak+
           '                              orcamento_tsb_id,                             '+SLineBreak+
           '                              gerente_comissao_percentual,                  '+SLineBreak+
           '                              xped,                                         '+SLineBreak+
           '                              nitemped2,                                    '+SLineBreak+
           '                              voutros,                                      '+SLineBreak+
           '                              vfrete,                                       '+SLineBreak+
           '                              original_pedido_id,                           '+SLineBreak+
           '                              valor_venda_cadastro,                         '+SLineBreak+
           '                              web_pedidoitens_id,                           '+SLineBreak+
           '                              tipo_venda,                                   '+SLineBreak+
           '                              entrega,                                      '+SLineBreak+
           '                              vbcfcpst,                                     '+SLineBreak+
           '                              pfcpst,                                       '+SLineBreak+
           '                              vfcpst,                                       '+SLineBreak+
           '                              valor_bonus_servico,                          '+SLineBreak+
           '                              cbenef,                                       '+SLineBreak+
           '                              vicmsdeson,                                   '+SLineBreak+
           '                              motdesicms,                                   '+SLineBreak+
           '                              valor_diferimento,                            '+SLineBreak+
           '                              valor_montador,                               '+SLineBreak+
           '                              montagem,                                     '+SLineBreak+
           '                              pcred_presumido,                              '+SLineBreak+
           '                              pedidocompraitens_id,                         '+SLineBreak+
           '                              pedidoitens_id,                               '+SLineBreak+
           '                              pis_cst,                                      '+SLineBreak+
           '                              cofins_cst,                                   '+SLineBreak+
           '                              ipi_cst,                                      '+SLineBreak+
           '                              csosn,                                        '+SLineBreak+
           '                              cfop)                                         '+SLineBreak+
           '     values (:codigo_cli,                                                   '+SLineBreak+
           '             :numero_ped,                                                   '+SLineBreak+
           '             :codigo_pro,                                                   '+SLineBreak+
           '             :quantidade_ped,                                               '+SLineBreak+
           '             :quantidade_troca,                                             '+SLineBreak+
           '             :valorunitario_ped,                                            '+SLineBreak+
           '             :desconto_ped,                                                 '+SLineBreak+
           '             :desconto_uf,                                                  '+SLineBreak+
           '             :valor_ipi,                                                    '+SLineBreak+
           '             :valor_st,                                                     '+SLineBreak+
           '             :vlrvenda_pro,                                                 '+SLineBreak+
           '             :vlrcusto_pro,                                                 '+SLineBreak+
           '             :comissao_ped,                                                 '+SLineBreak+
           '             :tipo_nf,                                                      '+SLineBreak+
           '             :quantidade_tipo,                                              '+SLineBreak+
           '             :observacao,                                                   '+SLineBreak+
           '             :ctr_exportacao,                                               '+SLineBreak+
           '             :produto_referencia,                                           '+SLineBreak+
           '             :obs_item,                                                     '+SLineBreak+
           '             :reserva_id,                                                   '+SLineBreak+
           '             :loja,                                                         '+SLineBreak+
           '             :aliq_ipi,                                                     '+SLineBreak+
           '             :valor_restituicao_st,                                         '+SLineBreak+
           '             :cfop_id,                                                      '+SLineBreak+
           '             :cst,                                                          '+SLineBreak+
           '             :aliq_icms,                                                    '+SLineBreak+
           '             :aliq_icms_st,                                                 '+SLineBreak+
           '             :reducao_st,                                                   '+SLineBreak+
           '             :mva,                                                          '+SLineBreak+
           '             :reducao_icms,                                                 '+SLineBreak+
           '             :base_icms,                                                    '+SLineBreak+
           '             :valor_icms,                                                   '+SLineBreak+
           '             :base_st,                                                      '+SLineBreak+
           '             :desc_restituicao_st,                                          '+SLineBreak+
           '             :icms_suframa,                                                 '+SLineBreak+
           '             :pis_suframa,                                                  '+SLineBreak+
           '             :cofins_suframa,                                               '+SLineBreak+
           '             :ipi_suframa,                                                  '+SLineBreak+
           '             :aliq_pis,                                                     '+SLineBreak+
           '             :aliq_cofins,                                                  '+SLineBreak+
           '             :base_pis,                                                     '+SLineBreak+
           '             :base_cofins,                                                  '+SLineBreak+
           '             :valor_pis,                                                    '+SLineBreak+
           '             :valor_cofins,                                                 '+SLineBreak+
           '             :prevenda_id,                                                  '+SLineBreak+
           '             :avulso,                                                       '+SLineBreak+
           '             :quantidade_new,                                               '+SLineBreak+
           '             :balanca,                                                      '+SLineBreak+
           '             :ambiente_id,                                                  '+SLineBreak+
           '             :ambiente_obs,                                                 '+SLineBreak+
           '             :projeto_id,                                                   '+SLineBreak+
           '             :largura,                                                      '+SLineBreak+
           '             :altura,                                                       '+SLineBreak+
           '             :item,                                                         '+SLineBreak+
           '             :dun14,                                                        '+SLineBreak+
           '             :saidas_id,                                                    '+SLineBreak+
           '             :custo_drg,                                                    '+SLineBreak+
           '             :pos_venda_status,                                             '+SLineBreak+
           '             :pos_venda_retorno,                                            '+SLineBreak+
           '             :pos_venda_obs,                                                '+SLineBreak+
           '             :bonus,                                                        '+SLineBreak+
           '             :bonus_uso,                                                    '+SLineBreak+
           '             :funcionario_id,                                               '+SLineBreak+
           '             :producao_id,                                                  '+SLineBreak+
           '             :quantidade_kg,                                                '+SLineBreak+
           '             :reservado,                                                    '+SLineBreak+
           '             :descricao_produto,                                            '+SLineBreak+
           '             :comissao_percentual,                                          '+SLineBreak+
           '             :qtd_checagem,                                                 '+SLineBreak+
           '             :qtd_checagem_corte,                                           '+SLineBreak+
           '             :altura_m,                                                     '+SLineBreak+
           '             :largura_m,                                                    '+SLineBreak+
           '             :profundidade_m,                                               '+SLineBreak+
           '             :vbcufdest,                                                    '+SLineBreak+
           '             :pfcpufdest,                                                   '+SLineBreak+
           '             :picmsufdest,                                                  '+SLineBreak+
           '             :picmsinter,                                                   '+SLineBreak+
           '             :picmsinterpart,                                               '+SLineBreak+
           '             :vfcpufdest,                                                   '+SLineBreak+
           '             :vicmsufdest,                                                  '+SLineBreak+
           '             :vicmsufremet,                                                 '+SLineBreak+
           '             :combo_item,                                                   '+SLineBreak+
           '             :vlrvenda_minimo,                                              '+SLineBreak+
           '             :vlrvenda_maximo,                                              '+SLineBreak+
           '             :impresso,                                                     '+SLineBreak+
           '             :orcamento_tsb_id,                                             '+SLineBreak+
           '             :gerente_comissao_percentual,                                  '+SLineBreak+
           '             :xped,                                                         '+SLineBreak+
           '             :nitemped2,                                                    '+SLineBreak+
           '             :voutros,                                                      '+SLineBreak+
           '             :vfrete,                                                       '+SLineBreak+
           '             :original_pedido_id,                                           '+SLineBreak+
           '             :valor_venda_cadastro,                                         '+SLineBreak+
           '             :web_pedidoitens_id,                                           '+SLineBreak+
           '             :tipo_venda,                                                   '+SLineBreak+
           '             :entrega,                                                      '+SLineBreak+
           '             :vbcfcpst,                                                     '+SLineBreak+
           '             :pfcpst,                                                       '+SLineBreak+
           '             :vfcpst,                                                       '+SLineBreak+
           '             :valor_bonus_servico,                                          '+SLineBreak+
           '             :cbenef,                                                       '+SLineBreak+
           '             :vicmsdeson,                                                   '+SLineBreak+
           '             :motdesicms,                                                   '+SLineBreak+
           '             :valor_diferimento,                                            '+SLineBreak+
           '             :valor_montador,                                               '+SLineBreak+
           '             :montagem,                                                     '+SLineBreak+
           '             :pcred_presumido,                                              '+SLineBreak+
           '             :pedidocompraitens_id,                                         '+SLineBreak+
           '             :pedidoitens_id,                                               '+SLineBreak+
           '             :pis_cst,                                                      '+SLineBreak+
           '             :cofins_cst,                                                   '+SLineBreak+
           '             :ipi_cst,                                                      '+SLineBreak+
           '             :csosn,                                                        '+SLineBreak+
           '             :cfop)                                                         '+SLineBreak;
  try
    lQry.SQL.Add(lSQL);
    lQry.Params.ArraySize := APedidoItensModel.PedidoItenssLista.Count;
    setParamsArray(lQry, APedidoItensModel);
    lQry.Execute(APedidoItensModel.PedidoItenssLista.Count, 0);
    Result := '';
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoItensDao.alterar(APedidoItensModel: TPedidoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := '     update pedidoitens                                                         '+SLineBreak+
          '        set codigo_cli = :codigo_cli,                                           '+SLineBreak+
          '            numero_ped = :numero_ped,                                           '+SLineBreak+
          '            codigo_pro = :codigo_pro,                                           '+SLineBreak+
          '            quantidade_ped = :quantidade_ped,                                   '+SLineBreak+
          '            quantidade_troca = :quantidade_troca,                               '+SLineBreak+
          '            valorunitario_ped = :valorunitario_ped,                             '+SLineBreak+
          '            desconto_ped = :desconto_ped,                                       '+SLineBreak+
          '            desconto_uf = :desconto_uf,                                         '+SLineBreak+
          '            valor_ipi = :valor_ipi,                                             '+SLineBreak+
          '            valor_st = :valor_st,                                               '+SLineBreak+
          '            vlrvenda_pro = :vlrvenda_pro,                                       '+SLineBreak+
          '            vlrcusto_pro = :vlrcusto_pro,                                       '+SLineBreak+
          '            comissao_ped = :comissao_ped,                                       '+SLineBreak+
          '            tipo_nf = :tipo_nf,                                                 '+SLineBreak+
          '            quantidade_tipo = :quantidade_tipo,                                 '+SLineBreak+
          '            observacao = :observacao,                                           '+SLineBreak+
          '            ctr_exportacao = :ctr_exportacao,                                   '+SLineBreak+
          '            produto_referencia = :produto_referencia,                           '+SLineBreak+
          '            obs_item = :obs_item,                                               '+SLineBreak+
          '            reserva_id = :reserva_id,                                           '+SLineBreak+
          '            aliq_ipi = :aliq_ipi,                                               '+SLineBreak+
          '            valor_restituicao_st = :valor_restituicao_st,                       '+SLineBreak+
          '            cfop_id = :cfop_id,                                                 '+SLineBreak+
          '            cst = :cst,                                                         '+SLineBreak+
          '            aliq_icms = :aliq_icms,                                             '+SLineBreak+
          '            aliq_icms_st = :aliq_icms_st,                                       '+SLineBreak+
          '            reducao_st = :reducao_st,                                           '+SLineBreak+
          '            mva = :mva,                                                         '+SLineBreak+
          '            reducao_icms = :reducao_icms,                                       '+SLineBreak+
          '            base_icms = :base_icms,                                             '+SLineBreak+
          '            valor_icms = :valor_icms,                                           '+SLineBreak+
          '            base_st = :base_st,                                                 '+SLineBreak+
          '            desc_restituicao_st = :desc_restituicao_st,                         '+SLineBreak+
          '            icms_suframa = :icms_suframa,                                       '+SLineBreak+
          '            pis_suframa = :pis_suframa,                                         '+SLineBreak+
          '            cofins_suframa = :cofins_suframa,                                   '+SLineBreak+
          '            ipi_suframa = :ipi_suframa,                                         '+SLineBreak+
          '            aliq_pis = :aliq_pis,                                               '+SLineBreak+
          '            aliq_cofins = :aliq_cofins,                                         '+SLineBreak+
          '            base_pis = :base_pis,                                               '+SLineBreak+
          '            base_cofins = :base_cofins,                                         '+SLineBreak+
          '            valor_pis = :valor_pis,                                             '+SLineBreak+
          '            valor_cofins = :valor_cofins,                                       '+SLineBreak+
          '            prevenda_id = :prevenda_id,                                         '+SLineBreak+
          '            avulso = :avulso,                                                   '+SLineBreak+
          '            quantidade_new = :quantidade_new,                                   '+SLineBreak+
          '            balanca = :balanca,                                                 '+SLineBreak+
          '            ambiente_id = :ambiente_id,                                         '+SLineBreak+
          '            ambiente_obs = :ambiente_obs,                                       '+SLineBreak+
          '            projeto_id = :projeto_id,                                           '+SLineBreak+
          '            largura = :largura,                                                 '+SLineBreak+
          '            altura = :altura,                                                   '+SLineBreak+
          '            item = :item,                                                       '+SLineBreak+
          '            dun14 = :dun14,                                                     '+SLineBreak+
          '            saidas_id = :saidas_id,                                             '+SLineBreak+
          '            custo_drg = :custo_drg,                                             '+SLineBreak+
          '            pos_venda_status = :pos_venda_status,                               '+SLineBreak+
          '            pos_venda_retorno = :pos_venda_retorno,                             '+SLineBreak+
          '            pos_venda_obs = :pos_venda_obs,                                     '+SLineBreak+
          '            bonus = :bonus,                                                     '+SLineBreak+
          '            bonus_uso = :bonus_uso,                                             '+SLineBreak+
          '            funcionario_id = :funcionario_id,                                   '+SLineBreak+
          '            producao_id = :producao_id,                                         '+SLineBreak+
          '            quantidade_kg = :quantidade_kg,                                     '+SLineBreak+
          '            reservado = :reservado,                                             '+SLineBreak+
          '            descricao_produto = :descricao_produto,                             '+SLineBreak+
          '            comissao_percentual = :comissao_percentual,                         '+SLineBreak+
          '            qtd_checagem = :qtd_checagem,                                       '+SLineBreak+
          '            qtd_checagem_corte = :qtd_checagem_corte,                           '+SLineBreak+
          '            altura_m = :altura_m,                                               '+SLineBreak+
          '            largura_m = :largura_m,                                             '+SLineBreak+
          '            profundidade_m = :profundidade_m,                                   '+SLineBreak+
          '            vbcufdest = :vbcufdest,                                             '+SLineBreak+
          '            pfcpufdest = :pfcpufdest,                                           '+SLineBreak+
          '            picmsufdest = :picmsufdest,                                         '+SLineBreak+
          '            picmsinter = :picmsinter,                                           '+SLineBreak+
          '            picmsinterpart = :picmsinterpart,                                   '+SLineBreak+
          '            vfcpufdest = :vfcpufdest,                                           '+SLineBreak+
          '            vicmsufdest = :vicmsufdest,                                         '+SLineBreak+
          '            vicmsufremet = :vicmsufremet,                                       '+SLineBreak+
          '            combo_item = :combo_item,                                           '+SLineBreak+
          '            vlrvenda_minimo = :vlrvenda_minimo,                                 '+SLineBreak+
          '            vlrvenda_maximo = :vlrvenda_maximo,                                 '+SLineBreak+
          '            impresso = :impresso,                                               '+SLineBreak+
          '            orcamento_tsb_id = :orcamento_tsb_id,                               '+SLineBreak+
          '            gerente_comissao_percentual = :gerente_comissao_percentual,         '+SLineBreak+
          '            xped = :xped,                                                       '+SLineBreak+
          '            nitemped2 = :nitemped2,                                             '+SLineBreak+
          '            voutros = :voutros,                                                 '+SLineBreak+
          '            vfrete = :vfrete,                                                   '+SLineBreak+
          '            original_pedido_id = :original_pedido_id,                           '+SLineBreak+
          '            valor_venda_cadastro = :valor_venda_cadastro,                       '+SLineBreak+
          '            web_pedidoitens_id = :web_pedidoitens_id,                           '+SLineBreak+
          '            tipo_venda = :tipo_venda,                                           '+SLineBreak+
          '            entrega = :entrega,                                                 '+SLineBreak+
          '            vbcfcpst = :vbcfcpst,                                               '+SLineBreak+
          '            pfcpst = :pfcpst,                                                   '+SLineBreak+
          '            vfcpst = :vfcpst,                                                   '+SLineBreak+
          '            valor_bonus_servico = :valor_bonus_servico,                         '+SLineBreak+
          '            cbenef = :cbenef,                                                   '+SLineBreak+
          '            vicmsdeson = :vicmsdeson,                                           '+SLineBreak+
          '            motdesicms = :motdesicms,                                           '+SLineBreak+
          '            valor_diferimento = :valor_diferimento,                             '+SLineBreak+
          '            valor_montador = :valor_montador,                                   '+SLineBreak+
          '            montagem = :montagem,                                               '+SLineBreak+
          '            pcred_presumido = :pcred_presumido,                                 '+SLineBreak+
          '            pedidocompraitens_id = :pedidocompraitens_id,                       '+SLineBreak+
          '            pedidoitens_id = :pedidoitens_id,                                   '+SLineBreak+
          '            loja = :loja,                                                       '+SLineBreak+
          '            pis_cst = :pis_cst,                                                 '+SLineBreak+
          '            cofins_cst = :cofins_cst,                                           '+SLineBreak+
          '            ipi_cst = :ipi_cst,                                                 '+SLineBreak+
          '            csosn = :csosn,                                                     '+SLineBreak+
          '            cfop = :cfop                                                        '+SLineBreak+
          '      where (id = :id)                                                          '+SLineBreak;
  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value   := IIF(APedidoItensModel.ID   = '', Unassigned, APedidoItensModel.ID);
    setParams(lQry, APedidoItensModel);
    lQry.ExecSQL;
    Result := APedidoItensModel.ID;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoItensDao.excluir(APedidoItensModel: TPedidoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from pedidoitens where ID = :ID',[APedidoItensModel.ID]);
   lQry.ExecSQL;
   Result := APedidoItensModel.ID;
  finally
    lQry.Free;
  end;
end;

function TPedidoItensDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';
  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;
  if FIDPedidoVendaView <> '' then
    lSQL := lSQL + ' and pedidoitens.numero_ped = '+FIDPedidoVendaView;
  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and pedidoitens.id = '+FIDRecordView;
  Result := lSQL;
end;

procedure TPedidoItensDao.obterTotaisItens(pNumeroPedido: String);
var
  lQry     : TFDQuery;
  lSQL     : String;
begin
  lQry     := vIConexao.CriarQuery;
  try
    lSQL :=
      ' select sum( valorunitario_ped * qtde_calculada ) VALOR_TOTAL_ITENS,                                                             '+
      '        sum( qtde_calculada * coalesce(quantidade_tipo,0) ) VALOR_TOTAL_GARANTIA,                                                '+
      '        sum(cast(((cast(VALORUNITARIO_PED  as float) * desconto_ped / 100)) * qtde_calculada as float)) as VALOR_TOTAL_DESCONTO  '+
      '   from pedidoitens                                                                                                              '+
      '  where numero_ped = '+QuotedStr(pNumeroPedido);

    lQry.Open(lSQL);
    self.FVALOR_TOTAL_ITENS     := lQry.FieldByName('VALOR_TOTAL_ITENS').AsFloat;
    self.FVALOR_TOTAL_GARANTIA  := lQry.FieldByName('VALOR_TOTAL_GARANTIA').AsFloat;
    self.FVALOR_TOTAL_DESCONTO  := lQry.FieldByName('VALOR_TOTAL_DESCONTO').AsFloat;
    self.VALOR_TOTAL            := self.FVALOR_TOTAL_ITENS + self.FVALOR_TOTAL_GARANTIA - self.FVALOR_TOTAL_DESCONTO;
  finally
    lQry.Free;
  end;
end;

procedure TPedidoItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := 'select count(*) records From pedidoitens where 1=1 ';
    lSql := lSql + montaCondicaoQuery;
    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;
procedure TPedidoItensDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoItenssLista := TObjectList<TPedidoItensModel>.Create;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';
    lSQL := lSQL +
      '       pedidoitens.*      '+
	    '  from pedidoitens        '+
      ' where 1=1                ';
    lSql := lSql + montaCondicaoQuery;
    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;
    lQry.Open(lSQL);
    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPedidoItenssLista.Add(TPedidoItensModel.Create(vIConexao));
      i := FPedidoItenssLista.Count -1;
      FPedidoItenssLista[i].ID                           := lQry.FieldByName('ID').AsString;
      FPedidoItenssLista[i].CODIGO_CLI                   := lQry.FieldByName('CODIGO_CLI').AsString;
      FPedidoItenssLista[i].NUMERO_PED                   := lQry.FieldByName('NUMERO_PED').AsString;
      FPedidoItenssLista[i].CODIGO_PRO                   := lQry.FieldByName('CODIGO_PRO').AsString;
      FPedidoItenssLista[i].QUANTIDADE_PED               := lQry.FieldByName('QUANTIDADE_PED').AsString;
      FPedidoItenssLista[i].QUANTIDADE_TROCA             := lQry.FieldByName('QUANTIDADE_TROCA').AsString;
      FPedidoItenssLista[i].VALORUNITARIO_PED            := lQry.FieldByName('VALORUNITARIO_PED').AsString;
      FPedidoItenssLista[i].DESCONTO_PED                 := lQry.FieldByName('DESCONTO_PED').AsString;
      FPedidoItenssLista[i].DESCONTO_UF                  := lQry.FieldByName('DESCONTO_UF').AsString;
      FPedidoItenssLista[i].VALOR_IPI                    := lQry.FieldByName('VALOR_IPI').AsString;
      FPedidoItenssLista[i].VALOR_ST                     := lQry.FieldByName('VALOR_ST').AsString;
      FPedidoItenssLista[i].VLRVENDA_PRO                 := lQry.FieldByName('VLRVENDA_PRO').AsString;
      FPedidoItenssLista[i].VLRCUSTO_PRO                 := lQry.FieldByName('VLRCUSTO_PRO').AsString;
      FPedidoItenssLista[i].COMISSAO_PED                 := lQry.FieldByName('COMISSAO_PED').AsString;
      FPedidoItenssLista[i].TIPO_NF                      := lQry.FieldByName('TIPO_NF').AsString;
      FPedidoItenssLista[i].QUANTIDADE_TIPO              := lQry.FieldByName('QUANTIDADE_TIPO').AsString;
      FPedidoItenssLista[i].OBSERVACAO                   := lQry.FieldByName('OBSERVACAO').AsString;
      FPedidoItenssLista[i].CTR_EXPORTACAO               := lQry.FieldByName('CTR_EXPORTACAO').AsString;
      FPedidoItenssLista[i].PRODUTO_REFERENCIA           := lQry.FieldByName('PRODUTO_REFERENCIA').AsString;
      FPedidoItenssLista[i].OBS_ITEM                     := lQry.FieldByName('OBS_ITEM').AsString;
      FPedidoItenssLista[i].RESERVA_ID                   := lQry.FieldByName('RESERVA_ID').AsString;
      FPedidoItenssLista[i].LOJA                         := lQry.FieldByName('LOJA').AsString;
      FPedidoItenssLista[i].ALIQ_IPI                     := lQry.FieldByName('ALIQ_IPI').AsString;
      FPedidoItenssLista[i].VALOR_RESTITUICAO_ST         := lQry.FieldByName('VALOR_RESTITUICAO_ST').AsString;
      FPedidoItenssLista[i].CFOP_ID                      := lQry.FieldByName('CFOP_ID').AsString;
      FPedidoItenssLista[i].CST                          := lQry.FieldByName('CST').AsString;
      FPedidoItenssLista[i].ALIQ_ICMS                    := lQry.FieldByName('ALIQ_ICMS').AsString;
      FPedidoItenssLista[i].ALIQ_ICMS_ST                 := lQry.FieldByName('ALIQ_ICMS_ST').AsString;
      FPedidoItenssLista[i].REDUCAO_ST                   := lQry.FieldByName('REDUCAO_ST').AsString;
      FPedidoItenssLista[i].MVA                          := lQry.FieldByName('MVA').AsString;
      FPedidoItenssLista[i].REDUCAO_ICMS                 := lQry.FieldByName('REDUCAO_ICMS').AsString;
      FPedidoItenssLista[i].BASE_ICMS                    := lQry.FieldByName('BASE_ICMS').AsString;
      FPedidoItenssLista[i].VALOR_ICMS                   := lQry.FieldByName('VALOR_ICMS').AsString;
      FPedidoItenssLista[i].BASE_ST                      := lQry.FieldByName('BASE_ST').AsString;
      FPedidoItenssLista[i].DESC_RESTITUICAO_ST          := lQry.FieldByName('DESC_RESTITUICAO_ST').AsString;
      FPedidoItenssLista[i].ICMS_SUFRAMA                 := lQry.FieldByName('ICMS_SUFRAMA').AsString;
      FPedidoItenssLista[i].PIS_SUFRAMA                  := lQry.FieldByName('PIS_SUFRAMA').AsString;
      FPedidoItenssLista[i].COFINS_SUFRAMA               := lQry.FieldByName('COFINS_SUFRAMA').AsString;
      FPedidoItenssLista[i].IPI_SUFRAMA                  := lQry.FieldByName('IPI_SUFRAMA').AsString;
      FPedidoItenssLista[i].ALIQ_PIS                     := lQry.FieldByName('ALIQ_PIS').AsString;
      FPedidoItenssLista[i].ALIQ_COFINS                  := lQry.FieldByName('ALIQ_COFINS').AsString;
      FPedidoItenssLista[i].BASE_PIS                     := lQry.FieldByName('BASE_PIS').AsString;
      FPedidoItenssLista[i].BASE_COFINS                  := lQry.FieldByName('BASE_COFINS').AsString;
      FPedidoItenssLista[i].VALOR_PIS                    := lQry.FieldByName('VALOR_PIS').AsString;
      FPedidoItenssLista[i].VALOR_COFINS                 := lQry.FieldByName('VALOR_COFINS').AsString;
      FPedidoItenssLista[i].PREVENDA_ID                  := lQry.FieldByName('PREVENDA_ID').AsString;
      FPedidoItenssLista[i].AVULSO                       := lQry.FieldByName('AVULSO').AsString;
      FPedidoItenssLista[i].QUANTIDADE_NEW               := lQry.FieldByName('QUANTIDADE_NEW').AsString;
      FPedidoItenssLista[i].BALANCA                      := lQry.FieldByName('BALANCA').AsString;
      FPedidoItenssLista[i].QTDE_CALCULADA               := lQry.FieldByName('QTDE_CALCULADA').AsString;
      FPedidoItenssLista[i].SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
      FPedidoItenssLista[i].AMBIENTE_ID                  := lQry.FieldByName('AMBIENTE_ID').AsString;
      FPedidoItenssLista[i].AMBIENTE_OBS                 := lQry.FieldByName('AMBIENTE_OBS').AsString;
      FPedidoItenssLista[i].PROJETO_ID                   := lQry.FieldByName('PROJETO_ID').AsString;
      FPedidoItenssLista[i].LARGURA                      := lQry.FieldByName('LARGURA').AsString;
      FPedidoItenssLista[i].ALTURA                       := lQry.FieldByName('ALTURA').AsString;
      FPedidoItenssLista[i].ITEM                         := lQry.FieldByName('ITEM').AsString;
      FPedidoItenssLista[i].DUN14                        := lQry.FieldByName('DUN14').AsString;
      FPedidoItenssLista[i].SAIDAS_ID                    := lQry.FieldByName('SAIDAS_ID').AsString;
      FPedidoItenssLista[i].CUSTO_DRG                    := lQry.FieldByName('CUSTO_DRG').AsString;
      FPedidoItenssLista[i].POS_VENDA_STATUS             := lQry.FieldByName('POS_VENDA_STATUS').AsString;
      FPedidoItenssLista[i].POS_VENDA_RETORNO            := lQry.FieldByName('POS_VENDA_RETORNO').AsString;
      FPedidoItenssLista[i].POS_VENDA_OBS                := lQry.FieldByName('POS_VENDA_OBS').AsString;
      FPedidoItenssLista[i].VALOR_SUFRAMA_ITEM_NEW       := lQry.FieldByName('VALOR_SUFRAMA_ITEM_NEW').AsString;
      FPedidoItenssLista[i].VALOR_SUFRAMA_ITEM           := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
      FPedidoItenssLista[i].BONUS                        := lQry.FieldByName('BONUS').AsString;
      FPedidoItenssLista[i].BONUS_USO                    := lQry.FieldByName('BONUS_USO').AsString;
      FPedidoItenssLista[i].FUNCIONARIO_ID               := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      FPedidoItenssLista[i].PRODUCAO_ID                  := lQry.FieldByName('PRODUCAO_ID').AsString;
      FPedidoItenssLista[i].QUANTIDADE_KG                := lQry.FieldByName('QUANTIDADE_KG').AsString;
      FPedidoItenssLista[i].RESERVADO                    := lQry.FieldByName('RESERVADO').AsString;
      FPedidoItenssLista[i].DESCRICAO_PRODUTO            := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
      FPedidoItenssLista[i].COMISSAO_PERCENTUAL          := lQry.FieldByName('COMISSAO_PERCENTUAL').AsString;
      FPedidoItenssLista[i].QTD_CHECAGEM                 := lQry.FieldByName('QTD_CHECAGEM').AsString;
      FPedidoItenssLista[i].QTD_CHECAGEM_CORTE           := lQry.FieldByName('QTD_CHECAGEM_CORTE').AsString;
      FPedidoItenssLista[i].ALTURA_M                     := lQry.FieldByName('ALTURA_M').AsString;
      FPedidoItenssLista[i].LARGURA_M                    := lQry.FieldByName('LARGURA_M').AsString;
      FPedidoItenssLista[i].PROFUNDIDADE_M               := lQry.FieldByName('PROFUNDIDADE_M').AsString;
      FPedidoItenssLista[i].VBCUFDEST                    := lQry.FieldByName('VBCUFDEST').AsString;
      FPedidoItenssLista[i].PFCPUFDEST                   := lQry.FieldByName('PFCPUFDEST').AsString;
      FPedidoItenssLista[i].PICMSUFDEST                  := lQry.FieldByName('PICMSUFDEST').AsString;
      FPedidoItenssLista[i].PICMSINTER                   := lQry.FieldByName('PICMSINTER').AsString;
      FPedidoItenssLista[i].PICMSINTERPART               := lQry.FieldByName('PICMSINTERPART').AsString;
      FPedidoItenssLista[i].VFCPUFDEST                   := lQry.FieldByName('VFCPUFDEST').AsString;
      FPedidoItenssLista[i].VICMSUFDEST                  := lQry.FieldByName('VICMSUFDEST').AsString;
      FPedidoItenssLista[i].VICMSUFREMET                 := lQry.FieldByName('VICMSUFREMET').AsString;
      FPedidoItenssLista[i].COMBO_ITEM                   := lQry.FieldByName('COMBO_ITEM').AsString;
      FPedidoItenssLista[i].VLRVENDA_MINIMO              := lQry.FieldByName('VLRVENDA_MINIMO').AsString;
      FPedidoItenssLista[i].VLRVENDA_MAXIMO              := lQry.FieldByName('VLRVENDA_MAXIMO').AsString;
      FPedidoItenssLista[i].IMPRESSO                     := lQry.FieldByName('IMPRESSO').AsString;
      FPedidoItenssLista[i].ORCAMENTO_TSB_ID             := lQry.FieldByName('ORCAMENTO_TSB_ID').AsString;
      FPedidoItenssLista[i].GERENTE_COMISSAO_PERCENTUAL  := lQry.FieldByName('GERENTE_COMISSAO_PERCENTUAL').AsString;
      FPedidoItenssLista[i].XPED                         := lQry.FieldByName('XPED').AsString;
      FPedidoItenssLista[i].NITEMPED2                    := lQry.FieldByName('NITEMPED2').AsString;
      FPedidoItenssLista[i].VOUTROS                      := lQry.FieldByName('VOUTROS').AsString;
      FPedidoItenssLista[i].VFRETE                       := lQry.FieldByName('VFRETE').AsString;
      FPedidoItenssLista[i].ORIGINAL_PEDIDO_ID           := lQry.FieldByName('ORIGINAL_PEDIDO_ID').AsString;
      FPedidoItenssLista[i].VALOR_VENDA_CADASTRO         := lQry.FieldByName('VALOR_VENDA_CADASTRO').AsString;
      FPedidoItenssLista[i].WEB_PEDIDOITENS_ID           := lQry.FieldByName('WEB_PEDIDOITENS_ID').AsString;
      FPedidoItenssLista[i].TIPO_VENDA                   := lQry.FieldByName('TIPO_VENDA').AsString;
      FPedidoItenssLista[i].ENTREGA                      := lQry.FieldByName('ENTREGA').AsString;
      FPedidoItenssLista[i].VBCFCPST                     := lQry.FieldByName('VBCFCPST').AsString;
      FPedidoItenssLista[i].PFCPST                       := lQry.FieldByName('PFCPST').AsString;
      FPedidoItenssLista[i].VFCPST                       := lQry.FieldByName('VFCPST').AsString;
      FPedidoItenssLista[i].VALOR_BONUS_SERVICO          := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
      FPedidoItenssLista[i].CBENEF                       := lQry.FieldByName('CBENEF').AsString;
      FPedidoItenssLista[i].VICMSDESON                   := lQry.FieldByName('VICMSDESON').AsString;
      FPedidoItenssLista[i].MOTDESICMS                   := lQry.FieldByName('MOTDESICMS').AsString;
      FPedidoItenssLista[i].VALOR_DIFERIMENTO            := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
      FPedidoItenssLista[i].VALOR_MONTADOR               := lQry.FieldByName('VALOR_MONTADOR').AsString;
      FPedidoItenssLista[i].MONTAGEM                     := lQry.FieldByName('MONTAGEM').AsString;
      FPedidoItenssLista[i].PCRED_PRESUMIDO              := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
      FPedidoItenssLista[i].PEDIDOCOMPRAITENS_ID         := lQry.FieldByName('PEDIDOCOMPRAITENS_ID').AsString;
      FPedidoItenssLista[i].PEDIDOITENS_ID               := lQry.FieldByName('PEDIDOITENS_ID').AsString;
      FPedidoItenssLista[i].PIS_CST                      := lQry.FieldByName('PIS_CST').AsString;
      FPedidoItenssLista[i].COFINS_CST                   := lQry.FieldByName('COFINS_CST').AsString;
      FPedidoItenssLista[i].IPI_CST                      := lQry.FieldByName('IPI_CST').AsString;
      FPedidoItenssLista[i].CSOSN                        := lQry.FieldByName('CSOSN').AsString;
      FPedidoItenssLista[i].CFOP                         := lQry.FieldByName('CFOP').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;
procedure TPedidoItensDao.obterItensPedido(pNumeroPedido: String);
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoItenssLista := TObjectList<TPedidoItensModel>.Create;
  try
    lSQL :=
    ' select                                             '+#13+
    '   i.id,                                            '+#13+
    '   i.codigo_pro,                                    '+#13+
    '   p.barras_pro,                                    '+#13+
    '   p.nome_pro,                                      '+#13+
    '   i.quantidade_ped,                                '+#13+
    '   i.valorunitario_ped,                             '+#13+
    '   i.desconto_ped,                                  '+#13+
    '   i.item,                                          '+#13+
    '   i.valorunitario_ped * i.quantidade_ped total     '+#13+
    ' from                                               '+#13+
    '     pedidoitens i                                  '+#13+
    '                                                    '+#13+
    ' left join produto p on p.codigo_pro = i.codigo_pro '+#13+
    '                                                    '+#13+
    ' where                                              '+#13+
    '     i.numero_ped = '+QuotedStr(pNumeroPedido);
    lQry.Open(lSQL);
    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPedidoItenssLista.Add(TPedidoItensModel.Create(vIConexao));
      i := FPedidoItenssLista.Count -1;
      FPedidoItenssLista[i].ID                := lQry.FieldByName('ID').AsString;
      FPedidoItenssLista[i].CODIGO_PRO        := lQry.FieldByName('CODIGO_PRO').AsString;
      FPedidoItenssLista[i].BARRAS_PRO        := lQry.FieldByName('BARRAS_PRO').AsString;
      FPedidoItenssLista[i].NOME_PRO          := lQry.FieldByName('NOME_PRO').AsString;
      FPedidoItenssLista[i].QUANTIDADE_PED    := lQry.FieldByName('QUANTIDADE_PED').AsFloat;
      FPedidoItenssLista[i].VALORUNITARIO_PED := lQry.FieldByName('VALORUNITARIO_PED').AsFloat;
      FPedidoItenssLista[i].DESCONTO_PED      := lQry.FieldByName('DESCONTO_PED').AsFloat;
      FPedidoItenssLista[i].ITEM              := lQry.FieldByName('ITEM').AsFloat;
      FPedidoItenssLista[i].TOTAL             := lQry.FieldByName('TOTAL').AsFloat;
      lQry.Next;
    end;
  finally
    lQry.Free;
  end;
end;
procedure TPedidoItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TPedidoItensDao.SetPedidoItenssLista(const Value: TObjectList<TPedidoItensModel>);
begin
  FPedidoItenssLista := Value;
end;
procedure TPedidoItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;
procedure TPedidoItensDao.SetIDPedidoVendaView(const Value: String);
begin
  FIDPedidoVendaView := Value;
end;
procedure TPedidoItensDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;
procedure TPedidoItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;
procedure TPedidoItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;
procedure TPedidoItensDao.setParams(var pQry: TFDQuery; pPedidoItensModel: TPedidoItensModel);
begin
  pQry.ParamByName('codigo_cli').Value                   := IIF(pPedidoItensModel.CODIGO_CLI                    = '', Unassigned, pPedidoItensModel.CODIGO_CLI);
  pQry.ParamByName('numero_ped').Value                   := IIF(pPedidoItensModel.NUMERO_PED                    = '', Unassigned, pPedidoItensModel.NUMERO_PED);
  pQry.ParamByName('codigo_pro').Value                   := IIF(pPedidoItensModel.CODIGO_PRO                    = '', Unassigned, pPedidoItensModel.CODIGO_PRO);
  pQry.ParamByName('quantidade_ped').Value               := IIF(pPedidoItensModel.QUANTIDADE_PED                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.QUANTIDADE_PED));
  pQry.ParamByName('quantidade_troca').Value             := IIF(pPedidoItensModel.QUANTIDADE_TROCA              = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.QUANTIDADE_TROCA));
  pQry.ParamByName('valorunitario_ped').Value            := IIF(pPedidoItensModel.VALORUNITARIO_PED             = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALORUNITARIO_PED));
  pQry.ParamByName('desconto_ped').Value                 := IIF(pPedidoItensModel.DESCONTO_PED                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.DESCONTO_PED));
  pQry.ParamByName('desconto_uf').Value                  := IIF(pPedidoItensModel.DESCONTO_UF                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.DESCONTO_UF));
  pQry.ParamByName('valor_ipi').Value                    := IIF(pPedidoItensModel.VALOR_IPI                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_IPI));
  pQry.ParamByName('valor_st').Value                     := IIF(pPedidoItensModel.VALOR_ST                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_ST));
  pQry.ParamByName('vlrvenda_pro').Value                 := IIF(pPedidoItensModel.VLRVENDA_PRO                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VLRVENDA_PRO));
  pQry.ParamByName('vlrcusto_pro').Value                 := IIF(pPedidoItensModel.VLRCUSTO_PRO                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VLRCUSTO_PRO));
  pQry.ParamByName('comissao_ped').Value                 := IIF(pPedidoItensModel.COMISSAO_PED                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.COMISSAO_PED));
  pQry.ParamByName('tipo_nf').Value                      := IIF(pPedidoItensModel.TIPO_NF                       = '', Unassigned, pPedidoItensModel.TIPO_NF);
  pQry.ParamByName('quantidade_tipo').Value              := IIF(pPedidoItensModel.QUANTIDADE_TIPO               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.QUANTIDADE_TIPO));
  pQry.ParamByName('observacao').Value                   := IIF(pPedidoItensModel.OBSERVACAO                    = '', Unassigned, pPedidoItensModel.OBSERVACAO);
  pQry.ParamByName('ctr_exportacao').Value               := IIF(pPedidoItensModel.CTR_EXPORTACAO                = '', Unassigned, pPedidoItensModel.CTR_EXPORTACAO);
  pQry.ParamByName('produto_referencia').Value           := IIF(pPedidoItensModel.PRODUTO_REFERENCIA            = '', Unassigned, pPedidoItensModel.PRODUTO_REFERENCIA);
  pQry.ParamByName('obs_item').Value                     := IIF(pPedidoItensModel.OBS_ITEM                      = '', Unassigned, pPedidoItensModel.OBS_ITEM);
  pQry.ParamByName('reserva_id').Value                   := IIF(pPedidoItensModel.RESERVA_ID                    = '', Unassigned, pPedidoItensModel.RESERVA_ID);
  pQry.ParamByName('loja').Value                         := IIF(pPedidoItensModel.LOJA                          = '', Unassigned, pPedidoItensModel.LOJA);
  pQry.ParamByName('aliq_ipi').Value                     := IIF(pPedidoItensModel.ALIQ_IPI                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.ALIQ_IPI));
  pQry.ParamByName('valor_restituicao_st').Value         := IIF(pPedidoItensModel.VALOR_RESTITUICAO_ST          = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_RESTITUICAO_ST));
  pQry.ParamByName('cfop_id').Value                      := IIF(pPedidoItensModel.CFOP_ID                       = '', Unassigned, pPedidoItensModel.CFOP_ID);
  pQry.ParamByName('cst').Value                          := IIF(pPedidoItensModel.CST                           = '', Unassigned, pPedidoItensModel.CST);
  pQry.ParamByName('aliq_icms').Value                    := IIF(pPedidoItensModel.ALIQ_ICMS                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.ALIQ_ICMS));
  pQry.ParamByName('aliq_icms_st').Value                 := IIF(pPedidoItensModel.ALIQ_ICMS_ST                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.ALIQ_ICMS_ST));
  pQry.ParamByName('reducao_st').Value                   := IIF(pPedidoItensModel.REDUCAO_ST                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.REDUCAO_ST));
  pQry.ParamByName('mva').Value                          := IIF(pPedidoItensModel.MVA                           = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.MVA));
  pQry.ParamByName('reducao_icms').Value                 := IIF(pPedidoItensModel.REDUCAO_ICMS                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.REDUCAO_ICMS));
  pQry.ParamByName('base_icms').Value                    := IIF(pPedidoItensModel.BASE_ICMS                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.BASE_ICMS));
  pQry.ParamByName('valor_icms').Value                   := IIF(pPedidoItensModel.VALOR_ICMS                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_ICMS));
  pQry.ParamByName('base_st').Value                      := IIF(pPedidoItensModel.BASE_ST                       = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.BASE_ST));
  pQry.ParamByName('desc_restituicao_st').Value          := IIF(pPedidoItensModel.DESC_RESTITUICAO_ST           = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.DESC_RESTITUICAO_ST));
  pQry.ParamByName('icms_suframa').Value                 := IIF(pPedidoItensModel.ICMS_SUFRAMA                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.ICMS_SUFRAMA));
  pQry.ParamByName('pis_suframa').Value                  := IIF(pPedidoItensModel.PIS_SUFRAMA                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PIS_SUFRAMA));
  pQry.ParamByName('cofins_suframa').Value               := IIF(pPedidoItensModel.COFINS_SUFRAMA                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.COFINS_SUFRAMA));
  pQry.ParamByName('ipi_suframa').Value                  := IIF(pPedidoItensModel.IPI_SUFRAMA                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.IPI_SUFRAMA));
  pQry.ParamByName('aliq_pis').Value                     := IIF(pPedidoItensModel.ALIQ_PIS                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.ALIQ_PIS));
  pQry.ParamByName('aliq_cofins').Value                  := IIF(pPedidoItensModel.ALIQ_COFINS                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.ALIQ_COFINS));
  pQry.ParamByName('base_pis').Value                     := IIF(pPedidoItensModel.BASE_PIS                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.BASE_PIS));
  pQry.ParamByName('base_cofins').Value                  := IIF(pPedidoItensModel.BASE_COFINS                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.BASE_COFINS));
  pQry.ParamByName('valor_pis').Value                    := IIF(pPedidoItensModel.VALOR_PIS                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_PIS));
  pQry.ParamByName('valor_cofins').Value                 := IIF(pPedidoItensModel.VALOR_COFINS                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_COFINS));
  pQry.ParamByName('prevenda_id').Value                  := IIF(pPedidoItensModel.PREVENDA_ID                   = '', Unassigned, pPedidoItensModel.PREVENDA_ID);
  pQry.ParamByName('avulso').Value                       := IIF(pPedidoItensModel.AVULSO                        = '', Unassigned, pPedidoItensModel.AVULSO);
  pQry.ParamByName('quantidade_new').Value               := IIF(pPedidoItensModel.QUANTIDADE_NEW                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.QUANTIDADE_NEW));
  pQry.ParamByName('balanca').Value                      := IIF(pPedidoItensModel.BALANCA                       = '', Unassigned, pPedidoItensModel.BALANCA);
  pQry.ParamByName('ambiente_id').Value                  := IIF(pPedidoItensModel.AMBIENTE_ID                   = '', Unassigned, pPedidoItensModel.AMBIENTE_ID);
  pQry.ParamByName('ambiente_obs').Value                 := IIF(pPedidoItensModel.AMBIENTE_OBS                  = '', Unassigned, pPedidoItensModel.AMBIENTE_OBS);
  pQry.ParamByName('projeto_id').Value                   := IIF(pPedidoItensModel.PROJETO_ID                    = '', Unassigned, pPedidoItensModel.PROJETO_ID);
  pQry.ParamByName('largura').Value                      := IIF(pPedidoItensModel.LARGURA                       = '', Unassigned, pPedidoItensModel.LARGURA);
  pQry.ParamByName('altura').Value                       := IIF(pPedidoItensModel.ALTURA                        = '', Unassigned, pPedidoItensModel.ALTURA);
  pQry.ParamByName('item').Value                         := IIF(pPedidoItensModel.ITEM                          = '', Unassigned, pPedidoItensModel.ITEM);
  pQry.ParamByName('dun14').Value                        := IIF(pPedidoItensModel.DUN14                         = '', Unassigned, pPedidoItensModel.DUN14);
  pQry.ParamByName('saidas_id').Value                    := IIF(pPedidoItensModel.SAIDAS_ID                     = '', Unassigned, pPedidoItensModel.SAIDAS_ID);
  pQry.ParamByName('custo_drg').Value                    := IIF(pPedidoItensModel.CUSTO_DRG                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.CUSTO_DRG));
  pQry.ParamByName('pos_venda_status').Value             := IIF(pPedidoItensModel.POS_VENDA_STATUS              = '', Unassigned, pPedidoItensModel.POS_VENDA_STATUS);
  pQry.ParamByName('pos_venda_retorno').Value            := IIF(pPedidoItensModel.POS_VENDA_RETORNO             = '', Unassigned, pPedidoItensModel.POS_VENDA_RETORNO);
  pQry.ParamByName('pos_venda_obs').Value                := IIF(pPedidoItensModel.POS_VENDA_OBS                 = '', Unassigned, pPedidoItensModel.POS_VENDA_OBS);
  pQry.ParamByName('bonus').Value                        := IIF(pPedidoItensModel.BONUS                         = '', Unassigned, pPedidoItensModel.BONUS);
  pQry.ParamByName('bonus_uso').Value                    := IIF(pPedidoItensModel.BONUS_USO                     = '', Unassigned, pPedidoItensModel.BONUS_USO);
  pQry.ParamByName('funcionario_id').Value               := IIF(pPedidoItensModel.FUNCIONARIO_ID                = '', Unassigned, pPedidoItensModel.FUNCIONARIO_ID);
  pQry.ParamByName('producao_id').Value                  := IIF(pPedidoItensModel.PRODUCAO_ID                   = '', Unassigned, pPedidoItensModel.PRODUCAO_ID);
  pQry.ParamByName('quantidade_kg').Value                := IIF(pPedidoItensModel.QUANTIDADE_KG                 = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.QUANTIDADE_KG));
  pQry.ParamByName('reservado').Value                    := IIF(pPedidoItensModel.RESERVADO                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.RESERVADO));
  pQry.ParamByName('descricao_produto').Value            := IIF(pPedidoItensModel.DESCRICAO_PRODUTO             = '', Unassigned, pPedidoItensModel.DESCRICAO_PRODUTO);
  pQry.ParamByName('comissao_percentual').Value          := IIF(pPedidoItensModel.COMISSAO_PERCENTUAL           = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.COMISSAO_PERCENTUAL));
  pQry.ParamByName('qtd_checagem').Value                 := IIF(pPedidoItensModel.QTD_CHECAGEM                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.QTD_CHECAGEM));
  pQry.ParamByName('qtd_checagem_corte').Value           := IIF(pPedidoItensModel.QTD_CHECAGEM_CORTE            = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.QTD_CHECAGEM_CORTE));
  pQry.ParamByName('altura_m').Value                     := IIF(pPedidoItensModel.ALTURA_M                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.ALTURA_M));
  pQry.ParamByName('largura_m').Value                    := IIF(pPedidoItensModel.LARGURA_M                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.LARGURA_M));
  pQry.ParamByName('profundidade_m').Value               := IIF(pPedidoItensModel.PROFUNDIDADE_M                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PROFUNDIDADE_M));
  pQry.ParamByName('vbcufdest').Value                    := IIF(pPedidoItensModel.VBCUFDEST                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VBCUFDEST));
  pQry.ParamByName('pfcpufdest').Value                   := IIF(pPedidoItensModel.PFCPUFDEST                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PFCPUFDEST));
  pQry.ParamByName('picmsufdest').Value                  := IIF(pPedidoItensModel.PICMSUFDEST                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PICMSUFDEST));
  pQry.ParamByName('picmsinter').Value                   := IIF(pPedidoItensModel.PICMSINTER                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PICMSINTER));
  pQry.ParamByName('picmsinterpart').Value               := IIF(pPedidoItensModel.PICMSINTERPART                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PICMSINTERPART));
  pQry.ParamByName('vfcpufdest').Value                   := IIF(pPedidoItensModel.VFCPUFDEST                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VFCPUFDEST));
  pQry.ParamByName('vicmsufdest').Value                  := IIF(pPedidoItensModel.VICMSUFDEST                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VICMSUFDEST));
  pQry.ParamByName('vicmsufremet').Value                 := IIF(pPedidoItensModel.VICMSUFREMET                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VICMSUFREMET));
  pQry.ParamByName('combo_item').Value                   := IIF(pPedidoItensModel.COMBO_ITEM                    = '', Unassigned, pPedidoItensModel.COMBO_ITEM);
  pQry.ParamByName('vlrvenda_minimo').Value              := IIF(pPedidoItensModel.VLRVENDA_MINIMO               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VLRVENDA_MINIMO));
  pQry.ParamByName('vlrvenda_maximo').Value              := IIF(pPedidoItensModel.VLRVENDA_MAXIMO               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VLRVENDA_MAXIMO));
  pQry.ParamByName('impresso').Value                     := IIF(pPedidoItensModel.IMPRESSO                      = '', Unassigned, pPedidoItensModel.IMPRESSO);
  pQry.ParamByName('orcamento_tsb_id').Value             := IIF(pPedidoItensModel.ORCAMENTO_TSB_ID              = '', Unassigned, pPedidoItensModel.ORCAMENTO_TSB_ID);
  pQry.ParamByName('gerente_comissao_percentual').Value  := IIF(pPedidoItensModel.GERENTE_COMISSAO_PERCENTUAL   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.GERENTE_COMISSAO_PERCENTUAL));
  pQry.ParamByName('xped').Value                         := IIF(pPedidoItensModel.XPED                          = '', Unassigned, pPedidoItensModel.XPED);
  pQry.ParamByName('nitemped2').Value                    := IIF(pPedidoItensModel.NITEMPED2                     = '', Unassigned, pPedidoItensModel.NITEMPED2);
  pQry.ParamByName('voutros').Value                      := IIF(pPedidoItensModel.VOUTROS                       = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VOUTROS));
  pQry.ParamByName('vfrete').Value                       := IIF(pPedidoItensModel.VFRETE                        = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VFRETE));
  pQry.ParamByName('original_pedido_id').Value           := IIF(pPedidoItensModel.ORIGINAL_PEDIDO_ID            = '', Unassigned, pPedidoItensModel.ORIGINAL_PEDIDO_ID);
  pQry.ParamByName('valor_venda_cadastro').Value         := IIF(pPedidoItensModel.VALOR_VENDA_CADASTRO          = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_VENDA_CADASTRO));
  pQry.ParamByName('web_pedidoitens_id').Value           := IIF(pPedidoItensModel.WEB_PEDIDOITENS_ID            = '', Unassigned, pPedidoItensModel.WEB_PEDIDOITENS_ID);
  pQry.ParamByName('tipo_venda').Value                   := IIF(pPedidoItensModel.TIPO_VENDA                    = '', Unassigned, pPedidoItensModel.TIPO_VENDA);
  pQry.ParamByName('entrega').Value                      := IIF(pPedidoItensModel.ENTREGA                       = '', Unassigned, pPedidoItensModel.ENTREGA);
  pQry.ParamByName('vbcfcpst').Value                     := IIF(pPedidoItensModel.VBCFCPST                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VBCFCPST));
  pQry.ParamByName('pfcpst').Value                       := IIF(pPedidoItensModel.PFCPST                        = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PFCPST));
  pQry.ParamByName('vfcpst').Value                       := IIF(pPedidoItensModel.VFCPST                        = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VFCPST));
  pQry.ParamByName('valor_bonus_servico').Value          := IIF(pPedidoItensModel.VALOR_BONUS_SERVICO           = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_BONUS_SERVICO));
  pQry.ParamByName('cbenef').Value                       := IIF(pPedidoItensModel.CBENEF                        = '', Unassigned, pPedidoItensModel.CBENEF);
  pQry.ParamByName('vicmsdeson').Value                   := IIF(pPedidoItensModel.VICMSDESON                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VICMSDESON));
  pQry.ParamByName('motdesicms').Value                   := IIF(pPedidoItensModel.MOTDESICMS                    = '', Unassigned, pPedidoItensModel.MOTDESICMS);
  pQry.ParamByName('valor_diferimento').Value            := IIF(pPedidoItensModel.VALOR_DIFERIMENTO             = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_DIFERIMENTO));
  pQry.ParamByName('valor_montador').Value               := IIF(pPedidoItensModel.VALOR_MONTADOR                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.VALOR_MONTADOR));
  pQry.ParamByName('montagem').Value                     := IIF(pPedidoItensModel.MONTAGEM                      = '', Unassigned, pPedidoItensModel.MONTAGEM);
  pQry.ParamByName('pcred_presumido').Value              := IIF(pPedidoItensModel.PCRED_PRESUMIDO               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PCRED_PRESUMIDO));
  pQry.ParamByName('pedidocompraitens_id').Value         := IIF(pPedidoItensModel.PEDIDOCOMPRAITENS_ID          = '', Unassigned, pPedidoItensModel.PEDIDOCOMPRAITENS_ID);
  pQry.ParamByName('pedidoitens_id').Value               := IIF(pPedidoItensModel.PEDIDOITENS_ID                = '', Unassigned, pPedidoItensModel.PEDIDOITENS_ID);
  pQry.ParamByName('pis_cst').Value                      := IIF(pPedidoItensModel.PIS_CST                       = '', Unassigned, pPedidoItensModel.PIS_CST);
  pQry.ParamByName('cofins_cst').Value                   := IIF(pPedidoItensModel.COFINS_CST                    = '', Unassigned, pPedidoItensModel.COFINS_CST);
  pQry.ParamByName('ipi_cst').Value                      := IIF(pPedidoItensModel.IPI_CST                       = '', Unassigned, pPedidoItensModel.IPI_CST);
  pQry.ParamByName('csosn').Value                        := IIF(pPedidoItensModel.CSOSN                         = '', Unassigned, pPedidoItensModel.CSOSN);
  pQry.ParamByName('cfop').Value                         := IIF(pPedidoItensModel.CFOP                          = '', Unassigned, pPedidoItensModel.CFOP);
end;
procedure TPedidoItensDao.setParamsArray(var pQry: TFDQuery; pPedidoItensModel: TPedidoItensModel);
var
  lCount: Integer;
begin
  for lCount := 0 to Pred(pPedidoItensModel.PedidoItenssLista.Count) do
  begin
    pQry.ParamByName('codigo_cli').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CODIGO_CLI                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].CODIGO_CLI);
    pQry.ParamByName('numero_ped').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].NUMERO_PED                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].NUMERO_PED);
    pQry.ParamByName('codigo_pro').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CODIGO_PRO                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].CODIGO_PRO);
    pQry.ParamByName('quantidade_ped').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_PED                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_PED));
    pQry.ParamByName('quantidade_troca').Values[lCount]             := IIF(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_TROCA              = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_TROCA));
    pQry.ParamByName('valorunitario_ped').Values[lCount]            := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALORUNITARIO_PED             = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALORUNITARIO_PED));
    pQry.ParamByName('desconto_ped').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].DESCONTO_PED                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].DESCONTO_PED));
    pQry.ParamByName('desconto_uf').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].DESCONTO_UF                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].DESCONTO_UF));
    pQry.ParamByName('valor_ipi').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_IPI                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_IPI));
    pQry.ParamByName('valor_st').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_ST                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_ST));
    pQry.ParamByName('vlrvenda_pro').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VLRVENDA_PRO                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VLRVENDA_PRO));
    pQry.ParamByName('vlrcusto_pro').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VLRCUSTO_PRO                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VLRCUSTO_PRO));
    pQry.ParamByName('comissao_ped').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].COMISSAO_PED                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].COMISSAO_PED));
    pQry.ParamByName('tipo_nf').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].TIPO_NF                       = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].TIPO_NF);
    pQry.ParamByName('quantidade_tipo').Values[lCount]              := IIF(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_TIPO               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_TIPO));
    pQry.ParamByName('observacao').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].OBSERVACAO                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].OBSERVACAO);
    pQry.ParamByName('ctr_exportacao').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CTR_EXPORTACAO                = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].CTR_EXPORTACAO);
    pQry.ParamByName('produto_referencia').Values[lCount]           := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PRODUTO_REFERENCIA            = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].PRODUTO_REFERENCIA);
    pQry.ParamByName('obs_item').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].OBS_ITEM                      = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].OBS_ITEM);
    pQry.ParamByName('reserva_id').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].RESERVA_ID                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].RESERVA_ID);
    pQry.ParamByName('loja').Values[lCount]                         := IIF(pPedidoItensModel.PedidoItenssLista[lCount].LOJA                          = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].LOJA);
    pQry.ParamByName('aliq_ipi').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_IPI                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_IPI));
    pQry.ParamByName('valor_restituicao_st').Values[lCount]         := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_RESTITUICAO_ST          = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_RESTITUICAO_ST));
    pQry.ParamByName('cfop_id').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CFOP_ID                       = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].CFOP_ID);
    pQry.ParamByName('cst').Values[lCount]                          := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CST                           = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].CST);
    pQry.ParamByName('aliq_icms').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_ICMS                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_ICMS));
    pQry.ParamByName('aliq_icms_st').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_ICMS_ST                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_ICMS_ST));
    pQry.ParamByName('reducao_st').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].REDUCAO_ST                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].REDUCAO_ST));
    pQry.ParamByName('mva').Values[lCount]                          := IIF(pPedidoItensModel.PedidoItenssLista[lCount].MVA                           = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].MVA));
    pQry.ParamByName('reducao_icms').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].REDUCAO_ICMS                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].REDUCAO_ICMS));
    pQry.ParamByName('base_icms').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].BASE_ICMS                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].BASE_ICMS));
    pQry.ParamByName('valor_icms').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_ICMS                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_ICMS));
    pQry.ParamByName('base_st').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].BASE_ST                       = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].BASE_ST));
    pQry.ParamByName('desc_restituicao_st').Values[lCount]          := IIF(pPedidoItensModel.PedidoItenssLista[lCount].DESC_RESTITUICAO_ST           = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].DESC_RESTITUICAO_ST));
    pQry.ParamByName('icms_suframa').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ICMS_SUFRAMA                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].ICMS_SUFRAMA));
    pQry.ParamByName('pis_suframa').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PIS_SUFRAMA                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PIS_SUFRAMA));
    pQry.ParamByName('cofins_suframa').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].COFINS_SUFRAMA                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].COFINS_SUFRAMA));
    pQry.ParamByName('ipi_suframa').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].IPI_SUFRAMA                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].IPI_SUFRAMA));
    pQry.ParamByName('aliq_pis').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_PIS                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_PIS));
    pQry.ParamByName('aliq_cofins').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_COFINS                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].ALIQ_COFINS));
    pQry.ParamByName('base_pis').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].BASE_PIS                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].BASE_PIS));
    pQry.ParamByName('base_cofins').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].BASE_COFINS                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].BASE_COFINS));
    pQry.ParamByName('valor_pis').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_PIS                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_PIS));
    pQry.ParamByName('valor_cofins').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_COFINS                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_COFINS));
    pQry.ParamByName('prevenda_id').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PREVENDA_ID                   = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].PREVENDA_ID);
    pQry.ParamByName('avulso').Values[lCount]                       := IIF(pPedidoItensModel.PedidoItenssLista[lCount].AVULSO                        = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].AVULSO);
    pQry.ParamByName('quantidade_new').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_NEW                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_NEW));
    pQry.ParamByName('balanca').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].BALANCA                       = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].BALANCA);
    pQry.ParamByName('ambiente_id').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].AMBIENTE_ID                   = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].AMBIENTE_ID);
    pQry.ParamByName('ambiente_obs').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].AMBIENTE_OBS                  = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].AMBIENTE_OBS);
    pQry.ParamByName('projeto_id').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PROJETO_ID                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].PROJETO_ID);
    pQry.ParamByName('largura').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].LARGURA                       = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].LARGURA);
    pQry.ParamByName('altura').Values[lCount]                       := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ALTURA                        = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].ALTURA);
    pQry.ParamByName('item').Values[lCount]                         := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ITEM                          = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].ITEM);
    pQry.ParamByName('dun14').Values[lCount]                        := IIF(pPedidoItensModel.PedidoItenssLista[lCount].DUN14                         = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].DUN14);
    pQry.ParamByName('saidas_id').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].SAIDAS_ID                     = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].SAIDAS_ID);
    pQry.ParamByName('custo_drg').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CUSTO_DRG                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].CUSTO_DRG));
    pQry.ParamByName('pos_venda_status').Values[lCount]             := IIF(pPedidoItensModel.PedidoItenssLista[lCount].POS_VENDA_STATUS              = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].POS_VENDA_STATUS);
    pQry.ParamByName('pos_venda_retorno').Values[lCount]            := IIF(pPedidoItensModel.PedidoItenssLista[lCount].POS_VENDA_RETORNO             = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].POS_VENDA_RETORNO);
    pQry.ParamByName('pos_venda_obs').Values[lCount]                := IIF(pPedidoItensModel.PedidoItenssLista[lCount].POS_VENDA_OBS                 = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].POS_VENDA_OBS);
    pQry.ParamByName('bonus').Values[lCount]                        := IIF(pPedidoItensModel.PedidoItenssLista[lCount].BONUS                         = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].BONUS);
    pQry.ParamByName('bonus_uso').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].BONUS_USO                     = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].BONUS_USO);
    pQry.ParamByName('funcionario_id').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].FUNCIONARIO_ID                = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].FUNCIONARIO_ID);
    pQry.ParamByName('producao_id').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PRODUCAO_ID                   = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].PRODUCAO_ID);
    pQry.ParamByName('quantidade_kg').Values[lCount]                := IIF(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_KG                 = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].QUANTIDADE_KG));
    pQry.ParamByName('reservado').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].RESERVADO                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].RESERVADO));
    pQry.ParamByName('descricao_produto').Values[lCount]            := IIF(pPedidoItensModel.PedidoItenssLista[lCount].DESCRICAO_PRODUTO             = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].DESCRICAO_PRODUTO);
    pQry.ParamByName('comissao_percentual').Values[lCount]          := IIF(pPedidoItensModel.PedidoItenssLista[lCount].COMISSAO_PERCENTUAL           = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].COMISSAO_PERCENTUAL));
    pQry.ParamByName('qtd_checagem').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].QTD_CHECAGEM                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].QTD_CHECAGEM));
    pQry.ParamByName('qtd_checagem_corte').Values[lCount]           := IIF(pPedidoItensModel.PedidoItenssLista[lCount].QTD_CHECAGEM_CORTE            = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].QTD_CHECAGEM_CORTE));
    pQry.ParamByName('altura_m').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ALTURA_M                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].ALTURA_M));
    pQry.ParamByName('largura_m').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].LARGURA_M                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].LARGURA_M));
    pQry.ParamByName('profundidade_m').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PROFUNDIDADE_M                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PROFUNDIDADE_M));
    pQry.ParamByName('vbcufdest').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VBCUFDEST                     = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VBCUFDEST));
    pQry.ParamByName('pfcpufdest').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PFCPUFDEST                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PFCPUFDEST));
    pQry.ParamByName('picmsufdest').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PICMSUFDEST                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PICMSUFDEST));
    pQry.ParamByName('picmsinter').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PICMSINTER                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PICMSINTER));
    pQry.ParamByName('picmsinterpart').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PICMSINTERPART                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PICMSINTERPART));
    pQry.ParamByName('vfcpufdest').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VFCPUFDEST                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VFCPUFDEST));
    pQry.ParamByName('vicmsufdest').Values[lCount]                  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VICMSUFDEST                   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VICMSUFDEST));
    pQry.ParamByName('vicmsufremet').Values[lCount]                 := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VICMSUFREMET                  = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VICMSUFREMET));
    pQry.ParamByName('combo_item').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].COMBO_ITEM                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].COMBO_ITEM);
    pQry.ParamByName('vlrvenda_minimo').Values[lCount]              := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VLRVENDA_MINIMO               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VLRVENDA_MINIMO));
    pQry.ParamByName('vlrvenda_maximo').Values[lCount]              := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VLRVENDA_MAXIMO               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VLRVENDA_MAXIMO));
    pQry.ParamByName('impresso').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].IMPRESSO                      = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].IMPRESSO);
    pQry.ParamByName('orcamento_tsb_id').Values[lCount]             := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ORCAMENTO_TSB_ID              = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].ORCAMENTO_TSB_ID);
    pQry.ParamByName('gerente_comissao_percentual').Values[lCount]  := IIF(pPedidoItensModel.PedidoItenssLista[lCount].GERENTE_COMISSAO_PERCENTUAL   = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].GERENTE_COMISSAO_PERCENTUAL));
    pQry.ParamByName('xped').Values[lCount]                         := IIF(pPedidoItensModel.PedidoItenssLista[lCount].XPED                          = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].XPED);
    pQry.ParamByName('nitemped2').Values[lCount]                    := IIF(pPedidoItensModel.PedidoItenssLista[lCount].NITEMPED2                     = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].NITEMPED2);
    pQry.ParamByName('voutros').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VOUTROS                       = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VOUTROS));
    pQry.ParamByName('vfrete').Values[lCount]                       := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VFRETE                        = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VFRETE));
    pQry.ParamByName('original_pedido_id').Values[lCount]           := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ORIGINAL_PEDIDO_ID            = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].ORIGINAL_PEDIDO_ID);
    pQry.ParamByName('valor_venda_cadastro').Values[lCount]         := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_VENDA_CADASTRO          = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_VENDA_CADASTRO));
    pQry.ParamByName('web_pedidoitens_id').Values[lCount]           := IIF(pPedidoItensModel.PedidoItenssLista[lCount].WEB_PEDIDOITENS_ID            = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].WEB_PEDIDOITENS_ID);
    pQry.ParamByName('tipo_venda').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].TIPO_VENDA                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].TIPO_VENDA);
    pQry.ParamByName('entrega').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].ENTREGA                       = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].ENTREGA);
    pQry.ParamByName('vbcfcpst').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VBCFCPST                      = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VBCFCPST));
    pQry.ParamByName('pfcpst').Values[lCount]                       := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PFCPST                        = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PFCPST));
    pQry.ParamByName('vfcpst').Values[lCount]                       := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VFCPST                        = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VFCPST));
    pQry.ParamByName('valor_bonus_servico').Values[lCount]          := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_BONUS_SERVICO           = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_BONUS_SERVICO));
    pQry.ParamByName('cbenef').Values[lCount]                       := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CBENEF                        = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].CBENEF);
    pQry.ParamByName('vicmsdeson').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VICMSDESON                    = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VICMSDESON));
    pQry.ParamByName('motdesicms').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].MOTDESICMS                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].MOTDESICMS);
    pQry.ParamByName('valor_diferimento').Values[lCount]            := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_DIFERIMENTO             = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_DIFERIMENTO));
    pQry.ParamByName('valor_montador').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_MONTADOR                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VALOR_MONTADOR));
    pQry.ParamByName('montagem').Values[lCount]                     := IIF(pPedidoItensModel.PedidoItenssLista[lCount].MONTAGEM                      = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].MONTAGEM);
    pQry.ParamByName('pcred_presumido').Values[lCount]              := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PCRED_PRESUMIDO               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PCRED_PRESUMIDO));
    pQry.ParamByName('pedidocompraitens_id').Values[lCount]         := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PEDIDOCOMPRAITENS_ID          = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].PEDIDOCOMPRAITENS_ID);
    pQry.ParamByName('pedidoitens_id').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PEDIDOITENS_ID                = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].PEDIDOITENS_ID);
    pQry.ParamByName('pis_cst').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PIS_CST                       = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].PIS_CST);
    pQry.ParamByName('cofins_cst').Values[lCount]                   := IIF(pPedidoItensModel.PedidoItenssLista[lCount].COFINS_CST                    = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].COFINS_CST);
    pQry.ParamByName('ipi_cst').Values[lCount]                      := IIF(pPedidoItensModel.PedidoItenssLista[lCount].IPI_CST                       = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].IPI_CST);
    pQry.ParamByName('csosn').Values[lCount]                        := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CSOSN                         = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].CSOSN);
    pQry.ParamByName('cfop').Values[lCount]                         := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CFOP                          = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].CFOP);
  end;
end;

procedure TPedidoItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TPedidoItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TPedidoItensDao.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;
procedure TPedidoItensDao.SetVALOR_TOTAL_DESCONTO(const Value: Variant);
begin
  FVALOR_TOTAL_DESCONTO := Value;
end;
procedure TPedidoItensDao.SetVALOR_TOTAL_GARANTIA(const Value: Variant);
begin
  FVALOR_TOTAL_GARANTIA := Value;
end;
procedure TPedidoItensDao.SetVALOR_TOTAL_ITENS(const Value: Variant);
begin
  FVALOR_TOTAL_ITENS := Value;
end;
procedure TPedidoItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
end.
