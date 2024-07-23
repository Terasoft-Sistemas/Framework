unit ContaCorrenteDao;

interface

uses
  ContaCorrenteModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Spring.Collections,
  Interfaces.Conexao;

type
  TContaCorrenteDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FContaCorrentesLista: IList<TContaCorrenteModel>;
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
    procedure SetContaCorrentesLista(const Value: IList<TContaCorrenteModel>);
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
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ContaCorrentesLista: IList<TContaCorrenteModel> read FContaCorrentesLista write SetContaCorrentesLista;
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
    function incluir(AContaCorrenteModel: TContaCorrenteModel): String;
    function alterar(AContaCorrenteModel: TContaCorrenteModel): String;
    function excluir(AContaCorrenteModel: TContaCorrenteModel): String;

    procedure obterSaldo(pLoja: String);
    procedure obterLista;
    function carregaClasse(pId: String): TContaCorrenteModel;

    procedure setParams(var pQry: TFDQuery; pContaCorrenteModel: TContaCorrenteModel);

end;

implementation

uses
  System.Rtti, LojasModel;

{ TContaCorrente }


function TContaCorrenteDao.carregaClasse(pId: String): TContaCorrenteModel;
var
  lQry: TFDQuery;
  lModel: TContaCorrenteModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContaCorrenteModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from contacorrente where numero_cor = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_COR            := lQry.FieldByName('NUMERO_COR').AsString;
    lModel.DATA_COR              := lQry.FieldByName('DATA_COR').AsString;
    lModel.HORA_COR              := lQry.FieldByName('HORA_COR').AsString;
    lModel.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.CODIGO_BAN            := lQry.FieldByName('CODIGO_BAN').AsString;
    lModel.OBSERVACAO_COR        := lQry.FieldByName('OBSERVACAO_COR').AsString;
    lModel.VALOR_COR             := lQry.FieldByName('VALOR_COR').AsString;
    lModel.TIPO_CTA              := lQry.FieldByName('TIPO_CTA').AsString;
    lModel.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.CONCILIADO_COR        := lQry.FieldByName('CONCILIADO_COR').AsString;
    lModel.DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
    lModel.CLIENTE_COR           := lQry.FieldByName('CLIENTE_COR').AsString;
    lModel.FATURA_COR            := lQry.FieldByName('FATURA_COR').AsString;
    lModel.PARCELA_COR           := lQry.FieldByName('PARCELA_COR').AsString;
    lModel.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.NUMERO_CHQ            := lQry.FieldByName('NUMERO_CHQ').AsString;
    lModel.DR                    := lQry.FieldByName('DR').AsString;
    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.PORTADOR_COR          := lQry.FieldByName('PORTADOR_COR').AsString;
    lModel.TROCO                 := lQry.FieldByName('TROCO').AsString;
    lModel.USUARIO_COR           := lQry.FieldByName('USUARIO_COR').AsString;
    lModel.TIPO                  := lQry.FieldByName('TIPO').AsString;
    lModel.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
    lModel.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.EMPRESTIMO_RECEBER_ID := lQry.FieldByName('EMPRESTIMO_RECEBER_ID').AsString;
    lModel.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.OS_NEW_ID             := lQry.FieldByName('OS_NEW_ID').AsString;
    lModel.CONCILIACAO_ID        := lQry.FieldByName('CONCILIACAO_ID').AsString;
    lModel.PLACA                 := lQry.FieldByName('PLACA').AsString;
    lModel.TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
    lModel.TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
    lModel.COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.PAGARME_LOTE          := lQry.FieldByName('PAGARME_LOTE').AsString;
    lModel.LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
    lModel.PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.IUGU_ID               := lQry.FieldByName('IUGU_ID').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TContaCorrenteDao.Create(pIConexao : IConexao);
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

