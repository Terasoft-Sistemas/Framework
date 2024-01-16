unit CreditoClienteDao;

interface

uses
  CreditoClienteModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto;

type
  TCreditoClienteDao = class

  private
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

    function montaCondicaoQuery: String;

  public
    constructor Create;
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

    procedure obterLista;
    procedure creditosAbertos(pCliente : String);
    procedure setParams(var pQry: TFDQuery; pCreditoClienteModel: TCreditoClienteModel);

end;

implementation

{ TCreditoCliente }

constructor TCreditoClienteDao.Create;
begin

end;

procedure TCreditoClienteDao.creditosAbertos(pCliente: String);
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

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
      FCreditoClientesLista.Add(TCreditoClienteModel.Create);

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
    lConexao.Free;
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
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

  lSQL := '     insert into credito_cliente (cliente_id,              '+SLineBreak+
          '                                  devolucao_id,            '+SLineBreak+
          '                                  data,                    '+SLineBreak+
          '                                  valor,                   '+SLineBreak+
          '                                  tipo,                    '+SLineBreak+
          '                                  obs,                     '+SLineBreak+
          '                                  entrada_id,              '+SLineBreak+
          '                                  fornecedor_id,           '+SLineBreak+
          '                                  fatura_id,               '+SLineBreak+
          '                                  pedido_site,             '+SLineBreak+
          '                                  contacorrente_id,        '+SLineBreak+
          '                                  cliente_anterior_id,     '+SLineBreak+
          '                                  venda_casada)            '+SLineBreak+
          '     values (:cliente_id,                                  '+SLineBreak+
          '             :devolucao_id,                                '+SLineBreak+
          '             :data,                                        '+SLineBreak+
          '             :valor,                                       '+SLineBreak+
          '             :tipo,                                        '+SLineBreak+
          '             :obs,                                         '+SLineBreak+
          '             :entrada_id,                                  '+SLineBreak+
          '             :fornecedor_id,                               '+SLineBreak+
          '             :fatura_id,                                   '+SLineBreak+
          '             :pedido_site,                                 '+SLineBreak+
          '             :contacorrente_id,                            '+SLineBreak+
          '             :cliente_anterior_id,                         '+SLineBreak+
          '             :venda_casada)                                '+SLineBreak+
          ' returning ID                                              '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACreditoClienteModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
    lConexao.Free;
  end;
end;

function TCreditoClienteDao.alterar(ACreditoClienteModel: TCreditoClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

  lSQL :=  ' update credito_cliente                                        '+SLineBreak+
           '       set cliente_id = :cliente_id,                           '+SLineBreak+
           '           devolucao_id = :devolucao_id,                       '+SLineBreak+
           '           data = :data,                                       '+SLineBreak+
           '           valor = :valor,                                     '+SLineBreak+
           '           tipo = :tipo,                                       '+SLineBreak+
           '           obs = :obs,                                         '+SLineBreak+
           '           entrada_id = :entrada_id,                           '+SLineBreak+
           '           fornecedor_id = :fornecedor_id,                     '+SLineBreak+
           '           fatura_id = :fatura_id,                             '+SLineBreak+
           '           pedido_site = :pedido_site,                         '+SLineBreak+
           '           contacorrente_id = :contacorrente_id,               '+SLineBreak+
           '           cliente_anterior_id = :cliente_anterior_id,         '+SLineBreak+
           '           venda_casada = :venda_casada                        '+SLineBreak+
           '       where (id = :id)                                        '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value   := IIF(ACreditoClienteModel.ID   = '', Unassigned, ACreditoClienteModel.ID);
    setParams(lQry, ACreditoClienteModel);
    lQry.ExecSQL;

    Result := ACreditoClienteModel.ID;

  finally
    lSQL := '';
    lQry.Free;
    lConexao.Free;
  end;
end;

function TCreditoClienteDao.excluir(ACreditoClienteModel: TCreditoClienteModel): String;
var
  lQry: TFDQuery;
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from credito_cliente where ID = :ID',[ACreditoClienteModel.ID]);
   lQry.ExecSQL;
   Result := ACreditoClienteModel.ID;

  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

function TCreditoClienteDao.montaCondicaoQuery: String;
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
  lConexao: TConexao;
begin
  try
    lConexao := TConexao.Create;
    lQry := lConexao.CriarQuery;

    lSql := 'select count(*) records From credito_cliente where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
    lConexao.Free;
  end;
end;

procedure TCreditoClienteDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
  lConexao: TConexao;
begin
  lConexao := TConexao.Create;
  lQry := lConexao.CriarQuery;

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

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCreditoClientesLista.Add(TCreditoClienteModel.Create);

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
    lConexao.Free;
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
begin
  pQry.ParamByName('cliente_id').Value           := IIF(pCreditoClienteModel.CLIENTE_ID           = '', Unassigned, pCreditoClienteModel.CLIENTE_ID);
  pQry.ParamByName('devolucao_id').Value         := IIF(pCreditoClienteModel.DEVOLUCAO_ID         = '', Unassigned, pCreditoClienteModel.DEVOLUCAO_ID);
  pQry.ParamByName('data').Value                 := IIF(pCreditoClienteModel.DATA                 = '', Unassigned, transformaDataFireBird(pCreditoClienteModel.DATA));
  pQry.ParamByName('valor').Value                := IIF(pCreditoClienteModel.VALOR                = '', Unassigned, FormataFloatFireBird(pCreditoClienteModel.VALOR));
  pQry.ParamByName('tipo').Value                 := IIF(pCreditoClienteModel.TIPO                 = '', Unassigned, pCreditoClienteModel.TIPO);
  pQry.ParamByName('obs').Value                  := IIF(pCreditoClienteModel.OBS                  = '', Unassigned, pCreditoClienteModel.OBS);
  pQry.ParamByName('entrada_id').Value           := IIF(pCreditoClienteModel.ENTRADA_ID           = '', Unassigned, pCreditoClienteModel.ENTRADA_ID);
  pQry.ParamByName('fornecedor_id').Value        := IIF(pCreditoClienteModel.FORNECEDOR_ID        = '', Unassigned, pCreditoClienteModel.FORNECEDOR_ID);
  pQry.ParamByName('fatura_id').Value            := IIF(pCreditoClienteModel.FATURA_ID            = '', Unassigned, pCreditoClienteModel.FATURA_ID);
  pQry.ParamByName('pedido_site').Value          := IIF(pCreditoClienteModel.PEDIDO_SITE          = '', Unassigned, pCreditoClienteModel.PEDIDO_SITE);
  pQry.ParamByName('contacorrente_id').Value     := IIF(pCreditoClienteModel.CONTACORRENTE_ID     = '', Unassigned, pCreditoClienteModel.CONTACORRENTE_ID);
  pQry.ParamByName('cliente_anterior_id').Value  := IIF(pCreditoClienteModel.CLIENTE_ANTERIOR_ID  = '', Unassigned, pCreditoClienteModel.CLIENTE_ANTERIOR_ID);
  pQry.ParamByName('venda_casada').Value         := IIF(pCreditoClienteModel.VENDA_CASADA         = '', Unassigned, pCreditoClienteModel.VENDA_CASADA);
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
