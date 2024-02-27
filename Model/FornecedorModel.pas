unit FornecedorModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TFornecedorModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FFAX_FOR: Variant;
    FMATRIZ_FORNECEDOR_ID: Variant;
    FNASCIMENTO_FOR: Variant;
    FNUMERO_END: Variant;
    FOPERACAOBANCO: Variant;
    FCODIGO_CONTABIL: Variant;
    FUF_FOR: Variant;
    FLIMITE_CREDITO_FOR: Variant;
    FINSCRICAO_RG_FOR: Variant;
    FCODIGO_FOR: Variant;
    FFAVORECIDO_EXTERIOR: Variant;
    FCELULARCONTATO_FOR2: Variant;
    FTIPO_APURACAO: Variant;
    FCONTA_EXTERIOR: Variant;
    FTRANSPORTADORA_ID: Variant;
    FCEP_FOR: Variant;
    FDESCRICAO: Variant;
    FCODIGO_ANTERIOR: Variant;
    FCOMPRA_PRAZO: Variant;
    FPERIODICIDADE: Variant;
    FCREDITO_IMPOSTO: Variant;
    FTIPO_MOVIMENTO: Variant;
    FID: Variant;
    FTELEFONE2_FOR: Variant;
    FMODALIDADECONTA: Variant;
    FTELEFONE_EXTERIOR: Variant;
    FCONTA_FOR: Variant;
    FCELULARCONTATO_FOR: Variant;
    FCONTATO_FOR: Variant;
    FVINCULAR_PRODUTOS_ENTRADA: Variant;
    FSTATUS: Variant;
    FSUFRAMA: Variant;
    FBANCO_EXTERIOR: Variant;
    FLOJA: Variant;
    FCONDICOES_PAG: Variant;
    FFAVORECIDO: Variant;
    FURL_FOR: Variant;
    FSYSTIME: Variant;
    FAGENCIA_FOR: Variant;
    FCOMPLEMENTO: Variant;
    FTIPO_FOR: Variant;
    FCIDADE_FOR: Variant;
    FCOMPRA_MINIMO: Variant;
    FENDERECO_FOR: Variant;
    FRAZAO_FOR: Variant;
    FTELEFONE_FOR: Variant;
    FCONTA_ID: Variant;
    FSWIFT_CODE: Variant;
    FBANCO_FOR: Variant;
    FPAIS: Variant;
    FUSUARIO_ENT: Variant;
    FOBSERVACAO_FOR: Variant;
    FFANTASIA_FOR: Variant;
    FCNPJ_CPF_FOR: Variant;
    FPREVISAO_ENTREGA: Variant;
    FCOD_MUNICIPIO: Variant;
    FEMAIL_FOR: Variant;
    FBAIRRO_FOR: Variant;
    FCNPJCPFRecordView: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetAGENCIA_FOR(const Value: Variant);
    procedure SetBAIRRO_FOR(const Value: Variant);
    procedure SetBANCO_EXTERIOR(const Value: Variant);
    procedure SetBANCO_FOR(const Value: Variant);
    procedure SetCELULARCONTATO_FOR(const Value: Variant);
    procedure SetCELULARCONTATO_FOR2(const Value: Variant);
    procedure SetCEP_FOR(const Value: Variant);
    procedure SetCIDADE_FOR(const Value: Variant);
    procedure SetCNPJ_CPF_FOR(const Value: Variant);
    procedure SetCOD_MUNICIPIO(const Value: Variant);
    procedure SetCODIGO_ANTERIOR(const Value: Variant);
    procedure SetCODIGO_CONTABIL(const Value: Variant);
    procedure SetCODIGO_FOR(const Value: Variant);
    procedure SetCOMPLEMENTO(const Value: Variant);
    procedure SetCOMPRA_MINIMO(const Value: Variant);
    procedure SetCOMPRA_PRAZO(const Value: Variant);
    procedure SetCONDICOES_PAG(const Value: Variant);
    procedure SetCONTA_EXTERIOR(const Value: Variant);
    procedure SetCONTA_FOR(const Value: Variant);
    procedure SetCONTA_ID(const Value: Variant);
    procedure SetCONTATO_FOR(const Value: Variant);
    procedure SetCREDITO_IMPOSTO(const Value: Variant);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetEMAIL_FOR(const Value: Variant);
    procedure SetENDERECO_FOR(const Value: Variant);
    procedure SetFANTASIA_FOR(const Value: Variant);
    procedure SetFAVORECIDO(const Value: Variant);
    procedure SetFAVORECIDO_EXTERIOR(const Value: Variant);
    procedure SetFAX_FOR(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetINSCRICAO_RG_FOR(const Value: Variant);
    procedure SetLIMITE_CREDITO_FOR(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetMATRIZ_FORNECEDOR_ID(const Value: Variant);
    procedure SetMODALIDADECONTA(const Value: Variant);
    procedure SetNASCIMENTO_FOR(const Value: Variant);
    procedure SetNUMERO_END(const Value: Variant);
    procedure SetOBSERVACAO_FOR(const Value: Variant);
    procedure SetOPERACAOBANCO(const Value: Variant);
    procedure SetPAIS(const Value: Variant);
    procedure SetPERIODICIDADE(const Value: Variant);
    procedure SetPREVISAO_ENTREGA(const Value: Variant);
    procedure SetRAZAO_FOR(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSUFRAMA(const Value: Variant);
    procedure SetSWIFT_CODE(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTELEFONE_EXTERIOR(const Value: Variant);
    procedure SetTELEFONE_FOR(const Value: Variant);
    procedure SetTELEFONE2_FOR(const Value: Variant);
    procedure SetTIPO_APURACAO(const Value: Variant);
    procedure SetTIPO_FOR(const Value: Variant);
    procedure SetTIPO_MOVIMENTO(const Value: Variant);
    procedure SetTRANSPORTADORA_ID(const Value: Variant);
    procedure SetUF_FOR(const Value: Variant);
    procedure SetURL_FOR(const Value: Variant);
    procedure SetUSUARIO_ENT(const Value: Variant);
    procedure SetVINCULAR_PRODUTOS_ENTRADA(const Value: Variant);
    procedure SetCNPJCPFRecordView(const Value: Variant);

  public

    property CODIGO_FOR                 :Variant read FCODIGO_FOR write SetCODIGO_FOR;
    property ENDERECO_FOR               :Variant read FENDERECO_FOR write SetENDERECO_FOR;
    property BAIRRO_FOR                 :Variant read FBAIRRO_FOR write SetBAIRRO_FOR;
    property CIDADE_FOR                 :Variant read FCIDADE_FOR write SetCIDADE_FOR;
    property UF_FOR                     :Variant read FUF_FOR write SetUF_FOR;
    property TELEFONE_FOR               :Variant read FTELEFONE_FOR write SetTELEFONE_FOR;
    property TELEFONE2_FOR              :Variant read FTELEFONE2_FOR write SetTELEFONE2_FOR;
    property FAX_FOR                    :Variant read FFAX_FOR write SetFAX_FOR;
    property CONTATO_FOR                :Variant read FCONTATO_FOR write SetCONTATO_FOR;
    property CELULARCONTATO_FOR         :Variant read FCELULARCONTATO_FOR write SetCELULARCONTATO_FOR;
    property EMAIL_FOR                  :Variant read FEMAIL_FOR write SetEMAIL_FOR;
    property URL_FOR                    :Variant read FURL_FOR write SetURL_FOR;
    property CEP_FOR                    :Variant read FCEP_FOR write SetCEP_FOR;
    property CNPJ_CPF_FOR               :Variant read FCNPJ_CPF_FOR write SetCNPJ_CPF_FOR;
    property INSCRICAO_RG_FOR           :Variant read FINSCRICAO_RG_FOR write SetINSCRICAO_RG_FOR;
    property FANTASIA_FOR               :Variant read FFANTASIA_FOR write SetFANTASIA_FOR;
    property RAZAO_FOR                  :Variant read FRAZAO_FOR write SetRAZAO_FOR;
    property BANCO_FOR                  :Variant read FBANCO_FOR write SetBANCO_FOR;
    property AGENCIA_FOR                :Variant read FAGENCIA_FOR write SetAGENCIA_FOR;
    property CONTA_FOR                  :Variant read FCONTA_FOR write SetCONTA_FOR;
    property OBSERVACAO_FOR             :Variant read FOBSERVACAO_FOR write SetOBSERVACAO_FOR;
    property LIMITE_CREDITO_FOR         :Variant read FLIMITE_CREDITO_FOR write SetLIMITE_CREDITO_FOR;
    property TIPO_FOR                   :Variant read FTIPO_FOR write SetTIPO_FOR;
    property USUARIO_ENT                :Variant read FUSUARIO_ENT write SetUSUARIO_ENT;
    property LOJA                       :Variant read FLOJA write SetLOJA;
    property DESCRICAO                  :Variant read FDESCRICAO write SetDESCRICAO;
    property FAVORECIDO                 :Variant read FFAVORECIDO write SetFAVORECIDO;
    property COD_MUNICIPIO              :Variant read FCOD_MUNICIPIO write SetCOD_MUNICIPIO;
    property TELEFONE_EXTERIOR          :Variant read FTELEFONE_EXTERIOR write SetTELEFONE_EXTERIOR;
    property PAIS                       :Variant read FPAIS write SetPAIS;
    property BANCO_EXTERIOR             :Variant read FBANCO_EXTERIOR write SetBANCO_EXTERIOR;
    property SWIFT_CODE                 :Variant read FSWIFT_CODE write SetSWIFT_CODE;
    property CONTA_EXTERIOR             :Variant read FCONTA_EXTERIOR write SetCONTA_EXTERIOR;
    property FAVORECIDO_EXTERIOR        :Variant read FFAVORECIDO_EXTERIOR write SetFAVORECIDO_EXTERIOR;
    property MODALIDADECONTA            :Variant read FMODALIDADECONTA write SetMODALIDADECONTA;
    property OPERACAOBANCO              :Variant read FOPERACAOBANCO write SetOPERACAOBANCO;
    property CELULARCONTATO_FOR2        :Variant read FCELULARCONTATO_FOR2 write SetCELULARCONTATO_FOR2;
    property ID                         :Variant read FID write SetID;
    property SUFRAMA                    :Variant read FSUFRAMA write SetSUFRAMA;
    property NUMERO_END                 :Variant read FNUMERO_END write SetNUMERO_END;
    property COMPLEMENTO                :Variant read FCOMPLEMENTO write SetCOMPLEMENTO;
    property CONDICOES_PAG              :Variant read FCONDICOES_PAG write SetCONDICOES_PAG;
    property STATUS                     :Variant read FSTATUS write SetSTATUS;
    property TRANSPORTADORA_ID          :Variant read FTRANSPORTADORA_ID write SetTRANSPORTADORA_ID;
    property TIPO_MOVIMENTO             :Variant read FTIPO_MOVIMENTO write SetTIPO_MOVIMENTO;
    property TIPO_APURACAO              :Variant read FTIPO_APURACAO write SetTIPO_APURACAO;
    property CREDITO_IMPOSTO            :Variant read FCREDITO_IMPOSTO write SetCREDITO_IMPOSTO;
    property COMPRA_PRAZO               :Variant read FCOMPRA_PRAZO write SetCOMPRA_PRAZO;
    property COMPRA_MINIMO              :Variant read FCOMPRA_MINIMO write SetCOMPRA_MINIMO;
    property CONTA_ID                   :Variant read FCONTA_ID write SetCONTA_ID;
    property CODIGO_CONTABIL            :Variant read FCODIGO_CONTABIL write SetCODIGO_CONTABIL;
    property NASCIMENTO_FOR             :Variant read FNASCIMENTO_FOR write SetNASCIMENTO_FOR;
    property PERIODICIDADE              :Variant read FPERIODICIDADE write SetPERIODICIDADE;
    property PREVISAO_ENTREGA           :Variant read FPREVISAO_ENTREGA write SetPREVISAO_ENTREGA;
    property MATRIZ_FORNECEDOR_ID       :Variant read FMATRIZ_FORNECEDOR_ID write SetMATRIZ_FORNECEDOR_ID;
    property VINCULAR_PRODUTOS_ENTRADA  :Variant read FVINCULAR_PRODUTOS_ENTRADA write SetVINCULAR_PRODUTOS_ENTRADA;
    property CODIGO_ANTERIOR            :Variant read FCODIGO_ANTERIOR write SetCODIGO_ANTERIOR;
    property SYSTIME                    :Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TFornecedorModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TFornecedorModel;
    function obterLista: TFDMemTable;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property CNPJCPFRecordView :Variant read FCNPJCPFRecordView write SetCNPJCPFRecordView;

  end;

implementation

uses
  FornecedorDao,  
  System.Classes, 
  System.SysUtils;

{ TFornecedorModel }

function TFornecedorModel.Alterar(pID: String): TFornecedorModel;
var
  lFornecedorModel : TFornecedorModel;
begin
  lFornecedorModel := TFornecedorModel.Create(vIConexao);
  try
    lFornecedorModel       := lFornecedorModel.carregaClasse(pID);
    lFornecedorModel.Acao  := tacAlterar;
    Result                 := lFornecedorModel;
  finally
  end;
end;

function TFornecedorModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TFornecedorModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TFornecedorModel.carregaClasse(pId : String): TFornecedorModel;
var
  lFornecedorDao: TFornecedorDao;
begin
  lFornecedorDao := TFornecedorDao.Create(vIConexao);

  try
    Result := lFornecedorDao.carregaClasse(pId);
  finally
    lFornecedorDao.Free;
  end;
end;

constructor TFornecedorModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFornecedorModel.Destroy;
begin
  inherited;
end;

function TFornecedorModel.obterLista: TFDMemTable;
var
  lFornecedorLista: TFornecedorDao;
begin
  lFornecedorLista := TFornecedorDao.Create(vIConexao);

  try
    lFornecedorLista.TotalRecords       := FTotalRecords;
    lFornecedorLista.WhereView          := FWhereView;
    lFornecedorLista.CountView          := FCountView;
    lFornecedorLista.OrderView          := FOrderView;
    lFornecedorLista.StartRecordView    := FStartRecordView;
    lFornecedorLista.LengthPageView     := FLengthPageView;
    lFornecedorLista.IDRecordView       := FIDRecordView;
    lFornecedorLista.CNPJCPFRecordView  := CNPJCPFRecordView;

    Result := lFornecedorLista.obterLista;

    FTotalRecords := lFornecedorLista.TotalRecords;

  finally
    lFornecedorLista.Free;
  end;
end;

function TFornecedorModel.Salvar: String;
var
  lFornecedorDao: TFornecedorDao;
begin
  lFornecedorDao := TFornecedorDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lFornecedorDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lFornecedorDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lFornecedorDao.excluir(Self);
    end;
  finally
    lFornecedorDao.Free;
  end;
end;

procedure TFornecedorModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TFornecedorModel.SetAGENCIA_FOR(const Value: Variant);
begin
  FAGENCIA_FOR := Value;
end;

procedure TFornecedorModel.SetBAIRRO_FOR(const Value: Variant);
begin
  FBAIRRO_FOR := Value;
end;

procedure TFornecedorModel.SetBANCO_EXTERIOR(const Value: Variant);
begin
  FBANCO_EXTERIOR := Value;
end;

procedure TFornecedorModel.SetBANCO_FOR(const Value: Variant);
begin
  FBANCO_FOR := Value;
end;

procedure TFornecedorModel.SetCELULARCONTATO_FOR(const Value: Variant);
begin
  FCELULARCONTATO_FOR := Value;
end;

procedure TFornecedorModel.SetCELULARCONTATO_FOR2(const Value: Variant);
begin
  FCELULARCONTATO_FOR2 := Value;
end;

procedure TFornecedorModel.SetCEP_FOR(const Value: Variant);
begin
  FCEP_FOR := Value;
end;

procedure TFornecedorModel.SetCIDADE_FOR(const Value: Variant);
begin
  FCIDADE_FOR := Value;
end;

procedure TFornecedorModel.SetCNPJCPFRecordView(const Value: Variant);
begin
  FCNPJCPFRecordView := Value;
end;

procedure TFornecedorModel.SetCNPJ_CPF_FOR(const Value: Variant);
begin
  FCNPJ_CPF_FOR := Value;
end;

procedure TFornecedorModel.SetCODIGO_ANTERIOR(const Value: Variant);
begin
  FCODIGO_ANTERIOR := Value;
end;

procedure TFornecedorModel.SetCODIGO_CONTABIL(const Value: Variant);
begin
  FCODIGO_CONTABIL := Value;
end;

procedure TFornecedorModel.SetCODIGO_FOR(const Value: Variant);
begin
  FCODIGO_FOR := Value;
end;

procedure TFornecedorModel.SetCOD_MUNICIPIO(const Value: Variant);
begin
  FCOD_MUNICIPIO := Value;
end;

procedure TFornecedorModel.SetCOMPLEMENTO(const Value: Variant);
begin
  FCOMPLEMENTO := Value;
end;

procedure TFornecedorModel.SetCOMPRA_MINIMO(const Value: Variant);
begin
  FCOMPRA_MINIMO := Value;
end;

procedure TFornecedorModel.SetCOMPRA_PRAZO(const Value: Variant);
begin
  FCOMPRA_PRAZO := Value;
end;

procedure TFornecedorModel.SetCONDICOES_PAG(const Value: Variant);
begin
  FCONDICOES_PAG := Value;
end;

procedure TFornecedorModel.SetCONTATO_FOR(const Value: Variant);
begin
  FCONTATO_FOR := Value;
end;

procedure TFornecedorModel.SetCONTA_EXTERIOR(const Value: Variant);
begin
  FCONTA_EXTERIOR := Value;
end;

procedure TFornecedorModel.SetCONTA_FOR(const Value: Variant);
begin
  FCONTA_FOR := Value;
end;

procedure TFornecedorModel.SetCONTA_ID(const Value: Variant);
begin
  FCONTA_ID := Value;
end;

procedure TFornecedorModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFornecedorModel.SetCREDITO_IMPOSTO(const Value: Variant);
begin
  FCREDITO_IMPOSTO := Value;
end;

procedure TFornecedorModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TFornecedorModel.SetEMAIL_FOR(const Value: Variant);
begin
  FEMAIL_FOR := Value;
end;

procedure TFornecedorModel.SetENDERECO_FOR(const Value: Variant);
begin
  FENDERECO_FOR := Value;
end;

procedure TFornecedorModel.SetFANTASIA_FOR(const Value: Variant);
begin
  FFANTASIA_FOR := Value;
end;

procedure TFornecedorModel.SetFAVORECIDO(const Value: Variant);
begin
  FFAVORECIDO := Value;
end;

procedure TFornecedorModel.SetFAVORECIDO_EXTERIOR(const Value: Variant);
begin
  FFAVORECIDO_EXTERIOR := Value;
end;

procedure TFornecedorModel.SetFAX_FOR(const Value: Variant);
begin
  FFAX_FOR := Value;
end;

procedure TFornecedorModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TFornecedorModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TFornecedorModel.SetINSCRICAO_RG_FOR(const Value: Variant);
begin
  FINSCRICAO_RG_FOR := Value;
end;

procedure TFornecedorModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFornecedorModel.SetLIMITE_CREDITO_FOR(const Value: Variant);
begin
  FLIMITE_CREDITO_FOR := Value;
end;

procedure TFornecedorModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TFornecedorModel.SetMATRIZ_FORNECEDOR_ID(const Value: Variant);
begin
  FMATRIZ_FORNECEDOR_ID := Value;
end;

procedure TFornecedorModel.SetMODALIDADECONTA(const Value: Variant);
begin
  FMODALIDADECONTA := Value;
end;

procedure TFornecedorModel.SetNASCIMENTO_FOR(const Value: Variant);
begin
  FNASCIMENTO_FOR := Value;
end;

procedure TFornecedorModel.SetNUMERO_END(const Value: Variant);
begin
  FNUMERO_END := Value;
end;

procedure TFornecedorModel.SetOBSERVACAO_FOR(const Value: Variant);
begin
  FOBSERVACAO_FOR := Value;
end;

procedure TFornecedorModel.SetOPERACAOBANCO(const Value: Variant);
begin
  FOPERACAOBANCO := Value;
end;

procedure TFornecedorModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TFornecedorModel.SetPAIS(const Value: Variant);
begin
  FPAIS := Value;
end;

procedure TFornecedorModel.SetPERIODICIDADE(const Value: Variant);
begin
  FPERIODICIDADE := Value;
end;

procedure TFornecedorModel.SetPREVISAO_ENTREGA(const Value: Variant);
begin
  FPREVISAO_ENTREGA := Value;
end;

procedure TFornecedorModel.SetRAZAO_FOR(const Value: Variant);
begin
  FRAZAO_FOR := Value;
end;

procedure TFornecedorModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TFornecedorModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TFornecedorModel.SetSUFRAMA(const Value: Variant);
begin
  FSUFRAMA := Value;
end;

procedure TFornecedorModel.SetSWIFT_CODE(const Value: Variant);
begin
  FSWIFT_CODE := Value;
end;

procedure TFornecedorModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TFornecedorModel.SetTELEFONE2_FOR(const Value: Variant);
begin
  FTELEFONE2_FOR := Value;
end;

procedure TFornecedorModel.SetTELEFONE_EXTERIOR(const Value: Variant);
begin
  FTELEFONE_EXTERIOR := Value;
end;

procedure TFornecedorModel.SetTELEFONE_FOR(const Value: Variant);
begin
  FTELEFONE_FOR := Value;
end;

procedure TFornecedorModel.SetTIPO_APURACAO(const Value: Variant);
begin
  FTIPO_APURACAO := Value;
end;

procedure TFornecedorModel.SetTIPO_FOR(const Value: Variant);
begin
  FTIPO_FOR := Value;
end;

procedure TFornecedorModel.SetTIPO_MOVIMENTO(const Value: Variant);
begin
  FTIPO_MOVIMENTO := Value;
end;

procedure TFornecedorModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TFornecedorModel.SetTRANSPORTADORA_ID(const Value: Variant);
begin
  FTRANSPORTADORA_ID := Value;
end;

procedure TFornecedorModel.SetUF_FOR(const Value: Variant);
begin
  FUF_FOR := Value;
end;

procedure TFornecedorModel.SetURL_FOR(const Value: Variant);
begin
  FURL_FOR := Value;
end;

procedure TFornecedorModel.SetUSUARIO_ENT(const Value: Variant);
begin
  FUSUARIO_ENT := Value;
end;

procedure TFornecedorModel.SetVINCULAR_PRODUTOS_ENTRADA(const Value: Variant);
begin
  FVINCULAR_PRODUTOS_ENTRADA := Value;
end;

procedure TFornecedorModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
