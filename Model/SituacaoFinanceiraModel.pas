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
    function realizarBaixaBanco(pIdContasReceberItens, pIdBancoBaixa, pIdContaBaixa, pIdSubGrupoBaixa, pIdPortadorBaixar, pValorBaixa, pJurosDesconto, pTipoAdicional, pDataPagamento, pHistorico: String): Boolean;

    function RegistroCaixa(pFatura, pParcela: String): IFDDataset;
    function RegistroCaixaJuros(pFatura, pParcela: String): IFDDataset;
    function EstornarCaixa(pFatura, pParcela: String): Boolean;
    function realizarBaixaCaixa(pIdContasReceberItens, pIdContaBaixa, pIdSubGrupoBaixa, pIdPortadorBaixar, pValorBaixa, pJurosDesconto, pTipoAdicional, pDataPagamento, pHistorico: String): Boolean;

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
  ContaCorrenteModel,
  CaixaModel,
  CaixaControleModel,
  AdmCartaoModel,
  PortadorModel;

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

function TSituacaoFinanceiraModel.realizarBaixaBanco(pIdContasReceberItens, pIdBancoBaixa, pIdContaBaixa, pIdSubGrupoBaixa, pIdPortadorBaixar, pValorBaixa, pJurosDesconto, pTipoAdicional, pDataPagamento, pHistorico: String): Boolean;
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
    lContaCorrenteModel.objeto.CENTRO_CUSTO    := pIdSubGrupoBaixa;
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
      lContaCorrenteModel.objeto.CENTRO_CUSTO    := pIdSubGrupoBaixa;
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
  lNumero, lTipo, lBanco, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta, lSubGrupo : String;
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
      lContaCorrenteModel.objeto.AlterarStatus(lValor, lParcela, lTipo, lBanco, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta, lNumero, 'X', lSubGrupo);
      lContaCorrenteModel.objeto.RegistroEstorno('000000', lBanco, lCliente, lNumero, lDuplicata, lLoja, lConciliado, lValor, lSubGrupo);
      lContasReceberItensModel.voltarParcela(lContasReceberItensModel.ID, lValor);

      lIFDDataset := lSituacaoFinanceira.RegistroBancoJuros(pFatura, pParcela);

      if lIFDDataset.objeto.RecordCount > 0 then begin

        lNumero := lIFDDataset.objeto.FieldByName('LANCAMENTONUMERO').AsString;
        lContaCorrenteModel.objeto.AlterarStatus(lValor, lParcela, lTipo, lBanco, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta, lNumero, 'X', lSubGrupo);
        lContaCorrenteModel.objeto.RegistroEstorno('000000', lBanco, lCliente, lNumero, lDuplicata, lLoja, lConciliado, lValor, lSubGrupo);

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

function TSituacaoFinanceiraModel.RegistroCaixa(pFatura, pParcela: String): IFDDataset;
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    Result := lSituacaoFinanceiraLista.RegistroCaixa(pFatura, pParcela);
  finally
    lSituacaoFinanceiraLista := nil;
  end;
end;

function TSituacaoFinanceiraModel.RegistroCaixaJuros(pFatura, pParcela: String): IFDDataset;
var
  lSituacaoFinanceiraLista: TSituacaoFinanceiraDao;
begin
  lSituacaoFinanceiraLista := TSituacaoFinanceiraDao.Create(vIConexao);
  try
    Result := lSituacaoFinanceiraLista.RegistroCaixaJuros(pFatura, pParcela);
  finally
    lSituacaoFinanceiraLista := nil;
  end;
end;

function TSituacaoFinanceiraModel.realizarBaixaCaixa(pIdContasReceberItens, pIdContaBaixa, pIdSubGrupoBaixa, pIdPortadorBaixar, pValorBaixa, pJurosDesconto, pTipoAdicional, pDataPagamento, pHistorico: String): Boolean;
var
  lContasReceberItensModel: TContasReceberItensModel;
  lCaixaModel: ITCaixaModel;
  lPortadorModel : ITPortadorModel;
  lCaixaControleModel: ITCaixaControleModel;
  lAdmCartaoModel: ITAdmCartaoModel;
  lRetorno: String;
  lValorAtualizar, lValorAberto, lValorParcela, lValorRecebido, lValorBaixa: Double;
