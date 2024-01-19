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
  Interfaces.Conexao;

type
  TContaCorrenteDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FContaCorrentesLista: TObjectList<TContaCorrenteModel>;
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
    procedure SetContaCorrentesLista(const Value: TObjectList<TContaCorrenteModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ContaCorrentesLista: TObjectList<TContaCorrenteModel> read FContaCorrentesLista write SetContaCorrentesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(AContaCorrenteModel: TContaCorrenteModel): String;
    function alterar(AContaCorrenteModel: TContaCorrenteModel): String;
    function excluir(AContaCorrenteModel: TContaCorrenteModel): String;
	
    procedure obterLista;
    function carregaClasse(pId: String): TContaCorrenteModel;

    procedure setParams(var pQry: TFDQuery; pContaCorrenteModel: TContaCorrenteModel);

end;

implementation

uses
  System.Rtti;

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
    lQry.ParamByName('NUMERO_COR').Value := vIConexao.Generetor('GEN_CONTACORRENTE');
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
    lQry.ParamByName('NUMERO_COR').Value := ifThen(AContaCorrenteModel.DATA_COR = '', Unassigned, AContaCorrenteModel.DATA_COR);
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FContaCorrentesLista := TObjectList<TContaCorrenteModel>.Create;

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

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FContaCorrentesLista.Add(TContaCorrenteModel.Create(vIConexao));

      i := FContaCorrentesLista.Count -1;

      FContaCorrentesLista[i].NUMERO_COR            := lQry.FieldByName('NUMERO_COR').AsString;
      FContaCorrentesLista[i].DATA_COR              := lQry.FieldByName('DATA_COR').AsString;
      FContaCorrentesLista[i].HORA_COR              := lQry.FieldByName('HORA_COR').AsString;
      FContaCorrentesLista[i].CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
      FContaCorrentesLista[i].CODIGO_BAN            := lQry.FieldByName('CODIGO_BAN').AsString;
      FContaCorrentesLista[i].OBSERVACAO_COR        := lQry.FieldByName('OBSERVACAO_COR').AsString;
      FContaCorrentesLista[i].VALOR_COR             := lQry.FieldByName('VALOR_COR').AsString;
      FContaCorrentesLista[i].TIPO_CTA              := lQry.FieldByName('TIPO_CTA').AsString;
      FContaCorrentesLista[i].STATUS                := lQry.FieldByName('STATUS').AsString;
      FContaCorrentesLista[i].CONCILIADO_COR        := lQry.FieldByName('CONCILIADO_COR').AsString;
      FContaCorrentesLista[i].DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
      FContaCorrentesLista[i].CLIENTE_COR           := lQry.FieldByName('CLIENTE_COR').AsString;
      FContaCorrentesLista[i].FATURA_COR            := lQry.FieldByName('FATURA_COR').AsString;
      FContaCorrentesLista[i].PARCELA_COR           := lQry.FieldByName('PARCELA_COR').AsString;
      FContaCorrentesLista[i].CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
      FContaCorrentesLista[i].LOJA                  := lQry.FieldByName('LOJA').AsString;
      FContaCorrentesLista[i].NUMERO_CHQ            := lQry.FieldByName('NUMERO_CHQ').AsString;
      FContaCorrentesLista[i].DR                    := lQry.FieldByName('DR').AsString;
      FContaCorrentesLista[i].ID                    := lQry.FieldByName('ID').AsString;
      FContaCorrentesLista[i].PORTADOR_COR          := lQry.FieldByName('PORTADOR_COR').AsString;
      FContaCorrentesLista[i].TROCO                 := lQry.FieldByName('TROCO').AsString;
      FContaCorrentesLista[i].USUARIO_COR           := lQry.FieldByName('USUARIO_COR').AsString;
      FContaCorrentesLista[i].TIPO                  := lQry.FieldByName('TIPO').AsString;
      FContaCorrentesLista[i].SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
      FContaCorrentesLista[i].LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
      FContaCorrentesLista[i].EMPRESTIMO_RECEBER_ID := lQry.FieldByName('EMPRESTIMO_RECEBER_ID').AsString;
      FContaCorrentesLista[i].FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      FContaCorrentesLista[i].OS_NEW_ID             := lQry.FieldByName('OS_NEW_ID').AsString;
      FContaCorrentesLista[i].CONCILIACAO_ID        := lQry.FieldByName('CONCILIACAO_ID').AsString;
      FContaCorrentesLista[i].PLACA                 := lQry.FieldByName('PLACA').AsString;
      FContaCorrentesLista[i].TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
      FContaCorrentesLista[i].TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
      FContaCorrentesLista[i].COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
      FContaCorrentesLista[i].SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
      FContaCorrentesLista[i].PAGARME_LOTE          := lQry.FieldByName('PAGARME_LOTE').AsString;
      FContaCorrentesLista[i].LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
      FContaCorrentesLista[i].PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;
      FContaCorrentesLista[i].IUGU_ID               := lQry.FieldByName('IUGU_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TContaCorrenteDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContaCorrenteDao.SetContaCorrentesLista(const Value: TObjectList<TContaCorrenteModel>);
begin
  FContaCorrentesLista := Value;
end;

procedure TContaCorrenteDao.SetID(const Value: Variant);
begin
  FID := Value;
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
  lTabela : TFDMemTable;
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
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pContaCorrenteModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
