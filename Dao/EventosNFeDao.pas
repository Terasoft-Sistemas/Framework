unit EventosNFeDao;

interface

uses
  FireDAC.Comp.Client,
  EventosNFeModel,
  System.SysUtils,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TEventosNFeDao = class;

  ITEventosNFeDao = IObject<TEventosNFeDao>;

  TEventosNFeDao = class
  private
  [unsafe] mySelf: ITEventosNFeDao;
  vIConexao   : IConexao;
  vConstrutor : IConstrutorDao;

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITEventosNFeDao;

    function incluir(AEventosNFeModel: ITEventosNFeModel): Boolean;
    function alterar(AEventosNFeModel: ITEventosNFeModel): Boolean;
    function excluir(AEventosNFeModel: ITEventosNFeModel): Boolean;

    procedure setParams(var pQry: TFDQuery; pEventosNFeModel : ITEventosNFeModel);
    function where: String;
end;

implementation

uses
  System.StrUtils, System.Variants, System.Rtti;//, SistemaControl;
{ TEventosNFeDao }

function TEventosNFeDao.alterar(AEventosNFeModel: ITEventosNFeModel): Boolean;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('EVENTOS_NFE','ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('ID').Value := AEventosNFeModel.objeto.ID;
    setParams(lQry, AEventosNFeModel);
    lQry.ExecSQL;

    Result := AEventosNFeModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

constructor TEventosNFeDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TEventosNFeDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

class function TEventosNFeDao.getNewIface(pIConexao: IConexao): ITEventosNFeDao;
begin
  Result := TImplObjetoOwner<TEventosNFeDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TEventosNFeDao.excluir(AEventosNFeModel: ITEventosNFeModel): Boolean;
var
  lQry: TFDQuery;

begin

  lQry := vIconexao.CriarQuery;

  try
   lQry.ExecSQL('delete from EVENTOS_NFE where ID = :ID',[AEventosNFeModel.objeto.ID]);
   lQry.ExecSQL;
   Result := AEventosNFeModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

function TEventosNFeDao.incluir(AEventosNFeModel: ITEventosNFeModel): Boolean;
var
  lSQL: String;
  lQry: TFDQuery;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSQL := vConstrutor.gerarInsert('EVENTOS_NFE','ID', true);
    lQry.SQL.Add(lSQL);
    AEventosNFeModel.objeto.ID := vIConexao.Generetor('GEN_EVENTOS');
    setParams(lQry, AEventosNFeModel);

    vConstrutor.getSQL(lQry);

    lQry.Open;

    Result := lQry.FieldByName('ID').AsString <> '';
  finally
    lQry.free;
  end;
end;

procedure TEventosNFeDao.setParams(var pQry: TFDQuery; pEventosNFeModel: ITEventosNFeModel);
var
  lTabela : IFDDataset;
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pEventosNFeModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pEventosNFeModel.objeto).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

function TEventosNFeDao.where: String;
begin

end;

end.
