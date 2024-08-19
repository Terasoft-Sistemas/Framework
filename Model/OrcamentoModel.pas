unit OrcamentoModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  FireDAC.Comp.Client,
  PedidoVendaModel,
  PedidoItensModel,
  OrcamentoItensModel,
  EmpresaModel,
  ProdutosModel,
  Terasoft.Utils;

type
  TOrcamentoModel = class;
  ITOrcamentoModel=IObject<TOrcamentoModel>;

  TOrcamentoModel = class
  private
    [weak] mySelf: ITOrcamentoModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVFCPUFDEST: Variant;
    FBASE_ST: Variant;
    FQTDEPARCELAS_ORC: Variant;
    FVICMSUFREMET: Variant;
    FDATAFECHAMENTO: Variant;
    FSEGURO_ORC: Variant;
    FUF_TRANSPORTADORA: Variant;
    FPRECO_VENDA_ID: Variant;
    FDATA_CANCELAMENTO: Variant;
    FINFORMACOES_ORC: Variant;
    FTOTAL_ORC: Variant;
    FHORA: Variant;
    FNUMERO_SERIE_ECF: Variant;
    FACRES_ORC: Variant;
    FPEDIDO_COMPRA: Variant;
    FNUMERO_ORC: Variant;
    FBASE_IPI: Variant;
    FFATURA_ORC: Variant;
    FENVIADO: Variant;
    FPESO_LIQUIDO: Variant;
    FHORAFECHAMENTO: Variant;
    FTIPO_FRETE: Variant;
    FCONDICAO_ORC: Variant;
    FCODIGO_VEN: Variant;
    FLOCALOBRA: Variant;
    FSITUACAO_ORC: Variant;
    FCONCLUIDO: Variant;
    FVLRPARCELA_ORC: Variant;
    FPREVISAO_EM_DIAS: Variant;
    FPARCELAS_ORC: Variant;
    FVALOR_ST: Variant;
    FCONTATO_ORC: Variant;
    FCODIGO_CLI: Variant;
    FHORAENTREGA: Variant;
    FESPECIE_VOLUME: Variant;
    FID: Variant;
    FCODIGO_PORT: Variant;
    FTRANPORTADORA_ID: Variant;
    FLOJA: Variant;
    FUSUARIO_ORC: Variant;
    FDESC_ORC: Variant;
    FPRODUTO_TIPO_ID: Variant;
    FPESO_BRUTO: Variant;
    FUSUARIO_CONCRETIZADO: Variant;
    FVLRENTRADA_ORC: Variant;
    FSERIE_CF: Variant;
    FSTATUS_ID: Variant;
    FTABJUROS_ORC: Variant;
    FSYSTIME: Variant;
    FDATA_ORC: Variant;
    FRNTRC: Variant;
    FVALOR_IPI: Variant;
    FOBS_GERAL: Variant;
    FDATA_CONCRETIZADO: Variant;
    FPAGAMENTO_STATUS: Variant;
    FNUMERO_CF: Variant;
    FCODIGO_TIP: Variant;
    FOBS_PEDIDO_VINCULADO: Variant;
    FDESCONTO_ORC: Variant;
    FPLACA: Variant;
    FFRETE: Variant;
    FVICMSUFDEST: Variant;
    FQTDE_VOLUME: Variant;
    FVALOR_ORC: Variant;
    FENTREGA_LOCAL: Variant;
    FZERAR_ST: Variant;
    FPRIMEIROVCTO_ORC: Variant;
    FHORA_CONCRETIZADO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetFACRES_ORC(const Value: Variant);
    procedure SetFBASE_IPI(const Value: Variant);
    procedure SetFBASE_ST(const Value: Variant);
    procedure SetFCODIGO_CLI(const Value: Variant);
    procedure SetFCODIGO_PORT(const Value: Variant);
    procedure SetFCODIGO_TIP(const Value: Variant);
    procedure SetFCODIGO_VEN(const Value: Variant);
    procedure SetFCONCLUIDO(const Value: Variant);
    procedure SetFCONDICAO_ORC(const Value: Variant);
    procedure SetFCONTATO_ORC(const Value: Variant);
    procedure SetFDATA_CANCELAMENTO(const Value: Variant);
    procedure SetFDATA_CONCRETIZADO(const Value: Variant);
    procedure SetFDATA_ORC(const Value: Variant);
    procedure SetFDATAFECHAMENTO(const Value: Variant);
    procedure SetFDESC_ORC(const Value: Variant);
    procedure SetFDESCONTO_ORC(const Value: Variant);
    procedure SetFENTREGA_LOCAL(const Value: Variant);
    procedure SetFENVIADO(const Value: Variant);
    procedure SetFESPECIE_VOLUME(const Value: Variant);
    procedure SetFFATURA_ORC(const Value: Variant);
    procedure SetFFRETE(const Value: Variant);
    procedure SetFHORA(const Value: Variant);
    procedure SetFHORA_CONCRETIZADO(const Value: Variant);
    procedure SetFHORAENTREGA(const Value: Variant);
    procedure SetFHORAFECHAMENTO(const Value: Variant);
    procedure SetFID(const Value: Variant);
    procedure SetFINFORMACOES_ORC(const Value: Variant);
    procedure SetFLOCALOBRA(const Value: Variant);
    procedure SetFLOJA(const Value: Variant);
    procedure SetFNUMERO_CF(const Value: Variant);
    procedure SetFNUMERO_ORC(const Value: Variant);
    procedure SetFNUMERO_SERIE_ECF(const Value: Variant);
    procedure SetFOBS_GERAL(const Value: Variant);
    procedure SetFOBS_PEDIDO_VINCULADO(const Value: Variant);
    procedure SetFPAGAMENTO_STATUS(const Value: Variant);
    procedure SetFPARCELAS_ORC(const Value: Variant);
    procedure SetFPEDIDO_COMPRA(const Value: Variant);
    procedure SetFPESO_BRUTO(const Value: Variant);
    procedure SetFPESO_LIQUIDO(const Value: Variant);
    procedure SetFPLACA(const Value: Variant);
    procedure SetFPRECO_VENDA_ID(const Value: Variant);
    procedure SetFPREVISAO_EM_DIAS(const Value: Variant);
    procedure SetFPRIMEIROVCTO_ORC(const Value: Variant);
    procedure SetFPRODUTO_TIPO_ID(const Value: Variant);
    procedure SetFQTDE_VOLUME(const Value: Variant);
    procedure SetFQTDEPARCELAS_ORC(const Value: Variant);
    procedure SetFRNTRC(const Value: Variant);
    procedure SetFSEGURO_ORC(const Value: Variant);
    procedure SetFSERIE_CF(const Value: Variant);
    procedure SetFSITUACAO_ORC(const Value: Variant);
    procedure SetFSTATUS_ID(const Value: Variant);
    procedure SetFSYSTIME(const Value: Variant);
    procedure SetFTABJUROS_ORC(const Value: Variant);
    procedure SetFTIPO_FRETE(const Value: Variant);
    procedure SetFTOTAL_ORC(const Value: Variant);
    procedure SetFTRANPORTADORA_ID(const Value: Variant);
    procedure SetFUF_TRANSPORTADORA(const Value: Variant);
    procedure SetFUSUARIO_CONCRETIZADO(const Value: Variant);
    procedure SetFUSUARIO_ORC(const Value: Variant);
    procedure SetFVALOR_IPI(const Value: Variant);
    procedure SetFVALOR_ORC(const Value: Variant);
    procedure SetFVALOR_ST(const Value: Variant);
    procedure SetFVFCPUFDEST(const Value: Variant);
    procedure SetFVICMSUFDEST(const Value: Variant);
    procedure SetFVICMSUFREMET(const Value: Variant);
    procedure SetFVLRENTRADA_ORC(const Value: Variant);
    procedure SetFVLRPARCELA_ORC(const Value: Variant);
    procedure SetFZERAR_ST(const Value: Variant);

  public

    property  NUMERO_ORC            : Variant read FNUMERO_ORC            write SetFNUMERO_ORC;
    property  CODIGO_CLI            : Variant read FCODIGO_CLI            write SetFCODIGO_CLI;
    property  CODIGO_VEN            : Variant read FCODIGO_VEN            write SetFCODIGO_VEN;
    property  CODIGO_PORT           : Variant read FCODIGO_PORT           write SetFCODIGO_PORT;
    property  DATA_ORC              : Variant read FDATA_ORC              write SetFDATA_ORC;
    property  CONDICAO_ORC          : Variant read FCONDICAO_ORC          write SetFCONDICAO_ORC;
    property  VALOR_ORC             : Variant read FVALOR_ORC             write SetFVALOR_ORC;
    property  DESC_ORC              : Variant read FDESC_ORC              write SetFDESC_ORC;
    property  ACRES_ORC             : Variant read FACRES_ORC             write SetFACRES_ORC;
    property  TOTAL_ORC             : Variant read FTOTAL_ORC             write SetFTOTAL_ORC;
    property  INFORMACOES_ORC       : Variant read FINFORMACOES_ORC       write SetFINFORMACOES_ORC;
    property  USUARIO_ORC           : Variant read FUSUARIO_ORC           write SetFUSUARIO_ORC;
    property  CONTATO_ORC           : Variant read FCONTATO_ORC           write SetFCONTATO_ORC;
    property  CODIGO_TIP            : Variant read FCODIGO_TIP            write SetFCODIGO_TIP;
    property  LOJA                  : Variant read FLOJA                  write SetFLOJA;
    property  NUMERO_CF             : Variant read FNUMERO_CF             write SetFNUMERO_CF;
    property  NUMERO_SERIE_ECF      : Variant read FNUMERO_SERIE_ECF      write SetFNUMERO_SERIE_ECF;
    property  SERIE_CF              : Variant read FSERIE_CF              write SetFSERIE_CF;
    property  VLRENTRADA_ORC        : Variant read FVLRENTRADA_ORC        write SetFVLRENTRADA_ORC;
    property  PRIMEIROVCTO_ORC      : Variant read FPRIMEIROVCTO_ORC      write SetFPRIMEIROVCTO_ORC;
    property  SEGURO_ORC            : Variant read FSEGURO_ORC            write SetFSEGURO_ORC;
    property  FATURA_ORC            : Variant read FFATURA_ORC            write SetFFATURA_ORC;
    property  VLRPARCELA_ORC        : Variant read FVLRPARCELA_ORC        write SetFVLRPARCELA_ORC;
    property  SITUACAO_ORC          : Variant read FSITUACAO_ORC          write SetFSITUACAO_ORC;
    property  QTDEPARCELAS_ORC      : Variant read FQTDEPARCELAS_ORC      write SetFQTDEPARCELAS_ORC;
    property  HORA                  : Variant read FHORA                  write SetFHORA;
    property  DATAFECHAMENTO        : Variant read FDATAFECHAMENTO        write SetFDATAFECHAMENTO;
    property  HORAFECHAMENTO        : Variant read FHORAFECHAMENTO        write SetFHORAFECHAMENTO;
    property  PAGAMENTO_STATUS      : Variant read FPAGAMENTO_STATUS      write SetFPAGAMENTO_STATUS;
    property  ENTREGA_LOCAL         : Variant read FENTREGA_LOCAL         write SetFENTREGA_LOCAL;
    property  OBS_PEDIDO_VINCULADO  : Variant read FOBS_PEDIDO_VINCULADO  write SetFOBS_PEDIDO_VINCULADO;
    property  DATA_CONCRETIZADO     : Variant read FDATA_CONCRETIZADO     write SetFDATA_CONCRETIZADO;
    property  HORA_CONCRETIZADO     : Variant read FHORA_CONCRETIZADO     write SetFHORA_CONCRETIZADO;
    property  DATA_CANCELAMENTO     : Variant read FDATA_CANCELAMENTO     write SetFDATA_CANCELAMENTO;
    property  USUARIO_CONCRETIZADO  : Variant read FUSUARIO_CONCRETIZADO  write SetFUSUARIO_CONCRETIZADO;
    property  VALOR_IPI             : Variant read FVALOR_IPI             write SetFVALOR_IPI;
    property  BASE_IPI              : Variant read FBASE_IPI              write SetFBASE_IPI;
    property  VALOR_ST              : Variant read FVALOR_ST              write SetFVALOR_ST;
    property  BASE_ST               : Variant read FBASE_ST               write SetFBASE_ST;
    property  ID                    : Variant read FID                    write SetFID;
    property  PARCELAS_ORC          : Variant read FPARCELAS_ORC          write SetFPARCELAS_ORC;
    property  FRETE                 : Variant read FFRETE                 write SetFFRETE;
    property  SYSTIME               : Variant read FSYSTIME               write SetFSYSTIME;
    property  TRANPORTADORA_ID      : Variant read FTRANPORTADORA_ID      write SetFTRANPORTADORA_ID;
    property  RNTRC                 : Variant read FRNTRC                 write SetFRNTRC;
    property  PLACA                 : Variant read FPLACA                 write SetFPLACA;
    property  PESO_LIQUIDO          : Variant read FPESO_LIQUIDO          write SetFPESO_LIQUIDO;
    property  PESO_BRUTO            : Variant read FPESO_BRUTO            write SetFPESO_BRUTO;
    property  QTDE_VOLUME           : Variant read FQTDE_VOLUME           write SetFQTDE_VOLUME;
    property  ESPECIE_VOLUME        : Variant read FESPECIE_VOLUME        write SetFESPECIE_VOLUME;
    property  TIPO_FRETE            : Variant read FTIPO_FRETE            write SetFTIPO_FRETE;
    property  UF_TRANSPORTADORA     : Variant read FUF_TRANSPORTADORA     write SetFUF_TRANSPORTADORA;
    property  PRECO_VENDA_ID        : Variant read FPRECO_VENDA_ID        write SetFPRECO_VENDA_ID;
    property  PEDIDO_COMPRA         : Variant read FPEDIDO_COMPRA         write SetFPEDIDO_COMPRA;
    property  TABJUROS_ORC          : Variant read FTABJUROS_ORC          write SetFTABJUROS_ORC;
    property  STATUS_ID             : Variant read FSTATUS_ID             write SetFSTATUS_ID;
    property  DESCONTO_ORC          : Variant read FDESCONTO_ORC          write SetFDESCONTO_ORC;
    property  OBS_GERAL             : Variant read FOBS_GERAL             write SetFOBS_GERAL;
    property  VFCPUFDEST            : Variant read FVFCPUFDEST            write SetFVFCPUFDEST;
    property  VICMSUFDEST           : Variant read FVICMSUFDEST           write SetFVICMSUFDEST;
    property  VICMSUFREMET          : Variant read FVICMSUFREMET          write SetFVICMSUFREMET;
    property  ZERAR_ST              : Variant read FZERAR_ST              write SetFZERAR_ST;
    property  PRODUTO_TIPO_ID       : Variant read FPRODUTO_TIPO_ID       write SetFPRODUTO_TIPO_ID;
    property  PREVISAO_EM_DIAS      : Variant read FPREVISAO_EM_DIAS      write SetFPREVISAO_EM_DIAS;
    property  HORAENTREGA           : Variant read FHORAENTREGA           write SetFHORAENTREGA;
    property  CONCLUIDO             : Variant read FCONCLUIDO             write SetFCONCLUIDO;
    property  ENVIADO               : Variant read FENVIADO               write SetFENVIADO;
    property  LOCALOBRA             : Variant read FLOCALOBRA             write SetFLOCALOBRA;


  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITOrcamentoModel;

    function Incluir: String;
    function Alterar(pID : String): ITOrcamentoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function finalizarOrcamento(pNumeroOrc: String): String;

    function carregaClasse(pId : String): ITOrcamentoModel;

    function ObterLista: IFDDataset; overload;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordview : String read FIDRecordview write SetIDRecordview;

  end;

