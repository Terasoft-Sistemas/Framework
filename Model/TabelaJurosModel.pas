unit TabelaJurosModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Utils,
  Interfaces.Conexao,
  FireDAC.Comp.Client,
  PortadorModel,
  Terasoft.Framework.ObjectIface,
  TabelaJurosDiaModel;

type
  TTabelaJurosModel = class;
  ITTabelaJurosModel=IObject<TTabelaJurosModel>;

  TTabelaJurosModel = class
  private
    [unsafe] mySelf:ITTabelaJurosModel;
    vIConexao : IConexao;
    FTabelaJurossLista: IList<ITTabelaJurosModel>;
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
    FVALOR_SEG_PRESTAMISTA: Variant;
    FVALOR_ACRESCIMO_SEG_PRESTAMISTA: Variant;
    FPER_SEG_PRESTAMSTA: Variant;
    FCOEFICIENTE: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetTabelaJurossLista(const Value: IList<ITTabelaJurosModel>);
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
    procedure SetPER_SEG_PRESTAMSTA(const Value: Variant);
    procedure SetVALOR_ACRESCIMO_SEG_PRESTAMISTA(const Value: Variant);
    procedure SetVALOR_SEG_PRESTAMISTA(const Value: Variant);
    procedure SetCOEFICIENTE(const Value: Variant);

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
    property VALOR_SEG_PRESTAMISTA : Variant read FVALOR_SEG_PRESTAMISTA write SetVALOR_SEG_PRESTAMISTA;
    property PER_SEG_PRESTAMSTA    : Variant read FPER_SEG_PRESTAMSTA write SetPER_SEG_PRESTAMSTA;
    property VALOR_ACRESCIMO_SEG_PRESTAMISTA : Variant read FVALOR_ACRESCIMO_SEG_PRESTAMISTA write SetVALOR_ACRESCIMO_SEG_PRESTAMISTA;
    property COEFICIENTE : Variant read FCOEFICIENTE write SetCOEFICIENTE;

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITTabelaJurosModel;

    function Salvar: String;
    procedure obterLista; overload;
    function obterLista(pPortador: String; pValor: Double; pSeguroPrestamista: Boolean; pPrimeiroVencimento: TDate): IFDDataset; overload;

    function carregaClasse(pId: Integer): ITTabelaJurosModel;

    property TabelaJurossLista: IList<ITTabelaJurosModel> read FTabelaJurossLista write SetTabelaJurossLista;
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
  TabelaJurosDao, System.SysUtils, Data.DB, Terasoft.Configuracoes;

{ TTabelaJurosModel }

function TTabelaJurosModel.carregaClasse(pId: Integer): ITTabelaJurosModel;
var
  lTabelaJurosDao: ITTabelaJurosDao;
begin
  lTabelaJurosDao := TTabelaJurosDao.getNewIface(vIConexao);

  try
    Result := lTabelaJurosDao.objeto.carregaClasse(pId);
  finally
    lTabelaJurosDao:=nil;
  end;
end;

constructor TTabelaJurosModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTabelaJurosModel.Destroy;
begin
  FTabelaJurossLista:=nil;
  vIConexao:=nil;
  inherited;
end;

class function TTabelaJurosModel.getNewIface(pIConexao: IConexao): ITTabelaJurosModel;
begin
  Result := TImplObjetoOwner<TTabelaJurosModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TTabelaJurosModel.obterLista(pPortador: String; pValor: Double; pSeguroPrestamista: Boolean; pPrimeiroVencimento: TDate): IFDDataset;
var
  lModel : ITTabelaJurosModel;
  lTabelaJurosDia : ITTabelaJurosDiaModel;
  i      : Integer;
  lTotal,
  lJuros,
  lValorGerar,
  lValorParcela,
  lPercentualJuros: Double;

  lCoeficienteJurosDias, lCoeficienteJuros : Extended;

  lMemTable      : IFDDataset;
  lPortadorModel : ITPortadorModel;
  lConfiguracoes : ITerasoftConfiguracoes;
  lTagPercentual : String;
  modelo: ITTabelaJurosModel;

  lTagLimitadorVencimento: Integer;
