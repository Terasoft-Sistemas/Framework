unit NFControl;

interface

uses
  NFModel,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TNFContol = class;
  ITNFContol=IObject<TNFContol>;


  TNFContol = class
  private
    [weak] mySelf: ITNFContol;
    FNFModel: ITNFModel;

  public
    constructor _Create(pID: String; pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pID: String; pIConexao: IConexao): ITNFContol;

    function Salvar: Boolean;
    function carregaClasse(ID: String): ITNFModel;
    property NFModel: ITNFModel read FNFModel write FNFModel;

  end;

implementation

{ TNFContol }

function TNFContol.carregaClasse(ID: String): ITNFModel;
begin
  Result := FNFModel.objeto.carregaClasse(ID);
end;

constructor TNFContol._Create(pID: String; pIConexao : IConexao);
begin
  FNFModel := TNFModel.getNewIface(pIConexao);
  if pID <> '' then
   FNFModel := FNFModel.objeto.carregaClasse(pID);
end;

destructor TNFContol.Destroy;
begin
  FNFModel:=nil;
  inherited;
end;

class function TNFContol.getNewIface(pID: String; pIConexao: IConexao): ITNFContol;
begin
  Result := TImplObjetoOwner<TNFContol>.CreateOwner(self._Create(pID, pIConexao));
  Result.objeto.myself := Result;
end;

function TNFContol.Salvar: Boolean;
begin
  Result := FNFModel.objeto.Salvar <> '';
end;

end.
