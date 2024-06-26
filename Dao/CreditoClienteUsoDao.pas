unit CreditoClienteUsoDao;

interface

uses
  CreditoClienteUsoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TCreditoClienteUsoDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FCreditoClienteUsosLista: TObjectList<TCreditoClienteUsoModel>;
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
    procedure SetCreditoClienteUsosLista(const Value: TObjectList<TCreditoClienteUsoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);



  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property CreditoClienteUsosLista: TObjectList<TCreditoClienteUsoModel> read FCreditoClienteUsosLista write SetCreditoClienteUsosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function where: String;
    function incluir(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
    function alterar(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
    function excluir(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
	  function carregaClasse(pID : String) : TCreditoClienteUsoModel;
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pCreditoClienteUsoModel: TCreditoClienteUsoModel);

end;

implementation

uses
  System.Rtti;

{ TCreditoClienteUso }

function TCreditoClienteUsoDao.carregaClasse(pID: String): TCreditoClienteUsoModel;
var
  lQry: TFDQuery;
  lModel: TCreditoClienteUsoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCreditoClienteUsoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CREDITO_CLIENTE_USO where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                 := lQry.FieldByName('ID').AsString;
    lModel.CREDITO_CLIENTE_ID := lQry.FieldByName('CREDITO_CLIENTE_ID').AsString;
    lModel.DATA               := lQry.FieldByName('DATA').AsString;
    lModel.VALOR              := lQry.FieldByName('VALOR').AsString;
    lModel.PARCELA            := lQry.FieldByName('PARCELA').AsString;
    lModel.RECEBER_ID         := lQry.FieldByName('RECEBER_ID').AsString;
    lModel.LOCAL              := lQry.FieldByName('LOCAL').AsString;
    lModel.USUARIO_ID         := lQry.FieldByName('USUARIO_ID').AsString;
    lModel.DATAHORA           := lQry.FieldByName('DATAHORA').AsString;
    lModel.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCreditoClienteUsoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TCreditoClienteUsoDao.Destroy;
begin

  inherited;
end;

function TCreditoClienteUsoDao.incluir(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CREDITO_CLIENTE_USO','ID', True);

  try
    lQry.SQL.Add(lSQL);
    ACreditoClienteUsoModel.ID := vIConexao.Generetor('GEN_CREDITO_CLIENTE_USO', true);
    setParams(lQry, ACreditoClienteUsoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCreditoClienteUsoDao.alterar(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CREDITO_CLIENTE_USO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACreditoClienteUsoModel);
    lQry.ExecSQL;

    Result := ACreditoClienteUsoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCreditoClienteUsoDao.excluir(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CREDITO_CLIENTE_USO where ID = :ID',[ACreditoClienteUsoModel.ID]);
   lQry.ExecSQL;
   Result := ACreditoClienteUsoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TCreditoClienteUsoDao.where: String;
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

procedure TCreditoClienteUsoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CREDITO_CLIENTE_USO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteUsoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin

  lQry := vIConexao.CriarQuery;

  FCreditoClienteUsosLista := TObjectList<TCreditoClienteUsoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       credito_cliente_uso.*    '+
	    '  from credito_cliente_uso      '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCreditoClienteUsosLista.Add(TCreditoClienteUsoModel.Create(vIConexao));

      i := FCreditoClienteUsosLista.Count -1;

      FCreditoClienteUsosLista[i].ID                  := lQry.FieldByName('ID').AsString;
      FCreditoClienteUsosLista[i].CREDITO_CLIENTE_ID  := lQry.FieldByName('CREDITO_CLIENTE_ID').AsString;
      FCreditoClienteUsosLista[i].DATA                := lQry.FieldByName('DATA').AsString;
      FCreditoClienteUsosLista[i].VALOR               := lQry.FieldByName('VALOR').AsString;
      FCreditoClienteUsosLista[i].PARCELA             := lQry.FieldByName('PARCELA').AsString;
      FCreditoClienteUsosLista[i].RECEBER_ID          := lQry.FieldByName('RECEBER_ID').AsString;
      FCreditoClienteUsosLista[i].LOCAL               := lQry.FieldByName('LOCAL').AsString;
      FCreditoClienteUsosLista[i].USUARIO_ID          := lQry.FieldByName('USUARIO_ID').AsString;
      FCreditoClienteUsosLista[i].DATAHORA            := lQry.FieldByName('DATAHORA').AsString;
      FCreditoClienteUsosLista[i].SYSTIME             := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteUsoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCreditoClienteUsoDao.SetCreditoClienteUsosLista(const Value: TObjectList<TCreditoClienteUsoModel>);
begin
  FCreditoClienteUsosLista := Value;
end;

procedure TCreditoClienteUsoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCreditoClienteUsoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCreditoClienteUsoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCreditoClienteUsoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCreditoClienteUsoDao.setParams(var pQry: TFDQuery; pCreditoClienteUsoModel: TCreditoClienteUsoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CREDITO_CLIENTE_USO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TCreditoClienteUsoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pCreditoClienteUsoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pCreditoClienteUsoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TCreditoClienteUsoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCreditoClienteUsoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCreditoClienteUsoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
