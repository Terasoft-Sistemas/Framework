
{$i definicoes.inc}

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
  ACBrMail,
  Terasoft.Types,
  Conexao,
  Interfaces.Conexao, EntradaModel, Vcl.Grids, XDBGrids, Data.DB,
  Terasoft.Configuracoes, Terasoft.FuncoesTexto, Vcl.Buttons, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet;

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
    btnDescontoAutorizar: TButton;
    btnDescontoNegar: TButton;
    TabSheet9: TTabSheet;
    XDBGrid9: TXDBGrid;
    Button88: TButton;
    Button113: TButton;
    Button114: TButton;
    Button115: TButton;
    dMovimentoSerial: TDataSource;
    TabSheet10: TTabSheet;
    imprimirGarantidaEstendida: TButton;
    imprimirRF: TButton;
    imprimirPrestamista: TButton;
    imprimirRFD: TButton;
    Usuario: TTabSheet;
    Button112: TButton;
    TabelaJurosDia: TTabSheet;
    Button133: TButton;
    Memo1: TMemo;
    TabelaJurosPromocao: TTabSheet;
    btnObterJurosPromocao: TButton;
    SpeedButton1: TSpeedButton;
    dbGridTabelaJuros: TXDBGrid;
    dsJuros: TDataSource;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    imprimirContratoCarteira: TButton;
    SpeedButton4: TSpeedButton;
    FDMemTable1: TFDMemTable;
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
    procedure btnDescontoClick(Sender: TObject);
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
    procedure BuButton116Click(Sender: TObject);
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
    procedure btnDescontoAutorizarClick(Sender: TObject);
    procedure btnDescontoNegarClick(Sender: TObject);
    procedure Button88Click(Sender: TObject);
    procedure Button113Click(Sender: TObject);
    procedure Button114Click(Sender: TObject);
    procedure Button117Click(Sender: TObject);
    procedure imprimirGarantidaEstendidaClick(Sender: TObject);
    procedure imprimirRFClick(Sender: TObject);
    procedure imprimirRFDClick(Sender: TObject);
    procedure imprimirPrestamistaClick(Sender: TObject);
    procedure Button116Click(Sender: TObject);
    procedure Button133Click(Sender: TObject);
    procedure btnObterJurosPromocaoClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imprimirContratoCarteiraClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FDMemTable1BeforePost(DataSet: TDataSet);

  private
    { Private declarations }
    vQtdeRegistros,
    vPagina         : Integer;
    dsTmp,dsTmp2: IFDDataset;

  public
    { Public declarations }
    vIConexao : IConexao;
    vConfiguracoes : ITerasoftConfiguracoes;
  end;

var
  Form1: TForm1;

implementation

uses
  Terasoft.Framework.Bytes,
  FuncoesArquivos,
  FinanceiroPedidoModel,
  WebPedidoModel,
  PCGDao,
  TipoVendadao,
  TipoVendaModel,
  Form.Endpoint,
  Controllers.Conexao,
  WebPedidoItensModel,
  TabelaJurosModel,
  SaldoModel, EmpresaModel, ProdutosModel, EntradaItensModel,
  ClienteModel, ContasPagarModel, ContasPagarItensModel, System.SysUtils,
  ReservaModel, DocumentoModel, AnexoModel, FluxoCaixaModel, BancoModel,
  PortadorModel, LojasModel, OSModel, SimuladorPrecoModel, GrupoModel, CNPJModel, CEPModel,
  PedidoCompraModel, PedidoCompraItensModel, ClientesContatoModel, DescontoModel,
  PromocaoModel, TransportadoraModel, PrevisaoPedidoCompraModel, SaidasModel,
  SaidasItensModel, ClientesEnderecoModel, OrcamentoModel, OrcamentoItensModel, Terasoft.Utils,
  SolicitacaoDescontoModel, PermissaoRemotaModel, MovimentoSerialModel, Impressao.Contratos,
  UsuarioModel, TabelaJurosDiaModel, TabelaJurosPromocaoModel, EndPointEditor;

{$R *.dfm}

procedure TForm1.btnConsultaDescontoClick(Sender: TObject);
var
  lSolicitacaoDescontoModel : ITSolicitacaoDescontoModel;
begin
  lSolicitacaoDescontoModel := TSolicitacaoDescontoModel.getNewIface(vIConexao);
  try
    lSolicitacaoDescontoModel.objeto.WhereView := ' and solicitacao_desconto.tabela_origem = ''WEB_PEDIDO'' ';
      //Aki o dataset será zerado apos sair da função.
      //Precisa deixar este contexto ativo...                  a
    dsTmp := lSolicitacaoDescontoModel.objeto.obterLista;
    dLiberacao.DataSet := dsTmp.objeto;
  finally
    lSolicitacaoDescontoModel:=nil;
  end;
end;

procedure TForm1.btnConsultaPermissaoClick(Sender: TObject);
var
  lPermissaoRemotaModel : ITPermissaoRemotaModel;
  lVendaAssistida       : String;
begin
  lPermissaoRemotaModel := TPermissaoRemotaModel.getNewIface(vIConexao);
  try
    lVendaAssistida := '4343';

    lPermissaoRemotaModel.objeto.WhereView := ' and permissao_remota.tabela = ''WEB_PEDIDOITENS'' and permissao_remota.pedido_id = '+lVendaAssistida;
      //Aki o dataset será zerado apos sair da função.
      //Precisa deixar este contexto ativo...                  a
    dsTmp := lPermissaoRemotaModel.objeto.obterLista;
    dLiberacao.DataSet := dsTmp.objeto;
  finally
    lPermissaoRemotaModel:=nil;
  end;
end;

procedure TForm1.BtnEndereco1Click(Sender: TObject);
var
  lClientesEnderecoModel : ITClientesEnderecoModel;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.getNewIface(vIConexao);
  try
    try
      lClientesEnderecoModel.objeto.ID          := 10;
      lClientesEnderecoModel.objeto.CLIENTE_ID  := '000001';
      lClientesEnderecoModel.objeto.ENDERECO     := 'TESTE TERASOFT';

      lClientesEnderecoModel.objeto.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lClientesEnderecoModel:=nil;
  end;
end;

