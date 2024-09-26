unit AtendimentoModel;

interface

uses
  Terasoft.Types,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TAtendimentoModel=class;
  ITAtendimentoModel=IObject<TAtendimentoModel>;

  TAtendimentoModel = class
  private
    [unsafe] mySelf: ITAtendimentoModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FATUALIZADO: Variant;
    FSOLICITANTE: Variant;
    FDATA_ALTERACAO: Variant;
    FOBS: Variant;
    FHORA: Variant;
    FVERSAO_NEW: Variant;
    FDATA_AGENDAMENTO: Variant;
    FCLIENTE: Variant;
    FRESPONSAVEL: Variant;
    FVISUALIZADO: Variant;
    FUSUARIO_FINAL: Variant;
    FID: Variant;
    FVERSAO_OLD: Variant;
    FSISTEMA_ID: Variant;
    FHORA_AGENDAMENTO: Variant;
    FDATA_CONCLUSAO: Variant;
    FSTATUS: Variant;
    FTAG: Variant;
    FSYSTIME: Variant;
    FLIGACAO_ID: Variant;
    FHISTORIO: Variant;
    FHORA_CONCLUSAO: Variant;
    FNOTIFICACAO: Variant;
    FUSUARIO: Variant;
    FTIPO: Variant;
    FDATA: Variant;
    FOS_ID: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetATUALIZADO(const Value: Variant);
    procedure SetCLIENTE(const Value: Variant);
    procedure SetDATA(const Value: Variant);
    procedure SetDATA_AGENDAMENTO(const Value: Variant);
    procedure SetDATA_ALTERACAO(const Value: Variant);
    procedure SetDATA_CONCLUSAO(const Value: Variant);
    procedure SetHISTORIO(const Value: Variant);
    procedure SetHORA(const Value: Variant);
    procedure SetHORA_AGENDAMENTO(const Value: Variant);
    procedure SetHORA_CONCLUSAO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLIGACAO_ID(const Value: Variant);
    procedure SetNOTIFICACAO(const Value: Variant);
    procedure SetOBS(const Value: Variant);
    procedure SetOS_ID(const Value: Variant);
    procedure SetRESPONSAVEL(const Value: Variant);
    procedure SetSISTEMA_ID(const Value: Variant);
    procedure SetSOLICITANTE(const Value: Variant);
    procedure SetSTATUS(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAG(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetUSUARIO(const Value: Variant);
    procedure SetUSUARIO_FINAL(const Value: Variant);
    procedure SetVERSAO_NEW(const Value: Variant);
    procedure SetVERSAO_OLD(const Value: Variant);
    procedure SetVISUALIZADO(const Value: Variant);

  public
    property ID                 : Variant     read FID                  write SetID;
    property DATA               : Variant     read FDATA                write SetDATA;
    property HORA               : Variant     read FHORA                write SetHORA;
    property CLIENTE            : Variant     read FCLIENTE             write SetCLIENTE;
    property TAG                : Variant     read FTAG                 write SetTAG;
    property HISTORIO           : Variant     read FHISTORIO            write SetHISTORIO;
    property STATUS             : Variant     read FSTATUS              write SetSTATUS;
    property DATA_CONCLUSAO     : Variant     read FDATA_CONCLUSAO      write SetDATA_CONCLUSAO;
    property HORA_CONCLUSAO     : Variant     read FHORA_CONCLUSAO      write SetHORA_CONCLUSAO;
    property USUARIO            : Variant     read FUSUARIO             write SetUSUARIO;
    property OBS                : Variant     read FOBS                 write SetOBS;
    property TIPO               : Variant     read FTIPO                write SetTIPO;
    property SOLICITANTE        : Variant     read FSOLICITANTE         write SetSOLICITANTE;
    property USUARIO_FINAL      : Variant     read FUSUARIO_FINAL       write SetUSUARIO_FINAL;
    property DATA_AGENDAMENTO   : Variant     read FDATA_AGENDAMENTO    write SetDATA_AGENDAMENTO;
    property HORA_AGENDAMENTO   : Variant     read FHORA_AGENDAMENTO    write SetHORA_AGENDAMENTO;
    property ATUALIZADO         : Variant     read FATUALIZADO          write SetATUALIZADO;
    property RESPONSAVEL        : Variant     read FRESPONSAVEL         write SetRESPONSAVEL;
    property SISTEMA_ID         : Variant     read FSISTEMA_ID          write SetSISTEMA_ID;
    property DATA_ALTERACAO     : Variant     read FDATA_ALTERACAO      write SetDATA_ALTERACAO;
    property VERSAO_OLD         : Variant     read FVERSAO_OLD          write SetVERSAO_OLD;
    property VERSAO_NEW         : Variant     read FVERSAO_NEW          write SetVERSAO_NEW;
    property OS_ID              : Variant     read FOS_ID               write SetOS_ID;
    property VISUALIZADO        : Variant     read FVISUALIZADO         write SetVISUALIZADO;
    property LIGACAO_ID         : Variant     read FLIGACAO_ID          write SetLIGACAO_ID;
    property NOTIFICACAO        : Variant     read FNOTIFICACAO         write SetNOTIFICACAO;
    property SYSTIME            : Variant     read FSYSTIME             write SetSYSTIME;

   	property Acao               : TAcao       read FAcao                write SetAcao;
    property TotalRecords       : Integer     read FTotalRecords        write SetTotalRecords;
    property WhereView          : String      read FWhereView           write SetWhereView;
    property CountView          : String      read FCountView           write SetCountView;
    property OrderView          : String      read FOrderView           write SetOrderView;
    property StartRecordView    : String      read FStartRecordView     write SetStartRecordView;
    property LengthPageView     : String      read FLengthPageView      write SetLengthPageView;
    property IDRecordView       : Integer     read FIDRecordView        write SetIDRecordView;


  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITAtendimentoModel;

    function Salvar: String;
    function obterLista: IFDDataset;

  end;

implementation

uses
  AtendimentoDao;

{ TAtendimentoModel }

constructor TAtendimentoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TAtendimentoModel.Destroy;
begin

  inherited;
end;

class function TAtendimentoModel.getNewIface(pIConexao: IConexao): ITAtendimentoModel;
begin
  Result := TImplObjetoOwner<TAtendimentoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TAtendimentoModel.obterLista: IFDDataset;
var
  lAtendimentoLista: ITAtendimentoDao;
begin
  lAtendimentoLista := TAtendimentoDao.getNewIface(vIConexao);
  lAtendimentoLista.objeto.TotalRecords    := FTotalRecords;
  lAtendimentoLista.objeto.WhereView       := FWhereView;
  lAtendimentoLista.objeto.CountView       := FCountView;
  lAtendimentoLista.objeto.OrderView       := FOrderView;
  lAtendimentoLista.objeto.StartRecordView := FStartRecordView;
  lAtendimentoLista.objeto.LengthPageView  := FLengthPageView;
  lAtendimentoLista.objeto.IDRecordView    := FIDRecordView;

  Result        := lAtendimentoLista.objeto.obterLista;
  FTotalRecords := lAtendimentoLista.objeto.TotalRecords;
end;

function TAtendimentoModel.Salvar: String;
var
  lAtendimentoDao: ITAtendimentoDao;
begin
  lAtendimentoDao := TAtendimentoDao.getNewIface(vIConexao);

  Result := '';

  case FAcao of
    Terasoft.Types.tacIncluir: Result := lAtendimentoDao.objeto.incluir(mySelf);
    Terasoft.Types.tacAlterar: Result := lAtendimentoDao.objeto.alterar(mySelf);
    Terasoft.Types.tacExcluir: Result := lAtendimentoDao.objeto.excluir(mySelf);
  end;

end;

procedure TAtendimentoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TAtendimentoModel.SetATUALIZADO(const Value: Variant);
begin
  FATUALIZADO := Value;
end;

procedure TAtendimentoModel.SetCLIENTE(const Value: Variant);
begin
  FCLIENTE := Value;
end;

procedure TAtendimentoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAtendimentoModel.SetDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TAtendimentoModel.SetDATA_AGENDAMENTO(const Value: Variant);
begin
  FDATA_AGENDAMENTO := Value;
end;

procedure TAtendimentoModel.SetDATA_ALTERACAO(const Value: Variant);
begin
  FDATA_ALTERACAO := Value;
end;

procedure TAtendimentoModel.SetDATA_CONCLUSAO(const Value: Variant);
begin
  FDATA_CONCLUSAO := Value;
end;

procedure TAtendimentoModel.SetHISTORIO(const Value: Variant);
begin
  FHISTORIO := Value;
end;

procedure TAtendimentoModel.SetHORA(const Value: Variant);
begin
  FHORA := Value;
end;

procedure TAtendimentoModel.SetHORA_AGENDAMENTO(const Value: Variant);
begin
  FHORA_AGENDAMENTO := Value;
end;

procedure TAtendimentoModel.SetHORA_CONCLUSAO(const Value: Variant);
begin
  FHORA_CONCLUSAO := Value;
end;

procedure TAtendimentoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAtendimentoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAtendimentoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAtendimentoModel.SetLIGACAO_ID(const Value: Variant);
begin
  FLIGACAO_ID := Value;
end;

procedure TAtendimentoModel.SetNOTIFICACAO(const Value: Variant);
begin
  FNOTIFICACAO := Value;
end;

procedure TAtendimentoModel.SetOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TAtendimentoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAtendimentoModel.SetOS_ID(const Value: Variant);
begin
  FOS_ID := Value;
end;

procedure TAtendimentoModel.SetRESPONSAVEL(const Value: Variant);
begin
  FRESPONSAVEL := Value;
end;

procedure TAtendimentoModel.SetSISTEMA_ID(const Value: Variant);
begin
  FSISTEMA_ID := Value;
end;

procedure TAtendimentoModel.SetSOLICITANTE(const Value: Variant);
begin
  FSOLICITANTE := Value;
end;

procedure TAtendimentoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAtendimentoModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TAtendimentoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TAtendimentoModel.SetTAG(const Value: Variant);
begin
  FTAG := Value;
end;

procedure TAtendimentoModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TAtendimentoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAtendimentoModel.SetUSUARIO(const Value: Variant);
begin
  FUSUARIO := Value;
end;

procedure TAtendimentoModel.SetUSUARIO_FINAL(const Value: Variant);
begin
  FUSUARIO_FINAL := Value;
end;

procedure TAtendimentoModel.SetVERSAO_NEW(const Value: Variant);
begin
  FVERSAO_NEW := Value;
end;

procedure TAtendimentoModel.SetVERSAO_OLD(const Value: Variant);
begin
  FVERSAO_OLD := Value;
end;

procedure TAtendimentoModel.SetVISUALIZADO(const Value: Variant);
begin
  FVISUALIZADO := Value;
end;

procedure TAtendimentoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
