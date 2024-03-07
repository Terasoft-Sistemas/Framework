unit EntradaItensDao;

interface

uses
  EntradaItensModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TEntradaItensDao = class

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
    FIDEntrada: String;
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
    procedure SetIDEntrada(const Value: String);

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
    property IDEntrada: String read FIDEntrada write SetIDEntrada;

    function incluir(AEntradaItensModel: TEntradaItensModel): String;
    function alterar(AEntradaItensModel: TEntradaItensModel): String;
    function excluir(AEntradaItensModel: TEntradaItensModel): String;

    function carregaClasse(pID : String): TEntradaItensModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pEntradaItensModel: TEntradaItensModel);

end;

implementation

uses
  System.Rtti;

{ TEntradaItens }

function TEntradaItensDao.carregaClasse(pID: String): TEntradaItensModel;
var
  lQry: TFDQuery;
  lModel: TEntradaItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TEntradaItensModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ENTRADAITENS where ID = '+ QuotedStr(pID));

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_ENT                     := lQry.FieldByName('NUMERO_ENT').AsString;
    lModel.CODIGO_FOR                     := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.CODIGO_PRO                     := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.QUANTIDADE_ENT                 := lQry.FieldByName('QUANTIDADE_ENT').AsString;
    lModel.VALORUNI_ENT                   := lQry.FieldByName('VALORUNI_ENT').AsString;
    lModel.IPI_ENT                        := lQry.FieldByName('IPI_ENT').AsString;
    lModel.STATUS                         := lQry.FieldByName('STATUS').AsString;
    lModel.NUMERO_LOTE                    := lQry.FieldByName('NUMERO_LOTE').AsString;
    lModel.LOJA                           := lQry.FieldByName('LOJA').AsString;
    lModel.CUSTO_COMPRA                   := lQry.FieldByName('CUSTO_COMPRA').AsString;
    lModel.ID                             := lQry.FieldByName('ID').AsString;
    lModel.VENDA_PRO                      := lQry.FieldByName('VENDA_PRO').AsString;
    lModel.VENDA2_PRO                     := lQry.FieldByName('VENDA2_PRO').AsString;
    lModel.DATA_FAB                       := lQry.FieldByName('DATA_FAB').AsString;
    lModel.DATA_VECTO                     := lQry.FieldByName('DATA_VECTO').AsString;
    lModel.ICMS_ENT                       := lQry.FieldByName('ICMS_ENT').AsString;
    lModel.BASE_ICMS_ENT                  := lQry.FieldByName('BASE_ICMS_ENT').AsString;
    lModel.SERIE_ENT                      := lQry.FieldByName('SERIE_ENT').AsString;
    lModel.BASE_ST_ENT                    := lQry.FieldByName('BASE_ST_ENT').AsString;
    lModel.ICMS_ST_ENT                    := lQry.FieldByName('ICMS_ST_ENT').AsString;
    lModel.CST_ENT                        := lQry.FieldByName('CST_ENT').AsString;
    lModel.PIS                            := lQry.FieldByName('PIS').AsString;
    lModel.COFINS                         := lQry.FieldByName('COFINS').AsString;
    lModel.VICMS_ST_ENT                   := lQry.FieldByName('VICMS_ST_ENT').AsString;
    lModel.ITEM_ENT                       := lQry.FieldByName('ITEM_ENT').AsString;
    lModel.CFOP                           := lQry.FieldByName('CFOP').AsString;
    lModel.VICMS_N17                      := lQry.FieldByName('VICMS_N17').AsString;
    lModel.MDBCST_N18                     := lQry.FieldByName('MDBCST_N18').AsString;
    lModel.PMVAST_N19                     := lQry.FieldByName('PMVAST_N19').AsString;
    lModel.PREDBCST_N20                   := lQry.FieldByName('PREDBCST_N20').AsString;
    lModel.PREDBC_N14                     := lQry.FieldByName('PREDBC_N14').AsString;
    lModel.CST_O09                        := lQry.FieldByName('CST_O09').AsString;
    lModel.CIENQ_O02                      := lQry.FieldByName('CIENQ_O02').AsString;
    lModel.CENQ_O06                       := lQry.FieldByName('CENQ_O06').AsString;
    lModel.VBC_O10                        := lQry.FieldByName('VBC_O10').AsString;
    lModel.QUNID_O11                      := lQry.FieldByName('QUNID_O11').AsString;
    lModel.VUNID_O12                      := lQry.FieldByName('VUNID_O12').AsString;
    lModel.VIPI_014                       := lQry.FieldByName('VIPI_014').AsString;
    lModel.VBC_P02                        := lQry.FieldByName('VBC_P02').AsString;
    lModel.VDESPADU_P03                   := lQry.FieldByName('VDESPADU_P03').AsString;
    lModel.VII_P04                        := lQry.FieldByName('VII_P04').AsString;
    lModel.VIOF_P05                       := lQry.FieldByName('VIOF_P05').AsString;
    lModel.ORIG_N11                       := lQry.FieldByName('ORIG_N11').AsString;
    lModel.MOBIBC_N13                     := lQry.FieldByName('MOBIBC_N13').AsString;
    lModel.CST_Q06                        := lQry.FieldByName('CST_Q06').AsString;
    lModel.VBC_Q07                        := lQry.FieldByName('VBC_Q07').AsString;
    lModel.PPIS_Q08                       := lQry.FieldByName('PPIS_Q08').AsString;
    lModel.VPIS_Q09                       := lQry.FieldByName('VPIS_Q09').AsString;
    lModel.QBCPROD_Q10                    := lQry.FieldByName('QBCPROD_Q10').AsString;
    lModel.VALIQPROD_Q11                  := lQry.FieldByName('VALIQPROD_Q11').AsString;
    lModel.VBC_R02                        := lQry.FieldByName('VBC_R02').AsString;
    lModel.PPIS_R03                       := lQry.FieldByName('PPIS_R03').AsString;
    lModel.QBCPROD_R04                    := lQry.FieldByName('QBCPROD_R04').AsString;
    lModel.VALIQPROD_R05                  := lQry.FieldByName('VALIQPROD_R05').AsString;
    lModel.VPIS_R06                       := lQry.FieldByName('VPIS_R06').AsString;
    lModel.CST_S06                        := lQry.FieldByName('CST_S06').AsString;
    lModel.VBC_S07                        := lQry.FieldByName('VBC_S07').AsString;
    lModel.PCOFINS_S08                    := lQry.FieldByName('PCOFINS_S08').AsString;
    lModel.VCOFINS_S11                    := lQry.FieldByName('VCOFINS_S11').AsString;
    lModel.QBCPROD_S09                    := lQry.FieldByName('QBCPROD_S09').AsString;
    lModel.VALIQPROD_S10                  := lQry.FieldByName('VALIQPROD_S10').AsString;
    lModel.VBC_T02                        := lQry.FieldByName('VBC_T02').AsString;
    lModel.PCOFINS_T03                    := lQry.FieldByName('PCOFINS_T03').AsString;
    lModel.QBCPROD_T04                    := lQry.FieldByName('QBCPROD_T04').AsString;
    lModel.VALIQPROD_T05                  := lQry.FieldByName('VALIQPROD_T05').AsString;
    lModel.VCOFINS_T06                    := lQry.FieldByName('VCOFINS_T06').AsString;
    lModel.VBC_U02                        := lQry.FieldByName('VBC_U02').AsString;
    lModel.VALIQ_U03                      := lQry.FieldByName('VALIQ_U03').AsString;
    lModel.VISSQN_U04                     := lQry.FieldByName('VISSQN_U04').AsString;
    lModel.CMUNFG_U05                     := lQry.FieldByName('CMUNFG_U05').AsString;
    lModel.CLISTSERV_U06                  := lQry.FieldByName('CLISTSERV_U06').AsString;
    lModel.CSITTRIB_U07                   := lQry.FieldByName('CSITTRIB_U07').AsString;
    lModel.DESC_I17                       := lQry.FieldByName('DESC_I17').AsString;
    lModel.NCM_I05                        := lQry.FieldByName('NCM_I05').AsString;
    lModel.VFRETE_I15                     := lQry.FieldByName('VFRETE_I15').AsString;
    lModel.VSEG_I16                       := lQry.FieldByName('VSEG_I16').AsString;
    lModel.CFOP_ID                        := lQry.FieldByName('CFOP_ID').AsString;
    lModel.ALIQ_CREDITO_PIS               := lQry.FieldByName('ALIQ_CREDITO_PIS').AsString;
    lModel.ALIQ_CREDITO_COFINS            := lQry.FieldByName('ALIQ_CREDITO_COFINS').AsString;
    lModel.CST_CREDITO_COFINS             := lQry.FieldByName('CST_CREDITO_COFINS').AsString;
    lModel.CST_CREDITO_PIS                := lQry.FieldByName('CST_CREDITO_PIS').AsString;
    lModel.TRIBUTA_COFINS                 := lQry.FieldByName('TRIBUTA_COFINS').AsString;
    lModel.TRIBUTA_PIS                    := lQry.FieldByName('TRIBUTA_PIS').AsString;
    lModel.CREDITA_ICMS                   := lQry.FieldByName('CREDITA_ICMS').AsString;
    lModel.CONTA_CONTABIL                 := lQry.FieldByName('CONTA_CONTABIL').AsString;
    lModel.CST_ENTRADA                    := lQry.FieldByName('CST_ENTRADA').AsString;
    lModel.SYSTIME                        := lQry.FieldByName('SYSTIME').AsString;
    lModel.ESTOQUE_2                      := lQry.FieldByName('ESTOQUE_2').AsString;
    lModel.PRECO_DOLAR                    := lQry.FieldByName('PRECO_DOLAR').AsString;
    lModel.CUSTO_COMPRA_NEW               := lQry.FieldByName('CUSTO_COMPRA_NEW').AsString;
    lModel.VBCFCPST                       := lQry.FieldByName('VBCFCPST').AsString;
    lModel.PFCPST                         := lQry.FieldByName('PFCPST').AsString;
    lModel.VFCPST                         := lQry.FieldByName('VFCPST').AsString;
    lModel.VBCFCPSTRET                    := lQry.FieldByName('VBCFCPSTRET').AsString;
    lModel.PFCPSTRET                      := lQry.FieldByName('PFCPSTRET').AsString;
    lModel.VFCPSTRET                      := lQry.FieldByName('VFCPSTRET').AsString;
    lModel.VBCFPC                         := lQry.FieldByName('VBCFPC').AsString;
    lModel.PFCP                           := lQry.FieldByName('PFCP').AsString;
    lModel.VFCP                           := lQry.FieldByName('VFCP').AsString;
    lModel.VFRETE_I15_2                   := lQry.FieldByName('VFRETE_I15_2').AsString;
    lModel.CUSTOMEDIO_ANTERIOR            := lQry.FieldByName('CUSTOMEDIO_ANTERIOR').AsString;
    lModel.CUSTOULTIMO_ANTERIOR           := lQry.FieldByName('CUSTOULTIMO_ANTERIOR').AsString;
    lModel.ATUALIZADO_VALOR_VENDA         := lQry.FieldByName('ATUALIZADO_VALOR_VENDA').AsString;
    lModel.VALOR_VENDA                    := lQry.FieldByName('VALOR_VENDA').AsString;
    lModel.QTD_CHECAGEM                   := lQry.FieldByName('QTD_CHECAGEM').AsString;
    lModel.MARGEM_PRO                     := lQry.FieldByName('MARGEM_PRO').AsString;
    lModel.VBCSTRET                       := lQry.FieldByName('VBCSTRET').AsString;
    lModel.VICMSSTRET                     := lQry.FieldByName('VICMSSTRET').AsString;
    lModel.DATA_ATUALIZACAO_PRECO_VENDA   := lQry.FieldByName('DATA_ATUALIZACAO_PRECO_VENDA').AsString;
    lModel.VALOR_ATUALIZACAO_PRECO_VENDA  := lQry.FieldByName('VALOR_ATUALIZACAO_PRECO_VENDA').AsString;
    lModel.CUSTO_DEVOLUCAO                := lQry.FieldByName('CUSTO_DEVOLUCAO').AsString;
    lModel.VICMS_ST_ORIGINAL              := lQry.FieldByName('VICMS_ST_ORIGINAL').AsString;
    lModel.BASE_ST_ORIGINAL               := lQry.FieldByName('BASE_ST_ORIGINAL').AsString;
    lModel.ICMS_ST_ORIGINAL               := lQry.FieldByName('ICMS_ST_ORIGINAL').AsString;
    lModel.VICMS_ORIGINAL                 := lQry.FieldByName('VICMS_ORIGINAL').AsString;
    lModel.VICMSSUBISTITUTORET            := lQry.FieldByName('VICMSSUBISTITUTORET').AsString;
    lModel.PICMSSTRET                     := lQry.FieldByName('PICMSSTRET').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TEntradaItensDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TEntradaItensDao.Destroy;