procedure TForm1.BtnEndereco2Click(Sender: TObject);
var
  lClientesEnderecoModel : ITClientesEnderecoModel;
  lMemTable   : IFDDataset;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lClientesEnderecoModel.objeto.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.objeto.FieldByName('ID').AsString);
        memoResultado.Lines.Add('CLIENTE_ID: '+lMemTable.objeto.FieldByName('CLIENTE_ID').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClientesEnderecoModel:=nil;
  end;
end;

procedure TForm1.BtnEndereco3Click(Sender: TObject);
var
  lClientesEnderecoModel : ITClientesEnderecoModel;
  ID          : String;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('CLIENTES_ENDERECO', 'Digite o ID do Contato que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lClientesEnderecoModel := lClientesEnderecoModel.objeto.Alterar(ID);
      lClientesEnderecoModel.objeto.ENDERECO := 'TESTE ALTERAR';

      lClientesEnderecoModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lClientesEnderecoModel:=nil;
  end;
end;

procedure TForm1.BtnEndereco4Click(Sender: TObject);
var
  lClientesEnderecoModel : ITClientesEnderecoModel;
  ID        : String;
begin
  lClientesEnderecoModel := TClientesEnderecoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('CLIENTES_ENDERECO', 'Digite o ID do Contato que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lClientesEnderecoModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClientesEnderecoModel:=nil;
  end;
end;

procedure TForm1.btnFinanceiroPedidoClick(Sender: TObject);
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  lMemTable : IFDDataset;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lFinanceiroPedidoModel.objeto.obterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.objeto.FieldByName('ID').AsString);
        memoResultado.Lines.Add('PORTADOR_ID: '+lMemTable.objeto.FieldByName('PORTADOR_ID').AsString);
        memoResultado.Lines.Add('PORTADOR_NOME: '+lMemTable.objeto.FieldByName('NOME_PORT').AsString);
        memoResultado.Lines.Add('PARCELA: '+lMemTable.objeto.FieldByName('PARCELA').AsString);
        memoResultado.Lines.Add('VALOR_PARCELA: '+lMemTable.objeto.FieldByName('VALOR_PARCELA').AsString);
        memoResultado.Lines.Add('VALOR_TOTAL: '+lMemTable.objeto.FieldByName('VALOR_TOTAL').AsString);

        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel:=nil;
  end;
end;

procedure TForm1.btnObterJurosPromocaoClick(Sender: TObject);
var
  lTabelaJurosPromocaoModel : ITTabelaJurosPromocaoModel;
  lMemTable                 : IFDDataset;
begin
  lTabelaJurosPromocaoModel := TTabelaJurosPromocaoModel.getNewIface(vIConexao);
  try
    lMemTable := lTabelaJurosPromocaoModel.objeto.obterLista;

      //Aki o dataset será zerado apos sair da função.
      //Precisa deixar este contexto ativo...                  a
    dsTmp := lMemTable;
    dsJuros.DataSet := dsTmp.objeto;

  finally
    lTabelaJurosPromocaoModel:=nil;
  end;
end;

procedure TForm1.btnReservaClick(Sender: TObject);
var
  lReservaModel : ITReservaModel;
  lWebPedidoItensModel : ITWebPedidoItensModel;
begin
  lReservaModel        := TReservaModel.getNewIface(vIConexao.NovaConexao('', vIConexao.getEmpresa.STRING_CONEXAO_RESERVA));
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(vIConexao);

  try
    lWebPedidoItensModel := lWebPedidoItensModel.objeto.carregaClasse('1091');

    lReservaModel.objeto.PRODUTO_ID          := lWebPedidoItensModel.objeto.PRODUTO_ID;
    lReservaModel.objeto.QUANTIDADE          :=lWebPedidoItensModel.objeto.QUANTIDADE;
    lReservaModel.objeto.VALOR_UNITARIO      := lWebPedidoItensModel.objeto.VALOR_UNITARIO;
    lReservaModel.objeto.OBSERVACAO          := 'Reservar realizada pela venda assistida N '+lWebPedidoItensModel.objeto.WEB_PEDIDO_ID;
    lReservaModel.objeto.WEB_PEDIDOITENS_ID  := lWebPedidoItensModel.objeto.ID;
    lReservaModel.objeto.WEB_PEDIDO_ID       := lWebPedidoItensModel.objeto.WEB_PEDIDO_ID;
    lReservaModel.objeto.TIPO                := lWebPedidoItensModel.objeto.TIPO;
    lReservaModel.objeto.ENTREGA             := lWebPedidoItensModel.objeto.ENTREGA;
    lReservaModel.objeto.RETIRA_LOJA         := IIF(lWebPedidoItensModel.objeto.TIPO_ENTREGA = 'LJ','S','N');;
    lReservaModel.objeto.STATUS              := IIF(lWebPedidoItensModel.objeto.TIPO_ENTREGA = 'LJ','L','1');
    lReservaModel.objeto.CLIENTE_ID          := '000000';
    lReservaModel.objeto.VENDEDOR_ID         := '000000';
    lReservaModel.objeto.FILIAL              := '000';

    lReservaModel.objeto.Incluir;

    lWebPedidoItensModel := lWebPedidoItensModel.objeto.carregaClasse('1091');

  finally
    lWebPedidoItensModel:=nil;
    lReservaModel:=nil;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  lFinanceiroParams      : TFinanceiroParams;
  lTabelaJurosModel      : ITTabelaJurosModel;
  lMemJuros              : IFDDataset;
  lJuros,
  lValorPago             : Double;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);
  lTabelaJurosModel      := TTabelaJurosModel.getNewIface(vIConexao);
  try
    try
      lValorPago := 10000;
      lMemJuros  := lTabelaJurosModel.objeto.obterLista('000005', lValorPago, true, vIConexao.dataServer);

      lFinanceiroParams.WEB_PEDIDO_ID       := '422';
      lFinanceiroParams.PORTADOR_ID         := '000005';
      lFinanceiroParams.PRIMEIRO_VENCIMENTO := Date + 30;
      lFinanceiroParams.QUANTIDADE_PARCELAS := 5;

      lMemJuros.objeto.first;
      lMemJuros.objeto.locate('CODIGO', '005', []);

      lJuros := lMemJuros.objeto.FieldByName('VALOR_JUROS').AsFloat;
      lFinanceiroParams.INDCE_APLICADO      := lMemJuros.objeto.FieldByName('PERCENTUAL').AsFloat;
      lFinanceiroParams.VALOR_ACRESCIMO     := lJuros;

      lFinanceiroParams.VALOR_LIQUIDO       := lValorPago;
      lFinanceiroParams.VALOR_TOTAL         := lValorPago + lJuros;

      lFinanceiroPedidoModel.objeto.gerarFinanceiro(lFinanceiroParams);

      ShowMessage('Inserido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel:=nil;
    lTabelaJurosModel:=nil;
  end;
end;

procedure TForm1.Button20Click(Sender: TObject);
var
  lClienteModel : ITClienteModel;
  lMemTable     : IFDDataset;
  i             : Integer;
begin
  lClienteModel := TClienteModel.getNewIface(vIConexao);
    try
      try
        lClienteModel.objeto.LengthPageView  := vQtdeRegistros.ToString;
        lClienteModel.objeto.StartRecordView := vPagina.ToString;
        lClienteModel.objeto.OrderView       := 'CODIGO_CLI';

        inc(vPagina, 10);

        lMemTable := lClienteModel.objeto.ObterListaMemTable;
        memoResultado.Lines.Clear;
        lMemTable.objeto.First;

      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('CODIGO_CLI: '+lMemTable.objeto.FieldByName('CODIGO_CLI').AsString);
        memoResultado.Lines.Add('FANTASIA_CLI: '+lMemTable.objeto.FieldByName('FANTASIA_CLI').AsString);
        memoResultado.Lines.Add('RAZAO_CLI: '+lMemTable.objeto.FieldByName('RAZAO_CLI').AsString);
        memoResultado.Lines.Add('CNPJ_CPF_CLI: '+lMemTable.objeto.FieldByName('CNPJ_CPF_CLI').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClienteModel:=nil;
  end;
end;

procedure TForm1.Button21Click(Sender: TObject);
var
  lClienteModel : ITClienteModel;
  ID            : String;
begin
  lClienteModel := TClienteModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('Cliente', 'Digite o ID que deseja Alterar:', '');

      if ID.IsEmpty then
        exit;

      lClienteModel := lClienteModel.objeto.Alterar(ID);
      lClienteModel.objeto.fantasia_cli := 'TESTE ALTERA FANTASIA - ' + randomBase32(10);

      lClienteModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lClienteModel:=nil;
  end;
end;

procedure TForm1.Button22Click(Sender: TObject);
var
  lClienteModel : ITClienteModel;
  CodCli        : String;
begin
  lClienteModel := TClienteModel.getNewIface(vIConexao);
  try
    try
      CodCli := InputBox('Cliente', 'Digite o ID do Cliente que deseja excluir:', '');

      lClienteModel.objeto.Excluir(CodCli);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClienteModel:=nil;
  end;
end;

procedure TForm1.Button23Click(Sender: TObject);
var
  lClienteModel : ITClienteModel;
  NomeCli       : String;
begin
  lClienteModel := TClienteModel.getNewIface(vIConexao);
  try
    try
      NomeCli := InputBox('Cliente', 'Digite o Nome:', '');

      if NomeCli.IsEmpty then
        exit;

      lClienteModel.objeto.fantasia_cli    := NomeCli;
      lClienteModel.objeto.tipo_cli        := 'F';
      lClienteModel.objeto.seprocado_cli   := 'N';
      lClienteModel.objeto.estadocivil_cli := 'O';
      lClienteModel.objeto.status          := 'A';
      lClienteModel.objeto.sexo_cli        := 'M';

      lClienteModel.objeto.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lClienteModel:=nil;
  end;
end;

procedure TForm1.Button24Click(Sender: TObject);
var
  lContasPagarModel : ITContasPagarModel;
  lFornecedor,
  lDuplicata    : String;

begin
  lContasPagarModel := TContasPagarModel.getNewIface(vIConexao);
  try
    try
      lDuplicata  := '';
      lFornecedor := '';

      lContasPagarModel := lContasPagarModel.objeto.Alterar(lDuplicata, lFornecedor);
      lContasPagarModel.objeto.CODIGO_FOR := '000175';

      lContasPagarModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lContasPagarModel:=nil;
  end;
end;

procedure TForm1.Button25Click(Sender: TObject);
var
  lContasPagarModel : ITContasPagarModel;
  lMemTable         : IFDDataset;
begin
  lContasPagarModel := TContasPagarModel.getNewIface(vIConexao);
  try
    try

      lContasPagarModel.objeto.LengthPageView  := vQtdeRegistros.ToString;
      lContasPagarModel.objeto.StartRecordView := vPagina.ToString;
      lContasPagarModel.objeto.OrderView       := 'DUPLICATA_PAG';

      inc(vPagina, 10);

      lMemTable := lContasPagarModel.objeto.obterLista;
      memoResultado.Lines.Clear;
      lMemTable.objeto.First;

      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('DUPLICATA_PAG: '+lMemTable.objeto.FieldByName('DUPLICATA_PAG').AsString);
        memoResultado.Lines.Add('CODIGO_FOR: '+lMemTable.objeto.FieldByName('CODIGO_FOR').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.objeto.FieldByName('FORNECEDOR').AsString);
        memoResultado.Lines.Add('PORTADOR_ID: '+lMemTable.objeto.FieldByName('PORTADOR_ID').AsString);
        memoResultado.Lines.Add('PORTADOR: '+lMemTable.objeto.FieldByName('PORTADOR').AsString);
        memoResultado.Lines.Add('DATAEMI_PAG: '+lMemTable.objeto.FieldByName('DATAEMI_PAG').AsString);
        memoResultado.Lines.Add('TIPO_PAG: '+lMemTable.objeto.FieldByName('TIPO_PAG').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;

    Except
      on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarModel:=nil;
  end;
end;

procedure TForm1.Button26Click(Sender: TObject);
var
  lContasPagarModel : ITContasPagarModel;
  Duplicata, Fornecedor : String;

begin
  lContasPagarModel := TContasPagarModel.getNewIface(vIConexao);
  try
    try
      Duplicata := InputBox('Cliente', 'Digite a Duplicata que deseja excluir:', '');

      if Duplicata.IsEmpty then
      Exit;

      lContasPagarModel.objeto.Excluir(Duplicata,Fornecedor);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarModel:=nil;
  end;
end;

procedure TForm1.Button27Click(Sender: TObject);
var
  lContasPagarModel :  ITContasPagarModel;
  Duplicata         : String;
begin
  lContasPagarModel := TContasPagarModel.getNewIface(vIConexao);
  try
    try
      lContasPagarModel.objeto.gerarDuplicatas('9000002024', '500005');

      ShowMessage('Parcela adicionada com sucesso!');
    Except
      on E:Exception do
      ShowMessage('Erro inserir parcelas:' + E.Message);
    end;
  finally
    lContasPagarModel:=nil;
  end;
end;

procedure TForm1.Button28Click(Sender: TObject);
var
  lContasPagarItensModel  : ITContasPagarItensModel;
  Duplicata               : String;
  i                       : Integer;
  lMemTable               : IFDDataset;
begin
  lContasPagarItensModel := TContasPagarItensModel.getNewIface(vIConexao);
  try
    try
      Duplicata := InputBox('ContasPagar', 'Digite a Duplicata para consultar os itens:', '');
      if Duplicata.IsEmpty then
        exit;

      lContasPagarItensModel.objeto.DuplicataView := Duplicata;

      lMemTable := lContasPagarItensModel.objeto.obterLista;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('DUPLIACATA_PAG: '+lMemTable.objeto.FieldByName('DUPLIACATA_PAG').AsString);
        memoResultado.Lines.Add('CODIGO_FOR: '+lMemTable.objeto.FieldByName('CODIGO_FOR').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.objeto.FieldByName('FORNECEDOR').AsString);
        memoResultado.Lines.Add('PORTADOR_ID: '+lMemTable.objeto.FieldByName('PORTADOR_ID').AsString);
        memoResultado.Lines.Add('PORTADOR: '+lMemTable.objeto.FieldByName('PORTADOR').AsString);
        memoResultado.Lines.Add('VENC_PAG: '+lMemTable.objeto.FieldByName('VENC_PAG').AsString);
        memoResultado.Lines.Add('PACELA_PAG: '+lMemTable.objeto.FieldByName('PACELA_PAG').AsString);
        memoResultado.Lines.Add('VALORPARCELA_PAG: '+lMemTable.objeto.FieldByName('VALORPARCELA_PAG').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
    on E:Exception do
       ShowMessage('Erro consultar itens' + E.Message);
    end;
  finally
    lContasPagarItensModel:=nil;
  end;
end;

procedure TForm1.Button29Click(Sender: TObject);
var
  lContasPagarItensModel : ITContasPagarItensModel;
  pDuplicata,
  pIDItem        : String;
begin
  lContasPagarItensModel := TContasPagarItensModel.getNewIface(vIConexao);
  try
    try
      pDuplicata := 'R00006';
      pIDItem    := '20198';

      lContasPagarItensModel := lContasPagarItensModel.objeto.Alterar(pDuplicata, pIDItem);
      lContasPagarItensModel.objeto.VENC_PAG := '10.05.2024';

      lContasPagarItensModel.objeto.Salvar;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  lContasPagarItensModel:=nil;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  IDRegistro             : String;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);

  try
    try
      IDRegistro := InputBox('FinanceiroPedido', 'Digite o ID do registro Financeiro:', '');

      if IDRegistro.IsEmpty then
        exit;

      lFinanceiroPedidoModel := lFinanceiroPedidoModel.objeto.Alterar(IDRegistro);
      lFinanceiroPedidoModel.objeto.WEB_PEDIDO_ID := '325';
      lFinanceiroPedidoModel.objeto.PORTADOR_ID   := '000001';
      lFinanceiroPedidoModel.objeto.VALOR_TOTAL   := '800';
      lFinanceiroPedidoModel.objeto.PARCELA       := '3';
      lFinanceiroPedidoModel.objeto.VALOR_PARCELA := '150';
      lFinanceiroPedidoModel.objeto.Salvar;

      ShowMessage('Alterado com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel:=nil;
  end;
end;

procedure TForm1.Button30Click(Sender: TObject);
var
  lContasPagarItensModel : ITContasPagarItensModel;
  NumParcela             : String;
begin
  lContasPagarItensModel := TContasPagarItensModel.getNewIface(vIConexao);
  try
    try
      NumParcela := InputBox('ContasPagarItens','Digite o ID da parcela','');
      if NumParcela.IsEmpty then
        Exit;

      lContasPagarItensModel.objeto.Excluir(NumParcela);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarItensModel:=nil;
  end;
end;

procedure TForm1.Button31Click(Sender: TObject);
var
  lEntradaItensParams : TEntradaItensParams;
  lEntradaModel       : ITEntradaModel;
  lNumEntrada         : String;
begin
  lEntradaModel  := TEntradaModel.getNewIface(vIConexao);
  try
    try
      lNumEntrada := InputBox('EntradaItens','Digite o número da Entrada:','');

      lEntradaItensParams.NUMERO_ENT      := lNumEntrada;
      lEntradaItensParams.CODIGO_FOR      := '500005';
      lEntradaItensParams.CODIGO_PRO      := '000444';
      lEntradaItensParams.QUANTIDADE_ENT  := '1';
      lEntradaItensParams.VALORUNI_ENT    := '30';

      lEntradaModel.objeto.EntradaItens(lEntradaItensParams);
      ShowMessage('Item adicionado a Entrada: ' + lNumEntrada);
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.Button32Click(Sender: TObject);
var
  lEntradaItensModel : ITEntradaItensModel;
  NumEntrada         : String;
  i                  : Integer;
  lMemTable          : IFDDataset;
begin
  lEntradaItensModel := TEntradaItensModel.getNewIface(vIConexao);
  try
    try
      NumEntrada := InputBox('Constulta EntradaItens','Digite o número da Entrada:','');
        if NumEntrada.IsEmpty then
          Exit;

      lEntradaItensModel.objeto.NumeroView := NumEntrada;
      lEntradaItensModel.objeto.FornecedorView := '500007';
      lMemTable := lEntradaItensModel.objeto.obterLista;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
         memoResultado.Lines.Add('NUMERO_ENT: ' +lMemTable.objeto.FieldByName('NUMERO_ENT').AsString);
         memoResultado.Lines.Add('PRODUTO_CODIGO_PRO: ' +lMemTable.objeto.FieldByName('PRODUTO_CODIGO_PRO').AsString);
         memoResultado.Lines.Add('CST: ' +lMemTable.objeto.FieldByName('CST').AsString);
         memoResultado.Lines.Add('VALOR_LIQUIDO: ' +lMemTable.objeto.FieldByName('VALOR_LIQUIDO').AsString);
         memoResultado.Lines.Add('TOTAL_UNITARIO: ' +lMemTable.objeto.FieldByName('TOTAL_UNITARIO').AsString);
         memoResultado.Lines.Add('ALIQUOTA_ICMS: ' +lMemTable.objeto.FieldByName('ALIQUOTA_ICMS').AsString);
         lMemTable.objeto.Next;
      end;
    except
      on E:Exception do
        ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaItensModel:=nil;
  end;
end;

procedure TForm1.Button33Click(Sender: TObject);
var
  lEntradaItensModel : ITEntradaItensModel;
  pIDItem            : String;
begin
  lEntradaItensModel := TEntradaItensModel.getNewIface(vIConexao);
  try
    try
      pIDItem        := '1916';

      lEntradaItensModel := lEntradaItensModel.objeto.Alterar(pIDItem);
      lEntradaItensModel.objeto.QUANTIDADE_ENT := '5';
      lEntradaItensModel.objeto.Salvar;
      ShowMessage('Alterado com sucesso');
    except
      on E:Exception do
        ShowMessage('Erro: ' + E.Message);
    end;
    finally
      lEntradaItensModel:=nil;
  end;
end;

procedure TForm1.Button34Click(Sender: TObject);
var
  lEntradaItensModel : ITEntradaItensModel;
  ID                 : String;
begin
  lEntradaItensModel := TEntradaItensModel.getNewIface(vIConexao);
  try
    try
      ID := '1916';
      lEntradaItensModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaItensModel:=nil;
  end;
end;

procedure TForm1.Button35Click(Sender: TObject);
var
  lReservaModel : ITReservaModel;
  lCodPro       : String;
begin
  lReservaModel := TReservaModel.getNewIface(vIConexao);
  try
    try
    lCodPro := InputBox('Reservar','Digite o código do Produto:','');
      if lCodPro.IsEmpty then
        Exit;

    lReservaModel.objeto.PRODUTO_ID   := lCodPro;
    lReservaModel.objeto.CLIENTE_ID   := '700504';
    lReservaModel.objeto.VENDEDOR_ID  := '000007';
    lReservaModel.objeto.QUANTIDADE   := '10';
    lReservaModel.objeto.STATUS       := 'L';
    lReservaModel.objeto.FILIAL       := '002';

    lReservaModel.objeto.Incluir;

    ShowMessage('Produto: '+ lCodPro +', reservado! ');
    except
     on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lReservaModel:=nil;
  end;
end;

procedure TForm1.Button36Click(Sender: TObject);
var
  lReservaModel : ITReservaModel;
  lMemTable     : IFDDataset;
begin
  lReservaModel := TReservaModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lReservaModel.objeto.obterLista;
      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.objeto.FieldByName('ID').AsString);
        memoResultado.Lines.Add('PRODUTO_ID: '+lMemTable.objeto.FieldByName('PRODUTO_ID').AsString);
        memoResultado.Lines.Add('PRODUTO: '+lMemTable.objeto.FieldByName('PRODUTO').AsString);
        memoResultado.Lines.Add('VENDEDOR_ID: '+lMemTable.objeto.FieldByName('VENDEDOR_ID').AsString);
        memoResultado.Lines.Add('VENDEDOR: '+lMemTable.objeto.FieldByName('VENDEDOR').AsString);
        memoResultado.Lines.Add('QUANTIDADE: '+lMemTable.objeto.FieldByName('QUANTIDADE').AsString);
        memoResultado.Lines.Add('HORAS_BAIXA: '+lMemTable.objeto.FieldByName('HORAS_BAIXA').AsString);
        memoResultado.Lines.Add('STATUS: '+lMemTable.objeto.FieldByName('STATUS').AsString);
        memoResultado.Lines.Add('FILIAL: '+lMemTable.objeto.FieldByName('FILIAL').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lReservaModel:=nil;
  end;
end;

procedure TForm1.Button37Click(Sender: TObject);
var
  lReservaModel : ITReservaModel;
  ID            : String;
begin
  lReservaModel := TReservaModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('Reserva', 'Digite o ID que deseja Alterar:', '');

      if ID.IsEmpty then
        exit;

      lReservaModel := lReservaModel.objeto.Alterar(ID);
      lReservaModel.objeto.PRODUTO_ID := '000007';
      lReservaModel.objeto.VENDEDOR_ID := '000007';

      lReservaModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lReservaModel:=nil;
  end;
end;

procedure TForm1.Button38Click(Sender: TObject);
var
  lReservaModel : ITReservaModel;
  ID        : String;
begin
  lReservaModel := TReservaModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('Reserva', 'Digite o ID da Reserva que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lReservaModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lReservaModel:=nil;
  end;
end;

procedure TForm1.Button39Click(Sender: TObject);
var
  lDocumentoModel : ITDocumentoModel;
  lDescricao      : String;
begin
  lDocumentoModel := TDocumentoModel.getNewIface(vIConexao);
  try
    try
      lDescricao := InputBox('Documento','Digite a descricao: ','');
      if lDescricao.IsEmpty then
      Exit;

      lDocumentoModel.objeto.NOME := lDescricao;
      lDocumentoModel.objeto.Incluir;

      ShowMessage('Documento incluido com sucesso');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDocumentoModel:=nil;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  IDFinanceiro             : String;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);

  try
    try
      IDFinanceiro := InputBox('FinanceiroPedido', 'Digite o ID Financeiro para excluir:', '');

      if IDFinanceiro.IsEmpty then
        exit;

      lFinanceiroPedidoModel.objeto.Excluir(IDFinanceiro);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro do Except: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel:=nil;
  end;
end;

procedure TForm1.Button40Click(Sender: TObject);
var
  lDocumentoModel : ITDocumentoModel;
  lMemTable : IFDDataset;
begin
  lDocumentoModel := TDocumentoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lDocumentoModel.objeto.obterLista;
      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.objeto.FieldByName('ID').AsString);
        memoResultado.Lines.Add('NOME: '+lMemTable.objeto.FieldByName('NOME').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDocumentoModel:=nil;
  end;
end;

procedure TForm1.Button41Click(Sender: TObject);
var
  lDocumentoModel : ITDocumentoModel;
  ID              : String;
begin
  lDocumentoModel := TDocumentoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('Documento', 'Digite o ID que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lDocumentoModel := lDocumentoModel.objeto.Alterar(ID);
      lDocumentoModel.objeto.NOME := 'TESTE DOC NOME';

      lDocumentoModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lDocumentoModel:=nil;
  end;
end;

procedure TForm1.Button42Click(Sender: TObject);
var
  lDocumentoModel : ITDocumentoModel;
  ID        : String;
begin
  lDocumentoModel := TDocumentoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('Documento', 'Digite o ID do Documento que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lDocumentoModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDocumentoModel:=nil;
  end;
end;

procedure TForm1.Button43Click(Sender: TObject);
var
  lAnexoModel : ITAnexoModel;
  lIDCli    : String;
begin
  lAnexoModel := TAnexoModel.getNewIface(vIConexao);
  try
    try
      lIDCli :=  InputBox('ANEXO','Digite ID do Cliente:','');
      if lIDCli.IsEmpty then
      Exit;

      lAnexoModel.objeto.REGISTRO_ID   := lIDCli;
      lAnexoModel.objeto.TABELA        := 'CLIENTES';
      lAnexoModel.objeto.DOCUMENTO_ID  := '2';

      lAnexoModel.objeto.Incluir;
      ShowMessage('Incluido com sucesso');
    except
       on E:Exception do
         ShowMessage('Erro: ' + E.Message);
      end;
  finally
    lAnexoModel:=nil;
  end;
end;

procedure TForm1.Button44Click(Sender: TObject);
var
  lAnexoModel : ITAnexoModel;
  lMemTable : IFDDataset;
begin
  lAnexoModel := TAnexoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lAnexoModel.objeto.obterLista;
      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.objeto.FieldByName('ID').AsString);
        memoResultado.Lines.Add('TABELA: '+lMemTable.objeto.FieldByName('TABELA').AsString);
        memoResultado.Lines.Add('REGISTRO_ID: '+lMemTable.objeto.FieldByName('REGISTRO_ID').AsString);
        memoResultado.Lines.Add('DOCUMENTO_ID: '+lMemTable.objeto.FieldByName('DOCUMENTO_ID').AsString);
        memoResultado.Lines.Add('DOCUMENTO_NOME: '+lMemTable.objeto.FieldByName('DOCUMENTO_NOME').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lAnexoModel:=nil;
  end;
end;

procedure TForm1.Button45Click(Sender: TObject);
var
  lAnexoModel : ITAnexoModel;
  ID          : String;
begin
  lAnexoModel := TAnexoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('ANEXO', 'Digite o ID que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lAnexoModel := lAnexoModel.objeto.Alterar(ID);
      lAnexoModel.objeto.REGISTRO_ID := '3';

      lAnexoModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lAnexoModel:=nil;
  end;
end;

procedure TForm1.Button46Click(Sender: TObject);
var
  lAnexoModel : ITAnexoModel;
  ID        : String;
begin
  lAnexoModel := TAnexoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('ANEXO', 'Digite o ID do Anexo que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lAnexoModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lAnexoModel:=nil;
  end;
end;

procedure TForm1.Button47Click(Sender: TObject);
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  lPedidoWeb             : String;
  lMemTable              : IFDDataset;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);
  try
    try
      lPedidoWeb := InputBox('ObterResumo','Digite o número do Web Pedido para consultar:','');
      if lPedidoWeb.IsEmpty then
      Exit;

      lMemTable := lFinanceiroPedidoModel.objeto.obterResumo(lPedidoWeb);
      memoResultado.Lines.Clear;
      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('WEB_PEDIDO_ID: '+lMemTable.objeto.FieldByName('WEB_PEDIDO_ID').AsString);
        memoResultado.Lines.Add('ID_FINANCEIRO: '+lMemTable.objeto.FieldByName('ID_FINANCEIRO').AsString);
        memoResultado.Lines.Add('CODIGO_PORT: '+lMemTable.objeto.FieldByName('CODIGO_PORT').AsString);
        memoResultado.Lines.Add('NOME_PORT: '+lMemTable.objeto.FieldByName('NOME_PORT').AsString);
        memoResultado.Lines.Add('QUANTIDADE_PARCELAS: '+lMemTable.objeto.FieldByName('QUANTIDADE_PARCELAS').AsString);
        memoResultado.Lines.Add('VALOR_PARCELAS: '+lMemTable.objeto.FieldByName('VALOR_PARCELA').AsString);
        memoResultado.Lines.Add('VALOR_TOTAL: '+lMemTable.objeto.FieldByName('VALOR_TOTAL').AsString);
        memoResultado.Lines.Add('VALOR_LIQUIDO: '+lMemTable.objeto.FieldByName('VALOR_LIQUIDO').AsString);
        memoResultado.Lines.Add('VENCIMENTO: '+lMemTable.objeto.FieldByName('VENCIMENTO').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel:=nil;
  end;
end;

procedure TForm1.Button48Click(Sender: TObject);
var
  lFluxoCaixaModel : ITFluxoCaixaModel;
  lMemTable        : IFDDataset;
begin
  lFluxoCaixaModel := TFluxoCaixaModel.getNewIface(vIConexao);
  try
    try
      lFluxoCaixaModel.objeto.DataInicialView := '01/01/2023';
      lFluxoCaixaModel.objeto.DataFinalView   := '12/12/2024';
      lFluxoCaixaModel.objeto.PortadorView    := '000001';
      lFluxoCaixaModel.objeto.OrderView       := 'RECEBER';
//      lFluxoCaixaModel.LojaView        := '001';

      lMemTable := lFluxoCaixaModel.objeto.obterFluxoCaixaSintetico;
      //Aki o dataset será zerado apos sair da função.
      //Precisa deixar este contexto ativo...                  a
      dsTmp := lMemTable;
      dsTeste2.DataSet := dsTmp.objeto;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button49Click(Sender: TObject);
var
  lFluxoCaixaModel : ITFluxoCaixaModel;
  lMemTable        : IFDDataset;
begin
  lFluxoCaixaModel := TFluxoCaixaModel.getNewIface(vIConexao);
  try
    try
      lFluxoCaixaModel.objeto.DataInicialView := '01/01/2023';
      lFluxoCaixaModel.objeto.DataFinalView   := '12/12/2024';
//      lFluxoCaixaModel.LojaView        := '001';

      //Para localizar um tipo especifico
      lFluxoCaixaModel.objeto.TipoView        := 'RECEBER';

      lMemTable := lFluxoCaixaModel.objeto.obterFluxoCaixaAnalitico;

      //Aki o dataset será zerado apos sair da função.
      //Precisa deixar este contexto ativo...                  a
      dsTmp := lMemTable;

      dsTeste2.DataSet := lMemTable.objeto;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  lWebPedidoModel : ITWebPedidoModel;
  i               : Integer;
  lMemTable       : IFDDataset;
  lPedidoWeb      : String;
begin
  lWebPedidoModel := TWebPedidoModel.getNewIface(vIConexao);
  try

    lPedidoWeb := InputBox('ObterResumo','Digite o número do Web Pedido para consultar:','');

    lWebPedidoModel.objeto.LengthPageView  := vQtdeRegistros.ToString;
    lWebPedidoModel.objeto.StartRecordView := vPagina.ToString;
    lWebPedidoModel.objeto.OrderView       := 'id';
    lWebPedidoModel.objeto.IDRecordView    := StrToInt(lPedidoWeb);

    lMemTable := lWebPedidoModel.objeto.obterLista;

    inc(vPagina, 10);

    memoResultado.Lines.Clear;

    lMemTable.objeto.First;
    while not lMemTable.objeto.eof do
    begin
      memoResultado.Lines.Add('ID: '+ lMemTable.objeto.FieldByName('ID').AsString);
      memoResultado.Lines.Add('CODIGO_CLI: '+ lMemTable.objeto.FieldByName('CODIGO_CLI').AsString);
      memoResultado.Lines.Add('CLIENTE_NOME: '+ lMemTable.objeto.FieldByName('CLIENTE_NOME').AsString);
      memoResultado.Lines.Add('ENTREGA_ENDERECO: '+ lMemTable.objeto.FieldByName('ENTREGA_ENDERECO').AsString);
      memoResultado.Lines.Add('ENTREGA_NUMERO: '+ lMemTable.objeto.FieldByName('ENTREGA_NUMERO').AsString);
      memoResultado.Lines.Add('ENTREGA_COD_MUNICIPIO: '+ lMemTable.objeto.FieldByName('ENTREGA_COD_MUNICIPIO').AsString);
      memoResultado.Lines.Add('ENTREGA_CEP: '+ lMemTable.objeto.FieldByName('ENTREGA_CEP').AsString);
      memoResultado.Lines.Add('ENTREGA_COMPLEMENTO: '+ lMemTable.objeto.FieldByName('ENTREGA_COMPLEMENTO').AsString);
      memoResultado.Lines.Add('ENTREGA_CIDADE: '+ lMemTable.objeto.FieldByName('ENTREGA_CIDADE').AsString);
      memoResultado.Lines.Add('ENTREGA_BAIRRO: '+ lMemTable.objeto.FieldByName('ENTREGA_BAIRRO').AsString);
      memoResultado.Lines.Add('ENTREGA_UF: '+ lMemTable.objeto.FieldByName('ENTREGA_UF').AsString);
      memoResultado.Lines.Add('MONTAGEM_DATA: '+ lMemTable.objeto.FieldByName('MONTAGEM_DATA').AsString);
      memoResultado.Lines.Add('MONTAGEM_HORA: '+ lMemTable.objeto.FieldByName('MONTAGEM_HORA').AsString);
      memoResultado.Lines.Add('ENTREGA_DATA: '+ lMemTable.objeto.FieldByName('ENTREGA_DATA').AsString);
      memoResultado.Lines.Add('ENTREGA_HORA: '+ lMemTable.objeto.FieldByName('ENTREGA_HORA').AsString);
      memoResultado.Lines.Add('REGIAO_ID: '+ lMemTable.objeto.FieldByName('REGIAO_ID').AsString);
      memoResultado.Lines.Add('REGIAO: '+ lMemTable.objeto.FieldByName('REGIAO').AsString);
      memoResultado.Lines.Add('DATAHORA: '+ lMemTable.objeto.FieldByName('DATAHORA').AsString);
      memoResultado.Lines.Add('VENDEDOR: '+ lMemTable.objeto.FieldByName('VENDEDOR').AsString);
      memoResultado.Lines.Add('STATUS: '+ lMemTable.objeto.FieldByName('STATUS').AsString);
      memoResultado.Lines.Add('VALOR_FRETE: '+ lMemTable.objeto.FieldByName('VALOR_FRETE').AsString);
      memoResultado.Lines.Add('ACRESCIMO: '+ lMemTable.objeto.FieldByName('ACRESCIMO').AsString);
      memoResultado.Lines.Add('VALOR_ITENS: '+ lMemTable.objeto.FieldByName('VALOR_ITENS').AsString);
      memoResultado.Lines.Add('VALOR_GARANTIA: '+ lMemTable.objeto.FieldByName('VALOR_GARANTIA').AsString);
      memoResultado.Lines.Add('VALOR_CUPOM_DESCONTO: '+ lMemTable.objeto.FieldByName('VALOR_CUPOM_DESCONTO').AsString);
      memoResultado.Lines.Add('VALOR_TOTAL: '+ lMemTable.objeto.FieldByName('VALOR_TOTAL').AsString);
      memoResultado.Lines.Add('===============================================');

      lMemTable.objeto.Next;
    end;

  finally
    lWebPedidoModel:=nil;
  end;

end;

procedure TForm1.Button50Click(Sender: TObject);
var
  lFluxoCaixaModel : ITFluxoCaixaModel;
  lMemTable        : IFDDataset;
begin
  lFluxoCaixaModel := TFluxoCaixaModel.getNewIface(vIConexao);
  try
    try
      lFluxoCaixaModel.objeto.DataInicialView := '27/02/2024';
      lFluxoCaixaModel.objeto.DataFinalView   := '29/02/2024';

      lMemTable := lFluxoCaixaModel.objeto.obterResumo;
      //Aki o dataset será zerado apos sair da função.
      //Precisa deixar este contexto ativo...                  a
      dsTmp := lMemTable;

      dsTeste2.DataSet := lMemTable.objeto;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button51Click(Sender: TObject);
var
  lFluxoCaixaModel : ITFluxoCaixaModel;
  lMemTable        : IFDDataset;
begin
  lFluxoCaixaModel := TFluxoCaixaModel.getNewIface(vIConexao);
  try
    try
      lFluxoCaixaModel.objeto.DataInicialView := '27/02/2024';
      lFluxoCaixaModel.objeto.DataFinalView   := '29/02/2024';
//      lFluxoCaixaModel.LojaView        := '001';

      lFluxoCaixaModel.objeto.PorcentagemInadimplenciaView := 10;
      lMemTable := lFluxoCaixaModel.objeto.obterResultadoFluxoCaixa;

      //Aki o dataset será zerado apos sair da função.
      //Precisa deixar este contexto ativo...                  a
      dsTmp := lMemTable;

      dsTeste2.DataSet := lMemTable.objeto;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button52Click(Sender: TObject);
var
  lBancoModel : ITBancoModel;
  lNomeBanco  : String;
begin
  lBancoModel := TBancoModel.getNewIface(vIConexao);
  try
    try
      lNomeBanco :=  InputBox('BANCO','Digite o Nome do Banco:','');

      if lNomeBanco.IsEmpty then
        Exit;

      lBancoModel.objeto.NOME_BAN    := lNomeBanco;
      lBancoModel.objeto.AGENCIA_BAN := '000123';
      lBancoModel.objeto.CONTA_BAN   := '321123';

      lBancoModel.objeto.Incluir;

      ShowMessage('Incluido com sucesso');
    except
       on E:Exception do
         ShowMessage('Erro: ' + E.Message);
      end;
  finally
  end;
end;

procedure TForm1.Button53Click(Sender: TObject);
var
  lBancoModel : ITBancoModel;
  lMemTable   : IFDDataset;
begin
  lBancoModel := TBancoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lBancoModel.objeto.obterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('NUMERO_BAN: '+lMemTable.objeto.FieldByName('NUMERO_BAN').AsString);
        memoResultado.Lines.Add('NOME_BAN: '+lMemTable.objeto.FieldByName('NOME_BAN').AsString);
        memoResultado.Lines.Add('AGENCIA_BAN: '+lMemTable.objeto.FieldByName('AGENCIA_BAN').AsString);
        memoResultado.Lines.Add('CONTA_BAN: '+lMemTable.objeto.FieldByName('CONTA_BAN').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button54Click(Sender: TObject);
var
  lBancoModel : ITBancoModel;
  ID          : String;
begin
  lBancoModel := TBancoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('BANCO', 'Digite o ID do Banco que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lBancoModel := lBancoModel.objeto.Alterar(ID);
      lBancoModel.objeto.NOME_BAN := 'TESTE ALTERAR';

      lBancoModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button55Click(Sender: TObject);
var
  lBancoModel : ITBancoModel;
  ID        : String;
begin
  lBancoModel := TBancoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('BANCO', 'Digite o ID do Banco que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lBancoModel.objeto.Exlcuir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button56Click(Sender: TObject);
var
  lEntradaModel      : ITEntradaModel;
  lEntradaItensModel : ITEntradaItensModel;
  lEntrada           : TEntradaResultado;
  lTableEntrada,
  lTableItens        : IFDDataset;
begin
  lEntradaModel      := TEntradaModel.getNewIface(vIConexao);
  lEntradaItensModel := TEntradaItensModel.getNewIface(vIConexao);

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
        lEntradaModel.objeto.PathXML := OpenDialog.FileName;
        lEntrada := lEntradaModel.objeto.importaXML;

        if lEntrada.NUMERO_ENT <> '' then
        begin
          lEntradaModel.objeto.NumeroView := lEntrada.NUMERO_ENT;
          lTableEntrada            := lEntradaModel.objeto.obterLista;
          dsTmp := lTableEntrada;

          dsEntrada.DataSet        := dsTmp.objeto;

          lEntradaItensModel.objeto.NumeroView := lEntrada.NUMERO_ENT;
          lTableItens                  := lEntradaItensModel.objeto.obterLista;
          dsTmp2 := lTableItens;
          dsEntradaItens.DataSet       := lTableitens.objeto;
        end;
      end;
    except
      on E:Exception do
        ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel:=nil;
    lEntradaItensModel:=nil;
  end;
end;

procedure TForm1.Button57Click(Sender: TObject);
var
  lPortadorModel : ITPortadorModel;
  lMemTable      : IFDDataset;
begin
  lPortadorModel := TPortadorModel.getNewIface(vIConexao);
  try
    try

      lMemTable := lPortadorModel.objeto.PortadorTabelaJuros;
      memoResultado.Lines.Clear;
      lMemTable.objeto.First;

      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('CODIGO_PORTADOR: '+lMemTable.objeto.FieldByName('CODIGO_PORTADOR').AsString);
        memoResultado.Lines.Add('PORTADOR: '+lMemTable.objeto.FieldByName('PORTADOR').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button58Click(Sender: TObject);
var
  lEntradaModel      : ITEntradaModel;
  lEntradaItensModel : ITEntradaItensModel;
  lEntrada           : String;
  lTableEntrada,
  lTableItens        : IFDDataset;
begin
  lEntradaModel      := TEntradaModel.getNewIface(vIConexao);
  lEntradaItensModel := TEntradaItensModel.getNewIface(vIConexao);
  try

    lEntrada := InputBox('Constultar Entrada','Digite o número da Entrada:','');
     if lEntrada.IsEmpty then
     Exit;

    lEntradaModel.objeto.NumeroView := lEntrada;
    lTableEntrada            := lEntradaModel.objeto.obterLista;
    dsTmp := lTableEntrada;
    dsEntrada.DataSet        := lTableEntrada.objeto;

    lEntradaItensModel.objeto.NumeroView := lEntrada;
    lTableItens                  := lEntradaItensModel.objeto.obterLista;
    dsEntradaItens.DataSet       := lTableitens.objeto;


  finally
    lEntradaModel:=nil;
    lEntradaItensModel:=nil;
  end;
end;


procedure TForm1.Button59Click(Sender: TObject);
var
  lEntradaModel      : ITEntradaModel;
  lEntradaItensModel : ITEntradaItensModel;

begin
  lEntradaModel      := TEntradaModel.getNewIface(vIConexao);
  lEntradaItensModel := TEntradaItensModel.getNewIface(vIConexao);
  try
    try
      lEntradaModel.objeto.NUMERO_ENT    := '55555555';
      lEntradaModel.objeto.CODIGO_FOR    := '500005';
      lEntradaModel.objeto.SERIE_ENT     := '001';
      lEntradaModel.objeto.PARCELAS_ENT  := '3';
      lEntradaModel.objeto.CONDICOES_PAG := '30';
      lEntradaModel.objeto.TOTAL_ENT     := '500';
      lEntradaModel.objeto.DATANOTA_ENT  := DateToStr(vIConexao.DataServer);

      lEntradaModel.objeto.Incluir;

      ShowMessage('Cabeçalho Entrada Cadastrado');
      except
       on E:Exception do
         ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel:=nil;
    lEntradaItensModel:=nil;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  lWebPedidoModel : ITWebPedidoModel;
begin
  lWebPedidoModel := TWebPedidoModel.getNewIface(vIConexao);
  try
    try

      lWebPedidoModel.objeto.CLIENTE_ID          := '000000';
      lWebPedidoModel.objeto.VENDEDOR_ID         := '000001';
      lWebPedidoModel.objeto.TIPOVENDA_ID        := '000004';
      lWebPedidoModel.objeto.PORTADOR_ID         := '000001';

      lWebPedidoModel.objeto.Incluir;
      ShowMessage('Inserido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoModel:=nil;
  end;
end;

procedure TForm1.Button60Click(Sender: TObject);
var
  lEntradaItensParams : TEntradaItensParams;
  lEntradaModel       : ITEntradaModel;
  lNumEntrada         : String;
begin
  lEntradaModel  := TEntradaModel.getNewIface(vIConexao);
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

      lEntradaModel.objeto.EntradaItens(lEntradaItensParams);
      ShowMessage('Item adicionado a Entrada: ' + lNumEntrada);

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.Button61Click(Sender: TObject);
var
  lEntradaModel : ITEntradaModel;

begin
  lEntradaModel := TEntradaModel.getNewIface(vIConexao);
  try
    try
      lEntradaModel.objeto.NumeroView     := '0001018217';
      lEntradaModel.objeto.FornecedorView := '500009';

      dsEntrada.DataSet := lEntradaModel.objeto.obterTotalizador.objeto;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.Button62Click(Sender: TObject);
var
  lContasPagarModel : ITContasPagarModel;
  pEntrada,
  pFornecedor : String;
begin
  lContasPagarModel := TContasPagarModel.getNewIface(vIConexao);
  try
    try
      pEntrada    := '0001044283';
      pFornecedor := '000184';

      dsEntrada.DataSet := lContasPagarModel.objeto.obterValorEntrada(pEntrada, pFornecedor).objeto;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button63Click(Sender: TObject);
var
  lOsModel : ITOSModel;
begin
  lOsModel := TOSModel.getNewIface(vIConexao);

  try
    lOsModel.objeto.CODIGO_CLI := '000001';
    lOsModel.objeto.TOTAL_OS   := '1000';
    lOsModel.objeto.Incluir;

    ShowMessage('Inserido com Sucesso');

  finally
    lOsModel:=nil;
  end;
end;

procedure TForm1.Button64Click(Sender: TObject);
var
  lOsModel  : ITOSModel;
begin

  lOsModel := TOSModel.getNewIface(vIConexao);

  try
    dsTmp := lOSModel.objeto.obterLista;
    dsOS.DataSet := dsTmp.objeto;
  finally
    lOsModel:=nil;
  end;

end;

procedure TForm1.Button65Click(Sender: TObject);
var
  lOsModel : ITOSModel;
begin
  lOsModel := TOSModel.getNewIface(vIConexao);

  try
    lOsModel := lOsModel.objeto.Alterar('000045');
    lOsModel.objeto.TOTAL_OS   := '500';
    lOsModel.objeto.Salvar;

    ShowMessage('Alterado com Sucesso');

  finally
    lOsModel:=nil;
  end;
end;

procedure TForm1.Button66Click(Sender: TObject);
var
  lOsModel :ITOSModel;
begin
  lOsModel := TOSModel.getNewIface(vIConexao);

  try
    try
      lOsModel.objeto.Excluir('000045');
      ShowMessage('Excluido com Sucesso');

    except
      on E:Exception do
        ShowMessage('Erro ao excluir: '+ E.Message);
    end;
  finally
    lOsModel:=nil;
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
  lGrupoModel : ITGrupoModel;
  lNomeGrupo  : String;
begin
  lGrupoModel := TGrupoModel.getNewIface(vIConexao);
  try
    try
      lNomeGrupo :=  InputBox('GRUPOPRODUTO','Digite o Nome do Grupo:','');

      if lNomeGrupo.IsEmpty then
        Exit;

      lGrupoModel.objeto.NOME_GRU    := lNomeGrupo;
      lGrupoModel.objeto.USUARIO_GRU := '000001';

      lGrupoModel.objeto.Incluir;

      ShowMessage('Incluido com sucesso');
    except
       on E:Exception do
         ShowMessage('Erro: ' + E.Message);
      end;
  finally
    lGrupoModel:=nil;
  end;
end;
procedure TForm1.Button69Click(Sender: TObject);
var
  lGrupoModel : ITGrupoModel;
  lMemTable   : IFDDataset;
begin
  lGrupoModel := TGrupoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lGrupoModel.objeto.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('CODIGO_GRU: '+lMemTable.objeto.FieldByName('CODIGO_GRU').AsString);
        memoResultado.Lines.Add('NOME_GRU: '+lMemTable.objeto.FieldByName('NOME_GRU').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lGrupoModel:=nil;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  lWebPedidoModel : ITWebPedidoModel;
  lID             : String;
begin
  lWebPedidoModel := TWebPedidoModel.getNewIface(vIConexao);
  try
    try
      lID := InputBox('WebPedido', 'Digite o ID do WebPedido:', '');

      if lID.IsEmpty then
        exit;

      lWebPedidoModel := lWebPedidoModel.objeto.Alterar(lID);
      lWebPedidoModel.objeto.CLIENTE_ID := '000001';
      lWebPedidoModel.objeto.Salvar;

      ShowMessage('Alterado com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoModel:=nil;
  end;
end;

procedure TForm1.Button70Click(Sender: TObject);
var
  lGrupoModel : ITGrupoModel;
  ID          : String;
begin
  lGrupoModel := TGrupoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('GRUPOPRODUTO', 'Digite o ID do GRUPO que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lGrupoModel := lGrupoModel.objeto.Alterar(ID);
      lGrupoModel.objeto.NOME_GRU := 'TESTE ALTERAR';

      lGrupoModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lGrupoModel:=nil;
  end;
end;
procedure TForm1.Button71Click(Sender: TObject);
var
  lGrupoModel : ITGrupoModel;
  ID        : String;
begin
  lGrupoModel := TGrupoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('GRUPOPRODUTO', 'Digite o ID do GRUPO que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lGrupoModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lGrupoModel:=nil;
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
  lContasPagarModel : ITContasPagarModel;
begin
  lContasPagarModel := TContasPagarModel.getNewIface(vIConexao);

  try
    try

      lContasPagarModel.objeto.DUPLICATA_PAG  := '9000002024'; //Numero NFe
      lContasPagarModel.objeto.CODIGO_FOR     := '500005'; //Fornecedor NFe
      lContasPagarModel.objeto.PORTADOR_ID    := '000001';
      lContasPagarModel.objeto.DATAEMI_PAG    := '27.02.2024'; //Data do MOvimento
      lContasPagarModel.objeto.VALOR_PAG      := '1000'; //Total da nota
      lContasPagarModel.objeto.CONDICOES_PAG  := '30/60/90';
      lContasPagarModel.objeto.USUARIO_PAG    := '000001';
      lContasPagarModel.objeto.OBS_PAG        := 'NUMERO DA NOTA E NOME DO FORNECEDOR';
      lContasPagarModel.objeto.CODIGO_CTA     := '444444';
      lContasPagarModel.objeto.LOJA           := '001';

      lContasPagarModel.objeto.GerarFinanceiroEntrada;

      ShowMessage('Inserido com Sucesso');
    Except
      on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lContasPagarModel:=nil;
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
 lCEPModel : ITCEPModel;
 Retorno : TRetornoCEP;
begin

  lCEPModel := TCEPModel.getNewIface(vConfiguracoes);

//lCEPModel.API := tApiViaCep;  Recebe o valor do ViaCep

  Retorno := lCEPModel.objeto.consultarCEP('86185420');

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
  lPedidoCompra : ITPedidoCompraModel;
begin
  lPedidoCompra := TPedidoCompraModel.getNewIface(vIConexao);
  try
    try

      lPedidoCompra.objeto.DATA_PED := DateToStr(vIConexao.DataServer);
      lPedidoCompra.objeto.DATAPREV_PED := DateToStr(vIConexao.DataServer);
      lPedidoCompra.objeto.CODIGO_FOR := '000059';
      lPedidoCompra.objeto.PARCELAS_PED := 1;
      lPedidoCompra.objeto.PRIMEIROVENC_PED := DateToStr(vIConexao.DataServer);
      lPedidoCompra.objeto.TOTAL_PED := '1000';
      lPedidoCompra.objeto.USUARIO_PED := '000001';
      lPedidoCompra.objeto.STATUS_PED := 'A';
      lPedidoCompra.objeto.TOTALPRODUTOS_PED := '1000';
      lPedidoCompra.objeto.TIPO_PRO := 'N';

      lPedidoCompra.objeto.Incluir;
      ShowMessage('Inserido com Sucesso');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPedidoCompra:=nil;
  end;
end;

procedure TForm1.Button77Click(Sender: TObject);
var
  lPedidoCompraModel : ITPedidoCompraModel;
  lPedidoItensModel  : ITPedidoCompraItensModel;
  TablePedItens      : IFDDataset;
  lNumeroView,
  lFornecedorView    : String;
begin
  lPedidoCompraModel := TPedidoCompraModel.getNewIface(vIConexao);
  lPedidoItensModel  := TPedidoCompraItensModel.getNewIface(vIConexao);
  try
    try
      lNumeroView     := '000008';
      lFornecedorView := '000000';

      lPedidoCompraModel.objeto.NumeroView    := lNumeroView;
      dsTmp                := lPedidoCompraModel.objeto.obterLista;
      dsPedidoCompra.DataSet           := dsTmp.objeto;

      lPedidoItensModel.objeto.NumeroView     := lNumeroView;
      lPedidoItensModel.objeto.FornecedorView := lFornecedorView;
      TablePedItens                    := lPedidoItensModel.objeto.obterLista;
      dsPedidoCompraItens.DataSet      := TablePedItens.objeto;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPedidoCompraModel:=nil;
    lPedidoItensModel:=nil;
  end;
end;

procedure TForm1.Button78Click(Sender: TObject);
var
  lPedidoCompraModel : ITPedidoCompraModel;
  lPedidoItensModel  : ITPedidoCompraItensModel;
  lPedidoParams      : TPedidoItensParams;
begin
  lPedidoCompraModel := TPedidoCompraModel.getNewIface(vIConexao);
  lPedidoItensModel  := TPedidoCompraItensModel.getNewIface(vIConexao);
  try
    try
      lPedidoParams.NUMERO_PED     := '000017';
      lPedidoParams.CODIGO_FOR     := '000059';
      lPedidoParams.CODIGO_PRO     := '000980';
      lPedidoParams.QUANTIDADE_PED := '5';
      lPedidoParams.VALORUNI_PED   := '100';

      lPedidoCompraModel.objeto.AdicionarItens(lPedidoParams);
      ShowMessage('Item adicionado ao Pedido: ' +lPedidoParams.NUMERO_PED)
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPedidoCompraModel:=nil;
    lPedidoItensModel:=nil;
  end;
end;

procedure TForm1.Button79Click(Sender: TObject);
var
  lEntradaModel: ITEntradaModel;
  lNomePDF: String;
  lIDEntrada, lCodigoFornecedor, lPathPDF: String;
  lImprimir, lMostraPreview, lGerarPDF: Boolean;
begin
  lEntradaModel   := TEntradaModel.getNewIface(vIConexao);

  try
    lIDEntrada         := '0000015340';
    lCodigoFornecedor  := '500017';
    lImprimir          := false;
    lMostraPreview     := false;
    lGerarPDF          := True;
    lPathPDF           := 'c:\temp';

    try
     lNomePDF := lEntradaModel.objeto.VisualizarXML(lIDEntrada,lCodigoFornecedor,lImprimir,lMostraPreview,lGerarPDF,lPathPDF)+'-nfe.pdf';
    except on E: Exception do
      begin
        ShowMessage('Erro: '+e.Message);
        Exit;
      end;
    end;

  finally
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  lWebPedidoModel : ITWebPedidoModel;
  PedidoWeb       : String;
begin
  lWebPedidoModel := TWebPedidoModel.getNewIface(vIConexao);
  try
    try
      PedidoWeb := InputBox('WebPedido', 'Digite o ID do Item que deseja excluir:', '');

      lWebPedidoModel.objeto.Excluir(PedidoWeb);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoModel:=nil;
  end;
end;

procedure TForm1.Button80Click(Sender: TObject);
var
  lEntradaModel: ITEntradaModel;
  lNomeXML: String;
  lPathXML, lIDEntrada, lCodigoFornecedor: String;
begin
  lEntradaModel   := TEntradaModel.getNewIface(vIConexao);

  try
    lIDEntrada         := '0000015340';
    lCodigoFornecedor  := '500017';
    lPathXML := 'c:\temp\';

    try
      lNomeXML := lEntradaModel.objeto.SalvarXML(lIDEntrada, lCodigoFornecedor,lPathXML);
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
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.Button81Click(Sender: TObject);
var
  lClientesContatoModel : ITClientesContatoModel;
  lMemTable   : IFDDataset;
begin
  lClientesContatoModel := TClientesContatoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lClientesContatoModel.objeto.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.objeto.FieldByName('ID').AsString);
        memoResultado.Lines.Add('CLIENTE_ID: '+lMemTable.objeto.FieldByName('CLIENTE_ID').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClientesContatoModel:=nil;
  end;
end;

procedure TForm1.Button82Click(Sender: TObject);
var
  lClientesContatoModel : ITClientesContatoModel;
  ID          : String;
begin
  lClientesContatoModel := TClientesContatoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('CLIENTES_CONTATO', 'Digite o ID do Contato que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lClientesContatoModel := lClientesContatoModel.objeto.Alterar(ID);
      lClientesContatoModel.objeto.Contato := 'TESTE ALTERAR';

      lClientesContatoModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lClientesContatoModel:=nil;
  end;
end;

procedure TForm1.Button83Click(Sender: TObject);
var
  lClientesContatoModel : ITClientesContatoModel;
  ID        : String;
begin
  lClientesContatoModel := TClientesContatoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('CLIENTES_CONTATO', 'Digite o ID do Contato que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lClientesContatoModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lClientesContatoModel:=nil;
  end;
end;

procedure TForm1.Button84Click(Sender: TObject);
var
  lClientesContatoModel : ITClientesContatoModel;
begin
  lClientesContatoModel := TClientesContatoModel.getNewIface(vIConexao);
  try
    try
      lClientesContatoModel.objeto.ID          := 10;
      lClientesContatoModel.objeto.CLIENTE_ID  := '000001';
      lClientesContatoModel.objeto.CONTATO     := 'TESTE TERASOFT';

      lClientesContatoModel.objeto.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lClientesContatoModel:=nil;
  end;
end;

procedure TForm1.Button85Click(Sender: TObject);
var
  lDescontoModel : ITDescontoModel;
  lMemTable   : IFDDataset;
begin
  lDescontoModel := TDescontoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lDescontoModel.objeto.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('ID: '+lMemTable.objeto.FieldByName('ID').AsString);
        memoResultado.Lines.Add('CLIENTE_ID: '+lMemTable.objeto.FieldByName('USUARIO_DES').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDescontoModel:=nil;
  end;
end;

procedure TForm1.Button86Click(Sender: TObject);
var
  lProdutoModel : ITProdutosModel;
  lValoresGarantia: TProdutoGarantia;
begin
  lProdutoModel := TProdutosModel.getNewIface(vIConexao);

  try
    try
      lValoresGarantia := lProdutoModel.objeto.ValorGarantia('000014',10);

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
  end;
end;

procedure TForm1.Button87Click(Sender: TObject);
var
  lPermissaoRemotaModel : ITPermissaoRemotaModel;
begin
  lPermissaoRemotaModel := TPermissaoRemotaModel.getNewIface(vIConexao);
  try
    lPermissaoRemotaModel.objeto.Negar('789');
  finally
    lPermissaoRemotaModel:=nil;
  end;
end;

procedure TForm1.Button88Click(Sender: TObject);
var
  lMovimentoSerial : ITMovimentoSerialModel;
begin
  lMovimentoSerial := TMovimentoSerialModel.getNewIface(vIConexao);
  try
    try
      lMovimentoSerial.objeto.Acao := tacIncluir;

      lMovimentoSerial.objeto.DH_MOVIMENTO   :=  FormatDateTime('dd.mm.yyyy', vIConexao.DataHoraServer) + ' ' + TimeToStr(vIConexao.HoraServer);
		  lMovimentoSerial.objeto.LOGISTICA      := 'FEDEX';
      lMovimentoSerial.objeto.TIPO_SERIAL    := 'I';
      lMovimentoSerial.objeto.NUMERO         := '123456789789789';
      lMovimentoSerial.objeto.PRODUTO        := '000001';
      lMovimentoSerial.objeto.TIPO_DOCUMENTO := 'P';
      lMovimentoSerial.objeto.ID_DOCUMENTO   := '000001';
      lMovimentoSerial.objeto.SUB_ID         := '000001';
      lMovimentoSerial.objeto.TIPO_MOVIMENTO := 'E';

      lMovimentoSerial.objeto.Salvar;
      ShowMessage('Inserido com Sucesso');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lMovimentoSerial:=nil;
  end;
end;

procedure TForm1.btnPermissaoClick(Sender: TObject);
var
  lDescontoModel : ITDescontoModel;
  ID        : String;
begin
  lDescontoModel := TDescontoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('DESCONTO', 'Digite o ID do Contato que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lDescontoModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lDescontoModel:=nil;
  end;
end;

procedure TForm1.btnPermissaoRemotaClick(Sender: TObject);
var
  lPermissaoRemotaModel : ITPermissaoRemotaModel;
begin
  lPermissaoRemotaModel := TPermissaoRemotaModel.getNewIface(vIConexao);
  try
    lPermissaoRemotaModel.objeto.Autorizar('789');
  finally
    lPermissaoRemotaModel:=nil;
  end;
end;

procedure TForm1.btnDescontoAutorizarClick(Sender: TObject);
var
  lSolicitacaoDescontoModel : ITSolicitacaoDescontoModel;
begin
  lSolicitacaoDescontoModel := TSolicitacaoDescontoModel.getNewIface(vIConexao);

  try
    lSolicitacaoDescontoModel.objeto.Autorizar('4176');
  finally
    lSolicitacaoDescontoModel:=nil;
  end;
end;

procedure TForm1.btnDescontoClick(Sender: TObject);
var
  lDescontoModel : ITDescontoModel;
begin
  lDescontoModel := TDescontoModel.getNewIface(vIConexao);
  try
    try
      lDescontoModel.objeto.USUARIO_DES   := '000002';
      lDescontoModel.objeto.TIPOVENDA_DES := '000004';
      lDescontoModel.objeto.VALOR_DES     := 99;

      lDescontoModel.objeto.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lDescontoModel:=nil;
  end;
end;

procedure TForm1.btnDescontoNegarClick(Sender: TObject);
var
  lSolicitacaoDescontoModel : ITSolicitacaoDescontoModel;
begin
  lSolicitacaoDescontoModel := TSolicitacaoDescontoModel.getNewIface(vIConexao);

  try
    lSolicitacaoDescontoModel.objeto.Negar('4176');
  finally
    lSolicitacaoDescontoModel:=nil;
  end;
end;

procedure TForm1.Button89Click(Sender: TObject);
var
  lTransportadoraModel : ITTransportadoraModel;
  lMemTable   : IFDDataset;
begin
  lTransportadoraModel := TTransportadoraModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lTransportadoraModel.objeto.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('CODIGO: '+lMemTable.objeto.FieldByName('CODIGO_TRA').AsString);
        memoResultado.Lines.Add('NOME: '+lMemTable.objeto.FieldByName('FANTASIA_TRA').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lTransportadoraModel:=nil;
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  lWebPedidoModel : ITWebPedidoModel;
  lVenderItemParametros: TVenderItemParametros;
  lWebPedido : String;
begin
  lWebPedidoModel := TWebPedidoModel.getNewIface(vIConexao);
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

      lWebPedidoModel.objeto.VenderItem(lVenderItemParametros);
      ShowMessage('Item adicionado ao WebPedido: ' +lWebPedido);
    except
    on E:Exception do
       ShowMessage('Erro vender item: ' + E.Message);
    end;
  finally
    lWebPedidoModel:=nil;
  end;
end;

procedure TForm1.Button90Click(Sender: TObject);
var
  lProdutosModel : ITProdutosModel;
begin
  lProdutosModel := TProdutosModel.getNewIface(vIConexao);
  try
    dsProdutos.DataSet := lProdutosModel.objeto.obterPromocao('000444').objeto;
  finally
  end;
end;

procedure TForm1.Button91Click(Sender: TObject);
var
  lProduto : ITProdutosModel;
begin
  lProduto := TProdutosModel.getNewIface(vIConexao);
  try
    lProduto.objeto.IDRecordView := '000005';
    dsProdutos.DataSet    := lProduto.objeto.ObterTabelaPreco.objeto;
  finally
  end;
end;

procedure TForm1.Button92Click(Sender: TObject);
var
  lTransportadoraModel : ITTransportadoraModel;
  ID : String;
begin
  lTransportadoraModel := TTransportadoraModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('TRANSPORTADORA', 'Digite o código da transportadora que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lTransportadoraModel := lTransportadoraModel.objeto.Alterar(ID);
      lTransportadoraModel.objeto.FANTASIA_TRA := 'TESTE ALTERAÇÃO';

      lTransportadoraModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lTransportadoraModel:=nil;
  end;
end;

procedure TForm1.Button93Click(Sender: TObject);
var
  lTransportadoraModel : ITTransportadoraModel;
  codigo        : String;
begin
  lTransportadoraModel := TTransportadoraModel.getNewIface(vIConexao);
  try
    try
      codigo := InputBox('TRANSPORTADORA', 'Digite o código da transportadora que deseja excluir:', '');
      if codigo.IsEmpty then
          Exit;

      lTransportadoraModel.objeto.Excluir(codigo);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lTransportadoraModel:=nil;
  end;
end;

procedure TForm1.Button94Click(Sender: TObject);
var
  lTransportadoraModel : ITTransportadoraModel;
begin
  lTransportadoraModel := TTransportadoraModel.getNewIface(vIConexao);
  try
    try
      lTransportadoraModel.objeto.FANTASIA_TRA := 'FANTASIA TRANSPORTADORA TESTE';
      lTransportadoraModel.objeto.RAZAO_TRA    := 'RAZÃO TRANSPORTADORA TESTE';
      lTransportadoraModel.objeto.STATUS       := 'A';

      lTransportadoraModel.objeto.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lTransportadoraModel:=nil;
  end;
end;

procedure TForm1.Button95Click(Sender: TObject);
var
  lPedidoCompra : ITPedidoCompraModel;
begin
  lPedidoCompra := TPedidoCompraModel.getNewIface(vIConexao);
  try
  lPedidoCompra.objeto.NumeroView     := '000008';
  lPedidoCompra.objeto.FornecedorView := '000000';
  dsTmp             := lPedidoCompra.objeto.ObterTotalizador;
  dsPedidoCompra.DataSet   := dsTmp.objeto;
  finally
    lPedidoCompra:=nil;
  end;
end;

procedure TForm1.Button96Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : ITPrevisaoPedidoCompraModel;
  lMemTable   : IFDDataset;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lPrevisaoPedidoCompraModel.objeto.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('PEDIDO: '+lMemTable.objeto.FieldByName('NUMERO_PED').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.objeto.FieldByName('CODIGO_FOR').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPrevisaoPedidoCompraModel:=nil;
  end;
end;

procedure TForm1.Button97Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : ITPrevisaoPedidoCompraModel;
  ID : String;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('PrevisaoPedidoCompra', 'Digite o código do PrevisaoPedidoCompra que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lPrevisaoPedidoCompraModel := lPrevisaoPedidoCompraModel.objeto.Alterar(ID);
      lPrevisaoPedidoCompraModel.objeto.VALOR_PARCELA := 888;

      lPrevisaoPedidoCompraModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lPrevisaoPedidoCompraModel:=nil;
  end;
end;

procedure TForm1.Button98Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : ITPrevisaoPedidoCompraModel;
  Numero_Ped, Codigo_For : String;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.getNewIface(vIConexao);
  try
    try
      Numero_Ped := InputBox('PrevisaoPedidoCompra', 'Digite o Numero Pedido da PrevisaoPedidoCompra que deseja excluir:', '');
      if Numero_Ped.IsEmpty then
          Exit;

      Codigo_For := InputBox('PrevisaoPedidoCompra', 'Digite o Código Fornecedor da PrevisaoPedidoCompra que deseja excluir:', '');
      if Codigo_For.IsEmpty then
          Exit;

      lPrevisaoPedidoCompraModel.objeto.Excluir(Numero_Ped, Codigo_For);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lPrevisaoPedidoCompraModel:=nil;
  end;
end;

procedure TForm1.Button99Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : ITPrevisaoPedidoCompraModel;
begin
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.getNewIface(vIConexao);
  try
    try
      lPrevisaoPedidoCompraModel.objeto.VALOR_PARCELA := 999;
      lPrevisaoPedidoCompraModel.objeto.NUMERO_PED    := '000013';
      lPrevisaoPedidoCompraModel.objeto.CODIGO_FOR    := '000137';

      lPrevisaoPedidoCompraModel.objeto.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lPrevisaoPedidoCompraModel:=nil;
  end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  lWebPedidoItensModel  : ITWebPedidoItensModel;
  lWebPedidoItens       : String;
  i                     : Integer;
begin
  lWebPedidoItensModel  := TWebPedidoItensModel.getNewIface(vIConexao);
  try
    try
      lWebPedidoItens := InputBox('WebPedido', 'Digite o número do Web Pedido para consultar os itens:', '');
      if lWebPedidoItens.IsEmpty then
        exit;


      lWebPedidoItensModel.objeto.IDWebPedidoView := StrToInt(lWebPedidoItens);
      lWebPedidoItensModel.objeto.obterLista;

      memoResultado.Lines.Clear;
      for i := 0 to lWebPedidoItensModel.objeto.WebPedidoItenssLista.Count -1 do
      begin
          memoResultado.Lines.Add('ID: ' +lWebPedidoItensModel.objeto.WebPedidoItenssLista[i].objeto.ID);
          memoResultado.Lines.Add('QUANTIDADE: ' +lWebPedidoItensModel.objeto.WebPedidoItenssLista[i].objeto.QUANTIDADE);
          memoResultado.Lines.Add('PRODUTO_ID: ' +lWebPedidoItensModel.objeto.WebPedidoItenssLista[i].objeto.PRODUTO_ID);
          memoResultado.Lines.Add('PRODUTO_NOME: ' +lWebPedidoItensModel.objeto.WebPedidoItenssLista[i].objeto.PRODUTO_NOME);
          memoResultado.Lines.Add('VALOR_UNITARIO: ' +lWebPedidoItensModel.objeto.WebPedidoItenssLista[i].objeto.VALOR_UNITARIO);
          memoResultado.Lines.Add('TIPO_GARANTIA: ' +lWebPedidoItensModel.objeto.WebPedidoItenssLista[i].objeto.TIPO_GARANTIA);
          memoResultado.Lines.Add('TIPO: ' +lWebPedidoItensModel.objeto.WebPedidoItenssLista[i].objeto.TIPO);
          memoResultado.Lines.Add('===============================================');
      end;
      ShowMessage('Consultou itens');
    except
    on E:Exception do
       ShowMessage('Erro consultar itens' + E.Message);
    end;
  finally
    lWebPedidoItensModel:=nil;
  end;
end;

procedure TForm1.btnSaldoClick(Sender: TObject);
var
  lSaldoModel : ITSaldoModel;
  lMemTable   : IFDDataset;
  lProduto    : String;
  lParametros : TParametrosSaldo;

begin
  lSaldoModel := TSaldoModel.getNewIface(vIConexao);
  try
    lProduto  := InputBox('Consulta de Saldo', 'Digite o código do produto:', '');

    lParametros.PRODUTO := lProduto;
    lParametros.CD      := true;

    lMemTable := lSaldoModel.objeto.obterSaldoLojas(lParametros);

    memoResultado.Lines.Clear;

    lMemTable.objeto.First;
    while not lMemTable.objeto.Eof do
    begin
      memoResultado.Lines.Add('LOJA: '+lMemTable.objeto.FieldByName('LOJA').AsString);
      memoResultado.Lines.Add('SALDO_FISICO: '+lMemTable.objeto.FieldByName('SALDO_FISICO').AsString);
      memoResultado.Lines.Add('SALDO_DISPONIVEL: '+lMemTable.objeto.FieldByName('SALDO_DISPONIVEL').AsString);
      memoResultado.Lines.Add('===============================================');
      lMemTable.objeto.Next;
    end;

  finally
  end;
end;

procedure TForm1.btnTabelaPrecoClick(Sender: TObject);
var
  lTabelaJurosModel: ITTabelaJurosModel;
  lPortador : String;
  lMemTable : IFDDataset;
begin
  lTabelaJurosModel := TTabelaJurosModel.getNewIface(vIConexao);
  try
    lPortador := InputBox('WebPedido', 'Digite o ID do portador:', '');
    lMemTable := lTabelaJurosModel.objeto.obterLista(lPortador, 1000, true, vIConexao.DataServer);

    lMemTable.objeto.first;
    while not lMemTable.objeto.eof do
    begin
      memoResultado.Lines.Add('ID: '+lMemTable.objeto.FieldByName('ID').AsString);
      memoResultado.Lines.Add('PARCELA: '+lMemTable.objeto.FieldByName('CODIGO').AsString);
      memoResultado.Lines.Add('PERCENTUAL: '+lMemTable.objeto.FieldByName('PERCENTUAL').AsString);
      memoResultado.Lines.Add('JUROS: '+lMemTable.objeto.FieldByName('JUROS_TEXTO').AsString);
      memoResultado.Lines.Add('VALOR_JUROS: '+lMemTable.objeto.FieldByName('VALOR_JUROS').AsString);
      memoResultado.Lines.Add('VALOR_PARCELA: '+lMemTable.objeto.FieldByName('VALOR_PARCELA').AsString);
      memoResultado.Lines.Add('VALOR_TOTAL: '+lMemTable.objeto.FieldByName('VALOR_TOTAL').AsString);
      memoResultado.Lines.Add('===============================================');
      memoResultado.Lines.Add('VALOR_SEG_PRESTAMISTA: '+lMemTable.objeto.FieldByName('VALOR_SEG_PRESTAMISTA').AsString);
      memoResultado.Lines.Add('PER_SEG_PRESTAMSTA: '+lMemTable.objeto.FieldByName('PER_SEG_PRESTAMSTA').AsString);
      memoResultado.Lines.Add('VALOR_ACRESCIMO_SEG_PRESTAMISTA: '+lMemTable.objeto.FieldByName('VALOR_ACRESCIMO_SEG_PRESTAMISTA').AsString);
      memoResultado.Lines.Add('===============================================');
      memoResultado.Lines.Add('');

      lMemTable.objeto.Next;
    end;

  finally
  end;
end;

procedure TForm1.btnTotaisClick(Sender: TObject);
var
  lWebPedidoModel : ITWebPedidoModel;
  lID : String;
begin
  lWebPedidoModel := TWebPedidoModel.getNewIface(vIConexao);
  try
    lID := InputBox('WebPedido', 'Digite o ID do Web Pedido:', '');
    if lID.IsEmpty then
      Exit;

    lWebPedidoModel.objeto.ID := lID;
    lWebPedidoModel.objeto.obterTotais;

    memoResultado.Lines.Add('VALOR_ACRESCIMO: '+lWebPedidoModel.objeto.ACRESCIMO);
    memoResultado.Lines.Add('VALOR_FRETE: '+lWebPedidoModel.objeto.VALOR_FRETE);
    memoResultado.Lines.Add('VALOR_DESCONTO: '+lWebPedidoModel.objeto.VALOR_CUPOM_DESCONTO);
    memoResultado.Lines.Add('VALOR_ITENS: '+lWebPedidoModel.objeto.VALOR_ITENS);
    memoResultado.Lines.Add('VALOR_TOTAL: '+lWebPedidoModel.objeto.VALOR_TOTAL);
    memoResultado.Lines.Add('===============================================');
  finally
    lWebPedidoModel:=nil;
  end;
end;

procedure TForm1.Button100Click(Sender: TObject);
var
  lPedidoCompraItens : ITPedidoCompraItensModel;
  lTable  : IFDDataset;
begin
  lPedidoCompraItens := TPedidoCompraItensModel.getNewIface(vIConexao);
  try
  lPedidoCompraItens.objeto.NumeroView := '000011';
  lTable                        := lPedidoCompraItens.objeto.obterLista;
  dsPedidoCompra.DataSet        := lTable.objeto;
  finally
    lPedidoCompraItens:=nil;
  end;
end;

procedure TForm1.Button101Click(Sender: TObject);
var
  lPedidoCompra : ITPedidoCompraModel;
begin
  lPedidoCompra := TPedidoCompraModel.getNewIface(vIConexao);
  try
    lPedidoCompra.objeto.NumeroView     := '000008';
    lPedidoCompra.objeto.FornecedorView := '000000';
    dsTmp                   := lPedidoCompra.objeto.obterLista;
    dsPedidoCompra.DataSet   := dsTmp.objeto;
  finally
    lPedidoCompra:=nil;
  end;
end;

procedure TForm1.Button102Click(Sender: TObject);
var
  lPrevisaoPedidoCompraModel : ITPrevisaoPedidoCompraModel;
  lPedidoCompra : ITPedidoCompraModel;
  pPed,
  pFornc : String;
begin
  lPedidoCompra := TPedidoCompraModel.getNewIface(vIConexao);
  lPrevisaoPedidoCompraModel := TPrevisaoPedidoCompraModel.getNewIface(vIConexao);
  try
    pPed   := '000013';
    pFornc := '000137';

    lPedidoCompra := lPedidoCompra.objeto.carregaClasse(pPed, pFornc);

    lPrevisaoPedidoCompraModel.objeto.gerarFinanceiro(lPedidoCompra);

  finally
    lPedidoCompra:=nil;
  end;
end;

procedure TForm1.Button103Click(Sender: TObject);
var
  lSaidasModel : ITSaidasModel;
begin
  lSaidasModel := TSaidasModel.getNewIface(vIConexao);
  try
    try
      lSaidasModel.objeto.LOJA       := '003';
      lSaidasModel.objeto.CODIGO_CLI := '000001';

      lSaidasModel.objeto.Incluir;

      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
    lSaidasModel:=nil;
  end;
end;

procedure TForm1.Button104Click(Sender: TObject);
var
  lSaidasModel : ITSaidasModel;
  ID : String;
begin
  lSaidasModel := TSaidasModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('Saidas', 'Digite o código da Saida que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lSaidasModel := lSaidasModel.objeto.Alterar(ID);
      lSaidasModel.objeto.TOTAL_SAI := 500;

      lSaidasModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lSaidasModel:=nil;
  end;
end;

procedure TForm1.Button105Click(Sender: TObject);
var
  lSaidasModel : ITSaidasModel;
  Numero_Saida : String;
begin
  lSaidasModel := TSaidasModel.getNewIface(vIConexao);
  try
    try
      Numero_Saida := InputBox('Saida', 'Digite o Numero da Saida que deseja excluir:', '');
      if Numero_Saida.IsEmpty then
          Exit;

      lSaidasModel.objeto.Excluir(Numero_Saida);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lSaidasModel:=nil;
  end;
end;

procedure TForm1.Button106Click(Sender: TObject);
var
  lSaidasModel : ITSaidasModel;
  lTable       : IFDDataset;
begin
  lSaidasModel := TSaidasModel.getNewIface(vIConexao);
  try
    try
      lSaidasModel.objeto.SaidaView := '000215';
      lSaidasModel.objeto.LojaView  := '001';

      lTable           := lSaidasModel.objeto.obterLista;
      dsSaidas.DataSet := lTable.objeto;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lSaidasModel:=nil;
  end;
end;

procedure TForm1.Button107Click(Sender: TObject);
var
  lSaidasModel      : ITSaidasModel;
  lSaidasItensModel : ITSaidasItensModel;
  lSaidaParams      : TSaidaItensParams;
  lNumeroSaida      : String;
begin
  lSaidasModel      := TSaidasModel.getNewIface(vIConexao);
  lSaidasItensModel := TSaidasItensModel.getNewIface(vIConexao);
  try
    try
      lNumeroSaida := InputBox('SaidaItens', 'Digite o Numero da Saida que deseja inserir os itens:', '');
      if lNumeroSaida.IsEmpty then
        exit;

      lSaidasModel := lSaidasModel.objeto.carregaClasse(lNumeroSaida);

      lSaidaParams.CODIGO_PRO     := '000007';
      lSaidaParams.QUANTIDADE_SAI := '5';
      lSaidaParams.VALOR_UNI_SAI  := '100';

      lSaidasModel.objeto.AdicionarItens(lSaidaParams);
      ShowMessage('Item adicionado ao Pedido: '  + lSaidasModel.objeto.NUMERO_SAI)

    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lSaidasModel:=nil;
    lSaidasItensModel:=nil;
  end;
end;

procedure TForm1.Button108Click(Sender: TObject);
var
  lSaidasItens : ITSaidasitensModel;
  lResultado   : IFDDataset;
begin
  lSaidasItens := TSaidasitensModel.getNewIface(vIConexao);
  try
    lResultado := lSaidasItens.objeto.ObterTotais('000260');
    dsSaidas.DataSet := lResultado.objeto;
  finally
    lSaidasItens:=nil;
  end;
end;

procedure TForm1.Button109Click(Sender: TObject);
var
  lLojasModel : ITLojasModel;
  lResultado  : IFDDataset;
begin
  lLojasModel := TLojasModel.getNewIface(vIConexao);
  try
    lResultado := lLojasModel.objeto.obterFiliais;
    dsSaidas.DataSet := lResultado.objeto;
  finally
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
  lWebPedidoItensModel : ITWebPedidoItensModel;
  ID                   : String;
begin
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('WebPedido', 'Digite o ID que deseja alterar:', '');

      if ID.IsEmpty then
        exit;

      lWebPedidoItensModel := lWebPedidoItensModel.objeto.Alterar(ID);
      lWebPedidoItensModel.objeto.PRODUTO_ID := '000001';
      lWebPedidoItensModel.objeto.QUANTIDADE := '25';
      lWebPedidoItensModel.objeto.VLR_GARANTIA := '10';
      lWebPedidoItensModel.objeto.Salvar;

      ShowMessage('Alterado o item com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoItensModel:=nil;
  end;
end;

procedure TForm1.Button110Click(Sender: TObject);
var
  lSaidasModel : ITSaidasModel;
  lParams      : TSaidaItensTransferenciaParams;
begin
  lSaidasModel := TSaidasModel.getNewIface(vIConexao);

  try
    lSaidasModel := lSaidasModel.objeto.carregaClasse('000224');

    lParams.CODIGO_PRO      := '000006';
    lParams.QUANTIDADE_SAI  := '2';

    lSaidasModel.objeto.AdicionarItensTransferencia(lParams);

  finally
    lSaidasModel:=nil;
  end;

end;

procedure TForm1.Button111Click(Sender: TObject);
var
  lSaidasItensModel : ITSaidasItensModel;
begin
  lSaidasItensModel := TSaidasItensModel.getNewIface(vIConexao);
  try
    lSaidasItensModel.objeto.Excluir('644');
  finally
    lSaidasItensModel.objeto.Free;
  end;
end;

procedure TForm1.BuButton116Click(Sender: TObject);
var
  lSaidasModel : ITSaidasModel;
begin
  lSaidasModel := TSaidasModel.getNewIface(vIConexao);
  try
    lSaidasModel.objeto.NUMERO_SAI := '000262';
    lSaidasModel := lSaidasModel.objeto.carregaClasse(lSaidasModel.objeto.NUMERO_SAI);

    lSaidasModel.objeto.CalcularPeso;
  finally
    lSaidasModel:=nil;
  end;
end;

procedure TForm1.Button113Click(Sender: TObject);
var
  lID : String;
  lMovimentoSerial : ITMovimentoSerialModel;
begin
  lMovimentoSerial := TMovimentoSerialModel.getNewIface(vIConexao);
  try
    try
      lID := InputBox('MovimentoSerial', 'Digite o ID que deseja excluir:', '');

      lMovimentoSerial.objeto.ID := lID;
      lMovimentoSerial.objeto.Excluir(lID);

      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lMovimentoSerial:=nil;
  end;
end;

procedure TForm1.Button114Click(Sender: TObject);
var
  lMovimentoSerial : ITMovimentoSerialModel;
begin
  lMovimentoSerial := TMovimentoSerialModel.getNewIface(vIConexao);
  try
    try
      dsTmp := lMovimentoSerial.objeto.ObterLista;
      dMovimentoSerial.DataSet := dsTmp.objeto;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lMovimentoSerial:=nil;
  end;
end;

procedure TForm1.Button116Click(Sender: TObject);
var
  lUsuarioModel : ITUsuarioModel;
  lIDUsuario,
  lSenhaAtual,
  lNovaSenha    : String;
begin
  lUsuarioModel := TUsuarioModel.getNewIface(vIConexao);
  try
    lIDUsuario := '000002';
    lSenhaAtual := InputBox('Senha', 'Digite a senha atual:', '');
    lNovaSenha := InputBox('Senha', 'Digite a nova senha:', '');

    lUsuarioModel.objeto.alterarSenha(lIDUsuario, lSenhaAtual, lNovaSenha);

  finally
  end;
end;

procedure TForm1.Button117Click(Sender: TObject);
var
  lMovimentoSerial : ITMovimentoSerialModel;
begin
  lMovimentoSerial := TMovimentoSerialModel.getNewIface(vIConexao);
  try
    try
      dsTmp := lMovimentoSerial.objeto.ConsultaSerial;
      dMovimentoSerial.DataSet := dsTmp.objeto;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lMovimentoSerial:=nil;
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  lWebPedidoItensModel : ITWebPedidoItensModel;
  lNumeroItem          : String;

begin
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(vIConexao);

  try
    try
      lNumeroItem := InputBox('WebPedido', 'Digite o ID que deseja excluir:', '');

      lWebPedidoItensModel.objeto.ID := lNumeroItem;
      lWebPedidoItensModel.objeto.Excluir(lNumeroItem);

      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoItensModel:=nil;
  end;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  lSaldoModel : ITSaldoModel;
  lMemTable   : IFDDataset;
  lProduto    : String;
begin
  lSaldoModel := TSaldoModel.getNewIface(vIConexao);
  try
    lProduto  := InputBox('Consulta de Saldo', 'Digite o código do produto:', '');

    lMemTable := lSaldoModel.objeto.obterSaldo(lProduto);

    memoResultado.Lines.Clear;
    memoResultado.Lines.Add('SALDO_FISICO: '+lMemTable.objeto.FieldByName('SALDO_FISICO').AsString);
    memoResultado.Lines.Add('SALDO_DISPONIVEL: '+lMemTable.objeto.FieldByName('SALDO_DISPONIVEL').AsString);
    memoResultado.Lines.Add('SALDO_CD: '+lMemTable.objeto.FieldByName('SALDO_CD').AsString);
    memoResultado.Lines.Add('===============================================');
  finally
  end;
end;

procedure TForm1.Button133Click(Sender: TObject);
var
  lTabelaJurosDia : ITTabelaJurosDiaModel;
  lDia,
  lPortador       : String;
  lIndice         : Double;
begin
  lTabelaJurosDia := TTabelaJurosDiaModel.getNewIface(vIConexao);
  try
    lDia := InputBox('TabelaJurosDia', 'Digite o dia:', '');
    lPortador := InputBox('TabelaJurosDia', 'Digite o código do portador:', '');

    lIndice := lTabelaJurosDia.objeto.obterIndice(lDia, lPortador);

    Memo1.Lines.Clear;
    Memo1.Lines.Add('Indice: ' +FloatToStr(lIndice));
    Memo1.Lines.Add('===============================================');

  finally
    lTabelaJurosDia:=nil;
  end;
end;

procedure TForm1.Button13Click(Sender: TObject);
var
  lProdutoModel : ITProdutosModel;
  lProduto      : String;
  lParametros   : TProdutoPreco;
  lValor        : Double;
begin
  lProdutoModel := TProdutosModel.getNewIface(vIConexao);
  try
     lProduto  := InputBox('Consulta de Saldo', 'Digite o código do produto:', '');

     lParametros.Produto     := lProduto;
     lParametros.TabelaPreco := true;
     lParametros.Promocao    := true;

     lValor := lProdutoModel.objeto.ValorUnitario(lParametros);

     memoResultado.Lines.Clear;
     memoResultado.Lines.Add('VALOR DE VENDA: '+ lValor.ToString);
     memoResultado.Lines.Add('===============================================');
  finally
  end;
end;

procedure TForm1.Button14Click(Sender: TObject);
var
  lSaldoModel : ITSaldoModel;
  lProduto    : String;
  lMemTable   : IFDDataset;
begin
  lSaldoModel := TSaldoModel.getNewIface(vIConexao);
  try
    lProduto  := InputBox('Reservas CD', 'Digite o código do produto:', '');

    lMemTable := lSaldoModel.objeto.obterReservasCD(lProduto);

    memoResultado.Lines.Clear;

    lMemTable.objeto.First;
    while not lMemTable.objeto.eof do
    begin
      memoResultado.Lines.Add('DOCUMENTO: '+ lMemTable.objeto.FieldByName('DOCUMENTO').AsString);
      memoResultado.Lines.Add('ORIGEM:    '+ lMemTable.objeto.FieldByName('ORIGEM').AsString);
      memoResultado.Lines.Add('DATA:      '+ lMemTable.objeto.FieldByName('DATA').AsString);
      memoResultado.Lines.Add('CLIENTE:   '+ lMemTable.objeto.FieldByName('CLIENTE').AsString);
      memoResultado.Lines.Add('RESERVADO: '+ lMemTable.objeto.FieldByName('RESERVADO').AsString);
      memoResultado.Lines.Add('LOJA:      '+ lMemTable.objeto.FieldByName('LOJA').AsString);
      memoResultado.Lines.Add('===============================================');
      lMemTable.objeto.Next;
    end;

  finally
  end;
end;

procedure TForm1.Button15Click(Sender: TObject);
var
  lEntradaModel : ITEntradaModel;
  NumEntrada    : String;
begin
  lEntradaModel := TEntradaModel.getNewIface(vIConexao);
  try
    try
      NumEntrada := InputBox('Entrada','Digite o número da Entrada (9 Digitos):','');

      if NumEntrada.IsEmpty then
        Exit;

      lEntradaModel.objeto.NUMERO_ENT  := NumEntrada;
      lEntradaModel.objeto.CODIGO_FOR  := '500005';
      lEntradaModel.objeto.SERIE_ENT   := '001';

      lEntradaModel.objeto.Incluir;
      ShowMessage('Inserido com Sucesso');
    Except
      on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.Button16Click(Sender: TObject);
var
  lContasPagarModel : ITContasPagarModel;
begin
  lContasPagarModel := TContasPagarModel.getNewIface(vIConexao);
  try
    try

      lContasPagarModel.objeto.DUPLICATA_PAG  := '9000002024';
      lContasPagarModel.objeto.CODIGO_FOR     := '500005';
      lContasPagarModel.objeto.PORTADOR_ID    := '000001';
      lContasPagarModel.objeto.DATAEMI_PAG    := '27.02.2024';
      lContasPagarModel.objeto.TIPO_PAG       := 'M';
      lContasPagarModel.objeto.VALOR_PAG      := '1000';
      lContasPagarModel.objeto.CONDICOES_PAG  := '30/60/90';

      lContasPagarModel.objeto.Incluir;
      ShowMessage('Inserido com Sucesso');
    Except
      on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.Button17Click(Sender: TObject);
var
  lEntradaModel : ITEntradaModel;
  lMemTable : IFDDataset;
begin
  lEntradaModel := TEntradaModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lEntradaModel.objeto.obterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('NUMERO_ENT: '+lMemTable.objeto.FieldByName('NUMERO_ENTRADA').AsString);
        memoResultado.Lines.Add('SERIE: '+lMemTable.objeto.FieldByName('SERIE').AsString);
        memoResultado.Lines.Add('CODIGO_FOR: '+lMemTable.objeto.FieldByName('COD_FORNECEDOR').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.objeto.FieldByName('NOME_FORNECEDOR').AsString);
        memoResultado.Lines.Add('ENDERECO_FORNECEDOR: '+lMemTable.objeto.FieldByName('ENDERECO_FORNECEDOR').AsString);
        memoResultado.Lines.Add('NUMERO_FORNECEDOR: '+lMemTable.objeto.FieldByName('NUMERO_FORNECEDOR').AsString);
        memoResultado.Lines.Add('BAIRRO_FORNECEDOR: '+lMemTable.objeto.FieldByName('BAIRRO_FORNECEDOR').AsString);
        memoResultado.Lines.Add('CIDADE_FORNECEDOR: '+lMemTable.objeto.FieldByName('CIDADE_FORNECEDOR').AsString);
        memoResultado.Lines.Add('CNPJ_CPF_FORNECEDOR: '+lMemTable.objeto.FieldByName('CNPJ_CPF_FORNECEDOR').AsString);
        memoResultado.Lines.Add('DATANOTA_ENT: '+lMemTable.objeto.FieldByName('DATA_EMISSAO').AsString);
        memoResultado.Lines.Add('TOTAL_ENT: '+lMemTable.objeto.FieldByName('VALOR_TOTAL').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.Button18Click(Sender: TObject);
var
  lEntradaModel     : ITEntradaModel;
  lNumeroEntrada,
  lCodigoFornecedor : String;
begin
  lEntradaModel := TEntradaModel.getNewIface(vIConexao);
  try
    try
      lNumeroEntrada    := '9999999999';
      lCodigoFornecedor := '500005';

      lEntradaModel := lEntradaModel.objeto.Alterar(lNumeroEntrada, lCodigoFornecedor);
      lEntradaModel.objeto.OBSERVACAO_ENT := 'TESTE ALTERACAO';

      lEntradaModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.Button19Click(Sender: TObject);
var
  lEntradaModel     : ITEntradaModel;
  lNumeroEntrada,
  lCodigoFornecedor : String;
begin
  lEntradaModel := TEntradaModel.getNewIface(vIConexao);
  try
    try
      lNumeroEntrada    := '9999999999';
      lCodigoFornecedor := '500005';

      lEntradaModel.objeto.Excluir(lNumeroEntrada, lCodigoFornecedor);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lEntradaModel:=nil;
  end;
end;

procedure TForm1.FDMemTable1BeforePost(DataSet: TDataSet);
begin
  //
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vIConexao := nil;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  lUsuario      : TUsuario;
  lEmpresa      : TEmpresa;
  lEmpresaModel : ITEmpresaModel;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  vIConexao := TControllersConexao.New;
//  vIConexao.terasoftConfiguracoes := vConfiguracoes;
  vIConexao.connection;

  vConfiguracoes := TerasoftConfiguracoes.getNewIface(vIConexao);

  vIConexao.setTerasoftConfiguracoes(vConfiguracoes);

  lUsuario.ID     := '000001';
  lUsuario.NOME   := 'ADMIN';
  lUsuario.PERFIL := '000000';

  vIConexao.setUser(lUsuario);

  lEmpresaModel := TEmpresaModel.getNewIface(vIConexao);
  lEmpresaModel.objeto.Carregar;

  lEmpresa.ID                     := lEmpresaModel.objeto.ID;
  lEmpresa.LOJA                   := lEmpresaModel.objeto.LOJA;
  lEmpresa.STRING_CONEXAO_RESERVA := lEmpresaModel.objeto.STRING_CONEXAO_RESERVA;

  vIConexao.setEmpresa(lEmpresa);

  vQtdeRegistros := 10;
  vPagina        := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  vConfiguracoes := nil;
  vIConexao := nil;
  {$if defined(__RELEASE__) or defined(__HIDE_MEMORY_LEAK__)}
//    TerminateProcess(GetCurrentProcess, exitCode );
  {$endif}
end;

procedure TForm1.imprimirContratoCarteiraClick(Sender: TObject);
var
  lImpressaoContratos : TImpressaoContratos;
begin
  lImpressaoContratos := TImpressaoContratos.Create(lImpressaoContratos);
  try
      lImpressaoContratos.IDPEDIDO    := InputBox('Imprimir Contrato Carteira', 'Digite o pedido de venda:', '040997');
      lImpressaoContratos.CONEXAO     := vIConexao;
      lImpressaoContratos.imprimirCarteira;
  finally
    lImpressaoContratos.Free;
  end;
end;

procedure TForm1.imprimirGarantidaEstendidaClick(Sender: TObject);
var
  lImpressaoContratos : TImpressaoContratos;
begin
  lImpressaoContratos := TImpressaoContratos.Create(lImpressaoContratos);
  try
      lImpressaoContratos.IDPEDIDO    := InputBox('Imprimir garantia estendida', 'Digite o pedido de venda:', '040697');
      lImpressaoContratos.CONEXAO     := vIConexao;
      lImpressaoContratos.imprimirGarantiaEstendida;
  finally
    lImpressaoContratos.Free;
  end;
end;

procedure TForm1.imprimirPrestamistaClick(Sender: TObject);
var
  lImpressaoContratos : TImpressaoContratos;
begin
  lImpressaoContratos := TImpressaoContratos.Create(lImpressaoContratos);
  try
    lImpressaoContratos.IDPEDIDO    := InputBox('Imprimir prestamista', 'Digite o pedido de venda:', '040718');
    lImpressaoContratos.CONEXAO     := vIConexao;
    lImpressaoContratos.imprimirPrestamista;
  finally
    lImpressaoContratos.Free;
  end;
end;

procedure TForm1.imprimirRFClick(Sender: TObject);
var
  lImpressaoContratos : TImpressaoContratos;
begin
  lImpressaoContratos := TImpressaoContratos.Create(lImpressaoContratos);
  try
      lImpressaoContratos.IDPEDIDO    := InputBox('Imprimir RF', 'Digite o pedido de venda:', '040697');
      lImpressaoContratos.CONEXAO     := vIConexao;
      lImpressaoContratos.imprimirRF;
  finally
    lImpressaoContratos.Free;
  end;
end;

procedure TForm1.imprimirRFDClick(Sender: TObject);
var
  lImpressaoContratos : TImpressaoContratos;
begin
  lImpressaoContratos := TImpressaoContratos.Create(lImpressaoContratos);
  try
      lImpressaoContratos.IDPEDIDO    := InputBox('Imprimir RFD', 'Digite o pedido de venda:', '040697');
      lImpressaoContratos.CONEXAO     := vIConexao;
      lImpressaoContratos.imprimirRFD;
  finally
    lImpressaoContratos.Free;
  end;
end;

procedure TForm1.OrcamentoAlterarClick(Sender: TObject);
var
  lOrcamentoModel : ITOrcamentoModel;
  ID : String;
begin
  lOrcamentoModel := TOrcamentoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('ORCAMENTO', 'Digite o ID do ORCAMENTO que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lOrcamentoModel := lOrcamentoModel.objeto.Alterar(ID);
      lOrcamentoModel.objeto.CODIGO_VEN := '000002';

      lOrcamentoModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
  end;
end;

procedure TForm1.OrcamentoConsultarClick(Sender: TObject);
var
  lOrcamentoModel : ITOrcamentoModel;
  lMemTable       : IFDDataset;
begin
  lOrcamentoModel := TOrcamentoModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lOrcamentoModel.objeto.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('NUMERO_ORC: '+lMemTable.objeto.FieldByName('NUMERO_ORC').AsString);
        memoResultado.Lines.Add('NOME_FUN: '+lMemTable.objeto.FieldByName('NOME_FUN').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;

end;

procedure TForm1.OrcamentoExcluirClick(Sender: TObject);
var
  lOrcamentoModel : ITOrcamentoModel;
  ID : String;
begin
  lOrcamentoModel := TOrcamentoModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('ORCAMENTO', 'Digite o ID do ORCAMENTO que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lOrcamentoModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.OrcamentoIncluirClick(Sender: TObject);
var
  lOrcamentoModel : ITOrcamentoModel;
begin
  lOrcamentoModel := TOrcamentoModel.getNewIface(vIConexao);
  try
    try
      lOrcamentoModel.objeto.CODIGO_CLI  := '000001';
      lOrcamentoModel.objeto.CODIGO_VEN  := '000001';
      lOrcamentoModel.objeto.TOTAL_ORC   := 1000;

      lOrcamentoModel.objeto.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
  end;
end;

procedure TForm1.OrcamentoItensAlterarClick(Sender: TObject);
var
  lOrcamentoItensModel : ITOrcamentoItensModel;
  ID : String;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('ORCAMENTOITENS', 'Digite o ID do ORCAMENTOITENS que deseja Alterar:', '');
      if ID.IsEmpty then
        exit;

      lOrcamentoItensModel := lOrcamentoItensModel.objeto.Alterar(ID);
      lOrcamentoItensModel.objeto.CODIGO_PRO := '000345';

      lOrcamentoItensModel.objeto.Salvar;
      ShowMessage('Alterado com Sucesso');
    Except
      on E:Exception do
      ShowMessage('Erro: ' +E.Message);
    end;
  finally
  end;
end;

procedure TForm1.OrcamentoItensConsultarClick(Sender: TObject);
var
  lOrcamentoItensModel : ITOrcamentoItensModel;
  lMemTable            : IFDDataset;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.getNewIface(vIConexao);
  try
    try
      lMemTable := lOrcamentoItensModel.objeto.ObterLista;

      memoResultado.Lines.Clear;

      lMemTable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        memoResultado.Lines.Add('CODIGO_PRO: '+lMemTable.objeto.FieldByName('CODIGO_PRO').AsString);
        memoResultado.Lines.Add('TOTAL: '+lMemTable.objeto.FieldByName('TOTAL').AsString);
        memoResultado.Lines.Add('===============================================');
        lMemTable.objeto.Next;
      end;
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.OrcamentoItensExcluirClick(Sender: TObject);
var
  lOrcamentoItensModel : ITOrcamentoItensModel;
  ID : String;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.getNewIface(vIConexao);
  try
    try
      ID := InputBox('ORCAMENTO', 'Digite o ID do ORCAMENTO que deseja excluir:', '');
      if ID.IsEmpty then
          Exit;

      lOrcamentoItensModel.objeto.Excluir(ID);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;

end;

procedure TForm1.OrcamentoItensIncluirClick(Sender: TObject);
var
  lOrcamentoItensModel : ITOrcamentoItensModel;
begin
  lOrcamentoItensModel := TOrcamentoItensModel.getNewIface(vIConexao);
  try
    try
      lOrcamentoItensModel.objeto.NUMERO_ORC         := '000015';
      lOrcamentoItensModel.objeto.CODIGO_PRO         := '000001';
      lOrcamentoItensModel.objeto.VALORUNITARIO_ORC  := 1000;

      lOrcamentoItensModel.objeto.Incluir;
      ShowMessage('Incluido com Sucesso!');
    except
      on E:Exception do
      ShowMessage('Erro: ' + E.Message);
    end
  finally
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  lTabelaJurosPromocaoModel : ITTabelaJurosPromocaoModel;
  lTableJuros               : IFDDataset;
begin
  lTabelaJurosPromocaoModel := TTabelaJurosPromocaoModel.getNewIface(vIConexao);
  try
    lTableJuros := lTabelaJurosPromocaoModel.objeto.obterTabelaJurosProduto('006165');

    if lTableJuros.objeto.RecordCount > 0 then
    begin
      dsTmp := RetornaCoeficiente(lTableJuros.objeto.FieldByName('TAXA_JUROS').AsFloat, lTableJuros.objeto.FieldByName('PARCELA').AsInteger);
      dsJuros.DataSet := dsTmp.objeto;
    end;

  finally
    lTabelaJurosPromocaoModel:=nil;
  end;

end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  IDRegistro             : String;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(vIConexao);

  try
    try
      IDRegistro := InputBox('FinanceiroPedido', 'Digite o ID do registro Financeiro:', '');

      if IDRegistro.IsEmpty then
        exit;

      lFinanceiroPedidoModel.objeto.ArredondaParcela(160,IDRegistro);

    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
  end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  TfrmEditorConsultas.getNewIface(vIConexao).objeto.showModal;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Form.Endpoint.criaViewEndpoint(vIConexao).objeto.ShowModal;
end;

initialization
  config_DiretorioAtualizado := '\\192.168.20.30\Atualizado\';



end.