implementation

uses
  OrcamentoDao,
  System.Classes,
  System.SysUtils,
  Terasoft.FuncoesTexto,
  ClienteModel;

{ TOrcamentoModel }

function TOrcamentoModel.Alterar(pID: String): ITOrcamentoModel;
var
  lOrcamentoModel : ITOrcamentoModel;
begin
  lOrcamentoModel := TOrcamentoModel.getNewIface(vIConexao);
  try
    lOrcamentoModel       := lOrcamentoModel.objeto.carregaClasse(pID);
    lOrcamentoModel.objeto.Acao  := tacAlterar;
    Result                := lOrcamentoModel;
  finally
  end;
end;

function TOrcamentoModel.Excluir(pID: String): String;
begin
  self.NUMERO_ORC := pID;
  self.FAcao      := tacExcluir;
  Result          := self.Salvar;
end;

function TOrcamentoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TOrcamentoModel.carregaClasse(pId : String): ITOrcamentoModel;
var
  lOrcamentoDao: ITOrcamentoDao;
begin
  lOrcamentoDao := TOrcamentoDao.getNewIface(vIConexao);

  try
    Result := lOrcamentoDao.objeto.carregaClasse(pId);
  finally
    lOrcamentoDao:=nil;
  end;
end;

constructor TOrcamentoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TOrcamentoModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TOrcamentoModel.obterLista: IFDDataset;
var
  lOrcamentoLista: ITOrcamentoDao;
