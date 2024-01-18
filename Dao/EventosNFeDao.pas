unit EventosNFeDao;

interface

uses
  FireDAC.Comp.Client,
  EventosNFeModel,
  System.SysUtils,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TEventosNFeDao = class

  private
  vIConexao   : IConexao;
  vConstrutor : TConstrutorDao;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;


    function incluir(AEventosNFeModel: TEventosNFeModel): Boolean;
    function alterar(AEventosNFeModel: TEventosNFeModel): Boolean;
    function excluir(AEventosNFeModel: TEventosNFeModel): Boolean;

    procedure setParams(var pQry: TFDQuery; pEventosNFeModel : TEventosNFeModel);
    function where: String;
end;

implementation

uses
  System.StrUtils;//, SistemaControl;
{ TEventosNFeDao }

function TEventosNFeDao.alterar(AEventosNFeModel: TEventosNFeModel): Boolean;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('EVENTOS_NFE','ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('ID').Value := AEventosNFeModel.ID;
    setParams(lQry, AEventosNFeModel);
    lQry.ExecSQL;

    Result := AEventosNFeModel.ID;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

constructor TEventosNFeDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TEventosNFeDao.Destroy;
begin
  inherited;

end;

function TEventosNFeDao.excluir(AEventosNFeModel: TEventosNFeModel): Boolean;
var
  lQry: TFDQuery;

begin

  lQry := vIconexao.CriarQuery;

  try
   lQry.ExecSQL('delete from EVENTOS_NFE where ID = :ID',[AEventosNFeModel.ID]);
   lQry.ExecSQL;
   Result := AEventosNFeModel.ID;

  finally
    lQry.Free;
  end;
end;

function TEventosNFeDao.incluir(AEventosNFeModel: TEventosNFeModel): Boolean;
var
  lSQL: String;
  lQry: TFDQuery;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSQL := vConstrutor.gerarInsert('EVENTOS_NFE','ID');

  finally

  end;
end;

end.
