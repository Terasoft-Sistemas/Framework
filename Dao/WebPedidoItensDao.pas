unit WebPedidoItensDao;

interface

uses
  Terasoft.FuncoesTexto,
  WebPedidoItensModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Utils,
  Interfaces.Conexao,
  Clipbrd;

type
  TWebPedidoItensDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPedidoWebItenssLista: TObjectList<TWebPedidoItensModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDPedidoWebView: Integer;
    FIDWebPedidoView: Integer;
    FWebPedidoItenssLista: TObjectList<TWebPedidoItensModel>;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPedidoWebItenssLista(const Value: TObjectList<TWebPedidoItensModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    procedure setParams(var pQry: TFDQuery; pWebPedidoItensModel: TWebPedidoItensModel);

    function where: String;
    procedure SetIDWebPedidoView(const Value: Integer);
    procedure SetWebPedidoItenssLista(const Value: TObjectList<TWebPedidoItensModel>);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property WebPedidoItenssLista: TObjectList<TWebPedidoItensModel> read FWebPedidoItenssLista write SetWebPedidoItenssLista;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDWebPedidoView: Integer read FIDWebPedidoView write SetIDWebPedidoView;

    function incluir(pWebPedidoItensModel: TWebPedidoItensModel): String;
    function alterar(pWebPedidoItensModel: TWebPedidoItensModel): String;
    function excluir(pWebPedidoItensModel: TWebPedidoItensModel): String;

    function obterTotais(pId: String): TTotais;


    procedure obterLista;
    function carregaClasse(pId: String): TWebPedidoItensModel;
end;

implementation

uses
  System.Rtti;

{ TWebPedidoItens }

function TWebPedidoItensDao.alterar(pWebPedidoItensModel: TWebPedidoItensModel): String;
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

    Result := pWebPedidoItensModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TWebPedidoItensDao.carregaClasse(pId: String): TWebPedidoItensModel;
var
  lQry: TFDQuery;
  lModel: TWebPedidoItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TWebPedidoItensModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from web_pedidoitens where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                   := ZeroLeft(lQry.FieldByName('ID').AsString, 6);
    lModel.WEB_PEDIDO_ID        := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    lModel.PRODUTO_ID           := lQry.FieldByName('PRODUTO_ID').AsString;
    lModel.QUANTIDADE           := lQry.FieldByName('QUANTIDADE').AsString;
    lModel.QUANTIDADE_TROCA     := lQry.FieldByName('QUANTIDADE_TROCA').AsString;
    lModel.VALOR_UNITARIO       := lQry.FieldByName('VALOR_UNITARIO').AsString;
    lModel.PERCENTUAL_DESCONTO  := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
    lModel.VALOR_VENDA_ATUAL    := lQry.FieldByName('VALOR_VENDA_ATUAL').AsString;
    lModel.VALOR_CUSTO_ATUAL    := lQry.FieldByName('VALOR_CUSTO_ATUAL').AsString;
    lModel.PERCENTUAL_COMISSAO  := lQry.FieldByName('PERCENTUAL_COMISSAO').AsString;
    lModel.OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.QUANTIDADE_OLD       := lQry.FieldByName('QUANTIDADE_OLD').AsString;
    lModel.QUANTIDADE_TROCA_OLD := lQry.FieldByName('QUANTIDADE_TROCA_OLD').AsString;
    lModel.AVULSO               := lQry.FieldByName('AVULSO').AsString;
    lModel.VALOR_ST             := lQry.FieldByName('VALOR_ST').AsString;
    lModel.RESERVADO            := lQry.FieldByName('RESERVADO').AsString;
    lModel.TIPO_GARANTIA        := lQry.FieldByName('TIPO_GARANTIA').AsString;
    lModel.VLR_GARANTIA         := lQry.FieldByName('VLR_GARANTIA').AsString;
    lModel.TIPO_ENTREGA         := lQry.FieldByName('TIPO_ENTREGA').AsString;
    lModel.MONTAGEM             := lQry.FieldByName('MONTAGEM').AsString;
    lModel.ENTREGA              := lQry.FieldByName('ENTREGA').AsString;
    lModel.TIPO                 := lQry.FieldByName('TIPO').AsString;
    lModel.QUANTIDADE_PENDENTE  := lQry.FieldByName('QUANTIDADE_PENDENTE').AsString;
    lModel.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
    lModel.VALOR_VENDIDO        := lQry.FieldByName('VALOR_VENDIDO').AsString;
    lModel.QUANTIDADE_SEPARACAO := lQry.FieldByName('QUANTIDADE_SEPARACAO').AsString;
    lModel.ALIQ_IPI             := lQry.FieldByName('ALIQ_IPI').AsString;
    lModel.VALOR_IPI            := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.CFOP_ID              := lQry.FieldByName('CFOP_ID').AsString;
    lModel.CST                  := lQry.FieldByName('CST').AsString;
    lModel.VALOR_RESTITUICAO_ST := lQry.FieldByName('VALOR_RESTITUICAO_ST').AsString;
    lModel.ALIQ_ICMS            := lQry.FieldByName('ALIQ_ICMS').AsString;
    lModel.ALIQ_ICMS_ST         := lQry.FieldByName('ALIQ_ICMS_ST').AsString;
    lModel.REDUCAO_ST           := lQry.FieldByName('REDUCAO_ST').AsString;
    lModel.MVA                  := lQry.FieldByName('MVA').AsString;
    lModel.REDUCAO_ICMS         := lQry.FieldByName('REDUCAO_ICMS').AsString;
    lModel.BASE_ICMS            := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.VALOR_ICMS           := lQry.FieldByName('VALOR_ICMS').AsString;
    lModel.BASE_ST              := lQry.FieldByName('BASE_ST').AsString;
    lModel.DESC_RESTITUICAO_ST  := lQry.FieldByName('DESC_RESTITUICAO_ST').AsString;
    lModel.ICMS_SUFRAMA         := lQry.FieldByName('ICMS_SUFRAMA').AsString;
    lModel.PIS_SUFRAMA          := lQry.FieldByName('PIS_SUFRAMA').AsString;
    lModel.COFINS_SUFRAMA       := lQry.FieldByName('COFINS_SUFRAMA').AsString;
    lModel.IPI_SUFRAMA          := lQry.FieldByName('IPI_SUFRAMA').AsString;
    lModel.ALIQ_PIS             := lQry.FieldByName('ALIQ_PIS').AsString;
    lModel.ALIQ_COFINS          := lQry.FieldByName('ALIQ_COFINS').AsString;
    lModel.BASE_PIS             := lQry.FieldByName('BASE_PIS').AsString;
    lModel.BASE_COFINS          := lQry.FieldByName('BASE_COFINS').AsString;
    lModel.VALOR_PIS            := lQry.FieldByName('VALOR_PIS').AsString;
    lModel.VALOR_COFINS         := lQry.FieldByName('VALOR_COFINS').AsString;
    lModel.VBCFCPST             := lQry.FieldByName('VBCFCPST').AsString;
    lModel.PFCPST               := lQry.FieldByName('PFCPST').AsString;
    lModel.VFCPST               := lQry.FieldByName('VFCPST').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TWebPedidoItensDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TWebPedidoItensDao.Destroy;
begin

  inherited;
end;

function TWebPedidoItensDao.excluir(pWebPedidoItensModel: TWebPedidoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from WEB_PEDIDOITENS where ID = :ID',[pWebPedidoItensModel.ID]);
   lQry.ExecSQL;
   Result := pWebPedidoItensModel.ID;

  finally
    lQry.Free;
  end;
end;

function TWebPedidoItensDao.incluir(pWebPedidoItensModel: TWebPedidoItensModel): String;
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
            '      VALOR_ACRESCIMO,                                                                                      '+SLineBreak+
            '      VALOR_FRETE,                                                                                          '+SLineBreak+
            '      VALOR_DESCONTO,                                                                                       '+SLineBreak+
            '      VALOR_ITENS,                                                                                          '+SLineBreak+
            '      TOTAL_GARANTIA                                                                                        '+SLineBreak+
            '    from                                                                                                    '+SLineBreak+
            '    (                                                                                                       '+SLineBreak+
            '     select                                                                                                 '+SLineBreak+
            '       web_pedido_id,                                                                                       '+SLineBreak+
            '       sum(valor_acrescimo) valor_acrescimo,                                                                '+SLineBreak+
            '       sum(valor_frete) valor_frete,                                                                        '+SLineBreak+
            '       sum(quantidade * valor_desconto) valor_desconto,                                                     '+SLineBreak+
            '       sum(quantidade * (valor_unitario + valor_garantia)) valor_itens,                                     '+SLineBreak+
            '       sum(quantidade * valor_garantia) total_garantia                                                      '+SLineBreak+
            '      from                                                                                                  '+SLineBreak+
            '      (                                                                                                     '+SLineBreak+
            '        select i.web_pedido_id,                                                                             '+SLineBreak+
            '               coalesce(p.acrescimo, 0) valor_acrescimo,                                                    '+SLineBreak+
            '               coalesce(p.valor_frete, 0) valor_frete,                                                      '+SLineBreak+
            '               coalesce(i.valor_unitario, 0) * coalesce(i.percentual_desconto,0) / 100 valor_desconto,      '+SLineBreak+
            '               coalesce(i.quantidade,0) quantidade,                                                         '+SLineBreak+
            '               coalesce(i.valor_unitario,0) valor_unitario,                                                 '+SLineBreak+
            '               coalesce(i.vlr_garantia,0)+coalesce(i.vlr_garantia_fr,0) valor_garantia                      '+SLineBreak+
            '         from web_pedidoitens i                                                                             '+SLineBreak+
            '        inner join web_pedido p on i.web_pedido_id = p.id ) t1                                              '+SLineBreak+
            '        group by 1 ) t2                                                                                     '+SLineBreak+
            '   where web_pedido_id = ' +pID;

    lQry.Open(lSQL);

    Result.VALOR_ACRESCIMO  := lQry.FieldByName('VALOR_ACRESCIMO').AsFloat;
    Result.VALOR_FRETE      := lQry.FieldByName('VALOR_FRETE').AsFloat;
    Result.VALOR_DESCONTO   := lQry.FieldByName('VALOR_DESCONTO').AsFloat;
    Result.VALOR_ITENS      := lQry.FieldByName('VALOR_ITENS').AsFloat;
    Result.TOTAL_GARANTIA   := lQry.FieldByName('TOTAL_GARANTIA').AsFloat;

    Result.VALOR_TOTAL  := lQry.FieldByName('VALOR_ITENS').AsFloat +
                           lQry.FieldByName('VALOR_FRETE').AsFloat +
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
  i          : INteger;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  FWebPedidoItenssLista := TObjectList<TWebPedidoItensModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSQL :=   '  select '+lPaginacao+'                                                                                                            '+SLineBreak+
              '      ID,                                                                                                                          '+SLineBreak+
              '      WEB_PEDIDO_ID,                                                                                                               '+SLineBreak+
              '      QUANTIDADE,                                                                                                                  '+SLineBreak+
              '      TIPO_ENTREGA,                                                                                                                '+SLineBreak+
              '      TIPO_GARANTIA,                                                                                                               '+SLineBreak+
              '      TIPO,                                                                                                                        '+SLineBreak+
              '      OBSERVACAO,                                                                                                                  '+SLineBreak+
              '      PRODUTO_ID,                                                                                                                  '+SLineBreak+
              '      VLR_GARANTIA,                                                                                                                '+SLineBreak+
              '      TIPO_GARANTIA_FR,                                                                                                            '+SLineBreak+
              '      VLR_GARANTIA_FR,                                                                                                             '+SLineBreak+
              '      ENTREGA,                                                                                                                     '+SLineBreak+
              '      MONTAGEM,                                                                                                                    '+SLineBreak+
              '      PERCENTUAL_DESCONTO,                                                                                                         '+SLineBreak+
              '      VALOR_UNITARIO,                                                                                                              '+SLineBreak+
              '      NOME_PRO,                                                                                                                    '+SLineBreak+
              '      VALOR_TOTALITENS,                                                                                                            '+SLineBreak+
              '      TOTAL_GARANTIA,                                                                                                              '+SLineBreak+
              '      VALOR_DESCONTO                                                                                                               '+SLineBreak+
              '      From                                                                                                                         '+SLineBreak+
              '         ( select                                                                                                                  '+SLineBreak+
              '              web_pedidoitens.id,                                                                                                  '+SLineBreak+
              '              web_pedidoitens.web_pedido_id,                                                                                       '+SLineBreak+
              '              web_pedidoitens.quantidade,                                                                                          '+SLineBreak+
              '              web_pedidoitens.tipo_entrega,                                                                                        '+SLineBreak+
              '              web_pedidoitens.tipo_garantia,                                                                                       '+SLineBreak+
              '              web_pedidoitens.tipo,                                                                                                '+SLineBreak+
              '              web_pedidoitens.observacao,                                                                                          '+SLineBreak+
              '              web_pedidoitens.produto_id,                                                                                          '+SLineBreak+
              '              web_pedidoitens.vlr_garantia,                                                                                        '+SLineBreak+
              '              web_pedidoitens.tipo_garantia_FR,                                                                                    '+SLineBreak+
              '              web_pedidoitens.vlr_garantia_FR,                                                                                     '+SLineBreak+
              '              web_pedidoitens.entrega,                                                                                             '+SLineBreak+
              '              web_pedidoitens.montagem,                                                                                            '+SLineBreak+
              '              web_pedidoitens.percentual_desconto,                                                                                 '+SLineBreak+
              '              web_pedidoitens.valor_unitario,                                                                                      '+SLineBreak+
              '              produto.nome_pro,                                                                                                    '+SLineBreak+
              '              coalesce(web_pedidoitens.quantidade, 0) * coalesce(web_pedidoitens.valor_unitario,0) valor_totalitens,               '+SLineBreak+
              '              coalesce(web_pedidoitens.quantidade,0) * coalesce(web_pedidoitens.vlr_garantia,0) total_garantia,                    '+SLineBreak+
              '              coalesce(web_pedidoitens.valor_unitario, 0) * coalesce(web_pedidoitens.percentual_desconto,0) / 100 valor_desconto   '+SLineBreak+
              '                                                                                                                                   '+SLineBreak+
              '          from web_pedidoitens                                                                                                     '+SLineBreak+
              '          inner join produto on produto.codigo_pro = web_pedidoitens.produto_id                                                    '+SLineBreak+
              '                                                                                                                                   '+SLineBreak+
              '          ) where 1=1 ';

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FWebPedidoItenssLista.Add(TWebPedidoItensModel.Create(vIConexao));

      i := FWebPedidoItenssLista.Count -1;

      FWebPedidoItenssLista[i].ID                   := lQry.FieldByName('ID').AsString;
      FWebPedidoItenssLista[i].QUANTIDADE           := lQry.FieldByName('QUANTIDADE').AsFloat;
      FWebPedidoItenssLista[i].TIPO_ENTREGA         := lQry.FieldByName('TIPO_ENTREGA').AsString;
      FWebPedidoItenssLista[i].TIPO_GARANTIA        := lQry.FieldByName('TIPO_GARANTIA').AsString;
      FWebPedidoItenssLista[i].TIPO                 := lQry.FieldByName('TIPO').AsString;
      FWebPedidoItenssLista[i].OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      FWebPedidoItenssLista[i].PRODUTO_ID           := lQry.FieldByName('PRODUTO_ID').AsString;
      FWebPedidoItenssLista[i].VLR_GARANTIA         := lQry.FieldByName('VLR_GARANTIA').AsFloat;
      FWebPedidoItenssLista[i].ENTREGA              := lQry.FieldByName('ENTREGA').AsString;
      FWebPedidoItenssLista[i].MONTAGEM             := lQry.FieldByName('MONTAGEM').AsString;
      FWebPedidoItenssLista[i].PERCENTUAL_DESCONTO  := lQry.FieldByName('PERCENTUAL_DESCONTO').AsFloat;
      FWebPedidoItenssLista[i].VALOR_UNITARIO       := lQry.FieldByName('VALOR_UNITARIO').AsFloat;
      FWebPedidoItenssLista[i].PRODUTO_NOME         := lQry.FieldByName('NOME_PRO').AsString;
      FWebPedidoItenssLista[i].TOTAL_GARANTIA       := lQry.FieldByName('TOTAL_GARANTIA').AsString;
      FWebPedidoItenssLista[i].VALOR_TOTALITENS     := lQry.FieldByName('VALOR_TOTALITENS').AsString;
      FWebPedidoItenssLista[i].VALOR_DESCONTO       := lQry.FieldByName('VALOR_DESCONTO').AsString;
      FWebPedidoItenssLista[i].TIPO_GARANTIA_FR     := lQry.FieldByName('TIPO_GARANTIA_FR').AsString;
      FWebPedidoItenssLista[i].VLR_GARANTIA_FR      := lQry.FieldByName('VLR_GARANTIA_FR').AsFloat;

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

procedure TWebPedidoItensDao.SetWebPedidoItenssLista(const Value: TObjectList<TWebPedidoItensModel>);
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

procedure TWebPedidoItensDao.setParams(var pQry: TFDQuery; pWebPedidoItensModel: TWebPedidoItensModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('WEB_PEDIDOITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TWebPedidoItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pWebPedidoItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pWebPedidoItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TWebPedidoItensDao.SetPedidoWebItenssLista(
  const Value: TObjectList<TWebPedidoItensModel>);
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
