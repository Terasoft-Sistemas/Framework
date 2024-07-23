unit ComissaoVendedorDao;

interface

uses
  AdmCartaoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  ComissaoVendedorModel;

type
  TComissaoVendedorDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

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

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pComissaoVendedorModel: TComissaoVendedorModel): String;
    function alterar(pComissaoVendedorModel: TComissaoVendedorModel): String;
    function excluir(pComissaoVendedorModel: TComissaoVendedorModel): String;

	  procedure obterTotalRegistros;
    function obterLista: IFDDataset;
    procedure setParams(var pQry: TFDQuery; pComissaoVendedorModel: TComissaoVendedorModel);

    function carregaClasse(pId: String): TComissaoVendedorModel;

end;

implementation

uses
  System.Rtti;

{ TComissaoVendedor }

function TComissaoVendedorDao.carregaClasse(pId: String): TComissaoVendedorModel;
var
  lQry: TFDQuery;
  lModel: TComissaoVendedorModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TComissaoVendedorModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from comissao_vendedor where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                   := lQry.FieldByName('ID').AsString;
    lModel.VENDEDOR             := lQry.FieldByName('VENDEDOR').AsString;
    lModel.TIPO_VENDA           := lQry.FieldByName('TIPO_VENDA').AsString;
    lModel.COMISSAO             := lQry.FieldByName('COMISSAO').AsString;
    lModel.DESCONTO_MAXIMO      := lQry.FieldByName('DESCONTO_MAXIMO').AsString;
    lModel.ABATIMENTO_COMISSAO  := lQry.FieldByName('ABATIMENTO_COMISSAO').AsString;
    lModel.TIPO_COMISSAO        := lQry.FieldByName('TIPO_COMISSAO').AsString;
    lModel.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TComissaoVendedorDao.Create(pIConexao: IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TComissaoVendedorDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TComissaoVendedorDao.incluir(pComissaoVendedorModel: TComissaoVendedorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('COMISSAO_VENDEDOR', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pComissaoVendedorModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TComissaoVendedorDao.alterar(pComissaoVendedorModel: TComissaoVendedorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('COMISSAO_VENDEDOR', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pComissaoVendedorModel);
    lQry.ExecSQL;

    Result := pComissaoVendedorModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TComissaoVendedorDao.excluir(pComissaoVendedorModel: TComissaoVendedorModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from comissao_vendedor where ID = :ID',[pComissaoVendedorModel.ID]);
   Result := pComissaoVendedorModel.ID;

  finally
    lQry.Free;
  end;
end;

function TComissaoVendedorDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and comissao_vendedor.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TComissaoVendedorDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From comissao_vendedor where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TComissaoVendedorDao.obterLista: IFDDataset;
var
  lQry : TFDQuery;
  lSQL : String;
  i    : INteger;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       comissao_vendedor.*       '+
	    '  from comissao_vendedor         '+
      ' where 1=1                       ';

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

procedure TComissaoVendedorDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TComissaoVendedorDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TComissaoVendedorDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TComissaoVendedorDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TComissaoVendedorDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TComissaoVendedorDao.setParams(var pQry: TFDQuery; pComissaoVendedorModel: TComissaoVendedorModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('COMISSAO_VENDEDOR');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TComissaoVendedorModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pComissaoVendedorModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pComissaoVendedorModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TComissaoVendedorDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TComissaoVendedorDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TComissaoVendedorDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
