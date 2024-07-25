unit EntradaItensXMLDao;

interface

uses
  EntradaItensXMLModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TEntradaItensXMLDao = class

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

    function incluir(AEntradaItensXMLModel: TEntradaItensXMLModel): String;
    function alterar(AEntradaItensXMLModel: TEntradaItensXMLModel): String;
    function excluir(AEntradaItensXMLModel: TEntradaItensXMLModel): String;

    function carregaClasse(pID : String): TEntradaItensXMLModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pEntradaItensXMLModel: TEntradaItensXMLModel);

end;

implementation

uses
  System.Rtti;

{ TEntradaItensXML }

function TEntradaItensXMLDao.carregaClasse(pID: String): TEntradaItensXMLModel;
var
  lQry: TFDQuery;
  lModel: TEntradaItensXMLModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TEntradaItensXMLModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ENTRADAITENS_XML where ID = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.CPROD                 := lQry.FieldByName('CPROD').AsString;
    lModel.CENAN                 := lQry.FieldByName('CENAN').AsString;
    lModel.XPROD                 := lQry.FieldByName('XPROD').AsString;
    lModel.NCM                   := lQry.FieldByName('NCM').AsString;
    lModel.CFOP                  := lQry.FieldByName('CFOP').AsString;
    lModel.UCOM                  := lQry.FieldByName('UCOM').AsString;
    lModel.QCOM                  := lQry.FieldByName('QCOM').AsString;
    lModel.VUNCOM                := lQry.FieldByName('VUNCOM').AsString;
    lModel.VPROD                 := lQry.FieldByName('VPROD').AsString;
    lModel.VFRETE                := lQry.FieldByName('VFRETE').AsString;
    lModel.VSEG                  := lQry.FieldByName('VSEG').AsString;
    lModel.VDESC                 := lQry.FieldByName('VDESC').AsString;
    lModel.VOUTRO                := lQry.FieldByName('VOUTRO').AsString;
    lModel.ICMS_CST              := lQry.FieldByName('ICMS_CST').AsString;
    lModel.ICMS_VBC              := lQry.FieldByName('ICMS_VBC').AsString;
    lModel.ICMS_PICMS            := lQry.FieldByName('ICMS_PICMS').AsString;
    lModel.ICMS_VICMS            := lQry.FieldByName('ICMS_VICMS').AsString;
    lModel.ICMS_PMVAST           := lQry.FieldByName('ICMS_PMVAST').AsString;
    lModel.ICMS_PREDBCST         := lQry.FieldByName('ICMS_PREDBCST').AsString;
    lModel.ICMS_VBCST            := lQry.FieldByName('ICMS_VBCST').AsString;
    lModel.ICMS_PICMSST          := lQry.FieldByName('ICMS_PICMSST').AsString;
    lModel.ICMS_VICMSST          := lQry.FieldByName('ICMS_VICMSST').AsString;
    lModel.ICMS_VBCSTRET         := lQry.FieldByName('ICMS_VBCSTRET').AsString;
    lModel.ICMS_PREDBC           := lQry.FieldByName('ICMS_PREDBC').AsString;
    lModel.ICMS_VICMSSTRET       := lQry.FieldByName('ICMS_VICMSSTRET').AsString;
    lModel.ICMS_VBCFCPSTRET      := lQry.FieldByName('ICMS_VBCFCPSTRET').AsString;
    lModel.ICMS_PFCPSTRET        := lQry.FieldByName('ICMS_PFCPSTRET').AsString;
    lModel.ICMS_VFCPSTRET        := lQry.FieldByName('ICMS_VFCPSTRET').AsString;
    lModel.ICMS_VBCFCP           := lQry.FieldByName('ICMS_VBCFCP').AsString;
    lModel.ICMS_PFCP             := lQry.FieldByName('ICMS_PFCP').AsString;
    lModel.ICMS_VFCP             := lQry.FieldByName('ICMS_VFCP').AsString;
    lModel.ICMS_PFCPST           := lQry.FieldByName('ICMS_PFCPST').AsString;
    lModel.ICMS_VBCFCPST         := lQry.FieldByName('ICMS_VBCFCPST').AsString;
    lModel.ICMS_VFCPST           := lQry.FieldByName('ICMS_VFCPST').AsString;
    lModel.ICMS_MODBCST          := lQry.FieldByName('ICMS_MODBCST').AsString;
    lModel.ICMS_CSOSN            := lQry.FieldByName('ICMS_CSOSN').AsString;
    lModel.IPI_CST               := lQry.FieldByName('IPI_CST').AsString;
    lModel.IPI_CIENQ             := lQry.FieldByName('IPI_CIENQ').AsString;
    lModel.IPI_CENQ              := lQry.FieldByName('IPI_CENQ').AsString;
    lModel.IPI_VBC               := lQry.FieldByName('IPI_VBC').AsString;
    lModel.IPI_QUNID             := lQry.FieldByName('IPI_QUNID').AsString;
    lModel.IPI_VUNID             := lQry.FieldByName('IPI_VUNID').AsString;
    lModel.IPI_PIPI              := lQry.FieldByName('IPI_PIPI').AsString;
    lModel.IPI_VIPI              := lQry.FieldByName('IPI_VIPI').AsString;
    lModel.II_VBC                := lQry.FieldByName('II_VBC').AsString;
    lModel.II_VDESPADU           := lQry.FieldByName('II_VDESPADU').AsString;
    lModel.II_VII                := lQry.FieldByName('II_VII').AsString;
    lModel.II_VIOF               := lQry.FieldByName('II_VIOF').AsString;
    lModel.PIS_CST               := lQry.FieldByName('PIS_CST').AsString;
    lModel.PIS_VBC               := lQry.FieldByName('PIS_VBC').AsString;
    lModel.PIS_PPIS              := lQry.FieldByName('PIS_PPIS').AsString;
    lModel.PIS_VPIS              := lQry.FieldByName('PIS_VPIS').AsString;
    lModel.PIS_QBCPROD           := lQry.FieldByName('PIS_QBCPROD').AsString;
    lModel.PIS_VALIQPROD         := lQry.FieldByName('PIS_VALIQPROD').AsString;
    lModel.PIS_ST_VBC            := lQry.FieldByName('PIS_ST_VBC').AsString;
    lModel.PIS_ST_PPIS           := lQry.FieldByName('PIS_ST_PPIS').AsString;
    lModel.PIS_ST_QBCPROD        := lQry.FieldByName('PIS_ST_QBCPROD').AsString;
    lModel.PIS_ST_VALIQPROD      := lQry.FieldByName('PIS_ST_VALIQPROD').AsString;
    lModel.PIS_ST_VPIS           := lQry.FieldByName('PIS_ST_VPIS').AsString;
    lModel.COFINS_CST            := lQry.FieldByName('COFINS_CST').AsString;
    lModel.COFINS_VBC            := lQry.FieldByName('COFINS_VBC').AsString;
    lModel.COFINS_PCOFINS        := lQry.FieldByName('COFINS_PCOFINS').AsString;
    lModel.COFINS_VCOFINS        := lQry.FieldByName('COFINS_VCOFINS').AsString;
    lModel.COFINS_QBCPROD        := lQry.FieldByName('COFINS_QBCPROD').AsString;
    lModel.COFINS_VALIQPROD      := lQry.FieldByName('COFINS_VALIQPROD').AsString;
    lModel.COFINS_ST_VBC         := lQry.FieldByName('COFINS_ST_VBC').AsString;
    lModel.COFINS_ST_PCOFINS     := lQry.FieldByName('COFINS_ST_PCOFINS').AsString;
    lModel.COFINS_ST_QBCPROD     := lQry.FieldByName('COFINS_ST_QBCPROD').AsString;
    lModel.COFINS_ST_VALIQPROD   := lQry.FieldByName('COFINS_ST_VALIQPROD').AsString;
    lModel.COFINS_ST_VCOFINS     := lQry.FieldByName('COFINS_ST_VCOFINS').AsString;
    lModel.PRODUTO_ID_VINCULO    := lQry.FieldByName('PRODUTO_ID_VINCULO').AsString;
    lModel.ICMS_ORIG             := lQry.FieldByName('ICMS_ORIG').AsString;
    lModel.ICMS_MODBC            := lQry.FieldByName('ICMS_MODBC').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TEntradaItensXMLDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TEntradaItensXMLDao.Destroy;
