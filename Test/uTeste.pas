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
  Interfaces.Conexao, EntradaModel;

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
  SaldoModel, EmpresaModel, ProdutosModel, EntradaItensModel,
  ClienteModel, ContasPagarModel, ContasPagarItensModel, System.SysUtils,
  ReservaModel;

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

procedure TForm1.Button1Click(Sender: TObject);
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  lFinanceiroParams      : TFinanceiroParams;
begin
  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(vIConexao);
  try
    try
      lFinanceiroParams.WEB_PEDIDO_ID       := '325';
      lFinanceiroParams.PORTADOR_ID         := '000001';
      lFinanceiroParams.PRIMEIRO_VENCIMENTO := Date + 30;
      lFinanceiroParams.QUANTIDADE_PARCELAS := 3;
      lFinanceiroParams.VALOR_TOTAL         := 150;

      lFinanceiroPedidoModel.gerarFinanceiro(lFinanceiroParams);

      ShowMessage('Inserido com sucesso!');
    except
     on E:Exception do
       ShowMessage('Erro: ' + E.Message);
    end;
  finally
    lFinanceiroPedidoModel.Free;
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
      lClienteModel.seprocado_cli   :='N';
      lClienteModel.estadocivil_cli := 'O';
      lClienteModel.data_alteracao  := '05.02.2024';
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
  Duplicata         : String;
begin
  lContasPagarModel := TContasPagarModel.Create(vIConexao);
  try
    try
      Duplicata := InputBox('Cliente', 'Digite a Duplicata que deseja excluir:', '');

      if Duplicata.IsEmpty then
      Exit;

      lContasPagarModel.Excluir(Duplicata);
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
      lContasPagarModel.gerarDuplicatas('R00006', '000001');

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

      lEntradaItensModel.IDEntrada := NumEntrada;
      lMemTable := lEntradaItensModel.obterLista;
      lMemTable.First;
      while not lMemTable.Eof do
      begin
         memoResultado.Lines.Add('NUMERO_ENT: ' +lMemTable.FieldByName('NUMERO_ENT').AsString);
         memoResultado.Lines.Add('CODIGO_FOR: ' +lMemTable.FieldByName('CODIGO_FOR').AsString);
         memoResultado.Lines.Add('FORNECEDOR: ' +lMemTable.FieldByName('FORNECEDOR').AsString);
         memoResultado.Lines.Add('CODIGO_PRO: ' +lMemTable.FieldByName('CODIGO_PRO').AsString);
         memoResultado.Lines.Add('PRODUTO: ' +lMemTable.FieldByName('PRODUTO').AsString);
         memoResultado.Lines.Add('QUANTIDADE_ENT: ' +lMemTable.FieldByName('QUANTIDADE_ENT').AsString);
         memoResultado.Lines.Add('VALORUNI_ENT: ' +lMemTable.FieldByName('VALORUNI_ENT').AsString);
         memoResultado.Lines.Add('============================================');
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
  lMemTable       : TFDMemTable;
begin
  lWebPedidoModel := TWebPedidoModel.Create(vIConexao);
  try
    lWebPedidoModel.LengthPageView  := vQtdeRegistros.ToString;
    lWebPedidoModel.StartRecordView := vPagina.ToString;
    lWebPedidoModel.OrderView       := 'id';

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
    if lID.IsEmpty then
      Exit;

    lWebPedidoModel.ID := lID;
    lWebPedidoModel.obterTotais;

    memoResultado.Lines.Add('ACRESCIMO: '+lWebPedidoModel.ACRESCIMO);
    memoResultado.Lines.Add('VALOR_FRETE: '+lWebPedidoModel.VALOR_FRETE);
    memoResultado.Lines.Add('VALOR_CUPOM_DESCONTO: '+lWebPedidoModel.VALOR_CUPOM_DESCONTO);
    memoResultado.Lines.Add('VALOR_ITENS: '+lWebPedidoModel.VALOR_ITENS);
    memoResultado.Lines.Add('VALOR_TOTAL: '+lWebPedidoModel.VALOR_TOTAL);
    memoResultado.Lines.Add('===============================================');
  finally
    lWebPedidoModel.Free;
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

      lContasPagarModel.DUPLICATA_PAG  := '9000000009';
      lContasPagarModel.CODIGO_FOR  := '500005';
      lContasPagarModel.PORTADOR_ID  := '000001';
      lContasPagarModel.DATAEMI_PAG := '05.02.2024';
      lContasPagarModel.TIPO_PAG := 'M';

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
        memoResultado.Lines.Add('NUMERO_ENT: '+lMemTable.FieldByName('NUMERO_ENT').AsString);
        memoResultado.Lines.Add('CODIGO_FOR: '+lMemTable.FieldByName('CODIGO_FOR').AsString);
        memoResultado.Lines.Add('FORNECEDOR: '+lMemTable.FieldByName('NOME_FORNECEDOR').AsString);
        memoResultado.Lines.Add('DATANOTA_ENT: '+lMemTable.FieldByName('DATANOTA_ENT').AsString);
        memoResultado.Lines.Add('TOTAL_ENT: '+lMemTable.FieldByName('TOTAL_ENT').AsString);
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
