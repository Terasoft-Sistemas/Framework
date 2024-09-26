unit VendasVendedorModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  FireDAC.Comp.Client;

type
  TVendasVendedorParametros = record
    DataInicio,
    DataFim,
    TipoData,
    Vendedor,
    Lojas        : String;
  end;

  TVendasVendedorResultado = record
    fdComissao,
    fdDevolucao,
    fditens,
    fdGrupo,
    fdGarantia,
    fdPrestamista      : IFDDataset;
    totalVenda,
    totalDevolucao,
    total,
    totalComissao,
    totalPedidos,
    ticket,
    meta,
    percentualMeta,
    totalGarantia,
    totalPrestamista   : Double;
  end;

  TVendasVendedorModel = class;
  ITVendasVendedorModel=IObject<TVendasVendedorModel>;

  TVendasVendedorModel = class
  private
    [unsafe] mySelf: ITVendasVendedorModel;
    vIConexao : IConexao;

    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;

    procedure SetCountView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

  public
  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITVendasVendedorModel;

    function obterVendasVendedor(pVendasVendedorParametros : TVendasVendedorParametros): TVendasVendedorResultado;
    function obterComissao(pVendasVendedorParametros : TVendasVendedorParametros): IFDDataset;
    function obterDevolucao(pVendasVendedorParametros : TVendasVendedorParametros): IFDDataset;
    function obterItens(pVendasVendedorParametros : TVendasVendedorParametros): IFDDataset;
    function obterGrupoComissao(pVendasVendedorParametros : TVendasVendedorParametros): IFDDataset;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;

  end;

implementation

uses
  VendasVendedorDao,  
  System.Classes, 
  System.SysUtils, VendedorModel;

{ TVendasVendedorModel }

class function TVendasVendedorModel.getNewIface(pIConexao: IConexao): ITVendasVendedorModel;
begin
  Result := TImplObjetoOwner<TVendasVendedorModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

constructor TVendasVendedorModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TVendasVendedorModel.Destroy;
begin
  inherited;
end;

function TVendasVendedorModel.obterComissao(pVendasVendedorParametros : TVendasVendedorParametros): IFDDataset;
var
  lVendasVendedorDao: ITVendasVendedorDao;
begin
  lVendasVendedorDao := TVendasVendedorDao.getNewIface(vIConexao);
  try
    Result := lVendasVendedorDao.objeto.obterComissao(pVendasVendedorParametros);
  finally
    lVendasVendedorDao := nil;
  end;
end;

function TVendasVendedorModel.obterDevolucao(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
var
  lVendasVendedorDao: ITVendasVendedorDao;
begin
  lVendasVendedorDao := TVendasVendedorDao.getNewIface(vIConexao);
  try
    Result := lVendasVendedorDao.objeto.obterDevolucao(pVendasVendedorParametros);
  finally
    lVendasVendedorDao := nil;
  end;
end;

function TVendasVendedorModel.obterGrupoComissao(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
var
  lVendasVendedorDao: ITVendasVendedorDao;
begin
  lVendasVendedorDao := TVendasVendedorDao.getNewIface(vIConexao);
  try
    Result := lVendasVendedorDao.objeto.obterGrupoComissao(pVendasVendedorParametros);
  finally
    lVendasVendedorDao := nil;
  end;
end;

function TVendasVendedorModel.obterItens(pVendasVendedorParametros: TVendasVendedorParametros): IFDDataset;
var
  lVendasVendedorDao: ITVendasVendedorDao;
begin
  lVendasVendedorDao := TVendasVendedorDao.getNewIface(vIConexao);
  try
    Result := lVendasVendedorDao.objeto.obterItens(pVendasVendedorParametros);
  finally
    lVendasVendedorDao := nil;
  end;
end;

function TVendasVendedorModel.obterVendasVendedor(pVendasVendedorParametros: TVendasVendedorParametros): TVendasVendedorResultado;
var
  lVendasVendedorDao : ITVendasVendedorDao;
  lVendedorModel     : TVendedorModel;
  lVenda,
  lComissao,
  lDevolucao,
  lMeta,
  lMetaPercentual    : Double;
  lPedidos           : Integer;
  lResultado         : TVendasVendedorResultado;
  lResultadoServicos : TServicosResultado;
begin
  lVendasVendedorDao := TVendasVendedorDao.getNewIface(vIConexao);
  lVendedorModel     := TVendedorModel.Create(vIConexao);
  lPedidos           := 0;

  try
    lResultado.fdComissao        := lVendasVendedorDao.objeto.obterComissao(pVendasVendedorParametros);
    lResultado.fdDevolucao       := lVendasVendedorDao.objeto.obterDevolucao(pVendasVendedorParametros);
    lResultado.fditens           := lVendasVendedorDao.objeto.obterItens(pVendasVendedorParametros);
    lResultado.fdGrupo           := lVendasVendedorDao.objeto.obterGrupoComissao(pVendasVendedorParametros);

    lResultadoServicos           := lVendasVendedorDao.objeto.obterServicos(pVendasVendedorParametros);

    lResultado.fdGarantia        := lResultadoServicos.fdGarantia;
    lResultado.fdPrestamista     := lResultadoServicos.fdPrestamista;
    lResultado.totalGarantia     := lResultadoServicos.totalGarantia;
    lResultado.totalPrestamista  := lResultadoServicos.totalPrestamista;

    lResultado.fdComissao.objeto.First;
    while not lResultado.fdComissao.objeto.Eof do
    begin
      lVenda    := lVenda    + lResultado.fdComissao.objeto.FieldByName('VALOR_VENDA').AsFloat;
      lComissao := lComissao + lResultado.fdComissao.objeto.FieldByName('VALOR_COMISSAO').AsFloat;
      inc(lPedidos);

      lResultado.fdComissao.objeto.Next;
    end;

    lResultado.fdDevolucao.objeto.First;
    while not lResultado.fdDevolucao.objeto.Eof do
    begin
      lDevolucao := lDevolucao + lResultado.fdDevolucao.objeto.FieldByName('VALOR_VENDA').AsFloat;
      lComissao  := lComissao  - lResultado.fdDevolucao.objeto.FieldByName('VALOR_COMISSAO').AsFloat;

      lResultado.fdDevolucao.objeto.Next;
    end;

    lResultado.percentualMeta := 0;
    lResultado.meta           := 0;

    if pVendasVendedorParametros.Vendedor <> '' then
    begin
      lMeta := lVendedorModel.obterMeta(pVendasVendedorParametros.Vendedor,
                                        StrToDate(pVendasVendedorParametros.DataInicio),
                                        StrToDate(pVendasVendedorParametros.DataFim));

      if lMeta > 0 then begin
        lResultado.percentualMeta := lVenda * 100 / lMeta;
        lResultado.meta           := lMeta;
      end;
    end;

    lResultado.totalVenda     := lVenda;
    lResultado.totalDevolucao := lDevolucao;
    lResultado.total          := lVenda-lDevolucao;
    lResultado.totalComissao  := lComissao;
    lResultado.totalPedidos   := lPedidos;
    lResultado.ticket         := lVenda/lPedidos;

    Result := lResultado;

  finally
    lVendasVendedorDao := nil;
    lVendedorModel.Free;
  end;
end;

procedure TVendasVendedorModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVendasVendedorModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVendasVendedorModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TVendasVendedorModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TVendasVendedorModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TVendasVendedorModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
