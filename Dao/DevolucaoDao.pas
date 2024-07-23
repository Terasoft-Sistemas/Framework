unit DevolucaoDao;

interface

uses
  DevolucaoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TDevolucaoDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

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
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pDevolucaoModel: TDevolucaoModel): String;
    function alterar(pDevolucaoModel: TDevolucaoModel): String;
    function excluir(pDevolucaoModel: TDevolucaoModel): String;

    function carregaClasse(pID : String): TDevolucaoModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pDevolucaoModel: TDevolucaoModel);

end;

implementation

uses
  System.Rtti;

{ TDevolucao }

function TDevolucaoDao.carregaClasse(pID : String): TDevolucaoModel;
var
  lQry: TFDQuery;
  lModel: TDevolucaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TDevolucaoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from devolucao where id = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID               := lQry.FieldByName('ID').AsString;
    lModel.PEDIDO           := lQry.FieldByName('PEDIDO').AsString;
    lModel.CLIENTE          := lQry.FieldByName('CLIENTE').AsString;
    lModel.DATA             := lQry.FieldByName('DATA').AsString;
    lModel.VALOR_TOTAL      := lQry.FieldByName('VALOR_TOTAL').AsString;
    lModel.USUARIO          := lQry.FieldByName('USUARIO').AsString;
    lModel.OBS              := lQry.FieldByName('OBS').AsString;
    lModel.LOJA             := lQry.FieldByName('LOJA').AsString;
    lModel.VALE             := lQry.FieldByName('VALE').AsString;
    lModel.DATA_USO_VALE    := lQry.FieldByName('DATA_USO_VALE').AsString;
    lModel.USO_VALE         := lQry.FieldByName('USO_VALE').AsString;
    lModel.NF_ENTRADA       := lQry.FieldByName('NF_ENTRADA').AsString;
    lModel.DESCONTO         := lQry.FieldByName('DESCONTO').AsString;
    lModel.VENDEDOR         := lQry.FieldByName('VENDEDOR').AsString;
    lModel.CODIGO_TIP       := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.HORA             := lQry.FieldByName('HORA').AsString;
    lModel.VALOR_IPI        := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.VALOR_ST         := lQry.FieldByName('VALOR_ST').AsString;
    lModel.FRETE            := lQry.FieldByName('FRETE').AsString;
    lModel.VALOR_SUFRAMA    := lQry.FieldByName('VALOR_SUFRAMA').AsString;
    lModel.STATUS_ID        := lQry.FieldByName('STATUS_ID').AsString;
    lModel.PORTADOR_ID      := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;
    lModel.VALOR_ACRESCIMO  := lQry.FieldByName('VALOR_ACRESCIMO').AsString;
    lModel.VFCPST           := lQry.FieldByName('VFCPST').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TDevolucaoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TDevolucaoDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TDevolucaoDao.incluir(pDevolucaoModel: TDevolucaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('DEVOLUCAO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pDevolucaoModel.ID := vIConexao.Generetor('GEN_DEVOLUCAO');
    setParams(lQry, pDevolucaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDevolucaoDao.alterar(pDevolucaoModel: TDevolucaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('DEVOLUCAO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pDevolucaoModel);
    lQry.ExecSQL;

    Result := pDevolucaoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDevolucaoDao.excluir(pDevolucaoModel: TDevolucaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from devolucao where id = :id' ,[pDevolucaoModel.ID]);
   lQry.ExecSQL;
   Result := pDevolucaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TDevolucaoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and id = '+QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TDevolucaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from devolucao where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TDevolucaoDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao                +SLineBreak+
              '         id,                        '+SLineBreak+
              '         pedido,                    '+SLineBreak+
              '         cliente,                   '+SLineBreak+
              '         data,                      '+SLineBreak+
              '         valor_total,               '+SLineBreak+
              '         usuario,                   '+SLineBreak+
              '         obs,                       '+SLineBreak+
              '         loja,                      '+SLineBreak+
              '         vale,                      '+SLineBreak+
              '         data_uso_vale,             '+SLineBreak+
              '         uso_vale,                  '+SLineBreak+
              '         nf_entrada,                '+SLineBreak+
              '         desconto,                  '+SLineBreak+
              '         vendedor,                  '+SLineBreak+
              '         codigo_tip,                '+SLineBreak+
              '         hora,                      '+SLineBreak+
              '         valor_ipi,                 '+SLineBreak+
              '         valor_st,                  '+SLineBreak+
              '         frete,                     '+SLineBreak+
              '         valor_suframa,             '+SLineBreak+
              '         status_id,                 '+SLineBreak+
              '         portador_id                '+SLineBreak+
              '    from devolucao                  '+SLineBreak+
              '   where 1=1                        '+SLineBreak;

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

procedure TDevolucaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDevolucaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDevolucaoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TDevolucaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDevolucaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TDevolucaoDao.setParams(var pQry: TFDQuery; pDevolucaoModel: TDevolucaoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('DEVOLUCAO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TDevolucaoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pDevolucaoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pDevolucaoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TDevolucaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TDevolucaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TDevolucaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
