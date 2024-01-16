unit NFDao;

interface

uses
  FireDAC.Comp.Client,
  Conexao,
  NFModel,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Utils,
  Terasoft.FuncoesTexto;

type
  TNFDao = class

  private
    FNFLista: TObjectList<TNFModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDPedidoView: Integer;
    procedure SetNFLista(const Value: TObjectList<TNFModel>);
    procedure SetCountView(const Value: String);
    procedure SetIDPedidoView(const Value: Integer);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function montaCondicaoQuery: String;
    procedure obterTotalRegistros;


  public
    property NFLista: TObjectList<TNFModel> read FNFLista write SetNFLista;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDPedidoView: Integer read FIDPedidoView write SetIDPedidoView;

    constructor Create;
    destructor Destroy; override;

    function incluir(ANFModel: TNFModel): String;
    function alterar(ANFModel: TNFModel): String;

    function carregaClasse(ID: String): TNFModel;
    procedure obterLista;
    procedure obterListaNFe;

    procedure setParams(var pQry: TFDQuery; pNFModel: TNFModel);

end;

implementation

{ TNFDao }

uses VariaveisGlobais;

constructor TNFDao.Create;
begin

end;

destructor TNFDao.Destroy;
begin
  inherited;

end;

function TNFDao.carregaClasse(ID: String): TNFModel;
var
  lQry: TFDQuery;
  ANFModel: TNFModel;
