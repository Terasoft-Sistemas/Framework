unit EventosNFeDao;

interface

uses
  FireDAC.Comp.Client,
  EventosNFeModel,
  System.SysUtils,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
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
  System.StrUtils, System.Variants, System.Rtti;//, SistemaControl;
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
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
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

    lSQL := vConstrutor.gerarInsert('EVENTOS_NFE','ID', true);
    lQry.SQL.Add(lSQL);
    AEventosNFeModel.ID := vIConexao.Generetor('GEN_EVENTOS');
    setParams(lQry, AEventosNFeModel);

    vConstrutor.getSQL(lQry);

    lQry.Open;

    Result := lQry.FieldByName('ID').AsString <> '';
  finally
    lQry.free;
  end;
end;

procedure TEventosNFeDao.setParams(var pQry: TFDQuery; pEventosNFeModel: TEventosNFeModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('EVENTOS_NFE');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TEventosNFeModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pEventosNFeModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pEventosNFeModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

function TEventosNFeDao.where: String;
begin

end;

end.
