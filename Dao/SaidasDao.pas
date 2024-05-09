unit SaidasDao;

interface

uses
  SaidasModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TSaidasDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FSaidaView: String;
    FLojaView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetSaidaView(const Value: String);
    procedure SetLojaView(const Value: String);
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
    property SaidaView : String read FSaidaView write SetSaidaView;
    property LojaView : String read FLojaView write SetLojaView;

    function incluir(pSaidasModel: TSaidasModel): String;
    function alterar(pSaidasModel: TSaidasModel): String;
    function excluir(pSaidasModel: TSaidasModel): String;
    function carregaClasse(pID : String): TSaidasModel;
    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pSaidasModel: TSaidasModel);

end;

implementation

uses
  System.Rtti;

{ TSaidas }

function TSaidasDao.carregaClasse(pID : String): TSaidasModel;
var
  lQry: TFDQuery;
  lModel: TSaidasModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TSaidasModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from saidas where numero_sai = ' + QuotedStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_SAI          := lQry.FieldByName('NUMERO_SAI').AsString;
    lModel.CODIGO_CLI          := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.DATA_SAI            := lQry.FieldByName('DATA_SAI').AsString;
    lModel.IPI_SAI             := lQry.FieldByName('IPI_SAI').AsString;
    lModel.VALOR_ICMS_SAI      := lQry.FieldByName('VALOR_ICMS_SAI').AsString;
    lModel.BASE_ICMS_SAI       := lQry.FieldByName('BASE_ICMS_SAI').AsString;
    lModel.OUTROS_SAI          := lQry.FieldByName('OUTROS_SAI').AsString;
    lModel.DESC_SAI            := lQry.FieldByName('DESC_SAI').AsString;
    lModel.TOTAL_SAI           := lQry.FieldByName('TOTAL_SAI').AsString;
    lModel.OBSERVACAO_SAI      := lQry.FieldByName('OBSERVACAO_SAI').AsString;
    lModel.USUARIO_SAI         := lQry.FieldByName('USUARIO_SAI').AsString;
    lModel.STATUS_SAI          := lQry.FieldByName('STATUS_SAI').AsString;
    lModel.TOTAL_PRODUTOS_SAI  := lQry.FieldByName('TOTAL_PRODUTOS_SAI').AsString;
    lModel.CFOP_SAI            := lQry.FieldByName('CFOP_SAI').AsString;
    lModel.PIS_SAI             := lQry.FieldByName('PIS_SAI').AsString;
    lModel.COFINS_SAI          := lQry.FieldByName('COFINS_SAI').AsString;
    lModel.TAXA_SAI            := lQry.FieldByName('TAXA_SAI').AsString;
    lModel.LOJA                := lQry.FieldByName('LOJA').AsString;
    lModel.ICMS_ST_SAI         := lQry.FieldByName('ICMS_ST_SAI').AsString;
    lModel.BASE_ST_SAI         := lQry.FieldByName('BASE_ST_SAI').AsString;
    lModel.NF_SAI              := lQry.FieldByName('NF_SAI').AsString;
    lModel.CONCLUIDA           := lQry.FieldByName('CONCLUIDA').AsString;
    lModel.ID                  := lQry.FieldByName('ID').AsString;
    lModel.CARGA_ID            := lQry.FieldByName('CARGA_ID').AsString;
    lModel.VENDEDOR_ID         := lQry.FieldByName('VENDEDOR_ID').AsString;
    lModel.ORDEM               := lQry.FieldByName('ORDEM').AsString;
    lModel.ORCAMENTO_ID        := lQry.FieldByName('ORCAMENTO_ID').AsString;
    lModel.CODIGO_CTA          := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.PREVISAO            := lQry.FieldByName('PREVISAO').AsString;
    lModel.PRECO_VENDA_ID      := lQry.FieldByName('PRECO_VENDA_ID').AsString;
    lModel.USUARIO_CHECAGEM    := lQry.FieldByName('USUARIO_CHECAGEM').AsString;
    lModel.DATAHORA_CHECAGEM   := lQry.FieldByName('DATAHORA_CHECAGEM').AsString;
    lModel.TRANSPORTADORA_ID   := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.RNTRC               := lQry.FieldByName('RNTRC').AsString;
    lModel.PLACA               := lQry.FieldByName('PLACA').AsString;
    lModel.UF_TRANSPORTADORA   := lQry.FieldByName('UF_TRANSPORTADORA').AsString;
    lModel.PESO_LIQUIDO        := lQry.FieldByName('PESO_LIQUIDO').AsString;
    lModel.PESO_BRUTO          := lQry.FieldByName('PESO_BRUTO').AsString;
    lModel.QTDE_VOLUME         := lQry.FieldByName('QTDE_VOLUME').AsString;
    lModel.ESPECIE_VOLUME      := lQry.FieldByName('ESPECIE_VOLUME').AsString;
    lModel.TRANSFERENCIA       := lQry.FieldByName('TRANSFERENCIA').AsString;
    lModel.CFOP_ID             := lQry.FieldByName('CFOP_ID').AsString;
    lModel.PEDIDO_COMPRA       := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.CTR_IMPRESSAO_PED   := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
    lModel.SYSTIME             := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TSaidasDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TSaidasDao.Destroy;
