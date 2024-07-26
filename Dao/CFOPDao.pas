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
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TCFOPDao = class;
  ITCFOPDao=IObject<TCFOPDao>;

  TCFOPDao = class
  private
    [weak] mySelf: ITCFOPDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FCFOPsLista: IList<ITCFOPModel>;
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
    procedure SetCFOPsLista(const Value: IList<ITCFOPModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

    procedure setParams(var pQry: TFDQuery; pCFOPModel: ITCFOPModel);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCFOPDao;

    property CFOPsLista: IList<ITCFOPModel> read FCFOPsLista write SetCFOPsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ACFOPModel: ITCFOPModel): String;
    function alterar(ACFOPModel: ITCFOPModel): String;
    function excluir(ACFOPModel: ITCFOPModel): String;
	
    procedure obterLista;

    function carregaClasse(pId: String): ITCFOPModel;
    function obterCFOP(pIdCFOP: String): String;

end;

implementation

uses
  System.Rtti;

{ TCFOP }

function TCFOPDao.carregaClasse(pId: String): ITCFOPModel;
var
  lQry: TFDQuery;
  lModel: ITCFOPModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCFOPModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from cfop where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                             := lQry.FieldByName('ID').AsString;
    lModel.objeto.CFOP                           := lQry.FieldByName('CFOP').AsString;
    lModel.objeto.DESCRICAO                      := lQry.FieldByName('DESCRICAO').AsString;
    lModel.objeto.TIPO                           := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.ESTOQUE                        := lQry.FieldByName('ESTOQUE').AsString;
    lModel.objeto.ICMS                           := lQry.FieldByName('ICMS').AsString;
    lModel.objeto.CST                            := lQry.FieldByName('CST').AsString;
    lModel.objeto.OBS                            := lQry.FieldByName('OBS').AsString;
    lModel.objeto.PIS                            := lQry.FieldByName('PIS').AsString;
    lModel.objeto.COFINS                         := lQry.FieldByName('COFINS').AsString;
    lModel.objeto.VALOR                          := lQry.FieldByName('VALOR').AsString;
    lModel.objeto.CONSIGNADO                     := lQry.FieldByName('CONSIGNADO').AsString;
    lModel.objeto.CSOSN                          := lQry.FieldByName('CSOSN').AsString;
    lModel.objeto.CFOP_REFERENCIA                := lQry.FieldByName('CFOP_REFERENCIA').AsString;
    lModel.objeto.CONTA_CONTABIL                 := lQry.FieldByName('CONTA_CONTABIL').AsString;
    lModel.objeto.CST_ENTRADA                    := lQry.FieldByName('CST_ENTRADA').AsString;
    lModel.objeto.RESERVADO_FISCO                := lQry.FieldByName('RESERVADO_FISCO').AsString;
    lModel.objeto.ALTERA_CUSTO                   := lQry.FieldByName('ALTERA_CUSTO').AsString;
    lModel.objeto.IBPT                           := lQry.FieldByName('IBPT').AsString;
    lModel.objeto.OPERACAO                       := lQry.FieldByName('OPERACAO').AsString;
    lModel.objeto.ESTOQUE_2                      := lQry.FieldByName('ESTOQUE_2').AsString;
    lModel.objeto.CST_PIS                        := lQry.FieldByName('CST_PIS').AsString;
    lModel.objeto.CST_COFINS                     := lQry.FieldByName('CST_COFINS').AsString;
    lModel.objeto.CST_IPI                        := lQry.FieldByName('CST_IPI').AsString;
    lModel.objeto.ALIQUOTA_PIS                   := lQry.FieldByName('ALIQUOTA_PIS').AsString;
    lModel.objeto.ALIQUOTA_COFINS                := lQry.FieldByName('ALIQUOTA_COFINS').AsString;
    lModel.objeto.ALIQUOTA_IPI                   := lQry.FieldByName('ALIQUOTA_IPI').AsString;
    lModel.objeto.SOMAR_IPI_BASE_ICMS            := lQry.FieldByName('SOMAR_IPI_BASE_ICMS').AsString;
    lModel.objeto.STATUS                         := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.LISTAR_IPI_SPED                := lQry.FieldByName('LISTAR_IPI_SPED').AsString;
    lModel.objeto.APROVEITAMENTO_ICMS            := lQry.FieldByName('APROVEITAMENTO_ICMS').AsString;
    lModel.objeto.REDUCAO_APROVEITAMENTO_ICMS    := lQry.FieldByName('REDUCAO_APROVEITAMENTO_ICMS').AsString;
    lModel.objeto.DESCONTO_SOBRE_IPI             := lQry.FieldByName('DESCONTO_SOBRE_IPI').AsString;
    lModel.objeto.SOMAR_PIS_COFINS_EM_OUTRAS     := lQry.FieldByName('SOMAR_PIS_COFINS_EM_OUTRAS').AsString;
    lModel.objeto.SOMAR_ICMS_TOTAL_NF            := lQry.FieldByName('SOMAR_ICMS_TOTAL_NF').AsString;
    lModel.objeto.CFOP_DEVOLUCAO                 := lQry.FieldByName('CFOP_DEVOLUCAO').AsString;
    lModel.objeto.MOTDESICMS                     := lQry.FieldByName('MOTDESICMS').AsString;
    lModel.objeto.CBENEF                         := lQry.FieldByName('CBENEF').AsString;
    lModel.objeto.PREDBC_N14                     := lQry.FieldByName('PREDBC_N14').AsString;
    lModel.objeto.CENQ                           := lQry.FieldByName('CENQ').AsString;
    lModel.objeto.SYSTIME                        := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.PCRED_PRESUMIDO                := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
    lModel.objeto.DESCONTO_SOBRE_ICMS            := lQry.FieldByName('DESCONTO_SOBRE_ICMS').AsString;
    lModel.objeto.DESCONTO_ICMS_BASE_PIS_COFINS  := lQry.FieldByName('DESCONTO_ICMS_BASE_PIS_COFINS').AsString;
    lModel.objeto.OUTRAS_DESPESAS_ENTRADA        := lQry.FieldByName('OUTRAS_DESPESAS_ENTRADA').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCFOPDao._Create(pIConexao :IConexao);
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

