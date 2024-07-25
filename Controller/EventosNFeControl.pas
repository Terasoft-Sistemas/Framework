unit EventosNFeControl;

interface

uses
  EventosNFeModel,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
    TEventosNFeControl = class

  private
    FEventosNFeModel: ITEventosNFeModel;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: Boolean;
    property EventosNFeModel: ITEventosNFeModel read FEventosNFeModel write FEventosNFeModel;

  end;

implementation

{ TEventosNFeControl }

constructor TEventosNFeControl.Create(pIConexao : IConexao);
begin
  FEventosNFeModel := TEventosNFeModel.getNewIface(pIConexao);
end;

destructor TEventosNFeControl.Destroy;
begin
  FEventosNFeModel := nil;
  inherited;
end;

function TEventosNFeControl.Salvar: Boolean;
begin
  Result := FEventosNFeModel.objeto.Salvar;
end;

end.
