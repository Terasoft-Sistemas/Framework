unit ReservaDao;

interface

uses
  ReservaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TReservaDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

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

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pReservaModel: TReservaModel): String;
    function alterar(pReservaModel: TReservaModel): String;
    function excluir(pReservaModel: TReservaModel): String;

    function AtualizaReservaVendaAssistida(pReservaModel: TReservaModel): String;

    function carregaClasse(pID : String): TReservaModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pReservaModel: TReservaModel);

end;

implementation

uses
  System.Rtti;

{ TReserva }

function TReservaDao.carregaClasse(pID : String): TReservaModel;
var
  lQry: TFDQuery;
  lModel: TReservaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TReservaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from RESERVA where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                     := lQry.FieldByName('ID').AsString;
    lModel.PRODUTO_ID             := lQry.FieldByName('PRODUTO_ID').AsString;
    lModel.CLIENTE_ID             := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.VENDEDOR_ID            := lQry.FieldByName('VENDEDOR_ID').AsString;
    lModel.QUANTIDADE             := lQry.FieldByName('QUANTIDADE').AsString;
    lModel.VALOR_UNITARIO         := lQry.FieldByName('VALOR_UNITARIO').AsString;
    lModel.DESCONTO               := lQry.FieldByName('DESCONTO').AsString;
    lModel.DATA                   := lQry.FieldByName('DATA').AsString;
    lModel.HORAS_BAIXA            := lQry.FieldByName('HORAS_BAIXA').AsString;
    lModel.STATUS                 := lQry.FieldByName('STATUS').AsString;
    lModel.HORA                   := lQry.FieldByName('HORA').AsString;
    lModel.FILIAL                 := lQry.FieldByName('FILIAL').AsString;
    lModel.PEDIDO_ID              := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.INFORMACOES_PED        := lQry.FieldByName('INFORMACOES_PED').AsString;
    lModel.OBSERVACAO             := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.WEB_PEDIDOITENS_ID     := lQry.FieldByName('WEB_PEDIDOITENS_ID').AsString;
    lModel.TIPO                   := lQry.FieldByName('TIPO').AsString;
    lModel.DATAHORA_EFETIVADA     := lQry.FieldByName('DATAHORA_EFETIVADA').AsString;
    lModel.RETIRA_LOJA            := lQry.FieldByName('RETIRA_LOJA').AsString;
    lModel.ENTREGA                := lQry.FieldByName('ENTREGA').AsString;
    lModel.ENTREGA_DATA           := lQry.FieldByName('ENTREGA_DATA').AsString;
    lModel.ENTREGA_HORA           := lQry.FieldByName('ENTREGA_HORA').AsString;
    lModel.MONTAGEM_DATA          := lQry.FieldByName('MONTAGEM_DATA').AsString;
    lModel.MONTAGEM_HORA          := lQry.FieldByName('MONTAGEM_HORA').AsString;
    lModel.SYSTIME                := lQry.FieldByName('SYSTIME').AsString;
    lModel.PRODUCAO_ID            := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.PRODUCAO_LOJA          := lQry.FieldByName('PRODUCAO_LOJA').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TReservaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TReservaDao.Destroy;
begin
  inherited;
end;

function TReservaDao.incluir(pReservaModel: TReservaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('RESERVA', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pReservaModel.ID := vIConexao.Generetor('GEN_RESERVA');
    setParams(lQry, pReservaModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TReservaDao.alterar(pReservaModel: TReservaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('RESERVA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pReservaModel);
    lQry.ExecSQL;

    Result := pReservaModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TReservaDao.AtualizaReservaVendaAssistida(pReservaModel: TReservaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=
          ' update reserva                          '+
          ' set                                     '+
          '     cliente_id = :cliente_id,           '+
          '     vendedor_id = :vendedor_id,         '+
          '     filial = :filial,                   '+
          '     informacoes_ped = :informacoes_ped, '+
          '     entrega = :entrega,                 '+
          '     entrega_data = :entrega_data,       '+
          '     entrega_hora = :entrega_hora,       '+
          '     montagem_data = :montagem_data,     '+
          '     montagem_hora = :montagem_hora,     '+
          ' where                                   '+
          '     (web_pedido_id = :web_pedido_id)    ';


  try
    lQry.SQL.Add(lSQL);

    //Incluir parametros



    lQry.ExecSQL;

    Result := pReservaModel.web_pedido_id;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TReservaDao.excluir(pReservaModel: TReservaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from RESERVA where ID = :ID ', [pReservaModel.ID]);
   lQry.ExecSQL;
   Result := pReservaModel.ID;
  finally
    lQry.Free;
  end;
end;

function TReservaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TReservaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From RESERVA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TReservaDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                         '+SLineBreak+
              '         reserva.*,                                                            '+SLineBreak+
              '         produto.nome_pro PRODUTO,                                             '+SLineBreak+
              '         funcionario.nome_fun VENDEDOR                                         '+SLineBreak+
              '    from reserva                                                               '+SLineBreak+
              '    left join produto on produto.codigo_pro = reserva.produto_id               '+SLineBreak+
              '    left join funcionario on funcionario.codigo_fun = reserva.vendedor_id      '+SLineBreak+
              '   where 1=1                                                                   '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TReservaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TReservaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TReservaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TReservaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TReservaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TReservaDao.setParams(var pQry: TFDQuery; pReservaModel: TReservaModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('RESERVA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TReservaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pReservaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pReservaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TReservaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TReservaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TReservaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
