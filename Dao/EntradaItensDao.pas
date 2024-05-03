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
    FCONCILIACAO_VALOR_UNIDADE: Real;
    FCONCILIACAO_NOME_PRODUTO: String;
    FCONCILIACAO_QUANTIDADE: Real;
    FCONCILIACAO_ORIGEM: String;
    FCONCILIACAO_DIVISOR: Real;
    FCONCILIACAO_MULTIPLICADOR: Real;
    FCONCILIACAO_ID_PRODUTO: String;
    FCONCILIACAO_UNIDADE_PRODUTO: String;
    FNumeroView: Variant;
    FFornecedorView: Variant;
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
    procedure SetCONCILIACAO_DIVISOR(const Value: Real);
    procedure SetCONCILIACAO_ID_PRODUTO(const Value: String);
    procedure SetCONCILIACAO_MULTIPLICADOR(const Value: Real);
    procedure SetCONCILIACAO_NOME_PRODUTO(const Value: String);
    procedure SetCONCILIACAO_ORIGEM(const Value: String);
    procedure SetCONCILIACAO_QUANTIDADE(const Value: Real);
    procedure SetCONCILIACAO_UNIDADE_PRODUTO(const Value: String);
    procedure SetCONCILIACAO_VALOR_UNIDADE(const Value: Real);
    procedure SetFornecedorView(const Value: Variant);
    procedure SetNumeroView(const Value: Variant);

  public

    property CONCILIACAO_ID_PRODUTO      :String read FCONCILIACAO_ID_PRODUTO write SetCONCILIACAO_ID_PRODUTO;
    property CONCILIACAO_NOME_PRODUTO    :String read FCONCILIACAO_NOME_PRODUTO write SetCONCILIACAO_NOME_PRODUTO;
    property CONCILIACAO_UNIDADE_PRODUTO :String read FCONCILIACAO_UNIDADE_PRODUTO write SetCONCILIACAO_UNIDADE_PRODUTO;
    property CONCILIACAO_ORIGEM          :String read FCONCILIACAO_ORIGEM write SetCONCILIACAO_ORIGEM;
    property CONCILIACAO_QUANTIDADE      :Real read FCONCILIACAO_QUANTIDADE write SetCONCILIACAO_QUANTIDADE;
    property CONCILIACAO_VALOR_UNIDADE   :Real read FCONCILIACAO_VALOR_UNIDADE write SetCONCILIACAO_VALOR_UNIDADE;
    property CONCILIACAO_DIVISOR         :Real read FCONCILIACAO_DIVISOR write SetCONCILIACAO_DIVISOR;
    property CONCILIACAO_MULTIPLICADOR   :Real read FCONCILIACAO_MULTIPLICADOR write SetCONCILIACAO_MULTIPLICADOR;

    procedure ConciliaItemEntrada;

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
    property FornecedorView : Variant read FFornecedorView write SetFornecedorView;
    property NumeroView : Variant read FNumeroView write SetNumeroView;
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

