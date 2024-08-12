unit GrupoComissaoModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TGrupoComissaoModel = class;
  ITGrupoComissaoModel=IObject<TGrupoComissaoModel>;

  TGrupoComissaoModel = class
  private
    [weak] mySelf: ITGrupoComissaoModel;
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPERCENTUAL: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FNOME: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetPERCENTUAL(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);


    public

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITGrupoComissaoModel;

    property ID         :Variant read FID write SetID;
    property NOME       :Variant read FNOME write SetNOME;
    property PERCENTUAL :Variant read FPERCENTUAL write SetPERCENTUAL;
    property SYSTIME    :Variant read FSYSTIME write SetSYSTIME;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function Salvar : String;
    function Incluir: String;
    function carregaClasse(pId : String): ITGrupoComissaoModel;
    function Alterar(pID : String): ITGrupoComissaoModel;
    function Excluir(pID : String): String;
    function ObterGrupoComissaoProduto (pProduto : String) : Double;

    function ObterLista : IFDDataset; overload;

  end;

implementation

uses
  System.SysUtils, GrupoComissaoDao;

{ TGrupoComissaoModel }

function TGrupoComissaoModel.Alterar(pID: String): ITGrupoComissaoModel;
var
  lGrupoComissaoModel : ITGrupoComissaoModel;
begin
  lGrupoComissaoModel := TGrupoComissaoModel.getNewIface(vIConexao);
  try
    lGrupoComissaoModel       := lGrupoComissaoModel.objeto.carregaClasse(pID);
    lGrupoComissaoModel.objeto.Acao  := tacAlterar;
    Result                    := lGrupoComissaoModel;
  finally
  end;
end;

function TGrupoComissaoModel.carregaClasse(pId: String): ITGrupoComissaoModel;
var
  lGrupoComissaoModel: ITGrupoComissaoModel;
begin
  lGrupoComissaoModel := TGrupoComissaoModel.getNewIface(vIConexao);

  try
    Result := lGrupoComissaoModel.objeto.carregaClasse(pId);
  finally
    lGrupoComissaoModel:=nil;
  end;
end;

constructor TGrupoComissaoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoComissaoModel.Destroy;
begin
  vIConexao:=nil;
  inherited;
end;

function TGrupoComissaoModel.Excluir(pID: String): String;
begin
  self.ID    := pID;
  self.FAcao := tacExcluir;
  Result     := self.Salvar;
end;

class function TGrupoComissaoModel.getNewIface(pIConexao: IConexao): ITGrupoComissaoModel;
begin
  Result := TImplObjetoOwner<TGrupoComissaoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TGrupoComissaoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TGrupoComissaoModel.ObterGrupoComissaoProduto(pProduto: String): Double;
  var
  lGrupoComissao: ITGrupoComissaoDao;
begin
  lGrupoComissao := TGrupoComissaoDao.getNewIface(vIConexao);
  try
    Result := lGrupoComissao.objeto.ObterGrupoComissaoProduto(pProduto);
  finally
    lGrupoComissao:=nil;
  end;
end;

function TGrupoComissaoModel.ObterLista: IFDDataset;
var
  lGrupoComissao: ITGrupoComissaoDao;
begin
  lGrupoComissao := TGrupoComissaoDao.getNewIface(vIConexao);
  try
    lGrupoComissao.objeto.TotalRecords    := FTotalRecords;
    lGrupoComissao.objeto.WhereView       := FWhereView;
    lGrupoComissao.objeto.CountView       := FCountView;
    lGrupoComissao.objeto.OrderView       := FOrderView;
    lGrupoComissao.objeto.StartRecordView := FStartRecordView;
    lGrupoComissao.objeto.LengthPageView  := FLengthPageView;
    lGrupoComissao.objeto.IDRecordView    := FIDRecordView;

    Result := lGrupoComissao.objeto.obterLista;
    FTotalRecords := lGrupoComissao.objeto.TotalRecords;
  finally
    lGrupoComissao:=nil;
  end;
end;

function TGrupoComissaoModel.Salvar: String;
var
  lGrupoComissaoDao: ITGrupoComissaoDao;
begin
  lGrupoComissaoDao := TGrupoComissaoDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lGrupoComissaoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lGrupoComissaoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lGrupoComissaoDao.objeto.excluir(mySelf);
    end;
  finally
    lGrupoComissaoDao:=nil;
  end;
end;


procedure TGrupoComissaoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TGrupoComissaoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoComissaoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoComissaoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoComissaoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoComissaoModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TGrupoComissaoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TGrupoComissaoModel.SetPERCENTUAL(const Value: Variant);
begin
  FPERCENTUAL := Value;
end;

procedure TGrupoComissaoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TGrupoComissaoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TGrupoComissaoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TGrupoComissaoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
