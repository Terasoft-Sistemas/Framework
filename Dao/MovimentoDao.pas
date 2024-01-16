unit MovimentoDao;

interface

uses
  MovimentoModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto;

type
  TMovimentoDao = class

  private
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

    function montaCondicaoQuery: String;

  public
    constructor Create;
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

    function incluir(AMovimentoModel: TMovimentoModel): String;
    function alterar(AMovimentoModel: TMovimentoModel): String;
    function excluir(AMovimentoModel: TMovimentoModel): String;
	
    procedure obterLista;
    function carregaClasse(pId: String): TMovimentoModel;
    procedure setParams(var pQry: TFDQuery; pMovimentoModel: TMovimentoModel);

end;

implementation

uses
  VariaveisGlobais;

{ TMovimento }

function TMovimentoDao.carregaClasse(pId: String): TMovimentoModel;
var
  lQry: TFDQuery;
  lModel: TMovimentoModel;
begin
  lQry     := xConexao.CriarQuery;
  lModel   := TMovimentoModel.Create;
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

constructor TMovimentoDao.Create;
begin

end;

destructor TMovimentoDao.Destroy;
begin

  inherited;
end;

function TMovimentoDao.incluir(AMovimentoModel: TMovimentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

  lSQL := '  insert into movimento (documento_mov,      '+SLineBreak+
          '                         codigo_pro,         '+SLineBreak+
          '                         codigo_for,         '+SLineBreak+
          '                         obs_mov,            '+SLineBreak+
          '                         tipo_doc,           '+SLineBreak+
          '                         data_mov,           '+SLineBreak+
          '                         data_doc,           '+SLineBreak+
          '                         quantidade_mov,     '+SLineBreak+
          '                         valor_mov,          '+SLineBreak+
          '                         custo_atual,        '+SLineBreak+
          '                         venda_atual,        '+SLineBreak+
          '                         status,             '+SLineBreak+
          '                         loja,               '+SLineBreak+
          '                         usuario_id,         '+SLineBreak+
          '                         datahora,           '+SLineBreak+
          '                         tabela_origem,      '+SLineBreak+
          '                         id_origem)          '+SLineBreak+
          '  values (:documento_mov,                    '+SLineBreak+
          '          :codigo_pro,                       '+SLineBreak+
          '          :codigo_for,                       '+SLineBreak+
          '          :obs_mov,                          '+SLineBreak+
          '          :tipo_doc,                         '+SLineBreak+
          '          :data_mov,                         '+SLineBreak+
          '          :data_doc,                         '+SLineBreak+
          '          :quantidade_mov,                   '+SLineBreak+
          '          :valor_mov,                        '+SLineBreak+
          '          :custo_atual,                      '+SLineBreak+
          '          :venda_atual,                      '+SLineBreak+
          '          :status,                           '+SLineBreak+
          '          :loja,                             '+SLineBreak+
          '          :usuario_id,                       '+SLineBreak+
          '          :datahora,                         '+SLineBreak+
          '          :tabela_origem,                    '+SLineBreak+
          '          :id_origem)                        '+SLineBreak+
          ' returning ID                                '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AMovimentoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
    lConexao.Free;
  end;
end;

function TMovimentoDao.alterar(AMovimentoModel: TMovimentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

  lSQL :=   '  update movimento                           '+SLineBreak+
            '     set documento_mov = :documento_mov,     '+SLineBreak+
            '         codigo_pro = :codigo_pro,           '+SLineBreak+
            '         codigo_for = :codigo_for,           '+SLineBreak+
            '         obs_mov = :obs_mov,                 '+SLineBreak+
            '         tipo_doc = :tipo_doc,               '+SLineBreak+
            '         data_mov = :data_mov,               '+SLineBreak+
            '         data_doc = :data_doc,               '+SLineBreak+
            '         quantidade_mov = :quantidade_mov,   '+SLineBreak+
            '         valor_mov = :valor_mov,             '+SLineBreak+
            '         custo_atual = :custo_atual,         '+SLineBreak+
            '         venda_atual = :venda_atual,         '+SLineBreak+
            '         status = :status,                   '+SLineBreak+
            '         usuario_id = :usuario_id,           '+SLineBreak+
            '         datahora = :datahora,               '+SLineBreak+
            '         tabela_origem = :tabela_origem,     '+SLineBreak+
            '         id_origem = :id_origem,             '+SLineBreak+
            '         loja = :loja                        '+SLineBreak+
            '   where (id = :id)                          '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AMovimentoModel);
    lQry.ParamByName('id').Value  := AMovimentoModel.ID;
    lQry.ExecSQL;

    Result := AMovimentoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
    lConexao.Free;
  end;
end;

function TMovimentoDao.excluir(AMovimentoModel: TMovimentoModel): String;
var
  lQry: TFDQuery;
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from movimento where ID = :ID',[AMovimentoModel.ID]);
   lQry.ExecSQL;
   Result := AMovimentoModel.ID;

  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

function TMovimentoDao.montaCondicaoQuery: String;
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
  lConexao: TConexao;
begin
  try
    lConexao := TConexao.Create;
    lQry := lConexao.CriarQuery;

    lSql := 'select count(*) records From movimento where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

procedure TMovimentoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

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

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FMovimentosLista.Add(TMovimentoModel.Create);

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
    lConexao.Free;
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
begin
  pQry.ParamByName('documento_mov').Value  := IIF(pMovimentoModel.DOCUMENTO_MOV   = '', Unassigned, pMovimentoModel.DOCUMENTO_MOV);
  pQry.ParamByName('codigo_pro').Value     := IIF(pMovimentoModel.CODIGO_PRO      = '', Unassigned, pMovimentoModel.CODIGO_PRO);
  pQry.ParamByName('codigo_for').Value     := IIF(pMovimentoModel.CODIGO_FOR      = '', Unassigned, pMovimentoModel.CODIGO_FOR);
  pQry.ParamByName('obs_mov').Value        := IIF(pMovimentoModel.OBS_MOV         = '', Unassigned, pMovimentoModel.OBS_MOV);
  pQry.ParamByName('tipo_doc').Value       := IIF(pMovimentoModel.TIPO_DOC        = '', Unassigned, pMovimentoModel.TIPO_DOC);
  pQry.ParamByName('data_mov').Value       := IIF(pMovimentoModel.DATA_MOV        = '', Unassigned, transformaDataFireBird(pMovimentoModel.DATA_MOV));
  pQry.ParamByName('data_doc').Value       := IIF(pMovimentoModel.DATA_DOC        = '', Unassigned, transformaDataFireBird(pMovimentoModel.DATA_DOC));
  pQry.ParamByName('quantidade_mov').Value := IIF(pMovimentoModel.QUANTIDADE_MOV  = '', Unassigned, FormataFloatFireBird(pMovimentoModel.QUANTIDADE_MOV));
  pQry.ParamByName('valor_mov').Value      := IIF(pMovimentoModel.VALOR_MOV       = '', Unassigned, FormataFloatFireBird(pMovimentoModel.VALOR_MOV));
  pQry.ParamByName('custo_atual').Value    := IIF(pMovimentoModel.CUSTO_ATUAL     = '', Unassigned, FormataFloatFireBird(pMovimentoModel.CUSTO_ATUAL));
  pQry.ParamByName('venda_atual').Value    := IIF(pMovimentoModel.VENDA_ATUAL     = '', Unassigned, FormataFloatFireBird(pMovimentoModel.VENDA_ATUAL));
  pQry.ParamByName('status').Value         := IIF(pMovimentoModel.STATUS          = '', Unassigned, pMovimentoModel.STATUS);
  pQry.ParamByName('loja').Value           := IIF(pMovimentoModel.LOJA            = '', Unassigned, pMovimentoModel.LOJA);
  pQry.ParamByName('usuario_id').Value     := IIF(pMovimentoModel.USUARIO_ID      = '', Unassigned, pMovimentoModel.USUARIO_ID);
  pQry.ParamByName('datahora').Value       := IIF(pMovimentoModel.DATAHORA        = '', Unassigned, transformaDataHoraFireBird(pMovimentoModel.DATAHORA));
  pQry.ParamByName('tabela_origem').Value  := IIF(pMovimentoModel.TABELA_ORIGEM   = '', Unassigned, pMovimentoModel.TABELA_ORIGEM);
  pQry.ParamByName('id_origem').Value      := IIF(pMovimentoModel.ID_ORIGEM       = '', Unassigned, pMovimentoModel.ID_ORIGEM);
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
