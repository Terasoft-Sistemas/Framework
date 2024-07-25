unit ContaCorrenteDao;

interface

uses
  ContaCorrenteModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  Terasoft.Utils,

  Spring.Collections,
  Interfaces.Conexao;

type
  TContaCorrenteDao = class;

  ITContaCorrenteDao = IObject<TContaCorrenteDao>;

  TContaCorrenteDao = class
  private
    [weak] mySelf: ITContaCorrenteDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FContaCorrentesLista: IList<ITContaCorrenteModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    FIDBancoView: String;
    FSaldo: Real;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetContaCorrentesLista(const Value: IList<ITContaCorrenteModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);
    procedure setIDBancoView(const Value: String);
    procedure SetSaldo(const Value: Real);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITContaCorrenteDao;

    property ContaCorrentesLista: IList<ITContaCorrenteModel> read FContaCorrentesLista write SetContaCorrentesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property IDBancoView: String read FIDBancoView write setIDBancoView;
    property Saldo: Real read FSaldo write SetSaldo;
    function incluir(AContaCorrenteModel: ITContaCorrenteModel): String;
    function alterar(AContaCorrenteModel: ITContaCorrenteModel): String;
    function excluir(AContaCorrenteModel: ITContaCorrenteModel): String;

    procedure obterSaldo(pLoja: String);
    procedure obterLista;
    function carregaClasse(pId: String): ITContaCorrenteModel;

    procedure setParams(var pQry: TFDQuery; pContaCorrenteModel: ITContaCorrenteModel);

end;

implementation

uses
  System.Rtti, LojasModel;

{ TContaCorrente }


function TContaCorrenteDao.carregaClasse(pId: String): ITContaCorrenteModel;
var
  lQry: TFDQuery;
  lModel: ITContaCorrenteModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContaCorrenteModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from contacorrente where numero_cor = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_COR            := lQry.FieldByName('NUMERO_COR').AsString;
    lModel.objeto.DATA_COR              := lQry.FieldByName('DATA_COR').AsString;
    lModel.objeto.HORA_COR              := lQry.FieldByName('HORA_COR').AsString;
    lModel.objeto.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.objeto.CODIGO_BAN            := lQry.FieldByName('CODIGO_BAN').AsString;
    lModel.objeto.OBSERVACAO_COR        := lQry.FieldByName('OBSERVACAO_COR').AsString;
    lModel.objeto.VALOR_COR             := lQry.FieldByName('VALOR_COR').AsString;
    lModel.objeto.TIPO_CTA              := lQry.FieldByName('TIPO_CTA').AsString;
    lModel.objeto.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.CONCILIADO_COR        := lQry.FieldByName('CONCILIADO_COR').AsString;
    lModel.objeto.DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
    lModel.objeto.CLIENTE_COR           := lQry.FieldByName('CLIENTE_COR').AsString;
    lModel.objeto.FATURA_COR            := lQry.FieldByName('FATURA_COR').AsString;
    lModel.objeto.PARCELA_COR           := lQry.FieldByName('PARCELA_COR').AsString;
    lModel.objeto.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.objeto.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.NUMERO_CHQ            := lQry.FieldByName('NUMERO_CHQ').AsString;
    lModel.objeto.DR                    := lQry.FieldByName('DR').AsString;
    lModel.objeto.ID                    := lQry.FieldByName('ID').AsString;
    lModel.objeto.PORTADOR_COR          := lQry.FieldByName('PORTADOR_COR').AsString;
    lModel.objeto.TROCO                 := lQry.FieldByName('TROCO').AsString;
    lModel.objeto.USUARIO_COR           := lQry.FieldByName('USUARIO_COR').AsString;
    lModel.objeto.TIPO                  := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
    lModel.objeto.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.objeto.EMPRESTIMO_RECEBER_ID := lQry.FieldByName('EMPRESTIMO_RECEBER_ID').AsString;
    lModel.objeto.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.objeto.OS_NEW_ID             := lQry.FieldByName('OS_NEW_ID').AsString;
    lModel.objeto.CONCILIACAO_ID        := lQry.FieldByName('CONCILIACAO_ID').AsString;
    lModel.objeto.PLACA                 := lQry.FieldByName('PLACA').AsString;
    lModel.objeto.TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
    lModel.objeto.TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
    lModel.objeto.COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
    lModel.objeto.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.PAGARME_LOTE          := lQry.FieldByName('PAGARME_LOTE').AsString;
    lModel.objeto.LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
    lModel.objeto.PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.objeto.IUGU_ID               := lQry.FieldByName('IUGU_ID').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TContaCorrenteDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TContaCorrenteDao.Destroy;
