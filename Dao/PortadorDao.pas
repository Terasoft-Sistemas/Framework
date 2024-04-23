unit PortadorDao;
interface
uses
  PortadorModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TPortadorDao = class
  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FPortadorsLista: TObjectList<TPortadorModel>;
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
    procedure SetPortadorsLista(const Value: TObjectList<TPortadorModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPortadorModel: TPortadorModel);
    function where: String;
    procedure SetIDRecordView(const Value: String);
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property PortadorsLista: TObjectList<TPortadorModel> read FPortadorsLista write SetPortadorsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pPortadorModel: TPortadorModel): String;
    function alterar(pPortadorModel: TPortadorModel): String;
    function excluir(pPortadorModel: TPortadorModel): String;

    procedure obterLista;
    function carregaClasse(pId: String): TPortadorModel;
    function PortadorTabelaJuros : TFDMemTable;
end;
implementation

uses
  System.Rtti;
{ TPortador }
function TPortadorDao.alterar(pPortadorModel: TPortadorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarUpdate('PORTADOR', 'CODIGO_PORT');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPortadorModel);
    lQry.ExecSQL;
    Result := pPortadorModel.CODIGO_PORT;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPortadorDao.carregaClasse(pId: String): TPortadorModel;
var
  lQry: TFDQuery;
  lModel: TPortadorModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPortadorModel.Create(vIConexao);
  Result   := lModel;
  try
    lQry.Open('select * from portador where codigo_port = '+pId);
    if lQry.IsEmpty then
      Exit;
    lModel.CODIGO_PORT              := lQry.FieldByName('CODIGO_PORT').AsString;
    lModel.NOME_PORT                := lQry.FieldByName('NOME_PORT').AsString;
    lModel.VR_PORT                  := lQry.FieldByName('VR_PORT').AsString;
    lModel.DESCONTO_PORT            := lQry.FieldByName('DESCONTO_PORT').AsString;
    lModel.USUARIO_PORT             := lQry.FieldByName('USUARIO_PORT').AsString;
    lModel.ID                       := lQry.FieldByName('ID').AsString;
    lModel.TIPO                     := lQry.FieldByName('TIPO').AsString;
    lModel.CONDICOES_PAG            := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.OBS                      := lQry.FieldByName('OBS').AsString;
    lModel.RECEITA_CONTA_ID         := lQry.FieldByName('RECEITA_CONTA_ID').AsString;
    lModel.CUSTO_CONTA_ID           := lQry.FieldByName('CUSTO_CONTA_ID').AsString;
    lModel.DF_CONTA_ID              := lQry.FieldByName('DF_CONTA_ID').AsString;
    lModel.RECEBIMENTO_CONTA_ID     := lQry.FieldByName('RECEBIMENTO_CONTA_ID').AsString;
    lModel.STATUS                   := lQry.FieldByName('STATUS').AsString;
    lModel.DIA_VENCIMENTO           := lQry.FieldByName('DIA_VENCIMENTO').AsString;
    lModel.PERCENTUAL_DESPESA_VENDA := lQry.FieldByName('PERCENTUAL_DESPESA_VENDA').AsString;
    lModel.DIRETO                   := lQry.FieldByName('DIRETO').AsString;
    lModel.PEDIR_VENCIMENTO         := lQry.FieldByName('PEDIR_VENCIMENTO').AsString;
    lModel.TELA_RECEBIMENTO         := lQry.FieldByName('TELA_RECEBIMENTO').AsString;
    lModel.TPAG_NFE                 := lQry.FieldByName('TPAG_NFE').AsString;
    lModel.CREDITO_CONTA_ID         := lQry.FieldByName('CREDITO_CONTA_ID').AsString;
    lModel.CONTAGEM                 := lQry.FieldByName('CONTAGEM').AsString;
    lModel.PERCENTUAL_COMISSAO      := lQry.FieldByName('PERCENTUAL_COMISSAO').AsString;
    lModel.SITUACAO_CLIENTE         := lQry.FieldByName('SITUACAO_CLIENTE').AsString;
    lModel.SYSTIME                  := lQry.FieldByName('SYSTIME').AsString;
    lModel.BANCO_BAIXA_DIRETA       := lQry.FieldByName('BANCO_BAIXA_DIRETA').AsString;
    lModel.TEF_MODALIDADE           := lQry.FieldByName('TEF_MODALIDADE').AsString;
    lModel.TEF_PARCELAMENTO         := lQry.FieldByName('TEF_PARCELAMENTO').AsString;
    lModel.TEF_ADQUIRENTE           := lQry.FieldByName('TEF_ADQUIRENTE').AsString;
    lModel.PIX_CHAVE                := lQry.FieldByName('PIX_CHAVE').AsString;
    lModel.XPAG_NFE                 := lQry.FieldByName('XPAG_NFE').AsString;
    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TPortadorDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;
