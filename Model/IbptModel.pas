unit IbptModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TIBPTRetorno = record
    IMPOSTO_FEDERAL    : Double;
    IMPOSTO_ESTADUAL   : Double;
    IMPOSTO_MUNICIPAL  : Double;
    FONTE              : String;
    VERSAO             : String;
    CHAVE              : String;
  end;

  TIbptModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FOrderView: String;
    FWhereView: String;
    FVERSAO: Variant;
    FESTADUAL: Variant;
    FUF: Variant;
    FCODIGO: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FVIGENCIA_FIM: Variant;
    FVIGENCIA_INICIO: Variant;
    FIMPORTADOS_FEDERAL: Variant;
    FUTRIB: Variant;
    FMUNICIPAL: Variant;
    FNACIONAL_FEDERAL: Variant;
    FCHAVE: Variant;
    FTIPO: Variant;
    FFONTE: Variant;
    FEX: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetOrderView(const Value: String);
    procedure SetWhereView(const Value: String);
    procedure SetCHAVE(const Value: Variant);
    procedure SetCODIGO(const Value: Variant);
    procedure SetESTADUAL(const Value: Variant);
    procedure SetEX(const Value: Variant);
    procedure SetFONTE(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIMPORTADOS_FEDERAL(const Value: Variant);
    procedure SetMUNICIPAL(const Value: Variant);
    procedure SetNACIONAL_FEDERAL(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetUF(const Value: Variant);
    procedure SetUTRIB(const Value: Variant);
    procedure SetVERSAO(const Value: Variant);
    procedure SetVIGENCIA_FIM(const Value: Variant);
    procedure SetVIGENCIA_INICIO(const Value: Variant);

  public
    property ID                   : Variant read FID write SetID;
    property UF                   : Variant read FUF write SetUF;
    property CODIGO               : Variant read FCODIGO write SetCODIGO;
    property EX                   : Variant read FEX write SetEX;
    property TIPO                 : Variant read FTIPO write SetTIPO;
    property VIGENCIA_INICIO      : Variant read FVIGENCIA_INICIO write SetVIGENCIA_INICIO;
    property VIGENCIA_FIM         : Variant read FVIGENCIA_FIM write SetVIGENCIA_FIM;
    property NACIONAL_FEDERAL     : Variant read FNACIONAL_FEDERAL write SetNACIONAL_FEDERAL;
    property IMPORTADOS_FEDERAL   : Variant read FIMPORTADOS_FEDERAL write SetIMPORTADOS_FEDERAL;
    property ESTADUAL             : Variant read FESTADUAL write SetESTADUAL;
    property MUNICIPAL            : Variant read FMUNICIPAL write SetMUNICIPAL;
    property CHAVE                : Variant read FCHAVE write SetCHAVE;
    property VERSAO               : Variant read FVERSAO write SetVERSAO;
    property FONTE                : Variant read FFONTE write SetFONTE;
    property UTRIB                : Variant read FUTRIB write SetUTRIB;
    property SYSTIME              : Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir: String;
    function Alterar(pID : String): TIbptModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): TIbptModel;
    function obterIBPT(pUf, pOrigem, pNCM : String): TIBPTRetorno;

    property Acao :TAcao read FAcao write SetAcao;
    property WhereView: String read FWhereView write SetWhereView;
    property OrderView: String read FOrderView write SetOrderView;
  end;

implementation

uses
  IbptDao,  
  System.Classes, 
  System.SysUtils, Terasoft.Configuracoes;

{ TIbptModel }

function TIbptModel.Alterar(pID: String): TIbptModel;
var
  lIbptModel : TIbptModel;
begin
  lIbptModel := TIbptModel.Create(vIConexao);
  try
    lIbptModel       := lIbptModel.carregaClasse(pID);
    lIbptModel.Acao  := tacAlterar;
    Result            := lIbptModel;
  finally
  end;
end;

function TIbptModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TIbptModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TIbptModel.carregaClasse(pId : String): TIbptModel;
var
  lIbptDao: TIbptDao;
begin
  lIbptDao := TIbptDao.Create(vIConexao);

  try
    Result := lIbptDao.carregaClasse(pId);
  finally
    lIbptDao.Free;
  end;
end;

constructor TIbptModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TIbptModel.Destroy;
begin
  inherited;
end;

function TIbptModel.obterIBPT(pUf, pOrigem, pNCM : String): TIBPTRetorno;
var
  lIbptDao       : TIbptDao;
  lTable         : IFDDataset;
  lConfiguracoes : TerasoftConfiguracoes;

begin
  lIbptDao := TIbptDao.Create(vIConexao);

  try
    lIbptDao.WhereView       := FWhereView;
    lIbptDao.OrderView       := FOrderView;

    lTable := lIbptDao.obterIBPT(pUf, pNCM);

    if lTable.objeto.RecordCount = 0 then
      exit;

    if (pOrigem = 'I') or (pOrigem = '6') then
      Result.IMPOSTO_FEDERAL := lTable.objeto.FieldByName('importados_federal').AsFloat
    else
      Result.IMPOSTO_FEDERAL := lTable.objeto.FieldByName('nacional_federal').AsFloat;

    Result.IMPOSTO_ESTADUAL  := lTable.objeto.FieldByName('estadual').AsFloat;
    Result.IMPOSTO_MUNICIPAL := lTable.objeto.FieldByName('municipal').AsFloat;

    Result.FONTE  := lTable.objeto.FieldByName('fonte').AsString;
    Result.VERSAO := lTable.objeto.FieldByName('versao').AsString;
    Result.CHAVE  := lTable.objeto.FieldByName('chave').AsString;

    lConfiguracoes := vIConexao.getTerasoftConfiguracoes as TerasoftConfiguracoes;

    if lConfiguracoes.valorTag('PERCENTUAL_IBPT_FEDERAL', 0, tvNumero) > 0 then
      Result.IMPOSTO_FEDERAL :=  lConfiguracoes.valorTag('PERCENTUAL_IBPT_FEDERAL', 0, tvNumero);

    if lConfiguracoes.valorTag('PERCENTUAL_IBPT_ESTADUAL', 0, tvNumero) > 0 then
      Result.IMPOSTO_ESTADUAL :=  lConfiguracoes.valorTag('PERCENTUAL_IBPT_ESTADUAL', 0, tvNumero);

  finally
    lIbptDao.Free;
  end;
end;

function TIbptModel.Salvar: String;
var
  lIbptDao: TIbptDao;
begin
  lIbptDao := TIbptDao.Create(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lIbptDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lIbptDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lIbptDao.excluir(Self);
    end;
  finally
    lIbptDao.Free;
  end;
end;

procedure TIbptModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TIbptModel.SetCHAVE(const Value: Variant);
begin
  FCHAVE := Value;
end;

procedure TIbptModel.SetCODIGO(const Value: Variant);
begin
  FCODIGO := Value;
end;

procedure TIbptModel.SetESTADUAL(const Value: Variant);
begin
  FESTADUAL := Value;
end;

procedure TIbptModel.SetEX(const Value: Variant);
begin
  FEX := Value;
end;

procedure TIbptModel.SetFONTE(const Value: Variant);
begin
  FFONTE := Value;
end;

procedure TIbptModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TIbptModel.SetIMPORTADOS_FEDERAL(const Value: Variant);
begin
  FIMPORTADOS_FEDERAL := Value;
end;

procedure TIbptModel.SetMUNICIPAL(const Value: Variant);
begin
  FMUNICIPAL := Value;
end;

procedure TIbptModel.SetNACIONAL_FEDERAL(const Value: Variant);
begin
  FNACIONAL_FEDERAL := Value;
end;

procedure TIbptModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TIbptModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TIbptModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TIbptModel.SetUF(const Value: Variant);
begin
  FUF := Value;
end;

procedure TIbptModel.SetUTRIB(const Value: Variant);
begin
  FUTRIB := Value;
end;

procedure TIbptModel.SetVERSAO(const Value: Variant);
begin
  FVERSAO := Value;
end;

procedure TIbptModel.SetVIGENCIA_FIM(const Value: Variant);
begin
  FVIGENCIA_FIM := Value;
end;

procedure TIbptModel.SetVIGENCIA_INICIO(const Value: Variant);
begin
  FVIGENCIA_INICIO := Value;
end;

procedure TIbptModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