begin
  lPortadorModel := TPortadorModel.getNewIface(vIConexao);
  lTabelaJurosDia := TTabelaJurosDiaModel.getNewIface(vIConexao);

  lMemTable := criaIFDDataset(TFDMemTable.Create(nil));
  lModel    := TTabelaJurosModel.getNewIface(vIConexao);
  lTotal    := pValor;

  try
    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    lPortadorModel.objeto.IDRecordView := pPortador;
    lPortadorModel.objeto.obterLista;

    lPortadorModel := lPortadorModel.objeto.PortadorsLista.First;

    self.WhereView  := 'and portador_id = ' + QuotedStr(pPortador);
    self.OrderView  := ' tabelajuros.codigo';
    self.obterLista;

    lTagPercentual  := lConfiguracoes.objeto.valorTag('PEDIDO_TABELA_JUROS_PERCENTUAL', 'N', tvBool);
    lTagLimitadorVencimento := StrToInt(lConfiguracoes.objeto.valorTag('LIMITADOR_VENCIMENTO_RECEBER', 31, tvInteiro));


    if Terasoft.Utils.DiferencaEntreDatas(Date,pPrimeiroVencimento)  > lTagLimitadorVencimento then
      CriaException('Primeiro vencimento superior ao permitido. Permitido: '+IntToStr(lTagLimitadorVencimento)+' dias.');



    if Terasoft.Utils.DiferencaEntreDatas(Date,pPrimeiroVencimento)  > 30 then
      lCoeficienteJurosDias := lTabelaJurosDia.objeto.obterIndice(IntToStr(Terasoft.Utils.DiferencaEntreDatas(Date,pPrimeiroVencimento)-30), pPortador)
    else
      lCoeficienteJurosDias := 1;

    if lCoeficienteJurosDias = 0 then
      lCoeficienteJurosDias := 1;

    if self.TotalRecords = 0 then
    begin
      self.TabelaJurossLista := TCollections.CreateList<ITTabelaJurosModel>;
      modelo := TTabelaJurosModel.getNewIface(vIConexao);
      self.TabelaJurossLista.Add(modelo);

      modelo.objeto.FID := 0;
      modelo.objeto.FCODIGO        := '001';
      modelo.objeto.FPERCENTUAL    := FormatFloat('#,##0.00', 0);
      modelo.objeto.FJUROS_TEXTO   := 'Sem Juros';
      modelo.objeto.FVALOR_JUROS   := FormatFloat('#,##0.00',  0);
      modelo.objeto.FVALOR_PARCELA := FormatFloat('#,##0.00',  lTotal);
      modelo.objeto.FVALOR_TOTAL   := FormatFloat('#,##0.00',  lTotal);
    end;

    for i := 0 to self.TabelaJurossLista.Count -1 do
    begin

      if lTagPercentual = 'S' then
      begin
        self.TabelaJurossLista[i].objeto.FJUROS_TEXTO   := IIF(self.TabelaJurossLista[i].objeto.PERCENTUAL > 0, 'Juros', 'Sem juros');
        lJuros                                   := IIF(self.TabelaJurossLista[i].objeto.PERCENTUAL > 0, self.TabelaJurossLista[i].objeto.PERCENTUAL / 100 * lTotal, 0);
        self.TabelaJurossLista[i].objeto.FVALOR_JUROS   := FormatFloat('#,##0.00', lJuros);
        self.TabelaJurossLista[i].objeto.FVALOR_TOTAL   := FormatFloat('#,##0.00', lTotal + lJuros);
        self.TabelaJurossLista[i].objeto.FVALOR_PARCELA := FormatFloat('#,##0.00', (lTotal + lJuros) / StrToInt(self.TabelaJurossLista[i].objeto.CODIGO));

        if pSeguroPrestamista then
        begin
          if lPortadorModel.objeto.PER_SEGURO_PRESTAMISTA = 0 then
           CriaException('Valor do cadastro do seguroprestamista esta zerado.');

          self.TabelaJurossLista[i].objeto.PER_SEG_PRESTAMSTA              := lPortadorModel.objeto.PER_SEGURO_PRESTAMISTA;
          self.TabelaJurossLista[i].objeto.VALOR_SEG_PRESTAMISTA           := (lTotal + lJuros)*(lPortadorModel.objeto.PER_SEGURO_PRESTAMISTA/100);
          self.TabelaJurossLista[i].objeto.VALOR_ACRESCIMO_SEG_PRESTAMISTA := IIF(self.TabelaJurossLista[i].objeto.PERCENTUAL > 0, self.TabelaJurossLista[i].objeto.PERCENTUAL / 100 * self.TabelaJurossLista[i].objeto.VALOR_SEG_PRESTAMISTA, 0);;
        end else
        begin
          self.TabelaJurossLista[i].objeto.PER_SEG_PRESTAMSTA              := 0;
          self.TabelaJurossLista[i].objeto.VALOR_SEG_PRESTAMISTA           := 0;
          self.TabelaJurossLista[i].objeto.VALOR_ACRESCIMO_SEG_PRESTAMISTA := 0;
        end;
      end else
      begin

        if self.TabelaJurossLista[i].objeto.INDCE > 0 then
        begin
          lValorParcela     := lTotal * (self.TabelaJurossLista[i].objeto.INDCE * lCoeficienteJurosDias);
          lCoeficienteJuros := StrToFloat(self.TabelaJurossLista[i].objeto.INDCE) * lCoeficienteJurosDias;
          lValorGerar       := lValorParcela * StrToInt(self.TabelaJurossLista[i].objeto.CODIGO);
          lPercentualJuros  := (lValorGerar - lTotal) / lTotal * 100;
        end
        else
        begin
          lValorParcela    := lTotal / StrToInt(self.TabelaJurossLista[i].objeto.CODIGO);
          lValorGerar      := lTotal;
          lPercentualJuros := 0;
        end;

        self.TabelaJurossLista[i].objeto.FJUROS_TEXTO   := IIF(lPercentualJuros > 0, 'Juros', 'Sem juros');
        lJuros                                   := IIF(self.TabelaJurossLista[i].objeto.INDCE > 0, lValorGerar - lTotal, 0);
        self.TabelaJurossLista[i].objeto.FVALOR_JUROS   := FormatFloat('#,##0.00', lJuros);
        self.TabelaJurossLista[i].objeto.FVALOR_TOTAL   := FormatFloat('#,##0.00', lValorGerar);
        self.TabelaJurossLista[i].objeto.FVALOR_PARCELA := FormatFloat('#,##0.00', lValorParcela);

        if pSeguroPrestamista then
        begin
          if lPortadorModel.objeto.PER_SEGURO_PRESTAMISTA = 0 then
           CriaException('Valor do cadastro do seguroprestamista esta zerado.');

          self.TabelaJurossLista[i].objeto.PER_SEG_PRESTAMSTA              := lPortadorModel.objeto.PER_SEGURO_PRESTAMISTA;
          self.TabelaJurossLista[i].objeto.VALOR_SEG_PRESTAMISTA           := (lTotal + lJuros)*(lPortadorModel.objeto.PER_SEGURO_PRESTAMISTA/100);
          self.TabelaJurossLista[i].objeto.VALOR_ACRESCIMO_SEG_PRESTAMISTA := IIF(lPercentualJuros > 0, lPercentualJuros / 100 * self.TabelaJurossLista[i].objeto.VALOR_SEG_PRESTAMISTA, 0);;
        end else
        begin
          self.TabelaJurossLista[i].objeto.PER_SEG_PRESTAMSTA              := 0;
          self.TabelaJurossLista[i].objeto.VALOR_SEG_PRESTAMISTA           := 0;
          self.TabelaJurossLista[i].objeto.VALOR_ACRESCIMO_SEG_PRESTAMISTA := 0;
        end;
      end;
    end;

    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoCodigo';
      Fields := 'CODIGO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    TFDMemTable(lMemTable.objeto).IndexName := 'OrdenacaoCodigo';

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('ID', ftInteger);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('CODIGO', ftString, 3);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('PERCENTUAL', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('JUROS_TEXTO', ftString, 20);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('VALOR_JUROS', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('VALOR_PARCELA', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('VALOR_TOTAL', ftString, 100);

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('VALOR_SEG_PRESTAMISTA', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('PER_SEG_PRESTAMSTA', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('VALOR_ACRESCIMO_SEG_PRESTAMISTA', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('COEFICIENTE', ftFloat);

    TFDMemTable(lMemTable.objeto).CreateDataSet;

    for i := 0 to self.TabelaJurossLista.Count -1 do
    begin
      if lTagPercentual = 'S' then
        lPercentualJuros := self.TabelaJurossLista[i].objeto.PERCENTUAL
      else
      if self.TabelaJurossLista[i].objeto.INDCE > 0 then
      begin
        lValorParcela    := lTotal * self.TabelaJurossLista[i].objeto.INDCE;
        lValorGerar      := lValorParcela * StrToInt(self.TabelaJurossLista[i].objeto.CODIGO);
        lPercentualJuros := (lValorGerar - lTotal) / lTotal * 100;
        lCoeficienteJuros := StrToFloat(self.TabelaJurossLista[i].objeto.INDCE) * lCoeficienteJurosDias;

      end
      else
      begin
        lPercentualJuros := 0;
      end;


      lMemTable.objeto.InsertRecord([
                              self.TabelaJurossLista[i].objeto.ID,
                              self.TabelaJurossLista[i].objeto.CODIGO,
                              IIF(lTagPercentual = 'S', self.TabelaJurossLista[i].objeto.PERCENTUAL, lPercentualJuros),
                              self.TabelaJurossLista[i].objeto.JUROS_TEXTO,
                              self.TabelaJurossLista[i].objeto.VALOR_JUROS,
                              self.TabelaJurossLista[i].objeto.VALOR_PARCELA,
                              self.TabelaJurossLista[i].objeto.VALOR_TOTAL,
                              self.TabelaJurossLista[i].objeto.VALOR_SEG_PRESTAMISTA,
                              self.TabelaJurossLista[i].objeto.PER_SEG_PRESTAMSTA,
                              self.TabelaJurossLista[i].objeto.VALOR_ACRESCIMO_SEG_PRESTAMISTA,
                              lCoeficienteJuros
                             ]);


    end;

    lMemTable.objeto.Open;

    Result := lMemTable;

  finally
    lModel:=nil;
    lTabelaJurosDia:=nil;
  end;

end;

procedure TTabelaJurosModel.obterLista;
var
  lTabelaJurosLista: ITTabelaJurosDao;
begin
  lTabelaJurosLista := TTabelaJurosDao.getNewIface(vIConexao);

  try
    lTabelaJurosLista.objeto.TotalRecords    := FTotalRecords;
    lTabelaJurosLista.objeto.WhereView       := FWhereView;
    lTabelaJurosLista.objeto.CountView       := FCountView;
    lTabelaJurosLista.objeto.OrderView       := FOrderView;
    lTabelaJurosLista.objeto.StartRecordView := FStartRecordView;
    lTabelaJurosLista.objeto.LengthPageView  := FLengthPageView;
    lTabelaJurosLista.objeto.IDRecordView    := FIDRecordView;

    lTabelaJurosLista.objeto.obterLista;

    FTotalRecords  := lTabelaJurosLista.objeto.TotalRecords;
    FTabelaJurossLista := lTabelaJurosLista.objeto.TabelaJurossLista;

  finally
    lTabelaJurosLista:=nil;
  end;
end;

function TTabelaJurosModel.Salvar: String;
var
  lTabelaJurosDao: ITTabelaJurosDao;
begin
  lTabelaJurosDao := TTabelaJurosDao.getNewIface(vIConexao);

  Result := '';

  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lTabelaJurosDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lTabelaJurosDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lTabelaJurosDao.objeto.excluir(mySelf);
    end;

  finally
    lTabelaJurosDao:=nil;
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

procedure TTabelaJurosModel.SetCOEFICIENTE(const Value: Variant);
begin
  FCOEFICIENTE := Value;
end;

procedure TTabelaJurosModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosModel.SetTabelaJurossLista;
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

procedure TTabelaJurosModel.SetPER_SEG_PRESTAMSTA(const Value: Variant);
begin
  FPER_SEG_PRESTAMSTA := Value;
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

procedure TTabelaJurosModel.SetVALOR_ACRESCIMO_SEG_PRESTAMISTA(
  const Value: Variant);
begin
  FVALOR_ACRESCIMO_SEG_PRESTAMISTA := Value;
end;

procedure TTabelaJurosModel.SetVALOR_JUROS(const Value: Variant);
begin
  FVALOR_JUROS := Value;
end;

procedure TTabelaJurosModel.SetVALOR_PARCELA(const Value: Variant);
begin
  FVALOR_PARCELA := Value;
end;

procedure TTabelaJurosModel.SetVALOR_SEG_PRESTAMISTA(const Value: Variant);
begin
  FVALOR_SEG_PRESTAMISTA := Value;
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
