unit SaldoDao;

interface

uses
  SaldoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  LojasModel,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Utils;

type
  TSaldoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FSaldosLista: TObjectList<TSaldoModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure SetCountView(const Value: String);
    procedure SetSaldosLista(const Value: TObjectList<TSaldoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

  public
    constructor Create(pIConexao: IConexao);
    destructor Destroy; override;

    property SaldosLista: TObjectList<TSaldoModel> read FSaldosLista write SetSaldosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;

    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

	  function obterSaldoLojas(pParametros : TParametrosSaldo): TFDMemTable;

end;

implementation

uses
  System.Rtti, Data.DB;

{ TSaldo }

constructor TSaldoDao.Create(pIConexao: IConexao);
begin
  vIConexao  := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TSaldoDao.Destroy;
begin

  inherited;
end;

function TSaldoDao.obterSaldoLojas(pParametros : TParametrosSaldo): TFDMemTable;
var
  lQry      : TFDQuery;
  lSql      : String;
  lLojas    : TLojasModel;
  lMemTable : TFDMemTable;
begin
  lLojas       := TLojasModel.Create(vIConexao);
  lMemTable    := TFDMemTable.Create(nil);
  FSaldosLista := TObjectList<TSaldoModel>.Create;

  try
    lSql := ' select                                                   '+
            '      CODIGO_PRO,                                         '+
            '      SALDO_FISICO,                                       '+
            '      SALDO_FISICO-RESERVADOS SALDO_DISPONIVEL            '+
            '                                                          '+
            '  from (                                                  '+
            '                                                          '+
            '  select                                                  '+
            '      p.codigo_pro,                                       '+
            '      coalesce(p.saldo_pro,0) saldo_fisico,               '+
            '      sum(r.reservado) reservados                         '+
            '                                                          '+
            '  from                                                    '+
            '      view_reservados r                                   '+
            '                                                          '+
            '  left join produto p on p.codigo_pro = r.produto_id      '+
            '                                                          '+
            '  group by 1,2                                            '+
            '  ) p                                                     '+
            '                                                          '+
            '  where                                                   '+
            '    p.CODIGO_PRO = ' + QuotedStr(pParametros.PRODUTO);

    with lMemTable.IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoLoja';
      Fields := 'LOJA';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    lMemTable.IndexName := 'OrdenacaoLoja';

    lMemTable.FieldDefs.Add('LOJA', ftString, 3);
    lMemTable.FieldDefs.Add('SALDO_FISICO', ftFloat);
    lMemTable.FieldDefs.Add('SALDO_DISPONIVEL', ftFloat);
    lMemTable.CreateDataSet;

    if pParametros.LOJA <> '' then
      lLojas.LojaView := pParametros.LOJA;

    lLojas.obterLista;

    for lLojas in lLojas.LojassLista do
    begin
      vIConexao.ConfigConexaoExterna(llojas.LOJA);

      lQry := vIConexao.criarQueryExterna;
      lQry.Open(lSQL);

      FSaldosLista.Add(TSaldoModel.Create(vIConexao));

      lMemTable.InsertRecord([
                              llojas.LOJA,
                              lQry.fieldByName('SALDO_FISICO').AsFloat,
                              lQry.fieldByName('SALDO_DISPONIVEL').AsFloat
                             ]);

    end;

    if pParametros.CD then
    begin
      vIConexao.ConfigConexaoExterna('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA);

      lQry := vIConexao.criarQueryExterna;
      lQry.Open(lSQL);

      FSaldosLista.Add(TSaldoModel.Create(vIConexao));

      lMemTable.InsertRecord([
                              'CD',
                              lQry.fieldByName('SALDO_FISICO').AsFloat,
                              lQry.fieldByName('SALDO_DISPONIVEL').AsFloat
                             ]);
    end;

    Result := lMemTable;
  finally
    lQry.Free;
    lLojas.Free;
  end;
end;

procedure TSaldoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSaldoDao.SetSaldosLista(const Value: TObjectList<TSaldoModel>);
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
