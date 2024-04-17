unit PrevisaoPedidoCompraDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  PrevisaoPedidoCompraModel;

type
  TPrevisaoPedidoCompraDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

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
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pPrevisaoPedidoCompraModel: TPrevisaoPedidoCompraModel): String;
    function alterar(pPrevisaoPedidoCompraModel: TPrevisaoPedidoCompraModel): String;
    function excluir(pPrevisaoPedidoCompraModel: TPrevisaoPedidoCompraModel): String;

    function carregaClasse(pID : String): TPrevisaoPedidoCompraModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pPrevisaoPedidoCompraModel: TPrevisaoPedidoCompraModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TPrevisaoPedidoCompra }

function TPrevisaoPedidoCompraDao.alterar(pPrevisaoPedidoCompraModel: TPrevisaoPedidoCompraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PREVISAO_PEDIDOCOMPRA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPrevisaoPedidoCompraModel);
    lQry.ExecSQL;

    Result := pPrevisaoPedidoCompraModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPrevisaoPedidoCompraDao.carregaClasse(pID: String): TPrevisaoPedidoCompraModel;
var
  lQry: TFDQuery;
  lModel: TPrevisaoPedidoCompraModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPrevisaoPedidoCompraModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PREVISAO_PEDIDOCOMPRA where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

      lModel.ID             := lQry.FieldByName('ID').AsString;
      lModel.VENCIMENTO     := lQry.FieldByName('VENCIMENTO').AsString;
      lModel.VALOR_PARCELA  := lQry.FieldByName('VALOR_PARCELA').AsString;
      lModel.PARCELA        := lQry.FieldByName('PARCELA').AsString;
      lModel.NUMERO_PED     := lQry.FieldByName('NUMERO_PED').AsString;
      lModel.CODIGO_FOR     := lQry.FieldByName('CODIGO_FOR').AsString;
      lModel.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TPrevisaoPedidoCompraDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TPrevisaoPedidoCompraDao.Destroy;
begin
  inherited;
end;

function TPrevisaoPedidoCompraDao.excluir(pPrevisaoPedidoCompraModel: TPrevisaoPedidoCompraModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from PREVISAO_PEDIDOCOMPRA where ID = :ID' ,[pPrevisaoPedidoCompraModel.ID]);
   lQry.ExecSQL;
   Result := pPrevisaoPedidoCompraModel.ID;

  finally
    lQry.Free;
  end;
end;
function TPrevisaoPedidoCompraDao.incluir(pPrevisaoPedidoCompraModel: TPrevisaoPedidoCompraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PREVISAO_PEDIDOCOMPRA', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pPrevisaoPedidoCompraModel.ID := vIConexao.Generetor('GEN_PREVISAO_PEDIDOCOMPRA');
    setParams(lQry, pPrevisaoPedidoCompraModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPrevisaoPedidoCompraDao.ObterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                    '+SLineBreak+
              '         PREVISAO_PEDIDOCOMPRA.ID,                                        '+SLineBreak+
              '         PREVISAO_PEDIDOCOMPRA.VENCIMENTO,                                '+SLineBreak+
              '         PREVISAO_PEDIDOCOMPRA.VALOR_PARCELA,                             '+SLineBreak+
              '         PREVISAO_PEDIDOCOMPRA.PARCELA,                                   '+SLineBreak+
              '         PREVISAO_PEDIDOCOMPRA.NUMERO_PED,                                '+SLineBreak+
              '         PREVISAO_PEDIDOCOMPRA.CODIGO_FOR                                 '+SLineBreak+
              '    from PREVISAO_PEDIDOCOMPRA                                            '+SLineBreak+
              '   where 1=1                                                              '+SLineBreak;

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

procedure TPrevisaoPedidoCompraDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From PREVISAO_PEDIDOCOMPRA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPrevisaoPedidoCompraDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPrevisaoPedidoCompraDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPrevisaoPedidoCompraDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPrevisaoPedidoCompraDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPrevisaoPedidoCompraDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrevisaoPedidoCompraDao.setParams(var pQry: TFDQuery; pPrevisaoPedidoCompraModel: TPrevisaoPedidoCompraModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PREVISAO_PEDIDOCOMPRA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPrevisaoPedidoCompraModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPrevisaoPedidoCompraModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pPrevisaoPedidoCompraModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPrevisaoPedidoCompraDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPrevisaoPedidoCompraDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPrevisaoPedidoCompraDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TPrevisaoPedidoCompraDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and ID = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

end.