destructor TPortadorDao.Destroy;
begin
  inherited;
end;
function TPortadorDao.excluir(pPortadorModel: TPortadorModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from portador where CODIGO_PORT = :CODIGO_PORT',[pPortadorModel.CODIGO_PORT]);
   lQry.ExecSQL;
   Result := pPortadorModel.CODIGO_PORT;
  finally
    lQry.Free;
  end;
end;

function TPortadorDao.incluir(pPortadorModel: TPortadorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PORTADOR', 'CODIGO_PORT');
  try
    lQry.SQL.Add(lSQL);
    pPortadorModel.CODIGO_PORT := vIConexao.Generetor('GEN_PORTADOR');
    setParams(lQry, pPortadorModel);
    lQry.Open;
    Result := lQry.FieldByName('CODIGO_PORT').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPortadorDao.where: String;
var
  lSQL : String;
begin

  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and portador.codigo_port = '+ QuotedStr(FIDRecordView);

  Result := lSQL;

end;
procedure TPortadorDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;
    lSql := 'select count(*) records From portador where 1=1 ';
    lSql := lSql + where;
    lQry.Open(lSQL);
    FTotalRecords := lQry.FieldByName('records').AsInteger;
  finally
    lQry.Free;
  end;
end;

function TPortadorDao.PortadorTabelaJuros: TFDMemTable;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.criarQuery;
  try
    lSql := '  select                                                                '+sLinebreak+
            '        CODIGO_PORTADOR,                                                '+sLinebreak+
            '        NOME_PORTADOR || '' - ''|| MAXIMO_PARCELAS ||''x'' PORTADOR     '+sLinebreak+
            '    from                                                                '+sLinebreak+
            '        (                                                               '+sLinebreak+
            '         select                                                         '+sLinebreak+
            '               p.codigo_port CODIGO_PORTADOR,                           '+sLinebreak+
            '               p.nome_port NOME_PORTADOR,                               '+sLinebreak+
            '               cast(max(t.codigo) as integer) MAXIMO_PARCELAS           '+sLinebreak+
            '                                                                        '+sLinebreak+
            '          from portador p                                               '+sLinebreak+
            '                                                                        '+sLinebreak+
            '         inner join tabelajuros t on t.portador_id = p.codigo_port      '+sLinebreak+
            '         where 1=1                                                      '+sLinebreak;

    if FIDRecordView <> '' then
      lSql := lSql + '  and t.portador_id = ' +QuotedStr(FIDRecordView);

      lSql := lSql + '   group by 1,2  order by 2   )                                 '+sLineBreak;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

procedure TPortadorDao.obterLista;
var
  lQry : TFDQuery;
  lSQL : String;
  i    : INteger;
begin
  lQry := vIConexao.CriarQuery;
  FPortadorsLista := TObjectList<TPortadorModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
                  '       portador.codigo_port,         '+
                  '       portador.nome_port,           '+
                  '       portador.banco_baixa_direta,  '+
                  '       portador.receita_conta_id,    '+
                  '       portador.tpag_nfe             '+
                  '  from portador                      '+
                  ' where 1=1                           ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPortadorsLista.Add(TPortadorModel.Create(vIConexao));
      i := FPortadorsLista.Count -1;

      FPortadorsLista[i].CODIGO_PORT          := lQry.FieldByName('CODIGO_PORT').AsString;
      FPortadorsLista[i].BANCO_BAIXA_DIRETA   := lQry.FieldByName('BANCO_BAIXA_DIRETA').AsString;
      FPortadorsLista[i].RECEITA_CONTA_ID     := lQry.FieldByName('RECEITA_CONTA_ID').AsString;
      FPortadorsLista[i].NOME_PORT            := lQry.FieldByName('NOME_PORT').AsString;
      FPortadorsLista[i].TPAG_NFE             := lQry.FieldByName('TPAG_NFE').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;
  finally
    lQry.Free;
  end;
end;

procedure TPortadorDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPortadorDao.SetPortadorsLista(const Value: TObjectList<TPortadorModel>);
begin
  FPortadorsLista := Value;
end;
procedure TPortadorDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPortadorDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TPortadorDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPortadorDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPortadorDao.setParams(var pQry: TFDQuery; pPortadorModel: TPortadorModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PORTADOR');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPortadorModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPortadorModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pPortadorModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPortadorDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;
procedure TPortadorDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;
procedure TPortadorDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
end.
