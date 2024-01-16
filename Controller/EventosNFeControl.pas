unit EventosNFeControl;

interface

uses
  EventosNFeModel,
  FireDAC.Comp.Client;

type
    TEventosNFeControl = class

  private
    FEventosNFeModel: TEventosNFeModel;

  public
    constructor Create;
    destructor Destroy; override;

    function Salvar: Boolean;
    property EventosNFeModel: TEventosNFeModel read FEventosNFeModel write FEventosNFeModel;

  end;

implementation

{ TEventosNFeControl }

constructor TEventosNFeControl.Create;
begin
  FEventosNFeModel := TEventosNFeModel.Create;
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
