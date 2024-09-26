unit TransportadoraModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TTransportadoraModel = class;
  ITTransportadoraModel=IObject<TTransportadoraModel>;

  TTransportadoraModel = class
  private
    [unsafe] mySelf:ITTransportadoraModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FRASTREIO: Variant;
    FCEP_TRA: Variant;
    FNUMERO_END: Variant;
    FTELEFONE2_TRA: Variant;
    FCELULARCONTATO_TRA: Variant;
    FCONTATO_TRA: Variant;
    FTIPO_FRETE: Variant;
    FFRENET_COD: Variant;
    FCODIGO_ANTERIOR: Variant;
    FURL_TRA: Variant;
    FCIDADE_TRA: Variant;
    FENDERECO_TRA: Variant;
    FNOME_ECOMMERCE: Variant;
    FRAZAO_TRA: Variant;
    FTELEFONE_TRA: Variant;
    FSTATUS: Variant;
    FSUFRAMA: Variant;
    FSYSTIME: Variant;
    FOBSERVACAO_TRA: Variant;
    FFANTASIA_TRA: Variant;
    FCNPJ_CPF_TRA: Variant;
    FCOMPLEMENTO: Variant;
    FEMAIL_TRA: Variant;
    FBAIRRO_TRA: Variant;
    FFAX_TRA: Variant;
    FPLACA: Variant;
    FUF_TRA: Variant;
    FUSUARIO_ENT: Variant;
    FINSCRICAO_RG_TRA: Variant;
    FCODIGO_TRA: Variant;
    FRNTC: Variant;
    FID: Variant;


    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetBAIRRO_TRA(const Value: Variant);
    procedure SetCELULARCONTATO_TRA(const Value: Variant);
    procedure SetCEP_TRA(const Value: Variant);
    procedure SetCIDADE_TRA(const Value: Variant);
    procedure SetCNPJ_CPF_TRA(const Value: Variant);
    procedure SetCODIGO_ANTERIOR(const Value: Variant);
    procedure SetCODIGO_TRA(const Value: Variant);
    procedure SetCOMPLEMENTO(const Value: Variant);
    procedure SetCONTATO_TRA(const Value: Variant);
    procedure SetEMAIL_TRA(const Value: Variant);
    procedure SetENDERECO_TRA(const Value: Variant);
    procedure SetFANTASIA_TRA(const Value: Variant);
    procedure SetFAX_TRA(const Value: Variant);
    procedure SetFRENET_COD(const Value: Variant);
    procedure SetINSCRICAO_RG_TRA(const Value: Variant);
    procedure SetNOME_ECOMMERCE(const Value: Variant);
    procedure SetNUMERO_END(const Value: Variant);
    procedure SetOBSERVACAO_TRA(const Value: Variant);
    procedure SetPLACA(const Value: Variant);
    procedure SetRASTREIO(const Value: Variant);
    procedure SetRAZAO_TRA(const Value: Variant);
    procedure SetRNTC(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSUFRAMA(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTELEFONE_TRA(const Value: Variant);
    procedure SetTELEFONE2_TRA(const Value: Variant);
    procedure SetTIPO_FRETE(const Value: Variant);
    procedure SetUF_TRA(const Value: Variant);
    procedure SetURL_TRA(const Value: Variant);
    procedure SetUSUARIO_ENT(const Value: Variant);
    procedure SetID(const Value: Variant);

  public

    property CODIGO_TRA          : Variant read FCODIGO_TRA         write SetCODIGO_TRA;
    property ENDERECO_TRA        : Variant read FENDERECO_TRA       write SetENDERECO_TRA;
    property BAIRRO_TRA          : Variant read FBAIRRO_TRA         write SetBAIRRO_TRA;
    property CIDADE_TRA          : Variant read FCIDADE_TRA         write SetCIDADE_TRA;
    property UF_TRA              : Variant read FUF_TRA             write SetUF_TRA;
    property TELEFONE_TRA        : Variant read FTELEFONE_TRA       write SetTELEFONE_TRA;
    property TELEFONE2_TRA       : Variant read FTELEFONE2_TRA      write SetTELEFONE2_TRA;
    property FAX_TRA             : Variant read FFAX_TRA            write SetFAX_TRA;
    property CONTATO_TRA         : Variant read FCONTATO_TRA        write SetCONTATO_TRA;
    property CELULARCONTATO_TRA  : Variant read FCELULARCONTATO_TRA write SetCELULARCONTATO_TRA;
    property EMAIL_TRA           : Variant read FEMAIL_TRA          write SetEMAIL_TRA;
    property URL_TRA             : Variant read FURL_TRA            write SetURL_TRA;
    property CEP_TRA             : Variant read FCEP_TRA            write SetCEP_TRA;
    property CNPJ_CPF_TRA        : Variant read FCNPJ_CPF_TRA       write SetCNPJ_CPF_TRA;
    property INSCRICAO_RG_TRA    : Variant read FINSCRICAO_RG_TRA   write SetINSCRICAO_RG_TRA;
    property FANTASIA_TRA        : Variant read FFANTASIA_TRA       write SetFANTASIA_TRA;
    property RAZAO_TRA           : Variant read FRAZAO_TRA          write SetRAZAO_TRA;
    property OBSERVACAO_TRA      : Variant read FOBSERVACAO_TRA     write SetOBSERVACAO_TRA;
    property USUARIO_ENT         : Variant read FUSUARIO_ENT        write SetUSUARIO_ENT;
    property ID                  : Variant read FID                 write SetID;
    property SUFRAMA             : Variant read FSUFRAMA            write SetSUFRAMA;
    property NUMERO_END          : Variant read FNUMERO_END         write SetNUMERO_END;
    property COMPLEMENTO         : Variant read FCOMPLEMENTO        write SetCOMPLEMENTO;
    property PLACA               : Variant read FPLACA              write SetPLACA;
    property RNTC                : Variant read FRNTC               write SetRNTC;
    property RASTREIO            : Variant read FRASTREIO           write SetRASTREIO;
    property CODIGO_ANTERIOR     : Variant read FCODIGO_ANTERIOR    write SetCODIGO_ANTERIOR;
    property SYSTIME             : Variant read FSYSTIME            write SetSYSTIME;
    property STATUS              : Variant read FSTATUS             write SetSTATUS;
    property NOME_ECOMMERCE      : Variant read FNOME_ECOMMERCE     write SetNOME_ECOMMERCE;
    property FRENET_COD          : Variant read FFRENET_COD         write SetFRENET_COD;
    property TIPO_FRETE          : Variant read FTIPO_FRETE         write SetTIPO_FRETE;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITTransportadoraModel;

    function Incluir: String;
    function Alterar(pID : String): ITTransportadoraModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITTransportadoraModel;

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
  TransportadoraDao,
  System.Classes,
  System.SysUtils;

{ TTransportadoraModel }

function TTransportadoraModel.Alterar(pID: String): ITTransportadoraModel;
var
  lTransportadoraModel : ITTransportadoraModel;
begin
  lTransportadoraModel := TTransportadoraModel.getNewIface(vIConexao);
  try
    lTransportadoraModel       := lTransportadoraModel.objeto.carregaClasse(pID);
    lTransportadoraModel.objeto.Acao  := tacAlterar;
    Result                     := lTransportadoraModel;
  finally
  end;
end;

function TTransportadoraModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TTransportadoraModel.getNewIface(pIConexao: IConexao): ITTransportadoraModel;
begin
  Result := TImplObjetoOwner<TTransportadoraModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TTransportadoraModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TTransportadoraModel.carregaClasse(pId : String): ITTransportadoraModel;
var
  lTransportadoraDao: ITTransportadoraDao;
begin
  lTransportadoraDao := TTransportadoraDao.getNewIface(vIConexao);

  try
    Result := lTransportadoraDao.objeto.carregaClasse(pId);
  finally
    lTransportadoraDao:=nil;
  end;
end;

constructor TTransportadoraModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTransportadoraModel.Destroy;
begin
  inherited;
end;

function TTransportadoraModel.obterLista: IFDDataset;
var
  lTransportadoraLista: ITTransportadoraDao;
begin
  lTransportadoraLista := TTransportadoraDao.getNewIface(vIConexao);

  try
    lTransportadoraLista.objeto.TotalRecords    := FTotalRecords;
    lTransportadoraLista.objeto.WhereView       := FWhereView;
    lTransportadoraLista.objeto.CountView       := FCountView;
    lTransportadoraLista.objeto.OrderView       := FOrderView;
    lTransportadoraLista.objeto.StartRecordView := FStartRecordView;
    lTransportadoraLista.objeto.LengthPageView  := FLengthPageView;
    lTransportadoraLista.objeto.IDRecordView    := FIDRecordView;

    Result := lTransportadoraLista.objeto.obterLista;

    FTotalRecords := lTransportadoraLista.objeto.TotalRecords;

  finally
    lTransportadoraLista:=nil;
  end;
end;

function TTransportadoraModel.Salvar: String;
var
  lTransportadoraDao: ITTransportadoraDao;
begin
  lTransportadoraDao := TTransportadoraDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lTransportadoraDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lTransportadoraDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lTransportadoraDao.objeto.excluir(mySelf);
    end;
  finally
    lTransportadoraDao:=nil;
  end;
end;

procedure TTransportadoraModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TTransportadoraModel.SetBAIRRO_TRA(const Value: Variant);
begin
  FBAIRRO_TRA := Value;
end;

procedure TTransportadoraModel.SetCELULARCONTATO_TRA(const Value: Variant);
begin
  FCELULARCONTATO_TRA := Value;
end;

procedure TTransportadoraModel.SetCEP_TRA(const Value: Variant);
begin
  FCEP_TRA := Value;
end;

procedure TTransportadoraModel.SetCIDADE_TRA(const Value: Variant);
begin
  FCIDADE_TRA := Value;
end;

procedure TTransportadoraModel.SetCNPJ_CPF_TRA(const Value: Variant);
begin
  FCNPJ_CPF_TRA := Value;
end;

procedure TTransportadoraModel.SetCODIGO_ANTERIOR(const Value: Variant);
begin
  FCODIGO_ANTERIOR := Value;
end;

procedure TTransportadoraModel.SetCODIGO_TRA(const Value: Variant);
begin
  FCODIGO_TRA := Value;
end;

procedure TTransportadoraModel.SetCOMPLEMENTO(const Value: Variant);
begin
  FCOMPLEMENTO := Value;
end;

procedure TTransportadoraModel.SetCONTATO_TRA(const Value: Variant);
begin
  FCONTATO_TRA := Value;
end;

procedure TTransportadoraModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTransportadoraModel.SetEMAIL_TRA(const Value: Variant);
begin
  FEMAIL_TRA := Value;
end;

procedure TTransportadoraModel.SetENDERECO_TRA(const Value: Variant);
begin
  FENDERECO_TRA := Value;
end;

procedure TTransportadoraModel.SetFANTASIA_TRA(const Value: Variant);
begin
  FFANTASIA_TRA := Value;
end;

procedure TTransportadoraModel.SetFAX_TRA(const Value: Variant);
begin
  FFAX_TRA := Value;
end;

procedure TTransportadoraModel.SetFRENET_COD(const Value: Variant);
begin
  FFRENET_COD := Value;
end;

procedure TTransportadoraModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTransportadoraModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TTransportadoraModel.SetINSCRICAO_RG_TRA(const Value: Variant);
begin
  FINSCRICAO_RG_TRA := Value;
end;

procedure TTransportadoraModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTransportadoraModel.SetNOME_ECOMMERCE(const Value: Variant);
begin
  FNOME_ECOMMERCE := Value;
end;

procedure TTransportadoraModel.SetNUMERO_END(const Value: Variant);
begin
  FNUMERO_END := Value;
end;

procedure TTransportadoraModel.SetOBSERVACAO_TRA(const Value: Variant);
begin
  FOBSERVACAO_TRA := Value;
end;

procedure TTransportadoraModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TTransportadoraModel.SetPLACA(const Value: Variant);
begin
  FPLACA := Value;
end;

procedure TTransportadoraModel.SetRASTREIO(const Value: Variant);
begin
  FRASTREIO := Value;
end;

procedure TTransportadoraModel.SetRAZAO_TRA(const Value: Variant);
begin
  FRAZAO_TRA := Value;
end;

procedure TTransportadoraModel.SetRNTC(const Value: Variant);
begin
  FRNTC := Value;
end;

procedure TTransportadoraModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TTransportadoraModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TTransportadoraModel.SetSUFRAMA(const Value: Variant);
begin
  FSUFRAMA := Value;
end;

procedure TTransportadoraModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TTransportadoraModel.SetTELEFONE2_TRA(const Value: Variant);
begin
  FTELEFONE2_TRA := Value;
end;

procedure TTransportadoraModel.SetTELEFONE_TRA(const Value: Variant);
begin
  FTELEFONE_TRA := Value;
end;

procedure TTransportadoraModel.SetTIPO_FRETE(const Value: Variant);
begin
  FTIPO_FRETE := Value;
end;

procedure TTransportadoraModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TTransportadoraModel.SetUF_TRA(const Value: Variant);
begin
  FUF_TRA := Value;
end;

procedure TTransportadoraModel.SetURL_TRA(const Value: Variant);
begin
  FURL_TRA := Value;
end;

procedure TTransportadoraModel.SetUSUARIO_ENT(const Value: Variant);
begin
  FUSUARIO_ENT := Value;
end;

procedure TTransportadoraModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
