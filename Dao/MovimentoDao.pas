unit MovimentoDao;

interface

uses
  MovimentoModel,
  Terasoft.ConstrutorDao,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ObjectIface,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TMovimentoDao = class;
  ITMovimentoDao=IObject<TMovimentoDao>;
  TMovimentoDao = class
  private
    [weak] mySelf: ITMovimentoDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FMovimentosLista: IList<ITMovimentoModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDProduto: String;
    FDataFinalView: Variant;
    FDataInicialView: Variant;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetMovimentosLista(const Value: IList<ITMovimentoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetIDProduto(const Value: String);
    procedure SetDataFinalView(const Value: Variant);
    procedure SetDataInicialView(const Value: Variant);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITMovimentoDao;

    property MovimentosLista: IList<ITMovimentoModel> read FMovimentosLista write SetMovimentosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property IDProduto : String read FIDProduto write SetIDProduto;
    property DataInicialView : Variant read FDataInicialView write SetDataInicialView;
    property DataFinalView : Variant read FDataFinalView write SetDataFinalView;

    function incluir(pMovimentoModel: ITMovimentoModel): String;
    function alterar(pMovimentoModel: ITMovimentoModel): String;
    function excluir(pMovimentoModel: ITMovimentoModel): String;

    procedure obterLista;
    function obterListaMemTable : IFDDataset;
    function carregaClasse(pId: String): ITMovimentoModel;
    procedure setParams(var pQry: TFDQuery; pMovimentoModel: ITMovimentoModel);

end;

implementation

uses
  System.Rtti;

{ TMovimento }

function TMovimentoDao.carregaClasse(pId: String): ITMovimentoModel;
var
  lQry: TFDQuery;
  lModel: ITMovimentoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TMovimentoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open(' select * from movimento where id = '+ pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.DOCUMENTO_MOV  := lQry.FieldByName('DOCUMENTO_MOV').AsString;
    lModel.objeto.CODIGO_PRO     := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.objeto.CODIGO_FOR     := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.objeto.OBS_MOV        := lQry.FieldByName('OBS_MOV').AsString;
    lModel.objeto.TIPO_DOC       := lQry.FieldByName('TIPO_DOC').AsString;
    lModel.objeto.DATA_MOV       := lQry.FieldByName('DATA_MOV').AsString;
    lModel.objeto.DATA_DOC       := lQry.FieldByName('DATA_DOC').AsString;
    lModel.objeto.QUANTIDADE_MOV := lQry.FieldByName('QUANTIDADE_MOV').AsString;
    lModel.objeto.VALOR_MOV      := lQry.FieldByName('VALOR_MOV').AsString;
    lModel.objeto.CUSTO_ATUAL    := lQry.FieldByName('CUSTO_ATUAL').AsString;
    lModel.objeto.VENDA_ATUAL    := lQry.FieldByName('VENDA_ATUAL').AsString;
    lModel.objeto.STATUS         := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.LOJA           := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.ID             := lQry.FieldByName('ID').AsString;
    lModel.objeto.USUARIO_ID     := lQry.FieldByName('USUARIO_ID').AsString;
    lModel.objeto.DATAHORA       := lQry.FieldByName('DATAHORA').AsString;
    lModel.objeto.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.TABELA_ORIGEM  := lQry.FieldByName('TABELA_ORIGEM').AsString;
    lModel.objeto.ID_ORIGEM      := lQry.FieldByName('ID_ORIGEM').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TMovimentoDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TMovimentoDao.Destroy;
begin
  FMovimentosLista:=nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TMovimentoDao.incluir(pMovimentoModel: ITMovimentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('MOVIMENTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMovimentoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMovimentoDao.alterar(pMovimentoModel: ITMovimentoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=   vConstrutor.gerarUpdate('MOVIMENTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMovimentoModel);
    lQry.ExecSQL;

    Result := pMovimentoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMovimentoDao.excluir(pMovimentoModel: ITMovimentoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from MOVIMENTO where ID = :ID',[pMovimentoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pMovimentoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TMovimentoDao.getNewIface(pIConexao: IConexao): ITMovimentoDao;
begin
  Result := TImplObjetoOwner<TMovimentoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TMovimentoDao.where: String;
var
  lSql : String;
begin

  if (FDataInicialView <> '') and (FDataFinalView <> '') then
    lSql := ' and data_mov between ''' + transformaDataFireBirdWhere(FDataInicialView) + ''' and ''' + transformaDataFireBirdWhere(FDataFinalView) + ''' ';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  if FIDProduto <> '' then
    lSql :=  lSql + ' and CODIGO_PRO = ' +QuotedStr(FIDProduto);

  Result := lSQL;
end;

procedure TMovimentoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from MOVIMENTO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TMovimentoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITMovimentoModel;
begin
  lQry := vIConexao.CriarQuery;

  FMovimentosLista := TCollections.CreateList<ITMovimentoModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       movimento.*         '+
	    '  from movimento           '+
      ' where 1=1                 ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TMovimentoModel.getNewIface(vIConexao);
      FMovimentosLista.Add(modelo);

      modelo.objeto.DOCUMENTO_MOV   := lQry.FieldByName('DOCUMENTO_MOV').AsString;
      modelo.objeto.CODIGO_PRO      := lQry.FieldByName('CODIGO_PRO').AsString;
      modelo.objeto.CODIGO_FOR      := lQry.FieldByName('CODIGO_FOR').AsString;
      modelo.objeto.OBS_MOV         := lQry.FieldByName('OBS_MOV').AsString;
      modelo.objeto.TIPO_DOC        := lQry.FieldByName('TIPO_DOC').AsString;
      modelo.objeto.DATA_MOV        := lQry.FieldByName('DATA_MOV').AsString;
      modelo.objeto.DATA_DOC        := lQry.FieldByName('DATA_DOC').AsString;
      modelo.objeto.QUANTIDADE_MOV  := lQry.FieldByName('QUANTIDADE_MOV').AsString;
      modelo.objeto.VALOR_MOV       := lQry.FieldByName('VALOR_MOV').AsString;
      modelo.objeto.CUSTO_ATUAL     := lQry.FieldByName('CUSTO_ATUAL').AsString;
      modelo.objeto.VENDA_ATUAL     := lQry.FieldByName('VENDA_ATUAL').AsString;
      modelo.objeto.STATUS          := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.LOJA            := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.ID              := lQry.FieldByName('ID').AsString;
      modelo.objeto.USUARIO_ID      := lQry.FieldByName('USUARIO_ID').AsString;
      modelo.objeto.DATAHORA        := lQry.FieldByName('DATAHORA').AsString;
      modelo.objeto.SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.TABELA_ORIGEM   := lQry.FieldByName('TABELA_ORIGEM').AsString;
      modelo.objeto.ID_ORIGEM       := lQry.FieldByName('ID_ORIGEM').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

function TMovimentoDao.obterListaMemTable: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSql := 'select '+lPaginacao+'                '+SLineBreak+
              '        movimento.data_doc,          '+SLineBreak+
              '        movimento.data_mov,          '+SLineBreak+
              '        movimento.obs_mov,           '+SLineBreak+
              '        movimento.tipo_doc,          '+SLineBreak+
              '        movimento.quantidade_mov,    '+SLineBreak+
              '        movimento.valor_mov,         '+SLineBreak+
              '        movimento.status,            '+SLineBreak+
              '        movimento.documento_mov      '+SLineBreak+
              '   from movimento                    '+SLineBreak+
              '  where 1=1                          '+SLineBreak;

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

procedure TMovimentoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMovimentoDao.SetDataFinalView(const Value: Variant);
begin
  FDataFinalView := Value;
end;

procedure TMovimentoDao.SetDataInicialView(const Value: Variant);
begin
  FDataInicialView := Value;
end;

procedure TMovimentoDao.SetMovimentosLista;
begin
  FMovimentosLista := Value;
end;

procedure TMovimentoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMovimentoDao.SetIDProduto(const Value: String);
begin
  FIDProduto := Value;
end;

procedure TMovimentoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TMovimentoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMovimentoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TMovimentoDao.setParams(var pQry: TFDQuery; pMovimentoModel: ITMovimentoModel);
begin
  vConstrutor.setParams('MOVIMENTO',pQry,pMovimentoModel.objeto);
end;

procedure TMovimentoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TMovimentoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TMovimentoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
