unit IbptDao;

interface

uses
  IbptModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TIBPTDao = class;
  ITIBPTDao = IObject<TIBPTDao>;

  TIBPTDao = class
  private
    [unsafe] mySelf: ITIbptDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

    FOrderView: String;
    FWhereView: String;
    procedure SetOrderView(const Value: String);
    procedure SetWhereView(const Value: String);

    function where: String;

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITIbptDao;

    property WhereView: String read FWhereView write SetWhereView;
    property OrderView: String read FOrderView write SetOrderView;

    function incluir(pIbptModel: ITIbptModel): String;
    function alterar(pIbptModel: ITIbptModel): String;
    function excluir(pIbptModel: ITIbptModel): String;

    function carregaClasse(pID : String): ITIbptModel;

    function obterIBPT(pUf, pNCM : String): IFDDataset;

    procedure setParams(var pQry: TFDQuery; pIbptModel: ITIbptModel);
    function fonteIBPT: String;
    function chaveIBPT: String;
end;

implementation

uses
  System.Rtti;

{ TIbpt }

function TIBPTDao.carregaClasse(pID : String): ITIbptModel;
var
  lQry: TFDQuery;
  lModel: ITIbptModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TIbptModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ibpt2 where id = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                   := lQry.FieldByName('ID').AsString;
    lModel.objeto.UF                   := lQry.FieldByName('UF').AsString;
    lModel.objeto.CODIGO               := lQry.FieldByName('CODIGO').AsString;
    lModel.objeto.EX                   := lQry.FieldByName('EX').AsString;
    lModel.objeto.TIPO                 := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.VIGENCIA_INICIO      := lQry.FieldByName('VIGENCIA_INICIO').AsString;
    lModel.objeto.VIGENCIA_FIM         := lQry.FieldByName('VIGENCIA_FIM').AsString;
    lModel.objeto.NACIONAL_FEDERAL     := lQry.FieldByName('NACIONAL_FEDERAL').AsString;
    lModel.objeto.IMPORTADOS_FEDERAL   := lQry.FieldByName('IMPORTADOS_FEDERAL').AsString;
    lModel.objeto.ESTADUAL             := lQry.FieldByName('ESTADUAL').AsString;
    lModel.objeto.MUNICIPAL            := lQry.FieldByName('MUNICIPAL').AsString;
    lModel.objeto.CHAVE                := lQry.FieldByName('CHAVE').AsString;
    lModel.objeto.VERSAO               := lQry.FieldByName('VERSAO').AsString;
    lModel.objeto.FONTE                := lQry.FieldByName('FONTE').AsString;
    lModel.objeto.UTRIB                := lQry.FieldByName('UTRIB').AsString;
    lModel.objeto.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TIBPTDao.chaveIBPT: String;
var
  lQry  : TFDQuery;
  lSQL  : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := 'select first 1 chave from ibpt2 i where current_date between i.vigencia_inicio and i.vigencia_fim  order by i.vigencia_inicio desc';
    lQry.Open(lSQL);

    Result := lQry.FieldByName('CHAVE').AsString;
  finally
    lQry.Free;
  end;
end;

constructor TIBPTDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TIBPTDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TIBPTDao.incluir(pIbptModel: ITIbptModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('IBPT2', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pIbptModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TIBPTDao.alterar(pIbptModel: ITIbptModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('IBPT2','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pIbptModel);
    lQry.ExecSQL;

    Result := pIbptModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TIBPTDao.excluir(pIbptModel: ITIbptModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from Ibpt2 where ID = :ID' ,[pIbptModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pIbptModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

function TIBPTDao.fonteIBPT: String;
var
  lQry  : TFDQuery;
  lSQL  : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := 'select first 1 fonte from ibpt2 i where current_date between i.vigencia_inicio and i.vigencia_fim  order by i.vigencia_inicio desc';
    lQry.Open(lSQL);

    Result := lQry.FieldByName('FONTE').AsString;
  finally
    lQry.Free;
  end;
end;

class function TIBPTDao.getNewIface(pIConexao: IConexao): ITIbptDao;
begin
  Result := TImplObjetoOwner<TIBPTDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TIBPTDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  Result := lSQL;
end;

function TIBPTDao.obterIBPT(pUf, pNCM : String): IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try

    lSQL := '  select *                                                                  '+SLineBreak+
            '    from ibpt2                                                              '+SLineBreak+
            '   where ibpt2.tipo = ''0''                                                 '+SLineBreak+
            '     and ibpt2.ex = ''''                                                    '+SLineBreak+
            '     and current_date between ibpt2.vigencia_inicio and ibpt2.vigencia_fim  '+SLineBreak+
            '     and ibpt2.codigo = ' + QuotedStr(pNCM)                                  +SLineBreak+
            '     and ibpt2.uf = '+ QuotedStr(pUf)                                        +SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

procedure TIBPTDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TIBPTDao.setParams(var pQry: TFDQuery; pIbptModel: ITIbptModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('IBPT2');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TIbptModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pIbptModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pIbptModel.objeto).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TIBPTDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
