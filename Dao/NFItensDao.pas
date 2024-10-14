unit NFItensDao;

interface

uses
  NFItensModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TNFItensDao = class;
  ITNFItensDao=IObject<TNFItensDao>;

  TNFItensDao = class
  private
    [unsafe] mySelf: ITNFItensDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FNFItenssLista: IList<ITNFItensModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDPedidoView: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetNFItenssLista(const Value: IList<ITNFItensModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    procedure setParams(var pQry: TFDQuery; pNFItensModel: ITNFItensModel);
    function where: String;
    procedure SetIDPedidoView(const Value: Integer);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITNFItensDao;

    property NFItenssLista: IList<ITNFItensModel> read FNFItenssLista write SetNFItenssLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDPedidoView: Integer read FIDPedidoView write SetIDPedidoView;

    function incluir(pNFItensModel: ITNFItensModel): String;
    function alterar(pNFItensModel: ITNFItensModel): String;
    function excluir(pNFItensModel: ITNFItensModel): String;

    procedure obterLista;
    function obterTotais(pNF : String): IFDDataset;

    function carregaClasse(pId: String): ITNFItensModel;
end;

implementation

uses
  System.Rtti;

{ TNFItens }

function TNFItensDao.carregaClasse(pId: String): ITNFItensModel;
var
  lQry: TFDQuery;
  lModel: ITNFItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TNFItensModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open(' select nfitens.*,                                                  ' +
              '       produto.nome_pro,                                            ' +
              '       produto.unidade_pro,                                         ' +
              '       produto.codigo_fornecedor ncm,                               ' +
              '       produto.tipo$_pro icms_origem                                ' +
              ' from nfitens                                                       ' +
              '       left join produto on produto.codigo_pro = nfitens.codigo_pro ' +
              ' where id = ' + pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_NF           := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.objeto.SERIE_NF            := lQry.FieldByName('SERIE_NF').AsString;
    lModel.objeto.CODIGO_PRO          := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.objeto.DESCRICAO_PRODUTO   := lQry.FieldByName('NOME_PRO').AsString;
    lModel.objeto.NCM                 := lQry.FieldByName('NCM').AsString;
    lModel.objeto.ICMS_ORIGEM         := lQry.FieldByName('ICMS_ORIGEM').AsString;
    lModel.objeto.UNIDADE_NF          := lQry.FieldByName('UNIDADE_PRO').AsString;
    lModel.objeto.VALORUNITARIO_NF    := lQry.FieldByName('VALORUNITARIO_NF').AsString;
    lModel.objeto.QUANTIDADE_NF       := lQry.FieldByName('QUANTIDADE_NF').AsString;
    lModel.objeto.VLRVENDA_NF         := lQry.FieldByName('VLRVENDA_NF').AsString;
    lModel.objeto.VLRCUSTO_NF         := lQry.FieldByName('VLRCUSTO_NF').AsString;
    lModel.objeto.REDUCAO_NF          := lQry.FieldByName('REDUCAO_NF').AsString;
    lModel.objeto.ICMS_NF             := lQry.FieldByName('ICMS_NF').AsString;
    lModel.objeto.IPI_NF              := lQry.FieldByName('IPI_NF').AsString;
    lModel.objeto.ITEM_NF             := lQry.FieldByName('ITEM_NF').AsString;
    lModel.objeto.LOJA                := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.VALOR_ICMS          := lQry.FieldByName('VALOR_ICMS').AsString;
    lModel.objeto.BASE_ICMS_ST        := lQry.FieldByName('BASE_ICMS_ST').AsString;
    lModel.objeto.VALOR_IPI           := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.objeto.BASE_ICMS           := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.objeto.LOTE                := lQry.FieldByName('LOTE').AsString;
    lModel.objeto.PMVAST_N19          := lQry.FieldByName('PMVAST_N19').AsString;
    lModel.objeto.PREDBCST_N20        := lQry.FieldByName('PREDBCST_N20').AsString;
    lModel.objeto.VBCST_N21           := lQry.FieldByName('VBCST_N21').AsString;
    lModel.objeto.PICMSST_N22         := lQry.FieldByName('PICMSST_N22').AsString;
    lModel.objeto.VICMSST_N23         := lQry.FieldByName('VICMSST_N23').AsString;
    lModel.objeto.MODBCST_N18         := lQry.FieldByName('MODBCST_N18').AsString;
    lModel.objeto.CST_N12             := lQry.FieldByName('CST_N12').AsString;
    lModel.objeto.VBC_N15             := lQry.FieldByName('VBC_N15').AsString;
    lModel.objeto.VICMS_N17           := lQry.FieldByName('VICMS_N17').AsString;
    lModel.objeto.NUMERO_SERIE_ECF    := lQry.FieldByName('NUMERO_SERIE_ECF').AsString;
    lModel.objeto.STATUS              := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.PREDBC_N14          := lQry.FieldByName('PREDBC_N14').AsString;
    lModel.objeto.CFOP                := lQry.FieldByName('CFOP').AsString;
    lModel.objeto.ID_OBS_LANCAMENTO   := lQry.FieldByName('ID_OBS_LANCAMENTO').AsString;
    lModel.objeto.CSOSN               := lQry.FieldByName('CSOSN').AsString;
    lModel.objeto.PCREDSN             := lQry.FieldByName('PCREDSN').AsString;
    lModel.objeto.VCREDICMSSN         := lQry.FieldByName('VCREDICMSSN').AsString;
    lModel.objeto.NDI_I19             := lQry.FieldByName('NDI_I19').AsString;
    lModel.objeto.DDI_I20             := lQry.FieldByName('DDI_I20').AsString;
    lModel.objeto.XLOCDESEMB_I21      := lQry.FieldByName('XLOCDESEMB_I21').AsString;
    lModel.objeto.UFDESEMB_I22        := lQry.FieldByName('UFDESEMB_I22').AsString;
    lModel.objeto.DDESEMB_I23         := lQry.FieldByName('DDESEMB_I23').AsString;
    lModel.objeto.CEXPORTADOR_I24     := lQry.FieldByName('CEXPORTADOR_I24').AsString;
    lModel.objeto.NADICAO_I26         := lQry.FieldByName('NADICAO_I26').AsString;
    lModel.objeto.NSEQADIC_I27        := lQry.FieldByName('NSEQADIC_I27').AsString;
    lModel.objeto.CFABRICANTE_I28     := lQry.FieldByName('CFABRICANTE_I28').AsString;
    lModel.objeto.VDESCDI_I29         := lQry.FieldByName('VDESCDI_I29').AsString;
    lModel.objeto.VBC_P02             := lQry.FieldByName('VBC_P02').AsString;
    lModel.objeto.VDESPADU_P03        := lQry.FieldByName('VDESPADU_P03').AsString;
    lModel.objeto.VII_P04             := lQry.FieldByName('VII_P04').AsString;
    lModel.objeto.VIOF_P05            := lQry.FieldByName('VIOF_P05').AsString;
    lModel.objeto.CST_Q06             := lQry.FieldByName('CST_Q06').AsString;
    lModel.objeto.VBC_Q07             := lQry.FieldByName('VBC_Q07').AsString;
    lModel.objeto.PPIS_Q08            := lQry.FieldByName('PPIS_Q08').AsString;
    lModel.objeto.VPIS_Q09            := lQry.FieldByName('VPIS_Q09').AsString;
    lModel.objeto.QBCPROD_Q10         := lQry.FieldByName('QBCPROD_Q10').AsString;
    lModel.objeto.VALIQPROD_Q11       := lQry.FieldByName('VALIQPROD_Q11').AsString;
    lModel.objeto.CST_S06             := lQry.FieldByName('CST_S06').AsString;
    lModel.objeto.VBC_S07             := lQry.FieldByName('VBC_S07').AsString;
    lModel.objeto.PCOFINS_S08         := lQry.FieldByName('PCOFINS_S08').AsString;
    lModel.objeto.VCOFINS_S11         := lQry.FieldByName('VCOFINS_S11').AsString;
    lModel.objeto.QBCPROD_S09         := lQry.FieldByName('QBCPROD_S09').AsString;
    lModel.objeto.VALIQPROD_S10       := lQry.FieldByName('VALIQPROD_S10').AsString;
    lModel.objeto.ID                  := lQry.FieldByName('ID').AsString;
    lModel.objeto.VTOTTRIB            := lQry.FieldByName('VTOTTRIB').AsString;
    lModel.objeto.OBSERVACAO          := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.objeto.CFOP_ID             := lQry.FieldByName('CFOP_ID').AsString;
    lModel.objeto.CONTA_CONTABIL      := lQry.FieldByName('CONTA_CONTABIL').AsString;
    lModel.objeto.VDESC               := lQry.FieldByName('VDESC').AsString;
    lModel.objeto.VSEG                := lQry.FieldByName('VSEG').AsString;
    lModel.objeto.FRETE               := lQry.FieldByName('FRETE').AsString;
    lModel.objeto.VOUTROS             := lQry.FieldByName('VOUTROS').AsString;
    lModel.objeto.CST_IPI             := lQry.FieldByName('CST_IPI').AsString;
    lModel.objeto.VALOR_DIFERIMENTO   := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
    lModel.objeto.OBS_ITEM            := lQry.FieldByName('OBS_ITEM').AsString;
    lModel.objeto.ICMS_SUFRAMA        := lQry.FieldByName('ICMS_SUFRAMA').AsString;
    lModel.objeto.PIS_SUFRAMA         := lQry.FieldByName('PIS_SUFRAMA').AsString;
    lModel.objeto.COFINS_SUFRAMA      := lQry.FieldByName('COFINS_SUFRAMA').AsString;
    lModel.objeto.IPI_SUFRAMA         := lQry.FieldByName('IPI_SUFRAMA').AsString;
    lModel.objeto.VALOR_SUFRAMA_ITEM  := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
    lModel.objeto.ESTOQUE_2           := lQry.FieldByName('ESTOQUE_2').AsString;
    lModel.objeto.VTOTTRIB_FEDERAL    := lQry.FieldByName('VTOTTRIB_FEDERAL').AsString;
    lModel.objeto.VTOTTRIB_ESTADUAL   := lQry.FieldByName('VTOTTRIB_ESTADUAL').AsString;
    lModel.objeto.VTOTTRIB_MUNICIPAL  := lQry.FieldByName('VTOTTRIB_MUNICIPAL').AsString;
    lModel.objeto.PEDIDO_ID           := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.objeto.NITEMPED            := lQry.FieldByName('NITEMPED').AsString;
    lModel.objeto.XPED                := lQry.FieldByName('XPED').AsString;
    lModel.objeto.TPVIATRANSP         := lQry.FieldByName('TPVIATRANSP').AsString;
    lModel.objeto.TPINTERMEDIO        := lQry.FieldByName('TPINTERMEDIO').AsString;
    lModel.objeto.VAFRMM_OPC          := lQry.FieldByName('VAFRMM_OPC').AsString;
    lModel.objeto.VBC_IPI             := lQry.FieldByName('VBC_IPI').AsString;
    lModel.objeto.ALIQUOTA_II         := lQry.FieldByName('ALIQUOTA_II').AsString;
    lModel.objeto.VBCUFDEST           := lQry.FieldByName('VBCUFDEST').AsString;
    lModel.objeto.PFCPUFDEST          := lQry.FieldByName('PFCPUFDEST').AsString;
    lModel.objeto.PICMSUFDEST         := lQry.FieldByName('PICMSUFDEST').AsString;
    lModel.objeto.PICMSINTER          := lQry.FieldByName('PICMSINTER').AsString;
    lModel.objeto.PICMSINTERPART      := lQry.FieldByName('PICMSINTERPART').AsString;
    lModel.objeto.VFCPUFDEST          := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.objeto.VICMSUFDEST         := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.objeto.VICMSUFREMET        := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.objeto.CEST                := lQry.FieldByName('CEST').AsString;
    lModel.objeto.SAIDA_ID            := lQry.FieldByName('SAIDA_ID').AsString;
    lModel.objeto.V_PROD              := lQry.FieldByName('V_PROD').AsString;
    lModel.objeto.PCREDICMS           := lQry.FieldByName('PCREDICMS').AsString;
    lModel.objeto.PCREDPIS            := lQry.FieldByName('PCREDPIS').AsString;
    lModel.objeto.PCREDCOFINS         := lQry.FieldByName('PCREDCOFINS').AsString;
    lModel.objeto.DESTINO             := lQry.FieldByName('DESTINO').AsString;
    lModel.objeto.BASE_IPI2           := lQry.FieldByName('BASE_IPI2').AsString;
    lModel.objeto.IPI_CENQ            := lQry.FieldByName('IPI_CENQ').AsString;
    lModel.objeto.NITEMPED2           := lQry.FieldByName('NITEMPED2').AsString;
    lModel.objeto.V_PROD2             := lQry.FieldByName('V_PROD2').AsString;
    lModel.objeto.UTRIB               := lQry.FieldByName('UTRIB').AsString;
    lModel.objeto.QTRIB               := lQry.FieldByName('QTRIB').AsString;
    lModel.objeto.VUNTRIB             := lQry.FieldByName('VUNTRIB').AsString;
    lModel.objeto.VBCFCPUFDEST        := lQry.FieldByName('VBCFCPUFDEST').AsString;
    lModel.objeto.VBCFCPST            := lQry.FieldByName('VBCFCPST').AsString;
    lModel.objeto.PFCPST              := lQry.FieldByName('PFCPST').AsString;
    lModel.objeto.VFCPST              := lQry.FieldByName('VFCPST').AsString;
    lModel.objeto.VBCCFP              := lQry.FieldByName('VBCCFP').AsString;
    lModel.objeto.PFCP                := lQry.FieldByName('PFCP').AsString;
    lModel.objeto.VFCP                := lQry.FieldByName('VFCP').AsString;
    lModel.objeto.VBCFCPSTRET         := lQry.FieldByName('VBCFCPSTRET').AsString;
    lModel.objeto.PFCPSTRET           := lQry.FieldByName('PFCPSTRET').AsString;
    lModel.objeto.VFCPSTRET           := lQry.FieldByName('VFCPSTRET').AsString;
    lModel.objeto.OS_ID               := lQry.FieldByName('OS_ID').AsString;
    lModel.objeto.CBENEF              := lQry.FieldByName('CBENEF').AsString;
    lModel.objeto.INDESCALA           := lQry.FieldByName('INDESCALA').AsString;
    lModel.objeto.CNPJFAB             := lQry.FieldByName('CNPJFAB').AsString;
    lModel.objeto.PREDBCEFET          := lQry.FieldByName('PREDBCEFET').AsString;
    lModel.objeto.VBCEFET             := lQry.FieldByName('VBCEFET').AsString;
    lModel.objeto.PICMSEFET           := lQry.FieldByName('PICMSEFET').AsString;
    lModel.objeto.VICMSEFET           := lQry.FieldByName('VICMSEFET').AsString;
    lModel.objeto.CENQ                := lQry.FieldByName('CENQ').AsString;
    lModel.objeto.VBCSTRET            := lQry.FieldByName('VBCSTRET').AsString;
    lModel.objeto.VICMSSTRET          := lQry.FieldByName('VICMSSTRET').AsString;
    lModel.objeto.PICMSSTRET          := lQry.FieldByName('PICMSSTRET').AsString;
    lModel.objeto.VICMSSUBISTITUTORET := lQry.FieldByName('VICMSSUBISTITUTORET').AsString;
    lModel.objeto.VICMSDESON          := lQry.FieldByName('VICMSDESON').AsString;
    lModel.objeto.MOTDESICMS          := lQry.FieldByName('MOTDESICMS').AsString;
    lModel.objeto.VALOR_VIP           := lQry.FieldByName('VALOR_VIP').AsString;
    lModel.objeto.SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.PCRED_PRESUMIDO     := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
    lModel.objeto.NDRAW               := lQry.FieldByName('NDRAW').AsString;
    lModel.objeto.PPRCOMP             := lQry.FieldByName('PPRCOMP').AsString;
    lModel.objeto.VPRCOMP             := lQry.FieldByName('VPRCOMP').AsString;
    lModel.objeto.NRE                 := lQry.FieldByName('NRE').AsString;
    lModel.objeto.CHNFE               := lQry.FieldByName('CHNFE').AsString;
    lModel.objeto.QEXPORT             := lQry.FieldByName('QEXPORT').AsString;
    lModel.objeto.EXTIPI              := lQry.FieldByName('EXTIPI').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TNFItensDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TNFItensDao.Destroy;
begin
  FNFItenssLista:=nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TNFItensDao.incluir(pNFItensModel: ITNFItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('NFITENS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pNFItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TNFItensDao.alterar(pNFItensModel: ITNFItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('NFITENS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pNFItensModel);
    lQry.ExecSQL;

    Result := pNFItensModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TNFItensDao.excluir(pNFItensModel: ITNFItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from nfitens where ID = :ID',[pNFItensModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pNFItensModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TNFItensDao.getNewIface(pIConexao: IConexao): ITNFItensDao;
begin
  Result := TImplObjetoOwner<TNFItensDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TNFItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and nfitens.id = '+IntToStr(FIDRecordView);

  if FIDPedidoView <> 0  then
    lSQL := lSQL + ' and nfitens.pedido_id = '+IntToStr(FIDPedidoView);

  Result := lSQL;
end;

function TNFItensDao.obterTotais(pNF: String): IFDDataset;
var
  lQry     : TFDQuery;
  lSQL     : String;
begin
  lQry     := vIConexao.CriarQuery;
  try
    lSQL :=
        '  select sum(n.quantidade_nf * n.valorunitario_nf) total_itens,                                                                          '+StartRecordView+
        '         sum(coalesce(n.vdesc,0)) total_desconto,                                                                                        '+StartRecordView+
        '         sum(coalesce(n.voutros,0)) total_outros,                                                                                        '+StartRecordView+
        '         sum(coalesce(n.frete,0)) total_frete,                                                                                           '+StartRecordView+
        '         sum(coalesce(n.valor_ipi,0)) as total_ipi,                                                                                      '+StartRecordView+
        '         sum(coalesce(n.vicms_n17,0)) as valor_icms,                                                                                     '+StartRecordView+
        '         sum(coalesce(n.vpis_q09,0)) as total_pis,                                                                                       '+StartRecordView+
        '         sum(coalesce(n.vcofins_s11,0)) as total_cofins,                                                                                 '+StartRecordView+
        '         sum(coalesce(n.vii_p04,0)) as total_vii,                                                                                        '+StartRecordView+
        '         sum(coalesce(n.vseg,0)) as total_seg,                                                                                           '+StartRecordView+
        '         sum(case                                                                                                                        '+StartRecordView+
        '               when (n.csosn = ''500'') then                                                                                             '+StartRecordView+
        '                 0                                                                                                                       '+StartRecordView+
        '               else                                                                                                                      '+StartRecordView+
        '                 (coalesce(n.vicmsst_n23,0))                                                                                             '+StartRecordView+
        '             end) as total_valor_icms_st,                                                                                                '+StartRecordView+
        '         sum(coalesce(n.vfcpufdest,0)) as vfcpufdest,                                                                                    '+StartRecordView+
        '         sum(coalesce(n.vicmsufdest,0)) as vicmsufdest,                                                                                  '+StartRecordView+
        '         sum(coalesce(n.vicmsufremet,0)) as vicmsufremet,                                                                                '+StartRecordView+
        '         sum(coalesce(n.vfcp,0)) as vfcp,                                                                                                '+StartRecordView+
        '         sum(coalesce(n.vfcpst,0)) as vfcpst,                                                                                            '+StartRecordView+
        '         sum(coalesce(n.vfcpstret,0)) as vfcpstret,                                                                                      '+StartRecordView+
        '         sum(coalesce(n.vcredicmssn,0)) as vcredicmssn,                                                                                  '+StartRecordView+
        '         sum(coalesce(n.vicmsdeson,0)) as vicmsdeson,                                                                                    '+StartRecordView+
        '         sum(coalesce(n.vicmsstret,0)) as vicmsstret,                                                                                    '+StartRecordView+
        '         sum(coalesce(n.icms_suframa,0)+coalesce(n.pis_suframa,0)+coalesce(n.cofins_suframa,0)+coalesce(n.ipi_suframa,0)) as vsuframa,   '+StartRecordView+
        '         sum(coalesce(n.v_prod2,0)) as vprod                                                                                             '+StartRecordView+
        '    from nfitens n                                                                                                                       '+StartRecordView+
        '   where n.numero_nf = ' + QuotedStr(pNF);

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

procedure TNFItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From nfitens where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TNFItensDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITNFItensModel;
begin
  lQry := vIConexao.CriarQuery;

  FNFItenssLista := TCollections.CreateList<ITNFItensModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       nfitens.*,                                                   ' +
      '       produto.nome_pro,                                            ' +
      '       produto.unidade_pro,                                         ' +
      '       produto.codigo_fornecedor ncm,                               ' +
      '       produto.tipo$_pro icms_origem                                ' +
	    '  from nfitens                                                      ' +
      '       left join produto on produto.codigo_pro = nfitens.codigo_pro ' +
      ' where 1=1                                                          ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TNFItensModel.getNewIface(vIConexao);
      FNFItenssLista.Add(modelo);

      modelo.objeto.NUMERO_NF            := lQry.FieldByName('NUMERO_NF').AsString;
      modelo.objeto.SERIE_NF             := lQry.FieldByName('SERIE_NF').AsString;
      modelo.objeto.CODIGO_PRO           := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.objeto.DESCRICAO_PRODUTO    := lQry.FieldByName('NOME_PRO').AsString;
      modelo.objeto.NCM                  := lQry.FieldByName('NCM').AsString;
      modelo.objeto.ICMS_ORIGEM          := lQry.FieldByName('ICMS_ORIGEM').AsString;
      modelo.objeto.UNIDADE_NF           := lQry.FieldByName('UNIDADE_PRO').AsString;
      modelo.objeto.VALORUNITARIO_NF     := lQry.FieldByName('VALORUNITARIO_NF').AsString;
      modelo.objeto.QUANTIDADE_NF        := lQry.FieldByName('QUANTIDADE_NF').AsString;
      modelo.objeto.VLRVENDA_NF          := lQry.FieldByName('VLRVENDA_NF').AsString;
      modelo.objeto.VLRCUSTO_NF          := lQry.FieldByName('VLRCUSTO_NF').AsString;
      modelo.objeto.REDUCAO_NF           := lQry.FieldByName('REDUCAO_NF').AsString;
      modelo.objeto.ICMS_NF              := lQry.FieldByName('ICMS_NF').AsString;
      modelo.objeto.IPI_NF               := lQry.FieldByName('IPI_NF').AsString;
      modelo.objeto.ITEM_NF              := lQry.FieldByName('ITEM_NF').AsString;
      modelo.objeto.LOJA                 := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.VALOR_ICMS           := lQry.FieldByName('VALOR_ICMS').AsString;
      modelo.objeto.BASE_ICMS_ST         := lQry.FieldByName('BASE_ICMS_ST').AsString;
      modelo.objeto.VALOR_IPI            := lQry.FieldByName('VALOR_IPI').AsString;
      modelo.objeto.BASE_ICMS            := lQry.FieldByName('BASE_ICMS').AsString;
      modelo.objeto.LOTE                 := lQry.FieldByName('LOTE').AsString;
      modelo.objeto.PMVAST_N19           := lQry.FieldByName('PMVAST_N19').AsString;
      modelo.objeto.PREDBCST_N20         := lQry.FieldByName('PREDBCST_N20').AsString;
      modelo.objeto.VBCST_N21            := lQry.FieldByName('VBCST_N21').AsString;
      modelo.objeto.PICMSST_N22          := lQry.FieldByName('PICMSST_N22').AsString;
      modelo.objeto.VICMSST_N23          := lQry.FieldByName('VICMSST_N23').AsString;
      modelo.objeto.MODBCST_N18          := lQry.FieldByName('MODBCST_N18').AsString;
      modelo.objeto.CST_N12              := lQry.FieldByName('CST_N12').AsString;
      modelo.objeto.VBC_N15              := lQry.FieldByName('VBC_N15').AsString;
      modelo.objeto.VICMS_N17            := lQry.FieldByName('VICMS_N17').AsString;
      modelo.objeto.NUMERO_SERIE_ECF     := lQry.FieldByName('NUMERO_SERIE_ECF').AsString;
      modelo.objeto.STATUS               := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.PREDBC_N14           := lQry.FieldByName('PREDBC_N14').AsString;
      modelo.objeto.CFOP                 := lQry.FieldByName('CFOP').AsString;
      modelo.objeto.ID_OBS_LANCAMENTO    := lQry.FieldByName('ID_OBS_LANCAMENTO').AsString;
      modelo.objeto.CSOSN                := lQry.FieldByName('CSOSN').AsString;
      modelo.objeto.PCREDSN              := lQry.FieldByName('PCREDSN').AsString;
      modelo.objeto.VCREDICMSSN          := lQry.FieldByName('VCREDICMSSN').AsString;
      modelo.objeto.NDI_I19              := lQry.FieldByName('NDI_I19').AsString;
      modelo.objeto.DDI_I20              := lQry.FieldByName('DDI_I20').AsString;
      modelo.objeto.XLOCDESEMB_I21       := lQry.FieldByName('XLOCDESEMB_I21').AsString;
      modelo.objeto.UFDESEMB_I22         := lQry.FieldByName('UFDESEMB_I22').AsString;
      modelo.objeto.DDESEMB_I23          := lQry.FieldByName('DDESEMB_I23').AsString;
      modelo.objeto.CEXPORTADOR_I24      := lQry.FieldByName('CEXPORTADOR_I24').AsString;
      modelo.objeto.NADICAO_I26          := lQry.FieldByName('NADICAO_I26').AsString;
      modelo.objeto.NSEQADIC_I27         := lQry.FieldByName('NSEQADIC_I27').AsString;
      modelo.objeto.CFABRICANTE_I28      := lQry.FieldByName('CFABRICANTE_I28').AsString;
      modelo.objeto.VDESCDI_I29          := lQry.FieldByName('VDESCDI_I29').AsString;
      modelo.objeto.VBC_P02              := lQry.FieldByName('VBC_P02').AsString;
      modelo.objeto.VDESPADU_P03         := lQry.FieldByName('VDESPADU_P03').AsString;
      modelo.objeto.VII_P04              := lQry.FieldByName('VII_P04').AsString;
      modelo.objeto.VIOF_P05             := lQry.FieldByName('VIOF_P05').AsString;
      modelo.objeto.CST_Q06              := lQry.FieldByName('CST_Q06').AsString;
      modelo.objeto.VBC_Q07              := lQry.FieldByName('VBC_Q07').AsString;
      modelo.objeto.PPIS_Q08             := lQry.FieldByName('PPIS_Q08').AsString;
      modelo.objeto.VPIS_Q09             := lQry.FieldByName('VPIS_Q09').AsString;
      modelo.objeto.QBCPROD_Q10          := lQry.FieldByName('QBCPROD_Q10').AsString;
      modelo.objeto.VALIQPROD_Q11        := lQry.FieldByName('VALIQPROD_Q11').AsString;
      modelo.objeto.CST_S06              := lQry.FieldByName('CST_S06').AsString;
      modelo.objeto.VBC_S07              := lQry.FieldByName('VBC_S07').AsString;
      modelo.objeto.PCOFINS_S08          := lQry.FieldByName('PCOFINS_S08').AsString;
      modelo.objeto.VCOFINS_S11          := lQry.FieldByName('VCOFINS_S11').AsString;
      modelo.objeto.QBCPROD_S09          := lQry.FieldByName('QBCPROD_S09').AsString;
      modelo.objeto.VALIQPROD_S10        := lQry.FieldByName('VALIQPROD_S10').AsString;
      modelo.objeto.ID                   := lQry.FieldByName('ID').AsString;
      modelo.objeto.VTOTTRIB             := lQry.FieldByName('VTOTTRIB').AsString;
      modelo.objeto.OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      modelo.objeto.CFOP_ID              := lQry.FieldByName('CFOP_ID').AsString;
      modelo.objeto.CONTA_CONTABIL       := lQry.FieldByName('CONTA_CONTABIL').AsString;
      modelo.objeto.VDESC                := lQry.FieldByName('VDESC').AsString;
      modelo.objeto.VSEG                 := lQry.FieldByName('VSEG').AsString;
      modelo.objeto.FRETE                := lQry.FieldByName('FRETE').AsString;
      modelo.objeto.VOUTROS              := lQry.FieldByName('VOUTROS').AsString;
      modelo.objeto.CST_IPI              := lQry.FieldByName('CST_IPI').AsString;
      modelo.objeto.VALOR_DIFERIMENTO    := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
      modelo.objeto.OBS_ITEM             := lQry.FieldByName('OBS_ITEM').AsString;
      modelo.objeto.ICMS_SUFRAMA         := lQry.FieldByName('ICMS_SUFRAMA').AsString;
      modelo.objeto.PIS_SUFRAMA          := lQry.FieldByName('PIS_SUFRAMA').AsString;
      modelo.objeto.COFINS_SUFRAMA       := lQry.FieldByName('COFINS_SUFRAMA').AsString;
      modelo.objeto.IPI_SUFRAMA          := lQry.FieldByName('IPI_SUFRAMA').AsString;
      modelo.objeto.VALOR_SUFRAMA_ITEM   := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
      modelo.objeto.ESTOQUE_2            := lQry.FieldByName('ESTOQUE_2').AsString;
      modelo.objeto.VTOTTRIB_FEDERAL     := lQry.FieldByName('VTOTTRIB_FEDERAL').AsString;
      modelo.objeto.VTOTTRIB_ESTADUAL    := lQry.FieldByName('VTOTTRIB_ESTADUAL').AsString;
      modelo.objeto.VTOTTRIB_MUNICIPAL   := lQry.FieldByName('VTOTTRIB_MUNICIPAL').AsString;
      modelo.objeto.PEDIDO_ID            := lQry.FieldByName('PEDIDO_ID').AsString;
      modelo.objeto.NITEMPED             := lQry.FieldByName('NITEMPED').AsString;
      modelo.objeto.XPED                 := lQry.FieldByName('XPED').AsString;
      modelo.objeto.TPVIATRANSP          := lQry.FieldByName('TPVIATRANSP').AsString;
      modelo.objeto.TPINTERMEDIO         := lQry.FieldByName('TPINTERMEDIO').AsString;
      modelo.objeto.VAFRMM_OPC           := lQry.FieldByName('VAFRMM_OPC').AsString;
      modelo.objeto.VBC_IPI              := lQry.FieldByName('VBC_IPI').AsString;
      modelo.objeto.ALIQUOTA_II          := lQry.FieldByName('ALIQUOTA_II').AsString;
      modelo.objeto.VBCUFDEST            := lQry.FieldByName('VBCUFDEST').AsString;
      modelo.objeto.PFCPUFDEST           := lQry.FieldByName('PFCPUFDEST').AsString;
      modelo.objeto.PICMSUFDEST          := lQry.FieldByName('PICMSUFDEST').AsString;
      modelo.objeto.PICMSINTER           := lQry.FieldByName('PICMSINTER').AsString;
      modelo.objeto.PICMSINTERPART       := lQry.FieldByName('PICMSINTERPART').AsString;
      modelo.objeto.VFCPUFDEST           := lQry.FieldByName('VFCPUFDEST').AsString;
      modelo.objeto.VICMSUFDEST          := lQry.FieldByName('VICMSUFDEST').AsString;
      modelo.objeto.VICMSUFREMET         := lQry.FieldByName('VICMSUFREMET').AsString;
      modelo.objeto.CEST                 := lQry.FieldByName('CEST').AsString;
      modelo.objeto.SAIDA_ID             := lQry.FieldByName('SAIDA_ID').AsString;
      modelo.objeto.V_PROD               := lQry.FieldByName('V_PROD').AsString;
      modelo.objeto.PCREDICMS            := lQry.FieldByName('PCREDICMS').AsString;
      modelo.objeto.PCREDPIS             := lQry.FieldByName('PCREDPIS').AsString;
      modelo.objeto.PCREDCOFINS          := lQry.FieldByName('PCREDCOFINS').AsString;
      modelo.objeto.DESTINO              := lQry.FieldByName('DESTINO').AsString;
      modelo.objeto.BASE_IPI2            := lQry.FieldByName('BASE_IPI2').AsString;
      modelo.objeto.IPI_CENQ             := lQry.FieldByName('IPI_CENQ').AsString;
      modelo.objeto.NITEMPED2            := lQry.FieldByName('NITEMPED2').AsString;
      modelo.objeto.V_PROD2              := lQry.FieldByName('V_PROD2').AsString;
      modelo.objeto.UTRIB                := lQry.FieldByName('UTRIB').AsString;
      modelo.objeto.QTRIB                := lQry.FieldByName('QTRIB').AsString;
      modelo.objeto.VUNTRIB              := lQry.FieldByName('VUNTRIB').AsString;
      modelo.objeto.VBCFCPUFDEST         := lQry.FieldByName('VBCFCPUFDEST').AsString;
      modelo.objeto.VBCFCPST             := lQry.FieldByName('VBCFCPST').AsString;
      modelo.objeto.PFCPST               := lQry.FieldByName('PFCPST').AsString;
      modelo.objeto.VFCPST               := lQry.FieldByName('VFCPST').AsString;
      modelo.objeto.VBCCFP               := lQry.FieldByName('VBCCFP').AsString;
      modelo.objeto.PFCP                 := lQry.FieldByName('PFCP').AsString;
      modelo.objeto.VFCP                 := lQry.FieldByName('VFCP').AsString;
      modelo.objeto.VBCFCPSTRET          := lQry.FieldByName('VBCFCPSTRET').AsString;
      modelo.objeto.PFCPSTRET            := lQry.FieldByName('PFCPSTRET').AsString;
      modelo.objeto.VFCPSTRET            := lQry.FieldByName('VFCPSTRET').AsString;
      modelo.objeto.OS_ID                := lQry.FieldByName('OS_ID').AsString;
      modelo.objeto.CBENEF               := lQry.FieldByName('CBENEF').AsString;
      modelo.objeto.INDESCALA            := lQry.FieldByName('INDESCALA').AsString;
      modelo.objeto.CNPJFAB              := lQry.FieldByName('CNPJFAB').AsString;
      modelo.objeto.PREDBCEFET           := lQry.FieldByName('PREDBCEFET').AsString;
      modelo.objeto.VBCEFET              := lQry.FieldByName('VBCEFET').AsString;
      modelo.objeto.PICMSEFET            := lQry.FieldByName('PICMSEFET').AsString;
      modelo.objeto.VICMSEFET            := lQry.FieldByName('VICMSEFET').AsString;
      modelo.objeto.CENQ                 := lQry.FieldByName('CENQ').AsString;
      modelo.objeto.VBCSTRET             := lQry.FieldByName('VBCSTRET').AsString;
      modelo.objeto.VICMSSTRET           := lQry.FieldByName('VICMSSTRET').AsString;
      modelo.objeto.PICMSSTRET           := lQry.FieldByName('PICMSSTRET').AsString;
      modelo.objeto.VICMSSUBISTITUTORET  := lQry.FieldByName('VICMSSUBISTITUTORET').AsString;
      modelo.objeto.VICMSDESON           := lQry.FieldByName('VICMSDESON').AsString;
      modelo.objeto.MOTDESICMS           := lQry.FieldByName('MOTDESICMS').AsString;
      modelo.objeto.VALOR_VIP            := lQry.FieldByName('VALOR_VIP').AsString;
      modelo.objeto.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.PCRED_PRESUMIDO      := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
      modelo.objeto.NDRAW                := lQry.FieldByName('NDRAW').AsString;
      modelo.objeto.PPRCOMP              := lQry.FieldByName('PPRCOMP').AsString;
      modelo.objeto.VPRCOMP              := lQry.FieldByName('VPRCOMP').AsString;
      modelo.objeto.NRE                  := lQry.FieldByName('NRE').AsString;
      modelo.objeto.CHNFE                := lQry.FieldByName('CHNFE').AsString;
      modelo.objeto.QEXPORT              := lQry.FieldByName('QEXPORT').AsString;
      modelo.objeto.EXTIPI               := lQry.FieldByName('EXTIPI').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TNFItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TNFItensDao.SetNFItenssLista;
begin
  FNFItenssLista := Value;
end;

procedure TNFItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TNFItensDao.SetIDPedidoView(const Value: Integer);
begin
  FIDPedidoView := Value;
end;

procedure TNFItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TNFItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TNFItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TNFItensDao.setParams(var pQry: TFDQuery; pNFItensModel: ITNFItensModel);
begin
  vConstrutor.setParams('NFITENS',pQry,pNFItensModel.objeto);
end;

procedure TNFItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TNFItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TNFItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
