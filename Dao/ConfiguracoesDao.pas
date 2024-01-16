unit ConfiguracoesDao;

interface

uses
  ConfiguracoesModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  VariaveisGlobais,
  Interfaces.Conexao;

type
  TConfiguracoesDao = class

  private
    vIConexao : IConexao;
    FConfiguracoessLista: TObjectList<TConfiguracoesModel>;
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
    procedure SetConfiguracoessLista(const Value: TObjectList<TConfiguracoesModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;

  public
    constructor Create(pIConexao : Iconexao);
    destructor Destroy; override;

    property ConfiguracoessLista: TObjectList<TConfiguracoesModel> read FConfiguracoessLista write SetConfiguracoessLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AConfiguracoesModel: TConfiguracoesModel): String;
    function alterar(AConfiguracoesModel: TConfiguracoesModel): String;
    function excluir(AConfiguracoesModel: TConfiguracoesModel): String;

    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pConfiguracoesModel: TConfiguracoesModel);

end;

implementation

{ TConfiguracoes }

constructor TConfiguracoesDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TConfiguracoesDao.Destroy;
begin

  inherited;
end;

function TConfiguracoesDao.incluir(AConfiguracoesModel: TConfiguracoesModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIConexao.CriarQuery;

  lSQL := '   insert into configuracoes (tag,                '+SLineBreak+
          '                              fid,                '+SLineBreak+
          '                              perfil_id,          '+SLineBreak+
          '                              valorinteiro,       '+SLineBreak+
          '                              valorstring,        '+SLineBreak+
          '                              valormemo,          '+SLineBreak+
          '                              valornumerico,      '+SLineBreak+
          '                              valorchar,          '+SLineBreak+
          '                              valordata,          '+SLineBreak+
          '                              valorhora,          '+SLineBreak+
          '                              valordatahora)      '+SLineBreak+
          '   values (:tag,                                  '+SLineBreak+
          '           :fid,                                  '+SLineBreak+
          '           :perfil_id,                            '+SLineBreak+
          '           :valorinteiro,                         '+SLineBreak+
          '           :valorstring,                          '+SLineBreak+
          '           :valormemo,                            '+SLineBreak+
          '           :valornumerico,                        '+SLineBreak+
          '           :valorchar,                            '+SLineBreak+
          '           :valordata,                            '+SLineBreak+
          '           :valorhora,                            '+SLineBreak+
          '           :valordatahora)                        '+SLineBreak+
          ' returning ID                                     '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AConfiguracoesModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TConfiguracoesDao.alterar(AConfiguracoesModel: TConfiguracoesModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL :=  '    update configuracoes                      '+SLineBreak+
           '       set perfil_id = :perfil_id,            '+SLineBreak+
           '           valorinteiro = :valorinteiro,      '+SLineBreak+
           '           valorstring = :valorstring,        '+SLineBreak+
           '           valormemo = :valormemo,            '+SLineBreak+
           '           valornumerico = :valornumerico,    '+SLineBreak+
           '           valorchar = :valorchar,            '+SLineBreak+
           '           valordata = :valordata,            '+SLineBreak+
           '           valorhora = :valorhora,            '+SLineBreak+
           '           valordatahora = :valordatahora     '+SLineBreak+
           '     where (tag = :tag) and (fid = :fid)      '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AConfiguracoesModel);
    lQry.ExecSQL;

    Result := AConfiguracoesModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TConfiguracoesDao.excluir(AConfiguracoesModel: TConfiguracoesModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from configuracoes where ID = :ID',[AConfiguracoesModel.ID]);
   lQry.ExecSQL;
   Result := AConfiguracoesModel.ID;

  finally
    lQry.Free;
  end;
end;

function TConfiguracoesDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and configuracoes.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TConfiguracoesDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From configuracoes where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TConfiguracoesDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i : Integer;
begin
  lQry := xConexao.CriarQuery;

  FConfiguracoessLista := TObjectList<TConfiguracoesModel>.Create;

  try
    lSQL := ' select  *                '+
	          '   from configuracoes     '+
            '  where 1=1               ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FConfiguracoessLista.Add(TConfiguracoesModel.Create);
      i := FConfiguracoessLista.Count -1;
      FConfiguracoessLista[i].ID             := lQry.FieldByName('ID').AsString;
      FConfiguracoessLista[i].TAG            := lQry.FieldByName('TAG').AsString;
      FConfiguracoessLista[i].F_ID           := lQry.FieldByName('FID').AsString;
      FConfiguracoessLista[i].PERFIL_ID      := lQry.FieldByName('PERFIL_ID').AsString;
      FConfiguracoessLista[i].VALORINTEIRO   := lQry.FieldByName('VALORINTEIRO').AsString;
      FConfiguracoessLista[i].VALORSTRING    := lQry.FieldByName('VALORSTRING').AsString;
      FConfiguracoessLista[i].VALORMEMO      := lQry.FieldByName('VALORMEMO').AsString;
      FConfiguracoessLista[i].VALORNUMERICO  := lQry.FieldByName('VALORNUMERICO').AsString;
      FConfiguracoessLista[i].VALORCHAR      := lQry.FieldByName('VALORCHAR').AsString;
      FConfiguracoessLista[i].VALORDATA      := lQry.FieldByName('VALORDATA').AsString;
      FConfiguracoessLista[i].VALORHORA      := lQry.FieldByName('VALORHORA').AsString;
      FConfiguracoessLista[i].VALORDATAHORA  := lQry.FieldByName('VALORDATAHORA').AsString;
      FConfiguracoessLista[i].SYSTIME        := lQry.FieldByName('SYSTIME').AsString;
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TConfiguracoesDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TConfiguracoesDao.SetConfiguracoessLista(const Value: TObjectList<TConfiguracoesModel>);
begin
  FConfiguracoessLista := Value;
end;

procedure TConfiguracoesDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TConfiguracoesDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TConfiguracoesDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TConfiguracoesDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TConfiguracoesDao.setParams(var pQry: TFDQuery; pConfiguracoesModel: TConfiguracoesModel);
begin
  pQry.ParamByName('tag').Value             := IIF(pConfiguracoesModel.TAG             = '', Unassigned, pConfiguracoesModel.TAG);
  pQry.ParamByName('fid').Value             := IIF(pConfiguracoesModel.F_ID            = '', Unassigned, pConfiguracoesModel.F_ID);
  pQry.ParamByName('perfil_id').Value       := IIF(pConfiguracoesModel.PERFIL_ID       = '', Unassigned, pConfiguracoesModel.PERFIL_ID);
  pQry.ParamByName('valorinteiro').Value    := IIF(pConfiguracoesModel.VALORINTEIRO    = '', Unassigned, pConfiguracoesModel.VALORINTEIRO);
  pQry.ParamByName('valorstring').Value     := IIF(pConfiguracoesModel.VALORSTRING     = '', Unassigned, pConfiguracoesModel.VALORSTRING);
  pQry.ParamByName('valormemo').Value       := IIF(pConfiguracoesModel.VALORMEMO       = '', Unassigned, pConfiguracoesModel.VALORMEMO);
  pQry.ParamByName('valornumerico').Value   := IIF(pConfiguracoesModel.VALORNUMERICO   = '', Unassigned, pConfiguracoesModel.VALORNUMERICO);
  pQry.ParamByName('valorchar').Value       := IIF(pConfiguracoesModel.VALORCHAR       = '', Unassigned, pConfiguracoesModel.VALORCHAR);
  pQry.ParamByName('valordata').Value       := IIF(pConfiguracoesModel.VALORDATA       = '', Unassigned, pConfiguracoesModel.VALORDATA);
  pQry.ParamByName('valorhora').Value       := IIF(pConfiguracoesModel.VALORHORA       = '', Unassigned, pConfiguracoesModel.VALORHORA);
  pQry.ParamByName('valordatahora').Value   := IIF(pConfiguracoesModel.VALORDATAHORA   = '', Unassigned, pConfiguracoesModel.VALORDATAHORA);
end;

procedure TConfiguracoesDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TConfiguracoesDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TConfiguracoesDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
