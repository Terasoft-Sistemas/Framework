unit NFControl;

interface

uses
  NFModel,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
    TNFContol = class

  private
    FNFModel: TNFModel;

  public
    constructor Create(ID: String; pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: Boolean;
    function carregaClasse(ID: String): TNFModel;
    property NFModel: TNFModel read FNFModel write FNFModel;

  end;

implementation

{ TNFContol }

function TNFContol.carregaClasse(ID: String): TNFModel;
begin
  Result := FNFModel.carregaClasse(ID);
end;

constructor TNFContol.Create(ID: String; pIConexao : IConexao);
begin
  FNFModel := TNFModel.Create(pIConexao);
if ID <> '' then
   FNFModel := FNFModel.carregaClasse(ID);
end;

destructor TNFContol.Destroy;
begin
  FNFModel.Free;

  inherited;
end;

function TNFContol.Salvar: Boolean;
begin
  Result := FNFModel.Salvar <> '';
end;

end.
