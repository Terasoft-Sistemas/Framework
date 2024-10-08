unit GrupoGarantiaDao;

interface

uses
  GrupoGarantiaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TGrupoGarantiaDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

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
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pGrupoGarantiaModel: TGrupoGarantiaModel): String;
    function alterar(pGrupoGarantiaModel: TGrupoGarantiaModel): String;
    function excluir(pGrupoGarantiaModel: TGrupoGarantiaModel): String;

    function carregaClasse(pID : String): TGrupoGarantiaModel;
    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pGrupoGarantiaModel: TGrupoGarantiaModel);

end;

implementation

uses
  System.Rtti;

{ TGrupoGarantia }

function TGrupoGarantiaDao.carregaClasse(pID : String): TGrupoGarantiaModel;
var
  lQry: TFDQuery;
  lModel: TGrupoGarantiaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TGrupoGarantiaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from Grupo_Garantia where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID          := lQry.FieldByName('ID').AsString;
    lModel.NOME        := lQry.FieldByName('NOME').AsString;
    lModel.SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TGrupoGarantiaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TGrupoGarantiaDao.Destroy;
begin
  inherited;
end;

function TGrupoGarantiaDao.incluir(pGrupoGarantiaModel: TGrupoGarantiaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('GRUPO_GARANTIA', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoGarantiaModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoGarantiaDao.alterar(pGrupoGarantiaModel: TGrupoGarantiaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('GRUPO_GARANTIA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoGarantiaModel);
    lQry.ExecSQL;

    Result := pGrupoGarantiaModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoGarantiaDao.excluir(pGrupoGarantiaModel: TGrupoGarantiaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from Grupo_Garantia where ID = :ID' ,[pGrupoGarantiaModel.ID]);
   lQry.ExecSQL;
   Result := pGrupoGarantiaModel.ID;

  finally
    lQry.Free;
  end;
end;

function TGrupoGarantiaDao.where: String;
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

procedure TGrupoGarantiaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From Grupo_Garantia where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TGrupoGarantiaDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+' * from Grupo_Garantia where 1=1 '+SLineBreak;


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

procedure TGrupoGarantiaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoGarantiaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoGarantiaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoGarantiaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoGarantiaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TGrupoGarantiaDao.setParams(var pQry: TFDQuery; pGrupoGarantiaModel: TGrupoGarantiaModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('Grupo_Garantia');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TGrupoGarantiaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pGrupoGarantiaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pGrupoGarantiaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TGrupoGarantiaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TGrupoGarantiaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TGrupoGarantiaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