procedure TEntradaItensDao.ConciliaItemEntrada;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL :=
            ' select                                                                                  '+
            '     p2.codigo_pro VINCULO_FORNECEDOR_CODIGO,                                            '+
            '     p2.nome_pro PRODUTO_NOME_FORNEC,                                                    '+
            '     p2.unidade_pro MEDIDA_NOME_FORNEC,                                                  '+
            '     p2.divizor DIVISOR_FORNEC,                                                          '+
            '     p2.multiplicador MULTIPLICADOR_FORNEC,                                              '+
            '     p.codigo_pro VINCULO_EAN,                                                           '+
            '     p.nome_pro PRODUTO_NOME_EAN,                                                        '+
            '     p.unidade_pro MEDIDA_NOME_EAN,                                                      '+
            '     p.divizor DIVISOR_EAN,                                                              '+
            '     p.multiplicador MULTIPLICADOR_EAN                                                   '+

            ' from                                                                                    '+
            '     entradaitens i                                                                      '+

            ' left join entrada e on e.numero_ent = i.numero_ent and e.codigo_for = i.codigo_for      '+
            ' left join fornecedor f on f.codigo_for = e.codigo_for                                   '+
            ' left join produto p on p.barras_pro = i.cean and p.barras_pro <> ''SEM GTIN''           '+
            ' left join produto p2 on p2.fornecedor_codigo = i.cprod and p2.codigo_for = e.codigo_for '+

            ' where i.id = ' + FIDRecordView.ToString;

    lQry.Open(lSQL);

    if lQry.FieldByName('VINCULO_EAN').AsString <> '' then
    begin
      FCONCILIACAO_ID_PRODUTO      := lQry.FieldByName('VINCULO_EAN').AsString;
      FCONCILIACAO_NOME_PRODUTO    := lQry.FieldByName('PRODUTO_NOME_EAN').AsString;
      FCONCILIACAO_UNIDADE_PRODUTO := lQry.FieldByName('MEDIDA_NOME_EAN').AsString;
      FCONCILIACAO_ORIGEM          := 'EAN';
      FCONCILIACAO_DIVISOR         := lQry.FieldByName('DIVISOR_EAN').AsFloat;
      FCONCILIACAO_MULTIPLICADOR   := lQry.FieldByName('MULTIPLICADOR_EAN').AsFloat;
    end else
    if lQry.FieldByName('VINCULO_FORNECEDOR_CODIGO').AsString <> '' then
    begin
      FCONCILIACAO_ID_PRODUTO    := lQry.FieldByName('VINCULO_FORNECEDOR_CODIGO').AsString;
      FCONCILIACAO_NOME_PRODUTO  := lQry.FieldByName('PRODUTO_NOME_FORNEC').AsString;
      FCONCILIACAO_UNIDADE_PRODUTO := lQry.FieldByName('MEDIDA_NOME_FORNEC').AsString;
      FCONCILIACAO_ORIGEM        := 'FORNECEDOR';
      FCONCILIACAO_DIVISOR       := lQry.FieldByName('DIVISOR_FORNEC').AsFloat;
      FCONCILIACAO_MULTIPLICADOR := lQry.FieldByName('MULTIPLICADOR_FORNEC').AsFloat;
    end else
    begin
      FCONCILIACAO_ID_PRODUTO      := '';
      FCONCILIACAO_NOME_PRODUTO    := '';
      FCONCILIACAO_UNIDADE_PRODUTO := '';
      FCONCILIACAO_ORIGEM          := '';
      FCONCILIACAO_DIVISOR         := 0;
      FCONCILIACAO_MULTIPLICADOR   := 0;
    end;

    lQry.Close;

  finally
    lQry.Free;
  end;
