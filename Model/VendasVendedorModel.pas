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

  TVendasVendedorModel = class;
  ITVendasVendedorModel=IObject<TVendasVendedorModel>;

  TVendasVendedorModel = class
  private
    [weak] mySelf: ITVendasVendedorModel;
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
    function obterComissao(pVendasVendedorParametros : TVendasVendedorParametros): IFDDataset;

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
  System.SysUtils;

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
