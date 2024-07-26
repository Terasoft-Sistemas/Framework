unit ObtemAliquotasDao;

interface

uses
  ObtemAliquotasModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  System.Variants,
  Interfaces.Conexao;

type
  TObtemAliquotasDao = class;
  ITObtemAliquotasDao=IObject<TObtemAliquotasDao>;

  TObtemAliquotasDao = class
  private
    [weak] mYSelf: ITObtemAliquotasDao;
    vIConexao : IConexao;

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

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITObtemAliquotasDao;

    function obterImpostos: ITObtemAliquotasModel;

end;

implementation

{ TObtemAliquotas }

constructor TObtemAliquotasDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TObtemAliquotasDao.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

class function TObtemAliquotasDao.getNewIface(pIConexao: IConexao): ITObtemAliquotasDao;
begin
  Result := TImplObjetoOwner<TObtemAliquotasDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TObtemAliquotasDao.obterImpostos: ITObtemAliquotasModel;
var
  lQry: TFDQuery;
  lSQL: String;
  lObtemAliquotasModel: ITObtemAliquotasModel;
  lUF_BASE: String;
begin
  lQry := vIConexao.CriarQuery;
  lObtemAliquotasModel := TObtemAliquotasModel.getNewIface(vIConexao);

  try
    if FMODELO_NF = '65' then
       lUF_BASE := FEMITENTE_UF
    else
       lUF_BASE := FDESTINATARIO_UF;

    lSQL :=
          ' select                                                           '+#13+
          '     t.'+lUF_BASE+'_cst cst,                                      '+#13+
          '     t.'+lUF_BASE+'_ icms_aliquota_interestadual,                 '+#13+
          '     t.'+lUF_BASE+'_reducao icms_reducao_base,                    '+#13+
          '     t.'+lUF_BASE+'_aliqint icms_aliquota_interna,                '+#13+
          '     t.'+lUF_BASE+'_mva st_mva,                                   '+#13+
          '     t.'+lUF_BASE+'_reducao_st st_reducao_base,                   '+#13+
          '     t.'+lUF_BASE+'_pfcp fcp_aliquota,                            '+#13+
          '     t.'+lUF_BASE+'_cfop_id cfop,                                 '+#13+
          '     t.'+lUF_BASE+'_cfop_id_consumidor cfop_consumidor,           '+#13+
          '     p.cst_cofins,                                                '+#13+
          '     p.aliquota_cofins,                                           '+#13+
          '     p.cst_pis,                                                   '+#13+
          '     p.aliquota_pis,                                              '+#13+
          '     p.ipi_sai,                                                   '+#13+
          '     p.cst_ipi,                                                   '+#13+
          '     c.cfop,                                                      '+#13+
          '     coalesce(c1.cfop, c.cfop) cfop_consumidor                    '+#13+
          '                                                                  '+#13+
          ' from                                                             '+#13+
          '     produto p                                                    '+#13+
          '                                                                  '+#13+
          ' left join tabelaicms t on t.codigo = p.tabicms_pro               '+#13+
          ' left join cfop c on c.id = t.'+lUF_BASE+'_cfop_id                '+#13+
          ' left join cfop c1 on c1.id = t.'+lUF_BASE+'_cfop_id_consumidor   '+#13+
          '                                                                  '+#13+
          ' where                                                            '+#13+
          '     p.codigo_pro = '+QuotedStr(FCODIGO_PRODUTO);

    lQry.Open(lSQL);

    if FMODELO_NF = '65' then
       lObtemAliquotasModel.objeto.CFOP := lQry.FieldByName('cfop_consumidor').Value
    else
       lObtemAliquotasModel.objeto.CFOP := lQry.FieldByName('cfop').Value;

    lObtemAliquotasModel.objeto.ICMS_CST                    := lQry.FieldByName('cst').Value;
    lObtemAliquotasModel.objeto.ICMS_MODADEDADE             := '4';
    lObtemAliquotasModel.objeto.ICMS_REDUCAO                := lQry.FieldByName('icms_reducao_base').Value;
    lObtemAliquotasModel.objeto.ICMS_ALIQUOTA               := lQry.FieldByName('icms_aliquota_interna').Value;
    lObtemAliquotasModel.objeto.ICMS_ALIQUOTA_INTERESTADUAL := lQry.FieldByName('icms_aliquota_interestadual').Value;
    lObtemAliquotasModel.objeto.ICMSST_MODALIDADE           := '4';
    lObtemAliquotasModel.objeto.ICMSST_REDUCAO              := lQry.FieldByName('st_reducao_base').Value;
    lObtemAliquotasModel.objeto.ICMSST_MVA                  := lQry.FieldByName('st_mva').Value;
    lObtemAliquotasModel.objeto.ICMSST_ALIQUOTA             := lQry.FieldByName('icms_aliquota_interna').Value;
    lObtemAliquotasModel.objeto.PFCP                        := lQry.FieldByName('fcp_aliquota').Value;
    lObtemAliquotasModel.objeto.PIS_CST                     := lQry.FieldByName('cst_pis').Value;
    lObtemAliquotasModel.objeto.PIS_ALIQUOTA                := lQry.FieldByName('aliquota_pis').Value;
    lObtemAliquotasModel.objeto.COFINS_CST                  := lQry.FieldByName('cst_cofins').Value;
    lObtemAliquotasModel.objeto.COFINS_ALIQUOTA             := lQry.FieldByName('aliquota_cofins').Value;
    lObtemAliquotasModel.objeto.IPI_CST                     := lQry.FieldByName('cst_ipi').Value;
    lObtemAliquotasModel.objeto.IPI_ALIQUOTA                := lQry.FieldByName('ipi_sai').Value;

    lSQL :=
        ' select                                      '+#13+
        '     c.cst cfop_cst,                         '+#13+
        '     c.csosn cfop_csosn,                     '+#13+
        '     c.cst_pis cfop_cst_pis,                 '+#13+
        '     c.aliquota_pis cfop_pis_aliquota,       '+#13+
        '     c.cst_cofins cfop_cst_cofins,           '+#13+
        '     c.aliquota_cofins cfop_cofins_aliquota, '+#13+
        '     c.aliquota_ipi cfop_ipi_aliquota,       '+#13+
        '     c.cst_ipi cfop_cst_ipi                  '+#13+
        '                                             '+#13+
        ' from                                        '+#13+
        '     cfop c                                  '+#13+
        '                                             '+#13+
        ' where                                       '+#13+
        '     c.id = '+lObtemAliquotasModel.objeto.CFOP;

    lQry.Open(lSQL);

    lObtemAliquotasModel.objeto.PIS_CST         := ifThen(lQry.FieldByName('cfop_cst_pis').AsString         <> '', lQry.FieldByName('cfop_cst_pis').Value,         lObtemAliquotasModel.objeto.PIS_CST);
    lObtemAliquotasModel.objeto.PIS_ALIQUOTA    := StrToFloatDef(ifThen(lQry.FieldByName('cfop_pis_aliquota').AsFloat     > 0 , lQry.FieldByName('cfop_pis_aliquota').Value,    FloatToStr(lObtemAliquotasModel.objeto.PIS_ALIQUOTA)), 0);
    lObtemAliquotasModel.objeto.COFINS_CST      := ifThen(lQry.FieldByName('cfop_cst_cofins').AsString      <> '', lQry.FieldByName('cfop_cst_cofins').Value,      lObtemAliquotasModel.objeto.COFINS_CST);
    lObtemAliquotasModel.objeto.COFINS_ALIQUOTA := StrToFloatDef(ifThen(lQry.FieldByName('cfop_cofins_aliquota').AsFloat  > 0 , lQry.FieldByName('cfop_cofins_aliquota').Value, FloatToStr(lObtemAliquotasModel.objeto.COFINS_ALIQUOTA)), 0);
    lObtemAliquotasModel.objeto.IPI_CST         := ifThen(lQry.FieldByName('cfop_cst_ipi').AsString         <> '', lQry.FieldByName('cfop_cst_ipi').AsString,         lObtemAliquotasModel.objeto.IPI_CST);
    lObtemAliquotasModel.objeto.IPI_ALIQUOTA    := StrToFloatDef(ifThen(lQry.FieldByName('cfop_ipi_aliquota').AsFloat     > 0 , lQry.FieldByName('cfop_ipi_aliquota').Value,    FloatToStr(lObtemAliquotasModel.objeto.IPI_ALIQUOTA)), 0);
    lObtemAliquotasModel.objeto.ICMS_CSOSN      := lQry.FieldByName('cfop_csosn').Value;

    Result := lObtemAliquotasModel;

  finally
    lQry.Free;
  end;
end;

procedure TObtemAliquotasDao.SetCODIGO_CLIENTE(const Value: String);
begin
  FCODIGO_CLIENTE := Value;
end;

procedure TObtemAliquotasDao.SetCODIGO_PRODUTO(const Value: String);
begin
  FCODIGO_PRODUTO := Value;
end;

procedure TObtemAliquotasDao.SetDESTINATARIO_UF(const Value: String);
begin
  FDESTINATARIO_UF := Value;
end;

procedure TObtemAliquotasDao.SetEMITENTE_UF(const Value: String);
begin
  FEMITENTE_UF := Value;
end;

procedure TObtemAliquotasDao.SetMODELO_NF(const Value: String);
begin
  FMODELO_NF := Value;
end;

end.
