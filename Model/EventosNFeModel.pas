unit  EventosNFeModel;

interface

uses
  Terasoft.Types,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TEventosNFeModel = class

  private
    vIConexao : IConexao;
    FAcao: TAcao;
    FRETORNO_SEFAZ: Variant;
    FPROTOCOLO_RETORNO: Variant;
    FFILIAL: Variant;
    FDATAHORA: Variant;
    FCHNFE: Variant;
    FXCONDUSO: Variant;
    FTXT: Variant;
    FXCORRECAO: Variant;
    FID: Variant;
    FTPEVENTO: Variant;
    FSTATUS: Variant;
    FEMPRESA: Variant;
    FDESCEVENTO: Variant;
    FJUSTIFICATIVA: Variant;
    FVEREVENTO: Variant;
    FEVENTO: Variant;
    FXML: Variant;
    FNSEQEVENTO: Variant;
    FID_EVENTO: Variant;
    FID_NFE: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCHNFE(const Value: Variant);
    procedure SetDATAHORA(const Value: Variant);
    procedure SetDESCEVENTO(const Value: Variant);
    procedure SetEMPRESA(const Value: Variant);
    procedure SetEVENTO(const Value: Variant);
    procedure SetFILIAL(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetID_EVENTO(const Value: Variant);
    procedure SetID_NFE(const Value: Variant);
    procedure SetJUSTIFICATIVA(const Value: Variant);
    procedure SetNSEQEVENTO(const Value: Variant);
    procedure SetPROTOCOLO_RETORNO(const Value: Variant);
    procedure SetRETORNO_SEFAZ(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetTPEVENTO(const Value: Variant);
    procedure SetTXT(const Value: Variant);
    procedure SetVEREVENTO(const Value: Variant);
    procedure SetXCONDUSO(const Value: Variant);
    procedure SetXCORRECAO(const Value: Variant);
    procedure SetXML(const Value: Variant);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property    ID                :Variant read FID write SetID;
    property    ID_NFE            :Variant read FID_NFE write SetID_NFE;
    property    DATAHORA          :Variant read FDATAHORA write SetDATAHORA;
    property    EVENTO            :Variant read FEVENTO write SetEVENTO;
    property    ID_EVENTO         :Variant read FID_EVENTO write SetID_EVENTO;
    property    CHNFE             :Variant read FCHNFE write SetCHNFE;
    property    TPEVENTO          :Variant read FTPEVENTO write SetTPEVENTO;
    property    NSEQEVENTO        :Variant read FNSEQEVENTO write SetNSEQEVENTO;
    property    VEREVENTO         :Variant read FVEREVENTO write SetVEREVENTO;
    property    DESCEVENTO        :Variant read FDESCEVENTO write SetDESCEVENTO;
    property    XCORRECAO         :Variant read FXCORRECAO write SetXCORRECAO;
    property    XCONDUSO          :Variant read FXCONDUSO write SetXCONDUSO;
    property    TXT               :Variant read FTXT write SetTXT;
    property    XML               :Variant read FXML write SetXML;
    property    STATUS            :Variant read FSTATUS write SetSTATUS;
    property    PROTOCOLO_RETORNO :Variant read FPROTOCOLO_RETORNO write SetPROTOCOLO_RETORNO;
    property    RETORNO_SEFAZ     :Variant read FRETORNO_SEFAZ write SetRETORNO_SEFAZ;
    property    FILIAL            :Variant read FFILIAL write SetFILIAL;
    property    EMPRESA           :Variant read FEMPRESA write SetEMPRESA;
    property    JUSTIFICATIVA     :Variant read FJUSTIFICATIVA write SetJUSTIFICATIVA;
    property    Acao              :TAcao   read FAcao write SetAcao;

    function Salvar: Boolean;

  end;

implementation

uses EventosNFeDao;

{ TEventosNFe }


constructor TEventosNFeModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TEventosNFeModel.Destroy;
begin

  inherited;
end;

function TEventosNFeModel.Salvar: Boolean;
var
  vEventosNFeDao: TEventosNFeDao;
begin
  Result := False;
  vEventosNFeDao := TEventosNFeDao.Create(vIConexao);

   try

    case FAcao of
      Terasoft.Types.tacIncluir: Result := vEventosNFeDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := vEventosNFeDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := vEventosNFeDao.excluir(Self);
    end;

   finally
     vEventosNFeDao.Free;
   end;

end;

procedure TEventosNFeModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TEventosNFeModel.SetCHNFE(const Value: Variant);
begin
  FCHNFE := Value;
end;

procedure TEventosNFeModel.SetDATAHORA(const Value: Variant);
begin
  FDATAHORA := Value;
end;

procedure TEventosNFeModel.SetDESCEVENTO(const Value: Variant);
begin
  FDESCEVENTO := Value;
end;

procedure TEventosNFeModel.SetEMPRESA(const Value: Variant);
begin
  FEMPRESA := Value;
end;

procedure TEventosNFeModel.SetEVENTO(const Value: Variant);
begin
  FEVENTO := Value;
end;

procedure TEventosNFeModel.SetFILIAL(const Value: Variant);
begin
  FFILIAL := Value;
end;

procedure TEventosNFeModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEventosNFeModel.SetID_EVENTO(const Value: Variant);
begin
  FID_EVENTO := Value;
end;

procedure TEventosNFeModel.SetID_NFE(const Value: Variant);
begin
  FID_NFE := Value;
end;

procedure TEventosNFeModel.SetJUSTIFICATIVA(const Value: Variant);
begin
  FJUSTIFICATIVA := Value;
end;

procedure TEventosNFeModel.SetNSEQEVENTO(const Value: Variant);
begin
  FNSEQEVENTO := Value;
end;

procedure TEventosNFeModel.SetPROTOCOLO_RETORNO(const Value: Variant);
begin
  FPROTOCOLO_RETORNO := Value;
end;

procedure TEventosNFeModel.SetRETORNO_SEFAZ(const Value: Variant);
begin
  FRETORNO_SEFAZ := Value;
end;

procedure TEventosNFeModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TEventosNFeModel.SetTPEVENTO(const Value: Variant);
begin
  FTPEVENTO := Value;
end;

procedure TEventosNFeModel.SetTXT(const Value: Variant);
begin
  FTXT := Value;
end;

procedure TEventosNFeModel.SetVEREVENTO(const Value: Variant);
begin
  FVEREVENTO := Value;
end;

procedure TEventosNFeModel.SetXCONDUSO(const Value: Variant);
begin
  FXCONDUSO := Value;
end;

procedure TEventosNFeModel.SetXCORRECAO(const Value: Variant);
begin
  FXCORRECAO := Value;
end;

procedure TEventosNFeModel.SetXML(const Value: Variant);
begin
  FXML := Value;
end;

end.
