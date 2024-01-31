unit CreditoClienteDao;

interface

uses
  CreditoClienteModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TCreditoClienteDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FCreditoClientesLista: TObjectList<TCreditoClienteModel>;
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
    procedure SetCreditoClientesLista(const Value: TObjectList<TCreditoClienteModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);



  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property CreditoClientesLista: TObjectList<TCreditoClienteModel> read FCreditoClientesLista write SetCreditoClientesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ACreditoClienteModel: TCreditoClienteModel): String;
    function alterar(ACreditoClienteModel: TCreditoClienteModel): String;
    function excluir(ACreditoClienteModel: TCreditoClienteModel): String;
    function carregaClasse(pID : String) : TCreditoClienteModel;
    function where: String;

    procedure obterLista;
    procedure creditosAbertos(pCliente : String);
    procedure setParams(var pQry: TFDQuery; pCreditoClienteModel: TCreditoClienteModel);

end;

implementation

uses
  System.Rtti;

{ TCreditoCliente }

function TCreditoClienteDao.carregaClasse(pID: String): TCreditoClienteModel;
var
  lQry: TFDQuery;
  lModel: TCreditoClienteModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCreditoClienteModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CREDITO_CLIENTE where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

      lModel.ID                   := lQry.FieldByName('ID').AsString;
      lModel.CLIENTE_ID           := lQry.FieldByName('CLIENTE_ID').AsString;
      lModel.DEVOLUCAO_ID         := lQry.FieldByName('DEVOLUCAO_ID').AsString;
      lModel.DATA                 := lQry.FieldByName('DATA').AsString;
      lModel.VALOR                := lQry.FieldByName('VALOR').AsString;
      lModel.TIPO                 := lQry.FieldByName('TIPO').AsString;
      lModel.OBS                  := lQry.FieldByName('OBS').AsString;
      lModel.ENTRADA_ID           := lQry.FieldByName('ENTRADA_ID').AsString;
      lModel.FORNECEDOR_ID        := lQry.FieldByName('FORNECEDOR_ID').AsString;
      lModel.FATURA_ID            := lQry.FieldByName('FATURA_ID').AsString;
      lModel.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      lModel.PEDIDO_SITE          := lQry.FieldByName('PEDIDO_SITE').AsString;
      lModel.CONTACORRENTE_ID     := lQry.FieldByName('CONTACORRENTE_ID').AsString;
      lModel.CLIENTE_ANTERIOR_ID  := lQry.FieldByName('CLIENTE_ANTERIOR_ID').AsString;
      lModel.VENDA_CASADA         := lQry.FieldByName('VENDA_CASADA').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCreditoClienteDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

procedure TCreditoClienteDao.creditosAbertos(pCliente: String);
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;

begin

  lQry := vIConexao.CriarQuery;

  FCreditoClientesLista := TObjectList<TCreditoClienteModel>.Create;

  try
    lSQL := '  select c.*,                                                                                '+
            '         c.valor - coalesce((select sum(u.valor)                                             '+
            '                               from credito_cliente_uso u                                    '+
            '                              where u.credito_cliente_id = c.id), 0) valor_aberto            '+
            '    from credito_cliente c                                                                   '+
            '   where c.cliente_id = ' + QuotedStr(pCliente)                                               +
            '     and c.tipo = ''C''                                                                      '+
            '     and c.valor - coalesce((select sum(u.valor)                                             '+
            '                              from credito_cliente_uso u                                     '+
            '                             where u.credito_cliente_id = c.id), 0) > 0                      ';

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCreditoClientesLista.Add(TCreditoClienteModel.Create(vIConexao));

      i := FCreditoClientesLista.Count -1;

      FCreditoClientesLista[i].ID                  := lQry.FieldByName('ID').AsString;
      FCreditoClientesLista[i].CLIENTE_ID          := lQry.FieldByName('CLIENTE_ID').AsString;
      FCreditoClientesLista[i].DEVOLUCAO_ID        := lQry.FieldByName('DEVOLUCAO_ID').AsString;
      FCreditoClientesLista[i].DATA                := lQry.FieldByName('DATA').AsString;
      FCreditoClientesLista[i].VALOR               := lQry.FieldByName('VALOR').AsString;
      FCreditoClientesLista[i].TIPO                := lQry.FieldByName('TIPO').AsString;
      FCreditoClientesLista[i].OBS                 := lQry.FieldByName('OBS').AsString;
      FCreditoClientesLista[i].ENTRADA_ID          := lQry.FieldByName('ENTRADA_ID').AsString;
      FCreditoClientesLista[i].FORNECEDOR_ID       := lQry.FieldByName('FORNECEDOR_ID').AsString;
      FCreditoClientesLista[i].FATURA_ID           := lQry.FieldByName('FATURA_ID').AsString;
      FCreditoClientesLista[i].SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
      FCreditoClientesLista[i].PEDIDO_SITE         := lQry.FieldByName('PEDIDO_SITE').AsString;
      FCreditoClientesLista[i].CONTACORRENTE_ID    := lQry.FieldByName('CONTACORRENTE_ID').AsString;
      FCreditoClientesLista[i].CLIENTE_ANTERIOR_ID := lQry.FieldByName('CLIENTE_ANTERIOR_ID').AsString;
      FCreditoClientesLista[i].VENDA_CASADA        := lQry.FieldByName('VENDA_CASADA').AsString;
      FCreditoClientesLista[i].VALOR_ABERTO        := lQry.FieldByName('VALOR_ABERTO').AsString;

      lQry.Next;
    end;

  finally
    lQry.Free;
  end;
