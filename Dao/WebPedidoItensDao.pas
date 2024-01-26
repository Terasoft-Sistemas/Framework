unit WebPedidoItensDao;

interface

uses
  WebPedidoItensModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Utils,
  Interfaces.Conexao;

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

    procedure obterListaVendaAssistidaItens;
    procedure obterLista;

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
    lSQL := lSQL + ' and web_pedidoitens.id = '+IntToStr(FIDRecordView);

  if FIDWebPedidoView <> 0 then
    lSQL := lSQL + ' and web_pedidoitens.web_pedido_id = '+IntToStr(FIDWebPedidoView);

  Result := lSQL;
end;

function TWebPedidoItensDao.obterTotais(pId: String): TTotais;
var
  lQry  : TFDQuery;
  lSQL  : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := ' select coalesce(p.acrescimo,0) acrescimo,                                                                                                                                                  '+SLineBreak+
            '        coalesce(p.valor_frete,0) frete,                                                                                                                                                    '+SLineBreak+
            '        sum(coalesce(i.valor_unitario,0) * coalesce(i.percentual_desconto,0) / 100) desconto,                                                                                               '+SLineBreak+
            '        sum(coalesce(i.quantidade,0) * (coalesce(i.valor_unitario,0) + coalesce(i.vlr_garantia,0) - (coalesce(i.valor_unitario,0) * coalesce(i.percentual_desconto,0) / 100) )) valor_itens '+SLineBreak+
            '   from web_pedidoitens i inner join web_pedido p on i.web_pedido_id = p.id                                                                                                                 '+SLineBreak+
            '  where i.web_pedido_id = ' + pId +
            '  group by 1,2 ';

    lQry.Open(lSQL);

    Result.ACRESCIMO    := lQry.FieldByName('ACRESCIMO').AsFloat;
    Result.FRETE        := lQry.FieldByName('FRETE').AsFloat;
    Result.DESCONTO     := lQry.FieldByName('DESCONTO').AsFloat;
    Result.VALOR_ITENS  := lQry.FieldByName('VALOR_ITENS').AsFloat;
    Result.VALOR_TOTAL  := lQry.FieldByName('VALOR_ITENS').AsFloat + lQry.FieldByName('FRETE').AsFloat + lQry.FieldByName('ACRESCIMO').AsFloat - lQry.FieldByName('DESCONTO').AsFloat;
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
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FWebPedidoItenssLista := TObjectList<TWebPedidoItensModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSQL := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSQL := 'select ';

    lSQL := lSQL +
      '       web_pedidoitens.id,                                             '+SLineBreak+
      '       web_pedidoitens.quantidade,                                     '+SLineBreak+
      '       web_pedidoitens.tipo_entrega,                                   '+SLineBreak+
      '       web_pedidoitens.observacao,                                     '+SLineBreak+
      '       web_pedidoitens.produto_id,                                     '+SLineBreak+
      '       web_pedidoitens.vlr_garantia,                                   '+SLineBreak+
      '       web_pedidoitens.entrega,                                        '+SLineBreak+
      '       web_pedidoitens.montagem,                                       '+SLineBreak+
      '       web_pedidoitens.percentual_desconto,                            '+SLineBreak+
      '       web_pedidoitens.valor_unitario,                                 '+SLineBreak+
      '       produto.valor_bonus_servico,                                    '+SLineBreak+
      '       produto.usar_balanca,                                           '+SLineBreak+
      '       produto.venda_pro,                                              '+SLineBreak+
      '       produto.customedio_pro,                                         '+SLineBreak+
      '       produto.valor_montador                                          '+SLineBreak+
      '  from web_pedidoitens                                                 '+SLineBreak+
      ' inner join produto on web_pedidoitens.produto_id = produto.codigo_pro '+SLineBreak+
      ' where 1=1 ';

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
      FWebPedidoItenssLista[i].QUANTIDADE           := lQry.FieldByName('QUANTIDADE').AsString;
      FWebPedidoItenssLista[i].TIPO_ENTREGA         := lQry.FieldByName('TIPO_ENTREGA').AsString;
      FWebPedidoItenssLista[i].OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      FWebPedidoItenssLista[i].PRODUTO_ID           := lQry.FieldByName('PRODUTO_ID').AsString;
      FWebPedidoItenssLista[i].VLR_GARANTIA         := lQry.FieldByName('VLR_GARANTIA').AsString;
      FWebPedidoItenssLista[i].ENTREGA              := lQry.FieldByName('ENTREGA').AsString;
      FWebPedidoItenssLista[i].MONTAGEM             := lQry.FieldByName('MONTAGEM').AsString;
      FWebPedidoItenssLista[i].PERCENTUAL_DESCONTO  := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
      FWebPedidoItenssLista[i].VALOR_UNITARIO       := lQry.FieldByName('VALOR_UNITARIO').AsString;
      FWebPedidoItenssLista[i].VALOR_BONUS_SERVICO  := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
      FWebPedidoItenssLista[i].USAR_BALANCA         := lQry.FieldByName('USAR_BALANCA').AsString;
      FWebPedidoItenssLista[i].VENDA_PRO            := lQry.FieldByName('VENDA_PRO').AsString;
      FWebPedidoItenssLista[i].CUSTOMEDIO_PRO       := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
      FWebPedidoItenssLista[i].VALOR_MONTADOR       := lQry.FieldByName('VALOR_MONTADOR').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TWebPedidoItensDao.obterListaVendaAssistidaItens;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FWebPedidoItenssLista := TObjectList<TWebPedidoItensModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSQL := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSQL := 'select ';

    lSQL := lSQL +
      '        produto.codigo_pro,                                                   '+SLineBreak+
      '        web_pedidoitens.quantidade,                                           '+SLineBreak+
      '        web_pedidoitens.valor_unitario,                                       '+SLineBreak+
      '        web_pedidoitens.quantidade * web_pedidoitens.valor_unitario total,    '+SLineBreak+
      '        produto.nome_pro                                                      '+SLineBreak+
      '  from  web_pedidoitens                                                       '+SLineBreak+
      '  inner join produto on web_pedidoitens.produto_id = produto.codigo_pro       '+SLineBreak+
      ' where 1=1 ';

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

      FWebPedidoItenssLista[i].PRODUTO_NOME     := lQry.FieldByName('NOME_PRO').AsString;
      FWebPedidoItenssLista[i].PRODUTO_CODIGO   := lQry.FieldByName('CODIGO_PRO').AsString;
      FWebPedidoItenssLista[i].QUANTIDADE       := lQry.FieldByName('QUANTIDADE').AsString;
      FWebPedidoItenssLista[i].VALOR_UNITARIO   := lQry.FieldByName('VALOR_UNITARIO').AsString;
      FWebPedidoItenssLista[i].TOTAL            := lQry.FieldByName('TOTAL').AsString;

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