begin
  lCaixaModel              := TCaixaModel.getNewIface(vIConexao);
  lPortadorModel           := TPortadorModel.getNewIface(vIConexao);
  lAdmCartaoModel          := TAdmCartaoModel.getNewIface(vIConexao);
  lCaixaControleModel      := TCaixaControleModel.getNewIface(vIConexao);
  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);

  try
    if pIdContasReceberItens = '' then
      CriaException('Contas a receber não informado para baixa');

    lCaixaControleModel.objeto.validateCaixa;

    lAdmCartaoModel.objeto.WhereView := ' and coalesce(STATUS,''A'') = ''A''  and PORTADOR_ID = '+QuotedStr(pIdPortadorBaixar);
    lAdmCartaoModel.objeto.obterLista;

    if lAdmCartaoModel.objeto.AdmCartaosLista.Count > 0 then
    begin
      lPortadorModel.objeto.IDRecordView := pIdPortadorBaixar;
      lPortadorModel.objeto.obterLista;
      lPortadorModel := lPortadorModel.objeto.PortadorsLista[0];
      CriaException('Venda em '+lPortadorModel.objeto.NOME_PORT+' não pode ser baixada no CAIXA. Voce deve usar a baixa pelo conta cliente.');
    end;

    if pValorBaixa = '' then
      CriaException('Valor pago não informado');

    if StrToFloatDef(pValorBaixa, 0) <= 0 then
      CriaException('Valor pago inválido');

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

    lCaixaModel.objeto.Acao         := tacIncluir;
    lCaixaModel.objeto.ID           := pIdContasReceberItens;
    lCaixaModel.objeto.CLIENTE_CAI  := lContasReceberItensModel.CODIGO_CLI;
    lCaixaModel.objeto.CODIGO_CTA   := pIdContaBaixa;
    lCaixaModel.objeto.CENTRO_CUSTO := pIdSubGrupoBaixa;
    lCaixaModel.objeto.TIPO_CAI     := 'C';
    lCaixaModel.objeto.USUARIO_CAI  := vIConexao.getUser.ID;
    lCaixaModel.objeto.LOJA         := vIConexao.getEmpresa.LOJA;
    lCaixaModel.objeto.DATA_CAI     := pDataPagamento;
    lCaixaModel.objeto.PORTADOR_CAI := pIdPortadorBaixar;
    lCaixaModel.objeto.FATURA_CAI   := lContasReceberItensModel.FATURA_REC;
    lCaixaModel.objeto.PARCELA_CAI  := lContasReceberItensModel.PACELA_REC;

    if pIdPortadorBaixar = '000004' then
      lCaixaModel.objeto.STATUS := 'D'
    else
    if pIdPortadorBaixar = '000002' then
      lCaixaModel.objeto.STATUS := 'C'
    else
      lCaixaModel.objeto.STATUS := 'A';

    lCaixaModel.objeto.COMPETENCIA     := copy(pDataPagamento,1,2)+copy(pDataPagamento,7,4);
    lCaixaModel.objeto.CONCILIADO_CAI  := '.';
    lCaixaModel.objeto.DR              := 'N';
    lCaixaModel.objeto.HISTORICO_CAI  := pHistorico;
    lCaixaModel.objeto.VALOR_CAI       := pValorBaixa;
    lRetorno := lCaixaModel.objeto.Salvar;

    if StrToFloatDef(pJurosDesconto, 0) > 0 then begin
      lCaixaModel.objeto.Acao         := tacIncluir;
      lCaixaModel.objeto.ID           := pIdContasReceberItens;
      lCaixaModel.objeto.CLIENTE_CAI  := lContasReceberItensModel.CODIGO_CLI;
      lCaixaModel.objeto.CODIGO_CTA   := IIF(pTipoAdicional = 'J', '222222', '300000');
      lCaixaModel.objeto.CENTRO_CUSTO := pIdSubGrupoBaixa;
      lCaixaModel.objeto.LOJA         := vIConexao.getEmpresa.LOJA;
      lCaixaModel.objeto.TIPO_CAI     := IIF(pTipoAdicional = 'J', 'C', 'D');
      lCaixaModel.objeto.DATA_CAI     := pDataPagamento;
      lCaixaModel.objeto.PORTADOR_CAI := pIdPortadorBaixar;
      lCaixaModel.objeto.FATURA_CAI   := lContasReceberItensModel.FATURA_REC;
      lCaixaModel.objeto.PARCELA_CAI  := lContasReceberItensModel.PACELA_REC;

      if pIdPortadorBaixar = '000004' then
        lCaixaModel.objeto.STATUS := 'D'
      else
      if pIdPortadorBaixar = '000002' then
        lCaixaModel.objeto.STATUS := 'C'
      else
        lCaixaModel.objeto.STATUS := 'A';

      lCaixaModel.objeto.COMPETENCIA   := copy(pDataPagamento,1,2)+copy(pDataPagamento,7,4);
      lCaixaModel.objeto.HISTORICO_CAI := IIF(pTipoAdicional = 'J', 'Rec.Juros fatura: ' + lContasReceberItensModel.FATURA_REC, 'Desconto fatura: '+lContasReceberItensModel.FATURA_REC);
      lCaixaModel.objeto.VALOR_CAI     := pJurosDesconto;
      lRetorno := lCaixaModel.objeto.Salvar;
    end;

    Result := lRetorno <> '';
  finally
    lCaixaModel := nil;
    lPortadorModel := nil;
    lAdmCartaoModel := nil;
    lCaixaControleModel := nil;
    lContasReceberItensModel.Free;
  end;