begin
  inherited;
end;

function TEntradaItensDao.incluir(AEntradaItensModel: TEntradaItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ENTRADAITENS', 'NUMERO_ENT');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AEntradaItensModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_ENT').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TEntradaItensDao.alterar(AEntradaItensModel: TEntradaItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('ENTRADAITENS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AEntradaItensModel);
    lQry.ExecSQL;

    Result := AEntradaItensModel.NUMERO_ENT;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TEntradaItensDao.excluir(AEntradaItensModel: TEntradaItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ENTRADAITENS where ID = :ID',[AEntradaItensModel.ID]);
   lQry.ExecSQL;
   Result := AEntradaItensModel.ID;

  finally
    lQry.Free;
  end;
end;

function TEntradaItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  if not FIDEntrada.IsEmpty then
    lSQL := lSQL + ' and  NUMERO_ENT = ' + QuotedStr(FIDEntrada);

  Result := lSQL;
end;

procedure TEntradaItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From ENTRADAITENS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TEntradaItensDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';


    lSQL := ' select ' +lPaginacao+ '                                                          '+SLineBreak+
            '        entradaitens.*,                                                           '+SLineBreak+
            '        coalesce(fornecedor.razao_for, fornecedor.fantasia_for) FORNECEDOR,       '+SLineBreak+
            '        produto.nome_pro PRODUTO,                                                 '+SLineBreak+
            '        produto.unidade_pro UNIDADE                                               '+SLineBreak+
            '   from entradaitens                                                              '+SLineBreak+
            '   left join fornecedor on fornecedor.codigo_for = entradaitens.codigo_for        '+SLineBreak+
            '   left join produto on produto.codigo_pro = entradaitens.codigo_pro              '+SLineBreak+
            '  where 1=1                                                                       '+SLineBreak;

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

procedure TEntradaItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TEntradaItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEntradaItensDao.SetIDEntrada(const Value: String);
begin
  FIDEntrada := Value;
end;

procedure TEntradaItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TEntradaItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TEntradaItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TEntradaItensDao.setParams(var pQry: TFDQuery; pEntradaItensModel: TEntradaItensModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('ENTRADAITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TEntradaItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pEntradaItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pEntradaItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TEntradaItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TEntradaItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TEntradaItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