function TContaCorrenteDao.incluir(AContaCorrenteModel: TContaCorrenteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTACORRENTE','NUMERO_COR', True);

  try
    lQry.SQL.Add(lSQL);
    AContaCorrenteModel.NUMERO_COR := vIConexao.Generetor('GEN_CONTACORRENTE');
    setParams(lQry, AContaCorrenteModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_COR').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContaCorrenteDao.alterar(AContaCorrenteModel: TContaCorrenteModel): String;
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

    Result := AContaCorrenteModel.NUMERO_COR;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContaCorrenteDao.excluir(AContaCorrenteModel: TContaCorrenteModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CONTACORRENTE where NUMERO_COR = :NUMERO_COR',[AContaCorrenteModel.NUMERO_COR]);
   lQry.ExecSQL;
   Result := AContaCorrenteModel.ID;

  finally
    lQry.Free;
  end;
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
  modelo: TContaCorrenteModel;
begin
  lQry := vIConexao.CriarQuery;

  FContaCorrentesLista := TCollections.CreateList<TContaCorrenteModel>(true);;

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
      modelo := TContaCorrenteModel.Create(vIConexao);
      FContaCorrentesLista.Add(modelo);

      modelo.NUMERO_COR            := lQry.FieldByName('NUMERO_COR').AsString;
      modelo.DATA_COR              := lQry.FieldByName('DATA_COR').AsString;
      modelo.HORA_COR              := lQry.FieldByName('HORA_COR').AsString;
      modelo.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
      modelo.CODIGO_BAN            := lQry.FieldByName('CODIGO_BAN').AsString;
      modelo.OBSERVACAO_COR        := lQry.FieldByName('OBSERVACAO_COR').AsString;
      modelo.VALOR_COR             := lQry.FieldByName('VALOR_COR').AsString;
      modelo.TIPO_CTA              := lQry.FieldByName('TIPO_CTA').AsString;
      modelo.STATUS                := lQry.FieldByName('STATUS').AsString;
      modelo.CONCILIADO_COR        := lQry.FieldByName('CONCILIADO_COR').AsString;
      modelo.DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
      modelo.CLIENTE_COR           := lQry.FieldByName('CLIENTE_COR').AsString;
      modelo.FATURA_COR            := lQry.FieldByName('FATURA_COR').AsString;
      modelo.PARCELA_COR           := lQry.FieldByName('PARCELA_COR').AsString;
      modelo.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
      modelo.LOJA                  := lQry.FieldByName('LOJA').AsString;
      modelo.NUMERO_CHQ            := lQry.FieldByName('NUMERO_CHQ').AsString;
      modelo.DR                    := lQry.FieldByName('DR').AsString;
      modelo.ID                    := lQry.FieldByName('ID').AsString;
      modelo.PORTADOR_COR          := lQry.FieldByName('PORTADOR_COR').AsString;
      modelo.TROCO                 := lQry.FieldByName('TROCO').AsString;
      modelo.USUARIO_COR           := lQry.FieldByName('USUARIO_COR').AsString;
      modelo.TIPO                  := lQry.FieldByName('TIPO').AsString;
      modelo.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
      modelo.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
      modelo.EMPRESTIMO_RECEBER_ID := lQry.FieldByName('EMPRESTIMO_RECEBER_ID').AsString;
      modelo.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      modelo.OS_NEW_ID             := lQry.FieldByName('OS_NEW_ID').AsString;
      modelo.CONCILIACAO_ID        := lQry.FieldByName('CONCILIACAO_ID').AsString;
      modelo.PLACA                 := lQry.FieldByName('PLACA').AsString;
      modelo.TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
      modelo.TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
      modelo.COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
      modelo.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
      modelo.PAGARME_LOTE          := lQry.FieldByName('PAGARME_LOTE').AsString;
      modelo.LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
      modelo.PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;
      modelo.IUGU_ID               := lQry.FieldByName('IUGU_ID').AsString;

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

procedure TContaCorrenteDao.setParams(var pQry: TFDQuery; pContaCorrenteModel: TContaCorrenteModel);
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pContaCorrenteModel).AsString = '',
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
