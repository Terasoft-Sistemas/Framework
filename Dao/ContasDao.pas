unit ContasDao;

interface

uses
  ContasModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TContasDao = class

  private
    vIConexao   : IConexao;
    vConstrutor  : TConstrutorDao;

    FContassLista: TObjectList<TContasModel>;
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
    procedure SetContassLista(const Value: TObjectList<TContasModel>);
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

    property ContassLista: TObjectList<TContasModel> read FContassLista write SetContassLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AContasModel: TContasModel): String;
    function alterar(AContasModel: TContasModel): String;
    function excluir(AContasModel: TContasModel): String;
    function carregaClasse(pID : String) : TContasModel;
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pContasModel: TContasModel);

end;

implementation

uses
  System.Rtti;

{ TContas }

function TContasDao.carregaClasse(pID: String): TContasModel;
var
  lQry: TFDQuery;
  lModel: TContasModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContasModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CONTAS where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                           := lQry.FieldByName('ID').AsString;
    lModel.CLASSIFICACAO                := lQry.FieldByName('CLASSIFICACAO').AsString;
    lModel.CODIGO_CTA                   := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.NOME_CTA                     := lQry.FieldByName('NOME_CTA').AsString;
    lModel.TIPO_CTA                     := lQry.FieldByName('TIPO_CTA').AsString;
    lModel.DR_CTA                       := lQry.FieldByName('DR_CTA').AsString;
    lModel.USUARIO_CTA                  := lQry.FieldByName('USUARIO_CTA').AsString;
    lModel.BANCO_CTA                    := lQry.FieldByName('BANCO_CTA').AsString;
    lModel.BAIXAPAGAR_CTA               := lQry.FieldByName('BAIXAPAGAR_CTA').AsString;
    lModel.TIPOSEMDR_CTA                := lQry.FieldByName('TIPOSEMDR_CTA').AsString;
    lModel.TIPOSEMDR_CTA_RECEBIMENTO    := lQry.FieldByName('TIPOSEMDR_CTA_RECEBIMENTO').AsString;
    lModel.GRUPO_CTA                    := lQry.FieldByName('GRUPO_CTA').AsString;
    lModel.SUBGRUPO_CTA                 := lQry.FieldByName('SUBGRUPO_CTA').AsString;
    lModel.CENTROCUSTO_CTA              := lQry.FieldByName('CENTROCUSTO_CTA').AsString;
    lModel.EXTRATO_CTA                  := lQry.FieldByName('EXTRATO_CTA').AsString;
    lModel.ORDEM                        := lQry.FieldByName('ORDEM').AsString;
    lModel.LOJA                         := lQry.FieldByName('LOJA').AsString;
    lModel.EMPRESTIMO_CTA               := lQry.FieldByName('EMPRESTIMO_CTA').AsString;
    lModel.STATUS                       := lQry.FieldByName('STATUS').AsString;
    lModel.CREDITO_ICMS                 := lQry.FieldByName('CREDITO_ICMS').AsString;
    lModel.RECEITAXDESPESAS             := lQry.FieldByName('RECEITAXDESPESAS').AsString;
    lModel.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
    lModel.CREDITO_CLIENTE_CTA          := lQry.FieldByName('CREDITO_CLIENTE_CTA').AsString;
    lModel.CREDITO_FORNECEDOR_CTA       := lQry.FieldByName('CREDITO_FORNECEDOR_CTA').AsString;
    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TContasDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TContasDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TContasDao.incluir(AContasModel: TContasModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTAS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasDao.alterar(AContasModel: TContasModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CONTAS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasModel);
    lQry.ExecSQL;

    Result := AContasModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasDao.excluir(AContasModel: TContasModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CONTAS where ID = :ID',[AContasModel.ID]);
   lQry.ExecSQL;
   Result := AContasModel.ID;

  finally
    lQry.Free;
  end;
end;

function TContasDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TContasDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from CONTAS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TContasDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin

  lQry := vIConexao.CriarQuery;

  FContassLista := TObjectList<TContasModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       contas.*                 '+
	    '  from contas                   '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FContassLista.Add(TContasModel.Create(vIConexao));

      i := FContassLista.Count -1;

      FContassLista[i].ID                         := lQry.FieldByName('ID').AsString;
      FContassLista[i].CLASSIFICACAO              := lQry.FieldByName('CLASSIFICACAO').AsString;
      FContassLista[i].CODIGO_CTA                 := lQry.FieldByName('CODIGO_CTA').AsString;
      FContassLista[i].NOME_CTA                   := lQry.FieldByName('NOME_CTA').AsString;
      FContassLista[i].TIPO_CTA                   := lQry.FieldByName('TIPO_CTA').AsString;
      FContassLista[i].DR_CTA                     := lQry.FieldByName('DR_CTA').AsString;
      FContassLista[i].USUARIO_CTA                := lQry.FieldByName('USUARIO_CTA').AsString;
      FContassLista[i].BANCO_CTA                  := lQry.FieldByName('BANCO_CTA').AsString;
      FContassLista[i].BAIXAPAGAR_CTA             := lQry.FieldByName('BAIXAPAGAR_CTA').AsString;
      FContassLista[i].TIPOSEMDR_CTA              := lQry.FieldByName('TIPOSEMDR_CTA').AsString;
      FContassLista[i].TIPOSEMDR_CTA_RECEBIMENTO  := lQry.FieldByName('TIPOSEMDR_CTA_RECEBIMENTO').AsString;
      FContassLista[i].GRUPO_CTA                  := lQry.FieldByName('GRUPO_CTA').AsString;
      FContassLista[i].SUBGRUPO_CTA               := lQry.FieldByName('SUBGRUPO_CTA').AsString;
      FContassLista[i].CENTROCUSTO_CTA            := lQry.FieldByName('CENTROCUSTO_CTA').AsString;
      FContassLista[i].EXTRATO_CTA                := lQry.FieldByName('EXTRATO_CTA').AsString;
      FContassLista[i].ORDEM                      := lQry.FieldByName('ORDEM').AsString;
      FContassLista[i].LOJA                       := lQry.FieldByName('LOJA').AsString;
      FContassLista[i].EMPRESTIMO_CTA             := lQry.FieldByName('EMPRESTIMO_CTA').AsString;
      FContassLista[i].STATUS                     := lQry.FieldByName('STATUS').AsString;
      FContassLista[i].CREDITO_ICMS               := lQry.FieldByName('CREDITO_ICMS').AsString;
      FContassLista[i].RECEITAXDESPESAS           := lQry.FieldByName('RECEITAXDESPESAS').AsString;
      FContassLista[i].SYSTIME                    := lQry.FieldByName('SYSTIME').AsString;
      FContassLista[i].CREDITO_CLIENTE_CTA        := lQry.FieldByName('CREDITO_CLIENTE_CTA').AsString;
      FContassLista[i].CREDITO_FORNECEDOR_CTA     := lQry.FieldByName('CREDITO_FORNECEDOR_CTA').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;

  end;
end;

procedure TContasDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasDao.SetContassLista(const Value: TObjectList<TContasModel>);
begin
  FContassLista := Value;
end;

procedure TContasDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasDao.setParams(var pQry: TFDQuery; pContasModel: TContasModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONTAS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TContasModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pContasModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pContasModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TContasDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
