unit uTeste;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Terasoft.Types,
  Conexao,
  Interfaces.Conexao, EntradaModel, Vcl.Grids, XDBGrids, Data.DB,
  Terasoft.Configuracoes, Terasoft.FuncoesTexto;

type
  TForm1 = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    memoResultado: TMemo;
    btnFinanceiroPedido: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    btnTabelaPreco: TButton;
    btnTotais: TButton;
    btnSaldo: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button16: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    Button38: TButton;
    Button39: TButton;
    Button40: TButton;
    Button41: TButton;
    Button42: TButton;
    Button43: TButton;
    Button44: TButton;
    Button45: TButton;
    Button46: TButton;
    Button47: TButton;
    TabSheet2: TTabSheet;
    dbTeste2: TXDBGrid;
    Button48: TButton;
    dsTeste2: TDataSource;
    Button49: TButton;
    Button50: TButton;
    Button51: TButton;
    Button52: TButton;
    Button53: TButton;
    Button54: TButton;
    Button55: TButton;
    TabSheet3: TTabSheet;
    XDBGrid1: TXDBGrid;
    XDBGrid2: TXDBGrid;
    Button56: TButton;
    OpenDialog: TOpenDialog;
    dsEntrada: TDataSource;
    Button57: TButton;
    dsEntradaItens: TDataSource;
    Button58: TButton;
    Button59: TButton;
    Button60: TButton;
    Button61: TButton;
    Button62: TButton;
    TabSheet4: TTabSheet;
    XDBGrid3: TXDBGrid;
    Button63: TButton;
    Button64: TButton;
    Button65: TButton;
    Button66: TButton;
    dsOS: TDataSource;
    TabSheet5: TTabSheet;
    memoSimulador: TMemo;
    Button67: TButton;
    Button68: TButton;
    Button69: TButton;
    Button70: TButton;
    Button71: TButton;
    Button72: TButton;
    Button73: TButton;
    API: TTabSheet;
    MemoAPI: TMemo;
    Button74: TButton;
    Button75: TButton;
    TabSheet6: TTabSheet;
    XDBGrid4: TXDBGrid;
    dsPedidoCompra: TDataSource;
    Button76: TButton;
    Button77: TButton;
    XDBGrid5: TXDBGrid;
    Button78: TButton;
    dsPedidoCompraItens: TDataSource;
    Button79: TButton;
    Button80: TButton;
    Button81: TButton;
    Button82: TButton;
    Button83: TButton;
    Button84: TButton;
    BtnEndereco2: TButton;
    BtnEndereco3: TButton;
    BtnEndereco4: TButton;
    BtnEndereco1: TButton;
    TabSheet7: TTabSheet;
    Button91: TButton;
    Button90: TButton;
    XDBGrid6: TXDBGrid;
    dsProdutos: TDataSource;
    Transportadora: TTabSheet;
    Button89: TButton;
    Button92: TButton;
    Button93: TButton;
    Button94: TButton;
    Button95: TButton;
    Button96: TButton;
    Button97: TButton;
    Button98: TButton;
    Button99: TButton;
    Button100: TButton;
    Button101: TButton;
    Button102: TButton;
    TabSheet8: TTabSheet;
    Button103: TButton;
    Button104: TButton;
    Button105: TButton;
    Button106: TButton;
    XDBGrid7: TXDBGrid;
    dsSaidas: TDataSource;
    Button107: TButton;
    Button108: TButton;
    Button109: TButton;
    Button110: TButton;
    Button111: TButton;
    Button85: TButton;
    Orcamento: TTabSheet;
    OrcamentoConsultar: TButton;
    OrcamentoAlterar: TButton;
    OrcamentoExcluir: TButton;
    OrcamentoIncluir: TButton;
    OrcamentoItensConsultar: TButton;
    OrcamentoItensAlterar: TButton;
    OrcamentoItensExcluir: TButton;
    OrcamentoItensIncluir: TButton;
    tabReserva: TTabSheet;
    btnReserva: TButton;
    Button86: TButton;
    tabLiberacao: TTabSheet;
    btnConsultaDesconto: TButton;
    XDBGrid8: TXDBGrid;
    dLiberacao: TDataSource;
    btnConsultaPermissao: TButton;
    btnPermissaoRemota: TButton;
    Button87: TButton;
    procedure btnFinanceiroPedidoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure btnTabelaPrecoClick(Sender: TObject);
    procedure btnTotaisClick(Sender: TObject);
    procedure btnSaldoClick(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure Button40Click(Sender: TObject);
    procedure Button41Click(Sender: TObject);
    procedure Button42Click(Sender: TObject);
    procedure Button43Click(Sender: TObject);
    procedure Button44Click(Sender: TObject);
    procedure Button45Click(Sender: TObject);
    procedure Button46Click(Sender: TObject);
    procedure Button47Click(Sender: TObject);
    procedure Button48Click(Sender: TObject);
    procedure Button49Click(Sender: TObject);
    procedure Button50Click(Sender: TObject);
    procedure Button51Click(Sender: TObject);
    procedure Button52Click(Sender: TObject);
    procedure Button53Click(Sender: TObject);
    procedure Button54Click(Sender: TObject);
    procedure Button55Click(Sender: TObject);
    procedure Button56Click(Sender: TObject);
    procedure Button57Click(Sender: TObject);
    procedure Button58Click(Sender: TObject);
    procedure Button59Click(Sender: TObject);
    procedure Button60Click(Sender: TObject);
    procedure Button61Click(Sender: TObject);
    procedure Button62Click(Sender: TObject);
    procedure Button64Click(Sender: TObject);
    procedure Button63Click(Sender: TObject);
    procedure Button65Click(Sender: TObject);
    procedure Button66Click(Sender: TObject);
    procedure Button67Click(Sender: TObject);
    procedure Button68Click(Sender: TObject);
    procedure Button69Click(Sender: TObject);
    procedure Button70Click(Sender: TObject);
    procedure Button71Click(Sender: TObject);
    procedure Button72Click(Sender: TObject);
    procedure Button73Click(Sender: TObject);
    procedure Button74Click(Sender: TObject);
    procedure Button75Click(Sender: TObject);
    procedure Button76Click(Sender: TObject);
    procedure Button77Click(Sender: TObject);
    procedure Button78Click(Sender: TObject);
    procedure Button79Click(Sender: TObject);
    procedure Button80Click(Sender: TObject);
    procedure Button84Click(Sender: TObject);
    procedure Button81Click(Sender: TObject);
    procedure Button82Click(Sender: TObject);
    procedure Button83Click(Sender: TObject);
    procedure Button88Click(Sender: TObject);
    procedure Button85Click(Sender: TObject);
    procedure Button86Click(Sender: TObject);
    procedure btnPermissaoClick(Sender: TObject);
    procedure Button90Click(Sender: TObject);
    procedure Button91Click(Sender: TObject);
    procedure Button94Click(Sender: TObject);
    procedure Button89Click(Sender: TObject);
    procedure Button92Click(Sender: TObject);
    procedure Button93Click(Sender: TObject);
    procedure Button95Click(Sender: TObject);
    procedure Button99Click(Sender: TObject);
    procedure Button96Click(Sender: TObject);
    procedure Button97Click(Sender: TObject);
    procedure Button98Click(Sender: TObject);
    procedure Button100Click(Sender: TObject);
    procedure Button101Click(Sender: TObject);
    procedure Button102Click(Sender: TObject);
    procedure Button103Click(Sender: TObject);
    procedure Button106Click(Sender: TObject);
    procedure Button105Click(Sender: TObject);
    procedure Button104Click(Sender: TObject);
    procedure Button107Click(Sender: TObject);
    procedure Button108Click(Sender: TObject);
    procedure Button109Click(Sender: TObject);
    procedure Button110Click(Sender: TObject);
    procedure Button111Click(Sender: TObject);
    procedure Button112Click(Sender: TObject);
    procedure BtnEndereco1Click(Sender: TObject);
    procedure BtnEndereco2Click(Sender: TObject);
    procedure BtnEndereco3Click(Sender: TObject);
    procedure BtnEndereco4Click(Sender: TObject);
    procedure OrcamentoIncluirClick(Sender: TObject);
    procedure OrcamentoAlterarClick(Sender: TObject);
    procedure OrcamentoExcluirClick(Sender: TObject);
    procedure OrcamentoConsultarClick(Sender: TObject);
    procedure OrcamentoItensIncluirClick(Sender: TObject);
    procedure OrcamentoItensConsultarClick(Sender: TObject);
    procedure OrcamentoItensAlterarClick(Sender: TObject);
    procedure OrcamentoItensExcluirClick(Sender: TObject);
    procedure btnReservaClick(Sender: TObject);
    procedure btnConsultaDescontoClick(Sender: TObject);
    procedure btnConsultaPermissaoClick(Sender: TObject);
    procedure btnPermissaoRemotaClick(Sender: TObject);
    procedure Button87Click(Sender: TObject);

  private
    { Private declarations }
    vQtdeRegistros,
    vPagina         : Integer;

  public
    { Public declarations }
    vIConexao : IConexao;
    vConfiguracoes : TerasoftConfiguracoes;
  end;

var
  Form1: TForm1;

implementation

uses
  FinanceiroPedidoModel,
  WebPedidoModel,
  Controllers.Conexao,
  FireDAC.Comp.Client,
  WebPedidoItensModel,
  TabelaJurosModel,
  SaldoModel, EmpresaModel, ProdutosModel, EntradaItensModel,
  ClienteModel, ContasPagarModel, ContasPagarItensModel, System.SysUtils,
  ReservaModel, DocumentoModel, AnexoModel, FluxoCaixaModel, BancoModel,
  PortadorModel, LojasModel, OSModel, SimuladorPrecoModel, GrupoModel, CNPJModel, CEPModel,
  PedidoCompraModel, PedidoCompraItensModel, ClientesContatoModel, DescontoModel,
  PromocaoModel, TransportadoraModel, PrevisaoPedidoCompraModel, SaidasModel,
  SaidasItensModel, ClientesEnderecoModel, OrcamentoModel, OrcamentoItensModel, Terasoft.Utils,
  SolicitacaoDescontoModel, PermissaoRemotaModel;

{$R *.dfm}

procedure TForm1.btnConsultaDescontoClick(Sender: TObject);
var
  lSolicitacaoDescontoModel : TSolicitacaoDescontoModel;
begin
  lSolicitacaoDescontoModel := TSolicitacaoDescontoModel.Create(vIConexao);
  try
    lSolicitacaoDescontoModel.WhereView := ' and solicitacao_desconto.tabela_origem = ''WEB_PEDIDO'' ';
    dLiberacao.DataSet := lSolicitacaoDescontoModel.obterLista;
  finally
    lSolicitacaoDescontoModel.Free;
  end;
end;

procedure TForm1.btnConsultaPermissaoClick(Sender: TObject);
var
  lPermissaoRemotaModel : TPermissaoRemotaModel;
  lVendaAssistida       : String;
begin
  lPermissaoRemotaModel := TPermissaoRemotaModel.Create(vIConexao);
  try
    lVendaAssistida := '4343';

    lPermissaoRemotaModel.WhereView := ' and permissao_remota.tabela = ''WEB_PEDIDOITENS'' and permissao_remota.pedido_id = '+lVendaAssistida;
    dLiberacao.DataSet := lPermissaoRemotaModel.obterLista;
  finally
    lPermissaoRemotaModel.Free;
  end;
end;

procedure TForm1.BtnEndereco1Click(Sender: TObject);
var
  lClientesEnderecoModel : TClientesEnderecoModel;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.Create(vIConexao);
  try
    try
      lClientesEnderecoModel.ID          := 10;
      lClientesEnderecoModel.CLIENTE_ID  := '000001';
      lClientesEnderecoModel.ENDERECO     := 'TESTE TERASOFT';

      lClientesEnderecoModel.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lClientesEnderecoModel.Free;
  end;
end;

procedure TForm1.BtnEndereco2Click(Sender: TObject);
var
  lClientesEnderecoModel : TClientesEnderecoModel;
  lMemTable   : TFDMemTable;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.Create(vIConexao);
  try
    try
      lMemTable := lClientesEnderecoModel.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
        memoResultado.Lines.Add('CLIENTE_ID: '+lMemTable.FieldByName('CLIENTE_ID').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClientesEnderecoModel.Free;
  end;
end;

procedure TForm1.BtnEndereco3Click(Sender: TObject);
var
  lClientesEnderecoModel : TClientesEnderecoModel;
  ID          : String;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.Create(vIConexao);
  try
    try
      ID := InputBox('CLIENTES_ENDERECO', 'Digite o ID do Contato que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lClientesEnderecoModel := lClientesEnderecoModel.Alterar(ID);
      lClientesEnderecoModel.ENDERECO := 'TESTE ALTERAR';

      lClientesEnderecoModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lClientesEnderecoModel.Free;
  end;
end;

procedure TForm1.BtnEndereco4Click(Sender: TObject);
var
  lClientesEnderecoModel : TClientesEnderecoModel;
  ID        : String;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.Create(vIConexao);
  try
    try
      ID := InputBox('CLIENTES_ENDERECO', 'Digite o ID do Contato que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lClientesEnderecoModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClientesEnderecoModel.Free;
  end;
end;

procedure TForm1.btnFinanceiroPedidoClick(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  lMemTable : TFDMemTable;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);
  try
    try
      lMemTable := lFinanceiroPedidoModel.obterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
        memoResultado.Lines.Add('PORTADOR_ID: '+lMemTable.FieldByName('PORTADOR_ID').AsString);
        memoResultado.Lines.Add('PORTADOR_NOME: '+lMemTable.FieldByName('NOME_PORT').AsString);
        memoResultado.Lines.Add('PARCELA: '+lMemTable.FieldByName('PARCELA').AsString);
        memoResultado.Lines.Add('VALOR_PARCELA: '+lMemTable.FieldByName('VALOR_PARCELA').AsString);
        memoResultado.Lines.Add('VALOR_TOTAL: '+lMemTable.FieldByName('VALOR_TOTAL').AsString);

        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel.Free;
  end;
end;

procedure TForm1.btnReservaClick(Sender: TObject);
var
  lReservaModel : TReservaModel;
  lWebPedidoItensModel : TWebPedidoItensModel;
begin
  lReservaModel        := TReservaModel.Create(vIConexao.NovaConexao('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA));
  lWebPedidoItensModel := TWebPedidoItensModel.Create(vIConexao);

  try
    lWebPedidoItensModel := lWebPedidoItensModel.carregaClasse('1091');

    lReservaModel.PRODUTO_ID          := lWebPedidoItensModel.PRODUTO_ID;
    lReservaModel.QUANTIDADE          :=lWebPedidoItensModel.QUANTIDADE;
    lReservaModel.VALOR_UNITARIO      := lWebPedidoItensModel.VALOR_UNITARIO;
    lReservaModel.OBSERVACAO          := 'Reservar realizada pela venda assistida N '+lWebPedidoItensModel.WEB_PEDIDO_ID;
    lReservaModel.WEB_PEDIDOITENS_ID  := lWebPedidoItensModel.ID;
    lReservaModel.WEB_PEDIDO_ID       := lWebPedidoItensModel.WEB_PEDIDO_ID;
    lReservaModel.TIPO                := lWebPedidoItensModel.TIPO;
    lReservaModel.ENTREGA             := lWebPedidoItensModel.ENTREGA;
    lReservaModel.RETIRA_LOJA         := IIF(lWebPedidoItensModel.TIPO_ENTREGA = 'LJ','S','N');;
    lReservaModel.STATUS              := IIF(lWebPedidoItensModel.TIPO_ENTREGA = 'LJ','L','1');
    lReservaModel.CLIENTE_ID          := '000000';
    lReservaModel.VENDEDOR_ID         := '000000';
    lReservaModel.FILIAL              := '000';

    lReservaModel.Incluir;

    lWebPedidoItensModel := lWebPedidoItensModel.carregaClasse('1091');

  finally
    lWebPedidoItensModel.Free;
    lReservaModel.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  lFinanceiroParams      : TFinanceiroParams;
  lTabelaJurosModel      : TTabelaJurosModel;
  lMemJuros              : TFDMemTable;
  lJuros,
  lValorPago             : Double;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);
  lTabelaJurosModel      := TTabelaJurosModel.Create(vIConexao);
  try
    try
      lValorPago := 10000;
      lMemJuros  := lTabelaJurosModel.obterLista('000005', lValorPago, true);

      lFinanceiroParams.WEB_PEDIDO_ID       := '422';
      lFinanceiroParams.PORTADOR_ID         := '000005';
      lFinanceiroParams.PRIMEIRO_VENCIMENTO := Date + 30;
      lFinanceiroParams.QUANTIDADE_PARCELAS := 5;

      lMemJuros.first;
      lMemJuros.locate('CODIGO', '005', []);

      lJuros := lMemJuros.FieldByName('VALOR_JUROS').AsFloat;
      lFinanceiroParams.INDCE_APLICADO      := lMemJuros.FieldByName('PERCENTUAL').AsFloat;
      lFinanceiroParams.VALOR_ACRESCIMO     := lJuros;

      lFinanceiroParams.VALOR_LIQUIDO       := lValorPago;
      lFinanceiroParams.VALOR_TOTAL         := lValorPago + lJuros;

      lFinanceiroPedidoModel.gerarFinanceiro(lFinanceiroParams);

      ShowMessage('Inserido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel.Free;
    lTabelaJurosModel.Free;
  end;
end;

procedure TForm1.Button20Click(Sender: TObject);
var
  lClienteModel : TClienteModel;
  lMemTable     : TFDMemTable;
  i             : Integer;
begin
  lClienteModel := TClienteModel.Create(vIConexao);
    try
      try
        lClienteModel.LengthPageView  := vQtdeRegistros.ToString;
        lClienteModel.StartRecordView := vPagina.ToString;
        lClienteModel.OrderView       := 'CODIGO_CLI';

        inc(vPagina, 10);

        lMemTable := lClienteModel.ObterListaMemTable;
        memoResultado.Lines.Clear;
        lMemTable.First;

      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('CODIGO_CLI: '+lMemTable.FieldByName('CODIGO_CLI').AsString);
        memoResultado.Lines.Add('FANTASIA_CLI: '+lMemTable.FieldByName('FANTASIA_CLI').AsString);
        memoResultado.Lines.Add('RAZAO_CLI: '+lMemTable.FieldByName('RAZAO_CLI').AsString);
        memoResultado.Lines.Add('CNPJ_CPF_CLI: '+lMemTable.FieldByName('CNPJ_CPF_CLI').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClienteModel.Free;
  end;
end;

procedure TForm1.Button21Click(Sender: TObject);
var
  lClienteModel : TClienteModel;
  ID            : String;
begin
  lClienteModel := TClienteModel.Create(vIConexao);
  try
    try
      ID := InputBox('Cliente', 'Digite o ID que deseja Alterar:', '');

      if ID.IsEmpty then
        exit;

      lClienteModel := lClienteModel.Alterar(ID);
      lClienteModel.fantasia_cli := 'TESTE ALTERA FANTASIA';

      lClienteModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lClienteModel.Free;
  end;
end;

procedure TForm1.Button22Click(Sender: TObject);
var
  lClienteModel : TClienteModel;
  CodCli        : String;
begin
  lClienteModel := TClienteModel.Create(vIConexao);
  try
    try
      CodCli := InputBox('Cliente', 'Digite o ID do Cliente que deseja excluir:', '');

      lClienteModel.Excluir(CodCli);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClienteModel.Free;
  end;
end;

procedure TForm1.Button23Click(Sender: TObject);
var
  lClienteModel : TClienteModel;
  NomeCli       : String;
begin
  lClienteModel := TClienteModel.Create(vIConexao);
  try
    try
      NomeCli := InputBox('Cliente', 'Digite o Nome:', '');

      if NomeCli.IsEmpty then
        exit;

      lClienteModel.fantasia_cli    := NomeCli;
      lClienteModel.tipo_cli        := 'F';
      lClienteModel.seprocado_cli   := 'N';
      lClienteModel.estadocivil_cli := 'O';
      lClienteModel.status          := 'A';
      lClienteModel.sexo_cli        := 'M';

      lClienteModel.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lClienteModel.Free;
  end;
end;

procedure TForm1.Button24Click(Sender: TObject);
var
  lContasPagarModel : TContasPagarModel;
  lFornecedor,
  lDuplicata    : String;

begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);
  try
    try
      lDuplicata  := '';
      lFornecedor := '';

      lContasPagarModel := lContasPagarModel.Alterar(lDuplicata, lFornecedor);
      lContasPagarModel.CODIGO_FOR := '000175';

      lContasPagarModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lContasPagarModel.Free;
  end;
end;

procedure TForm1.Button25Click(Sender: TObject);
var
  lContasPagarModel : TContasPagarModel;
  lMemTable         : TFDMemTable;
begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);
  try
    try

      lContasPagarModel.LengthPageView  := vQtdeRegistros.ToString;
      lContasPagarModel.StartRecordView := vPagina.ToString;
      lContasPagarModel.OrderView       := 'DUPLICATA_PAG';

      inc(vPagina, 10);

      lMemTable := lContasPagarModel.obterLista;
      memoResultado.Lines.Clear;
      lMemTable.First;

      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('DUPLICATA_PAG: '+lMemTable.FieldByName('DUPLICATA_PAG').AsString);
        memoResultado.Lines.Add('CODIGO_FOR: '+lMemTable.FieldByName('CODIGO_FOR').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.FieldByName('FORNECEDOR').AsString);
        memoResultado.Lines.Add('PORTADOR_ID: '+lMemTable.FieldByName('PORTADOR_ID').AsString);
        memoResultado.Lines.Add('PORTADOR: '+lMemTable.FieldByName('PORTADOR').AsString);
        memoResultado.Lines.Add('DATAEMI_PAG: '+lMemTable.FieldByName('DATAEMI_PAG').AsString);
        memoResultado.Lines.Add('TIPO_PAG: '+lMemTable.FieldByName('TIPO_PAG').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;

    Except
      on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarModel.Free;
  end;
end;

procedure TForm1.Button26Click(Sender: TObject);
var
  lContasPagarModel : TContasPagarModel;
  Duplicata, Fornecedor : String;

begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);
  try
    try
      Duplicata := InputBox('Cliente', 'Digite a Duplicata que deseja excluir:', '');

      if Duplicata.IsEmpty then
      Exit;

      lContasPagarModel.Excluir(Duplicata,Fornecedor);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarModel.Free;
  end;
end;

procedure TForm1.Button27Click(Sender: TObject);
var
  lContasPagarModel :  TContasPagarModel;
  Duplicata         : String;
begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);
  try
    try
      lContasPagarModel.gerarDuplicatas('9000002024', '500005');

      ShowMessage('Parcela adicionada com sucesso!');
    Except
      on E:Exception do
      ShowMessage('Erro inserir parcelas:' + E.Message);
    end;
  finally
    lContasPagarModel.Free;
  end;
end;

procedure TForm1.Button28Click(Sender: TObject);
var
  lContasPagarItensModel  : TContasPagarItensModel;
  Duplicata               : String;
  i                       : Integer;
  lMemTable               : TFDMemTable;
begin
  lContasPagarItensModel := TContasPagarItensModel.Create(vIConexao);
  try
    try
      Duplicata := InputBox('ContasPagar', 'Digite a Duplicata para consultar os itens:', '');
      if Duplicata.IsEmpty then
        exit;

      lContasPagarItensModel.DuplicataView := Duplicata;

      lMemTable := lContasPagarItensModel.obterLista;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('DUPLIACATA_PAG: '+lMemTable.FieldByName('DUPLIACATA_PAG').AsString);
        memoResultado.Lines.Add('CODIGO_FOR: '+lMemTable.FieldByName('CODIGO_FOR').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.FieldByName('FORNECEDOR').AsString);
        memoResultado.Lines.Add('PORTADOR_ID: '+lMemTable.FieldByName('PORTADOR_ID').AsString);
        memoResultado.Lines.Add('PORTADOR: '+lMemTable.FieldByName('PORTADOR').AsString);
        memoResultado.Lines.Add('VENC_PAG: '+lMemTable.FieldByName('VENC_PAG').AsString);
        memoResultado.Lines.Add('PACELA_PAG: '+lMemTable.FieldByName('PACELA_PAG').AsString);
        memoResultado.Lines.Add('VALORPARCELA_PAG: '+lMemTable.FieldByName('VALORPARCELA_PAG').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
    on E:Exception do
       ShowMessage('Erro consultar itens' + E.Message);
    end;
  finally
    lContasPagarItensModel.Free;
  end;
end;

procedure TForm1.Button29Click(Sender: TObject);
var
  lContasPagarItensModel : TContasPagarItensModel;
  pDuplicata,
  pIDItem        : String;
begin
  lContasPagarItensModel := TContasPagarItensModel.Create(vIConexao);
  try
    try
      pDuplicata := 'R00006';
      pIDItem    := '20198';

      lContasPagarItensModel := lContasPagarItensModel.Alterar(pDuplicata, pIDItem);
      lContasPagarItensModel.VENC_PAG := '10.05.2024';

      lContasPagarItensModel.Salvar;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  lContasPagarItensModel.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  IDRegistro             : String;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);

  try
    try
      IDRegistro := InputBox('FinanceiroPedido', 'Digite o ID do registro Financeiro:', '');

      if IDRegistro.IsEmpty then
        exit;

      lFinanceiroPedidoModel := lFinanceiroPedidoModel.Alterar(IDRegistro);
      lFinanceiroPedidoModel.WEB_PEDIDO_ID := '325';
      lFinanceiroPedidoModel.PORTADOR_ID   := '000001';
      lFinanceiroPedidoModel.VALOR_TOTAL   := '800';
      lFinanceiroPedidoModel.PARCELA       := '3';
      lFinanceiroPedidoModel.VALOR_PARCELA := '150';
      lFinanceiroPedidoModel.Salvar;

      ShowMessage('Alterado com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel.Free;
  end;
end;

procedure TForm1.Button30Click(Sender: TObject);
var
  lContasPagarItensModel : TContasPagarItensModel;
  NumParcela             : String;
begin
  lContasPagarItensModel := TContasPagarItensModel.Create(vIConexao);
  try
    try
      NumParcela := InputBox('ContasPagarItens','Digite o ID da parcela','');
      if NumParcela.IsEmpty then
        Exit;

      lContasPagarItensModel.Excluir(NumParcela);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarItensModel.Free;
  end;
end;

procedure TForm1.Button31Click(Sender: TObject);
var
  lEntradaItensParams : TEntradaItensParams;
  lEntradaModel       : TEntradaModel;
  lNumEntrada         : String;
begin
  lEntradaModel  := TEntradaModel.Create(vIConexao);
  try
    try
      lNumEntrada := InputBox('EntradaItens','Digite o número da Entrada:','');

      lEntradaItensParams.NUMERO_ENT      := lNumEntrada;
      lEntradaItensParams.CODIGO_FOR      := '500005';
      lEntradaItensParams.CODIGO_PRO      := '000444';
      lEntradaItensParams.QUANTIDADE_ENT  := '1';
      lEntradaItensParams.VALORUNI_ENT    := '30';

      lEntradaModel.EntradaItens(lEntradaItensParams);
      ShowMessage('Item adicionado a Entrada: ' + lNumEntrada);
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.Button32Click(Sender: TObject);
var
  lEntradaItensModel : TEntradaItensModel;
  NumEntrada         : String;
  i                  : Integer;
  lMemTable          : TFDMemTable;
begin
  lEntradaItensModel := TEntradaItensModel.Create(vIConexao);
  try
    try
      NumEntrada := InputBox('Constulta EntradaItens','Digite o número da Entrada:','');
        if NumEntrada.IsEmpty then
          Exit;

      lEntradaItensModel.NumeroView := NumEntrada;
      lEntradaItensModel.FornecedorView := '500007';
      lMemTable := lEntradaItensModel.obterLista;
      lMemTable.First;
      while not lMemTable.Eof do
      begin
         memoResultado.Lines.Add('NUMERO_ENT: ' +lMemTable.FieldByName('NUMERO_ENT').AsString);
         memoResultado.Lines.Add('PRODUTO_CODIGO_PRO: ' +lMemTable.FieldByName('PRODUTO_CODIGO_PRO').AsString);
         memoResultado.Lines.Add('CST: ' +lMemTable.FieldByName('CST').AsString);
         memoResultado.Lines.Add('VALOR_LIQUIDO: ' +lMemTable.FieldByName('VALOR_LIQUIDO').AsString);
         memoResultado.Lines.Add('TOTAL_UNITARIO: ' +lMemTable.FieldByName('TOTAL_UNITARIO').AsString);
         memoResultado.Lines.Add('ALIQUOTA_ICMS: ' +lMemTable.FieldByName('ALIQUOTA_ICMS').AsString);
         lMemTable.Next;
      end;
    except
      on E:Exception do
        ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaItensModel.Free;
  end;
end;

procedure TForm1.Button33Click(Sender: TObject);
var
  lEntradaItensModel : TEntradaItensModel;
  pIDItem            : String;
begin
  lEntradaItensModel := TEntradaItensModel.Create(vIConexao);
  try
    try
      pIDItem        := '1916';

      lEntradaItensModel := lEntradaItensModel.Alterar(pIDItem);
      lEntradaItensModel.QUANTIDADE_ENT := '5';
      lEntradaItensModel.Salvar;
      ShowMessage('Alterado com sucesso');
    except
      on E:Exception do
        ShowMessage('Erro: ' + E.Message);
    end;
    finally
      lEntradaItensModel.Free;
  end;
end;

procedure TForm1.Button34Click(Sender: TObject);
var
  lEntradaItensModel : TEntradaItensModel;
  ID                 : String;
begin
  lEntradaItensModel := TEntradaItensModel.Create(vIConexao);
  try
    try
      ID := '1916';
      lEntradaItensModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaItensModel.Free;
  end;
end;

procedure TForm1.Button35Click(Sender: TObject);
var
  lReservaModel : TReservaModel;
  lCodPro       : String;
begin
  lReservaModel := TReservaModel.Create(vIConexao);
  try
    try
    lCodPro := InputBox('Reservar','Digite o código do Produto:','');
      if lCodPro.IsEmpty then
        Exit;

    lReservaModel.PRODUTO_ID   := lCodPro;
    lReservaModel.CLIENTE_ID   := '700504';
    lReservaModel.VENDEDOR_ID  := '000007';
    lReservaModel.QUANTIDADE   := '10';
    lReservaModel.STATUS       := 'L';
    lReservaModel.FILIAL       := '002';

    lReservaModel.Incluir;

    ShowMessage('Produto: '+ lCodPro +', reservado! ');
    except
     on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lReservaModel.Free;
  end;
end;

procedure TForm1.Button36Click(Sender: TObject);
var
  lReservaModel : TReservaModel;
  lMemTable : TFDMemTable;
begin
  lReservaModel := TReservaModel.Create(vIConexao);
  try
    try
      lMemTable := lReservaModel.obterLista;
      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
        memoResultado.Lines.Add('PRODUTO_ID: '+lMemTable.FieldByName('PRODUTO_ID').AsString);
        memoResultado.Lines.Add('PRODUTO: '+lMemTable.FieldByName('PRODUTO').AsString);
        memoResultado.Lines.Add('VENDEDOR_ID: '+lMemTable.FieldByName('VENDEDOR_ID').AsString);
        memoResultado.Lines.Add('VENDEDOR: '+lMemTable.FieldByName('VENDEDOR').AsString);
        memoResultado.Lines.Add('QUANTIDADE: '+lMemTable.FieldByName('QUANTIDADE').AsString);
        memoResultado.Lines.Add('HORAS_BAIXA: '+lMemTable.FieldByName('HORAS_BAIXA').AsString);
        memoResultado.Lines.Add('STATUS: '+lMemTable.FieldByName('STATUS').AsString);
        memoResultado.Lines.Add('FILIAL: '+lMemTable.FieldByName('FILIAL').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lReservaModel.Free;
  end;
end;

procedure TForm1.Button37Click(Sender: TObject);
var
  lReservaModel : TReservaModel;
  ID            : String;
begin
  lReservaModel := TReservaModel.Create(vIConexao);
  try
    try
      ID := InputBox('Reserva', 'Digite o ID que deseja Alterar:', '');

      if ID.IsEmpty then
        exit;

      lReservaModel := lReservaModel.Alterar(ID);
      lReservaModel.PRODUTO_ID := '000007';
      lReservaModel.VENDEDOR_ID := '000007';

      lReservaModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lReservaModel.Free;
  end;
end;

procedure TForm1.Button38Click(Sender: TObject);
var
  lReservaModel : TReservaModel;
  ID        : String;
begin
  lReservaModel := TReservaModel.Create(vIConexao);
  try
    try
      ID := InputBox('Reserva', 'Digite o ID da Reserva que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lReservaModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lReservaModel.Free;
  end;
end;

procedure TForm1.Button39Click(Sender: TObject);
var
  lDocumentoModel : TDocumentoModel;
  lDescricao      : String;
begin
  lDocumentoModel := TDocumentoModel.Create(vIConexao);
  try
    try
      lDescricao := InputBox('Documento','Digite a descricao: ','');
      if lDescricao.IsEmpty then
      Exit;

      lDocumentoModel.NOME := lDescricao;
      lDocumentoModel.Incluir;

      ShowMessage('Documento incluido com sucesso');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDocumentoModel.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  IDFinanceiro             : String;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);

  try
    try
      IDFinanceiro := InputBox('FinanceiroPedido', 'Digite o ID Financeiro para excluir:', '');

      if IDFinanceiro.IsEmpty then
        exit;

      lFinanceiroPedidoModel.Excluir(IDFinanceiro);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro do Except: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel.Free;
  end;
end;

procedure TForm1.Button40Click(Sender: TObject);
var
  lDocumentoModel : TDocumentoModel;
  lMemTable : TFDMemTable;
begin
  lDocumentoModel := TDocumentoModel.Create(vIConexao);
  try
    try
      lMemTable := lDocumentoModel.obterLista;
      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
        memoResultado.Lines.Add('NOME: '+lMemTable.FieldByName('NOME').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDocumentoModel.Free;
  end;
end;

procedure TForm1.Button41Click(Sender: TObject);
var
  lDocumentoModel : TDocumentoModel;
  ID              : String;
begin
  lDocumentoModel := TDocumentoModel.Create(vIConexao);
  try
    try
      ID := InputBox('Documento', 'Digite o ID que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lDocumentoModel := lDocumentoModel.Alterar(ID);
      lDocumentoModel.NOME := 'TESTE DOC NOME';

      lDocumentoModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lDocumentoModel.Free;
  end;
end;

procedure TForm1.Button42Click(Sender: TObject);
var
  lDocumentoModel : TDocumentoModel;
  ID        : String;
begin
  lDocumentoModel := TDocumentoModel.Create(vIConexao);
  try
    try
      ID := InputBox('Documento', 'Digite o ID do Documento que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lDocumentoModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDocumentoModel.Free;
  end;
end;

procedure TForm1.Button43Click(Sender: TObject);
var
  lAnexoModel : TAnexoModel;
  lIDCli    : String;
begin
  lAnexoModel := TAnexoModel.Create(vIConexao);
  try
    try
      lIDCli :=  InputBox('ANEXO','Digite ID do Cliente:','');
      if lIDCli.IsEmpty then
      Exit;

      lAnexoModel.REGISTRO_ID   := lIDCli;
      lAnexoModel.TABELA        := 'CLIENTES';
      lAnexoModel.DOCUMENTO_ID  := '2';

      lAnexoModel.Incluir;
      ShowMessage('Incluido com sucesso');
    except
       on E:Exception do
         ShowMessage('Erro: ' + E.Message);
      end;
  finally
    lAnexoModel.Free;
  end;
end;

procedure TForm1.Button44Click(Sender: TObject);
var
  lAnexoModel : TAnexoModel;
  lMemTable : TFDMemTable;
begin
  lAnexoModel := TAnexoModel.Create(vIConexao);
  try
    try
      lMemTable := lAnexoModel.obterLista;
      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
        memoResultado.Lines.Add('TABELA: '+lMemTable.FieldByName('TABELA').AsString);
        memoResultado.Lines.Add('REGISTRO_ID: '+lMemTable.FieldByName('REGISTRO_ID').AsString);
        memoResultado.Lines.Add('DOCUMENTO_ID: '+lMemTable.FieldByName('DOCUMENTO_ID').AsString);
        memoResultado.Lines.Add('DOCUMENTO_NOME: '+lMemTable.FieldByName('DOCUMENTO_NOME').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lAnexoModel.Free;
  end;
end;

procedure TForm1.Button45Click(Sender: TObject);
var
  lAnexoModel : TAnexoModel;
  ID          : String;
begin
  lAnexoModel := TAnexoModel.Create(vIConexao);
  try
    try
      ID := InputBox('ANEXO', 'Digite o ID que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lAnexoModel := lAnexoModel.Alterar(ID);
      lAnexoModel.REGISTRO_ID := '3';

      lAnexoModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lAnexoModel.Free;
  end;
end;

procedure TForm1.Button46Click(Sender: TObject);
var
  lAnexoModel : TAnexoModel;
  ID        : String;
begin
  lAnexoModel := TAnexoModel.Create(vIConexao);
  try
    try
      ID := InputBox('ANEXO', 'Digite o ID do Anexo que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lAnexoModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lAnexoModel.Free;
  end;
end;

procedure TForm1.Button47Click(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  lPedidoWeb             : String;
  lMemTable              : TFDMemTable;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);
  try
    try
      lPedidoWeb := InputBox('ObterResumo','Digite o número do Web Pedido para consultar:','');
      if lPedidoWeb.IsEmpty then
      Exit;

      lMemTable := lFinanceiroPedidoModel.obterResumo(lPedidoWeb);
      memoResultado.Lines.Clear;
      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('WEB_PEDIDO_ID: '+lMemTable.FieldByName('WEB_PEDIDO_ID').AsString);
        memoResultado.Lines.Add('ID_FINANCEIRO: '+lMemTable.FieldByName('ID_FINANCEIRO').AsString);
        memoResultado.Lines.Add('CODIGO_PORT: '+lMemTable.FieldByName('CODIGO_PORT').AsString);
        memoResultado.Lines.Add('NOME_PORT: '+lMemTable.FieldByName('NOME_PORT').AsString);
        memoResultado.Lines.Add('QUANTIDADE_PARCELAS: '+lMemTable.FieldByName('QUANTIDADE_PARCELAS').AsString);
        memoResultado.Lines.Add('VALOR_PARCELAS: '+lMemTable.FieldByName('VALOR_PARCELA').AsString);
        memoResultado.Lines.Add('VALOR_TOTAL: '+lMemTable.FieldByName('VALOR_TOTAL').AsString);
        memoResultado.Lines.Add('VALOR_LIQUIDO: '+lMemTable.FieldByName('VALOR_LIQUIDO').AsString);
        memoResultado.Lines.Add('VENCIMENTO: '+lMemTable.FieldByName('VENCIMENTO').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel.free;
  end;
end;

procedure TForm1.Button48Click(Sender: TObject);
var
  lFluxoCaixaModel : TFluxoCaixaModel;
  lMemTable        : TFDMemTable;
begin
  lFluxoCaixaModel := TFluxoCaixaModel.Create(vIConexao);
  try
    try
      lFluxoCaixaModel.DataInicialView := '01/01/2023';
      lFluxoCaixaModel.DataFinalView   := '12/12/2024';
      lFluxoCaixaModel.PortadorView    := '000001';
      lFluxoCaixaModel.OrderView       := 'RECEBER';
//      lFluxoCaixaModel.LojaView        := '001';

      lMemTable := lFluxoCaixaModel.obterFluxoCaixaSintetico;
      dsTeste2.DataSet := lMemTable;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFluxoCaixaModel.Free;
  end;
end;

procedure TForm1.Button49Click(Sender: TObject);
var
  lFluxoCaixaModel : TFluxoCaixaModel;
  lMemTable        : TFDMemTable;
begin
  lFluxoCaixaModel := TFluxoCaixaModel.Create(vIConexao);
  try
    try
      lFluxoCaixaModel.DataInicialView := '01/01/2023';
      lFluxoCaixaModel.DataFinalView   := '12/12/2024';
//      lFluxoCaixaModel.LojaView        := '001';

      //Para localizar um tipo especifico
      lFluxoCaixaModel.TipoView        := 'RECEBER';

      lMemTable := lFluxoCaixaModel.obterFluxoCaixaAnalitico;
      dsTeste2.DataSet := lMemTable;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFluxoCaixaModel.Free;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  lWebPedidoModel : TWebPedidoModel;
  i               : Integer;
  lMemTable       : TFDMemTable;
  lPedidoWeb      : String;
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try

    lPedidoWeb := InputBox('ObterResumo','Digite o número do Web Pedido para consultar:','');

    lWebPedidoModel.LengthPageView  := vQtdeRegistros.ToString;
    lWebPedidoModel.StartRecordView := vPagina.ToString;
    lWebPedidoModel.OrderView       := 'id';
    lWebPedidoModel.IDRecordView    := StrToInt(lPedidoWeb);

    lMemTable := lWebPedidoModel.obterLista;

    inc(vPagina, 10);

    memoResultado.Lines.Clear;

    lMemTable.First;
    while not lMemTable.eof do
    begin
      memoResultado.Lines.Add('ID: '+ lMemTable.FieldByName('ID').AsString);
      memoResultado.Lines.Add('CODIGO_CLI: '+ lMemTable.FieldByName('CODIGO_CLI').AsString);
      memoResultado.Lines.Add('CLIENTE_NOME: '+ lMemTable.FieldByName('CLIENTE_NOME').AsString);
      memoResultado.Lines.Add('ENTREGA_ENDERECO: '+ lMemTable.FieldByName('ENTREGA_ENDERECO').AsString);
      memoResultado.Lines.Add('ENTREGA_NUMERO: '+ lMemTable.FieldByName('ENTREGA_NUMERO').AsString);
      memoResultado.Lines.Add('ENTREGA_COD_MUNICIPIO: '+ lMemTable.FieldByName('ENTREGA_COD_MUNICIPIO').AsString);
      memoResultado.Lines.Add('ENTREGA_CEP: '+ lMemTable.FieldByName('ENTREGA_CEP').AsString);
      memoResultado.Lines.Add('ENTREGA_COMPLEMENTO: '+ lMemTable.FieldByName('ENTREGA_COMPLEMENTO').AsString);
      memoResultado.Lines.Add('ENTREGA_CIDADE: '+ lMemTable.FieldByName('ENTREGA_CIDADE').AsString);
      memoResultado.Lines.Add('ENTREGA_BAIRRO: '+ lMemTable.FieldByName('ENTREGA_BAIRRO').AsString);
      memoResultado.Lines.Add('ENTREGA_UF: '+ lMemTable.FieldByName('ENTREGA_UF').AsString);
      memoResultado.Lines.Add('MONTAGEM_DATA: '+ lMemTable.FieldByName('MONTAGEM_DATA').AsString);
      memoResultado.Lines.Add('MONTAGEM_HORA: '+ lMemTable.FieldByName('MONTAGEM_HORA').AsString);
      memoResultado.Lines.Add('ENTREGA_DATA: '+ lMemTable.FieldByName('ENTREGA_DATA').AsString);
      memoResultado.Lines.Add('ENTREGA_HORA: '+ lMemTable.FieldByName('ENTREGA_HORA').AsString);
      memoResultado.Lines.Add('REGIAO_ID: '+ lMemTable.FieldByName('REGIAO_ID').AsString);
      memoResultado.Lines.Add('REGIAO: '+ lMemTable.FieldByName('REGIAO').AsString);
      memoResultado.Lines.Add('DATAHORA: '+ lMemTable.FieldByName('DATAHORA').AsString);
      memoResultado.Lines.Add('VENDEDOR: '+ lMemTable.FieldByName('VENDEDOR').AsString);
      memoResultado.Lines.Add('STATUS: '+ lMemTable.FieldByName('STATUS').AsString);
      memoResultado.Lines.Add('VALOR_FRETE: '+ lMemTable.FieldByName('VALOR_FRETE').AsString);
      memoResultado.Lines.Add('ACRESCIMO: '+ lMemTable.FieldByName('ACRESCIMO').AsString);
      memoResultado.Lines.Add('VALOR_ITENS: '+ lMemTable.FieldByName('VALOR_ITENS').AsString);
      memoResultado.Lines.Add('VALOR_GARANTIA: '+ lMemTable.FieldByName('VALOR_GARANTIA').AsString);
      memoResultado.Lines.Add('VALOR_CUPOM_DESCONTO: '+ lMemTable.FieldByName('VALOR_CUPOM_DESCONTO').AsString);
      memoResultado.Lines.Add('VALOR_TOTAL: '+ lMemTable.FieldByName('VALOR_TOTAL').AsString);
      memoResultado.Lines.Add('===============================================');

      lMemTable.Next;
    end;

  finally
    lWebPedidoModel.Free;
  end;

end;

procedure TForm1.Button50Click(Sender: TObject);
var
  lFluxoCaixaModel : TFluxoCaixaModel;
  lMemTable        : TFDMemTable;
begin
  lFluxoCaixaModel := TFluxoCaixaModel.Create(vIConexao);
  try
    try
      lFluxoCaixaModel.DataInicialView := '27/02/2024';
      lFluxoCaixaModel.DataFinalView   := '29/02/2024';

      lMemTable := lFluxoCaixaModel.obterResumo;
      dsTeste2.DataSet := lMemTable;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFluxoCaixaModel.Free;
  end;
end;

procedure TForm1.Button51Click(Sender: TObject);
var
  lFluxoCaixaModel : TFluxoCaixaModel;
  lMemTable        : TFDMemTable;
begin
  lFluxoCaixaModel := TFluxoCaixaModel.Create(vIConexao);
  try
    try
      lFluxoCaixaModel.DataInicialView := '27/02/2024';
      lFluxoCaixaModel.DataFinalView   := '29/02/2024';
//      lFluxoCaixaModel.LojaView        := '001';

      lFluxoCaixaModel.PorcentagemInadimplenciaView := 10;
      lMemTable := lFluxoCaixaModel.obterResultadoFluxoCaixa;

      dsTeste2.DataSet := lMemTable;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFluxoCaixaModel.Free;
  end;
end;

procedure TForm1.Button52Click(Sender: TObject);
var
  lBancoModel : TBancoModel;
  lNomeBanco  : String;
begin
  lBancoModel := TBancoModel.create(vIConexao);
  try
    try
      lNomeBanco :=  InputBox('BANCO','Digite o Nome do Banco:','');

      if lNomeBanco.IsEmpty then
        Exit;

      lBancoModel.NOME_BAN    := lNomeBanco;
      lBancoModel.AGENCIA_BAN := '000123';
      lBancoModel.CONTA_BAN   := '321123';

      lBancoModel.Incluir;

      ShowMessage('Incluido com sucesso');
    except
       on E:Exception do
         ShowMessage('Erro: ' + E.Message);
      end;
  finally
    lBancoModel.Free;
  end;
end;

procedure TForm1.Button53Click(Sender: TObject);
var
  lBancoModel : TBancoModel;
  lMemTable   : TFDMemTable;
begin
  lBancoModel := TBancoModel.Create(vIConexao);
  try
    try
      lMemTable := lBancoModel.obterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('NUMERO_BAN: '+lMemTable.FieldByName('NUMERO_BAN').AsString);
        memoResultado.Lines.Add('NOME_BAN: '+lMemTable.FieldByName('NOME_BAN').AsString);
        memoResultado.Lines.Add('AGENCIA_BAN: '+lMemTable.FieldByName('AGENCIA_BAN').AsString);
        memoResultado.Lines.Add('CONTA_BAN: '+lMemTable.FieldByName('CONTA_BAN').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lBancoModel.Free;
  end;
end;

procedure TForm1.Button54Click(Sender: TObject);
var
  lBancoModel : TBancoModel;
  ID          : String;
begin
  lBancoModel := TBancoModel.Create(vIConexao);
  try
    try
      ID := InputBox('BANCO', 'Digite o ID do Banco que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lBancoModel := lBancoModel.Alterar(ID);
      lBancoModel.NOME_BAN := 'TESTE ALTERAR';

      lBancoModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lBancoModel.Free;
  end;
end;

procedure TForm1.Button55Click(Sender: TObject);
var
  lBancoModel : TBancoModel;
  ID        : String;
begin
  lBancoModel := TBancoModel.Create(vIConexao);
  try
    try
      ID := InputBox('BANCO', 'Digite o ID do Banco que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lBancoModel.Exlcuir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lBancoModel.Free;
  end;
end;

procedure TForm1.Button56Click(Sender: TObject);
var
  lEntradaModel      : TEntradaModel;
  lEntradaItensModel : TEntradaItensModel;
  lEntrada           : TEntradaResultado;
  lTableEntrada,
  lTableItens        : TFDMemTable;
begin
  lEntradaModel      := TEntradaModel.Create(vIConexao);
  lEntradaItensModel := TEntradaItensModel.Create(vIConexao);

  try
    try
      OpenDialog.FileName   := '';
      OpenDialog.Title      := 'Selecione a NFE';
      OpenDialog.DefaultExt := '*.XML';
      OpenDialog.Filter     := 'Arquivos NFE (*.XML)|*.XML|Arquivos XML (*-nfe.XML)|*-nfe.XML|Todos os Arquivos (*.*)|*.*';
      OpenDialog.InitialDir := '%homepath%\documents\';

      OpenDialog.Execute;

      if FileExists(OpenDialog.FileName) then
      begin
        lEntradaModel.PathXML := OpenDialog.FileName;
        lEntrada := lEntradaModel.importaXML;

        if lEntrada.NUMERO_ENT <> '' then
        begin
          lEntradaModel.NumeroView := lEntrada.NUMERO_ENT;
          lTableEntrada            := lEntradaModel.obterLista;
          dsEntrada.DataSet        := lTableEntrada;

          lEntradaItensModel.NumeroView := lEntrada.NUMERO_ENT;
          lTableItens                  := lEntradaItensModel.obterLista;
          dsEntradaItens.DataSet       := lTableitens;
        end;
      end;
    except
      on E:Exception do
        ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel.Free;
    lEntradaItensModel.Free;
  end;
end;

procedure TForm1.Button57Click(Sender: TObject);
var
  lPortadorModel : TPortadorModel;
  lMemTable      : TFDMemTable;
begin
  lPortadorModel := TPortadorModel.Create(vIConexao);
  try
    try

      lMemTable := lPortadorModel.PortadorTabelaJuros;
      memoResultado.Lines.Clear;
      lMemTable.First;

      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('CODIGO_PORTADOR: '+lMemTable.FieldByName('CODIGO_PORTADOR').AsString);
        memoResultado.Lines.Add('PORTADOR: '+lMemTable.FieldByName('PORTADOR').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPortadorModel.free;
  end;
end;

procedure TForm1.Button58Click(Sender: TObject);
var
  lEntradaModel      : TEntradaModel;
  lEntradaItensModel : TEntradaItensModel;
  lEntrada           : String;
  lTableEntrada,
  lTableItens        : TFDMemTable;
begin
  lEntradaModel      := TEntradaModel.Create(vIConexao);
  lEntradaItensModel := TEntradaItensModel.Create(vIConexao);
  try

    lEntrada := InputBox('Constultar Entrada','Digite o número da Entrada:','');
     if lEntrada.IsEmpty then
     Exit;

    lEntradaModel.NumeroView := lEntrada;
    lTableEntrada            := lEntradaModel.obterLista;
    dsEntrada.DataSet        := lTableEntrada;

    lEntradaItensModel.NumeroView := lEntrada;
    lTableItens                  := lEntradaItensModel.obterLista;
    dsEntradaItens.DataSet       := lTableitens;


  finally
    lEntradaModel.Free;
    lEntradaItensModel.Free;
  end;
end;


procedure TForm1.Button59Click(Sender: TObject);
var
  lEntradaModel      : TEntradaModel;
  lEntradaItensModel : TEntradaItensModel;

begin
  lEntradaModel      := TEntradaModel.Create(vIConexao);
  lEntradaItensModel := TEntradaItensModel.Create(vIConexao);
  try
    try
      lEntradaModel.NUMERO_ENT    := '55555555';
      lEntradaModel.CODIGO_FOR    := '500005';
      lEntradaModel.SERIE_ENT     := '001';
      lEntradaModel.PARCELAS_ENT  := '3';
      lEntradaModel.CONDICOES_PAG := '30';
      lEntradaModel.TOTAL_ENT     := '500';
      lEntradaModel.DATANOTA_ENT  := DateToStr(vIConexao.DataServer);

      lEntradaModel.Incluir;

      ShowMessage('Cabeçalho Entrada Cadastrado');
      except
       on E:Exception do
         ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel.Free;
    lEntradaItensModel.Free;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  lWebPedidoModel : TWebPedidoModel;
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    try

      lWebPedidoModel.CLIENTE_ID          := '000000';
      lWebPedidoModel.VENDEDOR_ID         := '000001';
      lWebPedidoModel.TIPOVENDA_ID        := '000004';
      lWebPedidoModel.PORTADOR_ID         := '000001';

      lWebPedidoModel.Incluir;
      ShowMessage('Inserido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoModel.Free;
  end;
end;

procedure TForm1.Button60Click(Sender: TObject);
var
  lEntradaItensParams : TEntradaItensParams;
  lEntradaModel       : TEntradaModel;
  lNumEntrada         : String;
begin
  lEntradaModel  := TEntradaModel.Create(vIConexao);
  try
    try
      lNumEntrada := InputBox('Entrada Item','Digite o número da Entrada:','');
        if lNumEntrada.IsEmpty then
          Exit;

      lEntradaItensParams.NUMERO_ENT      := lNumEntrada;
      lEntradaItensParams.CODIGO_FOR      := '500005';
      lEntradaItensParams.CODIGO_PRO      := '000444';
      lEntradaItensParams.QUANTIDADE_ENT  := '10';
      lEntradaItensParams.VALORUNI_ENT    := '50';

      lEntradaModel.EntradaItens(lEntradaItensParams);
      ShowMessage('Item adicionado a Entrada: ' + lNumEntrada);

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.Button61Click(Sender: TObject);
var
  lEntradaModel : TEntradaModel;

begin
  lEntradaModel := TEntradaModel.Create(vIConexao);
  try
    try
      lEntradaModel.NumeroView     := '0001018217';
      lEntradaModel.FornecedorView := '500009';

      dsEntrada.DataSet := lEntradaModel.obterTotalizador;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.Button62Click(Sender: TObject);
var
  lContasPagarModel : TContasPagarModel;
  pEntrada,
  pFornecedor : String;
begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);
  try
    try
      pEntrada    := '0001044283';
      pFornecedor := '000184';

      dsEntrada.DataSet := lContasPagarModel.obterValorEntrada(pEntrada, pFornecedor);

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarModel.Free;
  end;
end;

procedure TForm1.Button63Click(Sender: TObject);
var
  lOsModel : TOSModel;
begin
  lOsModel := TOSModel.Create(vIConexao);

  try
    lOsModel.CODIGO_CLI := '000001';
    lOsModel.TOTAL_OS   := '1000';
    lOsModel.Incluir;

    ShowMessage('Inserido com Sucesso');

  finally
    lOsModel.Free;
  end;
end;

procedure TForm1.Button64Click(Sender: TObject);
var
  lOsModel  : TOSModel;
begin

  lOsModel := TOSModel.Create(vIConexao);

  try
    dsOS.DataSet := lOsModel.obterLista;
  finally
    lOsModel.Free;
  end;

end;

procedure TForm1.Button65Click(Sender: TObject);
var
  lOsModel : TOSModel;
begin
  lOsModel := TOSModel.Create(vIConexao);

  try
    lOsModel := lOsModel.Alterar('000045');
    lOsModel.TOTAL_OS   := '500';
    lOsModel.Salvar;

    ShowMessage('Alterado com Sucesso');

  finally
    lOsModel.Free;
  end;
end;

procedure TForm1.Button66Click(Sender: TObject);
var
  lOsModel : TOSModel;
begin
  lOsModel := TOSModel.Create(vIConexao);

  try
    try
      lOsModel.Excluir('000045');
      ShowMessage('Excluido com Sucesso');

    except
      on E:Exception do
        ShowMessage('Erro ao excluir: '+ E.Message);
    end;
  finally
    lOsModel.Free;
  end;
end;

procedure TForm1.Button67Click(Sender: TObject);
var
  lSimuladorPrecoModel : TSimuladorPrecoModel;
  lResultado           : TResultado;
begin
  lSimuladorPrecoModel := TSimuladorPrecoModel.Create;
  try
    lSimuladorPrecoModel.VALOR_AQUISICAO                    := 1332;
    lSimuladorPrecoModel.PERCENTUAL_IPI                     := 17;
    lSimuladorPrecoModel.PERCENTUAL_FRETE                   := 15;
    lSimuladorPrecoModel.PERCENTUAL_MVA                     := 15;
    lSimuladorPrecoModel.PERCENTUAL_ICMS_ST                 := 18;
    lSimuladorPrecoModel.PERCENTUAL_ICMS                    := 18;
    lSimuladorPrecoModel.PERCENTUAL_CREDITO_PIS_COFINS      := 10;
    lSimuladorPrecoModel.PERCENTUAL_REDUCAO_ST              := 5;
    lSimuladorPrecoModel.PERCENTUAL_REDUCAO_ICMS            := 5;
    lSimuladorPrecoModel.PERCENTUAL_MARGEM                  := 34.99;
    lSimuladorPrecoModel.TIPO_FRETE                         := 'CIF';

    lResultado := lSimuladorPrecoModel.simular;

    memoSimulador.Lines.Clear;

    memoSimulador.Lines.Add('Custo Líquido: '+ lResultado.CustoLiquido.ToString);
    memoSimulador.Lines.Add('Custo Bruto: '+ lResultado.CustoBruto.ToString);
    memoSimulador.Lines.Add('Custo Compra: '+ lResultado.CustoCompra.ToString);
  finally
    lSimuladorPrecoModel.Free;
  end;
end;

procedure TForm1.Button68Click(Sender: TObject);
var
  lGrupoModel : TGrupoModel;
  lNomeGrupo  : String;
begin
  lGrupoModel := TGrupoModel.create(vIConexao);
  try
    try
      lNomeGrupo :=  InputBox('GRUPOPRODUTO','Digite o Nome do Grupo:','');

      if lNomeGrupo.IsEmpty then
        Exit;

      lGrupoModel.NOME_GRU    := lNomeGrupo;
      lGrupoModel.USUARIO_GRU := '000001';

      lGrupoModel.Incluir;

      ShowMessage('Incluido com sucesso');
    except
       on E:Exception do
         ShowMessage('Erro: ' + E.Message);
      end;
  finally
    lGrupoModel.Free;
  end;
end;
procedure TForm1.Button69Click(Sender: TObject);
var
  lGrupoModel : TGrupoModel;
  lMemTable   : TFDMemTable;
begin
  lGrupoModel := TGrupoModel.Create(vIConexao);
  try
    try
      lMemTable := lGrupoModel.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('CODIGO_GRU: '+lMemTable.FieldByName('CODIGO_GRU').AsString);
        memoResultado.Lines.Add('NOME_GRU: '+lMemTable.FieldByName('NOME_GRU').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lGrupoModel.Free;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  lWebPedidoModel : TWebPedidoModel;
  lID             : String;
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    try
      lID := InputBox('WebPedido', 'Digite o ID do WebPedido:', '');

      if lID.IsEmpty then
        exit;

      lWebPedidoModel := lWebPedidoModel.Alterar(lID);
      lWebPedidoModel.CLIENTE_ID := '000001';
      lWebPedidoModel.Salvar;

      ShowMessage('Alterado com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoModel.Free;
  end;
end;

procedure TForm1.Button70Click(Sender: TObject);
var
  lGrupoModel : TGrupoModel;
  ID          : String;
begin
  lGrupoModel := TGrupoModel.Create(vIConexao);
  try
    try
      ID := InputBox('GRUPOPRODUTO', 'Digite o ID do GRUPO que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lGrupoModel := lGrupoModel.Alterar(ID);
      lGrupoModel.NOME_GRU := 'TESTE ALTERAR';

      lGrupoModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lGrupoModel.Free;
  end;
end;
procedure TForm1.Button71Click(Sender: TObject);
var
  lGrupoModel : TGrupoModel;
  ID        : String;
begin
  lGrupoModel := TGrupoModel.Create(vIConexao);
  try
    try
      ID := InputBox('GRUPOPRODUTO', 'Digite o ID do GRUPO que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lGrupoModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lGrupoModel.Free;
  end;
end;

procedure TForm1.Button72Click(Sender: TObject);
var
  lSimuladorPrecoModel : TSimuladorPrecoModel;
  lResultado           : TResultado;
begin
  lSimuladorPrecoModel := TSimuladorPrecoModel.Create;
  try
    lSimuladorPrecoModel.VALOR_AQUISICAO             := 1332;
    lSimuladorPrecoModel.VALOR_IPI                   := 30;
    lSimuladorPrecoModel.VALOR_FRETE                 := 50;
    lSimuladorPrecoModel.VALOR_ICMS_ST               := 25;
    lSimuladorPrecoModel.VALOR_ICMS                  := 80;
    lSimuladorPrecoModel.VALOR_CREDITO_PIS_COFINS    := 40;
    lSimuladorPrecoModel.TIPO_FRETE                  := 'CIF';

    lResultado := lSimuladorPrecoModel.calcular;

    memoSimulador.Lines.Clear;

    memoSimulador.Lines.Add('Custo Líquido: '+ lResultado.CustoLiquido.ToString);
    memoSimulador.Lines.Add('Custo Bruto: '+ lResultado.CustoBruto.ToString);
    memoSimulador.Lines.Add('Custo Compra: '+ lResultado.CustoCompra.ToString);
  finally
    lSimuladorPrecoModel.Free;
  end;
end;

procedure TForm1.Button73Click(Sender: TObject);
var
  lContasPagarModel : TContasPagarModel;
begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);

  try
    try

      lContasPagarModel.DUPLICATA_PAG  := '9000002024'; //Numero NFe
      lContasPagarModel.CODIGO_FOR     := '500005'; //Fornecedor NFe
      lContasPagarModel.PORTADOR_ID    := '000001';
      lContasPagarModel.DATAEMI_PAG    := '27.02.2024'; //Data do MOvimento
      lContasPagarModel.VALOR_PAG      := '1000'; //Total da nota
      lContasPagarModel.CONDICOES_PAG  := '30/60/90';
      lContasPagarModel.USUARIO_PAG    := '000001';
      lContasPagarModel.OBS_PAG        := 'NUMERO DA NOTA E NOME DO FORNECEDOR';
      lContasPagarModel.CODIGO_CTA     := '444444';
      lContasPagarModel.LOJA           := '001';

      lContasPagarModel.GerarFinanceiroEntrada;

      ShowMessage('Inserido com Sucesso');
    Except
      on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarModel.Free;
  end;
end;

procedure TForm1.Button74Click(Sender: TObject);
var
 lCNPJModel : TCNPJModel;
 Retorno : TRetornoCnpj;
begin

  lCNPJModel := TCNPJModel.Create(vConfiguracoes);

//lCNPJModel.API := tApiReceita;  Recebe o valor do Receita

  Retorno := lCNPJModel.consultarCnpj('09020312000131');

  MemoAPI.Lines.Add(Retorno.Nome);
  MemoAPI.Lines.Add(Retorno.Fantasia);
  MemoAPI.Lines.Add(Retorno.Cep);
  MemoAPI.Lines.Add(Retorno.Logradouro);
  MemoAPI.Lines.Add(Retorno.Numero);
  MemoAPI.Lines.Add(Retorno.Complemento);
  MemoAPI.Lines.Add(Retorno.Bairro);
  MemoAPI.Lines.Add(Retorno.Municipio);
  MemoAPI.Lines.Add(Retorno.UF);
  MemoAPI.Lines.Add(Retorno.Telefone);
  MemoAPI.Lines.Add(Retorno.Email);
  MemoAPI.Lines.Add(Retorno.Abertura);
end;

procedure TForm1.Button75Click(Sender: TObject);
var
 lCEPModel : TCEPModel;
 Retorno : TRetornoCEP;
begin

  lCEPModel := TCEPModel.Create(vConfiguracoes);

//lCEPModel.API := tApiViaCep;  Recebe o valor do ViaCep

  Retorno := lCEPModel.consultarCEP('86185420');

  MemoAPI.Lines.Add(Retorno.CEP);
  MemoAPI.Lines.Add(Retorno.Logradouro);
  MemoAPI.Lines.Add(Retorno.Bairro);
  MemoAPI.Lines.Add(Retorno.Cidade);
  MemoAPI.Lines.Add(Retorno.Cod_Municipio);
  MemoAPI.Lines.Add(Retorno.UF);
  MemoAPI.Lines.Add(Retorno.DDD);
end;

procedure TForm1.Button76Click(Sender: TObject);
var
  lPedidoCompra : TPedidoCompraModel;
begin
  lPedidoCompra := TPedidoCompraModel.Create(vIConexao);
  try
    try

      lPedidoCompra.DATA_PED := DateToStr(vIConexao.DataServer);
      lPedidoCompra.DATAPREV_PED := DateToStr(vIConexao.DataServer);
      lPedidoCompra.CODIGO_FOR := '000059';
      lPedidoCompra.PARCELAS_PED := 1;
      lPedidoCompra.PRIMEIROVENC_PED := DateToStr(vIConexao.DataServer);
      lPedidoCompra.TOTAL_PED := '1000';
      lPedidoCompra.USUARIO_PED := '000001';
      lPedidoCompra.STATUS_PED := 'A';
      lPedidoCompra.TOTALPRODUTOS_PED := '1000';
      lPedidoCompra.TIPO_PRO := 'N';

      lPedidoCompra.Incluir;
      ShowMessage('Inserido com Sucesso');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPedidoCompra.Free;
  end;
end;

procedure TForm1.Button77Click(Sender: TObject);
var
  lPedidoCompraModel : TPedidoCompraModel;
  lPedidoItensModel  : TPedidoCompraItensModel;
  TablePedidoCompra,
  TablePedItens      : TFDMEmTable;
  lNumeroView,
  lFornecedorView    : String;
begin
  lPedidoCompraModel := TPedidoCompraModel.Create(vIConexao);
  lPedidoItensModel  := TPedidoCompraItensModel.Create(vIConexao);
  try
    try
      lNumeroView     := '000008';
      lFornecedorView := '000000';

      lPedidoCompraModel.NumeroView    := lNumeroView;
      TablePedidoCompra                := lPedidoCompraModel.obterLista;
      dsPedidoCompra.DataSet           := TablePedidoCompra;

      lPedidoItensModel.NumeroView     := lNumeroView;
      lPedidoItensModel.FornecedorView := lFornecedorView;
      TablePedItens                    := lPedidoItensModel.obterLista;
      dsPedidoCompraItens.DataSet      := TablePedItens;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPedidoCompraModel.Free;
    lPedidoItensModel.Free;
  end;
end;

procedure TForm1.Button78Click(Sender: TObject);
var
  lPedidoCompraModel : TPedidoCompraModel;
  lPedidoItensModel  : TPedidoCompraItensModel;
  lPedidoParams      : TPedidoItensParams;
begin
  lPedidoCompraModel := TPedidoCompraModel.Create(vIConexao);
  lPedidoItensModel  := TPedidoCompraItensModel.Create(vIConexao);
  try
    try
      lPedidoParams.NUMERO_PED     := '000017';
      lPedidoParams.CODIGO_FOR     := '000059';
      lPedidoParams.CODIGO_PRO     := '000980';
      lPedidoParams.QUANTIDADE_PED := '5';
      lPedidoParams.VALORUNI_PED   := '100';

      lPedidoCompraModel.AdicionarItens(lPedidoParams);
      ShowMessage('Item adicionado ao Pedido: ' +lPedidoParams.NUMERO_PED)
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPedidoCompraModel.Free;
    lPedidoItensModel.Free;
  end;
end;

procedure TForm1.Button79Click(Sender: TObject);
var
  lEntradaModel: TEntradaModel;
  lNomePDF: String;
  lIDEntrada, lCodigoFornecedor, lPathPDF: String;
  lImprimir, lMostraPreview, lGerarPDF: Boolean;
begin
  lEntradaModel   := TEntradaModel.Create(vIConexao);

  try
    lIDEntrada         := '0000015340';
    lCodigoFornecedor  := '500017';
    lImprimir          := false;
    lMostraPreview     := false;
    lGerarPDF          := True;
    lPathPDF           := 'c:\temp';

    try
     lNomePDF := lEntradaModel.VisualizarXML(lIDEntrada,lCodigoFornecedor,lImprimir,lMostraPreview,lGerarPDF,lPathPDF)+'-nfe.pdf';
    except on E: Exception do
      begin
        ShowMessage('Erro: '+e.Message);
        Exit;
      end;
    end;

  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  lWebPedidoModel : TWebPedidoModel;
  PedidoWeb       : String;
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    try
      PedidoWeb := InputBox('WebPedido', 'Digite o ID do Item que deseja excluir:', '');

      lWebPedidoModel.Excluir(PedidoWeb);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoModel.Free;
  end;
end;

procedure TForm1.Button80Click(Sender: TObject);
var
  lEntradaModel: TEntradaModel;
  lNomeXML: String;
  lPathXML, lIDEntrada, lCodigoFornecedor: String;
begin
  lEntradaModel   := TEntradaModel.Create(vIConexao);

  try
    lIDEntrada         := '0000015340';
    lCodigoFornecedor  := '500017';
    lPathXML := 'c:\temp\';

    try
      lNomeXML := lEntradaModel.SalvarXML(lIDEntrada, lCodigoFornecedor,lPathXML);
    except on E: Exception do
      begin
        ShowMessage('Erro: '+e.Message);
        Exit;
      end;
    end;

    if not FileExists(lPathXML + lNomeXML) then
    begin
      ShowMessage('XML não localizado');
      Exit;
    end;

  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.Button81Click(Sender: TObject);
var
  lClientesContatoModel : TClientesContatoModel;
  lMemTable   : TFDMemTable;
begin
  lClientesContatoModel := TClientesContatoModel.Create(vIConexao);
  try
    try
      lMemTable := lClientesContatoModel.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
        memoResultado.Lines.Add('CLIENTE_ID: '+lMemTable.FieldByName('CLIENTE_ID').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClientesContatoModel.Free;
  end;
end;

procedure TForm1.Button82Click(Sender: TObject);
var
  lClientesContatoModel : TClientesContatoModel;
  ID          : String;
begin
  lClientesContatoModel := TClientesContatoModel.Create(vIConexao);
  try
    try
      ID := InputBox('CLIENTES_CONTATO', 'Digite o ID do Contato que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lClientesContatoModel := lClientesContatoModel.Alterar(ID);
      lClientesContatoModel.Contato := 'TESTE ALTERAR';

      lClientesContatoModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lClientesContatoModel.Free;
  end;
end;

procedure TForm1.Button83Click(Sender: TObject);
var
  lClientesContatoModel : TClientesContatoModel;
  ID        : String;
begin
  lClientesContatoModel := TClientesContatoModel.Create(vIConexao);
  try
    try
      ID := InputBox('CLIENTES_CONTATO', 'Digite o ID do Contato que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lClientesContatoModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClientesContatoModel.Free;
  end;
end;

procedure TForm1.Button84Click(Sender: TObject);
var
  lClientesContatoModel : TClientesContatoModel;
begin
  lClientesContatoModel := TClientesContatoModel.Create(vIConexao);
  try
    try
      lClientesContatoModel.ID          := 10;
      lClientesContatoModel.CLIENTE_ID  := '000001';
      lClientesContatoModel.CONTATO     := 'TESTE TERASOFT';

      lClientesContatoModel.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lClientesContatoModel.Free;
  end;
end;

procedure TForm1.Button85Click(Sender: TObject);
var
  lDescontoModel : TDescontoModel;
  lMemTable   : TFDMemTable;
begin
  lDescontoModel := TDescontoModel.Create(vIConexao);
  try
    try
      lMemTable := lDescontoModel.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
        memoResultado.Lines.Add('CLIENTE_ID: '+lMemTable.FieldByName('USUARIO_DES').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDescontoModel.Free;
  end;
end;

procedure TForm1.Button86Click(Sender: TObject);
var
  lProdutoModel : TProdutosModel;
  lValoresGarantia: TProdutoGarantia;
begin
  lProdutoModel := TProdutosModel.Create(vIConexao);

  try
    try
      lValoresGarantia := lProdutoModel.ValorGarantia('000014',10);

      memoResultado.Lines.Clear;

      memoResultado.Lines.Add('GARANTIA_EXTENDIDA_VENDA_12  R$ '+FormataFloat(lValoresGarantia.GARANTIA_EXTENDIDA_VENDA_12));
      memoResultado.Lines.Add('GARANTIA_EXTENDIDA_CUSTO_12  R$ '+FormataFloat(lValoresGarantia.GARANTIA_EXTENDIDA_CUSTO_12));
      memoResultado.Lines.Add('GARANTIA_EXTENDIDA_VENDA_24  R$ '+FormataFloat(lValoresGarantia.GARANTIA_EXTENDIDA_VENDA_24));
      memoResultado.Lines.Add('GARANTIA_EXTENDIDA_CUSTO_24  R$ '+FormataFloat(lValoresGarantia.GARANTIA_EXTENDIDA_CUSTO_24));
      memoResultado.Lines.Add('GARANTIA_EXTENDIDA_VENDA_36  R$ '+FormataFloat(lValoresGarantia.GARANTIA_EXTENDIDA_VENDA_36));
      memoResultado.Lines.Add('GARANTIA_EXTENDIDA_CUSTO_36  R$ '+FormataFloat(lValoresGarantia.GARANTIA_EXTENDIDA_CUSTO_36));
      memoResultado.Lines.Add('ROUBO_FURTO_12               R$ '+FormataFloat(lValoresGarantia.ROUBO_FURTO_12             ));
      memoResultado.Lines.Add('ROUBO_FURTO_24               R$ '+FormataFloat(lValoresGarantia.ROUBO_FURTO_24             ));
      memoResultado.Lines.Add('ROUBO_FURTO_CUSTO_12         R$ '+FormataFloat(lValoresGarantia.ROUBO_FURTO_CUSTO_12       ));
      memoResultado.Lines.Add('ROUBO_FURTO_CUSTO_24         R$ '+FormataFloat(lValoresGarantia.ROUBO_FURTO_CUSTO_24       ));
      memoResultado.Lines.Add('ROUBO_FURTO_DA_12            R$ '+FormataFloat(lValoresGarantia.ROUBO_FURTO_DA_12          ));
      memoResultado.Lines.Add('ROUBO_FURTO_DA_24            R$ '+FormataFloat(lValoresGarantia.ROUBO_FURTO_DA_24          ));
      memoResultado.Lines.Add('ROUBO_FURTO_CUSTO_DA_12      R$ '+FormataFloat(lValoresGarantia.ROUBO_FURTO_CUSTO_DA_12    ));
      memoResultado.Lines.Add('ROUBO_FURTO_CUSTO_DA_24      R$ '+FormataFloat(lValoresGarantia.ROUBO_FURTO_CUSTO_DA_24    ));

     except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lProdutoModel.Free;
  end;
end;

procedure TForm1.Button87Click(Sender: TObject);
var
  lPermissaoRemotaModel : TPermissaoRemotaModel;
begin
  lPermissaoRemotaModel := TPermissaoRemotaModel.Create(vIConexao);
  try
    lPermissaoRemotaModel.Negar('789');
  finally
    lPermissaoRemotaModel.Free;
  end;
end;

procedure TForm1.btnPermissaoClick(Sender: TObject);
var
  lDescontoModel : TDescontoModel;
  ID        : String;
begin
  lDescontoModel := TDescontoModel.Create(vIConexao);
  try
    try
      ID := InputBox('DESCONTO', 'Digite o ID do Contato que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lDescontoModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDescontoModel.Free;
  end;
end;

procedure TForm1.btnPermissaoRemotaClick(Sender: TObject);
var
  lPermissaoRemotaModel : TPermissaoRemotaModel;
begin
  lPermissaoRemotaModel := TPermissaoRemotaModel.Create(vIConexao);
  try
    lPermissaoRemotaModel.Autorizar('789');
  finally
    lPermissaoRemotaModel.Free;
  end;
end;

procedure TForm1.Button88Click(Sender: TObject);
var
  lDescontoModel : TDescontoModel;
begin
  lDescontoModel := TDescontoModel.Create(vIConexao);
  try
    try
      lDescontoModel.USUARIO_DES   := '000002';
      lDescontoModel.TIPOVENDA_DES := '000004';
      lDescontoModel.VALOR_DES     := 99;

      lDescontoModel.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lDescontoModel.Free;
  end;
end;

procedure TForm1.Button89Click(Sender: TObject);
var
  lTransportadoraModel : TTransportadoraModel;
  lMemTable   : TFDMemTable;
begin
  lTransportadoraModel := TTransportadoraModel.Create(vIConexao);
  try
    try
      lMemTable := lTransportadoraModel.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('CODIGO: '+lMemTable.FieldByName('CODIGO_TRA').AsString);
        memoResultado.Lines.Add('NOME: '+lMemTable.FieldByName('FANTASIA_TRA').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lTransportadoraModel.Free;
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  lWebPedidoModel : TWebPedidoModel;
  lVenderItemParametros: TVenderItemParametros;
  lWebPedido : String;
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    try
      lWebPedido := InputBox('WebPedido', 'Digite o número do Web Pedido:', '');

      if lWebPedido.IsEmpty then
        exit;

      lVenderItemParametros.WEB_PEDIDO       := lWebPedido;
      lVenderItemParametros.PRODUTO          := '000005';
      lVenderItemParametros.QUANTIDADE       := '10';
      lVenderItemParametros.DESCONTO         := '0';
      lVenderItemParametros.VALOR_UNITARIO   := '30';
      lVenderItemParametros.TIPO             := 'NORMAL';
      lVenderItemParametros.ENTREGA          := 'S'; //S=Sim - N=Não
      lVenderItemParametros.MONTAGEM         := 'S'; //S=Sim - N=Não
      lVenderItemParametros.TIPO_ENTREGA     := 'LJ';
      lVenderItemParametros.TIPO_GARANTIA    := '0000';
      lVenderItemParametros.VLR_GARANTIA     := '0';

      lWebPedidoModel.VenderItem(lVenderItemParametros);
      ShowMessage('Item adicionado ao WebPedido: ' +lWebPedido);
    except
    on E:Exception do
       ShowMessage('Erro vender item: ' + E.Message);
    end;
  finally
    lWebPedidoModel.Free;
  end;
end;

procedure TForm1.Button90Click(Sender: TObject);
var
  lProdutosModel : TProdutosModel;
begin
  lProdutosModel := TProdutosModel.Create(vIConexao);
  try
    dsProdutos.DataSet := lProdutosModel.obterPromocao('000444');
  finally
    lProdutosModel.Free;
  end;
end;

procedure TForm1.Button91Click(Sender: TObject);
var
  lProduto : TProdutosModel;
begin
  lProduto := TProdutosModel.Create(vIConexao);
  try
    lProduto.IDRecordView := '000005';
    dsProdutos.DataSet    := lProduto.ObterTabelaPreco;
  finally
    lProduto.Free;
  end;
end;

procedure TForm1.Button92Click(Sender: TObject);
var
  lTransportadoraModel : TTransportadoraModel;
  ID : String;
begin
  lTransportadoraModel := TTransportadoraModel.Create(vIConexao);
  try
    try
      ID := InputBox('TRANSPORTADORA', 'Digite o código da transportadora que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lTransportadoraModel := lTransportadoraModel.Alterar(ID);
      lTransportadoraModel.FANTASIA_TRA := 'TESTE ALTERAÇÃO';

      lTransportadoraModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lTransportadoraModel.Free;
  end;
end;

procedure TForm1.Button93Click(Sender: TObject);
var
  lTransportadoraModel : TTransportadoraModel;
  codigo        : String;
begin
  lTransportadoraModel := TTransportadoraModel.Create(vIConexao);
  try
    try
      codigo := InputBox('TRANSPORTADORA', 'Digite o código da transportadora que deseja excluir:', '');
      if codigo.IsEmpty then
          Exit;

      lTransportadoraModel.Excluir(codigo);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lTransportadoraModel.Free;
  end;
end;

procedure TForm1.Button94Click(Sender: TObject);
var
  lTransportadoraModel : TTransportadoraModel;
begin
  lTransportadoraModel := TTransportadoraModel.Create(vIConexao);
  try
    try
      lTransportadoraModel.FANTASIA_TRA := 'FANTASIA TRANSPORTADORA TESTE';
      lTransportadoraModel.RAZAO_TRA    := 'RAZÃO TRANSPORTADORA TESTE';
      lTransportadoraModel.STATUS       := 'A';

      lTransportadoraModel.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lTransportadoraModel.Free;
  end;
end;

procedure TForm1.Button95Click(Sender: TObject);
var
  lPedidoCompra : TPedidoCompraModel;
  lTotalizador  : TFDMemTable;
begin
  lPedidoCompra := TPedidoCompraModel.Create(vIConexao);
  try
  lPedidoCompra.NumeroView     := '000008';
  lPedidoCompra.FornecedorView := '000000';
  lTotalizador             := lPedidoCompra.ObterTotalizador;
  dsPedidoCompra.DataSet   := lTotalizador;
  finally
    lPedidoCompra.Free;
  end;
end;

procedure TForm1.Button96Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : TPrevisaoPedidoCompraModel;
  lMemTable   : TFDMemTable;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.Create(vIConexao);
  try
    try
      lMemTable := lPrevisaoPedidoCompraModel.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('PEDIDO: '+lMemTable.FieldByName('NUMERO_PED').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.FieldByName('CODIGO_FOR').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPrevisaoPedidoCompraModel.Free;
  end;
end;

procedure TForm1.Button97Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : TPrevisaoPedidoCompraModel;
  ID : String;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.Create(vIConexao);
  try
    try
      ID := InputBox('PrevisaoPedidoCompra', 'Digite o código do PrevisaoPedidoCompra que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lPrevisaoPedidoCompraModel := lPrevisaoPedidoCompraModel.Alterar(ID);
      lPrevisaoPedidoCompraModel.VALOR_PARCELA := 888;

      lPrevisaoPedidoCompraModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lPrevisaoPedidoCompraModel.Free;
  end;
end;

procedure TForm1.Button98Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : TPrevisaoPedidoCompraModel;
  Numero_Ped, Codigo_For : String;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.Create(vIConexao);
  try
    try
      Numero_Ped := InputBox('PrevisaoPedidoCompra', 'Digite o Numero Pedido da PrevisaoPedidoCompra que deseja excluir:', '');
      if Numero_Ped.IsEmpty then
          Exit;

      Codigo_For := InputBox('PrevisaoPedidoCompra', 'Digite o Código Fornecedor da PrevisaoPedidoCompra que deseja excluir:', '');
      if Codigo_For.IsEmpty then
          Exit;

      lPrevisaoPedidoCompraModel.Excluir(Numero_Ped, Codigo_For);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPrevisaoPedidoCompraModel.Free;
  end;
end;

procedure TForm1.Button99Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : TPrevisaoPedidoCompraModel;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.Create(vIConexao);
  try
    try
      lPrevisaoPedidoCompraModel.VALOR_PARCELA := 999;
      lPrevisaoPedidoCompraModel.NUMERO_PED    := '000013';
      lPrevisaoPedidoCompraModel.CODIGO_FOR    := '000137';

      lPrevisaoPedidoCompraModel.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lPrevisaoPedidoCompraModel.Free;
  end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  lWebPedidoItensModel  : TWebPedidoItensModel;
  lWebPedidoItens       : String;
  i                     : Integer;
begin
  lWebPedidoItensModel  := TWebPedidoItensModel.Create(vIConexao);
  try
    try
      lWebPedidoItens := InputBox('WebPedido', 'Digite o número do Web Pedido para consultar os itens:', '');
      if lWebPedidoItens.IsEmpty then
        exit;


      lWebPedidoItensModel.IDWebPedidoView := StrToInt(lWebPedidoItens);
      lWebPedidoItensModel.obterLista;

      memoResultado.Lines.Clear;
      for i := 0 to lWebPedidoItensModel.WebPedidoItenssLista.Count -1 do
      begin
          memoResultado.Lines.Add('ID: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].ID);
          memoResultado.Lines.Add('QUANTIDADE: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].QUANTIDADE);
          memoResultado.Lines.Add('PRODUTO_ID: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].PRODUTO_ID);
          memoResultado.Lines.Add('PRODUTO_NOME: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].PRODUTO_NOME);
          memoResultado.Lines.Add('VALOR_UNITARIO: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].VALOR_UNITARIO);
          memoResultado.Lines.Add('TIPO_GARANTIA: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].TIPO_GARANTIA);
          memoResultado.Lines.Add('TIPO: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].TIPO);
          memoResultado.Lines.Add('===============================================');
      end;
      ShowMessage('Consultou itens');
    except
    on E:Exception do
       ShowMessage('Erro consultar itens' + E.Message);
    end;
  finally
    lWebPedidoItensModel.Free;
  end;
end;

procedure TForm1.btnSaldoClick(Sender: TObject);
var
  lSaldoModel : TSaldoModel;
  lMemTable   : TFDMemTable;
  lProduto    : String;
  lParametros : TParametrosSaldo;

begin
  lSaldoModel := TSaldoModel.Create(vIConexao);
  try
    lProduto  := InputBox('Consulta de Saldo', 'Digite o código do produto:', '');

    lParametros.PRODUTO := lProduto;
    lParametros.CD      := true;

    lMemTable := lSaldoModel.obterSaldoLojas(lParametros);

    memoResultado.Lines.Clear;

    lMemTable.First;
    while not lMemTable.Eof do
    begin
      memoResultado.Lines.Add('LOJA: '+lMemTable.FieldByName('LOJA').AsString);
      memoResultado.Lines.Add('SALDO_FISICO: '+lMemTable.FieldByName('SALDO_FISICO').AsString);
      memoResultado.Lines.Add('SALDO_DISPONIVEL: '+lMemTable.FieldByName('SALDO_DISPONIVEL').AsString);
      memoResultado.Lines.Add('===============================================');
      lMemTable.Next;
    end;

  finally
    lSaldoModel.Free;
  end;
end;

procedure TForm1.btnTabelaPrecoClick(Sender: TObject);
var
  lTabelaJurosModel: TTabelaJurosModel;
  lPortador : String;
  lMemTable : TFDMemTable;
begin
  lTabelaJurosModel := TTabelaJurosModel.Create(vIConexao);
  try
    lPortador := InputBox('WebPedido', 'Digite o ID do portador:', '');
    lMemTable := lTabelaJurosModel.obterLista(lPortador, 1000, true);

    lMemTable.first;
    while not lMemTable.eof do
    begin
      memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
      memoResultado.Lines.Add('PARCELA: '+lMemTable.FieldByName('CODIGO').AsString);
      memoResultado.Lines.Add('PERCENTUAL: '+lMemTable.FieldByName('PERCENTUAL').AsString);
      memoResultado.Lines.Add('JUROS: '+lMemTable.FieldByName('JUROS_TEXTO').AsString);
      memoResultado.Lines.Add('VALOR_JUROS: '+lMemTable.FieldByName('VALOR_JUROS').AsString);
      memoResultado.Lines.Add('VALOR_PARCELA: '+lMemTable.FieldByName('VALOR_PARCELA').AsString);
      memoResultado.Lines.Add('VALOR_TOTAL: '+lMemTable.FieldByName('VALOR_TOTAL').AsString);
      memoResultado.Lines.Add('===============================================');
      memoResultado.Lines.Add('VALOR_SEG_PRESTAMISTA: '+lMemTable.FieldByName('VALOR_SEG_PRESTAMISTA').AsString);
      memoResultado.Lines.Add('PER_SEG_PRESTAMSTA: '+lMemTable.FieldByName('PER_SEG_PRESTAMSTA').AsString);
      memoResultado.Lines.Add('VALOR_ACRESCIMO_SEG_PRESTAMISTA: '+lMemTable.FieldByName('VALOR_ACRESCIMO_SEG_PRESTAMISTA').AsString);
      memoResultado.Lines.Add('===============================================');
      memoResultado.Lines.Add('');

      lMemTable.Next;
    end;

  finally
    lTabelaJurosModel.Free;
  end;
end;

procedure TForm1.btnTotaisClick(Sender: TObject);
var
  lWebPedidoModel : TWebPedidoModel;
  lID : String;
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    lID := InputBox('WebPedido', 'Digite o ID do Web Pedido:', '');
    if lID.IsEmpty then
      Exit;

    lWebPedidoModel.ID := lID;
    lWebPedidoModel.obterTotais;

    memoResultado.Lines.Add('VALOR_ACRESCIMO: '+lWebPedidoModel.ACRESCIMO);
    memoResultado.Lines.Add('VALOR_FRETE: '+lWebPedidoModel.VALOR_FRETE);
    memoResultado.Lines.Add('VALOR_DESCONTO: '+lWebPedidoModel.VALOR_CUPOM_DESCONTO);
    memoResultado.Lines.Add('VALOR_ITENS: '+lWebPedidoModel.VALOR_ITENS);
    memoResultado.Lines.Add('VALOR_TOTAL: '+lWebPedidoModel.VALOR_TOTAL);
    memoResultado.Lines.Add('===============================================');
  finally
    lWebPedidoModel.Free;
  end;
end;

procedure TForm1.Button100Click(Sender: TObject);
var
  lPedidoCompraItens : TPedidoCompraItensModel;
  lTable  : TFDMemTable;
begin
  lPedidoCompraItens := TPedidoCompraItensModel.Create(vIConexao);
  try
  lPedidoCompraItens.NumeroView := '000011';
  lTable                        := lPedidoCompraItens.obterLista;
  dsPedidoCompra.DataSet        := lTable;
  finally
    lPedidoCompraItens.Free;
  end;
end;

procedure TForm1.Button101Click(Sender: TObject);
var
  lPedidoCompra : TPedidoCompraModel;
  lTable  : TFDMemTable;
begin
  lPedidoCompra := TPedidoCompraModel.Create(vIConexao);
  try
    lPedidoCompra.NumeroView     := '000008';
    lPedidoCompra.FornecedorView := '000000';
    lTable                   := lPedidoCompra.obterLista;
    dsPedidoCompra.DataSet   := lTable;
  finally
    lPedidoCompra.Free;
  end;
end;

procedure TForm1.Button102Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : TPrevisaoPedidoCompraModel;
  lPedidoCompra : TPedidoCompraModel;
  pPed,
  pFornc : String;
begin
  lPedidoCompra := TPedidoCompraModel.Create(vIConexao);
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.Create(vIConexao);
  try
    pPed   := '000013';
    pFornc := '000137';

    lPedidoCompra := lPedidoCompra.carregaClasse(pPed, pFornc);

    lPrevisaoPedidoCompraModel.gerarFinanceiro(lPedidoCompra);

  finally
    lPedidoCompra.Free;
  end;
end;

procedure TForm1.Button103Click(Sender: TObject);
var
  lSaidasModel : TSaidasModel;
begin
  lSaidasModel := TSaidasModel.Create(vIConexao);
  try
    try
      lSaidasModel.LOJA       := '003';
      lSaidasModel.CODIGO_CLI := '000001';

      lSaidasModel.Incluir;

      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lSaidasModel.Free;
  end;
end;

procedure TForm1.Button104Click(Sender: TObject);
var
  lSaidasModel : TSaidasModel;
  ID : String;
begin
  lSaidasModel := TSaidasModel.Create(vIConexao);
  try
    try
      ID := InputBox('Saidas', 'Digite o código da Saida que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lSaidasModel := lSaidasModel.Alterar(ID);
      lSaidasModel.TOTAL_SAI := 500;

      lSaidasModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lSaidasModel.Free;
  end;
end;

procedure TForm1.Button105Click(Sender: TObject);
var
  lSaidasModel : TSaidasModel;
  Numero_Saida : String;
begin
  lSaidasModel := TSaidasModel.Create(vIConexao);
  try
    try
      Numero_Saida := InputBox('Saida', 'Digite o Numero da Saida que deseja excluir:', '');
      if Numero_Saida.IsEmpty then
          Exit;

      lSaidasModel.Excluir(Numero_Saida);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lSaidasModel.Free;
  end;
end;

procedure TForm1.Button106Click(Sender: TObject);
var
  lSaidasModel : TSaidasModel;
  lTable       : TFDMemTable;
begin
  lSaidasModel := TSaidasModel.Create(vIConexao);
  try
    try
      lSaidasModel.SaidaView := '000215';
      lSaidasModel.LojaView  := '001';

      lTable           := lSaidasModel.obterLista;
      dsSaidas.DataSet := lTable;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lSaidasModel.Free;
  end;
end;

procedure TForm1.Button107Click(Sender: TObject);
var
  lSaidasModel      : TSaidasModel;
  lSaidasItensModel : TSaidasItensModel;
  lSaidaParams      : TSaidaItensParams;
  lNumeroSaida      : String;
begin
  lSaidasModel      := TSaidasModel.Create(vIConexao);
  lSaidasItensModel := TSaidasItensModel.Create(vIConexao);
  try
    try
      lNumeroSaida := InputBox('SaidaItens', 'Digite o Numero da Saida que deseja inserir os itens:', '');
      if lNumeroSaida.IsEmpty then
        exit;

      lSaidasModel := lSaidasModel.carregaClasse(lNumeroSaida);

      lSaidaParams.CODIGO_PRO     := '000007';
      lSaidaParams.QUANTIDADE_SAI := '5';
      lSaidaParams.VALOR_UNI_SAI  := '100';

      lSaidasModel.AdicionarItens(lSaidaParams);
      ShowMessage('Item adicionado ao Pedido: '  + lSaidasModel.NUMERO_SAI)

    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lSaidasModel.Free;
    lSaidasItensModel.Free;
  end;
end;

procedure TForm1.Button108Click(Sender: TObject);
var
  lSaidasItens : TSaidasitensModel;
  lResultado   : TFDMemTable;
begin
  lSaidasItens := TSaidasitensModel.Create(vIConexao);
  try
    lResultado := lSaidasItens.ObterTotais('000260');
    dsSaidas.DataSet := lResultado;
  finally
    lSaidasItens.Free;
  end;
end;

procedure TForm1.Button109Click(Sender: TObject);
var
  lLojasModel : TLojasModel;
  lResultado  : TFDMemTable;
begin
  lLojasModel := TLojasModel.Create(vIConexao);
  try
    lResultado := lLojasModel.obterFiliais;
    dsSaidas.DataSet := lResultado;
  finally
    lLojasModel.Free;
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
  lWebPedidoItensModel : TWebPedidoItensModel;
  ID                   : String;
begin
  lWebPedidoItensModel := TWebPedidoItensModel.Create(vIConexao);
  try
    try
      ID := InputBox('WebPedido', 'Digite o ID que deseja alterar:', '');

      if ID.IsEmpty then
        exit;

      lWebPedidoItensModel := lWebPedidoItensModel.Alterar(ID);
      lWebPedidoItensModel.PRODUTO_ID := '000001';
      lWebPedidoItensModel.QUANTIDADE := '25';
      lWebPedidoItensModel.VLR_GARANTIA := '10';
      lWebPedidoItensModel.Salvar;

      ShowMessage('Alterado o item com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoItensModel.Free;
  end;
end;

procedure TForm1.Button110Click(Sender: TObject);
var
  lSaidasModel : TSaidasModel;
  lParams      : TSaidaItensTransferenciaParams;
begin
  lSaidasModel := TSaidasModel.Create(vIConexao);

  try
    lSaidasModel := lSaidasModel.carregaClasse('000224');

    lParams.CODIGO_PRO      := '000006';
    lParams.QUANTIDADE_SAI  := '2';

    lSaidasModel.AdicionarItensTransferencia(lParams);

  finally
    lSaidasModel.Free;
  end;

end;

procedure TForm1.Button111Click(Sender: TObject);
var
  lSaidasItensModel : TSaidasItensModel;
begin
  lSaidasItensModel := TSaidasItensModel.Create(vIConexao);
  try
    lSaidasItensModel.Excluir('644');
  finally
    lSaidasItensModel.Free;
  end;
end;

procedure TForm1.Button112Click(Sender: TObject);
var
  lSaidasModel : TSaidasModel;
begin
  lSaidasModel := TSaidasModel.Create(vIConexao);
  try
    lSaidasModel.NUMERO_SAI := '000262';
    lSaidasModel := lSaidasModel.carregaClasse(lSaidasModel.NUMERO_SAI);

    lSaidasModel.CalcularPeso;
  finally
    lSaidasModel.Free;
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  lWebPedidoItensModel : TWebPedidoItensModel;
  lNumeroItem          : String;

begin
  lWebPedidoItensModel := TWebPedidoItensModel.Create(vIConexao);

  try
    try
      lNumeroItem := InputBox('WebPedido', 'Digite o ID que deseja excluir:', '');

      lWebPedidoItensModel.ID := lNumeroItem;
      lWebPedidoItensModel.Excluir(lNumeroItem);

      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoItensModel.Free;
  end;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  lSaldoModel : TSaldoModel;
  lMemTable   : TFDMemTable;
  lProduto    : String;
begin
  lSaldoModel := TSaldoModel.Create(vIConexao);
  try
    lProduto  := InputBox('Consulta de Saldo', 'Digite o código do produto:', '');

    lMemTable := lSaldoModel.obterSaldo(lProduto);

    memoResultado.Lines.Clear;
    memoResultado.Lines.Add('SALDO_FISICO: '+lMemTable.FieldByName('SALDO_FISICO').AsString);
    memoResultado.Lines.Add('SALDO_DISPONIVEL: '+lMemTable.FieldByName('SALDO_DISPONIVEL').AsString);
    memoResultado.Lines.Add('SALDO_CD: '+lMemTable.FieldByName('SALDO_CD').AsString);
    memoResultado.Lines.Add('===============================================');
  finally
    lSaldoModel.Free;
  end;
end;

procedure TForm1.Button13Click(Sender: TObject);
var
  lProdutoModel : TProdutosModel;
  lProduto      : String;
  lParametros   : TProdutoPreco;
  lValor        : Double;
begin
  lProdutoModel := TProdutosModel.Create(vIConexao);
  try
     lProduto  := InputBox('Consulta de Saldo', 'Digite o código do produto:', '');

     lParametros.Produto     := lProduto;
     lParametros.TabelaPreco := true;
     lParametros.Promocao    := true;

     lValor := lProdutoModel.ValorUnitario(lParametros);

     memoResultado.Lines.Clear;
     memoResultado.Lines.Add('VALOR DE VENDA: '+ lValor.ToString);
     memoResultado.Lines.Add('===============================================');
  finally
    lProdutoModel.Free;
  end;
end;

procedure TForm1.Button14Click(Sender: TObject);
var
  lSaldoModel : TSaldoModel;
  lProduto    : String;
  lMemTable   : TFDMemTable;
begin
  lSaldoModel := TSaldoModel.Create(vIConexao);
  try
    lProduto  := InputBox('Reservas CD', 'Digite o código do produto:', '');

    lMemTable := lSaldoModel.obterReservasCD(lProduto);

    memoResultado.Lines.Clear;

    lMemTable.First;
    while not lMemTable.eof do
    begin
      memoResultado.Lines.Add('DOCUMENTO: '+ lMemTable.FieldByName('DOCUMENTO').AsString);
      memoResultado.Lines.Add('ORIGEM:    '+ lMemTable.FieldByName('ORIGEM').AsString);
      memoResultado.Lines.Add('DATA:      '+ lMemTable.FieldByName('DATA').AsString);
      memoResultado.Lines.Add('CLIENTE:   '+ lMemTable.FieldByName('CLIENTE').AsString);
      memoResultado.Lines.Add('RESERVADO: '+ lMemTable.FieldByName('RESERVADO').AsString);
      memoResultado.Lines.Add('LOJA:      '+ lMemTable.FieldByName('LOJA').AsString);
      memoResultado.Lines.Add('===============================================');
      lMemTable.Next;
    end;

  finally
    lSaldoModel.Free;
  end;
end;

procedure TForm1.Button15Click(Sender: TObject);
var
  lEntradaModel : TEntradaModel;
  NumEntrada    : String;
begin
  lEntradaModel := TEntradaModel.Create(vIConexao);
  try
    try
      NumEntrada := InputBox('Entrada','Digite o número da Entrada (9 Digitos):','');

      if NumEntrada.IsEmpty then
        Exit;

      lEntradaModel.NUMERO_ENT  := NumEntrada;
      lEntradaModel.CODIGO_FOR  := '500005';
      lEntradaModel.SERIE_ENT   := '001';

      lEntradaModel.Incluir;
      ShowMessage('Inserido com Sucesso');
    Except
      on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.Button16Click(Sender: TObject);
var
  lContasPagarModel : TContasPagarModel;
begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);
  try
    try

      lContasPagarModel.DUPLICATA_PAG  := '9000002024';
      lContasPagarModel.CODIGO_FOR     := '500005';
      lContasPagarModel.PORTADOR_ID    := '000001';
      lContasPagarModel.DATAEMI_PAG    := '27.02.2024';
      lContasPagarModel.TIPO_PAG       := 'M';
      lContasPagarModel.VALOR_PAG      := '1000';
      lContasPagarModel.CONDICOES_PAG  := '30/60/90';

      lContasPagarModel.Incluir;
      ShowMessage('Inserido com Sucesso');
    Except
      on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarModel.Free;
  end;
end;

procedure TForm1.Button17Click(Sender: TObject);
var
  lEntradaModel : TEntradaModel;
  lMemTable : TFDMemTable;
begin
  lEntradaModel := TEntradaModel.Create(vIConexao);
  try
    try
      lMemTable := lEntradaModel.obterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('NUMERO_ENT: '+lMemTable.FieldByName('NUMERO_ENTRADA').AsString);
        memoResultado.Lines.Add('SERIE: '+lMemTable.FieldByName('SERIE').AsString);
        memoResultado.Lines.Add('CODIGO_FOR: '+lMemTable.FieldByName('COD_FORNECEDOR').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.FieldByName('NOME_FORNECEDOR').AsString);
        memoResultado.Lines.Add('ENDERECO_FORNECEDOR: '+lMemTable.FieldByName('ENDERECO_FORNECEDOR').AsString);
        memoResultado.Lines.Add('NUMERO_FORNECEDOR: '+lMemTable.FieldByName('NUMERO_FORNECEDOR').AsString);
        memoResultado.Lines.Add('BAIRRO_FORNECEDOR: '+lMemTable.FieldByName('BAIRRO_FORNECEDOR').AsString);
        memoResultado.Lines.Add('CIDADE_FORNECEDOR: '+lMemTable.FieldByName('CIDADE_FORNECEDOR').AsString);
        memoResultado.Lines.Add('CNPJ_CPF_FORNECEDOR: '+lMemTable.FieldByName('CNPJ_CPF_FORNECEDOR').AsString);
        memoResultado.Lines.Add('DATANOTA_ENT: '+lMemTable.FieldByName('DATA_EMISSAO').AsString);
        memoResultado.Lines.Add('TOTAL_ENT: '+lMemTable.FieldByName('VALOR_TOTAL').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.Button18Click(Sender: TObject);
var
  lEntradaModel     : TEntradaModel;
  lNumeroEntrada,
  lCodigoFornecedor : String;
begin
  lEntradaModel := TEntradaModel.Create(vIConexao);
  try
    try
      lNumeroEntrada    := '9999999999';
      lCodigoFornecedor := '500005';

      lEntradaModel := lEntradaModel.Alterar(lNumeroEntrada, lCodigoFornecedor);
      lEntradaModel.OBSERVACAO_ENT := 'TESTE ALTERACAO';

      lEntradaModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.Button19Click(Sender: TObject);
var
  lEntradaModel     : TEntradaModel;
  lNumeroEntrada,
  lCodigoFornecedor : String;
begin
  lEntradaModel := TEntradaModel.Create(vIConexao);
  try
    try
      lNumeroEntrada    := '9999999999';
      lCodigoFornecedor := '500005';

      lEntradaModel.Excluir(lNumeroEntrada, lCodigoFornecedor);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel.Free;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Release;
  Form1 := nil;
  Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  lUsuario      : TUsuario;
  lEmpresa      : TEmpresa;
  lEmpresaModel : TEmpresaModel;
  lConfiguracoes : TerasoftConfiguracoes;
begin
  vIConexao := TControllersConexao.New;
  vIConexao.connection;

  vConfiguracoes := TerasoftConfiguracoes.Create(vIConexao);

  vIConexao.setTerasoftConfiguracoes(vConfiguracoes);

  lUsuario.ID     := '000001';
  lUsuario.NOME   := 'ADMIN';
  lUsuario.PERFIL := '000000';

  vIConexao.setUser(lUsuario);

  lEmpresaModel := TEmpresaModel.Create(vIConexao);
  lEmpresaModel.Carregar;

  lEmpresa.ID                     := lEmpresaModel.ID;
  lEmpresa.LOJA                   := lEmpresaModel.LOJA;
  lEmpresa.STRING_CONEXAO_RESERVA := lEmpresaModel.STRING_CONEXAO_RESERVA;

  vIConexao.setEmpresa(lEmpresa);

  vQtdeRegistros := 10;
  vPagina        := 0;
end;

procedure TForm1.OrcamentoAlterarClick(Sender: TObject);
var
  lOrcamentoModel : TOrcamentoModel;
  ID : String;
begin
  lOrcamentoModel := TOrcamentoModel.Create(vIConexao);
  try
    try
      ID := InputBox('ORCAMENTO', 'Digite o ID do ORCAMENTO que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lOrcamentoModel := lOrcamentoModel.Alterar(ID);
      lOrcamentoModel.CODIGO_VEN := '000002';

      lOrcamentoModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lOrcamentoModel.Free;
  end;
end;

procedure TForm1.OrcamentoConsultarClick(Sender: TObject);
var
  lOrcamentoModel : TOrcamentoModel;
  lMemTable       : TFDMemTable;
begin
  lOrcamentoModel := TOrcamentoModel.Create(vIConexao);
  try
    try
      lMemTable := lOrcamentoModel.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('NUMERO_ORC: '+lMemTable.FieldByName('NUMERO_ORC').AsString);
        memoResultado.Lines.Add('NOME_FUN: '+lMemTable.FieldByName('NOME_FUN').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lOrcamentoModel.Free;
  end;

end;

procedure TForm1.OrcamentoExcluirClick(Sender: TObject);
var
  lOrcamentoModel : TOrcamentoModel;
  ID : String;
begin
  lOrcamentoModel := TOrcamentoModel.Create(vIConexao);
  try
    try
      ID := InputBox('ORCAMENTO', 'Digite o ID do ORCAMENTO que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lOrcamentoModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lOrcamentoModel.Free;
  end;
end;

procedure TForm1.OrcamentoIncluirClick(Sender: TObject);
var
  lOrcamentoModel : TOrcamentoModel;
begin
  lOrcamentoModel := TOrcamentoModel.Create(vIConexao);
  try
    try
      lOrcamentoModel.CODIGO_CLI  := '000001';
      lOrcamentoModel.CODIGO_VEN  := '000001';
      lOrcamentoModel.TOTAL_ORC   := 1000;

      lOrcamentoModel.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lOrcamentoModel.Free;
  end;
end;

procedure TForm1.OrcamentoItensAlterarClick(Sender: TObject);
var
  lOrcamentoItensModel : TOrcamentoItensModel;
  ID : String;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.Create(vIConexao);
  try
    try
      ID := InputBox('ORCAMENTOITENS', 'Digite o ID do ORCAMENTOITENS que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lOrcamentoItensModel := lOrcamentoItensModel.Alterar(ID);
      lOrcamentoItensModel.CODIGO_PRO := '000345';

      lOrcamentoItensModel.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lOrcamentoItensModel.Free;
  end;
end;

procedure TForm1.OrcamentoItensConsultarClick(Sender: TObject);
var
  lOrcamentoItensModel : TOrcamentoItensModel;
  lMemTable            : TFDMemTable;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.Create(vIConexao);
  try
    try
      lMemTable := lOrcamentoItensModel.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.First;
      while not lMemTable.Eof do
      begin
        memoResultado.Lines.Add('CODIGO_PRO: '+lMemTable.FieldByName('CODIGO_PRO').AsString);
        memoResultado.Lines.Add('TOTAL: '+lMemTable.FieldByName('TOTAL').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lOrcamentoItensModel.Free;
  end;
end;

procedure TForm1.OrcamentoItensExcluirClick(Sender: TObject);
var
  lOrcamentoItensModel : TOrcamentoItensModel;
  ID : String;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.Create(vIConexao);
  try
    try
      ID := InputBox('ORCAMENTO', 'Digite o ID do ORCAMENTO que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lOrcamentoItensModel.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lOrcamentoItensModel.Free;
  end;

end;

procedure TForm1.OrcamentoItensIncluirClick(Sender: TObject);
var
  lOrcamentoItensModel : TOrcamentoItensModel;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.Create(vIConexao);
  try
    try
      lOrcamentoItensModel.NUMERO_ORC         := '000015';
      lOrcamentoItensModel.CODIGO_PRO         := '000001';
      lOrcamentoItensModel.VALORUNITARIO_ORC  := 1000;

      lOrcamentoItensModel.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lOrcamentoItensModel.Free;
  end;
end;

end.
