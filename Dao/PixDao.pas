unit PixDao;

interface

uses
  PixModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Utils,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TPixDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPixsLista: TObjectList<TPixModel>;
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
    procedure SetPixsLista(const Value: TObjectList<TPixModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPixModel: TPixModel);
    function where: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property PixsLista: TObjectList<TPixModel> read FPixsLista write SetPixsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pPixModel: TPixModel): String;
    function alterar(pPixModel: TPixModel): String;
    function excluir(pPixModel: TPixModel): String;
	
    procedure obterLista;

    function carregaClasse(pId: String): TPixModel;
end;

implementation

uses
  System.Rtti;

{ TPix }

function TPixDao.carregaClasse(pId: String): TPixModel;
var
  lQry: TFDQuery;
  lModel: TPixModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPixModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from pix where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                     := lQry.FieldByName('ID').AsString;
    lModel.DATA_CADASTRO          := lQry.FieldByName('DATA_CADASTRO').AsString;
    lModel.SYSTIME                := lQry.FieldByName('SYSTIME').AsString;
    lModel.CLIENTE_ID             := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.VALOR                  := lQry.FieldByName('VALOR').AsString;
    lModel.VENCIMENTO             := lQry.FieldByName('VENCIMENTO').AsString;
    lModel.EXPIRA                 := lQry.FieldByName('EXPIRA').AsString;
    lModel.MENSAGEM               := lQry.FieldByName('MENSAGEM').AsString;
    lModel.DOCUMENTO              := lQry.FieldByName('DOCUMENTO').AsString;
    lModel.JUROS_TIPO             := lQry.FieldByName('JUROS_TIPO').AsString;
    lModel.JUROS_VALOR            := lQry.FieldByName('JUROS_VALOR').AsString;
    lModel.MULTA_TIPO             := lQry.FieldByName('MULTA_TIPO').AsString;
    lModel.MULTA_VALOR            := lQry.FieldByName('MULTA_VALOR').AsString;
    lModel.DESCONTO_TIPO          := lQry.FieldByName('DESCONTO_TIPO').AsString;
    lModel.DESCONTO_VALOR         := lQry.FieldByName('DESCONTO_VALOR').AsString;
    lModel.DESCONTO_DATA          := lQry.FieldByName('DESCONTO_DATA').AsString;
    lModel.PIX_ID                 := lQry.FieldByName('PIX_ID').AsString;
    lModel.PIX_DATA               := lQry.FieldByName('PIX_DATA').AsString;
    lModel.PIX_URL                := lQry.FieldByName('PIX_URL').AsString;
    lModel.PIX_TIPO               := lQry.FieldByName('PIX_TIPO').AsString;
    lModel.VALOR_RECEBIDO         := lQry.FieldByName('VALOR_RECEBIDO').AsString;
    lModel.CONTASRECEBERITENS_ID  := lQry.FieldByName('CONTASRECEBERITENS_ID').AsString;
    lModel.DATA_PAGAMENTO         := lQry.FieldByName('DATA_PAGAMENTO').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TPixDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPixDao.Destroy;
begin

  inherited;
end;

function TPixDao.incluir(pPixModel: TPixModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PIX', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPixModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPixDao.alterar(pPixModel: TPixModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('PIX', 'ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := ifThen(pPixModel.ID = '', Unassigned, pPixModel.ID);
    setParams(lQry, pPixModel);
    lQry.ExecSQL;

    Result := pPixModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPixDao.excluir(pPixModel: TPixModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from pix where ID = :ID',[pPixModel.ID]);
   lQry.ExecSQL;
   Result := pPixModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPixDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and pix.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TPixDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From pix where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPixDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPixsLista := TObjectList<TPixModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
    '       pix.*          '+
	  '  from pix            '+
    ' where 1=1            ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPixsLista.Add(TPixModel.Create(vIConexao));

      i := FPixsLista.Count -1;

      FPixsLista[i].ID                    := lQry.FieldByName('ID').AsString;
      FPixsLista[i].DATA_CADASTRO         := lQry.FieldByName('DATA_CADASTRO').AsString;
      FPixsLista[i].SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
      FPixsLista[i].CLIENTE_ID            := lQry.FieldByName('CLIENTE_ID').AsString;
      FPixsLista[i].VALOR                 := lQry.FieldByName('VALOR').AsString;
      FPixsLista[i].VENCIMENTO            := lQry.FieldByName('VENCIMENTO').AsString;
      FPixsLista[i].EXPIRA                := lQry.FieldByName('EXPIRA').AsString;
      FPixsLista[i].MENSAGEM              := lQry.FieldByName('MENSAGEM').AsString;
      FPixsLista[i].DOCUMENTO             := lQry.FieldByName('DOCUMENTO').AsString;
      FPixsLista[i].JUROS_TIPO            := lQry.FieldByName('JUROS_TIPO').AsString;
      FPixsLista[i].JUROS_VALOR           := lQry.FieldByName('JUROS_VALOR').AsString;
      FPixsLista[i].MULTA_TIPO            := lQry.FieldByName('MULTA_TIPO').AsString;
      FPixsLista[i].MULTA_VALOR           := lQry.FieldByName('MULTA_VALOR').AsString;
      FPixsLista[i].DESCONTO_TIPO         := lQry.FieldByName('DESCONTO_TIPO').AsString;
      FPixsLista[i].DESCONTO_VALOR        := lQry.FieldByName('DESCONTO_VALOR').AsString;
      FPixsLista[i].DESCONTO_DATA         := lQry.FieldByName('DESCONTO_DATA').AsString;
      FPixsLista[i].PIX_ID                := lQry.FieldByName('PIX_ID').AsString;
      FPixsLista[i].PIX_DATA              := lQry.FieldByName('PIX_DATA').AsString;
      FPixsLista[i].PIX_URL               := lQry.FieldByName('PIX_URL').AsString;
      FPixsLista[i].PIX_TIPO              := lQry.FieldByName('PIX_TIPO').AsString;
      FPixsLista[i].VALOR_RECEBIDO        := lQry.FieldByName('VALOR_RECEBIDO').AsString;
      FPixsLista[i].DATA_PAGAMENTO        := lQry.FieldByName('DATA_PAGAMENTO').AsString;
      FPixsLista[i].CONTASRECEBERITENS_ID := lQry.FieldByName('CONTASRECEBERITENS_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPixDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPixDao.SetPixsLista(const Value: TObjectList<TPixModel>);
begin
  FPixsLista := Value;
end;

procedure TPixDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPixDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPixDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPixDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPixDao.setParams(var pQry: TFDQuery; pPixModel: TPixModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PIX');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPixModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPixModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pPixModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPixDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPixDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPixDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