begin
  lOrcamentoLista := TOrcamentoDao.getNewIface(vIConexao);

  try
    lOrcamentoLista.objeto.TotalRecords    := FTotalRecords;
    lOrcamentoLista.objeto.WhereView       := FWhereView;
    lOrcamentoLista.objeto.CountView       := FCountView;
    lOrcamentoLista.objeto.OrderView       := FOrderView;
    lOrcamentoLista.objeto.StartRecordView := FStartRecordView;
    lOrcamentoLista.objeto.LengthPageView  := FLengthPageView;
    lOrcamentoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lOrcamentoLista.objeto.obterLista;

    FTotalRecords := lOrcamentoLista.objeto.TotalRecords;

  finally
    lOrcamentoLista:=nil;
  end;
end;

function TOrcamentoModel.Salvar: String;
var
  lOrcamentoDao: ITOrcamentoDao;
begin
  lOrcamentoDao := TOrcamentoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lOrcamentoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lOrcamentoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lOrcamentoDao.objeto.excluir(mySelf);
    end;
  finally
    lOrcamentoDao:=nil;
  end;
end;

function TOrcamentoModel.finalizarOrcamento(pNumeroOrc: String): String;
var
  lPedidoVendaModel        : ITPedidoVendaModel;
  lPedidoItensModel        : ITPedidoItensModel;
  lOrcamentoItensModel     : ITOrcamentoItensModel;
  lOrcamentoModel          : ITOrcamentoModel;
  lClientesModel           : ITClienteModel;
  lEmpresaModel            : ITEmpresaModel;
  lProdutosModel           : ITProdutosModel;
  lPedido                  : String;
  lItem,
  lIndex,
  DiasVencimento           : Integer;
  lSaldoDisponivel         : Double;
  lMemtable, lTableCliente : IFDDataset;
