unit DescontoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TDescontoModel = class

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
    FUSUARIO_DES: Variant;
    FTIPOVENDA_DES: Variant;
    FVALOR_DES: Variant;
    FID: Variant;
    FSYSTIME: Variant;


    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetFID(const Value: Variant);
    procedure SetFSYSTIME(const Value: Variant);
    procedure SetFTIPOVENDA_DES(const Value: Variant);
    procedure SetFUSUARIO_DES(const Value: Variant);
    procedure SetFVALOR_DES(const Value: Variant);

  public

    property USUARIO_DES   : Variant read FUSUARIO_DES   write SetFUSUARIO_DES;
    property TIPOVENDA_DES : Variant read FTIPOVENDA_DES write SetFTIPOVENDA_DES;
    property VALOR_DES     : Variant read FVALOR_DES     write SetFVALOR_DES;
    property ID            : Variant read FID            write SetFID;
    property SYSTIME       : Variant read FSYSTIME       write SetFSYSTIME;


  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TDescontoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TDescontoModel;

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
  DescontoDao,
  System.Classes,
  System.SysUtils;

{ TDescontoModel }

function TDescontoModel.Alterar(pID: String): TDescontoModel;
var
  lDescontoModel : TDescontoModel;
begin
  lDescontoModel := TDescontoModel.Create(vIConexao);
  try
    lDescontoModel       := lDescontoModel.carregaClasse(pID);
    lDescontoModel.Acao  := tacAlterar;
    Result            := lDescontoModel;
  finally
  end;
end;

function TDescontoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TDescontoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TDescontoModel.carregaClasse(pId : String): TDescontoModel;
var
  lDescontoDao: TDescontoDao;
begin
  lDescontoDao := TDescontoDao.Create(vIConexao);

  try
    Result := lDescontoDao.carregaClasse(pId);
  finally
    lDescontoDao.Free;
  end;
end;

constructor TDescontoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDescontoModel.Destroy;
begin
  inherited;
end;

function TDescontoModel.obterLista: TFDMemTable;
var
  lDescontoLista: TDescontoDao;
begin
  lDescontoLista := TDescontoDao.Create(vIConexao);

  try
    lDescontoLista.TotalRecords    := FTotalRecords;
    lDescontoLista.WhereView       := FWhereView;
    lDescontoLista.CountView       := FCountView;
    lDescontoLista.OrderView       := FOrderView;
    lDescontoLista.StartRecordView := FStartRecordView;
    lDescontoLista.LengthPageView  := FLengthPageView;
    lDescontoLista.IDRecordView    := FIDRecordView;

    Result := lDescontoLista.obterLista;

    FTotalRecords := lDescontoLista.TotalRecords;

  finally
    lDescontoLista.Free;
  end;
end;

function TDescontoModel.Salvar: String;
var
  lDescontoDao: TDescontoDao;
begin
  lDescontoDao := TDescontoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lDescontoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lDescontoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lDescontoDao.excluir(Self);
    end;
  finally
    lDescontoDao.Free;
  end;
end;

procedure TDescontoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TDescontoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDescontoModel.SetFID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDescontoModel.SetFSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TDescontoModel.SetFTIPOVENDA_DES(const Value: Variant);
begin
  FTIPOVENDA_DES := Value;
end;

procedure TDescontoModel.SetFUSUARIO_DES(const Value: Variant);
begin
  FUSUARIO_DES := Value;
end;

procedure TDescontoModel.SetFVALOR_DES(const Value: Variant);
begin
  FVALOR_DES := Value;
end;

procedure TDescontoModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TDescontoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDescontoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TDescontoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TDescontoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TDescontoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
