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
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  OrcamentoItensModel;

type
  TOrcamentoItensDao = class;
  ITOrcamentoItensDao=IObject<TOrcamentoItensDao>;

  TOrcamentoItensDao = class
  private
    [weak] mySelf: ITOrcamentoItensDao;
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
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITOrcamentoItensDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pOrcamentoItensModel: ITOrcamentoItensModel): String;
    function alterar(pOrcamentoItensModel: ITOrcamentoItensModel): String;
    function excluir(pOrcamentoItensModel: ITOrcamentoItensModel): String;

    function carregaClasse(pID : String): ITOrcamentoItensModel;

    function obterLista: IFDDataset;

    procedure quantidadeAtendida(pNumeroOrc: String);

    procedure setParams(var pQry: TFDQuery; pOrcamentoItensModel: ITOrcamentoItensModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TOrcamentoItens }

function TOrcamentoItensDao.alterar(pOrcamentoItensModel: ITOrcamentoItensModel): String;
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

    Result := pOrcamentoItensModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TOrcamentoItensDao.carregaClasse(pID: String): ITOrcamentoItensModel;
var
  lQry: TFDQuery;
  lModel: ITOrcamentoItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TOrcamentoItensModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ORCAMENTOITENS where NUMERO_ORC = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_ORC            := lQry.FieldByName('NUMERO_ORC').AsString;
    lModel.objeto.CODIGO_PRO            := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.objeto.VALORUNITARIO_ORC     := lQry.FieldByName('VALORUNITARIO_ORC').AsString;
    lModel.objeto.QUANTIDADE_ORC        := lQry.FieldByName('QUANTIDADE_ORC').AsString;
    lModel.objeto.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.OBSERVACAO            := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.objeto.OBS                   := lQry.FieldByName('OBS').AsString;
    lModel.objeto.ID                    := lQry.FieldByName('ID').AsString;
    lModel.objeto.QUANTIDADE_ATE_ORC    := lQry.FieldByName('QUANTIDADE_ATE_ORC').AsString;
    lModel.objeto.NUMERO_SERIE_ITEM     := lQry.FieldByName('NUMERO_SERIE_ITEM').AsString;
    lModel.objeto.VLRGARANTIA_ORC       := lQry.FieldByName('VLRGARANTIA_ORC').AsString;
    lModel.objeto.CODBARRAS_ORC         := lQry.FieldByName('CODBARRAS_ORC').AsString;
    lModel.objeto.PERCENTUAL_IPI        := lQry.FieldByName('PERCENTUAL_IPI').AsString;
    lModel.objeto.VALOR_IPI             := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.objeto.MVA_ST                := lQry.FieldByName('MVA_ST').AsString;
    lModel.objeto.BASE_ST               := lQry.FieldByName('BASE_ST').AsString;
    lModel.objeto.REDUTOR_ST            := lQry.FieldByName('REDUTOR_ST').AsString;
    lModel.objeto.PERCENTUAL_ST         := lQry.FieldByName('PERCENTUAL_ST').AsString;
    lModel.objeto.VALOR_ST              := lQry.FieldByName('VALOR_ST').AsString;
    lModel.objeto.BASE_ICMS             := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.objeto.PERCENTUAL_ICMS       := lQry.FieldByName('PERCENTUAL_ICMS').AsString;
    lModel.objeto.CST_ICMS              := lQry.FieldByName('CST_ICMS').AsString;
    lModel.objeto.VALOR_ICMS            := lQry.FieldByName('VALOR_ICMS').AsString;
    lModel.objeto.DESCONTO_ORC          := lQry.FieldByName('DESCONTO_ORC').AsString;
    lModel.objeto.VLRCUSTO_ORC          := lQry.FieldByName('VLRCUSTO_ORC').AsString;
    lModel.objeto.ALTURA_M              := lQry.FieldByName('ALTURA_M').AsString;
    lModel.objeto.LARGURA_M             := lQry.FieldByName('LARGURA_M').AsString;
    lModel.objeto.PROFUNDIDADE_M        := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.objeto.VBCUFDEST             := lQry.FieldByName('VBCUFDEST').AsString;
    lModel.objeto.PFCPUFDEST            := lQry.FieldByName('PFCPUFDEST').AsString;
    lModel.objeto.PICMSUFDEST           := lQry.FieldByName('PICMSUFDEST').AsString;
    lModel.objeto.PICMSINTER            := lQry.FieldByName('PICMSINTER').AsString;
    lModel.objeto.PICMSINTERPART        := lQry.FieldByName('PICMSINTERPART').AsString;
    lModel.objeto.VFCPUFDEST            := lQry.FieldByName('VFCPUFDEST').AsString;
    lModel.objeto.VICMSUFDEST           := lQry.FieldByName('VICMSUFDEST').AsString;
    lModel.objeto.VICMSUFREMET          := lQry.FieldByName('VICMSUFREMET').AsString;
    lModel.objeto.CFOP_ID               := lQry.FieldByName('CFOP_ID').AsString;
    lModel.objeto.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.PEDIDOCOMPRA_ID       := lQry.FieldByName('PEDIDOCOMPRA_ID').AsString;
    lModel.objeto.PEDIDOCOMPRAITENS_ID  := lQry.FieldByName('PEDIDOCOMPRAITENS_ID').AsString;
    lModel.objeto.VBCFCPST              := lQry.FieldByName('VBCFCPST').AsString;
    lModel.objeto.PFCPST                := lQry.FieldByName('PFCPST').AsString;
    lModel.objeto.VFCPST                := lQry.FieldByName('VFCPST').AsString;
    lModel.objeto.VALOR_VENDA_CADASTRO  := lQry.FieldByName('VALOR_VENDA_CADASTRO').AsString;
    lModel.objeto.DESCRICAO_PRODUTO     := lQry.FieldByName('DESCRICAO_PRODUTO').AsString;
    lModel.objeto.PCRED_PRESUMIDO       := lQry.FieldByName('PCRED_PRESUMIDO').AsString;
    lModel.objeto.COMBO_ITEM            := lQry.FieldByName('COMBO_ITEM').AsString;
    lModel.objeto.QTD_CHECAGEM          := lQry.FieldByName('QTD_CHECAGEM').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TOrcamentoItensDao._Create(pIConexao : IConexao);
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

function TOrcamentoItensDao.excluir(pOrcamentoItensModel: ITOrcamentoItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ORCAMENTOITENS where ID = :ID' ,[pOrcamentoItensModel.objeto.ID]);
   Result := pOrcamentoItensModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TOrcamentoItensDao.getNewIface(pIConexao: IConexao): ITOrcamentoItensDao;
begin

end;

function TOrcamentoItensDao.incluir(pOrcamentoItensModel: ITOrcamentoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ORCAMENTOITENS', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pOrcamentoItensModel.objeto.ID := vIConexao.Generetor('GEN_ORCAMENTOITENS');
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

procedure TOrcamentoItensDao.setParams(var pQry: TFDQuery; pOrcamentoItensModel: ITOrcamentoItensModel);
begin
  vConstrutor.setParams('ORCAMENTOITENS',pQry,pOrcamentoItensModel.objeto);
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
