unit PedidoCompraDao;

interface

uses
  PedidoCompraModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TPedidoCompraDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FNumeroView: String;
    FFornecedorVew: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetFornecedorVew(const Value: String);
    procedure SetNumeroView(const Value: String);

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property FornecedorVew: String read FFornecedorVew write SetFornecedorVew;
    property NumeroView: String read FNumeroView write SetNumeroView;

    function incluir(pPedidoCompraModel : TPedidoCompraModel): String;
    function alterar(pPedidoCompraModel : TPedidoCompraModel): String;
    function excluir(pPedidoCompraModel : TPedidoCompraModel): String;

    function carregaClasse(pID : String): TPedidoCompraModel;
    function obterLista: TFDMemTable;
    procedure setParams(var pQry: TFDQuery; pPedidoCompraModel: TPedidoCompraModel);

end;

implementation

uses
  System.Rtti;

{ TPedidoCompra }

function TPedidoCompraDao.carregaClasse(pID : String): TPedidoCompraModel;
var
  lQry: TFDQuery;
  lModel: TPedidoCompraModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPedidoCompraModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PEDIDOCOMPRA where NUMERO_PED = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_PED                      := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.CODIGO_FOR                      := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.DATA_PED                        := lQry.FieldByName('DATA_PED').AsString;
    lModel.DATAPREV_PED                    := lQry.FieldByName('DATAPREV_PED').AsString;
    lModel.PARCELAS_PED                    := lQry.FieldByName('PARCELAS_PED').AsString;
    lModel.PRIMEIROVENC_PED                := lQry.FieldByName('PRIMEIROVENC_PED').AsString;
    lModel.FRETE_PED                       := lQry.FieldByName('FRETE_PED').AsString;
    lModel.ICMS_PED                        := lQry.FieldByName('ICMS_PED').AsString;
    lModel.OUTROS_PED                      := lQry.FieldByName('OUTROS_PED').AsString;
    lModel.DESC_PED                        := lQry.FieldByName('DESC_PED').AsString;
    lModel.TOTAL_PED                       := lQry.FieldByName('TOTAL_PED').AsString;
    lModel.OBSERVACAO_PED                  := lQry.FieldByName('OBSERVACAO_PED').AsString;
    lModel.USUARIO_PED                     := lQry.FieldByName('USUARIO_PED').AsString;
    lModel.STATUS_PED                      := lQry.FieldByName('STATUS_PED').AsString;
    lModel.TOTALPRODUTOS_PED               := lQry.FieldByName('TOTALPRODUTOS_PED').AsString;
    lModel.TIPO_PRO                        := lQry.FieldByName('TIPO_PRO').AsString;
    lModel.CTR_IMPRESSAO_PED               := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
    lModel.LOJA                            := lQry.FieldByName('LOJA').AsString;
    lModel.DOLAR                           := lQry.FieldByName('DOLAR').AsString;
    lModel.CONDICOES_PAG                   := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.ID                              := lQry.FieldByName('ID').AsString;
    lModel.TRANSPORTADORA_ID               := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.STATUS_ID                       := lQry.FieldByName('STATUS_ID').AsString;
    lModel.AUTORIZADO                      := lQry.FieldByName('AUTORIZADO').AsString;
    lModel.ENVIADO                         := lQry.FieldByName('ENVIADO').AsString;
    lModel.IPI_PED                         := lQry.FieldByName('IPI_PED').AsString;
    lModel.ST_PED                          := lQry.FieldByName('ST_PED').AsString;
    lModel.TIPO_MOEDA_ESTRANGEIRA          := lQry.FieldByName('TIPO_MOEDA_ESTRANGEIRA').AsString;
    lModel.PEDIDO_FORNECEDOR               := lQry.FieldByName('PEDIDO_FORNECEDOR').AsString;
    lModel.DATA_ACEITE                     := lQry.FieldByName('DATA_ACEITE').AsString;
    lModel.AUTORIZACAO_ESTOQUE_STATUS      := lQry.FieldByName('AUTORIZACAO_ESTOQUE_STATUS').AsString;
    lModel.AUTORIZACAO_ESTOQUE_USUARIO     := lQry.FieldByName('AUTORIZACAO_ESTOQUE_USUARIO').AsString;
    lModel.AUTORIZACAO_ESTOQUE_DATAHORA    := lQry.FieldByName('AUTORIZACAO_ESTOQUE_DATAHORA').AsString;
    lModel.AUTORIZACAO_ESTOQUE_OBS         := lQry.FieldByName('AUTORIZACAO_ESTOQUE_OBS').AsString;
    lModel.AUTORIZACAO_FINANCEIRO_STATUS   := lQry.FieldByName('AUTORIZACAO_FINANCEIRO_STATUS').AsString;
    lModel.AUTORIZACAO_FINANCEIRO_USUARIO  := lQry.FieldByName('AUTORIZACAO_FINANCEIRO_USUARIO').AsString;
    lModel.AUTORIZACAO_FINANCEIRO_DATAHORA := lQry.FieldByName('AUTORIZACAO_FINANCEIRO_DATAHORA').AsString;
    lModel.AUTORIZACAO_FINANCEIRO_OBS      := lQry.FieldByName('AUTORIZACAO_FINANCEIRO_OBS').AsString;
    lModel.TIPO_FRETE                      := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.BASE_ICMS                       := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.BASE_ST                         := lQry.FieldByName('BASE_ST').AsString;
    lModel.VFCP                            := lQry.FieldByName('VFCP').AsString;
    lModel.VFCPST                          := lQry.FieldByName('VFCPST').AsString;
    lModel.HORAPREV_PED                    := lQry.FieldByName('HORAPREV_PED').AsString;
    lModel.CONTATOPREV_PED                 := lQry.FieldByName('CONTATOPREV_PED').AsString;
    lModel.TELEFONEPREV_PED                := lQry.FieldByName('TELEFONEPREV_PED').AsString;
    lModel.CALCULAR_VALORES                := lQry.FieldByName('CALCULAR_VALORES').AsString;
    lModel.USO_CONSUMO                     := lQry.FieldByName('USO_CONSUMO').AsString;
    lModel.FRETE_NO_IPI                    := lQry.FieldByName('FRETE_NO_IPI').AsString;
    lModel.PORTADOR_ID                     := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.SYSTIME                         := lQry.FieldByName('SYSTIME').AsString;
    lModel.ENVIO_WHATSAPP                  := lQry.FieldByName('ENVIO_WHATSAPP').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPedidoCompraDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TPedidoCompraDao.Destroy;
