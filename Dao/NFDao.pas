unit NFDao;

interface

uses
  FireDAC.Comp.Client,
  NFModel,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.FuncoesTexto,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TNFDao = class;
  ITNFDao=IObject<TNFDao>;

  TNFDao = class
  private
    [unsafe] mySelf: ITNFDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FNFLista: IList<ITNFModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FNFModel: TNFModel;
    FTotalRecords: Integer;
    FIDPedidoView: Integer;
    procedure SetNFLista(const Value: IList<ITNFModel>);
    procedure SetCountView(const Value: String);
    procedure SetIDPedidoView(const Value: Integer);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure obterTotalRegistros;
    procedure SetNFModel(const Value: TNFModel);

  public
    property NFLista: IList<ITNFModel> read FNFLista write SetNFLista;
    property NFModel: TNFModel read FNFModel write SetNFModel;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDPedidoView: Integer read FIDPedidoView write SetIDPedidoView;

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITNFDao;

    function incluir(pNFModel: ITNFModel): String;
    function alterar(pNFModel: ITNFModel): String;
    function excluir(pNFModel: ITNFModel): String;

    function carregaClasse(ID: String): ITNFModel;
    procedure obterLista;
    procedure obterListaNFe;

    function obterTotalizador: TNFModel;

    procedure setParams(var pQry: TFDQuery; pNFModel: ITNFModel);

end;

implementation

uses
  System.Rtti;

{ TNFDao }