begin
  inherited;
end;

function TSaidasDao.incluir(pSaidasModel: TSaidasModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('SAIDAS', 'NUMERO_SAI');

  try
    lQry.SQL.Add(lSQL);
    pSaidasModel.NUMERO_SAI := vIConexao.Generetor('GEN_SAIDAS');
    setParams(lQry, pSaidasModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_SAI').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSaidasDao.alterar(pSaidasModel: TSaidasModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('SAIDAS','NUMERO_SAI');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pSaidasModel);
    lQry.ExecSQL;

    Result := pSaidasModel.NUMERO_SAI;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSaidasDao.excluir(pSaidasModel: TSaidasModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from saidas where numero_sai = :numero_sai' ,[pSaidasModel.NUMERO_SAI]);
   lQry.ExecSQL;
   Result := pSaidasModel.NUMERO_SAI;
  finally
    lQry.Free;
  end;
end;

function TSaidasDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and saidas.id = ' + IntToStr(FIDRecordView);

  if FSaidaView <> '' then
    lSQL := lSQL + ' and saidas.numero_sai = ' + QuotedStr(FSaidaView);

  if FLojaView <> '' then
    lSQL := lSQL + ' and saidas.loja = ' + QuotedStr(FLojaView);

  Result := lSQL;
end;

procedure TSaidasDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := ' select count(*) records                                                  '+sLineBreak+
            '   From saidas                                                            '+sLineBreak+
            '   left join contas on saidas.codigo_cta = contas.codigo_cta              '+sLineBreak+
            '   left join clientes on saidas.codigo_cli = clientes.codigo_cli          '+sLineBreak+
            '   left join funcionario on saidas.vendedor_id = funcionario.codigo_fun   '+sLineBreak+
            '   left join cfop on saidas.cfop_sai = cfop.cfop                          '+sLineBreak+
            '  where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TSaidasDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSql := ' select '+lPaginacao+'                                                    '+sLineBreak+
            '        saidas.id,                                                        '+sLineBreak+
            '        saidas.numero_sai,                                                '+sLineBreak+
            '        saidas.data_sai,                                                  '+sLineBreak+
            '        saidas.codigo_cli,                                                '+sLineBreak+
            '        coalesce(clientes.razao_cli, clientes.fantasia_cli) cliente_nome, '+sLineBreak+
            '        loja2.descricao destino,                                          '+sLineBreak+
            '        saidas.observacao_sai,                                            '+sLineBreak+
            '        saidas.cfop_sai,                                                  '+sLineBreak+
            '        cfop.descricao cfop_descricao,                                    '+sLineBreak+
            '        saidas.codigo_cta,                                                '+sLineBreak+
            '        contas.nome_cta conta_nome,                                       '+sLineBreak+
            '        saidas.vendedor_id,                                               '+sLineBreak+
            '        funcionario.nome_fun vendedor_nome,                               '+sLineBreak+
            '        saidas.loja,                                                      '+sLineBreak+
            '        saidas.nf_sai,                                                    '+sLineBreak+
            '        saidas.total_produtos_sai,                                        '+sLineBreak+
            '        saidas.total_sai,                                                 '+sLineBreak+
            '        saidas.status_sai                                                 '+sLineBreak+
            '   from saidas                                                            '+sLineBreak+
            '   left join contas on saidas.codigo_cta = contas.codigo_cta              '+sLineBreak+
            '   left join clientes on saidas.codigo_cli = clientes.codigo_cli          '+sLineBreak+
            '   left join funcionario on saidas.vendedor_id = funcionario.codigo_fun   '+sLineBreak+
            '   left join cfop on saidas.cfop_sai = cfop.cfop                          '+sLineBreak+
            '   left join loja2 on loja2.cliente_id = saidas.codigo_cli                '+sLineBreak+
            '  where 1=1                                                               '+sLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by '+FOrderView;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TSaidasDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSaidasDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSaidasDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TSaidasDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSaidasDao.SetLojaView(const Value: String);
begin
  FLojaView := Value;
end;

procedure TSaidasDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TSaidasDao.setParams(var pQry: TFDQuery; pSaidasModel: TSaidasModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('SAIDAS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TSaidasModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pSaidasModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pSaidasModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TSaidasDao.SetSaidaView(const Value: String);
begin
  FSaidaView := Value;
end;

procedure TSaidasDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TSaidasDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TSaidasDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
