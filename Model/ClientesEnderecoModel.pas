unit ClientesEnderecoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TClientesEnderecoModel = class

  private
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
    FREGIAO_ID: Variant;
    FBAIRRO: Variant;
    FSYSTIME: Variant;
    FUF: Variant;
    FCLIENTE_ID: Variant;
    FCEP: Variant;
    FID: Variant;
    FNUMERO: Variant;
    FCOMPLEMENTO: Variant;
    FCONTATO: Variant;
    FTIPO: Variant;
    FCIDADE: Variant;
    FENDERECO: Variant;
    FTELEFONE: Variant;
    FCOD_MUNICIPIO: Variant;


    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetBAIRRO(const Value: Variant);
    procedure SetCEP(const Value: Variant);
    procedure SetCIDADE(const Value: Variant);
    procedure SetCLIENTE_ID(const Value: Variant);
    procedure SetCOD_MUNICIPIO(const Value: Variant);
    procedure SetCOMPLEMENTO(const Value: Variant);
    procedure SetCONTATO(const Value: Variant);
    procedure SetENDERECO(const Value: Variant);
    procedure SetFID(const Value: Variant);
    procedure SetNUMERO(const Value: Variant);
    procedure SetOBS(const Value: Variant);
    procedure SetREGIAO_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTELEFONE(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetUF(const Value: Variant);

  public

    property  ID            : Variant  read FID            write SetFID;
    property  CLIENTE_ID    : Variant  read FCLIENTE_ID    write SetCLIENTE_ID;
    property  ENDERECO      : Variant  read FENDERECO      write SetENDERECO;
    property  NUMERO        : Variant  read FNUMERO        write SetNUMERO;
    property  COMPLEMENTO   : Variant  read FCOMPLEMENTO   write SetCOMPLEMENTO;
    property  BAIRRO        : Variant  read FBAIRRO        write SetBAIRRO;
    property  CIDADE        : Variant  read FCIDADE        write SetCIDADE;
    property  UF            : Variant  read FUF            write SetUF;
    property  CEP           : Variant  read FCEP           write SetCEP;
    property  COD_MUNICIPIO : Variant  read FCOD_MUNICIPIO write SetCOD_MUNICIPIO;
    property  OBS           : Variant  read FOBS           write SetOBS;
    property  TIPO          : Variant  read FTIPO          write SetTIPO;
    property  REGIAO_ID     : Variant  read FREGIAO_ID     write SetREGIAO_ID;
    property  TELEFONE      : Variant  read FTELEFONE      write SetTELEFONE;
    property  CONTATO       : Variant  read FCONTATO       write SetCONTATO;
    property  SYSTIME        : Variant  read FSYSTIME        write SetSYSTIME;


  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TClientesEnderecoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TClientesEnderecoModel;

    function ObterLista: TFDMemTable; overload;

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
  ClientesEnderecoDao,
  System.Classes,
  System.SysUtils;

{ TClientesEnderecoModel }

function TClientesEnderecoModel.Alterar(pID: String): TClientesEnderecoModel;
var
  lClientesEnderecoModel : TClientesEnderecoModel;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.Create(vIConexao);
  try
    lClientesEnderecoModel       := lClientesEnderecoModel.carregaClasse(pID);
    lClientesEnderecoModel.Acao  := tacAlterar;
    Result            := lClientesEnderecoModel;
  finally
  end;
end;

function TClientesEnderecoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TClientesEnderecoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TClientesEnderecoModel.carregaClasse(pId : String): TClientesEnderecoModel;
var
  lClientesEnderecoDao: TClientesEnderecoDao;
begin
  lClientesEnderecoDao := TClientesEnderecoDao.Create(vIConexao);

  try
    Result := lClientesEnderecoDao.carregaClasse(pId);
  finally
    lClientesEnderecoDao.Free;
  end;
end;

constructor TClientesEnderecoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TClientesEnderecoModel.Destroy;
begin
  inherited;
end;

function TClientesEnderecoModel.obterLista: TFDMemTable;
var
  lClientesEnderecoLista: TClientesEnderecoDao;
begin
  lClientesEnderecoLista := TClientesEnderecoDao.Create(vIConexao);

  try
    lClientesEnderecoLista.TotalRecords    := FTotalRecords;
    lClientesEnderecoLista.WhereView       := FWhereView;
    lClientesEnderecoLista.CountView       := FCountView;
    lClientesEnderecoLista.OrderView       := FOrderView;
    lClientesEnderecoLista.StartRecordView := FStartRecordView;
    lClientesEnderecoLista.LengthPageView  := FLengthPageView;
    lClientesEnderecoLista.IDRecordView    := FIDRecordView;

    Result := lClientesEnderecoLista.obterLista;

    FTotalRecords := lClientesEnderecoLista.TotalRecords;

  finally
    lClientesEnderecoLista.Free;
  end;
end;

function TClientesEnderecoModel.Salvar: String;
var
  lClientesEnderecoDao: TClientesEnderecoDao;
begin
  lClientesEnderecoDao := TClientesEnderecoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lClientesEnderecoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lClientesEnderecoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lClientesEnderecoDao.excluir(Self);
    end;
  finally
    lClientesEnderecoDao.Free;
  end;
end;

procedure TClientesEnderecoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TClientesEnderecoModel.SetBAIRRO(const Value: Variant);
begin
  FBAIRRO := Value;
end;

procedure TClientesEnderecoModel.SetCEP(const Value: Variant);
begin
  FCEP := Value;
end;

procedure TClientesEnderecoModel.SetCIDADE(const Value: Variant);
begin
  FCIDADE := Value;
end;

procedure TClientesEnderecoModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TClientesEnderecoModel.SetCOD_MUNICIPIO(const Value: Variant);
begin
  FCOD_MUNICIPIO := Value;
end;

procedure TClientesEnderecoModel.SetCOMPLEMENTO(const Value: Variant);
begin
  FCOMPLEMENTO := Value;
end;

procedure TClientesEnderecoModel.SetCONTATO(const Value: Variant);
begin
  FCONTATO := Value;
end;

procedure TClientesEnderecoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TClientesEnderecoModel.SetENDERECO(const Value: Variant);
begin
  FENDERECO := Value;
end;

procedure TClientesEnderecoModel.SetFID(const Value: Variant);
begin
  FID := Value;
end;

procedure TClientesEnderecoModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TClientesEnderecoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TClientesEnderecoModel.SetNUMERO(const Value: Variant);
begin
  FNUMERO := Value;
end;

procedure TClientesEnderecoModel.SetOBS(const Value: Variant);
begin
  FOBS := Value;
end;

procedure TClientesEnderecoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TClientesEnderecoModel.SetREGIAO_ID(const Value: Variant);
begin
  FREGIAO_ID := Value;
end;

procedure TClientesEnderecoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TClientesEnderecoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TClientesEnderecoModel.SetTELEFONE(const Value: Variant);
begin
  FTELEFONE := Value;
end;

procedure TClientesEnderecoModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TClientesEnderecoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TClientesEnderecoModel.SetUF(const Value: Variant);
begin
  FUF := Value;
end;

procedure TClientesEnderecoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
