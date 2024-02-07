unit EntradaDao;

interface

uses
  EntradaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TEntradaDao = class

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
    FIDEntrada: String;
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
    procedure SetIDEntrada(const Value: String);

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
    property IDEntrada: String read FIDEntrada write SetIDEntrada;

    function incluir(AEntradaModel: TEntradaModel): String;
    function alterar(AEntradaModel: TEntradaModel): String;
    function excluir(AEntradaModel: TEntradaModel): String;

    function carregaClasse(pID, pFornecedor : String): TEntradaModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pEntradaModel: TEntradaModel);

end;

implementation

uses
  System.Rtti;

{ TEntrada }

function TEntradaDao.carregaClasse(pID, pFornecedor: String): TEntradaModel;
var
  lQry: TFDQuery;
  lModel: TEntradaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TEntradaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ENTRADA where NUMERO_ENT = '+ QuotedStr(pID) + ' and CODIGO_FOR = ' + QuotedStr(pFornecedor) );

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_ENT                  := lQry.FieldByName('NUMERO_ENT').AsString;
    lModel.CODIGO_FOR                  := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.DATANOTA_ENT                := lQry.FieldByName('DATANOTA_ENT').AsString;
    lModel.DATAMOVI_ENT                := lQry.FieldByName('DATAMOVI_ENT').AsString;
    lModel.PARCELAS_ENT                := lQry.FieldByName('PARCELAS_ENT').AsString;
    lModel.PRIMEIROVENC_ENT            := lQry.FieldByName('PRIMEIROVENC_ENT').AsString;
    lModel.FRETE_ENT                   := lQry.FieldByName('FRETE_ENT').AsString;
    lModel.IPI_ENT                     := lQry.FieldByName('IPI_ENT').AsString;
    lModel.ICMS_ENT                    := lQry.FieldByName('ICMS_ENT').AsString;
    lModel.OUTROS_ENT                  := lQry.FieldByName('OUTROS_ENT').AsString;
    lModel.DESC_ENT                    := lQry.FieldByName('DESC_ENT').AsString;
    lModel.TOTAL_ENT                   := lQry.FieldByName('TOTAL_ENT').AsString;
    lModel.OBSERVACAO_ENT              := lQry.FieldByName('OBSERVACAO_ENT').AsString;
    lModel.USUARIO_ENT                 := lQry.FieldByName('USUARIO_ENT').AsString;
    lModel.STATUS                      := lQry.FieldByName('STATUS').AsString;
    lModel.TOTALPRODUTOS_ENT           := lQry.FieldByName('TOTALPRODUTOS_ENT').AsString;
    lModel.TIPO_PRO                    := lQry.FieldByName('TIPO$_PRO').AsString;
    lModel.CFOP_ENT                    := lQry.FieldByName('CFOP_ENT').AsString;
    lModel.DESPESAS_ADUANEIRAS         := lQry.FieldByName('DESPESAS_ADUANEIRAS').AsString;
    lModel.PIS_ENT                     := lQry.FieldByName('PIS_ENT').AsString;
    lModel.COFINS_ENT                  := lQry.FieldByName('COFINS_ENT').AsString;
    lModel.TAXA_ENT                    := lQry.FieldByName('TAXA_ENT').AsString;
    lModel.LOJA                        := lQry.FieldByName('LOJA').AsString;
    lModel.DOLAR                       := lQry.FieldByName('DOLAR').AsString;
    lModel.ICMS_ST                     := lQry.FieldByName('ICMS_ST').AsString;
    lModel.BASE_ST                     := lQry.FieldByName('BASE_ST').AsString;
    lModel.TIPO_FRETE                  := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.NUMERO_NF                   := lQry.FieldByName('NUMERO_NF').AsString;
    lModel.SERIE_ENT                   := lQry.FieldByName('SERIE_ENT').AsString;
    lModel.MODELO_ENT                  := lQry.FieldByName('MODELO_ENT').AsString;
    lModel.CONDICOES_PAG               := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.ID_A03                      := lQry.FieldByName('ID_A03').AsString;
    lModel.SEG_W09                     := lQry.FieldByName('SEG_W09').AsString;
    lModel.VII_W11                     := lQry.FieldByName('VII_W11').AsString;
    lModel.VRETPIS_W24                 := lQry.FieldByName('VRETPIS_W24').AsString;
    lModel.VRETCOFINS_W25              := lQry.FieldByName('VRETCOFINS_W25').AsString;
    lModel.VRETCSLL_W26                := lQry.FieldByName('VRETCSLL_W26').AsString;
    lModel.VBCIRRF_W27                 := lQry.FieldByName('VBCIRRF_W27').AsString;
    lModel.VIRRF_W28                   := lQry.FieldByName('VIRRF_W28').AsString;
    lModel.VBCRETPREV_W29              := lQry.FieldByName('VBCRETPREV_W29').AsString;
    lModel.VRETPREV_W30                := lQry.FieldByName('VRETPREV_W30').AsString;
    lModel.ARQ_NFE                     := lQry.FieldByName('ARQ_NFE').AsString;
    lModel.EMPRESA                     := lQry.FieldByName('EMPRESA').AsString;
    lModel.PEDIDO_COMPRA               := lQry.FieldByName('PEDIDO_COMPRA').AsString;
    lModel.ID                          := lQry.FieldByName('ID').AsString;
    lModel.ST_GUIA                     := lQry.FieldByName('ST_GUIA').AsString;
    lModel.CFOP_ID                     := lQry.FieldByName('CFOP_ID').AsString;
    lModel.PEDIDOCOMPRA_ID             := lQry.FieldByName('PEDIDOCOMPRA_ID').AsString;
    lModel.CONTA_ID                    := lQry.FieldByName('CONTA_ID').AsString;
    lModel.NUMERO_SAI                  := lQry.FieldByName('NUMERO_SAI').AsString;
    lModel.SYSTIME                     := lQry.FieldByName('SYSTIME').AsString;
    lModel.USUARIO_CHECAGEM            := lQry.FieldByName('USUARIO_CHECAGEM').AsString;
    lModel.DATAHORA_CHECAGEM           := lQry.FieldByName('DATAHORA_CHECAGEM').AsString;
    lModel.DESCONTO_NO_CUSTO           := lQry.FieldByName('DESCONTO_NO_CUSTO').AsString;
    lModel.PEDIDO_ID                   := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.AGUARDANDO_ENTREGA          := lQry.FieldByName('AGUARDANDO_ENTREGA').AsString;
    lModel.SAIDAS_ID                   := lQry.FieldByName('SAIDAS_ID').AsString;
    lModel.FINALIZADE                  := lQry.FieldByName('FINALIZADE').AsString;
    lModel.PRODUCAO_ID                 := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.DEVOLUCAO_PEDIDO_ID         := lQry.FieldByName('DEVOLUCAO_PEDIDO_ID').AsString;
    lModel.TRANSFERENCIA_SAIDA_ID      := lQry.FieldByName('TRANSFERENCIA_SAIDA_ID').AsString;
    lModel.TRANSFERENCIA_LOJA          := lQry.FieldByName('TRANSFERENCIA_LOJA').AsString;
    lModel.VFCP                        := lQry.FieldByName('VFCP').AsString;
    lModel.VFCPST                      := lQry.FieldByName('VFCPST').AsString;
    lModel.FRETE_ENT_2                 := lQry.FieldByName('FRETE_ENT_2').AsString;
    lModel.CHECAGEM                    := lQry.FieldByName('CHECAGEM').AsString;
    lModel.OBS_CHECAGEM                := lQry.FieldByName('OBS_CHECAGEM').AsString;
    lModel.PORTADOR_ID                 := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.OS_ID                       := lQry.FieldByName('OS_ID').AsString;
    lModel.CONTROLE_CHECAGEM           := lQry.FieldByName('CONTROLE_CHECAGEM').AsString;
    lModel.DATAHORA_CHECAGEM_INICIO    := lQry.FieldByName('DATAHORA_CHECAGEM_INICIO').AsString;
    lModel.CONDICOES_XML               := lQry.FieldByName('CONDICOES_XML').AsString;
    lModel.PARCELAS_XML                := lQry.FieldByName('PARCELAS_XML').AsString;
    lModel.ORCAMENTO_ID                := lQry.FieldByName('ORCAMENTO_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TEntradaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TEntradaDao.Destroy;
begin
  inherited;
end;

function TEntradaDao.incluir(AEntradaModel: TEntradaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('ENTRADA', 'NUMERO_ENT');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AEntradaModel);
    lQry.Open;
    Result := lQry.FieldByName('NUMERO_ENT').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TEntradaDao.alterar(AEntradaModel: TEntradaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('ENTRADA','NUMERO_ENT');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AEntradaModel);
    lQry.ExecSQL;

    Result := AEntradaModel.NUMERO_ENT;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TEntradaDao.excluir(AEntradaModel: TEntradaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ENTRADA where NUMERO_ENT = ' + QuotedStr(AEntradaModel.NUMERO_ENT) + ' and codigo_for = ' + QuotedStr(AEntradaModel.CODIGO_FOR));
   lQry.ExecSQL;
   Result := AEntradaModel.NUMERO_ENT;

  finally
    lQry.Free;
  end;
end;

function TEntradaDao.where: String;
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

procedure TEntradaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From ENTRADA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TEntradaDao.obterLista: TFDMemTable;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
    lSql := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSQL := ' select entrada.*,                                                                 '+SLineBreak+
            '        coalesce(fornecedor.razao_for, fornecedor.fantasia_for) NOME_FORNECEDOR,   '+SLineBreak+
            '        portador.nome_port PORTADOR                                                '+SLineBreak+
            '   from entrada                                                                    '+SLineBreak+
            '   left join fornecedor on fornecedor.codigo_for = entrada.codigo_for              '+SLineBreak+
            '   left join portador on portador.codigo_port = entrada.portador_id                '+SLineBreak+
            '  where 1=1                                                                        '+SLineBreak;

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

procedure TEntradaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TEntradaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEntradaDao.SetIDEntrada(const Value: String);
begin
  FIDEntrada := Value;
end;

procedure TEntradaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TEntradaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TEntradaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TEntradaDao.setParams(var pQry: TFDQuery; pEntradaModel: TEntradaModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('ENTRADA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TEntradaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pEntradaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pEntradaModel).AsString))
      else
        pQry.ParamByName(pQry.Params[i].Name).Value := Unassigned;

    end;
  finally
    lCtx.Free;
  end;
end;

procedure TEntradaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TEntradaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TEntradaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
