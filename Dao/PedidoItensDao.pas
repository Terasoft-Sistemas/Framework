unit PedidoItensDao;
interface
uses
  PedidoItensModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Utils,
  Spring.Collections,
  Interfaces.Conexao;

type
  TPedidoItensDao = class
  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPedidoItenssLista: IList<TPedidoItensModel>;
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
    FSEGURO_PRESTAMISTA_VALOR: Variant;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPedidoItenssLista(const Value: IList<TPedidoItensModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);
    procedure SetIDPedidoVendaView(const Value: String);
    procedure SetVALOR_TOTAL_DESCONTO(const Value: Variant);
    procedure SetVALOR_TOTAL_GARANTIA(const Value: Variant);
    procedure SetVALOR_TOTAL_ITENS(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);

    procedure setParams(var pQry: TFDQuery; pPedidoItensModel: TPedidoItensModel);
    procedure setParamsArray(var pQry: TFDQuery; pPedidoItensModel: TPedidoItensModel);
    function where: String;
    procedure SetSEGURO_PRESTAMISTA_VALOR(const Value: Variant);

  public
    constructor Create(pConexao : IConexao);
    destructor Destroy; override;

    property PedidoItenssLista: IList<TPedidoItensModel> read FPedidoItenssLista write SetPedidoItenssLista;
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
    property SEGURO_PRESTAMISTA_VALOR: Variant read FSEGURO_PRESTAMISTA_VALOR write SetSEGURO_PRESTAMISTA_VALOR;

    function incluir(pPedidoItensModel: TPedidoItensModel): String;
    function incluirLote(pPedidoItensModel: TPedidoItensModel): String;
    function alterar(pPedidoItensModel: TPedidoItensModel): String;
    function excluir(pPedidoItensModel: TPedidoItensModel): String;

    procedure obterLista;
    procedure obterItensPedido(pNumeroPedido: String);
    procedure obterTotaisItens(pNumeroPedido: String);
    function carregaClasse(pId: String): TPedidoItensModel;
    function obterIDItem(pPedido, pProduto : String): String;
end;

implementation

{ TPedidoItens }

uses Terasoft.FuncoesTexto, System.Rtti;

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
  vIConexao   := pConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPedidoItensDao.Destroy;
