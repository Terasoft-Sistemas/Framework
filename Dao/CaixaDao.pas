unit CaixaDao;

interface

uses
  CaixaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TCaixaDao = class;
  ITCaixaDao=IObject<TCaixaDao>;
  TCaixaDao = class
  private
    [weak] mySelf: ITCaixaDao;
    vIconexao : Iconexao;
    vConstrutor : IConstrutorDao;

    FCaixasLista: IList<ITCaixaModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetCaixasLista(const Value: IList<ITCaixaModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCaixaDao;

    property CaixasLista: IList<ITCaixaModel> read FCaixasLista write SetCaixasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(ACaixaModel: ITCaixaModel): String;
    function alterar(ACaixaModel: ITCaixaModel): String;
    function excluir(ACaixaModel: ITCaixaModel): String;

    procedure obterLista;
    function carregaClasse(pIdCaixa: String): ITCaixaModel;
    function obterSaldo(pUsario: String): IFDDataset;

    procedure setParams(var pQry: TFDQuery; pCaixaModel: ITCaixaModel);

end;

implementation

uses
  System.Rtti;

{ TCaixa }


function TCaixaDao.carregaClasse(pIdCaixa: String): ITCaixaModel;
var
  lQry: TFDQuery;
  lModel: ITCaixaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCaixaModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from caixa where numero_cai = '+pIdCaixa);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_CAI            := lQry.FieldByName('NUMERO_CAI').AsString;
    lModel.objeto.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.objeto.DATA_CAI              := lQry.FieldByName('DATA_CAI').AsString;
    lModel.objeto.HORA_CAI              := lQry.FieldByName('HORA_CAI').AsString;
    lModel.objeto.HISTORICO_CAI         := lQry.FieldByName('HISTORICO_CAI').AsString;
    lModel.objeto.VALOR_CAI             := lQry.FieldByName('VALOR_CAI').AsString;
    lModel.objeto.USUARIO_CAI           := lQry.FieldByName('USUARIO_CAI').AsString;
    lModel.objeto.TIPO_CAI              := lQry.FieldByName('TIPO_CAI').AsString;
    lModel.objeto.CLIENTE_CAI           := lQry.FieldByName('CLIENTE_CAI').AsString;
    lModel.objeto.NUMERO_PED            := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.objeto.FATURA_CAI            := lQry.FieldByName('FATURA_CAI').AsString;
    lModel.objeto.PARCELA_CAI           := lQry.FieldByName('PARCELA_CAI').AsString;
    lModel.objeto.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.PORTADOR_CAI          := lQry.FieldByName('PORTADOR_CAI').AsString;
    lModel.objeto.CONCILIADO_CAI        := lQry.FieldByName('CONCILIADO_CAI').AsString;
    lModel.objeto.DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
    lModel.objeto.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.objeto.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.RECIBO                := lQry.FieldByName('RECIBO').AsString;
    lModel.objeto.RELATORIO             := lQry.FieldByName('RELATORIO').AsString;
    lModel.objeto.OBSERVACAO            := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.objeto.DR                    := lQry.FieldByName('DR').AsString;
    lModel.objeto.ID                    := lQry.FieldByName('ID').AsString;
    lModel.objeto.TROCO                 := lQry.FieldByName('TROCO').AsString;
    lModel.objeto.CARGA_ID              := lQry.FieldByName('CARGA_ID').AsString;
    lModel.objeto.TIPO                  := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
    lModel.objeto.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.objeto.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.objeto.OS_ID                 := lQry.FieldByName('OS_ID').AsString;
    lModel.objeto.PLACA                 := lQry.FieldByName('PLACA').AsString;
    lModel.objeto.TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
    lModel.objeto.TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
    lModel.objeto.COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
    lModel.objeto.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
    lModel.objeto.PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCaixaDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TCaixaDao.Destroy;
begin
  FCaixasLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TCaixaDao.incluir(ACaixaModel: ITCaixaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CAIXA','NUMERO_CAI', True);

  try
    lQry.SQL.Add(lSQL);
    ACaixaModel.objeto.NUMERO_CAI := vIConexao.Generetor('GEN_CAIXA');
    setParams(lQry, ACaixaModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_CAI').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaDao.alterar(ACaixaModel: ITCaixaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CAIXA','NUMERO_CAI');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACaixaModel);
    lQry.ExecSQL;

    Result := ACaixaModel.objeto.NUMERO_CAI;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaDao.excluir(ACaixaModel: ITCaixaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CAIXA where NUMERO_CAI = :NUMERO_CAI',[ACaixaModel.objeto.NUMERO_CAI]);
   lQry.ExecSQL;
   Result := ACaixaModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TCaixaDao.getNewIface(pIConexao: IConexao): ITCaixaDao;
begin
  Result := TImplObjetoOwner<TCaixaDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCaixaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and CAIXA.NUMERO_CAI = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TCaixaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from CAIXA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCaixaDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITCaixaModel;
begin
  lQry := vIConexao.CriarQuery;

  FCaixasLista := TCollections.CreateList<ITCaixaModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       caixa.*         '+
	    '  from caixa           '+
      ' where 1=1             ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TCaixaModel.getNewIface(vIConexao);
      FCaixasLista.Add(modelo);

      modelo.objeto.NUMERO_CAI           := lQry.FieldByName('NUMERO_CAI').AsString;
      modelo.objeto.CODIGO_CTA           := lQry.FieldByName('CODIGO_CTA').AsString;
      modelo.objeto.DATA_CAI             := lQry.FieldByName('DATA_CAI').AsString;
      modelo.objeto.HORA_CAI             := lQry.FieldByName('HORA_CAI').AsString;
      modelo.objeto.HISTORICO_CAI        := lQry.FieldByName('HISTORICO_CAI').AsString;
      modelo.objeto.VALOR_CAI            := lQry.FieldByName('VALOR_CAI').AsString;
      modelo.objeto.USUARIO_CAI          := lQry.FieldByName('USUARIO_CAI').AsString;
      modelo.objeto.TIPO_CAI             := lQry.FieldByName('TIPO_CAI').AsString;
      modelo.objeto.CLIENTE_CAI          := lQry.FieldByName('CLIENTE_CAI').AsString;
      modelo.objeto.NUMERO_PED           := lQry.FieldByName('NUMERO_PED').AsString;
      modelo.objeto.FATURA_CAI           := lQry.FieldByName('FATURA_CAI').AsString;
      modelo.objeto.PARCELA_CAI          := lQry.FieldByName('PARCELA_CAI').AsString;
      modelo.objeto.STATUS               := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.PORTADOR_CAI         := lQry.FieldByName('PORTADOR_CAI').AsString;
      modelo.objeto.CONCILIADO_CAI       := lQry.FieldByName('CONCILIADO_CAI').AsString;
      modelo.objeto.DATA_CON             := lQry.FieldByName('DATA_CON').AsString;
      modelo.objeto.CENTRO_CUSTO         := lQry.FieldByName('CENTRO_CUSTO').AsString;
      modelo.objeto.LOJA                 := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.RECIBO               := lQry.FieldByName('RECIBO').AsString;
      modelo.objeto.RELATORIO            := lQry.FieldByName('RELATORIO').AsString;
      modelo.objeto.OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      modelo.objeto.DR                   := lQry.FieldByName('DR').AsString;
      modelo.objeto.ID                   := lQry.FieldByName('ID').AsString;
      modelo.objeto.TROCO                := lQry.FieldByName('TROCO').AsString;
      modelo.objeto.CARGA_ID             := lQry.FieldByName('CARGA_ID').AsString;
      modelo.objeto.TIPO                 := lQry.FieldByName('TIPO').AsString;
      modelo.objeto.SUB_ID               := lQry.FieldByName('SUB_ID').AsString;
      modelo.objeto.LOCACAO_ID           := lQry.FieldByName('LOCACAO_ID').AsString;
      modelo.objeto.FUNCIONARIO_ID       := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      modelo.objeto.OS_ID                := lQry.FieldByName('OS_ID').AsString;
      modelo.objeto.PLACA                := lQry.FieldByName('PLACA').AsString;
      modelo.objeto.TRANSFERENCIA_ORIGEM := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
      modelo.objeto.TRANSFERENCIA_ID     := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
      modelo.objeto.COMPETENCIA          := lQry.FieldByName('COMPETENCIA').AsString;
      modelo.objeto.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.LOJA_REMOTO          := lQry.FieldByName('LOJA_REMOTO').AsString;
      modelo.objeto.PEDIDO_ID            := lQry.FieldByName('PEDIDO_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

function TCaixaDao.obterSaldo(pUsario: String): IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSQL :=
      'SELECT SaldoCaixaC - SaldoCaixaD AS SaldoTotal'                                                                                                +SLineBreak+
      'FROM ('                                                                                                                                        +SLineBreak+
      '    SELECT '                                                                                                                                   +SLineBreak+
      '        SUM(CASE WHEN c.tipo_cai = ''C'' AND c.usuario_cai = '+QuotedStr(pUsario)+' THEN c.valor_cai END) AS SaldoCaixaC,'                     +SLineBreak+
      '        SUM(CASE WHEN c.tipo_cai = ''D'' AND c.usuario_cai = '+QuotedStr(pUsario)+' THEN c.valor_cai END) AS SaldoCaixaD'                      +SLineBreak+
      '    FROM caixa c'                                                                                                                              +SLineBreak+
      '    WHERE CAST(c.data_cai + COALESCE(c.hora_cai, CURRENT_TIME) AS TIMESTAMP) BETWEEN ''0001-01-01 00:00:00'' AND CURRENT_DATE + CURRENT_TIME)' +SLineBreak;

      lQry.Open(lSQL);
      Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

procedure TCaixaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCaixaDao.SetCaixasLista;
begin
  FCaixasLista := Value;
end;

procedure TCaixaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCaixaDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TCaixaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCaixaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCaixaDao.setParams(var pQry: TFDQuery; pCaixaModel: ITCaixaModel);
begin
  vConstrutor.setParams('CAIXA',pQry,pCaixaModel.objeto);
end;

procedure TCaixaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCaixaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCaixaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