begin

  if pNumeroOrc = '' then
    exit;

  lOrcamentoModel      := TOrcamentoModel.getNewIface(vIConexao);
  lOrcamentoItensModel := TOrcamentoItensModel.getNewIface(vIConexao);
  lPedidoVendaModel    := TPedidoVendaModel.getNewIface(vIConexao);
  lPedidoItensModel    := TPedidoItensModel.getNewIface(vIConexao);
  lClientesModel       := TClienteModel.getNewIface(vIConexao);
  lEmpresaModel        := TEmpresaModel.getNewIface(vIConexao);
  lProdutosModel       := TProdutosModel.getNewIface(vIConexao);

  try

    lPedidoVendaModel.objeto.WhereView := ' AND PEDIDOVENDA.NUMERO_ORC = '+ QuotedStr(pNumeroOrc);
    lPedidoVendaModel.objeto.obterLista;

    if lPedidoVendaModel.objeto.TotalRecords > 0 then begin
      Result := lPedidoVendaModel.objeto.PedidoVendasLista.First.objeto.NUMERO_PED;
      exit;
    end;

    lEmpresaModel.objeto.Carregar;

    if lEmpresaModel.objeto.AVISARNEGATIVO_EMP = 'S' then
    begin
      lOrcamentoItensModel.objeto.WhereView := ' AND I.NUMERO_ORC = '+QuotedStr(pNumeroOrc)+' ';
      lMemtable := lOrcamentoItensModel.objeto.obterLista;

      lMemtable.objeto.First;
      while not lMemtable.objeto.Eof do
      begin
        lProdutosModel.objeto.IDRecordView := lMemtable.objeto.FieldByName('CODIGO_PRO').AsString;
        lProdutosModel.objeto.obterLista;

        lSaldoDisponivel := lProdutosModel.objeto.obterSaldoDisponivel(lMemtable.objeto.FieldByName('CODIGO_PRO').AsString) + lMemtable.objeto.FieldByName('QUANTIDADE_ORC').AsFloat;

        if (lMemtable.objeto.FieldByName('QUANTIDADE_ORC').AsFloat > lSaldoDisponivel) then
          CriaException('Produto '+lMemtable.objeto.FieldByName('CODIGO_PRO').AsString+' sem saldo disponível em estoque.');

        lMemtable.objeto.Next;
      end;
    end;

    lOrcamentoModel := lOrcamentoModel.objeto.carregaClasse(pNumeroOrc);

    if lOrcamentoModel.objeto.VALOR_IPI > 0 then
      CriaException('Orçamento contém valor de IPI.'+#13+'Não é possível finalizar orçamento pelo frente de caixa.');

    lClientesModel.objeto.IDRecordView := lOrcamentoModel.objeto.CODIGO_CLI;
    lTableCliente := lClientesModel.objeto.ObterListaMemTable;

    lPedidoVendaModel.objeto.Acao                 := tacIncluir;
    lPedidoVendaModel.objeto.LOJA                 := lOrcamentoModel.objeto.LOJA;
    lPedidoVendaModel.objeto.DATA_PED             := DateToStr(vIConexao.DataServer);
    lPedidoVendaModel.objeto.HORA_PED             := TimeToStr(vIConexao.HoraServer);

    DiasVencimento := StrToInt(DifDias2(StrToDateTime(lOrcamentoModel.objeto.DATA_ORC), StrToDateTime(lOrcamentoModel.objeto.PRIMEIROVCTO_ORC) ));
    lPedidoVendaModel.objeto.PRIMEIROVENC_PED     := DateToStr(vIConexao.DataServer + DiasVencimento);

    lPedidoVendaModel.objeto.ACRES_PED            := lOrcamentoModel.objeto.ACRES_ORC;
    lPedidoVendaModel.objeto.DESC_PED             := lOrcamentoModel.objeto.DESCONTO_ORC;
    lPedidoVendaModel.objeto.DESCONTO_PED         := lOrcamentoModel.objeto.DESC_ORC;
    lPedidoVendaModel.objeto.VALOR_PED            := FloatToStr((StrToFloat(lOrcamentoModel.objeto.TOTAL_ORC)+StrToFloat(lOrcamentoModel.objeto.DESCONTO_ORC))-StrToFloat(lOrcamentoModel.objeto.ACRES_ORC));
    lPedidoVendaModel.objeto.TOTAL_PED            := lOrcamentoModel.objeto.TOTAL_ORC;
    lPedidoVendaModel.objeto.VALORENTADA_PED      := lOrcamentoModel.objeto.VLRENTRADA_ORC;
    lPedidoVendaModel.objeto.PARCELAS_PED         := lOrcamentoModel.objeto.PARCELAS_ORC;
    lPedidoVendaModel.objeto.PARCELA_PED          := lOrcamentoModel.objeto.VLRPARCELA_ORC;
    lPedidoVendaModel.objeto.CTR_IMPRESSAO_PED    := '0';
    lPedidoVendaModel.objeto.RESERVADO            := 'N';
    lPedidoVendaModel.objeto.SMS                  := 'N';
    lPedidoVendaModel.objeto.ENTREGA              := 'N';
    lPedidoVendaModel.objeto.STATUS_PED           := 'P';
    lPedidoVendaModel.objeto.STATUS               := 'O';
    lPedidoVendaModel.objeto.TIPO_PED             := 'P';
    lPedidoVendaModel.objeto.TABJUROS_PED         := 'N';
    lPedidoVendaModel.objeto.NUMERO_ORC           := lOrcamentoModel.objeto.NUMERO_ORC;
    lPedidoVendaModel.objeto.CODIGO_CLI           := lOrcamentoModel.objeto.CODIGO_CLI;
    lPedidoVendaModel.objeto.CNPJ_CPF_CONSUMIDOR  := lTableCliente.objeto.fieldByName('CNPJ_CPF_CLI').AsString;
    lPedidoVendaModel.objeto.CODIGO_PORT          := lOrcamentoModel.objeto.CODIGO_PORT;
    lPedidoVendaModel.objeto.CODIGO_VEN           := lOrcamentoModel.objeto.CODIGO_VEN;
    lPedidoVendaModel.objeto.CODIGO_TIP           := lOrcamentoModel.objeto.CODIGO_TIP;
    lPedidoVendaModel.objeto.FRETE_PED            := lOrcamentoModel.objeto.FRETE;
    lPedidoVendaModel.objeto.INFORMACOES_PED      := lOrcamentoModel.objeto.INFORMACOES_ORC;
    lPedidoVendaModel.objeto.PRECO_VENDA_ID       := lOrcamentoModel.objeto.PRECO_VENDA_ID;
    lPedidoVendaModel.objeto.USUARIO_PED          := self.vIConexao.getUSer.ID;
    lPedidoVendaModel.objeto.IDUsuario            := self.vIConexao.getUSer.ID;
    lPedidoVendaModel.objeto.ESPECIE_VOLUME       := lOrcamentoModel.objeto.ESPECIE_VOLUME;
    lPedidoVendaModel.objeto.PESO_BRUTO           := lOrcamentoModel.objeto.PESO_BRUTO;
    lPedidoVendaModel.objeto.PESO_LIQUIDO         := lOrcamentoModel.objeto.PESO_LIQUIDO;
    lPedidoVendaModel.objeto.PLACA                := lOrcamentoModel.objeto.PLACA;
    lPedidoVendaModel.objeto.TIPO_FRETE           := lOrcamentoModel.objeto.TIPO_FRETE;
    lPedidoVendaModel.objeto.UF_TRANSPORTADORA    := lOrcamentoModel.objeto.UF_TRANSPORTADORA;
    lPedidoVendaModel.objeto.RNTRC                := lOrcamentoModel.objeto.RNTRC;
    lPedidoVendaModel.objeto.TELEVENDA_PED        := lOrcamentoModel.objeto.TRANPORTADORA_ID;
    lPedidoVendaModel.objeto.QTDE_VOLUME          := lOrcamentoModel.objeto.QTDE_VOLUME;
    lPedidoVendaModel.objeto.FORM                 := 'PDV';

    lPedido := lPedidoVendaModel.objeto.Salvar;

    lPedidoVendaModel.objeto.NUMERO_PED := lPedido;

    lOrcamentoItensModel.objeto.WhereView := ' AND I.NUMERO_ORC = '+QuotedStr(pNumeroOrc)+' ';
    lMemtable := lOrcamentoItensModel.objeto.obterLista;

    lPedidoItensModel.objeto.PedidoItenssLista := TCollections.createList<ITPedidoItensModel>;

    lItem  := 0;
    lIndex := 0;

    lMemtable.objeto.First;
    while not lMemtable.objeto.Eof do
    begin
      lPedidoItensModel.objeto.PedidoItenssLista.Add(TPedidoItensModel.getNewIface(vIConexao));
      inc(lItem);

      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.NUMERO_PED             := lPedido;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.CODIGO_CLI             := lOrcamentoModel.objeto.CODIGO_CLI;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.LOJA                   := lOrcamentoModel.objeto.LOJA;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.BALANCA                := 'S';
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.QUANTIDADE_PED         := lMemtable.objeto.FieldByName('QUANTIDADE_ORC').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.QUANTIDADE_NEW         := lMemtable.objeto.FieldByName('QUANTIDADE_ORC').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.OBSERVACAO             := copy(lMemtable.objeto.FieldByName('OBSERVACAO').AsString,1,50);
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.OBS_ITEM               := lMemtable.objeto.FieldByName('OBSERVACAO').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.CODIGO_PRO             := lMemtable.objeto.FieldByName('CODIGO_PRO').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.QUANTIDADE_TIPO        := lMemtable.objeto.FieldByName('VLRGARANTIA_ORC').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.DESCONTO_PED           := lMemtable.objeto.FieldByName('DESCONTO_ORC').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VDESC                  := FloatToStr(lMemtable.objeto.FieldByName('DESCONTO_ORC').AsFloat / 100 * (lMemtable.objeto.FieldByName('VALORUNITARIO_ORC').AsFloat * lMemtable.objeto.FieldByName('QUANTIDADE_ORC').AsFloat));
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VALORUNITARIO_PED      := lMemtable.objeto.FieldByName('VALORUNITARIO_ORC').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.ITEM                   := lItem.ToString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VLRVENDA_PRO           := lMemtable.objeto.FieldByName('VALORUNITARIO_ORC').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VALOR_VENDA_CADASTRO   := lMemtable.objeto.FieldByName('VALORUNITARIO_ORC').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.VLRCUSTO_PRO           := lMemtable.objeto.FieldByName('VLRCUSTO_ORC').AsString;
      lPedidoItensModel.objeto.PedidoItenssLista[lIndex].objeto.COMISSAO_PED           := '0';

      inc(lIndex);
      lMemtable.objeto.Next;
    end;

    lPedidoItensModel.objeto.Acao := tacIncluirLote;
    lPedidoItensModel.objeto.Salvar;

    lPedidoVendaModel := lPedidoVendaModel.objeto.carregaClasse(lPedido);
    lPedidoVendaModel.objeto.calcularTotais;

    lPedidoVendaModel.objeto.gerarContasReceberPedido;

    lOrcamentoModel.objeto.FAcao := tacAlterar;
    lOrcamentoModel.objeto.FSITUACAO_ORC := 'A';
    lOrcamentoModel.objeto.Salvar;

    lOrcamentoItensModel.objeto.quantidadeAtendida(pNumeroOrc);

    Result := lPedido;
  finally
    lOrcamentoModel:=nil;
    lPedidoVendaModel:=nil;
    lOrcamentoItensModel:=nil;
    lPedidoItensModel:=nil;
    lClientesModel:=nil;
    lEmpresaModel := nil;
    lProdutosModel:=nil;
  end;
end;

class function TOrcamentoModel.getNewIface(pIConexao: IConexao): ITOrcamentoModel;
begin
  Result := TImplObjetoOwner<TOrcamentoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TOrcamentoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TOrcamentoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TOrcamentoModel.SetFACRES_ORC(const Value: Variant);
begin
  FACRES_ORC := Value;
end;

procedure TOrcamentoModel.SetFBASE_IPI(const Value: Variant);
begin
  FBASE_IPI := Value;
end;

procedure TOrcamentoModel.SetFBASE_ST(const Value: Variant);
begin
  FBASE_ST := Value;
end;

procedure TOrcamentoModel.SetFCODIGO_CLI(const Value: Variant);
begin
  FCODIGO_CLI := Value;
end;

procedure TOrcamentoModel.SetFCODIGO_PORT(const Value: Variant);
begin
  FCODIGO_PORT := Value;
end;

procedure TOrcamentoModel.SetFCODIGO_TIP(const Value: Variant);
begin
  FCODIGO_TIP := Value;
end;

procedure TOrcamentoModel.SetFCODIGO_VEN(const Value: Variant);
begin
  FCODIGO_VEN := Value;
end;

procedure TOrcamentoModel.SetFCONCLUIDO(const Value: Variant);
begin
  FCONCLUIDO := Value;
end;

procedure TOrcamentoModel.SetFCONDICAO_ORC(const Value: Variant);
begin
  FCONDICAO_ORC := Value;
end;

procedure TOrcamentoModel.SetFCONTATO_ORC(const Value: Variant);
begin
  FCONTATO_ORC := Value;
end;

procedure TOrcamentoModel.SetFDATAFECHAMENTO(const Value: Variant);
begin
  FDATAFECHAMENTO := Value;
end;

procedure TOrcamentoModel.SetFDATA_CANCELAMENTO(const Value: Variant);
begin
  FDATA_CANCELAMENTO := Value;
end;

procedure TOrcamentoModel.SetFDATA_CONCRETIZADO(const Value: Variant);
begin
  FDATA_CONCRETIZADO := Value;
end;

procedure TOrcamentoModel.SetFDATA_ORC(const Value: Variant);
begin
  FDATA_ORC := Value;
end;

procedure TOrcamentoModel.SetFDESCONTO_ORC(const Value: Variant);
begin
  FDESCONTO_ORC := Value;
end;

procedure TOrcamentoModel.SetFDESC_ORC(const Value: Variant);
begin
  FDESC_ORC := Value;
end;

procedure TOrcamentoModel.SetFENTREGA_LOCAL(const Value: Variant);
begin
  FENTREGA_LOCAL := Value;
end;

procedure TOrcamentoModel.SetFENVIADO(const Value: Variant);
begin
  FENVIADO := Value;
end;

procedure TOrcamentoModel.SetFESPECIE_VOLUME(const Value: Variant);
begin
  FESPECIE_VOLUME := Value;
end;

procedure TOrcamentoModel.SetFFATURA_ORC(const Value: Variant);
begin
  FFATURA_ORC := Value;
end;

procedure TOrcamentoModel.SetFFRETE(const Value: Variant);
begin
  FFRETE := Value;
end;

procedure TOrcamentoModel.SetFHORA(const Value: Variant);
begin
  FHORA := Value;
end;

procedure TOrcamentoModel.SetFHORAENTREGA(const Value: Variant);
begin
  FHORAENTREGA := Value;
end;

procedure TOrcamentoModel.SetFHORAFECHAMENTO(const Value: Variant);
begin
  FHORAFECHAMENTO := Value;
end;

procedure TOrcamentoModel.SetFHORA_CONCRETIZADO(const Value: Variant);
begin
  FHORA_CONCRETIZADO := Value;
end;

procedure TOrcamentoModel.SetFID(const Value: Variant);
begin
  FID := Value;
end;

procedure TOrcamentoModel.SetFINFORMACOES_ORC(const Value: Variant);
begin
  FINFORMACOES_ORC := Value;
end;

procedure TOrcamentoModel.SetFLOCALOBRA(const Value: Variant);
begin
  FLOCALOBRA := Value;
end;

procedure TOrcamentoModel.SetFLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TOrcamentoModel.SetFNUMERO_CF(const Value: Variant);
begin
  FNUMERO_CF := Value;
end;

procedure TOrcamentoModel.SetFNUMERO_ORC(const Value: Variant);
begin
  FNUMERO_ORC := Value;
end;

procedure TOrcamentoModel.SetFNUMERO_SERIE_ECF(const Value: Variant);
begin
  FNUMERO_SERIE_ECF := Value;
end;

procedure TOrcamentoModel.SetFOBS_GERAL(const Value: Variant);
begin
  FOBS_GERAL := Value;
end;

procedure TOrcamentoModel.SetFOBS_PEDIDO_VINCULADO(const Value: Variant);
begin
  FOBS_PEDIDO_VINCULADO := Value;
end;

procedure TOrcamentoModel.SetFPAGAMENTO_STATUS(const Value: Variant);
begin
  FPAGAMENTO_STATUS := Value;
end;

procedure TOrcamentoModel.SetFPARCELAS_ORC(const Value: Variant);
begin
  FPARCELAS_ORC := Value;
end;

procedure TOrcamentoModel.SetFPEDIDO_COMPRA(const Value: Variant);
begin
  FPEDIDO_COMPRA := Value;
end;

procedure TOrcamentoModel.SetFPESO_BRUTO(const Value: Variant);
begin
  FPESO_BRUTO := Value;
end;

procedure TOrcamentoModel.SetFPESO_LIQUIDO(const Value: Variant);
begin
  FPESO_LIQUIDO := Value;
end;

procedure TOrcamentoModel.SetFPLACA(const Value: Variant);
begin
  FPLACA := Value;
end;

procedure TOrcamentoModel.SetFPRECO_VENDA_ID(const Value: Variant);
begin
  FPRECO_VENDA_ID := Value;
end;

procedure TOrcamentoModel.SetFPREVISAO_EM_DIAS(const Value: Variant);
begin
  FPREVISAO_EM_DIAS := Value;
end;

procedure TOrcamentoModel.SetFPRIMEIROVCTO_ORC(const Value: Variant);
begin
  FPRIMEIROVCTO_ORC := Value;
end;

procedure TOrcamentoModel.SetFPRODUTO_TIPO_ID(const Value: Variant);
begin
  FPRODUTO_TIPO_ID := Value;
end;

procedure TOrcamentoModel.SetFQTDEPARCELAS_ORC(const Value: Variant);
begin
  FQTDEPARCELAS_ORC := Value;
end;

procedure TOrcamentoModel.SetFQTDE_VOLUME(const Value: Variant);
begin
  FQTDE_VOLUME := Value;
end;

procedure TOrcamentoModel.SetFRNTRC(const Value: Variant);
begin
  FRNTRC := Value;
end;

procedure TOrcamentoModel.SetFSEGURO_ORC(const Value: Variant);
begin
  FSEGURO_ORC := Value;
end;

procedure TOrcamentoModel.SetFSERIE_CF(const Value: Variant);
begin
  FSERIE_CF := Value;
end;

procedure TOrcamentoModel.SetFSITUACAO_ORC(const Value: Variant);
begin
  FSITUACAO_ORC := Value;
end;

procedure TOrcamentoModel.SetFSTATUS_ID(const Value: Variant);
begin
  FSTATUS_ID := Value;
end;

procedure TOrcamentoModel.SetFSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TOrcamentoModel.SetFTABJUROS_ORC(const Value: Variant);
begin
  FTABJUROS_ORC := Value;
end;

procedure TOrcamentoModel.SetFTIPO_FRETE(const Value: Variant);
begin
  FTIPO_FRETE := Value;
end;

procedure TOrcamentoModel.SetFTOTAL_ORC(const Value: Variant);
begin
  FTOTAL_ORC := Value;
end;

procedure TOrcamentoModel.SetFTRANPORTADORA_ID(const Value: Variant);
begin
  FTRANPORTADORA_ID := Value;
end;

procedure TOrcamentoModel.SetFUF_TRANSPORTADORA(const Value: Variant);
begin
  FUF_TRANSPORTADORA := Value;
end;

procedure TOrcamentoModel.SetFUSUARIO_CONCRETIZADO(const Value: Variant);
begin
  FUSUARIO_CONCRETIZADO := Value;
end;

procedure TOrcamentoModel.SetFUSUARIO_ORC(const Value: Variant);
begin
  FUSUARIO_ORC := Value;
end;

procedure TOrcamentoModel.SetFVALOR_IPI(const Value: Variant);
begin
  FVALOR_IPI := Value;
end;

procedure TOrcamentoModel.SetFVALOR_ORC(const Value: Variant);
begin
  FVALOR_ORC := Value;
end;

procedure TOrcamentoModel.SetFVALOR_ST(const Value: Variant);
begin
  FVALOR_ST := Value;
end;

procedure TOrcamentoModel.SetFVFCPUFDEST(const Value: Variant);
begin
  FVFCPUFDEST := Value;
end;

procedure TOrcamentoModel.SetFVICMSUFDEST(const Value: Variant);
begin
  FVICMSUFDEST := Value;
end;

procedure TOrcamentoModel.SetFVICMSUFREMET(const Value: Variant);
begin
  FVICMSUFREMET := Value;
end;

procedure TOrcamentoModel.SetFVLRENTRADA_ORC(const Value: Variant);
begin
  FVLRENTRADA_ORC := Value;
end;

procedure TOrcamentoModel.SetFVLRPARCELA_ORC(const Value: Variant);
begin
  FVLRPARCELA_ORC := Value;
end;

procedure TOrcamentoModel.SetFZERAR_ST(const Value: Variant);
begin
  FZERAR_ST := Value;
end;

procedure TOrcamentoModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TOrcamentoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TOrcamentoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TOrcamentoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TOrcamentoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TOrcamentoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
