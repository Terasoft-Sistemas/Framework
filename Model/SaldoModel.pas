unit SaldoModel;

interface

uses
  FireDAC.Comp.Client,
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao;

type
  TParametrosSaldo = record
    PRODUTO,
    LOJA       : String;
    CD         : boolean;
  end;

  TSaldoModel = class

  private
    vIConexao : IConexao;
    FSaldosLista: TObjectList<TSaldoModel>;
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
    procedure SetSaldosLista(const Value: TObjectList<TSaldoModel>);
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

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function obterSaldoLojas(pParametros : TParametrosSaldo): TFDMemTable;
    function obterSaldo(pProduto : String): TFDMemTable;

    property SaldosLista: TObjectList<TSaldoModel> read FSaldosLista write SetSaldosLista;
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
constructor TSaldoModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;
destructor TSaldoModel.Destroy;
begin
  inherited;
end;

function TSaldoModel.obterSaldo(pProduto: String): TFDMemTable;
var
  lMemTable,
  lMemConsulta : TFDMemTable;
  lParametros : TParametrosSaldo;
begin
  lMemTable := TFDMemTable.Create(nil);

  try
    lMemTable.FieldDefs.Add('SALDO_FISICO', ftFloat);
    lMemTable.FieldDefs.Add('SALDO_DISPONIVEL', ftFloat);
    lMemTable.FieldDefs.Add('SALDO_CD', ftFloat);
    lMemTable.CreateDataSet;

    lParametros.PRODUTO := pProduto;
    lParametros.LOJA    := vIConexao.getEmpresa.LOJA;
    lParametros.CD      := true;

    lMemConsulta := self.obterSaldoLojas(lParametros);

    lMemConsulta.first;

    while not lMemConsulta.eof do
    begin
      if lMemConsulta.fieldByName('LOJA').value = 'CD' then
      begin
        lMemTable.edit;
        lMemTable.fieldByName('SALDO_CD').value := lMemConsulta.fieldByName('SALDO_DISPONIVEL').value;
        lMemTable.post;
      end
      else
      begin
        lMemTable.append;
        lMemTable.fieldByName('SALDO_FISICO').value     := lMemConsulta.fieldByName('SALDO_FISICO').value;
        lMemTable.fieldByName('SALDO_DISPONIVEL').value := lMemConsulta.fieldByName('SALDO_DISPONIVEL').value;
        lMemTable.post;
      end;
      lMemConsulta.Next;
    end;

    Result := lMemTable;
  finally
  end;

end;

function TSaldoModel.obterSaldoLojas(pParametros : TParametrosSaldo): TFDMemTable;
var
  lSaldoDao : TSaldoDao;
begin
  lSaldoDao := TSaldoDao.Create(vIConexao);
  try
    Result := lSaldoDao.obterSaldoLojas(pParametros);
  finally
    lSaldoDao.Free;
  end;
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
procedure TSaldoModel.SetSaldosLista(const Value: TObjectList<TSaldoModel>);
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