function TCFOPDao.incluir(ACFOPModel: ITCFOPModel): String;
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

function TCFOPDao.alterar(ACFOPModel: ITCFOPModel): String;
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

    Result := ACFOPModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCFOPDao.excluir(ACFOPModel: ITCFOPModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CFOP where ID = :ID',[ACFOPModel.objeto.ID]);
   lQry.ExecSQL;
   Result := ACFOPModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TCFOPDao.getNewIface(pIConexao: IConexao): ITCFOPDao;
begin
  Result := TImplObjetoOwner<TCFOPDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
  modelo: ITCFOPModel;
begin
  lQry := vIConexao.CriarQuery;

  FCFOPsLista := TCollections.CreateList<ITCFOPModel>;

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
      modelo := TCFOPModel.getNewIface(vIConexao);
      FCFOPsLista.Add(modelo);

      modelo.objeto.ID                             := lQry.FieldByName('ID').AsString;
      modelo.objeto.CFOP                           := lQry.FieldByName('CFOP').AsString;
      modelo.objeto.DESCRICAO                      := lQry.FieldByName('DESCRICAO').AsString;
      modelo.objeto.TIPO                           := lQry.FieldByName('TIPO').AsString;
      modelo.objeto.ESTOQUE                        := lQry.FieldByName('ESTOQUE').AsString;
      modelo.objeto.ICMS                           := lQry.FieldByName('ICMS').AsString;
      modelo.objeto.CST                            := lQry.FieldByName('CST').AsString;
      modelo.objeto.OBS                            := lQry.FieldByName('OBS').AsString;
      modelo.objeto.PIS                            := lQry.FieldByName('PIS').AsString;
      modelo.objeto.COFINS                         := lQry.FieldByName('COFINS').AsString;
      modelo.objeto.VALOR                          := lQry.FieldByName('VALOR').AsString;
      modelo.objeto.CONSIGNADO                     := lQry.FieldByName('CONSIGNADO').AsString;
      modelo.objeto.CSOSN                          := lQry.FieldByName('CSOSN').AsString;
      modelo.objeto.CFOP_REFERENCIA                := lQry.FieldByName('CFOP_REFERENCIA').AsString;
      modelo.objeto.CONTA_CONTABIL                 := lQry.FieldByName('CONTA_CONTABIL').AsString;
      modelo.objeto.CST_ENTRADA                    := lQry.FieldByName('CST_ENTRADA').AsString;
      modelo.objeto.RESERVADO_FISCO                := lQry.FieldByName('RESERVADO_FISCO').AsString;
      modelo.objeto.ALTERA_CUSTO                   := lQry.FieldByName('ALTERA_CUSTO').AsString;
      modelo.objeto.IBPT                           := lQry.FieldByName('IBPT').AsString;
      modelo.objeto.OPERACAO                       := lQry.FieldByName('OPERACAO').AsString;
      modelo.objeto.ESTOQUE_2                      := lQry.FieldByName('ESTOQUE_2').AsString;
      modelo.objeto.CST_PIS                        := lQry.FieldByName('CST_PIS').AsString;
      modelo.objeto.CST_COFINS                     := lQry.FieldByName('CST_COFINS').AsString;
      modelo.objeto.CST_IPI                        := lQry.FieldByName('CST_IPI').AsString;
      modelo.objeto.ALIQUOTA_PIS                   := lQry.FieldByName('ALIQUOTA_PIS').AsString;
      modelo.objeto.ALIQUOTA_COFINS                := lQry.FieldByName('ALIQUOTA_COFINS').AsString;
      modelo.objeto.ALIQUOTA_IPI                   := lQry.FieldByName('ALIQUOTA_IPI').AsString;
      modelo.objeto.SOMAR_IPI_BASE_ICMS            := lQry.FieldByName('SOMAR_IPI_BASE_ICMS').AsString;
      modelo.objeto.STATUS                         := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.LISTAR_IPI_SPED                := lQry.FieldByName('LISTAR_IPI_SPED').AsString;
      modelo.objeto.APROVEITAMENTO_ICMS            := lQry.FieldByName('APROVEITAMENTO_ICMS').AsString;
      modelo.objeto.REDUCAO_APROVEITAMENTO_ICMS    := lQry.FieldByName('REDUCAO_APROVEITAMENTO_ICMS').AsString;
      modelo.objeto.DESCONTO_SOBRE_IPI             := lQry.FieldByName('DESCONTO_SOBRE_IPI').AsString;
      modelo.objeto.SOMAR_PIS_COFINS_EM_OUTRAS     := lQry.FieldByName('SOMAR_PIS_COFINS_EM_OUTRAS').AsString;
      modelo.objeto.SOMAR_ICMS_TOTAL_NF            := lQry.FieldByName('SOMAR_ICMS_TOTAL_NF').AsString;
      modelo.objeto.CFOP_DEVOLUCAO                 := lQry.FieldByName('CFOP_DEVOLUCAO').AsString;
      modelo.objeto.MOTDESICMS                     := lQry.FieldByName('MOTDESICMS').AsString;
      modelo.objeto.CBENEF                         := lQry.FieldByName('CBENEF').AsString;
      modelo.objeto.PREDBC_N14                     := lQry.FieldByName('PREDBC_N14').AsString;
      modelo.objeto.CENQ                           := lQry.FieldByName('CENQ').AsString;
      modelo.objeto.SYSTIME                        := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.PCRED_PRESUMIDO                := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
      modelo.objeto.DESCONTO_SOBRE_ICMS            := lQry.FieldByName('DESCONTO_SOBRE_ICMS').AsString;
      modelo.objeto.DESCONTO_ICMS_BASE_PIS_COFINS  := lQry.FieldByName('DESCONTO_ICMS_BASE_PIS_COFINS').AsString;
      modelo.objeto.OUTRAS_DESPESAS_ENTRADA        := lQry.FieldByName('OUTRAS_DESPESAS_ENTRADA').AsString;

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

procedure TCFOPDao.setParams(var pQry: TFDQuery; pCFOPModel: ITCFOPModel);
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pCFOPModel.objeto).AsString = '',
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
