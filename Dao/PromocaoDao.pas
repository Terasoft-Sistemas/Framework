unit PromocaoDao;

interface

uses
  PromocaoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  Terasoft.Utils;

type
  TPromocaoDao = class;
  ITPromocaoDao=IObject<TPromocaoDao>;

  TPromocaoDao = class
  private
    [weak] mySelf: ITPromocaoDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPromocaosLista: IList<ITPromocaoModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    FCodProdutoView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetPromocaosLista(const Value: IList<ITPromocaoModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

    procedure setParams(var pQry: TFDQuery; pPromocaoModel: ITPromocaoModel);
    procedure SetCodProdutoView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPromocaoDao;

    property PromocaosLista: IList<ITPromocaoModel> read FPromocaosLista write SetPromocaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property CodProdutoView : String read FCodProdutoView write SetCodProdutoView;

    function incluir(pPromocaoModel: ITPromocaoModel): String;
    function alterar(pPromocaoModel: ITPromocaoModel): String;
    function excluir(pPromocaoModel: ITPromocaoModel): String;
    function carregaClasse(pID : String) : ITPromocaoModel;
    procedure obterLista;

end;

implementation

uses
  System.Rtti;

{ TPromocao }

function TPromocaoDao.carregaClasse(pID: String): ITPromocaoModel;
var
  lQry: TFDQuery;
  lModel: ITPromocaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPromocaoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PROMOCAO where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;
    lModel.objeto.DESCRICAO        := lQry.FieldByName('DESCRICAO').AsString;
    lModel.objeto.DATA             := lQry.FieldByName('DATA').AsString;
    lModel.objeto.DATAINICIO       := lQry.FieldByName('DATAINICIO').AsString;
    lModel.objeto.DATAFIM          := lQry.FieldByName('DATAFIM').AsString;
    lModel.objeto.CLIENTE_ID       := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.objeto.PRECO_VENDA_ID   := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.objeto.HORAINICIO       := lQry.FieldByName('HORAINICIO').AsString;
    lModel.objeto.HORAFIM          := lQry.FieldByName('HORAFIM').AsString;
    lModel.objeto.DOMINGO          := lQry.FieldByName('DOMINGO').AsString;
    lModel.objeto.SEGUNDA          := lQry.FieldByName('SEGUNDA').AsString;
    lModel.objeto.TERCA            := lQry.FieldByName('TERCA').AsString;
    lModel.objeto.QUARTA           := lQry.FieldByName('QUARTA').AsString;
    lModel.objeto.QUINTA           := lQry.FieldByName('QUINTA').AsString;
    lModel.objeto.SEXTA            := lQry.FieldByName('SEXTA').AsString;
    lModel.objeto.SABADO           := lQry.FieldByName('SABADO').AsString;
    lModel.objeto.PORTADOR_ID      := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.LOJA             := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.TIPO_ABATIMENTO  := lQry.FieldByName('TIPO_ABATIMENTO').AsString;
    lModel.objeto.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TPromocaoDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TPromocaoDao.Destroy;
begin
  FPromocaosLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TPromocaoDao.incluir(pPromocaoModel: ITPromocaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := vConstrutor.gerarInsert('PROMOCAO', 'ID', true);
    lQry.SQL.Add(lSQL);
    pPromocaoModel.objeto.ID := vIConexao.Generetor('GEN_PROMOCAO');
    setParams(lQry, pPromocaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPromocaoDao.alterar(pPromocaoModel: ITPromocaoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PROMOCAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPromocaoModel);
    lQry.ExecSQL;

    Result := pPromocaoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPromocaoDao.excluir(pPromocaoModel: ITPromocaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from promocao where ID = :ID',[pPromocaoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pPromocaoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TPromocaoDao.getNewIface(pIConexao: IConexao): ITPromocaoDao;
begin
  Result := TImplObjetoOwner<TPromocaoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPromocaoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and promocao.id = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TPromocaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From promocao where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPromocaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo : ITPromocaoModel;
begin
  lQry := vIConexao.CriarQuery;

  FPromocaosLista := TCollections.CreateList<ITPromocaoModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

      lSql := lSql +'       id,                '+sLineBreak+
                    '       descricao,         '+sLineBreak+
                    '       data,              '+sLineBreak+
                    '       datainicio,        '+sLineBreak+
                    '       datafim,           '+sLineBreak+
                    '       cliente_id,        '+sLineBreak+
                    '       preco_venda_id,    '+sLineBreak+
                    '       horainicio,        '+sLineBreak+
                    '       horafim,           '+sLineBreak+
                    '       domingo,           '+sLineBreak+
                    '       segunda,           '+sLineBreak+
                    '       terca,             '+sLineBreak+
                    '       quarta,            '+sLineBreak+
                    '       quinta,            '+sLineBreak+
                    '       sexta,             '+sLineBreak+
                    '       sabado,            '+sLineBreak+
                    '       portador_id,       '+sLineBreak+
                    '       loja,              '+sLineBreak+
                    '       tipo_abatimento    '+sLineBreak+
                    '  from promocao           '+sLineBreak+
                    ' where 1=1                '+sLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPromocaoModel.getNewIface(vIConexao);
      FPromocaosLista.Add(modelo);

      modelo.objeto.ID              := lQry.FieldByName('ID').AsString;
      modelo.objeto.DESCRICAO       := lQry.FieldByName('DESCRICAO').AsString;
      modelo.objeto.DATA            := lQry.FieldByName('DATA').AsString;
      modelo.objeto.DATAINICIO      := lQry.FieldByName('DATAINICIO').AsString;
      modelo.objeto.DATAFIM         := lQry.FieldByName('DATAFIM').AsString;
      modelo.objeto.CLIENTE_ID      := lQry.FieldByName('CLIENTE_ID').AsString;
      modelo.objeto.PRECO_VENDA_ID  := lQry.FieldByName('PRECO_VENDA_ID').AsString;
      modelo.objeto.HORAINICIO      := lQry.FieldByName('HORAINICIO').AsString;
      modelo.objeto.HORAFIM         := lQry.FieldByName('HORAFIM').AsString;
      modelo.objeto.DOMINGO         := lQry.FieldByName('DOMINGO').AsString;
      modelo.objeto.SEGUNDA         := lQry.FieldByName('SEGUNDA').AsString;
      modelo.objeto.TERCA           := lQry.FieldByName('TERCA').AsString;
      modelo.objeto.QUARTA          := lQry.FieldByName('QUARTA').AsString;
      modelo.objeto.QUINTA          := lQry.FieldByName('QUINTA').AsString;
      modelo.objeto.SEXTA           := lQry.FieldByName('SEXTA').AsString;
      modelo.objeto.SABADO          := lQry.FieldByName('SABADO').AsString;
      modelo.objeto.PORTADOR_ID     := lQry.FieldByName('PORTADOR_ID').AsString;
      modelo.objeto.LOJA            := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.TIPO_ABATIMENTO := lQry.FieldByName('TIPO_ABATIMENTO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPromocaoDao.SetCodProdutoView(const Value: String);
begin
  FCodProdutoView := Value;
end;

procedure TPromocaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPromocaoDao.SetPromocaosLista;
begin
  FPromocaosLista := Value;
end;

procedure TPromocaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPromocaoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPromocaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPromocaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPromocaoDao.setParams(var pQry: TFDQuery; pPromocaoModel: ITPromocaoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PROMOCAO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPromocaoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPromocaoModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPromocaoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPromocaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPromocaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPromocaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
