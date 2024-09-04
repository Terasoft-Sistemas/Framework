unit DevolucaoDao;

interface

uses
  DevolucaoModel,
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
  TDevolucaoDao = class;
  ITDevolucaoDao=IObject<TDevolucaoDao>;
  TDevolucaoDao = class
  private
    [weak] mySelf: ITDevolucaoDao;
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

    class function getNewIface(pIConexao: IConexao): ITDevolucaoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pDevolucaoModel: ITDevolucaoModel): String;
    function alterar(pDevolucaoModel: ITDevolucaoModel): String;
    function excluir(pDevolucaoModel: ITDevolucaoModel): String;

    function carregaClasse(pID : String): ITDevolucaoModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pDevolucaoModel: ITDevolucaoModel);

end;

implementation

uses
  System.Rtti;

{ TDevolucao }

function TDevolucaoDao.carregaClasse(pID : String): ITDevolucaoModel;
var
  lQry: TFDQuery;
  lModel: ITDevolucaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TDevolucaoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from devolucao where id = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;
    lModel.objeto.PEDIDO           := lQry.FieldByName('PEDIDO').AsString;
    lModel.objeto.CLIENTE          := lQry.FieldByName('CLIENTE').AsString;
    lModel.objeto.DATA             := lQry.FieldByName('DATA').AsString;
    lModel.objeto.VALOR_TOTAL      := lQry.FieldByName('VALOR_TOTAL').AsString;
    lModel.objeto.USUARIO          := lQry.FieldByName('USUARIO').AsString;
    lModel.objeto.OBS              := lQry.FieldByName('OBS').AsString;
    lModel.objeto.LOJA             := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.VALE             := lQry.FieldByName('VALE').AsString;
    lModel.objeto.DATA_USO_VALE    := lQry.FieldByName('DATA_USO_VALE').AsString;
    lModel.objeto.USO_VALE         := lQry.FieldByName('USO_VALE').AsString;
    lModel.objeto.NF_ENTRADA       := lQry.FieldByName('NF_ENTRADA').AsString;
    lModel.objeto.DESCONTO         := lQry.FieldByName('DESCONTO').AsString;
    lModel.objeto.VENDEDOR         := lQry.FieldByName('VENDEDOR').AsString;
    lModel.objeto.CODIGO_TIP       := lQry.FieldByName('CODIGO_TIP').AsString;
    lModel.objeto.HORA             := lQry.FieldByName('HORA').AsString;
    lModel.objeto.VALOR_IPI        := lQry.FieldByName('VALOR_IPI').AsString;
    lModel.objeto.VALOR_ST         := lQry.FieldByName('VALOR_ST').AsString;
    lModel.objeto.FRETE            := lQry.FieldByName('FRETE').AsString;
    lModel.objeto.VALOR_SUFRAMA    := lQry.FieldByName('VALOR_SUFRAMA').AsString;
    lModel.objeto.STATUS_ID        := lQry.FieldByName('STATUS_ID').AsString;
    lModel.objeto.PORTADOR_ID      := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.VALOR_ACRESCIMO  := lQry.FieldByName('VALOR_ACRESCIMO').AsString;
    lModel.objeto.VFCPST           := lQry.FieldByName('VFCPST').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TDevolucaoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TDevolucaoDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TDevolucaoDao.incluir(pDevolucaoModel: ITDevolucaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('DEVOLUCAO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pDevolucaoModel.objeto.ID := vIConexao.Generetor('GEN_DEVOLUCAO');
    setParams(lQry, pDevolucaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDevolucaoDao.alterar(pDevolucaoModel: ITDevolucaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('DEVOLUCAO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pDevolucaoModel);
    lQry.ExecSQL;

    Result := pDevolucaoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDevolucaoDao.excluir(pDevolucaoModel: ITDevolucaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from devolucao where id = :id' ,[pDevolucaoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pDevolucaoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TDevolucaoDao.getNewIface(pIConexao: IConexao): ITDevolucaoDao;
begin
  Result := TImplObjetoOwner<TDevolucaoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDevolucaoDao.where: String;
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

procedure TDevolucaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from devolucao where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TDevolucaoDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao                +SLineBreak+
              '         id,                        '+SLineBreak+
              '         pedido,                    '+SLineBreak+
              '         cliente,                   '+SLineBreak+
              '         data,                      '+SLineBreak+
              '         valor_total,               '+SLineBreak+
              '         usuario,                   '+SLineBreak+
              '         obs,                       '+SLineBreak+
              '         loja,                      '+SLineBreak+
              '         vale,                      '+SLineBreak+
              '         data_uso_vale,             '+SLineBreak+
              '         uso_vale,                  '+SLineBreak+
              '         nf_entrada,                '+SLineBreak+
              '         desconto,                  '+SLineBreak+
              '         vendedor,                  '+SLineBreak+
              '         codigo_tip,                '+SLineBreak+
              '         hora,                      '+SLineBreak+
              '         valor_ipi,                 '+SLineBreak+
              '         valor_st,                  '+SLineBreak+
              '         frete,                     '+SLineBreak+
              '         valor_suframa,             '+SLineBreak+
              '         status_id,                 '+SLineBreak+
              '         portador_id                '+SLineBreak+
              '    from devolucao                  '+SLineBreak+
              '   where 1=1                        '+SLineBreak;

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

procedure TDevolucaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDevolucaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDevolucaoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TDevolucaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDevolucaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TDevolucaoDao.setParams(var pQry: TFDQuery; pDevolucaoModel: ITDevolucaoModel);
begin
  vConstrutor.setParams('DEVOLUCAO',pQry,pDevolucaoModel.objeto);
end;

procedure TDevolucaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TDevolucaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TDevolucaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
