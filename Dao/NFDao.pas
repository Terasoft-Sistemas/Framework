unit NFDao;

interface

uses
  FireDAC.Comp.Client,
  NFModel,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.FuncoesTexto,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TNFDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

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

    function where: String;
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

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function incluir(pNFModel: TNFModel): String;
    function alterar(pNFModel: TNFModel): String;
    function excluir(pNFModel: TNFModel): String;

    function carregaClasse(ID: String): TNFModel;
    procedure obterLista;
    procedure obterListaNFe;

    procedure setParams(var pQry: TFDQuery; pNFModel: TNFModel);

end;

implementation

uses
  System.Rtti;

{ TNFDao }

constructor TNFDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TNFDao.Destroy;
begin
  inherited;

end;

function TNFDao.excluir(pNFModel: TNFModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from NF where NUMERO_NF = :NUMERO_NF',[pNFModel.NUMERO_NF]);
   lQry.ExecSQL;
   Result := pNFModel.NUMERO_NF;

  finally
    lQry.Free;
  end;
end;

function TNFDao.carregaClasse(ID: String): TNFModel;
var
  lQry: TFDQuery;
  ANFModel: TNFModel;
begin
  lQry := vIConexao.CriarQuery;
  ANFModel := TNFModel.Create(vIConexao);
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

function TNFDao.incluir(pNFModel: TNFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('NF', 'NUMERO_NF');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_nf').Value  := vIConexao.Generetor('gen_nf');

    if pNFModel.MODELO = '65' then
      lQry.ParamByName('numero_ecf').Value := vIConexao.Generetor('GEN_NFCe')
    else if pNFModel.MODELO = '55' then
      lQry.ParamByName('numero_ecf').Value := vIConexao.Generetor('GEN_NF2');

    setParams(lQry, pNFModel);

    lQry.Open;

    Result := lQry.FieldByName('NUMERO_NF').AsString;
  finally
    lQry.Free;
  end;
end;

function TNFDao.alterar(pNFModel: TNFModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarUpdate('NF', 'NUMERO_NF');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_nf').Value  :=	pNFModel.NUMERO_NF;
    lQry.ParamByName('numero_ecf').Value :=	pNFModel.NUMERO_ECF;
    setParams(lQry, pNFModel);
    lQry.ExecSQL;

    Result := pNFModel.NUMERO_NF;

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
  lQry := vIConexao.CriarQuery;

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

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by ' + FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FNFLista.Add(TNFModel.Create(vIConexao));

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
  lQry := vIConexao.CriarQuery;

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


    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by ' + FOrderView;


    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FNFLista.Add(TNFModel.Create(vIConexao));

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

procedure TNFDao.SetNFLista(const Value: TObjectList<TNFModel>);
begin
  FNFLista := Value;
end;

procedure TNFDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TNFDao.setParams(var pQry: TFDQuery; pNFModel: TNFModel);
var
  lTabela : TFDMemTable;
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pNFModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pNFModel).AsString))
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
