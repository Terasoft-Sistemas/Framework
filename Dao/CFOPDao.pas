unit CFOPDao;

interface

uses
  CFOPModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TCFOPDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FCFOPsLista: IList<TCFOPModel>;
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
    procedure SetCFOPsLista(const Value: IList<TCFOPModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

    procedure setParams(var pQry: TFDQuery; pCFOPModel: TCFOPModel);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property CFOPsLista: IList<TCFOPModel> read FCFOPsLista write SetCFOPsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ACFOPModel: TCFOPModel): String;
    function alterar(ACFOPModel: TCFOPModel): String;
    function excluir(ACFOPModel: TCFOPModel): String;
	
    procedure obterLista;

    function carregaClasse(pId: String): TCFOPModel;
    function obterCFOP(pIdCFOP: String): String;

end;

implementation

uses
  System.Rtti;

{ TCFOP }

function TCFOPDao.carregaClasse(pId: String): TCFOPModel;
var
  lQry: TFDQuery;
  lModel: TCFOPModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCFOPModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from cfop where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                             := lQry.FieldByName('ID').AsString;
    lModel.CFOP                           := lQry.FieldByName('CFOP').AsString;
    lModel.DESCRICAO                      := lQry.FieldByName('DESCRICAO').AsString;
    lModel.TIPO                           := lQry.FieldByName('TIPO').AsString;
    lModel.ESTOQUE                        := lQry.FieldByName('ESTOQUE').AsString;
    lModel.ICMS                           := lQry.FieldByName('ICMS').AsString;
    lModel.CST                            := lQry.FieldByName('CST').AsString;
    lModel.OBS                            := lQry.FieldByName('OBS').AsString;
    lModel.PIS                            := lQry.FieldByName('PIS').AsString;
    lModel.COFINS                         := lQry.FieldByName('COFINS').AsString;
    lModel.VALOR                          := lQry.FieldByName('VALOR').AsString;
    lModel.CONSIGNADO                     := lQry.FieldByName('CONSIGNADO').AsString;
    lModel.CSOSN                          := lQry.FieldByName('CSOSN').AsString;
    lModel.CFOP_REFERENCIA                := lQry.FieldByName('CFOP_REFERENCIA').AsString;
    lModel.CONTA_CONTABIL                 := lQry.FieldByName('CONTA_CONTABIL').AsString;
    lModel.CST_ENTRADA                    := lQry.FieldByName('CST_ENTRADA').AsString;
    lModel.RESERVADO_FISCO                := lQry.FieldByName('RESERVADO_FISCO').AsString;
    lModel.ALTERA_CUSTO                   := lQry.FieldByName('ALTERA_CUSTO').AsString;
    lModel.IBPT                           := lQry.FieldByName('IBPT').AsString;
    lModel.OPERACAO                       := lQry.FieldByName('OPERACAO').AsString;
    lModel.ESTOQUE_2                      := lQry.FieldByName('ESTOQUE_2').AsString;
    lModel.CST_PIS                        := lQry.FieldByName('CST_PIS').AsString;
    lModel.CST_COFINS                     := lQry.FieldByName('CST_COFINS').AsString;
    lModel.CST_IPI                        := lQry.FieldByName('CST_IPI').AsString;
    lModel.ALIQUOTA_PIS                   := lQry.FieldByName('ALIQUOTA_PIS').AsString;
    lModel.ALIQUOTA_COFINS                := lQry.FieldByName('ALIQUOTA_COFINS').AsString;
    lModel.ALIQUOTA_IPI                   := lQry.FieldByName('ALIQUOTA_IPI').AsString;
    lModel.SOMAR_IPI_BASE_ICMS            := lQry.FieldByName('SOMAR_IPI_BASE_ICMS').AsString;
    lModel.STATUS                         := lQry.FieldByName('STATUS').AsString;
    lModel.LISTAR_IPI_SPED                := lQry.FieldByName('LISTAR_IPI_SPED').AsString;
    lModel.APROVEITAMENTO_ICMS            := lQry.FieldByName('APROVEITAMENTO_ICMS').AsString;
    lModel.REDUCAO_APROVEITAMENTO_ICMS    := lQry.FieldByName('REDUCAO_APROVEITAMENTO_ICMS').AsString;
    lModel.DESCONTO_SOBRE_IPI             := lQry.FieldByName('DESCONTO_SOBRE_IPI').AsString;
    lModel.SOMAR_PIS_COFINS_EM_OUTRAS     := lQry.FieldByName('SOMAR_PIS_COFINS_EM_OUTRAS').AsString;
    lModel.SOMAR_ICMS_TOTAL_NF            := lQry.FieldByName('SOMAR_ICMS_TOTAL_NF').AsString;
    lModel.CFOP_DEVOLUCAO                 := lQry.FieldByName('CFOP_DEVOLUCAO').AsString;
    lModel.MOTDESICMS                     := lQry.FieldByName('MOTDESICMS').AsString;
    lModel.CBENEF                         := lQry.FieldByName('CBENEF').AsString;
    lModel.PREDBC_N14                     := lQry.FieldByName('PREDBC_N14').AsString;
    lModel.CENQ                           := lQry.FieldByName('CENQ').AsString;
    lModel.SYSTIME                        := lQry.FieldByName('SYSTIME').AsString;
    lModel.PCRED_PRESUMIDO                := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
    lModel.DESCONTO_SOBRE_ICMS            := lQry.FieldByName('DESCONTO_SOBRE_ICMS').AsString;
    lModel.DESCONTO_ICMS_BASE_PIS_COFINS  := lQry.FieldByName('DESCONTO_ICMS_BASE_PIS_COFINS').AsString;
    lModel.OUTRAS_DESPESAS_ENTRADA        := lQry.FieldByName('OUTRAS_DESPESAS_ENTRADA').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCFOPDao.Create(pIConexao :IConexao);
