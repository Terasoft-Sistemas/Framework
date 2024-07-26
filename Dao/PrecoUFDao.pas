unit PrecoUFDao;
interface
uses
  PrecoUFModel,
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
  TPrecoUFDao = class;
  ITPrecoUFDao=IObject<TPrecoUFDao>;

  TPrecoUFDao = class
  private
    [weak] mySelf: ITPrecoUFDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPrecoUFsLista: IList<ITPrecoUFModel>;
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
    procedure SetPrecoUFsLista(const Value: IList<ITPrecoUFModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPrecoUfModel: ITPrecoUfModel);
    function where: String;

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPrecoUFDao;

    property PrecoUFsLista: IList<ITPrecoUFModel> read FPrecoUFsLista write SetPrecoUFsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pPrecoUFModel: ITPrecoUFModel): String;
    function alterar(pPrecoUFModel: ITPrecoUFModel): String;
    function excluir(pPrecoUFModel: ITPrecoUFModel): String;
    function carregaClasse(ID: String): ITPrecoUFModel;
    procedure obterLista;
end;
implementation

uses
  System.Rtti;
{ TPrecoUF }
function TPrecoUFDao.carregaClasse(ID: String): ITPrecoUFModel;
var
  lQry: TFDQuery;
  lModel: ITPrecoUFModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPrecoUFModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PRECO_UF where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID          := lQry.FieldByName('ID').AsString;
    lModel.objeto.PRODUTO_ID  := lQry.FieldByName('PRODUTO_ID').AsString;
    lModel.objeto.UF          := lQry.FieldByName('UF').AsString;
    lModel.objeto.COMISSAO    := lQry.FieldByName('COMISSAO').AsString;
    lModel.objeto.SIMPLES     := lQry.FieldByName('SIMPLES').AsString;
    lModel.objeto.ICMS_ST     := lQry.FieldByName('ICMS_ST').AsString;
    lModel.objeto.SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TPrecoUFDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;
destructor TPrecoUFDao.Destroy;
begin
  FPrecoUFsLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TPrecoUFDao.incluir(pPrecoUFModel: ITPrecoUFModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PRECO_UF', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pPrecoUFModel.objeto.ID := vIConexao.Generetor('GEN_PRECO_UF');
    setParams(lQry, pPrecoUFModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPrecoUFDao.alterar(pPrecoUFModel: ITPrecoUFModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PRECO_UF', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPrecoUFModel);
    lQry.ExecSQL;

    Result := pPrecoUFModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;
function TPrecoUFDao.excluir(pPrecoUFModel: ITPrecoUFModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from preco_uf where ID = :ID',[pPrecoUFModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pPrecoUFModel.objeto.ID;
  finally
    lQry.Free;
  end;
end;
class function TPrecoUFDao.getNewIface(pIConexao: IConexao): ITPrecoUFDao;
begin
  Result := TImplObjetoOwner<TPrecoUFDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPrecoUFDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';
  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;
  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and preco_uf.id = '+IntToStr(FIDRecordView);
  Result := lSQL;
end;
procedure TPrecoUFDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := 'select count(*) records From preco_uf where 1=1 ';
    lSql := lSql + where;
    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;
procedure TPrecoUFDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITPrecoUFModel;
begin
  lQry := vIConexao.CriarQuery;
  FPrecoUFsLista := TCollections.CreateList<ITPrecoUFModel>;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';
    lSQL := lSQL +
      '       preco_uf.*,                                              '+
      '       produto.customedio_pro,                                  '+
      '       produto.margem_pro                                       '+
	    '  from preco_uf                                                 '+
      ' inner join produto on preco_uf.produto_id = produto.codigo_pro '+
      ' where 1=1                                                      ';
    lSql := lSql + where;
    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;
    lQry.Open(lSQL);
    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPrecoUFModel.getNewIface(vIConexao);
      FPrecoUFsLista.Add(modelo);

      modelo.objeto.ID         := lQry.FieldByName('ID').AsString;
      modelo.objeto.PRODUTO_ID := lQry.FieldByName('PRODUTO_ID').AsString;
      modelo.objeto.UF         := lQry.FieldByName('UF').AsString;
      modelo.objeto.COMISSAO   := lQry.FieldByName('COMISSAO').AsString;
      modelo.objeto.SIMPLES    := lQry.FieldByName('SIMPLES').AsString;
      modelo.objeto.ICMS_ST    := lQry.FieldByName('ICMS_ST').AsString;
      modelo.objeto.SYSTIME    := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.TOTAL      := (lQry.FieldByName('CUSTOMEDIO_PRO').AsFloat * lQry.FieldByName('MARGEM_PRO').AsFloat / 100 + lQry.FieldByName('CUSTOMEDIO_PRO').AsFloat) /
                                      ( (100 - (lQry.FieldByName('COMISSAO').AsFloat + lQry.FieldByName('SIMPLES').AsFloat + lQry.FieldByName('ICMS_ST').AsFloat) ) / 100);
      lQry.Next;
    end;
    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;
procedure TPrecoUFDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TPrecoUFDao.SetPrecoUFsLista;
begin
  FPrecoUFsLista := Value;
end;
procedure TPrecoUFDao.SetID(const Value: Variant);
begin
  FID := Value;
end;
procedure TPrecoUFDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;
procedure TPrecoUFDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;
procedure TPrecoUFDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPrecoUFDao.setParams(var pQry: TFDQuery; pPrecoUfModel: ITPrecoUfModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PRECO_UF');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPrecoUfModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPrecoUfModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPrecoUfModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPrecoUFDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TPrecoUFDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TPrecoUFDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
end.
