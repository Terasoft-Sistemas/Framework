unit CaixaDao;

interface

uses
  CaixaModel,
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
  TCaixaDao = class

  private
    vIconexao : Iconexao;
    vConstrutor : TConstrutorDao;

    FCaixasLista: TObjectList<TCaixaModel>;
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
    procedure SetCaixasLista(const Value: TObjectList<TCaixaModel>);
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

    property CaixasLista: TObjectList<TCaixaModel> read FCaixasLista write SetCaixasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(ACaixaModel: TCaixaModel): String;
    function alterar(ACaixaModel: TCaixaModel): String;
    function excluir(ACaixaModel: TCaixaModel): String;

    procedure obterLista;
    function carregaClasse(pIdCaixa: String): TCaixaModel;

    procedure setParams(var pQry: TFDQuery; pCaixaModel: TCaixaModel);

end;

implementation

uses
  System.Rtti;

{ TCaixa }


function TCaixaDao.carregaClasse(pIdCaixa: String): TCaixaModel;
var
  lQry: TFDQuery;
  lModel: TCaixaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCaixaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from caixa where numero_cai = '+pIdCaixa);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_CAI            := lQry.FieldByName('NUMERO_CAI').AsString;
    lModel.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.DATA_CAI              := lQry.FieldByName('DATA_CAI').AsString;
    lModel.HORA_CAI              := lQry.FieldByName('HORA_CAI').AsString;
    lModel.HISTORICO_CAI         := lQry.FieldByName('HISTORICO_CAI').AsString;
    lModel.VALOR_CAI             := lQry.FieldByName('VALOR_CAI').AsString;
    lModel.USUARIO_CAI           := lQry.FieldByName('USUARIO_CAI').AsString;
    lModel.TIPO_CAI              := lQry.FieldByName('TIPO_CAI').AsString;
    lModel.CLIENTE_CAI           := lQry.FieldByName('CLIENTE_CAI').AsString;
    lModel.NUMERO_PED            := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.FATURA_CAI            := lQry.FieldByName('FATURA_CAI').AsString;
    lModel.PARCELA_CAI           := lQry.FieldByName('PARCELA_CAI').AsString;
    lModel.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.PORTADOR_CAI          := lQry.FieldByName('PORTADOR_CAI').AsString;
    lModel.CONCILIADO_CAI        := lQry.FieldByName('CONCILIADO_CAI').AsString;
    lModel.DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
    lModel.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.RECIBO                := lQry.FieldByName('RECIBO').AsString;
    lModel.RELATORIO             := lQry.FieldByName('RELATORIO').AsString;
    lModel.OBSERVACAO            := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.DR                    := lQry.FieldByName('DR').AsString;
    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.TROCO                 := lQry.FieldByName('TROCO').AsString;
    lModel.CARGA_ID              := lQry.FieldByName('CARGA_ID').AsString;
    lModel.TIPO                  := lQry.FieldByName('TIPO').AsString;
    lModel.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
    lModel.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.OS_ID                 := lQry.FieldByName('OS_ID').AsString;
    lModel.PLACA                 := lQry.FieldByName('PLACA').AsString;
    lModel.TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
    lModel.TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
    lModel.COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
    lModel.PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCaixaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TCaixaDao.Destroy;
begin
  inherited;
end;

