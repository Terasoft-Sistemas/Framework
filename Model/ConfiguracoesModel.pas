unit ConfiguracoesModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  System.StrUtils,
  System.SysUtils,
  Terasoft.Utils,
  ConfiguracoesLocaisModel;

type
  TConfiguracoesModel = class;
  ITConfiguracoesModel=IObject<TConfiguracoesModel>;

  TConfiguracoesModel = class
  private
    [weak] mySelf: ITConfiguracoesModel;
    vIConexao : IConexao;

    FConfiguracoessLista: IList<ITConfiguracoesModel>;
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
    FSYSTIME: Variant;
    FVALORNUMERICO: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetConfiguracoessLista(const Value: IList<ITConfiguracoesModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetF_ID(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetPERFIL_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTAG(const Value: Variant);
    procedure SetVALORCHAR(const Value: Variant);
    procedure SetVALORDATA(const Value: Variant);
    procedure SetVALORDATAHORA(const Value: Variant);
    procedure SetVALORHORA(const Value: Variant);
    procedure SetVALORINTEIRO(const Value: Variant);
    procedure SetVALORMEMO(const Value: Variant);
    procedure SetVALORNUMERICO(const Value: Variant);
    procedure SetVALORSTRING(const Value: Variant);

  public
    property ID: Variant read FID write SetID;
    property TAG: Variant read FTAG write SetTAG;
    property F_ID: Variant read FF_ID write SetF_ID;
    property PERFIL_ID: Variant read FPERFIL_ID write SetPERFIL_ID;
    property VALORINTEIRO: Variant read FVALORINTEIRO write SetVALORINTEIRO;
    property VALORSTRING: Variant read FVALORSTRING write SetVALORSTRING;
    property VALORMEMO: Variant read FVALORMEMO write SetVALORMEMO;
    property VALORNUMERICO: Variant read FVALORNUMERICO write SetVALORNUMERICO;
    property VALORCHAR: Variant read FVALORCHAR write SetVALORCHAR;
    property VALORDATA: Variant read FVALORDATA write SetVALORDATA;
    property VALORHORA: Variant read FVALORHORA write SetVALORHORA;
    property VALORDATAHORA: Variant read FVALORDATAHORA write SetVALORDATAHORA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITConfiguracoesModel;

    function carregaClasse(pId : String): ITConfiguracoesModel;

    function Salvar: String;
    procedure obterLista;
    procedure gravaValorTagConfig(pTag: String; pTipoValor: TTipoValorConfiguracao; pValor: Variant; pPerfil: String = ''; pLocal: boolean = True);

    property ConfiguracoessLista: IList<ITConfiguracoesModel> read FConfiguracoessLista write SetConfiguracoessLista;
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
  Terasoft.Framework.LOG,
  ConfiguracoesDao;

{ TConfiguracoesModel }

constructor TConfiguracoesModel._Create(pIConexao : IConexao);
begin
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TConfiguracoesModel._Create',LOG_LEVEL_DEBUG);
  vIConexao := pIConexao;
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TConfiguracoesModel._Create: Saindo do _Create',LOG_LEVEL_DEBUG);
end;

function TConfiguracoesModel.carregaClasse(pId: String): ITConfiguracoesModel;
var
  lConfiguracoesDao: ITConfiguracoesDao;
begin
  lConfiguracoesDao := TConfiguracoesDao.getNewIface(vIConexao);
  try
    Result := lConfiguracoesDao.objeto.carregaClasse(pId);
  finally
    lConfiguracoesDao := nil;
  end;
end;

destructor TConfiguracoesModel.Destroy;
begin
  FConfiguracoessLista := nil;
  vIConexao := nil;
  inherited;
end;

class function TConfiguracoesModel.getNewIface(pIConexao: IConexao): ITConfiguracoesModel;
begin
  Result := TImplObjetoOwner<TConfiguracoesModel>.CreateOwner(self._Create(pIConexao));
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TConfiguracoesModel.getNewIface: Atribuindo Result para myself',LOG_LEVEL_DEBUG);
  Result.objeto.myself := Result;
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TConfiguracoesModel.getNewIface: Saindo do getNewIface',LOG_LEVEL_DEBUG);
end;

procedure TConfiguracoesModel.obterLista;
var
  lConfiguracoesLista: ITConfiguracoesDao;
begin
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TerasoftConfiguracoes.carregarConfiguracoes: Criando TConfiguracoesDao',LOG_LEVEL_DEBUG);
  lConfiguracoesLista := TConfiguracoesDao.getNewIface(vIConexao);

  try
    lConfiguracoesLista.objeto.TotalRecords    := FTotalRecords;
    lConfiguracoesLista.objeto.WhereView       := FWhereView;
    lConfiguracoesLista.objeto.CountView       := FCountView;
    lConfiguracoesLista.objeto.OrderView       := FOrderView;
    lConfiguracoesLista.objeto.StartRecordView := FStartRecordView;
    lConfiguracoesLista.objeto.LengthPageView  := FLengthPageView;
    lConfiguracoesLista.objeto.IDRecordView    := FIDRecordView;

    lConfiguracoesLista.objeto.obterLista;

    FTotalRecords := lConfiguracoesLista.objeto.TotalRecords;
    FConfiguracoessLista := lConfiguracoesLista.objeto.ConfiguracoessLista;

    logaByTagSeNivel(TAGLOG_CONDICIONAL, format('TConfiguracoesModel.obterLista: %d registros',[FTotalRecords]),LOG_LEVEL_DEBUG);
    logaMemoriaEmUso;

  finally
    lConfiguracoesLista:=nil;
  end;
end;

function TConfiguracoesModel.Salvar: String;
var
  lConfiguracoesDao: ITConfiguracoesDao;
begin
  lConfiguracoesDao := TConfiguracoesDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lConfiguracoesDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lConfiguracoesDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lConfiguracoesDao.objeto.excluir(mySelf);
    end;

  finally
    lConfiguracoesDao:=nil;
  end;
end;

procedure TConfiguracoesModel.gravaValorTagConfig(pTag: String; pTipoValor: TTipoValorConfiguracao; pValor: Variant; pPerfil: String = ''; pLocal: boolean = True);
var
  lNomeCampo, lPerf: String;
  lConfiguracoesLocaisModel : ITConfiguracoesLocaisModel;
  lConfiguracoesModel : ITConfiguracoesModel;
  lDataSet : IFDDataset;
begin

  lConfiguracoesLocaisModel := TConfiguracoesLocaisModel.getNewIface(vIConexao);
  lConfiguracoesModel       := TConfiguracoesModel.getNewIface(vIConexao);

  try
    lPerf := ifThen(pPerfil = '', 'ZZZZZZ', pPerfil);
    pTag  := UpperCase(trim(pTag));

    if pLocal then
    begin
      lConfiguracoesLocaisModel.objeto.WhereView := 'AND CONFIGURACOESLOCAIS.TAG = '+ QuotedStr(pTag);
      lDataSet := lConfiguracoesLocaisModel.objeto.ObterLista;

      if lDataSet.objeto.RecordCount > 0 then
        lConfiguracoesLocaisModel := lConfiguracoesLocaisModel.objeto.Alterar(QuotedStr(lDataSet.objeto.FieldByName('ID').AsString));

      case pTipoValor of
        tvInteiro  : lConfiguracoesLocaisModel.objeto.VALORINTEIRO  := pValor;
        tvNumero   : lConfiguracoesLocaisModel.objeto.VALORNUMERICO := CurrToStr(pValor);
        tvString   : lConfiguracoesLocaisModel.objeto.VALORSTRING   := pValor;
        tvMemo     : lConfiguracoesLocaisModel.objeto.VALORMEMO     := pValor;
        tvData     : lConfiguracoesLocaisModel.objeto.VALORDATA     := pValor;
        tvHora     : lConfiguracoesLocaisModel.objeto.VALORHORA     := pValor;
        tvDataHora : lConfiguracoesLocaisModel.objeto.VALORDATAHORA := pValor;
        tvChar,
        tvBool     : lConfiguracoesLocaisModel.objeto.VALORCHAR     := pValor;
      end;

      if lDataSet.objeto.RecordCount > 0 then
        lConfiguracoesLocaisModel.objeto.Salvar
      else begin
        lConfiguracoesLocaisModel.objeto.TAG       := pTag;
        lConfiguracoesLocaisModel.objeto.F_ID      := lPerf;
        lConfiguracoesLocaisModel.objeto.PERFIL_ID := pPerfil;
        lConfiguracoesLocaisModel.objeto.Incluir;
      end;
    end
    else
    begin
      lConfiguracoesModel.objeto.WhereView := 'AND CONFIGURACOES.TAG = '+ QuotedStr(pTag);
      lConfiguracoesModel.objeto.ObterLista;

      if lConfiguracoesModel.objeto.ConfiguracoessLista.Count > 0 then
        lConfiguracoesModel := lConfiguracoesModel.objeto.carregaClasse(QuotedStr(lConfiguracoesModel.objeto.ConfiguracoessLista[0].objeto.ID));

      case pTipoValor of
        tvInteiro  : lConfiguracoesModel.objeto.VALORINTEIRO  := pValor;
        tvNumero   : lConfiguracoesModel.objeto.VALORNUMERICO := CurrToStr(pValor);
        tvString   : lConfiguracoesModel.objeto.VALORSTRING   := pValor;
        tvMemo     : lConfiguracoesModel.objeto.VALORMEMO     := pValor;
        tvData     : lConfiguracoesModel.objeto.VALORDATA     := pValor;
        tvHora     : lConfiguracoesModel.objeto.VALORHORA     := pValor;
        tvDataHora : lConfiguracoesModel.objeto.VALORDATAHORA := pValor;
        tvChar,
        tvBool     : lConfiguracoesModel.objeto.VALORCHAR     := pValor;
      end;

      if lConfiguracoesModel.objeto.ID <> '' then
        lConfiguracoesModel.objeto.Acao := tacAlterar
      else begin
        lConfiguracoesModel.objeto.TAG       := pTag;
        lConfiguracoesModel.objeto.F_ID      := lPerf;
        lConfiguracoesModel.objeto.PERFIL_ID := pPerfil;
        lConfiguracoesModel.objeto.Acao      := tacIncluir;
      end;

      lConfiguracoesModel.objeto.Salvar;
    end;

  finally
    lConfiguracoesLocaisModel := nil;
    lConfiguracoesModel := nil;
  end;

end;

procedure TConfiguracoesModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TConfiguracoesModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TConfiguracoesModel.SetF_ID(const Value: Variant);
begin
  FF_ID := Value;
end;

procedure TConfiguracoesModel.SetConfiguracoessLista;
begin
  FConfiguracoessLista := Value;
end;

procedure TConfiguracoesModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TConfiguracoesModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TConfiguracoesModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TConfiguracoesModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TConfiguracoesModel.SetPERFIL_ID(const Value: Variant);
begin
  FPERFIL_ID := Value;
end;

procedure TConfiguracoesModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TConfiguracoesModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TConfiguracoesModel.SetTAG(const Value: Variant);
begin
  FTAG := Value;
end;

procedure TConfiguracoesModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TConfiguracoesModel.SetVALORCHAR(const Value: Variant);
begin
  FVALORCHAR := Value;
end;

procedure TConfiguracoesModel.SetVALORDATA(const Value: Variant);
begin
  FVALORDATA := Value;
end;

procedure TConfiguracoesModel.SetVALORDATAHORA(const Value: Variant);
begin
  FVALORDATAHORA := Value;
end;

procedure TConfiguracoesModel.SetVALORHORA(const Value: Variant);
begin
  FVALORHORA := Value;
end;

procedure TConfiguracoesModel.SetVALORINTEIRO(const Value: Variant);
begin
  FVALORINTEIRO := Value;
end;

procedure TConfiguracoesModel.SetVALORMEMO(const Value: Variant);
begin
  FVALORMEMO := Value;
end;

procedure TConfiguracoesModel.SetVALORNUMERICO(const Value: Variant);
begin
  FVALORNUMERICO := Value;
end;

procedure TConfiguracoesModel.SetVALORSTRING(const Value: Variant);
begin
  FVALORSTRING := Value;
end;

procedure TConfiguracoesModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
