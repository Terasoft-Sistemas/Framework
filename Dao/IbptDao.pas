unit IbptDao;

interface

uses
  IbptModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TIbptDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

    FOrderView: String;
    FWhereView: String;
    procedure SetOrderView(const Value: String);
    procedure SetWhereView(const Value: String);

    function where: String;

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property WhereView: String read FWhereView write SetWhereView;
    property OrderView: String read FOrderView write SetOrderView;

    function incluir(pIbptModel: TIbptModel): String;
    function alterar(pIbptModel: TIbptModel): String;
    function excluir(pIbptModel: TIbptModel): String;

    function carregaClasse(pID : String): TIbptModel;

    function obterIBPT(pUf, pNCM : String): IFDDataset;

    procedure setParams(var pQry: TFDQuery; pIbptModel: TIbptModel);

end;

implementation

uses
  System.Rtti;

{ TIbpt }

function TIbptDao.carregaClasse(pID : String): TIbptModel;
var
  lQry: TFDQuery;
  lModel: TIbptModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TIbptModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ibpt2 where id = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                   := lQry.FieldByName('ID').AsString;
    lModel.UF                   := lQry.FieldByName('UF').AsString;
    lModel.CODIGO               := lQry.FieldByName('CODIGO').AsString;
    lModel.EX                   := lQry.FieldByName('EX').AsString;
    lModel.TIPO                 := lQry.FieldByName('TIPO').AsString;
    lModel.VIGENCIA_INICIO      := lQry.FieldByName('VIGENCIA_INICIO').AsString;
    lModel.VIGENCIA_FIM         := lQry.FieldByName('VIGENCIA_FIM').AsString;
    lModel.NACIONAL_FEDERAL     := lQry.FieldByName('NACIONAL_FEDERAL').AsString;
    lModel.IMPORTADOS_FEDERAL   := lQry.FieldByName('IMPORTADOS_FEDERAL').AsString;
    lModel.ESTADUAL             := lQry.FieldByName('ESTADUAL').AsString;
    lModel.MUNICIPAL            := lQry.FieldByName('MUNICIPAL').AsString;
    lModel.CHAVE                := lQry.FieldByName('CHAVE').AsString;
    lModel.VERSAO               := lQry.FieldByName('VERSAO').AsString;
    lModel.FONTE                := lQry.FieldByName('FONTE').AsString;
    lModel.UTRIB                := lQry.FieldByName('UTRIB').AsString;
    lModel.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TIbptDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TIbptDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TIbptDao.incluir(pIbptModel: TIbptModel): String;
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

function TIbptDao.alterar(pIbptModel: TIbptModel): String;
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

    Result := pIbptModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TIbptDao.excluir(pIbptModel: TIbptModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from Ibpt2 where ID = :ID' ,[pIbptModel.ID]);
   lQry.ExecSQL;
   Result := pIbptModel.ID;

  finally
    lQry.Free;
  end;
end;

function TIbptDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  Result := lSQL;
end;

function TIbptDao.obterIBPT(pUf, pNCM : String): IFDDataset;
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

procedure TIbptDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TIbptDao.setParams(var pQry: TFDQuery; pIbptModel: TIbptModel);
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pIbptModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pIbptModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TIbptDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
