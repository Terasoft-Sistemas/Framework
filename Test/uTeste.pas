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

  private
    { Private declarations }
    vIConexao       : IConexao;
    vQtdeRegistros,
    vPagina         : Integer;

  public
    { Public declarations }
    vConexao : TConexao;
  end;

var
  Form1: TForm1;

implementation

uses
  FinanceiroPedidoModel,
  WebPedidoModel,
  Controllers.Conexao,
  FireDAC.Comp.Client;

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
      lFinanceiroPedidoModel.Acao := tacIncluir;
      lFinanceiroPedidoModel.WEB_PEDIDO_ID := '325';
      lFinanceiroPedidoModel.PORTADOR_ID   := '000001';
      lFinanceiroPedidoModel.VALOR_TOTAL   := '500';
      lFinanceiroPedidoModel.PARCELA       := '1';
      lFinanceiroPedidoModel.VALOR_PARCELA := '1';
      lFinanceiroPedidoModel.Salvar;
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
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);

  try
    try
      lFinanceiroPedidoModel.Acao := tacAlterar;
      lFinanceiroPedidoModel.ID            := '4';
      lFinanceiroPedidoModel.WEB_PEDIDO_ID := '324';
      lFinanceiroPedidoModel.PORTADOR_ID   := '000001';
      lFinanceiroPedidoModel.VALOR_TOTAL   := '300';
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
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);

  try
    try
      lFinanceiroPedidoModel.Acao := tacExcluir;
      lFinanceiroPedidoModel.ID            := '5';
      lFinanceiroPedidoModel.Salvar;
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
      lWebPedidoModel.Acao := tacIncluir;

      lWebPedidoModel.CLIENTE_ID := '000001';
      lWebPedidoModel.VENDEDOR_ID := '000001';
      lWebPedidoModel.PORTADOR_ID := '000001';
      lWebPedidoModel.TIPOVENDA_ID := '000004';
      lWebPedidoModel.CONDICOES_PAGAMENTO := '30';

      lWebPedidoModel.Salvar;
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
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    try
      lWebPedidoModel := lWebPedidoModel.carregaClasse('329');

      lWebPedidoModel.Acao := tacAlterar;
      lWebPedidoModel.VENDEDOR_ID := '000001';

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
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    try
      lWebPedidoModel.Acao := tacExcluir;
      lWebPedidoModel.ID := '333';

      lWebPedidoModel.Salvar;
      ShowMessage('Excluido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lWebPedidoModel.Free;
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
begin
  vConexao  := TConexao.Create;
  vIConexao := TControllersConexao.New;

  vQtdeRegistros := 10;
  vPagina        := 0;
end;

end.
