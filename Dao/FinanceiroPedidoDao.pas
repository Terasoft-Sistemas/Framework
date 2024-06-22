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
  System.Rtti;

type
  TFinanceiroPedidoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

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

    constructor Create(pIConexao: IConexao);
    destructor Destroy; override;

    property TotalRecords      : Integer      read FTotalRecords        write SetTotalRecords;
    property IDRecordView      : Integer      read FIDRecordView        write SetIDRecordView;
    property WhereView         : String       read FWhereView           write SetWhereView;
    property CountView         : String       read FCountView           write SetCountView;
    property OrderView         : String       read FOrderView           write SetOrderView;
    property StartRecordView   : String       read FStartRecordView     write SetStartRecordView;
    property LengthPageView    : String       read FLengthPageView      write SetLengthPageView;

    function incluir(pFinanceiroPedidoModel: TFinanceiroPedidoModel): String;
    function alterar(pFinanceiroPedidoModel: TFinanceiroPedidoModel): String;
    function excluir(pFinanceiroPedidoModel: TFinanceiroPedidoModel): String;

    procedure setParams(var pQry : TFDQuery; pFinanceiroPedidoModel: TFinanceiroPedidoModel);
    function carregaClasse(pID: String): TFinanceiroPedidoModel;
    function obterResumo(pIDPedido : String) : TFDMemTable;
    function obterResumoFinanceiro: TFDMemTable;
    function ObterLista: TFDMemTable;
    function qtdePagamentoPrazo(pWebPedido : String): Integer;
end;

implementation

uses
  System.Variants;

{ TFinanceiroPedido }

function TFinanceiroPedidoDao.carregaClasse(pID: String): TFinanceiroPedidoModel;
var
  lQry: TFDQuery;
  lModel: TFinanceiroPedidoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TFinanceiroPedidoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from FINANCEIRO_PEDIDO where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                     := lQry.FieldByName('ID').AsString;
    lModel.SYSTIME                := lQry.FieldByName('SYSTIME').AsString;
    lModel.DATA_CADASTRO          := lQry.FieldByName('DATA_CADASTRO').AsString;
    lModel.WEB_PEDIDO_ID          := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    lModel.PEDIDO_VENDA_ID        := lQry.FieldByName('PEDIDO_VENDA_ID').AsString;
    lModel.PORTADOR_ID            := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.VALOR_TOTAL            := lQry.FieldByName('VALOR_TOTAL').AsString;
    lModel.QUANTIDADE_PARCELAS    := lQry.FieldByName('QUANTIDADE_PARCELAS').AsString;
    lModel.PARCELA                := lQry.FieldByName('PARCELA').AsString;
    lModel.VALOR_PARCELA          := lQry.FieldByName('VALOR_PARCELA').AsString;
    lModel.VENCIMENTO             := lQry.FieldByName('VENCIMENTO').AsString;
    lModel.CONDICAO_PAGAMENTO     := lQry.FieldByName('CONDICAO_PAGAMENTO').AsString;
    lModel.OBSERVACAO             := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.INDCE_APLICADO         := lQry.FieldByName('INDCE_APLICADO').AsString;
    lModel.VALOR_ACRESCIMO        := lQry.FieldByName('VALOR_ACRESCIMO').AsString;
    lModel.VALOR_LIQUIDO          := lQry.FieldByName('VALOR_LIQUIDO').AsString;
    lModel.ID_FINANCEIRO          := lQry.FieldByName('ID_FINANCEIRO').AsString;
    lModel.VALOR_LIQUIDO          := lQry.FieldByName('VALOR_SEG_PRESTAMISTA').AsString;
    lModel.ID_FINANCEIRO          := lQry.FieldByName('PER_SEG_PRESTAMSTA').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TFinanceiroPedidoDao.Create(pIConexao: IConexao);
begin
  vIConexao       := pIConexao;
  vConstrutor  := TConstrutorDao.Create(vIConexao);
end;

destructor TFinanceiroPedidoDao.Destroy;
begin
  vConstrutor.Free;
  inherited;
end;

function TFinanceiroPedidoDao.incluir(pFinanceiroPedidoModel: TFinanceiroPedidoModel): String;
var
  lQry  : TFDQuery;
  lSQL  : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := vConstrutor.gerarInsert('FINANCEIRO_PEDIDO', 'ID', true);

    pFinanceiroPedidoModel.ID := vIConexao.Generetor('GEN_FINANCEIRO_PEDIDO_ID');

    if pFinanceiroPedidoModel.ID_FINANCEIRO = '' then
      pFinanceiroPedidoModel.ID_FINANCEIRO := pFinanceiroPedidoModel.ID;

    lQry.SQL.Add(lSQL);
    setParams(lQry, pFinanceiroPedidoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.alterar(pFinanceiroPedidoModel: TFinanceiroPedidoModel): String;
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

    Result := pFinanceiroPedidoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.excluir(pFinanceiroPedidoModel: TFinanceiroPedidoModel): String;
var
  lQry     : TFDQuery;
begin
  lQry     := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from FINANCEIRO_PEDIDO where ID_FINANCEIRO = :ID_FINANCEIRO',[pFinanceiroPedidoModel.ID_FINANCEIRO]);

   Result := pFinanceiroPedidoModel.ID_FINANCEIRO;
  finally
    lQry.Free;
  end;
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

function TFinanceiroPedidoDao.obterResumo(pIDPedido: String): TFDMemTable;
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
    '     f.valor_seg_prestamista                            '+SLineBreak+
    '                                                        '+SLineBreak+
    ' From financeiro_pedido f                               '+SLineBreak+
    '                                                        '+SLineBreak+
    ' left join portador p on p.codigo_port = f.portador_id  '+SLineBreak+
    ' left join web_pedido w on w.id = f.web_pedido_id       '+SLineBreak+
    '                                                        '+SLineBreak+
    ' where                                                  '+SLineBreak+
    '     f.web_pedido_id = '+pIDPedido+' and                '+SLineBreak+
    '     f.parcela = 1                                      '+SLineBreak;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.obterResumoFinanceiro: TFDMemTable;
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
            'where 1=1                                               '+SLineBreak;

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
      '      and p.tpag_nfe not in (''01'', ''03'', ''04'', ''99'')      '+SLineBreak;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry).FieldByName('QTDE').AsInteger;
  finally
    lQry.Free;
  end;
end;

function TFinanceiroPedidoDao.ObterLista: TFDMemTable;
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
      ' where 1=1                                                                    '+SLineBreak;

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

procedure TFinanceiroPedidoDao.setParams(var pQry: TFDQuery; pFinanceiroPedidoModel: TFinanceiroPedidoModel);
var
  lTabela  : TFDMemTable;
  lCtx     : TRttiContext;
  lProp    : TRttiProperty;
  i        : Integer;
begin
  lTabela := vConstrutor.getColumns('FINANCEIRO_PEDIDO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TFinanceiroPedidoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pFinanceiroPedidoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pFinanceiroPedidoModel).AsString));
    end;
  finally
    lCtx.Free;
  end;
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
