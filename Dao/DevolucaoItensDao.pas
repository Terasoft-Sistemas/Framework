unit DevolucaoItensDao;

interface

uses
  DevolucaoItensModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TDevolucaoItensDao = class;
  ITDevolucaoItensDao=IObject<TDevolucaoItensDao>;

  TDevolucaoItensDao = class
  private
    [weak] mySelf: ITDevolucaoItensDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

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
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDRecordView(const Value: String);

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDevolucaoItensDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pDevolucaoItensModel: ITDevolucaoItensModel): String;
    function alterar(pDevolucaoItensModel: ITDevolucaoItensModel): String;
    function excluir(pDevolucaoItensModel: ITDevolucaoItensModel): String;

    function carregaClasse(pID, pProduto, pItem : String): ITDevolucaoItensModel;
    function obterLista: IFDDataset;
    procedure setParams(var pQry: TFDQuery; pDevolucaoItensModel: ITDevolucaoItensModel);
    function proximoItem(pDevolucao : String): String;
    function calculaTotais(pDevolucao : String): IFDDataset;

end;

implementation

uses
  System.Rtti;

{ TDevolucaoItens }

function TDevolucaoItensDao.calculaTotais(pDevolucao: String): IFDDataset;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := ' select coalesce(sum(quantidade * valor_unitario), 0) Total  '+SLineBreak+
            '   from devolucaoItens                                       '+SLineBreak+
            '  where id = ' + QuotedStr(pDevolucao);

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

function TDevolucaoItensDao.carregaClasse(pID, pProduto, pItem : String): ITDevolucaoItensModel;
var
  lQry: TFDQuery;
  lModel: ITDevolucaoItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TDevolucaoItensModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open(' select * '+
              '   from devolucaoitens '+
              '  where id = ' +QuotedStr(pID) +
              '    and produto = ' + QuotedStr(pProduto) +
              '    and item = ' + QuotedStr(pItem));

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                      := lQry.FieldByName('ID').AsString;
    lModel.objeto.PRODUTO                 := lQry.FieldByName('PRODUTO').AsString;
    lModel.objeto.VALOR_UNITARIO          := lQry.FieldByName('VALOR_UNITARIO').AsString;
    lModel.objeto.QUANTIDADE              := lQry.FieldByName('QUANTIDADE').AsString;
    lModel.objeto.LOJA                    := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.CUSTO                   := lQry.FieldByName('CUSTO').AsString;
    lModel.objeto.COMISSAO_DEV            := lQry.FieldByName('COMISSAO_DEV').AsString;
    lModel.objeto.PEDIDO_ID               := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.objeto.VALOR_ST                := lQry.FieldByName('VALOR_ST').AsString;
    lModel.objeto.COMISSAO_PERCENTUAL     := lQry.FieldByName('COMISSAO_PERCENTUAL').AsString;
    lModel.objeto.FRETE                   := lQry.FieldByName('FRETE').AsString;
    lModel.objeto.COMANDA                 := lQry.FieldByName('COMANDA').AsString;
    lModel.objeto.ALTURA_M                := lQry.FieldByName('ALTURA_M').AsString;
    lModel.objeto.LARGURA_M               := lQry.FieldByName('LARGURA_M').AsString;
    lModel.objeto.PROFUNDIDADE_M          := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.objeto.ITEM                    := lQry.FieldByName('ITEM').AsString;
    lModel.objeto.DESCONTO_PED            := lQry.FieldByName('DESCONTO_PED').AsString;
    lModel.objeto.VALOR_SUFRAMA           := lQry.FieldByName('VALOR_SUFRAMA').AsString;
    lModel.objeto.SYSTIME                 := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.VALOR_IPI               := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.objeto.VALOR_ACRESCIMO         := lQry.FieldByName('VALOR_ACRESCIMO').AsString;
    lModel.objeto.VFCPST                  := lQry.FieldByName('VFCPST').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TDevolucaoItensDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TDevolucaoItensDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TDevolucaoItensDao.incluir(pDevolucaoItensModel: ITDevolucaoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('DEVOLUCAOITENS', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pDevolucaoItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDevolucaoItensDao.alterar(pDevolucaoItensModel: ITDevolucaoItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('DEVOLUCAOITENS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pDevolucaoItensModel);
    lQry.ExecSQL;

    Result := pDevolucaoItensModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDevolucaoItensDao.excluir(pDevolucaoItensModel: ITDevolucaoItensModel): String;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete '+
                '  from devolucaoitens '+
                ' where id = '+ QuotedStr(pDevolucaoItensModel.objeto.ID) +
                '   and produto = ' + QuotedStr(pDevolucaoItensModel.objeto.PRODUTO) +
                '   and item = ' + QuotedStr(pDevolucaoItensModel.objeto.ITEM));

   Result := pDevolucaoItensModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TDevolucaoItensDao.getNewIface(pIConexao: IConexao): ITDevolucaoItensDao;
begin
  Result := TImplObjetoOwner<TDevolucaoItensDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDevolucaoItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and id = '+QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TDevolucaoItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from devolucaoitens where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TDevolucaoItensDao.proximoItem(pDevolucao: String): String;
begin
  Result := vIConexao.getConnection.ExecSQLScalar('select first 1 lpad (cast(i.item as integer) + 1, 3, ''0'') item from devolucaoitens i where i.id = '+QuotedStr(pDevolucao)+' order by i.item desc');
end;

function TDevolucaoItensDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '   select '+lPaginacao               +SLineBreak+
              '          id,                       '+SLineBreak+
              '          produto,                  '+SLineBreak+
              '          valor_unitario,           '+SLineBreak+
              '          quantidade,               '+SLineBreak+
              '          loja,                     '+SLineBreak+
              '          custo,                    '+SLineBreak+
              '          comissao_dev,             '+SLineBreak+
              '          pedido_id,                '+SLineBreak+
              '          valor_st,                 '+SLineBreak+
              '          comissao_percentual,      '+SLineBreak+
              '          frete,                    '+SLineBreak+
              '          comanda,                  '+SLineBreak+
              '          altura_m,                 '+SLineBreak+
              '          largura_m,                '+SLineBreak+
              '          profundidade_m,           '+SLineBreak+
              '          item,                     '+SLineBreak+
              '          desconto_ped,             '+SLineBreak+
              '          valor_suframa,            '+SLineBreak+
              '          systime,                  '+SLineBreak+
              '          valor_ipi,                '+SLineBreak+
              '          valor_acrescimo,          '+SLineBreak+
              '          vfcpst                    '+SLineBreak+
              '     from devolucaoitens            '+SLineBreak+
              '    where 1=1                       '+SLineBreak;

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

procedure TDevolucaoItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDevolucaoItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDevolucaoItensDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TDevolucaoItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDevolucaoItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TDevolucaoItensDao.setParams(var pQry: TFDQuery; pDevolucaoItensModel: ITDevolucaoItensModel);
begin
  vConstrutor.setParams('DEVOLUCAOITENS',pQry,pDevolucaoItensModel.objeto);
end;

procedure TDevolucaoItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TDevolucaoItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TDevolucaoItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
