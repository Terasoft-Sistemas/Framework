unit ClientesContatoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TClientesContatoModel = class;
  ITClientesContatoModel=IObject<TClientesContatoModel>;

  TClientesContatoModel = class
  private
    [weak] mySelf: ITClientesContatoModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FOBS: Variant;
    FEMAIL: Variant;
    FCLIENTE_ID: Variant;
    FID: Variant;
    FDEPARTAMENTO: Variant;
    FSYSTIME: Variant;
    FCONTATO: Variant;
    FUSUARIO_ID: Variant;
    FTELEFONE: Variant;
    FCELULAR: Variant;


    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetFCELULAR(const Value: Variant);
    procedure SetFCLIENTE_ID(const Value: Variant);
    procedure SetFCONTATO(const Value: Variant);
    procedure SetFDEPARTAMENTO(const Value: Variant);
    procedure SetFEMAIL(const Value: Variant);
    procedure SetFID(const Value: Variant);
    procedure SetFOBS(const Value: Variant);
    procedure SetFSYSTIME(const Value: Variant);
    procedure SetFTELEFONE(const Value: Variant);
    procedure SetFUSUARIO_ID(const Value: Variant);

  public

    property  ID            : Variant  read FID            write SetFID;
    property  CLIENTE_ID    : Variant  read FCLIENTE_ID    write SetFCLIENTE_ID;
    property  CONTATO       : Variant  read FCONTATO       write SetFCONTATO;
    property  DEPARTAMENTO  : Variant  read FDEPARTAMENTO  write SetFDEPARTAMENTO;
    property  CELULAR       : Variant  read FCELULAR       write SetFCELULAR;
    property  TELEFONE      : Variant  read FTELEFONE      write SetFTELEFONE;
    property  EMAIL         : Variant  read FEMAIL         write SetFEMAIL;
    property  OBS           : Variant  read FOBS           write SetFOBS;
    property  SYSTIME       : Variant  read FSYSTIME       write SetFSYSTIME;
    property  USUARIO_ID    : Variant  read FUSUARIO_ID    write SetFUSUARIO_ID;


  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITClientesContatoModel;

    function Incluir: String;
    function Alterar(pID : String): ITClientesContatoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITClientesContatoModel;

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
  ClientesContatoDao,
  System.Classes,
  System.SysUtils;

{ TClientesContatoModel }

function TClientesContatoModel.Alterar(pID: String): ITClientesContatoModel;
var
  lClientesContatoModel : ITClientesContatoModel;
begin
  lClientesContatoModel := TClientesContatoModel.getNewIface(vIConexao);
  try
    lClientesContatoModel       := lClientesContatoModel.objeto.carregaClasse(pID);
    lClientesContatoModel.objeto.Acao  := tacAlterar;
    Result            := lClientesContatoModel;
  finally
  end;
end;

function TClientesContatoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TClientesContatoModel.getNewIface(pIConexao: IConexao): ITClientesContatoModel;
begin
  Result := TImplObjetoOwner<TClientesContatoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TClientesContatoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TClientesContatoModel.carregaClasse(pId : String): ITClientesContatoModel;
var
  lClientesContatoDao: ITClientesContatoDao;
begin
  lClientesContatoDao := TClientesContatoDao.getNewIface(vIConexao);

  try
    Result := lClientesContatoDao.objeto.carregaClasse(pId);
  finally
    lClientesContatoDao:=nil;
  end;
end;

constructor TClientesContatoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TClientesContatoModel.Destroy;
begin
  inherited;
end;

function TClientesContatoModel.obterLista: IFDDataset;
var
  lClientesContatoLista: ITClientesContatoDao;
begin
  lClientesContatoLista := TClientesContatoDao.getNewIface(vIConexao);

  try
    lClientesContatoLista.objeto.TotalRecords    := FTotalRecords;
    lClientesContatoLista.objeto.WhereView       := FWhereView;
    lClientesContatoLista.objeto.CountView       := FCountView;
    lClientesContatoLista.objeto.OrderView       := FOrderView;
    lClientesContatoLista.objeto.StartRecordView := FStartRecordView;
    lClientesContatoLista.objeto.LengthPageView  := FLengthPageView;
    lClientesContatoLista.objeto.IDRecordView    := FIDRecordView;

    Result := lClientesContatoLista.objeto.obterLista;

    FTotalRecords := lClientesContatoLista.objeto.TotalRecords;

  finally
    lClientesContatoLista:=nil;
  end;
end;

function TClientesContatoModel.Salvar: String;
var
  lClientesContatoDao: ITClientesContatoDao;
begin
  lClientesContatoDao := TClientesContatoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lClientesContatoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lClientesContatoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lClientesContatoDao.objeto.excluir(mySelf);
    end;
  finally
    lClientesContatoDao:=nil;
  end;
end;

procedure TClientesContatoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TClientesContatoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TClientesContatoModel.SetFCELULAR(const Value: Variant);
begin
  FCELULAR := Value;
end;

procedure TClientesContatoModel.SetFCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TClientesContatoModel.SetFCONTATO(const Value: Variant);
begin
  FCONTATO := Value;
end;

procedure TClientesContatoModel.SetFDEPARTAMENTO(const Value: Variant);
begin
  FDEPARTAMENTO := Value;
end;

procedure TClientesContatoModel.SetFEMAIL(const Value: Variant);
begin
  FEMAIL := Value;
end;

procedure TClientesContatoModel.SetFID(const Value: Variant);
begin
  FID := Value;
end;

procedure TClientesContatoModel.SetFOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TClientesContatoModel.SetFSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TClientesContatoModel.SetFTELEFONE(const Value: Variant);
begin
  FTELEFONE := Value;
end;

procedure TClientesContatoModel.SetFUSUARIO_ID(const Value: Variant);
begin
  FUSUARIO_ID := Value;
end;

procedure TClientesContatoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TClientesContatoModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TClientesContatoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TClientesContatoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TClientesContatoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;


procedure TClientesContatoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TClientesContatoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TClientesContatoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
