unit ConfiguracoesLocaisModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TConfiguracoesLocaisModel = class;

  ITConfiguracoesLocaisModel = IObject<TConfiguracoesLocaisModel>;

  TConfiguracoesLocaisModel = class
  private
    [unsafe] myself: ITConfiguracoesLocaisModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FVALORSTRING: Variant;
    FVALORDATA: Variant;
    FVALORMEMO: Variant;
    FVALORDATAHORA: Variant;
    FVALORHORA: Variant;
    FF_ID: Variant;
    FVALORCHAR: Variant;
    FID: Variant;
    FVALORINTEIRO: Variant;
    FPERFIL_ID: Variant;
    FTAG: Variant;
    FVALORNUMERICO: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetFF_ID(const Value: Variant);
    procedure SetFID(const Value: Variant);
    procedure SetFPERFIL_ID(const Value: Variant);
    procedure SetFTAG(const Value: Variant);
    procedure SetFVALORCHAR(const Value: Variant);
    procedure SetFVALORDATA(const Value: Variant);
    procedure SetFVALORDATAHORA(const Value: Variant);
    procedure SetFVALORHORA(const Value: Variant);
    procedure SetFVALORINTEIRO(const Value: Variant);
    procedure SetFVALORMEMO(const Value: Variant);
    procedure SetFVALORNUMERICO(const Value: Variant);
    procedure SetFVALORSTRING(const Value: Variant);

  public
    property  ID            : Variant  read FID            write SetFID;
    property  TAG           : Variant  read FTAG           write SetFTAG;
    property  F_ID          : Variant  read FF_ID          write SetFF_ID;
    property  PERFIL_ID     : Variant  read FPERFIL_ID     write SetFPERFIL_ID;
    property  VALORINTEIRO  : Variant  read FVALORINTEIRO  write SetFVALORINTEIRO;
    property  VALORSTRING   : Variant  read FVALORSTRING   write SetFVALORSTRING;
    property  VALORMEMO     : Variant  read FVALORMEMO     write SetFVALORMEMO;
    property  VALORNUMERICO : Variant  read FVALORNUMERICO write SetFVALORNUMERICO;
    property  VALORCHAR     : Variant  read FVALORCHAR     write SetFVALORCHAR;
    property  VALORDATA     : Variant  read FVALORDATA     write SetFVALORDATA;
    property  VALORHORA     : Variant  read FVALORHORA     write SetFVALORHORA;
    property  VALORDATAHORA : Variant  read FVALORDATAHORA write SetFVALORDATAHORA;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao : IConexao): ITConfiguracoesLocaisModel;

    function Incluir: String;
    function Alterar(pID : String): ITConfiguracoesLocaisModel;
    function Excluir(pID : String): String;
    function Salvar: String;
    function obterLista: IFDDataset;

    function carregaClasse(pId: String): ITConfiguracoesLocaisModel;

   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  ConfiguracoesLocaisDao;

{ TConfiguracoesLocaisModel }

function TConfiguracoesLocaisModel.Alterar(pID: String): ITConfiguracoesLocaisModel;
var
  lConfiguracoesLocaisModel : ITConfiguracoesLocaisModel;
begin
  lConfiguracoesLocaisModel := TConfiguracoesLocaisModel.getNewIface(vIConexao);

  try
    lConfiguracoesLocaisModel      := lConfiguracoesLocaisModel.objeto.carregaClasse(pID);
    lConfiguracoesLocaisModel.objeto.Acao := tacAlterar;
    Result               := lConfiguracoesLocaisModel;
  finally
    lConfiguracoesLocaisModel:=nil;
  end;
end;

function TConfiguracoesLocaisModel.carregaClasse(pId: String): ITConfiguracoesLocaisModel;
var
  lConfiguracoesLocaisDao: ITConfiguracoesLocaisDao;
begin
  lConfiguracoesLocaisDao := TConfiguracoesLocaisDao.getNewIface(vIConexao);

  try
    Result := lConfiguracoesLocaisDao.objeto.carregaClasse(pId);
  finally
    lConfiguracoesLocaisDao := nil;
  end;
end;

constructor TConfiguracoesLocaisModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TConfiguracoesLocaisModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TConfiguracoesLocaisModel.Excluir(pID: String): String;
begin
  self.FID := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar
