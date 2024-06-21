unit SolicitacaoDescontoDao;

interface

uses
  SolicitacaoDescontoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TSolicitacaoDescontoDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pSolicitacaoDescontoModel: TSolicitacaoDescontoModel): String;
    function alterar(pSolicitacaoDescontoModel: TSolicitacaoDescontoModel): String;
    function excluir(pSolicitacaoDescontoModel: TSolicitacaoDescontoModel): String;

    function carregaClasse(pID : String): TSolicitacaoDescontoModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pSolicitacaoDescontoModel: TSolicitacaoDescontoModel);

end;

implementation

uses
  System.Rtti;

{ TSolicitacaoDesconto }

function TSolicitacaoDescontoDao.carregaClasse(pID : String): TSolicitacaoDescontoModel;
var
  lQry: TFDQuery;
  lModel: TSolicitacaoDescontoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TSolicitacaoDescontoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from solicitacao_desconto where id = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                   := lQry.FieldByName('ID').AsString;
    lModel.PEDIDO_ID            := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.CLIENTE_ID           := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.USUARIO_SOLICITANTE  := lQry.FieldByName('USUARIO_SOLICITANTE').AsString;
    lModel.USUARIO_CEDENTE      := lQry.FieldByName('USUARIO_CEDENTE').AsString;
    lModel.VALOR_PEDIDO         := lQry.FieldByName('VALOR_PEDIDO').AsString;
    lModel.VALOR_DESCONTO       := lQry.FieldByName('VALOR_DESCONTO').AsString;
    lModel.STATUS               := lQry.FieldByName('STATUS').AsString;
    lModel.TIPOVENDA_ID         := lQry.FieldByName('TIPOVENDA_ID').AsString;
    lModel.TABELA_ORIGEM        := lQry.FieldByName('TABELA_ORIGEM').AsString;
    lModel.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TSolicitacaoDescontoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TSolicitacaoDescontoDao.Destroy;
begin
  inherited;
end;

function TSolicitacaoDescontoDao.incluir(pSolicitacaoDescontoModel: TSolicitacaoDescontoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('SOLICITACAO_DESCONTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pSolicitacaoDescontoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSolicitacaoDescontoDao.alterar(pSolicitacaoDescontoModel: TSolicitacaoDescontoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('SOLICITACAO_DESCONTO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pSolicitacaoDescontoModel);
    lQry.ExecSQL;

    Result := pSolicitacaoDescontoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSolicitacaoDescontoDao.excluir(pSolicitacaoDescontoModel: TSolicitacaoDescontoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from solicitacao_desconto where ID = :ID' ,[pSolicitacaoDescontoModel.ID]);
   Result := pSolicitacaoDescontoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TSolicitacaoDescontoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TSolicitacaoDescontoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From solicitacao_desconto where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TSolicitacaoDescontoDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+'                                                                                           '+SLineBreak+
              '         solicitacao_desconto.id,                                                                                 '+SLineBreak+
              '         solicitacao_desconto.cliente_id,                                                                         '+SLineBreak+
              '         coalesce(clientes.razao_cli, clientes.fantasia_cli) cliente_nome,                                        '+SLineBreak+
              '         solicitacao_desconto.usuario_solicitante,                                                                '+SLineBreak+
              '         solicitante.fantasia usuario_solicitante_nome,                                                           '+SLineBreak+
              '         solicitacao_desconto.usuario_cedente,                                                                    '+SLineBreak+
              '         cedente.fantasia usuario_cedente_nome,                                                                   '+SLineBreak+
              '         solicitacao_desconto.pedido_id,                                                                          '+SLineBreak+
              '         solicitacao_desconto.status,                                                                             '+SLineBreak+
              '         solicitacao_desconto.tipovenda_id,                                                                       '+SLineBreak+
              '         solicitacao_desconto.tabela_origem,                                                                      '+SLineBreak+
              '         solicitacao_desconto.valor_desconto,                                                                     '+SLineBreak+
              '         solicitacao_desconto.valor_desconto / solicitacao_desconto.valor_pedido * 100 percentual_desconto,       '+SLineBreak+
              '         solicitacao_desconto.valor_pedido,                                                                       '+SLineBreak+
              '         solicitacao_desconto.valor_pedido - solicitacao_desconto.valor_desconto                                  '+SLineBreak+
              '    from solicitacao_desconto                                                                                     '+SLineBreak+
              '    left join clientes on clientes.codigo_cli = solicitacao_desconto.cliente_id                                   '+SLineBreak+
              '    left join usuario solicitante on solicitante.id = solicitacao_desconto.usuario_solicitante                    '+SLineBreak+
              '    left join usuario cedente on cedente.id = solicitacao_desconto.usuario_cedente                                '+SLineBreak+
              '   where 1=1                                                                                                      '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TSolicitacaoDescontoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSolicitacaoDescontoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSolicitacaoDescontoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TSolicitacaoDescontoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSolicitacaoDescontoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TSolicitacaoDescontoDao.setParams(var pQry: TFDQuery; pSolicitacaoDescontoModel: TSolicitacaoDescontoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('SOLICITACAO_DESCONTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TSolicitacaoDescontoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pSolicitacaoDescontoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pSolicitacaoDescontoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TSolicitacaoDescontoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TSolicitacaoDescontoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TSolicitacaoDescontoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
