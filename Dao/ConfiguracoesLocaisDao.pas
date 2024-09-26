unit ConfiguracoesLocaisDao;

interface

uses
  ConfiguracoesLocaisModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  Terasoft.Types,
  Terasoft.Utils;

type
  TConfiguracoesLocaisDao = class;

  ITConfiguracoesLocaisDao = IObject<TConfiguracoesLocaisDao>;

  TConfiguracoesLocaisDao = class

  private
    [unsafe] myself : ITConfiguracoesLocaisDao;
    vIConexao     : IConexao;
    vConstrutor   : IConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao: IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITConfiguracoesLocaisDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AConfiguracoesLocaisModel: ITConfiguracoesLocaisModel): String;
    function alterar(AConfiguracoesLocaisModel: ITConfiguracoesLocaisModel): String;
    function excluir(AConfiguracoesLocaisModel: ITConfiguracoesLocaisModel): String;

	  procedure obterTotalRegistros;
    function obterLista: IFDDataset;
    procedure setParams(var pQry: TFDQuery; pConfiguracoesLocaisModel: ITConfiguracoesLocaisModel);

    function carregaClasse(pId: String): ITConfiguracoesLocaisModel;

end;

implementation

uses
  System.Rtti, Terasoft.Configuracoes;

{ TConfiguracoesLocais }

function TConfiguracoesLocaisDao.carregaClasse(pId: String): ITConfiguracoesLocaisModel;
var
  lQry: TFDQuery;
  lModel: ITConfiguracoesLocaisModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TConfiguracoesLocaisModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CONFIGURACOESLOCAIS where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID            := lQry.FieldByName('ID').AsString;
    lModel.objeto.TAG           := lQry.FieldByName('TAG').AsString;
    lModel.objeto.F_ID          := lQry.FieldByName('FID').AsString;
    lModel.objeto.PERFIL_ID     := lQry.FieldByName('PERFIL_ID').AsString;
    lModel.objeto.VALORINTEIRO  := lQry.FieldByName('VALORINTEIRO').AsString;
    lModel.objeto.VALORSTRING   := lQry.FieldByName('VALORSTRING').AsString;
    lModel.objeto.VALORMEMO     := lQry.FieldByName('VALORMEMO').AsString;
    lModel.objeto.VALORNUMERICO := lQry.FieldByName('VALORNUMERICO').AsString;
    lModel.objeto.VALORCHAR     := lQry.FieldByName('VALORCHAR').AsString;
    lModel.objeto.VALORDATA     := lQry.FieldByName('VALORDATA').AsString;
    lModel.objeto.VALORHORA     := lQry.FieldByName('VALORHORA').AsString;
    lModel.objeto.VALORDATAHORA := lQry.FieldByName('VALORDATAHORA').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TConfiguracoesLocaisDao.Create(pIConexao: IConexao);
begin
  vIConexao  := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TConfiguracoesLocaisDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

class function TConfiguracoesLocaisDao.getNewIface(pIConexao: IConexao): ITConfiguracoesLocaisDao;
begin
  Result := TImplObjetoOwner<TConfiguracoesLocaisDao>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TConfiguracoesLocaisDao.incluir(AConfiguracoesLocaisModel: ITConfiguracoesLocaisModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('CONFIGURACOESLOCAIS', 'ID', true);
  try
    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    lQry.SQL.Add(lSQL);
    AConfiguracoesLocaisModel.objeto.ID := vIConexao.Generetor('GEN_CONFIGURACOESLOCAIS', true);
    setParams(lQry, AConfiguracoesLocaisModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TConfiguracoesLocaisDao.alterar(AConfiguracoesLocaisModel: ITConfiguracoesLocaisModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CONFIGURACOESLOCAIS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AConfiguracoesLocaisModel);
    lQry.ExecSQL;

    Result := AConfiguracoesLocaisModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TConfiguracoesLocaisDao.excluir(AConfiguracoesLocaisModel: ITConfiguracoesLocaisModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CONFIGURACOESLOCAIS where ID = :ID',[AConfiguracoesLocaisModel.objeto.ID]);
   lQry.ExecSQL;
   Result := AConfiguracoesLocaisModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

function TConfiguracoesLocaisDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and CONFIGURACOESLOCAIS.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TConfiguracoesLocaisDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CONFIGURACOESLOCAIS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TConfiguracoesLocaisDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                           '+SLineBreak+
              '         CONFIGURACOESLOCAIS.ID,                                          '+SLineBreak+
              '         CONFIGURACOESLOCAIS.TAG,                                         '+SLineBreak+
              '         CONFIGURACOESLOCAIS.FID,                                         '+SLineBreak+
              '         CONFIGURACOESLOCAIS.PERFIL_ID,                                   '+SLineBreak+
              '         CONFIGURACOESLOCAIS.VALORINTEIRO,                                '+SLineBreak+
              '         CONFIGURACOESLOCAIS.VALORSTRING,                                 '+SLineBreak+
              '         CONFIGURACOESLOCAIS.VALORMEMO,                                   '+SLineBreak+
              '         CONFIGURACOESLOCAIS.VALORNUMERICO,                               '+SLineBreak+
              '         CONFIGURACOESLOCAIS.VALORCHAR,                                   '+SLineBreak+
              '         CONFIGURACOESLOCAIS.VALORDATA,                                   '+SLineBreak+
              '         CONFIGURACOESLOCAIS.VALORHORA,                                   '+SLineBreak+
              '         CONFIGURACOESLOCAIS.VALORDATAHORA                                '+SLineBreak+
              '    from CONFIGURACOESLOCAIS                                              '+SLineBreak+
              '   where 1=1                                                              '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TConfiguracoesLocaisDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TConfiguracoesLocaisDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TConfiguracoesLocaisDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TConfiguracoesLocaisDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TConfiguracoesLocaisDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TConfiguracoesLocaisDao.setParams(var pQry: TFDQuery; pConfiguracoesLocaisModel: ITConfiguracoesLocaisModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONFIGURACOESLOCAIS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TConfiguracoesLocaisModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pConfiguracoesLocaisModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pConfiguracoesLocaisModel.objeto).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TConfiguracoesLocaisDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TConfiguracoesLocaisDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TConfiguracoesLocaisDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
