unit PedidoWebItensDao;

interface

uses
  PedidoWebItensModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TPedidoWebItensDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

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

    procedure setParams(var pQry: TFDQuery; pPedidoWebItensModel: TPedidoWebItensModel);

    function where: String;
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

    function incluir(pPedidoWebItensModel: TPedidoWebItensModel): String;
    function alterar(pPedidoWebItensModel: TPedidoWebItensModel): String;
    function excluir(pPedidoWebItensModel: TPedidoWebItensModel): String;

    procedure obterListaVendaAssistidaItens;
    procedure obterLista;

end;

implementation

{ TPedidoWebItens }

function TPedidoWebItensDao.alterar(pPedidoWebItensModel: TPedidoWebItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('WEB_PEDIDOITENS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := ifThen(pPedidoWebItensModel.ID = '', Unassigned, pPedidoWebItensModel.ID);
    setParams(lQry, pPedidoWebItensModel);
    lQry.ExecSQL;

    Result := pPedidoWebItensModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

constructor TPedidoWebItensDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPedidoWebItensDao.Destroy;
begin

  inherited;
end;

function TPedidoWebItensDao.excluir(pPedidoWebItensModel: TPedidoWebItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from WEB_PEDIDOITENS where ID = :ID',[pPedidoWebItensModel.ID]);
   lQry.ExecSQL;
   Result := pPedidoWebItensModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPedidoWebItensDao.incluir(pPedidoWebItensModel: TPedidoWebItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('WEB_PEDIDOITENS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoWebItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoWebItensDao.where: String;
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

    lSql := lSql + where;

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

    lSQL := lSQL + where;

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

    lSQL := lSQL + where;

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

procedure TPedidoWebItensDao.setParams(var pQry: TFDQuery; pPedidoWebItensModel: TPedidoWebItensModel);
begin
  pQry.ParamByName('WEB_PEDIDO_ID').Value           := ifThen(pPedidoWebItensModel.WEB_PEDIDO_ID              = '', Unassigned, pPedidoWebItensModel.WEB_PEDIDO_ID);
  pQry.ParamByName('PRODUTO_ID').Value              := ifThen(pPedidoWebItensModel.PRODUTO_ID                 = '', Unassigned, pPedidoWebItensModel.PRODUTO_ID);
  pQry.ParamByName('QUANTIDADE').Value              := ifThen(pPedidoWebItensModel.QUANTIDADE                 = '', Unassigned, pPedidoWebItensModel.QUANTIDADE);
  pQry.ParamByName('QUANTIDADE_TROCA').Value        := ifThen(pPedidoWebItensModel.QUANTIDADE_TROCA           = '', Unassigned, pPedidoWebItensModel.QUANTIDADE_TROCA);
  pQry.ParamByName('VALOR_UNITARIO').Value          := ifThen(pPedidoWebItensModel.VALOR_UNITARIO             = '', Unassigned, pPedidoWebItensModel.VALOR_UNITARIO);
  pQry.ParamByName('PERCENTUAL_DESCONTO').Value     := ifThen(pPedidoWebItensModel.PERCENTUAL_DESCONTO        = '', Unassigned, pPedidoWebItensModel.PERCENTUAL_DESCONTO);
  pQry.ParamByName('VALOR_VENDA_ATUAL').Value       := ifThen(pPedidoWebItensModel.VALOR_VENDA_ATUAL          = '', Unassigned, pPedidoWebItensModel.VALOR_VENDA_ATUAL);
  pQry.ParamByName('VALOR_CUSTO_ATUAL').Value       := ifThen(pPedidoWebItensModel.VALOR_CUSTO_ATUAL          = '', Unassigned, pPedidoWebItensModel.VALOR_CUSTO_ATUAL);
  pQry.ParamByName('PERCENTUAL_COMISSAO').Value     := ifThen(pPedidoWebItensModel.PERCENTUAL_COMISSAO        = '', Unassigned, pPedidoWebItensModel.PERCENTUAL_COMISSAO);
  pQry.ParamByName('OBSERVACAO').Value              := ifThen(pPedidoWebItensModel.OBSERVACAO                 = '', Unassigned, pPedidoWebItensModel.OBSERVACAO);
  pQry.ParamByName('QUANTIDADE_OLD').Value          := ifThen(pPedidoWebItensModel.QUANTIDADE_OLD             = '', Unassigned, pPedidoWebItensModel.QUANTIDADE_OLD);
  pQry.ParamByName('QUANTIDADE_TROCA_OLD').Value    := ifThen(pPedidoWebItensModel.QUANTIDADE_TROCA_OLD       = '', Unassigned, pPedidoWebItensModel.QUANTIDADE_TROCA_OLD);
  pQry.ParamByName('AVULSO').Value                  := ifThen(pPedidoWebItensModel.AVULSO                     = '', Unassigned, pPedidoWebItensModel.AVULSO);
  pQry.ParamByName('VALOR_ST').Value                := ifThen(pPedidoWebItensModel.VALOR_ST                   = '', Unassigned, pPedidoWebItensModel.VALOR_ST);
  pQry.ParamByName('RESERVADO').Value               := ifThen(pPedidoWebItensModel.RESERVADO                  = '', Unassigned, pPedidoWebItensModel.RESERVADO);
  pQry.ParamByName('TIPO_GARANTIA').Value           := ifThen(pPedidoWebItensModel.TIPO_GARANTIA              = '', Unassigned, pPedidoWebItensModel.TIPO_GARANTIA);
  pQry.ParamByName('VLR_GARANTIA').Value            := ifThen(pPedidoWebItensModel.VLR_GARANTIA               = '', Unassigned, pPedidoWebItensModel.VLR_GARANTIA);
  pQry.ParamByName('TIPO_ENTREGA').Value            := ifThen(pPedidoWebItensModel.TIPO_ENTREGA               = '', Unassigned, pPedidoWebItensModel.TIPO_ENTREGA);
  pQry.ParamByName('MONTAGEM').Value                := ifThen(pPedidoWebItensModel.MONTAGEM                   = '', Unassigned, pPedidoWebItensModel.MONTAGEM);
  pQry.ParamByName('ENTREGA').Value                 := ifThen(pPedidoWebItensModel.ENTREGA                    = '', Unassigned, pPedidoWebItensModel.ENTREGA);
  pQry.ParamByName('TIPO').Value                    := ifThen(pPedidoWebItensModel.TIPO                       = '', Unassigned, pPedidoWebItensModel.TIPO);
  pQry.ParamByName('QUANTIDADE_PENDENTE').Value     := ifThen(pPedidoWebItensModel.QUANTIDADE_PENDENTE        = '', Unassigned, pPedidoWebItensModel.QUANTIDADE_PENDENTE);
  pQry.ParamByName('VALOR_VENDIDO').Value           := ifThen(pPedidoWebItensModel.VALOR_VENDIDO              = '', Unassigned, pPedidoWebItensModel.VALOR_VENDIDO);
  pQry.ParamByName('QUANTIDADE_SEPARACAO').Value    := ifThen(pPedidoWebItensModel.QUANTIDADE_SEPARACAO       = '', Unassigned, pPedidoWebItensModel.QUANTIDADE_SEPARACAO);
  pQry.ParamByName('ALIQ_IPI').Value                := ifThen(pPedidoWebItensModel.ALIQ_IPI                   = '', Unassigned, pPedidoWebItensModel.ALIQ_IPI);
  pQry.ParamByName('VALOR_IPI').Value               := ifThen(pPedidoWebItensModel.VALOR_IPI                  = '', Unassigned, pPedidoWebItensModel.VALOR_IPI);
  pQry.ParamByName('CFOP_ID').Value                 := ifThen(pPedidoWebItensModel.CFOP_ID                    = '', Unassigned, pPedidoWebItensModel.CFOP_ID);
  pQry.ParamByName('CST').Value                     := ifThen(pPedidoWebItensModel.CST                        = '', Unassigned, pPedidoWebItensModel.CST);
  pQry.ParamByName('VALOR_RESTITUICAO_ST').Value    := ifThen(pPedidoWebItensModel.VALOR_RESTITUICAO_ST       = '', Unassigned, pPedidoWebItensModel.VALOR_RESTITUICAO_ST);
  pQry.ParamByName('ALIQ_ICMS').Value               := ifThen(pPedidoWebItensModel.ALIQ_ICMS                  = '', Unassigned, pPedidoWebItensModel.ALIQ_ICMS);
  pQry.ParamByName('ALIQ_ICMS_ST').Value            := ifThen(pPedidoWebItensModel.ALIQ_ICMS_ST               = '', Unassigned, pPedidoWebItensModel.ALIQ_ICMS_ST);
  pQry.ParamByName('REDUCAO_ST').Value              := ifThen(pPedidoWebItensModel.REDUCAO_ST                 = '', Unassigned, pPedidoWebItensModel.REDUCAO_ST);
  pQry.ParamByName('MVA').Value                     := ifThen(pPedidoWebItensModel.MVA                        = '', Unassigned, pPedidoWebItensModel.MVA);
  pQry.ParamByName('REDUCAO_ICMS').Value            := ifThen(pPedidoWebItensModel.REDUCAO_ICMS               = '', Unassigned, pPedidoWebItensModel.REDUCAO_ICMS);
  pQry.ParamByName('BASE_ICMS').Value               := ifThen(pPedidoWebItensModel.BASE_ICMS                  = '', Unassigned, pPedidoWebItensModel.BASE_ICMS);
  pQry.ParamByName('VALOR_ICMS').Value              := ifThen(pPedidoWebItensModel.VALOR_ICMS                 = '', Unassigned, pPedidoWebItensModel.VALOR_ICMS);
  pQry.ParamByName('BASE_ST').Value                 := ifThen(pPedidoWebItensModel.BASE_ST                    = '', Unassigned, pPedidoWebItensModel.BASE_ST);
  pQry.ParamByName('DESC_RESTITUICAO_ST').Value     := ifThen(pPedidoWebItensModel.DESC_RESTITUICAO_ST        = '', Unassigned, pPedidoWebItensModel.DESC_RESTITUICAO_ST);
  pQry.ParamByName('ICMS_SUFRAMA').Value            := ifThen(pPedidoWebItensModel.ICMS_SUFRAMA               = '', Unassigned, pPedidoWebItensModel.ICMS_SUFRAMA);
  pQry.ParamByName('PIS_SUFRAMA').Value             := ifThen(pPedidoWebItensModel.PIS_SUFRAMA                = '', Unassigned, pPedidoWebItensModel.PIS_SUFRAMA);
  pQry.ParamByName('COFINS_SUFRAMA').Value          := ifThen(pPedidoWebItensModel.COFINS_SUFRAMA             = '', Unassigned, pPedidoWebItensModel.COFINS_SUFRAMA);
  pQry.ParamByName('IPI_SUFRAMA').Value             := ifThen(pPedidoWebItensModel.IPI_SUFRAMA                = '', Unassigned, pPedidoWebItensModel.IPI_SUFRAMA);
  pQry.ParamByName('ALIQ_PIS').Value                := ifThen(pPedidoWebItensModel.ALIQ_PIS                   = '', Unassigned, pPedidoWebItensModel.ALIQ_PIS);
  pQry.ParamByName('ALIQ_COFINS').Value             := ifThen(pPedidoWebItensModel.ALIQ_COFINS                = '', Unassigned, pPedidoWebItensModel.ALIQ_COFINS);
  pQry.ParamByName('BASE_PIS').Value                := ifThen(pPedidoWebItensModel.BASE_PIS                   = '', Unassigned, pPedidoWebItensModel.BASE_PIS);
  pQry.ParamByName('BASE_COFINS').Value             := ifThen(pPedidoWebItensModel.BASE_COFINS                = '', Unassigned, pPedidoWebItensModel.BASE_COFINS);
  pQry.ParamByName('VALOR_PIS').Value               := ifThen(pPedidoWebItensModel.VALOR_PIS                  = '', Unassigned, pPedidoWebItensModel.VALOR_PIS);
  pQry.ParamByName('VALOR_COFINS').Value            := ifThen(pPedidoWebItensModel.VALOR_COFINS               = '', Unassigned, pPedidoWebItensModel.VALOR_COFINS);
  pQry.ParamByName('VBCFCPST').Value                := ifThen(pPedidoWebItensModel.VBCFCPST                   = '', Unassigned, pPedidoWebItensModel.VBCFCPST);
  pQry.ParamByName('PFCPST').Value                  := ifThen(pPedidoWebItensModel.PFCPST                     = '', Unassigned, pPedidoWebItensModel.PFCPST);
  pQry.ParamByName('VFCPST').Value                  := ifThen(pPedidoWebItensModel.VFCPST                     = '', Unassigned, pPedidoWebItensModel.VFCPST);
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
