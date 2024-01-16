unit UsuarioControl;

interface

uses UsuarioModel, FireDAC.Comp.Client;

type
    TUsuarioControl = class

  private
    FUsuarioModel: TUsuarioModel;

  public
    constructor Create;
    destructor Destroy; override;

    function Salvar: String;
    function validaLogin(user,pass: String): Boolean;
    property UsuarioModel: TUsuarioModel read FUsuarioModel write FUsuarioModel;

  end;

implementation

{ TClienteContol }

constructor TUsuarioControl.Create;
begin
  FUsuarioModel := TUsuarioModel.Create;
end;

destructor TUsuarioControl.Destroy;
begin
  FUsuarioModel.Free;

  inherited;
end;

function TUsuarioControl.Salvar: String;
begin
  Result := FUsuarioModel.Salvar;
end;

function TUsuarioControl.validaLogin(user, pass: String): Boolean;
begin
  Result := FUsuarioModel.validaLogin(user, pass);
end;

end.
