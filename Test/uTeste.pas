unit uTeste;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
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
  Interfaces.Conexao;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
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

  private
    { Private declarations }
    vQtdeRegistros,
    vPagina         : Integer;

  public
    { Public declarations }
    vIConexao : IConexao;
    vConexao  : TConexao;
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
  SaldoModel, EmpresaModel, ProdutosModel;

{$R *.dfm}

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

procedure TForm1.Button1Click(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);
  try
    try
      lFinanceiroPedidoModel.WEB_PEDIDO_ID        := '325';
      lFinanceiroPedidoModel.PORTADOR_ID          := '000001';
      lFinanceiroPedidoModel.VALOR_TOTAL          := '500';
      lFinanceiroPedidoModel.QUANTIDADE_PARCELAS  := '2';
      lFinanceiroPedidoModel.PARCELA              := '1';
      lFinanceiroPedidoModel.VALOR_PARCELA        := '500';
      lFinanceiroPedidoModel.VENCIMENTO           := '26/01/2024';
      lFinanceiroPedidoModel.CONDICAO_PAGAMENTO   :='30';

      lFinanceiroPedidoModel.Incluir;

      ShowMessage('Inserido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  IDRegistro            : String;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);

  try
    try
      IDRegistro := InputBox('FinanceiroPedido', 'Digite o ID do registro Financeiro:', '');

      if IDRegistro.IsEmpty then
        exit;

      lFinanceiroPedidoModel := lFinanceiroPedidoModel.Alterar(IDRegistro);
      lFinanceiroPedidoModel.WEB_PEDIDO_ID := '324';
      lFinanceiroPedidoModel.PORTADOR_ID   := '000001';
      lFinanceiroPedidoModel.VALOR_TOTAL   := '30';
      lFinanceiroPedidoModel.PARCELA       := '1';
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

procedure TForm1.Button3Click(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  IDRegistro             : String;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);

  try
    try
      IDRegistro := InputBox('FinanceiroPedido', 'Digite o ID do registro Financeiro para excluir:', '');

      if IDRegistro.IsEmpty then
        exit;

      lFinanceiroPedidoModel.Excluir(IDRegistro);
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel.Free;
  end;
end;

/// WebPedido ///

procedure TForm1.Button4Click(Sender: TObject);
var
  lWebPedidoModel : TWebPedidoModel;
  i               : Integer;
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    lWebPedidoModel.LengthPageView  := vQtdeRegistros.ToString;
    lWebPedidoModel.StartRecordView := vPagina.ToString;
    lWebPedidoModel.OrderView       := 'id';

    lWebPedidoModel.obterListaVendaAssistida;

    inc(vPagina, 10);

    memoResultado.Lines.Clear;

    for i := 0 to lWebPedidoModel.WebPedidosLista.Count -1 do
    begin
      memoResultado.Lines.Add('ID: '+ lWebPedidoModel.WebPedidosLista[i].ID);
      memoResultado.Lines.Add('CLIENTE: '+lWebPedidoModel.WebPedidosLista[i].CLIENTE_NOME);
      memoResultado.Lines.Add('VALOR_ITENS: '+lWebPedidoModel.WebPedidosLista[i].VALOR_ITENS);
      memoResultado.Lines.Add('VALOR_TOTAL: '+lWebPedidoModel.WebPedidosLista[i].VALOR_TOTAL);
      memoResultado.Lines.Add('===============================================');
    end;

  finally
    lWebPedidoModel.Free;
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
      lVenderItemParametros.VALOR_UNITARIO   := '0';

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
      lWebPedidoItensModel.obterListaVendaAssistidaItens;

      memoResultado.Lines.Clear;
      for i := 0 to lWebPedidoItensModel.WebPedidoItenssLista.Count -1 do
      begin
          memoResultado.Lines.Add('ID: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].ID);
          memoResultado.Lines.Add('QUANTIDADE: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].QUANTIDADE);
          memoResultado.Lines.Add('PRODUTO_ID: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].PRODUTO_ID);
          memoResultado.Lines.Add('VALOR_UNITARIO: ' +lWebPedidoItensModel.WebPedidoItenssLista[i].VALOR_UNITARIO);
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
    lMemTable := lTabelaJurosModel.obterLista(lPortador, 1000);

    lMemTable.first;
    while not lMemTable.eof do
    begin
      memoResultado.Lines.Add('ID: '+lMemTable.FieldByName('ID').AsString);
      memoResultado.Lines.Add('PARCELA: '+lMemTable.FieldByName('CODIGO').AsString);
      memoResultado.Lines.Add('PERCENTUAL: '+lMemTable.FieldByName('PERCENTUAL').AsString);
      memoResultado.Lines.Add('JUROS: '+lMemTable.FieldByName('JUROS_TEXTO').AsString);
      memoResultado.Lines.Add('VALOR_PARCELA: '+lMemTable.FieldByName('VALOR_PARCELA').AsString);
      memoResultado.Lines.Add('VALOR_TOTAL: '+lMemTable.FieldByName('VALOR_TOTAL').AsString);
      memoResultado.Lines.Add('===============================================');
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

    lWebPedidoModel.ID := lID;
    lWebPedidoModel.obterTotais;

    memoResultado.Lines.Add('ACRESCIMO: '+lWebPedidoModel.ACRESCIMO);
    memoResultado.Lines.Add('VALOR_FRETE: '+lWebPedidoModel.VALOR_FRETE);
    memoResultado.Lines.Add('VALOR_CUPOM_DESCONTO: '+lWebPedidoModel.VALOR_CUPOM_DESCONTO);
    memoResultado.Lines.Add('VALOR_ITENS: '+lWebPedidoModel.VALOR_ITENS);
    memoResultado.Lines.Add('VALOR_TOTAL: '+lWebPedidoModel.VALOR_TOTAL);
  finally
    lWebPedidoModel.Free;
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
  lWebPedidoItensModel : TWebPedidoItensModel;
  ID                  : String;
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
  lProduto : String;
  lParametros: TProdutoPreco;
  lValor : Double;
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

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vConexao.Free;
  Form1.Release;
  Form1 := nil;
  Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  lUsuario      : TUsuario;
  lEmpresa      : TEmpresa;
  lEmpresaModel : TEmpresaModel;
begin
  vConexao  := TConexao.Create;
  vIConexao := TControllersConexao.New;

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

end.
