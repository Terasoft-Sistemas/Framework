unit EventosNFeControl;

interface

uses
  EventosNFeModel,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TEventosNFeControl = class;
  ITEventosNFeControl=IObject<TEventosNFeControl>;

  TEventosNFeControl=class

  private
    [unsafe] mySelf: ITEventosNFeControl;
    FEventosNFeModel: ITEventosNFeModel;

  public
    constructor _Create(pIConexao: IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEventosNFeControl;

    function Salvar: Boolean;
    property EventosNFeModel: ITEventosNFeModel read FEventosNFeModel write FEventosNFeModel;

  end;

implementation

{ TEventosNFeControl }

constructor TEventosNFeControl._Create(pIConexao : IConexao);
begin
  FEventosNFeModel := TEventosNFeModel.getNewIface(pIConexao);
end;

destructor TEventosNFeControl.Destroy;
begin
  FEventosNFeModel := nil;
  inherited;
end;

class function TEventosNFeControl.getNewIface(pIConexao: IConexao): ITEventosNFeControl;
begin
  Result := TImplObjetoOwner<TEventosNFeControl>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TEventosNFeControl.Salvar: Boolean;
begin
  Result := FEventosNFeModel.objeto.Salvar;
end;

end.
