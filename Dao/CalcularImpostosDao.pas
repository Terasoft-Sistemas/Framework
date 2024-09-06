unit CalcularImpostosDao;

interface

uses
  CalcularImpostosModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TCalcularImpostosDao = class

  private
    vIConexao : IConexao;
    vConstrutor : IConstrutorDao;

    FDESTINATARIO_UF: String;
    FCODIGO_CLIENTE: String;
    FEMITENTE_UF: String;
    FCODIGO_PRODUTO: String;
    FMODELO_NF: String;
    procedure SetCODIGO_CLIENTE(const Value: String);
    procedure SetCODIGO_PRODUTO(const Value: String);
    procedure SetDESTINATARIO_UF(const Value: String);
    procedure SetEMITENTE_UF(const Value: String);
    procedure SetMODELO_NF(const Value: String);


  public
    property CODIGO_PRODUTO  : String read FCODIGO_PRODUTO write SetCODIGO_PRODUTO;
    property CODIGO_CLIENTE  : String read FCODIGO_CLIENTE write SetCODIGO_CLIENTE;
    property EMITENTE_UF     : String read FEMITENTE_UF write SetEMITENTE_UF;
    property DESTINATARIO_UF : String read FDESTINATARIO_UF write SetDESTINATARIO_UF;
    property MODELO_NF       : String read FMODELO_NF write SetMODELO_NF;

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function obterAliquotas: TCalcularImpostosModel;

end;

implementation

{ TCalcularImpostos }

uses
  Terasoft.Utils, IbptModel;

constructor TCalcularImpostosDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TCalcularImpostosDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TCalcularImpostosDao.obterAliquotas: TCalcularImpostosModel;
var
  lQry : TFDQuery;
  lSQL : String;
  lCalcularImpostosModel : TCalcularImpostosModel;
  lIbptModel             : ITIbptModel;
  lTipoProduto,
  lNCM,
  lUF_BASE               : String;
  lRetornoIbpt           : TIBPTRetorno;
