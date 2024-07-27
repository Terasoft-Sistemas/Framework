unit SaldoModel;

interface

uses
  FireDAC.Comp.Client,
  Terasoft.Types,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TSaldoModel = class;
  ITSaldoModel=IObject<TSaldoModel>;

  TParametrosSaldo = record
    PRODUTO,
    LOJA       : String;
    CD         : boolean;
  end;

  TSaldoModel = class
  private
    [weak] mySelf: ITSaldoModel;
    vIConexao : IConexao;
    FSaldosLista: IList<ITSaldoModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FSALDO_DISPONIVEL: Variant;
    FSALDO_FISICO: Variant;
    FLOJA: Variant;
    FCD: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetSaldosLista(const Value: IList<ITSaldoModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetSALDO_DISPONIVEL(const Value: Variant);
    procedure SetSALDO_FISICO(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetCD(const Value: Variant);

  public
    property CD: Variant read FCD write SetCD;
    property LOJA: Variant read FLOJA write SetLOJA;
    property SALDO_FISICO: Variant read FSALDO_FISICO write SetSALDO_FISICO;
    property SALDO_DISPONIVEL: Variant read FSALDO_DISPONIVEL write SetSALDO_DISPONIVEL;

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITSaldoModel;

    function obterSaldoLojas(pParametros : TParametrosSaldo): IFDDataset;
    function obterSaldo(pProduto : String): IFDDataset;
    function obterReservasCD(pProduto : String) : IFDDataset;

    property SaldosLista: IList<ITSaldoModel> read FSaldosLista write SetSaldosLista;
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
  SaldoDao, Data.DB;

{ TSaldoModel }
constructor TSaldoModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;
destructor TSaldoModel.Destroy;
begin
  FSaldosLista := nil;
  inherited;
end;

class function TSaldoModel.getNewIface(pIConexao: IConexao): ITSaldoModel;
begin
  Result := TImplObjetoOwner<TSaldoModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TSaldoModel.obterReservasCD(pProduto: String): IFDDataset;
var
  lSaldoDao : ITSaldoDao;
begin
  Result := TSaldoDao.getNewIface(vIConexao).objeto.obterReservasCD(pProduto);
end;

function TSaldoModel.obterSaldo(pProduto: String): IFDDataset;
var
  lMemTable,
  lMemConsulta : IFDDataset;
  lParametros : TParametrosSaldo;
begin
  lMemTable := criaIFDDataset(TFDMemTable.Create(nil));

  try
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('SALDO_FISICO', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('SALDO_DISPONIVEL', ftFloat);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('SALDO_CD', ftFloat);
    TFDMemTable(lMemTable.objeto).CreateDataSet;

    lParametros.PRODUTO := pProduto;
    lParametros.LOJA    := vIConexao.getEmpresa.LOJA;
    lParametros.CD      := true;

    lMemConsulta := self.obterSaldoLojas(lParametros);

    lMemConsulta.objeto.first;

    while not lMemConsulta.objeto.eof do
    begin
      if lMemConsulta.objeto.fieldByName('LOJA').value = 'CD' then
      begin
        lMemTable.objeto.edit;
        lMemTable.objeto.fieldByName('SALDO_CD').value := lMemConsulta.objeto.fieldByName('SALDO_DISPONIVEL').value;
        lMemTable.objeto.post;
      end
      else
      begin
        lMemTable.objeto.append;
        lMemTable.objeto.fieldByName('SALDO_FISICO').value     := lMemConsulta.objeto.fieldByName('SALDO_FISICO').value;
        lMemTable.objeto.fieldByName('SALDO_DISPONIVEL').value := lMemConsulta.objeto.fieldByName('SALDO_DISPONIVEL').value;
        lMemTable.objeto.post;
      end;
      lMemConsulta.objeto.Next;
    end;

    Result := lMemTable;
  finally
  end;

end;

function TSaldoModel.obterSaldoLojas(pParametros : TParametrosSaldo): IFDDataset;
begin
  Result := TSaldoDao.getNewIface(vIConexao).objeto.obterSaldoLojas(pParametros);
end;

procedure TSaldoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;
procedure TSaldoModel.SetCD(const Value: Variant);
begin
  FCD := Value;
end;

procedure TSaldoModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TSaldoModel.SetSaldosLista;
begin
  FSaldosLista := Value;
end;
procedure TSaldoModel.SetSALDO_DISPONIVEL(const Value: Variant);
begin
  FSALDO_DISPONIVEL := Value;
end;

procedure TSaldoModel.SetSALDO_FISICO(const Value: Variant);
begin
  FSALDO_FISICO := Value;
end;

procedure TSaldoModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;
procedure TSaldoModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;
procedure TSaldoModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TSaldoModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;
procedure TSaldoModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TSaldoModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TSaldoModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
end.