begin
  inherited;
end;

function TEntradaItensXMLDao.incluir(AEntradaItensXMLModel: TEntradaItensXMLModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ENTRADAITENS_XML', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    AEntradaItensXMLModel.ID := vIConexao.Generetor('GEN_ENTRADAITENS_XML');
    setParams(lQry, AEntradaItensXMLModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TEntradaItensXMLDao.alterar(AEntradaItensXMLModel: TEntradaItensXMLModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('ENTRADAITENS_XML','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AEntradaItensXMLModel);
    lQry.ExecSQL;

    Result := AEntradaItensXMLModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TEntradaItensXMLDao.excluir(AEntradaItensXMLModel: TEntradaItensXMLModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ENTRADAITENS_XML where ID = :ID',[AEntradaItensXMLModel.ID]);
   lQry.ExecSQL;
   Result := AEntradaItensXMLModel.ID;

  finally
    lQry.Free;
  end;
end;

function TEntradaItensXMLDao.where: String;
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

procedure TEntradaItensXMLDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From ENTRADAITENS_XML where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TEntradaItensXMLDao.obterLista: IFDDataset;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       ENTRADAITENS_XML.*       '+
	    '  from EntradaItensXML          '+
      ' where 1=1                      ';

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

procedure TEntradaItensXMLDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TEntradaItensXMLDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEntradaItensXMLDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TEntradaItensXMLDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TEntradaItensXMLDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TEntradaItensXMLDao.setParams(var pQry: TFDQuery; pEntradaItensXMLModel: TEntradaItensXMLModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('ENTRADAITENS_XML');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TEntradaItensXMLModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pEntradaItensXMLModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pEntradaItensXMLModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TEntradaItensXMLDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TEntradaItensXMLDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TEntradaItensXMLDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
