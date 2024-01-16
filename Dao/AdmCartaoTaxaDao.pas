unit AdmCartaoTaxaDao;

interface

uses
  AdmCartaoTaxaModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TAdmCartaoTaxaDao = class

  private
    vIConexao : IConexao;
    FAdmCartaoTaxasLista: TObjectList<TAdmCartaoTaxaModel>;
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
    procedure SetAdmCartaoTaxasLista(const Value: TObjectList<TAdmCartaoTaxaModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property AdmCartaoTaxasLista: TObjectList<TAdmCartaoTaxaModel> read FAdmCartaoTaxasLista write SetAdmCartaoTaxasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AAdmCartaoTaxaModel: TAdmCartaoTaxaModel): String;
    function alterar(AAdmCartaoTaxaModel: TAdmCartaoTaxaModel): String;
    function excluir(AAdmCartaoTaxaModel: TAdmCartaoTaxaModel): String;

    procedure obterLista;

    procedure setParams(var pQry: TFDQuery; pCartaoTaxaModel: TAdmCartaoTaxaModel);

end;

implementation

{ TAdmCartaoTaxa }

constructor TAdmCartaoTaxaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TAdmCartaoTaxaDao.Destroy;
begin

  inherited;
end;

function TAdmCartaoTaxaDao.incluir(AAdmCartaoTaxaModel: TAdmCartaoTaxaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := '    insert into admcartao_taxa (id,               '+SLineBreak+
          '                                adm_id,           '+SLineBreak+
          '                                parcela,          '+SLineBreak+
          '                                taxa,             '+SLineBreak+
          '                                dias_vencimento,  '+SLineBreak+
          '                                conciliadora_id)  '+SLineBreak+
          '    values (:id,                                  '+SLineBreak+
          '            :adm_id,                              '+SLineBreak+
          '            :parcela,                             '+SLineBreak+
          '            :taxa,                                '+SLineBreak+
          '            :dias_vencimento,                     '+SLineBreak+
          '            :conciliadora_id)                     '+SLineBreak+
          ' returning ID                                     '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := vIConexao.Generetor('GEN_ADMCARTAO_TAXA');
    setParams(lQry, AAdmCartaoTaxaModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAdmCartaoTaxaDao.alterar(AAdmCartaoTaxaModel: TAdmCartaoTaxaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  '  update admcartao_taxa                        '+SLineBreak+
           '     set adm_id = :adm_id,                     '+SLineBreak+
           '         parcela = :parcela,                   '+SLineBreak+
           '         taxa = :taxa,                         '+SLineBreak+
           '         dias_vencimento = :dias_vencimento,   '+SLineBreak+
           '         conciliadora_id = :conciliadora_id    '+SLineBreak+
           '   where (id = :id)                            '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := IIF(AAdmCartaoTaxaModel.ID = '', Unassigned, AAdmCartaoTaxaModel.ID);
    setParams(lQry, AAdmCartaoTaxaModel);
    lQry.ExecSQL;

    Result := AAdmCartaoTaxaModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAdmCartaoTaxaDao.excluir(AAdmCartaoTaxaModel: TAdmCartaoTaxaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from admcartao_taxa where ID = :ID',[AAdmCartaoTaxaModel.ID]);
   lQry.ExecSQL;
   Result := AAdmCartaoTaxaModel.ID;

  finally
    lQry.Free;
  end;
end;

function TAdmCartaoTaxaDao.montaCondicaoQuery: String;
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

procedure TAdmCartaoTaxaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From admcartao_taxa where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TAdmCartaoTaxaDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FAdmCartaoTaxasLista := TObjectList<TAdmCartaoTaxaModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       admcartao_taxa.*         '+
	    '  from admcartao_taxa           '+
      ' where 1=1                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FAdmCartaoTaxasLista.Add(TAdmCartaoTaxaModel.Create(vIConexao));

      i := FAdmCartaoTaxasLista.Count -1;

      FAdmCartaoTaxasLista[i].ID              := lQry.FieldByName('ID').AsString;
      FAdmCartaoTaxasLista[i].ADM_ID          := lQry.FieldByName('ADM_ID').AsString;
      FAdmCartaoTaxasLista[i].PARCELA         := lQry.FieldByName('PARCELA').AsString;
      FAdmCartaoTaxasLista[i].TAXA            := lQry.FieldByName('TAXA').AsString;
      FAdmCartaoTaxasLista[i].SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
      FAdmCartaoTaxasLista[i].DIAS_VENCIMENTO := lQry.FieldByName('DIAS_VENCIMENTO').AsString;
      FAdmCartaoTaxasLista[i].CONCILIADORA_ID := lQry.FieldByName('CONCILIADORA_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TAdmCartaoTaxaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAdmCartaoTaxaDao.SetAdmCartaoTaxasLista(const Value: TObjectList<TAdmCartaoTaxaModel>);
begin
  FAdmCartaoTaxasLista := Value;
end;

procedure TAdmCartaoTaxaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAdmCartaoTaxaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAdmCartaoTaxaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAdmCartaoTaxaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAdmCartaoTaxaDao.setParams(var pQry: TFDQuery; pCartaoTaxaModel: TAdmCartaoTaxaModel);
begin
  pQry.ParamByName('adm_id').Value          := IIF(pCartaoTaxaModel.ADM_ID          = '', Unassigned, pCartaoTaxaModel.ADM_ID);
  pQry.ParamByName('parcela').Value         := IIF(pCartaoTaxaModel.PARCELA         = '', Unassigned, pCartaoTaxaModel.PARCELA);
  pQry.ParamByName('taxa').Value            := IIF(pCartaoTaxaModel.TAXA            = '', Unassigned, pCartaoTaxaModel.TAXA);
  pQry.ParamByName('dias_vencimento').Value := IIF(pCartaoTaxaModel.DIAS_VENCIMENTO = '', Unassigned, pCartaoTaxaModel.DIAS_VENCIMENTO);
  pQry.ParamByName('conciliadora_id').Value := IIF(pCartaoTaxaModel.CONCILIADORA_ID = '', Unassigned, pCartaoTaxaModel.CONCILIADORA_ID);
end;

procedure TAdmCartaoTaxaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAdmCartaoTaxaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAdmCartaoTaxaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
