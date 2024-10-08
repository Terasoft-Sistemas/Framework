unit EntradaDao;

interface

uses
  EntradaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  ClipBrd;

type
  TEntradaDao = class;
  ITEntradaDao=IObject<TEntradaDao>;

  TEntradaDao = class
  private
    [unsafe] mySelf: ITEntradaDao;
    vIConexao : IConexao;
    vConstrutor : IConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FNumeroView: String;
    FFornecedorView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetFornecedorView(const Value: String);
    procedure SetNumeroView(const Value: String);

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEntradaDao;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property NumeroView: String read FNumeroView write SetNumeroView;
    property FornecedorView: String read FFornecedorView write SetFornecedorView;
    
    function incluir(AEntradaModel: ITEntradaModel): String;
    function alterar(AEntradaModel: ITEntradaModel): String;
    function excluir(AEntradaModel: ITEntradaModel): String;

    function carregaClasse(pEntrada, pFornecedor : String): ITEntradaModel;

    function where: String;

    function obterLista       : IFDDataset;
    function obterTotalizador : IFDDataset;

    procedure setParams(var pQry: TFDQuery; pEntradaModel: ITEntradaModel);

end;

implementation

uses
  System.Rtti;

{ TEntrada }

function TEntradaDao.carregaClasse(pEntrada, pFornecedor: String): ITEntradaModel;
var
  lQry: TFDQuery;
  lModel: ITEntradaModel;