begin
  inherited;
end;

function TPedidoCompraDao.incluir(pPedidoCompraModel: TPedidoCompraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PEDIDOCOMPRA', 'NUMERO_PED', true);

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoCompraModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_PED').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoCompraDao.alterar(pPedidoCompraModel: TPedidoCompraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PEDIDOCOMPRA','NUMERO_PED');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoCompraModel);
    lQry.ExecSQL;

    Result := pPedidoCompraModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoCompraDao.excluir(pPedidoCompraModel: TPedidoCompraModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from PEDIDOCOMPRA where NUMERO_PED = ' + QuotedStr(pPedidoCompraModel.NUMERO_PED) + ' and CODIGO_FOR = ' + QuotedStr(pPedidoCompraModel.CODIGO_FOR));
   lQry.ExecSQL;
   Result := pPedidoCompraModel.NUMERO_PED;

  finally
    lQry.Free;
  end;
end;

function TPedidoCompraDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and PEDIDOCOMPRA.ID = ' +IntToStr(FIDRecordView);

  if FNumeroView <> ''  then
    lSQL := lSQL + ' and PEDIDOCOMPRA.NUMERO_PED = ' +QuotedStr(FNumeroView);

  if FFornecedorVew <> ''  then
    lSQL := lSQL + ' and PEDIDOCOMPRA.CODIGO_FOR = ' +QuotedStr(FFornecedorVew);

  Result := lSQL;
end;

procedure TPedidoCompraDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From PEDIDOCOMPRA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TPedidoCompraDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '   select ' + lPaginacao + ' pedidocompra.*,                                  '+SLineBreak+
              '          fornecedor.fantasia_for fornecedor_nome                             '+SLineBreak+
              '          from pedidocompra                                                   '+SLineBreak+
              '     left join fornecedor on fornecedor.codigo_for = pedidocompra.codigo_for  '+SLineBreak+
              '    where 1=1                                                                 '+SLineBreak;

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

procedure TPedidoCompraDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoCompraDao.SetFornecedorVew(const Value: String);
begin
  FFornecedorVew := Value;
end;

procedure TPedidoCompraDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPedidoCompraDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoCompraDao.SetNumeroView(const Value: String);
begin
  FNumeroView := Value;
end;

procedure TPedidoCompraDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoCompraDao.setParams(var pQry: TFDQuery; pPedidoCompraModel: TPedidoCompraModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PEDIDOCOMPRA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPedidoCompraModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPedidoCompraModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pPedidoCompraModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPedidoCompraDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPedidoCompraDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPedidoCompraDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
