unit PedidoWebItensDao;

interface

uses
  PedidoWebItensModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TPedidoWebItensDao = class

  private
    vIConexao : IConexao;
    FPedidoWebItenssLista: TObjectList<TPedidoWebItensModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDPedidoWebView: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPedidoWebItenssLista(const Value: TObjectList<TPedidoWebItensModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;
    procedure SetIDPedidoWebView(const Value: Integer);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property PedidoWebItenssLista: TObjectList<TPedidoWebItensModel> read FPedidoWebItenssLista write SetPedidoWebItenssLista;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDPedidoWebView: Integer read FIDPedidoWebView write SetIDPedidoWebView;

    procedure obterListaVendaAssistidaItens;
    procedure obterLista;

end;

implementation

{ TPedidoWebItens }

constructor TPedidoWebItensDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPedidoWebItensDao.Destroy;
begin

  inherited;
end;

function TPedidoWebItensDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0 then
    lSQL := lSQL + ' and web_pedidoitens.id = '+IntToStr(FIDRecordView);

  if FIDPedidoWebView <> 0 then
    lSQL := lSQL + ' and web_pedidoitens.web_pedido_id = '+IntToStr(FIDPedidoWebView);

  Result := lSQL;
end;

procedure TPedidoWebItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From web_pedidoitens where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPedidoWebItensDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPedidoWebItenssLista := TObjectList<TPedidoWebItensModel>.Create;

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

    lSQL := lSQL + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPedidoWebItenssLista.Add(TPedidoWebItensModel.Create(vIConexao));

      i := FPedidoWebItenssLista.Count -1;

      FPedidoWebItenssLista[i].ID                   := lQry.FieldByName('ID').AsString;
      FPedidoWebItenssLista[i].QUANTIDADE           := lQry.FieldByName('QUANTIDADE').AsString;
      FPedidoWebItenssLista[i].TIPO_ENTREGA         := lQry.FieldByName('TIPO_ENTREGA').AsString;
      FPedidoWebItenssLista[i].OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      FPedidoWebItenssLista[i].PRODUTO_ID           := lQry.FieldByName('PRODUTO_ID').AsString;
      FPedidoWebItenssLista[i].VLR_GARANTIA         := lQry.FieldByName('VLR_GARANTIA').AsString;
      FPedidoWebItenssLista[i].ENTREGA              := lQry.FieldByName('ENTREGA').AsString;
      FPedidoWebItenssLista[i].MONTAGEM             := lQry.FieldByName('MONTAGEM').AsString;
      FPedidoWebItenssLista[i].PERCENTUAL_DESCONTO  := lQry.FieldByName('PERCENTUAL_DESCONTO').AsString;
      FPedidoWebItenssLista[i].VALOR_UNITARIO       := lQry.FieldByName('VALOR_UNITARIO').AsString;
      FPedidoWebItenssLista[i].VALOR_BONUS_SERVICO  := lQry.FieldByName('VALOR_BONUS_SERVICO').AsString;
      FPedidoWebItenssLista[i].USAR_BALANCA         := lQry.FieldByName('USAR_BALANCA').AsString;
      FPedidoWebItenssLista[i].VENDA_PRO            := lQry.FieldByName('VENDA_PRO').AsString;
      FPedidoWebItenssLista[i].CUSTOMEDIO_PRO       := lQry.FieldByName('CUSTOMEDIO_PRO').AsString;
      FPedidoWebItenssLista[i].VALOR_MONTADOR       := lQry.FieldByName('VALOR_MONTADOR').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPedidoWebItensDao.obterListaVendaAssistidaItens;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPedidoWebItenssLista := TObjectList<TPedidoWebItensModel>.Create;

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

    lSQL := lSQL + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPedidoWebItenssLista.Add(TPedidoWebItensModel.Create(vIConexao));

      i := FPedidoWebItenssLista.Count -1;

      FPedidoWebItenssLista[i].PRODUTO_NOME     := lQry.FieldByName('NOME_PRO').AsString;
      FPedidoWebItenssLista[i].PRODUTO_CODIGO   := lQry.FieldByName('CODIGO_PRO').AsString;
      FPedidoWebItenssLista[i].QUANTIDADE       := lQry.FieldByName('QUANTIDADE').AsString;
      FPedidoWebItenssLista[i].VALOR_UNITARIO   := lQry.FieldByName('VALOR_UNITARIO').AsString;
      FPedidoWebItenssLista[i].TOTAL            := lQry.FieldByName('TOTAL').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPedidoWebItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoWebItensDao.SetPedidoWebItenssLista(const Value: TObjectList<TPedidoWebItensModel>);
begin
  FPedidoWebItenssLista := Value;
end;

procedure TPedidoWebItensDao.SetID(const Value: Variant);
begin

end;

procedure TPedidoWebItensDao.SetIDPedidoWebView(const Value: Integer);
begin
  FIDPedidoWebView := Value;
end;

procedure TPedidoWebItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPedidoWebItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoWebItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoWebItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPedidoWebItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPedidoWebItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
