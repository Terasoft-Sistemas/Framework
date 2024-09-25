unit FinanceiroPedidoDao;

interface

uses
  FinanceiroPedidoModel,
  Terasoft.Utils,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  System.Rtti, WebPedidoModel, Terasoft.Types;

type
  TFinanceiroPedidoDao = class;
  ITFinanceiroPedidoDao=IObject<TFinanceiroPedidoDao>;

  TFinanceiroPedidoDao = class
  private
    [unsafe] mySelf: ITFinanceiroPedidoDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;



  public

    constructor _Create(pIConexao: IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITFinanceiroPedidoDao;

    property TotalRecords      : Integer      read FTotalRecords        write SetTotalRecords;
    property IDRecordView      : Integer      read FIDRecordView        write SetIDRecordView;
    property WhereView         : String       read FWhereView           write SetWhereView;
    property CountView         : String       read FCountView           write SetCountView;
    property OrderView         : String       read FOrderView           write SetOrderView;
    property StartRecordView   : String       read FStartRecordView     write SetStartRecordView;
    property LengthPageView    : String       read FLengthPageView      write SetLengthPageView;

    function incluir(pFinanceiroPedidoModel: ITFinanceiroPedidoModel): String;
    function alterar(pFinanceiroPedidoModel: ITFinanceiroPedidoModel): String;
    function excluir(pFinanceiroPedidoModel: ITFinanceiroPedidoModel): String;
    function excluirPromocao(pID: String): String;

    procedure setParams(var pQry : TFDQuery; pFinanceiroPedidoModel: ITFinanceiroPedidoModel);
    function carregaClasse(pID: String): ITFinanceiroPedidoModel;
    function obterResumo(pIDPedido : String) : IFDDataset;
    function obterResumoFinanceiro: IFDDataset;
    function ObterLista: IFDDataset;
    function qtdePagamentoPrazo(pWebPedido : String): Integer;

    procedure UpdateDadosFinanceiro(pWebPedidoModel: ITWebPedidoModel);

    procedure UpdateArredondaParcela(pTotal, pValorParcela, pIndice, pValorAcrescimo : Extended; pID_Financeiro: String);


end;

implementation

uses
  System.Variants, Terasoft.FuncoesTexto;

{ TFinanceiroPedido }

procedure TFinanceiroPedidoDao.UpdateArredondaParcela(pTotal, pValorParcela, pIndice, pValorAcrescimo : Extended; pID_Financeiro: String);
var
  lQry: TFDQuery;
  lSQL: String;
begin
  lQry := vIConexao.CriarQuery;

  try
     lSQL :=
            ' update                                    '+#13+
            '     financeiro_pedido f                   '+#13+
            '                                           '+#13+
            ' set                                       '+#13+
            '     f.valor_total = :total,               '+#13+
            '     f.valor_parcela = :valor_parcela,     '+#13+
            '     f.indce_aplicado = :indice,           '+#13+
            '     f.valor_acrescimo = :valor_acrescimo  '+#13+
            '                                           '+#13+
            ' where                                     '+#13+
            '     f.id_financeiro = :id_financeiro      '+#13;

    lQry.SQL.Add(lSQL);
    lQry.ParamByName('total').Value           := FormataFloatFireBird(FloatToStr(pTotal));
    lQry.ParamByName('valor_parcela').Value   := FormataFloatFireBird(FloatToStr(pValorParcela));
    lQry.ParamByName('indice').Value          := FormataFloatFireBird(FloatToStr(pIndice));
    lQry.ParamByName('valor_acrescimo').Value := FormataFloatFireBird(FloatToStr(pValorAcrescimo));
    lQry.ParamByName('id_financeiro').Value   := pID_Financeiro;
    lQry.ExecSQL;

  finally
    lQry.Free;
  end;

end;

function TFinanceiroPedidoDao.carregaClasse(pID: String): ITFinanceiroPedidoModel;
var
  lQry: TFDQuery;
  lModel: ITFinanceiroPedidoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TFinanceiroPedidoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from FINANCEIRO_PEDIDO where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                     := lQry.FieldByName('ID').AsString;
    lModel.objeto.SYSTIME                := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.DATA_CADASTRO          := lQry.FieldByName('DATA_CADASTRO').AsString;
    lModel.objeto.WEB_PEDIDO_ID          := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    lModel.objeto.PEDIDO_VENDA_ID        := lQry.FieldByName('PEDIDO_VENDA_ID').AsString;
    lModel.objeto.WEB_PEDIDOITENS_ID     := lQry.FieldByName('WEB_PEDIDOITENS_ID').AsString;
    lModel.objeto.PORTADOR_ID            := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.VALOR_TOTAL            := lQry.FieldByName('VALOR_TOTAL').AsString;
    lModel.objeto.QUANTIDADE_PARCELAS    := lQry.FieldByName('QUANTIDADE_PARCELAS').AsString;
    lModel.objeto.PARCELA                := lQry.FieldByName('PARCELA').AsString;
    lModel.objeto.VALOR_PARCELA          := lQry.FieldByName('VALOR_PARCELA').AsString;
    lModel.objeto.VENCIMENTO             := lQry.FieldByName('VENCIMENTO').AsString;
    lModel.objeto.CONDICAO_PAGAMENTO     := lQry.FieldByName('CONDICAO_PAGAMENTO').AsString;
    lModel.objeto.OBSERVACAO             := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.objeto.INDCE_APLICADO         := lQry.FieldByName('INDCE_APLICADO').AsString;
    lModel.objeto.VALOR_ACRESCIMO        := lQry.FieldByName('VALOR_ACRESCIMO').AsString;
    lModel.objeto.VALOR_LIQUIDO          := lQry.FieldByName('VALOR_LIQUIDO').AsString;
    lModel.objeto.ID_FINANCEIRO          := lQry.FieldByName('ID_FINANCEIRO').AsString;
    lModel.objeto.VALOR_SEG_PRESTAMISTA  := lQry.FieldByName('VALOR_SEG_PRESTAMISTA').AsString;
    lModel.objeto.PER_SEG_PRESTAMSTA     := lQry.FieldByName('PER_SEG_PRESTAMSTA').AsString;
    lModel.objeto.VALOR_ACRESCIMO_SEG_PRESTAMISTA := lQry.FieldByName('VALOR_ACRESCIMO_SEG_PRESTAMISTA').AsString;
    lModel.objeto.ORIGINAL_VALOR_PARCELA  := lQry.FieldByName('ORIGINAL_VALOR_PARCELA').AsString;
    lModel.objeto.ORIGINAL_INDCE_APLICADO := lQry.FieldByName('ORIGINAL_INDCE_APLICADO').AsString;
    lModel.objeto.STATUS                  := lQry.FieldByName('STATUS').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TFinanceiroPedidoDao._Create(pIConexao: IConexao);
begin
  vIConexao       := pIConexao;
  vConstrutor  := TConstrutorDao.Create(vIConexao);
end;

destructor TFinanceiroPedidoDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TFinanceiroPedidoDao.incluir(pFinanceiroPedidoModel: ITFinanceiroPedidoModel): String;
var
  lQry  : TFDQuery;
  lSQL  : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := vConstrutor.gerarInsert('FINANCEIRO_PEDIDO', 'ID', true);

    pFinanceiroPedidoModel.objeto.ID := vIConexao.Generetor('GEN_FINANCEIRO_PEDIDO_ID');

    if pFinanceiroPedidoModel.objeto.ID_FINANCEIRO = '' then
      pFinanceiroPedidoModel.objeto.ID_FINANCEIRO := pFinanceiroPedidoModel.objeto.ID;

    lQry.SQL.Add(lSQL);
    setParams(lQry, pFinanceiroPedidoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lQry.Free;
  end;
end;

procedure TFinanceiroPedidoDao.UpdateDadosFinanceiro(pWebPedidoModel: ITWebPedidoModel);
var
  lQry: TFDQuery;
  lSQL: String;
  lValorEntrada: Extended;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL :=
    ' select                               '+#13+
    '   sum(f.VALOR_PARCELA) VALOR_ENTRADA '+#13+
    '                                      '+#13+
    ' from                                 '+#13+
    '   financeiro_pedido f                '+#13+
    '                                      '+#13+
    ' inner join portador p on p.codigo_port = f.portador_id '+#13+
    '                                                        '+#13+
    ' where                                                  '+#13+
    '   f.web_pedido_id = '+pWebPedidoModel.objeto.ID+' and p.tpag_nfe in (''01'', ''03'', ''04'', ''99'', ''17'',''20'') '+#13;

    lQry.Open(lSQL);

    lValorEntrada := lQry.FieldByName('VALOR_ENTRADA').AsFloat;

    lSQL :=
    ' select avg(f.VALOR_PARCELA) valor_financiado, count(*) QUANTIDADE_PARCELAS, min(f.vencimento) PRIMEIRO_VENCIMENTO '+#13+
    ' from financeiro_pedido f'+#13+
    ' inner join portador p on p.codigo_port = f.portador_id'+#13+
    ' where f.web_pedido_id = '+pWebPedidoModel.objeto.ID+''+#13+
    ' and p.tpag_nfe not in (''01'', ''03'', ''04'', ''17'',''20'', ''99'') ';

    lQry.Open(lSQL);

    pWebPedidoModel.objeto.Acao                := tacAlterar;
    pWebPedidoModel.objeto.VALOR_ENTRADA       := lValorEntrada;
    pWebPedidoModel.objeto.PRIMEIRO_VENCIMENTO := DateToStr(lQry.FieldByName('PRIMEIRO_VENCIMENTO').AsDateTime);
    pWebPedidoModel.objeto.PARCELAS            := IIF(lQry.FieldByName('QUANTIDADE_PARCELAS').AsInteger > 0, lQry.FieldByName('QUANTIDADE_PARCELAS').AsInteger, 1 );
    pWebPedidoModel.objeto.VALOR_FINANCIADO    := lQry.FieldByName('valor_financiado').AsString;
    pWebPedidoModel.objeto.Salvar;
  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.alterar(pFinanceiroPedidoModel: ITFinanceiroPedidoModel): String;
var
  lQry      : TFDQuery;
  lSQL      : String;
begin

  lQry      := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('FINANCEIRO_PEDIDO', 'ID');  //Trocar o ID pela coluna que será filtrada no Where do update

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pFinanceiroPedidoModel);
    lQry.ExecSQL;

    Result := pFinanceiroPedidoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.excluir(pFinanceiroPedidoModel: ITFinanceiroPedidoModel): String;
var
  lQry     : TFDQuery;
begin
  lQry     := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from FINANCEIRO_PEDIDO where ID_FINANCEIRO = :ID_FINANCEIRO',[pFinanceiroPedidoModel.objeto.ID_FINANCEIRO]);

   Result := pFinanceiroPedidoModel.objeto.ID_FINANCEIRO;
  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.excluirPromocao(pID: String): String;
var
  lQry     : TFDQuery;
begin
  lQry     := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from FINANCEIRO_PEDIDO where WEB_PEDIDOITENS_ID = :WEB_PEDIDOITENS_ID',[pID]);

   Result := pID;
  finally
    lQry.Free;
  end;
end;

class function TFinanceiroPedidoDao.getNewIface(pIConexao: IConexao): ITFinanceiroPedidoDao;
begin
  Result := TImplObjetoOwner<TFinanceiroPedidoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TFinanceiroPedidoDao.where: String;
var
  lSQL: String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and FINANCEIRO_PEDIDO.ID = '+IntToStr(FIDRecordView);

  Result := lSql;
end;

function TFinanceiroPedidoDao.obterResumo(pIDPedido: String): IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL :=
    ' select                                                 '+SLineBreak+
    '     f.web_pedido_id,                                   '+SLineBreak+
    '     p.codigo_port,                                     '+SLineBreak+
    '     p.nome_port,                                       '+SLineBreak+
    '     f.quantidade_parcelas,                             '+SLineBreak+
    '     f.valor_parcela,                                   '+SLineBreak+
    '     f.valor_total,                                     '+SLineBreak+
    '     f.vencimento,                                      '+SLineBreak+
    '     f.valor_liquido,                                   '+SLineBreak+
    '     f.id_financeiro,                                   '+SLineBreak+
    '     f.valor_acrescimo,                                 '+SLineBreak+
    '     f.valor_seg_prestamista,                           '+SLineBreak+
    '     f.web_pedidoitens_id                               '+SLineBreak+
    '                                                        '+SLineBreak+
    ' From financeiro_pedido f                               '+SLineBreak+
    '                                                        '+SLineBreak+
    ' left join portador p on p.codigo_port = f.portador_id  '+SLineBreak+
    ' left join web_pedido w on w.id = f.web_pedido_id       '+SLineBreak+
    '                                                        '+SLineBreak+
    ' where f.web_pedido_id = '+pIDPedido+'                  '+SLineBreak+
    '   and f.parcela = 1                                    '+SLineBreak+
    '   and coalesce(f.status,''A'') = ''A''                 '+SLineBreak;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.obterResumoFinanceiro: IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := ' select                                                 '+SLineBreak+
            '     f.web_pedido_id,                                   '+SLineBreak+
            '     p.codigo_port,                                     '+SLineBreak+
            '     p.nome_port,                                       '+SLineBreak+
            '     f.quantidade_parcelas,                             '+SLineBreak+
            '     f.valor_parcela,                                   '+SLineBreak+
            '     f.valor_total,                                     '+SLineBreak+
            '     f.vencimento,                                      '+SLineBreak+
            '     f.valor_liquido,                                   '+SLineBreak+
            '     f.id_financeiro                                    '+SLineBreak+
            ' from financeiro_pedido f                               '+SLineBreak+
            ' left join portador p on p.codigo_port = f.portador_id  '+SLineBreak+
            ' left join web_pedido w on w.id = f.web_pedido_id       '+SLineBreak+
            'where coalesce(f.status,''A'') = ''A''                  '+SLineBreak;

    lSQL := lSQL + where;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

procedure TFinanceiroPedidoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From FINANCEIRO_PEDIDO where 1=1 ';

    lSQL := lSQL + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.qtdePagamentoPrazo(pWebPedido: String): Integer;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin

  lQry := vIConexao.CriarQuery;

  try
      lSQL :=
      '   select count(*) qtde                                           '+SLineBreak+
      '     from financeiro_pedido f                                     '+SLineBreak+
      '    inner join portador p on p.codigo_port = f.portador_id        '+SLineBreak+
      '    where f.web_pedido_id = '+pWebPedido+'                        '+SLineBreak+
      '      and p.tpag_nfe not in (''01'', ''03'', ''04'', ''17'', ''20'', ''99'')      '+SLineBreak;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry).objeto.FieldByName('QTDE').AsInteger;
  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin

  lQry       := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

      lSQL :=
      ' select   '+lPaginacao+'                                                      '+SLineBreak+
      '     financeiro_pedido.*,                                                     '+SLineBreak+
      '     portador.nome_port                                                       '+SLineBreak+
      '                                                                              '+SLineBreak+
      '                                                                              '+SLineBreak+
      ' From                                                                         '+SLineBreak+
      '     financeiro_pedido                                                        '+SLineBreak+
      '                                                                              '+SLineBreak+
      ' left join portador on portador.codigo_port = financeiro_pedido.portador_id   '+SLineBreak+
      '                                                                              '+SLineBreak+
      ' where coalesce(financeiro_pedido.status,''A'') = ''A''                       '+SLineBreak;

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TFinanceiroPedidoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFinanceiroPedidoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TFinanceiroPedidoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFinanceiroPedidoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFinanceiroPedidoDao.setParams(var pQry: TFDQuery; pFinanceiroPedidoModel: ITFinanceiroPedidoModel);
begin
  vConstrutor.setParams('FINANCEIRO_PEDIDO',pQry,pFinanceiroPedidoModel.objeto);
end;

procedure TFinanceiroPedidoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFinanceiroPedidoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFinanceiroPedidoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