begin
  lModel   := TEntradaModel.getNewIface(vIConexao);
  Result   := lModel;
  lQry := nil;
  try
    lQry     := vIConexao.CriarQuery;
    lQry.Open('select * from ENTRADA where NUMERO_ENT = '+ QuotedStr(pEntrada) + ' and CODIGO_FOR = ' + QuotedStr(pFornecedor) );

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_ENT                  := lQry.FieldByName('NUMERO_ENT').AsString;
    lModel.objeto.CODIGO_FOR                  := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.objeto.DATANOTA_ENT                := lQry.FieldByName('DATANOTA_ENT').AsString;
    lModel.objeto.DATAMOVI_ENT                := lQry.FieldByName('DATAMOVI_ENT').AsString;
    lModel.objeto.PARCELAS_ENT                := lQry.FieldByName('PARCELAS_ENT').AsString;
    lModel.objeto.PRIMEIROVENC_ENT            := lQry.FieldByName('PRIMEIROVENC_ENT').AsString;
    lModel.objeto.FRETE_ENT                   := lQry.FieldByName('FRETE_ENT').AsString;
    lModel.objeto.IPI_ENT                     := lQry.FieldByName('IPI_ENT').AsString;
    lModel.objeto.ICMS_ENT                    := lQry.FieldByName('ICMS_ENT').AsString;
    lModel.objeto.OUTROS_ENT                  := lQry.FieldByName('OUTROS_ENT').AsString;
    lModel.objeto.DESC_ENT                    := lQry.FieldByName('DESC_ENT').AsString;
    lModel.objeto.TOTAL_ENT                   := lQry.FieldByName('TOTAL_ENT').AsString;
    lModel.objeto.OBSERVACAO_ENT              := lQry.FieldByName('OBSERVACAO_ENT').AsString;
    lModel.objeto.USUARIO_ENT                 := lQry.FieldByName('USUARIO_ENT').AsString;
    lModel.objeto.STATUS                      := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.TOTALPRODUTOS_ENT           := lQry.FieldByName('TOTALPRODUTOS_ENT').AsString;
    lModel.objeto.TIPO_PRO                    := lQry.FieldByName('TIPO$_PRO').AsString;
    lModel.objeto.CFOP_ENT                    := lQry.FieldByName('CFOP_ENT').AsString;
    lModel.objeto.DESPESAS_ADUANEIRAS         := lQry.FieldByName('DESPESAS_ADUANEIRAS').AsString;
    lModel.objeto.PIS_ENT                     := lQry.FieldByName('PIS_ENT').AsString;
    lModel.objeto.COFINS_ENT                  := lQry.FieldByName('COFINS_ENT').AsString;
    lModel.objeto.TAXA_ENT                    := lQry.FieldByName('TAXA_ENT').AsString;
    lModel.objeto.LOJA                        := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.DOLAR                       := lQry.FieldByName('DOLAR').AsString;
    lModel.objeto.ICMS_ST                     := lQry.FieldByName('ICMS_ST').AsString;
    lModel.objeto.BASE_ST                     := lQry.FieldByName('BASE_ST').AsString;
    lModel.objeto.TIPO_FRETE                  := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.objeto.NUMERO_NF                   := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.objeto.SERIE_ENT                   := lQry.FieldByName('SERIE_ENT').AsString;
    lModel.objeto.MODELO_ENT                  := lQry.FieldByName('MODELO_ENT').AsString;
    lModel.objeto.CONDICOES_PAG               := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.objeto.ID_A03                      := lQry.FieldByName('ID_A03').AsString;
    lModel.objeto.SEG_W09                     := lQry.FieldByName('SEG_W09').AsString;
    lModel.objeto.VII_W11                     := lQry.FieldByName('VII_W11').AsString;
    lModel.objeto.VRETPIS_W24                 := lQry.FieldByName('VRETPIS_W24').AsString;
    lModel.objeto.VRETCOFINS_W25              := lQry.FieldByName('VRETCOFINS_W25').AsString;
    lModel.objeto.VRETCSLL_W26                := lQry.FieldByName('VRETCSLL_W26').AsString;
    lModel.objeto.VBCIRRF_W27                 := lQry.FieldByName('VBCIRRF_W27').AsString;
    lModel.objeto.VIRRF_W28                   := lQry.FieldByName('VIRRF_W28').AsString;
    lModel.objeto.VBCRETPREV_W29              := lQry.FieldByName('VBCRETPREV_W29').AsString;
    lModel.objeto.VRETPREV_W30                := lQry.FieldByName('VRETPREV_W30').AsString;
    lModel.objeto.ARQ_NFE                     := lQry.FieldByName('ARQ_NFE').AsString;
    lModel.objeto.EMPRESA                     := lQry.FieldByName('EMPRESA').AsString;
    lModel.objeto.PEDIDO_COMPRA               := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.objeto.ID                          := lQry.FieldByName('ID').AsString;
    lModel.objeto.ST_GUIA                     := lQry.FieldByName('ST_GUIA').AsString;
    lModel.objeto.CFOP_ID                     := lQry.FieldByName('CFOP_ID').AsString;
    lModel.objeto.PEDIDOCOMPRA_ID             := lQry.FieldByName('PEDIDOCOMPRA_ID').AsString;
    lModel.objeto.CONTA_ID                    := lQry.FieldByName('CONTA_ID').AsString;
    lModel.objeto.NUMERO_SAI                  := lQry.FieldByName('NUMERO_SAI').AsString;
    lModel.objeto.SYSTIME                     := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.USUARIO_CHECAGEM            := lQry.FieldByName('USUARIO_CHECAGEM').AsString;
    lModel.objeto.DATAHORA_CHECAGEM           := lQry.FieldByName('DATAHORA_CHECAGEM').AsString;
    lModel.objeto.DESCONTO_NO_CUSTO           := lQry.FieldByName('DESCONTO_NO_CUSTO').AsString;
    lModel.objeto.PEDIDO_ID                   := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.objeto.AGUARDANDO_ENTREGA          := lQry.FieldByName('AGUARDANDO_ENTREGA').AsString;
    lModel.objeto.SAIDAS_ID                   := lQry.FieldByName('SAIDAS_ID').AsString;
    lModel.objeto.FINALIZADE                  := lQry.FieldByName('FINALIZADE').AsString;
    lModel.objeto.PRODUCAO_ID                 := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.objeto.DEVOLUCAO_PEDIDO_ID         := lQry.FieldByName('DEVOLUCAO_PEDIDO_ID').AsString;
    lModel.objeto.TRANSFERENCIA_SAIDA_ID      := lQry.FieldByName('TRANSFERENCIA_SAIDA_ID').AsString;
    lModel.objeto.TRANSFERENCIA_LOJA          := lQry.FieldByName('TRANSFERENCIA_LOJA').AsString;
    lModel.objeto.VFCP                        := lQry.FieldByName('VFCP').AsString;
    lModel.objeto.VFCPST                      := lQry.FieldByName('VFCPST').AsString;
    lModel.objeto.FRETE_ENT_2                 := lQry.FieldByName('FRETE_ENT_2').AsString;
    lModel.objeto.CHECAGEM                    := lQry.FieldByName('CHECAGEM').AsString;
    lModel.objeto.OBS_CHECAGEM                := lQry.FieldByName('OBS_CHECAGEM').AsString;
    lModel.objeto.PORTADOR_ID                 := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.OS_ID                       := lQry.FieldByName('OS_ID').AsString;
    lModel.objeto.CONTROLE_CHECAGEM           := lQry.FieldByName('CONTROLE_CHECAGEM').AsString;
    lModel.objeto.DATAHORA_CHECAGEM_INICIO    := lQry.FieldByName('DATAHORA_CHECAGEM_INICIO').AsString;
    lModel.objeto.CONDICOES_XML               := lQry.FieldByName('CONDICOES_XML').AsString;
    lModel.objeto.PARCELAS_XML                := lQry.FieldByName('PARCELAS_XML').AsString;
    lModel.objeto.ORCAMENTO_ID                := lQry.FieldByName('ORCAMENTO_ID').AsString;
    lModel.objeto.INFADFISCO                  := lQry.FieldByName('INFADFISCO').AsString;
    lModel.objeto.INFCPL                      := lQry.FieldByName('INFCPL').AsString;

    Result := lModel;
  finally
    FreeAndNil(lQry);
  end;
