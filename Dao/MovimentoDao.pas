unit MovimentoDao;

interface

uses
  MovimentoModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TMovimentoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FMovimentosLista: TObjectList<TMovimentoModel>;
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
    procedure SetMovimentosLista(const Value: TObjectList<TMovimentoModel>);
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

    property MovimentosLista: TObjectList<TMovimentoModel> read FMovimentosLista write SetMovimentosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pMovimentoModel: TMovimentoModel): String;
    function alterar(pMovimentoModel: TMovimentoModel): String;
    function excluir(pMovimentoModel: TMovimentoModel): String;

    procedure obterLista;
    function carregaClasse(pId: String): TMovimentoModel;
    procedure setParams(var pQry: TFDQuery; pMovimentoModel: TMovimentoModel);

end;

implementation

uses
  System.Rtti;

{ TMovimento }

function TMovimentoDao.carregaClasse(pId: String): TMovimentoModel;
var
  lQry: TFDQuery;
  lModel: TMovimentoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TMovimentoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open(' select * from movimento where id = '+ pId);

    if lQry.IsEmpty then
      Exit;

    lModel.DOCUMENTO_MOV  := lQry.FieldByName('DOCUMENTO_MOV').AsString;
    lModel.CODIGO_PRO     := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.CODIGO_FOR     := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.OBS_MOV        := lQry.FieldByName('OBS_MOV').AsString;
    lModel.TIPO_DOC       := lQry.FieldByName('TIPO_DOC').AsString;
    lModel.DATA_MOV       := lQry.FieldByName('DATA_MOV').AsString;
    lModel.DATA_DOC       := lQry.FieldByName('DATA_DOC').AsString;
    lModel.QUANTIDADE_MOV := lQry.FieldByName('QUANTIDADE_MOV').AsString;
    lModel.VALOR_MOV      := lQry.FieldByName('VALOR_MOV').AsString;
    lModel.CUSTO_ATUAL    := lQry.FieldByName('CUSTO_ATUAL').AsString;
    lModel.VENDA_ATUAL    := lQry.FieldByName('VENDA_ATUAL').AsString;
    lModel.STATUS         := lQry.FieldByName('STATUS').AsString;
    lModel.LOJA           := lQry.FieldByName('LOJA').AsString;
    lModel.ID             := lQry.FieldByName('ID').AsString;
    lModel.USUARIO_ID     := lQry.FieldByName('USUARIO_ID').AsString;
    lModel.DATAHORA       := lQry.FieldByName('DATAHORA').AsString;
    lModel.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;
    lModel.TABELA_ORIGEM  := lQry.FieldByName('TABELA_ORIGEM').AsString;
    lModel.ID_ORIGEM      := lQry.FieldByName('ID_ORIGEM').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TMovimentoDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TMovimentoDao.Destroy;
begin

  inherited;
end;

function TMovimentoDao.incluir(pMovimentoModel: TMovimentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('MOVIMENTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMovimentoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMovimentoDao.alterar(pMovimentoModel: TMovimentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=   vConstrutor.gerarUpdate('MOVIMENTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMovimentoModel);
    lQry.ExecSQL;

    Result := pMovimentoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMovimentoDao.excluir(pMovimentoModel: TMovimentoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from MOVIMENTO where ID = :ID',[pMovimentoModel.ID]);
   lQry.ExecSQL;
   Result := pMovimentoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TMovimentoDao.where: String;
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

procedure TMovimentoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from MOVIMENTO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TMovimentoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FMovimentosLista := TObjectList<TMovimentoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       movimento.*         '+
	    '  from movimento           '+
      ' where 1=1                 ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FMovimentosLista.Add(TMovimentoModel.Create(vIConexao));

      i := FMovimentosLista.Count -1;

      FMovimentosLista[i].DOCUMENTO_MOV   := lQry.FieldByName('DOCUMENTO_MOV').AsString;
      FMovimentosLista[i].CODIGO_PRO      := lQry.FieldByName('CODIGO_PRO').AsString;
      FMovimentosLista[i].CODIGO_FOR      := lQry.FieldByName('CODIGO_FOR').AsString;
      FMovimentosLista[i].OBS_MOV         := lQry.FieldByName('OBS_MOV').AsString;
      FMovimentosLista[i].TIPO_DOC        := lQry.FieldByName('TIPO_DOC').AsString;
      FMovimentosLista[i].DATA_MOV        := lQry.FieldByName('DATA_MOV').AsString;
      FMovimentosLista[i].DATA_DOC        := lQry.FieldByName('DATA_DOC').AsString;
      FMovimentosLista[i].QUANTIDADE_MOV  := lQry.FieldByName('QUANTIDADE_MOV').AsString;
      FMovimentosLista[i].VALOR_MOV       := lQry.FieldByName('VALOR_MOV').AsString;
      FMovimentosLista[i].CUSTO_ATUAL     := lQry.FieldByName('CUSTO_ATUAL').AsString;
      FMovimentosLista[i].VENDA_ATUAL     := lQry.FieldByName('VENDA_ATUAL').AsString;
      FMovimentosLista[i].STATUS          := lQry.FieldByName('STATUS').AsString;
      FMovimentosLista[i].LOJA            := lQry.FieldByName('LOJA').AsString;
      FMovimentosLista[i].ID              := lQry.FieldByName('ID').AsString;
      FMovimentosLista[i].USUARIO_ID      := lQry.FieldByName('USUARIO_ID').AsString;
      FMovimentosLista[i].DATAHORA        := lQry.FieldByName('DATAHORA').AsString;
      FMovimentosLista[i].SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
      FMovimentosLista[i].TABELA_ORIGEM   := lQry.FieldByName('TABELA_ORIGEM').AsString;
      FMovimentosLista[i].ID_ORIGEM       := lQry.FieldByName('ID_ORIGEM').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TMovimentoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMovimentoDao.SetMovimentosLista(const Value: TObjectList<TMovimentoModel>);
begin
  FMovimentosLista := Value;
end;

procedure TMovimentoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMovimentoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TMovimentoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMovimentoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TMovimentoDao.setParams(var pQry: TFDQuery; pMovimentoModel: TMovimentoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('MOVIMENTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TMovimentoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pMovimentoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pMovimentoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TMovimentoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TMovimentoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TMovimentoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
