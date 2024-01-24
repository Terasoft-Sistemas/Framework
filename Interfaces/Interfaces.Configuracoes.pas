unit Interfaces.Configuracoes;

interface
  uses
    Terasoft.Types;

  type
    IConfiguracoes = interface
      ['{95F87627-AEB8-4783-A4E9-C528CAE82D28}']

      function carregarConfiguracoes : IConfiguracoes;
      function valorTag(tag: String; ValorPadrao: Variant; tipoValor: TTipoValorConfiguracao = tvString; pPerfil: String = '')  : Variant;
    end;

implementation

end.
