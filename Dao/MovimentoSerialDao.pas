unit MovimentoSerialDao;

interface

uses
  MovimentoSerialModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TMovimentoSerialDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

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
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

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
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pMovimentoSerialModel: TMovimentoSerialModel): String;
    function alterar(pMovimentoSerialModel: TMovimentoSerialModel): String;
    function excluir(pMovimentoSerialModel: TMovimentoSerialModel): String;

    function carregaClasse(pID : String): TMovimentoSerialModel;
    function obterLista: TFDMemTable;
    function ConsultaSerial: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pMovimentoSerialModel: TMovimentoSerialModel);

end;

implementation

uses
  System.Rtti;

{ TMovimentoSerial }

function TMovimentoSerialDao.carregaClasse(pID : String): TMovimentoSerialModel;
var
  lQry: TFDQuery;
  lModel: TMovimentoSerialModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TMovimentoSerialModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from movimento_serial where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                := lQry.FieldByName('ID').AsString;
    lModel.LOGISTICA         := lQry.FieldByName('LOGISTICA').AsString;
    lModel.TIPO_SERIAL       := lQry.FieldByName('TIPO_SERIAL').AsString;
    lModel.NUMERO            := lQry.FieldByName('NUMERO').AsString;
    lModel.PRODUTO           := lQry.FieldByName('PRODUTO').AsString;
    lModel.DH_MOVIMENTO      := lQry.FieldByName('DH_MOVIMENTO').AsString;
    lModel.TIPO_DOCUMENTO    := lQry.FieldByName('TIPO_DOCUMENTO').AsString;
    lModel.ID_DOCUMENTO      := lQry.FieldByName('ID_DOCUMENTO').AsString;
    lModel.SUB_ID            := lQry.FieldByName('SUB_ID').AsString;
    lModel.TIPO_MOVIMENTO    := lQry.FieldByName('TIPO_MOVIMENTO').AsString;
    lModel.SYSTIME           := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.ConsultaSerial: TFDMemTable;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSql := '  select                                                                                '+sLineBreak+
            '      case m.tipo_documento                                                             '+sLineBreak+
            '        when ''E'' then f.fantasia_for                                                  '+sLineBreak+
            '        when ''P'' then c.fantasia_cli                                                  '+sLineBreak+
            '        when ''T'' then cl.fantasia_cli                                                 '+sLineBreak+
            '        when ''D'' then cli.fantasia_cli                                                '+sLineBreak+
            '        else ''NAO INFORMADO''                                                          '+sLineBreak+
            '      end Cliente_fornecedor,                                                           '+sLineBreak+
            '                                                                                        '+sLineBreak+
            '      case m.tipo_documento                                                             '+sLineBreak+
            '        when ''I'' then ''INICIALIZACAO''                                               '+sLineBreak+
            '        when ''E'' then ''ENTRADA''                                                     '+sLineBreak+
            '        when ''P'' then ''VENDA''                                                       '+sLineBreak+
            '        when ''T'' then ''TRASNFERENCIA SAIDA''                                         '+sLineBreak+
            '        when ''D'' then ''DEVOLUCAO''                                                   '+sLineBreak+
            '        else ''NAO INFORMADO''                                                          '+sLineBreak+
            '      end tipo_documento,                                                               '+sLineBreak+
            '                                                                                        '+sLineBreak+
            '      m.numero,                                                                         '+sLineBreak+
            '      m.produto,                                                                        '+sLineBreak+
            '      t.nome_pro,                                                                       '+sLineBreak+
            '      m.id_documento,                                                                   '+sLineBreak+
            '      m.dh_movimento,                                                                   '+sLineBreak+
            '      m.tipo_movimento,                                                                 '+sLineBreak+
            '      p.numero_nf                                                                       '+sLineBreak+
            '  from                                                                                  '+sLineBreak+
            '       movimento_serial m                                                               '+sLineBreak+
            '                                                                                        '+sLineBreak+
            '  left join entrada e on e.id = m.id_documento and m.tipo_documento = ''E''             '+sLineBreak+
            '  left join fornecedor f on f.codigo_for = e.codigo_for and m.tipo_documento = ''E''    '+sLineBreak+
            '  left join pedidovenda p on p.numero_ped = m.id_documento and m.tipo_documento = ''P'' '+sLineBreak+
            '  left join clientes c on c.codigo_cli = p.codigo_cli and m.tipo_documento = ''P''      '+sLineBreak+
            '  left join saidas s on s.numero_sai = m.id_documento and m.tipo_documento = ''T''      '+sLineBreak+
            '  left join clientes cl on cl.codigo_cli = s.codigo_cli and m.tipo_documento = ''T''    '+sLineBreak+
            '  left join devolucao d on d.id = m.id_documento and m.tipo_documento = ''D''           '+sLineBreak+
            '  left join clientes cli on cli.codigo_cli = d.cliente and m.tipo_documento = ''D''     '+sLineBreak+
            '  left join produto t on t.codigo_pro = m.produto                                       '+sLineBreak+
            ' where 1=1                                                                              '+sLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

constructor TMovimentoSerialDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TMovimentoSerialDao.Destroy;
begin
  inherited;
end;

function TMovimentoSerialDao.incluir(pMovimentoSerialModel: TMovimentoSerialModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('MOVIMENTO_SERIAL', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMovimentoSerialModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.alterar(pMovimentoSerialModel: TMovimentoSerialModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('MOVIMENTO_SERIAL','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMovimentoSerialModel);
    lQry.ExecSQL;

    Result := pMovimentoSerialModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.excluir(pMovimentoSerialModel: TMovimentoSerialModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from movimento_serial where ID = :ID' ,[pMovimentoSerialModel.ID]);
   lQry.ExecSQL;
   Result := pMovimentoSerialModel.ID;

  finally
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TMovimentoSerialDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from movimento_serial where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+' *       '+SLineBreak+
              '    from movimento_serial       '+SLineBreak+
              '   where 1=1                    '+SLineBreak;


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

procedure TMovimentoSerialDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMovimentoSerialDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMovimentoSerialDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TMovimentoSerialDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMovimentoSerialDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TMovimentoSerialDao.setParams(var pQry: TFDQuery; pMovimentoSerialModel: TMovimentoSerialModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('movimento_serial');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TMovimentoSerialModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pMovimentoSerialModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pMovimentoSerialModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TMovimentoSerialDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TMovimentoSerialDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TMovimentoSerialDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
