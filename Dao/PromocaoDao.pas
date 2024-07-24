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
  Terasoft.Utils;

type
  TPromocaoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPromocaosLista: IList<TPromocaoModel>;
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
    procedure SetPromocaosLista(const Value: IList<TPromocaoModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

    procedure setParams(var pQry: TFDQuery; pPromocaoModel: TPromocaoModel);
    procedure SetCodProdutoView(const Value: String);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property PromocaosLista: IList<TPromocaoModel> read FPromocaosLista write SetPromocaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property CodProdutoView : String read FCodProdutoView write SetCodProdutoView;

    function incluir(pPromocaoModel: TPromocaoModel): String;
    function alterar(pPromocaoModel: TPromocaoModel): String;
    function excluir(pPromocaoModel: TPromocaoModel): String;
    function carregaClasse(pID : String) : TPromocaoModel;
    procedure obterLista;

end;

implementation

uses
  System.Rtti;

{ TPromocao }

function TPromocaoDao.carregaClasse(pID: String): TPromocaoModel;
var
  lQry: TFDQuery;
  lModel: TPromocaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPromocaoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PROMOCAO where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID               := lQry.FieldByName('ID').AsString;
    lModel.DESCRICAO        := lQry.FieldByName('DESCRICAO').AsString;
    lModel.DATA             := lQry.FieldByName('DATA').AsString;
    lModel.DATAINICIO       := lQry.FieldByName('DATAINICIO').AsString;
    lModel.DATAFIM          := lQry.FieldByName('DATAFIM').AsString;
    lModel.CLIENTE_ID       := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.PRECO_VENDA_ID   := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.HORAINICIO       := lQry.FieldByName('HORAINICIO').AsString;
    lModel.HORAFIM          := lQry.FieldByName('HORAFIM').AsString;
    lModel.DOMINGO          := lQry.FieldByName('DOMINGO').AsString;
    lModel.SEGUNDA          := lQry.FieldByName('SEGUNDA').AsString;
    lModel.TERCA            := lQry.FieldByName('TERCA').AsString;
    lModel.QUARTA           := lQry.FieldByName('QUARTA').AsString;
    lModel.QUINTA           := lQry.FieldByName('QUINTA').AsString;
    lModel.SEXTA            := lQry.FieldByName('SEXTA').AsString;
    lModel.SABADO           := lQry.FieldByName('SABADO').AsString;
    lModel.PORTADOR_ID      := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.LOJA             := lQry.FieldByName('LOJA').AsString;
    lModel.TIPO_ABATIMENTO  := lQry.FieldByName('TIPO_ABATIMENTO').AsString;
    lModel.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TPromocaoDao.Create(pIConexao : IConexao);
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

function TPromocaoDao.incluir(pPromocaoModel: TPromocaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := vConstrutor.gerarInsert('PROMOCAO', 'ID', true);
    lQry.SQL.Add(lSQL);
    pPromocaoModel.ID := vIConexao.Generetor('GEN_PROMOCAO');
    setParams(lQry, pPromocaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPromocaoDao.alterar(pPromocaoModel: TPromocaoModel): String;
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

    Result := pPromocaoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPromocaoDao.excluir(pPromocaoModel: TPromocaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from promocao where ID = :ID',[pPromocaoModel.ID]);
   lQry.ExecSQL;
   Result := pPromocaoModel.ID;

  finally
    lQry.Free;
  end;
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
  modelo : TPromocaoModel;
begin
  lQry := vIConexao.CriarQuery;

  FPromocaosLista := TCollections.CreateList<TPromocaoModel>(true);

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
      modelo := TPromocaoModel.Create(vIConexao);
      FPromocaosLista.Add(modelo);

      modelo.ID              := lQry.FieldByName('ID').AsString;
      modelo.DESCRICAO       := lQry.FieldByName('DESCRICAO').AsString;
      modelo.DATA            := lQry.FieldByName('DATA').AsString;
      modelo.DATAINICIO      := lQry.FieldByName('DATAINICIO').AsString;
      modelo.DATAFIM         := lQry.FieldByName('DATAFIM').AsString;
      modelo.CLIENTE_ID      := lQry.FieldByName('CLIENTE_ID').AsString;
      modelo.PRECO_VENDA_ID  := lQry.FieldByName('PRECO_VENDA_ID').AsString;
      modelo.HORAINICIO      := lQry.FieldByName('HORAINICIO').AsString;
      modelo.HORAFIM         := lQry.FieldByName('HORAFIM').AsString;
      modelo.DOMINGO         := lQry.FieldByName('DOMINGO').AsString;
      modelo.SEGUNDA         := lQry.FieldByName('SEGUNDA').AsString;
      modelo.TERCA           := lQry.FieldByName('TERCA').AsString;
      modelo.QUARTA          := lQry.FieldByName('QUARTA').AsString;
      modelo.QUINTA          := lQry.FieldByName('QUINTA').AsString;
      modelo.SEXTA           := lQry.FieldByName('SEXTA').AsString;
      modelo.SABADO          := lQry.FieldByName('SABADO').AsString;
      modelo.PORTADOR_ID     := lQry.FieldByName('PORTADOR_ID').AsString;
      modelo.LOJA            := lQry.FieldByName('LOJA').AsString;
      modelo.TIPO_ABATIMENTO := lQry.FieldByName('TIPO_ABATIMENTO').AsString;

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

procedure TPromocaoDao.setParams(var pQry: TFDQuery; pPromocaoModel: TPromocaoModel);
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPromocaoModel).AsString = '',
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
