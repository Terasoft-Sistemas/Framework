unit UsuarioControl;

interface

  uses
    SysUtils,
    UsuarioModel,
    FireDAC.Comp.Client,
    Interfaces.Conexao;

type
    TUsuarioControl = class

  private
    FUsuarioModel: ITUsuarioModel;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Salvar: String;
    function validaLogin(user,pass: String): Boolean;
    property UsuarioModel: ITUsuarioModel read FUsuarioModel write FUsuarioModel;

  end;

implementation

{ TClienteContol }

constructor TUsuarioControl.Create(pIConexao : IConexao);
begin
  FUsuarioModel := TUsuarioModel.getNewIface(pIConexao);
end;

destructor TUsuarioControl.Destroy;
begin
  FUsuarioModel := nil;
  inherited;
end;

function TUsuarioControl.Salvar: String;
begin
  Result := FUsuarioModel.objeto.Salvar;
end;

function TUsuarioControl.validaLogin(user, pass: String): Boolean;
begin
  Result := FUsuarioModel.objeto.validaLogin(user, pass);
end;

end.
