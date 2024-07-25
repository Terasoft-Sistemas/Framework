unit GrupoComissaoFuncionarioDao;

interface

uses

  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.FuncoesTexto,
  Spring.Collections,
  Terasoft.ConstrutorDao,
  GrupoComissaoFuncionarioModel;

type
  TGrupoComissaoFuncionarioDao = class

  private
    vIConexao : IConexao;

    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;

    var
      vConstrutorDao : TConstrutorDao;

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel): String;
    function alterar(pGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel): String;
    function excluir(pGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel): String;
    function carregaClasse(pID : String): TGrupoComissaoFuncionarioModel;

    procedure setParams(var pQry: TFDQuery; pGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel);
    function ObterLista: IFDDataset; overload;

end;

implementation

uses
  Data.DB, System.Rtti;

{ TPCG }

function TGrupoComissaoFuncionarioDao.carregaClasse(pID: String): TGrupoComissaoFuncionarioModel;
var
  lQry: TFDQuery;
  lModel: TGrupoComissaoFuncionarioModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TGrupoComissaoFuncionarioModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from funcionario_grupo_comissao where id = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID       		      := lQry.FieldByName('ID').AsString;
    lModel.GRUPO_COMISSAO_ID  := lQry.FieldByName('GRUPO_COMISSAO_ID').AsString;
    lModel.FUNCIONARIO_ID     := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.PERCENTUAL       	:= lQry.FieldByName('PERCENTUAL').AsString;
    lModel.SYSTIME       		  := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TGrupoComissaoFuncionarioDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TGrupoComissaoFuncionarioDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TGrupoComissaoFuncionarioDao.incluir(pGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('FUNCIONARIO_GRUPO_COMISSAO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pGrupoComissaoFuncionarioModel.ID := vIConexao.Generetor('GEN_FUNCIONARIO_GRUPO_COMISSAO');
    setParams(lQry, pGrupoComissaoFuncionarioModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoComissaoFuncionarioDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := '  select '+lPaginacao+'                          '+sLineBreak+
            '         id,                                     '+sLineBreak+
            '         grupo_comissao_id,                      '+sLineBreak+
            '         funcionario_id,                         '+sLineBreak+
            '         percentual,                             '+sLineBreak+
            '         systime                                 '+sLineBreak+
            '    from funcionario_grupo_comissao              '+sLineBreak+
            '   where 1=1 ';

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutorDao.atribuirRegistros(lQry);
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

function TGrupoComissaoFuncionarioDao.alterar(pGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('FUNCIONARIO_GRUPO_COMISSAO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoComissaoFuncionarioModel);
    lQry.ExecSQL;

    Result := pGrupoComissaoFuncionarioModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoComissaoFuncionarioDao.excluir(pGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from FUNCIONARIO_GRUPO_COMISSAO where ID = :ID' ,[pGrupoComissaoFuncionarioModel.ID]);
   lQry.ExecSQL;
   Result := pGrupoComissaoFuncionarioModel.ID;

  finally
    lQry.Free;
  end;
end;

function TGrupoComissaoFuncionarioDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TGrupoComissaoFuncionarioDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From FUNCIONARIO_GRUPO_COMISSAO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;


procedure TGrupoComissaoFuncionarioDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoComissaoFuncionarioDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoComissaoFuncionarioDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoComissaoFuncionarioDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TGrupoComissaoFuncionarioDao.setParams(var pQry: TFDQuery; pGrupoComissaoFuncionarioModel: TGrupoComissaoFuncionarioModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('FUNCIONARIO_GRUPO_COMISSAO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TGrupoComissaoFuncionarioModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pGrupoComissaoFuncionarioModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pGrupoComissaoFuncionarioModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TGrupoComissaoFuncionarioDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TGrupoComissaoFuncionarioDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TGrupoComissaoFuncionarioDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;


end.
