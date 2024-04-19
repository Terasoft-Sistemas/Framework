unit PedidoCompraItensDao;

interface

uses
  PedidoCompraItensModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type

  TPedidoCompraItensDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FNumeroView: String;
    FFornecedorView: String;
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
    procedure SetFornecedorView(const Value: String);
    procedure SetNumeroView(const Value: String);

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
    property NumeroView : String read FNumeroView write SetNumeroView;
    property FornecedorView : String read FFornecedorView write SetFornecedorView;

    function incluir(pPedidoCompraItensModel: TPedidoCompraItensModel): String;
    function alterar(pPedidoCompraItensModel: TPedidoCompraItensModel): String;
    function excluir(pPedidoCompraItensModel: TPedidoCompraItensModel): String;

    function carregaClasse(pID : String): TPedidoCompraItensModel;
    function obterLista: TFDMemTable;
    procedure setParams(var pQry: TFDQuery; pPedidoCompraItensModel: TPedidoCompraItensModel);

end;

implementation

uses
  System.Rtti;

{ TPedidoCompraItens }

function TPedidoCompraItensDao.carregaClasse(pID : String): TPedidoCompraItensModel;
var
  lQry: TFDQuery;
  lModel: TPedidoCompraItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPedidoCompraItensModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PEDIDOCOMPRAITENS where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                      := lQry.FieldByName('ID').AsString;
    lModel.NUMERO_PED              := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.CODIGO_FOR              := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.CODIGO_PRO              := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.QUANTIDADE_PED          := lQry.FieldByName('QUANTIDADE_PED').AsString;
    lModel.VALORUNI_PED            := lQry.FieldByName('VALORUNI_PED').AsString;
    lModel.IPI_PED                 := lQry.FieldByName('IPI_PED').AsString;
    lModel.FRETE_PED               := lQry.FieldByName('FRETE_PED').AsString;
    lModel.MARGEM_PED              := lQry.FieldByName('MARGEM_PED').AsString;
    lModel.VENDAANTERIOR_PED       := lQry.FieldByName('VENDAANTERIOR_PED').AsString;
    lModel.QUANTIDADE_ATE          := lQry.FieldByName('QUANTIDADE_ATE').AsString;
    lModel.STATUS_PED              := lQry.FieldByName('STATUS_PED').AsString;
    lModel.VENDACALC_PED           := lQry.FieldByName('VENDACALC_PED').AsString;
    lModel.LOJA                    := lQry.FieldByName('LOJA').AsString;
    lModel.OBSERVACAO              := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.QUANTIDADE_ATE_ORIGINAL := lQry.FieldByName('QUANTIDADE_ATE_ORIGINAL').AsString;
    lModel.CFOP_ID                 := lQry.FieldByName('CFOP_ID').AsString;
    lModel.CST_N12                 := lQry.FieldByName('CST_N12').AsString;
    lModel.VIPI_014                := lQry.FieldByName('VIPI_014').AsString;
    lModel.VBCICMS_N15             := lQry.FieldByName('VBCICMS_N15').AsString;
    lModel.VICMS_N17               := lQry.FieldByName('VICMS_N17').AsString;
    lModel.PICMS_N16               := lQry.FieldByName('PICMS_N16').AsString;
    lModel.VBCST_N21               := lQry.FieldByName('VBCST_N21').AsString;
    lModel.VST_N23                 := lQry.FieldByName('VST_N23').AsString;
    lModel.PST_N22                 := lQry.FieldByName('PST_N22').AsString;
    lModel.VLR_DESCONTO            := lQry.FieldByName('VLR_DESCONTO').AsString;
    lModel.VLR_OUTRAS              := lQry.FieldByName('VLR_OUTRAS').AsString;
    lModel.VFCP                    := lQry.FieldByName('VFCP').AsString;
    lModel.VFCPST                  := lQry.FieldByName('VFCPST').AsString;
    lModel.VFCPSTRET               := lQry.FieldByName('VFCPSTRET').AsString;
    lModel.PREDBC_N14              := lQry.FieldByName('PREDBC_N14').AsString;
    lModel.PMVAST_N19              := lQry.FieldByName('PMVAST_N19').AsString;
    lModel.PREDBCST_N20            := lQry.FieldByName('PREDBCST_N20').AsString;
    lModel.ORCAMENTO_ID            := lQry.FieldByName('ORCAMENTO_ID').AsString;
    lModel.SYSTIME                 := lQry.FieldByName('SYSTIME').AsString;
    lModel.ALTURA_M                := lQry.FieldByName('ALTURA_M').AsString;
    lModel.LARGURA_M               := lQry.FieldByName('LARGURA_M').AsString;
    lModel.PROFUNDIDADE_M          := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.RESERVA_ID              := lQry.FieldByName('RESERVA_ID').AsString;
    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPedidoCompraItensDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TPedidoCompraItensDao.Destroy;
begin
  inherited;
end;

function TPedidoCompraItensDao.incluir(pPedidoCompraItensModel: TPedidoCompraItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PEDIDOCOMPRAITENS', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoCompraItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoCompraItensDao.alterar(pPedidoCompraItensModel: TPedidoCompraItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PEDIDOCOMPRAITENS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoCompraItensModel);
    lQry.ExecSQL;

    Result := pPedidoCompraItensModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoCompraItensDao.excluir(pPedidoCompraItensModel: TPedidoCompraItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from PEDIDOCOMPRAITENS where ID = :ID' ,[pPedidoCompraItensModel.ID]);
   lQry.ExecSQL;
   Result := pPedidoCompraItensModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPedidoCompraItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and PEDIDOCOMPRAITENS.ID = '+IntToStr(FIDRecordView);

  if FNumeroView <> '' then
    lSQL := lSQL + ' and PEDIDOCOMPRAITENS.NUMERO_PED = '+QuotedStr(FNumeroView);

  if FFornecedorView <> '' then
    lSQL := lSQL + ' and PEDIDOCOMPRAITENS.CODIGO_FOR = '+ QuotedStr(FFornecedorView);

  Result := lSQL;
end;

procedure TPedidoCompraItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From PEDIDOCOMPRAITENS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TPedidoCompraItensDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := 'select '+ lPaginacao +' pedidocompraitens.*,                                       ' +
              '       (pedidocompraitens.quantidade_ped - quantidade_ate) as quantidade_pendente, ' +
              '       produto.nome_pro produto_nome,                                              ' +
              '       produto.unidade_pro,                                                        ' +
              '       produto.codigo_for fornecedor_codigo,                                       ' +
              '       produto.saldomin_pro produto_saldo_min,                                     ' +
              '       cfop.cfop cfop                                                              ' +
              '  from pedidocompraitens                                                           ' +
              '  left join produto on pedidocompraitens.codigo_pro = produto.codigo_pro           ' +
              '  left join cfop on pedidocompraitens.cfop_id = cfop.id                            ' +
              ' where 1=1                                                                         ';

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

procedure TPedidoCompraItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoCompraItensDao.SetFornecedorView(const Value: String);
begin
  FFornecedorView := Value;
end;

procedure TPedidoCompraItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPedidoCompraItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPedidoCompraItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoCompraItensDao.SetNumeroView(const Value: String);
begin
  FNumeroView := Value;
end;

procedure TPedidoCompraItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoCompraItensDao.setParams(var pQry: TFDQuery; pPedidoCompraItensModel: TPedidoCompraItensModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PEDIDOCOMPRAITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPedidoCompraItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPedidoCompraItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pPedidoCompraItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPedidoCompraItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPedidoCompraItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPedidoCompraItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