end;

constructor TEntradaDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TEntradaDao.Destroy;
begin
  vConstrutor := nil;
  vIConexao := nil;
  inherited;
end;

function TEntradaDao.incluir(AEntradaModel: ITEntradaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('ENTRADA', 'NUMERO_ENT');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AEntradaModel);
    lQry.Open;
    Result := lQry.FieldByName('NUMERO_ENT').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TEntradaDao.alterar(AEntradaModel: ITEntradaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('ENTRADA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AEntradaModel);
    lQry.ExecSQL;

    Result := AEntradaModel.objeto.NUMERO_ENT;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TEntradaDao.excluir(AEntradaModel: ITEntradaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ENTRADA where NUMERO_ENT = ' + QuotedStr(AEntradaModel.objeto.NUMERO_ENT) + ' and codigo_for = ' + QuotedStr(AEntradaModel.objeto.CODIGO_FOR));
   lQry.ExecSQL;
   Result := AEntradaModel.objeto.NUMERO_ENT;

  finally
    lQry.Free;
  end;
end;

class function TEntradaDao.getNewIface(pIConexao: IConexao): ITEntradaDao;
begin
  Result := TImplObjetoOwner<TEntradaDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TEntradaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0 then
    lSQL := lSQL + ' and entrada.id = '+IntToStr(FIDRecordView);


  if not FNumeroView.IsEmpty then
    lSQL := lSQL + ' and entrada.numero_ent = '+QuotedStr(FNumeroView);


  if not FFornecedorView.IsEmpty then
    lSQL := lSQL + ' and entrada.codigo_for = '+QuotedStr(FFornecedorView);

  Result := lSQL;
end;

function TEntradaDao.obterTotalizador: IFDDataset;
var
  lQry : TFDQuery;
  lSql : String;
begin

//  if FNumeroView.IsEmpty then
//    CriaException('Entrada n�o informado');
//
//  if FFornecedorView.IsEmpty then
//    CriaException('Fornecedor n�o informado');
//
  lQry := vIConexao.CriarQuery;

  try
    lSql := '     select                                                                                                    '+SLineBreak+
            '       ENTRADA,                                                                                                '+SLineBreak+
            '       FORNECEDOR,                                                                                             '+SLineBreak+
            '       QUANTIDADE_ITENS,                                                                                       '+SLineBreak+
            '       QUANTIDADE_PRODUTOS,                                                                                    '+SLineBreak+
            '       TOTAL_PRODUTOS,                                                                                         '+SLineBreak+
            '       TOTAL_BASE_ICMS,                                                                                        '+SLineBreak+
            '       TOTAL_VALOR_ICMS,                                                                                       '+SLineBreak+
            '       TOTAL_BASE_ICMS_ST,                                                                                     '+SLineBreak+
            '       TOTAL_VALOR_ST,                                                                                         '+SLineBreak+
            '       TOTAL_ICMS_DESON,                                                                                       '+SLineBreak+
            '       TOTAL_BASE_IPI,                                                                                         '+SLineBreak+
            '       TOTAL_VALOR_IPI,                                                                                        '+SLineBreak+
            '       TOTAL_BASE_PIS,                                                                                         '+SLineBreak+
            '       TOTAL_VALOR_PIS,                                                                                        '+SLineBreak+
            '       TOTAL_BASE_COFINS,                                                                                      '+SLineBreak+
            '       TOTAL_VALOR_COFINS,                                                                                     '+SLineBreak+
            '       TOTAL_FCP,                                                                                              '+SLineBreak+
            '       TOTAL_FCP_ST,                                                                                           '+SLineBreak+
            '       TOTAL_OUTROS,                                                                                           '+SLineBreak+
            '       TOTAL_FRETE,                                                                                            '+SLineBreak+
            '       PERCENTUAL_DESCONTO,                                                                                    '+SLineBreak+
            '       TOTAL_DESCONTO,                                                                                         '+SLineBreak+
            '       TOTAL_ENTRADA                                                                                           '+SLineBreak+
            '                                                                                                               '+SLineBreak+
            '       from                                                                                                    '+SLineBreak+
            '       (                                                                                                       '+SLineBreak+
            '        select                                                                                                 '+SLineBreak+
            '            entrada,                                                                                           '+SLineBreak+
            '            fornecedor,                                                                                        '+SLineBreak+
            '            quantidade_itens,                                                                                  '+SLineBreak+
            '            quantidade_produtos,                                                                               '+SLineBreak+
            '            total_produtos,                                                                                    '+SLineBreak+
            '            total_base_icms,                                                                                   '+SLineBreak+
            '            total_valor_icms,                                                                                  '+SLineBreak+
            '            total_base_icms_st,                                                                                '+SLineBreak+
            '            total_valor_st,                                                                                    '+SLineBreak+
            '            total_icms_deson,                                                                                  '+SLineBreak+
            '            total_base_ipi,                                                                                    '+SLineBreak+
            '            total_valor_ipi,                                                                                   '+SLineBreak+
            '            total_base_pis,                                                                                    '+SLineBreak+
            '            total_valor_pis,                                                                                   '+SLineBreak+
            '            total_base_cofins,                                                                                 '+SLineBreak+
            '            total_valor_cofins,                                                                                '+SLineBreak+
            '            total_fcp,                                                                                         '+SLineBreak+
            '            total_fcp_st,                                                                                      '+SLineBreak+
            '            total_outros,                                                                                      '+SLineBreak+
            '            total_frete,                                                                                       '+SLineBreak+
            '            case                                                                                               '+SLineBreak+
            '              when total_produtos > 0 then                                                                     '+SLineBreak+
            '                cast(total_desconto / total_produtos * 100 as numeric(18,2))                                   '+SLineBreak+
            '              else                                                                                             '+SLineBreak+
            '                0                                                                                              '+SLineBreak+
            '            end percentual_desconto,                                                                           '+SLineBreak+
            '            total_desconto,                                                                                    '+SLineBreak+
            '            total_produtos                                                                                     '+SLineBreak+
            '              + total_valor_st                                                                                 '+SLineBreak+
            '              + total_valor_ipi                                                                                '+SLineBreak+
            '              + total_fcp_st                                                                                   '+SLineBreak+
            '              + total_frete                                                                                    '+SLineBreak+
            '              + total_outros                                                                                   '+SLineBreak+
            '              - total_desconto total_entrada                                                                   '+SLineBreak+
            '                                                                                                               '+SLineBreak+
            '             from                                                                                              '+SLineBreak+
            '             (                                                                                                 '+SLineBreak+
            '              select                                                                                           '+SLineBreak+
            '                  e.numero_ent entrada,                                                                        '+SLineBreak+
            '                  e.codigo_for fornecedor,                                                                     '+SLineBreak+
            '                  count(*) quantidade_itens,                                                                   '+SLineBreak+
            '                  COALESCE(sum(i.quantidade_ent), 0) quantidade_produtos,                                      '+SLineBreak+
            '                  COALESCE(sum(cast(i.valoruni_ent * i.quantidade_ent as numeric(18,2))), 0) total_produtos,   '+SLineBreak+
            '                  COALESCE(sum(i.base_icms_ent), 0) total_base_icms,                                           '+SLineBreak+
            '                  COALESCE(sum(i.vicms_n17), 0) total_valor_icms,                                              '+SLineBreak+
            '                  COALESCE(sum(i.base_st_ent), 0) total_base_icms_st,                                          '+SLineBreak+
            '                  COALESCE(sum(i.vicms_st_ent), 0) total_valor_st,                                             '+SLineBreak+
            '                  sum(0) total_icms_deson,                                                                     '+SLineBreak+
            '                  COALESCE(sum(i.vbc_o10), 0) total_base_ipi,                                                  '+SLineBreak+
            '                  COALESCE(sum(i.vipi_014), 0) total_valor_ipi,                                                '+SLineBreak+
            '                  COALESCE(sum(i.vbc_q07), 0)  total_base_pis,                                                 '+SLineBreak+
            '                  COALESCE(sum(i.vpis_q09), 0) total_valor_pis,                                                '+SLineBreak+
            '                  COALESCE(sum(i.vbc_s07), 0) total_base_cofins,                                               '+SLineBreak+
            '                  COALESCE(sum(i.cofins), 0) total_valor_cofins,                                               '+SLineBreak+
            '                  COALESCE(sum(i.vfcpst), 0) total_fcp,                                                        '+SLineBreak+
            '                  COALESCE(sum(i.vfcpstret), 0) total_fcp_st,                                                  '+SLineBreak+
            '                  COALESCE(sum(i.vseg_i16), 0) total_outros,                                                   '+SLineBreak+
            '                  COALESCE(sum(i.vfrete_i15), 0) total_frete,                                                  '+SLineBreak+
            '                  COALESCE(sum(i.desc_i17), 0) total_desconto                                                  '+SLineBreak+
            '                from entrada e                                                                                 '+SLineBreak+
            '                left join entradaitens i on i.numero_ent = e.numero_ent and i.codigo_for = e.codigo_for        '+SLineBreak+
            '               group by 1,2                                                                                    '+SLineBreak+
            '               )                                                                                               '+SLineBreak+
            '              )                                                                                                '+SLineBreak+
            '              where 1=1                                                                                        '+SLineBreak;

    lSql := lSql + ' and entrada = '+ QuotedStr(FNumeroView) + ' and fornecedor = '+ QuotedStr(FFornecedorView);

    lQry.Open(lSql);

    vConstrutor.getSQL(lQry);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

procedure TEntradaDao.obterTotalRegistros;
var
  lQry: IFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.criaIfaceQuery;

    lSql := 'select count(*) records                                                 ' +
            'from ENTRADA                                                            ' +
            '     left join fornecedor on fornecedor.codigo_for = entrada.codigo_for ' +
            'where 1=1                                                               ';

    lSql := lSql + where;

    lQry.objeto.Open(lSQL);

    FTotalRecords := lQry.objeto.FieldByName('records').AsInteger;

  finally
    lQry:=nil;
  end;
end;

function TEntradaDao.obterLista: IFDDataset;
var
  lQry       : IFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.criaIfaceQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
    lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView ;

    lSql := ' select ' +lPaginacao+ '                                                                             '+SLineBreak+
            '       ID,                                                                                           '+SLineBreak+
            '       CHAVE,                                                                                        '+SLineBreak+
            '       NUMERO_ENTRADA,                                                                               '+SLineBreak+
            '       SERIE,                                                                                        '+SLineBreak+
            '       MODELO,                                                                                       '+SLineBreak+
            '       CFOP_ENTRADA,                                                                                 '+SLineBreak+
            '       OBSERVACAO,                                                                                   '+SLineBreak+
            '       COD_FORNECEDOR,                                                                               '+SLineBreak+
            '       NOME_FORNECEDOR,                                                                              '+SLineBreak+
            '       ENDERECO_FORNECEDOR,                                                                          '+SLineBreak+
            '       NUMERO_FORNECEDOR,                                                                            '+SLineBreak+
            '       BAIRRO_FORNECEDOR,                                                                            '+SLineBreak+
            '       CIDADE_FORNECEDOR,                                                                            '+SLineBreak+
            '       UF_FORNECEDOR,                                                                                '+SLineBreak+
            '       CNPJ_CPF_FORNECEDOR,                                                                          '+SLineBreak+
            '       TELEFONE_FORNECEDOR,                                                                          '+SLineBreak+
            '       CELULAR_FORNECEDOR,                                                                           '+SLineBreak+
            '       CONTATO_FORNECEDOR,                                                                           '+SLineBreak+
            '       DATA_EMISSAO,                                                                                 '+SLineBreak+
            '       DATA_MOVIMENTO,                                                                               '+SLineBreak+
            '       VALOR_TOTAL,                                                                                  '+SLineBreak+
            '       INFADFISCO,                                                                                   '+SLineBreak+
            '       INFCPL                                                                                        '+SLineBreak+
            '                 from                                                                                '+SLineBreak+
            '                    (select                                                                          '+SLineBreak+
            '                          entrada.id,                                                                '+SLineBreak+
            '                          entrada.id_a03 chave,                                                      '+SLineBreak+
            '                          entrada.numero_ent numero_entrada,                                         '+SLineBreak+
            '                          entrada.serie_ent serie,                                                   '+SLineBreak+
            '                          entrada.modelo_ent modelo,                                                 '+SLineBreak+
            '                          entrada.cfop_ent cfop_entrada,                                             '+SLineBreak+
            '                          entrada.observacao_ent observacao,                                         '+SLineBreak+
            '                          entrada.codigo_for cod_fornecedor,                                         '+SLineBreak+
            '                          coalesce(fornecedor.razao_for, fornecedor.fantasia_for) nome_fornecedor,   '+SLineBreak+
            '                          fornecedor.endereco_for endereco_fornecedor,                               '+SLineBreak+
            '                          fornecedor.numero_end numero_fornecedor,                                   '+SLineBreak+
            '                          fornecedor.bairro_for bairro_fornecedor,                                   '+SLineBreak+
            '                          fornecedor.cidade_for cidade_fornecedor,                                   '+SLineBreak+
            '                          fornecedor.uf_for uf_fornecedor,                                           '+SLineBreak+
            '                          fornecedor.cnpj_cpf_for cnpj_cpf_fornecedor,                               '+SLineBreak+
            '                          fornecedor.telefone_for telefone_fornecedor,                               '+SLineBreak+
            '                          fornecedor.celularcontato_for celular_fornecedor,                          '+SLineBreak+
            '                          fornecedor.contato_for contato_fornecedor,                                 '+SLineBreak+
            '                          entrada.datanota_ent data_emissao,                                         '+SLineBreak+
            '                          entrada.datamovi_ent data_movimento,                                       '+SLineBreak+
            '                          entrada.total_ent valor_total,                                             '+SLineBreak+
            '                          entrada.infadfisco,                                                        '+SLineBreak+
            '                          entrada.infcpl                                                             '+SLineBreak+
            '                     from entrada                                                                    '+SLineBreak+
            '                     left join fornecedor on fornecedor.codigo_for = entrada.codigo_for              '+SLineBreak+
            '                    where 1=1                                                                        '+SLineBreak;

    lSql := lSql + where;

    lSql := lSql + ' ) entrada ';

    if not FOrderView.IsEmpty then
      lSql := lSQL + ' order by '+FOrderView;

    lQry.objeto.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry.objeto);

    obterTotalRegistros;

  finally
    lQry:=nil;
  end;
end;

procedure TEntradaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TEntradaDao.SetFornecedorView(const Value: String);
begin
  FFornecedorView := Value;
end;

procedure TEntradaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TEntradaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TEntradaDao.SetNumeroView(const Value: String);
begin
  FNumeroView := Value;
end;

procedure TEntradaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TEntradaDao.setParams(var pQry: TFDQuery; pEntradaModel: ITEntradaModel);
begin
  vConstrutor.setParams('ENTRADA',pQry,pEntradaModel.objeto);
end;

procedure TEntradaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TEntradaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TEntradaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