begin
  lQry := xConexao.CriarQuery;
  ANFModel := TNFModel.Create;
  Result   := ANFModel;

  try

    lQry.Open('select * from NF where numero_nf = '+QuotedStr(ID));

    if lQry.IsEmpty then
      Exit;

    ANFModel.NUMERO_NF                    := lQry.FieldByName('NUMERO_NF').AsString;
    ANFModel.SERIE_NF                     := lQry.FieldByName('SERIE_NF').AsString;
    ANFModel.CODIGO_CLI                   := lQry.FieldByName('CODIGO_CLI').AsString;
    ANFModel.CODIGO_VEN                   := lQry.FieldByName('CODIGO_VEN').AsString;
    ANFModel.CODIGO_PORT                  := lQry.FieldByName('CODIGO_PORT').AsString;
    ANFModel.CODIGO_TIP                   := lQry.FieldByName('CODIGO_TIP').AsString;
    ANFModel.DATA_NF                      := lQry.FieldByName('DATA_NF').AsString;
    ANFModel.VALOR_NF                     := lQry.FieldByName('VALOR_NF').AsString;
    ANFModel.DESC_NF                      := lQry.FieldByName('DESC_NF').AsString;
    ANFModel.ACRES_NF                     := lQry.FieldByName('ACRES_NF').AsString;
    ANFModel.TOTAL_NF                     := lQry.FieldByName('TOTAL_NF').AsString;
    ANFModel.BICMS_NF                     := lQry.FieldByName('BICMS_NF').AsString;
    ANFModel.VICMS_NF                     := lQry.FieldByName('VICMS_NF').AsString;
    ANFModel.ICMS_NF                      := lQry.FieldByName('ICMS_NF').AsString;
    ANFModel.USUARIO_NF                   := lQry.FieldByName('USUARIO_NF').AsString;
    ANFModel.NUMERO_PED                   := lQry.FieldByName('NUMERO_PED').AsString;
    ANFModel.TIPO_NF                      := lQry.FieldByName('TIPO_NF').AsString;
    ANFModel.STATUS_NF                    := lQry.FieldByName('STATUS_NF').AsString;
    ANFModel.DESCONTO_NF                  := lQry.FieldByName('DESCONTO_NF').AsString;
    ANFModel.CFOP_NF                      := lQry.FieldByName('CFOP_NF').AsString;
    ANFModel.FISCO_NF                     := lQry.FieldByName('FISCO_NF').AsString;
    ANFModel.OBS_NF                       := lQry.FieldByName('OBS_NF').AsString;
    ANFModel.NUMERO_ECF                   := lQry.FieldByName('NUMERO_ECF').AsString;
    ANFModel.DATA_CANCELAMENTO            := lQry.FieldByName('DATA_CANCELAMENTO').AsString;
    ANFModel.PESO_LIQUIDO                 := lQry.FieldByName('PESO_LIQUIDO').AsString;
    ANFModel.PESO_BRUTO                   := lQry.FieldByName('PESO_BRUTO').AsString;
    ANFModel.VALOR_EXTENSO                := lQry.FieldByName('VALOR_EXTENSO').AsString;
    ANFModel.QTDE_VOLUME                  := lQry.FieldByName('QTDE_VOLUME').AsString;
    ANFModel.ESPECIE_VOLUME               := lQry.FieldByName('ESPECIE_VOLUME').AsString;
    ANFModel.TRANSPORTADORA               := lQry.FieldByName('TRANSPORTADORA').AsString;
    ANFModel.DATA_SAIDA                   := lQry.FieldByName('DATA_SAIDA').AsString;
    ANFModel.FRETE                        := lQry.FieldByName('FRETE').AsString;
    ANFModel.CONDICOES_PAGTO              := lQry.FieldByName('CONDICOES_PAGTO').AsString;
    ANFModel.LOJA                         := lQry.FieldByName('LOJA').AsString;
    ANFModel.ISENTA_NF                    := lQry.FieldByName('ISENTA_NF').AsString;
    ANFModel.OUTROS_NF                    := lQry.FieldByName('OUTROS_NF').AsString;
    ANFModel.BASE_ST_NF                   := lQry.FieldByName('BASE_ST_NF').AsString;
    ANFModel.ICMS_ST                      := lQry.FieldByName('ICMS_ST').AsString;
    ANFModel.IPI_NF                       := lQry.FieldByName('IPI_NF').AsString;
    ANFModel.ID_NF3                       := lQry.FieldByName('ID_NF3').AsString;
    ANFModel.RECIBO_NFE                   := lQry.FieldByName('RECIBO_NFE').AsString;
    ANFModel.PROTOCOLO_NFE                := lQry.FieldByName('PROTOCOLO_NFE').AsString;
    ANFModel.NFE                          := lQry.FieldByName('NFE').AsString;
    ANFModel.AUTORIZADA                   := lQry.FieldByName('AUTORIZADA').AsString;
    ANFModel.MODELO                       := lQry.FieldByName('MODELO').AsString;
    ANFModel.VLRENTRADA_NF                := lQry.FieldByName('VLRENTRADA_NF').AsString;
    ANFModel.QTPARCELAS                   := lQry.FieldByName('QTPARCELAS').AsString;
    ANFModel.NUMERO_SERIE_ECF             := lQry.FieldByName('NUMERO_SERIE_ECF').AsString;
    ANFModel.CCF_CUPOM                    := lQry.FieldByName('CCF_CUPOM').AsString;
    ANFModel.EMAIL_NFE                    := lQry.FieldByName('EMAIL_NFE').AsString;
    ANFModel.NOME_XML                     := lQry.FieldByName('NOME_XML').AsString;
    ANFModel.STATUS                       := lQry.FieldByName('STATUS').AsString;
    ANFModel.PCTE                         := lQry.FieldByName('PCTE').AsString;
    ANFModel.HEM                          := lQry.FieldByName('HEM').AsString;
    ANFModel.DR                           := lQry.FieldByName('DR').AsString;
    ANFModel.AIH                          := lQry.FieldByName('AIH').AsString;
    ANFModel.VEND                         := lQry.FieldByName('VEND').AsString;
    ANFModel.CONV                         := lQry.FieldByName('CONV').AsString;
    ANFModel.ID_INFO_COMPLEMENTAR         := lQry.FieldByName('ID_INFO_COMPLEMENTAR').AsString;
    ANFModel.TIPO_FRETE                   := lQry.FieldByName('TIPO_FRETE').AsString;
    ANFModel.TRANSPORTADORA_ID            := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    ANFModel.VCREDICMSSN                  := lQry.FieldByName('VCREDICMSSN').AsString;
    ANFModel.VPIS                         := lQry.FieldByName('VPIS').AsString;
    ANFModel.VCOFINS                      := lQry.FieldByName('VCOFINS').AsString;
    ANFModel.ID                           := lQry.FieldByName('ID').AsString;
    ANFModel.VTOTTRIB                     := lQry.FieldByName('VTOTTRIB').AsString;
    ANFModel.OBS_FISCAL                   := lQry.FieldByName('OBS_FISCAL').AsString;
    ANFModel.INFO_COMPLEMENTAR            := lQry.FieldByName('INFO_COMPLEMENTAR').AsString;
    ANFModel.CFOP_ID                      := lQry.FieldByName('CFOP_ID').AsString;
    ANFModel.UF_EMBARQUE                  := lQry.FieldByName('UF_EMBARQUE').AsString;
    ANFModel.LOCAL_EMBARQUE               := lQry.FieldByName('LOCAL_EMBARQUE').AsString;
    ANFModel.VSEG                         := lQry.FieldByName('VSEG').AsString;
    ANFModel.VII                          := lQry.FieldByName('VII').AsString;
    ANFModel.VALOR_SUFRAMA                := lQry.FieldByName('VALOR_SUFRAMA').AsString;
    ANFModel.XML_NFE                      := lQry.FieldByName('XML_NFE').AsString;
    ANFModel.STATUS_TRANSMISSAO           := lQry.FieldByName('STATUS_TRANSMISSAO').AsString;
    ANFModel.HORA_SAIDA                   := lQry.FieldByName('HORA_SAIDA').AsString;
    ANFModel.VTOTTRIB_FEDERAL             := lQry.FieldByName('VTOTTRIB_FEDERAL').AsString;
    ANFModel.VTOTTRIB_ESTADUAL            := lQry.FieldByName('VTOTTRIB_ESTADUAL').AsString;
    ANFModel.VTOTTRIB_MUNICIPAL           := lQry.FieldByName('VTOTTRIB_MUNICIPAL').AsString;
    ANFModel.CTR_IMPRESSAO_NF             := lQry.FieldByName('CTR_IMPRESSAO_NF').AsString;
    ANFModel.VALOR_PAGO                   := lQry.FieldByName('VALOR_PAGO').AsString;
    ANFModel.XPED                         := lQry.FieldByName('XPED').AsString;
    ANFModel.CNPJ_CPF_CONSUMIDOR          := lQry.FieldByName('CNPJ_CPF_CONSUMIDOR').AsString;
    ANFModel.DEVOLUCAO_ID                 := lQry.FieldByName('DEVOLUCAO_ID').AsString;
    ANFModel.PEDIDO_ID                    := lQry.FieldByName('PEDIDO_ID').AsString;
    ANFModel.OS_ID                        := lQry.FieldByName('OS_ID').AsString;
    ANFModel.ORCAMENTO_ID                 := lQry.FieldByName('ORCAMENTO_ID').AsString;
    ANFModel.SAIDAS_ID                    := lQry.FieldByName('SAIDAS_ID').AsString;
    ANFModel.REF_CUF                      := lQry.FieldByName('REF_CUF').AsString;
    ANFModel.REF_AAMM                     := lQry.FieldByName('REF_AAMM').AsString;
    ANFModel.REF_CNPJ                     := lQry.FieldByName('REF_CNPJ').AsString;
    ANFModel.REF_MOD                      := lQry.FieldByName('REF_MOD').AsString;
    ANFModel.REF_SERIE                    := lQry.FieldByName('REF_SERIE').AsString;
    ANFModel.REF_NNF                      := lQry.FieldByName('REF_NNF').AsString;
    ANFModel.VFCP                         := lQry.FieldByName('VFCP').AsString;
    ANFModel.VFCPST                       := lQry.FieldByName('VFCPST').AsString;
    ANFModel.VFCPSTRET                    := lQry.FieldByName('VFCPSTRET').AsString;
    ANFModel.VFCPUFDEST                   := lQry.FieldByName('VFCPUFDEST').AsString;
    ANFModel.VICMSUFDEST                  := lQry.FieldByName('VICMSUFDEST').AsString;
    ANFModel.VICMSUFREMET                 := lQry.FieldByName('VICMSUFREMET').AsString;
    ANFModel.INDPRES                      := lQry.FieldByName('INDPRES').AsString;
    ANFModel.GNRE                         := lQry.FieldByName('GNRE').AsString;
    ANFModel.VDOLAR                       := lQry.FieldByName('VDOLAR').AsString;
    ANFModel.NUMERO_PROCESSO              := lQry.FieldByName('NUMERO_PROCESSO').AsString;
    ANFModel.GNRE_IMPRESSO                := lQry.FieldByName('GNRE_IMPRESSO').AsString;
    ANFModel.TRA_PLACA                    := lQry.FieldByName('TRA_PLACA').AsString;
    ANFModel.TRA_RNTC                     := lQry.FieldByName('TRA_RNTC').AsString;
    ANFModel.TRA_UF                       := lQry.FieldByName('TRA_UF').AsString;
    ANFModel.TRA_MARCA                    := lQry.FieldByName('TRA_MARCA').AsString;
    ANFModel.TRA_NUMERACAO                := lQry.FieldByName('TRA_NUMERACAO').AsString;
    ANFModel.TRANSPORTADORA_REDESPACHO_ID := lQry.FieldByName('TRANSPORTADORA_REDESPACHO_ID').AsString;
    ANFModel.DESPESA_IMPORTACAO           := lQry.FieldByName('DESPESA_IMPORTACAO').AsString;
    ANFModel.DATA_HORA_AUTORIZACAO        := lQry.FieldByName('DATA_HORA_AUTORIZACAO').AsString;
    ANFModel.VIPIDEVOL                    := lQry.FieldByName('VIPIDEVOL').AsString;
    ANFModel.N_SERIE_SAT                  := lQry.FieldByName('N_SERIE_SAT').AsString;
    ANFModel.CAIXA_SAT                    := lQry.FieldByName('CAIXA_SAT').AsString;
    ANFModel.AGRUPAMENTO_FATURA           := lQry.FieldByName('AGRUPAMENTO_FATURA').AsString;
    ANFModel.CONSIGNADO_ID                := lQry.FieldByName('CONSIGNADO_ID').AsString;
    ANFModel.CONSIGNADO_STATUS            := lQry.FieldByName('CONSIGNADO_STATUS').AsString;
    ANFModel.PESO_LIQUIDO_NEW             := lQry.FieldByName('PESO_LIQUIDO_NEW').AsString;
    ANFModel.PESO_BRUTO_NEW               := lQry.FieldByName('PESO_BRUTO_NEW').AsString;
    ANFModel.STATUS_PENDENTE              := lQry.FieldByName('STATUS_PENDENTE').AsString;
    ANFModel.CNF                          := lQry.FieldByName('CNF').AsString;
    ANFModel.VICMSDESON                   := lQry.FieldByName('VICMSDESON').AsString;
    ANFModel.VICMSSTRET                   := lQry.FieldByName('VICMSSTRET').AsString;
    ANFModel.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
    ANFModel.ENTRADA_ID                   := lQry.FieldByName('ENTRADA_ID').AsString;
    ANFModel.INTERMEDIADOR_CNPJ           := lQry.FieldByName('INTERMEDIADOR_CNPJ').AsString;
    ANFModel.INTERMEDIADOR_NOME           := lQry.FieldByName('INTERMEDIADOR_NOME').AsString;
    ANFModel.LOJA_ORIGEM                  := lQry.FieldByName('LOJA_ORIGEM').AsString;
    ANFModel.ENTREGA_ENDERECO             := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
    ANFModel.ENTREGA_COMPLEMENTO          := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
    ANFModel.ENTREGA_NUMERO               := lQry.FieldByName('ENTREGA_NUMERO').AsString;
    ANFModel.ENTREGA_BAIRRO               := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
    ANFModel.ENTREGA_CIDADE               := lQry.FieldByName('ENTREGA_CIDADE').AsString;
    ANFModel.ENTREGA_CEP                  := lQry.FieldByName('ENTREGA_CEP').AsString;
    ANFModel.ENTREGA_UF                   := lQry.FieldByName('ENTREGA_UF').AsString;
    ANFModel.ENTREGA_COD_MUNICIPIO        := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
    ANFModel.WEB_PEDIDO_ID                := lQry.FieldByName('WEB_PEDIDO_ID').AsString;
    ANFModel.TRANSFERENCIA_ID             := lQry.FieldByName('TRANSFERENCIA_ID').AsString;

    Result := ANFModel;

  finally
    lQry.Free;
  end;
end;

