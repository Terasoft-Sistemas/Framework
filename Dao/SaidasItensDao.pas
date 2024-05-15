unit SaidasItensDao;

interface

uses
  SaidasItensModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TSaidasItensDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FNumeroSaidaView: String;
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
    procedure SetNumeroSaidaView(const Value: String);

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
    property NumeroSaidaView : String read FNumeroSaidaView write SetNumeroSaidaView;

    function incluir(pSaidasItensModel: TSaidasItensModel): String;
    function alterar(pSaidasItensModel: TSaidasItensModel): String;
    function excluir(pSaidasItensModel: TSaidasItensModel): String;
    function carregaClasse(pID : String): TSaidasItensModel;
    function obterLista: TFDMemTable;

    function ObterTotais(pNumeroSaida : String) : TFDMemTable;
    procedure setParams(var pQry: TFDQuery; pSaidasItensModel: TSaidasItensModel);

end;

implementation

uses
  System.Rtti;

{ TSaidasItens }

function TSaidasItensDao.carregaClasse(pID : String): TSaidasItensModel;
var
  lQry : TFDQuery;
  lModel : TSaidasItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TSaidasItensModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from saidasitens where id = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_SAI     := lQry.FieldByName('NUMERO_SAI').AsString;
    lModel.CODIGO_CLI     := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.CODIGO_PRO     := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.QUANTIDADE_SAI := lQry.FieldByName('QUANTIDADE_SAI').AsString;
    lModel.QUANTIDADE_ATE := lQry.FieldByName('QUANTIDADE_ATE').AsString;
    lModel.VALOR_UNI_SAI  := lQry.FieldByName('VALOR_UNI_SAI').AsString;
    lModel.IPI_SAI        := lQry.FieldByName('IPI_SAI').AsString;
    lModel.ICMS_SAI       := lQry.FieldByName('ICMS_SAI').AsString;
    lModel.STATUS         := lQry.FieldByName('STATUS').AsString;
    lModel.LOJA           := lQry.FieldByName('LOJA').AsString;
    lModel.ID             := lQry.FieldByName('ID').AsString;
    lModel.RESERVA_ID     := lQry.FieldByName('RESERVA_ID').AsString;
    lModel.AVULSO         := lQry.FieldByName('AVULSO').AsString;
    lModel.DESCONTO_PED   := lQry.FieldByName('DESCONTO_PED').AsString;
    lModel.ALTURA_M       := lQry.FieldByName('ALTURA_M').AsString;
    lModel.LARGURA_M      := lQry.FieldByName('LARGURA_M').AsString;
    lModel.PROFUNDIDADE_M := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.DATA_CAD       := lQry.FieldByName('DATA_CAD').AsString;
    lModel.QTD_CHECAGEM   := lQry.FieldByName('QTD_CHECAGEM').AsString;
    lModel.REPOSICAO_ID   := lQry.FieldByName('REPOSICAO_ID').AsString;
    lModel.PRODUCAO_ID    := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.SAIDA_ID       := lQry.FieldByName('SAIDA_ID').AsString;
    lModel.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TSaidasItensDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TSaidasItensDao.Destroy;
begin
  inherited;
end;

function TSaidasItensDao.incluir(pSaidasItensModel: TSaidasItensModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('SAIDASITENS', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pSaidasItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSaidasItensDao.alterar(pSaidasItensModel: TSaidasItensModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin

  lQry := vIConexao.CriarQuery;
  lSQL :=  vConstrutor.gerarUpdate('SAIDASITENS','ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pSaidasItensModel);
    lQry.ExecSQL;

    Result := pSaidasItensModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSaidasItensDao.excluir(pSaidasItensModel: TSaidasItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from saidasitens where id = :id' ,[pSaidasItensModel.ID]);
   lQry.ExecSQL;
   Result := pSaidasItensModel.ID;

  finally
    lQry.Free;
  end;
end;

function TSaidasItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and saidasitens.id = '+IntToStr(FIDRecordView);

  if FNumeroSaidaView <> '' then
    lSQL := lSQL + ' and saidasitens.numero_sai = '+ QuotedStr(FNumeroSaidaView);

  Result := lSQL;
end;

procedure TSaidasItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from saidasitens where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TSaidasItensDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSql := ' select '+lPaginacao+'                                               '+SLineBreak+
            '        saidasitens.id,                                              '+SLineBreak+
            '        saidasitens.numero_sai,                                      '+SLineBreak+
            '        saidasitens.codigo_cli,                                      '+SLineBreak+
            '        saidasitens.codigo_pro,                                      '+SLineBreak+
            '        produto.nome_pro produto_nome,                               '+SLineBreak+
            '        produto.unidade_pro produto_unidade,                         '+SLineBreak+
            '        saidasitens.quantidade_sai,                                  '+SLineBreak+
            '        saidasitens.quantidade_ate,                                  '+SLineBreak+
            '        saidasitens.valor_uni_sai,                                   '+SLineBreak+
            '        saidasitens.status,                                          '+SLineBreak+
            '        saidasitens.loja,                                            '+SLineBreak+
            '        saidasitens.desconto_ped,                                    '+SLineBreak+
            '        saidasitens.data_cad,                                        '+SLineBreak+
            '        saidasitens.saida_id                                         '+SLineBreak+
            '   from saidasitens                                                  '+SLineBreak+
            '   left join produto on produto.codigo_pro = saidasitens.codigo_pro  '+SLineBreak+
            '  where 1=1                                                          '+SLineBreak;

    lSql := lSql + Where;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by '+FOrderView;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

function TSaidasItensDao.ObterTotais(pNumeroSaida : String): TFDMemTable;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSql := ' select                                                                                   '+SLineBreak+
            '        CUSTO,                                                                            '+SLineBreak+
            '        VALOR                                                                             '+SLineBreak+
            '   from                                                                                   '+SLineBreak+
            '   (select                                                                                '+SLineBreak+
            '           sum(quantidade * (custo - custo * percentual_desconto)) custo,                 '+SLineBreak+
            '           sum(quantidade * (valor_saida - valor_saida * percentual_desconto)) valor      '+SLineBreak+
            '      from                                                                                '+SLineBreak+
            '      (select                                                                             '+SLineBreak+
            '              cast(saidasitens.quantidade_sai as float) quantidade,                       '+SLineBreak+
            '              coalesce(saidasitens.icms_sai,0) custo,                                     '+SLineBreak+
            '              coalesce(saidasitens.desconto_ped,0) / 100 percentual_desconto,             '+SLineBreak+
            '              coalesce(saidasitens.valor_uni_sai,0) valor_saida                           '+SLineBreak+
            '         from saidas                                                                      '+SLineBreak+
            '        inner join saidasitens on saidasitens.numero_sai = saidas.numero_sai              '+SLineBreak+
            '        where saidas.numero_sai = '+QuotedStr(pNumeroSaida)+'                             '+SLineBreak+
            '       )                                                                                  '+SLineBreak+
            '    )                                                                                     '+SLineBreak;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

procedure TSaidasItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSaidasItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSaidasItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TSaidasItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSaidasItensDao.SetNumeroSaidaView(const Value: String);
begin
  FNumeroSaidaView := Value;
end;

procedure TSaidasItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TSaidasItensDao.setParams(var pQry: TFDQuery; pSaidasItensModel: TSaidasItensModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('SAIDASITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TSaidasItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pSaidasItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pSaidasItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TSaidasItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TSaidasItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TSaidasItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
