unit NFItensDao;

interface

uses
  NFItensModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TNFItensDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FNFItenssLista: TObjectList<TNFItensModel>;
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
    procedure SetNFItenssLista(const Value: TObjectList<TNFItensModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    procedure setParams(var pQry: TFDQuery; pNFItensModel: TNFItensModel);
    function where: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property NFItenssLista: TObjectList<TNFItensModel> read FNFItenssLista write SetNFItenssLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pNFItensModel: TNFItensModel): String;
    function alterar(pNFItensModel: TNFItensModel): String;
    function excluir(pNFItensModel: TNFItensModel): String;

    procedure obterLista;
    function obterTotais(pNF : String): TFDMemTable;

    function carregaClasse(pId: String): TNFItensModel;
end;

implementation

uses
  System.Rtti;

{ TNFItens }

function TNFItensDao.carregaClasse(pId: String): TNFItensModel;
var
  lQry: TFDQuery;
  lModel: TNFItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TNFItensModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open(' select * from nfitens where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_NF           := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.SERIE_NF            := lQry.FieldByName('SERIE_NF').AsString;
    lModel.CODIGO_PRO          := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.VALORUNITARIO_NF    := lQry.FieldByName('VALORUNITARIO_NF').AsString;
    lModel.QUANTIDADE_NF       := lQry.FieldByName('QUANTIDADE_NF').AsString;
    lModel.VLRVENDA_NF         := lQry.FieldByName('VLRVENDA_NF').AsString;
    lModel.VLRCUSTO_NF         := lQry.FieldByName('VLRCUSTO_NF').AsString;
    lModel.REDUCAO_NF          := lQry.FieldByName('REDUCAO_NF').AsString;
    lModel.ICMS_NF             := lQry.FieldByName('ICMS_NF').AsString;
    lModel.IPI_NF              := lQry.FieldByName('IPI_NF').AsString;
    lModel.ITEM_NF             := lQry.FieldByName('ITEM_NF').AsString;
    lModel.UNIDADE_NF          := lQry.FieldByName('UNIDADE_NF').AsString;
    lModel.LOJA                := lQry.FieldByName('LOJA').AsString;
    lModel.VALOR_ICMS          := lQry.FieldByName('VALOR_ICMS').AsString;
    lModel.BASE_ICMS_ST        := lQry.FieldByName('BASE_ICMS_ST').AsString;
    lModel.VALOR_IPI           := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.BASE_ICMS           := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.LOTE                := lQry.FieldByName('LOTE').AsString;
    lModel.PMVAST_N19          := lQry.FieldByName('PMVAST_N19').AsString;
    lModel.PREDBCST_N20        := lQry.FieldByName('PREDBCST_N20').AsString;
    lModel.VBCST_N21           := lQry.FieldByName('VBCST_N21').AsString;
    lModel.PICMSST_N22         := lQry.FieldByName('PICMSST_N22').AsString;
    lModel.VICMSST_N23         := lQry.FieldByName('VICMSST_N23').AsString;
    lModel.MODBCST_N18         := lQry.FieldByName('MODBCST_N18').AsString;
    lModel.CST_N12             := lQry.FieldByName('CST_N12').AsString;
    lModel.VBC_N15             := lQry.FieldByName('VBC_N15').AsString;
    lModel.VICMS_N17           := lQry.FieldByName('VICMS_N17').AsString;
    lModel.NUMERO_SERIE_ECF    := lQry.FieldByName('NUMERO_SERIE_ECF').AsString;
    lModel.STATUS              := lQry.FieldByName('STATUS').AsString;
    lModel.PREDBC_N14          := lQry.FieldByName('PREDBC_N14').AsString;
    lModel.CFOP                := lQry.FieldByName('CFOP').AsString;
    lModel.ID_OBS_LANCAMENTO   := lQry.FieldByName('ID_OBS_LANCAMENTO').AsString;
    lModel.CSOSN               := lQry.FieldByName('CSOSN').AsString;
    lModel.PCREDSN             := lQry.FieldByName('PCREDSN').AsString;
    lModel.VCREDICMSSN         := lQry.FieldByName('VCREDICMSSN').AsString;
    lModel.NDI_I19             := lQry.FieldByName('NDI_I19').AsString;
    lModel.DDI_I20             := lQry.FieldByName('DDI_I20').AsString;
    lModel.XLOCDESEMB_I21      := lQry.FieldByName('XLOCDESEMB_I21').AsString;
    lModel.UFDESEMB_I22        := lQry.FieldByName('UFDESEMB_I22').AsString;
    lModel.DDESEMB_I23         := lQry.FieldByName('DDESEMB_I23').AsString;
    lModel.CEXPORTADOR_I24     := lQry.FieldByName('CEXPORTADOR_I24').AsString;
    lModel.NADICAO_I26         := lQry.FieldByName('NADICAO_I26').AsString;
    lModel.NSEQADIC_I27        := lQry.FieldByName('NSEQADIC_I27').AsString;
    lModel.CFABRICANTE_I28     := lQry.FieldByName('CFABRICANTE_I28').AsString;
    lModel.VDESCDI_I29         := lQry.FieldByName('VDESCDI_I29').AsString;
    lModel.VBC_P02             := lQry.FieldByName('VBC_P02').AsString;
    lModel.VDESPADU_P03        := lQry.FieldByName('VDESPADU_P03').AsString;
    lModel.VII_P04             := lQry.FieldByName('VII_P04').AsString;
    lModel.VIOF_P05            := lQry.FieldByName('VIOF_P05').AsString;
    lModel.CST_Q06             := lQry.FieldByName('CST_Q06').AsString;
    lModel.VBC_Q07             := lQry.FieldByName('VBC_Q07').AsString;
    lModel.PPIS_Q08            := lQry.FieldByName('PPIS_Q08').AsString;
    lModel.VPIS_Q09            := lQry.FieldByName('VPIS_Q09').AsString;
    lModel.QBCPROD_Q10         := lQry.FieldByName('QBCPROD_Q10').AsString;
    lModel.VALIQPROD_Q11       := lQry.FieldByName('VALIQPROD_Q11').AsString;
    lModel.CST_S06             := lQry.FieldByName('CST_S06').AsString;
    lModel.VBC_S07             := lQry.FieldByName('VBC_S07').AsString;
    lModel.PCOFINS_S08         := lQry.FieldByName('PCOFINS_S08').AsString;
    lModel.VCOFINS_S11         := lQry.FieldByName('VCOFINS_S11').AsString;
    lModel.QBCPROD_S09         := lQry.FieldByName('QBCPROD_S09').AsString;
    lModel.VALIQPROD_S10       := lQry.FieldByName('VALIQPROD_S10').AsString;
    lModel.ID                  := lQry.FieldByName('ID').AsString;
    lModel.VTOTTRIB            := lQry.FieldByName('VTOTTRIB').AsString;
    lModel.OBSERVACAO          := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.CFOP_ID             := lQry.FieldByName('CFOP_ID').AsString;
    lModel.CONTA_CONTABIL      := lQry.FieldByName('CONTA_CONTABIL').AsString;
    lModel.VDESC               := lQry.FieldByName('VDESC').AsString;
    lModel.VSEG                := lQry.FieldByName('VSEG').AsString;
    lModel.FRETE               := lQry.FieldByName('FRETE').AsString;
    lModel.VOUTROS             := lQry.FieldByName('VOUTROS').AsString;
    lModel.CST_IPI             := lQry.FieldByName('CST_IPI').AsString;
    lModel.VALOR_DIFERIMENTO   := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
    lModel.OBS_ITEM            := lQry.FieldByName('OBS_ITEM').AsString;
    lModel.ICMS_SUFRAMA        := lQry.FieldByName('ICMS_SUFRAMA').AsString;
    lModel.PIS_SUFRAMA         := lQry.FieldByName('PIS_SUFRAMA').AsString;
    lModel.COFINS_SUFRAMA      := lQry.FieldByName('COFINS_SUFRAMA').AsString;
    lModel.IPI_SUFRAMA         := lQry.FieldByName('IPI_SUFRAMA').AsString;
    lModel.VALOR_SUFRAMA_ITEM  := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
    lModel.DESCRICAO_PRODUTO   := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
    lModel.ESTOQUE_2           := lQry.FieldByName('ESTOQUE_2').AsString;
    lModel.VTOTTRIB_FEDERAL    := lQry.FieldByName('VTOTTRIB_FEDERAL').AsString;
    lModel.VTOTTRIB_ESTADUAL   := lQry.FieldByName('VTOTTRIB_ESTADUAL').AsString;
    lModel.VTOTTRIB_MUNICIPAL  := lQry.FieldByName('VTOTTRIB_MUNICIPAL').AsString;
    lModel.PEDIDO_ID           := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.NITEMPED            := lQry.FieldByName('NITEMPED').AsString;
    lModel.XPED                := lQry.FieldByName('XPED').AsString;
    lModel.TPVIATRANSP         := lQry.FieldByName('TPVIATRANSP').AsString;
    lModel.TPINTERMEDIO        := lQry.FieldByName('TPINTERMEDIO').AsString;
    lModel.VAFRMM_OPC          := lQry.FieldByName('VAFRMM_OPC').AsString;
    lModel.VBC_IPI             := lQry.FieldByName('VBC_IPI').AsString;
    lModel.ALIQUOTA_II         := lQry.FieldByName('ALIQUOTA_II').AsString;
    lModel.VBCUFDEST           := lQry.FieldByName('VBCUFDEST').AsString;
    lModel.PFCPUFDEST          := lQry.FieldByName('PFCPUFDEST').AsString;
    lModel.PICMSUFDEST         := lQry.FieldByName('PICMSUFDEST').AsString;
    lModel.PICMSINTER          := lQry.FieldByName('PICMSINTER').AsString;
    lModel.PICMSINTERPART      := lQry.FieldByName('PICMSINTERPART').AsString;
    lModel.VFCPUFDEST          := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.VICMSUFDEST         := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.VICMSUFREMET        := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.CEST                := lQry.FieldByName('CEST').AsString;
    lModel.SAIDA_ID            := lQry.FieldByName('SAIDA_ID').AsString;
    lModel.V_PROD              := lQry.FieldByName('V_PROD').AsString;
    lModel.PCREDICMS           := lQry.FieldByName('PCREDICMS').AsString;
    lModel.PCREDPIS            := lQry.FieldByName('PCREDPIS').AsString;
    lModel.PCREDCOFINS         := lQry.FieldByName('PCREDCOFINS').AsString;
    lModel.DESTINO             := lQry.FieldByName('DESTINO').AsString;
    lModel.BASE_IPI2           := lQry.FieldByName('BASE_IPI2').AsString;
    lModel.IPI_CENQ            := lQry.FieldByName('IPI_CENQ').AsString;
    lModel.NITEMPED2           := lQry.FieldByName('NITEMPED2').AsString;
    lModel.V_PROD2             := lQry.FieldByName('V_PROD2').AsString;
    lModel.UTRIB               := lQry.FieldByName('UTRIB').AsString;
    lModel.QTRIB               := lQry.FieldByName('QTRIB').AsString;
    lModel.VUNTRIB             := lQry.FieldByName('VUNTRIB').AsString;
    lModel.VBCFCPUFDEST        := lQry.FieldByName('VBCFCPUFDEST').AsString;
    lModel.VBCFCPST            := lQry.FieldByName('VBCFCPST').AsString;
    lModel.PFCPST              := lQry.FieldByName('PFCPST').AsString;
    lModel.VFCPST              := lQry.FieldByName('VFCPST').AsString;
    lModel.VBCCFP              := lQry.FieldByName('VBCCFP').AsString;
    lModel.PFCP                := lQry.FieldByName('PFCP').AsString;
    lModel.VFCP                := lQry.FieldByName('VFCP').AsString;
    lModel.VBCFCPSTRET         := lQry.FieldByName('VBCFCPSTRET').AsString;
    lModel.PFCPSTRET           := lQry.FieldByName('PFCPSTRET').AsString;
    lModel.VFCPSTRET           := lQry.FieldByName('VFCPSTRET').AsString;
    lModel.OS_ID               := lQry.FieldByName('OS_ID').AsString;
    lModel.CBENEF              := lQry.FieldByName('CBENEF').AsString;
    lModel.INDESCALA           := lQry.FieldByName('INDESCALA').AsString;
    lModel.CNPJFAB             := lQry.FieldByName('CNPJFAB').AsString;
    lModel.PREDBCEFET          := lQry.FieldByName('PREDBCEFET').AsString;
    lModel.VBCEFET             := lQry.FieldByName('VBCEFET').AsString;
    lModel.PICMSEFET           := lQry.FieldByName('PICMSEFET').AsString;
    lModel.VICMSEFET           := lQry.FieldByName('VICMSEFET').AsString;
    lModel.CENQ                := lQry.FieldByName('CENQ').AsString;
    lModel.VBCSTRET            := lQry.FieldByName('VBCSTRET').AsString;
    lModel.VICMSSTRET          := lQry.FieldByName('VICMSSTRET').AsString;
    lModel.PICMSSTRET          := lQry.FieldByName('PICMSSTRET').AsString;
    lModel.VICMSSUBISTITUTORET := lQry.FieldByName('VICMSSUBISTITUTORET').AsString;
    lModel.VICMSDESON          := lQry.FieldByName('VICMSDESON').AsString;
    lModel.MOTDESICMS          := lQry.FieldByName('MOTDESICMS').AsString;
    lModel.VALOR_VIP           := lQry.FieldByName('VALOR_VIP').AsString;
    lModel.SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
    lModel.PCRED_PRESUMIDO     := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
    lModel.NDRAW               := lQry.FieldByName('NDRAW').AsString;
    lModel.PPRCOMP             := lQry.FieldByName('PPRCOMP').AsString;
    lModel.VPRCOMP             := lQry.FieldByName('VPRCOMP').AsString;
    lModel.NRE                 := lQry.FieldByName('NRE').AsString;
    lModel.CHNFE               := lQry.FieldByName('CHNFE').AsString;
    lModel.QEXPORT             := lQry.FieldByName('QEXPORT').AsString;
    lModel.EXTIPI              := lQry.FieldByName('EXTIPI').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TNFItensDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TNFItensDao.Destroy;
begin

  inherited;
end;

function TNFItensDao.incluir(pNFItensModel: TNFItensModel): String;
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

function TNFItensDao.alterar(pNFItensModel: TNFItensModel): String;
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

    Result := pNFItensModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TNFItensDao.excluir(pNFItensModel: TNFItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from nfitens where ID = :ID',[pNFItensModel.ID]);
   lQry.ExecSQL;
   Result := pNFItensModel.ID;

  finally
    lQry.Free;
  end;
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

  Result := lSQL;
end;

function TNFItensDao.obterTotais(pNF: String): TFDMemTable;
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
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FNFItenssLista := TObjectList<TNFItensModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       nfitens.*             '+
	    '  from nfitens               '+
      ' where 1=1                   ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FNFItenssLista.Add(TNFItensModel.Create(vIConexao));

      i := FNFItenssLista.Count -1;

      FNFItenssLista[i].NUMERO_NF            := lQry.FieldByName('NUMERO_NF').AsString;
      FNFItenssLista[i].SERIE_NF             := lQry.FieldByName('SERIE_NF').AsString;
      FNFItenssLista[i].CODIGO_PRO           := lQry.FieldByName('CODIGO_PRO').AsString;
      FNFItenssLista[i].VALORUNITARIO_NF     := lQry.FieldByName('VALORUNITARIO_NF').AsString;
      FNFItenssLista[i].QUANTIDADE_NF        := lQry.FieldByName('QUANTIDADE_NF').AsString;
      FNFItenssLista[i].VLRVENDA_NF          := lQry.FieldByName('VLRVENDA_NF').AsString;
      FNFItenssLista[i].VLRCUSTO_NF          := lQry.FieldByName('VLRCUSTO_NF').AsString;
      FNFItenssLista[i].REDUCAO_NF           := lQry.FieldByName('REDUCAO_NF').AsString;
      FNFItenssLista[i].ICMS_NF              := lQry.FieldByName('ICMS_NF').AsString;
      FNFItenssLista[i].IPI_NF               := lQry.FieldByName('IPI_NF').AsString;
      FNFItenssLista[i].ITEM_NF              := lQry.FieldByName('ITEM_NF').AsString;
      FNFItenssLista[i].UNIDADE_NF           := lQry.FieldByName('UNIDADE_NF').AsString;
      FNFItenssLista[i].LOJA                 := lQry.FieldByName('LOJA').AsString;
      FNFItenssLista[i].VALOR_ICMS           := lQry.FieldByName('VALOR_ICMS').AsString;
      FNFItenssLista[i].BASE_ICMS_ST         := lQry.FieldByName('BASE_ICMS_ST').AsString;
      FNFItenssLista[i].VALOR_IPI            := lQry.FieldByName('VALOR_IPI').AsString;
      FNFItenssLista[i].BASE_ICMS            := lQry.FieldByName('BASE_ICMS').AsString;
      FNFItenssLista[i].LOTE                 := lQry.FieldByName('LOTE').AsString;
      FNFItenssLista[i].PMVAST_N19           := lQry.FieldByName('PMVAST_N19').AsString;
      FNFItenssLista[i].PREDBCST_N20         := lQry.FieldByName('PREDBCST_N20').AsString;
      FNFItenssLista[i].VBCST_N21            := lQry.FieldByName('VBCST_N21').AsString;
      FNFItenssLista[i].PICMSST_N22          := lQry.FieldByName('PICMSST_N22').AsString;
      FNFItenssLista[i].VICMSST_N23          := lQry.FieldByName('VICMSST_N23').AsString;
      FNFItenssLista[i].MODBCST_N18          := lQry.FieldByName('MODBCST_N18').AsString;
      FNFItenssLista[i].CST_N12              := lQry.FieldByName('CST_N12').AsString;
      FNFItenssLista[i].VBC_N15              := lQry.FieldByName('VBC_N15').AsString;
      FNFItenssLista[i].VICMS_N17            := lQry.FieldByName('VICMS_N17').AsString;
      FNFItenssLista[i].NUMERO_SERIE_ECF     := lQry.FieldByName('NUMERO_SERIE_ECF').AsString;
      FNFItenssLista[i].STATUS               := lQry.FieldByName('STATUS').AsString;
      FNFItenssLista[i].PREDBC_N14           := lQry.FieldByName('PREDBC_N14').AsString;
      FNFItenssLista[i].CFOP                 := lQry.FieldByName('CFOP').AsString;
      FNFItenssLista[i].ID_OBS_LANCAMENTO    := lQry.FieldByName('ID_OBS_LANCAMENTO').AsString;
      FNFItenssLista[i].CSOSN                := lQry.FieldByName('CSOSN').AsString;
      FNFItenssLista[i].PCREDSN              := lQry.FieldByName('PCREDSN').AsString;
      FNFItenssLista[i].VCREDICMSSN          := lQry.FieldByName('VCREDICMSSN').AsString;
      FNFItenssLista[i].NDI_I19              := lQry.FieldByName('NDI_I19').AsString;
      FNFItenssLista[i].DDI_I20              := lQry.FieldByName('DDI_I20').AsString;
      FNFItenssLista[i].XLOCDESEMB_I21       := lQry.FieldByName('XLOCDESEMB_I21').AsString;
      FNFItenssLista[i].UFDESEMB_I22         := lQry.FieldByName('UFDESEMB_I22').AsString;
      FNFItenssLista[i].DDESEMB_I23          := lQry.FieldByName('DDESEMB_I23').AsString;
      FNFItenssLista[i].CEXPORTADOR_I24      := lQry.FieldByName('CEXPORTADOR_I24').AsString;
      FNFItenssLista[i].NADICAO_I26          := lQry.FieldByName('NADICAO_I26').AsString;
      FNFItenssLista[i].NSEQADIC_I27         := lQry.FieldByName('NSEQADIC_I27').AsString;
      FNFItenssLista[i].CFABRICANTE_I28      := lQry.FieldByName('CFABRICANTE_I28').AsString;
      FNFItenssLista[i].VDESCDI_I29          := lQry.FieldByName('VDESCDI_I29').AsString;
      FNFItenssLista[i].VBC_P02              := lQry.FieldByName('VBC_P02').AsString;
      FNFItenssLista[i].VDESPADU_P03         := lQry.FieldByName('VDESPADU_P03').AsString;
      FNFItenssLista[i].VII_P04              := lQry.FieldByName('VII_P04').AsString;
      FNFItenssLista[i].VIOF_P05             := lQry.FieldByName('VIOF_P05').AsString;
      FNFItenssLista[i].CST_Q06              := lQry.FieldByName('CST_Q06').AsString;
      FNFItenssLista[i].VBC_Q07              := lQry.FieldByName('VBC_Q07').AsString;
      FNFItenssLista[i].PPIS_Q08             := lQry.FieldByName('PPIS_Q08').AsString;
      FNFItenssLista[i].VPIS_Q09             := lQry.FieldByName('VPIS_Q09').AsString;
      FNFItenssLista[i].QBCPROD_Q10          := lQry.FieldByName('QBCPROD_Q10').AsString;
      FNFItenssLista[i].VALIQPROD_Q11        := lQry.FieldByName('VALIQPROD_Q11').AsString;
      FNFItenssLista[i].CST_S06              := lQry.FieldByName('CST_S06').AsString;
      FNFItenssLista[i].VBC_S07              := lQry.FieldByName('VBC_S07').AsString;
      FNFItenssLista[i].PCOFINS_S08          := lQry.FieldByName('PCOFINS_S08').AsString;
      FNFItenssLista[i].VCOFINS_S11          := lQry.FieldByName('VCOFINS_S11').AsString;
      FNFItenssLista[i].QBCPROD_S09          := lQry.FieldByName('QBCPROD_S09').AsString;
      FNFItenssLista[i].VALIQPROD_S10        := lQry.FieldByName('VALIQPROD_S10').AsString;
      FNFItenssLista[i].ID                   := lQry.FieldByName('ID').AsString;
      FNFItenssLista[i].VTOTTRIB             := lQry.FieldByName('VTOTTRIB').AsString;
      FNFItenssLista[i].OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      FNFItenssLista[i].CFOP_ID              := lQry.FieldByName('CFOP_ID').AsString;
      FNFItenssLista[i].CONTA_CONTABIL       := lQry.FieldByName('CONTA_CONTABIL').AsString;
      FNFItenssLista[i].VDESC                := lQry.FieldByName('VDESC').AsString;
      FNFItenssLista[i].VSEG                 := lQry.FieldByName('VSEG').AsString;
      FNFItenssLista[i].FRETE                := lQry.FieldByName('FRETE').AsString;
      FNFItenssLista[i].VOUTROS              := lQry.FieldByName('VOUTROS').AsString;
      FNFItenssLista[i].CST_IPI              := lQry.FieldByName('CST_IPI').AsString;
      FNFItenssLista[i].VALOR_DIFERIMENTO    := lQry.FieldByName('VALOR_DIFERIMENTO').AsString;
      FNFItenssLista[i].OBS_ITEM             := lQry.FieldByName('OBS_ITEM').AsString;
      FNFItenssLista[i].ICMS_SUFRAMA         := lQry.FieldByName('ICMS_SUFRAMA').AsString;
      FNFItenssLista[i].PIS_SUFRAMA          := lQry.FieldByName('PIS_SUFRAMA').AsString;
      FNFItenssLista[i].COFINS_SUFRAMA       := lQry.FieldByName('COFINS_SUFRAMA').AsString;
      FNFItenssLista[i].IPI_SUFRAMA          := lQry.FieldByName('IPI_SUFRAMA').AsString;
      FNFItenssLista[i].VALOR_SUFRAMA_ITEM   := lQry.FieldByName('VALOR_SUFRAMA_ITEM').AsString;
      FNFItenssLista[i].DESCRICAO_PRODUTO    := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
      FNFItenssLista[i].ESTOQUE_2            := lQry.FieldByName('ESTOQUE_2').AsString;
      FNFItenssLista[i].VTOTTRIB_FEDERAL     := lQry.FieldByName('VTOTTRIB_FEDERAL').AsString;
      FNFItenssLista[i].VTOTTRIB_ESTADUAL    := lQry.FieldByName('VTOTTRIB_ESTADUAL').AsString;
      FNFItenssLista[i].VTOTTRIB_MUNICIPAL   := lQry.FieldByName('VTOTTRIB_MUNICIPAL').AsString;
      FNFItenssLista[i].PEDIDO_ID            := lQry.FieldByName('PEDIDO_ID').AsString;
      FNFItenssLista[i].NITEMPED             := lQry.FieldByName('NITEMPED').AsString;
      FNFItenssLista[i].XPED                 := lQry.FieldByName('XPED').AsString;
      FNFItenssLista[i].TPVIATRANSP          := lQry.FieldByName('TPVIATRANSP').AsString;
      FNFItenssLista[i].TPINTERMEDIO         := lQry.FieldByName('TPINTERMEDIO').AsString;
      FNFItenssLista[i].VAFRMM_OPC           := lQry.FieldByName('VAFRMM_OPC').AsString;
      FNFItenssLista[i].VBC_IPI              := lQry.FieldByName('VBC_IPI').AsString;
      FNFItenssLista[i].ALIQUOTA_II          := lQry.FieldByName('ALIQUOTA_II').AsString;
      FNFItenssLista[i].VBCUFDEST            := lQry.FieldByName('VBCUFDEST').AsString;
      FNFItenssLista[i].PFCPUFDEST           := lQry.FieldByName('PFCPUFDEST').AsString;
      FNFItenssLista[i].PICMSUFDEST          := lQry.FieldByName('PICMSUFDEST').AsString;
      FNFItenssLista[i].PICMSINTER           := lQry.FieldByName('PICMSINTER').AsString;
      FNFItenssLista[i].PICMSINTERPART       := lQry.FieldByName('PICMSINTERPART').AsString;
      FNFItenssLista[i].VFCPUFDEST           := lQry.FieldByName('VFCPUFDEST').AsString;
      FNFItenssLista[i].VICMSUFDEST          := lQry.FieldByName('VICMSUFDEST').AsString;
      FNFItenssLista[i].VICMSUFREMET         := lQry.FieldByName('VICMSUFREMET').AsString;
      FNFItenssLista[i].CEST                 := lQry.FieldByName('CEST').AsString;
      FNFItenssLista[i].SAIDA_ID             := lQry.FieldByName('SAIDA_ID').AsString;
      FNFItenssLista[i].V_PROD               := lQry.FieldByName('V_PROD').AsString;
      FNFItenssLista[i].PCREDICMS            := lQry.FieldByName('PCREDICMS').AsString;
      FNFItenssLista[i].PCREDPIS             := lQry.FieldByName('PCREDPIS').AsString;
      FNFItenssLista[i].PCREDCOFINS          := lQry.FieldByName('PCREDCOFINS').AsString;
      FNFItenssLista[i].DESTINO              := lQry.FieldByName('DESTINO').AsString;
      FNFItenssLista[i].BASE_IPI2            := lQry.FieldByName('BASE_IPI2').AsString;
      FNFItenssLista[i].IPI_CENQ             := lQry.FieldByName('IPI_CENQ').AsString;
      FNFItenssLista[i].NITEMPED2            := lQry.FieldByName('NITEMPED2').AsString;
      FNFItenssLista[i].V_PROD2              := lQry.FieldByName('V_PROD2').AsString;
      FNFItenssLista[i].UTRIB                := lQry.FieldByName('UTRIB').AsString;
      FNFItenssLista[i].QTRIB                := lQry.FieldByName('QTRIB').AsString;
      FNFItenssLista[i].VUNTRIB              := lQry.FieldByName('VUNTRIB').AsString;
      FNFItenssLista[i].VBCFCPUFDEST         := lQry.FieldByName('VBCFCPUFDEST').AsString;
      FNFItenssLista[i].VBCFCPST             := lQry.FieldByName('VBCFCPST').AsString;
      FNFItenssLista[i].PFCPST               := lQry.FieldByName('PFCPST').AsString;
      FNFItenssLista[i].VFCPST               := lQry.FieldByName('VFCPST').AsString;
      FNFItenssLista[i].VBCCFP               := lQry.FieldByName('VBCCFP').AsString;
      FNFItenssLista[i].PFCP                 := lQry.FieldByName('PFCP').AsString;
      FNFItenssLista[i].VFCP                 := lQry.FieldByName('VFCP').AsString;
      FNFItenssLista[i].VBCFCPSTRET          := lQry.FieldByName('VBCFCPSTRET').AsString;
      FNFItenssLista[i].PFCPSTRET            := lQry.FieldByName('PFCPSTRET').AsString;
      FNFItenssLista[i].VFCPSTRET            := lQry.FieldByName('VFCPSTRET').AsString;
      FNFItenssLista[i].OS_ID                := lQry.FieldByName('OS_ID').AsString;
      FNFItenssLista[i].CBENEF               := lQry.FieldByName('CBENEF').AsString;
      FNFItenssLista[i].INDESCALA            := lQry.FieldByName('INDESCALA').AsString;
      FNFItenssLista[i].CNPJFAB              := lQry.FieldByName('CNPJFAB').AsString;
      FNFItenssLista[i].PREDBCEFET           := lQry.FieldByName('PREDBCEFET').AsString;
      FNFItenssLista[i].VBCEFET              := lQry.FieldByName('VBCEFET').AsString;
      FNFItenssLista[i].PICMSEFET            := lQry.FieldByName('PICMSEFET').AsString;
      FNFItenssLista[i].VICMSEFET            := lQry.FieldByName('VICMSEFET').AsString;
      FNFItenssLista[i].CENQ                 := lQry.FieldByName('CENQ').AsString;
      FNFItenssLista[i].VBCSTRET             := lQry.FieldByName('VBCSTRET').AsString;
      FNFItenssLista[i].VICMSSTRET           := lQry.FieldByName('VICMSSTRET').AsString;
      FNFItenssLista[i].PICMSSTRET           := lQry.FieldByName('PICMSSTRET').AsString;
      FNFItenssLista[i].VICMSSUBISTITUTORET  := lQry.FieldByName('VICMSSUBISTITUTORET').AsString;
      FNFItenssLista[i].VICMSDESON           := lQry.FieldByName('VICMSDESON').AsString;
      FNFItenssLista[i].MOTDESICMS           := lQry.FieldByName('MOTDESICMS').AsString;
      FNFItenssLista[i].VALOR_VIP            := lQry.FieldByName('VALOR_VIP').AsString;
      FNFItenssLista[i].SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      FNFItenssLista[i].PCRED_PRESUMIDO      := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
      FNFItenssLista[i].NDRAW                := lQry.FieldByName('NDRAW').AsString;
      FNFItenssLista[i].PPRCOMP              := lQry.FieldByName('PPRCOMP').AsString;
      FNFItenssLista[i].VPRCOMP              := lQry.FieldByName('VPRCOMP').AsString;
      FNFItenssLista[i].NRE                  := lQry.FieldByName('NRE').AsString;
      FNFItenssLista[i].CHNFE                := lQry.FieldByName('CHNFE').AsString;
      FNFItenssLista[i].QEXPORT              := lQry.FieldByName('QEXPORT').AsString;
      FNFItenssLista[i].EXTIPI               := lQry.FieldByName('EXTIPI').AsString;

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

procedure TNFItensDao.SetNFItenssLista(const Value: TObjectList<TNFItensModel>);
begin
  FNFItenssLista := Value;
end;

procedure TNFItensDao.SetID(const Value: Variant);
begin
  FID := Value;
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

procedure TNFItensDao.setParams(var pQry: TFDQuery; pNFItensModel: TNFItensModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('NFITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TNFItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pNFItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pNFItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
