unit GrupoComissaoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TGrupoComissaoModel = class

  private
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

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;


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
    function carregaClasse(pId : String): TGrupoComissaoModel;
    function Alterar(pID : String): TGrupoComissaoModel;
    function Excluir(pID : String): String;

    function ObterLista : TFDMemTable; overload;

  end;

implementation

uses
  System.SysUtils, GrupoComissaoDao;

{ TGrupoComissaoModel }

function TGrupoComissaoModel.Alterar(pID: String): TGrupoComissaoModel;
var
  lGrupoComissaoModel : TGrupoComissaoModel;
begin
  lGrupoComissaoModel := TGrupoComissaoModel.Create(vIConexao);
  try
    lGrupoComissaoModel       := lGrupoComissaoModel.carregaClasse(pID);
    lGrupoComissaoModel.Acao  := tacAlterar;
    Result            := lGrupoComissaoModel;
  finally
  end;
end;

function TGrupoComissaoModel.carregaClasse(pId: String): TGrupoComissaoModel;
var
  lGrupoComissaoModel: TGrupoComissaoModel;
begin
  lGrupoComissaoModel := TGrupoComissaoModel.Create(vIConexao);

  try
    Result := lGrupoComissaoModel.carregaClasse(pId);
  finally
    lGrupoComissaoModel.Free;
  end;
end;

constructor TGrupoComissaoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoComissaoModel.Destroy;
begin
  inherited;
end;

function TGrupoComissaoModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TGrupoComissaoModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TGrupoComissaoModel.ObterLista: TFDMemTable;
var
  lGrupoComissao: TGrupoComissaoDao;
begin
  lGrupoComissao := TGrupoComissaoDao.Create(vIConexao);
  try
    lGrupoComissao.TotalRecords    := FTotalRecords;
    lGrupoComissao.WhereView       := FWhereView;
    lGrupoComissao.CountView       := FCountView;
    lGrupoComissao.OrderView       := FOrderView;
    lGrupoComissao.StartRecordView := FStartRecordView;
    lGrupoComissao.LengthPageView  := FLengthPageView;
    lGrupoComissao.IDRecordView    := FIDRecordView;

    Result := lGrupoComissao.obterLista;
    FTotalRecords := lGrupoComissao.TotalRecords;
  finally
    lGrupoComissao.Free;
  end;
end;

function TGrupoComissaoModel.Salvar: String;
var
  lGrupoComissaoDao: TGrupoComissaoDao;
begin
  lGrupoComissaoDao := TGrupoComissaoDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lGrupoComissaoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lGrupoComissaoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lGrupoComissaoDao.excluir(Self);
    end;
  finally
    lGrupoComissaoDao.Free;
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
