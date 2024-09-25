unit MarcaModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TMarcaModel = class;
  ITMarcaModel=IObject<TMarcaModel>;

  TMarcaModel = class
  private
    [unsafe] mySelf: ITMarcaModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCODIGO_MAR: Variant;
    FID: Variant;
    FSIGLA: Variant;
    FUSUARIO_MAR: Variant;
    FNOME_MAR: Variant;
    FIDRecordView: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO_MAR(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetNOME_MAR(const Value: Variant);
    procedure SetSIGLA(const Value: Variant);
    procedure SetUSUARIO_MAR(const Value: Variant);
    procedure SetIDRecordView(const Value: String);

    public

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITMarcaModel;

    property CODIGO_MAR  :Variant read FCODIGO_MAR write SetCODIGO_MAR;
    property NOME_MAR    :Variant read FNOME_MAR write SetNOME_MAR;
    property USUARIO_MAR :Variant read FUSUARIO_MAR write SetUSUARIO_MAR;
    property ID          :Variant read FID write SetID;
    property SIGLA       :Variant read FSIGLA write SetSIGLA;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function Salvar : String;
    function Incluir: String;
    function carregaClasse(pId : String): ITMarcaModel;
    function Alterar(pID : String): ITMarcaModel;
    function Excluir(pID : String): String;

    function ObterLista(pMarca_Parametros: TMarca_Parametros): IFDDataset; overload;
    function ObterLista : IFDDataset; overload;

  end;

implementation

uses
  System.SysUtils, MarcaDao;

{ TMarcaModel }

function TMarcaModel.Alterar(pID: String): ITMarcaModel;
var
  lMarcaModel : ITMarcaModel;
begin
  lMarcaModel := TMarcaModel.getNewIface(vIConexao);
  try
    lMarcaModel       := lMarcaModel.objeto.carregaClasse(pID);
    lMarcaModel.objeto.Acao  := tacAlterar;
    Result            := lMarcaModel;
  finally
  end;
end;

function TMarcaModel.carregaClasse(pId: String): ITMarcaModel;
var
  lMarcaModel: ITMarcaModel;
begin
  lMarcaModel := TMarcaModel.getNewIface(vIConexao);

  try
    Result := lMarcaModel.objeto.carregaClasse(pId);
  finally
    lMarcaModel:=nil;
  end;
end;

constructor TMarcaModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TMarcaModel.Destroy;
begin
  inherited;
end;

function TMarcaModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

class function TMarcaModel.getNewIface(pIConexao: IConexao): ITMarcaModel;
begin
  Result := TImplObjetoOwner<TMarcaModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TMarcaModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TMarcaModel.ObterLista: IFDDataset;
var
  lMarca: ITMarcaDao;
begin
  lMarca := TMarcaDao.getNewIface(vIConexao);
  try
    lMarca.objeto.TotalRecords    := FTotalRecords;
    lMarca.objeto.WhereView       := FWhereView;
    lMarca.objeto.CountView       := FCountView;
    lMarca.objeto.OrderView       := FOrderView;
    lMarca.objeto.StartRecordView := FStartRecordView;
    lMarca.objeto.LengthPageView  := FLengthPageView;
    lMarca.objeto.IDRecordView    := FIDRecordView;

    Result := lMarca.objeto.obterLista;
    FTotalRecords := lMarca.objeto.TotalRecords;
  finally
    lMarca:=nil;
  end;
end;

function TMarcaModel.ObterLista(pMarca_Parametros: TMarca_Parametros): IFDDataset;
var
  lMarcaDao: ITMarcaDao;
  lMarca_Parametros: TMarca_Parametros;
begin
  lMarcaDao := TMarcaDao.getNewIface(vIConexao);

  try
    lMarca_Parametros.Marcas := pMarca_Parametros.Marcas;

    Result := lMarcaDao.objeto.ObterLista(lMarca_Parametros);

  finally
    lMarcaDao:=nil;
  end;
end;

function TMarcaModel.Salvar: String;
var
  lMarcaDao: ITMarcaDao;
begin
  lMarcaDao := TMarcaDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lMarcaDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lMarcaDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lMarcaDao.objeto.excluir(mySelf);
    end;
  finally
    lMarcaDao:=nil;
  end;
end;


procedure TMarcaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TMarcaModel.SetCODIGO_MAR(const Value: Variant);
begin
  FCODIGO_MAR := Value;
end;

procedure TMarcaModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMarcaModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMarcaModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TMarcaModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMarcaModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TMarcaModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TMarcaModel.SetNOME_MAR(const Value: Variant);
begin
  FNOME_MAR := Value;
end;

procedure TMarcaModel.SetSIGLA(const Value: Variant);
begin
  FSIGLA := Value;
end;

procedure TMarcaModel.SetUSUARIO_MAR(const Value: Variant);
begin
  FUSUARIO_MAR := Value;
end;

procedure TMarcaModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TMarcaModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
