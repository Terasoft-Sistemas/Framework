unit ContasPagarDao;

interface

uses
  ContasPagarModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TContasPagarDao = class;
  ITContasPagarDao=IObject<TContasPagarDao>;

  TContasPagarDao = class
  private
    [weak] mySelf: ITContasPagarDao;
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FFornecedorView: Variant;
    FDuplicataView: Variant;
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
    procedure SetFornecedorView(const Value: Variant);
    procedure SetDuplicataView(const Value: Variant);

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITContasPagarDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property FornecedorView :Variant read FFornecedorView write SetFornecedorView;
    property DuplicataView :Variant read FDuplicataView write SetDuplicataView;
    function incluir(AContasPagarModel: ITContasPagarModel): String;
    function alterar(AContasPagarModel: ITContasPagarModel): String;
    function excluir(AContasPagarModel: ITContasPagarModel): String;

    function carregaClasse(pID, pFornecedor : String): ITContasPagarModel;
    function obterLista: IFDDataset;
    function FinanceiroEntrada(pEntrada, pFornecedor: String): Double;

    procedure setParams(var pQry: TFDQuery; pContasPagarModel: ITContasPagarModel);

end;

implementation

uses
  System.Rtti;

{ TContasPagar }

function TContasPagarDao.carregaClasse(pID, pFornecedor: String): ITContasPagarModel;
var
  lQry: TFDQuery;
  lModel: ITContasPagarModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContasPagarModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CONTASPAGAR where DUPLICATA_PAG = '+ QuotedStr(pId) + ' and CODIGO_FOR =' + QuotedStr(pFornecedor));

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.DUPLICATA_PAG                    := lQry.FieldByName('DUPLICATA_PAG').AsString;
    lModel.objeto.CODIGO_FOR                       := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.objeto.DATAEMI_PAG                      := lQry.FieldByName('DATAEMI_PAG').AsString;
    lModel.objeto.DATACOM_PAG                      := lQry.FieldByName('DATACOM_PAG').AsString;
    lModel.objeto.VALOR_PAG                        := lQry.FieldByName('VALOR_PAG').AsString;
    lModel.objeto.OBS_PAG                          := lQry.FieldByName('OBS_PAG').AsString;
    lModel.objeto.SITUACAO_PAG                     := lQry.FieldByName('SITUACAO_PAG').AsString;
    lModel.objeto.USUARIO_PAG                      := lQry.FieldByName('USUARIO_PAG').AsString;
    lModel.objeto.TIPO_PAG                         := lQry.FieldByName('TIPO_PAG').AsString;
    lModel.objeto.CODIGO_CTA                       := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.objeto.LOJA                             := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.TIPO                             := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.ID                               := lQry.FieldByName('ID').AsString;
    lModel.objeto.LOCAL_BAIXA                      := lQry.FieldByName('LOCAL_BAIXA').AsString;
    lModel.objeto.PORTADOR_ID                      := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.OBS_COMPLEMENTAR                 := lQry.FieldByName('OBS_COMPLEMENTAR').AsString;
    lModel.objeto.SYSTIME                          := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.DUPLICATA_ANTIGA                 := lQry.FieldByName('DUPLICATA_ANTIGA').AsString;
    lModel.objeto.SUB_ID                           := lQry.FieldByName('SUB_ID').AsString;
    lModel.objeto.LOCACAO_ID                       := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.objeto.CENTRO_CUSTO                     := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.objeto.EMPRESTIMO_RECEBER_ID            := lQry.FieldByName('EMPRESTIMO_RECEBER_ID').AsString;
    lModel.objeto.FUNCIONARIO_ID                   := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.objeto.CONDICOES_PAG                    := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.objeto.PRIMEIRO_VENC                    := lQry.FieldByName('PRIMEIRO_VENC').AsString;
    lModel.objeto.PREVISAO                         := lQry.FieldByName('PREVISAO').AsString;
    lModel.objeto.COMPETENCIA                      := lQry.FieldByName('COMPETENCIA').AsString;
    lModel.objeto.OS_ID                            := lQry.FieldByName('OS_ID').AsString;
    lModel.objeto.GESTAO_PAGAMENTO_FORMA_ID        := lQry.FieldByName('GESTAO_PAGAMENTO_FORMA_ID').AsString;
    lModel.objeto.GESTAO_PAGAMENTO_TIPO_ID         := lQry.FieldByName('GESTAO_PAGAMENTO_TIPO_ID').AsString;
    lModel.objeto.GESTAO_PAGAMENTO                 := lQry.FieldByName('GESTAO_PAGAMENTO').AsString;
    lModel.objeto.GESTAO_PAGAMENTO_BANCO_FAVORECI  := lQry.FieldByName('GESTAO_PAGAMENTO_BANCO_FAVORECI').AsString;
    lModel.objeto.GESTAO_PAGAMENTO_AGENCIA_FAVORE  := lQry.FieldByName('GESTAO_PAGAMENTO_AGENCIA_FAVORE').AsString;
    lModel.objeto.GESTAO_PAGAMENTO_NOME_FAVORECID  := lQry.FieldByName('GESTAO_PAGAMENTO_NOME_FAVORECID').AsString;
    lModel.objeto.GESTAO_PAGAMENTO_CONTA_FAVORECI  := lQry.FieldByName('GESTAO_PAGAMENTO_CONTA_FAVORECI').AsString;
    lModel.objeto.DUPLICATA_REP                    := lQry.FieldByName('DUPLICATA_REP').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TContasPagarDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TContasPagarDao.Destroy;
