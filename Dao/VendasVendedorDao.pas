unit VendasVendedorDao;

interface

uses
  VendasVendedorModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TVendasVendedorDao = class;
  ITVendasVendedorDao=IObject<TVendasVendedorDao>;

  TVendasVendedorDao = class
  private
    [weak] mySelf : ITVendasVendedorDao;
    vIConexao 	  : IConexao;
    vConstrutor   : IConstrutorDao;

    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    function queryPedido: String;
    function queryDevolucao: String;
  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITVendasVendedorDao;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;

    function obterComissao(pVendasVendedorParametros : TVendasVendedorParametros): IFDDataset;
    function obterDevolucao(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
    function obterItens(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
    function obterGrupoComissao(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
end;

implementation

uses
  System.Rtti, Data.DB, Interfaces.QueryLojaAsync, System.AnsiStrings, Terasoft.FuncoesTexto;

{ TVendasVendedor }

constructor TVendasVendedorDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TVendasVendedorDao.Destroy;
begin
  inherited;
end;

class function TVendasVendedorDao.getNewIface(pIConexao: IConexao): ITVendasVendedorDao;
begin
  Result := TImplObjetoOwner<TVendasVendedorDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TVendasVendedorDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  Result := lSQL;
end;

function TVendasVendedorDao.obterComissao(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
var
  lSQL        : String;
  lMemTable   : TFDMemTable;
  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin
  lAsyncList := getQueryLojaAsyncList(vIConexao, pVendasVendedorParametros.Lojas);
  lMemTable  := TFDMemTable.Create(nil);
  Result     := criaIFDDataset(lMemTable);

  lSQL := ' select                                                                                                                   '+SLineBreak+
          '      TIPO,                                                                                                               '+SLineBreak+
          '      DOCUMENTO,                                                                                                          '+SLineBreak+
          '      DATA,                                                                                                               '+SLineBreak+
          '      CLIENTE,                                                                                                            '+SLineBreak+
          '      LOJA,                                                                                                               '+SLineBreak+
          '      CODIGO_VENDEDOR,                                                                                                    '+SLineBreak+
          '      VENDEDOR,                                                                                                           '+SLineBreak+
          '      SUM(VALOR_VENDA_BRUTO-VALOR_DESCONTO) VALOR_VENDA,                                                                  '+SLineBreak+
          '      SUM(cast( (VALOR_VENDA_BRUTO-VALOR_DESCONTO) as float) * cast(( PERCENTUAL_COMISSAO/100) as float)) VALOR_COMISSAO  '+SLineBreak+
          '  from                                                                                                                    '+SLineBreak+
          '  ( '+queryPedido+' ) t                                                                                                   '+SLineBreak+
          ' where 1=1                                                                                                                '+SLineBreak+
          '   and t.data between ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + 'and             '+SLineBreak+
                                     QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and t.codigo_vendedor in (' + pVendasVendedorParametros.Vendedor + ')';

  lSQL := lSQL + ' group by 1,2,3,4,5,6,7 ';

  gravaSQL(lSQL, 'VendasVendedorObterComissao_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  lMemTable.FieldDefs.Add('TIPO', ftString, 11);
  lMemTable.FieldDefs.Add('DOCUMENTO', ftString, 6);
  lMemTable.FieldDefs.Add('DATA', ftDate);
  lMemTable.FieldDefs.Add('CLIENTE', ftString, 100);
  lMemTable.FieldDefs.Add('VALOR_VENDA', ftFloat);
  lMemTable.FieldDefs.Add('VALOR_COMISSAO', ftFloat);
  lMemTable.FieldDefs.Add('LOJA', ftString, 3);
  lMemTable.FieldDefs.Add('CODIGO_VENDEDOR', ftString, 6);
  lMemTable.FieldDefs.Add('VENDEDOR', ftString, 50);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterComissao';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterComissao: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterComissao: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA, lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lMemTable.InsertRecord([lQA.dataset.dataset.FieldByName('TIPO').AsString,
                              lQA.dataset.dataset.FieldByName('DOCUMENTO').AsString,
                              lQA.dataset.dataset.FieldByName('DATA').AsString,
                              lQA.dataset.dataset.FieldByName('CLIENTE').AsString,
                              lQA.dataset.dataset.FieldByName('VALOR_VENDA').AsString,
                              lQA.dataset.dataset.FieldByName('VALOR_COMISSAO').AsString,
                              lQA.dataset.dataset.FieldByName('LOJA').AsString,
                              lQA.dataset.dataset.FieldByName('CODIGO_VENDEDOR').AsString,
                              lQA.dataset.dataset.FieldByName('VENDEDOR').AsString]);

      lQA.dataset.dataset.Next;
    end;
  end;

end;

function TVendasVendedorDao.obterDevolucao(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
var
  lSql        : String;
  lMemTable   : TFDMemTable;
  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin
  lAsyncList := getQueryLojaAsyncList(vIConexao, pVendasVendedorParametros.Lojas);
  lMemTable  := TFDMemTable.Create(nil);
  Result     := criaIFDDataset(lMemTable);

  lSql := ' select                                                                                                                '+SLineBreak+
          '    TIPO,                                                                                                              '+SLineBreak+
          '    DOCUMENTO,                                                                                                         '+SLineBreak+
          '    DATA,                                                                                                              '+SLineBreak+
          '    CLIENTE,                                                                                                           '+SLineBreak+
          '    CODIGO_VENDEDOR,                                                                                                   '+SLineBreak+
          '    VENDEDOR,                                                                                                          '+SLineBreak+
          '    LOJA,                                                                                                              '+SLineBreak+
          '    SUM(VALOR_VENDA_BRUTO-VALOR_DESCONTO) VALOR_VENDA,                                                                 '+SLineBreak+
          '    SUM(cast((VALOR_VENDA_BRUTO-VALOR_DESCONTO) as float) * cast(( PERCENTUAL_COMISSAO/100) as float)) VALOR_COMISSAO  '+SLineBreak+
          '   from                                                                                                                '+SLineBreak+
          '     ( '+queryDevolucao+' ) t                                                                                          '+SLineBreak+
          '  where 1=1                                                                                                            '+SLineBreak+
          '    and t.data between ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) + 'and         '+SLineBreak+
                                      QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and t.codigo_vendedor = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL + ' group by 1,2,3,4,5,6,7 ';

  gravaSQL(lSQL, 'VendasVendedorObterDevolucao_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  lMemTable.FieldDefs.Add('TIPO', ftString, 11);
  lMemTable.FieldDefs.Add('DOCUMENTO', ftString, 6);
  lMemTable.FieldDefs.Add('DATA', ftDate);
  lMemTable.FieldDefs.Add('CLIENTE', ftString, 100);
  lMemTable.FieldDefs.Add('VALOR_VENDA', ftFloat);
  lMemTable.FieldDefs.Add('VALOR_COMISSAO', ftFloat);
  lMemTable.FieldDefs.Add('LOJA', ftString, 3);
  lMemTable.FieldDefs.Add('CODIGO_VENDEDOR', ftString, 6);
  lMemTable.FieldDefs.Add('VENDEDOR', ftString, 50);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterDevolucao';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterDevolucao: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterDevolucao: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA, lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lMemTable.InsertRecord([lQA.dataset.dataset.FieldByName('TIPO').AsString,
                              lQA.dataset.dataset.FieldByName('DOCUMENTO').AsString,
                              lQA.dataset.dataset.FieldByName('DATA').AsString,
                              lQA.dataset.dataset.FieldByName('CLIENTE').AsString,
                              lQA.dataset.dataset.FieldByName('VALOR_VENDA').AsString,
                              lQA.dataset.dataset.FieldByName('VALOR_COMISSAO').AsString,
                              lQA.dataset.dataset.FieldByName('LOJA').AsString,
                              lQA.dataset.dataset.FieldByName('CODIGO_VENDEDOR').AsString,
                              lQA.dataset.dataset.FieldByName('VENDEDOR').AsString]);

      lQA.dataset.dataset.Next;
    end;
  end;
end;

function TVendasVendedorDao.obterGrupoComissao(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
var
  lSql        : String;
  lMemTable   : TFDMemTable;
  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin
  lAsyncList := getQueryLojaAsyncList(vIConexao, pVendasVendedorParametros.Lojas);
  lMemTable  := TFDMemTable.Create(nil);
  Result     := criaIFDDataset(lMemTable);

  lSql := ' select                                                                                                               '+SLineBreak+
          '    GRUPO,                                                                                                            '+SLineBreak+
          '    PERCENTUAL_COMISSAO,                                                                                              '+SLineBreak+
          '    SUM(VALOR_VENDA_BRUTO-VALOR_DESCONTO) VALOR_VENDA,                                                                '+SLineBreak+
          '    SUM(cast((VALOR_VENDA_BRUTO-VALOR_DESCONTO) as float) * cast(( PERCENTUAL_COMISSAO/100) as float)) VALOR_COMISSAO '+SLineBreak+
          '   from                                                                                                               '+SLineBreak+
          '     (                                                                                                                '+SLineBreak+
          '        '+queryPedido+'                                                                                               '+SLineBreak+
          '         where p.data_ped between ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) +
          '                              and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + '  and f.codigo_fun = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL +
          '     ) t                                                                                                              '+SLineBreak+
          '  where 1=1                                                                                                           '+SLineBreak;

  lSQL := lSQL + ' group by 1,2 ';
  lSQL := lSQL + ' order by 1 ';

  gravaSQL(lSQL, 'VendasVendedorObterGrupo_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  lMemTable.FieldDefs.Add('GRUPO', ftString, 100);
  lMemTable.FieldDefs.Add('PERCENTUAL_COMISSAO', ftFloat);
  lMemTable.FieldDefs.Add('VALOR_VENDA', ftFloat);
  lMemTable.FieldDefs.Add('VALOR_COMISSAO', ftFloat);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterGrupo';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterGrupo: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterGrupo: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA, lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lMemTable.InsertRecord([lQA.dataset.dataset.FieldByName('GRUPO').AsString,
                              lQA.dataset.dataset.FieldByName('PERCENTUAL_COMISSAO').AsFloat,
                              lQA.dataset.dataset.FieldByName('VALOR_VENDA').AsFloat,
                              lQA.dataset.dataset.FieldByName('VALOR_COMISSAO').AsFloat]);

      lQA.dataset.dataset.Next;
    end;
  end;
end;

function TVendasVendedorDao.obterItens(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
var
  lSql        : String;
  lMemTable   : TFDMemTable;
  lAsyncList  : IListaQueryAsync;
  lQA         : IQueryLojaAsync;
  conexao     : IConexao;
begin
  lAsyncList := getQueryLojaAsyncList(vIConexao, pVendasVendedorParametros.Lojas);
  lMemTable  := TFDMemTable.Create(nil);
  Result     := criaIFDDataset(lMemTable);

  lSql := ' select                                         '+SLineBreak+
          '    TIPO,                                       '+SLineBreak+
          '    DOCUMENTO,                                  '+SLineBreak+
          '    DATA,                                       '+SLineBreak+
          '    LOJA,                                       '+SLineBreak+
          '    CODIGO_VENDEDOR,                            '+SLineBreak+
          '    VENDEDOR,                                   '+SLineBreak+
          '    CODIGO_PRODUTO,                             '+SLineBreak+
          '    PRODUTO,                                    '+SLineBreak+
          '    VALOR_VENDA_BRUTO VALOR_VENDA,              '+SLineBreak+
          '    QUANTIDADE                                  '+SLineBreak+
          '   from                                         '+SLineBreak+
          '     ( '+queryPedido+' ) t                      '+SLineBreak+
          '  where 1=1                                     '+SLineBreak+
          '    and t.data between ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataInicio)) +
          '                   and ' + QuotedStr(transformaDataFireBirdWhere(pVendasVendedorParametros.DataFim));

  if pVendasVendedorParametros.Vendedor <> '' then
    lSQL := lSQL + ' and t.codigo_vendedor = ' + QuotedStr(pVendasVendedorParametros.Vendedor);

  lSQL := lSQL + ' order by 3,6 ';

  gravaSQL(lSQL, 'VendasVendedorObterItens_' + FormatDateTime('yyyymmddhhnnsszzz', now));

  lMemTable.FieldDefs.Add('TIPO', ftString, 11);
  lMemTable.FieldDefs.Add('DOCUMENTO', ftString, 6);
  lMemTable.FieldDefs.Add('DATA', ftDate);
  lMemTable.FieldDefs.Add('LOJA', ftString, 3);
  lMemTable.FieldDefs.Add('CODIGO_VENDEDOR', ftString, 6);
  lMemTable.FieldDefs.Add('VENDEDOR', ftString, 100);
  lMemTable.FieldDefs.Add('CODIGO_PRODUTO', ftString, 50);
  lMemTable.FieldDefs.Add('PRODUTO', ftString, 100);
  lMemTable.FieldDefs.Add('VALOR_VENDA', ftFloat);
  lMemTable.FieldDefs.Add('QUANTIDADE', ftFloat);
  lMemTable.CreateDataSet;

  for lQA in lAsyncList do
  begin
    lQA.rotulo := 'ObterItens';
    conexao := lQA.loja.objeto.conexaoLoja;
    if(conexao=nil) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterItens: Loja [%s] com problemas.',[lQA.loja.objeto.LOJA]);

    lQA.execQuery(lSQL,'',[]);
  end;

  for lQA in lAsyncList do
  begin
    lQA.esperar;
    if(lQA.resultado.erros>0) then
      raise Exception.CreateFmt('TVendasVendedorDao.ObterItens: Loja [%s] com problemas: [%s]',[lQA.loja.objeto.LOJA, lQA.resultado.toString]);

    lQA.dataset.dataset.first;
    while not lQA.dataset.dataset.Eof do
    begin
      lMemTable.InsertRecord([lQA.dataset.dataset.FieldByName('TIPO').AsString,
                              lQA.dataset.dataset.FieldByName('DOCUMENTO').AsString,
                              lQA.dataset.dataset.FieldByName('DATA').AsString,
                              lQA.dataset.dataset.FieldByName('LOJA').AsString,
                              lQA.dataset.dataset.FieldByName('CODIGO_VENDEDOR').AsString,
                              lQA.dataset.dataset.FieldByName('VENDEDOR').AsString,
                              lQA.dataset.dataset.FieldByName('CODIGO_PRODUTO').AsString,
                              lQA.dataset.dataset.FieldByName('PRODUTO').AsString,
                              lQA.dataset.dataset.FieldByName('VALOR_VENDA').AsString,
                              lQA.dataset.dataset.FieldByName('QUANTIDADE').AsString]);

      lQA.dataset.dataset.Next;
    end;
  end;
end;

procedure TVendasVendedorDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from GRUPO_FILIAIS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TVendasVendedorDao.queryDevolucao: String;
begin
  Result := ' select                                                                                                      '+SLineBreak+
            '    ''DEVOLUCAO'' TIPO,                                                                                      '+SLineBreak+
            '    d.data DATA,                                                                                             '+SLineBreak+
            '    d.loja LOJA,                                                                                             '+SLineBreak+
            '    cl.fantasia_cli CLIENTE,                                                                                 '+SLineBreak+
            '    f.codigo_fun CODIGO_VENDEDOR,                                                                            '+SLineBreak+
            '    f.nome_fun VENDEDOR,                                                                                     '+SLineBreak+
            '    d.id DOCUMENTO,                                                                                          '+SLineBreak+
            '    g.nome GRUPO,                                                                                            '+SLineBreak+
            '    di.produto CODIGO_PRODUTO,                                                                               '+SLineBreak+
            '    pr.nome_pro PRODUTO,                                                                                     '+SLineBreak+
            '    di.quantidade QUANTIDADE,                                                                                '+SLineBreak+
            '    (di.valor_unitario* di.quantidade) VALOR_VENDA_BRUTO,                                                    '+SLineBreak+
            '    cast(((di.valor_unitario*(coalesce(di.desconto_ped,0)/100))*di.quantidade) as float) VALOR_DESCONTO,     '+SLineBreak+
            '    (di.comissao_percentual) PERCENTUAL_COMISSAO                                                             '+SLineBreak+
            '                                                                                                             '+SLineBreak+
            '   from                                                                                                      '+SLineBreak+
            '      devolucao d                                                                                            '+SLineBreak+
            '                                                                                                             '+SLineBreak+
            '   left join devolucaoitens di on d.id = di.id                                                               '+SLineBreak+
            '   left join produto pr on pr.codigo_pro = di.produto                                                        '+SLineBreak+
            '   left join funcionario f on f.codigo_fun = d.vendedor                                                      '+SLineBreak+
            '   left join grupo_comissao g on g.id = pr.grupo_comissao_id                                                 '+SLineBreak+
            '   left join clientes cl on cl.codigo_cli = d.cliente                                                        '+SLineBreak;
end;

function TVendasVendedorDao.queryPedido: String;
begin
  Result := ' select                                                                         '+SLineBreak+
            '    ''PEDIDO'' TIPO,                                                            '+SLineBreak+
            '    p.data_ped DATA,                                                            '+SLineBreak+
            '    i.loja LOJA,                                                                '+SLineBreak+
            '    cl.fantasia_cli CLIENTE,                                                    '+SLineBreak+
            '    F.codigo_fun CODIGO_VENDEDOR,                                               '+SLineBreak+
            '    f.nome_fun VENDEDOR,                                                        '+SLineBreak+
            '    p.numero_ped DOCUMENTO,                                                     '+SLineBreak+
            '    g.nome GRUPO,                                                               '+SLineBreak+
            '    i.codigo_pro CODIGO_PRODUTO,                                                '+SLineBreak+
            '    pr.nome_pro PRODUTO,                                                        '+SLineBreak+
            '    i.quantidade_ped QUANTIDADE,                                                '+SLineBreak+
            '    i.valorunitario_ped*i.quantidade_ped VALOR_VENDA_BRUTO,                     '+SLineBreak+
            '    (i.valorunitario_ped*(i.desconto_ped/100))*i.quantidade_ped VALOR_DESCONTO, '+SLineBreak+
            '    i.comissao_percentual PERCENTUAL_COMISSAO                                   '+SLineBreak+
            '                                                                                '+SLineBreak+
            '   from                                                                         '+SLineBreak+
            '      pedidovenda p                                                             '+SLineBreak+
            '                                                                                '+SLineBreak+
            '   left join  pedidoitens i on p.numero_ped = i.numero_ped                      '+SLineBreak+
            '   left join  produto pr on pr.codigo_pro = i.codigo_pro                        '+SLineBreak+
            '   left join  funcionario f on f.codigo_fun = p.codigo_ven                      '+SLineBreak+
            '   left join  grupo_comissao g on g.id = pr.grupo_comissao_id                   '+SLineBreak+
            '   left join  clientes cl on cl.codigo_cli = p.codigo_cli                       '+SLineBreak;
end;

procedure TVendasVendedorDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVendasVendedorDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVendasVendedorDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TVendasVendedorDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TVendasVendedorDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TVendasVendedorDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