begin
  lQry := vIConexao.CriarQuery;

  lCalcularImpostosModel := TCalcularImpostosModel.Create(vIConexao);
  lIbptModel             := TIbptModel.getNewIface(vIConexao);

  try
    if FMODELO_NF = '65' then
       lUF_BASE := FEMITENTE_UF
    else
       lUF_BASE := FDESTINATARIO_UF;

    lSQL :=
          ' select                                                           '+#13+
          '     coalesce(c1.cst, t.'+lUF_BASE+'_cst) cst,                    '+#13+
          '     t.'+lUF_BASE+'_ icms_aliquota_interestadual,                 '+#13+
          '     t.'+lUF_BASE+'_reducao icms_reducao_base,                    '+#13+
          '     t.'+lUF_BASE+'_aliqint icms_aliquota_interna,                '+#13+
          '     t.'+lUF_BASE+'_mva st_mva,                                   '+#13+
          '     t.'+lUF_BASE+'_reducao_st st_reducao_base,                   '+#13+
          '     t.'+lUF_BASE+'_pfcp fcp_aliquota,                            '+#13+
          '     t.'+lUF_BASE+'_cfop_id cfop_id,                              '+#13+
          '     t.'+lUF_BASE+'_cfop_id_consumidor cfop_consumidor_id,        '+#13+
          '     p.cst_cofins,                                                '+#13+
          '     p.aliquota_cofins,                                           '+#13+
          '     p.cst_pis,                                                   '+#13+
          '     p.aliquota_pis,                                              '+#13+
          '     p.ipi_sai,                                                   '+#13+
          '     p.cst_ipi,                                                   '+#13+
          '     p.nfce_csosn,                                                '+#13+
          '     coalesce(c2.cst, p.nfce_cst) nfce_cst,                       '+#13+
          '     p.nfce_cfop nfce_cfop_id,                                    '+#13+
          '     c2.cfop nfce_cfop,                                           '+#13+
          '     c.cfop,                                                      '+#13+
          '     coalesce(c1.cfop, c.cfop) cfop_consumidor,                   '+#13+
          '     p.tipo_pro,                                                  '+#13+
          '     p.codigo_fornecedor ncm,                                     '+#13+
          '     base_st_recolhido,                                           '+#13+
          '     valor_icms_substituto,                                       '+#13+
          '     percentual_st_recolhido                                      '+#13+
          '                                                                  '+#13+
          ' from                                                             '+#13+
          '     produto p                                                    '+#13+
          '                                                                  '+#13+
          ' left join tabelaicms t on t.codigo = p.tabicms_pro               '+#13+
          ' left join cfop c on c.id = t.'+lUF_BASE+'_cfop_id                '+#13+
          ' left join cfop c1 on c1.id = t.'+lUF_BASE+'_cfop_id_consumidor   '+#13+
          ' left join cfop c2 on c2.id = p.nfce_cfop                         '+#13+
          '                                                                  '+#13+
          ' where                                                            '+#13+
          '     p.codigo_pro = '+QuotedStr(FCODIGO_PRODUTO);

    lQry.Open(lSQL);

    if FMODELO_NF = '65' then
    begin
      if lQry.FieldByName('cfop_consumidor_id').AsString <> '' then
      begin
        lCalcularImpostosModel.CFOP          := lQry.FieldByName('cfop_consumidor').AsString;
        lCalcularImpostosModel.CFOP_ID       := lQry.FieldByName('cfop_consumidor_id').AsString;
        lCalcularImpostosModel.ICMS_CST      := lQry.FieldByName('cst').AsString;
        lCalcularImpostosModel.ICMS_REDUCAO  := 0;
      end else
      begin
        lCalcularImpostosModel.CFOP          := lQry.FieldByName('nfce_cfop').AsString;
        lCalcularImpostosModel.CFOP_ID       := lQry.FieldByName('nfce_cfop_id').AsString;
        lCalcularImpostosModel.ICMS_CST      := lQry.FieldByName('nfce_cst').AsString;
        lCalcularImpostosModel.ICMS_REDUCAO  := lQry.FieldByName('icms_reducao_base').AsFloat;
      end;

      lCalcularImpostosModel.ICMS_CSOSN    := lQry.FieldByName('nfce_csosn').AsString;

    end else
    begin
      lCalcularImpostosModel.CFOP          := lQry.FieldByName('cfop').AsString;
      lCalcularImpostosModel.CFOP_ID       := lQry.FieldByName('cfop_id').AsString;
      lCalcularImpostosModel.ICMS_CSOSN    := lQry.FieldByName('cfop_csosn').AsString;
      lCalcularImpostosModel.ICMS_REDUCAO  := lQry.FieldByName('icms_reducao_base').AsFloat;
    end;


    lCalcularImpostosModel.ICMS_MODADEDADE             := '4';
    lCalcularImpostosModel.ICMS_ALIQUOTA               := lQry.FieldByName('icms_aliquota_interna').AsFloat;
    lCalcularImpostosModel.ICMS_ALIQUOTA_INTERESTADUAL := lQry.FieldByName('icms_aliquota_interestadual').AsFloat;
    lCalcularImpostosModel.ICMSST_MODALIDADE           := '4';
    lCalcularImpostosModel.ICMSST_REDUCAO              := lQry.FieldByName('st_reducao_base').AsFloat;
    lCalcularImpostosModel.ICMSST_MVA                  := lQry.FieldByName('st_mva').AsFloat;
    lCalcularImpostosModel.ICMSST_ALIQUOTA             := lQry.FieldByName('icms_aliquota_interna').AsFloat;
    lCalcularImpostosModel.PFCP                        := lQry.FieldByName('fcp_aliquota').AsFloat;
    lCalcularImpostosModel.PIS_CST                     := lQry.FieldByName('cst_pis').AsString;
    lCalcularImpostosModel.PIS_ALIQUOTA                := lQry.FieldByName('aliquota_pis').AsFloat;
    lCalcularImpostosModel.COFINS_CST                  := lQry.FieldByName('cst_cofins').AsString;
    lCalcularImpostosModel.COFINS_ALIQUOTA             := lQry.FieldByName('aliquota_cofins').AsFloat;
    lCalcularImpostosModel.IPI_CST                     := lQry.FieldByName('cst_ipi').AsString;
    lCalcularImpostosModel.IPI_ALIQUOTA                := lQry.FieldByName('ipi_sai').AsFloat;
    lCalcularImpostosModel.BASE_ST_RECOLHIDO           := lQry.FieldByName('BASE_ST_RECOLHIDO').AsFloat;
    lCalcularImpostosModel.VALOR_ICMS_SUBSTITUTO       := lQry.FieldByName('VALOR_ICMS_SUBSTITUTO').AsFloat;
    lCalcularImpostosModel.PERCENTUAL_ST_RECOLHIDO     := lQry.FieldByName('PERCENTUAL_ST_RECOLHIDO').AsFloat;

    lTipoProduto := lQry.FieldByName('tipo_pro').AsString;
    lNCM         := lQry.FieldByName('ncm').AsString;

    lCalcularImpostosModel.CODIGO_PRODUTO    := FCODIGO_PRODUTO;
    lCalcularImpostosModel.CODIGO_CLIENTE    := FCODIGO_CLIENTE;
    lCalcularImpostosModel.EMITENTE_UF       := FEMITENTE_UF;
    lCalcularImpostosModel.DESTINATARIO_UF   := FDESTINATARIO_UF;
    lCalcularImpostosModel.MODELO_NF         := FMODELO_NF;

    lSQL :=
        ' select                                      '+#13+
        '     c.cst cfop_cst,                         '+#13+
        '     c.csosn cfop_csosn,                     '+#13+
        '     c.cst_pis cfop_cst_pis,                 '+#13+
        '     c.aliquota_pis cfop_pis_aliquota,       '+#13+
        '     c.cst_cofins cfop_cst_cofins,           '+#13+
        '     c.aliquota_cofins cfop_cofins_aliquota, '+#13+
        '     c.aliquota_ipi cfop_ipi_aliquota,       '+#13+
        '     c.cst_ipi cfop_cst_ipi,                 '+#13+
        '     c.ibpt,                                 '+#13+
        '     c.desconto_icms_base_pis_cofins         '+#13+
        '                                             '+#13+
        ' from                                        '+#13+
        '     cfop c                                  '+#13+
        '                                             '+#13+
        ' where                                       '+#13+
        '     c.id = '+lCalcularImpostosModel.CFOP_ID;

    lQry.Open(lSQL);

    if lQry.FieldByName('cfop_cst_pis').AsString <> '' then
      lCalcularImpostosModel.PIS_CST := lQry.FieldByName('cfop_cst_pis').AsString
    else
      lCalcularImpostosModel.PIS_CST := lCalcularImpostosModel.PIS_CST;

    if lQry.FieldByName('cfop_pis_aliquota').AsFloat > 0 then
      lCalcularImpostosModel.PIS_ALIQUOTA := lQry.FieldByName('cfop_pis_aliquota').AsFloat
    else
      lCalcularImpostosModel.PIS_ALIQUOTA := lCalcularImpostosModel.PIS_ALIQUOTA;

    if lQry.FieldByName('cfop_cst_cofins').AsString <> '' then
      lCalcularImpostosModel.COFINS_CST := lQry.FieldByName('cfop_cst_cofins').AsString
    else
      lCalcularImpostosModel.COFINS_CST := lCalcularImpostosModel.COFINS_CST;

    if lQry.FieldByName('cfop_cofins_aliquota').AsFloat > 0 then
      lCalcularImpostosModel.COFINS_ALIQUOTA := lQry.FieldByName('cfop_cofins_aliquota').AsFloat
    else
      lCalcularImpostosModel.COFINS_ALIQUOTA := lCalcularImpostosModel.COFINS_ALIQUOTA;

    if lQry.FieldByName('cfop_cst_ipi').AsString <> '' then
      lCalcularImpostosModel.IPI_CST := lQry.FieldByName('cfop_cst_ipi').AsString
    else
      lCalcularImpostosModel.IPI_CST := lCalcularImpostosModel.IPI_CST;

    if lQry.FieldByName('cfop_ipi_aliquota').AsFloat > 0 then
      lCalcularImpostosModel.IPI_ALIQUOTA := lQry.FieldByName('cfop_ipi_aliquota').AsFloat
    else
      lCalcularImpostosModel.IPI_ALIQUOTA := lCalcularImpostosModel.IPI_ALIQUOTA;

    lCalcularImpostosModel.COFINS_VALOR_BASE_EXCLUIR_VALOR_ICMS := lQry.FieldByName('desconto_icms_base_pis_cofins').AsString = 'S';
    lCalcularImpostosModel.PIS_VALOR_BASE_EXCLUIR_VALOR_ICMS    := lQry.FieldByName('desconto_icms_base_pis_cofins').AsString = 'S';

    if lQry.FieldByName('ibpt').AsString <> 'N' then
    begin
      lRetornoIbpt := lIbptModel.objeto.obterIBPT(FEMITENTE_UF, lTipoProduto, lNCM);

      lCalcularImpostosModel.ALIQUOTA_FEDERAL   := lRetornoIbpt.IMPOSTO_FEDERAL;
      lCalcularImpostosModel.ALIQUOTA_ESTADUAL  := lRetornoIbpt.IMPOSTO_ESTADUAL;
      lCalcularImpostosModel.ALIQUOTA_MUNICIPAL := lRetornoIbpt.IMPOSTO_MUNICIPAL;
    end;

    Result := lCalcularImpostosModel;

  finally
    lIbptModel:=nil;
    lQry.Free;
  end;
end;

procedure TCalcularImpostosDao.SetCODIGO_CLIENTE(const Value: String);
begin
  FCODIGO_CLIENTE := Value;
end;

procedure TCalcularImpostosDao.SetCODIGO_PRODUTO(const Value: String);
begin
  FCODIGO_PRODUTO := Value;
end;

procedure TCalcularImpostosDao.SetDESTINATARIO_UF(const Value: String);
begin
  FDESTINATARIO_UF := Value;
end;

procedure TCalcularImpostosDao.SetEMITENTE_UF(const Value: String);
begin
  FEMITENTE_UF := Value;
end;

procedure TCalcularImpostosDao.SetMODELO_NF(const Value: String);
begin
  FMODELO_NF := Value;
end;

end.