end;

destructor TCreditoClienteDao.Destroy;
begin

  inherited;
end;

function TCreditoClienteDao.incluir(ACreditoClienteModel: TCreditoClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CREDITO_CLIENTE','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACreditoClienteModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

function TCreditoClienteDao.alterar(ACreditoClienteModel: TCreditoClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CREDITO_CLIENTE','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACreditoClienteModel);
    lQry.ExecSQL;

    Result := ACreditoClienteModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCreditoClienteDao.excluir(ACreditoClienteModel: TCreditoClienteModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CREDITO_CLIENTE where ID = :ID',[ACreditoClienteModel.ID]);
   lQry.ExecSQL;
   Result := ACreditoClienteModel.ID;

  finally
    lQry.Free;
  end;
end;

function TCreditoClienteDao.where: String;
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

procedure TCreditoClienteDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CREDITO_CLIENTE where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FCreditoClientesLista := TObjectList<TCreditoClienteModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       credito_cliente.*        '+
	    '  from credito_cliente          '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCreditoClientesLista.Add(TCreditoClienteModel.Create(vIConexao));

      i := FCreditoClientesLista.Count -1;

      FCreditoClientesLista[i].ID                  := lQry.FieldByName('ID').AsString;
      FCreditoClientesLista[i].CLIENTE_ID          := lQry.FieldByName('CLIENTE_ID').AsString;
      FCreditoClientesLista[i].DEVOLUCAO_ID        := lQry.FieldByName('DEVOLUCAO_ID').AsString;
      FCreditoClientesLista[i].DATA                := lQry.FieldByName('DATA').AsString;
      FCreditoClientesLista[i].VALOR               := lQry.FieldByName('VALOR').AsString;
      FCreditoClientesLista[i].TIPO                := lQry.FieldByName('TIPO').AsString;
      FCreditoClientesLista[i].OBS                 := lQry.FieldByName('OBS').AsString;
      FCreditoClientesLista[i].ENTRADA_ID          := lQry.FieldByName('ENTRADA_ID').AsString;
      FCreditoClientesLista[i].FORNECEDOR_ID       := lQry.FieldByName('FORNECEDOR_ID').AsString;
      FCreditoClientesLista[i].FATURA_ID           := lQry.FieldByName('FATURA_ID').AsString;
      FCreditoClientesLista[i].SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
      FCreditoClientesLista[i].PEDIDO_SITE         := lQry.FieldByName('PEDIDO_SITE').AsString;
      FCreditoClientesLista[i].CONTACORRENTE_ID    := lQry.FieldByName('CONTACORRENTE_ID').AsString;
      FCreditoClientesLista[i].CLIENTE_ANTERIOR_ID := lQry.FieldByName('CLIENTE_ANTERIOR_ID').AsString;
      FCreditoClientesLista[i].VENDA_CASADA        := lQry.FieldByName('VENDA_CASADA').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCreditoClienteDao.SetCreditoClientesLista(const Value: TObjectList<TCreditoClienteModel>);
begin
  FCreditoClientesLista := Value;
end;

procedure TCreditoClienteDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCreditoClienteDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCreditoClienteDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCreditoClienteDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCreditoClienteDao.setParams(var pQry: TFDQuery; pCreditoClienteModel: TCreditoClienteModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CREDITO_CLIENTE');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TCreditoClienteModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pCreditoClienteModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pCreditoClienteModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TCreditoClienteDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCreditoClienteDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCreditoClienteDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