end;



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
    lModel.CPROD                          := lQry.FieldByName('CPROD').AsString;
    lModel.CEAN                           := lQry.FieldByName('CEAN').AsString;
    lModel.CBARRA                         := lQry.FieldByName('CBARRA').AsString;
    lModel.CEST                           := lQry.FieldByName('CEST').AsString;
    lModel.XPROD                          := lQry.FieldByName('XPROD').AsString;
    lModel.UCOM                           := lQry.FieldByName('UCOM').AsString;
    lModel.QUANTIDADE_NF                  := lQry.FieldByName('QUANTIDADE_NF').AsString;
    lModel.VALOR_UNITARIO_NF              := lQry.FieldByName('VALOR_UNITARIO_NF').AsString;
    lModel.ORIGEM_CONCILIACAO_PRODUTO     := lQry.FieldByName('ORIGEM_CONCILIACAO_PRODUTO').AsString;

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
    lSQL := lSQL + ' and ENTRADAITENS.ID = '+IntToStr(FIDRecordView);

  if FNumeroView <> '' then
    lSQL := lSQL + ' and ENTRADAITENS.NUMERO_ENT = ' + QuotedStr(FNumeroView);

  if FFornecedorView <> '' then
    lSQL := lSQL + ' and ENTRADAITENS.CODIGO_FOR = ' + QuotedStr(FFornecedorView);

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


    lSQL := '     select  '+lPaginacao+'                                                                                                          '+SLineBreak+
            '        ID,                                                                                                                          '+SLineBreak+
            '        NUMERO_ENT,                                                                                                                  '+SLineBreak+
            '        PRODUTO_CODIGO_PRO,                                                                                                          '+SLineBreak+
            '        PRODUTO_NOME_PRO,                                                                                                            '+SLineBreak+
            '        PRODUTO_UNIDADE_PRO,                                                                                                         '+SLineBreak+
            '        PRODUTO_BARRAS_PRO,                                                                                                          '+SLineBreak+
            '        CFOP,                                                                                                                        '+SLineBreak+
            '        CFOP_ID,                                                                                                                     '+SLineBreak+
            '        CFOP_CFOP,                                                                                                                   '+SLineBreak+
            '        NCM,                                                                                                                         '+SLineBreak+
            '        CST,                                                                                                                         '+SLineBreak+
            '        CPROD,                                                                                                                       '+SLineBreak+
            '        CEAN,                                                                                                                        '+SLineBreak+
            '        CBARRA,                                                                                                                      '+SLineBreak+
            '        CEST,                                                                                                                        '+SLineBreak+
            '        XPROD,                                                                                                                       '+SLineBreak+
            '        UCOM,                                                                                                                        '+SLineBreak+
            '        QUANTIDADE_NF,                                                                                                               '+SLineBreak+
            '        VALOR_UNITARIO_NF,                                                                                                           '+SLineBreak+
            '        DIVISOR,                                                                                                                     '+SLineBreak+
            '        MULTIPLICADODR,                                                                                                              '+SLineBreak+
            '        ORIGEM_CONCILIACAO_PRODUTO,                                                                                                  '+SLineBreak+
            '        QUANTIDADE,                                                                                                                  '+SLineBreak+
            '        VALOR_FRETE,                                                                                                                 '+SLineBreak+
            '        VALOR_FRETE_2, valor_unitario,                                                                                               '+SLineBreak+
            '        VALOR_OUTRAS_DESPESAS,                                                                                                       '+SLineBreak+
            '        VALOR_BASE_IPI,                                                                                                              '+SLineBreak+
            '        ALIQUOTA_IPI,                                                                                                                '+SLineBreak+
            '        VALOR_IPI,                                                                                                                   '+SLineBreak+
            '        ICMS_ORIGEM,                                                                                                                 '+SLineBreak+
            '        PERCENTUAL_RED_BC,                                                                                                           '+SLineBreak+
            '        VALOR_ICMS_RET,                                                                                                              '+SLineBreak+
            '        VALOR_BASE_ICMS,                                                                                                             '+SLineBreak+
            '        VALOR_ICMS,                                                                                                                  '+SLineBreak+
            '        ALIQUOTA_ICMS,                                                                                                               '+SLineBreak+
            '        PERCENTUAL_ICMS_ST,                                                                                                          '+SLineBreak+
            '        VALOR_ICMS_ST,                                                                                                               '+SLineBreak+
            '        PERCENTUAL_MVA_ST,                                                                                                           '+SLineBreak+
            '        PERCENTUAL_RED_BC_ST,                                                                                                        '+SLineBreak+
            '        VALOR_BASE_ST,                                                                                                               '+SLineBreak+
            '        ALIQUOTA_FCP,                                                                                                                '+SLineBreak+
            '        VALOR_BASE_FCP,                                                                                                              '+SLineBreak+
            '        VALOR_FCP,                                                                                                                   '+SLineBreak+
            '        ALIQUOTA_FCP_ST,                                                                                                             '+SLineBreak+
            '        VALOR_BC_FCP_ST,                                                                                                             '+SLineBreak+
            '        VALOR_FCP_ST,                                                                                                                '+SLineBreak+
            '        VALOR_BASE_PIS,                                                                                                              '+SLineBreak+
            '        ALIQUOTA_PIS,                                                                                                                '+SLineBreak+
            '        VALOR_PIS,                                                                                                                   '+SLineBreak+
            '        VALOR_BASE_CONFINS,                                                                                                          '+SLineBreak+
            '        ALIQUOTA_CONFINS,                                                                                                            '+SLineBreak+
            '        VALOR_COFINS,                                                                                                                '+SLineBreak+
            '        DESCONTO,                                                                                                                    '+SLineBreak+
            '        UNITARIO_LIQUIDO,                                                                                                            '+SLineBreak+
            '        UNITARIO_TOTAL,                                                                                                              '+SLineBreak+
            '        TOTAL_LIQUIDO,                                                                                                               '+SLineBreak+
            '        VALOR_TOTAL                                                                                                                  '+SLineBreak+
            '                from                                                                                                                 '+SLineBreak+
            '                (select                                                                                                              '+SLineBreak+
            '                        id,                                                                                                          '+SLineBreak+
            '                        numero_ent,                                                                                                  '+SLineBreak+
            '                        produto_codigo_pro,                                                                                          '+SLineBreak+
            '                        produto_nome_pro,                                                                                            '+SLineBreak+
            '                        produto_unidade_pro,                                                                                         '+SLineBreak+
            '                        produto_barras_pro,                                                                                          '+SLineBreak+
            '                        cfop,                                                                                                        '+SLineBreak+
            '                        cfop_id,                                                                                                     '+SLineBreak+
            '                        cfop_cfop,                                                                                                   '+SLineBreak+
            '                        ncm,                                                                                                         '+SLineBreak+
            '                        cst,                                                                                                         '+SLineBreak+
            '                        cprod,                                                                                                       '+SLineBreak+
            '                        cean,                                                                                                        '+SLineBreak+
            '                        cbarra,                                                                                                      '+SLineBreak+
            '                        cest,                                                                                                        '+SLineBreak+
            '                        xprod,                                                                                                       '+SLineBreak+
            '                        ucom,                                                                                                        '+SLineBreak+
            '                        quantidade_nf,                                                                                               '+SLineBreak+
            '                        valor_unitario_nf,                                                                                           '+SLineBreak+
            '                        divisor,                                                                                                     '+SLineBreak+
            '                        multiplicadodr,                                                                                              '+SLineBreak+
            '                        origem_conciliacao_produto,                                                                                  '+SLineBreak+
            '                        quantidade,                                                                                                  '+SLineBreak+
            '                        valor_unitario,                                                                                              '+SLineBreak+
            '                        valor_frete,                                                                                                 '+SLineBreak+
            '                        valor_frete_2,                                                                                               '+SLineBreak+
            '                        valor_outras_despesas,                                                                                       '+SLineBreak+
            '                        valor_base_ipi,                                                                                              '+SLineBreak+
            '                        aliquota_ipi,                                                                                                '+SLineBreak+
            '                        valor_ipi,                                                                                                   '+SLineBreak+
            '                        icms_origem,                                                                                                 '+SLineBreak+
            '                        percentual_red_bc,                                                                                           '+SLineBreak+
            '                        valor_icms_ret,                                                                                              '+SLineBreak+
            '                        valor_base_icms,                                                                                             '+SLineBreak+
            '                        valor_icms,                                                                                                  '+SLineBreak+
            '                        aliquota_icms,                                                                                               '+SLineBreak+
            '                        percentual_icms_st,                                                                                          '+SLineBreak+
            '                        valor_icms_st,                                                                                               '+SLineBreak+
            '                        percentual_mva_st,                                                                                           '+SLineBreak+
            '                        percentual_red_bc_st,                                                                                        '+SLineBreak+
            '                        valor_base_st,                                                                                               '+SLineBreak+
            '                        aliquota_fcp,                                                                                                '+SLineBreak+
            '                        valor_base_fcp,                                                                                              '+SLineBreak+
            '                        valor_fcp,                                                                                                   '+SLineBreak+
            '                        aliquota_fcp_st,                                                                                             '+SLineBreak+
            '                        valor_bc_fcp_st,                                                                                             '+SLineBreak+
            '                        valor_fcp_st,                                                                                                '+SLineBreak+
            '                        valor_base_pis,                                                                                              '+SLineBreak+
            '                        aliquota_pis,                                                                                                '+SLineBreak+
            '                        valor_pis,                                                                                                   '+SLineBreak+
            '                        valor_base_confins,                                                                                          '+SLineBreak+
            '                        aliquota_confins,                                                                                            '+SLineBreak+
            '                        valor_cofins,                                                                                                '+SLineBreak+
            '                        desconto,                                                                                                    '+SLineBreak+
            '                        (total_unitario - desconto) / quantidade unitario_liquido,                                                   '+SLineBreak+
            '                        total_unitario - desconto total_liquido,                                                                     '+SLineBreak+
            '                        (total_unitario                                                                                              '+SLineBreak+
            '                                   + valor_ipi                                                                                       '+SLineBreak+
            '                                   + valor_icms_st                                                                                   '+SLineBreak+
            '                                   + valor_frete                                                                                     '+SLineBreak+
            '                                   + valor_frete_2                                                                                   '+SLineBreak+
            '                                   + valor_outras_despesas                                                                           '+SLineBreak+
            '                                   + valor_fcp_st                                                                                    '+SLineBreak+
            '                                   - desconto) / quantidade unitario_total,                                                          '+SLineBreak+
            '                        total_unitario                                                                                               '+SLineBreak+
            '                                   + valor_ipi                                                                                       '+SLineBreak+
            '                                   + valor_icms_st                                                                                   '+SLineBreak+
            '                                   + valor_frete                                                                                     '+SLineBreak+
            '                                   + valor_frete_2                                                                                   '+SLineBreak+
            '                                   + valor_outras_despesas                                                                           '+SLineBreak+
            '                                   + valor_fcp_st                                                                                    '+SLineBreak+
            '                                   - desconto valor_total                                                                            '+SLineBreak+
            '                                      from                                                                                           '+SLineBreak+
            '                                      (select                                                                                        '+SLineBreak+
            '                                            entradaitens.id,                                                                         '+SLineBreak+
            '                                            entradaitens.numero_ent numero_ent,                                                      '+SLineBreak+
            '                                            entradaitens.codigo_pro produto_codigo_pro,                                              '+SLineBreak+
            '                                            produto.nome_pro produto_nome_pro,                                                       '+SLineBreak+
            '                                            produto.unidade_pro produto_unidade_pro,                                                 '+SLineBreak+
            '                                            produto.barras_pro produto_barras_pro,                                                   '+SLineBreak+
            '                                            entradaitens.cfop,                                                                       '+SLineBreak+
            '                                            entradaitens.cfop_id,                                                                    '+SLineBreak+
            '                                            cfop.cfop cfop_cfop,                                                                     '+SLineBreak+
            '                                            entradaitens.ncm_i05 ncm,                                                                '+SLineBreak+
            '                                            entradaitens.cst_ent cst,                                                                '+SLineBreak+
            '                                            entradaitens.cprod,                                                                      '+SLineBreak+
            '                                            entradaitens.cean,                                                                       '+SLineBreak+
            '                                            entradaitens.cbarra,                                                                     '+SLineBreak+
            '                                            entradaitens.cest,                                                                       '+SLineBreak+
            '                                            entradaitens.xprod,                                                                      '+SLineBreak+
            '                                            entradaitens.ucom,                                                                       '+SLineBreak+
            '                                            entradaitens.quantidade_nf,                                                              '+SLineBreak+
            '                                            entradaitens.valor_unitario_nf,                                                          '+SLineBreak+
            '                                            entradaitens.divisor,                                                                    '+SLineBreak+
            '                                            entradaitens.multiplicadodr,                                                             '+SLineBreak+
            '                                            entradaitens.origem_conciliacao_produto,                                                 '+SLineBreak+
            '                                            coalesce(entradaitens.quantidade_ent, 0) quantidade,                                     '+SLineBreak+
            '                                            coalesce(entradaitens.valoruni_ent, 0) valor_unitario,                                   '+SLineBreak+
            '                                            coalesce(entradaitens.vfrete_i15, 0) valor_frete,                                        '+SLineBreak+
            '                                            coalesce(entradaitens.vfrete_i15_2, 0) valor_frete_2,                                    '+SLineBreak+
            '                                            coalesce(entradaitens.vseg_i16, 0) valor_outras_despesas,                                '+SLineBreak+
            '                                            coalesce(entradaitens.vbc_o10, 0) valor_base_ipi,                                        '+SLineBreak+
            '                                            coalesce(entradaitens.ipi_ent, 0) aliquota_ipi,                                          '+SLineBreak+
            '                                            coalesce(entradaitens.vipi_014, 0) valor_ipi,                                            '+SLineBreak+
            '                                            coalesce(entradaitens.orig_n11, 0) icms_origem,                                          '+SLineBreak+
            '                                            coalesce(entradaitens.predbc_n14, 0) percentual_red_bc,                                  '+SLineBreak+
            '                                            coalesce(entradaitens.vicmsstret, 0) valor_icms_ret,                                     '+SLineBreak+
            '                                            coalesce(entradaitens.base_icms_ent, 0) valor_base_icms,                                 '+SLineBreak+
            '                                            coalesce(entradaitens.vicms_n17, 0) valor_icms,                                          '+SLineBreak+
            '                                            coalesce(entradaitens.icms_ent, 0) aliquota_icms,                                        '+SLineBreak+
            '                                            coalesce(entradaitens.icms_st_ent, 0) percentual_icms_st,                                '+SLineBreak+
            '                                            coalesce(entradaitens.vicms_st_ent, 0) valor_icms_st,                                    '+SLineBreak+
            '                                            coalesce(entradaitens.pmvast_n19, 0) percentual_mva_st,                                  '+SLineBreak+
            '                                            coalesce(entradaitens.predbcst_n20, 0) percentual_red_bc_st,                             '+SLineBreak+
            '                                            coalesce(entradaitens.base_st_ent, 0) valor_base_st,                                     '+SLineBreak+
            '                                            coalesce(entradaitens.pfcp, 0) aliquota_fcp,                                             '+SLineBreak+
            '                                            coalesce(entradaitens.vbcfpc, 0) valor_base_fcp,                                         '+SLineBreak+
            '                                            coalesce(entradaitens.vfcp, 0) valor_fcp,                                                '+SLineBreak+
            '                                            coalesce(entradaitens.pfcpst, 0) aliquota_fcp_st,                                        '+SLineBreak+
            '                                            coalesce(entradaitens.vbcfcpst, 0) valor_bc_fcp_st,                                      '+SLineBreak+
            '                                            coalesce(entradaitens.vfcpst, 0) valor_fcp_st,                                           '+SLineBreak+
            '                                            coalesce(entradaitens.vbc_q07, 0) valor_base_pis,                                        '+SLineBreak+
            '                                            coalesce(entradaitens.ppis_q08, 0) aliquota_pis,                                         '+SLineBreak+
            '                                            coalesce(entradaitens.vpis_q09, 0) valor_pis,                                            '+SLineBreak+
            '                                            coalesce(entradaitens.vbc_s07, 0) valor_base_confins,                                    '+SLineBreak+
            '                                            coalesce(entradaitens.pcofins_s08, 0) aliquota_confins,                                  '+SLineBreak+
            '                                            coalesce(entradaitens.cofins, 0) valor_cofins,                                           '+SLineBreak+
            '                                            coalesce(entradaitens.desc_i17, 0) desconto,                                             '+SLineBreak+
            '                                            coalesce(entradaitens.quantidade_ent * entradaitens.valoruni_ent, 0) total_unitario      '+SLineBreak+
            '                                       from entradaitens                                                                             '+SLineBreak+
            '                                  left join produto on produto.codigo_pro = entradaitens.codigo_pro                                  '+SLineBreak+
            '                                  left join cfop on cfop.id = entradaitens.cfop_id                                                   '+SLineBreak+
            '                                  where 1=1                                                                                          '+SLineBreak;

    lSQL := lSQL + where;

    lSQL := lSQL + '       )   '+SLineBreak+
                   '  )        '+SLineBreak;


    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TEntradaItensDao.SetCONCILIACAO_DIVISOR(const Value: Real);
