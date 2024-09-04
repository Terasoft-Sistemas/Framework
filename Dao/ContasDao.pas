unit ContasDao;

interface

uses
  ContasModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TContasDao = class;
  ITContasDao=IObject<TContasDao>;

  TContasDao = class
  private
    [weak] mySelf: ITContasDao;
    vIConexao   : IConexao;
    vConstrutor  : IConstrutorDao;

    FContassLista: IList<ITContasModel>;
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
    procedure SetContassLista(const Value: IList<ITContasModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITContasDao;

    property ContassLista: IList<ITContasModel> read FContassLista write SetContassLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AContasModel: ITContasModel): String;
    function alterar(AContasModel: ITContasModel): String;
    function excluir(AContasModel: ITContasModel): String;
    function carregaClasse(pID : String) : ITContasModel;
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pContasModel: ITContasModel);

end;

implementation

uses
  System.Rtti;

{ TContas }

function TContasDao.carregaClasse(pID: String): ITContasModel;
var
  lQry: TFDQuery;
  lModel: ITContasModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContasModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CONTAS where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                           := lQry.FieldByName('ID').AsString;
    lModel.objeto.CLASSIFICACAO                := lQry.FieldByName('CLASSIFICACAO').AsString;
    lModel.objeto.CODIGO_CTA                   := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.objeto.NOME_CTA                     := lQry.FieldByName('NOME_CTA').AsString;
    lModel.objeto.TIPO_CTA                     := lQry.FieldByName('TIPO_CTA').AsString;
    lModel.objeto.DR_CTA                       := lQry.FieldByName('DR_CTA').AsString;
    lModel.objeto.USUARIO_CTA                  := lQry.FieldByName('USUARIO_CTA').AsString;
    lModel.objeto.BANCO_CTA                    := lQry.FieldByName('BANCO_CTA').AsString;
    lModel.objeto.BAIXAPAGAR_CTA               := lQry.FieldByName('BAIXAPAGAR_CTA').AsString;
    lModel.objeto.TIPOSEMDR_CTA                := lQry.FieldByName('TIPOSEMDR_CTA').AsString;
    lModel.objeto.TIPOSEMDR_CTA_RECEBIMENTO    := lQry.FieldByName('TIPOSEMDR_CTA_RECEBIMENTO').AsString;
    lModel.objeto.GRUPO_CTA                    := lQry.FieldByName('GRUPO_CTA').AsString;
    lModel.objeto.SUBGRUPO_CTA                 := lQry.FieldByName('SUBGRUPO_CTA').AsString;
    lModel.objeto.CENTROCUSTO_CTA              := lQry.FieldByName('CENTROCUSTO_CTA').AsString;
    lModel.objeto.EXTRATO_CTA                  := lQry.FieldByName('EXTRATO_CTA').AsString;
    lModel.objeto.ORDEM                        := lQry.FieldByName('ORDEM').AsString;
    lModel.objeto.LOJA                         := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.EMPRESTIMO_CTA               := lQry.FieldByName('EMPRESTIMO_CTA').AsString;
    lModel.objeto.STATUS                       := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.CREDITO_ICMS                 := lQry.FieldByName('CREDITO_ICMS').AsString;
    lModel.objeto.RECEITAXDESPESAS             := lQry.FieldByName('RECEITAXDESPESAS').AsString;
    lModel.objeto.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.CREDITO_CLIENTE_CTA          := lQry.FieldByName('CREDITO_CLIENTE_CTA').AsString;
    lModel.objeto.CREDITO_FORNECEDOR_CTA       := lQry.FieldByName('CREDITO_FORNECEDOR_CTA').AsString;
    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TContasDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TContasDao.Destroy;
begin
  FContassLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TContasDao.incluir(AContasModel: ITContasModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTAS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasDao.alterar(AContasModel: ITContasModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CONTAS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasModel);
    lQry.ExecSQL;

    Result := AContasModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasDao.excluir(AContasModel: ITContasModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CONTAS where ID = :ID',[AContasModel.objeto.ID]);
   lQry.ExecSQL;
   Result := AContasModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TContasDao.getNewIface(pIConexao: IConexao): ITContasDao;
begin
  Result := TImplObjetoOwner<TContasDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TContasDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TContasDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from CONTAS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TContasDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITContasModel;
begin

  lQry := vIConexao.CriarQuery;

  FContassLista := TCollections.CreateList<ITContasModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       contas.*                 '+
	    '  from contas                   '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TContasModel.getNewIface(vIConexao);
      FContassLista.Add(modelo);

      modelo.objeto.ID                         := lQry.FieldByName('ID').AsString;
      modelo.objeto.CLASSIFICACAO              := lQry.FieldByName('CLASSIFICACAO').AsString;
      modelo.objeto.CODIGO_CTA                 := lQry.FieldByName('CODIGO_CTA').AsString;
      modelo.objeto.NOME_CTA                   := lQry.FieldByName('NOME_CTA').AsString;
      modelo.objeto.TIPO_CTA                   := lQry.FieldByName('TIPO_CTA').AsString;
      modelo.objeto.DR_CTA                     := lQry.FieldByName('DR_CTA').AsString;
      modelo.objeto.USUARIO_CTA                := lQry.FieldByName('USUARIO_CTA').AsString;
      modelo.objeto.BANCO_CTA                  := lQry.FieldByName('BANCO_CTA').AsString;
      modelo.objeto.BAIXAPAGAR_CTA             := lQry.FieldByName('BAIXAPAGAR_CTA').AsString;
      modelo.objeto.TIPOSEMDR_CTA              := lQry.FieldByName('TIPOSEMDR_CTA').AsString;
      modelo.objeto.TIPOSEMDR_CTA_RECEBIMENTO  := lQry.FieldByName('TIPOSEMDR_CTA_RECEBIMENTO').AsString;
      modelo.objeto.GRUPO_CTA                  := lQry.FieldByName('GRUPO_CTA').AsString;
      modelo.objeto.SUBGRUPO_CTA               := lQry.FieldByName('SUBGRUPO_CTA').AsString;
      modelo.objeto.CENTROCUSTO_CTA            := lQry.FieldByName('CENTROCUSTO_CTA').AsString;
      modelo.objeto.EXTRATO_CTA                := lQry.FieldByName('EXTRATO_CTA').AsString;
      modelo.objeto.ORDEM                      := lQry.FieldByName('ORDEM').AsString;
      modelo.objeto.LOJA                       := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.EMPRESTIMO_CTA             := lQry.FieldByName('EMPRESTIMO_CTA').AsString;
      modelo.objeto.STATUS                     := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.CREDITO_ICMS               := lQry.FieldByName('CREDITO_ICMS').AsString;
      modelo.objeto.RECEITAXDESPESAS           := lQry.FieldByName('RECEITAXDESPESAS').AsString;
      modelo.objeto.SYSTIME                    := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.CREDITO_CLIENTE_CTA        := lQry.FieldByName('CREDITO_CLIENTE_CTA').AsString;
      modelo.objeto.CREDITO_FORNECEDOR_CTA     := lQry.FieldByName('CREDITO_FORNECEDOR_CTA').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;

  end;
end;

procedure TContasDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasDao.SetContassLista;
begin
  FContassLista := Value;
end;

procedure TContasDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasDao.setParams(var pQry: TFDQuery; pContasModel: ITContasModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONTAS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TContasModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pContasModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pContasModel.objeto).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TContasDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
