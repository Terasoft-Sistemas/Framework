unit RecebimentoCartaoDao;

interface

uses
  RecebimentoCartaoModel,
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
  TRecebimentoCartaoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FRecebimentoCartaosLista: TObjectList<TRecebimentoCartaoModel>;
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
    procedure SetRecebimentoCartaosLista(const Value: TObjectList<TRecebimentoCartaoModel>);
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

    property RecebimentoCartaosLista: TObjectList<TRecebimentoCartaoModel> read FRecebimentoCartaosLista write SetRecebimentoCartaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
    function alterar(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
    function excluir(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
	
    procedure obterLista;
    function carregaClasse(pID: String): TRecebimentoCartaoModel;

    procedure setParams(var pQry: TFDQuery; pCaixaModel: TRecebimentoCartaoModel);

end;

implementation

uses
  System.Rtti;

{ TRecebimentoCartao }

function TRecebimentoCartaoDao.carregaClasse(pID: String): TRecebimentoCartaoModel;
var
  lQry   : TFDQuery;
  lModel : TRecebimentoCartaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TRecebimentoCartaoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from recebimento_cartao where id = '+pID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID            := lQry.FieldByName('ID').AsString;
    lModel.USUARIO_ID    := lQry.FieldByName('USUARIO_ID').AsString;
    lModel.DATA_HORA     := lQry.FieldByName('DATA_HORA').AsString;
    lModel.CLIENTE_ID    := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.FATURA        := lQry.FieldByName('FATURA').AsString;
    lModel.PARCELA       := lQry.FieldByName('PARCELA').AsString;
    lModel.VALOR         := lQry.FieldByName('VALOR').AsString;
    lModel.BANDEIRA_ID   := lQry.FieldByName('BANDEIRA_ID').AsString;
    lModel.VENCIMENTO    := lQry.FieldByName('VENCIMENTO').AsString;
    lModel.TEF_ID        := lQry.FieldByName('TEF_ID').AsString;
    lModel.SYSTIME       := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TRecebimentoCartaoDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TRecebimentoCartaoDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TRecebimentoCartaoDao.incluir(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := vConstrutor.gerarInsert('RECEBIMENTO_CARTAO', 'ID', true);
    lQry.SQL.Add(lSQL);
    ARecebimentoCartaoModel.ID := vIConexao.Generetor('GEN_RECEBIMENTO_CARTAO');
    setParams(lQry, ARecebimentoCartaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TRecebimentoCartaoDao.alterar(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('RECEBIMENTO_CARTAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ARecebimentoCartaoModel);
    lQry.ExecSQL;

    Result := ARecebimentoCartaoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TRecebimentoCartaoDao.excluir(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from recebimento_cartao where ID = :ID',[ARecebimentoCartaoModel.ID]);
   lQry.ExecSQL;
   Result := ARecebimentoCartaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TRecebimentoCartaoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and recebimento_cartao.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TRecebimentoCartaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From recebimento_cartao where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TRecebimentoCartaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FRecebimentoCartaosLista := TObjectList<TRecebimentoCartaoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       recebimento_cartao.*      '+
	    '  from recebimento_cartao        '+
      ' where 1=1                       ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FRecebimentoCartaosLista.Add(TRecebimentoCartaoModel.Create(vIConexao));

      i := FRecebimentoCartaosLista.Count -1;

      FRecebimentoCartaosLista[i].ID          := lQry.FieldByName('ID').AsString;
      FRecebimentoCartaosLista[i].USUARIO_ID  := lQry.FieldByName('USUARIO_ID').AsString;
      FRecebimentoCartaosLista[i].DATA_HORA   := lQry.FieldByName('DATA_HORA').AsString;
      FRecebimentoCartaosLista[i].CLIENTE_ID  := lQry.FieldByName('CLIENTE_ID').AsString;
      FRecebimentoCartaosLista[i].FATURA      := lQry.FieldByName('FATURA').AsString;
      FRecebimentoCartaosLista[i].PARCELA     := lQry.FieldByName('PARCELA').AsString;
      FRecebimentoCartaosLista[i].VALOR       := lQry.FieldByName('VALOR').AsString;
      FRecebimentoCartaosLista[i].BANDEIRA_ID := lQry.FieldByName('BANDEIRA_ID').AsString;
      FRecebimentoCartaosLista[i].VENCIMENTO  := lQry.FieldByName('VENCIMENTO').AsString;
      FRecebimentoCartaosLista[i].TEF_ID      := lQry.FieldByName('TEF_ID').AsString;
      FRecebimentoCartaosLista[i].SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TRecebimentoCartaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TRecebimentoCartaoDao.SetRecebimentoCartaosLista(const Value: TObjectList<TRecebimentoCartaoModel>);
begin
  FRecebimentoCartaosLista := Value;
end;

procedure TRecebimentoCartaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TRecebimentoCartaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TRecebimentoCartaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TRecebimentoCartaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TRecebimentoCartaoDao.setParams(var pQry: TFDQuery; pCaixaModel: TRecebimentoCartaoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('RECEBIMENTO_CARTAO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TRecebimentoCartaoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pCaixaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pCaixaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TRecebimentoCartaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TRecebimentoCartaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TRecebimentoCartaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
