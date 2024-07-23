unit VendaCartaoDao;

interface

uses
  VendaCartaoModel,
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
  TVendaCartaoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FVendaCartaosLista: TObjectList<TVendaCartaoModel>;
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
    procedure SetVendaCartaosLista(const Value: TObjectList<TVendaCartaoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;

    procedure setParams(var pQry: TFDQuery; pVendaCartaoModel: TVendaCartaoModel);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property VendaCartaosLista: TObjectList<TVendaCartaoModel> read FVendaCartaosLista write SetVendaCartaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AVendaCartaoModel: TVendaCartaoModel): String;
    function alterar(AVendaCartaoModel: TVendaCartaoModel): String;
    function excluir(AVendaCartaoModel: TVendaCartaoModel): String;

    function carregaClasse(pID : String) : TVendaCartaoModel;

    procedure obterLista;

end;

implementation

uses
  System.Rtti;

{ TVendaCartao }

function TVendaCartaoDao.carregaClasse(pID: String): TVendaCartaoModel;
var
  lQry: TFDQuery;
  lModel: TVendaCartaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TVendaCartaoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from VENDACARTAO where ID = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                   := lQry.FieldByName('ID').AsString;
    lModel.NUMERO_CAR           := lQry.FieldByName('NUMERO_CAR').AsString;
    lModel.AUTORIZACAO_CAR      := lQry.FieldByName('AUTORIZACAO_CAR').AsString;
    lModel.PARCELA_CAR          := lQry.FieldByName('PARCELA_CAR').AsString;
    lModel.PARCELAS_CAR         := lQry.FieldByName('PARCELAS_CAR').AsString;
    lModel.VALOR_CAR            := lQry.FieldByName('VALOR_CAR').AsString;
    lModel.CODIGO_CLI           := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.ADM_CAR              := lQry.FieldByName('ADM_CAR').AsString;
    lModel.VENDA_CAR            := lQry.FieldByName('VENDA_CAR').AsString;
    lModel.PARCELADO_CAR        := lQry.FieldByName('PARCELADO_CAR').AsString;
    lModel.VENCIMENTO_CAR       := lQry.FieldByName('VENCIMENTO_CAR').AsString;
    lModel.NUMERO_VENDA         := lQry.FieldByName('NUMERO_VENDA').AsString;
    lModel.LOJA                 := lQry.FieldByName('LOJA').AsString;
    lModel.NUMERO_OS            := lQry.FieldByName('NUMERO_OS').AsString;
    lModel.FATURA_ID            := lQry.FieldByName('FATURA_ID').AsString;
    lModel.CANCELAMENTO_DATA    := lQry.FieldByName('CANCELAMENTO_DATA').AsString;
    lModel.CANCELAMENTO_CODIGO  := lQry.FieldByName('CANCELAMENTO_CODIGO').AsString;
    lModel.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
    lModel.TAXA                 := lQry.FieldByName('TAXA').AsString;
    lModel.PARCELA_TEF          := lQry.FieldByName('PARCELA_TEF').AsString;
    lModel.PARCELAS_TEF         := lQry.FieldByName('PARCELAS_TEF').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TVendaCartaoDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TVendaCartaoDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TVendaCartaoDao.incluir(AVendaCartaoModel: TVendaCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('VENDACARTAO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    AVendaCartaoModel.id := vIConexao.Generetor('GEN_VENDACARTAO');
    setParams(lQry, AVendaCartaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TVendaCartaoDao.alterar(AVendaCartaoModel: TVendaCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('VENDACARTAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AVendaCartaoModel);
    lQry.ExecSQL;

    Result := AVendaCartaoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TVendaCartaoDao.excluir(AVendaCartaoModel: TVendaCartaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from vendacartao where ID = :ID',[AVendaCartaoModel.ID]);
   lQry.ExecSQL;
   Result := AVendaCartaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TVendaCartaoDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and vendacartao.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TVendaCartaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From vendacartao where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TVendaCartaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FVendaCartaosLista := TObjectList<TVendaCartaoModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       vendacartao.*            '+
	    '  from vendacartao              '+
      ' where 1=1                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FVendaCartaosLista.Add(TVendaCartaoModel.Create(vIConexao));

      i := FVendaCartaosLista.Count -1;

      FVendaCartaosLista[i].ID                  := lQry.FieldByName('ID').AsString;
      FVendaCartaosLista[i].NUMERO_CAR          := lQry.FieldByName('NUMERO_CAR').AsString;
      FVendaCartaosLista[i].AUTORIZACAO_CAR     := lQry.FieldByName('AUTORIZACAO_CAR').AsString;
      FVendaCartaosLista[i].PARCELA_CAR         := lQry.FieldByName('PARCELA_CAR').AsString;
      FVendaCartaosLista[i].PARCELAS_CAR        := lQry.FieldByName('PARCELAS_CAR').AsString;
      FVendaCartaosLista[i].VALOR_CAR           := lQry.FieldByName('VALOR_CAR').AsString;
      FVendaCartaosLista[i].CODIGO_CLI          := lQry.FieldByName('CODIGO_CLI').AsString;
      FVendaCartaosLista[i].ADM_CAR             := lQry.FieldByName('ADM_CAR').AsString;
      FVendaCartaosLista[i].VENDA_CAR           := lQry.FieldByName('VENDA_CAR').AsString;
      FVendaCartaosLista[i].PARCELADO_CAR       := lQry.FieldByName('PARCELADO_CAR').AsString;
      FVendaCartaosLista[i].VENCIMENTO_CAR      := lQry.FieldByName('VENCIMENTO_CAR').AsString;
      FVendaCartaosLista[i].NUMERO_VENDA        := lQry.FieldByName('NUMERO_VENDA').AsString;
      FVendaCartaosLista[i].LOJA                := lQry.FieldByName('LOJA').AsString;
      FVendaCartaosLista[i].NUMERO_OS           := lQry.FieldByName('NUMERO_OS').AsString;
      FVendaCartaosLista[i].FATURA_ID           := lQry.FieldByName('FATURA_ID').AsString;
      FVendaCartaosLista[i].CANCELAMENTO_DATA   := lQry.FieldByName('CANCELAMENTO_DATA').AsString;
      FVendaCartaosLista[i].CANCELAMENTO_CODIGO := lQry.FieldByName('CANCELAMENTO_CODIGO').AsString;
      FVendaCartaosLista[i].SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
      FVendaCartaosLista[i].TAXA                := lQry.FieldByName('TAXA').AsString;
      FVendaCartaosLista[i].PARCELA_TEF         := lQry.FieldByName('PARCELA_TEF').AsString;
      FVendaCartaosLista[i].PARCELAS_TEF        := lQry.FieldByName('PARCELAS_TEF').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TVendaCartaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVendaCartaoDao.SetVendaCartaosLista(const Value: TObjectList<TVendaCartaoModel>);
begin
  FVendaCartaosLista := Value;
end;

procedure TVendaCartaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TVendaCartaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TVendaCartaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVendaCartaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TVendaCartaoDao.setParams(var pQry: TFDQuery; pVendaCartaoModel: TVendaCartaoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('VENDACARTAO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TVendaCartaoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pVendaCartaoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pVendaCartaoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;
procedure TVendaCartaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TVendaCartaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TVendaCartaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