function TCaixaDao.incluir(ACaixaModel: TCaixaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CAIXA','NUMERO_CAI', True);

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('NUMERO_CAI').Value := vIConexao.Generetor('GEN_CAIXA');
    setParams(lQry, ACaixaModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_CAI').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaDao.alterar(ACaixaModel: TCaixaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CAIXA','NUMERO_CAI');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_cai').Value := ifThen(ACaixaModel.NUMERO_CAI = '', Unassigned, ACaixaModel.NUMERO_CAI);
    setParams(lQry, ACaixaModel);
    lQry.ExecSQL;

    Result := ACaixaModel.NUMERO_CAI;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaDao.excluir(ACaixaModel: TCaixaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CAIXA where NUMERO_CAI = :NUMERO_CAI',[ACaixaModel.NUMERO_CAI]);
   lQry.ExecSQL;
   Result := ACaixaModel.ID;

  finally
    lQry.Free;
  end;
end;

function TCaixaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and CAIXA.NUMERO_CAI = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TCaixaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from CAIXA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCaixaDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FCaixasLista := TObjectList<TCaixaModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       caixa.*         '+
	    '  from caixa           '+
      ' where 1=1             ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCaixasLista.Add(TCaixaModel.Create(vIConexao));

      i := FCaixasLista.Count -1;

      FCaixasLista[i].NUMERO_CAI           := lQry.FieldByName('NUMERO_CAI').AsString;
      FCaixasLista[i].CODIGO_CTA           := lQry.FieldByName('CODIGO_CTA').AsString;
      FCaixasLista[i].DATA_CAI             := lQry.FieldByName('DATA_CAI').AsString;
      FCaixasLista[i].HORA_CAI             := lQry.FieldByName('HORA_CAI').AsString;
      FCaixasLista[i].HISTORICO_CAI        := lQry.FieldByName('HISTORICO_CAI').AsString;
      FCaixasLista[i].VALOR_CAI            := lQry.FieldByName('VALOR_CAI').AsString;
      FCaixasLista[i].USUARIO_CAI          := lQry.FieldByName('USUARIO_CAI').AsString;
      FCaixasLista[i].TIPO_CAI             := lQry.FieldByName('TIPO_CAI').AsString;
      FCaixasLista[i].CLIENTE_CAI          := lQry.FieldByName('CLIENTE_CAI').AsString;
      FCaixasLista[i].NUMERO_PED           := lQry.FieldByName('NUMERO_PED').AsString;
      FCaixasLista[i].FATURA_CAI           := lQry.FieldByName('FATURA_CAI').AsString;
      FCaixasLista[i].PARCELA_CAI          := lQry.FieldByName('PARCELA_CAI').AsString;
      FCaixasLista[i].STATUS               := lQry.FieldByName('STATUS').AsString;
      FCaixasLista[i].PORTADOR_CAI         := lQry.FieldByName('PORTADOR_CAI').AsString;
      FCaixasLista[i].CONCILIADO_CAI       := lQry.FieldByName('CONCILIADO_CAI').AsString;
      FCaixasLista[i].DATA_CON             := lQry.FieldByName('DATA_CON').AsString;
      FCaixasLista[i].CENTRO_CUSTO         := lQry.FieldByName('CENTRO_CUSTO').AsString;
      FCaixasLista[i].LOJA                 := lQry.FieldByName('LOJA').AsString;
      FCaixasLista[i].RECIBO               := lQry.FieldByName('RECIBO').AsString;
      FCaixasLista[i].RELATORIO            := lQry.FieldByName('RELATORIO').AsString;
      FCaixasLista[i].OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      FCaixasLista[i].DR                   := lQry.FieldByName('DR').AsString;
      FCaixasLista[i].ID                   := lQry.FieldByName('ID').AsString;
      FCaixasLista[i].TROCO                := lQry.FieldByName('TROCO').AsString;
      FCaixasLista[i].CARGA_ID             := lQry.FieldByName('CARGA_ID').AsString;
      FCaixasLista[i].TIPO                 := lQry.FieldByName('TIPO').AsString;
      FCaixasLista[i].SUB_ID               := lQry.FieldByName('SUB_ID').AsString;
      FCaixasLista[i].LOCACAO_ID           := lQry.FieldByName('LOCACAO_ID').AsString;
      FCaixasLista[i].FUNCIONARIO_ID       := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      FCaixasLista[i].OS_ID                := lQry.FieldByName('OS_ID').AsString;
      FCaixasLista[i].PLACA                := lQry.FieldByName('PLACA').AsString;
      FCaixasLista[i].TRANSFERENCIA_ORIGEM := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
      FCaixasLista[i].TRANSFERENCIA_ID     := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
      FCaixasLista[i].COMPETENCIA          := lQry.FieldByName('COMPETENCIA').AsString;
      FCaixasLista[i].SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      FCaixasLista[i].LOJA_REMOTO          := lQry.FieldByName('LOJA_REMOTO').AsString;
      FCaixasLista[i].PEDIDO_ID            := lQry.FieldByName('PEDIDO_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCaixaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCaixaDao.SetCaixasLista(const Value: TObjectList<TCaixaModel>);
begin
  FCaixasLista := Value;
end;

procedure TCaixaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCaixaDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TCaixaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCaixaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCaixaDao.setParams(var pQry: TFDQuery; pCaixaModel: TCaixaModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CAIXA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TCaixaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pCaixaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pCaixaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TCaixaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCaixaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCaixaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