begin
  FCONCILIACAO_DIVISOR := Value;
end;

procedure TEntradaItensDao.SetCONCILIACAO_ID_PRODUTO(const Value: String);
begin
  FCONCILIACAO_ID_PRODUTO := Value;
end;

procedure TEntradaItensDao.SetCONCILIACAO_MULTIPLICADOR(const Value: Real);
begin
  FCONCILIACAO_MULTIPLICADOR := Value;
end;

procedure TEntradaItensDao.SetCONCILIACAO_NOME_PRODUTO(const Value: String);
begin
  FCONCILIACAO_NOME_PRODUTO := Value;
end;

procedure TEntradaItensDao.SetCONCILIACAO_ORIGEM(const Value: String);
begin
  FCONCILIACAO_ORIGEM := Value;
end;

procedure TEntradaItensDao.SetCONCILIACAO_QUANTIDADE(const Value: Real);
begin
  FCONCILIACAO_QUANTIDADE := Value;
end;

procedure TEntradaItensDao.SetCONCILIACAO_UNIDADE_PRODUTO(const Value: String);
begin
  FCONCILIACAO_UNIDADE_PRODUTO := Value;
end;

procedure TEntradaItensDao.SetCONCILIACAO_VALOR_UNIDADE(const Value: Real);
begin
  FCONCILIACAO_VALOR_UNIDADE := Value;
end;

procedure TEntradaItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TEntradaItensDao.SetFornecedorView(const Value: Variant);
begin
  FFornecedorView := Value;
end;

procedure TEntradaItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEntradaItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TEntradaItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TEntradaItensDao.SetNumeroView(const Value: Variant);
begin
  FNumeroView := Value;
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