end;

function TSituacaoFinanceiraModel.EstornarCaixa(pFatura, pParcela: String) : Boolean;
var
  lContasReceberItensModel : TContasReceberItensModel;
  lSituacaoFinanceira      : TSituacaoFinanceiraModel;
  lCaixaModel              : ITCaixaModel;
  lIFDDataset              : IFDDataset;
  lValor   : Double;
  lParcela : Integer;
  lNumero, lTipo, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta, lSubGrupo : String;
begin
  lSituacaoFinanceira      := TSituacaoFinanceiraModel.Create(vIConexao);
  lContasReceberItensModel := TContasReceberItensModel.Create(vIConexao);
  lCaixaModel              := TCaixaModel.getNewIface(vIConexao);

  Result := False;

  try
    lContasReceberItensModel.WhereView := 'and contasreceberitens.pacela_rec = '+ pParcela +' and contasreceberitens.fatura_rec = '+ QuotedStr(pFatura);
    lContasReceberItensModel.obterLista;
    lContasReceberItensModel := lContasReceberItensModel.ContasReceberItenssLista[0];

    lIFDDataset := lSituacaoFinanceira.RegistroCaixa(pFatura, pParcela);

    if ((not lIFDDataset.objeto.IsEmpty) and (lIFDDataset.objeto.FieldByName('LANCAMENTOVALOR').AsFloat <> lContasReceberItensModel.VALORREC_REC)) then
      criaException('Não foi possível fazer o estorno.'+SLineBreak+'Baixa parcial deve ser estornado diretamente no caixa');

    if lIFDDataset.objeto.RecordCount > 0 then begin

      lNumero := lIFDDataset.objeto.FieldByName('LANCAMENTONUMERO').AsString;
      lCaixaModel.objeto.AlterarStatus(lValor, lParcela, lTipo, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta, lNumero, 'X', lSubGrupo);
      lCaixaModel.objeto.RegistroEstorno('000000', lCliente, lNumero, lDuplicata, lLoja, lConciliado, lValor, lSubGrupo);
      lContasReceberItensModel.voltarParcela(lContasReceberItensModel.ID, lValor);

      lIFDDataset := lSituacaoFinanceira.RegistroCaixaJuros(pFatura, pParcela);

      if lIFDDataset.objeto.RecordCount > 0 then begin

        lNumero := lIFDDataset.objeto.FieldByName('LANCAMENTONUMERO').AsString;
        lCaixaModel.objeto.AlterarStatus(lValor, lParcela, lTipo, lPortador, lDuplicata, lCliente, lLoja, lConciliado, lConta, lNumero, 'X', lSubGrupo);
        lCaixaModel.objeto.RegistroEstorno('000000', lCliente, lNumero, lDuplicata, lLoja, lConciliado, lValor, lSubGrupo);

      end;
      Result := True;
    end;
  finally
    lContasReceberItensModel.Free;
    lSituacaoFinanceira := nil;
    lCaixaModel := nil;
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