end;

class function TConfiguracoesLocaisModel.getNewIface(pIConexao: IConexao): ITConfiguracoesLocaisModel;
begin
  Result := TImplObjetoOwner<TConfiguracoesLocaisModel>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TConfiguracoesLocaisModel.Incluir: String;
var
  lConfiguracoesLocaisModel : ITConfiguracoesLocaisModel;
begin
  lConfiguracoesLocaisModel := TConfiguracoesLocaisModel.getNewIface(vIConexao);
  try
    self.Acao := tacIncluir ;
    Result    := self.Salvar;
  finally
    lConfiguracoesLocaisModel := nil;
  end;
end;

function TConfiguracoesLocaisModel.obterLista: IFDDataset;
var
  lConfiguracoesLocais: ITConfiguracoesLocaisDao;
begin
  lConfiguracoesLocais := TConfiguracoesLocaisDao.getNewIface(vIConexao);

  try
    lConfiguracoesLocais.objeto.TotalRecords    := FTotalRecords;
    lConfiguracoesLocais.objeto.WhereView       := FWhereView;
    lConfiguracoesLocais.objeto.CountView       := FCountView;
    lConfiguracoesLocais.objeto.OrderView       := FOrderView;
    lConfiguracoesLocais.objeto.StartRecordView := FStartRecordView;
    lConfiguracoesLocais.objeto.LengthPageView  := FLengthPageView;
    lConfiguracoesLocais.objeto.IDRecordView    := FIDRecordView;

    Result := lConfiguracoesLocais.objeto.obterLista;

    FTotalRecords  := lConfiguracoesLocais.objeto.TotalRecords;
  finally
    lConfiguracoesLocais := nil;
  end;
end;

function TConfiguracoesLocaisModel.Salvar: String;
var
  lConfiguracoesLocaisDao: ITConfiguracoesLocaisDao;
begin
  lConfiguracoesLocaisDao := TConfiguracoesLocaisDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lConfiguracoesLocaisDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lConfiguracoesLocaisDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lConfiguracoesLocaisDao.objeto.excluir(mySelf);
    end;

  finally
    lConfiguracoesLocaisDao := nil;
  end;
end;

procedure TConfiguracoesLocaisModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TConfiguracoesLocaisModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TConfiguracoesLocaisModel.SetFF_ID(const Value: Variant);
begin
  FF_ID := Value;
end;

procedure TConfiguracoesLocaisModel.SetFID(const Value: Variant);
begin
  FID := Value;
end;

procedure TConfiguracoesLocaisModel.SetFPERFIL_ID(const Value: Variant);
begin
  FPERFIL_ID := Value;
end;

procedure TConfiguracoesLocaisModel.SetFTAG(const Value: Variant);
begin
  FTAG := Value;
end;

procedure TConfiguracoesLocaisModel.SetFVALORCHAR(const Value: Variant);
begin
  FVALORCHAR := Value;
end;

procedure TConfiguracoesLocaisModel.SetFVALORDATA(const Value: Variant);
begin
  FVALORDATA := Value;
end;

procedure TConfiguracoesLocaisModel.SetFVALORDATAHORA(const Value: Variant);
begin
  FVALORDATAHORA := Value;
end;

procedure TConfiguracoesLocaisModel.SetFVALORHORA(const Value: Variant);
begin
  FVALORHORA := Value;
end;

procedure TConfiguracoesLocaisModel.SetFVALORINTEIRO(const Value: Variant);
begin
  FVALORINTEIRO := Value;
end;

procedure TConfiguracoesLocaisModel.SetFVALORMEMO(const Value: Variant);
begin
  FVALORMEMO := Value;
end;

procedure TConfiguracoesLocaisModel.SetFVALORNUMERICO(const Value: Variant);
begin
  FVALORNUMERICO := Value;
end;

procedure TConfiguracoesLocaisModel.SetFVALORSTRING(const Value: Variant);
begin
  FVALORSTRING := Value;
end;

procedure TConfiguracoesLocaisModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TConfiguracoesLocaisModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TConfiguracoesLocaisModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TConfiguracoesLocaisModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TConfiguracoesLocaisModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TConfiguracoesLocaisModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