begin
  inherited;
end;

function TContasPagarDao.incluir(AContasPagarModel: ITContasPagarModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTASPAGAR', 'DUPLICATA_PAG');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasPagarModel);
    lQry.Open;

    Result := lQry.FieldByName('DUPLICATA_PAG').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasPagarDao.alterar(AContasPagarModel: ITContasPagarModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('CONTASPAGAR','DUPLICATA_PAG');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasPagarModel);
    lQry.ExecSQL;

    Result := AContasPagarModel.objeto.DUPLICATA_PAG;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasPagarDao.excluir(AContasPagarModel: ITContasPagarModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CONTASPAGAR where DUPLICATA_PAG = ' + QuotedStr(AContasPagarModel.objeto.DUPLICATA_PAG) + 'and CODIGO_FOR = ' + QuotedStr(AContasPagarModel.objeto.CODIGO_FOR));
   lQry.ExecSQL;
   Result := AContasPagarModel.objeto.DUPLICATA_PAG;

  finally
    lQry.Free;
  end;
end;

function TContasPagarDao.FinanceiroEntrada(pEntrada, pFornecedor: String): Double;
var
  lSql : String;
  lQry : TFDQuery;
begin
  lQry := vIConexao.criarQuery;
  try
    lSql := 'select sum(c.valor_pag) valor from contaspagar c where c.duplicata_pag = ' +QuotedStr(pEntrada)+ ' and c.codigo_for = ' +QuotedStr(pFornecedor);

    lQry.Open(lSql);

    Result := lQry.FieldByName('VALOR').AsFloat;

  finally
    lQry.Free;
  end;
end;

class function TContasPagarDao.getNewIface(pIConexao: IConexao): ITContasPagarDao;
begin
  Result := TImplObjetoOwner<TContasPagarDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TContasPagarDao.where: String;
var
  lSql : String;
begin
  lSql := '';

  if not FWhereView.IsEmpty then
    lSql := lSQL + FWhereView;

  if DuplicataView <> ''  then
    lSql := lSQL + ' and contaspagar.DUPLICATA_PAG = ' +QuotedStr(DuplicataView);

  if FFornecedorView <> '' then
    lSql := lSql + ' and contaspagar.CODIGO_FOR = ' +QuotedStr(FFornecedorView);

  Result := lSQL;
end;

procedure TContasPagarDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CONTASPAGAR where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TContasPagarDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                           '+SLineBreak+
              '        contaspagar.*,                                                           '+SLineBreak+
              '        portador.nome_port PORTADOR,                                             '+SLineBreak+
              '        coalesce(fornecedor.razao_for, fornecedor.fantasia_for) FORNECEDOR       '+SLineBreak+
              '   from contaspagar                                                              '+SLineBreak+
              '   left join portador on portador.codigo_port = contaspagar.portador_id          '+SLineBreak+
              '  inner join fornecedor on fornecedor.codigo_for = contaspagar.codigo_for        '+SLineBreak+
              '  where 1=1                                                                      '+SLineBreak;

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

procedure TContasPagarDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasPagarDao.SetDuplicataView(const Value: Variant);
begin
  FDuplicataView := Value;
end;

procedure TContasPagarDao.SetFornecedorView(const Value: Variant);
begin
  FFornecedorView := Value;
end;

procedure TContasPagarDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasPagarDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasPagarDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasPagarDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasPagarDao.setParams(var pQry: TFDQuery; pContasPagarModel: ITContasPagarModel);
begin
  vConstrutor.setParams('CONTASPAGAR',pQry,pContasPagarModel.objeto);
end;

procedure TContasPagarDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasPagarDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasPagarDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