begin
  FContaCorrentesLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TContaCorrenteDao.incluir(AContaCorrenteModel: ITContaCorrenteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTACORRENTE','NUMERO_COR', True);

  try
    lQry.SQL.Add(lSQL);
    AContaCorrenteModel.objeto.NUMERO_COR := vIConexao.Generetor('GEN_CONTACORRENTE');
    setParams(lQry, AContaCorrenteModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_COR').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContaCorrenteDao.alterar(AContaCorrenteModel: ITContaCorrenteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CONTACORRENTE','NUMERO_COR');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContaCorrenteModel);
    lQry.ExecSQL;

    Result := AContaCorrenteModel.objeto.NUMERO_COR;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContaCorrenteDao.excluir(AContaCorrenteModel: ITContaCorrenteModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CONTACORRENTE where NUMERO_COR = :NUMERO_COR',[AContaCorrenteModel.objeto.NUMERO_COR]);
   lQry.ExecSQL;
   Result := AContaCorrenteModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TContaCorrenteDao.getNewIface(pIConexao: IConexao): ITContaCorrenteDao;
begin
  Result := TImplObjetoOwner<TContaCorrenteDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TContaCorrenteDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and CONTACORRENTE.NUMERO_COR = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TContaCorrenteDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CONTACORRENTE where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TContaCorrenteDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITContaCorrenteModel;
begin
  lQry := vIConexao.CriarQuery;

  FContaCorrentesLista := TCollections.CreateList<ITContaCorrenteModel>;;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       contacorrente.*          '+
	    '  from contacorrente            '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TContaCorrenteModel.getNewIface(vIConexao);
      FContaCorrentesLista.Add(modelo);

      modelo.objeto.NUMERO_COR            := lQry.FieldByName('NUMERO_COR').AsString;
      modelo.objeto.DATA_COR              := lQry.FieldByName('DATA_COR').AsString;
      modelo.objeto.HORA_COR              := lQry.FieldByName('HORA_COR').AsString;
      modelo.objeto.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
      modelo.objeto.CODIGO_BAN            := lQry.FieldByName('CODIGO_BAN').AsString;
      modelo.objeto.OBSERVACAO_COR        := lQry.FieldByName('OBSERVACAO_COR').AsString;
      modelo.objeto.VALOR_COR             := lQry.FieldByName('VALOR_COR').AsString;
      modelo.objeto.TIPO_CTA              := lQry.FieldByName('TIPO_CTA').AsString;
      modelo.objeto.STATUS                := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.CONCILIADO_COR        := lQry.FieldByName('CONCILIADO_COR').AsString;
      modelo.objeto.DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
      modelo.objeto.CLIENTE_COR           := lQry.FieldByName('CLIENTE_COR').AsString;
      modelo.objeto.FATURA_COR            := lQry.FieldByName('FATURA_COR').AsString;
      modelo.objeto.PARCELA_COR           := lQry.FieldByName('PARCELA_COR').AsString;
      modelo.objeto.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
      modelo.objeto.LOJA                  := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.NUMERO_CHQ            := lQry.FieldByName('NUMERO_CHQ').AsString;
      modelo.objeto.DR                    := lQry.FieldByName('DR').AsString;
      modelo.objeto.ID                    := lQry.FieldByName('ID').AsString;
      modelo.objeto.PORTADOR_COR          := lQry.FieldByName('PORTADOR_COR').AsString;
      modelo.objeto.TROCO                 := lQry.FieldByName('TROCO').AsString;
      modelo.objeto.USUARIO_COR           := lQry.FieldByName('USUARIO_COR').AsString;
      modelo.objeto.TIPO                  := lQry.FieldByName('TIPO').AsString;
      modelo.objeto.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
      modelo.objeto.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
      modelo.objeto.EMPRESTIMO_RECEBER_ID := lQry.FieldByName('EMPRESTIMO_RECEBER_ID').AsString;
      modelo.objeto.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      modelo.objeto.OS_NEW_ID             := lQry.FieldByName('OS_NEW_ID').AsString;
      modelo.objeto.CONCILIACAO_ID        := lQry.FieldByName('CONCILIACAO_ID').AsString;
      modelo.objeto.PLACA                 := lQry.FieldByName('PLACA').AsString;
      modelo.objeto.TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
      modelo.objeto.TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
      modelo.objeto.COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
      modelo.objeto.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.PAGARME_LOTE          := lQry.FieldByName('PAGARME_LOTE').AsString;
      modelo.objeto.LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
      modelo.objeto.PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;
      modelo.objeto.IUGU_ID               := lQry.FieldByName('IUGU_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TContaCorrenteDao.obterSaldo(pLoja: String);
var
  lQry: TFDQuery;
  lSql: String;
begin
  try
    lSql := ' select                                    '+sLineBreak+
            '       SUM(case c.tipo_cta                 '+sLineBreak+
            '       when ''D'' then -1*(c.valor_cor)    '+sLineBreak+
            '       when ''C'' then c.valor_cor         '+sLineBreak+
            '       end) SALDO                          '+sLineBreak+
            '  from contacorrente c                     '+sLineBreak+
            ' where 1=1                                 '+sLineBreak;


    if FIDBancoView <> '' then
    begin
      if Pos(',', FIDBancoView) <= 0 then
        lSQL := lSQL + ' and c.CODIGO_BAN = ' + FIDBancoView
      else
        lSQL := lSQL + ' and c.CODIGO_BAN in (' + FIDBancoView + ')';
    end;

    vIConexao.ConfigConexaoExterna(IIF(pLoja <> '', pLoja, vIConexao.getEmpresa.LOJA));
    lQry := vIConexao.CriarQueryExterna;
    lQry.Open(lSQL);

    FSaldo := lQry.FieldByName('SALDO').AsFloat;

  finally
    lQry.Free;
  end;
end;

procedure TContaCorrenteDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContaCorrenteDao.SetContaCorrentesLista;
begin
  FContaCorrentesLista := Value;
end;

procedure TContaCorrenteDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContaCorrenteDao.setIDBancoView(const Value: String);
begin
  FIDBancoView := Value;
end;

procedure TContaCorrenteDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TContaCorrenteDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContaCorrenteDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContaCorrenteDao.setParams(var pQry: TFDQuery; pContaCorrenteModel: ITContaCorrenteModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONTACORRENTE');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TContaCorrenteModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pContaCorrenteModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pContaCorrenteModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TContaCorrenteDao.SetSaldo(const Value: Real);
begin
  FSaldo := Value;
end;

procedure TContaCorrenteDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContaCorrenteDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContaCorrenteDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
