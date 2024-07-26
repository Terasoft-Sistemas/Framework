unit PromocaoItensDao;
interface
uses
  PromocaoItensModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao,
  Terasoft.Utils;

type
  TPromocaoItensDao = class;
  ITPromocaoItensDao=IObject<TPromocaoItensDao>;

  TPromocaoItensDao = class
  private
    [weak] mySelf: ITPromocaoItensDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;
    FPromocaoItenssLista: IList<ITPromocaoItensModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FProdutoView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPromocaoItenssLista(const Value: IList<ITPromocaoItensModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function montaCondicaoQuery: String;
    procedure setParams(var pQry: TFDQuery; pPromocaoItensModel: ITPromocaoItensModel);
    procedure SetProdutoView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPromocaoItensDao;

    property PromocaoItenssLista: IList<ITPromocaoItensModel> read FPromocaoItenssLista write SetPromocaoItenssLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property ProdutoView : String read FProdutoView write SetProdutoView;

    function incluir(pPromocaoItensModel: ITPromocaoItensModel): String;
    function alterar(pPromocaoItensModel: ITPromocaoItensModel): String;
    function excluir(pPromocaoItensModel: ITPromocaoItensModel): String;
    function carregaClasse(pID : String) : ITPromocaoItensModel;
    procedure obterLista;
end;
implementation

uses
  System.Rtti;
{ TPromocaoItens }
function TPromocaoItensDao.carregaClasse(pID: String): ITPromocaoItensModel;
var
  lQry: TFDQuery;
  lModel: ITPromocaoItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPromocaoItensModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PROMOCAOITENS where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;
    lModel.objeto.PROMOCAO_ID      := lQry.FieldByName('PROMOCAO_ID').AsString;
    lModel.objeto.PRODUTO_ID       := lQry.FieldByName('PRODUTO_ID').AsString;
    lModel.objeto.VALOR_PROMOCAO   := lQry.FieldByName('VALOR_PROMOCAO').AsString;
    lModel.objeto.SALDO            := lQry.FieldByName('SALDO').AsString;
    lModel.objeto.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TPromocaoItensDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPromocaoItensDao.Destroy;
begin
  FPromocaoItenssLista:=nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TPromocaoItensDao.incluir(pPromocaoItensModel: ITPromocaoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := vConstrutor.gerarInsert('PROMOCAOITENS', 'ID', true);
    lQry.SQL.Add(lSQL);
    pPromocaoItensModel.objeto.ID := vIConexao.Generetor('GEN_PROMOCAOITENS');
    setParams(lQry, pPromocaoItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPromocaoItensDao.alterar(pPromocaoItensModel: ITPromocaoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PROMOCAOITENS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPromocaoItensModel);
    lQry.ExecSQL;

    Result := pPromocaoItensModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPromocaoItensDao.excluir(pPromocaoItensModel: ITPromocaoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from promocaoitens where ID = :ID',[pPromocaoItensModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pPromocaoItensModel.objeto.ID;
  finally
    lQry.Free;
  end;
end;

class function TPromocaoItensDao.getNewIface(pIConexao: IConexao): ITPromocaoItensDao;
begin
  Result := TImplObjetoOwner<TPromocaoItensDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPromocaoItensDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and promocaoitens.id = '+IntToStr(FIDRecordView);

  if not FProdutoView.IsEmpty then
    lSQL := lSQL + ' and promocaoitens.produto_id = '+QuotedStr(FProdutoView);

  Result := lSQL;
end;
procedure TPromocaoItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := '  select count(*) records                                         '+
            '    From promocaoitens                                            '+
            '   inner join promocao on promocaoitens.promocao_id = promocao.id '+
            '   where 1=1 ';
    lSql := lSql + montaCondicaoQuery;
    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;
procedure TPromocaoItensDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITPromocaoItensModel;
begin
  lQry := vIConexao.CriarQuery;
  FPromocaoItenssLista := TCollections.CreateList<ITPromocaoItensModel>;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSql := lSql +  '       promocaoitens.id,                                        '+sLineBreak+
                    '       promocaoitens.promocao_id,                               '+sLineBreak+
                    '       promocaoitens.produto_id,                                '+sLineBreak+
                    '       promocaoitens.valor_promocao,                            '+sLineBreak+
                    '       promocaoitens.saldo                                      '+sLineBreak+
                    '       from promocaoitens                                       '+sLineBreak+
                    ' inner join promocao on promocaoitens.promocao_id = promocao.id '+sLineBreak+
                    ' where 1=1                                                      '+sLineBreak;

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPromocaoItensModel.getNewIface(vIConexao);
      FPromocaoItenssLista.Add(modelo);

      modelo.objeto.ID              := lQry.FieldByName('ID').AsString;
      modelo.objeto.PROMOCAO_ID     := lQry.FieldByName('PROMOCAO_ID').AsString;
      modelo.objeto.PRODUTO_ID      := lQry.FieldByName('PRODUTO_ID').AsString;
      modelo.objeto.VALOR_PROMOCAO  := lQry.FieldByName('VALOR_PROMOCAO').AsString;
      modelo.objeto.SALDO           := lQry.FieldByName('SALDO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;
procedure TPromocaoItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;
procedure TPromocaoItensDao.SetProdutoView(const Value: String);
begin
  FProdutoView := Value;
end;

procedure TPromocaoItensDao.SetPromocaoItenssLista;
begin
  FPromocaoItenssLista := Value;
end;
procedure TPromocaoItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;
procedure TPromocaoItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;
procedure TPromocaoItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;
procedure TPromocaoItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPromocaoItensDao.setParams(var pQry: TFDQuery; pPromocaoItensModel: ITPromocaoItensModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PROMOCAOITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPromocaoItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPromocaoItensModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPromocaoItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPromocaoItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TPromocaoItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TPromocaoItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
end.
