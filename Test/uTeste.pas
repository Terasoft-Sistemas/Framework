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
    procedure btnFinanceiroPedidoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
    vIConexao : IConexao;
  public
    { Public declarations }
    vConexao : TConexao;
  end;

var
  Form1: TForm1;

implementation

uses
  FinanceiroPedidoModel, Controllers.Conexao, FireDAC.Comp.Client;

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

procedure TForm1.FormCreate(Sender: TObject);
begin
  vConexao  := TConexao.Create;
  vIConexao := TControllersConexao.New;
end;

end.
