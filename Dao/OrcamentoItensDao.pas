unit OrcamentoItensDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  OrcamentoItensModel;

type
  TOrcamentoItensDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

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
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pOrcamentoItensModel: TOrcamentoItensModel): String;
    function alterar(pOrcamentoItensModel: TOrcamentoItensModel): String;
    function excluir(pOrcamentoItensModel: TOrcamentoItensModel): String;

    function carregaClasse(pID : String): TOrcamentoItensModel;

    function obterLista: IFDDataset;

    procedure quantidadeAtendida(pNumeroOrc: String);

    procedure setParams(var pQry: TFDQuery; pOrcamentoItensModel: TOrcamentoItensModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TOrcamentoItens }

function TOrcamentoItensDao.alterar(pOrcamentoItensModel: TOrcamentoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('ORCAMENTOITENS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pOrcamentoItensModel);
    lQry.ExecSQL;

    Result := pOrcamentoItensModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TOrcamentoItensDao.carregaClasse(pID: String): TOrcamentoItensModel;
var
  lQry: TFDQuery;
  lModel: TOrcamentoItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TOrcamentoItensModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ORCAMENTOITENS where NUMERO_ORC = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_ORC            := lQry.FieldByName('NUMERO_ORC').AsString;
    lModel.CODIGO_PRO            := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.VALORUNITARIO_ORC     := lQry.FieldByName('VALORUNITARIO_ORC').AsString;
    lModel.QUANTIDADE_ORC        := lQry.FieldByName('QUANTIDADE_ORC').AsString;
    lModel.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.OBSERVACAO            := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.OBS                   := lQry.FieldByName('OBS').AsString;
    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.QUANTIDADE_ATE_ORC    := lQry.FieldByName('QUANTIDADE_ATE_ORC').AsString;
    lModel.NUMERO_SERIE_ITEM     := lQry.FieldByName('NUMERO_SERIE_ITEM').AsString;
    lModel.VLRGARANTIA_ORC       := lQry.FieldByName('VLRGARANTIA_ORC').AsString;
    lModel.CODBARRAS_ORC         := lQry.FieldByName('CODBARRAS_ORC').AsString;
    lModel.PERCENTUAL_IPI        := lQry.FieldByName('PERCENTUAL_IPI').AsString;
    lModel.VALOR_IPI             := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.MVA_ST                := lQry.FieldByName('MVA_ST').AsString;
    lModel.BASE_ST               := lQry.FieldByName('BASE_ST').AsString;
    lModel.REDUTOR_ST            := lQry.FieldByName('REDUTOR_ST').AsString;
    lModel.PERCENTUAL_ST         := lQry.FieldByName('PERCENTUAL_ST').AsString;
    lModel.VALOR_ST              := lQry.FieldByName('VALOR_ST').AsString;
    lModel.BASE_ICMS             := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.PERCENTUAL_ICMS       := lQry.FieldByName('PERCENTUAL_ICMS').AsString;
    lModel.CST_ICMS              := lQry.FieldByName('CST_ICMS').AsString;
    lModel.VALOR_ICMS            := lQry.FieldByName('VALOR_ICMS').AsString;
    lModel.DESCONTO_ORC          := lQry.FieldByName('DESCONTO_ORC').AsString;
    lModel.VLRCUSTO_ORC          := lQry.FieldByName('VLRCUSTO_ORC').AsString;
    lModel.ALTURA_M              := lQry.FieldByName('ALTURA_M').AsString;
    lModel.LARGURA_M             := lQry.FieldByName('LARGURA_M').AsString;
    lModel.PROFUNDIDADE_M        := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.VBCUFDEST             := lQry.FieldByName('VBCUFDEST').AsString;
    lModel.PFCPUFDEST            := lQry.FieldByName('PFCPUFDEST').AsString;
    lModel.PICMSUFDEST           := lQry.FieldByName('PICMSUFDEST').AsString;
    lModel.PICMSINTER            := lQry.FieldByName('PICMSINTER').AsString;
    lModel.PICMSINTERPART        := lQry.FieldByName('PICMSINTERPART').AsString;
    lModel.VFCPUFDEST            := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.VICMSUFDEST           := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.VICMSUFREMET          := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.CFOP_ID               := lQry.FieldByName('CFOP_ID').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.PEDIDOCOMPRA_ID       := lQry.FieldByName('PEDIDOCOMPRA_ID').AsString;
    lModel.PEDIDOCOMPRAITENS_ID  := lQry.FieldByName('PEDIDOCOMPRAITENS_ID').AsString;
    lModel.VBCFCPST              := lQry.FieldByName('VBCFCPST').AsString;
    lModel.PFCPST                := lQry.FieldByName('PFCPST').AsString;
    lModel.VFCPST                := lQry.FieldByName('VFCPST').AsString;
    lModel.VALOR_VENDA_CADASTRO  := lQry.FieldByName('VALOR_VENDA_CADASTRO').AsString;
    lModel.DESCRICAO_PRODUTO     := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
    lModel.PCRED_PRESUMIDO       := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
    lModel.COMBO_ITEM            := lQry.FieldByName('COMBO_ITEM').AsString;
    lModel.QTD_CHECAGEM          := lQry.FieldByName('QTD_CHECAGEM').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TOrcamentoItensDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TOrcamentoItensDao.Destroy;
begin
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TOrcamentoItensDao.excluir(pOrcamentoItensModel: TOrcamentoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ORCAMENTOITENS where ID = :ID' ,[pOrcamentoItensModel.ID]);
   Result := pOrcamentoItensModel.ID;

  finally
    lQry.Free;
  end;
end;
function TOrcamentoItensDao.incluir(pOrcamentoItensModel: TOrcamentoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ORCAMENTOITENS', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pOrcamentoItensModel.ID := vIConexao.Generetor('GEN_ORCAMENTOITENS');
    setParams(lQry, pOrcamentoItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TOrcamentoItensDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                                               '+SLineBreak+
              '     P.BARRAS_PRO,                                                                                   '+SlineBreak+
              '     P.CODLISTA_COD,                                                                                 '+SlineBreak+
              '     P.REFERENCIA_NEW,                                                                               '+SlineBreak+
              '     P.CODIGO_PRO,                                                                                   '+SlineBreak+
              '     P.NOME_PRO,                                                                                     '+SlineBreak+
              '     I.OBSERVACAO,                                                                                   '+SlineBreak+
              '     I.VLRCUSTO_ORC,                                                                                 '+SlineBreak+
              '     I.VLRGARANTIA_ORC,                                                                              '+SlineBreak+
              '     COALESCE(COALESCE(I.QUANTIDADE_ORC, 0) - COALESCE(I.QUANTIDADE_ATE_ORC, 0),0) QUANTIDADE_ORC,   '+SlineBreak+
              '     COALESCE(I.VALORUNITARIO_ORC, 0) VALORUNITARIO_ORC,                                             '+SlineBreak+
              '     COALESCE(I.DESCONTO_ORC, 0) DESCONTO_ORC,                                                       '+SlineBreak+
              '     CAST(I.QUANTIDADE_ORC AS DOUBLE PRECISION) * (I.VALORUNITARIO_ORC - (I.DESCONTO_ORC / 100 * I.VALORUNITARIO_ORC)) AS TOTAL '+SlineBreak+
              ' FROM                                                                                                '+SlineBreak+
              '     ORCAMENTOITENS I                                                                                '+SlineBreak+
              ' INNER JOIN PRODUTO P ON                                                                             '+SlineBreak+
              '     I.CODIGO_PRO = P.CODIGO_PRO                                                                     '+SlineBreak+
              ' WHERE                                                                                               '+SlineBreak+
              '     COALESCE(COALESCE(I.QUANTIDADE_ORC, 0) - COALESCE(I.QUANTIDADE_ATE_ORC, 0),0) > 0               '+SlineBreak;

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

procedure TOrcamentoItensDao.quantidadeAtendida(pNumeroOrc : String);
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;
  try
      lSQL :=
              ' UPDATE ORCAMENTOITENS O                      '+SLineBreak+
              ' SET O.QUANTIDADE_ATE_ORC = O.QUANTIDADE_ORC  '+SLineBreak+
              ' WHERE O.NUMERO_ORC = '+QuotedStr(pNumeroOrc)  +SLineBreak;

    lQry.ExecSQL(lSQL);
  finally
    lQry.Free;
  end;
end;

procedure TOrcamentoItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From ORCAMENTOITENS I where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TOrcamentoItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TOrcamentoItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TOrcamentoItensDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TOrcamentoItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TOrcamentoItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TOrcamentoItensDao.setParams(var pQry: TFDQuery; pOrcamentoItensModel: TOrcamentoItensModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('ORCAMENTOITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TOrcamentoItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pOrcamentoItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pOrcamentoItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TOrcamentoItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TOrcamentoItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TOrcamentoItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TOrcamentoItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and ID = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

end.
