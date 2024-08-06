unit DescontoDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  DescontoModel;

type
  TDescontoDao = class;
  ITDescontoDao=IObject<TDescontoDao>;

  TDescontoDao = class
  private
    [weak] mySelf: ITDescontoDao;
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
    FIDUsuarioView: String;
    FIDTipoVendaView: String;
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
    procedure SetIDTipoVendaView(const Value: String);
    procedure SetIDUsuarioView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDescontoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;
    property IDUsuarioView : String read FIDUsuarioView write SetIDUsuarioView;
    property IDTipoVendaView : String read FIDTipoVendaView write SetIDTipoVendaView;

    function incluir(pDescontoModel: ITDescontoModel): String;
    function alterar(pDescontoModel: ITDescontoModel): String;
    function excluir(pDescontoModel: ITDescontoModel): String;

    function carregaClasse(pID : String): ITDescontoModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pDescontoModel: ITDescontoModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TDesconto }

function TDescontoDao.alterar(pDescontoModel: ITDescontoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('DESCONTO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pDescontoModel);
    lQry.ExecSQL;

    Result := pDescontoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDescontoDao.carregaClasse(pID: String): ITDescontoModel;
var
  lQry: TFDQuery;
  lModel: ITDescontoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TDescontoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from DESCONTO where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

      lModel.objeto.ID             := lQry.FieldByName('ID').AsString;
      lModel.objeto.USUARIO_DES    := lQry.FieldByName('USUARIO_DES').AsString;
      lModel.objeto.TIPOVENDA_DES  := lQry.FieldByName('TIPOVENDA_DES').AsString;
      lModel.objeto.VALOR_DES      := lQry.FieldByName('VALOR_DES').AsString;
      lModel.objeto.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TDescontoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TDescontoDao.Destroy;
begin
  inherited;
end;

function TDescontoDao.excluir(pDescontoModel: ITDescontoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from DESCONTO where ID = :ID' ,[pDescontoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pDescontoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TDescontoDao.getNewIface(pIConexao: IConexao): ITDescontoDao;
begin
  Result := TImplObjetoOwner<TDescontoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDescontoDao.incluir(pDescontoModel: ITDescontoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('DESCONTO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    pDescontoModel.objeto.ID := vIConexao.Generetor('GEN_DESCONTO_ID');
    setParams(lQry, pDescontoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TDescontoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                    '+SLineBreak+
              '         DESCONTO.ID,                                                     '+SLineBreak+
              '         DESCONTO.TIPOVENDA_DES,                                          '+SLineBreak+
              '         DESCONTO.USUARIO_DES,                                            '+SLineBreak+
              '         DESCONTO.VALOR_DES                                               '+SLineBreak+
              '    from DESCONTO                                                         '+SLineBreak+
              '   where 1=1                                                              '+SLineBreak;

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

procedure TDescontoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From DESCONTO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TDescontoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TDescontoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TDescontoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TDescontoDao.SetIDTipoVendaView(const Value: String);
begin
  FIDTipoVendaView := Value;
end;

procedure TDescontoDao.SetIDUsuarioView(const Value: String);
begin
  FIDUsuarioView := Value;
end;

procedure TDescontoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TDescontoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TDescontoDao.setParams(var pQry: TFDQuery; pDescontoModel: ITDescontoModel);
begin
  vConstrutor.setParams('DESCONTO',pQry,pDescontoModel.objeto);
end;

procedure TDescontoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TDescontoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TDescontoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TDescontoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and ID = ' + QuotedStr(FIDRecordView);

  if FIDTipoVendaView <> ''  then
    lSQL := lSQL + ' and TIPOVENDA_DES = ' + QuotedStr(FIDTipoVendaView);

  if FIDUsuarioView <> ''  then
    lSQL := lSQL + ' and USUARIO_DES = ' + QuotedStr(FIDUsuarioView);

  Result := lSQL;
end;

end.
