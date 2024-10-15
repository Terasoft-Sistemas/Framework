unit SituacaoFinanceiraModel;

interface

uses
  Terasoft.Types,
  System.Generics.Collections,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.FuncoesTexto;

type

  TSituacaoFinanceiraModel = class;

  ITSituacaoFinanceiraModel = IObject<TSituacaoFinanceiraModel>;

  TSituacaoFinanceiraModel = class
  private
    [unsafe] myself: ITSituacaoFinanceiraModel;
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

    class function getNewIface(pIConexao : IConexao): ITSituacaoFinanceiraModel;

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pCliente : String): IFDDataset;
    procedure ObterResumoFinanceiro(pCliente : String);
    function ObterDetalhesBaixa(pFatura, pParcela : String): IFDDataset;
    function ObterCredito(pCliente: String): Double;

    function RegistroBanco(pFatura, pParcela: String): IFDDataset;
    function RegistroBancoJuros(pFatura, pParcela: String): IFDDataset;

    function EstornarBanco(pFatura, pParcela: String): Boolean;

    function realizarBaixa(pIdContasReceberItens, pIdBancoBaixa, pIdContaBaixa, pIdPortadorBaixar, pValorBaixa, pJurosDesconto, pTipoAdicional, pDataPagamento, pHistorico: String): Boolean;
    function calcularJuros(pCliente, pSituacao: String; pValorParcela, pValorRecebido: Double; pVencimento, pDataBaixa: TDate): Double;

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
  System.SysUtils,
  ContasReceberItensModel,
  ContaCorrenteModel;

{ TSituacaoFinanceiraModel }

constructor TSituacaoFinanceiraModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

class function TSituacaoFinanceiraModel.getNewIface(pIConexao: IConexao): ITSituacaoFinanceiraModel;
begin
  Result := TImplObjetoOwner<TSituacaoFinanceiraModel>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

destructor TSituacaoFinanceiraModel.Destroy;
begin
  inherited;
  vIConexao := nil;
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
    lSituacaoFinanceiraLista := nil;
  end;
end;

function TSituacaoFinanceiraModel.calcularJuros(pCliente, pSituacao : String; pValorParcela, pValorRecebido : Double; pVencimento, pDataBaixa : TDate) : Double;
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    Result := lSituacaoFinanceiraLista.calcularJuros(pCliente, pSituacao, pValorParcela, pValorRecebido, pVencimento, pDataBaixa);
  finally
    lSituacaoFinanceiraLista := nil;
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
    lSituacaoFinanceiraLista := nil;
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
    lSituacaoFinanceiraLista := nil;
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
    lSituacaoFinanceiraLista := nil;
  end;
end;

function TSituacaoFinanceiraModel.RegistroBanco(pFatura, pParcela: String): IFDDataset;
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    Result := lSituacaoFinanceiraLista.RegistroBanco(pFatura, pParcela);
  finally
    lSituacaoFinanceiraLista := nil;
  end;
end;

function TSituacaoFinanceiraModel.RegistroBancoJuros(pFatura, pParcela: String): IFDDataset;
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    Result := lSituacaoFinanceiraLista.RegistroBancoJuros(pFatura, pParcela);
  finally
    lSituacaoFinanceiraLista := nil;
  end;
end;

function TSituacaoFinanceiraModel.realizarBaixa(pIdContasReceberItens, pIdBancoBaixa, pIdContaBaixa, pIdPortadorBaixar, pValorBaixa, pJurosDesconto, pTipoAdicional, pDataPagamento, pHistorico: String): Boolean;
var
  lContasReceberItensModel: TContasReceberItensModel;
  lContaCorrenteModel: ITContaCorrenteModel;
  lRetorno: String;
  lValorAtualizar, lValorAberto, lValorParcela, lValorRecebido, lValorBaixa: Double;
