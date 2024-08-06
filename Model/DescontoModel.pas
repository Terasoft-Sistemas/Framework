unit DescontoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TDescontoModel = class;
  ITDescontoModel=IObject<TDescontoModel>;

  TDescontoModel = class
  private
    [weak] mySelf: ITDescontoModel;
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
    FIDUsuarioView: String;
    FIDTipoVendaView: String;


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
    procedure SetIDTipoVendaView(const Value: String);
    procedure SetIDUsuarioView(const Value: String);

  public

    property USUARIO_DES   : Variant read FUSUARIO_DES   write SetFUSUARIO_DES;
    property TIPOVENDA_DES : Variant read FTIPOVENDA_DES write SetFTIPOVENDA_DES;
    property VALOR_DES     : Variant read FVALOR_DES     write SetFVALOR_DES;
    property ID            : Variant read FID            write SetFID;
    property SYSTIME       : Variant read FSYSTIME       write SetFSYSTIME;


  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDescontoModel;

    function Incluir: String;
    function Alterar(pID : String): ITDescontoModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITDescontoModel;

    function ObterLista: IFDDataset; overload;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordview : String read FIDRecordview write SetIDRecordview;
    property IDUsuarioView : String read FIDUsuarioView write SetIDUsuarioView;
    property IDTipoVendaView : String read FIDTipoVendaView write SetIDTipoVendaView;

  end;

implementation

uses
  DescontoDao,
  System.Classes,
  System.SysUtils;

{ TDescontoModel }

function TDescontoModel.Alterar(pID: String): ITDescontoModel;
var
  lDescontoModel : ITDescontoModel;
begin
  lDescontoModel := TDescontoModel.getNewIface(vIConexao);
  try
    lDescontoModel       := lDescontoModel.objeto.carregaClasse(pID);
    lDescontoModel.objeto.Acao  := tacAlterar;
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

class function TDescontoModel.getNewIface(pIConexao: IConexao): ITDescontoModel;
begin
  Result := TImplObjetoOwner<TDescontoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDescontoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TDescontoModel.carregaClasse(pId : String): ITDescontoModel;
var
  lDescontoDao: ITDescontoDao;
begin
  lDescontoDao := TDescontoDao.getNewIface(vIConexao);

  try
    Result := lDescontoDao.objeto.carregaClasse(pId);
  finally
    lDescontoDao:=nil;
  end;
end;

constructor TDescontoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDescontoModel.Destroy;
begin
  inherited;
end;

function TDescontoModel.obterLista: IFDDataset;
var
  lDescontoLista: ITDescontoDao;
begin
  lDescontoLista := TDescontoDao.getNewIface(vIConexao);

  try
    lDescontoLista.objeto.TotalRecords    := FTotalRecords;
    lDescontoLista.objeto.WhereView       := FWhereView;
    lDescontoLista.objeto.CountView       := FCountView;
    lDescontoLista.objeto.OrderView       := FOrderView;
    lDescontoLista.objeto.StartRecordView := FStartRecordView;
    lDescontoLista.objeto.LengthPageView  := FLengthPageView;
    lDescontoLista.objeto.IDRecordView    := FIDRecordView;
    lDescontoLista.objeto.IDTipoVendaView := FIDTipoVendaView;
    lDescontoLista.objeto.IDUsuarioView   := FIDUsuarioView;

    Result := lDescontoLista.objeto.obterLista;

    FTotalRecords := lDescontoLista.objeto.TotalRecords;

  finally
    lDescontoLista:=nil;
  end;
end;

function TDescontoModel.Salvar: String;
var
  lDescontoDao: ITDescontoDao;
begin
  lDescontoDao := TDescontoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lDescontoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lDescontoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lDescontoDao.objeto.excluir(mySelf);
    end;
  finally
    lDescontoDao:=nil;
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

procedure TDescontoModel.SetIDTipoVendaView(const Value: String);
begin
  FIDTipoVendaView := Value;
end;

procedure TDescontoModel.SetIDUsuarioView(const Value: String);
begin
  FIDUsuarioView := Value;
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
