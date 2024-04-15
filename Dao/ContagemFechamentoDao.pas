unit ContagemFechamentoDao;

interface

uses
  ContagemFechamentoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Utils;

type
  TContagemFechamentoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;

    procedure SetCountView(const Value: String);
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

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AContagemFechamentoModel: TContagemFechamentoModel): String;
    function alterar(AContagemFechamentoModel: TContagemFechamentoModel): String;
    function excluir(AContagemFechamentoModel: TContagemFechamentoModel): String;

	  procedure obterTotalRegistros;
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pContagemFechamentoModel: TContagemFechamentoModel);

    function carregaClasse(pId: String): TContagemFechamentoModel;

end;

implementation

uses
  System.Rtti;

{ TAdmCartao }

function TContagemFechamentoDao.carregaClasse(pId: String): TContagemFechamentoModel;
var
  lQry: TFDQuery;
  lModel: TContagemFechamentoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContagemFechamentoModel.Create(vIConexao);
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

constructor TContagemFechamentoDao.Create(pIConexao: IConexao);
begin
  vIConexao  := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TContagemFechamentoDao.Destroy;
begin

  inherited;
end;

function TContagemFechamentoDao.incluir(AContagemFechamentoModel: TContagemFechamentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTAGEM_FECHAMENTO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContagemFechamentoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContagemFechamentoDao.alterar(AContagemFechamentoModel: TContagemFechamentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CONTAGEM_FECHAMENTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContagemFechamentoModel);
    lQry.ExecSQL;

    Result := AContagemFechamentoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContagemFechamentoDao.excluir(AContagemFechamentoModel: TContagemFechamentoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CONTAGEM_FECHAMENTO where ID = :ID',[AContagemFechamentoModel.ID]);
   lQry.ExecSQL;
   Result := AContagemFechamentoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TContagemFechamentoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and CONTAGEM_FECHAMENTO.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TContagemFechamentoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CONTAGEM_FECHAMENTO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TContagemFechamentoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  try

  finally
    lQry.Free;
  end;
end;

procedure TContagemFechamentoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContagemFechamentoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContagemFechamentoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContagemFechamentoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContagemFechamentoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContagemFechamentoDao.setParams(var pQry: TFDQuery; pContagemFechamentoModel: TContagemFechamentoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONTAGEM_FECHAMENTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TContagemFechamentoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pContagemFechamentoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pContagemFechamentoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TContagemFechamentoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContagemFechamentoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContagemFechamentoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
