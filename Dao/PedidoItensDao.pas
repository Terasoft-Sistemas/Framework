unit PedidoItensDao;
interface
uses
  PedidoItensModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Terasoft.Framework.ObjectIface,
  System.Variants,
  Terasoft.Utils,
  Spring.Collections,
  Interfaces.Conexao;

type
  TPedidoItensDao = class;
  ITPedidoItensDao=IObject<TPedidoItensDao>;

  TPedidoItensDao = class
  private
    [weak] mySelf: ITPedidoItensDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPedidoItenssLista: IList<ITPedidoItensModel>;
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
    procedure SetPedidoItenssLista(const Value: IList<ITPedidoItensModel>);
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

    procedure setParams(var pQry: TFDQuery; pPedidoItensModel: ITPedidoItensModel);
    procedure setParamsArray(var pQry: TFDQuery; pPedidoItensModel: ITPedidoItensModel);
    function where: String;
    procedure SetSEGURO_PRESTAMISTA_VALOR(const Value: Variant);

  public
    constructor _Create(pConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPedidoItensDao;

    property PedidoItenssLista: IList<ITPedidoItensModel> read FPedidoItenssLista write SetPedidoItenssLista;
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

    function incluir(pPedidoItensModel: ITPedidoItensModel): String;
    function incluirLote(pPedidoItensModel: ITPedidoItensModel): String;
    function alterar(pPedidoItensModel: ITPedidoItensModel): String;
    function excluir(pPedidoItensModel: ITPedidoItensModel): String;

    procedure obterLista;
    procedure obterItensPedido(pNumeroPedido: String);
    procedure obterTotaisItens(pNumeroPedido: String);
    function carregaClasse(pId: String): ITPedidoItensModel;
    function obterIDItem(pPedido, pProduto : String): String;
end;

implementation

{ TPedidoItens }

uses Terasoft.FuncoesTexto, System.Rtti;

function TPedidoItensDao.carregaClasse(pId: String): ITPedidoItensModel;
var
  lQry: TFDQuery;
  lModel: ITPedidoItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPedidoItensModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from pedidoitens where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                           := lQry.FieldByName('ID').AsString;
    lModel.objeto.CODIGO_CLI                   := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.objeto.NUMERO_PED                   := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.objeto.CODIGO_PRO                   := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.objeto.QUANTIDADE_PED               := lQry.FieldByName('QUANTIDADE_PED').AsString;
    lModel.objeto.QUANTIDADE_TROCA             := lQry.FieldByName('QUANTIDADE_TROCA').AsString;
    lModel.objeto.VALORUNITARIO_PED            := lQry.FieldByName('VALORUNITARIO_PED').AsString;
    lModel.objeto.DESCONTO_PED                 := lQry.FieldByName('DESCONTO_PED').AsString;
    lModel.objeto.DESCONTO_UF                  := lQry.FieldByName('DESCONTO_UF').AsString;
    lModel.objeto.VALOR_IPI                    := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.objeto.VALOR_ST                     := lQry.FieldByName('VALOR_ST').AsString;
    lModel.objeto.VLRVENDA_PRO                 := lQry.FieldByName('VLRVENDA_PRO').AsString;
    lModel.objeto.VLRCUSTO_PRO                 := lQry.FieldByName('VLRCUSTO_PRO').AsString;
    lModel.objeto.COMISSAO_PED                 := lQry.FieldByName('COMISSAO_PED').AsString;
    lModel.objeto.TIPO_NF                      := lQry.FieldByName('TIPO_NF').AsString;
    lModel.objeto.QUANTIDADE_TIPO              := lQry.FieldByName('QUANTIDADE_TIPO').AsString;
    lModel.objeto.OBSERVACAO                   := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.objeto.CTR_EXPORTACAO               := lQry.FieldByName('CTR_EXPORTACAO').AsString;
    lModel.objeto.PRODUTO_REFERENCIA           := lQry.FieldByName('PRODUTO_REFERENCIA').AsString;
    lModel.objeto.OBS_ITEM                     := lQry.FieldByName('OBS_ITEM').AsString;
    lModel.objeto.RESERVA_ID                   := lQry.FieldByName('RESERVA_ID').AsString;
    lModel.objeto.LOJA                         := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.ALIQ_IPI                     := lQry.FieldByName('ALIQ_IPI').AsString;
    lModel.objeto.VALOR_RESTITUICAO_ST         := lQry.FieldByName('VALOR_RESTITUICAO_ST').AsString;
    lModel.objeto.CFOP_ID                      := lQry.FieldByName('CFOP_ID').AsString;
    lModel.objeto.CST                          := lQry.FieldByName('CST').AsString;
    lModel.objeto.ALIQ_ICMS                    := lQry.FieldByName('ALIQ_ICMS').AsString;
    lModel.objeto.ALIQ_ICMS_ST                 := lQry.FieldByName('ALIQ_ICMS_ST').AsString;
    lModel.objeto.REDUCAO_ST                   := lQry.FieldByName('REDUCAO_ST').AsString;
    lModel.objeto.MVA                          := lQry.FieldByName('MVA').AsString;
    lModel.objeto.REDUCAO_ICMS                 := lQry.FieldByName('REDUCAO_ICMS').AsString;
    lModel.objeto.BASE_ICMS                    := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.objeto.VALOR_ICMS                   := lQry.FieldByName('VALOR_ICMS').AsString;
    lModel.objeto.BASE_ST                      := lQry.FieldByName('BASE_ST').AsString;
    lModel.objeto.DESC_RESTITUICAO_ST          := lQry.FieldByName('DESC_RESTITUICAO_ST').AsString;
    lModel.objeto.ICMS_SUFRAMA                 := lQry.FieldByName('ICMS_SUFRAMA').AsString;
    lModel.objeto.PIS_SUFRAMA                  := lQry.FieldByName('PIS_SUFRAMA').AsString;
    lModel.objeto.COFINS_SUFRAMA               := lQry.FieldByName('COFINS_SUFRAMA').AsString;
    lModel.objeto.IPI_SUFRAMA                  := lQry.FieldByName('IPI_SUFRAMA').AsString;
    lModel.objeto.ALIQ_PIS                     := lQry.FieldByName('ALIQ_PIS').AsString;
    lModel.objeto.ALIQ_COFINS                  := lQry.FieldByName('ALIQ_COFINS').AsString;
    lModel.objeto.BASE_PIS                     := lQry.FieldByName('BASE_PIS').AsString;
    lModel.objeto.BASE_COFINS                  := lQry.FieldByName('BASE_COFINS').AsString;
    lModel.objeto.VALOR_PIS                    := lQry.FieldByName('VALOR_PIS').AsString;
    lModel.objeto.VALOR_COFINS                 := lQry.FieldByName('VALOR_COFINS').AsString;
    lModel.objeto.PREVENDA_ID                  := lQry.FieldByName('PREVENDA_ID').AsString;
    lModel.objeto.AVULSO                       := lQry.FieldByName('AVULSO').AsString;
    lModel.objeto.QUANTIDADE_NEW               := lQry.FieldByName('QUANTIDADE_NEW').AsString;
    lModel.objeto.BALANCA                      := lQry.FieldByName('BALANCA').AsString;
    lModel.objeto.QTDE_CALCULADA               := lQry.FieldByName('QTDE_CALCULADA').AsString;
    lModel.objeto.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.AMBIENTE_ID                  := lQry.FieldByName('AMBIENTE_ID').AsString;
    lModel.objeto.AMBIENTE_OBS                 := lQry.FieldByName('AMBIENTE_OBS').AsString;
    lModel.objeto.PROJETO_ID                   := lQry.FieldByName('PROJETO_ID').AsString;
    lModel.objeto.LARGURA                      := lQry.FieldByName('LARGURA').AsString;
    lModel.objeto.ALTURA                       := lQry.FieldByName('ALTURA').AsString;
    lModel.objeto.ITEM                         := lQry.FieldByName('ITEM').AsString;
    lModel.objeto.DUN14                        := lQry.FieldByName('DUN14').AsString;
    lModel.objeto.SAIDAS_ID                    := lQry.FieldByName('SAIDAS_ID').AsString;
    lModel.objeto.CUSTO_DRG                    := lQry.FieldByName('CUSTO_DRG').AsString;
    lModel.objeto.POS_VENDA_STATUS             := lQry.FieldByName('POS_VENDA_STATUS').AsString;
    lModel.objeto.POS_VENDA_RETORNO            := lQry.FieldByName('POS_VENDA_RETORNO').AsString;
    lModel.objeto.POS_VENDA_OBS                := lQry.FieldByName('POS_VENDA_OBS').AsString;
    lModel.objeto.VALOR_SUFRAMA_ITEM_NEW       := lQry.FieldByName('VALOR_SUFRAMA_ITEM_NEW').AsString;
    lModel.objeto.VALOR_SUFRAMA_ITEM           := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
    lModel.objeto.BONUS                        := lQry.FieldByName('BONUS').AsString;
    lModel.objeto.BONUS_USO                    := lQry.FieldByName('BONUS_USO').AsString;
    lModel.objeto.FUNCIONARIO_ID               := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.objeto.PRODUCAO_ID                  := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.objeto.QUANTIDADE_KG                := lQry.FieldByName('QUANTIDADE_KG').AsString;
    lModel.objeto.RESERVADO                    := lQry.FieldByName('RESERVADO').AsString;
    lModel.objeto.DESCRICAO_PRODUTO            := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
    lModel.objeto.COMISSAO_PERCENTUAL          := lQry.FieldByName('COMISSAO_PERCENTUAL').AsString;
    lModel.objeto.QTD_CHECAGEM                 := lQry.FieldByName('QTD_CHECAGEM').AsString;
    lModel.objeto.QTD_CHECAGEM_CORTE           := lQry.FieldByName('QTD_CHECAGEM_CORTE').AsString;
    lModel.objeto.ALTURA_M                     := lQry.FieldByName('ALTURA_M').AsString;
    lModel.objeto.LARGURA_M                    := lQry.FieldByName('LARGURA_M').AsString;
    lModel.objeto.PROFUNDIDADE_M               := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.objeto.VBCUFDEST                    := lQry.FieldByName('VBCUFDEST').AsString;
    lModel.objeto.PFCPUFDEST                   := lQry.FieldByName('PFCPUFDEST').AsString;
    lModel.objeto.PICMSUFDEST                  := lQry.FieldByName('PICMSUFDEST').AsString;
    lModel.objeto.PICMSINTER                   := lQry.FieldByName('PICMSINTER').AsString;
    lModel.objeto.PICMSINTERPART               := lQry.FieldByName('PICMSINTERPART').AsString;
    lModel.objeto.VFCPUFDEST                   := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.objeto.VICMSUFDEST                  := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.objeto.VICMSUFREMET                 := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.objeto.COMBO_ITEM                   := lQry.FieldByName('COMBO_ITEM').AsString;
    lModel.objeto.VLRVENDA_MINIMO              := lQry.FieldByName('VLRVENDA_MINIMO').AsString;
    lModel.objeto.VLRVENDA_MAXIMO              := lQry.FieldByName('VLRVENDA_MAXIMO').AsString;
    lModel.objeto.IMPRESSO                     := lQry.FieldByName('IMPRESSO').AsString;
    lModel.objeto.ORCAMENTO_TSB_ID             := lQry.FieldByName('ORCAMENTO_TSB_ID').AsString;
    lModel.objeto.GERENTE_COMISSAO_PERCENTUAL  := lQry.FieldByName('GERENTE_COMISSAO_PERCENTUAL').AsString;
    lModel.objeto.XPED                         := lQry.FieldByName('XPED').AsString;
    lModel.objeto.NITEMPED2                    := lQry.FieldByName('NITEMPED2').AsString;
    lModel.objeto.VOUTROS                      := lQry.FieldByName('VOUTROS').AsString;
    lModel.objeto.VFRETE                       := lQry.FieldByName('VFRETE').AsString;
    lModel.objeto.ORIGINAL_PEDIDO_ID           := lQry.FieldByName('ORIGINAL_PEDIDO_ID').AsString;
    lModel.objeto.VALOR_VENDA_CADASTRO         := lQry.FieldByName('VALOR_VENDA_CADASTRO').AsString;
    lModel.objeto.WEB_PEDIDOITENS_ID           := lQry.FieldByName('WEB_PEDIDOITENS_ID').AsString;
    lModel.objeto.TIPO_VENDA                   := lQry.FieldByName('TIPO_VENDA').AsString;
    lModel.objeto.ENTREGA                      := lQry.FieldByName('ENTREGA').AsString;
    lModel.objeto.VBCFCPST                     := lQry.FieldByName('VBCFCPST').AsString;
    lModel.objeto.PFCPST                       := lQry.FieldByName('PFCPST').AsString;
    lModel.objeto.VFCPST                       := lQry.FieldByName('VFCPST').AsString;
    lModel.objeto.VALOR_BONUS_SERVICO          := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
    lModel.objeto.CBENEF                       := lQry.FieldByName('CBENEF').AsString;
    lModel.objeto.VICMSDESON                   := lQry.FieldByName('VICMSDESON').AsString;
    lModel.objeto.MOTDESICMS                   := lQry.FieldByName('MOTDESICMS').AsString;
    lModel.objeto.VALOR_DIFERIMENTO            := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
    lModel.objeto.VALOR_MONTADOR               := lQry.FieldByName('VALOR_MONTADOR').AsString;
    lModel.objeto.MONTAGEM                     := lQry.FieldByName('MONTAGEM').AsString;
    lModel.objeto.PCRED_PRESUMIDO              := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
    lModel.objeto.PEDIDOCOMPRAITENS_ID         := lQry.FieldByName('PEDIDOCOMPRAITENS_ID').AsString;
    lModel.objeto.PEDIDOITENS_ID               := lQry.FieldByName('PEDIDOITENS_ID').AsString;
    lModel.objeto.PIS_CST                      := lQry.FieldByName('PIS_CST').AsString;
    lModel.objeto.COFINS_CST                   := lQry.FieldByName('COFINS_CST').AsString;
    lModel.objeto.IPI_CST                      := lQry.FieldByName('IPI_CST').AsString;
    lModel.objeto.VDESC                        := lQry.FieldByName('VDESC').AsString;
    lModel.objeto.CSOSN                        := lQry.FieldByName('CSOSN').AsString;
    lModel.objeto.CFOP                         := lQry.FieldByName('CFOP').AsString;
    lModel.objeto.VBCSTRET                     := lQry.FieldByName('VBCSTRET').AsString;
    lModel.objeto.PICMSSTRET                   := lQry.FieldByName('PICMSSTRET').AsString;
    lModel.objeto.VICMSSTRET                   := lQry.FieldByName('VICMSSTRET').AsString;
    lModel.objeto.VICMSSUBISTITUTORET          := lQry.FieldByName('VICMSSUBISTITUTORET').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPedidoItensDao._Create(pConexao : IConexao);
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

function TPedidoItensDao.incluir(pPedidoItensModel: ITPedidoItensModel): String;
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

function TPedidoItensDao.incluirLote(pPedidoItensModel: ITPedidoItensModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PEDIDOITENS', '');

  try
    lQry.SQL.Add(lSQL);
    lQry.Params.ArraySize := pPedidoItensModel.objeto.PedidoItenssLista.Count;
    setParamsArray(lQry, pPedidoItensModel);
    lQry.Execute(pPedidoItensModel.objeto.PedidoItenssLista.Count, 0);
    Result := '';
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoItensDao.alterar(pPedidoItensModel: ITPedidoItensModel): String;
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
    Result := pPedidoItensModel.objeto.ID;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoItensDao.excluir(pPedidoItensModel: ITPedidoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from pedidoitens where ID = :ID',[pPedidoItensModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pPedidoItensModel.objeto.ID;
  finally
    lQry.Free;
  end;
end;

class function TPedidoItensDao.getNewIface(pIConexao: IConexao): ITPedidoItensDao;
begin
  Result := TImplObjetoOwner<TPedidoItensDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
  modelo: ITPedidoItensModel;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoItenssLista := TCollections.CreateList<ITPedidoItensModel>;

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
      modelo := TPedidoItensModel.getNewIface(vIConexao);
      FPedidoItenssLista.Add(modelo);

      modelo.objeto.ID                           := lQry.FieldByName('ID').AsString;
      modelo.objeto.CODIGO_CLI                   := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.objeto.NUMERO_PED                   := lQry.FieldByName('NUMERO_PED').AsString;
      modelo.objeto.CODIGO_PRO                   := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.objeto.QUANTIDADE_PED               := lQry.FieldByName('QUANTIDADE_PED').AsString;
      modelo.objeto.QUANTIDADE_TROCA             := lQry.FieldByName('QUANTIDADE_TROCA').AsString;
      modelo.objeto.VALORUNITARIO_PED            := lQry.FieldByName('VALORUNITARIO_PED').AsString;
      modelo.objeto.DESCONTO_PED                 := lQry.FieldByName('DESCONTO_PED').AsString;
      modelo.objeto.DESCONTO_UF                  := lQry.FieldByName('DESCONTO_UF').AsString;
      modelo.objeto.VALOR_IPI                    := lQry.FieldByName('VALOR_IPI').AsString;
      modelo.objeto.VALOR_ST                     := lQry.FieldByName('VALOR_ST').AsString;
      modelo.objeto.VLRVENDA_PRO                 := lQry.FieldByName('VLRVENDA_PRO').AsString;
      modelo.objeto.VLRCUSTO_PRO                 := lQry.FieldByName('VLRCUSTO_PRO').AsString;
      modelo.objeto.COMISSAO_PED                 := lQry.FieldByName('COMISSAO_PED').AsString;
      modelo.objeto.TIPO_NF                      := lQry.FieldByName('TIPO_NF').AsString;
      modelo.objeto.QUANTIDADE_TIPO              := lQry.FieldByName('QUANTIDADE_TIPO').AsString;
      modelo.objeto.OBSERVACAO                   := lQry.FieldByName('OBSERVACAO').AsString;
      modelo.objeto.CTR_EXPORTACAO               := lQry.FieldByName('CTR_EXPORTACAO').AsString;
      modelo.objeto.PRODUTO_REFERENCIA           := lQry.FieldByName('PRODUTO_REFERENCIA').AsString;
      modelo.objeto.OBS_ITEM                     := lQry.FieldByName('OBS_ITEM').AsString;
      modelo.objeto.RESERVA_ID                   := lQry.FieldByName('RESERVA_ID').AsString;
      modelo.objeto.LOJA                         := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.ALIQ_IPI                     := lQry.FieldByName('ALIQ_IPI').AsString;
      modelo.objeto.VALOR_RESTITUICAO_ST         := lQry.FieldByName('VALOR_RESTITUICAO_ST').AsString;
      modelo.objeto.CFOP_ID                      := lQry.FieldByName('CFOP_ID').AsString;
      modelo.objeto.CST                          := lQry.FieldByName('CST').AsString;
      modelo.objeto.ALIQ_ICMS                    := lQry.FieldByName('ALIQ_ICMS').AsString;
      modelo.objeto.ALIQ_ICMS_ST                 := lQry.FieldByName('ALIQ_ICMS_ST').AsString;
      modelo.objeto.REDUCAO_ST                   := lQry.FieldByName('REDUCAO_ST').AsString;
      modelo.objeto.MVA                          := lQry.FieldByName('MVA').AsString;
      modelo.objeto.REDUCAO_ICMS                 := lQry.FieldByName('REDUCAO_ICMS').AsString;
      modelo.objeto.BASE_ICMS                    := lQry.FieldByName('BASE_ICMS').AsString;
      modelo.objeto.VALOR_ICMS                   := lQry.FieldByName('VALOR_ICMS').AsString;
      modelo.objeto.BASE_ST                      := lQry.FieldByName('BASE_ST').AsString;
      modelo.objeto.DESC_RESTITUICAO_ST          := lQry.FieldByName('DESC_RESTITUICAO_ST').AsString;
      modelo.objeto.ICMS_SUFRAMA                 := lQry.FieldByName('ICMS_SUFRAMA').AsString;
      modelo.objeto.PIS_SUFRAMA                  := lQry.FieldByName('PIS_SUFRAMA').AsString;
      modelo.objeto.COFINS_SUFRAMA               := lQry.FieldByName('COFINS_SUFRAMA').AsString;
      modelo.objeto.IPI_SUFRAMA                  := lQry.FieldByName('IPI_SUFRAMA').AsString;
      modelo.objeto.ALIQ_PIS                     := lQry.FieldByName('ALIQ_PIS').AsString;
      modelo.objeto.ALIQ_COFINS                  := lQry.FieldByName('ALIQ_COFINS').AsString;
      modelo.objeto.BASE_PIS                     := lQry.FieldByName('BASE_PIS').AsString;
      modelo.objeto.BASE_COFINS                  := lQry.FieldByName('BASE_COFINS').AsString;
      modelo.objeto.VALOR_PIS                    := lQry.FieldByName('VALOR_PIS').AsString;
      modelo.objeto.VALOR_COFINS                 := lQry.FieldByName('VALOR_COFINS').AsString;
      modelo.objeto.PREVENDA_ID                  := lQry.FieldByName('PREVENDA_ID').AsString;
      modelo.objeto.AVULSO                       := lQry.FieldByName('AVULSO').AsString;
      modelo.objeto.QUANTIDADE_NEW               := lQry.FieldByName('QUANTIDADE_NEW').AsString;
      modelo.objeto.BALANCA                      := lQry.FieldByName('BALANCA').AsString;
      modelo.objeto.QTDE_CALCULADA               := lQry.FieldByName('QTDE_CALCULADA').AsString;
      modelo.objeto.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.AMBIENTE_ID                  := lQry.FieldByName('AMBIENTE_ID').AsString;
      modelo.objeto.AMBIENTE_OBS                 := lQry.FieldByName('AMBIENTE_OBS').AsString;
      modelo.objeto.PROJETO_ID                   := lQry.FieldByName('PROJETO_ID').AsString;
      modelo.objeto.LARGURA                      := lQry.FieldByName('LARGURA').AsString;
      modelo.objeto.ALTURA                       := lQry.FieldByName('ALTURA').AsString;
      modelo.objeto.ITEM                         := lQry.FieldByName('ITEM').AsString;
      modelo.objeto.DUN14                        := lQry.FieldByName('DUN14').AsString;
      modelo.objeto.SAIDAS_ID                    := lQry.FieldByName('SAIDAS_ID').AsString;
      modelo.objeto.CUSTO_DRG                    := lQry.FieldByName('CUSTO_DRG').AsString;
      modelo.objeto.POS_VENDA_STATUS             := lQry.FieldByName('POS_VENDA_STATUS').AsString;
      modelo.objeto.POS_VENDA_RETORNO            := lQry.FieldByName('POS_VENDA_RETORNO').AsString;
      modelo.objeto.POS_VENDA_OBS                := lQry.FieldByName('POS_VENDA_OBS').AsString;
      modelo.objeto.VALOR_SUFRAMA_ITEM_NEW       := lQry.FieldByName('VALOR_SUFRAMA_ITEM_NEW').AsString;
      modelo.objeto.VALOR_SUFRAMA_ITEM           := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
      modelo.objeto.BONUS                        := lQry.FieldByName('BONUS').AsString;
      modelo.objeto.BONUS_USO                    := lQry.FieldByName('BONUS_USO').AsString;
      modelo.objeto.FUNCIONARIO_ID               := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      modelo.objeto.PRODUCAO_ID                  := lQry.FieldByName('PRODUCAO_ID').AsString;
      modelo.objeto.QUANTIDADE_KG                := lQry.FieldByName('QUANTIDADE_KG').AsString;
      modelo.objeto.RESERVADO                    := lQry.FieldByName('RESERVADO').AsString;
      modelo.objeto.DESCRICAO_PRODUTO            := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
      modelo.objeto.COMISSAO_PERCENTUAL          := lQry.FieldByName('COMISSAO_PERCENTUAL').AsString;
      modelo.objeto.QTD_CHECAGEM                 := lQry.FieldByName('QTD_CHECAGEM').AsString;
      modelo.objeto.QTD_CHECAGEM_CORTE           := lQry.FieldByName('QTD_CHECAGEM_CORTE').AsString;
      modelo.objeto.ALTURA_M                     := lQry.FieldByName('ALTURA_M').AsString;
      modelo.objeto.LARGURA_M                    := lQry.FieldByName('LARGURA_M').AsString;
      modelo.objeto.PROFUNDIDADE_M               := lQry.FieldByName('PROFUNDIDADE_M').AsString;
      modelo.objeto.VBCUFDEST                    := lQry.FieldByName('VBCUFDEST').AsString;
      modelo.objeto.PFCPUFDEST                   := lQry.FieldByName('PFCPUFDEST').AsString;
      modelo.objeto.PICMSUFDEST                  := lQry.FieldByName('PICMSUFDEST').AsString;
      modelo.objeto.PICMSINTER                   := lQry.FieldByName('PICMSINTER').AsString;
      modelo.objeto.PICMSINTERPART               := lQry.FieldByName('PICMSINTERPART').AsString;
      modelo.objeto.VFCPUFDEST                   := lQry.FieldByName('VFCPUFDEST').AsString;
      modelo.objeto.VICMSUFDEST                  := lQry.FieldByName('VICMSUFDEST').AsString;
      modelo.objeto.VICMSUFREMET                 := lQry.FieldByName('VICMSUFREMET').AsString;
      modelo.objeto.COMBO_ITEM                   := lQry.FieldByName('COMBO_ITEM').AsString;
      modelo.objeto.VLRVENDA_MINIMO              := lQry.FieldByName('VLRVENDA_MINIMO').AsString;
      modelo.objeto.VLRVENDA_MAXIMO              := lQry.FieldByName('VLRVENDA_MAXIMO').AsString;
      modelo.objeto.IMPRESSO                     := lQry.FieldByName('IMPRESSO').AsString;
      modelo.objeto.ORCAMENTO_TSB_ID             := lQry.FieldByName('ORCAMENTO_TSB_ID').AsString;
      modelo.objeto.GERENTE_COMISSAO_PERCENTUAL  := lQry.FieldByName('GERENTE_COMISSAO_PERCENTUAL').AsString;
      modelo.objeto.XPED                         := lQry.FieldByName('XPED').AsString;
      modelo.objeto.NITEMPED2                    := lQry.FieldByName('NITEMPED2').AsString;
      modelo.objeto.VOUTROS                      := lQry.FieldByName('VOUTROS').AsString;
      modelo.objeto.VFRETE                       := lQry.FieldByName('VFRETE').AsString;
      modelo.objeto.ORIGINAL_PEDIDO_ID           := lQry.FieldByName('ORIGINAL_PEDIDO_ID').AsString;
      modelo.objeto.VALOR_VENDA_CADASTRO         := lQry.FieldByName('VALOR_VENDA_CADASTRO').AsString;
      modelo.objeto.WEB_PEDIDOITENS_ID           := lQry.FieldByName('WEB_PEDIDOITENS_ID').AsString;
      modelo.objeto.TIPO_VENDA                   := lQry.FieldByName('TIPO_VENDA').AsString;
      modelo.objeto.ENTREGA                      := lQry.FieldByName('ENTREGA').AsString;
      modelo.objeto.VBCFCPST                     := lQry.FieldByName('VBCFCPST').AsString;
      modelo.objeto.PFCPST                       := lQry.FieldByName('PFCPST').AsString;
      modelo.objeto.VFCPST                       := lQry.FieldByName('VFCPST').AsString;
      modelo.objeto.VALOR_BONUS_SERVICO          := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
      modelo.objeto.CBENEF                       := lQry.FieldByName('CBENEF').AsString;
      modelo.objeto.VICMSDESON                   := lQry.FieldByName('VICMSDESON').AsString;
      modelo.objeto.MOTDESICMS                   := lQry.FieldByName('MOTDESICMS').AsString;
      modelo.objeto.VALOR_DIFERIMENTO            := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
      modelo.objeto.VALOR_MONTADOR               := lQry.FieldByName('VALOR_MONTADOR').AsString;
      modelo.objeto.MONTAGEM                     := lQry.FieldByName('MONTAGEM').AsString;
      modelo.objeto.PCRED_PRESUMIDO              := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
      modelo.objeto.PEDIDOCOMPRAITENS_ID         := lQry.FieldByName('PEDIDOCOMPRAITENS_ID').AsString;
      modelo.objeto.PEDIDOITENS_ID               := lQry.FieldByName('PEDIDOITENS_ID').AsString;
      modelo.objeto.PIS_CST                      := lQry.FieldByName('PIS_CST').AsString;
      modelo.objeto.COFINS_CST                   := lQry.FieldByName('COFINS_CST').AsString;
      modelo.objeto.IPI_CST                      := lQry.FieldByName('IPI_CST').AsString;
      modelo.objeto.CSOSN                        := lQry.FieldByName('CSOSN').AsString;
      modelo.objeto.CFOP                         := lQry.FieldByName('CFOP').AsString;
      modelo.objeto.VDESC                        := lQry.FieldByName('VDESC').AsString;
      modelo.objeto.TIPO_VENDA_COMISSAO_ID       := lQry.FieldByName('TIPO_VENDA_COMISSAO_ID').AsString;
      modelo.objeto.COMIS_PRO                    := lQry.FieldByName('COMIS_PRO').AsString;

      modelo.objeto.GRUPO_COMISSAO_ID            := lQry.FieldByName('GRUPO_COMISSAO_ID').AsString;
      modelo.objeto.TIPO_GARANTIA_FR             := lQry.FieldByName('TIPO_GARANTIA_FR').AsString;
      modelo.objeto.VLR_GARANTIA_FR              := lQry.FieldByName('VLR_GARANTIA_FR').AsString;
      modelo.objeto.CUSTO_GARANTIA_FR            := lQry.FieldByName('CUSTO_GARANTIA_FR').AsString;
      modelo.objeto.CUSTO_GARANTIA               := lQry.FieldByName('CUSTO_GARANTIA').AsString;
      modelo.objeto.PER_GARANTIA_FR              := lQry.FieldByName('PER_GARANTIA_FR').AsString;

      modelo.objeto.VTOTTRIB_FEDERAL             := lQry.FieldByName('VTOTTRIB_FEDERAL').AsString;
      modelo.objeto.VTOTTRIB_ESTADUAL            := lQry.FieldByName('VTOTTRIB_ESTADUAL').AsString;
      modelo.objeto.VTOTTRIB_MUNICIPAL           := lQry.FieldByName('VTOTTRIB_MUNICIPAL').AsString;

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
  modelo: ITPedidoItensModel;
begin
  lQry := vIConexao.CriarQuery;
  FPedidoItenssLista := TCollections.CreateList<ITPedidoItensModel>;
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
      modelo := TPedidoItensModel.getNewIface(vIConexao);
      FPedidoItenssLista.Add(modelo);
      modelo.objeto.ID                := lQry.FieldByName('ID').AsString;
      modelo.objeto.CODIGO_PRO        := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.objeto.BARRAS_PRO        := lQry.FieldByName('BARRAS_PRO').AsString;
      modelo.objeto.NOME_PRO          := lQry.FieldByName('NOME_PRO').AsString;
      modelo.objeto.QUANTIDADE_PED    := lQry.FieldByName('QUANTIDADE_PED').AsFloat;
      modelo.objeto.QTDE_CALCULADA    := lQry.FieldByName('QTDE_CALCULADA').AsFloat;
      modelo.objeto.VALORUNITARIO_PED := lQry.FieldByName('VALORUNITARIO_PED').AsFloat;
      modelo.objeto.DESCONTO_PED      := lQry.FieldByName('DESCONTO_PED').AsFloat;
      modelo.objeto.VDESC             := lQry.FieldByName('VDESC').AsFloat;
      modelo.objeto.ITEM              := lQry.FieldByName('ITEM').AsFloat;
      modelo.objeto.TOTAL             := lQry.FieldByName('TOTAL').AsFloat;

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

procedure TPedidoItensDao.setParams(var pQry: TFDQuery; pPedidoItensModel: ITPedidoItensModel);
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPedidoItensModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPedidoItensModel.objeto).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPedidoItensDao.setParamsArray(var pQry: TFDQuery; pPedidoItensModel: ITPedidoItensModel);
var
  modelo: ITPedidoItensModel;
  lCount: Integer;
begin
  lCount := 0;
  for modelo in pPedidoItensModel.objeto.PedidoItenssLista do
  begin
    pQry.ParamByName('codigo_cli').Values[lCount]                   := IIF(modelo.objeto.CODIGO_CLI                    = '', Unassigned, modelo.objeto.CODIGO_CLI);
    pQry.ParamByName('numero_ped').Values[lCount]                   := IIF(modelo.objeto.NUMERO_PED                    = '', Unassigned, modelo.objeto.NUMERO_PED);
    pQry.ParamByName('codigo_pro').Values[lCount]                   := IIF(modelo.objeto.CODIGO_PRO                    = '', Unassigned, modelo.objeto.CODIGO_PRO);
    pQry.ParamByName('quantidade_ped').Values[lCount]               := IIF(modelo.objeto.QUANTIDADE_PED                = '', Unassigned, FormataFloatFireBird(modelo.objeto.QUANTIDADE_PED));
    pQry.ParamByName('quantidade_troca').Values[lCount]             := IIF(modelo.objeto.QUANTIDADE_TROCA              = '', Unassigned, FormataFloatFireBird(modelo.objeto.QUANTIDADE_TROCA));
    pQry.ParamByName('valorunitario_ped').Values[lCount]            := IIF(modelo.objeto.VALORUNITARIO_PED             = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALORUNITARIO_PED));
    pQry.ParamByName('desconto_ped').Values[lCount]                 := IIF(modelo.objeto.DESCONTO_PED                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.DESCONTO_PED));
    pQry.ParamByName('vdesc').Values[lCount]                        := IIF(modelo.objeto.VDESC                         = '', Unassigned, FormataFloatFireBird(modelo.objeto.VDESC));
    pQry.ParamByName('desconto_uf').Values[lCount]                  := IIF(modelo.objeto.DESCONTO_UF                   = '', Unassigned, FormataFloatFireBird(modelo.objeto.DESCONTO_UF));
    pQry.ParamByName('valor_ipi').Values[lCount]                    := IIF(modelo.objeto.VALOR_IPI                     = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_IPI));
    pQry.ParamByName('valor_st').Values[lCount]                     := IIF(modelo.objeto.VALOR_ST                      = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_ST));
    pQry.ParamByName('vlrvenda_pro').Values[lCount]                 := IIF(modelo.objeto.VLRVENDA_PRO                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.VLRVENDA_PRO));
    pQry.ParamByName('vlrcusto_pro').Values[lCount]                 := IIF(modelo.objeto.VLRCUSTO_PRO                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.VLRCUSTO_PRO));
    pQry.ParamByName('comissao_ped').Values[lCount]                 := IIF(modelo.objeto.COMISSAO_PED                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.COMISSAO_PED));
    pQry.ParamByName('tipo_nf').Values[lCount]                      := IIF(modelo.objeto.TIPO_NF                       = '', Unassigned, modelo.objeto.TIPO_NF);
    pQry.ParamByName('quantidade_tipo').Values[lCount]              := IIF(modelo.objeto.QUANTIDADE_TIPO               = '', Unassigned, FormataFloatFireBird(modelo.objeto.QUANTIDADE_TIPO));
    pQry.ParamByName('observacao').Values[lCount]                   := IIF(modelo.objeto.OBSERVACAO                    = '', Unassigned, modelo.objeto.OBSERVACAO);
    pQry.ParamByName('ctr_exportacao').Values[lCount]               := IIF(modelo.objeto.CTR_EXPORTACAO                = '', Unassigned, modelo.objeto.CTR_EXPORTACAO);
    pQry.ParamByName('produto_referencia').Values[lCount]           := IIF(modelo.objeto.PRODUTO_REFERENCIA            = '', Unassigned, modelo.objeto.PRODUTO_REFERENCIA);
    pQry.ParamByName('obs_item').Values[lCount]                     := IIF(modelo.objeto.OBS_ITEM                      = '', Unassigned, modelo.objeto.OBS_ITEM);
    pQry.ParamByName('reserva_id').Values[lCount]                   := IIF(modelo.objeto.RESERVA_ID                    = '', Unassigned, modelo.objeto.RESERVA_ID);
    pQry.ParamByName('loja').Values[lCount]                         := IIF(modelo.objeto.LOJA                          = '', Unassigned, modelo.objeto.LOJA);
    pQry.ParamByName('aliq_ipi').Values[lCount]                     := IIF(modelo.objeto.ALIQ_IPI                      = '', Unassigned, FormataFloatFireBird(modelo.objeto.ALIQ_IPI));
    pQry.ParamByName('valor_restituicao_st').Values[lCount]         := IIF(modelo.objeto.VALOR_RESTITUICAO_ST          = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_RESTITUICAO_ST));
    pQry.ParamByName('cfop_id').Values[lCount]                      := IIF(modelo.objeto.CFOP_ID                       = '', Unassigned, modelo.objeto.CFOP_ID);
    pQry.ParamByName('cst').Values[lCount]                          := IIF(modelo.objeto.CST                           = '', Unassigned, modelo.objeto.CST);
    pQry.ParamByName('aliq_icms').Values[lCount]                    := IIF(modelo.objeto.ALIQ_ICMS                     = '', Unassigned, FormataFloatFireBird(modelo.objeto.ALIQ_ICMS));
    pQry.ParamByName('aliq_icms_st').Values[lCount]                 := IIF(modelo.objeto.ALIQ_ICMS_ST                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.ALIQ_ICMS_ST));
    pQry.ParamByName('reducao_st').Values[lCount]                   := IIF(modelo.objeto.REDUCAO_ST                    = '', Unassigned, FormataFloatFireBird(modelo.objeto.REDUCAO_ST));
    pQry.ParamByName('mva').Values[lCount]                          := IIF(modelo.objeto.MVA                           = '', Unassigned, FormataFloatFireBird(modelo.objeto.MVA));
    pQry.ParamByName('reducao_icms').Values[lCount]                 := IIF(modelo.objeto.REDUCAO_ICMS                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.REDUCAO_ICMS));
    pQry.ParamByName('base_icms').Values[lCount]                    := IIF(modelo.objeto.BASE_ICMS                     = '', Unassigned, FormataFloatFireBird(modelo.objeto.BASE_ICMS));
    pQry.ParamByName('valor_icms').Values[lCount]                   := IIF(modelo.objeto.VALOR_ICMS                    = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_ICMS));
    pQry.ParamByName('base_st').Values[lCount]                      := IIF(modelo.objeto.BASE_ST                       = '', Unassigned, FormataFloatFireBird(modelo.objeto.BASE_ST));
    pQry.ParamByName('desc_restituicao_st').Values[lCount]          := IIF(modelo.objeto.DESC_RESTITUICAO_ST           = '', Unassigned, FormataFloatFireBird(modelo.objeto.DESC_RESTITUICAO_ST));
    pQry.ParamByName('icms_suframa').Values[lCount]                 := IIF(modelo.objeto.ICMS_SUFRAMA                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.ICMS_SUFRAMA));
    pQry.ParamByName('pis_suframa').Values[lCount]                  := IIF(modelo.objeto.PIS_SUFRAMA                   = '', Unassigned, FormataFloatFireBird(modelo.objeto.PIS_SUFRAMA));
    pQry.ParamByName('cofins_suframa').Values[lCount]               := IIF(modelo.objeto.COFINS_SUFRAMA                = '', Unassigned, FormataFloatFireBird(modelo.objeto.COFINS_SUFRAMA));
    pQry.ParamByName('ipi_suframa').Values[lCount]                  := IIF(modelo.objeto.IPI_SUFRAMA                   = '', Unassigned, FormataFloatFireBird(modelo.objeto.IPI_SUFRAMA));
    pQry.ParamByName('aliq_pis').Values[lCount]                     := IIF(modelo.objeto.ALIQ_PIS                      = '', Unassigned, FormataFloatFireBird(modelo.objeto.ALIQ_PIS));
    pQry.ParamByName('aliq_cofins').Values[lCount]                  := IIF(modelo.objeto.ALIQ_COFINS                   = '', Unassigned, FormataFloatFireBird(modelo.objeto.ALIQ_COFINS));
    pQry.ParamByName('base_pis').Values[lCount]                     := IIF(modelo.objeto.BASE_PIS                      = '', Unassigned, FormataFloatFireBird(modelo.objeto.BASE_PIS));
    pQry.ParamByName('base_cofins').Values[lCount]                  := IIF(modelo.objeto.BASE_COFINS                   = '', Unassigned, FormataFloatFireBird(modelo.objeto.BASE_COFINS));
    pQry.ParamByName('valor_pis').Values[lCount]                    := IIF(modelo.objeto.VALOR_PIS                     = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_PIS));
    pQry.ParamByName('valor_cofins').Values[lCount]                 := IIF(modelo.objeto.VALOR_COFINS                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_COFINS));
    pQry.ParamByName('prevenda_id').Values[lCount]                  := IIF(modelo.objeto.PREVENDA_ID                   = '', Unassigned, modelo.objeto.PREVENDA_ID);
    pQry.ParamByName('avulso').Values[lCount]                       := IIF(modelo.objeto.AVULSO                        = '', Unassigned, modelo.objeto.AVULSO);
    pQry.ParamByName('quantidade_new').Values[lCount]               := IIF(modelo.objeto.QUANTIDADE_NEW                = '', Unassigned, FormataFloatFireBird(modelo.objeto.QUANTIDADE_NEW));
    pQry.ParamByName('balanca').Values[lCount]                      := IIF(modelo.objeto.BALANCA                       = '', Unassigned, modelo.objeto.BALANCA);
    pQry.ParamByName('ambiente_id').Values[lCount]                  := IIF(modelo.objeto.AMBIENTE_ID                   = '', Unassigned, modelo.objeto.AMBIENTE_ID);
    pQry.ParamByName('ambiente_obs').Values[lCount]                 := IIF(modelo.objeto.AMBIENTE_OBS                  = '', Unassigned, modelo.objeto.AMBIENTE_OBS);
    pQry.ParamByName('projeto_id').Values[lCount]                   := IIF(modelo.objeto.PROJETO_ID                    = '', Unassigned, modelo.objeto.PROJETO_ID);
    pQry.ParamByName('largura').Values[lCount]                      := IIF(modelo.objeto.LARGURA                       = '', Unassigned, modelo.objeto.LARGURA);
    pQry.ParamByName('altura').Values[lCount]                       := IIF(modelo.objeto.ALTURA                        = '', Unassigned, modelo.objeto.ALTURA);
    pQry.ParamByName('item').Values[lCount]                         := IIF(modelo.objeto.ITEM                          = '', Unassigned, modelo.objeto.ITEM);
    pQry.ParamByName('dun14').Values[lCount]                        := IIF(modelo.objeto.DUN14                         = '', Unassigned, modelo.objeto.DUN14);
    pQry.ParamByName('saidas_id').Values[lCount]                    := IIF(modelo.objeto.SAIDAS_ID                     = '', Unassigned, modelo.objeto.SAIDAS_ID);
    pQry.ParamByName('custo_drg').Values[lCount]                    := IIF(modelo.objeto.CUSTO_DRG                     = '', Unassigned, FormataFloatFireBird(modelo.objeto.CUSTO_DRG));
    pQry.ParamByName('pos_venda_status').Values[lCount]             := IIF(modelo.objeto.POS_VENDA_STATUS              = '', Unassigned, modelo.objeto.POS_VENDA_STATUS);
    pQry.ParamByName('pos_venda_retorno').Values[lCount]            := IIF(modelo.objeto.POS_VENDA_RETORNO             = '', Unassigned, modelo.objeto.POS_VENDA_RETORNO);
    pQry.ParamByName('pos_venda_obs').Values[lCount]                := IIF(modelo.objeto.POS_VENDA_OBS                 = '', Unassigned, modelo.objeto.POS_VENDA_OBS);
    pQry.ParamByName('bonus').Values[lCount]                        := IIF(modelo.objeto.BONUS                         = '', Unassigned, modelo.objeto.BONUS);
    pQry.ParamByName('bonus_uso').Values[lCount]                    := IIF(modelo.objeto.BONUS_USO                     = '', Unassigned, modelo.objeto.BONUS_USO);
    pQry.ParamByName('funcionario_id').Values[lCount]               := IIF(modelo.objeto.FUNCIONARIO_ID                = '', Unassigned, modelo.objeto.FUNCIONARIO_ID);
    pQry.ParamByName('producao_id').Values[lCount]                  := IIF(modelo.objeto.PRODUCAO_ID                   = '', Unassigned, modelo.objeto.PRODUCAO_ID);
    pQry.ParamByName('quantidade_kg').Values[lCount]                := IIF(modelo.objeto.QUANTIDADE_KG                 = '', Unassigned, FormataFloatFireBird(modelo.objeto.QUANTIDADE_KG));
    pQry.ParamByName('reservado').Values[lCount]                    := IIF(modelo.objeto.RESERVADO                     = '', Unassigned, FormataFloatFireBird(modelo.objeto.RESERVADO));
    pQry.ParamByName('descricao_produto').Values[lCount]            := IIF(modelo.objeto.DESCRICAO_PRODUTO             = '', Unassigned, modelo.objeto.DESCRICAO_PRODUTO);
    pQry.ParamByName('comissao_percentual').Values[lCount]          := IIF(modelo.objeto.COMISSAO_PERCENTUAL           = '', Unassigned, FormataFloatFireBird(modelo.objeto.COMISSAO_PERCENTUAL));
    pQry.ParamByName('qtd_checagem').Values[lCount]                 := IIF(modelo.objeto.QTD_CHECAGEM                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.QTD_CHECAGEM));
    pQry.ParamByName('qtd_checagem_corte').Values[lCount]           := IIF(modelo.objeto.QTD_CHECAGEM_CORTE            = '', Unassigned, FormataFloatFireBird(modelo.objeto.QTD_CHECAGEM_CORTE));
    pQry.ParamByName('altura_m').Values[lCount]                     := IIF(modelo.objeto.ALTURA_M                      = '', Unassigned, FormataFloatFireBird(modelo.objeto.ALTURA_M));
    pQry.ParamByName('largura_m').Values[lCount]                    := IIF(modelo.objeto.LARGURA_M                     = '', Unassigned, FormataFloatFireBird(modelo.objeto.LARGURA_M));
    pQry.ParamByName('profundidade_m').Values[lCount]               := IIF(modelo.objeto.PROFUNDIDADE_M                = '', Unassigned, FormataFloatFireBird(modelo.objeto.PROFUNDIDADE_M));
    pQry.ParamByName('vbcufdest').Values[lCount]                    := IIF(modelo.objeto.VBCUFDEST                     = '', Unassigned, FormataFloatFireBird(modelo.objeto.VBCUFDEST));
    pQry.ParamByName('pfcpufdest').Values[lCount]                   := IIF(modelo.objeto.PFCPUFDEST                    = '', Unassigned, FormataFloatFireBird(modelo.objeto.PFCPUFDEST));
    pQry.ParamByName('picmsufdest').Values[lCount]                  := IIF(modelo.objeto.PICMSUFDEST                   = '', Unassigned, FormataFloatFireBird(modelo.objeto.PICMSUFDEST));
    pQry.ParamByName('picmsinter').Values[lCount]                   := IIF(modelo.objeto.PICMSINTER                    = '', Unassigned, FormataFloatFireBird(modelo.objeto.PICMSINTER));
    pQry.ParamByName('picmsinterpart').Values[lCount]               := IIF(modelo.objeto.PICMSINTERPART                = '', Unassigned, FormataFloatFireBird(modelo.objeto.PICMSINTERPART));
    pQry.ParamByName('vfcpufdest').Values[lCount]                   := IIF(modelo.objeto.VFCPUFDEST                    = '', Unassigned, FormataFloatFireBird(modelo.objeto.VFCPUFDEST));
    pQry.ParamByName('vicmsufdest').Values[lCount]                  := IIF(modelo.objeto.VICMSUFDEST                   = '', Unassigned, FormataFloatFireBird(modelo.objeto.VICMSUFDEST));
    pQry.ParamByName('vicmsufremet').Values[lCount]                 := IIF(modelo.objeto.VICMSUFREMET                  = '', Unassigned, FormataFloatFireBird(modelo.objeto.VICMSUFREMET));
    pQry.ParamByName('combo_item').Values[lCount]                   := IIF(modelo.objeto.COMBO_ITEM                    = '', Unassigned, modelo.objeto.COMBO_ITEM);
    pQry.ParamByName('vlrvenda_minimo').Values[lCount]              := IIF(modelo.objeto.VLRVENDA_MINIMO               = '', Unassigned, FormataFloatFireBird(modelo.objeto.VLRVENDA_MINIMO));
    pQry.ParamByName('vlrvenda_maximo').Values[lCount]              := IIF(modelo.objeto.VLRVENDA_MAXIMO               = '', Unassigned, FormataFloatFireBird(modelo.objeto.VLRVENDA_MAXIMO));
    pQry.ParamByName('impresso').Values[lCount]                     := IIF(modelo.objeto.IMPRESSO                      = '', Unassigned, modelo.objeto.IMPRESSO);
    pQry.ParamByName('orcamento_tsb_id').Values[lCount]             := IIF(modelo.objeto.ORCAMENTO_TSB_ID              = '', Unassigned, modelo.objeto.ORCAMENTO_TSB_ID);
    pQry.ParamByName('gerente_comissao_percentual').Values[lCount]  := IIF(modelo.objeto.GERENTE_COMISSAO_PERCENTUAL   = '', Unassigned, FormataFloatFireBird(modelo.objeto.GERENTE_COMISSAO_PERCENTUAL));
    pQry.ParamByName('xped').Values[lCount]                         := IIF(modelo.objeto.XPED                          = '', Unassigned, modelo.objeto.XPED);
    pQry.ParamByName('nitemped2').Values[lCount]                    := IIF(modelo.objeto.NITEMPED2                     = '', Unassigned, modelo.objeto.NITEMPED2);
    pQry.ParamByName('voutros').Values[lCount]                      := IIF(modelo.objeto.VOUTROS                       = '', Unassigned, FormataFloatFireBird(modelo.objeto.VOUTROS));
    pQry.ParamByName('vfrete').Values[lCount]                       := IIF(modelo.objeto.VFRETE                        = '', Unassigned, FormataFloatFireBird(modelo.objeto.VFRETE));
    pQry.ParamByName('original_pedido_id').Values[lCount]           := IIF(modelo.objeto.ORIGINAL_PEDIDO_ID            = '', Unassigned, modelo.objeto.ORIGINAL_PEDIDO_ID);
    pQry.ParamByName('valor_venda_cadastro').Values[lCount]         := IIF(modelo.objeto.VALOR_VENDA_CADASTRO          = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_VENDA_CADASTRO));
    pQry.ParamByName('web_pedidoitens_id').Values[lCount]           := IIF(modelo.objeto.WEB_PEDIDOITENS_ID            = '', Unassigned, modelo.objeto.WEB_PEDIDOITENS_ID);
    pQry.ParamByName('tipo_venda').Values[lCount]                   := IIF(modelo.objeto.TIPO_VENDA                    = '', Unassigned, modelo.objeto.TIPO_VENDA);
    pQry.ParamByName('entrega').Values[lCount]                      := IIF(modelo.objeto.ENTREGA                       = '', Unassigned, modelo.objeto.ENTREGA);
    pQry.ParamByName('vbcfcpst').Values[lCount]                     := IIF(modelo.objeto.VBCFCPST                      = '', Unassigned, FormataFloatFireBird(modelo.objeto.VBCFCPST));
    pQry.ParamByName('pfcpst').Values[lCount]                       := IIF(modelo.objeto.PFCPST                        = '', Unassigned, FormataFloatFireBird(modelo.objeto.PFCPST));
    pQry.ParamByName('vfcpst').Values[lCount]                       := IIF(modelo.objeto.VFCPST                        = '', Unassigned, FormataFloatFireBird(modelo.objeto.VFCPST));
    pQry.ParamByName('valor_bonus_servico').Values[lCount]          := IIF(modelo.objeto.VALOR_BONUS_SERVICO           = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_BONUS_SERVICO));
    pQry.ParamByName('cbenef').Values[lCount]                       := IIF(modelo.objeto.CBENEF                        = '', Unassigned, modelo.objeto.CBENEF);
    pQry.ParamByName('vicmsdeson').Values[lCount]                   := IIF(modelo.objeto.VICMSDESON                    = '', Unassigned, FormataFloatFireBird(modelo.objeto.VICMSDESON));
    pQry.ParamByName('motdesicms').Values[lCount]                   := IIF(modelo.objeto.MOTDESICMS                    = '', Unassigned, modelo.objeto.MOTDESICMS);
    pQry.ParamByName('valor_diferimento').Values[lCount]            := IIF(modelo.objeto.VALOR_DIFERIMENTO             = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_DIFERIMENTO));
    pQry.ParamByName('valor_montador').Values[lCount]               := IIF(modelo.objeto.VALOR_MONTADOR                = '', Unassigned, FormataFloatFireBird(modelo.objeto.VALOR_MONTADOR));
    pQry.ParamByName('montagem').Values[lCount]                     := IIF(modelo.objeto.MONTAGEM                      = '', Unassigned, modelo.objeto.MONTAGEM);
    pQry.ParamByName('pcred_presumido').Values[lCount]              := IIF(modelo.objeto.PCRED_PRESUMIDO               = '', Unassigned, FormataFloatFireBird(modelo.objeto.PCRED_PRESUMIDO));
    pQry.ParamByName('pedidocompraitens_id').Values[lCount]         := IIF(modelo.objeto.PEDIDOCOMPRAITENS_ID          = '', Unassigned, modelo.objeto.PEDIDOCOMPRAITENS_ID);
    pQry.ParamByName('pedidoitens_id').Values[lCount]               := IIF(modelo.objeto.PEDIDOITENS_ID                = '', Unassigned, modelo.objeto.PEDIDOITENS_ID);
    pQry.ParamByName('pis_cst').Values[lCount]                      := IIF(modelo.objeto.PIS_CST                       = '', Unassigned, modelo.objeto.PIS_CST);
    pQry.ParamByName('cofins_cst').Values[lCount]                   := IIF(modelo.objeto.COFINS_CST                    = '', Unassigned, modelo.objeto.COFINS_CST);
    pQry.ParamByName('ipi_cst').Values[lCount]                      := IIF(modelo.objeto.IPI_CST                       = '', Unassigned, modelo.objeto.IPI_CST);
    pQry.ParamByName('csosn').Values[lCount]                        := IIF(modelo.objeto.CSOSN                         = '', Unassigned, modelo.objeto.CSOSN);
    pQry.ParamByName('cfop').Values[lCount]                         := IIF(modelo.objeto.CFOP                          = '', Unassigned, modelo.objeto.CFOP);

    pQry.ParamByName('tipo_garantia_fr').Values[lCount]             := IIF(modelo.objeto.TIPO_GARANTIA_FR              = '', Unassigned, modelo.objeto.TIPO_GARANTIA_FR);
    pQry.ParamByName('vlr_garantia_fr').Values[lCount]              := IIF(modelo.objeto.VLR_GARANTIA_FR               = '', Unassigned, FormataFloatFireBird(modelo.objeto.VLR_GARANTIA_FR));
    pQry.ParamByName('custo_garantia_fr').Values[lCount]            := IIF(modelo.objeto.CUSTO_GARANTIA_FR             = '', Unassigned, FormataFloatFireBird(modelo.objeto.CUSTO_GARANTIA_FR));
    pQry.ParamByName('custo_garantia').Values[lCount]               := IIF(modelo.objeto.CUSTO_GARANTIA                = '', Unassigned, FormataFloatFireBird(modelo.objeto.CUSTO_GARANTIA));
    pQry.ParamByName('per_garantia_fr').Values[lCount]              := IIF(modelo.objeto.PER_GARANTIA_FR               = '', Unassigned, FormataFloatFireBird(modelo.objeto.PER_GARANTIA_FR));
    inc(lCount);
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