begin

  if pIdContasReceberItens = '' then
    CriaException('Contas a receber não informado para baixa');

  if pIdBancoBaixa = '' then
    CriaException('Banco não informado');

  if pValorBaixa = '' then
    CriaException('Valor pago não informado');

  if StrToFloatDef(pValorBaixa, 0) <= 0 then
    CriaException('Valor pago inválido');

  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);
  lContaCorrenteModel      := TContaCorrenteModel.getNewIface(vIConexao);

  try
    lContasReceberItensModel.IDRecordView := StrToIntDef(pIdContasReceberItens, 0);
    lContasReceberItensModel.obterLista;

    lContasReceberItensModel := lContasReceberItensModel.ContasReceberItenssLista[0];

    lValorBaixa    := StrToFloat(pValorBaixa);
    lValorParcela  := lContasReceberItensModel.VLRPARCELA_REC;
    lValorRecebido := lContasReceberItensModel.VALORREC_REC;
    lValorAberto   := lValorParcela - lValorRecebido;

    if lValorBaixa > lValorAberto + 0.01 then
      CriaException('Valor informado maior que o valor em aberto');

    lValorAtualizar := lContasReceberItensModel.VALORREC_REC + StrToFloat(pValorBaixa);

    lContasReceberItensModel := lContasReceberItensModel.Alterar(pIdContasReceberItens);
    lContasReceberItensModel.VALORREC_REC  := lValorAtualizar;
    lContasReceberItensModel.DATABAIXA_REC := pDataPagamento;
    lContasReceberItensModel.SITUACAO_REC  := 'B';
    lContasReceberItensModel.Salvar;

    lContaCorrenteModel.objeto.Acao            := tacIncluir;
    lContaCorrenteModel.objeto.DATA_COR        := pDataPagamento;
    lContaCorrenteModel.objeto.TIPO_CTA        := 'C';
    lContaCorrenteModel.objeto.CODIGO_CTA      := pIdContaBaixa;
    lContaCorrenteModel.objeto.CODIGO_BAN      := pIdBancoBaixa;
    lContaCorrenteModel.objeto.CLIENTE_COR     := lContasReceberItensModel.CODIGO_CLI;
    lContaCorrenteModel.objeto.USUARIO_COR     := vIConexao.getUser.ID;
    lContaCorrenteModel.objeto.LOJA            := vIConexao.getEmpresa.LOJA;
    lContaCorrenteModel.objeto.STATUS          := 'A';
    lContaCorrenteModel.objeto.CONCILIADO_COR  := '.';
    lContaCorrenteModel.objeto.DR              := 'N';
    lContaCorrenteModel.objeto.PORTADOR_COR    := pIdPortadorBaixar;
    lContaCorrenteModel.objeto.FATURA_COR      := lContasReceberItensModel.FATURA_REC;
    lContaCorrenteModel.objeto.PARCELA_COR     := lContasReceberItensModel.PACELA_REC;
    lContaCorrenteModel.objeto.OBSERVACAO_COR  := pHistorico;
    lContaCorrenteModel.objeto.ID              := pIdContasReceberItens;
    lContaCorrenteModel.objeto.COMPETENCIA     := copy(pDataPagamento,1,2)+copy(pDataPagamento,7,4);
    lContaCorrenteModel.objeto.VALOR_COR       := pValorBaixa;
    lRetorno := lContaCorrenteModel.objeto.Salvar;

    if StrToFloatDef(pJurosDesconto, 0) > 0 then begin
      lContaCorrenteModel.objeto.Acao           := tacIncluir;
      lContaCorrenteModel.objeto.DATA_COR       := pDataPagamento;
      lContaCorrenteModel.objeto.TIPO_CTA       := IIF(pTipoAdicional = 'J', 'C', 'D');
      lContaCorrenteModel.objeto.CODIGO_CTA     := '222222';
      lContaCorrenteModel.objeto.OBSERVACAO_COR := IIF(pTipoAdicional = 'J', 'Rec.Juros fatura: ' + lContasReceberItensModel.FATURA_REC, 'Desconto fatura: '+lContasReceberItensModel.FATURA_REC);
      lContaCorrenteModel.objeto.CODIGO_BAN     := pIdBancoBaixa;
      lContaCorrenteModel.objeto.PORTADOR_COR   := pIdPortadorBaixar;
      lContaCorrenteModel.objeto.ID             := pIdContasReceberItens;
      lContaCorrenteModel.objeto.COMPETENCIA    := copy(pDataPagamento,1,2)+copy(pDataPagamento,7,4);
      lContaCorrenteModel.objeto.VALOR_COR      := pJurosDesconto;
      lRetorno := lContaCorrenteModel.objeto.Salvar;
    end;

    Result := lRetorno <> '';

  finally
    lContasReceberItensModel.Free;
    lContaCorrenteModel := nil;
  end;
end;

function TSituacaoFinanceiraModel.EstornarBanco(pFatura, pParcela: String) : Boolean;
var
  lContasReceberItensModel : TContasReceberItensModel;
  lSituacaoFinanceira      : TSituacaoFinanceiraModel;
  lContaCorrenteModel      : ITContaCorrenteModel;
  lIFDDataset              : IFDDataset;
  lValor   : Double;
  lParcela : Integer;
  lNumero, lTipo, lBanco, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta : String;
begin
  lSituacaoFinanceira      := TSituacaoFinanceiraModel.Create(vIConexao);
  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);
  lContaCorrenteModel      := TContaCorrenteModel.getNewIface(vIConexao);

  Result := False;

  try
    lContasReceberItensModel.WhereView := 'and contasreceberitens.pacela_rec = '+ pParcela +' and contasreceberitens.fatura_rec = '+ QuotedStr(pFatura);
    lContasReceberItensModel.obterLista;
    lContasReceberItensModel := lContasReceberItensModel.ContasReceberItenssLista[0];

    lIFDDataset := lSituacaoFinanceira.RegistroBanco(pFatura, pParcela);

    if ((not lIFDDataset.objeto.IsEmpty) and (lIFDDataset.objeto.FieldByName('LANCAMENTOVALOR').AsFloat <> lContasReceberItensModel.VALORREC_REC)) then
      criaException('Não foi possível fazer o estorno.'+SLineBreak+'Baixa parcial deve ser estornado diretamente no banco');

    if lIFDDataset.objeto.RecordCount > 0 then begin

      lNumero := lIFDDataset.objeto.FieldByName('LANCAMENTONUMERO').AsString;
      lContaCorrenteModel.objeto.AlterarStatus(lValor, lParcela, lTipo, lBanco, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta, lNumero, 'X');
      lContaCorrenteModel.objeto.RegistroEstorno('000000', lBanco, lCliente, lNumero, lDuplicata, lLoja, lConciliado, lValor);
      lContasReceberItensModel.voltarParcela(lContasReceberItensModel.ID, lValor);

      lIFDDataset := lSituacaoFinanceira.RegistroBancoJuros(pFatura, pParcela);

      if lIFDDataset.objeto.RecordCount > 0 then begin

        lNumero := lIFDDataset.objeto.FieldByName('LANCAMENTONUMERO').AsString;
        lContaCorrenteModel.objeto.AlterarStatus(lValor, lParcela, lTipo, lBanco, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta, lNumero, 'X');
        lContaCorrenteModel.objeto.RegistroEstorno('000000', lBanco, lCliente, lNumero, lDuplicata, lLoja, lConciliado, lValor);

      end;
      Result := True;
    end;
  finally
    lContasReceberItensModel.Free;
    lSituacaoFinanceira := nil;
    lContaCorrenteModel := nil;
    lIFDDataset := nil;
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
