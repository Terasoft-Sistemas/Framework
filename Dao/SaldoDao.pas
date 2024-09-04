unit SaldoDao;

interface

uses
  SaldoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  LojasModel,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao,
  Terasoft.Utils;

type
  TSaldoDao = class;
  ITSaldoDao=IObject<TSaldoDao>;

  TSaldoDao = class
  private
    [weak] mySelf: ITSaldoDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FSaldosLista: IList<ITSaldoModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure SetCountView(const Value: String);
    procedure SetSaldosLista(const Value: IList<ITSaldoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

  public
    constructor _Create(pIConexao: IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITSaldoDao;

    property SaldosLista: IList<ITSaldoModel> read FSaldosLista write SetSaldosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;

    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

	  function obterSaldoLojas(pParametros : TParametrosSaldo): IFDDataset;
    function obterReservasCD(pProduto: String): IFDDataset;
end;

implementation

uses
  System.Rtti, Data.DB;

{ TSaldo }

constructor TSaldoDao._Create(pIConexao: IConexao);
begin
  vIConexao  := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TSaldoDao.Destroy;
begin
  FSaldosLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

class function TSaldoDao.getNewIface(pIConexao: IConexao): ITSaldoDao;
begin
  Result := TImplObjetoOwner<TSaldoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TSaldoDao.obterReservasCD(pProduto: String): IFDDataset;
var
  lSql  : String;
  lQry  : TFDQuery;
begin
  try
    lSql := '  select                                                                                                 '+SLineBreak+
            '        DOCUMENTO,                                                                                       '+SLineBreak+
            '        ORIGEM,                                                                                          '+SLineBreak+
            '        DATA,                                                                                            '+SLineBreak+
            '        CLIENTE,                                                                                         '+SLineBreak+
            '        RESERVADO,                                                                                       '+SLineBreak+
            '        LOJA,                                                                                            '+SLineBreak+
            '        PRODUTO                                                                                          '+SLineBreak+
            '                                                                                                         '+SLineBreak+
            '    from                                                                                                 '+SLineBreak+
            '        (                                                                                                '+SLineBreak+
            '        select                                                                                           '+SLineBreak+
            '            r.id documento,                                                                              '+SLineBreak+
            '            r.origem,                                                                                    '+SLineBreak+
            '            r.data,                                                                                      '+SLineBreak+
            '            case                                                                                         '+SLineBreak+
            '            when r.origem = ''Entrada pendente'' then f.fantasia_for                                     '+SLineBreak+
            '            else                                                                                         '+SLineBreak+
            '            c.fantasia_cli                                                                               '+SLineBreak+
            '            end cliente,                                                                                 '+SLineBreak+
            '            r.reservado,                                                                                 '+SLineBreak+
            '            l2.loja loja,                                                                                '+SLineBreak+
            '            r.produto_id produto                                                                         '+SLineBreak+
            '                                                                                                         '+SLineBreak+
            '        from                                                                                             '+SLineBreak+
            '            view_reservados r                                                                            '+SLineBreak+
            '                                                                                                         '+SLineBreak+
            '            left join loja2 l2 on r.loja = l2.loja                                                       '+SLineBreak+
            '            left join clientes c on c.codigo_cli = r.cliente_id and r.origem <> ''Entrada pendente''     '+SLineBreak+
            '            left join fornecedor f on f.codigo_for = r.cliente_id  and r.origem = ''Entrada pendente''   '+SLineBreak+
            '        ) r                                                                                              '+SLineBreak+
            '                                                                                                         '+SLineBreak+
            '    where                                                                                                '+SLineBreak+
            '        r.RESERVADO <> 0 and r.PRODUTO = ' + QuotedStr(pProduto);


    vIConexao.ConfigConexaoExterna('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA);

    lQry := vIConexao.criarQueryExterna;
    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
  end;
end;

function TSaldoDao.obterSaldoLojas(pParametros : TParametrosSaldo): IFDDataset;
var
  lQry      : TFDQuery;
  lSql      : String;
  lLojas    : ITLojasModel;
  lMemTable : IFDDataset;
begin
  lQry := nil;
  lLojas       := TLojasModel.getNewIface(vIConexao);
  lMemTable    := criaIFDDataset(TFDMemTable.Create(nil));
  try
    lSql := ' select                                                   '+SLineBreak+
            '      CODIGO_PRO,                                         '+SLineBreak+
            '      SALDO_FISICO,                                       '+SLineBreak+
            '      SALDO_FISICO-RESERVADOS SALDO_DISPONIVEL            '+SLineBreak+
            '                                                          '+SLineBreak+
            '  from (                                                  '+SLineBreak+
            '                                                          '+SLineBreak+
            '  select                                                  '+SLineBreak+
            '      p.codigo_pro,                                           '+SLineBreak+
            '      coalesce(p.saldo_pro,0) saldo_fisico,                   '+SLineBreak+
            '      sum(coalesce(R.reservado,0)) reservados                 '+SLineBreak+
            '                                                              '+SLineBreak+
            '  from                                                        '+SLineBreak+
            '     produto p                                                '+SLineBreak+
            '                                                              '+SLineBreak+
            '  left join view_reservados r  on p.codigo_pro = r.produto_id '+SLineBreak+
            '                                                              '+SLineBreak+
            '  group by 1,2                                                '+SLineBreak+
            '  ) p                                                         '+SLineBreak+
            '                                                              '+SLineBreak+
            '  where                                                       '+SLineBreak+
            '    p.CODIGO_PRO = ' + QuotedStr(pParametros.PRODUTO);

    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoLoja';
      Fields := 'LOJA';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    TFDMemTable(lMemTable.objeto).IndexName := 'OrdenacaoLoja';

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('LOJA', ftString, 3);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('SALDO_FISICO', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('SALDO_DISPONIVEL', ftFloat);
    TFDMemTable(lMemTable.objeto).CreateDataSet;

    if pParametros.LOJA <> '' then
      lLojas.objeto.LojaView := pParametros.LOJA;

    lLojas.objeto.obterLista;

    for lLojas in lLojas.objeto.LojassLista do
    begin
      vIConexao.ConfigConexaoExterna(llojas.objeto.LOJA);

      lQry := vIConexao.criarQueryExterna;
      lQry.Open(lSQL);

      lMemTable.objeto.InsertRecord([
                              llojas.objeto.LOJA,
                              lQry.fieldByName('SALDO_FISICO').AsFloat,
                              lQry.fieldByName('SALDO_DISPONIVEL').AsFloat
                             ]);

    end;

    if pParametros.CD then
    begin
      vIConexao.ConfigConexaoExterna('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA);

      lQry := vIConexao.criarQueryExterna;
      lQry.Open(lSQL);

      lMemTable.objeto.InsertRecord([
                              'CD',
                              lQry.fieldByName('SALDO_FISICO').AsFloat,
                              lQry.fieldByName('SALDO_DISPONIVEL').AsFloat
                             ]);
    end;

    Result := lMemTable;
  finally
    lQry.Free;
    lLojas:=nil;
  end;
end;

procedure TSaldoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSaldoDao.SetSaldosLista;
begin
  FSaldosLista := Value;
end;

procedure TSaldoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSaldoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TSaldoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSaldoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TSaldoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TSaldoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TSaldoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
