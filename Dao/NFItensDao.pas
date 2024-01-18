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
    function carregaClasse(pId: String): TNFItensModel;
end;

implementation

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
begin
  pQry.ParamByName('numero_nf').Value           := ifThen(pNFItensModel.NUMERO_NF            = '', Unassigned, pNFItensModel.NUMERO_NF);
  pQry.ParamByName('serie_nf').Value            := ifThen(pNFItensModel.SERIE_NF             = '', Unassigned, pNFItensModel.SERIE_NF);
  pQry.ParamByName('codigo_pro').Value          := ifThen(pNFItensModel.CODIGO_PRO           = '', Unassigned, pNFItensModel.CODIGO_PRO);
  pQry.ParamByName('valorunitario_nf').Value    := ifThen(pNFItensModel.VALORUNITARIO_NF     = '', Unassigned, FormataFloatFireBird(pNFItensModel.VALORUNITARIO_NF));
  pQry.ParamByName('quantidade_nf').Value       := ifThen(pNFItensModel.QUANTIDADE_NF        = '', Unassigned, FormataFloatFireBird(pNFItensModel.QUANTIDADE_NF));
  pQry.ParamByName('vlrvenda_nf').Value         := ifThen(pNFItensModel.VLRVENDA_NF          = '', Unassigned, FormataFloatFireBird(pNFItensModel.VLRVENDA_NF));
  pQry.ParamByName('vlrcusto_nf').Value         := ifThen(pNFItensModel.VLRCUSTO_NF          = '', Unassigned, FormataFloatFireBird(pNFItensModel.VLRCUSTO_NF));
  pQry.ParamByName('reducao_nf').Value          := ifThen(pNFItensModel.REDUCAO_NF           = '', Unassigned, FormataFloatFireBird(pNFItensModel.REDUCAO_NF));
  pQry.ParamByName('icms_nf').Value             := ifThen(pNFItensModel.ICMS_NF              = '', Unassigned, FormataFloatFireBird(pNFItensModel.ICMS_NF));
  pQry.ParamByName('ipi_nf').Value              := ifThen(pNFItensModel.IPI_NF               = '', Unassigned, FormataFloatFireBird(pNFItensModel.IPI_NF));
  pQry.ParamByName('item_nf').Value             := ifThen(pNFItensModel.ITEM_NF              = '', Unassigned, pNFItensModel.ITEM_NF);
  pQry.ParamByName('unidade_nf').Value          := ifThen(pNFItensModel.UNIDADE_NF           = '', Unassigned, pNFItensModel.UNIDADE_NF);
  pQry.ParamByName('loja').Value                := ifThen(pNFItensModel.LOJA                 = '', Unassigned, pNFItensModel.LOJA);
  pQry.ParamByName('valor_icms').Value          := ifThen(pNFItensModel.VALOR_ICMS           = '', Unassigned, FormataFloatFireBird(pNFItensModel.VALOR_ICMS));
  pQry.ParamByName('base_icms_st').Value        := ifThen(pNFItensModel.BASE_ICMS_ST         = '', Unassigned, FormataFloatFireBird(pNFItensModel.BASE_ICMS_ST));
  pQry.ParamByName('valor_ipi').Value           := ifThen(pNFItensModel.VALOR_IPI            = '', Unassigned, FormataFloatFireBird(pNFItensModel.VALOR_IPI));
  pQry.ParamByName('base_icms').Value           := ifThen(pNFItensModel.BASE_ICMS            = '', Unassigned, FormataFloatFireBird(pNFItensModel.BASE_ICMS));
  pQry.ParamByName('lote').Value                := ifThen(pNFItensModel.LOTE                 = '', Unassigned, pNFItensModel.LOTE);
  pQry.ParamByName('pmvast_n19').Value          := ifThen(pNFItensModel.PMVAST_N19           = '', Unassigned, FormataFloatFireBird(pNFItensModel.PMVAST_N19));
  pQry.ParamByName('predbcst_n20').Value        := ifThen(pNFItensModel.PREDBCST_N20         = '', Unassigned, FormataFloatFireBird(pNFItensModel.PREDBCST_N20));
  pQry.ParamByName('vbcst_n21').Value           := ifThen(pNFItensModel.VBCST_N21            = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBCST_N21));
  pQry.ParamByName('picmsst_n22').Value         := ifThen(pNFItensModel.PICMSST_N22          = '', Unassigned, FormataFloatFireBird(pNFItensModel.PICMSST_N22));
  pQry.ParamByName('vicmsst_n23').Value         := ifThen(pNFItensModel.VICMSST_N23          = '', Unassigned, FormataFloatFireBird(pNFItensModel.VICMSST_N23));
  pQry.ParamByName('modbcst_n18').Value         := ifThen(pNFItensModel.MODBCST_N18          = '', Unassigned, pNFItensModel.MODBCST_N18);
  pQry.ParamByName('cst_n12').Value             := ifThen(pNFItensModel.CST_N12              = '', Unassigned, pNFItensModel.CST_N12);
  pQry.ParamByName('vbc_n15').Value             := ifThen(pNFItensModel.VBC_N15              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBC_N15));
  pQry.ParamByName('vicms_n17').Value           := ifThen(pNFItensModel.VICMS_N17            = '', Unassigned, FormataFloatFireBird(pNFItensModel.VICMS_N17));
  pQry.ParamByName('numero_serie_ecf').Value    := ifThen(pNFItensModel.NUMERO_SERIE_ECF     = '', Unassigned, pNFItensModel.NUMERO_SERIE_ECF);
  pQry.ParamByName('status').Value              := ifThen(pNFItensModel.STATUS               = '', Unassigned, pNFItensModel.STATUS);
  pQry.ParamByName('predbc_n14').Value          := ifThen(pNFItensModel.PREDBC_N14           = '', Unassigned, FormataFloatFireBird(pNFItensModel.PREDBC_N14));
  pQry.ParamByName('cfop').Value                := ifThen(pNFItensModel.CFOP                 = '', Unassigned, pNFItensModel.CFOP);
  pQry.ParamByName('id_obs_lancamento').Value   := ifThen(pNFItensModel.ID_OBS_LANCAMENTO    = '', Unassigned, pNFItensModel.ID_OBS_LANCAMENTO);
  pQry.ParamByName('csosn').Value               := ifThen(pNFItensModel.CSOSN                = '', Unassigned, pNFItensModel.CSOSN);
  pQry.ParamByName('pcredsn').Value             := ifThen(pNFItensModel.PCREDSN              = '', Unassigned, pNFItensModel.PCREDSN);
  pQry.ParamByName('vcredicmssn').Value         := ifThen(pNFItensModel.VCREDICMSSN          = '', Unassigned, pNFItensModel.VCREDICMSSN);
  pQry.ParamByName('ndi_i19').Value             := ifThen(pNFItensModel.NDI_I19              = '', Unassigned, pNFItensModel.NDI_I19);
  pQry.ParamByName('ddi_i20').Value             := ifThen(pNFItensModel.DDI_I20              = '', Unassigned, transformaDataFireBird(pNFItensModel.DDI_I20));
  pQry.ParamByName('xlocdesemb_i21').Value      := ifThen(pNFItensModel.XLOCDESEMB_I21       = '', Unassigned, pNFItensModel.XLOCDESEMB_I21);
  pQry.ParamByName('ufdesemb_i22').Value        := ifThen(pNFItensModel.UFDESEMB_I22         = '', Unassigned, pNFItensModel.UFDESEMB_I22);
  pQry.ParamByName('ddesemb_i23').Value         := ifThen(pNFItensModel.DDESEMB_I23          = '', Unassigned, transformaDataFireBird(pNFItensModel.DDESEMB_I23));
  pQry.ParamByName('cexportador_i24').Value     := ifThen(pNFItensModel.CEXPORTADOR_I24      = '', Unassigned, pNFItensModel.CEXPORTADOR_I24);
  pQry.ParamByName('nadicao_i26').Value         := ifThen(pNFItensModel.NADICAO_I26          = '', Unassigned, pNFItensModel.NADICAO_I26);
  pQry.ParamByName('nseqadic_i27').Value        := ifThen(pNFItensModel.NSEQADIC_I27         = '', Unassigned, pNFItensModel.NSEQADIC_I27);
  pQry.ParamByName('cfabricante_i28').Value     := ifThen(pNFItensModel.CFABRICANTE_I28      = '', Unassigned, pNFItensModel.CFABRICANTE_I28);
  pQry.ParamByName('vdescdi_i29').Value         := ifThen(pNFItensModel.VDESCDI_I29          = '', Unassigned, FormataFloatFireBird(pNFItensModel.VDESCDI_I29));
  pQry.ParamByName('vbc_p02').Value             := ifThen(pNFItensModel.VBC_P02              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBC_P02));
  pQry.ParamByName('vdespadu_p03').Value        := ifThen(pNFItensModel.VDESPADU_P03         = '', Unassigned, FormataFloatFireBird(pNFItensModel.VDESPADU_P03));
  pQry.ParamByName('vii_p04').Value             := ifThen(pNFItensModel.VII_P04              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VII_P04));
  pQry.ParamByName('viof_p05').Value            := ifThen(pNFItensModel.VIOF_P05             = '', Unassigned, FormataFloatFireBird(pNFItensModel.VIOF_P05));
  pQry.ParamByName('cst_q06').Value             := ifThen(pNFItensModel.CST_Q06              = '', Unassigned, pNFItensModel.CST_Q06);
  pQry.ParamByName('vbc_q07').Value             := ifThen(pNFItensModel.VBC_Q07              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBC_Q07));
  pQry.ParamByName('ppis_q08').Value            := ifThen(pNFItensModel.PPIS_Q08             = '', Unassigned, FormataFloatFireBird(pNFItensModel.PPIS_Q08));
  pQry.ParamByName('vpis_q09').Value            := ifThen(pNFItensModel.VPIS_Q09             = '', Unassigned, FormataFloatFireBird(pNFItensModel.VPIS_Q09));
  pQry.ParamByName('qbcprod_q10').Value         := ifThen(pNFItensModel.QBCPROD_Q10          = '', Unassigned, FormataFloatFireBird(pNFItensModel.QBCPROD_Q10));
  pQry.ParamByName('valiqprod_q11').Value       := ifThen(pNFItensModel.VALIQPROD_Q11        = '', Unassigned, FormataFloatFireBird(pNFItensModel.VALIQPROD_Q11));
  pQry.ParamByName('cst_s06').Value             := ifThen(pNFItensModel.CST_S06              = '', Unassigned, pNFItensModel.CST_S06);
  pQry.ParamByName('vbc_s07').Value             := ifThen(pNFItensModel.VBC_S07              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBC_S07));
  pQry.ParamByName('pcofins_s08').Value         := ifThen(pNFItensModel.PCOFINS_S08          = '', Unassigned, FormataFloatFireBird(pNFItensModel.PCOFINS_S08));
  pQry.ParamByName('vcofins_s11').Value         := ifThen(pNFItensModel.VCOFINS_S11          = '', Unassigned, FormataFloatFireBird(pNFItensModel.VCOFINS_S11));
  pQry.ParamByName('qbcprod_s09').Value         := ifThen(pNFItensModel.QBCPROD_S09          = '', Unassigned, FormataFloatFireBird(pNFItensModel.QBCPROD_S09));
  pQry.ParamByName('valiqprod_s10').Value       := ifThen(pNFItensModel.VALIQPROD_S10        = '', Unassigned, FormataFloatFireBird(pNFItensModel.VALIQPROD_S10));
  pQry.ParamByName('vtottrib').Value            := ifThen(pNFItensModel.VTOTTRIB             = '', Unassigned, FormataFloatFireBird(pNFItensModel.VTOTTRIB));
  pQry.ParamByName('observacao').Value          := ifThen(pNFItensModel.OBSERVACAO           = '', Unassigned, pNFItensModel.OBSERVACAO);
  pQry.ParamByName('cfop_id').Value             := ifThen(pNFItensModel.CFOP_ID              = '', Unassigned, pNFItensModel.CFOP_ID);
  pQry.ParamByName('conta_contabil').Value      := ifThen(pNFItensModel.CONTA_CONTABIL       = '', Unassigned, pNFItensModel.CONTA_CONTABIL);
  pQry.ParamByName('vdesc').Value               := ifThen(pNFItensModel.VDESC                = '', Unassigned, FormataFloatFireBird(pNFItensModel.VDESC));
  pQry.ParamByName('vseg').Value                := ifThen(pNFItensModel.VSEG                 = '', Unassigned, FormataFloatFireBird(pNFItensModel.VSEG));
  pQry.ParamByName('frete').Value               := ifThen(pNFItensModel.FRETE                = '', Unassigned, FormataFloatFireBird(pNFItensModel.FRETE));
  pQry.ParamByName('voutros').Value             := ifThen(pNFItensModel.VOUTROS              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VOUTROS));
  pQry.ParamByName('cst_ipi').Value             := ifThen(pNFItensModel.CST_IPI              = '', Unassigned, pNFItensModel.CST_IPI);
  pQry.ParamByName('valor_diferimento').Value   := ifThen(pNFItensModel.VALOR_DIFERIMENTO    = '', Unassigned, FormataFloatFireBird(pNFItensModel.VALOR_DIFERIMENTO));
  pQry.ParamByName('obs_item').Value            := ifThen(pNFItensModel.OBS_ITEM             = '', Unassigned, pNFItensModel.OBS_ITEM);
  pQry.ParamByName('icms_suframa').Value        := ifThen(pNFItensModel.ICMS_SUFRAMA         = '', Unassigned, FormataFloatFireBird(pNFItensModel.ICMS_SUFRAMA));
  pQry.ParamByName('pis_suframa').Value         := ifThen(pNFItensModel.PIS_SUFRAMA          = '', Unassigned, FormataFloatFireBird(pNFItensModel.PIS_SUFRAMA));
  pQry.ParamByName('cofins_suframa').Value      := ifThen(pNFItensModel.COFINS_SUFRAMA       = '', Unassigned, FormataFloatFireBird(pNFItensModel.COFINS_SUFRAMA));
  pQry.ParamByName('ipi_suframa').Value         := ifThen(pNFItensModel.IPI_SUFRAMA          = '', Unassigned, FormataFloatFireBird(pNFItensModel.IPI_SUFRAMA));
  pQry.ParamByName('descricao_produto').Value   := ifThen(pNFItensModel.DESCRICAO_PRODUTO    = '', Unassigned, pNFItensModel.DESCRICAO_PRODUTO);
  pQry.ParamByName('estoque_2').Value           := ifThen(pNFItensModel.ESTOQUE_2            = '', Unassigned, pNFItensModel.ESTOQUE_2);
  pQry.ParamByName('vtottrib_federal').Value    := ifThen(pNFItensModel.VTOTTRIB_FEDERAL     = '', Unassigned, FormataFloatFireBird(pNFItensModel.VTOTTRIB_FEDERAL));
  pQry.ParamByName('vtottrib_estadual').Value   := ifThen(pNFItensModel.VTOTTRIB_ESTADUAL    = '', Unassigned, FormataFloatFireBird(pNFItensModel.VTOTTRIB_ESTADUAL));
  pQry.ParamByName('vtottrib_municipal').Value  := ifThen(pNFItensModel.VTOTTRIB_MUNICIPAL   = '', Unassigned, FormataFloatFireBird(pNFItensModel.VTOTTRIB_MUNICIPAL));
  pQry.ParamByName('pedido_id').Value           := ifThen(pNFItensModel.PEDIDO_ID            = '', Unassigned, pNFItensModel.PEDIDO_ID);
  pQry.ParamByName('nitemped').Value            := ifThen(pNFItensModel.NITEMPED             = '', Unassigned, pNFItensModel.NITEMPED);
  pQry.ParamByName('xped').Value                := ifThen(pNFItensModel.XPED                 = '', Unassigned, pNFItensModel.XPED);
  pQry.ParamByName('tpviatransp').Value         := ifThen(pNFItensModel.TPVIATRANSP          = '', Unassigned, pNFItensModel.TPVIATRANSP);
  pQry.ParamByName('tpintermedio').Value        := ifThen(pNFItensModel.TPINTERMEDIO         = '', Unassigned, pNFItensModel.TPINTERMEDIO);
  pQry.ParamByName('vafrmm_opc').Value          := ifThen(pNFItensModel.VAFRMM_OPC           = '', Unassigned, FormataFloatFireBird(pNFItensModel.VAFRMM_OPC));
  pQry.ParamByName('vbc_ipi').Value             := ifThen(pNFItensModel.VBC_IPI              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBC_IPI));
  pQry.ParamByName('aliquota_ii').Value         := ifThen(pNFItensModel.ALIQUOTA_II          = '', Unassigned, FormataFloatFireBird(pNFItensModel.ALIQUOTA_II));
  pQry.ParamByName('vbcufdest').Value           := ifThen(pNFItensModel.VBCUFDEST            = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBCUFDEST));
  pQry.ParamByName('pfcpufdest').Value          := ifThen(pNFItensModel.PFCPUFDEST           = '', Unassigned, FormataFloatFireBird(pNFItensModel.PFCPUFDEST));
  pQry.ParamByName('picmsufdest').Value         := ifThen(pNFItensModel.PICMSUFDEST          = '', Unassigned, FormataFloatFireBird(pNFItensModel.PICMSUFDEST));
  pQry.ParamByName('picmsinter').Value          := ifThen(pNFItensModel.PICMSINTER           = '', Unassigned, FormataFloatFireBird(pNFItensModel.PICMSINTER));
  pQry.ParamByName('picmsinterpart').Value      := ifThen(pNFItensModel.PICMSINTERPART       = '', Unassigned, FormataFloatFireBird(pNFItensModel.PICMSINTERPART));
  pQry.ParamByName('vfcpufdest').Value          := ifThen(pNFItensModel.VFCPUFDEST           = '', Unassigned, FormataFloatFireBird(pNFItensModel.VFCPUFDEST));
  pQry.ParamByName('vicmsufdest').Value         := ifThen(pNFItensModel.VICMSUFDEST          = '', Unassigned, FormataFloatFireBird(pNFItensModel.VICMSUFDEST));
  pQry.ParamByName('vicmsufremet').Value        := ifThen(pNFItensModel.VICMSUFREMET         = '', Unassigned, FormataFloatFireBird(pNFItensModel.VICMSUFREMET));
  pQry.ParamByName('cest').Value                := ifThen(pNFItensModel.CEST                 = '', Unassigned, pNFItensModel.CEST);
  pQry.ParamByName('saida_id').Value            := ifThen(pNFItensModel.SAIDA_ID             = '', Unassigned, pNFItensModel.SAIDA_ID);
  pQry.ParamByName('pcredicms').Value           := ifThen(pNFItensModel.PCREDICMS            = '', Unassigned, FormataFloatFireBird(pNFItensModel.PCREDICMS));
  pQry.ParamByName('pcredpis').Value            := ifThen(pNFItensModel.PCREDPIS             = '', Unassigned, FormataFloatFireBird(pNFItensModel.PCREDPIS));
  pQry.ParamByName('pcredcofins').Value         := ifThen(pNFItensModel.PCREDCOFINS          = '', Unassigned, FormataFloatFireBird(pNFItensModel.PCREDCOFINS));
  pQry.ParamByName('destino').Value             := ifThen(pNFItensModel.DESTINO              = '', Unassigned, pNFItensModel.DESTINO);
  pQry.ParamByName('ipi_cenq').Value            := ifThen(pNFItensModel.IPI_CENQ             = '', Unassigned, pNFItensModel.IPI_CENQ);
  pQry.ParamByName('nitemped2').Value           := ifThen(pNFItensModel.NITEMPED2            = '', Unassigned, pNFItensModel.NITEMPED2);
  pQry.ParamByName('utrib').Value               := ifThen(pNFItensModel.UTRIB                = '', Unassigned, pNFItensModel.UTRIB);
  pQry.ParamByName('qtrib').Value               := ifThen(pNFItensModel.QTRIB                = '', Unassigned, FormataFloatFireBird(pNFItensModel.QTRIB));
  pQry.ParamByName('vuntrib').Value             := ifThen(pNFItensModel.VUNTRIB              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VUNTRIB));
  pQry.ParamByName('vbcfcpufdest').Value        := ifThen(pNFItensModel.VBCFCPUFDEST         = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBCFCPUFDEST));
  pQry.ParamByName('vbcfcpst').Value            := ifThen(pNFItensModel.VBCFCPST             = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBCFCPST));
  pQry.ParamByName('pfcpst').Value              := ifThen(pNFItensModel.PFCPST               = '', Unassigned, FormataFloatFireBird(pNFItensModel.PFCPST));
  pQry.ParamByName('vfcpst').Value              := ifThen(pNFItensModel.VFCPST               = '', Unassigned, FormataFloatFireBird(pNFItensModel.VFCPST));
  pQry.ParamByName('vbccfp').Value              := ifThen(pNFItensModel.VBCCFP               = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBCCFP));
  pQry.ParamByName('pfcp').Value                := ifThen(pNFItensModel.PFCP                 = '', Unassigned, FormataFloatFireBird(pNFItensModel.PFCP));
  pQry.ParamByName('vfcp').Value                := ifThen(pNFItensModel.VFCP                 = '', Unassigned, FormataFloatFireBird(pNFItensModel.VFCP));
  pQry.ParamByName('vbcfcpstret').Value         := ifThen(pNFItensModel.VBCFCPSTRET          = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBCFCPSTRET));
  pQry.ParamByName('pfcpstret').Value           := ifThen(pNFItensModel.PFCPSTRET            = '', Unassigned, FormataFloatFireBird(pNFItensModel.PFCPSTRET));
  pQry.ParamByName('vfcpstret').Value           := ifThen(pNFItensModel.VFCPSTRET            = '', Unassigned, FormataFloatFireBird(pNFItensModel.VFCPSTRET));
  pQry.ParamByName('os_id').Value               := ifThen(pNFItensModel.OS_ID                = '', Unassigned, pNFItensModel.OS_ID);
  pQry.ParamByName('cbenef').Value              := ifThen(pNFItensModel.CBENEF               = '', Unassigned, pNFItensModel.CBENEF);
  pQry.ParamByName('indescala').Value           := ifThen(pNFItensModel.INDESCALA            = '', Unassigned, pNFItensModel.INDESCALA);
  pQry.ParamByName('cnpjfab').Value             := ifThen(pNFItensModel.CNPJFAB              = '', Unassigned, pNFItensModel.CNPJFAB);
  pQry.ParamByName('predbcefet').Value          := ifThen(pNFItensModel.PREDBCEFET           = '', Unassigned, FormataFloatFireBird(pNFItensModel.PREDBCEFET));
  pQry.ParamByName('vbcefet').Value             := ifThen(pNFItensModel.VBCEFET              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBCEFET));
  pQry.ParamByName('picmsefet').Value           := ifThen(pNFItensModel.PICMSEFET            = '', Unassigned, FormataFloatFireBird(pNFItensModel.PICMSEFET));
  pQry.ParamByName('vicmsefet').Value           := ifThen(pNFItensModel.VICMSEFET            = '', Unassigned, FormataFloatFireBird(pNFItensModel.VICMSEFET));
  pQry.ParamByName('cenq').Value                := ifThen(pNFItensModel.CENQ                 = '', Unassigned, pNFItensModel.CENQ);
  pQry.ParamByName('vbcstret').Value            := ifThen(pNFItensModel.VBCSTRET             = '', Unassigned, FormataFloatFireBird(pNFItensModel.VBCSTRET));
  pQry.ParamByName('vicmsstret').Value          := ifThen(pNFItensModel.VICMSSTRET           = '', Unassigned, FormataFloatFireBird(pNFItensModel.VICMSSTRET));
  pQry.ParamByName('picmsstret').Value          := ifThen(pNFItensModel.PICMSSTRET           = '', Unassigned, FormataFloatFireBird(pNFItensModel.PICMSSTRET));
  pQry.ParamByName('vicmssubistitutoret').Value := ifThen(pNFItensModel.VICMSSUBISTITUTORET  = '', Unassigned, FormataFloatFireBird(pNFItensModel.VICMSSUBISTITUTORET));
  pQry.ParamByName('vicmsdeson').Value          := ifThen(pNFItensModel.VICMSDESON           = '', Unassigned, FormataFloatFireBird(pNFItensModel.VICMSDESON));
  pQry.ParamByName('motdesicms').Value          := ifThen(pNFItensModel.MOTDESICMS           = '', Unassigned, pNFItensModel.MOTDESICMS);
  pQry.ParamByName('valor_vip').Value           := ifThen(pNFItensModel.VALOR_VIP            = '', Unassigned, FormataFloatFireBird(pNFItensModel.VALOR_VIP));
  pQry.ParamByName('pcred_presumido').Value     := ifThen(pNFItensModel.PCRED_PRESUMIDO      = '', Unassigned, FormataFloatFireBird(pNFItensModel.PCRED_PRESUMIDO));
  pQry.ParamByName('ndraw').Value               := ifThen(pNFItensModel.NDRAW                = '', Unassigned, pNFItensModel.NDRAW);
  pQry.ParamByName('pprcomp').Value             := ifThen(pNFItensModel.PPRCOMP              = '', Unassigned, FormataFloatFireBird(pNFItensModel.PPRCOMP));
  pQry.ParamByName('vprcomp').Value             := ifThen(pNFItensModel.VPRCOMP              = '', Unassigned, FormataFloatFireBird(pNFItensModel.VPRCOMP));
  pQry.ParamByName('nre').Value                 := ifThen(pNFItensModel.NRE                  = '', Unassigned, pNFItensModel.NRE);
  pQry.ParamByName('chnfe').Value               := ifThen(pNFItensModel.CHNFE                = '', Unassigned, pNFItensModel.CHNFE);
  pQry.ParamByName('qexport').Value             := ifThen(pNFItensModel.QEXPORT              = '', Unassigned, FormataFloatFireBird(pNFItensModel.QEXPORT));
  pQry.ParamByName('extipi').Value              := ifThen(pNFItensModel.EXTIPI               = '', Unassigned, pNFItensModel.EXTIPI);
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
