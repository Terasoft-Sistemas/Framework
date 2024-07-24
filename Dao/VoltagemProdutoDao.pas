unit VoltagemProdutoDao;

interface

uses
  VoltagemProdutoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TVoltagemProdutoDao = class

  private
    vIConexao 	: IConexao;
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

    function incluir(pVoltagemProdutoModel: TVoltagemProdutoModel): String;
    function alterar(pVoltagemProdutoModel: TVoltagemProdutoModel): String;
    function excluir(pVoltagemProdutoModel: TVoltagemProdutoModel): String;

    function carregaClasse(pID : String): TVoltagemProdutoModel;
    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pVoltagemProdutoModel: TVoltagemProdutoModel);

end;

implementation

uses
  System.Rtti;

{ TVoltagemProduto }

function TVoltagemProdutoDao.carregaClasse(pID : String): TVoltagemProdutoModel;
var
  lQry: TFDQuery;
  lModel: TVoltagemProdutoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TVoltagemProdutoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from voltagem_produto where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID               := lQry.FieldByName('ID').AsString;
    lModel.DESCRICAO        := lQry.FieldByName('DESCRICAO').AsString;
    lModel.DATA_CADASTRO    := lQry.FieldByName('DATA_CADASTRO').AsString;
    lModel.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TVoltagemProdutoDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TVoltagemProdutoDao.Destroy;
begin
  inherited;
end;

function TVoltagemProdutoDao.incluir(pVoltagemProdutoModel: TVoltagemProdutoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('VOLTAGEM_PRODUTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pVoltagemProdutoModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TVoltagemProdutoDao.alterar(pVoltagemProdutoModel: TVoltagemProdutoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSql :=  vconstrutor.gerarupdate('voltagem_produto','id');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pVoltagemProdutoModel);
    lQry.ExecSQL;

    Result := pVoltagemProdutoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TVoltagemProdutoDao.excluir(pVoltagemProdutoModel: TVoltagemProdutoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from voltagem_produto where ID = :ID' ,[pVoltagemProdutoModel.ID]);
   lQry.ExecSQL;
   Result := pVoltagemProdutoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TVoltagemProdutoDao.where: String;
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

procedure TVoltagemProdutoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From voltagem_produto where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TVoltagemProdutoDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+'     '+SLineBreak+
              '          id,               '+SLineBreak+
              '          descricao,        '+SLineBreak+
              '          data_cadastro,    '+SLineBreak+
              '          systime           '+SLineBreak+
              '     from voltagem_produto  '+SLineBreak+
              '    where 1=1               '+SLineBreak;

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

procedure TVoltagemProdutoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVoltagemProdutoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TVoltagemProdutoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TVoltagemProdutoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVoltagemProdutoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TVoltagemProdutoDao.setParams(var pQry: TFDQuery; pVoltagemProdutoModel: TVoltagemProdutoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('Voltagem_Produto');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TVoltagemProdutoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pVoltagemProdutoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pVoltagemProdutoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TVoltagemProdutoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TVoltagemProdutoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TVoltagemProdutoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
