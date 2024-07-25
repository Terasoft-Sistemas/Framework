unit GrupoComissaoFuncionarioModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type
  TGrupoComissaoFuncionarioModel = class

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
    FFUNCIONARIO_ID: Variant;
    FGRUPO_COMISSAO_ID: Variant;
    FID: Variant;
    FSYSTIME: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetFUNCIONARIO_ID(const Value: Variant);
    procedure SetGRUPO_COMISSAO_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetPERCENTUAL(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);

  public
    property ID                 : Variant read FID                 write SetID;
    property GRUPO_COMISSAO_ID  : Variant read FGRUPO_COMISSAO_ID  write SetGRUPO_COMISSAO_ID;
    property FUNCIONARIO_ID     : Variant read FFUNCIONARIO_ID     write SetFUNCIONARIO_ID;
    property PERCENTUAL         : Variant read FPERCENTUAL         write SetPERCENTUAL;
    property SYSTIME            : Variant read FSYSTIME            write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

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
    function carregaClasse(pId : String): TGrupoComissaoFuncionarioModel;
    function Alterar(pID : String): TGrupoComissaoFuncionarioModel;
    function Excluir(pID : String): String;

    function ObterLista : IFDDataset; overload;

  end;

implementation

uses
  System.SysUtils, GrupoComissaoFuncionarioDao;

{ TGrupoComissaoFuncionarioModel }

function TGrupoComissaoFuncionarioModel.Alterar(pID: String): TGrupoComissaoFuncionarioModel;
var
  lGrupoComissaoFuncionarioModel : TGrupoComissaoFuncionarioModel;
begin
  lGrupoComissaoFuncionarioModel := TGrupoComissaoFuncionarioModel.Create(vIConexao);
  try
    lGrupoComissaoFuncionarioModel       := lGrupoComissaoFuncionarioModel.carregaClasse(pID);
    lGrupoComissaoFuncionarioModel.Acao  := tacAlterar;
    Result                               := lGrupoComissaoFuncionarioModel;
  finally
  end;
end;

function TGrupoComissaoFuncionarioModel.carregaClasse(pId: String): TGrupoComissaoFuncionarioModel;
var
  lGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel;
begin
  lGrupoComissaoFuncionarioModel := TGrupoComissaoFuncionarioModel.Create(vIConexao);

  try
    Result := lGrupoComissaoFuncionarioModel.carregaClasse(pId);
  finally
    lGrupoComissaoFuncionarioModel.Free;
  end;
end;

constructor TGrupoComissaoFuncionarioModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoComissaoFuncionarioModel.Destroy;
begin
  vIConexao:=nil;
  inherited;
end;

function TGrupoComissaoFuncionarioModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TGrupoComissaoFuncionarioModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TGrupoComissaoFuncionarioModel.ObterLista: IFDDataset;
var
  lGrupoComissaoFuncionario: TGrupoComissaoFuncionarioDao;
begin
  lGrupoComissaoFuncionario := TGrupoComissaoFuncionarioDao.Create(vIConexao);
  try
    lGrupoComissaoFuncionario.TotalRecords    := FTotalRecords;
    lGrupoComissaoFuncionario.WhereView       := FWhereView;
    lGrupoComissaoFuncionario.CountView       := FCountView;
    lGrupoComissaoFuncionario.OrderView       := FOrderView;
    lGrupoComissaoFuncionario.StartRecordView := FStartRecordView;
    lGrupoComissaoFuncionario.LengthPageView  := FLengthPageView;
    lGrupoComissaoFuncionario.IDRecordView    := FIDRecordView;

    Result := lGrupoComissaoFuncionario.obterLista;
    FTotalRecords := lGrupoComissaoFuncionario.TotalRecords;
  finally
    lGrupoComissaoFuncionario.Free;
  end;
end;

function TGrupoComissaoFuncionarioModel.Salvar: String;
var
  lGrupoComissaoFuncionarioDao: TGrupoComissaoFuncionarioDao;
begin
  lGrupoComissaoFuncionarioDao := TGrupoComissaoFuncionarioDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lGrupoComissaoFuncionarioDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lGrupoComissaoFuncionarioDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lGrupoComissaoFuncionarioDao.excluir(Self);
    end;
  finally
    lGrupoComissaoFuncionarioDao.Free;
  end;
end;


procedure TGrupoComissaoFuncionarioModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetFUNCIONARIO_ID(
  const Value: Variant);
begin
  FFUNCIONARIO_ID := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetGRUPO_COMISSAO_ID(
  const Value: Variant);
begin
  FGRUPO_COMISSAO_ID := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TGrupoComissaoFuncionarioModel.SetPERCENTUAL(const Value: Variant);
begin
  FPERCENTUAL := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TGrupoComissaoFuncionarioModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TGrupoComissaoFuncionarioModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TGrupoComissaoFuncionarioModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