begin
  FPedidoItenssLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TPedidoItensDao.incluir(pPedidoItensModel: TPedidoItensModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PEDIDOITENS', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoItensModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoItensDao.incluirLote(pPedidoItensModel: TPedidoItensModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PEDIDOITENS', '');

  try
    lQry.SQL.Add(lSQL);
    lQry.Params.ArraySize := pPedidoItensModel.PedidoItenssLista.Count;
    setParamsArray(lQry, pPedidoItensModel);
    lQry.Execute(pPedidoItensModel.PedidoItenssLista.Count, 0);
    Result := '';
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoItensDao.alterar(pPedidoItensModel: TPedidoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('PEDIDOITENS', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoItensModel);
    lQry.ExecSQL;
    Result := pPedidoItensModel.ID;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoItensDao.excluir(pPedidoItensModel: TPedidoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from pedidoitens where ID = :ID',[pPedidoItensModel.ID]);
   lQry.ExecSQL;
   Result := pPedidoItensModel.ID;
  finally
    lQry.Free;
  end;
end;

function TPedidoItensDao.where: String;
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
      ' select coalesce(pedidovenda.seguro_prestamista_valor, 0) seguro_prestamista_valor,                                                                   '+
      '        sum( valorunitario_ped * qtde_calculada ) VALOR_TOTAL_ITENS,                                                                                  '+
      '        sum( (qtde_calculada * coalesce(quantidade_tipo,0)) + (qtde_calculada * coalesce(VLR_GARANTIA_FR,0)) ) VALOR_TOTAL_GARANTIA,                  '+
      '        sum(round(cast(((cast(VALORUNITARIO_PED  as float) * pedidoitens.desconto_ped / 100)) * qtde_calculada as float),2)) as VALOR_TOTAL_DESCONTO  '+
      '   from pedidoitens                                                                                                                                   '+
      '  inner join pedidovenda on pedidovenda.numero_ped = pedidoitens.numero_ped                                                                           '+
      '  where pedidoitens.numero_ped = '+QuotedStr(pNumeroPedido) +
      '  group by 1';

    lQry.Open(lSQL);
    self.FVALOR_TOTAL_ITENS            := lQry.FieldByName('VALOR_TOTAL_ITENS').AsFloat;
    self.FVALOR_TOTAL_GARANTIA         := lQry.FieldByName('VALOR_TOTAL_GARANTIA').AsFloat;
    self.FVALOR_TOTAL_DESCONTO         := lQry.FieldByName('VALOR_TOTAL_DESCONTO').AsFloat;
    self.VALOR_TOTAL                   := self.FVALOR_TOTAL_ITENS + self.FVALOR_TOTAL_GARANTIA - self.FVALOR_TOTAL_DESCONTO;
    self.FSEGURO_PRESTAMISTA_VALOR     := lQry.FieldByName('SEGURO_PRESTAMISTA_VALOR').AsFloat;
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
    lSql := lSql + where;
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
  modelo: TPedidoItensModel;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoItenssLista := TCollections.CreateList<TPedidoItensModel>(true);

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       pedidoitens.*,                                               '+sLineBreak+
      '       produto.tipo_venda_comissao_id,                              '+sLineBreak+
      '       produto.comis_pro,                                           '+sLineBreak+
      '       produto.grupo_comissao_id                                    '+sLineBreak+
	    '  from pedidoitens                                                  '+sLineBreak+
      '  left join produto on produto.codigo_pro = pedidoitens.codigo_pro  '+sLineBreak+
      ' where 1=1                    ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPedidoItensModel.Create(vIConexao);
      FPedidoItenssLista.Add(modelo);

      modelo.ID                           := lQry.FieldByName('ID').AsString;
      modelo.CODIGO_CLI                   := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.NUMERO_PED                   := lQry.FieldByName('NUMERO_PED').AsString;
      modelo.CODIGO_PRO                   := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.QUANTIDADE_PED               := lQry.FieldByName('QUANTIDADE_PED').AsString;
      modelo.QUANTIDADE_TROCA             := lQry.FieldByName('QUANTIDADE_TROCA').AsString;
      modelo.VALORUNITARIO_PED            := lQry.FieldByName('VALORUNITARIO_PED').AsString;
      modelo.DESCONTO_PED                 := lQry.FieldByName('DESCONTO_PED').AsString;
      modelo.DESCONTO_UF                  := lQry.FieldByName('DESCONTO_UF').AsString;
      modelo.VALOR_IPI                    := lQry.FieldByName('VALOR_IPI').AsString;
      modelo.VALOR_ST                     := lQry.FieldByName('VALOR_ST').AsString;
      modelo.VLRVENDA_PRO                 := lQry.FieldByName('VLRVENDA_PRO').AsString;
      modelo.VLRCUSTO_PRO                 := lQry.FieldByName('VLRCUSTO_PRO').AsString;
      modelo.COMISSAO_PED                 := lQry.FieldByName('COMISSAO_PED').AsString;
      modelo.TIPO_NF                      := lQry.FieldByName('TIPO_NF').AsString;
      modelo.QUANTIDADE_TIPO              := lQry.FieldByName('QUANTIDADE_TIPO').AsString;
      modelo.OBSERVACAO                   := lQry.FieldByName('OBSERVACAO').AsString;
      modelo.CTR_EXPORTACAO               := lQry.FieldByName('CTR_EXPORTACAO').AsString;
      modelo.PRODUTO_REFERENCIA           := lQry.FieldByName('PRODUTO_REFERENCIA').AsString;
      modelo.OBS_ITEM                     := lQry.FieldByName('OBS_ITEM').AsString;
      modelo.RESERVA_ID                   := lQry.FieldByName('RESERVA_ID').AsString;
      modelo.LOJA                         := lQry.FieldByName('LOJA').AsString;
      modelo.ALIQ_IPI                     := lQry.FieldByName('ALIQ_IPI').AsString;
      modelo.VALOR_RESTITUICAO_ST         := lQry.FieldByName('VALOR_RESTITUICAO_ST').AsString;
      modelo.CFOP_ID                      := lQry.FieldByName('CFOP_ID').AsString;
      modelo.CST                          := lQry.FieldByName('CST').AsString;
      modelo.ALIQ_ICMS                    := lQry.FieldByName('ALIQ_ICMS').AsString;
      modelo.ALIQ_ICMS_ST                 := lQry.FieldByName('ALIQ_ICMS_ST').AsString;
      modelo.REDUCAO_ST                   := lQry.FieldByName('REDUCAO_ST').AsString;
      modelo.MVA                          := lQry.FieldByName('MVA').AsString;
      modelo.REDUCAO_ICMS                 := lQry.FieldByName('REDUCAO_ICMS').AsString;
      modelo.BASE_ICMS                    := lQry.FieldByName('BASE_ICMS').AsString;
      modelo.VALOR_ICMS                   := lQry.FieldByName('VALOR_ICMS').AsString;
      modelo.BASE_ST                      := lQry.FieldByName('BASE_ST').AsString;
      modelo.DESC_RESTITUICAO_ST          := lQry.FieldByName('DESC_RESTITUICAO_ST').AsString;
      modelo.ICMS_SUFRAMA                 := lQry.FieldByName('ICMS_SUFRAMA').AsString;
      modelo.PIS_SUFRAMA                  := lQry.FieldByName('PIS_SUFRAMA').AsString;
      modelo.COFINS_SUFRAMA               := lQry.FieldByName('COFINS_SUFRAMA').AsString;
      modelo.IPI_SUFRAMA                  := lQry.FieldByName('IPI_SUFRAMA').AsString;
      modelo.ALIQ_PIS                     := lQry.FieldByName('ALIQ_PIS').AsString;
      modelo.ALIQ_COFINS                  := lQry.FieldByName('ALIQ_COFINS').AsString;
      modelo.BASE_PIS                     := lQry.FieldByName('BASE_PIS').AsString;
      modelo.BASE_COFINS                  := lQry.FieldByName('BASE_COFINS').AsString;
      modelo.VALOR_PIS                    := lQry.FieldByName('VALOR_PIS').AsString;
      modelo.VALOR_COFINS                 := lQry.FieldByName('VALOR_COFINS').AsString;
      modelo.PREVENDA_ID                  := lQry.FieldByName('PREVENDA_ID').AsString;
      modelo.AVULSO                       := lQry.FieldByName('AVULSO').AsString;
      modelo.QUANTIDADE_NEW               := lQry.FieldByName('QUANTIDADE_NEW').AsString;
      modelo.BALANCA                      := lQry.FieldByName('BALANCA').AsString;
      modelo.QTDE_CALCULADA               := lQry.FieldByName('QTDE_CALCULADA').AsString;
      modelo.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
      modelo.AMBIENTE_ID                  := lQry.FieldByName('AMBIENTE_ID').AsString;
      modelo.AMBIENTE_OBS                 := lQry.FieldByName('AMBIENTE_OBS').AsString;
      modelo.PROJETO_ID                   := lQry.FieldByName('PROJETO_ID').AsString;
      modelo.LARGURA                      := lQry.FieldByName('LARGURA').AsString;
      modelo.ALTURA                       := lQry.FieldByName('ALTURA').AsString;
      modelo.ITEM                         := lQry.FieldByName('ITEM').AsString;
      modelo.DUN14                        := lQry.FieldByName('DUN14').AsString;
      modelo.SAIDAS_ID                    := lQry.FieldByName('SAIDAS_ID').AsString;
      modelo.CUSTO_DRG                    := lQry.FieldByName('CUSTO_DRG').AsString;
      modelo.POS_VENDA_STATUS             := lQry.FieldByName('POS_VENDA_STATUS').AsString;
      modelo.POS_VENDA_RETORNO            := lQry.FieldByName('POS_VENDA_RETORNO').AsString;
      modelo.POS_VENDA_OBS                := lQry.FieldByName('POS_VENDA_OBS').AsString;
      modelo.VALOR_SUFRAMA_ITEM_NEW       := lQry.FieldByName('VALOR_SUFRAMA_ITEM_NEW').AsString;
      modelo.VALOR_SUFRAMA_ITEM           := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
      modelo.BONUS                        := lQry.FieldByName('BONUS').AsString;
      modelo.BONUS_USO                    := lQry.FieldByName('BONUS_USO').AsString;
      modelo.FUNCIONARIO_ID               := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      modelo.PRODUCAO_ID                  := lQry.FieldByName('PRODUCAO_ID').AsString;
      modelo.QUANTIDADE_KG                := lQry.FieldByName('QUANTIDADE_KG').AsString;
      modelo.RESERVADO                    := lQry.FieldByName('RESERVADO').AsString;
      modelo.DESCRICAO_PRODUTO            := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
      modelo.COMISSAO_PERCENTUAL          := lQry.FieldByName('COMISSAO_PERCENTUAL').AsString;
      modelo.QTD_CHECAGEM                 := lQry.FieldByName('QTD_CHECAGEM').AsString;
      modelo.QTD_CHECAGEM_CORTE           := lQry.FieldByName('QTD_CHECAGEM_CORTE').AsString;
      modelo.ALTURA_M                     := lQry.FieldByName('ALTURA_M').AsString;
      modelo.LARGURA_M                    := lQry.FieldByName('LARGURA_M').AsString;
      modelo.PROFUNDIDADE_M               := lQry.FieldByName('PROFUNDIDADE_M').AsString;
      modelo.VBCUFDEST                    := lQry.FieldByName('VBCUFDEST').AsString;
      modelo.PFCPUFDEST                   := lQry.FieldByName('PFCPUFDEST').AsString;
      modelo.PICMSUFDEST                  := lQry.FieldByName('PICMSUFDEST').AsString;
      modelo.PICMSINTER                   := lQry.FieldByName('PICMSINTER').AsString;
      modelo.PICMSINTERPART               := lQry.FieldByName('PICMSINTERPART').AsString;
      modelo.VFCPUFDEST                   := lQry.FieldByName('VFCPUFDEST').AsString;
      modelo.VICMSUFDEST                  := lQry.FieldByName('VICMSUFDEST').AsString;
      modelo.VICMSUFREMET                 := lQry.FieldByName('VICMSUFREMET').AsString;
      modelo.COMBO_ITEM                   := lQry.FieldByName('COMBO_ITEM').AsString;
      modelo.VLRVENDA_MINIMO              := lQry.FieldByName('VLRVENDA_MINIMO').AsString;
      modelo.VLRVENDA_MAXIMO              := lQry.FieldByName('VLRVENDA_MAXIMO').AsString;
      modelo.IMPRESSO                     := lQry.FieldByName('IMPRESSO').AsString;
      modelo.ORCAMENTO_TSB_ID             := lQry.FieldByName('ORCAMENTO_TSB_ID').AsString;
      modelo.GERENTE_COMISSAO_PERCENTUAL  := lQry.FieldByName('GERENTE_COMISSAO_PERCENTUAL').AsString;
      modelo.XPED                         := lQry.FieldByName('XPED').AsString;
      modelo.NITEMPED2                    := lQry.FieldByName('NITEMPED2').AsString;
      modelo.VOUTROS                      := lQry.FieldByName('VOUTROS').AsString;
      modelo.VFRETE                       := lQry.FieldByName('VFRETE').AsString;
      modelo.ORIGINAL_PEDIDO_ID           := lQry.FieldByName('ORIGINAL_PEDIDO_ID').AsString;
      modelo.VALOR_VENDA_CADASTRO         := lQry.FieldByName('VALOR_VENDA_CADASTRO').AsString;
      modelo.WEB_PEDIDOITENS_ID           := lQry.FieldByName('WEB_PEDIDOITENS_ID').AsString;
      modelo.TIPO_VENDA                   := lQry.FieldByName('TIPO_VENDA').AsString;
      modelo.ENTREGA                      := lQry.FieldByName('ENTREGA').AsString;
      modelo.VBCFCPST                     := lQry.FieldByName('VBCFCPST').AsString;
      modelo.PFCPST                       := lQry.FieldByName('PFCPST').AsString;
      modelo.VFCPST                       := lQry.FieldByName('VFCPST').AsString;
      modelo.VALOR_BONUS_SERVICO          := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
      modelo.CBENEF                       := lQry.FieldByName('CBENEF').AsString;
      modelo.VICMSDESON                   := lQry.FieldByName('VICMSDESON').AsString;
      modelo.MOTDESICMS                   := lQry.FieldByName('MOTDESICMS').AsString;
      modelo.VALOR_DIFERIMENTO            := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
      modelo.VALOR_MONTADOR               := lQry.FieldByName('VALOR_MONTADOR').AsString;
      modelo.MONTAGEM                     := lQry.FieldByName('MONTAGEM').AsString;
      modelo.PCRED_PRESUMIDO              := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
      modelo.PEDIDOCOMPRAITENS_ID         := lQry.FieldByName('PEDIDOCOMPRAITENS_ID').AsString;
      modelo.PEDIDOITENS_ID               := lQry.FieldByName('PEDIDOITENS_ID').AsString;
      modelo.PIS_CST                      := lQry.FieldByName('PIS_CST').AsString;
      modelo.COFINS_CST                   := lQry.FieldByName('COFINS_CST').AsString;
      modelo.IPI_CST                      := lQry.FieldByName('IPI_CST').AsString;
      modelo.CSOSN                        := lQry.FieldByName('CSOSN').AsString;
      modelo.CFOP                         := lQry.FieldByName('CFOP').AsString;
      modelo.VDESC                        := lQry.FieldByName('VDESC').AsString;
      modelo.TIPO_VENDA_COMISSAO_ID       := lQry.FieldByName('TIPO_VENDA_COMISSAO_ID').AsString;
      modelo.COMIS_PRO                    := lQry.FieldByName('COMIS_PRO').AsString;

      modelo.GRUPO_COMISSAO_ID            := lQry.FieldByName('GRUPO_COMISSAO_ID').AsString;
      modelo.TIPO_GARANTIA_FR             := lQry.FieldByName('TIPO_GARANTIA_FR').AsString;
      modelo.VLR_GARANTIA_FR              := lQry.FieldByName('VLR_GARANTIA_FR').AsString;
      modelo.CUSTO_GARANTIA_FR            := lQry.FieldByName('CUSTO_GARANTIA_FR').AsString;
      modelo.CUSTO_GARANTIA               := lQry.FieldByName('CUSTO_GARANTIA').AsString;
      modelo.PER_GARANTIA_FR              := lQry.FieldByName('PER_GARANTIA_FR').AsString;

      modelo.VTOTTRIB_FEDERAL             := lQry.FieldByName('VTOTTRIB_FEDERAL').AsString;
      modelo.VTOTTRIB_ESTADUAL            := lQry.FieldByName('VTOTTRIB_ESTADUAL').AsString;
      modelo.VTOTTRIB_MUNICIPAL           := lQry.FieldByName('VTOTTRIB_MUNICIPAL').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;
function TPedidoItensDao.obterIDItem(pPedido, pProduto: String): String;
begin
  Result := vIConexao.getConnection.ExecSQLScalar('select i.id from pedidoitens i where i.numero_ped = '+QuotedStr(pPedido)+' and i.codigo_pro = '+QuotedStr(pProduto)+'');
end;

procedure TPedidoItensDao.obterItensPedido(pNumeroPedido: String);
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: TPedidoItensModel;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoItenssLista := TCollections.CreateList<TPedidoItensModel>(true);
  try
    lSQL :=
    ' select                                             '+#13+
    '   i.id,                                            '+#13+
    '   i.codigo_pro,                                    '+#13+
    '   p.barras_pro,                                    '+#13+
    '   p.nome_pro,                                      '+#13+
    '   i.quantidade_ped,                                '+#13+
    '   i.qtde_calculada,                                '+#13+
    '   i.valorunitario_ped,                             '+#13+
    '   i.desconto_ped,                                  '+#13+
    '   i.vdesc,                                         '+#13+
    '   i.item,                                          '+#13+
    '   i.valorunitario_ped * i.qtde_calculada total     '+#13+
    ' from                                               '+#13+
    '     pedidoitens i                                  '+#13+
    '                                                    '+#13+
    ' left join produto p on p.codigo_pro = i.codigo_pro '+#13+
    '                                                    '+#13+
    ' where                                              '+#13+
    '     i.numero_ped = '+QuotedStr(pNumeroPedido);
    lQry.Open(lSQL);
    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPedidoItensModel.Create(vIConexao);
      FPedidoItenssLista.Add(modelo);
      modelo.ID                := lQry.FieldByName('ID').AsString;
      modelo.CODIGO_PRO        := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.BARRAS_PRO        := lQry.FieldByName('BARRAS_PRO').AsString;
      modelo.NOME_PRO          := lQry.FieldByName('NOME_PRO').AsString;
      modelo.QUANTIDADE_PED    := lQry.FieldByName('QUANTIDADE_PED').AsFloat;
      modelo.QTDE_CALCULADA    := lQry.FieldByName('QTDE_CALCULADA').AsFloat;
      modelo.VALORUNITARIO_PED := lQry.FieldByName('VALORUNITARIO_PED').AsFloat;
      modelo.DESCONTO_PED      := lQry.FieldByName('DESCONTO_PED').AsFloat;
      modelo.VDESC             := lQry.FieldByName('VDESC').AsFloat;
      modelo.ITEM              := lQry.FieldByName('ITEM').AsFloat;
      modelo.TOTAL             := lQry.FieldByName('TOTAL').AsFloat;

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

procedure TPedidoItensDao.SetPedidoItenssLista;
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
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PEDIDOITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPedidoItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPedidoItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPedidoItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
    pQry.ParamByName('vdesc').Values[lCount]                        := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VDESC                         = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VDESC));
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

    pQry.ParamByName('tipo_garantia_fr').Values[lCount]             := IIF(pPedidoItensModel.PedidoItenssLista[lCount].TIPO_GARANTIA_FR              = '', Unassigned, pPedidoItensModel.PedidoItenssLista[lCount].TIPO_GARANTIA_FR);
    pQry.ParamByName('vlr_garantia_fr').Values[lCount]              := IIF(pPedidoItensModel.PedidoItenssLista[lCount].VLR_GARANTIA_FR               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].VLR_GARANTIA_FR));
    pQry.ParamByName('custo_garantia_fr').Values[lCount]            := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CUSTO_GARANTIA_FR             = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].CUSTO_GARANTIA_FR));
    pQry.ParamByName('custo_garantia').Values[lCount]               := IIF(pPedidoItensModel.PedidoItenssLista[lCount].CUSTO_GARANTIA                = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].CUSTO_GARANTIA));
    pQry.ParamByName('per_garantia_fr').Values[lCount]              := IIF(pPedidoItensModel.PedidoItenssLista[lCount].PER_GARANTIA_FR               = '', Unassigned, FormataFloatFireBird(pPedidoItensModel.PedidoItenssLista[lCount].PER_GARANTIA_FR));

  end;
end;

procedure TPedidoItensDao.SetSEGURO_PRESTAMISTA_VALOR(const Value: Variant);
begin
  FSEGURO_PRESTAMISTA_VALOR := Value;
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
