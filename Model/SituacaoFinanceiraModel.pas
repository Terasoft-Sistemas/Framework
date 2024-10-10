unit SituacaoFinanceiraModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Interfaces.Conexao,
  FireDAC.Comp.Client;

type

  TSituacaoFinanceiraModel = class

  private
    vIConexao : IConexao;

    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FValorAVencer: Double;
    FValorDeJuros: Double;
    FValorEmAberto: Double;
    FValorEmAbertoComJuros: Double;
    FValorEmAtraso: Double;
    FValorComprasRealizadasAPrazo: Double;


    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordview(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetValorAVencer(const Value: Double);
    procedure SetValorComprasRealizadasAPrazo(const Value: Double);
    procedure SetValorDeJuros(const Value: Double);
    procedure SetValorEmAberto(const Value: Double);
    procedure SetValorEmAbertoComJuros(const Value: Double);
    procedure SetValorEmAtraso(const Value: Double);

  public


  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pCliente : String): IFDDataset;
    procedure ObterResumoFinanceiro(pCliente : String);
    function ObterDetalhesBaixa(pFatura, pParcela : String): IFDDataset;
    function ObterCredito(pCliente: String): Double;

    property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordview : String read FIDRecordview write SetIDRecordview;

    property ValorEmAberto : Double read FValorEmAberto write SetValorEmAberto;
    property ValorDeJuros : Double read FValorDeJuros write SetValorDeJuros;
    property ValorEmAbertoComJuros : Double read FValorEmAbertoComJuros write SetValorEmAbertoComJuros;
    property ValorEmAtraso : Double read FValorEmAtraso write SetValorEmAtraso;
    property ValorAVencer : Double read FValorAVencer write SetValorAVencer;
    property ValorComprasRealizadasAPrazo : Double read FValorComprasRealizadasAPrazo write SetValorComprasRealizadasAPrazo;
  end;

implementation

uses
  SituacaoFinanceiraDao,
  System.Classes,
  System.SysUtils;

{ TSituacaoFinanceiraModel }

constructor TSituacaoFinanceiraModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TSituacaoFinanceiraModel.Destroy;
begin
  inherited;
end;

function TSituacaoFinanceiraModel.obterLista(pCliente : String): IFDDataset;
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    lSituacaoFinanceiraLista.WhereView  := FWhereView;

    Result := lSituacaoFinanceiraLista.obterLista(pCliente);
  finally
    lSituacaoFinanceiraLista.Free;
  end;
end;

procedure TSituacaoFinanceiraModel.ObterResumoFinanceiro(pCliente : String);
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    lSituacaoFinanceiraLista.WhereView  := FWhereView;
    lSituacaoFinanceiraLista.ObterResumoFinanceiro(pCliente);
    FValorEmAberto                := lSituacaoFinanceiraLista.ValorEmAberto;
    FValorDeJuros                 := lSituacaoFinanceiraLista.ValorDeJuros;
    FValorEmAbertoComJuros        := lSituacaoFinanceiraLista.ValorEmAbertoComJuros;
    FValorEmAtraso                := lSituacaoFinanceiraLista.ValorEmAtraso;
    FValorAVencer                 := lSituacaoFinanceiraLista.ValorAVencer;
    FValorComprasRealizadasAPrazo := lSituacaoFinanceiraLista.ValorComprasRealizadasAPrazo;
  finally
    lSituacaoFinanceiraLista.Free;
  end;
end;

function TSituacaoFinanceiraModel.ObterCredito(pCliente: String): Double;
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    Result := lSituacaoFinanceiraLista.ObterCredito(pCliente);
  finally
    lSituacaoFinanceiraLista.Free;
  end;
end;

function TSituacaoFinanceiraModel.ObterDetalhesBaixa(pFatura, pParcela: String): IFDDataset;
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    Result := lSituacaoFinanceiraLista.ObterDetalhesBaixa(pFatura, pParcela);
  finally
    lSituacaoFinanceiraLista.Free;
  end;
end;

procedure TSituacaoFinanceiraModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TSituacaoFinanceiraModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSituacaoFinanceiraModel.SetIDRecordview(const Value: String);
begin
  FIDRecordview := Value;
end;

procedure TSituacaoFinanceiraModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSituacaoFinanceiraModel.SetOrderView(const Value: String);
begin
  FOrderView := Value
end;

procedure TSituacaoFinanceiraModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value
end;

procedure TSituacaoFinanceiraModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value
end;

procedure TSituacaoFinanceiraModel.SetValorAVencer(const Value: Double);
begin
  FValorAVencer := Value;
end;

procedure TSituacaoFinanceiraModel.SetValorComprasRealizadasAPrazo(
  const Value: Double);
begin
  FValorComprasRealizadasAPrazo := Value;
end;

procedure TSituacaoFinanceiraModel.SetValorDeJuros(const Value: Double);
begin
  FValorDeJuros := Value;
end;

procedure TSituacaoFinanceiraModel.SetValorEmAberto(const Value: Double);
begin
  FValorEmAberto := Value;
end;

procedure TSituacaoFinanceiraModel.SetValorEmAbertoComJuros(
  const Value: Double);
begin
  FValorEmAbertoComJuros := Value;
end;

procedure TSituacaoFinanceiraModel.SetValorEmAtraso(const Value: Double);
begin
  FValorEmAtraso := Value;
end;

procedure TSituacaoFinanceiraModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
