unit WebPedidoItensDao;

interface

uses
  Terasoft.FuncoesTexto,
  WebPedidoItensModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.Utils,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  Clipbrd;

type
  TWebPedidoItensDao = class;
  ITWebPedidoItensDao=IObject<TWebPedidoItensDao>;

  TWebPedidoItensDao = class
  private
    [unsafe] mySelf: ITWebPedidoItensDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FPedidoWebItenssLista: IList<ITWebPedidoItensModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDPedidoWebView: Integer;
    FIDWebPedidoView: Integer;
    FWebPedidoItenssLista: IList<ITWebPedidoItensModel>;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPedidoWebItenssLista(const Value: IList<ITWebPedidoItensModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    procedure setParams(var pQry: TFDQuery; pWebPedidoItensModel: ITWebPedidoItensModel);

    function where: String;
    procedure SetIDWebPedidoView(const Value: Integer);
    procedure SetWebPedidoItenssLista(const Value: IList<ITWebPedidoItensModel>);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITWebPedidoItensDao;

    property WebPedidoItenssLista: IList<ITWebPedidoItensModel> read FWebPedidoItenssLista write SetWebPedidoItenssLista;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDWebPedidoView: Integer read FIDWebPedidoView write SetIDWebPedidoView;

    function incluir(pWebPedidoItensModel: ITWebPedidoItensModel): String;
    function alterar(pWebPedidoItensModel: ITWebPedidoItensModel): String;
    function excluir(pWebPedidoItensModel: ITWebPedidoItensModel): String;

    function obterTotais(pId: String): TTotais;


    procedure obterLista;
    function carregaClasse(pId: String): ITWebPedidoItensModel;
end;

implementation

uses
  Terasoft.Framework.LOG,
  System.Rtti;

{ TWebPedidoItens }

function TWebPedidoItensDao.alterar(pWebPedidoItensModel: ITWebPedidoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('WEB_PEDIDOITENS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pWebPedidoItensModel);
    lQry.ExecSQL;

    Result := pWebPedidoItensModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TWebPedidoItensDao.carregaClasse(pId: String): ITWebPedidoItensModel;
var
  lQry: TFDQuery;
  lModel: ITWebPedidoItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TWebPedidoItensModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from web_pedidoitens where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                   := ZeroLeft(lQry.FieldByName('ID').AsString, 6);
    lModel.objeto.WEB_PEDIDO_ID        := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    lModel.objeto.PRODUTO_ID           := lQry.FieldByName('PRODUTO_ID').AsString;
    lModel.objeto.QUANTIDADE           := lQry.FieldByName('QUANTIDADE').AsString;
    lModel.objeto.QUANTIDADE_TROCA     := lQry.FieldByName('QUANTIDADE_TROCA').AsString;
    lModel.objeto.VALOR_UNITARIO       := lQry.FieldByName('VALOR_UNITARIO').AsString;
    lModel.objeto.PERCENTUAL_DESCONTO  := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
    lModel.objeto.VALOR_VENDA_ATUAL    := lQry.FieldByName('VALOR_VENDA_ATUAL').AsString;
    lModel.objeto.VALOR_CUSTO_ATUAL    := lQry.FieldByName('VALOR_CUSTO_ATUAL').AsString;
    lModel.objeto.PERCENTUAL_COMISSAO  := lQry.FieldByName('PERCENTUAL_COMISSAO').AsString;
    lModel.objeto.OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.objeto.QUANTIDADE_OLD       := lQry.FieldByName('QUANTIDADE_OLD').AsString;
    lModel.objeto.QUANTIDADE_TROCA_OLD := lQry.FieldByName('QUANTIDADE_TROCA_OLD').AsString;
    lModel.objeto.AVULSO               := lQry.FieldByName('AVULSO').AsString;
    lModel.objeto.VALOR_ST             := lQry.FieldByName('VALOR_ST').AsString;
    lModel.objeto.RESERVADO            := lQry.FieldByName('RESERVADO').AsString;
    lModel.objeto.TIPO_GARANTIA        := lQry.FieldByName('TIPO_GARANTIA').AsString;
    lModel.objeto.VLR_GARANTIA         := lQry.FieldByName('VLR_GARANTIA').AsString;
    lModel.objeto.TIPO_ENTREGA         := lQry.FieldByName('TIPO_ENTREGA').AsString;
    lModel.objeto.MONTAGEM             := lQry.FieldByName('MONTAGEM').AsString;
    lModel.objeto.ENTREGA              := lQry.FieldByName('ENTREGA').AsString;
    lModel.objeto.TIPO                 := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.QUANTIDADE_PENDENTE  := lQry.FieldByName('QUANTIDADE_PENDENTE').AsString;
    lModel.objeto.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.VALOR_VENDIDO        := lQry.FieldByName('VALOR_VENDIDO').AsString;
    lModel.objeto.QUANTIDADE_SEPARACAO := lQry.FieldByName('QUANTIDADE_SEPARACAO').AsString;
    lModel.objeto.ALIQ_IPI             := lQry.FieldByName('ALIQ_IPI').AsString;
    lModel.objeto.VALOR_IPI            := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.objeto.CFOP_ID              := lQry.FieldByName('CFOP_ID').AsString;
    lModel.objeto.CST                  := lQry.FieldByName('CST').AsString;
    lModel.objeto.VALOR_RESTITUICAO_ST := lQry.FieldByName('VALOR_RESTITUICAO_ST').AsString;
    lModel.objeto.ALIQ_ICMS            := lQry.FieldByName('ALIQ_ICMS').AsString;
    lModel.objeto.ALIQ_ICMS_ST         := lQry.FieldByName('ALIQ_ICMS_ST').AsString;
    lModel.objeto.REDUCAO_ST           := lQry.FieldByName('REDUCAO_ST').AsString;
    lModel.objeto.MVA                  := lQry.FieldByName('MVA').AsString;
    lModel.objeto.REDUCAO_ICMS         := lQry.FieldByName('REDUCAO_ICMS').AsString;
    lModel.objeto.BASE_ICMS            := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.objeto.VALOR_ICMS           := lQry.FieldByName('VALOR_ICMS').AsString;
    lModel.objeto.BASE_ST              := lQry.FieldByName('BASE_ST').AsString;
    lModel.objeto.DESC_RESTITUICAO_ST  := lQry.FieldByName('DESC_RESTITUICAO_ST').AsString;
    lModel.objeto.ICMS_SUFRAMA         := lQry.FieldByName('ICMS_SUFRAMA').AsString;
    lModel.objeto.PIS_SUFRAMA          := lQry.FieldByName('PIS_SUFRAMA').AsString;
    lModel.objeto.COFINS_SUFRAMA       := lQry.FieldByName('COFINS_SUFRAMA').AsString;
    lModel.objeto.IPI_SUFRAMA          := lQry.FieldByName('IPI_SUFRAMA').AsString;
    lModel.objeto.ALIQ_PIS             := lQry.FieldByName('ALIQ_PIS').AsString;
    lModel.objeto.ALIQ_COFINS          := lQry.FieldByName('ALIQ_COFINS').AsString;
    lModel.objeto.BASE_PIS             := lQry.FieldByName('BASE_PIS').AsString;
    lModel.objeto.BASE_COFINS          := lQry.FieldByName('BASE_COFINS').AsString;
    lModel.objeto.VALOR_PIS            := lQry.FieldByName('VALOR_PIS').AsString;
    lModel.objeto.VALOR_COFINS         := lQry.FieldByName('VALOR_COFINS').AsString;
    lModel.objeto.VBCFCPST             := lQry.FieldByName('VBCFCPST').AsString;
    lModel.objeto.PFCPST               := lQry.FieldByName('PFCPST').AsString;
    lModel.objeto.VFCPST               := lQry.FieldByName('VFCPST').AsString;
    lModel.objeto.VALOR_FRETE_SUBTRAIR := lQry.FieldByName('VALOR_FRETE_SUBTRAIR').AsString;
    lModel.objeto.TIPO_GARANTIA_FR     := lQry.FieldByName('TIPO_GARANTIA_FR').AsString;
    lModel.objeto.VLR_GARANTIA_FR      := lQry.FieldByName('VLR_GARANTIA_FR').AsString;
    lModel.objeto.CUSTO_GARANTIA_FR    := lQry.FieldByName('CUSTO_GARANTIA_FR').AsString;
    lModel.objeto.CUSTO_GARANTIA       := lQry.FieldByName('CUSTO_GARANTIA').AsString;
    lModel.objeto.PER_GARANTIA_FR      := lQry.FieldByName('PER_GARANTIA_FR').AsString;
    lModel.objeto.VLRVENDA_PRO         := lQry.FieldByName('VLRVENDA_PRO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TWebPedidoItensDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TWebPedidoItensDao.Destroy;
begin
  FPedidoWebItenssLista := nil;
  FWebPedidoItenssLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TWebPedidoItensDao.excluir(pWebPedidoItensModel: ITWebPedidoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from WEB_PEDIDOITENS where ID = :ID',[pWebPedidoItensModel.objeto.ID]);
   lQry.ExecSQL;

   Result := pWebPedidoItensModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TWebPedidoItensDao.getNewIface(pIConexao: IConexao): ITWebPedidoItensDao;
begin
  Result := TImplObjetoOwner<TWebPedidoItensDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TWebPedidoItensDao.incluir(pWebPedidoItensModel: ITWebPedidoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('WEB_PEDIDOITENS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pWebPedidoItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TWebPedidoItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0 then
    lSQL := lSQL + ' and id = '+IntToStr(FIDRecordView);

  if FIDWebPedidoView <> 0 then
    lSQL := lSQL + ' and web_pedido_id = '+IntToStr(FIDWebPedidoView);

  Result := lSQL;
end;

function TWebPedidoItensDao.obterTotais(pId: String): TTotais;
var
  lQry  : TFDQuery;
  lSQL  : String;
  lTotais : TTotais;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := '   select                                                                                                   '+SLineBreak+
            '      WEB_PEDIDO_ID,                                                                                        '+SLineBreak+
            '      SEGURO_PRESTAMISTA_VALOR,                                                                             '+SLineBreak+
            '      VALOR_ACRESCIMO,                                                                                      '+SLineBreak+
            '      VALOR_FRETE,                                                                                          '+SLineBreak+
            '      VALOR_DESCONTO,                                                                                       '+SLineBreak+
            '      VALOR_ITENS,                                                                                          '+SLineBreak+
            '      TOTAL_GARANTIA                                                                                        '+SLineBreak+
            '    from                                                                                                    '+SLineBreak+
            '    (                                                                                                       '+SLineBreak+
            '     select                                                                                                 '+SLineBreak+
            '       web_pedido_id,                                                                                       '+SLineBreak+
            '       seguro_prestamista_valor,                                                                            '+SLineBreak+
            '       valor_acrescimo valor_acrescimo,                                                                     '+SLineBreak+
            '       valor_frete valor_frete,                                                                             '+SLineBreak+
            '       sum(quantidade * valor_desconto) valor_desconto,                                                     '+SLineBreak+
            '       sum(quantidade * (valor_unitario)) valor_itens,                                                      '+SLineBreak+
            '       sum(quantidade * valor_garantia) total_garantia                                                      '+SLineBreak+
            '      from                                                                                                  '+SLineBreak+
            '      (                                                                                                     '+SLineBreak+
            '        select i.web_pedido_id,                                                                             '+SLineBreak+
            '               seguro_prestamista_valor,                                                                    '+SLineBreak+
            '               coalesce(p.acrescimo, 0) valor_acrescimo,                                                    '+SLineBreak+
            '               coalesce(p.valor_frete, 0) valor_frete,                                                      '+SLineBreak+
            '               coalesce(i.valor_unitario, 0) * coalesce(i.percentual_desconto,0) / 100 valor_desconto,      '+SLineBreak+
            '               coalesce(i.quantidade,0) quantidade,                                                         '+SLineBreak+
            '               coalesce(i.valor_unitario,0) valor_unitario,                                                 '+SLineBreak+
            '               coalesce(i.vlr_garantia,0)+coalesce(i.vlr_garantia_fr,0) valor_garantia                      '+SLineBreak+
            '         from web_pedidoitens i                                                                             '+SLineBreak+
            '        inner join web_pedido p on i.web_pedido_id = p.id ) t1                                              '+SLineBreak+
            '        group by 1,2,3,4 ) t2                                                                               '+SLineBreak+
            '   where web_pedido_id = ' +pID;

    lQry.Open(lSQL);

    Result.SEGURO_PRESTAMISTA_VALOR  := lQry.FieldByName('SEGURO_PRESTAMISTA_VALOR').AsFloat;
    Result.VALOR_ACRESCIMO           := lQry.FieldByName('VALOR_ACRESCIMO').AsFloat;
    Result.VALOR_FRETE               := lQry.FieldByName('VALOR_FRETE').AsFloat;
    Result.VALOR_DESCONTO            := lQry.FieldByName('VALOR_DESCONTO').AsFloat;
    Result.VALOR_ITENS               := lQry.FieldByName('VALOR_ITENS').AsFloat;
    Result.TOTAL_GARANTIA            := lQry.FieldByName('TOTAL_GARANTIA').AsFloat;

    Result.TOTAL_PAGAR  := lQry.FieldByName('VALOR_ITENS').AsFloat +
                           lQry.FieldByName('VALOR_FRETE').AsFloat +
                           lQry.FieldByName('TOTAL_GARANTIA').AsFloat+
                           lQry.FieldByName('VALOR_DESCONTO').AsFloat;


    Result.VALOR_TOTAL  := lQry.FieldByName('VALOR_ITENS').AsFloat +
                           lQry.FieldByName('VALOR_FRETE').AsFloat +
                           lQry.FieldByName('TOTAL_GARANTIA').AsFloat+
                           lQry.FieldByName('SEGURO_PRESTAMISTA_VALOR').AsFloat+
                           lQry.FieldByName('VALOR_ACRESCIMO').AsFloat -
                           lQry.FieldByName('VALOR_DESCONTO').AsFloat;
  finally
    lQry.Free;
  end;
end;

procedure TWebPedidoItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From web_pedidoitens where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TWebPedidoItensDao.obterLista;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
  modelo: ITWebPedidoItensModel;
begin
  lQry := vIConexao.CriarQuery;

  FWebPedidoItenssLista := TCollections.CreateList<ITWebPedidoItensModel>;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSQL :=   '  select '+lPaginacao+'                                                                                                                                         '+SLineBreak+
              '      ID,                                                                                                                                                       '+SLineBreak+
              '      UNIDADE_PRO,                                                                                                                                              '+SLineBreak+
              '      WEB_PEDIDO_ID,                                                                                                                                            '+SLineBreak+
              '      QUANTIDADE,                                                                                                                                               '+SLineBreak+
              '      TIPO_ENTREGA,                                                                                                                                             '+SLineBreak+
              '      TIPO_GARANTIA,                                                                                                                                            '+SLineBreak+
              '      TIPO,                                                                                                                                                     '+SLineBreak+
              '      OBSERVACAO,                                                                                                                                               '+SLineBreak+
              '      PRODUTO_ID,                                                                                                                                               '+SLineBreak+
              '      ENTREGA,                                                                                                                                                  '+SLineBreak+
              '      MONTAGEM,                                                                                                                                                 '+SLineBreak+
              '      PERCENTUAL_DESCONTO,                                                                                                                                      '+SLineBreak+
              '      VALOR_UNITARIO,                                                                                                                                           '+SLineBreak+
              '      NOME_PRO,                                                                                                                                                 '+SLineBreak+
              '      VALOR_CUSTO_ATUAL,                                                                                                                                        '+SLineBreak+
              '      TIPO_GARANTIA_FR,                                                                                                                                         '+SLineBreak+
              '      CUSTO_GARANTIA_FR,                                                                                                                                        '+SLineBreak+
              '      CUSTO_GARANTIA,                                                                                                                                           '+SLineBreak+
              '      PER_GARANTIA_FR,                                                                                                                                          '+SLineBreak+
              '      VALOR_VENDA_ATUAL,                                                                                                                                        '+SLineBreak+
              '      VLRVENDA_PRO,                                                                                                                                             '+SLineBreak+
              '      VLR_GARANTIA,                                                                                                                                             '+SLineBreak+
              '      VLR_GARANTIA_FR,                                                                                                                                          '+SLineBreak+
              '      VALOR_TOTALITENS                                                                                                                                          '+SLineBreak+
              '        + TOTAL_GARANTIA - VALOR_DESCONTO VALOR_TOTALITENS,                                                                                                     '+SLineBreak+
              '      TOTAL_GARANTIA,                                                                                                                                           '+SLineBreak+
              '      VALOR_DESCONTO                                                                                                                                            '+SLineBreak+
              '      From                                                                                                                                                      '+SLineBreak+
              '         ( select                                                                                                                                               '+SLineBreak+
              '              web_pedidoitens.id,                                                                                                                               '+SLineBreak+
              '              produto.unidade_pro,                                                                                                                              '+SLineBreak+
              '              web_pedidoitens.web_pedido_id,                                                                                                                    '+SLineBreak+
              '              web_pedidoitens.quantidade,                                                                                                                       '+SLineBreak+
              '              web_pedidoitens.tipo_entrega,                                                                                                                     '+SLineBreak+
              '              web_pedidoitens.tipo_garantia,                                                                                                                    '+SLineBreak+
              '              web_pedidoitens.tipo,                                                                                                                             '+SLineBreak+
              '              web_pedidoitens.observacao,                                                                                                                       '+SLineBreak+
              '              web_pedidoitens.produto_id,                                                                                                                       '+SLineBreak+
              '              web_pedidoitens.entrega,                                                                                                                          '+SLineBreak+
              '              web_pedidoitens.montagem,                                                                                                                         '+SLineBreak+
              '              web_pedidoitens.percentual_desconto,                                                                                                              '+SLineBreak+
              '              web_pedidoitens.valor_unitario,                                                                                                                   '+SLineBreak+
              '              produto.nome_pro,                                                                                                                                 '+SLineBreak+
              '              web_pedidoitens.valor_custo_atual,                                                                                                                '+SLineBreak+
              '              web_pedidoitens.tipo_garantia_fr,                                                                                                                 '+SLineBreak+
              '              web_pedidoitens.custo_garantia_fr,                                                                                                                '+SLineBreak+
              '              web_pedidoitens.custo_garantia,                                                                                                                   '+SLineBreak+
              '              web_pedidoitens.per_garantia_fr,                                                                                                                  '+SLineBreak+
              '              web_pedidoitens.valor_venda_atual,                                                                                                                '+SLineBreak+
              '              web_pedidoitens.vlrvenda_pro,                                                                                                                     '+SLineBreak+
              '              coalesce(web_pedidoitens.vlr_garantia, 0) vlr_garantia,                                                                                           '+SLineBreak+
              '              coalesce(web_pedidoitens.vlr_garantia_fr, 0) vlr_garantia_fr,                                                                                     '+SLineBreak+
              '              coalesce(web_pedidoitens.quantidade, 0) * coalesce(web_pedidoitens.valor_unitario,0) valor_totalitens,                                            '+SLineBreak+
              '              coalesce(web_pedidoitens.quantidade,0) * (coalesce(web_pedidoitens.vlr_garantia,0)+coalesce(web_pedidoitens.vlr_garantia_fr,0)) total_garantia,   '+SLineBreak+
              '              coalesce(web_pedidoitens.valor_unitario * web_pedidoitens.quantidade, 0) * coalesce(web_pedidoitens.percentual_desconto,0) / 100 valor_desconto   '+SLineBreak+
              '                                                                                                                                                                '+SLineBreak+
              '          from web_pedidoitens                                                                                                                                  '+SLineBreak+
              '          inner join produto on produto.codigo_pro = web_pedidoitens.produto_id                                                                                 '+SLineBreak+
              '                                                                                                                                                                '+SLineBreak+
              '          ) where 1=1 ';

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    logaByTagSeNivel(TAGLOG_FRAMEWORK,format('TWebPedidoItensDao.obterLista(%s): [%s]', [ vIConexao.empresa.ID, lSQL ] ), LOG_LEVEL_DEBUG);
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TWebPedidoItensModel.getNewIface(vIConexao);
      FWebPedidoItenssLista.Add(modelo);

      modelo.objeto.ID                   := lQry.FieldByName('ID').AsString;
      modelo.objeto.UNIDADE_PRO          := lQry.FieldByName('UNIDADE_PRO').AsString;
      modelo.objeto.WEB_PEDIDO_ID        := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
      modelo.objeto.QUANTIDADE           := lQry.FieldByName('QUANTIDADE').AsFloat;
      modelo.objeto.TIPO_ENTREGA         := lQry.FieldByName('TIPO_ENTREGA').AsString;
      modelo.objeto.TIPO_GARANTIA        := lQry.FieldByName('TIPO_GARANTIA').AsString;
      modelo.objeto.TIPO                 := lQry.FieldByName('TIPO').AsString;
      modelo.objeto.OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      modelo.objeto.PRODUTO_ID           := lQry.FieldByName('PRODUTO_ID').AsString;
      modelo.objeto.VLR_GARANTIA         := lQry.FieldByName('VLR_GARANTIA').AsFloat;
      modelo.objeto.ENTREGA              := lQry.FieldByName('ENTREGA').AsString;
      modelo.objeto.MONTAGEM             := lQry.FieldByName('MONTAGEM').AsString;
      modelo.objeto.PERCENTUAL_DESCONTO  := lQry.FieldByName('PERCENTUAL_DESCONTO').AsFloat;
      modelo.objeto.VALOR_UNITARIO       := lQry.FieldByName('VALOR_UNITARIO').AsFloat;
      modelo.objeto.PRODUTO_NOME         := lQry.FieldByName('NOME_PRO').AsString;
      modelo.objeto.TIPO_GARANTIA_FR     := lQry.FieldByName('TIPO_GARANTIA_FR').AsString;
      modelo.objeto.VLR_GARANTIA_FR      := lQry.FieldByName('VLR_GARANTIA_FR').AsString;
      modelo.objeto.CUSTO_GARANTIA_FR    := lQry.FieldByName('CUSTO_GARANTIA_FR').AsString;
      modelo.objeto.CUSTO_GARANTIA       := lQry.FieldByName('CUSTO_GARANTIA').AsString;
      modelo.objeto.PER_GARANTIA_FR      := lQry.FieldByName('PER_GARANTIA_FR').AsString;
      modelo.objeto.VALOR_VENDA_ATUAL    := lQry.FieldByName('VALOR_VENDA_ATUAL').AsString;
      modelo.objeto.VALOR_CUSTO_ATUAL    := lQry.FieldByName('VALOR_CUSTO_ATUAL').AsString;
      modelo.objeto.VLRVENDA_PRO         := lQry.FieldByName('VLRVENDA_PRO').AsString;
      modelo.objeto.TOTAL_GARANTIA       := lQry.FieldByName('TOTAL_GARANTIA').AsString;
      modelo.objeto.VALOR_TOTALITENS     := lQry.FieldByName('VALOR_TOTALITENS').AsString;
      modelo.objeto.VALOR_DESCONTO       := lQry.FieldByName('VALOR_DESCONTO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TWebPedidoItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TWebPedidoItensDao.SetWebPedidoItenssLista;
begin
  FWebPedidoItenssLista := Value;
end;

procedure TWebPedidoItensDao.SetIDWebPedidoView(const Value: Integer);
begin
  FIDWebPedidoView := Value;
end;

procedure TWebPedidoItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TWebPedidoItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TWebPedidoItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TWebPedidoItensDao.setParams(var pQry: TFDQuery; pWebPedidoItensModel: ITWebPedidoItensModel);
begin
  vConstrutor.setParams('WEB_PEDIDOITENS',pQry,pWebPedidoItensModel.objeto);
end;

procedure TWebPedidoItensDao.SetPedidoWebItenssLista;
begin
end;

procedure TWebPedidoItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TWebPedidoItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TWebPedidoItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
