unit PromocaoModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TPromocaoModel = class;
  ITPromocaoModel=IObject<TPromocaoModel>;

  TPromocaoModel = class
  private
    [unsafe] mySelf: ITPromocaoModel;
    vIConexao : IConexao;
    FPromocaosLista: IList<ITPromocaoModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FQUARTA: Variant;
    FTIPO_ABATIMENTO: Variant;
    FSABADO: Variant;
    FQUINTA: Variant;
    FPRECO_VENDA_ID: Variant;
    FPORTADOR_ID: Variant;
    FSEGUNDA: Variant;
    FDESCRICAO: Variant;
    FDOMINGO: Variant;
    FCLIENTE_ID: Variant;
    FID: Variant;
    FDATAFIM: Variant;
    FLOJA: Variant;
    FDATAINICIO: Variant;
    FTERCA: Variant;
    FSYSTIME: Variant;
    FHORAFIM: Variant;
    FHORAINICIO: Variant;
    FSEXTA: Variant;
    FDATA: Variant;
    FIDRecordView: String;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPromocaosLista(const Value: IList<ITPromocaoModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCLIENTE_ID(const Value: Variant);
    procedure SetDATA(const Value: Variant);
    procedure SetDATAFIM(const Value: Variant);
    procedure SetDATAINICIO(const Value: Variant);
    procedure SetDESCRICAO(const Value: Variant);
    procedure SetDOMINGO(const Value: Variant);
    procedure SetHORAFIM(const Value: Variant);
    procedure SetHORAINICIO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetPRECO_VENDA_ID(const Value: Variant);
    procedure SetQUARTA(const Value: Variant);
    procedure SetQUINTA(const Value: Variant);
    procedure SetSABADO(const Value: Variant);
    procedure SetSEGUNDA(const Value: Variant);
    procedure SetSEXTA(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTERCA(const Value: Variant);
    procedure SetTIPO_ABATIMENTO(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
  public
    property ID: Variant read FID write SetID;
    property DESCRICAO: Variant read FDESCRICAO write SetDESCRICAO;
    property DATA: Variant read FDATA write SetDATA;
    property DATAINICIO: Variant read FDATAINICIO write SetDATAINICIO;
    property DATAFIM: Variant read FDATAFIM write SetDATAFIM;
    property CLIENTE_ID: Variant read FCLIENTE_ID write SetCLIENTE_ID;
    property PRECO_VENDA_ID: Variant read FPRECO_VENDA_ID write SetPRECO_VENDA_ID;
    property HORAINICIO: Variant read FHORAINICIO write SetHORAINICIO;
    property HORAFIM: Variant read FHORAFIM write SetHORAFIM;
    property DOMINGO: Variant read FDOMINGO write SetDOMINGO;
    property SEGUNDA: Variant read FSEGUNDA write SetSEGUNDA;
    property TERCA: Variant read FTERCA write SetTERCA;
    property QUARTA: Variant read FQUARTA write SetQUARTA;
    property QUINTA: Variant read FQUINTA write SetQUINTA;
    property SEXTA: Variant read FSEXTA write SetSEXTA;
    property SABADO: Variant read FSABADO write SetSABADO;
    property PORTADOR_ID: Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property LOJA: Variant read FLOJA write SetLOJA;
    property TIPO_ABATIMENTO: Variant read FTIPO_ABATIMENTO write SetTIPO_ABATIMENTO;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPromocaoModel;

    function Incluir: String;
    function Alterar(pID : String) : ITPromocaoModel;
    function Excluir(pID : String) : String;
    function Salvar: String;
    function carregaClasse(pID : String) : ITPromocaoModel;
    procedure obterLista;

    property PromocaosLista: IList<ITPromocaoModel> read FPromocaosLista write SetPromocaosLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  PromocaoDao;

{ TPromocaoModel }

function TPromocaoModel.Alterar(pID: String): ITPromocaoModel;
var
  lPromocaoModel : ITPromocaoModel;
begin
  lPromocaoModel := TPromocaoModel.getNewIface(vIConexao);
  try
    lPromocaoModel      := lPromocaoModel.objeto.carregaClasse(pID);
    lPromocaoModel.objeto.Acao := tacAlterar;
    Result              := lPromocaoModel;
  finally
  end;
end;

function TPromocaoModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TPromocaoModel.getNewIface(pIConexao: IConexao): ITPromocaoModel;
begin
  Result := TImplObjetoOwner<TPromocaoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPromocaoModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  self.Salvar;
end;

function TPromocaoModel.carregaClasse(pID: String): ITPromocaoModel;
var
  lPromocaoDao: ITPromocaoDao;
begin
  lPromocaoDao := TPromocaoDao.getNewIface(vIConexao);
  try
    Result  := lPromocaoDao.objeto.carregaClasse(pId);
  finally
    lPromocaoDao:=nil;
  end;
end;

constructor TPromocaoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPromocaoModel.Destroy;
begin
  FPromocaosLista := nil;
  vIConexao := nil;
  inherited;
end;

procedure TPromocaoModel.obterLista;
var
  lPromocaoLista: ITPromocaoDao;
begin
  lPromocaoLista := TPromocaoDao.getNewIface(vIConexao);

  try
    lPromocaoLista.objeto.TotalRecords    := FTotalRecords;
    lPromocaoLista.objeto.WhereView       := FWhereView;
    lPromocaoLista.objeto.CountView       := FCountView;
    lPromocaoLista.objeto.OrderView       := FOrderView;
    lPromocaoLista.objeto.StartRecordView := FStartRecordView;
    lPromocaoLista.objeto.LengthPageView  := FLengthPageView;
    lPromocaoLista.objeto.IDRecordView    := FIDRecordView;

    lPromocaoLista.objeto.obterLista;

    FTotalRecords  := lPromocaoLista.objeto.TotalRecords;
    FPromocaosLista := lPromocaoLista.objeto.PromocaosLista;

  finally
    lPromocaoLista:=nil;
  end;
end;

function TPromocaoModel.Salvar: String;
var
  lPromocaoDao: ITPromocaoDao;
begin
  lPromocaoDao := TPromocaoDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lPromocaoDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lPromocaoDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lPromocaoDao.objeto.excluir(mySelf);
    end;

  finally
    lPromocaoDao:=nil;
  end;
end;

procedure TPromocaoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPromocaoModel.SetCLIENTE_ID(const Value: Variant);
begin
  FCLIENTE_ID := Value;
end;

procedure TPromocaoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPromocaoModel.SetDATA(const Value: Variant);
begin
  FDATA := Value;
end;

procedure TPromocaoModel.SetDATAFIM(const Value: Variant);
begin
  FDATAFIM := Value;
end;

procedure TPromocaoModel.SetDATAINICIO(const Value: Variant);
begin
  FDATAINICIO := Value;
end;

procedure TPromocaoModel.SetDESCRICAO(const Value: Variant);
begin
  FDESCRICAO := Value;
end;

procedure TPromocaoModel.SetDOMINGO(const Value: Variant);
begin
  FDOMINGO := Value;
end;

procedure TPromocaoModel.SetHORAFIM(const Value: Variant);
begin
  FHORAFIM := Value;
end;

procedure TPromocaoModel.SetHORAINICIO(const Value: Variant);
begin
  FHORAINICIO := Value;
end;

procedure TPromocaoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TPromocaoModel.SetPRECO_VENDA_ID(const Value: Variant);
begin
  FPRECO_VENDA_ID := Value;
end;

procedure TPromocaoModel.SetPromocaosLista;
begin
  FPromocaosLista := Value;
end;

procedure TPromocaoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPromocaoModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPromocaoModel.SetQUARTA(const Value: Variant);
begin
  FQUARTA := Value;
end;

procedure TPromocaoModel.SetQUINTA(const Value: Variant);
begin
  FQUINTA := Value;
end;

procedure TPromocaoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPromocaoModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TPromocaoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPromocaoModel.SetSABADO(const Value: Variant);
begin
  FSABADO := Value;
end;

procedure TPromocaoModel.SetSEGUNDA(const Value: Variant);
begin
  FSEGUNDA := Value;
end;

procedure TPromocaoModel.SetSEXTA(const Value: Variant);
begin
  FSEXTA := Value;
end;

procedure TPromocaoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPromocaoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TPromocaoModel.SetTERCA(const Value: Variant);
begin
  FTERCA := Value;
end;

procedure TPromocaoModel.SetTIPO_ABATIMENTO(const Value: Variant);
begin
  FTIPO_ABATIMENTO := Value;
end;

procedure TPromocaoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPromocaoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