constructor TNFDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TNFDao.Destroy;
begin
  FNFLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TNFDao.excluir(pNFModel: ITNFModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from NF where NUMERO_NF = :NUMERO_NF',[pNFModel.objeto.NUMERO_NF]);
   lQry.ExecSQL;
   Result := pNFModel.objeto.NUMERO_NF;

  finally
    lQry.Free;
  end;
end;

class function TNFDao.getNewIface(pIConexao: IConexao): ITNFDao;
begin
  Result := TImplObjetoOwner<TNFDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TNFDao.carregaClasse(ID: String): ITNFModel;
var
  lQry: TFDQuery;
  ANFModel: ITNFModel;
begin
  lQry := vIConexao.CriarQuery;
  ANFModel := TNFModel.getNewIface(vIConexao);
  Result   := ANFModel;

  try

    lQry.Open('select * from NF where numero_nf = '+QuotedStr(ID));

    if lQry.IsEmpty then
      Exit;

    ANFModel.objeto.NUMERO_NF                    := lQry.FieldByName('NUMERO_NF').AsString;
    ANFModel.objeto.SERIE_NF                     := lQry.FieldByName('SERIE_NF').AsString;
    ANFModel.objeto.CODIGO_CLI                   := lQry.FieldByName('CODIGO_CLI').AsString;
    ANFModel.objeto.CODIGO_VEN                   := lQry.FieldByName('CODIGO_VEN').AsString;
    ANFModel.objeto.CODIGO_PORT                  := lQry.FieldByName('CODIGO_PORT').AsString;
    ANFModel.objeto.CODIGO_TIP                   := lQry.FieldByName('CODIGO_TIP').AsString;
    ANFModel.objeto.DATA_NF                      := lQry.FieldByName('DATA_NF').AsString;
    ANFModel.objeto.VALOR_NF                     := lQry.FieldByName('VALOR_NF').AsString;
    ANFModel.objeto.DESC_NF                      := lQry.FieldByName('DESC_NF').AsString;
    ANFModel.objeto.ACRES_NF                     := lQry.FieldByName('ACRES_NF').AsString;
    ANFModel.objeto.TOTAL_NF                     := lQry.FieldByName('TOTAL_NF').AsString;
    ANFModel.objeto.BICMS_NF                     := lQry.FieldByName('BICMS_NF').AsString;
    ANFModel.objeto.VICMS_NF                     := lQry.FieldByName('VICMS_NF').AsString;
    ANFModel.objeto.ICMS_NF                      := lQry.FieldByName('ICMS_NF').AsString;
    ANFModel.objeto.USUARIO_NF                   := lQry.FieldByName('USUARIO_NF').AsString;
    ANFModel.objeto.NUMERO_PED                   := lQry.FieldByName('NUMERO_PED').AsString;
    ANFModel.objeto.TIPO_NF                      := lQry.FieldByName('TIPO_NF').AsString;
    ANFModel.objeto.STATUS_NF                    := lQry.FieldByName('STATUS_NF').AsString;
    ANFModel.objeto.DESCONTO_NF                  := lQry.FieldByName('DESCONTO_NF').AsString;
    ANFModel.objeto.CFOP_NF                      := lQry.FieldByName('CFOP_NF').AsString;
    ANFModel.objeto.FISCO_NF                     := lQry.FieldByName('FISCO_NF').AsString;
    ANFModel.objeto.OBS_NF                       := lQry.FieldByName('OBS_NF').AsString;
    ANFModel.objeto.NUMERO_ECF                   := lQry.FieldByName('NUMERO_ECF').AsString;
    ANFModel.objeto.DATA_CANCELAMENTO            := lQry.FieldByName('DATA_CANCELAMENTO').AsString;
    ANFModel.objeto.PESO_LIQUIDO                 := lQry.FieldByName('PESO_LIQUIDO').AsString;
    ANFModel.objeto.PESO_BRUTO                   := lQry.FieldByName('PESO_BRUTO').AsString;
    ANFModel.objeto.VALOR_EXTENSO                := lQry.FieldByName('VALOR_EXTENSO').AsString;
    ANFModel.objeto.QTDE_VOLUME                  := lQry.FieldByName('QTDE_VOLUME').AsString;
    ANFModel.objeto.ESPECIE_VOLUME               := lQry.FieldByName('ESPECIE_VOLUME').AsString;
    ANFModel.objeto.TRANSPORTADORA               := lQry.FieldByName('TRANSPORTADORA').AsString;
    ANFModel.objeto.DATA_SAIDA                   := lQry.FieldByName('DATA_SAIDA').AsString;
    ANFModel.objeto.FRETE                        := lQry.FieldByName('FRETE').AsString;
    ANFModel.objeto.CONDICOES_PAGTO              := lQry.FieldByName('CONDICOES_PAGTO').AsString;
    ANFModel.objeto.LOJA                         := lQry.FieldByName('LOJA').AsString;
    ANFModel.objeto.ISENTA_NF                    := lQry.FieldByName('ISENTA_NF').AsString;
    ANFModel.objeto.OUTROS_NF                    := lQry.FieldByName('OUTROS_NF').AsString;
    ANFModel.objeto.BASE_ST_NF                   := lQry.FieldByName('BASE_ST_NF').AsString;
    ANFModel.objeto.ICMS_ST                      := lQry.FieldByName('ICMS_ST').AsString;
    ANFModel.objeto.IPI_NF                       := lQry.FieldByName('IPI_NF').AsString;
    ANFModel.objeto.ID_NF3                       := lQry.FieldByName('ID_NF3').AsString;
    ANFModel.objeto.RECIBO_NFE                   := lQry.FieldByName('RECIBO_NFE').AsString;
    ANFModel.objeto.PROTOCOLO_NFE                := lQry.FieldByName('PROTOCOLO_NFE').AsString;
    ANFModel.objeto.NFE                          := lQry.FieldByName('NFE').AsString;
    ANFModel.objeto.AUTORIZADA                   := lQry.FieldByName('AUTORIZADA').AsString;
    ANFModel.objeto.MODELO                       := lQry.FieldByName('MODELO').AsString;
    ANFModel.objeto.VLRENTRADA_NF                := lQry.FieldByName('VLRENTRADA_NF').AsString;
    ANFModel.objeto.QTPARCELAS                   := lQry.FieldByName('QTPARCELAS').AsString;
    ANFModel.objeto.NUMERO_SERIE_ECF             := lQry.FieldByName('NUMERO_SERIE_ECF').AsString;
    ANFModel.objeto.CCF_CUPOM                    := lQry.FieldByName('CCF_CUPOM').AsString;
    ANFModel.objeto.EMAIL_NFE                    := lQry.FieldByName('EMAIL_NFE').AsString;
    ANFModel.objeto.NOME_XML                     := lQry.FieldByName('NOME_XML').AsString;
    ANFModel.objeto.STATUS                       := lQry.FieldByName('STATUS').AsString;
    ANFModel.objeto.PCTE                         := lQry.FieldByName('PCTE').AsString;
    ANFModel.objeto.HEM                          := lQry.FieldByName('HEM').AsString;
    ANFModel.objeto.DR                           := lQry.FieldByName('DR').AsString;
    ANFModel.objeto.AIH                          := lQry.FieldByName('AIH').AsString;
    ANFModel.objeto.VEND                         := lQry.FieldByName('VEND').AsString;
    ANFModel.objeto.CONV                         := lQry.FieldByName('CONV').AsString;
    ANFModel.objeto.ID_INFO_COMPLEMENTAR         := lQry.FieldByName('ID_INFO_COMPLEMENTAR').AsString;
    ANFModel.objeto.TIPO_FRETE                   := lQry.FieldByName('TIPO_FRETE').AsString;
    ANFModel.objeto.TRANSPORTADORA_ID            := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    ANFModel.objeto.VCREDICMSSN                  := lQry.FieldByName('VCREDICMSSN').AsString;
    ANFModel.objeto.VPIS                         := lQry.FieldByName('VPIS').AsString;
    ANFModel.objeto.VCOFINS                      := lQry.FieldByName('VCOFINS').AsString;
    ANFModel.objeto.ID                           := lQry.FieldByName('ID').AsString;
    ANFModel.objeto.VTOTTRIB                     := lQry.FieldByName('VTOTTRIB').AsString;
    ANFModel.objeto.OBS_FISCAL                   := lQry.FieldByName('OBS_FISCAL').AsString;
    ANFModel.objeto.INFO_COMPLEMENTAR            := lQry.FieldByName('INFO_COMPLEMENTAR').AsString;
    ANFModel.objeto.CFOP_ID                      := lQry.FieldByName('CFOP_ID').AsString;
    ANFModel.objeto.UF_EMBARQUE                  := lQry.FieldByName('UF_EMBARQUE').AsString;
    ANFModel.objeto.LOCAL_EMBARQUE               := lQry.FieldByName('LOCAL_EMBARQUE').AsString;
    ANFModel.objeto.VSEG                         := lQry.FieldByName('VSEG').AsString;
    ANFModel.objeto.VII                          := lQry.FieldByName('VII').AsString;
    ANFModel.objeto.VALOR_SUFRAMA                := lQry.FieldByName('VALOR_SUFRAMA').AsString;
    ANFModel.objeto.XML_NFE                      := lQry.FieldByName('XML_NFE').AsString;
    ANFModel.objeto.STATUS_TRANSMISSAO           := lQry.FieldByName('STATUS_TRANSMISSAO').AsString;
    ANFModel.objeto.HORA_SAIDA                   := lQry.FieldByName('HORA_SAIDA').AsString;
    ANFModel.objeto.VTOTTRIB_FEDERAL             := lQry.FieldByName('VTOTTRIB_FEDERAL').AsString;
    ANFModel.objeto.VTOTTRIB_ESTADUAL            := lQry.FieldByName('VTOTTRIB_ESTADUAL').AsString;
    ANFModel.objeto.VTOTTRIB_MUNICIPAL           := lQry.FieldByName('VTOTTRIB_MUNICIPAL').AsString;
    ANFModel.objeto.CTR_IMPRESSAO_NF             := lQry.FieldByName('CTR_IMPRESSAO_NF').AsString;
    ANFModel.objeto.VALOR_PAGO                   := lQry.FieldByName('VALOR_PAGO').AsString;
    ANFModel.objeto.XPED                         := lQry.FieldByName('XPED').AsString;
    ANFModel.objeto.CNPJ_CPF_CONSUMIDOR          := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
    ANFModel.objeto.DEVOLUCAO_ID                 := lQry.FieldByName('DEVOLUCAO_ID').AsString;
    ANFModel.objeto.PEDIDO_ID                    := lQry.FieldByName('PEDIDO_ID').AsString;
    ANFModel.objeto.OS_ID                        := lQry.FieldByName('OS_ID').AsString;
    ANFModel.objeto.ORCAMENTO_ID                 := lQry.FieldByName('ORCAMENTO_ID').AsString;
    ANFModel.objeto.SAIDAS_ID                    := lQry.FieldByName('SAIDAS_ID').AsString;
    ANFModel.objeto.REF_CUF                      := lQry.FieldByName('REF_CUF').AsString;
    ANFModel.objeto.REF_AAMM                     := lQry.FieldByName('REF_AAMM').AsString;
    ANFModel.objeto.REF_CNPJ                     := lQry.FieldByName('REF_CNPJ').AsString;
    ANFModel.objeto.REF_MOD                      := lQry.FieldByName('REF_MOD').AsString;
    ANFModel.objeto.REF_SERIE                    := lQry.FieldByName('REF_SERIE').AsString;
    ANFModel.objeto.REF_NNF                      := lQry.FieldByName('REF_NNF').AsString;
    ANFModel.objeto.VFCP                         := lQry.FieldByName('VFCP').AsString;
    ANFModel.objeto.VFCPST                       := lQry.FieldByName('VFCPST').AsString;
    ANFModel.objeto.VFCPSTRET                    := lQry.FieldByName('VFCPSTRET').AsString;
    ANFModel.objeto.VFCPUFDEST                   := lQry.FieldByName('VFCPUFDEST').AsString;
    ANFModel.objeto.VICMSUFDEST                  := lQry.FieldByName('VICMSUFDEST').AsString;
    ANFModel.objeto.VICMSUFREMET                 := lQry.FieldByName('VICMSUFREMET').AsString;
    ANFModel.objeto.INDPRES                      := lQry.FieldByName('INDPRES').AsString;
    ANFModel.objeto.GNRE                         := lQry.FieldByName('GNRE').AsString;
    ANFModel.objeto.VDOLAR                       := lQry.FieldByName('VDOLAR').AsString;
    ANFModel.objeto.NUMERO_PROCESSO              := lQry.FieldByName('NUMERO_PROCESSO').AsString;
    ANFModel.objeto.GNRE_IMPRESSO                := lQry.FieldByName('GNRE_IMPRESSO').AsString;
    ANFModel.objeto.TRA_PLACA                    := lQry.FieldByName('TRA_PLACA').AsString;
    ANFModel.objeto.TRA_RNTC                     := lQry.FieldByName('TRA_RNTC').AsString;
    ANFModel.objeto.TRA_UF                       := lQry.FieldByName('TRA_UF').AsString;
    ANFModel.objeto.TRA_MARCA                    := lQry.FieldByName('TRA_MARCA').AsString;
    ANFModel.objeto.TRA_NUMERACAO                := lQry.FieldByName('TRA_NUMERACAO').AsString;
    ANFModel.objeto.TRANSPORTADORA_REDESPACHO_ID := lQry.FieldByName('TRANSPORTADORA_REDESPACHO_ID').AsString;
    ANFModel.objeto.DESPESA_IMPORTACAO           := lQry.FieldByName('DESPESA_IMPORTACAO').AsString;
    ANFModel.objeto.DATA_HORA_AUTORIZACAO        := lQry.FieldByName('DATA_HORA_AUTORIZACAO').AsString;
    ANFModel.objeto.VIPIDEVOL                    := lQry.FieldByName('VIPIDEVOL').AsString;
    ANFModel.objeto.N_SERIE_SAT                  := lQry.FieldByName('N_SERIE_SAT').AsString;
    ANFModel.objeto.CAIXA_SAT                    := lQry.FieldByName('CAIXA_SAT').AsString;
    ANFModel.objeto.AGRUPAMENTO_FATURA           := lQry.FieldByName('AGRUPAMENTO_FATURA').AsString;
    ANFModel.objeto.CONSIGNADO_ID                := lQry.FieldByName('CONSIGNADO_ID').AsString;
    ANFModel.objeto.CONSIGNADO_STATUS            := lQry.FieldByName('CONSIGNADO_STATUS').AsString;
    ANFModel.objeto.PESO_LIQUIDO_NEW             := lQry.FieldByName('PESO_LIQUIDO_NEW').AsString;
    ANFModel.objeto.PESO_BRUTO_NEW               := lQry.FieldByName('PESO_BRUTO_NEW').AsString;
    ANFModel.objeto.STATUS_PENDENTE              := lQry.FieldByName('STATUS_PENDENTE').AsString;
    ANFModel.objeto.CNF                          := lQry.FieldByName('CNF').AsString;
    ANFModel.objeto.VICMSDESON                   := lQry.FieldByName('VICMSDESON').AsString;
    ANFModel.objeto.VICMSSTRET                   := lQry.FieldByName('VICMSSTRET').AsString;
    ANFModel.objeto.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
    ANFModel.objeto.ENTRADA_ID                   := lQry.FieldByName('ENTRADA_ID').AsString;
    ANFModel.objeto.INTERMEDIADOR_CNPJ           := lQry.FieldByName('INTERMEDIADOR_CNPJ').AsString;
    ANFModel.objeto.INTERMEDIADOR_NOME           := lQry.FieldByName('INTERMEDIADOR_NOME').AsString;
    ANFModel.objeto.LOJA_ORIGEM                  := lQry.FieldByName('LOJA_ORIGEM').AsString;
    ANFModel.objeto.ENTREGA_ENDERECO             := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
    ANFModel.objeto.ENTREGA_COMPLEMENTO          := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
    ANFModel.objeto.ENTREGA_NUMERO               := lQry.FieldByName('ENTREGA_NUMERO').AsString;
    ANFModel.objeto.ENTREGA_BAIRRO               := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
    ANFModel.objeto.ENTREGA_CIDADE               := lQry.FieldByName('ENTREGA_CIDADE').AsString;
    ANFModel.objeto.ENTREGA_CEP                  := lQry.FieldByName('ENTREGA_CEP').AsString;
    ANFModel.objeto.ENTREGA_UF                   := lQry.FieldByName('ENTREGA_UF').AsString;
    ANFModel.objeto.ENTREGA_COD_MUNICIPIO        := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
    ANFModel.objeto.WEB_PEDIDO_ID                := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    ANFModel.objeto.TRANSFERENCIA_ID             := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
    ANFModel.objeto.HORA_NF                      := lQry.FieldByName('HORA_NF').AsString;

    Result := ANFModel;

  finally
    lQry.Free;
  end;
end;

function TNFDao.incluir(pNFModel: ITNFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('NF', 'NUMERO_NF');

  try
    lQry.SQL.Add(lSQL);
    pNFModel.objeto.numero_nf := vIConexao.Generetor('gen_nf', true);

    if pNFModel.objeto.MODELO = '65' then
      pNFModel.objeto.numero_ecf := vIConexao.Generetor('GEN_NFCe')
    else if pNFModel.objeto.MODELO = '55' then
      pNFModel.objeto.numero_ecf := vIConexao.Generetor('GEN_NF2');

    setParams(lQry, pNFModel);

    lQry.Open;

    Result := lQry.FieldByName('NUMERO_NF').AsString;
  finally
    lQry.Free;
  end;
end;

function TNFDao.alterar(pNFModel: ITNFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarUpdate('NF', 'NUMERO_NF');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pNFModel);
    lQry.ExecSQL;

    Result := pNFModel.objeto.NUMERO_NF;

  finally
    lQry.Free;
  end;
end;

procedure TNFDao.obterListaNFe;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITNFModel;
begin
  lQry := vIConexao.CriarQuery;

  FNFLista := TCollections.CreateList<ITNFModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
    '       nf.numero_nf,                                                 '+#13+
    '       nf.numero_ecf,                                                '+#13+
    '       nf.numero_ped,                                                '+#13+
    '       nf.data_nf,                                                   '+#13+
    '       nf.serie_nf,                                                  '+#13+
    '       nf.nome_xml,                                                  '+#13+
    '       nf.total_nf,                                                  '+#13+
    '       nf.total_nf,                                                  '+#13+
    '       nf.status_nf,                                                 '+#13+
    '       nf.protocolo_nfe,                                             '+#13+

    '       clientes.razao_cli razao_social_cliente,                      '+#13+
    '       clientes.fantasia_cli cliente_nome_cliente,                   '+#13+
    '       clientes.cnpj_cpf_cli cnpj_cpf_cliente                        '+#13+
    '                                                                     '+#13+
    '                                                                     '+#13+
    '   From NF                                                           '+#13+
    '        left join clientes on clientes.codigo_cli = NF.codigo_cli    '+#13+
    '                                                                     '+#13+
    '   where 1=1                                                         '+#13;

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by ' + FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TNFModel.getNewIface(vIConexao);
      FNFLista.Add(modelo);

      modelo.objeto.NUMERO_NF                   := lQry.FieldByName('NUMERO_NF').AsString;
      modelo.objeto.NUMERO_ECF                  := lQry.FieldByName('NUMERO_ECF').AsString;
      modelo.objeto.NUMERO_PED                  := lQry.FieldByName('NUMERO_PED').AsString;
      modelo.objeto.SERIE_NF                    := lQry.FieldByName('SERIE_NF').AsString;
      modelo.objeto.DATA_NF                     := lQry.FieldByName('DATA_NF').AsString;
      modelo.objeto.CLIENTE_NF                  := lQry.FieldByName('cliente_nome_cliente').AsString;
      modelo.objeto.NOME_XML                    := lQry.FieldByName('NOME_XML').AsString;
      modelo.objeto.TOTAL_NF                    := lQry.FieldByName('TOTAL_NF').AsString;
      modelo.objeto.STATUS_NF                   := lQry.FieldByName('STATUS_NF').AsString;
      modelo.objeto.PROTOCOLO_NFE               := lQry.FieldByName('PROTOCOLO_NFE').AsString;

      lQry.Next;
    end;

    Self.obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TNFDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITNFModel;
begin
  lQry := vIConexao.CriarQuery;

  FNFLista := TCollections.CreateList<ITNFModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
    '     NF.*,                                                                          '+#13+
    '     clientes.razao_cli razao_social_cliente,                                       '+#13+
    '     clientes.fantasia_cli cliente_nome_cliente,                                    '+#13+
    '     clientes.cnpj_cpf_cli cnpj_cpf_cliente,                                        '+#13+
    '     clientes.cep_cli cep_cliente,                                                  '+#13+
    '     clientes.endereco_cli endereco_cliente,                                        '+#13+
    '     clientes.numero_end numero_cliente,                                            '+#13+
    '     clientes.complemento complemento_cliente,                                      '+#13+
    '     clientes.bairro_cli bairro_cliente,                                            '+#13+
    '     clientes.cidade_cli cidade_cliente,                                            '+#13+
    '     clientes.uf_cli as estado_cliente,                                             '+#13+
    '     clientes.telefone_cli telefone_cliente,                                        '+#13+
    '     clientes.celular_cli celular_cliente,                                          '+#13+
    '     clientes.contato_cli contato_cliente,                                          '+#13+

    '     funcionario.nome_fun Vendedor_Nome,                                            '+#13+

    '     transportadora.fantasia_tra transportadora_nome_transp,                        '+#13+
    '     transportadora.cep_tra Cep_transp,                                             '+#13+
    '     transportadora.endereco_tra Endereco_transp,                                   '+#13+
    '     transportadora.complemento Complemento_transp,                                 '+#13+
    '     transportadora.bairro_tra Bairro_transp,                                       '+#13+
    '     transportadora.cidade_tra Cidade_transp,                                       '+#13+
    '     transportadora.uf_tra Estado_transp,                                           '+#13+
    '     transportadora.contato_tra Contato_transp,                                     '+#13+
    '                                                                                    '+#13+
    '     usuario.fantasia Nome_usuario                                                  '+#13+
    '                                                                                    '+#13+
    ' From NF                                                                            '+#13+
    '      left join clientes on clientes.codigo_cli = NF.codigo_cli                     '+#13+
    '      left join funcionario on funcionario.codigo_fun = NF.codigo_ven               '+#13+
    '      left join transportadora on transportadora.codigo_tra = NF.transportadora_id  '+#13+
    '      left join usuario on usuario.id = NF.usuario_nf                               '+#13+
    '                                                                                    '+#13+
    ' where 1=1 ';


    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by ' + FOrderView;


    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TNFModel.getNewIface(vIConexao);
      FNFLista.Add(modelo);

      modelo.objeto.ID                            := lQry.FieldByName('ID').AsString;
      modelo.objeto.NUMERO_NF                     := lQry.FieldByName('NUMERO_NF').AsString;
      modelo.objeto.NUMERO_ECF                    := lQry.FieldByName('NUMERO_ECF').AsString;
      modelo.objeto.NUMERO_PED                    := lQry.FieldByName('NUMERO_PED').AsString;
      modelo.objeto.SERIE_NF                      := lQry.FieldByName('SERIE_NF').AsString;
      modelo.objeto.MODELO                        := lQry.FieldByName('MODELO').AsString;
      modelo.objeto.CODIGO_CLI                    := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.objeto.CODIGO_VEN                    := lQry.FieldByName('CODIGO_VEN').AsString;
      modelo.objeto.DATA_NF                       := lQry.FieldByName('DATA_NF').AsString;
      modelo.objeto.DATA_SAIDA                    := lQry.FieldByName('DATA_SAIDA').AsString;
      modelo.objeto.CLIENTE_NF                    := lQry.FieldByName('cliente_nome_cliente').AsString;
      modelo.objeto.NOME_XML                      := lQry.FieldByName('NOME_XML').AsString;
      modelo.objeto.UF_EMBARQUE                   := lQry.FieldByName('estado_cliente').AsString;

      modelo.objeto.razao_social_cliente          := lQry.FieldByName('razao_social_cliente').AsString;
      modelo.objeto.cliente_nome_cliente          := lQry.FieldByName('cliente_nome_cliente').AsString;
      modelo.objeto.cnpj_cpf_cliente              := lQry.FieldByName('cnpj_cpf_cliente').AsString;
      modelo.objeto.cep_cliente                   := lQry.FieldByName('cep_cliente').AsString;
      modelo.objeto.endereco_cliente              := lQry.FieldByName('endereco_cliente').AsString;
      modelo.objeto.numero_cliente                := lQry.FieldByName('numero_cliente').AsString;
      modelo.objeto.complemento_cliente           := lQry.FieldByName('complemento_cliente').AsString;
      modelo.objeto.bairro_cliente                := lQry.FieldByName('bairro_cliente').AsString;
      modelo.objeto.cidade_cliente                := lQry.FieldByName('cidade_cliente').AsString;
      modelo.objeto.estado_cliente                := lQry.FieldByName('estado_cliente').AsString;
      modelo.objeto.telefone_cliente              := lQry.FieldByName('telefone_cliente').AsString;
      modelo.objeto.celular_cliente               := lQry.FieldByName('celular_cliente').AsString;
      modelo.objeto.contato_cliente               := lQry.FieldByName('contato_cliente').AsString;
      modelo.objeto.Vendedor_Nome                 := lQry.FieldByName('Vendedor_Nome').AsString;
      modelo.objeto.transportadora_nome_transp    := lQry.FieldByName('transportadora_nome_transp').AsString;
      modelo.objeto.Cep_transp                    := lQry.FieldByName('Cep_transp').AsString;
      modelo.objeto.Endereco_transp               := lQry.FieldByName('Endereco_transp').AsString;
      modelo.objeto.Complemento_transp            := lQry.FieldByName('Complemento_transp').AsString;
      modelo.objeto.Bairro_transp                 := lQry.FieldByName('Bairro_transp').AsString;
      modelo.objeto.Cidade_transp                 := lQry.FieldByName('Cidade_transp').AsString;
      modelo.objeto.Estado_transp                 := lQry.FieldByName('Estado_transp').AsString;
      modelo.objeto.Contato_transp                := lQry.FieldByName('Contato_transp').AsString;
      modelo.objeto.Nome_usuario                  := lQry.FieldByName('Nome_usuario').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TNFDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := '  select count(*) records                                      '+#13+
            '    From NF                                                    '+#13+
            '    left join clientes on clientes.codigo_cli = NF.codigo_cli  '+#13+
            '   where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TNFDao.obterTotalizador: TNFModel;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  FNFModel := TNFModel.Create;

  try
    lSql :=
            ' select                                                                              '+SLineBreak+
            '     count(*) QUANTIDADE_ITENS,                                                      '+SLineBreak+
            '     sum(i.quantidade) QUANTIDADE_PRODUTOS,                                          '+SLineBreak+
            '     sum(i.valor_unitario* i.quantidade) TOTAL_PRODUTOS,                             '+SLineBreak+
            '     sum(i.icms_base) TOTAL_BASE_ICMS,                                               '+SLineBreak+
            '     sum(i.icms_valor) TOTAL_ICMS,                                                   '+SLineBreak+
            '     sum(i.icmsst_base) TOTAL_BASE_ICMS_ST,                                          '+SLineBreak+
            '     sum(i.icmsst_valor) TOTAL_ICMS_ST,                                              '+SLineBreak+
            '     sum(0) TOTAL_ICMS_DESON,                                                        '+SLineBreak+
            '     sum(i.ipi_base) TOTAL_BASE_IPI,                                                 '+SLineBreak+
            '     sum(i.ipi_valor) TOTAL_IPI,                                                     '+SLineBreak+
            '     sum(i.pis_base) TOTAL_BASE_PIS,                                                 '+SLineBreak+
            '     sum(i.pis_valor) TOTAL_PIS,                                                     '+SLineBreak+
            '     sum(i.cofins_base) TOTAL_BASE_COFINS,                                           '+SLineBreak+
            '     sum(i.cofins_valor) TOTAL_COFINS,                                               '+SLineBreak+
            '     sum(i.vfcp) TOTAL_FCP,                                                          '+SLineBreak+
            '     sum(i.vfcpst) TOTAL_FCP_ST,                                                     '+SLineBreak+
            '     sum(i.valor_frete) TOTAL_FRETE,                                                 '+SLineBreak+
            '     sum(i.valor_outros) TOTAL_OUTROS,                                               '+SLineBreak+
            '     sum(((0/100)*i.valor_unitario)* cast(i.quantidade as float)) TOTAL_DESCONTO     '+SLineBreak+
            '                                                                                     '+SLineBreak+
            ' from                                                                                '+SLineBreak+
            '     nfitens i                                                                       '+SLineBreak+
            '                                                                                     '+SLineBreak+
            ' where i.NF_ID = '+IntToStr(FIDRecordView);


    lQry.Open(lSQL);
    FNFModel.QUANTIDADE_PRODUTOS := lQry.FieldByName('QUANTIDADE_PRODUTOS').AsFloat;
    FNFModel.QUANTIDADE_ITENS    := lQry.FieldByName('QUANTIDADE_ITENS').AsInteger;
    FNFModel.TOTAL_PRODUTOS      := lQry.FieldByName('TOTAL_PRODUTOS').AsFloat;
    FNFModel.TOTAL_BASE_ICMS     := lQry.FieldByName('TOTAL_BASE_ICMS').AsFloat;
    FNFModel.TOTAL_ICMS          := lQry.FieldByName('TOTAL_ICMS').AsFloat;
    FNFModel.TOTAL_BASE_ICMS_ST  := lQry.FieldByName('TOTAL_BASE_ICMS_ST').AsFloat;
    FNFModel.TOTAL_ICMS_ST       := lQry.FieldByName('TOTAL_ICMS_ST').AsFloat;
    FNFModel.TOTAL_ICMS_DESON    := lQry.FieldByName('TOTAL_ICMS_DESON').AsFloat;
    FNFModel.TOTAL_BASE_IPI      := lQry.FieldByName('TOTAL_BASE_IPI').AsFloat;
    FNFModel.TOTAL_IPI           := lQry.FieldByName('TOTAL_IPI').AsFloat;
    FNFModel.TOTAL_BASE_PIS      := lQry.FieldByName('TOTAL_BASE_PIS').AsFloat;
    FNFModel.TOTAL_PIS           := lQry.FieldByName('TOTAL_PIS').AsFloat;
    FNFModel.TOTAL_BASE_COFINS   := lQry.FieldByName('TOTAL_BASE_COFINS').AsFloat;
    FNFModel.TOTAL_COFINS        := lQry.FieldByName('TOTAL_COFINS').AsFloat;
    FNFModel.TOTAL_FCP           := lQry.FieldByName('TOTAL_FCP').AsFloat;
    FNFModel.TOTAL_FCP_ST        := lQry.FieldByName('TOTAL_FCP_ST').AsFloat;
    FNFModel.TOTAL_FRETE         := lQry.FieldByName('TOTAL_FRETE').AsFloat;
    FNFModel.TOTAL_OUTROS        := lQry.FieldByName('TOTAL_OUTROS').AsFloat;
    FNFModel.TOTAL_DESCONTO      := lQry.FieldByName('TOTAL_DESCONTO').AsFloat;

    if lQry.FieldByName('TOTAL_PRODUTOS').AsFloat > 0 then
      FNFModel.TOTAL_DESCONTO_PERCENTUAL  := (lQry.FieldByName('TOTAL_DESCONTO').AsFloat*100)/lQry.FieldByName('TOTAL_PRODUTOS').AsFloat
    else
      FNFModel.TOTAL_DESCONTO_PERCENTUAL  := 0;

    FNFModel.TOTAL_TOTALNF        := (lQry.FieldByName('TOTAL_PRODUTOS').AsFloat +
                                     lQry.FieldByName('TOTAL_ICMS_ST').AsFloat +
                                     lQry.FieldByName('TOTAL_IPI').AsFloat +
                                     lQry.FieldByName('TOTAL_FCP_ST').AsFloat +
                                     lQry.FieldByName('TOTAL_FRETE').AsFloat +
                                     lQry.FieldByName('TOTAL_OUTROS').AsFloat) -
                                     lQry.FieldByName('TOTAL_DESCONTO').AsFloat;

    Result := FNFModel;

  finally
    lQry.Free;

  end;
end;

function TNFDao.where: String;
var
  lSql: String;
begin
  lSql := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and NF.id = '+IntToStr(FIDRecordView);

  if FIDPedidoView <> 0  then
    lSQL := lSQL + ' and NF.pedido_id = '+IntToStr(FIDPedidoView);

  Result := lSql;
end;


procedure TNFDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TNFDao.SetIDPedidoView(const Value: Integer);
begin
  FIDPedidoView := Value;
end;

procedure TNFDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TNFDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TNFDao.SetNFLista;
begin
  FNFLista := Value;
end;

procedure TNFDao.SetNFModel(const Value: TNFModel);
begin
  FNFModel := Value;
end;

procedure TNFDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TNFDao.setParams(var pQry: TFDQuery; pNFModel: ITNFModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('NF');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TNFModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pNFModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pNFModel.objeto).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TNFDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TNFDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TNFDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
