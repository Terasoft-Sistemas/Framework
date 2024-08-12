unit PortadorDao;
interface
uses
  PortadorModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Terasoft.Framework.ObjectIface,
  System.Variants,
  Terasoft.Utils,
  Spring.Collections,
  Interfaces.Conexao;

type

  TPortadorDao = class;

  ITPortadorDao = IObject<TPortadorDao>;

  TPortadorDao = class
  private
    [weak] mySelf: ITPortadorDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FPortadorsLista: IList<ITPortadorModel>;
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
    procedure SetPortadorsLista(const Value: IList<ITPortadorModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure setParams(var pQry: TFDQuery; pPortadorModel: ITPortadorModel);
    function where: String;
    procedure SetIDRecordView(const Value: String);
  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPortadorDao;

    property PortadorsLista: IList<ITPortadorModel> read FPortadorsLista write SetPortadorsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pPortadorModel: ITPortadorModel): String;
    function alterar(pPortadorModel: ITPortadorModel): String;
    function excluir(pPortadorModel: ITPortadorModel): String;

    procedure obterLista;
    function carregaClasse(pId: String): ITPortadorModel;
    function PortadorTabelaJuros : IFDDataset;
end;
implementation

uses
  System.Rtti;
{ TPortador }
function TPortadorDao.alterar(pPortadorModel: ITPortadorModel): String;
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
    Result := pPortadorModel.objeto.CODIGO_PORT;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPortadorDao.carregaClasse(pId: String): ITPortadorModel;
var
  lQry: TFDQuery;
  lModel: ITPortadorModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPortadorModel.getNewIface(vIConexao);
  Result   := lModel;
  try
    lQry.Open('select * from portador where codigo_port = '+pId);
    if lQry.IsEmpty then
      Exit;
    lModel.objeto.CODIGO_PORT              := lQry.FieldByName('CODIGO_PORT').AsString;
    lModel.objeto.NOME_PORT                := lQry.FieldByName('NOME_PORT').AsString;
    lModel.objeto.VR_PORT                  := lQry.FieldByName('VR_PORT').AsString;
    lModel.objeto.DESCONTO_PORT            := lQry.FieldByName('DESCONTO_PORT').AsString;
    lModel.objeto.USUARIO_PORT             := lQry.FieldByName('USUARIO_PORT').AsString;
    lModel.objeto.ID                       := lQry.FieldByName('ID').AsString;
    lModel.objeto.TIPO                     := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.CONDICOES_PAG            := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.objeto.OBS                      := lQry.FieldByName('OBS').AsString;
    lModel.objeto.RECEITA_CONTA_ID         := lQry.FieldByName('RECEITA_CONTA_ID').AsString;
    lModel.objeto.CUSTO_CONTA_ID           := lQry.FieldByName('CUSTO_CONTA_ID').AsString;
    lModel.objeto.DF_CONTA_ID              := lQry.FieldByName('DF_CONTA_ID').AsString;
    lModel.objeto.RECEBIMENTO_CONTA_ID     := lQry.FieldByName('RECEBIMENTO_CONTA_ID').AsString;
    lModel.objeto.STATUS                   := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.DIA_VENCIMENTO           := lQry.FieldByName('DIA_VENCIMENTO').AsString;
    lModel.objeto.PERCENTUAL_DESPESA_VENDA := lQry.FieldByName('PERCENTUAL_DESPESA_VENDA').AsString;
    lModel.objeto.DIRETO                   := lQry.FieldByName('DIRETO').AsString;
    lModel.objeto.PEDIR_VENCIMENTO         := lQry.FieldByName('PEDIR_VENCIMENTO').AsString;
    lModel.objeto.TELA_RECEBIMENTO         := lQry.FieldByName('TELA_RECEBIMENTO').AsString;
    lModel.objeto.TPAG_NFE                 := lQry.FieldByName('TPAG_NFE').AsString;
    lModel.objeto.CREDITO_CONTA_ID         := lQry.FieldByName('CREDITO_CONTA_ID').AsString;
    lModel.objeto.CONTAGEM                 := lQry.FieldByName('CONTAGEM').AsString;
    lModel.objeto.PERCENTUAL_COMISSAO      := lQry.FieldByName('PERCENTUAL_COMISSAO').AsString;
    lModel.objeto.SITUACAO_CLIENTE         := lQry.FieldByName('SITUACAO_CLIENTE').AsString;
    lModel.objeto.SYSTIME                  := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.BANCO_BAIXA_DIRETA       := lQry.FieldByName('BANCO_BAIXA_DIRETA').AsString;
    lModel.objeto.TEF_MODALIDADE           := lQry.FieldByName('TEF_MODALIDADE').AsString;
    lModel.objeto.TEF_PARCELAMENTO         := lQry.FieldByName('TEF_PARCELAMENTO').AsString;
    lModel.objeto.TEF_ADQUIRENTE           := lQry.FieldByName('TEF_ADQUIRENTE').AsString;
    lModel.objeto.PIX_CHAVE                := lQry.FieldByName('PIX_CHAVE').AsString;
    lModel.objeto.XPAG_NFE                 := lQry.FieldByName('XPAG_NFE').AsString;
    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TPortadorDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;
