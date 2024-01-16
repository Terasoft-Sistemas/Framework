unit EventosNFeControl;

interface

uses
  EventosNFeModel,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
    TEventosNFeControl = class

  private
    FEventosNFeModel: TEventosNFeModel;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: Boolean;
    property EventosNFeModel: TEventosNFeModel read FEventosNFeModel write FEventosNFeModel;

  end;

implementation

{ TEventosNFeControl }

constructor TEventosNFeControl.Create(pIConexao : IConexao);
begin
  FEventosNFeModel := TEventosNFeModel.Create(pIConexao);
end;

destructor TEventosNFeControl.Destroy;
begin
  FEventosNFeModel.Free;
  inherited;
end;

function TEventosNFeControl.Salvar: Boolean;
begin
  Result := FEventosNFeModel.Salvar;
end;

end.
