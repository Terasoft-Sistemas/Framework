unit AdmCartaoDao;

interface

uses
  AdmCartaoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao;

type
  TAdmCartaoDao = class

  private
    vIConexao  : IConexao;
    vConstrutor : TConstrutorDao;

    FAdmCartaosLista: TObjectList<TAdmCartaoModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure SetCountView(const Value: String);
    procedure SetAdmCartaosLista(const Value: TObjectList<TAdmCartaoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao: IConexao);
    destructor Destroy; override;

    property AdmCartaosLista: TObjectList<TAdmCartaoModel> read FAdmCartaosLista write SetAdmCartaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AAdmCartaoModel: TAdmCartaoModel): String;
    function alterar(AAdmCartaoModel: TAdmCartaoModel): String;
    function excluir(AAdmCartaoModel: TAdmCartaoModel): String;

	  procedure obterTotalRegistros;
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pAdmCartaoModel: TAdmCartaoModel);

    function carregaClasse(pId: String): TAdmCartaoModel;

end;

implementation

{ TAdmCartao }

function TAdmCartaoDao.carregaClasse(pId: String): TAdmCartaoModel;
var
  lQry: TFDQuery;
  lModel: TAdmCartaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TAdmCartaoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from admcartao where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.NOME_ADM              := lQry.FieldByName('NOME_ADM').AsString;
    lModel.CREDITO_ADM           := lQry.FieldByName('CREDITO_ADM').AsString;
    lModel.DEBITO_ADM            := lQry.FieldByName('DEBITO_ADM').AsString;
    lModel.PARCELADO_ADM         := lQry.FieldByName('PARCELADO_ADM').AsString;
    lModel.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.COMISSAO_ADM          := lQry.FieldByName('COMISSAO_ADM').AsString;
    lModel.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.GERENCIADOR           := lQry.FieldByName('GERENCIADOR').AsString;
    lModel.VENCIMENTO_DIA_SEMANA := lQry.FieldByName('VENCIMENTO_DIA_SEMANA').AsString;
    lModel.PORTADOR_ID           := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.IMAGEM                := lQry.FieldByName('IMAGEM').AsString;
    lModel.TAXA                  := lQry.FieldByName('TAXA').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.NOME_WEB              := lQry.FieldByName('NOME_WEB').AsString;
    lModel.CONCILIADORA_ID       := lQry.FieldByName('CONCILIADORA_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TAdmCartaoDao.Create(pIConexao: IConexao);
begin
  vIConexao  := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TAdmCartaoDao.Destroy;
begin

  inherited;
end;

function TAdmCartaoDao.incluir(AAdmCartaoModel: TAdmCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ADMCARTAO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('ID').Value := vIConexao.Generetor('GEN_ADMCARTAO');
    setParams(lQry, AAdmCartaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAdmCartaoDao.alterar(AAdmCartaoModel: TAdmCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('ADMCARTAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value   := ifThen(AAdmCartaoModel.ID   = '', Unassigned, AAdmCartaoModel.ID);
    setParams(lQry, AAdmCartaoModel);
    lQry.ExecSQL;

    Result := AAdmCartaoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAdmCartaoDao.excluir(AAdmCartaoModel: TAdmCartaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from admcartao where ID = :ID',[AAdmCartaoModel.ID]);
   lQry.ExecSQL;
   Result := AAdmCartaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TAdmCartaoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and admcartao.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TAdmCartaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From admcartao where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TAdmCartaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FAdmCartaosLista := TObjectList<TAdmCartaoModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       admcartao.*       '+
	    '  from admcartao         '+
      ' where 1=1               ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FAdmCartaosLista.Add(TAdmCartaoModel.Create(vIConexao));

      i := FAdmCartaosLista.Count -1;

      FAdmCartaosLista[i].ID                    := lQry.FieldByName('ID').AsString;
      FAdmCartaosLista[i].NOME_ADM              := lQry.FieldByName('NOME_ADM').AsString;
      FAdmCartaosLista[i].CREDITO_ADM           := lQry.FieldByName('CREDITO_ADM').AsString;
      FAdmCartaosLista[i].DEBITO_ADM            := lQry.FieldByName('DEBITO_ADM').AsString;
      FAdmCartaosLista[i].PARCELADO_ADM         := lQry.FieldByName('PARCELADO_ADM').AsString;
      FAdmCartaosLista[i].STATUS                := lQry.FieldByName('STATUS').AsString;
      FAdmCartaosLista[i].COMISSAO_ADM          := lQry.FieldByName('COMISSAO_ADM').AsString;
      FAdmCartaosLista[i].LOJA                  := lQry.FieldByName('LOJA').AsString;
      FAdmCartaosLista[i].GERENCIADOR           := lQry.FieldByName('GERENCIADOR').AsString;
      FAdmCartaosLista[i].VENCIMENTO_DIA_SEMANA := lQry.FieldByName('VENCIMENTO_DIA_SEMANA').AsString;
      FAdmCartaosLista[i].PORTADOR_ID           := lQry.FieldByName('PORTADOR_ID').AsString;
      FAdmCartaosLista[i].IMAGEM                := lQry.FieldByName('IMAGEM').AsString;
      FAdmCartaosLista[i].TAXA                  := lQry.FieldByName('TAXA').AsString;
      FAdmCartaosLista[i].SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
      FAdmCartaosLista[i].NOME_WEB              := lQry.FieldByName('NOME_WEB').AsString;
      FAdmCartaosLista[i].CONCILIADORA_ID       := lQry.FieldByName('CONCILIADORA_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TAdmCartaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAdmCartaoDao.SetAdmCartaosLista(const Value: TObjectList<TAdmCartaoModel>);
begin
  FAdmCartaosLista := Value;
end;

procedure TAdmCartaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAdmCartaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAdmCartaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAdmCartaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAdmCartaoDao.setParams(var pQry: TFDQuery; pAdmCartaoModel: TAdmCartaoModel);
begin
  pQry.ParamByName('nome_adm').Value               := ifThen(pAdmCartaoModel.NOME_ADM               = '', Unassigned, pAdmCartaoModel.NOME_ADM);
  pQry.ParamByName('credito_adm').Value            := ifThen(pAdmCartaoModel.CREDITO_ADM            = '', Unassigned, pAdmCartaoModel.CREDITO_ADM);
  pQry.ParamByName('debito_adm').Value             := ifThen(pAdmCartaoModel.DEBITO_ADM             = '', Unassigned, pAdmCartaoModel.DEBITO_ADM);
  pQry.ParamByName('parcelado_adm').Value          := ifThen(pAdmCartaoModel.PARCELADO_ADM          = '', Unassigned, pAdmCartaoModel.PARCELADO_ADM);
  pQry.ParamByName('status').Value                 := ifThen(pAdmCartaoModel.STATUS                 = '', Unassigned, pAdmCartaoModel.STATUS);
  pQry.ParamByName('comissao_adm').Value           := ifThen(pAdmCartaoModel.COMISSAO_ADM           = '', Unassigned, FormataFloatFireBird(pAdmCartaoModel.COMISSAO_ADM));
  pQry.ParamByName('loja').Value                   := ifThen(pAdmCartaoModel.LOJA                   = '', Unassigned, pAdmCartaoModel.LOJA);
  pQry.ParamByName('gerenciador').Value            := ifThen(pAdmCartaoModel.GERENCIADOR            = '', Unassigned, pAdmCartaoModel.GERENCIADOR);
  pQry.ParamByName('vencimento_dia_semana').Value  := ifThen(pAdmCartaoModel.VENCIMENTO_DIA_SEMANA  = '', Unassigned, pAdmCartaoModel.VENCIMENTO_DIA_SEMANA);
  pQry.ParamByName('portador_id').Value            := ifThen(pAdmCartaoModel.PORTADOR_ID            = '', Unassigned, pAdmCartaoModel.PORTADOR_ID);
  pQry.ParamByName('imagem').Value                 := ifThen(pAdmCartaoModel.IMAGEM                 = '', Unassigned, pAdmCartaoModel.IMAGEM);
  pQry.ParamByName('taxa').Value                   := ifThen(pAdmCartaoModel.TAXA                   = '', Unassigned, FormataFloatFireBird(pAdmCartaoModel.TAXA));
  pQry.ParamByName('nome_web').Value               := ifThen(pAdmCartaoModel.NOME_WEB               = '', Unassigned, pAdmCartaoModel.NOME_WEB);
  pQry.ParamByName('conciliadora_id').Value        := ifThen(pAdmCartaoModel.CONCILIADORA_ID        = '', Unassigned, pAdmCartaoModel.CONCILIADORA_ID);
end;

procedure TAdmCartaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAdmCartaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAdmCartaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
