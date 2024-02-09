unit TabelaJurosModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Terasoft.Utils,
  Interfaces.Conexao, FireDAC.Comp.Client;

type
  TTabelaJurosModel = class

  private
    vIConexao : IConexao;
    FTabelaJurossLista: TObjectList<TTabelaJurosModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FPERCENTUAL: Variant;
    FPORTADOR_ID: Variant;
    FINDCE: Variant;
    FCODIGO: Variant;
    FID: Variant;
    FSYSTIME: Variant;
    FINDCEENT: Variant;
    FVALOR_TOTAL: Variant;
    FVALOR_PARCELA: Variant;
    FJUROS_TEXTO: Variant;
    FVALOR_JUROS: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetTabelaJurossLista(const Value: TObjectList<TTabelaJurosModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCODIGO(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetINDCE(const Value: Variant);
    procedure SetINDCEENT(const Value: Variant);
    procedure SetPERCENTUAL(const Value: Variant);
    procedure SetPORTADOR_ID(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetVALOR_PARCELA(const Value: Variant);
    procedure SetVALOR_TOTAL(const Value: Variant);
    procedure SetJUROS_TEXTO(const Value: Variant);
    procedure SetVALOR_JUROS(const Value: Variant);

  public
    property CODIGO: Variant read FCODIGO write SetCODIGO;
    property INDCE: Variant read FINDCE write SetINDCE;
    property INDCEENT: Variant read FINDCEENT write SetINDCEENT;
    property ID: Variant read FID write SetID;
    property PERCENTUAL: Variant read FPERCENTUAL write SetPERCENTUAL;
    property PORTADOR_ID: Variant read FPORTADOR_ID write SetPORTADOR_ID;
    property SYSTIME: Variant read FSYSTIME write SetSYSTIME;
    property VALOR_PARCELA: Variant read FVALOR_PARCELA write SetVALOR_PARCELA;
    property VALOR_TOTAL: Variant read FVALOR_TOTAL write SetVALOR_TOTAL;
    property JUROS_TEXTO: Variant read FJUROS_TEXTO write SetJUROS_TEXTO;
    property VALOR_JUROS: Variant read FVALOR_JUROS write SetVALOR_JUROS;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista; overload;
    function obterLista(pPortador: String; pValor: Double): TFDMemTable; overload;

    function carregaClasse(pId: Integer): TTabelaJurosModel;

    property TabelaJurossLista: TObjectList<TTabelaJurosModel> read FTabelaJurossLista write SetTabelaJurossLista;
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
  TabelaJurosDao, System.SysUtils, Data.DB;

{ TTabelaJurosModel }

function TTabelaJurosModel.carregaClasse(pId: Integer): TTabelaJurosModel;
var
  lTabelaJurosDao: TTabelaJurosDao;
begin
  lTabelaJurosDao := TTabelaJurosDao.Create(vIConexao);

  try
    Result := lTabelaJurosDao.carregaClasse(pId);
  finally
    lTabelaJurosDao.Free;
  end;
end;

constructor TTabelaJurosModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTabelaJurosModel.Destroy;
begin

  inherited;
end;

function TTabelaJurosModel.obterLista(pPortador: String; pValor: Double): TFDMemTable;
var
  lModel    : TTabelaJurosModel;
  i         : Integer;
  lTotal,
  lJuros    : Double;
  lMemTable : TFDMemTable;
begin

  lMemTable := TFDMemTable.Create(nil);
  lModel    := TTabelaJurosModel.Create(vIConexao);
  lTotal    := pValor;

  try
    self.WhereView  := 'and portador_id = ' + QuotedStr(pPortador);
    self.OrderView  := ' tabelajuros.codigo';
    self.obterLista;

    if self.TotalRecords = 0 then
    begin
      self.TabelaJurossLista := TObjectList<TTabelaJurosModel>.Create;
      self.TabelaJurossLista[0].FID            := 0;
      self.TabelaJurossLista[0].FCODIGO        := '001';
      self.TabelaJurossLista[0].FPERCENTUAL    := FormatFloat('#,##0.00', 0);
      self.TabelaJurossLista[0].FJUROS_TEXTO   := 'Sem Juros';
      self.TabelaJurossLista[0].FVALOR_JUROS   := FormatFloat('#,##0.00',  0);
      self.TabelaJurossLista[0].FVALOR_PARCELA := FormatFloat('#,##0.00',  lTotal);
      self.TabelaJurossLista[0].FVALOR_TOTAL   := FormatFloat('#,##0.00',  lTotal);
    end;

    for i := 0 to self.TabelaJurossLista.Count -1 do
    begin
      self.TabelaJurossLista[i].FJUROS_TEXTO := IIF(self.TabelaJurossLista[i].PERCENTUAL > 0, 'Juros', 'Sem juros');
      lJuros                                 := IIF(self.TabelaJurossLista[i].PERCENTUAL > 0, self.TabelaJurossLista[i].PERCENTUAL / 100 * lTotal, 0);

      self.TabelaJurossLista[i].FVALOR_JUROS   := FormatFloat('#,##0.00',  lJuros);
      self.TabelaJurossLista[i].FVALOR_TOTAL   := FormatFloat('#,##0.00',lTotal + lJuros);
      self.TabelaJurossLista[i].FVALOR_PARCELA := FormatFloat('#,##0.00', (lTotal + lJuros) / StrToInt(self.TabelaJurossLista[i].CODIGO));
    end;

    with lMemTable.IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoCodigo';
      Fields := 'CODIGO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    lMemTable.IndexName := 'OrdenacaoCodigo';

    lMemTable.FieldDefs.Add('ID', ftInteger);
    lMemTable.FieldDefs.Add('CODIGO', ftString, 3);
    lMemTable.FieldDefs.Add('PERCENTUAL', ftFloat);
    lMemTable.FieldDefs.Add('JUROS_TEXTO', ftString, 20);
    lMemTable.FieldDefs.Add('VALOR_JUROS', ftFloat);
    lMemTable.FieldDefs.Add('VALOR_PARCELA', ftFloat);
    lMemTable.FieldDefs.Add('VALOR_TOTAL', ftString, 100);
    lMemTable.CreateDataSet;

    for i := 0 to self.TabelaJurossLista.Count -1 do
    begin
       lMemTable.InsertRecord([
                                self.TabelaJurossLista[i].ID,
                                self.TabelaJurossLista[i].CODIGO,
                                self.TabelaJurossLista[i].PERCENTUAL,
                                self.TabelaJurossLista[i].JUROS_TEXTO,
                                self.TabelaJurossLista[i].VALOR_JUROS,
                                self.TabelaJurossLista[i].VALOR_PARCELA,
                                self.TabelaJurossLista[i].VALOR_TOTAL
                               ]);
    end;

    lMemTable.Open;

    Result := lMemTable;

  finally
    lModel.Free;
  end;

end;

procedure TTabelaJurosModel.obterLista;
var
  lTabelaJurosLista: TTabelaJurosDao;
begin
  lTabelaJurosLista := TTabelaJurosDao.Create(vIConexao);

  try
    lTabelaJurosLista.TotalRecords    := FTotalRecords;
    lTabelaJurosLista.WhereView       := FWhereView;
    lTabelaJurosLista.CountView       := FCountView;
    lTabelaJurosLista.OrderView       := FOrderView;
    lTabelaJurosLista.StartRecordView := FStartRecordView;
    lTabelaJurosLista.LengthPageView  := FLengthPageView;
    lTabelaJurosLista.IDRecordView    := FIDRecordView;

    lTabelaJurosLista.obterLista;

    FTotalRecords  := lTabelaJurosLista.TotalRecords;
    FTabelaJurossLista := lTabelaJurosLista.TabelaJurossLista;

  finally
    lTabelaJurosLista.Free;
  end;
end;

function TTabelaJurosModel.Salvar: String;
var
  lTabelaJurosDao: TTabelaJurosDao;
begin
  lTabelaJurosDao := TTabelaJurosDao.Create(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lTabelaJurosDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lTabelaJurosDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lTabelaJurosDao.excluir(Self);
    end;

  finally
    lTabelaJurosDao.Free;
  end;
end;

procedure TTabelaJurosModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TTabelaJurosModel.SetCODIGO(const Value: Variant);
begin
  FCODIGO := Value;
end;

procedure TTabelaJurosModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosModel.SetTabelaJurossLista(const Value: TObjectList<TTabelaJurosModel>);
begin
  FTabelaJurossLista := Value;
end;

procedure TTabelaJurosModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosModel.SetINDCE(const Value: Variant);
begin
  FINDCE := Value;
end;

procedure TTabelaJurosModel.SetINDCEENT(const Value: Variant);
begin
  FINDCEENT := Value;
end;

procedure TTabelaJurosModel.SetJUROS_TEXTO(const Value: Variant);
begin
  FJUROS_TEXTO := Value;
end;

procedure TTabelaJurosModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTabelaJurosModel.SetPERCENTUAL(const Value: Variant);
begin
  FPERCENTUAL := Value;
end;

procedure TTabelaJurosModel.SetPORTADOR_ID(const Value: Variant);
begin
  FPORTADOR_ID := Value;
end;

procedure TTabelaJurosModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTabelaJurosModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TTabelaJurosModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTabelaJurosModel.SetVALOR_JUROS(const Value: Variant);
begin
  FVALOR_JUROS := Value;
end;

procedure TTabelaJurosModel.SetVALOR_PARCELA(const Value: Variant);
begin
  FVALOR_PARCELA := Value;
end;

procedure TTabelaJurosModel.SetVALOR_TOTAL(const Value: Variant);
begin
  FVALOR_TOTAL := Value;
end;

procedure TTabelaJurosModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
