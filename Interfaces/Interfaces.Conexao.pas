unit Interfaces.Conexao;

interface
  uses
    FireDAC.Comp.Client;

  type
    IConexao = interface
      ['{66A98734-B254-4482-A4EA-8D3D1CD8C974}']

      function criarQuery                              : TFDQuery;
      function ConfigConexao(pLoja: String)            : Boolean;
      function Generetor(pValue: String)               : String;
      function getConnection                           : TFDConnection;
      function getLojaConectada                        : String;
    end;

implementation

end.
