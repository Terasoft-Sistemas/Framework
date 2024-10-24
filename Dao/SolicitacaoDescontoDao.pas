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
  Terasoft.Framework.ObjectIface,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TSolicitacaoDescontoDao = class;
  ITSolicitacaoDescontoDao=IObject<TSolicitacaoDescontoDao>;

  TSolicitacaoDescontoDao = class
  private
    [unsafe] mySelf: ITSolicitacaoDescontoDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

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

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITSolicitacaoDescontoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pSolicitacaoDescontoModel: ITSolicitacaoDescontoModel): String;
    function alterar(pSolicitacaoDescontoModel: ITSolicitacaoDescontoModel): String;
    function excluir(pSolicitacaoDescontoModel: ITSolicitacaoDescontoModel): String;

    function carregaClasse(pID : String): ITSolicitacaoDescontoModel;

    function obterLista: IFDDataset;
    function obterDescontoVendaAssistidaRemoto: TDescontoRemotoResultado;

    procedure setParams(var pQry: TFDQuery; pSolicitacaoDescontoModel: ITSolicitacaoDescontoModel);

end;

implementation

uses
  System.Rtti, Interfaces.QueryLojaAsync, Data.DB;

{ TSolicitacaoDesconto }

function TSolicitacaoDescontoDao.carregaClasse(pID : String): ITSolicitacaoDescontoModel;
var
  lQry: TFDQuery;
  lModel: ITSolicitacaoDescontoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TSolicitacaoDescontoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from solicitacao_desconto where id = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                   := lQry.FieldByName('ID').AsString;
    lModel.objeto.PEDIDO_ID            := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.objeto.CLIENTE_ID           := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.objeto.USUARIO_SOLICITANTE  := lQry.FieldByName('USUARIO_SOLICITANTE').AsString;
    lModel.objeto.USUARIO_CEDENTE      := lQry.FieldByName('USUARIO_CEDENTE').AsString;
    lModel.objeto.VALOR_PEDIDO         := lQry.FieldByName('VALOR_PEDIDO').AsString;
    lModel.objeto.VALOR_DESCONTO       := lQry.FieldByName('VALOR_DESCONTO').AsString;
    lModel.objeto.STATUS               := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.TIPOVENDA_ID         := lQry.FieldByName('TIPOVENDA_ID').AsString;
    lModel.objeto.TABELA_ORIGEM        := lQry.FieldByName('TABELA_ORIGEM').AsString;
    lModel.objeto.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TSolicitacaoDescontoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TSolicitacaoDescontoDao.Destroy;
begin
  inherited;
end;

function TSolicitacaoDescontoDao.incluir(pSolicitacaoDescontoModel: ITSolicitacaoDescontoModel): String;
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

