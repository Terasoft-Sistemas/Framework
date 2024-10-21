unit ReciboModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type

  TReciboModel = class;
  ITReciboModel=IObject<TReciboModel>;

  TReciboModel = class
  private
    [unsafe] mySelf: ITReciboModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVALOR: Variant;
    FCLIENTE_ID: Variant;
    FID: Variant;
    FREFERENTE: Variant;
    FDOCUMENTO_ID: Variant;
    FSYSTIME: Variant;
    FDATA: Variant;
    FMATRICIAL: Variant;
    FTIPO_DOCUMENTO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetFCLIENTE_ID(const Value: Variant);
    procedure SetFDATA(const Value: Variant);
    procedure SetFDOCUMENTO_ID(const Value: Variant);
    procedure SetFID(const Value: Variant);
    procedure SetFMATRICIAL(const Value: Variant);
    procedure SetFREFERENTE(const Value: Variant);
    procedure SetFSYSTIME(const Value: Variant);
    procedure SetFTIPO_DOCUMENTO(const Value: Variant);
    procedure SetFVALOR(const Value: Variant);

  public

    property  ID             : Variant read FID             write SetFID;
    property  VALOR          : Variant read FVALOR          write SetFVALOR;
    property  CLIENTE_ID     : Variant read FCLIENTE_ID     write SetFCLIENTE_ID;
    property  REFERENTE      : Variant read FREFERENTE      write SetFREFERENTE;
    property  DOCUMENTO_ID   : Variant read FDOCUMENTO_ID   write SetFDOCUMENTO_ID;
    property  TIPO_DOCUMENTO : Variant read FTIPO_DOCUMENTO write SetFTIPO_DOCUMENTO;
    property  DATA           : Variant read FDATA           write SetFDATA;
    property  MATRICIAL      : Variant read FMATRICIAL      write SetFMATRICIAL;
    property  SYSTIME        : Variant read FSYSTIME        write SetFSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITReciboModel;

    function Incluir: String;
    function Alterar(pID : String): ITReciboModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITReciboModel;

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
  ReciboDao,
  System.Classes,
  System.SysUtils;

{ TReciboModel }

function TReciboModel.Alterar(pID: String): ITReciboModel;
var
  lReciboModel : ITReciboModel;
begin
  lReciboModel := TReciboModel.getNewIface(vIConexao);
  try
    lReciboModel       := lReciboModel.objeto.carregaClasse(pID);
    lReciboModel.objeto.Acao  := tacAlterar;
    Result            := lReciboModel;
  finally
  end;
end;

function TReciboModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TReciboModel.getNewIface(pIConexao: IConexao): ITReciboModel;
begin
  Result := TImplObjetoOwner<TReciboModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TReciboModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TReciboModel.carregaClasse(pId : String): ITReciboModel;
var
  lReciboDao: ITReciboDao;
begin
  lReciboDao := TReciboDao.getNewIface(vIConexao);

  try
    Result := lReciboDao.objeto.carregaClasse(pId);
  finally
    lReciboDao:=nil;
  end;
end;

constructor TReciboModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TReciboModel.Destroy;
begin
  inherited;
end;

function TReciboModel.obterLista: IFDDataset;
var
  lReciboLista: ITReciboDao;
begin
  lReciboLista := TReciboDao.getNewIface(vIConexao);

  try
    lReciboLista.objeto.TotalRecords    := FTotalRecords;
    lReciboLista.objeto.WhereView       := FWhereView;
    lReciboLista.objeto.CountView       := FCountView;
    lReciboLista.objeto.OrderView       := FOrderView;
    lReciboLista.objeto.StartRecordView := FStartRecordView;
    lReciboLista.objeto.LengthPageView  := FLengthPageView;
    lReciboLista.objeto.IDRecordView    := FIDRecordView;

    Result := lReciboLista.objeto.obterLista;

    FTotalRecords := lReciboLista.objeto.TotalRecords;

  finally
    lReciboLista:=nil;
  end;
end;

function TReciboModel.Salvar: String;
var
  lReciboDao: ITReciboDao;
begin
  lReciboDao := TReciboDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lReciboDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lReciboDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lReciboDao.objeto.excluir(mySelf);
    end;
  finally
    lReciboDao:=nil;
  end;
end;

procedure TReciboModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TReciboModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TReciboModel.SetFCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TReciboModel.SetFDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TReciboModel.SetFDOCUMENTO_ID(const Value: Variant);
begin
  FDOCUMENTO_ID := Value;
end;

procedure TReciboModel.SetFID(const Value: Variant);
begin
  FID := Value;
end;

procedure TReciboModel.SetFMATRICIAL(const Value: Variant);
begin
  FMATRICIAL := Value;
end;

procedure TReciboModel.SetFREFERENTE(const Value: Variant);
begin
  FREFERENTE := Value;
end;

procedure TReciboModel.SetFSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TReciboModel.SetFTIPO_DOCUMENTO(const Value: Variant);
begin
  FTIPO_DOCUMENTO := Value;
end;

procedure TReciboModel.SetFVALOR(const Value: Variant);
begin
  FVALOR := Value;
end;

procedure TReciboModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TReciboModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TReciboModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TReciboModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TReciboModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TReciboModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