function TNFDao.incluir(ANFModel: TNFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := xConexao.CriarQuery;

  lSQL :=
        ' insert into nf (numero_nf,                   '+#13+
        '                 serie_nf,                    '+#13+
        '                 codigo_cli,                  '+#13+
        '                 codigo_ven,                  '+#13+
        '                 codigo_port,                 '+#13+
        '                 codigo_tip,                  '+#13+
        '                 data_nf,                     '+#13+
        '                 valor_nf,                    '+#13+
        '                 desc_nf,                     '+#13+
        '                 acres_nf,                    '+#13+
        '                 total_nf,                    '+#13+
        '                 bicms_nf,                    '+#13+
        '                 vicms_nf,                    '+#13+
        '                 icms_nf,                     '+#13+
        '                 usuario_nf,                  '+#13+
        '                 numero_ped,                  '+#13+
        '                 tipo_nf,                     '+#13+
        '                 status_nf,                   '+#13+
        '                 desconto_nf,                 '+#13+
        '                 cfop_nf,                     '+#13+
        '                 fisco_nf,                    '+#13+
        '                 obs_nf,                      '+#13+
        '                 numero_ecf,                  '+#13+
        '                 data_cancelamento,           '+#13+
        '                 peso_liquido,                '+#13+
        '                 peso_bruto,                  '+#13+
        '                 valor_extenso,               '+#13+
        '                 qtde_volume,                 '+#13+
        '                 especie_volume,              '+#13+
        '                 transportadora,              '+#13+
        '                 data_saida,                  '+#13+
        '                 frete,                       '+#13+
        '                 condicoes_pagto,             '+#13+
        '                 loja,                        '+#13+
        '                 isenta_nf,                   '+#13+
        '                 outros_nf,                   '+#13+
        '                 base_st_nf,                  '+#13+
        '                 icms_st,                     '+#13+
        '                 ipi_nf,                      '+#13+
        '                 id_nf3,                      '+#13+
        '                 recibo_nfe,                  '+#13+
        '                 protocolo_nfe,               '+#13+
        '                 nfe,                         '+#13+
        '                 autorizada,                  '+#13+
        '                 modelo,                      '+#13+
        '                 vlrentrada_nf,               '+#13+
        '                 qtparcelas,                  '+#13+
        '                 numero_serie_ecf,            '+#13+
        '                 ccf_cupom,                   '+#13+
        '                 email_nfe,                   '+#13+
        '                 nome_xml,                    '+#13+
        '                 status,                      '+#13+
        '                 pcte,                        '+#13+
        '                 hem,                         '+#13+
        '                 dr,                          '+#13+
        '                 aih,                         '+#13+
        '                 vend,                        '+#13+
        '                 conv,                        '+#13+
        '                 id_info_complementar,        '+#13+
        '                 tipo_frete,                  '+#13+
        '                 transportadora_id,           '+#13+
        '                 vcredicmssn,                 '+#13+
        '                 vpis,                        '+#13+
        '                 vcofins,                     '+#13+
        '                 id,                          '+#13+
        '                 vtottrib,                    '+#13+
        '                 obs_fiscal,                  '+#13+
        '                 info_complementar,           '+#13+
        '                 cfop_id,                     '+#13+
        '                 uf_embarque,                 '+#13+
        '                 local_embarque,              '+#13+
        '                 vseg,                        '+#13+
        '                 vii,                         '+#13+
        '                 valor_suframa,               '+#13+
        '                 xml_nfe,                     '+#13+
        '                 status_transmissao,          '+#13+
        '                 hora_saida,                  '+#13+
        '                 vtottrib_federal,            '+#13+
        '                 vtottrib_estadual,           '+#13+
        '                 vtottrib_municipal,          '+#13+
        '                 ctr_impressao_nf,            '+#13+
        '                 valor_pago,                  '+#13+
        '                 xped,                        '+#13+
        '                 cnpj_cpf_consumidor,         '+#13+
        '                 devolucao_id,                '+#13+
        '                 pedido_id,                   '+#13+
        '                 os_id,                       '+#13+
        '                 orcamento_id,                '+#13+
        '                 saidas_id,                   '+#13+
        '                 ref_cuf,                     '+#13+
        '                 ref_aamm,                    '+#13+
        '                 ref_cnpj,                    '+#13+
        '                 ref_mod,                     '+#13+
        '                 ref_serie,                   '+#13+
        '                 ref_nnf,                     '+#13+
        '                 vfcp,                        '+#13+
        '                 vfcpst,                      '+#13+
        '                 vfcpstret,                   '+#13+
        '                 vfcpufdest,                  '+#13+
        '                 vicmsufdest,                 '+#13+
        '                 vicmsufremet,                '+#13+
        '                 indpres,                     '+#13+
        '                 gnre,                        '+#13+
        '                 vdolar,                      '+#13+
        '                 numero_processo,             '+#13+
        '                 gnre_impresso,               '+#13+
        '                 tra_placa,                   '+#13+
        '                 tra_rntc,                    '+#13+
        '                 tra_uf,                      '+#13+
        '                 tra_marca,                   '+#13+
        '                 tra_numeracao,               '+#13+
        '                 transportadora_redespacho_id,'+#13+
        '                 despesa_importacao,          '+#13+
        '                 data_hora_autorizacao,       '+#13+
        '                 vipidevol,                   '+#13+
        '                 n_serie_sat,                 '+#13+
        '                 caixa_sat,                   '+#13+
        '                 agrupamento_fatura,          '+#13+
        '                 consignado_id,               '+#13+
        '                 consignado_status,           '+#13+
        '                 peso_liquido_new,            '+#13+
        '                 peso_bruto_new,              '+#13+
        '                 status_pendente,             '+#13+
        '                 cnf,                         '+#13+
        '                 vicmsdeson,                  '+#13+
        '                 vicmsstret,                  '+#13+
        '                 entrada_id,                  '+#13+
        '                 intermediador_cnpj,          '+#13+
        '                 intermediador_nome,          '+#13+
        '                 loja_origem,                 '+#13+
        '                 entrega_endereco,            '+#13+
        '                 entrega_complemento,         '+#13+
        '                 entrega_numero,              '+#13+
        '                 entrega_bairro,              '+#13+
        '                 entrega_cidade,              '+#13+
        '                 entrega_cep,                 '+#13+
        '                 entrega_uf,                  '+#13+
        '                 entrega_cod_municipio,       '+#13+
        '                 web_pedido_id,               '+#13+
        '                 transferencia_id)            '+#13+
        ' values (:numero_nf,                          '+#13+
        '         :serie_nf,                           '+#13+
        '         :codigo_cli,                         '+#13+
        '         :codigo_ven,                         '+#13+
        '         :codigo_port,                        '+#13+
        '         :codigo_tip,                         '+#13+
        '         :data_nf,                            '+#13+
        '         :valor_nf,                           '+#13+
        '         :desc_nf,                            '+#13+
        '         :acres_nf,                           '+#13+
        '         :total_nf,                           '+#13+
        '         :bicms_nf,                           '+#13+
        '         :vicms_nf,                           '+#13+
        '         :icms_nf,                            '+#13+
        '         :usuario_nf,                         '+#13+
        '         :numero_ped,                         '+#13+
        '         :tipo_nf,                            '+#13+
        '         :status_nf,                          '+#13+
        '         :desconto_nf,                        '+#13+
        '         :cfop_nf,                            '+#13+
        '         :fisco_nf,                           '+#13+
        '         :obs_nf,                             '+#13+
        '         :numero_ecf,                         '+#13+
        '         :data_cancelamento,                  '+#13+
        '         :peso_liquido,                       '+#13+
        '         :peso_bruto,                         '+#13+
        '         :valor_extenso,                      '+#13+
        '         :qtde_volume,                        '+#13+
        '         :especie_volume,                     '+#13+
        '         :transportadora,                     '+#13+
        '         :data_saida,                         '+#13+
        '         :frete,                              '+#13+
        '         :condicoes_pagto,                    '+#13+
        '         :loja,                               '+#13+
        '         :isenta_nf,                          '+#13+
        '         :outros_nf,                          '+#13+
        '         :base_st_nf,                         '+#13+
        '         :icms_st,                            '+#13+
        '         :ipi_nf,                             '+#13+
        '         :id_nf3,                             '+#13+
        '         :recibo_nfe,                         '+#13+
        '         :protocolo_nfe,                      '+#13+
        '         :nfe,                                '+#13+
        '         :autorizada,                         '+#13+
        '         :modelo,                             '+#13+
        '         :vlrentrada_nf,                      '+#13+
        '         :qtparcelas,                         '+#13+
        '         :numero_serie_ecf,                   '+#13+
        '         :ccf_cupom,                          '+#13+
        '         :email_nfe,                          '+#13+
        '         :nome_xml,                           '+#13+
        '         :status,                             '+#13+
        '         :pcte,                               '+#13+
        '         :hem,                                '+#13+
        '         :dr,                                 '+#13+
        '         :aih,                                '+#13+
        '         :vend,                               '+#13+
        '         :conv,                               '+#13+
        '         :id_info_complementar,               '+#13+
        '         :tipo_frete,                         '+#13+
        '         :transportadora_id,                  '+#13+
        '         :vcredicmssn,                        '+#13+
        '         :vpis,                               '+#13+
        '         :vcofins,                            '+#13+
        '         :id,                                 '+#13+
        '         :vtottrib,                           '+#13+
        '         :obs_fiscal,                         '+#13+
        '         :info_complementar,                  '+#13+
        '         :cfop_id,                            '+#13+
        '         :uf_embarque,                        '+#13+
        '         :local_embarque,                     '+#13+
        '         :vseg,                               '+#13+
        '         :vii,                                '+#13+
        '         :valor_suframa,                      '+#13+
        '         :xml_nfe,                            '+#13+
        '         :status_transmissao,                 '+#13+
        '         :hora_saida,                         '+#13+
        '         :vtottrib_federal,                   '+#13+
        '         :vtottrib_estadual,                  '+#13+
        '         :vtottrib_municipal,                 '+#13+
        '         :ctr_impressao_nf,                   '+#13+
        '         :valor_pago,                         '+#13+
        '         :xped,                               '+#13+
        '         :cnpj_cpf_consumidor,                '+#13+
        '         :devolucao_id,                       '+#13+
        '         :pedido_id,                          '+#13+
        '         :os_id,                              '+#13+
        '         :orcamento_id,                       '+#13+
        '         :saidas_id,                          '+#13+
        '         :ref_cuf,                            '+#13+
        '         :ref_aamm,                           '+#13+
        '         :ref_cnpj,                           '+#13+
        '         :ref_mod,                            '+#13+
        '         :ref_serie,                          '+#13+
        '         :ref_nnf,                            '+#13+
        '         :vfcp,                               '+#13+
        '         :vfcpst,                             '+#13+
        '         :vfcpstret,                          '+#13+
        '         :vfcpufdest,                         '+#13+
        '         :vicmsufdest,                        '+#13+
        '         :vicmsufremet,                       '+#13+
        '         :indpres,                            '+#13+
        '         :gnre,                               '+#13+
        '         :vdolar,                             '+#13+
        '         :numero_processo,                    '+#13+
        '         :gnre_impresso,                      '+#13+
        '         :tra_placa,                          '+#13+
        '         :tra_rntc,                           '+#13+
        '         :tra_uf,                             '+#13+
        '         :tra_marca,                          '+#13+
        '         :tra_numeracao,                      '+#13+
        '         :transportadora_redespacho_id,       '+#13+
        '         :despesa_importacao,                 '+#13+
        '         :data_hora_autorizacao,              '+#13+
        '         :vipidevol,                          '+#13+
        '         :n_serie_sat,                        '+#13+
        '         :caixa_sat,                          '+#13+
        '         :agrupamento_fatura,                 '+#13+
        '         :consignado_id,                      '+#13+
        '         :consignado_status,                  '+#13+
        '         :peso_liquido_new,                   '+#13+
        '         :peso_bruto_new,                     '+#13+
        '         :status_pendente,                    '+#13+
        '         :cnf,                                '+#13+
        '         :vicmsdeson,                         '+#13+
        '         :vicmsstret,                         '+#13+
        '         :entrada_id,                         '+#13+
        '         :intermediador_cnpj,                 '+#13+
        '         :intermediador_nome,                 '+#13+
        '         :loja_origem,                        '+#13+
        '         :entrega_endereco,                   '+#13+
        '         :entrega_complemento,                '+#13+
        '         :entrega_numero,                     '+#13+
        '         :entrega_bairro,                     '+#13+
        '         :entrega_cidade,                     '+#13+
        '         :entrega_cep,                        '+#13+
        '         :entrega_uf,                         '+#13+
        '         :entrega_cod_municipio,              '+#13+
        '         :web_pedido_id,                      '+#13+
        '         :transferencia_id)                   '+#13+
        '   returning numero_nf ';

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_nf').Value  := xConexao.Generetor('gen_nf');

    if ANFModel.MODELO = '65' then
      lQry.ParamByName('numero_ecf').Value := xConexao.Generetor('GEN_NFCe')
    else if ANFModel.MODELO = '55' then
      lQry.ParamByName('numero_ecf').Value := xConexao.Generetor('GEN_NF2');

    setParams(lQry, ANFModel);

    lQry.Open;

    Result := lQry.FieldByName('NUMERO_NF').AsString;
  finally
    lQry.Free;
  end;
end;

function TNFDao.alterar(ANFModel: TNFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := xConexao.CriarQuery;

  lSQL :=
        ' update nf                                                           '+#13+
        ' set codigo_cli = :codigo_cli,                                       '+#13+
        '     codigo_ven = :codigo_ven,                                       '+#13+
        '     SERIE_NF = :SERIE_NF,                                           '+#13+
        '     codigo_port = :codigo_port,                                     '+#13+
        '     codigo_tip = :codigo_tip,                                       '+#13+
        '     data_nf = :data_nf,                                             '+#13+
        '     valor_nf = :valor_nf,                                           '+#13+
        '     desc_nf = :desc_nf,                                             '+#13+
        '     acres_nf = :acres_nf,                                           '+#13+
        '     total_nf = :total_nf,                                           '+#13+
        '     bicms_nf = :bicms_nf,                                           '+#13+
        '     vicms_nf = :vicms_nf,                                           '+#13+
        '     icms_nf = :icms_nf,                                             '+#13+
        '     usuario_nf = :usuario_nf,                                       '+#13+
        '     numero_ped = :numero_ped,                                       '+#13+
        '     tipo_nf = :tipo_nf,                                             '+#13+
        '     status_nf = :status_nf,                                         '+#13+
        '     desconto_nf = :desconto_nf,                                     '+#13+
        '     cfop_nf = :cfop_nf,                                             '+#13+
        '     fisco_nf = :fisco_nf,                                           '+#13+
        '     obs_nf = :obs_nf,                                               '+#13+
        '     numero_ecf = :numero_ecf,                                       '+#13+
        '     data_cancelamento = :data_cancelamento,                         '+#13+
        '     peso_liquido = :peso_liquido,                                   '+#13+
        '     peso_bruto = :peso_bruto,                                       '+#13+
        '     valor_extenso = :valor_extenso,                                 '+#13+
        '     qtde_volume = :qtde_volume,                                     '+#13+
        '     especie_volume = :especie_volume,                               '+#13+
        '     transportadora = :transportadora,                               '+#13+
        '     data_saida = :data_saida,                                       '+#13+
        '     frete = :frete,                                                 '+#13+
        '     condicoes_pagto = :condicoes_pagto,                             '+#13+
        '     loja = :loja,                                                   '+#13+
        '     isenta_nf = :isenta_nf,                                         '+#13+
        '     outros_nf = :outros_nf,                                         '+#13+
        '     base_st_nf = :base_st_nf,                                       '+#13+
        '     icms_st = :icms_st,                                             '+#13+
        '     ipi_nf = :ipi_nf,                                               '+#13+
        '     id_nf3 = :id_nf3,                                               '+#13+
        '     recibo_nfe = :recibo_nfe,                                       '+#13+
        '     protocolo_nfe = :protocolo_nfe,                                 '+#13+
        '     nfe = :nfe,                                                     '+#13+
        '     autorizada = :autorizada,                                       '+#13+
        '     modelo = :modelo,                                               '+#13+
        '     vlrentrada_nf = :vlrentrada_nf,                                 '+#13+
        '     qtparcelas = :qtparcelas,                                       '+#13+
        '     numero_serie_ecf = :numero_serie_ecf,                           '+#13+
        '     ccf_cupom = :ccf_cupom,                                         '+#13+
        '     email_nfe = :email_nfe,                                         '+#13+
        '     nome_xml = :nome_xml,                                           '+#13+
        '     status = :status,                                               '+#13+
        '     pcte = :pcte,                                                   '+#13+
        '     hem = :hem,                                                     '+#13+
        '     dr = :dr,                                                       '+#13+
        '     aih = :aih,                                                     '+#13+
        '     vend = :vend,                                                   '+#13+
        '     conv = :conv,                                                   '+#13+
        '     id_info_complementar = :id_info_complementar,                   '+#13+
        '     tipo_frete = :tipo_frete,                                       '+#13+
        '     transportadora_id = :transportadora_id,                         '+#13+
        '     vcredicmssn = :vcredicmssn,                                     '+#13+
        '     vpis = :vpis,                                                   '+#13+
        '     vcofins = :vcofins,                                             '+#13+
        '     id = :id,                                                       '+#13+
        '     vtottrib = :vtottrib,                                           '+#13+
        '     obs_fiscal = :obs_fiscal,                                       '+#13+
        '     info_complementar = :info_complementar,                         '+#13+
        '     cfop_id = :cfop_id,                                             '+#13+
        '     uf_embarque = :uf_embarque,                                     '+#13+
        '     local_embarque = :local_embarque,                               '+#13+
        '     vseg = :vseg,                                                   '+#13+
        '     vii = :vii,                                                     '+#13+
        '     valor_suframa = :valor_suframa,                                 '+#13+
        '     xml_nfe = :xml_nfe,                                             '+#13+
        '     status_transmissao = :status_transmissao,                       '+#13+
        '     hora_saida = :hora_saida,                                       '+#13+
        '     vtottrib_federal = :vtottrib_federal,                           '+#13+
        '     vtottrib_estadual = :vtottrib_estadual,                         '+#13+
        '     vtottrib_municipal = :vtottrib_municipal,                       '+#13+
        '     ctr_impressao_nf = :ctr_impressao_nf,                           '+#13+
        '     valor_pago = :valor_pago,                                       '+#13+
        '     xped = :xped,                                                   '+#13+
        '     cnpj_cpf_consumidor = :cnpj_cpf_consumidor,                     '+#13+
        '     devolucao_id = :devolucao_id,                                   '+#13+
        '     pedido_id = :pedido_id,                                         '+#13+
        '     os_id = :os_id,                                                 '+#13+
        '     orcamento_id = :orcamento_id,                                   '+#13+
        '     saidas_id = :saidas_id,                                         '+#13+
        '     ref_cuf = :ref_cuf,                                             '+#13+
        '     ref_aamm = :ref_aamm,                                           '+#13+
        '     ref_cnpj = :ref_cnpj,                                           '+#13+
        '     ref_mod = :ref_mod,                                             '+#13+
        '     ref_serie = :ref_serie,                                         '+#13+
        '     ref_nnf = :ref_nnf,                                             '+#13+
        '     vfcp = :vfcp,                                                   '+#13+
        '     vfcpst = :vfcpst,                                               '+#13+
        '     vfcpstret = :vfcpstret,                                         '+#13+
        '     vfcpufdest = :vfcpufdest,                                       '+#13+
        '     vicmsufdest = :vicmsufdest,                                     '+#13+
        '     vicmsufremet = :vicmsufremet,                                   '+#13+
        '     indpres = :indpres,                                             '+#13+
        '     gnre = :gnre,                                                   '+#13+
        '     vdolar = :vdolar,                                               '+#13+
        '     numero_processo = :numero_processo,                             '+#13+
        '     gnre_impresso = :gnre_impresso,                                 '+#13+
        '     tra_placa = :tra_placa,                                         '+#13+
        '     tra_rntc = :tra_rntc,                                           '+#13+
        '     tra_uf = :tra_uf,                                               '+#13+
        '     tra_marca = :tra_marca,                                         '+#13+
        '     tra_numeracao = :tra_numeracao,                                 '+#13+
        '     transportadora_redespacho_id = :transportadora_redespacho_id,   '+#13+
        '     despesa_importacao = :despesa_importacao,                       '+#13+
        '     data_hora_autorizacao = :data_hora_autorizacao,                 '+#13+
        '     vipidevol = :vipidevol,                                         '+#13+
        '     n_serie_sat = :n_serie_sat,                                     '+#13+
        '     caixa_sat = :caixa_sat,                                         '+#13+
        '     agrupamento_fatura = :agrupamento_fatura,                       '+#13+
        '     consignado_id = :consignado_id,                                 '+#13+
        '     consignado_status = :consignado_status,                         '+#13+
        '     peso_liquido_new = :peso_liquido_new,                           '+#13+
        '     peso_bruto_new = :peso_bruto_new,                               '+#13+
        '     status_pendente = :status_pendente,                             '+#13+
        '     cnf = :cnf,                                                     '+#13+
        '     vicmsdeson = :vicmsdeson,                                       '+#13+
        '     vicmsstret = :vicmsstret,                                       '+#13+
        '     systime = :systime,                                             '+#13+
        '     entrada_id = :entrada_id,                                       '+#13+
        '     intermediador_cnpj = :intermediador_cnpj,                       '+#13+
        '     intermediador_nome = :intermediador_nome,                       '+#13+
        '     loja_origem = :loja_origem,                                     '+#13+
        '     entrega_endereco = :entrega_endereco,                           '+#13+
        '     entrega_complemento = :entrega_complemento,                     '+#13+
        '     entrega_numero = :entrega_numero,                               '+#13+
        '     entrega_bairro = :entrega_bairro,                               '+#13+
        '     entrega_cidade = :entrega_cidade,                               '+#13+
        '     entrega_cep = :entrega_cep,                                     '+#13+
        '     entrega_uf = :entrega_uf,                                       '+#13+
        '     entrega_cod_municipio = :entrega_cod_municipio,                 '+#13+
        '     web_pedido_id = :web_pedido_id,                                 '+#13+
        '     transferencia_id = :transferencia_id                            '+#13+
        ' where (numero_nf = :numero_nf) ';

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_nf').Value  :=	ANFModel.NUMERO_NF;
    lQry.ParamByName('numero_ecf').Value :=	ANFModel.NUMERO_ECF;
    setParams(lQry, ANFModel);
    lQry.ExecSQL;

    Result := ANFModel.NUMERO_NF;

  finally
    lQry.Free;
  end;
end;

procedure TNFDao.obterListaNFe;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := xConexao.CriarQuery;

  FNFLista := TObjectList<TNFModel>.Create;

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

    '       clientes.razao_cli razao_social_cliente,                      '+#13+
    '       clientes.fantasia_cli cliente_nome_cliente,                   '+#13+
    '       clientes.cnpj_cpf_cli cnpj_cpf_cliente                        '+#13+
    '                                                                     '+#13+
    '                                                                     '+#13+
    '   From NF                                                           '+#13+
    '        left join clientes on clientes.codigo_cli = NF.codigo_cli    '+#13+
    '                                                                     '+#13+
    '   where 1=1                                                         '+#13;

    lSQL := lSQL + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by ' + FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FNFLista.Add(TNFModel.Create);

      i := FNFLista.Count -1;
      FNFLista[i].NUMERO_NF                   := lQry.FieldByName('NUMERO_NF').AsString;
      FNFLista[i].NUMERO_ECF                  := lQry.FieldByName('NUMERO_ECF').AsString;
      FNFLista[i].NUMERO_PED                  := lQry.FieldByName('NUMERO_PED').AsString;
      FNFLista[i].SERIE_NF                    := lQry.FieldByName('SERIE_NF').AsString;
      FNFLista[i].DATA_NF                     := lQry.FieldByName('DATA_NF').AsString;
      FNFLista[i].CLIENTE_NF                  := lQry.FieldByName('cliente_nome_cliente').AsString;
      FNFLista[i].NOME_XML                    := lQry.FieldByName('NOME_XML').AsString;
      FNFLista[i].TOTAL_NF                    := lQry.FieldByName('TOTAL_NF').AsString;
      FNFLista[i].STATUS_NF                   := lQry.FieldByName('STATUS_NF').AsString;

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
  i: INteger;
begin
  lQry := xConexao.CriarQuery;

  FNFLista := TObjectList<TNFModel>.Create;

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


    lSQL := lSQL + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by ' + FOrderView;


    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FNFLista.Add(TNFModel.Create);

      i := FNFLista.Count -1;
      FNFLista[i].NUMERO_NF                   := lQry.FieldByName('NUMERO_NF').AsString;
      FNFLista[i].NUMERO_ECF                  := lQry.FieldByName('NUMERO_ECF').AsString;
      FNFLista[i].NUMERO_PED                  := lQry.FieldByName('NUMERO_PED').AsString;
      FNFLista[i].SERIE_NF                    := lQry.FieldByName('SERIE_NF').AsString;
      FNFLista[i].MODELO                      := lQry.FieldByName('MODELO').AsString;
      FNFLista[i].CODIGO_CLI                  := lQry.FieldByName('CODIGO_CLI').AsString;
      FNFLista[i].DATA_NF                     := lQry.FieldByName('DATA_NF').AsString;
      FNFLista[i].DATA_SAIDA                  := lQry.FieldByName('DATA_SAIDA').AsString;
      FNFLista[i].CLIENTE_NF                  := lQry.FieldByName('cliente_nome_cliente').AsString;
      FNFLista[i].NOME_XML                    := lQry.FieldByName('NOME_XML').AsString;

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
    lQry := xConexao.CriarQuery;

    lSql := '  select count(*) records                                      '+#13+
            '    From NF                                                    '+#13+
            '    left join clientes on clientes.codigo_cli = NF.codigo_cli  '+#13+
            '   where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TNFDao.montaCondicaoQuery: String;
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

procedure TNFDao.SetNFLista(const Value: TObjectList<TNFModel>);
begin
  FNFLista := Value;
end;

procedure TNFDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TNFDao.setParams(var pQry: TFDQuery; pNFModel: TNFModel);
begin
  pQry.ParamByName('serie_nf').Value                     := IIF(pNFModel.SERIE_NF                      = '', Unassigned, pNFModel.SERIE_NF);
  pQry.ParamByName('codigo_cli').Value                   := IIF(pNFModel.CODIGO_CLI                    = '', Unassigned, pNFModel.CODIGO_CLI);
  pQry.ParamByName('codigo_ven').Value                   := IIF(pNFModel.CODIGO_VEN                    = '', Unassigned, pNFModel.CODIGO_VEN);
  pQry.ParamByName('codigo_port').Value                  := IIF(pNFModel.CODIGO_PORT                   = '', Unassigned, pNFModel.CODIGO_PORT);
  pQry.ParamByName('codigo_tip').Value                   := IIF(pNFModel.CODIGO_TIP                    = '', Unassigned, pNFModel.CODIGO_TIP);
  pQry.ParamByName('data_nf').Value                      := IIF(pNFModel.DATA_NF                       = '', Unassigned, transformaDataFireBird(pNFModel.DATA_NF));
  pQry.ParamByName('valor_nf').Value                     := IIF(pNFModel.VALOR_NF                      = '', Unassigned, FormataFloatFireBird(pNFModel.VALOR_NF));
  pQry.ParamByName('desc_nf').Value                      := IIF(pNFModel.DESC_NF                       = '', Unassigned, FormataFloatFireBird(pNFModel.DESC_NF));
  pQry.ParamByName('acres_nf').Value                     := IIF(pNFModel.ACRES_NF                      = '', Unassigned, FormataFloatFireBird(pNFModel.ACRES_NF));
  pQry.ParamByName('total_nf').Value                     := IIF(pNFModel.TOTAL_NF                      = '', Unassigned, FormataFloatFireBird(pNFModel.TOTAL_NF));
  pQry.ParamByName('bicms_nf').Value                     := IIF(pNFModel.BICMS_NF                      = '', Unassigned, FormataFloatFireBird(pNFModel.BICMS_NF));
  pQry.ParamByName('vicms_nf').Value                     := IIF(pNFModel.VICMS_NF                      = '', Unassigned, FormataFloatFireBird(pNFModel.VICMS_NF));
  pQry.ParamByName('icms_nf').Value                      := IIF(pNFModel.ICMS_NF                       = '', Unassigned, FormataFloatFireBird(pNFModel.ICMS_NF));
  pQry.ParamByName('usuario_nf').Value                   := IIF(pNFModel.USUARIO_NF                    = '', Unassigned, pNFModel.USUARIO_NF);
  pQry.ParamByName('numero_ped').Value                   := IIF(pNFModel.NUMERO_PED                    = '', Unassigned, pNFModel.NUMERO_PED);
  pQry.ParamByName('tipo_nf').Value                      := IIF(pNFModel.TIPO_NF                       = '', Unassigned, pNFModel.TIPO_NF);
  pQry.ParamByName('status_nf').Value                    := IIF(pNFModel.STATUS_NF                     = '', Unassigned, pNFModel.STATUS_NF);
  pQry.ParamByName('desconto_nf').Value                  := IIF(pNFModel.DESCONTO_NF                   = '', Unassigned, FormataFloatFireBird(pNFModel.DESCONTO_NF));
  pQry.ParamByName('cfop_nf').Value                      := IIF(pNFModel.CFOP_NF                       = '', Unassigned, pNFModel.CFOP_NF);
  pQry.ParamByName('fisco_nf').Value                     := IIF(pNFModel.FISCO_NF                      = '', Unassigned, pNFModel.FISCO_NF);
  pQry.ParamByName('obs_nf').Value                       := IIF(pNFModel.OBS_NF                        = '', Unassigned, pNFModel.OBS_NF);
  pQry.ParamByName('data_cancelamento').Value            := IIF(pNFModel.DATA_CANCELAMENTO             = '', Unassigned, transformaDataFireBird(pNFModel.DATA_CANCELAMENTO));
  pQry.ParamByName('peso_liquido').Value                 := IIF(pNFModel.PESO_LIQUIDO                  = '', Unassigned, FormataFloatFireBird(pNFModel.PESO_LIQUIDO));
  pQry.ParamByName('peso_bruto').Value                   := IIF(pNFModel.PESO_BRUTO                    = '', Unassigned, FormataFloatFireBird(pNFModel.PESO_BRUTO));
  pQry.ParamByName('valor_extenso').Value                := IIF(pNFModel.VALOR_EXTENSO                 = '', Unassigned, pNFModel.VALOR_EXTENSO);
  pQry.ParamByName('qtde_volume').Value                  := IIF(pNFModel.QTDE_VOLUME                   = '', Unassigned, pNFModel.QTDE_VOLUME);
  pQry.ParamByName('especie_volume').Value               := IIF(pNFModel.ESPECIE_VOLUME                = '', Unassigned, pNFModel.ESPECIE_VOLUME);
  pQry.ParamByName('transportadora').Value               := IIF(pNFModel.TRANSPORTADORA                = '', Unassigned, pNFModel.TRANSPORTADORA);
  pQry.ParamByName('data_saida').Value                   := IIF(pNFModel.DATA_SAIDA                    = '', Unassigned, transformaDataFireBird(pNFModel.DATA_SAIDA));
  pQry.ParamByName('frete').Value                        := IIF(pNFModel.FRETE                         = '', Unassigned, FormataFloatFireBird(pNFModel.FRETE));
  pQry.ParamByName('condicoes_pagto').Value              := IIF(pNFModel.CONDICOES_PAGTO               = '', Unassigned, pNFModel.CONDICOES_PAGTO);
  pQry.ParamByName('loja').Value                         := IIF(pNFModel.LOJA                          = '', Unassigned, pNFModel.LOJA);
  pQry.ParamByName('isenta_nf').Value                    := IIF(pNFModel.ISENTA_NF                     = '', Unassigned, FormataFloatFireBird(pNFModel.ISENTA_NF));
  pQry.ParamByName('outros_nf').Value                    := IIF(pNFModel.OUTROS_NF                     = '', Unassigned, FormataFloatFireBird(pNFModel.OUTROS_NF));
  pQry.ParamByName('base_st_nf').Value                   := IIF(pNFModel.BASE_ST_NF                    = '', Unassigned, FormataFloatFireBird(pNFModel.BASE_ST_NF));
  pQry.ParamByName('icms_st').Value                      := IIF(pNFModel.ICMS_ST                       = '', Unassigned, FormataFloatFireBird(pNFModel.ICMS_ST));
  pQry.ParamByName('ipi_nf').Value                       := IIF(pNFModel.IPI_NF                        = '', Unassigned, FormataFloatFireBird(pNFModel.IPI_NF));
  pQry.ParamByName('id_nf3').Value                       := IIF(pNFModel.ID_NF3                        = '', Unassigned, pNFModel.ID_NF3);
  pQry.ParamByName('recibo_nfe').Value                   := IIF(pNFModel.RECIBO_NFE                    = '', Unassigned, pNFModel.RECIBO_NFE);
  pQry.ParamByName('protocolo_nfe').Value                := IIF(pNFModel.PROTOCOLO_NFE                 = '', Unassigned, pNFModel.PROTOCOLO_NFE);
  pQry.ParamByName('nfe').Value                          := IIF(pNFModel.NFE                           = '', Unassigned, pNFModel.NFE);
  pQry.ParamByName('autorizada').Value                   := IIF(pNFModel.AUTORIZADA                    = '', Unassigned, pNFModel.AUTORIZADA);
  pQry.ParamByName('modelo').Value                       := IIF(pNFModel.MODELO                        = '', Unassigned, pNFModel.MODELO);
  pQry.ParamByName('vlrentrada_nf').Value                := IIF(pNFModel.VLRENTRADA_NF                 = '', Unassigned, FormataFloatFireBird(pNFModel.VLRENTRADA_NF));
  pQry.ParamByName('qtparcelas').Value                   := IIF(pNFModel.QTPARCELAS                    = '', Unassigned, pNFModel.QTPARCELAS);
  pQry.ParamByName('numero_serie_ecf').Value             := IIF(pNFModel.NUMERO_SERIE_ECF              = '', Unassigned, pNFModel.NUMERO_SERIE_ECF);
  pQry.ParamByName('ccf_cupom').Value                    := IIF(pNFModel.CCF_CUPOM                     = '', Unassigned, pNFModel.CCF_CUPOM);
  pQry.ParamByName('email_nfe').Value                    := IIF(pNFModel.EMAIL_NFE                     = '', Unassigned, pNFModel.EMAIL_NFE);
  pQry.ParamByName('nome_xml').Value                     := IIF(pNFModel.NOME_XML                      = '', Unassigned, pNFModel.NOME_XML);
  pQry.ParamByName('status').Value                       := IIF(pNFModel.STATUS                        = '', Unassigned, pNFModel.STATUS);
  pQry.ParamByName('pcte').Value                         := IIF(pNFModel.PCTE                          = '', Unassigned, pNFModel.PCTE);
  pQry.ParamByName('hem').Value                          := IIF(pNFModel.HEM                           = '', Unassigned, pNFModel.HEM);
  pQry.ParamByName('dr').Value                           := IIF(pNFModel.DR                            = '', Unassigned, pNFModel.DR);
  pQry.ParamByName('aih').Value                          := IIF(pNFModel.AIH                           = '', Unassigned, pNFModel.AIH);
  pQry.ParamByName('vend').Value                         := IIF(pNFModel.VEND                          = '', Unassigned, pNFModel.VEND);
  pQry.ParamByName('conv').Value                         := IIF(pNFModel.CONV                          = '', Unassigned, pNFModel.CONV);
  pQry.ParamByName('id_info_complementar').Value         := IIF(pNFModel.ID_INFO_COMPLEMENTAR          = '', Unassigned, pNFModel.ID_INFO_COMPLEMENTAR);
  pQry.ParamByName('tipo_frete').Value                   := IIF(pNFModel.TIPO_FRETE                    = '', Unassigned, pNFModel.TIPO_FRETE);
  pQry.ParamByName('transportadora_id').Value            := IIF(pNFModel.TRANSPORTADORA_ID             = '', Unassigned, pNFModel.TRANSPORTADORA_ID);
  pQry.ParamByName('vcredicmssn').Value                  := IIF(pNFModel.VCREDICMSSN                   = '', Unassigned, pNFModel.VCREDICMSSN);
  pQry.ParamByName('vpis').Value                         := IIF(pNFModel.VPIS                          = '', Unassigned, FormataFloatFireBird(pNFModel.VPIS));
  pQry.ParamByName('vcofins').Value                      := IIF(pNFModel.VCOFINS                       = '', Unassigned, FormataFloatFireBird(pNFModel.VCOFINS));
  pQry.ParamByName('id').Value                           := IIF(pNFModel.ID                            = '', Unassigned, pNFModel.ID);
  pQry.ParamByName('vtottrib').Value                     := IIF(pNFModel.VTOTTRIB                      = '', Unassigned, FormataFloatFireBird(pNFModel.VTOTTRIB));
  pQry.ParamByName('obs_fiscal').Value                   := IIF(pNFModel.OBS_FISCAL                    = '', Unassigned, pNFModel.OBS_FISCAL);
  pQry.ParamByName('info_complementar').Value            := IIF(pNFModel.INFO_COMPLEMENTAR             = '', Unassigned, pNFModel.INFO_COMPLEMENTAR);
  pQry.ParamByName('cfop_id').Value                      := IIF(pNFModel.CFOP_ID                       = '', Unassigned, pNFModel.CFOP_ID);
  pQry.ParamByName('uf_embarque').Value                  := IIF(pNFModel.UF_EMBARQUE                   = '', Unassigned, pNFModel.UF_EMBARQUE);
  pQry.ParamByName('local_embarque').Value               := IIF(pNFModel.LOCAL_EMBARQUE                = '', Unassigned, pNFModel.LOCAL_EMBARQUE);
  pQry.ParamByName('vseg').Value                         := IIF(pNFModel.VSEG                          = '', Unassigned, FormataFloatFireBird(pNFModel.VSEG));
  pQry.ParamByName('vii').Value                          := IIF(pNFModel.VII                           = '', Unassigned, FormataFloatFireBird(pNFModel.VII));
  pQry.ParamByName('valor_suframa').Value                := IIF(pNFModel.VALOR_SUFRAMA                 = '', Unassigned, FormataFloatFireBird(pNFModel.VALOR_SUFRAMA));
  pQry.ParamByName('xml_nfe').Value                      := IIF(pNFModel.XML_NFE                       = '', Unassigned, pNFModel.XML_NFE);
  pQry.ParamByName('status_transmissao').Value           := IIF(pNFModel.STATUS_TRANSMISSAO            = '', Unassigned, pNFModel.STATUS_TRANSMISSAO);
  pQry.ParamByName('hora_saida').Value                   := IIF(pNFModel.HORA_SAIDA                    = '', Unassigned, pNFModel.HORA_SAIDA);
  pQry.ParamByName('vtottrib_federal').Value             := IIF(pNFModel.VTOTTRIB_FEDERAL              = '', Unassigned, FormataFloatFireBird(pNFModel.VTOTTRIB_FEDERAL));
  pQry.ParamByName('vtottrib_estadual').Value            := IIF(pNFModel.VTOTTRIB_ESTADUAL             = '', Unassigned, FormataFloatFireBird(pNFModel.VTOTTRIB_ESTADUAL));
  pQry.ParamByName('vtottrib_municipal').Value           := IIF(pNFModel.VTOTTRIB_MUNICIPAL            = '', Unassigned, FormataFloatFireBird(pNFModel.VTOTTRIB_MUNICIPAL));
  pQry.ParamByName('ctr_impressao_nf').Value             := IIF(pNFModel.CTR_IMPRESSAO_NF              = '', Unassigned, pNFModel.CTR_IMPRESSAO_NF);
  pQry.ParamByName('valor_pago').Value                   := IIF(pNFModel.VALOR_PAGO                    = '', Unassigned, FormataFloatFireBird(pNFModel.VALOR_PAGO));
  pQry.ParamByName('xped').Value                         := IIF(pNFModel.XPED                          = '', Unassigned, pNFModel.XPED);
  pQry.ParamByName('cnpj_cpf_consumidor').Value          := IIF(pNFModel.CNPJ_CPF_CONSUMIDOR           = '', Unassigned, pNFModel.CNPJ_CPF_CONSUMIDOR);
  pQry.ParamByName('devolucao_id').Value                 := IIF(pNFModel.DEVOLUCAO_ID                  = '', Unassigned, pNFModel.DEVOLUCAO_ID);
  pQry.ParamByName('pedido_id').Value                    := IIF(pNFModel.PEDIDO_ID                     = '', Unassigned, pNFModel.PEDIDO_ID);
  pQry.ParamByName('os_id').Value                        := IIF(pNFModel.OS_ID                         = '', Unassigned, pNFModel.OS_ID);
  pQry.ParamByName('orcamento_id').Value                 := IIF(pNFModel.ORCAMENTO_ID                  = '', Unassigned, pNFModel.ORCAMENTO_ID);
  pQry.ParamByName('saidas_id').Value                    := IIF(pNFModel.SAIDAS_ID                     = '', Unassigned, pNFModel.SAIDAS_ID);
  pQry.ParamByName('ref_cuf').Value                      := IIF(pNFModel.REF_CUF                       = '', Unassigned, pNFModel.REF_CUF);
  pQry.ParamByName('ref_aamm').Value                     := IIF(pNFModel.REF_AAMM                      = '', Unassigned, pNFModel.REF_AAMM);
  pQry.ParamByName('ref_cnpj').Value                     := IIF(pNFModel.REF_CNPJ                      = '', Unassigned, pNFModel.REF_CNPJ);
  pQry.ParamByName('ref_mod').Value                      := IIF(pNFModel.REF_MOD                       = '', Unassigned, pNFModel.REF_MOD);
  pQry.ParamByName('ref_serie').Value                    := IIF(pNFModel.REF_SERIE                     = '', Unassigned, pNFModel.REF_SERIE);
  pQry.ParamByName('ref_nnf').Value                      := IIF(pNFModel.REF_NNF                       = '', Unassigned, pNFModel.REF_NNF);
  pQry.ParamByName('vfcp').Value                         := IIF(pNFModel.VFCP                          = '', Unassigned, FormataFloatFireBird(pNFModel.VFCP));
  pQry.ParamByName('vfcpst').Value                       := IIF(pNFModel.VFCPST                        = '', Unassigned, FormataFloatFireBird(pNFModel.VFCPST));
  pQry.ParamByName('vfcpstret').Value                    := IIF(pNFModel.VFCPSTRET                     = '', Unassigned, FormataFloatFireBird(pNFModel.VFCPSTRET));
  pQry.ParamByName('vfcpufdest').Value                   := IIF(pNFModel.VFCPUFDEST                    = '', Unassigned, FormataFloatFireBird(pNFModel.VFCPUFDEST));
  pQry.ParamByName('vicmsufdest').Value                  := IIF(pNFModel.VICMSUFDEST                   = '', Unassigned, FormataFloatFireBird(pNFModel.VICMSUFDEST));
  pQry.ParamByName('vicmsufremet').Value                 := IIF(pNFModel.VICMSUFREMET                  = '', Unassigned, FormataFloatFireBird(pNFModel.VICMSUFREMET));
  pQry.ParamByName('indpres').Value                      := IIF(pNFModel.INDPRES                       = '', Unassigned, pNFModel.INDPRES);
  pQry.ParamByName('gnre').Value                         := IIF(pNFModel.GNRE                          = '', Unassigned, pNFModel.GNRE);
  pQry.ParamByName('vdolar').Value                       := IIF(pNFModel.VDOLAR                        = '', Unassigned, FormataFloatFireBird(pNFModel.VDOLAR));
  pQry.ParamByName('numero_processo').Value              := IIF(pNFModel.NUMERO_PROCESSO               = '', Unassigned, pNFModel.NUMERO_PROCESSO);
  pQry.ParamByName('gnre_impresso').Value                := IIF(pNFModel.GNRE_IMPRESSO                 = '', Unassigned, pNFModel.GNRE_IMPRESSO);
  pQry.ParamByName('tra_placa').Value                    := IIF(pNFModel.TRA_PLACA                     = '', Unassigned, pNFModel.TRA_PLACA);
  pQry.ParamByName('tra_rntc').Value                     := IIF(pNFModel.TRA_RNTC                      = '', Unassigned, pNFModel.TRA_RNTC);
  pQry.ParamByName('tra_uf').Value                       := IIF(pNFModel.TRA_UF                        = '', Unassigned, pNFModel.TRA_UF);
  pQry.ParamByName('tra_marca').Value                    := IIF(pNFModel.TRA_MARCA                     = '', Unassigned, pNFModel.TRA_MARCA);
  pQry.ParamByName('tra_numeracao').Value                := IIF(pNFModel.TRA_NUMERACAO                 = '', Unassigned, pNFModel.TRA_NUMERACAO);
  pQry.ParamByName('transportadora_redespacho_id').Value := IIF(pNFModel.TRANSPORTADORA_REDESPACHO_ID  = '', Unassigned, pNFModel.TRANSPORTADORA_REDESPACHO_ID);
  pQry.ParamByName('despesa_importacao').Value           := IIF(pNFModel.DESPESA_IMPORTACAO            = '', Unassigned, pNFModel.DESPESA_IMPORTACAO);
  pQry.ParamByName('data_hora_autorizacao').Value        := IIF(pNFModel.DATA_HORA_AUTORIZACAO         = '', Unassigned, transformaDataHoraFireBird(pNFModel.DATA_HORA_AUTORIZACAO));
  pQry.ParamByName('vipidevol').Value                    := IIF(pNFModel.VIPIDEVOL                     = '', Unassigned, FormataFloatFireBird(pNFModel.VIPIDEVOL));
  pQry.ParamByName('n_serie_sat').Value                  := IIF(pNFModel.N_SERIE_SAT                   = '', Unassigned, pNFModel.N_SERIE_SAT);
  pQry.ParamByName('caixa_sat').Value                    := IIF(pNFModel.CAIXA_SAT                     = '', Unassigned, pNFModel.CAIXA_SAT);
  pQry.ParamByName('agrupamento_fatura').Value           := IIF(pNFModel.AGRUPAMENTO_FATURA            = '', Unassigned, pNFModel.AGRUPAMENTO_FATURA);
  pQry.ParamByName('consignado_id').Value                := IIF(pNFModel.CONSIGNADO_ID                 = '', Unassigned, pNFModel.CONSIGNADO_ID);
  pQry.ParamByName('consignado_status').Value            := IIF(pNFModel.CONSIGNADO_STATUS             = '', Unassigned, pNFModel.CONSIGNADO_STATUS);
  pQry.ParamByName('peso_liquido_new').Value             := IIF(pNFModel.PESO_LIQUIDO_NEW              = '', Unassigned, FormataFloatFireBird(pNFModel.PESO_LIQUIDO_NEW));
  pQry.ParamByName('peso_bruto_new').Value               := IIF(pNFModel.PESO_BRUTO_NEW                = '', Unassigned, FormataFloatFireBird(pNFModel.PESO_BRUTO_NEW));
  pQry.ParamByName('status_pendente').Value              := IIF(pNFModel.STATUS_PENDENTE               = '', Unassigned, pNFModel.STATUS_PENDENTE);
  pQry.ParamByName('cnf').Value                          := IIF(pNFModel.CNF                           = '', Unassigned, pNFModel.CNF);
  pQry.ParamByName('vicmsdeson').Value                   := IIF(pNFModel.VICMSDESON                    = '', Unassigned, FormataFloatFireBird(pNFModel.VICMSDESON));
  pQry.ParamByName('vicmsstret').Value                   := IIF(pNFModel.VICMSSTRET                    = '', Unassigned, FormataFloatFireBird(pNFModel.VICMSSTRET));
  pQry.ParamByName('entrada_id').Value                   := IIF(pNFModel.ENTRADA_ID                    = '', Unassigned, pNFModel.ENTRADA_ID);
  pQry.ParamByName('intermediador_cnpj').Value           := IIF(pNFModel.INTERMEDIADOR_CNPJ            = '', Unassigned, pNFModel.INTERMEDIADOR_CNPJ);
  pQry.ParamByName('intermediador_nome').Value           := IIF(pNFModel.INTERMEDIADOR_NOME            = '', Unassigned, pNFModel.INTERMEDIADOR_NOME);
  pQry.ParamByName('loja_origem').Value                  := IIF(pNFModel.LOJA_ORIGEM                   = '', Unassigned, pNFModel.LOJA_ORIGEM);
  pQry.ParamByName('entrega_endereco').Value             := IIF(pNFModel.ENTREGA_ENDERECO              = '', Unassigned, pNFModel.ENTREGA_ENDERECO);
  pQry.ParamByName('entrega_complemento').Value          := IIF(pNFModel.ENTREGA_COMPLEMENTO           = '', Unassigned, pNFModel.ENTREGA_COMPLEMENTO);
  pQry.ParamByName('entrega_numero').Value               := IIF(pNFModel.ENTREGA_NUMERO                = '', Unassigned, pNFModel.ENTREGA_NUMERO);
  pQry.ParamByName('entrega_bairro').Value               := IIF(pNFModel.ENTREGA_BAIRRO                = '', Unassigned, pNFModel.ENTREGA_BAIRRO);
  pQry.ParamByName('entrega_cidade').Value               := IIF(pNFModel.ENTREGA_CIDADE                = '', Unassigned, pNFModel.ENTREGA_CIDADE);
  pQry.ParamByName('entrega_cep').Value                  := IIF(pNFModel.ENTREGA_CEP                   = '', Unassigned, pNFModel.ENTREGA_CEP);
  pQry.ParamByName('entrega_uf').Value                   := IIF(pNFModel.ENTREGA_UF                    = '', Unassigned, pNFModel.ENTREGA_UF);
  pQry.ParamByName('entrega_cod_municipio').Value        := IIF(pNFModel.ENTREGA_COD_MUNICIPIO         = '', Unassigned, pNFModel.ENTREGA_COD_MUNICIPIO);
  pQry.ParamByName('web_pedido_id').Value                := IIF(pNFModel.WEB_PEDIDO_ID                 = '', Unassigned, pNFModel.WEB_PEDIDO_ID);
  pQry.ParamByName('transferencia_id').Value             := IIF(pNFModel.TRANSFERENCIA_ID              = '', Unassigned, pNFModel.TRANSFERENCIA_ID);

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
