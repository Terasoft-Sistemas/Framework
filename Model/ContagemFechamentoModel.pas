unit ContagemFechamentoModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao, FireDAC.Comp.Client;

type
  TContagemFechamentoModel = class

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
    FCAIXA_CTR_ID: Variant;
    FDATAHORA: Variant;
    FVALOR: Variant;
    FPORTADOR_ID: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FBANDEIRA_ID: Variant;
    FJUSTIFICATIVA: Variant;

    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetBANDEIRA_ID(const Value: Variant);
    procedure SetCAIXA_CTR_ID(const Value: Variant);
    procedure SetDATAHORA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetJUSTIFICATIVA(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR(const Value: Variant);

  public
    property ID: Variant read FID write SetID;
    property PORTADOR_ID: Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property BANDEIRA_ID: Variant read FBANDEIRA_ID write SetBANDEIRA_ID;
    property VALOR: Variant read FVALOR write SetVALOR;
    property DATAHORA: Variant read FDATAHORA write SetDATAHORA;
    property CAIXA_CTR_ID: Variant read FCAIXA_CTR_ID write SetCAIXA_CTR_ID;
    property JUSTIFICATIVA: Variant read FJUSTIFICATIVA write SetJUSTIFICATIVA;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir     : String;
    function Alterar(pID : String): TContagemFechamentoModel;
    function Excluir(pID : String): String;
    function Salvar      : String;
    function obterLista  : IFDDataset;
    procedure ExcluirContagem(pIdCaixa : String);

    function carregaClasse(pId: String): TContagemFechamentoModel;
    function obterContagem(pIdAberturaCaixa: String): IFDDataset;

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
  ContagemFechamentoDao, PortadorModel, AdmCartaoModel, Data.DB,
  System.SysUtils;

{ TContagemFechamentoModel }

function TContagemFechamentoModel.Alterar(pID: String): TContagemFechamentoModel;
var
  lContagemFechamentoModel : TContagemFechamentoModel;
begin
  lContagemFechamentoModel := TContagemFechamentoModel.Create(vIConexao);

  try
    lContagemFechamentoModel      := lContagemFechamentoModel.carregaClasse(pID);
    lContagemFechamentoModel.Acao := tacAlterar;

    Result := lContagemFechamentoModel;
  finally
    lContagemFechamentoModel.Free
  end;
end;

function TContagemFechamentoModel.carregaClasse(pId: String): TContagemFechamentoModel;
var
  lContagemFechamentoDao: TContagemFechamentoDao;
begin
  lContagemFechamentoDao := TContagemFechamentoDao.Create(vIConexao);
  try
    Result := lContagemFechamentoDao.carregaClasse(pId);
  finally
    lContagemFechamentoDao.Free;
  end;
end;

constructor TContagemFechamentoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContagemFechamentoModel.Destroy;
begin
  vIConexao := nil;
  inherited;
end;

function TContagemFechamentoModel.Excluir(pID: String): String;
begin
  self.FID := pID;
  self.Acao := tacExcluir;
  Result := self.Salvar
end;

procedure TContagemFechamentoModel.ExcluirContagem(pIdCaixa: String);
var
  lContagemFechamentoDao : TContagemFechamentoDao;
begin
  lContagemFechamentoDao := TContagemFechamentoDao.Create(vIConexao);
  try
    lContagemFechamentoDao.excluirContagem(pIdCaixa);
  finally
    lContagemFechamentoDao.Free;
  end;
end;

function TContagemFechamentoModel.Incluir: String;
var
  lContagemFechamentoModel : TContagemFechamentoModel;
begin
  lContagemFechamentoModel := TContagemFechamentoModel.Create(vIConexao);
  try
    self.Acao := tacIncluir;
    Result    := self.Salvar;
  finally
    lContagemFechamentoModel.Free;
  end;
end;

function TContagemFechamentoModel.obterContagem(pIdAberturaCaixa: String): IFDDataset;
var
  lPortadorModel   : ITPortadorModel;
  lAdmCartaoModel  : ITAdmCartaoModel;
  lMemTable        : IFDDataset;
  lMemTableGerada  : IFDDataset;
  lLocate          : Boolean;

begin
  lPortadorModel   := TPortadorModel.getNewIface(vIConexao);
  lAdmCartaoModel  := TAdmCartaoModel.getNewIface(vIConexao);
  lMemTable        := TImplObjetoOwner<TDataset>.CreateOwner(TFDMemTable.Create(nil));
  lMemTableGerada  := TImplObjetoOwner<TDataset>.CreateOwner(TFDMemTable.Create(nil));

  try
    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoDescricao';
      Fields := 'DESCRICAO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    with TFDMemTable(lMemTable.objeto) do
    begin
      IndexName := 'OrdenacaoDescricao';
      FieldDefs.Add('TIPO', ftString, 1);
      FieldDefs.Add('ID', ftString, 10);
      FieldDefs.Add('DESCRICAO', ftString, 50);
      FieldDefs.Add('VALOR', ftFloat);
      CreateDataSet;
    end;

    lPortadorModel.objeto.WhereView := ' and coalesce(portador.contagem,''S'') = ''S''                                               '+
                                ' and coalesce(portador.status,''A'')   = ''A''                                               '+
                                ' and (select count(*) from admcartao where admcartao.portador_id = portador.codigo_port) = 0 ';

    lPortadorModel.objeto.obterLista;

    for lPortadorModel in lPortadorModel.objeto.PortadorsLista do
    begin
      lMemTable.objeto.InsertRecord([
                              'P',
                              lPortadorModel.objeto.CODIGO_PORT,
                              lPortadorModel.objeto.NOME_PORT,
                              0
                             ]);

    end;

    lAdmCartaoModel.objeto.WhereView := ' and coalesce(admcartao.status,''A'') = ''A'' ';
    lAdmCartaoModel.objeto.obterLista;

    for lAdmCartaoModel in lAdmCartaoModel.objeto.AdmCartaosLista do
    begin
      lMemTable.objeto.InsertRecord([
                              'B',
                              lAdmCartaoModel.objeto.ID,
                              lAdmCartaoModel.objeto.NOME_ADM,
                              0
                             ]);

    end;

    lMemTable.objeto.Open;

    self.WhereView  := ' and contagem_fechamento.caixa_ctr_id = '+ QuotedStr(pIdAberturaCaixa);
    lMemTableGerada := self.obterLista;

    lMemTable.objeto.First;
    while not lMemTable.objeto.Eof do
    begin
      lMemTableGerada.objeto.first;

      if lMemTable.objeto.fieldByName('TIPO').AsString = 'P' then
        lLocate := lMemTableGerada.objeto.locate('PORTADOR_ID', lMemTable.objeto.fieldByName('ID').AsString, [])
      else
        lLocate := lMemTableGerada.objeto.locate('BANDEIRA_ID', lMemTable.objeto.fieldByName('ID').AsString, []);

      if lLocate then
      begin
        lMemTable.objeto.Edit;
        lMemTable.objeto.fieldByName('VALOR').AsFloat := lMemTableGerada.objeto.fieldByName('VALOR').AsFloat;
        lMemTable.objeto.Post;
      end;

      lMemTable.objeto.Next;
    end;

    Result := lMemTable;
  finally
    lPortadorModel:=nil;
    lAdmCartaoModel:=nil;
  end;

end;

function TContagemFechamentoModel.obterLista : IFDDataset;
var
  lContagemFechamentoDao : TContagemFechamentoDao;
begin
  lContagemFechamentoDao := TContagemFechamentoDao.Create(vIConexao);

  try
    lContagemFechamentoDao.TotalRecords    := FTotalRecords;
    lContagemFechamentoDao.WhereView       := FWhereView;
    lContagemFechamentoDao.CountView       := FCountView;
    lContagemFechamentoDao.OrderView       := FOrderView;
    lContagemFechamentoDao.StartRecordView := FStartRecordView;
    lContagemFechamentoDao.LengthPageView  := FLengthPageView;
    lContagemFechamentoDao.IDRecordView    := FIDRecordView;

    Result := lContagemFechamentoDao.obterLista;

    FTotalRecords := lContagemFechamentoDao.TotalRecords;
  finally
    lContagemFechamentoDao.Free;
  end;
end;

function TContagemFechamentoModel.Salvar: String;
var
  lContagemFechamentoDao: TContagemFechamentoDao;
begin
  lContagemFechamentoDao := TContagemFechamentoDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lContagemFechamentoDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lContagemFechamentoDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lContagemFechamentoDao.excluir(Self);
    end;
  finally
    lContagemFechamentoDao.Free;
  end;
end;

procedure TContagemFechamentoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TContagemFechamentoModel.SetBANDEIRA_ID(const Value: Variant);
begin
  FBANDEIRA_ID := Value;
end;

procedure TContagemFechamentoModel.SetCAIXA_CTR_ID(const Value: Variant);
begin
  FCAIXA_CTR_ID := Value;
end;

procedure TContagemFechamentoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContagemFechamentoModel.SetDATAHORA(const Value: Variant);
begin
  FDATAHORA := Value;
end;

procedure TContagemFechamentoModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContagemFechamentoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContagemFechamentoModel.SetJUSTIFICATIVA(const Value: Variant);
begin
  FJUSTIFICATIVA := Value;
end;

procedure TContagemFechamentoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContagemFechamentoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContagemFechamentoModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TContagemFechamentoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContagemFechamentoModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TContagemFechamentoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContagemFechamentoModel.SetVALOR(const Value: Variant);
begin
  FVALOR := Value;
end;

procedure TContagemFechamentoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
