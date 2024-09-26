unit IbptModel;

interface

uses
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
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

  TIBPTModel  = class;
  ITIBPTModel = IObject<TIBPTModel>;

  TIBPTModel = class
  private
    [unsafe] mySelf: ITIBPTModel;
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

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITIBPTModel;

    function Incluir: String;
    function Alterar(pID : String): ITIbptModel;
    function Excluir(pID : String): String;
    function Salvar : String;

    function carregaClasse(pId : String): ITIbptModel;
    function obterIBPT(pUf, pOrigem, pNCM : String): TIBPTRetorno;

    function chaveIBPT: String;
    function fonteIBPT: String;

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

function TIBPTModel.Alterar(pID: String): ITIbptModel;
var
  lIbptModel : ITIbptModel;
begin
  lIbptModel := TIbptModel.getNewIface(vIConexao);
  try
    lIbptModel       := lIbptModel.objeto.carregaClasse(pID);
    lIbptModel.objeto.Acao  := tacAlterar;
    Result            := lIbptModel;
  finally
  end;
end;

function TIBPTModel.Excluir(pID: String): String;
begin
  self.ID      := pID;
  self.FAcao   := tacExcluir;
  Result       := self.Salvar;
end;

function TIBPTModel.fonteIBPT: String;
var
  lIbptDao: ITIBPTDao;
begin
  lIbptDao := TIbptDao.getNewIface(vIConexao);

  try
    Result := lIbptDao.objeto.fonteIBPT;
  finally
    lIbptDao := nil;
  end;
end;

class function TIBPTModel.getNewIface(pIConexao: IConexao): ITIBPTModel;
begin
  Result := TImplObjetoOwner<TIBPTModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TIBPTModel.Incluir: String;
begin
    self.Acao := tacIncluir;
    Result    := self.Salvar;
end;

function TIBPTModel.carregaClasse(pId : String): ITIbptModel;
var
  lIbptDao: ITIBPTDao;
begin
  lIbptDao := TIbptDao.getNewIface(vIConexao);

  try
    Result := lIbptDao.objeto.carregaClasse(pId);
  finally
    lIbptDao := nil;
  end;
end;

function TIBPTModel.chaveIBPT: String;
var
  lIbptDao: ITIBPTDao;
begin
  lIbptDao := TIbptDao.getNewIface(vIConexao);

  try
    Result := lIbptDao.objeto.chaveIBPT;
  finally
    lIbptDao := nil;
  end;
end;

constructor TIBPTModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TIBPTModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TIBPTModel.obterIBPT(pUf, pOrigem, pNCM : String): TIBPTRetorno;
var
  lIbptDao       : ITIbptDao;
  lTable         : IFDDataset;
  lConfiguracoes : ITerasoftConfiguracoes;

begin
  lIbptDao := TIbptDao.getNewIface(vIConexao);

  try
    lIbptDao.objeto.WhereView       := FWhereView;
    lIbptDao.objeto.OrderView       := FOrderView;

    lTable := lIbptDao.objeto.obterIBPT(pUf, pNCM);

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

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    if lConfiguracoes.objeto.valorTag('PERCENTUAL_IBPT_FEDERAL', 0, tvNumero) > 0 then
      Result.IMPOSTO_FEDERAL :=  lConfiguracoes.objeto.valorTag('PERCENTUAL_IBPT_FEDERAL', 0, tvNumero);

    if lConfiguracoes.objeto.valorTag('PERCENTUAL_IBPT_ESTADUAL', 0, tvNumero) > 0 then
      Result.IMPOSTO_ESTADUAL :=  lConfiguracoes.objeto.valorTag('PERCENTUAL_IBPT_ESTADUAL', 0, tvNumero);

  finally
    lIbptDao := nil;
  end;
end;

function TIBPTModel.Salvar: String;
var
  lIbptDao: ITIbptDao;
begin
  lIbptDao := TIbptDao.getNewIface(vIConexao);
  Result := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lIbptDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lIbptDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lIbptDao.objeto.excluir(mySelf);
    end;
  finally
    lIbptDao := nil;
  end;
end;

procedure TIBPTModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TIBPTModel.SetCHAVE(const Value: Variant);
begin
  FCHAVE := Value;
end;

procedure TIBPTModel.SetCODIGO(const Value: Variant);
begin
  FCODIGO := Value;
end;

procedure TIBPTModel.SetESTADUAL(const Value: Variant);
begin
  FESTADUAL := Value;
end;

procedure TIBPTModel.SetEX(const Value: Variant);
begin
  FEX := Value;
end;

procedure TIBPTModel.SetFONTE(const Value: Variant);
begin
  FFONTE := Value;
end;

procedure TIBPTModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TIBPTModel.SetIMPORTADOS_FEDERAL(const Value: Variant);
begin
  FIMPORTADOS_FEDERAL := Value;
end;

procedure TIBPTModel.SetMUNICIPAL(const Value: Variant);
begin
  FMUNICIPAL := Value;
end;

procedure TIBPTModel.SetNACIONAL_FEDERAL(const Value: Variant);
begin
  FNACIONAL_FEDERAL := Value;
end;

procedure TIBPTModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TIBPTModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TIBPTModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TIBPTModel.SetUF(const Value: Variant);
begin
  FUF := Value;
end;

procedure TIBPTModel.SetUTRIB(const Value: Variant);
begin
  FUTRIB := Value;
end;

procedure TIBPTModel.SetVERSAO(const Value: Variant);
begin
  FVERSAO := Value;
end;

procedure TIBPTModel.SetVIGENCIA_FIM(const Value: Variant);
begin
  FVIGENCIA_FIM := Value;
end;

procedure TIBPTModel.SetVIGENCIA_INICIO(const Value: Variant);
begin
  FVIGENCIA_INICIO := Value;
end;

procedure TIBPTModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