destructor TPortadorDao.Destroy;
begin
  FPortadorsLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;
function TPortadorDao.excluir(pPortadorModel: ITPortadorModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from portador where CODIGO_PORT = :CODIGO_PORT',[pPortadorModel.objeto.CODIGO_PORT]);
   lQry.ExecSQL;
   Result := pPortadorModel.objeto.CODIGO_PORT;
  finally
    lQry.Free;
  end;
end;

class function TPortadorDao.getNewIface(pIConexao: IConexao): ITPortadorDao;
begin
  Result := TImplObjetoOwner<TPortadorDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPortadorDao.incluir(pPortadorModel: ITPortadorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('PORTADOR', 'CODIGO_PORT');
  try
    lQry.SQL.Add(lSQL);
    pPortadorModel.objeto.CODIGO_PORT := vIConexao.Generetor('GEN_PORTADOR');
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

function TPortadorDao.PortadorTabelaJuros: IFDDataset;
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
  modelo: ITPortadorModel;
begin
  lQry := vIConexao.CriarQuery;
  FPortadorsLista := TCollections.CreateList<ITPortadorModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
                  '       portador.codigo_port,          '+
                  '       portador.nome_port,            '+
                  '       portador.banco_baixa_direta,   '+
                  '       portador.receita_conta_id,     '+
                  '       portador.tpag_nfe,             '+
                  '       portador.per_seguro_prestamista'+
                  '  from portador                       '+
                  ' where 1=1                            ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TPortadorModel.getNewIface(vIConexao);
      FPortadorsLista.Add(modelo);
      modelo.objeto.CODIGO_PORT            := lQry.FieldByName('CODIGO_PORT').AsString;
      modelo.objeto.BANCO_BAIXA_DIRETA     := lQry.FieldByName('BANCO_BAIXA_DIRETA').AsString;
      modelo.objeto.RECEITA_CONTA_ID       := lQry.FieldByName('RECEITA_CONTA_ID').AsString;
      modelo.objeto.NOME_PORT              := lQry.FieldByName('NOME_PORT').AsString;
      modelo.objeto.TPAG_NFE               := lQry.FieldByName('TPAG_NFE').AsString;
      modelo.objeto.PER_SEGURO_PRESTAMISTA := lQry.FieldByName('PER_SEGURO_PRESTAMISTA').AsFloat;

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

procedure TPortadorDao.SetPortadorsLista;
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

procedure TPortadorDao.setParams(var pQry: TFDQuery; pPortadorModel: ITPortadorModel);
var
  lTabela : IFDDataset;
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPortadorModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pPortadorModel.objeto).AsString))
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