begin
   vIConexao    := pIConexao;
   vConstrutor  := TConstrutorDao.Create(vIConexao);
end;

destructor TCFOPDao.Destroy;
begin
  FCFOPsLista := nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TCFOPDao.incluir(ACFOPModel: TCFOPModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CFOP','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACFOPModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCFOPDao.alterar(ACFOPModel: TCFOPModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CFOP', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACFOPModel);
    lQry.ExecSQL;

    Result := ACFOPModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCFOPDao.excluir(ACFOPModel: TCFOPModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CFOP where ID = :ID',[ACFOPModel.ID]);
   lQry.ExecSQL;
   Result := ACFOPModel.ID;

  finally
    lQry.Free;
  end;
end;

function TCFOPDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and cfop.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TCFOPDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from CFOP where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TCFOPDao.obterCFOP(pIdCFOP: String): String;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select CFOP from CFOP where id = '+ pIdCFOP);
end;

procedure TCFOPDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: TCFOPModel;
begin
  lQry := vIConexao.CriarQuery;

  FCFOPsLista := TCollections.CreateList<TCFOPModel>(true);

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       cfop.*              '+
	    '  from cfop                '+
      ' where 1=1                 ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TCFOPModel.Create(vIConexao);
      FCFOPsLista.Add(modelo);

      modelo.ID                             := lQry.FieldByName('ID').AsString;
      modelo.CFOP                           := lQry.FieldByName('CFOP').AsString;
      modelo.DESCRICAO                      := lQry.FieldByName('DESCRICAO').AsString;
      modelo.TIPO                           := lQry.FieldByName('TIPO').AsString;
      modelo.ESTOQUE                        := lQry.FieldByName('ESTOQUE').AsString;
      modelo.ICMS                           := lQry.FieldByName('ICMS').AsString;
      modelo.CST                            := lQry.FieldByName('CST').AsString;
      modelo.OBS                            := lQry.FieldByName('OBS').AsString;
      modelo.PIS                            := lQry.FieldByName('PIS').AsString;
      modelo.COFINS                         := lQry.FieldByName('COFINS').AsString;
      modelo.VALOR                          := lQry.FieldByName('VALOR').AsString;
      modelo.CONSIGNADO                     := lQry.FieldByName('CONSIGNADO').AsString;
      modelo.CSOSN                          := lQry.FieldByName('CSOSN').AsString;
      modelo.CFOP_REFERENCIA                := lQry.FieldByName('CFOP_REFERENCIA').AsString;
      modelo.CONTA_CONTABIL                 := lQry.FieldByName('CONTA_CONTABIL').AsString;
      modelo.CST_ENTRADA                    := lQry.FieldByName('CST_ENTRADA').AsString;
      modelo.RESERVADO_FISCO                := lQry.FieldByName('RESERVADO_FISCO').AsString;
      modelo.ALTERA_CUSTO                   := lQry.FieldByName('ALTERA_CUSTO').AsString;
      modelo.IBPT                           := lQry.FieldByName('IBPT').AsString;
      modelo.OPERACAO                       := lQry.FieldByName('OPERACAO').AsString;
      modelo.ESTOQUE_2                      := lQry.FieldByName('ESTOQUE_2').AsString;
      modelo.CST_PIS                        := lQry.FieldByName('CST_PIS').AsString;
      modelo.CST_COFINS                     := lQry.FieldByName('CST_COFINS').AsString;
      modelo.CST_IPI                        := lQry.FieldByName('CST_IPI').AsString;
      modelo.ALIQUOTA_PIS                   := lQry.FieldByName('ALIQUOTA_PIS').AsString;
      modelo.ALIQUOTA_COFINS                := lQry.FieldByName('ALIQUOTA_COFINS').AsString;
      modelo.ALIQUOTA_IPI                   := lQry.FieldByName('ALIQUOTA_IPI').AsString;
      modelo.SOMAR_IPI_BASE_ICMS            := lQry.FieldByName('SOMAR_IPI_BASE_ICMS').AsString;
      modelo.STATUS                         := lQry.FieldByName('STATUS').AsString;
      modelo.LISTAR_IPI_SPED                := lQry.FieldByName('LISTAR_IPI_SPED').AsString;
      modelo.APROVEITAMENTO_ICMS            := lQry.FieldByName('APROVEITAMENTO_ICMS').AsString;
      modelo.REDUCAO_APROVEITAMENTO_ICMS    := lQry.FieldByName('REDUCAO_APROVEITAMENTO_ICMS').AsString;
      modelo.DESCONTO_SOBRE_IPI             := lQry.FieldByName('DESCONTO_SOBRE_IPI').AsString;
      modelo.SOMAR_PIS_COFINS_EM_OUTRAS     := lQry.FieldByName('SOMAR_PIS_COFINS_EM_OUTRAS').AsString;
      modelo.SOMAR_ICMS_TOTAL_NF            := lQry.FieldByName('SOMAR_ICMS_TOTAL_NF').AsString;
      modelo.CFOP_DEVOLUCAO                 := lQry.FieldByName('CFOP_DEVOLUCAO').AsString;
      modelo.MOTDESICMS                     := lQry.FieldByName('MOTDESICMS').AsString;
      modelo.CBENEF                         := lQry.FieldByName('CBENEF').AsString;
      modelo.PREDBC_N14                     := lQry.FieldByName('PREDBC_N14').AsString;
      modelo.CENQ                           := lQry.FieldByName('CENQ').AsString;
      modelo.SYSTIME                        := lQry.FieldByName('SYSTIME').AsString;
      modelo.PCRED_PRESUMIDO                := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
      modelo.DESCONTO_SOBRE_ICMS            := lQry.FieldByName('DESCONTO_SOBRE_ICMS').AsString;
      modelo.DESCONTO_ICMS_BASE_PIS_COFINS  := lQry.FieldByName('DESCONTO_ICMS_BASE_PIS_COFINS').AsString;
      modelo.OUTRAS_DESPESAS_ENTRADA        := lQry.FieldByName('OUTRAS_DESPESAS_ENTRADA').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCFOPDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCFOPDao.SetCFOPsLista;
begin
  FCFOPsLista := Value;
end;

procedure TCFOPDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCFOPDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCFOPDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCFOPDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCFOPDao.setParams(var pQry: TFDQuery; pCFOPModel: TCFOPModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CFOP');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TCFOPModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pCFOPModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pCFOPModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TCFOPDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCFOPDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCFOPDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