function TSolicitacaoDescontoDao.alterar(pSolicitacaoDescontoModel: ITSolicitacaoDescontoModel): String;
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

    Result := pSolicitacaoDescontoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSolicitacaoDescontoDao.excluir(pSolicitacaoDescontoModel: ITSolicitacaoDescontoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from solicitacao_desconto where ID = :ID' ,[pSolicitacaoDescontoModel.objeto.ID]);
   Result := pSolicitacaoDescontoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TSolicitacaoDescontoDao.getNewIface(pIConexao: IConexao): ITSolicitacaoDescontoDao;
begin
  Result := TImplObjetoOwner<TSolicitacaoDescontoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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

    lSql := '  select count(*) records                                                                       '+SLineBreak+
            '    From solicitacao_desconto                                                                   '+SLineBreak+
            '    left join clientes on clientes.codigo_cli = solicitacao_desconto.cliente_id                 '+SLineBreak+
            '    left join usuario solicitante on solicitante.id = solicitacao_desconto.usuario_solicitante  '+SLineBreak+
            '    left join usuario cedente on cedente.id = solicitacao_desconto.usuario_cedente              '+SLineBreak+
            '   where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TSolicitacaoDescontoDao.obterDescontoVendaAssistidaRemoto: TDescontoRemotoResultado;
var
  lSQL        : String;
  lRegistros,
  lLojas      : TFDMemTable;
  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
  lTotal      : Double;
begin
  lAsyncList   := getQueryLojaAsyncList(vIConexao);
  lRegistros   := TFDMemTable.Create(nil);
  lLojas       := TFDMemTable.Create(nil);
  lTotal       := 0;

  Result.fdRegistros    := criaIFDDataset(lRegistros);
  Result.fdLojasRecords := criaIFDDataset(lLojas);
  
  lSQL := '  select                                                                                                          '+SLineBreak+
          '         solicitacao_desconto.id,                                                                                 '+SLineBreak+
          '         solicitacao_desconto.cliente_id,                                                                         '+SLineBreak+
          '         coalesce(clientes.razao_cli, clientes.fantasia_cli) cliente_nome,                                       '+SLineBreak+
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
          '         solicitacao_desconto.valor_pedido - solicitacao_desconto.valor_desconto valor_liquido                    '+SLineBreak+
          '    from solicitacao_desconto                                                                                     '+SLineBreak+
          '    left join clientes on clientes.codigo_cli = solicitacao_desconto.cliente_id                                   '+SLineBreak+
          '    left join usuario solicitante on solicitante.id = solicitacao_desconto.usuario_solicitante                    '+SLineBreak+
          '    left join usuario cedente on cedente.id = solicitacao_desconto.usuario_cedente                                '+SLineBreak+
          '   where solicitacao_desconto.tabela_origem = ''WEB_PEDIDO''                                                      '+SLineBreak+
          '     and solicitacao_desconto.status is null                                                                      '+SLineBreak;

  lSql := lSql + where;
  lSQL := lSQL + ' order by solicitacao_desconto.SYSTIME ';

  lRegistros.FieldDefs.Add('ID', ftString, 10);
  lRegistros.FieldDefs.Add('LOJA', ftString, 3);
  lRegistros.FieldDefs.Add('CLIENTE_ID', ftString, 6);
  lRegistros.FieldDefs.Add('CLIENTE_NOME', ftString, 100);
  lRegistros.FieldDefs.Add('USUARIO_SOLICITANTE', ftString, 20);
  lRegistros.FieldDefs.Add('USUARIO_SOLICITANTE_NOME', ftString, 50);
  lRegistros.FieldDefs.Add('USUARIO_CEDENTE', ftString, 20);
  lRegistros.FieldDefs.Add('USUARIO_CEDENTE_NOME', ftString, 50);
  lRegistros.FieldDefs.Add('PEDIDO_ID', ftString, 6);
  lRegistros.FieldDefs.Add('STATUS', ftString, 20);
  lRegistros.FieldDefs.Add('TIPOVENDA_ID', ftString, 20);
  lRegistros.FieldDefs.Add('TABELA_ORIGEM', ftString, 50);
  lRegistros.FieldDefs.Add('VALOR_DESCONTO', ftFloat);
  lRegistros.FieldDefs.Add('PERCENTUAL_DESCONTO', ftFloat);
  lRegistros.FieldDefs.Add('VALOR_PEDIDO', ftFloat);
  lRegistros.FieldDefs.Add('VALOR_LIQUIDO', ftFloat);
  lRegistros.CreateDataSet;

  lLojas.FieldDefs.Add('LOJA', ftString, 3);
  lLojas.FieldDefs.Add('QUANTIDADE', ftFloat);
  lLojas.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterDescontoVendaAssistida';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TSolicitacaoDescontoDao.ObterDescontoVendaAssistida: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TSolicitacaoDescontoDao.ObterDescontoVendaAssistida: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA, lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lTotal := lTotal + 1;

      lRegistros.InsertRecord([lQA.dataset.dataset.FieldByName('ID').AsString,
                              lQA.loja.objeto.LOJA,
                              lQA.dataset.dataset.FieldByName('CLIENTE_ID').AsString,
                              lQA.dataset.dataset.FieldByName('CLIENTE_NOME').AsString,
                              lQA.dataset.dataset.FieldByName('USUARIO_SOLICITANTE').AsString,
                              lQA.dataset.dataset.FieldByName('USUARIO_SOLICITANTE_NOME').AsString,
                              lQA.dataset.dataset.FieldByName('USUARIO_CEDENTE').AsString,
                              lQA.dataset.dataset.FieldByName('USUARIO_CEDENTE_NOME').AsString,
                              lQA.dataset.dataset.FieldByName('PEDIDO_ID').AsString,
                              lQA.dataset.dataset.FieldByName('STATUS').AsString,
                              lQA.dataset.dataset.FieldByName('TIPOVENDA_ID').AsString,
                              lQA.dataset.dataset.FieldByName('TABELA_ORIGEM').AsString,
                              lQA.dataset.dataset.FieldByName('VALOR_DESCONTO').AsFloat,
                              lQA.dataset.dataset.FieldByName('PERCENTUAL_DESCONTO').AsFloat,
                              lQA.dataset.dataset.FieldByName('VALOR_PEDIDO').AsFloat,
                              lQA.dataset.dataset.FieldByName('VALOR_LIQUIDO').AsFloat]);

      lQA.dataset.dataset.Next;
    end;

    if lTotal > 0 then
    begin
      lLojas.InsertRecord([lQA.loja.objeto.LOJA, lTotal]);
      lTotal := 0;
    end;
  end;
end;

function TSolicitacaoDescontoDao.obterLista: IFDDataset;
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
              '         solicitacao_desconto.valor_pedido - solicitacao_desconto.valor_desconto valor_liquido                    '+SLineBreak+
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

procedure TSolicitacaoDescontoDao.setParams(var pQry: TFDQuery; pSolicitacaoDescontoModel: ITSolicitacaoDescontoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  vConstrutor.setParams('SOLICITACAO_DESCONTO',pQry,pSolicitacaoDescontoModel.objeto);
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
