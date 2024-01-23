program Teste_Classes;

uses
  Vcl.Forms,
  uTeste in 'uTeste.pas' {Form1},
  FinanceiroPedidoDao in '..\Dao\FinanceiroPedidoDao.pas',
  FinanceiroPedidoModel in '..\Model\FinanceiroPedidoModel.pas',
  Terasoft.Types in '..\Types\Terasoft.Types.pas',
  Interfaces.Conexao in '..\Interfaces\Interfaces.Conexao.pas',
  Terasoft.Utils in '..\Libs\Terasoft.Utils.pas',
  Terasoft.ConstrutorDao in '..\Libs\Terasoft.ConstrutorDao.pas',
  Terasoft.FuncoesTexto in '..\Libs\Terasoft.FuncoesTexto.pas',
  Conexao in 'Conexao.pas',
  Controllers.Conexao in 'Controllers.Conexao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
